<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" CodeBehind="Count.aspx.cs" Inherits="Medical.Web.View.Count" %>
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
                       // $("#pt").append("<option value='" + sdata[i]["ID"] + "'>" + sdata[i]["姓名"] + "</option>");
                    }
                }
            }, function () {

            }, false);


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

            chart();
            chart1();
        })

        function chart() {
            var myChart = echarts.init(document.getElementById('chart2'));
            option = {
                title: {
                    text: '人次统计',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: ['VTE', 'Morse', 'Braden', '疼痛评估', '非计划风险评估']
                },
                series: [
                    {
                        name: '人次占比',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '60%'],
                        data: [
                            { value: 335, name: 'VTE' },
                            { value: 310, name: 'Morse' },
                            { value: 234, name: 'Braden' },
                            { value: 135, name: '疼痛评估' },
                            { value: 1548, name: '非计划风险评估' }
                        ],
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            myChart.setOption(option, false);
        }

        function chart1() {
            var myChart = echarts.init(document.getElementById('chart1'));
            option = {
                title: {
                    text: '风险人次统计'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        label: {
                            backgroundColor: '#6a7985'
                        }
                    }
                },
                legend: {
                    data: ['风险人次']
                },
                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: [
                    {
                        type: 'category',
                        boundaryGap: false,
                        data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: '风险人次',
                        type: 'line',
                        stack: '总量',
                        areaStyle: {},
                        data: [120, 132, 101, 134, 90, 125, 92,112,135,140,92,124,86]
                    }
                ]
            };
            myChart.setOption(option, false);
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
                <label for="room">风险类别</label>
                <select class="form-control text select2-selection" style="font-size: 0.9em; display: -webkit-inline-box !important; width: 180px !important; height: 30px !important" cname="room" id="room">
                </select>
                <label for="pt">风险等级</label>
                <select class="form-control text select2-selection" style="font-size: 0.9em; display: -webkit-inline-box !important; width: 180px !important; height: 30px !important" cname="pt" id="pt">
                </select>
                <label for="pt">时间</label>
                <select class="form-control text select2-selection" style="font-size: 0.9em; display: -webkit-inline-box !important; width: 180px !important; height: 30px !important" cname="time" id="time">
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
            
            <div class="row no-margin-bottom" style="margin-top: 45px;">
                <div class="col-xs-12" id="d1">
                    <div class="card card-success">
                        
                        <div class="card-body no-padding" id="chart1" style="height: 300px">
                        </div>
                    </div>
                </div>
            </div>
            <div class="row no-margin-bottom" >
                <div class="col-xs-12" id="d2">
                    <div class="card card-success">
                        
                        <div class="card-body no-padding" id="chart2" style="height: 300px">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
