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

public partial class App_NewUI_EnergyModelingAddUtilityData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    if (Request.QueryString["pk_facility_utility_data_id"] != null)
                    {
                        if (!Request.QueryString["pk_facility_utility_data_id"].ToString().Equals(""))
                        {
                            string pk_facility_utility_data_id = Request.QueryString["pk_facility_utility_data_id"].ToString();
                            //SessionController.Users_.Profileid = pk_project_id;
                            BindUtilityDataProfile(pk_facility_utility_data_id);
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

    private void BindUtilityDataProfile(string pk_facility_utility_data_id)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            obj_energy_plus_model.Pk_energymodel_facility_billing_statements = new Guid(pk_facility_utility_data_id);
            ds = obj_energy_plus_client.Get_Energy_Modeling_Utility_data_Profile(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                txt_type_of_service.Text = ds.Tables[0].Rows[0]["Types_of_services"].ToString();
                txt_meter.Text = ds.Tables[0].Rows[0]["Meter#"].ToString();
                rdpstartdate.SelectedDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["READ_date"].ToString());
                txt_previous.Text = ds.Tables[0].Rows[0]["Previous"].ToString();
                txt_current.Text = ds.Tables[0].Rows[0]["Curren"].ToString();
                txt_multiplier.Text = ds.Tables[0].Rows[0]["Multiplier"].ToString();
                txt_usage.Text = ds.Tables[0].Rows[0]["Usage"].ToString();
                txt_amount.Text = ds.Tables[0].Rows[0]["amount"].ToString();
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
            if (Request.QueryString["pk_facility_utility_data_id"] != null)
            {
                if (!Request.QueryString["pk_facility_utility_data_id"].ToString().Equals(""))
                {
                    obj_energy_plus_model.Pk_energymodel_facility_billing_statements = new Guid(Request.QueryString["pk_facility_utility_data_id"].ToString());
                }
                else
                {
                    obj_energy_plus_model.Pk_energymodel_facility_billing_statements = Guid.Empty;
                }
            }
            obj_energy_plus_model.Type_of_service = txt_type_of_service.Text.ToString();
            obj_energy_plus_model.Meter=txt_meter.Text.ToString();
            obj_energy_plus_model.Read_date = (DateTime)rdpstartdate.SelectedDate;
            obj_energy_plus_model.Previous = txt_previous.Text.ToString();
            obj_energy_plus_model.Current = txt_current.Text.ToString();
            obj_energy_plus_model.Multiplier = txt_multiplier.Text.ToString();
            obj_energy_plus_model.Usage = txt_usage.Text.ToString();
            obj_energy_plus_model.Amount = txt_amount.Text.ToString();
            obj_energy_plus_model.Fk_em_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            obj_energy_plus_model.User_id = new Guid(SessionController.Users_.UserId);
            obj_energy_plus_client.Insert_update_facility_utility_data(obj_energy_plus_model, SessionController.ConnectionString);

            //if (Convert.ToString(ds.Tables[0].Rows[0]["profile_id"]) != null)
            //SessionController.Users_.Profileid = Convert.ToString(ds.Tables[0].Rows[0]["profile_id"]);
            //hf_id.Value = SessionController.Users_.Profileid;
            Page.ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}