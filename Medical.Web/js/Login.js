
var canGetCookie = 0;//是否支持存储Cookie 0 不支持 1 支持
$(window).ready(function () {

    document.title = "医疗系统";

    $('#tbUserName').focus();

    $("#radio-admin").prop("checked", "checked");

    $('#btnLogin').click(function () {
        login();
    });

    Code();

    $("#radio-user").click(function (data) {
        $("#tbUserName").attr("placeholder", "编码");
        $('#tbUserName').focus();
        $("#pwd").hide();
    });

    $("#radio-admin").click(function (data) {
        $("#tbUserName").attr("placeholder", "用户名");
        $('#tbUserName').focus();
        $("#pwd").show();
    });

    //绑定按下回车键事件
    $('#tbUserName').bind('keydown', function (e) {
        var key = e.which;
        if ($("#radio-user").is(':checked')) {
            if (key == 13) { $('#verifiyCode').focus(); }
        } else {
            if (key == 13) { $('#tbPassword').focus(); }
        }
    });

    $('#tbPassword').bind('keydown', function (e) {
        var key = e.which;
        if (key == 13) { $('#verifiyCode').focus(); }
    });

    $('#verifiyCode').bind('keydown', function (e) {
        var key = e.which;
        if (key == 13) { $('#btnLogin').click(); }
    });
    particlesJS('star', {
        particles: {
            color: '#fff',
            shape: 'circle', // "circle", "edge" or "triangle"
            opacity: 0.3,
            size: 3,
            size_random: true,
            nb: 80,
            line_linked: {
                enable_auto: true,
                distance: 100,
                color: '#fff',
                opacity: 1,
                width: 1,
                condensed_mode: {
                    enable: false,
                    rotateX: 600,
                    rotateY: 600
                }
            },
            anim: {
                enable: true,
                speed: 1
            }
        },
        interactivity: {
            enable: true,
            mouse: {
                distance: 250
            },
            detect_on: 'canvas', // "canvas" or "window"
            mode: 'grab',
            line_linked: {
                opacity: .5
            },
            events: {
                onclick: {
                    enable: false,
                    mode: 'push', // "push" or "remove" (particles)
                    nb: 4
                }
            }
        },
        /* Retina Display Support */
        retina_detect: true
    });

});

//登录系统
function login() {
    var n = $('#tbUserName').val();
    var p = $('#tbPassword').val();
    var c = $('#verifiyCode').val();
    var s = 1;
    if ($("#radio-admin").is(':checked')) {
        s = 1;
    } else if ($("#radio-user").is(':checked')) {
        s = 2;
    }

    //检查姓名,密码,及vCode
    if ($.trim(n) == "") {
        layer.msg("请输入用户名", { icon: 0 });
        $('#tbUserName').focus();
        return false;
    }

    if ($("#radio-admin").is(':checked')) {
        if ($.trim(p) == "") {
            layer.msg("请输入密码", { icon: 0 });
            $('#tbPassword').focus();
            return false;
        }
    }

    if ($.trim(c) == "") {
        layer.msg("请输入随机验证码", { icon: 0 });
        $('#verifiyCode').focus();
        return false;
    }

    if (($("#verifiyCode").val()).toUpperCase() != CodeVal.toUpperCase()) {
        layer.msg("验证码错误", { icon: 0 });
        $('#verifiyCode').focus();
        return false;
    }


    setCookie("Home_UserName", n, 30);

    $('.page-loading-overlay').removeClass("loaded");

    var index = layer.load(1, {
        shade: [0.2, '#fff'] //0.1透明度的白色背景
    });


    //Manage

    $.ajax({
        type: 'post',
        url: "View/BaseManageHandler.ashx?tag=Login&random=" + Math.random(),
        dataType: "json",
        data: { userName: n, pwd: p, state: s },
        success: function (data, textStatus) {
            if (data == "0") {
                layer.msg('用户名或密码错误', { icon: 5 });
                Code();
            }
            else {
                setCookie("state", s, 30);
                window.location.href = "View/Home.aspx?state=" + s;
            }
            layer.close(index);
        },
        error: function (data) {
            layer.msg("登录出现错误:" + data.responseText, { icon: 5 });
            layer.close(index);
        }
    });
}

function Code() {
    if (canGetCookie == 1) {
        createCode("AdminCode");
        var AdminCode = getCookieValue("AdminCode");
        showCheck(AdminCode);
    } else {
        showCheck(createCode(""));
    }
}

var CodeVal;
function showCheck(a) {

    CodeVal = a;
    var c = document.getElementById("myCanvas");
    var ctx = c.getContext("2d");
    ctx.clearRect(0, 0, 1000, 1000);
    ctx.font = "80px 'Hiragino Sans GB'";
    ctx.fillStyle = "#0e0e0e";
    ctx.fillText(a, 0, 100);
}

//设置cookie值
function setCookie(NameOfCookie, value, expiredays) {
    //@参数:三个变量用来设置新的cookie:
    //cookie的名称,存储的Cookie值,
    // 以及Cookie过期的时间.
    // 这几行是把天数转换为合法的日期

    var ExpireDate = new Date();
    ExpireDate.setTime(ExpireDate.getTime() + (expiredays * 24 * 3600 * 1000));

    // 下面这行是用来存储cookie的,只需简单的为”document.cookie”赋值即可.
    // 注意日期通过toGMTstring()函数被转换成了GMT时间
    document.cookie = NameOfCookie + "=" + escape(value) + ((expiredays == null) ? "" : ";expires=" + ExpireDate.toGMTString());
}

///获取cookie值
function getCookie(NameOfCookie) {
    // 首先我们检查下cookie是否存在.
    // 如果不存在则document.cookie的长度为0
    if (document.cookie.length > 0) {
        // 接着我们检查下cookie的名字是否存在于document.cookie
        // 因为不止一个cookie值存储,所以即使document.cookie的长度不为0也不能保证我们想要的名字的cookie存在
        //所以我们需要这一步看看是否有我们想要的cookie
        //如果begin的变量值得到的是-1那么说明不存在
        begin = document.cookie.indexOf(NameOfCookie + "=");
        if (begin != -1) {
            // 说明存在我们的cookie.
            begin += NameOfCookie.length + 1; //cookie值的初始位置
            end = document.cookie.indexOf(";", begin); //结束位置
            if (end == -1) end = document.cookie.length; //没有;则end为字符串结束位置
            return unescape(document.cookie.substring(begin, end));
        }
    }
    return null;
    // cookie不存在返回null
}

///删除cookie
function delCookie(NameOfCookie) {
    // 该函数检查下cookie是否设置，如果设置了则将过期时间调到过去的时间;
    //剩下就交给操作系统适当时间清理cookie啦
    if (getCookie(NameOfCookie)) {
        document.cookie = NameOfCookie + "=" + "; expires=Thu, 01-Jan-70 00:00:01 GMT";
    }
}

function ToShow() {
    var id = $(this).attr("data-id");
    if (id) {
        window.location.href = "/Index.aspx?id=" + id;
    }
}