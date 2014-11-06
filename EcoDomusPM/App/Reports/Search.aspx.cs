using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Dashboard;
using EcoDomus.Session;
using EcoDomus.EncrptDecrypt;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;

public partial class Reports_Search : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    Guid asset_id;
    Guid space_id;

    string search_asset="";
    string search_space="";
    Guid facility_id;
    string asset_entity = "Asset";
    string space_entity = "Space";

 
    /* Declare the Global connection object */


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

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                /* Create the Client DB Connection object ! */

                if (Request.QueryString["Search_asset"] != null && Request.QueryString["Search_space"] != null && Request.QueryString["facility_id"] != null)
                {
                     search_asset = Request.QueryString["Search_asset"].ToString();
                    search_space = Request.QueryString["Search_space"].ToString();
                    facility_id = new Guid(Request.QueryString["facility_id"].ToString());

                    if (!IsPostBack)
                    {
                        GridSortExpression sortExpr = new GridSortExpression();
                        sortExpr.FieldName = "name";
                        sortExpr.SortOrder = GridSortOrder.Ascending;
                        //Add sort expression, which will sort against first column
                        RgSpaceData.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                        sortExpr.FieldName = "name";
                        sortExpr.SortOrder = GridSortOrder.Ascending;
                        //Add sort expression, which will sort against first column
                        RgAssetData.MasterTableView.SortExpressions.AddSortExpression(sortExpr);



                        BindSearchAssetData(search_asset,facility_id);
                        BindSearchSpaceData(search_space,facility_id);
                    }
                }
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "Page_Load:- " + ex.Message.ToString();
        }
    }



    public void BindSearchAssetData(string asset,Guid facility_id)
    {
        //string search_col_name = Session["Asset_search_col_name"].ToString();
        //string search_text = Session["Asset_Search_text"].ToString();

        DashboardModel dm = new DashboardModel();
        DashboardClient dc = new DashboardClient();
        dm.FacilityId = facility_id;
        dm.Search_text = asset;
        dm.Entity = "Asset";

        ds = dc.GetAssetSpaceOnSearch(dm,SessionController.ConnectionString);
        RgAssetData.DataSource = ds;
        RgAssetData.DataBind();


        //dm.Name_Description = search_col_name;
        //dm.Search_text = search_text;
        //ds = dc.GetAssetData(dm, SessionController.ConnectionString);
        //ViewState["AssetData"] = ds;
        //BindAssetData(ref ds);
    }

    public void BindSearchSpaceData(string space,Guid facility_id)
    {              
        //string search_col_name = Session["Space_search_col_name"].ToString();
        //string search_text = Session["Space_Search_text"].ToString();
        DashboardModel dm = new DashboardModel();
        DashboardClient dc = new DashboardClient();

        dm.FacilityId = facility_id;
        dm.Search_text = space;
        dm.Entity = "Space";
        ds = dc.GetAssetSpaceOnSearch(dm,SessionController.ConnectionString);
        RgSpaceData.DataSource = ds;
        RgSpaceData.DataBind();

        //dm.Name_Description = search_col_name;
        //dm.Search_text = search_text;
        //ds = dc.GetSpaceData(dm, SessionController.ConnectionString);
        //ViewState["SpaceData"] = ds;
        //BindSpaceData(ref ds);
    }

    void BindAssetData(ref DataSet ds)
    {
        RgAssetData.DataSource = ds;
        RgAssetData.DataBind();
    }

    void BindSpaceData(ref DataSet ds)
    {
        RgSpaceData.DataSource = ds;
        RgSpaceData.DataBind();
    }

    void ReBindAsset()
    {
        DataSet ds;
        ds = (DataSet)ViewState["AssetData"];
        BindAssetData(ref ds);
    }

    void ReBindSpace()
    {
        DataSet ds;
        ds = (DataSet)ViewState["SpaceData"];
        BindSpaceData(ref ds);
    }

    protected void RgAssetData_OnPageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {
            
            BindSearchAssetData(search_asset,facility_id);
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "RgAssetData_OnPageIndexChanged:- " + ex.Message.ToString();
        }
    }

    protected void RgAssetData_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            BindSearchAssetData(search_asset, facility_id);
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "RgAssetData_OnPageSizeChanged:- " + ex.Message.ToString();

        }
    }

    protected void RgSpaceData_OnPageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {
            BindSearchSpaceData(search_space,facility_id);
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "RgSpaceData_OnPageIndexChanged:- " + ex.Message.ToString();

        }

    }

    protected void RgSpaceData_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            BindSearchSpaceData(search_space, facility_id);
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "RgSpaceData_OnPageSizeChanged:- " + ex.Message.ToString();
        }
    }

    protected void RgAssetData_OnSortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            BindSearchAssetData(search_asset, facility_id);
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "RgAssetData_OnSortCommand:- " + ex.Message.ToString();
        }
    }

    protected void RgSpaceData_OnSortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            BindSearchSpaceData(search_space, facility_id);
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "RgSpaceData_OnSortCommand:- " + ex.Message.ToString();
        }
    }

    protected void RgAssetData_OnItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "editassets")
        {
            asset_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_asset_id"].ToString());
            Response.Redirect("~/App/Asset/AssetMenu.aspx?assetid=" + asset_id + "&pagevalue=AssetProfile");
        }
        else if (e.CommandName == "Edit_")
        {
            LinkButton lnk_work_order_name = e.Item.FindControl("linkFacility") as LinkButton;
            Guid fk_facility_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["fk_facility_id"].ToString());
            SessionController.Users_.facilityID = fk_facility_id.ToString();
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + fk_facility_id, false);
        }
    }

    protected void RgSpaceData_OnItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "editspaces")
        {
            space_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_location_id"].ToString());
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?id=" + space_id+"&pagevalue=Space Profile");
        }

        else if (e.CommandName=="Edit_")
        {
            LinkButton lnk_work_order_name = e.Item.FindControl("linkFacility") as LinkButton;
            Guid fk_facility_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["fk_facility_id"].ToString());
            SessionController.Users_.facilityID = fk_facility_id.ToString();
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + fk_facility_id, false);
        }

    }
}