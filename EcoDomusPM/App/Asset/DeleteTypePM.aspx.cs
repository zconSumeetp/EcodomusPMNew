using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TypeProfile;
using EcoDomus.Session;
using System.Data;
using System.Data.SqlClient;

public partial class App_Asset_DeleteTypePM : System.Web.UI.Page
{
    string type_id="";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["type_id"] != null)
        {
           
            string id = Request.QueryString["type_id"].ToString();
            type_id = id.Substring(0,id.Length - 1);
           // string id = Request.QueryString["type_id"].ToString();
           
        }
    }

    protected void btn_delete_type(object sender,EventArgs e)
    {
        try
        {
          
            TypeModel tm = new TypeModel();
            TypeProfileClient tc = new TypeProfileClient();
            tm.Facility_Ids = type_id;
            tm.Flag = "";
            tc.deletetypepm(tm, SessionController.ConnectionString);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:closeWindow();", true);
            //ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>closeWindow();</script>");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void btnDeleteTypeWithComponent_Click(object sender, EventArgs e)
    {
        try
        {
            TypeModel tm = new TypeModel();
            TypeProfileClient tc = new TypeProfileClient();
            tm.Facility_Ids = Request.QueryString["type_id"].ToString();
            tm.Flag = "TC";
            tc.deletetypepm(tm, SessionController.ConnectionString);
            ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>closeWindow();</script>");
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
}