using System;
using System.Collections;
using System.Data;
using System.Globalization;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Session;
using Login;
using Organization;
using Project;
using Telerik.Web.UI;

namespace App.Settings
{
    public partial class Projects : SelectProjectPage
    {
        DataSet ds_temp3 = new DataSet();
        int blank_master;
        ArrayList clientsofuser = new ArrayList();
        string tempPageSize = "";
        bool flag = false;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Request.QueryString["flag"] == "no_master")
            {
                Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";
                blank_master = 1;
                ViewState["flag_master"] = "no_master";
            }


            //if(Request.QueryString["flag1"] == "new" && Request.QueryString["flag"] != "no_master")
            //{
            //    Page.MasterPageFile = "~/App/EcoDomusMaster.master"; 
            //    //blank_master = 0;
            //}
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            txtSearch.Attributes.Add("onKeyPress", "doClick('" + btnsearchProject.ClientID + "',event)");
            if (SessionController.Users_.UserId != null)
            {
                if (SessionController.Users_.UserSystemRole == "SA")
                {
                    btnAddProject.Visible = false;
                }
                checkOtherOA();    // To check whether user logged in is other OA.
                checkforotherclient();

                if (!IsPostBack)
                {
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "project_name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    rgProjects.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    //GetUserClientDetail_forPM();
                    hfProjectPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    GetUserClientDetail_forPM_new();
                }

                if (Request.QueryString["flag"] == "no_master")
                {
                    OrganizationModel om = new OrganizationModel();
                    OrganizationClient oc = new OrganizationClient();


                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SetCaption", "SetCaption('Y');", true);

                }
                else
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SetCaption", "SetCaption('N');", true);
            }
            else
            {
                // Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }
        }


