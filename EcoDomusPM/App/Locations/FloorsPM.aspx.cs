using System;
using System.Collections.Generic; 
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Facility;
using System.Data;
using System.Data.SqlClient;
using EcoDomus.Session;
using Telerik.Web.UI;
using Locations;
using System.Threading;
using System.Globalization;


public partial class App_Locations_FloorsPM : System.Web.UI.Page
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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {
        Response.Redirect(url, false);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        txt_search.Attributes.Add("onKeyPress", "doClick('" + btn_search.ClientID + "',event)");
        if (SessionController.Users_.UserId != null)
        {
            if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
            }
            else
            {
                if (!IsPostBack)
                {
                    bindfacility();
                    GridSortExpression sortexpr = new GridSortExpression();
                    sortexpr.FieldName = "FloorName";
                    sortexpr.SortOrder = GridSortOrder.Ascending;
                    rg_floors.MasterTableView.SortExpressions.AddSortExpression(sortexpr);
                    hfFloorsPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    bindfloors();
                           
                }
            }
        }
        else
        {
            Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
        }
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "GU")
        {
            btnaddfloor.Visible = false;
            btndelete.Visible = false;
        }
        // bindfloors();
        if (SessionController.Users_.Permission_ds != null)
        {
            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
            {
                {
                    SetPermissions();
                }
            }
           // chk_facility.Checked = false;
        }
    }

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='Floor'")[0];

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
        // delete button on component profile
        if (dr["name"].ToString() == "Floor")
        {
            objPermission.SetEditable(btndelete, delete_permission);
            objPermission.SetEditable(btnaddfloor, edit_permission);
        }

    }

    protected void bindfacility()
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        DataSet ds = new DataSet();
        DataSet ds1 = new DataSet();
        try
        {
            fm.Project_id = new Guid(SessionController.Users_.ProjectId);
            fm.Search_text_name = "";
            fm.Doc_flag = "floor";
            ds = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                cmb_facility.DataTextField = "name";
                cmb_facility.DataValueField = "pk_facility_id";
                cmb_facility.DataSource = ds;
                cmb_facility.DataBind();
                string name = ds.Tables[0].Rows[0]["name"].ToString();
                cmb_facility.Text = name;
            }         
           
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }

    //protected void cmb_facility_OnSelectedIndexChanged(object sender,RadComboBoxSelectedIndexChangedEventArgs e)
    //{
    //    bindfloors();
    //    bindspaces();
    //}

    //protected void cmb_facility_on_checked(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    //{
    //    bindfloors(); 
    //}

    protected void bindfloors()
    {
        LocationsModel lm = new LocationsModel();
        LocationsClient lc = new LocationsClient();
        DataSet ds = new DataSet();
        //lm.facility_ID = new Guid(cmb_facility.SelectedValue.ToString());       

        System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
        foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmb_facility.Items)
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

        lm.FacilityNames = facilityvalues.ToString();
        lm.CriteriaText = cmb_criteria.SelectedValue.ToString();
        lm.Search_text = txt_search.Text.ToString();
        ds = lc.Get_Floors_PM(lm, SessionController.ConnectionString);

        rg_floors.AllowCustomPaging = true;
        // rgdocument.AllowPaging = true;
        if (tempPageSize != "")
            rg_floors.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
        rg_floors.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
        rg_floors.DataSource = ds;
        rg_floors.DataBind();

      
    }

    protected void btn_search_click(object sender, EventArgs e)
    {
       // rg_spaces.Visible = true;

       // GridSortExpression sortexpr = new GridSortExpression();
       // sortexpr.FieldName = "SpaceName";
       // sortexpr.SortOrder = GridSortOrder.Ascending;
       // rg_spaces.MasterTableView.SortExpressions.AddSortExpression(sortexpr);


       // LocationsModel lm = new LocationsModel();
       // LocationsClient lc = new LocationsClient();
       // DataSet ds = new DataSet();
       //// lm.facility_ID = new Guid(cmb_facility.SelectedValue.ToString());
       // System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
       // foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmb_facility.Items)
       // {
       //     if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
       //     {
       //         facilityvalues.Append(rcbItem.Value);
       //         facilityvalues.Append(",");
       //     }
       // }
       // if (facilityvalues.Length > 0)
       // {
       //     facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
       // }

       // lm.FacilityNames = facilityvalues.ToString();


       // lm.Search_text = txt_search.Text.Trim();
       // if (cmb_floors.SelectedIndex == -1)
       // {
       //     lm.Location_id = Guid.Empty;
       // }
       // else
       // {
       //     lm.Location_id = new Guid(cmb_floors.SelectedValue.ToString());
       // }
       // ds = lc.Get_Spaces_PM(lm, SessionController.ConnectionString);
       // rg_spaces.DataSource = ds;
       // rg_spaces.DataBind();

        bindfloors();
    }

    protected void cmbfacility_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        try
        {
            ((CheckBox)e.Item.FindControl("CheckBox1")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");                        
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void navigate(object sender, EventArgs e)
    {
        //cmb_floors.Enabled = true;
        bindfloors();
    }

    protected void btnaddfloor_Click(object sender, EventArgs e)
    {
        hf_floor_id.Value = Guid.Empty.ToString();
        SessionController.Users_.facilityID = Guid.Empty.ToString();
        //Session["action"] = "AddFloor";
        SessionController.Users_.Action = "AddFloor";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_floor();", true);              
    }

    protected void btn_delete_click(object sender, EventArgs e)
    {
        try
        {
            if (rg_floors.SelectedItems.Count > 0)
            {
                System.Text.StringBuilder strSystemIds = new System.Text.StringBuilder();
                for (int i = 0; i < rg_floors.SelectedItems.Count; i++)
                {
                    strSystemIds.Append(rg_floors.SelectedItems[i].Cells[2].Text);
                    strSystemIds.Append(",");
                }

                string fac_ids = strSystemIds.ToString();
                if (fac_ids.Length > 0)
                {
                    fac_ids = fac_ids.Remove(fac_ids.ToString().Length - 1, 1);
                }
                FacilityModel fm = new Facility.FacilityModel();
                FacilityClient fc = new Facility.FacilityClient();
                fm.Facility_Ids = fac_ids;
                fm.Entity = "Floor";
                fc.delete_facility_pm(fm, SessionController.ConnectionString);           
                bindfloors();
            }
            //else
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
            //}
        }
        catch (Exception ex)
        {

        }
    }

    protected void rg_floors_ItemCommand(object sender, GridCommandEventArgs e)
    {
        //if (e.CommandName == "SpaceProfile")
        //{
        //    Guid space_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Space_location_id"].ToString());
        //    //SessionController.Users_.facilityID = Guid.Empty.ToString();
        //    SessionController.Users_.facilityID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Space_location_id"].ToString();
        //    Response.Redirect("~/App/Locations/FacilityMenu.aspx?pagevalue=Space Profile&id=" + space_id);
        //}
        if (e.CommandName == "FloorProfile")
        {
            Guid Floor_location_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Floor_id"].ToString());
            //SessionController.Users_.facilityID = Guid.Empty.ToString();
            SessionController.Users_.facilityID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_facility_id"].ToString();
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?pagevalue=Floor Profile&IsFromFloor=y&id=" + Floor_location_id);
        }

    }

    protected void rg_floorsPageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        bindfloors();
        flag = true;

        


    }

    protected void rg_floorsPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
         tempPageSize = e.NewPageSize.ToString();
         if (!flag)
         {
             flag = true;

             bindfloors();
         }

    }

    protected void rg_floorsSortCommand(object source, GridSortCommandEventArgs e)
    {
        bindfloors();
    }

    protected void rg_floors_OnItemDataBound(object sender, GridItemEventArgs e)
    {

        try
        {

            if (e.Item is GridPagerItem)
            {

                RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                cb.Items.Sort(new PagerRadComboBoxItemComparer());
                if (tempPageSize != "")
                {
                    cb.Items.FindItemByValue(tempPageSize).Selected = true;
                }


            }

            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rg_floors.MasterTableView.RenderColumns)
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
                foreach (GridColumn column in rg_floors.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "linkfacility")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[0].ToString());
                        else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "floor_name")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2].ToString());
                        }
                        else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "linkfacility")
                        { 
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[0].ToString());
                        }
                        else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "description")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[4].ToString());
                        }
                    }
                    else if (column is GridButtonColumn)
                    {
                        //this line will show a tooltip based type of linkbutton for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.OrderIndex != 3 && column.OrderIndex != 4)
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                        else
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[3].ToString());

                    }
                   
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void chk_facility_click(object sender, EventArgs e)
    {
        if (chk_facility.Checked == true)
        {
            GridColumn col = rg_floors.Columns.FindByUniqueName("linkfacility");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = true;
            bindfloors();
            Session["chk_facility_checked_floorpm"] = "Y";
        }
        else
        {
            GridColumn col = rg_floors.Columns.FindByUniqueName("linkfacility");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = false;
            bindfloors();
            Session["chk_facility_checked_floorpm"] = "";
        }

    }

}