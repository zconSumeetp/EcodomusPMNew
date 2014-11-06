using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Login;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Session;
using Telerik.Web.UI;
using EcoDomus.Common;
using System.Threading;
using System.Globalization;
using EcoDomus.ActivateLicense;
using System.Net;

using Project;
using User;

public partial class App_Login_PM : System.Web.UI.Page
{
    CryptoHelper crypto = new CryptoHelper();
    string systemRole = string.Empty;
    public Boolean isValidUser = false;

    protected void Page_Init(object sender, EventArgs e)
    {
         
        try
        {
			// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			// !!! This is the most stupid solution !!!!			
			// The redirection to https have to be configured in IIS !!!!
			/*
            string url = HttpContext.Current.Request.Url.AbsoluteUri;
            if (url != "https://pm.ecodomus.com/app/login_pm.aspx")
            {
                Response.Redirect("https://pm.ecodomus.com/app/login_pm.aspx", false);
            }
			*/
			// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
        }
        catch (Exception ex)
        {
            Response.Write(ex.StackTrace.ToString());
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {


        try
        {

			// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			// !!! This is the most stupid solution !!!!			
			// The redirection to https have to be configured in IIS !!!!
			/*
            if ((!HttpContext.Current.Request.IsSecureConnection))
            {

                Uri baseUrl = HttpContext.Current.ApplicationInstance.Request.Url;
                string url_host = HttpContext.Current.ApplicationInstance.Request.RawUrl;
                string url_param = HttpContext.Current.ApplicationInstance.Request.ApplicationPath;

                string host = url_host.Split('/')[1];
                if (host.ToLower().Equals("pm.ecodomus.com"))
                {
                    string url = baseUrl.ToString().Replace(baseUrl.Scheme, Uri.UriSchemeHttps);
                    Response.RedirectPermanent(url);
                }
                             
            }           
			*/
			// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	
            SessionController.Users_.is_PM_FM = "PM";
            if (Request.Form["username"] == null && Request.Form["password"] == null)
            {
                UserName.Focus();
                string session = Convert.ToString(Request.QueryString["Error"]);
                if (session == "Session")
                {
                    ScriptManager.RegisterStartupScript(Page, GetType(), "JsStatus", "refreshparent();", true);
                    lblErrorMsg.Text = "Session expired. Please login.";
                }
                else if (session == "Delete")
                {
                    ScriptManager.RegisterStartupScript(Page, GetType(), "JsStatus", "refreshparent();", true);
                    lblErrorMsg.Text = "Your Session has been terminated.";
                }

                if (!IsPostBack)
                {
                    Bindlangauage();
                    //Session["Culture"] = "en-US";
                    if (SessionController.Users_.UserId == null || SessionController.Users_.UserLoginDetailId == null)
                    {
                        Session.RemoveAll();
                        Session.Abandon();
                    }
                    else
                    {
                        if (SessionController.Users_.UserSystemRole != "SA")
                        {

                            Response.Redirect("~/App/Reports/Dashboard_PM.aspx", false);
                        }
                        else
                        {
                            Response.Redirect("~/App/Central/Client.aspx", false);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.StackTrace.ToString());
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (Request.Form["username"] != null && Request.Form["password"] != null)
        {
            if (!IsPostBack)
            {
                ChkLogin(Convert.ToString(Request.Form["username"]), Convert.ToString(Request.Form["password"]));
                if (lblErrorMsg.Text != "")
                {
                    Response.Redirect("../index.html?error=" + lblErrorMsg.Text);
                }
                else
                {
                    Response.Cookies["loginstate"].Value = "Index";
                    Response.Cookies["loginstate"].Expires = DateTime.Now.AddDays(1);
                }
            }
        }
        else
        {
            Response.Cookies["loginstate"].Value = "Login";
            Response.Cookies["loginstate"].Expires = DateTime.Now.AddDays(1);
        }
    }

    // Added by: Priyanka salave  Date: 12/26/2011
    protected override void InitializeCulture()
    {
        DataSet ds = new DataSet();
        try
        {

            string Culture_id = Request["hf_culture_id"];
            if (Culture_id == null || Culture_id == "")
            {
                Culture_id = Guid.Empty.ToString();
            }
            LoginModel obj_mdl = new LoginModel();
            LoginClient obj_crtl = new LoginClient();
            obj_mdl.Language_id = new Guid(Culture_id);
            ds = obj_crtl.getCultureName(obj_mdl);
            string culture = ds.Tables[0].Rows[0]["culture"].ToString();
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);

            Session["Culture"] = culture;
        }
        catch (Exception ex)
        {

            throw ex;
        }


        //string Culture_id = Request["ddlLanguage"];
        //if (Culture_id == null)



        //{
        //    Culture_id = Guid.Empty.ToString();


        //}

        //DataSet ds = new DataSet();
        //LoginModel obj_mdl = new LoginModel();
        //LoginClient obj_crtl = new LoginClient();
        //obj_mdl.Language_id = new Guid(Culture_id);

        //ds = obj_crtl.getCultureName(obj_mdl);
        //string culture = ds.Tables[0].Rows[0]["culture"].ToString();


        //Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
        //Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);

        //Session["Culture"] = culture;


    }


    protected void LoginButton_Click(object sender, EventArgs e)
    {
        try
        {
            ChkLogin(UserName.Text, Password.Text);
        }
        catch (Exception ex)
        {
            ExceptionHandle("ChkLogin", ex);
        }
    }

    protected void Bindlangauage()
    {
        DataSet ds = new DataSet();
        try
        {
            LoginModel obj_mdl = new LoginModel();
            LoginClient obj_crtl = new LoginClient();
            ds = obj_crtl.GetLanguageDDL(obj_mdl);
            rcm_languages.DataTextField = "language_name";
            rcm_languages.DataValueField = "pk_language_id";
            rcm_languages.DataSource = ds;
            rcm_languages.DataBind();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void ChkLogin(string username, string password)
    {
        try
        {
            DataSet ds = new DataSet();
            LoginClient obj_crtl = new LoginClient();
            LoginModel obj_mdl = new LoginModel();

            obj_mdl.Password = password;

            obj_mdl.Username = username;
            ds = obj_crtl.CheckUserAuthentication(obj_mdl);
            if (ds.Tables[0].Rows.Count > 0)
            {
                SetSession(ds);
                // Session["Culture"] = "en-US";
                /*----Added for Licensing ---*/

                ActivateLicense validate = new ActivateLicense();
                string login_chk = validate.Validate_login();
                // string login_chk = Validate_login();


                if (Convert.ToString(login_chk) != "")
                {
                    /*----Added for Licensing ---*/

                    if (isValidUser)
                    {
                        SessionController.Users_.User_enabled = Convert.ToBoolean(ds.Tables[0].Rows[0]["status"]);
                        bool pass_change = !Convert.ToBoolean(ds.Tables[0].Rows[0]["pass_change_flag"]);
                        SessionController.Users_.Password_Change_Flag = pass_change;

                        if (SessionController.Users_.UserSystemRole != "SA")
                        {
                            DataSet ds_ConnString = new DataSet();
                            obj_mdl.UserId = new Guid(ds.Tables[0].Rows[0]["UserID"].ToString());
                            ds_ConnString = obj_crtl.GetConnectionStringUser(obj_mdl);

                            if (ds_ConnString.Tables[0].Rows.Count == 0)
                            {
                                lblErrorMsg.Text = "This account is not enabled. Please contact your system administrator.";
                            }
                            else
                            {

                                LoginModel obj_LoginModel = new LoginModel();
                                LoginClient obj_LoginClient = new LoginClient();
                                DataSet ds_recentProject = new DataSet();
                                obj_LoginModel.UserId = new Guid(ds.Tables[0].Rows[0]["UserID"].ToString());
                                ds_recentProject = obj_LoginClient.GetRecentUserDataPMFM(obj_mdl);

                                if (ds_recentProject.Tables[0].Rows.Count > 0)
                                {
                                    CryptoHelper crypto_obj = new CryptoHelper();
                                    SessionController.ConnectionString = crypto.Encrypt(ds_recentProject.Tables[0].Rows[0]["connection_string"].ToString());
                                    SessionController.Users_.ProjectId = ds_recentProject.Tables[0].Rows[0]["project_id"].ToString();
                                    SessionController.Users_.ClientID = ds_recentProject.Tables[0].Rows[0]["pk_client_id"].ToString();
                                    SessionController.Users_.ClientName = ds_recentProject.Tables[0].Rows[0]["client_name"].ToString();

                                    ProjectModel pm = new ProjectModel();
                                    ProjectClient pc = new ProjectClient();
                                    DataSet ds1 = new DataSet();
                                    pm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                                    ds1 = pc.GetProjectDataById(pm, SessionController.ConnectionString);
                                    if (ds1.Tables[0].Rows.Count > 0)
                                        SessionController.Users_.ProjectName = ds1.Tables[0].Rows[0]["project_name"].ToString();
                                    //getting system role for setting access permissions to pages 
                                    //getsystemrole();
                                    // Response.Redirect("~/App/Reports/Dashboard_PM.aspx", false);
                                }
                                else
                                {
                                    SessionController.ConnectionString = crypto.Encrypt(ds_ConnString.Tables[0].Rows[0]["connection_string"].ToString());
                                    SessionController.Users_.ClientID = (ds_ConnString.Tables[0].Rows[0]["pk_client_id"].ToString());
                                    SessionController.Users_.ClientName = (ds_ConnString.Tables[0].Rows[0]["client_name"].ToString());
                                    SessionController.Users_.ProjectId = Guid.Empty.ToString();
                                    // Response.Redirect("~/App/Reports/Dashboard_PM.aspx", false);
                                    //SessionController.Users_.facilityName = "ALL";
                                }

                                if (!Convert.ToBoolean(ds.Tables[0].Rows[0]["status"]))
                                {

                                    Response.Redirect("~/App/Central/EulaRegistration.aspx", false);
                                }
                                else if (pass_change)
                                {
                                    Response.Redirect("~/App/Central/ChangePassword.aspx", false);
                                }
                                else
                                {
                                    Response.Redirect("~/App/Reports/Dashboard_PM.aspx", false);
                                }
                            }
                        }
                        else
                        {
                            if (!Convert.ToBoolean(ds.Tables[0].Rows[0]["status"]))
                            {

                                Response.Redirect("~/App/Central/EulaRegistration.aspx", false);
                            }
                            else if (pass_change)
                            {
                                Response.Redirect("~/App/Central/ChangePassword.aspx", false);
                            }
                            else
                            {
                                Response.Redirect("~/App/Central/Client.aspx", false);
                            }
                        }
                    }
                    SessionController.Users_.DefaultPageSizeGrids = hfPageSize.Value;   
                }
                else
                {
                    if (SessionController.Users_.UserSystemRole == "SA")
                    {
                        bool pass_change = !Convert.ToBoolean(ds.Tables[0].Rows[0]["pass_change_flag"]);
                        SessionController.Users_.Password_Change_Flag = pass_change;
                        Response.Redirect("~/App/Settings/LicenseRegistration1.aspx", false);
                    }
                    else
                    {
                        lblErrorMsg.Text = "Website is Expired. Please contact your System Administrator.";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ExceptionHandle("ChkLogin", ex);
        }
    }

    protected void SetSession(DataSet ds)
    {
        try
        {
            if (ds.Tables[0].Rows[0]["ERROR"].ToString() == "We are sorry, this username does not exist in the system")
            {
                lblErrorMsg.Text = ds.Tables[0].Rows[0]["ERROR"].ToString();

            }
            else if (ds.Tables[0].Rows[0]["ERROR"].ToString() == "Provided password is not correct. Please re-enter the password.")
            {
                lblErrorMsg.Text = ds.Tables[0].Rows[0]["ERROR"].ToString();

            }
            else if (ds.Tables[0].Rows[0]["ERROR"].ToString() == "This account is not enabled. Please contact your system administrator.")
            {
                lblErrorMsg.Text = ds.Tables[0].Rows[0]["ERROR"].ToString();

            }
            else if (ds.Tables[0].Rows[0]["SystemRole"].ToString() == "LU")
            {
                lblErrorMsg.Text = "Sorry, your access level does not allow you to login.";
            }
            else
            {
                LoginSession login_obj = new LoginSession();
                login_obj.SetSession(ds);
                isValidUser = true;
                InsertUserDetail();
            }
        }
        catch (Exception ex)
        {
            ExceptionHandle("SetSession", ex);
        }
    }

    protected void InsertUserDetail()
    {
        try
        {
            LoginClient login_obj = new LoginClient();
            LoginModel login_mdl = new LoginModel();
            login_mdl.UserId = new Guid(SessionController.Users_.UserId);
            login_mdl.Login_type = "N";
            login_mdl.Flag = "Y";
            login_mdl.Application_flag = "PM";
            login_mdl.IpAddress = Request.ServerVariables["REMOTE_ADDR"].ToString();
            login_mdl = login_obj.InsertLoginUserDetail(login_mdl);
            SessionController.Users_.UserLoginDetailId = login_mdl.LoginId.ToString();
            Response.Cookies["test"].Value = login_mdl.LoginId.ToString();
            Response.Cookies["test"].Expires = DateTime.Now.AddDays(1);
        }
        catch (Exception ex)
        {
            ExceptionHandle("InsertUserDetail", ex);
        }
    }

    protected void ExceptionHandle(string error_msg, Exception ex)
    {
        lblErrorMsg.Text = error_msg + ":- " + ex.Message.ToString();
    }

    //protected void Redirect_Btn_Click(object sender, EventArgs e)
    //{
    //    SessionController.Users_.is_PM_FM = "PM";
    //    Response.Redirect("~/App/Reports/Dashboard_PM.aspx", false);
    //}

    public void openMasterUrl()
    {


        RadWindowManager win = new RadWindowManager();
        string url;
        url = "FacilityList.aspx";
        Telerik.Web.UI.RadWindow newwindow = new Telerik.Web.UI.RadWindow();
        newwindow.ID = "RadWindow_NavigateUrl";
        newwindow.NavigateUrl = url;
        newwindow.VisibleOnPageLoad = true;
        newwindow.InitialBehaviors = WindowBehaviors.None;
        newwindow.Left = 200;
        newwindow.Top = 100;
        newwindow.Behaviors = WindowBehaviors.Move;
        newwindow.Width = 875;
        newwindow.Height = 450;
        newwindow.VisibleStatusbar = false;
        newwindow.VisibleTitlebar = true;
        newwindow.Modal = true;
        win.Windows.Add(newwindow);
    }

    protected void ForgotPassword_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/App/ForgotPassword.aspx");
    }

    protected void rcm_languages_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        try
        {
            lbl_language_name.Text = rcm_languages.SelectedItem.Text;

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    protected void btnclick_Click(object sender, EventArgs e)
    {
        SessionController.Users_.DefaultPageSizeGrids = hfPageSize.Value;
    }
}