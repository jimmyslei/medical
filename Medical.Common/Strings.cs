using System.Web.Security;
using System;
using System.Web;
using System.Text.RegularExpressions;
using System.Text;
using System.Data;
using System.IO;
using System.Xml;
using System.IO.Compression;

namespace Medical.Common
{
    /// <summary>
    /// 字符串帮助类
    /// </summary>
    public class Strings
    {

        #region 从地址栏获取Id值（整数）
        /// <summary>
        /// 从HTTP URL获取数字值
        /// </summary>
        /// <param name="Key">HTTP URL 的参数名</param>
        /// <returns></returns>
        public static int GetIdFromUrl(string Key)
        {
            int _keyid = 0;
            string keyid = HttpContext.Current.Request.QueryString[Key];
            if (keyid != null && keyid.Length > 0)
            {
                if (IsNumber(keyid))
                {
                    _keyid = int.Parse(keyid);
                }
                else
                {
                    _keyid = 0;
                }
            }
            return _keyid;
        }

        #endregion

        #region 从Form栏获取Id值（整数）
        /// <summary>
        /// 从网页提交的表单 Form 获取数字
        /// </summary>
        /// <param name="Key">Form表单的参数名</param>
        /// <returns></returns>
        public static int GetIdFromForm(string Key)
        {
            int _keyid = 0;
            string keyid = HttpContext.Current.Request.Form[Key];
            if (keyid != null && keyid.Length > 0)
            {
                if (IsNumber(keyid) == true)
                {
                    _keyid = int.Parse(keyid);
                }
                else
                {
                    _keyid = 0;
                }
            }
            return _keyid;
        }
        #endregion

        #region 从地址栏获取值（字符串）
        /// <summary>
        /// 增加
        ///     从URL栏获取值(字符串)
        /// </summary>
        public static string GetValueFromUrl(string key)
        {
            string keyvalue = HttpContext.Current.Request.QueryString[key];
            if (keyvalue != null)
            {
                return System.Web.HttpUtility.UrlDecode(keyvalue); ;
            }
            return "";
        }

        /// <summary>
        /// 从URL地址栏获取值
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="key"></param>
        /// <returns></returns>
        public static T GetValueFormUrl<T>(string key) where T : IConvertible
        {
            var obj = default(T);

            if (key.IsNullOrEmpty())
            {
                return obj;
            }

            string keyvalue = HttpContext.Current.Request.QueryString[key];

            try
            {
                //URL字符串解码
                keyvalue = System.Web.HttpUtility.UrlDecode(keyvalue);
            }
            catch
            {

            }

            if (keyvalue.IsNullOrEmpty())
            {
                return obj;
            }

            var _type = obj.GetType();
            try
            {
                return (T)Convert.ChangeType(obj, _type);
            }
            catch (Exception)
            {
                return obj;
            }
        }
        #endregion

        #region 从Form栏获取值(字符串)
        /// <summary>
        /// 增加
        ///     从Form栏获取值(字符串)
        /// </summary>
        public static string GetValueFromForm(string Key)
        {
            string keyvalue = HttpContext.Current.Request.Form[Key];
            if (keyvalue != null)
            {
                return System.Web.HttpUtility.UrlDecode(keyvalue);
            }
            return "";
        }

        /// <summary>
        /// 从Form栏获取字符串并转换对应的格式数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="Key"></param>
        /// <returns></returns>
        public static T GetValueFromForm<T>(string Key) where T : IConvertible
        {
            //StringConvert
            var obj = default(T);

            if (Key.IsNullOrEmpty())
            {
                return obj;
            }

            string keyvalue = HttpContext.Current.Request.Form[Key];
            try
            {
                //URL字符串解码
                keyvalue = System.Web.HttpUtility.UrlDecode(keyvalue);
            }
            catch
            {

            }

            if (keyvalue.IsNullOrEmpty())
            {
                return obj;
            }

            var _type = obj.GetType();
            try
            {
                return (T)Convert.ChangeType(keyvalue, _type);
            }
            catch (Exception)
            {
                return obj;
            }
        }

        /// <summary>
        /// 从Form表单中获取对应模型的数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public static T GetValueFromForm<T>() where T : new()
        {
            var obj = default(T);

            var properties = new T().GetType().GetProperties();
            var model = new T();
            foreach (var p in properties)
            {
                string pptypeName = p.Name;
                string keyvalue = HttpContext.Current.Request.Form[pptypeName];
                try
                {
                    //URL字符串解码
                    keyvalue = System.Web.HttpUtility.UrlDecode(keyvalue);
                    p.SetValue(model, Convert.ChangeType(keyvalue, p.PropertyType), null);
                }
                catch
                {

                }
            }
            return model;
        }
        #endregion
        
        #region 检查是否满足某种正则表达式
        /// <summary>
        /// 检查是否满足某种正则表达式
        /// </summary>
        public static bool IsRegexMatch(string str, string Express)
        {
            if (string.IsNullOrEmpty(str))
            {
                return false;
            }

            return Regex.IsMatch(str, Express);
        }

        /// <summary>
        /// 检查目标字符串是否是数字形式
        /// </summary>
        public static bool IsNumber(string str)
        {
            return IsRegexMatch(str, @"^\d+$");
        }

        /// <summary>
        /// 检查字符串是否为数字集合
        /// 如 3,4,5,7
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static bool IsNumberArray(string str)
        {
            return IsRegexMatch(str, @"^(\d+)(,\d+)*$");
        }

        /// <summary>
        /// 检查字符串是否为字符串集合（仅为数字和字母）
        /// 如 erv34,dfg23,45fdf,r_t5
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static bool IsStringArray(string str)
        {
            return IsRegexMatch(str, @"^([a-zA-Z0-9_]+)(,[a-zA-Z0-9_]+)*$");
        }

        /// <summary>
        /// 判断是否为邮箱地址
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static bool IsEmail(string str)
        {
            return IsRegexMatch(str, @"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");
        }
        #endregion

    }
}
