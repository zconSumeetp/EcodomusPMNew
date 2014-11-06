using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.Data;
using EnergyPlus;
using System.Collections;

public partial class App_UserControls_SchedulesAllOtherDaysCS : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
            EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
            chkAllOtherDays.Enabled = false;
            UncheckCheckBoxes();
            DisableCheckBoxes();
            if (IsFirstTime.Value.Equals("Yes"))
            {
                HiddenField hf_pk_schedule_id = (HiddenField)Page.FindControl("hf_pk_schedule_id");
                if (hf_pk_schedule_id != null && (!hf_pk_schedule_id.Value.Equals("")))
                {
                    string id = hf_pk_schedule_id.Value;
                    TextBox rcbScheduleName = (TextBox)Page.FindControl("txtScheduleName");
                    if (rcbScheduleName != null)
                    {
                        obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                        obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
                        obj_energy_plus_model.Pk_simulation_schedule_id = new Guid(id);
                        ds = obj_energy_plus_client.Get_Energy_Modeling_Schedule_For_Update(obj_energy_plus_model, SessionController.ConnectionString);
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DisableCheckBoxes(ds);
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                string tab_name = ds.Tables[0].Rows[i]["week_type"].ToString();
                                if (tab_name.Equals("AllOtherDays"))
                                {
                                    BindScheduleData(ds, i);
                                    Check_For_Other_Week_Types(ds, i);
                                }
                                //bool all_other_days = Convert.ToBoolean(ds.Tables[0].Rows[i]["all_other_days"]);
                                //if (all_other_days)
                                //{
                                //    BindScheduleData(ds, i);
                                //}
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

    }

    private void DisableCheckBoxes(DataSet ds)
    {
        try
        {
            RadTabStrip rdstripSchedules = (RadTabStrip)Page.FindControl("rdstripSchedules");
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string tabName = ds.Tables[0].Rows[i]["week_type"].ToString();
                string chkID = "chk" + tabName.Replace(" ", "");
                CheckBox chkbox = (CheckBox)FindControl(chkID);
                if (chkbox != null)
                {
                    chkbox.Checked = false;
                    chkbox.Enabled = false;
                }
            }


        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    private void DisableCheckBoxes()
    {
        try
        {
            RadTabStrip rdstripSchedules = (RadTabStrip)Page.FindControl("rdstripSchedules");
            if (rdstripSchedules != null)
            {
                int tabCount = rdstripSchedules.Tabs.Count;
                ArrayList TabNames = new ArrayList();
                for (int i = 0; i < tabCount; i++)
                {
                    string tabName = rdstripSchedules.Tabs[i].Text;
                    string value = rdstripSchedules.Tabs[i].Value;
                    string chkID = "chk" + tabName.Replace(" ", "");
                    CheckBox chkbox = (CheckBox)FindControl(chkID);
                    if (chkbox != null)
                    {
                        chkbox.Checked = false;
                        chkbox.Enabled = false;
                    }
                }

            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void Check_For_Other_Week_Types(DataSet ds, int i)
    {
        try
        {
            bool week_days = Convert.ToBoolean(ds.Tables[0].Rows[i]["week_days"]);
            if (week_days)
            {
                chkWeekDays.Checked = true;
            }
            bool all_days = Convert.ToBoolean(ds.Tables[0].Rows[i]["all_days"]);

            if (all_days)
            {
                chkAllDays.Checked = true;
            }
            bool all_other_days = Convert.ToBoolean(ds.Tables[0].Rows[i]["all_other_days"]);
            if (all_other_days)
            {
                chkAllOtherDays.Checked = true;
            }
            bool winter_design_day = Convert.ToBoolean(ds.Tables[0].Rows[i]["winter_design_day"]);
            if (winter_design_day)
            {
                chkWinterDesignDay.Checked = true;
            }
            bool summer_design_days = Convert.ToBoolean(ds.Tables[0].Rows[i]["summer_design_days"]);
            if (summer_design_days)
            {
                chkSummerDesignDays.Checked = true;
            }
            bool custom_day_1 = Convert.ToBoolean(ds.Tables[0].Rows[i]["custom_day_1"]);
            if (custom_day_1)
            {
                chkCustomDay1.Checked = true;
            }
            bool custom_day_2 = Convert.ToBoolean(ds.Tables[0].Rows[i]["custom_day_2"]);
            if (custom_day_2)
            {
                chkCustomDay2.Checked = true;
            }
            bool week_ends = Convert.ToBoolean(ds.Tables[0].Rows[i]["week_ends"]);
            if (week_ends)
            {
                chkWeekEnds.Checked = true;
            }
            bool holiday = Convert.ToBoolean(ds.Tables[0].Rows[i]["holiday"]);
            if (holiday)
            {
                chkHoliday.Checked = true;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void UncheckCheckBoxes()
    {
        try
        {
            HiddenField week_days = (HiddenField)Page.FindControl("week_days");
            if (week_days != null)
            {
                if (!week_days.Value.Equals(""))
                {
                    if (chkWeekDays.Enabled)
                    {
                        chkWeekDays.Checked = false;
                        chkWeekDays.Enabled = false;
                    }
                }

            }

            HiddenField all_days = (HiddenField)Page.FindControl("all_days");
            if (all_days != null)
            {
                if (!all_days.Value.Equals(""))
                {
                    if (chkAllDays.Enabled)
                    {
                        chkAllDays.Checked = false;
                        chkAllDays.Enabled = false;
                    }
                }

            }

            HiddenField all_other_days = (HiddenField)Page.FindControl("all_other_days");
            if (all_other_days != null)
            {
                if (!all_other_days.Value.Equals(""))
                {
                    if (chkAllOtherDays.Enabled)
                    {
                        chkAllOtherDays.Checked = false;
                        chkAllOtherDays.Enabled = false;
                    }
                }

            }

            HiddenField winter_design_day = (HiddenField)Page.FindControl("winter_design_day");
            if (winter_design_day != null)
            {
                if (!winter_design_day.Value.Equals(""))
                {
                    if (chkWinterDesignDay.Enabled)
                    {
                        chkWinterDesignDay.Checked = false;
                        chkWinterDesignDay.Enabled = false;
                    }
                }

            }

            HiddenField summer_design_day = (HiddenField)Page.FindControl("summer_design_day");
            if (summer_design_day != null)
            {
                if (!summer_design_day.Value.Equals(""))
                {
                    if (chkSummerDesignDays.Enabled)
                    {
                        chkSummerDesignDays.Checked = false;
                        chkSummerDesignDays.Checked = false;
                    }
                }

            }

            HiddenField custom_day_1 = (HiddenField)Page.FindControl("custom_day_1");
            if (custom_day_1 != null)
            {
                if (!custom_day_1.Value.Equals(""))
                {
                    if (chkCustomDay1.Enabled)
                    {
                        chkCustomDay1.Checked = false;
                        chkCustomDay1.Checked = false;
                    }
                }

            }
            HiddenField custom_day_2 = (HiddenField)Page.FindControl("custom_day_2");
            if (custom_day_2 != null)
            {
                if (!custom_day_2.Value.Equals(""))
                {
                    if (chkCustomDay2.Enabled)
                    {
                        chkCustomDay2.Checked = false;
                        chkCustomDay2.Enabled = false;
                    }
                }

            }
            HiddenField week_ends = (HiddenField)Page.FindControl("week_ends");
            if (week_ends != null)
            {
                if (!week_ends.Value.Equals(""))
                {
                    if (chkWeekEnds.Enabled)
                    {
                        chkWeekEnds.Checked = false;
                        chkWeekEnds.Enabled = false;
                    }
                }

            }
            HiddenField holiday = (HiddenField)Page.FindControl("holiday");
            if (holiday != null)
            {
                if (!holiday.Value.Equals(""))
                {
                    if (chkHoliday.Enabled)
                    {
                        chkHoliday.Checked = false;
                        chkHoliday.Enabled = false;
                    }
                }

            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void CleanAllData()
    {
        try
        {
            txtMonTime.Text = "";
            txtMonLimitTime.Text = "";
            txtTueTime.Text = "";
            txtTueTimeLimit.Text = "";
            txtWenTime.Text = "";
            txtWenTimeLimit.Text = "";
            txtThuTime.Text = "";
            txtThuTimeLimit.Text = "";
            txtFriTime.Text = "";
            txtFriTimeLimit.Text = "";
            txtSatTime.Text = "";
            txtSatLimitTime.Text = "";
            txtSunTime.Text = "";
            txtSunTimeLimit.Text = "";
            txtCusTime.Text = "";
            txtCusTimeLimit.Text = "";
            txtHoliTime.Text = "";
            txtHoliTimeLimit.Text = "";
            isCleanData.Value = "No";
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void BindScheduleData(DataSet ds, int i)
    {

        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            //obj_energy_plus_model.Pk_simulation_schedule_id = new Guid(pk_simulation_schedule_id);
            //ds=obj_energy_plus_client.Get_Simulation_Schedule_Data(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                RadComboBox rcbFor = (RadComboBox)Page.FindControl("rcbFor");
                if (rcbFor != null)
                {
                    rcbFor.SelectedValue = ds.Tables[0].Rows[i]["week_type"].ToString().Replace(" ", "");
                }
                RadComboBox rcbTypeName = (RadComboBox)Page.FindControl("rcbTypeName");
                if (rcbTypeName != null)
                {
                    rcbTypeName.SelectedValue = ds.Tables[0].Rows[i]["pk_simulation_schedule_limit_id"].ToString();

                }
                txtThrough.Text = ds.Tables[0].Rows[i]["through"].ToString();
                txtMonTime.Text = ds.Tables[0].Rows[i]["until1"].ToString();
                txtMonLimitTime.Text = ds.Tables[0].Rows[i]["value1"].ToString();
                txtTueTime.Text = ds.Tables[0].Rows[i]["until2"].ToString();
                txtTueTimeLimit.Text = ds.Tables[0].Rows[i]["value2"].ToString();
                txtWenTime.Text = ds.Tables[0].Rows[i]["until3"].ToString();
                txtWenTimeLimit.Text = ds.Tables[0].Rows[i]["value3"].ToString();
                txtThuTime.Text = ds.Tables[0].Rows[i]["until4"].ToString();
                txtThuTimeLimit.Text = ds.Tables[0].Rows[i]["value4"].ToString();
                txtFriTime.Text = ds.Tables[0].Rows[i]["until5"].ToString();
                txtFriTimeLimit.Text = ds.Tables[0].Rows[i]["value5"].ToString();
                txtSatTime.Text = ds.Tables[0].Rows[i]["until6"].ToString();
                txtSatLimitTime.Text = ds.Tables[0].Rows[i]["value6"].ToString();
                txtSunTime.Text = ds.Tables[0].Rows[i]["until7"].ToString();
                txtSunTimeLimit.Text = ds.Tables[0].Rows[i]["value7"].ToString();
                txtHoliTime.Text = ds.Tables[0].Rows[i]["until8"].ToString();
                txtHoliTimeLimit.Text = ds.Tables[0].Rows[i]["value8"].ToString();
                txtCusTime.Text = ds.Tables[0].Rows[i]["until9"].ToString();
                txtCusTimeLimit.Text = ds.Tables[0].Rows[i]["value9"].ToString();
                btnSave.Text = (string)GetGlobalResourceObject("Resource", "Update");
                hf_pk_simulation_schedules_id.Value = ds.Tables[0].Rows[i]["pk_energymodel_schedule_value_id"].ToString();
                IsFirstTime.Value = "No";
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
            if (Page.IsValid)
            {
                if (chkWeekDays.Checked)
                {
                    obj_energy_plus_model.Week_days = 1;
                }

                if (chkAllDays.Checked)
                {
                    obj_energy_plus_model.All_days = 1;
                }

                if (chkAllOtherDays.Checked)
                {
                    obj_energy_plus_model.All_other_days = 1;
                }

                if (chkWinterDesignDay.Checked)
                {
                    obj_energy_plus_model.Winter_design_day = 1;
                }

                if (chkSummerDesignDays.Checked)
                {
                    obj_energy_plus_model.Summer_design_days = 1;
                }

                if (chkCustomDay1.Checked)
                {
                    obj_energy_plus_model.Custom_day_1 = 1;
                }

                if (chkCustomDay2.Checked)
                {
                    obj_energy_plus_model.Custom_day_2 = 1;
                }

                if (chkWeekEnds.Checked)
                {
                    obj_energy_plus_model.Week_ends = 1;
                }

                if (chkHoliday.Checked)
                {
                    obj_energy_plus_model.Holiday = 1;
                }

                obj_energy_plus_model.Through = txtThrough.Text;
                //To update the flags
                Update_Flag_For_Schedules(obj_energy_plus_model);

                if (hf_pk_simulation_schedules_id.Value.Equals(""))
                {
                    Insert_Schedules_Data(obj_energy_plus_model);

                }
                else
                {
                    Update_Schedules_Data(obj_energy_plus_model);

                }
                HiddenField week_days = (HiddenField)Page.FindControl("all_other_days");
                if (week_days != null)
                {
                    week_days.Value = "chkAllOtherDays";
                }


            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void Update_Flag_For_Schedules(EnergyPlusModel obj_energy_plus_model)
    {
       
        try
        {
            EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
            TextBox objComboBox = (TextBox)Page.FindControl("txtScheduleName");
            if (objComboBox != null)
            {
                obj_energy_plus_model.Name = objComboBox.Text;
            }
            obj_energy_plus_model.Col_name = "all_other_days";
            obj_energy_plus_model.Col_value = 0;
            obj_energy_plus_client.Update_Flag_For_Schedules(obj_energy_plus_model, SessionController.ConnectionString);

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void Insert_Schedules_Data(string strFor, HiddenField hfField)
    {

        {
            EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
            EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
            DataSet ds = new DataSet();
            try
            {
                HiddenField hf_IsNewSchedule = (HiddenField)Page.FindControl("hf_IsNewSchedule");
                if (hf_IsNewSchedule != null)
                {
                    obj_energy_plus_model.Flag = hf_IsNewSchedule.Value;
                }
                TextBox objComboBox = (TextBox)Page.FindControl("txtScheduleName");
                if (objComboBox != null)
                {
                    obj_energy_plus_model.Name = objComboBox.Text;
                }
                RadComboBox rcbTypeName = (RadComboBox)Page.FindControl("rcbTypeName");
                if (rcbTypeName != null)
                {
                    obj_energy_plus_model.Fk_simulation_schedule_limit_id = new Guid(rcbTypeName.SelectedItem.Value.ToString());
                }
                RadComboBox rcbFor = (RadComboBox)Page.FindControl("rcbFor");
                if (rcbFor != null)
                {
                    obj_energy_plus_model.Week_type = strFor;
                }
                TextBox txtThrough = (TextBox)Page.FindControl("txtThrough");
                if (txtThrough != null)
                {
                    obj_energy_plus_model.Through = txtThrough.Text;
                }


                obj_energy_plus_model.Until1 = txtMonTime.Text;
                obj_energy_plus_model.Value1 = txtMonLimitTime.Text;

                obj_energy_plus_model.Until2 = txtTueTime.Text;
                obj_energy_plus_model.Value2 = txtTueTimeLimit.Text;

                obj_energy_plus_model.Unti3 = txtWenTime.Text;
                obj_energy_plus_model.Value3 = txtWenTimeLimit.Text;

                obj_energy_plus_model.Until4 = txtThuTime.Text;
                obj_energy_plus_model.Value4 = txtThuTimeLimit.Text;

                obj_energy_plus_model.Until5 = txtFriTime.Text;
                obj_energy_plus_model.Value5 = txtFriTimeLimit.Text;

                obj_energy_plus_model.Until6 = txtSatTime.Text;
                obj_energy_plus_model.Value6 = txtSatLimitTime.Text;

                obj_energy_plus_model.Until7 = txtSunTime.Text;
                obj_energy_plus_model.Value7 = txtSunTimeLimit.Text;

                obj_energy_plus_model.Until8 = txtHoliTime.Text;
                obj_energy_plus_model.Value8 = txtHoliTimeLimit.Text;

                obj_energy_plus_model.Until9 = txtCusTime.Text;
                obj_energy_plus_model.Value9 = txtCusTimeLimit.Text;

                obj_energy_plus_model.Created_by = new Guid(SessionController.Users_.UserId);
                ds = obj_energy_plus_client.Insert_Update_Simulation_Schedule(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (!ds.Tables[0].Rows[0]["pk_simulation_schedules_id"].ToString().Equals(Guid.Empty.ToString()))
                    {
                        lblMsg.Text = "Saved successfully";

                    }
                    if (hfField != null)
                    {
                        hfField.Value = ds.Tables[0].Rows[0]["pk_simulation_schedules_id"].ToString();
                    }
                    //btnSave.Text = (string)GetGlobalResourceObject("Resource", "Update");
                }

            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
    }
    
    protected void Insert_Schedules_Data(EnergyPlusModel obj_energy_plus_model)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        //EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
           
            HiddenField hf_IsNewSchedule = (HiddenField)Page.FindControl("hf_IsNewSchedule");
            if (hf_IsNewSchedule != null)
            {
                if (hf_IsNewSchedule.Value.Equals("Yes"))
                {
                    obj_energy_plus_model.Flag = "Yes";
                    //hf_IsNewSchedule.Value = "No";
                }
                else
                {
                    obj_energy_plus_model.Flag = hf_IsNewSchedule.Value;
                }
            }
            TextBox objComboBox = (TextBox)Page.FindControl("txtScheduleName");
            if (objComboBox != null)
            {
                obj_energy_plus_model.Name = objComboBox.Text;
            }
            RadComboBox rcbTypeName = (RadComboBox)Page.FindControl("rcbTypeName");
            if (rcbTypeName != null)
            {
                obj_energy_plus_model.Fk_simulation_schedule_limit_id = new Guid(rcbTypeName.SelectedItem.Value.ToString());
            }
            RadComboBox rcbFor = (RadComboBox)Page.FindControl("rcbFor");
            if (rcbFor != null)
            {
                obj_energy_plus_model.Week_type = rcbFor.SelectedItem.Text;
            }
            TextBox txtThrough = (TextBox)Page.FindControl("txtThrough");
            if (txtThrough != null)
            {
                obj_energy_plus_model.Through = txtThrough.Text;
            }

            obj_energy_plus_model.Until1 = txtMonTime.Text;
            obj_energy_plus_model.Value1 = txtMonLimitTime.Text;

            obj_energy_plus_model.Until2 = txtTueTime.Text;
            obj_energy_plus_model.Value2 = txtTueTimeLimit.Text;

            obj_energy_plus_model.Unti3 = txtWenTime.Text;
            obj_energy_plus_model.Value3 = txtWenTimeLimit.Text;

            obj_energy_plus_model.Until4 = txtThuTime.Text;
            obj_energy_plus_model.Value4 = txtThuTimeLimit.Text;

            obj_energy_plus_model.Until5 = txtFriTime.Text;
            obj_energy_plus_model.Value5 = txtFriTimeLimit.Text;

            obj_energy_plus_model.Until6 = txtSatTime.Text;
            obj_energy_plus_model.Value6 = txtSatLimitTime.Text;

            obj_energy_plus_model.Until7 = txtSunTime.Text;
            obj_energy_plus_model.Value7 = txtSunTimeLimit.Text;

            obj_energy_plus_model.Until8 = txtHoliTime.Text;
            obj_energy_plus_model.Value8 = txtHoliTimeLimit.Text;

            obj_energy_plus_model.Until9 = txtCusTime.Text;
            obj_energy_plus_model.Value9 = txtCusTimeLimit.Text;

            obj_energy_plus_model.Created_by = new Guid(SessionController.Users_.UserId);
            ds=obj_energy_plus_client.Insert_Update_Energy_Modeling_Compact_Schedule(obj_energy_plus_model, SessionController.ConnectionString);
            HiddenField hfField = (HiddenField)Page.FindControl("hf_pk_WeekDays");
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (!ds.Tables[0].Rows[0]["pk_energymodel_schedule_value_id"].ToString().Equals(Guid.Empty.ToString()))
                {
                    lblMsg.Text = "Saved successfully";
                    hf_pk_simulation_schedules_id.Value = ds.Tables[0].Rows[0]["pk_energymodel_schedule_value_id"].ToString();
                    if (hfField != null)
                    {
                        hfField.Value = hf_pk_simulation_schedules_id.Value;
                    }
                    btnSave.Text = (string)GetGlobalResourceObject("Resource", "Update");
                    if (hf_IsNewSchedule != null)
                    {
                        hf_IsNewSchedule.Value = "No";
                    }

                    IsFirstTime.Value = "No";
                }
                else
                {
                    Label lblErrMsg = (Label)Page.FindControl("lblErrMsg");
                    if (lblErrMsg != null)
                    {
                        lblErrMsg.Text = "Name  already exists";
                    }

                }

            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void Update_Schedules_Data(string strFor, HiddenField hfField)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            HiddenField hf_IsNewSchedule = (HiddenField)Page.FindControl("hf_IsNewSchedule");
            if (hf_IsNewSchedule != null)
            {
                obj_energy_plus_model.Flag = hf_IsNewSchedule.Value;
            }
            obj_energy_plus_model.Pk_simulation_schedule_id = new Guid(hfField.Value.ToString());
            TextBox objTextBox = (TextBox)Page.FindControl("txtName");
            if (objTextBox != null)
            {
                obj_energy_plus_model.Name = objTextBox.Text;
            }
            RadComboBox rcbTypeName = (RadComboBox)Page.FindControl("rcbTypeName");
            if (rcbTypeName != null)
            {
                obj_energy_plus_model.Fk_simulation_schedule_limit_id = new Guid(rcbTypeName.SelectedItem.Value.ToString());
            }
            //RadComboBox rcbFor = (RadComboBox)Page.FindControl("rcbFor");
            //if (rcbFor != null)
            //{
            //    obj_energy_plus_model.Week_type = rcbFor.SelectedItem.Text;
            //}

            obj_energy_plus_model.Week_type = strFor;
            TextBox txtThrough = (TextBox)Page.FindControl("txtThrough");
            if (txtThrough != null)
            {
                obj_energy_plus_model.Through = txtThrough.Text;
            }
            obj_energy_plus_model.Until1 = txtMonTime.Text;
            obj_energy_plus_model.Value1 = txtMonLimitTime.Text;

            obj_energy_plus_model.Until2 = txtTueTime.Text;
            obj_energy_plus_model.Value2 = txtTueTimeLimit.Text;

            obj_energy_plus_model.Unti3 = txtWenTime.Text;
            obj_energy_plus_model.Value3 = txtWenTimeLimit.Text;

            obj_energy_plus_model.Until4 = txtThuTime.Text;
            obj_energy_plus_model.Value4 = txtThuTimeLimit.Text;

            obj_energy_plus_model.Until5 = txtFriTime.Text;
            obj_energy_plus_model.Value5 = txtFriTimeLimit.Text;

            obj_energy_plus_model.Until6 = txtSatTime.Text;
            obj_energy_plus_model.Value6 = txtSatLimitTime.Text;

            obj_energy_plus_model.Until7 = txtSunTime.Text;
            obj_energy_plus_model.Value7 = txtSunTimeLimit.Text;

            obj_energy_plus_model.Until8 = txtHoliTime.Text;
            obj_energy_plus_model.Value8 = txtHoliTimeLimit.Text;

            obj_energy_plus_model.Until9 = txtCusTime.Text;
            obj_energy_plus_model.Value9 = txtCusTimeLimit.Text;

            obj_energy_plus_model.Created_by = new Guid(SessionController.Users_.UserId);
            ds = obj_energy_plus_client.Insert_Update_Simulation_Schedule(obj_energy_plus_model, SessionController.ConnectionString);
            if (!ds.Tables[0].Rows[0]["pk_simulation_schedules_id"].ToString().Equals(Guid.Empty.ToString()))
            {
                lblMsg.Text = "Updated successfully";

            }
            else
            {
                lblMsg.Text = "";

            }


        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void Update_Schedules_Data(EnergyPlusModel obj_energy_plus_model)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        //EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            HiddenField hf_IsNewSchedule = (HiddenField)Page.FindControl("hf_IsNewSchedule");
            if (hf_IsNewSchedule != null)
            {
                obj_energy_plus_model.Flag = hf_IsNewSchedule.Value;
            }
            obj_energy_plus_model.Pk_simulation_schedule_id = new Guid(hf_pk_simulation_schedules_id.Value.ToString());
            TextBox objComboBox = (TextBox)Page.FindControl("txtScheduleName");
            if (objComboBox != null)
            {
                obj_energy_plus_model.Name = objComboBox.Text;
            }
            RadComboBox rcbTypeName = (RadComboBox)Page.FindControl("rcbTypeName");
            if (rcbTypeName != null)
            {
                obj_energy_plus_model.Fk_simulation_schedule_limit_id = new Guid(rcbTypeName.SelectedItem.Value.ToString());
            }
            RadComboBox rcbFor = (RadComboBox)Page.FindControl("rcbFor");
            if (rcbFor != null)
            {
                obj_energy_plus_model.Week_type = rcbFor.SelectedItem.Text;
            }
            TextBox txtThrough = (TextBox)Page.FindControl("txtThrough");
            if (txtThrough != null)
            {
                obj_energy_plus_model.Through = txtThrough.Text;
            }
            obj_energy_plus_model.Until1 = txtMonTime.Text;
            obj_energy_plus_model.Value1 = txtMonLimitTime.Text;

            obj_energy_plus_model.Until2 = txtTueTime.Text;
            obj_energy_plus_model.Value2 = txtTueTimeLimit.Text;

            obj_energy_plus_model.Unti3 = txtWenTime.Text;
            obj_energy_plus_model.Value3 = txtWenTimeLimit.Text;

            obj_energy_plus_model.Until4 = txtThuTime.Text;
            obj_energy_plus_model.Value4 = txtThuTimeLimit.Text;

            obj_energy_plus_model.Until5 = txtFriTime.Text;
            obj_energy_plus_model.Value5 = txtFriTimeLimit.Text;

            obj_energy_plus_model.Until6 = txtSatTime.Text;
            obj_energy_plus_model.Value6 = txtSatLimitTime.Text;

            obj_energy_plus_model.Until7 = txtSunTime.Text;
            obj_energy_plus_model.Value7 = txtSunTimeLimit.Text;

            obj_energy_plus_model.Until8 = txtHoliTime.Text;
            obj_energy_plus_model.Value8 = txtHoliTimeLimit.Text;

            obj_energy_plus_model.Until9 = txtCusTime.Text;
            obj_energy_plus_model.Value9 = txtCusTimeLimit.Text;

            obj_energy_plus_model.Created_by = new Guid(SessionController.Users_.UserId);
            ds = obj_energy_plus_client.Insert_Update_Energy_Modeling_Compact_Schedule(obj_energy_plus_model, SessionController.ConnectionString);
            if (!ds.Tables[0].Rows[0]["pk_energymodel_schedule_value_id"].ToString().Equals(Guid.Empty.ToString()))
            {
                lblMsg.Text = "Updated successfully";

            }
            else
            {
                lblMsg.Text = "";

            }


        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

}