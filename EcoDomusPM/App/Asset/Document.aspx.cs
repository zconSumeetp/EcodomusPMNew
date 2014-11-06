using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using Facility;
using System.Data;
using System.Globalization;
using System.Threading;
using System.Collections;

public partial class App_Asset_Document : System.Web.UI.Page
{
    public ArrayList arrayList = new ArrayList();
    string tempPageSize = "";
    bool flag = false;
    #region Page events
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtcriteria.Attributes.Add("onKeyPress", "doClick('" + btnSearch.ClientID + "',event)");

            if (SessionController.Users_.UserId != null)
            {

                if (!IsPostBack)
                {
                    if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                    {

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                    }
                    else
                    {


                        BindFacilities();
                        GridSortExpression sortExpr = new GridSortExpression();
                        sortExpr.FieldName = "document_name";
                        sortExpr.SortOrder = GridSortOrder.Ascending;
                        //Add sort expression, which will sort against first column
                        rgdocument.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                        hfDocumentPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                        tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                        BindDocuments();
                    }
                }
            }
            else
            {
                Response.Redirect("~/App/LoginPM.aspx");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Private methods

    public void BindFacilities()
    {
        try
        {
            DataSet ds_facility = new DataSet();
            FacilityClient locObj_crtl = new FacilityClient();
            FacilityModel locObj_mdl = new FacilityModel();
            locObj_mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
            locObj_mdl.Search_text_name = "";
            locObj_mdl.Doc_flag = "floor";
            ds_facility = locObj_crtl.GetFacilitiesPM(locObj_mdl, SessionController.ConnectionString);
            if (ds_facility.Tables[0].Rows.Count > 0)
            {
                cmbfacility.DataTextField = "name";
                cmbfacility.DataValueField = "pk_facility_id";
                cmbfacility.DataSource = ds_facility;
                cmbfacility.DataBind();
                string name = ds_facility.Tables[0].Rows[0]["name"].ToString();
                cmbfacility.Text = name;
            }

            //rcb_map_facility.DataTextField = "name";
            //rcb_map_facility.DataValueField = "pk_facility_id";
            //rcb_map_facility.DataSource = ds_facility;
            //rcb_map_facility.DataBind();
            //rcb_map_facility.Items.Insert(0, new RadComboBoxItem("--Select--", ""));

            cmbfacility.Visible = true;
            lblfacility.Visible = true;
            cmbfacility.Enabled = true;


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void BindDocuments()
    {
        DataSet ds = GetDocuments();
        // rgdocument.DataSource = GetDocuments();
        rgdocument.AllowCustomPaging = true;
        // rgdocument.AllowPaging = true;
        if (tempPageSize != "")
            rgdocument.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
        rgdocument.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
        if (ds.Tables.Count > 0)
        {
            rgdocument.DataSource = ds;
            rgdocument.DataBind();
            rgdocument.Visible = true;
        }
        //rgdocument.AllowCustomPaging = false;
    }

    private DataSet GetDocuments()
    {
        DataSet ds = new DataSet();
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        try
        {
            //  fm.Facility_Ids = cmbfacility.SelectedValue;//"546E3DB3-8697-4229-84F5-CBCCBD13C1F9";
            fm.Project_id = new Guid(SessionController.Users_.ProjectId);
            fm.Search_text_name = txtcriteria.Text;
            fm.Show_unassigned_flag = chkShowUnassignedFlag.Checked;

            System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
            foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
            {
                if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
                {
                    facilityvalues.Append(rcbItem.Value);
                    facilityvalues.Append(",");
                }
            }
            if (facilityvalues.Length > 0)
            {
                facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
            }

            fm.Facility_Ids = facilityvalues.ToString();

            ds = fc.GetDocuments_PM(fm, SessionController.ConnectionString);
            return ds;
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

    #endregion

    #region EventHandlers

    protected void rgdocument_OnItemCreated(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rgdocument.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                    if (column is GridButtonColumn)
                    {
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "")
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

            if (e.Item is GridDataItem)
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                foreach (GridColumn column in rgdocument.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null)
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                    }
                    else if (column is GridButtonColumn)
                    {
                        //this line will show a tooltip based type of linkbutton for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.OrderIndex != 3)
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());

                    }
                    else if (column is GridTemplateColumn)
                    {
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName != "File")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                        else
                        {
                            GridDataItem item = (GridDataItem)e.Item;
                            Label lbl = (Label)item.FindControl("lblDocName");
                            string value = lbl.Text;
                            gridItem[column.UniqueName].ToolTip = value;// Convert.ToString((Label)gridItem.FindControl("lblDocName"));
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
    protected void cmbfacility_itemdatabound(object sender, Telerik.Web.UI.RadComboBoxItemEventArgs e)
    {
        try
        {
            ((CheckBox)e.Item.FindControl("checkbox1")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        GetSelectedRows();
        btnMapDocuments.Visible = chkShowUnassignedFlag.Checked;
        //rcb_map_facility.Visible = chkShowUnassignedFlag.Checked;
        //lblFac.Visible = chkShowUnassignedFlag.Checked;
        BindDocuments();
        rgdocument.AllowPaging = true;
    }

    protected void rgdocument_OnPageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        BindDocuments();
        flag = false;
    }

    protected void rgdocument_OnPageIndexChanged(object source, GridPageSizeChangedEventArgs e)
    {
        tempPageSize = e.NewPageSize.ToString();
        if (!flag)
        {
            flag = true;
            BindDocuments();

        }
    }


    protected void rgdocument_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            string fk_row_id = string.Empty;
            Guid document_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_document_id"].ToString());
            string documentname = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["document_name"].ToString();
            //Guid fk_row_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["fk_row_id"].ToString());
            fk_row_id = Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["fk_row_id"]);
            string entity_name = Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["entity_name"]);
            //string rowname = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["  "].ToString();
            hf_row_ids.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["row_ids"].ToString();
            //Server.Transfer("~/App/Asset/DocumentProfile.aspx?DocumentId=" + document_id + "&fk_row_id=" + fk_row_id + "&entity_name=" + entity_name, true);
            //Response.Redirect("~/App/Asset/DocumentProfile.aspx?DocumentId=" + document_id + "&fk_row_id=" + hf_row_ids.Value + "&entity_name=" + entity_name, false);
            Response.Redirect("~/App/Asset/DocumentMenu.aspx?DocumentId=" + document_id + "&fk_row_id=" + hf_row_ids.Value + "&entity_name=" + entity_name, false);
        }

    }

    protected void btnaddDocument_Click(object sender, EventArgs e)
    {
        //string documentid;        
        //documentid = Guid.Empty.ToString();
        //  Response.Redirect("~/App/Asset/UploadDocumentWizard.aspx?DocumentId=" + documentid, false);
        Response.Redirect("~/App/Asset/UploadDocumentWizard.aspx", false);

    }

    protected void btnMapDocuments_click(object sender, EventArgs e)
    {
        try
        {
            GetSelectedRows();

            List<string> UploadedDocumentIds = new List<string>();

            DataSet ds = GetDocuments();
            string Facility_ID = "";
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                string document_id = row["pk_document_id"].ToString();
                if (arrayList.Contains(document_id))
                {
                    Facility_ID = Convert.ToString(row["fk_facility_id"]);
                    UploadedDocumentIds.Add(row["pk_document_id"].ToString());
                }
            }

            if (UploadedDocumentIds.Count > 0)  // check weather user checked any text box or not 
            {
                SessionController.Users_.BulkUploadDocumentIds = String.Join(",", UploadedDocumentIds.ToArray());
                Session["facilityid"] = Facility_ID;
                Response.Redirect("~/App/Asset/MapDocuments.aspx", false);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnDelete_click(object sender, EventArgs e)
    {
        {
            try
            {
                GetSelectedRows();

                if (arrayList.Count > 0)  // check weather user checked any text box or not 
                {
                    System.Text.StringBuilder strRowIds = new System.Text.StringBuilder();
                    System.Text.StringBuilder strDocumentNames = new System.Text.StringBuilder();

                    DataSet ds = GetDocuments();

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        string document_id = row["pk_document_id"].ToString();

                        if (arrayList.Contains(document_id))
                        {
                            string row_id = row["row_ids"].ToString().Equals("") ? row["fk_row_id"].ToString() : row["row_ids"].ToString();
                            strRowIds.Append(row_id);
                            strRowIds.Append(",");
                            strDocumentNames.Append(row["document_name"].ToString());
                            strDocumentNames.Append(",");
                        }
                    }

                    FacilityClient objfacctrl = new FacilityClient();
                    FacilityModel objfacmdl = new FacilityModel();

                    objfacmdl.Document_Name = strDocumentNames.ToString();
                    objfacmdl.Document_Name.Trim();
                    objfacmdl.Document_Name.Trim(',');
                    objfacmdl.Fk_row_ids = strRowIds.ToString() == string.Empty ? Guid.Empty.ToString() : strRowIds.ToString();
                    objfacmdl.Fk_row_ids.Trim();
                    objfacmdl.Fk_row_ids.Trim(',');
                    objfacctrl.delete_document_pm(objfacmdl, SessionController.ConnectionString);
                    BindDocuments();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    protected void navigate(object sender, EventArgs e)
    {
        BindDocuments();
    }

    #endregion

    //protected void cmbfacility_selectedindexchanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    //{
    //    BindDocuments();
    //}

    protected void rgdocument_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridDataItem)
            {

                HyperLink hyper_path = e.Item.FindControl("hlnkDocName") as HyperLink;
                Label lblDoc = e.Item.FindControl("lblDocName") as Label;

                Label lblEntityNames = e.Item.FindControl("lblEntityNames") as Label;


                GridDataItem item = (GridDataItem)e.Item;
                string document_id = item.GetDataKeyValue("pk_document_id").ToString();
                if (arrayList.Contains(document_id))
                {
                    item.Selected = true;
                }

                string EntityNames = ((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[8].ToString();
                if (EntityNames.Length > 25)
                {
                    lblEntityNames.Text = EntityNames.Substring(0, 25) + " ...";
                }
                else
                {
                    lblEntityNames.Text = EntityNames;
                }

                if (((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2] != "")
                {
                    hyper_path.Visible = true;
                    lblDoc.Visible = false;
                    if (hyper_path.NavigateUrl.ToString() != "")
                    {
                        hyper_path.NavigateUrl = ((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2].ToString();
                    }
                }
                else
                {
                    hyper_path.Visible = false;
                    lblDoc.Visible = true;
                    try
                    {
                        lblDoc.Text = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[10].ToString());
                    }
                    catch (Exception exce)
                    {
                        throw exce;
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
            if (e.Item is GridDataItem)
            {
                 GridDataItem gridItem = e.Item as GridDataItem;
                 foreach (GridColumn column in rgdocument.MasterTableView.RenderColumns)
                 {
                     if (e.Item is GridDataItem && column.UniqueName == "File")
                     {
                         GridDataItem item = (GridDataItem)e.Item;
                         Label lbl = (Label)item.FindControl("lblDocName");
                         string value = lbl.Text;
                         gridItem[column.UniqueName].ToolTip = value;// Convert.ToString((Label)gridItem.FindControl("lblDocName"));
                     }
                 }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                btnDelete.Visible = false;
                btnaddDocument.Visible = false;

            }
            //BindDocuments();
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

    protected void GetSelectedRows()
    {
        try
        {
            if (ViewState["SelectedDocuments"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedDocuments"];
            }

            foreach (GridDataItem item in rgdocument.Items)
            {
                string strIndex = rgdocument.MasterTableView.CurrentPageIndex.ToString();
                string pk_document_id = item["pk_document_id"].Text;
                if (item.Selected)
                {
                    if (!arrayList.Contains(pk_document_id.ToString()))
                    {
                        arrayList.Add(pk_document_id.ToString());
                    }
                }
                else
                {
                    if (arrayList.Contains(pk_document_id.ToString()))
                    {
                        arrayList.Remove(pk_document_id.ToString());
                    }
                }
            }

            ViewState["SelectedDocuments"] = arrayList;
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
            DataRow dr_component = ds_component.Tables[0].Select("name='Document'")[0];
            SetPermissionToControl(dr_component);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SetPermissionToControl(DataRow dr)
    {
        Permissions objPermission = new Permissions();
        string edit_permission = dr["edit_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();

        if (dr["Control_label_id"].ToString() == "btnDelete")
        {
            objPermission.SetEditable(btnDelete, delete_permission);
            objPermission.SetEditable(btnaddDocument, edit_permission);
            objPermission.SetEditable(btnMapDocuments, edit_permission);
        }

    }

}