using System;
using System.Configuration;
using System.Data;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Mail.Control;
using EcoDomus.Mail.Model;
using EcoDomus.Session;
using Telerik.Web.UI;
using TypeProfile;
using User;
using Organization;

namespace App.Settings
{
    public partial class UserProfile : PageBase
    {
        #region Global Variables
    
        Guid _userId = Guid.Empty;
        string _uniClassFlag = "";
        string _omniClassFlag = "";

        #endregion

        #region Page Events
    
        protected void Page_Load(object sender, EventArgs e)
        {
            if (GetUserIdFromSessionController() != null && !SessionController.Users_.UserId.Equals(string.Empty))
            {
                if (Request.QueryString["popupflag"] == "popup")
                {
                    hfpopupflag.Value = "popup";
                    btnclose.Visible = true;
                    tblheader.Style.Value = ("text-align:left; font-size :large ;margin:2px 0px 2px 2px;");
                    lblpopup.Text = @"Contact Profile";
                    lblpopup.Visible = true;
                }
                else
                {
                    btnclose.Visible = false;
                }

                if (!IsPostBack)
                {
                    if (Request.QueryString["organization_id"] != null)
                    {
                        hfOrganization.Value = Request.QueryString["organization_id"];
                    }
                    
                    if (Request.QueryString["flag"] == "clone")
                    {
                        hfFlagClone.Value = (string)GetGlobalResourceObject("Resource", "Clone");
                        BindCountry();
                        BindState();
                        BindSystemRoles();
                        BindViewer();
                        BindUserDetails(new Guid(GetUserIdFromQueryString()));
                        BindTimeZones();
                        EnabledDisable('N');
                        txtUsername.Text = "";
                        txtFirstName.Text = "";
                        txtLastName.Text = "";
                        txtEmail.Text = "";
                        txtPassword.Attributes.Add("value", "");
                        lblMessage.Text = "";
                        hfUserId.Value = Guid.Empty.ToString();
                    }
                    else if (new Guid(GetUserIdFromQueryString()) != Guid.Empty)
                    {
                        _userId = new Guid(GetUserIdFromQueryString());
                        BindCountry();
                        BindState();
                        BindSystemRoles();
                        BindViewer();
                        BindUserDetails(_userId);
                        BindTimeZones();
                    }
                    else
                    {
                        _userId = Guid.Empty;
                        BindCountry();
                        BindSystemRoles();
                        BindViewer();
                        BindUserDetails(_userId);
                        var selectedState = "";

                        if (GetUserIdFromQueryString() != null)
                        {
                            if (GetUserIdFromQueryString() == Guid.Empty.ToString())
                            {
                                Label1.Visible = true;
                                if (Request.QueryString["organization_id"] != null && Request.QueryString["Organization_name"] != null)
                                {
                                    if (!Convert.ToString(Request.QueryString["Organization_name"]).Equals(""))
                                    {
                                        string organizationId = Request.QueryString["organization_id"];
                                        if (!organizationId.Equals(Guid.Empty.ToString()))
                                        {
                                            selectedState = BindAddress(organizationId);
                                        }
                                    }
                                }
                            }
                        }

                        BindState();

                        if (!selectedState.Equals(""))
                        {
                            cmbState.SelectedValue = selectedState;
                        }

                        BindTimeZones();
                        cmbTimeZone.SelectedValue = "Eastern Standard Time";
                    }

                    hfPassward.Value = txtPassword.Text;
                }

                if ((Request.QueryString["organization_id"] != null) && (Request.QueryString["Organization_name"] == ""))
                {
                    hfOrganization.Value = Request.QueryString["organization_id"];
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "script1", "LogoutNavigation();", true);
            }
        }

        private string GetUserIdFromQueryString()
        {
            return Request.QueryString["userId"];
        }

        #endregion

        #region My Methods
    
        protected void BindSystemRoles()
        {
            var userClient = new UserClient();
            var userModel = 
                new UserModel
                {
                    UserId = new Guid(GetUserIdFromSessionController())
                };

            var dataSetSystemRoles = userClient.GetSystemRoles_PM(userModel);
            cmbSystemRole.DataSource = dataSetSystemRoles;
            cmbSystemRole.DataBind();
            cmbSystemRole.Height = 100;
        }

        private static string GetUserIdFromSessionController()
        {
            return SessionController.Users_.UserId;
        }

