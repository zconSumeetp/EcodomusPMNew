using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Locations;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;


public partial class App_Locations_FindLocation : System.Web.UI.Page
{
    protected void Page_Prerender(object sender, EventArgs e)
    {

        BindGrid();

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
              txtcriteria.Attributes.Add("onKeyPress","doClick('" + btnsearch.ClientID+ "',event)");
            if (SessionController.Users_.UserId != null)
            {
                CheckBox chk_facility = (CheckBox)Master.FindControl("chkfacility");
                if (chk_facility.Checked == true)
                {
                    cmbfacility.SelectedValue = SessionController.Users_.facilityID;
                    cmbfacility.Enabled = false;
                    SessionController.Users_.IsFacility="yes";
                    uncheckFacility();
                   
                }
                else
                {
                   cmbfacility.Enabled = true;
                   cmbfacility.SelectedValue = Guid.Empty.ToString();
                   cmbfacility.Text = "";
                   SessionController.Users_.IsFacility = "no";
                  
                }
                if (!IsPostBack)
                {
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "Name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rglocation.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    BindFacility();
                    BindLocation(); BindGrid();
                }

            }
        }
        catch (Exception ex)
        {

        }
    }

    // Bind facilities to facility Dropdown according to user
    private void BindFacility()
    {
        try
        {
            DataSet ds_facility = new DataSet();
            LocationsClient locObj_crtl = new LocationsClient();
            LocationsModel locObj_mdl = new LocationsModel();
            locObj_mdl.User_id = new Guid(SessionController.Users_.UserId);
            ds_facility = locObj_crtl.Get_Facility(SessionController.ConnectionString, locObj_mdl);
            cmbfacility.DataTextField = "name";
            cmbfacility.DataValueField = "ID";
            cmbfacility.DataSource = ds_facility;
            cmbfacility.DataBind();
           // cmbfacility.SelectedIndex=0;
          
          
        }
        catch (Exception ex)
        {
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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

    // Bind Locations to Location dropdown
    private void BindLocation()
    {
        DataSet ds_location = new DataSet();
        LocationsClient locObj_crtl = new LocationsClient();
        ds_location = locObj_crtl.GetentityLocation(SessionController.ConnectionString);
        cmblocation.DataTextField = "entity_name";
        cmblocation.DataValueField = "pk_entity_id";
        cmblocation.DataSource = ds_location;
        cmblocation.DataBind();
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
    protected void rglocation_SortCommand(object source, GridSortCommandEventArgs e)
    {
        try
        {
            BindGrid();
        }
        catch (Exception ex)
        {
        }
    }

    // bind Location Grid according to search criteria
    protected void BindGrid()
    {
        try
        {
            LocationsModel objloc_mdl = new LocationsModel();
            LocationsClient objloc_crtl = new LocationsClient();
            DataSet ds_Search_facility = new DataSet();
            objloc_mdl.LocationName = cmblocation.SelectedItem.Text;
            objloc_mdl.CriteriaName = cmbcriteria.SelectedItem.Text;
            objloc_mdl.CriteriaText = txtcriteria.Text.Trim();
            objloc_mdl.User_id = new Guid(SessionController.Users_.UserId.ToString());

            if (SessionController.Users_.IsFacility == "yes")
            {
                objloc_mdl.FacilityNames = SessionController.Users_.facilityID;
            }
            else
            {
                System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
                foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
                    {
                        facilityvalues.Append(rcbItem.Value);
                        facilityvalues.Append(",");
                    }
                }
                if (facilityvalues.ToString().Length > 0)
                {
                    facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
                }
                objloc_mdl.FacilityNames = facilityvalues.ToString();
                cmbfacility.Text = hf_cmb_text.Value.ToString();
            }

            ds_Search_facility = objloc_crtl.Search_Location(SessionController.ConnectionString, objloc_mdl);

            rglocation.DataSource = ds_Search_facility;
            rglocation.DataBind();
            rglocation.Visible = true;
            
        }
        catch (Exception ex)
        {
        }
    }

    // to unchacked the cmbfacility check box
    protected void uncheckFacility()
    {
        foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
        {
            if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
            {
                ((CheckBox)rcbItem.FindControl("CheckBox1")).Checked = false;

            }
        }
        hf_cmb_text.Value = "";
    }

    protected void rglocation_PreRender(object sender, EventArgs e)
    {
        if (rglocation.Visible == true)
        {
            if (cmblocation.SelectedItem.Text == "Facility")
            {
                foreach (GridColumn col in rglocation.Columns)
                {
                    if (col.UniqueName == "floor" || col.UniqueName == "facility" || col.UniqueName == "locationId")
                    {
                        col.Visible = false;
                    }
                }
            }
            else if (cmblocation.SelectedItem.Text == "Floor" || cmblocation.SelectedItem.Text == "Zone")
            {
                foreach (GridColumn col in rglocation.Columns)
                {
                    if (col.UniqueName == "floor" || col.UniqueName == "locationId")
                    {
                        col.Visible = false;
                       
                    }
                    else
                        col.Visible = true;
                }
               
            }
            else
            {
                foreach (GridColumn col in rglocation.Columns)
                {
                    if (col.UniqueName == "locationId")
                    {
                        col.Visible = false;
                    }
                    else
                        col.Visible = true;
                }
              
            }
        }
    }

    protected void cmblocation_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        rglocation.Visible = false;
       

        if (cmblocation.SelectedItem.Text != "Facility")
        {
          
            if (SessionController.Users_.IsFacility == "yes")
            {
               
                cmbfacility.Visible = true;
                lblfacility.Visible = true;
                cmbfacility.SelectedValue = SessionController.Users_.facilityID;
                cmbfacility.Enabled = false;
                if (cmblocation.SelectedItem.Text == "Floor")
                {
                    btn_floor.Visible = true;
                    btn_facility.Visible = false;
                    btn_space.Visible = false;
                    btn_zone.Visible = false;
                }
                else if (cmblocation.SelectedItem.Text == "Space")
                {
                    btn_space.Visible = true;
                    btn_floor.Visible = false;
                    btn_facility.Visible = false;
                    btn_zone.Visible = false;
                }
                else if (cmblocation.SelectedItem.Text == "Zone")
                {
                    btn_space.Visible = false;
                    btn_floor.Visible = false;
                    btn_zone.Visible = true;
                    btn_facility.Visible = false;
                }
            }
            else
            {
               // BindFacility();
                cmbfacility.Visible = true;
                lblfacility.Visible = true;
                cmbfacility.Enabled = true;
               
            }
        }
        else
        {
            cmbfacility.Visible = false;
            lblfacility.Visible = false;
        }
        BindGrid();
    }

    protected void rglocation_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            string facilityid;
            string FacilityName;
            string floorid = "";
            LocationsModel locObj_mdl = new LocationsModel();
            LocationsClient locObj_crtl = new LocationsClient();
            DataSet ds_location = new DataSet();
            locObj_mdl.Location_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["LocationId"].ToString());

            string id = locObj_mdl.Location_id.ToString();
            string name = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Name"].ToString();
            if (cmblocation.SelectedItem.Text == "Facility")
            {
                ds_location = locObj_crtl.Get_Location_Facility(SessionController.ConnectionString, locObj_mdl);
                facilityid = ds_location.Tables[0].Rows[0]["pk_facility_id"].ToString();
                FacilityName = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Name"].ToString();
            }
            else
            {
                ds_location = locObj_crtl.Get_Location(SessionController.ConnectionString, locObj_mdl);
                floorid = ds_location.Tables[0].Rows[0]["fk_location_parent_id"].ToString();
                facilityid = ds_location.Tables[0].Rows[0]["fk_facility_id"].ToString();
                FacilityName = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["FacilityName"].ToString();
            }
            if (e.CommandName == "delete")
            {
                locObj_mdl.Entity_id = new Guid(cmblocation.SelectedValue.ToString());
                locObj_crtl.delete_Location(SessionController.ConnectionString, locObj_mdl);
            }

            if (e.CommandName == "locationprofile")
            {
                if (cmblocation.SelectedItem.Text == "Facility")
                {
                    SessionController.Users_.facilityID = facilityid;
                    SessionController.Users_.facilityName = FacilityName;
                    Response.Redirect("FacilityMenu.aspx?facilityid=" + facilityid);
                }
                else if (cmblocation.SelectedItem.Text == "Floor")
                    Response.Redirect("FacilityMenu.aspx?pagevalue=Floor Profile&id=" + id);
                else if (cmblocation.SelectedItem.Text == "Space")
                    Response.Redirect("FacilityMenu.aspx?pagevalue=Space Profile&id=" + id);
                else if (cmblocation.SelectedItem.Text == "Zone")
                    Response.Redirect("FacilityMenu.aspx?pagevalue=Zone Profile&id=" + id +"&name="+ name);
            }

            if (e.CommandName == "facilityprofile")  
            {
                SessionController.Users_.facilityID = facilityid;
                SessionController.Users_.facilityName = FacilityName;
                Response.Redirect("FacilityMenu.aspx?id=" + facilityid);
            }
            if (e.CommandName == "floorprofile")
            {
                Response.Redirect("FacilityMenu.aspx?pagevalue=Floor Profile&id=" + floorid);
            }

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

    protected void btn_space_click(object sender, EventArgs e)
    {        
        hf_location_id.Value = Guid.Empty.ToString();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_space();", true);
    }

    protected void btn_floor_click(object sender, EventArgs e)
    {
        hf_location_id.Value = Guid.Empty.ToString();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_floor();", true);
    }
    protected void btn_zone_Click(object sender, EventArgs e)
    {
        hf_location_id.Value = Guid.Empty.ToString();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "navigate_zone();", true);
    }

    protected void btn_facility_click(object sender,EventArgs e)
    {
        SessionController.Users_.facilityID = null;
        Response.Redirect("~/App/Locations/FacilityMenu.aspx", false);

    }
  }


