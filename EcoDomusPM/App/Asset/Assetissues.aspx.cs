using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using Winnovative.WnvHtmlConvert;
using System.Threading;
using System.Globalization;
using WorkOrder;
using Inspections;


public partial class App_Asset_Assetissues : System.Web.UI.Page
{
    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
         string fk_asset_id="";
         string inspection_id = "";

         try
         {

             if (SessionController.Users_.UserId != null)
             {
                 ///////////////////Ashok:Date-28/12/2011///////////////////////////
                 if (Request.QueryString["assetid"] != null)
                 {
                     fk_asset_id = Request.QueryString["assetid"].ToString();
                     if (!IsPostBack)
                     {
                         WorkOrderModel wm = new WorkOrderModel();
                         WorkOrderClient wc = new WorkOrderClient();
                         DataSet ds = new DataSet();
                         wm.Fk_Asset_Id = fk_asset_id.ToString();
                         ds = wc.GetAssetName(wm, SessionController.ConnectionString);
                         //lblName.Text = ds.Tables[0].Rows[0]["name"].ToString();
                     }

                 }

                 if (Request.QueryString["inspectionid"] != null)
                 {
                     inspection_id = Request.QueryString["inspectionid"].ToString();
                     if (!IsPostBack)
                     {
                         DataSet ds = new DataSet();
                         Inspections.InspectionModel objins_mdl = new InspectionModel();
                         Inspections.InspectionsClient objins_ctrl = new InspectionsClient();

                         objins_mdl.Inspection_id = new Guid(inspection_id);
                         ds = objins_ctrl.proc_get_inspection_data(objins_mdl, SessionController.ConnectionString);

                         if (ds.Tables[0].Rows.Count > 0)
                         {
                             //lblName.Text = ds.Tables[0].Rows[0]["name"].ToString();
                         }
                     }
                 }

                 if (!Page.IsPostBack)
                 {
                     GridSortExpression sortExpr = new GridSortExpression();
                     sortExpr.FieldName = "created_on";
                     sortExpr.SortOrder = GridSortOrder.Descending;
                     //Add sort expression, which will sort against first column
                     rgIssue.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                     GetAllIssues("Open");


                 }
             }
             else
             {
                 ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
             
             }
         }

                       //////////////////////////////////////////////////////////////////////////


