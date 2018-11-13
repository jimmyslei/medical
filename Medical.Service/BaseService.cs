using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using Yun.DataService;
using Medical.Model;

namespace Medical.Service
{
    public class BaseService
    {
        DataService ser = new DataService();

        #region 科室

        public DataSet GetDepartmentList()
        {
            string sql = "select * from 科室表";
            SqlParameter parmenter = new SqlParameter();
            DataSet ds = ser.GetDataSet(sql, CommandType.Text, parmenter);
            return ds;
        }

        #endregion

        #region 人员
        /// <summary>
        /// 获取人员列表
        /// </summary>
        /// <returns></returns>
        public DataTable GetPaintList(int beginRow, int endRow)
        {
            string sql = @"select * from(
                select u.id, u.用户名,i.姓名,i.性别,i.联系方式,i.身份证号,ROW_NUMBER() over(order by u.id) as 序号
                from 用户表 u,人员信息表 i where i.ID = u.人员ID)a where a.序号 between @beginRow and @endRow";
            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@beginRow",beginRow){SqlDbType=SqlDbType.Int},
                new SqlParameter("@endRow",endRow){SqlDbType=SqlDbType.Int}
            };

            DataSet ds = ser.GetDataSet(sql, CommandType.Text, parmeter);
            if (ds.Tables[0] != null)
            {
                return ds.Tables[0];
            }
            else
            {
                return null;
            }

        }

        /// <summary>
        /// 获取人员总数
        /// </summary>
        /// <returns></returns>
        public string GetPaintTotal()
        {
            string sql = "select count(1) from 用户表 u,人员信息表 i where i.ID = u.人员ID";
            SqlParameter parmeter = new SqlParameter();

            var result = ser.ExecuteScalar(sql, CommandType.Text, parmeter);
            return result.ToString();
        }

        public string EditPaint(PersonModel per, int type)
        {
            string sql = string.Empty;
            //insert
            if (type == 0)
            {
                sql = "insert into 人员信息表 values()";
            }
            else if (type == 1)//update
            {
                sql = "update 人员信息表 u set ";
            }
            else//delete
            {
                sql = "delete from 人员信息表 u where u.id=@uid";
            }

            SqlParameter[] query = {
                new SqlParameter(),
                new SqlParameter()
            };

            var result = ser.ExecuteScalar(sql, CommandType.Text, query);
            if (result == null)
            {
                return "";
            }
            return "1";

        }
        #endregion


    }
}
