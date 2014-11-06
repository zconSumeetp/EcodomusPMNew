using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EcoDomus.Session;
using Login;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using Facility;
using System.Threading;
using System.Globalization;
using Dashboard;
using Telerik.Web.UI;
//using SystemRoles;

public partial class App_FacilityList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            lblTodayDate.Text = DateTime.Now.Date.ToShortDateString();
            if (SessionController.Users_.UserId != null)
            {

                if (!IsPostBack)
                {
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "Name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against above specified column
                    rgFacility.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    GetUserClientDetail();
                    main_tbl.Visible = false;

                    if (Request.QueryString["Flag"].ToString().Equals("POP"))
                    {
                        bdy.Style.Add("background-image", "");
                    }
                    else
                    {
                        BindUserDetails();
                        main_tbl.Visible = true;
                    }
                }
            }
            else
            {
                redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            }
        }
        catch (Exception)
        {
            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }
    }


    protected override void InitializeCulture()
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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }


    public void BindUserDetails()
    {
        lbl_user_info.Text = "<b>User:&nbsp;</b>" +
        SessionController.Users_.UserName + "," + "&nbsp;"
        + SessionController.Users_.OrganizationName + "&nbsp;&nbsp;" + " " + "  <b> System Role:&nbsp;</b>" + SessionController.Users_.UserRoleDescription;
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
        }
        catch (Exception)
        {

        }
    }

    protected void GetUserClientDetail()
    {
        try
        {
            DataSet ds = new DataSet();
            DataSet ds_facility = new DataSet();
            LoginClient login_ctrl = new LoginClient();
            LoginModel login_mdl = new LoginModel();
            CryptoHelper crypt = new CryptoHelper();
            login_mdl.UserId = new Guid(SessionController.Users_.UserId);
            ds = login_ctrl.GetUserClientDetail(login_mdl);
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow myRow in ds.Tables[0].Rows)
                {
                    DataSet ds_temp = new DataSet();
                    ds_temp = GetFacilities(crypt.Encrypt(myRow["ConnectionString"].ToString()), new Guid(myRow["pk_user_id"].ToString()), new Guid(myRow["client_id"].ToString()), myRow["ClientName"].ToString(), myRow["role"].ToString());
                    ds_facility.Merge(ds_temp);
                }
                rgFacility.Visible = true;
                ViewState["TempDataset"] = ds_facility;
                rgFacility.DataSource = ds_facility;
                rgFacility.DataBind();
            }
            else
            {
                rgFacility.Visible = false;
                lbl_msg.Text = "No facility is assigned, Contact your Organization Admin";
            }
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "GetUserClientDetail :- " + ex.Message.ToString();

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
        Response.Redirect("~/App/LoginPM.aspx", false);
    }

    protected DataSet GetFacilities(string con_string, Guid pk_UserID, Guid client_id, string Client_name, string role)
    {
        FacilityClient facility_crtl = new FacilityClient();
        FacilityModel facility_mdl = new FacilityModel();
        DataSet ds = new DataSet();
        try
        {
            DataColumn column;
            facility_mdl.User_Id = pk_UserID;
            facility_mdl.Client_id = client_id;
            facility_mdl.Search_text_name = srch_txt_box.Text;
            facility_mdl.Role = role;

            ds = facility_crtl.GetUserFacility(facility_mdl, con_string);
            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "Client_Name";
            ds.Tables[0].Columns.Add(column);
            foreach (DataRow myRow in ds.Tables[0].Rows)
            {
                myRow["Client_Name"] = Client_name;
            }
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "GetFacilities :- " + ex.Message.ToString();
        }
        return ds;
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            GetUserClientDetail();
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "btnSearch_Click :- " + ex.Message.ToString();

        }
    }

    void ReBindDataSet()
    {
        DataSet ds = new DataSet();
        ds = (DataSet)ViewState["TempDataset"];
        rgFacility.DataSource = ds;
        rgFacility.DataBind();
    }


    protected void rgFacility_PageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {
            ReBindDataSet();
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "rgFacility_PageIndexChanged :- " + ex.Message.ToString();
        }

    }

    protected void rgFacility_OnSortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            ReBindDataSet();
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "rgFacility_OnSortCommand :- " + ex.Message.ToString();
        }
    }

    protected void rgFacility_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            ReBindDataSet();
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "rgFacility_PageSizeChanged :- " + ex.Message.ToString();
        }
    }


    protected void rgFacility_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == "Facility")
            {
                CryptoHelper crypto_obj = new CryptoHelper();
                SessionController.Users_.facilityID = (new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ID"].ToString())).ToString();
                SessionController.ConnectionString = crypto_obj.Encrypt(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["cons_string"].ToString());
                SessionController.Users_.facilityName = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Name"].ToString();
                SessionController.Users_.ClientID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["client_id"].ToString();
                SessionController.Users_.ClientName = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Client_Name"].ToString();
                
                //getting system role for setting access permissions to pages 
                //getsystemrole();
                if (Request.QueryString["Flag"].ToString().Equals("POP"))
                {

                    /*************************Insert into recent facility******************************************/
                    DataSet ds_ConnString = new DataSet();
                    //LoginModel obj_mdl = new LoginModel();
                    //LoginClient obj_crtl = new LoginClient();
                    //obj_mdl.UserId = new Guid(SessionController.Users_.UserId.ToString());
                    //ds_ConnString = obj_crtl.GetConnectionStringUser(obj_mdl);
                    //CryptoHelper crypto = new CryptoHelper();
                    //string Conn_string = crypto.Encrypt(ds_ConnString.Tables[0].Rows[0]["connection_string"].ToString());
                    LoginModel dm = new LoginModel();
                    LoginClient dc = new LoginClient();
                    dm.UserId  = new Guid(SessionController.Users_.UserId.ToString());
                    dm.ClientId  = new Guid(SessionController.Users_.ClientID.ToString());
                    dm.entityName = "Facility";
                    dm.Row_id = (SessionController.Users_.facilityID.ToString());
                    dc.InsertRecentUserData(dm);
                    /**********************************************************************************************/
                    
                    /*HiddenField hdnID = (HiddenField)Parent.Page.Master.FindControl("hffacilityId").;                    
                    hdnID.Value = SessionController.Users_.facilityID.ToString();*/
                   ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>window.parent.rd_facility_popup_Onclientclose('"+SessionController.Users_.facilityID.ToString()+"')</script>");
                    
                }
                else
                {
                    Response.Redirect("~/App/Reports/dashboard.aspx", false);
                }
            }
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "rgFacility_ItemCommand :- " + ex.Message.ToString();
        }
    }

    //private void getsystemrole()
    //{

    //    if (SessionController.Users_.UserSystemRole == "OA")
    //    {
    //        SystemRolesModel SystemRolesModel = new SystemRolesModel();
    //        SystemRolesClient SystemRolesClient = new SystemRoles.SystemRolesClient();
    //        SystemRolesModel.ClientId = new Guid(SessionController.Users_.ClientID);
    //        SystemRolesModel.Organization_id = new Guid(SessionController.Users_.OrganizationID);
    //        SystemRolesModel.Systemrole = SessionController.Users_.UserSystemRole;
    //        SystemRolesModel.UserId = new Guid(SessionController.Users_.UserId);

    //        DataSet ds_systemrole = SystemRolesClient.Getrolesbyuser(SystemRolesModel, SessionController.ConnectionString);
    //        if (ds_systemrole.Tables.Count > 0)
    //        {
    //            SessionController.Users_.SystemRoleAccess = ds_systemrole.Tables[0].Rows[0]["Role"].ToString();
    //        }
    //    }
    //    else
    //    {
    //        SessionController.Users_.SystemRoleAccess = SessionController.Users_.UserSystemRole;
    //    }
        

    //}
    public void redirect_page(string url)
    {
        if (Request.QueryString["Flag"].ToString().Equals("POP"))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>close_Window('Error, try again to login again.');</script>");
        }
        else
        {
            Response.Redirect(url, false);
        }
    }
}