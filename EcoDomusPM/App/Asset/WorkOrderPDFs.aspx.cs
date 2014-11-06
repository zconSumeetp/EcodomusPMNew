using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;


public partial class App_Asset_IssuePDF : System.Web.UI.Page
{
    Issue.IssueModel IssueModel = new Issue.IssueModel();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            IssueModel.Issue_status = Request.QueryString["issuestatus"];
            if (Request.QueryString["columnname"] != "All")

                IssueModel.Column_name = Request.QueryString["columnname"];
            else
                IssueModel.Column_name = "";

            IssueModel.Column_value = Request.QueryString["columnvalue"];

            if (!string.IsNullOrEmpty(Request.QueryString["assetid"]))
            {
                IssueModel.Fk_asset_id = new Guid(Request.QueryString["assetid"]);
            }
            if (!string.IsNullOrEmpty(Request.QueryString["inspectionid"]))
            {
                IssueModel.Inspection = new Guid(Request.QueryString["inspectionid"]);
            }
            if ((string.IsNullOrEmpty(Request.QueryString["fromdate"])))
            {
                lblfromdate.Text = "";
                panelFrm.Visible = false;
            }
            else
            {
                IssueModel.Frmdate = Convert.ToDateTime(Request.QueryString["fromdate"]);
                lblfromdate.Text = Convert.ToDateTime(Request.QueryString["fromdate"]).ToShortDateString();
            }

            if (string.IsNullOrEmpty(Request.QueryString["todate"]))
            {
                lbltodate.Text = "";

                panelTo.Visible = false;
            }
            else
            {
                IssueModel.Todate = Convert.ToDateTime(Request.QueryString["todate"]);
                lbltodate.Text = Convert.ToDateTime(Request.QueryString["todate"]).ToShortDateString();
            }

            bindGridIssue(); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //protected override void InitializeCulture()
    //{
    //    try
    //    {
    //        string culture = Session["Culture"].ToString();
    //        if (culture == null)
    //        {
    //            culture = "en-US";
    //        }
    //        Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
    //        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
    //    }
    //    catch (Exception ex)
    //    {

    //        redirect_page("~\\app\\Login.aspx?Error=Session");
    //    }

    //}

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
    protected void bindGridIssue()
    {
        try
        {
            Issue.IssueClient IssueClient = new Issue.IssueClient();
            DataSet ds = new DataSet();
            if ((IssueModel.Fk_asset_id == null || IssueModel.Fk_asset_id == Guid.Empty) && (IssueModel.Inspection == null || IssueModel.Inspection == Guid.Empty))
            {
                IssueModel.Facilityids = Request.QueryString["facilityids"];
                ds = IssueClient.GetAllIssues(IssueModel, Request.QueryString["connectionstring"].ToString().Replace(" ", "+"));
            }
            else
                ds = IssueClient.GetAssetsIssues(IssueModel, Request.QueryString["connectionstring"].ToString().Replace(" ", "+"));
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

    protected void rgIssue_ItemDataBound(object sender, GridItemEventArgs e)
    {
        //if (e.Item is GridDataItem)
        //{
        //    string LaborValue = e.Item.Cells[5].Text;
        //    //LaborValue = LaborValue.Replace("\"", "'");
        //    //LaborValue = LaborValue.Replace("!span", "<span").Replace("span!", "</span>").Replace("@$", ">").Replace("!hash!", "#");
        //    e.Item.Cells[5].Text = LaborValue;
        //}
    }
}