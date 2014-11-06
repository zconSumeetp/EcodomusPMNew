using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;

public partial class App_NewUI_EnergyModelingProjects : System.Web.UI.Page
{
    #region PageEvents
    protected void Page_Load(object sender, EventArgs e)
    {
        Guid pk_facility_id;
        if (SessionController.Users_.UserId!=null)
        {
            if (!IsPostBack)
            {

                if ( Convert.ToString( Request.QueryString["pk_facility_id"]) != null)
                {
                    pk_facility_id = new Guid( Convert.ToString( Request.QueryString["pk_facility_id"]));
                    SessionController.Users_.Em_facility_id = Convert.ToString( pk_facility_id);

                }

            }
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);

    }
    #endregion
}