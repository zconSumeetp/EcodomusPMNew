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
                    sortExpr.FieldName = "issuename";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgIssue.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                    if (Request.QueryString["facility_id"] != null)
                    {
                        try
                        {
                            Issue.IssueClient IssueClient = new Issue.IssueClient();
                            Issue.IssueModel IssueModel = new Issue.IssueModel();
                            IssueModel.Fk_issue_type_id = new Guid(Request.QueryString["Issue_type_id"].ToString());
                            IssueModel.FacilityID = new Guid(Request.QueryString["facility_id"].ToString());
                            DataSet ds = IssueClient.GetAllIssuesGIS(IssueModel, SessionController.ConnectionString.ToString());
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
                    else
                    {
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

    private void GetAllIssues(string issuestatus)
    {
        try
        {
            Issue.IssueClient IssueClient = new Issue.IssueClient();
            Issue.IssueModel IssueModel = new Issue.IssueModel();
            IssueModel.Issue_status = issuestatus;
            IssueModel.Column_name = cmb_CategoryType.SelectedItem.Value;
            IssueModel.Column_value = txtSearch_Issue.Text.ToString();
            if (rdpfrom.SelectedDate!=null)
            IssueModel.Frmdate = rdpfrom.SelectedDate.Value;
            if (rdpto.SelectedDate != null)
            IssueModel.Todate = rdpto.SelectedDate.Value;
            DataSet ds = IssueClient.GetAllIssuesPM(IssueModel, SessionController.ConnectionString.ToString());
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

        Response.Redirect("../Asset/IssueProfile.aspx?issue_id=00000000-0000-0000-0000-000000000000", true);
    }

    protected void rgIssue_ItemCommand(object sender, GridCommandEventArgs e)
    {
        Guid issues_id;
        try
        {
            if (e.CommandName == "Profile")
            {
                issues_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_issues_id"].ToString());
                Response.Redirect("../Asset/IssueProfile.aspx?issue_id=" + issues_id + "&flag=issue", false);
            }
            if (e.CommandName == "deleteIssue")
            {
                issues_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_issues_id"].ToString());
                Issue.IssueClient IssueClient = new Issue.IssueClient();
                Issue.IssueModel IssueModel = new Issue.IssueModel();
                IssueModel.Pk_issues_id = issues_id;
                IssueClient.DeleteIssue(IssueModel, SessionController.ConnectionString);
                Getstatus();
            }

            if (e.CommandName == "closeIssue")
            {
                issues_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_issues_id"].ToString());
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

            if (btnShowAI.Text == "Show Open Issues")
            {

                btnShowAI.Text = "Show All Issues";
                GetAllIssues("Open");
            }
            else
            {

                btnShowAI.Text = "Show Open Issues";
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
                //LaborValue = LaborValue.Replace("\"", "'");
                LaborValue = LaborValue.Replace("!span", "<span").Replace("span!", "</span>").Replace("@$", ">").Replace("!hash!", "#");
                e.Item.Cells[5].Text = LaborValue;

                GridDataItem item = (GridDataItem)e.Item;
                string strflag = item["IssueStatus"].Text.ToString();
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

            if (btnShowAI.Text == "Show Open Issues")
            {
                btnShowAI.Text = "Show All Issues";
                issue_status = "All";
            }
            else
            {
                btnShowAI.Text = "Show Open Issues";
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
            parameterstring = "?filter=" + filter+ "&todate=" + to_date + "&fromdate=" + from_date + "&columnvalue=" + txt_Search + "&columnname=" + cmb_value + "&issuestatus=" + issue_status+"&connectionstring="+SessionController.ConnectionString+"";
           

            string querystring = Request.Url.AbsoluteUri.ToString() + parameterstring;
            querystring = querystring.Replace("Issues", "IssuePDFs");


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



    protected void btn_Search_Click(object sender, EventArgs e)
    {
        Getstatus();
    }
    
}