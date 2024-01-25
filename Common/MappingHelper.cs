using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common
{
    public static class MappingHelper
    {
      

        public static TDestination MapNonNullFields<TSource, TDestination>(TSource source, TDestination destination)
        {
            // 创建映射配置
            var config = new MapperConfiguration(cfg =>
            {
                cfg.CreateMap<TSource, TDestination>().ForAllMembers(opt => opt.Condition((src, dest, srcMember) => srcMember != null&&srcMember!=""));
            });

            // 创建映射器
            var mapper = new Mapper(config);

            // 执行映射
            return mapper.Map(source, destination);
        }
    }
    }

