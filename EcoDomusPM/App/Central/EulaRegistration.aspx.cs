using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Login;
using EcoDomus.Session;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using User;
using System.Threading;
using System.Globalization;
using System.Text.RegularExpressions;
using EcoDomus.Mail.Control;
using EcoDomus.Mail.Model;
using System.Configuration;
using System.Data;
using System.Text;

public partial class App_Central_Default : System.Web.UI.Page
{
    protected override void InitializeCulture()
    {
        try
        {
            string culture;

            if (Session["Culture"] == null)
            {
                culture = "en-US";
            }
            else
            {
                culture = Convert.ToString(Session["Culture"]);
            }
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
        }
        catch
        {
            Response.Redirect("~\\app\\Login_PM.aspx?Error=Session");
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId == null)
        {
            Response.Redirect("~\\app\\Login_PM.aspx?Error=Session");
        }
    }
    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            InitializeCulture();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
        }
        catch (Exception)
        {

        }
    }
    protected void btnIAgree_Click(object sender, EventArgs e)
    {
        UserClient ctrl = new UserClient();
        UserModel mdl = new UserModel();
        mdl.UserId = Guid.Parse(SessionController.Users_.UserId);
        ctrl.proc_enable_user(mdl);
        SessionController.Users_.User_enabled = true;
        string userrole = SessionController.Users_.UserSystemRole.ToString();
        //if (userrole.Equals("SA"))
        //{
        //    Response.Redirect("~/App/Central/Client.aspx", false);
        //}
        //else
        //{
            //Response.Redirect("~/App/Reports/Dashboard_PM.aspx", false);
        //}

            if (!Convert.ToBoolean(SessionController.Users_.User_enabled))
            {
                Response.Redirect("~/App/Central/EulaRegistration.aspx", false);
            }
            if (Convert.ToBoolean(SessionController.Users_.Password_Change_Flag))
            {
                Response.Redirect("~\\App\\Central\\ChangePassword.aspx");
            }
    }
    protected void lnkbtnLogOut_Click(object sender, EventArgs e)
    {
        LoginClient obj_crtl = new LoginClient();
        LoginModel obj_mdl = new LoginModel();


        obj_mdl.LoginId = new Guid(SessionController.Users_.UserLoginDetailId);
        obj_crtl.DeleteLoginUserDetail(obj_mdl);

        if (Request.Cookies["FromPerioddate"] != null)
            Response.Cookies["FromPerioddate"].Value = "";
        if (Request.Cookies["ToPerioddate"] != null)
            Response.Cookies["ToPerioddate"].Value = "";
        Session.RemoveAll();
        Session.Clear();
        Session.Abandon();
        Response.Cache.SetNoServerCaching();
        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        Response.Cache.SetNoStore();

        //Delete cookies
        string[] cook = Request.Cookies.AllKeys;
        foreach (string cookie in cook)
        {
            Response.Cookies[cookie].Expires = DateTime.Now.AddDays(-1);
        }

        Response.Redirect("~/App/LoginPM.aspx", false);
    }
    protected void btnIDecline_Click(object sender, EventArgs e)
    {
        LoginClient obj_crtl = new LoginClient();
        LoginModel obj_mdl = new LoginModel();


        obj_mdl.LoginId = new Guid(SessionController.Users_.UserLoginDetailId);
        obj_crtl.DeleteLoginUserDetail(obj_mdl);

        if (Request.Cookies["FromPerioddate"] != null)
            Response.Cookies["FromPerioddate"].Value = "";
        if (Request.Cookies["ToPerioddate"] != null)
            Response.Cookies["ToPerioddate"].Value = "";
        Session.RemoveAll();
        Session.Clear();
        Session.Abandon();
        Response.Cache.SetNoServerCaching();
        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        Response.Cache.SetNoStore();

        //Delete cookies
        string[] cook = Request.Cookies.AllKeys;
        foreach (string cookie in cook)
        {
            Response.Cookies[cookie].Expires = DateTime.Now.AddDays(-1);
        }

        Response.Redirect("~/App/LoginPM.aspx", false);
    }
}