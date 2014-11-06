using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EcoDomus.Session;
using Asset;
using Telerik.Web.UI;
using System.Collections;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;

public partial class App_Asset_AssetsImpact : System.Web.UI.Page
{
    public ArrayList arrayList = new ArrayList();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!Page.IsPostBack)
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rgimpact.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                Get_Entity_For_Impact();
                bind_impact_grid();
                bind_AffectsBy_grid();
                ViewState["SelectedFacilityID"] = null;
                Get_AssetProfile(SessionController.Users_.AssetId.ToString());
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void Get_AssetProfile(string AssetId)
    {
        try
        {
            AssetClient obj_assetclient = new AssetClient();
            AssetModel obj_assetmodel = new AssetModel();
            DataSet AssetProfile = new DataSet();
            obj_assetmodel.Asset_id = new Guid(AssetId);
            AssetProfile = obj_assetclient.Get_AssetProfile(obj_assetmodel, SessionController.ConnectionString);
            hffacilityid.Value = AssetProfile.Tables[0].Rows[0]["fk_facility_id"].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void Get_Entity_For_Impact()
    {
        try
        {
            AssetClient obj_asset_client = new AssetClient();
            AssetModel obj_asset_model = new AssetModel();
            DataSet ds = obj_asset_client.Get_Entity_For_Impact(SessionController.ConnectionString);
            ddl_entity.DataTextField = "entity_name";
            ddl_entity.DataValueField = "pk_entity_id";
            ddl_entity.DataSource = ds;
            ddl_entity.DataBind();

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void bind_impact_grid()
    {
        try
        {
            AssetClient obj_asset_client = new AssetClient();
            AssetModel obj_asset_model = new AssetModel();
            DataSet ds_impact = new DataSet();
            obj_asset_model.Asset_id = new Guid(SessionController.Users_.AssetId.ToString());
            obj_asset_model.Name = txt_name.Text.Trim();
            ds_impact = obj_asset_client.Get_impact(obj_asset_model, SessionController.ConnectionString);
            rgimpact.DataSource = ds_impact;
            rgimpact.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void bind_AffectsBy_grid()
    {
        var objAssetClient = new AssetClient();
        var objAssetModel = new AssetModel();
        var dsImpact = new DataSet();
        objAssetModel.Asset_id = new Guid(SessionController.Users_.AssetId.ToString());
        objAssetModel.EntityName = "";
        objAssetModel.Search_Text = RadTextBoxSearchAffectedBy.Text;
        dsImpact = objAssetClient.get_rows_for_affect(objAssetModel, SessionController.ConnectionString);
        AffectedByGrid.DataSource = dsImpact;
        AffectedByGrid.DataBind();
    }

    protected void btn_addImpact_Click(object sender, EventArgs e)
    {
        ViewState["impactid"] = Guid.Empty;
        Get_Entity_For_Impact();
        txt_description.Text = "";
        div_add_impact.Style.Add("display", "inline");
        rgentity.Style.Add("display", "none");
        tr_entity.Style.Add("display", "none");
        rgentity.AllowMultiRowSelection = true;
    }

    protected void btn_saveImpact_Click(object sender, EventArgs e)
    {
        string id = "";
        string name = "";
        try
        {
            GetSelectedRows();
            ArrayList facility_list = (ArrayList)ViewState["SelectedFacilityID"];
            if (facility_list.Count > 0)
            {
                for (int i = 0; i < facility_list.Count; i++)
                {
                    id = id + facility_list[i].ToString() + ",";

                }
                id = id.Substring(0, id.Length - 1);
            }
            if (id.Length < 1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "selectAtleastOne();", true);
            }
            else
            {
                insert_update_impact(id);
                div_add_impact.Style.Add("display", "none");
                bind_impact_grid();
                ViewState["SelectedFacilityID"] = null;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        div_add_impact.Style.Add("display", "none");
    }

    private void insert_update_impact(string id)
    {
        AssetClient obj_asset_client = new AssetClient();
        AssetModel obj_asset_model = new AssetModel();
        obj_asset_model.impactid = new Guid(ViewState["impactid"].ToString());
        obj_asset_model.Asset_id = new Guid(SessionController.Users_.AssetId.ToString());
        obj_asset_model.row_id = id;
        obj_asset_model.entity_id = new Guid(ddl_entity.SelectedValue.ToString());
        obj_asset_model.Description = txt_description.Text;
        int rows_affected = obj_asset_client.Insert_impact(obj_asset_model, SessionController.ConnectionString);
        if (rows_affected == 0)
            ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "duplicate();", true);
    }

    protected void ddl_entity_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridSortExpression sortExpr1 = new GridSortExpression();
        sortExpr1.FieldName = "name";
        sortExpr1.SortOrder = GridSortOrder.Ascending;
        rgentity.MasterTableView.SortExpressions.AddSortExpression(sortExpr1);
        bind_entity_grid();
    }
    protected void rgentity_OnSortCommand(object sender, EventArgs e)
    {
        bind_entity_grid();
    }

    private void bind_entity_grid()
    {
        if (ddl_entity.SelectedValue != Guid.Empty.ToString())
        {
            AssetClient obj_asset_client = new AssetClient();
            AssetModel obj_asset_model = new AssetModel();
            DataSet ds_row = new DataSet();
            string entity_name = ddl_entity.SelectedItem.Text;
            if (entity_name == "Component")
            {

                entity_name = "Asset";
            }

            obj_asset_model.EntityName = entity_name;
            obj_asset_model.Project_id = new Guid(SessionController.Users_.ProjectId);
            obj_asset_model.CriteriaText = txt_search.Text;
            ds_row = obj_asset_client.get_rows_for_impact_pm(obj_asset_model, SessionController.ConnectionString);
            rgentity.DataSource = ds_row;
            rgentity.DataBind();
            rgentity.Style.Add("display", "inline");
            tr_entity.Style.Add("display", "inline");
        }
        else
        {
            rgentity.Style.Add("display", "none");
            tr_entity.Style.Add("display", "none");
        }
    }

    protected void rgentity_pageindexchanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            bind_entity_grid();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }
        catch (Exception ex)
        {
            throw ex;
        }


    }

    protected void rgAffectedByPageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        bind_AffectsBy_grid();
    }

    protected void rgimpact_pageindexchanged(object sender, GridPageChangedEventArgs e)
    {
        bind_impact_grid();
        //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
    }

    protected void rgAffectedByPageSizeChanged(object sender, GridPageSizeChangedEventArgs e) 
    {
        bind_AffectsBy_grid();
    }

    protected void rgimpact_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        bind_impact_grid();
        //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
    }

    protected void rgentity_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        bind_entity_grid();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
    }

    protected void GetSelectedRows()
    {
        try
        {
            SessionToArrayList();

            foreach (GridDataItem item in rgentity.Items)
            {
                string strIndex = rgentity.MasterTableView.CurrentPageIndex.ToString();
                string id = item["id"].Text;

                if (item.Selected)
                {
                    if (!arrayList.Contains(id.ToString()))
                    {
                        arrayList.Add(id.ToString());
                    }
                }
                else
                {
                    if (arrayList.Contains(id.ToString()))
                    {
                        arrayList.Remove(id.ToString());
                    }
                }
            }

            ViewState["SelectedFacilityID"] = arrayList;
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void SessionToArrayList()
    {
        try
        {
            if (ViewState["SelectedFacilityID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedFacilityID"];
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void ReSelectedRows()
    {
        try
        {
            foreach (GridDataItem item in rgentity.Items)
            {
                string id = item["id"].Text;
                if (arrayList.Contains(id.ToString()))
                {
                    item.Selected = true;
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rgentity_DataBound(object sender, EventArgs e)
    {
        try
        {
            ReSelectedRows();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rgimpact_ItemCommand(object sender, GridCommandEventArgs e)
    {
        AssetClient obj_asset_client = new AssetClient();
        AssetModel obj_asset_model = new AssetModel();
        DataSet ds = new DataSet();
        Guid impactid;
        if (e.CommandName == "DeleteImpact")
        {
            impactid = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_impact_id"].ToString());
            obj_asset_model.impactid = impactid;
            obj_asset_client.Delete_impact(obj_asset_model, SessionController.ConnectionString);
            bind_impact_grid();
            div_add_impact.Style.Add("display", "none");
        }

        if (e.CommandName == "EditImpact")
        {
            impactid = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_impact_id"].ToString());
            div_add_impact.Style.Add("display", "inline");
            tr_entity.Style.Add("display", "inline");
            obj_asset_model.impactid = impactid;
            ds = obj_asset_client.get_impact_for_edit(obj_asset_model, SessionController.ConnectionString);

            txt_description.Text = ds.Tables[0].Rows[0]["Description"].ToString();
            ddl_entity.SelectedValue = ds.Tables[0].Rows[0]["fk_entity_id"].ToString();

            string fk_row_id = ds.Tables[0].Rows[0]["fk_row_id"].ToString();

            rgentity.AllowMultiRowSelection = false;
            bind_entity_grid();
            ReselectGridItemOnEdit(fk_row_id);
            ViewState["impactid"] = impactid;
            lbl_add_edit_impact.Text = "Edit Impact";
        }
    }

    protected void btn_search_impact_Click(object sender, EventArgs e)
    {
        bind_impact_grid();
    }

    protected void btnSearchAffectedByClick(object sender, EventArgs e)
    {
        bind_AffectsBy_grid();
    }

    private void ReselectGridItemOnEdit(string rowid)
    {
        foreach (GridDataItem item in rgentity.Items)
        {
            string strIndex = rgentity.MasterTableView.CurrentPageIndex.ToString();
            string id = item["id"].Text;

            if (id == rowid)
            {
                item.Selected = true;
            }
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

    protected void btn_search_Click(object sender, EventArgs e)
    {
        bind_entity_grid();
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            bind_impact_grid();
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                btn_addImpact.Visible = false;
                foreach (GridDataItem item in rgimpact.MasterTableView.Items)
                {
                    Button btn = item.FindControl("btn_edit") as Button;
                    btn.Enabled = false;
                    ImageButton btn_img = item.FindControl("imgbtnDelete") as ImageButton;
                    btn_img.Enabled = false;
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
            DataRow dr_component = ds_component.Tables[0].Select("name='Component'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Impacts")
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


        if (edit_permission == "N")
        {
            foreach (GridDataItem item in rgimpact.MasterTableView.Items)
            {
                Button btnedit = (Button)item.FindControl("btn_edit");
                btnedit.Enabled = false;
            }
            btn_addImpact.Enabled = false;
        }
        else
        {
            foreach (GridDataItem item in rgimpact.MasterTableView.Items)
            {
                Button btnedit = (Button)item.FindControl("btn_edit");
                btnedit.Enabled = true;
            }
            btn_addImpact.Enabled = true;
        }


        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rgimpact.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }

        }
        else
        {
            foreach (GridDataItem item in rgimpact.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = true;
            }
        }



    }

}