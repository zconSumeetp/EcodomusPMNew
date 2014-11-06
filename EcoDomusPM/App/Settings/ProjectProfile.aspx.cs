using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Data;
using System.Data.SqlClient;
using Organization;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using Project;
using System.IO; 
using Login;
using Dashboard;
using Login;
using System.Threading;
using System.Globalization;
using Facility;
using User;

public partial class App_Settings_ProjectProfile : System.Web.UI.Page
{

    Guid project_id = Guid.Empty;
    string conn = "";
    Guid intprojectid;
    string clnflag = "";
    int blank_master;
    string flag = "0";


    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Request.QueryString["flag"] == "no_master")
        {
            Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";
            blank_master = 1;
        }
        //if(Request.QueryString["flag1"] == "new" && Request.QueryString["flag"] != "no_master")
        //{
        //    Page.MasterPageFile = "~/App/EcoDomusMaster.master"; 
        //    //blank_master = 0;
        //}
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


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
        else
        {

        }
        //  CryptoHelper a = new CryptoHelper();         
        if (SessionController.Users_.UserId != null)
        {
            ruProjectLogo.Localization.Select = (string)GetGlobalResourceObject("Resource", "Select");
            if (!IsPostBack)
            {
                // if (SessionController.Users_.ProjectId != Guid.Empty.ToString())      

                if (Request.QueryString["ProjectId"] != null && Request.QueryString["ProjectId"] != Guid.Empty.ToString())
                {

                    /******************************Added*************************************/
                    //LoginModel lm = new LoginModel();
                    //LoginClient lc = new LoginClient();
                    //DataSet ds = new DataSet();
                    //CryptoHelper crypt = new CryptoHelper();
                    //lm.UserId = new Guid(SessionController.Users_.UserId);
                    //ds = lc.GetConnectionStringUser(lm);
                    ////To insert data into tbl_recent_user_data
                    ///************************************************************************/                                                
                    //bind_project_data(SessionController.Users_.ProjectId);
                    //string entity = "Project"; earlier
                    bind_project_data(SessionController.Users_.ProjectId);
                    //string entity = "Project";
                    //Guid row_id = new Guid(SessionController.Users_.ProjectId.ToString());
                    ////Guid client_id = new Guid(ds.Tables[0].Rows[0]["pk_client_id"].ToString());
                    //Guid client_id = new Guid(SessionController.Users_.ClientID.ToString());
                    //Guid user_id = new Guid(SessionController.Users_.UserId.ToString());

                    //Insert_Recent_User_Data_Project(user_id, client_id, entity, row_id);

                    var clientId = new Guid(SessionController.Users_.ClientID);
                    var userId = new Guid(SessionController.Users_.UserId);
                    const EntityType entityType = EntityType.Project;
                    var projectId = new Guid(SessionController.Users_.ProjectId);
                    using (var userClient = new UserClient())
                    {
                        userClient.InsertUpdateRecentEntities(clientId, userId, entityType, projectId);
                    }

                    /****************************************************************************/

                    hfProjectId.Value = SessionController.Users_.ProjectId.ToString();
                    btnEdit.Visible = true;
                    btnDelete.Visible = true;
                    btnSave.Visible = false;
                    BindCountry();
                    BindState();
                    bindphase();

                    //flag = "1";
                }

                else
                {
                    lbl_title.Visible = true;
                    Guid project_id = Guid.Empty;
                    btnEdit.Visible = false;
                    btnDelete.Visible = false;
                    btn_clone.Visible = false;
                    btnSave.Visible = true;
                    lbl_created_on.Visible = false;
                    ImgProjectLogo.Visible = false;
                    lblCreatedNm.Visible = true;
                    lblOwnerNm.Visible = true;  //added 12july12

                    if (Request.QueryString["ispage"] == "organization")
                    {
                        lblCreatedNm.Text = Request.QueryString["org_name"].ToString();
                        hflblOrganization.Value = Request.QueryString["org_id"].ToString();
                        lblOwnerNm.Text = Request.QueryString["org_name"].ToString();  //added 12july12
                        hflblOwnerOrg.Value = Request.QueryString["org_id"].ToString();//added 12july12
                        hf_lead_org_name.Value = lblCreatedNm.Text;
                        hf_org_name.Value = lblOwnerNm.Text;   //added 12july12
                        hfoldlead.Value = Request.QueryString["org_id"].ToString();
                    }
                    else
                    {
                        lblCreatedNm.Text = SessionController.Users_.OrganizationName.ToString();
                        hflblOrganization.Value = SessionController.Users_.OrganizationID.ToString();
                        hf_lead_org_name.Value = lblCreatedNm.Text;

                        lblOwnerNm.Text = SessionController.Users_.OrganizationName.ToString();
                        hflblOwnerOrg.Value = SessionController.Users_.OrganizationID.ToString();
                        hf_org_name.Value = lblOwnerNm.Text;

                        hfoldlead.Value = SessionController.Users_.OrganizationID.ToString();
                    }

                    BindCountry();
                    bindphase();


                    string OrganizationId = Request.QueryString["org_id"] != null ? Request.QueryString["org_id"] : SessionController.Users_.OrganizationID.ToString();
                    string SelectedState = "";
                    if (!OrganizationId.Equals("00000000-0000-0000-0000-000000000000"))
                    {
                        SelectedState = BindAddress(OrganizationId);
                    }

                    BindState();
                    if (!SelectedState.Equals(""))
                    {
                        ddlState.SelectedValue = SelectedState;
                    }
                }
                bind_cmdstandard_v1();
            }
        }
        else
        {
            //  Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    protected void bindphase()
    {
        DataSet ds = new DataSet();
        ProjectModel pm = new ProjectModel();
        ProjectClient pc = new ProjectClient();
        if (hflblOwnerOrg.Value.ToString() != "")
            pm.Organization_id = new Guid(hflblOwnerOrg.Value.ToString());
        else
            hflblOwnerOrg.Value = "00000000-0000-0000-0000-000000000000";
        ds = pc.getphase(pm, SessionController.ConnectionString);
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlphase.DataTextField = "phase_name";
                ddlphase.DataValueField = "pk_phase_id";

                ddlphase.DataSource = ds;
                ddlphase.DataBind();
            }
        }
    }
    protected void Insert_Recent_User_Data_Project(Guid user_id, Guid client_id, string entity_name, Guid row_id)
    {
        //DashboardModel dm = new DashboardModel();
        //DashboardClient dc = new DashboardClient();
        //dm.User_id = user_id;
        //dm.ClientID = client_id;
        //dm.Entity = "Project";
        //dm.Row_id = row_id;
        //dc.InsertRecentUserData(dm, SessionController.ConnectionString);
        Login.LoginModel lm = new Login.LoginModel();
        Login.LoginClient lc = new Login.LoginClient();
        lm.UserId = user_id;
        lm.ClientId = client_id;
        lm.entityName = entity_name;
        lm.Row_id = row_id.ToString();
        lc.InsertRecentUserData(lm);
    }

    protected void BindCountry()
    {
        DataSet ds = new DataSet();
        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
        Organization.OrganizationModel mdl = new Organization.OrganizationModel();
        ds = obj_ctrl.getCountry();
        ddlCountry.DataSource = ds;
        ddlCountry.DataBind();

        int cmb_size = 200;
        cmb_size = cmb_size < (ddlCountry.Items.Count) * 18 ? cmb_size : (ddlCountry.Items.Count) * 18;
        ddlCountry.Height = cmb_size;
    }

    protected void BindState()
    {
        try
        {
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            DataSet ds = new DataSet();

            mdl.Country_Id = new Guid(ddlCountry.SelectedValue);
            ds = obj_ctrl.getState(mdl);
            ddlState.DataTextField = "name";
            ddlState.DataValueField = "state_id";
            ddlState.DataSource = ds;
            ddlState.DataBind();

            int cmb_size = 200;
            cmb_size = cmb_size < (ddlState.Items.Count) * 18 ? cmb_size : (ddlState.Items.Count) * 18;
            ddlState.Height = cmb_size;

        }
        catch (Exception ex)
        {
            Response.Write("BindState" + ex.Message.ToString());
        }
    }

    protected void ddl_Country_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            mdl.Country_Id = new Guid(ddlCountry.SelectedValue.ToString());
            ds = obj_ctrl.getState(mdl);
            ddlState.DataTextField = "Name";
            ddlState.DataValueField = "state_id";
            ddlState.DataSource = ds;
            ddlState.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write("cmbState_SelectedIndexChanged" + ex.Message.ToString());
        }
    }

    protected void btnOrgChangeAddress_click(object sender, EventArgs e)
    {
        string SelectedState = "";

        SelectedState = BindAddress(hflblOwnerOrg.Value);

        lblCreatedNm.Text = hf_lead_org_name.Value;

        BindState();

        if (!SelectedState.Equals(string.Empty))
        {
            ddlState.SelectedValue = SelectedState;
        }
    }

    protected string BindAddress(string OrganizationId)
    {
        string SelectedState = "";
        DataSet ds = new DataSet();
        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
        Organization.OrganizationModel mdl = new Organization.OrganizationModel();

        mdl.Organization_Id = new Guid(OrganizationId);
        ds = obj_ctrl.GetOranizationInformation(mdl);
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblOwnerNm.Text = ds.Tables[0].Rows[0]["OrganizationName"].ToString();
                txtAddress1.Text = ds.Tables[0].Rows[0]["Address_1"].ToString();
                txtAddress2.Text = ds.Tables[0].Rows[0]["Address_2"].ToString();
                txtPostalCode.Text = ds.Tables[0].Rows[0]["postalCode"].ToString();
                txtCity.Text = ds.Tables[0].Rows[0]["city_name"].ToString();
                ddlCountry.SelectedValue = ds.Tables[0].Rows[0]["countryId"].ToString();
                SelectedState = ds.Tables[0].Rows[0]["stateId"].ToString();
            }
        }

        return SelectedState;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        ProjectModel pm = new ProjectModel();
        ProjectClient pc = new ProjectClient();
        DataSet ds = new DataSet();
        string s = "";
        try
        {
            //if (SessionController.Users_.ProjectId != null)
            //{            
            //    pm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
            //}
            if (Request.QueryString["ProjectId"] != Guid.Empty.ToString() && SessionController.Users_.ProjectId != null)
            {
                pm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                //-----------------------added to update records from tbl_organization_project---------
                pm.Old_Lead_organization_id = new Guid(hfoldlead.Value.ToString());
                pm.Old_Owner_organization_id = new Guid(hfoldowner.Value.ToString());
                //---------------------------------------------------------------------------------------------------
            }
            else
            {
                pm.Project_id = Guid.Empty;


            }

            pm.Project_Name = txtProjectName.Text;

            SessionController.Users_.ProjectName = pm.Project_Name;//added

            pm.Address_1 = txtAddress1.Text;
            pm.Address_2 = txtAddress2.Text;
            s = ddlEnabled.SelectedValue.ToString();
            if (s == "1")
            {
                pm.Enable_bit = "1";
            }
            else
            {
                pm.Enable_bit = "0";
            }

            pm.Lead_organization_id = new Guid(hflblOrganization.Value.ToString());


            if (hflblOwnerOrg.Value == "")
            {
                pm.Owner_organization_id = Guid.Empty;
            }
            else
            {
                pm.Owner_organization_id = new Guid(hflblOwnerOrg.Value.ToString());//earlier
            }

            pm.City = txtCity.Text;

            pm.Country_id = new Guid(ddlCountry.SelectedValue.ToString());

            pm.State_id = new Guid(ddlState.SelectedValue.ToString());

            pm.User_id = new Guid(SessionController.Users_.UserId.ToString());

            pm.Postal_code = txtPostalCode.Text;

            pm.Logo_path = hfLogo.Value.ToString();

            if (hf_uniclass_id.Value != null)
            {
                if (hf_uniclass_id.Value.ToString() != "")
                {
                    pm.Standard_id_uniclass = new Guid(hf_uniclass_id.Value.ToString());
                }
                else
                {
                    pm.Standard_id_uniclass = Guid.Empty;
                }
            }
            else
            {
                pm.Standard_id_uniclass = Guid.Empty;
            }
            //xxx
            if (hf_MasterFormat.Value != null)
            {
                if (hf_MasterFormat.Value.ToString() != "")
                {
                    pm.Standard_id_MasterFormat = new Guid(hf_MasterFormat.Value.ToString());
                }
                else
                {
                    pm.Standard_id_MasterFormat = Guid.Empty;
                }
            }
            else
            {
                pm.Standard_id_MasterFormat = Guid.Empty;
            }

            if (hf_OmniClass2010.Value != null)
            {
                if (hf_OmniClass2010.Value.ToString() != "")
                {
                    pm.Standard_id_OmniClass2010 = new Guid(hf_OmniClass2010.Value.ToString());
                }
                else
                {
                    pm.Standard_id_OmniClass2010 = Guid.Empty;
                }
            }
            else
            {
                pm.Standard_id_OmniClass2010 = Guid.Empty;
            }

            if (hf_UniFormat.Value != null)
            {
                if (hf_UniFormat.Value.ToString() != "")
                {
                    pm.Standard_id_UniFormat = new Guid(hf_UniFormat.Value.ToString());
                }
                else
                {
                    pm.Standard_id_UniFormat = Guid.Empty;
                }
            }
            else
            {
                pm.Standard_id_UniFormat = Guid.Empty;
            }
            //xxx
            //hf_MasterFormat.Value.ToString();
            //hf_OmniClass2010.Value.ToString();
            //hf_UniFormat.Value.ToString();



            pm.Client_id = new Guid(SessionController.Users_.ClientID.ToString());
            if (ddlphase.SelectedValue.ToString() != "")
                pm.phaseid = new Guid(ddlphase.SelectedValue.ToString());
            else
                pm.phaseid = new Guid("00000000-0000-0000-0000-000000000000");

            /*-- check for OA who is from different database--*/
            string conn_string = string.Empty;
            if (SessionController.Users_.UserRoleDescription != "System Admin")
            {

                try
                {
                    LoginModel lm = new LoginModel();
                    LoginClient lc = new LoginClient();
                    DataSet ds_conn = new DataSet();
                    CryptoHelper crypt = new CryptoHelper();
                    lm.UserId = new Guid(SessionController.Users_.UserId);
                    ds_conn = lc.GetConnectionStringUser(lm);
                    if (ds_conn.Tables[0].Rows.Count > 0)
                    {                                            
                        if (Convert.ToString(ds_conn.Tables[0].Rows[0]["connection_string"]) != "")
                        {
                            conn_string = Convert.ToString(ds_conn.Tables[0].Rows[0]["connection_string"]);
                            CryptoHelper crypto_obj = new CryptoHelper();
                            conn_string = crypto_obj.Encrypt(conn_string);
                            // switch session to the new connection string
                            SessionController.ConnectionString = conn_string;
                        }
                        else
                        {
                            conn_string = SessionController.ConnectionString;
                        }
                    }
                }
                catch (Exception)
                {
                    conn_string = SessionController.ConnectionString;
                }
            }
            else
            {
                conn_string = SessionController.ConnectionString;
            }
            /*-- check for OA who is from different database--*/

            string standard_ids = string.Empty;
            getSelectedStandards(out standard_ids);
            pm.standard_ids = standard_ids;

            ds = pc.InsertUpdateProject(pm, conn_string);
            string pk_project_id = ds.Tables[0].Rows[0]["pk_project_id"].ToString();

            hfProjectId.Value = pk_project_id;
            // SessionController.Users_.ProjectId = hfProjectId.Value.ToString();//added
            SessionController.Users_.ProjectId = pk_project_id;
            SaveImage();

            //  bind_project_data(hfProjectId.Value);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "navigate", "GotoProfile();", true);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void bind_project_data(string pk_project_id)
    {
        label();
        DataSet ds = new DataSet();
        ProjectModel pm = new ProjectModel();
        ProjectClient pc = new ProjectClient();
        pm.Project_id = new Guid(pk_project_id.ToString());


        ds = pc.GetProjectDataById(pm, SessionController.ConnectionString);

        lblProjectName.Text = ds.Tables[0].Rows[0]["project_name"].ToString();
        lblAddress1.Text = ds.Tables[0].Rows[0]["address1"].ToString();
        lblAddress2.Text = ds.Tables[0].Rows[0]["address2"].ToString();
        lbltxtphase.Text = ds.Tables[0].Rows[0]["phase"].ToString();
        if (ds.Tables[0].Rows[0]["is_enabled"].ToString() == "True")
        {
            lblEnabled.Text = "Yes";
        }
        else
        {
            lblEnabled.Text = "No";
        }
        lblEnabled.Text = ds.Tables[0].Rows[0]["is_enabled"].ToString();
        lblCity.Text = ds.Tables[0].Rows[0]["city"].ToString();
        lblCountry.Text = ds.Tables[0].Rows[0]["country_name"].ToString();

        /*--custom classification changes-->*/
        for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
        {
            lbl_standard.Text = lbl_standard.Text + "," + ds.Tables[1].Rows[i]["standard_name"].ToString();

        }
        if (lbl_standard.Text.Length > 0)
            lbl_standard.Text = lbl_standard.Text.Substring(1, lbl_standard.Text.Length - 1);
        /*--custom classification changes--*/

        lblState.Text = ds.Tables[0].Rows[0]["state_name"].ToString();
        lblCreatedBy.Text = ds.Tables[0].Rows[0]["name"].ToString();
        lblCreatedOn.Text = ds.Tables[0].Rows[0]["created_on"].ToString();

        lblOwnerNm.Text = ds.Tables[0].Rows[0]["owner_org_name"].ToString();
        lblCreatedNm.Text = ds.Tables[0].Rows[0]["lead_org_name"].ToString();

        hf_org_name.Value = ds.Tables[0].Rows[0]["owner_org_name"].ToString();//added
        hf_lead_org_name.Value = ds.Tables[0].Rows[0]["lead_org_name"].ToString();//added

        lblPostalCode.Text = ds.Tables[0].Rows[0]["zipcode"].ToString();

        hflblOrganization.Value = ds.Tables[0].Rows[0]["fk_lead_organization_id"].ToString();
        hflblOwnerOrg.Value = ds.Tables[0].Rows[0]["fk_owner_organization_id"].ToString();

        //-----------------------added to update records from tbl_organization_project---------
        hfoldlead.Value = ds.Tables[0].Rows[0]["fk_lead_organization_id"].ToString();
        hfoldowner.Value = ds.Tables[0].Rows[0]["fk_owner_organization_id"].ToString();
        //---------------------------------------------------------------------------------------------------
        if (ds.Tables[0].Rows[0]["logo_path"].ToString() == "")
        {
            ImgProjectLogo.Visible = false;
        }
        else
        {
            lblimgmsg.Visible = false;
            ImgProjectLogo.ImageUrl = ds.Tables[0].Rows[0]["logo_path"].ToString();
            hfLogo.Value = ds.Tables[0].Rows[0]["logo_path"].ToString();
        }
    }

    void unlabel()
    {
        lbl_title.Visible = false;

        txtProjectName.Visible = true;
        lblProjectName.Visible = false;
        lblAddress1.Visible = false;
        txtAddress1.Visible = true;
        lblAddress2.Visible = false;
        txtAddress2.Visible = true;
        lblEnabled.Visible = false;
        ddlEnabled.Visible = true;

        ddlphase.Visible = true;
        lbltxtphase.Visible = false;
        txtCity.Visible = true;
        lblCity.Visible = false;
        ddlCountry.Visible = true;
        lblCountry.Visible = false;
        ddlState.Visible = true;
        lblState.Visible = false;
        lbl_standard.Visible = false;
        txtPostalCode.Visible = true;
        lblPostalCode.Visible = false;
        cmbSelectStandard_v1.Visible = true;

        //ImgProjectLogo.Visible = true; 

        lblCreatedBy.Visible = false;
        lblCreatedOn.Visible = false;

        linkOrganizationChange.Visible = true;
        lnbtnselect.Visible = true;

        btnEdit.Visible = false;
        btnSave.Visible = true;


        ruProjectLogo.Visible = true;

        btnUpload.Visible = true;

        lbl_created_by.Visible = false;
        lbl_created_on.Visible = false;
        lblCreatedBy.Visible = false;
        lblCreatedOn.Visible = false;

        lbl_logo.Visible = true;
        //ImgProjectLogo.Visible = true;
        //lblimgmsg.Visible = true;

        btnCancel.Visible = true;
        btnDelete.Visible = false;

    }

    void label()
    {
        lbl_title.Visible = false;

        lblProjectName.Visible = true;
        txtProjectName.Visible = false;
        ddlphase.Visible = false;
        lbltxtphase.Visible = true;
        lblAddress1.Visible = true;
        txtAddress1.Visible = false;


        lblAddress2.Visible = true;
        txtAddress2.Visible = false;


        lblEnabled.Visible = true;
        ddlEnabled.Visible = false;


        lblCity.Visible = true;
        txtCity.Visible = false;

        lblOwnerNm.Visible = true;
        lblCreatedNm.Visible = true;


        lblCountry.Visible = true;
        ddlCountry.Visible = false;
        cmbSelectStandard_v1.Visible = false;

        lblState.Visible = true;
        lbl_standard.Visible = true;
        ddlState.Visible = false;


        lblCreatedBy.Visible = true;
        lblCreatedOn.Visible = true;

        lbl_created_by.Visible = true;
        lbl_created_on.Visible = true;


        lblPostalCode.Visible = true;
        txtPostalCode.Visible = false;

        btnEdit.Visible = true;
        btnDelete.Visible = true;
        btnSave.Visible = false;

        ruProjectLogo.Visible = false;
        btnUpload.Visible = false;

        lbl_logo.Visible = false;
        ImgProjectLogo.Visible = true;
        lblimgmsg.Visible = true;

        linkOrganizationChange.Visible = false;
        lnbtnselect.Visible = false;

        btnCancel.Visible = false;
        btnDelete.Visible = true;
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            ProjectModel pm = new ProjectModel();
            ProjectClient pc = new ProjectClient();
            pm.Project_id = new Guid(SessionController.Users_.ProjectId);
            SessionController.Users_.ProjectId = pm.Project_id.ToString();
            //ddlphase.DataTextField = "phase";
            //ddlphase.DataValueField = "phase_id";
            //bindphase();
            ds = pc.GetProjectDataById(pm, SessionController.ConnectionString);
            txtProjectName.Text = ds.Tables[0].Rows[0]["project_name"].ToString();
            txtAddress1.Text = ds.Tables[0].Rows[0]["address1"].ToString();
            txtAddress2.Text = ds.Tables[0].Rows[0]["address2"].ToString();
            //ddlphase.SelectedValue= ds.Tables[0].Rows[0]["phase_id"].ToString();
            if (ds.Tables[0].Rows[0]["is_enabled"].ToString() == "False")
            {
                ddlEnabled.SelectedValue = "0";

            }
            else
            {
                ddlEnabled.SelectedValue = "1";
            }
            ddlEnabled.SelectedValue = ds.Tables[0].Rows[0]["is_enabled"].ToString();
            txtCity.Text = ds.Tables[0].Rows[0]["city"].ToString();
            ddlCountry.SelectedValue = ds.Tables[0].Rows[0]["Id"].ToString();
            BindState();
            ddlState.SelectedValue = ds.Tables[0].Rows[0]["state_id"].ToString();
            txtPostalCode.Text = ds.Tables[0].Rows[0]["zipcode"].ToString();
            ddlphase.SelectedValue = ds.Tables[0].Rows[0]["phase_id"].ToString();
            ImgProjectLogo.ImageUrl = ds.Tables[0].Rows[0]["logo_path"].ToString();
            if (ImgProjectLogo.ImageUrl == "")
            {
                ImgProjectLogo.Visible = false;
                lbl_logo.Visible = false;
            }
            else
                ImgProjectLogo.Visible = true;
            hflblOrganization.Value = ds.Tables[0].Rows[0]["fk_lead_organization_id"].ToString();
            hflblOwnerOrg.Value = ds.Tables[0].Rows[0]["fk_owner_organization_id"].ToString();

            //-----------------------added to update records from tbl_organization_project---------
            hfoldlead.Value = ds.Tables[0].Rows[0]["fk_lead_organization_id"].ToString();
            hfoldowner.Value = ds.Tables[0].Rows[0]["fk_owner_organization_id"].ToString();
            //---------------------------------------------------------------------------------------------------

            hf_redirect_value.Value = "ProjectProfile";
            unlabel();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string url = "";
        ProjectModel pm = new ProjectModel();
        ProjectClient pc = new ProjectClient();
        //pm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());

        //**********************old code before delete flag functionality********
        //pc.DeleteProject(pm, SessionController.ConnectionString);
        //****************end***********************************
        //************NEw code modified by Ganesh 20/07/2012********
        FacilityModel fm = new Facility.FacilityModel();
        FacilityClient fc = new Facility.FacilityClient();
        fm.Facility_Ids = SessionController.Users_.ProjectId.ToString();
        fm.Entity = "Project";
        fc.Set_delete_flag(fm, SessionController.ConnectionString);
        //*************End *************************
        SessionController.Users_.ProjectId = Guid.Empty.ToString();
        //SessionController.Users_.ProjectName = "";
        SessionController.Users_.ProjectName = null;
        url = "Project.aspx";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "naviagate", "naviagatetoProject('" + url + "');", true);
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "naviagate", "naviagatetoProject();", true);
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        intprojectid = new Guid(hfProjectId.Value.ToString());
        BindCloneDetails(intprojectid);
        btnEdit.Visible = false;
        btnSave.Visible = false;
        btnDelete.Visible = false;
        btn_clone.Visible = false;
        btnCancel.Visible = true;
        btn_save_clone.Visible = true;
    }

    public void BindCloneDetails(Guid intquery)
    {
        try
        {
            unlabel();
            ProjectModel pm = new ProjectModel();
            ProjectClient pc = new ProjectClient();
            DataSet ds1 = new DataSet();
            DataSet ds = new DataSet();
            pm.Project_id = intquery;

            ds1 = pc.CloneProject(pm, SessionController.ConnectionString);
            txtProjectName.Text = ds1.Tables[0].Rows[0]["ProjectName"].ToString();

            hfLogo.Value = ds1.Tables[0].Rows[0]["logo"].ToString();//added


            ds = pc.GetProjectDataById(pm, SessionController.ConnectionString);

            txtAddress1.Text = ds.Tables[0].Rows[0]["address1"].ToString();
            txtAddress2.Text = ds.Tables[0].Rows[0]["address2"].ToString();
            ddlEnabled.SelectedValue = ds.Tables[0].Rows[0]["is_enabled"].ToString();
            txtCity.Text = ds.Tables[0].Rows[0]["city"].ToString();
            ddlCountry.SelectedValue = ds.Tables[0].Rows[0]["Id"].ToString();
            ddlState.SelectedValue = ds.Tables[0].Rows[0]["state_id"].ToString();
            txtPostalCode.Text = ds.Tables[0].Rows[0]["zipcode"].ToString();


            string final_lbl = lbl_standard.Text.ToString();
            if (final_lbl.StartsWith(","))
            {
                final_lbl = final_lbl.Remove(0, 1);
            }
            if (final_lbl.EndsWith(","))
            {
                final_lbl = final_lbl.Remove(final_lbl.Length - 1, 1);
            }
            lbl_standard.Text = final_lbl;

            //  if (ds.Tables[0].Rows[0]["logo_path"].ToString() == "")earlier
            if (ds1.Tables[0].Rows[0]["logo"].ToString() == "")
            {
                ImgProjectLogo.Visible = false;
                //  lblimgmsg.Text = "No Logo";
            }
            else
            {
                ImgProjectLogo.Visible = true;

                //ImgProjectLogo.ImageUrl = ds.Tables[0].Rows[0]["logo_path"].ToString(); earlier
                ImgProjectLogo.ImageUrl = ds1.Tables[0].Rows[0]["logo"].ToString();

                lblimgmsg.Text = "";
                hfLogo.Value = Server.MapPath(ds1.Tables[0].Rows[0]["logo"].ToString());
                //hfLogo.Value = Server.MapPath(ds.Tables[0].Rows[0]["logo_path"].ToString());earlier
            }
            hflblOrganization.Value = ds.Tables[0].Rows[0]["fk_lead_organization_id"].ToString();
            hflblOwnerOrg.Value = ds.Tables[0].Rows[0]["fk_owner_organization_id"].ToString();


            hf_redirect_value.Value = "ProjectProfile";

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btn_save_clone_Click(object sender, EventArgs e)
    {

        ProjectModel pm = new ProjectModel();
        ProjectClient pc = new ProjectClient();
        DataSet ds = new DataSet();
        string s;
        try
        {
            pm.Project_id = Guid.Empty;
            pm.Project_Name = txtProjectName.Text;
            pm.Address_1 = txtAddress1.Text;
            pm.Address_2 = txtAddress2.Text;
            s = ddlEnabled.SelectedValue.ToString();
            if (s == "1")
            {
                pm.Enable_bit = "1";
            }
            else
            {
                pm.Enable_bit = "0";
            }

            pm.Lead_organization_id = new Guid(hflblOrganization.Value.ToString());
            pm.Owner_organization_id = new Guid(hflblOwnerOrg.Value.ToString());
            pm.City = txtCity.Text;
            pm.Country_id = new Guid(ddlCountry.SelectedValue.ToString());
            pm.State_id = new Guid(ddlState.SelectedValue.ToString());
            pm.User_id = new Guid(SessionController.Users_.UserId.ToString());
            pm.Postal_code = txtPostalCode.Text;

            if (hf_uniclass_id.Value != null)
            {
                if (hf_uniclass_id.Value.ToString() != "")
                {
                    pm.Standard_id_uniclass = new Guid(hf_uniclass_id.Value.ToString());
                }
                else
                {
                    pm.Standard_id_uniclass = Guid.Empty;
                }
            }
            else
            {
                pm.Standard_id_uniclass = Guid.Empty;
            }
            if (hf_MasterFormat.Value != null)
            {
                if (hf_MasterFormat.Value.ToString() != "")
                {
                    pm.Standard_id_MasterFormat = new Guid(hf_MasterFormat.Value.ToString());
                }
                else
                {
                    pm.Standard_id_MasterFormat = Guid.Empty;
                }
            }
            else
            {
                pm.Standard_id_MasterFormat = Guid.Empty;
            }

            if (hf_OmniClass2010.Value != null)
            {
                if (hf_OmniClass2010.Value.ToString() != "")
                {
                    pm.Standard_id_OmniClass2010 = new Guid(hf_OmniClass2010.Value.ToString());
                }
                else
                {
                    pm.Standard_id_OmniClass2010 = Guid.Empty;
                }
            }
            else
            {
                pm.Standard_id_OmniClass2010 = Guid.Empty;
            }

            if (hf_UniFormat.Value != null)
            {
                if (hf_UniFormat.Value.ToString() != "")
                {
                    pm.Standard_id_UniFormat = new Guid(hf_UniFormat.Value.ToString());
                }
                else
                {
                    pm.Standard_id_UniFormat = Guid.Empty;
                }
            }
            else
            {
                pm.Standard_id_UniFormat = Guid.Empty;
            }



            //pm.Logo_path = ""; earlier
            pm.Logo_path = hfLogo.Value.ToString();

            pm.Client_id = new Guid(SessionController.Users_.ClientID.ToString());
            string standard_ids = string.Empty;
            getSelectedStandards(out standard_ids);
            pm.standard_ids = standard_ids;

            ds = pc.InsertUpdateProject(pm, SessionController.ConnectionString);
            string pk_project_id = ds.Tables[0].Rows[0]["pk_project_id"].ToString();
            hfProjectId.Value = pk_project_id;
            SessionController.Users_.ProjectId = pk_project_id;
            SessionController.Users_.ProjectName = ds.Tables[0].Rows[0]["project_name"].ToString();
            btn_save_clone.Visible = false;
            SaveImage();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "navigate", "GotoProfile();", true);
            //bind_project_data(hfProjectId.Value); earlier
        }

        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        try
        {
            //imgDiv.Style["display"] = "inline";
            SaveTemporaryImage();
            lblCreatedNm.Text = hf_lead_org_name.Value;
            lblOwnerNm.Text = hf_org_name.Value;//added
        }
        catch (Exception ex)
        {
            Response.Write("SettingsProjectProfile : btnUpload_Click :- " + ex.Message.ToString());
        }
    }

    protected void SaveTemporaryImage()
    {
        DeleteFiles("~/App/ProjectAttachments/Temp");
        string filePath = "~/App/ProjectAttachments/Temp";
        string actualPath = Server.MapPath("~/App/ProjectAttachments");
        actualPath = actualPath + "\\Temp";
        DirectoryInfo oDocDirInfo = new DirectoryInfo(actualPath);
        if (!oDocDirInfo.Exists)
        {
            DirectoryInfo info = Directory.CreateDirectory(actualPath);
        }

        foreach (UploadedFile uf in ruProjectLogo.UploadedFiles)
        {

            actualPath = Path.Combine(actualPath, uf.GetName());
            uf.SaveAs(actualPath, true);
            ImgProjectLogo.Visible = true;
            ImgProjectLogo.ImageUrl = filePath + "/" + uf.GetName();
            hfLogo.Value = actualPath;
            lblimgmsg.Visible = false;
        }
    }

    protected void DeleteFiles(string logopath)
    {
        try
        {
            string targetFolder = Server.MapPath(logopath);
            DirectoryInfo targetDir = new DirectoryInfo(targetFolder);
            if (targetDir.Exists)
            {
                foreach (FileInfo file in targetDir.GetFiles())
                {
                    if ((file.Attributes & FileAttributes.ReadOnly) == 0)
                        file.Delete();
                }
            }
        }
        catch (IOException ex)
        {
            lblMsg.Text = "DeleteFiles: " + ex.Message;
        }
    }

    protected void DeleteFiless(string logopath)
    {
        try
        {
            string targetFolder = Server.MapPath(logopath);
            FileInfo targetDir = new FileInfo(targetFolder);
            if (targetDir.Exists)
            {
                if ((targetDir.Attributes & FileAttributes.ReadOnly) == 0)
                    targetDir.Delete();
            }
        }
        catch (IOException ex)
        {
            lblMsg.Text = "DeleteFiles: " + ex.Message;
        }
    }

    protected void SaveImage()
    {
        try
        {
            if (hfLogo.Value != "")
            {
                string filePath = string.Empty;
                Guid project_id = new Guid(SessionController.Users_.ProjectId.ToString());


                filePath = Server.MapPath("~/App/ProjectAttachments/" + project_id);
                string actualpath;
                DirectoryInfo oDocDirInfo = new DirectoryInfo(filePath);
                if (!oDocDirInfo.Exists)
                {
                    DirectoryInfo info = Directory.CreateDirectory(filePath);
                }

                filePath = filePath + "/" + "ProjectLogo";
                oDocDirInfo = new DirectoryInfo(filePath);

                if (!oDocDirInfo.Exists)
                {
                    DirectoryInfo info1 = Directory.CreateDirectory(filePath);
                }

                actualpath = "~/" + filePath.Substring(filePath.IndexOf("App"));
                actualpath = actualpath.Replace("\\", "/") + "/";

                string filename = string.Empty;


                if (hfLogo.Value.LastIndexOf("\\") != -1)
                {
                    filename = hfLogo.Value.Substring(hfLogo.Value.LastIndexOf("\\") + 1);
                    actualpath = actualpath + filename;

                    filePath = Path.Combine(filePath, filename);
                    filePath = filePath.Replace('/', '\\');
                    FileInfo fileinfo = new FileInfo(hfLogo.Value);

                    if (fileinfo.Exists)
                    {
                        DeleteFiless(actualpath);
                        File.Move(hfLogo.Value, filePath);

                    }
                }
                else
                {
                    filename = hfLogo.Value.Substring(hfLogo.Value.LastIndexOf("/") + 1);
                    actualpath = actualpath + filename;

                    filePath = Path.Combine(filePath, filename);
                    filePath = filePath.Replace('/', '\\');
                    FileInfo fileinfo = new FileInfo(hfLogo.Value);
                    if (fileinfo.Exists)
                    {
                        File.Move(Server.MapPath(hfLogo.Value), filePath);
                    }
                }
                ProjectModel pm = new ProjectModel();
                ProjectClient pc = new ProjectClient();

                pm.Project_id = project_id;
                pm.Logo_path = actualpath;

                pc.Save_Project_Logo_Path(pm, SessionController.ConnectionString);

                hfLogo.Value = actualpath;

                if (actualpath != "No Logo")
                {
                    ImgProjectLogo.Visible = true;
                    ImgProjectLogo.ImageUrl = hfLogo.Value;
                    lblimgmsg.Visible = false;
                }
                else
                {
                    ImgProjectLogo.Visible = false;
                    lblimgmsg.Visible = true;
                    lblimgmsg.Text = "No Logo";//added
                }
            }



        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        string url = "";
        try
        {
            if (hf_redirect_value.Value.Equals("ProjectProfile"))
            {
                //string id = Request.QueryString["pk_project_id"].ToString();
                //cdb2c8ec-a9c3-4196-9a02-94c1c8ed2d7b
                url = "ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "naviagate", "naviagatetoProject('" + url + "');", true);
            }
            else
            {
                url = "Project.aspx";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "naviagate", "naviagatetoProject('" + url + "');", true);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    public void lead_org_link(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "GotoLeadOrganizationProfile('" + hflblOrganization.Value + "');", true);
    }

    public void owner_org_link(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "GotoOwnerOrganizationProfile('" + hflblOwnerOrg.Value + "');", true);
    }

    protected void btnphase_click(object sender, EventArgs e)
    {
        bindphase();
        lblOwnerNm.Text = Convert.ToString(hftxtownerorganization_value.Value);
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                btnDelete.Visible = false;
                btnEdit.Visible = false;
                btn_clone.Visible = false;
                lblCreatedNm.Enabled = false;
                lblOwnerNm.Enabled = false;
            }
            if (SessionController.Users_.UserSystemRole == "PA")
            {
                btnDelete.Visible = false;
                btn_clone.Visible = false;
                lblCreatedNm.Enabled = false;
                lblOwnerNm.Enabled = false;

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
            DataRow dr_component = ds_component.Tables[0].Select("name='BIM Server'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Projects")
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
        if (edit_permission == "N")
        {
            btn_clone.Enabled = false;
            btnEdit.Enabled = false;
        }
        else
        {
            btn_clone.Enabled = true;
            btnEdit.Enabled = true;
        }

        if (delete_permission == "N")
        {
            btnDelete.Enabled = false;
        }
        else
        {
            btnDelete.Enabled = true;
        }
    }



    /// bind standards with custom standards
    /// 
    /// </summary>
    protected void bind_cmdstandard_v1()
    {
        DataSet ds = new DataSet();
        ProjectModel pm = new ProjectModel();
        ProjectClient pc = new ProjectClient();

        // If no project is selected, the project id is null. Checking it.
        pm.Project_id = 
            SessionController.Users_.ProjectId != null 
                ? new Guid(SessionController.Users_.ProjectId) 
                : Guid.Empty;

        ds = pc.getStandards(pm, SessionController.ConnectionString);
        cmbSelectStandard_v1.DataTextField = "standard_name";
        cmbSelectStandard_v1.DataValueField = "pk_standard_id";
        cmbSelectStandard_v1.DataSource = ds;
        cmbSelectStandard_v1.DataBind();

        for (int i = 0; i < cmbSelectStandard_v1.Items.Count; i++)
        {
            if (lbl_standard.Text.Contains(cmbSelectStandard_v1.Items[i].Text))
            {
                cmbSelectStandard_v1.Items[i].Checked = true;
            }
            else
            {
                cmbSelectStandard_v1.Items[i].Checked = false;
            }
        }


    }

    /// selected standards check event
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void cmbSelectStandard_v1_ItemChecked(object sender, RadComboBoxItemEventArgs e)
    {
        if (e.Item.Checked)
        {
            if (e.Item.Text != "MasterFormat" && e.Item.Text != "UniFormat")
            {
                for (int i = 0; i < cmbSelectStandard_v1.Items.Count; i++)
                {

                    if (cmbSelectStandard_v1.Items[i].Text != "UniFormat" && cmbSelectStandard_v1.Items[i].Text != "MasterFormat" && cmbSelectStandard_v1.Items[i].Text != e.Item.Text)
                    {
                        cmbSelectStandard_v1.Items[i].Checked = false;
                    }
                }
            }

        }


    }

    /// get selected standards
    /// 
    /// </summary>
    /// <param name="selected_standards"></param>
    protected void getSelectedStandards(out string selected_standards)
    {
        try
        {
            selected_standards = string.Empty;

            for (int i = 0; i < cmbSelectStandard_v1.Items.Count; i++)
            {
                if (cmbSelectStandard_v1.Items[i].Checked)
                {
                    selected_standards = selected_standards + "," + cmbSelectStandard_v1.Items[i].Value;
                }
            }
            if (selected_standards.Length > 1)
            {
                selected_standards = selected_standards.Substring(1, selected_standards.Length - 1);
            }
        }
        catch (Exception)
        {

            throw;
        }

    }
}