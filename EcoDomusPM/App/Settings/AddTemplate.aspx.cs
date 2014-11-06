using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;
using AttributeTemplate;
using EcoDomus.Session;
using System.Data;

public partial class App_Settings_AddTemplate : System.Web.UI.Page 
{
    #region Global Variables Declarations
    string omniclass_detail_id = "";
    string[] ids;
    List<String> ls = new List<string>();
    string name = "";
    #endregion
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["templateId"].ToString() != null && Request.QueryString["templateId"].ToString() != "")
                {

                    hftemplate_id.Value = Request.QueryString["templateId"].ToString();
                    BindTemplate();
                    hfglobal_flag.Value = Request.QueryString["flag"].ToString();
                }

                AddTab((string)GetGlobalResourceObject("Resource", "Profile"), true);
                RadPageView pageView = new RadPageView();
                pageView.ID = @"~/App/UserControls/UCProfile.ascx";
                RadMultiPage1.PageViews.Add(pageView);
                AddTabImage("", "", false);
                AddTab((string)GetGlobalResourceObject("Resource", "Classifications"), false);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }


    }
    #endregion
    #region Private Methods
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

            //redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }
    public void BindTemplate()
    {

        try
        {
            DataSet ds = new DataSet();
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            am.Attribute_template_id = new Guid(hftemplate_id.Value.ToString());
           ds=ac.GetAttributeTemplateProfile(am, SessionController.ConnectionString);
           string name = ds.Tables[0].Rows[0]["name"].ToString();
           hfTemplate_name.Value = name;
           if (ds.Tables[1].Rows.Count > 0)
           {
               for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
               {
                   hf_facility_ids.Value =hf_facility_ids.Value+ds.Tables[1].Rows[i].ToString()+",";
               
               }
              string fac_ids=hf_facility_ids.Value;
              fac_ids = fac_ids.Substring(0, fac_ids.Length - 1);
              hf_facility_ids.Value = fac_ids;
              
           }
           hf_flag.Value = "Y";
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    private void AddTab(string tabName, bool enabled)
    {
        RadTab tab = new RadTab();
        tab.Text = tabName;
        tab.Enabled = enabled;
        //tab.CssClass = "activeCourses";
        //tab.SelectedCssClass = "activeCoursesSelected";
        RadTabStrip1.Tabs.Add(tab);
    }
    private void AddTabImage(string tabName, string tabValue, bool enabled)
    {
        try
        {
            RadTab tab = new RadTab(tabName);
            tab.Enabled = enabled;
            tab.DisabledImageUrl = "~/App/Images/Icons/asset_wizard_arrow_selected.png";
            tab.Width = 30;
            tab.IsSeparator = false;
            RadTabStrip1.Tabs.Add(tab);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    #endregion
    #region Event Handlers
    protected void RadMultiPage1_PageViewCreated(object sender, RadMultiPageEventArgs e)
    {
        Control pageViewContents = LoadControl(e.PageView.ID);
        pageViewContents.ID = e.PageView.ID + "AttributeGroup";
        e.PageView.Controls.Add(pageViewContents);
    }
    private void AddPageView(RadTab tab)
    {
        RadPageView pageView = new RadPageView();
        pageView.ID = tab.Text;
        RadMultiPage1.PageViews.Add(pageView);
        //pageView.CssClass = "pageView";
        tab.PageViewID = pageView.ID;
    }
    protected void rdstripSetupSync_TabClick(object sender, RadTabStripEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                string TabName = e.Tab.Text.Replace(" ", "").Trim().ToString();
                GoToNextPageView(TabName);
            }
            catch (Exception ex)
            {
                //Response.Write("<script>alert('" + Server.HtmlEncode(ex.Message) + "')</script>");
                throw ex;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    protected void RadTabStrip1_TabClick(object sender, RadTabStripEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            AddPageView(e.Tab);
            e.Tab.PageView.Selected = true;
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    private void GoToNextPageView(string TabName)
    {
        try
        {
            RadMultiPage multiPage = (RadMultiPage)FindControl("RadMultiPage1");
            if (TabName.Equals("Profile"))
            {
                RadPageView PageView = multiPage.FindPageViewByID(@"~/App/UserControls/UCProfile.ascx");
                if (PageView == null)
                {
                    PageView = new RadPageView();
                    PageView.ID = @"~/App/UserControls/UCProfile.ascx";
                    multiPage.PageViews.Add(PageView);
                }
                PageView.Selected = true;


            }
            else if (TabName.Equals("Classofications"))
            {
                RadPageView PageView = multiPage.FindPageViewByID(@"~/App/UserControls/UCClassifications.ascx");
                if (PageView == null)
                {
                    PageView = new RadPageView();
                    PageView.ID = @"~/App/UserControls/UCClassifications.ascx";
                    multiPage.PageViews.Add(PageView);
                }
                PageView.Selected = true;

            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    #endregion
}