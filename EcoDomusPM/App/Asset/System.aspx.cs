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
using Facility;
using System.Collections;
using TypeProfile;

public partial class App_Asset_System : System.Web.UI.Page
{
    string Master_flag = "";
    string UniClass_flag = "";
    string UniFormat_flag = "";
    string OmniClass_flag = "";
    public ArrayList arrayList = new ArrayList();
    List<String> ls = new List<string>();
    int TotalItemCount;
    string tempPageSize = "";
    bool flag = false;
    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtcriteria.Attributes.Add("onKeyPress", "doClick('" + btn_search.ClientID + "',event)");
            if (SessionController.Users_.UserId != null)
            {
                if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                }
                else
                {
                    if (!IsPostBack)
                    {
                        ViewState["SelectedsystemID"] = null;
                        BindFacility();
                        GridSortExpression sortExpr = new GridSortExpression();
                        sortExpr.FieldName = "SystemName";
                        sortExpr.SortOrder = GridSortOrder.Ascending;
                        //Add sort expression, which will sort against first column
                        rgSystems.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                        //ViewState["PageSize"] = 10;
                        //ViewState["PageIndex"] = 0;
                        //ViewState["SortExpression"] = "SystemName"; 

                        hfSystemPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                        tempPageSize = SessionController.Users_.DefaultPageSizeGrids;

                        ViewState["PageSize"] = tempPageSize;
                        ViewState["PageIndex"] = 0;
                        ViewState["SortExpression"] = "SystemName"; 
                        BindSystem();

                    }
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    //protected void Page_Prerender(object sender, EventArgs e)
    //{

    //    if (!Page.IsPostBack)
    //    {
    //        BindSystem();
    //    }
    //    else if (Request.Params.Get("__EVENTTARGET") == "ctl00$chkfacility")
    //    {
    //        BindSystem();
    //    }
    //}

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    {
                        SetPermissions();
                    }
                }
            }
            if (SessionController.Users_.UserId != null)
            {

                if (!Page.IsPostBack)
                {
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "SystemName";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgSystems.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                    {

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                    }
                    else
                    {
                        BindSystem();
                    }

                }
                else
                {

                    BindSystem();
                }
                //else if (Request.Params.Get("__EVENTTARGET") == "ctl00$chkfacility")
                //{
                //    BindSystem();
                //}

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
            DataRow dr_component = ds_component.Tables[0].Select("name='System'")[0];
            SetPermissionToControl(dr_component);


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
        if (dr["name"].ToString() == "System")
        {
            objPermission.SetEditable(btnDelete, delete_permission);
            objPermission.SetEditable(btnAddSystem, edit_permission);
        }

    }

    #endregion

    #region Event Handlers

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        try
        {
            BindSystem();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void rgSystems_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        GetSelectedRows();
        ViewState["PageIndex"] = e.NewPageIndex;
        flag = false;
    }

    protected void GetSelectedRows()
    {
        try
        {
            SessionToArrayList();


            foreach (GridDataItem item in rgSystems.Items)
            {
                string strIndex = rgSystems.MasterTableView.CurrentPageIndex.ToString();
                // string comp_id = item.GetDataKeyValue("Assetid").ToString();
                string comp_id = item["Systemsid"].Text;

                if (item.Selected)
                {
                    if (!arrayList.Contains(comp_id.ToString()))
                    {
                        arrayList.Add(comp_id.ToString());
                    }
                }
                else
                {
                    if (arrayList.Contains(comp_id.ToString()))
                    {
                        arrayList.Remove(comp_id.ToString());
                    }
                }
            }

            ViewState["SelectedsystemID"] = arrayList;
            ArrayList comp_list = (ArrayList)ViewState["SelectedsystemID"];
            string id = "";
            if (comp_list.Count > 0)
            {
                for (int i = 0; i < comp_list.Count; i++)
                {
                    id = id + comp_list[i].ToString() + ",";

                }
                id = id.Substring(0, id.Length - 1);
                hf_system_id.Value = id;

            }
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void SessionToArrayList()
    {
        try
        {
            if (ViewState["SelectedsystemID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedsystemID"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rgSystems_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            tempPageSize = e.NewPageSize.ToString();
            if (!flag)
            {
                flag = true;

                GetSelectedRows();

                //if (e.NewPageSize != 10 && e.NewPageSize != 20 && e.NewPageSize != 50)
                //{
                //    ViewState["PageSize"] = 0;
                //    ViewState["PageIndex"] = 0;


                //}
                //else
                //{
                    ViewState["PageSize"] = e.NewPageSize;
                    int compo_count = Int32.Parse(ViewState["SystemCount"].ToString());
                    int page_size = Int32.Parse(ViewState["PageSize"].ToString());
                    int page_index = Int32.Parse(ViewState["PageIndex"].ToString());
                    int maxpg_index = (compo_count / page_size) + 1;
                    if (page_index >= maxpg_index)
                    {
                        ViewState["PageIndex"] = 0;
                    }

               // }
            }
           // BindSystem();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void rgSystems_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Systemprofile")
            {
                Response.Redirect("~/App/Asset/SystemMenu.aspx?system_id=" + e.Item.Cells[2].Text, false);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void rgSystems_OnItemEvent(object sender, GridItemEventArgs e)
    {

        if (e.EventInfo is GridInitializePagerItem)
        {

            TotalItemCount = (e.EventInfo as GridInitializePagerItem).PagingManager.DataSourceCount;

        }
        hf_count.Value = TotalItemCount.ToString();

    }

    protected void rgSystems_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            ReSelectedRows();
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

                foreach (GridColumn column in rgSystems.MasterTableView.RenderColumns)
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
                foreach (GridColumn column in rgSystems.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null)
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                    }
                    else if (column is GridButtonColumn)
                    {
                        //this line will show a tooltip based type of linkbutton for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.OrderIndex != 3)
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());

                    }
                    else if (column is GridTemplateColumn)
                    {
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName != "name")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                        else
                        {
                            GridDataItem item = (GridDataItem)e.Item;
                            LinkButton lbl = (LinkButton)item.FindControl("lnkbtnName");
                            string value = lbl.Text;
                            gridItem[column.UniqueName].ToolTip = value;// Convert.ToString((Label)gridItem.FindControl("lblDocName"));
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

    protected void btnAddSystem_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/App/Asset/SystemMenu.aspx?system_id=" + Guid.Empty.ToString(), false);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (rgSystems.SelectedItems.Count > 0)  // check weather user checked any text box or not 
            {
                System.Text.StringBuilder strSystemIds = new System.Text.StringBuilder();
                for (int i = 0; i < rgSystems.SelectedItems.Count; i++)
                {
                    strSystemIds.Append(rgSystems.SelectedItems[i].Cells[2].Text);
                    strSystemIds.Append(",");
                }
                Systems.SystemsModel objSystemsModel = new Systems.SystemsModel();
                Systems.SystemsClient objSystemsClient = new Systems.SystemsClient();
                objSystemsModel.SystemIds = strSystemIds.ToString();
                objSystemsModel.SystemIds.Trim();
                objSystemsModel.SystemIds.Trim(',');
                objSystemsClient.DeleteSystems(objSystemsModel, SessionController.ConnectionString);
                BindSystem();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script3", "validate();", true);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void cmbfacility_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        try
        {
            ((CheckBox)e.Item.FindControl("CheckBox1")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgSystems_sortCommand(object sender, GridSortCommandEventArgs e)
    {
        GetSelectedRows();
        ViewState["SortExpression"] = e.SortExpression;
        if (e.NewSortOrder.ToString() == "Descending")
        {
            ViewState["SortExpression"] = ViewState["SortExpression"].ToString() + " DESC";
        }
    }

    #endregion

    #region Private Methods
    protected void show_hide_standards()
    {
        DataSet ds_TypeCount = new DataSet();

        DataSet ds = new DataSet();
        TypeModel tm = new TypeModel();
        TypeProfileClient tc = new TypeProfileClient();

        tm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
        tm.Flag = "type";
        tm.Txt_Search = "";
        ds_TypeCount = tc.bindtypepm_count_v1(tm, SessionController.ConnectionString);

        if (ds_TypeCount.Tables[2] != null)
        {
            if (ds_TypeCount.Tables[2].Rows.Count > 0)
            {
                for (int i = 0; i < ds_TypeCount.Tables[2].Rows.Count; i++)
                {
                    if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "MasterFormat")
                    {
                        Master_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                    }
                    else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "OmniClass 2010")
                    {
                        OmniClass_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                    }
                    else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "UniFormat")
                    {
                        UniFormat_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                    }
                    else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "UniClass")
                    {
                        UniClass_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                    }
                }
            }
            if (UniClass_flag != "")
            {
                hf_uniclass.Value = "Y";
            }
            else
            {
                hf_uniclass.Value = "N";
            }

        }

    }
    protected void ReSelectedRows()
    {
        try
        {
            foreach (GridDataItem item in rgSystems.Items)
            {
                string systems_id = Convert.ToString(item.GetDataKeyValue("SystemsId"));//item["Assetid"].Text;

                if (arrayList.Contains(systems_id.ToString()))
                {
                    item.Selected = true;

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    private void BindSystem()
    {
        try
        {
            show_hide_standards();

            //Telerik.Web.UI.RadComboBox objCmbFacility = (Telerik.Web.UI.RadComboBox)FacilityUserControlComboFacility.FindControl("cmbFacility");
            //UserControl.UserControlClient objUserControlClient = new UserControl.UserControlClient();
            Systems.SystemsModel objSystemsModel = new Systems.SystemsModel();
            Systems.SystemsClient objSystemsClient = new Systems.SystemsClient();
            System.Text.StringBuilder strFacilityIds = new System.Text.StringBuilder();

            foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
            {
                if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
                {
                    strFacilityIds.Append(rcbItem.Value);
                    strFacilityIds.Append(",");
                }
            }
            if (strFacilityIds.ToString().Length > 0)
            {
                strFacilityIds = strFacilityIds.Remove(strFacilityIds.ToString().Length - 1, 1);
            }

            objSystemsModel.FacilityIds = strFacilityIds.ToString();
            objSystemsModel.FacilityIds.Trim();
            objSystemsModel.FacilityIds.Trim(',');

            objSystemsModel.SearchText = txtcriteria.Text;
            DataSet ds = new DataSet();
            objSystemsModel.Pagesize = Int32.Parse(Convert.ToString(ViewState["PageSize"]));
            objSystemsModel.Pageindex = Int32.Parse(Convert.ToString(ViewState["PageIndex"]));
            objSystemsModel.Orderby = Convert.ToString(ViewState["SortExpression"]);
            ds = objSystemsClient.GetSystems(objSystemsModel, SessionController.ConnectionString);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    rgSystems.VirtualItemCount = Int32.Parse(ds.Tables[0].Rows[0]["system_count"].ToString());
                    ViewState["SystemCount"] = Int32.Parse(ds.Tables[0].Rows[0]["system_count"].ToString());
                }
            }

            rgSystems.AllowCustomPaging = true;
            rgSystems.AllowPaging = true;
            if (tempPageSize != "")
                rgSystems.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
           // rgSystems.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
            
            rgSystems.DataSource = ds;
            rgSystems.DataBind();
            if(hf_uniclass.Value != "")
            {
                if (hf_uniclass.Value == "Y")
                {
                    rgSystems.Columns[3].Visible = false;
                    rgSystems.Columns[4].Visible = true;
                }
                else
                {
                    rgSystems.Columns[3].Visible = true;
                    rgSystems.Columns[4].Visible = false;
                }
            
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void BindFacility()
    {
        try
        {
            DataSet ds_facility = new DataSet();
            FacilityClient locObj_crtl = new FacilityClient();
            FacilityModel locObj_mdl = new FacilityModel();
            //locObj_mdl.User_Id = new Guid(SessionController.Users_.UserId);
            locObj_mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
            locObj_mdl.Search_text_name = "";
            locObj_mdl.Doc_flag = "floor";
            ds_facility = locObj_crtl.GetFacilitiesPM(locObj_mdl, SessionController.ConnectionString);
            if (ds_facility.Tables[0].Rows.Count > 0)
            {
                cmbfacility.DataTextField = "name";
                cmbfacility.DataValueField = "pk_facility_id";
                cmbfacility.DataSource = ds_facility;
                cmbfacility.DataBind();
                string name = ds_facility.Tables[0].Rows[0]["name"].ToString();
                cmbfacility.Text = name;
            }

            //if (SessionController.Users_.IsFacility == "yes")
            //{
            //    cmbfacility.Visible = true;
            //    lblfacility.Visible = true;
            //    cmbfacility.SelectedValue = SessionController.Users_.facilityID;
            //    cmbfacility.Enabled = false;
            //}
            //else
            //{
            cmbfacility.Visible = true;
            lblFacility.Visible = true;
            cmbfacility.Enabled = true;
            //}

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

    protected void navigate(object sender, EventArgs e)
    {
        SessionController.Users_.facilityID = hf_facility_id.Value.ToString();
        Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + SessionController.Users_.facilityID, false);
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

            redirect_page("~\\app\\Loginpm.aspx?Error=Session");
        }

    }

    public void refresh(object sender, EventArgs e)
    {
        BindSystem();
    }

    public void redirect_page(string url)
    {
        Response.Redirect(url, false);
    }
}