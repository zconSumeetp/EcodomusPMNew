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
using Dashboard;



public partial class App_Login : System.Web.UI.Page
{
    /* Declare the Global connection object */

    CryptoHelper crypto = new CryptoHelper();
    string systemRole = string.Empty;
    public Boolean isValidUser = false;

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
			// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!					
			// The redirection to https have to be configured in IIS !!!!
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
            SessionController.Users_.is_PM_FM = "FM";
            if (Request.Form["username"] == null && Request.Form["password"] == null)
            {
                lgnUserLOgin.Focus();
                string session = Convert.ToString(Request.QueryString["Error"]);
                if (session == "Session")
                {
                    lblFailureText.Text = "Session expired. Please login.";
                }
                else if (session == "Delete")
                {
                    lblFailureText.Text = "Your Session has been terminated.";
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
                            Response.Redirect("~/App/Reports/dashboard.aspx", false);
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
                if (lblFailureText.Text != "")
                {
                    Response.Redirect("../index.html?error=" + lblFailureText.Text);
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
        try
        {
            string Culture_id = Request["ddlLanguage"];
            if (Culture_id == null)
            {
                Culture_id = Guid.Empty.ToString();
            }

            DataSet ds = new DataSet();
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
    }

    public void redirect_page(string url)
    {
            Response.Redirect(url, false);
     
    }

    protected void lgnUserLOgin_Authenticate(object sender, AuthenticateEventArgs e)
    {
        try
        {
            ChkLogin(lgnUserLOgin.UserName.ToString(), lgnUserLOgin.Password.ToString());
        }
        catch (Exception ex)
        {
            ExceptionHandle("ChkLogin", ex);
        }
    }


    // Added by: Priyanka salave  Date: 12/21/2011
    protected void Bindlangauage()
    {

        try
        {

            DataSet ds = new DataSet();
            LoginModel obj_mdl = new LoginModel();
            LoginClient obj_crtl = new LoginClient();
            ds = obj_crtl.GetLanguageDDL(obj_mdl);

            ddlLanguage.DataTextField = "language_name";
            ddlLanguage.DataValueField = "pk_language_id";
            ddlLanguage.DataSource = ds;
            ddlLanguage.DataBind();


        }

        catch (Exception ex)
        {
            ExceptionHandle("BindLanguage :-", ex);
        }


    }

    //***************************************************************
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
                if (isValidUser)
                {
                    if (SessionController.Users_.UserSystemRole != "SA")
                    {
                        DataSet ds_ConnString = new DataSet();
                        obj_mdl.UserId = new Guid(ds.Tables[0].Rows[0]["UserID"].ToString());
                        ds_ConnString = obj_crtl.GetConnectionStringUser(obj_mdl);
                        //SessionController.ConnectionString =crypto.Encrypt(ds_ConnString.Tables[0].Rows[0]["connection_string"].ToString());

                        LoginModel obj_LoginModel = new LoginModel();
                        LoginClient obj_LoginClient = new LoginClient();
                        DataSet ds_recentFacility = new DataSet();

                        obj_LoginModel.UserId  = new Guid(ds.Tables[0].Rows[0]["UserID"].ToString());
                        ds_recentFacility = obj_LoginClient.GetRecentFacilityDataFM(obj_LoginModel);

                        if (ds_recentFacility.Tables[0].Rows.Count > 0)
                        {
                            CryptoHelper crypto_obj = new CryptoHelper();
                            SessionController.ConnectionString = crypto.Encrypt(ds_recentFacility.Tables[0].Rows[0]["connection_string"].ToString());
                            SessionController.Users_.facilityID = ds_recentFacility.Tables[0].Rows[0]["facility_id"].ToString();
                            //SessionController.Users_.facilityName = ds_recentFacility.Tables[0].Rows[0]["facility_name"].ToString();
                            SessionController.Users_.ClientID = ds_recentFacility.Tables[0].Rows[0]["fk_client_id"].ToString();
                            SessionController.Users_.ClientName = ds_recentFacility.Tables[0].Rows[0]["client_name"].ToString();

                            //getting system role for setting access permissions to pages 
                            //getsystemrole();
                            
                                Response.Redirect("~/App/Reports/dashboard.aspx", false);
                           

                        }
                        else
                        {
                            SessionController.ConnectionString =crypto.Encrypt(ds_ConnString.Tables[0].Rows[0]["connection_string"].ToString());
                            SessionController.Users_.ClientID = (ds_ConnString.Tables[0].Rows[0]["pk_client_id"].ToString());
                            SessionController.Users_.ClientName = (ds_ConnString.Tables[0].Rows[0]["client_name"].ToString());
                            SessionController.Users_.facilityID = Guid.Empty.ToString();
                            SessionController.Users_.facilityName = "ALL";
                            Response.Redirect("~/App/Reports/dashboard.aspx", false);
                        }
                       //// Response.Redirect("~/App/FacilityList.aspx?Flag=NO", false);
                    }
                    else
                    {
                        Response.Redirect("~/App/Central/Client.aspx", false);
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
                lblFailureText.Text = ds.Tables[0].Rows[0]["ERROR"].ToString();
            }
            else if (ds.Tables[0].Rows[0]["ERROR"].ToString() == "Provided password is not correct. Please re-enter the password.")
            {
                lblFailureText.Text = ds.Tables[0].Rows[0]["ERROR"].ToString();
            }
            else if (ds.Tables[0].Rows[0]["ERROR"].ToString() == "This account is not enabled. Please contact your system administrator.")
            {
                lblFailureText.Text = ds.Tables[0].Rows[0]["ERROR"].ToString();
            }
            else if (ds.Tables[0].Rows[0]["SystemRole"].ToString() == "LU")
            {
                lblFailureText.Text = "Sorry, your access level does not allow you to login.";
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
        lblFailureText.Text = error_msg + ":- " + ex.Message.ToString();
    }
    protected void Redirect_Btn_Click(object sender, EventArgs e)
    {
        SessionController.Users_.is_PM_FM = "FM";
        Response.Redirect("~/App/Reports/dashboard.aspx", false);
    }

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


    protected void ddlLanguage_SelectedIndexChanged(object sender, EventArgs e)
    {

        DataSet ds = new DataSet();
        LoginClient login_obj = new LoginClient();
        LoginModel login_mdl = new LoginModel();
        login_mdl.Language_id = new Guid(ddlLanguage.SelectedValue);
        login_obj.setApplicationlangauage(login_mdl);

    }
}