        protected void BindCountry()
        {
            var userClient = new UserClient();
            var dataSetCountries = userClient.GetCountry();
            cmbCountry.DataSource = dataSetCountries;
            cmbCountry.DataBind();
            cmbCountry.SelectedItem.Text = @"USA";
            cmbCountry.Height = 100;
        }

        protected void BindState()
        {
            var userClient = new UserClient();
            var userModel = new UserModel { CountryId = new Guid(cmbCountry.SelectedValue) };
            var dataSetState = userClient.bindState(userModel);
            cmbState.DataSource = dataSetState;
            cmbState.DataBind();
            cmbState.Height = 100;
        }
        
        protected void BindUserDetails(Guid userId)
        {
            var userClient = new UserClient();
            var userModel = new UserModel {UserId = userId};
            var dataSetUserDetails = userClient.GetUserDetails(userModel);
            if (dataSetUserDetails.Tables.Count > 0 && dataSetUserDetails.Tables[0].Rows.Count > 0)
            {
                lblAbbreviation.Text = dataSetUserDetails.Tables[0].Rows[0]["abbreviation"].ToString();
                txtAbbreviation.Text = dataSetUserDetails.Tables[0].Rows[0]["abbreviation"].ToString();
                lblAddress1.Text = dataSetUserDetails.Tables[0].Rows[0]["address_line_1"].ToString();
                txtAddress1.Text = dataSetUserDetails.Tables[0].Rows[0]["address_line_1"].ToString();
                lblAddress2.Text = dataSetUserDetails.Tables[0].Rows[0]["address_line_2"].ToString();
                txtAddress2.Text = dataSetUserDetails.Tables[0].Rows[0]["address_line_2"].ToString();
                lblCity.Text = dataSetUserDetails.Tables[0].Rows[0]["city"].ToString();
                txtcity.Text = dataSetUserDetails.Tables[0].Rows[0]["city"].ToString();
                lblCountry.Text = dataSetUserDetails.Tables[0].Rows[0]["country_name"].ToString();

                if (lblCountry.Text != "")
                {
                    cmbCountry.FindItemByText(lblCountry.Text).Selected = true;
                }

                lblEmail.Text = dataSetUserDetails.Tables[0].Rows[0]["email_address"].ToString();
                txtEmail.Text = dataSetUserDetails.Tables[0].Rows[0]["email_address"].ToString();
                lblFirstName.Text = dataSetUserDetails.Tables[0].Rows[0]["first_name"].ToString();
                txtFirstName.Text = dataSetUserDetails.Tables[0].Rows[0]["first_name"].ToString();
                lblLastName.Text = dataSetUserDetails.Tables[0].Rows[0]["last_name"].ToString();
                txtLastName.Text = dataSetUserDetails.Tables[0].Rows[0]["last_name"].ToString();
                lblOrganization.Text = dataSetUserDetails.Tables[0].Rows[0]["organization_name"].ToString();
                txtOrganizationId.Text = dataSetUserDetails.Tables[0].Rows[0]["organization_id"].ToString();
                hfOrganizationId.Value = dataSetUserDetails.Tables[0].Rows[0]["organization_id"].ToString();

                var crypto = new CryptoHelper();
                txtPassword.Text = crypto.Decrypt(dataSetUserDetails.Tables[0].Rows[0]["password"].ToString());
                
                hfPassward.Value = txtPassword.Text;
                txtPassword.Attributes.Add("value", hfPassward.Value);
                lblPhoneNo.Text = dataSetUserDetails.Tables[0].Rows[0]["phone_number"].ToString();
                txtPhoneNo.Text = dataSetUserDetails.Tables[0].Rows[0]["phone_number"].ToString();
                lblPostalCode.Text = dataSetUserDetails.Tables[0].Rows[0]["postal_code"].ToString();
                txtPostalCode.Text = dataSetUserDetails.Tables[0].Rows[0]["postal_code"].ToString();
                lblstate.Text = dataSetUserDetails.Tables[0].Rows[0]["state_name"].ToString();
                lblViewer.Text = dataSetUserDetails.Tables[0].Rows[0]["viewer_name"].ToString();
                cmbViewer.SelectedValue = dataSetUserDetails.Tables[0].Rows[0]["pk_viewer_id"].ToString();

                if (dataSetUserDetails.Tables[0].Rows[0]["state_name"].ToString() != "")
                {
                    BindState();
                    cmbState.FindItemByText(dataSetUserDetails.Tables[0].Rows[0]["state_name"].ToString()).Selected = true;
                }

                lblSystemRole.Text = dataSetUserDetails.Tables[0].Rows[0]["system_role"].ToString();
                cmbSystemRole.FindItemByText(dataSetUserDetails.Tables[0].Rows[0]["system_role"].ToString()).Selected = true;
                lblTitle.Text = dataSetUserDetails.Tables[0].Rows[0]["title"].ToString();
                txtTitle.Text = dataSetUserDetails.Tables[0].Rows[0]["title"].ToString();
                lblUsername.Text = dataSetUserDetails.Tables[0].Rows[0]["username"].ToString();
                txtUsername.Text = dataSetUserDetails.Tables[0].Rows[0]["username"].ToString();
                lbl_category.Text = dataSetUserDetails.Tables[0].Rows[0]["OmniclassType"].ToString();
                hf_lblOmniClassid.Value = dataSetUserDetails.Tables[0].Rows[0]["omniclass_id"].ToString();
                    
                var dataSetTimeZone = userClient.GetTimeZoneInfo(userModel);
                
                if (dataSetTimeZone.Tables.Count > 0 && dataSetTimeZone.Tables[0].Rows.Count > 0)
                {
                    lblTimeZone.Text = dataSetTimeZone.Tables[0].Rows[0]["DisplayName"].ToString();    
                }
                else
                {
                    lblTimeZone.Text = "";
                }
                
                EnabledDisable('Y');
            }
            else
            {
                btnSetOrganization_Click();
                EnabledDisable('N');
                for (var i = 0; i < cmbViewer.Items.Count; i++)
                {
                    if (cmbViewer.Items[i].Text.Contains("2014"))
                    {
                        cmbViewer.Items[i].Selected = true;
                    }
                }
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
                lblTimeZone.Visible = true;
                lblEmail.Visible = true;
                lblFirstName.Visible = true;
                lblLastName.Visible = true;
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
                lblViewer.Visible = true;
                lnk_btn_addnewCountry.Visible = false;
                lnk_btn_addnewState.Visible = false;
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
                txtcity.Visible = false;
                cmbCountry.Visible = false;
                lnkAddOmniclass.Visible = false;
                cmbSystemRole.Visible = false;
                btnSelectOrganization.Visible = false;
                cmbViewer.Visible = false;
                btnDelete.Visible = true;
                btnSave.Text = (string)GetGlobalResourceObject("Resource", "Edit");
                btnClone.Text = (string)GetGlobalResourceObject("Resource", "Clone");
                btnCancel.Visible = false;
                cmbTimeZone.Visible = false;
            }

            else if (flag.Equals('N'))
            {
                lblAbbreviation.Visible = false;
                lblAddress1.Visible = false;
                lblAddress2.Visible = false;
                lblCity.Visible = false;
                lblCountry.Visible = false;
                lblTimeZone.Visible = false;
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
                lblViewer.Visible = false;
                lblOrganization.Visible = true; 
                lnk_btn_addnewCountry.Visible = true;
                lnk_btn_addnewState.Visible = true;
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
                txtcity.Visible = true;
                cmbCountry.Visible = true;
                lnkAddOmniclass.Visible = true;
                cmbSystemRole.Visible = true;
                btnSelectOrganization.Visible = true;
                cmbViewer.Visible = true;
                btnDelete.Visible = false;
                btnSave.Text = (string)GetGlobalResourceObject("Resource", "Save");
                btnClone.Text = (string)GetGlobalResourceObject("Resource", "Save_and_Clone");
                btnCancel.Visible = true;
                cmbTimeZone.Visible = true;
            }
        }
        
