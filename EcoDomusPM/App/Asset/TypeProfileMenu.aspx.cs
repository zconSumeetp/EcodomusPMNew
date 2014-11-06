using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using Asset;
using Telerik.Web.UI;
using System.Globalization;
using System.Threading;

public partial class App_Asset_TypeProfileMenu : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {

                if (SessionController.Users_.UserId != null)
                {
                    //Int32 screenresolution;
                    //if (Session["ScreenResolution"] == null)
                    //{
                    //    // Session variable is not set
                    //    // Redirect to the screen resolution detection script
                    //    if (Request.QueryString["type_id"] != null && Request.QueryString["type_id"] != Guid.Empty.ToString() )
                    //    {
                    //        Response.Redirect("TypeJobs.aspx?Type_id=" + Convert.ToString(Request.QueryString["type_id"]) + "&name=type");
                    //    }
                    //}
                    //else
                    //{
                    //    // Session variable is set
                    //    // Display it on the page 

                    //    screenresolution = Convert.ToInt32(Session["ScreenResolution"].ToString());
                    //}        

                    if (Request.QueryString["pagevalue"] == null)
                    {
                        if (Request.QueryString["type_id"] != null)
                        {
                            string value = "";
                            if (Request.QueryString["page_load"] != null)
                            {

                                value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','TypeProfile.aspx?type_id=" + Request.QueryString["type_id"] + "'+'&value=type');</script>";//sitemapSystem();
                            }//added

                            else if (Request.QueryString["type_id"] == Guid.Empty.ToString())
                            {
                                value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','TypeProfile.aspx?type_id=" + Request.QueryString["type_id"] + "'+'&value=blank');</script>";//sitemapSystem();
                            }
                            else if (Request.QueryString["type_id"] != null && Request.QueryString["isFromMissingAttribute"] != null)
                            {

                                    hfMissingAttribute.Value = Request.QueryString["attribute_name"].ToString();
                                    value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','TypeAttribute.aspx?entity_id=" + Request.QueryString["type_id"] + "&entity_name=Type&attribute_name=" + hfMissingAttribute.Value + "');</script>";//sitemapSystem();
                                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
                                    rtsTypeProfile.SelectedIndex = 1;
                               

                            }

                            else
                            {
                                //value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','TypeAttribute.aspx?entity_id=" + Request.QueryString["type_id"] + "&entity_name=Type');</script>";//sitemapSystem();
                                value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','TypeProfileNew.aspx?type_id=" + Request.QueryString["type_id"] + "');</script>";//sitemapSystem();
                            }
                            //HiddenField1.Value = Request.QueryString["IsfromClient"];

                            //string value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','TypeProfilePM.aspx?type_id=" + Request.QueryString["type_id"] + "');</script>";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);

                            //Type.Visible = true;
                            hf_type_id.Value = Request.QueryString["type_id"].ToString();

                            //lbltypeprofile.Text = "Type Profile";

                            Guid derypted_type_id = new Guid(hf_type_id.Value);
                            if (derypted_type_id == Guid.Empty)
                            {
                                //rmSettingsMenu.Style.Add("display", "none");
                                rtsTypeProfile.Style.Add("display", "none");
                            }

                            else
                            {
                                rtsTypeProfile.Style.Add("display", "inline");

                                //rmSettingsMenu.Style.Add("display", "inline");
                            }
                            if (Request.QueryString["type_id"] == Guid.Empty.ToString())
                            {
                                TypeProfile.Visible = true;
                                //lbltypeprofile.Text = "Type Profile";
                            }
                            else
                            {
                                //////To get the name of current system:- //////////////////////
                                Type.Visible = true;

                                // Systems.SystemsModel objSysModel = new Systems.SystemsModel();
                                // Systems.SystemsClient objSysClient = new Systems.SystemsClient();
                                TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
                                TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
                                DataSet ds_systemprofile = new DataSet();
                                try
                                {
                                    if (hf_type_id.Value == Guid.Empty.ToString())
                                    {
                                        mdl.Type_Id = Guid.Empty;
                                    }
                                    else
                                    {
                                        mdl.Type_Id = new Guid(hf_type_id.Value);
                                    }
                                    DataSet ds1 = new DataSet();
                                    ds1 = TypeClient.GetTypeProfileInformation(mdl, SessionController.ConnectionString);
                                    string typename = ds1.Tables[0].Rows[0]["type_name"].ToString();
                                    lbltypename.Text = typename;
                                    // BindDataToControls(ds);
                                    /// bindfacilityinformation(TypeId);
                                    // disableControl();

                                }
                                catch (Exception ex)
                                {
                                    throw ex;
                                    //lblMsg.Text = "BindTypeProfileInformation:" + ex.ToString();
                                }
                            }
                            //try
                            //{
                            //    DataSet ds1 = new DataSet();
                            //    DataSet ds_fac = new DataSet();
                            //    TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
                            //    TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
                            //    mdl.Type_Id = new Guid(hf_type_id.Value);
                            //    ds1 = TypeClient.GetTypeProfileInformation(mdl, SessionController.ConnectionString);
                            //    string typename = ds1.Tables[0].Rows[0]["type_name"].ToString();
                            //    lblTypeName.Text = typename;
                            //}
                            //catch (Exception ex) {
                            //    throw ex;
                            //}
                        }
                        //else if (Request.QueryString["type_id"] != null)
                        //{
                        //    //HiddenField1.Value = Request.QueryString["IsfromClient"];

                        //    string value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','Product.aspx?type_id=" + Request.QueryString["type_id"] + "');</script>";
                        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
                        //    hfOrgid.Value = Request.QueryString["organizationid"].ToString();
                        //    Guid derypted_org_id = new Guid(hfOrgid.Value);
                        //    if (derypted_org_id == Guid.Empty)
                        //    {
                        //        rmSettingsMenu.Style.Add("display", "none");
                        //    }
                        //    else
                        //    {
                        //        rmSettingsMenu.Style.Add("display", "inline");
                        //    }
                        //}

                    }
                    else
                    {
                        hf_type_id.Value = Request.QueryString["type_id"].ToString();
                        string abvalue = Request.QueryString["pagevalue"].ToString();
                        TypeProfile.Visible = true;
                        string value = "<script language='javascript'>pageload('" + abvalue + "')</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
                        Session.Add("type_id", new Guid(Request.QueryString["type_id"].ToString()));
                    }
                    DataSet ds = new DataSet();
                    AssetClient ObjAsset_crtl = new AssetClient();
                    AssetModel ObjAsset_mdl = new AssetModel();
                    ObjAsset_mdl.EntityName = "Type";
                    ObjAsset_mdl.Culture = Session["Culture"].ToString();
                    ds = ObjAsset_crtl.get_customised_left_menu(ObjAsset_mdl, SessionController.ConnectionString);
                    //rmSettingsMenu.DataTextField = "page_heading";
                    //rmSettingsMenu.DataFieldID = "pk_setting_page_id";
                    //rmSettingsMenu.DataNavigateUrlField = "NavigateUrl";
                    //rmSettingsMenu.DataValueField = "page_heading";
                    //rmSettingsMenu.DataSource = ds;
                    //rmSettingsMenu.DataBind();
                    rtsTypeProfile.DataTextField = "page_heading1";
                    rtsTypeProfile.DataFieldID = "pk_setting_page_id";
                    //rtsTypeProfile.DataNavigateUrlField = "NavigateUrl";
                    rtsTypeProfile.DataValueField = "page_heading";
                    rtsTypeProfile.DataSource = ds;
                    rtsTypeProfile.DataBind();
                }


            }
            else
            {
                string Updatedvalue = "<script language='javascript'>top.window.CallClickEvent(~/App/loginPM.aspx)')</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script", Updatedvalue);
            }
        }
        catch (Exception ex)
        {
            Response.Write("Page_Load :-" + ex.Message.ToString());
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
    protected void btnclick_Click(object sender, EventArgs e)
    {

        string tabName = hfSelectedIndex.Value;
        //if (tabName.Equals((string)GetGlobalResourceObject("Resource", "Components")))
        //{
        //    tabName = (string)GetGlobalResourceObject("Resource", "Assets");
        //}
        if (tabName.Contains(" "))
        {
            tabName = tabName.Trim().Replace(" ", "_");
        }
        ContentPlaceHolder ctnobj = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
        if (ctnobj != null)
        {
            RadTabStrip tabStrip = (RadTabStrip)ctnobj.FindControl("rtsTypeProfile");
            if (tabStrip != null)
            {
                RadTab objTab = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", tabName));
                if (objTab != null)
                {
                    objTab.Enabled = true;
                    objTab.Selected = true;
                }
            }
        }
        //string tabIndex = hfSelectedIndex.Value;
        //if (tabIndex == (string)GetGlobalResourceObject("Resource", "Type_Profile"))
        //{
        //    rtsTypeProfile.SelectedIndex = 0;
        //    hfSelectedIndex.Value = "";
        //}
        //if (tabIndex == (string)GetGlobalResourceObject("Resource", "Attributes"))
        //{
        //    rtsTypeProfile.SelectedIndex = 1;
        //    hfSelectedIndex.Value = "";
        //}
        //if (tabIndex == (string)GetGlobalResourceObject("Resource", "Components"))
        //{
        //    rtsTypeProfile.SelectedIndex = 2;
        //    hfSelectedIndex.Value = "";
        //}
        //if (tabIndex == (string)GetGlobalResourceObject("Resource", "Documents"))
        //{
        //    rtsTypeProfile.SelectedIndex = 3;
        //    hfSelectedIndex.Value = "";
        //}


    }
}