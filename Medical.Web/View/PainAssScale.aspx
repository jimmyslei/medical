<%@ Page Title="" Language="C#" MasterPageFile="~/View/Main.Master" AutoEventWireup="true" Inherits="Medical.Library.View.PainAssScale" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/themes/flat-blue.css">
    <link href="../js/layui/css/layui.css" rel="stylesheet" />
    <link href="../js/laymobile/layer.css" rel="stylesheet" />

    <script>
        function clk() {
            var html = $("#demo5a").val();
            // var html = window.location.href = "AsseTable.aspx";
            layer.open({
                type: 1,
                content: html,
                anim: 'up',
                style: 'position:fixed; bottom:0; left:0; width: 100%; height: 90%; padding:10px 0; border: none; -webkit-animation-duration: .5s; animation-duration: .5s;'
            });
        }

        function sub() {
            layer.open({
                content: '移动版和PC版不能同时存在同一页面',
                shadeClose: false,
                btn: '我知道了'
            });
        }

    </script>

    <style>
        .content {
            background-color: #E9E7E7;
        }

        .card {
            margin: 20px;
        }

        .card-header {
            background-color: #4e9bef;
        }

        .btn-primary {
            margin-top: 20px;
        }

        .layui-form-checkbox[lay-skin=primary] {
            height: 0 !important;
        }

            .layui-form-checkbox[lay-skin=primary]:hover i {
                border-color: #007DDB;
            }

        .layui-form-checked[lay-skin=primary] i {
            border-color: #007DDB;
            background-color: #007DDB;
        }

        .layui-form-radio > i:hover, .layui-form-radioed > i {
            color: #007DDB;
        }

        .layui-form-checkbox span {
            overflow: inherit;
            white-space: inherit;
        }

        .layui-input-block {
            margin-left: 10px;
        }

        .layui-form-checkbox, .layui-form-checkbox *, .layui-form-switch {
            display: -webkit-box;
        }

        .badge-primary {
            color: white !important;
            background-color: #007DDB !important;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="side-body padding-top">
            <div class="row  no-margin-bottom">
                <div class="col-xs-12">
                    <div class="card card-success">
                        <div class="card-header">
                            <div class="card-title">
                                <div class="title">
                                    <i class="fa fa-comments-o"></i>
                                    标题
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xs-12">
                    <div class="card card-success">
                        <div class="card-header">
                            <div class="card-title">
                                <div class="title"><i class="fa fa-comments-o"></i>Last Message</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                        <div class="card-body no-padding">
                            <ul class="message-list">
                                <a href="#">
                                    <li>
                                        <span class="badge badge-pill badge-danger">高危</span>
                                        <div class="layui-form layui-form-item">
                                            <div class="layui-input-block">
                                                <input type="checkbox" name="like1[write]" lay-skin="primary" title="写作速度快刚好是法规的法规梵蒂冈" checked="">
                                                <input type="checkbox" name="like1[read]" lay-skin="primary" title="阅读的疯狂了国家基本型">
                                                <input type="checkbox" name="like1[game]" lay-skin="primary" title="游戏没回复的华融开放部分">
                                            </div>
                                        </div>
                                        <div class="layui-form layui-form-item">
                                            <div class="layui-input-block">
                                                <input type="radio" name="sex" value="男" title="男" checked="">
                                                <input type="radio" name="sex" value="女" title="女">
                                                <input type="radio" name="sex" value="禁" title="禁用">
                                            </div>
                                        </div>
                                    </li>
                                </a>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-sm-12">
                    <div class="sub-title">鼠标浮动效果 <span class="description"></span></div>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Username</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">1</th>
                                <td>Mark</td>
                                <td>Otto</td>
                                <td>@mdo</td>
                                <td>
                                    <button type="button" class="btn btn-success"><i class="fa fa-plus-square"></i>&nbsp新增</button>
                                    <button type="button" class="btn btn-warning"><i class="fa fa-edit"></i>&nbsp修改</button>
                                    <button type="button" class="btn btn-danger"><i class="fa fa fa-trash-o"></i>&nbsp删除</button>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">2</th>
                                <td>Jacob</td>
                                <td>Thornton</td>
                                <td>@fat</td>
                                <td>
                                    <button type="button" class="btn btn-success"><i class="fa fa-plus-square"></i>&nbsp新增</button>
                                    <button type="button" class="btn btn-warning"><i class="fa fa-edit"></i>&nbsp修改</button>
                                    <button type="button" class="btn btn-danger"><i class="fa fa fa-trash-o"></i>&nbsp删除</button>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">3</th>
                                <td>Larry</td>
                                <td>the Bird</td>
                                <td>@twitter</td>
                                <td>
                                    <button type="button" class="btn btn-success"><i class="fa fa-plus-square"></i>&nbsp新增</button>
                                    <button type="button" class="btn btn-warning"><i class="fa fa-edit"></i>&nbsp修改</button>
                                    <button type="button" class="btn btn-danger"><i class="fa fa fa-trash-o"></i>&nbsp删除</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>

            <div style="padding: 10px;">
                <button type="button" onclick="new Function(clk())();" class="btn btn-primary btn-lg btn-block">提交</button>
            </div>

        </div>
    </div>

    <textarea id="demo5a" style="display: none;">
        <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

         <div class="card" style="margin: 0;">
            <div class="card-header" style="background-color: #4e9bef; text-align: center;">
                dfdsf-测试问卷调查是的放假了干净利索功能设定奇偶平
            </div>
        </div>
        <div class="card">
            <div class="card-header">
                水电费感受到了感觉到了国内低很多年了
            </div>
            <div class="card-body">
                <h5 class="card-title">是的贵金属的枫蓝国际</h5>
                <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                <span class="badge badge-pill badge-danger">高危</span>
                <span class="badge badge-pill badge-warning">警告</span>
                <span class="badge badge-pill badge-success">正常</span>
            </div>
        </div>
        <div class="card">
            <div class="card-header">
                水电费感受到了感觉到了国内低很多年了
            </div>
            <div class="card-body">
                <h5 class="card-title">是的贵金属的枫蓝国际</h5>
                <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
                <span class="badge badge-pill badge-danger">高危</span>
                <span class="badge badge-pill badge-warning">警告</span>
                <span class="badge badge-pill badge-success">正常</span>

                <div class="layui-form layui-form-item" pane="">
                    <div class="layui-input-block">
                        <input type="checkbox" name="like1[write]" lay-skin="primary" title="写作速度快刚好是法规的法规梵蒂冈" checked="">
                        <input type="checkbox" name="like1[read]" lay-skin="primary" title="阅读的疯狂了国家基本型">
                        <input type="checkbox" name="like1[game]" lay-skin="primary" title="游戏没回复的华融开放部分">
                    </div>
                </div>

                <div class="layui-form layui-form-item">
                    <div class="layui-input-block">
                        <input type="radio" name="sex" value="男" title="男" checked="">
                        <input type="radio" name="sex" value="女" title="女">
                        <input type="radio" name="sex" value="禁" title="禁用">
                    </div>
                </div>
            </div>
        </div>
        <div style="padding: 10px;">
            <button type="button" onclick="sub()" class="btn btn-primary btn-lg btn-block">提交</button>
        </div>
        <script src="../js/layui/layui.all.js"></script>
        <script src="../js/laymobile/layer.js"></script>
    </textarea>


    <script src="../js/layui/layui.all.js"></script>
    <script src="../js/laymobile/layer.js"></script>
</asp:Content>