        protected void show_hide_standards()
        {
            var typeModel = new TypeModel();
            var typeClient = new TypeProfileClient();
            if (SessionController.Users_.ProjectId != null)
            {
                typeModel.Project_id = new Guid(SessionController.Users_.ProjectId);
                typeModel.Flag = "type";
                typeModel.Txt_Search = "";
                var dsTypeCount = typeClient.bindtypepm_count_v1(typeModel, SessionController.ConnectionString);

                if (dsTypeCount.Tables[2] == null) return;

                if (dsTypeCount.Tables[2].Rows.Count > 0)
                {
                    for (var i = 0; i < dsTypeCount.Tables[2].Rows.Count; i++)
                    {
                        switch (dsTypeCount.Tables[2].Rows[i]["standard_name"].ToString())
                        {
                            case "MasterFormat":
                            case "UniFormat":
                                break;

                            case "OmniClass 2010":
                                _omniClassFlag = dsTypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                                break;

                            case "UniClass":
                                _uniClassFlag = dsTypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                                break;
                        }
                    }
                }

                hf_uniclass.Value = _uniClassFlag != "" ? "Y" : "N";
                    
                hf_omniclass.Value = _omniClassFlag != "" ? "Y" : "N";

                if (hf_omniclass.Value == "N" && hf_uniclass.Value == "N")
                {
                    td_category.Style.Add("display", "none");
                }
            }
            else
            {
                td_category.Style.Add("display", "none");
            }
        }

