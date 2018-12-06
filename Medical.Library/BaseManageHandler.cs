using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Medical.Common;
using Medical.Model;
using Medical.Logic;
using System.Data;

namespace Medical.Library
{
    public class BaseManageHandler : IHttpHandler
    {
        BaseLogic bases = new BaseLogic();
        public void ProcessRequest(HttpContext context)
        {

            string rstr = string.Empty;
            string tag = context.Request.QueryString["tag"];

            if (!tag.IsNullOrEmpty())
            {
                switch (tag)
                {
                    case "Login":
                        rstr = Login(context);
                        break;
                    case "UpdatePwd":
                        rstr = UpdatePwd(context);
                        break;
                    case "GetDepList":
                        rstr = GetDepList(context);
                        break;
                    case "GetDepartmentList":
                        rstr = GetDepartmentList(context);
                        break;
                    case "EditDepartment":
                        rstr = EditDepartment(context);
                        break;
                    case "GetPersonList":
                        rstr = GetPersonList(context);
                        break;
                    case "GetPersonTotal":
                        rstr = GetPersonTotal(context);
                        break;
                    case "EditPerson":
                        rstr = EditPerson(context);
                        break;
                    case "GetHisPatientList":
                        rstr = GetHisPatientList(context);
                        break;
                    case "GetHisPatienInfoByCode":
                        rstr = GetHisPatienInfoByCode(context);
                        break;
                    case "GetPatientList":
                        rstr = GetPatientList(context);
                        break;
                    case "AddPatientInfo":
                        rstr = AddPatientInfo(context);
                        break;
                    case "DelPatient":
                        rstr = DelPatient(context);
                        break;
                    default:
                        rstr = "tag方法未在定义范围内！";
                        break;
                }
            }
            else
            {
                rstr = "缺少操作参数tag";
                // SystemLog.Error("请求参数中未传入[tag]，请求无法继续！");
            }

            context.Response.Clear();
            context.Response.ContentType = "text/xml";
            context.Response.Write(rstr);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }



        private string Login(HttpContext context)
        {
            var userName = context.Request["userName"];
            var pwd = context.Request["pwd"];
            var state = Convert.ToInt32(context.Request["state"]);

            PersonModel person = new PersonModel();
            person.UserName = userName;
            person.Pwd = pwd;
            
            return bases.Login(person, state);
        }
        
        private string UpdatePwd(HttpContext context)
        {
            var userName = context.Request["userName"];
            var pwd = context.Request["pwd"];
            var pwdok = context.Request["pwdok"];

            if (pwd!= pwdok)
            {
                return "确认密码与新密码不同";
            }

            return bases.UpdatePwd(userName, pwd);
        }


        private string GetDepList(HttpContext context)
        {
            return  bases.GetDepList().ToJson();
        }

        private string GetDepartmentList(HttpContext context)
        {
            int pageIndex = !string.IsNullOrEmpty(context.Request["pageIndex"]) ? Convert.ToInt32(context.Request["pageIndex"]) : 0;
            int pageSize = !string.IsNullOrEmpty(context.Request["pageSize"]) ? Convert.ToInt32(context.Request["pageSize"]) : 0;

            var result = bases.GetDepartmentList(pageIndex, pageSize);

            var dataJson = result.ToJson();
            var total = Convert.ToInt32(bases.GetDepTotal());
            var pageCount = (total % pageSize) == 0 ? (total / pageSize) : (total / pageSize) + 1;

            return "{" + "\"dataList\":" + dataJson + "," +
                  "\"records\":" + total + "," +
                  "\"page\":" + pageIndex + "," +
                  "\"total\":" + pageCount + "}";
        }

        private string EditDepartment(HttpContext context)
        {
            var state = Convert.ToInt32(context.Request["state"]);
            var Id = context.Request["Id"] == "" ? null : context.Request["Id"];
            var name = context.Request["name"];
            var code = context.Request["code"];
            var remark = context.Request["remark"];

            DepartmentModel dep = new DepartmentModel();
            dep.Id = Convert.ToInt32(Id);
            dep.DepCode = code;
            dep.DepName = name;
            dep.Remark = remark;

            return bases.EditDepartment(dep, state);
        }


        private string GetPersonList(HttpContext context)
        {
            int pageIndex = !string.IsNullOrEmpty(context.Request["pageIndex"]) ? Convert.ToInt32(context.Request["pageIndex"]) : 0;
            int pageSize = !string.IsNullOrEmpty(context.Request["pageSize"]) ? Convert.ToInt32(context.Request["pageSize"]) : 0;

            var result = bases.GetPersonList(pageIndex, pageSize);

            var dataJson = result.ToJson();
            var total = Convert.ToInt32(bases.GetPersonTotal());
            var pageCount = (total % pageSize) == 0 ? (total / pageSize) : (total / pageSize) + 1;

            return "{" + "\"dataList\":" + dataJson + "," +
                  "\"totalCount\":" + total + "," +
                  "\"currPage\":" + pageIndex + "," +
                  "\"totalPage\":" + pageCount + "}";
        }

