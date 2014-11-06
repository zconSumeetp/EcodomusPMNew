using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;



public partial class App_NewUI_EnergyModelingWizardWindow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (SessionController.Users_.UserId != null && !SessionController.Users_.UserId.Equals(string.Empty))
            {
                AddTab("Select Facility", "EnergyPlusFacility", true);
                RadPageView pageView = new RadPageView();
                pageView.ID = @"~/App/UserControls/UserControlNewUI/" + "EnergyPlusFacility";
                rmp_energy_plus.PageViews.Add(pageView);
                AddTabImage("", "EnergyPlusFacility", false);

                AddTab("Select Template", "EnergyPlusTemplate", false);
                AddTabImage("", "EnergyPlusTemplate", false);

                AddTab("Select Data", "EnergyPlusData", false);
                AddTabImage("", "EnergyPlusData", false);

                AddTab("Import Data", "EnergyPlusImportData", false);
                AddTabImage("", "EnergyPlusImportData", false);

                AddTab("Finish", "Finish", true);
            }
        }
       
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
                rts_energy_plus.Tabs.Add(tab);
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }

    private void AddTab(string tabName, string tabValue, bool enabled)
    {
        try
        {
            RadTab tab = new RadTab(tabName);
            tab.Enabled = enabled;
            tab.Value = tabValue;
            rts_energy_plus.Tabs.Add(tab);
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
       
    }

    protected void btn_close_Click(object sender, EventArgs e)
    {
        try
        {
             //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "CloseWindow();", true);
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
    protected void rts_energy_plus_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        try
        {
            if (e.Tab.Text.Equals("Finish"))
            {
                ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
            }

        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void rmp_energy_plus_PageViewCreated(object sender, Telerik.Web.UI.RadMultiPageEventArgs e)
    {
        try
        {
            Control pageViewContents = LoadControl(e.PageView.ID + ".ascx");
            pageViewContents.ID = e.PageView.ID + "userControl";
            e.PageView.Controls.Add(pageViewContents);

        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
}