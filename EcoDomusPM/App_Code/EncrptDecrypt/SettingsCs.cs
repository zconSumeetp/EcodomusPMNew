using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;


namespace EcoDomus.EncrptDecrypt.SettingsCs
{
    public class Settings
    {
        public Settings()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        static internal readonly byte[] Key = new byte[] { 113, 49, 213, 243, 213, 97, 186, 164 };
        static internal readonly byte[] IV = new byte[] { 190, 48, 13, 193, 137, 134, 106, 173 };
        internal const int LDAP_EXCEPTION_TIMEOUT_ERROR_CODE = 85;
    }
}