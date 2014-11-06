using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.IO;
using EcoDomus.Session;
using EnergyPlus;
using System.Collections;
using System.Data;
using System.Text;
using System.Data.SQLite;
using System.Data.SqlClient;
using System.Web.Configuration;
using Telerik.Web.UI.Upload;
using Telerik.Web.UI;

public partial class App_UserControls_UserControlNewUI_EnergyModelingSimulation : System.Web.UI.UserControl
{
    string path = "";//"C:\\EnergyPlusV7-0-0\\Outputs";
    System.Data.SQLite.SQLiteConnection SQLiteConn = null;
    System.Data.SqlClient.SqlConnection SQLConn = null;

    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    if (SessionController.Users_.ProfileName != null)
                    {
                        lbl_project_name.Text = SessionController.Users_.ProfileName;
                    }

                    RadProgressArea1.Localization.CurrentFileName = "Simulation Status:";
                    if (SessionController.Users_.Em_Weather_File_Name == null)
                    {
                        GetLastWeatherFile();
                    }

                    GetPath();
                    BindMonthDropDown();
                    BindDayDropDown();
                    BindWeekDayDropDown();
                    //BindYesNoDropDown();
                    BindSimulationParameterGrid();
                    BindRunPeriodGrid();
                    BindTimeStepGrid();
                   
                }
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void GetPath()
    {
        try
        {
            hf_ep_batch_file_path.Value = WebConfigurationManager.AppSettings["EPBatchFilePath"];
            //path = 
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void BindTimeStepGrid()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                if (SessionController.Users_.Profileid != null)
                {
                    obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
                }
                obj_energy_plus_model.Obj_name = "Timestep";
                ds = obj_energy_plus_client.Get_Energy_Modeling_Simulation_Control_Parameter(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        if (lbl_notph.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {
                            txt_notph.Text = ds.Tables[0].Rows[i]["field_value"].ToString();
                            hf_notph.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
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

    private void BindYesNoDropDown()
    {
        string[] yes_no = new string[] { "Yes", "No" };
        try
        {
            ListItem li = new ListItem("-Select-", "select");
            ddl_dowfsd.Items.Add(li);
            ddl_uwfhasd.Items.Add(li);
            ddl_uwfdsp.Items.Add(li);
            ddl_awhr.Items.Add(li);
            ddl_uwfri.Items.Add(li);
            for (int i = 0; i < yes_no.Length; i++)
            {
                ListItem li_wd = new ListItem(yes_no[i], yes_no[i].ToLower());
                ddl_dowfsd.Items.Add(li_wd);
                ddl_uwfhasd.Items.Add(li_wd);
                ddl_uwfdsp.Items.Add(li_wd);
                ddl_awhr.Items.Add(li_wd);
                ddl_uwfri.Items.Add(li_wd);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void BindWeekDayDropDown()
    {
        string[] week_day = new string[] { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" };
        try
        {
            ListItem li = new ListItem("-Select-", "select");
            ddl_dowfsd.Items.Add(li);
            for (int i = 0; i < week_day.Length; i++)
            {
                ListItem li_wd = new ListItem(week_day[i], week_day[i].ToLower());
                ddl_dowfsd.Items.Add(li_wd);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void BindDayDropDown()
    {
        try
        {
            //Bind Begin Day Of Month
            ListItem li_bdom = new ListItem("-Select-", "select");
            ddl_bdom.Items.Add(li_bdom);
            ddl_edom.Items.Add(li_bdom);
            for (int i = 1; i <= 31; i++)
            {
                ListItem l1 = new ListItem(i.ToString(), i.ToString());
                ListItem l2 = new ListItem(i.ToString(), i.ToString());
                ddl_bdom.Items.Add(l1);
                ddl_edom.Items.Add(l2);
            }


        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void BindMonthDropDown()
    {
        try
        {
            //Bind Begin Month
            ListItem li_bm = new ListItem("-Select-", "select");
            ddl_bm.Items.Add(li_bm);
            ddl_em.Items.Add(li_bm);
            for (int i = 1; i <= 12; i++)
            {
                ListItem l1 = new ListItem(i.ToString(), i.ToString());
                ListItem l2 = new ListItem(i.ToString(), i.ToString());
                ddl_bm.Items.Add(l1);
                ddl_em.Items.Add(l2);
            }


        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void GetLastWeatherFile()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                if (SessionController.Users_.Profileid != null)
                {
                    obj_energy_plus_model.pk_profileid = new Guid(SessionController.Users_.Profileid);
                }
                ds = obj_energy_plus_client.GetLastWeatherDataFile(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        SessionController.Users_.Em_Weather_File_Name = ds.Tables[0].Rows[0]["weather_file_name"].ToString();

                    }
                }
            }
        }

        catch (Exception es)
        {
            throw es;
        }

    }

    private void BindRunPeriodGrid()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                if (SessionController.Users_.Profileid != null)
                {
                    obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
                }
                obj_energy_plus_model.Obj_name = "RunPeriod";
                ds = obj_energy_plus_client.Get_Energy_Modeling_Simulation_Control_Parameter(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        if (lbl_name.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {
                            txt_name.Text = ds.Tables[0].Rows[i]["field_value"].ToString();
                            hf_name.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }
                        if (lbl_bm.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {
                            ddl_bm.SelectedValue = ds.Tables[0].Rows[i]["field_value"].ToString();
                            hf_bm.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }
                        if (lbl_bdom.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {
                            ddl_bdom.SelectedValue = ds.Tables[0].Rows[i]["field_value"].ToString();
                            hf_bdom.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }
                        if (lbl_em.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {
                            ddl_em.SelectedValue = ds.Tables[0].Rows[i]["field_value"].ToString();
                            hf_em.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }
                        if (lbl_edom.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {
                            ddl_edom.SelectedValue = ds.Tables[0].Rows[i]["field_value"].ToString();
                            hf_edom.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }

                        if (lbl_dowfsd.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {
                            ddl_dowfsd.SelectedValue = ds.Tables[0].Rows[i]["field_value"].ToString().ToLower();
                            hf_dowfsd.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }

                        if (lbl_uwfhasd.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {

                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_uwfhasd.SelectedValue = "1";
                            }
                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_uwfhasd.SelectedValue = "2";
                            }
                            hf_uwfhasd.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }


                        if (lbl_uwfdsp.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {

                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_uwfdsp.SelectedValue = "1";
                            }
                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_uwfdsp.SelectedValue = "2";
                            }
                            hf_uwfdsp.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }

                        if (lbl_awhr.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {

                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_awhr.SelectedValue = "1";
                            }
                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_awhr.SelectedValue = "2";
                            }
                            hf_awhr.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }

                        if (lbl_uwfri.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {

                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_uwfri.SelectedValue = "1";
                            }
                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_uwfri.SelectedValue = "2";
                            }
                            hf_uwfri.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }

                        if (lbl_uwfsi.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {

                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_uwfsi.SelectedValue = "1";
                            }
                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_uwfsi.SelectedValue = "2";
                            }
                            hf_uwfsi.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }
                        if (lbl_notrtbr.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {
                            txt_notrtbr.Text = ds.Tables[0].Rows[i]["field_value"].ToString();
                            hf_notrtbr.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
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
    //private void BindRunPeriodGrid()
    //{
    //    EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
    //    EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
    //    DataSet ds = new DataSet();
    //    try
    //    {
    //        if (SessionController.Users_.Em_facility_id != null)
    //        {
    //            obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
    //            obj_energy_plus_model.Obj_name = "RunPeriod";
    //            ds = obj_energy_plus_client.Get_EM_Simulation_Control_Data(obj_energy_plus_model, SessionController.ConnectionString);
    //            if (ds.Tables[0].Rows.Count > 0)
    //            {
    //                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
    //                {
    //                    if (lbl_name.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {
    //                        txt_name.Text = ds.Tables[0].Rows[i]["value"].ToString();
    //                        hf_name.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }
    //                    if (lbl_bm.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {
    //                        ddl_bm.SelectedValue = ds.Tables[0].Rows[i]["value"].ToString();
    //                        hf_bm.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }
    //                    if (lbl_bdom.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {
    //                        ddl_bdom.SelectedValue = ds.Tables[0].Rows[i]["value"].ToString();
    //                        hf_bdom.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }
    //                    if (lbl_em.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {
    //                        ddl_em.SelectedValue = ds.Tables[0].Rows[i]["value"].ToString();
    //                        hf_em.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }
    //                    if (lbl_edom.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {
    //                        ddl_edom.SelectedValue = ds.Tables[0].Rows[i]["value"].ToString();
    //                        hf_edom.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }

    //                    if (lbl_dowfsd.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {
    //                        ddl_dowfsd.SelectedValue = ds.Tables[0].Rows[i]["value"].ToString().ToLower();
    //                        hf_dowfsd.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }

    //                    if (lbl_uwfhasd.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {

    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_uwfhasd.SelectedValue = "1";
    //                        }
    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_uwfhasd.SelectedValue = "2";
    //                        }
    //                        hf_uwfhasd.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }


    //                    if (lbl_uwfdsp.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {

    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_uwfdsp.SelectedValue = "1";
    //                        }
    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_uwfdsp.SelectedValue = "2";
    //                        }
    //                        hf_uwfdsp.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }

    //                    if (lbl_awhr.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {

    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_awhr.SelectedValue = "1";
    //                        }
    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_awhr.SelectedValue = "2";
    //                        }
    //                        hf_awhr.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }

    //                    if (lbl_uwfri.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {

    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_uwfri.SelectedValue = "1";
    //                        }
    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_uwfri.SelectedValue = "2";
    //                        }
    //                        hf_uwfri.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }

    //                    if (lbl_uwfsi.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {

    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_uwfsi.SelectedValue = "1";
    //                        }
    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_uwfsi.SelectedValue = "2";
    //                        }
    //                        hf_uwfsi.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }
    //                    if (lbl_notrtbr.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {
    //                        txt_notrtbr.Text = ds.Tables[0].Rows[i]["value"].ToString();
    //                        hf_notrtbr.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }

    //                }
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        throw ex;
    //    }
    //}

    protected void BindSimulationParameterGrid()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                if (SessionController.Users_.Profileid != null)
                {
                    obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
                }
                obj_energy_plus_model.Obj_name = "SimulationControl";
                ds = obj_energy_plus_client.Get_Energy_Modeling_Simulation_Control_Parameter(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        if (lbl_dzsc.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {

                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_dzsc.SelectedValue = "1";
                            }
                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_dzsc.SelectedValue = "2";
                            }
                            hf_dzsc.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }
                        if (lbl_dssc.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {

                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_dssc.SelectedValue = "1";
                            }
                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_dssc.SelectedValue = "2";
                            }
                            hf_dssc.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }
                        if (lbl_dpsc.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {

                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_dpsc.SelectedValue = "1";
                            }
                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_dpsc.SelectedValue = "2";
                            }
                            hf_dpsc.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }
                        if (lbl_rsfsp.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {

                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_rsfsp.SelectedValue = "1";
                            }
                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_rsfsp.SelectedValue = "2";
                            }
                            hf_rsfsp.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
                        }
                        if (lbl__rsfwfrp.Text.Equals(ds.Tables[0].Rows[i]["field_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
                        {
                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_rsfwfrp.SelectedValue = "1";
                            }
                            if (ds.Tables[0].Rows[i]["field_value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
                            {
                                ddl_rsfwfrp.SelectedValue = "2";
                            }
                            hf_rsfwfrp.Value = ds.Tables[0].Rows[i]["pk_proj_simulation_control_parameter_id"].ToString();
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

    //protected void BindSimulationParameterGrid()
    //{
    //    EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
    //    EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
    //    DataSet ds = new DataSet();
    //    try
    //    {

    //        if (SessionController.Users_.Em_facility_id != null)
    //        {
    //            obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
    //            obj_energy_plus_model.Obj_name = "SimulationControl";
    //            ds = obj_energy_plus_client.Get_EM_Simulation_Control_Data(obj_energy_plus_model, SessionController.ConnectionString);
    //            if (ds.Tables[0].Rows.Count > 0)
    //            {
    //                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
    //                {
    //                    if (lbl_dzsc.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {

    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_dzsc.SelectedValue = "1";
    //                        }
    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_dzsc.SelectedValue = "2";
    //                        }
    //                        hf_dzsc.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }
    //                    if (lbl_dssc.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {

    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_dssc.SelectedValue = "1";
    //                        }
    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_dssc.SelectedValue = "2";
    //                        }
    //                        hf_dssc.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }
    //                    if (lbl_dpsc.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {

    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_dpsc.SelectedValue = "1";
    //                        }
    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_dpsc.SelectedValue = "2";
    //                        }
    //                        hf_dpsc.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }
    //                    if (lbl_rsfsp.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {

    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_rsfsp.SelectedValue = "1";
    //                        }
    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_rsfsp.SelectedValue = "2";
    //                        }
    //                        hf_rsfsp.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }
    //                    if (lbl__rsfwfrp.Text.Equals(ds.Tables[0].Rows[i]["attribute_name"].ToString(), StringComparison.CurrentCultureIgnoreCase))
    //                    {
    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("Yes", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_rsfwfrp.SelectedValue = "1";
    //                        }
    //                        if (ds.Tables[0].Rows[i]["value"].ToString().Equals("No", StringComparison.CurrentCultureIgnoreCase))
    //                        {
    //                            ddl_rsfwfrp.SelectedValue = "2";
    //                        }
    //                        hf_rsfwfrp.Value = ds.Tables[0].Rows[i]["pk_asset_attribute_value_id"].ToString();
    //                    }

    //                }

    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        throw ex;
    //    }

    //}

    public void ProgressBarSimulation(int inc, string status)
    {
        RadProgressContext progress = RadProgressContext.Current;
        progress.PrimaryTotal = 1;
        progress.PrimaryValue = 1;
        progress.PrimaryPercent = inc;

        //RadProgressArea1.Localization.CurrentFileName = "Simulation Status:";

        //progress.SecondaryTotal = total;
        //progress.SecondaryValue = c;
        //progress.SecondaryPercent = c;
        //progress.CurrentOperationText = "Step " + inc.ToString();
        //progress.CurrentOperationText = status.ToString();
        lbl_status.Text = status.ToString();
        if (!Response.IsClientConnected)
        {
            // break;
        }

        progress.TimeEstimated = (100 - (inc / 20)) * 100;

        System.Threading.Thread.Sleep(1000);
    }

    //protected void ibtn_start_Click(object sender, ImageClickEventArgs e)
    //{
    //    //try
    //    //{
    //     //  // UpdateProgressContext();
    //     //   progress = RadProgressContext.Current;
    //     //   progress.Speed = "N/A";
    //     //   EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
    //     //   EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
    //     //   DataSet ds_fileName = new DataSet();
    //     //   DataSet ds_zoneList = new DataSet();
    //     //   DataSet ds_equipment = new DataSet();
    //     //   DataSet ds_simulation_data = new DataSet();
    //     //   DataSet ds_schedule_data = new DataSet();
    //     //   DataSet ds_schedule_type_data = new DataSet();
    //     //   DataSet ds_faciity = new DataSet();
    //        string file_name="";
    //        string pk_file_id = "";
    //        string fName = null;
    //     //   if (SessionController.Users_.Em_facility_id != null && SessionController.Users_.Profileid!=null)
    //     //   {
    //     //       obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
    //     //       obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
    //     //       ds_fileName = obj_energy_plus_client.Get_Energy_Modeling_IDF_File_Name_Of_Facility(obj_energy_plus_model, SessionController.ConnectionString);
    //     //       if (ds_fileName.Tables[0].Rows.Count == 0)
    //     //       {
    //     //           if (SessionController.Users_.Em_facility_name != null)
    //     //           {
    //     //               file_name = SessionController.Users_.Em_facility_name.Replace(" ", "_") + ".idf";
    //     //               string save_path = "";
    //     //               file_name = WebConfigurationManager.AppSettings["EnergyPlusFileName"];
    //     //               string path = WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id;
    //     //               path = Server.MapPath(path);
    //     //               DirectoryInfo dir_info = new DirectoryInfo(path);
    //     //               if (!dir_info.Exists)
    //     //               {
    //     //                   dir_info.Create();
    //     //                   save_path = Path.Combine(path, file_name);
    //     //               }
    //     //               else
    //     //               {
    //     //                   save_path = Path.Combine(path, file_name);
    //     //               }
    //     //           }
    //     //       }
    //     //       else
    //     //       {
    //     //           file_name = ds_fileName.Tables[0].Rows[0]["file_name"].ToString();
    //     //           string facility_name = ds_fileName.Tables[0].Rows[0]["facility_name"].ToString();
    //     //           pk_file_id = ds_fileName.Tables[0].Rows[0]["pk_file_id"].ToString();
    //     //       }
    //     //           if (file_name != null)
    //     //           {
    //     //               hf_idf_file_name.Value = file_name;
    //     //               //string NewFileName = file_name.Replace(".", "1.");
    //     //               string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
    //     //               if (File.Exists(newfilePath))
    //     //               {
    //     //                   File.Delete(newfilePath);
    //     //               }

    //     //               //Writing Version Block
    //     //               GenerateVersionBlockInIDF(file_name);

    //     //               //Writing SimulationControl,RunPeriod,Timestep Block
    //     //               ds_simulation_data = obj_energy_plus_client.Get_Energy_Modeling_Project_Simulation_Data(obj_energy_plus_model, SessionController.ConnectionString);
    //     //               if (ds_simulation_data.Tables.Count > 0)
    //     //               {
    //     //                   for (int t = 0; t < ds_simulation_data.Tables.Count; t++)
    //     //                   {

    //     //                       GenerateSimulationControlBlockInIDF(ds_simulation_data, t, file_name);
    //     //                   }

    //     //               }
    //     //               ProgressBarSimulation(20);


    //     //               //Writing Building Block
    //     //               ds_faciity = obj_energy_plus_client.Get_Energy_Modeling_Enable_Facility_Attribute(obj_energy_plus_model, SessionController.ConnectionString);
    //     //               ProgressBarSimulation(40);
    //     //               GenerateSimulationBuildingBlock(ds_faciity, file_name);

    //     //               //Writing ZoneList Block
    //     //               ds_zoneList = obj_energy_plus_client.Get_Energy_Modeling_ZoneList(obj_energy_plus_model, SessionController.ConnectionString);
    //     //               ProgressBarSimulation(60);
    //     //               if (ds_zoneList.Tables.Count > 0)
    //     //               {
    //     //                   if (ds_zoneList.Tables[0].Rows.Count > 0)
    //     //                   {
    //     //                       for (int i = 0; i < ds_zoneList.Tables[0].Rows.Count; i++)
    //     //                       {
    //     //                           string zone_name = ds_zoneList.Tables[0].Rows[i]["name"].ToString();
    //     //                           string zone_id = ds_zoneList.Tables[0].Rows[i]["pk_location_id"].ToString();
    //     //                           GenerateZoneListBlockInIDF(zone_name, zone_id, ds_zoneList, file_name);
    //     //                       }
    //     //                   }
    //     //               }


    //     //               //Writing Zone Block
    //     //               if (ds_zoneList.Tables.Count > 0)
    //     //               {
    //     //                   if (ds_zoneList.Tables[1].Rows.Count > 0)
    //     //                   {
    //     //                       for (int i = 0; i < ds_zoneList.Tables[1].Rows.Count; i++)
    //     //                       {
    //     //                           string space_name = ds_zoneList.Tables[1].Rows[i]["name"].ToString();
    //     //                           string space_id = ds_zoneList.Tables[1].Rows[i]["pk_location_id"].ToString();
    //     //                           GenerateZoneBlockInIDF(space_name, space_id, file_name);
    //     //                       }
    //     //                   }
    //     //               }

    //     //               //Changes Done on 3_12_2012 
    //     //               //string file_id = ds_fileName.Tables[0].Rows[0]["pk_file_id"].ToString();
    //     //               //obj_energy_plus_model.File_id = new Guid(file_id);


    //     //               ds_equipment = obj_energy_plus_client.Get_Energy_Modeling_Equipment_Attribute(obj_energy_plus_model, SessionController.ConnectionString);
    //     //               ProgressBarSimulation(80);
    //     //               if (ds_equipment.Tables.Count > 0)
    //     //               {
    //     //                   for (int i = 0; i < ds_equipment.Tables.Count; i++)
    //     //                   {
    //     //                       GenerateEquipmentBlockInIDF(ds_equipment, i, file_name);
    //     //                   }

    //     //               }


    //     //               //Write Schedule Type block in idf file
    //     //               ds_schedule_type_data = obj_energy_plus_client.Get_Energy_Modeling_Compact_Schedule_Types(obj_energy_plus_model, SessionController.ConnectionString);

    //     //               if (ds_schedule_type_data.Tables[0].Rows.Count > 0)
    //     //               {
    //     //                   GenerateScheduleTypeBlockInIDF(ds_schedule_type_data,file_name);
    //     //               }


    //     //               //Write Schedule block in idf file
    //     //               ds_schedule_data = obj_energy_plus_client.Get_Energy_Modeling_Compact_Schedules(obj_energy_plus_model, SessionController.ConnectionString);


    //     //               if (ds_schedule_data.Tables.Count > 0)
    //     //               {
    //     //                   for (int t = 0; t < ds_schedule_data.Tables.Count; t++)
    //     //                   {
    //     //                       if (ds_schedule_data.Tables[t].Rows.Count > 0)
    //     //                       {
    //     //                           GenerateScheduleBlockInIDF(ds_schedule_data, t, file_name);
    //     //                       }
    //     //                   }
    //     //               }
    //     //               //Generate SQLite Block
    //     //               GenerateSQLiteBlockInIDF(file_name);

    //     //               //GenerateScheduleBlockInIDF();
    //     //               //string new_file_name1 = file_name.Replace(".", "1.");
    //     //               //string newfilePath1 = Server.MapPath("~/SimulationFiles/" + new_file_name1);
    //     //               //tw = new System.IO.StreamWriter(Server.MapPath("~/SimulationFiles/" + newfilePath1), true);
    //     //               //tw.WriteLine("  Output:SQLite,SimpleAndTabular;");
    //     //               //tw.Close();
    //     //               //if (ds_fileName.Tables[0].Rows.Count > 0)
    //     //               //{
    //     //               //    string file_id = ds_fileName.Tables[0].Rows[0]["pk_file_id"].ToString();
    //     //               //    if (!file_name.Equals(""))
    //     //               //    {
    //     //               //        GenerateIDFFile(file_name, file_id);
    //     //               //    }
    //     //               //}

    //     //               //Running Batch File
    //     //               string path = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
    //     //               InsertUpdateEnergyModelingSimulationRequest(file_name, path, pk_file_id);
    //     //               ProgressBarSimulation(100);
    //     //               //RunSimulationTools(path);
    //     //               //ImportSQLiteData();

    //     //           }

    //            //obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
    //            //ds = obj_energy_plus_client.Get_Get_EM_IDF_File_Name_Of_Facility(obj_energy_plus_model, SessionController.ConnectionString);
    //            //if(ds.Tables[0].Rows.Count>0)
    //            //{
    //            //    string file_name = ds.Tables[0].Rows[0]["file_name"].ToString();
    //            //    if (file_name!=null)
    //            //    {
    //            //        if (!file_name.Equals(""))
    //            //        {
    //            //            GenerateIDFFile(file_name);
    //            //        }
    //            //    }
    //            //}
    //       // }
    //    try
    //    {
    //        IDF_Exporter = new EcoDomus_IDF_Export();

    //        // setup the guids for our data

    //        IDF_Exporter.pk_facility_id = SessionController.Users_.Em_facility_id.ToString();
    //        IDF_Exporter.pk_project_id = "00000000-0000-0000-0000-000000000000";
    //        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
    //        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
    //        IDF_Exporter.ecodomus_client.sql_connection.ConnectionString = obj_energy_plus_client.Get_Connection_String(obj_energy_plus_model, SessionController.ConnectionString);
    //        IDF_Exporter.ecodomus_client.sql_connection.ConnectionString += ";MultipleActiveResultSets=True;";

    //        if (IDF_Exporter.ConnectClientDatabase())
    //        {
    //            // show debug info ?
    //            IDF_Exporter.bShowDebugOutput = true;

    //            // export the file
    //            DataSet ds_fileName = obj_energy_plus_client.Get_Energy_Modeling_IDF_File_Name_Of_Facility(obj_energy_plus_model, SessionController.ConnectionString);
    //            if (ds_fileName.Tables[0].Rows.Count == 0)
    //            {
    //                if (SessionController.Users_.Em_facility_name != null)
    //                {
    //                    file_name = SessionController.Users_.Em_facility_name.Replace(" ", "_") + ".idf";
    //                    fName = "";

    //                    string path = WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id;
    //                    path = Server.MapPath(path);
    //                    DirectoryInfo dir_info = new DirectoryInfo(path);
    //                    if (!dir_info.Exists)
    //                    {
    //                        dir_info.Create();
    //                        fName = Path.Combine(path, file_name);
    //                    }
    //                    else
    //                    {
    //                        fName = Path.Combine(path, file_name);
    //                    }
    //                }

    //            }
    //            else
    //            {
    //                file_name = ds_fileName.Tables[0].Rows[0]["file_name"].ToString();
    //                string facility_name = ds_fileName.Tables[0].Rows[0]["facility_name"].ToString();
    //                pk_file_id = ds_fileName.Tables[0].Rows[0]["pk_file_id"].ToString();
    //            }

    //            long objects_exported = IDF_Exporter.Export_IDF_File(IDF_Exporter.pk_facility_id, IDF_Exporter.pk_project_id, fName);
    //            // close the db
    //            IDF_Exporter.CloseClientDatabase();
    //        }

    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }

    //    finally
    //    {
    //        //tw.Close();
    //    }
    //}

    protected void ibtn_start_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string file_name = "";
            string pk_file_id = "";
            if (SessionController.Users_.Em_facility_id != null)
            {
                if (SessionController.Users_.Profileid != null)
                {
                    EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
                    EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();

                    obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                    DataSet ds_fileName = obj_energy_plus_client.Get_Energy_Modeling_IDF_File_Name_Of_Facility(obj_energy_plus_model, SessionController.ConnectionString);
                    if (ds_fileName.Tables[0].Rows.Count == 0)
                    {
                        if (SessionController.Users_.Em_facility_name != null)
                        {
                            file_name = SessionController.Users_.Em_facility_name.Replace(" ", "_") + ".idf";
                            string path = WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id;
                            path = Server.MapPath(path);
                            DirectoryInfo dir_info = new DirectoryInfo(path);
                            if (!dir_info.Exists)
                            {
                                dir_info.Create();
                            }
                        }
                    }
                    else
                    {
                        file_name = ds_fileName.Tables[0].Rows[0]["file_name"].ToString();
                        string facility_name = ds_fileName.Tables[0].Rows[0]["facility_name"].ToString();
                        pk_file_id = ds_fileName.Tables[0].Rows[0]["pk_file_id"].ToString();
                    }

                    if (file_name != null)
                    {
                        hf_idf_file_name.Value = file_name;
                        string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                        if (File.Exists(newfilePath))
                        {
                            File.Delete(newfilePath);
                        }
                        
                        ProgressBarSimulation(10, "Simulation will start in 1-2 minutes ...");
                        string path = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                        InsertUpdateEnergyModelingSimulationRequest(file_name, path, pk_file_id);

                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "script1", "CheckSimulationProfile();", true);
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }

        finally
        {
            //tw.Close();
        }
    }

    private void GenerateSQLiteBlockInIDF(string file_name)
    {
        System.IO.StreamWriter tw = null;
        try
        {
            string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
            tw = new System.IO.StreamWriter(newfilePath, true);
            tw.WriteLine();
            tw.WriteLine("  Output:SQLite,SimpleAndTabular;");
        }
        catch (Exception ex)
        {

            throw ex;
        }
        finally
        {
            tw.Close();
        }
    }

    private void GenerateScheduleTypeBlockInIDF(DataSet ds_schedule_type_data, string file_name)
    {
        System.IO.StreamWriter tw = null;
        string object_name = "";
        string schedule_type = "";
        string lower_limit = "";
        string upper_limit = "";
        string numeric_type = "";
        string unit_type = "";
        try
        {
            string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
            StringBuilder sb = new StringBuilder();
            tw = new System.IO.StreamWriter(newfilePath, true);
            int prev_pad_value = 0;
            int curr_pad_value = 0;
            for (int i = 0; i < ds_schedule_type_data.Tables[0].Rows.Count; i++)
            {
                object_name = ds_schedule_type_data.Tables[0].Rows[i]["object_name"].ToString() + ",";
                sb.AppendLine("".PadLeft(2) + object_name);
                schedule_type = ds_schedule_type_data.Tables[0].Rows[i]["schedule_type"].ToString();
                curr_pad_value = schedule_type.Length;
                sb.AppendLine("".PadLeft(5) + schedule_type + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, schedule_type)) + "!- Name");
                lower_limit = ds_schedule_type_data.Tables[0].Rows[i]["lower_limit"].ToString();
                curr_pad_value = lower_limit.Length;
                prev_pad_value = schedule_type.Length;
                sb.AppendLine("".PadLeft(5) + lower_limit + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, lower_limit)) + "!- Lower Limit Value");
                upper_limit = ds_schedule_type_data.Tables[0].Rows[i]["upper_limit"].ToString();
                curr_pad_value = upper_limit.Length;
                prev_pad_value = schedule_type.Length;
                sb.AppendLine("".PadLeft(5) + upper_limit + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, upper_limit)) + "!- Upper Limit Value");
                numeric_type = ds_schedule_type_data.Tables[0].Rows[i]["numeric_type"].ToString();
                curr_pad_value = numeric_type.Length;
                prev_pad_value = schedule_type.Length;
                sb.AppendLine("".PadLeft(5) + numeric_type + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, numeric_type)) + "!- Numeric Type");
                unit_type = ds_schedule_type_data.Tables[0].Rows[i]["unit_type"].ToString();
                curr_pad_value = unit_type.Length;
                prev_pad_value = schedule_type.Length;
                sb.AppendLine("".PadLeft(5) + unit_type + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, unit_type)) + "!- Unit Type");

                int index = sb.ToString().LastIndexOf(",");
                sb[index] = ';';
                tw.WriteLine(sb.ToString());
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        finally
        {
            tw.Close();
        }
    }

    private void GenerateScheduleBlockInIDF(DataSet ds_schedule_data, int t, string file_name)
    {
        System.IO.StreamWriter tw = null;
        string object_name = "";
        string schedule_name = "";
        string schedule_type = "";
        List<string> through = new List<string>();
        try
        {
            int prev_pad_value = 0;
            int curr_pad_value = 0;
            string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
            StringBuilder sb = new StringBuilder();
            tw = new System.IO.StreamWriter(newfilePath, true);
            object_name = ds_schedule_data.Tables[t].Rows[0]["object_name"].ToString() + ",";
            tw.WriteLine("".PadLeft(2) + object_name);
            schedule_name = ds_schedule_data.Tables[t].Rows[0]["schedule_name"].ToString();
            curr_pad_value = schedule_name.Length;
            tw.WriteLine("".PadLeft(5) + schedule_name + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, schedule_name)) + "!- Name");

            schedule_type = ds_schedule_data.Tables[t].Rows[0]["schedule_type"].ToString();
            curr_pad_value = schedule_type.Length;
            prev_pad_value = schedule_name.Length;
            tw.WriteLine("".PadLeft(5) + schedule_type + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, schedule_type)) + "!- Schedule Type Limits Name");

            int field_no = 1;
            for (int i = 0; i < ds_schedule_data.Tables[t].Rows.Count; i++)
            {
                string for_str = "For: ";
                string until_str = "";
                string through_str = "";
                through_str = ds_schedule_data.Tables[t].Rows[i]["through"].ToString().Trim();
                curr_pad_value = through_str.Length;
                prev_pad_value = schedule_name.Length;
                if (!through.Contains(through_str))
                {
                    sb.AppendLine("".PadLeft(5) + through_str + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, through_str)) + "!- Field" + (field_no++).ToString());
                    //tw.WriteLine();
                    through.Add(through_str);
                }
                //Generate For string
                for_str = for_str + ds_schedule_data.Tables[t].Rows[i]["week_type"].ToString().Replace(" ", "");
                if (Convert.ToBoolean(ds_schedule_data.Tables[t].Rows[i]["week_days"].ToString()))
                {
                    for_str = for_str + " WeekDays";
                }

                if (Convert.ToBoolean(ds_schedule_data.Tables[t].Rows[i]["all_days"].ToString()))
                {
                    for_str = for_str + " AllDays";
                }

                if (Convert.ToBoolean(ds_schedule_data.Tables[t].Rows[i]["all_other_days"].ToString()))
                {
                    for_str = for_str + " AllOtherDays";
                }

                if (Convert.ToBoolean(ds_schedule_data.Tables[t].Rows[i]["winter_design_day"].ToString()))
                {
                    for_str = for_str + " WinterDesignDay";
                }

                if (Convert.ToBoolean(ds_schedule_data.Tables[t].Rows[i]["summer_design_days"].ToString()))
                {
                    for_str = for_str + " SummerDesignDays";
                }

                if (Convert.ToBoolean(ds_schedule_data.Tables[t].Rows[i]["custom_day_1"].ToString()))
                {
                    for_str = for_str + " CustomDay1";
                }

                if (Convert.ToBoolean(ds_schedule_data.Tables[t].Rows[i]["custom_day_2"].ToString()))
                {
                    for_str = for_str + " CustomDay2";
                }

                if (Convert.ToBoolean(ds_schedule_data.Tables[t].Rows[i]["week_ends"].ToString()))
                {
                    for_str = for_str + " WeekEnds";
                }

                if (Convert.ToBoolean(ds_schedule_data.Tables[t].Rows[i]["holiday"].ToString()))
                {
                    for_str = for_str + " Holiday";
                }
                curr_pad_value = for_str.Length;
                prev_pad_value = schedule_name.Length;
                sb.AppendLine("".PadLeft(5) + for_str + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, for_str)) + "!- Field" + (field_no++).ToString());

                if (!ds_schedule_data.Tables[t].Rows[i]["until1"].ToString().Equals(""))
                {
                    until_str = "Until: " + ds_schedule_data.Tables[t].Rows[i]["until1"].ToString() + "," + ds_schedule_data.Tables[t].Rows[i]["value1"].ToString();
                    curr_pad_value = until_str.Length;
                    prev_pad_value = schedule_name.Length;
                    sb.AppendLine("".PadLeft(5) + until_str + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, until_str)) + "!- Field" + (field_no++).ToString());

                }
                if (!ds_schedule_data.Tables[t].Rows[i]["until2"].ToString().Equals(""))
                {
                    until_str = "Until: " + ds_schedule_data.Tables[t].Rows[i]["until2"].ToString() + "," + ds_schedule_data.Tables[t].Rows[i]["value2"].ToString();
                    curr_pad_value = until_str.Length;
                    prev_pad_value = schedule_name.Length;
                    sb.AppendLine("".PadLeft(5) + until_str + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, until_str)) + "!- Field" + (field_no++).ToString());

                }
                if (!ds_schedule_data.Tables[t].Rows[i]["until3"].ToString().Equals(""))
                {
                    until_str = "Until: " + ds_schedule_data.Tables[t].Rows[i]["until3"].ToString() + "," + ds_schedule_data.Tables[t].Rows[i]["value3"].ToString();
                    curr_pad_value = until_str.Length;
                    prev_pad_value = schedule_name.Length;
                    sb.AppendLine("".PadLeft(5) + until_str + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, until_str)) + "!- Field" + (field_no++).ToString());

                }
                if (!ds_schedule_data.Tables[t].Rows[i]["until4"].ToString().Equals(""))
                {
                    until_str = "Until: " + ds_schedule_data.Tables[t].Rows[i]["until4"].ToString() + "," + ds_schedule_data.Tables[t].Rows[i]["value4"].ToString();
                    curr_pad_value = until_str.Length;
                    prev_pad_value = schedule_name.Length;
                    sb.AppendLine("".PadLeft(5) + until_str + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, until_str)) + "!- Field" + (field_no++).ToString());

                }
                if (!ds_schedule_data.Tables[t].Rows[i]["until5"].ToString().Equals(""))
                {
                    until_str = "Until: " + ds_schedule_data.Tables[t].Rows[i]["until5"].ToString() + "," + ds_schedule_data.Tables[t].Rows[i]["value5"].ToString();
                    curr_pad_value = until_str.Length;
                    prev_pad_value = schedule_name.Length;
                    sb.AppendLine("".PadLeft(5) + until_str + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, until_str)) + "!- Field" + (field_no++).ToString());

                }
                if (!ds_schedule_data.Tables[t].Rows[i]["until6"].ToString().Equals(""))
                {
                    until_str = "Until: " + ds_schedule_data.Tables[t].Rows[i]["until6"].ToString() + "," + ds_schedule_data.Tables[t].Rows[i]["value6"].ToString();
                    curr_pad_value = until_str.Length;
                    prev_pad_value = schedule_name.Length;
                    sb.AppendLine("".PadLeft(5) + until_str + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, until_str)) + "!- Field" + (field_no++).ToString());

                }
                if (!ds_schedule_data.Tables[t].Rows[i]["until7"].ToString().Equals(""))
                {
                    until_str = "Until: " + ds_schedule_data.Tables[t].Rows[i]["until7"].ToString() + "," + ds_schedule_data.Tables[t].Rows[i]["value7"].ToString();
                    curr_pad_value = until_str.Length;
                    prev_pad_value = schedule_name.Length;
                    sb.AppendLine("".PadLeft(5) + until_str + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, until_str)) + "!- Field" + (field_no++).ToString());

                }
                if (!ds_schedule_data.Tables[t].Rows[i]["until8"].ToString().Equals(""))
                {
                    until_str = "Until: " + ds_schedule_data.Tables[t].Rows[i]["until8"].ToString() + "," + ds_schedule_data.Tables[t].Rows[i]["value8"].ToString();
                    curr_pad_value = until_str.Length;
                    prev_pad_value = schedule_name.Length;
                    sb.AppendLine("".PadLeft(5) + until_str + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, until_str)) + "!- Field" + (field_no++).ToString());

                }
                if (!ds_schedule_data.Tables[t].Rows[i]["until9"].ToString().Equals(""))
                {
                    until_str = until_str + ds_schedule_data.Tables[t].Rows[i]["until9"].ToString() + "," + ds_schedule_data.Tables[t].Rows[i]["value9"].ToString();
                    curr_pad_value = until_str.Length;
                    prev_pad_value = schedule_name.Length;
                    sb.AppendLine("".PadLeft(5) + until_str + ",".PadRight(getPaddingValue(prev_pad_value, curr_pad_value, until_str)) + "!- Field" + (field_no++).ToString());

                }

            }
            int index = sb.ToString().LastIndexOf(",");
            sb[index] = ';';
            tw.WriteLine(sb.ToString());
        }
        catch (Exception ex)
        {

            throw ex;
        }
        finally
        {
            tw.Close();
        }
    }

    private int getPaddingValue(int prev_pad_value, int curr_pad_value, string prev_string)
    {
        int pad_value = 25;
        int gap = 0;
        try
        {
            //For Adjusting Pading Value

            curr_pad_value = prev_string.Length;
            if (prev_pad_value == 0)
            {
                prev_pad_value = prev_string.Length;
            }
            if (curr_pad_value > prev_pad_value)
            {
                gap = curr_pad_value - prev_pad_value;
                pad_value = pad_value - gap;
            }
            if (curr_pad_value < prev_pad_value)
            {
                gap = prev_pad_value - curr_pad_value;
                pad_value = pad_value + gap;
            }

            if (pad_value < 0 || pad_value == 0)
            {
                pad_value = 5;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return pad_value;
    }

    private void InsertUpdateEnergyModelingSimulationRequest(string file_name, string path, string file_id)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            if (SessionController.Users_.ClientID != null)
            {
                obj_energy_plus_model.Client_id = new Guid(SessionController.Users_.ClientID);
            }
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);

                if (SessionController.Users_.UserId != null)
                {
                    obj_energy_plus_model.User_id = new Guid(SessionController.Users_.UserId);
                }
                if (SessionController.Users_.Profileid != null)
                {
                    obj_energy_plus_model.pk_profileid = new Guid(SessionController.Users_.Profileid);
                    if (SessionController.Users_.Em_Weather_File_Name != null)
                    {
                        obj_energy_plus_model.Weather_file_name = SessionController.Users_.Em_Weather_File_Name;
                        obj_energy_plus_model.Weather_file_path = WebConfigurationManager.AppSettings["EnergyPlusWeatherFilePath"];
                    }

                    if (!file_id.Equals(""))
                    {
                        obj_energy_plus_model.Uploaded_file_id = new Guid(file_id);
                    }

                    // obj_energy_plus_model.FrmTimeStmp
                    // obj_energy_plus_model.ToTimeStmp

                    obj_energy_plus_model.Status = "N";
                    obj_energy_plus_model.File_path = Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id);
                    obj_energy_plus_model.File_name = file_name;
                    obj_energy_plus_client.Insert_Update_Energy_Modeling_Simulation_Request(obj_energy_plus_model, SessionController.ConnectionString);
                }
                
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void GenerateSimulationBuildingBlock(DataSet ds_faciity, string file_name)
    {
        System.IO.StreamWriter tw = null;
        string attribute_line = "";
        string object_name = "";
        try
        {
            StringBuilder sb = new StringBuilder();
            string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
            tw = new System.IO.StreamWriter(newfilePath, true);
            if (ds_faciity.Tables.Count > 0)
            {
                for (int t = 0; t < ds_faciity.Tables.Count; t++)
                {
                    if (ds_faciity.Tables[t].Rows.Count > 0)
                    {
                        int prev_pad_value = 0;
                        int curr_pad_value = 0;
                        int gap = 0;
                        tw.WriteLine();
                        object_name = ds_faciity.Tables[t].Rows[0]["object_name"].ToString() + ",";
                        object_name = "".PadLeft(2) + object_name;
                        tw.WriteLine(object_name);
                        for (int i = 0; i < ds_faciity.Tables[t].Rows.Count; i++)
                        {
                            int pad_value = 25;
                            string attribute_name = ds_faciity.Tables[t].Rows[i]["attribute_name"].ToString();
                            string attribute_value = ds_faciity.Tables[t].Rows[i]["attribute_value"].ToString();
                            //For Adjusting Pading Value
                            curr_pad_value = attribute_value.Length;
                            if (prev_pad_value == 0)
                            {
                                prev_pad_value = attribute_value.Length;
                            }
                            if (curr_pad_value > prev_pad_value)
                            {
                                gap = curr_pad_value - prev_pad_value;
                                pad_value = pad_value - gap;
                            }
                            if (curr_pad_value < prev_pad_value)
                            {
                                gap = prev_pad_value - curr_pad_value;
                                pad_value = pad_value + gap;
                            }

                            if (pad_value < 0 || pad_value == 0)
                            {
                                pad_value = 5;
                            }

                            attribute_line = attribute_value + ",".PadRight(pad_value) + "!-" + attribute_name;
                            attribute_line = "".PadLeft(5) + attribute_line;
                            sb.AppendLine(attribute_line);
                        }
                        int index = sb.ToString().LastIndexOf(",");
                        sb[index] = ';';
                        char[] s = sb.ToString().ToArray();
                        tw.WriteLine(sb.ToString());
                        sb.Clear();
                    }
                }

            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
        finally
        {
            tw.Close();
        }
    }
    private void GenerateVersionBlockInIDF(string file_name)
    {
        System.IO.StreamWriter tw = null;
        try
        {
            string object_name = "Version,";
            string version_line = "";
            string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
            string version = WebConfigurationManager.AppSettings["EnergyPlusVersion"];
            tw = new System.IO.StreamWriter(newfilePath, true);
            object_name = "".PadLeft(2) + object_name.Trim();
            tw.WriteLine(object_name);
            version_line = "".PadRight(5) + version.PadRight(20) + "! Version Identifier";
            tw.WriteLine(version_line);
        }
        catch (Exception ex)
        {

            throw ex;
        }
        finally
        {

            tw.Close();
        }
    }

    private void GenerateSimulationControlBlockInIDF(DataSet ds_simulation_data, int t, string file_name)
    {
        System.IO.StreamWriter tw = null;
        try
        {
            string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
            tw = new System.IO.StreamWriter(newfilePath, true);
            string attribute_line = "";
            string object_name = "";

            if (ds_simulation_data.Tables[t].Rows.Count > 0)
            {
                int prev_pad_value = 0;
                int curr_pad_value = 0;
                int gap = 0;
                tw.WriteLine();
                object_name = ds_simulation_data.Tables[t].Rows[0]["object_name"].ToString() + ",";
                object_name = "".PadLeft(2) + object_name.Trim();
                tw.WriteLine(object_name);
                for (int i = 0; i < ds_simulation_data.Tables[t].Rows.Count; i++)
                {
                    int pad_value = 25;
                    string attribute_name = ds_simulation_data.Tables[t].Rows[i]["attribute_name"].ToString();
                    string attribute_value = ds_simulation_data.Tables[t].Rows[i]["attribute_value"].ToString();

                    //For Adjusting Pading Value
                    curr_pad_value = attribute_value.Length;
                    if (prev_pad_value == 0)
                    {
                        prev_pad_value = attribute_value.Length;
                    }
                    if (curr_pad_value > prev_pad_value)
                    {
                        gap = curr_pad_value - prev_pad_value;
                        pad_value = pad_value - gap;
                    }
                    if (curr_pad_value < prev_pad_value)
                    {
                        gap = prev_pad_value - curr_pad_value;
                        pad_value = pad_value + gap;
                    }

                    if (pad_value < 0 || pad_value == 0)
                    {
                        pad_value = 5;
                    }
                    if (i == (ds_simulation_data.Tables[t].Rows.Count - 1))
                    {
                        attribute_line = attribute_value + ";".PadRight(pad_value) + "!-" + attribute_name;
                    }
                    else
                    {
                        attribute_line = attribute_value + ",".PadRight(pad_value) + "!-" + attribute_name;
                    }
                    attribute_line = "".PadLeft(5) + attribute_line;
                    tw.WriteLine(attribute_line);
                }

            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        finally
        {
            tw.Close();
        }
    }

    private void GenerateZoneListBlockInIDF(string zone_name, string zone_id, DataSet ds_zoneList, string file_name)
    {
        System.IO.StreamWriter tw = null;
        string zoneList_name_line = "";
        string zone_name_line = "";
        string object_name = "ZoneList,";
        try
        {
            string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
            tw = new System.IO.StreamWriter(newfilePath, true);
            ArrayList spaces = new ArrayList();
            tw.WriteLine();
            zoneList_name_line = "".PadRight(20) + "!-Name";
            object_name = "".PadLeft(2) + object_name.Trim();
            tw.WriteLine(object_name);
            zone_name = "".PadLeft(2) + zone_name;
            tw.WriteLine(zone_name + "," + zoneList_name_line);
            for (int i = 0; i < ds_zoneList.Tables[1].Rows.Count; i++)
            {
                if (ds_zoneList.Tables[1].Rows[i]["fk_zone_list_id"].ToString().Equals(zone_id))
                {
                    string space_name = ds_zoneList.Tables[1].Rows[i]["name"].ToString();
                    spaces.Add(space_name);
                }

            }

            if (spaces.Count > 0)
            {
                int prev_pad_value = 0;
                int curr_pad_value = 0;
                int gap = 0;
                for (int i = 0; i < spaces.Count; i++)
                {
                    int pad_value = 25;
                    string space_name = spaces[i].ToString();

                    //For Adjusting Pading Value
                    curr_pad_value = space_name.Length;
                    if (prev_pad_value == 0)
                    {
                        prev_pad_value = space_name.Length;
                    }
                    if (curr_pad_value > prev_pad_value)
                    {
                        gap = curr_pad_value - prev_pad_value;
                        pad_value = pad_value - gap;
                    }
                    if (curr_pad_value < prev_pad_value)
                    {
                        gap = prev_pad_value - curr_pad_value;
                        pad_value = pad_value + gap;
                    }

                    if (pad_value < 0 || pad_value == 0)
                    {
                        pad_value = 5;
                    }
                    if (i == (spaces.Count - 1))
                    {
                        zone_name_line = space_name.Trim() + ";".PadRight(pad_value) + "!-Zone " + (i + 1).ToString() + " Name";
                    }
                    else
                    {
                        zone_name_line = space_name.Trim() + ",".PadRight(pad_value) + "!-Zone " + (i + 1).ToString() + " Name";
                    }

                    zone_name_line = "".PadLeft(5) + zone_name_line;
                    tw.WriteLine(zone_name_line);
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        finally
        {

            tw.Close();
        }
    }

    private void GenerateZoneBlockInIDF(string space_name, string space_id, string file_name)
    {
        System.IO.StreamWriter tw = null;
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        string space_name_line = "";
        string attribute_line = "";
        string object_name = "Zone,";
        try
        {
            string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
            tw = new System.IO.StreamWriter(newfilePath, true);
            obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            obj_energy_plus_model.Pk_space_id = new Guid(space_id);
            ArrayList spaces = new ArrayList();
            StringBuilder sb = new StringBuilder();
            ds = obj_energy_plus_client.Get_Energy_Modeling_Space_Attribute(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables.Count > 0)
            {
                space_name_line = "".PadRight(25) + "!-Name";
                for (int t = 0; t < ds.Tables.Count; t++)
                {
                    if (ds.Tables[t].Rows.Count > 0)
                    {
                        int prev_pad_value = 0;
                        int curr_pad_value = 0;
                        int gap = 0;
                        tw.WriteLine();
                        object_name = ds.Tables[t].Rows[0]["object_name"].ToString() + ",";
                        object_name = "".PadLeft(2) + object_name;
                        tw.WriteLine(object_name);
                        for (int i = 0; i < ds.Tables[t].Rows.Count; i++)
                        {
                            int pad_value = 25;
                            string attribute_name = ds.Tables[t].Rows[i]["attribute_name"].ToString();
                            string attribute_value = ds.Tables[t].Rows[i]["attribute_value"].ToString();

                            //For Adjusting Pading Value

                            curr_pad_value = attribute_value.Length;
                            if (prev_pad_value == 0)
                            {
                                prev_pad_value = attribute_value.Length;
                            }
                            if (curr_pad_value > prev_pad_value)
                            {
                                gap = curr_pad_value - prev_pad_value;
                                pad_value = pad_value - gap;
                            }
                            if (curr_pad_value < prev_pad_value)
                            {
                                gap = prev_pad_value - curr_pad_value;
                                pad_value = pad_value + gap;
                            }

                            if (pad_value < 0 || pad_value == 0)
                            {
                                pad_value = 5;
                            }

                            attribute_line = attribute_value + ",".PadRight(pad_value) + "!-" + attribute_name;
                            attribute_line = "".PadLeft(5) + attribute_line;
                            sb.AppendLine(attribute_line);
                        }

                        int index = sb.ToString().LastIndexOf(",");
                        sb[index] = ';';
                        char[] s = sb.ToString().ToArray();
                        tw.WriteLine(sb.ToString());
                        sb.Clear();
                    }

                }


            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
        finally
        {
            tw.Close();
        }
    }

    private void GenerateEquipmentBlockInIDF(DataSet ds_equipment, int i, string file_name)
    {
        System.IO.StreamWriter tw = null;
        try
        {
            string attribute_line = "";
            string object_name = "";
            string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
            StringBuilder sb = new StringBuilder();
            tw = new System.IO.StreamWriter(newfilePath, true);
            ArrayList omni_id = new ArrayList();
            ArrayList asset_id = new ArrayList();
            if (ds_equipment.Tables[i].Rows.Count > 0)
            {
                tw.WriteLine();
                for (int j = 0; j < ds_equipment.Tables[i].Rows.Count; j++)
                {
                    //if (!omni_id.Contains(ds_equipment.Tables[i].Rows[j]["omniclass_id"].ToString()))
                    //{

                    //    //asset_id.Add(ds_equipment.Tables[i].Rows[j]["asset_id"].ToString());
                    //}

                    if (!asset_id.Contains(ds_equipment.Tables[i].Rows[j]["asset_id"].ToString()))
                    {
                        asset_id.Add(ds_equipment.Tables[i].Rows[j]["asset_id"].ToString());
                        omni_id.Add(ds_equipment.Tables[i].Rows[j]["omniclass_id"].ToString());
                    }
                }

            }

            if (omni_id.Count > 1)
            {
                for (int k = 0; k < omni_id.Count; k++)
                {
                    if (ds_equipment.Tables[i].Rows.Count > 0)
                    {
                        int prev_pad_value = 0;
                        int curr_pad_value = 0;
                        int gap = 0;
                        object_name = ds_equipment.Tables[i].Rows[0]["object_name"].ToString() + ",";
                        object_name = "".PadLeft(2) + object_name;
                        tw.WriteLine(object_name);
                        for (int j = 0; j < ds_equipment.Tables[i].Rows.Count; j++)
                        {

                            if (omni_id[k].ToString().Equals(ds_equipment.Tables[i].Rows[j]["omniclass_id"].ToString()) && asset_id[k].ToString().Equals(ds_equipment.Tables[i].Rows[j]["asset_id"].ToString()))
                            {
                                int pad_value = 25;
                                string attribute_name = ds_equipment.Tables[i].Rows[j]["attribute_name"].ToString();
                                string attribute_value = ds_equipment.Tables[i].Rows[j]["attribute_value"].ToString();

                                //For Adjusting Pading Value

                                curr_pad_value = attribute_value.Length;
                                if (prev_pad_value == 0)
                                {
                                    prev_pad_value = attribute_value.Length;
                                }
                                if (curr_pad_value > prev_pad_value)
                                {
                                    gap = curr_pad_value - prev_pad_value;
                                    pad_value = pad_value - gap;
                                }
                                if (curr_pad_value < prev_pad_value)
                                {
                                    gap = prev_pad_value - curr_pad_value;
                                    pad_value = pad_value + gap;
                                }

                                if (pad_value < 0 || pad_value == 0)
                                {
                                    pad_value = 5;
                                }

                                attribute_line = attribute_value + ",".PadRight(pad_value) + "!-" + attribute_name;
                                attribute_line = "".PadLeft(5) + attribute_line;
                                sb.AppendLine(attribute_line);
                            }
                        }
                    }
                    int index = sb.ToString().LastIndexOf(",");
                    sb[index] = ';';
                    char[] s = sb.ToString().ToArray();
                    tw.WriteLine(sb.ToString());
                    sb.Clear();
                }
            }
            else
            {
                if (ds_equipment.Tables[i].Rows.Count > 0)
                {
                    //StringBuilder sb1 = new StringBuilder();
                    int prev_pad_value = 0;
                    int curr_pad_value = 0;
                    int gap = 0;
                    object_name = ds_equipment.Tables[i].Rows[0]["object_name"].ToString() + ",";
                    object_name = "".PadLeft(2) + object_name;
                    tw.WriteLine(object_name);
                    for (int j = 0; j < ds_equipment.Tables[i].Rows.Count; j++)
                    {
                        int pad_value = 25;
                        string attribute_name = ds_equipment.Tables[i].Rows[j]["attribute_name"].ToString();
                        string attribute_value = ds_equipment.Tables[i].Rows[j]["attribute_value"].ToString();
                        curr_pad_value = attribute_value.Length;
                        if (prev_pad_value == 0)
                        {
                            prev_pad_value = attribute_value.Length;
                        }
                        if (curr_pad_value > prev_pad_value)
                        {
                            gap = curr_pad_value - prev_pad_value;
                            pad_value = pad_value - gap;
                        }
                        if (curr_pad_value < prev_pad_value)
                        {
                            gap = prev_pad_value - curr_pad_value;
                            pad_value = pad_value + gap;
                        }

                        if (pad_value < 0 || pad_value == 0)
                        {
                            pad_value = 5;
                        }
                        if (j == (ds_equipment.Tables[i].Rows.Count - 1))
                        {
                            attribute_line = attribute_value + ";".PadRight(pad_value) + "!-" + attribute_name;
                        }
                        else
                        {
                            attribute_line = attribute_value + ",".PadRight(pad_value) + "!-" + attribute_name;
                        }
                        attribute_line = "".PadLeft(5) + attribute_line;
                        //sb1.AppendLine(attribute_line.ToString());
                        //string str = sb1.ToString();
                        tw.WriteLine(attribute_line);
                    }
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
        finally
        {
            tw.Close();
        }
    }

    public void GenerateIDFFile(string fileName, string file_id)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet equipment_attribute = new DataSet();
        DataSet space_attribute = new DataSet();
        DataTable attribute = new DataTable();
        try
        {
            string NewFileName = fileName.Replace(".", "1.");
            string newfilePath = Server.MapPath("~/SimulationFiles/" + NewFileName);
            //--------------------------------------------------------------------------------------------------//
            //if (File.Exists(newfilePath))
            //{
            //    File.Delete(newfilePath);
            //}
            //System.IO.File.Copy(Server.MapPath("~/SimulationFiles/" + fileName), Server.MapPath("~/SimulationFiles/" + NewFileName));
            System.IO.StreamWriter tw = new System.IO.StreamWriter(Server.MapPath("~/SimulationFiles/" + NewFileName), true);
            //------------------------------------------------------------------------------------------------//

            tw.WriteLine();

            //tw.WriteLine("! EcoDomus Generated IDF Portion Starts\n");

            HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                //obj_energy_plus_model.File_id = new Guid(SessionController.Users_.FileID);
                obj_energy_plus_model.File_id = new Guid(file_id);
                equipment_attribute = obj_energy_plus_client.Get_Data_To_Generate_Simulation_IDF_File(obj_energy_plus_model, SessionController.ConnectionString);
                space_attribute = obj_energy_plus_client.Get_EM_Space_Attribute(obj_energy_plus_model, SessionController.ConnectionString);
                if (equipment_attribute.Tables[0] != null)
                {
                    attribute.Merge(equipment_attribute.Tables[0]);
                }
                //if (space_attribute.Tables[0] != null)
                //{
                //    attribute.Merge(space_attribute.Tables[0]);
                //}
                DataSet ds = new DataSet();
                ds.Tables.Add(attribute);
                CreateIDFFile(tw, ds, NewFileName);
                RunSimulationTools(Server.MapPath("~/SimulationFiles/" + NewFileName));
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void CreateIDFFile(StreamWriter tw, DataSet IDFFileDataSet, string NewFileName)
    {
        Hashtable GroupHashtbl = new Hashtable();
        try
        {
            if (IDFFileDataSet == null || IDFFileDataSet.Tables.Count == 0 || IDFFileDataSet.Tables[0].Rows.Count == 0) return;
            string CurrentObjectName = null;
            string PrevObjectName = null;
            string OneLine = null;
            string FieldValue = "";
            string FieldName = "";
            string Comments = "";
            int PadValue = 0;
            int MaxFieldLength = 0;
            string currentSeqId = null;
            int CurrSeqIdInt = -1;
            int PrevSeqIdInt = -1;
            string prevField = null;
            string currField = null;
            for (int LoopCounter = 0; LoopCounter < IDFFileDataSet.Tables[0].Rows.Count; LoopCounter++)
            {
                FieldValue = IDFFileDataSet.Tables[0].Rows[LoopCounter]["file_field_value"].ToString().Trim();
                if (FieldValue.Length > MaxFieldLength)
                    MaxFieldLength = FieldValue.Length;
            }
            MaxFieldLength = MaxFieldLength + 5;


            for (int LoopCounter = 0; LoopCounter < IDFFileDataSet.Tables[0].Rows.Count; LoopCounter++)
            {
                CurrentObjectName = IDFFileDataSet.Tables[0].Rows[LoopCounter]["object_name"].ToString().Trim();
                PrevSeqIdInt = CurrSeqIdInt;
                try
                {
                    CurrSeqIdInt = Int32.Parse(IDFFileDataSet.Tables[0].Rows[LoopCounter]["SEQ_ID"].ToString().Trim());
                }
                catch (Exception exp) { }
                currentSeqId = IDFFileDataSet.Tables[0].Rows[LoopCounter]["SEQ_ID"].ToString().Trim();
                currField = IDFFileDataSet.Tables[0].Rows[LoopCounter]["field_name"].ToString().Trim();
                if (PrevObjectName == null)
                {
                    PrevObjectName = CurrentObjectName;
                }

                if (prevField == null)
                {
                    prevField = currField;
                }
                if (CurrentObjectName.Equals(PrevObjectName) == false)
                {
                    OneLine = OneLine + ";" + "    ".PadRight(MaxFieldLength - PadValue - 1) + Comments + "\n\n";
                    Console.Write(OneLine);
                    tw.WriteLine(OneLine);
                    OneLine = null;
                    PrevObjectName = CurrentObjectName;
                    prevField = currField;
                }
                else
                {
                    if (CurrentObjectName.Equals("Output:Variable") == true && FieldName.Equals("Reporting Frequency") == true)
                    {
                        OneLine = OneLine + ";" + "    ".PadRight(MaxFieldLength - PadValue - 1) + Comments + "\n\n";
                        Console.Write(OneLine);
                        tw.WriteLine(OneLine);
                        OneLine = null;
                        PrevObjectName = CurrentObjectName;
                        prevField = currField;
                    }
                }
                if (OneLine == null)
                {
                    OneLine = "  " + CurrentObjectName + ",".PadRight(50 - PadValue) + "\n";
                }
                else
                {
                    // None,    2!-- Name
                    OneLine = OneLine + ",    ".PadRight(MaxFieldLength - PadValue) + Comments + "\n";
                }
                FieldValue = IDFFileDataSet.Tables[0].Rows[LoopCounter]["file_field_value"].ToString().Trim();
                FieldName = IDFFileDataSet.Tables[0].Rows[LoopCounter]["field_name"].ToString().Trim();

                string TempObjectValue = (string)GroupHashtbl[CurrentObjectName];
                if (TempObjectValue != null)
                {
                    if (TempObjectValue.Equals(currentSeqId) == true)
                    {
                        OneLine = OneLine + ";"; //+ "    ".PadRight(MaxFieldLength - PadValue - 1) + Comments + "\n\n";
                        //OneLine = OneLine.Replace(",\n;", ";\n");
                        //OneLine = OneLine.Replace(",", ";");
                        OneLine = OneLine.Substring(0, OneLine.LastIndexOf(";"));
                        string TempOneLine1 = OneLine;
                        OneLine = OneLine.Substring(0, OneLine.LastIndexOf(","));
                        string TempOneLine = TempOneLine1.Substring(TempOneLine1.LastIndexOf(",") + 3);
                        OneLine = OneLine + ";" + TempOneLine;
                        tw.WriteLine(OneLine);

                        //if( CurrSeqIdInt < PrevSeqIdInt )            
                        OneLine = "  " + CurrentObjectName + "".PadRight(50 - PadValue) + "";
                        //else
                        // OneLine = "  " + CurrentObjectName + ",".PadRight(50 - PadValue) + "";
                        tw.WriteLine(OneLine);

                        OneLine = null;
                        PrevObjectName = CurrentObjectName;

                        prevField = currField;
                    }
                }
                else
                {
                    if (GroupHashtbl.ContainsKey(CurrentObjectName) == false)
                        GroupHashtbl.Add(CurrentObjectName, currentSeqId);
                }

                Comments = "!-- " + FieldName;
                PadValue = FieldValue.Length;
                OneLine = OneLine + "    " + FieldValue;

            }

            if (OneLine != null)
                OneLine = OneLine + ";" + "    ".PadRight(MaxFieldLength - PadValue - 1) + Comments + "\n\n";

            Console.Write(OneLine);
            tw.WriteLine(OneLine);
            tw.WriteLine("  Output:SQLite,SimpleAndTabular;");
            //tw.WriteLine("! EcoDomus Generated IDF Portion Ends\n");
            tw.Close();
            OneLine = null;
            PrevObjectName = CurrentObjectName;
            prevField = currField;
        }
        catch (Exception ex)
        {

            throw ex;
        }
        finally
        {
            GroupHashtbl.Clear();
            GroupHashtbl = null;
        }
    }

    private void RunSimulationTools(string file_path)
    {
        try
        {
            StreamWriter tw = new System.IO.StreamWriter(file_path, true);
            tw.WriteLine();
            tw.WriteLine("  Output:SQLite,SimpleAndTabular;");
            tw.Close();

            string arg = file_path.Substring(file_path.LastIndexOf("\\") + 1).Replace(".idf", "");
            File.Copy(file_path, "C:\\EnergyPlusV7-0-0\\" + arg, true);
            ProcessStartInfo startInfo = new ProcessStartInfo();

            startInfo.CreateNoWindow = false;
            startInfo.UseShellExecute = false;
            startInfo.FileName = "C:\\EnergyPlusV7-0-0\\RunEPlus.bat ";
            startInfo.WindowStyle = ProcessWindowStyle.Normal;
            startInfo.Arguments = arg;
            startInfo.WorkingDirectory = "C:\\EnergyPlusV7-0-0";
            Process exeProcess = Process.Start(startInfo);
            //using (Process exeProcess = Process.Start(startInfo))
            //{
            //   exeProcess.WaitForExit();
            //}


            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = "C:\\EnergyPlusV7-0-0\\RunEPlus.bat ";
            //ProcessStartInfo psi = new ProcessStartInfo("D:\\BATFILE", "1 2  3  4  5  6  7  8  9");
            Process proc = new Process();
            proc.StartInfo = psi;
            proc.StartInfo.Arguments = string.Format(" {1}  {3} ", @"C:\Users\priyankas\Desktop\yede\4ZoneWithShading_Simple_1.idf", @"C:\EnergyPlusV7-0-0\WeatherData\USA_CA_San.Francisco.Intl.AP.724940_TMY3.epw");
            //  proc.StartInfo.Arguments = "Minimal";
            proc.Start();
            proc.WaitForExit();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void UpdateSimulationControlData(ref HiddenField hf, string val, string field_name, string obj_name)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            if (hf != null)
            {
                if (hf.Value.Equals(""))
                {
                    hf.Value = Guid.Empty.ToString();
                }
                obj_energy_plus_model.Pk_proj_simulation_control_parameter_id = new Guid(hf.Value);
                if (SessionController.Users_.Profileid != null)
                {
                    obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
                }
                if (SessionController.Users_.Em_facility_id != null)
                {
                    obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                }
                obj_energy_plus_model.Name = field_name;
                obj_energy_plus_model.Until1 = "";
                obj_energy_plus_model.attributevalues = val;
                obj_energy_plus_model.Obj_name = obj_name;
                ds = obj_energy_plus_client.Insert_Update_Energy_Modeling_Simulation_Control_Parameter(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        hf.Value = ds.Tables[0].Rows[0]["pk_proj_simulation_control_parameter_id"].ToString();
                    }
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void ddl_dzsc_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_dzsc.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_dzsc.SelectedItem.Text;
                string field_name = lbl_dzsc.Text;
                string obj_name = "SimulationControl";
                UpdateSimulationControlData(ref hf_dzsc, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ddl_dssc_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_dssc.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_dssc.SelectedItem.Text;
                string field_name = lbl_dssc.Text;
                string obj_name = "SimulationControl";
                UpdateSimulationControlData(ref hf_dssc, val, field_name, obj_name);
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ddl_dpsc_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_dpsc.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_dpsc.SelectedItem.Text;
                string field_name = lbl_dpsc.Text;
                string obj_name = "SimulationControl";
                UpdateSimulationControlData(ref hf_dpsc, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ddl_rsfsp_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_rsfsp.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_rsfsp.SelectedItem.Text;
                string field_name = lbl_rsfsp.Text;
                string obj_name = "SimulationControl";
                UpdateSimulationControlData(ref hf_rsfsp, val, field_name, obj_name);
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ddl_rsfwfrp_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            if (!ddl_rsfwfrp.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_rsfwfrp.SelectedItem.Text;
                string field_name = lbl__rsfwfrp.Text;
                string obj_name = "SimulationControl";
                UpdateSimulationControlData(ref hf_rsfwfrp, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void txt_notrtbr_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string val = txt_notrtbr.Text;
            string field_name = lbl_notrtbr.Text;
            string obj_name = "RunPeriod";
            UpdateSimulationControlData(ref hf_notrtbr, val, field_name, obj_name);

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void txt_name_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string val = txt_name.Text;
            string field_name = lbl_name.Text;
            string obj_name = "RunPeriod";
            UpdateSimulationControlData(ref hf_name, val, field_name, obj_name);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ddl_bm_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_bm.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_bm.SelectedItem.Text;
                string field_name = lbl_bm.Text;
                string obj_name = "RunPeriod";
                UpdateSimulationControlData(ref hf_bm, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ddl_bdom_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_bdom.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_bdom.SelectedItem.Text;
                string field_name = lbl_bdom.Text;
                string obj_name = "RunPeriod";
                UpdateSimulationControlData(ref hf_bdom, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ddl_em_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_em.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_em.SelectedItem.Text;
                string field_name = lbl_em.Text;
                string obj_name = "RunPeriod";
                UpdateSimulationControlData(ref hf_em, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ddl_edom_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_edom.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_edom.SelectedItem.Text;
                string field_name = lbl_edom.Text;
                string obj_name = "RunPeriod";
                UpdateSimulationControlData(ref hf_edom, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ddl_dowfsd_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_dowfsd.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_dowfsd.SelectedItem.Text;
                string field_name = lbl_dowfsd.Text;
                string obj_name = "RunPeriod";
                UpdateSimulationControlData(ref hf_dowfsd, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void ddl_uwfhasd_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_uwfhasd.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_uwfhasd.SelectedItem.Text;
                string field_name = lbl_uwfhasd.Text;
                string obj_name = "RunPeriod";
                UpdateSimulationControlData(ref hf_uwfhasd, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ddl_uwfdsp_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_uwfdsp.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_uwfdsp.SelectedItem.Text;
                string field_name = lbl_uwfdsp.Text;
                string obj_name = "RunPeriod";
                UpdateSimulationControlData(ref hf_uwfdsp, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ddl_awhr_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_awhr.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_awhr.SelectedItem.Text;
                string field_name = lbl_awhr.Text;
                string obj_name = "RunPeriod";
                UpdateSimulationControlData(ref hf_awhr, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ddl_uwfri_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_uwfri.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_uwfri.SelectedItem.Text;
                string field_name = lbl_uwfri.Text;
                string obj_name = "RunPeriod";
                UpdateSimulationControlData(ref hf_uwfri, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void ddl_uwfsi_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (!ddl_uwfsi.SelectedItem.Text.Equals("-Select-"))
            {
                string val = ddl_uwfsi.SelectedItem.Text;
                string field_name = lbl_uwfsi.Text;
                string obj_name = "RunPeriod";
                UpdateSimulationControlData(ref hf_uwfsi, val, field_name, obj_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void txt_notph_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string val = txt_notph.Text;
            string field_name = lbl_notph.Text;
            string obj_name = "Timestep";
            UpdateSimulationControlData(ref hf_notph, val, field_name, obj_name);

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    protected void btn_idf_error_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }

                //string new_file_name = file_name.Replace(".", "1.");
                //string newfilePath = Server.MapPath("~/SimulationFiles/" + new_file_name);
                //ProcessStartInfo startInfo = new ProcessStartInfo();
                //startInfo.FileName = "notepad.exe";
                //startInfo.Arguments = path + "\\" + new_file_name.Replace(".idf", ".err");
                //startInfo.WorkingDirectory = "C:\\EnergyPlusV7-0-0";
                //using (Process exeProcess = Process.Start(startInfo))
                //{
                //    exeProcess.WaitForExit();
                //}
            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_table_Click(object sender, EventArgs e)
    {
        string[] file_ext = new string[] { ".csv", ".tab", ".txt" };
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string idf_ext = Path.GetExtension(newfilePath);
                for (int i = 0; i < file_ext.Length; i++)
                {
                    string file_to_open = path + "\\" + file_name.Replace(idf_ext, "Table" + file_ext[i]);
                    if (File.Exists(file_to_open))
                    {
                        lbl_err_msg.Text = "";
                        Process notePad = new Process();
                        notePad.StartInfo.FileName = "notepad.exe";
                        notePad.StartInfo.Arguments = file_to_open;
                        notePad.Start();
                    }
                    else
                    {
                        lbl_err_msg.Text = "The file or folder does not exist";
                    }
                }
            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_dein_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {

                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".delight.in");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void Button5_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_bnd_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".bnd");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_bsmto_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_bsmtc_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_meters_Click(object sender, EventArgs e)
    {
        string[] file_ext = new string[] { ".csv", ".tab", ".txt" };
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                for (int i = 0; i < file_ext.Length; i++)
                {
                    string file_to_open = path + "\\" + file_name.Replace(extension, "Meter" + file_ext[i]);
                    if (File.Exists(file_to_open))
                    {
                        lbl_err_msg.Text = "";
                        Process notePad = new Process();
                        notePad.StartInfo.FileName = "notepad.exe";
                        notePad.StartInfo.Arguments = file_to_open;
                        notePad.Start();
                    }
                    else
                    {
                        lbl_err_msg.Text = "The file or folder does not exist";
                    }
                }
            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_rdd_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".rdd");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }
            }

            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_deout_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, "delight.out");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_dfdmp_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_dbg_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".dbg");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_bsmt_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_edd_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".edd");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }
            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_variab_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_mdd_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".mdd");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_map_Click(object sender, EventArgs e)
    {
        string[] file_ext = new string[] { ".csv", ".tab", ".txt" };
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                for (int i = 0; i < file_ext.Length; i++)
                {
                    string file_to_open = path + "\\" + file_name.Replace(extension, "Map" + file_ext[i]);
                    if (File.Exists(file_to_open))
                    {
                        lbl_err_msg.Text = "";
                        Process notePad = new Process();
                        notePad.StartInfo.FileName = "notepad.exe";
                        notePad.StartInfo.Arguments = file_to_open;
                        notePad.Start();
                    }
                    else
                    {
                        lbl_err_msg.Text = "The file or folder does not exist";
                    }
                }

            }

            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_screen_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, "screen.csv");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_sln_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".sln");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_bsmta_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_eio_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".eio");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_mtd_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".mtd");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_expidf_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_shd_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".shd");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_eso_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".eso");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_slabo_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_svg_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".svg");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_zsz_Click(object sender, EventArgs e)
    {
        string[] file_ext = new string[] { ".csv", ".tab", ".txt" };
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                for (int i = 0; i < file_ext.Length; i++)
                {
                    string file_to_open = path + "\\" + file_name.Replace(extension, "zsz" + file_ext[i]);
                    if (File.Exists(file_to_open))
                    {
                        lbl_err_msg.Text = "";
                        Process notePad = new Process();
                        notePad.StartInfo.FileName = "notepad.exe";
                        notePad.StartInfo.Arguments = file_to_open;
                        notePad.Start();
                    }
                    else
                    {
                        lbl_err_msg.Text = "The file or folder does not exist";
                    }
                }

            }

            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_epmidf_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".epmidf");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_vrml_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".wrl");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_mtr_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".mtr");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_slab_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_dxf_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".dxf");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_ssz_Click(object sender, EventArgs e)
    {
        string[] file_ext = new string[] { ".csv", ".tab", ".txt" };
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                for (int i = 0; i < file_ext.Length; i++)
                {
                    string file_to_open = path + "\\" + file_name.Replace(extension, "Ssz" + file_ext[i]);
                    if (File.Exists(file_to_open))
                    {
                        lbl_err_msg.Text = "";
                        Process notePad = new Process();
                        notePad.StartInfo.FileName = "notepad.exe";
                        notePad.StartInfo.Arguments = file_to_open;
                        notePad.Start();
                    }
                    else
                    {
                        lbl_err_msg.Text = "The file or folder does not exist";
                    }
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_epmdet_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".epmdet");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_audit_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".audit");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
            else
            {
                lbl_err_msg.Text = "First run the simulation";
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_proc_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_idf_slaberr_Click(object sender, EventArgs e)
    {

        try
        {
            if (!hf_ep_batch_file_path.Value.Equals(""))
            {
                path = hf_ep_batch_file_path.Value;
            }
            if (!hf_idf_file_name.Value.Equals(""))
            {
                string file_name = hf_idf_file_name.Value;
                string newfilePath = Path.Combine(Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id), file_name);
                string extension = Path.GetExtension(newfilePath);
                string file_to_open = path + "\\" + file_name.Replace(extension, ".err");
                if (File.Exists(file_to_open))
                {
                    lbl_err_msg.Text = "";
                    Process notePad = new Process();
                    notePad.StartInfo.FileName = "notepad.exe";
                    notePad.StartInfo.Arguments = file_to_open;
                    notePad.Start();
                }
                else
                {
                    lbl_err_msg.Text = "The file or folder does not exist";
                }

            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void UpdateProgressContext()
    {
        const int total = 100;

        RadProgressContext progress = RadProgressContext.Current;
        progress.Speed = "N/A";

        for (int i = 0; i < total; i++)
        {
            progress.PrimaryTotal = 1;
            progress.PrimaryValue = 1;
            progress.PrimaryPercent = i;

            progress.SecondaryTotal = total;
            progress.SecondaryValue = i;
            progress.SecondaryPercent = i;

            progress.CurrentOperationText = "Step " + i.ToString();

            if (!Response.IsClientConnected)
            {
                //Cancel button was clicked or the browser was closed, so stop processing
                break;
            }

            progress.TimeEstimated = (total - i) * 100;
            //Stall the current thread for 0.1 seconds
            System.Threading.Thread.Sleep(100);
        }
    }
    #region SQLite Import
    private void ImportSQLiteData()
    {
        try
        {
            ConnectToDatabase();
            CreateProcedures();
            ImportData();
        }
        catch (Exception ex)
        {

            throw ex;
        }
        finally
        {
            SQLConn.Close();
            SQLiteConn.Close();
        }
    }
    private void ConnectToDatabase()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            if (!hf_idf_file_name.Value.Equals(""))
            {
                if (!hf_ep_batch_file_path.Value.Equals(""))
                {
                    path = hf_ep_batch_file_path.Value;
                }
                //string new_file_name = hf_idf_file_name.Value.Replace(".", "1.");
                string file_name = hf_idf_file_name.Value.Replace(".idf", ".sql");
                string sqlite_conn_str = "Data Source=" + Path.Combine(path, file_name) + ";Version=3;";
                SQLiteConn = new System.Data.SQLite.SQLiteConnection(sqlite_conn_str);
                SQLiteConn.Open();
                string conn_str = obj_energy_plus_client.Get_Connection_String(obj_energy_plus_model, SessionController.ConnectionString);
                //SQLConn = new System.Data.SqlClient.SqlConnection("Data Source=ZCON-86\\SQLEXPRESS;Initial Catalog=EnergyPlus;User ID=sa;Password=zcon@123;Connect Timeout=50000000");
                SQLConn = new System.Data.SqlClient.SqlConnection(conn_str);
                SQLConn.Open();

            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    private void CreateProcedures()
    {
        System.Data.SqlClient.SqlCommand FromSQLCmd = new System.Data.SqlClient.SqlCommand();
        FromSQLCmd.Connection = SQLConn;
        FromSQLCmd.CommandType = CommandType.Text;
        FromSQLCmd.CommandText = "SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'TBL_ENERGYMODELING_%'";
        DataSet FromSQLDS = new DataSet();
        System.Data.SqlClient.SqlDataAdapter FromSQLADP = new System.Data.SqlClient.SqlDataAdapter(FromSQLCmd);
        FromSQLADP.Fill(FromSQLDS);

        if (FromSQLDS != null && FromSQLDS.Tables.Count > 0 && FromSQLDS.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < FromSQLDS.Tables[0].Rows.Count; i++)
            {
                FromSQLCmd = new System.Data.SqlClient.SqlCommand();
                FromSQLCmd.Connection = SQLConn;
                FromSQLCmd.CommandType = CommandType.Text;

                String tbl_name = FromSQLDS.Tables[0].Rows[i][0].ToString();

                try
                {
                    String SQLCmdText = "DROP PROCEDURE [dbo].[Import_" + FromSQLDS.Tables[0].Rows[i][0].ToString() + "]\n";
                    FromSQLCmd.CommandText = SQLCmdText;

                    FromSQLCmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    //throw ex;
                }
            }

            for (int i = 0; i < FromSQLDS.Tables[0].Rows.Count; i++)
            {
                try
                {
                    FromSQLCmd = new System.Data.SqlClient.SqlCommand();
                    FromSQLCmd.Connection = SQLConn;
                    FromSQLCmd.CommandType = CommandType.Text;

                    String tbl_name = FromSQLDS.Tables[0].Rows[i][0].ToString();
                    String SQLCmdText = "CREATE PROCEDURE dbo.Import_" + FromSQLDS.Tables[0].Rows[i][0].ToString() + "\n";
                    tbl_name = tbl_name.Replace("tbl_", "datatable_");
                    SQLCmdText = SQLCmdText + "\t@dt AS " + tbl_name + " READONLY,\n";
                    SQLCmdText = SQLCmdText + "\t@simulation_project_id as uniqueidentifier\nAS BEGIN\n";
                    SQLCmdText = SQLCmdText + "\tSET NOCOUNT ON;\n";
                    SQLCmdText = SQLCmdText + "\tINSERT dbo." + FromSQLDS.Tables[0].Rows[i][0].ToString() + "\n";
                    SQLCmdText = SQLCmdText + "\tSELECT newid(),@simulation_project_id ,getdate(),* FROM @dt;\n";
                    SQLCmdText = SQLCmdText + "END\n";
                    FromSQLCmd.CommandText = SQLCmdText;
                    FromSQLCmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    //throw ex;
                    //MessageBox.Show("Exception exp 2"); 

                }
            }
        }
    }
    private void ImportData()
    {
        System.Data.SqlClient.SqlCommand FromSQLCmd = new System.Data.SqlClient.SqlCommand();
        FromSQLCmd.Connection = SQLConn;
        FromSQLCmd.CommandType = CommandType.Text;
        FromSQLCmd.CommandText = "SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'TBL_ENERGYMODELING_%'";
        DataSet FromSQLDS = new DataSet();
        System.Data.SqlClient.SqlDataAdapter FromSQLADP = new System.Data.SqlClient.SqlDataAdapter(FromSQLCmd);
        FromSQLADP.Fill(FromSQLDS);

        if (FromSQLDS != null && FromSQLDS.Tables.Count > 0 && FromSQLDS.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < FromSQLDS.Tables[0].Rows.Count; i++)
            {
                try
                {
                    DataSet FromSQLiteDS = new DataSet();

                    System.Data.SQLite.SQLiteCommand FromSQLiteCmd = new System.Data.SQLite.SQLiteCommand();
                    FromSQLiteCmd.Connection = SQLiteConn;
                    FromSQLiteCmd.CommandType = CommandType.Text;
                    String sqlite_tbl_name = FromSQLDS.Tables[0].Rows[i][0].ToString();
                    sqlite_tbl_name = sqlite_tbl_name.Replace("tbl_energymodeling_", "");

                    FromSQLiteCmd.CommandText = "Select * from " + sqlite_tbl_name;
                    System.Data.SQLite.SQLiteDataAdapter SQLiteADP = new System.Data.SQLite.SQLiteDataAdapter(FromSQLiteCmd);
                    SQLiteADP.Fill(FromSQLiteDS);

                    DataTable tvp = FromSQLiteDS.Tables[0];

                    SqlCommand cmd = new SqlCommand("dbo.Import_" + FromSQLDS.Tables[0].Rows[i][0].ToString(), SQLConn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter tvparam = cmd.Parameters.AddWithValue("@dt", tvp);
                    tvparam.SqlDbType = SqlDbType.Structured;

                    cmd.Parameters.AddWithValue("@simulation_project_id ", SessionController.Users_.Profileid);

                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    //throw ex;
                    //MessageBox.Show("Exception exp 3");
                }

            }
        }
    }

    #endregion

    protected void Timer1_click(object sender, EventArgs e)
    {
        try
        {
            ShowSimulationStatus();
            //Timer1.Enabled = false;
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }

    public void ShowSimulationStatus()
    {
        RadProgressContext progress = RadProgressContext.Current;
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        int status_value = 10;
        string msg = "Simulation will start in 1-2 minutes ...";
        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                if (SessionController.Users_.Profileid != null)
                {
                    obj_energy_plus_model.pk_profileid = new Guid(SessionController.Users_.Profileid);
                }

                ds = obj_energy_plus_client.Get_Energy_Modeling_Simulation_Status(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        //if (!ds.Tables[0].Rows[0]["status"].ToString().Equals("N", StringComparison.CurrentCultureIgnoreCase))
                        //{
                            //if (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["message"])))
                            //{
                                msg = Convert.ToString(ds.Tables[0].Rows[0]["message"]);
                            //}

                            if (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[0].Rows[0]["status_value"])))
                            {
                                status_value = Convert.ToInt32(ds.Tables[0].Rows[0]["status_value"]);
                            }
                           
                            //if (ds.Tables[0].Rows[0]["status"].ToString().Equals("C", StringComparison.CurrentCultureIgnoreCase))
                            //{
                                ProgressBarSimulation(status_value, msg);
                            //}
                            //else
                            //{
                                //progress.CurrentOperationText = msg;
                                //progress.SecondaryValue = status_value;
                                //progress.SecondaryPercent = status_value;
                                //ProgressBarSimulation(status_value, msg);
                            //}
                        //}
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
}