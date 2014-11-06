
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Facility;
using Locations;
 
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Session;
using System.Globalization;
using System.Threading;
using Telerik.Web.UI;

public partial class App_Locations_FacilityMenu : System.Web.UI.Page
{
    // Facility.ConnectionModel conObj_Facilitymdl = new Facility.ConnectionModel();

    //   string connection = "";
    string profileflag = "";
    int spaceFlag = 0; // 0 means facility name is clicked to open it's profile and 1 space name is clicked to open it's profile
    int floorFlag = 0; // 0 means facility name is clicked to open it's profile and 1 space floor name is clicked to open it's profile
    int zoneFlag = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try 
        {
            //Comman.DisablePageCaching();

            string facilityidforspace = "";

            if (SessionController.Users_.UserId.ToString() != null)
            {

                if (Request.QueryString["pagevalue"] == null)  //It means facility name is clicked to open it's profile.
                {
                    SessionController.Users_.Spaceflag = "1";
                    hfAttributeflag.Value = "1";   //1 for FacilityAttributes and 0 for space Attributes.
                    hf_location_id.Value = Request.QueryString["FacilityId"].ToString();

                    if (hf_location_id.Value != Guid.Empty.ToString())
                    {
                        facility.Visible = true;
                        //To get the facility name of current facility and to show it on parent page i.e. FacilityMenu page
                        DataSet ds_facilityname = new DataSet();
                        FacilityClient objfac_ctrl = new FacilityClient();
                        FacilityModel objfac_mdl = new FacilityModel();
                        objfac_mdl.Facility_id = new Guid(Request.QueryString["FacilityId"].ToString());

                        ds_facilityname = objfac_ctrl.proc_get_facility_data(objfac_mdl, SessionController.ConnectionString);
                        string facilityname = ds_facilityname.Tables[0].Rows[0]["name"].ToString();
                        lblfacilityname.Text = facilityname;
                        if (Request.QueryString["profileflag"] != "old")
                        {
                            profileflag = "new";
                        }
                        else if (Request.QueryString["profileflag"] == "old")
                        {
                            profileflag = "old";
                        }
                    }
                    else
                    {
                        facilityprofile.Visible = true;
                        profileflag = "old";
                    }
                    if (Request.QueryString["IsFromFacility"] != null)
                    {
                        hfIsFromFacility.Value = "Y";
 
                    }
                   


                    if (Request.QueryString["FacilityId"] == Guid.Empty.ToString())
                    {
                        string script1 = "<script language='javascript'>loadintoIframe('frameSettingsMenu','FacilityProfile.aspx');sitemap();</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", script1);
                    }

                    else if (Request.QueryString["FacilityId"] == null)
                    {
                        string script1 = "<script language='javascript'>loadintoIframe('frameSettingsMenu','FacilityProfile.aspx');sitemap();</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", script1);
                    }

                    else if (Request.QueryString["zones"] != null)
                    {
                        hf_Facility_id.Value = SessionController.Users_.facilityID;
                        HiddenField1.Value = Request.QueryString["IsfromClient"];
                        Guid decrypted_Facility_id = new Guid(hf_Facility_id.Value);
                        string value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','Zones.aspx?FacilityId=" + SessionController.Users_.facilityID + "');sitemap();</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);



                        if (decrypted_Facility_id == Guid.Empty)
                        {
                        }
                        else
                        {
                        }
                    }

                    else if (Request.QueryString["FacilityId"] != Guid.Empty.ToString())
                    {
                        string value = "";
                        //hf_Facility_id.Value = SessionController.Users_.facilityID;
                        hf_Facility_id.Value = Request.QueryString["FacilityId"];
                        HiddenField1.Value = Request.QueryString["IsfromClient"];
                        Guid decrypted_Facility_id = new Guid(hf_Facility_id.Value);
                        if (profileflag == "new")
                        {
                            value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','FacilityProfileNew.aspx?FacilityId=" + hf_Facility_id.Value + "');sitemap();</script>";
                        }
                        else if (Request.QueryString["profileflag"] == "old")
                        {
                            value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','FacilityProfile.aspx?FacilityId=" + hf_Facility_id.Value + "');sitemap();</script>";
                        }
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
                        if (decrypted_Facility_id == Guid.Empty)
                        {
                          }
                        else
                        {
                        }
                    }

                }
                else
                {

                    hf_Facility_id.Value = SessionController.Users_.facilityID;

                    string abvalue = Request.QueryString["pagevalue"].ToString();
                    if (abvalue == "Zone Profile")  //It means Zone name is clicked to open it's profile.
                    {
                        zoneFlag = 1;
                        SessionController.Users_.Spaceflag = "0";
                        hfAttributeflag.Value = "0"; //AttributeFlag = 3 means show documents for zone.
                        hf_zone_name.Value = Request.QueryString["name"].ToString();
                        if (hf_zone_name.Value != "")
                        {
                            zone.Visible = true;
                            lblzonename.Text = hf_zone_name.Value;
                        }
                        else
                        {
                            zoneprofile.Visible = true;
                        }

                    }
                    else if (abvalue == "Floor Profile") //It means Floor name is clicked to open it's profile.
                    {
                        floorFlag = 1;
                        SessionController.Users_.Spaceflag = "1";
                        hfAttributeflag.Value = "2";  //AttributeFlag = 2 means show documents for floor.

                        hf_location_id.Value = Request.QueryString["id"].ToString();

                        if (hf_location_id.Value != Guid.Empty.ToString())
                        {
                            floor.Visible = true;
                            DataSet ds_floor = new DataSet();
                            LocationsClient objloc_ctrl = new LocationsClient();
                            LocationsModel objloc_mdl = new LocationsModel();
                            objloc_mdl.Location_id = new Guid(hf_location_id.Value.ToString());
                            ds_floor = objloc_ctrl.Get_FloorProfile_byID(SessionController.ConnectionString, objloc_mdl);
                            string floorname = ds_floor.Tables[0].Rows[0]["FloorName"].ToString();
                            lblfloorname.Text = floorname;
                        }
                        else
                        {
                            floorProfile.Visible = true;
                        }


                    }

                    if (abvalue == "Space Profile") //It means Space name is clicked to open it's profile.
                    {
                        spaceFlag = 1;
                        hfAttributeflag.Value = "0"; //AttributeFlag = 0 means show attributes for spaces.
                        hf_location_id.Value = Request.QueryString["id"].ToString();
                        if (hf_location_id.Value != Guid.Empty.ToString())
                        {
                            space.Visible = true;
                            DataSet ds_space = new DataSet();
                            LocationsClient objloc_ctrl = new LocationsClient();
                            LocationsModel objloc_mdl = new LocationsModel();
                            objloc_mdl.Location_id = new Guid(hf_location_id.Value.ToString());
                            ds_space = objloc_ctrl.Get_SpaceProfile_byID(SessionController.ConnectionString, objloc_mdl);
                            string spacename = ds_space.Tables[0].Rows[0]["SpaceName"].ToString();
                            lblspacename.Text = spacename;
                            //Following facility id is for redirecting to space profile from Components page.
                            facilityidforspace = ds_space.Tables[0].Rows[0]["FacilityId"].ToString();
                            if (Request.QueryString["profileflag"] != "old")
                            {
                                profileflag = "new";
                            }
                            else if (Request.QueryString["profileflag"] == "old")
                            {
                                profileflag = "old";
                            }

                        }
                        else
                        {
                            spaceprofile.Visible = true;
                            //lblspaceprofile.Text = "Space Profile";
                            profileflag = "old";
                        }

                        /************************************BIM***************************************************************/
                        BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
                        BIMModel.BIMModels mdl = new BIMModel.BIMModels();
                        DataSet ds1 = new DataSet();
                        string filename = string.Empty;
                        mdl.Asset_id = new Guid(hf_location_id.Value.ToString());
                        ds1 = BIMModelClient.GetUploadedFileForspace(mdl, SessionController.ConnectionString);
                        if (ds1.Tables[0].Rows.Count > 0)
                        {
                            hf_uploaded_File_id.Value = ds1.Tables[0].Rows[0]["uploaded_file_id"].ToString();
                            hf_element_numeric_id.Value = ds1.Tables[0].Rows[0]["element_numeric_id"].ToString();
                            hf_fk_masterfile_id.Value = ds1.Tables[0].Rows[0]["fk_master_file_id"].ToString();
                            filename = ds1.Tables[0].Rows[0]["file_name"].ToString();
                            if (filename.Substring(filename.Length - 3, 3).ToString().ToLower() == "nwd")
                            {
                                hf_file_ext.Value = "nwd";
                            }
                            else
                            {
                                hf_file_ext.Value = "hsf";
                            }
                        }
                        else
                        {
                            hf_uploaded_File_id.Value = Guid.Empty.ToString();
                            hf_element_numeric_id.Value = Guid.Empty.ToString();
                            hf_fk_masterfile_id.Value = Guid.Empty.ToString();
                        }
                        /************************************BIM***************************************************/


                    }

                    hf_location_id.Value = Request.QueryString["id"].ToString();
                    string id = hf_location_id.Value;
                    string value = "";
                    if (profileflag == "old")
                    {
                        if (Request.QueryString["floor_id"].ToString() == "")
                        {

                            value = "<script language='javascript'>pageload('" + abvalue + "','" + id + "','" + profileflag + "')</script>";
                        }
                        else
                        {
                            value = "<script language='javascript'>pageload('" + abvalue + "','" + id + "','" + profileflag + "','" + Request.QueryString["floor_id"].ToString() + "')</script>";
                        }

                    }
                    else
                    {
                        value = "<script language='javascript'>pageload('" + abvalue + "','" + id + "','" + profileflag + "')</script>";
                    }
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);


