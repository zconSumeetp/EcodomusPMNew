using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using EnergyPlus;
using EcoDomus.Session;
using Asset;
using System.Collections;
using System.Text;

public partial class App_NewUI_EnergyModelingEconomics : System.Web.UI.Page
{
    int obj_cnt = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!Page.IsPostBack)
            {
                if (SessionController.Users_.UserId != null)
                {
                    BindEconomicsTypeDropDown();
                    BindEnergyModelingEconomicsGrid();
                    rg_economics.MasterTableView.GroupsDefaultExpanded = false;
                    if (this.rg_economics.MasterTableView.GroupByExpressions.Count > 0)
                    {
                        //refresh on RreRender if grid not rebound
                        this.rg_economics.MasterTableView.SetLevelRequiresBinding();
                    }
                }
            }
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);

    }

    private void BindEconomicsTypeDropDown()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            obj_energy_plus_model.Modeling_class_name ="Economics";
            ds = obj_energy_plus_client.Get_Modeling_Objects_By_Class(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    cmb_ecomonics_type.DataSource = ds;
                    cmb_ecomonics_type.DataTextField = "object_name";
                    cmb_ecomonics_type.DataValueField = "object_name";
                    cmb_ecomonics_type.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void BindEnergyModelingEconomicsGrid()
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
                if (cmb_ecomonics_type.Items.Count > 0)
                {
                    obj_energy_plus_model.Object_name = cmb_ecomonics_type.SelectedItem.Value;
                    //obj_energy_plus_model.Object_name = "Schedule:Compact";
                }
                ds = obj_energy_plus_client.Get_Energy_Modeling_Object_And_Object_Attributes(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables.Count > 0)
                {
                    rg_economics.DataSource = ds;
                    rg_economics.DataBind();
                }
                else
                {
                    rg_economics.DataSource = string.Empty;
                    rg_economics.DataBind();
                }
            }
            else
            {
                rg_economics.DataSource = string.Empty;
                rg_economics.DataBind();
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_economics_ItemCommand(object sender, GridCommandEventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_model_model = new EnergyPlusModel();
        try
        {
            if (e.CommandName == "Edit")
            {

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
            }
            if (e.CommandName == "Cancel")
            {

            }
            rg_economics.MasterTableView.GroupsDefaultExpanded = true;
            if (this.rg_economics.MasterTableView.GroupByExpressions.Count > 0)
            {
                //refresh on RreRender if grid not rebound
                this.rg_economics.MasterTableView.SetLevelRequiresBinding();
            }
            if (e.CommandName == "delete_object")
            {
                if (e.Item is GridGroupHeaderItem)
                {
                    HiddenField hf_object_id = (HiddenField)e.Item.FindControl("hf_object_id");
                    if (hf_object_id != null)
                    {
                        if (hf_object_id.Value.Length > 36)
                        {
                            string id = hf_object_id.Value.Remove(36);
                        }

                    }
                }
            }
            BindEnergyModelingEconomicsGrid();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_economics_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            //GetSelectedRows();
            BindEnergyModelingEconomicsGrid();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_economics_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            //GetSelectedRows();
            BindEnergyModelingEconomicsGrid();
            rg_economics.MasterTableView.GroupsDefaultExpanded = false;
            if (this.rg_economics.MasterTableView.GroupByExpressions.Count > 0)
            {
                //refresh on RreRender if grid not rebound
                this.rg_economics.MasterTableView.SetLevelRequiresBinding();
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_economics_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        try
        {
            //GetSelectedRows();
            BindEnergyModelingEconomicsGrid();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_economics_ItemDataBound(object sender, GridItemEventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        if (e.Item is GridGroupHeaderItem)
        {
            GridGroupHeaderItem groupHeader = (GridGroupHeaderItem)e.Item;
            Label lbl = (Label)e.Item.FindControl("lbl_object");
            if (lbl != null)
            {
                if (lbl.Text.Length > 36)
                {

                    lbl.Text = lbl.Text.Substring(36, lbl.Text.Length - 36);
                }
            }
        }

        if (e.Item is GridGroupHeaderItem)
        {
            //GridGroupHeaderItem groupHeader = (GridGroupHeaderItem)e.Item;
            ////groupHeader.DataCell.Text = groupHeader.DataCell.Text.Split(':')[1];
            //string header = groupHeader.DataCell.Text.Replace("; Name:", " (").Replace("Object:", "");
            //header = header + " )" +"<input id=\"chk_delete\" type=\"checkbox\" name=\"chk_delete\"/>";
            //groupHeader.DataCell.Text = header.Trim();
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
    protected void cmb_schedule_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            BindEnergyModelingEconomicsGrid();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_economics_ItemCreated(object sender, GridItemEventArgs e)
    {

    }
    protected void btn_delete_Click(object sender, EventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        string id = "";
        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            }
            if (SessionController.Users_.Profileid != null)
            {
                obj_energy_plus_model.Project_id = new Guid(SessionController.Users_.Profileid);
            }

            foreach (GridGroupHeaderItem item in rg_economics.MasterTableView.GetItems(GridItemType.GroupHeader))
            {
                CheckBox chk_delete = (CheckBox)item.FindControl("chk_delete");
                if (chk_delete != null)
                {
                    if (chk_delete.Checked)
                    {
                        Label lbl_object = (Label)item.FindControl("lbl_object");
                        HiddenField hf_object_id = (HiddenField)item.FindControl("hf_object_id");
                        if (hf_object_id != null)
                        {
                            if (hf_object_id.Value.Length > 36)
                            {
                                id = id + hf_object_id.Value.Remove(36) + ",";
                            }

                        }
                    }
                }
            }
            if (id.Length > 0)
            {
                id = id.TrimEnd(',');
                obj_energy_plus_model.Pk_simulation_object_ids = id;
                obj_energy_plus_client.Delete_Energy_Modeling_Object_And_Object_Value(obj_energy_plus_model, SessionController.ConnectionString);
                BindEnergyModelingEconomicsGrid();
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
}