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
using System.Threading;
using System.Globalization;


public partial class App_Settings_ClientOrganizations : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flag = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtSearch.Attributes.Add("onKeyPress", "doClick('" + btnsearch.ClientID + "',event)");
            if (!Page.IsPostBack)
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "OrganizationName";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rgResources.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                BindOrganizationTypes();
                hfClientOrgaPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                BindResourcesDetails();
            }          
           
        }
        catch (Exception ex)
        {
            Response.Write("Page_Load :-" + ex.Message.ToString());
        }
    }

    protected void ddlOrgType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try 
        {
            BindResourcesDetails();
        }
        catch (Exception ex)
        {
            Response.Write("Page_Load :-" + ex.Message.ToString());
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
            lblMessage.Text = "BindOrganizationTypes:" + ex.Message.ToString();
        }
    }

    //navigate to next page to assign new organization
    protected void btnAddNewResources_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/App/Settings/AddNewOrganization.aspx");
    }

    //Bind all assigned,pending and denied organizations
    protected void BindResourcesDetails()
    {
        try
        {          
            ClientOrganization.ClientOrganizationClient OrganizationClient = new ClientOrganization.ClientOrganizationClient();

            ClientOrganization.ClientOrganizationModel OrganizationModel = new ClientOrganization.ClientOrganizationModel();

             OrganizationModel.ClientId = new Guid(SessionController.Users_.ClientID);
             OrganizationModel.Txt_Search = txtSearch.Text;
             OrganizationModel.TypeId = ddlOrgType.SelectedValue;
             if (SessionController.Users_.ProjectId != null)
             {
                 OrganizationModel.Project_id = new Guid(SessionController.Users_.ProjectId);
             }
             else
             {
                 OrganizationModel.Project_id = Guid.Empty;
             }

             DataSet ds = OrganizationClient.GetClientOrganization(OrganizationModel, SessionController.ConnectionString);
             //if (ds.Tables[0].Rows.Count > 0)
             //{
             rgResources.AllowCustomPaging = true;
             if (tempPageSize != "")
                 rgResources.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
             rgResources.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
                 
                 rgResources.DataSource = ds;
                 rgResources.DataBind();
             //}
           
        }
        catch (Exception ex)
        {
            lblMessage.Text = "BindResourcesDetails:" + ex.Message.ToString();
            
            
        }
    }

    // to remove and edit organization
    protected void rgResources_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {

        if (e.CommandName == "EditOrganization")
        {

            string Organization_Id, Organization_name;
            string User_Id="";
            string user_role = "";
            user_role = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Role"].ToString();
            User_Id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["primary_contact_id"].ToString();
            Organization_Id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_organization_id"].ToString();
            Organization_name = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["OrganizationName"].ToString();
            Response.Redirect("~/App/Settings/SettingsMenu.aspx?organization_id=" + Organization_Id.ToString() + "&Organization_name=" + Organization_name.ToString() + "&IsfromClient=Y&UserId=" + User_Id.ToString() + "&user_role=FA", false);           
        }
        if (e.CommandName == "RemoveOrganization")
        {           
            ClientOrganization.ClientOrganizationClient OrganizationClient = new ClientOrganization.ClientOrganizationClient();
            ClientOrganization.ClientOrganizationModel OrganizationModel = new ClientOrganization.ClientOrganizationModel();

            OrganizationModel.ClientId = new Guid(SessionController.Users_.ClientID);
            OrganizationModel.Organization_Id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_organization_id"].ToString());
            OrganizationClient.DeleteOrganizationClientSide(OrganizationModel, SessionController.ConnectionString);
            BindResourcesDetails();
        }
    }

    // To set the color according to status
    protected void rgResources_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        try
        {
            if (e.Item is Telerik.Web.UI.GridDataItem)
            {
                Button btn = e.Item.FindControl("btn") as Button;
                Label lbl = e.Item.FindControl("lblColor") as Label;
                btn.CssClass = lbl.Text.ToString();

                if (lbl.Text.ToString() == "Disable")
                {
                    //btn.Text = "Request Pending";
                    btn.Visible = false;
                }
                if (lbl.Text.ToString() == "btnGreen")
                {
                    btn.Text = "Assigned";
                    btn.Enabled = false;
                }
                if (lbl.Text.ToString() == "btnRed")
                {
                    btn.Text = "Denied";
                    btn.Enabled = false;
                }
                if (lbl.Text.ToString() == "btnBlue")
                {
                    btn.Text = "Request Pending";
                    btn.Enabled = false;
                }
                string uservalue = e.Item.Cells[5].Text;
                uservalue = uservalue.Replace("\"", "'");
                uservalue = uservalue.Replace("!span", "<span").Replace("span!", "</span>").Replace("@$", ">");
                e.Item.Cells[5].Text = uservalue;

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
                                if (dr_profile["name"].ToString() == "Organization")
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
                        else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "Email" )
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[9].ToString());
                        }
                        else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "web_address")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[8].ToString());
                        }
                    }


                    else if (column is GridButtonColumn)
                    {

                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "name")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2].ToString());

                    }

                }
            }
        }
        catch (Exception ex)
        {

            lblMessage.Text = "rgResources_ItemDataBound:" + ex.Message.ToString();
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
       catch (Exception)
        {
            Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
        }
    }

    protected void rgResources_OnPageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        BindResourcesDetails();
        flag = false;

    }

    protected void rgResources_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        BindResourcesDetails();
    }

    protected void rgResources_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        
        try
        {
            tempPageSize = e.NewPageSize.ToString();
            if (!flag)
            {
                flag = true;
                BindResourcesDetails();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindResourcesDetails();
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            //BindOrganizationTypes();
            BindResourcesDetails();

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
            foreach (GridDataItem item in rgResources.MasterTableView.Items)
            {
                Button btn = (Button)item.FindControl("btn");
                btn.Enabled = false;

                ImageButton imgbtnDelete = (ImageButton)item.FindControl("btnRemove");
                imgbtnDelete.Enabled = false;
            }

            btnAddNewResources.Enabled = false;
        }
        else
        {
            foreach (GridDataItem item in rgResources.MasterTableView.Items)
            {
                Button btn = (Button)item.FindControl("btn");
                btn.Enabled = true;

                ImageButton imgbtnDelete = (ImageButton)item.FindControl("btnRemove");
                imgbtnDelete.Enabled = true;
            }

            btnAddNewResources.Enabled = true;
        }
    }
}