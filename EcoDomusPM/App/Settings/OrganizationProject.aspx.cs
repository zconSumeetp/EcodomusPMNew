using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project;
using Organization;
using EcoDomus.Session;
using System.Data;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;
using Login;


public partial class App_Settings_OrganizationProject : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flag = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (SessionController.Users_.UserSystemRole == "SA")
            {
                btnAddProject.Visible = false;
            }
            if (!IsPostBack)
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "project_name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                rgProjects.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                hfDocumentPMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 1);
                tempPageSize = hfDocumentPMPageSize.Value;
                bind_projects();
            }
        }
    }


    protected void bind_projects()
    {
        //OrganizationModel om = new OrganizationModel();
        //OrganizationClient oc = new OrganizationClient();
        //om.Organization_Id = new Guid(Request.QueryString["organization_id"].ToString());
        
        //ProjectModel pm = new ProjectModel();
        //ProjectClient pc = new ProjectClient();
        //DataSet ds = new DataSet();
        //try
        //{
        //    pm.Organization_id = new Guid(Request.QueryString["organization_id"].ToString());
        //    pm.Search_text_name = txtSearch.Text;
        //    pm.Conn_string = SessionController.ConnectionString.ToString();
        //    ds = pc.GetProjectsOrganization(pm, SessionController.ConnectionString);
        //    rgProjects.DataSource = ds;
        //    rgProjects.DataBind();
        //}
        //catch (Exception ex)
        //{
        //}



        CryptoHelper crypt = new CryptoHelper();
        OrganizationModel om = new OrganizationModel();
        OrganizationClient oc = new OrganizationClient();
        om.Organization_Id = new Guid(Request.QueryString["organization_id"].ToString());

        hforgid.Value = Request.QueryString["organization_id"].ToString();
        DataSet ds_org = oc.GetOranizationInformation(om);
        hforgname.Value = ds_org.Tables[0].Rows[0]["OrganizationName"].ToString(); 


        DataSet ds_project = new DataSet();

        DataSet ds_clients = new DataSet();
        ds_clients = oc.GetClients_of_organization(om);


        if (ds_clients.Tables[0].Rows.Count > 0)
        {

            foreach (DataRow myRow in ds_clients.Tables[0].Rows)
            {
                DataSet ds_temp = new DataSet();
                ds_temp = GetProjects(crypt.Encrypt(myRow["ConnectionString"].ToString()), new Guid(myRow["organization_id"].ToString()), myRow["client_name"].ToString() , new Guid(myRow["pk_client_id"].ToString()));
                ds_project.Merge(ds_temp);
            }

            if (tempPageSize != "")
                rgProjects.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgProjects.VirtualItemCount = Int32.Parse((ds_project.Tables[0].Rows.Count.ToString()));
            rgProjects.Visible = true;
            ViewState["TempDataset"] = ds_project;
            rgProjects.DataSource = ds_project;
            rgProjects.DataBind();

        }
        else {
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

    protected DataSet GetProjects(string con_string, Guid org_id, string clientname , Guid client_id)
    {
        ProjectClient proj_crtl = new ProjectClient();
        ProjectModel proj_mdl = new ProjectModel();
        DataSet ds = new DataSet();
        try
        {
            DataColumn column;
            proj_mdl.Organization_id = org_id;
            proj_mdl.Client_id = client_id;
                //new Guid(Request.QueryString["organization_id"].ToString());
            proj_mdl.Conn_string = con_string;
            proj_mdl.Search_text_name = txtSearch.Text;
            ds = proj_crtl.GetProjectsOrganization(proj_mdl, con_string);
            //column = new DataColumn();
            //column.DataType = System.Type.GetType("System.String");
            //column.ColumnName = "Client_Name";
            //ds.Tables[0].Columns.Add(column);
            //foreach (DataRow myRow in ds.Tables[0].Rows)
            //{
            //    myRow["Client_Name"] = clientname;
            //}
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ds;
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

    protected void rgProjects_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        try
        {
            bind_projects();
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
            bind_projects();
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
            bind_projects();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            bind_projects();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgProjects_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edit")
            {
                CryptoHelper crypto_obj = new CryptoHelper();
                SessionController.ConnectionString = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["cons_string"].ToString(); //earlier                
                string pk_project_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_project_id"].ToString();
                string project_name = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["project_name"].ToString();
                SessionController.Users_.ClientID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_client_id"].ToString();
                hfprojectid.Value = pk_project_id;
                SessionController.Users_.ProjectId = pk_project_id;
                SessionController.Users_.ProjectName = project_name;            
                try
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "navigate", "NavigateToProjectProfile();", true);
                }
                catch (Exception ex)
                {

                    throw ex;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
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
                SessionController.ConnectionString = crypt.Encrypt(ds.Tables[0].Rows[0]["connection_string"].ToString());
                //SessionController.Users_.OrganizationID = ds.Tables[0].Rows[0]["pk_organization_id"].ToString();
                //SessionController.Users_.OrganizationName = ds.Tables[0].Rows[0]["name"].ToString();
                
                SessionController.Users_.ProjectId = Guid.Empty.ToString();
                hfprojectid.Value = Guid.Empty.ToString();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "addproject();", true); 
                //Response.Redirect("~\\App\\Settings\\ProjectMenu.aspx?pagevalue=ProjectProfile&ProjectId=" + Guid.Empty + "&org_id=" + hforgid.Value + "&org_name=" + hforgname.Value);                
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
        }

    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
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
                if (dr_profile["name"].ToString() == "Organization")
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

        //delete permission
        if (delete_permission == "N")
        {


        }
        else
        {


        }




    }
    protected void rgProjects_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rgProjects.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                    else if (column is GridButtonColumn)
                    {
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "" && column.HeaderText != "Delete")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }

                }
            }

            if (e.Item is GridPagerItem && flag)
            {

                RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                cb.Items.Sort(new PagerRadComboBoxItemComparer());
                if (tempPageSize != "")
                {
                    cb.Items.FindItemByValue(tempPageSize).Selected = true;
                }
            }

            //if (e.Item is GridPagerItem)
            //{
            //    GridPagerItem pagerItem = e.Item as GridPagerItem;
            //    RadComboBox combo = pagerItem.FindControl("PageSizeComboBox") as RadComboBox;
            //    combo.EnableScreenBoundaryDetection = false;
            //    combo.ExpandDirection = RadComboBoxExpandDirection.Up;
            //}
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
                        else if (column.UniqueName == "client_name" || column.UniqueName == "enabled")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[3].ToString());
                        else
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                    }
                    else if (column is GridButtonColumn)
                    {
                        //this line will show a tooltip based type of linkbutton for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null)
                        {
                            if (column.UniqueName.ToString().Equals("Name"))
                                //if(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].GetType() == typeof(string))
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                        }
                    }
                    else if (column is GridTemplateColumn)
                    {
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "unitName")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[8].ToString());
                        }
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "StageName")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[12].ToString());
                        }
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