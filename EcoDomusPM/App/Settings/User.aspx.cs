using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using User;
using System.Data;
using System.Data.SqlClient;
using EcoDomus.Session;
using Telerik.Web.UI;
using Locations;
using System.Threading;
using System.Globalization;

public partial class App_Reports_UserProfile : System.Web.UI.Page
{
    #region Global Variable Declaration
    string user_id;
    string organization_id;
    int blank_master;
    string tempPageSize = "";
    bool flag = false;
    #endregion

    #region Page Events
    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Request.QueryString["flag"] == "no_master")
        {
            Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";
            blank_master = 1;
        }
        //if(Request.QueryString["flag1"] == "new" && Request.QueryString["flag"] != "no_master")
        //{
        //    Page.MasterPageFile = "~/App/EcoDomusMaster.master"; 
        //    //blank_master = 0;
        //}
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

            //redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try 
        {
            if (SessionController.Users_.UserId != null && !SessionController.Users_.UserId.Equals(string.Empty))
            {
                user_id = SessionController.Users_.UserId;
                organization_id = SessionController.Users_.OrganizationID;

                if (!IsPostBack)
                {
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "Name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against above specified column
                    rgUsers.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    hfUserPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    if (Request.QueryString["flag"] == "no_master")
                    {
                        tempPageSize = Convert.ToString(Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids) - 2);
                        bindUserDetails(user_id, organization_id);
                        // tblUser.Style.Add("margin-left", "30px");
                    }
                    else
                    {
                        bindUserDetails(user_id, organization_id);
                    }

                }

            }
            else
            {
                // Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }

            if (Request.QueryString["flag"] == "no_master")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SetCaption", "SetCaption('Y');", true);

            }
            else
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SetCaption", "SetCaption('N');", true);
        }

        catch (Exception ex)
        {
            lbl_msg.Text = "Page_Load:- " + ex.Message.ToString();
        }
    }
    #endregion

    #region My Methods
    //get all users
    protected void bindUserDetails(string userId, string organizationId)
    {
        DataSet ds = new DataSet();
        try
        {
            UserClient dm = new UserClient();
            UserModel mdl = new UserModel();
            mdl.SearchTextUser = txtSearch.Text.ToString();
            mdl.UserId = new Guid(userId);
            mdl.OrganizationId = new Guid(organizationId);
            mdl.Title = SessionController.Users_.UserSystemRole;   // passing system role to the procedure.
            if (Convert.ToString(SessionController.Users_.UserRoleDescription) == "System Admin")
            {
                mdl.Title = "SA";
            }
            if (blank_master == 1)
            {
                mdl.OrganizationId = new Guid(Request.QueryString["Organization_Id"]);
                mdl.FlagOrganizationUsers = "Y";
            }
            else
            {
                mdl.FlagOrganizationUsers = "N";
            }
            ds = dm.GetUser(mdl);

            rgUsers.AllowCustomPaging = true;
            if (tempPageSize != "")
                rgUsers.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgUsers.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
            if (ds.Tables.Count > 0)
            {
                rgUsers.DataSource = ds;
                rgUsers.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //delete the particular user
    protected void deleteUser(string userId)
    {
        UserClient ctrl = new UserClient();
        UserModel mdl = new UserModel();
        try
        {
            mdl.UserId = new Guid(userId);
            ctrl.DeleteUser(mdl);
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    #endregion

    #region Event Handlers
    protected void rgUsers_SortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            bindUserDetails(user_id, organization_id);
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "rgUsers_SortCommand:- " + ex.Message.ToString();
        }
    }
    protected void rgUsers_PageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {

            bindUserDetails(user_id, organization_id);
            flag = false;

        }
        catch (Exception ex)
        {
            lbl_msg.Text = "rgUsers_PageIndexChanged:- " + ex.Message.ToString();
        }

    }
    protected void rgUsers_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            tempPageSize = e.NewPageSize.ToString();
            if (!flag)
            {
                flag = true;
                bindUserDetails(user_id, organization_id);
            }
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "rgUsers_PageSizeChanged:- " + ex.Message.ToString();
        }

    }
    protected void rgUsers_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "EditUser")
        {

            string userId = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ID"].ToString();
            string user_role = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["system_role"].ToString();
            if (SessionController.Users_.UserSystemRole.Equals("SA"))
            {
                user_role = "SA";
            }
            if (blank_master == 1)
            {
                Response.Redirect("UserMenu.aspx?UserId=" + userId + "&organization_id=" + Request.QueryString["Organization_Id"] + "&flag=no_master&user_role=" + user_role);
            }
            else
            {
                Response.Redirect("UserMenu.aspx?UserId=" + userId + "&flag=&user_role=" + user_role);
            }
        }

        if (e.CommandName == "cloneuser")
        {
            //added by Priyanka J---------------------------------------------
            if ((Request.QueryString["flag"] == "no_master") && (Request.QueryString["Organization_Id"] != null))
            {
                string userId = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ID"].ToString();

                Response.Redirect("UserMenu.aspx?UserId=" + userId + "&flag=clone" + "&flag1=no_radmenu" + "&organization_id=" + Request.QueryString["Organization_Id"]);
            }
            //----------------------------------------------------------------
            else
            {
                string userId = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ID"].ToString();
                Response.Redirect("UserMenu.aspx?UserId=" + userId + "&flag=clone");
            }

        }

        if (e.CommandName == "deleteuser")
        {
            string userId = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ID"].ToString();
            deleteUser(userId);
            bindUserDetails(user_id, organization_id);
        }

    }
    protected void btnAddNewUser_Click(object sender, EventArgs e)
    {
        //Response.Redirect("UserProfile.aspx?UserId="+Guid.Empty+"&flag=");
        if (blank_master == 1)
        {
            Response.Redirect("UserMenu.aspx?UserId=" + Guid.Empty + "&flag=no_master&organization_id=" + Request.QueryString["Organization_Id"] + "&Organization_name=" + Request.QueryString["Organization_name"]);
        }
        else
        {
            Response.Redirect("UserMenu.aspx?UserId=" + Guid.Empty + "&flag=");
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindUserDetails(user_id, organization_id);
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            user_id = SessionController.Users_.UserId;
            organization_id = SessionController.Users_.OrganizationID;
            bindUserDetails(user_id, organization_id);
            if (SessionController.Users_.UserSystemRole == "CBU")
            {
                foreach (GridDataItem item in rgUsers.MasterTableView.Items)
                {
                    ImageButton btn = item.FindControl("imgbtnClone") as ImageButton;
                    string str = item["system_role"].Text;
                    if (str == "PA" || str == "OA" || str == "GU" || str == "LU")
                    {
                        btn.Enabled = false;
                    }

                }
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
                if (dr_profile["name"].ToString() == "Users")
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
        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rgUsers.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }
        }
        else
        {
            foreach (GridDataItem item in rgUsers.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = true;
            }
        }


        if (edit_permission == "N")
        {
            foreach (GridDataItem item in rgUsers.MasterTableView.Items)
            {
                ImageButton imgbtnClone = (ImageButton)item.FindControl("imgbtnClone");
                imgbtnClone.Enabled = false;
            }
            btnAddNewUser.Enabled = false;

        }
        else
        {
            foreach (GridDataItem item in rgUsers.MasterTableView.Items)
            {
                ImageButton imgbtnClone = (ImageButton)item.FindControl("imgbtnClone");
                imgbtnClone.Enabled = true;
            }
            btnAddNewUser.Enabled = true;
        }


    }

    protected void rgUsers_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is Telerik.Web.UI.GridDataItem)
            {
                if (SessionController.Users_.Permission_ds != null)
                {
                    if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                    {
                        DataSet ds_component = SessionController.Users_.Permission_ds;
                        DataRow dr_component = ds_component.Tables[0].Select("name='BIM Server'")[0];
                        DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
                        foreach (DataRow dr_profile in dr_submenu_component)
                        {
                            if (dr_profile["name"].ToString() == "Users")
                            {
                                Permissions objPermission = new Permissions();
                                string delete_permission = dr_profile["delete_permission"].ToString();
                                string edit_permission = dr_profile["edit_permission"].ToString();
                                string name = string.Empty;
                                if (edit_permission == "N")
                                {
                                    try
                                    {
                                        GridDataItem item = (GridDataItem)e.Item;
                                        LinkButton lnkname = (LinkButton)item["name"].Controls[0];
                                        name = lnkname.Text;
                                        lnkname.Enabled = false;
                                        lnkname.ResolveUrl(name.Replace("&nbsp;", ""));
                                    }
                                    catch (Exception)
                                    {
                                        throw;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rgUsers.MasterTableView.RenderColumns)
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
                foreach (GridColumn column in rgUsers.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null)
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                        }
                    }


                    else if (column is GridButtonColumn)
                    {

                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "Name")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());

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

        }
        catch (Exception)
        {
            throw;
        }
    }
    protected void rgUsers_OnPreRender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "CBU")
        {
            foreach (GridDataItem item in rgUsers.MasterTableView.Items)
            {
                string name = string.Empty;
                LinkButton lnkname = (LinkButton)item["name"].Controls[0];
                ImageButton btn = item.FindControl("imgbtnDelete") as ImageButton;
                string str = item["system_role"].Text;
                if (str == "PA" || str == "OA" || str == "GU" || str == "LU")
                {
                    name = lnkname.Text;
                    lnkname.Enabled = false;
                    lnkname.ResolveUrl(name.Replace("&nbsp;", ""));
                    btn.Enabled = false;
                }
            }

        }

    }

    #endregion
}