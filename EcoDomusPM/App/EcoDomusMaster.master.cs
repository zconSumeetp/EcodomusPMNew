using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dashboard;
using System.Data;
using Login;
using EcoDomus.Session;
using Locations;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using System.IO;
using System.Threading;
using System.Globalization;


public partial class App_EcoDomusMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            img_logo2.Visible = false;
            lblTodayDate.Text = DateTime.Now.Date.ToShortDateString();
            if (SessionController.Users_.UserId != null)
            {
                if (System.Configuration.ConfigurationManager.AppSettings["FAA_Client_Name"] != null)
                {
                    if (System.Configuration.ConfigurationManager.AppSettings["FAA_Client_Name"].ToString() != "")
                    {
                        if (SessionController.Users_.ClientName == System.Configuration.ConfigurationManager.AppSettings["FAA_Client_Name"].ToString())
                        {
                            Bindlogo();
                        }
                    }
                }
                /* Create the Client DB Connection object ! */
                CheckUserLoginDetail();
                 if (SessionController.Users_.is_PM_FM == "FM")
                    {
                if (!IsPostBack)
                {
                        
                        bindRadMenuData();
                        
                        if (SessionController.Users_.facilityName != "ALL")
                        {
                            chkfacility.Checked = true;
                        }

                    
                }

                        if (chkfacility.Checked == true)
                        {
                            SessionController.Users_.IsFacility = "yes";
                            DataSet ds_facilityname = new DataSet();
                            LocationsModel loc_objmdl = new LocationsModel();
                            LocationsClient loc_objcrtl = new LocationsClient();
                            //priyanka
                            if (SessionController.Users_.facilityID != null)
                            {
                                loc_objmdl.facility_ID = new Guid(SessionController.Users_.facilityID);
                                ds_facilityname = loc_objcrtl.Get_FacilityName(SessionController.ConnectionString, loc_objmdl);
                                if (ds_facilityname.Tables[0].Rows.Count > 0)
                                    SessionController.Users_.facilityName = ds_facilityname.Tables[0].Rows[0][0].ToString();
                                else
                                {
                                    SessionController.Users_.IsFacility = "no";
                                    SessionController.Users_.facilityName = "ALL";
                                }

                            }
                            else
                                SessionController.Users_.facilityName = "ALL";
                        }
                        else
                        {
                            SessionController.Users_.IsFacility = "no";
                            SessionController.Users_.facilityName = "ALL";
                        }
                        string currentPage = System.IO.Path.GetFileName(System.Web.HttpContext.Current.Request.Url.AbsolutePath).ToString();
                        BindUserDetails();
                    }

                    else
                    {
                        chkfacility.Visible = false;
                        bindRadMenuData_PM();
                        string currentPage = System.IO.Path.GetFileName(System.Web.HttpContext.Current.Request.Url.AbsolutePath).ToString();
                        BindUserDetails_PM();
                    }
                }          
            else
            {
                Response.Redirect("~\\app\\Login.aspx?Error=Session");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void InitializeCulture()
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

            redirect_page("~\\app\\Login.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }


    // for client logo on page
    public void Bindlogo()
    {
        try
        {
            DirectoryInfo di = new DirectoryInfo(Server.MapPath("~/App/Images/Client Logo"));
            string rootfolder = "~/App/Images/Client Logo";
          
            if (di.Exists == true)
            {
                if (di.GetFiles().Count() > 0)
                {
                    foreach (FileInfo fi in di.GetFiles())
                    {
                       
                            img_logo2.Visible = true;
                            img_logo2.ImageUrl = rootfolder + "/" + "Bottom_Logo.png";
                           
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }


    public void BindUserDetails()
    {
        string FacilityUrl;
        if (SessionController.Users_.facilityName != "ALL")
        {
            FacilityUrl = "<a href=../Locations/FacilityMenu.aspx?FacilityId=" + SessionController.Users_.facilityID + ">";
        }
        else
        {
            FacilityUrl = "<a href=../Locations/FindLocation.aspx>";
        }
        string isfromclient;
        // + SessionController.Users_.UserName + "</a>" + "," + "&nbsp;<a href=../Settings/OrganizationProfile.aspx?Organizationid=" + SessionController.Users_.OrganizationID + ">"
        if (SessionController.Users_.UserSystemRole.Equals("SA"))
        {
            isfromclient = "N";
        }
        else
        {
            isfromclient = "Y";
        }

        lblUserName.Text = "<b>" +HttpContext.GetGlobalResourceObject("Resource","User")+":&nbsp</b>" +
  "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=" + SessionController.Users_.UserSystemRole + ">"
   + SessionController.Users_.UserName + "</a>" + "," + "&nbsp;<a href=../Settings/SettingsMenu.aspx?organization_id=" + SessionController.Users_.OrganizationID + "&IsfromClient=" + isfromclient + ">"
  + SessionController.Users_.OrganizationName + "</a>" + "&nbsp;&nbsp;" + " " + "  <b>" + HttpContext.GetGlobalResourceObject("Resource", "System_Role") + ":&nbsp;</b>" + SessionController.Users_.UserRoleDescription + "&nbsp;&nbsp;";

        if (!SessionController.Users_.UserSystemRole.Equals("SA"))
        {
            lblUserName.Text = lblUserName.Text + " " + " <b>" + HttpContext.GetGlobalResourceObject("Resource", "Client") + ":&nbsp;</b>" + "<a href='javascript:openClientWindow()'>" + SessionController.Users_.ClientName + "</a> &nbsp;&nbsp;"
         + " " + " <b>" + HttpContext.GetGlobalResourceObject("Resource", "Facility") + ":&nbsp;</b>" + FacilityUrl + SessionController.Users_.facilityName + "</a>";
        }
        else
        {
            chkfacility.Visible = false;
        }
    }

    protected void BindUserDetails_PM()
    {
        if (SessionController.ConnectionString == null)
        {
            LoginModel lm = new LoginModel();
            LoginClient lc = new LoginClient();
            DataSet ds = new DataSet();
            CryptoHelper crypt = new CryptoHelper();
            lm.UserId = new Guid(SessionController.Users_.UserId);
            ds = lc.GetConnectionStringUser(lm);
            SessionController.ConnectionString = crypt.Encrypt(ds.Tables[0].Rows[0]["connection_string"].ToString());
        
       
            DashboardModel dm = new DashboardModel();
            DashboardClient dc = new DashboardClient();
            DataSet ds1 = new DataSet();
            dm.User_id = new Guid(SessionController.Users_.UserId);
            ds1 = dc.GetRecentUSerDataPMFM(dm, SessionController.ConnectionString);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                string project_name = ds1.Tables[0].Rows[0]["project_name"].ToString();
                SessionController.Users_.ProjectId = ds1.Tables[0].Rows[0]["pk_project_id"].ToString();
                SessionController.Users_.ProjectName = project_name;
            }
        }
        lblUserName.Text = "<b>"+ HttpContext.GetGlobalResourceObject("Resources", "User") +
":&nbsp;</b>" + "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=" + SessionController.Users_.UserSystemRole + ">" +
        SessionController.Users_.UserName + "," + SessionController.Users_.OrganizationName + "</a>" + "&nbsp;&nbsp;" + "" + "|" + "  <b>" + HttpContext.GetGlobalResourceObject("Resource", "System_Role") + ":&nbsp;</b>" + SessionController.Users_.UserRoleDescription + "&nbsp;&nbsp;"
        + "|" + " <b> Project:&nbsp;</b>" + "<a  href=../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";      
    }


    public void CheckUserLoginDetail()
    {
        LoginClient loginControl = new LoginClient();
        LoginModel loginModel = new LoginModel();

        if (SessionController.Users_.UserLoginDetailId != null)
        {
            loginModel.LoginId = new Guid(SessionController.Users_.UserLoginDetailId);
        }
        else
            loginModel.LoginId = Guid.Empty;

        string user_id = loginControl.GetLoginUserDetail(loginModel);

        if (SessionController.Users_.UserId == "" || user_id == "")
        {
            string error = "";
            if (SessionController.Users_.UserId == "")
            {
                error = "Session";
                if (Request.Cookies["test"] != null)
                {
                    DeleteExistingLoginId(Request.Cookies["test"].Value);
                    Response.Cookies["test"].Expires = DateTime.Now;
                }
            }
            else if (user_id == "")
            {
                error = "Delete";
            }
            Session.RemoveAll();
            Session.Abandon();
            Response.Redirect("~/App/Login.aspx?Error=" + error, false);
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

    void bindRadMenuData()
    {
        try
        {
            DataSet ds = new DataSet();

            LoginClient crtl = new LoginClient();
            LoginModel mdl = new LoginModel();
            mdl.UserId = new Guid(SessionController.Users_.UserId);
            mdl.SystemRole = SessionController.Users_.UserSystemRole;
            mdl.Culture= Session["Culture"].ToString();
            ds = crtl.GetMenuData(mdl);
            radQ1Menu.DataTextField = "page_heading";
            radQ1Menu.DataFieldID = "pk_page_id";
            radQ1Menu.DataFieldParentID = "parent_page_id";
            radQ1Menu.DataNavigateUrlField = "navigate_url";
            radQ1Menu.DataSource = ds;
            radQ1Menu.DataBind();
        }
        catch (Exception)
        {
        }
    }

    void bindRadMenuData_PM()
    {
        try
        {
            DataSet ds = new DataSet();
            LoginClient crtl = new LoginClient();
            LoginModel mdl = new LoginModel();
            mdl.UserId = new Guid(SessionController.Users_.UserId);
            mdl.SystemRole = SessionController.Users_.UserSystemRole;
            ds = crtl.GetMenuData_PM(mdl);
            radQ1Menu.DataTextField = "page_heading";
            radQ1Menu.DataFieldID = "pk_page_id";
            radQ1Menu.DataFieldParentID = "parent_page_id";
            radQ1Menu.DataNavigateUrlField = "navigate_url";
            radQ1Menu.DataSource = ds;
            radQ1Menu.DataBind();
        }
        catch (Exception)
        {

        }
    }

    protected void lnkbtnLogOut_Click(object sender, EventArgs e)
    {
        try
        {
            DeleteExistingLoginId(SessionController.Users_.UserLoginDetailId);
        }
        catch (Exception)
        {

        }
    }

    protected void divHelp_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Response.ContentType = "Application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=EcoDomus FM User Guide.pdf");
            Response.TransmitFile(Server.MapPath("~/App/Files/EcoDomus FM User Guide.pdf"));
            Response.End();
        }
        catch (Exception)
        {

        }
    }

    public void DeleteExistingLoginId(string loginID)
    {
        LoginClient obj_crtl = new LoginClient();
        LoginModel obj_mdl = new LoginModel();

        if (SessionController.Users_.is_PM_FM == "FM")
        {

            obj_mdl.LoginId = new Guid(loginID);
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
            Response.Redirect("~/App/Login.aspx", false);
        }
        else
        {
            obj_mdl.LoginId = new Guid(loginID);
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
            Response.Redirect("~/App/LoginPM.aspx", false);
        }
    }

}
