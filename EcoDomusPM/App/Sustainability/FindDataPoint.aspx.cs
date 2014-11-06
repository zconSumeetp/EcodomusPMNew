using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;

public partial class App_Sustainability_FindDataPoint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if(SessionController.Users_.UserId != null)
            {
                
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
        
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {

        if (Request.QueryString["flag_master"] == "nomaster")
        {
            Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";

        }
    }
}