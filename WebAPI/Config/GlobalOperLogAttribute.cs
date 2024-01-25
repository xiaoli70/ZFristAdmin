
using IPTools.Core;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Extensions.Logging;
using Model.Other;
using NetTaste;
using Newtonsoft.Json;
using Serilog;
using Serilog.Formatting.Compact;
using SqlSugar;
using System.Security.Claims;
using System.Text.RegularExpressions;

namespace WebAPI.Config
{
    //[AttributeUsage(AttributeTargets.Method)]
    public class GlobalOperLogAttribute : Attribute, IAsyncActionFilter
    {
        private ILogger<GlobalOperLogAttribute> _logger;
        private readonly ISqlSugarClient _repository;

        /// <summary>
        /// 注入一个日志服务
        /// </summary>
        /// <param name="sqlSugarClient"></param>
        public GlobalOperLogAttribute(ISqlSugarClient repository,ILogger<GlobalOperLogAttribute> logger)
        {
            _logger = logger;
            _repository = repository;

        }


        public async Task OnActionExecuted(ActionExecutedContext context)
        {
            //判断标签是在方法上
            if (context.ActionDescriptor is not ControllerActionDescriptor controllerActionDescriptor) return;
            //查找标签，获取标签对象
            OperLogAttribute? operLogAttribute = controllerActionDescriptor.MethodInfo.GetCustomAttributes(inherit: true)
                  .FirstOrDefault(a => a.GetType().Equals(typeof(OperLogAttribute))) as OperLogAttribute;
            //空对象直接返回
            if (operLogAttribute is null) return;
            //登录失败直接返回
            if (operLogAttribute.OperType == OperEnum.Auth && LoggedInUserInfo.UserName == null)
                return;
            ////获取控制器名
            string controller = context.RouteData.Values["Controller"]?.ToString();
            ////获取方法名
            string action = context.RouteData.Values["Action"].ToString();

            string ip="", location="";
            try
            {
                ip = context.HttpContext.GetClientIp();
                //根据ip获取地址
                var ipTool  = IpTool.Search(ip);
                location = $"{ipTool.Province} {ipTool.City}";
            }
            catch (Exception ex)
            {
                // 处理其他异常
                LogException(ex);
            }

            //日志服务插入一条操作记录即可
            var logEntity = new OperationLogEntity();
            logEntity.Id = SnowflakeHelper.NextId;
            logEntity.OperIp = ip;
            logEntity.OperLocation = location;
            logEntity.OperType = operLogAttribute.OperType;
            logEntity.Title = operLogAttribute.Title;
            logEntity.RequestMethod = context.HttpContext.Request.Method;
            logEntity.Method = context.HttpContext.Request.Path.Value;
            logEntity.OperLocation = location;
            logEntity.CreationTime= DateTime.Now;
            if (operLogAttribute.OperType == OperEnum.Auth)
            {
                logEntity.CreatorId = LoggedInUserInfo.UserId;
                logEntity.OperUser = LoggedInUserInfo.UserName;
            }
            else {
                var va = context.HttpContext.User.Identity as ClaimsIdentity;
                logEntity.CreatorId = Convert.ToInt32(va.FindFirst("Id")?.Value);
                logEntity.OperUser = va.FindFirst("Name")?.Value;
            }
            if (operLogAttribute.IsSaveResponseData)
            {
                if (context.Result is ContentResult result && result.ContentType == "application/json")
                {
                    logEntity.RequestResult = result.Content?.Replace("\r\n", "").Trim();
                }
                if (context.Result is JsonResult result2)
                {
                    logEntity.RequestResult = result2.Value?.ToString();
                }
                if (context.Result is ObjectResult result3)
                {
                    logEntity.RequestResult = JsonConvert.SerializeObject(result3.Value);
                }
            }
            if (operLogAttribute.IsSaveRequestData)
            {
                logEntity.RequestParam = "1";
            }
            LogToConsole(logEntity);
            await _repository.Insertable(logEntity).ExecuteCommandAsync();
        }

        private void LogToConsole(OperationLogEntity logEntity)
        {
    
            // 记录logEntity对象
            Log.Information("操作日志：" +
                            "Id: {Id}\n" +
                            "OperIp: {OperIp}\n" +
                            "OperLocation: {OperLocation}\n" +
                            "OperType: {OperType}\n" +
                            "Title: {Title}\n" +
                            "RequestMethod: {RequestMethod}\n" +
                            "Method: {Method}\n" +
                            "CreationTime: {CreationTime:yyyy-MM-dd HH:mm:ss}\n" +
                            "CreatorId: {CreatorId}\n" +
                            "OperUser: {OperUser}",
                            logEntity.Id, logEntity.OperIp, logEntity.OperLocation, logEntity.OperType,
                            logEntity.Title, logEntity.RequestMethod, logEntity.Method,
                            logEntity.CreationTime, logEntity.CreatorId, logEntity.OperUser);
        }

        public async Task OnActionExecuting(ActionExecutingContext context)
        {
            await Task.CompletedTask;
        }

        public async Task OnActionExecutionAsync(ActionExecutingContext context, ActionExecutionDelegate next)
        {
             await OnActionExecuting(context);

            var nextContext = await next();
            //_ = await next.Invoke();
            //return;
            // Do something after the action executes.
             await OnActionExecuted(nextContext);
        }

        private void LogException(Exception ex)
        {
            // 使用日志框架记录异常信息
           //_logger.LogError(ex, "An exception occurred in OnActionExecuted.");
        }

    }
}
