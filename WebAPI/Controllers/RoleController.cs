using Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model.Dto.Role;
using Model.Other;
using SqlSugar;
using WebAPI.Config;

namespace WebAPI.Controllers
{
    /// <summary>
    /// 角色管理
    /// </summary>
    [Route("api/[controller]/[action]")]
    [Authorize]
    [ApiController]
    public class RoleController : ControllerBase
    {
        private readonly IRoleService _role;
        private readonly ISqlSugarClient _sqlSugarClient;
        public RoleController(IRoleService role,ISqlSugarClient sqlSugarClient)
        {
            _role = role;
            _sqlSugarClient = sqlSugarClient;
        }
        [HttpPost]
        public async Task<ApiResult> GetRoles(RoleReq req)
        {
            return ResultHelper.Success(_role.GetRolesAsync(req));
        }

        
        [OperLog("获取角色",OperEnum.GetData)]
        [HttpGet]
        public ApiResult GetRole(long id)
        {
            return ResultHelper.Success(_role.GetRoleById(id));
        }
        [HttpPost]
        public ApiResult Add(RoleAdd req)
        {
            //获取当前登录人信息
            long userId = Convert.ToInt32(HttpContext.User.Claims.ToList()[0].Value);
            return ResultHelper.Success(_role.Add(req, userId));
        }
        [HttpPost]
        public ApiResult Edit(RoleEdit req)
        {
            //获取当前登录人信息
            long userId = Convert.ToInt32(HttpContext.User.Claims.ToList()[0].Value);
            return ResultHelper.Success(_role.Edit(req, userId));
        }
        [HttpGet]
        public ApiResult Del(long id)
        {
            //获取当前登录人信息 
            return ResultHelper.Success(_role.Del(id));
        }
        [HttpGet]
        public ApiResult BatchDel(string ids)
        {
            //获取当前登录人信息 
            return ResultHelper.Success(_role.BatchDel(ids));
        }
    }
}
