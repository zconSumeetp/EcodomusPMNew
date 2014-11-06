using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using TypeProfile;
using EcoDomus.Session;
using Telerik.Web.UI; 
using System.Threading;
using System.Globalization;

public partial class App_Asset_TypeSpares : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flagCheck = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtSearch.Attributes.Add("onKeyPress", "doClick('" + btnSearch.ClientID + "',event)");
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {

                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "SpareName";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rg_TypeSpares.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                
                tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                hfAttributePMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize));
                tempPageSize = hfAttributePMPageSize.Value;//Convert.ToString(Convert.ToInt32(tempPageSize) - 2);
                                    
                BindGrid();
                BindSupplier();
                BindCategory();
            }
        }
        else
        {
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
    protected void rg_TypeSpares_OnItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edit")
            {
                BindGrid();
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
            }
            if (e.CommandName == "deleteSpare")
            {
                string spare_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_spare_id"].ToString();
                TypeModel mdl = new TypeModel();
                TypeProfileClient ctrl = new TypeProfileClient();
                mdl.Pk_Spare_Id = new Guid(spare_id);
                ctrl.DeleteTypeSpares(mdl, SessionController.ConnectionString);
                BindGrid();
            }
            if (e.CommandName == "Update" || e.CommandName == "PerformInsert")
            {
                DataSet ds = new DataSet();
                TypeModel mdl = new TypeModel();
                TypeProfileClient ctrl = new TypeProfileClient();
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
                                if (editableCol.Column.UniqueName == "SpareName")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                    mdl.spare_name = editorText.ToString();
                                }
                                if (editableCol.Column.UniqueName == "Description")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                    mdl.Txt_Description = editorText.ToString();
                                }
                                if (editableCol.Column.UniqueName == "SetNumber")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                    mdl.SetNumber = editorText.ToString();
                                }
                                if (editableCol.Column.UniqueName == "PartNumber")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                    mdl.PartNumber = editorText.ToString();
                                }
                            }
                            else if (editor is GridTemplateColumnEditor)
                            {
                                if (editableCol.Column.SortExpression == "Suppliers")
                                {
                                    if ((editor.ContainerControl.FindControl("cmb_Supplier") as RadComboBox).SelectedItem != null)
                                    {
                                        mdl.Fk_Manufacturer_Id = new Guid(Convert.ToString((editor.ContainerControl.FindControl("cmb_Supplier") as RadComboBox).SelectedItem.Value.ToString()));
                                        if (mdl.Fk_Manufacturer_Id.Equals(Guid.Empty))
                                        {
                                        }
                                        else
                                        {
                                        }
                                    }
                                }

                                if (editableCol.Column.SortExpression == "Category")
                                {
                                    mdl.fk_Spare_category_Id = new Guid(Convert.ToString((editor.ContainerControl.FindControl("cmb_category") as RadComboBox).SelectedItem.Value.ToString()));
                                    if (mdl.fk_Spare_category_Id.Equals(Guid.Empty))
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



                mdl.Type_Id = new Guid(Request.QueryString["Type_id"].ToString());
                //mdl.fk_Spare_category_Id = Guid.Empty;
                mdl.User_id = new Guid(SessionController.Users_.UserId);
                //mdl.Fk_Manufacturer_Id = Guid.Empty;
               
                if (e.CommandName != "PerformInsert")
                {
                    mdl.Pk_Spare_Id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_spare_id"].ToString());
                    //ds = ctrl.InsertUpdateTypeSpares(mdl, SessionController.ConnectionString.ToString());
                    BindGrid();
                }
                else
                {
                    mdl.Pk_Spare_Id = Guid.Empty;
                    //ds = ctrl.InsertUpdateTypeSpares(mdl, SessionController.ConnectionString.ToString());
                    rg_TypeSpares.MasterTableView.AllowAutomaticInserts = false;
                    
                }
                ds = ctrl.InsertUpdateTypeSpares(mdl, SessionController.ConnectionString.ToString());
                BindGrid();
                if (ds.Tables[0].Rows[0]["flag"].ToString() == "Y")
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
                }


                e.Item.Edit = false;
            }
           
            if (e.CommandName == "InitInsert")
            {
                BindGrid();
                e.Item.OwnerTableView.EditFormSettings.CaptionFormatString =  "Add Spares";
                
                

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
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_TypeSpares_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {

            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rg_TypeSpares.MasterTableView.RenderColumns)
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
                        if (column.HeaderText != "" && column.UniqueName != "pk_spare_id")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }


                }
            }
            if (e.Item is GridPagerItem)
            {
                GridPagerItem pagerItem = e.Item as GridPagerItem;
                RadComboBox combo = pagerItem.FindControl("PageSizeComboBox") as RadComboBox;
                combo.EnableScreenBoundaryDetection = false;
                combo.ExpandDirection = RadComboBoxExpandDirection.Up;
            }
            if (e.Item is GridDataItem)
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                foreach (GridColumn column in rg_TypeSpares.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null)
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                        }
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
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "Category")
                        {
                           // gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[3].ToString());
                        }
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "suppliers")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[4].ToString());
                        }
                    }

                }
            }

            if (e.Item is GridPagerItem && !flagCheck)
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
            if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {

                RadComboBox cmbSupplier = e.Item.FindControl("cmb_Supplier") as RadComboBox;
                RadComboBox cmbCategory = e.Item.FindControl("cmb_category") as RadComboBox;
                // RadComboBox cmbgroup = e.Item.FindControl("cmb_group") as RadComboBox;

                DataSet ds_spare_info;
                TypeModel mdl1 = new TypeModel();
                TypeProfileClient ctrl1 = new TypeProfileClient();

                if (e.Item.ItemIndex != -1)
                {
                    mdl1.Pk_Spare_Id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_spare_id"].ToString());
                    mdl1.Type_Id = new Guid(Request.QueryString["Type_id"].ToString());
                }
                else
                    mdl1.Type_Id = Guid.Empty;
                               
                ds_spare_info = ctrl1.GetSpareProfile(mdl1, SessionController.ConnectionString.ToString());

                DataSet ds = new DataSet();
                TypeModel mdl = new TypeModel();
                TypeProfileClient ctrl = new TypeProfileClient();
                mdl.Organization_Id = Guid.Empty;
                ds = ctrl.Getguarantor(mdl, SessionController.ConnectionString);

                cmbSupplier.DataTextField = "name";
                cmbSupplier.DataValueField = "ID";
                cmbSupplier.DataSource = ds;
                cmbSupplier.DataBind();

                if (ds_spare_info.Tables[0].Rows.Count > 0)
                {
                    if (ds_spare_info.Tables[0].Rows[0]["suppliers"].ToString() != "")
                    {
                        cmbSupplier.FindItemByText(ds_spare_info.Tables[0].Rows[0]["suppliers"].ToString()).Selected = true;
                    }
                    else
                    {
                        cmbSupplier.ClearSelection();
                    }
                }
                mdl.User_id = Guid.Empty;
                ds = ctrl.GetSpareCategory(mdl, SessionController.ConnectionString);
                cmbCategory.DataTextField = "name";
                cmbCategory.DataValueField = "ID";
                cmbCategory.DataSource = ds;
                cmbCategory.DataBind();

                if (ds_spare_info.Tables[0].Rows.Count > 0)
                {
                    if (ds_spare_info.Tables[0].Rows[0]["category"].ToString() != "")
                    {
                        cmbCategory.FindItemByText(ds_spare_info.Tables[0].Rows[0]["category"].ToString()).Selected = true;
                    }
                    else
                    {
                        cmbCategory.ClearSelection();
                    }
                }



            }

           
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_TypeSpares_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            GridEditableItem item = e.Item as GridEditableItem;
            GridTextBoxColumnEditor editor = (GridTextBoxColumnEditor)item.EditManager.GetColumnEditor("SpareName");
            TableCell cell = (TableCell)editor.TextBoxControl.Parent;
            RequiredFieldValidator validator = new RequiredFieldValidator();
            editor.TextBoxControl.ID = "RequiredFieldValidatorName";
            validator.ControlToValidate = editor.TextBoxControl.ID;
            validator.ErrorMessage = "*";
            cell.Controls.Add(validator);
        }
    }

    public void BindGrid()
    {
        try
        {
            DataSet ds = new DataSet();
            TypeModel tm = new TypeModel();
            TypeProfileClient tc = new TypeProfileClient();
            tm.Type_Id = new Guid(Request.QueryString["Type_id"].ToString());
            tm.Txt_Search = txtSearch.Text;
            ds = tc.GetTypeSpares(tm, SessionController.ConnectionString);
            if (!flagCheck)
            {
                rg_TypeSpares.AllowCustomPaging = true;
                if (tempPageSize != "")
                    rg_TypeSpares.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
                rg_TypeSpares.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
            }
            rg_TypeSpares.DataSource = ds;
            rg_TypeSpares.DataBind();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public void BindCategory()
    {
        try
        {
            DataSet ds = new DataSet();
            TypeModel tm = new TypeModel();
            TypeProfileClient tc = new TypeProfileClient();
            tm.User_id = Guid.Empty;
            ds = tc.GetSpareCategory(tm, SessionController.ConnectionString);
            cmb_category.DataTextField = "name";
            cmb_category.DataValueField = "ID";
            cmb_category.DataSource = ds;
            cmb_category.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    public void BindSupplier()
    {
        try
        {
            DataSet ds = new DataSet();
            TypeModel mdl = new TypeModel();
            TypeProfileClient ctrl = new TypeProfileClient();
            mdl.Organization_Id = Guid.Empty;
            ds = ctrl.Getguarantor(mdl, SessionController.ConnectionString);

            //cmb_Supplier.DataTextField = "name";
            //cmb_Supplier.DataValueField = "ID";
            //cmb_Supplier.DataSource = ds;
            //cmb_Supplier.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ibtnSearch_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void btnSearch_Click(object sender, EventArgs e)
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            TypeModel tm = new TypeModel();
            TypeProfileClient tc = new TypeProfileClient();
            tm.Pk_Spare_Id = Guid.Empty;
            tm.spare_name = txtName.Text;
            tm.fk_Spare_category_Id = new Guid(cmb_category.SelectedValue);
            if (!(string.IsNullOrEmpty(hf_supplier_ids.Value)))
                tm.Fk_Manufacturer_Id = new Guid(hf_supplier_ids.Value);
            else
                tm.Fk_Manufacturer_Id = Guid.Empty;
            //  tm.Fk_Manufacturer_Id = new Guid(cmb_Supplier.SelectedValue);
            tm.Txt_Description = txtDescription.Text;
            tm.SetNumber = txtSetNumber.Text;
            tm.PartNumber = txtPartNumber.Text;
            tm.Type_Id = new Guid(Request.QueryString["Type_id"].ToString());
            tm.User_id = new Guid(SessionController.Users_.UserId);
            ds = tc.InsertUpdateTypeSpares(tm, SessionController.ConnectionString);
            if (ds.Tables[0].Rows[0].ToString() == "Y")
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
            }
            BindGrid();
            txtName.Text = "";
            txtSetNumber.Text = "";
            txtPartNumber.Text = "";
            txtDescription.Text = "";
            cmb_category.ClearSelection();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btnAddAttribute_Click(object sender, EventArgs e)
    {
        btnAddAttribute.Visible = false;
    }
    protected void rg_TypeSpares_OnSortCommand(object sender, GridSortCommandEventArgs e)
    {
        BindGrid();

    }
    protected void rg_TypeSpares_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        BindGrid();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
    }
    protected void rg_TypeSpares_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        BindGrid();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
    }
    protected void rg_TypeSpares_OnPreRender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "GU")
        {
            foreach (GridDataItem item in rg_TypeSpares.MasterTableView.Items)
            {
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;
                ImageButton btn = item.FindControl("imgbtnDelete") as ImageButton;
                if (btn != null)
                {
                    btn.Visible = false;
                }
            }
        }

    }
    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                btnAddAttribute.Visible = false;
                foreach (GridDataItem item in rg_TypeSpares.MasterTableView.Items)
                {
                    (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;
                    ImageButton img_btn = item.FindControl("imgbtnDelete") as ImageButton;
                    if (img_btn != null)
                    {
                        img_btn.Visible = false;
                    }
                }

            }
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
            DataRow dr_component = ds_component.Tables[0].Select("name='Type'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Spares")
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
            btnAddAttribute.Enabled = false;
            foreach (GridDataItem item in rg_TypeSpares.MasterTableView.Items)
            {
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;
            }
        }
        else
        {
            btnAddAttribute.Enabled = true;
            foreach (GridDataItem item in rg_TypeSpares.MasterTableView.Items)
            {
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = true;
            }
        }

        //delete permission
        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rg_TypeSpares.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }
        }
        else
        {
            foreach (GridDataItem item in rg_TypeSpares.MasterTableView.Items)
            {
                ImageButton imgbtndelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtndelete.Enabled = true;
            }
        }
    }
}