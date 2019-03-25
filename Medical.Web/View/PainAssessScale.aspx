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
            if (getCookie("Home_UserName") == null) {
                window.location.href = "../Login";
            }
            paintId = comFn.getQueryString("id");
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
            var myAuto = document.getElementById('myaudio');
            myAuto.pause(); //暂停
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
            var myAuto = document.getElementById('myaudio');
            var score = 0;
            $.each($('input:checkbox:checked'), function () {
                score = $(this).val();
            });
            score = parseInt(score);
            var rank, tips = '';
            if (score == 0) {
                rank = 1;
                tips = '该病人当前处于 无痛 状态';
            } else if (score >= 1 && score <= 3) {
                rank = 2;
                tips = '该病人当前处于 轻度疼痛 状态，请每日评估一次';
            } else if (score >= 4 && score <= 6) {
                rank = 3;
                tips = '该病人当前处于 中度疼痛 状态，请每4小时评估一次';
            } else if (score >= 7 && score <= 10) {
                rank = 4;
                tips = '该病人当前处于 重度疼痛 状态，请每2小时评估一次';
                myAuto.play();  //播放
            }

            var data = {};
            data.patId = paintId;
            data.assItem = "疼痛评估";
            data.assType = 1;
            data.score = score;
            data.rank = rank;
            
            comFn.Ajax(url, data, function (sdata) {
                if (sdata > "0") {
                    layer.open({
                        content: tips ,
                        btn: ['确定'],
                        yes: function (index) {
                            myAuto.pause(); //暂停
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
                <audio src="../music/tis.mp3" id="myaudio" controls="controls" loop="false" autoplay hidden="true"></audio> 
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
                                <div class="title" style="color: white; float: left">疼痛评估量表</div>
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
                            <div class="sub-title">你当前感觉到是否有身体不适，是否有疼痛感？</div>
                            <div>

                                <div class="checkbox3 checkbox-success <%--checkbox-inline--%> checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="0" cname="checkbox0" id="checkbox-fa-light-0">
                                    <label for="checkbox-fa-light-0">
                                        无痛
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" cname="checkbox1" id="checkbox-fa-light-1">
                                    <label for="checkbox-fa-light-1">
                                        安静平卧不痛，翻身、咳嗽时疼痛
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" cname="checkbox2" id="checkbox-fa-light-2">
                                    <label for="checkbox-fa-light-2">
                                        咳嗽时疼痛，深呼吸不痛
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" cname="checkbox3" id="checkbox-fa-light-3">
                                    <label for="checkbox-fa-light-3">
                                        安静平卧不痛，咳嗽、深呼吸痛
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="4" cname="checkbox4" id="checkbox-fa-light-4">
                                    <label for="checkbox-fa-light-4">
                                        安静平卧间歇疼痛，影响睡眠
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="5" cname="checkbox5" id="checkbox-fa-light-5">
                                    <label for="checkbox-fa-light-5">
                                        安静平卧持续疼痛
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="6" cname="checkbox6" id="checkbox-fa-light-6">
                                    <label for="checkbox-fa-light-6">
                                        安静平卧疼痛较重
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="7" cname="checkbox7" id="checkbox-fa-light-7">
                                    <label for="checkbox-fa-light-7">
                                        疼痛较重，翻转不安，无法入眠
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="8" cname="checkbox8" id="checkbox-fa-light-8">
                                    <label for="checkbox-fa-light-8">
                                        持续疼痛难忍，全身大汗
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="9" cname="checkbox9" id="checkbox-fa-light-9">
                                    <label for="checkbox-fa-light-9">
                                        剧烈疼痛，无法忍受
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="10" cname="checkbox10" id="checkbox-fa-light-10">
                                    <label for="checkbox-fa-light-10">
                                        最疼痛，生不如死
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
