using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using User;
using Telerik.Web.UI;
using EnergyPlus;
using EcoDomus.Session;

public partial class App_NewUI_EnergyModelingAddProject : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    // if (hf_is_first_time.Value.Equals("Y"))
                    // {
                    if (Request.QueryString["action"] != null)
                    {
                        if (Request.QueryString["action"].ToString().Equals("U"))
                        {
                            if (Request.QueryString["pk_project_id"] != null)
                            {
                                if (!Request.QueryString["pk_project_id"].ToString().Equals(""))
                                {
                                    string pk_project_id = Request.QueryString["pk_project_id"].ToString();
                                    SessionController.Users_.Profileid = pk_project_id;
                                    BindProjectProfile(pk_project_id);
                                }
                            }
                        }
                    }
                    //hf_is_first_time.Value = "N";
                    //}
                }
            }
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
       
    }

    private void BindProjectProfile(string pk_project_id)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            obj_energy_plus_model.pk_profileid = new Guid(pk_project_id);
            ds = obj_energy_plus_client.Get_Energy_Modeling_Project_Profile(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                txt_project_name.Text = ds.Tables[0].Rows[0]["profile_name"].ToString();
                txt_description.Text = ds.Tables[0].Rows[0]["description"].ToString();
                btn_save.Text = "Update";
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
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "CloseWindow();", true);

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
  
    protected void btn_save_Click(object sender, EventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            if (Request.QueryString["pk_project_id"] != null)
            {
                if (!Request.QueryString["pk_project_id"].ToString().Equals(""))
                {
                    obj_energy_plus_model.pk_profileid = new Guid(Request.QueryString["pk_project_id"].ToString());
                }
            }

            if (Request.QueryString["action"] != null)
            {
                if (Request.QueryString["action"].ToString().Equals("I"))
                {
                    obj_energy_plus_model.pk_profileid = Guid.Empty;
                }
            }

            obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            obj_energy_plus_model.Name = txt_project_name.Text;
            obj_energy_plus_model.Description = txt_description.Text;
            DataSet ds=  obj_energy_plus_client.Insert_Update_EM_Simulation_Profile(obj_energy_plus_model, SessionController.ConnectionString);
            if ( Convert.ToString( ds.Tables[0].Rows[0]["profile_id"])!=null)
            SessionController.Users_.Profileid = Convert.ToString( ds.Tables[0].Rows[0]["profile_id"]);
            hf_id.Value = SessionController.Users_.Profileid;
            Page.ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
}