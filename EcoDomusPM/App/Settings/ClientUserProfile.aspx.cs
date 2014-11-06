using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dashboard;
using Telerik.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using User;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;
using TypeProfile;
using System.Text.RegularExpressions;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Mail.Control;
using EcoDomus.Mail.Model;
using System.Configuration;
using System.Text;

public partial class App_Settings_ClientUserProfile : System.Web.UI.Page
{
    #region Global Variable Declaration
    string userId;
    string Master_flag = "";
    string UniClass_flag = "";
    string UniFormat_flag = "";
    string OmniClass_flag = "";
    #endregion


    #region Page Event
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId == null)
            {
                Response.Redirect("~\\app\\LoginPM.aspx?Error=Session",true);
            }
            else if (!SessionController.Users_.UserId.Equals(string.Empty))
            {
                string url = @"~/App/Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=" + SessionController.Users_.UserSystemRole;
                Response.Redirect(url,true);

                userId = SessionController.Users_.UserId;
                cmbSystemRole.Enabled = false;
                if (!IsPostBack)
                {
                    bindCountry();
                    bindState();
                    //bindCity();
                    bindSystemRoles();
                   // BindOmniclassTypes();
                    BindViewer();
                    bindUserDetails(new Guid(userId.ToString()));
                    EnabledDisable('Y');
                }
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);
        }
        catch (Exception)
        {
            //Response.Redirect("~\\app\\Login.aspx?Error=Session");
        }
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            //if (SessionController.Users_.UserSystemRole == "CBU")
            //{
            //    tdlblViewer.Visible = false;
            //    cmbViewer.Visible = false;
            //    lblViewer.Visible = false;
            //}
        }
        catch (Exception ex)
        {
        }
    }
    #endregion

    #region My Methods
    //get all system roles for user
    protected void bindSystemRoles()
    {
        DataSet ds = new DataSet();
        try
        {
            UserClient ctrl = new UserClient();
            UserModel mdl = new UserModel();
            mdl.UserId = new Guid(SessionController.Users_.UserId);
            ds = ctrl.GetSystemRoles(mdl);
            cmbSystemRole.DataValueField = "systemRoleId";
            cmbSystemRole.DataTextField = "systemRole";
            cmbSystemRole.DataSource = ds;
            cmbSystemRole.DataBind();

            //size of dropdown
            int cmb_size = 250;
            cmb_size = cmb_size < (cmbSystemRole.Items.Count) * 18 ? cmb_size : (cmbSystemRole.Items.Count) * 18;
            cmbSystemRole.Height = cmb_size;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //bind country dropdown with USA as default
    protected void bindCountry()
    {
        DataSet ds = new DataSet();
        try
        {
            UserClient ctrl = new UserClient();
            UserModel mdl = new UserModel();
            ds = ctrl.GetCountry();
            cmbCountry.DataValueField = "Id";
            cmbCountry.DataTextField = "Name";
            cmbCountry.DataSource = ds;
            cmbCountry.DataBind();
            cmbCountry.SelectedItem.Text = "USA";

            //size of dropdown
            int cmb_size = 250;
            cmb_size = cmb_size < (cmbCountry.Items.Count) * 18 ? cmb_size : (cmbCountry.Items.Count) * 18;
            cmbCountry.Height = cmb_size;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //bind state dropdown
    protected void bindState()
    {

        DataSet ds = new DataSet();
        try
        {
            UserClient ctrl = new UserClient();
            UserModel mdl = new UserModel();
            mdl.CountryId = new Guid(cmbCountry.SelectedValue);
            ds = ctrl.bindState(mdl);
            cmbState.DataValueField = "state_id";
            cmbState.DataTextField = "name";
            cmbState.DataSource = ds;
            cmbState.DataBind();

            //size of dropdown
            int cmb_size = 250;
            cmb_size = cmb_size < (cmbState.Items.Count) * 18 ? cmb_size : (cmbState.Items.Count) * 18;
            cmbState.Height = cmb_size;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //bind city dropdown
    //protected void bindCity()
    //{
    //    DataSet ds = new DataSet();
    //    try
    //    {
    //        UserClient ctrl = new UserClient();
    //        UserModel mdl = new UserModel();
    //        mdl.StateId = new Guid(cmbState.SelectedValue);
    //        ds = ctrl.GetCity(mdl);
    //        cmbCity.DataValueField = "city_id";
    //        cmbCity.DataTextField = "name";
    //        cmbCity.DataSource = ds;
    //        cmbCity.DataBind();

    //        //size of dropdown
    //        int cmb_size = 250;
    //        cmb_size = cmb_size < (cmbCity.Items.Count) * 18 ? cmb_size : (cmbCity.Items.Count) * 18;
    //        cmbCity.Height = cmb_size;
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    //get user details of particular user
    protected void bindUserDetails(Guid intQuery)
    {
        DataSet ds = new DataSet();
        try
        {
            //show_hide_standards();
            UserClient ctrl = new UserClient();
            UserModel mdl = new UserModel();
            mdl.UserId = intQuery;
            ds = ctrl.GetUserDetails(mdl);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblAbbreviation.Text = ds.Tables[0].Rows[0]["abbreviation"].ToString();
                txtAbbreviation.Text = ds.Tables[0].Rows[0]["abbreviation"].ToString();
                lblAddress1.Text = ds.Tables[0].Rows[0]["address_line_1"].ToString();
                txtAddress1.Text = ds.Tables[0].Rows[0]["address_line_1"].ToString();
                lblAddress2.Text = ds.Tables[0].Rows[0]["address_line_2"].ToString();
                txtAddress2.Text = ds.Tables[0].Rows[0]["address_line_2"].ToString();
                lblCity.Text = ds.Tables[0].Rows[0]["city"].ToString();
                txtcity.Text = ds.Tables[0].Rows[0]["city"].ToString();
                lblCountry.Text = ds.Tables[0].Rows[0]["country_name"].ToString();
                cmbCountry.FindItemByText(lblCountry.Text.ToString()).Selected = true;
                lblEmail.Text = ds.Tables[0].Rows[0]["email_address"].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0]["email_address"].ToString();
                lblFirstName.Text = ds.Tables[0].Rows[0]["first_name"].ToString();
                txtFirstName.Text = ds.Tables[0].Rows[0]["first_name"].ToString();
                lblLastName.Text = ds.Tables[0].Rows[0]["last_name"].ToString();
                txtLastName.Text = ds.Tables[0].Rows[0]["last_name"].ToString();
                lblOrganization.Text = ds.Tables[0].Rows[0]["organization_name"].ToString();
                txtOrganizationId.Text = ds.Tables[0].Rows[0]["organization_id"].ToString();

                CryptoHelper crypto = new CryptoHelper();
                txtPassword.Text = crypto.Decrypt(ds.Tables[0].Rows[0]["password"].ToString());
                hfPassward.Value = txtPassword.Text;
                
                txtPassword.Attributes.Add("value", hfPassward.Value.ToString());
                lblPhoneNo.Text = ds.Tables[0].Rows[0]["phone_number"].ToString();
                txtPhoneNo.Text = ds.Tables[0].Rows[0]["phone_number"].ToString();
                lblPostalCode.Text = ds.Tables[0].Rows[0]["postal_code"].ToString();
                txtPostalCode.Text = ds.Tables[0].Rows[0]["postal_code"].ToString();
                lblViewer.Text = ds.Tables[0].Rows[0]["viewer_name"].ToString();
                cmbViewer.SelectedValue = ds.Tables[0].Rows[0]["pk_viewer_id"].ToString();
                lblstate.Text = ds.Tables[0].Rows[0]["state_name"].ToString();
                if (ds.Tables[0].Rows[0]["state_name"].ToString() != "")
                {
                    bindState();
                    cmbState.FindItemByText(ds.Tables[0].Rows[0]["state_name"].ToString()).Selected = true;
                }

                lblSystemRole.Text = ds.Tables[0].Rows[0]["system_role"].ToString();
                cmbSystemRole.FindItemByText(ds.Tables[0].Rows[0]["system_role"].ToString()).Selected = true;
                lblTitle.Text = ds.Tables[0].Rows[0]["title"].ToString();
                txtTitle.Text = ds.Tables[0].Rows[0]["title"].ToString();
                lblUsername.Text = ds.Tables[0].Rows[0]["username"].ToString();
                txtUsername.Text = ds.Tables[0].Rows[0]["username"].ToString();
               // lblOmniClass.Text = ds.Tables[0].Rows[0]["OmniclassType"].ToString();
                if (!ds.Tables[0].Rows[0]["omniclass_id"].ToString().Equals(""))
                {
                  
                    //cmbOmniClass.FindItemByValue(ds.Tables[0].Rows[0]["omniclass_id"].ToString()).Selected = true;
                }
                //if (hf_uniclass.Value != "")
                //{
                //    if (hf_uniclass.Value == "Y")
                //    {
                //        lbl_category.Text = ds.Tables[0].Rows[0]["uniclassType"].ToString();
                //        hf_uniclass_id.Value = ds.Tables[0].Rows[0]["uniclass_id"].ToString();
                //    }
                //    else
                //    {
                        lbl_category.Text = ds.Tables[0].Rows[0]["OmniclassType"].ToString();
                        hf_lblOmniClassid.Value = ds.Tables[0].Rows[0]["omniclass_id"].ToString();
                //    }
                //}

                EnabledDisable('Y');
            }
            else
            {
                EnabledDisable('N');
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void EnabledDisable(char flag)
    {
        if (flag.Equals('Y'))
        {
            lblAbbreviation.Visible = true;
            lblAddress1.Visible = true;
            lblAddress2.Visible = true;
            lblCity.Visible = true;
            lblCountry.Visible = true;
            lblEmail.Visible = true;
            lblFirstName.Visible = true;
            lblLastName.Visible = true;
            //lblOmniClass.Visible=true;
            lblOrganization.Visible = true;
            txtPassword.Visible = true;
            txtPassword.ReadOnly = false;
            txtPassword.CssClass = "SmallTextBoxBorder";
            lblPhoneNo.Visible = true;
            lblPostalCode.Visible = true;
            lblstate.Visible = true;
            lblSystemRole.Visible = true;
            lblTitle.Visible = true;
            lblUsername.Visible = true;
            //lblOmniClass.Visible = true;
            lblViewer.Visible = true;
            //lnk_btn_addnewCity.Visible = false;
            lnk_btn_addnewCountry.Visible = false;
            lnk_btn_addnewState.Visible = false;
            btnCancel.Visible = false;

            txtAbbreviation.Visible = false;
            txtAddress1.Visible = false;
            txtAddress2.Visible = false;
            txtEmail.Visible = false;
            txtFirstName.Visible = false;
            txtLastName.Visible = false;
            txtPhoneNo.Visible = false;
            txtPostalCode.Visible = false;
            cmbState.Visible = false;
            txtTitle.Visible = false;
            txtUsername.Visible = false;
            //cmbCity.Visible = false;
            txtcity.Visible = false;
            cmbCountry.Visible = false;
            lnkAddOmniclass.Visible = false;
            //cmbOmniClass.Visible = false;
            cmbSystemRole.Visible = false;
            btnSelectOrganization.Visible = false;
           // cmbOmniClass.Visible = false;
            cmbViewer.Visible = false;
            //btnSave.Text = "Edit";
            btnSave.Text = (string)GetGlobalResourceObject("Resource", "Edit");
            
        }

        else if (flag.Equals('N'))
        {
            lblAbbreviation.Visible = false;
            lblAddress1.Visible = false;
            lblAddress2.Visible = false;
            lblCity.Visible = false;
            lblCountry.Visible = false;
            lblEmail.Visible = false;
            lblFirstName.Visible = false;
            lblLastName.Visible = false;
            txtPassword.CssClass = "SmallTextBox";
            txtPassword.ReadOnly = false;
            lblPhoneNo.Visible = false;
            lblPostalCode.Visible = false;
            lblstate.Visible = false;
            lblSystemRole.Visible = false;
            lblTitle.Visible = false;
            lblUsername.Visible = false;
            //lblOmniClass.Visible = false;
            lblViewer.Visible = false;
            //lnk_btn_addnewCity.Visible = true;
            lnk_btn_addnewCountry.Visible = true;
            lnk_btn_addnewState.Visible = true;
            btnCancel.Visible = true;

            txtAbbreviation.Visible = true;
            txtAddress1.Visible = true;
            txtAddress2.Visible = true;
            txtEmail.Visible = true;
            txtFirstName.Visible = true;
            txtLastName.Visible = true;
            txtPassword.Visible = true;
            txtPhoneNo.Visible = true;
            txtPostalCode.Visible = true;
            cmbState.Visible = true;
            txtTitle.Visible = true;
            txtUsername.Visible = true;
            //cmbCity.Visible = true;
            txtcity.Visible = true;
            cmbCountry.Visible = true;
            lnkAddOmniclass.Visible = true;
           // cmbOmniClass.Visible = true;
            cmbSystemRole.Visible = true;
            btnSelectOrganization.Visible = false;
           // cmbOmniClass.Visible = true;
            cmbViewer.Visible = true;
            //btnSave.Text = "Save";
            btnSave.Text = (string)GetGlobalResourceObject("Resource", "Save");
            
            lblMessage.Text = "";
        }
    }

    //bind omniclass dropdown
    //protected void BindOmniclassTypes()
    //{
    //    try
    //    {
    //        DataSet ds = new DataSet();
    //        UserClient ctrl = new UserClient();
    //        UserModel mdl = new UserModel();
    //        ds = ctrl.GetOmniclassTypes();
    //        cmbOmniClass.DataTextField = "Name";
    //        cmbOmniClass.DataValueField = "Id";
    //        cmbOmniClass.DataSource = ds;
    //        cmbOmniClass.DataBind();

    //        //size of dropdown
    //        int cmb_size = 250;
    //        cmb_size = cmb_size < (cmbOmniClass.Items.Count) * 18 ? cmb_size : (cmbOmniClass.Items.Count) * 18;
    //        cmbOmniClass.Height = cmb_size;
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
    protected void BindViewer()
    {
        try
        {
            DataSet ds = new DataSet();
            UserClient ctrl = new UserClient();
            UserModel mdl = new UserModel();
            mdl.UserId = new Guid(SessionController.Users_.UserId);
            ds = ctrl.BindUserViewer(mdl);
            cmbViewer.DataTextField = "Name";
            cmbViewer.DataValueField = "Id";
            cmbViewer.DataSource = ds;
            cmbViewer.DataBind();

            //size of dropdown
            int cmb_size = 250;
            cmb_size = cmb_size < (cmbViewer.Items.Count) * 18 ? cmb_size : (cmbViewer.Items.Count) * 18;
            cmbViewer.Height = cmb_size;
        }
        catch (Exception ex)
        {
            lblMessage.Text = "BindViewer:" + ex.Message.ToString();
        }
    }

    #endregion

    #region Event Handlers
    protected void btnrefresh_Click(object sender, EventArgs e)
    {
        bindState();
        //bindCity();
        bindCountry();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //if (btnSave.Text == "Edit")
        if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
            
        {
            bindUserDetails(new Guid(userId.ToString()));
            EnabledDisable('N');
        }
        //else if (btnSave.Text == "Save")
        else if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Save"))
        {
            string PwdRegularExpr = System.Configuration.ConfigurationManager.AppSettings["PwdRegularExpr"].ToString();
            if (!Regex.IsMatch(txtPassword.Text, PwdRegularExpr))
            {
                StringBuilder builder = new StringBuilder();
                builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_1"));
                builder.Append(":<ul><li>");
                builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_2"));
                builder.Append("</li><li>");
                builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_3"));
                builder.Append("</li><li>");
                builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_5"));
                builder.Append(":<ul><li>&emsp;");
                builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_6"));
                builder.Append("</li><li>&emsp;");
                builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_7"));
                builder.Append("</li><li>&emsp;");
                builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_8"));
                builder.Append("</li></ul></li></ul></span>");
                lblMessage.Text = builder.ToString();
                return;
            }

            UserClient ctrl = new UserClient();
            UserModel mdl = new UserModel();
            mdl.UserId = new Guid(userId.ToString());
            mdl.Firstname = txtFirstName.Text.ToString();
            mdl.Phone = txtPhoneNo.Text.ToString();
            mdl.LastName = txtLastName.Text.ToString();
            mdl.Email = txtEmail.Text.ToString();
            mdl.Title = txtTitle.Text.ToString();
            mdl.Address1 = txtAddress1.Text.ToString();
            mdl.OrganizationId = new Guid(txtOrganizationId.Text);
            mdl.Address2 = txtAddress2.Text.ToString();
            mdl.SystemRoleId = new Guid(cmbSystemRole.SelectedValue);
            //mdl.City = cmbCity.SelectedItem.Text.ToString();
            mdl.City = txtcity.Text.ToString();
            mdl.UserName = txtUsername.Text.ToString();
            mdl.StateId = new Guid(cmbState.SelectedValue);

            string password = txtPassword.Text.Equals(string.Empty) ? hfPassward.Value : txtPassword.Text;
            mdl.Passward = new CryptoHelper().Encrypt(password);

            mdl.Postal = txtPostalCode.Text.ToString();
            mdl.Abbreviation = txtAbbreviation.Text.ToString();
            mdl.CountryId = new Guid(cmbCountry.SelectedValue);
           // mdl.OmniclassType = new Guid(cmbOmniClass.SelectedValue);
            if (hf_uniclass_id.Value == "")
            {
                mdl.Uniclass_id = Guid.Empty;
            }
            else
            {
                mdl.Uniclass_id = new Guid(hf_uniclass_id.Value);
            }
            if (hf_lblOmniClassid.Value == "")
            {
                mdl.OmniclassType = Guid.Empty;
            }
            else
            {
                mdl.OmniclassType = new Guid(hf_lblOmniClassid.Value);
            }
            
            if (!hfPassward.Value.Equals(txtPassword.Text))
            {
                SendPasswordChangeEmail();
            }

            hfPassward.Value = password;

            mdl.fk_viewer_id = new Guid(cmbViewer.SelectedValue.ToString());
            string NewUserId = ctrl.InsertUpdateUser(mdl);
            EnabledDisable('Y');
            bindUserDetails(new Guid(userId.ToString()));
            lblMessage.Text = "User Details Saved successfully.";
        }
    }

    public void SendPasswordChangeEmail()
    {
        try
        {
            UserModel mdlUser = new UserModel();
            mdlUser.UserName = txtUsername.Text;
            UserClient clUser = new UserClient();
            DataSet ds = clUser.get_user_details_from_username(mdlUser);

            MailControl mailControl = new MailControl();
            MailModel mailModel = new MailModel();

            string mailbody = "Dear " + ds.Tables[0].Rows[0]["first_name"].ToString() + " " + ds.Tables[0].Rows[0]["last_name"].ToString() + ",<br><br>&emsp;&emsp;Your password has been changed successfully...";
            mailbody += "<br><br>&emsp;&emsp;Your new password is: <b>" + txtPassword.Text;
            mailbody += "</b><br><br><span style='color:#4F6228'>Thanks!</span><br> <b><span style='color:#4F6228'>EcoDomus, Inc.</span></b>";
            mailModel.Sender = ConfigurationManager.AppSettings["SupportMailId"].ToString();
            mailModel.Receiver = ds.Tables[0].Rows[0]["email_address"].ToString();
            mailModel.Subject = "EcoDomus: Password change confirmation for EcoDomus Account";
            mailModel.MessageBody = mailbody;
            mailModel.IsBodyHtml = true;
            string result = mailControl.SendMail(mailModel);
        }
        catch
        {

        }
    }

    //protected void cmbCity_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    //{
    //}
    //protected void cmbState_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    //{
    //    bindCity();
    //}

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
            Response.Redirect("~\\app\\LoginPM.aspx?Error=Session", true);
        }
    }

    protected void btnSetOrganization_Click(object sender, EventArgs e)
    {
        lblOrganization.Visible = true;
        lblOrganization.Text = hfOrganizationName.Value;
        txtOrganizationId.Text = hfOrganizationId.Value;
    }

    protected void cmbCountry_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        bindState();
        //bindCity();
    }
    #endregion
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        EnabledDisable('Y');
    }
    protected void btnrefreshState_Click(object sender, EventArgs e)
    {
        bindState();
    }
}