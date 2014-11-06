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
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.ActivateLicense;

public partial class App_Sample_master : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //lblTodayDate.Text = DateTime.Now.Date.ToShortDateString();
            //if (SessionController.Users_.ProjectId == "")
            //{            
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "project_validate();", true);
            //}   

            if (SessionController.Users_.UserId != null)
            {
                //if (SessionController.Users_.ProjectName == null)
                //{
                //    string nw1 = "<script language='javascript'>alert('Please select the project in Settings -> Projects.\\nIf you do not have any projects assigned,\\ncontact your System Administrator.');window.location = '../Settings/Project.aspx';</script>";
                //    Page.ClientScript.RegisterStartupScript(this.GetType(), "script", nw1, false);
                //}
                if (Convert.ToBoolean(SessionController.Users_.Password_Change_Flag))
                {
                    Response.Redirect("~\\App\\Central\\ChangePassword.aspx");
                }

                CheckUserLoginDetail();
                if (!IsPostBack)
                {
                    if ((SessionController.Users_.UserSystemRole != "SA") && (SessionController.Users_.ProjectId != null) && (SessionController.Users_.ProjectId != Guid.Empty.ToString()))
                    {
                        GetPermissionsForProjectRole();
                    }
                    BindToDataSet();

                }
                //string currentPage = System.IO.Path.GetFileName(System.Web.HttpContext.Current.Request.Url.AbsolutePath).ToString();
                //bind_user_details_pm();
                /*--for licesing--*/
                string currentPage = string.Empty;
                ActivateLicense validate = new ActivateLicense();
                string login_chk = validate.Validate_login();
                if (Convert.ToString(login_chk) != "success")
                {
                    //Response.Redirect("~/App/Settings/LicenseRegistration.aspx", false);
                    currentPage = "LicenseRegistration.aspx"; //System.IO.Path.GetFileName("EcoDomus_FM/App/Settings/LicenseRegistration.aspx").ToString();
                    if (SessionController.Users_.UserSystemRole == "SA")
                    {
                        lbl_license_msg.Text = validate.date_calculate();
                    }
                }
                else
                {
                    currentPage = System.IO.Path.GetFileName(System.Web.HttpContext.Current.Request.Url.AbsolutePath).ToString();
                    bind_user_details_pm();
                    if (SessionController.Users_.UserSystemRole == "SA")
                    {
                        lbl_license_msg.Text = validate.date_calculate();
                    }
                }

            }
            else
            {
                Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            }

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "controls", "control();", true);
        }
        catch (Exception ex)
        {
            throw ex;
        }
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
            Response.Redirect("~/App/LoginPM.aspx?Error=" + error, false);
        }
    }

    private void BindToDataSet()
    {
        LoginModel lm = new LoginModel();
        LoginClient lc = new LoginClient();
        lm.UserId = new Guid(SessionController.Users_.UserId.ToString());
        //lm.UserId = new Guid("0b2b9e58-80c4-42fe-b3eb-f22e9470375c".ToString());
        //lm.SystemRole = "OA";
        lm.SystemRole = SessionController.Users_.UserSystemRole;
        lm.Culture = Session["Culture"].ToString();

        DataSet links = new DataSet();

        //Bind RadPanelBar for PM:-
        DataSet linksnew = new DataSet();
        if (SessionController.Users_.is_PM_FM == "PM")
        {
            links = lc.GetMenuData_PM(lm);

            linksnew = lc.GetMenuData_PM(lm);
        }
        //Bind RadPanelBar for FM:-
        else if (SessionController.Users_.is_PM_FM == "FM")
        {
            links = lc.GetMenuData(lm);
            linksnew = lc.GetMenuData(lm);
        }

        //DataRow drlinks = links.Tables[0].Select("page_heading='Component'")[0];
        // DataSet dspermissions_for_role = Session["permissions"] as DataSet;

        //if (SessionController.Users_.UserSystemRole != "SA" && SessionController.Users_.ClientName == "EcoDomus")// for roles and permissions its only for other users than SA
        //{
        //    DataSet dspermissions_for_role = SessionController.Users_.Permission_ds;
        //    foreach (DataRow dr in links.Tables[0].Rows)
        //    {
        //        DataRow[] drlinkscollection = dspermissions_for_role.Tables[0].Select("name='" + dr["page_heading"] + "'");
        //        DataRow[] drlinksnew = linksnew.Tables[0].Select("page_heading='" + dr["page_heading"] + "'");
        //        if (drlinkscollection.Length > 0)
        //            if (drlinkscollection[0]["view_permission"].ToString() == "N")
        //            {
        //                linksnew.Tables[0].Rows.Remove(drlinksnew[0]);
        //            }


        //    }

        //}


        RadPanelBar1.DataTextField = "page_heading1";
        RadPanelBar1.DataNavigateUrlField = "navigate_url";
        RadPanelBar1.DataValueField = "page_heading";
        RadPanelBar1.DataFieldID = "pk_page_id";
        RadPanelBar1.DataFieldParentID = "parent_page_id";
        RadPanelBar1.DataSource = linksnew;
        RadPanelBar1.DataBind();
        if ((SessionController.Users_.is_PM_FM == "PM") && (SessionController.Users_.UserSystemRole != "SA") && (SessionController.Users_.UserSystemRole == "OA"))
        {
            RadPanelBar1.Items[7].Visible = false;
        }
        else if ((SessionController.Users_.is_PM_FM == "PM") && (SessionController.Users_.UserSystemRole != "SA") && (SessionController.Users_.UserSystemRole == "PA"))
        {
            RadPanelBar1.Items[6].Visible = false;
        }
        else if ((SessionController.Users_.is_PM_FM == "PM") && (SessionController.Users_.UserSystemRole != "SA") && (SessionController.Users_.UserSystemRole == "GU"))
        {
            RadPanelBar1.Items[4].Visible = false;
            RadPanelBar1.Items[5].Visible = false;
            RadPanelItem item = RadPanelBar1.FindItemByValue("Add Issue");
            if (item != null)
            {
                item.Owner.Items.Remove(item);
            }
        }
        else if ((SessionController.Users_.is_PM_FM == "PM") && (SessionController.Users_.UserSystemRole != "SA") && (SessionController.Users_.UserSystemRole == "CBU"))
        {
            RadPanelBar1.Items[4].Visible = false;
            RadPanelBar1.Items[2].Visible = false;
            RadPanelBar1.Items[5].Visible = false;
        }
        bind_setting_panel();
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

    public void DeleteExistingLoginId(string loginID)
    {
        LoginClient obj_crtl = new LoginClient();
        LoginModel obj_mdl = new LoginModel();


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

        //Delete cookies
        string[] cook = Request.Cookies.AllKeys;
        foreach (string cookie in cook)
        {
            Response.Cookies[cookie].Expires = DateTime.Now.AddDays(-1);
        }

        Response.Redirect("~/App/LoginPM.aspx", false);

    }

    public void bind_setting_panel()
    {
        try
        {
            LoginModel lm = new LoginModel();
            LoginClient lc = new LoginClient();
            lm.SystemRole = SessionController.Users_.UserSystemRole;
            lm.Culture = Session["Culture"].ToString();
            DataSet ds = new DataSet();
            ds = lc.GetSettingMenuPM(lm);

            rad_panel_setting.DataTextField = "page_heading1";
            rad_panel_setting.DataNavigateUrlField = "navigate_url";
            rad_panel_setting.DataFieldID = "pk_page_id";
            rad_panel_setting.DataFieldParentID = "parent_page_id";
            rad_panel_setting.DataSource = ds;
            rad_panel_setting.DataBind();

            rad_panel_setting.Items[0].Visible = true;
            if (SessionController.Users_.UserSystemRole == "GU" || SessionController.Users_.UserSystemRole == "PA")
            {
                rad_panel_setting.Items[1].Visible = false;
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void bind_user_details_pm()
    {
        //if (SessionController.ConnectionString == null)
        //{
        LoginModel lm = new LoginModel();
        LoginClient lc = new LoginClient();
        DataSet ds = new DataSet();
        CryptoHelper crypt = new CryptoHelper();

        lm.UserId = new Guid(SessionController.Users_.UserId); //earlier
        ds = lc.GetConnectionStringUser(lm);
        string SA_org = ds.Tables[0].Rows[0]["name"].ToString();
        Guid SA_orgid = new Guid(ds.Tables[0].Rows[0]["pk_organization_id"].ToString());
        //    SessionController.ConnectionString = crypt.Encrypt(ds.Tables[0].Rows[0]["connection_string"].ToString());

        //    DashboardModel dm = new DashboardModel();
        //    DashboardClient dc = new DashboardClient();
        //    DataSet ds1 = new DataSet();
        //    dm.User_id = new Guid(SessionController.Users_.UserId);
        //    ds1 = dc.GetRecentUSerDataPMFM(dm, SessionController.ConnectionString);

        //    SessionController.ConnectionString = crypt.Encrypt(ds.Tables[0].Rows[0]["connection_string"].ToString());

        //    if (SessionController.Users_.UserSystemRole != "SA")
        //    {
        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            SessionController.Users_.ProjectId = ds.Tables[0].Rows[0]["project_id"].ToString();
        //            ProjectModel pm = new ProjectModel();
        //            ProjectClient pc = new ProjectClient();
        //            pm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
        //            DataSet dsproj = new DataSet();
        //            dsproj = pc.GetProjectDataById(pm, SessionController.ConnectionString);
        //            SessionController.Users_.ProjectName = dsproj.Tables[0].Rows[0]["project_name"].ToString();
        //        }
        //    }
        //}

        string orgname = HttpUtility.UrlPathEncode(SessionController.Users_.OrganizationName);

        //For Actual OA
        if ((SessionController.Users_.UserSystemRole == "OA") && (SessionController.Users_.UserRoleDescription != "System Admin"))
        {
            lbl_user.Text = "<b>" + HttpContext.GetGlobalResourceObject("Resource", "User") + ":&nbsp</b>" + "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=" + SessionController.Users_.UserSystemRole + ">" +
            SessionController.Users_.UserName + "</a>" + ",&nbsp;&nbsp;" + "<a href=../Settings/SettingsMenu.aspx?organization_id=" + SessionController.Users_.OrganizationID + "&Organization_name=" + orgname + "&IsfromClient=Y" + ">" + SessionController.Users_.OrganizationName + "</a>" + "&nbsp;&nbsp;" + "" + "|" + "  <b>" + HttpContext.GetGlobalResourceObject("Resource", "System_Role") + ":&nbsp;</b>" + SessionController.Users_.UserRoleDescription + "&nbsp;&nbsp;"
            + "|" + "<b>" + HttpContext.GetGlobalResourceObject("Resource", "Project") + ":&nbsp</b>" + "<a  href=../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
        }
        else if (SessionController.Users_.UserSystemRole == "SA") // For actual SA
        {
            //lbl_user.Text = "<b>" + HttpContext.GetGlobalResourceObject("Resource", "User") + ":&nbsp</b>" + "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=" + SessionController.Users_.UserSystemRole + ">" +
            //SessionController.Users_.UserName + "</a>" + ",&nbsp;&nbsp;" + "<a href=../Settings/SettingsMenu.aspx?organization_id=" + SessionController.Users_.OrganizationID + "&Organization_name=" + orgname + "&IsfromClient=N" + ">" + SessionController.Users_.OrganizationName + "</a>" + "&nbsp;&nbsp;" + "" + "|" + "  <b>" + HttpContext.GetGlobalResourceObject("Resource", "System_Role") + ":&nbsp;</b>" + SessionController.Users_.UserRoleDescription + "&nbsp;&nbsp;";

            lbl_user.Text = "<b>" + HttpContext.GetGlobalResourceObject("Resource", "User") + ":&nbsp</b>" + "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=" + SessionController.Users_.UserSystemRole + ">" +
            SessionController.Users_.UserName + "</a>" + ",&nbsp;&nbsp;" + "<a href=../Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + ">" + SA_org + "</a>" + "&nbsp;&nbsp;" + "" + "|" + "  <b>" + HttpContext.GetGlobalResourceObject("Resource", "System_Role") + ":&nbsp;</b>" + SessionController.Users_.UserRoleDescription + "&nbsp;&nbsp;";

            Label1.Visible = false;
        }
        // For SA when he proxy logs in as OA
        else if ((SessionController.Users_.UserSystemRole == "OA") && (SessionController.Users_.UserRoleDescription == "System Admin") || (SessionController.Users_.UserSystemRole == "CBU") && (SessionController.Users_.UserRoleDescription == "COBie Basic User" || SessionController.Users_.UserRoleDescription == "System Admin"))
        {
            lbl_user.Text = "<b>" + HttpContext.GetGlobalResourceObject("Resource", "User") + ":&nbsp</b>" + "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=" + SessionController.Users_.UserSystemRole + ">" +
            SessionController.Users_.UserName + "</a>" + ",&nbsp;&nbsp;" + "<a href=../Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + ">" + SA_org + "</a>" + "&nbsp;&nbsp;" + "" + "|" + "  <b>" + HttpContext.GetGlobalResourceObject("Resource", "System_Role") + ":&nbsp;</b>" + SessionController.Users_.UserRoleDescription + "&nbsp;&nbsp;"
            + "|" + "<b>" + HttpContext.GetGlobalResourceObject("Resource", "Project") + ":&nbsp</b>" + "<a  href=../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";

        }
        else if ((SessionController.Users_.UserSystemRole == "PA") && (SessionController.Users_.UserRoleDescription == "Project Admin") || (SessionController.Users_.UserSystemRole == "GU") && (SessionController.Users_.UserRoleDescription == "Generic User"))
        {
            lbl_user.Text = "<b>" + HttpContext.GetGlobalResourceObject("Resource", "User") + ":&nbsp</b>" + "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=" + SessionController.Users_.UserSystemRole + ">" +
            SessionController.Users_.UserName + "</a>" + ",&nbsp;&nbsp;" + SA_org + "&nbsp;&nbsp;" + "" + "|" + "  <b>" + HttpContext.GetGlobalResourceObject("Resource", "System_Role") + ":&nbsp;</b>" + SessionController.Users_.UserRoleDescription + "&nbsp;&nbsp;"
            + "|" + "<b>" + HttpContext.GetGlobalResourceObject("Resource", "Project") + ":&nbsp</b>" + "<a  href=../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";

        }
        else if ((SessionController.Users_.UserSystemRole == "PA") && (SessionController.Users_.UserRoleDescription == "System Admin") || (SessionController.Users_.UserSystemRole == "GU") && (SessionController.Users_.UserRoleDescription == "System Admin"))
        {
            lbl_user.Text = "<b>" + HttpContext.GetGlobalResourceObject("Resource", "User") + ":&nbsp</b>" + "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=" + SessionController.Users_.UserSystemRole + ">" +
            SessionController.Users_.UserName + "</a>" + ",&nbsp;&nbsp;" + SA_org + "&nbsp;&nbsp;" + "" + "|" + "  <b>" + HttpContext.GetGlobalResourceObject("Resource", "System_Role") + ":&nbsp;</b>" + SessionController.Users_.UserRoleDescription + "&nbsp;&nbsp;"
            + "|" + "<b>" + HttpContext.GetGlobalResourceObject("Resource", "Project") + ":&nbsp</b>" + "<a  href=../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";

        }
    }


    public void GetPermissionsForProjectRole()
    {
        try
        {
            Roles.RolesClient obj_roleClient = new Roles.RolesClient();
            Roles.RolesModel obj_roleModel = new Roles.RolesModel();
            DataSet ds = new DataSet();
            obj_roleModel.Fk_project_id = new Guid(SessionController.Users_.ProjectId);
            obj_roleModel.User_Id = new Guid(SessionController.Users_.UserId);
            ds = obj_roleClient.GetPermissionsForProjectRole(obj_roleModel, SessionController.ConnectionString);
            SessionController.Users_.Permission_ds = ds;
        }

        catch (Exception ex)
        {
            throw ex;
        }
    }

    //protected void btnbindRadmenu_click(object sender, EventArgs e)
    //{ 


    //    LoginModel lm = new LoginModel();
    //    LoginClient lc = new LoginClient();
    //    lm.UserId = new Guid(SessionController.Users_.UserId.ToString());
    //    //lm.UserId = new Guid("0b2b9e58-80c4-42fe-b3eb-f22e9470375c".ToString());
    //    lm.SystemRole = "OA";
    //    DataSet ds = new DataSet();
    //    ds = lc.GetMenuData_PM(lm);
    //    rad_panel_setting.DataSource = ds;
    //    rad_panel_setting.DataBind();

    //    rad_panel_setting.Items[0].Visible = false;
    //    rad_panel_setting.Items[1].Visible = false;
    //    rad_panel_setting.Items[2].Visible = false;
    //    rad_panel_setting.Items[3].Visible = false;
    //    rad_panel_setting.Items[4].Visible = false;
    //    rad_panel_setting.Items[5].Visible = false;
    //    rad_panel_setting.Items[6].Visible = false;


    //    rad_panel_setting.Items[7].Visible = true;

    //}
}