using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Locations;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;

public partial class App_Settings_DocumentType : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flag = false;

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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "document_type_name";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            rgDocumentType.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
            tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
            hfDocumentPMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize));
            tempPageSize = hfDocumentPMPageSize.Value;
        }
    }

    protected void rgDocumentType_OnNeedDataSource(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        Organization.OrganizationClient locObj_crtl = new Organization.OrganizationClient();
        Organization.OrganizationModel locObj_mdl = new Organization.OrganizationModel();

        string organization_id = new Guid().ToString();
        if (Request.QueryString["organization_id"] != null)
        {
            organization_id = Convert.ToString(Request.QueryString["organization_id"]);
        }
        locObj_mdl.Organization_Id =new Guid(organization_id);
        ds = locObj_crtl.Get_Document_Type_for_Organization(locObj_mdl);
        rgDocumentType.AllowCustomPaging = true;
        if (tempPageSize != "")
            rgDocumentType.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
        rgDocumentType.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));

        rgDocumentType.DataSource = ds;
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
    }

    protected void rgDocumentType_ItemCommand(object sender, GridCommandEventArgs e)
    {
        lblMsg.Text = "";
        if (e.CommandName.Equals("Delete"))
        {
            Guid pk_document_type_id = new Guid(((GridDataItem)e.Item).GetDataKeyValue("pk_document_type_id").ToString());

            Organization.OrganizationClient locObj_crtl = new Organization.OrganizationClient();
            Organization.OrganizationModel locObj_mdl = new Organization.OrganizationModel();
            locObj_mdl.Document_Type_Id = pk_document_type_id;
            locObj_crtl.Delete_Document_Type_for_Organization(locObj_mdl);
        }
        if (e.CommandName == "InitInsert")
        {
            //Bind_Phase_Grid();
            e.Item.OwnerTableView.EditFormSettings.CaptionFormatString = "Add Attribute:";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_gridHeight()", true);
        }
        if (e.CommandName == "Cancel")
        {
            //Bind_Phase_Grid();
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }
        if (e.CommandName == "Page")
        {
            //Bind_Phase_Grid();
        }

       
            if (e.CommandName == "Update" || e.CommandName == "PerformInsert")
            {
                try
                {
                    string organization_id = new Guid().ToString();
                    if (Request.QueryString["organization_id"] != null)
                    {
                        organization_id = Convert.ToString(Request.QueryString["organization_id"]);
                    }

                    Organization.OrganizationClient locObj_crtl = new Organization.OrganizationClient();
                    Organization.OrganizationModel locObj_mdl = new Organization.OrganizationModel();
                    locObj_mdl.Organization_Id = new Guid(organization_id);
                    locObj_mdl.User_id = new Guid(SessionController.Users_.UserId);
                    

                 
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
                                    if (editableCol.Column.UniqueName == "document_type_name")
                                    {
                                        editorText = (editor as GridTextColumnEditor).Text;
                                        locObj_mdl.Document_Type_Name = editorText.ToString();
                                    }
                                   
                                }
                            }
                        }
                    }
                    /*
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (ds.Tables[0].Rows[0]["phase_id"].ToString().Equals(Guid.Empty.ToString()))
                        {
                            string nw1 = "<script language='javascript'>alert('Phase name already exists..');</script>";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "script", nw1);
                        }
                    }
                  
                   */


                    locObj_mdl = locObj_crtl.Insert_Document_Type_for_Organization(locObj_mdl);
                    if (locObj_mdl.existsflag)
                    {
                        //string nw1 = "<script language='javascript'>alert('Phase name already exists..');</script>";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "AlertExistDocument();", true);
                    }
                    rgDocumentType.MasterTableView.Rebind();
                }
                catch (Exception ex)
                {
                    throw ex;
                }

            }
       
        if (e.CommandName == "Edit")
        {
            //Bind_Phase_Grid();
            //e.Item.OwnerTableView.EditFormSettings.CaptionFormatString = "Edit Attribute:";
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }
    }

    protected void btnSaveDocumentType_Click(object sender, EventArgs e)
    {
        try
        {
            string organization_id = new Guid().ToString();
            if (Request.QueryString["organization_id"] != null)
            {
                organization_id = Convert.ToString(Request.QueryString["organization_id"]);
            }

            Organization.OrganizationClient locObj_crtl = new Organization.OrganizationClient();
            Organization.OrganizationModel locObj_mdl = new Organization.OrganizationModel();
            locObj_mdl.Organization_Id =new Guid(organization_id);
            locObj_mdl.User_id = new Guid(SessionController.Users_.UserId);
            locObj_mdl.Document_Type_Name = txtDocumentTypeName.Text;

            locObj_mdl = locObj_crtl.Insert_Document_Type_for_Organization(locObj_mdl);
            if (locObj_mdl.existsflag)
            {
                lblMsg.Text = txtDocumentTypeName.Text + " is already present for selected organization...";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                txtDocumentTypeName.Text = "";
                lblMsg.Text = "";
                trAddDocumentType.Style["display"] = "block";
                trSaveDocumentType.Style["display"] = "none";
            }

            rgDocumentType.MasterTableView.Rebind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnAddDocumentType_OnClick(object sender, EventArgs e)
    {
        trAddDocumentType.Style["display"] = "none";
        trSaveDocumentType.Style["display"] = "block";
        lblMsg.Text = "";
    }

    protected void btnCancleDocumentType_OnClick(object sender, EventArgs e)
    {
        trAddDocumentType.Style["display"] = "block";
        trSaveDocumentType.Style["display"] = "none";
        lblMsg.Text = "";
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "CBU")
            {

               // btnAddDocumentType.Visible = false;
                foreach (GridDataItem item in rgDocumentType.MasterTableView.Items)
                {
                    ImageButton img_btn = item.FindControl("btnRemove") as ImageButton;
                    if (img_btn != null)
                    {
                        //img_btn.Visible = false;
                    }
                
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
            DataRow dr_component = ds_component.Tables[0].Select("name='BIM Server'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Organizations")
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
            btnAddDocumentType.Enabled = false;
        }
        else
        {
            btnAddDocumentType.Enabled = true;
        }

        //delete permission
        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rgDocumentType.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("btnRemove");
                imgbtnDelete.Enabled = false;
            }
        }

        else
        {
            foreach (GridDataItem item in rgDocumentType.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("btnRemove");
                imgbtnDelete.Enabled = true;
            }
        }




    }
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void rgDocumentType_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {


            GridEditableItem item = e.Item as GridEditableItem;
            GridTextBoxColumnEditor editorName = (GridTextBoxColumnEditor)item.EditManager.GetColumnEditor("document_type_name");

            TableCell cellName = (TableCell)editorName.TextBoxControl.Parent;



            RequiredFieldValidator validatoreditorName = new RequiredFieldValidator();

            editorName.TextBoxControl.ID = "RequiredFieldValidatorName";


            validatoreditorName.ControlToValidate = editorName.TextBoxControl.ID;


            validatoreditorName.ErrorMessage = "*";
            cellName.Controls.Add(validatoreditorName);


        }
    }
    protected void rgDocumentType_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rgDocumentType.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                    else if (column is GridButtonColumn)
                    {
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "" && column.HeaderText != "Delete")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }

                }
            }

            if (e.Item is GridPagerItem && flag)
            {
                RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                cb.Items.Sort(new PagerRadComboBoxItemComparer());
                if (tempPageSize != "")
                {
                    cb.Items.FindItemByValue(tempPageSize).Selected = true;
                }
            }

            //if (e.Item is GridPagerItem)
            //{
            //    GridPagerItem pagerItem = e.Item as GridPagerItem;
            //    RadComboBox combo = pagerItem.FindControl("PageSizeComboBox") as RadComboBox;
            //    combo.EnableScreenBoundaryDetection = false;
            //    combo.ExpandDirection = RadComboBoxExpandDirection.Up;
            //}
            if (e.Item is GridDataItem)
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                foreach (GridColumn column in rgDocumentType.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "AttributeName")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2].ToString());
                        }
                        else if (column.UniqueName == "URL")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[3].ToString());
                        else
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                            //http://www.w3schools.com">Visit W3Schools.com!</a> ";

                            //Guid phase_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_phase_id"].ToString());
                            ////string phase = "Architectural%20Programming";//e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["phase_name"].ToString();
                            ////this logic putted due to href string of anchor tag spase is indicated by %20 symbol
                            //string phase = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["phase_name"].ToString().Replace(" ", "%20");
                            //gridItem[column.UniqueName].Text = "<a href=SelectedPhase.aspx?pk_phase_id=" + phase_id + "&phase=" + phase + "&fk_organization_id=" + Request.QueryString["organization_id"].ToString() + ">" + Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString()) + "</a>";
                            //// Response.Redirect("SelectedPhase.aspx?pk_phase_id=" + phase_id + "&phase=" + phase + "&fk_organization_id=" + Request.QueryString["organization_id"].ToString(), false);
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
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "unitName")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[8].ToString());
                        }
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "StageName")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[12].ToString());
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
}