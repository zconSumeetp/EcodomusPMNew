using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Locations;
using EcoDomus.Session;
using Asset;
using Telerik.Web.UI;
//using EcoDomus.AccessRoles;  
using System.Threading;
using System.Globalization;
using Facility;
using Project;
using Aspose.BarCode;
using Aspose.Words.Fields;
using Aspose.Words;
using System.Collections;
using System.IO;
using System.Drawing;



public partial class App_Asset_ComponentPM : System.Web.UI.Page
{
    public ArrayList arrayList = new ArrayList();
    List<String> ls = new List<string>();
    //DataTable dt_facilityids = new DataTable();
    //DataSet ds_facility1 = new DataSet();


    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtcriteria.Attributes.Add("onKeyPress", "doClick('" + btn_search.ClientID + "',event)");
            if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
            {
                if (!IsPostBack)
                {
                    ViewState["SelectedComponentID"] = null;
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);

            }
            else
            {
                //dt_facilityids.Columns.Add("ids");
                txtcriteria.Attributes.Add("onKeyPress", "doClick('" + btnsearch.ClientID + "',event)");
                if (SessionController.Users_.UserId != null)
                {
                    cmbfacility.Enabled = true;

                    if (!IsPostBack)
                    {
                        ViewState["SelectedComponentID"] = null;

                        BindFacility();

                        GridSortExpression sortExpr = new GridSortExpression();
                        sortExpr.FieldName = "Asset_Name";
                        sortExpr.SortOrder = GridSortOrder.Ascending;
                        //Add sort expression, which will sort against first column
                        rgasset.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                       // if( SessionController.Users_.ComponentPageSize != "" )
                         
                        //ViewState["PageSize"] = 10;
                        //ViewState["PageIndex"] = 0;
                        //ViewState["SortExpression"] = "Asset_Name";
                        if (SessionController.Users_.ComponentPageSize == null)
                        {
                           // SessionController.Users_.ComponentPageSize = "10";
                            SessionController.Users_.ComponentPageSize = SessionController.Users_.DefaultPageSizeGrids;
                        }
                        if (SessionController.Users_.ComponentPageIndex == null)
                        {
                            SessionController.Users_.ComponentPageIndex = "0";
                        }
                        if (SessionController.Users_.ComponentSortExpression == null)
                        {
                            SessionController.Users_.ComponentSortExpression = "Asset_Name";
                        }
                        else
                        {
                            string ComponentSortExpression = SessionController.Users_.ComponentSortExpression;
                            GridSortExpression sortExpr1 = new GridSortExpression();

                            if (ComponentSortExpression.Contains(' '))
                            {
                                int index = ComponentSortExpression.IndexOf(' ');
                                sortExpr.FieldName = ComponentSortExpression.Substring(0, index);
                                sortExpr.SortOrder = GridSortOrder.Descending;
                            }
                            else
                            {
                                sortExpr.FieldName = ComponentSortExpression;
                                sortExpr.SortOrder = GridSortOrder.Ascending;
                            }

                            rgasset.MasterTableView.SortExpressions.AddSortExpression(sortExpr1);
                            
                        }
                        hfCompPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                        BindGrid("n");
                        

                    }


                }
                else
                {
                    Response.Redirect("~/App/LoginPM.aspx");
                }

            }
        }

        catch (Exception ex)
        {
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {

        }
        catch (Exception)
        {

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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

    private void SetaccesstopageControls()
    {

        DataSet ds = new DataSet();
        DataTable dt = new DataTable();

        DataColumn Control_type = new DataColumn("Control_type", typeof(string));
        Control_type.DataType = System.Type.GetType("System.String");
        DataColumn Control_id = new DataColumn("Control_id");
        Control_id.DataType = System.Type.GetType("System.String");
        DataRow dr = dt.NewRow();
        dt.Rows.Add(dr);
        DataRow drgrid = dt.NewRow();
        dt.Rows.Add(drgrid);

        dt.Columns.Add(Control_type);
        dt.Columns.Add(Control_id);


        dr["Control_type"] = "Button";
        dr["Control_id"] = "btnaddcomponent";
        drgrid["Control_type"] = "GridView";
        drgrid["Control_id"] = "rgasset";


        foreach (DataRow drs in dt.Rows)
        {
            if (Convert.ToString(drs["Control_type"]) == "Button" && Convert.ToString(drs["Control_id"]) == "btnaddcomponent")
            {
                btnaddcomponent.Visible = false;
            }
            if (Convert.ToString(drs["Control_type"]) == "GridView" && Convert.ToString(drs["Control_id"]) == "rgasset")
            {
                foreach (GridColumn column in rgasset.Columns)
                {
                    if (column.UniqueName == "remove")
                    {
                        column.Visible = false;
                        break;
                    }

                }
            }

        }


    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "CBU")
            {
                btnUpdateNames.Visible = false;
                btnGenerateBarcode.Visible = false;

            }
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                btnUpdateNames.Visible = false;
                btnGenerateBarcode.Visible = false;
                btnDelete.Visible = false;
                btnaddcomponent.Visible = false;
            }
            if (!Page.IsPostBack)
            {
                BindGrid("");
            }
            else
            {
                BindGrid("");
            }

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
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        try
        {
            GetSelectedRows();
            SessionController.Users_.ComponentPageIndex = "0";
            SessionController.Users_.ComponentSearchText = txtcriteria.Text.Trim().Replace("'", "''");

            BindGrid("");



        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private ArrayList ConvertDataSetToArrayList(DataSet ds)
    {
        try
        {
            //DataSet ds = (DataSet)Session["selectedRows"];
            ArrayList alist = new ArrayList();
            foreach (DataRow dtRow in ds.Tables[0].Rows)
            {
                alist.Add(dtRow["Assetid"].ToString());
            }
            return alist;
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

            foreach (GridDataItem item in rgasset.Items)
            {
                string strIndex = rgasset.MasterTableView.CurrentPageIndex.ToString();
                // string comp_id = item.GetDataKeyValue("Assetid").ToString();
                string comp_id = item["Assetid"].Text;

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

            ViewState["SelectedComponentID"] = arrayList;
            ArrayList comp_list = (ArrayList)ViewState["SelectedComponentID"];
            string id = "";
            if (comp_list.Count > 0)
            {
                for (int i = 0; i < comp_list.Count; i++)
                {
                    id = id + comp_list[i].ToString() + ",";

                }
                id = id.Substring(0, id.Length - 1);
                hf_component_id.Value = id;

            }
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
            foreach (GridDataItem item in rgasset.Items)
            {
                string component_id = item.GetDataKeyValue("Assetid").ToString();//item["Assetid"].Text;

                if (arrayList.Contains(component_id.ToString()))
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
            if (ViewState["SelectedComponentID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedComponentID"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    // Bind facilities to facility Dropdown according to project
    private void BindFacility()
    {
        try
        { 

            DataSet ds_facility = new DataSet();
            FacilityClient locObj_crtl = new FacilityClient();
            FacilityModel locObj_mdl = new FacilityModel();
            locObj_mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
            locObj_mdl.Search_text_name = "";
            locObj_mdl.Doc_flag = "floor";
            ds_facility = locObj_crtl.GetFacilitiesPM(locObj_mdl, SessionController.ConnectionString);
            //ds_facility1 = ds_facility;
            if (ds_facility.Tables[0].Rows.Count > 0)
            {
                cmbfacility.DataTextField = "name";
                cmbfacility.DataValueField = "pk_facility_id";
                cmbfacility.DataSource = ds_facility;
                cmbfacility.DataBind();
                string name = ds_facility.Tables[0].Rows[0]["name"].ToString();
                //cmbfacility.Text = name;

            }

            cmbfacility.Visible = true;
            lblfacility.Visible = true;
            cmbfacility.Enabled = true;
            //-----------------------------------------------------------------------------------------------------------
            if (ds_facility.Tables[0].Rows.Count != 0)
            {
                
                if (SessionController.Users_.ComponentSelectedFacilities == null)
                {
                    for (int k = 0; k < cmbfacility.Items.Count; k++)
                    {
                        var checkbox = (CheckBox)cmbfacility.Items[k].FindControl("CheckBox1");
                        checkbox.Checked = true;
                        //cmbfacility.SelectedValue = SessionController.Users_.ComponentFacilities;
                        cmbfacility.SelectedValue = cmbfacility.SelectedValue + "," + checkbox.Text;
                        //cmbfacility.Text = SessionController.Users_.ComponentFacilities;

                    }
                    cmbfacility.SelectedValue = cmbfacility.SelectedValue.Remove(0, 1);
                    cmbfacility.Text = cmbfacility.SelectedValue;
                }
                else
                {
                    string facilityids = SessionController.Users_.ComponentFacilities;
                    if (facilityids.ToString() != "")
                    {
                        //To check the checkboxes of selected facilities-----------------------------------------------------------------------
                        int count = 0;
                        string mySubString = ",";
                        for (var i = 0; i <= facilityids.Length - mySubString.Length; i++)
                        {
                            if (facilityids.ToString().Substring(i, mySubString.Length) == mySubString)
                            {
                                count++;
                            }
                        }
                        string[] facidarray = new string[count + 1];
                        int j = count + 1;
                        int p = 0;
                        System.Text.StringBuilder facilityvalues2 = new System.Text.StringBuilder();
                        for (int k = 0; k < cmbfacility.Items.Count; k++)
                        {
                            Telerik.Web.UI.RadComboBoxItem rcbItem = (Telerik.Web.UI.RadComboBoxItem)cmbfacility.Items[k];
                            if (facilityids.Contains(rcbItem.Value))
                            {
                                facidarray[p] = rcbItem.Value;
                                cmbfacility.SelectedValue = facidarray[p].ToString();
                                CheckBox checkbox = (CheckBox)cmbfacility.Items[k].FindControl("CheckBox1");
                                checkbox.Checked = true;
                            }
                        }
                        cmbfacility.SelectedValue = SessionController.Users_.ComponentSelectedFacilities;
                        cmbfacility.Text = SessionController.Users_.ComponentSelectedFacilities;

                    }
                }
            }
            //--------------------------------------------------------------------------------------------------------------
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void BindGrid(string m)
    {
        try
        {
            int page_size = 0;
            var objloc_mdl = new AssetModel();
            var objloc_crtl = new AssetClient();


            if ((SessionController.Users_.ComponentSearchText == "") || (SessionController.Users_.ComponentSearchText == null))
            {
                objloc_mdl.CriteriaText = txtcriteria.Text.Trim().Replace("'", "''");
                SessionController.Users_.ComponentSearchText = txtcriteria.Text.Trim().Replace("'", "''");
            }
            else
            {
                objloc_mdl.CriteriaText = SessionController.Users_.ComponentSearchText;
            }

            var ds_ComponentCount = new DataSet();

            var ds_Search_assets = new DataSet();

            txtcriteria.Text = SessionController.Users_.ComponentSearchText;


            if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
            }
            else
            {
                var facilityIds = new List<Guid?>(); 
                var selectedfacilitynames = new System.Text.StringBuilder();
                var facilityvalues = new System.Text.StringBuilder();
                foreach (RadComboBoxItem rcbItem in cmbfacility.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
                    {
                        facilityvalues.Append(rcbItem.Value);
                        facilityvalues.Append(",");
                        selectedfacilitynames.Append(rcbItem.Text);
                        selectedfacilitynames.Append(",");
                        facilityIds.Add(new Guid(rcbItem.Value)); 
                    }
                }

                //foreach (var item in cmbfacility.Items.Where(x=>x.Checked))
                //{
                //    facilityIds.Add(new Guid(item.Value)); 
                //}
                
                
                if (facilityvalues.ToString().Length > 0)
                {
                    facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
                }
                if (selectedfacilitynames.ToString().Length > 0)
                {
                    selectedfacilitynames = selectedfacilitynames.Remove(selectedfacilitynames.ToString().Length - 1, 1);
                }
                objloc_mdl.FacilityNames = facilityvalues.ToString();

                SessionController.Users_.ComponentFacilities = facilityvalues.ToString();

                SessionController.Users_.ComponentSelectedFacilities = selectedfacilitynames.ToString();

                #region for deleted facility
                //----------------------------added on 21-11-2012---------------------------------------------------------------------------------------------------
                //string deletedfac = "";
                //for (int q = 0; q < ds_facility1.Tables[0].Rows.Count; q++)
                //{
                //    for (int r = 0; r < dt_facilityids.Rows.Count; r++)
                //    {
                //        if (dt_facilityids.Rows[r].ToString() == ds_facility1.Tables[0].Rows[q]["pk_facility_id"].ToString())
                //        {
                //            deletedfac = deletedfac + r.ToString();
                //        }
                //        else
                //        {

                //        }
                //    }
                //}
                //if (deletedfac != "")
                //{
                //    DataRow row1 = dt_facilityids.Rows[Int32.Parse(deletedfac)];
                //    dt_facilityids.Rows.Remove(row1);
                //}
                //--------------------------------------------------------------------------------------------------------------------------------
                #endregion
                //---------------------------added to bind by default only 10 components at a time----------------------------------------------------------

                ds_ComponentCount = objloc_crtl.Get_Component_Count(SessionController.ConnectionString, objloc_mdl);


                SessionController.Users_.ComponentCount = ds_ComponentCount.Tables[0].Rows[0]["Cnt"].ToString();

                
                if (SessionController.Users_.ComponentPageSize != null)
                {
                    if (SessionController.Users_.ComponentPageSize != "All")
                    {
                        rgasset.PageSize = Int32.Parse(SessionController.Users_.ComponentPageSize);

                    }
                }
                rgasset.VirtualItemCount = Int32.Parse(ds_ComponentCount.Tables[0].Rows[0]["Cnt"].ToString());
                if (SessionController.Users_.ComponentPageSize != null)
                {
                    objloc_mdl.Pagesize = Int32.Parse(SessionController.Users_.ComponentPageSize);
                }

                objloc_mdl.Pageindex = Int32.Parse(SessionController.Users_.ComponentPageIndex);
                objloc_mdl.Orderby = SessionController.Users_.ComponentSortExpression;
                //added on 20-11-2012
                int compo_count = Int32.Parse(SessionController.Users_.ComponentCount);
                page_size = Int32.Parse(SessionController.Users_.ComponentPageSize);
                int page_index = Int32.Parse(SessionController.Users_.ComponentPageIndex);
                if (page_size != 0)
                {
                    int maxpg_index = (compo_count / page_size) + 1;
                    if (page_index >= maxpg_index)
                    {

                        SessionController.Users_.ComponentPageIndex = "0";
                    }
                }

                ///////////////////////
                //-------------------------------------------------------------------------------------------------------------------------------------------

                var assetClient = new AssetClient();
                var orderByType = OrderByType.Name;
                switch (objloc_mdl.Orderby)
                {
                    case "Space_Name_ipad":
                        orderByType = OrderByType.Location;
                        break;
                    case "System_Name_iPad":
                        orderByType = OrderByType.System;
                        break;
                    case "Type_Name":
                        orderByType = OrderByType.Type;
                        break;
                }

                //var res = assetClient.GetComponents(SessionController.ConnectionString, facilityIds.ToArray(), page_size, page_index, orderByType, SessionController.Users_.ComponentSearchText);

                


                ds_Search_assets = objloc_crtl.Search_PMComponents(SessionController.ConnectionString, objloc_mdl);

                rgasset.DataSource = ds_Search_assets;
                //rgasset.DataSource = TypeConversion(res);
                rgasset.DataBind();
                rgasset.CurrentPageIndex = Int32.Parse(SessionController.Users_.ComponentPageIndex);
                rgasset.Visible = true;

                if (m == "n")
                {
                    string abc = rgasset.Columns[6].HeaderText;
                    rgasset.Columns[8].Visible = false;
                    rgasset.Columns[9].Visible = false;
                    rgasset.Columns[10].Visible = false;

                    if (SessionController.Users_.ComponentCheckedCheckboxes != null)
                    {
                        if (SessionController.Users_.ComponentCheckedCheckboxes.Contains('0'))
                        {
                            GridColumn col = rgasset.Columns.FindByUniqueName("Tagnumber");
                            GridBoundColumn colBound = col as GridBoundColumn;
                            colBound.Visible = true;
                            chk_tagNo.Checked = true;
                        }
                        if (SessionController.Users_.ComponentCheckedCheckboxes.Contains('1'))
                        {
                            GridColumn col = rgasset.Columns.FindByUniqueName("SerialNumber");
                            GridBoundColumn colBound = col as GridBoundColumn;
                            colBound.Visible = true;
                            chk_serialNo.Checked = true;
                        }

                        if (SessionController.Users_.ComponentCheckedCheckboxes.Contains('2'))
                        {
                            GridColumn col = rgasset.Columns.FindByUniqueName("LinkToBIM");
                            GridBoundColumn colBound = col as GridBoundColumn;
                            colBound.Visible = true;
                            chk_LinkToBIM.Checked = true;
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

    private DataSet TypeConversion(IEnumerable<AssetViewModel> am)
    {
        var ds = new DataSet();
        var dt = new DataTable();
        dt.Columns.Add("RowIndex", typeof(int));
        dt.Columns.Add("Assetid", typeof(Guid));
        dt.Columns.Add("Asset_Name", typeof(string));
        dt.Columns.Add("Asset_Description", typeof (string));
        dt.Columns.Add("Asset_Description_short", typeof(string));
        dt.Columns.Add("Type_Description", typeof(string));
        dt.Columns.Add("Space_Name", typeof(string));
        dt.Columns.Add("Space_Name_ipad", typeof(string));
        dt.Columns.Add("Facility_Name", typeof(string));
        dt.Columns.Add("Facility_Id", typeof(Guid));
        dt.Columns.Add("Type_Name", typeof(string));
        dt.Columns.Add("System_Name", typeof(string));
        dt.Columns.Add("System_Name_iPad", typeof(string));
        dt.Columns.Add("Status", typeof(string));
        dt.Columns.Add("Tagnumber", typeof(string));
        dt.Columns.Add("SerialNumber", typeof(string));
        dt.Columns.Add("linkasset", typeof(string));
        dt.Columns.Add("linktype", typeof(string));
        dt.Columns.Add("linkfacility", typeof(string));
        dt.Columns.Add("SpaceId", typeof(string));

        foreach (var assetViewModel in am)
        {
            var row = dt.NewRow();
            row["Assetid"] = assetViewModel.Id;
            row["Asset_Name"] = assetViewModel.AssetName;
            row["Asset_Description"] = assetViewModel.AssetDescription;
            row["Type_Description"] = assetViewModel.TypeDescription;
            row["Space_Name"] = "<a  href=\"javascript:gotoPage(\'" + assetViewModel.SpaceId + "\',\'Space\')\" >" + assetViewModel.SpaceName + "</a>";
            row["Space_Name_ipad"] = assetViewModel.SpaceName;
            row["Facility_Name"] = assetViewModel.FacilityName;
            row["Facility_Id"] = assetViewModel.FacilityId;
            row["Type_Name"] = assetViewModel.TypeName;
            row["System_Name"] = assetViewModel.SystemName;
            row["System_Name_iPad"] = assetViewModel.SystemName;
            row["Tagnumber"] = assetViewModel.TagNumber;
            row["SerialNumber"] = assetViewModel.SerialNumber;
            row["linkasset"] = "<a  href=\"javascript:gotoPage(\'" + assetViewModel.Id + "\',\'Asset\')\" >" + assetViewModel.AssetName + "</a>";
            row["linktype"] = "<a  href=\"javascript:gotoPage(\'" + assetViewModel.TypeId + "\',\'Type\')\" >" + assetViewModel.TypeName + "</a>";
            row["linkfacility"] = "<a  href=\"javascript:gotoPage(\'" + assetViewModel.FacilityId + "\',\'Facility\')\" >" + assetViewModel.FacilityName + "</a>";
            row["SpaceId"] = assetViewModel.SpaceId;
            if (assetViewModel.Status != null)
            {row["Status"] = "Y";}
            else
            {
                row["Status"] = "N";
            }
            
            dt.Rows.Add(row);
        }

        ds.Tables.Add(dt);
        return ds;
    }

    protected void rgasset_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            AssetModel objloc_mdl = new AssetModel();
            AssetClient objloc_crtl = new AssetClient();

            objloc_mdl.Asset_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Assetid"].ToString());

            Guid asset_id = objloc_mdl.Asset_id;
            if (e.CommandName == "delete")
            {
                objloc_crtl.delete_Asset(SessionController.ConnectionString, objloc_mdl);
                BindGrid("");
            }
            else if (e.CommandName == "edit")
            {

                Guid assetid = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Assetid"].ToString());
                Guid facilityid = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["facilityid"].ToString());

                hfAssetId.Value = assetid.ToString();
                Response.Redirect("~/App/Asset/AssetMenu.aspx?assetid=" + hfAssetId.Value.ToString(), false);
                // Response.Redirect("~/App/Asset/AssetMenu.aspx?AssetProfileNew.aspx?pagevalue=AssetProfile&assetid=" + asset_id,false);
            }


            //BindGrid();
        }
        catch (Exception ex)
        {

        }

    }

    int TotalItemCount;

    protected void rgasset_OnItemEvent(object sender, GridItemEventArgs e)
    {

        if (e.EventInfo is GridInitializePagerItem)
        {

            TotalItemCount = (e.EventInfo as GridInitializePagerItem).PagingManager.DataSourceCount;

        }
        hfcount.Value = TotalItemCount.ToString();

    }
    protected void rgassets_OnItemCreated(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rgasset.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        if (column.HeaderText != "" && column.HeaderText != "Facility")
                          (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;
                                            
                    }
                    if (column is GridButtonColumn)
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
                foreach (GridColumn column in rgasset.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null)
                        {
                            if (column.UniqueName == "Location")
                            {
                                //if(Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[6])!= "")
                                //{
                                //  string temp  = ((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[6].ToString();
                                //  temp = temp.Substring(temp.IndexOf('>')+1, temp.LastIndexOf("</a>") - temp.IndexOf('>')-1);
                                //     gridItem[column.UniqueName].ToolTip = temp;// Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[6]);
                                //}

                                gridItem[column.UniqueName].ToolTip =  Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[7]);
                            }
                            else if (column.UniqueName == "System")
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[12]);
                            else if (column.UniqueName == "LinkToBIM")
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[13]);
                            else if (column.UniqueName == "linkasset")
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2]);
                            else if (column.UniqueName == "Description")
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[3]);

                            else if (column.UniqueName == "linktype")
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[10]);
                            else
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName]);
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
    protected void btnaddcomponent_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("AssetMenu.aspx?assetid=" + Guid.Empty.ToString(), false);
        }
        catch (Exception ex)
        {
        }
    }

    protected void cmbfacility_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        try
        {

            if (SessionController.Users_.ComponentFacilities == null)
            {
                System.Text.StringBuilder facilityvalues1 = new System.Text.StringBuilder();
                foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
                    {
                        facilityvalues1.Append(rcbItem.Value);
                        facilityvalues1.Append(",");
                    }
                }
                if (facilityvalues1.ToString().Length > 0)
                {
                    facilityvalues1 = facilityvalues1.Remove(facilityvalues1.ToString().Length - 1, 1);
                }
                SessionController.Users_.ComponentFacilities = facilityvalues1.ToString();

            }

            ((CheckBox)e.Item.FindControl("CheckBox1")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgasset_OnItemDataBound(object sender, GridItemEventArgs e)
    {

        ReSelectedRows();
        if (e.Item is GridPagerItem)
        {

            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            cb.Items.Clear();

            RadComboBoxItem item = item = new RadComboBoxItem(SessionController.Users_.DefaultPageSizeGrids, SessionController.Users_.DefaultPageSizeGrids);

            item.Attributes.Add("ownerTableViewId", rgasset.MasterTableView.ClientID);
            if (hfcount.Value != "")
            {
                if (Convert.ToInt32(hfcount.Value) >= Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids))
                {
                    if (cb.Items.FindItemByValue(SessionController.Users_.DefaultPageSizeGrids) == null)
                        cb.Items.Add(item);
                }
            }

            if (hfcount.Value != "")
            {
                if (Convert.ToInt32(hfcount.Value) >= 20)
                {
                    item = new RadComboBoxItem("20", "20");
                    item.Attributes.Add("ownerTableViewId", rgasset.MasterTableView.ClientID);
                    if (cb.Items.FindItemByValue("20") == null)
                        cb.Items.Add(item);
                }
            }
            if (hfcount.Value != "")
            {
                if (Convert.ToInt32(hfcount.Value) >= 50)
                {
                    item = new RadComboBoxItem("50", "50");
                    item.Attributes.Add("ownerTableViewId", rgasset.MasterTableView.ClientID);
                    if (cb.Items.FindItemByValue("50") == null)
                        cb.Items.Add(item);
                }
            }
            if (hfcount.Value != "")
            {
                if (Convert.ToInt32(hfcount.Value) < 10)
                {
                    item = new RadComboBoxItem("10", "10");
                    item.Attributes.Add("ownerTableViewId", rgasset.MasterTableView.ClientID);
                    if (cb.Items.FindItemByValue("10") == null)
                        cb.Items.Add(item);
                }
            }

            //item = new RadComboBoxItem("All", hfcount.Value);
            //item.Attributes.Add("ownerTableViewId", rgasset.MasterTableView.ClientID);
            //if (cb.Items.FindItemByValue("All") == null)
            //           cb.Items.Add(item);



            cb.Items.Sort(new PagerRadComboBoxItemComparer());
            if (cb.Items.FindItemByValue(rgasset.PageSize.ToString()) != null)
                cb.Items.FindItemByValue(rgasset.PageSize.ToString()).Selected = true;



        }

    }

    protected void btnDelete_click(object sender, EventArgs e)
    {
        try
        {

            if (rgasset.SelectedItems.Count > 0)  // check weather user checked any text box or not 
            {
                System.Text.StringBuilder strComponentIds = new System.Text.StringBuilder();
                for (int i = 0; i < rgasset.SelectedItems.Count; i++)
                {
                    strComponentIds.Append(rgasset.SelectedItems[i].Cells[2].Text);
                    strComponentIds.Append(",");
                }

                FacilityClient objfacctrl = new FacilityClient();
                FacilityModel objfacmdl = new FacilityModel();

                objfacmdl.Facility_Ids = strComponentIds.ToString(); //Variable Facility_Ids from model class is used to pass component ids.
                objfacmdl.Entity = "Component";
                objfacmdl.Facility_Ids.Trim();
                objfacmdl.Facility_Ids.Trim(',');
                objfacctrl.delete_facility_pm(objfacmdl, SessionController.ConnectionString);
                BindGrid("");
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btn_refresh_click(object sender, EventArgs e)
    {
        try
        {
            ViewState["SelectedComponentID"] = null;
            rgasset.MasterTableView.CurrentPageIndex = 0;
            BindGrid("");
            hf_component_id.Value = "";
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void navigate(object sender, EventArgs e)
    {
        //cmb_floors.Enabled = true;
        BindGrid("");
    }

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='Component'")[0];
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

        //if (dr["Control_id"].ToString() == "btnaddcomponent")
        //{
        //    objPermission.SetEditable(btnaddcomponent, add_permission);
        //}
        if (dr["Control_label_id"].ToString() == "btnDelete")
        {
            objPermission.SetEditable(btnDelete, delete_permission);
            objPermission.SetEditable(btnaddcomponent, edit_permission);
            objPermission.SetEditable(btnGenerateBarcode, edit_permission);
            objPermission.SetEditable(btnUpdateNames, edit_permission);

        }

    }

    protected void rgasset_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        // This function is needed for custom paging. It gets called on pagesizechanged, pageindexchanged and sort events.
    }

    protected void rgasset_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        GetSelectedRows();
        if (e.NewPageSize != 10 && e.NewPageSize != 20 && e.NewPageSize != 50 &&  e.NewPageSize !=Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids))
        {

            SessionController.Users_.ComponentPageSize = "All";
            SessionController.Users_.ComponentPageIndex = "0";

        }
        else
        {

        SessionController.Users_.ComponentPageSize = e.NewPageSize.ToString();
        int compo_count = Int32.Parse(SessionController.Users_.ComponentCount);
        int page_size = Int32.Parse(SessionController.Users_.ComponentPageSize);
        int page_index = Int32.Parse(SessionController.Users_.ComponentPageIndex);
        int maxpg_index = (compo_count / page_size) + 1;
        if (page_index >= maxpg_index)
        {
            SessionController.Users_.ComponentPageIndex = "0";
        }
        if (e.Item is GridPagerItem)
        {
            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            cb.Items.FindItemByValue(rgasset.PageSize.ToString()).Selected = true;
        }
        if(rgasset.Items.Count > 10 )
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }


    }

    protected void rgasset_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        GetSelectedRows();
        SessionController.Users_.ComponentPageIndex = e.NewPageIndex.ToString();
        if (rgasset.Items.Count > 10)
         ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
    }

    protected void rgasset_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        GetSelectedRows();
        //ViewState["SortExpression"] = e.SortExpression;
        SessionController.Users_.ComponentSortExpression = e.SortExpression;
        if (e.NewSortOrder.ToString() == "Descending")
        {
            //ViewState["SortExpression"]=  ViewState["SortExpression"].ToString() + " DESC";
            SessionController.Users_.ComponentSortExpression = SessionController.Users_.ComponentSortExpression + " DESC";
        }
    }

    //protected void rgasset_ItemCreated(object sender, GridItemEventArgs e)
    //{

    //}

    /*Added By: Priyanka S
     *Date:7Th June 2013
     *Purpose:Added extra column To grid, Linked to BIM 
     */
    protected void chk_LinkToBIM_click(object sender, EventArgs e)
    {
        if (chk_LinkToBIM.Checked)
        {
            GridColumn col = rgasset.Columns.FindByUniqueName("LinkToBIM");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = true;
            //added
            SessionController.Users_.ComponentCheckedCheckboxes = SessionController.Users_.ComponentCheckedCheckboxes + "2";
            //--------------------------
            BindGrid("");
        }
        else
        {
            GridColumn col = rgasset.Columns.FindByUniqueName("LinkToBIM");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = false;
            //added
            if (SessionController.Users_.ComponentCheckedCheckboxes.Contains('2'))
            {
                int pos = SessionController.Users_.ComponentCheckedCheckboxes.IndexOf('2');
                SessionController.Users_.ComponentCheckedCheckboxes = SessionController.Users_.ComponentCheckedCheckboxes.Remove(pos, 1);
            }
            //---------------------
            BindGrid("");
        }

    }

    protected void chk_tagNo_click(object sender, EventArgs e)
    {
        if (chk_tagNo.Checked)
        {
            GridColumn col = rgasset.Columns.FindByUniqueName("Tagnumber");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = true;
            //added
            SessionController.Users_.ComponentCheckedCheckboxes = SessionController.Users_.ComponentCheckedCheckboxes + "0";
            //--------------------------
            BindGrid("");
        }
        else
        {
            GridColumn col = rgasset.Columns.FindByUniqueName("Tagnumber");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = false;
            //added
            if (SessionController.Users_.ComponentCheckedCheckboxes.Contains('0'))
            {
                int pos = SessionController.Users_.ComponentCheckedCheckboxes.IndexOf('0');
                SessionController.Users_.ComponentCheckedCheckboxes = SessionController.Users_.ComponentCheckedCheckboxes.Remove(pos, 1);
            }
            //---------------------
            BindGrid("");
        }

    }

    protected void chk_serialNo_click(object sender, EventArgs e)
    {
        if (chk_serialNo.Checked)
        {
            GridColumn col = rgasset.Columns.FindByUniqueName("SerialNumber");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = true;
            //added
            SessionController.Users_.ComponentCheckedCheckboxes = SessionController.Users_.ComponentCheckedCheckboxes + "1";
            //--------------------------
            BindGrid("");
        }
        else
        {
            GridColumn col = rgasset.Columns.FindByUniqueName("SerialNumber");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = false;
            //added
            if (SessionController.Users_.ComponentCheckedCheckboxes.Contains('1'))
            {
                int pos = SessionController.Users_.ComponentCheckedCheckboxes.IndexOf('1');
                SessionController.Users_.ComponentCheckedCheckboxes = SessionController.Users_.ComponentCheckedCheckboxes.Remove(pos, 1);
            }
            //---------------------
            BindGrid("");
        }

    }

    protected void btnGenerateBarcode_Click(object sender, EventArgs e)
    {
        try
        {

            //Aspose.Words.License license = new Aspose.Words.License();
            //license.SetLicense("Aspose.Words.lic");
            Aspose.BarCode.License license1 = new Aspose.BarCode.License();
            license1.SetLicense("Aspose.BarCode.lic");

            int barcode_width;
            int barcode_height;
            GetSelectedRows();

            System.Text.StringBuilder strComponentIds = new System.Text.StringBuilder();
            for (int i = 0; i < arrayList.Count; i++)
            {
                strComponentIds.Append(arrayList[i]);
                strComponentIds.Append(",");
            }

            if (strComponentIds.Length > 0)
            {
                strComponentIds = strComponentIds.Remove(strComponentIds.ToString().Length - 1, 1);
            }


            string all_componentid = strComponentIds.ToString();



            DataSet ds_barcode = new DataSet();
            Document doc = null;

            FacilityModel objloc_mdl = new FacilityModel();
            FacilityClient objloc_crtl = new FacilityClient();

            objloc_mdl.Entity_Ids = all_componentid;
            objloc_mdl.Entity = "Asset";
            
            ds_barcode = objloc_crtl.proc_generate_barcode(objloc_mdl, SessionController.ConnectionString);
            int count = ds_barcode.Tables[0].Rows.Count;

            if (count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "Configurefacility();", true);
            }
            else
            {

                string fac = ds_barcode.Tables[0].Rows[0]["facility_Id"].ToString();

                DataSet ds1 = new DataSet();
                AssetModel objbarcode_mdl = new AssetModel();
                AssetClient objbarcode_crtl = new AssetClient();


                DataSet doc_template = objbarcode_crtl.proc_get_barcode_info(SessionController.ConnectionString, ds_barcode);  //to get document template parameters
                DataSet barcode_print_option = objloc_crtl.proc_get_barcode_print_option(SessionController.ConnectionString, ds_barcode); // to get all barcode information

                if (ds_barcode.Tables[0].Rows.Count < arrayList.Count) // By pratik 
                {
                     
                    
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "Configurefacility();", true);

                }
                else
                {
                    if (doc_template.Tables[0].Rows[0]["template_type"].Equals("Custom Template"))
                    {
                        doc = new Document();
                        string barcodetype = ds_barcode.Tables[0].Rows[0]["barcode_type"].ToString();
                        if (barcodetype.Equals("QR"))
                        {
                            barcode_width = int.Parse(doc_template.Tables[0].Rows[0]["barcode_width"].ToString());
                            barcode_height = int.Parse(doc_template.Tables[0].Rows[0]["barcode_height"].ToString());
                            if (barcode_width>100)
                            barcode_width = barcode_width - 100;
                            barcode_height = barcode_height + 5;
                        }
                        else if (barcodetype.Equals("Code 128"))
                        {
                            barcode_width = int.Parse(doc_template.Tables[0].Rows[0]["barcode_width"].ToString());
                            barcode_height = int.Parse(doc_template.Tables[0].Rows[0]["barcode_height"].ToString());
                            barcode_width = barcode_width +40;
                            barcode_height = barcode_height + 5;
                        }
                        else
                        {

                            barcode_height = int.Parse(barcode_print_option.Tables[0].Rows[0]["barcode_height"].ToString());
                            barcode_width = int.Parse(barcode_print_option.Tables[0].Rows[0]["barcode_width"].ToString());
                            barcode_height = barcode_height - 20;
                        }

                        int no_of_coloumns = 2;      // int.Parse(doc_template.Tables[0].Rows[0]["no_of_coloumns"].ToString());
                        int no_barcode_per_page = int.Parse(barcode_print_option.Tables[0].Rows[0]["barcode_per_page"].ToString());
                        int print_option = int.Parse(barcode_print_option.Tables[0].Rows[0]["barcode_print_option"].ToString());
                        int barcode_font_size = int.Parse(doc_template.Tables[0].Rows[0]["font_size"].ToString());


                        //////code by Pratik 

                        DocumentBuilder builder = new DocumentBuilder(doc);
                        BarCodeBuilder builder_bar = new BarCodeBuilder();
                        //// Setting Template Attributes 

                        builder.StartTable();
                        builder.PageSetup.LeftMargin = ConvertUtil.InchToPoint(0.5);
                        builder.PageSetup.RightMargin = ConvertUtil.InchToPoint(0.5);
                        builder.CellFormat.LeftPadding = 20;
                        builder.CellFormat.RightPadding = 10;
                        builder.CellFormat.TopPadding = 30;
                        builder.CellFormat.BottomPadding = 10;
                        builder.RowFormat.CellSpacing = 5;

                        //builder.CellFormat.Width = ;
                        //builder.RowFormat.Height = 1;
                        builder.CellFormat.WrapText = true;

                        builder.CellFormat.Borders.Bottom.LineWidth = 0.5;
                        builder.CellFormat.Borders.Top.LineWidth = 0.5;
                        builder.CellFormat.Borders.Left.LineWidth = 0.5;
                        builder.CellFormat.Borders.Right.LineWidth = 0.5;
                        builder.CellFormat.Borders.Bottom.LineStyle = LineStyle.Dot;
                        builder.CellFormat.Borders.Top.LineStyle = LineStyle.Dot;
                        builder.CellFormat.Borders.Left.LineStyle = LineStyle.Thick;
                        builder.CellFormat.Borders.Right.LineStyle = LineStyle.Thick;
                        builder.CellFormat.Borders.Color = System.Drawing.Color.Black;
                        int counter = 0;

                        int rowcount;
                        int colcount;
                        if (no_barcode_per_page == 1)
                        {
                            rowcount = ds_barcode.Tables[0].Rows.Count;
                            colcount = 1;
                        }
                        else
                        {
                             rowcount= no_barcode_per_page / 2;
                             colcount = no_of_coloumns;
                        }
                       
                        int entrycount = ds_barcode.Tables[0].Rows.Count;
                        int imagecount = 0;


                        if (rowcount == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "Configurefacility();", true);
                        }
                        else
                        {
                            for (int i = 0; i < rowcount; i++)
                            {
                                for (int j = 0; j < colcount; j++)
                                {

                                    builder.InsertCell(); // inserting  column in row                         

                                    if (imagecount < entrycount)
                                    {
                                        try
                                        {



                                            if (!string.IsNullOrEmpty(ds_barcode.Tables[0].Rows[counter]["barcode"].ToString()))
                                                builder_bar.CodeText = (ds_barcode.Tables[0].Rows[counter]["barcode"].ToString());


                                            //Set the symbology type to Code128

                                            builder_bar.SymbologyType = (Symbology)Enum.Parse(typeof(Symbology), ds_barcode.Tables[0].Rows[0]["barcode_type"].ToString());

                                            //Set Caption for the Barcode Image 
                                            Caption caption = new Caption();
                                            caption.Text = "";
                                            caption.Visible = true;
                                            builder_bar.CodeTextAlignment = StringAlignment.Center;
                                            builder_bar.CodeTextColor=Color.Black;
                                  
                                            builder_bar.CaptionAbove = caption;
                                            builder_bar.CodeText= ds_barcode.Tables[0].Rows[counter]["barcode"].ToString();
                                            //set Image quality of barcode Image 
                                            builder_bar.ImageQuality = ImageQualityMode.Default;
                                            builder_bar.ImageHeight = barcode_height - 5;
                                            if (barcode_width>80)
                                            builder_bar.ImageWidth = barcode_width - 80;

                                            //Creating memory stream

                                            System.IO.MemoryStream ms = new System.IO.MemoryStream();

                                            //Saving barcode image to memory stream

                                            builder_bar.BarCodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Bmp);

                                            builder.InsertImage(builder_bar.BarCodeImage, barcode_width, barcode_height);


                                            builder.InsertBreak(BreakType.LineBreak);


                                            // print barcode information
                                            if (print_option == 1)
                                            {

                                                if (ds_barcode.Tables[0].Rows[0]["barcode"].ToString() != null && ds_barcode.Tables[0].Rows[0]["name"].ToString() != null)
                                                {
                                                    builder.Font.Size = barcode_font_size;
                                                    //builder.InsertTextInput("TextInput", TextFormFieldType.Regular, "", "Barcode Text: " + ds_barcode.Tables[0].Rows[0]["barcode"].ToString(),0);
                                                    builder.InsertBreak(BreakType.LineBreak);
                                                   
                                                    //builder.InsertTextInput("TextInput", TextFormFieldType.Regular, "", "Type: " + (ds_barcode.Tables[0].Rows[imagecount - 1]["type_name"].ToString()), 0);
                                                    //builder.InsertBreak(BreakType.LineBreak);
                                                    //if (ds_barcode.Tables[0].Rows[counter]["system_name"].ToString() != null && ds_barcode.Tables[0].Rows[imagecount - 1]["system_name"].ToString() != "")
                                                    //{
                                                    //    builder.InsertTextInput("TextInput", TextFormFieldType.Regular, "", "System: " + (ds_barcode.Tables[0].Rows[imagecount - 1]["system_name"].ToString()), 0);
                                                    //    builder.InsertBreak(BreakType.LineBreak);
                                                    //}
                                                }

                                            }

                                            imagecount++;
                                            counter++;
                                        }

                                        catch (Exception ex)
                                        {

                                        }
                                    }

                                }
                                builder.EndRow();

                            }
                            builder.EndTable();

                        }
                    }
                    else
                    {


                        string template = doc_template.Tables[0].Rows[0]["template_type"].ToString();
                        doc = new Document(Server.MapPath(@"~\app\templates\" + template.ToString() + ".docx"));
                        DocumentBuilder builder = new DocumentBuilder(doc);
                        BarCodeBuilder builder_bar = new BarCodeBuilder();

                        string barcodetype=ds_barcode.Tables[0].Rows[0]["barcode_type"].ToString();
                        if (barcodetype.Equals("QR"))
                        {
                             barcode_width = int.Parse(doc_template.Tables[0].Rows[0]["barcode_width"].ToString());
                            barcode_height = int.Parse(doc_template.Tables[0].Rows[0]["barcode_height"].ToString());
                            if(barcode_width>80)
                            barcode_width = barcode_width - 80;
                            barcode_height=barcode_height + 5;
                        }
                        else
                        {
                            barcode_width = int.Parse(doc_template.Tables[0].Rows[0]["barcode_width"].ToString());
                            barcode_height = int.Parse(doc_template.Tables[0].Rows[0]["barcode_height"].ToString());
                            barcode_height = barcode_height - 20;
                        }

                       
                        int barcode_font_size = int.Parse(doc_template.Tables[0].Rows[0]["font_size"].ToString());
                      
                        int no_of_rows = int.Parse(doc_template.Tables[0].Rows[0]["no_of_rows"].ToString());
                        int no_of_coloumns = int.Parse(doc_template.Tables[0].Rows[0]["no_of_coloumns"].ToString());
                        int print_option = int.Parse(barcode_print_option.Tables[0].Rows[0]["barcode_print_option"].ToString());
                        int counter = 0;

                        int rowcount = no_of_rows;
                        int colcount = no_of_coloumns;
                        int entrycount = ds_barcode.Tables[0].Rows.Count;
                        int imagecount = 0;
                        string bookmark = "";


                        if (rowcount == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "Configurefacility();", true);
                        }
                        else
                        {
                            for (int i = 1; i <= rowcount; i++)
                            {
                                for (int j = 1; j <= colcount; j++)
                                {

                                    if (imagecount < entrycount)
                                    {


                                        bookmark = "r" + i + "c" + j;

                                        try
                                        {
                                            if (!string.IsNullOrEmpty(ds_barcode.Tables[0].Rows[counter]["barcode"].ToString()))
                                                //builder_bar.CodeText = (ds_barcode.Tables[0].Rows[0]["Name"].ToString());
                                                builder_bar.CodeText = (ds_barcode.Tables[0].Rows[counter]["BarCode"].ToString());
                                            builder_bar.SymbologyType = (Symbology)Enum.Parse(typeof(Symbology), ds_barcode.Tables[0].Rows[0]["barcode_type"].ToString());

                                            //Set Caption for the Barcode Image 
                                            Caption caption = new Caption();
                                            caption.Text = "";
                                            caption.Visible = true;
                                            builder_bar.CodeTextAlignment = StringAlignment.Near;
                                            builder_bar.CaptionAbove = caption;
                                            builder_bar.CodeText = (ds_barcode.Tables[0].Rows[counter]["BarCode"].ToString());
                                            //set Image quality of barcode Image 
                                            builder_bar.CodeTextColor = Color.Black;
                                            builder_bar.ImageQuality = ImageQualityMode.Default;
                                            builder_bar.ImageHeight = barcode_height - 5;
                                            if(barcode_width>80)
                                            builder_bar.ImageWidth = barcode_width - 80;

                                            //Creating memory stream

                                            System.IO.MemoryStream ms = new System.IO.MemoryStream();

                                            //Saving barcode image to memory stream

                                            builder_bar.BarCodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Bmp);

                                            //move to specific Bookmark 
                                            builder.MoveToBookmark(bookmark);

                                            builder.InsertImage(builder_bar.BarCodeImage, barcode_width, barcode_height);


                                            builder.InsertBreak(BreakType.LineBreak);


                                            // print barcode information
                                            if (print_option == 1)
                                            {

                                                if (ds_barcode.Tables[0].Rows[counter]["barcode"].ToString() != null && ds_barcode.Tables[0].Rows[counter]["name"].ToString() != null)
                                                {
                                                    builder.Font.Size = barcode_font_size;
                                                    //builder.InsertTextInput("TextInput", TextFormFieldType.Regular, "", "" + ds_barcode.Tables[0].Rows[counter]["barcode"].ToString(), 0);
                                                    builder.InsertBreak(BreakType.LineBreak);
                                                }

                                            }
                                            builder.InsertCell();
                                            imagecount++;
                                            counter++;

                                        }
                                        catch (Exception ex)
                                        {
                                            throw ex;
                                        }
                                    }
                                }
                            }

                        }

                    }



                    MemoryStream stream = new System.IO.MemoryStream();

                    doc.Save(stream, Aspose.Words.SaveFormat.Doc);

                    byte[] bytes = stream.GetBuffer();
                    System.Web.HttpResponse response1 = System.Web.HttpContext.Current.Response;
                    response1.Clear();
                    response1.AddHeader("Content-Type", "binary/octet-stream");
                    response1.AddHeader("Content-Disposition", "attachment; filename=" + "Barcode.doc" + "; size=" + bytes.Length.ToString());
                    response1.Flush();
                    response1.BinaryWrite(bytes);
                    response1.Flush();
                    response1.End();
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;

        }
    

        
        

    }
}