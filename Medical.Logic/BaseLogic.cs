using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Medical.Service;
using Medical.Model;
using System.Data;

namespace Medical.Logic
{
    public class BaseLogic
    {
        BaseService service = new BaseService();

        #region 登录
        public string Login(PersonModel person, int state)
        {
            return service.Login(person, state);
        }

        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="newPwd"></param>
        /// <returns></returns>
        public string UpdatePwd(string userName, string newPwd)
        {
            return service.UpdatePwd(userName, newPwd);
        }

        #endregion

        #region 科室

        public DataTable GetDepList()
        {
            return service.GetDepList();
        }

        public DataTable GetDepartmentList(int pageIndex, int pageSize)
        {
            int startRow = 0, endRow = 0;
            startRow = (pageIndex - 1) * pageSize + 1;
            endRow = pageIndex * pageSize;
            return service.GetDepartmentList(startRow, endRow);
        }

        public string GetDepTotal()
        {
            return service.GetDepTotal();
        }

        public string EditDepartment(DepartmentModel dep, int state)
        {
            return service.EditDepartment(dep, state);
        }

        #endregion

        #region 人员信息

        /// <summary>
        /// 获取人员列表
        /// </summary>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        public DataTable GetPersonList(int pageIndex, int pageSize)
        {
            int startRow = 0, endRow = 0;
            startRow = (pageIndex - 1) * pageSize + 1;
            endRow = pageIndex * pageSize;
            return service.GetPersonList(startRow, endRow);
        }

        /// <summary>
        /// 获取人员总数
        /// </summary>
        /// <returns></returns>
        public string GetPersonTotal()
        {
            return service.GetPersonTotal();
        }

        /// <summary>
        /// 编辑人员
        /// </summary>
        /// <param name="per"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public string EditPerson(PersonModel per, int type)
        {
            return service.EditPerson(per, type);
        }

        #endregion

        #region 病人信息

        public DataTable GetHisPatientList(int pageIndex, int pageSize)
        {
            int startRow = 0, endRow = 0;
            startRow = (pageIndex - 1) * pageSize + 1;
            endRow = pageIndex * pageSize;
            return service.GetHisPatientList(startRow, endRow);
        }

        public DataTable GetHisPatienInfoByCode(string code)
        {
            return service.GetHisPatienInfoByCode(code);
        }

        public DataTable GetPatiens()
        {
            return service.GetPatiens();
        }

        public DataTable GetPatientList(int pageIndex, int pageSize)
        {
            int startRow = 0, endRow = 0;
            startRow = (pageIndex - 1) * pageSize + 1;
            endRow = pageIndex * pageSize;
            return service.GetPatientList(startRow, endRow);
        }

        public DataTable GetPatInfoById(int Id)
        {
            return service.GetPatInfoById(Id);
        }

        public string GetPatientCount()
        {
            return service.GetPatientCount();
        }

        public string AddPatientInfo(PatientModel patien, int state)
        {
            return service.AddPatientInfo(patien, state);
        }

        public string DelPatient(int Id, int state)
        {
            return service.DelPatient(Id, state);
        }

        #endregion

        #region 评估
        public string EditAssess(int patId, string assItem, int assType, double score, int rank)
        {
            return service.EditAssess(patId, assItem, assType, score, rank);
        }

        public DataTable GetAssess(int pageIndex, int pageSize, int type, int rank)
        {
            int startRow = 0, endRow = 0;
            startRow = (pageIndex - 1) * pageSize + 1;
            endRow = pageIndex * pageSize;
            return service.GetAssess(startRow, endRow, type, rank);
        }

        public string GetAssesTotal(int type, int rank)
        {
            return service.GetAssesTotal(type, rank);
        }

        public DataTable GetAssCountbyPainId(int painId)
        {
            return service.GetAssCountbyPainId(painId);
        }

        public DataTable GetCharts(int painId)
        {
            return service.GetCharts(painId);
        }

        #endregion

    }
}
