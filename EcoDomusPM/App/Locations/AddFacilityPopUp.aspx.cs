using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;

public partial class App_Locations_AddFacilityPopUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { 
        
        
        }

    }
    protected override void InitializeCulture()
    {
        try
        {
            string culture = Session["Culture"].ToString();
            if (culture == null)
            {
                culture = "en-US";
            }
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
        }
        catch (Exception ex)
        {

            Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        if (rdbtnAddNewFaciltiy.Checked)
        {
            try
            {
                string facility_id = Guid.Empty.ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "Navigate('"+facility_id+"');", true);
               
            }
            catch (Exception ex)
            {
                throw ex;

            }
        }
        else if (rdbtnAddExistingFacility.Checked)
        {
            try
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NavigateToFacility();", true);
               
            }
            catch (Exception ex)
            {
                throw ex;

            }


        }

    }

    protected void rdbtnAddNewFaciltiy_checked(object sender, EventArgs e)
    {
       
    }
    protected void rdbtnAddExistingFacility_checked(object sender, EventArgs e)
    {
        
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "CloseWindow();", true);
    }
}