                    if (facilityidforspace != "")
                    {
                        hf_Facility_id.Value = facilityidforspace;
                    }
                    else
                    {
                        hf_Facility_id.Value = SessionController.Users_.facilityID;
                    }
                    Guid decrypted_Facility_id = new Guid(hf_Facility_id.Value);

                    if (decrypted_Facility_id == Guid.Empty || hf_location_id.Value == Guid.Empty.ToString())
                    {
                        rtsFacilityProfile.Style.Add("display", "none");
                    }
                    else
                    {
                        rtsFacilityProfile.Style.Add("display", "inline");
                    }
                }
                if (Request.QueryString["IsFromFloor"] != null)
                {
                    hfIsFromFloor.Value = "Y";
                }
                if (Request.QueryString["IsFromZone"] != null)
                {
                    hfIsFromZone.Value = "Y";
                }
                if (Request.QueryString["IsFromSpace"] != null)
                {
                    hfIsFromSpace.Value = "Y";
                }

                DataSet ds = new DataSet();

                FacilityClient facObjClientCtrl = new FacilityClient();
                FacilityModel facObjFacilityModel = new FacilityModel();
                if (Request.QueryString["id"] != null)
                {
                    facObjFacilityModel.Facility_id = new Guid(Request.QueryString["id"]);
                }
                facObjFacilityModel.Culture = Session["Culture"].ToString();
                ds = facObjClientCtrl.Get_Facility_menu_PM(facObjFacilityModel, SessionController.ConnectionString);
                                                
                rtsFacilityProfile.DataTextField = "page_heading1";
                rtsFacilityProfile.DataFieldID = "pk_setting_page_Id";
                rtsFacilityProfile.DataValueField = "page_heading";
                rtsFacilityProfile.DataSource = ds;
                rtsFacilityProfile.DataBind();

                if (Request.QueryString["FacilityId"] == Guid.Empty.ToString())
                {
                    rtsFacilityProfile.Visible = false;
                }
            }
            else
            {
                Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            }

        }
        catch (Exception ex)
        {

            Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
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

    protected void btnclick_Click(object sender, EventArgs e)
    {
        string tabName = hfSelectedIndex.Value;
        if (tabName.Contains(" "))
        {
            tabName = tabName.Trim().Replace(" ", "_");
        }
        ContentPlaceHolder ctnobj = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
        if (ctnobj != null)
        {
            RadTabStrip tabStrip = (RadTabStrip)ctnobj.FindControl("rtsFacilityProfile");
            if (tabStrip != null)
            {
                RadTab objTab = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", tabName));
                if (objTab != null)
                {
                    objTab.Enabled = true;
                    objTab.Selected = true;
                }
            }
        }
    }
    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "CBU")
            {
                ContentPlaceHolder ctnobj = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
                RadTabStrip tabStrip = (RadTabStrip)ctnobj.FindControl("rtsFacilityProfile");
                if (tabStrip != null)
                {
                    RadTab objTab = tabStrip.FindTabByValue("View in BIM");
                    if (objTab != null)
                    {
                        objTab.Visible = false;

                    }
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
}
