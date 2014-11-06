using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;
using TypeProfile;


public partial class App_Reports_OrganizationProfile : System.Web.UI.Page
{
    #region Global variable Declarations
    Guid OrganizationId = Guid.Empty;
    string isfromclient;
    string Master_flag = "";
    string UniClass_flag = "";
    string UniFormat_flag = "";
    string OmniClass_flag = "";
    #endregion
    #region Page  events
    protected void Page_Load(object sender, EventArgs e)
    {


        if (SessionController.Users_.UserId != null)
        {
            btnDelete.Visible = false;
            if (!IsPostBack)
            {
                //if (btnEdit.Text == "Edit")
                //if (btnEdit.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
                //{
                //    //RequiredFieldValidator3.Enabled = false;

                //}
                ////btnCancel.Visible = false;
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "SetCaption", "SetCaption();", true);

                OrganizationId = new Guid(Request.QueryString["Organization_Id"].ToString());
                str_qry.Value = OrganizationId.ToString();
                //lnk_btn_addnewCity.Visible = true;
                lnk_btn_addnewCountry.Visible = true;
                lnk_btn_addnewState.Visible = true;
                    

                // Bind all the Dropdowns with the pre-define values

                BindCountry();
                BindState();
                //BindOmniclassTypes();
                BindOrganizationTypes();

                if ((Request.QueryString["Organization_Id"].ToString()) != "00000000-0000-0000-0000-000000000000")
                {
                    BindPrimaryConcact(OrganizationId);
                    BindOrganizationInformation(OrganizationId);
                }
                else
                {
                    BindPrimaryConcact(OrganizationId);

                }


            }

            //if (btnEdit.Text == "Edit")
            //if (btnEdit.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
            //{
            //    if (SessionController.Users_.UserSystemRole.ToString() == "SA")
            //    {
            //        btnDelete.Visible = true;
            //    }
            //    btnEdit.CausesValidation = false;
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "SetCaption", "SetCaption();", true);
            //}
            //else
            //{
            //    if (SessionController.Users_.UserSystemRole.ToString() == "SA")
            //    {
            //        btnDelete.Visible = false;
            //    }
            //    btnEdit.CausesValidation = true;
            //}
            if (btnEdit.Visible == false)
            {
                btnEdit.CausesValidation = false;
                org_profile_cap.InnerText = "";
            }
            else
            {
                if (btnEdit.Text == "Save")
                    org_profile_cap.InnerText = "Request to add new organization";
                else
                    org_profile_cap.InnerText = "";

                btnEdit.CausesValidation = true;
                
            }
        }
        else
        {
            // Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }


    #endregion

    #region My Methods
    //To bind all omniclass types

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

    //protected override void InitializeCulture()
    //{
    //    string culture = Session["Culture"].ToString();
    //    if (culture == null)
    //    {


    //        culture = "en-US";
    //    }
    //    Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
    //    Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
    //}
    //private void BindOmniclassTypes()
    //{
    //    try
    //    {
    //        DataSet ds = new DataSet();
    //        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
    //        Organization.OrganizationModel mdl = new Organization.OrganizationModel();
    //        ds = obj_ctrl.GetOmniclassTypes();
    //        cmbOmniclassType.DataTextField = "Name";
    //        cmbOmniclassType.DataValueField = "Id";
    //        cmbOmniclassType.DataSource = ds;
    //        cmbOmniclassType.DataBind();

    //        //size of dropdown
    //        int cmb_size = 200;
    //        cmb_size = cmb_size < (cmbOmniclassType.Items.Count) * 18 ? cmb_size : (cmbOmniclassType.Items.Count) * 18;
    //        cmbOmniclassType.Height = cmb_size;
    //    }
    //    catch (Exception ex)
    //    {
    //        lblMessage.Text = "BindOmniclassTypes:" + ex.Message.ToString();
    //    }
    //}

    protected void show_hide_standards()
    {
        DataSet ds_TypeCount = new DataSet();

        DataSet ds = new DataSet();
        TypeModel tm = new TypeModel();
        TypeProfileClient tc = new TypeProfileClient();
        if (SessionController.Users_.ProjectId != null)
        {
            tm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
            tm.Flag = "type";
            tm.Txt_Search = "";
            ds_TypeCount = tc.bindtypepm_count_v1(tm, SessionController.ConnectionString);

            if (ds_TypeCount.Tables[2] != null)
            {
                if (ds_TypeCount.Tables[2].Rows.Count > 0)
                {
                    for (int i = 0; i < ds_TypeCount.Tables[2].Rows.Count; i++)
                    {
                        if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "MasterFormat")
                        {
                            Master_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                        }
                        else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "OmniClass 2010")
                        {
                            OmniClass_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                        }
                        else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "UniFormat")
                        {
                            UniFormat_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                        }
                        else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "UniClass")
                        {
                            UniClass_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                        }
                    }
                }
                if (UniClass_flag != "")
                {
                    hf_uniclass.Value = "Y";
                }
                else
                {
                    hf_uniclass.Value = "N";
                }
                if (OmniClass_flag != "")
                {
                    hf_omniclass.Value = "Y";
                }
                else
                {
                    hf_omniclass.Value = "N";
                }

                if (hf_omniclass.Value == "N" && hf_uniclass.Value == "N")
                {
                    td_category.Style.Add("display", "none");
                }
            }
        }
        else
        {
            td_category.Style.Add("display", "none");
        }

    }


    //To bind all organization types
    private void BindOrganizationTypes()
    {
        try
        {
            DataSet ds = new DataSet();
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            ds = obj_ctrl.GetOrganizationType();
            cmbOrganizationType.DataTextField = "name";
            cmbOrganizationType.DataValueField = "organization_type_id";
            cmbOrganizationType.DataSource = ds;
            cmbOrganizationType.DataBind();
        }
        catch (Exception ex)
        {
            lblMessage.Text = "BindOrganizationTypes:" + ex.Message.ToString();
        }
    }

    //To Disply profile of selected organization 
    private void BindOrganizationInformation(Guid OrganizationId)
    {
        try
        {
            DataSet ds = new DataSet();

            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();

            mdl.Organization_Id = OrganizationId;
            mdl.User_id = new Guid(SessionController.Users_.UserId);
            ds = obj_ctrl.GetOranizationInformation_v1(mdl);
            BindDataToControls(ds);
            disableControl();
        }
        catch (Exception ex)
        {
            lblMessage.Text = "BindOrganizationInformation" + ex.Message.ToString();
        }
    }

    //disable all  dropdowns and textboxes and enable all lables
    protected void disableControl()
    {
        //lnk_btn_addnewCity.Visible = false;
        lnk_btn_addnewCountry.Visible = false;
        lnk_btn_addnewState.Visible = false;
        txtName.ReadOnly = true;
        txtName.CssClass = "SmallTextBoxBorder";
        txtWebsite.ReadOnly = true;
        txtWebsite.CssClass = "SmallTextBoxBorder";
        txtAbbreviation.ReadOnly = true;
        txtAbbreviation.CssClass = "SmallTextBoxBorder";
        txtPostalCode.ReadOnly = true;
        txtPostalCode.CssClass = "SmallTextBoxBorder";
        txtPhone.ReadOnly = true;
        txtPhone.CssClass = "SmallTextBoxBorder";
        txtAddress2.ReadOnly = true;
        txtAddress2.CssClass = "SmallTextBoxBorder";
        txtAddress1.ReadOnly = true;
        txtAddress1.CssClass = "SmallTextBoxBorder";
        txtcity.ReadOnly = true;
        txtcity.CssClass = "SmallTextBoxBorder";
        cmb_Country.CssClass = "DropDownBorder";
        cmb_Country.Visible = false;
        lblCountry.Visible = true;
        lblCountry.CssClass = "SmallTextBoxBorder";
        cmbPrimaryContact.Visible = true;
        cmbPrimaryContact.CssClass = "DropDownBorder";
        cmbState.Visible = true;
        cmbState.CssClass = "DropDownBorder";
        lblState.Visible = true;
        lblState.CssClass = "SmallTextBoxBorder";
        cmbOrganizationType.Visible = false;
        cmbOrganizationType.CssClass = "DropDownBorder";

        //lblCity.Visible = true;
        //lblCity.CssClass = "SmallTextBoxBorder";
        lblPrimaryContact.Visible = true;
        lblOrganizationType.Visible = true;

        cmb_Country.Style["Display"] = "None";
        cmbPrimaryContact.Style["Display"] = "None";
        cmbState.Style["Display"] = "None";
        cmbOrganizationType.Style["Display"] = "None";

        //cmbCity.Style["Display"] = "None";
        btnCancel.Visible = false;
        lnkAddOmniclass.Visible = false;

    }

    //for edit mode enable all dropdowns and textboxes
    protected void enableControl()
    {
        cmb_Country.Style["Display"] = "Block";
        cmbPrimaryContact.Style["Display"] = "Block";
        cmbState.Style["Display"] = "Block";
        cmbOrganizationType.Style["Display"] = "Block";

        //cmbCity.Style["Display"] = "Block";

        //lnk_btn_addnewCity.Visible = true;//temporary
        lnk_btn_addnewCountry.Visible = true;
        lnk_btn_addnewState.Visible = true;
        txtName.ReadOnly = false;
        txtName.CssClass = "SmallTextBox";
        txtWebsite.ReadOnly = false;
        txtWebsite.CssClass = "SmallTextBox";
        txtAbbreviation.ReadOnly = false;
        txtAbbreviation.CssClass = "SmallTextBox";
        txtPostalCode.ReadOnly = false;
        txtPostalCode.CssClass = "SmallTextBox";
        txtPhone.ReadOnly = false;
        txtPhone.CssClass = "SmallTextBox";
        txtAddress2.ReadOnly = false;
        txtAddress2.CssClass = "SmallTextBox";
        txtAddress1.ReadOnly = false;
        txtAddress1.CssClass = "SmallTextBox";
        txtcity.ReadOnly = false;
        txtcity.CssClass = "SmallTextBox";
        cmb_Country.Visible = true;
        lblCountry.Visible = false;
        cmbPrimaryContact.Visible = true;
        lblPrimaryContact.Visible = false;
        cmbState.Visible = true;
        lblState.Visible = false;
        cmbOrganizationType.Visible = true;
        lblOrganizationType.Visible = false;

        lblCity.Visible = false;
        btnCancel.Visible = true;
        lnkAddOmniclass.Visible = true;

    }

    //To bind data to controls from dataset
    protected void BindDataToControls(DataSet ds)
    {
        try
        {
            // show_hide_standards();
            //btnEdit.Text = "Edit";
            if (ds.Tables[1] != null)
            {
                if (ds.Tables[1].Rows.Count == 0 && SessionController.Users_.UserRoleDescription.ToString() != "System Admin")
                    btnEdit.Visible = false;
                else
                {
                    btnEdit.Visible = true;
                    btnEdit.Text = (string)GetGlobalResourceObject("Resource", "Edit");
                }
            }
            else
                btnEdit.Text = (string)GetGlobalResourceObject("Resource", "Edit");

            //btnEdit.Text = (string)GetGlobalResourceObject("Resource", "Edit");

            //   btnCancel.Visible = true;

            if (SessionController.Users_.UserSystemRole.ToString() == "SA" || SessionController.Users_.UserRoleDescription.ToString() == "System Admin")
            {
                btnDelete.Visible = true;
                btnEdit.Visible = true;
                btnEdit.Text = (string)GetGlobalResourceObject("Resource", "Edit");
            }
            else
            {
                btnDelete.Visible = false;
            }

            txtName.Text = ds.Tables[0].Rows[0]["OrganizationName"].ToString();
            txtAbbreviation.Text = ds.Tables[0].Rows[0]["Abbreviation"].ToString();
            txtAddress1.Text = ds.Tables[0].Rows[0]["Address_1"].ToString();
            txtAddress2.Text = ds.Tables[0].Rows[0]["Address_2"].ToString();
            txtPhone.Text = ds.Tables[0].Rows[0]["phoneNumber"].ToString();
            txtPostalCode.Text = ds.Tables[0].Rows[0]["postalCode"].ToString();
            txtWebsite.Text = ds.Tables[0].Rows[0]["webSite"].ToString();
            txtcity.Text = ds.Tables[0].Rows[0]["city_name"].ToString();

            //BindCountry();
            // BindState();
            // BindOmniclassTypes();
            // BindOrganizationTypes();

            cmb_Country.SelectedValue = ds.Tables[0].Rows[0]["countryId"].ToString();
            BindState();
            cmbState.SelectedValue = ds.Tables[0].Rows[0]["stateId"].ToString();

            //bindCitiesForState(cmbState.SelectedValue);
            //cmbCity.FindItemByText(ds.Tables[0].Rows[0]["city_name"].ToString()).Selected = true;
            cmbPrimaryContact.SelectedValue = ds.Tables[0].Rows[0]["primaryContact"].ToString().ToLower();
            cmbOrganizationType.SelectedValue = ds.Tables[0].Rows[0]["fkOrganizationTypeId"].ToString().ToLower();

            lblCountry.Text = cmb_Country.SelectedItem.Text;
            lblState.Text = cmbState.SelectedItem.Text;
            if (cmbState.SelectedItem.Text.ToString() == " --Select--")
            {
                lblState.Text = "";
            }
            if (cmbPrimaryContact.SelectedValue == "00000000-0000-0000-0000-000000000000")
            {
                lblPrimaryContact.Text = "N/A";
            }
            else
            {
                lblPrimaryContact.Text = cmbPrimaryContact.SelectedItem.Text;
            }

            lblOrganizationType.Text = cmbOrganizationType.SelectedItem.Text;
            
            lbl_category.Text = ds.Tables[0].Rows[0]["omniclass_name"].ToString();
            hf_lblOmniClassid.Value = ds.Tables[0].Rows[0]["omniClassType"].ToString();



        }
        catch (Exception ex)
        {
            lblMessage.Text = "BindDataToControls" + ex.Message.ToString();
        }
    }

    //To bind city dropdown for selected state
    //private void bindCitiesForState(string stateId)
    //{
    //    try
    //    {

    //        DataSet ds = new DataSet();
    //        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
    //        Organization.OrganizationModel mdl = new Organization.OrganizationModel();
    //        mdl.StateId = new Guid(stateId.ToString());
    //        ds = obj_ctrl.GetCity(mdl);
    //        cmbCity.DataTextField = "Name";
    //        cmbCity.DataValueField = "Id";
    //        cmbCity.DataSource = ds;
    //        cmbCity.DataBind();

    //        int cmb_size = 200;
    //        cmb_size = cmb_size < (cmbCity.Items.Count) * 18 ? cmb_size : (cmbCity.Items.Count) * 18;
    //        cmbCity.Height = cmb_size;
    //        //cmbCity.SelectedItem.Text = lblCity.Text.ToString();

    //    }
    //    catch (Exception ex)
    //    {
    //        lblMessage.Text = "cmbState_SelectedIndexChanged" + ex.Message.ToString();
    //    }
    //}

    protected void unLabel()
    {
        //btnEdit.Text = "Save";
        btnEdit.Text = (string)GetGlobalResourceObject("Resource", "Save");

        // btnCancel.Visible = false;
    }

    //For Binding country names
    protected void BindCountry()
    {
        DataSet ds = new DataSet();
        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
        Organization.OrganizationModel mdl = new Organization.OrganizationModel();
        ds = obj_ctrl.getCountry();
        cmb_Country.DataTextField = "Name";
        cmb_Country.DataValueField = "Id";
        cmb_Country.DataSource = ds;
        cmb_Country.DataBind();

        int cmb_size = 200;
        cmb_size = cmb_size < (cmb_Country.Items.Count) * 18 ? cmb_size : (cmb_Country.Items.Count) * 18;
        cmb_Country.Height = cmb_size;
    }

    //To Bind State names
    protected void BindState()
    {
        try
        {
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            DataSet ds = new DataSet();
            mdl.Country_Id = new Guid(cmb_Country.SelectedValue);
            ds = obj_ctrl.getState(mdl);
            cmbState.DataTextField = "name";
            cmbState.DataValueField = "state_id";
            cmbState.DataSource = ds;
            cmbState.DataBind();

            int cmb_size = 200;
            cmb_size = cmb_size < (cmbState.Items.Count) * 18 ? cmb_size : (cmbState.Items.Count) * 18;
            cmbState.Height = cmb_size;

        }
        catch (Exception ex)
        {
            Response.Write("BindState" + ex.Message.ToString());
        }
    }

    //To bind primary contact dropdown it will contain all users of that organization
    protected void BindPrimaryConcact(Guid OrganizationId)
    {
        try
        {
            DataSet ds = new DataSet();
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            mdl.Organization_Id = OrganizationId;
            ds = obj_ctrl.GetOranizationPrimaryContact(mdl);

            cmbPrimaryContact.DataTextField = "UserName";
            cmbPrimaryContact.DataValueField = "pk_user_id";
            cmbPrimaryContact.DataSource = ds;
            cmbPrimaryContact.DataBind();

        }
        catch (Exception ex)
        {
            Response.Write("BindPrimaryConcact" + ex.Message.ToString());
        }
    }

    #endregion


    #region Event Handlers

    //It will bind all  cities related to selected state
    //protected void cmbState_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    //{
    //    try
    //    {
    //        DataSet ds = new DataSet();
    //        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
    //        Organization.OrganizationModel mdl = new Organization.OrganizationModel();
    //        mdl.StateId = new Guid(cmbState.SelectedValue.ToString());
    //        ds = obj_ctrl.GetCity(mdl);
    //        cmbCity.DataTextField = "Name";
    //        cmbCity.DataValueField = "Id";
    //        cmbCity.DataSource = ds;
    //        cmbCity.DataBind();

    //    }
    //    catch (Exception ex)
    //    {
    //        Response.Write("cmbState_SelectedIndexChanged" + ex.Message.ToString());
    //    }

    //}

    //It will bind all  states related to selected country
    protected void cmb_Country_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            mdl.Country_Id = new Guid(cmb_Country.SelectedValue.ToString());
            ds = obj_ctrl.getState(mdl);
            cmbState.DataTextField = "Name";
            cmbState.DataValueField = "state_id";
            cmbState.DataSource = ds;
            cmbState.DataBind();

        }
        catch (Exception ex)
        {
            Response.Write("cmbState_SelectedIndexChanged" + ex.Message.ToString());
        }

    }
    //To save and update organization
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
        Organization.OrganizationModel mdl = new Organization.OrganizationModel();

        Organization.OrganizationModel return_mdl = new Organization.OrganizationModel();

        DataSet ds = new DataSet();
        try
        {
            //if (btnEdit.Text == "Save")
            if (btnEdit.Text == (string)GetGlobalResourceObject("Resource", "Save"))
            {

                if (Request.QueryString["Organization_Id"] != "00000000-0000-0000-0000-000000000000")
                {
                    mdl.Organization_Id = new Guid(Request.QueryString["Organization_Id"].ToString());
                }
                else
                {
                    mdl.Organization_Id = Guid.Empty;
                }

                mdl.Organization_name = txtName.Text.Trim();
                mdl.address_line_1 = txtAddress1.Text;
                mdl.address_line_2 = txtAddress2.Text;
                mdl.Cityname = txtcity.Text;
                mdl.Abbreviation = txtAbbreviation.Text;
                mdl.web_address = txtWebsite.Text;
                mdl.Country_Id = new Guid(cmb_Country.SelectedValue.ToString());
                mdl.OrganizationType_Id = new Guid(cmbOrganizationType.SelectedValue.ToString());
                mdl.StateId = new Guid(cmbState.SelectedValue.ToString());
                //mdl.strCity = cmbCity.SelectedItem.Text;

                if (cmbPrimaryContact.SelectedValue.ToString() != "00000000-0000-0000-0000-000000000000")
                {
                    mdl.Primary_Contact_Id = new Guid(cmbPrimaryContact.SelectedValue.ToString());
                }
                else
                {
                    mdl.Primary_Contact_Id = Guid.Empty;
                }

                //if (cmbCity.SelectedValue.ToString() != "00000000-0000-0000-0000-000000000000")
                //{
                //    mdl.City_Id = new Guid(cmbCity.SelectedValue.ToString());
                //}
                //else
                //{
                //    mdl.City_Id = Guid.Empty;
                //}


                mdl.phone_number = txtPhone.Text;


                mdl.Postal_Code = txtPostalCode.Text;
                //if (cmbOmniclassType.SelectedValue.ToString() != "00000000-0000-0000-0000-000000000000")
                //{
                //    mdl.Omniclass_Type_Id = new Guid(cmbOmniclassType.SelectedValue.ToString());
                //}
                //else
                //{
                //    mdl.Omniclass_Type_Id = Guid.Empty;
                //}
                if (hf_uniclass_id.Value == "")
                {
                    mdl.Uniclass_Type_id = Guid.Empty;
                }
                else
                {
                    mdl.Uniclass_Type_id = new Guid(hf_uniclass_id.Value);
                }
                if (hf_lblOmniClassid.Value == "")
                {
                    mdl.Omniclass_Type_Id = Guid.Empty;
                }
                else
                {
                    mdl.Omniclass_Type_Id = new Guid(hf_lblOmniClassid.Value);
                }
                mdl.Login_Id = new Guid(SessionController.Users_.UserId.ToString());

                return_mdl = obj_ctrl.InsertUpdateOrganization(mdl);

                string error = return_mdl.Error.ToString();
                Guid Neworganization_id = new Guid(return_mdl.Organization_Id.ToString());
                //  btnCancel.Visible = false;
                if (error == "N")
                {
                    str_qry.Value = Neworganization_id.ToString();
                    str_name.Value = txtName.Text.Trim();
                    btnEdit.CausesValidation = false;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);
                    //  Response.Redirect("~/App/Settings/SettingsMenu.aspx?organization_id=" + Neworganization_id.ToString() + "&IsfromClient=" + hfIsfromClient.Value, false);
                }
                else
                {
                    lblMessage.Text = error.ToString();
                }

            }
            else
            {
                enableControl();
                unLabel();
                // btnCancel.Visible = false;
                string comboState = cmbState.SelectedItem.Value.ToString();

                /* For binding city */
                // bindCitiesForState(comboState);
                txtName.Focus();
                if (SessionController.Users_.UserSystemRole.ToString() == "SA")
                {
                    btnDelete.Visible = false;
                }
                btnEdit.CausesValidation = true;
            }
        }


        catch (Exception ex)
        {
            lblMessage.Text = "btnEdit_Click" + ex.Message.ToString();
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //if (SessionController.Users_.UserSystemRole == "SA")
        //{
        //    Response.Redirect("~/App/Settings/Organizations.aspx?flag=nomaster", false);
        //}
        //else
        //{
        string id = Request.QueryString["Organization_Id"].ToString();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "getQueryVariable('" + id + "');", true);
        //}


    }

    protected void btnrefresh_Click(object sender, EventArgs e)
    {
        BindCountry();
        BindState();
        // Bindcity();

    }
    protected void btnrefresh_state_Click(object sender, EventArgs e)
    {
        BindState();


    }
    #endregion

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
        Organization.OrganizationModel mdl = new Organization.OrganizationModel();
        // mdl.Organization_Id = new Guid(Request.QueryString["Organization_Id"].ToString());

        mdl.Organization_Id = new Guid(Request.QueryString["organization_id"].ToString());
        obj_ctrl.DeleteOrganization(mdl);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "organization", "Navigate();", true);
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "CBU")
            {
                btnEdit.Enabled = false;

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
                if (dr_profile["name"].ToString() == "Organizations")
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
            btnEdit.Enabled = false;
        }
        else
        {
            btnEdit.Enabled = true;
        }
    }

}