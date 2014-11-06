using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TypeProfile;
using EcoDomus.Session;
using System.Data;


public partial class App_Locations_UniformatControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (hf_uniformat_id.Value == "false")
            {
                binduniformat();
            }
            hf_uniformat_id.Value = "true";
        }
            
        
    }

    protected void binduniformat()
    {
        TypeModel tm = new TypeModel();
        TypeProfileClient tc = new TypeProfileClient();
        DataSet ds = new DataSet();
        try
        {
            ds = tc.GetUniformat(SessionController.ConnectionString);
            rcmb_uniformat.DataTextField = "Name";
            rcmb_uniformat.DataValueField = "Id";
            rcmb_uniformat.DataSource=ds;
            rcmb_uniformat.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}