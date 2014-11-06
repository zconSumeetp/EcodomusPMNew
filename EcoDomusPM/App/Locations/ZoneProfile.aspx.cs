using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using EcoDomus.Session;
using Facility;
using Locations;
using System.Threading;
using System.Globalization;



public partial class App_Locations_ZoneProfile : System.Web.UI.Page
{
    #region Page Load
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //Comman.DisablePageCaching();
            if (SessionController.Users_.UserId != null)
            {
                hflocationid.Value = Request.QueryString["id"].ToString();
                hfzonename.Value = Request.QueryString["name"].ToString();
                
                if (!IsPostBack)
                {
                    
                    Get_ZoneProfile();
                    
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
            throw ex;
        }
    }
    #endregion

    #region Methods for procedure call
    //To go to zone profile of that particular zone,when we click on zone name link:-
    protected void Get_ZoneProfile()
    {
        try
        {

            if (hflocationid.Value != Guid.Empty.ToString())
            {
                LocationsModel objloc_mdl = new LocationsModel();
                LocationsClient locObj_crtl = new LocationsClient();
                objloc_mdl.Location_id = new Guid(hflocationid.Value);//new Guid(Request.QueryString["id"].ToString());
                DataSet ds_get_zoneprofile = new DataSet();
                ds_get_zoneprofile = locObj_crtl.Get_Zone_Profile_by_ID(SessionController.ConnectionString, objloc_mdl);



                lblfacility.Visible = true;
                lblzonename.Visible = true;
                lbldescription.Visible = true;
                lblcategory.Visible = true;

                txtzonename.Visible = false;
                txtdescription.Visible = false;
                txtcategory.Visible = false;
                cmbfacility.Visible = false;

                //btnSave.Text = "Edit";
                btnSave.Visible = false;
                btnDelete.Visible = true;
                btnEdit.Visible = true;
                btnCancel.Visible = false;
                

                hfzonename.Value = ds_get_zoneprofile.Tables[0].Rows[0]["ZoneName"].ToString();
                lblzonename.Text = ds_get_zoneprofile.Tables[0].Rows[0]["ZoneName"].ToString();
                lbldescription.Text = ds_get_zoneprofile.Tables[0].Rows[0]["Description"].ToString();
                lblfacility.Text = ds_get_zoneprofile.Tables[0].Rows[0]["FacilityName"].ToString();
                lblcategory.Text = ds_get_zoneprofile.Tables[0].Rows[0]["category"].ToString();

                hfzonename.Value = lblzonename.Text;

                SessionController.Users_.facilityID = ds_get_zoneprofile.Tables[0].Rows[0]["FacilityId"].ToString();
                //ViewState["facility_id"] = ds_get_zoneprofile.Tables[0].Rows[0]["FacilityId"].ToString();
                SessionController.Users_.facilityName = ds_get_zoneprofile.Tables[0].Rows[0]["FacilityName"].ToString();

            }
            else
            {
                cmbfacility.Visible = true;
                btnSave.Visible = true;
                btnEdit.Visible = false;
                btnCancel.Visible = true;
                btnDelete.Visible = false;
                if (SessionController.Users_.is_PM_FM == "PM")
                {
                    bind_facility_pm();
                }
                else
                {
                    BindFacility();
                   
                }
                hflocationid.Value = Guid.Empty.ToString();
                
            }
        }
        catch (Exception ex)
        {
            throw ex;

        }
    }

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

