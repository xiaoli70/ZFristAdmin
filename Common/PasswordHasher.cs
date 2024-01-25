using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Common
{
    public class PasswordHasher
    {
        // 生成密码哈希和盐
        public static void HashPassword(string password, out string hash, out string salt)
        {
            using (var deriveBytes = new Rfc2898DeriveBytes(password, 32, 10000))
            {
                byte[] saltBytes = deriveBytes.Salt;
                byte[] hashBytes = deriveBytes.GetBytes(32);

                hash = Convert.ToBase64String(hashBytes);
                salt = Convert.ToBase64String(saltBytes);
            }
        }

        // 验证密码
        public static bool VerifyPassword(string password, string storedHash, string storedSalt)
        {
            byte[] hashBytes = Convert.FromBase64String(storedHash);
            byte[] saltBytes = Convert.FromBase64String(storedSalt);

            using (var deriveBytes = new Rfc2898DeriveBytes(password, saltBytes, 10000))
            {
                byte[] newHashBytes = deriveBytes.GetBytes(32);

                return StructuralComparisons.StructuralEqualityComparer.Equals(hashBytes, newHashBytes);
            }
        }
    }
}
