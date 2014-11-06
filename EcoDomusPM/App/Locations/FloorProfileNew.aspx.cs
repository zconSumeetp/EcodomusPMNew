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
using System.Text;
using System.Threading;
using System.Globalization;
using Facility;


public partial class App_Settings_FloorProfileNew : System.Web.UI.Page
{

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
        }
        catch (Exception)
        {

        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (Request.QueryString["popupflag"] == "popup")
                {
                    hfpopupflag.Value = "popup";
                    tblHeader.Style.Value = "dispaly:inline; margin: 2px 0px 2px 2px;";

                    Label1.Visible = true;
                    Label1.Text = "Floor Profile";
                   // divProfilePage.Style.Add("margin-left", "30px");
                    btnclose.Visible = true;
                }
                else
                {
                    //divFloorName.Style["display"] = "inline";
                   
                   // lblpoupmsg.Visible = false;
                    btnclose.Visible = false;

                }
                if (SessionController.Users_.is_PM_FM == "FM")
                {
                    hflocationid.Value = Request.QueryString["id"].ToString();

                    if (!IsPostBack)
                    {
                        Bind_Category();
                        if (hflocationid.Value == Guid.Empty.ToString())
                        {
                            lblDescription.Visible = false;
                            txtfloorname.Visible = true;
                            txtdescription.Visible = true;
                            cmbfacility.Visible = true;
                            lblfacility.Visible = false;
                            lblfloorname.Visible = false;
                            txtheight.Visible = true;
                            txtelevation.Visible = true;
                            lblcategory.Visible = false;
                            cmbcategory.Visible = true;
                            //btnsave.Text = "Save";
                            btnsave.Text = (string)GetGlobalResourceObject("Resource", "Save");
                            
                            if (lblcategory.Text != "N/A")
                            {
                                if (lblcategory.Text != "")
                                    cmbcategory.FindItemByText(lblcategory.Text).Selected = true;
                            }
                            BindFacility();
                        }
                        else
                        {
                            Get_FloorProfile();
                        }
                    }
                }
                else if (SessionController.Users_.is_PM_FM == "PM")
                {
                    //if (Session["action"] != null)
                    //{
                    //    if (Session["action"].Equals("AddFloor"))
                    //    {

                    //        divFloorName.Style["display"] = "inline";
                    //        Session["action"] = null;
                    //    }
                    //}
                    if (SessionController.Users_.Action != null)
                    {
                        if (SessionController.Users_.Action.Equals("AddFloor"))
                        {
                            divFloorName.Style["display"] = "inline";
                            SessionController.Users_.Action = null;
                        }
                    }

                    if (!IsPostBack)
                    {
                        bind_facility_pm();
                        Bind_Category();

                    }
                    hflocationid.Value = Request.QueryString["id"].ToString();
                    if (hflocationid.Value == Guid.Empty.ToString())
                    {
                        btncancel.Visible = true;
                        btnDelete.Visible = false;
                        lblDescription.Visible = false;
                        txtfloorname.Visible = true;
                        txtdescription.Visible = true;
                        cmbfacility.Visible = true;
                        lblfacility.Visible = true;
                        lblfloorname.Visible = false;
                        txtheight.Visible = true;
                        txtelevation.Visible = true;
                        lblcategory.Visible = false;
                        cmbcategory.Visible = true;
                        divFloorName.Style["display"] = "inline";
                        //txtelevation.Text = lblelevation.Text;
                        //txtheight.Text = lblheight.Text;
                        //txtfloorname.Text = lblfloorname.Text;
                        //txtdescription.Text = lblDescription.Text;
                        //lblheight.Visible = false;
                        //lblelevation.Visible = false;

                        //btnsave.Text = "Save";
                        btnsave.Text = (string)GetGlobalResourceObject("Resource", "Save");
                        
                        if (lblcategory.Text != "N/A")
                        {
                            if (lblcategory.Text != "")
                                cmbcategory.FindItemByText(lblcategory.Text).Selected = true;
                        }
                    }
                    else
                    {
                        if (!IsPostBack)
                        {
                            Get_FloorProfile();
                        }

                    }
                }

            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {

        if (SessionController.Users_.UserSystemRole == "GU")
        {
            btnDelete.Visible = false;
            btnsave.Visible = false;
        }
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
            DataRow dr_component = ds_component.Tables[0].Select("name='Floor'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Floor Profile")
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
        string view_permission = dr["view_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();
        // delete button on component profile
        if (dr["name"].ToString() == "Floor Profile")
        {
            objPermission.SetEditable(btnDelete, delete_permission);
            if (btnsave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
            {
                objPermission.SetEditable(btnsave, edit_permission);
            }
        }
    }

    protected void bind_facility_pm()
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        DataSet ds = new DataSet();
        DataSet ds1 = new DataSet();
        try
        {
            fm.Project_id = new Guid(SessionController.Users_.ProjectId);
            fm.Search_text_name = "";
            fm.Doc_flag = "";
            ds = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                cmbfacility.DataTextField = "name";
                cmbfacility.DataValueField = "pk_facility_id";
                cmbfacility.DataSource = ds;
                cmbfacility.DataBind();
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void Get_FloorProfile()
    {
        try
        {
            LocationsModel objloc_mdl = new LocationsModel();
            LocationsClient locObj_crtl = new LocationsClient();
            objloc_mdl.Location_id = new Guid(Request.QueryString["id"].ToString());

            DataSet ds_get_floorprofile = new DataSet();
            ds_get_floorprofile = locObj_crtl.Get_FloorProfile_byID(SessionController.ConnectionString, objloc_mdl);


            lblfacility.Visible = true;

            lblfloorname.Visible = true;
            lblDescription.Visible = true;
            lblcategory.Visible = true;
            lblelevation.Visible = true;
            lblheight.Visible = true;

            txtfloorname.Visible = false;
            txtelevation.Visible = false;
            txtheight.Visible = false;
            txtdescription.Visible = false;
            
            cmbfacility.Visible = false;
            cmbcategory.Visible = false;
            btncancel.Visible = false;
            //btnsave.Text = "Edit";
            btnsave.Text = (string)GetGlobalResourceObject("Resource", "Edit");

            

            lblDescription.Text = ds_get_floorprofile.Tables[0].Rows[0]["Description"].ToString();
            lblfacility.Text = ds_get_floorprofile.Tables[0].Rows[0]["FacilityName"].ToString();
            lblfloorname.Text = ds_get_floorprofile.Tables[0].Rows[0]["FloorName"].ToString();
            lblelevation.Text = ds_get_floorprofile.Tables[0].Rows[0]["Elevation"].ToString();
            lblheight.Text = ds_get_floorprofile.Tables[0].Rows[0]["Height"].ToString();
            lblcategory.Text = ds_get_floorprofile.Tables[0].Rows[0]["Category"].ToString();

            //if (SessionController.Users_.is_PM_FM == "FM")
          //  {
                SessionController.Users_.facilityID = ds_get_floorprofile.Tables[0].Rows[0]["FacilityId"].ToString();
           // }
            //else
           // {
                cmbfacility.SelectedValue = ds_get_floorprofile.Tables[0].Rows[0]["FacilityId"].ToString();
            //}

            SessionController.Users_.facilityName = ds_get_floorprofile.Tables[0].Rows[0]["FacilityName"].ToString();

        }
        catch (Exception ex)
        {
        }
    }

    private void Bind_Category()
    {
        LocationsClient locobj_crtl = new LocationsClient();
        DataSet ds_bindcategory = new DataSet();
        ds_bindcategory = locobj_crtl.Get_Floor_Category(SessionController.ConnectionString);
        cmbcategory.DataSource = ds_bindcategory;
        cmbcategory.DataTextField = "floor_type";
        cmbcategory.DataValueField = "pk_floor_type_id";
        cmbcategory.DataBind();
    }


    private void Insert_Update_FloorProfile()
    {
        try
        {
            string cmb_facility_value = cmbfacility.SelectedValue.ToString();

            string strcategory;
            if (cmbcategory.SelectedIndex == 0)
                strcategory = "N/A";
            else
                strcategory = cmbcategory.SelectedItem.Text.Trim();
            StringBuilder strAttribute = new StringBuilder();

            strAttribute.Append("<root><folder Name='" + lbl_height.Text.Trim() + "' Value='" + txtheight.Text.Trim() + "'></folder>");
            strAttribute.Append("<folder Name='" + lbl_elevation.Text.Trim() + "' Value='" + txtelevation.Text.Trim() + "'></folder>");
            strAttribute.Append("<folder Name='" + lbl_category.Text.Trim() + "' Value='" + strcategory + "'></folder></root>");
            LocationsClient locobj_crtl = new LocationsClient();
            LocationsModel locobj_mdl = new LocationsModel();
            locobj_mdl.Location_id = new Guid(hflocationid.Value);



            locobj_mdl.LocationName = txtfloorname.Text.ToString();
            locobj_mdl.Description = txtdescription.Text.ToString();

            if (SessionController.Users_.is_PM_FM == "PM")
            {
                locobj_mdl.facility_ID = new Guid(cmb_facility_value.ToString());
            }
            else
            {
                locobj_mdl.facility_ID =new Guid(SessionController.Users_.facilityID.ToString());
            }

            locobj_mdl.AttributeValue = strAttribute.ToString().Replace("'", "\"");
            
            locobj_mdl.Omniclass_type = null;

            locobj_mdl.User_id = new Guid(SessionController.Users_.UserId.ToString());
            locobj_mdl.Fk_uploaded_file_id = Guid.Empty;

            if (SessionController.Users_.is_PM_FM == "FM")
            {
                DataSet ds1 = new DataSet();
                ds1=locobj_crtl.proc_insert_update_floor_profile(SessionController.ConnectionString, locobj_mdl);
                if (ds1.Tables[0].Rows[0]["pk_location_id"].ToString() == Guid.Empty.ToString())
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
                }
                else
                {
                    string id = ds1.Tables[0].Rows[0]["pk_location_id"].ToString();
                    hf_floor_id.Value = id;
                    hf_facility_id.Value = cmb_facility_value.ToString();
                    SessionController.Users_.facilityID = hf_facility_id.Value;
                    if(hfpopupflag.Value=="popup")
                        ScriptManager.RegisterStartupScript(this,this.GetType(),"script1", "navigate_floorpopup();", true);
                    else
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_floor();", true);
                }
            }
            else
            {
                DataSet ds = new DataSet();
                ds = locobj_crtl.proc_insert_update_floor_profile(SessionController.ConnectionString, locobj_mdl);
                if (ds.Tables[0].Rows[0]["pk_location_id"].ToString() == Guid.Empty.ToString())
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
                }
                else
                {
                    string id = ds.Tables[0].Rows[0]["pk_location_id"].ToString();
                    hf_floor_id.Value = id;
                    hf_facility_id.Value = cmb_facility_value.ToString();
                    SessionController.Users_.facilityID = hf_facility_id.Value;
                    if (hfpopupflag.Value == "popup")
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "javascript:navigate_floorpopup();", true);
                    else
                         ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_floor();", true);
                }
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            //if (btnsave.Text == "Edit")
            if (btnsave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
                
            {
                lblDescription.Visible = false;
                txtfloorname.Visible = true;
                btnDelete.Visible = true;
                btncancel.Visible = false;
                txtdescription.Visible = true;
                divFloorName.Style["display"] = "inline";
                if (SessionController.Users_.is_PM_FM == "FM")
                {
                    cmbfacility.SelectedValue = SessionController.Users_.facilityID.ToString();
                    cmbfacility.Visible = true;
                    lblfacility.Visible = false;
                    BindFacility();
                }
                else if (SessionController.Users_.is_PM_FM == "PM")
                {

                    cmbfacility.Visible = true;
                    lblfacility.Visible = false;
                    bind_facility_pm();
                    cmbfacility.SelectedValue = SessionController.Users_.facilityID.ToString();

                }
                lblfloorname.Visible = false;
                txtheight.Visible = true;
                txtelevation.Visible = true;
                lblcategory.Visible = false;
                cmbcategory.Visible = true;
                txtelevation.Text = lblelevation.Text;
                txtheight.Text = lblheight.Text;
                txtfloorname.Text = lblfloorname.Text;
                txtdescription.Text = lblDescription.Text;
                lblheight.Visible = false;
                lblelevation.Visible = false;
                btncancel.Visible = true;
                btnDelete.Visible = false;
                //btnsave.Text = "Save";
                btnsave.Text = (string)GetGlobalResourceObject("Resource", "Save");
                
                Bind_Category();
                if (lblcategory.Text != "N/A")
                {
                    if (lblcategory.Text != "")
                        cmbcategory.FindItemByText(lblcategory.Text).Selected = true;
                }
                // divFloorName.Style["display"] = "none";
                //Response.Redirect("FloorProfile.aspx?id="+hflocationid.Value.ToString());
            }

            //else if (btnsave.Text == "Save")
            else if (btnsave.Text == (string)GetGlobalResourceObject("Resource", "Save"))
                
            {
                if (SessionController.Users_.is_PM_FM == "FM")
                {
                    Insert_Update_FloorProfile();
                    //Get_FloorProfile();
                }
                else if (SessionController.Users_.is_PM_FM == "PM")
                {
                    btncancel.Visible = true;
                    btnDelete.Visible = false;
                    Insert_Update_FloorProfile();
                }
            }
        }
        else
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
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
        try
        {
            Response.Redirect(url, false);
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
        

    }

    protected void btnDelete_click(object sender, EventArgs e)
    {
        try
        {

            FacilityModel fm = new Facility.FacilityModel();
            FacilityClient fc = new Facility.FacilityClient();
            fm.Floor_Id = new Guid(hflocationid.Value);
            fc.Delete_Floor(fm, SessionController.ConnectionString);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "FloorsPM", "NavigateToFloorPM();", true);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    
    
    }
    protected void btncancel_Click(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.is_PM_FM == "FM")
            {
                //if (btnsave.Text == "Save")
                if (btnsave.Text == (string)GetGlobalResourceObject("Resource", "Save"))
                    
                    //Response.Redirect("FloorProfile.aspx?id=" + hflocationid.Value.ToString());
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "NavigateToFindLocation();", true);
                //else if (btnsave.Text == "Edit")
                else if (btnsave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
                    
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "NavigateToFindLocation();", true);
            }
            else
            {
                if(hfpopupflag.Value=="popup")
                ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "NavigateToFindLocationPMpopup();", true);
                else
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "NavigateToFindLocationPM();", true);
            }
        }
        catch (Exception ex)
        {
        }
    }

    private void BindFacility()
    {
        DataSet ds_facility = new DataSet();
        LocationsClient locObj_crtl = new LocationsClient();
        LocationsModel locObj_mdl = new LocationsModel();        

            locObj_mdl.User_id = new Guid(SessionController.Users_.UserId.ToString());
            ds_facility = locObj_crtl.Get_Facility(SessionController.ConnectionString, locObj_mdl);
            cmbfacility.DataTextField = "name";
            cmbfacility.DataValueField = "ID";
            cmbfacility.DataSource = ds_facility;
            cmbfacility.DataBind();

            if (SessionController.Users_.IsFacility == "yes")
            {
                cmbfacility.Visible = true;
                lblfacility.Visible = false;
                cmbfacility.SelectedValue = SessionController.Users_.facilityID;
                cmbfacility.Enabled = false;
            }
            else
            {
                cmbfacility.Visible = true;
                lblfacility.Visible = false;
                cmbfacility.Enabled = true;
            }                   
    }

}
