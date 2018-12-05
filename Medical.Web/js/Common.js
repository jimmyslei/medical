var comFn = {
    Ajax: function (url, data, successFn, errorFn, IsAsync, subType, dType) {
        $.ajax({
            type: subType ? subType : "post",
            url: url,
            data: data,
            dataType: dType ? dType : "Json",
            async: IsAsync == false ? false : true,
            success: function (data) {
                if (successFn) {
                    successFn(data);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                if (errorFn) {
                    errorFn(XMLHttpRequest, textStatus, errorThrown);
                }
            }
        });
    },
    //获取URL中的参数
    getQueryString: function (key) {
        var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
        var result = window.location.search.substr(1).match(reg);
        return result ? decodeURIComponent(result[2]) : null;
    },
    //获取form表单值
    getFromVal: function () {
        var data = {};
        //输入框
        $("input[type=text][cName]").each(function () {
            var cName = $(this).attr("cName");
            if (cName) {
                data[cName] = $(this).val();
            } else {
                console.log("获取input输入框数据发生错误");
            }
        });
        //密码框
        $("input[type = password][cName]").each(function () {
            var cName = $(this).attr("cName");
            if (cName) {
                data[cName] = $(this).val();
            } else {
                console.log("获取input密码框数据发生错误");
            }
        });
        //下拉框
        $('select[cName]').each(function () {
            var cName = $(this).attr("cName");
            var strId = $(this).attr("id");
            if (cName) {
                data[cName] = $("#" + strId).val();
            } else {
                console.log("获取select下拉数据发生错误");
            }
        });
        //复选框
        $('input[type=checkbox][cName]').each(function () {
            var cName = $(this).attr("cName");
            var _value = data[cName];
            if ($(this).is(":checked")) {
                if (_value) {
                    data[cName] = _value + "," + $(this).val();
                }
                else {
                    data[cName] = $(this).val();
                }
            }
            else {
                if (!_value) {
                    data[cName] = "";
                }
            }
        });
        //单选
        $('input[type=radio][cName]:checked').each(function () {
            var cName = $(this).attr("cName");
            data[cName] = $(this).val();
        });
        //多行文本
        $('input[type=textarea]').each(function () {
            var cName = $(this).attr("cName");
            data[cName] = $(this).val();
        })

        return data;
    },
    newGuid() {
        var guid = "";
        for (var i = 1; i <= 32; i++) {
            var n = Math.floor(Math.random() * 16.0).toString(16);
            guid += n;
            if ((i == 8) || (i == 12) || (i == 16) || (i == 20))
                guid += "-";
        }
        return guid;
    }
}

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

function getCookie(NameOfCookie) {
    // 首先我们检查下cookie是否存在.
    // 如果不存在则document.cookie的长度为0
    if (document.cookie.length > 0) {
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