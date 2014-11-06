using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Facility;
using System.Data;
using EcoDomus.Session;
using Telerik.Web.UI;

public partial class App_NewUI_FacilityDetailPM : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);

    }
    protected void OnClick_btn_searchimg(object sender, CommandEventArgs e)
    { 
    
    }
    protected void OnclickibtnEdit(object sender, EventArgs e)
    { 
    Response.Redirect("~/App/NewUI/FacilityBillinsStatements.aspx");
    }

}