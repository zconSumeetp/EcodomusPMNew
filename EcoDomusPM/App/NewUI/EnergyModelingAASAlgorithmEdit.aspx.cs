using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EnergyPlus;
using EcoDomus.Session;
using System.Data;

public partial class App_NewUI_EnergyModelingAASAlgorithmEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["pk_algorithm_id"] != "")
                {
                    get_simulation_algorithm_record();

                }
            }
        }


        catch (Exception es)
        {
            throw es;
        }
    }

    public void get_simulation_algorithm_record()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        obj_energy_plus_model.Pk_algorithm_id = new Guid(Request.QueryString["pk_algorithm_id"].ToString());
        ds = obj_energy_plus_client.Get_Energy_Modeling_simulation_algorithm_record(obj_energy_plus_model, SessionController.ConnectionString);
        txt_description.Text = ds.Tables[0].Rows[0]["Message"].ToString();
        ddlComparision.SelectedValue = ds.Tables[0].Rows[0]["Comparision_Operator"].ToString();
        ddlTolarece.SelectedValue = ds.Tables[0].Rows[0]["Tolerance_Operator"].ToString();
        txttol.Text = ds.Tables[0].Rows[0]["Tolerance"].ToString();
        ddlImpactOperator.Text = ds.Tables[0].Rows[0]["Impact_Operator"].ToString();
        txtOmniName.Text = ds.Tables[0].Rows[0]["Omni_Class"].ToString();
        txtBASAttrName.Text = ds.Tables[0].Rows[0]["Attribute_Name"].ToString();
        txtIDDClass.Text= ds.Tables[0].Rows[0]["IDD_Class"].ToString();
        txtIDDClassField.Text = ds.Tables[0].Rows[0]["IDD_Class_Field"].ToString();
        txtImpact.Text = ds.Tables[0].Rows[0]["Impact"].ToString();
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
    protected void lbtn_save_Click(object sender, EventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        string abc = Request.QueryString.ToString();

        try
        {
            if (Request.QueryString["pk_algorithm_id"] == "")
                obj_energy_plus_model.Pk_algorithm_id = Guid.Empty;
            else
                obj_energy_plus_model.Pk_algorithm_id = new Guid(Request.QueryString["pk_algorithm_id"].ToString());

            obj_energy_plus_model.Fk_em_facility_id = new Guid(SessionController.Users_.Em_facility_id);

            if (SessionController.Users_.Profileid == null)
                obj_energy_plus_model.pk_profileid = Guid.Empty;
            else
                obj_energy_plus_model.pk_profileid=new Guid(SessionController.Users_.Profileid.ToString());
            obj_energy_plus_model.Message = txt_description.Text.ToString();
            obj_energy_plus_model.iDD_class = txtIDDClass.Text.ToString();
            obj_energy_plus_model.iDD_class_field = txtIDDClassField.Text.ToString();
            obj_energy_plus_model.Omni_class = txtOmniName.Text.ToString();
            obj_energy_plus_model.Attribute_name = txtBASAttrName.Text.ToString();
            obj_energy_plus_model.Comparision_operator = ddlComparision.SelectedItem.Text.ToString();
            obj_energy_plus_model.Tolerance_operator = ddlTolarece.SelectedItem.Text.ToString();
            obj_energy_plus_model.Tolerance = float.Parse(txttol.Text.ToString());
            obj_energy_plus_model.Impact_operator = ddlImpactOperator.Text.ToString();
            obj_energy_plus_model.Impact = float.Parse(txtImpact.Text.ToString()); 
            obj_energy_plus_model.Pk_simulation_AAS_id = new Guid(Request.QueryString["pk_simulation_AAS_id"].ToString());
            obj_energy_plus_client.Insert_Energy_Modeling_simulation_algorithm_record(obj_energy_plus_model, SessionController.ConnectionString);
            Page.ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
        }

        catch (Exception es)
        {

            throw es;
        }
    }
}