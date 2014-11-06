using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SetupSync;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;

public partial class App_Settings_SetupSyncPage : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flagCheck = false;
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!Page.IsPostBack)
        {
            string searchValue = "";
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "configuration_name";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            //Add sort expression, which will sort against first column
            rgconfiguration.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
            rgconfiguration.PagerStyle.PageSizeLabelText = (string)GetGlobalResourceObject("Resource", "Page_Size");

            rgconfiguration.PagerStyle.FirstPageToolTip = (string)GetGlobalResourceObject("Resource", "First_Page");
            rgconfiguration.PagerStyle.LastPageToolTip = (string)GetGlobalResourceObject("Resource", "Last_Page");
            rgconfiguration.PagerStyle.PrevPageToolTip = (string)GetGlobalResourceObject("Resource", "Previous_Page");
            rgconfiguration.PagerStyle.NextPageToolTip = (string)GetGlobalResourceObject("Resource", "Next_Page");

            rgconfiguration.SortingSettings.SortedAscToolTip = (string)GetGlobalResourceObject("Resource", "Sorted_asc");
            rgconfiguration.SortingSettings.SortedDescToolTip = (string)GetGlobalResourceObject("Resource", "Sortedd_desc");
            rgconfiguration.SortingSettings.SortToolTip = (string)GetGlobalResourceObject("Resource", "Sort_Tool_Tip");

            string str = rgconfiguration.PagerStyle.PagerTextFormat;
            rgconfiguration.PagerStyle.Mode = GridPagerMode.NextPrevAndNumeric;
            string strItms = str.Replace("items", (string)GetGlobalResourceObject("Resource", "items"));
            string strPage = strItms.Replace("Page", (string)GetGlobalResourceObject("Resource", "page"));
            string strOf = strPage.Replace("of", (string)GetGlobalResourceObject("Resource", "of"));
            string strto = strOf.Replace("to", (string)GetGlobalResourceObject("Resource", "to"));
            rgconfiguration.PagerStyle.PagerTextFormat = strOf;
            tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
            hfTypePMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize));
            tempPageSize = hfTypePMPageSize.Value;
            Bind_Configuration_Grid();
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

            redirect_page("~\\app\\Login.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

    private void Bind_Configuration_Grid()
    {
        try
        {
            SetupSyncClient obj_setSync_client = new SetupSyncClient();
            SetupSyncModel obj_setSync_model = new SetupSyncModel();
            obj_setSync_model.Search_value = txtsearch.Text;
            DataSet ds = obj_setSync_client.Get_external_system_configuration(obj_setSync_model, SessionController.ConnectionString);

            rgconfiguration.AllowCustomPaging = true;
            if (tempPageSize != "")
                rgconfiguration.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgconfiguration.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));

            rgconfiguration.DataSource = ds;
            rgconfiguration.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {

        Response.Redirect("SetupSync.aspx?pk_external_system_configuration_id=00000000-0000-0000-0000-000000000000");
    }


    protected void rgconfiguration_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "delete")
        {
            //Guid pk_external_system_config_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_external_system_configuration_id"].ToString());

            SetupSyncClient obj_setSync_client = new SetupSyncClient();
            SetupSyncModel obj_setSync_model = new SetupSyncModel();
            obj_setSync_model.Pk_external_system_configuration_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_external_system_configuration_id"].ToString());
            obj_setSync_client.Delete_external_system_configuration(obj_setSync_model, SessionController.ConnectionString);

            Bind_Configuration_Grid();
        }

    }
    protected void radbtnsearch_click(object sender, EventArgs e)
    {
        string searchValue = txtsearch.Text.Trim().ToString();
        Bind_Configuration_Grid();

    }
    protected void rgconfiguration_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {

        Bind_Configuration_Grid();
    }
    protected void rgconfiguration_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        Bind_Configuration_Grid();
    }
    protected void rgconfiguration_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        Bind_Configuration_Grid();
    }
    protected void rgconfiguration_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            //if (e.Item is GridPagerItem)
            //{
            //    GridPagerItem item = e.Item as GridPagerItem;
            //    Label pageOfLabel = e.Item.FindControl("PageOfLabel") as Label;
            //    pageOfLabel.Text = "OF " + item.Paging.PageCount.ToString();
            //}
        }
        catch (Exception)
        {

            throw;
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
        catch (Exception es)
        {
            throw es;
        }

    }

    private void SetPermissions()
    {
        try
        {
            DataSet ds_attr = SessionController.Users_.Permission_ds;
            DataRow dr_attr = ds_attr.Tables[0].Select("name='Settings'")[0];
            DataRow[] dr_submenu_attr = ds_attr.Tables[0].Select("fk_parent_control_id='" + dr_attr["pk_facility_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_attr)
            {
                if (dr_profile["name"].ToString() == "Setup Sync")
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
        try
        {
            Permissions objPermission = new Permissions();
            string delete_permission = dr["delete_permission"].ToString();
            string edit_permission = dr["edit_permission"].ToString();
            if (delete_permission == "N")
            {
                foreach (GridDataItem item in rgconfiguration.MasterTableView.Items)
                {
                    ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnremove");
                    imgbtnDelete.Enabled = false;
                }



            }
            else
            {
                foreach (GridDataItem item in rgconfiguration.MasterTableView.Items)
                {
                    ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnremove");
                    imgbtnDelete.Enabled = true;
                }

            }


            if (edit_permission == "N")
            {
                btnNext.Enabled = false;
            }
            else
            {
                btnNext.Enabled = true;
            }

        }
        catch (Exception es)
        {
            throw es;
        }
    }
}