using Autofac;
using Autofac.Core;
using Autofac.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Model.Other;
using Newtonsoft.Json;
using SqlSugar;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;

namespace WebAPI.Config
{
    /// <summary>
    /// 扩展类
    /// </summary>
    public static class HostBuilderExtend
    {
        public static void Register(this WebApplicationBuilder builder)
        {
            builder.Host.UseServiceProviderFactory(new AutofacServiceProviderFactory());
            builder.Host.ConfigureContainer<ContainerBuilder>(builder1 =>
            {
                #region 注册sqlsugar
                builder1.Register<ISqlSugarClient>(context =>
                {
                    SqlSugarClient db = new SqlSugarClient(new ConnectionConfig()
                    {
                        //连接字符串
                        ConnectionString = "Data Source=ZEROTPC003\\MSSQLSERVER2022;Initial Catalog=AdminDb;Persist Security Info=True;User ID=sa;Password=sa123456",
                        DbType = DbType.SqlServer,
                        IsAutoCloseConnection = true
                    });
                    //支持sql语句的输出，方便排查问题
                    //db.Aop.OnLogExecuted = (sql, par) =>
                    //{
                    //    Console.WriteLine("\r\n");
                    //    Console.WriteLine($"{DateTime.Now.ToString("yyyyMMdd HH:mm:ss")}，Sql语句：{sql}");
                    //    Console.WriteLine("===========================================================================");
                    //};
                   
                        ////如果不存在创建数据库存在不会重复创建 
                        //{
                        //    db.DbMaintenance.CreateDatabase(); // 注意 ：Oracle和个别国产库需不支持该方法，需要手动建库  
                        //}
                        ////创建表根据实体类CodeFirstTable1     
                        //{
                           // db.CodeFirst.InitTables(typeof(OperationLogEntity));//这样一个表就能成功创建了
                        //}
                    string namespaceName = "Model.Entitys";

                    // 获取当前程序集中的类型  
                    //Assembly assembly = Assembly.Load("Model");
                    //Type[] types = assembly.GetTypes();
                    //string type2 = types[6].Namespace;
                    //bool fal = type2.Contains(namespaceName);
                    //// 筛选出特定命名空间下的类型  
                    //var filteredTypes = types.Where(type => type.Namespace.Contains(namespaceName)).ToArray();
                    //db.CodeFirst.InitTables(filteredTypes);
                    //builder.Services.AddScoped(db);
                    return db;
                });
                #endregion

                //注册接口和实现层
                builder1.RegisterModule(new AutofacModuleRegister());
            });
            //Automapper映射
            builder.Services.AddAutoMapper(typeof(AutoMapperConfigs));
            //第一步，注册JWT
            builder.Services.Configure<JWTTokenOptions>(builder.Configuration.GetSection("JWTTokenOptions"));
            #region JWT校验
            //第二步，增加鉴权逻辑
            JWTTokenOptions tokenOptions = new JWTTokenOptions();
            builder.Configuration.Bind("JWTTokenOptions", tokenOptions);
            builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)//Scheme
             .AddJwtBearer(options =>  //这里是配置的鉴权的逻辑
             {
                 options.TokenValidationParameters = new TokenValidationParameters
                 {
                         //JWT有一些默认的属性，就是给鉴权时就可以筛选了
                     ValidateIssuer = true,//是否验证Issuer
                     ValidateAudience = true,//是否验证Audience
                     ValidateLifetime = true,//是否验证失效时间
                     ValidateIssuerSigningKey = true,//是否验证SecurityKey
                     ValidAudience = tokenOptions.Audience,//
                     ValidIssuer = tokenOptions.Issuer,//Issuer，这两项和前面签发jwt的设置一致
                     IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(tokenOptions.SecurityKey))//拿到SecurityKey 
                 };
             });
            builder.Services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo
                {
                    Version = "v1",
                    Title = "Admin Api"
                });
                c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme//增加swagger报头
                {
                    Description = "Value: Bearer {token}",
                    Name = "Authorization",
                    In = ParameterLocation.Header,
                    Type = SecuritySchemeType.ApiKey,
                    Scheme = "Bearer"
                });
                // 设置 XML 注释文件的路径
                var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
                var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
                c.IncludeXmlComments(xmlPath);
                c.AddSecurityRequirement(new OpenApiSecurityRequirement()
                {
                  {
                    new OpenApiSecurityScheme
                    {
                      Reference = new OpenApiReference
                      {
                        Type = ReferenceType.SecurityScheme,
                        Id = "Bearer"
                      },Scheme = "oauth2",Name = "Bearer",In = ParameterLocation.Header,
                    },new List<string>()
                  }
                });
            });
            #endregion
            
            //添加跨域策略
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("CorsPolicy", opt => opt.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod().WithExposedHeaders("X-Pagination"));
            });
            //设置Json返回的日期格式
            builder.Services.AddControllers().AddNewtonsoftJson(options =>
            {
                options.SerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
                options.SerializerSettings.DateFormatString = "yyyy-MM-dd HH:mm:ss";
            });
        }
        /// <summary>
        /// 获取客户端IP
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public static string GetClientIp(this HttpContext context)
        {
            if (context == null) return "";
            var result = context.Request.Headers["X-Forwarded-For"].FirstOrDefault();
            if (string.IsNullOrEmpty(result))
            {
                result = context.Connection.RemoteIpAddress?.ToString();
            }
            if (string.IsNullOrEmpty(result) || result.Contains("::1"))
                result = "127.0.0.1";

            result = result.Replace("::ffff:", "127.0.0.1");

            //Ip规则效验
            var regResult = Regex.IsMatch(result, @"^((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)$");

            result = regResult ? result : "127.0.0.1";
            return result;
        }
    }
}
