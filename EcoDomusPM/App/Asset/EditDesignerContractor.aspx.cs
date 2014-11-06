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

public partial class App_Asset_EditDesignerContractor : System.Web.UI.Page
{
    string type_id = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Request.QueryString["type_id"] != null)
        {
            string id = Request.QueryString["type_id"].ToString();
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
                AddTab("Designer");
                RadPageView pageView = new RadPageView();
                pageView.ID = @"~/App/Locations/Designer.ascx";
                RadMultiPage1.PageViews.Add(pageView);
                AddTab("Contractor");
                radbtnAssignMaster.Visible = false;
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

                }
                else if (Request.QueryString["flag"] == "Contractor")
                {
                    AddTab("Contractor");
                    GoToNextPageView("Contractor");
                    RadTabStrip1.Tabs[0].Selected = true;
                    RadTabStrip1.Visible = false;
                }
                
            }
        }

    }
    private void AddTab(string tabName)
    {
        RadTab tab = new RadTab();
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
}