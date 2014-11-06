using System;
using System.Collections.Generic; 
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using Facility;
using Locations;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;

public partial class App_Locations_Spaces : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flag = false;
    #region Page Load

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtSearchText.Attributes.Add("onKeyPress", "doClick('" + btnSearch.ClientID + "',event)");
            //Comman.DisablePageCaching();
            if (SessionController.Users_.UserId != null && SessionController.Users_.UserId != string.Empty)
            {

                hf_zone_id.Value = Request.QueryString["id"].ToString();
                hf_zone_name.Value = Request.QueryString["name"].ToString();

                if (SessionController.Users_.Spaceflag == "0")  // It means user wants to see spaces in zone.
                {
                    show();
                    btn_space.Visible = false;
                }
                else // it means user wants to see spaces in floor.
                {
                    hide();
                }

                if (!IsPostBack)
                {
                    lblFacilityName.Text = SessionController.Users_.facilityName;
                    BindFloors();

                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "space_name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgSpaces.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    hfDocumentPMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 2);
                    tempPageSize = hfDocumentPMPageSize.Value;
                   
                    BindSpaces();
                   


                }
            }
            else
            {

                //Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion


    #region Private Methods
    private void BindZonename()
    {
        try
        {
            LocationsModel objloc_mdl = new LocationsModel();
            LocationsClient locObj_crtl = new LocationsClient();
            objloc_mdl.Location_id = new Guid(hf_zone_id.Value);//new Guid(Request.QueryString["id"].ToString());
            DataSet ds_get_zoneprofile = new DataSet();
            ds_get_zoneprofile = locObj_crtl.Get_Zone_Profile_by_ID(SessionController.ConnectionString, objloc_mdl);

            lblzonename.Text = ds_get_zoneprofile.Tables[0].Rows[0]["zonename"].ToString();
            lblzonename.Visible = true;

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void BindFloors()
    {
        try
        {
            DataSet ds;

            FacilityClient facObjClientCtrl = new FacilityClient();
            FacilityModel facObjFacilityModel = new FacilityModel();
            facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
            // facObjFacilityModel.Floor_Id = new Guid(SessionController.Users_.facilityID);

            facObjFacilityModel.Search_text_name = txtSearchText.Text;


            ds = facObjClientCtrl.Get_Floors_For_Selected_Facility(facObjFacilityModel, SessionController.ConnectionString);

            rcbFloors.DataSource = ds;
            rcbFloors.DataValueField = "location_id";
            rcbFloors.DataTextField = "NAME";
            rcbFloors.DataBind();

        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message.ToString();
        }
    }

    protected void BindSpaces()
    {
        try
        {
            DataSet ds;

            FacilityClient facObjClientCtrl = new FacilityClient();
            FacilityModel facObjFacilityModel = new FacilityModel();
            facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
            string url = Request.Url.ToString();

            if (Request.QueryString["id"].ToString().Equals(SessionController.Users_.facilityID.ToString()))
            {
                facObjFacilityModel.Floor_Id = Guid.Empty;

            }
            else
            {
                if (!Request.QueryString["id"].ToString().Equals(Guid.Empty))
                {
                    facObjFacilityModel.Floor_Id = new Guid(Request.QueryString["id"].ToString());
                }
            }
            //facObjFacilityModel.Floor_Id = new Guid(rcbFloors.SelectedValue.ToString());
            if (SessionController.Users_.Spaceflag == "0")
            {
                facObjFacilityModel.Zone_id = new Guid(hf_zone_id.Value.ToString());
                facObjFacilityModel.Description = "";

                //foreach (GridColumn col in rgSpaces.Columns)
                //{
                //    if (col.UniqueName == "floor_name")
                //    {
                //        col.Visible = false;
                //    }
                //}
            }
            else
            {
                facObjFacilityModel.Description = hf_zone_id.Value.ToString();
            }

            facObjFacilityModel.Search_text_name = txtSearchText.Text;
            facObjFacilityModel.Spaceflag = SessionController.Users_.Spaceflag;
            ds = facObjClientCtrl.Get_Spaces_For_Floor_PM(facObjFacilityModel, SessionController.ConnectionString);
            //ds = facObjClientCtrl.Get_Spaces_For_Facility_PM(facObjFacilityModel, SessionController.ConnectionString);

            rgSpaces.AllowCustomPaging = true;
            // rgdocument.AllowPaging = true;
            if (tempPageSize != "")
                rgSpaces.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgSpaces.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
                        
            rgSpaces.DataSource = ds;
            rgSpaces.DataBind();
            
            

        }
        catch (Exception ex)
        {

            lblMsg.Text = ex.Message.ToString();
        }

    }

    protected void show()
    {
        try
        {
            BindZonename();
            lblzone.Visible = true;
            // lblzonename.Text = hf_zone_name.Value.ToString();
            // lblzonename.Visible = true;
            btnAssignSpace.Visible = true;
            btnUnAssignSpace.Visible = true;  //added now
            btnDelete.Visible = false;  //added now
            lblFloorName.Visible = false;
            rcbFloors.Visible = false;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    //To hide the Zone Name and 'Assign Space' button when user views spaces for a paticular floor.
    protected void hide()
    {
        try
        {
            lblzone.Visible = false;
            lblzonename.Visible = false;
            btnAssignSpace.Visible = false;
            btnUnAssignSpace.Visible = false; //added now
            btnDelete.Visible = true; //added now
            lblFloorName.Visible = true;
            rcbFloors.Visible = true;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion



    #region Grid Events
    protected void rgSpace_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            Guid space_id = Guid.Empty;

            if (e.CommandName == "deleteSpace")
            {
                space_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["space_id"].ToString());

                FacilityClient facObjClientCtrl = new FacilityClient();
                FacilityModel facObjFacilityModel = new FacilityModel();
                facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
                facObjFacilityModel.Document_Id = space_id;
                facObjFacilityModel.Description = SessionController.Users_.Spaceflag;
                facObjClientCtrl.Delete_Space(facObjFacilityModel, SessionController.ConnectionString);
                BindSpaces();
                
            }


            if (e.CommandName == "profile")
            {
                string s_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["space_id"].ToString();
                hf_location_id.Value = s_id;
                //Response.Redirect("~/App/Locations/FacilityMenu.aspx?pagevalue=Space Profile&id=" + space_id + "&profileflag=new");
                try
                {
                    //Response.Redirect("FacilityMenu.aspx?pagevalue=Profile&id=" + s_id + "&profileflag=new");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "NavigateToFindLocation('" + s_id + "');", true);
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "Profile navigation error:-" + ex.Message;
                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "rgSpace_ItemCommand:-" + ex.Message;
        }

    }

    protected void rgSpace_SortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            BindSpaces();
            
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    protected void rgSpace_PageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {
            BindSpaces();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgSpace_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            BindSpaces();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion



    #region Event Handlers

    protected void btnSearch_Click(object sender, EventArgs e)
    {

        BindSpaces();
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        
        
    }



    //To show the Zone Name and 'Assign Space' button when user views spaces for a paticular zone.

    protected void btnselect1_Click(object sender, EventArgs e)
    {
        string space_ids = hf_selected_id.Value.ToString();
        string space_names = hf_selected_name.Value.ToString();

        string[] ids = new string[100];
        ids = space_ids.Split(',');

        string[] names = new string[100];
        names = space_names.Split(',');

        LocationsClient loc_ctrl = new Locations.LocationsClient();
        LocationsModel loc_mdl = new Locations.LocationsModel();

        loc_mdl.Location_id = new Guid(hf_zone_id.Value.ToString());
        loc_mdl.Space_ids = hf_selected_id.Value.ToString();

        loc_ctrl.assign_spaces_for_zone(loc_mdl, SessionController.ConnectionString);
        BindSpaces();
       
    }

    protected void btn_spaces_click(object sender, EventArgs e)
    {
        hf_location_id.Value = Guid.Empty.ToString();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_space()", true);
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

    protected void btn_space_click(object sender, EventArgs e)
    {
        hf_location_id.Value = Guid.Empty.ToString();
        if (hf_zone_id.Value != Guid.Empty.ToString())
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_space_floor('" + hf_zone_id.Value.ToString() + "');", true);

        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_space();", true);
        }
    }
    protected void btnAssignSpace_Click(object sender, EventArgs e)
    {

    }
    protected void btnDelete_click(object sender, EventArgs e)
    {
        try
        {

            if (rgSpaces.SelectedItems.Count > 0)  // check weather user checked any text box or not 
            {
                System.Text.StringBuilder strSpaceIds = new System.Text.StringBuilder();
                for (int i = 0; i < rgSpaces.SelectedItems.Count; i++)
                {
                    strSpaceIds.Append(rgSpaces.SelectedItems[i].Cells[2].Text);
                    strSpaceIds.Append(",");
                }

                FacilityClient objfacctrl = new FacilityClient();
                FacilityModel objfacmdl = new FacilityModel();

                objfacmdl.Facility_Ids = strSpaceIds.ToString();
                objfacmdl.Entity = "Space";
                objfacmdl.Facility_Ids.Trim();
                objfacmdl.Facility_Ids.Trim(',');
                objfacctrl.delete_facility_pm(objfacmdl, SessionController.ConnectionString);
                BindSpaces();
                
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void btnUnAssignSpace_Click(object sender, EventArgs e)
    {
        try
        {

            if (rgSpaces.SelectedItems.Count > 0)  // check weather user checked any text box or not 
            {
                System.Text.StringBuilder strSpaceIds = new System.Text.StringBuilder();
                for (int i = 0; i < rgSpaces.SelectedItems.Count; i++)
                {
                    strSpaceIds.Append(rgSpaces.SelectedItems[i].Cells[2].Text);
                    strSpaceIds.Append(",");
                }

                FacilityClient objfacctrl = new FacilityClient();
                FacilityModel objfacmdl = new FacilityModel();

                objfacmdl.Facility_Ids = strSpaceIds.ToString();
                //objfacmdl.Entity = "Space";
                objfacmdl.Facility_Ids.Trim();
                objfacmdl.Facility_Ids.Trim(',');
                objfacctrl.UnassignSpacesPM(objfacmdl, SessionController.ConnectionString);
                BindSpaces();
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
                btn_space.Visible = false;
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

            if (Request.QueryString["name"].ToString() == "Floor")
            {
                DataSet ds_floor = SessionController.Users_.Permission_ds;
                DataRow dr_floor = ds_floor.Tables[0].Select("name='Floor'")[0];
                DataRow[] dr_submenu_floor = ds_floor.Tables[0].Select("fk_parent_control_id='" + dr_floor["pk_project_role_controls"] + "'");
                foreach (DataRow dr_profile in dr_submenu_floor)
                {
                    if (dr_profile["name"].ToString() == "Spaces")
                    {
                        SetPermissionToControl(dr_profile);
                    }
                }
            }


            else if (Request.QueryString["name"].ToString() == "Facility")
            {
                DataSet ds_facility = SessionController.Users_.Permission_ds;
                DataRow dr_facility = ds_facility.Tables[0].Select("name='Facility'")[0];
                DataRow[] dr_submenu_facility = ds_facility.Tables[0].Select("fk_parent_control_id='" + dr_facility["pk_project_role_controls"] + "'");
                foreach (DataRow dr_profile in dr_submenu_facility)
                {
                    if (dr_profile["name"].ToString() == "Spaces")
                    {
                        SetPermissionToControl(dr_profile);
                    }
                }
            }

            else
            {
                DataSet ds_zone = SessionController.Users_.Permission_ds;
                DataRow dr_zone = ds_zone.Tables[0].Select("name='Zone'")[0];
                DataRow[] dr_submenu_component = ds_zone.Tables[0].Select("fk_parent_control_id='" + dr_zone["pk_project_role_controls"] + "'");
                foreach (DataRow dr_profile in dr_submenu_component)
                {
                    if (dr_profile["name"].ToString() == "Zone Profile")
                    {
                        SetPermissionToControl(dr_profile);
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
        string delete_permission = dr["delete_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();
        objPermission.SetEditable(btnDelete, delete_permission);
        objPermission.SetEditable(btnAssignSpace, edit_permission);
        objPermission.SetEditable(btnUnAssignSpace, delete_permission);
        objPermission.SetEditable(btn_space, edit_permission);

    }
protected void rgSpaces_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridHeaderItem)
        {
            GridHeaderItem headerItem = e.Item as GridHeaderItem;

            foreach (GridColumn column in rgSpaces.MasterTableView.RenderColumns)
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
            foreach (GridColumn column in rgSpaces.MasterTableView.RenderColumns)
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
            GridPagerItem pagerItem = e.Item as GridPagerItem;
            RadComboBox combo = pagerItem.FindControl("PageSizeComboBox") as RadComboBox;
            combo.EnableScreenBoundaryDetection = false;
            combo.ExpandDirection = RadComboBoxExpandDirection.Up;
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
        // try
        //{
        //    if (e.Item is Telerik.Web.UI.GridDataItem)
        //    { 
        //        if (SessionController.Users_.Permission_ds != null)
        //        {
        //            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
        //            {
        //                DataSet ds_component = SessionController.Users_.Permission_ds;
        //                DataRow dr_component = ds_component.Tables[0].Select("name='Facility'")[0];
        //                DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
        //                foreach (DataRow dr_profile in dr_submenu_component)
        //                {
        //                    if (dr_profile["name"].ToString() == "Spaces")
        //                    {
        //                        Permissions objPermission = new Permissions();
        //                        string delete_permission = dr_profile["delete_permission"].ToString();
        //                        string edit_permission = dr_profile["edit_permission"].ToString();                       
        //                        string name = string.Empty;
        //                        if (edit_permission == "N")
        //                        {
        //                            try
        //                            {
        //                                LinkButton lnkname = (LinkButton)e.Item.FindControl("hlnkSpaceName");
        //                                name = lnkname.Text.ToString();
        //                                lnkname.Enabled = false;
        //                                lnkname.ResolveUrl(name.Replace("&nbsp;", ""));
        //                            }
        //                            catch (Exception)
        //                            {

        //                                throw;
        //                            }

        //                        }
        //                    }
        //                }
        //            }
        //        }
        //    }
        //}

        //catch (Exception)
        //{

        //    throw;
        //}
    

    }
}