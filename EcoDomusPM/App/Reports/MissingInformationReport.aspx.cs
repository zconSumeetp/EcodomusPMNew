using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using AttributeTemplate;
using Report;
using System.Data;
using Facility;
using Telerik.Web.UI;
using TypeProfile;
using Aspose.Cells;
using System.Drawing;
using System.IO;
using System.Threading;
using System.Globalization;


public partial class App_Reports_MissingInformationReport : System.Web.UI.Page
{
    public List<string> report_types = new List<string>();
    public List<string> designer_contractor = new List<string>();
    public List<string> lst_entities = new List<string>();
    public Dictionary<string, string> dict_facility_template = new Dictionary<string, string>();

    #region Page methods

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

           Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
        }

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            hfPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                    {

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                    }
                    else
                    {
                        DataSet ds_report_type = new DataSet();
                        DataSet ds_designer_contractor = new DataSet();
                        DataSet ds_facility = new DataSet();
                        DataSet ds_entity = new DataSet();
                        ds_entity = bindentity();
                        ds_facility = bindfacility();
                        ds_report_type = bindReportType();
                        ds_designer_contractor = bindDesignerContractor();

                        /*--genrate list of entiy names-->*/

                        for (int count = 0; count < ds_entity.Tables[0].Rows.Count; count++)
                        {
                            lst_entities.Add(Convert.ToString(ds_entity.Tables[0].Rows[count][1]));
                        }
                        ViewState["vw_entities"] = lst_entities;
                        /*--genrate list of entiy names-->*/


                        /*--select all checkboxes report type-->*/
                        for (int i = 0; i < cmbReport_type.Items.Count; i++)
                        {
                            cmbReport_type.Items[i].Checked = true;
                            report_types.Add(Convert.ToString(ds_report_type.Tables[0].Rows[i]["val"]));
                        }
                        ViewState["reports"] = report_types;
                        /*--select all checkboxes report type--*/

                        /*--select all checkboxes designer contractor-->*/
                        for (int i = 0; i < cmb_designer_contractor.Items.Count; i++)
                        {
                            cmb_designer_contractor.Items[i].Checked = true;
                            designer_contractor.Add(Convert.ToString(ds_designer_contractor.Tables[0].Rows[i]["pk_organization_id"]));
                        }
                        ViewState["designer_contractor"] = designer_contractor;
                        /*--select all checkboxes designer contractor--*/

                        /*--facility attribute template values-->*/
                        for (int i = 0; i < cmbfacility.Items.Count; i++)
                        {
                            if (!dict_facility_template.ContainsKey(Convert.ToString(ds_facility.Tables[1].Rows[i]["pk_facility_id"])))
                                dict_facility_template.Add(Convert.ToString(ds_facility.Tables[1].Rows[i]["pk_facility_id"]), Convert.ToString(ds_facility.Tables[1].Rows[i]["fk_attribute_template_id"]));
                        }
                        ViewState["facility_template"] = dict_facility_template;
                        /*--facility attribute template values--*/

                    }
                }
            }
            else
            {
                Response.Redirect("~/App/LoginPM.aspx");
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    #endregion 

    #region Report parameters Binding methods
    /// bind Designer Contractor
    /// </summary>
    private DataSet bindDesignerContractor()
    {
        DataSet ds = new DataSet();
        try
        {
            TypeModel tm = new TypeModel();
            TypeProfileClient tc = new TypeProfileClient();

            tm.Flag = "DC";
            tm.Txt_Search = "";
            tm.Project_id = new Guid(SessionController.Users_.ProjectId);
            ds = tc.GetDesignerContrator(tm, SessionController.ConnectionString);

            if (ds.Tables.Count > 0)
            {
                cmb_designer_contractor.DataTextField = "OrganizationName";
                cmb_designer_contractor.DataValueField = "pk_organization_id";
                cmb_designer_contractor.DataSource = ds;
                cmb_designer_contractor.DataBind();
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return ds;
    }

    /// bind report type 
    /// </summary>
    private DataSet bindReportType()
    {
        ReportModel am = new ReportModel();
        ReportClient ac = new ReportClient();
        DataSet ds = new DataSet();
        try
        {
            am.Entity_name = "All";
            ds = ac.get_MI_report_types(am, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                cmbReport_type.DataTextField = "MI_report_types";
                cmbReport_type.DataValueField = "id";
                cmbReport_type.DataSource = ds;
                cmbReport_type.DataBind();
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ds;
    }

    /// for binding facility dropdown
    /// </summary>
    private DataSet bindfacility()
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        DataSet ds = new DataSet();
        try
        {
            fm.Project_id = new Guid(SessionController.Users_.ProjectId);
            fm.Search_text_name = "";
            fm.Doc_flag = "floor";
            ds = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                cmbfacility.DataTextField = "name";
                cmbfacility.DataValueField = "pk_facility_id";
                cmbfacility.DataSource = ds;
                cmbfacility.DataBind();
            }
            else
            {
                cmbfacility.DataSource = string.Empty;
                cmbfacility.DataBind();
            }


        }
        catch (Exception ex)
        {

            throw ex;
        }
        return ds;
    }

    /// for binding categories dropdown 
    /// </summary>
    private DataSet bindentity()
    {
        AttributeTemplateModel am = new AttributeTemplateModel();
        AttributeTemplateClient ac = new AttributeTemplateClient();
        DataSet ds = new DataSet();
        try
        {
            am.Flag = "MI template";
            ds = ac.BindEntity(am, SessionController.ConnectionString);

            cmbentity.DataSource = ds;
            if (ds.Tables[0].Rows.Count > 0)
            {
                cmbentity.DataTextField = "entity_name";
                cmbentity.DataValueField = "pk_entity_id";
                cmbentity.DataSource = ds;
                cmbentity.DataBind();
            }
            else
            {
                cmbentity.DataSource = string.Empty;
                cmbentity.DataBind();
            }


        }
        catch (Exception ex)
        {

            throw ex;
        }
        return ds;
    }

    #endregion

    #region User defined methods
    /// get present MI report types 
    /// </summary>
    /// <returns></returns>
    protected string get_present_report_types()
    {
        var collection = cmbReport_type.CheckedItems;
        List<string> selected_vals = new List<string>();
        foreach (var item in collection)
        {
            selected_vals.Add(item.Text);
        }

        report_types = (List<string>)ViewState["reports"];

        for (int i = 0; i < cmbReport_type.Items.Count; i++)
        {
            if (selected_vals.Contains(Convert.ToString(cmbReport_type.Items[i].Text)))
            {
                cmbReport_type.Items[i].Checked = true;
                if (!report_types.Contains(Convert.ToString(cmbReport_type.Items[i].Text)))
                {
                    report_types.Add(Convert.ToString(cmbReport_type.Items[i].Text));
                }
                //else
                //{

                //}
            }
            else
            {
                cmbReport_type.Items[i].Checked = false;
                if (report_types.Contains(Convert.ToString(cmbReport_type.Items[i].Text)))
                {
                    report_types.Remove(Convert.ToString(cmbReport_type.Items[i].Text));
                }
                //else
                //{

                //}
            }

        }
        ViewState["reports"] = report_types;

        //var col = cmbReport_type.Items;

        System.Text.StringBuilder MI_reports = new System.Text.StringBuilder();
        try
        {
            report_types = (List<string>)ViewState["reports"];
            foreach (var item in report_types)
            {
                MI_reports.Append(Convert.ToString(item) + ",");
            }
            if (MI_reports.Length > 0)
                MI_reports.Remove(MI_reports.Length - 1, 1);
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return Convert.ToString(MI_reports);
    }

    ///  get_present_designer_contractor
    /// </summary>
    /// <returns></returns>
    protected string get_present_designer_contractor()
    {
        var collection = cmb_designer_contractor.CheckedItems;
        List<string> selected_vals = new List<string>();
        foreach (var item in collection)
        {
            selected_vals.Add(item.Value);
        }

        designer_contractor = (List<string>)ViewState["designer_contractor"];

        for (int i = 0; i < cmb_designer_contractor.Items.Count; i++)
        {
            if (selected_vals.Contains(Convert.ToString(cmb_designer_contractor.Items[i].Value)))
            {
                cmb_designer_contractor.Items[i].Checked = true;
                if (!designer_contractor.Contains(Convert.ToString(cmb_designer_contractor.Items[i].Value)))
                {
                    designer_contractor.Add(Convert.ToString(cmb_designer_contractor.Items[i].Value));
                }

            }
            else
            {
                cmb_designer_contractor.Items[i].Checked = false;
                if (designer_contractor.Contains(Convert.ToString(cmb_designer_contractor.Items[i].Value)))
                {
                    designer_contractor.Remove(Convert.ToString(cmb_designer_contractor.Items[i].Value));
                }

            }

        }
        ViewState["designer_contractor"] = designer_contractor;

        System.Text.StringBuilder selected_designer_contractors = new System.Text.StringBuilder();
        try
        {
            designer_contractor = (List<string>)ViewState["designer_contractor"];
            foreach (var item in designer_contractor)
            {
                selected_designer_contractors.Append(Convert.ToString(item) + ",");
            }
            if (selected_designer_contractors.Length > 0)
                selected_designer_contractors.Remove(selected_designer_contractors.Length - 1, 1);
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return Convert.ToString(selected_designer_contractors);
    }

    #endregion

    /// generate report using selected parameteres 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_generate_report_Click(object sender, EventArgs e)
    {
        rg_MI_report.Rebind();
    }

    #region Grid methods
    /// datasource evet for outermost grid
    /// </summary>
    /// <param name="source"></param>
    /// <param name="e"></param>
    protected void rg_MI_report_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        if (!e.IsFromDetailTable)
        {
            ReportModel am = new ReportModel();
            ReportClient ac = new ReportClient();
            DataSet ds = new DataSet();
            am.Entity_name = get_present_report_types();
            ds = ac.get_MI_report_types(am, SessionController.ConnectionString);

            rg_MI_report.DataSource = ds;
        }
    }

    protected void rg_MI_report_DetailTableDataBind(object source, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "pk_entity_id"://binding different entity types to inner grid 
                {
                    //string MI_report_type = Convert.ToString(dataItem.GetDataKeyValue("id"));
                    AttributeTemplateModel am = new AttributeTemplateModel();
                    AttributeTemplateClient ac = new AttributeTemplateClient();
                    DataSet ds = new DataSet();
                    try
                    {
                        am.Flag = "MI template";
                        ds = ac.BindEntity(am, SessionController.ConnectionString);
                    }
                    catch (Exception ex)
                    {

                        throw ex;
                    }
                    e.DetailTableView.DataSource = ds;
                    break;
                }

            case "id"://binding entity to inner grid 
                {
                    string MI_report_type = Convert.ToString((dataItem.OwnerTableView.ParentItem as GridDataItem).GetDataKeyValue("id")).Trim();
                    string entity_name = Convert.ToString(dataItem.GetDataKeyValue("entity_name")).Trim();
                    ReportModel am = new ReportModel();
                    ReportClient ac = new ReportClient();
                    DataSet ds = new DataSet();
                    string organization_ids = get_present_designer_contractor();
                    //am.Entity_name = Convert.ToString(cmbentity.SelectedItem.Text).Trim();
                    am.Entity_name = entity_name;
                    am.fk_organization_id = organization_ids;
                    //get the attribute template for facility
                    dict_facility_template = (Dictionary<string, string>)ViewState["facility_template"];
                    string Attribute_template_id = dict_facility_template[Convert.ToString(cmbfacility.SelectedValue)];
                    if (Attribute_template_id == "")
                        am.Attribute_template_id = null;
                    else
                        am.Attribute_template_id = dict_facility_template[Convert.ToString(cmbfacility.SelectedValue)];

                    am.Facility_id = Convert.ToString(cmbfacility.SelectedValue);
                    am.MI_report_type = MI_report_type;// Convert.ToString(dataItem.GetDataKeyValue("id")).Trim();

                    ds = ac.get_MI_entity_list(am, SessionController.ConnectionString);
                    e.DetailTableView.DataSource = ds;
                    break;
                }

            case "row_id"://binding attributes to inner grid 
                {
                    //e.DetailTableView.GetColumn("Attributes").HeaderText = "Document Types";
                    //string ParentID = (dataItem.OwnerTableView.ParentItem as GridDataItem).GetDataKeyValue("id").ToString();
                    string ParentID = Convert.ToString((dataItem.OwnerTableView.ParentItem.OwnerTableView.ParentItem as GridDataItem).GetDataKeyValue("id"));
                    string ID = dataItem.GetDataKeyValue("id").ToString();
                    string entity_name = Convert.ToString((dataItem.OwnerTableView.ParentItem as GridDataItem).GetDataKeyValue("entity_name")).Trim();

                    //if (ParentID.Equals("Missing Documents"))
                    //{
                    //    e.DetailTableView.GetColumn("Attributes").HeaderText = "Document Type";
                    //}
                    //else
                    //{
                    //    e.DetailTableView.GetColumn("Attributes").HeaderText = "Attributes";
                    //}

                    ReportModel am = new ReportModel();
                    ReportClient ac = new ReportClient();
                    DataSet ds = new DataSet();
                    dict_facility_template = (Dictionary<string, string>)ViewState["facility_template"];
                    string Attribute_template_id = dict_facility_template[Convert.ToString(cmbfacility.SelectedValue)];
                    if (Attribute_template_id == "")
                        am.Attribute_template_id = null;
                    else
                        am.Attribute_template_id = dict_facility_template[Convert.ToString(cmbfacility.SelectedValue)];

                    am.Facility_id = Convert.ToString(cmbfacility.SelectedValue);
                    am.MI_report_type = Convert.ToString(ParentID).Trim();
                    am.Entity_name = entity_name; //Convert.ToString(cmbentity.SelectedItem.Text).Trim();
                    am.RowId = new Guid(ID);
                    ds = ac.get_MI_attributes(am, SessionController.ConnectionString);
                    e.DetailTableView.DataSource = ds;
                    //e.DetailTableView.GetColumn("Attributes").HeaderText = "Document Type";
                    break;
                }



        }
    }

    protected void rg_MI_report_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //rg_MI_report.MasterTableView.Items[0].Expanded = true;
            //rg_MI_report.MasterTableView.Items[0].ChildItem.NestedTableViews[0].Items[0].Expanded = true;
            //RadGrid1.MasterTableView.Items[1].Expanded = true;
        }
    }

    protected void rg_MI_report_ItemDataBound(object sender, GridItemEventArgs e)
    {
        /*//try to change the header text for document type
        if (Convert.ToString((e.Item).ItemType) == "Header")
        {
            e.Item.OwnerTableView.Columns[1].HeaderText = "Type";
        }
        if (Convert.ToString((e.Item).ItemType) == "Item")
        {
            if (Convert.ToString((e.Item).OwnerTableView.Columns[1].HeaderText) == "Attributes")
            {
                string dynamic_header = Convert.ToString(((e.Item).OwnerTableView.ParentItem.OwnerTableView.ParentItem.OwnerTableView.ParentItem as GridDataItem).GetDataKeyValue("id"));

                if (dynamic_header == "Missing Documents")
                {
                    //(e.Item).OwnerTableView.Columns[1].HeaderText = "Document Type";
                    (e.Item).OwnerTableView.GetColumn("Attributes").HeaderText = "Document Type";                    

                }

            }
        }
         */

    }

    #endregion

    #region Export to Excel
    /// export report in excel format
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_export_report_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            lst_entities = (List<string>)ViewState["vw_entities"];
            //Instantiating a Workbook object
            Workbook workbook = new Workbook();

            foreach (var sheetname in lst_entities)
            {
                workbook.Worksheets.Add(sheetname);
                Cells cel = workbook.Worksheets[sheetname].Cells;
                createHeader(cel, Convert.ToString(sheetname));

            }
            workbook.Worksheets.RemoveAt(0);
            //workbook.Save("C:\\Users\\KaustubhS\\Desktop\\temp\\output.xls");

            Aspose.Cells.License cellslicense = new Aspose.Cells.License();
            cellslicense.SetLicense("Aspose.Cells.lic");


            /*--saving final file-->*/
            string ExcelFiles = System.Configuration.ConfigurationManager.AppSettings["ExcelFiles"].ToString();
            string strfacility = Convert.ToString(cmbfacility.SelectedValue);
            ExcelFiles = ExcelFiles + strfacility;
            string ExcelFiles_serverpath = Server.MapPath(ExcelFiles);
            DirectoryInfo de5 = new DirectoryInfo(ExcelFiles_serverpath);
            if (!de5.Exists)
            {
                de5.Create();
            }

            string ExcelfileName = "Missing Information Report" + "_" + System.DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";

            string strpath = ExcelFiles_serverpath + "\\" + ExcelfileName;
            workbook.Save(strpath);
            Response.Redirect(ExcelFiles + "/" + ExcelfileName);
            /*--saving final file--*/



        }
        catch (Exception ex)
        {

            throw;
        }
    }

    /// Create header elements of excel export file 
    /// 
    /// </summary>
    /// <param name="cell"></param>
    /// <param name="entity_name"></param>
    private void createHeader(Cells cell, string entity_name)
    {
        try
        {

            cell.SetColumnWidth(0, 35);
            cell.SetColumnWidth(1, 55);
            cell.SetColumnWidth(2, 55);
            cell.SetColumnWidth(3, 55);


            cell[0, 0].PutValue("Entity Names");
            Aspose.Cells.Style style = cell[0, 0].GetStyle();
            style.Font.IsBold = true;
            style.IsTextWrapped = true;
            cell[0, 0].SetStyle(style);

            cell[0, 1].PutValue("Missing Standard Attributes");
            Aspose.Cells.Style style1 = cell[0, 1].GetStyle();
            style1.Font.IsBold = true;
            style1.IsTextWrapped = true;
            cell[0, 1].SetStyle(style1);

            cell[0, 2].PutValue("Missing User Defined Attributes");
            Aspose.Cells.Style style2 = cell[0, 2].GetStyle();
            style2.Font.IsBold = true;
            style2.IsTextWrapped = true;
            cell[0, 2].SetStyle(style2);

            cell[0, 3].PutValue("Missing Document");
            Aspose.Cells.Style style3 = cell[0, 3].GetStyle();
            style3.Font.IsBold = true;
            style3.IsTextWrapped = true;
            cell[0, 3].SetStyle(style3);

            createElements(cell, entity_name);
        }
        catch (Exception ex)
        {

            throw;
        }

    }

    /// Create actual elements of export excel file
    /// 
    /// </summary>
    /// <param name="cel"></param>
    /// <param name="entity_name"></param>
    private void createElements(Cells cel, string entity_name)
    {
        try
        {
            //DataSet ds_entity_list = get_Entity_list(entity_name, "export_report");
            DataSet ds_export_data = get_Export_Data(entity_name, "export_report");
            int total_row_count = ds_export_data.Tables[0].Rows.Count;
            for (int i = 0; i < total_row_count; i++)
            {
                cel[i + 1, 0].PutValue(Convert.ToString(ds_export_data.Tables[0].Rows[i]["name"]));
                cel[i + 1, 1].PutValue(Convert.ToString(ds_export_data.Tables[0].Rows[i]["std_attributes"]));
                cel[i + 1, 2].PutValue(Convert.ToString(ds_export_data.Tables[0].Rows[i]["ud_attributes"]));
                cel[i + 1, 3].PutValue(Convert.ToString(ds_export_data.Tables[0].Rows[i]["doc_attributes"]));
            }



        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    /// Get data according to passed facility id and entity name .
    /// 
    /// </summary>
    /// <param name="entity_name"></param>
    /// <param name="MI_report_type"></param>
    /// <returns></returns>
    private DataSet get_Export_Data(string entity_name, string MI_report_type)
    {
        DataSet ds = new DataSet();
        try
        {
            ReportModel am = new ReportModel();
            ReportClient ac = new ReportClient();

            string organization_ids = get_present_designer_contractor();
            am.Entity_name = entity_name;
            am.fk_organization_id = organization_ids;
            //get the attribute template for facility
            dict_facility_template = (Dictionary<string, string>)ViewState["facility_template"];
            string Attribute_template_id = dict_facility_template[Convert.ToString(cmbfacility.SelectedValue)];
            if (Attribute_template_id == "")
                am.Attribute_template_id = null;
            else
                am.Attribute_template_id = dict_facility_template[Convert.ToString(cmbfacility.SelectedValue)];

            am.Facility_id = Convert.ToString(cmbfacility.SelectedValue);
            am.MI_report_type = MI_report_type;

            ds = ac.get_missing_information_report_by_entity(am, SessionController.ConnectionString);
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return ds;
    }

    #endregion


}