using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Login;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;


public partial class App_Settings_Roles : System.Web.UI.Page
{
    string created_by = "";
    string AccessRole = "";
    string System_Role = "";
    string tempPageSize = "";
    bool flag = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        txtRole.Attributes.Add("onKeyPress", "doClick('" + btnsearch.ClientID + "',event)");
        if (!Page.IsPostBack)
        {
           
            tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
            tempPageSize = Convert.ToString((Convert.ToInt32(tempPageSize) + 1));
            hfSearchResultPMPageSize.Value = tempPageSize;
            Bind_ProjectRoles();
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

            //redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
    protected void btnAddRole_Click(object sender, EventArgs e)
    {
        Response.Redirect("RolesMenu.aspx");
    }

    protected void Bind_ProjectRoles()
    {
        try
        {
            Roles.RolesClient RolesClient = new Roles.RolesClient();
            Roles.RolesModel RolesModel = new Roles.RolesModel();
            RolesModel.Fk_project_id = new Guid(SessionController.Users_.ProjectId);
            RolesModel.Role_Name = txtRole.Text.Trim();
            DataSet ds = new DataSet();
            
            ds = RolesClient.Get_project_roles(RolesModel, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0 && ds.Tables != null)
            {
                rgRoles.AllowCustomPaging = true;
                //rgRoles.AllowPaging = true;
                if (tempPageSize != "")
                    rgRoles.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
                rgRoles.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));//Int32.Parse( (ds.Tables[0].Rows.Count / Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids)).ToString());
      
                rgRoles.DataSource = ds;
                rgRoles.DataBind();
            }
            else 
            {
                rgRoles.DataSource = string.Empty;
               // rgRoles.DataBind();

            }

           
          }
        catch (Exception ex)
        {
            ex.Message.ToString();
        }
    
    }

    protected void rgRoles_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        Roles.RolesClient objRolesClient = new Roles.RolesClient();
        Roles.RolesModel objRolesModel = new Roles.RolesModel(); 
        if (e.CommandName == "deleteRole")
        {       
            objRolesModel.Project_RoleId = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_project_role_id"].ToString());
            hf_system_role.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["system_role"].ToString();     
            created_by= e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["created_by"].ToString();
            hf_role_delete.Value = objRolesModel.Project_RoleId.ToString();
            string flag = checkAssignedRole();
            if (flag == "Y")
            {
                if (hf_system_role.Value != null)
                {
                    System_Role = hf_system_role.Value.ToString();
                    if (System_Role == "SA" && SessionController.Users_.UserId.ToString() != created_by.ToLower() && System_Role != AccessRole)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "roleid", "validate_delete();", true);
                        
                    }
                    else
                    {
                        objRolesClient.Delete_project_role(objRolesModel, SessionController.ConnectionString);
                    }
                }
            }
            else if (flag == "")
            {

                if (hf_system_role.Value != null)
                {
                    System_Role = hf_system_role.Value.ToString();
                    if (System_Role == "SA" && SessionController.Users_.UserId.ToString() != created_by.ToLower())
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "roleid", "validate_delete();", true);

                    }
                    else
                    {
                        objRolesClient.Delete_project_role(objRolesModel, SessionController.ConnectionString);
                    }
                }


            }

            else
            {
                objRolesClient.Delete_project_role(objRolesModel, SessionController.ConnectionString);
            }
        }
        Bind_ProjectRoles();
    }


    protected void rgRoles_SortCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        Bind_ProjectRoles();
    }

    protected void rgRoles_OnPageIndexChanged(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
       
        Bind_ProjectRoles();
        flag = false;
    }

    protected void rgRoles_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        
        try
        {
            tempPageSize = e.NewPageSize.ToString();
            if (!flag)
            {
                flag = true;
                Bind_ProjectRoles();

            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        Bind_ProjectRoles();
    }
    protected void rgRoles_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {

            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rgRoles.MasterTableView.RenderColumns)
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


            if (e.Item is GridPagerItem)
            {

                RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                RadComboBoxItem item = new RadComboBoxItem(tempPageSize,tempPageSize);
               // RadComboBoxItem item = new RadComboBoxItem(SessionController.Users_.DefaultPageSizeGrids, SessionController.Users_.DefaultPageSizeGrids);
                item.Attributes.Add("ownerTableViewId", rgRoles.MasterTableView.ClientID);
                cb.Items.Add(item);

                cb.Items.Sort(new PagerRadComboBoxItemComparer());
                
                if (tempPageSize != "")
                {
                   
                    cb.Items.FindItemByValue(tempPageSize).Selected = true;
                }


            }

            if (e.Item is GridDataItem)
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                foreach (GridColumn column in rgRoles.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field

                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "Description")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2].ToString());
                        }
                        else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "status")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[9].ToString());
                        }
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "RoleName")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[1].ToString());
                    }

                    else if (column is GridButtonColumn)
                    {

                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "RoleName")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[1].ToString());

                    }
                  
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public string checkAssignedRole()
    {

        try
        {
            string flag = "";
            Roles.RolesClient RolesClient = new Roles.RolesClient();
            Roles.RolesModel RolesModel = new Roles.RolesModel();
            RolesModel.Project_id = new Guid(SessionController.Users_.ProjectId);
            RolesModel.User_Id = new Guid(SessionController.Users_.UserId);
            RolesModel.Project_RoleId = new Guid(hf_role_delete.Value);
            DataSet ds = new DataSet();

            ds = RolesClient.Get_Verfiy_Role(RolesModel, SessionController.ConnectionString);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    flag = "Y";
                    if (ds.Tables[1].Rows.Count > 0)
                    {

                        AccessRole = ds.Tables[1].Rows[0]["name"].ToString();
                    }
                }
                else
                {
                    flag = "N";
                }
            }
            return flag;

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
}