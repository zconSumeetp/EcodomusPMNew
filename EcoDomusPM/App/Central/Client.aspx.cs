using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dashboard; 
using Telerik.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Login;
using Client;
using EcoDomus.Session;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Common;
//using EcoDomus.TA.TACLIENT;
using System.Globalization;
using System.Threading;
using Project;

public partial class App_Central_Client : System.Web.UI.Page
{
    #region Global Variable Declaration
    CryptoHelper crypto = new CryptoHelper();
    string tempPageSize = "";
    bool flag = false;
    #endregion

    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        txtSearch.Attributes.Add("onKeyPress", "doClick('" + btnSearch.ClientID + "',event)");
        if (SessionController.Users_.UserId != null && !SessionController.Users_.UserId.Equals(string.Empty))
        {
            if (!IsPostBack)
            {
                SessionController.Users_.facilityName = "ALL";
                txtSearch.Focus();
                txtSearch.Text = "";
                 
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "clientName";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rgClient.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                hfClientPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                bindSystemAdmins();
            }
        }
        else
        {
            Response.Redirect("~\\app\\Loginpm.aspx?Error=Session");
        }
    }
    #endregion

    #region My Methods
    //get system admins

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


    protected void bindSystemAdmins()
    {
        DataSet ds = new DataSet();
        try
        {
            Client.ClientClient obj_ctrl = new Client.ClientClient();
            
            ClientModel obj_mdl = new ClientModel();
            obj_mdl.ClientSearchText = txtSearch.Text.ToString();
            obj_mdl.ClientName = txtSearch.Text.ToString();
            ds = obj_ctrl.GetSystemAdmins(obj_mdl);
            rgClient.AllowCustomPaging = true;
          
            if (tempPageSize != "")
                rgClient.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgClient.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
            
            if (ds.Tables.Count > 0)
            {
                rgClient.DataSource = ds;
                rgClient.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Event Handlers
    protected void rgClient_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        try {

            RadComboBox cmbUnit = e.Item.FindControl("cmb_role") as RadComboBox;
            if (cmbUnit != null)
            {
                DataSet ds = new DataSet();
                Client.ClientClient obj_ctrl = new Client.ClientClient();
                ClientModel obj_mdl = new ClientModel();
                ds = obj_ctrl.GetSystemRoles(obj_mdl);
                cmbUnit.DataTextField = "systemRole";
                cmbUnit.DataValueField = "systemRoleId";
                cmbUnit.DataSource = ds;              
                cmbUnit.DataBind();
                int index=cmbUnit.FindItemIndexByText("OA");
                cmbUnit.SelectedIndex = index;



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

                foreach (GridColumn column in rgClient.MasterTableView.RenderColumns)
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
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                }
            }


            if (e.Item is GridDataItem)
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                foreach (GridColumn column in rgClient.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "organization_name")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2].ToString());
                        }
                    }
                    else if (column is GridTemplateColumn)
                    {

                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "clientName")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());

                    }

                }
            }
        }
        catch (Exception ex) { throw ex; }
        
    }

    //search for the client
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            bindSystemAdmins();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void OnItemCommand_rgClient(object source, GridCommandEventArgs e)
    {
        try
        {
           
            if (e.CommandName == "delete_client")
            {
                Guid client_id = new Guid(rgClient.Items[e.Item.ItemIndex]["clientId"].Text);
                Client.ClientClient obj_ctrl = new Client.ClientClient();
                ClientModel obj_mdl = new ClientModel();
                obj_mdl.ClientId = client_id;
                obj_ctrl.DeleteClient(obj_mdl);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "refreshgrid()", true);
            }
            if (e.CommandName == "Login")
            {
                //aded on 29-6-12----------------------------------------
                if (SessionController.Users_.UserSystemRole == "SA")
                {

                    CryptoHelper crypto_obj = new CryptoHelper();
                    LoginModel obj_LoginModel = new LoginModel();
                    LoginClient obj_LoginClient = new LoginClient();
                    DataSet ds_recentProject = new DataSet();
                    obj_LoginModel.UserId = new Guid(SessionController.Users_.UserId);
                    ds_recentProject = obj_LoginClient.GetRecentUserDataPMFM(obj_LoginModel);

                    if (ds_recentProject.Tables[0].Rows.Count > 0)
                    {
                        if (ds_recentProject.Tables[0].Rows[0]["pk_client_id"].ToString() == e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["clientId"].ToString())
                        {
                            SessionController.Users_.ProjectId = ds_recentProject.Tables[0].Rows[0]["project_id"].ToString();
                            SessionController.Users_.ClientName = ds_recentProject.Tables[0].Rows[0]["client_name"].ToString();

                            SessionController.ConnectionString = ds_recentProject.Tables[0].Rows[0]["connection_string"].ToString();
                            SessionController.Users_.ClientID = ds_recentProject.Tables[0].Rows[0]["pk_client_id"].ToString();

                            ProjectModel pm = new ProjectModel();
                            ProjectClient pc = new ProjectClient();
                            DataSet ds1 = new DataSet();
                            pm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                            ds1 = pc.GetProjectDataById(pm, SessionController.ConnectionString);
                            if (ds1.Tables[0].Rows.Count > 0)
                                SessionController.Users_.ProjectName = ds1.Tables[0].Rows[0]["project_name"].ToString();
                        }
                        else 
                        {
                            for (int j = 0; j < ds_recentProject.Tables[0].Rows.Count; j++)
                            {
                                if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["clientId"].ToString() == ds_recentProject.Tables[0].Rows[j]["pk_client_id"].ToString())
                                {
                                    SessionController.Users_.ProjectId = ds_recentProject.Tables[0].Rows[j]["project_id"].ToString();
                                    SessionController.Users_.ClientName = ds_recentProject.Tables[0].Rows[j]["client_name"].ToString();

                                    SessionController.ConnectionString = ds_recentProject.Tables[0].Rows[j]["connection_string"].ToString();
                                    SessionController.Users_.ClientID = ds_recentProject.Tables[0].Rows[j]["pk_client_id"].ToString();

                                    ProjectModel pm = new ProjectModel();
                                    ProjectClient pc = new ProjectClient();
                                    DataSet ds1 = new DataSet();
                                    pm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                                    ds1 = pc.GetProjectDataById(pm, SessionController.ConnectionString);
                                    if (ds1.Tables[0].Rows.Count > 0)
                                        SessionController.Users_.ProjectName = ds1.Tables[0].Rows[0]["project_name"].ToString();
                                }
                           }
                        }
              
                    }
                    SessionController.ConnectionString = crypto_obj.Encrypt(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ConnectionString"].ToString());
                    SessionController.Users_.ClientID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["clientId"].ToString();
                    ClientModel client_mdl = new ClientModel();
                    ClientClient client_ctrl = new ClientClient();
                    DataSet dsownerorg = new DataSet();
                    client_mdl.ClientId = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["clientId"].ToString());
                    dsownerorg = client_ctrl.GetOwnerOrg(client_mdl); 
                    SessionController.Users_.OrganizationID = dsownerorg.Tables[0].Rows[0]["organization_id"].ToString();
                    SessionController.Users_.OrganizationName = dsownerorg.Tables[0].Rows[0]["organization_name"].ToString();

                    SessionController.Users_.Initial_ClientId = SessionController.Users_.ClientID;
                    SessionController.Users_.Initial_ConnectionString = SessionController.ConnectionString;
                
                }
                //----------------------------------------------------------
                RadComboBox cmbRole = e.Item.FindControl("cmb_role") as RadComboBox;
                if (new Guid(cmbRole.SelectedItem.Value) == Guid.Empty)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "script", "<script language='javascript'>validateRole();</script>",false);
                }
                else if (cmbRole.SelectedItem.Text.ToString() == "OA" || cmbRole.SelectedItem.Text.ToString() == "PA" || cmbRole.SelectedItem.Text.ToString() == "GU" || cmbRole.SelectedItem.Text.ToString() == "CBU")
                {
                     
                    CryptoHelper crypto_obj = new CryptoHelper();
                    SessionController.Users_.UserSystemRole = cmbRole.SelectedItem.Text.ToString();
                    //SessionController.Users_.facilityID = (new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["clientId"].ToString())).ToString();
                    SessionController.ConnectionString = crypto_obj.Encrypt(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ConnectionString"].ToString());
                    SessionController.Users_.ClientID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["clientId"].ToString();
                    SessionController.Users_.ClientName = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["clientName"].ToString();

                    ///////////////////Proxy login Changes for PM-FM///////////////////////
                    if (SessionController.Users_.is_PM_FM == "FM")
                    {
                        DataSet ds = new DataSet();
                        LoginClient obj_crtl = new LoginClient();
                        LoginModel obj_mdl = new LoginModel();
                        //************
                        DataSet ds_ConnString = new DataSet();
                        obj_mdl.UserId = new Guid(SessionController.Users_.UserId.ToString());
                        ds_ConnString = obj_crtl.GetConnectionStringUser(obj_mdl);
                        //SessionController.ConnectionString =crypto.Encrypt(ds_ConnString.Tables[0].Rows[0]["connection_string"].ToString());

                        LoginModel obj_LoginModel = new LoginModel();
                        LoginClient obj_LoginClient = new LoginClient();
                        DataSet ds_recentFacility = new DataSet();
                        obj_LoginModel.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
                        obj_LoginModel.UserId = new Guid(SessionController.Users_.UserId.ToString());
                       // ds_recentFacility = obj_LoginClient.GetRecentFacilityDataFMSA(obj_LoginModel);

                        if (ds_recentFacility.Tables[0].Rows.Count > 0)
                        {
                            //CryptoHelper crypto_obj = new CryptoHelper();
                            SessionController.ConnectionString = crypto.Encrypt(ds_recentFacility.Tables[0].Rows[0]["connection_string"].ToString());
                            SessionController.Users_.facilityID = ds_recentFacility.Tables[0].Rows[0]["facility_id"].ToString();
                            SessionController.Users_.facilityName = "";// ds_recentFacility.Tables[0].Rows[0]["facility_name"].ToString();
                            SessionController.Users_.ClientID = ds_recentFacility.Tables[0].Rows[0]["fk_client_id"].ToString();
                            SessionController.Users_.ClientName = ds_recentFacility.Tables[0].Rows[0]["client_name"].ToString();

                            //getting system role for setting access permissions to pages 
                            //getsystemrole();

                            Response.Redirect("~/App/Reports/dashboard.aspx", false);


                        }
                        else
                        {
                            //SessionController.ConnectionString = crypto.Encrypt(ds_ConnString.Tables[0].Rows[0]["connection_string"].ToString());
                            //SessionController.Users_.ClientID = (ds_ConnString.Tables[0].Rows[0]["pk_client_id"].ToString());
                            //SessionController.Users_.ClientName = (ds_ConnString.Tables[0].Rows[0]["client_name"].ToString());
                            SessionController.Users_.facilityID = Guid.Empty.ToString();
                            SessionController.Users_.facilityName = "ALL";
                            Response.Redirect("~/App/Reports/dashboard.aspx", false);
                        }
                        //**********
                        //Response.Redirect("~/App/Reports/dashboard.aspx", false);
                    }
                    else if (SessionController.Users_.is_PM_FM == "PM")
                    {
                        Response.Redirect("~/App/Reports/Dashboard_PM.aspx", false);
                    }
                }

                //***********************************
                if (SessionController.Users_.UserSystemRole != "SA")
                {
                    
                    //// Response.Redirect("~/App/FacilityList.aspx?Flag=NO", false);
                }
                //************************************
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        bindSystemAdmins();
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        bindSystemAdmins();
    }
    protected void btn_RefreshGrid_Click(object sender, EventArgs e)
    {
        bindSystemAdmins();
    }
    

    protected void rgClient_OnPageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        bindSystemAdmins();
        flag = false;

    }

    protected void rgClient_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
         tempPageSize = e.NewPageSize.ToString();
         if (!flag)
         {
             flag = true;
             bindSystemAdmins();
         }
        
    }
    protected void rgClient_SortCommand(object source, GridSortCommandEventArgs e)
    {
        bindSystemAdmins();
    }
    #endregion
}