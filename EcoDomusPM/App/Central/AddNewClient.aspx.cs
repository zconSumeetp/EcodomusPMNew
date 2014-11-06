using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Login;
using Client;
using EcoDomus.Session;
using System.Configuration;
using System.Threading;
using System.Globalization;
//using EcoDomus.TA.TACLIENT;


public partial class App_Central_AddNewClient : System.Web.UI.Page
{
    #region Global variable Declarations
    #endregion

    #region Page  events
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null && !SessionController.Users_.UserId.Equals(string.Empty))
            {
                if (!IsPostBack)
                {
                    //dropdown shows all organizations
                    BindOrganizationDropdown();
                }
            }
        }
        catch (Exception)
        {
            Response.Redirect("~\\app\\Loginpm.aspx?Error=Session");
        }
    }
    #endregion

    #region My Methods
    //dropdown shows all organizations
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

            redirect_page("~\\app\\Loginpm.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
    protected void BindOrganizationDropdown()
    {
        DataSet ds = new DataSet();
        try
        {
            Client.ClientClient obj_ctrl = new Client.ClientClient();
            ClientModel obj_mdl = new ClientModel();
            ds = obj_ctrl.BindOrganization(obj_mdl);
            rcbOrganizations.DataTextField = "name";
            rcbOrganizations.DataValueField = "ID";
            rcbOrganizations.DataSource = ds;
            rcbOrganizations.DataBind();

            //size of dropdown
            int cmb_size = 250;
            cmb_size = cmb_size < (rcbOrganizations.Items.Count) * 18 ? cmb_size : (rcbOrganizations.Items.Count) * 18;
            //rcbOrganizations.Height = cmb_size;
            rcbOrganizations.Height = 150;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //create new db if not exists and client if not exists
    protected void AddNewClientClick(object sender, EventArgs e)
    {
        string exist_flag = "";
        try
        {
            Client.ClientClient obj_ctrl = new Client.ClientClient();
            ClientModel obj_mdl = new ClientModel();
            obj_mdl.ClientName = txtClientName.Text.ToString();
            obj_mdl.ServerInstance = ConfigurationManager.AppSettings["serverInstance"].ToString();
            obj_mdl.DatabaseUsername = ConfigurationManager.AppSettings["dbUsername"].ToString();
            obj_mdl.DatabasePassword = ConfigurationManager.AppSettings["dbPassward"].ToString();
            obj_mdl.Blank_db_Name_to_Restore = ConfigurationManager.AppSettings["blankDBName"].ToString();
            obj_mdl.InitialCatalogue = txtDatabaseName.Text.ToString();
            obj_mdl.ConnectTimeout = 100;
            obj_mdl.OrganizationId = new Guid(rcbOrganizations.SelectedValue);
            obj_mdl.CreatedByUserId = new Guid(SessionController.Users_.UserId);

            //create the database
            string flag = obj_ctrl.CreateNewClientDB(obj_mdl);

            //check if db already exists
            if (flag == "DBExists")
            {
                lblMessage.Text = "This DataBase name already exists!";
            }

            //database created, check for duplicate client name
            if (flag == "DONE")
            {
                exist_flag = obj_ctrl.InsertNewClient(obj_mdl);
                if (exist_flag == "Y")
                {
                    lblMessage.Text = "This Client name already exists!";
                }
                else
                {

                    ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>refresh_parent();</script>");
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion
}