using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Other
{
    public enum OperEnum
    {
        /// <summary>
        /// 插入操作。
        /// </summary>
        Insert,

        /// <summary>
        /// 更新操作。
        /// </summary>
        Update,

        /// <summary>
        /// 删除操作。
        /// </summary>
        Delete,

        /// <summary>
        /// 授权操作。
        /// </summary>
        Auth,

        /// <summary>
        /// 导出操作。
        /// </summary>
        Export,

        /// <summary>
        /// 导入操作。
        /// </summary>
        Import,

        /// <summary>
        /// 强制退出操作。
        /// </summary>
        ForcedOut,

        /// <summary>
        /// 生成代码操作。
        /// </summary>
        GenerateCode,

        /// <summary>
        /// 清除数据操作。
        /// </summary>
        ClearData,

        /// <summary>
        /// 获取数据操作。
        /// </summary>
        GetData
    }
}
