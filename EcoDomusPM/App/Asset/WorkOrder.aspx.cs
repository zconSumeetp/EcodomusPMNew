using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using EcoDomus.Session;
using Telerik.Web.UI;
using Winnovative.WnvHtmlConvert;
using System.Threading;
using Facility;
using System.Globalization;


public partial class App_Asset_Issues : System.Web.UI.Page
{

    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                }
                else
                {
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "created_on";
                    sortExpr.SortOrder = GridSortOrder.Descending;
                    //Add sort expression, which will sort against first column
                    rgIssue.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    if (Request.QueryString["facility_id"] != null)
                    {
                        try
                        {
                            Issue.IssueClient IssueClient = new Issue.IssueClient();
                            Issue.IssueModel IssueModel = new Issue.IssueModel();
                            IssueModel.Fk_issue_type_id = new Guid(Request.QueryString["work_order_type_id"].ToString());
                            IssueModel.FacilityID = new Guid(Request.QueryString["facility_id"].ToString());
                            DataSet ds = IssueClient.GetAllIssuesGIS(IssueModel, SessionController.ConnectionString.ToString());
                            if (ds.Tables.Count > 0)
                            {
                                rgIssue.DataSource = ds;
                                rgIssue.DataBind();
                            }
                            else
                            {

                                rgIssue.DataSource = string.Empty;
                                rgIssue.DataBind();
                            }
                        }
                        catch (Exception ex)
                        {

                            throw ex;
                        }
                    }
                    else
                    {
                        BindFacilities();
                        /*custom paging */
                        ViewState["IssuePageSize"] = "10";
                        ViewState["IssuePageIndex"] = "0";

                        GetAllIssues("Open");
                    }

                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    #endregion

    #region Private Methods

    protected void BindFacilities()
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        DataSet ds = new DataSet();
        try
        {
            fm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
            fm.Search_text_name = "";
            fm.Doc_flag = "floor";
            cmb_facility.DataTextField = "name";
            cmb_facility.DataValueField = "pk_facility_id";
            ds = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);
            cmb_facility.DataSource = ds;
            cmb_facility.DataBind();


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    private void GetAllIssues(string issuestatus)
    {
        try
        {
            Issue.IssueClient IssueClient = new Issue.IssueClient();
            Issue.IssueModel IssueModel = new Issue.IssueModel();

            System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
            foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmb_facility.Items)
            {
                if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
                {
                    facilityvalues.Append(rcbItem.Value);
                    facilityvalues.Append(",");
                }
            }
            if (facilityvalues.Length > 0)
            {
                facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
            }

            //added
            hffacids.Value = facilityvalues.ToString();
            //

            IssueModel.Facilityids = facilityvalues.ToString();


            IssueModel.Issue_status = issuestatus;
            IssueModel.Column_name = cmb_CategoryType.SelectedItem.Value;
            IssueModel.Column_value = txtSearch_Issue.Text.ToString();
            if (rdpfrom.SelectedDate != null)
                IssueModel.Frmdate = rdpfrom.SelectedDate.Value;
            if (rdpto.SelectedDate != null)
                IssueModel.Todate = rdpto.SelectedDate.Value;
            DataSet ds_count = IssueClient.GetAllWorkOrdersCountV2(IssueModel, SessionController.ConnectionString.ToString());

            IssueModel.Pageindex = Convert.ToInt32(ViewState["IssuePageIndex"].ToString());
            IssueModel.Pagesize = Convert.ToInt32(ViewState["IssuePageSize"].ToString());
            rgIssue.MasterTableView.VirtualItemCount = Convert.ToInt32(ds_count.Tables[0].Rows[0]["cntWorkOrder"]);
            rgIssue.VirtualItemCount = Convert.ToInt32(ds_count.Tables[0].Rows[0]["cntWorkOrder"]);
            DataSet ds = IssueClient.GetAllWorkOrdersV2(IssueModel, SessionController.ConnectionString.ToString());
            if (ds.Tables.Count > 0)
            {
                rgIssue.DataSource = ds;
                rgIssue.DataBind();
            }
            else
            {
                ds = null;
                rgIssue.DataSource = string.Empty;
                rgIssue.DataBind();
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rgIssue_OnItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {


    }
    int TotalItemCount;
    protected void rgIssue_OnItemEvent(object sender, GridItemEventArgs e)
    {

        if (e.EventInfo is GridInitializePagerItem)
        {

            TotalItemCount = (e.EventInfo as GridInitializePagerItem).PagingManager.DataSourceCount;

        }
        hfcount.Value = TotalItemCount.ToString();

    }

    //private void GetAllIssues(string issuestatus)
    //{
    //    try
    //    {
    //        Issue.IssueClient IssueClient = new Issue.IssueClient();
    //        Issue.IssueModel IssueModel = new Issue.IssueModel();

    //        System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
    //        foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmb_facility.Items)
    //        {
    //            if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
    //            {
    //                facilityvalues.Append(rcbItem.Value);
    //                facilityvalues.Append(",");
    //            }
    //        }
    //        if (facilityvalues.Length > 0)
    //        {
    //            facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
    //        }

    //        //added
    //        hffacids.Value = facilityvalues.ToString();
    //        //

    //        IssueModel.Facilityids = facilityvalues.ToString();


    //        IssueModel.Issue_status = issuestatus;
    //        IssueModel.Column_name = cmb_CategoryType.SelectedItem.Value;
    //        IssueModel.Column_value = txtSearch_Issue.Text.ToString();
    //        if (rdpfrom.SelectedDate!=null)
    //        IssueModel.Frmdate = rdpfrom.SelectedDate.Value;
    //        if (rdpto.SelectedDate != null)
    //        IssueModel.Todate = rdpto.SelectedDate.Value;
    //        DataSet ds = IssueClient.GetAllWorkOrders(IssueModel, SessionController.ConnectionString.ToString());
    //        if (ds.Tables.Count > 0)
    //        {
    //            rgIssue.DataSource = ds;
    //            rgIssue.DataBind();
    //        }
    //        else
    //        {
    //            ds = null;
    //            rgIssue.DataSource = string.Empty;
    //            rgIssue.DataBind();
    //        }           

    //    }
    //    catch (Exception ex)
    //    {

    //        throw ex;
    //    }

    //}

    private void Getstatus()
    {
        try
        {
            if (btnShowAI.Text == "Show Open Work Order")
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
        try
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
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

    #region Event Handlers

    protected void btnaddissue_click(object sender, EventArgs e)
    {

        Response.Redirect("../Asset/WorkOrderProfile.aspx?work_order_id=00000000-0000-0000-0000-000000000000", true);
    }

    protected void rgIssue_ItemCommand(object sender, GridCommandEventArgs e)
    {
        Guid issues_id;
        try
        {
            if (e.CommandName == "Profile")
            {
                issues_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_work_order_id"].ToString());
                Response.Redirect("../Asset/WorkOrderProfile.aspx?work_order_id=" + issues_id + "&flag=issue", false);
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
            ViewState["IssuePageIndex"] = e.NewPageIndex.ToString();
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
            if (e.NewPageSize != 10 && e.NewPageSize != 20 && e.NewPageSize != 50)
            {
                ViewState["IssuePageIndex"] = 0;
                ViewState["IssuePageSize"] = 0;

            }
            else
            {
                ViewState["IssuePageSize"] = e.NewPageSize.ToString();

                int issue_count = Int32.Parse(hfcount.Value);
                int page_size = Int32.Parse(e.NewPageSize.ToString());
                int page_index = Int32.Parse(ViewState["IssuePageIndex"].ToString());
                int maxpg_index = (issue_count / page_size) + 1;
                if (page_index >= maxpg_index)
                {
                    ViewState["IssuePageIndex"] = 0;

                }

            }
            if (e.Item is GridPagerItem)
            {
                RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                cb.Items.FindItemByValue(rgIssue.PageSize.ToString()).Selected = true;
            }
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
                //LaborValue = LaborValue.Replace("\"", "'");
                LaborValue = LaborValue.Replace("!span", "<span").Replace("span!", "</span>").Replace("@$", ">").Replace("!hash!", "#");
                e.Item.Cells[5].Text = LaborValue;

                GridDataItem item = (GridDataItem)e.Item;
                string strflag = item["work_orderstatus"].Text.ToString();
                if (strflag.Equals("Resolved"))
                {
                    e.Item.FindControl("imgbtnclose").Visible = false;
                }



            }
            /* custom paging */
            if (e.Item is GridPagerItem)
            {
                RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                cb.Items.Clear();

                RadComboBoxItem item = new RadComboBoxItem("10", "10");

                item.Attributes.Add("ownerTableViewId", rgIssue.MasterTableView.ClientID);
                if (hfcount.Value != "")
                {
                    if (Convert.ToInt32(hfcount.Value) >= 10)
                    {
                        if (cb.Items.FindItemByValue("10") == null)
                            cb.Items.Add(item);
                    }
                }
                if (hfcount.Value != "")
                {
                    if (Convert.ToInt32(hfcount.Value) >= 20)
                    {
                        item = new RadComboBoxItem("20", "20");
                        item.Attributes.Add("ownerTableViewId", rgIssue.MasterTableView.ClientID);
                        if (cb.Items.FindItemByValue("20") == null)
                            cb.Items.Add(item);
                    }
                }
                if (hfcount.Value != "")
                {
                    if (Convert.ToInt32(hfcount.Value) <= 50 && Convert.ToInt32(hfcount.Value) >= 20)
                    {
                        item = new RadComboBoxItem("50", "50");
                        item.Attributes.Add("ownerTableViewId", rgIssue.MasterTableView.ClientID);
                        if (cb.Items.FindItemByValue("50") == null)
                            cb.Items.Add(item);
                    }
                    if (Convert.ToInt32(hfcount.Value) >= 50)
                    {
                        item = new RadComboBoxItem("50", "50");
                        item.Attributes.Add("ownerTableViewId", rgIssue.MasterTableView.ClientID);
                        if (cb.Items.FindItemByValue("50") == null)
                            cb.Items.Add(item);
                    }
                }

                //item = new RadComboBoxItem("All", hfcount.Value);
                //item.Attributes.Add("ownerTableViewId", rgIssue.MasterTableView.ClientID);
                //if (cb.Items.FindItemByValue("All") == null)
                //    cb.Items.Add(item);



                cb.Items.Sort(new PagerRadComboBoxItemComparer());
                if (cb.Items.FindItemByValue(rgIssue.PageSize.ToString()) != null)
                    cb.Items.FindItemByValue(rgIssue.PageSize.ToString()).Selected = true;




            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

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

            //  Project_Id = new Guid(Session["ProjectId"].ToString());
            from_date = Convert.ToString(rdpfrom.DbSelectedDate);
            to_date = Convert.ToString(rdpto.DbSelectedDate);

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

            //  System.Collections.Generic.IList<RadTreeNode> LocationnodeCollection = rtvlabor.CheckedNodes;

            string locationNode = "";
            //foreach (RadTreeNode node in LocationnodeCollection)
            //{
            //    locationNode = locationNode + node.Value.ToString() + ",";
            //}
            //if (locationNode.Length > 0)
            //    locationNode = locationNode.Substring(0, locationNode.Length - 1);

            labor_id = locationNode;
            parameterstring = "?filter=" + filter + "&todate=" + to_date + "&fromdate=" + from_date + "&columnvalue=" + txt_Search + "&columnname=" + cmb_value + "&issuestatus=" + issue_status + "&facilityids=" + hffacids.Value + "&connectionstring=" + SessionController.ConnectionString + "";


            string querystring = Request.Url.AbsoluteUri.ToString() + parameterstring;
            querystring = querystring.Replace("WorkOrder", "WorkOrderPDFs");


            string urlToConvert = querystring;

            string downloadName = "IssuePDF.pdf";

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

    protected void navigate_space(object sender, EventArgs e)
    {
        Guid space_id;
        space_id = new Guid(hf_space_id.Value.ToString());
        Response.Redirect("~/App/Locations/FacilityMenu.aspx?&pageValue=Space Profile" + "&id=" + space_id, false);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ViewState["IssuePageIndex"] = 0;
        ViewState["IssuePageSize"] = 10;
        Getstatus();
    }

    protected void navigate(object sender, EventArgs e)
    {
        GetAllIssues("Open");
    }

    protected void cmbfacility_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        try
        {
            ((CheckBox)e.Item.FindControl("CheckBox1")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                Button1.Visible = false;
                foreach (GridDataItem item in rgIssue.MasterTableView.Items)
                {
                    ImageButton btn_img = item.FindControl("imgbtnDelete") as ImageButton;
                    if (btn_img != null)
                    {
                        btn_img.Visible = false;
                    }

                }
            }
            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    SetPermissions();
                }
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
            DataRow dr_component = ds_component.Tables[0].Select("name='BIM Server'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Activities")
                {
                    SetPermissionToControl(dr_profile);
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
        string delete_permission = dr["delete_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();


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

        if (edit_permission == "N")
        {
            foreach (GridDataItem item in rgIssue.MasterTableView.Items)
            {
                ImageButton imgbtnClose = (ImageButton)item.FindControl("imgbtnclose");
                imgbtnClose.Enabled = false;
            }

            Button1.Enabled = false;
        }
        else
        {
            foreach (GridDataItem item in rgIssue.MasterTableView.Items)
            {
                ImageButton imgbtnClose = (ImageButton)item.FindControl("imgbtnclose");
                imgbtnClose.Enabled = true;

            }

            Button1.Enabled = true;
        }
    }
}