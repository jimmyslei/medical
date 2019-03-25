<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.PersonList" %>

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
                                <div class="title">人员列表</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <button type="button" onclick="OperFunction(0)" class="btn btn-success"><i class="fa fa-plus-square"></i>&nbsp新增</button>
                                    <button type="button" onclick="OperFunction(1)" class="btn btn-warning"><i class="fa fa-edit"></i>&nbsp修改</button>
                                    <button type="button" onclick="OperFunction(-1)" class="btn btn-danger"><i class="fa fa fa-trash-o"></i>&nbsp删除</button>
                                </div>
                                <div class="panel-body">
                                    <div class="col-sm-12">
                                        <table id="jDataGrid" style="width: 100%" class="table table-hover select">
                                        </table>
                                        <div id="gridPager"></div>
                                    </div>
                                    <textarea id="add" style="display: none;">
                                        <form id="form" class="form-inline" style="max-height: 350px;overflow:scroll;overflow-x:hidden;">
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
                                            <%--<div class="form-group text-show">
                                                <label for="userName">用户名</label>
                                                <input type="text" class="form-control text" cName="userName" id="userName" placeholder="姓名">
                                            </div>
                                            <div class="form-group text-show">
                                                <label for="pwd">密码</label>
                                                <input type="password" class="form-control text" cName="pwd" id="pwd" placeholder="密码">
                                            </div>--%>
                                            <div class="form-group text-show">
                                                <label for="idCard">身份证</label>
                                                <input type="text" class="form-control text" cName="idCard" id="idCard" placeholder="身份证号码">
                                            </div>
                                            <div class="form-group text-show">
                                                <label for="birth">出生日期</label>
                                                <input type="text" class="form-control text" cName="birth" id="birth" placeholder="出生日期">
                                            </div>
                                            <div class="form-group text-show">
                                                <label for="phone">联系电话</label>
                                                <input type="text" class="form-control text" cName="phone" id="phone" placeholder="联系电话">
                                            </div>
                                            <div class="form-group text-show">
                                                <label for="phone">人员编码</label>
                                                <input type="text" class="form-control text" cName="code" id="code" placeholder="人员编码">
                                            </div>
                                            <div class="form-group" style="width:95%">
                                                <label for="address">家庭住址</label>
                                                <input type="text" class="form-control text" cName="address" id="address" placeholder="家庭住址">
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
    <link href="../js/laydate/theme/default/laydate.css" rel="stylesheet" />
    <script src="../js/laydate/laydate.js"></script>
    <script src="../js/Common.js"></script>
    <script>
        $.jgrid.defaults.styleUI = 'Bootstrap';
        $.jgrid.defaults.responsive = true;
        var pageIndex = 1, pageSize = 10;

        $(function () {
            if (getCookie("Home_UserName") == null) {
                window.location.href = "../Login";
            }
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
        });

        function load() {
            jQuery('#jDataGrid').jqGrid({
                url: 'BaseManageHandler.ashx?tag=GetPersonList',
                postData: { pageIndex: pageIndex, pageSize: pageSize },
                datatype: 'json',
                mtype: 'post',
                autowidth: true,
                shrinkToFit: false,
                cellEdit: false,
                gridview: true,
                altRows: true,
                userdata: 'userdata',
                viewrecords: true,
                colNames: ['ID', '序号', '姓名', '编码', '性别', '身份证号', '联系电话', '出生日期', '住址'],
                colModel: [
                    { name: 'ID', index: 'ID', hidden: true },
                    { name: '序号', index: '序号', width: 40, align: 'center' },
                    { name: '姓名', index: '姓名' },
                    { name: '编码', index: '编码' },
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
                    { name: '身份证号', index: '身份证号' },
                    { name: '联系方式', index: '联系方式' },
                    { name: '出生日期', index: '出生日期' },
                    { name: '住址', index: '住址' }
                ],
                jsonReader: {
                    root: "dataList", page: "currPage", total: "totalPage",
                    records: "totalCount", repeatitems: false, id: "id"
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
                url: "BaseManageHandler.ashx?tag=GetPersonList",
                postData: { pageIndex: pageIndex, pageSize: pageSize },  //{ page: cr_page, size: size, 'user_age': 20 }, //发送数据，查第一页，只查2条（grid rowNum），找到所有20岁的人  
            }).trigger("reloadGrid");
        }

        var Id = "";
        function OperFunction(state) {
            var addhtml = $("#add").val();
            var url = "BaseManageHandler.ashx?tag=EditPerson";
            if (state == "0") {
                commAlert(addhtml, url, "0");
            } else if (state == "1") {
                var rowId = $('#jDataGrid').jqGrid('getGridParam', 'selrow');
                
                if (rowId) {
                    Id = rowId;
                    commAlert(addhtml, url, "1");
                } else {
                    layer.open({
                        content: '请选择一行数据'
                        , skin: 'msg'
                        , time: 2
                    });
                }
            } else if (state == "-1") {
                Del();
            }
        }

        function commAlert(html, url, state) {
            layer.open({
                content: html,
                shadeClose: true,
                btn: ['确定', '取消'],
                anim: 'up',
                success: function (elem) {
                    var width = $(".layui-m-layerchild").width();
                    if (width < 350) {
                        $(".text-show").css({ "width": "95%" });
                    } else {
                        $(".text-show").css({ "width": "45%" });
                    }

                    laydate.render({
                        elem: '#birth',
                        min: '1700-01-01',
                        max: '2250-01-01',
                        format: 'yyyy-MM-dd',
                        theme: '#16a1d3',
                        done: function (value, date, endDate) {

                        }
                    });

                    //修改填充表单
                    if (state == "1") {
                        var rowData = $('#jDataGrid').jqGrid('getRowData', Id);
                        $("#name").val(rowData['姓名']);
                        if (rowData['性别'] == "男") {
                            $("#sex").val(1);
                        } else {
                            $("#sex").val(0);
                        }
                        //$("#userName").val(rowData['用户名']);
                        //$("#pwd").val(rowData['密码']);
                        $("#idCard").val(rowData['身份证号']);
                        $("#birth").val(rowData['出生日期']);
                        $("#phone").val(rowData['联系方式']);
                        $("#code").val(rowData['编码']);
                        $("#address").val(rowData['住址']);
                    }

                },
                yes: function (index) {
                    var data = comFn.getFromVal();
                    var rowData = $('#jDataGrid').jqGrid('getRowData', Id);
                    data.Id = rowData.ID;
                    data.state = state;
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
                    var url = "BaseManageHandler.ashx?tag=EditPerson";
                    var rowData = $('#jDataGrid').jqGrid('getRowData', rowId);
                    var data = { state: -1, Id: rowData.ID };
                    if (save(url, data)) {
                        layer.open({
                            content: '删除成功',
                            skin: 'msg',
                            time: 2
                        });
                        layer.close(index);
                        queryFunc(pageIndex, pageSize);

                    } else {
                        layer.open({
                            content: '删除失败',
                            skin: 'msg',
                            time: 2
                        });
                    }
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
                if (data > "0") {
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
