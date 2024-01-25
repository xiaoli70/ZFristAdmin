using Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Model.Dto.Log;
using Model.Dto.Role;
using Model.Other;
using SqlSugar;
using WebAPI.Config;

namespace WebAPI.Controllers
{
    [Route("api/[controller]/[action]")]
    [Authorize]
    [ApiController]
    public class LogController : ControllerBase
    {
       
        private readonly ISqlSugarClient _sqlSugarClient;
        public LogController(ISqlSugarClient sqlSugarClient)
        {
          
            _sqlSugarClient = sqlSugarClient;
        }
        /// <summary>
        /// 获取日志操作记录
        /// </summary>
        /// <param name="req"></param>
        /// <returns></returns>
        [HttpPost]
        public async Task<ApiResult> GetLogs(LogReq req)
        {
            List<OperationLogEntity> list = await _sqlSugarClient.Queryable<OperationLogEntity>()
                .WhereIF(!string.IsNullOrEmpty(req.Title), u => u.Title.Contains(req.Title))
                .WhereIF(!string.IsNullOrEmpty(req.OperUser), u => u.OperUser.Contains(req.OperUser))
                .ToListAsync();

            return ResultHelper.Success(list);
        }
    }
}
