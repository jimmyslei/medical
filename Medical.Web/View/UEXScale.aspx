<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.UEXScale" %>
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
        });

        function Save() {
            var url = "BaseManageHandler.ashx?tag=EditAssess";

            var score = 0;
            $.each($('input:checkbox:checked'), function () {
                score += parseInt($(this).val());
            });

            var rank, tips = '';
            if (score >= 1 && score <= 3) {
                rank = 2;
                tips = '该病人当前处于 低风险 状态，请每周评估一次';
            } else if (score >= 4 && score <= 6) {
                rank = 3;
                tips = '该病人当前处于 中风险 状态，请每周评估两次';
            } else if (score >= 7) {
                rank = 4;
                tips = '该病人当前处于 高风险 状态，请每24小时评估一次';
            }

            var data = {};
            data.patId = paintId;
            data.assItem = "非计划性拔管评估";
            data.assType = 5;
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
                                <div class="title" style="color: white; float: left">非计划性拔管风险评估表</div>
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
                            <div class="sub-title">年龄</div>
                            <div>
                                <div class="checkbox3 checkbox-success <%--checkbox-inline--%> checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light-age">
                                    <label for="checkbox-fa-light-age">
                                        ① ≥ 70岁 ② ＜ 5岁
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">非高危导管(Ⅱ类导管)</div>
                            <div>
                                <div class="checkbox3 checkbox-success <%--checkbox-inline--%> checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light-0">
                                    <label for="checkbox-fa-light-0">
                                        尿管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light-1">
                                    <label for="checkbox-fa-light-1">
                                        胃管/十二指肠营养管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light-2">
                                    <label for="checkbox-fa-light-2">
                                        盆/腹腔引流管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light-3">
                                    <label for="checkbox-fa-light-3">
                                        肠胃减压管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light-4">
                                    <label for="checkbox-fa-light-4">
                                        造瘘管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light-5">
                                    <label for="checkbox-fa-light-5">
                                        PICC
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light-6">
                                    <label for="checkbox-fa-light-6">
                                        身静脉置管
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">高危导管(Ⅰ类导管)</div>
                            <div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light0-3">
                                    <label for="checkbox-fa-light0-3">
                                        气管插管/切开
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light1-3">
                                    <label for="checkbox-fa-light1-3">
                                        脑室引流管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light2-3">
                                    <label for="checkbox-fa-light2-3">
                                        心包引流管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light3-3">
                                    <label for="checkbox-fa-light3-3">
                                        胸腔引流管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light4-3">
                                    <label for="checkbox-fa-light4-3">
                                        T管引流管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light5-3">
                                    <label for="checkbox-fa-light5-3">
                                        动静脉置管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="5" id="checkbox-fa-light6-3">
                                    <label for="checkbox-fa-light6-3">
                                        肾造瘘管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="5" id="checkbox-fa-light7-3">
                                    <label for="checkbox-fa-light7-3">
                                        腰大池引流管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="5" id="checkbox-fa-light8-3">
                                    <label for="checkbox-fa-light8-3">
                                        鼻肠管(食管胃手术及胃镜下植入)
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="5" id="checkbox-fa-light9-3">
                                    <label for="checkbox-fa-light9-3">
                                        尿管(前列腺、肾移植及尿道手术)
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">意识状态</div>
                            <div>
                                <div class="checkbox3 checkbox-success <%--checkbox-inline--%> checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="5" id="checkbox-fa-light0-2">
                                    <label for="checkbox-fa-light0-2">
                                        烦躁/嗜睡/瞻望/意识模糊/精神障碍
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">管路刀口</div>
                            <div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light0-1">
                                    <label for="checkbox-fa-light0-1">
                                        粘贴固定局部多汗、渗血或分泌物多
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
