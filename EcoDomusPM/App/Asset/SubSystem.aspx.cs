using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;

public partial class App_Asset_System : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flag = false;
    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
          if (SessionController.Users_.UserId != null)
           {

             if (!IsPostBack)
             {
                if (SessionController.Users_.UserId != null)
                {

                    if (Request.QueryString["system_id"] != null)
                    {
                        if (Request.QueryString["system_id"].ToString() != "")
                        {
                            if (Request.QueryString["system_id"].ToString() == Guid.Empty.ToString())
                            {
                                hfSystemId.Value = Guid.Empty.ToString();
                            }
                            else
                            {
                                hfSystemId.Value = Request.QueryString["system_id"].ToString();
                                Systems.SystemsModel objSystemsModel = new Systems.SystemsModel();
                                Systems.SystemsClient objSystemsClient = new Systems.SystemsClient();
                                DataSet ds = new DataSet();
                                objSystemsModel.SystemId = new Guid(hfSystemId.Value);
                                ds = objSystemsClient.GetSystemProfile(objSystemsModel, SessionController.ConnectionString);
                                //lblSystemName.Text= ds.Tables[0].Rows[0]["SystemName"].ToString();
                            }
                        }
                    }
                   
                }
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "SubsystemName";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rgSubSystems.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                hfDocumentPMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 2);
                tempPageSize = hfDocumentPMPageSize.Value;
                 BindSubSystem();
            }
        }
        else
        {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        
        }
          
           
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    #endregion

    #region Private Methods

    private void BindSubSystem()
    {
        try
        {
            Systems.SystemsModel objSystemsModel =new Systems.SystemsModel();
            Systems.SystemsClient objSystemsClient =new Systems.SystemsClient();
            if (Request.QueryString["system_id"] != null)
            {
                if (Request.QueryString["system_id"].ToString() != "")
                {
                    if (Request.QueryString["system_id"].ToString() == Guid.Empty.ToString())
                    {
                        objSystemsModel.SystemId = Guid.Empty;
                    }
                    else
                    {
                        objSystemsModel.SystemId = new Guid(Request.QueryString["system_id"].ToString());
                    }
                }
            }
            objSystemsModel.SearchText=txtcriteria.Text.Trim();
            DataSet ds =new DataSet();
            ds= objSystemsClient.GetSubSystems(objSystemsModel,SessionController.ConnectionString);
            rgSubSystems.AllowCustomPaging = true;
            // rgdocument.AllowPaging = true;
            if (tempPageSize != "")
                rgSubSystems.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgSubSystems.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
            rgSubSystems.DataSource =ds;
            rgSubSystems.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

    #region Event Handlers

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        try
        {
            BindSubSystem();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void rgSubSystems_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "SubsystemNameProfile")
            {
                hfSubsystemId.Value = e.Item.Cells[3].Text;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);
            }
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
        
    }

    //protected void btnCancel_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        Response.Redirect("~/App/Asset/SystemProfile.aspx?system_id=" + hfSystemId.Value, false);
    //    }
    //    catch (Exception ex)
    //    {
            
    //        throw ex;
    //    }
        
    //}

    protected void btnUnassignSubsystems_Click(object sender, EventArgs e)
    {
        
        string strSubsystemids = "", strSubsystemNames = "";
        try
        {
            if (rgSubSystems.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                for (int i = 0; i < rgSubSystems.SelectedItems.Count; i++)
                {
                    strSubsystemids = strSubsystemids + rgSubSystems.SelectedItems[i].Cells[3].Text + ",";
                    strSubsystemNames = strSubsystemNames + rgSubSystems.SelectedItems[i].Cells[4].Text + ",";
                }
                strSubsystemids = strSubsystemids.Substring(0, strSubsystemids.Length - 1);
                strSubsystemNames = strSubsystemNames.Substring(0, strSubsystemNames.Length - 1);

                Systems.SystemsModel objSystemsModel = new Systems.SystemsModel();
                Systems.SystemsClient objSystemsClient = new Systems.SystemsClient();
                if (Request.QueryString["system_id"] != null)
                {
                    if (Request.QueryString["system_id"].ToString() != "")
                    {
                        if (Request.QueryString["system_id"].ToString() == Guid.Empty.ToString())
                        {
                            objSystemsModel.SystemId = Guid.Empty;
                        }
                        else
                        {
                            objSystemsModel.SystemId = new Guid(Request.QueryString["system_id"].ToString());
                        }
                    }
                }

                objSystemsModel.SubSystemIds = strSubsystemids;
                objSystemsClient.UnassignSubSystems(objSystemsModel, SessionController.ConnectionString);
                BindSubSystem();
            }
         }

        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

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

    protected void Page_Prerender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "GU")
        {
            btnAddSubSystems.Visible = false;
            btnUnassignSubsystems.Visible = false;

        }
        // BindSubSystem();
        if (SessionController.Users_.Permission_ds != null)
        {
            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
            {
                {
                    SetPermissions();
                }
            }
        }
    }

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='System'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "System Profile")
                {
                    // Edit/Delete permission for component
                    SetPermissionToControl(dr_profile);

                    // permissions for component profile fields
                    DataRow[] dr_fields_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_profile["pk_project_role_controls"] + "'");
                    foreach (DataRow dr in dr_fields_component)
                    {
                        SetPermissionToControl(dr);
                    }

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
        string edit_permission = dr["edit_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();
        // delete button on component profile
        if (dr["name"].ToString() == "System Profile")
        {
            objPermission.SetEditable(btnAddSubSystems, edit_permission);
            objPermission.SetEditable(btnUnassignSubsystems, delete_permission);
        }
    }

 protected void rgSubSystems_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridHeaderItem)
        {
            GridHeaderItem headerItem = e.Item as GridHeaderItem;

            foreach (GridColumn column in rgSubSystems.MasterTableView.RenderColumns)
            {
                if (column is GridBoundColumn)
                {
                    //if the sorting feature of the grid is enabled
                    if (column.HeaderText != "")
                        (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                }
                if (column is GridButtonColumn)
                {
                    //if the sorting feature of the grid is enabled
                    if (column.HeaderText != "" && column.HeaderText != "Delete")
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
            foreach (GridColumn column in rgSubSystems.MasterTableView.RenderColumns)
            {
                if (column is GridBoundColumn)
                {
                    //this line will show a tooltip based type of Databound for grid data field
                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "AttributeName")
                    {
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[0].ToString());
                    }
                    else
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                }
                else if (column is GridButtonColumn)
                {
                    //this line will show a tooltip based type of linkbutton for grid data field
                    if (column.OrderIndex > -1 && e.Item.DataItem != null)
                    {
                        if (column.UniqueName.ToString().Equals("name"))
                            //if(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].GetType() == typeof(string))
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                    }
                }
                else if (column is GridTemplateColumn)
                {
                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "SubsystemName")
                    {
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[1].ToString());
                    }
                    if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "StageName")
                    {
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[12].ToString());
                    }
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
        //try
        //{
        //    if (e.Item is Telerik.Web.UI.GridDataItem)
        //    {
        //        Permissions objPermission = new Permissions();
        //        if (SessionController.Users_.Permission_ds != null)
        //        {
        //            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
        //            {
        //                DataSet ds_component = SessionController.Users_.Permission_ds;
        //                DataRow dr_component = ds_component.Tables[0].Select("name='System Profile'")[0];
        //                string delete_permission = dr_component["delete_permission"].ToString();
        //                string edit_permission = dr_component["edit_permission"].ToString();
        //                string name = string.Empty;
        //                if (edit_permission == "N")
        //                {
        //                    // remove hyperlink for System name 
        //                    try
        //                    {
        //                        LinkButton lnk = (LinkButton)e.Item.FindControl("lnkbtnSubsystemName");
        //                        name = lnk.Text.ToString();
        //                        lnk.Enabled = false;
        //                        lnk.ResolveUrl(name.Replace("&nbsp;", ""));
        //                        //name = e.Item.Cells[4].Text.ToString();
        //                        //e.Item.Cells[4].Text = objPermission.remove_Hyperlink(name.Replace("&nbsp;", ""));
        //                    }
        //                    catch (Exception)
        //                    {
        //                        throw;
        //                    }
        //                }
        //            }
        //        }
        //    }
        //}
        //catch (Exception ex)
        //{
        //    throw ex;
        //}
    }

}