        private string GetPersonTotal(HttpContext context)
        {
            return bases.GetPersonTotal();
        }

        /// <summary>
        /// 编辑人员
        /// </summary>
        /// <param name="per"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        private string EditPerson(HttpContext context)
        {
            var state = Convert.ToInt32(context.Request["state"]);
            var Id = context.Request["Id"];
            var name = context.Request["name"];
            var sex = context.Request["sex"];
            var code = context.Request["code"];
            var birth = context.Request["birth"];
            var phone = context.Request["phone"];
            var address = context.Request["address"];
            var idCard = context.Request["idCard"];
            var userName = context.Request["userName"];
            var pwd = context.Request["pwd"];

            PersonModel person = new PersonModel();
            person.Id = Id;
            person.Name = name;
            person.Sex = Convert.ToInt32(sex);
            person.Code = code;
            person.Phone = phone;
            person.Address = address;
            person.Birth = Convert.ToDateTime(birth);
            person.CardId = idCard;
            person.UserName = userName;
            person.Pwd = pwd;

            return bases.EditPerson(person, state);
        }

        private string GetHisPatientList(HttpContext context)
        {
            int pageIndex = !string.IsNullOrEmpty(context.Request["pageIndex"]) ? Convert.ToInt32(context.Request["pageIndex"]) : 0;
            int pageSize = !string.IsNullOrEmpty(context.Request["pageSize"]) ? Convert.ToInt32(context.Request["pageSize"]) : 0;

            var result = bases.GetHisPatientList(pageIndex, pageSize);

            var dataJson = result.ToJson();
            var total = Convert.ToInt32(bases.GetPatientCount());
            var pageCount = (total % pageSize) == 0 ? (total / pageSize) : (total / pageSize) + 1;

            return "{" + "\"dataList\":" + dataJson + "," +
                  "\"records\":" + total + "," +
                  "\"page\":" + pageIndex + "," +
                  "\"total\":" + pageCount + "}";
        }

        private string GetHisPatienInfoByCode(HttpContext context)
        {
            var code = context.Request["code"];
            var result = bases.GetHisPatienInfoByCode(code);
            return result.ToJson();
        }

        /// <summary>
        /// 获取病人列表
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        private string GetPatientList(HttpContext context)
        {
            int pageIndex = !string.IsNullOrEmpty(context.Request["pageIndex"]) ? Convert.ToInt32(context.Request["pageIndex"]) : 0;
            int pageSize = !string.IsNullOrEmpty(context.Request["pageSize"]) ? Convert.ToInt32(context.Request["pageSize"]) : 0;

            var result = bases.GetPatientList(pageIndex, pageSize);

            var dataJson = result.ToJson();
            var total = Convert.ToInt32(bases.GetPatientCount());
            var pageCount = (total % pageSize) == 0 ? (total / pageSize) : (total / pageSize) + 1;

            return "{" + "\"dataList\":" + dataJson + "," +
                  "\"records\":" + total + "," +
                  "\"page\":" + pageIndex + "," +
                  "\"total\":" + pageCount + "}";
        }

        private string AddPatientInfo(HttpContext context)
        {
            var state = Convert.ToInt32(context.Request["state"]);
            var Id = context.Request["Id"];
            var name = context.Request["name"];
            var sex = context.Request["sex"];
            var code = context.Request["code"];
            var phone = context.Request["phone"];
            var cardId = context.Request["cardId"];
            var age = context.Request["age"] == "" ? null: context.Request["age"];
            var work = context.Request["work"];
            var inTime = context.Request["inTime"];
            var nowAddress = context.Request["nowAddress"];
            var address = context.Request["address"];
            var marry = context.Request["marry"];
            var depName = context.Request["depName"];
            var dep = context.Request["dep"];
            var badNo = context.Request["badno"];

            PatientModel patien = new PatientModel();
            patien.Id = Convert.ToInt32(Id);
            patien.Name = name;
            patien.Sex = Convert.ToInt32(sex);
            patien.Code = code;
            patien.Phone = phone;
            patien.CardId = cardId;
            patien.Age = Convert.ToInt32(age);
            patien.InTime= Convert.ToDateTime(inTime);
            patien.NowAddress = nowAddress;
            patien.Address = address;
            patien.Marry = Convert.ToInt32(marry);
            patien.Work = work;
            patien.bedNo = badNo;
            patien.depCode = dep;
            patien.depName = depName;

            return bases.AddPatientInfo(patien, state);
        }

        private string DelPatient(HttpContext context)
        {
            var Id =Convert.ToInt32(context.Request["Id"]);
            var state = Convert.ToInt32(context.Request["state"]);
            return bases.DelPatient(Id, state);
        }  

    }
}
