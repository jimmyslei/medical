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
        //#region MD5加密
        ///// <summary>
        ///// MD5加密字符串
        ///// </summary>
        ///// <param name="str"></param>
        ///// <returns></returns>
        //public static string MD5(string str)
        //{
        //    return FormsAuthentication.HashPasswordForStoringInConfigFile(str, "MD5");
        //}
        //#endregion

        #region GuidID
        /// <summary>
        /// 生成新的Guid
        /// </summary>
        /// <returns></returns>
        public static string GuidID()
        {
            Guid guid = Guid.NewGuid();
            return guid.ToString("N");
        }

        /// <summary>
        /// 获取数据库的RAW类型字符串
        /// </summary>
        /// <returns></returns>
        public static string NewRawID()
        {
            Guid guid = Guid.NewGuid();
            return BitConverter.ToString(guid.ToByteArray()).Replace("-", "");
        }
        #endregion

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

        #region 获取文本真实长度（一个中文当两个英文）
        /// <summary>
        /// 获取文本真实长度（一个中文当两个英文）
        /// </summary>
        public static int StrLength(string str)
        {
            if (str == null)
            {
                return 0;
            }
            else
            {
                byte[] arr = Encoding.Default.GetBytes(str);
                return arr.Length;
            }
        }

        /// <summary>
        /// 根据实际字符长度截长度（按英文长度）
        /// </summary>
        /// <param name="str">输入的字符</param>
        /// <param name="length">最大输出字符长</param>
        /// <returns></returns>
        public static string StrSubstring(string str, int length)
        {
            if (str == null || str.Length == 0)
            {
                return "";
            }

            int oLen = StrLength(str);
            if (oLen < length)
            {
                return str;
            }

            StringBuilder sb = new StringBuilder();
            int sLen = str.Length;
            int count = 0;
            string s = null;

            for (int i = 0; i < sLen; i++)
            {
                s = str.Substring(i, 1);
                count += StrLength(s);
                sb.Append(s);

                if (count >= length)
                {
                    break;
                }
            }

            return sb.ToString();
        }
        #endregion

        #region IsInString 检查某个字符是否在一串字符串中
        /// <summary>
        /// 检查某字符是否在一串字符串中
        /// Spliter是分隔的符号（Char类型）
        /// 如：字符串格式 3,5,7,78,13
        /// </summary>
        public static bool IsInString(string val, string strs, char spliter)
        {
            if (strs == null || val == null)
            {
                return false;
            }

            bool b = false;
            string[] arr = strs.Split(spliter);
            int count = arr.Length;
            for (int i = 0; i < count; i++)
            {
                if (arr[i].Equals(val))
                {
                    b = true;
                    break;
                }
            }
            return b;
        }

        /// <summary>
        /// 判断值是否在字符串数组中存在
        /// </summary>
        /// <param name="val"></param>
        /// <param name="arr"></param>
        /// <returns></returns>
        public static bool IsInArray(string val, string[] arr)
        {
            if (arr == null || val == null)
            {
                return false;
            }

            bool b = false;
            int count = arr.Length;
            for (int i = 0; i < count; i++)
            {
                if (arr[i].Equals(val))
                {
                    b = true;
                    break;
                }
            }
            return b;
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

        #region 字符HTML编码
        /// <summary>
        /// HTML编码移除不符合标准的字符
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string RemoveChars(string str)
        {
            if (str == null || str.Length == 0)
            {
                return "";
            }

            str = Regex.Replace(str, "=", "");
            str = Regex.Replace(str, "'", "");
            str = Regex.Replace(str, ":", "");
            str = Regex.Replace(str, ",", "");
            str = Regex.Replace(str, "\"", "");
            str = Regex.Replace(str, @"\(", "");
            str = Regex.Replace(str, @"\)", "");
            str = Regex.Replace(str, @"\.", "");
            str = Regex.Replace(str, @"\?", "");
            str = Regex.Replace(str, @"\*", "");
            str = Regex.Replace(str, @"\[", "");
            str = Regex.Replace(str, @"\]", "");
            str = Regex.Replace(str, "$", "");
            str = Regex.Replace(str, "^", "");
            str = Regex.Replace(str, @"\\", "");
            str = Regex.Replace(str, "/", "");
            return str;
        }

        /// <summary>
        /// 使用HTML标准 更新SQL语句
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string SqlEncode(string str)
        {
            if (str == null || str.Length == 0)
            {
                return "";
            }

            str = Regex.Replace(str, "=", "%3D");
            str = Regex.Replace(str, "'", "''");
            str = Regex.Replace(str, "<", "");
            str = Regex.Replace(str, ">", "");
            str = Regex.Replace(str, @"\(", "");
            str = Regex.Replace(str, @"\)", "");

            return str;
        }

        /// <summary>
        /// HTML格式化字符串
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string HtmlEncode(string str)
        {
            if (str == null || str.Length == 0)
            {
                return "";
            }

            str = Regex.Replace(str, "&", "&amp;");
            str = Regex.Replace(str, "<", "&lt;");
            str = Regex.Replace(str, ">", "&gt;");
            str = Regex.Replace(str, "\"", "&quot;");
            str = Regex.Replace(str, " ", "&nbsp;");
            str = Regex.Replace(str, "\n", "<br />");
            str = str.Trim();

            return str;
        }

        /// <summary>
        /// 反序列化HTML字符串
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string HtmlDecode(string str)
        {
            if (str == null || str.Length == 0)
            {
                return "";
            }

            str = Regex.Replace(str, "&amp;", "&");
            str = Regex.Replace(str, "&lt;", "<");
            str = Regex.Replace(str, "&gt;", ">");
            str = Regex.Replace(str, "&quot;", "\"");
            str = Regex.Replace(str, "&nbsp;", " ");
            str = Regex.Replace(str, "<br />", "\n");

            return str;
        }
        #endregion

        #region 把字符串转换成日期类型
        /// <summary>
        /// 把字符串转换成日期类型
        /// </summary>
        /// <param name="datetime"></param>
        /// <returns></returns>
        public static DateTime ConverToDateTime(string datetime)
        {
            DateTime dt = DateTime.Now;

            if (Regex.IsMatch(datetime, @"^\d{4}-\d{1,2}-\d{1,2}$"))
            {
                string[] vals = datetime.Split('-');
                dt = new DateTime(int.Parse(vals[0]), int.Parse(vals[1]), int.Parse(vals[2]));
            }

            return dt;
        }
        #endregion

        #region 半角转全角的函数(SBC case)
        /// <summary>
        /// 半角转全角的函数(SBC case) 
        /// 全角空格为12288，半角空格为32 
        /// 其他字符半角(33-126)与全角(65281-65374)的对应关系是：均相差65248 
        /// </summary> 
        /// <param name="input">任意字符串</param> 
        /// <returns>全角字符串</returns> 
        public static string ToDBC(string input)
        {
            //半角转全角： 
            char[] c = input.ToCharArray();
            for (int i = 0; i < c.Length; i++)
            {
                if (c[i] == 32)
                {
                    c[i] = (char)12288;
                    continue;
                }
                if (c[i] < 127)
                    c[i] = (char)(c[i] + 65248);
            }
            return new string(c);
        }
        #endregion

        #region  全角转半角的函数(DBC case)
        /// <summary> 
        /// 全角转半角的函数(DBC case) 
        /// 全角空格为12288，半角空格为32 
        /// 其他字符半角(33-126)与全角(65281-65374)的对应关系是：均相差65248 
        /// </summary> 
        /// <param name="input">任意字符串</param> 
        /// <returns>半角字符串</returns>
        public static string ToSBC(string input)
        {
            char[] c = input.ToCharArray();
            for (int i = 0; i < c.Length; i++)
            {
                if (c[i] == 12288)
                {
                    c[i] = (char)32;
                    continue;
                }
                if (c[i] > 65280 && c[i] < 65375)
                    c[i] = (char)(c[i] - 65248);
            }
            return new string(c);
        }
        #endregion

        #region Oracle 的Hex与string转换
        /// <summary>
        /// Guid转Raw
        /// </summary>
        /// <param name="text"></param>
        /// <returns></returns>
        public static string GuidToRaw(string text)
        {
            Guid guid = new Guid(text);
            return BitConverter.ToString(guid.ToByteArray()).Replace("-", "");
        }

        /// <summary>
        /// Raw转Guid
        /// </summary>
        /// <param name="text"></param>
        /// <returns></returns>
        public static string RawToGuid(string text)
        {
            byte[] bytes = ParseHex(text);
            Guid guid = new Guid(bytes);
            return guid.ToString().ToUpperInvariant();
        }

        private static byte[] ParseHex(string text)
        {
            byte[] ret = new byte[text.Length / 2];
            for (int i = 0; i < ret.Length; i++)
            {
                ret[i] = Convert.ToByte(text.Substring(i * 2, 2), 16);
            }
            return ret;
        }
        #endregion

        #region 将Byte[]转16进制字符串
        /// <summary>
        /// 将Byte[]转16进制字符串
        /// 也是Raw转字符串的方法
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static string RawToHexString(byte[] data)
        {
            var val = string.Empty;
            if (data != null)
            {
                var len = data.Length;
                foreach (byte b in data)
                {
                    val += b.ToString("X2");
                }
            }

            return val;
        }
        #endregion

        #region 字符转拼音
        /// <summary>
        /// 汉字转拼音
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string GetPYString(string str)
        {
            string tempStr = "";
            foreach (char c in str)
            {
                if ((int)c >= 33 && (int)c <= 126)
                {//字母和符号原样保留           
                    tempStr += c.ToString();
                }
                else
                {//累加拼音声母     
                    tempStr += GetPYChar(c.ToString());
                }
            }
            return tempStr;
        }

        /// <summary>
        /// /// 取单个字符的拼音声母/// Code By
        /// /// 2004-11-30/// </summary>/// <param name="c">要转换的单个汉字</param>
        /// /// <returns>拼音声母</returns>
        private static string GetPYChar(string c)
        {
            byte[] array = new byte[2];
            array = System.Text.Encoding.Default.GetBytes(c);
            int i = (short)(array[0] - '\0') * 256 + ((short)(array[1] - '\0'));
            if (i < 0xB0A1) return "*";
            if (i < 0xB0C5) return "a";
            if (i < 0xB2C1) return "b";
            if (i < 0xB4EE) return "c";
            if (i < 0xB6EA) return "d";
            if (i < 0xB7A2) return "e";
            if (i < 0xB8C1) return "f";
            if (i < 0xB9FE) return "g";
            if (i < 0xBBF7) return "h";
            if (i < 0xBFA6) return "g";
            if (i < 0xC0AC) return "k";
            if (i < 0xC2E8) return "l";
            if (i < 0xC4C3) return "m";
            if (i < 0xC5B6) return "n";
            if (i < 0xC5BE) return "o";
            if (i < 0xC6DA) return "p";
            if (i < 0xC8BB) return "q";
            if (i < 0xC8F6) return "r";
            if (i < 0xCBFA) return "s";
            if (i < 0xCDDA) return "t";
            if (i < 0xCEF4) return "w";
            if (i < 0xD1B9) return "x";
            if (i < 0xD4D1) return "y";
            if (i < 0xD7FA) return "z";
            return "*";
        }

        #endregion

        #region 字符串压缩及解压方法
        /// <summary>
        /// 字符串压缩
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static byte[] Compress(byte[] data)
        {
            try
            {
                MemoryStream ms = new MemoryStream();
                GZipStream zip = new GZipStream(ms, CompressionMode.Compress, true);
                zip.Write(data, 0, data.Length);
                zip.Close();
                byte[] buffer = new byte[ms.Length];
                ms.Position = 0;
                ms.Read(buffer, 0, buffer.Length);
                ms.Close();
                return buffer;

            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        /// <summary>
        /// 字符串解压缩
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public static byte[] Decompress(byte[] data)
        {
            try
            {
                MemoryStream ms = new MemoryStream(data);
                GZipStream zip = new GZipStream(ms, CompressionMode.Decompress, true);
                MemoryStream msreader = new MemoryStream();
                byte[] buffer = new byte[0x1000];
                while (true)
                {
                    int reader = zip.Read(buffer, 0, buffer.Length);
                    if (reader <= 0)
                    {
                        break;
                    }
                    msreader.Write(buffer, 0, reader);
                }
                zip.Close();
                ms.Close();
                msreader.Position = 0;
                buffer = msreader.ToArray();
                msreader.Close();
                return buffer;
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        /// <summary>
        /// 字符串压缩
        /// </summary>
        /// <param name="str">需要压缩的字符串</param>
        /// <returns></returns>
        public static string CompressString(string str)
        {
            string compressString = "";
            byte[] compressBeforeByte = Encoding.GetEncoding("UTF-8").GetBytes(str);
            byte[] compressAfterByte = Compress(compressBeforeByte);
            //compressString = Encoding.GetEncoding("UTF-8").GetString(compressAfterByte);  
            compressString = Convert.ToBase64String(compressAfterByte);
            return compressString;
        }

        /// <summary>
        /// 压缩字符串解压缩
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string DecompressString(string str)
        {
            string compressString = "";
            //byte[] compressBeforeByte = Encoding.GetEncoding("UTF-8").GetBytes(str);  
            byte[] compressBeforeByte = Convert.FromBase64String(str);
            byte[] compressAfterByte = Decompress(compressBeforeByte);
            compressString = Encoding.GetEncoding("UTF-8").GetString(compressAfterByte);
            return compressString;
        }
        #endregion

        #region DataTable与XML字符串互相转换方法
        /// <summary>
        /// DataTable转成对应的Xml字符串
        /// </summary>
        /// <param name="xmlDS"></param>
        /// <param name="TableName">表名称</param>
        /// <returns></returns>
        public static string ConvertDataTableToXML(DataTable xmlDS, string TableName)
        {
            MemoryStream stream = null;
            XmlTextWriter writer = null;
            try
            {
                stream = new MemoryStream();
                writer = new XmlTextWriter(stream, Encoding.UTF8);
                xmlDS.TableName = TableName;
                xmlDS.WriteXml(writer);
                int count = (int)stream.Length;
                byte[] arr = new byte[count];
                stream.Seek(0, SeekOrigin.Begin);
                stream.Read(arr, 0, count);
                UTF8Encoding utf = new UTF8Encoding();

                var content = utf.GetString(arr).Trim();
                //转换成功后,可能出现第一位不是<的字符,用眼睛看不出来.
                if (content.Substring(0, 1) != "<")
                {
                    content = content.Substring(1, content.Length - 1);
                }

                return content;
            }
            catch (Exception)
            {
                return string.Empty;
            }
            finally
            {
                if (writer != null) writer.Close();
            }
        }

        /// <summary>
        /// DataTable转成对应的Xml字符串
        /// </summary>
        /// <param name="xmlDS"></param>
        /// <returns></returns>
        public static string ConvertDataTableToXML(DataTable xmlDS)
        {
            MemoryStream stream = null;
            XmlTextWriter writer = null;
            try
            {
                stream = new MemoryStream();
                writer = new XmlTextWriter(stream, Encoding.Default);
                xmlDS.WriteXml(writer);
                int count = (int)stream.Length;
                byte[] arr = new byte[count];
                stream.Seek(0, SeekOrigin.Begin);
                stream.Read(arr, 0, count);
                Encoding.Default.GetString(arr).Trim();
                //UTF8Encoding utf = new UTF8Encoding();
                return Encoding.Default.GetString(arr).Trim(); ;
            }
            catch (Exception)
            {
                return string.Empty;
            }
            finally
            {
                if (writer != null) writer.Close();
            }
        }

        /// <summary>
        /// Xml字符串转对应的DataSet 
        /// </summary>
        /// <param name="xmlData"></param>
        /// <returns></returns>
        public static DataSet ConvertXMLToDataSet(string xmlData)
        {
            StringReader stream = null;
            XmlTextReader reader = null;
            try
            {
                DataSet xmlDS = new DataSet();
                stream = new StringReader(xmlData);
                reader = new XmlTextReader(stream);
                xmlDS.ReadXml(reader);
                return xmlDS;
            }
            catch (Exception ex)
            {
                string strTest = ex.Message;
                return null;
            }
            finally
            {
                if (reader != null)
                    reader.Close();
            }
        }

        /// <summary>
        /// XML字符串转对应的DataTable如果转换后存在多个DataTable只返回第一个Table
        /// </summary>
        /// <param name="xmlData"></param>
        /// <returns></returns>
        public static DataTable ConvertXMLToDataTable(string xmlData)
        {
            StringReader stream = null;
            XmlTextReader reader = null;
            try
            {
                DataSet xmlDS = new DataSet();
                stream = new StringReader(xmlData);
                reader = new XmlTextReader(stream);
                xmlDS.ReadXml(reader);
                if (xmlDS != null && xmlDS.Tables.Count > 0)
                {
                    return xmlDS.Tables[0];
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                string strTest = ex.Message;
                return null;
            }
            finally
            {
                if (reader != null)
                    reader.Close();
            }
        }
        #endregion


        /// <summary>
        /// 使用newtonsoft转为对象
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="json"></param>
        /// <returns></returns>
        public static T JsonToObject1<T>(string json)
        {
            return Newtonsoft.Json.JsonConvert.DeserializeObject<T>(json);
        }
    }
}
