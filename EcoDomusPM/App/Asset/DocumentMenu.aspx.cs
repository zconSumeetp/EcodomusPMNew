using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient; 
using System.Data;
using Asset;
using EcoDomus.Session;
using System.Web.UI.HtmlControls;

public partial class App_Asset_DocumentMenu : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            bindDocumentMenu();
            pageData();

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void pageData()
    {
        try
        {
            hfPageData.Value = "?DocumentId=" + Convert.ToString(Request.QueryString["DocumentId"]) + "&fk_row_id=" + Convert.ToString(Request.QueryString["fk_row_id"]) + "&entity_name=" + Convert.ToString(Request.QueryString["entity_name"]);
            //HtmlControl contentPanel1 = (HtmlControl)this.FindControl("frameSettingsMenu");
            //contentPanel1.Attributes["src"] = "DocumentProfile" + hfPageData.Value;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "setDefault();", true);

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void bindDocumentMenu()
    {
        try
        {
            DataSet ds = new DataSet();
            AssetClient ObjAsset_crtl = new AssetClient();
            AssetModel ObjAsset_mdl = new AssetModel();

            ObjAsset_mdl.EntityName = "Document";
            ObjAsset_mdl.Culture = Session["Culture"].ToString();
            ds = ObjAsset_crtl.get_customised_left_menu(ObjAsset_mdl, SessionController.ConnectionString);


            if (Session["Culture"].ToString() == "en-us")
            {
                rtsDocumentmenu.DataTextField = "page_heading";
            }
            else
            {
                rtsDocumentmenu.DataTextField = "page_heading1";
            }
            // rtsComponentProfile.DataTextField = "page_heading1";
            rtsDocumentmenu.DataFieldID = "pk_setting_page_id";
            //rtsDocumentmenu.DataNavigateUrlField = "NavigateUrl";
            rtsDocumentmenu.DataValueField = "page_heading";
            rtsDocumentmenu.DataSource = ds;
            rtsDocumentmenu.DataBind();
        }
        catch (Exception Ex)
        {
            rtsDocumentmenu.DataSource = string.Empty;
            rtsDocumentmenu.DataBind();
        }
    }

}