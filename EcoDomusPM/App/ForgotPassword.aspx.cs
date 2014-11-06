using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using User;
using EcoDomus.Mail.Control;
using EcoDomus.Mail.Model;
using System.Web.Configuration;
using System.Configuration;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using System.Data;
using System.Threading;
using System.Globalization;

public partial class App_ForgotPassword : System.Web.UI.Page
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

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            UserModel mdlUser = new UserModel();
            mdlUser.UserName = UserName.Text;
            UserClient clUser = new UserClient();
            DataSet ds = clUser.get_user_details_from_username(mdlUser);

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["email_address"].ToString().Equals(UserEmail.Text))
                    {
                        CryptoHelper crypto = new CryptoHelper();

                        MailControl mailControl = new MailControl();
                        MailModel mailModel = new MailModel();

                        string mailbody = "Dear " + ds.Tables[0].Rows[0]["first_name"].ToString() + " " + ds.Tables[0].Rows[0]["last_name"].ToString() + ",<br><br>&emsp;&emsp;Your password for EcoDomus account is: <b>";
                        mailbody += crypto.Decrypt(ds.Tables[0].Rows[0]["password"].ToString());
                        mailbody += "</b><br><br><span style='color:#4F6228'>Thanks!</span><br> <b><span style='color:#4F6228'>EcoDomus, Inc.</span></b>";

                        mailModel.Sender = ConfigurationManager.AppSettings["SupportMailId"].ToString();
                        mailModel.Receiver = UserEmail.Text;
                        mailModel.Subject = "EcoDomus: Password for EcoDomus Account";
                        mailModel.MessageBody = mailbody;
                        mailModel.IsBodyHtml = true;
                        string result = mailControl.SendMail(mailModel);

                        if (result.Equals("Mail sent successfully"))
                        {
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Script", "RedirectUser();", true);
                        }
                        else
                        {
                            lblFailureText.Text = (string)GetGlobalResourceObject("Resource", "Error_sending_Email") + ".";
                        }
                    }
                    else
                    {
                        lblFailureText.Text = (string)GetGlobalResourceObject("Resource", "Authentication_error") + ".";
                    }
                }
                else
                {
                    lblFailureText.Text = (string)GetGlobalResourceObject("Resource", "Authentication_error") + ".";
                }
            }
            else
            {
                lblFailureText.Text = (string)GetGlobalResourceObject("Resource", "Authentication_error") + ".";
            }
        }
        catch (Exception ex)
        {
            lblFailureText.Text = "Error: " + ex.Message;
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~//App/LoginPM.aspx");
    }

    protected void postback_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/App/LoginPM.aspx");
    }
}