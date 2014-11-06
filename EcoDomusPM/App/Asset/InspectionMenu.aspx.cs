using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using System.Data;
using Asset;
using System.Threading;
using System.Globalization;

public partial class App_Asset_InspectionMenu : System.Web.UI.Page
{

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

    protected void Page_Load(object sender, EventArgs e)
    {
        try 
        {
            if (SessionController.Users_.UserId.ToString() != null)
            {
                if (Request.QueryString["InspectionId"] == Guid.Empty.ToString())
                {
                    string value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','InspectionProfile.aspx');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
                }

                else if (Request.QueryString["InspectionId"] != Guid.Empty.ToString())
                    { 

                    string abvalue = Request.QueryString["pagevalue"].ToString();
                    hfInspectionID.Value = Request.QueryString["InspectionId"].ToString();
                    string id = hfInspectionID.Value;
                    string value = "<script language='javascript'>pageload('" + abvalue + "','" + id + "')</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
                    rmSettingsMenu.Style.Add("display", "inline");

                    }
                    DataSet ds = new DataSet();

                    AssetClient ObjAsset_crtl = new AssetClient();
                    AssetModel ObjAsset_mdl = new AssetModel();

                    ObjAsset_mdl.EntityName = "Inspection";
                    ds = ObjAsset_crtl.get_customised_left_menu(ObjAsset_mdl, SessionController.ConnectionString);

                    rmSettingsMenu.DataTextField = "page_heading";
                    rmSettingsMenu.DataFieldID = "pk_setting_page_id";
                    rmSettingsMenu.DataNavigateUrlField = "NavigateUrl";
                    rmSettingsMenu.DataValueField = "page_heading";
                    rmSettingsMenu.DataSource = ds;
                    rmSettingsMenu.DataBind();

            }
            
            else 
            {
                Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            }
            
        }
        catch(Exception)
        {
            throw;
        }
       
    }
}