using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using Report;
using Telerik.Web.UI;
using Aspose.Cells;
using System.IO;
using System.Threading;
using System.Globalization;

public partial class App_Reports_COBieQc : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        try
        {
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
                        ckbox_major.Checked = true;
                        bindfacility();
                        getphaseid();
                        rg_sheet_name.Visible = false;


                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);

            }
        }



        catch (Exception ex)
        {
            throw ex;
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

    protected void bindfacility()
    {
        string strproject_id;
        string strorganization_id;
        try
        {
            strproject_id = SessionController.Users_.ProjectId.ToString();
            strorganization_id = SessionController.Users_.OrganizationID.ToString();
            ReportClient rc = new ReportClient();
            ReportModel rm = new ReportModel();
            rm.fkproject_id = strproject_id;
            DataSet ds = rc.proc_bind_facility_dropdown_for_cobieqc(rm, SessionController.ConnectionString);
            ddlFacility.DataSource = ds;
            ddlFacility.DataTextField = "name";
            ddlFacility.DataValueField = "pk_facility_id";
            ddlFacility.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void getphaseid()
    {

        try
        {
            ReportClient rc = new ReportClient();
            ReportModel rm = new ReportModel();
            rm.fkproject_id = SessionController.Users_.ProjectId.ToString();
            Session["ProjectId"] = SessionController.Users_.ProjectId.ToString();
            rm.fk_organization_id = SessionController.Users_.OrganizationID.ToString();
            DataSet ds = rc.proc_get_pahse_id(rm, SessionController.ConnectionString);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)

                    Session["Phase_id"] = ds.Tables[0].Rows[0]["fk_phase_id"].ToString();
                else
                    Session["Phase_id"] = "00000000-0000-0000-0000-000000000000";

                if (Session["Phase_id"].ToString() == "00000000-0000-0000-0000-000000000000")
                {
                    string nw1 = "<script language='javascript'>alert('No Phase selected for current project..! \\n Please select the Phase for the project.');window.location = '../Settings/ProjectMenu.aspx?pk_project_id=" + SessionController.Users_.ProjectId.ToString() + "&Flag=SPP&pagevalue=ProjectProfile';</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script", nw1);

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void btnSubmitDetails_Click(object sender, EventArgs e)
    {
        try
        {
            Guid entity_id = new Guid("00000000-0000-0000-0000-000000000000");
            bind_error_grid(entity_id, "Bind");
        }
        catch (Exception ex)
        {
            throw;
        }
    }
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        try
        {
            Export_error_grid();
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    private void Export_error_grid()
    {
        try
        {
            ReportClient rc = new ReportClient();
            ReportModel rm = new ReportModel();
            rm.fk_organization_id = SessionController.Users_.OrganizationID.ToString();
            rm.fk_phase_id = Session["Phase_id"].ToString();
            rm.fkproject_id = SessionController.Users_.ProjectId.ToString();
            rm.Facility_id = ddlFacility.SelectedValue.ToString();
            if (ckbox_major.Checked)
                rm.majorflag = "Y";
            else 
                rm.majorflag = "N";
            DataSet ds = rc.proc_generate_report_for_cobieqc(rm, SessionController.ConnectionString);

            if (ds.Tables.Count > 0)
            {
                DataSet dset = new DataSet();
                DataSet dtset = new DataSet();
                string[] ExcelSheetName = new string[100];
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    dtset = get_data(Convert.ToString(ds.Tables[0].Rows[i][1]));
                    DataTable db = dtset.Tables[0];
                    db.TableName = Convert.ToString(ds.Tables[0].Rows[i][0]);
                    ExcelSheetName[i] = Convert.ToString(ds.Tables[0].Rows[i][0]);
                    dtset.Tables.Remove(Convert.ToString(ds.Tables[0].Rows[i][0]));
                    dset.Tables.Add(db);

                }

                //// for aspose license
                //Aspose.Cells.License license = new Aspose.Cells.License();
                //license.SetLicense("Aspose.Cells.lic");

                Workbook workbook = new Workbook();
                Worksheet sheetfacility = workbook.Worksheets[0];
                sheetfacility.Name = ExcelSheetName[0];
                Aspose.Cells.Style style = workbook.DefaultStyle;
                style.Font.Name = "Tahoma";
                workbook.DefaultStyle = style;

                CreateExcelData(workbook, dset, ExcelSheetName);
            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    private void CreateExcelData(Workbook workbook, DataSet dset, Array ExcelSheetName)
    {
        string[] ExcelColumn = new string[27] { "xx", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };

        int WorksheetsNo = 1;
        for (int dstable = 0; dstable < dset.Tables.Count; dstable++)
        {
            Cells cells = workbook.Worksheets[dstable].Cells;
            CreateHeader(cells, dset.Tables[dstable]);

            int i = 2;
            for (int j = 0; j < dset.Tables[dstable].Rows.Count; j++)
            {

                for (int k = 1; k < dset.Tables[dstable].Columns.Count; k++)
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
            if (ExcelSheetName.Length > WorksheetsNo)
            {
                workbook.Worksheets.Add();
                Worksheet sheet = workbook.Worksheets[WorksheetsNo];
                sheet.Name = (string)ExcelSheetName.GetValue(WorksheetsNo);
                WorksheetsNo++;
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
        string ExcelfileName = Convert.ToString(ddlFacility.Text) + "_" + System.DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";

        string strpath = ExcelFiles_serverpath + "\\" + ExcelfileName;
        workbook.Save(strpath);
        Response.Redirect(ExcelFiles + "//" + ExcelfileName);
    }

    private void CreateHeader(Cells cells, DataTable dt)
    {
        string[] ExcelColumn = new string[27] { "xx", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };
        for (int i = 1; i < dt.Columns.Count; i++)
        {
            string str = ExcelColumn[i].ToString() + "1";
            cells[str].PutValue(dt.Columns[i].ColumnName);
        }
    }

    private void bind_error_grid(Guid entity_id, string Refresh_flag)
    {
        //string fk = SessionController.Users_.facilityID.ToString();
        ReportClient rc = new ReportClient();
        ReportModel rm = new ReportModel();
        rm.fk_organization_id = SessionController.Users_.OrganizationID.ToString();
        rm.fk_phase_id = Session["Phase_id"].ToString();
        rm.fkproject_id = SessionController.Users_.ProjectId.ToString();
        if (ddlFacility.SelectedValue.ToString() == "")
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ValidateFacility();", true);

        }
        else
        {
            rm.Facility_id = ddlFacility.SelectedValue.ToString();
            if (ckbox_major.Checked)
                rm.majorflag = "Y";
            else
                rm.majorflag = "N";
            //  rm.Refresh_flag = Refresh_flag;
            //  rm.fk_entityids = Convert.ToString(entity_id);
            DataSet ds = rc.proc_generate_report_for_cobieqc(rm, SessionController.ConnectionString);

            //while ( ds.Tables[0].Rows.Count> 0)
            //{
            //  Int32 contact_count = Convert.ToInt32(  ds.Tables[0].Rows[0]["Contact_count"]);
            rg_sheet_name.Visible = true;

            rg_sheet_name.DataSource = ds;
            rg_sheet_name.DataBind();
            if (ds.Tables.Count > 0)
                btnExcel.Visible = true;
        }
        //}
    }
    protected void rg_sheet_name_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        //if (e.Item.OwnerTableView.Name.Equals("error_grid"))
        //{
        //    Guid id = new Guid();
        //    if (e.CommandName == "Name")
        //    {
        //        id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ID"].ToString());
        //    }
        //}

        Guid entity_Id = new Guid();
        if (e.CommandName == "refresh")
        {
            entity_Id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["fk_entity_id"].ToString());
            bind_error_grid(entity_Id, "refresh");

            //(((GridDataItem)e.Item)).ChildItem.NestedTableViews[0].DataSource = get_data(Convert.ToString(entity_Id));
            //(((GridDataItem)e.Item)).ChildItem.NestedTableViews[0].DataBind();            

            foreach (GridItem item in e.Item.OwnerTableView.Items)
            {
                if (Convert.ToString(((System.Data.DataRowView)(item.DataItem)).Row.ItemArray[1]) == Convert.ToString(entity_Id))
                {
                    item.Expanded = true;
                }
            }
        }


    }
    protected void rg_sheet_name_DetailTableDataBind(object sender, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
    {
        try
        {
            GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
            if (e.DetailTableView.Name.Equals("error_grid"))
            {
                e.DetailTableView.DataSource = get_data(dataItem.GetDataKeyValue("fk_entity_id").ToString());
                //// e.DetailTableView.DataBind();
                // e.DetailTableView.Columns[0].Visible = true;
                // e.DetailTableView.Columns[1].Visible = true;

                //   e.DetailTableView.Visible=
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    protected DataSet get_data(string fk_entity_id)
    {
        ReportClient rc = new ReportClient();
        ReportModel rm = new ReportModel();
        rm.fk_entityids = fk_entity_id.ToString();
        rm.fk_organization_id = SessionController.Users_.OrganizationID.ToString();
        rm.fkproject_id = SessionController.Users_.ProjectId.ToString();
        rm.fk_phase_id = Session["Phase_id"].ToString();
        rm.Facility_id = ddlFacility.SelectedValue.ToString();
        if (ckbox_major.Checked)
            rm.majorflag = "Y";
        else
            rm.majorflag = "N";
        DataSet ds = rc.proc_bind_error_grid_for_entity(rm, SessionController.ConnectionString);
        return ds;
    }

}