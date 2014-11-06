using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using TypeProfile;
using System.Globalization;
using System.Threading;
using System.Data;
 
public partial class App_Asset_EditMasterFormatUniformatNew : System.Web.UI.Page
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
            //if (parameters.Length >= 1)
            //{
            //    type_id = parameters[0];
            //}
            //else
            //{
            //    type_id = parameters[0];
            //}
        }
        if (!IsPostBack)
        {
            show_hide_tabs();
            //Page.ClientScript.RegisterStartupScript(GetType(), "manage_height", "adjust_height();", true);

        }




    }

    protected void show_hide_tabs()
    {
        if (Request.QueryString["uniclasstypeprofile"] != null)
        {
            if (Request.QueryString["uniclasstypeprofile"] == "y")
            {
                AddTabImage("", "", false);
                AddTab("UniClass", true);
                RadPageView pageView = new RadPageView();
                pageView.ID = @"~/App/Locations/UCUniclass.ascx";
                RadMultiPage1.PageViews.Add(pageView);
                RadTabStrip1.Visible = false;
                radbtnAssignMaster.Visible = false;
                radbtnAssignUniformt.Visible = false;
            }
        }
        else
        {
            show_hide_tabs_according_to_category();

        }


    }
    protected void show_hide_tabs_according_to_category()
    {
        DataSet ds_TypeCount = new DataSet();

        DataSet ds = new DataSet();
        TypeModel tm = new TypeModel();
        TypeProfileClient tc = new TypeProfileClient();

        tm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
        tm.Flag = "type";
        tm.Txt_Search = SessionController.Users_.TypeSearchText;
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
            if (Master_flag != "")
            {
                
                AddTab("MasterFormat", true);
                if (pageViewId == "")
                {
                    RadPageView pageView = new RadPageView();
                    pageView.ID = @"~/App/Locations/MasterFormatControl.ascx";
                    pageViewId = pageView.ID;
                    RadMultiPage1.PageViews.Add(pageView);
                }
                if ( UniFormat_flag != "" || UniClass_flag != "")
                {
                    AddTabImage("", "", false);
                }
            }
            if (UniFormat_flag != "")
            {
                
                AddTab("UniFormat", true);
                if (pageViewId == "")
                {
                    RadPageView pageView = new RadPageView();
                    pageView.ID = @"~/App/Locations/UniformatControl.ascx";
                    pageViewId = pageView.ID;
                    RadMultiPage1.PageViews.Add(pageView);
                }
                if (UniClass_flag != "")
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


            if (OmniClass_flag != "")
            {
                radbtnAssignMaster.Visible = false;
                radbtnAssignUniformt.Visible = false;
            }
            else if (Master_flag != "")
            {
                radbtnAssignMaster.Visible = true;
                radbtnAssignUniformt.Visible = false;
            }
            else if (UniFormat_flag != "")
            {
                radbtnAssignMaster.Visible = false;
                radbtnAssignUniformt.Visible = true;
            }
            else if (UniClass_flag != "")
            {
                radbtnAssignMaster.Visible = false;
                radbtnAssignUniformt.Visible = false;
            }


            //radbtnAssignMaster.Visible = false;
            //radbtnAssignUniformt.Visible = false;

            
        }
    }

    private void AddTab(string tabName, bool enabled)
    {
        RadTab tab = new RadTab();
        tab.Enabled = enabled;
        if(tabName.Equals("MasterFormat"))
                tab.Width = 150;
        else
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
                RadPageView PageView = multiPage.FindPageViewByID(@"~/App/Locations/Omniclass.ascx");
                if (PageView == null)
                {
                    PageView = new RadPageView();
                    PageView.ID = @"~/App/Locations/Omniclass.ascx";
                    multiPage.PageViews.Add(PageView);
                }
                PageView.Selected = true;
                //div_assign.Style.Add("display", "none");
                radbtnAssignMaster.Visible = false;
                radbtnAssignUniformt.Visible = false;


            }
            else if (TabName.Equals("MasterFormat"))
            {
                RadPageView PageView = multiPage.FindPageViewByID(@"~/App/Locations/MasterFormatControl.ascx");
                if (PageView == null)
                {

                    PageView = new RadPageView();
                    PageView.ID = @"~/App/Locations/MasterFormatControl.ascx";
                    multiPage.PageViews.Add(PageView);

                }
                PageView.Selected = true;
                //div_assign.Style["display"] = "block";
                //div_assign.Style.Add("display", "block");
                radbtnAssignMaster.Visible = true;
                radbtnAssignUniformt.Visible = false;

            }

            else if (TabName.Equals("UniFormat"))
            {
                RadPageView PageView = multiPage.FindPageViewByID(@"~/App/Locations/UniFormatControl.ascx");
                if (PageView == null)
                {
                    PageView = new RadPageView();
                    PageView.ID = @"~/App/Locations/UniFormatControl.ascx";
                    multiPage.PageViews.Add(PageView);
                }
                PageView.Selected = true;
                //div_assign.Style["display"] = "block";
                //  div_assign.Style.Add("display", "block");
                radbtnAssignMaster.Visible = false;
                radbtnAssignUniformt.Visible = true;


            }
            else if (TabName.Equals("UniClass"))
            {
                RadPageView PageView = multiPage.FindPageViewByID(@"~/App/Locations/UCUniclass.ascx");
                if (PageView == null)
                {
                    PageView = new RadPageView();
                    PageView.ID = @"~/App/Locations/UCUniclass.ascx";
                    multiPage.PageViews.Add(PageView);
                }
                PageView.Selected = true;
                //div_assign.Style.Add("display", "none");
                radbtnAssignMaster.Visible = false;
                radbtnAssignUniformt.Visible = false;


            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btn_click(object sender, EventArgs e)
    {

        RadComboBox rcbcombo = new RadComboBox();
        //RadComboBox rcbcombo = (RadComboBox)RadMultiPage1.FindPageViewByID(@"~/App/Locations/MasterFormatControl.ascx").Controls[0].FindControl("rcbLevel1");
        string id = "";
        string name = "";
        string id1 = "";
        string name1 = "";
        for (int i = 1; i <= 4; i++)
        {
            rcbcombo = (RadComboBox)RadMultiPage1.FindPageViewByID(@"~/App/Locations/MasterFormatControl.ascx").Controls[0].FindControl("rcbLevel" + i);
            if (rcbcombo.SelectedValue != Guid.Empty.ToString())
            {
                id = rcbcombo.SelectedValue;
                name = rcbcombo.SelectedItem.Text;
            }
            else
            {
                break;
            }

            id1 = id;//.Substring(0, id.Length - 1);
            name1 = name; ;//.Substring(0, id.Length - 1);
        }
        if (!string.IsNullOrEmpty(ids) && name1 != "")
        {
            TypeModel tm = new TypeModel();
            TypeProfileClient tc = new TypeProfileClient();
            tm.Type_Ids = ids;
            tm.Fk_Masterformat_Id = new Guid(id1);
            tc.UpdateMasterformatForTypePM(tm, SessionController.ConnectionString);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:selectedformat('" + id1 + "','" + name1 + "');", true);
            //ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:refreshpage();", true);
        }
        else if (name1 == "")
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:chkvalidate();", true);

        }

        else
        {
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:selectedformat('" + rcbcombo.SelectedValue + "','" + rcbcombo.SelectedItem.Text + "');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:selectedformat('" + id1 + "','" + name1 + "');", true);
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

            //redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void redirect_page(string url)
    {
        Response.Redirect(url, false);
    }

    protected void btn_click_uniFormat(object sender, EventArgs e)
    {
        RadComboBox rcbcombo = new RadComboBox();
        rcbcombo = (RadComboBox)RadMultiPage1.FindPageViewByID(@"~/App/Locations/UniFormatControl.ascx").Controls[0].FindControl("rcmb_uniformat");
        string id = "";
        string name = "";
        id = rcbcombo.SelectedValue;
        name = rcbcombo.SelectedItem.Text;
        if (!string.IsNullOrEmpty(ids) && name != " --Select--")
        {
            TypeModel tm = new TypeModel();
            TypeProfileClient tc = new TypeProfileClient();
            tm.Type_Ids = ids;
            tm.Fk_Uniformat_id = new Guid(id);
            tc.UpdateUniformatForTypePM(tm, SessionController.ConnectionString);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:selectedformat('" + id + "','" + name + "');", true);
            //ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind();", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:refreshpage();", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:selectuniformat('" + id + "','" + name + "');", true);
            ////ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:refreshpage();", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:refreshpage();", true);
        }
        else if (name == " --Select--")
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:chkuniformat();", true);

        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:selectuniformat('" + id + "','" + name + "');", true);
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