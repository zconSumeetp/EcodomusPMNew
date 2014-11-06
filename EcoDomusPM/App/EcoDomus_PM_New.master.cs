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

public partial class App_EcoDomus_PM_New : System.Web.UI.MasterPage
{
    public event EventHandler contentCallEvent;
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
                if (!Convert.ToBoolean(SessionController.Users_.User_enabled))
                {
                    Response.Redirect("~/App/Central/EulaRegistration.aspx", false);
                }
                if (Convert.ToBoolean(SessionController.Users_.Password_Change_Flag))
                {
                    Response.Redirect("~\\App\\Central\\ChangePassword.aspx");
                }

                lbtn_user_name.Text = SessionController.Users_.UserName;
                lbtn_user_name.CssClass = "userNameStyle";
                lbtn_user_name.PostBackUrl = "~/App/Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA";
                lbl_projectRole.Text = SessionController.Users_.UserRoleDescription;
                lbtn_project_name.Text = "<a  href=../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
                lbtn_project_name.CssClass = "LogoutBtnV1";

                //lblMyProjects.Text =SessionController.Users_.
                //GetorganizationProjects(crypt.Encrypt(myRow["ConnectionString"].ToString()), new Guid(myRow["client_id"].ToString()), new Guid(SessionController.Users_.OrganizationID.ToString()), Convert.ToString(myRow["is_primary_flag"]));
                hffUserIdValue.Value = SessionController.Users_.UserId;
                // btnLinkButtonProfile.PostBackUrl = "~/App/Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA";
                CheckUserLoginDetail();
                if (!IsPostBack)
                {
                    if ((SessionController.Users_.UserSystemRole != "SA") && (SessionController.Users_.ProjectId != null) && (SessionController.Users_.ProjectId != Guid.Empty.ToString()))
                    {
                        GetPermissionsForProjectRole();
                    }
                    //RadPanelBar1.FindItemByValue("Energy Modeling").DisabledCssClass = "divScroll";

                    BindToDataSet();

                }
                string currentPage = System.IO.Path.GetFileName(System.Web.HttpContext.Current.Request.Url.AbsolutePath).ToString();
                bind_user_details_pm();//Binds User Details In left Corner OF Page Containg Project ,User,Profiles,Energy Simulatin

            }
            else
            {
                Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            }
            bind_user_details_pm();

        }
        catch (Exception ex)
        {
            //throw ex;
            Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    protected int userProjectsCount()
    {
        int projectCount = 0;

        try
        {
            ProjectClient pro_client = new ProjectClient();
            ProjectModel pro_model = new ProjectModel();
            pro_model.User_id = new Guid(SessionController.Users_.UserId);
            pro_model.Conn_string = SessionController.ConnectionString;
            pro_model.Client_id = new Guid(SessionController.Users_.ClientID);
            projectCount = pro_client.GetUserProjectsCount(pro_model, SessionController.ConnectionString);

        }
        catch (Exception)
        {

            //throw;
        }
        finally
        {

        }
        return projectCount;
    }
    protected void cmdCreate_Click(DataSet ds)
    {
        tbl.Controls.Clear();
        DataRow[] Rows = ds.Tables[0].Select("parent_page_id IS NULL");
        for (int i = 0; i < Rows.Length; i++)
        {

            TableRow rowNew = new TableRow();
            tbl.Controls.Add(rowNew);

            for (int j = 0; j < 1; j++)
            {
                //Data Cell
                TableCell cellImage = new TableCell();
                Image img = new Image();
                if (Rows[i].ItemArray[2].ToString().Equals("Projects"))
                    img.ImageUrl = "~/App/Images/Icons/project_image.png";
                else if (Rows[i].ItemArray[2].ToString().Equals("Users"))
                    img.ImageUrl = "~/App/Images/Icons/icon_user_sm.png";
                else if (Rows[i].ItemArray[2].ToString().Equals("Attribute Template"))
                    img.ImageUrl = "~/App/Images/Icons/icon_documents_sm.png";
                else if (Rows[i].ItemArray[2].ToString().Equals("Setup Sync"))
                    img.ImageUrl = "~/App/Images/Icons/icon_sync_sm.png";
                img.Width = new Unit(20);
                TableCell cellData = new TableCell();
                cellData.Attributes["height"] = "25px";
                cellData.Style.Add("padding-right", "12px");
                LinkButton lnkbtn = new LinkButton();
                lnkbtn.ID = Convert.ToString(Rows[i]["pk_page_id"]);
                lnkbtn.Text = Convert.ToString(Rows[i]["page_heading1"]);
                lnkbtn.PostBackUrl = Convert.ToString(Rows[i]["navigate_url"]);
                lnkbtn.Font.Underline = false;
                cellData.Controls.Add(lnkbtn);
                cellImage.Controls.Add(img);
                rowNew.Controls.Add(cellImage);
                rowNew.Controls.Add(cellData);
            }
            //Format Row and Cell
            TableRow rowFormat = new TableRow();
            TableCell cellFormat = new TableCell();
            TableCell cellFormatEmpty = new TableCell();
            cellFormat.BackColor = System.Drawing.Color.Orange;
            cellFormat.Height = new Unit(1);
            //cellFormat.ColumnSpan = 2;
            rowFormat.Controls.Add(cellFormatEmpty);
            rowFormat.Controls.Add(cellFormat);
            if (i != Rows.Length - 1)
            {
                tbl.Controls.Add(rowFormat);
            }
        }

    }

    protected void btnLogout_OnClick(object sender, EventArgs e)
    {
        try
        {
            updateSessionOutTime(); //For ActivityLogReport: Kongkun
            DeleteExistingLoginId(SessionController.Users_.UserLoginDetailId);
        }
        catch (Exception)
        {

        }
    }

    //Helper method for updating log out time: Kongkun
    private static void updateSessionOutTime()
    {
        LoginClient loginControl = new LoginClient();
        LoginModel loginModel = new LoginModel();

        loginModel.UserId = new Guid(SessionController.Users_.UserId.ToString());
        loginModel.LoginId = new Guid(SessionController.Users_.UserLoginDetailId.ToString());
        loginModel.SessionOutTime = DateTime.Now.ToUniversalTime();

        int rowUpdated = loginControl.UpdateLoginUsersessionDetail(loginModel);
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
           linksnew = lc.GetMenuData_PM(lm);

        }
        //Bind RadPanelBar for FM:-
        else if (SessionController.Users_.is_PM_FM == "FM")
        {          
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
        //code for Scroll Bar Of RadPanelBar1 Chield Item 

        // --- for Menu Hide As per Role of user 

        if (SessionController.Users_.UserRoleDescription != "System Admin")
        {
            DashboardModel dl = new DashboardModel();
            DashboardClient dc = new DashboardClient();
            dl.User_id = new Guid(SessionController.Users_.UserId);
            dl.Culture = Session["Culture"].ToString();
            dl.ProjectId = new Guid(SessionController.Users_.ProjectId);
            DataSet ds_menu = new DataSet();
            ds_menu = dc.GetMenuForProjectRole(dl, SessionController.ConnectionString);


           
            List<string> role_based_menu_items = new List<string>();
            foreach (DataRow row in ds_menu.Tables[0].Rows)
            {
                var values = row.ItemArray;
                role_based_menu_items.Add(values[0].ToString());

            }

            foreach (RadPanelItem item in RadPanelBar1.Items)
            {
                if (role_based_menu_items.Contains(item.Value))
                {
                    item.Visible = false;
                }
            }
            

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
        obj_mdl.Application_flag = "PM";
        obj_mdl.UserId = new Guid(SessionController.Users_.UserId.ToString());

        obj_mdl.session_type = "OUT";
        obj_mdl.IpAddress = Request.ServerVariables["REMOTE_ADDR"].ToString();
        obj_mdl.LoginId = new Guid(SessionController.Users_.UserLoginDetailId.ToString());

        //obj_crtl.InsertLoginUsersessionDetail(obj_mdl);//For ActivityLogReport
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
            if (!"SelectedCulture".Equals(cookie, StringComparison.InvariantCultureIgnoreCase))
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

            //rd_seeting_info.DataSource = ds;
            //rd_seeting_info.DataBind();
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    cmdCreate_Click(ds);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void bind_user_details_pm()
    {
        LoginModel lm = new LoginModel();
        LoginClient lc = new LoginClient();
        DataSet ds = new DataSet();
        CryptoHelper crypt = new CryptoHelper();

        lm.UserId = new Guid(SessionController.Users_.UserId); //earlier
        ds = lc.GetConnectionStringUser(lm);
        if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            return;
        string SA_org = ds.Tables[0].Rows[0]["name"].ToString();
        Guid SA_orgid = new Guid(ds.Tables[0].Rows[0]["pk_organization_id"].ToString());
        //lbl_user.Text = SessionController.Users_.UserName;

        //"<a  href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA </a>";
        /* 
       * 
        //        lbl_project_name.Text = SessionController.Users_.ProjectName;
        //xxxx
         
        if (SessionController.Users_.UserRoleDescription.Equals("System Admin"))
        {
            dvSearchControl.Visible = false;
            //dvSeperator.Visible = false;
            btnSettings.Visible = false;
            btnSettingsExpand.Visible = false; //here
            //Previous code for admin for change
            lbl_project_name.Text = "<a href=../Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + ">" + SA_org + "</a>";
            //lbl_project_name.Text = "<a  href=../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
        }
     * */

        //For Actual OA
        if ((SessionController.Users_.UserSystemRole == "OA") && (SessionController.Users_.UserRoleDescription != "System Admin"))
        {
            btnSettingsExpand.Visible = true;
            //btnProfile.Visible = true;//here
            //lbl_user.Text = "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=" + SessionController.Users_.UserSystemRole + ">" + SessionController.Users_.UserName + "</a>";

            lbl_project_name.Style.Add("color", "Gray");
            //lblMyProjectCount.Text = "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA&From=projectCounts>" + userProjectsCount() + "</a>";
            lblMyProjectCount.CssClass = "LogoutBtnV1";
            //lbl_orgnization_name.Text = "<a href=../Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + " >" + SA_org + "</a>";
            if (Request.RawUrl.Contains("Training"))
            {
                lbl_orgnization_name.Text = "<a href=./Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + " >" + SA_org + "</a>";
                lbl_orgnization_name.CssClass = "LogoutBtnV1";
                lbl_project_name.Text = "<a  href=./Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
                lbl_project_name.CssClass = "LogoutBtnV1";
                lbl_user.Text = "<a  href=./Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA>" + SessionController.Users_.UserName + " </a>";
                lbl_user.CssClass = "LogoutBtnV1";
            }
            else
            {
                lbl_orgnization_name.Text = "<a href=../Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + " >" + SA_org + "</a>";
                lbl_orgnization_name.CssClass = "LogoutBtnV1";
                lbl_project_name.Text = "<a  href=../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
                lbl_project_name.CssClass = "LogoutBtnV1";
                lbl_user.Text = "<a  href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA>" + SessionController.Users_.UserName + " </a>";
                lbl_user.CssClass = "LogoutBtnV1";
            }//Request.Url.GetLeftPart(UriPartial.Authority)

        }
        else if (SessionController.Users_.UserSystemRole == "SA") // For actual SA
        {
            dvSearchControl.Visible = false;
            //dvSeperator.Visible = false;
            btnSettings.Visible = false;
            btnSettingsExpand.Visible = false;
            //btnProfile.Visible = false;//here
            //lbl_user.Text = "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=" + SessionController.Users_.UserSystemRole + ">" + SessionController.Users_.UserName + "</a>";
            //lbl_orgnization_name.Text = "<a href=../Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + " >" + SA_org + "</a>";
            //lbl_orgnization_name.CssClass = "LogoutBtnV1";
            if (Request.RawUrl.Contains("Training"))
            {
                lbl_orgnization_name.Text = "<a href=./Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + " >" + SA_org + "</a>";
                lbl_orgnization_name.CssClass = "LogoutBtnV1";
                //lbl_project_name.Text = "<a  href=./Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
                //lbl_project_name.CssClass = "LogoutBtnV1";
                lbl_user.Text = "<a  href=./Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA>" + SessionController.Users_.UserName + " </a>";
                lbl_user.CssClass = "LogoutBtnV1";
            }
            else
            {
                lbl_orgnization_name.Text = "<a href=../Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + " >" + SA_org + "</a>";
                lbl_orgnization_name.CssClass = "LogoutBtnV1";
                //lbl_project_name.Text = "<a  href=../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
                //lbl_project_name.CssClass = "LogoutBtnV1";
                lbl_user.Text = "<a  href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA>" + SessionController.Users_.UserName + " </a>";
                lbl_user.CssClass = "LogoutBtnV1";
            }
            lbl_project_name.Text = SessionController.Users_.UserRoleDescription;
        }
        // For SA when he proxy logs in as OA
        else if ((SessionController.Users_.UserSystemRole == "OA") && (SessionController.Users_.UserRoleDescription == "System Admin") || (SessionController.Users_.UserSystemRole == "CBU") && (SessionController.Users_.UserRoleDescription == "COBie Basic User" || SessionController.Users_.UserRoleDescription == "System Admin"))
        {
            dvSearchControl.Visible = true;
            //dvSeperator.Visible = true;
            btnSettings.Visible = true;
            btnSettingsExpand.Visible = true;
            //btnProfile.Visible = true;
            //lblMyProjectCount.Text = "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA&From=projectCounts>" + userProjectsCount() + "</a>";
            lblMyProjectCount.CssClass = "LogoutBtnV1";
            lbl_projectRole.Text = SessionController.Users_.UserRoleDescription;
            if (Request.RawUrl.Contains("Training"))
            {
                lbl_orgnization_name.Text = "<a href=./Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + " >" + SA_org + "</a>";
                lbl_orgnization_name.CssClass = "LogoutBtnV1";
                lbl_project_name.Text = "<a  href=./Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
                lbl_project_name.CssClass = "LogoutBtnV1";
                lbl_user.Text = "<a  href=./Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA>" + SessionController.Users_.UserName + " </a>";
                lbl_user.CssClass = "LogoutBtnV1";
            }
            else
            {
                lbl_orgnization_name.Text = "<a href=../Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + " >" + SA_org + "</a>";
                lbl_orgnization_name.CssClass = "LogoutBtnV1";
                lbl_project_name.Text = "<a  href=../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
                lbl_project_name.CssClass = "LogoutBtnV1";
                lbl_user.Text = "<a  href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA>" + SessionController.Users_.UserName + " </a>";
                lbl_user.CssClass = "LogoutBtnV1";
            }
        }
        else if ((SessionController.Users_.UserSystemRole == "PA") && (SessionController.Users_.UserRoleDescription == "Project Admin") || (SessionController.Users_.UserSystemRole == "GU") && (SessionController.Users_.UserRoleDescription == "Generic User"))
        {
            dvSearchControl.Visible = true;
            //dvSeperator.Visible = true;
            btnSettings.Visible = true;
            btnSettingsExpand.Visible = true;
            //btnProfile.Visible = true;
            //lblMyProjectCount.Text = "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA&From=projectCounts>" + userProjectsCount() + "</a>";
            lblMyProjectCount.CssClass = "LogoutBtnV1";
            lbl_projectRole.Text = SessionController.Users_.UserRoleDescription;
            if (Request.RawUrl.Contains("Training"))
            {
                lbl_orgnization_name.Text = "<a href=./Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + " >" + SA_org + "</a>";
                lbl_orgnization_name.CssClass = "LogoutBtnV1";
                lbl_project_name.Text = "<a  href=./Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
                lbl_project_name.CssClass = "LogoutBtnV1";
                lbl_user.Text = "<a  href=./Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA>" + SessionController.Users_.UserName + " </a>";
                lbl_user.CssClass = "LogoutBtnV1";
            }
            else
            {
                lbl_orgnization_name.Text = "<a href=../Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + " >" + SA_org + "</a>";
                lbl_orgnization_name.CssClass = "LogoutBtnV1";
                lbl_project_name.Text = "<a  href=../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
                lbl_project_name.CssClass = "LogoutBtnV1";
                lbl_user.Text = "<a  href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA>" + SessionController.Users_.UserName + " </a>";
                lbl_user.CssClass = "LogoutBtnV1";
            }
        }
        else if ((SessionController.Users_.UserSystemRole == "PA") && (SessionController.Users_.UserRoleDescription == "System Admin") || (SessionController.Users_.UserSystemRole == "GU") && (SessionController.Users_.UserRoleDescription == "System Admin"))
        {
            dvSearchControl.Visible = true;
            //dvSeperator.Visible = true;
            btnSettings.Visible = true;
            btnSettingsExpand.Visible = true;
            btnProfile.Visible = true;
            //lblMyProjectCount.Text = "<a href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA&From=projectCounts>" + userProjectsCount() + "</a>";
            lblMyProjectCount.CssClass = "LogoutBtnV1";
            lbl_projectRole.Text = SessionController.Users_.UserRoleDescription;
            if (Request.RawUrl.Contains("Training"))
            {
                lbl_orgnization_name.Text = "<a href=./Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + " >" + SA_org + "</a>";
                lbl_orgnization_name.CssClass = "LogoutBtnV1";
                lbl_project_name.Text = "<a  href=./Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
                lbl_project_name.CssClass = "LogoutBtnV1";
                lbl_user.Text = "<a  href=./Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA>" + SessionController.Users_.UserName + " </a>";
                lbl_user.CssClass = "LogoutBtnV1";
            }
            else
            {
                lbl_orgnization_name.Text = "<a href=../Settings/SettingsMenu.aspx?organization_id=" + SA_orgid + "&Organization_name=" + SA_org + "&IsfromClient=N" + " >" + SA_org + "</a>";
                lbl_orgnization_name.CssClass = "LogoutBtnV1";
                lbl_project_name.Text = "<a  href=../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId + "&Flag=SPP+&pagevalue=ProjectProfile>" + SessionController.Users_.ProjectName + "</a>";
                lbl_project_name.CssClass = "LogoutBtnV1";
                lbl_user.Text = "<a  href=../Settings/UserMenu.aspx?UserId=" + SessionController.Users_.UserId + "&Flag=SU&user_role=OA>" + SessionController.Users_.UserName + " </a>";
                lbl_user.CssClass = "LogoutBtnV1";
            }
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

    //protected void chk_projects_Click(object sender, EventArgs e)
    //{
    //    lbl_search_entity.Text = chk_projects.Value;
    //}
    //protected void chk_facilities_Click(object sender, EventArgs e)
    //{
    //    lbl_search_entity.Text = chk_facilities.Value;
    //}
    //protected void chk_equipment_Click(object sender, EventArgs e)
    //{
    //    lbl_search_entity.Text = chk_equipment.Value;
    //}
    //protected void chk_locations_Click(object sender, EventArgs e)
    //{
    //    lbl_search_entity.Text = chk_locations.Value;
    //}
    protected void setScrollBar(object sender, EventArgs e)
    {
        try
        {
            // System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "Script", "setHeightValues();", true);
            if (!SessionController.Users_.UserRoleDescription.Equals("System Admin"))
            {
                // RadPanelBar1.FindItemByValue("Energy Modeling").ChildGroupHeight = 200 ;   //Convert.ToInt32(hffsetheightValue.Value);
                //RadPanelBar1.FindItemByValue("Energy Modeling").ChildGroupCssClass = "rpSlide" ;
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string srch_entity = string.Empty;
            //ContentPlaceHolder mpContentPlaceHolder;
            //mpContentPlaceHolder = (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
            bind_setting_panel();
            //if (contentCallEvent != null)
            //    contentCallEvent(this, EventArgs.Empty);
            if (chk_facilities.Checked)
            {
                srch_entity = srch_entity + "Facility";
            }
            Response.Redirect("~/App/Reports/SearchResultPage.aspx?srch_entity" + srch_entity);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btnSearch_ClickMaster(object sender, ImageClickEventArgs e)
    {
        try
        {
            string srch_entity = string.Empty;
            string srch_txt = string.Empty;
            //ContentPlaceHolder mpContentPlaceHolder;
            //mpContentPlaceHolder = (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
            //bind_setting_panel();
            //if (contentCallEvent != null)
            //    contentCallEvent(this, EventArgs.Empty);

            srch_txt = txtcriteriaMtr.Text;
            if (chk_facilities.Checked)
            {
                srch_entity = srch_entity + "Facilities" + ",";
            }
            if (chk_projects.Checked)
            {
                srch_entity = srch_entity + "Projects" + ",";
            }
            if (chk_locations.Checked)
            {
                srch_entity = srch_entity + "Locations" + ",";
            }
            if (chk_Component.Checked)
            {
                srch_entity = srch_entity + "Component" + ",";
            }

            //Server.Transfer("~/App/Reports/SearchResultPage.aspx?srch_entity=" + srch_entity + "&srch_txt=" + srch_txt);
            Response.Redirect("~/App/Reports/SearchResultPage.aspx?srch_entity=" + srch_entity + "&srch_txt=" + srch_txt, false);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    protected void btnHelp_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/app/Training.aspx", true);
    }

    protected void btnclick_Click(object sender, EventArgs e)
    {
        SessionController.Users_.DefaultPageSizeGrids = hfPageSize.Value;

    }

    protected void RadPanelBar1_ItemDataBound(object sender, RadPanelBarEventArgs e)
    {
        //RadPanelItem item = e.Item;
        //DataRowView dataRow = (DataRowView)e.Item.DataItem;
        //e.Item.
    }
}