using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using TypeProfile;
using System.Data;
using System.Threading;
using System.Globalization;

 
public partial class App_Asset_EditDesignerContractorNew : System.Web.UI.Page
{

    string type_id = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["type_id"] != null)
        {
            string id = Request.QueryString["type_id"].ToString();
            Session["type_id"] = id;
            string[] parameters = id.Split(',');
            if (parameters.Length >= 1)
            {
                type_id = parameters[0];
            }
            else
            {
                type_id = parameters[0];
            }
            
        }
        if (!IsPostBack)
        {
          
            if (Request.QueryString["flag"] == null)
            {
                AddTab((string)GetGlobalResourceObject("Resource", "Designer"));
                RadPageView pageView = new RadPageView();
                pageView.ID = @"~/App/Locations/Designer.ascx";
                AddTabImage("", "", false);
                RadMultiPage1.PageViews.Add(pageView);
                AddTab((string)GetGlobalResourceObject("Resource", "Contractor"));
                radbtnAssignMaster.Visible = false;
               // lbl_header.Text = (string)GetGlobalResourceObject("Resource", "Assign_DesignerContractor");
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:adjust_height('name');", true);
            }
            else
            {


                if (Request.QueryString["flag"] == "Designer")
                {
                    AddTab("Designer");
                    RadPageView pageView = new RadPageView();
                    pageView.ID = @"~/App/Locations/Designer.ascx";
                    RadMultiPage1.PageViews.Add(pageView);
                    GoToNextPageView("Designer");
                    RadTabStrip1.Tabs[0].Selected = true;
                    RadTabStrip1.Visible = false;
                    //lbl_header.Text = (string)GetGlobalResourceObject("Resource", "Assign_Designer");
                }
                else if (Request.QueryString["flag"] == "Contractor")
                {
                    AddTab("Contractor");
                    GoToNextPageView("Contractor");
                    RadTabStrip1.Tabs[0].Selected = true;
                    RadTabStrip1.Visible = false;
                   // lbl_header.Text = (string)GetGlobalResourceObject("Resource", "Assign_Contractor");
                    //if (Request.QueryString["popupflag"].ToString().Equals("popup"))
                    //{

                    //}
                }

            }
        }

    }
    protected override void InitializeCulture()
    {
        if (SessionController.Users_.UserId != null)
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
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }
    private void AddTab(string tabName)
    {
        RadTab tab = new RadTab();
        tab.Enabled = true;
        tab.Text = tabName;

        RadTabStrip1.Tabs.Add(tab);
    }
    protected void btn_click(object sender, EventArgs e)
    {
        //RadComboBox rcbcombo = new RadComboBox();
        //rcbcombo = (RadComboBox)RadMultiPage1.FindPageViewByID(@"~/App/Locations/Designer.ascx").Controls[0].FindControl("rg_masterformat");
        //string id = "";
        //string name = "";
        //id = rcbcombo.SelectedValue;
        //name = rcbcombo.SelectedItem.Text;
        //if (!string.IsNullOrEmpty(type_id))
        //{
        //    TypeModel tm = new TypeModel();
        //    TypeProfileClient tc = new TypeProfileClient();
        //    tm.Type_Id = new Guid(type_id);
        //    tm.Flag = "D";
        //    tm.DesignerOrContractor_id= new Guid(id);
        //    tc.UpdateDesignerContractorPM(tm, SessionController.ConnectionString);

        //ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:selectformat('" + id + "','" + name + "');", true);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:refreshpage();", true);
        //}
        //else
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:selectformat('" + id + "','" + name + "');", true);
        //}


    }
    protected void rdstripSetupSync_TabClick(object sender, RadTabStripEventArgs e)
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
    private void GoToNextPageView(string TabName)
    {
        try
        {
            RadMultiPage multiPage = (RadMultiPage)FindControl("RadMultiPage1");
            if (TabName.Equals("Designer"))
            {
                RadPageView PageView = multiPage.FindPageViewByID(@"~/App/Locations/Designer.ascx");
                if (PageView == null)
                {
                    PageView = new RadPageView();
                    PageView.ID = @"~/App/Locations/Designer.ascx";
                    multiPage.PageViews.Add(PageView);
                }
                PageView.Selected = true;
                radbtnAssignMaster.Visible = false;

            }
            else if (TabName.Equals("Contractor"))
            {
                RadPageView PageView = multiPage.FindPageViewByID(@"~/App/Locations/Contractor.ascx");
                if (PageView == null)
                {
                    PageView = new RadPageView();
                    PageView.ID = @"~/App/Locations/Contractor.ascx";
                    multiPage.PageViews.Add(PageView);
                }
                PageView.Selected = true;
                radbtnAssignMaster.Visible = false;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void RadMultiPage1_PageViewCreated(object sender, RadMultiPageEventArgs e)
    {
        Control pageViewContents = LoadControl(e.PageView.ID);
        pageViewContents.ID = e.PageView.ID + "Designer";
        e.PageView.Controls.Add(pageViewContents);
    }
      private void AddTabImage(string tabName, string tabValue, bool enabled)
    {
        try
        {
            RadTab tab = new RadTab(tabName);
            tab.Enabled = enabled;
            tab.DisabledImageUrl = "~/App/Images/Icons/asset_scrollbar_bar.png";
            tab.Width = 15;
            tab.BorderWidth = 0;
            tab.IsSeparator = false;
            RadTabStrip1.Tabs.Add(tab);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

}