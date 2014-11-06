using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using System.Data;
using Facility;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;


public partial class App_Locations_Floors : System.Web.UI.Page
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
                    sortExpr.FieldName = "floor_name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgFloors.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    hfDocumentPMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 2);
                    tempPageSize = hfDocumentPMPageSize.Value;
                    
                    //hfDocumentPMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 2);
                    //tempPageSize = hfDocumentPMPageSize.Value;

                    BindFloors();


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
            lblMsg.Text = ex.Message.ToString();

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

    protected void BindFloors()
    {
        try
        {

            DataSet ds;

            FacilityClient facObjClientCtrl = new FacilityClient();
            FacilityModel facObjFacilityModel = new FacilityModel();
            facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
            facObjFacilityModel.Search_text_name = txtSearchText.Text;

            ds = facObjClientCtrl.Get_Floors_For_Facility(facObjFacilityModel, SessionController.ConnectionString);
            rgFloors.AllowCustomPaging = true;
            // rgdocument.AllowPaging = true;
            if (tempPageSize != "")
                rgFloors.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgFloors.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
            rgFloors.DataSource = ds;
            rgFloors.DataBind();
          /*  
            if (ds.Tables[0].Rows.Count > 0)
            {
                rgFloors.DataSource = ds;
                rgFloors.DataBind();
            }
            else
            {
                rgFloors.DataSource = ds;
                rgFloors.DataBind();
            }
           */ 
        }
        catch (Exception ex)
        {

            lblMsg.Text = ex.Message.ToString();
        }

    }

    protected void rgFloor_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            Guid floor_id = Guid.Empty;
            if (e.CommandName == "deleteFloor")
            {
                floor_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["floor_id"].ToString());

                FacilityClient facObjClientCtrl = new FacilityClient();
                FacilityModel facObjFacilityModel = new FacilityModel();

                facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
                facObjFacilityModel.Floor_Id = floor_id;
                //facObjFacilityModel.Document_Id = floor_id;

                facObjClientCtrl.Delete_Floor(facObjFacilityModel, SessionController.ConnectionString);
                BindFloors();
            }

            if (e.CommandName == "profile")
            {

                string f_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["floor_id"].ToString();
                hf_location_id.Value = f_id;
                try
                {
                    // Response.Redirect("~\\App\\Locations\\FloorProfile.aspx?master=N&id=" + f_id.ToString(),false);
                    //this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "myUniqueKey", "FacilityMenu.aspx?pagevalue=Floor Profile&id=" + f_id);
                    //"self.parent.location='FloorProfile.aspx?id="+f_id+"';", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "NavigateToFindLocation('" + f_id + "');", true);
                }
                catch (Exception ex)
                {

                    lblMsg.Text = "Profile navigation error:-" + ex.Message;
                }
                //Response.Redirect("FloorProfile.aspx?id=" + f_id.ToString());

            }



        }
        catch (Exception ex)
        {
            lblMsg.Text = "rgFloor_ItemCommand:-" + ex.Message;
        }



    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindFloors();
    }

    protected void rgFloor_SortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            BindFloors();
        }
        catch (Exception ex)
        {

            lblMsg.Text = ex.Message.ToString();
        }

    }

    protected void rgFloor_PageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {
            BindFloors();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }
        catch (Exception ex)
        {

            lblMsg.Text = ex.Message.ToString();
        }

    }

    protected void rgFloor_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {


        try
        {
            BindFloors();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

        }
        catch (Exception ex)
        {

            lblMsg.Text = ex.Message.ToString();
        }

    }

    protected void btn_floor_Click(object sender, EventArgs e)
    {
        hf_location_id.Value = Guid.Empty.ToString();
        //Session["action"] = "AddFloor";
        SessionController.Users_.Action = "AddFloor";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_floor();", true);
    }

    protected void btnDelete_click(object sender, EventArgs e)
    {
        try
        {

            if (rgFloors.SelectedItems.Count > 0)  // check weather user checked any text box or not 
            {
                System.Text.StringBuilder strFloorIds = new System.Text.StringBuilder();
                for (int i = 0; i < rgFloors.SelectedItems.Count; i++)
                {
                    strFloorIds.Append(rgFloors.SelectedItems[i].Cells[2].Text);
                    strFloorIds.Append(",");
                }

                FacilityClient objfacctrl = new FacilityClient();
                FacilityModel objfacmdl = new FacilityModel();

                objfacmdl.Facility_Ids = strFloorIds.ToString();
                objfacmdl.Entity = "Floor";
                objfacmdl.Facility_Ids.Trim();
                objfacmdl.Facility_Ids.Trim(',');
                objfacctrl.delete_facility_pm(objfacmdl, SessionController.ConnectionString);
                BindFloors();
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
                btn_floor.Visible = false;
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
                if (dr_profile["name"].ToString() == "Floors")
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
        objPermission.SetEditable(btn_floor, edit_permission);
    }
    protected void rgFloors_OnItemDataBound(object sender, GridItemEventArgs e)
    {
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
        //                    if (dr_profile["name"].ToString() == "Floors")
        //                    {
        //                        Permissions objPermission = new Permissions();
        //                        string delete_permission = dr_profile["delete_permission"].ToString();
        //                        string edit_permission = dr_profile["edit_permission"].ToString();
        //                        string name = string.Empty;
        //                        if (edit_permission == "N")
        //                        {
        //                            try
        //                            {
        //                                LinkButton lnkname = (LinkButton)e.Item.FindControl("hlnkFloorName");
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

        if (e.Item is GridHeaderItem)
        {
            GridHeaderItem headerItem = e.Item as GridHeaderItem;

            foreach (GridColumn column in rgFloors.MasterTableView.RenderColumns)
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
            foreach (GridColumn column in rgFloors.MasterTableView.RenderColumns)
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
                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "floor_name")
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
    }
}
