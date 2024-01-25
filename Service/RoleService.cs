using AutoMapper;
using Interface;
using Model.Dto.Role;
using Model.Entitys;
using Model.Other;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service
{
    public class RoleService: IRoleService
    {
        private readonly IMapper _mapper;
        private ISqlSugarClient _db { get; set; }
        public RoleService(IMapper mapper, ISqlSugarClient db)
        {
            _mapper = mapper;
            _db = db;
        }
        public bool Add(RoleAdd req, long userId)
        {
            Role info = _mapper.Map<Role>(req);
            info.CreateUserId = userId;
            info.CreateDate = DateTime.Now;
            info.IsDeleted = 0;
            return _db.Insertable(info).ExecuteCommand() > 0;
        }

        public bool Del(long id)
        {
            var info = _db.Queryable<Role>().First(p => p.Id == id);
            return _db.Deleteable(info).ExecuteCommand() > 0;
        }
        public bool BatchDel(string ids)
        {
            return _db.Ado.ExecuteCommand($"DELETE Role WHERE Id IN({ids})") > 0;
        }

        public bool Edit(RoleEdit req, long userId)
        {
            var role = _db.Queryable<Role>().First(p => p.Id == req.Id);
            _mapper.Map(req, role);
            role.ModifyUserId = userId;
            role.ModifyDate = DateTime.Now;
            return _db.Updateable(role).ExecuteCommand() > 0;
        }

        public RoleRes GetRoleById(long id)
        {
            var info = _db.Queryable<Role>().First(p => p.Id == id);
            return _mapper.Map<RoleRes>(info);
        }

        public PageInfo GetRoles(RoleReq req)
        {
            PageInfo pageInfo = new PageInfo();
            var exp = _db.Queryable<Role>().WhereIF(!string.IsNullOrEmpty(req.Name), p => p.Name.Contains(req.Name));
            var res = exp
                .OrderBy(p => p.Order)
                .Skip((req.PageIndex - 1) * req.PageSize)
                .Take(req.PageSize)
                .ToList();
            pageInfo.Data = _mapper.Map<List<RoleRes>>(res);
            pageInfo.Total = exp.Count();
            return pageInfo;
        }
        public async Task<PageInfo> GetRolesAsync(RoleReq req)
        {
            PageInfo pageInfo = new PageInfo();

            try
            {
                var query = _db.Queryable<Role>().WhereIF(!string.IsNullOrEmpty(req.Name), p => p.Name.Contains(req.Name));

                // 注意：如果 Order 字段可能为 null，请进行 null 检查
                query = query.OrderBy(p => p.Order);

                var roles = await query
                    .Skip((req.PageIndex - 1) * req.PageSize)
                    .Take(req.PageSize)
                    .ToListAsync();

                pageInfo.Data = _mapper.Map<List<RoleRes>>(roles);
                pageInfo.Total = query.Count();
            }
            catch (Exception ex)
            {
                // 处理异常，可以记录日志或者抛出自定义异常
                Console.WriteLine($"An error occurred in GetRolesAsync: {ex.Message}");
                // 如果是 Web API，可以抛出 HttpResponseException 或者返回适当的错误状态码
                throw;
            }

            return pageInfo;
        }
    }
}
