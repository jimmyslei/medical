using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Medical.Model
{
    public class PatientModel
    {
        public int Id { get; set; }

        /// <summary>
        /// 姓名
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// 性别
        /// </summary>
        public int Sex { get; set; }

        /// <summary>
        /// 年龄
        /// </summary>
        public int Age { get; set; }

        /// <summary>
        /// 编码
        /// </summary>
        public string Code { get; set; }

        /// <summary>
        /// 身份证号
        /// </summary>
        public string CardId { get; set; }

        /// <summary>
        /// 联系电话
        /// </summary>
        public string Phone { get; set; }
        
        /// <summary>
        /// 婚姻
        /// </summary>
        public int Marry { get; set; }

        /// <summary>
        /// 入院时间
        /// </summary>
        public DateTime? InTime { get; set; }

        /// <summary>
        /// 户籍地址
        /// </summary>
        public string Address { get; set; }

        /// <summary>
        /// 现居地址
        /// </summary>
        public string NowAddress { get; set; }

        /// <summary>
        /// 工作单位
        /// </summary>
        public string Work { get; set; }

        /// <summary>
        /// 科室
        /// </summary>
        public string depName { get; set; }

        /// <summary>
        /// 科室Id
        /// </summary>
        public string depCode { get; set; }

        /// <summary>
        /// 床位
        /// </summary>
        public string bedNo { get; set; }

    }
}
