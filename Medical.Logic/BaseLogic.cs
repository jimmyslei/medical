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
        /// <summary>
        /// 获取人员列表
        /// </summary>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        public DataTable GetPaintList(int pageIndex, int pageSize)
        {
            int startRow = 0, endRow = 0;
            startRow = (pageIndex - 1) * pageSize + 1;
            endRow = pageIndex * pageSize;
            return service.GetPaintList(startRow, endRow);
        }

        /// <summary>
        /// 获取人员总数
        /// </summary>
        /// <returns></returns>
        public string GetPaintTotal()
        {
            return service.GetPaintTotal();
        }
    }
}
 