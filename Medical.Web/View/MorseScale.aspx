<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.MorseScale" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/themes/flat-blue.css">
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

        .btn.btn-primary {
            background-color: #166be2 !important;
            border-color: #166be2 !important;
        }

        .badge-primary {
            color: white !important;
            background-color: #007DDB !important;
        }

        .select2-dropdown {
            z-index: 99999999 !important;
        }
    </style>
    <script>
        var paintId;
        $(function () {
            paintId = comFn.getQueryString("id");
            $(".username").text(getCookie("Home_UserName"));
            var state = getCookie("state");
            if (state == "2") {
                $("#baseLi").hide();
                $("#updatePwd").hide();
            }

            if (paintId == null) {
                var html = $("#patin").val();
                layer.open({
                    content: html,
                    shadeClose: false,
                    btn: ['确定'],
                    anim: 'up',
                    yes: function (index) {
                        paintId = $("#patiens option:selected").val();
                        layer.close(index);
                    },
                    success: function (elem) {
                        $('#patiens').select2({
                            placeholder: '--请选择--', //提示
                            allowClear: false, //不允许清空
                            multiple: false,
                            ajax: {
                                url: 'BaseManageHandler.ashx?tag=GetPatiens',
                                dataType: 'json',
                                data: function (params) {

                                },
                                delay: 500,
                                processResults: function (data, params) {
                                    var list = [];
                                    for (var i = 0; i < data.length; i++) {
                                        list.push({ id: data[i].ID, text: data[i]["姓名"] });
                                    }
                                    return {
                                        results: list  //必须赋值给results并且必须返回一个obj
                                    };
                                },
                                cache: true,　　　　　　　　　　//开启缓存
                            }
                        });
                    }
                });
            }

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

        function Save() {
            var url = "BaseManageHandler.ashx?tag=EditAssess";

            var score = 0;
            $.each($("input[type=radio]:checked"), function () {
                score += parseInt($(this).val());
            });
            var rank, tips = '';
            if (score >= 0 && score <= 24) {
                rank = 1;
                tips = '该病人当前处于 无风险 状态';
            } else if (score >= 25 && score <= 44) {
                rank = 2;
                tips = '该病人当前处于 低风险 状态，请每周评估一次';
            } else if (score >= 45) {
                rank = 4;
                tips = '该病人当前处于 高风险 状态，请每日评估一次';
            }

            var data = {};
            data.patId = paintId;
            data.assItem = "Morse跌倒评估";
            data.assType = 3;
            data.score = score;
            data.rank = rank;

            comFn.Ajax(url, data, function (sdata) {
                if (sdata == "1") {
                    layer.open({
                        content: tips,
                        btn: ['确定'],
                        yes: function (index) {
                            layer.close(index);
                        }
                    });
                }
                else {
                    layer.open({
                        content: '评估失败',
                        skin: 'msg',
                        time: 2
                    });
                }
            }, function () {

            }, false);
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="side-body">
            <div class="row">
                <div class="col-xs-12">
                    <div class="card">
                        <textarea id="patin" style="display: none;">
                             <form id="form" class="form-inline" style="max-height: 350px;overflow:scroll;overflow-x:hidden;">
                                <div class="form-group text-show">
                                    <label for="sex">请选择评估的病人</label>
                                    <select id="patiens" style="width:180px">
                                        
                                    </select>
                                </div>
                                </form>
                        </textarea>
                        <div class="card-header">
                            <div class="card-title">
                                <div class="title" style="color: white; float: left">Morse跌倒风险评估量表</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <%--<div class="summary-inline">
                                <span class="text-info">住院号:02120180124</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="text-info">姓名:杨丽莎</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="text-info">性别:女</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="text-info">年龄:32</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="text-info">科室:妇产科</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="text-info">床号:23号床</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </div>--%>
                            <div class="sub-title">近三个月有无跌倒</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio0" name="radio1" value="0">
                                    <label for="radio0">
                                        无
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio1" name="radio1" value="25">
                                    <label for="radio1">
                                        有
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">多于一个疾病诊断</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-0" name="radio2" value="0">
                                    <label for="radio-0">
                                        无
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-1" name="radio2" value="15">
                                    <label for="radio-1">
                                        有
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">使用行走辅助工具</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-no-0" name="radio3" value="0">
                                    <label for="radio-no-0">
                                        不需要，卧床休息，护士辅助
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-yes-1" name="radio3" value="15">
                                    <label for="radio-yes-1">
                                        拐杖、助行器、手杖
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-yes-2" name="radio3" value="30">
                                    <label for="radio-yes-2">
                                        依扶家具行走
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">是否需要静脉输液</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-no" name="radio4" value="0">
                                    <label for="radio-no">
                                        否
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-yes" name="radio4" value="20">
                                    <label for="radio-yes">
                                        是
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">步态</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-b-1" name="radio5" value="0">
                                    <label for="radio-b-1">
                                        正常、卧床不能够移动
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-b-2" name="radio5" value="10">
                                    <label for="radio-b-2">
                                        虚弱无力
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-b-3" name="radio5" value="20">
                                    <label for="radio-b-3">
                                        功能障碍
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">认知状态</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-z-1" name="radio6" value="0">
                                    <label for="radio-z-1">
                                        量力而行
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio-z-2" name="radio6" value="15">
                                    <label for="radio-z-2">
                                        高估自己能力、忘记自己受限制
                                    </label>
                                </div>
                            </div>
                            <div style="padding: 10px;">
                                <button type="button" onclick="Save()" class="btn btn-primary btn-lg btn-block">提交</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
