﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using EnergyPlus;
using System.Data;
using Telerik.Web.UI;
using System.Collections;

public partial class App_UserControls_UserControlNewUI_EnergyModelingZoneList : System.Web.UI.UserControl
{
    string facid = "";
    public ArrayList arrayList = new ArrayList();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lbl_project_name.Text = SessionController.Users_.ProfileName;
            BindEnergyModelingZoneList();
            rg_em_zoneslist.MasterTableView.GroupsDefaultExpanded = false;
            if (this.rg_em_zoneslist.MasterTableView.GroupByExpressions.Count > 0)
            {
                //refresh on RreRender if grid not rebound
                this.rg_em_zoneslist.MasterTableView.SetLevelRequiresBinding();
            }
            ViewState["SelectedObjectId"] = null;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);
														
    }

    protected void BindEnergyModelingZoneList()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                if (SessionController.Users_.Profileid != null)
                {
                    obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
                }

                obj_energy_plus_model.Object_name = "ZoneList";

                ds = obj_energy_plus_client.Get_Energy_Modeling_Object_And_Object_Attributes(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    rg_em_zoneslist.DataSource = ds;
                    rg_em_zoneslist.DataBind();
                }
                else
                {
                    rg_em_zoneslist.DataSource = string.Empty;
                    rg_em_zoneslist.DataBind();
                }

            }
            else
            {
                rg_em_zoneslist.DataSource = string.Empty;
                rg_em_zoneslist.DataBind();
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    
    }

    protected void rg_em_zoneslist_ItemCommand(object sender, GridCommandEventArgs e)
    {
         EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_model_model = new EnergyPlusModel();
       
        try
        {
            if (e.CommandName == "Edit")
            {
                BindEnergyModelingZoneList();
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
                BindEnergyModelingZoneList();
            }
            if (e.CommandName == "Cancel")
            {
                BindEnergyModelingZoneList();
            }
            rg_em_zoneslist.MasterTableView.GroupsDefaultExpanded = true;
            if (this.rg_em_zoneslist.MasterTableView.GroupByExpressions.Count > 0)
            {
                //refresh on RreRender if grid not rebound
                this.rg_em_zoneslist.MasterTableView.SetLevelRequiresBinding();
            }
            
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rg_em_zoneslist_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindEnergyModelingZoneList();
            rg_em_zoneslist.MasterTableView.GroupsDefaultExpanded = false;
            if (this.rg_em_zoneslist.MasterTableView.GroupByExpressions.Count > 0)
            {
                //refresh on RreRender if grid not rebound
                this.rg_em_zoneslist.MasterTableView.SetLevelRequiresBinding();
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rg_em_zoneslist_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindEnergyModelingZoneList();
            rg_em_zoneslist.MasterTableView.GroupsDefaultExpanded = false;
            if (this.rg_em_zoneslist.MasterTableView.GroupByExpressions.Count > 0)
            {
                //refresh on RreRender if grid not rebound
                this.rg_em_zoneslist.MasterTableView.SetLevelRequiresBinding();
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rg_em_zoneslist_ItemDataBound(object sender, GridItemEventArgs e)
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
                Label lbl = (Label)e.Item.FindControl("lbl_object_zoneList");
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

    protected void rg_em_zoneslist_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        try
        {
            //GetSelectedRows();
            BindEnergyModelingZoneList();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btn_delete_zoneList_Click(object sender, EventArgs e)
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

                //foreach (GridGroupHeaderItem item in rg_em_zoneslist.MasterTableView.GetItems(GridItemType.GroupHeader))
                //{
                //    CheckBox chk_delete_zoneList = (CheckBox)item.FindControl("chk_delete_zoneList");
                //    if (chk_delete_zoneList != null)
                //    {
                //        if (chk_delete_zoneList.Checked)
                //        {
                //            Label lbl_object_zoneList = (Label)item.FindControl("lbl_object_zoneList");
                //            HiddenField hf_object_zoneList_id = (HiddenField)item.FindControl("hf_object_zoneList_id");
                //            if (hf_object_zoneList_id != null)
                //            {
                //                if (hf_object_zoneList_id.Value.Length > 36)
                //                {
                //                    id = id + hf_object_zoneList_id.Value.Remove(36) + ",";
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
                    BindEnergyModelingZoneList();
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void GetSelectedRows()
    {
        try
        {
            SessionToArrayList();
            HiddenField hf_object_id = null;
            foreach (GridGroupHeaderItem item in rg_em_zoneslist.MasterTableView.GetItems(GridItemType.GroupHeader))
            {
                CheckBox chk_delete = (CheckBox)item.FindControl("chk_delete_zoneList");
                Label lbl_object = (Label)item.FindControl("lbl_object_zoneList");
                hf_object_id = (HiddenField)item.FindControl("hf_object_zoneList_id");
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
            foreach (GridGroupHeaderItem item in rg_em_zoneslist.MasterTableView.GetItems(GridItemType.GroupHeader))
            {
                HiddenField hf_object_id = (HiddenField)item.FindControl("hf_object_zoneList_id");
                if (hf_object_id != null)
                {
                    if (hf_object_id.Value.Length > 36)
                    {
                        if (arrayList.Contains(hf_object_id.Value.Remove(36)))
                        {
                            CheckBox chk_delete = (CheckBox)item.FindControl("chk_delete_zoneList");
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
    protected void rg_em_zoneslist_DataBound(object sender, EventArgs e)
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