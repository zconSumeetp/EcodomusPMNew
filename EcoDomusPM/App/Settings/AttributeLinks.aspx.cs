using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attributes;
using EcoDomus.Session;
using Telerik.Web.UI;
using Login;
using System.Threading;
using System.Globalization;

public partial class App_Settings_AttributeLinks : System.Web.UI.Page
{
    Guid user_id;
    Guid organizationId;
    string tempPageSize = "";
    bool flag = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {

                if (Request.QueryString["organization_id"] != null)
                {
                    organizationId = new Guid(Request.QueryString["organization_id"].ToString());
                    hfOrganizationid.Value = organizationId.ToString();
                }

                addtbl.Style.Add("display", "none");
                btnSave.Visible = false;
                btnCancel.Visible = false;
                btnAddNew.Visible = true;
                btnupdate.Visible = false;

                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "Name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rgAttributeLink.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                hfDocumentPMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 1);
                tempPageSize = hfDocumentPMPageSize.Value;

                BindAttributeLink();
            }

        }
        else 
        {
           // Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
      
    }

    //protected override void InitializeCulture()
    //{
    //    try
    //    {
    //        string Culture_id = Request["ddlLanguage"];
    //        if (Culture_id == null)
    //        {
    //            Culture_id = Guid.Empty.ToString();
    //        }

    //        DataSet ds = new DataSet();
    //        LoginModel obj_mdl = new LoginModel();
    //        LoginClient obj_crtl = new LoginClient();
    //        obj_mdl.Language_id = new Guid(Culture_id);
    //        ds = obj_crtl.getCultureName(obj_mdl);
    //        string culture = ds.Tables[0].Rows[0]["culture"].ToString();

    //        Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
    //        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);

    //        Session["Culture"] = culture;
    //    }
    //    catch (Exception ex)
    //    {

    //        throw ex;
    //    }
    //}

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

    protected void BindAttributeLink()
    {

        try
        {
            
            DataSet ds = new DataSet();
            AttributeModel attributeModel = new AttributeModel();
            AttributeClient attributeClient = new AttributeClient();
            attributeModel.Fk_organizatoin_id = new Guid(hfOrganizationid.Value.ToString());
            ds = attributeClient.GetAttributeHyperlink(attributeModel, SessionController.ConnectionString);

            if (tempPageSize != "")
            rgAttributeLink.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgAttributeLink.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));


            if (ds.Tables[0].Rows.Count > 0)
            {
                rgAttributeLink.DataSource = ds;
                rgAttributeLink.DataBind();
            }
            else
            {
                rgAttributeLink.DataSource = ds;
                rgAttributeLink.DataBind();
            }
           
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void btnAddNew_OnClick(object sender, EventArgs e)
    {
        addtbl.Style.Remove("display");
        txtAttribute.Text = "";
        txtName.Text = "";
        txtURLLink.Text = "";
        btnSave.Visible = true;
        btnCancel.Visible = true;
        btnAddNew.Visible = false;
    }
    protected void InsertUpdateAttributeHyperlink()
    {
        try
        {
            DataSet ds = new DataSet();
            AttributeModel attributeModel = new AttributeModel();
            AttributeClient attributeClient = new AttributeClient();
          
            if (hfHyperlinkid.Value == "")
            {
                attributeModel.Attribute_id = Guid.Empty;
            }
            else
            {
                attributeModel.Attribute_id = new Guid(Convert.ToString(hfHyperlinkid.Value));
            }
            attributeModel.Name = txtName.Text;
            attributeModel.Attribute_name = txtAttribute.Text;
            attributeModel.URL_link = txtURLLink.Text;
            if (hfOrganizationid.Value != "")
            {
                attributeModel.Fk_organizatoin_id = new Guid(Convert.ToString(hfOrganizationid.Value));
            }
            else
            {
                attributeModel.Fk_organizatoin_id = Guid.Empty;
            }
            attributeModel.User_id = new Guid(SessionController.Users_.UserId);
            attributeClient.InsertUpdateAttributeHyperlink(attributeModel, SessionController.ConnectionString);
            BindAttributeLink();
            Response.Redirect("~/App/Settings/AttributeLinks.aspx?Organization_Id=" + hfOrganizationid.Value, true);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        InsertUpdateAttributeHyperlink();
    }
    protected void btnupdate_Click(object sender, EventArgs e)
    {
        InsertUpdateAttributeHyperlink();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/App/Settings/AttributeLinks.aspx?Organization_Id=" + hfOrganizationid.Value, true);
    }
    protected void rgAttributeLink_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "deletehyperlink")
        {
            Guid Attribute_hyperlink_id = Guid.Empty;
            Attribute_hyperlink_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["attribute_hyperlink_id"].ToString());
            DataSet ds = new DataSet();
            AttributeModel attributeModel = new AttributeModel();
            AttributeClient attributeClient = new AttributeClient();
            attributeModel.Attribute_id = Attribute_hyperlink_id;
            attributeClient.DeleteAttributeHyaperlink(attributeModel, SessionController.ConnectionString);
            BindAttributeLink();   

        }
        if (e.CommandName == "Update" || e.CommandName == "PerformInsert")
        {
            try
            {
                DataSet ds = new DataSet();
                AttributeModel attributeModel = new AttributeModel();
                AttributeClient attributeClient = new AttributeClient();
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
                                if (editableCol.Column.UniqueName == "Name")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                    attributeModel.Name = editorText.ToString();
                                }
                                if (editableCol.Column.UniqueName == "AttributeName")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                    attributeModel.Attribute_name = editorText.ToString();
                                }
                                if (editableCol.Column.UniqueName == "URL")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                    attributeModel.URL_link = editorText.ToString();
                                }
                            }
                        }
                    }
                }

                if (hfHyperlinkid.Value == "")
                {
                    attributeModel.Attribute_id = Guid.Empty;
                }
                else
                {
                    attributeModel.Attribute_id = new Guid(Convert.ToString(hfHyperlinkid.Value));
                }

               
                //attributeModel.Name = txtName.Text;
                //attributeModel.Attribute_name = txtAttribute.Text;
                //attributeModel.URL_link = txtURLLink.Text;
                if (hfOrganizationid.Value != "")
                {
                    attributeModel.Fk_organizatoin_id = new Guid(Convert.ToString(hfOrganizationid.Value));
                }
                else
                {
                    attributeModel.Fk_organizatoin_id = Guid.Empty;
                }

                if (e.CommandName != "PerformInsert")
                    attributeModel.Attribute_id = new Guid( e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["attribute_hyperlink_id"].ToString());
                else
                {
                    attributeModel.Attribute_id = Guid.Empty;
                    rgAttributeLink.MasterTableView.AllowAutomaticInserts = false;
                    // bindAttributes();
                }

                attributeModel.User_id = new Guid(SessionController.Users_.UserId);
                attributeClient.InsertUpdateAttributeHyperlink(attributeModel, SessionController.ConnectionString);
                BindAttributeLink();
                Response.Redirect("~/App/Settings/AttributeLinks.aspx?Organization_Id=" + hfOrganizationid.Value, true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        if (e.CommandName == "InitInsert")
        {
            BindAttributeLink();
            e.Item.OwnerTableView.EditFormSettings.CaptionFormatString = "Add Attribute:";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_gridHeight()", true);
        }
        if (e.CommandName == "Cancel")
        {
            BindAttributeLink();
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }
        if (e.CommandName == "Page")
        {
            BindAttributeLink();
        }


        if (e.CommandName == "Edit")
        {
            BindAttributeLink();
            //e.Item.OwnerTableView.EditFormSettings.CaptionFormatString = "Edit Attribute:";
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }

        else if(e.CommandArgument.ToString()=="edit")
        {
            /*
            addtbl.Style.Add("display", "inline");
            btnAddNew.Visible = false;
            btnSave.Visible = false;
            btnCancel.Visible = true;
            btnupdate.Visible = true;
            hfHyperlinkid.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["attribute_hyperlink_id"].ToString();
            txtName.Text = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Name"].ToString();
            txtAttribute.Text = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Attribute_Name"].ToString();
            txtURLLink.Text = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["URL_Link"].ToString();
            BindAttributeLink();
             */ 
        }
    }
    protected void rgAttributeLink_OnPageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        BindAttributeLink();
    }
    protected void rgAttributeLink_OnPageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindAttributeLink();
    }
    protected void rgAttributeLink_OnSortCommand(object sender, EventArgs e)
    {
        BindAttributeLink();
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

        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rgAttributeLink.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }
        }

        else
        {
            foreach (GridDataItem item in rgAttributeLink.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = true;
            }
        }


        if (edit_permission == "N")
        {
            foreach (GridDataItem item in rgAttributeLink.MasterTableView.Items)
            {
                LinkButton btn = (LinkButton)item.FindControl("btnEdit");
                btn.Enabled = false;
            }

            btnAddNew.Enabled = false;
        }
        else
        {
            foreach (GridDataItem item in rgAttributeLink.MasterTableView.Items)
            {
                LinkButton btn = (LinkButton)item.FindControl("btnEdit");
                btn.Enabled = true;
            }

            btnAddNew.Enabled = true;
        }
    }

    protected void rgAttributeLink_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {


            GridEditableItem item = e.Item as GridEditableItem;
            GridTextBoxColumnEditor editorName = (GridTextBoxColumnEditor)item.EditManager.GetColumnEditor("Name");
            GridTextBoxColumnEditor editorAttribute = (GridTextBoxColumnEditor)item.EditManager.GetColumnEditor("AttributeName");
            GridTextBoxColumnEditor editorUrl = (GridTextBoxColumnEditor)item.EditManager.GetColumnEditor("URL");
            TableCell cellName = (TableCell)editorName.TextBoxControl.Parent;
            TableCell cellAttr = (TableCell)editorAttribute.TextBoxControl.Parent;
            TableCell cellUrl = (TableCell)editorUrl.TextBoxControl.Parent;


            RequiredFieldValidator validatoreditorName = new RequiredFieldValidator();
            RequiredFieldValidator validatoreditorAttribute = new RequiredFieldValidator();
            RequiredFieldValidator validatoeditorUrl = new RequiredFieldValidator();
            editorName.TextBoxControl.ID = "RequiredFieldValidatorName";
            editorAttribute.TextBoxControl.ID = "RequiredFieldValidatorAttribute";
            editorUrl.TextBoxControl.ID = "RequiredFieldValidatorUrl";

            validatoreditorName.ControlToValidate = editorName.TextBoxControl.ID;
            validatoreditorAttribute.ControlToValidate = editorAttribute.TextBoxControl.ID;
            validatoeditorUrl.ControlToValidate = editorUrl.TextBoxControl.ID;

            validatoreditorName.ErrorMessage = "*";
            cellName.Controls.Add(validatoreditorName);
            validatoreditorAttribute.ErrorMessage = "*";
            cellAttr.Controls.Add(validatoreditorAttribute);
            validatoeditorUrl.ErrorMessage = "*";
            cellUrl.Controls.Add(validatoeditorUrl);

        }
    }
    protected void rgAttributeLink_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rgAttributeLink.MasterTableView.RenderColumns)
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
                foreach (GridColumn column in rgAttributeLink.MasterTableView.RenderColumns)
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
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
          //    rgAttributeLink.MasterTableView.Rebind();
        
        string filterExpression = "([Name] LIKE \'%" + txtSearchText.Text + "%\') "; //"(" + "=" + txtSearchText.Text + ")"; 

        if (txtSearchText.Text != "")
        {
            rgAttributeLink.AllowFilteringByColumn = true;
            rgAttributeLink.MasterTableView.FilterExpression = "([Name] LIKE \'%" + txtSearchText.Text + "%\') "; //string.Format("([Name]= '{0}')", txtSearchText.Text);//filterExpression;
            rgAttributeLink.MasterTableView.Rebind();
            rgAttributeLink.AllowFilteringByColumn = false;
            BindAttributeLink();
        }
     else
        BindAttributeLink();
       
    }

   
}