         catch (Exception ex)
         {

             throw ex;
         }


    }

    #endregion

    #region Private Methods

    private void GetAllIssues(string issuestatus)
    {
        try
        {
            Issue.IssueClient IssueClient = new Issue.IssueClient();
            Issue.IssueModel IssueModel = new Issue.IssueModel();

            switch (Request.QueryString["assetid"])
            {
                case null:
                    IssueModel.Fk_asset_id = new Guid("00000000-0000-0000-0000-000000000000");
                    break;
    
                   default:
                    IssueModel.Fk_asset_id = new Guid(Request.QueryString["assetid"]);
                    break;
            }

            switch (Request.QueryString["inspectionid"])
            {
                case null:
                    IssueModel.Inspection = new Guid("00000000-0000-0000-0000-000000000000");
                    break;

                default:
                    IssueModel.Inspection = new Guid(Request.QueryString["inspectionid"]);
                    break;
            }
            
            IssueModel.Issue_status = issuestatus;
            IssueModel.Column_name = cmb_CategoryType.SelectedItem.Value;
            IssueModel.Column_value = txtSearch_Issue.Text.ToString();
            IssueModel.Search_text = txtSearch_Issue.Text.ToString();
            
            if (rdpfrom.SelectedDate != null)
                IssueModel.Frmdate = rdpfrom.SelectedDate.Value;
            if (rdpto.SelectedDate != null)
                IssueModel.Todate = rdpto.SelectedDate.Value;

            //DataSet ds = IssueClient.GetAssetsIssuesPM(IssueModel, SessionController.ConnectionString.ToString());
            DataSet ds = IssueClient.GetAssetsIssues(IssueModel, SessionController.ConnectionString.ToString());


            if (ds.Tables.Count > 0)
            {
                rgIssue.DataSource = ds;
                rgIssue.DataBind();
            }
            else
            {
                ds = null;
                rgIssue.DataSource = ds;
                rgIssue.DataBind();
            }


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

            //redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

    private void Getstatus()
    {
        try
        {
            if (btnShowAI.Text == "Show Open Issues")
            {

                // btnShowAI.Text = "Show All Issues";
                GetAllIssues("All");
            }
            else
            {

                //btnShowAI.Text = "Show Open Issues";
                GetAllIssues("Open");

            }
        }
        catch (Exception ex)
        {

            throw ex;
        }




    }

    private PdfConverter GetPdfConverter()
    {
        PdfConverter pdfConverter = new PdfConverter();



        pdfConverter.LicenseKey = "NB8FFAUUBBQBGgQUBwUaBQYaDQ0NDQ==";

        pdfConverter.PdfDocumentOptions.PdfCompressionLevel = PdfCompressionLevel.Normal;
        pdfConverter.PdfDocumentOptions.PdfPageOrientation = PDFPageOrientation.Portrait;
        pdfConverter.PdfDocumentOptions.ShowHeader = false;
        pdfConverter.PdfDocumentOptions.ShowFooter = true;
        pdfConverter.PdfDocumentOptions.LeftMargin = 20;
        pdfConverter.PdfDocumentOptions.RightMargin = 10;
        pdfConverter.PdfDocumentOptions.TopMargin = 10;
        pdfConverter.PdfDocumentOptions.BottomMargin = 10;
        pdfConverter.PdfDocumentOptions.GenerateSelectablePdf = true;
        pdfConverter.PdfDocumentOptions.LiveUrlsEnabled = false;
        pdfConverter.PdfDocumentOptions.FitWidth = true;
        pdfConverter.PdfDocumentOptions.AutoSizePdfPage = false;
        pdfConverter.PdfDocumentOptions.EmbedFonts = true;



        pdfConverter.PageWidth = 1500;

        pdfConverter.AvoidImageBreak = false;

        pdfConverter.PdfFooterOptions.FooterText = "";
        pdfConverter.PdfFooterOptions.DrawFooterLine = false;
        pdfConverter.PdfFooterOptions.PageNumberText = "Page";
        pdfConverter.PdfFooterOptions.ShowPageNumber = true;

        pdfConverter.PdfBookmarkOptions.TagNames = false ? new string[] { "h1", "h2" } : null;

        return pdfConverter;
    }

    #endregion

    #region Event Handlers

    protected void btnaddissue_click(object sender, EventArgs e)
    {
      ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "NavigateIssueProfile", "NavigateAddIssue('" + Request.QueryString["assetid"] + "','" + Request.QueryString["inspectionid"] + "');", true);
    }

    protected void rgIssue_ItemCommand(object sender, GridCommandEventArgs e)
    {
        Guid issues_id;
        try
        {
            if (e.CommandName == "Profile")
            {
                issues_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_work_order_id"].ToString());
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "NavigateIssueProfile", "NavigateIssueProfile('" + issues_id + "');", true);
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "NavigateIssueProfile", "NavigateAddIssue('" + issues_id + "','" + Request.QueryString["assetid"] + "');", true);
                          
            }
            if (e.CommandName == "deleteIssue")
            {
                issues_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_work_order_id"].ToString());
                Issue.IssueClient IssueClient = new Issue.IssueClient();
                Issue.IssueModel IssueModel = new Issue.IssueModel();
                IssueModel.Pk_issues_id = issues_id;
                IssueClient.DeleteIssue(IssueModel, SessionController.ConnectionString);
                Getstatus();
            }

            if (e.CommandName == "closeIssue")
            {
                issues_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_work_order_id"].ToString());
                Issue.IssueClient IssueClient = new Issue.IssueClient();
                Issue.IssueModel IssueModel = new Issue.IssueModel();
                IssueModel.Pk_issues_id = issues_id;
                IssueModel.Issue_status = "Resolved";
                IssueClient.UpdateIssueStatus(IssueModel, SessionController.ConnectionString);
                Getstatus();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnShowAI_click(object sender, EventArgs e)
    {
        try
        {

            if (btnShowAI.Text == (string)GetGlobalResourceObject("Resource", "Show_Open_Issue"))
            {

                btnShowAI.Text = (string)GetGlobalResourceObject("Resource", "Show_All_Issues");
                GetAllIssues("Open");
            }
            else
            {

                btnShowAI.Text = (string)GetGlobalResourceObject("Resource", "Show_Open_Issue");
                GetAllIssues("All");

            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rgIssue_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
    {

        try
        {
            Getstatus();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    protected void rgIssue_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            Getstatus();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    protected void rgIssue_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {

            if (e.Item is GridDataItem)
            {
                string LaborValue = e.Item.Cells[5].Text;
                LaborValue = LaborValue.Replace("\"", "'");
                LaborValue = LaborValue.Replace("!span", "<span").Replace("span!", "</span>").Replace("@$", ">").Replace("!hash!", "#");
                e.Item.Cells[5].Text = LaborValue;

                GridDataItem item = (GridDataItem)e.Item;
                string strflag = item["work_orderstatus"].Text.ToString();
                if (strflag.Equals("Resolved"))
                {
                    e.Item.FindControl("imgbtnclose").Visible = false;
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Getstatus();
    }

    protected void rgIssue_OnSortCommand(object source, GridSortCommandEventArgs e)
    {
        Getstatus();
    }

    protected void btnpdf_click(object sender, EventArgs e)
    {

        try
        {

            string parameterstring = "";
            string from_date = "";
            string to_date = "";
            string labor_id = "";
            string issue_status = "";
            string filter = "";
            string txt_Search = "";
            string cmb_value = "";

            
            from_date = Convert.ToString(rdpfrom.DbSelectedDate);
            to_date = Convert.ToString(rdpto.DbSelectedDate);

            //if (btnShowAI.Text == "Show Open Issues")
            //{
            //    btnShowAI.Text = "Show All Issues";
            //    issue_status = "All";
            //}
            //else
            //{
            //    btnShowAI.Text = "Show Open Issues";
            //    issue_status = "Open";
            //}


            if (btnShowAI.Text == (string)GetGlobalResourceObject("Resource", "Show_Open_Issue"))
            {
                btnShowAI.Text = (string)GetGlobalResourceObject("Resource", "Show_All_Issues");
                issue_status = "All";
            }
            else
            {
                btnShowAI.Text = (string)GetGlobalResourceObject("Resource", "Show_Open_Issue");
                issue_status = "Open";
            }




            txt_Search = txtSearch_Issue.Text.Trim();
            cmb_value = cmb_CategoryType.SelectedValue;

            

            string locationNode = "";

            //string fac_id = Request.QueryString["facilityid"].ToString();

            //string assetid = Request.QueryString["assetid"].ToString();

            
            labor_id = locationNode;
            parameterstring = "&filter=" + filter + "&todate=" + to_date + "&fromdate=" + from_date + "&columnvalue=" + txt_Search + "&columnname=" + cmb_value + "&issuestatus=" + issue_status +   "&connectionstring=" + SessionController.ConnectionString + "";


            string querystring = Request.Url.AbsoluteUri.ToString() + parameterstring;
            querystring = querystring.Replace("Assetissues", "WorkOrderPDFs");


            string urlToConvert = querystring;

            string downloadName = "WorkOrderPDF.pdf";

            if (!Page.IsValid)
                return;
            byte[] downloadBytes = null;

            PdfConverter pdfConverter = GetPdfConverter();

            downloadBytes = pdfConverter.GetPdfBytesFromUrl(urlToConvert);

            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Cache.SetCacheability(HttpCacheability.Private);
            Response.Expires = -1;
            Response.Buffer = false;
            System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;

            response.AddHeader("Content-Type", "binary/octet-stream");
            response.AddHeader("Content-Disposition",
                "attachment; filename=" + downloadName + "; size=" + downloadBytes.Length.ToString());

            Response.BinaryWrite(downloadBytes);
            Response.End();





        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

    #region roles_permission


    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                btnaddissue.Visible = false;
                foreach (GridDataItem item in rgIssue.MasterTableView.Items)
                {
                    ImageButton btn_img = item.FindControl("imgbtnDelete") as ImageButton;
                    if (btn_img != null)
                    {
                        btn_img.Enabled = false;
                    }

                }
            }
            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
            {
                SetPermissions();
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }


    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='Component'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Work Orders")
                {
                    SetPermissionToControl(dr_profile);
                    //DataRow[] dr_fields_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_profile["pk_project_role_controls"] + "'");
                    //foreach (DataRow dr in dr_fields_component)
                    //{
                    //    SetPermissionToControl(dr);
                    //}

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    private void SetPermissionToControl(DataRow dr)
    {
        Permissions objPermission = new Permissions();
      //  string add_permission = dr["add_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();
        // Add permission
        //if (dr["Control_id"].ToString() == "btnaddissue")
        //{
        //    objPermission.SetEditable(btnaddissue, add_permission);
        //}

        // edit permission
        if (edit_permission == "N")
        {
            rgIssue.Columns[1].Display = false;
            btnaddissue.Enabled = false;
            foreach (GridDataItem item in rgIssue.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnclose");
                imgbtnDelete.Enabled = false;
            }
        }
        else
        {
            rgIssue.Columns[1].Display = true;
            btnaddissue.Enabled = true;
            foreach (GridDataItem item in rgIssue.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnclose");
                imgbtnDelete.Enabled = true;
            }

        }

        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rgIssue.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }

        }
        else
        {
            foreach (GridDataItem item in rgIssue.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = true;
            }
        }

    }
    

    #endregion
}