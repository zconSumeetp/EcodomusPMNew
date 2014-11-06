using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
//using Dashboard;
using Login;
using Telerik.Web.UI;
using EcoDomus.Session;
using Client;
//using System.Web.Mail;
using System.Net.Mail;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Mail;
using System.Threading;
using System.Globalization;

   
public partial class App_Settings_AddNewOrganization : System.Web.UI.Page
{

    CryptoHelper crypto = new CryptoHelper();
    string encry_value = "";
    string encry_client_id = "";
    Guid client_id;
    string tempPageSize = "";
    bool flag = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtSearch.Attributes.Add("onKeyPress", "doClick('" + btnSearch.ClientID + "',event)");
            if (SessionController.Users_.UserId != null)
            {
                string value;
                if (!IsPostBack)
                {
                     value = "<script language='javascript'>sitemap();</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
                   
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "OrganizationName";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgResources.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    BindOrganizationTypes();
                    hfNewClientOrgaPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    Bind_rgResources();
                  
                }
                   value = "<script language='javascript'>sitemap();</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
            }
            else
            {
                Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            }
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "Page_Load:- " + ex.Message.ToString();

        }  
    }
    //To bind all assigned,non assigned,denied,not allowed organizations
    private void Bind_rgResources()
    {
        DataSet ds = new DataSet();
        ClientOrganization.ClientOrganizationClient OrganizationClient = new ClientOrganization.ClientOrganizationClient();
        ClientOrganization.ClientOrganizationModel OrganizationModel = new ClientOrganization.ClientOrganizationModel();


        OrganizationModel.ClientId = new Guid(SessionController.Users_.ClientID);
        OrganizationModel.Txt_Search = txtSearch.Text;
        OrganizationModel.Organization_Id = new Guid(ddlOrgType.SelectedValue.ToString());
        OrganizationModel.User_Id = new Guid(SessionController.Users_.UserId);
        OrganizationModel.Project_id = new Guid(SessionController.Users_.ProjectId);
        ds = OrganizationClient.GetunassignedOrganizations(OrganizationModel,SessionController.ConnectionString);

        rgResources.AllowCustomPaging = true;
        if (tempPageSize != "")
            rgResources.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
        rgResources.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
        if (ds.Tables.Count > 0)
        {
            rgResources.DataSource = ds;
            rgResources.DataBind();
        }

        else
        {
            rgResources.DataSource = string.Empty;
            rgResources.DataBind();
        }

    }

    protected void ddlOrgType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            Bind_rgResources();
        }
        catch (Exception ex)
        {
            Response.Write("Page_Load :-" + ex.Message.ToString());
        }

    }
    //To edit organization
    protected void OnItemCommand_rgResources(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "EditOrganization")
        {

            string Organization_Id, Organization_name;
            Organization_Id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["organization_id"].ToString();
            Organization_name = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["OrganizationName"].ToString();
            Response.Redirect("~/App/Settings/SettingsMenu.aspx?organization_id=" + Organization_Id.ToString() + "&Organization_name=" + Organization_name.ToString() + "&IsfromClient=Y", false);
                                                                           
            //Response.Redirect("OrganizationProfile.aspx");
        }
    }

    protected void rgAddResources_ItemDataBound1(object sender, Telerik.Web.UI.GridItemEventArgs e)
     {
        try
        {
            //string  request_status ="R";
            if (e.Item is Telerik.Web.UI.GridDataItem)
            {
                Button btn = e.Item.FindControl("btn") as Button;
                Label lbl = e.Item.FindControl("lblColor") as Label;
                Label lblPC = e.Item.FindControl("Email_Address") as Label;
                btn.CssClass = lbl.Text.ToString();
                btn.CssClass = lbl.Text.ToString();

                if (Convert.ToString(lblPC.Text) == "n/a" || Convert.ToString(lblPC.Text) == "N/A" || Convert.ToString(lblPC.Text) == "")
                {
                    btn.Text = "Not Allowed";
                    btn.Enabled = false;
                    btn.CssClass = "btnRed";
                }
                else
                {
                    if (lbl.Text.ToString() == "btnYellow")
                    {
                        btn.Text = "Resend Request";
                    }
                    else if (lbl.Text.ToString() == "btnGreen")
                    {
                        btn.Text = "Assigned";
                        btn.Enabled = false;
                    }
                    else if (lbl.Text.ToString() == "btnBlue")
                    {
                        btn.Text = "Request Sent";
                        btn.Enabled = true;
                    }
                    else if (lbl.Text.ToString() == "btnRed")
                    {
                        btn.Text = "Denied";
                        btn.Enabled = false;
                    }
                    else
                    {
                        btn.Text = "Send Request";
                        btn.Enabled = true;
                        btn.CssClass = "btnBlue";
                    
                    }                    

                }

            }


            if (e.Item is GridPagerItem)
            {

                RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                cb.Items.Sort(new PagerRadComboBoxItemComparer());
                if (tempPageSize != "")
                {
                    cb.Items.FindItemByValue(tempPageSize).Selected = true;
                }


            }

            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rgResources.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                    if (column is GridButtonColumn)
                    {
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                    if (column is GridTemplateColumn)
                    {
                        ////if the sorting feature of the grid is enabled
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                }
            }

            if (e.Item is GridDataItem)
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                foreach (GridColumn column in rgResources.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "OrganizationName")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2].ToString());
                        }
                        else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName != "Email" && column.UniqueName != "enabled")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                        }
                        else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "email")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[4].ToString());
                        }
                        else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "status")
                        {
                            string status = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[9].ToString());
                            if (status.ToString().Equals("btnYellow"))
                            {
                                gridItem[column.UniqueName].ToolTip = "Resend Request";
                               
                            }
                            else if (status.ToString().Equals("btnGreen"))
                            {
                              gridItem[column.UniqueName].ToolTip = "Assigned";
                               
                            }
                            else if (status.ToString().Equals("btnBlue"))
                            {
                                gridItem[column.UniqueName].ToolTip = "Request Sent";
                               
                            }
                            else if (status.ToString().Equals("btnRed"))
                            {
                                gridItem[column.UniqueName].ToolTip = "Denied";
                               
                            }
                            else if (status.ToString().Equals("") || status.ToString().ToUpper().Equals("N/A"))
                            {
                                gridItem[column.UniqueName].ToolTip = "Not allowed";
                            }
                            else
                            {
                                gridItem[column.UniqueName].ToolTip = "Send Request";
                            }      

                        }
                    }

                    else if (column is GridButtonColumn)
                    {

                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "name")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[1].ToString());
                       
                    }

                    else if (column is GridTemplateColumn)
                    {

                       if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "email")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[4].ToString());
                        }
                       if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "status")
                       {
                           string status = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[9].ToString());
                           if (status.ToString().Equals("btnYellow"))
                           {
                               gridItem[column.UniqueName].ToolTip = "Resend Request";

                           }
                           else if (status.ToString().Equals("btnGreen"))
                           {
                               gridItem[column.UniqueName].ToolTip = "Assigned";

                           }
                           else if (status.ToString().Equals("btnBlue"))
                           {
                               gridItem[column.UniqueName].ToolTip = "Request Sent";

                           }
                           else if (status.ToString().Equals("btnRed"))
                           {
                               gridItem[column.UniqueName].ToolTip = "Denied";

                           }
                           else if (status.ToString().Equals("")|| status.ToString().ToUpper().Equals("N/A"))
                           {
                               gridItem[column.UniqueName].ToolTip = "Not allowed";
                           }
                           else
                           {
                               gridItem[column.UniqueName].ToolTip = "Send Request";

                           }      
                           
                       }
                    }
                }
            }

        }
        catch (Exception ex)
        {
            Response.Write("rgAddResources_ItemDataBound1 :-" + ex.Message.ToString());
        }

    }

    //To bind all organization types
    private void BindOrganizationTypes()
    {
        try
        {
            DataSet ds = new DataSet();
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            ds = obj_ctrl.GetOrganizationType();
            ddlOrgType.DataTextField = "name";
            ddlOrgType.DataValueField = "organization_type_id";
            ddlOrgType.DataSource = ds;
            ddlOrgType.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
            //lblMessage.Text = "BindOrganizationTypes:" + ex.Message.ToString();
        }
    }

    //To send the mail to organizations primary contact 
    protected void btn_Click(object sender, EventArgs e)
    {
        try
        {

            ClientOrganization.ClientOrganizationClient OrganizationClient = new ClientOrganization.ClientOrganizationClient();
            ClientOrganization.ClientOrganizationModel OrganizationModel = new ClientOrganization.ClientOrganizationModel();

            string strOrgID = ((System.Web.UI.WebControls.Button)(sender)).CommandArgument.ToString();
            string strClientID = SessionController.Users_.ClientID;
            OrganizationModel.Organization_Id = new Guid(strOrgID);

            DataSet ds_Towhome = new DataSet();
            DataSet ds_sender = new DataSet();

            ds_Towhome = OrganizationClient.GetPrimaryContactInformationForEmail(OrganizationModel, SessionController.ConnectionString);

            OrganizationModel.User_Id = new Guid(SessionController.Users_.UserId.ToString());
            ds_sender = OrganizationClient.GetRequestLetterForEmail(OrganizationModel, SessionController.ConnectionString);
            string towhomeuserid = ds_Towhome.Tables[0].Rows[0]["userId"].ToString();
            encry_value = crypto.Encrypt(strOrgID).Replace("+", "!Plus!").Replace("#", "!Hash!").Replace("&", "!And!");
            encry_client_id = crypto.Encrypt(strClientID).Replace("+", "!Plus!").Replace("#", "!Hash!").Replace("&", "!And!");


            string fromaddress = ds_sender.Tables[0].Rows[0]["sender_email"].ToString();

            string toaddress = ds_Towhome.Tables[0].Rows[0]["user_email_adderss"].ToString();

            //string subject = "Request to add '" + ds_Towhome.Tables[0].Rows[0]["ToWhome_name"].ToString() + "' to the Organization '" + SessionController.Users_.OrganizationName + "'";

            string subject = "Request to add your organization to a project";




            string messagebody;

            messagebody = "Dear " + ds_Towhome.Tables[0].Rows[0]["PrimaryContact"].ToString() + ", <BR/><BR/>" +
               "We would like to add your organization, " + ds_Towhome.Tables[0].Rows[0]["ToWhome_name"].ToString() + ", to the Organizations List " +
               "within the EcoDomus PM System. Please approve this request by clicking on this link: " +
               "<a href='" + Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("Settings")) + "Settings/Acceptance_Organization.aspx?org_id=" + strOrgID + "&client_id=" + strClientID + "&id=" + towhomeuserid + "&project_id=" + SessionController.Users_.ProjectId + "' target='_blank'>Approve Request</a>" +

               "<BR /><BR />" + "Also, please assign the appropriate persons to the project by going to the " +
               "<a href='" + Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("Settings")) + "LoginPM.aspx" + "' target='_blank'>Organization Profile</a> <br />" +

               "and selecting personnel from your organization.<br/><br/>" +
               "We are looking forward to working with your team!<br/><br/>" +
               "Sincerely,<br/>" +
               ds_sender.Tables[0].Rows[0]["Sender_name"].ToString() + "<br/>" +

               ds_sender.Tables[0].Rows[0]["sender_organization_name"].ToString() + "<br/>" +
               ds_sender.Tables[0].Rows[0]["sender_phone"].ToString();

            EcoDomus.Mail.Control.MailControl mailControl = new EcoDomus.Mail.Control.MailControl();
            EcoDomus.Mail.Model.MailModel mailModel = new EcoDomus.Mail.Model.MailModel();


            mailModel.Sender = fromaddress;
            mailModel.Receiver = toaddress;
            mailModel.Subject = subject;
            mailModel.MessageBody = messagebody;
            mailModel.IsBodyHtml = true;
            string result = mailControl.SendMail(mailModel);

            lbl_msg.Text = result;

            ClientOrganization.ClientOrganizationClient OrganizationClient1 = new ClientOrganization.ClientOrganizationClient();

            ClientOrganization.ClientOrganizationModel OrganizationModel1 = new ClientOrganization.ClientOrganizationModel();

            OrganizationModel1.ClientId = new Guid(SessionController.Users_.ClientID);
            OrganizationModel1.Organization_Id = new Guid(strOrgID);
            OrganizationModel1.Request_status = "P";
            OrganizationModel1.User_Id = new Guid(SessionController.Users_.UserId);
            OrganizationModel1.Project_id = new Guid(SessionController.Users_.ProjectId);
            OrganizationClient1.InsertintoClientOrganizationLinkup(OrganizationModel1, SessionController.ConnectionString);
            // errorlable.Text = result;
            Bind_rgResources();
        }
        catch (Exception ex)
        {
            lbl_msg.Text = ex.Message.ToString();
        }

    }

    //protected void btn_Click(object sender, EventArgs e)
    //{
    //    try
    //    {

    //        ClientOrganization.ClientOrganizationClient OrganizationClient = new ClientOrganization.ClientOrganizationClient();
    //        ClientOrganization.ClientOrganizationModel OrganizationModel = new ClientOrganization.ClientOrganizationModel();

    //        string strOrgID = ((System.Web.UI.WebControls.Button)(sender)).CommandArgument.ToString();
    //        string strClientID = SessionController.Users_.ClientID;
    //        OrganizationModel.Organization_Id = new Guid(strOrgID);

    //        DataSet ds_Towhome = new DataSet();
    //        DataSet ds_sender = new DataSet();

    //        ds_Towhome = OrganizationClient.GetPrimaryContactInformationForEmail(OrganizationModel, SessionController.ConnectionString);

    //        OrganizationModel.User_Id = new Guid(SessionController.Users_.UserId.ToString());
    //        ds_sender = OrganizationClient.GetRequestLetterForEmail(OrganizationModel, SessionController.ConnectionString);
    //        string towhomeuserid = ds_Towhome.Tables[0].Rows[0]["userId"].ToString();
    //        encry_value = crypto.Encrypt(strOrgID).Replace("+", "!Plus!").Replace("#", "!Hash!").Replace("&", "!And!");
    //        encry_client_id = crypto.Encrypt(strClientID).Replace("+", "!Plus!").Replace("#", "!Hash!").Replace("&", "!And!");
           

    //        string fromaddress = ds_sender.Tables[0].Rows[0]["sender_email"].ToString();
         
    //        string toaddress = ds_Towhome.Tables[0].Rows[0]["user_email_adderss"].ToString();
          
    //        string subject = "Request to add '" + ds_Towhome.Tables[0].Rows[0]["ToWhome_name"].ToString() + "' to the Organization '" + SessionController.Users_.OrganizationName + "'";
          
    //        string messagebody;

    //         messagebody = "Dear " + ds_Towhome.Tables[0].Rows[0]["PrimaryContact"].ToString() + ", <BR/><BR/>" +
    //            "We would like to add your organization, " + ds_Towhome.Tables[0].Rows[0]["ToWhome_name"].ToString() + ", to the Organizations List " +
    //            "within the EcoDomus FM System. Please approve this request by clicking on this link: " +
    //            "<a href='" + Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("Settings")) + "Settings/Acceptance_Organization.aspx?org_id=" + strOrgID + "&client_id=" + strClientID + "&id=" + towhomeuserid + "' target='_blank'>Approve Request</a>" +

    //            "<BR /><BR />" + "Also, please assign the appropriate persons to the organization by going to the " +
    //            "<a href='" + Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("Settings")) + "LoginPM.aspx" + " ' target='_blank'>Organization Profile</a> <br />" +

    //            "and selecting personnel from your organization.<br/><br/>" +
    //            "We are looking forward to working with your team!<br/><br/>" +
    //            "Sincerely,<br/>" +
    //            ds_sender.Tables[0].Rows[0]["Sender_name"].ToString() + "<br/>" +
               
    //            ds_sender.Tables[0].Rows[0]["sender_organization_name"].ToString() + "<br/>" +
    //            ds_sender.Tables[0].Rows[0]["sender_phone"].ToString();

    //        EcoDomus.Mail.Control.MailControl mailControl = new EcoDomus.Mail.Control.MailControl();
    //        EcoDomus.Mail.Model.MailModel mailModel = new EcoDomus.Mail.Model.MailModel();


    //        mailModel.Sender = fromaddress;
    //        mailModel.Receiver = toaddress;
    //        mailModel.Subject = subject;
    //        mailModel.MessageBody = messagebody;
    //        mailModel.IsBodyHtml = true;
    //        string result = mailControl.SendMail(mailModel);

    //        lbl_msg.Text = result;

    //        ClientOrganization.ClientOrganizationClient OrganizationClient1 = new ClientOrganization.ClientOrganizationClient();

    //        ClientOrganization.ClientOrganizationModel OrganizationModel1 = new ClientOrganization.ClientOrganizationModel();

    //        OrganizationModel1.ClientId = new Guid(SessionController.Users_.ClientID);
    //        OrganizationModel1.Organization_Id = new Guid(strOrgID);
    //        OrganizationModel1.Request_status = "P";
    //        OrganizationModel1.Project_id = new Guid(SessionController.Users_.ProjectId);
    //        OrganizationModel1.User_Id = new Guid(SessionController.Users_.UserId);
    //        OrganizationClient1.InsertintoClientOrganizationLinkup(OrganizationModel1, SessionController.ConnectionString);
    //        // errorlable.Text = result;
    //        Bind_rgResources();
    //    }
    //    catch (Exception ex)
    //    {
    //        lbl_msg.Text = ex.Message.ToString();
    //    }

    //}

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
    protected void rgAddResources_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
      
        Bind_rgResources();
        flag = false;
   
    }
    protected void rgAddResources_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            tempPageSize = e.NewPageSize.ToString();
            if (!flag)
            {
                flag = true;
                Bind_rgResources();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

       
        
       
    }
    protected void rgAddResources_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        Bind_rgResources();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Bind_rgResources();
    }
    protected void btnAddNewResources_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/App/Settings/SettingsMenu.aspx?organization_id=00000000-0000-0000-0000-000000000000&IsfromClient=Y&user_role=FA", false);
    }
}
