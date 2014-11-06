using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Locations;
using EcoDomus.Session;
using System.Data;
using System.Threading;
using System.Globalization;
using Facility;
using EnergyPlus;
using System.Collections;

public partial class App_test_EnergyZones : System.Web.UI.Page
{
    Int32 TotalItemCount;
    public ArrayList arrayList = new ArrayList();
    public Hashtable ht_zonelist_zone = new Hashtable();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //if (Convert.ToString( Request.QueryString["pk_energymodel_simulation_profile"]) != null)
            //{

            //    SessionController.Users_.Profileid = Convert.ToString( Request.QueryString["pk_energymodel_simulation_profile"]);

            //    lbl_project_name.Text = Convert.ToString(Request.QueryString["project_name"]);
            //    SessionController.Users_.ProfileName = lbl_project_name.Text;
            //}
            lbl_project_name.Text = SessionController.Users_.ProfileName;
            hfExpand.Value = "no";
            BindzonedropDown();
            if (rarcmbZones.Items.Count > 0)
            {
                hf_zone_id.Value = rarcmbZones.SelectedItem.Value;
            }
            ViewState["SelectedLocationId"] = null;
            ViewState["zonelist_zone"] = null;
            GetEnergyModelAddedZones();
            BindZones();

        }

    }

    private void GetEnergyModelAddedZones()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            obj_energy_plus_model.Fk_em_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
            ds = obj_energy_plus_client.Get_Energy_Modeling_Project_Zonelist_Zones(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                     ConvertDataSetToArrayList(ds);
                }
            }
            
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    
    protected void btn_addSpacestoProject_Click(object sender, EventArgs e)
    {
        try
        {
            AddSpaces();
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
        
    }

    protected void rg_zones_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindZones();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_zones_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindZones();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_zones_OnSortCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            BindZones();

        }
        catch (Exception ex)
        {
            
            throw ;
        }
        
    }
    protected void RadGrid1_ColumnCreated(object sender, GridColumnCreatedEventArgs e)
    {
        try
        {
            if (e.Column is GridGroupSplitterColumn)
            {
                e.Column.Display = false;
            }
        }
        catch (Exception ex)
        {
            
            throw ;
        }
        
    }
    protected void rg_zones_ItemEvent(object sender, GridItemEventArgs e)
    {
        TotalItemCount = (e.EventInfo as GridInitializePagerItem).PagingManager.DataSourceCount;
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;
        }
    }
    protected void rg_zones_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = (GridDataItem)e.Item;
            string id = Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_energy_modeling_project_zonelist_linkup"]);
            string space_id = Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["space_id"]);
            string zone_id = Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_location_id"]);
            if (!string.IsNullOrEmpty(id))
            {

                e.Item.Selected = true;

                if (!string.IsNullOrEmpty(hf_space_ids.Value))
                {
                    if ((hf_space_ids.Value).IndexOf(space_id) == -1)
                        hf_space_ids.Value = hf_space_ids.Value + ',' + space_id;
                }
                else
                {
                    hf_space_ids.Value = space_id;
                }
                if (!string.IsNullOrEmpty(hf_zone_ids.Value))
                {
                    if ((hf_zone_ids.Value).IndexOf(zone_id) == -1)
                        hf_zone_ids.Value = hf_zone_ids.Value + ',' + zone_id;
                }
                else
                {
                    hf_zone_ids.Value = zone_id;
                }
            }

        }
    }
    protected void rg_zones_ItemCreated(object sender, GridItemEventArgs e)
    {

    }
    protected void rg_zones_ColumnCreated(object sender, GridColumnCreatedEventArgs e)
    {
        if (e.Column is GridExpandColumn)
        {
            e.Column.Display = false;
        }
    }
    protected void rg_zones_ItemCommand(object source, GridCommandEventArgs e)
    {
        try
        {
            if (hdn_row_index.Value != "")
            {
                if (e.CommandName == "attributes")
                {

                    if (rg_zones.MasterTableView.Items[e.Item.ItemIndex].Expanded)
                    {
                        if (hf_mode.Value == "edit")
                        {
                            hfExpand.Value = "expanded";
                            rg_zones.MasterTableView.Items[e.Item.ItemIndex].Expanded = true;
                            create_attributes_for_space(e);
                            foreach (GridDataItem item in rg_zones.Items)
                            {
                                if (item.Selected == true)
                                {
                                    System.Web.UI.HtmlControls.HtmlTable tbl_img = (System.Web.UI.HtmlControls.HtmlTable)rg_zones.MasterTableView.Items[item.ItemIndex].FindControl("tbl_edit2");
                                    tbl_img.Style.Add("display", "inline");
                                }
                                else
                                {
                                    System.Web.UI.HtmlControls.HtmlTable tbl_img = (System.Web.UI.HtmlControls.HtmlTable)rg_zones.MasterTableView.Items[item.ItemIndex].FindControl("tbl_edit");

                                    tbl_img.Style.Add("display", "none");
                                }
                            }
                        }
                        else
                        {
                            hfExpand.Value = "no";
                            rg_zones.MasterTableView.Items[e.Item.ItemIndex].Expanded = false;
                        }
                        if (hdn_row_deselected.Value == "row_deselected")
                        {
                            hfExpand.Value = "no";
                            rg_zones.MasterTableView.Items[e.Item.ItemIndex].Selected = false;
                            System.Web.UI.HtmlControls.HtmlTable tbl_img = (System.Web.UI.HtmlControls.HtmlTable)rg_zones.MasterTableView.Items[e.Item.ItemIndex].FindControl("tbl_edit");
                            tbl_img.Style.Add("display", "none");
                        }
                        else
                        {


                        }
                    }
                    else
                    {

                        hfExpand.Value = "expanded";
                        rg_zones.MasterTableView.Items[e.Item.ItemIndex].Expanded = true;
                        create_attributes_for_space(e);
                        foreach (GridDataItem item in rg_zones.Items)
                        {
                            if (item.Selected == true)
                            {
                                System.Web.UI.HtmlControls.HtmlTable tbl_img = (System.Web.UI.HtmlControls.HtmlTable)rg_zones.MasterTableView.Items[item.ItemIndex].FindControl("tbl_edit2");
                                tbl_img.Style.Add("display", "inline");
                            }
                            else
                            {
                                System.Web.UI.HtmlControls.HtmlTable tbl_img = (System.Web.UI.HtmlControls.HtmlTable)rg_zones.MasterTableView.Items[item.ItemIndex].FindControl("tbl_edit2");

                                tbl_img.Style.Add("display", "none");
                            }
                        }

                    }
                    hf_mode.Value = "profile";
                }
                else if (e.CommandName == "editAttributes")
                {
                    hfExpand.Value = "expanded";
                    rg_zones.MasterTableView.Items[e.Item.ItemIndex].Expanded = true;
                    edit_attributes_for_space(e);
                    foreach (GridDataItem item in rg_zones.Items)
                    {
                        if (item.Selected == true)
                        {
                            System.Web.UI.HtmlControls.HtmlTable tbl_img = (System.Web.UI.HtmlControls.HtmlTable)rg_zones.MasterTableView.Items[item.ItemIndex].FindControl("tbl_edit2");
                            tbl_img.Style.Add("display", "inline");
                        }
                        else
                        {
                            System.Web.UI.HtmlControls.HtmlTable tbl_img = (System.Web.UI.HtmlControls.HtmlTable)rg_zones.MasterTableView.Items[item.ItemIndex].FindControl("tbl_edit2");

                            tbl_img.Style.Add("display", "none");
                        }
                    }

                    hf_mode.Value = "edit";
                }


                if (e.CommandName == "save")
                {

                    //  rg_zones.MasterTableView.Items[(e.Item.ItemIndex)].Expanded = true;
                    edit_attributes_for_space(e);
                    foreach (GridDataItem item in rg_zones.Items)
                    {
                        if (item.Selected == true)
                        {
                            System.Web.UI.HtmlControls.HtmlTable tbl_img = (System.Web.UI.HtmlControls.HtmlTable)rg_zones.MasterTableView.Items[item.ItemIndex].FindControl("tbl_edit2");
                            tbl_img.Style.Add("display", "inline");
                        }
                        else
                        {
                            System.Web.UI.HtmlControls.HtmlTable tbl_img = (System.Web.UI.HtmlControls.HtmlTable)rg_zones.MasterTableView.Items[item.ItemIndex].FindControl("tbl_edit2");

                            tbl_img.Style.Add("display", "none");
                        }
                    }
                    hf_mode.Value = "save";
                }
                if (e.CommandName == "closeAttributes")
                {
                    hfExpand.Value = "no";
                    rg_zones.MasterTableView.Items[e.Item.ItemIndex].Expanded = false;
                    if (hdn_row_deselected.Value == "row_selected")
                    {
                        rg_zones.MasterTableView.Items[e.Item.ItemIndex].Selected = false;
                        System.Web.UI.HtmlControls.HtmlTable tbl_img = (System.Web.UI.HtmlControls.HtmlTable)rg_zones.MasterTableView.Items[e.Item.ItemIndex].FindControl("tbl_edit2");
                        tbl_img.Style.Add("display", "none");
                    }
                    else
                    {


                    }
                    hf_mode.Value = "closeAttributes";
                }
            }
            else
            {
                if (e.Item != null && e.Item.ItemIndex >= 0)
                {

                    System.Web.UI.HtmlControls.HtmlTable tbl_img = (System.Web.UI.HtmlControls.HtmlTable)rg_zones.MasterTableView.Items[e.Item.ItemIndex].FindControl("tbl_edit2");
                    tbl_img.Style.Add("display", "none");
                    rg_zones.MasterTableView.Items[e.Item.ItemIndex].Expanded = false;
                    rg_zones.MasterTableView.Items[e.Item.ItemIndex].Selected = false;
                    hfExpand.Value = "no";
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void btngotopage_click(object sender, EventArgs e)
    {

    }
    protected void txtgotopage_textChanged(object sender, EventArgs e)
    {
        try
        {
            TextBox txt = (TextBox)rg_zones.MasterTableView.FindControl("txtgotopage");



        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_zones_PreRender1(object sender, EventArgs e)
    {

        foreach (GridNestedViewItem item in rg_zones.MasterTableView.GetItems(GridItemType.NestedView)) // loop through the nested items of a NestedView Template
        {

            GridDataItem parentitem = (GridDataItem)item.ParentItem;
            TableCell cell = parentitem["ExpandColumn"];
            cell.Controls.Clear();
            //}
        }
    }
    protected void rg_zones_ItemCreated1(object sender, GridItemEventArgs e)
    {
        try
        {

            if (e.Item is GridPagerItem)
            {

            }
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ibtnSearch_Click(object sender, ImageClickEventArgs e)
    {
        if (rarcmbZones.Items.Count > 0)
        {
            hf_zone_id.Value = rarcmbZones.SelectedItem.Value;
            BindZones();
        }

    }
    protected void OnClick_lbtn_edit_save(object sender, EventArgs e)
    {

        saveattributes(sender, e);


    }
    protected void AddSpaces()
    {
        EnergyPlusClient ctrl_ep = new EnergyPlusClient();
        EnergyPlusModel mdl_ep = new EnergyPlusModel();
        DataSet ds = new DataSet();
        string Space_ids="";
        string zone_ids="";
        GetSelectedRows();
        if (ViewState["zonelist_zone"] != null)
        {
            Hashtable ht_zonelist_zone = (Hashtable)ViewState["zonelist_zone"];
            if (ht_zonelist_zone != null)
            {
                foreach (string k in ht_zonelist_zone.Keys)
                {
                    Space_ids = Space_ids + k + ",";
                    zone_ids = zone_ids + ht_zonelist_zone[k] + ",";
                }
            }
        }
        Space_ids = Space_ids.TrimEnd(',');
        zone_ids = zone_ids.TrimEnd(',');

        //Space_ids = Convert.ToString(hf_space_ids.Value);
        //zone_ids = Convert.ToString(hf_zone_ids.Value);

        mdl_ep.spaceids = Space_ids;
        mdl_ep.zoneids = zone_ids;
        mdl_ep.pk_profileid = new Guid(SessionController.Users_.Profileid);
        mdl_ep.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
        mdl_ep.User_id = new Guid(SessionController.Users_.UserId);
        ctrl_ep.proc_insert_update_EnergyModeling_projects_zonelist(mdl_ep, SessionController.ConnectionString);


    }
    void saveattributes(object sender, EventArgs e)
    {

        System.Collections.IEnumerator keys = Request.Params.Keys.GetEnumerator();
        string attributes_id = "";
        string attributes_values = "";
        string oneKey;
        string str = "`";
        while (keys.MoveNext())
        {
            oneKey = keys.Current.ToString();
            if (oneKey.EndsWith("-txtvalue-") == true)
            {
                if (attributes_id == "")
                    attributes_id = oneKey.Substring(oneKey.IndexOf("[") + 1, 36);
                else
                    attributes_id = attributes_id + "," + oneKey.Substring(oneKey.IndexOf("[") + 1, 36);
                if (attributes_values == "")
                    attributes_values = Request.Params.GetValues(oneKey).ElementAt(0).ToString();
                else
                {
                    if (!(string.IsNullOrEmpty(Request.Params.GetValues(oneKey).ElementAt(0).ToString())))
                        attributes_values = attributes_values + "," + Request.Params.GetValues(oneKey).ElementAt(0).ToString();
                    else
                        attributes_values = attributes_values + "," + str;
                }
            }

        }

        EnergyPlusClient EnergyPlusClient = new EnergyPlusClient();
        EnergyPlusModel EnergyPlusModel = new EnergyPlusModel();
        EnergyPlusModel.attributeids = attributes_id;
        EnergyPlusModel.attributevalues = attributes_values;
        DataSet ds = EnergyPlusClient.proc_update_energy_modeling_space_attributes(EnergyPlusModel, SessionController.ConnectionString);


    }
    void create_attributes_for_space(GridCommandEventArgs e)
    {
        DataSet ds = new DataSet();
        DataSet dsObjects = new DataSet();
        GridDataItem item = null;
        if (e.Item.GetType().Name == "GridDataItem")
        {
            item = (GridDataItem)e.Item;
        }
        else if (e.Item.GetType().Name == "GridNestedViewItem")
        {
            item = ((Telerik.Web.UI.GridNestedViewItem)(e.Item)).ParentItem;
        }
        Guid pk_space_id = new Guid(Convert.ToString(item.GetDataKeyValue("space_id")));
        hf_space_id.Value = Convert.ToString(pk_space_id);
        Panel pnlAttributes = (Panel)item.ChildItem.FindControl("NestedViewPanel");
        Panel pnlModelingObjects = (Panel)item.ChildItem.FindControl("Pnl_whole_control");

        Table tblSpace_attributes = (Table)pnlAttributes.FindControl("tblSpace_attributes");
        Table tbl_modelingObject = (Table)pnlModelingObjects.FindControl("tbl_modelingObject");

        RadComboBox rcbModelingObjects = (RadComboBox)tbl_modelingObject.FindControl("rcbmodelingObjects");

        EnergyPlusClient EnergyPlusClient = new EnergyPlusClient();
        EnergyPlusModel EnergyPlusModel = new EnergyPlusModel();
        EnergyPlusModel.spaceid = pk_space_id;
        ds = EnergyPlusClient.proc_get_energy_modeling_space_attributes(EnergyPlusModel, SessionController.ConnectionString);
        EnergyPlusModel.spaceid = pk_space_id;
        dsObjects = EnergyPlusClient.proc_get_energymodeling_objects_for_space(EnergyPlusModel, SessionController.ConnectionString);

        rcbModelingObjects.DataSource = dsObjects;
        rcbModelingObjects.DataTextField = "group_name";
        rcbModelingObjects.DataValueField = "pk_required_attribute_group_id";
        rcbModelingObjects.DataBind();

        Table tblinner = new Table();
        TableRow tr = new TableRow();
        TableCell td = new TableCell();
        TableRow trinner = new TableRow();
        TableCell tdinner = new TableCell();

        tblinner.CellPadding = 0;
        tblinner.CellSpacing = 0;
        tblinner.Style.Add("border-collapse", "collapse");

        #region Inner
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            trinner = new TableRow();
            Int32 col = 0;
            foreach (DataColumn dc in ds.Tables[0].Columns)
            {


                tdinner = new TableCell();
                tdinner.CssClass = "tdInner";
                tdinner.BorderWidth = 1;
                tdinner.Height = 25;
                tdinner.BorderColor = System.Drawing.Color.Gray;
                tdinner.Font.Size = 8;
                tdinner.Font.Bold = true;
                tdinner.Font.Name = "Arial Regular";
                if (col == 0)
                {
                    tdinner.Visible = false;
                }
                if (col == 1)
                {

                    tdinner.Style.Add("width", "60%");


                }

                tdinner.Style.Add("border-color", "#DBDBDB");
                tdinner.Style.Add("padding-left", "15px");

                col++;
                tdinner.Text = Convert.ToString(dr[dc.ColumnName]);
                tdinner.HorizontalAlign = HorizontalAlign.Left;
                trinner.Controls.Add(tdinner);
            }
            tblSpace_attributes.Controls.Add(trinner);
            tblSpace_attributes.Style.Add("border-right-width", "0");
            tblSpace_attributes.Style.Add("border-left-color", "white");

        }
        #endregion

        //to make visible false
        Panel PnlEdit = (Panel)item.ChildItem.FindControl("PnlEdit");
        PnlEdit.Visible = false;
        pnlModelingObjects.Visible = true;

    }
    void edit_attributes_for_space(GridCommandEventArgs e)
    {
        DataSet ds = new DataSet();
        DataSet dsObjects = new DataSet();
        GridDataItem item = null;
        if (e.Item.GetType().Name == "GridDataItem")
        {
            item = (GridDataItem)e.Item;
        }
        else if (e.Item.GetType().Name == "GridNestedViewItem")
        {
            item = ((Telerik.Web.UI.GridNestedViewItem)(e.Item)).ParentItem;
        }
        Guid pk_space_id = new Guid(Convert.ToString(item.GetDataKeyValue("space_id")));
        hf_space_id.Value = Convert.ToString(pk_space_id);
        Panel pnl_edit_attributes_table = (Panel)item.ChildItem.FindControl("pnl_edit_attributes_table");
        Panel PnlEdit = (Panel)item.ChildItem.FindControl("PnlEdit");

        Table tbl_edit_space_attributes = (Table)pnl_edit_attributes_table.FindControl("tbl_edit_space_attributes");
        Table tbl_edit_modelingObject = (Table)PnlEdit.FindControl("tbl_edit_modelingObject");

        RadComboBox rcbModelingObjects = (RadComboBox)tbl_edit_modelingObject.FindControl("rcb_edit_modeling_object");

        EnergyPlusClient EnergyPlusClient = new EnergyPlusClient();
        EnergyPlusModel EnergyPlusModel = new EnergyPlusModel();
        EnergyPlusModel.spaceid = pk_space_id;
        ds = EnergyPlusClient.proc_get_energy_modeling_space_attributes(EnergyPlusModel, SessionController.ConnectionString);
        EnergyPlusModel.spaceid = pk_space_id;
        dsObjects = EnergyPlusClient.proc_get_energymodeling_objects_for_space(EnergyPlusModel, SessionController.ConnectionString);

        rcbModelingObjects.DataSource = dsObjects;
        rcbModelingObjects.DataTextField = "group_name";
        rcbModelingObjects.DataValueField = "pk_required_attribute_group_id";
        rcbModelingObjects.DataBind();


        TableRow trinner = new TableRow();
        TableCell tdinner = new TableCell();
        //TextBox txtvalue = new TextBox();

        Int32 cell = 0;
        Int32 row = 0;
        Guid TestID = Guid.Empty;
        Guid PrevID = Guid.Empty;

        try
        {
            #region Inner
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                TestID = Guid.Parse(ds.Tables[0].Rows[row]["pk_location_attribute_value_id"].ToString());
                if (PrevID.Equals(Guid.Empty) == true)
                    PrevID = TestID;
                else
                    if (PrevID.Equals(TestID) == true)
                        continue;
                PrevID = TestID;
                trinner = new TableRow();
                trinner.ClientIDMode = System.Web.UI.ClientIDMode.Static;
                trinner.ID = "trinner" + Convert.ToString(cell);
                Int32 col = 0;

                foreach (DataColumn dc in ds.Tables[0].Columns)
                {


                    tdinner = new TableCell();
                    tdinner.CssClass = "tdInner";
                    tdinner.BorderWidth = 1;
                    tdinner.Height = 25;
                    tdinner.BorderColor = System.Drawing.Color.Gray;
                    tdinner.ClientIDMode = System.Web.UI.ClientIDMode.Static;
                    tdinner.ID = "tdinner" + Convert.ToString(cell);
                    if (col == 0)
                    {
                        tdinner.Visible = false;
                    }
                    if (col == 1)
                    {

                        tdinner.Style.Add("width", "60%");


                    }
                    if (col != 2)
                    {

                        tdinner.Font.Size = 8;
                        tdinner.Font.Bold = true;
                        tdinner.Font.Name = "Arial Regular";
                        tdinner.Text = Convert.ToString(dr[dc.ColumnName]);
                        tdinner.Style.Add("padding-left", "15px");

                    }
                    if (col == 2)
                    {
                        tdinner.Style.Add("width", "40%");

                        TextBox txtvalue = new TextBox();

                        txtvalue.Text = Convert.ToString(dr[dc.ColumnName]);
                        txtvalue.Style.Add("width", "95%");
                        txtvalue.Style.Add("height", "99%");
                        txtvalue.ForeColor = System.Drawing.Color.Black;
                        txtvalue.Font.Name = "Arial Regular";
                        txtvalue.Font.Bold = true;
                        txtvalue.Font.Size = 8;
                        txtvalue.ClientIDMode = System.Web.UI.ClientIDMode.Static;
                        txtvalue.ID = "[" + ds.Tables[0].Rows[row][0].ToString() + "]-txtvalue-";
                        //txtvalue.TextChanged=System.Web.UI.;
                        //txtvalue.BorderWidth = 0;
                        //  txtvalue.Height = tdinner.Height;
                        tdinner.Controls.Add(txtvalue);
                        tdinner.BorderWidth = 0;
                    }


                    tdinner.Style.Add("border-color", "#DBDBDB");
                    tdinner.HorizontalAlign = HorizontalAlign.Left;
                    trinner.Controls.Add(tdinner);

                    col++;
                    cell++;
                }
                tbl_edit_space_attributes.ClientIDMode = System.Web.UI.ClientIDMode.Static;

                tbl_edit_space_attributes.Controls.Add(trinner);
                tbl_edit_space_attributes.Style.Add("border-right-width", "0");
                tbl_edit_space_attributes.Style.Add("border-left-color", "white");

                //to make visible false
                Panel Pnl_whole_control = (Panel)item.ChildItem.FindControl("Pnl_whole_control");
                Pnl_whole_control.Visible = false;
                PnlEdit.Visible = true;
                row++;
                if (row == 14)
                    PrevID = TestID;
            }
            #endregion
        }
        catch (Exception exp)
        {
            Response.Write(exp.StackTrace);
        }
    }
    protected void BindZones()
    {
        EnergyPlusClient ctrl_ep = new EnergyPlusClient();
        EnergyPlusModel mdl_ep = new EnergyPlusModel();
        DataSet ds = new DataSet();
        if (!(string.IsNullOrEmpty(Convert.ToString(SessionController.Users_.Em_facility_id))))
            mdl_ep.Fk_facility_id = new Guid(Convert.ToString(SessionController.Users_.Em_facility_id));
        if (!(string.IsNullOrEmpty(SessionController.Users_.Profileid)))
            mdl_ep.pk_profileid = new Guid(SessionController.Users_.Profileid);

        if (!(string.IsNullOrEmpty(hf_zone_id.Value)))
            mdl_ep.zoneid = new Guid(hf_zone_id.Value);
        else
            mdl_ep.zoneid = Guid.Empty;
        ds = ctrl_ep.proc_get_zone_list_NewUI(mdl_ep, SessionController.ConnectionString);

        rg_zones.DataSource = ds.Tables[0];
        rg_zones.DataBind();




    }
    protected void BindzonedropDown()
    {
        EnergyPlusClient ctrl_ep = new EnergyPlusClient();
        EnergyPlusModel mdl_ep = new EnergyPlusModel();
        DataSet ds = new DataSet();
        if (!(string.IsNullOrEmpty(Convert.ToString(SessionController.Users_.Em_facility_id))))
            mdl_ep.Fk_facility_id = new Guid(Convert.ToString(SessionController.Users_.Em_facility_id));

        if (!(string.IsNullOrEmpty(SessionController.Users_.Profileid)))
            mdl_ep.pk_profileid = new Guid(SessionController.Users_.Profileid);

        ds = ctrl_ep.proc_get_energy_modeling_zones_for_dropdown(mdl_ep, SessionController.ConnectionString);
        rarcmbZones.DataSource = ds;
        rarcmbZones.DataTextField = "name";
        rarcmbZones.DataValueField = "pk_location_id";
        rarcmbZones.DataBind();

        //    rarcmbZones.DataBind();


    }

 

    public void ConvertDataSetToArrayList(DataSet ds)
    {
        try
        {
            foreach (DataRow dtRow in ds.Tables[0].Rows)
            {
                string zone_id = dtRow["zone_id"].ToString();
                string zonelist_id = dtRow["zonelist_id"].ToString();
                if (!arrayList.Contains(zone_id))
                {
                    arrayList.Add(dtRow["zone_id"].ToString());
                }

                if (!ht_zonelist_zone.ContainsKey(zone_id))
                {
                    ht_zonelist_zone.Add(zone_id, zonelist_id);
                }
            }

            ViewState["SelectedLocationId"] = arrayList;
            ViewState["zonelist_zone"] = ht_zonelist_zone;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void GetSelectedRows()
    {
        try
        {
            SessionToArrayList();

            foreach (GridDataItem item in rg_zones.Items)
            {
                string strIndex = rg_zones.MasterTableView.CurrentPageIndex.ToString();
                string space_id = item["space_id"].Text;
                string zonelist_id = item["pk_location_id"].Text;
                if (item.Selected)
                {
                    if (!arrayList.Contains(space_id.ToString()))
                    {
                        arrayList.Add(space_id.ToString());
                    }

                    if (!ht_zonelist_zone.ContainsKey(space_id))
                    {
                        ht_zonelist_zone.Add(space_id, zonelist_id);
                    }
                }
                else
                {
                    if (arrayList.Contains(space_id.ToString()))
                    {
                        arrayList.Remove(space_id.ToString());
                    }
                    if (ht_zonelist_zone.ContainsKey(space_id))
                    {
                        ht_zonelist_zone.Remove(space_id);
                    }
                }
            }

            ViewState["SelectedLocationId"] = arrayList;
            ViewState["zonelist_zone"] = ht_zonelist_zone;
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void ReSelectedRows()
    {
        try
        {
            foreach (GridDataItem item in rg_zones.Items)
            {
                string space_id = item["space_id"].Text;
                if (arrayList.Contains(space_id.ToString()))
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

    protected void SessionToArrayList()
    {
        try
        {
            if (ViewState["SelectedLocationId"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedLocationId"];
            }
            if (ViewState["zonelist_zone"] != null)
            {
                ht_zonelist_zone = (Hashtable)ViewState["zonelist_zone"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_zones_DataBound(object sender, EventArgs e)
    {
        try
        {
            ReSelectedRows();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

   
}
