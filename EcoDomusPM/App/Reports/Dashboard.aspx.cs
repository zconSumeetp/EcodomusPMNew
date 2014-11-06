using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Dashboard;
using System.Data.SqlClient;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;
using BIMModel;
using Locations;
using Login;

public partial class App_Reports_Dashboard : System.Web.UI.Page
{
    Guid facility_id;
    Guid asset_id;
    Guid space_id;

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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
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
            if (SessionController.Users_.UserId != null)
            {
                if (hdnfaciliy_id.Value != "")
                {
                    SessionController.Users_.facilityID = hdnfaciliy_id.Value.ToString();
                    /*************************Insert into recent Assets******************************************/
                    LoginModel dm = new LoginModel();
                    LoginClient dc = new LoginClient();
                    dm.UserId = new Guid(SessionController.Users_.UserId.ToString());
                    dm.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
                    dm.entityName = "Facility";
                    dm.Row_id = SessionController.Users_.facilityID.ToString();
                    dc.InsertRecentUserData(dm);
                    /**********************************************************************************************/
                }
                if (!IsPostBack)
                {
                   

                    Get_recent_user_data();
                    LodaData();
                    BindNavigationTree();
                    Inbox();
                }
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Page_Load:- " + ex.Message.ToString();
        }
    }

   
    public void BindNavigationTree()
    {
        try
        {
            DataSet ds = new DataSet();
            DashboardClient obj_dash = new Dashboard.DashboardClient();
            DashboardModel mdl = new DashboardModel();

            mdl.OrganizationId = new Guid(SessionController.Users_.OrganizationID);
            mdl.User_id = new Guid(SessionController.Users_.UserId);
            mdl.ClientID = new Guid(SessionController.Users_.ClientID);
            mdl.System_role = SessionController.Users_.UserSystemRole.ToString();    
                                 
            ds = obj_dash.GetNavigationData(mdl, SessionController.ConnectionString);
            NavigationTree.DataTextField = "name";
            NavigationTree.DataValueField = "ID";
            NavigationTree.DataFieldParentID = "parent_id";
            NavigationTree.DataFieldID = "ID";
            NavigationTree.DataSource = ds;
            NavigationTree.DataBind();
        }
        catch (Exception ex)
        {
            lblMessage.Text = "BindNavigationTree:- " + ex.Message.ToString();
        }
    }

    private void Get_recent_user_data()
    {
        try
        {
            DataSet ds = new DataSet();
            DashboardClient obj_dash = new Dashboard.DashboardClient();
            DashboardModel mdl = new DashboardModel();
            mdl.User_id = new Guid(SessionController.Users_.UserId);
            ds = obj_dash.GetRecentData(mdl, SessionController.ConnectionString);
            rgFacility.DataSource = ds.Tables[0];
            rgFacility.DataBind();
            rg_assets.DataSource = ds.Tables[1];
            rg_assets.DataBind();
            rg_spaces.DataSource = ds.Tables[2];
            rg_spaces.DataBind();
        }
        catch (Exception ex)
        {
            lblMessage.Text = " Get_recent_user_data:-  " + ex.Message.ToString();
        }
    }

    protected void btn_search_Click(object sender, EventArgs e)
    {
        try
        {
           // SearchAssestData();
            SearchSpaceData();
        }
        catch (Exception ex)
        {
            lblMessage.Text = "btn_search_Click:- " + ex.Message.ToString();
        } 
        Response.Redirect(@"~\App\Reports\Search.aspx");
    }

    public void SearchAssestData()
    {
        //try
        //{
        //    string search_value;
        //    search_value = "='" + txt_result_asset.Text.Trim() + "'";
        //    if (cmb_search_condition_asset.SelectedItem.Text.Equals("Contains"))
        //    {
        //        search_value = "";
        //        search_value = "like '%" + txt_result_asset.Text.Trim() + "%'";
        //    }
        //    Session["Asset_Search_text"] = search_value;
        //    Session["Asset_search_col_name"] = cmb_assets.SelectedValue.ToString();
        //}
        //catch (Exception ex)
        //{
        //    throw ex;
        //}

    }

    
    public void SearchSpaceData()
    {
        //try
        //{
        //    string search_value;

        //    search_value = "='" + txt_result_spaces.Text.Trim() + "'";

        //    if (cmb_search_condition_spaces.SelectedItem.Text.Equals("Contains"))
        //    {
        //        search_value = "";
        //        search_value = "like '%" + txt_result_spaces.Text.Trim() + "%'";
        //    }
        //    Session["Space_Search_text"] = search_value;
        //    Session["Space_search_col_name"] = cmb_spaces.SelectedValue.ToString();

        //}
        //catch (Exception ex)
        //{
        //    throw ex;
        //}

        try
        {
            /***************************Asset***********************************************/
            string search_by_name_desc = "";
            string search_condition = "";

            search_by_name_desc = cmb_assets.SelectedValue.ToString();
            if (search_by_name_desc == "name")
            {
                search_by_name_desc = "name";
            }
            else if (search_by_name_desc == "description")
            {
                search_by_name_desc = "description";
            }
            search_condition = cmb_search_condition_asset.SelectedValue.ToString();
            if (search_condition == "equal to")
            {
                search_condition = search_by_name_desc + "=" + "\\" + txt_result_asset.Text.Trim() + "\\";
            }
            else if (search_condition == "contains")
            {
                search_condition = search_by_name_desc + "  " + "like\\%" + txt_result_asset.Text.Trim() + "%\\";
            }

            /********************************Space*************************************************/
            string search_by_name_desc_space = "";
            string search_condition_space = "";

            search_by_name_desc_space = cmb_spaces.SelectedValue.ToString();
            if (search_by_name_desc_space == "name")
            {
                search_by_name_desc_space = "name";
            }
            else if (search_by_name_desc_space == "description")
            {
                search_by_name_desc_space = "description";
            }

            search_condition_space = cmb_search_condition_spaces.SelectedValue.ToString();

            if (search_condition_space == "equal to")
            {
                search_condition_space = search_by_name_desc + "=" +"\\"+ txt_result_spaces.Text.Trim()+"\\";
            }
            else if (search_condition_space == "contains")
            {
                search_condition_space = search_by_name_desc +"  " +"like\\%" + txt_result_spaces.Text.Trim() + "%\\";
            }

            Response.Redirect("~/App/Reports/Search.aspx?Search_asset="+search_condition + "&Search_space=" + search_condition_space + "&facility_id=" + SessionController.Users_.facilityID.ToString());
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void LodaData()
    {
        try
        {
        DataSet ds = new DataSet();
        cmb_assets.Items.Clear();
        DashboardClient obj = new DashboardClient();
        ds = obj.GetSearchField(SessionController.ConnectionString);
        load_cmbassets(ref ds);
        load_cmbspaces(ref ds);
        }
        catch (Exception ex)
        {
            lblMessage.Text = "LodaData:- " + ex.Message.ToString();
        }
    }

    protected void load_cmbassets(ref DataSet ds)
    {
        try
        {
            cmb_assets.DataTextField = "name";
            cmb_assets.DataValueField = "value";
            cmb_assets.DataSource = ds;
            cmb_assets.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void load_cmbspaces(ref DataSet ds)
    {
        try
        {
            cmb_spaces.DataTextField = "name";
            cmb_spaces.DataValueField = "value";
            cmb_spaces.DataSource = ds;
            cmb_spaces.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void Inbox()
    {
        DataSet ds_inbox = new DataSet();
        DataTable dtInbox = new DataTable();
        DataColumn column = default(DataColumn);
        try
        {
            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "Object";
            dtInbox.Columns.Add(column);

            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "attribute";
            dtInbox.Columns.Add(column);

            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "changed_by";
            dtInbox.Columns.Add(column);

            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "changed_date";
            dtInbox.Columns.Add(column);

            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "System";
            dtInbox.Columns.Add(column);

            dtInbox.Rows.Add("Asset:VAV100", "Updated", "Igor Starkov", "Aug 14, 2011", "EcoDomus");
            dtInbox.Rows.Add("Asset:GWP-1", "Created", "Igor Starkov", "Aug 10, 2011", "EcoDomus");
            dtInbox.Rows.Add("Asset:AHU-1", "Created", "Igor Starkov", "Aug 10, 2011", "Maximo");
            dtInbox.Rows.Add("Space:Room1", "Geometry Change", "Igor Starkov", "Aug 9, 2011", "EcoDomus");
            rgInbox.DataSource = dtInbox;
            rgInbox.DataBind();
            rgInbox.MasterTableView.AllowAutomaticInserts = false;

        }
        catch (Exception ex)
        {
            lblMessage.Text = "Inbox: " + ex.Message.ToString();
        }

    }

    protected void rgInbox_OnPageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {
            Inbox();
        }
        catch (Exception)
        {
            
        }
    }

    protected void rgInbox_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            Inbox();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rgInbox_OnSortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            Inbox();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rgFacility_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "editFacility")
        {
            facility_id= new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["facility_id"].ToString());
            SessionController.Users_.facilityID = facility_id.ToString();
            SessionController.Users_.facilityName = rgFacility.Items[e.Item.ItemIndex].Cells[4].Text;
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId="+facility_id);
        }
    }

    protected void rg_assets_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        facility_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["facility_id"].ToString());
        SessionController.Users_.facilityID = facility_id.ToString();
        SessionController.Users_.facilityName = rgFacility.Items[e.Item.ItemIndex].Cells[4].Text;

        if (e.CommandName == "editAssets")
        {

            asset_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["asset_id"].ToString());
            Response.Redirect("~/App/Asset/AssetMenu.aspx?assetid=" + asset_id + "&pagevalue=AssetProfile");
        }
        if (e.CommandName == "Editfacility")
        {
          
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + facility_id);
        }
    }

    protected void rg_spaces_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        facility_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["facility_id"].ToString());
        SessionController.Users_.facilityID = facility_id.ToString();
        SessionController.Users_.facilityName = rgFacility.Items[e.Item.ItemIndex].Cells[4].Text;

        if (e.CommandName == "editSpaces")
        {
            space_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_location_id"].ToString());
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?pagevalue=Space Profile&id=" + space_id);
        }
        if (e.CommandName == "Editfacility")
        {
            
          
          
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + facility_id);
        }
    }
    
    // To create child placemarks on a placemark click
    protected void hf_btn_navigation_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            DashboardClient obj_dash = new Dashboard.DashboardClient();
            DashboardModel mdl = new DashboardModel();
            mdl.OrganizationId = new Guid(SessionController.Users_.OrganizationID);
            mdl.ParentID = new Guid(hf_ID.Value);
            ds = obj_dash.GetNavigationChildNodeData(mdl, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                string strIds = ds.Tables[0].Rows[0]["ID"].ToString();
                string strNames = ds.Tables[0].Rows[0]["Name"].ToString();
                string strLatitudes = ds.Tables[0].Rows[0]["lattitude"].ToString();
                string strLongitudes = ds.Tables[0].Rows[0]["Longitude"].ToString();
                string strAddresses = ds.Tables[0].Rows[0]["address"].ToString().Replace(',', '#');
                string strFlags = ds.Tables[0].Rows[0]["flag"].ToString();
                string strJavascriptFunction = "<script language='javascript' type='text/javascript'>setPlacemarksForChilds('" + strIds + "'," + "'" + strNames + "'," + "'" + strLatitudes + "','" + strLongitudes + "','" + strAddresses + "','" + strFlags + "');</script>";
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "script3", strJavascriptFunction, false);
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text ="hf_btn_navigation_Click: "+ ex.Message.ToString();
        }
    }

    protected void btnnavigate_click(object sender, EventArgs e)
    {

        SessionController.Users_.facilityID = hdnfaciliy_id.Value.ToString();


        BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
        BIMModels BIMModels = new BIMModel.BIMModels();
        BIMModels.File_id = new Guid(hdnfaciliy_id.Value);

        DataSet ds = BIMModelClient.GetsingleUploadedFile(BIMModels, SessionController.ConnectionString);
        string File_id = null;
        if (ds.Tables[0].Rows.Count > 0)
            File_id = ds.Tables[0].Rows[0]["pk_uploaded_file_id"].ToString();
        else
            File_id = "";

        ScriptManager.RegisterStartupScript(this, this.GetType(), "naviagate", "navigate('" + File_id + "');", true);

        

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        hdnfromserverside.Value = "FromServerSide";
        hdninitialize.Value = "initialize";
        //SessionController.Users_.facilityID = hdnfaciliy_id.Value.ToString();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "refresh", "setPlacemarksForRegion('" + hdnfaciliy_id.Value + "','" + latitude.Value + "','" + longitude.Value + "','" + strRegionName.Value + "','" + strFacilityflag.Value + "','" + strAddress.Value + "','" + strimage.Value + "','" + strColor.Value + "');", true);
        
    }
}