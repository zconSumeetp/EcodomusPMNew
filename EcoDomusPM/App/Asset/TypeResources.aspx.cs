using System;
using System.Collections.Generic;
using System.Linq;
using System.Web; 
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using EcoDomus.Session;
using Attributes;
using TypeProfile;
using System.Threading;
using System.Globalization;

public partial class App_Asset_TypeResources : System.Web.UI.Page
{
    Guid EntityDataId;
    string EntityName = "";
    string tempPageSize = "";
    bool flag = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        EntityDataId = new Guid(Request.QueryString["entity_id"].ToString());
        EntityName = Request.QueryString["entity_name"].ToString();
        string abc = Request.QueryString.ToString();

        txtSearch.Attributes.Add("onKeyPress", "doClick('" + btnSearch.ClientID + "',event)");
      
        try
        {
            if (SessionController.ConnectionString.ToString() != "")
            {
                if (!IsPostBack)
                {
                    
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "Resource_name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgResources.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    hfDocumentPMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 2);
                    tempPageSize = hfDocumentPMPageSize.Value;
                   
                    BindGrid();

                   // BindJobs();
                    BindCategory();
                }
               
                BindCategory();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //protected void BindJobs()
    //{
    //    DataSet ds = new DataSet();
    //    TypeModel mdl = new TypeModel();
    //    TypeProfileClient ctl = new TypeProfileClient();
    //    mdl.Facility_Id = new Guid(Request.QueryString["entity_id"].ToString());
    //    mdl.Txt_Search = "";
    //    ds = ctl.proc_get_facility_jobs(mdl, SessionController.ConnectionString);
    //    cmb_job.DataTextField = "name";
    //    cmb_job.DataValueField = "pk_job_id";
    //    cmb_job.DataSource = ds;
    //    cmb_job.DataBind();
        
    //}
    //public void BindJobTasks(Guid job_id)
    //{
    //    DataSet ds_jobtask = new DataSet();
    //    TypeModel mdl = new TypeModel();
    //    TypeProfileClient ctl = new TypeProfileClient();
    //    mdl.jobid = new Guid(cmb_job.SelectedValue.ToString());
    //    ds_jobtask = ctl.proc_get_job_tasks(mdl, SessionController.ConnectionString);
    //    cmb_job_task.DataTextField = "des";
    //    cmb_job_task.DataValueField = "pk_job_task_id";
    //    cmb_job_task.DataSource = ds_jobtask;
    //    cmb_job_task.DataBind();

       
    //}
    public void BindCategory()
    {
        DataSet ds_category = new DataSet();
        TypeModel mdl = new TypeModel();
        TypeProfileClient ctl = new TypeProfileClient();

        ds_category = ctl.proc_get_resource_category(mdl, SessionController.ConnectionString);
        cmb_category .DataTextField = "category_name";
        cmb_category.DataValueField = "pk_resourse_category_id";
        cmb_category.DataSource = ds_category;
        cmb_category.DataBind();
        
        
    }
    public void BindGrid()
    {
        try
        {
            DataSet ds = new DataSet();
            TypeModel typemdl = new TypeModel();
            TypeProfileClient typeclient = new TypeProfileClient();
            typemdl.Facility_Id = EntityDataId;
            typemdl.Txt_Search = txtSearch.Text.Trim().Replace("'", "''");

            ds = typeclient.proc_get_facility_resources(typemdl, SessionController.ConnectionString);
            rgResources.AllowCustomPaging = true;
            // rgdocument.AllowPaging = true;
            if (tempPageSize != "")
                rgResources.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgResources.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
            rgResources.DataSource = ds;
            rgResources.DataBind();
         }
         catch (Exception ex)
         {
             throw ex;
         }
     }

  
    protected void rgResources_OnItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        Guid resource_id = Guid.Empty;

        if (e.CommandName == "Edit")
        {
            BindGrid();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }
        else if (e.CommandName == "deleteResource")
        {
            resource_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_resource_id"].ToString());

            TypeModel typemdl = new TypeModel();
            TypeProfileClient typeclient = new TypeProfileClient();
            typemdl.Pk_resource_id = resource_id;
            typeclient.DeleteTypeResource(typemdl, SessionController.ConnectionString);
            BindGrid();
        }
        if (e.CommandName == "InitInsert")
        {
            BindGrid();
            e.Item.OwnerTableView.EditFormSettings.CaptionFormatString = "Add Resource:";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_gridHeight()", true);
        }
        if (e.CommandName == "RebindGrid")
        {
            BindGrid();
        }

        if (e.CommandName == "Cancel")
        {
            BindGrid();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }
        if (e.CommandName == "Page")
        {
            BindGrid();
        }
        else if (e.CommandName == "Update" || e.CommandName == "PerformInsert")
        {
            TypeProfileClient ctrl = new TypeProfileClient();
            TypeModel mdl = new TypeModel();
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
                            if (editableCol.Column.UniqueName == "Resource_name")
                            {
                                editorText = (editor as GridTextColumnEditor).Text;
                                mdl.Resource_name = editorText.ToString();
                            }
                            if (editableCol.Column.UniqueName == "Resource_description")
                            {
                                editorText = (editor as GridTextColumnEditor).Text;
                                mdl.Resource_description = editorText.ToString();
                            }
                        
                        }
                        else if (editor is GridTemplateColumnEditor)
                        {
                            if (editableCol.Column.SortExpression == "resource_category_name")
                            {
                                if ((editor.ContainerControl.FindControl("cmb_resource_category") as RadComboBox).SelectedItem != null)
                                {
                                    mdl.Job_category_id = new Guid(Convert.ToString((editor.ContainerControl.FindControl("cmb_resource_category") as RadComboBox).SelectedItem.Value.ToString()));
                                    if (mdl.Job_category_id .Equals(Guid.Empty))
                                    {
                                    }
                                    else
                                    {
                                    }
                                }
                            }

           

                            //if (editableCol.Column.SortExpression == "Attribute_group")
                            //{
                                //mdl.Attribute_group_id = new Guid(Convert.ToString((editor.ContainerControl.FindControl("cmb_group") as RadComboBox).SelectedItem.Value.ToString()));
                                //if (mdl.Attribute_group_id.Equals(Guid.Empty))
                                //{
                                //}
                                //else
                                //{
                                //}
                            //}
                        }
                    }
                }
            }
           
            mdl.Type_Id = EntityDataId;
            mdl.User_id = new Guid(SessionController.Users_.UserId);
            mdl.Facility_Id = new Guid(SessionController.Users_.facilityID);
            if (e.CommandName != "PerformInsert")
            {
                mdl.Pk_resource_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_resource_id"].ToString());
                //mdl.jobid = new Guid(Convert.ToString(cmb_job.SelectedItem.Value));
                //mdl.jobTaskId = new Guid(Convert.ToString(cmb_job_task.SelectedItem.Value));

            }
            else
            {
                mdl.Pk_resource_id = Guid.Empty;
                //ds = ctrl.InsertUpdateTypeSpares(mdl, SessionController.ConnectionString.ToString());
                rgResources.MasterTableView.AllowAutomaticInserts = false;
                //BindGrid();
                txtName.Text = "";
                // cmb_job.ClearSelection();
                // cmb_job_task.ClearSelection();
                cmb_category.ClearSelection();
                txtDescription.Text = "";
            }
            //string resource_exists = "";
            DataSet ds_res = new DataSet();
            ds_res = ctrl.InsertUpdateTypeResources(mdl, SessionController.ConnectionString.ToString());

            //if (ds_res == "Y")
            //{

            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
            //}
            this.BindGrid();
        }
        
    }
    protected void rgResources_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridPagerItem)
        {
            GridPagerItem pagerItem = e.Item as GridPagerItem;
            RadComboBox combo = pagerItem.FindControl("PageSizeComboBox") as RadComboBox;
            combo.EnableScreenBoundaryDetection = false;
            combo.ExpandDirection = RadComboBoxExpandDirection.Up;
        }
        if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
        {
            RadComboBox cmb_resource_category = e.Item.FindControl("cmb_resource_category") as RadComboBox;
            
           // RadComboBox cmbgroup = e.Item.FindControl("cmb_group") as RadComboBox;

            TypeProfileClient client = new TypeProfileClient();
            TypeModel model = new TypeModel();

            DataSet ds = new DataSet();
            DataSet ds_resource_info = new DataSet();

            if (e.Item.ItemIndex != -1)
            {
                model.Pk_resource_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_resource_id"].ToString());
                //mdl1.Type_Id = new Guid(Request.QueryString["Type_id"].ToString());
            }
            else
                model.Pk_resource_id = Guid.Empty;
          
            ds_resource_info = client.GetResourceById(model, SessionController.ConnectionString.ToString());

            ds = client.proc_get_resource_category(model ,SessionController.ConnectionString.ToString());
            cmb_resource_category.DataTextField = "category_name";
            cmb_resource_category.DataValueField = "pk_resourse_category_id";
            cmb_resource_category.DataSource = ds;
            cmb_resource_category.DataBind();
            //ds = ctrl.GetGroup(SessionController.ConnectionString.ToString());
            //cmbgroup.DataTextField = "group_name";
            //cmbgroup.DataValueField = "group_id";
            //cmbgroup.DataSource = ds;
            //cmbgroup.DataBind();

            //if (ds_attribute_info.Tables[0].Rows.Count > 0)
            //{
            //    if (ds_attribute_info.Tables[0].Rows[0]["Attribute_group"].ToString() != "")
            //    {
            //        cmbgroup.FindItemByText(ds_attribute_info.Tables[0].Rows[0]["Attribute_group"].ToString()).Selected = true;
            //    }
            //    else
            //    {
            //        cmbgroup.ClearSelection();
            //    }
            //}

       
            if (ds_resource_info.Tables[0].Rows.Count > 0)
            {
                if (ds_resource_info.Tables[0].Rows[0]["category_name"].ToString() != "")
                {
                    cmb_resource_category.FindItemByText(ds_resource_info.Tables[0].Rows[0]["category_name"].ToString()).Selected = true;
                }
                else
                {
                    cmb_resource_category.ClearSelection();
                }
            }
        }

        if (e.Item is GridHeaderItem)
        {
            GridHeaderItem headerItem = e.Item as GridHeaderItem;

            foreach (GridColumn column in rgResources.MasterTableView.RenderColumns)
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
                    if (column.HeaderText != "" && column.HeaderText != "Delete")
                        (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                }
                if (column is GridTemplateColumn)
                {
                    //if the sorting feature of the grid is enabled
                    if (column.HeaderText != "") ;
                        //(headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                }


            }
        }
        if (e.Item is GridDataItem)
        {
            GridDataItem gridItem = e.Item as GridDataItem;
            foreach (GridColumn column in rgResources.MasterTableView.RenderColumns)
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
                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "space_name")
                    {
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[1].ToString());
                    }
                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "StageName")
                    {
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[12].ToString());
                    }
                }

            }
        }

        if (e.Item is GridPagerItem)
        {

            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            cb.Items.Sort(new PagerRadComboBoxItemComparer());
            if (tempPageSize != "")
            {
                cb.Items.FindItemByValue(tempPageSize).Selected = true;
            }
        }
    }
    protected void rgResources_OnSortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        BindGrid();
    }
    protected void rgResources_OnPageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        BindGrid();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
       
    }
    protected void rgResources_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindGrid();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
       
    }
    protected void rgResources_OnPreRender(object sender, EventArgs e)
    {

        if (SessionController.Users_.UserSystemRole == "GU")
        {
            btnAddResource.Visible = false;
            foreach (GridDataItem item in rgResources.MasterTableView.Items)
            {
                ImageButton img_btn = (ImageButton)item.FindControl("imgbtnDelete");
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;
                if (img_btn != null)
                {
                    img_btn.Visible = false;
                }

            }

        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        TypeModel mdl = new TypeModel();
        TypeProfileClient ctl = new TypeProfileClient();
        DataSet ds_resources = new DataSet();
        mdl.Pk_resource_id = Guid.Empty;
        mdl.Resource_name = txtName.Text;
        mdl.Resource_description = txtDescription.Text;
       // mdl.jobid = new Guid(Convert.ToString(cmb_job.SelectedItem.Value));
       // mdl.jobTaskId = new Guid(Convert.ToString(cmb_job_task.SelectedItem.Value));
        if (cmb_category.SelectedItem != null)
        {
            mdl.Job_category_id = new Guid(Convert.ToString(cmb_category.SelectedItem.Value));
        }
        else
        {
            mdl.Job_category_id = Guid.Empty;
        }
        mdl.Type_Id = EntityDataId;
        mdl.Facility_Id = new Guid( SessionController.Users_.facilityID);
        mdl.User_id = new Guid(SessionController.Users_.UserId.ToString());
        ds_resources = ctl.InsertUpdateTypeResources(mdl, SessionController.ConnectionString);

        BindGrid();
        txtName.Text = "";
       // cmb_job.ClearSelection();
       // cmb_job_task.ClearSelection();
        cmb_category.ClearSelection();
        txtDescription.Text = "";
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        if (SessionController.Users_.Permission_ds != null)
        {
            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
            {
                {
                    SetPermissions();
                }
            }
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
                if (dr_profile["name"].ToString() == "Resources")
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
        // edit permission
        if (edit_permission == "N")
        {
            btnAddResource.Enabled = false;
            foreach (GridDataItem item in rgResources.MasterTableView.Items)
            {
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;
            }

            
        }
        else
        {
            btnAddResource.Enabled = true;
            foreach (GridDataItem item in rgResources.MasterTableView.Items)
            {
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = true;
            }
           
        }

        //delete permission
        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rgResources.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }
        }
        else
        {
            foreach (GridDataItem item in rgResources.MasterTableView.Items)
            {
                ImageButton imgbtndelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtndelete.Enabled = true;
            }
        }
    }
    protected void rgResources_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem item = e.Item as GridEditableItem;
            GridTextBoxColumnEditor editor = (GridTextBoxColumnEditor)item.EditManager.GetColumnEditor("Resource_name");
            TableCell cell = (TableCell)editor.TextBoxControl.Parent;
            RequiredFieldValidator validator = new RequiredFieldValidator();
            editor.TextBoxControl.ID = "RequiredFieldValidatorName";
            validator.ControlToValidate = editor.TextBoxControl.ID;
            validator.ErrorMessage = "*";
            cell.Controls.Add(validator);
        }
    }
}