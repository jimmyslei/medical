<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.BradenScale" %>

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
        .select2-dropdown{
            z-index:99999999 !important
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
                                cache : true,　　　　　　　　　　//开启缓存
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
            $.each($("input[type=radio]:checked"), function (d) {
                score += parseInt($(this).val());
            })

            var rank, tips = '';
            if (score > 18) {
                rank = 1;
                tips = '该病人状态良好';
            } else if (score >= 15 && score <= 18) {
                rank = 2;
                tips = '该病人当前处于 低危 状态，请每周评估一次';
            } else if (score >= 13 && score <= 14) {
                rank = 3;
                tips = '该病人当前处于 中危 状态，请每周评估两次';
            } else if (score >= 10 && score <= 12) {
                rank = 4;
                tips = '该病人当前处于 高危 状态，请每周评估两次';
            } else if (score <= 9) {
                rank = 5;
                tips = '该病人当前处于 极高危 状态，请每两天评估一次';
            }

            var data = {};
            data.patId = paintId;
            data.assItem = "Braden压疮风险评估";
            data.assType = 2;
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
                                <div class="title" style="color: white; float: left">Braden压疮风险评估量表</div>
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
                            <div class="sub-title">(感知)机体对压力引起的不是感的反应能力</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio1" name="radio1" value="1">
                                    <label for="radio1">
                                        完全受限
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio2" name="radio1" value="2">
                                    <label for="radio2">
                                        大部分受限
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio3" name="radio1" value="3">
                                    <label for="radio3">
                                        轻度受限
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radio4" name="radio1" value="4">
                                    <label for="radio4">
                                        没有改变
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">(潮湿)皮肤处于潮湿状态的程度</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioc1" name="radio2" value="1">
                                    <label for="radioc1">
                                        持久潮湿
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioc2" name="radio2" value="2">
                                    <label for="radioc2">
                                        经常潮湿
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioc3" name="radio2" value="3">
                                    <label for="radioc3">
                                        偶尔潮湿
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioc4" name="radio2" value="4">
                                    <label for="radioc4">
                                        很少潮湿
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">(活动能力)躯体活动的能力</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioh1" name="radio3" value="1">
                                    <label for="radioh1">
                                        卧床不起
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioh2" name="radio3" value="2">
                                    <label for="radioh2">
                                        局限于轮椅
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioh3" name="radio3" value="3">
                                    <label for="radioh3">
                                        可偶尔步行
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioh4" name="radio3" value="4">
                                    <label for="radioh4">
                                        经常步行
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">(移动能力)控制躯体位置的能力</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioy1" name="radio4" value="1">
                                    <label for="radioy1">
                                        完全受限
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioy2" name="radio4" value="2">
                                    <label for="radioy2">
                                        严重受限
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioy3" name="radio4" value="3">
                                    <label for="radioy3">
                                        轻度受限
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioy4" name="radio4" value="4">
                                    <label for="radioy4">
                                        不受限
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">(营养)平常食物摄入模式</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radiof1" name="radio5" value="1">
                                    <label for="radiof1">
                                        严重营养摄入不足
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radiof2" name="radio5" value="2">
                                    <label for="radiof2">
                                        营养摄入不足
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radiof3" name="radio5" value="3">
                                    <label for="radiof3">
                                        营养摄入适当
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radiof4" name="radio5" value="4">
                                    <label for="radiof4">
                                        营养摄入良好
                                    </label>
                                </div>
                            </div>
                            <div class="sub-title">摩擦力和剪切力</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radiol1" name="radio6" value="1">
                                    <label for="radiol1">
                                        有此问题
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radiol2" name="radio6" value="2">
                                    <label for="radiol2">
                                        有潜在问题
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radiol3" name="radio6" value="3">
                                    <label for="radiol3">
                                        无明显问题
                                    </label>
                                </div>
                            </div>

                            <!--儿童加一项-->
                            <%--  <div class="sub-title">组织灌注与养合</div>
                            <div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioz1" name="radio7" value="1">
                                    <label for="radioz1">
                                        极度缺乏
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioz2" name="radio7" value="2">
                                    <label for="radioz2">
                                        缺乏
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioz3" name="radio7" value="3">
                                    <label for="radioz3">
                                        充足
                                    </label>
                                </div>
                                <div class="radio3 radio-check radio-success">
                                    <input type="radio" id="radioz4" name="radio7" value="4">
                                    <label for="radioz4">
                                        非常好
                                    </label>
                                </div>
                            </div>--%>

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
