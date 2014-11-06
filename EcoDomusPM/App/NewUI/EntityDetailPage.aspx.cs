using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Collections;
using System.Data;
using EcoDomus.Session;
using EnergyPlus;

public partial class App_UserControls_UserControlNewUI_EntityDetailPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {
                string entity = Request.QueryString["entity_name"].ToString();
                string facility_id = Request.QueryString["facility_id"].ToString();
                DataTable dt = GetChildDataTables(entity, facility_id);
                BindEntityDetailsGrid(dt, entity);
            }
        }
    }

    private void BindEntityDetailsGrid(DataTable dt,string entity_name)
    {
        try
        {
            rg_entity_import_details.MasterTableView.Columns[0].HeaderText = entity_name;
            rg_entity_import_details.DataSource = dt;
            rg_entity_import_details.DataBind();
            Page.ClientScript.RegisterStartupScript(GetType(), "manage_height", "adjust_height();", true);
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }

    protected void ibtn_close_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "CloseWindow();", true);

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected DataTable GetChildDataTables(string objectName,string facility_id)
    {
        DataSet ds_facility = new DataSet();
        DataSet ds_space = new DataSet();
        DataSet ds_zone = new DataSet();
        DataSet ds_zonelist = new DataSet();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        SimulationFileModel obj_simulation_file_model = new SimulationFileModel();
        DataTable facilility = new DataTable("Facility");
        DataTable space = new DataTable("Space");
        DataTable location = new DataTable("Location");
        DataTable zone = new DataTable("Zone");
        DataTable System = new DataTable("System");
        DataTable zonelist = new DataTable("ZoneList");
        DataSet ds = new DataSet();
        DataTable report = new DataTable();
        try
        {
            //obj_simulation_file_model.PK_FILE_ID = new Guid("136B8F03-C7D0-4B67-BD1F-8203637ACC1F");
            HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
            
              //  if (SessionController.Users_.FileID != null)
             //   {
                    if (!facility_id.Equals(""))
                    {
                        obj_simulation_file_model.PK_FACILITY_ID = Guid.Parse(Cache["hf_facility_id"].ToString());
                       
                            obj_simulation_file_model.PK_FILE_ID = new Guid(SessionController.Users_.FileID);
                            obj_energy_plus_model.Zone_xml = Cache["Zone_xml"].ToString();
                            obj_energy_plus_model.System_xml = Cache["System_xml"] .ToString();
                            obj_energy_plus_model.Zonelist_xml = Cache["ZoneList_xml"].ToString();
                            obj_energy_plus_model.Fk_facility_id = Guid.Parse(Cache["hf_facility_id"].ToString());
                            obj_energy_plus_model.entityname =Request.QueryString["entity_name"].ToString();

                            
                            if (objectName.Equals("Facility", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ds_facility = obj_energy_plus_client.Get_energy_modeling_entity_details(obj_energy_plus_model, SessionController.ConnectionString);
                                facilility = (DataTable)ds_facility.Tables[0];
                                report.Merge(facilility);
                            }

                            if (objectName.Equals("Location", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ds_facility = obj_energy_plus_client.Get_energy_modeling_entity_details(obj_energy_plus_model, SessionController.ConnectionString);
                                location = (DataTable)ds_facility.Tables[0];
                                report.Merge(location);
                            }
                            if (objectName.Equals("Systems", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ds_zone = obj_energy_plus_client.Get_energy_modeling_entity_details(obj_energy_plus_model, SessionController.ConnectionString);
                                System = (DataTable)ds_zone.Tables[0];
                                report.Merge(System);
                            }

                            if (objectName.Equals("Zones",StringComparison.CurrentCultureIgnoreCase))
                            {
                                ds_zone = obj_energy_plus_client.Get_energy_modeling_entity_details(obj_energy_plus_model, SessionController.ConnectionString);
                                zone = (DataTable)ds_zone.Tables[0];
                                report.Merge(zone);
                            }
                            if (objectName.Equals("ZoneList", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ds_zonelist = obj_energy_plus_client.Get_energy_modeling_entity_details(obj_energy_plus_model, SessionController.ConnectionString);
                                zonelist = (DataTable)ds_zonelist.Tables[0];
                                report.Merge(zonelist);
                            }
                            //if (objectName.Equals("Zone"))
                            //{
                            //    ds_zone = obj_energy_plus_client.Get_Simulation_Zonelist_Validation_Details(obj_simulation_file_model, SessionController.ConnectionString);
                            //    zone = (DataTable)ds_zone.Tables[0];
                            //    report.Merge(zone);
                            //}

                            
                            //ArrayList rows = new ArrayList();
                            //int cntRow = report.Rows.Count;
                            //foreach (DataRow dr in report.Rows)
                            //{
                            //    string val = dr["CODE"].ToString();
                            //    if (val.Equals("1"))
                            //    {
                            //        rows.Add(dr);
                            //    }
                            //}

                            //for (int i = 0; i < rows.Count; i++)
                            //{
                            //    report.Rows.Remove((DataRow)rows[i]);
                            //}
                        
                    }
               // }
           
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return report;
    }
    protected void rg_entity_import_details_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            string entity = Request.QueryString["entity_name"].ToString();
            string facility_id = Request.QueryString["facility_id"].ToString();
            DataTable dt = GetChildDataTables(entity, facility_id);
            BindEntityDetailsGrid(dt, entity);

        }
        catch (Exception ex)
        {
            
            throw ex;
        }

    }
    protected void rg_entity_import_details_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            string entity = Request.QueryString["entity_name"].ToString();
            string facility_id = Request.QueryString["facility_id"].ToString();
            DataTable dt = GetChildDataTables(entity, facility_id);
            BindEntityDetailsGrid(dt, entity);

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
}