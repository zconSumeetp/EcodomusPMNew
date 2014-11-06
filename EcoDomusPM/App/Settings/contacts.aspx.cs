
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using System.Net.Mail;
using Login;
using Client;
using EcoDomus.Mail;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using Contact;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;

public partial class App_Settings_contacts : System.Web.UI.Page
{

    CryptoHelper crypto = new CryptoHelper();
    string encry_value = "";
    string encry_client_id = "";
    Guid client_id;
    Guid org_of_otherOA;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                    
                }
                else
                {
                    checkOtherOA();
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "username";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgAssignedUser.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    GridSortExpression sortExpr1 = new GridSortExpression();
                    sortExpr1.FieldName = "Username";
                    sortExpr1.SortOrder = GridSortOrder.Ascending;
                    rgAssignContacts.MasterTableView.SortExpressions.AddSortExpression(sortExpr1);
                    bindUnassignContact();
                    bindAssignedContact();
                    Bind_ProjectRoles();
                }
                hfTypePMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);
            }

        }
        catch (Exception ex)
        {
            throw ex;
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

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

    protected void btnAssign_Click(Object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU" || SessionController.Users_.UserSystemRole == "LU")
            {

                //lblError.Text = "You do not have permissions to Assign the User.";
            }
            else
            {
                //lblError.Text = "";
                string UserID = ((System.Web.UI.WebControls.Button)(sender)).CommandArgument.ToString();
                ContactClient ctrl = new ContactClient();
                ContactModel con_model = new ContactModel();
                if (SessionController.Users_.ProjectId.ToString() == Guid.Empty.ToString())
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "open_space_popup();", true);
                }
                else
                {
                    con_model.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                    con_model.Project_role_id = Guid.Empty;
                    con_model.Created_by = new Guid(SessionController.Users_.UserId);
                    con_model.User_id = new Guid(UserID);
                    con_model.Client_id = new Guid(SessionController.Users_.ClientID);
                    ctrl.proc_insert_users_project(con_model, SessionController.ConnectionString.ToString());
                    bindUnassignContact();
                    bindAssignedContact();
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnRemove_Click(Object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            //lblError.Text = "";
            string user_id = (SessionController.Users_.UserId).ToString();
            string pk_user_project_id = ((System.Web.UI.WebControls.ImageButton)(sender)).CommandArgument.ToString();
            ContactClient ctrl = new ContactClient();
            ContactModel con_model = new ContactModel();
            con_model.User_project_id = new Guid(pk_user_project_id);
            con_model.Project_id = new Guid(SessionController.Users_.ProjectId);
             ds = ctrl.proc_delete_users_project(con_model, SessionController.ConnectionString.ToString());
            
            bindUnassignContact();
            bindAssignedContact();

            if (ds.Tables.Count > 0)
            {

                if (ds.Tables[0].Rows[0]["User_ID"] != null)
                {
                    if (ds.Tables[0].Rows[0]["User_ID"].ToString() == user_id)
                    {
                        SessionController.Users_.ProjectId = null;
                        SessionController.Users_.ProjectName = null;
                        Response.Redirect("~\\App\\Reports\\Dashboard_PM.aspx");
                    }
                }
            }
            //Response.Redirect("~\\App\\Settings\\contacts.aspx.cs");

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //protected void btn_Click(object sender, EventArgs e)
    //{

    //    try
    //    {
    //        foreach (GridDataItem gridrow in rgAssignedUser.MasterTableView.Items)  // check weather user checked any text box or not 
    //        {
    //            CheckBox chk = (CheckBox)gridrow.FindControl("chkSelect");

    //            if (chk.Checked == true)
    //            {
    //                string receiver_organization_id = gridrow["pk_organization_id"].Text.ToString();
    //                string receiver_user_id = gridrow["user_id"].Text.ToString();
    //                string receiver_email_id = gridrow["email_address"].Text.ToString();
    //                string receiver_user_name = gridrow["username"].Text.ToString();

    //                ClientOrganization.ClientOrganizationClient OrganizationClient = new ClientOrganization.ClientOrganizationClient();
    //                ClientOrganization.ClientOrganizationModel OrganizationModel = new ClientOrganization.ClientOrganizationModel();

    //                //string receiver_organization_id = ((System.Web.UI.WebControls.Button)(sender)).CommandArgument.ToString();
    //                string strClientID = SessionController.Users_.ClientID;
    //                string Organization_Id = SessionController.Users_.OrganizationID;
    //                string User_ID = SessionController.Users_.UserId;
    //                string User_Name = SessionController.Users_.UserName;
    //                string Organization_Name = SessionController.Users_.OrganizationName;
    //                string Project_Name = SessionController.Users_.ProjectName;
    //                OrganizationModel.Organization_Id = new Guid(Organization_Id);
    //                OrganizationModel.User_Id = new Guid(User_ID);

    //                // DataSet ds_Towhome = new DataSet();
    //                DataSet ds_sender = new DataSet();

    //                //ds_Towhome = OrganizationClient.GetReceiverContactInformationForEmail(OrganizationModel, SessionController.ConnectionString);

    //                OrganizationModel.User_Id = new Guid(User_ID);//SessionController.Users_.UserId.ToString()
    //                ds_sender = OrganizationClient.GetSenderContactInformationForEmail(OrganizationModel, SessionController.ConnectionString);
    //                //string towhomeuserid = ds_Towhome.Tables[0].Rows[0]["userId"].ToString();
    //                encry_value = crypto.Encrypt(receiver_organization_id).Replace("+", "!Plus!").Replace("#", "!Hash!").Replace("&", "!And!");
    //                encry_client_id = crypto.Encrypt(strClientID).Replace("+", "!Plus!").Replace("#", "!Hash!").Replace("&", "!And!");

    //                string fromaddress = ds_sender.Tables[0].Rows[0]["sender_email"].ToString();
    //                string toaddress = receiver_email_id;
    //                string subject = "Notification of project role assigned by '" + Organization_Name + "'";//+ ds_Towhome.Tables[0].Rows[0]["ToWhome_name"].ToString() +"'";
    //                string messagebody;

    //                messagebody = "Dear " + receiver_user_name + ", <BR/><BR/>" +
    //                   "You are assigned  role of 'Organization admin' for project  '" + Project_Name + "', under " +
    //                   "the EcoDomus PM application  by  " + User_Name + "." +
    //                   "<BR />" + "For any queries you can contact " + User_Name + " at " + fromaddress + "." +
    //                   "&nbsp;You can also visit our website by click on this link <a href='" + Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("Settings")) + "LoginPM.aspx" + " ' target='_blank'>Ecodomus PM Aplication</a> <br />" +
    //                   "<BR><BR>Sincerely,<br/>" +
    //                      User_Name + "<br/>" + Organization_Name + "<br/>";


    //                EcoDomus.Mail.Control.MailControl mailControl = new EcoDomus.Mail.Control.MailControl();
    //                EcoDomus.Mail.Model.MailModel mailModel = new EcoDomus.Mail.Model.MailModel();


    //                mailModel.Sender = fromaddress;
    //                mailModel.Receiver = toaddress;
    //                mailModel.Subject = subject;
    //                mailModel.MessageBody = messagebody;
    //                mailModel.IsBodyHtml = true;
    //                string result = mailControl.SendMail(mailModel);

    //                lbl_msg.Text = result;

    //                //ClientOrganization.ClientOrganizationClient OrganizationClient1 = new ClientOrganization.ClientOrganizationClient();
    //                //ClientOrganization.ClientOrganizationModel OrganizationModel1 = new ClientOrganization.ClientOrganizationModel();
    //                //OrganizationModel1.ClientId = new Guid(SessionController.Users_.ClientID);
    //                //OrganizationModel1.Organization_Id = new Guid(Organization_Id);
    //                //OrganizationModel1.Request_status = "P";
    //                //OrganizationModel1.User_Id = new Guid(SessionController.Users_.UserId);
    //                // OrganizationClient1.InsertintoClientOrganizationLinkup(OrganizationModel1, SessionController.ConnectionString);
    //                //errorlable.Text = result;
    //                // Bind_rgResources();
    //            }
    //        }
    //        bindUnassignContact();
    //        bindAssignedContact();
    //    }
    //    catch (Exception ex)
    //    {
    //        lbl_msg.Text = ex.Message.ToString();
    //    }
    //}



    protected void btn_Click(object sender, EventArgs e)
    {
        try
        {
            if (rgAssignedUser.SelectedItems.Count > 0)
            {
                for (int i = 0; i < rgAssignedUser.SelectedItems.Count; i++)
                {
                    string receiver_organization_id = rgAssignedUser.SelectedItems[i].Cells[11].Text.ToString();
                    string receiver_user_id = rgAssignedUser.SelectedItems[i].Cells[12].Text.ToString();
                    string receiver_email_id = rgAssignedUser.SelectedItems[i].Cells[8].Text.ToString();
                    string receiver_user_name = rgAssignedUser.SelectedItems[i].Cells[5].Text.ToString();

                    ClientOrganization.ClientOrganizationClient OrganizationClient = new ClientOrganization.ClientOrganizationClient();
                    ClientOrganization.ClientOrganizationModel OrganizationModel = new ClientOrganization.ClientOrganizationModel();


                    string strClientID = SessionController.Users_.ClientID;
                    string Organization_Id = SessionController.Users_.OrganizationID;
                    string User_ID = SessionController.Users_.UserId;
                    string User_Name = SessionController.Users_.UserName;
                    string Organization_Name = SessionController.Users_.OrganizationName;
                    string Project_Name = SessionController.Users_.ProjectName;
                    OrganizationModel.Organization_Id = new Guid(Organization_Id);
                    OrganizationModel.User_Id = new Guid(User_ID);


                    DataSet ds_sender = new DataSet();

                    //ds_Towhome = OrganizationClient.GetReceiverContactInformationForEmail(OrganizationModel, SessionController.ConnectionString);

                    OrganizationModel.User_Id = new Guid(User_ID);//SessionController.Users_.UserId.ToString()
                    ds_sender = OrganizationClient.GetSenderContactInformationForEmail(OrganizationModel, SessionController.ConnectionString);
                    //string towhomeuserid = ds_Towhome.Tables[0].Rows[0]["userId"].ToString();
                    encry_value = crypto.Encrypt(receiver_organization_id).Replace("+", "!Plus!").Replace("#", "!Hash!").Replace("&", "!And!");
                    encry_client_id = crypto.Encrypt(strClientID).Replace("+", "!Plus!").Replace("#", "!Hash!").Replace("&", "!And!");

                    string fromaddress = ds_sender.Tables[0].Rows[0]["sender_email"].ToString();
                    string toaddress = receiver_email_id;
                    string subject = "Notification of project role assigned by '" + Organization_Name + "'";//+ ds_Towhome.Tables[0].Rows[0]["ToWhome_name"].ToString() +"'";
                    string messagebody;

                    messagebody = "Dear " + receiver_user_name + ", <BR/><BR/>" +
                       "You are assigned  role of 'Organization admin' for project  '" + Project_Name + "', under " +
                       "the EcoDomus PM application  by  " + User_Name + "." +
                       "<BR />" + "For any queries you can contact " + User_Name + " at " + fromaddress + "." +
                       "&nbsp;You can also visit our website by click on this link <a href='" + Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("Settings")) + "LoginPM.aspx" + " ' target='_blank'>Ecodomus PM Aplication</a> <br />" +
                       "<BR><BR>Sincerely,<br/>" +
                          User_Name + "<br/>" + Organization_Name + "<br/>";


                    EcoDomus.Mail.Control.MailControl mailControl = new EcoDomus.Mail.Control.MailControl();
                    EcoDomus.Mail.Model.MailModel mailModel = new EcoDomus.Mail.Model.MailModel();


                    mailModel.Sender = fromaddress;
                    mailModel.Receiver = toaddress;
                    mailModel.Subject = subject;
                    mailModel.MessageBody = messagebody;
                    mailModel.IsBodyHtml = true;
                    string result = mailControl.SendMail(mailModel);

                    lbl_msg.Text = result;

                    //ClientOrganization.ClientOrganizationClient OrganizationClient1 = new ClientOrganization.ClientOrganizationClient();
                    //ClientOrganization.ClientOrganizationModel OrganizationModel1 = new ClientOrganization.ClientOrganizationModel();
                    //OrganizationModel1.ClientId = new Guid(SessionController.Users_.ClientID);
                    //OrganizationModel1.Organization_Id = new Guid(Organization_Id);
                    //OrganizationModel1.Request_status = "P";
                    //OrganizationModel1.User_Id = new Guid(SessionController.Users_.UserId);
                    // OrganizationClient1.InsertintoClientOrganizationLinkup(OrganizationModel1, SessionController.ConnectionString);
                    //errorlable.Text = result;
                    // Bind_rgResources();
                    //  }
                    //}
                }
            }
            bindUnassignContact();
            bindAssignedContact();
        }
        catch (Exception ex)
        {
            lbl_msg.Text = ex.Message.ToString();
        }
    }

    protected void Bind_ProjectRoles()
    {
        try
        {


            Roles.RolesClient RolesClient = new Roles.RolesClient();
            Roles.RolesModel RolesModel = new Roles.RolesModel();
            RolesModel.Fk_project_id = new Guid(SessionController.Users_.ProjectId);
            RolesModel.Role_Name = "";
            DataSet ds_roles = new DataSet();
            ds_roles = RolesClient.Get_project_roles(RolesModel, SessionController.ConnectionString);
            ddlProjectrole.DataTextField = "name";
            ddlProjectrole.DataValueField = "pk_project_role_id";
            ddlProjectrole.DataSource = ds_roles;
            ddlProjectrole.DataBind();

            DropDownList ddl = new DropDownList();
            ddl.Items.Add("select");
            ddl.Items[0].Text = "---Select---";
            ddl.Items[0].Value = Guid.Empty.ToString();
            ddlProjectrole.Items.Add(ddl.Items[0]);
            ddlProjectrole.SelectedValue = Guid.Empty.ToString();


        }

        catch (Exception ex)
        {
            ex.Message.ToString();
        }

    }

    protected void bindAssignedContact()
    {

        try
        {

            DataSet ds = new DataSet();
            ContactClient ctrl = new ContactClient();
            ContactModel con_model = new ContactModel();

            con_model.Client_id = new Guid(SessionController.Users_.ClientID.ToString());
            con_model.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
            ds = ctrl.proc_get_assigned_user_for_project(con_model, SessionController.ConnectionString.ToString());
            rgAssignedUser.DataSource = null;
            rgAssignedUser.DataSource = ds;
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    rgAssignedUser.DataBind();
                }
                else
                {
                    rgAssignedUser.DataSource = string.Empty;
                    rgAssignedUser.DataBind();
                }

            }


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void bindUnassignContact()
    {
        DataSet ds = new DataSet();
        ContactClient ctrl = new ContactClient();
        ContactModel con_model = new ContactModel();
        con_model.Client_id = new Guid(SessionController.Users_.ClientID.ToString());
        con_model.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
        con_model.Search_text = txtSearch.Text.ToString();
       
        // for other OA:- ----------------------------------------
        LoginModel lm = new LoginModel();
        LoginClient lc = new LoginClient();
        CryptoHelper crypt = new CryptoHelper();
        lm.UserId = new Guid(SessionController.Users_.UserId);
        ds = lc.GetConnectionStringUser(lm);
        org_of_otherOA = new Guid(ds.Tables[0].Rows[0]["pk_organization_id"].ToString());
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["is_primary_flag"].ToString() == "")
                {
                    con_model.User_id = new Guid(SessionController.Users_.UserId.ToString());
                    ds = ctrl.get_unassigned_users_for_other_OA(con_model, SessionController.ConnectionString.ToString());
                }
                else
                {
                    ds = ctrl.get_unassigned_users(con_model, SessionController.ConnectionString.ToString());
                }
            }
        }
        //----------------------------------------------------------
         
        rgAssignContacts.DataSource = null;
        rgAssignContacts.DataSource = ds;
        rgAssignContacts.DataBind();


    }

    public void checkOtherOA()  // To check whether user logged in is other OA.
    {
        
    }

    protected void rgAssignContacts_OnSortCommand(object source, GridSortCommandEventArgs e)
    {
        bindUnassignContact();
        //bindAssignedContact();
    }

    protected void rgAssignedUser_bind_Contact(object source, GridSortCommandEventArgs e)
    {
        //bindUnassignContact();
        bindAssignedContact();
    }

    protected void bind_Contact(object sender, EventArgs e)
    {

        bindUnassignContact();
        bindAssignedContact();

    }

    protected void btnAssignProjectContact_Click(object sender, EventArgs e)
    {
        string receiver_user_id = "";
        try
        {
            foreach (GridDataItem Gridrow in rgAssignedUser.MasterTableView.Items)
            {
                if (Gridrow.Selected == true)
                {
                    receiver_user_id = receiver_user_id + Gridrow["pk_user_project_id"].Text.ToString() + ",";
                }
            }

            receiver_user_id = receiver_user_id.Substring(0, receiver_user_id.Length - 1);
            Guid project_role_id = new Guid(ddlProjectrole.SelectedValue);
            Roles.RolesClient RolesClient = new Roles.RolesClient();
            Roles.RolesModel RolesModel = new Roles.RolesModel();
            RolesModel.Project_RoleId = new Guid(ddlProjectrole.SelectedValue);
            RolesModel.UserIds = receiver_user_id;
            RolesModel.User_Id = new Guid(SessionController.Users_.UserId);
            DataSet ds_roles = new DataSet();
            ds_roles = RolesClient.Assign_project_roles_user(RolesModel, SessionController.ConnectionString);
            bindUnassignContact();
            bindAssignedContact();
            Bind_ProjectRoles();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void rgAssignedUser_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {        
            DataSet dsusers = new DataSet();
            ContactClient ctrl = new ContactClient();
            ContactModel con_model = new ContactModel();

            con_model.Client_id = new Guid(SessionController.Users_.ClientID.ToString());
            con_model.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
            dsusers = ctrl.proc_get_assigned_user_for_project(con_model, SessionController.ConnectionString.ToString());
           
            //string LaborValue = e.Item.Cells[5].Text;
            //LaborValue = LaborValue.Replace("!span", "<span").Replace("span!", "</span>").Replace("@$", ">").Replace("!hash!", "#");
            //e.Item.Cells[5].Text = LaborValue;
            DataSet ds = new DataSet();
            GridDataItem item = (GridDataItem)e.Item;
            string strflag = item["pk_organization_id"].Text.ToString();

            LoginModel lm = new LoginModel();
            LoginClient lc = new LoginClient();
            CryptoHelper crypt = new CryptoHelper();
            lm.UserId = new Guid(SessionController.Users_.UserId);
            ds = lc.GetConnectionStringUser(lm);
            org_of_otherOA = new Guid(ds.Tables[0].Rows[0]["pk_organization_id"].ToString());
        
            if (ds.Tables[0].Rows[0]["is_primary_flag"].ToString() == "")
            {
                if (new Guid(strflag) != org_of_otherOA)
                    {
                        e.Item.FindControl("btnRemove").Visible = false;
                    }                
            }
       
        }
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            //bindUnassignContact();
            //bindAssignedContact();

            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    SetPermissions();
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='BIM Server'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Contacts")
                {
                    SetPermissionToControl(dr_profile);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SetPermissionToControl(DataRow dr)
    {
        Permissions objPermission = new Permissions();
        string delete_permission = dr["delete_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();

        if (edit_permission == "N")
        {
            foreach (GridDataItem item in rgAssignedUser.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("btnRemove");
                imgbtnDelete.Enabled = false;
            }

            foreach (GridDataItem item in rgAssignContacts.MasterTableView.Items)
            {
                Button btn = (Button)item.FindControl("btnAssign");
                btn.Enabled = false;
            }

            btnAssignProjectContact.Enabled = false;
            Button1.Enabled = false;
            Button2.Enabled = false;
        }
        else
        {
            foreach (GridDataItem item in rgAssignedUser.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("btnRemove");
                imgbtnDelete.Enabled = true;
            }

            foreach (GridDataItem item in rgAssignContacts.MasterTableView.Items)
            {
                Button btn = (Button)item.FindControl("btnAssign");
                btn.Enabled = true;
            }
            btnAssignProjectContact.Enabled = true;
            Button1.Enabled = true;
            Button2.Enabled = true;
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindUnassignContact();
    }
}