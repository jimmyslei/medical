using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Web.Script.Serialization;

namespace Medical.Common
{
    /// <summary>
    /// string扩展方法
    /// </summary>
    public static class StringHelper
    {
        /// <summary>
        /// 判断字符串是否为空
        /// </summary>
        /// <param name="target"></param>
        /// <returns></returns>
        public static bool IsNullOrEmpty(this string target)
        {
            if (target == null || string.IsNullOrEmpty(target))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 将字符串中的格式项替换为指定数组中相应对应的字符串表示形式
        /// </summary>
        /// <param name="str"></param>
        /// <param name="parm"></param>
        /// <returns></returns>
        public static string Format(this string str, params string[] parm)
        {
            var rstr = string.Format(str, parm);
            return rstr;
        }

        /// <summary>
        /// 返回指定类型的时间格式
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="dateFormat"></param>
        /// <returns></returns>
        public static string ToDate(this DateTime? dt, string dateFormat)
        {
            return dt == null ? "" : ((DateTime)dt).ToString(dateFormat);
        }

        /// <summary>
        /// 空对象返回null，防止空引用异常
        /// </summary>
        /// <param name="obj"></param>
        /// <returns>空对象返回null</returns>
        public static string ToStringEX(this object obj)
        {
            return obj == null ? null : obj.ToString();
        }
        
        /// <summary>
        /// 将空字符串转换成null
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static string StringIsNull(this string str)
        {
            if (str != null)
            {
                if (str.Trim() == "")
                {
                    return null;
                }
            }
            return str;
        }

        /// <summary>
        /// 转为枚举类型
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static T ToEnum<T>(this string str)
        {
            return (T)Enum.Parse(typeof(T), str);
        }

        /// <summary>
        /// 将string转换成Time 如果是""则返回null
        /// </summary>
        /// <param name="Time">时间</param>
        /// <returns>处理后的时间</returns>
        public static DateTime? StringIsTime(this string time)
        {
            DateTime? dateTime = null;
            if (time != "" && time != null)//如果传入的时间不为空
                dateTime = DateTime.Parse(time.Trim());
            return dateTime;
        }

        /// <summary>
        /// 处理字符中的特殊符号，空对象返回''，防止在解析json字符串时出错。
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>       
        //public static string ToJsonString(this object s)
        //{
        //    return JsonHelper.JsonReplace(s.ToStringEX());
        //}

        /// <summary>
        /// 根据索引值获取键下的第一个值。一般用于获取前端序列化表单提交的数据
        /// </summary>
        /// <param name="c">数据集合</param>
        /// <param name="index">索引值</param>
        /// <returns></returns>
        public static string FirstValue(this NameValueCollection c, int index)
        {
            if (c.GetValues(index).Length > 0)
            {
                return c.GetValues(index)[0];
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 根据索引值获取键下的第一个值。一般用于获取前端序列化表单提交的数据
        /// </summary>
        /// <param name="c"></param>
        /// <param name="name">键名</param>
        /// <returns></returns>
        public static string FirstValue(this NameValueCollection c, string name)
        {
            if (c.GetValues(name) != null && c.GetValues(name).Length > 0)
            {
                return c.GetValues(name)[0];
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// NameValueCollection获取值
        /// </summary>
        /// <param name="collection"></param>
        /// <param name="name">键</param>
        /// <typeparam name="T">指定类型(int,int?,DateTime,DateTime?,long,long?,string)</typeparam>
        /// <returns></returns>
        public static T FirstValue<T>(this NameValueCollection collection, string name)
        {
            string val = collection.FirstValue(name);
            Type type = typeof(T);
            string typeString = type.ToString();
            object returnVal = null;

            #region 转换
            switch (typeString)
            {
                case "System.String":
                    returnVal = val;
                    break;
                case "System.Nullable`1[System.DateTime]":
                    DateTime dateNull;
                    if (DateTime.TryParse(val, out dateNull) == true)
                    {
                        returnVal = (DateTime?)dateNull;
                    }
                    break;
                case "System.DateTime":
                    DateTime date;
                    if (DateTime.TryParse(val, out date) == true)
                    {
                        returnVal = date;
                    }
                    else
                    {
                        throw new ArgumentException("无法转换为System.DateTime, val: " + val);
                    }
                    break;
                case "System.Int32":
                    int valInt;
                    if (int.TryParse(val, out valInt) == true)
                    {
                        returnVal = valInt;
                    }
                    else
                    {
                        throw new ArgumentException("无法转换为System.Int32, val: " + val);
                    }
                    break;
                case "System.Nullable`1[System.Int32]":
                    int valIntNull;
                    if (int.TryParse(val, out valIntNull) == true)
                    {
                        returnVal = (int?)valIntNull;
                    }
                    break;
                case "System.Int64":
                    long valLong;
                    if (long.TryParse(val, out valLong) == true)
                    {
                        returnVal = valLong;
                    }
                    else
                    {
                        throw new ArgumentException("无法转换为System.Int64, val: " + val);
                    }
                    break;
                case "System.Nullable`1[System.Int64]":
                    long valLongNull;
                    if (long.TryParse(val, out valLongNull) == true)
                    {
                        returnVal = valLongNull;
                    }
                    break;
                default:
                    throw new Exception("请添加类型并实现: " + typeString);
            }
            #endregion

            return (T)returnVal;
        }

        /// <summary>
        /// 根据索引值获取全部值已逗号隔开
        /// </summary>
        /// <param name="c"></param>
        /// <param name="name">键名</param>
        /// <returns></returns>
        public static string GetValue(this NameValueCollection c, string name)
        {
            if (c.GetValues(name) != null && c.GetValues(name).Length > 0)
            {
                string values = "";
                for (int i = 0; i < c.GetValues(name).Length; i++)
                {
                    values += c.GetValues(name)[i] + ",";
                }
                return values.Substring(0, values.Length - 1);
            }
            else
            {
                return null;
            }
        }

        /// <summary>
        /// 数组中是否含有指定值。匹配时忽略大小写。
        /// </summary>
        /// <param name="s"></param>
        /// <param name="value">要查找的值</param>
        /// <returns></returns>
        public static bool ContainValue(this string[] s, string value)
        {
            foreach (string v in s)
            {
                if (v.ToLower() == value.ToLower())
                {
                    return true;
                }
            }
            return false;
        }

        #region DateTime类扩展
        /// <summary>
        /// 按默认时间格式输出。长格式
        /// </summary>
        /// <param name="?"></param>
        /// <param name="format"></param>
        /// <returns></returns>
        public static string ToDefaultString1(this DateTime dt, string stringFormat = "yyyy年MM月dd日 HH:mm:ss")
        {
            return dt.ToString(stringFormat);
        }
        /// <summary>
        /// 按默认时间格式输出。短格式
        /// </summary>
        /// <param name="?"></param>
        /// <param name="format"></param>
        /// <returns></returns>
        public static string ToDefaultString2(this DateTime dt, string stringFormat = "yyyy年MM月dd日")
        {
            return dt.ToString(stringFormat);
        }

        /// <summary>
        /// 按默认时间格式输出。数据库格式
        /// </summary>
        /// <param name="?"></param>
        /// <param name="format"></param>
        /// <returns></returns>
        public static string ToDefaultString3(this DateTime dt, string stringFormat = "yyyy-MM-dd HH:mm:ss")
        {
            return dt.ToString(stringFormat);
        }

        /// <summary>
        /// 按默认时间格式输出。年月日格式
        /// </summary>
        /// <param name="?"></param>
        /// <param name="format"></param>
        /// <returns></returns>
        public static string ToDefaultString4(this DateTime dt, string stringFormat = "yyyy-MM-dd")
        {
            return dt.ToString(stringFormat);
        }

        /// <summary>
        /// 计算年龄
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="birthday">生日</param>
        /// <returns></returns>
        public static int GetAge(this DateTime dt, DateTime birthday)
        {
            return dt.Year - birthday.Year;
        }

        /// <summary>
        /// 获取时间当天的开始时间。即时分秒都为0
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static DateTime Start(this DateTime dt)
        {
            return new DateTime(dt.Year, dt.Month, dt.Day);
        }

        /// <summary>
        /// 获取时间当天的最后一刻时间。即时分秒为23:59:59
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static DateTime End(this DateTime dt)
        {
            return new DateTime(dt.Year, dt.Month, dt.Day, 23, 59, 59);
        }

        /// <summary>
        /// 时间转换成时间戳
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static long ToTimeStamp(this DateTime dt)
        {
            var utczero = new DateTime(1970, 1, 1);
            long rs = 0;
            if (dt <= new DateTime(1970, 1, 1))
            {

            }
            else
            {
                //rs = (DateTime.Now.ToUniversalTime().Ticks - 621355968000000000) / 10000000;
                rs = (long)(dt - utczero).TotalSeconds;

            }
            return rs;
        }

        /// <summary>
        /// 获取当前日期月份的第一天
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static DateTime GetFirstDateOfMonth(this DateTime dt)
        {
            return new DateTime(dt.Year, dt.Month, 1);
        }

        /// <summary>
        /// 获取当前日期月份的最后一天
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static DateTime GetLastDateOfMonth(this DateTime dt)
        {
            return dt.GetFirstDateOfMonth().AddMonths(1).AddDays(-1);
        }
        #endregion

        #region DataSet,DataTable类扩展

        /// <summary>
        /// 判断数据集是否含有数据。
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static bool HasData(this DataTable dt)
        {
            return dt.Rows.Count > 0 && dt.Columns.Count > 0;
        }

        /// <summary>
        ///使用[JavaScriptSerializer类]序列化成Json字符串。输出格式：[{字段名1:字段值1,字段名2:字段值2},{字段名1:字段值1,字段名2:字段值2}]；
        /// 字段名为DataTable中的列名，:字段值为每一行该列的值，字段名和字段值都为字符串格式
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="tableName">表名</param>
        /// <returns></returns>
        public static string ToJson(this DataTable dt)
        {
            //用JavaScriptSerializer类序列化
            JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
            javaScriptSerializer.MaxJsonLength = Int32.MaxValue; //取得最大数值
            ArrayList arrayList = new ArrayList();
            foreach (DataRow dataRow in dt.Rows)
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();  //实例化一个参数集合
                foreach (DataColumn dataColumn in dt.Columns)
                {
                    dictionary.Add(dataColumn.ColumnName, dataRow[dataColumn.ColumnName].ToString());
                }
                arrayList.Add(dictionary); //ArrayList集合中添加键值
            }
            return javaScriptSerializer.Serialize(arrayList); //返回一个json字符串

            #region 自己组装的json中含有影响json解析的字符时，在easyui控件中解析不出来，会直接进入onLoadError回调
            //StringBuilder sb = new StringBuilder();
            //var r = dt.Rows;    //引用行集合
            //var c = dt.Columns; //引用列集合
            //sb.Append("[");
            //for (int i = 0; i < r.Count; i++)
            //{
            //    sb.Append("{");
            //    for (int j = 0; j < c.Count; j++)
            //    {
            //        sb.Append(string.Format("\"{0}\":\"{1}\"", c[j].ColumnName, r[i][c[j].ColumnName]));
            //        if (j < c.Count - 1)
            //        {
            //            sb.Append(",");
            //        }
            //    }
            //    sb.Append("}");
            //    if (i < r.Count - 1)
            //    {
            //        sb.Append(",");
            //    }
            //}
            //sb.Append("]");
            //return sb.ToString(); 

            #endregion
        }
        /// <summary>
        /// 数据集中含有的表，且表中含有数据时返回true
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="tableName">表名</param>
        /// <returns></returns>
        public static bool HasData(this DataSet ds, string tableName)
        {
            return ds.Tables.Contains(tableName) && ds.Tables[tableName].HasData();
        }
        /// <summary>
        /// 返回表的首行首列
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static object GetScalar(this DataTable dt)
        {
            if (dt.HasData())
            {
                return dt.Rows[0][0];
            }
            else
            {
                return null;
            }
        }
        #endregion


        #region 泛型集合类扩展
        /// <summary>
        /// 给字典赋值，如果键已存在则覆盖原有的数据。避免因键已存在抛出异常
        /// </summary>
        /// <typeparam name="Tkey"></typeparam>
        /// <typeparam name="Tvalue"></typeparam>
        /// <param name="dic"></param>
        /// <param name="key"></param>
        /// <param name="value"></param>
        public static void SetValue<Tkey, Tvalue>(this Dictionary<Tkey, Tvalue> dic, Tkey key, Tvalue value)
        {
            if (dic.ContainsKey(key))
            {
                dic[key] = value;
            }
            else
            {
                dic.Add(key, value);
            }
        }

        /// <summary>
        /// 合并泛型数组。
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="arrayThis">当前数组</param>
        /// <param name="arrayToMerge">要合并的数组对象</param>
        /// <returns></returns>
        public static T[] MergeArray<T>(this T[] arrayThis, T[] arrayToMerge)
        {
            T[] newArray = new T[arrayThis.Length + arrayToMerge.Length];
            arrayThis.CopyTo(newArray, 0);
            arrayToMerge.CopyTo(newArray, arrayThis.Length);
            return newArray;
        }
        #endregion
    }
}
