using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;
using Report;
using System.Data;
using EcoDomus.Session;
using Telerik.Web.UI;

public partial class App_Reports_MissingAttributesPDFs : System.Web.UI.Page
{

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

    //        redirect_page("~\\app\\LoginPM.aspx?Error=Session");
    //    }
    //}

    public void redirect_page(string url)
    {
        
        Response.Redirect(url, false);

    }



    protected void Page_Load(object sender, EventArgs e)
    {
        GridSortExpression sortExpr = new GridSortExpression();
        sortExpr.FieldName = "omniclassname";
        sortExpr.SortOrder = GridSortOrder.Ascending;
        rg_missing_attribute_reports.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
       bindmissingattributes();      
    }

    protected void bindmissingattributes()
    {
        ReportModel rm = new ReportModel();
        ReportClient rc = new ReportClient();
        DataSet ds = new DataSet();
        try
        {

            rm.Entity_id = new Guid(Request.QueryString["entity"].ToString());
            rm.Facility_id = Request.QueryString["facilityid"].ToString();
            rm.Standardname = Request.QueryString["omniclass"].ToString();
            rm.Search_text = Request.QueryString["text"].ToString();
            rm.majorflag = Request.QueryString["ismajor"].ToString();

            ds = rc.GetMissingAttributes(rm, Request.QueryString["connectionstring"].ToString().Replace(" ", "+"));
            if (ds.Tables[0].Rows.Count > 0)
            {
                rg_missing_attribute_reports.DataSource = ds;
                rg_missing_attribute_reports.DataBind();
            }
            else
            {
                rg_missing_attribute_reports.DataSource = ds;
                rg_missing_attribute_reports.DataBind();
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //protected void bindmissingattributes()
    //{
    //    ReportModel rm = new ReportModel();
    //    ReportClient rc = new ReportClient();
    //    DataSet ds = new DataSet();
    //    try
    //    {
            
    //        rm.Entity_id = new Guid(Request.QueryString["entity"].ToString());
    //        rm.Facility_id = Request.QueryString["facilityid"].ToString();
    //        rm.Standardname = Request.QueryString["omniclass"].ToString();
    //        rm.Search_text = Request.QueryString["text"].ToString();

    //        ds = rc.GetMissingAttributes(rm, Request.QueryString["connectionstring"].ToString().Replace(" ", "+"));
    //        if (ds.Tables[0].Rows.Count > 0)
    //        {
    //            rg_missing_attribute_reports.DataSource = ds;
    //            rg_missing_attribute_reports.DataBind();
    //        }
    //        else
    //        {                
    //            rg_missing_attribute_reports.DataSource = ds;
    //            rg_missing_attribute_reports.DataBind();
    //        }

    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}
}