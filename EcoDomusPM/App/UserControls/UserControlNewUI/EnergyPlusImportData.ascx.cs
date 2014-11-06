using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attributes;
using EnergyPlus;
using System.Data;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Collections;
using System.Web.Configuration;
using System.IO;
using System.Text;
using EcoDomus.Energymodeling;
//using EnergyModelingtIDFImport;

public partial class App_UserControls_EnergyPlusImportData : System.Web.UI.UserControl
{
    RadProgressContext progress;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (hf_is_loaded.Value.Equals("No"))
            {
                //bindIDFValidationGrid();
                rgEnergySimulation.DataSource = string.Empty;
                rgEnergySimulation.DataBind();
                hf_is_loaded.Value = "Yes";
            }
            
        }
    }

    private void Bind_Energy_Simulation_Grid()
    {
        DataSet ds_facility = new DataSet();
        DataSet ds_space = new DataSet();
        DataSet ds_zone = new DataSet();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        SimulationFileModel obj_simulation_file_model = new SimulationFileModel();
        DataTable facilility = new DataTable("Facility");
        DataTable space = new DataTable("Space");
        DataTable location = new DataTable("Location");
        DataTable zone = new DataTable("Zone");
        DataSet ds = new DataSet();
        DataTable report = new DataTable();
       
        try
        {
            //obj_simulation_file_model.PK_FILE_ID = new Guid("136B8F03-C7D0-4B67-BD1F-8203637ACC1F");
            HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
            if (hf_facility_id != null)
            {

                if (SessionController.Users_.FileID != null)
                {
                    if (!hf_facility_id.Value.Equals(""))
                    {
                        obj_simulation_file_model.PK_FACILITY_ID = Guid.Parse(hf_facility_id.Value);
                    }
                    obj_simulation_file_model.PK_FILE_ID = new Guid(SessionController.Users_.FileID);
                    ds_facility = obj_energy_plus_client.Get_Simulation_Building_Validation_Details(obj_simulation_file_model, SessionController.ConnectionString);
                    ds_space = obj_energy_plus_client.Get_Simulation_Zone_Validation_Details(obj_simulation_file_model, SessionController.ConnectionString);
                    ds_zone = obj_energy_plus_client.Get_Simulation_Zonelist_Validation_Details(obj_simulation_file_model, SessionController.ConnectionString);

                    if (ds_facility.Tables.Count >= 2)
                    {
                        if (ds_facility.Tables[1] != null)
                        {
                            facilility = (DataTable)ds_facility.Tables[1];
                        }
                    }
                    if (ds_facility.Tables.Count >= 2)
                    {
                        if (ds_facility.Tables[2] != null)
                        {
                            location = (DataTable)ds_facility.Tables[2];
                        }
                    }
                    if (ds_space.Tables.Count >= 2)
                    {
                        if (ds_space.Tables[1] != null)
                        {
                            space = (DataTable)ds_space.Tables[1];
                        }
                    }
                    if (ds_zone.Tables.Count >= 2)
                    {
                        if (ds_zone.Tables[1] != null)
                        {
                            zone = (DataTable)ds_zone.Tables[1];
                        }
                    }
                    report.Merge(facilility, true);
                    report.Merge(location, true);
                    report.Merge(space, true);
                    report.Merge(zone, true);
                    ds.Tables.Add(report);
                    rgEnergySimulation.DataSource = ds;
                    rgEnergySimulation.DataBind();
                    if (ds.Tables[0] == null)
                    {
                        rgEnergySimulation.DataSource = string.Empty;
                        rgEnergySimulation.DataBind();
                    }

                }
                if (ds.Tables.Count == 0)
                {
                        rgEnergySimulation.DataSource = string.Empty;
                        rgEnergySimulation.DataBind();
                }
            }
            
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    protected DataTable GetChildDataTables(string objectName)
    {
        DataSet ds_facility = new DataSet();
        DataSet ds_space = new DataSet();
        DataSet ds_zone = new DataSet();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        SimulationFileModel obj_simulation_file_model = new SimulationFileModel();
        DataTable facilility = new DataTable("Facility");
        DataTable space = new DataTable("Space");
        DataTable location = new DataTable("Location");
        DataTable zone = new DataTable("Zone");
        DataSet ds = new DataSet();
        DataTable report = new DataTable();
        try
        {
            //obj_simulation_file_model.PK_FILE_ID = new Guid("136B8F03-C7D0-4B67-BD1F-8203637ACC1F");
            HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
            if (hf_facility_id != null)
            {
                if (SessionController.Users_.FileID != null)
                {
                    if (!hf_facility_id.Value.Equals(""))
                    {
                        obj_simulation_file_model.PK_FACILITY_ID = Guid.Parse(hf_facility_id.Value);
                        if (SessionController.Users_.FileID != null)
                        {
                            obj_simulation_file_model.PK_FILE_ID = new Guid(SessionController.Users_.FileID);
                            obj_simulation_file_model.PK_FACILITY_ID = new Guid(SessionController.Users_.facilityID);
                            ds_facility = obj_energy_plus_client.Get_Simulation_Building_Validation_Details(obj_simulation_file_model, SessionController.ConnectionString);
                            ds_space = obj_energy_plus_client.Get_Simulation_Zone_Validation_Details(obj_simulation_file_model, SessionController.ConnectionString);
                            ds_zone = obj_energy_plus_client.Get_Simulation_Zonelist_Validation_Details(obj_simulation_file_model, SessionController.ConnectionString);
                            if (ds_facility.Tables[0] != null)
                            {
                                facilility = (DataTable)ds_facility.Tables[0];
                            }
                            if (ds_facility.Tables[0] != null)
                            {
                                location = (DataTable)ds_facility.Tables[0];
                            }
                            if (ds_space.Tables[0] != null)
                            {
                                space = (DataTable)ds_space.Tables[0];
                            }
                            //if (ds_zone.Tables[0] != null)
                            //{
                            //    zone = (DataTable)ds_zone.Tables[0];
                            //}
                            if (objectName.Equals("Facility"))
                            {
                                report.Merge(facilility);
                            }
                            if (objectName.Equals("Space"))
                            {
                                report.Merge(space);

                            }
                            if (objectName.Equals("Location"))
                            {
                                report.Merge(location);

                            }
                            if (objectName.Equals("Zone"))
                            {
                                report.Merge(space);

                            }
                            ArrayList rows = new ArrayList();
                            int cntRow = report.Rows.Count;
                            foreach (DataRow dr in report.Rows)
                            {
                                string val = dr["CODE"].ToString();
                                if (val.Equals("1"))
                                {
                                    rows.Add(dr);
                                }
                            }

                            for (int i = 0; i < rows.Count; i++)
                            {
                                report.Rows.Remove((DataRow)rows[i]);
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return report;
    }
    protected void rgEnergySimulation_DetailTableDataBind(object source, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
    {
        try
        {
            GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
            string name = e.DetailTableView.Name;
            if (name.Equals("Report"))
            {
                rgEnergySimulation.DataSource = GetDataTables();

            }
            if (name.Equals("MissingObject"))
            {
                string objectName = dataItem.GetDataKeyValue("entity_name").ToString();
                e.DetailTableView.DataSource = GetChildDataTables(objectName);

            }

            RadGrid rg = (RadGrid)e.DetailTableView.FindControl("rgEnergySimulationDetails");

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    
    protected void rgEnergySimulation_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        if (!e.IsFromDetailTable)
        {
            try
            {
                rgEnergySimulation.DataSource = GetDataTables();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_frame_height();", true);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
    protected DataTable GetDataTables()
    {
        DataTable report = new DataTable();
        try
        {
            DataSet ds_facility = new DataSet();
            DataSet ds_space = new DataSet();
            DataSet ds_zone = new DataSet();
            EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
            EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
            SimulationFileModel obj_simulation_file_model = new SimulationFileModel();
            DataTable facilility = new DataTable("Facility");
            DataTable space = new DataTable("Space");
            DataTable location = new DataTable("Location");
            DataTable zone = new DataTable("Zone");
            DataSet ds = new DataSet();
            HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
            if (hf_facility_id != null)
            {
                if (SessionController.Users_.FileID != null)
                {
                    if (!hf_facility_id.Value.Equals(""))
                    {
                        obj_simulation_file_model.PK_FACILITY_ID = Guid.Parse(hf_facility_id.Value);
                    }
                    if (SessionController.Users_.FileID != null)
                    {
                        obj_simulation_file_model.PK_FILE_ID = new Guid(SessionController.Users_.FileID);
                        ds_facility = obj_energy_plus_client.Get_Simulation_Building_Validation_Details(obj_simulation_file_model, SessionController.ConnectionString);
                        ds_space = obj_energy_plus_client.Get_Simulation_Zone_Validation_Details(obj_simulation_file_model, SessionController.ConnectionString);
                        ds_zone = obj_energy_plus_client.Get_Simulation_Zonelist_Validation_Details(obj_simulation_file_model, SessionController.ConnectionString);
                        if (ds_facility.Tables[1] != null)
                        {
                            facilility = (DataTable)ds_facility.Tables[1];
                        }
                        if (ds_facility.Tables[2] != null)
                        {
                            location = (DataTable)ds_facility.Tables[2];
                        }
                        if (ds_space.Tables[1] != null)
                        {
                            space = (DataTable)ds_space.Tables[1];
                        }
                        if (ds_zone.Tables[0] != null)
                        {
                            zone = (DataTable)ds_zone.Tables[0];
                        }
                        report.Merge(facilility, true);
                        report.Merge(location, true);
                        report.Merge(space, true);
                        report.Merge(zone, true);
                    }
                }
            }
        }

        catch (Exception ex)
        {

            throw ex;
        }
        return report;
    }
    protected void rgEnergySimulation_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            Type type = e.Item.GetType();

            if (e.Item is GridDataItem)
            {
                string str = e.Item.Cells[0].Text;
                string str1 = e.Item.Cells[1].Text;
                string str2 = e.Item.Cells[2].Text;
                string str3 = e.Item.Cells[3].Text;

                if (e.Item.Cells[2].Text.Equals("0"))
                {
                    int i = e.Item.RowIndex;

                }

            }
            if (e.Item is GridNestedViewItem)
            {
                GridNestedViewItem ss = (GridNestedViewItem)e.Item;
            }


            if (e.Item is GridGroupHeaderItem)
            {
                GridGroupHeaderItem groupHeader = (GridGroupHeaderItem)e.Item;
                groupHeader.DataCell.Text = groupHeader.DataCell.Text.Split(':')[1];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    
    protected void rgEnergySimulation_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
           
                HiddenField facilityId = (HiddenField)Page.FindControl("hf_facility_id");
                bindIDFValidationGrid( new Guid(facilityId.Value));
           

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rgEnergySimulation_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            
                HiddenField facilityId = (HiddenField)Page.FindControl("hf_facility_id");
                bindIDFValidationGrid( new Guid(facilityId.Value));
           
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rgEnergySimulation_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        try
        {
           
                HiddenField facilityId = (HiddenField)Page.FindControl("hf_facility_id");
                bindIDFValidationGrid( new Guid(facilityId.Value));
           
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rgEnergySimulation_ItemCommand(object sender, GridCommandEventArgs e)
    {
        DataTable dt = new DataTable();
        try
        {
           // bj_setSync_model.Pk_external_system_configuration_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ImportType"].ToString());
            if (e.CommandName == "details")
            {
                string entityname = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["entity_name"].ToString();
                //Page.ClientScript.RegisterStartupScript(GetType(), "hwa", "view_details();", true);

                //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "view_details(" + entityname + ");", true);
            }
            
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rgEnergySimulation_ItemCreated(object sender, GridItemEventArgs e)
    {
        string facility_id="";
         HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
         if (hf_facility_id != null)
         {
              facility_id = hf_facility_id.Value;
         }
        if (e.Item is GridDataItem)
        {

            //ImageButton editLink = (ImageButton)e.Item.FindControl("img_details");
            //editLink.Attributes["href"] = "#";
            //editLink.Attributes["onclick"] = String.Format("return ShowDetailWindow('{0}','{1}','{2}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["entity_name"], e.Item.ItemIndex, facility_id);
        }
    }
    
    private void Update_Space_Attribute(DataSet ds, int i)
    {
        //AttributeClient obj_attribute_client = new AttributeClient();
        //AttributeModel obj_attribute_model = new AttributeModel();

        EnergyPlusClient obj_attribute_client = new EnergyPlusClient();
        EnergyPlusModel obj_attribute_model = new EnergyPlusModel();
         
          
        StringBuilder strAssetAttributes = new StringBuilder();
        try
        {
            if (ds.Tables[i].Rows.Count > 0)
            {
                Guid pk_group_id=Guid.Empty;
                Guid user_id=Guid.Empty;
                Guid space_id = Guid.Empty;
                Guid zone_id = Guid.Empty;
                string zone_name="";
                strAssetAttributes.Append("<root>");
                for (int j = 0; j < ds.Tables[i].Rows.Count; j++)
                {
                   strAssetAttributes.Append("<folder Name='" + ds.Tables[i].Rows[j]["attribute_name"].ToString() + "' Value='" + ds.Tables[i].Rows[j]["idf_attribute_value"].ToString() + "'></folder>");
                   pk_group_id=new Guid(ds.Tables[i].Rows[j]["attribute_group_id"].ToString());
                   user_id=new Guid(SessionController.Users_.UserId);
                   if (ds.Tables[i].Rows[j]["entity_data_id"].ToString().Equals(""))
                       zone_id = Guid.Empty;
                   else
                       zone_id = new Guid(ds.Tables[i].Rows[j]["entity_data_id"].ToString());
                   if (ds.Tables[i].Rows[j]["attribute_name"].ToString() == "Name")
                       zone_name = ds.Tables[i].Rows[j]["idf_attribute_value"].ToString();
                  //  zone_id=new 
                    //obj_attribute_model.Entiy = ds.Tables[i].Rows[j]["entity_data"].ToString();
                    //if (!ds.Tables[i].Rows[j]["entity_data_id"].ToString().Equals(""))
                    //{
                    //    obj_attribute_model.Entiy_data_id = new Guid(ds.Tables[i].Rows[j]["entity_data_id"].ToString());
                    //}
                    //if (!ds.Tables[i].Rows[j]["pk_attribute_id"].ToString().Equals(""))
                    //{
                    //    obj_attribute_model.Attribute_id = new Guid(ds.Tables[i].Rows[j]["pk_attribute_id"].ToString());
                    //}

                    //obj_attribute_model.Attribute_name = ds.Tables[i].Rows[j]["attribute_name"].ToString();
                    //obj_attribute_model.AttributeDescription = ds.Tables[i].Rows[j]["attribute_description"].ToString();
                    //obj_attribute_model.Attribute_created_on = DateTime.Now;
                    //obj_attribute_model.Attribute_created_by = new Guid(SessionController.Users_.UserId);
                    //obj_attribute_model.Attribute_value = ds.Tables[i].Rows[j]["idf_attribute_value"].ToString();
                    //if (ds.Tables[i].Rows[j]["attribute_uom_id"].ToString().Equals(""))
                    //{
                    //    obj_attribute_model.Attribute_uom_id = Guid.Empty;
                    //}
                    //else
                    //{
                    //    obj_attribute_model.Attribute_uom_id = new Guid(ds.Tables[i].Rows[j]["attribute_uom_id"].ToString());
                    //}
                    //if (!ds.Tables[i].Rows[j]["attribute_group_id"].ToString().Equals(""))
                    //{
                    //    obj_attribute_model.Attribute_group_id = new Guid(ds.Tables[i].Rows[j]["attribute_group_id"].ToString());
                    //}
                    //if (!ds.Tables[i].Rows[j]["attribute_stage_id"].ToString().Equals(""))
                    //{
                    //    obj_attribute_model.Attribute_stage_id = new Guid(ds.Tables[i].Rows[j]["attribute_stage_id"].ToString());
                    //}

                    //obj_attribute_client.InsertUpdateAttribute(obj_attribute_model, SessionController.ConnectionString);

                }
                HiddenField hf_facility_id_zone = (HiddenField)Page.FindControl("hf_facility_id");
                if (hf_facility_id_zone != null)
                {
                    strAssetAttributes.Append("</root>");
                    obj_attribute_model.Pk_group_id = pk_group_id;
                    obj_attribute_model.User_id = user_id;
                    obj_attribute_model.zoneid = zone_id;
                    obj_attribute_model.Name = zone_name;
                    
                    obj_attribute_model.Fk_facility_id = new Guid(hf_facility_id_zone.Value.ToString());
                    obj_attribute_model.Query_str = strAssetAttributes.ToString().Replace("'", "\"");
                    obj_attribute_client.Insert_Update_Energy_Modeling_Zone_Attribute(obj_attribute_model, SessionController.ConnectionString);
                }
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_parent_height();", true);

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void lbtn_next_Click(object sender, EventArgs e)
    {
        try
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void lbtn_back_Click(object sender, EventArgs e)
    {
        try
        {
            GoToPreviousTab();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ibtn_back_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            GoToPreviousTab();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    private void GoToPreviousTab()
    {
        try
        {
            RadTabStrip tabStrip = (RadTabStrip)Page.FindControl("rts_energy_plus");
            RadTab select_data = tabStrip.FindTabByValue("EnergyPlusData");
            select_data.Enabled = true;
            select_data.Selected = true;
            GoToPreviousPageView();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    private void GoToPreviousPageView()
    {
        try
        {
            RadMultiPage rmp_energy_plus = (RadMultiPage)Page.FindControl("rmp_energy_plus");
            RadPageView rpv_data = rmp_energy_plus.FindPageViewByID(@"~/App/UserControls/UserControlNewUI/" + "EnergyPlusData");

            if (rpv_data == null)
            {
                rpv_data = new RadPageView();
                rpv_data.ID = @"~/App/UserControls/UserControlNewUI/" + "EnergyPlusData";
                rmp_energy_plus.PageViews.Add(rpv_data);
            }
            rpv_data.Selected = true;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ibtn_next_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_import_data_Click(object sender, EventArgs e)
    {
        
        try
        {
            lbl_imp_msg.Text = "Importing data....";
            rgEnergySimulation.Visible = true;
           // btn_continue_import.Visible = true;
            HiddenField hf_file_name = (HiddenField)Page.FindControl("hf_file_name");
            HiddenField hf_file_full_path = (HiddenField)Page.FindControl("hf_file_full_path");
            if (hf_file_name != null)
            {
                if (!hf_file_name.Value.Equals(""))
                    {
                        //UploadFileOnServer(hf_file_name.Value, hf_file_full_path.Value);
                       // ImportIDFFile(hf_file_name.Value, hf_file_full_path.Value);
                       
                      // delete objects and its fields of previous imported IDF file
                        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
                        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
                        obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                        obj_energy_plus_client.Delete_energy_modeling_objects_and_objects_fields(obj_energy_plus_model, SessionController.ConnectionString);

                       /* Code with xml obj
                        importIDFFile em_import = new importIDFFile();
                        em_import.ImportIdfFileforEM(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id + "/" + hf_file_name.Value));
                       */
                    /* Dave's Code */
                    
                       //Import IDF file objects and its fields
                        EnergyModelingtIDFImport em_import = new EnergyModelingtIDFImport();
                        em_import.IDF_Import(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id + "/" + hf_file_name.Value), SessionController.Users_.Em_facility_id);
                       // em_import.Import_IDF_File(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id+ "/" + hf_file_name.Value));
                        bindIDFValidationGrid(new Guid(SessionController.Users_.Em_facility_id));
                      
                   
                    

                    
                    }
            }
          
            lbl_imp_msg.Text = "Validation Completed";
            //btn_continue_import.Enabled = true;
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_parent_height();", true);
            //Page.ClientScript.RegisterStartupScript(GetType(), "hwadsd", "adjust_parent_height();", true);
         
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void UploadIDFfile(string fileName, string filePath)
    {
        try
        {
            if (!filePath.Equals(""))
            {
               // File.Copy();
            }
        
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ImportIDFFile(string pSimulatonFileName, string file_path)
    {
        try
        {
            EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
            string ConnectionString = null;
            ConnectionString = SessionController.ConnectionString.ToString();
            Guid PK_FILE_ID = Guid.Empty;
            DataSet ds = new DataSet();
            EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
            SimulationFileModel obj_simulation_file_model = new SimulationFileModel();
            obj_simulation_file_model.SIMULATIONFILENAME = pSimulatonFileName;
            HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
            List<string> object_name = new List<string>();
            //object_name.Add("site:location");
            object_name.Add("zone");
            string system_object = "Sizing:System";
            string zone_object = "zone";
            string zonelist_object = "ZoneList";
            int cnt_records = 0;
            if (hf_facility_id != null)
            {
                if (!hf_facility_id.Value.Equals(""))
                {
                    obj_simulation_file_model.PK_FACILITY_ID = Guid.Parse(hf_facility_id.Value);
                    string Path = Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + hf_facility_id.Value);
                    string[] lines = System.IO.File.ReadAllLines(Path + "/" + pSimulatonFileName);
                    string OneLine = null;
                    bool LineEnds = false;
                                       
                    StringBuilder sb = new StringBuilder();
                    StringBuilder sb_system = new StringBuilder();
                    StringBuilder sb_zone = new StringBuilder();
                    StringBuilder sb_zonelist = new StringBuilder();
                  
                    //read each line of idf, parse it and put it in database
                    DataSet ObjectDataSetFields = new DataSet();
                    obj_energy_plus_model.Obj_name = "zone,Sizing:System";
                    ObjectDataSetFields = obj_energy_plus_client.Get_energy_modeling_object_fields(obj_energy_plus_model, SessionController.ConnectionString);

                    foreach (string line in lines)
                    {
                        string tmp = null;
                        tmp = line;
                        tmp = tmp.Replace(Environment.NewLine, "");
                        tmp = tmp.Trim();

                        if (tmp.Length == 0) continue;
                        if (tmp.StartsWith("!") == true) continue;


                        if (tmp.IndexOf("!") > 0)
                            tmp = tmp.Substring(0, tmp.IndexOf("!"));

                        tmp = tmp.Trim();

                        if (OneLine == null)
                            OneLine = tmp;
                        else
                            OneLine = OneLine + tmp;

                        if (tmp.EndsWith(";") == true)
                        {
                            LineEnds = true;
                        }
                        else
                        {
                            continue;
                        }

                        string[] Splitters = { ",", ";" };
                        string[] Values = OneLine.Split(Splitters, StringSplitOptions.None);

                        for (int i = 0; i < Values.Length; i++)
                            Values[i] = Values[i].Trim();

                        obj_simulation_file_model.IDFOBJECTNAME = Values[0];
                        DataSet ObjectDataSet = new DataSet();
                                            
                        String str_blank="";
                        //create xml for zone and its attribute;  Developer:Priyanka Salave;  Date:26 Feb 2013
                        if (zone_object.ToLower() == Values[0].ToLower())
                        {
                            string zone_name = Values[1].ToString();
                            sb_zone.AppendLine("<Zone  zone_name=\"" + Values[1] + "\">");
                            
                            DataRow[] ZoneRows = ObjectDataSetFields.Tables[0].Select("object_name ='" + Values[0] + "'");
                            for (int i = 0; i < ZoneRows.Count(); i++)
                                if ((i+2) > Values.Count())
                                    sb_zone.AppendLine(" <Attribute  attribute_name=\"" + ZoneRows[i]["field_name"].ToString().Trim() + "\" attribute_value=\"" + str_blank + "\"/>");
                                    
                                else
                                    sb_zone.AppendLine(" <Attribute  attribute_name=\"" + ZoneRows[i]["field_name"].ToString().Trim() + "\" attribute_value=\"" + Values[i + 1].Trim() + "\"/>");

                            sb_zone.AppendLine("</Zone>");
                        }

                        //create xml for System and its attribute;  Developer:Priyanka Salave;  Date:25 Feb 2013
                        if (system_object.ToLower() == Values[0].ToLower())
                        {
                            string sys_name = Values[1].ToString();
                            sb_system.AppendLine("<System  sys_name=\""+ Values[1]+"\">");

                            DataRow[] Rows = ObjectDataSetFields.Tables[0].Select("object_name ='" + Values[0] + "'");
                            for (int i = 0; i < Rows.Count(); i++)
                                if ((i + 2) > Values.Count())
                                   sb_system.AppendLine(" <Attribute  attribute_name=\"" + Rows[i]["field_name"].ToString().Trim() + "\" attribute_value=\"" + str_blank + "\"/>");
                                   
                                else
                                    sb_system.AppendLine(" <Attribute  attribute_name=\"" + Rows[i]["field_name"].ToString().Trim() + "\" attribute_value=\"" + Values[i + 1].Trim() + "\"/>");

                            sb_system.AppendLine("</System>");
                        }


                        //create xml for zonelist and its zones;  Developer:Priyanka Salave;   Date:28 Feb 2013
                        if (zonelist_object.ToLower() == Values[0].ToLower())
                        {

                            sb_zonelist.AppendLine("<ZoneList  zonelist_name=\"" + Values[1] + "\">");


                            for (int i = 2; i < Values.Count(); i++)
                            {
                                if (Values[i].ToString().Trim()!="")
                                   sb_zonelist.AppendLine(" <Zone  zone_name=\"" + Values[i].ToString().Trim() + "\"/>");
                            }

                            sb_zonelist.AppendLine("</ZoneList>");
                        }



                        if (LineEnds == true)
                        {
                            OneLine = null;
                            LineEnds = false;
                        }
                    }


                    bindIDFValidationGrid(new Guid(hf_facility_id.Value));
                  
                    if (!sb_system.ToString().Equals(string.Empty))
                    {
                        //InsertUpdateSystemFromIDFFile(sb_system.ToString(), new Guid(hf_facility_id.Value));
                        ViewState["System_xml"] = sb_system.ToString();
                        Cache["System_xml"] = sb_system.ToString();
                        Cache["hf_facility_id"] = hf_facility_id.Value;
                                             
                        sb_system.Clear();
                        HiddenField hf_system_xml = (HiddenField)Page.FindControl("hf_system_xml");
                        if (hf_system_xml != null)
                        {
                            hf_system_xml.Value = sb_system.ToString();
                        }
                       

                    }

                    if (!sb_zone.ToString().Equals(string.Empty))
                    {
                        // InsertUpdateZoneFromIDFFile(sb_zone.ToString(), new Guid(hf_facility_id.Value));
                         ViewState["Zone_xml"] = sb_zone.ToString();
                         Cache["Zone_xml"] = sb_zone.ToString(); 
                        sb_zone.Clear();
                        HiddenField hf_zone_xml = (HiddenField)Page.FindControl("hf_zone_xml");
                        if (hf_zone_xml != null)
                        {
                            hf_zone_xml.Value = sb_zone.ToString();
                        }
                    }

                    if (!sb_zonelist.ToString().Equals(string.Empty))
                    {

                        ViewState["ZoneList_xml"] = sb_zonelist.ToString();
                        Cache["ZoneList_xml"] = sb_zonelist.ToString();
                        sb_zonelist.Clear();
                    }

                   
                                                          
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    public void  bindIDFValidationGrid( Guid facilityId)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            obj_energy_plus_model.Fk_facility_id = facilityId;
            obj_energy_plus_model.Pk_project_id =   String.IsNullOrEmpty(SessionController.Users_.Profileid)? Guid.Empty:new Guid(SessionController.Users_.Profileid);
            ds = obj_energy_plus_client.proc_get_energy_modeling_import_objects_count(obj_energy_plus_model, SessionController.ConnectionString);
            rgEnergySimulation.DataSource = ds;
            rgEnergySimulation.DataBind();
         
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public void InsertUpdateZoneListFromIDFFile(string xml_zoneList, Guid facility_id)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            obj_energy_plus_model.Fk_facility_id = facility_id;
            obj_energy_plus_model.User_id = new Guid(SessionController.Users_.UserId);
            obj_energy_plus_model.Query_str = xml_zoneList;
            obj_energy_plus_client.Insert_update_energy_modeling_zonelist_zone(obj_energy_plus_model, SessionController.ConnectionString);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    public void InsertUpdateSystemFromIDFFile(string xml_system, Guid facility_id)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            obj_energy_plus_model.Fk_facility_id = facility_id;
            obj_energy_plus_model.User_id = new Guid(SessionController.Users_.UserId);
            obj_energy_plus_model.Query_str = xml_system;
           obj_energy_plus_client. Insert_update_energy_model_system_system_attribute(obj_energy_plus_model, SessionController.ConnectionString);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public void InsertUpdateZoneFromIDFFile(string xml_zone, Guid facility_id)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            obj_energy_plus_model.Fk_facility_id = facility_id;
            obj_energy_plus_model.User_id = new Guid(SessionController.Users_.UserId);
            obj_energy_plus_model.Query_str = xml_zone;
            obj_energy_plus_client.Insert_update_energy_model_zone_zone_attribute(obj_energy_plus_model, SessionController.ConnectionString);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void InsertRecords(StringBuilder sb)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            int index = sb.ToString().LastIndexOf(",");
            if (index > 0)
            {
                sb[index] = ' ';
                string value_block = sb.ToString().Trim();
                obj_energy_plus_model.Query_str = value_block;
                obj_energy_plus_client.Insert_Update_Energy_Modeling_IDF_File_Data(obj_energy_plus_model, SessionController.ConnectionString);
            }
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }

    private void UploadFileOnServer(string file_name,string file_path)
    {
        try
        {
            string save_path = "";
                string path = WebConfigurationManager.AppSettings["EnergyPlusFilePath"]+SessionController.Users_.Em_facility_id;
                path=  Server.MapPath(path);
                DirectoryInfo dir_info = new DirectoryInfo(path);
                if (!dir_info.Exists)
                {
                    dir_info.Create();
                    save_path = Path.Combine(path, file_name);
                }
                else
                {
                  
                     save_path = Path.Combine(path, file_name);
                }
                if(File.Exists(save_path))
                {
                    File.Delete(save_path);
                }
                File.Copy(file_path, save_path,true);
           
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }


    #region Not Usable Methods
    #endregion 
    protected void rgEnergySimulation_PageIndexChanged1(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            
                HiddenField facilityId = (HiddenField)Page.FindControl("hf_facility_id");
                bindIDFValidationGrid( new Guid(facilityId.Value));
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "script2", "adjust_parent_height();", true);
          
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void rgEnergySimulation_PageSizeChanged1(object sender, GridPageSizeChangedEventArgs e)
    {

        try
        {
           
                HiddenField facilityId = (HiddenField)Page.FindControl("hf_facility_id");
                bindIDFValidationGrid( new Guid(facilityId.Value));
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "script3", "adjust_parent_height();", true);
            
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    //protected void btn_continue_import_Click(object sender, EventArgs e)
    //{
    //    const int total = 100;
    //    progress = RadProgressContext.Current;
    //    progress.Speed = "N/A";
    //    ProgressBarSimulation(0);
    //    HiddenField facilityId=(HiddenField)Page.FindControl("hf_facility_id");
       
               
    //    try
    //    {
    //        if (facilityId != null)
    //        {
    //            if (ViewState["System_xml"] != null && !ViewState["System_xml"].ToString().Equals(""))
    //            {
    //                InsertUpdateSystemFromIDFFile(ViewState["System_xml"].ToString(), new Guid(facilityId.Value));
    //                // ViewState["System_xml"] = "";
    //            }
    //            ProgressBarSimulation(20);
    //            if (ViewState["Zone_xml"] != null && !ViewState["Zone_xml"].ToString().Equals(""))
    //            {
    //                InsertUpdateZoneFromIDFFile(ViewState["Zone_xml"].ToString(), new Guid(facilityId.Value));
    //                //ViewState["Zone_xml"] = "";
    //            }
    //            ProgressBarSimulation(40);
    //            if (ViewState["ZoneList_xml"] != null && !ViewState["ZoneList_xml"].ToString().Equals(""))
    //            {
    //                InsertUpdateZoneListFromIDFFile(ViewState["ZoneList_xml"].ToString(), new Guid(facilityId.Value));
    //            }
    //            ProgressBarSimulation(60);
    //            if (ViewState["System_xml"] != null && ViewState["Zone_xml"] != null && ViewState["Zone_xml"] != null)
    //            {

    //                bindIDFValidationGrid(ViewState["System_xml"].ToString(), ViewState["Zone_xml"].ToString(), ViewState["ZoneList_xml"].ToString(), new Guid(facilityId.Value));
    //                ViewState["System_xml"] = "";
    //                ViewState["Zone_xml"] = "";
    //                ViewState["ZoneList_xml"] = "";
    //            }
    //            ProgressBarSimulation(80);
               
    //            lbl_imp_msg.Text = "Import is completed";
    //            ProgressBarSimulation(100);
    //            RadProgressArea1.Visible = false;
                
    //        }
           
           
    //    //    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>ConfirmationMessage();</script>", false);
           
           
    //    }
    //    catch (Exception ex)
    //    {
            
    //        throw ex;
    //    }
      
      
    //}

    public void ProgressBarSimulation(int inc)
    {
        int upperlimit;
        if (inc == 100)
        {
            upperlimit = 100;
        }
        else
            upperlimit = inc + 20;

        for (int i = inc; i < (upperlimit+1) ; i++)
        {
            progress.PrimaryTotal = 100;
            progress.PrimaryValue = i;
            progress.PrimaryPercent = i;
            progress.CurrentOperationText = "Step " + i.ToString();
            progress.TimeEstimated = (100 - i) * 100;
            System.Threading.Thread.Sleep(100);
        }
                
          //progress.PrimaryTotal = 1;
          //progress.PrimaryValue = 1;
          //progress.PrimaryPercent = inc;

          //progress.CurrentOperationText = "Step " + inc.ToString();

          //if (!Response.IsClientConnected)
          //{

          //    // break;
          //}

          //progress.TimeEstimated = (100 - (inc / 20)) * 100;

          //System.Threading.Thread.Sleep(1000);
         
         
    }
}