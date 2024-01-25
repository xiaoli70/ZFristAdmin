using System.Security.Claims;

namespace WebAPI.Config
{
    public static class UseStaticHttpContext
    {
        private static readonly IHttpContextAccessor _httpContextAccessor;
        static UseStaticHttpContext()
        {
            _httpContextAccessor = new HttpContextAccessor();
        }
        public static string? UserName => _httpContextAccessor.HttpContext?.User.FindFirstValue("Name");
        public static string? UserId => _httpContextAccessor.HttpContext?.User.FindFirstValue("Id");
    }
}
