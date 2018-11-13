<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.MorseScale" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/themes/flat-blue.css">
    <style>
        .card-header {
            background-color: #4e9bef;
        }

        .btn-primary {
            margin-top: 20px;
        }

        .btn.btn-primary {
            background-color: #166be2 !important;
            border-color: #166be2 !important;
        }

        .badge-primary {
            color: white !important;
            background-color: #007DDB !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="side-body">
            <div class="row">
                <div class="col-xs-12">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                                <div class="title" style="color: white; float: left">Morse跌倒风险评估量表</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="summary-inline">
                                <span class="text-info">住院号:02120180124</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="text-info">姓名:杨丽莎</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="text-info">性别:女</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="text-info">年龄:32</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="text-info">科室:妇产科</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="text-info">床号:23号床</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </div>
                            <div class="sub-title">近三个月有无跌倒</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio0" name="radio" value="0">
                                    <label for="radio0">
                                        无
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio1" name="radio" value="25">
                                    <label for="radio1">
                                        有
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">多于一个疾病诊断</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-0" name="radio" value="0">
                                    <label for="radio-0">
                                        无
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-1" name="radio" value="15">
                                    <label for="radio-1">
                                        有
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">使用行走辅助工具</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-no-0" name="radio" value="0">
                                    <label for="radio-no-0">
                                        不需要，卧床休息，护士辅助
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-yes-1" name="radio" value="15">
                                    <label for="radio-yes-1">
                                        拐杖、助行器、手杖
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-yes-2" name="radio" value="30">
                                    <label for="radio-yes-2">
                                        依扶家具行走
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">是否需要静脉输液</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-no" name="radio" value="0">
                                    <label for="radio-no">
                                        否
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-yes" name="radio" value="20">
                                    <label for="radio-yes">
                                        是
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">步态</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-b-1" name="radio" value="0">
                                    <label for="radio-b-1">
                                        正常、卧床不能够移动
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-b-2" name="radio" value="10">
                                    <label for="radio-b-2">
                                        虚弱无力
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-b-3" name="radio" value="20">
                                    <label for="radio-b-3">
                                        功能障碍
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">认知状态</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-z-1" name="radio" value="0">
                                    <label for="radio-z-1">
                                        量力而行
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-z-2" name="radio" value="15">
                                    <label for="radio-z-2">
                                        高估自己能力、忘记自己受限制
                                    </label>
                                </div>
                            </div>
                            <div style="padding: 10px;">
                                <button type="button" onclick="" class="btn btn-primary btn-lg btn-block">提交</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
