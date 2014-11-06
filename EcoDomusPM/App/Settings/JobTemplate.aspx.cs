using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using TypeProfile;
using EcoDomus.Session;
using AttributeTemplate;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;

public partial class App_Settings_JobTemplate : System.Web.UI.Page
{
    /// set culture
    /// 
    /// </summary>
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
            throw ex;
        }

    }

    /// page load event
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindCategory();
            BindStatus();
            Bindunits();
            tbl_jobs2.Visible = false;
            bindJobTemplates();
            //rg_tasks.DataSource = string.Empty;
            //rg_tasks.DataBind();
            tbl_task_grid.Visible = false;
            //bind_task_grid(new Guid("869ad198-f813-4fea-978a-b495cc051ac6"));

            //tbl_job_template_grid.Visible = false;

        }

    }

    /// Add new job template
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_add_job_template_Click(object sender, EventArgs e)
    {
        try
        {
            tbl_jobs2.Visible = true;
            btn_add_job_template.Visible = false;
            tbl_job_template_grid.Visible = false;
            tbl_assign_unassign.Visible = false;

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    /// Save button click
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            //if (hf_job_template_id.Value != null && hf_job_template_id.Value != "")
            //{
            //    //update template
            //    Guid jobid = new Guid(hf_job_template_id.Value);
            //    Guid org_id = new Guid(hf_organization_id.Value);
            //    //update_template(jobid, org_id);
            //    clear_values();
            //    lblmsg.Text = "Template updated successfully.";
            //}
            //else
            //{
            Guid job_template_id = Guid.Empty;
            Guid job_task_id = Guid.Empty;
            if (hf_job_template_id.Value != null && hf_job_template_id.Value != "")
                job_template_id = new Guid(hf_job_template_id.Value);
            if (hf_task_id.Value != null && hf_task_id.Value != "")
                job_task_id = new Guid(hf_task_id.Value);
            Guid org_id = new Guid(Request.QueryString["organization_id"]);

            save_template(org_id, job_template_id, job_task_id);
            clear_values();
            lblmsg.Text = "Template created successfully.";
            //}
            //hf_job_template_id.Value = null;
            //tbl_assign_unassign.Visible = true;

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    /// Cancel button edit
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Button button = (Button)sender;
            string buttonId = button.ID;

            if (buttonId == "btn_cancel_task")
            {
                tbl_jobs2.Visible = false;
                btn_add_job_template.Visible = true;
                tbl_job_template_grid.Visible = true;
                tbl_assign_unassign.Visible = true;
                tbl_task_grid.Visible = false;
                bindJobTemplates();
                hf_from_task.Value = "";
                hf_job_template_id.Value = "";
                hf_job_template_name.Value = "";
                hf_task_id.Value = "";
                hf_template_category.Value = "";
            }
            else if (hf_from_task.Value != "Y")
            {
                tbl_jobs2.Visible = false;
                btn_add_job_template.Visible = true;
                tbl_job_template_grid.Visible = true;
                tbl_assign_unassign.Visible = true;
                tbl_task_grid.Visible = false;
                bindJobTemplates();
                hf_from_task.Value = "";
                hf_job_template_id.Value = "";
                hf_job_template_name.Value = "";
                hf_task_id.Value = "";
                hf_template_category.Value = "";
            }
            else
            {
                tbl_jobs2.Visible = false;
                btn_add_job_template.Visible = false;
                tbl_job_template_grid.Visible = false;
                tbl_assign_unassign.Visible = false;
                edit_job_template_task(new Guid(hf_job_template_id.Value), hf_job_template_name.Value);
            }

            clear_values();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    /// Button assing template click event
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_Assign_template_Click(object sender, EventArgs e)
    {
        try
        {
            string standards = Request.QueryString["omniclass_detail_id"];
            standards = standards.Substring(0, standards.Length - 1);

            Guid attribute_template_id = new Guid(Request.QueryString["templateId"]);
            List<Guid> jobTemplateIds = hf_selected_ids.Value.Split(',').Select(Guid.Parse).ToList();
            List<Guid> standardDetailIds = standards.Split(',').Select(Guid.Parse).ToList();

            Guid[] jobTemplateIds_final = jobTemplateIds.ToArray();
            Guid[] standardDetailIds_final = standardDetailIds.ToArray();

            using (var cli = new AttributeTemplateClient())
            {
                cli.JobTemplateLinkupAdd(attribute_template_id, jobTemplateIds_final, standardDetailIds_final, new Guid(SessionController.Users_.UserId), SessionController.ConnectionString);
            }
            lblmsg.Text = "Template successfully assigned.";
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    /// Button unassing template click event
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_unassign_template_Click(object sender, EventArgs e)
    {
        try
        {
            string standards = Request.QueryString["omniclass_detail_id"];
            standards = standards.Substring(0, standards.Length - 1);

            Guid attribute_template_id = new Guid(Request.QueryString["templateId"]);
            List<Guid> jobTemplateIds = hf_selected_ids.Value.Split(',').Select(Guid.Parse).ToList();
            List<Guid> standardDetailIds = standards.Split(',').Select(Guid.Parse).ToList();

            Guid[] jobTemplateIds_final = jobTemplateIds.ToArray();
            Guid[] standardDetailIds_final = standardDetailIds.ToArray();

            using (var cli = new AttributeTemplateClient())
            {
                cli.JobTemplateLinkupDelete(attribute_template_id, jobTemplateIds_final, standardDetailIds_final, SessionController.ConnectionString);
            }
            lblmsg.Text = "Template successfully un-assigned.";

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    /// Update job template
    /// 
    /// </summary>
    /// <param name="jobid"></param>
    /// <param name="organization_id"></param>
    private void update_template(Guid jobid, Guid organization_id)
    {
        try
        {

            AttributeTemplateClient cli = new AttributeTemplateClient();
            JobTemplateModel mdl = new JobTemplateModel();



            //AttributeTemplateModel mdl = new AttributeTemplateModel();
            //AttributeTemplateClient cli = new AttributeTemplateClient();
            //TemplateTypeModel mdl_type = new TemplateTypeModel();            

            //mdl_type.jobid = jobid;

            //mdl_type.jobTaskId = Guid.Empty;
            //mdl_type.jobname = txtName.Text;
            ////mdl_type.Pk_resource_id = Guid.Empty;
            //if (!(string.IsNullOrEmpty(cmb_Category.SelectedValue)))
            //    mdl_type.jobCategory = cmb_Category.SelectedValue;
            //else
            //    mdl_type.jobCategory = Convert.ToString(Guid.Empty);
            //mdl_type.jobdesc = txt_Description.Text;
            //mdl_type.jobTaskNumber = Txttasknumber.Text;
            //mdl_type.jobPriors = txtPriors.Text;
            //if (!(string.IsNullOrEmpty(cmb_status.SelectedValue)))
            //    mdl_type.jobStatus = cmb_status.SelectedValue;
            //else
            //    mdl_type.jobStatus = Convert.ToString(Guid.Empty);
            //mdl_type.jobDuration = txtDuration.Text;
            //if (!(string.IsNullOrEmpty(cmb_duration_unit.SelectedValue)))
            //    mdl_type.jobDurationUnit = new Guid(cmb_duration_unit.SelectedValue);
            //else
            //    mdl_type.jobDurationUnit = Guid.Empty;
            //if (!(radDatePicker.IsEmpty))
            //    mdl_type.jobStart = Convert.ToDateTime(Convert.ToDateTime(radDatePicker.SelectedDate));

            //if (!(string.IsNullOrEmpty(cmb_start_unit.SelectedValue)))
            //    mdl_type.jobStartUnit = new Guid(cmb_start_unit.SelectedValue);
            //else
            //    mdl_type.jobStartUnit = Guid.Empty;
            //mdl_type.jobFrequency = txtFrequency.Text;
            //if (!(string.IsNullOrEmpty(cmb_frequency_unit.SelectedValue)))
            //    mdl_type.jobFrequencyUnit = new Guid(cmb_frequency_unit.SelectedValue);
            //else
            //    mdl_type.jobFrequencyUnit = Guid.Empty;
            //mdl_type.CreatedBy = new Guid(SessionController.Users_.UserId);
            //mdl_type.fk_typeId = null;
            //mdl_type.Flag = "";

            //Guid org_id = organization_id;
            //mdl_type.jobResourceName = "";

            //cli.UpdateJobTemplate(mdl_type, SessionController.ConnectionString);

            tbl_jobs2.Visible = false;
            btn_add_job_template.Visible = true;
            tbl_job_template_grid.Visible = true;
            bindJobTemplates();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    /// Save new job template 
    /// 
    /// </summary>
    /// <param name="jobid"></param>
    /// <param name="organization_id"></param>
    private void save_template(Guid organization_id, Guid job_template_id, Guid job_task_id)
    {
        try
        {
            //insert job template
            AttributeTemplateClient cli = new AttributeTemplateClient();
            JobTemplateModel job_template_mdl = new JobTemplateModel();
            JobTemplateTaskModel task = new JobTemplateTaskModel();
            job_template_mdl.Id = job_template_id;
            job_template_mdl.Name = txtName.Text;

            if (!(string.IsNullOrEmpty(cmb_Category.SelectedValue)))
                job_template_mdl.JobCategoryId = new Guid(cmb_Category.SelectedValue);
            else
                job_template_mdl.JobCategoryId = Guid.Empty;

            job_template_mdl.CreatedBy = new Guid(SessionController.Users_.UserId);
            job_template_mdl.OrganizationId = organization_id;
            job_template_id = cli.SaveJobTemplate(job_template_mdl, SessionController.ConnectionString);

            //insert job template task
            task.Id = job_task_id;
            task.JobTemplateId = job_template_id;
            task.Des = txt_Description.Text;

            if (Convert.ToString(Txttasknumber.Text) == "" || Convert.ToString(Txttasknumber.Text) == null)
                task.TaskNumber = 0;
            else
                task.TaskNumber = Convert.ToDecimal(Txttasknumber.Text);
            if (Convert.ToString(txtPriors.Text) == "" || Convert.ToString(txtPriors.Text) == null)
                task.Priors = 0;
            else
                task.Priors = Convert.ToDecimal(txtPriors.Text);
            if (Convert.ToString(txtDuration.Text) == "" || Convert.ToString(txtDuration.Text) == null)
                task.Duration = "0";
            else
                task.Duration = txtDuration.Text;
            if (!(string.IsNullOrEmpty(cmb_duration_unit.SelectedValue)))
                task.DurationUnit = new Guid(cmb_duration_unit.SelectedValue);
            else
                task.DurationUnit = Guid.Empty;

            if (!(radDatePicker.IsEmpty))
                task.Start = Convert.ToDateTime(Convert.ToDateTime(radDatePicker.SelectedDate));

            if (!(string.IsNullOrEmpty(cmb_start_unit.SelectedValue)))
                task.StartUnit = new Guid(cmb_start_unit.SelectedValue);
            else
                task.StartUnit = Guid.Empty;

            if (Convert.ToString(txtFrequency.Text) == "" || Convert.ToString(txtFrequency.Text) == null)
                task.Frequency = 0;
            else
                task.Frequency = Convert.ToDecimal(txtFrequency.Text);
            if (!(string.IsNullOrEmpty(cmb_frequency_unit.SelectedValue)))
                task.FrequencyUnit = new Guid(cmb_frequency_unit.SelectedValue);
            else
                task.FrequencyUnit = Guid.Empty;

            if (!(string.IsNullOrEmpty(cmb_status.SelectedValue)))
                task.StatusId = new Guid(cmb_status.SelectedValue);
            else
                task.StatusId = Guid.Empty;
            task.ResourceIds = null;
            task.CreatedBy = new Guid(SessionController.Users_.UserId);

            cli.SaveJobTemplateTask(task, SessionController.ConnectionString);

            if (hf_from_task.Value != "Y")
            {
                tbl_jobs2.Visible = false;
                btn_add_job_template.Visible = true;
                tbl_job_template_grid.Visible = true;
                tbl_assign_unassign.Visible = true;
                bindJobTemplates();
                hf_from_task.Value = "";
                hf_job_template_id.Value = "";
                hf_job_template_name.Value = "";
                hf_task_id.Value = "";
                hf_template_category.Value = "";
            }
            else
            {
                tbl_jobs2.Visible = false;
                btn_add_job_template.Visible = false;
                tbl_job_template_grid.Visible = false;
                tbl_assign_unassign.Visible = false;
                edit_job_template_task(job_template_id, hf_job_template_name.Value);
            }



        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    /// Clear all the values 
    /// 
    /// </summary>
    private void clear_values()
    {
        try
        {
            txtName.Text = string.Empty;
            txtDuration.Text = string.Empty;
            txtFrequency.Text = string.Empty;
            Txttasknumber.Text = string.Empty;
            txtPriors.Text = string.Empty;
            txt_Description.Text = string.Empty;
            cmb_Category.ClearSelection();
            cmb_duration_unit.ClearSelection();
            cmb_frequency_unit.ClearSelection();
            cmb_start_unit.ClearSelection();
            cmb_status.ClearSelection();
            radDatePicker.Clear();
            lblmsg.Text = "";
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    /// Edit template
    /// 
    /// </summary>
    /// <param name="job_template_id"></param>
    protected void edit_template(Guid job_template_id)
    {
        try
        {
            hf_job_template_id.Value = job_template_id.ToString();

            AttributeTemplateModel mdl = new AttributeTemplateModel();
            AttributeTemplateClient cli = new AttributeTemplateClient();
            JobTemplateModel template_mdl = new JobTemplateModel();
            template_mdl = cli.GetJobTemplate(job_template_id, SessionController.ConnectionString);
            txtName.Text = template_mdl.Name;
            hf_organization_id.Value = template_mdl.OrganizationId.ToString();

            IList<JobTemplateTaskModel> task;
            task = cli.GetJobTemplateTasks(job_template_id, SessionController.ConnectionString);

            txtName.Text = "";
            cmb_Category.SelectedValue = "";
            txt_Description.Text = "";
            Txttasknumber.Text = "";
            txtPriors.Text = "";
            txtDuration.Text = "";
            cmb_duration_unit.SelectedValue = "";
            radDatePicker.SelectedDate = null;
            cmb_start_unit.SelectedValue = "";
            txtFrequency.Text = "";
            cmb_frequency_unit.SelectedValue = "";
            cmb_status.SelectedValue = "";




        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    /// Edit mode for job template
    /// 
    /// </summary>
    /// <param name="job_template_id"></param>
    private void edit_job_template_task(Guid job_template_id, string job_template_name)
    {
        try
        {
            //lbl_job_template_name.Text = "<b>Template : </b>";
            //lbl_job_template_name.Text = lbl_job_template_name.Text + job_template_name;

            bind_task_grid(job_template_id);
            //tbl_job_template_grid.Visible = true;
            tbl_task_grid.Visible = true;
            tbl_job_template_grid.Visible = false;
            tbl_assign_unassign.Visible = false;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    /// bind existing templates to grid
    /// 
    /// </summary>
    protected void bindJobTemplates()
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            IList<AttributeTemplate.JobTemplateModel> templates;
            Guid org_id = new Guid(Request.QueryString["organization_id"]);
            templates = ac.GetJobTemplates(org_id, SessionController.ConnectionString);
            rg_Job_templates.DataSource = templates;
            rg_Job_templates.DataBind();

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    
    #region Job template grid Events

    /// grid command event
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rg_Job_templates_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "delete_template")
            {
                GridDataItem ditem = (GridDataItem)e.Item;
                Guid job_template_id = new Guid(ditem["Id"].Text);
                //Guid job_id = new Guid(ditem["JobId"].Text);
                using (var cli = new AttributeTemplateClient())
                {
                    cli.DeleteJobTemplate(job_template_id, SessionController.ConnectionString);
                }
                clear_values();
                bindJobTemplates();
            }
            if (e.CommandName == "edit_template_task")
            {
                GridDataItem ditem = (GridDataItem)e.Item;
                Guid job_template_id = new Guid(ditem["Id"].Text);
                string job_template_name = ditem["Name"].Text;
                string JobCategoryId = ditem["JobCategoryId"].Text;
                /*--saving values for task insert update-->*/
                hf_job_template_id.Value = job_template_id.ToString();
                hf_job_template_name.Value = job_template_name;
                hf_template_category.Value = JobCategoryId;
                /*--saving values for task insert update--*/

                tbl_jobs2.Visible = false;
                btn_add_job_template.Visible = false;
                tbl_job_template_grid.Visible = false;
                tbl_assign_unassign.Visible = false;
                //edit_template(job_template_id);
                edit_job_template_task(job_template_id, job_template_name);


            }
            if (e.CommandName == "edit_template")
            {
                GridDataItem ditem = (GridDataItem)e.Item;
                string job_template_id = ditem["Id"].Text;
                ///ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script1", "template_popup('" + job_template_id + "');", true);

                return;
            }
            //bindJobTemplates();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    /// grid PageIndexChanged
    /// 
    /// </summary>
    /// <param name="source"></param>
    /// <param name="e"></param>
    protected void rg_Job_templates_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                bindJobTemplates();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    /// Grid PageSizeChanged
    /// 
    /// </summary>
    /// <param name="source"></param>
    /// <param name="e"></param>
    protected void rg_Job_templates_PageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                bindJobTemplates();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }

    /// Grid sort event
    /// 
    /// </summary>
    /// <param name="source"></param>
    /// <param name="e"></param>
    protected void rg_Job_templates_SortCommand(object source, GridSortCommandEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                bindJobTemplates();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }

    #endregion

    /*--Add edit tasks-->*/

    protected void btn_close_Click(object sender, EventArgs e)
    {
        try
        {
            bindJobTemplates();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    /// Add new task click
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_add_new_task_Click(object sender, EventArgs e)
    {
        try
        {
            hf_task_id.Value = "";
            disable_job_template_fields();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    /// Disable cmb_Category and job template name so that save will only update task not JOb template 
    /// 
    /// </summary>
    protected void disable_job_template_fields()
    {
        try
        {
            tbl_jobs2.Visible = true;
            btn_add_job_template.Visible = false;
            tbl_job_template_grid.Visible = false;
            tbl_assign_unassign.Visible = false;
            tbl_task_grid.Visible = false;
            /*set the hidden field values */
            hf_from_task.Value = "Y";
            txtName.Text = hf_job_template_name.Value;
            //txtName.Enabled = false;
            if (hf_template_category.Value == "" || hf_template_category.Value == null)
                //cmb_Category.Enabled = false;
                cmb_Category.Enabled = true;
            else
                cmb_Category.SelectedValue = hf_template_category.Value;

            //cmb_Category.Enabled = false;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    /// Bind task grid
    /// 
    /// </summary>
    /// <param name="pk_job_template_id"></param>
    protected void bind_task_grid(Guid job_template_id)
    {
        try
        {
            IList<JobTemplateTaskModel> task;
            AttributeTemplateClient cli = new AttributeTemplateClient();
            task = cli.GetJobTemplateTasks(job_template_id, SessionController.ConnectionString);
            rg_tasks.DataSource = task;
            rg_tasks.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    #region Job task grid events


    /// grid command event
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rg_tasks_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "edit_task")
            {
                disable_job_template_fields();
                GridDataItem ditem = (GridDataItem)e.Item;

                hf_task_id.Value = ditem["Id"].Text;//hidden field for edit
                txtDuration.Text = ditem["Duration"].Text;
                txtFrequency.Text = ditem["Frequency"].Text;
                Txttasknumber.Text = ditem["TaskNumber"].Text;
                txt_Description.Text = ditem["Des"].Text;
                txtPriors.Text = ditem["Priors"].Text;
                radDatePicker.SelectedDate = Convert.ToDateTime(ditem["Start"].Text);

                if (ditem["DurationUnit"].Text != null && ditem["DurationUnit"].Text != "")
                {
                    if (new Guid(ditem["DurationUnit"].Text) != Guid.Empty)
                        cmb_duration_unit.SelectedValue = ditem["DurationUnit"].Text;
                }
                if (ditem["FrequencyUnit"].Text != null && ditem["FrequencyUnit"].Text != "")
                {
                    if (new Guid(ditem["FrequencyUnit"].Text) != Guid.Empty)
                        cmb_frequency_unit.SelectedValue = ditem["FrequencyUnit"].Text;
                }
                if (ditem["StartUnit"].Text != null && ditem["StartUnit"].Text != "")
                {
                    if (new Guid(ditem["StartUnit"].Text) != Guid.Empty)
                        cmb_start_unit.SelectedValue = ditem["StartUnit"].Text;
                }
                if (ditem["StatusId"].Text != null && ditem["StatusId"].Text != "")
                {
                    if (new Guid(ditem["StatusId"].Text) != Guid.Empty)
                        cmb_status.SelectedValue = ditem["StatusId"].Text;
                }

            }
            if (e.CommandName == "delete_task")
            {
                AttributeTemplateClient cli = new AttributeTemplateClient();
                GridDataItem ditem = (GridDataItem)e.Item;
                cli.DeleteJobTemplateTask(new Guid(ditem["Id"].Text), SessionController.ConnectionString);
                bind_task_grid(new Guid(hf_job_template_id.Value));
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    /// grid PageIndexChanged
    /// 
    /// </summary>
    /// <param name="source"></param>
    /// <param name="e"></param>
    protected void rg_tasks_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                bind_task_grid(new Guid(hf_job_template_id.Value));
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    /// Grid PageSizeChanged
    /// 
    /// </summary>
    /// <param name="source"></param>
    /// <param name="e"></param>
    protected void rg_tasks_PageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                bind_task_grid(new Guid(hf_job_template_id.Value));
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }

    /// Grid sort event
    /// 
    /// </summary>
    /// <param name="source"></param>
    /// <param name="e"></param>
    protected void rg_tasks_SortCommand(object source, GridSortCommandEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                bind_task_grid(new Guid(hf_job_template_id.Value));
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }

    #endregion

    /*--Add edit tasks--*/

    #region binding data for job template creation

    private void BindCategory()
    {
        try
        {
            DataSet ds = new DataSet();
            TypeProfileClient ctl = new TypeProfileClient();
            TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
            ds = ctl.proc_get_job_category(mdl, SessionController.ConnectionString);

            cmb_Category.DataTextField = "job_category_name";
            cmb_Category.DataValueField = "pk_job_category";
            cmb_Category.DataSource = ds;
            cmb_Category.DataBind();

        }
        catch (Exception ex)
        {

            throw ex;
        }


    }
    private void BindStatus()
    {
        try
        {
            DataSet ds1 = new DataSet();
            TypeProfileClient ctl1 = new TypeProfileClient();
            TypeProfile.TypeModel mdl1 = new TypeProfile.TypeModel();
            ds1 = ctl1.proc_get_job_status(mdl1, SessionController.ConnectionString);
            cmb_status.DataTextField = "status";
            cmb_status.DataValueField = "pk_job_status_id";
            cmb_status.DataSource = ds1;
            cmb_status.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }
    private void Bindunits()
    {
        try
        {
            DataSet ds2 = new DataSet();
            TypeProfileClient ctl2 = new TypeProfileClient();
            TypeProfile.TypeModel mdl2 = new TypeProfile.TypeModel();
            ds2 = ctl2.proc_get_job_duration_unit(mdl2, SessionController.ConnectionString);
            cmb_duration_unit.DataTextField = "name";
            cmb_duration_unit.DataValueField = "pk_duration_unit_id";
            cmb_duration_unit.DataSource = ds2;
            cmb_duration_unit.DataBind();

            cmb_start_unit.DataTextField = "name";
            cmb_start_unit.DataValueField = "pk_duration_unit_id";
            cmb_start_unit.DataSource = ds2;
            cmb_start_unit.DataBind();

            cmb_frequency_unit.DataTextField = "name";
            cmb_frequency_unit.DataValueField = "pk_duration_unit_id";
            cmb_frequency_unit.DataSource = ds2;
            cmb_frequency_unit.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    private void BindResources(Guid type_id)
    {
        try
        {
            DataSet ds = new DataSet();
            TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
            TypeProfileClient ctl = new TypeProfileClient();
            mdl.Type_Id = type_id;
            mdl.Txt_Search = "";
            mdl.Type_Id = type_id;
            ds = ctl.proc_get_types_resources(mdl, SessionController.ConnectionString);
            //cmb_resource.DataTextField = "Resource_name";
            //cmb_resource.DataValueField = "pk_resource_id";
            //cmb_resource.DataSource = ds;
            //cmb_resource.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    
    #endregion




}