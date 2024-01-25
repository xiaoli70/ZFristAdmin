using Autofac.Core;
using Microsoft.AspNetCore.Mvc;
using Serilog;
using Swashbuckle.AspNetCore.SwaggerUI;
using WebAPI.Config;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Register();


builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddControllers(options =>
{
    options.Filters.Add(new TypeFilterAttribute(typeof(GlobalOperLogAttribute)));
});
Log.Logger = new LoggerConfiguration()
                .WriteTo.Console(outputTemplate: "{NewLine}[{Timestamp:yyyy-MM-dd HH:mm:ss} {Level:u3}] {Message:lj}{NewLine}")
                .WriteTo.File(path: $"Logs\\Log_{DateTime.Now:yyyyMMdd}.txt", outputTemplate: "{NewLine}[{Timestamp:HH:mm:ss} {Level:u3}] {Message:lj} {Properties:j}{NewLine}")
                .CreateLogger();
var app = builder.Build();

// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
    app.UseSwagger();
    app.UseSwaggerUI(options => options.DocExpansion(DocExpansion.None));
//}
#region 鉴权授权
app.UseAuthentication();
app.UseAuthorization();
#endregion

//使用跨域策略
app.UseCors("CorsPolicy");

app.MapControllers();

app.Run();
