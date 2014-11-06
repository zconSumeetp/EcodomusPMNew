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
using User;

public partial class App_Asset_AddManufacturerOrganization : System.Web.UI.Page
{
    #region Global variable Declarations
    Guid OrganizationId = Guid.Empty;
    string isfromclient;
    #endregion
    #region Page  events
    protected void Page_Load(object sender, EventArgs e)
    {


        if (SessionController.Users_.UserId != null)
        {

            if (!IsPostBack)
            {
                if (Request.QueryString["FromType"] != null)
                {
                    if (Request.QueryString["FromType"].ToString() == "Y")
                    {
                        btnback.Visible = true;
                        btnCancel.Visible = false;
                        btndelete.Visible = false; // visible false
                    }
                }
                else
                {
                    btnback.Visible = true;
                    btnCancel.Visible = false;
                    btndelete.Visible = false;
                }
                if (btnEdit.Text == "Edit")
                {
                    //RequiredFieldValidator3.Enabled = false;
                }
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "SetCaption", "SetCaption();", true);

                OrganizationId = new Guid(Request.QueryString["Organization_Id"].ToString());
                hfOrganizationid.Value = Convert.ToString(OrganizationId);
                str_qry.Value = OrganizationId.ToString();
                //lnk_btn_addnewCity.Visible = true;
                lnk_btn_addnewCountry.Visible = true;
                lnk_btn_addnewState.Visible = true;


                // Bind all the Dropdowns with the pre-define values

                BindCountry();
                BindState();
                BindOmniclassTypes();
                BindOrganizationTypes();
                bindSystemRoles();          // for organization primary contact
                if ((Request.QueryString["Organization_Id"].ToString()) != "00000000-0000-0000-0000-000000000000")
                {
                    // BindPrimaryConcact(OrganizationId);
                    BindOrganizationInformation(OrganizationId);
                }
                else
                {
                    // BindPrimaryConcact(OrganizationId);

                }
                //Select header for popup
                if (Request.QueryString["IsDesigner"] != null)
                {
                    if ((Request.QueryString["IsDesigner"].ToString()) == "Y")
                    {
                        //lbl_header.Text = (string)GetGlobalResourceObject("Resource", "Add_Designer");
                        //setTitleToWindow('Add_Designer');
                        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'> setTitleToWindow('Add Designer');</script>", false);
                    }
                    else if ((Request.QueryString["IsDesigner"].ToString()) == "N")
                    {
                        //lbl_header.Text = (string)GetGlobalResourceObject("Resource", "Add_Contractor");
                       
                        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'> setTitleToWindow('Add Contractor');</script>", false);
                    }
                }
                else
                {

                    //lbl_header.Text = (string)GetGlobalResourceObject("Resource", "Add_Manufacturer");
                   //setTitleToWindow('Add_Manufacturer');
                     ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'> setTitleToWindow('Add Manufacturer');</script>", false);
                }


            }
        }
        else
        {
            Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
        }
    }


    #endregion

    #region My Methods
    //To bind all omniclass types
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
    private void BindOmniclassTypes()
    {
        try
        {
            DataSet ds = new DataSet();
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            ds = obj_ctrl.GetOmniclassTypes();
            cmbOmniclassType.DataTextField = "Name";
            cmbOmniclassType.DataValueField = "Id";
            cmbOmniclassType.DataSource = ds;
            cmbOmniclassType.DataBind();
            string omniclasstype = ds.Tables[0].Rows[0]["Name"].ToString();
            if (cmbOmniclassType.FindItemByText(omniclasstype.ToString()) != null)
            {
                cmbOmniclassType.FindItemByText("34-65 11 11 Corporation").Selected = true;
                //cmbOmniclassType.FindItemByText("34-65 11 11 Corporation").Selected = true;
            }

            //size of dropdown
            int cmb_size = 200;
            cmb_size = cmb_size < (cmbOmniclassType.Items.Count) * 18 ? cmb_size : (cmbOmniclassType.Items.Count) * 18;
            cmbOmniclassType.Height = cmb_size;
        }
        catch (Exception ex)
        {
            lblMessage.Text = "BindOmniclassTypes:" + ex.Message.ToString();
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
            if (Request.QueryString["IsDesigner"] != null)
            {
                if ((Request.QueryString["IsDesigner"].ToString()) == "Y")
                {
                   // cmbOrganizationType.FindItemByText("Designer").Selected = true;
                    cmbOrganizationType.FindItemByText("Architects or Engineers").Selected = true;
                }
                else if ((Request.QueryString["IsDesigner"].ToString()) == "N")
                {
                  //  cmbOrganizationType.FindItemByText("Contractor").Selected = true;
                    cmbOrganizationType.FindItemByText("General Contractor").Selected = true;
                }
            }
            else
            {
                cmbOrganizationType.FindItemByText("Manufacturer").Selected = true;
            }
            //if (cmbOrganizationType.FindItemByText("Manufacturer") != null)
            //{
            //    cmbOrganizationType.FindItemByText("Manufacturer").Selected = true;
            //}
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
            ds = obj_ctrl.GetOranizationInformation(mdl);
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
        //cmbPrimaryContact.Visible = true;
        //cmbPrimaryContact.CssClass = "DropDownBorder";
        cmbState.Visible = true;
        cmbState.CssClass = "DropDownBorder";
        lblState.Visible = true;
        lblState.CssClass = "SmallTextBoxBorder";
        cmbOrganizationType.Visible = false;
        cmbOrganizationType.CssClass = "DropDownBorder";
        cmbOmniclassType.Visible = false;
        cmbOmniclassType.CssClass = "DropDownBorder";
        //lblCity.Visible = true;
        //lblCity.CssClass = "SmallTextBoxBorder";
        //lblPrimaryContact.Visible = true;
        lblOrganizationType.Visible = true;
        lblOmniclassType.Visible = true;
        cmb_Country.Style["Display"] = "None";
        //cmbPrimaryContact.Style["Display"] = "None";
        cmbState.Style["Display"] = "None";
        cmbOrganizationType.Style["Display"] = "None";
        cmbOmniclassType.Style["Display"] = "None";
        //cmbCity.Style["Display"] = "None";

    }

    //for edit mode enable all dropdowns and textboxes
    protected void enableControl()
    {
        cmb_Country.Style["Display"] = "Block";
        //cmbPrimaryContact.Style["Display"] = "Block";
        cmbState.Style["Display"] = "Block";
        cmbOrganizationType.Style["Display"] = "Block";
        cmbOmniclassType.Style["Display"] = "Block";
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
        //cmbPrimaryContact.Visible = true;
        //lblPrimaryContact.Visible = false;
        cmbState.Visible = true;
        lblState.Visible = false;
        cmbOrganizationType.Visible = true;
        lblOrganizationType.Visible = false;
        cmbOmniclassType.Visible = true;
        lblOmniclassType.Visible = false;
        lblCity.Visible = false;
    }

    //To bind data to controls from dataset
    protected void BindDataToControls(DataSet ds)
    {
        try
        {

            btnEdit.Text = "Edit";
            btnCancel.Visible = false;
            if (SessionController.Users_.UserSystemRole.ToString() == "SA")
            {
                btndelete.Visible = true;

            }
            else
            {
                btndelete.Visible = false;
            }
            txtName.Text = ds.Tables[0].Rows[0]["OrganizationName"].ToString();
            txtAbbreviation.Text = ds.Tables[0].Rows[0]["Abbreviation"].ToString();
            txtAddress1.Text = ds.Tables[0].Rows[0]["Address_1"].ToString();
            txtAddress2.Text = ds.Tables[0].Rows[0]["Address_2"].ToString();
            txtPhone.Text = ds.Tables[0].Rows[0]["phoneNumber"].ToString();
            txtPostalCode.Text = ds.Tables[0].Rows[0]["postalCode"].ToString();
            txtWebsite.Text = ds.Tables[0].Rows[0]["webSite"].ToString();
            txtcity.Text = ds.Tables[0].Rows[0]["city_name"].ToString();

            cmb_Country.SelectedValue = ds.Tables[0].Rows[0]["countryId"].ToString();
            cmbState.SelectedValue = ds.Tables[0].Rows[0]["stateId"].ToString();

            //bindCitiesForState(cmbState.SelectedValue);
            //cmbCity.FindItemByText(ds.Tables[0].Rows[0]["city_name"].ToString()).Selected = true;
            //cmbPrimaryContact.SelectedValue = ds.Tables[0].Rows[0]["primaryContact"].ToString().ToLower();
            cmbOrganizationType.SelectedValue = ds.Tables[0].Rows[0]["fkOrganizationTypeId"].ToString().ToLower();
            cmbOmniclassType.SelectedValue = ds.Tables[0].Rows[0]["omniClassType"].ToString().ToLower();
            lblCountry.Text = cmb_Country.SelectedItem.Text;
            lblState.Text = cmbState.SelectedItem.Text;


            //if (cmbPrimaryContact.SelectedValue == "00000000-0000-0000-0000-000000000000")
            //{
            //    lblPrimaryContact.Text = "N/A";
            //}
            //else
            //{
            //    lblPrimaryContact.Text = cmbPrimaryContact.SelectedItem.Text;
            //}
            //if (cmbCity.SelectedItem.Text == " --Select--")
            //{
            //    lblCity.Text = "N/A";
            //}
            //else
            //{
            //    lblCity.Text = cmbCity.SelectedItem.Text;
            //}
            if (cmbOmniclassType.SelectedValue.Equals("00000000-0000-0000-0000-000000000000"))
            {
                lblOmniclassType.Text = "N/A";
            }
            else
            {
                lblOmniclassType.Text = cmbOmniclassType.SelectedItem.Text;
            }
            lblOrganizationType.Text = cmbOrganizationType.SelectedItem.Text;
        }
        catch (Exception ex)
        {
            lblMessage.Text = "BindDataToControls" + ex.Message.ToString();
        }
    }


    protected void unLabel()
    {
        btnEdit.Text = "Save";
        btnCancel.Visible = true;
        btndelete.Visible = false;
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
        //cmb_Country.Height = cmb_size;
        cmb_Country.Height = 100;
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
            //cmbState.Height = cmb_size;
            cmbState.Height = 100;
        }
        catch (Exception ex)
        {
            Response.Write("BindState" + ex.Message.ToString());
        }
    }

    //To bind primary contact dropdown it will contain all users of that organization
    //protected void BindPrimaryConcact(Guid OrganizationId)
    //{
    //    try
    //    {
    //        DataSet ds = new DataSet();
    //        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
    //        Organization.OrganizationModel mdl = new Organization.OrganizationModel();
    //        mdl.Organization_Id = OrganizationId;
    //        ds = obj_ctrl.GetOranizationPrimaryContact(mdl);

    //        cmbPrimaryContact.DataTextField = "UserName";
    //        cmbPrimaryContact.DataValueField = "pk_user_id";
    //        cmbPrimaryContact.DataSource = ds;
    //        cmbPrimaryContact.DataBind();

    //    }
    //    catch (Exception ex)
    //    {
    //        Response.Write("BindPrimaryConcact" + ex.Message.ToString());
    //    }
    //}

    public void InsertUser()
    {
        try
        {
            UserClient ctrl = new UserClient();
            UserModel mdl = new UserModel();
            mdl.UserId = Guid.Empty;
            mdl.Firstname = txtFirstName.Text.ToString();
            mdl.Phone = txtPhone.Text.ToString();
            mdl.LastName = txtLastName.Text.ToString();
            mdl.Email = txtEmail.Text.ToString();
            mdl.Title = txtLastName.Text.ToString();
            mdl.Address1 = txtAddress1.Text.ToString();
            if (hf_NewOrganizationid.Value != "")
            {
                mdl.OrganizationId = new Guid(hf_NewOrganizationid.Value.ToString());
            }
            else
            {
                mdl.OrganizationId = Guid.Empty;
            }
            mdl.Address2 = txtAddress2.Text.ToString();
            mdl.SystemRoleId = new Guid(hf_SystemRole.Value.ToString());
            mdl.City = txtcity.Text.ToString();
            mdl.UserName = txtFirstName.Text.ToString();
            mdl.StateId = new Guid(cmbState.SelectedValue);
            mdl.Passward = txtFirstName.Text;
            mdl.Postal = txtPostalCode.Text.ToString();
            mdl.Abbreviation = txtAbbreviation.Text.ToString();
            mdl.CountryId = new Guid(cmb_Country.SelectedValue);
            // for user omniclass 
            if (cmbOmniclassType.FindItemByText("34-31 11 00 Manufacturer") != null)
            {
                cmbOmniclassType.FindItemByText("34-31 11 00 Manufacturer").Selected = true;
            }
            mdl.OmniclassType = new Guid(cmbOmniclassType.SelectedValue);
            if (cmbOmniclassType.FindItemByText("34-65 11 11 Corporation") != null)
            {
                cmbOmniclassType.FindItemByText("34-65 11 11 Corporation").Selected = true;
            }
            //
            string NewUserId = ctrl.InsertUpdateUser(mdl);
            if (NewUserId == "00000000-0000-0000-0000-000000000000")
            {
                lblMessage.Text = "This username already exists!";
                lblMessage.Visible = true;
            }
            else
            {
                mdl.UserId = new Guid(NewUserId);
                mdl.OrganizationId = new Guid(hf_NewOrganizationid.Value);
                ctrl.UpdateUserManufacturer(mdl);

            }

        }
        catch (Exception es)
        {
            throw es;
        }

    }
    public void InsertIntoClientOrganizationLinkup()
    {
        try
        {
            ClientOrganization.ClientOrganizationClient OrganizationClient1 = new ClientOrganization.ClientOrganizationClient();

            ClientOrganization.ClientOrganizationModel OrganizationModel1 = new ClientOrganization.ClientOrganizationModel();

            OrganizationModel1.ClientId = new Guid(SessionController.Users_.ClientID);
            OrganizationModel1.Organization_Id = new Guid(hf_NewOrganizationid.Value);
            OrganizationModel1.Request_status = "A";
            OrganizationModel1.User_Id = new Guid(SessionController.Users_.UserId);
            OrganizationModel1.Project_id = new Guid(SessionController.Users_.ProjectId);
            OrganizationClient1.InsertintoClientOrganizationLinkup(OrganizationModel1, SessionController.ConnectionString);

        }
        catch (Exception ex)
        {

            throw ex;
        }



    }


    protected void bindSystemRoles()
    {
        DataSet ds = new DataSet();
        try
        {
            UserClient ctrl = new UserClient();
            UserModel mdl = new UserModel();
            mdl.UserId = new Guid(SessionController.Users_.UserId);
            ds = ctrl.GetSystemRoles(mdl);
            if (ds.Tables[0].Rows.Count > 0)
            {
                hf_SystemRole.Value = ds.Tables[0].Rows[3]["systemRoleId"].ToString();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion


    #region Event Handlers


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
            if (btnEdit.Text == "Save")
            {


                if (Request.QueryString["Organization_Id"] != "00000000-0000-0000-0000-000000000000")
                {
                    mdl.Organization_Id = new Guid(Request.QueryString["Organization_Id"].ToString());
                }
                else
                {
                    mdl.Organization_Id = Guid.Empty;
                }

                mdl.ClientId = new Guid(SessionController.Users_.ClientID);
                mdl.Organization_name = txtName.Text.Trim();
                mdl.address_line_1 = txtAddress1.Text;
                mdl.address_line_2 = txtAddress2.Text;
                mdl.Cityname = txtcity.Text;
                mdl.Abbreviation = txtAbbreviation.Text;
                mdl.web_address = txtWebsite.Text;
                mdl.Country_Id = new Guid(cmb_Country.SelectedValue.ToString());
                mdl.OrganizationType_Id = new Guid(cmbOrganizationType.SelectedValue.ToString());
                mdl.StateId = new Guid(cmbState.SelectedValue.ToString());

                mdl.phone_number = txtPhone.Text;
                mdl.Postal_Code = txtPostalCode.Text;
                if (cmbOmniclassType.SelectedValue.ToString() != "00000000-0000-0000-0000-000000000000")
                {
                    mdl.Omniclass_Type_Id = new Guid(cmbOmniclassType.SelectedValue.ToString());
                }
                else
                {
                    mdl.Omniclass_Type_Id = Guid.Empty;
                }

                mdl.Login_Id = new Guid(SessionController.Users_.UserId.ToString());
                return_mdl = obj_ctrl.InsertUpdateOrganization(mdl);

                string error = return_mdl.Error.ToString();
                Guid Neworganization_id = new Guid(return_mdl.Organization_Id.ToString());
                hf_NewOrganizationid.Value = Neworganization_id.ToString();
                // add primary contact for organization

                if (error == "N")
                {
                    if (Request.QueryString["IsfromClient"] != null)
                    {
                        if (Request.QueryString["IsfromClient"].ToString() == "Y")
                        {
                            if (Request.QueryString["IsDesigner"] != null)
                            {
                                if (Request.QueryString["IsFromTypePM"] != null)
                                {
                                    if ((Request.QueryString["IsDesigner"].ToString() == "Y"))
                                    {
                                        if (Request.QueryString["IsFromTypePM"].ToString() == "Y")
                                        {
                                            Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?flag=Designer", false);

                                        }
                                    }
                                    else
                                    {

                                        if (Request.QueryString["IsDesigner"] != "N")
                                        {
                                            Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?flag=Designer", false);
                                        }
                                        else if (Request.QueryString["IsDesigner"] == "N")
                                        {
                                            Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?flag=Contractor", false);
                                        }



                                    }
                                }
                                else
                                {
                                    if (Request.QueryString["IsFromTypePM"] != null)
                                    {
                                        if (Request.QueryString["IsFromTypePM"].ToString() == "Y")
                                        {
                                            Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?flag=Contractor", false);

                                        }
                                        else
                                        {
                                            Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?flag=Contractor", false);
                                        }
                                    }
                                    else
                                    {
                                        Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?flag=Contractor", false);
                                    }
                                }
                            }
                            else
                            {
                                Response.Redirect("~/App/Asset/AddSelectManufacturerpopup.aspx", false);
                            }
                        }
                    }
                    else
                    {
                        str_qry.Value = Neworganization_id.ToString();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);

                    }
                    //  Response.Redirect("~/App/Settings/SettingsMenu.aspx?organization_id=" + Neworganization_id.ToString() + "&IsfromClient=" + hfIsfromClient.Value, false);
                    InsertUser();
                    InsertIntoClientOrganizationLinkup();
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
                string comboState = cmbState.SelectedItem.Value.ToString();

                /* For binding city */
                // bindCitiesForState(comboState);

            }
        }


        catch (Exception ex)
        {
            lblMessage.Text = "btnEdit_Click" + ex.Message.ToString();
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["IsDesigner"] != null)
        {
            // Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?flag=Designer", false);
            if (Request.QueryString["IsDesigner"].ToString() == "Y")
            {
                if (Request.QueryString["IsFromTypePM"] != null)
                {
                    if (Request.QueryString["IsFromTypePM"].ToString() == "Y")
                    {
                        Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?", false);

                    }
                    else
                    {
                        Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?flag=Designer", false);
                    }
                }
                else
                {
                    Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?flag=Designer", false);
                }
            }
            else
            {
                if (Request.QueryString["IsFromTypePM"] != null)
                {
                    if (Request.QueryString["IsFromTypePM"].ToString() == "Y")
                    {
                        Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?", false);

                    }
                    else
                    {
                        Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?flag=Contractor", false);
                    }
                }
                else
                {
                    Response.Redirect("~/App/Asset/EditDesignerContractorNew.aspx?flag=Contractor", false);
                }
            }
        }

        else
        {
            //Response.Redirect("~/App/Asset/AddSelectManufacturerpopup.aspx", false);
            Response.Redirect("~/App/Asset/AddSelectManufacturerpopup.aspx?Name=undefined&popupflag=", false);
            
        }
    }

    protected void btnrefresh_Click(object sender, EventArgs e)
    {
        BindCountry();
        BindState();
        BindOrganizationTypes();

    }

    protected void btnrefreshcmbcountry_click(object sender, EventArgs e)
    {
        BindCountry();
    }

    protected void btndelete_Click(object sender, EventArgs e)
    {
        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
        Organization.OrganizationModel mdl = new Organization.OrganizationModel();
        // mdl.Organization_Id = new Guid(Request.QueryString["Organization_Id"].ToString());
        mdl.Organization_Id = new Guid(hfOrganizationid.Value);
        obj_ctrl.DeleteOrganization(mdl);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "organization", "Navigate();", true);
    }
    protected void btnrefreshState_Click(object sender, EventArgs e)
    {
        BindState();
    }


    #endregion


}