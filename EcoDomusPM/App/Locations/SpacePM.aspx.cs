using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Facility;
using System.Data;
using EcoDomus.Session;
using Locations;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;
using Aspose.Cells;
using System.Drawing;
using Facility;
using Project;
using Aspose.BarCode;
using Aspose.Words.Fields;
using Aspose.Words;
using System.Collections;
using System.IO;
using Asset; 


public partial class App_Locations_SpacePM : System.Web.UI.Page
{
    public ArrayList arrayList = new ArrayList();

    string tempPageSize = "";
    bool flag = false;
    //System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
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
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {
                ViewState["SelectedSpaceID"] = null;
                if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                }
                else
                {
                    bindfacility();
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "SpaceName";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rg_spaces.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    hfSpacePMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    bindspaces();
                }
                //  rg_spaces.Columns[7].Visible = false;

            }


        }
        else
        {
            Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
        }
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "GU")
        {
            btnaddspace.Visible = false;
            btndelete.Visible = false;

        }
        if (Session["chk_facility_checked"] != null)
        {
            if (Session["chk_facility_checked"].ToString() != "")
            {
                if (Session["chk_facility_checked"].ToString() == "Y")
                {
                    GridColumn col = rg_spaces.Columns.FindByUniqueName("linkfacility");
                    GridBoundColumn colBound = col as GridBoundColumn;
                    colBound.Visible = true;
                    chk_facility.Checked = true;
                    bindspaces();
                }

            }
            else
            {
                GridColumn col = rg_spaces.Columns.FindByUniqueName("linkfacility");
                GridBoundColumn colBound = col as GridBoundColumn;
                colBound.Visible = false;
                chk_facility.Checked = false;
                bindspaces();
            }
        }
        else
        {
            GridColumn col = rg_spaces.Columns.FindByUniqueName("linkfacility");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = false;
            //bindspaces();
        } 

        /*-----Category column-----*/

        if (Session["chk_category_checked"] != null)
        {
            if (Session["chk_category_checked"].ToString() != "")
            {
                if (Session["chk_category_checked"].ToString() == "Y")
                {
                    GridColumn col = rg_spaces.Columns.FindByUniqueName("Omniclass");
                    GridBoundColumn colBound = col as GridBoundColumn;
                    colBound.Visible = true;
                    chk_category.Checked = true;
                    bindspaces();
                }

            }
            else
            {
                GridColumn col = rg_spaces.Columns.FindByUniqueName("Omniclass");
                GridBoundColumn colBound = col as GridBoundColumn;
                colBound.Visible = false;
                chk_category.Checked = false;
                bindspaces();
            }
        }
        else
        {
            GridColumn col = rg_spaces.Columns.FindByUniqueName("Omniclass");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = false;
            bindspaces();
        }

        /*-----Category column-----*/


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
            DataRow dr_component = ds_component.Tables[0].Select("name='Space'")[0];
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
        string view_permission = dr["view_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();
        // delete button on component profile
        if (dr["name"].ToString() == "Space")
        {
            objPermission.SetEditable(btndelete, delete_permission);
            objPermission.SetEditable(btnaddspace, edit_permission);
        }

    }

    protected void bindfacility()
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        DataSet ds = new DataSet();
        DataSet ds1 = new DataSet();
        try
        {
            fm.Project_id = new Guid(SessionController.Users_.ProjectId);
            fm.Search_text_name = "";
            fm.Doc_flag = "floor";
            ds = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                cmb_facility.DataTextField = "name";
                cmb_facility.DataValueField = "pk_facility_id";
                cmb_facility.DataSource = ds;
                cmb_facility.DataBind();
                string name = ds.Tables[0].Rows[0]["name"].ToString();
                cmb_facility.Text = name;
            }
            cmb_facility.Visible = true;
            lbl_facility.Visible = true;
            cmb_facility.Enabled = true;
              
            if (ds.Tables[0].Rows.Count != 0)
            {
                if (SessionController.Users_.SpaceSelectedFacilities == null || Convert.ToString(SessionController.Users_.SpaceSelectedFacilities)=="")
                {
                    for (int k = 0; k < cmb_facility.Items.Count; k++)
                    {
                        CheckBox checkbox = (CheckBox)cmb_facility.Items[k].FindControl("CheckBox2");
                        checkbox.Checked = true;
                        cmb_facility.SelectedValue = cmb_facility.SelectedValue + "," + checkbox.Text;
                    }
                    cmb_facility.SelectedValue = cmb_facility.SelectedValue.Remove(0, 1);
                    cmb_facility.Text = cmb_facility.SelectedValue;
                }
                else
                {
                    string facilityids = SessionController.Users_.SpaceFacilities;
                    if (facilityids.ToString() != "")
                    {
                        int count = 0;
                        string mysubstring = "";
                        for (var i = 0; i <= facilityids.Length - mysubstring.Length; i++)
                        {
                            if (facilityids.ToString().Substring(i, mysubstring.Length) == mysubstring)
                            {
                                count++;
                            }
                        }
                        string[] facidarray = new string[count + 1];
                        int j = count + 1;
                        int p = 0;
                        System.Text.StringBuilder facilityvalues2 = new System.Text.StringBuilder();
                        for (int k = 0; k < cmb_facility.Items.Count; k++)
                        {
                            Telerik.Web.UI.RadComboBoxItem rcbItem = (Telerik.Web.UI.RadComboBoxItem)cmb_facility.Items[k];
                            if (facilityids.Contains(rcbItem.Value))
                            {
                                facidarray[p] = rcbItem.Value;
                                cmb_facility.SelectedValue = facidarray[p].ToString();
                                CheckBox checkbox = (CheckBox)cmb_facility.Items[k].FindControl("CheckBox2");
                                checkbox.Checked = true;
                            }
                        }
                        cmb_facility.SelectedValue = SessionController.Users_.SpaceSelectedFacilities;
                        cmb_facility.Text = SessionController.Users_.SpaceSelectedFacilities;
                    }
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void bindspaces()
    {
        LocationsModel lm = new LocationsModel();
        LocationsClient lc = new LocationsClient();
        DataSet ds = new DataSet();
        System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
        System.Text.StringBuilder selectedfacilitynames = new System.Text.StringBuilder();

        foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmb_facility.Items)
        {
            if (((CheckBox)rcbItem.FindControl("CheckBox2")).Checked)
            {
                facilityvalues.Append(rcbItem.Value);
                facilityvalues.Append(",");

                selectedfacilitynames.Append(rcbItem.Text);
                selectedfacilitynames.Append(",");

            }
        }
        if (facilityvalues.Length > 0)
        {
            facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
        }

        if (selectedfacilitynames.ToString().Length > 0)
        {
            selectedfacilitynames = selectedfacilitynames.Remove(selectedfacilitynames.ToString().Length - 1, 1);
        }


        lm.FacilityNames = facilityvalues.ToString();


        SessionController.Users_.SpaceFacilities = facilityvalues.ToString();

        SessionController.Users_.SpaceSelectedFacilities = selectedfacilitynames.ToString();


        //remove combobox from source ganesh m
        lm.CriteriaText = "Name"; //cmb_criteria.SelectedValue.ToString();
        lm.Search_text = txt_search.Text;
        ds = lc.Get_Spaces_PM(lm, SessionController.ConnectionString);
        rg_spaces.AllowCustomPaging = true;
        rg_spaces.AllowPaging = true;
        if (tempPageSize != "")
            rg_spaces.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
        rg_spaces.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
        if (ds.Tables.Count > 0)
        {

            rg_spaces.DataSource = ds;
            rg_spaces.DataBind();

        }
        ReSelectedRows();
        rg_spaces.AllowCustomPaging = false;
        //rg_spaces.AllowPaging = false;

    }  

    protected void rg_spacesPageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        bindspaces();

        flag = false;
    }

    protected void rg_spacesPageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        tempPageSize = e.NewPageSize.ToString();
        if (!flag)
        {
            flag = true;
            bindspaces();

        }
    }

    protected void rg_spacesSortCommand(object source, GridSortCommandEventArgs e)
    {
        bindspaces();
    }

    protected void cmbfacility_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {

        try
        {
            if (SessionController.Users_.SpaceFacilities == null)
            {
                System.Text.StringBuilder facilityvalues1 = new System.Text.StringBuilder();
                foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmb_facility.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("CheckBox2")).Checked)
                    {
                        facilityvalues1.Append(rcbItem.Value);
                        facilityvalues1.Append(",");
                    }
                }
                if (facilityvalues1.ToString().Length > 0)
                {
                    facilityvalues1 = facilityvalues1.Remove(facilityvalues1.ToString().Length - 1, 1);
                }
                SessionController.Users_.SpaceFacilities = facilityvalues1.ToString();
            }
            ((CheckBox)e.Item.FindControl("CheckBox2")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btn_search_click(object sender, EventArgs e)
    {
        bindspaces();
    }

    protected void btnaddspace_Click(object sender, EventArgs e)
    {
        hf_space_id.Value = Guid.Empty.ToString();
        SessionController.Users_.facilityID = Guid.Empty.ToString();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "navigate_space();", true);
    }

    protected void navigate(object sender, EventArgs e)
    {

        bindspaces();
    }

    protected void rg_spaces_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "SpaceProfile")
        {
            Guid space_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Space_location_id"].ToString());
            SessionController.Users_.facilityID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_facility_id"].ToString();
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?IsFromSpace=y&pagevalue=Space Profile&id=" + space_id + "&profileflag=new");
        }
        if (e.CommandName == "FloorProfile")
        {
            Guid floor_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Floor_location_id"].ToString());
            SessionController.Users_.facilityID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_facility_id"].ToString();
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?IsFromFloor=y&pagevalue=Floor Profile&id=" + floor_id);
        }
        if (e.CommandName == "Page")
        {
            GetSelectedRows();
        }
        //if (e.CommandName == "EditFacility")
        //{
        //    Guid floor_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Floor_location_id"].ToString());
        //    SessionController.Users_.facilityID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_facility_id"].ToString();
        //    Response.Redirect("~/App/Locations/FacilityMenu.aspx?pagevalue=Facility Profile&id=" + floor_id);
        //} 

    }

    protected void btn_delete_click(object sender, EventArgs e)
    {
        try
        {
            if (rg_spaces.SelectedItems.Count > 0)
            {
                System.Text.StringBuilder strSystemIds = new System.Text.StringBuilder();
                for (int i = 0; i < rg_spaces.SelectedItems.Count; i++)
                {
                    strSystemIds.Append(rg_spaces.SelectedItems[i].Cells[2].Text);
                    strSystemIds.Append(",");
                }

                string fac_ids = strSystemIds.ToString();
                if (fac_ids.Length > 0)
                {
                    fac_ids = fac_ids.Remove(fac_ids.ToString().Length - 1, 1);
                }
                FacilityModel fm = new Facility.FacilityModel();
                FacilityClient fc = new Facility.FacilityClient();
                fm.Facility_Ids = fac_ids;
                fm.Entity = "Space";
                fc.delete_facility_pm(fm, SessionController.ConnectionString);
                bindspaces();

            }
            //else
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
            //}
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnExcel_Click(object sender, EventArgs e)
    {
        LocationsModel lm = new LocationsModel();
        LocationsClient lc = new LocationsClient();
        DataSet ds = new DataSet();

        System.Text.StringBuilder facilityids = new System.Text.StringBuilder();
        foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmb_facility.Items)
        {
            if (((CheckBox)rcbItem.FindControl("CheckBox2")).Checked)
            {
                facilityids.Append(rcbItem.Value);
                facilityids.Append(",");
            }
        }
        if (facilityids.Length > 0)
        {
            facilityids = facilityids.Remove(facilityids.ToString().Length - 1, 1);
        }
        lm.FacilityNames = facilityids.ToString();
        ds = lc.Generate_Room_Datasheet_xls(SessionController.ConnectionString, lm);

        //// for aspose license
        //Aspose.Cells.License license = new Aspose.Cells.License();
        //license.SetLicense("Aspose.Cells.lic");

        Workbook workbook = new Workbook();
        Worksheet sheetfacility = workbook.Worksheets[0];

        sheetfacility.Name = "Room Data Sheet";

        sheetfacility.AutoFitColumns();
        Aspose.Cells.Style style = workbook.DefaultStyle;
        style.IsTextWrapped = true;
        style.Font.Name = "Tahoma";

        workbook.DefaultStyle = style;

        CreateExcelData(workbook, ds, "Room Data Sheet");
    }

    private void CreateExcelData(Workbook workbook, DataSet dset, string ExcelSheetName)
    {
        string[] ExcelColumn = new string[26] { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };

        int WorksheetsNo = 1;
        for (int dstable = 0; dstable < dset.Tables.Count; dstable++)
        {
            Cells cells = workbook.Worksheets[dstable].Cells;
            CreateHeader(cells, dset.Tables[dstable]);

            int i = 2;
            for (int j = 0; j < dset.Tables[dstable].Rows.Count; j++)
            {

                for (int k = 0; k < dset.Tables[dstable].Columns.Count; k++)
                {
                    string str = ExcelColumn[k].ToString() + i;
                    string[] datasplit = dset.Tables[dstable].Rows[j][k].ToString().Split('>');
                    if (datasplit.Length > 1)
                    {
                        string[] data = datasplit[1].Split('<');
                        cells[str].PutValue(data[0]);

                        Aspose.Cells.Style style = cells[str].GetStyle();

                        //Set text alignment type
                        style.HorizontalAlignment = TextAlignmentType.Left;

                        style.VerticalAlignment = TextAlignmentType.Left;
                        style.IsTextWrapped = true;
                        cells[str].SetStyle(style);
                    }
                    else
                    {
                        cells[str].PutValue(datasplit[0]);
                        cells.SetColumnWidth(k, 30);
                        Aspose.Cells.Style style = cells[str].GetStyle();

                        //Set text alignment type
                        style.HorizontalAlignment = TextAlignmentType.Left;
                        style.VerticalAlignment = TextAlignmentType.Left;
                        style.IsTextWrapped = true;


                        cells[str].SetStyle(style);
                    }
                }
                i++;

            }

            //Saving the modified Excel file in default (that is Excel 2003) format               
        }
        string ExcelFiles = System.Configuration.ConfigurationManager.AppSettings["ExcelFiles"].ToString();

        string strproject = SessionController.Users_.ProjectId.ToString();
        ExcelFiles = ExcelFiles + strproject;
        string ExcelFiles_serverpath = Server.MapPath(ExcelFiles);
        DirectoryInfo de5 = new DirectoryInfo(ExcelFiles_serverpath);
        if (!de5.Exists)
        {
            de5.Create();
        }
        string ExcelfileName = "Room Data Sheet" + "_" + System.DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";

        string strpath = ExcelFiles_serverpath + "\\" + ExcelfileName;
        workbook.Save(strpath);
        Response.Redirect(ExcelFiles + "//" + ExcelfileName);
    }

    private void CreateHeader(Cells cells, DataTable dt)
    {
        string[] ExcelColumn = new string[26] { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };
        for (int i = 0; i < dt.Columns.Count; i++)
        {
            string str = ExcelColumn[i].ToString() + "1";
            cells[str].PutValue(dt.Columns[i].ColumnName);
            cells.SetColumnWidth(i, 30);
            Aspose.Cells.Style style = cells[i].GetStyle();
            style.Font.Color = Color.Red;
            cells[i].SetStyle(style);
            style.Font.IsItalic = true;
        }
    }

    protected void rg_spaces_OnItemDataBound(object sender, GridItemEventArgs e)
    {

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


    protected void rg_spaces_OnItemCreated(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rg_spaces.MasterTableView.RenderColumns)
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
                }
            }

            if (e.Item is GridDataItem)
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                foreach (GridColumn column in rg_spaces.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null)
                        {
                            if (column.UniqueName.ToString().Equals("linkfacility"))
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[7].ToString());
                            else
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                        }
                    }
                    else if (column is GridButtonColumn)
                    {
                        //this line will show a tooltip based type of linkbutton for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null)
                        {
                            if (column.UniqueName.ToString().Equals("name"))
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[0].ToString());
                            if (column.UniqueName.ToString().Equals("name1"))
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[4].ToString());

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



    protected void btnGenerateBarcode_Click(object sender, EventArgs e)
    {
        try
        {
            //Aspose.Words.License license = new Aspose.Words.License();
            //license.SetLicense("Aspose.Words.lic");
            Aspose.BarCode.License license1 = new Aspose.BarCode.License();
            license1.SetLicense("Aspose.BarCode.lic");
            int barcode_height;
            int barcode_width;

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
            objloc_mdl.Entity = "Space";
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
                    barcode_width = barcode_width - 70;
                    barcode_height = barcode_height + 10;
                }
                else
                {
                    barcode_width = int.Parse(doc_template.Tables[0].Rows[0]["barcode_width"].ToString());
                    barcode_height = int.Parse(doc_template.Tables[0].Rows[0]["barcode_height"].ToString());
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
                builder.CellFormat.LeftPadding =
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

                int rowcount = no_barcode_per_page / 2;
                int colcount = no_of_coloumns;
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
                                    caption.Text = "EcoDomus";
                                    caption.Visible = true;
                                    builder_bar.CodeTextAlignment = StringAlignment.Near;
                                    builder_bar.CaptionAbove = caption;

                                    //set Image quality of barcode Image 
                                    builder_bar.ImageQuality = ImageQualityMode.Default;

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
                                                    builder.InsertTextInput("TextInput", TextFormFieldType.Regular, "", "Location: " + (ds_barcode.Tables[0].Rows[j- 1]["name"].ToString()), 0);
                                                    builder.InsertBreak(BreakType.LineBreak);
                                                    builder.InsertBreak(BreakType.LineBreak);
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

                string barcodetype = ds_barcode.Tables[0].Rows[0]["barcode_type"].ToString();
                if (barcodetype.Equals("QR"))
                {
                    barcode_width = int.Parse(doc_template.Tables[0].Rows[0]["barcode_width"].ToString());
                    barcode_height = int.Parse(doc_template.Tables[0].Rows[0]["barcode_height"].ToString());
                    barcode_width = barcode_width - 70;
                    barcode_height = barcode_height + 10;
                }
                else
                {
                    barcode_width = int.Parse(doc_template.Tables[0].Rows[0]["barcode_width"].ToString());
                    barcode_height = int.Parse(doc_template.Tables[0].Rows[0]["barcode_height"].ToString());
                    barcode_height = barcode_height - 20;
                }

               // int barcode_height = int.Parse(doc_template.Tables[0].Rows[0]["barcode_height"].ToString());
                int barcode_font_size = int.Parse(doc_template.Tables[0].Rows[0]["font_size"].ToString());
               // int barcode_width = int.Parse(doc_template.Tables[0].Rows[0]["barcode_width"].ToString());
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
                                                builder_bar.CodeText = (ds_barcode.Tables[0].Rows[counter]["barcode"].ToString());
                                            builder_bar.SymbologyType = (Symbology)Enum.Parse(typeof(Symbology), ds_barcode.Tables[0].Rows[0]["barcode_type"].ToString());

                                    //Set Caption for the Barcode Image 
                                    Caption caption = new Caption();
                                    caption.Text = "EcoDomus";
                                    caption.Visible = true;
                                    builder_bar.CodeTextAlignment = StringAlignment.Near;
                                    builder_bar.CaptionAbove = caption;

                                    //set Image quality of barcode Image 
                                    builder_bar.ImageQuality = ImageQualityMode.Default;

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
                                                    builder.InsertTextInput("TextInput", TextFormFieldType.Regular, "", "Location: " + (ds_barcode.Tables[0].Rows[counter]["name"].ToString()), 0);
                                                    builder.InsertBreak(BreakType.LineBreak);
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
    

            ////Aspose.Words.License license = new Aspose.Words.License();
        ////license.SetLicense("Aspose.Words.lic");
        ////Aspose.BarCode.License license = new Aspose.BarCode.License();
        //// license.SetLicense("Aspose.BarCode.lic");

            ////if (rgasset.SelectedItems.Count > 0)  // check weather user checked any text box or not 
        ////{ }
        //GetSelectedRows();
        //ReSelectedRows();
        //System.Text.StringBuilder strComponentIds = new System.Text.StringBuilder();
        //for (int i = 0; i < arrayList.Count; i++)
        //{
        //    strComponentIds.Append(arrayList[i]);
        //    strComponentIds.Append(",");
        //}

            //if (strComponentIds.Length > 0)
        //{
        //    strComponentIds = strComponentIds.Remove(strComponentIds.ToString().Length - 1, 1);
        //}


            //string all_componentid = strComponentIds.ToString();

            //Document doc = new Document();

            //DataSet ds_barcode = new DataSet();

            //FacilityModel objloc_mdl = new FacilityModel();
        //FacilityClient objloc_crtl = new FacilityClient();

            //objloc_mdl.Entity_Ids = all_componentid;
        //objloc_mdl.Entity = "Space";
        //ds_barcode = objloc_crtl.proc_generate_barcode(objloc_mdl, SessionController.ConnectionString);
        //int count = ds_barcode.Tables[0].Rows.Count;


            ////DataSet ds1 = new DataSet();
        ////AssetModel objbarcode_mdl = new AssetModel();
        ////AssetClient objbarcode_crtl = new AssetClient();

            ////objbarcode_mdl.Barcode_Structure_Id = new Guid("D30EA040-0245-4290-9662-0108B04F7F3D");

            ////ds1 = objbarcode_crtl.Proc_get_barcode_structure(SessionController.ConnectionString, objbarcode_mdl);


            //DocumentBuilder builder = new DocumentBuilder(doc);

            //builder.StartTable();

            //builder.PageSetup.LeftMargin = ConvertUtil.InchToPoint(0.5);
        //builder.PageSetup.RightMargin = ConvertUtil.InchToPoint(0.5);
        //builder.CellFormat.LeftPadding = 10;
        //builder.CellFormat.RightPadding = 10;
        //builder.CellFormat.TopPadding = 30;
        //builder.CellFormat.BottomPadding = 10;
        //builder.RowFormat.CellSpacing = 5;

            //builder.CellFormat.Width = ConvertUtil.InchToPoint(4);
        //builder.RowFormat.Height = ConvertUtil.InchToPoint(2);

            //builder.CellFormat.Borders.Bottom.LineWidth = 0.5;
        //builder.CellFormat.Borders.Top.LineWidth = 0.5;
        //builder.CellFormat.Borders.Left.LineWidth = 0.5;
        //builder.CellFormat.Borders.Right.LineWidth = 0.5;
        //builder.CellFormat.Borders.Bottom.LineStyle = LineStyle.Dot;
        //builder.CellFormat.Borders.Top.LineStyle = LineStyle.Dot;
        //builder.CellFormat.Borders.Left.LineStyle = LineStyle.Thick;
        //builder.CellFormat.Borders.Right.LineStyle = LineStyle.Thick;
        //builder.CellFormat.Borders.Color = System.Drawing.Color.Black;
        //int counter = 0;

            ////int intcell = 2;

            //int rowcount = ds_barcode.Tables[0].Rows.Count;
        //if (rowcount == 0)
        //{
        //      ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "Configurefacility();", true);
        //}
        //else
        //{
        //    for (int i = 0; i < rowcount; i++)
        //    {

            //        //if (ds_barcode.Tables[0].Rows[i]["barcode"].ToString() == "n/a" || ds_barcode.Tables[0].Rows[i]["barcode"].ToString() == "")
        //        //{
        //        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "Configurefacility(someconfiguration);", true);
        //        //}

            //        //********************code to generate barcode******************************//

            //        //Instantiate linear barcode object

            //      //  BarCodeBuilder builder_bar = new BarCodeBuilder();
        //        try
        //        {

            //            // By Pratik for activating Licence of Barcode and Aspose.Word on 09/25/2013
        //            BarCodeBuilder builder_bar = new BarCodeBuilder();
        //            Aspose.BarCode.License license = new Aspose.BarCode.License();
        //            license.SetLicense("Aspose.Barcode.lic");    //---------------------Replace this by Aspose.barcode.Lic for Production
        //            // Aspose.Words.License wlicense = new Aspose.Words.License();
        //            // wlicense.SetLicense("Aspose.Words.lic");

            //            builder.InsertCell();
        //            if (!string.IsNullOrEmpty(ds_barcode.Tables[0].Rows[i]["barcode"].ToString()))
        //            builder_bar.CodeText = (ds_barcode.Tables[0].Rows[i]["barcode"].ToString());


            //            //Set the symbology type to Code128

            //            builder_bar.SymbologyType = (Symbology)Enum.Parse(typeof(Symbology), ds_barcode.Tables[0].Rows[i]["barcode_type"].ToString());

            //            //Set Caption for the Barcode Image 
        //            Caption caption = new Caption();
        //            caption.Text = "EcoDomus";
        //            caption.Visible = true;
        //            builder_bar.CodeTextAlignment = StringAlignment.Near;
        //            builder_bar.CaptionAbove = caption;

            //            //set Image quality of barcode Image 
        //            builder_bar.ImageQuality = ImageQualityMode.Default;

            //            //Creating memory stream

            //            System.IO.MemoryStream ms = new System.IO.MemoryStream();

            //            //Saving barcode image to memory stream


            //            builder_bar.BarCodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Bmp);

            //            //Insert the barCode image into document

            //            builder.InsertImage(builder_bar.BarCodeImage, 230, 70);

            //            builder.InsertCell();
        //            //Set the Code text for the barcode
        //            if (ds_barcode.Tables[0].Rows[i]["barcode"].ToString() != null && ds_barcode.Tables[0].Rows[i]["name"].ToString() != null)
        //            {

            //                builder.InsertTextInput("TextInput", TextFormFieldType.Regular, "", "Location: " + (ds_barcode.Tables[0].Rows[i]["name"].ToString()), 0);
        //                builder.InsertBreak(BreakType.LineBreak);
        //                                           builder.InsertBreak(BreakType.LineBreak);

            //                //********************end************************************************//

            //            }

            //        }
        //        catch (Exception)
        //        {

            //        }
        //        //counter++;

            //        builder.EndRow();
        //    }
        //    builder.EndTable();


            //    MemoryStream stream = new System.IO.MemoryStream();

            //    doc.Save(stream, Aspose.Words.SaveFormat.Doc);

            //    byte[] bytes = stream.GetBuffer();
        //    System.Web.HttpResponse response1 = System.Web.HttpContext.Current.Response;
        //    response1.Clear();
        //    response1.AddHeader("Content-Type", "binary/octet-stream");
        //    response1.AddHeader("Content-Disposition", "attachment; filename=" + "Barcode.doc" + "; size=" + bytes.Length.ToString());
        //    response1.Flush();
        //    response1.BinaryWrite(bytes);
        //    response1.Flush();
        //    response1.End();
        //}


       // }
        catch (Exception ex)
        {
            throw ex;

        }

    }

    protected void rg_spaces_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetSelectedRows();

        if (rg_spaces.Items.Count > 10)
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

    }
    protected void GetSelectedRows()
    {
        try
        {


            foreach (GridDataItem item in rg_spaces.Items)
            {
                string strIndex = rg_spaces.MasterTableView.CurrentPageIndex.ToString();
                // string comp_id = item.GetDataKeyValue("Assetid").ToString();
                string comp_id = item.Cells[2].Text;

                if (item.Selected && ViewState["SelectedSpaceID"] != null)
                {
                    if (!((ArrayList)ViewState["SelectedSpaceID"]).Contains(comp_id.ToString()))
                    {
                        ((ArrayList)ViewState["SelectedSpaceID"]).Add(comp_id.ToString());
                    }
                }
                else if (item.Selected && ViewState["SelectedSpaceID"] == null)
                {
                    arrayList.Add(comp_id.ToString());
                    ViewState["SelectedSpaceID"] = arrayList;
                }
                else if (ViewState["SelectedSpaceID"] != null)
                {
                    if (((ArrayList)ViewState["SelectedSpaceID"]).Contains(comp_id.ToString()))
                    {
                        ((ArrayList)ViewState["SelectedSpaceID"]).Remove(comp_id.ToString());
                    }
                }
                SessionToArrayList();
                //if (item.Selected)
                //{
                //    if (!arrayList.Contains(comp_id.ToString()))
                //    {
                //        arrayList.Add(comp_id.ToString());
                //    }
                //}
                //else
                //{
                //    if (arrayList.Contains(comp_id.ToString()))
                //    {
                //        arrayList.Remove(comp_id.ToString());
                //    }
                //}
            }
            //ViewState["SelectedSpaceID"] = arrayList;

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
            //arrayList = (ArrayList)ViewState["SelectedSpaceID"];
            if (ViewState["SelectedSpaceID"] != null)
            {
                foreach (GridDataItem item in rg_spaces.Items)
                {
                    string component_id = item.Cells[2].Text;//item["Assetid"].Text;

                    if (((ArrayList)ViewState["SelectedSpaceID"]).Contains(component_id.ToString()))
                    {
                        item.Selected = true;

                    }
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
            if (ViewState["SelectedSpaceID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedSpaceID"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void checkchange(object sender, EventArgs e)
    {
        ViewState["SelectedSpaceID"] = null;
    }

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {

    }

    protected void chk_facility_click(object sender, EventArgs e)
    {
        if (chk_facility.Checked == true)
        {
            //GridColumn col = rg_spaces.Columns.FindByUniqueName("linkfacility");
            //GridBoundColumn colBound = col as GridBoundColumn;
            //colBound.Visible = true;
            //bindspaces();
            Session["chk_facility_checked"] = "Y";
        }
        else
        {
            //GridColumn col = rg_spaces.Columns.FindByUniqueName("linkfacility");
            //GridBoundColumn colBound = col as GridBoundColumn;
            //colBound.Visible = false;
            //bindspaces();
            Session["chk_facility_checked"] = "";
        }

    }
    protected void chk_category_CheckedChanged(object sender, EventArgs e)
    {
        if (chk_category.Checked == true)
        {
            Session["chk_category_checked"] = "Y";
        }
        else
        {
            Session["chk_category_checked"] = "";
        }

    }
}