            if (SessionController.Users_.IsFacility == "yes")
            {
                cmbfacility.Visible = true;
                lblfacility.Visible = true;
                cmbfacility.SelectedValue = SessionController.Users_.facilityID;
                cmbfacility.Enabled = false;
            }
            else
            {
                cmbfacility.Visible = true;
                lblfacility.Visible = true;
                cmbfacility.Enabled = true;
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

    private void Insert_Update_ZoneProfile()
    {
        try
        {
            DataSet ds_zone_id = new DataSet();
            LocationsClient locobj_crtl = new LocationsClient();
            LocationsModel locobj_mdl = new LocationsModel();
            locobj_mdl.Location_id = new Guid(hflocationid.Value);
            SessionController.Users_.facilityID = cmbfacility.SelectedValue.ToString();
            hfFacility_id.Value = cmbfacility.SelectedValue.ToString();
            //locobj_mdl.facility_ID = new Guid(ViewState["facility_id"].ToString());

            //if (SessionController.Users_.is_PM_FM == "FM")
            //{
            //    locobj_mdl.facility_ID = new Guid(SessionController.Users_.facilityID);
            //}
            //else 
            //{
                locobj_mdl.facility_ID =new Guid(cmbfacility.SelectedValue.ToString());
            //}
            locobj_mdl.LocationName = txtzonename.Text;
            locobj_mdl.Description = txtdescription.Text;
            locobj_mdl.category_name = txtcategory.Text;
            locobj_mdl.User_id = new Guid(SessionController.Users_.UserId.ToString());

            ds_zone_id=locobj_crtl.proc_insert_update_zone_profile(SessionController.ConnectionString, locobj_mdl);
            hflocationid.Value = ds_zone_id.Tables[0].Rows[0]["id"].ToString();
            //Request.QueryString["id"] = hflocationid.Value;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region EventHandlers
    //To save the changes made in zone profile:-    
    protected void btnsave_click(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {


                //if (SessionController.Users_.facilityID == Guid.Empty.ToString())
                //{
                //    SessionController.Users_.facilityID = cmbfacility.SelectedValue.ToString();
                //}
                Insert_Update_ZoneProfile();
                if (SessionController.Users_.is_PM_FM == "PM")
                {
                    hfzonename.Value = txtzonename.Text;
                    //Response.Redirect("ZoneProfile.aspx?id=" + hflocationid.Value.ToString() + "&name=" + hfzonename.Value.ToString());
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_zone_profile_pm();", true);
                    //Response.Redirect("FacilityMenu.aspx?pagevalue=Zone Profile&id=" + hflocationid.Value.ToString());
                }
                else
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_zone_profile_pm();", true);
                    //Get_ZoneProfile();
                }
                //lblfacilityheading.Visible = false;
                //lblfacility.Visible = false;
                //lblzonename.Visible = false;
                //lblzoneheading.Visible = false;
                btnSave.Visible = false;
                btnEdit.Visible = true;
                btnDelete.Visible = true;
                btnCancel.Visible = false;
                //divfacility.Visible = false;


            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
   
    //To update profile of any zone:-
    protected void btncancel_Click(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.is_PM_FM == "PM")
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ZonePM", "NavigateToZonePM();", true);
            else if (btnSave.Text == "Save")
                if(hflocationid.Value.ToString()==Guid.Empty.ToString())
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "NavigateToFindLocation();", true);
                else 
                Response.Redirect("ZoneProfile.aspx?id=" + hflocationid.Value.ToString() + "&name=" + hfzonename.Value.ToString());

            else if (btnSave.Text == "Edit" && SessionController.Users_.is_PM_FM == "FM")
                ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "NavigateToFindLocation();", true);

           
        }
        catch (Exception ex)
        {
            throw ex;
        }
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

    protected void btnedit_click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            lblzonename.Visible = false;
            lbldescription.Visible = false;
            lblcategory.Visible = false;

            txtzonename.Visible = true;
            txtdescription.Visible = true;
            txtcategory.Visible = true;
            if (SessionController.Users_.is_PM_FM == "FM")
            {

                //cmbfacility.Visible = false;
                BindFacility();
                lblfacility.Visible = false;
            }
            else
            {
                cmbfacility.Visible = true;
                lblfacility.Visible = false;
                lblfacilityheading.Visible = true;
                //divfacility.Visible = true;
                bind_facility_pm();
                cmbfacility.SelectedValue = SessionController.Users_.facilityID.ToString();
            }

            txtzonename.Text = lblzonename.Text;
            txtdescription.Text = lbldescription.Text;
            txtcategory.Text = lblcategory.Text;

            btnSave.Visible = true;
            btnEdit.Visible = false;
            btnCancel.Visible = true;
            btnDelete.Visible = false;
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
protected void  btnDelete_Click(object sender, EventArgs e)
{
    LocationsModel lm = new LocationsModel();
    LocationsClient lc = new LocationsClient();
    
    lm.Zone_id = new Guid(hflocationid.Value.ToString());
    lc.Delete_Zone(lm, SessionController.ConnectionString);
    ScriptManager.RegisterStartupScript(this, this.GetType(), "ZonePM", "NavigateToZonePM();", true);
    
}
}  // class closed.