        public void GetUserClientDetail_forPM_new()
        {
            try
            {

                DataSet ds = new DataSet();
                DataSet ds_facility = new DataSet();
                CryptoHelper crypt = new CryptoHelper();
                DataSet ds_project = new DataSet();// final dataset of projects 

                LoginClient login_ctrl = new LoginClient();
                LoginModel login_mdl = new LoginModel();
                login_mdl.UserId = new Guid(SessionController.Users_.UserId);

                if (Request.QueryString["UserId"] != null && Request.QueryString["UserId"] != "")
                    login_mdl.UserId = new Guid(Request.QueryString["UserId"]);

                ds = login_ctrl.GetUserClientDetail_new(login_mdl);

                if (Convert.ToString(ds.Tables.Count) != "0")
                {

                    if (ds.Tables[0].Rows.Count > 0)
                    {

                        foreach (DataRow myRow in ds.Tables[0].Rows)
                        {
                            DataSet ds_temp = new DataSet();
                            ds_temp = GetorganizationProjects(crypt.Encrypt(myRow["ConnectionString"].ToString()), new Guid(myRow["client_id"].ToString()), new Guid(SessionController.Users_.OrganizationID.ToString()), Convert.ToString(myRow["is_primary_flag"]));
                            ds_project.Merge(ds_temp);
                        }
                        rgProjects.Visible = true;
                        ViewState["TempDataset"] = ds_project;

                        rgProjects.AllowCustomPaging = true;
                        if (tempPageSize != "")
                            rgProjects.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
                        rgProjects.VirtualItemCount = Int32.Parse((ds_project.Tables[0].Rows.Count.ToString()));
                        if (ds_project.Tables.Count > 0)
                        {

                            rgProjects.DataSource = ds_project;
                            rgProjects.DataBind();
                        }

                    }
                    else
                    {
                        DataTable dt = new DataTable();
                        dt.Columns.Add("pk_project_id");
                        dt.Columns.Add("project_name");
                        dt.Columns.Add("lead_organization");
                        dt.Columns.Add("State");
                        dt.Columns.Add("owner_org");
                        dt.Columns.Add("cons_string");
                        rgProjects.DataSource = dt;
                        rgProjects.DataBind();

                    }

                }
                else
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("pk_project_id");
                    dt.Columns.Add("project_name");
                    dt.Columns.Add("lead_organization");
                    dt.Columns.Add("State");
                    dt.Columns.Add("owner_org");
                    dt.Columns.Add("cons_string");
                    rgProjects.DataSource = dt;
                    rgProjects.DataBind();
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected DataSet GetorganizationProjects(string con_string, Guid client_id, Guid pk_organization_id, string is_primary_flag)
        {
            ProjectClient proj_crtl = new ProjectClient();
            ProjectModel proj_mdl = new ProjectModel();
            DataSet ds = new DataSet();
            CryptoHelper crypt = new CryptoHelper();
            try
            {

                proj_mdl.User_id = new Guid(SessionController.Users_.UserId);
                proj_mdl.Search_text_name = txtSearch.Text;
                proj_mdl.Client_id = client_id;
                proj_mdl.Conn_string = con_string;
                proj_mdl.Sessionclient_id = new Guid(SessionController.Users_.ClientID);
                proj_mdl.Organization_id = pk_organization_id;
                if (Convert.ToString(SessionController.Users_.UserRoleDescription) == "System Admin")
                {
                    proj_mdl.Role = "System Admin";
                }
                else
                {
                    proj_mdl.Role = Convert.ToString(SessionController.Users_.UserSystemRole);
                }
                proj_mdl.is_primary_flag = is_primary_flag;
                ds = proj_crtl.proc_get_client_all_projects(proj_mdl, con_string);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        protected DataSet GetorganizationProjects_backup(string con_string, Guid client_id, Guid pk_organization_id)
        {
            ProjectClient proj_crtl = new ProjectClient();
            ProjectModel proj_mdl = new ProjectModel();
            DataSet ds = new DataSet();
            CryptoHelper crypt = new CryptoHelper();
            try
            {
                DataColumn column;
                DataSet dsuserid = new DataSet();
                if (SessionController.Users_.UserRoleDescription == "System Admin")
                {
                    proj_mdl.Sessionclient_id = new Guid(SessionController.Users_.Initial_ClientId);
                    dsuserid = proj_crtl.GetUserId(proj_mdl, SessionController.Users_.Initial_ConnectionString);
                    proj_mdl.User_id = new Guid(dsuserid.Tables[0].Rows[0]["fk_user_id"].ToString());
                }
                else
                {
                    proj_mdl.User_id = new Guid(SessionController.Users_.UserId);
                }

                proj_mdl.Search_text_name = txtSearch.Text;
                proj_mdl.Client_id = client_id;
                proj_mdl.Conn_string = con_string;
                proj_mdl.Sessionclient_id = new Guid(SessionController.Users_.ClientID);
                proj_mdl.Organization_id = pk_organization_id;
                ds = proj_crtl.proc_get_client_all_projects(proj_mdl, con_string);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        protected DataSet GetProjects(string con_string, Guid client_id)
        {
            ProjectClient proj_crtl = new ProjectClient();
            ProjectModel proj_mdl = new ProjectModel();
            DataSet ds = new DataSet();
            CryptoHelper crypt = new CryptoHelper();
            try
            {
                DataColumn column;
                DataSet dsuserid = new DataSet();
                if (SessionController.Users_.UserRoleDescription == "System Admin")
                {
                    proj_mdl.Sessionclient_id = new Guid(SessionController.Users_.Initial_ClientId);
                    dsuserid = proj_crtl.GetUserId(proj_mdl, SessionController.Users_.Initial_ConnectionString);
                    proj_mdl.User_id = new Guid(dsuserid.Tables[0].Rows[0]["fk_user_id"].ToString());
                }
                else
                {
                    proj_mdl.User_id = new Guid(SessionController.Users_.UserId);
                }

                proj_mdl.Search_text_name = txtSearch.Text;
                proj_mdl.Client_id = client_id;
                proj_mdl.Conn_string = con_string;
                proj_mdl.Sessionclient_id = new Guid(SessionController.Users_.ClientID);

                ds = proj_crtl.GetUserProjects(proj_mdl, con_string);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        protected void rgProjects_ItemCommand(object sender, GridCommandEventArgs e)
        {
            var commandName = e.CommandName;

            if (commandName == "Edit")
            {
                var dataItem = (GridDataItem)e.Item;
                var projectId = (Guid)dataItem.GetDataKeyValue("pk_project_id");
                var projectName = (string)dataItem.GetDataKeyValue("project_name");
                var clientId = (Guid)dataItem.GetDataKeyValue("pk_client_id");
                var connectionString = (string)dataItem.GetDataKeyValue("cons_string");

                SwitchContextToProject(projectId, projectName, clientId, connectionString);
                hfprojectid.Value = projectId.ToString();
                
                ScriptManager.RegisterStartupScript(this, this.GetType(), "navigate", "NavigateToProjectProfile();", true);
            }
        }

        protected void btnAddProject_Click(object sender, EventArgs e)
        {
            LoginModel lm = new LoginModel();
            LoginClient lc = new LoginClient();
            DataSet ds = new DataSet();
            CryptoHelper crypt = new CryptoHelper();
            lm.UserId = new Guid(SessionController.Users_.UserId);
            ds = lc.GetConnectionStringUser(lm);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["is_primary_flag"].ToString() == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
                }
                else
                {
                    if (SessionController.Users_.UserRoleDescription != "System Admin")
                    {
                        SessionController.Users_.OrganizationID = ds.Tables[0].Rows[0]["pk_organization_id"].ToString();
                        SessionController.Users_.OrganizationName = ds.Tables[0].Rows[0]["name"].ToString();
                    }
                    else
                    {

                    }

                    Response.Redirect("~\\App\\Settings\\ProjectMenu.aspx?pagevalue=ProjectProfile&ProjectId=" + Guid.Empty + "&ispage=");
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //GetUserClientDetail_forPM();
            GetUserClientDetail_forPM_new();
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

                // redirect_page("~\\app\\LoginPM.aspx?Error=Session");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }

        }

        public void redirect_page(string url)
        {
            Response.Redirect(url, false);
        }

        public void checkOtherOA()  // To check whether user logged in is other OA.
        {
            LoginModel lm = new LoginModel();
            LoginClient lc = new LoginClient();
            DataSet ds = new DataSet();
            CryptoHelper crypt = new CryptoHelper();
            lm.UserId = new Guid(SessionController.Users_.UserId);
            ds = lc.GetConnectionStringUser(lm);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["is_primary_flag"].ToString() == "")
                {
                    btnAddProject.Visible = false;
                }
            }
        }

        public void checkforotherclient()
        {
            LoginModel lm = new LoginModel();
            LoginClient lc = new LoginClient();
            DataSet ds = new DataSet();
            CryptoHelper crypt = new CryptoHelper();

            if (SessionController.Users_.UserRoleDescription != "System Admin")
            {
                lm.UserId = new Guid(SessionController.Users_.UserId); //earlier
                ds = lc.GetConnectionStringUser(lm);
                if (ds.Tables[0].Rows.Count == 1)
                {
                    Guid clientofuser = new Guid(ds.Tables[0].Rows[0]["pk_client_id"].ToString());
                    if (clientofuser != new Guid(SessionController.Users_.ClientID))
                    {
                        btnAddProject.Visible = false;
                    }
                }
                else
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        clientsofuser.Add(ds.Tables[0].Rows[i]["pk_client_id"].ToString());
                    }
                    if (clientsofuser.Contains(SessionController.Users_.ClientID))
                    {
                    }
                    else
                    {
                        btnAddProject.Visible = false;
                    }
                }

                /*---check if the user has primary organization in different database---*/
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (Convert.ToString(ds.Tables[0].Rows[0]["pk_client_id"]) != "")
                    {
                        if (Convert.ToString(ds.Tables[0].Rows[0]["is_primary_flag"]) == "Y")
                        {
                            btnAddProject.Visible = true;
                            SessionController.Users_.ClientID = Convert.ToString(ds.Tables[0].Rows[0]["pk_client_id"]);
                            SessionController.Users_.ClientName = Convert.ToString(ds.Tables[0].Rows[0]["name"]);
                                            
                      
                        }

 
                    }
                }
            }
        }

        protected void rgProjects_PageIndexChanged(object source, GridPageChangedEventArgs e)
        {
            try
            {
                //GetUserClientDetail_forPM();
                GetUserClientDetail_forPM_new();
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void rgProjects_PageSizeChanged(object source, GridPageSizeChangedEventArgs e)
        {
            try
            {
                //GetUserClientDetail_forPM();
                GetUserClientDetail_forPM_new();
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void rgProjects_SortCommand(object source, GridSortCommandEventArgs e)
        {
            try
            {
                //GetUserClientDetail_forPM();
                GetUserClientDetail_forPM_new();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void Page_Prerender(object sender, EventArgs e)
        {
            try
            {
                if (SessionController.Users_.UserSystemRole == "GU" || SessionController.Users_.UserSystemRole == "PA")
                {
                    btnAddProject.Visible = false;
                }
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
                    if (dr_profile["name"].ToString() == "Projects")
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
                btnAddProject.Enabled = false;
            }
            else
            {
                btnAddProject.Enabled = true;
            }
        }

        protected void rgProjects_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            try
            {
                if (e.Item is GridPagerItem)
                {

                    RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                    cb.Items.Sort(new PagerRadComboBoxItemComparer());
                    if (tempPageSize != "")
                    {
                        cb.Items.FindItemByValue(tempPageSize).Selected = true;
                    }
                }



                if (e.Item is GridDataItem)
                {
                    GridDataItem gridItem = e.Item as GridDataItem;
                    foreach (GridColumn column in rgProjects.MasterTableView.RenderColumns)
                    {
                        if (column is GridBoundColumn)
                        {
                            //this line will show a tooltip based type of Databound for grid data field
                            if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "OrganizationName")
                            {
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2].ToString());
                            }
                            else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName != "client_name1" && column.UniqueName != "enabled")
                            {
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                            }
                        }


                        else if (column is GridButtonColumn)
                        {

                            if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "project_name" )
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());

                        }

                    }
                }

                if (e.Item is GridHeaderItem)
                {
                    GridHeaderItem headerItem = e.Item as GridHeaderItem;

                    foreach (GridColumn column in rgProjects.MasterTableView.RenderColumns)
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
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}