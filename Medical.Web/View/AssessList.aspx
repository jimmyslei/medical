<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.AssessList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/AdminLTE.min.css" rel="stylesheet" />
    <link href="../css/font-awesome.min.css" rel="stylesheet" />
    <link href="../css/skins/_all-skins.min.css" rel="stylesheet" />
    <link href="../css/ui.jqgrid-bootstrap.css" rel="stylesheet" />
    <link href="../css/vjpage.css" rel="stylesheet" />
    <link href="../css/config.css" rel="stylesheet" />

    <style>
        #gbox_jDataGrid, #gview_jDataGrid, #gridPager, .ui-jqgrid-hdiv, .ui-jqgrid-bdiv {
            width: 100% !important;
        }

        .select2-container--default .select2-selection--single .select2-selection__rendered {
            line-height: 25px !important;
        }

        .select2-container .select2-selection--single .select2-selection__rendered {
            padding-left: 0px !important;
        }

        .flat-blue .table .danger, .flat-blue .table .success, .flat-blue .table .warning, .flat-blue .table .primary {
            color: white !important;
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
                                <div class="title">评估风险统计</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        
                                        <audio src="../music/tis.mp3" id="myaudio" controls="controls" loop="false" autoplay hidden="true"></audio>               
                                        <div class="btn-group">
                                            <span>风险类别</span>
                                            <select id="type" style="width: 180px">
                                                <option value="1">疼痛评估</option>
                                                <option value="2">Braden压疮风险评估</option>
                                                <option value="3">Morse跌倒评估</option>
                                                <option value="4">VTE评估</option>
                                                <option value="5">非计划性拔管评估</option>
                                            </select>

                                        </div>
                                        <div class="btn-group">

                                            <span>风险等级</span>
                                            <select id="rank" style="width: 130px">
                                                <option value="1">无风险</option>
                                                <option value="2">低风险</option>
                                                <option value="3">中风险</option>
                                                <option value="4">高风险</option>
                                                <option value="5">极高风险</option>
                                            </select>
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
    <script src="../js/Common.js"></script>
    <link href="../lib/css/select2.min.css" rel="stylesheet" />
    <script src="../lib/js/select2.full.min.js"></script>

    <script>
        $.jgrid.defaults.styleUI = 'Bootstrap';
        $.jgrid.defaults.responsive = true;
        var pageIndex = 1, pageSize = 10;
        $(function myfunction() {
            var myAuto = document.getElementById('myaudio');
            //myAuto.play();  //播放
            myAuto.pause(); //暂停
            $(".username").text(getCookie("Home_UserName"));
            var state = getCookie("state");
            if (state == "2") {
                $("#baseLi").hide();
                $("#updatePwd").hide();
            }


            ////时间比较
            //debugger;
            //var planDate = new Date('2018-02-25 05:30:00');
            //var applyDate = new Date('2018-03-02 12:25:18');

            //if (applyDate > planDate) {
            //    alert("预计完成时间不能早于提请日期！");
            //    //return false;
            //}


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

            $("#type").select2({
                tags: "true",
                placeholder: "请选择",
                allowClear: false
            });

            $("#rank").select2({
                tags: "true",
                placeholder: "请选择",
                allowClear: false
            });

            $("#type").on("select2:select", function (e) {
                queryFunc(pageIndex, pageSize)
            })
            $("#rank").on("select2:select", function (e) {
                queryFunc(pageIndex, pageSize)
            })

            load();
        });

        function load() {
            var type = $("#type option:selected").val();
            var rank = $("#rank option:selected").val();

            $('#jDataGrid').jqGrid({
                url: 'BaseManageHandler.ashx?tag=GetAssess',
                postData: { pageIndex: pageIndex, pageSize: pageSize, type: type, rank: rank },
                datatype: 'json',
                mtype: 'post',
                autowidth: true,
                shrinkToFit: false,
                cellEdit: false,
                gridview: true,
                altRows: true,
                viewrecords: true,
                colNames: ['ID', '序号', '姓名', '评估项目', '评估类别', '评估总分', '等级', '评估日期'],
                colModel: [
                    { name: 'ID', index: 'ID', hidden: true },
                    { name: '序号', index: '序号', width: 40, align: 'center' },
                    { name: '姓名', index: '姓名' },
                    { name: '评估项目', index: '评估项目' },
                    {
                        name: '评估类别', index: '评估类别', formatter: function (cellvalue, options, rowObject) {
                            if (cellvalue == "1") {
                                return "疼痛评估";
                            } else if (cellvalue == "2") {
                                return "Braden压疮风险评估";
                            } else if (cellvalue == "3") {
                                return "Morse跌倒评估";
                            } else if (cellvalue == "4") {
                                return "VTE评估";
                            } else if (cellvalue == "5") {
                                return "非计划性拔管评估";
                            }
                        }
                    },
                    { name: '评估总分', index: '评估总分' },
                    {
                        name: '等级', index: '等级', formatter: function (cellvalue, options, rowObject) {
                            if (cellvalue == "1") {
                                return "<span class='badge success'>良好</span>";
                            } else if (cellvalue == "2") {
                                return "<span class='badge success' style='background-color:#ffe5a2;color:#5d5d5d !important'>低风险</span>";
                            } else if (cellvalue == "3") {
                                return "<span class='badge warning'>中风险</span>";
                            } else if (cellvalue == "4") {
                                return "<span class='badge danger'>高风险</span>";
                            } else if (cellvalue == "5") {
                                return "<span class='badge primary'>极高风险</span>";
                            }

                        }
                    },
                    { name: '评估日期', index: '评估日期' }

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
            var type = $("#type option:selected").val();
            var rank = $("#rank option:selected").val();
            //加载数据：
            $("#jDataGrid").jqGrid('setGridParam', {
                url: "BaseManageHandler.ashx?tag=GetAssess",
                postData: { pageIndex: pageIndex, pageSize: pageSize, type: type, rank: rank },
            }).trigger("reloadGrid");
        }


    </script>

</asp:Content>
