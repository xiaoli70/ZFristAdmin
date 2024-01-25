using AutoMapper;
using Common;
using Interface;
using Model.Dto.User;
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
    public class UserService : IUserService
    {
        private readonly IMapper _mapper;
        private ISqlSugarClient _db { get; set; }
        public UserService(IMapper mapper, ISqlSugarClient db)
        {
            _mapper = mapper;
            _db = db;
        }
        public UserRes GetUser(string userName, string password)
        {
            var user = _db.Queryable<Users>().Where(u => u.Name == userName &&u.IsDeleted==0).First();
            if (user != null)
            {
            bool isPasswordCorrect = PasswordHasher.VerifyPassword(password, user.Password.Split(',')[0], user.Password.Split(',')[1]);
            if (isPasswordCorrect)
            {
                return _mapper.Map<UserRes>(user);
            }}
            return new UserRes();
        }

        public async Task<UserRes> GetUserAsync(string userName, string password)
        {
            var user =await _db.Queryable<Users>().Where(u => u.Name == userName && u.IsDeleted == 0).FirstAsync();
            if (user != null)
            {
                bool isPasswordCorrect = PasswordHasher.VerifyPassword(password, user.Password.Split(',')[0], user.Password.Split(',')[1]);
                if (isPasswordCorrect)
                {
                    return _mapper.Map<UserRes>(user);
                }
            }
            return new UserRes();
        }
        public bool Add(UserAdd input, long userId)
        {
            Users info = _mapper.Map<Users>(input);
            info.CreateUserId = userId;
            info.CreateDate = DateTime.Now;
            info.UserType = 1;//0=炒鸡管理员，系统内置的
            info.IsDeleted = 0;
            
            PasswordHasher.HashPassword(info.Password, out string hashedPassword, out string salt);
            info.Password= hashedPassword+","+salt;
            return _db.Insertable(info).ExecuteCommand() > 0;
        }

        public bool Edit(UserEdit input, long userId)
        {

            var info = _db.Queryable<Users>().First(p => p.Id == input.Id);
            
             MappingHelper.MapNonNullFields(input, info);
            if (!string.IsNullOrEmpty(input.Password)) {
                PasswordHasher.HashPassword(input.Password, out string hashedPassword, out string salt);
                info.Password = hashedPassword + "," + salt;
            }
            info.ModifyUserId = userId;
            info.ModifyDate = DateTime.Now;
            return _db.Updateable(info).ExecuteCommand() > 0;
        }

        public bool Del(long id)
        {
            var info = _db.Queryable<Users>().First(p => p.Id == id);
            return _db.Deleteable(info).ExecuteCommand() > 0;
        }

        public bool BatchDel(string ids)
        {
            return _db.Ado.ExecuteCommand($"DELETE Users WHERE Id IN({ids})") > 0;
        }

        public async Task<PageInfo> GetUsers(UserReq req)
        {
            PageInfo pageInfo = new PageInfo();
            var exp = _db.Queryable<Users>()
                //默认只查询非炒鸡管理员的用户
                .Where(u => u.UserType == 1)
                .WhereIF(!string.IsNullOrEmpty(req.Name), u => u.Name.Contains(req.Name))
                .WhereIF(!string.IsNullOrEmpty(req.NickName), u => u.NickName.Contains(req.NickName))
                .OrderBy((u) => u.CreateDate, OrderByType.Desc)
                .Select((u) => new UserRes
                {
                    Id = u.Id
                ,
                    Name = u.Name
                ,
                    NickName = u.NickName
                ,
                    Password = u.Password
                ,
                    UserType = u.UserType
                //,
                //    RoleName = GetRolesByUserId(u.Id)
                ,
                    CreateDate = u.CreateDate
                ,
                    IsEnable = u.IsEnable
                ,
                    Description = u.Description
                });
            var res = await exp
                    .Skip((req.PageIndex - 1) * req.PageSize)
                .Take(req.PageSize)
                .ToListAsync();
            res.ForEach( p =>
            {
                p.RoleName = GetRolesByUserId(p.Id);
            });
            pageInfo.Data = _mapper.Map<List<UserRes>>(res);
            pageInfo.Total = await exp.CountAsync();
            return pageInfo;
        }
        private string GetRolesByUserId(long uid)
        {
            return _db.Ado.SqlQuery<string>($@"SELECT STUFF((SELECT ','+R.Name FROM dbo.Role R
                    LEFT JOIN dbo.UserRoleRelation UR ON R.Id=UR.RoleId
                    WHERE UR.UserId={uid} FOR XML PATH('')),1,1,'') RoleNames")[0];
        }
        public UserRes GetUsersById(long id)
        {
            var info = _db.Queryable<Users>().First(p => p.Id == id);
            return _mapper.Map<UserRes>(info);
        }
        public bool SettingRole(string pid, string rids)
        {
            //1,2,3,4,5
            List<UserRoleRelation> list = new List<UserRoleRelation>();
            foreach (string it in rids.Split(','))
            {
                UserRoleRelation info = new UserRoleRelation() { UserId = Convert.ToInt64(pid), RoleId = Convert.ToInt64(it.Replace("'", "")) };
                list.Add(info);
            }
            //删除之前的角色
            _db.Ado.ExecuteCommand($"DELETE UserRoleRelation WHERE UserId = {pid}");
            return _db.Insertable(list).ExecuteCommand() > 0;
        }
        public bool EditNickNameOrPassword(long userId, string nickName, string password)
        {
            var info = _db.Queryable<Users>().Where(p => p.Id == userId).First();
            if (info != null)
            {
                if (!string.IsNullOrEmpty(nickName))
                {
                    info.NickName = nickName;
                }
                if (!string.IsNullOrEmpty(password))
                {
                    info.Password = password;
                }
            }
            return _db.Updateable(info).ExecuteCommand() > 0;
        }

        
    }
}
