using Autofac;
using Autofac.Extensions.DependencyInjection;
using SqlSugar;

namespace WebAPI.Config
{
    /// <summary>
    /// 扩展类
    /// </summary>
    public static class HostBuilderExtend
    {
        public static void Register(this WebApplicationBuilder app)
        {
            app.Host.UseServiceProviderFactory(new AutofacServiceProviderFactory());
            app.Host.ConfigureContainer<ContainerBuilder>(builder =>
            {
                #region 注册sqlsugar
                builder.Register<ISqlSugarClient>(context =>
                {
                    SqlSugarClient db = new SqlSugarClient(new ConnectionConfig()
                    {
                        //连接字符串
                        ConnectionString = "Data Source=DESKTOP-2DUF58Q\\SQLEXPRESS;Initial Catalog=ZhaoxiAdminDb1;Persist Security Info=True;User ID=sa;Password=123456",
                        DbType = DbType.SqlServer,
                        IsAutoCloseConnection = true
                    });
                    //支持sql语句的输出，方便排查问题
                    db.Aop.OnLogExecuted = (sql, par) =>
                    {
                        Console.WriteLine("\r\n");
                        Console.WriteLine($"{DateTime.Now.ToString("yyyyMMdd HH:mm:ss")}，Sql语句：{sql}");
                        Console.WriteLine("===========================================================================");
                    };

                    return db;
                });
                #endregion

                //注册接口和实现层
                builder.RegisterModule(new AutofacModuleRegister());
            });
        }
    }
}
