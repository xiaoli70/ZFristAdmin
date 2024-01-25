namespace WebAPI.Config
{
    /// <summary>
    /// 登录人信息
    /// </summary>
    public static class LoggedInUserInfo
    {
        public static string UserName { get; set; }
        public static long UserId { get; set; }
        // Add other properties as needed

        // You can add methods to update or clear the user information
        public static void SetUserInfo(string userName, long userId)
        {
            UserName = userName;
            UserId = userId;
        }

        public static void ClearUserInfo()
        {
            UserName = null;
            UserId = 0;
        }
    }
}
