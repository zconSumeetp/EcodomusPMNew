using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using User;
using System.Data;
using Login;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Session;
using Facility;
using Telerik.Web.UI;
using Locations;
using System.Threading;
using System.Globalization;


public partial class App_Settings_UserFacility : System.Web.UI.Page
{
    #region Global Variable Declaration
    #endregion

    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
       
        txtSearch.Attributes.Add("onKeyPress", "doClick('" +btnSearch.ClientID + "',event)");
        if (!IsPostBack)
        {
            hfUserRole.Value = Request.QueryString["user_role"].ToString();
            if (Request.QueryString["UserId"] != null)
            {
               hfOrganizatioPrimaryUserid.Value= SessionController.Users_.UserId.ToString();
            }
            
            if (hfUserRole.Value.Equals("SA") || (SessionController.ConnectionString==null))
            {
                div_btnAssignFacility.Style.Add("Display", "none");
                GetUserClientDetail();
            }
            
            else
            {
                if (hfUserRole.Value.ToString().Equals("OA"))
                {
                    div_btnAssignFacility.Style.Add("Display", "none");
                    hfOrganizatioPrimaryUserid.Value = SessionController.Users_.UserId.ToString();
                }
               // hfOrganizatioPrimaryUserid.Value = Request.QueryString["UserId"].ToString();
                if (!hfOrganizatioPrimaryUserid.Value.ToString().Equals(""))
                {
                    
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "Name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgUserFacility.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    GetFacilities();
                }
                
            }
        }
        
    }
    #endregion

    #region My Methods

    protected override void InitializeCulture()
    {
        string culture = Session["Culture"].ToString();
        if (culture == null)
        {
            culture = "en-US";
        }
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
    }
    protected void GetFacilities()
    {
        FacilityClient facility_crtl = new FacilityClient();
        FacilityModel facility_mdl = new FacilityModel();
        DataSet ds = new DataSet();
        try
        {
            facility_mdl.User_Id = new Guid(hfOrganizatioPrimaryUserid.Value.ToString());
            facility_mdl.Client_id = Guid.Empty;
            facility_mdl.Search_text_name = txtSearch.Text.ToString();
            facility_mdl.Role = hfUserRole.Value.ToString();
            ds = facility_crtl.GetUserFacility(facility_mdl, SessionController.ConnectionString.ToString());
                rgUserFacility.DataSource = ds;
                rgUserFacility.DataBind();
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "GetFacilities :- " + ex.Message.ToString();
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
            //added on 23Feb,2012---------
            if (Request.QueryString["UserId"].ToString() != "")
            {
                login_mdl.UserId = new Guid(Request.QueryString["UserId"].ToString());
            }
            //----------------------------
            ds = login_ctrl.GetUserClientDetail(login_mdl);
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow myRow in ds.Tables[0].Rows)
                {
                    DataSet ds_temp = new DataSet();
                    ds_temp = GetFacilities(crypt.Encrypt(myRow["ConnectionString"].ToString()), new Guid(myRow["pk_user_id"].ToString()), new Guid(myRow["client_id"].ToString()), myRow["ClientName"].ToString(), myRow["role"].ToString());
                    ds_facility.Merge(ds_temp);
                }
                rgUserFacility.Visible = true;
                ViewState["TempDataset"] = ds_facility;
                rgUserFacility.DataSource = ds_facility;
                rgUserFacility.DataBind();
            }
            else
            {
                rgUserFacility.Visible = false;
                lbl_msg.Text = "No facility is assigned, Contact your Organization Admin";
            }

        }
        catch (Exception ex)
        {
            lbl_msg.Text = "GetUserClientDetail :- " + ex.Message.ToString();

        }
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
            facility_mdl.Role = role;
            facility_mdl.Search_text_name = txtSearch.Text;
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

    #endregion

    #region Event Handlers
    protected void rgUserFacility_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        CryptoHelper crypt = new CryptoHelper();
        if (e.CommandName == "EditFacility")
        {
            SessionController.Users_.facilityID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ID"].ToString();
            SessionController.ConnectionString =crypt.Encrypt(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["cons_string"].ToString());
            SessionController.Users_.IsFacility = "yes";
            DataSet ds_facilityname = new DataSet();
            LocationsModel loc_objmdl = new LocationsModel();
            LocationsClient loc_objcrtl = new LocationsClient();
            Guid facilityid = new Guid(SessionController.Users_.facilityID);
            if (SessionController.Users_.facilityID != null)
            {
                 Response.Redirect("~\\App\\Locations\\FacilityProfile.aspx?FacilityId=" + facilityid);
             }
        }
        if (e.CommandName == "deletefacility")
        {
            if (hfUserRole.Value != "OA")
            {
                FacilityClient ctrl = new FacilityClient();
                FacilityModel mdl = new FacilityModel();
                mdl.User_Id =new Guid(hfOrganizatioPrimaryUserid.Value);
                mdl.Facility_id =new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ID"].ToString());
                
                ctrl.Delete_Facility_Assigned(mdl,SessionController.ConnectionString.ToString());


                hfUserRole.Value = Request.QueryString["user_role"].ToString();
                if (Request.QueryString["UserId"] != null)
                {
                    hfOrganizatioPrimaryUserid.Value = Request.QueryString["UserId"].ToString();
                }
                if (hfUserRole.Value.Equals("SA") || (SessionController.ConnectionString == null))
                {
                    div_btnAssignFacility.Style.Add("Display", "none");
                    GetUserClientDetail();
                }
                else
                {
                    if (hfUserRole.Value.ToString().Equals("OA"))
                    {
                        div_btnAssignFacility.Style.Add("Display", "none");
                    }
                   // hfOrganizatioPrimaryUserid.Value = Request.QueryString["UserId"].ToString();
                    hfOrganizatioPrimaryUserid.Value = SessionController.Users_.UserId.ToString();
                    if (!hfOrganizatioPrimaryUserid.Value.ToString().Equals(""))
                    {
                        GetFacilities();
                    }
                }
            }
        }
    }

    protected void rgUserFacility_SortCommand(object source, GridSortCommandEventArgs e)
    {
        hfUserRole.Value = Request.QueryString["user_role"].ToString();
        if (Request.QueryString["UserId"] != null)
        {
            hfOrganizatioPrimaryUserid.Value = Request.QueryString["UserId"].ToString();
        }

        if (hfUserRole.Value.Equals("SA") || (SessionController.ConnectionString == null))
        {
            div_btnAssignFacility.Style.Add("Display", "none");
            GetUserClientDetail();
        }

        else
        {
            if (hfUserRole.Value.ToString().Equals("OA"))
            {
                div_btnAssignFacility.Style.Add("Display", "none");
            }
            hfOrganizatioPrimaryUserid.Value = Request.QueryString["UserId"].ToString();
            if (!hfOrganizatioPrimaryUserid.Value.ToString().Equals(""))
            {
                GetFacilities();
            }
        }
     //   GetUserClientDetail();
    }
    protected void rgUserFacility_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        hfUserRole.Value = Request.QueryString["user_role"].ToString();
        if (Request.QueryString["UserId"] != null)
        {
            hfOrganizatioPrimaryUserid.Value = Request.QueryString["UserId"].ToString();
        }

        if (hfUserRole.Value.Equals("SA") || (SessionController.ConnectionString == null))
        {
            div_btnAssignFacility.Style.Add("Display", "none");
            GetUserClientDetail();
        }

        else
        {
            if (hfUserRole.Value.ToString().Equals("OA"))
            {
                div_btnAssignFacility.Style.Add("Display", "none");
            }
            hfOrganizatioPrimaryUserid.Value = Request.QueryString["UserId"].ToString();
            if (!hfOrganizatioPrimaryUserid.Value.ToString().Equals(""))
            {
                GetFacilities();
            }
        }
    }
    protected void rgUserFacility_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        hfUserRole.Value = Request.QueryString["user_role"].ToString();
        if (Request.QueryString["UserId"] != null)
        {
            hfOrganizatioPrimaryUserid.Value = Request.QueryString["UserId"].ToString();
        }

        if (hfUserRole.Value.Equals("SA") || (SessionController.ConnectionString == null))
        {
            div_btnAssignFacility.Style.Add("Display", "none");
            GetUserClientDetail();
        }

        else
        {
            if (hfUserRole.Value.ToString().Equals("OA"))
            {
                div_btnAssignFacility.Style.Add("Display", "none");
            }
            hfOrganizatioPrimaryUserid.Value = Request.QueryString["UserId"].ToString();
            if (!hfOrganizatioPrimaryUserid.Value.ToString().Equals(""))
            {
                GetFacilities();
            }
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        hfUserRole.Value = Request.QueryString["user_role"].ToString();
        if (Request.QueryString["UserId"] != null)
        {
            hfOrganizatioPrimaryUserid.Value = Request.QueryString["UserId"].ToString();
        }

        if (hfUserRole.Value.Equals("SA") || (SessionController.ConnectionString == null))
        {
            div_btnAssignFacility.Style.Add("Display", "none");
            GetUserClientDetail();
        }

        else
        {
            if (hfUserRole.Value.ToString().Equals("OA"))
            {
                div_btnAssignFacility.Style.Add("Display", "none");
            }
            hfOrganizatioPrimaryUserid.Value = Request.QueryString["UserId"].ToString();
            if (!hfOrganizatioPrimaryUserid.Value.ToString().Equals(""))
            {
                GetFacilities();
            }
        }
    }
    
    //when clicked on Assign after selecting facilities
    protected void btnFacilityAssigned_Click(object sender, EventArgs e) 
    {
        //get the user details for mailing purpose
        UserClient user_ctrl = new UserClient();
        UserModel user_mdl = new UserModel();
        user_mdl.UserId = new Guid(SessionController.Users_.UserId.ToString());
        user_mdl.OrganizatioPrimaryUserId = new Guid(hfOrganizatioPrimaryUserid.Value.ToString());
        if (Request.QueryString.ToString() != "")
        {
            user_mdl.OrganizationId = new Guid(Request.QueryString["organization_id"].ToString());
        }
        else 
        {
            user_mdl.OrganizationId = new Guid(SessionController.Users_.OrganizationID.ToString());
        }
        DataSet ds = user_ctrl.getUserAddress(user_mdl);
        string fromaddress = ds.Tables[0].Rows[0]["from_address"].ToString();
        string toaddress = ds.Tables[1].Rows[0]["to_address"].ToString();
        string subject = "Assigned Facility '" + hfAssignedFacilityListNames.Value + "'to the User'" + ds.Tables[1].Rows[0]["name"].ToString() + "'";
        string messagebody;
        messagebody = "Dear " + ds.Tables[1].Rows[0]["name"].ToString() + ", <BR/><BR/>" +
           "The facility " + hfAssignedFacilityListNames.Value + ", has been assigned to you. <br/><br/>"+
           "Sincerely,<br/>" +
           ds.Tables[0].Rows[0]["sender_name"].ToString() + "<br/>" +
           ds.Tables[0].Rows[0]["sender_organization_name"].ToString() + "<br/>" +
           ds.Tables[0].Rows[0]["sender_phone"].ToString();

        EcoDomus.Mail.Control.MailControl mailControl = new EcoDomus.Mail.Control.MailControl();
        EcoDomus.Mail.Model.MailModel mailModel = new EcoDomus.Mail.Model.MailModel();
        mailModel.Sender = fromaddress;
        mailModel.Receiver = toaddress;
        mailModel.Subject = subject;
        mailModel.MessageBody = messagebody;
        mailModel.IsBodyHtml = true;
        string result = mailControl.SendMail(mailModel);
        lbl_msg.Text = result;    
        
        if (result.Equals("Mail sent successfully"))
        {
            //make the entries in table to assign user facilities
            string str_conn=SessionController.ConnectionString.ToString();
            FacilityClient ctrl=new FacilityClient();
            FacilityModel mdl=new FacilityModel();
            mdl.Client_id =new Guid(SessionController.Users_.ClientID.ToString());
            if (Request.QueryString["UserId"].ToString() != "")
            {
                mdl.User_Id = new Guid(Request.QueryString["UserId"].ToString());
            }
            else 
            {
                mdl.User_Id = new Guid(SessionController.Users_.UserId.ToString());
            }
            mdl.Facility_Ids = hfAssignedFacilityListIds.Value.ToString();
            ctrl.Assign_user_facility(mdl,str_conn);

            GetFacilities();
        }
    }
    #endregion
}