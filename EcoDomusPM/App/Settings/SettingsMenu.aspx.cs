using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;


public partial class App_Settings_SettingsMenu : System.Web.UI.Page
{
    int userFlag = 0; //for checking that user is clicking from dashboard or user role

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
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
               
                if (SessionController.Users_.UserId != null)
                {
                    //to show faclities of assigned organization in client, user is not OA
                    if (Request.QueryString["user_role"] != null)
                    {
                        
                        hfOrgPrimaryContactRole.Value = Request.QueryString["user_role"].ToString();
                        if (hfOrgPrimaryContactRole.Value.ToString() != "" || hfOrgPrimaryContactRole.Value.ToString() != null)
                        {
                            userFlag = 1;
                        }
                    }
                        
                    if (Request.QueryString["UserId"] != null)
                    {
                        hfOrgPrimaryContact.Value = Request.QueryString["UserId"].ToString();
                    }
                    if (Request.QueryString["Organization_name"] != null)
                    {
                        hforganization_name.Value = Request.QueryString["Organization_name"].ToString();
                    }
                    
                    if (Request.QueryString["pagevalue"] == null)
                    {
                        if (Request.QueryString["organization_id"] != null && Request.QueryString["ProductId"] == null)
                        {
                            HiddenField1.Value = Request.QueryString["IsfromClient"];
                           
                            string value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','OrganizationProfile.aspx?organization_id=" + Request.QueryString["organization_id"] + "');sitemap();</script>";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
                            hfOrgid.Value = Request.QueryString["organization_id"].ToString();
                            Guid derypted_org_id = new Guid(hfOrgid.Value);
                            lblProfileName.Text = "Organization Name : " + SessionController.Users_.OrganizationName.ToString();
                            if (derypted_org_id == Guid.Empty)
                            {
                                rtsSettingMenu.Style.Add("display", "none");
                            }
                            else
                            {
                                rtsSettingMenu.Style.Add("display", "inline");
                            }
                        }

                        else if (Request.QueryString["organizationid"] != null)
                        {
                            HiddenField1.Value = Request.QueryString["IsfromClient"];

                            string value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','Product.aspx?organization_id=" + Request.QueryString["organizationid"] + "');sitemapProduct();</script>";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
                            hfOrgid.Value = Request.QueryString["organizationid"].ToString();
                            Guid derypted_org_id = new Guid(hfOrgid.Value);
                            if (derypted_org_id == Guid.Empty)
                            {
                                rtsSettingMenu.Style.Add("display", "none");
                            }
                            else
                            {
                                rtsSettingMenu.Style.Add("display", "inline");
                            }
                        }
                         if (Request.QueryString["ProductId"] != null)
                        {

                            HiddenField1.Value = Request.QueryString["IsfromClient"];
                            hdfProductId.Value = Request.QueryString["ProductId"].ToString();
                            hfOrgid.Value = Request.QueryString["organization_id"].ToString();
                            
                            string value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','ProductProfile.aspx?ProductId=" + Request.QueryString["ProductId"] +"&organization_id="+hfOrgid.Value+"');sitemapProductProfile();</script>";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
                            Guid derypted_org_id = new Guid(hfOrgid.Value);
                             Guid derypted_ProductId = new Guid(hdfProductId.Value);
                            if (derypted_ProductId == Guid.Empty)
                            {
                                rtsSettingMenu.Style.Add("display", "none");
                            }
                            else
                            {
                                rtsSettingMenu.Style.Add("display", "inline");
                            }
                        }
                         if (Request.QueryString["IsFromProduct"] != null)
                         {
                             hfIsFromProduct.Value = "Y";
                         }
                       
                       
                    }
                    else
                    {
                        hfOrgid.Value = Request.QueryString["organization_id"].ToString();
                        string abvalue = Request.QueryString["pagevalue"].ToString();
                        string value = "<script language='javascript'>pageload('" + abvalue + "')</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
                        
                        Session.Add("organization_id", new Guid(Request.QueryString["organization_id"].ToString()));
                    }
                   
                     DataSet ds = new DataSet();
                     Product.ProductClient ProductClient = new Product.ProductClient();
                     Product.ProductModel ProductModel = new Product.ProductModel();

                     ProductModel.Navigateurl = "Library#";
                     ProductModel.SystemRole = SessionController.Users_.UserSystemRole.ToString();
                     
                     if (hfOrgid.Value != "0" && Request.QueryString["ProductId"]==null)
                     ProductModel.OrganizationId = new Guid(hfOrgid.Value);
                     else if (hdfProductId.Value!="0")
                         ProductModel.ProductId = new Guid(hdfProductId.Value);

                     string culture = Session["Culture"].ToString();
                     if (culture == null)
                     {
                         culture = "en-US";
                     }
                     ProductModel.Culture = culture;
                     ds= ProductClient.GetLeftMenuForOrganizationV1(ProductModel);
                     if (Session["Culture"].ToString() == "en-us")
                     {
                         rtsSettingMenu.DataTextField = "page_heading";
                     }
                     else
                     {
                         rtsSettingMenu.DataTextField = "page_heading1";
                     }
                     rtsSettingMenu.DataFieldID = "pk_setting_page_Id";
                     rtsSettingMenu.DataValueField = "page_heading";
                     rtsSettingMenu.DataSource = ds;
                     rtsSettingMenu.DataBind();
                     Remove_Password_plicyTab();
                }
            }
            else
            {
                string Updatedvalue = "<script language='javascript'>top.window.CallClickEvent(~/App/LoginPM.aspx)')</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script", Updatedvalue);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void Remove_Password_plicyTab()
    {
        var ctnobj = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
        var tabStrip = (RadTabStrip)ctnobj.FindControl("rtsSettingMenu");
        if (tabStrip != null)
        {
            var objTab = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", "Password_Policy"));
            if (objTab != null)
            {
                objTab.Visible = false;

            }
        }
    }
    //Roles and Permissions
    protected void BindAccessibleMenu()
    {
    }
    protected void btnclick_Click(object sender, EventArgs e)
    {

         string tabName = hfSelectedIndex.Value;
        if (tabName.Contains(" "))
        {
            tabName = tabName.Trim().Replace(" ", "_");
        }
        var ctnobj = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
        if (ctnobj != null)
        {
            var tabStrip = (RadTabStrip)ctnobj.FindControl("rtsSettingMenu");
            if (tabStrip != null)
            {
                var objTab = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", tabName));
                if (objTab != null)
                {
                    objTab.Enabled = true;
                    objTab.Selected = true;
                }
            }
        }
    }
    protected void rtsSettingMenu_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {

    }
    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "CBU")
            {
                var ctnobj = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
                var tabStrip = (RadTabStrip)ctnobj.FindControl("rtsSettingMenu");
                if (tabStrip != null)
                {
                    var objTab = tabStrip.FindTabByValue("Links");
                    var objTab1 = tabStrip.FindTabByValue("Phase");
                    if (objTab != null)
                    {
                        objTab.Visible = false;

                    }
                    if (objTab1 != null)
                    {
                        objTab1.Visible = false;

                    }

                }

            }



        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
}