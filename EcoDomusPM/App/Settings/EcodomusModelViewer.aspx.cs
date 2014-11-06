using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asset;
using Attributes;
using BIMModel;
using EcoDomus.Session;
using Facility;
using Telerik.Web.UI;
using tmaAuthentication;
using WorkOrder;

namespace App.Settings
{
    public partial class EcodomusModelViewer : PageBase
    {
        public static string FileId;
        public static string FileIdMain;
        string _elementNumericId;
        DataSet _dsFile = new DataSet();
        public static string AttributeValue, TableName, GroupName, AttributeName;
        string[] _attributeIds;
        
        #region Page Events

        protected void Page_Prerender(object sender, EventArgs e)
        {
            SetPermissions();
        }

        private void SetPermissions()
        {
            if (!UserIsInRole("GU")) return;

            var btn = Page.FindControl("btn_search") as ImageButton;
            if (btn != null)
            {
                btn.Enabled = false;
            }
        }

        private static bool UserIsInRole(string role)
        {
            return String.Equals(SessionController.Users_.UserSystemRole, role, StringComparison.CurrentCultureIgnoreCase);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                return;
            }

            if (SessionController.Users_.UserId != null)
            {
                if (Request.QueryString["FileId"] == null || Request.QueryString["FileId"] == "0" ||
                    Request.QueryString["FileId"] == Guid.Empty.ToString() || Request.QueryString["FileId"] == "")
                {
                    return;
                }

                hf_client_con_string.Value = SessionController.ConnectionString;
                hf_RestServiceUrl.Value = ConfigurationManager.AppSettings["RestServiceUrl"];
                var bimModelClient = new BIMModelClient();
                var bimModels = new BIMModels();

                if (Request.QueryString["FileId"] != null)
                {
                    hf_file_id.Value = Convert.ToString(Request.QueryString["FileId"]);
                    FileId = Request.QueryString["FileId"];
                    FileIdMain = Request.QueryString["FileId"];
                    hf_file_id_main.Value = FileIdMain;
                }
                
                bimModels.File_id = new Guid(FileId);
                _dsFile = 
                    (Request.QueryString["history_flag"] == "Y") 
                        ? bimModelClient.getuploadedfileinformation_for_history(bimModels, SessionController.ConnectionString) 
                        : bimModelClient.getuploadedfileinformation(bimModels, SessionController.ConnectionString);
                hdnfacilityid.Value = Request.QueryString["facility_id"];
                
                if (Request.QueryString["FileId"] != Request.QueryString["fk_master_file_id"])
                {
                    FileId = Request.QueryString["fk_master_file_id"];
                    hf_file_id.Value = Request.QueryString["fk_master_file_id"];
                    FileIdMain = Request.QueryString["FileId"];
                    hf_file_id_main.Value = FileIdMain;
                }
                
                var tempPath = "";

                if (_dsFile != null && _dsFile.Tables.Count > 0 && _dsFile.Tables[0].Rows.Count > 0)
                {
                    tempPath = _dsFile.Tables[0].Rows[0]["file_path"].ToString().Substring(_dsFile.Tables[0].Rows[0]["file_path"].ToString().LastIndexOf('~') + 1) + "/" + _dsFile.Tables[0].Rows[0]["file_name"];

                    if (Request.Url.Host == "localhost")
                    {
                        tempPath = String.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Host, tempPath);
                    }
                }
                
                ScriptManager.RegisterStartupScript(this, GetType(), "Script", "LoadModel('" + tempPath + "');", true);
                BindParentViewDropdown();
                BindViewpoints();
                BindEntityToFindAsset();
                btnBack.Visible = true;

                if (Request.QueryString["name"] != null && Request.QueryString["name"] == "System")
                {
                    btnBack.Visible = false;
                }

