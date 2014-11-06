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


public partial class App_Settings_FloorProfile : System.Web.UI.Page
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
                    if (!IsPostBack)
                    {
                        bind_facility_pm();
                        Bind_Category();
                    }
                    hflocationid.Value = Request.QueryString["id"].ToString();
                    if (hflocationid.Value == Guid.Empty.ToString())
                    {
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
        }
        catch (Exception ex)
        {
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
        //if (btnsave.Text == "Edit")
        if (btnsave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
            
        {
            lblDescription.Visible = false;
            txtfloorname.Visible = true;
            txtdescription.Visible = true;
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
            //btnsave.Text = "Save";
            btnsave.Text = (string)GetGlobalResourceObject("Resource", "Save");
            
            Bind_Category();
            if (lblcategory.Text != "N/A")
            {
                if (lblcategory.Text != "")
                cmbcategory.FindItemByText(lblcategory.Text).Selected = true;
            }
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
                Insert_Update_FloorProfile();
            }
        }
    }

    protected override void InitializeCulture()
    {
        string culture = Session["Culture"].ToString();
        if (culture == null)
        {
            culture = "en-US";
        }
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
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
