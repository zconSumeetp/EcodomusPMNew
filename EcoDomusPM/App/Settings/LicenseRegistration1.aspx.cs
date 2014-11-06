using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Data.SqlClient;
using Login;
using EcoDomus.Session;
using Dashboard;
using Project;
using System.Configuration;
using System.Web.Configuration;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Mail.Control;
using EcoDomus.Mail.Model;
using System.Net.NetworkInformation;
using EcoDomus.ActivateLicense;

public partial class App_Settings_LicenseRegistration1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {
                tr_duration.Visible = false;
            }
        }
        else
        {
            Response.Redirect("~/App/Login_PM.aspx", false);
        }

    }
    protected void btn_trail_Click(object sender, EventArgs e)
    {
        if (Rb_list_duration.SelectedIndex != 0)
        {
            if (dd_years.SelectedValue == "0")
            {
                lbl_req_field2.Text = " *";
                return;
            }
            else
            {
                lbl_req_field.Text = "";
                lbl_req_field2.Text = "";
                SendRequest();
            }
        }
        else
        {
            if (txt_email.Text != "")
            {
                lbl_req_field.Text = "";
                lbl_req_field2.Text = "";
                SendRequest();
            }
            else
            {
                lbl_req_field.Text = " *";
            }
        }
    }
    protected void btn_activate_Click(object sender, EventArgs e)
    {
        try
        {
            ActivateLicense validate = new ActivateLicense();
            DataSet ds = new DataSet();
            int[] arr_app = new int[] { 2, 3, 4, 5 };
            Login.LoginModel obj_mdl = new Login.LoginModel();
            Login.LoginClient obj_crtl = new Login.LoginClient();
             ds = obj_crtl.GetSequenceKeys(obj_mdl);
            lbl_activation_msg.Text = validate.activate_key(txt_key.Text.Trim(), ds, arr_app);
            lbl_activation_msg.Text = lbl_activation_msg.Text + "<br/>Click on Continue to use EcoDomus Application";
            //MessageBox("Key Activated.. You will be redirected to login page");
            //Response.Redirect("~/App/Login.aspx", false);
        }
        catch (Exception)
        {
            lbl_activation_msg.Text = "Activation Failed. Invalid key";
            //throw;
        }
    }
    protected void btn_cont_Click(object sender, EventArgs e)
    {
        Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
    }
    private void MessageBox(string msg)
    {
        Label lbl = new Label();
        lbl.Text = "<script language='javascript'>" + Environment.NewLine + "window.alert('" + msg + "')</script>";
        Page.Controls.Add(lbl);
    }
    private void SendRequest()
    {

        MailControl mailControl = new MailControl();
        MailModel mailModel = new MailModel();

        string mailbody = "Registration Request :<br/>";
        mailbody = mailbody + "<br/>&emsp;&emsp;Client Email Address : " + Convert.ToString(txt_email.Text).Trim();
        mailbody = mailbody + "<br/>&emsp;&emsp;Client Mac Address : " + GetMACAddress().Trim();
        mailbody = mailbody + "<br/>&emsp;&emsp;Registration type : ";
        if (dd_years.SelectedValue == "0")
        {
            mailbody = mailbody + "<b>Trial</b>";
        }
        else
        {
            mailbody = mailbody + "<b>" + dd_years.SelectedValue + " years </b>";
        }
        mailModel.Sender = ConfigurationManager.AppSettings["SupportMailId"].ToString();
        mailModel.Receiver = ConfigurationManager.AppSettings["SupportMailId"].ToString();
        mailModel.Subject = "EcoDomus: Request for License Key";
        mailModel.MessageBody = mailbody;
        mailModel.IsBodyHtml = true;
        string result = mailControl.SendMail(mailModel);
        if (result == "Mail sent successfully")
        {
            lbl_mail_note.Text = "Request sent successfully EcoDomus will send you key shortly on your specified Email Address.";
        }
        else
        {
            lbl_mail_note.Text = "Request dose not sent successfully something is wrong";
        }
    }
    public string GetMACAddress()
    {
        NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
        String sMacAddress = string.Empty;
        foreach (NetworkInterface adapter in nics)
        {
            if (sMacAddress == String.Empty)// only return MAC Address from first card  
            {
                IPInterfaceProperties properties = adapter.GetIPProperties();
                sMacAddress = adapter.GetPhysicalAddress().ToString();
            }
        }
        return sMacAddress;
    }
    protected void Rb_list_duration_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Rb_list_duration.SelectedIndex == 0)
        {
            tr_duration.Visible = false;
            dd_years.SelectedValue = "0";
        }
        else
        {
            tr_duration.Visible = true;
        }
    }
    protected void lnkbtnLogOut_Click(object sender, EventArgs e)
    {
        try
        {
            SessionController.Users_.UserId = null;
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
        catch (Exception)
        {
            Response.Redirect("~/App/LoginPM.aspx", false);
        }
    }
}