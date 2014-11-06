using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using EcoDomus.EncrptDecrypt.SettingsCs;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Collections.Specialized;

/// <summary>
/// Summary description for CryptoHelper
/// </summary>
/// 
namespace EcoDomus.EncrptDecrypt.CryptoHelperCs
{
    public class CryptoHelper
    {
        public CryptoHelper()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        internal const string DEFAULT_ALGORITHM = "DES";

        private SymmetricAlgorithm GetProvider(string algorithm)
        {
            return SymmetricAlgorithm.Create(algorithm);
        }

        public string Encrypt(string str)
        {
            return Encrypt(str, DEFAULT_ALGORITHM);
        }


        public string Encrypt(string str, string algorithm)
        {
            SymmetricAlgorithm des = GetProvider(algorithm);
            MemoryStream ms = new MemoryStream();
            try
            {
                ICryptoTransform desTr = des.CreateEncryptor(Settings.Key, Settings.IV);
                Encoding enc = Encoding.UTF8;
                byte[] bytes = enc.GetBytes(str.Trim());
                CryptoStream cs = new CryptoStream(ms, desTr, CryptoStreamMode.Write);
                cs.Write(bytes, 0, bytes.Length);
                cs.FlushFinalBlock();

                return Convert.ToBase64String(ms.ToArray());
            }
            finally
            {
                ms.Close();
            }
        }

        public string Decrypt(string str)
        {
            return Decrypt(str, DEFAULT_ALGORITHM);
        }


        public string Decrypt(string str, string algorithm)
        {
            SymmetricAlgorithm des = GetProvider(algorithm);
            Encoding enc = Encoding.UTF8;
            byte[] bytes = enc.GetBytes(str);
            FromBase64Transform b64 = new FromBase64Transform();
            bytes = b64.TransformFinalBlock(bytes, 0, bytes.Length);
            MemoryStream ms = new MemoryStream(bytes);
            try
            {
                ICryptoTransform desTr = des.CreateDecryptor(Settings.Key, Settings.IV);
                CryptoStream cs = new CryptoStream(ms, desTr, CryptoStreamMode.Read);
                byte[] resBytes = new byte[ms.Length];
                cs.Read(resBytes, 0, resBytes.Length);
                return enc.GetString(resBytes).TrimEnd('\0');
            }
            finally
            {
                ms.Close();
            }
        }
    }
}