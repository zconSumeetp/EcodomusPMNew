using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;
using System.Data;
using SyncAsset;
using EcoDomus.Session;
using Telerik.Web.UI;
using EcoDomus.ES;
using EcoDomus.TA;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using System.Threading;

public partial class App_Asset_SyncAsset : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flagCheck = false;
    DataSet ds1 = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        // lblRefreshMsg.Text = "*Note: Page will refresh after every 30 sec automatically";

        txtSearch.Attributes.Add("onKeyPress", "doClick('" + btnSearch.ClientID + "',event)");
        lblSyncCompleteStatus.Text = "";
        //lblRefreshMsg.Text = "";
        if (!Page.IsPostBack)
        {
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "configuration_name";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            //Add sort expression, which will sort against first column
            SyncFacility.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
            tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
            hfTypePMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize));
            tempPageSize = hfTypePMPageSize.Value;
            BindGrid();
            // GetEntityCode();

        }

    }


    protected void GetSyncSearch()
    {
        DataSet ds = new DataSet();
        AssetSyncClient obj_AssetSyncClient = new AssetSyncClient();
        AssetSyncModel obj_AssetSyncModel = new AssetSyncModel(); 
        obj_AssetSyncModel.Txt_search = txtSearch.Text;
        ds = obj_AssetSyncClient.GetSyncSearch(obj_AssetSyncModel, SessionController.ConnectionString);
        SyncFacility.DataSource = ds;
        SyncFacility.DataBind();
    }

    public void GetEntityCode()
    {
        AssetSyncClient obj_AssetSyncClient = new AssetSyncClient();
        AssetSyncModel obj_AssetSyncModel = new AssetSyncModel();
        obj_AssetSyncModel.Ext_sys_id = new Guid(hid.Value);
        ds1 = obj_AssetSyncClient.GetEntityCode(obj_AssetSyncModel, SessionController.ConnectionString);

        tbl.Controls.Clear();

        for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
        {
            TableRow rowNew = new TableRow();
            tbl.Controls.Add(rowNew);
            TableCell cellNew = new TableCell();
            LinkButton lblNew = new LinkButton();
            lblNew.Text = ds1.Tables[0].Rows[i]["entity_code"].ToString();
            cellNew.Controls.Add(lblNew);
            rowNew.Controls.Add(cellNew);
        }
    }

    protected void BindGrid()
    {
        DataSet ds = new DataSet();
        AssetSyncClient obj_AssetSyncClient = new AssetSyncClient();
        ds = obj_AssetSyncClient.GetSyncGrid(SessionController.ConnectionString);

        SyncFacility.AllowCustomPaging = true;
        if (tempPageSize != "")
            SyncFacility.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
        SyncFacility.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));

        SyncFacility.DataSource = ds;
        SyncFacility.DataBind();

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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {
        Response.Redirect(url, false);
    }

    protected void SyncFacility_ItemDatabound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {

            GridDataItem dataItem = (GridDataItem)e.Item;
            HyperLink lnkbtn = (HyperLink)dataItem["Status"].FindControl("sync_status");
            lnkbtn.Attributes.Add("onclick", "javascript:openpopupSyncStatus('" + dataItem["ExternalSystem"].Text + "','" + dataItem["HistoryID"].Text + "','" + dataItem["ConfigurationID"].Text + "','" + lnkbtn.Text + "')");

        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetSyncSearch();
    }

    protected void btnSynchronize_Click(object sender, EventArgs e)
    {
        try
        {

            //  lblRefreshMsg.Text = "*Note: Page will refresh after every 30 sec automatically";
            //lblRefreshMsg.Text = "";
            CryptoHelper objCryptoHelper = new CryptoHelper();
            if (SyncFacility.SelectedItems.Count > 0)
            {
                for (int i = 0; i < SyncFacility.SelectedItems.Count; i++)
                {
                    Guid ConfigKey = Guid.Parse(SyncFacility.SelectedItems[i].Cells[3].Text);
                    String constr = objCryptoHelper.Decrypt(SessionController.ConnectionString);
                    EcoDomus.ES.ExternalIntigration tmp = new EcoDomus.ES.ExternalIntigration();

                    tmp.Synchronize(ConfigKey, constr);
                    Thread.Sleep(10 * 1000);
                    Page.Response.Redirect(HttpContext.Current.Request.Url.ToString(), true);
                    BindGrid();
                    lblSyncCompleteStatus.Text = "Synchronization is running.";
                    // lblRefreshMsg.Text = "*Note: Page will refresh after every 30 sec automatically";

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void SyncFacility_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            BindGrid();

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void SyncFacility_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {

        try
        {
            BindGrid();

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void rgexportedfiles_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        BindGrid();
    }



    protected void SyncFacility_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        try
        {
            BindGrid();

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
            DataRow dr_component = ds_component.Tables[0].Select("name='Assets'")[0];
            SetPermissionToControl(dr_component);


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SetPermissionToControl(DataRow dr)
    {
        try
        {
            Permissions objPermission = new Permissions();

            string delete_permission = dr["delete_permission"].ToString();
            string edit_permission = dr["edit_permission"].ToString();

            if (edit_permission == "N")
            {
                btnSynchronize.Enabled = false;
            }
            else
            {
                btnSynchronize.Enabled = true;
            }

            if (delete_permission == "N")
            {

                //foreach (GridDataItem item in rgasset.MasterTableView.Items)
                //{
                //    ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnremove");
                //    imgbtnDelete.Enabled = false;
                //}
            }
            else
            {
                //foreach (GridDataItem item in rgasset.MasterTableView.Items)
                //{
                //    ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnremove");
                //    imgbtnDelete.Enabled = true;
                //}
            }

        }
        catch (Exception es)
        {
            throw es;

        }
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    {
                        //SetPermissions();
                    }
                }
            }
        }
        catch (Exception ed)
        {
            throw ed;
        }
    }

    protected void Timer1_click(object sender, EventArgs e)
    {
        //SyncFacility.Rebind();
        BindGrid();
    }
}