using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using EnergyPlus;
using System.Data;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;
using System.Collections;

public partial class App_NewUI_EnergyModelingAddSchedule : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (SessionController.Users_.UserId != null)
            {
                //Bind_Unit_Type_DropDown();
                //Validate("validateForSection");
                Bind_Type_Name_DropDown();
                Bind_Schedule_Name_DropDown();
                Bind_Week_Type_DropDown();
                ViewState["ids"] = null;
                if (Request.QueryString["pk_energymodel_schedule_id"] != null)
                {
                string id = Request.QueryString["pk_energymodel_schedule_id"].ToString();
                    UpdateEnergyModelSchedule(id);

                }
            }


        }
    }

    private void UpdateEnergyModelSchedule(string id)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        ViewState["schedule"] = null;
        try
        {
            if (SessionController.Users_.Em_facility_id != null && SessionController.Users_.Profileid != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
                obj_energy_plus_model.Pk_simulation_schedule_id = new Guid(id);
                ds = obj_energy_plus_client.Get_Energy_Modeling_Schedule_For_Update(obj_energy_plus_model, SessionController.ConnectionString);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    hf_pk_schedule_id.Value = id;
                    //Removing previous tabs and page views
                    txtScheduleName.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    RemoveTabAndPageViews();
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        string tab_name = ds.Tables[0].Rows[i]["week_type"].ToString();
                        //lst.Add(tab_name);
                        AddTab(tab_name, true);
                        hf_IsNewSchedule.Value = "No";
                    }
                }

                int tab_count = rdstripSchedules.Tabs.Count;
                if (tab_count > 0)
                {
                    rdstripSchedules.SelectedIndex = 0;
                    rmpageSchedules.SelectedIndex = 0;
                    rcbFor.AllowCustomText = false;
                    rcbFor.SelectedValue = rdstripSchedules.Tabs[0].Text.Replace(" ", "");
                }
            }
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    private void Bind_Week_Type_DropDown()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            ds = obj_energy_plus_client.Get_Simulation_Week_Type(obj_energy_plus_model, SessionController.ConnectionString);
            rcbFor.DataSource = ds;
            rcbFor.DataTextField = "week_type_text";
            rcbFor.DataValueField = "week_type_value";
            rcbFor.DataBind();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void Bind_Schedule_Name_DropDown()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            //ds = obj_energy_plus_client.Get_Simulation_Schedule_Names(obj_energy_plus_model, SessionController.ConnectionString);
            //rcbScheduleName.DataSource = ds;
            //rcbScheduleName.DataTextField = "name";
            //rcbScheduleName.DataValueField = "name";
            //rcbScheduleName.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void Bind_Type_Name_DropDown()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            ds = obj_energy_plus_client.Get_Simulation_Type_Name(obj_energy_plus_model, SessionController.ConnectionString);
            rcbTypeName.DataSource = ds;
            rcbTypeName.DataTextField = "name";
            rcbTypeName.DataValueField = "pk_simulation_schedule_limit_id";
            rcbTypeName.DataBind();
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

            //redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    private void Bind_Unit_Type_DropDown()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            DataSet ds = new DataSet();
            ds = obj_energy_plus_client.Get_Simulation_Schedule_Limit(obj_energy_plus_model, SessionController.ConnectionString);
            rcbTypeName.DataSource = ds;
            rcbTypeName.DataTextField = "name";
            rcbTypeName.DataValueField = "pk_simulation_schedule_limit_id";
            rcbTypeName.DataBind();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            string strTabName = rcbFor.SelectedItem.Text.ToString();
            if (!rcbFor.SelectedItem.Value.Equals("Select"))
            {
                AddTab(strTabName, true);

            }
            RadTab tab = (RadTab)rdstripSchedules.Tabs.FindTabByText(strTabName);
            if (tab != null)
            {
                tab.Selected = true;
            }
           
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void AddTab(string tabName, bool enabled)
    {
        try
        {
            string tabValue = tabName.Replace(" ", "");
            RadTab tab1 = (RadTab)rdstripSchedules.Tabs.FindTabByValue(tabValue);
            if (tab1 == null)
            {
                //dvBtn.Style["display"] = "block";
                RadTab tab = new RadTab(tabName);
                tab.Enabled = enabled;
                tab.Value = tabName.Replace(" ", "");
                rdstripSchedules.Tabs.Add(tab);
                tab.PageViewID = @"~/App/UserControls/" + "Schedules" + tab.Value.Replace(" ", "");
                AddPageView(tabName.Replace(" ", ""));
                hf_tab_name.Value = tabName;
                //CheckUncheckCheckboxes(tabName);
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void CheckUncheckCheckboxes(string tabName)
    {
        try
        {

            CheckBox chkWeekDays = (CheckBox)Page.FindControl("chkWeekDays");
            if (chkWeekDays != null)
            {
                if (!chkWeekDays.Enabled)
                {
                    chkWeekDays.Enabled = true;
                }
                chkWeekDays.Checked = false;
            }
            CheckBox chkAllDays = (CheckBox)Page.FindControl("chkAllDays");
            if (chkAllDays != null)
            {
                if (!chkAllDays.Enabled)
                {
                    chkAllDays.Enabled = true;
                }
                chkAllDays.Checked = false;
            }
            CheckBox chkAllOtherDays = (CheckBox)Page.FindControl("chkAllOtherDays");
            if (chkAllOtherDays != null)
            {
                if (!chkAllOtherDays.Enabled)
                {
                    chkAllOtherDays.Enabled = true;
                }
                chkAllOtherDays.Checked = false;
            }
            CheckBox chkWinterDesignDay = (CheckBox)Page.FindControl("chkWinterDesignDay");
            if (chkWinterDesignDay != null)
            {
                if (!chkWinterDesignDay.Enabled)
                {
                    chkWinterDesignDay.Enabled = true;
                }
                chkWinterDesignDay.Checked = false;
            }
            CheckBox chkSummerDesignDays = (CheckBox)Page.FindControl("chkSummerDesignDays");
            if (chkSummerDesignDays != null)
            {
                if (!chkSummerDesignDays.Enabled)
                {
                    chkSummerDesignDays.Enabled = true;
                }
                chkSummerDesignDays.Checked = false;
            }
            CheckBox chkCustomDay1 = (CheckBox)Page.FindControl("chkCustomDay1");
            if (chkCustomDay1 != null)
            {
                if (!chkCustomDay1.Enabled)
                {
                    chkCustomDay1.Enabled = true;
                }
                chkCustomDay1.Checked = false;


            }
            CheckBox chkCustomDay2 = (CheckBox)Page.FindControl("chkCustomDay2");
            if (chkCustomDay2 != null)
            {
                if (!chkCustomDay2.Enabled)
                {
                    chkCustomDay2.Enabled = true;
                }
                chkCustomDay2.Checked = false;
            }
            CheckBox chkWeekEnds = (CheckBox)Page.FindControl("chkWeekEnds");
            if (chkWeekEnds != null)
            {
                if (!chkWeekEnds.Enabled)
                {
                    chkWeekEnds.Enabled = true;
                }
                chkWeekEnds.Checked = false;


            }
            CheckBox chkHoliday = (CheckBox)Page.FindControl("chkHoliday");
            if (chkHoliday != null)
            {
                if (!chkHoliday.Enabled)
                {
                    chkHoliday.Enabled = true;
                }
                chkHoliday.Checked = false;
            }
            string chkID = "chk" + tabName.Replace(" ", "");
            CheckBox chkbox = (CheckBox)Page.FindControl(chkID);
            if (chkbox != null)
            {
                //chkbox.Checked = true;
                chkbox.Enabled = false;
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void RemoveTab(string tabName)
    {
        try
        {
            string tabValue = tabName.Replace(" ", "");
            RadTab rdTab = (RadTab)rdstripSchedules.Tabs.FindTabByValue(tabValue);
            if (rdTab != null)
            {
                rdstripSchedules.Tabs.Remove(rdTab);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void RemovePageView(string TabName)
    {
        try
        {
            RadMultiPage multiPage = (RadMultiPage)Page.FindControl("rmpageSchedules");
            string pageId = @"~/App/UserControls/" + "Schedules" + TabName.ToString();
            RadPageView PageView = multiPage.FindPageViewByID(pageId);
            if (PageView != null)
            {
                multiPage.PageViews.Remove(PageView);
            }


        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    private void AddPageView(string TabName)
    {
        try
        {
            RadMultiPage multiPage = (RadMultiPage)Page.FindControl("rmpageSchedules");
            RadPageView PageView = multiPage.FindPageViewByID(@"~/App/UserControls/" + TabName.ToString());
            if (PageView == null)
            {
                PageView = new RadPageView();
                PageView.ID = @"~/App/UserControls/" + "Schedules" + TabName.ToString();
                multiPage.PageViews.Add(PageView);
            }
            PageView.Selected = true;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void RadMultiPage1_PageViewCreated(object sender, Telerik.Web.UI.RadMultiPageEventArgs e)
    {
        try
        {
            Control pageViewContents = LoadControl(e.PageView.ID + "CS.ascx");
            if (pageViewContents != null)
            {
                pageViewContents.ID = e.PageView.ID + "userControl";
                e.PageView.Controls.Add(pageViewContents);

            }
            //string userControlName = e.PageView.ID + "CS.ascx";
            //Control userControl = Page.LoadControl(userControlName);
            //userControl.ID = e.PageView.ID + "userControl";
            //e.PageView.Controls.Add(userControl);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rdstripSchedules_TabClick(object sender, RadTabStripEventArgs e)
    {
        try
        {
            string strTabName = e.Tab.Text;
            string tabValue = e.Tab.Text.Replace(" ", "").Trim().ToString();
            RadTab tab = rdstripSchedules.FindTabByValue(tabValue);
            if (tab != null)
            {
                tab.Selected = true;
                rcbFor.SelectedValue = tabValue;
            }


        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            string strTabName = rcbFor.SelectedItem.Text.ToString();
            if (!rcbFor.SelectedItem.Value.Equals("Select"))
            {
                RemoveTab(strTabName);
                RemovePageView(strTabName.Replace(" ", ""));
            }
            if (rdstripSchedules.Tabs.Count == 0)
            {
                //txtName.Text = "";
                rcbFor.SelectedItem.Value = "Select";
                //dvBtn.Style["display"] = "none";
                rcbTypeName.SelectedValue = Guid.Empty.ToString();
                //txtThrough.Text = "";
                //dvSchedule.Style["display"] = "none";
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnAddNewSchedule_Click(object sender, EventArgs e)
    {
        try
        {
            RemoveTabAndPageViews();
            UncheckAllCheckboxes();
            ResetHiddenFields();
            rcbFor.SelectedValue = " --Select-- ";
            //dvBtn.Style["display"] = "none";
            rcbTypeName.SelectedValue = Guid.Empty.ToString();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void ResetHiddenFields()
    {
        try
        {
            hf_IsNewSchedule.Value = "Yes";
            hf_IsCleanData.Value = "Yes";
            hf_pk_WeekDays.Value = "";
            hf_pk_AllDays.Value = "";
            hf_pk_AllOtherDays.Value = "";
            hf_pk_WinterDesignDay.Value = "";
            hf_pk_SummerDesignDays.Value = "";
            hf_pk_CustomDay1.Value = "";
            hf_pk_CustomDay2.Value = "";
            hf_pk_WeekEnds.Value = "";
            hf_pk_Holiday.Value = "";

            week_days.Value = "";
            all_days.Value = "";
            all_other_days.Value = "";
            winter_design_day.Value = "";
            summer_design_day.Value = "";
            custom_day_1.Value = "";
            custom_day_2.Value = "";
            week_ends.Value = "";
            holiday.Value = "";
            hf_is_delete.Value = "N";
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void UncheckAllCheckboxes()
    {
        try
        {
            CheckBox chkWeekDays = (CheckBox)Page.FindControl("chkWeekDays");
            if (chkWeekDays != null)
            {
                chkWeekDays.Checked = false;
                chkWeekDays.Enabled = true;
            }
            CheckBox chkAllDays = (CheckBox)Page.FindControl("chkAllDays");
            if (chkAllDays != null)
            {
                chkAllDays.Checked = false;
                chkAllDays.Enabled = true;
            }
            CheckBox chkAllOtherDays = (CheckBox)Page.FindControl("chkAllOtherDays");
            if (chkAllOtherDays != null)
            {
                chkAllOtherDays.Checked = false;
                chkAllOtherDays.Enabled = true;
            }
            CheckBox chkWinterDesignDay = (CheckBox)Page.FindControl("chkWinterDesignDay");
            if (chkWinterDesignDay != null)
            {
                chkWinterDesignDay.Checked = false;
                chkWinterDesignDay.Enabled = true;
            }
            CheckBox chkSummerDesignDays = (CheckBox)Page.FindControl("chkSummerDesignDays");
            if (chkSummerDesignDays != null)
            {
                chkSummerDesignDays.Checked = false;
                chkSummerDesignDays.Enabled = true;
            }
            CheckBox chkCustomDay1 = (CheckBox)Page.FindControl("chkCustomDay1");
            if (chkCustomDay1 != null)
            {
                chkCustomDay1.Checked = false;
                chkCustomDay1.Enabled = true;
            }
            CheckBox chkCustomDay2 = (CheckBox)Page.FindControl("chkCustomDay2");
            if (chkCustomDay2 != null)
            {
                chkCustomDay2.Checked = false;
                chkCustomDay2.Enabled = true;
            }
            CheckBox chkWeekEnds = (CheckBox)Page.FindControl("chkWeekEnds");
            if (chkWeekEnds != null)
            {
                chkWeekEnds.Checked = false;
                chkWeekEnds.Enabled = true;
            }
            CheckBox chkHoliday = (CheckBox)Page.FindControl("chkHoliday");
            if (chkHoliday != null)
            {
                chkHoliday.Checked = false;
                chkHoliday.Enabled = true;
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void RemoveTabAndPageViews()
    {
        try
        {
            int tabCount = rdstripSchedules.Tabs.Count;
            ArrayList TabNames = new ArrayList();
            for (int i = 0; i < tabCount; i++)
            {
                string tabName = rdstripSchedules.Tabs[i].Text;
                string value = rdstripSchedules.Tabs[i].Value;
                TabNames.Add(tabName);
            }

            for (int i = 0; i < TabNames.Count; i++)
            {
                RemoveTab(TabNames[i].ToString());
                RemovePageView(TabNames[i].ToString().Replace(" ", ""));
            }

            if (hf_is_delete.Value.Equals("Y"))
            {
               // rcbScheduleName.SelectedItem.Text = "--Select--";
                //dvBtn.Style["display"] = "none";
                rcbFor.SelectedValue = " --Select-- ";
                rcbTypeName.SelectedValue = Guid.Empty.ToString();
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnDeleteSchedule_Click(object sender, EventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            obj_energy_plus_model.Name = txtScheduleName.Text;
            obj_energy_plus_client.Delete_Simulation_Schedule(obj_energy_plus_model, SessionController.ConnectionString);
            RemoveTabAndPageViews();
            ResetHiddenFields();
            //dvBtn.Style["display"] = "none";
            hf_is_delete.Value = "Y";
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rcbScheduleName_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        ArrayList lst = new ArrayList();

        try
        {
            //string scheduleName = txtScheduleName.SelectedValue.ToString();
            string scheduleName = txtScheduleName.Text;
            obj_energy_plus_model.Name = scheduleName;
            ds = obj_energy_plus_client.Get_Simulation_Schedule_Data_By_Name(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //Removing previous tabs and page views
                RemoveTabAndPageViews();
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string tab_name = ds.Tables[0].Rows[i]["week_type"].ToString();
                    //lst.Add(tab_name);
                    AddTab(tab_name, true);
                    hf_IsNewSchedule.Value = "No";
                }
            }

            int tab_count = rdstripSchedules.Tabs.Count;
            if (tab_count > 0)
            {
                rdstripSchedules.SelectedIndex = 0;
                rmpageSchedules.SelectedIndex = 0;
                rcbFor.AllowCustomText = false;
                rcbFor.SelectedValue = rdstripSchedules.Tabs[0].Text.Replace(" ", "");
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    SetPermissions();
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }


    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='Component'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Schedules")
                {
                    SetPermissionToControl(dr_profile);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    private void SetPermissionToControl(DataRow dr)
    {
        Permissions objPermission = new Permissions();
        string delete_permission = dr["delete_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();

        // delete permission
        if (dr["Control_id"].ToString() == "btnDelete")
        {
            objPermission.SetEditable(btnDelete, delete_permission);
            //objPermission.SetEditable(btnDeleteSchedule, delete_permission);
        }

    }
    protected void ibtn_close_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "CloseWindow();", true);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
}