        protected void BindViewer()
        {
            try
            {
                var userClient = new UserClient();
                var userModel = new UserModel {UserId = new Guid(GetUserIdFromSessionController())};
                var dataSetUserViewer = userClient.BindUserViewer(userModel);
                cmbViewer.DataSource = dataSetUserViewer;
                cmbViewer.DataBind();
                cmbViewer.Height = 100;
            }
            catch (Exception ex)
            {
                lblMessage.Text = @"BindViewer:" + ex.Message;
            }
        }
    
        protected void BindTimeZones()
        {
            using (var userClient = new UserClient())
            {
                BindRadComboBoxTimeZones(userClient);
                TrySetDefaultTimeZone();
                TrySetTimeZoneForUser(userClient);
            }

            cmbTimeZone.Height = 100;
        }

        private void TrySetTimeZoneForUser(IUser userClient)
        {
            var userModel = 
                new UserModel
                {
                    UserId = new Guid(GetUserIdFromQueryString())
                };

            var dsTimeZone = userClient.GetTimeZoneInfo(userModel);

            if (dsTimeZone.Tables.Count > 0 && dsTimeZone.Tables[0].Rows.Count > 0)
            {
                var timeZoneId = dsTimeZone.Tables[0].Rows[0]["Id"].ToString().Trim();
                if (!string.IsNullOrEmpty(timeZoneId))
                {
                    cmbTimeZone.SelectedValue = timeZoneId;
                }
            }
        }

        private void BindRadComboBoxTimeZones(IUser userClient)
        {
            var dataSetTimeZones = userClient.GetTimeZones();
            cmbTimeZone.DataSource = dataSetTimeZones;
            cmbTimeZone.DataBind();
        }

        private void TrySetDefaultTimeZone()
        {
            if (cmbTimeZone.Items.Count > 0)
            {
                cmbTimeZone.Items[0].Selected = true;
            }    
        }

        #endregion

        #region Event Handlers

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
            {
                EnabledDisable('N');
                ScriptManager.RegisterStartupScript(this, GetType(), "script1", "resizePopup('expand');", true);
            }
       
