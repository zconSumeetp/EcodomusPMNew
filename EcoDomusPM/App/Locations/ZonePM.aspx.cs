using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Locations;
using EcoDomus.Session;
using System.Data;
using System.Threading;
using System.Globalization;
using Facility;
using System.Drawing;

public partial class App_Locations_ZonePM : System.Web.UI.Page
{
    string zonename = "";
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
        if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
        }
        else
        {
            if (!IsPostBack)
            {
                BindFacilities();
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "zone_name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                //rgzones.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                hfZonePMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                //BindZones();
            }
        }
    }



    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {

                btn_delete.Visible = false;
                btnadd.Visible = false;
            }
            if (Session["chk_facility_checked_zonespm"] != null)
            {
                if (Session["chk_facility_checked_zonespm"].ToString() != "")
                {
                    if (Session["chk_facility_checked_zonespm"].ToString() == "Y")
                    {
                        //GridColumn col = rgzones.Columns.FindByUniqueName("linkfacility");
                        //GridBoundColumn colBound = col as GridBoundColumn;
                        //colBound.Visible = true;
                        //chk_facility.Checked = true;
                        //BindZones();
                    }

                }
                else
                {
                    //    GridColumn col = rgzones.Columns.FindByUniqueName("linkfacility");
                    //    GridBoundColumn colBound = col as GridBoundColumn;
                    //    colBound.Visible = false;
                    //    chk_facility.Checked = false;
                    //    BindZones();
                }
            }
            else
            {
                //GridColumn col = rgzones.Columns.FindByUniqueName("linkfacility");
                //GridBoundColumn colBound = col as GridBoundColumn;
                //colBound.Visible = false;
                //BindZones();
            }
            // BindZones();
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
            DataRow dr_component = ds_component.Tables[0].Select("name='Zone'")[0];
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
        if (dr["name"].ToString() == "Zone")
        {
            objPermission.SetEditable(btn_delete, delete_permission);
            objPermission.SetEditable(btnadd, edit_permission);
        }

    }


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
                //cmbfacility.Text = name;
            }
            cmbfacility.Visible = true;
            lblfacility.Visible = true;
            cmbfacility.Enabled = true;
            if (ds_facility.Tables[0].Rows.Count != 0)
            {
                if (SessionController.Users_.ZoneSelectedFacilities == null || Convert.ToString(SessionController.Users_.SpaceSelectedFacilities) == "")
                {

                    for (int k = 0; k < cmbfacility.Items.Count; k++)
                    {
                        CheckBox checkbox = (CheckBox)cmbfacility.Items[k].FindControl("CheckBox2");
                        checkbox.Checked = true;
                        cmbfacility.SelectedValue = cmbfacility.SelectedValue + "," + checkbox.Text;


                    }



                    cmbfacility.SelectedValue = cmbfacility.SelectedValue.Remove(0, 1);
                    cmbfacility.Text = cmbfacility.SelectedValue;
                }
                else
                {
                    string facilityids = SessionController.Users_.ZoneFacilities;
                    if (facilityids.ToString() != "")
                    {
                        int count = 0;
                        string mysubstring = "";
                        for (var i = 0; i <= facilityids.Length - mysubstring.Length; i++)
                        {
                            if (facilityids.ToString().Substring(i, mysubstring.Length) == mysubstring)
                            {
                                count++;
                            }
                        }
                        string[] facidarray = new string[count + 1];
                        int j = count + 1;
                        int p = 0;
                        System.Text.StringBuilder facilityvalues2 = new System.Text.StringBuilder();
                        for (int k = 0; k < cmbfacility.Items.Count; k++)
                        {
                            Telerik.Web.UI.RadComboBoxItem rcbItem = (Telerik.Web.UI.RadComboBoxItem)cmbfacility.Items[k];
                            if (facilityids.Contains(rcbItem.Value))
                            {
                                facidarray[p] = rcbItem.Value;
                                cmbfacility.SelectedValue = facidarray[p].ToString();
                                CheckBox checkbox = (CheckBox)cmbfacility.Items[k].FindControl("CheckBox2");
                                checkbox.Checked = true;
                            }
                        }
                        cmbfacility.SelectedValue = SessionController.Users_.ZoneSelectedFacilities;
                        cmbfacility.Text = SessionController.Users_.ZoneSelectedFacilities;
                    }
                }
            }


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }



    protected void btnadd_Click(object sender, EventArgs e)
    {
        SessionController.Users_.facilityID = Guid.Empty.ToString();
        //Session["action"] = "AddZone";
        SessionController.Users_.Action = "AddZone";
        Response.Redirect("FacilityMenu.aspx?name=" + zonename + "&pagevalue=Zone Profile&id=" + Guid.Empty.ToString());

    }

    protected void btn_search_click(object sender, EventArgs e)
    {
        try
        {
            //BindZones();
            rg_zone.Rebind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //protected void cmbfacility_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    //{
    //    rg_zone.Rebind();
    //    //BindZones();
    //}

    protected void cmbfacility_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        try
        {
            if (SessionController.Users_.ZoneFacilities == null || SessionController.Users_.ZoneFacilities == "")
            {
                System.Text.StringBuilder facilityvalues1 = new System.Text.StringBuilder();
                foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("CheckBox2")).Checked)
                    {
                        facilityvalues1.Append(rcbItem.Value);
                        facilityvalues1.Append(",");
                    }
                }
                if (facilityvalues1.ToString().Length > 0)
                {
                    facilityvalues1 = facilityvalues1.Remove(facilityvalues1.ToString().Length - 1, 1);
                }
                SessionController.Users_.ZoneFacilities = facilityvalues1.ToString();
            }
            ((CheckBox)e.Item.FindControl("CheckBox2")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    /// this function gets called when facility checkbox is clicked
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void navigate(object sender, EventArgs e)
    {
        rg_zone.Rebind();
    }

    protected void chk_facility_click(object sender, EventArgs e)
    {
        if (chk_facility.Checked == true)
        {
            //GridColumn col = rg_spaces.Columns.FindByUniqueName("linkfacility");
            //GridBoundColumn colBound = col as GridBoundColumn;
            //colBound.Visible = true;
            //bindspaces();
            Session["chk_facility_checked_zonespm"] = "Y";
        }
        else
        {
            //GridColumn col = rg_spaces.Columns.FindByUniqueName("linkfacility");
            //GridBoundColumn colBound = col as GridBoundColumn;
            //colBound.Visible = false;
            //bindspaces();
            Session["chk_facility_checked_zonespm"] = "";
        }

    }

    protected void btndelete_Click(object sender, EventArgs e)
    {
        if (rg_zone.SelectedItems.Count > 0)
        {
            System.Text.StringBuilder strSystemIds = new System.Text.StringBuilder();

            for (int i = 0; i < rg_zone.SelectedItems.Count; i++)
            {
                strSystemIds.Append(rg_zone.SelectedItems[i].Cells[3].Text);
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
            fm.Entity = "Zone";
            fc.delete_facility_pm(fm, SessionController.ConnectionString);
            rg_zone.Rebind();
        }
    }


    /*--new methods for hierarchical grid changes -->*/

    protected void get_zone_facility(string zone_id, out Guid facility_id)
    {
        try
        {
            facility_id = Guid.Empty;
            DataSet ds_facility = new DataSet();
            FacilityModel mdl = new FacilityModel();
            FacilityClient cli = new FacilityClient();

            mdl.Zone_id = new Guid(zone_id);
            ds_facility = cli.GetZoneFacility(mdl, SessionController.ConnectionString);
            facility_id = new Guid(Convert.ToString(ds_facility.Tables[0].Rows[0]["fk_facility_id"]));

        }
        catch (Exception)
        {

            throw;
        }
        finally
        {

        }


    }

    /// returns all facilities for first time 
    /// 
    /// </summary>
    /// <param name="facility_ids"></param>
    protected void get_facilities(out string facility_ids)
    {
        facility_ids = Convert.ToString(SessionController.Users_.ZoneFacilities);

        if (!IsPostBack)
        {
            if (facility_ids == "" || facility_ids == null)
            {
                System.Text.StringBuilder str_facility_ids = new System.Text.StringBuilder();

                DataSet ds_facility = new DataSet();
                FacilityClient locObj_crtl = new FacilityClient();
                FacilityModel locObj_mdl = new FacilityModel();
                locObj_mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
                locObj_mdl.Search_text_name = "";
                locObj_mdl.Doc_flag = "floor";
                ds_facility = locObj_crtl.GetFacilitiesPM(locObj_mdl, SessionController.ConnectionString);

                foreach (var item in ds_facility.Tables[0].Rows)
                {
                    /*--for first time ids-->*/
                    str_facility_ids.Append(",");
                    str_facility_ids.Append(Convert.ToString(((System.Data.DataRow)(item)).ItemArray[0]));
                }
                str_facility_ids = str_facility_ids.Remove(0, 1);

                facility_ids = Convert.ToString(str_facility_ids);
            }
            else
            {
                System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
                System.Text.StringBuilder selectedfacilitynames = new System.Text.StringBuilder();


                foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("CheckBox2")).Checked)
                    {
                        facilityvalues.Append(rcbItem.Value);
                        facilityvalues.Append(",");

                        selectedfacilitynames.Append(rcbItem.Text);
                        selectedfacilitynames.Append(",");

                    }
                }
                if (facilityvalues.Length > 0)
                {
                    facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
                }
                if (selectedfacilitynames.ToString().Length > 0)
                {
                    selectedfacilitynames = selectedfacilitynames.Remove(selectedfacilitynames.ToString().Length - 1, 1);
                }

                facility_ids = facilityvalues.ToString();

                SessionController.Users_.ZoneFacilities = facilityvalues.ToString();

                SessionController.Users_.ZoneSelectedFacilities = selectedfacilitynames.ToString();
            }

        }
        else
        {
            System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
            System.Text.StringBuilder selectedfacilitynames = new System.Text.StringBuilder();


            foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
            {
                if (((CheckBox)rcbItem.FindControl("CheckBox2")).Checked)
                {
                    facilityvalues.Append(rcbItem.Value);
                    facilityvalues.Append(",");

                    selectedfacilitynames.Append(rcbItem.Text);
                    selectedfacilitynames.Append(",");

                }
            }
            if (facilityvalues.Length > 0)
            {
                facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
            }
            if (selectedfacilitynames.ToString().Length > 0)
            {
                selectedfacilitynames = selectedfacilitynames.Remove(selectedfacilitynames.ToString().Length - 1, 1);
            }

            facility_ids = facilityvalues.ToString();

            SessionController.Users_.ZoneFacilities = facilityvalues.ToString();

            SessionController.Users_.ZoneSelectedFacilities = selectedfacilitynames.ToString();
        }

    }

    /// NeedDataSource gets called on every rebind 
    /// 
    /// </summary>
    protected void rg_zone_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        if (!e.IsFromDetailTable)
        {
            string facility_ids = string.Empty;
            get_facilities(out facility_ids);

            FacilityClient lc = new FacilityClient();
            FacilityModel lm = new FacilityModel();
            DataSet ds = new DataSet();
            lm.Facility_Ids = facility_ids;
            lm.Search_text_name = Convert.ToString(txt_search.Text.Trim());
            ds = lc.GetZoneByFacility(lm, SessionController.ConnectionString);
            rg_zone.DataSource = ds;
        }
    }

    /// bind internal grid 
    /// 
    /// </summary>
    protected void rg_zone_DetailTableDataBind(object source, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "space_id"://binding different entity types to inner grid 
                {
                    string pk_zone_id = Convert.ToString(dataItem.GetDataKeyValue("pk_zone_id"));
                    FacilityClient lc = new FacilityClient();
                    FacilityModel lm = new FacilityModel();
                    DataSet ds = new DataSet();
                    try
                    {
                        lm.Zone_id = new Guid(pk_zone_id);
                        ds = lc.GetSpaceByZone(lm, SessionController.ConnectionString);
                    }
                    catch (Exception ex)
                    {

                        throw ex;
                    }
                    e.DetailTableView.DataSource = ds;
                    break;
                }



        }
    }

    /// PreRender event for grid 
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rg_zone_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //rg_MI_report.MasterTableView.Items[0].Expanded = true;
            //rg_MI_report.MasterTableView.Items[0].ChildItem.NestedTableViews[0].Items[0].Expanded = true;
            //RadGrid1.MasterTableView.Items[1].Expanded = true;
        }
    }

    /// Grid ItemCommand event
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rg_zone_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "color")
        {
            GridDataItem ditem = (GridDataItem)e.Item;
            string id = ditem["pk_zone_id"].Text;
            string entity_id = ditem["entity_id"].Text;
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script1", "color_popup('" + id + "','" + entity_id + "');", true);
            return;
        }
        if (e.CommandName == "Edit")
        {
            GridDataItem ditem = (GridDataItem)e.Item;
            string zonename = ditem["name"].Text;
            string id = ditem["pk_zone_id"].Text;
            Guid fk_facility_id;
            get_zone_facility(id, out fk_facility_id);
            SessionController.Users_.facilityID = fk_facility_id.ToString();

            Response.Redirect("FacilityMenu.aspx?IsFromZone=Y&name=" + zonename + "&pagevalue=Zone Profile&id=" + id.ToString());
            return;
        }
        if (e.CommandName == "Edit_space")
        {
            GridDataItem ditem = (GridDataItem)e.Item;
            Guid space_id = new Guid(ditem["space_id"].Text);
            SessionController.Users_.facilityID = Convert.ToString(ditem["fk_facility_id"].Text);
            //Guid space_id = new Guid(Convert.ToString(e.Item.Cells[2].Text));
            //SessionController.Users_.facilityID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_facility_id"].ToString();
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?IsFromSpace=y&pagevalue=Space Profile&id=" + space_id + "&profileflag=new");
        }
        if (e.CommandName == "Edit_floor")
        {
            GridDataItem ditem = (GridDataItem)e.Item;
            Guid floor_id = new Guid(ditem["floor_id"].Text);
            SessionController.Users_.facilityID = Convert.ToString(ditem["fk_facility_id"].Text);
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?pagevalue=Floor Profile&IsFromFloor=y&id=" + floor_id);
        }

        if (e.CommandName == "Assign_space")
        {
            //string zone_id = Convert.ToString(e.Item.Cells[3].Text);
            GridDataItem ditem = (GridDataItem)e.Item;
            string zone_id = Convert.ToString(ditem["pk_zone_id"].Text);
            string url = "../Locations/AssignSpace.aspx?id=" + zone_id + "&flag=zonepm";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script1", "AssignSpace_popup('" + url + "');", true);
        }
        if (e.CommandName == "Unassign_space")
        {
            GridDataItem ditem = (GridDataItem)e.Item;
            Guid space_id = new Guid(ditem["space_id"].Text);
            FacilityClient objfacctrl = new FacilityClient();
            FacilityModel objfacmdl = new FacilityModel();

            objfacmdl.Facility_Ids = Convert.ToString(space_id);
            objfacctrl.UnassignSpacesPM(objfacmdl, SessionController.ConnectionString);
            rg_zone.Rebind();

        }
        if (e.CommandName == "BIM")
        {

            //string space_id = Convert.ToString(e.Item.Cells[2].Text);
            GridDataItem ditem = (GridDataItem)e.Item;
            string space_id = ditem["space_id"].Text;
            string url_db = string.Empty;

            FacilityClient lc = new FacilityClient();
            FacilityModel lm = new FacilityModel();
            DataSet ds = new DataSet();

            lm.Space_Id = new Guid(space_id);
            ds = lc.GetModelUrlSpacePM(lm, SessionController.ConnectionString);

            if (ds.Tables[0].Rows.Count > 0)
            {
                url_db = Convert.ToString(ds.Tables[0].Rows[0]["URL"]);
                if (url_db != null && url_db != "")
                {
                    System.Text.StringBuilder navigation_url = new System.Text.StringBuilder();
                    navigation_url.Append(Convert.ToString(Request.Url.GetLeftPart(UriPartial.Authority)));

                    if (Convert.ToString(Request.ApplicationPath) == "" || Convert.ToString(Request.ApplicationPath) == "/" || Convert.ToString(Request.ApplicationPath) == "//")
                    {
                        navigation_url.Append("/");
                        navigation_url.Append(url_db);
                    }
                    else
                    {
                        navigation_url.Append(Convert.ToString(Request.ApplicationPath));
                        navigation_url.Append(url_db);
                    }

                    Response.Redirect(Convert.ToString(navigation_url));
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script1", "validate_space();", true);
                }
            }

            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script1", "validate_space();", true);
            }

        }

    }


    protected void rg_zone_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem ditem = (GridDataItem)e.Item;
            if (ditem.GetDataKeyValue("pk_zone_id") != null)
            {
                string color_code = ditem["color_code"].Text;



                if (color_code != "&nbsp;" && color_code != null && color_code.Contains(','))
                {
                    
                    string[] array = color_code.Split(',');

                    int Redvalue = Convert.ToInt32(Convert.ToDouble(array[0]) * 255);
                    int greenValue = Convert.ToInt32(Convert.ToDouble(array[1]) * 255);

                    int bluevalue = Convert.ToInt32(Convert.ToDouble(array[2]) * 255);
                    Color myColor = Color.FromArgb(0,Redvalue ,greenValue ,bluevalue);
                        

                    string hex ="#"+ myColor.R.ToString("X2") + myColor.G.ToString("X2") + myColor.B.ToString("x2");
                    ImageButton btn = (ImageButton)e.Item.FindControl("btn_color_select");
                    btn.Style.Add("background-color", hex);
                }
            }
        }
    }


    /// Assign spaces for zone 
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_assign_spaces_Click(object sender, EventArgs e)
    {
        string space_ids = Convert.ToString(hf_selected_id.Value);
        string space_names = Convert.ToString(hf_selected_name.Value);

        string[] ids = new string[100];
        ids = space_ids.Split(',');

        string[] names = new string[100];
        names = space_names.Split(',');

        LocationsClient loc_ctrl = new Locations.LocationsClient();
        LocationsModel loc_mdl = new Locations.LocationsModel();

        loc_mdl.Location_id = new Guid(hf_zone_id.Value.ToString());
        loc_mdl.Space_ids = hf_selected_id.Value.ToString();

        loc_ctrl.assign_spaces_for_zone(loc_mdl, SessionController.ConnectionString);

        rg_zone.Rebind();

    }
    /*--new methods for hierarchical grid changes --*/

    protected void btn_save_Click(object sender, EventArgs e)
    {
        string color_code = ColorTranslator.ToHtml(RadColorPicker1.SelectedColor);
        LocationsClient loc_ctrl = new Locations.LocationsClient();
        LocationsModel loc_mdl = new Locations.LocationsModel();
        DataSet ds_response = new DataSet();
        loc_mdl.Entity_id = new Guid(hf_entity_id.Value);
        loc_mdl.Zone_id = new Guid(hf_pk_zone_id.Value);
        System.Drawing.Color myColor = System.Drawing.Color.FromArgb(0,RadColorPicker1.SelectedColor);
        double redvalue = (( Convert.ToDouble(myColor.R))/255);
        double greenvalue = (( Convert.ToDouble(myColor.G))/255);
        double bluevalue = (( Convert.ToDouble(myColor.B))/255);

        loc_mdl.Color_code = redvalue.ToString() + "," + greenvalue.ToString() + "," + bluevalue.ToString();
        loc_mdl.User_id =new Guid (SessionController.Users_.UserId);
        ds_response = loc_ctrl.insert_update_entity_color(loc_mdl, SessionController.ConnectionString);
        rg_zone.Rebind();
    }

    #region not in ues

    //protected void btndelete_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        if (rgzones.SelectedItems.Count > 0)
    //        {
    //            System.Text.StringBuilder strSystemIds = new System.Text.StringBuilder();

    //            for (int i = 0; i < rgzones.SelectedItems.Count; i++)
    //            {
    //                strSystemIds.Append(rgzones.SelectedItems[i].Cells[2].Text);
    //                strSystemIds.Append(",");
    //            }

    //            string fac_ids = strSystemIds.ToString();
    //            if (fac_ids.Length > 0)
    //            {
    //                fac_ids = fac_ids.Remove(fac_ids.ToString().Length - 1, 1);
    //            }
    //            FacilityModel fm = new Facility.FacilityModel();
    //            FacilityClient fc = new Facility.FacilityClient();
    //            fm.Facility_Ids = fac_ids;
    //            fm.Entity = "Zone";
    //            fc.delete_facility_pm(fm, SessionController.ConnectionString);
    //            BindZones();
    //        }
    //        //else
    //        //{
    //        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
    //        //}
    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //}
    //protected void BindZones()
    //{
    //    FacilityClient lc = new FacilityClient();
    //    FacilityModel lm = new FacilityModel();
    //    DataSet ds = new DataSet();
    //    try
    //    {
    //        System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
    //        System.Text.StringBuilder selectedfacilitynames = new System.Text.StringBuilder();


    //        foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
    //        {
    //            if (((CheckBox)rcbItem.FindControl("CheckBox2")).Checked)
    //            {
    //                facilityvalues.Append(rcbItem.Value);
    //                facilityvalues.Append(",");

    //                selectedfacilitynames.Append(rcbItem.Text);
    //                selectedfacilitynames.Append(",");

    //            }
    //        }
    //        if (facilityvalues.Length > 0)
    //        {
    //            facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
    //        }
    //        if (selectedfacilitynames.ToString().Length > 0)
    //        {
    //            selectedfacilitynames = selectedfacilitynames.Remove(selectedfacilitynames.ToString().Length - 1, 1);
    //        }



    //        lm.Facility_Ids = facilityvalues.ToString();

    //        SessionController.Users_.ZoneFacilities = facilityvalues.ToString();

    //        SessionController.Users_.ZoneSelectedFacilities = selectedfacilitynames.ToString();


    //        //lm.Project_id = new Guid(SessionController.Users_.ProjectId);
    //        //lm.Facility_id= new Guid(cmbfacility.SelectedValue.ToString());
    //        lm.Search_text_name = txt_search.Text;
    //        ds = lc.Get_Zones_For_Facility(lm, SessionController.ConnectionString);

    //        rgzones.AllowCustomPaging = true;
    //        // rgdocument.AllowPaging = true;
    //        if (tempPageSize != "")
    //            rgzones.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
    //        rgzones.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));

    //        rgzones.DataSource = ds;
    //        rgzones.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    //protected void rgzones_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    //{

    //    if (e.CommandName == "Edit")
    //    {
    //        string id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["zone_id"].ToString();
    //        string fk_facility_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["fk_facility_id"].ToString();

    //        zonename = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["zone_name"].ToString();
    //        SessionController.Users_.facilityID = fk_facility_id.ToString();
    //        Response.Redirect("FacilityMenu.aspx?IsFromZone=Y&name=" + zonename + "&pagevalue=Zone Profile&id=" + id.ToString());
    //    }
    //    else
    //    {
    //        if (e.CommandName == "deleteZone")
    //        {
    //            Guid zone_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["zone_id"].ToString());
    //            LocationsClient loc_ctrl = new LocationsClient();
    //            LocationsModel loc_mdl = new LocationsModel();
    //            //loc_mdl.Facility_id = new Guid(SessionController.Users_.facilityID);
    //            loc_mdl.Zone_id = zone_id;
    //            //loc_mdl.Description = SessionController.Users_.Spaceflag;
    //            loc_ctrl.Delete_Zone(loc_mdl, SessionController.ConnectionString);
    //            BindZones();
    //        }
    //    }
    //}

    //protected void rgzones_OnItemDataBound(object sender, GridItemEventArgs e)
    //{
    //    try
    //    {

    //        if (e.Item is GridPagerItem)
    //        {

    //            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
    //            cb.Items.Sort(new PagerRadComboBoxItemComparer());
    //            if (tempPageSize != "")
    //            {
    //                cb.Items.FindItemByValue(tempPageSize).Selected = true;
    //            }


    //        }

    //        if (e.Item is GridHeaderItem)
    //        {
    //            GridHeaderItem headerItem = e.Item as GridHeaderItem;

    //            foreach (GridColumn column in rgzones.MasterTableView.RenderColumns)
    //            {
    //                if (column is GridBoundColumn)
    //                {
    //                    if (column.HeaderText != "")
    //                        (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

    //                }
    //                if (column is GridButtonColumn)
    //                {
    //                    //if the sorting feature of the grid is enabled
    //                    if (column.HeaderText != "")
    //                        (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

    //                }
    //                if (column is GridTemplateColumn)
    //                {
    //                    //if the sorting feature of the grid is enabled
    //                    if (column.HeaderText != "")
    //                        (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

    //                }
    //            }
    //        }

    //        if (e.Item is GridDataItem)
    //        {
    //            GridDataItem gridItem = e.Item as GridDataItem;
    //            foreach (GridColumn column in rgzones.MasterTableView.RenderColumns)
    //            {
    //                if (column is GridBoundColumn)
    //                {
    //                    //this line will show a tooltip based type of Databound for grid data field
    //                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "linkfacility")
    //                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[4].ToString());
    //                    else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "description")
    //                    {
    //                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2].ToString());
    //                    }

    //                }
    //                else if (column is GridButtonColumn)
    //                {
    //                    //this line will show a tooltip based type of linkbutton for grid data field
    //                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.OrderIndex != 3)
    //                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());

    //                }
    //                else if (column is GridTemplateColumn)
    //                {
    //                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName != "location_id")
    //                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
    //                    else
    //                    {
    //                        GridDataItem item = (GridDataItem)e.Item;
    //                        ImageButton lbl = (ImageButton)item.FindControl("imgbtnDelete");
    //                        // string value = lbl.Text;
    //                        gridItem[column.UniqueName].ToolTip = "Delete";// Convert.ToString((Label)gridItem.FindControl("lblDocName"));
    //                    }
    //                }
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }

    //}

    //protected void rgzones_PageIndexChanged1(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    //{
    //    BindZones();

    //    flag = false;
    //}

    //protected void rgzones_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    //{
    //    tempPageSize = e.NewPageSize.ToString();
    //    if (!flag)
    //    {
    //        flag = true;
    //        BindZones();
    //    }

    //}

    //protected void rgzones_SortCommand(object source, GridSortCommandEventArgs e)
    //{
    //    BindZones();
    //}

    #endregion


}