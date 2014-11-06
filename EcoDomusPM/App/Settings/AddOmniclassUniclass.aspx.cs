using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using TypeProfile;
using System.Globalization;
using System.Threading;
using System.Data;
using Telerik.Web.UI;

public partial class App_Settings_AddOmniclassUniclass : System.Web.UI.Page
{
    string type_id = "";
    string ids = "";
    string Master_flag = "";
    string UniClass_flag = "";
    string UniFormat_flag = "";
    string OmniClass_flag = "";
    string show_hide_categories = "";
    string pageViewId = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["type_id"] != null)
        {
            string id = Request.QueryString["type_id"].ToString();
            id = id.Substring(0, id.Length - 1);
            string[] parameters = id.Split(',');
            foreach (string id1 in parameters)
            {
                type_id = type_id + id1 + ",";

            }
            ids = type_id.Substring(0, type_id.Length - 1);
         
        }
        if (!IsPostBack)
        {
            show_hide_tabs();
            //Page.ClientScript.RegisterStartupScript(GetType(), "manage_height", "adjust_height();", true);

        }




    }

    protected void show_hide_tabs()
    {

        AddTab("OmniClass", true);
        RadPageView pageView = new RadPageView();
        pageView.ID = @"~/App/Locations/UCOmniclassUniclass.ascx";
        pageViewId = pageView.ID;
        RadMultiPage1.PageViews.Add(pageView);
        AddTabImage("", "", false);
        AddTab("UniClass", true);


    }
    protected void show_hide_tabs_according_to_category()
    {
        DataSet ds_TypeCount = new DataSet();

        DataSet ds = new DataSet();
        TypeModel tm = new TypeModel();
        TypeProfileClient tc = new TypeProfileClient();

        tm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
        tm.Flag = "type";
        tm.Txt_Search = "";
        ds_TypeCount = tc.bindtypepm_count_v1(tm, SessionController.ConnectionString);

        if (ds_TypeCount.Tables[2] != null)
        {
            if (ds_TypeCount.Tables[2].Rows.Count > 0)
            {
                for (int i = 0; i < ds_TypeCount.Tables[2].Rows.Count; i++)
                {
                    if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "MasterFormat")
                    {
                        Master_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                    }
                    else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "OmniClass 2010")
                    {
                        OmniClass_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                    }
                    else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "UniFormat")
                    {
                        UniFormat_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                    }
                    else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "UniClass")
                    {
                        UniClass_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                    }
                }
            }
            if (OmniClass_flag != "")
            {
                AddTab("OmniClass", true);
                RadPageView pageView = new RadPageView();
                pageView.ID = @"~/App/Locations/Omniclass.ascx";
                pageViewId = pageView.ID;
                RadMultiPage1.PageViews.Add(pageView);
                if (UniFormat_flag != "" || UniClass_flag != "" || Master_flag != "")
                {
                    AddTabImage("", "", false);
                }
            }

            if (UniClass_flag != "")
            {
                AddTab("UniClass", true);
                if (pageViewId == "")
                {
                    RadPageView pageView = new RadPageView();
                    pageView.ID = @"~/App/Locations/UCUniclass.ascx";
                    pageViewId = pageView.ID;
                    RadMultiPage1.PageViews.Add(pageView);
                }
            }

        }
    }

    private void AddTab(string tabName, bool enabled)
    {
        RadTab tab = new RadTab();
        tab.Enabled = enabled;
        tab.Width = 100;
        //tab.Height = 50;
        //tab.BorderWidth = 0;
        tab.Text = tabName;
        RadTabStrip1.Tabs.Add(tab);
    }
    private void AddTabImage(string tabName, string tabValue, bool enabled)
    {
        try
        {

            RadTab tab = new RadTab(tabName);
            tab.Enabled = enabled;
            tab.DisabledImageUrl = "~/App/Images/Icons/asset_scrollbar_bar.png";
            tab.Height = 30;
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

    protected void RadMultiPage1_PageViewCreated(object sender, RadMultiPageEventArgs e)
    {
        Control pageViewContents = LoadControl(e.PageView.ID);
        pageViewContents.ID = e.PageView.ID + "omnimasteruniformat";
        e.PageView.Controls.Add(pageViewContents);
    }

    private void AddPageView(RadTab tab)
    {
        RadPageView pageView = new RadPageView();
        pageView.ID = tab.Text;
        RadMultiPage1.PageViews.Add(pageView);
        pageView.CssClass = "pageView";
        tab.PageViewID = pageView.ID;
    }

    protected void rdstripSetupSync_TabClick(object sender, RadTabStripEventArgs e)
    {
        try
        {
            string TabName = e.Tab.Text.Replace(" ", "").Trim().ToString();
            GoToNextPageView(TabName);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_height();", true);
        }
        catch (Exception ex)
        {
            //Response.Write("<script>alert('" + Server.HtmlEncode(ex.Message) + "')</script>");
            throw ex;
        }
    }

    protected void RadTabStrip1_TabClick(object sender, RadTabStripEventArgs e)
    {
        AddPageView(e.Tab);
        e.Tab.PageView.Selected = true;
    }



    private void GoToNextPageView(string TabName)
    {
        try
        {

            RadMultiPage multiPage = (RadMultiPage)FindControl("RadMultiPage1");
            if (TabName.Equals("OmniClass"))
            {
                RadPageView PageView = multiPage.FindPageViewByID(@"~/App/Locations/UCOmniclassUniclass.ascx");
                if (PageView == null)
                {
                    PageView = new RadPageView();
                    PageView.ID = @"~/App/Locations/Omniclass.ascx";
                    multiPage.PageViews.Add(PageView);
                }
                PageView.Selected = true;
                
                //div_assign.Style.Add("display", "none");


            }
          
            else if (TabName.Equals("UniClass"))
            {
                RadPageView PageView = multiPage.FindPageViewByID(@"~/App/Locations/UCOmniclassUniclass.ascx");
                if (PageView == null)
                {
                    PageView = new RadPageView();
                    PageView.ID = @"~/App/Locations/UCUniclass.ascx";
                    multiPage.PageViews.Add(PageView);
                }
                PageView.Selected = true;
                //div_assign.Style.Add("display", "none");


            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void ibtn_close_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "CloseWindow();", true);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
}