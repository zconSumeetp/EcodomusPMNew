using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using EnergyPlus;
using System.Data;
using Telerik.Web.UI;

public partial class App_NewUI_EnergyModelingAssignSchedule : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {
                BindAssignScheduleGrid();
            
            }
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_height();", true);
    }

    private void BindAssignScheduleGrid()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            if (SessionController.Users_.Em_facility_id != null && SessionController.Users_.Profileid != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
                ds = obj_energy_plus_client.Get_Energy_Modeling_Unassigned_Compact_Schedule(obj_energy_plus_model, SessionController.ConnectionString);
                rg_schedule.DataSource = ds;
                rg_schedule.DataBind();
            }
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
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void rg_schedule_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void rg_schedule_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            
            throw ex;
        }

    }
    protected void btnSearchClick(object sender, ImageClickEventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void btn_assign_schedule_Click(object sender, EventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        string simulation_ids = "";
        try
        {
            foreach (GridDataItem item in rg_schedule.Items)
            {
                if (item.Selected)
                {
                    simulation_ids = simulation_ids + item["pk_energymodel_schedule_id"].Text + ",";
                }
            
            }
            if (simulation_ids.Length > 0)
            {
                simulation_ids = simulation_ids.Substring(0, simulation_ids.Length - 1);
            }
            obj_energy_plus_model.Simulation_schedule_ids = simulation_ids;
            obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
            if (Request.QueryString["pk_entity_id"] != null && Request.QueryString["entity_name"] != null)
            {
                obj_energy_plus_model.Fk_entity_id = new Guid(Request.QueryString["pk_entity_id"].ToString());
                obj_energy_plus_model.entityname = Request.QueryString["entity_name"].ToString();
            }
           
            obj_energy_plus_client.Insert_Update_Energy_Modeling_Entity_Schedule_Linkup(obj_energy_plus_model, SessionController.ConnectionString);
            lbl_msg.Text = "Schedule is assigned";
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
}