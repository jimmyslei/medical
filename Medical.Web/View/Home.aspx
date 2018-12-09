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
            var state = comFn.getQueryString("state");
            $(".username").text(getCookie("Home_UserName"));

            setCookie("state", state, 30);
            if (state == "2") {
                $("#baseLi").hide();
                $("#updatePwd").hide();
            }

            var myChart = echarts.init(document.getElementById('chart'));
            option = {
                //title: {
                //    text: '折线图堆叠'
                //},
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ['邮件营销'],
                    align: 'left',
                    left: 30
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                //toolbox: {
                //    feature: {
                //        saveAsImage: {}
                //    }
                //},
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                        name: '邮件营销',
                        type: 'line',
                        stack: '总量',
                        data: [120, 132, 101, 134, 90, 230, 210]
                    }
                ]
            };
            myChart.setOption(option);

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


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="side-body padding-top">
            <div class="row">
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
            <div class="row  no-margin-bottom">
                <%-- <div class="col-sm-6 col-xs-12">
                      <div class="row">
                        <div class="col-xs-12">
                            <div class="card primary">
                                <div class="card-jumbotron no-padding">
                                    <canvas id="jumbotron-line-chart" class="chart no-padding"></canvas>
                                </div>
                                <div class="card-body half-padding">
                                    <h4 class="float-left no-margin font-weight-300">Profits</h4>
                                    <h2 class="float-right no-margin font-weight-300">$3200</h2>
                                    <div class="clear-both"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                  <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <div class="thumbnail no-margin-bottom">
                                <img src="../img/thumbnails/picjumbo.com_IMG_4566.jpg" class="img-responsive">
                                <div class="caption">
                                    <h3 id="thumbnail-label">Thumbnail label<a class="anchorjs-link" href="#thumbnail-label"><span class="anchorjs-icon"></span></a></h3>
                                    <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                                    <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="thumbnail no-margin-bottom">
                                <img src="../img/thumbnails/picjumbo.com_IMG_3241.jpg" class="img-responsive">
                                <div class="caption">
                                    <h3 id="thumbnail-label">Thumbnail label<a class="anchorjs-link" href="#thumbnail-label"><span class="anchorjs-icon"></span></a></h3>
                                    <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                                    <p><a href="#" class="btn btn-success" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                 </div>--%>
                <div class="col-sm-6 col-xs-12">
                    <%--  <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <div class="card primary">
                                <div class="card-jumbotron no-padding">
                                    <canvas id="jumbotron-bar-chart" class="chart no-padding"></canvas>
                                </div>
                                <div class="card-body half-padding">
                                    <h4 class="float-left no-margin font-weight-300">Orders</h4>
                                    <div class="clear-both"></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="card primary">
                                <div class="card-jumbotron no-padding">
                                    <canvas id="jumbotron-line-2-chart" class="chart no-padding"></canvas>
                                </div>
                                <div class="card-body half-padding">
                                    <h4 class="float-left no-margin font-weight-300">Pages view</h4>
                                    <div class="clear-both"></div>
                                </div>
                            </div>
                        </div>
                    </div>--%>
                    <div class="card card-success">
                        <div class="card-header">
                            <div class="card-title">
                                <div class="title"><i class="fa fa-area-chart"></i>图表</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                        <div class="card-body no-padding" id="chart" style="height: 250px">
                            <%-- <ul class="message-list">
                                <a href="#">
                                    <li>
                                        <img src="../img/profile/profile-1.jpg" class="profile-img pull-left">
                                        <div class="message-block">
                                            <div>
                                                <span class="username">Tui2Tone</span> <span class="message-datetime">12 min ago</span>
                                            </div>
                                            <div class="message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.</div>
                                        </div>
                                    </li>
                                </a>
                                <a href="#">
                                    <li>
                                        <img src="../img/profile/profile-1.jpg" class="profile-img pull-left">
                                        <div class="message-block">
                                            <div>
                                                <span class="username">Tui2Tone</span> <span class="message-datetime">15 min ago</span>
                                            </div>
                                            <div class="message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.</div>
                                        </div>
                                    </li>
                                </a>
                                <a href="#">
                                    <li>
                                        <img src="../img/profile/profile-1.jpg" class="profile-img pull-left">
                                        <div class="message-block">
                                            <div>
                                                <span class="username">Tui2Tone</span> <span class="message-datetime">2 hour ago</span>
                                            </div>
                                            <div class="message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.</div>
                                        </div>
                                    </li>
                                </a>
                                <a href="#">
                                    <li>
                                        <img src="../img/profile/profile-1.jpg" class="profile-img pull-left">
                                        <div class="message-block">
                                            <div>
                                                <span class="username">Tui2Tone</span> <span class="message-datetime">1 day ago</span>
                                            </div>
                                            <div class="message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.</div>
                                        </div>
                                    </li>
                                </a>
                            </ul>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
