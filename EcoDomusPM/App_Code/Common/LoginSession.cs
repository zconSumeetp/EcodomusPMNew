using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using EcoDomus.Session;

/// <summary>
/// Summary description for SetSession
/// </summary>
/// 

namespace EcoDomus.Common
{
    public class LoginSession
    {
        public LoginSession()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public void SetSession(DataSet ds)
        {
            SessionController.Users_.UserId = ds.Tables[0].Rows[0]["UserID"].ToString();
            SessionController.Users_.UserName = ds.Tables[0].Rows[0]["UserName"].ToString();
            SessionController.Users_.OrganizationID = ds.Tables[0].Rows[0]["OrganizationId"].ToString();
            SessionController.Users_.UserRoleDescription = ds.Tables[0].Rows[0]["SystemRoleDesc"].ToString();
            SessionController.Users_.OrganizationName = ds.Tables[0].Rows[0]["OrganizationName"].ToString();
            SessionController.Users_.UserSystemRole = ds.Tables[0].Rows[0]["SystemRole"].ToString();
        }
    }
}