            else if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Save"))
            {
                var passwordRegularExpression = ConfigurationManager.AppSettings["PwdRegularExpr"];
                if (!Regex.IsMatch(txtPassword.Text, passwordRegularExpression))
                {
                    var builder = new StringBuilder();
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
                    ScriptManager.RegisterStartupScript(this, GetType(), "script1", "resizePopup('expandMesage');", true);
                    return;
                }

                if (lblOrganization.Text != "")
                {
                    if ((hfOrganization.Value != "") &&
                        (new Guid(GetUserIdFromQueryString()) != Guid.Empty) &&
                        (Request.QueryString["Organization_name"] == ""))
                    {
                        txtOrganizationId.Text = Request.QueryString["organization_id"];
                    }

                    if ((GetUserIdFromQueryString() != "") && (Request.QueryString["flag"] == ""))
                    {
                        txtOrganizationId.Text = hfOrganizationId.Value;
                    }

                    if ((new Guid(GetUserIdFromQueryString()) == Guid.Empty) &&
                        (Request.QueryString["organization_id"] != ""))
                    {
                        txtOrganizationId.Text = hfOrganizationId.Value;
                    }
                    
                    txtOrganizationId.Text = hfOrganizationId.Value != "" ? hfOrganizationId.Value : hfOrganization.Value;

                    var userClient = new UserClient();
                    var userModel = new UserModel();
                    
                    if (hfFlagClone.Value == (string) GetGlobalResourceObject("Resource", "Clone"))
                    {
                        userModel.UserId = Guid.Empty;
                    }
                    else if (hfFlag.Value == "Cloned")
                    {
                        userModel.UserId = Guid.Empty;
                    }
                    else if (new Guid(GetUserIdFromQueryString()) != Guid.Empty)
                    {
                        userModel.UserId = new Guid(GetUserIdFromQueryString());
                        hfUserId.Value = GetUserIdFromQueryString();
                    }
                    else
                    {
                        userModel.UserId = Guid.Empty;
                        hfUserId.Value = "";
                    }

                    userModel.Firstname = txtFirstName.Text;
                    userModel.Phone = txtPhoneNo.Text;
                    userModel.LastName = txtLastName.Text;
                    userModel.Email = txtEmail.Text;
                    userModel.Title = txtTitle.Text;
                    userModel.Address1 = txtAddress1.Text;
                    userModel.OrganizationId = new Guid(txtOrganizationId.Text);
                    userModel.Address2 = txtAddress2.Text;
                    userModel.SystemRoleId = new Guid(cmbSystemRole.SelectedValue);
                    userModel.City = txtcity.Text;
                    userModel.UserName = txtUsername.Text;
                    userModel.StateId = new Guid(cmbState.SelectedValue);
                    userModel.Passward = new CryptoHelper().Encrypt(txtPassword.Text);
                    userModel.Postal = txtPostalCode.Text;
                    userModel.Abbreviation = txtAbbreviation.Text;
                    userModel.CountryId = new Guid(cmbCountry.SelectedValue);
                    userModel.TimeZoneId = cmbTimeZone.SelectedValue.Trim();
                    userModel.Uniclass_id = hf_uniclass_id.Value == "" ? Guid.Empty : new Guid(hf_uniclass_id.Value);
                    userModel.OmniclassType = hf_lblOmniClassid.Value == "" ? Guid.Empty : new Guid(hf_lblOmniClassid.Value);
                    userModel.Created_by_userid = new Guid(GetUserIdFromSessionController());
                    userModel.fk_viewer_id = new Guid(cmbViewer.SelectedValue);
                    
                    var newUserId = userClient.InsertUpdateUser(userModel);

                    if (String.Equals(newUserId, Convert.ToString(GetUserIdFromSessionController()), StringComparison.CurrentCultureIgnoreCase))
                    {
                        SessionController.Users_.OrganizationID = Convert.ToString(userModel.OrganizationId);
                        SessionController.Users_.OrganizationName = Convert.ToString(lblOrganization.Text);
                    }

                    if (newUserId == Guid.Empty.ToString())
                    {
                        lblMessage.Text = @"This username already exists!";
                        lblMessage.Visible = true;
                    }
                    else
                    {
                        if (new Guid(GetUserIdFromQueryString()) != Guid.Empty && hfPassward.Value != txtPassword.Text)
                        {
                            SendPasswordChangeEmail();
                        }

                        EnabledDisable('Y');

                        if (newUserId == "")
                        {
                            _userId = new Guid(hfUserId.Value);
                        }
                        else
                        {
                            _userId = new Guid(newUserId);
                            hfUserId.Value = newUserId;
                            string redirectToUserProfile;

                            if (hfpopupflag.Value == "popup")
                            {
                                redirectToUserProfile = "<script language='javascript'>RedirectToUserProfilepopup('" +
                                                        hfUserId.Value + "&popupflag=" +
                                                        Request.QueryString["popupflag"] + "');</script>";
                            }
                            else
                            {
                                redirectToUserProfile = "<script language='javascript'>RedirectToUserProfile('" +
                                                        hfUserId.Value + "');</script>";
                            }

                            Page.ClientScript.RegisterStartupScript(GetType(), "script", redirectToUserProfile);
                        }

                        BindUserDetails(_userId);
                        lblMessage.Text = "";
                        hfFlag.Value = "";
                        hfFlagClone.Value = "";
                    }
                }
                else
                {
                    lblvalidate.Visible = true;
                }
            }
        }

