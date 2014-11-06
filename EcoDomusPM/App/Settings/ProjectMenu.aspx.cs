using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using System.Data;
using Project;
using Asset;
using System.Threading;
using System.Globalization;

public partial class App_Settings_ProjectMenu : System.Web.UI.Page
{
    
    //protected override void InitializeCulture()
    //{
    //    try
    //    {
    //        string culture = Session["Culture"].ToString();
    //        if (culture == null)
    //        {
    //            culture = "en-US";
    //        }
    //        Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
    //        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
    //    }
    //    catch (Exception ex)
    //    {

    //        redirect_page("~\\app\\LoginPM.aspx?Error=Session");
    //    }

    //}

    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Request.QueryString["flag"] == "no_master")
        {
            Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";
           
        }
        //if(Request.QueryString["flag1"] == "new" && Request.QueryString["flag"] != "no_master")
        //{
        //    Page.MasterPageFile = "~/App/EcoDomusMaster.master"; 
        //    //blank_master = 0;
        //}
    }
    public void redirect_page(string url)
    {
        Response.Redirect(url, false);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                string s = SessionController.Users_.is_PM_FM.ToString();

                if (Request.QueryString["Flag"] == "no_master")
                {
                    hf_no_master.Value = "no_master";
                }

                if (Request.QueryString["ispage"] == "organization" )
                {
                    hfProjectID.Value = Request.QueryString["pk_project_id"].ToString();
                    hforgid.Value = Request.QueryString["org_id"].ToString();
                    hforgname.Value = Request.QueryString["org_name"].ToString();                    
                    hfispage.Value = Request.QueryString["ispage"].ToString();

                    string abvalue = Request.QueryString["pagevalue"].ToString();
                    string value = "<script language='javascript'>pageload('" + abvalue + "')</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
                    rmSettingsMenu.Style.Add("display", "none");
                }

                if (Request.QueryString["Flag"] == "no_master" && Request.QueryString["pagevalue"] == "ProjectProfile" && Request.QueryString["Flag"] !=null && Request.QueryString["pagevalue"] !=null)
                {
                    string value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','ProjectProfile.aspx');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
                }

                //else if (Request.QueryString["pk_project_id"] != null)  //if (SessionController.Users_.ProjectId != Guid.Empty.ToString())
               //  else if (Request.QueryString["pk_project_id"] != Guid.Empty.ToString())
                else if (Request.QueryString["pk_project_id"] != null && Request.QueryString["ispage"] != "organization")
                {
                    if (Request.QueryString["Flag"] == "SPP")
                    {
                   
                        BindPageDetails();
                    }
                    else
                    {
                   
                        BindPageDetails();
                        lblProjectName.Text ="Project Name : "+ SessionController.Users_.ProjectName.ToString();
                        //lblProjectName.Css = "profileName";
                    }
                }
                else
                {
                    if (Request.QueryString["ispage"] == "organization")
                    {
                        rmSettingsMenu.Style.Add("display", "none");
                    }
                    else
                    {
                        lblProjectName.Text = "Project Profile:";
                        BindPageDetails();
                    }
                }
               
            }

            else
            {
                Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void BindPageDetails()
    {
        string abvalue = Request.QueryString["pagevalue"].ToString();
        //hfProjectID.Value = SessionController.Users_.ProjectId;
        
        if(Request.QueryString["pk_project_id"]!=null)
      //  if (Request.QueryString["pk_project_id"] != Guid.Empty.ToString())
        hfProjectID.Value = Request.QueryString["pk_project_id"].ToString();
        else
            hfProjectID.Value = Request.QueryString["ProjectId"].ToString();

        string id = hfProjectID.Value;
        string value = "<script language='javascript'>pageload('" + abvalue + "','" + id + "')</script>";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);

        if (Request.QueryString["pk_project_id"] != null)
        {
            DataSet ds = new DataSet();

            AssetClient ObjAsset_crtl = new AssetClient();
            AssetModel ObjAsset_mdl = new AssetModel();
            ObjAsset_mdl.Culture = Session["culture"].ToString();
            ObjAsset_mdl.EntityName = "Project";
            ds = ObjAsset_crtl.get_customised_left_menu(ObjAsset_mdl, SessionController.ConnectionString);
            rmSettingsMenu.DataTextField = "page_heading";
            rmSettingsMenu.DataFieldID = "pk_setting_page_id";
            rmSettingsMenu.DataNavigateUrlField = "NavigateUrl";
            rmSettingsMenu.DataValueField = "page_heading";
            rmSettingsMenu.DataSource = ds;
            rmSettingsMenu.DataBind();

            rtsProjectProfile.DataTextField = "page_heading";
            rtsProjectProfile.DataFieldID = "pk_setting_page_id";
            rtsProjectProfile.DataNavigateUrlField = "NavigateUrl";
            rtsProjectProfile.DataValueField = "page_heading";
            rtsProjectProfile.DataSource = ds;
            rtsProjectProfile.DataBind();
            hf_page_id.Value = ds.Tables[0].Rows[0]["pk_setting_page_id"].ToString();
            rmSettingsMenu.Style.Add("display", "inline");
        }
        else
            rmSettingsMenu.Style.Add("display", "none");

        //DataSet ds = new DataSet();

        //AssetClient ObjAsset_crtl = new AssetClient();
        //AssetModel ObjAsset_mdl = new AssetModel();

        //ObjAsset_mdl.EntityName = "Project";
        //ds = ObjAsset_crtl.get_customised_left_menu(ObjAsset_mdl, SessionController.ConnectionString);
        //rmSettingsMenu.DataTextField = "page_heading";
        //rmSettingsMenu.DataFieldID = "pk_setting_page_id";
        //rmSettingsMenu.DataNavigateUrlField = "NavigateUrl";
        //rmSettingsMenu.DataValueField = "page_heading";
        //rmSettingsMenu.DataSource = ds;
        //rmSettingsMenu.DataBind();

        //rtsProjectProfile.DataTextField = "page_heading";
        //rtsProjectProfile.DataFieldID = "pk_setting_page_id";
        //rtsProjectProfile.DataNavigateUrlField = "NavigateUrl";
        //rtsProjectProfile.DataValueField = "page_heading";
        //rtsProjectProfile.DataSource = ds;
        //rtsProjectProfile.DataBind();
        //hf_page_id.Value = ds.Tables[0].Rows[0]["pk_setting_page_id"].ToString();

    }
}