                radfrmdatepicker.SelectedDate = DateTime.Now.AddDays(-1);
                radtodatepicker.SelectedDate = DateTime.Now;
                BindSystemGrid();
            }
            else
            {
                Response.Redirect("~/App/LoginPM.aspx?Error=Session");
            }
        }

        #endregion

        #region Private Methods

        private string Naviagatetotma()
        {
            var bimModelClient = new BIMModelClient();
            var bimModels = new BIMModels {Asset_id = new Guid(hf_component_id.Value)};
            var dataSetExternalSystemAssetId = bimModelClient.GetExternalSystemAssetId(bimModels, SessionController.ConnectionString);

            if (dataSetExternalSystemAssetId.Tables[0].Rows.Count <= 0)
            {
                return String.Empty;
            }

            var pk = Convert.ToString(dataSetExternalSystemAssetId.Tables[0].Rows[0]["ext_asset_pk"]);
            var authenticationSoapClient = new AuthenticationSoapClient();
            var key1 = authenticationSoapClient.GenerateKey("wade", "tma", "ecodomus");
            
            var loginUrl = "<a href='http://208.83.232.98/webtma/default.aspx?key=" + key1;
            loginUrl += "&DefaultURL=" + HttpUtility.UrlEncode("items/equipment.aspx?pk=" + pk) + "'target='_blank'>Profile link</a>";

            return loginUrl;
        }

        private void BindProperties()
        {
            var bimModelClient = new BIMModelClient();
            var bimModels = new BIMModels();
            DataSet ds;
            var pkLocationId = Guid.Empty;
            BindSpaceForNavisViewer();

            if (hf_category.Value == "Floors" || hf_category.Value == "Generic Models")
            {
                rdk_asset.Closed = false;
                rdk_type.Closed = true;
                rdk_system_attributes.Closed = true;
                rdk_asset.Title = lblspace.Text;

                bimModels.File_id = new Guid(FileId);
                bimModels.Model_id = PK_element_Numeric_ID.Value;
                ds = bimModelClient.GetSpaceAttributeForNavisViewer(bimModels, SessionController.ConnectionString);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    //hf_location_id.Value = ds.Tables[0].Rows[0]["id"].ToString();
                    hf_component_id.Value = hf_location_id.Value;
                    pkLocationId = new Guid(hf_location_id.Value);
                    hf_entity.Value = "Space";
                    rgcomponent.DataSource = ds;
                    rgcomponent.DataBind();
                }
                else
                {
                    hf_component_id.Value = String.Empty;
                    hf_entity.Value = "Space";
                    rgcomponent.DataSource = ds;
                    rgcomponent.DataBind();
                }

                if (pkLocationId != Guid.Empty)
                {
                    BindRoomDataSheet(pkLocationId);
                }
                
                BindDocument(pkLocationId, "Space");
                ViewState["Entity_Name"] = "Space";
            }
            else
            {
                bimModels.File_id = new Guid(FileId);
                bimModels.Model_id = PK_element_Numeric_ID.Value;
                rdk_asset.Title = lblasset.Text;

                rdk_asset.Closed = false;
                rdk_type.Closed = false;
                rdk_system_attributes.Closed = true;

                bimModels.Asset_id = hdn_asset_id.Value == String.Empty ? Guid.Empty : new Guid(hdn_asset_id.Value);
                ds = bimModelClient.getattributesformodelviewer(bimModels, SessionController.ConnectionString);

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
                    hf_component_id.Value = String.Empty;
                    hf_entity.Value = "Asset";
                    rgcomponent.DataSource = ds;
                    rgcomponent.DataBind();
                    hdnpropertystatus.Value = "no property";
                }

                BindTypeProperties();
                
                if (hf_component_id.Value != String.Empty)
                {
                    BindDocument(new Guid(hf_component_id.Value), "Asset");
                    GetAssetImpacts();
                }
                else if (hf_component_id.Value == String.Empty)
                {
                    BindDocument(Guid.Empty, "Roofs");
                }

                ViewState["Entity_Name"] = "Asset";

                if (Request.QueryString["element_numeric_id"] == null)
                {
                    BindWorkOrders();
                }
            }

            hf_location_id.Value = String.Empty;
        }

        private void BindViewpoints()
        {
            var bimModelClient = new BIMModelClient();

            var bimModels = new BIMModels
            {
                File_id = 
                    (Request.QueryString["FileId"] != null) 
                        ? new Guid(Request.QueryString["FileId"]) 
                        : Guid.Empty
            };

            var ds = bimModelClient.getviewbyfileid_ecodomusviewer(bimModels, SessionController.ConnectionString); 
            Treeview_Views.DataTextField = "view_name";
            Treeview_Views.DataValueField = "pk_view_id";
            Treeview_Views.DataFieldParentID = "fk_view_id";
            Treeview_Views.DataFieldID = "pk_view_id";
            Treeview_Views.DataSource = ds;
            Treeview_Views.DataBind();
        }

        private void BindSystemProperties(string systemId)
        {
            var bimModelClient = new BIMModelClient();
            var bimModels = new BIMModels {System_id = systemId};
            var ds = bimModelClient.get_system_attributes_for_modelviewer(bimModels, SessionController.ConnectionString);
            rgSystemAttributes.DataSource = ds;
            rgSystemAttributes.DataBind();
        }

        public void BindSystemGrid()
        {
            var bimModelClient = new BIMModelClient();
            var bimModels = new BIMModels {File_id = (FileId == String.Empty) ? Guid.Empty : new Guid(FileId)};

            var ds = bimModelClient.getsystemsformodelviewer(bimModels, SessionController.ConnectionString);
            radtreeviewsystem.DataFieldID = "pk_system_id";
            radtreeviewsystem.DataFieldParentID = "fk_parent_system_id";
            radtreeviewsystem.DataTextField = "name";
            radtreeviewsystem.DataValueField = "pk_system_id";
            radtreeviewsystem.DataSource = ds;
            radtreeviewsystem.DataBind();
            radtreeviewsystem.ExpandAllNodes();
        }

        public void BindRoomDataSheet(Guid locationId)
        {
            var clientId = new Guid(SessionController.Users_.ClientID);
            var bimModelClient = new BIMModelClient();
            var modelViewerSourceId = new Guid(FileId);
            var assets = bimModelClient.GetAssetsForLocation(locationId, modelViewerSourceId, clientId);
            rg_room_data_sheet.DataSource = assets.Items;
            rg_room_data_sheet.DataBind();

            ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>open_space_popup();</script>", false);
        }

        public void BindTypeProperties()
        {
            var bimModelClient = new BIMModelClient();

            var bimModels = new BIMModels
            {
                File_id = new Guid(FileId),
                Model_id = PK_element_Numeric_ID.Value,
                Asset_id = hdn_asset_id.Value == String.Empty ? Guid.Empty : new Guid(hdn_asset_id.Value)
            };

            var ds = bimModelClient.GetTypeAttributesModelViewer(bimModels, SessionController.ConnectionString);
            hf_type_id.Value = ds.Tables[0].Rows[0]["asset_id"].ToString();
            rgtype.DataSource = ds;
            rgtype.DataBind();
            rgtype.Visible = true;
        }
        
        public DataSet BindBasInformation()
        {
            var ds = new DataSet();

            if (SessionController.Users_.UserId != null)
            {
                var bimModelClient = new BIMModelClient();
                var bimModels = new BIMModels
                {
                    External_asset_id = PK_element_Numeric_ID.Value,
                    File_id = (FileId == String.Empty || FileId == "0") ? Guid.Empty : new Guid(FileId)
                };

                ds = bimModelClient.GetAssetAttributeHistoryForBAS(bimModels, SessionController.ConnectionString);
            }
            else
            {
                Response.Redirect(@"~\app\Login.aspx?Error=Session");
            }

            return ds;
        }

        public void BindEntityToFindAsset()
        {
            var bimModelClient = new BIMModelClient();
            var bimModels = new BIMModels();
            var ds = bimModelClient.GetEntityToSearchAssetModelViewer(bimModels, SessionController.ConnectionString);
            rdcmb_search_type.DataTextField = "entity_name";
            rdcmb_search_type.DataValueField = "pk_entity_id";
            rdcmb_search_type.DataSource = ds;
            rdcmb_search_type.DataBind();
        }

        private void BindWorkOrders()
        {
            var workOrderClient = new WorkOrderClient();

            var workOrderModel = new WorkOrderModel
            {
                Fk_Asset_Id = hf_component_id.Value,
                Criteria = "number",
                Search = String.Empty
            };

            var ds = workOrderClient.GetWorkOrder_Entity(workOrderModel, SessionController.ConnectionString);
            radworkorder.DataSource = ds;
            radworkorder.DataBind();
        }

        #endregion

        #region   Event Handlers
        
        protected void rgtype_OnItemCreated(object sender, GridItemEventArgs e)
        {
            if (!(e.Item is GridGroupHeaderItem))
            {
                return;
            }

            var headerItem = e.Item as GridGroupHeaderItem;

            if (!(headerItem.Controls[0] is GridTableCell))
            {
                return;
            }

            if (((GridTableCell)headerItem.Controls[0]).Text == @"&nbsp;")
            {
                headerItem.Controls[0].Controls[0].Visible = false;
            }
        }

        protected void rgtype_OnColumnCreated(object sender, GridColumnCreatedEventArgs e)
        {
            if (!(e.Column is GridGroupSplitterColumn))
            {
                return;
            }

            e.Column.Visible = false;
            e.Column.HeaderStyle.Width = Unit.Pixel(0);
            e.Column.HeaderStyle.HorizontalAlign = HorizontalAlign.Left;
            e.Column.ItemStyle.Width = Unit.Pixel(0);
        }

        protected void rgcomponent_OnItemCreated(object sender, GridItemEventArgs e)
        {
            if (!(e.Item is GridGroupHeaderItem))
            {
                return;
            }

            var headerItem = e.Item as GridGroupHeaderItem;

            if (!(headerItem.Controls[0] is GridTableCell))
            {
                return;
            }

            if (((GridTableCell)headerItem.Controls[0]).Text == @"&nbsp;")
            {
                headerItem.Controls[0].Controls[0].Visible = false;
            }
        }

        protected void rgcomponent_OnColumnCreated(object sender, GridColumnCreatedEventArgs e)
        {
            if (!(e.Column is GridGroupSplitterColumn))
            {
                return;
            }

            e.Column.Visible = false;
            e.Column.HeaderStyle.Width = Unit.Pixel(0);
            e.Column.HeaderStyle.HorizontalAlign = HorizontalAlign.Left;
            e.Column.ItemStyle.Width = Unit.Pixel(0);
        }

        protected void rgcomponent_OnPreRender(object sender, EventArgs e)
        {
            if (SessionController.Users_.UserSystemRole != "GU")
            {
                return;
            }

            foreach (GridDataItem item in rgcomponent.MasterTableView.Items)
            {
                var imageButton = item["EditCommandColumn"].Controls[0] as ImageButton;

                if (imageButton != null)
                {
                    imageButton.Enabled = false;
                }

                imageButton = item.FindControl("imgbtnremove") as ImageButton;

                if (imageButton != null)
                {
                    imageButton.Enabled = false;
                }
            }
        }

        protected void rgtype_OnPreRender(object sender, EventArgs e)
        {
            if (SessionController.Users_.UserSystemRole != "GU")
            {
                return;
            }

            foreach (GridDataItem item in rgtype.MasterTableView.Items)
            {
                var imageButton = item["EditCommandColumn"].Controls[0] as ImageButton;

                if (imageButton != null)
                {
                    imageButton.Enabled = false;
                }

                imageButton = item.FindControl("imgbtnremove") as ImageButton;

                if (imageButton != null)
                {
                    imageButton.Enabled = false;
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/App/Settings/BIMServer.aspx", false);
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            BindDocument(new Guid(hf_component_id.Value), ViewState["Entity_Name"].ToString());
        }

        protected void btn_properties_click(object sender, EventArgs e)
        {
            if (hf_category.Value.Equals("System"))
            {
                BindDocument(new Guid(ViewState["selected_system_id"].ToString()), "System");
            }
            else
            {
                BindProperties();
            }
        }

        protected void BindAssetForNavisViewer()
        {
            var bimModelClient = new BIMModelClient();

            var bimModels = new BIMModels
            {
                Entity_name = rdcmb_search_type.SelectedItem.Text,
                Search_by = rdcmb_search_by.SelectedValue,
                Search_text = txt_search.Text,
                File_id = new Guid(FileId),
                Fk_facility_id = new Guid(Request.QueryString["facility_id"])
            };
            
            var dsAsset = bimModelClient.Get_asset_navis_viewer(bimModels, SessionController.ConnectionString);
            ViewState["dataset"] = dsAsset;

            if (dsAsset.Tables.Count <= 0)
            {
                return;
            }

            rg_search_data_new.DataSource = dsAsset;
            rg_search_data_new.DataBind();
        }

        protected void BindSpaceForNavisViewer()
        {
            var bimModelClient = new BIMModelClient();

            var bimModels = new BIMModels
            {
                File_id = new Guid(FileId),
                Search_criteria = rdCmbSearchCriteria.SelectedValue,
                Search_text = txtSearchSpace.Text
            };

            var ds = bimModelClient.GetSpaceForNavisViewer(bimModels, SessionController.ConnectionString);
            
            if (ds.Tables[0].Rows.Count > 0)
            {
                rgSearchSpace.DataSource = ds;
                rgSearchSpace.DataBind();
            }
            else
            {
                rgSearchSpace.DataSource = ds;
                rgSearchSpace.DataBind();
            }
        }

        protected void btn_find_component_click(object sender, EventArgs e)
        {
            BindAssetForNavisViewer();
        }
        
        protected void btnFindSpace_Click(object sender, EventArgs e)
        {
            BindSpaceForNavisViewer();
        }

        protected void rdcmb_search_type_selectedindexchanged(object sender, EventArgs e)
        {
            if (rdcmb_search_type.SelectedIndex > 0)
            {
                rdcmb_search_by.SelectedIndex = 0;
            }
        }

        protected void radtreeviewsystem_click(object source, RadTreeNodeEventArgs e)
        {
            var elementNumericids = String.Empty;
            var systemId = String.Empty;

            if (e.Node.Parent is RadTreeView)
            {
                var idsList = 
                    (
                        from RadTreeNode radnode 
                        in e.Node.Nodes 
                        select radnode.Value
                    ).ToList();

                idsList.Add(e.Node.Value);

                systemId = String.Join(",", idsList);
            }
            
            if (e.Node.Parent is RadTreeNode)
            {
                systemId = e.Node.Value;
            }

            rdk_asset.Closed = true;
            rdk_type.Closed = true;
            rdk_system_attributes.Closed = false;
            ViewState["selected_system_id"] = e.Node.Value;
            BindSystemProperties(e.Node.Value);
            BindDocument(new Guid(e.Node.Value), "System");

            var bimModels = new BIMModels();
            var bimModelClient = new BIMModelClient();

            if (Request.QueryString["facility_id"] == null)
            {
                bimModels.File_id = new Guid(FileId);
                var ds1 = bimModelClient.GetUploadedFileDetails(bimModels, SessionController.ConnectionString);
                bimModels.Fk_facility_id = new Guid(ds1.Tables[0].Rows[0]["fk_facility_id"].ToString());
            }
            else
            {
                bimModels.Fk_facility_id = new Guid(Request.QueryString["facility_id"]);
            }

            bimModels.System_id = systemId;
            var ds = bimModelClient.getsystemsassetsformodelviewer(bimModels, SessionController.ConnectionString);

            rg_component.DataSource = ds;
            rg_component.DataBind();

            elementNumericids = ds.Tables[0].Rows.Cast<DataRow>().Aggregate(elementNumericids, (current, dr) => current + dr["fk_external_system_data_id"] + ",");
            ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>jump_on_system_components('" + elementNumericids + "');</script>", false);
        }

        protected void rgSearchSpace_ItemCommand(object source, GridCommandEventArgs e)
        {
            _elementNumericId = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["fk_external_space_id"].ToString();
            ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>jump_on_comp('" + _elementNumericId + "');</script>", false);
        }

        protected void rg_comp_sensor_OnNeedDataSource(object source, GridNeedDataSourceEventArgs e)
        {
            var strKey = rg_comp_sensor.MasterTableView.Items.Cast<GridDataItem>().Where(item => item.Selected).Aggregate(String.Empty, (current, item) => current + item.GetDataKeyValue("pk_asset_attribute_id") + ",");
            _attributeIds = strKey.Split(',');
            rg_comp_sensor.DataSource = BindBasInformation();
        }

        public void Timer1_Tick(object sender, EventArgs e)
        {
            rg_comp_sensor.Rebind();

            foreach (GridDataItem gridDataItem in rg_comp_sensor.MasterTableView.Items)
            {
                foreach (var attributeId in _attributeIds)
                {
                    if (gridDataItem.GetDataKeyValue("pk_asset_attribute_id").ToString() == attributeId)
                    {
                        gridDataItem.Selected = true;
                    }
                }
            }
        }

        protected void rgtype_OnItemCommand(object sender, GridCommandEventArgs e)
        {
            var commandName = e.CommandName;

            Guid attributeId;
            switch (commandName)
            {
                case "Edit":
                    AttributeValue = rgtype.Items[e.Item.ItemIndex].Cells[5].Text;
                    TableName = rgtype.Items[e.Item.ItemIndex].Cells[8].Text;
                    GroupName = rgtype.Items[e.Item.ItemIndex].Cells[7].Text;
                    AttributeName = rgtype.Items[e.Item.ItemIndex].Cells[4].Text;
                    
                    if (AttributeName == "Manufacturer")
                    {
                        var typeId = rgtype.Items[e.Item.ItemIndex].Cells[10].Text;
                        ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>openassignmanufacturer('" + typeId + "');</script>", false);
                        e.Canceled = true;
                    }
                    else
                    {
                        BindTypeProperties();
                    }
                    break;

                case "Update":
                    var bimModelClient = new BIMModelClient();
                    var bimModels = new BIMModels();
                    var gridEditableItem = e.Item as GridEditableItem;

                    if (gridEditableItem != null)
                    {
                        var editManager = gridEditableItem.EditManager;
                    
                        foreach (var gridColumn in e.Item.OwnerTableView.RenderColumns)
                        {
                            if (!(gridColumn is IGridEditableColumn))
                            {
                                continue;
                            }

                            var gridEditableColumn = gridColumn as IGridEditableColumn;

                            if (!gridEditableColumn.IsEditable || gridEditableColumn.ColumnEditor == null)
                            {
                                continue;
                            }

                            var editor = editManager.GetColumnEditor(gridEditableColumn);

                            if (!(editor is GridTextColumnEditor))
                            {
                                continue;
                            }

                            switch (gridEditableColumn.Column.HeaderText)
                            {
                                case @"Parameter":
                                    bimModels.Attribute_name = (editor as GridTextColumnEditor).Text;
                                    break;

                                case @"Value":
                                    bimModels.Attribute_value = (editor as GridTextColumnEditor).Text;
                                    break;
                            }
                        }

                        attributeId = (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString() != String.Empty) 
                            ? new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString()) 
                            : Guid.Empty;

                        var uomId = 
                            (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString() != String.Empty)
                                ? new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString()) 
                                : Guid.Empty;

                        bimModels.Attribute_name = AttributeName;
                        bimModels.Pk_attribute_id = attributeId;
                        bimModels.Fk_row_id = Guid.Empty;
                        bimModels.Table_name = TableName;
                        bimModels.User_id = new Guid(SessionController.Users_.UserId);
                        bimModels.File_id = new Guid(FileId);
                        bimModels.Fk_uom_id = uomId;
                        bimModelClient.InsertUpdateTypeAttributeForModelViewer(bimModels, SessionController.ConnectionString);
                    }

                    BindTypeProperties();
                    break;

                case "Cancel":
                    BindTypeProperties();
                    break;

                case "delete":
                    attributeId = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString());
                    var attributeClient = new AttributeClient();

                    var attributeModel = new AttributeModel
                    {
                        Entiy = "Type",
                        Entiy_data_id = new Guid(hf_component_id.Value),
                        Attribute_id = attributeId
                    };

                    attributeClient.DeleteAttribute(attributeModel, SessionController.ConnectionString);
                    BindProperties();
                    break;
            }
        }

        protected void rgcomponent_OnItemCommand(object sender, GridCommandEventArgs e)
        {
            if ((hf_category.Value == "Floors" || hf_category.Value == "Generic Models") && rdk_asset.Text == "Space")
            {
                Guid attributeId;

                switch (e.CommandName)
                {
                    case "Edit":
                        AttributeValue = rgcomponent.Items[e.Item.ItemIndex].Cells[5].Text;
                        TableName = rgcomponent.Items[e.Item.ItemIndex].Cells[8].Text;
                        GroupName = rgcomponent.Items[e.Item.ItemIndex].Cells[7].Text;
                        AttributeName = rgcomponent.Items[e.Item.ItemIndex].Cells[4].Text;
                        ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
                        break;

                    case "Update":
                        var bimModelClient = new BIMModelClient();
                        var bimModels = new BIMModels();
                        var gridEditableItem = e.Item as GridEditableItem;

                        if (gridEditableItem != null)
                        {
                            var editManager = gridEditableItem.EditManager;
                        
                            foreach (var gridColumn in e.Item.OwnerTableView.RenderColumns)
                            {
                                if (!(gridColumn is IGridEditableColumn))
                                {
                                    continue;
                                }

                                var editableColumn = gridColumn as IGridEditableColumn;

                                if (!editableColumn.IsEditable || editableColumn.ColumnEditor == null)
                                {
                                    continue;
                                }

                                var editor = editManager.GetColumnEditor(editableColumn);

                                if (!(editor is GridTextColumnEditor))
                                {
                                    continue;
                                }

                                switch (editableColumn.Column.HeaderText)
                                {
                                    case @"Parameter":
                                        bimModels.Attribute_name = (editor as GridTextColumnEditor).Text;
                                        break;

                                    case @"Value":
                                        bimModels.Attribute_value = (editor as GridTextColumnEditor).Text;
                                        break;
                                }
                            }
                        }

                        attributeId = (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString() != String.Empty) 
                            ? new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString()) 
                            : Guid.Empty;

                        var uomId = 
                            (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString() != String.Empty)
                                ? new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString()) 
                                : Guid.Empty;

                        bimModels.Attribute_name = AttributeName;
                        bimModels.Pk_attribute_id = attributeId;
                        bimModels.Fk_row_id = Guid.Empty;
                        bimModels.Table_name = TableName;
                        bimModels.User_id = new Guid(SessionController.Users_.UserId);
                        bimModels.File_id = new Guid(FileId);
                        bimModels.Fk_uom_id = uomId;
                        bimModels.Model_id = PK_element_Numeric_ID.Value;
                        bimModelClient.InsertUpdateSpaceAttributeForModelViewer(bimModels, SessionController.ConnectionString);

                        ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
                        break;

                    case "Cancel":
                        ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
                        break;

                    case "delete":
                        attributeId = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString());
                        var attributeClient = new AttributeClient();
                        var attributeModel = new AttributeModel
                        {
                            Entiy = "Space",
                            Entiy_data_id = new Guid(hf_component_id.Value),
                            Attribute_id = attributeId
                        };
                        attributeClient.DeleteAttribute(attributeModel, SessionController.ConnectionString);
                        BindProperties();
                        break;
                }
            }
            else
            {
                switch (e.CommandName)
                {
                    case "Edit":
                        AttributeValue = rgcomponent.Items[e.Item.ItemIndex].Cells[5].Text;
                        TableName = rgcomponent.Items[e.Item.ItemIndex].Cells[8].Text;
                        GroupName = rgcomponent.Items[e.Item.ItemIndex].Cells[7].Text;
                        AttributeName = rgcomponent.Items[e.Item.ItemIndex].Cells[4].Text;
                        if (AttributeName == "Location")
                        {
                            ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>OpenModelSpaces('" + hf_file_id.Value + "');</script>", false);
                            e.Canceled = true;
                        }
                        else
                        {
                            ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
                        }
                        break;

                    case "Update":
                    {
                        var bimModels = new BIMModels();
                        var gridEditableItem = e.Item as GridEditableItem;

                        if (gridEditableItem != null)
                        {
                            var editManager = gridEditableItem.EditManager;
                        
                            foreach (var gridColumn in e.Item.OwnerTableView.RenderColumns)
                            {
                                if (!(gridColumn is IGridEditableColumn))
                                {
                                    continue;
                                }

                                var gridEditableColumn = gridColumn as IGridEditableColumn;

                                if (!gridEditableColumn.IsEditable || gridEditableColumn.ColumnEditor == null)
                                {
                                    continue;
                                }

                                var editor = editManager.GetColumnEditor(gridEditableColumn);

                                if (!(editor is GridTextColumnEditor))
                                {
                                    continue;
                                }

                                switch (gridEditableColumn.Column.HeaderText)
                                {
                                    case @"Parameter":
                                        bimModels.Attribute_name = (editor as GridTextColumnEditor).Text;
                                        break;

                                    case @"Value":
                                        bimModels.Attribute_value = (editor as GridTextColumnEditor).Text;
                                        break;
                                }
                            }
                        }

                        var attributeId = 
                            (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString() != String.Empty)
                                ? new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString()) 
                                : Guid.Empty;

                        var uomId = 
                            (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString() != String.Empty)
                                ? new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_unit_of_measurement_id"].ToString()) 
                                : Guid.Empty;

                        bimModels.Attribute_name = AttributeName;
                        bimModels.Pk_attribute_id = attributeId;
                        bimModels.Fk_row_id = Guid.Empty;
                        bimModels.Table_name = TableName;
                        bimModels.User_id = new Guid(SessionController.Users_.UserId);
                        bimModels.File_id = new Guid(FileId);
                        bimModels.Fk_uom_id = uomId;
                        bimModels.Model_id = PK_element_Numeric_ID.Value;
                        //BIMModelClient.InsertUpdateAssetAttributeForModelViewer(BIMModels, SessionController.ConnectionString);
                        ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>open_type_popup('" + AttributeName + "','" + attributeId + "','" + TableName + "','" + bimModels.Attribute_value + "','" + uomId + "','" + PK_element_Numeric_ID.Value + "');</script>", false);
                        ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
                    }
                        break;

                    case "Cancel":
                        ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
                        break;

                    case "delete":
                    {
                        var attributeId = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString();
                        var attributeClient = new AttributeClient();
                        var attributeModel = new AttributeModel
                        {
                            Entiy = "Asset",
                            Entiy_data_id = new Guid(hf_component_id.Value),
                            Attribute_id = new Guid(attributeId)
                        };
                        attributeClient.DeleteAttribute(attributeModel, SessionController.ConnectionString);
                        BindProperties();
                    }
                        break;
                }
            }
        }

        protected void rgcomponent_OnSortCommand(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>Bind_asset();</script>", false);
        }

        protected void rgtype_OnSortCommand(object sender, EventArgs e)
        {
            BindTypeProperties();
        }

        protected void rgdocument_OnSortCommand(object sender, EventArgs e)
        {
            BindDocument(new Guid(hf_component_id.Value), ViewState["Entity_Name"].ToString());
        }

        protected void rgSearchSpace_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
        {
            BindSpaceForNavisViewer();
        }

        protected void rgSearchSpace_OnPageIndexChanged(object sennder, GridPageChangedEventArgs e)
        {
            BindSpaceForNavisViewer();
        }

        protected void rg_search_data_new_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
        {
            BindAssetForNavisViewer();
        }

        protected void rg_search_data_new_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
        {
            BindAssetForNavisViewer();
        }

        public bool IsDate(string date)
        {
            DateTime dateTime;
            return DateTime.TryParse(date, out dateTime);
        }

        protected void Update_Click(object sender, EventArgs e)
        {
        }

        protected void btn_refresh_asset_click(object sender, EventArgs e)
        {
            BindProperties();
            BindAssetForNavisViewer();
        }

        protected void rgcomponent_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            if (!(e.Item is GridDataItem))
            {
                return;
            }

            var gridDataItem = (GridDataItem) e.Item;

            gridDataItem["remove"].Visible = (gridDataItem["table_name"].Text == @"tbl_asset_attribute");

            if (gridDataItem["parameter"].Text == @"Area served" || gridDataItem["parameter"].Text == @"Archibus CMMS" || gridDataItem["parameter"].Text == @"TMA CMMS" || gridDataItem["parameter"].Text == @"Room" || gridDataItem["parameter"].Text == @"ARCHIBUS Link" || gridDataItem["table_name"].Text == @"tbl_system" || gridDataItem["parameter"].Text == @"Edited By")
            {
                var imageButton = gridDataItem["EditCommandColumn"].Controls[0] as ImageButton;
                if (imageButton != null)
                {
                    imageButton.Visible = false;
                }
            }

            gridDataItem["parameter"].ToolTip = gridDataItem["parameter"].Text.Replace("&nbsp;", String.Empty);
            gridDataItem["Atrr_value"].ToolTip = gridDataItem["Atrr_value"].Text.Replace("&nbsp;", String.Empty);
            gridDataItem["Atrr_UOM"].ToolTip = gridDataItem["Atrr_UOM"].Text.Replace("&nbsp;", String.Empty);

            if (gridDataItem["parameter"].Text.Contains("TMA CMMS"))
            {
                var url = Naviagatetotma();
                gridDataItem["Atrr_value"].Text = url;
            }

            if (gridDataItem["Atrr_value"].Text.Contains("http://"))
            {
                var index = gridDataItem["Atrr_value"].Text.IndexOf("target", 0, StringComparison.OrdinalIgnoreCase) - 8;
                var toolTip = gridDataItem["Atrr_value"].Text.Substring(8, index);
                gridDataItem["Atrr_value"].ToolTip = toolTip;
            }
        }

        protected void rgtype_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            if (!(e.Item is GridDataItem))
            {
                return;
            }

            var gridDataItem = (GridDataItem)e.Item;

            gridDataItem["remove"].Visible = (gridDataItem["table_name"].Text == @"tbl_type_attribute");

            gridDataItem["parameter"].ToolTip = gridDataItem["parameter"].Text.Replace("&nbsp;", String.Empty);
            gridDataItem["Atrr_value"].ToolTip = gridDataItem["Atrr_value"].Text.Replace("&nbsp;", String.Empty);
            gridDataItem["Atrr_UOM"].ToolTip = gridDataItem["Atrr_UOM"].Text.Replace("&nbsp;", String.Empty);

            if (gridDataItem["Atrr_value"].Text.Contains("http://"))
            {
                var index = gridDataItem["Atrr_value"].Text.IndexOf("target", 0, StringComparison.OrdinalIgnoreCase) - 8;
                var toolTip = gridDataItem["Atrr_value"].Text.Substring(8, index);
                gridDataItem["Atrr_value"].ToolTip = toolTip;
            }
        }

        protected void rgSystemAttributes_OnItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Update")
            {
                var bimModelClient = new BIMModelClient();
                var bimModels = new BIMModels();

                var gridEditableItem = e.Item as GridEditableItem;

                if (gridEditableItem != null)
                {
                    var editManager = gridEditableItem.EditManager;

                    foreach (var gridColumn in e.Item.OwnerTableView.RenderColumns)
                    {
                        if (!(gridColumn is IGridEditableColumn))
                        {
                            continue;
                        }

                        var gridEditableColumn = gridColumn as IGridEditableColumn;

                        if (!gridEditableColumn.IsEditable || gridEditableColumn.ColumnEditor == null)
                        {
                            continue;
                        }

                        var editor = editManager.GetColumnEditor(gridEditableColumn);

                        if (gridEditableColumn.Column.HeaderText == Resources.Resource.Value)
                        {
                            var gridTextColumnEditor = editor as GridTextColumnEditor;
                            if (gridTextColumnEditor != null)
                            {
                                bimModels.Attribute_value = gridTextColumnEditor.Text;
                            }
                        }
                    }
                }

                bimModels.Pk_attribute_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_system_attribute_id"].ToString());
                bimModels.Attribute_name = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["attribute_name"].ToString();
                bimModels.System_id = ViewState["selected_system_id"].ToString();
                bimModelClient.update_system_attribute_for_modelviewer(bimModels, SessionController.ConnectionString);
            }

            BindSystemProperties(ViewState["selected_system_id"].ToString());
        }

        protected void rgSystemAttributes_OnColumnCreated(object sender, GridColumnCreatedEventArgs e)
        {
            if (!(e.Column is GridGroupSplitterColumn))
            {
                return;
            }

            e.Column.Visible = false;
            e.Column.HeaderStyle.Width = Unit.Pixel(0);
            e.Column.HeaderStyle.HorizontalAlign = HorizontalAlign.Left;
            e.Column.ItemStyle.Width = Unit.Pixel(0);
        }

        protected void rgSystemAttributes_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            if (!(e.Item is GridDataItem))
            {
                return;
            }

            var gridDataItem = (GridDataItem)e.Item;
            gridDataItem["parameter"].ToolTip = gridDataItem["parameter"].Text.Replace("&nbsp;", String.Empty);
            gridDataItem["Atrr_value"].ToolTip = gridDataItem["Atrr_value"].Text.Replace("&nbsp;", String.Empty);
        }

        protected void rgSystemAttributes_OnPreRender(object sender, EventArgs e)
        {
            if (SessionController.Users_.UserSystemRole != "GU")
            {
                return;
            }

            foreach (GridDataItem item in rgcomponent.MasterTableView.Items)
            {
                var imageButton = item["EditCommandColumn"].Controls[0] as ImageButton;

                if (imageButton != null)
                {
                    imageButton.Enabled = false;
                }

                imageButton = item.FindControl("imgbtnremove") as ImageButton;

                if (imageButton != null)
                {
                    imageButton.Enabled = false;
                }
            }
        }

        private void GetAssetImpacts()
        {
            var assetClient = new AssetClient();
            var assetModel = new AssetModel {Asset_id = new Guid(hf_component_id.Value), Name = String.Empty};
            var dsImpact = assetClient.Get_impact(assetModel, SessionController.ConnectionString);
            radgrdimpact.DataSource = dsImpact;
            radgrdimpact.DataBind();
        }
        
        protected void BindDocument(Guid assetId, string flag)
        {
            var bimModelClient = new BIMModelClient();
            var bimModels = new BIMModels {Asset_id = assetId, Flag = flag};
            var ds = bimModelClient.GetDocumentModelViewer(bimModels, SessionController.ConnectionString);
            rgdocument.DataSource = ds;
            rgdocument.DataBind();
        }

        protected void rg_document_item_command(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName != "delete")
            {
                return;
            }

            var documentId = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["document_id"].ToString());
            var facilityClient = new FacilityClient();

            var facilityModel = new FacilityModel
            {
                Facility_id = new Guid(Request.QueryString["facility_id"]),
                Document_Id = documentId
            };

            facilityClient.Delete_Document(facilityModel, SessionController.ConnectionString);
            BindDocument(new Guid(hf_component_id.Value), ViewState["Entity_Name"].ToString());
        }

        protected void radgrdimpact_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
        {
            GetAssetImpacts();
        }

        protected void radgrdimpact_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
        {
            GetAssetImpacts();
        }

        protected void btn_system_assets_Click(object sender, EventArgs e)
        {
            var systemId = hdnsystemid.Value;
            var elementNumericids = String.Empty;
            var bimModels = new BIMModels();
            var bimModelClient = new BIMModelClient();

            if (Request.QueryString["facility_id"] == null)
            {
                bimModels.File_id = new Guid(FileId);
                var ds1 = bimModelClient.GetUploadedFileDetails(bimModels, SessionController.ConnectionString);
                bimModels.Fk_facility_id = new Guid(ds1.Tables[0].Rows[0]["fk_facility_id"].ToString());
            }
            else
            {
                bimModels.Fk_facility_id = new Guid(Request.QueryString["facility_id"]);
            }

            bimModels.System_id = systemId;
            var ds = bimModelClient.getsystemsassetsformodelviewer(bimModels, SessionController.ConnectionString);

            rg_component.DataSource = ds;
            rg_component.DataBind();

            elementNumericids = ds.Tables[0].Rows.Cast<DataRow>().Aggregate(elementNumericids, (current, dr) => current + dr["fk_external_system_data_id"].ToString() + ",");
            ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>jump_on_system_components('" + elementNumericids + "');</script>", false);
        }

        #endregion

        public void RedirectPage(string url)
        {
            Response.Redirect(url, false);
        }

        protected void btn_upload_server_Click(object sender, EventArgs e)
        {
            BindViewpoints();
            BindParentViewDropdown();
        }

        private void BindParentViewDropdown()
        {
            var bimModelClient = new BIMModelClient();
            var bimModels = new BIMModels {File_id = new Guid(FileIdMain)};
            var ds = bimModelClient.Bind_parent_view_dropdown_ecodomus_viewer(bimModels, SessionController.ConnectionString);
            
            if (ds.Tables[0].Rows.Count <= 0)
            {
                return;
            }

            cmb_parentView.DataTextField = "view_name";
            cmb_parentView.DataValueField = "pk_view_id";
            cmb_parentView.DataSource = ds;
            cmb_parentView.DataBind();
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (FileId == null || FileId == "0")
            {
                return;
            }

            var bimModelClient = new BIMModelClient();

            var bimModels = new BIMModels
            {
                View_Name = txt_ViewName.Text,
                Parent_id =
                    cmb_parentView.SelectedValue != String.Empty
                        ? new Guid(cmb_parentView.SelectedValue)
                        : Guid.Empty,
                File_id = new Guid(FileIdMain),
                Positionx = hf_positionx.Value,
                Positiony = hf_positiony.Value,
                Positionz = hf_positionz.Value,
                Targetx = hf_targetx.Value,
                Targety = hf_targety.Value,
                Targetz = hf_targetz.Value,
                Upx = hf_upx.Value,
                Upy = hf_upy.Value,
                Upz = hf_upz.Value,
                Pk_view_id = Guid.Empty,
                Width = hf_width.Value,
                Height = hf_height.Value
            };
            
            bimModelClient.InsertUpdateViewEcoDomusViewer(bimModels, SessionController.ConnectionString);
            BindViewpoints();
            BindParentViewDropdown();
            txt_ViewName.Text = String.Empty;
        }

        protected void Treeview_Views_OnNodeClick(object source, RadTreeNodeEventArgs e)
        {
            var viewName = e.Node.Text;
            
            var bimModelClient = new BIMModelClient();
            var bimModels = new BIMModels {View_Name = viewName, File_id = new Guid(FileIdMain)};

            var ds = bimModelClient.GetViewInfoEcoDomusViewer(bimModels, SessionController.ConnectionString);
            
            if (ds.Tables[0].Rows.Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>jump_on_selected_view('" + viewName + "','" + ds.Tables[0].Rows[0]["positionx"] + "','" + ds.Tables[0].Rows[0]["positiony"] + "','" + ds.Tables[0].Rows[0]["positionz"] + "','" + ds.Tables[0].Rows[0]["targetx"] + "','" + ds.Tables[0].Rows[0]["targety"] + "','" + ds.Tables[0].Rows[0]["targetz"] + "','" + ds.Tables[0].Rows[0]["upx"] + "','" + ds.Tables[0].Rows[0]["upy"] + "','" + ds.Tables[0].Rows[0]["upz"] + "','" + ds.Tables[0].Rows[0]["width"] + "','" + ds.Tables[0].Rows[0]["height"] + "');</script>", false);
            }
        }

        protected void Treeview_Views_NodeEdit(object sender, RadTreeNodeEditEventArgs e)
        {
            var radTreeNode = e.Node;
            var newText = e.Text;
            radTreeNode.Text = newText;

            var bimModelClient = new BIMModelClient();

            var bimModels = new BIMModels
            {
                View_Name = newText,
                Pk_view_id = new Guid(e.Node.Value),
                Flag = "Update"
            };

            bimModelClient.EditDeleteViewEcoDomusViewer(bimModels, SessionController.ConnectionString);
            BindParentViewDropdown();
        }

        protected void Treeview_Views_ContextMenuItemClick(object sender, RadTreeViewContextMenuEventArgs e)
        {
            switch (e.MenuItem.Value)
            {
                case "Delete":
                    var bimModelClient = new BIMModelClient();
                    var radTreeNode = e.Node;
                    var newText = radTreeNode.Text;
                    var bimModels = new BIMModels
                    {
                        View_Name = newText,
                        Pk_view_id = new Guid(e.Node.Value),
                        Flag = "Delete"
                    };
                    bimModelClient.EditDeleteViewEcoDomusViewer(bimModels, SessionController.ConnectionString);
                    BindViewpoints();
                    BindParentViewDropdown();
                    break;
            }
        }

        protected void btn_setcolor_Click(object sender, EventArgs e)
        {
            var externalids = String.Empty;
            var colorvalues = String.Empty;
            var bimModels = new BIMModels();
            var bimModelClient = new BIMModelClient();
            bimModels.Fk_facility_id = new Guid(Request.QueryString["facility_id"]);
            var ds = bimModelClient.GetColorcodeForZone(bimModels, SessionController.ConnectionString);
            var rowcount = ds.Tables[0].Rows.Count;

            for (var i = 0; i < rowcount; i++)
            {
                externalids = externalids + "," + ds.Tables[0].Rows[i]["external_id"];
                colorvalues = colorvalues + " " + ds.Tables[0].Rows[i]["value"];
            }
            
            ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>btnSetColor_onclick('" + externalids + "','" + colorvalues + "');</script>", false);
        }

        protected void rg_room_data_sheet_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            var item = e.Item;
            
            var gridItem = item as GridDataItem;
            if (gridItem != null)
            {
                var asset = (AssetDto) gridItem.DataItem;
                var hyperLinkAsset = (HyperLink)gridItem["AssetLink"].FindControl("HyperLinkAsset");
                hyperLinkAsset.Text = asset.Name;
                hyperLinkAsset.NavigateUrl = string.Format("javascript:jump_on_comp_v1('{0}','{1}')", asset.ExternalSystemDataId, asset.Id);
            }
        }
    }
}