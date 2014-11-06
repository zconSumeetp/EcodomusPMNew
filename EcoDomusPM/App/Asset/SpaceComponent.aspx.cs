using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Locations;
using EcoDomus.Session;
using Asset;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;
using Facility;

public partial class SpaceComponent : System.Web.UI.Page
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
                    //hdnfacility.Value = SessionController.Users_.facilityID.ToString(); 
                    hdnEmptyGuid.Value = Guid.Empty.ToString();
                    hfid.Value = Request.QueryString["id"].ToString();
                    hfentityname.Value = Request.QueryString["name"].ToString();
                    if (hfentityname.Value == "Space")
                    {
                        //btnaddasset.Visible = false;
                        //btnunassignasset.Visible = false;
                        rgasset.Columns[4].Visible = false;
                    }
                    //BindFacility();

                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "Asset_Name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgasset.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    hfDocumentPMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize));
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    BindGrid();
                }

            }
            else
            {
               // redirect_page("~\\app\\LoginPM.aspx?Error=Session");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        try
        {
            BindGrid();
        }
        catch (Exception)
        {

            throw;
        }

    }

    // Bind facilities to facility Dropdown according to user
    //private void BindFacility()
    //{
    //    try
    //    {
    //        DataSet ds_facility = new DataSet();
    //        FacilityClient facObj_crtl = new FacilityClient();
    //        FacilityModel facObj_mdl = new FacilityModel();
    //        facObj_mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
    //        facObj_mdl.Search_text_name = "";
    //        facObj_mdl.Doc_flag = "";
    //        ds_facility = facObj_crtl.GetFacilitiesPM(facObj_mdl, SessionController.ConnectionString);
    //        cmbfacility.DataTextField = "name";
    //        cmbfacility.DataValueField = "pk_facility_id";
    //        cmbfacility.DataSource = ds_facility;
    //        cmbfacility.DataBind();

    //        if (SessionController.Users_.IsFacility == "yes")
    //        {
    //            cmbfacility.Visible = true;
    //            lblfacility.Visible = true;
    //            cmbfacility.SelectedValue = SessionController.Users_.facilityID;
    //            cmbfacility.Enabled = false;
    //        }
    //        else
    //        {
    //            cmbfacility.Visible = true;
    //            lblfacility.Visible = true;
    //            cmbfacility.Enabled = true;
    //        }

    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}

    protected void BindGrid()
    {
        try
        {
            AssetModel objloc_mdl = new AssetModel();
            AssetClient objloc_crtl = new AssetClient();
            DataSet ds_Search_assets = new DataSet();
            objloc_mdl.EntityName = hfentityname.Value;
            objloc_mdl.CriteriaName = "Name"; // cmbcriteria.SelectedItem.Text;
            objloc_mdl.CriteriaText = txtcriteria.Text;
            objloc_mdl.Type_id = new Guid(hfid.Value); 

            //if (SessionController.Users_.IsFacility == "yes")
            //{
            //    objloc_mdl.FacilityNames = SessionController.Users_.facilityID;
            //}
            //else
            //{
            //    System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
            //    foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
            //    {
            //        if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
            //        {
            //            facilityvalues.Append(rcbItem.Value);
            //            facilityvalues.Append(",");
            //        }
            //    }
            //    if (facilityvalues.ToString().Length > 0)
            //    {
            //        facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
            //    }
            //    objloc_mdl.FacilityNames = facilityvalues.ToString();
            //}
           
            if (hfentityname.Value == "Space")
            {
                ds_Search_assets = objloc_crtl.Search_Assets_for_space(SessionController.ConnectionString, objloc_mdl);
            }
            else
            {
                ds_Search_assets = objloc_crtl.Search_Assets_for_entity_pm(SessionController.ConnectionString, objloc_mdl);
            }

            rgasset.AllowCustomPaging = true;
            // rgdocument.AllowPaging = true;
            if (tempPageSize != "")
                rgasset.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgasset.VirtualItemCount = Int32.Parse((ds_Search_assets.Tables[0].Rows.Count.ToString()));
            
            if (ds_Search_assets.Tables.Count > 0)
            {
                rgasset.DataSource = ds_Search_assets;
                rgasset.DataBind();
                rgasset.Visible = true;
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void rgasset_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            AssetModel objloc_mdl = new AssetModel();
            AssetClient objloc_crtl = new AssetClient();

            objloc_mdl.Asset_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Assetid"].ToString());

            //if (e.CommandName == "delete")
            //{
            //    objloc_crtl.delete_Asset(SessionController.ConnectionString, objloc_mdl);

            //}


            BindGrid();
        }
        catch (Exception ex)
        {

        }

    }

    protected void cmbfacility_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        try
        {
            ((CheckBox)e.Item.FindControl("CheckBox1")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");

        }
        catch (Exception ex)
        {
        }
    }

    protected void btn_refresh_Click(object sender, EventArgs e)
    {
        BindGrid();
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

    protected void btnunassignasset_Click(object sender, EventArgs e)
    {
        string id = "";

        try
        {
            if (rgasset.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                for (int i = 0; i < rgasset.SelectedItems.Count; i++)
                {
                    id = id + rgasset.SelectedItems[i].Cells[3].Text + ",";
                    //name = name + rgasset.SelectedItems[i].Cells[4].Text + ",";
                    //type_name = type_name + rgasset.SelectedItems[i].Cells[5].Text + ",";
                }
                id = id.Substring(0, id.Length - 1);
                //name = name.Substring(0, name.Length - 1);
                //type_name = type_name.Substring(0, type_name.Length - 1);
                //type_name = type_name.Replace("'", "single");
                //name = name.Replace("'", "single");

                DataSet ds = new DataSet();
                AssetClient objAsset_Client = new AssetClient();
                AssetModel objAsset_Model = new AssetModel();

                objAsset_Model.EntityName = (hfentityname.Value).ToString();
                objAsset_Model.Type_id = new Guid(hfid.Value);
                objAsset_Model.Name = id; //comma seperated asset ids

                objAsset_Client.UnAssign_Assets_for_entity(objAsset_Model, SessionController.ConnectionString);
                BindGrid();  
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>assignAsset()</script>");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "GU")
        {
            btnAddCompo.Visible = false;
            btnaddasset.Visible = false;
            btnunassignasset.Visible = false;
        }
        //BindGrid();
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
            DataRow dr_component = ds_component.Tables[0].Select("name='Space'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Space Profile")
                {
                    // Edit/Delete permission for component
                    SetPermissionToControl(dr_profile);

                    // permissions for component profile fields
                    DataRow[] dr_fields_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_profile["pk_project_role_controls"] + "'");
                    foreach (DataRow dr in dr_fields_component)
                    {
                        SetPermissionToControl(dr);
                    }
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
        string edit_permission = dr["edit_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();
        // delete button on component profile
        if (dr["name"].ToString() == "Space Profile")
        {
            objPermission.SetEditable(btnaddasset, edit_permission);
            objPermission.SetEditable(btnunassignasset, delete_permission);
            objPermission.SetEditable(btnAddCompo, edit_permission);
        }
    }

    protected void rgasset_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridHeaderItem)
        {
            GridHeaderItem headerItem = e.Item as GridHeaderItem;

            foreach (GridColumn column in rgasset.MasterTableView.RenderColumns)
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
                    if (column.HeaderText != "")
                        (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                }


            }
        }
        if (e.Item is GridDataItem)
        {
            GridDataItem gridItem = e.Item as GridDataItem;
            foreach (GridColumn column in rgasset.MasterTableView.RenderColumns)
            {
                if (column is GridBoundColumn)
                {
                    //this line will show a tooltip based type of Databound for grid data field
                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "Location")
                    {
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[0].ToString());
                    }
                    else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "linkasset")
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[1].ToString());
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
                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "linkasset")
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
        if (e.Item is GridPagerItem)
        {
            GridPagerItem pagerItem = e.Item as GridPagerItem;
            RadComboBox combo = pagerItem.FindControl("PageSizeComboBox") as RadComboBox;
            combo.EnableScreenBoundaryDetection = false;
            combo.ExpandDirection = RadComboBoxExpandDirection.Up;
        }

        //if (e.Item is Telerik.Web.UI.GridDataItem)
        //{
        //    Permissions objPermission = new Permissions();
        //    if (SessionController.Users_.Permission_ds != null)
        //    {
        //        if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
        //        {
        //            DataSet ds_component = SessionController.Users_.Permission_ds;
        //            DataRow dr_component = ds_component.Tables[0].Select("name='Space Profile'")[0];

        //            string delete_permission = dr_component["delete_permission"].ToString();
        //            string edit_permission = dr_component["edit_permission"].ToString();
        //            string name = string.Empty;
        //            if (edit_permission == "N")
        //            {
        //                try
        //                {
        //                    name = e.Item.Cells[4].Text.ToString();
        //                    e.Item.Cells[4].Text = objPermission.remove_Hyperlink(name.Replace("&nbsp;", ""));

        //                     name = e.Item.Cells[5].Text.ToString();
        //                    e.Item.Cells[5].Text = objPermission.remove_Hyperlink(name.Replace("&nbsp;", ""));
                        
        //                }
        //                catch (Exception)
        //                {
        //                    throw;
        //                }
        //            }
        //        }
        //    }
        //}
    }
}