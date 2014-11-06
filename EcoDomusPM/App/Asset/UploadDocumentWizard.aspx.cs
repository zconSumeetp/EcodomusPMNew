using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;

public partial class App_Asset_UploadDocumentWizard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session.Remove("BulkUploadDocumentIds");
            Session.Remove("BulkUploadFacilityId");
            if (SessionController.Users_.UserId != null && !SessionController.Users_.UserId.Equals(string.Empty))
            {

                string tab_uploadDocument = (string)GetGlobalResourceObject("Resource", "Upload_Document");
                AddTab(tab_uploadDocument, "UCUploadDocument", true);
                
                RadPageView pageView = new RadPageView();
                pageView.ID = @"~/App/UserControls/" + "UCUploadDocument";
                rmp_upload_document.PageViews.Add(pageView);
                AddTabImage("", "UCUploadDocument", false);
                string tab_mapDocument = (string)GetGlobalResourceObject("Resource", "Map_Document");
                AddTab(tab_mapDocument, "UCMapDocuments", false);
                AddTabImage("", "UCMapDocuments", false);                
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
            rts_upload_document.Tabs.Add(tab);
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
            rts_upload_document.Tabs.Add(tab);
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    
    
    protected void rts_uplaod_document_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
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
    protected void rmp_uplaod_document_PageViewCreated(object sender, Telerik.Web.UI.RadMultiPageEventArgs e)
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

           
        }

    }
}