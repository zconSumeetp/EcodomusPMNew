using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EcoDomus.Session;
using BIMModel;
using Telerik.Web.UI;
using Asset;
using Attributes;
using tmaAuthentication;
using WorkOrder;
using Facility;
using System.Configuration;

public partial class App_Settings_ModelViewerV1 : System.Web.UI.Page
{
    public string navis_class_id;
    DataSet ds_file = new DataSet();
    public static string FileId;
    string element_numeric_id;
    Guid asset_id;
    public static string attribute_value, table_name, group_name, attribute_name;
    string[] attributeids;


    //string testCon = "Data Source=208.83.233.66\\sqlexpress;Initial Catalog=EcoDomus_Central;User ID=sa;Password=ecodomus@123;Connect Timeout=50000000";
    //string ModelId = "250544";
    //string documentId = "ec0505fb-a2c4-4d1b-a046-0a721ad87b73";

    //string testCon = "Data Source=zconl-37\\SQL2008R2Express;Initial Catalog=EcoDomus_central;User ID=sa;Password=zcon@123;Connect Timeout=50000000";
    //string ModelId = "166873";
    //string documentId = "6633e4a4-f583-4e17-b702-84977acd299c";

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            DataSet ds = new DataSet();
            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            BIMModel.BIMModels mdl = new BIMModel.BIMModels();
            mdl.User_id = new Guid(SessionController.Users_.UserId);
            ds = BIMModelClient.GetViewerForUser(mdl, SessionController.ConnectionString);
            if (ds != null)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    navis_class_id = ds.Tables[0].Rows[0]["class_id"].ToString();
                    //navis_class_id = "CLSID:29877E00-BEC4-4A2D-B40E-5AB27F4A916C"; 
                }
                else
                {
                    navis_class_id = "CLSID:8A8F9690-5695-42D5-AD50-6FA695F8B634";      // New classid
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
        //navis_class_id = "CLSID:2B72955E-067A-4260-AEF5-44746A775C53";    // Old claasid
        //navis_class_id = "CLSID:8A8F9690-5695-42D5-AD50-6FA695F8B634";      // New classid
        //  navis_class_id = "CLSID:29877E00-BEC4-4A2D-B40E-5AB27F4A916C";//for2013
        try
        {
            if (!Page.IsPostBack)
            {
                if (SessionController.Users_.UserId != null)
                {
                    if (Request.QueryString["FileId"] != null && Request.QueryString["FileId"] != "0" && Request.QueryString["FileId"] != Guid.Empty.ToString() && Request.QueryString["FileId"] != "")
                    {
                        hf_client_con_string.Value = SessionController.ConnectionString;
                        hf_RestServiceUrl.Value = ConfigurationManager.AppSettings["RestServiceUrl"].ToString();
                        BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
                        BIMModel.BIMModels mdl = new BIMModel.BIMModels();

                        if (Request.QueryString["FileId"] != null)
                        {
                            if (Request.QueryString["FileId"].ToString().Equals("") == false)
                                FileId = Request.QueryString["FileId"].ToString();
                        }

                        //FileId = new Guid(Request.QueryString["FileId"].ToString());
                        mdl.File_id = new Guid(FileId);
                        ds_file = BIMModelClient.getuploadedfileinformation(mdl, SessionController.ConnectionString);
                        hf_file_id.Value = Convert.ToString(Request.QueryString["FileId"]);
                        hdnfacilityid.Value = Request.QueryString["facility_id"];

                        if (Request.QueryString["fk_master_file_id"] != null)
                        {
                            if (Request.QueryString["FileId"] != Request.QueryString["fk_master_file_id"])
                            {
                                FileId = Request.QueryString["fk_master_file_id"].ToString();
                                hf_file_id.Value = Request.QueryString["fk_master_file_id"].ToString();
                            }
                        }
                        string mappath;
                        mappath = "<p style='text-align: center'><object id='NWControl01'  width='100%' height='65%'  classid='" + navis_class_id + "' codebase='../../Bin/Navisworks ActiveX Redistributable Setup.exe' ><param name='_cx' value='30000'><param name='_cy' value='12500'>";
                        string temppath = "";
                        if (ds_file != null && ds_file.Tables.Count > 0 && ds_file.Tables[0].Rows.Count > 0)
                            temppath = Server.MapPath(ds_file.Tables[0].Rows[0]["file_path"].ToString().Substring(0) + "//" + ds_file.Tables[0].Rows[0]["file_name"].ToString());
                        //mappath = mappath + "<param name='SRC' value='" + Request.Url.GetLeftPart(UriPartial.Authority) + ds_file.Tables[0].Rows[0]["file_path"].ToString().Substring(1) + "/" + ds_file.Tables[0].Rows[0]["file_name"].ToString() + "'></object></p>";
                        mappath = mappath + "<param name='SRC' value='" + temppath + "'></object></p>";
                        ViewState["mappath"] = mappath;
                        divModel.InnerHtml = mappath;
                        //  if (Request.QueryString["element_numeric_id"] == null)
                        //  {
                        BindViewpoints();

                        Bind_Entity_To_Find_Asset();

                        //  }
                        //btnBack.Visible = true;
                        //if (Request.QueryString["name"] != null && Request.QueryString["name"] == "System")
                            //btnBack.Visible = false;

                        //radfrmdatepicker.SelectedDate = DateTime.Now.AddDays(-1);
                        //radtodatepicker.SelectedDate = DateTime.Now;
                        //get_conn_string();
                        bind_system_tree();
                    }

                }
                else
                {
                    Response.Redirect("~/App/LoginPM.aspx?Error=Session");
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
                }
            }
        }
        catch (Exception ex)
        {
            //throw ex;
        }


        //try
        //{
        //    if (SessionController.Users_.UserId == null)
        //    {
        //        Response.Redirect("~/App/LoginPM.aspx?Error=Session", true);
        //    }
        //    if (Request.QueryString["FileId"] != null)
        //    {
        //        FileId = Request.QueryString["FileId"].ToString();
        //    }
        //    DataSet ds = new DataSet();
        //    BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
        //    BIMModel.BIMModels mdl = new BIMModel.BIMModels();
        //    mdl.User_id = new Guid(SessionController.Users_.UserId);
        //    ds = BIMModelClient.GetViewerForUser(mdl, SessionController.ConnectionString);
        //    if (ds != null)
        //    {
        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            navis_class_id = ds.Tables[0].Rows[0]["class_id"].ToString();
        //        }
        //        else
        //        {
        //            navis_class_id = "CLSID:8A8F9690-5695-42D5-AD50-6FA695F8B634";      // New classid
        //        }
        //    }

        //}
        //catch (Exception ex)
        //{

        //    throw ex;
        //}

        //if (!IsPostBack)
        //{
        //    hdnfacilityid.Value = Request.QueryString["facility_id"];
        //    hf_file_id.Value = Convert.ToString(Request.QueryString["FileId"]);
        //    string mappath;
        //    mappath = "<p style='text-align: center'><object id='NWControl01'  width='100%' height='65%'  classid='" + navis_class_id + "' codebase='../../Bin/Navisworks ActiveX Redistributable Setup.exe' ><param name='_cx' value='30000'><param name='_cy' value='12500'>";

        //    string temppath = "";
        //    BIMModel.BIMModels mdl = new BIMModel.BIMModels();
        //    BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
        //    mdl.File_id = new Guid(FileId);
        //    ds_file = BIMModelClient.getuploadedfileinformation(mdl, SessionController.ConnectionString);
        //    if (ds_file != null && ds_file.Tables.Count > 0 && ds_file.Tables[0].Rows.Count > 0)
        //    {
        //        temppath = Server.MapPath(ds_file.Tables[0].Rows[0]["file_path"].ToString().Substring(0) + "//" + ds_file.Tables[0].Rows[0]["file_name"].ToString());
        //    }
        //    mappath = mappath + "<param name='SRC' value='" + temppath + "'></object></p>";
        //    divModel.InnerHtml = mappath;

        //    BindLeftPanel();

        //    BindRightPanel();
        //}
    }


    private void get_asset_impacts()
    {
        try
        {
            AssetClient obj_asset_client = new AssetClient();
            AssetModel obj_asset_model = new AssetModel();
            DataSet ds_impact = new DataSet();
            obj_asset_model.Asset_id = new Guid(hf_component_id.Value);
            obj_asset_model.Name = "";
            ds_impact = obj_asset_client.Get_impact(obj_asset_model, SessionController.ConnectionString);
            radgrdimpact.DataSource = ds_impact;
            radgrdimpact.DataBind();

            //if (ds_impact.Tables[0].Rows.Count > 0)
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "showimpactdock", "javascript:showimpactdock();", true);
            //}

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void radgrdimpact_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        get_asset_impacts();
    }

    protected void radgrdimpact_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        get_asset_impacts();
    }

    public void bind_room_data_sheet(Guid location_id)
    {
        BIMModels BIMModels = new BIMModels();
        BIMModelClient BIMModelClient = new BIMModelClient();
        DataSet ds = new DataSet();
        BIMModels.Location_Id = location_id;
        BIMModels.File_id = new Guid(FileId);
        ds = BIMModelClient.GetRoomDataSheet(BIMModels, SessionController.ConnectionString);
      
        if (ds != null)
        {
            if (ds.Tables.Count > 0)
            {
                rg_room_data_sheet.DataSource = ds;
                rg_room_data_sheet.DataBind();
            }
            else
            {
                rg_room_data_sheet.DataSource =string.Empty;
                rg_room_data_sheet.DataBind();
            }
        }
        
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>expand_room_data_sheet();</script>", false);
    }

    #region Left Panel

    public void BindLeftPanel()
    {
        BindViewpoints();
        Bind_Entity_To_Find_Asset();
        BindSelectedComponents();
        bind_system_tree();
    }


    public void Bind_Entity_To_Find_Asset()
    {
        try
        {
            BIMModelClient BIMModelClient = new BIMModelClient();
            BIMModels BIMModels = new BIMModels();
            DataSet ds = new DataSet();
            ds = BIMModelClient.GetEntityToSearchAssetModelViewer(BIMModels, SessionController.ConnectionString);
            //rdcmb_search_type.DataTextField = "entity_name";
            //rdcmb_search_type.DataValueField = "pk_entity_id";
            // rdcmb_search_type.DataSource = ds;
            //rdcmb_search_type.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }


    }

    protected void btnFindSpace_Click(object sender, EventArgs e)
    {
        BindSpaceForNavisViewer();
    }

    protected void BindSpaceForNavisViewer()
    {
        try
        {
            BIMModelClient BIMModelClient = new BIMModelClient();
            BIMModels BIMModels = new BIMModels();
            DataSet ds = new DataSet();
            BIMModels.File_id = new Guid(Request.QueryString["FileId"]);
            BIMModels.Search_criteria = "Name";
            BIMModels.Search_text = txtSearch.Text;
            ds = BIMModelClient.GetSpaceForNavisViewer(BIMModels, SessionController.ConnectionString);
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        //hf_location_id.Value = ds.Tables[0].Rows[0]["pk_location_id"].ToString();
                        rgSearchSpace.DataSource = ds;
                        rgSearchSpace.DataBind();
                    }
                }
                else
                {
                    rgSearchSpace.DataSource = string.Empty;
                    rgSearchSpace.DataBind();
                }
            }

            //else
            //{
            //    //hf_location_id.Value = "";
            //    rgSearchSpace.DataSource = ds;
            //    rgSearchSpace.DataBind();
            //}
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgSearchSpace_OnPageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindSpaceForNavisViewer();
    }
    protected void rgSearchSpace_OnPageIndexChanged(object sennder, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        BindSpaceForNavisViewer();
    }


    protected void btn_find_component_click(object sender, EventArgs e)
    {
        BindAssetForNavisViewer();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
    }

    protected void BindAssetForNavisViewer()
    {
        try
        {

            BIMModelClient BIMModelClient = new BIMModelClient();
            BIMModels BIMModels = new BIMModels();
            DataSet ds_asset = new DataSet();
            BIMModels.Entity_name = lbl_entity.Text;
            BIMModels.Search_by = "Name";
            BIMModels.Search_text = txtSearch.Text;
            BIMModels.File_id = new Guid(hf_file_id.Value);
            BIMModels.Fk_facility_id = new Guid(Request.QueryString["facility_id"]);
            ds_asset = BIMModelClient.Get_asset_navis_viewer(BIMModels, SessionController.ConnectionString);
            if (ds_asset != null)
            {
                if (ds_asset.Tables.Count > 0)
                {
                    if (ds_asset.Tables.Count > 0)
                    {
                        rg_search_data_new.DataSource = ds_asset;
                        rg_search_data_new.DataBind();
                    }
                }
                else
                {
                    rg_search_data_new.DataSource = string.Empty;
                    rg_search_data_new.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rg_search_data_new_OnPageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        BindAssetForNavisViewer();
        // bind_views_state_data();
    }
    protected void rg_search_data_new_OnPageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindAssetForNavisViewer();
        //bind_views_state_data();
    }
    public void BindViewpoints()
    {
        try
        {
            DataSet ds = new DataSet();
            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            BIMModel.BIMModels mdl = new BIMModel.BIMModels();
            mdl.File_id = new Guid(FileId);

            ds = BIMModelClient.getviewbyfileid(mdl, SessionController.ConnectionString);
            rtv_Viewpoints.DataTextField = "view_name";
            rtv_Viewpoints.DataValueField = "pk_view_id";
            rtv_Viewpoints.DataFieldParentID = "fk_view_id";
            rtv_Viewpoints.DataFieldID = "pk_view_id";
            rtv_Viewpoints.DataSource = ds;
            rtv_Viewpoints.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void BindSelectedComponents()
    {
        //DataSet ds = new DataSet();

        //System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(testCon);
        //con.Open();
        //string qry = "select 'VAV-001' as component_name, 'VAV w/Reheat 6in' as component_type";
        //qry += " Union all select 'VAV-337' as component_name, 'VAV w/Reheat 6in' as component_type";
        //qry += " Union all select 'PUMP-325' as component_name, 'Centrifugal Pump' as component_type";
        //qry += " Union all select 'PUMP-854' as component_name, 'Centrifugal Pump' as component_type";
        //qry += " Union all select 'VLV-052' as component_name, 'Valve, Backflow' as component_type";
        //qry += " Union all select 'VLV-212' as component_name, 'Valve, Backflow' as component_type";
        //qry += " Union all select 'VLV-852' as component_name, 'Valve, Backflow' as component_type";
        //qry += " Union all select 'Pump-5236' as component_name, 'Cent Pump' as component_type";
        //System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(qry, con);
        //System.Data.SqlClient.SqlDataAdapter da = new System.Data.SqlClient.SqlDataAdapter(cmd);
        //da.Fill(ds);
        //con.Close();

        //rd_selected_components.DataSource = ds;
        //rd_selected_components.DataBind();
    }

    public void bind_system_tree()
    {
        try
        {
            DataSet ds = new DataSet();
            BIMModels BIMModels = new BIMModel.BIMModels();
            BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            if (FileId == "")
            {
                BIMModels.File_id = Guid.Empty;
            }
            else
            {
                BIMModels.File_id = new Guid(FileId);

            }
            ds = BIMModelClient.getsystemsformodelviewer(BIMModels, SessionController.ConnectionString);
            rtv_System.DataFieldID = "pk_system_id";
            rtv_System.DataFieldParentID = "fk_parent_system_id";
            rtv_System.DataTextField = "name";
            rtv_System.DataValueField = "pk_system_id";
            rtv_System.DataSource = ds;

            rtv_System.DataBind();

            rtv_System.ExpandAllNodes();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnAddViewpoint_OnClick(object sender, EventArgs e)
    {

    }

    protected void btnAddWorkorder_OnClick(object sender, EventArgs e)
    {

    }

    protected void rtv_System_click(object source, RadTreeNodeEventArgs e)
    {
        try
        {
            string ElementNumericids = "";
            DataSet ds = new DataSet();
            string system_id = string.Empty;

            if (e.Node.Parent is RadTreeView)
            {
                foreach (RadTreeNode radnode in e.Node.Nodes)
                {
                    system_id = system_id + new Guid(radnode.Value) + ",";
                }
                system_id = system_id + (e.Node.Value) + ",";
                if (system_id.Length > 1)
                {
                    system_id = system_id.Substring(0, system_id.Length - 1);
                }
            }

            else if (e.Node.Parent is RadTreeNode)
            {

                system_id = e.Node.Value;
            }

            //  system_id = new Guid(rg_system.MasterTableView.DataKeyValues[e.Item.ItemIndex]["pk_system_id"].ToString());

            BIMModels BIMModels = new BIMModel.BIMModels();
            BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();

            if (Request.QueryString["facility_id"] == null)
            {
                DataSet ds1 = new DataSet();
                BIMModels.File_id = new Guid(FileId.ToString());
                ds1 = BIMModelClient.GetUploadedFileDetails(BIMModels, SessionController.ConnectionString);
                BIMModels.Fk_facility_id = new Guid(ds1.Tables[0].Rows[0]["fk_facility_id"].ToString());
            }
            else
            {
                BIMModels.Fk_facility_id = new Guid(Request.QueryString["facility_id"]);
            }

            BIMModels.System_id = system_id;
            ds = BIMModelClient.getsystemsassetsformodelviewer(BIMModels, SessionController.ConnectionString);

            rg_component.DataSource = ds;
            rg_component.DataBind();

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                if (dr["fk_external_system_data_id"].ToString() != "")
                    ElementNumericids = ElementNumericids + dr["fk_external_system_data_id"].ToString() + ",";
            }
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>jump_on_system_components('" + ElementNumericids + "');</script>", false);
            // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>open_sys_comp();</script>", false);
        }

        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

    #region Right Panel

    public void BindRightPanel()
    {
        BindComponentGrid();
        Bind_Type();
        //Bind_Documents("Asset", new Guid(documentId));
    }

    public void BindComponentGrid()
    {
        //DataSet ds = new DataSet();

        //BIMModels BIMModels = new BIMModels();
        //BIMModelClient BIMModelClient = new BIMModelClient();
        //BIMModels.File_id = new Guid(FileId);
        //BIMModels.Model_id = ModelId;
        //BIMModels.Asset_id = new Guid("00000000-0000-0000-0000-000000000000");
        //ds = BIMModelClient.getattributesformodelviewer(BIMModels, SessionController.ConnectionString);

        //rgcomponent.DataSource = ds;
        //rd_assigned_components.DataBind();
    }

    public void Bind_Type()
    {
        try
        {
            //BIMModels BIMModels = new BIMModels();
            //BIMModelClient BIMModelClient = new BIMModelClient();
            //DataSet ds = new DataSet();
            //BIMModels.File_id = new Guid(FileId);
            //BIMModels.Model_id = ModelId;
            //BIMModels.Asset_id = new Guid("00000000-0000-0000-0000-000000000000");

            //ds = BIMModelClient.GetTypeAttributesModelViewer(BIMModels, SessionController.ConnectionString);
            //rgtype.DataSource = ds;
            //rgtype.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //public void Bind_Documents(string flag, Guid asset_id)
    //{
    //    try
    //    {
    //        DataSet ds = new DataSet();
    //        BIMModels mdl = new BIMModels();
    //        BIMModelClient bmc = new BIMModelClient();
    //        mdl.Asset_id = asset_id;
    //        mdl.Flag = flag.Equals("Asset") ? "asset" : "space";
    //        ds = bmc.GetDocumentModelViewer(mdl, SessionController.ConnectionString);
    //        rd_document.DataSource = ds;
    //        rd_document.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    protected void rgcomponent_OnColumnCreated(object sender, GridColumnCreatedEventArgs e)
    {
        if (e.Column is GridGroupSplitterColumn)
        {
           // (e.Column as GridGroupSplitterColumn).ExpandImageUrl = "~/App/Images/Icons/asset_carrot_down.png";
            //(e.Column as GridGroupSplitterColumn).CollapseImageUrl = "~/App/Images/Icons/asset_carrot_up.png";
        }
    }
    protected void rgcomponent_OnItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridGroupHeaderItem)
        {
            GridGroupHeaderItem headerItem = e.Item as GridGroupHeaderItem;
            if (headerItem.Controls[0] is GridTableCell)
            {
                if (((GridTableCell)headerItem.Controls[0]).Text == "&nbsp;")
                {
                    ((GridTableCell)headerItem.Controls[0]).Controls[0].Visible = false;

                }
            }
        }
    }

    protected void rgcomponent_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            hf_assetTab.Value = lbl_components.Text;
            if ((hf_category.Value == "Floors") && lbl_components.Text == "Space")//|| hf_category.Value == "Generic Models"
            {
                try
                {

                    if (e.CommandName.Equals("Edit"))
                    {
                        attribute_value = rgcomponent.Items[e.Item.ItemIndex].Cells[5].Text;
                        table_name = rgcomponent.Items[e.Item.ItemIndex].Cells[8].Text; ;
                        group_name = rgcomponent.Items[e.Item.ItemIndex].Cells[7].Text;
                        attribute_name = rgcomponent.Items[e.Item.ItemIndex].Cells[4].Text;
                        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
                    }
                    if (e.CommandName.Equals("Update"))
                    {
                        BIMModelClient BIMModelClient = new BIMModelClient();
                        BIMModels BIMModels = new BIMModels();
                        GridEditableItem rgeditableItem = e.Item as GridEditableItem;
                        GridEditManager rgeditManager = rgeditableItem.EditManager;
                        GridUpdatedEventArgs ue;
                        DataSet ds = new DataSet();

                        foreach (GridColumn column in e.Item.OwnerTableView.RenderColumns)
                        {
                            if (column is IGridEditableColumn)
                            {
                                IGridEditableColumn editableCol = (column as IGridEditableColumn);
                                if (editableCol.IsEditable && editableCol.ColumnEditor != null)
                                {
                                    IGridColumnEditor editor = rgeditManager.GetColumnEditor(editableCol);

                                    string editorText = editableCol.Column.HeaderText.ToString();

                                    if (editor is GridTextColumnEditor)
                                    {
                                        if (editableCol.Column.HeaderText == "Parameter")
                                        {
                                            BIMModels.Attribute_name = (editor as GridTextColumnEditor).Text;
                                        }
                                        if (editableCol.Column.HeaderText == "Value")
                                        {
                                            BIMModels.Attribute_value = (editor as GridTextColumnEditor).Text;
                                        }
                                        if (editableCol.Column.HeaderText == "UOM")
                                        {
                                            editorText = (editor as GridTextColumnEditor).Text;
                                        }
                                    }
                                }
                            }
                        }



                        Guid UOM_id = new Guid();
                        Guid attribute_id = new Guid();
                        if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString() == "")
                        {
                            attribute_id = Guid.Empty;
                        }
                        else
                        {
                            attribute_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString());
                        }

                        if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString() == "")
                        {
                            UOM_id = Guid.Empty;
                        }
                        else
                        {
                            UOM_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString());
                        }

                        BIMModels.Attribute_name = attribute_name;
                        BIMModels.Pk_attribute_id = attribute_id;
                        BIMModels.Fk_row_id = Guid.Empty;
                        BIMModels.Table_name = table_name;
                        // BIMModels.Fk_facility_id = new Guid(Request.QueryString["facility_id"]);
                        BIMModels.User_id = new Guid(SessionController.Users_.UserId);
                        BIMModels.File_id = new Guid(FileId);
                        BIMModels.Fk_uom_id = UOM_id;
                        BIMModels.Model_id = PK_element_Numeric_ID.Value.ToString();
                        BIMModelClient.InsertUpdateSpaceAttributeForModelViewer(BIMModels, SessionController.ConnectionString);
                        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);

                    }
                    if (e.CommandName.Equals("Cancel"))
                    {
                        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
                    }

                    if (e.CommandName.Equals("delete"))
                    {
                        string attribute_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString();
                        AttributeModel mdl = new AttributeModel();
                        AttributeClient ctrl = new AttributeClient();
                        mdl.Entiy = "Space";
                        mdl.Entiy_data_id = new Guid(hf_component_id.Value);
                        mdl.Attribute_id = new Guid(attribute_id);
                        ctrl.DeleteAttribute(mdl, SessionController.ConnectionString);
                        BindProperties();
                    }

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            else
            {
                try
                {
                    if (e.CommandName.Equals("Edit"))
                    {
                        attribute_value = rgcomponent.Items[e.Item.ItemIndex].Cells[5].Text;
                        table_name = rgcomponent.Items[e.Item.ItemIndex].Cells[8].Text; ;
                        group_name = rgcomponent.Items[e.Item.ItemIndex].Cells[7].Text;
                        attribute_name = rgcomponent.Items[e.Item.ItemIndex].Cells[4].Text;

                        if (attribute_name == "Location")
                        {
                            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>OpenModelSpaces('" + hf_file_id.Value + "');</script>", false);
                            e.Canceled = true;
                        }
                        else
                        {
                            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
                        }
                    }
                    if (e.CommandName.Equals("Update"))
                    {

                        if (hf_component_id.Value.ToString() == Guid.Empty.ToString())
                        {

                            BIMModelClient BIMModelClient = new BIMModelClient();
                            BIMModels BIMModels = new BIMModels();
                            GridEditableItem rgeditableItem = e.Item as GridEditableItem;
                            GridEditManager rgeditManager = rgeditableItem.EditManager;
                            DataSet ds = new DataSet();

                            foreach (GridColumn column in e.Item.OwnerTableView.RenderColumns)
                            {
                                if (column is IGridEditableColumn)
                                {
                                    IGridEditableColumn editableCol = (column as IGridEditableColumn);
                                    if (editableCol.IsEditable && editableCol.ColumnEditor != null)
                                    {
                                        IGridColumnEditor editor = rgeditManager.GetColumnEditor(editableCol);

                                        string editorText = editableCol.Column.HeaderText.ToString();

                                        if (editor is GridTextColumnEditor)
                                        {

                                            if (editableCol.Column.HeaderText == "Parameter")
                                            {
                                                BIMModels.Attribute_name = (editor as GridTextColumnEditor).Text;
                                            }
                                            if (editableCol.Column.HeaderText == "Value")
                                            {
                                                //if (BIMModels.Attribute_value == null)
                                                //{

                                                //    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>ValidateAssetName();</script>", false);

                                                //}

                                                BIMModels.Attribute_value = (editor as GridTextColumnEditor).Text;
                                            }
                                            if (editableCol.Column.HeaderText == "UOM")
                                            {
                                                editorText = (editor as GridTextColumnEditor).Text;
                                            }
                                        }
                                    }
                                }
                            }

                            Guid UOM_id = new Guid();
                            Guid attribute_id = new Guid();
                            if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString() == "")
                            {
                                attribute_id = Guid.Empty;
                            }
                            else
                            {
                                attribute_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString());
                            }

                            if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString() == "")
                            {
                                UOM_id = Guid.Empty;
                            }
                            else
                            {
                                UOM_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString());
                            }
                            BIMModels.Attribute_name = attribute_name;
                            BIMModels.Pk_attribute_id = attribute_id;
                            BIMModels.Fk_row_id = Guid.Empty;
                            BIMModels.Table_name = table_name;
                            // BIMModels.Fk_facility_id = new Guid(Request.QueryString["facility_id"]);
                            //if (hf_TypeID_popup.Value != "")
                            //    BIMModels.Fk_type_id = new Guid(hf_TypeID_popup.Value);
                            BIMModels.User_id = new Guid(SessionController.Users_.UserId);
                            BIMModels.File_id = new Guid(FileId);
                            BIMModels.Fk_uom_id = UOM_id;
                            BIMModels.Model_id = PK_element_Numeric_ID.Value.ToString();
                            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>open_type_popup('" + attribute_name + "','" + attribute_id.ToString() + "','" + table_name + "','" + BIMModels.Attribute_value + "','" + UOM_id + "','" + PK_element_Numeric_ID.Value.ToString() + "');</script>", false);
                            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);

                        }

                        else
                        {


                            BIMModelClient BIMModelClient = new BIMModelClient();
                            BIMModels BIMModels = new BIMModels();
                            GridEditableItem rgeditableItem = e.Item as GridEditableItem;
                            GridEditManager rgeditManager = rgeditableItem.EditManager;
                            DataSet ds = new DataSet();

                            foreach (GridColumn column in e.Item.OwnerTableView.RenderColumns)
                            {
                                if (column is IGridEditableColumn)
                                {
                                    IGridEditableColumn editableCol = (column as IGridEditableColumn);
                                    if (editableCol.IsEditable && editableCol.ColumnEditor != null)
                                    {
                                        IGridColumnEditor editor = rgeditManager.GetColumnEditor(editableCol);

                                        string editorText = editableCol.Column.HeaderText.ToString();

                                        if (editor is GridTextColumnEditor)
                                        {
                                            if (editableCol.Column.HeaderText == "Parameter")
                                            {
                                                BIMModels.Attribute_name = (editor as GridTextColumnEditor).Text;
                                            }
                                            if (editableCol.Column.HeaderText == "Value")
                                            {

                                                BIMModels.Attribute_value = (editor as GridTextColumnEditor).Text;
                                            }
                                            if (editableCol.Column.HeaderText == "UOM")
                                            {
                                                editorText = (editor as GridTextColumnEditor).Text;
                                            }
                                        }
                                    }
                                }
                            }



                            Guid UOM_id = new Guid();
                            Guid attribute_id = new Guid();
                            if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString() == "")
                            {
                                attribute_id = Guid.Empty;
                            }
                            else
                            {
                                attribute_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString());
                            }

                            if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString() == "")
                            {
                                UOM_id = Guid.Empty;
                            }
                            else
                            {
                                UOM_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString());
                            }



                            BIMModels.Attribute_name = attribute_name;
                            BIMModels.Pk_attribute_id = attribute_id;
                            BIMModels.Fk_row_id = Guid.Empty;
                            BIMModels.Table_name = table_name;
                            // BIMModels.Fk_facility_id = new Guid(Request.QueryString["facility_id"]);
                            BIMModels.User_id = new Guid(SessionController.Users_.UserId);
                            BIMModels.File_id = new Guid(FileId);
                            BIMModels.Fk_uom_id = UOM_id;
                            BIMModels.Model_id = PK_element_Numeric_ID.Value.ToString();
                            BIMModelClient.InsertUpdateAssetAttributeForModelViewer(BIMModels, SessionController.ConnectionString);
                            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
                        }

                    }
                    if (e.CommandName.Equals("Cancel"))
                    {
                        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
                    }

                    if (e.CommandName.Equals("delete"))
                    {
                        string attribute_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString();
                        AttributeModel mdl = new AttributeModel();
                        AttributeClient ctrl = new AttributeClient();
                        mdl.Entiy = "Asset";
                        mdl.Entiy_data_id = new Guid(hf_component_id.Value);
                        mdl.Attribute_id = new Guid(attribute_id);
                        ctrl.DeleteAttribute(mdl, SessionController.ConnectionString);
                        BindProperties();
                    }
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

    protected void btn_refresh_asset_click(object sender, EventArgs e)
    {
        BindProperties();
        BindAssetForNavisViewer();

    }

    protected void rgcomponent_OnSortCommand(object sender, EventArgs e)
    {
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
    }
    protected void rgcomponent_OnPreRender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                foreach (GridDataItem item in rgcomponent.MasterTableView.Items)
                {
                    (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;
                    ImageButton btn = item.FindControl("imgbtnremove") as ImageButton;
                    if (btn != null)
                    {
                        btn.Enabled = false;
                    }
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rgcomponent_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {


            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                if (item["table_name"].Text == "tbl_asset_attribute")
                {
                    item["remove"].Visible = true;

                }
                else
                    item["remove"].Visible = false;

                if (item["parameter"].Text == "Area served" || item["parameter"].Text == "Archibus CMMS" || item["parameter"].Text == "TMA CMMS" || item["parameter"].Text == "Room" || item["parameter"].Text == "ARCHIBUS Link" || item["table_name"].Text == "tbl_system" || item["parameter"].Text == "Edited By")
                {
                    (item["EditCommandColumn"].Controls[0] as ImageButton).Visible = false;

                }

                item["parameter"].ToolTip = item["parameter"].Text.Replace("&nbsp;", "");
                item["Atrr_value"].ToolTip = item["Atrr_value"].Text.Replace("&nbsp;", "");
                item["Atrr_UOM"].ToolTip = item["Atrr_UOM"].Text.Replace("&nbsp;", "");

                if (item["parameter"].Text.Contains("TMA CMMS"))
                {

                    string URL = naviagatetotma();
                    item["Atrr_value"].Text = URL;

                }
                if (item["Atrr_value"].Text.Contains("http://"))
                {
                    int index = item["Atrr_value"].Text.IndexOf("target", 0) - 8;
                    string str = item["Atrr_value"].Text.Substring(8, index);
                    item["Atrr_value"].ToolTip = str;
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rgtype_OnColumnCreated(object sender, GridColumnCreatedEventArgs e)
    {
        if (e.Column is GridGroupSplitterColumn)
        {
            (e.Column as GridGroupSplitterColumn).ExpandImageUrl = "~/App/Images/Icons/asset_carrot_down.png";
            (e.Column as GridGroupSplitterColumn).CollapseImageUrl = "~/App/Images/Icons/asset_carrot_up.png";
        }
    }

    protected void rgtype_OnItemCreated(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridGroupHeaderItem)
        {
            GridGroupHeaderItem headerItem = e.Item as GridGroupHeaderItem;
            if (headerItem.Controls[0] is GridTableCell)
            {
                if (((GridTableCell)headerItem.Controls[0]).Text == "&nbsp;")
                {
                    ((GridTableCell)headerItem.Controls[0]).Controls[0].Visible = false;

                }
            }
        }
    }

    protected void rgtype_OnSortCommand(object sender, EventArgs e)
    {
        BindProperties();
        //bind_type_properties();
    }

    protected void rgtype_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName.Equals("Edit"))
            {
                attribute_value = rgtype.Items[e.Item.ItemIndex].Cells[5].Text;
                table_name = rgtype.Items[e.Item.ItemIndex].Cells[8].Text; ;
                group_name = rgtype.Items[e.Item.ItemIndex].Cells[7].Text;
                attribute_name = rgtype.Items[e.Item.ItemIndex].Cells[4].Text;
                if (attribute_name == "Manufacturer")
                {
                    string type_id;
                    type_id = rgtype.Items[e.Item.ItemIndex].Cells[10].Text;
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>openassignmanufacturer('" + type_id + "');</script>", false);
                    e.Canceled = true;
                }
                else
                {
                    bind_type_properties();
                }
                //bind_type_properties();
            }
            if (e.CommandName.Equals("Update"))
            {
                BIMModelClient BIMModelClient = new BIMModelClient();
                BIMModels BIMModels = new BIMModels();
                GridEditableItem rgeditableItem = e.Item as GridEditableItem;
                GridEditManager rgeditManager = rgeditableItem.EditManager;
                DataSet ds = new DataSet();

                foreach (GridColumn column in e.Item.OwnerTableView.RenderColumns)
                {
                    if (column is IGridEditableColumn)
                    {
                        IGridEditableColumn editableCol = (column as IGridEditableColumn);
                        if (editableCol.IsEditable && editableCol.ColumnEditor != null)
                        {
                            IGridColumnEditor editor = rgeditManager.GetColumnEditor(editableCol);

                            string editorText = editableCol.Column.HeaderText.ToString();

                            if (editor is GridTextColumnEditor)
                            {
                                if (editableCol.Column.HeaderText == "Parameter")
                                {
                                    BIMModels.Attribute_name = (editor as GridTextColumnEditor).Text;
                                }
                                if (editableCol.Column.HeaderText == "Value")
                                {
                                    BIMModels.Attribute_value = (editor as GridTextColumnEditor).Text;
                                }
                                if (editableCol.Column.HeaderText == "UOM")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                }
                            }
                        }
                    }
                }


                Guid UOM_id = new Guid();
                Guid attribute_id = new Guid();
                if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString() == "")
                {
                    attribute_id = Guid.Empty;
                }
                else
                {
                    attribute_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString());
                }

                if (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString() == "")
                {
                    UOM_id = Guid.Empty;
                }
                else
                {
                    UOM_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString());
                }



                BIMModels.Attribute_name = attribute_name;
                BIMModels.Pk_attribute_id = attribute_id;
                BIMModels.Fk_row_id = Guid.Empty;
                BIMModels.Table_name = table_name;
                // BIMModels.Fk_facility_id= new Guid(Request.QueryString["facility_id"]);
                BIMModels.User_id = new Guid(SessionController.Users_.UserId);
                BIMModels.File_id = new Guid(FileId);
                BIMModels.Fk_uom_id = UOM_id;
                ds = BIMModelClient.InsertUpdateTypeAttributeForModelViewer(BIMModels, SessionController.ConnectionString);
                bind_type_properties();

            }
            if (e.CommandName.Equals("Cancel"))
            {
                bind_type_properties();
            }

            if (e.CommandName.Equals("delete"))
            {
                string attribute_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString();
                AttributeModel mdl = new AttributeModel();
                AttributeClient ctrl = new AttributeClient();
                mdl.Entiy = "Type";
                mdl.Entiy_data_id = new Guid(hf_component_id.Value);
                mdl.Attribute_id = new Guid(attribute_id);
                ctrl.DeleteAttribute(mdl, SessionController.ConnectionString);
                BindProperties();
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    public void bind_type_properties()
    {
        try
        {
            BIMModels BIMModels = new BIMModels();
            BIMModelClient BIMModelClient = new BIMModelClient();
            DataSet ds = new DataSet();
            BIMModels.File_id = new Guid(hf_file_id.Value);
            BIMModels.Model_id = PK_element_Numeric_ID.Value;
            BIMModels.Asset_id = hdn_asset_id.Value == "" ? Guid.Empty : new Guid(hdn_asset_id.Value);

            ds = BIMModelClient.GetTypeAttributesModelViewer(BIMModels, SessionController.ConnectionString);
            rgtype.DataSource = ds;
            rgtype.DataBind();
            rgtype.Visible = true;


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void rgtype_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {


            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                if (item["table_name"].Text == "tbl_type_attribute")
                {
                    item["remove"].Visible = true;
                }
                else
                    item["remove"].Visible = false;

                item["parameter"].ToolTip = item["parameter"].Text.Replace("&nbsp;", "");
                // item[""
                item["Atrr_value"].ToolTip = item["Atrr_value"].Text.Replace("&nbsp;", "");
                item["Atrr_UOM"].ToolTip = item["Atrr_UOM"].Text.Replace("&nbsp;", "");

                if (item["Atrr_value"].Text.Contains("http://"))
                {
                    int index = item["Atrr_value"].Text.IndexOf("target", 0) - 8;
                    string str = item["Atrr_value"].Text.Substring(8, index);
                    item["Atrr_value"].ToolTip = str;
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rgtype_OnPreRender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                foreach (GridDataItem item in rgtype.MasterTableView.Items)
                {
                    (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;
                    ImageButton btn = item.FindControl("imgbtnremove") as ImageButton;
                    if (btn != null)
                    {
                        btn.Enabled = false;
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

   
    protected void btnAddDocument_OnClick(object sender, EventArgs e)
    {

    }

    protected void btn_properties_click(object sender, EventArgs e)
    {
        if (hf_category.Value.Equals("System"))
        {
            bind_document(new Guid(ViewState["selected_system_id"].ToString()), "System");
        }
        else
        {
            BindProperties();
        }
    }

    //private void BindProperties()
    //{
    //    try
    //    {
    //        BIMModelClient BIMModelClient = new BIMModelClient();
    //        BIMModels BIMModels = new BIMModels();
    //        DataSet ds = new DataSet();
    //        Guid pk_location_id = Guid.Empty;

    //        if (hf_category.Value == "Floors" || hf_layer.Value == "PLATFORM")//|| hf_category.Value == "Generic Models"
    //        {
    //            // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script12", "<script language='javascript'>selectAssetAttributeTab();</script>", false);
    //            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Script1", "<script type='text/javascript'>selectAssetAttributeTab();</script>", false);
    //            BIMModels.File_id = new Guid(Request.QueryString["FileId"].ToString());
    //            BIMModels.Model_id = PK_element_Numeric_ID.Value.ToString();
    //            ds = BIMModelClient.GetSpaceAttributeForNavisViewer(BIMModels, SessionController.ConnectionString);
    //            if (ds.Tables[0].Rows.Count > 0)
    //            {
    //                hf_location_id.Value = ds.Tables[0].Rows[0]["id"].ToString();
    //                hf_component_id.Value = hf_location_id.Value.ToString();
    //                pk_location_id = new Guid(hf_location_id.Value);

    //                hf_entity.Value = "Space";
    //                rgcomponent.DataSource = ds;
    //                rgcomponent.DataBind();
    //                hdnpropertystatus.Value = "property";
    //            }
    //            else
    //            {
    //                hf_component_id.Value = "";
    //                hf_entity.Value = "Space";
    //                rgcomponent.DataSource = ds;
    //                rgcomponent.DataBind();
    //                hdnpropertystatus.Value = "no property";

    //            }
    //            bind_room_data_sheet(pk_location_id);
    //            Bind_Documents("Space", pk_location_id);
    //            ViewState["Entity_Name"] = "Space";

    //        }
    //        else
    //        {
    //            BIMModels.File_id = new Guid(Request.QueryString["FileId"].ToString());
    //            BIMModels.Model_id = PK_element_Numeric_ID.Value;
    //            BIMModels.Asset_id = hdn_asset_id.Value == "" ? Guid.Empty : new Guid(hdn_asset_id.Value);

    //            //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script123", "<script language='javascript'>selectAssetAttributeTab();</script>", false);
    //            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Script2", "<script type='text/javascript'>selectAssetAttributeTab();</script>", false);
    //            ds = BIMModelClient.getattributesformodelviewer(BIMModels, SessionController.ConnectionString);

    //            if (ds.Tables[0].Rows.Count > 0)
    //            {
    //                hf_component_id.Value = ds.Tables[0].Rows[0]["asset_id"].ToString();
    //                hf_entity.Value = "Asset";
    //                rgcomponent.DataSource = ds;
    //                rgcomponent.DataBind();
    //                hdnpropertystatus.Value = "property";
    //            }
    //            else
    //            {
    //                hf_component_id.Value = "";
    //                hf_entity.Value = "Asset";
    //                rgcomponent.DataSource = ds;
    //                rgcomponent.DataBind();
    //                hdnpropertystatus.Value = "no property";

    //            }
    //            Bind_Type();

    //            if (hf_component_id.Value != "")
    //            {
    //                Bind_Documents("Asset", new Guid(hf_component_id.Value));
    //                get_asset_impacts();
    //            }
    //            else if (hf_component_id.Value == "")
    //            {
    //                Bind_Documents("Roofs", Guid.Empty);
    //            }
    //            ViewState["Entity_Name"] = "Asset";

    //            if (Request.QueryString["element_numeric_id"] == null)
    //            {
    //                //BindWorkOrders();

    //            }
    //        }
    //        hf_location_id.Value = "";
    //        if (SessionController.Users_.Permission_ds != null)
    //        {
    //            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
    //            {
    //                {
    //                    SetPermissions();
    //                }
    //            }
    //        }

    //        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
    //    }
    //    catch (Exception ex)
    //    {

    //        throw ex;
    //    }

    //}

    private void BindProperties()
    {
        try
        {
            BIMModelClient BIMModelClient = new BIMModelClient();
            BIMModels BIMModels = new BIMModels();
            DataSet ds = new DataSet();
            Guid pk_location_id = Guid.Empty;
            BindSpaceForNavisViewer();

            // bind sapce and hf_location_id
            if (hf_category.Value == "Floors" || hf_layer.Value == "PLATFORM")//|| hf_category.Value == "Generic Models"
            {
                //rdk_type.Closed = true;
                //rdk_system_attributes.Closed = true;
                //rdk_asset.Visible = true;
                //rdk_asset.Title = lblspace.Text;
                hf_assetTab.Value = lbl_components.Text;
                //rdk_type.Closed = true;

                //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>selectAssetAttributeTab();</script>", false);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Script2", "<script type='text/javascript'>selectAssetAttributeTab();</script>", false);

                BIMModels.File_id = new Guid(Request.QueryString["FileId"].ToString());
                BIMModels.Model_id = PK_element_Numeric_ID.Value.ToString();
                ds = BIMModelClient.GetSpaceAttributeForNavisViewer(BIMModels, SessionController.ConnectionString);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    //hf_component_id.Value = ds.Tables[0].Rows[0]["asset_id"].ToString(); //earlier correct
                    hf_location_id.Value = ds.Tables[0].Rows[0]["id"].ToString();
                    hf_component_id.Value = hf_location_id.Value.ToString();
                    pk_location_id = new Guid(hf_location_id.Value);

                    hf_entity.Value = "Space";
                    rgcomponent.DataSource = ds;
                    rgcomponent.DataBind();
                    hdnpropertystatus.Value = "property";
                }
                else
                {
                    hf_component_id.Value = "";
                    hf_entity.Value = "Space";
                    rgcomponent.DataSource = ds;
                    rgcomponent.DataBind();
                    hdnpropertystatus.Value = "no property";

                }

                bind_room_data_sheet(pk_location_id);

                bind_document(pk_location_id, "Space");
                ViewState["Entity_Name"] = "Space";

            }
            else
            {
                BIMModels.File_id = new Guid(hf_file_id.Value);
                BIMModels.Model_id = PK_element_Numeric_ID.Value;
                BIMModels.Asset_id = hdn_asset_id.Value == "" ? Guid.Empty : new Guid(hdn_asset_id.Value);

                //rdk_asset.Title = lblasset.Text;
                hf_assetTab.Value = lbl_components.Text;
                //rdk_asset.Closed = false;
                //rdk_type.Closed = false;
                //rdk_system_attributes.Closed = true;

                //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>selectAssetAttributeTab();</script>", false);
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Script2", "<script type='text/javascript'>selectAssetAttributeTab();</script>", false);
                ds = BIMModelClient.getattributesformodelviewer(BIMModels, SessionController.ConnectionString);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    hf_component_id.Value = ds.Tables[0].Rows[0]["asset_id"].ToString();
                    hf_entity.Value = "Asset";
                    rgcomponent.DataSource = ds;
                    rgcomponent.DataBind();
                    hdnpropertystatus.Value = "property";

                }
                else
                {
                    hf_component_id.Value = "";
                    hf_entity.Value = "Asset";
                    rgcomponent.DataSource = ds;
                    rgcomponent.DataBind();
                    hdnpropertystatus.Value = "no property";

                }
                bind_type_properties();
                //bind_document();
                if (hf_component_id.Value != "")
                {
                    bind_document(new Guid(hf_component_id.Value), "Asset");
                    get_asset_impacts();
                }
                else if (hf_component_id.Value == "")
                {
                    bind_document(Guid.Empty, "Roofs");
                }
                ViewState["Entity_Name"] = "Asset";

                if (Request.QueryString["element_numeric_id"] == null)
                {
                    BindWorkOrders();

                }

                //assettab.Selected = true;
                //Navis_attri_tab.SelectedIndex = 0;
                //attribute_tab.SelectedIndex = 0;

            }
            hf_location_id.Value = "";

            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    {
                        SetPermissions();
                    }
                }
            }
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void BindWorkOrders()
    {
        WorkOrderModel wm = new WorkOrderModel();
        WorkOrderClient wc = new WorkOrderClient();
        DataSet ds = new DataSet();
        try
        {
            wm.Fk_Asset_Id = hf_component_id.Value;
            wm.Criteria = "number";
            wm.Search = "";
            ds = wc.GetWorkOrder_Entity(wm, SessionController.ConnectionString);
            //radworkorder.DataSource = ds;
            //radworkorder.DataBind();

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void bind_document(Guid asset_id, string flag)
    {
        try
        {
            DataSet ds = new DataSet();
            BIMModels mdl = new BIMModels();
            BIMModelClient bmc = new BIMModelClient();
            mdl.Asset_id = asset_id;
            mdl.Flag = flag;
            ds = bmc.GetDocumentModelViewer(mdl, SessionController.ConnectionString);
            rgdocument.DataSource = ds;
            rgdocument.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgdocument_OnSortCommand(object sender, EventArgs e)
    {
        bind_document(new Guid(hf_component_id.Value), ViewState["Entity_Name"].ToString());
    }

    protected void rg_document_item_command(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "delete")
        {
            Guid document_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["document_id"].ToString());
            FacilityClient facObjClientCtrl = new FacilityClient();
            FacilityModel facObjFacilityModel = new FacilityModel();
            facObjFacilityModel.Facility_id = new Guid(Request.QueryString["facility_id"]);
            facObjFacilityModel.Document_Id = document_id;
            facObjClientCtrl.Delete_Document(facObjFacilityModel, SessionController.ConnectionString);
            bind_document(new Guid(hf_component_id.Value), ViewState["Entity_Name"].ToString());
        }
    }

    #endregion



    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='BIM Server'")[0];
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

        if (edit_permission == "N")
        {
            btn_search.Enabled = false;
            btn_groupSelection.Enabled = false;
            btnAddDocument.Enabled = false;
            foreach (GridDataItem item in rgcomponent.MasterTableView.Items)
            {
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;
            }

            foreach (GridDataItem item in rgtype.MasterTableView.Items)
            {
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;
            }
        }
        else
        {
            btn_search.Enabled = true;
            btn_groupSelection.Enabled = true;
            btnAddDocument.Enabled = true;
            foreach (GridDataItem item in rgcomponent.MasterTableView.Items)
            {
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = true;
            }

            foreach (GridDataItem item in rgtype.MasterTableView.Items)
            {
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = true;
            }
        }
    }


    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (lbl_entity.Text.Equals("Asset"))
            {
                rgSearchSpace.Visible = false;
                rg_search_data_new.Visible = true;
                BindAssetForNavisViewer();
            }
            if (lbl_entity.Text.Equals("Space"))
            {
                rg_search_data_new.Visible = false;
                rgSearchSpace.Visible = true;
                BindSpaceForNavisViewer();
            }
            if (lbl_entity.Text.Equals("Type"))
            {
                rgSearchSpace.Visible = false;
                rg_search_data_new.Visible = true;
                BindAssetForNavisViewer();
            }

            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rcm_entity_ItemClick(object sender, RadMenuEventArgs e)
    {

        DataSet ds = new DataSet();
        try
        {
            
                lbl_entity.Text = rcm_entity.SelectedItem.Text;

            
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    #region Private Methods
    private string naviagatetotma()
    {
        BIMModelClient BIMModelClient = new BIMModelClient();
        BIMModels BIMModels = new BIMModels();
        DataSet ds = new DataSet();
        BIMModels.Asset_id = new Guid(hf_component_id.Value);
        string loginURL = "";
        ds = BIMModelClient.GetExternalSystemAssetId(BIMModels, SessionController.ConnectionString);
        if (ds.Tables[0].Rows.Count > 0)
        {
            string pk = Convert.ToString(ds.Tables[0].Rows[0]["ext_asset_pk"]);
            tmaAuthentication.AuthenticationSoapClient auth = new AuthenticationSoapClient();
            string key1 = auth.GenerateKey("wade", "tma", "ecodomus");

            //wsAuthentication.Authentication auth = new wsAuthentication.Authentication();

            // string key = auth.GenerateKey("username", "password", "client name");

            loginURL = "<a href='http://208.83.232.98/webtma/default.aspx?key=" + key1;

            loginURL += "&DefaultURL=" + HttpUtility.UrlEncode("items/equipment.aspx?pk=" + pk) + "'target='_blank'>Profile link </a> ";

            //System.Diagnostics.Process.Start(loginURL);
            return loginURL;
        }
        // BindProperties();
        return loginURL = "";
    }
    #endregion
}