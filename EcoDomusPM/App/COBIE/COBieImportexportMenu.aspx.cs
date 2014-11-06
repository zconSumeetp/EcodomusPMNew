using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Threading;
using System.Globalization;
using EcoDomus.Session;
using System.Data;

public partial class App_COBIE_COBieImportexportMenu : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!IsPostBack)
        {
            rdstripcobie.SelectedIndex = 0;
          
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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }
    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    SetPermissions();
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='BIM Server'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Projects")
                {
                    SetPermissionToControl(dr_profile);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SetPermissionToControl(DataRow dr)
    {
        Permissions objPermission = new Permissions();
        string delete_permission = dr["delete_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();
        if (edit_permission == "N")
        {
            //rdstripcobie.Tabs[1].Enabled = false;
        }
        else
        {
            //rdstripcobie.Tabs[1].Enabled = true;
        }
    }
}