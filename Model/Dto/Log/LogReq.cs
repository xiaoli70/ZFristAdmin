using Model.Other;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Dto.Log
{
    public class LogReq
    {
      
        public string? Title { get; set; }
        
        public OperEnum OperType { get; set; }
        
       
        public string? RequestMethod { get; set; }
       
        
        public string? OperUser { get; set; }
       
        
    }
}
