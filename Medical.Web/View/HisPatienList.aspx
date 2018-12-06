<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.HisPatienList" %>

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
                                <div class="title">His病人信息列表</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <button type="button" onclick="Add()" class="btn btn-success"><i class="fa fa-barcode"></i>&nbsp;生成条码</button>
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
                                <div class="page-title">
                                    <img class="title" id="code" style="width:200px;height:150px" />
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
                $("#updatePwd").hide();
            }

            Number.prototype.zeroPadding = function () {
                var ret = "" + this.valueOf();
                return ret.length == 1 ? "0" + ret : ret;
            };

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

            load();
        })


        function load() {
            $('#jDataGrid').jqGrid({
                url: 'BaseManageHandler.ashx?tag=GetHisPatientList',
                postData: { pageIndex: pageIndex, pageSize: pageSize },
                datatype: 'json',
                mtype: 'post',
                autowidth: true,
                shrinkToFit: false,
                cellEdit: false,
                gridview: true,
                altRows: true,
                viewrecords: true,
                colNames: ['id', '序号', '姓名', '性别', '年龄', '编码', '身份证号', '联系方式', '入院时间', '联系地址', '婚姻状况', '户籍地址', '工作单位'],
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
            var rowId = $('#jDataGrid').jqGrid('getGridParam', 'selrow');

            if (rowId) {
                layer.open({
                    content: addhtml,
                    shadeClose: true,
                    btn: ['关闭'],
                    anim: 'up',
                    yes: function (index) {
                        layer.close(index);
                    },
                    success: function (elem) {
                        var rowData = $('#jDataGrid').jqGrid('getRowData', rowId);
                        JsBarcode("#code", rowData["编码"]);
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

    </script>

</asp:Content>
