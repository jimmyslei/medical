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

        #region 登录
        public string Login(PersonModel person, int state)
        {
            string sql = string.Empty;
            if (state == 1)
            {
                sql = @"select count(1) from 用户表 where 用户名=@userName and 密码=@pwd";
            }
            else
            {
                sql = @"select count(1) from 人员信息表 where 编码=@userName";
            }
            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@userName",person.UserName){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@pwd",person.Pwd){SqlDbType=SqlDbType.NVarChar}
            };

            return ser.ExecuteScalar(sql, CommandType.Text, parmeter).ToString();
        }

        public string UpdatePwd(string userName, string newPwd)
        {
            string sql = @"update 用户表 set 密码=@pwd where 用户名=@userName";
            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@userName",userName){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@pwd",newPwd){SqlDbType=SqlDbType.NVarChar}
            };

            return ser.ExecuteNonquery(sql, CommandType.Text, parmeter).ToString();
        }

        #endregion

        #region 科室

        public DataTable GetDepList()
        {
            string sql = "select Id,[名称],[编码] from 科室表 where 标识=0";
            SqlParameter[] parmeter = new SqlParameter[] { };
            DataTable dt = ser.GetDataSet(sql, CommandType.Text, parmeter).Tables[0];
            if (dt != null)
            {
                return dt;
            }
            else
            {
                return null;
            }
        }

        public DataTable GetDepartmentList(int beginRow, int endRow)
        {
            string sql = @"select * from(
                select Id,[名称],[编码] ,[描述],[标识],ROW_NUMBER() over(order by id) as 序号 from 科室表 where 标识=0) a 
                where a.序号 between @beginRow and @endRow";

            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@beginRow",beginRow){SqlDbType=SqlDbType.Int},
                new SqlParameter("@endRow",endRow){SqlDbType=SqlDbType.Int}
            };
            DataTable dt = ser.GetDataSet(sql, CommandType.Text, parmeter).Tables[0];
            if (dt != null)
            {
                return dt;
            }
            else
            {
                return null;
            }
        }

        public string GetDepTotal()
        {
            string sql = "select count(1) from 科室表 where 标识=0";
            SqlParameter[] parmeter = new SqlParameter[] { };
            return ser.ExecuteScalar(sql, CommandType.Text, parmeter).ToString();
        }

        public string EditDepartment(DepartmentModel dep, int state)
        {
            string sql = string.Empty;
            if (state == 0)
            {
                sql = @"insert into 科室表(名称,[编码] ,[描述],标识) values(@name,@code,@remark,0)";
            }
            else if (state == 1)
            {
                sql = @"update 科室表 set 名称=@name,编码=@code,描述=@remark where Id=@Id ";
            }
            else if (state == -1)
            {
                sql = @"update 科室表 set 标识=-1 where Id=@Id ";
            }

            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@Id",dep.Id){SqlDbType=SqlDbType.Int},
                new SqlParameter("@name",dep.DepName){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@code",dep.DepCode){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@remark",dep.Remark){SqlDbType=SqlDbType.NVarChar}
            };

            return ser.ExecuteNonquery(sql, CommandType.Text, parmeter).ToString();
        }

        #endregion

        #region 人员
        /// <summary>
        /// 获取人员列表
        /// </summary>
        /// <returns></returns>
        public DataTable GetPersonList(int beginRow, int endRow)
        {
            string sql = @"select * from(
                select [ID]
                      ,[姓名]
                      ,[性别]
                      ,[编码]
                      ,CONVERT(varchar(60), 出生日期, 23) 出生日期
                      ,[身份证号]
                      ,[联系方式]
                      ,[住址]
                ,[标识],ROW_NUMBER() over(order by id) as 序号
                from 人员信息表 where 标识=0)a where a.序号 between @beginRow and @endRow";
            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@beginRow",beginRow){SqlDbType=SqlDbType.Int},
                new SqlParameter("@endRow",endRow){SqlDbType=SqlDbType.Int}
            };

            DataTable dt = ser.GetDataSet(sql, CommandType.Text, parmeter).Tables[0];
            if (dt != null)
            {
                return dt;
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
        public string GetPersonTotal()
        {
            string sql = "select count(1) from 人员信息表 where 标识=0";
            SqlParameter parmeter = new SqlParameter();

            var result = ser.ExecuteScalar(sql, CommandType.Text, parmeter);
            return result.ToString();
        }

        public string EditPerson(PersonModel per, int type)
        {
            string sql = string.Empty;
            //insert
            string userId = string.Empty;
            if (type == 0)
            {
                userId = Guid.NewGuid().ToString();
                sql = @"insert into 人员信息表([ID]
                      ,[姓名]
                      ,[性别]
                      ,[编码]
                      ,[出生日期]
                      ,[身份证号]
                      ,[联系方式]
                      ,[住址]
                      ,[标识]) values(@Id,@name,@sex,@code,@birth,@cardId,@phone,@address,0)";
            }
            else if (type == 1)//update
            {
                userId = per.Id;
                sql = @"update 人员信息表 set 姓名=@name
                      ,性别=@sex
                      ,编码=@code
                      ,出生日期=@birth
                      ,身份证号=@cardId
                      ,联系方式=@phone
                      ,住址=@address where Id=@Id";
            }
            else//delete
            {
                userId = per.Id;
                sql = "update 人员信息表 set 标识 =-1 where id=@Id";
                SqlParameter[] parmter = {
                    new SqlParameter("@Id",userId){SqlDbType=SqlDbType.NVarChar}
                };
                return ser.ExecuteNonquery(sql, CommandType.Text, parmter).ToString();
            }

            SqlParameter[] query = {
                new SqlParameter("@Id",userId){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@name",per.Name){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@sex",per.Sex){SqlDbType=SqlDbType.Int},
                new SqlParameter("@code",per.Code){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@birth",per.Birth){SqlDbType=SqlDbType.DateTime},
                new SqlParameter("@cardId",per.CardId){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@address",per.Address){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@phone",per.Phone){SqlDbType=SqlDbType.NVarChar}
            };

            return ser.ExecuteNonquery(sql, CommandType.Text, query).ToString();
        }
        #endregion

        #region 病人信息
        public DataTable GetHisPatientList(int beginRow, int endRow)
        {
            string sql = @"select * from(
                select [ID]
                  ,[姓名]
                  ,[性别]
                  ,[年龄]
                  ,[身份证号]
                  ,[联系方式]
                  ,[联系地址]
                  ,[婚姻状况]
                  ,[户籍地址]
                  ,[工作单位]
                  ,CONVERT(varchar(60), 登记时间, 20) 登记时间
                  ,[标识]
                  ,[编码]
                  ,[科室]
                  ,[科室id]
                ,[床位],ROW_NUMBER() over(order by ID) as 序号
                from His病人信息表 where 标识=0)a where a.序号 between @beginRow and @endRow";
            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@beginRow",beginRow){SqlDbType=SqlDbType.Int},
                new SqlParameter("@endRow",endRow){SqlDbType=SqlDbType.Int}
            };

            DataTable dt = ser.GetDataSet(sql, CommandType.Text, parmeter).Tables[0];
            if (dt != null)
            {
                return dt;
            }
            else
            {
                return null;
            }
        }

        public DataTable GetHisPatienInfoByCode(string code)
        {
            string sql = @"select [ID]
                  ,[姓名]
                  ,[性别]
                  ,[年龄]
                  ,[身份证号]
                  ,[联系方式]
                  ,[联系地址]
                  ,[婚姻状况]
                  ,[户籍地址]
                  ,[工作单位]
                  ,CONVERT(varchar(60), 登记时间, 20) 登记时间
                  ,[标识]
                  ,[编码]
                  ,[科室]
                  ,[科室id]
                  ,[床位]
                from His病人信息表 where 标识=0 and 编码=@code";
            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@code",code){SqlDbType=SqlDbType.NVarChar}
            };

            DataTable dt = ser.GetDataSet(sql, CommandType.Text, parmeter).Tables[0];
            if (dt != null)
            {
                return dt;
            }
            else
            {
                return null;
            }
        }

        public DataTable GetPatientList(int beginRow, int endRow)
        {
            string sql = @"select * from(
                select [ID]
                  ,[姓名]
                  ,[性别]
                  ,[编码]
                  ,[年龄]
                  ,[身份证号]
                  ,[联系方式]
                  ,[联系地址]
                  ,[婚姻状况]
                  ,[户籍地址]
                  ,[工作单位]
                  ,CONVERT(varchar(60), 登记时间, 20) 登记时间
                  ,[科室]
                  ,[科室Id]
                  ,[床位]
                  ,[标识],ROW_NUMBER() over(order by ID) as 序号
                from 病人信息表 where 标识!=-1)a where a.序号 between @beginRow and @endRow";
            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@beginRow",beginRow){SqlDbType=SqlDbType.Int},
                new SqlParameter("@endRow",endRow){SqlDbType=SqlDbType.Int}
            };

            DataTable dt = ser.GetDataSet(sql, CommandType.Text, parmeter).Tables[0];
            if (dt != null)
            {
                return dt;
            }
            else
            {
                return null;
            }
        }

        public DataTable GetPatInfoById(int Id)
        {
            string sql = @"select [ID]
                  ,[姓名]
                  ,[性别]
                  ,[编码]
                  ,[年龄]
                  ,[身份证号]
                  ,[联系方式]
                  ,[联系地址]
                  ,[婚姻状况]
                  ,[户籍地址]
                  ,[工作单位]
                  ,CONVERT(varchar(60), 登记时间, 20) 登记时间
                  ,[科室]
                  ,[科室Id]
                  ,[床位]
                  ,[标识],ROW_NUMBER() over(order by ID) as 序号
                from 病人信息表 where Id=@Id";

            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@Id",Id){SqlDbType=SqlDbType.Int}
            };

            DataTable dt = ser.GetDataSet(sql, CommandType.Text, parmeter).Tables[0];
            if (dt != null)
            {
                return dt;
            }
            else
            {
                return null;
            }
        }

        public string GetPatientCount()
        {
            string sql = "select count(1) from 病人信息表 where 标识!=-1";
            SqlParameter[] parmeter = new SqlParameter[] { };
            return ser.ExecuteScalar(sql, CommandType.Text, parmeter).ToString();
        }

        public string AddPatientInfo(PatientModel patien, int state)
        {
            string sql = string.Empty;
            if (state == 1)
            {
                sql = @"insert into 病人信息表(姓名
                      ,[性别]
                      ,[编码]
                      ,[年龄]
                      ,[身份证号]
                      ,[联系方式]
                      ,[联系地址]
                      ,[婚姻状况]
                      ,[户籍地址]
                      ,[工作单位]
                      ,[登记时间]
                      ,[科室]
                      ,[科室Id]
                      ,[床位]
                      ,标识) values(@name,@sex,@code,@age,@cardId,@phone,@address,@marry,@Haddress,@work,@time,@dep,@depId,@bedNo,0)";
            }
            else if (state == 2)
            {
                sql = @"update 病人信息表 set 姓名=@name
                      ,[性别]=@sex
                      ,[编码]=@code
                      ,[年龄]=@age
                      ,[身份证号]=@cardId
                      ,[联系方式]=@phone
                      ,[联系地址]=@address
                      ,[婚姻状况]=@marry
                      ,[户籍地址]=@Haddress
                      ,[工作单位]=@work
                      ,[登记时间]=@time
                      ,[科室]=@dep
                      ,[科室Id]=@depId
                      ,[床位]=@bedNo where Id=@Id ";
            }

            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@Id",patien.Id){SqlDbType=SqlDbType.Int},
                new SqlParameter("@name",patien.Name){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@sex",patien.Sex){SqlDbType=SqlDbType.Int},
                new SqlParameter("@code",patien.Code){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@age",patien.Age){SqlDbType=SqlDbType.Int},
                new SqlParameter("@cardId",patien.CardId){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@phone",patien.Phone){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@address",patien.NowAddress){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@marry",patien.Marry){SqlDbType=SqlDbType.Int},
                new SqlParameter("@Haddress",patien.Address){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@work",patien.Work){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@time",patien.InTime){SqlDbType=SqlDbType.DateTime},
                new SqlParameter("@dep",patien.depName){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@depId",patien.depCode){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@bedNo",patien.bedNo){SqlDbType=SqlDbType.NVarChar}
            };

            return ser.ExecuteNonquery(sql, CommandType.Text, parmeter).ToString();

        }

        public string DelPatient(int Id, int state)
        {
            string sql = string.Empty;
            if (state == -1)
            {
                sql = "update 病人信息表 set 标识=-1 where Id=@Id";
            }
            else if (state == 1)
            {
                sql = "update 病人信息表 set 标识=1 where Id=@Id";
            }

            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@Id",Id){SqlDbType=SqlDbType.Int}
            };

            return ser.ExecuteNonquery(sql, CommandType.Text, parmeter).ToString();
        }

        #endregion

        #region 评估
        public string EditAssess(int patId, string assItem, int assType, double score, int rank)
        {
            string sql = @"insert into 评估记录表(病人Id
                          ,[评估项目]
                          ,[评估类别]
                          ,[评估总分]
                          ,[评估日期]
                          ,等级) values(@painId,@asseItem,@asseType,@score,@time,@rank)";
            SqlParameter[] parmeter = new SqlParameter[] {
                new SqlParameter("@painId",patId){SqlDbType=SqlDbType.Int},
                new SqlParameter("@asseItem",assItem){SqlDbType=SqlDbType.NVarChar},
                new SqlParameter("@asseType",assType){SqlDbType=SqlDbType.Int},
                new SqlParameter("@score",score){SqlDbType=SqlDbType.Float},
                new SqlParameter("@time",DateTime.Now){SqlDbType=SqlDbType.DateTime},
                new SqlParameter("@rank",rank){SqlDbType=SqlDbType.Int}
            };

            return ser.ExecuteNonquery(sql, CommandType.Text, parmeter).ToString();
        }

        #endregion

    }
}
