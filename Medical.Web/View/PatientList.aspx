<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.PatientList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/AdminLTE.min.css" rel="stylesheet" />
    <link href="../css/font-awesome.min.css" rel="stylesheet" />
    <link href="../css/skins/_all-skins.min.css" rel="stylesheet" />
    <link href="../css/ui.jqgrid-bootstrap.css" rel="stylesheet" />
    <link href="../css/vjpage.css" rel="stylesheet" />
    <link href="../css/config.css" rel="stylesheet" />

    <style>
        .text {
            width: 90% !important;
        }

        /*.text-show {
            width: 45% !important;
        }*/

        .text-all {
            width: 95% !important;
        }

        #gbox_jDataGrid, #gview_jDataGrid, #gridPager, .ui-jqgrid-hdiv, .ui-jqgrid-bdiv {
            width: 100% !important;
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
                                <div class="title">病人信息列表</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <button type="button" onclick="Add()" class="btn btn-success"><i class="fa fa-plus-square"></i>&nbsp;新增</button>
                                        <button type="button" onclick="Edit()" class="btn btn-warning"><i class="fa fa-edit"></i>&nbsp;修改</button>
                                        <button type="button" onclick="Del()" class="btn btn-danger"><i class="fa fa fa-trash-o"></i>&nbsp;删除</button>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-expanded="false">风险评估 <span class="caret"></span></button>
                                            <ul class="dropdown-menu" role="menu">
                                                <li><a href="#">疼痛评估</a></li>
                                                <li><a href="#">跌倒评估</a></li>
                                                <li><a href="#">压疮评估</a></li>
                                                <li><a href="#">VTE评估</a></li>
                                                <li><a href="#">非计划拔管评估</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="panel-body">
                                        <div class="col-sm-12">
                                            <table id="jDataGrid" style="width: 100%" class="table table-hover select">
                                            </table>
                                            <div id="gridPager"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <textarea id="add" style="display: none;">
                            <form id="form" class="form-inline" style="max-height: 350px;overflow:scroll;overflow-x:hidden;">
                                <div class="form-group text-show">
                                    <label for="phone">编码</label>
                                    <input type="text" class="form-control text" cName="code" id="code" placeholder="编码">
                                </div>
                                <div class="form-group text-show">
                                    <label for="name">姓名</label>
                                    <input type="text" class="form-control text" cName="name" id="name" placeholder="姓名">
                                </div>
                                <div class="form-group text-show">
                                    <label for="sex">性别</label>
                                    <select class="form-control text select2-selection" cName="sex" id="sex">
                                        <option value="1">男</option>
                                        <option value="0">女</option>
                                    </select>
                                </div>
                                <div class="form-group text-show">
                                    <label for="idCard">身份证</label>
                                    <input type="text" class="form-control text" cName="cardId" id="idCard" placeholder="身份证号码">
                                </div>
                                <div class="form-group text-show">
                                    <label for="birth">年龄</label>
                                    <input type="text" class="form-control text" cName="age" id="age" placeholder="年龄">
                                </div>
                                <div class="form-group text-show">
                                    <label for="phone">联系电话</label>
                                    <input type="text" class="form-control text" cName="phone" id="phone" placeholder="联系电话">
                                </div>
                                <div class="form-group text-show">
                                    <label for="sex">科室</label>
                                    <select class="form-control text select2-selection" cName="dep" id="dep">
                                        <option value="1"></option>
                                        <option value="0"></option>
                                    </select>
                                </div>
                                <div class="form-group text-show">
                                    <label for="phone">床位</label>
                                    <input type="text" class="form-control text" cName="badno" id="badno" placeholder="床位">
                                </div>
                                <div class="form-group text-show">
                                    <label for="phone">入院时间</label>
                                    <input type="text" readonly class="form-control text" cName="inTime" id="inTime" placeholder="yyyy-mm-dd">
                                </div>
                                <div class="form-group text-show">
                                    <label for="sex">婚姻</label>
                                    <select class="form-control text select2-selection" cName="marry" id="marry">
                                        <option value="1">已婚</option>
                                        <option value="0">未婚</option>
                                    </select>
                                </div>
                                <div class="form-group text-all">
                                    <label for="address">现住住址</label>
                                    <input type="text" class="form-control text" cName="nowAddress" id="nowaddress" placeholder="现住住址">
                                </div>
                                <div class="form-group text-all">
                                    <label for="address">工作单位</label>
                                    <input type="text" class="form-control text" cName="work" id="work" placeholder="工作单位">
                                </div>
                                <div class="form-group text-all">
                                    <label for="address">户籍地址</label>
                                    <input type="text" class="form-control text" cName="address" id="address" placeholder="户籍地址">
                                </div>
                            </form>
                        </textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../js/jquery-3.3.1.min.js"></script>
    <script src="../js/jqGrid/adminlte.min.js"></script>
    <script src="../js/jqGrid/grid.locale-cn.js"></script>
    <script src="../js/jqGrid/jquery.jqGrid.min.js"></script>
    <link href="../js/laymobile/layer.css" rel="stylesheet" />
    <script src="../js/laymobile/layer.js"></script>
    <link href="../js/laydate/theme/default/laydate.css" rel="stylesheet" />
    <script src="../js/laydate/laydate.js"></script>
    <script src="../js/Common.js"></script>
    <script src="../js/JsBarcode.all.js"></script>
    <script>
        $.jgrid.defaults.styleUI = 'Bootstrap';
        $.jgrid.defaults.responsive = true;
        var pageIndex = 1, pageSize = 10;

        $(function () {
            $(".username").text(getCookie("Home_UserName"));
            var state = getCookie("state");
            if (state == "2") {
                $("#baseLi").hide();
            }

            Number.prototype.zeroPadding = function () {
                var ret = "" + this.valueOf();
                return ret.length == 1 ? "0" + ret : ret;
            };

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

            var code = "";
            var nextCode;
            document.onkeypress = function (e) {
                nextCode = e.which;
                if (nextCode != null && nextCode != 13) {
                    code += String.fromCharCode(nextCode);
                }

                if (e.which == 13) {
                    if (code == '') {
                        code = $("#code").val();
                    }
                    var data = { code: code };
                    comFn.Ajax("BaseManageHandler.ashx?tag=GetHisPatienInfoByCode", data, function (rdata) {
                        if (rdata.length > 0) {
                            $("#name").val(rdata[0]['姓名']);
                            $("#sex").val(rdata[0]['性别']);
                            $("#code").val(rdata[0]['编码']);
                            $("#inTime").val(rdata[0]['登记时间'])
                            $("#idCard").val(rdata[0]['身份证号']);
                            $("#age").val(rdata[0]['年龄']);
                            $("#phone").val(rdata[0]['联系方式']);
                            $("#marry").val(rdata[0]['婚姻状况']);
                            $("#nowaddress").val(rdata[0]['联系地址']);
                            $("#work").val(rdata[0]['工作单位']);
                            $("#address").val(rdata[0]['户籍地址']);
                        } else {
                            layer.open({
                                content: '该病人信息不存在',
                                skin: 'msg',
                                time: 2
                            });
                        }
                    }, function () {

                    }, false);
                    code = "";//回车输入后清空
                }
            };

            load();
        })


        function load() {
            $('#jDataGrid').jqGrid({
                url: 'BaseManageHandler.ashx?tag=GetPatientList',
                postData: { pageIndex: pageIndex, pageSize: pageSize },
                datatype: 'json',
                mtype: 'post',
                autowidth: true,
                //multiselect:true,  //多选
                shrinkToFit: false,
                cellEdit: false,
                gridview: true,
                altRows: true,
                viewrecords: true,
                colNames: ['id', '序号', '姓名', '性别','年龄', '编码', '身份证号', '联系方式', '科室', '床位', '入院时间', '联系地址', '婚姻状况', '户籍地址', '工作单位'],
                colModel: [
                    { name: 'id', index: 'id', hidden: true },
                    { name: '序号', index: '序号', width: 40, align: 'center' },
                    { name: '姓名', index: '姓名', classes: "text-align:center" },
                    {
                        name: '性别', index: '性别', formatter: function (cellvalue, options, rowObject) {
                            if (cellvalue == "1") {
                                return "男";
                            }
                            else if (cellvalue == "0") {
                                return "女";
                            }
                        }
                    },
                    { name: '年龄', index: '年龄' },
                    { name: '编码', index: '编码' },
                    { name: '身份证号', index: '身份证号' },
                    { name: '联系方式', index: '联系方式' },
                    { name: '科室', index: '科室' },
                    { name: '床位', index: '床位' },
                    { name: '登记时间', index: '登记时间' },
                    { name: '联系地址', index: '联系地址', hidden: true },
                    { name: '婚姻状况', index: '婚姻状况', hidden: true },
                    { name: '户籍地址', index: '户籍地址', hidden: true },
                    { name: '工作单位', index: '工作单位', hidden: true }
                ],
                jsonReader: {
                    root: "dataList", page: "page", total: "total",
                    records: "records", repeatitems: false
                },
                onSelectRow: function (rowId, status) {

                },
                loadComplete: function (data) {

                },
                onPaging: function (pageBtn) {
                    var re_page = $(this).getGridParam('page');//获取返回的当前页
                    var re_rowNum = $(this).getGridParam('rowNum');//获取每页数
                    var re_total = $(this).getGridParam('lastpage');//获取最后一页

                    if (pageBtn === "next") {
                        re_page = re_page + 1;
                        queryFunc(re_page, re_rowNum);
                    } else if (pageBtn === "prev") {
                        re_page = re_page - 1;
                        queryFunc(re_page, re_rowNum);
                    } else if (pageBtn === "last") {
                        queryFunc(re_total, re_rowNum);
                    } else if (pageBtn === "first") {
                        queryFunc(1, re_rowNum);
                    } else if (pageBtn === "records") {
                        var rowNum = $(".ui-pg-selbox").val();
                        queryFunc(re_page, rowNum);
                    } else if (pageBtn === "user") {
                        var page = $(".ui-pg-input").val();
                        queryFunc(page, re_rowNum);
                    }
                },
                height: 300,
                rowNum: 10,
                rownumbers: true,
                pginput: true,
                rowList: [10, 20, 30],
                pager: jQuery('#gridPager'),
            });
        }

        $('#jDataGrid').closest('.ui-jqgrid-bdiv').css({ 'overflow-y': 'auto' });
        $('#jDataGrid').trigger('reloadGrid');

        //重新加载数据
        function queryFunc(pageIndex, pageSize) {
            pageIndex = pageIndex;
            //加载数据：
            $("#jDataGrid").jqGrid('setGridParam', {
                url: "BaseManageHandler.ashx?tag=GetPatientList",
                postData: { pageIndex: pageIndex, pageSize: pageSize },
            }).trigger("reloadGrid");
        }

        function Add() {
            var addhtml = $("#add").val();

            layer.open({
                content: addhtml,
                shadeClose: true,
                btn: ['确定', '取消'],
                anim: 'up',
                yes: function (index) {
                    var url = "BaseManageHandler.ashx?tag=AddPatientInfo";
                    var data = comFn.getFromVal();
                    data.state = "1";
                    if (save(url, data)) {
                        layer.open({
                            content: '保存成功',
                            skin: 'msg',
                            time: 2
                        });
                        layer.close(index);
                        queryFunc(pageIndex, pageSize);

                    } else {
                        layer.open({
                            content: '保存失败',
                            skin: 'msg',
                            time: 2
                        });
                    }
                },
                success: function (elem) {
                    $('#code').focus();
                    var width = $(".layui-m-layerchild").width();
                    if (width < 350) {
                        $(".text-show").css({ "width": "95%" });
                    } else {
                        $(".text-show").css({ "width": "45%" });
                    }

                    comFn.Ajax("BaseManageHandler.ashx?tag=GetDepartmentList", null, function (sdata) {
                        debugger;
                        $("#dep").append("option")
                    }, function () {

                    }, false);
                    
                    laydate.render({
                        elem: '#inTime',
                        type: 'datetime',
                        min: '1700-01-01',
                        max: '2250-01-01',
                        format: 'yyyy-MM-dd HH:mm:ss',
                        theme: '#16a1d3',
                        done: function (value, date, endDate) {

                        }
                    });
                }
            });
        }

        function Del() {
            var rowId = $('#jDataGrid').jqGrid('getGridParam', 'selrow');
            if (rowId) {
                layer.open({
                    content: '您确定要删除该数据吗？'
                , btn: ['确定', '取消']
                , yes: function (index) {
                    var url = "BaseManageHandler.ashx?tag=DelPatient";
                    var data = { Id: rowId };
                    save(url, data);
                    layer.close(index);
                    queryFunc(pageIndex, pageSize);
                }
                });
            } else {
                layer.open({
                    content: '请选择一行数据'
                    , skin: 'msg'
                    , time: 2
                });
            }
        }

        function Edit() {
            var rowId = $('#jDataGrid').jqGrid('getGridParam', 'selrow');

            if (rowId) {
                var addhtml = $("#add").val();
                layer.open({
                    content: addhtml,
                    shadeClose: true,
                    btn: ['确定', '取消'],
                    anim: 'up',
                    // skin: 'footer',
                    yes: function (index) {
                        var url = "BaseManageHandler.ashx?tag=AddPatientInfo";
                        var data = comFn.getFromVal();
                        data.Id = rowId;
                        data.state = "2";
                        if (save(url, data)) {
                            layer.open({
                                content: '保存成功',
                                skin: 'msg',
                                time: 2
                            });
                            layer.close(index);
                            queryFunc(pageIndex, pageSize);

                        } else {
                            layer.open({
                                content: '保存失败',
                                skin: 'msg',
                                time: 2
                            });
                        }

                    },
                    success: function (elem) {
                        var width = $(".layui-m-layerchild").width();
                        if (width < 350) {
                            $(".text-show").css({ "width": "95%" });
                        } else {
                            $(".text-show").css({ "width": "45%" });
                        }
                        document.getElementById("code").disabled = true;

                        laydate.render({
                            elem: '#inTime',
                            type: 'datetime',
                            min: '1700-01-01',
                            max: '2250-01-01',
                            format: 'yyyy-MM-dd HH:mm:ss',
                            theme: '#16a1d3',
                            done: function (value, date, endDate) {

                            }
                        });
                        var rowData = $('#jDataGrid').jqGrid('getRowData', rowId);
                        $("#name").val(rowData['姓名']);
                        if (rowData['性别'] == "男") {
                            $("#sex").val(1);
                        } else {
                            $("#sex").val(0);
                        }
                        $("#code").val(rowData['编码']);
                        $("#inTime").val(rowData['登记时间'])
                        $("#idCard").val(rowData['身份证号']);
                        $("#age").val(rowData['年龄']);
                        $("#phone").val(rowData['联系方式']);
                        $("#marry").val(rowData['婚姻状况']);
                        $("#nowaddress").val(rowData['联系地址']);
                        $("#work").val(rowData['工作单位']);
                        $("#address").val(rowData['户籍地址']);
                    }
                });
            } else {
                layer.open({
                    content: '请选择一行数据'
                    , skin: 'msg'
                    , time: 2
                });
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

</asp:Content>
