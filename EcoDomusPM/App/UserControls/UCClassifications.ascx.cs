using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;

public partial class App_UserControls_UCClassifications : System.Web.UI.UserControl
{
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {





            }
            catch (Exception ex)
            {

                Response.Redirect("~/App/LoginPM.aspx");
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }
    #endregion 
    #region Private Methods
    protected void btnBack_click(object sender, EventArgs e)
    {
        GoToNextTab();

    }
    private void GoToNextTab()
    {

        RadTabStrip tabStrip = (RadTabStrip)Page.FindControl("RadTabStrip1");
        RadTab AttribtueGroup = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", "Profile"));
        //RadTab AttribtueDetail = tabStrip.FindTabByText("Attribute Detail");
        AttribtueGroup.Enabled = true;
        AttribtueGroup.Selected = true;



        GoToNextPageView();
    }
    private void GoToNextPageView()
    {
        try
        {
            RadMultiPage multiPage = (RadMultiPage)Page.FindControl("RadMultiPage1");
            RadPageView PageView = multiPage.FindPageViewByID(@"~/App/UserControls/UCProfile.ascx");
            if (PageView == null)
            {
                PageView = new RadPageView();
                PageView.ID = @"~/App/UserControls/UCProfile.ascx";
                multiPage.PageViews.Add(PageView);
            }
            PageView.Selected = true;



        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    #endregion
    #region Event Handlers
    protected void lbtn_next_Click(object sender, EventArgs e)
    {
    }
    protected void ibtn_next_Click(object sender, ImageClickEventArgs e)
    {
     
    }
    protected void lbtn_back_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            GoToNextTab();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    protected void ibtn_back_Click(object sender, ImageClickEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            GoToNextTab();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    #endregion
}