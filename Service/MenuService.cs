using AutoMapper;
using Interface;
using Model.Dto.Menu;
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
    public class MenuService: IMenuService
    {
        private readonly IMapper _mapper;
        private ISqlSugarClient _db { get; set; }
        public MenuService(IMapper mapper, ISqlSugarClient db)
        {
            _mapper = mapper;
            _db = db;
        }
        public bool Add(MenuAdd input, long MenuId)
        {
            Menu info = _mapper.Map<Menu>(input);
            info.CreateUserId = MenuId;
            info.CreateDate = DateTime.Now;
            info.IsDeleted = 0;
            return _db.Insertable(info).ExecuteCommand() > 0;
        }

        public bool Edit(MenuEdit input, long userId)
        {
            var info = _db.Queryable<Menu>().First(p => p.Id == input.Id);
            _mapper.Map(input, info);
            info.ModifyUserId = userId;
            info.ModifyDate = DateTime.Now;
            return _db.Updateable(info).ExecuteCommand() > 0;
        }

        public bool Del(long id)
        {
            var info = _db.Queryable<Menu>().First(p => p.Id == id);
            return _db.Deleteable(info).ExecuteCommand() > 0;
        }

        public bool BatchDel(string ids)
        {
            return _db.Ado.ExecuteCommand($"DELETE Menu WHERE Id IN({ids})") > 0;
        }

        public PageInfo GetMenus(MenuReq req)
        {
            PageInfo pageInfo = new PageInfo();
            var exp = _db.Queryable<Menu>()
                .WhereIF(!string.IsNullOrEmpty(req.Name), u => u.Name.Contains(req.Name))
                .WhereIF(!string.IsNullOrEmpty(req.Index), u => u.Index.Contains(req.Index))
                .OrderBy((u) => u.Order)
                .Select((u) => new MenuRes
                {
                    Id = u.Id
                ,
                    Name = u.Name
                ,
                    Index = u.Index
                ,
                    FilePath = u.FilePath
                ,
                    ParentId = u.ParentId
                ,
                    ParentName = SqlFunc.Subqueryable<Menu>().Where(p => p.Id == u.ParentId).Select(s => s.Name)
                ,
                    Order = u.Order
                ,
                    IsEnable = u.IsEnable
                ,
                    Description = u.Description
                ,
                    CreateDate = u.CreateDate
                }).ToTree(it => it.Children, it => it.ParentId, 0);
            var res = exp
                .Skip((req.PageIndex - 1) * req.PageSize)
                .Take(req.PageSize)
                .ToList();
            pageInfo.Data = _mapper.Map<List<MenuRes>>(res);
            pageInfo.Total = exp.Count();
            return pageInfo;
        }
        public MenuRes GetMenuById(long id)
        {
            var info = _db.Queryable<Menu>().First(p => p.Id == id);
            return _mapper.Map<MenuRes>(info);
        }

        public bool SettingMenu(long rid, string mids)
        {
            List<MenuRoleRelation> list = new List<MenuRoleRelation>();
            foreach (string it in mids.Split(','))
            {
                MenuRoleRelation info = new MenuRoleRelation() { RoleId = rid, MenuId = Convert.ToInt64(it.Replace("'", "")) };
                list.Add(info);
            }
            //删除之前的角色
            _db.Ado.ExecuteCommand($"DELETE MenuRoleRelation WHERE MenuId = {rid}");
            return _db.Insertable(list).ExecuteCommand() > 0;
        }

    }
}
