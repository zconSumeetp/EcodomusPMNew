using System;
using System.Collections.Generic;
using System.Linq; 
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Data.SqlClient;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;
using System.Collections;
  

public partial class App_Central_ProductAttribute : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flag = false;
    public ArrayList arrayList = new ArrayList();
    int TotalItemCount;

    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    ViewState["SelectedAttributeID"] = null;
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "attribute_name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    ViewState["PageSize"] = tempPageSize;
                    ViewState["PageIndex"] = 0;
                    ViewState["SortExpression"] = "attribute_name";
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    hfAttributePMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 2);
                    tempPageSize = hfAttributePMPageSize.Value;
                    rgProductAttributes.MasterTableView.SortExpressions.AddSortExpression(sortExpr);


                    BindProductName();
                    BindAttributes();
                    load_UOM_list();
                    load_group_list();
                    load_stage_list();

                    DataSet ds = new DataSet();

                    Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
                    Organization.OrganizationModel mdl = new Organization.OrganizationModel();

                    mdl.Organization_Id = new Guid(Request.QueryString["organization_id"]);
                    ds = obj_ctrl.GetOranizationInformation(mdl);
                    lblProductManufacturer.Text = ds.Tables[0].Rows[0]["OrganizationName"].ToString();
                    ViewState["PageSize"] = tempPageSize;
                    ViewState["PageIndex"] = 0;
                }
            }
            else
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }
        }
        catch (Exception ex)
        {
            //Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }

    #endregion



    #region Private Methods

    protected void BindAttributes()
    {
        try
        {

            int attributecount;
            Product.ProductClient ProductClient = new Product.ProductClient();
            Product.ProductModel ProductModel = new Product.ProductModel();
           // ProductModel.ProductId = new Guid(Request.QueryString["ProductId"].ToString());
            ProductModel.ProductId = new Guid(Request.QueryString["ProductId"]);
            ProductModel.Searchstring = txtSearch.Text.ToString();
            DataSet ds = ProductClient.GetProductAttributeById(ProductModel);

            if (ds.Tables[0].Rows.Count > 0)
            {
                attributecount = ds.Tables[0].Rows.Count;
                ViewState["attributecount"] = attributecount;
            }
            if (flag)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        rgProductAttributes.VirtualItemCount = ds.Tables[0].Rows.Count; // Int32.Parse(ds.Tables[0].Rows[0]["attributecount"].ToString());
                        ViewState["attributecount"] = ds.Tables[0].Rows.Count;
                    }
                }

                rgProductAttributes.AllowCustomPaging = true;
                rgProductAttributes.AllowPaging = true;

                if (tempPageSize != "")
                    rgProductAttributes.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
                flag = true;
            }
            
            rgProductAttributes.DataSource = ds;
            rgProductAttributes.DataBind();
            //if (flag)
            //{
            //    flag = false;
            //    rgProductAttributes.AllowCustomPaging = true;           
            //}
           


        }
        catch (Exception ex)
        {
            lblMsg.Text = "BindAttributes:-" + ex.Message.ToString();
        }
    }

    public void load_UOM_list()
    {
        cmb_uom.Items.Clear();
        
        Product.ProductClient ProductClient = new Product.ProductClient();

        DataSet ds = ProductClient.GetUnitOfMeasurement();
        cmb_uom.DataTextField = "unit_of_measurement";
        cmb_uom.DataValueField = "pk_unit_of_measurement_id";
        cmb_uom.DataSource = ds;
        cmb_uom.DataBind();
    }

    public void load_group_list()
    {
        cmbGroup_outer.Items.Clear();
        Product.ProductClient ProductClient = new Product.ProductClient();
        Product.ProductModel ProductModel = new Product.ProductModel();
        ProductModel.Entity_name = "Group";
        DataSet ds = ProductClient.GetStageandGroup(ProductModel);
        cmbGroup_outer.DataTextField = "standard_detail_name";
        cmbGroup_outer.DataValueField = "pk_standard_detail_id";
        cmbGroup_outer.DataSource = ds;
        cmbGroup_outer.DataBind();
    }

    public void load_stage_list()
    {
        cmbStage.Items.Clear();
        Product.ProductClient ProductClient = new Product.ProductClient();
        Product.ProductModel ProductModel = new Product.ProductModel();
        ProductModel.Entity_name = "Stage";
        DataSet ds = ProductClient.GetStageandGroup(ProductModel);
        cmbStage.DataTextField = "standard_detail_name";
        cmbStage.DataValueField = "pk_standard_detail_id";
        cmbStage.DataSource = ds;
        cmbStage.DataBind();
    }

    private void BindProductName()
    { 
    
             Product.ProductClient ProductClient = new Product.ProductClient();
            Product.ProductModel ProductModel = new Product.ProductModel();

            ProductModel.ProductId = new Guid(Request.QueryString["ProductId"].ToString());
            DataSet ds = ProductClient.Getproductsbyid(ProductModel);


            if (ds.Tables[0].Rows.Count > 0)
            {

                lblproduct.Text = ds.Tables[0].Rows[0]["model_number"].ToString();
                //lblproduct.Text = ds.Tables[0].Rows[0]["long_name"].ToString();
            }
    }

    #endregion



    #region Grid Events


    protected void rgProductAttributes_ItemDataBound(object source, GridItemEventArgs e)
    {
        //try
        //{
        //    ReSelectedRows();
        //    if (e.Item is GridPagerItem)
        //    {

        //        RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
        //        cb.Items.Sort(new PagerRadComboBoxItemComparer());
        //        if (tempPageSize != "")
        //        {
        //            cb.Items.FindItemByValue(tempPageSize).Selected = true;
        //        }


        //    }
        //if (e.Item is GridHeaderItem)
        //    {
        //        GridHeaderItem headerItem = e.Item as GridHeaderItem;

        //        foreach (GridColumn column in rgProductAttributes.MasterTableView.RenderColumns)
        //        {
        //            if (column is GridBoundColumn)
        //            {
        //                if (column.HeaderText != "")
        //                    (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

        //            }
        //            if (column is GridButtonColumn)
        //            {
        //                //if the sorting feature of the grid is enabled
        //                if (column.HeaderText != "")
        //                    (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

        //            }
        //            if (column is GridTemplateColumn)
        //            {
        //                //if the sorting feature of the grid is enabled
        //                if (column.HeaderText != "")
        //                    (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

        //            }
        //        }
        //    }

        //    if (e.Item is GridDataItem)
        //    {
        //        GridDataItem gridItem = e.Item as GridDataItem;
        //        foreach (GridColumn column in rgProductAttributes.MasterTableView.RenderColumns)
        //        {
        //            if (column is GridBoundColumn)
        //            {
        //                //this line will show a tooltip based type of Databound for grid data field
        //                if (column.OrderIndex > -1 && e.Item.DataItem != null)
        //                    gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
        //            }
        //            else if (column is GridButtonColumn)
        //            {
        //                //this line will show a tooltip based type of linkbutton for grid data field
        //                if (column.OrderIndex > -1 && e.Item.DataItem != null && column.OrderIndex != 3)
        //                    gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());

        //            }
        //            else if (column is GridTemplateColumn)
        //            {
        //                if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName != "attribute_name")
        //                    gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
        //                else
        //                {
        //                    GridDataItem item = (GridDataItem)e.Item;
        //                    //LinkButton lbl = (LinkButton)item.FindControl("lnkbtnName");
        //                    //string value = lbl.Text;
        //                    //gridItem[column.UniqueName].ToolTip = value;// Convert.ToString((Label)gridItem.FindControl("lblDocName"));
        //                }
        //            }
        //        }
        //    }
        //}
        //catch (Exception ex)
        //{
        //    throw ex;
        //}


        if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
        {
            RadComboBox cmbUnit = e.Item.FindControl("cmb_unit") as RadComboBox;
            RadComboBox cmbstage = e.Item.FindControl("cmb_stage") as RadComboBox;
            RadComboBox cmbgroup = e.Item.FindControl("cmb_group") as RadComboBox;


            Product.ProductClient ProductClient = new Product.ProductClient();
            Product.ProductModel ProductModel = new Product.ProductModel();

            DataSet ds = ProductClient.GetUnitOfMeasurement();
            cmbUnit.DataTextField = "unit_of_measurement";
            cmbUnit.DataValueField = "pk_unit_of_measurement_id";
            cmbUnit.DataSource = ds;
            cmbUnit.DataBind();



            ProductModel.Attribute_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_product_attribute_id"].ToString());
            ds = ProductClient.GetProductAttributeByName(ProductModel);
            cmbUnit.SelectedValue = ds.Tables[0].Rows[0]["fk_unit_of_measurement_id"].ToString();



            ProductClient = new Product.ProductClient();
            ProductModel = new Product.ProductModel();
            ProductModel.Entity_name = "Stage";
            ds = new DataSet();
            ds = ProductClient.GetStageandGroup(ProductModel);
            cmbstage.DataTextField = "standard_detail_name";
            cmbstage.DataValueField = "pk_standard_detail_id";
            cmbstage.DataSource = ds;
            cmbstage.DataBind();
            ProductModel.Attribute_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_product_attribute_id"].ToString());
            ds = ProductClient.GetProductAttributeByName(ProductModel);
            cmbstage.SelectedValue = ds.Tables[0].Rows[0]["fk_stage_id"].ToString();



            ProductClient = new Product.ProductClient();
            ProductModel = new Product.ProductModel();
            ProductModel.Entity_name = "Group";
            ds = new DataSet();
            ds = ProductClient.GetStageandGroup(ProductModel);
            cmbgroup.DataTextField = "standard_detail_name";
            cmbgroup.DataValueField = "pk_standard_detail_id";
            cmbgroup.DataSource = ds;
            cmbgroup.DataBind();
            ProductModel.Attribute_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_product_attribute_id"].ToString());
            ds = ProductClient.GetProductAttributeByName(ProductModel);
            cmbgroup.SelectedValue = ds.Tables[0].Rows[0]["fk_group_id"].ToString();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }
    }

    protected void rgProductAttributes_ItemCommand(object source, GridCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == "Update")
            {

                GridEditableItem editedItem = e.Item as GridEditableItem;
                GridEditManager editMan = editedItem.EditManager;
                DataSet Ds_ClientDomain = new DataSet();

                //ProductsControl prodC = new ProductsControl(SystemConstants.getConnectionFile());
                //ProductsModel prodM = new ProductsModel();

                Product.ProductClient ProductClient = new Product.ProductClient();
                Product.ProductModel ProductModel = new Product.ProductModel();


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
                                if (editableCol.Column.HeaderText == "Attribute Name")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                    ProductModel.Attribute_name = editorText.ToString();
                                }
                                else if (editableCol.Column.HeaderText == "Value")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                    ProductModel.Attribute_value = editorText.ToString();
                                }
                                //else if (editableCol.Column.HeaderText == "Unit")
                                //{
                                //    editorText = (editor as GridTextColumnEditor).Text;
                                //    ProductModel.un = editorText.ToString();
                                //}

                                else if (editableCol.Column.HeaderText == "Description")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                   ProductModel.Description = editorText.ToString();
                                }

                            }

                            else if (editor is GridTemplateColumnEditor)
                            {
                                if (editableCol.Column.HeaderText == "Unit")
                                {
                                    string Units = Convert.ToString((editor.ContainerControl.FindControl("cmb_unit") as RadComboBox).SelectedItem.Text.ToString());
                                    if (Units.Equals("---select UM----"))
                                    {
                                        ProductModel.Unit_of_measurement_id = Guid.Empty;
                                    }

                                    else
                                    {
                                        ProductModel.Unit_of_measurement_id = new Guid((editor.ContainerControl.FindControl("cmb_unit") as RadComboBox).SelectedItem.Value.ToString());
                                    }
                                }

                                if (editableCol.Column.HeaderText == "Stage")
                                {
                                    string AttributeStage = Convert.ToString((editor.ContainerControl.FindControl("cmb_stage") as RadComboBox).SelectedItem.Text.ToString());
                                    if (AttributeStage.Equals("---select----"))
                                    {
                                        ProductModel.Stage_id= Guid.Empty;
                                    }

                                    else
                                    {
                                        ProductModel.Stage_id = new Guid((editor.ContainerControl.FindControl("cmb_stage") as RadComboBox).SelectedItem.Value.ToString());
                                    }
                                }


                                if (editableCol.Column.HeaderText == "Group")
                                {
                                    string AttributeGroup = Convert.ToString((editor.ContainerControl.FindControl("cmb_group") as RadComboBox).SelectedItem.Text.ToString());
                                    if (AttributeGroup.Equals("---select----"))
                                    {
                                        ProductModel.Group_id = Guid.Empty;
                                    }

                                    else
                                    {
                                        ProductModel.Group_id = new Guid((editor.ContainerControl.FindControl("cmb_group") as RadComboBox).SelectedItem.Value.ToString());
                                    }
                                }
                            }

                        }


                    }



                }

                if (ProductModel.Attribute_name != "" && ProductModel.Attribute_value != "")
                {
                    ProductModel.Attribute_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_product_attribute_id"].ToString());

                    ProductClient.UpdateProductAttribute(ProductModel);
                    //if (prodM.existsflag.Equals("Y"))
                    //{
                    //    //lblMsg.Text = "Attribute name already exists!";
                    //}
                }


            }

            if (e.CommandName == "Edit")
            {
                Label lblCategory_id = e.Item.FindControl("lblCategoryId") as Label;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);


            }



            if (e.CommandName == "deleteAttribute")
            {
                Product.ProductClient ProductClient = new Product.ProductClient();
                Product.ProductModel ProductModel = new Product.ProductModel();
                GridEditableItem editedItem = e.Item as GridEditableItem;
                GridEditManager editMan = editedItem.EditManager;
                ProductModel.Attribute_id = new Guid(editedItem["pk_product_attribute_id"].Text);
                ProductClient.DeleteProductAttribute(ProductModel);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
            }

            BindAttributes();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }
        catch (Exception ex)
        {
            lblMsg.Text = "rgProductAttributes_ItemCommand:-" + ex.Message.ToString();
        }
    }

    protected void rgProductAttributes_onSortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {

           
                GridSortExpression sortExpr = new GridSortExpression();
                switch (e.OldSortOrder)
                {
                    case GridSortOrder.None:
                        sortExpr.FieldName = e.SortExpression;
                        sortExpr.SortOrder = GridSortOrder.Descending;

                        e.Item.OwnerTableView.SortExpressions.AddSortExpression(sortExpr);
                        break;
                    case GridSortOrder.Ascending:
                        sortExpr.FieldName = e.SortExpression;
                        sortExpr.SortOrder = rgProductAttributes.MasterTableView.AllowNaturalSort ? GridSortOrder.None : GridSortOrder.Descending;
                        e.Item.OwnerTableView.SortExpressions.AddSortExpression(sortExpr);
                        break;
                    case GridSortOrder.Descending:
                        sortExpr.FieldName = e.SortExpression;
                        sortExpr.SortOrder = GridSortOrder.Ascending;

                        e.Item.OwnerTableView.SortExpressions.AddSortExpression(sortExpr);
                        break;
                }

                e.Canceled = true;
                BindAttributes();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
            }
        
        catch (Exception ex)
        {
            lblMsg.Text = "rgProductAttributes_onSortCommand:-" + ex.Message.ToString();
        }
    }

    protected void rgProductAttributes_OnPageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {

        //try
        //{
        //    GetSelectedRows();
        //    ViewState["PageIndex"] = e.NewPageIndex;
        //    flag = false;
        //}
        try
        {
            
            flag = false;
            BindAttributes();
            ViewState["PageIndex"] = e.NewPageIndex;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }
        catch (Exception ex)
        {
            lblMsg.Text = "rgProductAttributes_OnPageIndexChanged:-" + ex.Message.ToString();
        }
    }

    protected void rgProductAttributes_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {


        //try
        //{
        //   // rgProductAttributes.AllowCustomPaging = true;
        //    tempPageSize = e.NewPageSize.ToString();
        //    flag = true;
        //    BindAttributes();
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        //}

       
             try
        {
            tempPageSize = e.NewPageSize.ToString();
            if (!flag)
            {
                flag = true;

                GetSelectedRows();
                ViewState["PageSize"] = e.NewPageSize;
                int compo_count = Int32.Parse(ViewState["attributecount"].ToString());
                int page_size = Int32.Parse(ViewState["PageSize"].ToString());
                int page_index = Int32.Parse(ViewState["PageIndex"].ToString());
                int maxpg_index = (compo_count / page_size) + 1;
                if (page_index >= maxpg_index)
                {
                    ViewState["PageIndex"] = 0;
                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "rgProductAttributes_OnPageSizeChanged:-" + ex.Message.ToString();
        }
    }
  


    #endregion



    #region Event Handlers


    //protected void btnAddAttribute_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        trbtnAddAttribute.Style.Add("display", "none");
    //        trAddAttribute.Style.Add("display", "inline");
    //        txtName.Text = "";
    //        txtValue.Text = "";
    //        txtDescription.Text = "";
    //        lblmessage.Text = "";

    //        cmb_uom.SelectedIndex = 0;
    //        cmbStage.SelectedIndex = 0;
    //        cmbGroup_outer.SelectedIndex = 0;

    //    }
    //    catch (Exception ex)
    //    {
    //        lblMsg.Text = "btnAddAttribute_Click:-" + ex.Message.ToString();
    //    }
    //}

    protected void btnCancelSave_Click(object sender, EventArgs e)
    {
        try
        {
            trbtnAddAttribute.Style.Add("display", "inline");
            trAddAttribute.Style.Add("display", "none");
        }
        catch (Exception ex)
        {
            lblMsg.Text = "btnCancelSave_Click:-" + ex.Message.ToString();
        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            Product.ProductClient ProductClient = new Product.ProductClient();
            Product.ProductModel ProductModel = new Product.ProductModel();

            ProductModel.ProductId = new Guid(Request.QueryString["ProductId"]);
            //ProductModel.ProductId = new Guid(Request.QueryString["ProductId"].ToString());


        
            ProductModel.Attribute_name = txtName.Text.ToString();
            ProductModel.Attribute_value = txtValue.Text.ToString();
            if (cmb_uom.SelectedItem.Text.ToString().Equals("---select UM----"))
            {
                ProductModel.Unit_of_measurement_id = Guid.Empty;
            }
            else
            {
                ProductModel.Unit_of_measurement_id = new Guid(cmb_uom.SelectedItem.Value.ToString());
            }

            if (cmbGroup_outer.SelectedItem.Text.ToString().Equals("---select----"))
            {
                ProductModel.Group_id= Guid.Empty;
            }
            else
            {
                ProductModel.Group_id = new Guid(cmbGroup_outer.SelectedItem.Value.ToString());
            }

            if (cmbStage.SelectedItem.Text.ToString().Equals("---select----"))
            {
                ProductModel.Stage_id = Guid.Empty;
            }
            else
            {
                ProductModel.Stage_id = new Guid(cmbStage.SelectedItem.Value.ToString());
            }

            ProductModel.Description = txtDescription.Text.ToString();

            ProductModel.Existingflag=ProductClient.InsertProductAttribute(ProductModel);

            if (ProductModel.Existingflag.Equals("Y"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
               // lblmessage.Text = "Attribute already exists!";
            }
            if (ProductModel.Existingflag.Equals("N"))
            {
                BindAttributes();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
                trAddAttribute.Style.Add("display", "none");
                trbtnAddAttribute.Style.Add("display", "inline");

            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "btnSave_Click:-" + ex.Message.ToString();
        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            BindAttributes();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        }
        catch (Exception ex)
        {
            lblMsg.Text = "btnSearch_Click:-" + ex.Message.ToString();
        }
    }

    #endregion




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
        catch(Exception)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
     }
    protected void GetSelectedRows()
    {
        try
        {
            SessionToArrayList();


            foreach (GridDataItem item in rgProductAttributes.Items)
            {
                string strIndex = rgProductAttributes.MasterTableView.CurrentPageIndex.ToString();
                // string comp_id = item.GetDataKeyValue("Assetid").ToString();
                string comp_id = item["pk_product_attribute_id"].Text;

                if (item.Selected)
                {
                    if (!arrayList.Contains(comp_id.ToString()))
                    {
                        arrayList.Add(comp_id.ToString());
                    }
                }
                else
                {
                    if (arrayList.Contains(comp_id.ToString()))
                    {
                        arrayList.Remove(comp_id.ToString());
                    }
                }
            }

            ViewState["SelectedAttributeID"] = arrayList;
            ArrayList comp_list = (ArrayList)ViewState["SelectedAttributeID"];
            string id = "";
            if (comp_list.Count > 0)
            {
                for (int i = 0; i < comp_list.Count; i++)
                {
                    id = id + comp_list[i].ToString() + ",";

                }
                id = id.Substring(0, id.Length - 1);
                 hf_attribute_id.Value = id;

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
            if (ViewState["SelectedsystemID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedsystemID"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rgSystems_OnItemEvent(object sender, GridItemEventArgs e)
    {

        if (e.EventInfo is GridInitializePagerItem)
        {

            TotalItemCount = (e.EventInfo as GridInitializePagerItem).PagingManager.DataSourceCount;

        }
        hf_count.Value = TotalItemCount.ToString();

    }
    protected void ReSelectedRows()
    {
        try
        {
            foreach (GridDataItem item in rgProductAttributes.Items)
            {
                string attribute_id = Convert.ToString(item.GetDataKeyValue("pk_product_attribute_id"));//item["Assetid"].Text;

                if (arrayList.Contains(attribute_id.ToString()))
                {
                    item.Selected = true;

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }


}