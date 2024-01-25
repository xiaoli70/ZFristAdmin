using Interface;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model.Dto.User;
using Model.Other;
using WebAPI.Config;

namespace WebAPI.Controllers
{
    /// <summary>
    /// 登录(Token)
    /// </summary>
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class LoginController : ControllerBase
    { 
        private IUserService _userService;
        private ICustomJWTService _jwtService;
        public LoginController(IUserService userService, ICustomJWTService jwtService)
        {
            _userService = userService;
            _jwtService = jwtService;
        }
        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="name"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        [OperLog("登录", OperEnum.Auth)]
        [HttpGet]
        public async Task<ApiResult> GetToken(string name, string password)
        {
           
                if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(password))
                {
                    return ResultHelper.Error("参数不能为空");
                }
                UserRes user =await _userService.GetUserAsync(name, password);
                if (string.IsNullOrEmpty(user.Name))
                {
                    return ResultHelper.Error("账号不存在，用户名或密码错误！");
                }
                LoggedInUserInfo.SetUserInfo(user.Name, user.Id);
                return ResultHelper.Success(_jwtService.GetToken(user));
           
        }
        
    }
}