        public void SendPasswordChangeEmail()
        {
            var userModel = new UserModel {UserName = txtUsername.Text};
            var userClient = new UserClient();
            var dataSetUserDetails = userClient.get_user_details_from_username(userModel);

            var mailControl = new MailControl();
            var mailModel = new MailModel();

            var mailbody = "Dear " + dataSetUserDetails.Tables[0].Rows[0]["first_name"] + " " + dataSetUserDetails.Tables[0].Rows[0]["last_name"] + ",<br><br>&emsp;&emsp;Your password has been changed successfully...";
            mailbody += "<br><br>&emsp;&emsp;Your new password is: <b>" + txtPassword.Text;
            mailbody += "</b><br><br><span style='color:#4F6228'>Thanks!</span><br> <b><span style='color:#4F6228'>EcoDomus, Inc.</span></b>";
            mailModel.Sender = ConfigurationManager.AppSettings["SupportMailId"];
            mailModel.Receiver = dataSetUserDetails.Tables[0].Rows[0]["email_address"].ToString();
            mailModel.Subject = "EcoDomus: Password change confirmation for EcoDomus Account";
            mailModel.MessageBody = mailbody;
            mailModel.IsBodyHtml = true;
            mailControl.SendMail(mailModel);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (new Guid(Request.QueryString["userId"]) == Guid.Empty)
            {
                if (Request.QueryString["flag"].Equals("from_no_master"))
                {
                    const string redirectToUser = "<script language='javascript'>RedirectToUser('from_no_master');</script>";
                    Page.ClientScript.RegisterStartupScript(GetType(), "script", redirectToUser);
                }
                else
                {
                    const string redirectToUser = "<script language='javascript'>RedirectToUser('from_master');</script>";
                    Page.ClientScript.RegisterStartupScript(GetType(), "script", redirectToUser);
                }
            }
            else
            {
                if (new Guid(GetUserIdFromQueryString()) != Guid.Empty)
                {
                    BindUserDetails(new Guid(GetUserIdFromQueryString()));
                    lblMessage.Visible = false;

                }

                #region may need in future
                //if ((Request.QueryString["flag"] == "clone")&&(GetUserIdFromQueryString() != "")&&(Request.QueryString["organization_id"] == ""))
                //{
                //    if (ViewState["InitialOrganization"] != null)
                //    {
                //    lblOrganization.Text = ViewState["InitialOrganization"].ToString();
                //    }
                //}
                //if ((Request.QueryString["flag"] == "from_no_master") && (GetUserIdFromQueryString() != "") && (Request.QueryString["organization_id"] == ""))
                //{
                //    if (ViewState["InitialOrganization"] != null)
                //    {
                //        lblOrganization.Text = ViewState["InitialOrganization"].ToString();
                //    }
                //}
                //if ((Request.QueryString["flag"] == "clone") && (GetUserIdFromQueryString() != "") && (Request.QueryString["organization_id"] != ""))
                //{
                //    if (ViewState["InitialOrganization"] != null)
                //    {
                //        lblOrganization.Text = ViewState["InitialOrganization"].ToString();
                //    }
                //}
                //if ((Request.QueryString["flag"] == "") && (GetUserIdFromQueryString() != ""))
                //{
                //    if (ViewState["InitialOrganization"] != null)
                //    {
                //        lblOrganization.Text = ViewState["InitialOrganization"].ToString();
                //    }
                //}
                #endregion

                EnabledDisable('Y');
                ScriptManager.RegisterStartupScript(this, GetType(), "script1", "resizePopup('CollapsPopup');", true);
            }
        }

        protected void btnSetOrganization_Click(object sender, EventArgs e)
        {
            lblOrganization.Visible = true;
            ViewState["InitialOrganization"] = lblOrganization.Text;
            lblOrganization.Text = hfOrganizationName.Value;
            lblvalidate.Visible = false;
            
            if ((Request.QueryString["organization_id"] != "") && (Request.QueryString["Organization_name"] != "") && (new Guid(GetUserIdFromQueryString()) == Guid.Empty))
            {
                txtOrganizationId.Text = hfOrganizationId.Value;
            }

            if ((hfOrganization.Value == "") && (Request.QueryString["organization_id"] == ""))
            {
                txtOrganizationId.Text = hfOrganizationId.Value;
            }

            if (hfOrganizationId.Value != "")
            {
                var selectedState = BindAddress(hfOrganizationId.Value);
                BindState();
                if (!selectedState.Equals(""))
                {
                    cmbState.SelectedValue = selectedState;
                }
            }
            else
            {
                txtOrganizationId.Text = Request.QueryString["organization_id"];
            }
        }

