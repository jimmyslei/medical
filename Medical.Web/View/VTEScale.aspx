<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.VTEScale" %>

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
            if (score >= 0 && score <= 1) {
                rank = 2;
                tips = '该病人当前处于 低危 状态，请每周评估一次';
            } else if (score == 2) {
                rank = 3;
                tips = '该病人当前处于 中危 状态，请每周评估两次';
            } else if (score >= 3 && score <= 4) {
                rank = 4;
                tips = '该病人当前处于 高危 状态，请每日评估一次';
                myAuto.play();  //播放
            } else if (score >= 5) {
                rank = 5;
                tips = '该病人当前处于 极高危 状态，请每日评估一次';
                myAuto.play();  //播放
            }

            var data = {};
            data.patId = paintId;
            data.assItem = "VTE评估";
            data.assType = 4;
            data.score = score;
            data.rank = rank;

            comFn.Ajax(url, data, function (sdata) {
                if (sdata > "0") {
                    layer.open({
                        content: tips,
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
                                <div class="title" style="color: white; float: left">VTE风险评估量表</div>
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
                            <div class="sub-title">5分项</div>
                            <div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="5" id="checkbox-fa-light-0">
                                    <label for="checkbox-fa-light-0">
                                        脑卒中(一个月内)
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="5" id="checkbox-fa-light-1">
                                    <label for="checkbox-fa-light-1">
                                        急性脊髓损伤(一个月内)
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="5" id="checkbox-fa-light-2">
                                    <label for="checkbox-fa-light-2">
                                        择期下肢关节置换手术
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="5" id="checkbox-fa-light-3">
                                    <label for="checkbox-fa-light-3">
                                        髋关节，骨盆或下肢骨折
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="5" id="checkbox-fa-light-4">
                                    <label for="checkbox-fa-light-4">
                                        多发性损伤(一个月内)
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">3分项</div>
                            <div>
                                <div class="checkbox3 checkbox-success <%--checkbox-inline--%> checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light0-3">
                                    <label for="checkbox-fa-light0-3">
                                        年龄≥75
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light1-3">
                                    <label for="checkbox-fa-light1-3">
                                        有VTE病史
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light2-3">
                                    <label for="checkbox-fa-light2-3">
                                        有VTE家族史
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light3-3">
                                    <label for="checkbox-fa-light3-3">
                                        肝素诱导的血小板减少症
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light4-3">
                                    <label for="checkbox-fa-light4-3">
                                        其他先天性或获得性血栓症
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light5-3">
                                    <label for="checkbox-fa-light5-3">
                                        抗心磷脂抗体阳性
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light6-3">
                                    <label for="checkbox-fa-light6-3">
                                        因子Vleiden阳性
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light7-3">
                                    <label for="checkbox-fa-light7-3">
                                        狼疮抗凝物阳性
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="3" id="checkbox-fa-light8-3">
                                    <label for="checkbox-fa-light8-3">
                                        血清同型半胱氨酸升高
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">2分项</div>
                            <div>
                                <div class="checkbox3 checkbox-success <%--checkbox-inline--%> checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light0-2">
                                    <label for="checkbox-fa-light0-2">
                                        年龄61-74
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light1-2">
                                    <label for="checkbox-fa-light1-2">
                                        石膏固定(一个月内)
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light2-2">
                                    <label for="checkbox-fa-light2-2">
                                        卧床或制动 > 72小时
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light3-2">
                                    <label for="checkbox-fa-light3-2">
                                        恶性肿瘤(既往或现患)
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light4-2">
                                    <label for="checkbox-fa-light4-2">
                                        中心静脉置管
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light5-2">
                                    <label for="checkbox-fa-light5-2">
                                        腹腔镜手术 > 45分钟
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light6-2">
                                    <label for="checkbox-fa-light6-2">
                                        大手术 > 45分钟
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="2" id="checkbox-fa-light7-2">
                                    <label for="checkbox-fa-light7-2">
                                        关节镜手术
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">1分项</div>
                            <div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light0-1">
                                    <label for="checkbox-fa-light0-1">
                                        年龄41-60
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light1-1">
                                    <label for="checkbox-fa-light1-1">
                                        计划小手术(<30分钟)
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light2-1">
                                    <label for="checkbox-fa-light2-1">
                                        肥肝( BMN > 25kg/m²)
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light3-1">
                                    <label for="checkbox-fa-light3-1">
                                        异常妊娠
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light4-1">
                                    <label for="checkbox-fa-light4-1">
                                        妊娠期或产后(1个月)
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light5-1">
                                    <label for="checkbox-fa-light5-1">
                                        口服避孕药或激素替代治疗
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light6-1">
                                    <label for="checkbox-fa-light6-1">
                                        需要卧床休息的患者
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light7-1">
                                    <label for="checkbox-fa-light7-1">
                                        肠炎病史
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light8-1">
                                    <label for="checkbox-fa-light8-1">
                                        下肢水肿
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light9-1">
                                    <label for="checkbox-fa-light9-1">
                                        静脉曲张
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light10-1">
                                    <label for="checkbox-fa-light10-1">
                                        严重肺部疾病(<1个月)
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light11-1">
                                    <label for="checkbox-fa-light11-1">
                                        肺功能异常，COPD
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light12-1">
                                    <label for="checkbox-fa-light12-1">
                                        急性心机梗塞
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light13-1">
                                    <label for="checkbox-fa-light13-1">
                                        充血性心力衰竭(1个月内)
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light14-1">
                                    <label for="checkbox-fa-light14-1">
                                        败血症(1个月内)
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light15-1">
                                    <label for="checkbox-fa-light15-1">
                                        大手术(1个月内)
                                    </label>
                                </div>
                                <div class="checkbox3 checkbox-success checkbox-check checkbox-round  checkbox-light">
                                    <input type="checkbox" value="1" id="checkbox-fa-light16-1">
                                    <label for="checkbox-fa-light16-1">
                                        其他高危因素
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
