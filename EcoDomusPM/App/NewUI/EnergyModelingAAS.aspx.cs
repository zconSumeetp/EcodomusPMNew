using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EnergyPlus;
using EcoDomus.Session;
using System.Data;

public partial class App_NewUI_EnergyModelingAAS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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
    protected void lbtn_save_Click(object sender, EventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds =new DataSet();
        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {

                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            }
            if (SessionController.Users_.Profileid != null)
            {
                obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
            
            }
            obj_energy_plus_model.Description = txt_description.Text;
            obj_energy_plus_model.IsSimulation = rbtn_simulation.Checked;
            obj_energy_plus_model.IsMeasurement = rbtn_measurement.Checked;
            obj_energy_plus_model.Assumption = rbtn_assumption.Checked;
            obj_energy_plus_model.Approximation = rbtn_approximation.Checked;
            obj_energy_plus_model.Simplification = rbtn_simplification.Checked;
            ds = obj_energy_plus_client.Insert_Update_Energy_Modeling_Simulation_AAS(obj_energy_plus_model, SessionController.ConnectionString);
            Page.ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void lbtn_cancel_Click(object sender, EventArgs e)
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
}