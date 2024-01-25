﻿using Microsoft.AspNetCore.Mvc;
using Model.Other;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebAPI.Config
{

    [AttributeUsage(AttributeTargets.Method)]
    public class OperLogAttribute : Attribute
    {
        /// <summary>
        /// 操作类型
        /// </summary>
        public OperEnum OperType { get; set; }

        /// <summary>
        /// 日志标题（模块）
        /// </summary>
        public string Title { get; set; }

        /// <summary>
        /// 是否保存请求数据
        /// </summary>
        public bool IsSaveRequestData { get; set; } = true;

        /// <summary>
        /// 是否保存返回数据
        /// </summary>
        public bool IsSaveResponseData { get; set; } = true;

        public OperLogAttribute(string title, OperEnum operationType)
        {
            Title = title;
            OperType = operationType;
        }
    }
}
