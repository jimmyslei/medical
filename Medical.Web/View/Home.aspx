<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/themes/flat-blue.css">
    <script src="../js/jquery-2.1.1.min.js"></script>
    <script src="../js/Common.js"></script>
    <link href="../js/laymobile/layer.css" rel="stylesheet" />
    <script src="../js/laymobile/layer.js"></script>
    <script src="../js/echarts.min.js"></script>
    <script>

        $(function () {
            if (getCookie("Home_UserName") == null) {
                window.location.href = "../Login";
            }
            var state = getCookie("state");
            if (state == "1") {
                $(".username").text(getCookie("Home_UserName"));
            } else {
                $(".username").text(getCookie("user") + " " + getCookie("Home_UserName"));
            }


            if (state == "2") {
                $("#baseLi").hide();
                $("#updatePwd").hide();
            }

            comFn.Ajax("BaseManageHandler.ashx?tag=GetPatiens", null, function (sdata) {
                if (sdata.length > 0) {
                    for (var i = 0; i < sdata.length; i++) {
                        $("#pt").append("<option value='" + sdata[i]["ID"] + "'>" + sdata[i]["姓名"] + "</option>");
                    }
                }
            }, function () {

            }, false);

            $("#pt").change(function () {
                chartsShow();
            })

            chartsShow();

            $("#exitLogin").click(function () {
                delCookie("Home_UserName");
                window.location.href = "../Login";
            });

            $("#updatePwd").click(function () {
                var html = $("#update").val();
                layer.open({
                    content: html,
                    shadeClose: true,
                    btn: ['确定', '取消'],
                    anim: 'up',
                    yes: function (index) {
                        var url = "BaseManageHandler.ashx?tag=UpdatePwd";
                        var data = comFn.getFromVal();
                        data.userName = $("#userName").val();
                        if (data.pwdok != data.pwd) {
                            layer.open({
                                content: '确认密码与新密码不同',
                                skin: 'msg',
                                time: 2
                            });
                            return false;
                        }
                        if (save(url, data)) {
                            layer.open({
                                content: '修改成功',
                                skin: 'msg',
                                time: 2
                            });
                            layer.close(index);
                            queryFunc(pageIndex, pageSize);

                        } else {
                            layer.open({
                                content: '修改失败',
                                skin: 'msg',
                                time: 2
                            });
                        }
                    },
                    success: function (elem) {
                        $("#userName").val(getCookie("Home_UserName"));
                    }
                });
            });
        })

        function setChart(htmlId, lengedx, xData, yData) {
            var myChart = echarts.init(document.getElementById(htmlId));
            option = {
                //title: {
                //    text: '折线图堆叠'
                //},
                color: ['#3398DB'],
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: lengedx,
                    align: 'left',
                    left: 30
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    //axisLabel: {  
                    //    interval:0,  
                    //    rotate:-40  
                    //},
                    data: xData//['周一', '周二', '周三', '周四', '周五', '周六', '周日']
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        name: lengedx[0],//'邮件营销',
                        type: 'line',
                        stack: '总量',
                        data: yData//[120, 132, 101, 134, 90, 230, 210]
                    }
                ]
            };
            myChart.setOption(option, false);
        }

        function chartsShow() {
            $("#疼痛评估").hide();
            $("#Braden压疮风险评估").hide();
            $("#Morse跌倒评估").hide();
            $("#VTE评估").hide();
            $("#非计划性拔管评估").hide();
            var ptId = $("#pt option:selected").val();
            var data = { painId: ptId };
            comFn.Ajax("BaseManageHandler.ashx?tag=GetAssCountbyPainId", data, function (rdata) {
                for (var i = 0; i < rdata.length; i++) {
                    $("#" + rdata[i]["评估项目"] + "").show();
                }
            }, function () { }, false);
            chart();
        }

        function chart() {
            var ptId = $("#pt option:selected").val();
            var data = { painId: ptId };
            var x = new Array();
            var xdata = new Array();
            var ydata = new Array();
            var data1 = new Array(), data2 = new Array(), data3 = new Array(), data4 = new Array(), data5 = new Array();
            comFn.Ajax("BaseManageHandler.ashx?tag=GetCharts", data, function (sdata) {
                for (var i = 0; i < sdata.length; i++) {
                    if (sdata[i]["评估类别"] == "1") {
                        data1.push(sdata[i]);
                    } else if (sdata[i]["评估类别"] == "2") {
                        data2.push(sdata[i]);
                    } else if (sdata[i]["评估类别"] == "3") {
                        data3.push(sdata[i]);
                    } else if (sdata[i]["评估类别"] == "4") {
                        data4.push(sdata[i]);
                    } else if (sdata[i]["评估类别"] == "5") {
                        data5.push(sdata[i]);
                    }
                }
            }, function () { }, false);

            if (data1.length > 0) {
                x.push(data1[0]["评估项目"]);
                for (var i = 0; i < data1.length; i++) {
                    xdata.push(data1[i]["评估日期"]);
                    ydata.push(data1[i]["评估总分"])
                }
                setChart('chart', x, xdata, ydata);
                x = new Array(), xdata = new Array(), ydata = new Array();
            }
            if (data2.length > 0) {
                x.push(data2[0]["评估项目"]);
                for (var i = 0; i < data2.length; i++) {
                    xdata.push(data2[i]["评估日期"]);
                    ydata.push(data2[i]["评估总分"])
                }
                setChart('chart1', x, xdata, ydata);
                x = new Array(), xdata = new Array(), ydata = new Array();
            }
            if (data3.length > 0) {
                x.push(data3[0]["评估项目"]);
                for (var i = 0; i < data3.length; i++) {
                    xdata.push(data3[i]["评估日期"]);
                    ydata.push(data3[i]["评估总分"])
                }
                setChart('chart2', x, xdata, ydata);
                x = new Array(), xdata = new Array(), ydata = new Array();
            }
            if (data4.length > 0) {
                x.push(data4[0]["评估项目"]);
                for (var i = 0; i < data4.length; i++) {
                    xdata.push(data4[i]["评估日期"]);
                    ydata.push(data4[i]["评估总分"])
                }
                setChart('chart3', x, xdata, ydata);
                x = new Array(), xdata = new Array(), ydata = new Array();
            }
            if (data5.length > 0) {
                x.push(data5[0]["评估项目"]);
                for (var i = 0; i < data5.length; i++) {
                    xdata.push(data5[i]["评估日期"]);
                    ydata.push(data5[i]["评估总分"])
                }
                setChart('chart4', x, xdata, ydata);
                x = new Array(), xdata = new Array(), ydata = new Array();
            }
        }

        function save(url, data) {
            var result = false;
            comFn.Ajax(url, data, function (data) {
                if (data == "1") {
                    result = true;
                }
                else {
                    result = false;
                }
            }, function (data) {
                result = false;
            }, false);
            return result;
        }

    </script>
    <style>
        .flat-blue .card.card-success .card-header {
            background-color: #22A7F0 !important;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="navbar navbar-default navbar-fixed-top navbar-top" style="margin-top: 59px; z-index: 1000; background-color: white">
        <div class="container-fluid">
            <div class="form-group text-show" style="margin-top: 15px">
                <label for="org">科室</label>
                <select class="form-control text select2-selection" style="font-size: 0.9em; display: -webkit-inline-box !important; width: 180px !important; height: 30px !important" cname="org" id="org">
                    <option>外科</option>
                    <option>内科</option>
                </select>
                <label for="room">床位</label>
                <select class="form-control text select2-selection" style="font-size: 0.9em; display: -webkit-inline-box !important; width: 180px !important; height: 30px !important" cname="room" id="room">
                </select>
                <label for="pt">病人</label>
                <select class="form-control text select2-selection" style="font-size: 0.9em; display: -webkit-inline-box !important; width: 180px !important; height: 30px !important" cname="pt" id="pt">
                </select>
            </div>
        </div>
    </nav>
    <div class="container-fluid">
        <div class="side-body padding-top">
            <div class="row" style="margin-top: 45px; display: none">
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                    <a href="#">
                        <div class="card red summary-inline">
                            <div class="card-body">
                                <i class="icon fa fa-inbox fa-4x"></i>
                                <div class="content">
                                    <div class="title">50</div>
                                    <div class="sub-title">New Mails</div>
                                </div>
                                <div class="clear-both"></div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                    <a href="#">
                        <div class="card yellow summary-inline">
                            <div class="card-body">
                                <i class="icon fa fa-comments fa-4x"></i>
                                <div class="content">
                                    <div class="title">23</div>
                                    <div class="sub-title">New Message</div>
                                </div>
                                <div class="clear-both"></div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                    <a href="#">
                        <div class="card green summary-inline">
                            <div class="card-body">
                                <i class="icon fa fa-tags fa-4x"></i>
                                <div class="content">
                                    <div class="title">280</div>
                                    <div class="sub-title">Product View</div>
                                </div>
                                <div class="clear-both"></div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                    <a href="#">
                        <div class="card blue summary-inline">
                            <div class="card-body">
                                <i class="icon fa fa-share-alt fa-4x"></i>
                                <div class="content">
                                    <div class="title">16</div>
                                    <div class="sub-title">Share</div>
                                </div>
                                <div class="clear-both"></div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="row  no-margin-bottom" style="margin-top: 45px;">
                <div class="col-sm-6 col-xs-12" id="疼痛评估">
                    <div class="card card-success">
                        <div class="card-header">
                            <div class="card-title">
                                <div class="title"><i class="fa fa-area-chart"></i>疼痛评估统计</div>
                            </div>
                            <div class="card-title" style="float: right">
                                <a class="title" style="float: right">查看</a>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                        <div class="card-body no-padding" id="chart" style="height: 250px; margin-bottom: 10px">
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xs-12" id="Braden压疮风险评估">
                    <div class="card card-success">
                        <div class="card-header">
                            <div class="card-title">
                                <div class="title"><i class="fa fa-area-chart"></i>Braden压疮评估统计</div>
                            </div>
                            <div class="card-title" style="float: right">
                                <a class="title" style="float: right">查看</a>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                        <div class="card-body no-padding" id="chart1" style="height: 250px">
                        </div>
                    </div>
                </div>
            </div>
            <div class="row no-margin-bottom">
                <div class="col-sm-6 col-xs-12" id="Morse跌倒评估">
                    <div class="card card-success">
                        <div class="card-header">
                            <div class="card-title">
                                <div class="title"><i class="fa fa-area-chart"></i>Morse跌倒评估统计</div>
                            </div>
                            <div class="card-title" style="float: right">
                                <a class="title" style="float: right">查看</a>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                        <div class="card-body no-padding" id="chart2" style="height: 250px">
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xs-12" id="VTE评估">
                    <div class="card card-success">
                        <div class="card-header">
                            <div class="card-title">
                                <div class="title"><i class="fa fa-area-chart"></i>VTE评估统计</div>
                            </div>
                            <div class="card-title" style="float: right">
                                <a class="title" style="float: right">查看</a>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                        <div class="card-body no-padding" id="chart3" style="height: 250px">
                        </div>
                    </div>
                </div>
            </div>
            <div class="row no-margin-bottom">
                <div class="col-xs-12" id="非计划性拔管评估">
                    <div class="card card-success">
                        <div class="card-header">
                            <div class="card-title">
                                <div class="title"><i class="fa fa-area-chart"></i>非计划性拔管评估统计</div>
                            </div>
                            <div class="card-title" style="float: right">
                                <a class="title" style="float: right">查看</a>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                        <div class="card-body no-padding" id="chart4" style="height: 250px">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