        protected string BindAddress(string organizationId)
        {
            var selectedState = "";
            var organizationClient = new OrganizationClient();
            var organizationModel = new OrganizationModel {Organization_Id = new Guid(organizationId)};
            var dataSetOranizationInformation = organizationClient.GetOranizationInformation(organizationModel);

            if (dataSetOranizationInformation.Tables.Count <= 0) return selectedState;
            if (dataSetOranizationInformation.Tables[0].Rows.Count <= 0) return selectedState;

            lblOrganization.Text = dataSetOranizationInformation.Tables[0].Rows[0]["OrganizationName"].ToString();
            txtAddress1.Text = dataSetOranizationInformation.Tables[0].Rows[0]["Address_1"].ToString();
            txtAddress2.Text = dataSetOranizationInformation.Tables[0].Rows[0]["Address_2"].ToString();
            txtPostalCode.Text = dataSetOranizationInformation.Tables[0].Rows[0]["postalCode"].ToString();
            txtcity.Text = dataSetOranizationInformation.Tables[0].Rows[0]["city_name"].ToString();
            cmbCountry.SelectedValue = dataSetOranizationInformation.Tables[0].Rows[0]["countryId"].ToString();
            selectedState = dataSetOranizationInformation.Tables[0].Rows[0]["stateId"].ToString();

            return selectedState;
        }

        protected void btnSetOrganization_Click()
        {
            if (Request.QueryString["Organization_name"] != null)
            {
                var currentOrg = Request.QueryString["Organization_name"];
                lblOrganization.Text = currentOrg;
                txtOrganizationId.Text = Request.QueryString["organization_id"];
            }

            lblOrganization.Visible = true;
            
            if (Request.QueryString["flag"] != "clone")
            {
                txtOrganizationId.Text = hfOrganizationId.Value;
            }
        }
        
        protected void btnClone_Click(object sender, EventArgs e)
        {
            if (btnClone.Text == (string)GetGlobalResourceObject("Resource", "Save_and_Clone"))
            {
                var userClient = new UserClient();
                var userModel = new UserModel();

                if (hfUserId.Value == "")
                {
                    userModel.UserId = new Guid(GetUserIdFromQueryString());
                    hfUserId.Value = GetUserIdFromQueryString();
                }
                else
                {
                    userModel.UserId = new Guid(hfUserId.Value);
                }

                userModel.Firstname = txtFirstName.Text;
                userModel.Phone = txtPhoneNo.Text;
                userModel.LastName = txtLastName.Text;
                userModel.Email = txtEmail.Text;
                userModel.Title = txtTitle.Text;
                userModel.Address1 = txtAddress1.Text;

                if (txtOrganizationId.Text == "")
                {
                    if (Request.QueryString["organization_id"] != null)
                    {
                        txtOrganizationId.Text = Request.QueryString["organization_id"];
                    }
                        
                    if (hfOrganizationId.Value == "")
                    {
                        hfOrganizationId.Value = Request.QueryString["organization_id"];
                    }
                }

                if (hfOrganizationId != null)
                {
                    if (hfOrganizationId.Value != null)
                    {
                        userModel.OrganizationId = new Guid(hfOrganizationId.Value);
                    }
                } 
                    
                userModel.Address2 = txtAddress2.Text;
                userModel.SystemRoleId = new Guid(cmbSystemRole.SelectedValue);
                userModel.City = txtcity.Text;
                userModel.UserName = txtUsername.Text;
                userModel.StateId = new Guid(cmbState.SelectedValue);

                var pwdRegularExpr = ConfigurationManager.AppSettings["PwdRegularExpr"];
                if (!Regex.IsMatch(Convert.ToString(txtPassword.Text), pwdRegularExpr))
                {
                    var builder = new StringBuilder();
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

                userModel.Passward = new CryptoHelper().Encrypt(Convert.ToString(txtPassword.Text));
                userModel.Postal = txtPostalCode.Text;
                userModel.Abbreviation = txtAbbreviation.Text;
                userModel.CountryId = new Guid(cmbCountry.SelectedValue);
                userModel.TimeZoneId = cmbTimeZone.SelectedValue;
                userModel.Uniclass_id = hf_uniclass_id.Value == "" ? Guid.Empty : new Guid(hf_uniclass_id.Value);
                userModel.OmniclassType = hf_lblOmniClassid.Value == "" ? Guid.Empty : new Guid(hf_lblOmniClassid.Value);
                
                var newUserId = userClient.InsertUpdateUser(userModel);

                if (newUserId == Guid.Empty.ToString())
                {
                    lblMessage.Text = @"This username already exists!";
                    lblMessage.Visible = true;
                }
                else
                {
                    if (newUserId == "")
                    {
                        _userId = new Guid(hfUserId.Value);
                    }
                    else
                    {
                        _userId = new Guid(newUserId);
                        hfUserId.Value = Guid.Empty.ToString();
                    }

                    if (!hfPassward.Value.Equals(txtPassword.Text))
                    {
                        SendPasswordChangeEmail();
                    }

                    hfFlag.Value = "Cloned";
                    BindUserDetails(_userId);
                    EnabledDisable('N');
                    lblMessage.Text = "";
                    txtUsername.Text = "";
                    txtFirstName.Text = "";
                    txtLastName.Text = "";
                    txtEmail.Text = "";
                    txtPassword.Attributes.Add("value", "");
                }
            }
                
            else if (btnClone.Text == (string)GetGlobalResourceObject("Resource", "Clone"))
            {
                EnabledDisable('N');
                lblMessage.Text = "";
                txtUsername.Text = "";
                txtFirstName.Text = "";
                txtLastName.Text = "";
                txtEmail.Text = "";
                txtPassword.Attributes.Add("value", "");
                hfFlagClone.Value = (string)GetGlobalResourceObject("Resource", "Clone");
                hfUserId.Value = Guid.Empty.ToString();
            }
        }

        protected void cmbCountry_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            BindState();
        }

