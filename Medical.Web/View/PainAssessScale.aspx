<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.PainAssessScale" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/themes/flat-blue.css">
    <link href="../js/layui/css/layui.css" rel="stylesheet" />
    <link href="../js/laymobile/layer.css" rel="stylesheet" />
    <script src="../js/jquery-2.1.1.min.js"></script>
    <script src="../js/Common.js"></script>
    <link href="../js/laymobile/layer.css" rel="stylesheet" />
    <script src="../js/laymobile/layer.js"></script>
    <style>
        .card-header {
            background-color: #4e9bef;
        }

        .btn-primary {
            margin-top: 20px;
        }

        .btn.btn-primary{
            background-color:#166be2 !important;
            border-color:#166be2 !important;
        }

        .badge-primary {
            color: white !important;
            background-color: #007DDB !important;
        }
    </style>
    <script>
        $(function () {
            $(".username").text(getCookie("Home_UserName"));
            var state = getCookie("state");
            if (state == "2") {
                $("#baseLi").hide();
            }

            $("#exitLogin").click(function () {
                delCookie("Home_UserName");
                window.location.href = "Login.html";
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

                    }
                });
            });
        })
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="side-body">
            <div class="row">
                <div class="col-xs-12">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                                <div class="title" style="color: white; float: left">疼痛评估量表</div>
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
                            <div class="sub-title">你当前感觉到是否有身体不适，是否有疼痛感？</div>
                            <div>
                                <%--<div class="checkbox3 checkbox-round">
                                    <input type="checkbox" id="checkbox-2">
                                    <label for="checkbox-2">
                                        Option one is this and that&mdash;be sure to include why it's great
                                         
                                    </label>
                                </div>--%>

                                <div class="checkbox3 checkbox-success <%--checkbox-inline--%> checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="0" id="checkbox-fa-light-0">
                                    <label for="checkbox-fa-light-0">
                                        无痛
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light-1">
                                    <label for="checkbox-fa-light-1">
                                        安静平卧不痛，翻身、咳嗽时疼痛
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light-2">
                                    <label for="checkbox-fa-light-2">
                                        咳嗽时疼痛，深呼吸不痛
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light-3">
                                    <label for="checkbox-fa-light-3">
                                        安静平卧不痛，咳嗽、深呼吸痛
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="4" id="checkbox-fa-light-4">
                                    <label for="checkbox-fa-light-4">
                                        安静平卧间歇疼痛，影响睡眠
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="5" id="checkbox-fa-light-5">
                                    <label for="checkbox-fa-light-5">
                                        安静平卧持续疼痛
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="6" id="checkbox-fa-light-6">
                                    <label for="checkbox-fa-light-6">
                                        安静平卧疼痛较重
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="7" id="checkbox-fa-light-7">
                                    <label for="checkbox-fa-light-7">
                                        疼痛较重，翻转不安，无法入眠
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="8" id="checkbox-fa-light-8">
                                    <label for="checkbox-fa-light-8">
                                        持续疼痛难忍，全身大汗
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="9" id="checkbox-fa-light-9">
                                    <label for="checkbox-fa-light-9">
                                        剧烈疼痛，无法忍受
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="10" id="checkbox-fa-light-10">
                                    <label for="checkbox-fa-light-10">
                                        最疼痛，生不如死
                                    </label>
                                </div>

                                <%--<div class="radio3">
                                    <input type="radio" id="radio1" name="radio1" value="option1">
                                    <label for="radio1">
                                        Option one is this and that&mdash;be sure to include why it's great
                                         
                                    </label>
                                </div>
                                <div class="radio3">
                                    <input type="radio" id="radio2" name="radio1" value="option2">
                                    <label for="radio2">
                                        Option two can be something else and selecting it will deselect option one
                                         
                                    </label>
                                </div>
                                <div>
                                    <div class="radio3 radio-check">
                                        <input type="radio" id="radio4" name="radio2" value="option1" checked="">
                                        <label for="radio4">
                                            Option 1
                                           
                                        </label>
                                    </div>
                                    <div class="radio3 radio-check radio-success">
                                        <input type="radio" id="radio5" name="radio2" value="option2">
                                        <label for="radio5">
                                            Option 2
                                           
                                        </label>
                                    </div>
                                    <div class="radio3 radio-check radio-warning">
                                        <input type="radio" id="radio6" name="radio2" value="option3">
                                        <label for="radio6">
                                            Option 3
                                           
                                        </label>
                                    </div>
                                </div>--%>
                            </div>
                            <div style="padding: 10px;">
                                <button type="button" onclick="" class="btn btn-primary btn-lg btn-block">提交</button>
                            </div>
                            <%--<div>
                                <input type="checkbox" class="toggle-checkbox" name="my-checkbox" checked>
                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
