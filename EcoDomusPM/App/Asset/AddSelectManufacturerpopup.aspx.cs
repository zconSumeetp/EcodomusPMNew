using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TypeProfile;
using EcoDomus.Session;
using System.Data;
using System.Net.Mail;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Mail;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;
  

public partial class App_Asset_AddSelectManufacturerpopup : System.Web.UI.Page
{

    CryptoHelper crypto = new CryptoHelper();
    string encry_value = "";
    string encry_client_id = "";
    Guid client_id;
    string flag_name = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.ClientID != null)
        {

            if (!IsPostBack)
            {
               // div_assignedManufacturer.Visible = true;
                div_addManufacturer.Visible = false;

                //To show the sorting arrow on first column on page load:-
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                RgManufacturers.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                if (Request.QueryString["Name"] != null)
                {
                    hf_flag_name.Value = Request.QueryString["Name"].ToString();
                    Session["flag_name"] = hf_flag_name.Value;
                }
                else
                {
                    if (Session["flag_name"] != null)
                    {
                        hf_flag_name.Value = (string)Session["flag_name"];
                    }
                
                }

                BindAssignedManufacturer();
               // if (Request.RawUrl.ToString().ToLower().Contains("popup"))
                if (Request.QueryString["popupflag"] != null)
                {
                    if (Request.QueryString["popupflag"].ToString().ToLower().Contains("popup"))
                    {
                        btnAddManufacturer.Enabled = false;
                    }
                }
            }
        }
    }
    protected void Page_Prerender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "GU" || SessionController.Users_.UserSystemRole == "PA" || SessionController.Users_.UserSystemRole == "CBU")
        {
            btnAddManufacturer.Visible = false;
        }

    }
    protected override void InitializeCulture()
    {
        if (SessionController.Users_.UserId != null)
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

                throw ex;
            }
        }
        else
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
    private void BindAssignedManufacturer()
    {
        DataSet ds = new DataSet();
        TypeProfile.TypeProfileClient obj_type = new TypeProfileClient();
        TypeProfile.TypeModel mdl = new TypeModel();
        mdl.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
        mdl.Txt_Search = txt_search.Text;
        ds = obj_type.GetClientAssignedManufacturer(mdl, SessionController.ConnectionString);
        RgManufacturers.DataSource = ds;
        RgManufacturers.DataBind();
    }
    protected void btnAssign_Click(object sender, EventArgs e)
    {
        string id = "", name = "";
        try
        {
            if (RgManufacturers.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                for (int i = 0; i < RgManufacturers.SelectedItems.Count; i++)
                {
                    id = id + RgManufacturers.SelectedItems[i].Cells[2].Text + ",";
                    name = name + RgManufacturers.SelectedItems[i].Cells[4].Text + ",";
                }
                id = id.Substring(0, id.Length - 1);
                name = name.Substring(0, name.Length - 1);

                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_Sub_System('" + id + "','" + name + "','"+flag_name+"')</script>", false);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>assignmanufacturer();</script>", false);
            }
        }

        catch (Exception ex)
        {

            Response.Write("btnAssign_Click:-" + ex.Message);
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
                Label lblPC = e.Item.FindControl("lblPrimaryContact") as Label;
                //btn.CssClass = lbl.Text.ToString();
                btn.CssClass = lbl.Text.ToString();

                if (lblPC.Text.ToString() == "N/A")
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
                        btn.Enabled = false;
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
        }
        catch (Exception ex)
        {
            Response.Write("rgAddResources_ItemDataBound1 :-" + ex.Message.ToString());
        }

    }
    protected void rgAddResources_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        Bind_rgResources();
    }
    private void Bind_rgResources()
    {
        try
        {

            DataSet ds = new DataSet();

            TypeProfile.TypeProfileClient TypeClient = new TypeProfileClient();
            TypeProfile.TypeModel mdl = new TypeModel();
            mdl.ClientId = new Guid(SessionController.Users_.ClientID);
            mdl.Txt_Search = txt_search.Text;

            ds = TypeClient.GetManufacturerunassignedOrganizations(mdl, SessionController.ConnectionString);

            // if (ds.Tables[0].Rows.Count > 0)
            // {
            rgResources.DataSource = ds;
            rgResources.DataBind();
            //}
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "btnAddManufacturer_Click" + ex;
        }

    }
    protected void rgAddResources_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        Bind_rgResources();
    }
    protected void rgAddResources_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        Bind_rgResources();
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

            encry_value = crypto.Encrypt(strOrgID).Replace("+", "!Plus!").Replace("#", "!Hash!").Replace("&", "!And!");
            encry_client_id = crypto.Encrypt(strClientID).Replace("+", "!Plus!").Replace("#", "!Hash!").Replace("&", "!And!");


            string fromaddress = ds_sender.Tables[0].Rows[0]["sender_email"].ToString();

            string toaddress = ds_Towhome.Tables[0].Rows[0]["user_email_adderss"].ToString();

            string subject = "Request to add '" + ds_Towhome.Tables[0].Rows[0]["ToWhome_name"].ToString() + "' to the Organization '" + SessionController.Users_.OrganizationName + "'";

            string messagebody;

            messagebody = "Dear " + ds_Towhome.Tables[0].Rows[0]["PrimaryContact"].ToString() + ", <BR/><BR/>" +
               "We would like to add your organization, " + ds_Towhome.Tables[0].Rows[0]["ToWhome_name"].ToString() + ", to the Organizations List " +
               "within the EcoDomus FM System. Please approve this request by clicking on this link: " +
               "<a href='" + Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("Settings")) + "Settings/Acceptance_Organization.aspx?org_id=" + encry_value + "&client_id=" + encry_client_id + "' target='_blank'>Approve Request</a>" +


               "<BR /><BR />" + "Also, please assign the appropriate persons to the organization by going to the " +
               "<a href='" + Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("Settings")) + "LoginPM.aspx" + " ' target='_blank'>Organization Profile</a> <br />" +

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
    protected void btnAddManufacturer_Click1(object sender, EventArgs e)
    {
      //  div_assignedManufacturer.Visible = false;
        //div_addManufacturer.Visible = true;
        Response.Redirect("~/App/Asset/AddManufacturerOrganization.aspx?organization_id=00000000-0000-0000-0000-000000000000&IsfromClient=Y&FromType=Y", true);
        // div_addManufacturer.Visible = true;
        //  Bind_rgResources();
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
       // div_assignedManufacturer.Visible = true;
        div_addManufacturer.Visible = false;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //if (div_assignedManufacturer.Visible == true)
        //{
        //    BindAssignedManufacturer();
        //}
        //else
        //{
        //    Bind_rgResources();
        //}
    }

    protected void RgManufacturers_OnPageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        BindAssignedManufacturer();
    }
    protected void RgManufacturers_OnPageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindAssignedManufacturer();
    }
    protected void RgManufacturers_OnSortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        BindAssignedManufacturer();
    }

  
   
    protected void btn_search_Click(object sender, ImageClickEventArgs e)
    {
        BindAssignedManufacturer();
    }
}