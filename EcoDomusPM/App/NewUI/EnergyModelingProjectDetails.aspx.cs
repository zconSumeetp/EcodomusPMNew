using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using EnergyPlus;
using System.Data;
using Telerik.Web.UI;
using System.Text;
using System.Collections;


public partial class App_NewUI_EnergyModelingProjectAttributes : System.Web.UI.Page
{
    public ArrayList arrayList = new ArrayList();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    if (Convert.ToString(Request.QueryString["pk_energymodel_simulation_profile"]) != null)
                    {
                        SessionController.Users_.Profileid = Convert.ToString(Request.QueryString["pk_energymodel_simulation_profile"]);
                        lbl_project_name.Text = Convert.ToString(Request.QueryString["project_name"]);
                        SessionController.Users_.ProfileName = lbl_project_name.Text;
                    }
                    if (SessionController.Users_.ProfileName != null)
                    {
                        lbl_project_name.Text = SessionController.Users_.ProfileName;
                    }
                    rgAttributes.DataSource = string.Empty;
                    rgAttributes.DataBind();
                    BindModelingClass();
                    BindModelingObject();
                    ViewState["SelectedObjectId"] = null;
                }
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);

        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    protected void cmb_modeling_class_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {

            BindModelingObject();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void cmb_modeling_object_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            BindEnergyModelingProjectAttributes();
            rgAttributes.MasterTableView.GroupsDefaultExpanded = false;
            if (this.rgAttributes.MasterTableView.GroupByExpressions.Count > 0)
            {
                //refresh on RreRender if grid not rebound
                this.rgAttributes.MasterTableView.SetLevelRequiresBinding();
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void BindEnergyModelingProjectAttributes()
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
                if (cmb_modeling_object.Items.Count > 0)
                {
                    obj_energy_plus_model.Fk_object_id = new Guid(cmb_modeling_object.SelectedItem.Value);
                }
                ds = obj_energy_plus_client.Get_Energy_Modeling_Project_Attributes(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    rgAttributes.DataSource = ds;
                    rgAttributes.DataBind();
                }
                else
                {
                    rgAttributes.DataSource = string.Empty;
                    rgAttributes.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void BindModelingClass()
    {
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        DataSet ds = new DataSet();
        try
        {
            ds = obj_energy_plus_client.Get_Modeling_Class(obj_energy_plus_model, SessionController.ConnectionString);
            cmb_modeling_class.DataSource = ds;
            cmb_modeling_class.DataTextField = "object_group_name";
            cmb_modeling_class.DataValueField = "object_group_name";
            cmb_modeling_class.DataBind();
        }
        catch (Exception es)
        {

            throw es;
        }

    }

    protected void BindModelingObject()
    {
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        DataSet ds = new DataSet();
        try
        {
            if (cmb_modeling_class.Items.Count > 0)
            {
                obj_energy_plus_model.Modeling_class_name = cmb_modeling_class.SelectedValue.ToString();
            }
            else
            {
                obj_energy_plus_model.Modeling_class_name = "";
            }
            ds = obj_energy_plus_client.Get_Modeling_Objects_By_Class(obj_energy_plus_model, SessionController.ConnectionString);
            cmb_modeling_object.DataSource = ds;
            cmb_modeling_object.DataTextField = "object_name";
            cmb_modeling_object.DataValueField = "pk_object_id";
            cmb_modeling_object.DataBind();
        }
        catch (Exception es)
        {

            throw es;
        }

    }

    protected void rgAttributes_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
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
                Label lbl = (Label)e.Item.FindControl("lbl_object");
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

    protected void rgAttributes_ItemCommand(object sender, GridCommandEventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_model_model = new EnergyPlusModel();
        try
        {
            if (e.CommandName == "Edit")
            {
                BindEnergyModelingProjectAttributes();
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
                                //    //obj_energy_model_model.Field_value = editorText.ToString();
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
                BindEnergyModelingProjectAttributes();
            }
            if (e.CommandName == "Cancel")
            {
                BindEnergyModelingProjectAttributes();
            }

            
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btn_add_modeling_obj_Click(object sender, EventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            string IDF_Version = "7.2";
            string value = "";
            StringBuilder sb_Objectlist = new StringBuilder();
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            }
            if (SessionController.Users_.Profileid != null)
            {
                //obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
            }
            if (cmb_modeling_object.Items.Count > 0)
            {
                obj_energy_plus_model.Fk_object_id = new Guid(cmb_modeling_object.SelectedItem.Value);
            }

            ds = obj_energy_plus_client.Get_Energy_Modeling_Object_Attributes(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataTable dt = (DataTable)ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        int obj_seq = Convert.ToInt32(dt.Rows[0]["obj_seq"].ToString());
                        int i = 0;
                        sb_Objectlist.AppendLine("<Object name=\"" + dt.Rows[0]["object_name"] + "\" parent_id=\"" + Guid.NewGuid().ToString() + "\" object_id=\"" + dt.Rows[0]["pk_object_id"].ToString().Trim() + "\" obj_seq=\"" + (obj_seq + 1) + "\"  version_id=\"" + IDF_Version + " \">");
                        foreach (DataRow dr in dt.Rows)
                        {
                            sb_Objectlist.AppendLine(" <Attribute  name=\"" + dr["field_name"].ToString().Trim() + "\" value=\"" + value + "\" field_id=\"" + dr["pk_field_id"].ToString().Trim() + "\" field_seq=\"" + (i).ToString() + "\"/>");
                            i = i + 1;
                        }
                        sb_Objectlist.AppendLine("</Object>");
                        string xml = sb_Objectlist.ToString();
                        obj_energy_plus_model.Str_xml = sb_Objectlist.ToString();
                        obj_energy_plus_client.Insert_New_Energy_Modeling_Object(obj_energy_plus_model, SessionController.ConnectionString);
                    }
                    BindEnergyModelingProjectAttributes();
                    lbl_msg.Text = "";
                }
            }
            else
            {
                lbl_msg.Text = "Select Modeling Class and Modeling Object";
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rgAttributes_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindEnergyModelingProjectAttributes();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rgAttributes_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindEnergyModelingProjectAttributes();
            
        }
        catch (Exception ex)
        {

            throw ex;
        }
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

                //foreach (GridGroupHeaderItem item in rgAttributes.MasterTableView.GetItems(GridItemType.GroupHeader))
                //{
                //    CheckBox chk_delete = (CheckBox)item.FindControl("chk_delete");
                //    if (chk_delete != null)
                //    {
                //        if (chk_delete.Checked)
                //        {
                //            Label lbl_object = (Label)item.FindControl("lbl_object");
                //            HiddenField hf_object_id = (HiddenField)item.FindControl("hf_object_id");
                //            if (hf_object_id != null)
                //            {
                //                if (hf_object_id.Value.Length > 36)
                //                {
                //                    id = id + hf_object_id.Value.Remove(36) + ",";
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
                    BindEnergyModelingProjectAttributes();
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
            HiddenField hf_object_id=null;
            foreach (GridGroupHeaderItem item in rgAttributes.MasterTableView.GetItems(GridItemType.GroupHeader))
            {
                    CheckBox chk_delete = (CheckBox)item.FindControl("chk_delete");
                    Label lbl_object = (Label)item.FindControl("lbl_object");
                    hf_object_id = (HiddenField)item.FindControl("hf_object_id");
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
            foreach (GridGroupHeaderItem item in rgAttributes.MasterTableView.GetItems(GridItemType.GroupHeader))
            {
                HiddenField hf_object_id = (HiddenField)item.FindControl("hf_object_id");
                if (hf_object_id != null)
                {
                    if (hf_object_id.Value.Length > 36)
                    {
                        if (arrayList.Contains(hf_object_id.Value.Remove(36)))
                        {
                            CheckBox chk_delete = (CheckBox)item.FindControl("chk_delete");
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
    protected void rgAttributes_DataBound(object sender, EventArgs e)
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