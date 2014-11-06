using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;

public partial class App_Sustainability_SetupBasAccess : System.Web.UI.Page
{

    public string BASinsertupdate
    {

        get { return ViewState["BASinsertupdate"].ToString();}
        set { ViewState["BASinsertupdate"]=value; }
    }

    
    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                
                if (SessionController.Users_.UserId != null)
                {

                    getprotocollist();
                    getserverlist();
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    #endregion

    #region Private Methods

    private void getprotocollist()
    {
        try
        {
            BAS.BASClient BASClient = new BAS.BASClient();
            BAS.BASmodel BASmodel = new BAS.BASmodel();


            DataSet ds = BASClient.getprotocollist(BASmodel, SessionController.ConnectionString);

            ddlprotocol.DataSource = ds;
            ddlprotocol.DataBind();

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void getserverlist()
    {
        try
        {
            BAS.BASClient BASClient = new BAS.BASClient();
            BAS.BASmodel BASmodel = new BAS.BASmodel();

            BASmodel.Searchtext = txtsearch.Text;
            BASmodel.Pk_bas_server_id = Guid.Empty;
            DataSet ds = BASClient.getBASservers(BASmodel, SessionController.ConnectionString);

            rgbasserver.DataSource = ds;
            rgbasserver.DataBind();

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    #endregion

    #region Event Handlers

    protected void btnaddbasserver_click(object sender, EventArgs e)
    {
        try
        {

            tblbasserver.Style.Add("display", "inline");
            caption.InnerText = "Add BAS Server";
            btnaddbasserver.Visible = false;
            BASinsertupdate = Guid.Empty.ToString();
            txtname.Text = "";
            txtpassword.Text = "";
            txtusername.Text = "";
            txturl.Text = "";
            ddlprotocol.SelectedValue = Guid.Empty.ToString();
            txtpassword.Attributes.Add("value", "");

        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

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

    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        {
            tblbasserver.Style.Add("display", "none");
            btnaddbasserver.Visible = true;


            BAS.BASClient BASClient = new BAS.BASClient();
            BAS.BASmodel BASmodel = new BAS.BASmodel();
            BASmodel.Pk_bas_server_id = new Guid(BASinsertupdate);
            BASmodel.Bas_server_url = txturl.Text.ToString();
            BASmodel.Fk_bas_server_protocol_id = new Guid(ddlprotocol.SelectedValue);
            BASmodel.Login_user_name = txtusername.Text.ToString();
            BASmodel.Login_user_password = txtpassword.Text.ToString();
            BASmodel.Name = txtname.Text.ToString();

            BASClient.InsertUpdateBASinformation(BASmodel, SessionController.ConnectionString);

            getserverlist();


        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    protected void btncancel_Click(object sender, EventArgs e)
    {
        try
        {
            tblbasserver.Style.Add("display", "none");
            btnaddbasserver.Visible = true;
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    protected void rgbasserver_itemcommad(object sender, GridCommandEventArgs e)
    {
        Guid basserverid;
        try
        {
            if (e.CommandName == "DeleteBASserver")
            {

                basserverid = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_bas_server_id"].ToString());
                BAS.BASClient BASClient = new BAS.BASClient();
                BAS.BASmodel BASmodel = new BAS.BASmodel();
                BASmodel.Pk_bas_server_id = basserverid;
                BASClient.DeleteBASservers(BASmodel, SessionController.ConnectionString);
                getserverlist();

            }

            if (e.CommandName == "navigate")
            {
                tblbasserver.Style.Add("display", "inline");
                caption.InnerText = "Edit BAS Server";
          

                DataSet ds = new DataSet();
                basserverid = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_bas_server_id"].ToString());
                BAS.BASClient BASClient = new BAS.BASClient();
                BAS.BASmodel BASmodel = new BAS.BASmodel();
                BASmodel.Pk_bas_server_id = basserverid;
                BASmodel.Searchtext = "";
                BASmodel.Pk_bas_server_id = basserverid;
                ds=BASClient.getBASservers(BASmodel, SessionController.ConnectionString);
                if (ds != null)
                {
                    tblbasserver.Visible = true;
                    btnaddbasserver.Visible = false;

                    txtname.Text = ds.Tables[0].Rows[0]["servername"].ToString();
                    txtpassword.Attributes.Add("value", ds.Tables[0].Rows[0]["login_user_password"].ToString());
                    txturl.Text = ds.Tables[0].Rows[0]["bas_server_url"].ToString();
                    txtusername.Text = ds.Tables[0].Rows[0]["login_user_name"].ToString();
                    ddlprotocol.SelectedValue = ds.Tables[0].Rows[0]["pk_bas_protocol_id"].ToString();

                    BASinsertupdate = basserverid.ToString();
                
                }

            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rgbasserver_sortcommand(object sender, GridSortCommandEventArgs e)
    {
        try
        {
            getserverlist();

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void radbtnsearch_click(object sender, EventArgs e)
    {

        try
        {

            getserverlist();


        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    #endregion

}