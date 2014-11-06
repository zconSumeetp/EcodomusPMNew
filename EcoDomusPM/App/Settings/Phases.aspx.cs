using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using Organization;
using System.Data;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;
public partial class App_Settings_Phases : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flag = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    organization_id.Value = Request.QueryString["organization_id"].ToString();
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "phase_name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rg_phases_grid.MasterTableView.SortExpressions.AddSortExpression(sortExpr);


                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    hfDocumentPMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize));
                    tempPageSize = hfDocumentPMPageSize.Value;

                    Bind_Phase_Grid();

                }

            }
            else

            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }

        }
        catch (Exception ex)
        {

            throw ex;
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
    private void Bind_Phase_Grid()
    {
        OrganizationClient obj_org_client = new OrganizationClient();
        OrganizationModel obj_org_model = new OrganizationModel();
        DataSet ds = new DataSet();
        try
        {
            if (!organization_id.Value.Equals(""))
            {
                obj_org_model.Organization_Id = new Guid(organization_id.Value.ToString());
            }
            else
            {
                obj_org_model.Organization_Id = new Guid(Request.QueryString["organization_id"].ToString());
            }
            //obj_org_model.Organization_Id = new Guid(organization_id.Value);
            ds = obj_org_client.GetOrganizationPhases(obj_org_model);
            rg_phases_grid.AllowCustomPaging = true;
            if (tempPageSize != "")
                rg_phases_grid.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
                rg_phases_grid.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
                rg_phases_grid.DataSource = ds;
                rg_phases_grid.DataBind();
            
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        OrganizationClient obj_org_client = new OrganizationClient();
        OrganizationModel obj_org_model = new OrganizationModel();
        DataSet ds = new DataSet();
        try
        {

            obj_org_model.Phase_id = Guid.Empty;
            obj_org_model.Phase_name = txtPhaseName.Text.Trim().ToString();
            obj_org_model.Phase_description = txtPhaseName.Text.Trim().ToString();
            if (!organization_id.Value.Equals(""))
                obj_org_model.Organization_Id = new Guid(organization_id.Value.ToString());
            else
                obj_org_model.Organization_Id = new Guid(Request.QueryString["organization_id"].ToString());
            obj_org_model.Created_by = new Guid(SessionController.Users_.UserId.ToString());
            ds = obj_org_client.InsertOrganizationPhase(obj_org_model);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["phase_id"].ToString().Equals(Guid.Empty.ToString()))
                {
                    string nw1 = "<script language='javascript'>alert('Phase name already exists..');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script", nw1);
                }
            }
            Bind_Phase_Grid();

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_phases_grid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        OrganizationClient obj_org_client = new OrganizationClient();
        OrganizationModel obj_org_model = new OrganizationModel();
        if (SessionController.Users_.ProjectId != null)
        {
            string strprojectid = Convert.ToString(SessionController.Users_.ProjectId);
        }
        
       // string phase = ((System.Web.UI.WebControls.ImageButton)(e.CommandSource)).Text;
       try
        {
            if (e.CommandName == "Update" || e.CommandName == "PerformInsert")
            {
                DataSet ds = new DataSet();
                try
                {

                    obj_org_model.Phase_id = Guid.Empty;
                    //obj_org_model.Phase_name =  //txtPhaseName.Text.Trim().ToString();
                    obj_org_model.Phase_description = txtPhaseName.Text.Trim().ToString();

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
                                    if (editableCol.Column.UniqueName == "phase_name")
                                    {
                                        editorText = (editor as GridTextColumnEditor).Text;
                                        obj_org_model.Phase_name = editorText.ToString();
                                    }
                                   /*
                                    if (editableCol.Column.UniqueName == "AttributeName")
                                    {
                                        editorText = (editor as GridTextColumnEditor).Text;
                                        obj_org_model.Attribute_name = editorText.ToString();
                                    }
                                    if (editableCol.Column.UniqueName == "URL")
                                    {
                                        editorText = (editor as GridTextColumnEditor).Text;
                                        obj_org_model.URL_link = editorText.ToString();
                                    }
                                    */ 
                                }
                            }
                        }
                    }



                    if (!organization_id.Value.Equals(""))
                        obj_org_model.Organization_Id = new Guid(organization_id.Value.ToString());
                    else
                        obj_org_model.Organization_Id = new Guid(Request.QueryString["organization_id"].ToString());
                        obj_org_model.Created_by = new Guid(SessionController.Users_.UserId.ToString());
                    ds = obj_org_client.InsertOrganizationPhase(obj_org_model);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (ds.Tables[0].Rows[0]["phase_id"].ToString().Equals(Guid.Empty.ToString()))
                        {
                            string nw1 = "<script language='javascript'>alert('Phase name already exists..');</script>";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "script", nw1);
                        }
                    }
                    Bind_Phase_Grid();

                }
                catch (Exception ex)
                {

                    throw ex;
                }
            }

            if (e.CommandName == "deletephases")
            {
                Guid phase_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_phase_id"].ToString());
                string phase = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["phase_name"].ToString();
                obj_org_model.Phase_id = phase_id;
                obj_org_client.DeleteOrganizationPhases(obj_org_model);
                Bind_Phase_Grid();
            }
            else if (e.CommandName == "phasename")
            {
                Guid phase_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_phase_id"].ToString());
                string phase = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["phase_name"].ToString();
                Response.Redirect("SelectedPhase.aspx?pk_phase_id=" + phase_id + "&phase=" + phase + "&fk_organization_id=" + Request.QueryString["organization_id"].ToString(), false);
            
            }
            if (e.CommandName == "InitInsert")
            {
                Bind_Phase_Grid();
                e.Item.OwnerTableView.EditFormSettings.CaptionFormatString = "Add Attribute:";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_gridHeight()", true);
            }
            if (e.CommandName == "Cancel")
            {
                Bind_Phase_Grid();
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
            }
            if (e.CommandName == "Page")
            {
                Bind_Phase_Grid();
            }


            if (e.CommandName == "Edit")
            {
                Bind_Phase_Grid();
                //e.Item.OwnerTableView.EditFormSettings.CaptionFormatString = "Edit Attribute:";
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_phases_grid_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {
            Bind_Phase_Grid();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_phases_grid_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            Bind_Phase_Grid();
            
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_phases_grid_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            Bind_Phase_Grid();
        }
        catch (Exception ex)
        {

            throw;
        }
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {

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
                if (dr_profile["name"].ToString() == "Organization")
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
            btnadd.Enabled = false;
        }
        else
        {
            btnadd.Enabled = true;
        }

        //delete permission
        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rg_phases_grid.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }
        }

        else
        {
            foreach (GridDataItem item in rg_phases_grid.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = true;
            }
        }




    }
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void rg_phases_grid_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {


            GridEditableItem item = e.Item as GridEditableItem;
            GridTextBoxColumnEditor editorName = (GridTextBoxColumnEditor)item.EditManager.GetColumnEditor("phase_name");
            
            TableCell cellName = (TableCell)editorName.TextBoxControl.Parent;
         


            RequiredFieldValidator validatoreditorName = new RequiredFieldValidator();
         
            editorName.TextBoxControl.ID = "RequiredFieldValidatorName";
          

            validatoreditorName.ControlToValidate = editorName.TextBoxControl.ID;
          

            validatoreditorName.ErrorMessage = "*";
            cellName.Controls.Add(validatoreditorName);
         

        }
    }
    protected void rg_phases_grid_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rg_phases_grid.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "")
                         (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;
                    //   ((LinkButton)headerItem[column.UniqueName].Controls[0]).Font.Underline = false;
                      //  ((LinkButton)header["TemplateColumnUniqueName"].Controls[0]).Font.Underline = true; 
                       

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
                foreach (GridColumn column in rg_phases_grid.MasterTableView.RenderColumns)
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

                            Guid phase_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_phase_id"].ToString());
                            //string phase = "Architectural%20Programming";//e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["phase_name"].ToString();
                            //this logic putted due to href string of anchor tag spase is indicated by %20 symbol
                            string phase = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["phase_name"].ToString().Replace(" ", "%20");
                            gridItem[column.UniqueName].Text = "<a href=SelectedPhase.aspx?pk_phase_id=" + phase_id + "&phase=" + phase + "&fk_organization_id=" + Request.QueryString["organization_id"].ToString() + ">"+ Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString())+ "</a>" ;
                        
                           // Response.Redirect("SelectedPhase.aspx?pk_phase_id=" + phase_id + "&phase=" + phase + "&fk_organization_id=" + Request.QueryString["organization_id"].ToString(), false);
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