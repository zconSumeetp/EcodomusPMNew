using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Locations;
using EcoDomus.Session;
using System.Data;
using System.Threading;
using System.Globalization;
using Facility;
using EnergyPlus;
using System.Collections;

public partial class App_UserControls_UserControlNewUI_EnergyModelingZones : System.Web.UI.UserControl
{
    Int32 TotalItemCount;
    public ArrayList arrayList = new ArrayList();
    public Hashtable ht_zonelist_zone = new Hashtable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (hf_is_first_time.Value.Equals("Y"))
            {
                lbl_project_name.Text = SessionController.Users_.ProfileName;
                hfExpand.Value = "no";
                BindZoneListDropDown();
                if (rarcmbZones.Items.Count > 0)
                {
                    hf_zone_id.Value = rarcmbZones.SelectedItem.Value;
                }
                
                ViewState["SelectedObjectId"] = null;
                //GetEnergyModelAddedZones();
                BindEnergyModelingZones();
                rg_em_zones.MasterTableView.GroupsDefaultExpanded = false;
                if (this.rg_em_zones.MasterTableView.GroupByExpressions.Count > 0)
                {
                    //refresh on RreRender if grid not rebound
                    this.rg_em_zones.MasterTableView.SetLevelRequiresBinding();
                }
                hf_is_first_time.Value = "N";
            }

        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);
    }

    protected void rg_em_zones_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindEnergyModelingZones();
            rg_em_zones.MasterTableView.GroupsDefaultExpanded = false;
            if (this.rg_em_zones.MasterTableView.GroupByExpressions.Count > 0)
            {
                //refresh on RreRender if grid not rebound
                this.rg_em_zones.MasterTableView.SetLevelRequiresBinding();
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_em_zones_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindEnergyModelingZones();
            rg_em_zones.MasterTableView.GroupsDefaultExpanded = false;
            if (this.rg_em_zones.MasterTableView.GroupByExpressions.Count > 0)
            {
                //refresh on RreRender if grid not rebound
                this.rg_em_zones.MasterTableView.SetLevelRequiresBinding();
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void ibtnSearch_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (rarcmbZones.Items.Count > 0)
            {
                hf_zone_id.Value = rarcmbZones.SelectedItem.Value;
                BindEnergyModelingZones();
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void BindEnergyModelingZones()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            if (!string.IsNullOrEmpty(SessionController.Users_.Em_facility_id))
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                if (!string.IsNullOrEmpty(SessionController.Users_.Profileid))
                {
                    obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
                }
                else
                {
                    obj_energy_plus_model.Pk_project_id = Guid.Empty;
                }

                obj_energy_plus_model.Object_name = "Zone";
                ds = obj_energy_plus_client.Get_Energy_Modeling_Object_And_Object_Attributes(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        rg_em_zones.DataSource = ds;
                        rg_em_zones.DataBind();
                    }

                }
                else
                {
                    rg_em_zones.DataSource = string.Empty;
                    rg_em_zones.DataBind();
                
                }

            }
            else
            {

                rg_em_zones.DataSource = string.Empty;
                rg_em_zones.DataBind();
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void BindZoneListDropDown()
    {
        EnergyPlusClient ctrl_ep = new EnergyPlusClient();
        EnergyPlusModel mdl_ep = new EnergyPlusModel();
        DataSet ds = new DataSet();
        if (!(string.IsNullOrEmpty(SessionController.Users_.Em_facility_id)) && !(string.IsNullOrEmpty(SessionController.Users_.Profileid)))
        {
            mdl_ep.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            mdl_ep.pk_profileid = new Guid(SessionController.Users_.Profileid);
            ds = ctrl_ep.proc_get_energy_modeling_zones_for_dropdown(mdl_ep, SessionController.ConnectionString);
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    rarcmbZones.DataSource = ds;
                    rarcmbZones.DataTextField = "name";
                    rarcmbZones.DataValueField = "pk_location_id";
                    rarcmbZones.DataBind();
                }
            }
        }
    }

    protected void rg_zones_DataBound(object sender, EventArgs e)
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

    protected void rg_em_zones_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            }
            if (SessionController.Users_.Profileid != null)
            {
                obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
            }
            if (e.Item is GridGroupHeaderItem)
            {
                GridGroupHeaderItem groupHeader = (GridGroupHeaderItem)e.Item;
                Label lbl = (Label)e.Item.FindControl("lbl_object_zone");
                if (lbl != null)
                {
                    if (lbl.Text.Length > 36)
                    {

                        lbl.Text = lbl.Text.Substring(36, lbl.Text.Length - 36);
                    }
                }
            }

            if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                DataSet ds = new DataSet();
                RadComboBox cmb_attribute_value = (RadComboBox)e.Item.FindControl("cmb_attribute_value");
                if (cmb_attribute_value != null)
                {
                    string field_id = Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["fk_field_id"]);
                    string object_id = Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["attribute_id"]);
                    if (!field_id.Equals(""))
                    {
                        obj_energy_plus_model.Pk_field_id = new Guid(field_id);
                    }
                    if (!object_id.Equals(""))
                    {
                        obj_energy_plus_model.Pk_attribute_id = new Guid(object_id);
                    }
                    ds = obj_energy_plus_client.Get_Energy_Modeling_Object_Fields_Key_Values(obj_energy_plus_model, SessionController.ConnectionString);
                    if (ds.Tables.Count > 0)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            cmb_attribute_value.DataTextField = "field_value";
                            cmb_attribute_value.DataValueField = "field_value";
                            cmb_attribute_value.DataSource = ds;
                            cmb_attribute_value.DataBind();
                        }
                    }
                    if (ds.Tables.Count > 1)
                    {
                        if (ds.Tables[1].Rows.Count > 0)
                        {
                            cmb_attribute_value.Text = ds.Tables[1].Rows[0]["value"].ToString();
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_em_zones_ItemCommand(object sender, GridCommandEventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_model_model = new EnergyPlusModel();
        try
        {
            if (e.CommandName == "Edit")
            {
                BindEnergyModelingZones();
            }
            if (e.CommandName == "Update")
            {
                GridEditableItem editedItem = e.Item as GridEditableItem;
                GridEditManager editMan = editedItem.EditManager;
                foreach (GridColumn column in e.Item.OwnerTableView.RenderColumns)
                {
                    if (column is IGridEditableColumn)
                    {
                        IGridEditableColumn editableCol = (column as IGridEditableColumn);
                        if (editableCol.IsEditable && editableCol.ColumnEditor != null)
                        {
                            IGridColumnEditor editor = editMan.GetColumnEditor(editableCol);
                            string editorText;
                            if (editor is GridTextColumnEditor)
                            {
                                if (editableCol.Column.UniqueName == "Attribute_name")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;

                                    // mdl.Attribute_name = editorText.ToString();
                                }

                                //if (editableCol.Column.UniqueName == "Attribute_value")
                                //{
                                //    editorText = (editor as GridTextColumnEditor).Text;
                                //    obj_energy_model_model.Field_value = editorText.ToString();
                                //}

                            }
                            else if (editor is GridTemplateColumnEditor)
                            {
                                if ((editor.ContainerControl.FindControl("cmb_attribute_value") as RadComboBox).Text != null)
                                {
                                    RadComboBox cmb_attribute_value = (RadComboBox)editor.ContainerControl.FindControl("cmb_attribute_value");
                                    if (cmb_attribute_value != null)
                                    {
                                        obj_energy_model_model.Field_value = cmb_attribute_value.Text;

                                    }
                                }

                            }
                        }
                    }
                }
                string id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["attribute_id"].ToString();
                obj_energy_model_model.Pk_attribute_id = new Guid(id);
                obj_energy_plus_client.Insert_Update_Energy_Modeling_Project_Attribute_Value(obj_energy_model_model, SessionController.ConnectionString);
                BindEnergyModelingZones();
            }
            if (e.CommandName == "Cancel")
            {
                BindEnergyModelingZones();
            }
            rg_em_zones.MasterTableView.GroupsDefaultExpanded = true;
            if (this.rg_em_zones.MasterTableView.GroupByExpressions.Count > 0)
            {
                //refresh on RreRender if grid not rebound
                this.rg_em_zones.MasterTableView.SetLevelRequiresBinding();
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_em_zones_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        try
        {
            //GetSelectedRows();
            BindEnergyModelingZones();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_delete_zone_Click(object sender, EventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        string id = "";
        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);

                if (SessionController.Users_.Profileid != null)
                {
                    obj_energy_plus_model.Project_id = new Guid(SessionController.Users_.Profileid);
                }

                GetSelectedRows();
                if (ViewState["SelectedObjectId"] != null)
                {
                    ArrayList object_list = (ArrayList)ViewState["SelectedObjectId"];
                    if (object_list.Count > 0)
                    {
                        for (int i = 0; i < object_list.Count; i++)
                        {
                            id = id + object_list[i].ToString() + ",";

                        }

                    }
                }

                //foreach (GridGroupHeaderItem item in rg_em_zones.MasterTableView.GetItems(GridItemType.GroupHeader))
                //{
                //    CheckBox chk_delete_zone = (CheckBox)item.FindControl("chk_delete_zone");
                //    if (chk_delete_zone != null)
                //    {
                //        if (chk_delete_zone.Checked)
                //        {
                //            Label lbl_object = (Label)item.FindControl("lbl_object_zone");
                //            HiddenField hf_object_zone_id = (HiddenField)item.FindControl("hf_object_zone_id");
                //            if (hf_object_zone_id != null)
                //            {
                //                if (hf_object_zone_id.Value.Length > 36)
                //                {
                //                    id = id + hf_object_zone_id.Value.Remove(36) + ",";
                //                }

                //            }
                //        }
                //    }
                //}
                if (id.Length > 0)
                {
                    id = id.TrimEnd(',');
                    obj_energy_plus_model.Pk_simulation_object_ids = id;
                    obj_energy_plus_client.Delete_Energy_Modeling_Object_And_Object_Value(obj_energy_plus_model, SessionController.ConnectionString);
                    BindEnergyModelingZones();
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    #region To remember previous select items
    protected void GetSelectedRows()
    {
        try
        {
            SessionToArrayList();
            HiddenField hf_object_id = null;
            foreach (GridGroupHeaderItem item in rg_em_zones.MasterTableView.GetItems(GridItemType.GroupHeader))
            {
                CheckBox chk_delete = (CheckBox)item.FindControl("chk_delete_zone");
                Label lbl_object = (Label)item.FindControl("lbl_object_zone");
                hf_object_id = (HiddenField)item.FindControl("hf_object_zone_id");
                if (chk_delete != null)
                {
                    if (chk_delete.Checked)
                    {
                        if (hf_object_id != null)
                        {
                            if (hf_object_id.Value.Length > 36)
                            {
                                if (!arrayList.Contains((hf_object_id.Value.Remove(36))))
                                {
                                    arrayList.Add(hf_object_id.Value.Remove(36));
                                }
                            }

                        }
                    }

                    else
                    {
                        if (hf_object_id != null)
                        {
                            if (hf_object_id.Value.Length > 36)
                            {
                                if (arrayList.Contains((hf_object_id.Value.Remove(36))))
                                {
                                    arrayList.Remove(hf_object_id.Value.Remove(36));
                                }
                            }
                        }

                    }
                }
            }

            ViewState["SelectedObjectId"] = arrayList;
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
            foreach (GridGroupHeaderItem item in rg_em_zones.MasterTableView.GetItems(GridItemType.GroupHeader))
            {
                HiddenField hf_object_id = (HiddenField)item.FindControl("hf_object_zone_id");
                if (hf_object_id != null)
                {
                    if (hf_object_id.Value.Length > 36)
                    {
                        if (arrayList.Contains(hf_object_id.Value.Remove(36)))
                        {
                            CheckBox chk_delete = (CheckBox)item.FindControl("chk_delete_zone");
                            if (chk_delete != null)
                            {
                                chk_delete.Checked = true;
                            }
                        }
                    }
                }
            }
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
            if (ViewState["SelectedObjectId"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedObjectId"];
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    #endregion
    protected void rg_em_zones_DataBound(object sender, EventArgs e)
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
}