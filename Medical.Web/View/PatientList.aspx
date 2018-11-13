<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.PatientList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/themes/flat-blue.css">
    <script src="../js/jquery-2.1.1.min.js"></script>

    <script>
        var pageIndex = 1, pageSize = 10;
        $(function () {
            load();
            getTotal();
            page();
        });

        function load() {
            $.ajax({
                type: "post",
                url: "BaseManageHandler.ashx?tag=GetPaintList",
                data: { pageIndex: pageIndex, pageSize: pageSize },
                dataType: "Json",
                async: true,
                success: function (data) {
                    var tbody = [];
                    for (var i = 0; i < data.length; i++) {
                        var sex;
                        if (data[i]["性别"] == "1") {
                            sex = "男";
                        }
                        else {
                            sex = "女";
                        }
                        tbody.push("<tr>\
                                        <td>" + data[i]["姓名"] + "</td>\
                                        <td>" + sex + "</td>\
                                        <td>" + data[i]["用户名"] + "</td>\
                                        <td>" + data[i]["联系方式"] + "</td>\
                                    </tr>");
                    }

                    var table = "<thead>\
                                    <tr>\
                                        <th>姓名</th>\
                                        <th>性别</th>\
                                        <th>用户名</th>\
                                       <th>联系电话</th>\
                                    </tr>\
                                </thead>\
                                <tbody>\
                                    " + tbody + "\
                                </tbody>";

                    $(".table").html(table);
                },
                error: function (error) {

                }
            });
        }
        var total = 0;
        function getTotal() {
            $.ajax({
                type: "post",
                url: "BaseManageHandler.ashx?tag=GetPaintTotal",
                data: null,
                dataType: "json",
                async: true,
                success: function (data) {
                    total = data;
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }

        function page() {

            var pageCount = (total % pageSize) == 0 ? (total / pageSize) : (total / pageSize) + 1;

            for (var i = 1; i < pageCount+1; i++) {

            }

            var pageHtml = "<ul class='pagination'>\
                            <li class='page-item'>\
                                <a class='page-link' href='#' aria-label='Previous'>\
                                    <span aria-hidden='true'>&laquo;</span>\
                                    <span class='sr-only'>Previous</span>\
                                </a>\
                            </li>\
                            <li class='page-item'><a class='page-link' href='#'>1</a></li>\
                            <li class='page-item'><a class='page-link' href='#'>2</a></li>\
                            <li class='page-item'><a class='page-link' href='#'>3</a></li>\
                            <li class='page-item'>\
                                <a class='page-link' href='#' aria-label='Next'>\
                                    <span aria-hidden='true'>&raquo;</span>\
                                    <span class='sr-only'>Next</span>\
                                </a>\
                            </li>\
                        </ul>";
            $(".page").html(pageHtml);
        }

    </script>
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
                                        <button type="button" class="btn btn-success"><i class="fa fa-plus-square"></i>&nbsp新增</button>
                                        <button type="button" class="btn btn-warning"><i class="fa fa-edit"></i>&nbsp修改</button>
                                        <button type="button" class="btn btn-danger"><i class="fa fa fa-trash-o"></i>&nbsp删除</button>
                                    </div>
                                    <div class="panel-body">
                                        <div class="col-sm-12">
                                            <table class="table table-hover select">
                                                <%--   <thead>
                                                    <tr>
                                                        <th>序号</th>
                                                        <th>姓名</th>
                                                        <th>出生日期</th>
                                                        <th>电话</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <th scope="row">1</th>
                                                        <td>Mark</td>
                                                        <td>Otto</td>
                                                        <td>@mdo</td>
                                                    </tr>
                                                    <tr>
                                                        <th scope="row">2</th>
                                                        <td>Jacob</td>
                                                        <td>Thornton</td>
                                                        <td>@fat</td>
                                                    </tr>
                                                    <tr>
                                                        <th scope="row">3</th>
                                                        <td>Larry</td>
                                                        <td>the Bird</td>
                                                        <td>@twitter</td>
                                                    </tr>
                                                </tbody>--%>
                                            </table>

                                            <nav aria-label="Page navigation example" class="page">
                                                <%--<ul class="pagination">
                                                    <li class="page-item">
                                                        <a class="page-link" href="#" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                            <span class="sr-only">Previous</span>
                                                        </a>
                                                    </li>
                                                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                                    <li class="page-item">
                                                        <a class="page-link" href="#" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                            <span class="sr-only">Next</span>
                                                        </a>
                                                    </li>
                                                </ul>--%>
                                            </nav>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <%--  <div class="sub-title">Panel Colors</div>
                            <div class="row row-example">
                                <div class="col-sm-4">
                                    <div class="panel panel-primary">
                                        <div class="panel-heading">.panel-primary</div>
                                        <div class="panel-body">
                                            Panel content
                                               
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="panel panel-success">
                                        <div class="panel-heading">.panel-success</div>
                                        <div class="panel-body">
                                            Panel content
                                               
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="panel panel-info">
                                        <div class="panel-heading">.panel-info</div>
                                        <div class="panel-body">
                                            Panel content
                                               
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="panel panel-warning">
                                        <div class="panel-heading">.panel-warning</div>
                                        <div class="panel-body">
                                            Panel content
                                               
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="panel panel-danger">
                                        <div class="panel-heading">.panel-danger</div>
                                        <div class="panel-body">
                                            Panel content
                                               
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="sub-title">Panel with Fresh Colors <span class="description">( .fresh-color )</span></div>
                            <div class="row row-example">
                                <div class="col-sm-4">
                                    <div class="panel fresh-color panel-primary">
                                        <div class="panel-heading">.panel-primary</div>
                                        <div class="panel-body">
                                            Panel content
                                               
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="panel fresh-color panel-success">
                                        <div class="panel-heading">.panel-success</div>
                                        <div class="panel-body">
                                            Panel content
                                               
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="panel fresh-color panel-info">
                                        <div class="panel-heading">.panel-info</div>
                                        <div class="panel-body">
                                            Panel content
                                               
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="panel fresh-color panel-warning">
                                        <div class="panel-heading">.panel-warning</div>
                                        <div class="panel-body">
                                            Panel content
                                               
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="panel fresh-color panel-danger">
                                        <div class="panel-heading">.panel-danger</div>
                                        <div class="panel-body">
                                            Panel content
                                        </div>
                                    </div>
                                </div>
                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
