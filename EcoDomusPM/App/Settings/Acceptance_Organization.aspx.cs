using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using Client;
using EcoDomus.EncrptDecrypt;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using System.Data;
using EcoDomus.Common;
using Login;
using System.Threading;
using System.Globalization;


public partial class App_Settings_Acceptance_Organization : System.Web.UI.Page
{
    //Guid encry_value = Guid.Empty;
    string encry_value;
    string encry_client_id;
    CryptoHelper crypto = new CryptoHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SetSession();
        }
    }
    protected void btnAccept_Click(object sender, EventArgs e)
    {

        if (SessionController.Users_.UserId != null)
        {

            if (SessionController.Users_.ClientID != null)
            {
                try
                {
                    ClientOrganization.ClientOrganizationClient OrganizationClient = new ClientOrganization.ClientOrganizationClient();

                    ClientOrganization.ClientOrganizationModel OrganizationModel = new ClientOrganization.ClientOrganizationModel();

                    OrganizationModel.ClientId = new Guid(SessionController.Users_.ClientID);
                    encry_value = Request.QueryString["org_id"].ToString();
                   // OrganizationModel.Organization_Id = new Guid(Request.QueryString["org_id"].ToString());
                   // OrganizationModel.Organization_Id = new Guid(crypto.Decrypt(encry_value));
                   // OrganizationModel.Request_status = "A";
                    OrganizationModel.Organization_Id = new Guid(Request.QueryString["org_id"].ToString());
                    OrganizationModel.User_Id = new Guid(SessionController.Users_.UserId);
                    if (!string.IsNullOrEmpty(Request.QueryString["project_id"]))
                    {
                        OrganizationModel.Project_id = new Guid(Convert.ToString(Request.QueryString["project_id"]));
                    }

                    OrganizationClient.UpdateintoClientOrganizationLinkup(OrganizationModel, SessionController.ConnectionString);
                    lblMsg.Text = "Thank you for accepting the invitation";
                    btnDeny.Visible = false;
                    btnAccept.Enabled = false;
                    btnAccept.Text = "Accepted";
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "btnAccept_Click :-" + ex.Message.ToString();
                }

            }

        }

    }

    protected override void InitializeCulture()
    {
        try
        {
            string culture = string.Empty;
            if (Session["Culture"] != null)
            {
                culture = Session["Culture"].ToString();
                if (culture == null)
                {
                    culture = "en-US";
                }
            }
            else
            {
                culture = "en-US";
            }
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
        }
        catch (Exception ex)
        {

           // redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
    protected void SetSession()
    {
        try
        {
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            DataSet ds = new DataSet();
            //http://testfm.ecodomus.com/App/Settings/Acceptance_Organization.aspx?org_id=RDt85tYuqRaZd9HuaYqBPlUwisQNrmlKhN9yKI93bSrli!Plus!sn0jP6xQ==&client_id=jjZ4wxImXePPoLXzLQ1cYDt3kOSSbFGII7JK8CupMQ92RtMuwCmR7g==
            encry_value = Request.QueryString["org_id"].Replace("!Plus!", "+").Replace("!Hash!", "#").Replace("!And!", "&");
            //encry_value=crypto.Decrypt(encry_value);

            encry_client_id = Request.QueryString["client_id"].Replace("!Plus!", "+").Replace("!Hash!", "#").Replace("!And!", "&");
            SessionController.Users_.UserId  = Request.QueryString["id"].ToString();
            //encry_client_id = crypto.Decrypt(encry_client_id);
            GetClientInfo(new Guid(encry_client_id));
            mdl.Organization_Id = new Guid(encry_value);
            ds = obj_ctrl.GetUserSessionDetails(mdl);
            if (ds.Tables[0].Rows.Count > 0)
            {
                LoginSession lgn = new LoginSession();
                lgn.SetSession(ds);
                SessionController.Users_.ClientID = encry_client_id;
                InsertUserDetail();
            }
            else
            {
                Response.Redirect("~/App/LoginPM.aspx", false);
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "SetSession :-" + ex.Message.ToString();
        }
    }

    protected void GetClientInfo(Guid client_id)
    {
        ClientClient crtl = new ClientClient();
        ClientModel mdl = new ClientModel();
        DataSet ds = new DataSet();
        mdl.ClientId = client_id;
        ds = crtl.GetClientDetail(mdl);
        SessionController.ConnectionString = crypto.Encrypt(ds.Tables[0].Rows[0]["ConnectionString"].ToString());
        SessionController.Users_.ClientName = ds.Tables[0].Rows[0]["name"].ToString();
        SessionController.Users_.ClientID = client_id.ToString();
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
        catch (Exception)
        {
            
        }
    }

    protected void btnDeny_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (SessionController.Users_.ClientID != null)
            {
                try
                {
                    ClientOrganization.ClientOrganizationClient OrganizationClient = new ClientOrganization.ClientOrganizationClient();

                    ClientOrganization.ClientOrganizationModel OrganizationModel = new ClientOrganization.ClientOrganizationModel();

                    OrganizationModel.ClientId = new Guid(SessionController.Users_.ClientID);
                    encry_value = Request.QueryString["org_id"].Replace("!Plus!", "+").Replace("!Hash!", "#").Replace("!And!", "&");
                    // OrganizationModel.Organization_Id = new Guid(Request.QueryString["org_id"].ToString());
                    OrganizationModel.Organization_Id = new Guid(crypto.Decrypt(encry_value));
                    // OrganizationModel.Request_status = "A";
                    OrganizationModel.User_Id = new Guid(SessionController.Users_.UserId);
                    if (!string.IsNullOrEmpty(Request.QueryString["project_id"]))
                    {
                        OrganizationModel.Project_id = new Guid(Convert.ToString(Request.QueryString["project_id"]));
                    }
                    OrganizationClient.UpdateintoClientOrganizationLinkupDeny(OrganizationModel, SessionController.ConnectionString);
                    
                    lblMsg.Text = "You have denied the acceptance.";
                    btnDeny.Enabled = false;
                    btnAccept.Visible = false;
                    btnDeny.Text = "Denied";
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "btnAccept_Click :-" + ex.Message.ToString();
                }

            }

        }


    }
}