        protected void btnrefresh_Click(object sender, EventArgs e)
        {
            BindState();
            BindCountry();
        }

        protected void btnrefreshState_Click(object sender, EventArgs e)
        {
            BindState();
        }
        
        #endregion

        protected void lnk_btn_addnewState_Click(object sender, EventArgs e)
        {
            hfPassward.Value = txtPassword.Text;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            var userClient = new UserClient();
            var userModel = new UserModel {UserId = new Guid(GetUserIdFromQueryString())};
            userClient.DeleteUser(userModel);
            ScriptManager.RegisterStartupScript(Page, GetType(), "user", "navigateurl();", true);
        }
        
        protected void lnkBimCon2012_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/App/Files/EcoDomus BIM Connector.zip");
        }

        protected void Page_Prerender(object sender, EventArgs e)
        {
            if (SessionController.Users_.UserSystemRole == "CBU")
            {
                trViewer.Style["display"] = "none";
            }

            if (GetUserIdFromQueryString() == Guid.Empty.ToString() && SessionController.Users_.UserSystemRole == "CBU")
            {
                Label19.Visible = false;
                hfOrganizationId.Value = SessionController.Users_.OrganizationID;
                hfOrganizationName.Value = SessionController.Users_.OrganizationName;
                lblOrganization.Text = SessionController.Users_.OrganizationName;
            }
            else if (GetUserIdFromQueryString() != Guid.Empty.ToString() && SessionController.Users_.UserSystemRole == "CBU")
            {
                Label19.Visible = false;
                hfOrganizationId.Value = SessionController.Users_.OrganizationID;
                hfOrganizationName.Value = SessionController.Users_.OrganizationName;
                lblOrganization.Text = SessionController.Users_.OrganizationName;
            }

            if (SessionController.Users_.UserSystemRole == "GU")
            {
                btnClone.Visible = false;
                btnDelete.Visible = false;
                btnSelectOrganization.Visible = false;
                cmbSystemRole.Enabled = false;
            }

            if (SessionController.Users_.Permission_ds == null) return;

            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
            {
                SetPermissions();
            }
        }

        private void SetPermissions()
        {
            var dsComponent = SessionController.Users_.Permission_ds;
            var drComponent = dsComponent.Tables[0].Select("name='BIM Server'")[0];
            var drSubmenuComponent = dsComponent.Tables[0].Select("fk_parent_control_id='" + drComponent["pk_project_role_controls"] + "'");
            
            foreach (var drProfile in drSubmenuComponent)
            {
                if (drProfile["name"].ToString() == "Users")
                {
                    SetPermissionToControl(drProfile);
                }
            }
        }

        private void SetPermissionToControl(DataRow dr)
        {
            var deletePermission = dr["delete_permission"].ToString();
            var editPermission = dr["edit_permission"].ToString();

            btnDelete.Enabled = deletePermission != "N";

            if (editPermission == "N")
            {
                btnSave.Enabled = false;
                btnClone.Enabled = false;
            }
            else
            {
                btnSave.Enabled = true;
                btnClone.Enabled = true;
            }
        }
    }
}