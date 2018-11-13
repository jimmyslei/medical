<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.PersonList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/AdminLTE.min.css" rel="stylesheet" />
    <link href="../css/font-awesome.min.css" rel="stylesheet" />
    <link href="../css/skins/_all-skins.min.css" rel="stylesheet" />
    <link href="../css/ui.jqgrid-bootstrap.css" rel="stylesheet" />
    <link href="../css/vjpage.css" rel="stylesheet" />
    <link href="../css/config.css" rel="stylesheet" />

    <style>
        .form-control{
            width:90% !important;
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
                                <div class="title">人员列表</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <button type="button" onclick="Add()" class="btn btn-success"><i class="fa fa-plus-square"></i>&nbsp新增</button>
                                    <button type="button" class="btn btn-warning"><i class="fa fa-edit"></i>&nbsp修改</button>
                                    <button type="button" class="btn btn-danger"><i class="fa fa fa-trash-o"></i>&nbsp删除</button>
                                </div>
                                <div class="panel-body">
                                    <div class="col-sm-12">
                                        <table id="jDataGrid" style="width: 100%" class="table table-hover select">
                                        </table>
                                        <div id="gridPager"></div>
                                    </div>
                                    <textarea id="add" style="display: none;">
                                        <form class="form-inline" style="max-height:450px;overflow:scroll;overflow-x:hidden;">
                                            <div class="form-group">
                                                <label for="name">姓名</label>
                                                <input type="text" class="form-control" id="name" placeholder="姓名">
                                            </div>
                                            <div class="form-group">
                                                <label for="userName">用户名</label>
                                                <input type="text" class="form-control" id="userName" placeholder="用户名">
                                            </div>
                                            <div class="form-group">
                                                <label for="pwd">密码</label>
                                                <input type="password" class="form-control" id="pwd" placeholder="密码">
                                            </div>
                                            
                                        </form>
                                    </textarea>
                                </div>
                            </div>
                        </div>
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

    <script>
        $.jgrid.defaults.styleUI = 'Bootstrap';
        $.jgrid.defaults.responsive = true;
        var pageIndex = 1, pageSize = 10;

        $(function () {
            load();
        });

        function load() {
            jQuery('#jDataGrid').jqGrid({
                url: 'BaseManageHandler.ashx?tag=GetPaintList',
                postData: { pageIndex: pageIndex, pageSize: pageSize },
                datatype: 'json',
                mtype: 'post',
                autowidth: true,
                shrinkToFit: false,
                cellEdit: false,
                gridview: true,
                altRows: true,
                viewrecords: true,
                colNames: ['序号', '姓名', '性别', '用户名', '身份证号', '联系电话'],
                colModel: [
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
                    { name: '用户名', index: '用户名' },
                    { name: '身份证号', index: '身份证号' },
                    { name: '联系方式', index: '联系方式' }
                ],
                jsonReader: {
                    root: "dataList", page: "currPage", total: "totalPage",
                    records: "totalCount", repeatitems: false, id: "id"
                },
                loadComplete: function (data) {
                    debugger;

                },
                //onPaging: function (pageData) {
                //    debugger
                //},
                height: 300,
                rowNum: 10,
                rownumbers: true,
                rowList: [10, 20, 30],
                pager: jQuery('#gridPager'),
            });//.navGrid('#gridPager', { edit: true, add: false, del: false });//设置附加按钮
        }

        $('#jDataGrid').closest('.ui-jqgrid-bdiv').css({ 'overflow-y': 'auto' });
        $('#jDataGrid').trigger('reloadGrid');

        function Add() {
            var addhtml = $("#add").val();

            //layer.open({
            //    type: 1,
            //    content: addhtml,
            //   // shadeClose: false,
            //    anim: 'up',
            //    style: 'position:fixed; bottom:0; left:0; width: 100%; height: 90%; padding:10px 0; border:none;'
            // });

            layer.open({
                content: addhtml,
                shadeClose: false,
                btn: ['确定', '取消'],
               // skin: 'footer',
                yes: function (index) {

                }
            });
        }


    </script>
</asp:Content>
