using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EnergyPlus;
using System.Data;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.Collections;

public partial class App_NewUI_EnergyModelingProjectDetailsNew : System.Web.UI.Page
{
    ArrayList list = new ArrayList();
    Hashtable Hlist = new Hashtable();
  
    
    protected void Page_Load(object sender, EventArgs e)
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
                BindModelingClass();
                BindModelingObject();
                rg_details.DataSource = string.Empty;
                rg_details.DataBind();
               // BindEnergyPlusDetailsGrid();
            }        
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);
														
    }

    protected void rg_details_PreRender(object sender, System.EventArgs e)
    {
        if (!this.IsPostBack)
        {
      //      this.rg_details.MasterTableView.Items[1].Edit = true;
            this.rg_details.MasterTableView.Rebind();
        }

        

    }

    private void BindEnergyPlusDetailsGrid()
    {
        hdnModelingObjName.Value = cmb_modeling_object.SelectedItem.Text.ToString();
        hdnModelingObjId.Value = cmb_modeling_object.SelectedValue.ToString();
       // hdnEntity.Value = cmb_entity.SelectedValue.ToString();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        DataSet ds = new DataSet();
        try
        {
            obj_energy_plus_model.Modeling_Obj_Id = new Guid(hdnModelingObjId.Value.ToString());
            obj_energy_plus_model.ModelingObjName = hdnModelingObjName.Value.ToString();
            //obj_energy_plus_model.entityname = cmb_entity.SelectedValue.ToString();
            obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            ds = obj_energy_plus_client.Get_Modeling_Object_Fields(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables.Count > 0)
            {
                rg_details.DataSource = ds;
                rg_details.DataBind();
            }
            else
            {
                rg_details.DataSource = string.Empty;
                rg_details.DataBind();
            }
        }
        catch (Exception es)
        {
            throw es;
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
            obj_energy_plus_model.Modeling_class_name = cmb_modeling_class.SelectedValue.ToString();
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

    protected void cmb_modeling_class_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            BindModelingObject();
          //  cmb_entity.SelectedValue = "Select";
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
        
    }

    protected void cmb_modeling_object_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
       BindEnergyPlusDetailsGrid();
    }
 
    protected void OnItemCommand_rg_details(object sender, CommandEventArgs e)
    {
        BindEnergyPlusDetailsGrid();
    }

    protected void rg_details_OnSortCommand(object source, GridSortCommandEventArgs e)
    {
        BindEnergyPlusDetailsGrid();
    }

    protected void rg_details_OnPageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        BindEnergyPlusDetailsGrid();
    }

    protected void rg_details_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindEnergyPlusDetailsGrid();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
    }

    protected void rg_details_OnItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        int i = 0;
        if (e.CommandName == "Edit")
        {
            BindEnergyPlusDetailsGrid();         
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);     
        }

        if (e.CommandName == "Update")
        {
            EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
            EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
            GridEditableItem editedItem = e.Item as GridEditableItem;
            GridEditManager editMan = editedItem.EditManager;
           
             SessionToArrayList();
            foreach (GridColumn column in e.Item.OwnerTableView.RenderColumns)
            {
                 string editorText = string.Empty;
                Guid id=Guid.Empty;
                if (column is IGridEditableColumn)
                {
                    IGridEditableColumn editableCol = (column as IGridEditableColumn);
                    if (editableCol.IsEditable && editableCol.ColumnEditor != null)
                    {
                        IGridColumnEditor editor = editMan.GetColumnEditor(editableCol);
                        if (editor is GridTextColumnEditor)
                        {
                           // editorText = (editor as GridTextColumnEditor).Text.ToString();
                           // id = new Guid(list[i].ToString());
                            obj_energy_plus_model.pk_asset_attribute_valueid = new Guid(list[i].ToString());
                            obj_energy_plus_model.mdlObjValue = (editor as GridTextColumnEditor).Text.ToString();
                        //    obj_energy_plus_model.entityname = cmb_entity.SelectedItem.Text;
                            obj_energy_plus_client.Update_Modeling_Obj_Filed(obj_energy_plus_model, SessionController.ConnectionString.ToString());               
                            i++;
                           //if(!Hlist.ContainsKey(list[i]))
                           //{
                           //    Hlist.Add(list[i], editorText);
                           //    i++;
                           //}
                        }
                     }
                }
            }
            //obj_energy_plus_model.pk_required_group_attributeid = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_required_group_attribute_id"].ToString());      
            //obj_energy_plus_client.Update_Modeling_Obj_Filed(obj_energy_plus_model, SessionController.ConnectionString.ToString());          
            e.Item.Edit = false;    
        }
        BindEnergyPlusDetailsGrid();
    }

    protected void rg_details_OnItemDataBound(object source, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem editedItem = e.Item as GridEditableItem;
            GridEditManager editMan = editedItem.EditManager;
            string nondisplay_value = "";
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
                            int index = (editor as GridTextColumnEditor).Text.LastIndexOf("##");
                            if (index > 0)
                            {
                                editorText = (editor as GridTextColumnEditor).Text;
                                nondisplay_value = editorText.Remove(36);
                                list.Add(nondisplay_value);
                                (editor as GridTextColumnEditor).Text = editorText.Remove(0, index + 2);
                            }
                            else
                            {
                                list.Add(Guid.Empty.ToString());
                            }
                        }
                    }
                }
            }
            ViewState["attribute_id"] = list;
        }
        if (e.Item is GridDataItem)
        {
            string display_value="";
            //string nondisplay_value = "";
            GridDataItem item = e.Item as GridDataItem;
            foreach (GridColumn col in rg_details.MasterTableView.AutoGeneratedColumns)
            {
                string col_value=item[col.UniqueName].Text;
                int index=col_value.LastIndexOf("##");

                if (index > 0)
                {
                   // nondisplay_value = col_value.Remove(36);
                   // list.Add(nondisplay_value);
                    display_value = col_value.Remove(0, index + 2);
                    //display_value = col_value.Substring(index, col_value.Length);
                    item[col.UniqueName].Text = display_value;
                }
                //else

                //{
                //    list.Add(Guid.Empty.ToString());
                //}
            }
        }
        //ViewState["attribute_id"] = list;

    }

    protected void SessionToArrayList()
    {
        try
        {
            if (ViewState["attribute_id"] != null)
            {
                list = (ArrayList)ViewState["attribute_id"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_details_OnItemCreated(object source, GridItemEventArgs e)
    {
    }

    protected void rg_details_OnColumnCreated(object sender, GridColumnCreatedEventArgs e)
    { 
    }

    protected void cmb_entity_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            BindEnergyPlusDetailsGrid();
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
        
    }
    protected void btn_add_modeling_obj_Click(object sender, EventArgs e)
    {
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        DataSet ds = new DataSet();
        try
        {
            obj_energy_plus_model.Object_group_name = cmb_modeling_class.SelectedValue.ToString();
            obj_energy_plus_model.Modeling_Obj_Id = new Guid(cmb_modeling_object.SelectedValue);
            obj_energy_plus_model.User_id = new Guid(SessionController.Users_.UserId);
            obj_energy_plus_model.Fk_em_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            obj_energy_plus_client.Insert_energy_modeling_object(obj_energy_plus_model, SessionController.ConnectionString);
            
        }
        catch (Exception es)
        {
            throw es;
        }
    }
}