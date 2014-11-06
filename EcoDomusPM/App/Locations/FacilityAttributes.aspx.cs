using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts; 
using System.Web.UI.HtmlControls;
using EcoDomus.Session;
using Attributes;
using Facility;
using System.Threading;
using System.Globalization;
using System.Collections;

public partial class FacilityAttributes : System.Web.UI.Page
{
    Guid EntityDataId;
    string EntityName = "";
    string attribute_name = "";
    string flag = "";
    string tempPageSize = "";
    bool flagCheck = false;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        EntityDataId =new Guid( Request.QueryString["entity_id"].ToString());
        EntityName = Request.QueryString["entity_name"].ToString();
        hf_entity_name.Value = EntityName;
        txtSearch.Attributes.Add("onKeyPress", "doClick('" + btnSearch.ClientID + "',event)");
        try
        {
            if (SessionController.Users_.UserId != null)
            {

                if (SessionController.ConnectionString.ToString() != "")
                {
                    if (!IsPostBack)
                    {
                        if (Request.QueryString["attribute_name"] != null)
                        {

                            attribute_name = Request.QueryString["attribute_name"].ToString();
                        }
                        DataSet ds = new DataSet();
                        FacilityModel fm = new FacilityModel();
                        FacilityClient fc = new FacilityClient();
                        fm.Facility_id = EntityDataId;
                        fm.Doc_flag = EntityName;
                        ds = fc.Get_Entity_Name_Document(fm, SessionController.ConnectionString);
                        lbl_entity_name.Text = EntityName + " " + "Name:";
                        lbl_entity_value.Text = ds.Tables[0].Rows[0]["name"].ToString();



                        GridSortExpression sortExpr = new GridSortExpression();
                        sortExpr.FieldName = "Attribute_name";
                        sortExpr.SortOrder = GridSortOrder.Ascending;
                        //Add sort expression, which will sort against first column
                        rgAttributes.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                        tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                        hfAttributePMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 2);
                        tempPageSize = hfAttributePMPageSize.Value;
                        bindAttributes();
                        //bindUnit();
                        //bindStage();
                        //bindGroup();

                    }
                }
            }
            else 
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            
            }
        }
        catch (Exception)
        {
            //Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
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

    protected void bindAttributes()
    {
        AttributeClient ctrl = new AttributeClient();
        AttributeModel mdl = new AttributeModel();
        DataSet ds;
        mdl.Entiy=EntityName;
        mdl.Entiy_data_id = EntityDataId;
        mdl.User_id = new Guid(SessionController.Users_.UserId.ToString());
        mdl.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
        if (attribute_name != "")
        {

            txtSearch.Text = attribute_name;
        }
        mdl.SearchText = txtSearch.Text.ToString();

       // ds=ctrl.GetAttribute(mdl,SessionController.ConnectionString.ToString());
        ds = ctrl.GetRoleBasedAttribute(mdl, SessionController.ConnectionString.ToString());
        if (flagCheck)
        {
            rgAttributes.AllowCustomPaging = true;
            if (tempPageSize != "")
                rgAttributes.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgAttributes.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
        }
        if (flag == "search" && txtSearch.Text != "")
        {
            //rgAttributes.MasterTableView.CurrentPageIndex = 0;
            //rgAttributes.MasterTableView.Rebind();
            rgAttributes.DataSource = ds;
            rgAttributes.DataBind();
            flag = "";
        }
        else
        {
            rgAttributes.DataSource = ds;
            rgAttributes.DataBind();
        }
        attribute_name = "";
    }

    protected void bindUnit()
    {
        AttributeClient ctrl = new AttributeClient();
        AttributeModel mdl = new AttributeModel();
        DataSet ds;
        ds = ctrl.GetUnit(SessionController.ConnectionString.ToString());
        
        cmb_uom.DataTextField = "unit";
        cmb_uom.DataValueField = "unit_of_measurement_id"; 
        cmb_uom.DataSource = ds;
        cmb_uom.DataBind();
    }

    protected void bindStage()
    {
        
        AttributeClient ctrl = new AttributeClient();
        AttributeModel mdl = new AttributeModel();
        DataSet ds;
        ds = ctrl.GetStage(SessionController.ConnectionString.ToString());

        cmbStage.DataTextField = "stage_name";
        cmbStage.DataValueField = "stage_id";
        cmbStage.DataSource = ds;
        cmbStage.DataBind();
        
       
    }

    protected void bindGroup()
    {
        AttributeClient ctrl = new AttributeClient();
        AttributeModel mdl = new AttributeModel();
        DataSet ds;
        ds = ctrl.GetGroup(SessionController.ConnectionString.ToString());

        cmbGroup_outer.DataTextField = "group_name";
        cmbGroup_outer.DataValueField = "group_id";
        cmbGroup_outer.DataSource = ds;
        cmbGroup_outer.DataBind();
       
    }

    protected void rgAttributes_OnSortCommand(object source, GridSortCommandEventArgs e)
    {
        bindAttributes();
    }

    protected void rgAttributes_OnPageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        flagCheck = false;
        bindAttributes();
        
    }

    public void rgAttributes_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {

        try
        {
            tempPageSize = e.NewPageSize.ToString();
            if (!flagCheck)
            {
                flagCheck = true;
                bindAttributes();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        
    }
    protected void rgAttributes_OnItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

        if (e.CommandName == "Versioning")
        {
            string attribute_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["attribute_id"].ToString();
            AttributeModel mdl = new AttributeModel();
            AttributeClient ctrl = new AttributeClient();
            string attribute_flag=null;
            //if (lbl_entity_name.Text == "Space Name:")
            //{
            //    attribute_flag = "Space";
            //}
            //else
            //{
                attribute_flag = "Facility";
            //}

            //string script = String.Format("openpopupVersioning({0},{1})", attribute_id, attribute_flag);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "openpopup", "openpopupVersioning('" + attribute_id + "','" + attribute_flag + "')", true);
        }        
        if (e.CommandName == "Edit")
        {
            bindAttributes();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }
        if (e.CommandName == "delete")
        {
            try
            {
                string attribute_ids = hf_Attribute_id.Value.ToString();
                AttributeModel mdl = new AttributeModel();
                AttributeClient ctrl = new AttributeClient();
                mdl.Entiy = EntityName;
                mdl.Entiy_data_id = EntityDataId;
                mdl.Attribute_ids = attribute_ids;
                ctrl.DeleteAttributes(mdl, SessionController.ConnectionString);
                bindAttributes();

            }
            catch (Exception ex)
            {
                 throw ex;
            }
        }

        if (e.CommandName == "Edit")
        {
            bindAttributes();
            e.Item.OwnerTableView.EditFormSettings.CaptionFormatString = "Edit Attribute:";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }
        if (e.CommandName == "Update" || e.CommandName == "PerformInsert")
        {
            AttributeClient ctrl = new AttributeClient();
            AttributeModel mdl = new AttributeModel();
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
                                mdl.Attribute_name = editorText.ToString();
                            }
                            if (editableCol.Column.UniqueName == "Attribute_description")
                            {
                                editorText = (editor as GridTextColumnEditor).Text;
                                mdl.AttributeDescription = editorText.ToString();
                            }
                            if (editableCol.Column.UniqueName == "Attribute_value")
                            {
                                editorText = (editor as GridTextColumnEditor).Text;
                                mdl.Attribute_value = editorText.ToString();
                            }
                        }
                        else if (editor is GridTemplateColumnEditor)
                        {
                            if (editableCol.Column.SortExpression == "attribute_unit")
                            {
                                if ((editor.ContainerControl.FindControl("cmb_unit") as RadComboBox).SelectedItem != null)
                                {
                                    mdl.Attribute_uom_id = new Guid(Convert.ToString((editor.ContainerControl.FindControl("cmb_unit") as RadComboBox).SelectedItem.Value.ToString()));
                                    if (mdl.Attribute_uom_id.Equals(Guid.Empty))
                                    {
                                    }
                                    else
                                    {
                                    }
                                }
                            }

                            if (editableCol.Column.SortExpression == "Attribute_stage_name")
                            {
                                mdl.Attribute_stage_id = new Guid(Convert.ToString((editor.ContainerControl.FindControl("cmb_stage") as RadComboBox).SelectedItem.Value.ToString()));
                                if (mdl.Attribute_stage_id.Equals(Guid.Empty))
                                {
                                }
                                else
                                {
                                }
                            }

                            if (editableCol.Column.SortExpression == "Attribute_group")
                            {
                                mdl.Attribute_group_id = new Guid(Convert.ToString((editor.ContainerControl.FindControl("cmb_group") as RadComboBox).SelectedItem.Value.ToString()));
                                if (mdl.Attribute_group_id.Equals(Guid.Empty))
                                {
                                }
                                else
                                {
                                }
                            }
                        }
                    }
                }
            }

            mdl.Entiy = EntityName;
            mdl.Entiy_data_id = EntityDataId;
            mdl.Attribute_created_by = new Guid(SessionController.Users_.UserId);
            mdl.Attribute_created_on = DateTime.Now;
            if (e.CommandName != "PerformInsert")
                mdl.Attribute_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["attribute_id"].ToString());
            else
            {
                mdl.Attribute_id = Guid.Empty;

                rgAttributes.MasterTableView.AllowAutomaticInserts = false;
                bindAttributes();
            }
            string attribute_exists = "";
            attribute_exists = ctrl.InsertUpdateAttribute(mdl, SessionController.ConnectionString.ToString());
            if (attribute_exists == "Y")
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
            }
            bindAttributes();
        }
        if (e.CommandName == "Delete")
        {
            // this.btnDelete_Click(null, null);
            try
            {
                GridDataItem[] items = rgAttributes.MasterTableView.GetSelectedItems();
                if (items.Length > 0)
                {
                    string attribute_ids = "";
                    for (int i = 0; i < items.Length; i++)
                    {
                        attribute_ids = attribute_ids + items[i].GetDataKeyValue("attribute_id") + ",";
                    }
                    //string attribute_ids = hf_Attribute_id.Value.ToString();
                    attribute_ids = attribute_ids.TrimEnd(',');
                    AttributeModel mdl = new AttributeModel();
                    AttributeClient ctrl = new AttributeClient();
                    mdl.Entiy = EntityName;
                    mdl.Entiy_data_id = EntityDataId;
                    mdl.Attribute_ids = attribute_ids;
                    ctrl.DeleteAttributes(mdl, SessionController.ConnectionString);
                    bindAttributes();
                }
                else
                {
                    bindAttributes();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "selectAttributeValidation()", true);
                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        if (e.CommandName == "InitInsert")
        {
            bindAttributes();
            e.Item.OwnerTableView.EditFormSettings.CaptionFormatString = "Add Attribute:";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_gridHeight()", true);
        }
        if (e.CommandName == "Cancel")
        {
            bindAttributes();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }
        if (e.CommandName == "Page")
        {
            bindAttributes();
        }

    }

    public DataTable RemoveDuplicateRows(DataTable dTable, string colName)
    {
        Hashtable hTable = new Hashtable();
        ArrayList duplicateList = new ArrayList();
        foreach (DataRow dtRow in dTable.Rows)
        {
            if (hTable.Contains(dtRow[colName]))
                duplicateList.Add(dtRow);
            else
                hTable.Add(dtRow[colName], string.Empty);
        }
        foreach (DataRow dtRow in duplicateList)
            dTable.Rows.Remove(dtRow);
        return dTable;
    }
    protected void rgAttributes_OnItemDataBound(object source, GridItemEventArgs e)
    {
        if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
        {
            RadComboBox cmbUnit = e.Item.FindControl("cmb_unit") as RadComboBox;
            RadComboBox cmbstage = e.Item.FindControl("cmb_stage") as RadComboBox;
            RadComboBox cmbgroup = e.Item.FindControl("cmb_group") as RadComboBox;

            AttributeClient ctrl = new AttributeClient();
            AttributeModel mdl = new AttributeModel();
            DataSet ds;

            DataSet ds_attribute_info;
            if (e.Item.ItemIndex != -1)
                mdl.Attribute_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["attribute_id"].ToString());
            else
                mdl.Attribute_id = Guid.Empty;
            mdl.Entiy = EntityName;
            mdl.Entiy_data_id = EntityDataId;
            ds_attribute_info = ctrl.GetAttributeById(mdl, SessionController.ConnectionString.ToString());
            
            ds = ctrl.GetGroup(SessionController.ConnectionString.ToString());
            cmbgroup.DataTextField = "group_name";
            cmbgroup.DataValueField = "group_id";
            //cmbgroup.DataSource = ds;
            cmbgroup.DataSource = this.RemoveDuplicateRows(ds.Tables[0], "group_name");
            cmbgroup.DataBind();

            if (ds_attribute_info.Tables[0].Rows.Count > 0)
            {
                if (ds_attribute_info.Tables[0].Rows[0]["Attribute_group"].ToString() != "")
                {
                    if (cmbgroup.FindItemByText(ds_attribute_info.Tables[0].Rows[0]["Attribute_group"].ToString()) != null)
                        cmbgroup.FindItemByText(ds_attribute_info.Tables[0].Rows[0]["Attribute_group"].ToString()).Selected = true;
                }
                else
                {
                    cmbgroup.ClearSelection();
                }
            }
           

            ds = ctrl.GetStage(SessionController.ConnectionString.ToString());
            cmbstage.DataTextField = "stage_name";
            cmbstage.DataValueField = "stage_id";
            cmbstage.DataSource = ds;
            cmbstage.DataBind();
            if (ds_attribute_info.Tables[0].Rows.Count > 0)
            {
                if (ds_attribute_info.Tables[0].Rows[0]["Attribute_stage_name"].ToString() != "")
                {
                    cmbstage.FindItemByText(ds_attribute_info.Tables[0].Rows[0]["Attribute_stage_name"].ToString()).Selected = true;
                }
                else
                {
                    cmbstage.ClearSelection();
                }
            }
           

            ds = ctrl.GetUnit(SessionController.ConnectionString.ToString());
            cmbUnit.DataTextField = "unit";
            cmbUnit.DataValueField = "unit_of_measurement_id";
            cmbUnit.DataSource = ds;
            cmbUnit.DataBind();
            if (ds_attribute_info.Tables[0].Rows.Count > 0)
            {
                if (ds_attribute_info.Tables[0].Rows[0]["attribute_unit"].ToString() != "")
                {
                    cmbUnit.FindItemByText(ds_attribute_info.Tables[0].Rows[0]["attribute_unit"].ToString()).Selected = true;
                }
                else
                {
                    cmbUnit.ClearSelection();
                }
            }
           
        }


  

        if (e.Item is GridHeaderItem)
        {
            GridHeaderItem headerItem = e.Item as GridHeaderItem;

            foreach (GridColumn column in rgAttributes.MasterTableView.RenderColumns)
            {
                if (column is GridBoundColumn)
                {
                    //if the sorting feature of the grid is enabled
                    if (column.HeaderText != "")
                        (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                }
                if (column is GridButtonColumn)
                {
                    //if the sorting feature of the grid is enabled
                    if (column.HeaderText != "" && column.HeaderText != Resources.Resource.Delete)
                        (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                }
                if (column is GridTemplateColumn)
                {
                    //if the sorting feature of the grid is enabled
                    if (column.HeaderText != "")
                        (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                }


            }
        }

        if (e.Item is GridPagerItem && flagCheck)
        {

            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            cb.Items.Sort(new PagerRadComboBoxItemComparer());
            if (tempPageSize != "")
            {
                cb.Items.FindItemByValue(tempPageSize).Selected = true;
            }
        }

        if (e.Item is GridPagerItem)
        {
            GridPagerItem pagerItem = e.Item as GridPagerItem;
            RadComboBox combo = pagerItem.FindControl("PageSizeComboBox") as RadComboBox;
            combo.EnableScreenBoundaryDetection = false;
            combo.ExpandDirection = RadComboBoxExpandDirection.Up;
        }

        /*if (e.Item is GridPagerItem)
        {

            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            cb.Items.Clear();

            RadComboBoxItem item = item = new RadComboBoxItem(SessionController.Users_.DefaultPageSizeGrids, SessionController.Users_.DefaultPageSizeGrids);
            item.Attributes.Add("ownerTableViewId", rgAttributes.MasterTableView.ClientID);
            item = new RadComboBoxItem("All", rgAttributes.MasterTableView.Items.Count.ToString());
            item.Attributes.Add("ownerTableViewId", rgAttributes.MasterTableView.Items.Count.ToString());
            if (cb.Items.FindItemByValue("All") == null)
                cb.Items.Add(item);

        }
         */

        if (e.Item is GridDataItem)
        {
            GridDataItem gridItem = e.Item as GridDataItem;
            foreach (GridColumn column in rgAttributes.MasterTableView.RenderColumns)
            {
                if (column is GridBoundColumn)
                {
                    //this line will show a tooltip based type of Databound for grid data field
                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "AttributeName")
                    {
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[0].ToString());
                    }
                    else
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                }
                else if (column is GridButtonColumn)
                {
                    //this line will show a tooltip based type of linkbutton for grid data field
                    if (column.OrderIndex > -1 && e.Item.DataItem != null)
                    {
                        if (column.UniqueName.ToString().Equals("name"))
                            //if(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].GetType() == typeof(string))
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                    }
                }
                else if (column is GridTemplateColumn)
                {
                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "unitName")
                    {
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[10].ToString());
                    }
                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "StageName")
                    {
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[12].ToString());
                    }
                }

            }
        }
    }
    protected void rgAttributes_OnPreRender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                foreach (GridDataItem item in rgAttributes.MasterTableView.Items)
                {
                    (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;

                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        AttributeClient ctrl = new AttributeClient();
        AttributeModel mdl = new AttributeModel();
        
        mdl.Entiy=EntityName;
        mdl.Entiy_data_id = EntityDataId;
        //mdl.Attribute_created_by=Guid.Empty;
        //mdl.Attribute_created_on="";
        mdl.Attribute_created_by = new Guid(SessionController.Users_.UserId);
        mdl.Attribute_created_on = DateTime.Now;
        mdl.Attribute_group_id=new Guid(cmbGroup_outer.SelectedValue.ToString());
        mdl.Attribute_id=Guid.Empty;
        mdl.Attribute_name=txtName.Text.ToString();
        mdl.Attribute_stage_id=new Guid(cmbStage.SelectedValue.ToString());

        ///priyanka
        if (cmb_uom.SelectedValue != "")
        {
            mdl.Attribute_uom_id = new Guid(cmb_uom.SelectedValue.ToString());
        }
        mdl.Attribute_value=txtValue.Text.ToString();
        mdl.AttributeDescription=txtDescription.Text.ToString();

        string attribute_exists="";
        attribute_exists=ctrl.InsertUpdateAttribute(mdl,SessionController.ConnectionString.ToString());
        if (attribute_exists == "Y")
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
        }
        bindAttributes();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        flag = "search";
        bindAttributes();
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                btnAddAttribute.Visible = false;
                btnDelete.Visible = false;
            }
            if (SessionController.Users_.UserSystemRole == "PA")
            {
                btnAddAttribute.Visible = false;
                btnDelete.Visible = false;
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
            DataRow dr_component = ds_component.Tables[0].Select("name='Facility'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Attributes")
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
            rgAttributes.Columns.FindByUniqueName("EditCommandColumn").Display = false;
            btnAddAttribute.Enabled = false;
        }
        else
        {
            btnAddAttribute.Enabled = true;
            rgAttributes.Columns.FindByUniqueName("EditCommandColumn").Display = true;
        }

        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rgAttributes.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }
            // btnDelete.Enabled = false;
        }
        else
        {
            //foreach (GridDataItem item in rgAttributes.MasterTableView.Items)
            //{
            //    ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
            //    imgbtnDelete.Enabled = true;
            //}
             btnDelete.Enabled = true;
        }





    }
   
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            string attribute_ids = hf_Attribute_id.Value.ToString();
            AttributeModel mdl = new AttributeModel();
            AttributeClient ctrl = new AttributeClient();
            mdl.Entiy = EntityName;
            mdl.Entiy_data_id = EntityDataId;
            mdl.Attribute_ids = attribute_ids;
            ctrl.DeleteAttributes(mdl, SessionController.ConnectionString);
            bindAttributes();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rgAttributes_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem item = e.Item as GridEditableItem;
            GridTextBoxColumnEditor editor = (GridTextBoxColumnEditor)item.EditManager.GetColumnEditor("Attribute_name");
            TableCell cell = (TableCell)editor.TextBoxControl.Parent;
            RequiredFieldValidator validator = new RequiredFieldValidator();
            editor.TextBoxControl.ID = "RequiredFieldValidatorName";
            validator.ControlToValidate = editor.TextBoxControl.ID;
            validator.ErrorMessage = "*";
            cell.Controls.Add(validator);
        }
    }
}