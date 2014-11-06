using System;
using System.Collections.Generic; 
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Data;
using Facility;
using Locations;
using System.Threading;
using System.Globalization;

public partial class App_Locations_Zones : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flag = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtSearchText.Attributes.Add("onKeyPress", "doClick('" + btnSearch.ClientID + "',event)");

            Comman.DisablePageCaching();
            if (SessionController.Users_.UserId != null && SessionController.Users_.UserId != string.Empty)
            {
                if (!IsPostBack)
                {
                    lblFacilityName.Text = SessionController.Users_.facilityName;
                     
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "zone_name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgZones.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    hfDocumentPMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 2);
                    tempPageSize = hfDocumentPMPageSize.Value;
                   
                    BindZones();

                }

            }
            else 
            {
               // Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Page_Load" + ex.Message.ToString();
        }
    }

   
    protected void BindZones()
    {
        try
        {

            DataSet ds;

            FacilityClient facObjClientCtrl = new FacilityClient();
            FacilityModel facObjFacilityModel = new FacilityModel();
            facObjFacilityModel.Facility_Ids = SessionController.Users_.facilityID.ToString();
       
            facObjFacilityModel.Search_text_name = txtSearchText.Text;
            
            ds = facObjClientCtrl.Get_Zones_For_Facility(facObjFacilityModel, SessionController.ConnectionString);
            rgZones.AllowCustomPaging = true;
            // rgdocument.AllowPaging = true;
            if (tempPageSize != "")
                rgZones.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgZones.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
            
            if (ds.Tables[0].Rows.Count > 0)
            {
                rgZones.DataSource = ds;
                rgZones.DataBind();
            }


        }
        catch (Exception ex)
        {

            lblMsg.Text = ex.Message.ToString();
        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindZones();
    }

    
    protected void rgZones_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            Guid zone_id = Guid.Empty;

            if (e.CommandName == "profile")
            {
                string z_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["zone_id"].ToString();
                string name1 = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["zone_name"].ToString();
                hf_location_id.Value = z_id;
                hf_zone_name.Value = name1;
                
  
                try
                {
                        //this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "myUniqueKey",
                        //"self.parent.location='SpaceProfile.aspx?id=" + _id + "';", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "NavigateToFindLocation();", true);

                }
                catch (Exception ex)
                {

                    lblMsg.Text = "Profile navigation error:-" + ex.Message;
                }
             

            }

            if (e.CommandName == "deleteZone")
            {
                zone_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["zone_id"].ToString());
                
                LocationsClient loc_ctrl = new LocationsClient();
                LocationsModel loc_mdl = new LocationsModel();
                //loc_mdl.Facility_id = new Guid(SessionController.Users_.facilityID);
                loc_mdl.Zone_id = zone_id;
                //loc_mdl.Description = SessionController.Users_.Spaceflag;
                loc_ctrl.Delete_Zone(loc_mdl, SessionController.ConnectionString);
                BindZones();
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    
    }

    protected void rgZones_SortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            BindZones();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rgZones_PageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    { 
        try
        {
            BindZones();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

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

    protected void rgZones_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            BindZones();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    protected void btnadd_Click(object sender, EventArgs e)
    {

        hf_location_id.Value = Guid.Empty.ToString();
      //  Session["action"] = "AddZone";
        SessionController.Users_.Action = "AddZone";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "navigate_zone();", true);
        //Response.Redirect("FacilityMenu.aspx?pagevalue=Zone Profile&name= &id=" + Guid.Empty.ToString());
    }
    protected void btnclose_Click(object sender, EventArgs e)
    {

    }
    protected void btnDelete_click(object sender, EventArgs e)
    {
        try
        {

            if (rgZones.SelectedItems.Count > 0)  // check weather user checked any text box or not 
            {
                System.Text.StringBuilder strZoneIds = new System.Text.StringBuilder();
                for (int i = 0; i < rgZones.SelectedItems.Count; i++)
                {
                    strZoneIds.Append(rgZones.SelectedItems[i].Cells[2].Text);
                    strZoneIds.Append(",");
                }

                FacilityClient objfacctrl = new FacilityClient();
                FacilityModel objfacmdl = new FacilityModel();

                objfacmdl.Facility_Ids = strZoneIds.ToString();
                objfacmdl.Entity = "Zone";
                objfacmdl.Facility_Ids.Trim();
                objfacmdl.Facility_Ids.Trim(',');
                objfacctrl.delete_facility_pm(objfacmdl, SessionController.ConnectionString);
                BindZones();
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
                btnadd.Visible = false;
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
                if (dr_profile["name"].ToString() == "Zones")
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
        objPermission.SetEditable(btnDelete, delete_permission);
        objPermission.SetEditable(btnadd, edit_permission);

    }

protected void rgZones_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridHeaderItem)
        {
            GridHeaderItem headerItem = e.Item as GridHeaderItem;

            foreach (GridColumn column in rgZones.MasterTableView.RenderColumns)
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
            foreach (GridColumn column in rgZones.MasterTableView.RenderColumns)
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
                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "zone_name")
                    {
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[3].ToString());
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
        //try
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
        //                    if (dr_profile["name"].ToString() == "Zones")
        //                    {
        //                        Permissions objPermission = new Permissions();
        //                        string delete_permission = dr_profile["delete_permission"].ToString();
        //                        string edit_permission = dr_profile["edit_permission"].ToString();                       
        //                        string name = string.Empty;
        //                        if (edit_permission == "N")
        //                        {
        //                            try
        //                            {
        //                                LinkButton lnkname = (LinkButton)e.Item.FindControl("hlnkZoneName");
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