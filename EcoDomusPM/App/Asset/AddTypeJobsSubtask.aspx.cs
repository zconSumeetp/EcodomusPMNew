using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using TypeProfile;
using System.Globalization;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Threading;
using EcoDomus.Session;

public partial class App_Asset_AddTypeJobsSubtask : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                this.Header.DataBind();
                if (!IsPostBack)
                {

                    hfjob_id.Value = Convert.ToString(Request.QueryString["pk_job_id"]);
                    hf_category_id.Value = Convert.ToString(Request.QueryString["category_id"]);
                    hftype_id.Value = Convert.ToString(Request.QueryString["type_id"]);
                    hfScreenResolution.Value = Convert.ToString(Request.QueryString["resolution"]);
                    BindStatus();
                    BindDurationUnit();
                    BindResource();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }
        }
        catch (Exception es)
        {
            throw es;
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
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveTask();
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script1", "CloseWindow_after_save('"+hftype_id.Value+"','"+hfScreenResolution.Value+"');", true);
       // Page.ClientScript.RegisterStartupScript(GetType(), "popClose", "CloseWindow();", false);
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "close();", false);
    }


    protected void BindStatus()
    {
        DataSet ds = new DataSet();
        TypeProfileClient ctl = new TypeProfileClient();
        TypeModel mdl = new TypeModel();
        ds = ctl.proc_get_job_status(mdl, SessionController.ConnectionString);
        cmb_status.DataTextField = "status";
        cmb_status.DataValueField = "pk_job_status_id";
        cmb_status.DataSource = ds;
        cmb_status.DataBind();
    }
    protected void BindDurationUnit()
    {
        DataSet ds = new DataSet();
        TypeProfileClient ctl = new TypeProfileClient();
        TypeModel mdl = new TypeModel();
        ds = ctl.proc_get_job_duration_unit(mdl, SessionController.ConnectionString);
        cmb_durationUnit.DataTextField = "name";
        cmb_durationUnit.DataValueField = "pk_duration_unit_id";
        cmb_durationUnit.DataSource = ds;
        cmb_durationUnit.DataBind();

        cmb_frequencyUnit.DataTextField = "name";
        cmb_frequencyUnit.DataValueField = "pk_duration_unit_id";
        cmb_frequencyUnit.DataSource = ds;
        cmb_frequencyUnit.DataBind();

        cmb_StartUnit.DataTextField = "name";
        cmb_StartUnit.DataValueField = "pk_duration_unit_id";
        cmb_StartUnit.DataSource = ds;
        cmb_StartUnit.DataBind();
    }

    protected void BindResource()
    {
        DataSet ds = new DataSet();
        TypeProfileClient ctl = new TypeProfileClient();
        TypeModel mdl = new TypeModel();
        mdl.Type_Id = new Guid(hftype_id.Value);
        mdl.Txt_Search = "";
        ds = ctl.proc_get_types_resources(mdl, SessionController.ConnectionString);
        cmb_resource.DataTextField = "Resource_name";
        cmb_resource.DataValueField = "pk_resource_id";
        cmb_resource.DataSource = ds;
        cmb_resource.DataBind();
    }

    protected void SaveTask()
    {

        try
        {
            DataSet ds = new DataSet();
            TypeModel mdl = new TypeModel();
            TypeProfileClient ctl = new TypeProfileClient();

            mdl.jobid = new Guid(hfjob_id.Value);
            mdl.jobTaskId = Guid.Empty;
            if (!(string.IsNullOrEmpty((Convert.ToString(hf_category_id.Value)))))
                mdl.jobCategory = hf_category_id.Value;
            else
                mdl.jobCategory = Convert.ToString(Guid.Empty);
            mdl.jobname = "";
            mdl.jobdesc = radTextDescription.Text;
            mdl.jobTaskNumber = Txttasknumber.Text;
            mdl.jobPriors = txtPriors.Text;

            if (!(string.IsNullOrEmpty(cmb_status.SelectedValue)))

                mdl.jobStatus = cmb_status.SelectedValue;
            else
                mdl.jobStatus = Convert.ToString(Guid.Empty);

            mdl.jobDuration = txtDuration.Text;

            if (!(string.IsNullOrEmpty(cmb_durationUnit.SelectedValue)))

                mdl.jobDurationUnit = new Guid(cmb_durationUnit.SelectedValue);
            else
                mdl.jobDurationUnit = Guid.Empty;

            mdl.jobStart = Convert.ToDateTime(radDatetimePicker.SelectedDate.ToString());

            if (!(string.IsNullOrEmpty(cmb_StartUnit.SelectedValue)))

                mdl.jobStartUnit = new Guid(cmb_StartUnit.SelectedValue);
            else
                mdl.jobStartUnit = Guid.Empty;

            mdl.jobFrequency = txtFrequency.Text;

            if (!(string.IsNullOrEmpty(cmb_frequencyUnit.SelectedValue)))

                mdl.jobFrequencyUnit = new Guid(cmb_frequencyUnit.SelectedValue);
            else
                mdl.jobFrequencyUnit = Guid.Empty;

            int itemschecked = cmb_resource.CheckedItems.Count;
            String[] resourceArray = new String[itemschecked];
            var collection = cmb_resource.CheckedItems;
            int i = 0;
            foreach (var item in collection)
            {
                String value = item.Value;
                resourceArray[i] = value;
                i++;
            }
            var resources = String.Join(",", resourceArray);
            mdl.jobResourceName = resources;
            //if (hf_resource_ids.Value != null)
            //    mdl.jobResourceName = hf_resource_ids.Value;
            //else
            //    mdl.jobResourceName = Convert.ToString(Guid.Empty);
            mdl.CreatedBy = new Guid(SessionController.Users_.UserId);
            mdl.fk_typeId = new Guid(hftype_id.Value);
            mdl.Flag = "Task";

            ds = ctl.proc_insert_update_job_details(mdl, SessionController.ConnectionString);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "myCloseScript", "window.close()", true);

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }


}