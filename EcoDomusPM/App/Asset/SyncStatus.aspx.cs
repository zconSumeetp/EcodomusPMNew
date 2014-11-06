using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Globalization;
using System.Threading;
using EcoDomus.Session;
using SyncAsset;

public partial class App_Asset_SynchronizeFacility : System.Web.UI.Page
{
    Guid history_id;
    Guid configuration_id;
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
        if (SessionController.Users_.UserId != null)
        {
            if (!Page.IsPostBack)
            {
                history_id = new Guid(Request.QueryString["pk_external_system_sync_history_id"]);
                configuration_id = new Guid(Request.QueryString["fk_external_system_configuration_id"]);
                if (Request.QueryString["external_system_name"] != null ) 
                {
                   lblextsys.Text = Request.QueryString["external_system_name"].ToString();
                }
               
                SyncRep();
                BindSynchDetailGrid();
            }
        }
        else
        { 
        
        }
    }

    protected void SyncRep()

    {
        DataSet ds = new DataSet();
        SyncAsset.AssetSyncClient obj = new SyncAsset.AssetSyncClient();
        SyncAsset.AssetSyncModel obj_model = new SyncAsset.AssetSyncModel();
        obj_model.History_id = new Guid(Request.QueryString["pk_external_system_sync_history_id"].ToString());
        ds = obj.SyncReport(obj_model, SessionController.ConnectionString);
        lblImportedFailed.Text = ds.Tables[0].Rows[0]["import_failed"].ToString();
        lblExportedFailed.Text = ds.Tables[0].Rows[0]["export_failed"].ToString();
        lblImportedCompleted.Text = ds.Tables[0].Rows[0]["imp_completed"].ToString();
        lblExportedCompleted.Text = ds.Tables[0].Rows[0]["exp_completed"].ToString();
        lblTotalExportedData.Text = ds.Tables[0].Rows[0]["exp_total"].ToString();
        lblTotalImportedlData.Text = ds.Tables[0].Rows[0]["imp_total"].ToString();

    }

    protected void BindSynchDetailGrid()
    {
        DataSet ds = new DataSet();
        SyncAsset.AssetSyncClient obj = new SyncAsset.AssetSyncClient();
        SyncAsset.AssetSyncModel obj_model = new SyncAsset.AssetSyncModel();
        obj_model.History_id = new Guid(Request.QueryString["pk_external_system_sync_history_id"].ToString());
       // obj_model.History_id=new Guid("92149344-B11E-45EC-9C62-DF30E4715E46");
        obj_model.Pk_configuration_Id = new Guid(Request.QueryString["fk_external_system_configuration_id"].ToString());
        ds = obj.GetSyncDetails(obj_model, SessionController.ConnectionString);
        rg_asset.DataSource = ds.Tables[0];
        rg_asset.DataBind();
        rg_floor.DataSource = ds.Tables[1];
        rg_floor.DataBind();
        rg_spaces.DataSource = ds.Tables[2];
        rg_spaces.DataBind();
        //rg_work_order.DataSource = ds.Tables[3];
        //rg_work_order.DataBind();
        
    }

    //protected void BindGrid()
    //{

    //    DataTable dt = new DataTable();
    //    DataColumn col1 = new DataColumn("item_name", typeof(string));
    //    dt.Columns.Add(col1);
    //    DataRow dr = dt.NewRow();
    //    dr["item_name"] = "ABC";
    //    dt.Rows.Add(dr);

    //    DataRow dr1 = dt.NewRow();
    //    dr1["item_name"] = "XYZ";
    //    dt.Rows.Add(dr1);

    //    RadGrid1.DataSource = dt;
    //}


}