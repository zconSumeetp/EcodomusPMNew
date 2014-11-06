using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using UserControl;
using System.Data;
using System.Threading;
using System.Globalization;
using EcoDomus.Session;
using SetupSync;

public partial class App_Settings_SetupSync : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, System.EventArgs e)
    {
        //if (!Page.IsPostBack)
        //{
        //    Session["external_SystemId"] = Guid.Empty;
        //    Session["configuration_id"] = Guid.Empty;
        //}

        //27Jan 2012
         if (!Page.IsPostBack)
        {

            if (Request.QueryString["pk_external_system_configuration_id"] == Guid.Empty.ToString())
            {
                AddTab("Sync Profile", true);
                RadPageView pageView = new RadPageView();
                pageView.ID = @"~/App/UserControls/" + "SyncProfile";
                rmpageSetupSync.PageViews.Add(pageView);
                AddTab("Facility", false);
                //AddTab("Asset Type", false);
                //AddTab("Space Type", false);
                AddTab("Map Integration", false);
                AddTab("Scheduler", false);
            }
            else
            {
                SessionController.Users_.Configuration_id = Request.QueryString["pk_external_system_configuration_id"].ToString();
                AddTab("Sync Profile", true);
                RadPageView pageView = new RadPageView();
                pageView.ID = @"~/App/UserControls/" + "SyncProfile";
                rmpageSetupSync.PageViews.Add(pageView);
                AddTab("Facility", true);
                //AddTab("Asset Type", true);
                //AddTab("Space Type", true);
                AddTab("Map Integration", true);
                AddTab("Scheduler", true);

            }
        }
         
         

    }


    private void AddTab(string tabName, bool enabled)
    {
        RadTab tab = new RadTab(tabName);
        tab.Enabled = enabled;
       
        rdstripSetupSync.Tabs.Add(tab);
    }

    //27Jan 2012
    protected void RadMultiPage1_PageViewCreated(object sender, RadMultiPageEventArgs e)
    {
        Control pageViewContents = LoadControl(e.PageView.ID + "CS.ascx");
        pageViewContents.ID = e.PageView.ID + "userControl";

        e.PageView.Controls.Add(pageViewContents);
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


    protected void rdstripSetupSync_TabClick(object sender, RadTabStripEventArgs e)
    {
        try
        {
            string TabName = e.Tab.Text.Replace(" ","").Trim().ToString();
            GoToNextPageView(TabName);
        }
        catch (Exception ex)
        {
            //Response.Write("<script>alert('" + Server.HtmlEncode(ex.Message) + "')</script>");
            throw ex;
        }
    }

    private void GoToNextPageView(string TabName)
    {
        try
        {
            if (hf_external_system.Value.Equals("Tekla")&&TabName.Equals("MapIntegration"))
            {
                TabName = "AttributeMapping";
            }

            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            RadMultiPage multiPage = (RadMultiPage)userContentHolder.FindControl("rmpageSetupSync");
            RadPageView PageView = multiPage.FindPageViewByID(@"~/App/UserControls/" + TabName.ToString());
            if (PageView == null)
            {
                PageView = new RadPageView();
                PageView.ID = @"~/App/UserControls/" +TabName.ToString();

                multiPage.PageViews.Add(PageView);
            }
            PageView.Selected = true;
            //Session["bindGrid"] = "Y";


        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
}