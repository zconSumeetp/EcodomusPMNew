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
using Login;
using System.Text;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Globalization;
using System.Threading;
using EcoDomus.Session;
using SyncAsset;


public partial class App_Settings_SpaceProfile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (Request.QueryString["popupflag"] == "popup")
                {
                    hfpopupflag.Value = "popup";
                    //tbltitle.Style.Value = "display:inline";  
                    // lblpoupmsg.Text = "Space Profile";
                    //lblSpaceProfileName.Visible = true;
                   // divProfilePage.Style.Add("margin-left", "30px");
                   // btnclose.Visible = true;

                }
                else
                {
                    // lblpoupmsg.Visible = false;
                   // tbltitle.Style.Value = "display:none";
                   // btnclose.Visible = false;
                }
                if (SessionController.Users_.is_PM_FM == "FM")
                {
                    hflocationid.Value = Request.QueryString["id"].ToString();
                    if (!IsPostBack)
                    {
                        if (hflocationid.Value == Guid.Empty.ToString())
                        {
                            //BindDocuments();
                            lblspacename.Visible = false;
                            lbldescription.Visible = false;
                            lblcategory.Visible = true;

                            txtspacename.Visible = true;
                            txtdescription.Visible = true;

                            cmbfacility.Visible = true;
                            //cmbfacility.Visible = false;
                            cmbfloorname.Visible = true;
                            cmbfloorname.Enabled = false;

                            lblfacility.Visible = false;
                            //lblfacility.Visible = true;
                            lblfloorname.Visible = false;

                            lnkbtncategory.Visible = true;
                            //rgDocuments.Columns[2].Visible = true;

                            txtspacename.Text = lblspacename.Text;
                            txtdescription.Text = lbldescription.Text;

                            //btnadddocument.Visible = true;
                            //btnsave.Text = "Save";
                            btnsave.Text = (string)GetGlobalResourceObject("Resource", "Save");
                            

                            BindFacility();

                        }
                        else
                        {
                            Get_SpaceProfile();
                            //BindDocuments();
                        }
                    }
                }
                else
                {
                    if (!IsPostBack)
                    {
                        BindFacility();
                        hflocationid.Value = Request.QueryString["id"].ToString();
                        //BindDocuments();
                        if (hflocationid.Value == Guid.Empty.ToString())
                        {
                            if (Request.QueryString["floor_id"].ToString() != "")
                            {
                                Guid  fac_id = new Guid(SessionController.Users_.facilityID.ToString());
                                
                                if (fac_id.ToString() == Guid.Empty.ToString())
                                {

                                    cmbfloorname.Visible = true;
                                    cmbfloorname.Enabled = false;
                                }
                                else
                                {
                                    cmbfacility.SelectedValue = fac_id.ToString();
                                    BindFloors(fac_id);
                                    cmbfloorname.Visible = true;
                                    cmbfloorname.Enabled = true;
                                    cmbfloorname.SelectedValue = Request.QueryString["floor_id"].ToString();

                                }
                               
                                

                            }
                            else {
                                cmbfloorname.Enabled = false;
                            
                            }
                            
                            lblspacename.Visible = false;
                            lbldescription.Visible = false;
                            lblcategory.Visible = true;


                            txtspacename.Visible = true;
                            txtdescription.Visible = true;

                            cmbfacility.Visible = true;
                            cmbfloorname.Visible = true;
                          //  cmbfloorname.Enabled = false;



                            lblfacility.Visible = false;
                            lblfloorname.Visible = false;

                            lnkbtncategory.Visible = true;
                            //rgDocuments.Columns[2].Visible = true;

                            //lblroomtag1.Visible = false;   //2nd May
                            //txtRoomTag1.Visible = false; 
                            //lblRoomtagheading1.Visible = false;


                            txtspacename.Text = lblspacename.Text;
                            txtdescription.Text = lbldescription.Text;

                            //btnadddocument.Visible = true;
                            //btnsave.Text = "Save";
                            btnsave.Text = (string)GetGlobalResourceObject("Resource", "Save");
                            

                        }
                        else
                        {
                            Get_SpaceProfile();
                            //BindDocuments(); 
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

    protected void rgDocument_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            Guid document_id = Guid.Empty;
            if (e.CommandName == "deleteDocument")
            {
                document_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["document_id"].ToString());

                FacilityClient facObjClientCtrl = new FacilityClient();
                FacilityModel facObjFacilityModel = new FacilityModel();
                facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
                facObjFacilityModel.Document_Id = document_id;
                facObjClientCtrl.Delete_Document(facObjFacilityModel, SessionController.ConnectionString);
                //BindDocuments();
            }

            //if (e.CommandName == "ChangePageSize")
            //{
            //    BindDocuments();
            //}
            //if (e.CommandName == "Page")
            //{
            //    BindDocuments();
            //}

        }
        catch (Exception ex)
        {
            //  lblMsg.Text = "rgDocument_ItemCommand:-" + ex.Message;
        }
    }

    private void BindFacility()
    {
        DataSet ds_facility = new DataSet();
        LocationsClient locObj_crtl = new LocationsClient();
        LocationsModel locObj_mdl = new LocationsModel();
        if (SessionController.Users_.is_PM_FM == "FM")
        {

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
            BindFloors(new Guid(SessionController.Users_.facilityID.ToString()));
            cmbfloorname.Enabled = true;
        }
        else
        {
            FacilityModel fm = new FacilityModel();
            FacilityClient fc = new FacilityClient();
            DataSet ds = new DataSet();
            fm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
            fm.Search_text_name = "";
            fm.Doc_flag = "";
            ds = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);
            cmbfacility.DataTextField = "name";
            cmbfacility.DataValueField = "pk_facility_id";
            cmbfacility.DataSource = ds;
            cmbfacility.DataBind();
        }
    }



    protected void BindFloors(Guid facility_ID)
    {
        try
        {

            DataSet ds_facility = new DataSet();
            LocationsClient locObj_crtl = new LocationsClient();
            LocationsModel locObj_mdl = new LocationsModel();
            DataSet ds_Getfloor = new DataSet();

            locObj_mdl.facility_ID = facility_ID;
            ds_Getfloor = locObj_crtl.Get_Floors_by_FacilityID(SessionController.ConnectionString, locObj_mdl);
            cmbfloorname.DataSource = ds_Getfloor;
            cmbfloorname.DataTextField = "NAME";
            cmbfloorname.DataValueField = "location_id";
            cmbfloorname.DataBind();

        }
        catch (Exception ex)
        {

        }
    }

    //    protected void BindDocuments()
    //{
    //    try
    //    {

    //        DataSet ds_facility = new DataSet();
    //        LocationsClient locObj_crtl = new LocationsClient();
    //        LocationsModel locObj_mdl = new LocationsModel();
    //        DataSet ds_GetDocs = new DataSet();
    //        locObj_mdl.Location_id  = new Guid(Request.QueryString["id"].ToString());
    //        ds_GetDocs = locObj_crtl.get_Space_documents(SessionController.ConnectionString, locObj_mdl);
    //        rgDocuments.DataSource = ds_GetDocs;
    //        rgDocuments.DataBind();

    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //}

    protected void Get_SpaceProfile()
    {
        try
        {
            LocationsModel objloc_mdl = new LocationsModel();
            LocationsClient locObj_crtl = new LocationsClient();
            objloc_mdl.Location_id = new Guid(Request.QueryString["id"].ToString());
            DataSet ds_get_spaceprofile = new DataSet();
            ds_get_spaceprofile = locObj_crtl.Get_SpaceProfile_byID(SessionController.ConnectionString, objloc_mdl);

            //////////////////////////////---------------------------
            lblspacename.Visible = false;
            lbldescription.Visible = false;
            lblcategory.Visible = true;
            lblArea.Visible = false;
            lblGrossArea.Visible = false;
            lblBarcode.Visible = false;
            lblroomtag.Visible = false;
            lblusableheight.Visible = false;


            txtspacename.Visible = true;
            txtdescription.Visible = true;
            txt_area.Visible = true;
            txt_Grossarea.Visible = true;
            txtBarcode.Visible = true;
            txtRoomTag.Visible = true;
            txtusableheight.Visible = true;

            //lblroomtag1.Visible = false;   //2nd May
            //txtRoomTag1.Visible = false;
            //lblRoomtagheading1.Visible = false;

            if (SessionController.Users_.is_PM_FM == "FM")
            {
                //cmbfacility.Visible = false;
                //lblfacility.Visible = true;

                cmbfacility.SelectedValue = SessionController.Users_.facilityID.ToString();
                cmbfacility.Visible = true;
                lblfacility.Visible = false;



                cmbfloorname.Visible = true;
                lblfloorname.Visible = false;
                BindFacility();
                BindFloors(new Guid(SessionController.Users_.facilityID.ToString()));
                cmbfloorname.SelectedValue = hf_floor_id.Value.ToString();
            }

            else
            {

                cmbfacility.Visible = true;
                cmbfloorname.Visible = true;
                lblfacility.Visible = false;
                lblfloorname.Visible = false;
                BindFacility();
                cmbfacility.SelectedValue = SessionController.Users_.facilityID.ToString();


                BindFloors(new Guid(SessionController.Users_.facilityID.ToString()));
                cmbfloorname.SelectedValue = hf_floor_id.Value.ToString();
            }

            lnkbtncategory.Visible = true;
            //rgDocuments.Columns[2].Visible = true;
            //BindDocuments();
            lblfloorname.Text = ds_get_spaceprofile.Tables[0].Rows[0]["FloorName"].ToString();
            hf_floor_id.Value = ds_get_spaceprofile.Tables[0].Rows[0]["floorid"].ToString();
            cmbfloorname.SelectedValue = hf_floor_id.Value;
            lblspacename.Text = ds_get_spaceprofile.Tables[0].Rows[0]["SpaceName"].ToString();
            txtspacename.Text = lblspacename.Text;
            txtdescription.Text = lbldescription.Text;
            txt_area.Text = lblArea.Text;
            txt_Grossarea.Text = lblGrossArea.Text;
            txtRoomTag.Text = lblroomtag.Text;
            //lblroomtag1.Text = lblroomtag.Text;   //added
            //txtRoomTag1.Text = txtRoomTag.Text;    //added
            txtusableheight.Text = lblusableheight.Text;
            txtBarcode.Text = lblBarcode.Text;
            //btnadddocument.Visible = true;
            //btnsave.Text = "Save";
            btnsave.Text = (string)GetGlobalResourceObject("Resource", "Save");
            

            //lblspacename.Visible = true;


            //lblfacility.Visible = true;

            //lblfloorname.Visible = true;
            //lbldescription.Visible = true;
            //lblcategory.Visible = true;

            //lblArea.Visible = true;                
            //txt_area.Visible = false;

            //lblGrossArea.Visible = true;
            //txt_Grossarea.Visible = false;

            //lblBarcode.Visible = true;
            //txtBarcode.Visible = false;

            //lblroomtag.Visible = true;
            //txtRoomTag.Visible = false;

            //lblusableheight.Visible = true;
            //txtusableheight.Visible = false;

            //txtspacename.Visible = false;
            //txtdescription.Visible = false;

            //cmbfacility.Visible = false;


            //cmbfloorname.Visible = false;
            //lnkbtncategory.Visible = false;

            //lblroomtag1.Visible = true;   //2nd May
            //txtRoomTag1.Visible = false;
            //lblRoomtagheading1.Visible = true;
            //lblroomtag.Visible = false;   //2nd May
            //txtRoomTag.Visible = false;
            //lblRoomtagheading.Visible = false;



            //btnsave.Text = "Edit";

            lblspacename.Text = ds_get_spaceprofile.Tables[0].Rows[0]["SpaceName"].ToString();
            lbldescription.Text = ds_get_spaceprofile.Tables[0].Rows[0]["Description"].ToString();

            lblfacility.Text = ds_get_spaceprofile.Tables[0].Rows[0]["FacilityName"].ToString();
            lblfloorname.Text = ds_get_spaceprofile.Tables[0].Rows[0]["FloorName"].ToString();
            lblcategory.Text = ds_get_spaceprofile.Tables[0].Rows[0]["category"].ToString();
            lblArea.Text = ds_get_spaceprofile.Tables[0].Rows[0]["Area"].ToString();                              // area
            lblGrossArea.Text = ds_get_spaceprofile.Tables[0].Rows[0]["GrossArea"].ToString();

            lblroomtag.Text = ds_get_spaceprofile.Tables[0].Rows[0]["Roomtag"].ToString();
            lblBarcode.Text = ds_get_spaceprofile.Tables[0].Rows[0]["Barcode"].ToString();
            lblusableheight.Text = ds_get_spaceprofile.Tables[0].Rows[0]["Usable_Height"].ToString();


            hf_floor_id.Value = ds_get_spaceprofile.Tables[0].Rows[0]["floorid"].ToString();
            hf_lblOmniClassid.Value = ds_get_spaceprofile.Tables[0].Rows[0]["pk_standard_detail_id"].ToString();

            txt_area.Text = lblArea.Text;
            txt_Grossarea.Text = lblGrossArea.Text;
            txtdescription.Text = lbldescription.Text;
            txtRoomTag.Text = lblroomtag.Text;
            txtusableheight.Text = lblusableheight.Text;
            txtBarcode.Text = lblBarcode.Text;


            //SessionController.Users_.facilityID = ds_get_spaceprofile.Tables[0].Rows[0]["FacilityId"].ToString();
            //SessionController.Users_.facilityName = ds_get_spaceprofile.Tables[0].Rows[0]["FacilityName"].ToString();

            /*************************Insert into recent Space******************************************/
            //LoginModel dm = new LoginModel();
            //LoginClient dc = new LoginClient();
            //dm.UserId = new Guid(SessionController.Users_.UserId.ToString());
            //dm.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
            //dm.entityName = "Space";
            //dm.Row_id = Request.QueryString["id"].ToString();
            //dc.InsertRecentUserData(dm);
            /**********************************************************************************************/

        }
        catch (Exception ex)
        {
        }
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            savespaceprofile();
        }
        else
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
        //BindFacility();            
    }

    private void Insert_Update_SpaceProfile()
    {
        try
        {
            StringBuilder sb_attribute = new StringBuilder();
            LocationsClient locobj_crtl = new LocationsClient();
            LocationsModel locobj_mdl = new LocationsModel();
            locobj_mdl.Location_id = new Guid(hflocationid.Value);
            locobj_mdl.LocationName = txtspacename.Text;
            locobj_mdl.Description = txtdescription.Text;

            sb_attribute.Append("<root>");
            sb_attribute.Append("<folder Name='Room Tag' Value='" + txtRoomTag.Text.Trim() + "'></folder>");
            sb_attribute.Append("<folder Name='Area' Value='" + txt_area.Text.Trim() + "'></folder>");
            sb_attribute.Append("<folder Name='Gross Area' Value='" + txt_Grossarea.Text.Trim() + "'></folder>");
            sb_attribute.Append("<folder Name='Barcode' Value='" + txtBarcode.Text.Trim() + "'></folder>");
            sb_attribute.Append("<folder Name='Usable Height' Value='" + txtusableheight.Text.Trim() + "'></folder>");
            sb_attribute.Append("</root>");
            string attributes = sb_attribute.ToString().Replace("'", "\"");
            locobj_mdl.Space_attribute_value = attributes;

            //locobj_mdl.facility_ID = new Guid(cmbfacility.SelectedValue.ToString());
            //locobj_mdl.facility_ID = new Guid(hfFacility_id.Value.ToString());

            locobj_mdl.facility_ID = new Guid(SessionController.Users_.facilityID.ToString());

            locobj_mdl.Omniclass_type = null;

            locobj_mdl.User_id = new Guid(SessionController.Users_.UserId.ToString());


            locobj_mdl.floor_id = new Guid(cmbfloorname.SelectedValue.ToString());


            locobj_mdl.Fk_uploaded_file_id = Guid.Empty;



            if (hf_lblOmniClassid.Value != "")
                locobj_mdl.Fk_omniclass_id = new Guid(hf_lblOmniClassid.Value);

            if (SessionController.Users_.is_PM_FM == "FM")
            {
                DataSet ds1 = new DataSet();
                ds1 = locobj_crtl.proc_insert_update_space_profile(SessionController.ConnectionString, locobj_mdl);
                if (ds1.Tables[0].Rows[0]["pk_location_id"].ToString() == Guid.Empty.ToString())
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
                }
                else
                {
                    BindFacility();
                    string id = ds1.Tables[0].Rows[0]["pk_location_id"].ToString();
                    hflocationid.Value = id;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_space();", true);
                }
            }
            else
            {
                DataSet ds = new DataSet();
                ds = locobj_crtl.proc_insert_update_space_profile(SessionController.ConnectionString, locobj_mdl);
                if (ds.Tables[0].Rows[0]["pk_location_id"].ToString() == Guid.Empty.ToString())
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
                }
                else
                {
                    BindFacility();
                    string id = ds.Tables[0].Rows[0]["pk_location_id"].ToString();
                    hflocationid.Value = id;
                    if (hfpopupflag.Value == "popup")
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_spacepopup();", true);
                    else
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_space();", true);
                }
            }
        }
        catch (Exception ex)
        {
        }
    }

    private void savespaceprofile()
    {

        //if (btnsave.Text == "Edit")
        if (btnsave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
            
        {

        }
        //else if (btnsave.Text == "Save")
        else if (btnsave.Text == (string)GetGlobalResourceObject("Resource", "Save"))
            
        {
            if (SessionController.Users_.is_PM_FM == "FM")
            {
                Insert_Update_SpaceProfile();
                //Get_SpaceProfile();
            }
            else
            {
                Insert_Update_SpaceProfile();
                //lblroomtag1.Visible = true;   //2nd May
                //txtRoomTag1.Visible = false;
                //lblRoomtagheading1.Visible = true;
                //lblroomtag.Visible = false;   //2nd May
                //txtRoomTag.Visible = false;
                //lblRoomtagheading.Visible = false;
            }
        }

    }

    protected void cmbfacility_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        Guid facilityId = new Guid(cmbfacility.SelectedValue.ToString());
        SessionController.Users_.facilityID = facilityId.ToString();
        //hfFacility_id.Value = facilityId.ToString();
        if (facilityId == Guid.Empty)
        {
            cmbfloorname.Enabled = false;
            cmbfloorname.SelectedItem.Text = "";
            //cmbfloorname.Visible = false;
        }
        else
        {
            cmbfloorname.Enabled = true;
            BindFloors(facilityId);
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
                    
                    Response.Redirect("SpaceProfile.aspx?id=" + hflocationid.Value.ToString());
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "NavigateToFindLocation();", true);
                //else if (btnsave.Text == "Edit")
                else if (btnsave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
                    
                    //Response.Redirect("FindLocation.aspx");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "NavigateToFindLocation();", true);
            }
            else
            {
                if (hflocationid.Value == Guid.Empty.ToString())
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "NavigateToFindLocationPM();", true);
                }
                else
                {
                    if (hfpopupflag.Value == "popup")
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "navigate_spacepopup();", true);
                    else
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "navigate_space();", true);
                }
            }

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

            // redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

    protected void btn_refresh_Click(object sender, EventArgs e)
    {
        //BindDocuments();
    }
}