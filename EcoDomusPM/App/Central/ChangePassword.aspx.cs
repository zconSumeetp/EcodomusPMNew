using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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

public partial class App_Central_ChangePassword : System.Web.UI.Page
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
        if (!IsPostBack)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append((string)GetGlobalResourceObject("Resource", "Change_Password"));
            builder.Append("<strong><br /><br />");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_1"));
            builder.Append(":</strong><ul class='style1' style='color: rgb(51, 51, 51); font-size: small; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);'><li>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_2"));
            builder.Append(".</li><li>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_3"));
            builder.Append(".</li><li>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_4"));
            builder.Append(".</li><li>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_5"));
            builder.Append(":<ul><li>&emsp;");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_6"));
            builder.Append(".</li><li>&emsp;");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_7"));
            builder.Append(".</li><li>&emsp;");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_8"));
            builder.Append(".</li></ul></li><li>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_9"));
            builder.Append(".</li></ul>");
            builder.Append("<p class='style1' style='color: rgb(51, 51, 51); font-size: small; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);'>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_10"));
            builder.Append(":</p><ul class='style1' style='color: rgb(51, 51, 51); font-size: small; font-style: normal;font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);'><li>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_11"));
            builder.Append(".</li><li>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_12"));
            builder.Append(".</li></ul>");
            builder.Append("<p class='style1' style='color: rgb(51, 51, 51); font-size: small; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);'>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_13"));
            builder.Append(":</p>");
            builder.Append("<ul class='style1' style='color: rgb(51, 51, 51); font-size: small; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);'><li>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_14"));
            builder.Append(".</li><li>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_15"));
            builder.Append(".</li></ul>");

            lblChangePassword.Text = builder.ToString();
        }
    }

    protected void btnChangePassword_OnClick(object sender, EventArgs e)
    {
        CryptoHelper crypto_obj = new CryptoHelper();

        UserClient ctrl = new UserClient();
        UserModel mdl = new UserModel();

        string PwdRegularExpr = System.Configuration.ConfigurationManager.AppSettings["PwdRegularExpr"].ToString();
        if (!Regex.IsMatch(txtNewPassword.Text, PwdRegularExpr))
        {
            StringBuilder builder = new StringBuilder();
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_1"));
            builder.Append(":<ul><li>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_2"));
            builder.Append(".</li><li>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_3"));
            builder.Append(".</li><li>");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_5"));
            builder.Append(":<ul><li>&emsp;");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_6"));
            builder.Append(".</li><li>&emsp;");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_7"));
            builder.Append(".</li><li>&emsp;");
            builder.Append((string)GetGlobalResourceObject("Resource", "Password_Rule_8"));
            builder.Append(".</li></ul></li></ul>");
            lblError.Text = builder.ToString();
            return;
        }

        mdl.Passward = crypto_obj.Encrypt(txtNewPassword.Text);
        mdl.Old_Passward = crypto_obj.Encrypt(txtOldPassword.Text);
        mdl.UserId = new Guid(SessionController.Users_.UserId);

        string messege = ctrl.ChangePassword(mdl);
        if (messege.Equals("Success"))
        {
            SendPasswordChangeEmail();

            SessionController.Users_.Password_Change_Flag = false;

            if (SessionController.Users_.UserSystemRole != "SA")
            {
                Response.Redirect("~/App/Reports/Dashboard_PM.aspx", false);
            }
            else
            {
                Response.Redirect("~/App/Central/Client.aspx", false);
            }
        }
        else if (messege.Equals("Password matched"))
        {
            lblError.Text = (string)GetGlobalResourceObject("Resource", "Password_Rule_16") + ".";
        }
        else
        {
            lblError.Text = (string)GetGlobalResourceObject("Resource", "Password_change_message") + ".";
        }
    }

    public void SendPasswordChangeEmail()
    {
        try
        {
            UserModel mdlUser = new UserModel();
            mdlUser.UserId = new Guid(SessionController.Users_.UserId);
            UserClient clUser = new UserClient();
            DataSet ds = clUser.GetUserDetails(mdlUser);

            MailControl mailControl = new MailControl();
            MailModel mailModel = new MailModel();

            string mailbody = "Dear " + ds.Tables[0].Rows[0]["first_name"].ToString() + " " + ds.Tables[0].Rows[0]["last_name"].ToString() + ",<br><br>&emsp;&emsp;Your password has been changed successfully...";
            mailbody += "<br><br>&emsp;&emsp;Your new password is: <b>" + txtNewPassword.Text;
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
}