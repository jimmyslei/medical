<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AsseTable.aspx.cs" Inherits="Medical.Web.View.AsseTable" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- <link href="css/bootstrap.css" /> -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="../js/layui/css/layui.css" rel="stylesheet" />
    <!-- <script src="js/bootstrap.js"></script> -->
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <link href="../js/laymobile/layer.css" rel="stylesheet" />

    <script>
        function clk() {
            layer.open({
                content: '移动版和PC版不能同时存在同一页面',
                shadeClose: false,
                btn: '我知道了'
            });
        }
    </script>

    <style>
        body {
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
    </style>

</head>
<body>
    <form id="form1" runat="server">
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
            <button type="button" onclick="clk()" class="btn btn-primary btn-lg btn-block">提交</button>
        </div>
        <script src="../js/layui/layui.all.js"></script>
        <script src="../js/laymobile/layer.js"></script>
    </form>
</body>
</html>
