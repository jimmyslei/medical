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
        
        #region DataSet,DataTable类扩展
        
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
       
        #endregion
        
    }
}
