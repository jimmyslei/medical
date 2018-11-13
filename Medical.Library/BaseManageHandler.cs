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
                    case "GetPaintList":
                        rstr = GetPaintList(context);
                        break;
                    case "GetPaintTotal":
                        rstr = GetPaintTotal(context);
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

        

        private string GetPaintList(HttpContext context)
        {
            int pageIndex = !string.IsNullOrEmpty(context.Request["pageIndex"]) ? Convert.ToInt32(context.Request["pageIndex"]) : 0;
            int pageSize = !string.IsNullOrEmpty(context.Request["pageSize"]) ? Convert.ToInt32(context.Request["pageSize"]) : 0;

            var result = bases.GetPaintList(pageIndex, pageSize);

            var dataJson = result.ToJson();
            var total = Convert.ToInt32(bases.GetPaintTotal());
            var pageCount = (total % pageSize) == 0 ? (total / pageSize) : (total / pageSize) + 1;

            return "{" + "\"dataList\":" + dataJson + "," +
                  "\"totalCount\":" + total + "," +
                  "\"currPage\":" + pageIndex + "," +
                  "\"totalPage\":" + pageCount + "}";
        }

        private string GetPaintTotal(HttpContext context)
        {
            return bases.GetPaintTotal();
        }

    }
}
