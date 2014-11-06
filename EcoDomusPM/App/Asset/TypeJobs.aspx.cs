using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using TypeProfile;
using EcoDomus.Session;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Threading;
using System.Globalization;



public partial class App_Asset_TypeJobs : System.Web.UI.Page
{


    #region page events

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                hfScreenResolution.Value = Convert.ToString((Convert.ToString(Request.QueryString["resolution"])));
                //rg_TypeJobs.Width = Convert.ToInt32(Request.QueryString["resolution"]) - 50;
                //  RadPanelBar1.Style["Width"] = Convert.ToString(rg_TypeJobs.Width);

                //tbl_jobs.Style["Width"] = Convert.ToString(rg_TypeJobs.Width);
                //tbl_jobs1.Style["Width"] = Convert.ToString(rg_TypeJobs.Width);

                if (!(IsPostBack))
                {
                    if ((Convert.ToString(Request.QueryString["Type_id"]) != null))
                    {

                        hf_type_id.Value = Convert.ToString((Convert.ToString(Request.QueryString["Type_id"])));

                        GridSortExpression sortExpr = new GridSortExpression();
                        sortExpr.FieldName = "Name";
                        sortExpr.SortOrder = GridSortOrder.Ascending;
                        //  Add sort expression, which will sort against first column
                        rg_TypeJobs.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                        Bindjobs(new Guid(hf_type_id.Value));
                        BindCategory();
                        BindStatus();
                        Bindunits();
                        BindResources(new Guid(hf_type_id.Value));

                    }
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>LogoutNavigation();</script>", false);
                // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script1", "", true);
                //    Response.Redirect("~/APP/LoginPM.aspx?Error=Session");
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
    #endregion


    #region event handlers
    //protected void btnAssign_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        bind_Resources();

    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;

    //    }
    //}

    protected void rg_TypeJobs_NeedDataSource(object source, GridNeedDataSourceEventArgs e)
    {
        if (!e.IsFromDetailTable)
        {

        }
    }

    public void rg_TypeJobs_OnDetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        try
        {
            GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

            if (e.DetailTableView.Name.Equals("rg_JobTasks"))
            {
                hf_job_id.Value = Convert.ToString(dataItem.GetDataKeyValue("pk_job_id"));
                e.DetailTableView.DataSource = get_data(Convert.ToString(dataItem.GetDataKeyValue("pk_job_id")));

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public void rg_TypeJobs_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {

    }
    protected void rg_TypeJobs_OnSortCommand(object source, GridSortCommandEventArgs e)
    {

    }
    protected void rg_TypeJobs_OnPageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        try
        {


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void rg_TypeJobs_OnItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        DataSet dsname;
        string duplicate_name;
        Guid job_id = Guid.Empty;
        Guid task_id = Guid.Empty;

        if (e.CommandName == "Sort" && e.Item.OwnerTableView.Name == "rgJob")
        {
            Bindjobs(new Guid(hf_type_id.Value));
        }

        if (e.CommandName == "ExpandCollpse")
        {
            Bindjobs(new Guid(hf_type_id.Value));
        }

        else if (e.CommandName == "Edit" && e.Item.OwnerTableView.Name == "rgJob")
        {
            Bindjobs(new Guid(hf_type_id.Value));
        }

        else if (e.CommandName == "deleteJob" && e.Item.OwnerTableView.Name == "rgJob")
        {

            job_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_id"].ToString());
            TypeModel mdl = new TypeModel();
            TypeProfileClient ctl = new TypeProfileClient();
            mdl.jobid = job_id;
            ctl.DeleteJob(mdl, SessionController.ConnectionString);
            Bindjobs(new Guid(hf_type_id.Value));
        }
        else if (e.CommandName == "Update" && e.Item.OwnerTableView.Name == "rgJob")
        {
            DataSet ds = new DataSet();
            TypeModel mdl = new TypeModel();
            TypeProfileClient ctl = new TypeProfileClient();

            GridEditableItem editedItem = e.Item as GridEditableItem;
            GridEditManager editMan = editedItem.EditManager;

            RadComboBox cmbCateroryEdit = e.Item.FindControl("cmb_categoryEdit") as RadComboBox;
            if (cmbCateroryEdit != null)
            {
                foreach (GridColumn column in e.Item.OwnerTableView.RenderColumns)
                {

                    if (column is IGridEditableColumn)
                    {
                        IGridEditableColumn editableCol = (column as IGridEditableColumn);
                        if (editableCol.IsEditable && editableCol.ColumnEditor != null)
                        {
                            IGridColumnEditor editor = editMan.GetColumnEditor(editableCol);

                            string editorText;

                            if (editor is GridTextColumnEditor)
                            {

                                if (editableCol.Column.UniqueName == "Name")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                    mdl.jobname = editorText.ToString();
                                }

                            }

                            else if (editor is GridTemplateColumnEditor)
                            {

                                if (editableCol.Column.SortExpression == "Category")
                                {
                                    if ((editor.ContainerControl.FindControl("cmb_categoryEdit") as RadComboBox).SelectedItem != null)
                                    {


                                        mdl.jobCategory = Convert.ToString((editor.ContainerControl.FindControl("cmb_categoryEdit") as RadComboBox).SelectedItem.Value.ToString());

                                    }
                                }
                            }
                        }
                    }

                }

                mdl.jobid = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_id"].ToString());
                mdl.User_id = new Guid(SessionController.Users_.UserId);
                dsname = ctl.proc_insert_update_job(mdl, SessionController.ConnectionString);

                duplicate_name = Convert.ToString(dsname.Tables[0].Rows[0]["duplicate_flag"]);
                if (duplicate_name == "Y")
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate1();", true);
                }


            }

        }

        else if (e.CommandName == "deleteTask" && e.Item.OwnerTableView.Name == "rg_JobTasks")
        {
            task_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_task_id"].ToString());
            TypeModel mdl = new TypeModel();
            TypeProfileClient ctl = new TypeProfileClient();
            mdl.jobTaskId = task_id;
            ctl.DeleteTask(mdl, SessionController.ConnectionString);
            GridDataItem item = (GridDataItem)e.Item;
            GridTableView detailtable;
            Bindjobs(new Guid(hf_type_id.Value));

        }

        else if (e.CommandName == "Update" && e.Item.OwnerTableView.Name == "rg_JobTasks")
        {

            DataSet ds = new DataSet();
            TypeModel mdl = new TypeModel();
            TypeProfileClient ctl = new TypeProfileClient();

            GridEditableItem editedItem = e.Item as GridEditableItem;
            GridEditManager editMan = editedItem.EditManager;

            RadComboBox cmb_statusEdit = e.Item.FindControl("cmb_statusEdit") as RadComboBox;
            RadComboBox cmb_durationUnitEidt = e.Item.FindControl("cmb_durationUnitEidt") as RadComboBox;
            RadComboBox cmb_startUnitEidt = e.Item.FindControl("cmb_startUnitEidt") as RadComboBox;
            RadComboBox cmb_Frequency_unitEdit = e.Item.FindControl("cmb_Frequency_unitEdit") as RadComboBox;
            RadComboBox cmb_resourceEdit = e.Item.FindControl("cmb_resourceEdit") as RadComboBox;
            RadDatePicker radDateStartDate = e.Item.FindControl("radDateStartDate") as RadDatePicker;

            if (cmb_statusEdit != null)
            {
                foreach (GridColumn column in e.Item.OwnerTableView.RenderColumns)
                {

                    if (column is IGridEditableColumn)
                    {
                        IGridEditableColumn editableCol = (column as IGridEditableColumn);

                        if (editableCol.IsEditable && editableCol.ColumnEditor != null)
                        {
                            IGridColumnEditor editor = editMan.GetColumnEditor(editableCol);

                            string editorText;

                            if (editor is GridTextColumnEditor)
                            {

                                if (editableCol.Column.UniqueName == "Description")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                    mdl.jobdesc = editorText.ToString();
                                }

                                if (editableCol.Column.UniqueName == "Start")
                                {
                                    editorText = (editor as GridTextColumnEditor).Text;
                                    mdl.jobStart = Convert.ToDateTime(editorText.ToString());


                                }

                            }

                            else if (editor is GridTemplateColumnEditor)
                            {
                                if (editableCol.Column.SortExpression == "task_number")
                                {
                                    if ((editor.ContainerControl.FindControl("txttask_numberEdit") as RadTextBox).Text != null)
                                    {
                                        mdl.jobTaskNumber = Convert.ToString(Convert.ToString((editor.ContainerControl.FindControl("txttask_numberEdit") as RadTextBox).Text));

                                    }
                                    else
                                        mdl.jobTaskNumber = "";
                                }
                                if (editableCol.Column.SortExpression == "priors")
                                {
                                    if ((editor.ContainerControl.FindControl("txtpriorsEdit") as RadTextBox).Text != null)
                                    {
                                        mdl.jobPriors = Convert.ToString(Convert.ToString((editor.ContainerControl.FindControl("txtpriorsEdit") as RadTextBox).Text));

                                    }
                                    else
                                        mdl.jobPriors = "";
                                }
                                if (editableCol.Column.SortExpression == "Duration")
                                {
                                    if ((editor.ContainerControl.FindControl("txtDurationEdit") as RadTextBox).Text != null)
                                    {
                                        mdl.jobDuration = Convert.ToString(Convert.ToString((editor.ContainerControl.FindControl("txtDurationEdit") as RadTextBox).Text));

                                    }
                                    else
                                        mdl.jobDuration = "";
                                }
                                if (editableCol.Column.SortExpression == "Frequency")
                                {
                                    if ((editor.ContainerControl.FindControl("txtFrequencyEdit") as RadTextBox).Text != null)
                                    {
                                        mdl.jobFrequency = Convert.ToString(Convert.ToString((editor.ContainerControl.FindControl("txtFrequencyEdit") as RadTextBox).Text));

                                    }
                                    else
                                        mdl.jobFrequency = "";
                                }


                                if (editableCol.Column.SortExpression == "Status")
                                {
                                    if ((editor.ContainerControl.FindControl("cmb_statusEdit") as RadComboBox).SelectedItem != null)
                                    {
                                        mdl.jobStatus = Convert.ToString((editor.ContainerControl.FindControl("cmb_statusEdit") as RadComboBox).SelectedItem.Value.ToString());

                                    }
                                    else
                                    {
                                        mdl.jobStatus = Convert.ToString(Guid.Empty);
                                    }
                                }
                                if (editableCol.Column.SortExpression == "Duration_unit")
                                {
                                    if ((editor.ContainerControl.FindControl("cmb_durationUnitEidt") as RadComboBox).SelectedItem != null)
                                    {
                                        mdl.jobDurationUnit = new Guid((editor.ContainerControl.FindControl("cmb_durationUnitEidt") as RadComboBox).SelectedItem.Value);

                                    }
                                }
                                if (editableCol.Column.SortExpression == "Start_unit")
                                {
                                    if ((editor.ContainerControl.FindControl("cmb_startUnitEidt") as RadComboBox).SelectedItem != null)
                                    {
                                        mdl.jobStartUnit = new Guid((editor.ContainerControl.FindControl("cmb_startUnitEidt") as RadComboBox).SelectedItem.Value.ToString());

                                    }
                                }
                                if (editableCol.Column.SortExpression == "Frequency_unit")
                                {
                                    if ((editor.ContainerControl.FindControl("cmb_Frequency_unitEdit") as RadComboBox).SelectedItem != null)
                                    {
                                        mdl.jobFrequencyUnit = new Guid((editor.ContainerControl.FindControl("cmb_Frequency_unitEdit") as RadComboBox).SelectedItem.Value.ToString());

                                    }
                                }
                                if (editableCol.Column.SortExpression == "ResourceNames")
                                {

                                    System.Text.StringBuilder resourcenames = new System.Text.StringBuilder();
                                    System.Text.StringBuilder resourceids = new System.Text.StringBuilder();
                                    foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmb_resourceEdit.Items)
                                    {
                                        if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
                                        {
                                            resourceids.Append(rcbItem.Value);
                                            resourceids.Append(",");
                                            resourcenames.Append(rcbItem.Text);
                                            resourcenames.Append(",");

                                        }

                                    }

                                    mdl.jobResourceName = Convert.ToString(resourceids);

                                }
                                if (editableCol.Column.SortExpression == "Start")
                                {
                                    if ((editor.ContainerControl.FindControl("radDateStartDate") as RadDatePicker).SelectedDate != null)
                                    {
                                        mdl.jobStart = Convert.ToDateTime((editor.ContainerControl.FindControl("radDateStartDate") as RadDatePicker).SelectedDate.ToString());


                                    }
                                }

                            }
                        }
                    }

                }
                mdl.jobname = "";
                mdl.jobCategory = Convert.ToString(Guid.Empty);
                mdl.jobid = Guid.Empty;// new Guid(Convert.ToString(editedItem.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_id"]));
                mdl.Flag = "Task";
                mdl.jobTaskId = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_task_id"].ToString());
                mdl.CreatedBy = new Guid(SessionController.Users_.UserId.ToString());
                ds = ctl.proc_insert_update_job_details(mdl, SessionController.ConnectionString);

            }
        }
        else if (e.CommandName == "")
        {
            string attribute_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_id"].ToString();
            TypeModel mdl = new TypeModel();
            TypeProfileClient ctl = new TypeProfileClient();
        }
        if (e.CommandName == "Update" && e.Item.OwnerTableView.Name == "rgJob")
        {
            DataSet ds = new DataSet();
            TypeModel mdl = new TypeModel();
            TypeProfileClient ctl = new TypeProfileClient();
            mdl.Type_Id = new Guid(hf_type_id.Value);
            mdl.Txt_Search = txtSearch.Text;
            ds = ctl.proc_get_types_job(mdl, SessionController.ConnectionString);
            rg_TypeJobs.DataSource = ds;
            rg_TypeJobs.DataBind();
        }
        if (e.CommandName == "Cancel" && e.Item.OwnerTableView.Name == "rgJob")
        {
            Bindjobs(new Guid(hf_type_id.Value));
        }

        if (e.CommandName == "ChangePageSize" && e.Item != null && e.Item.OwnerTableView.Name != "rg_JobTasks")
        {
            Bindjobs(new Guid(hf_type_id.Value));
        }
        else if (e.CommandName == "ChangePageSize")
        {
            Bindjobs(new Guid(hf_type_id.Value));
        }
        if (e.CommandName == "Page" && e.Item != null && e.Item.OwnerTableView.Name != "rg_JobTasks")
        {
            Bindjobs(new Guid(hf_type_id.Value));
        }

    }
    protected void rg_TypeJobs_OnItemDataBound(object source, GridItemEventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "GU")
        {
            if (e.Item.OwnerTableView.Name == "rg_JobTasks")
            {
                if ((e.Item is GridDataItem))
                {
                    GridDataItem item = e.Item as GridDataItem;
                    (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;
                    ImageButton btn = e.Item.FindControl("imgbtnDelete") as ImageButton;
                    if (btn != null)
                    {
                        btn.Visible = false;
                    }
                }
            }


        }
        else
        {
            if (e.Item.OwnerTableView.Name == "rg_JobTasks")
            {
                if (e.Item is GridDataItem)
                {
                    GridDataItem item = (GridDataItem)e.Item;
                    item["Description"].ToolTip = item["Description"].Text.Replace("&nbsp;", "");
                    item["ResourceNames"].ToolTip = item["ResourceNames"].Text.Replace("&nbsp;", "");
                    if (item["Description"].Text.Length > 50)
                        item["Description"].Text = item["Description"].Text.Substring(0, 50) + "...";
                    Label lblResourceEdit = (Label)e.Item.FindControl("lblResourceEdit");
                    if (lblResourceEdit != null)
                    {
                        item["ResourceNames"].ToolTip = lblResourceEdit.Text.Replace("&nbsp;", "");
                        if (lblResourceEdit.Text.Length > 25)
                            item["ResourceNames"].Text = lblResourceEdit.Text.Substring(0, 25) + "...";
                    }
                }



            }
            if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "rg_JobTasks")
            {


                GridDataItem item = (GridDataItem)e.Item;

                Label lbltask_numberEdit = (Label)item.FindControl("lbltask_numberEdit");
                Label lblpriorsEdit = (Label)item.FindControl("lblpriorsEdit");
                Label lblDurationEdit = (Label)item.FindControl("lblDurationEdit");
                Label lblFrequencyEdit = (Label)item.FindControl("lblFrequencyEdit");

                hf_task_number.Value = lbltask_numberEdit.Text;
                hf_priors.Value = lbltask_numberEdit.Text;
                hf_duration.Value = lbltask_numberEdit.Text;
                hf_frequency.Value = lbltask_numberEdit.Text;

            }

            if (e.Item is GridEditFormItem && e.Item.IsInEditMode && e.Item.OwnerTableView.Name == "rg_JobTasks")
            {

                GridEditFormItem editItem = (GridEditFormItem)e.Item;
                TypeProfileClient client = new TypeProfileClient();
                TypeModel model = new TypeModel();
                Guid task_id;
                Guid jobDurationUnit;
                string jobStatus = "";
                DateTime jobStart = DateTime.Now;
                Guid jobStartUnit;
                Guid jobFrequencyUnit;
                DataSet ds = new DataSet();
                DataSet ds_resource_info = new DataSet();


                task_id = new Guid(Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_task_id"]));
                RadComboBox cmb_resourceEdit = (RadComboBox)editItem.FindControl("cmb_resourceEdit");
                hf_type_id.Value = Convert.ToString(Request.QueryString["Type_id"]);
                BindResourcesEdit(cmb_resourceEdit, task_id, new Guid(hf_type_id.Value));


                RadTextBox txttask_numberEdit = (RadTextBox)editItem.FindControl("txttask_numberEdit");
                RadTextBox txtpriorsEdit = (RadTextBox)editItem.FindControl("txtpriorsEdit");
                RadTextBox txtDurationEdit = (RadTextBox)editItem.FindControl("txtDurationEdit");
                RadTextBox txtFrequencyEdit = (RadTextBox)editItem.FindControl("txtFrequencyEdit");

                if (hf_task_number.Value != null)
                {

                    txttask_numberEdit.Text = hf_task_number.Value;


                }
                if (hf_priors.Value != null)
                {
                    txtpriorsEdit.Text = hf_priors.Value;

                }
                if (hf_duration.Value != null)
                {
                    txtDurationEdit.Text = hf_duration.Value;

                }
                if (hf_frequency.Value != null)
                {
                    txtFrequencyEdit.Text = hf_frequency.Value;

                }
                /////////////////////////

                if (Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_status_id"]) != "")
                {
                    jobStatus = Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_status_id"]);

                    RadComboBox cmb_statusEdit = (RadComboBox)editItem.FindControl("cmb_statusEdit");
                    BindStatusEdit(cmb_statusEdit, jobStatus);

                }
                else if (Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_status_id"]) == "")
                {
                    jobStatus = Convert.ToString(Guid.Empty);
                    RadComboBox cmb_statusEdit = (RadComboBox)editItem.FindControl("cmb_statusEdit");
                    BindStatusEdit(cmb_statusEdit, jobStatus);
                }
                if (Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_duration_unit_id"]) != "")
                {
                    jobDurationUnit = new Guid(Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_duration_unit_id"]));
                    RadComboBox cmb_durationUnitEidt = (RadComboBox)editItem.FindControl("cmb_durationUnitEidt");
                    BindDurationEdit(cmb_durationUnitEidt, jobDurationUnit);
                }
                else if (Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_duration_unit_id"]) == "")
                {
                    jobDurationUnit = Guid.Empty;
                    RadComboBox cmb_durationUnitEidt = (RadComboBox)editItem.FindControl("cmb_durationUnitEidt");
                    BindDurationEdit(cmb_durationUnitEidt, jobDurationUnit);
                }
                if (Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Start_unit_id"]) != "")
                {
                    jobStartUnit = new Guid(Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Start_unit_id"]));
                    RadComboBox cmb_startUnitEidt = (RadComboBox)editItem.FindControl("cmb_startUnitEidt");
                    BindDurationEdit(cmb_startUnitEidt, jobStartUnit);
                }
                else if (Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Start_unit_id"]) == "")
                {
                    jobStartUnit = Guid.Empty;
                    RadComboBox cmb_startUnitEidt = (RadComboBox)editItem.FindControl("cmb_startUnitEidt");
                    BindDurationEdit(cmb_startUnitEidt, jobStartUnit);
                }
                if (Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Frequency_unit_id"]) != "")
                {
                    jobFrequencyUnit = new Guid(Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Frequency_unit_id"]));
                    RadComboBox cmb_Frequency_unitEdit = (RadComboBox)editItem.FindControl("cmb_Frequency_unitEdit");
                    BindDurationEdit(cmb_Frequency_unitEdit, jobFrequencyUnit);
                }
                else if (Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Frequency_unit_id"]) == "")
                {
                    jobFrequencyUnit = Guid.Empty;
                    RadComboBox cmb_Frequency_unitEdit = (RadComboBox)editItem.FindControl("cmb_Frequency_unitEdit");
                    BindDurationEdit(cmb_Frequency_unitEdit, jobFrequencyUnit);
                }
                if (Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["start"]) != "")
                {
                    jobStart = (Convert.ToDateTime(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["start"]));
                    RadDatePicker radDateStartDate = (RadDatePicker)editItem.FindControl("radDateStartDate");
                    BindStartDateEdit(radDateStartDate, jobStart);

                }
                else if (Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["start"]) == "")
                {
                    jobStart = DateTime.Now;
                    RadDatePicker radDateStartDate = (RadDatePicker)editItem.FindControl("radDateStartDate");
                    BindStartDateEdit(radDateStartDate, jobStart);
                }

            }

            ImageButton editLink = (ImageButton)e.Item.FindControl("imgbtnAddSubtask");
            if (e.Item is GridDataItem && editLink != null)
            {
                editLink = (ImageButton)e.Item.FindControl("imgbtnAddSubtask");

                editLink.Attributes["onclick"] = String.Format("return ShowDetailWindow('{0}','{1}','{2}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_id"], e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_category"], e.Item.ItemIndex);
            }
            if (e.Item is GridEditFormItem && e.Item.IsInEditMode && e.Item.OwnerTableView.Name == "rgJob")
            {
                RadComboBox cmb_categoryEdit = e.Item.FindControl("cmb_categoryEdit") as RadComboBox;

                TypeProfileClient client = new TypeProfileClient();
                TypeModel model = new TypeModel();
                string jobCategory = "";
                DataSet ds = new DataSet();
                DataSet ds_resource_info = new DataSet();

                RadComboBox cmbCateroryEdit = e.Item.FindControl("cmb_categoryEdit") as RadComboBox;
                Label lblCateoryEdit = e.Item.FindControl("lblCategoryEdit") as Label;

                if (cmbCateroryEdit != null)
                {
                    jobCategory = Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_job_category"]);
                    BindCategoryEdit(cmbCateroryEdit, jobCategory);
                }


            }

        }
    }
    protected void rg_TypeJobs_ItemCreated(object sender, GridItemEventArgs e)
    {
        //if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        //{
        //    GridEditableItem item = e.Item as GridEditableItem;
        //    GridTextBoxColumnEditor editor = (GridTextBoxColumnEditor)item.EditManager.GetColumnEditor("ContactName");
        //    TableCell cell = (TableCell)editor.TextBoxControl.Parent;

        //    RequiredFieldValidator validator = new RequiredFieldValidator();
        //    editor.TextBoxControl.ID = "ID_for_validation";
        //    validator.ControlToValidate = editor.TextBoxControl.ID;
        //    validator.ErrorMessage = "*";
        //    cell.Controls.Add(validator);
        //}



    }
    protected void rg_TypeJobs_OnPreRender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "GU")
        {
            btnAddJob.Visible = false;
            foreach (GridDataItem item in rg_TypeJobs.MasterTableView.Items)
            {
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;
                ImageButton imgbtnAddSubtask = (ImageButton)item.FindControl("imgbtnAddSubtask");
                ImageButton img_btn = (ImageButton)item.FindControl("imgbtnDelete");
                if (imgbtnAddSubtask != null)
                {
                    imgbtnAddSubtask.Enabled = false;
                }
                if (img_btn != null)
                {
                    img_btn.Visible = false;
                }

            }
        }
    }
    protected void combo_ItemsRequested(object o, RadComboBoxItemsRequestedEventArgs e)
    {



    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveJob();

    }
    protected void btn_searchimg_Click(object sender, ImageClickEventArgs e)
    {

        Bindjobs(new Guid(hf_type_id.Value));
    }
    #endregion

    #region user defined
    //protected void bind_Resources()
    //{


    //    if (hf_man_org_id.Value.ToString() != "")
    //    {
    //        mdl.Organization_Id = new Guid(hf_man_org_id.Value.ToString());
    //    }
    //    else
    //    {
    //        mdl.Organization_Id = new Guid("00000000-0000-0000-0000-000000000000");
    //    }
    //    DataSet ds = TypeClient.Getguarantor(mdl, SessionController.ConnectionString); ;

    //    cmbWarrantyGurantorPart.DataTextField = "name";
    //    cmbWarrantyGurantorPart.DataValueField = "ID";
    //    cmbWarrantyGurantorPart.DataSource = ds;
    //    cmbWarrantyGurantorPart.DataBind();

    //    cmbWarrantyGuarantorLabor.DataTextField = "name";
    //    cmbWarrantyGuarantorLabor.DataValueField = "ID";
    //    cmbWarrantyGuarantorLabor.DataSource = ds;
    //    cmbWarrantyGuarantorLabor.DataBind();


    //}
    private void BindStartDateEdit(RadDatePicker radDateStartDate, DateTime jobStart)
    {
        DataSet ds = new DataSet();
        TypeProfileClient ctl = new TypeProfileClient();
        TypeModel mdl = new TypeModel();
        if (jobStart.ToString() != "")
        {
            radDateStartDate.SelectedDate = jobStart;

        }

    }
    private void BindDurationEdit(RadComboBox cmb_durationUnitEidt, Guid jobDurationUnit)
    {
        DataSet ds = new DataSet();
        TypeProfileClient ctl = new TypeProfileClient();
        TypeModel mdl = new TypeModel();
        ds = ctl.proc_get_job_duration_unit(mdl, SessionController.ConnectionString);

        cmb_durationUnitEidt.DataTextField = "name";
        cmb_durationUnitEidt.DataValueField = "pk_duration_unit_id";
        cmb_durationUnitEidt.DataSource = ds;
        cmb_durationUnitEidt.DataBind();

        if (ds.Tables[0].Rows.Count > 0)
        {
            if (jobDurationUnit != Guid.Empty)
            {
                cmb_durationUnitEidt.FindItemByValue(Convert.ToString(jobDurationUnit)).Selected = true;
            }
            else
            {
                // cmb_durationUnitEidt.ClearSelection();
            }
        }



    }
    private void BindstartUnitEidt(RadComboBox cmb_startUnitEidt, Guid jobStartUnit)
    {
        DataSet ds = new DataSet();
        TypeProfileClient ctl = new TypeProfileClient();
        TypeModel mdl = new TypeModel();
        ds = ctl.proc_get_job_duration_unit(mdl, SessionController.ConnectionString);


        cmb_startUnitEidt.DataTextField = "name";
        cmb_startUnitEidt.DataValueField = "pk_duration_unit_id";
        cmb_startUnitEidt.DataSource = ds;
        cmb_startUnitEidt.DataBind();

        if (ds.Tables[0].Rows.Count > 0)
        {
            if (jobStartUnit != Guid.Empty)
            {
                cmb_startUnitEidt.FindItemByValue(Convert.ToString(jobStartUnit)).Selected = true;
            }
            else
            {
                // cmb_startUnitEidt.ClearSelection();
            }
        }




    }
    private void BindFrequency_unitEdit(RadComboBox cmb_Frequency_unitEdit, Guid jobFrequencyUnit)
    {
        DataSet ds = new DataSet();
        TypeProfileClient ctl = new TypeProfileClient();
        TypeModel mdl = new TypeModel();
        ds = ctl.proc_get_job_duration_unit(mdl, SessionController.ConnectionString);


        cmb_Frequency_unitEdit.DataTextField = "name";
        cmb_Frequency_unitEdit.DataValueField = "pk_duration_unit_id";
        cmb_Frequency_unitEdit.DataSource = ds;
        cmb_Frequency_unitEdit.DataBind();

        if (ds.Tables[0].Rows.Count > 0)
        {
            if (jobFrequencyUnit != Guid.Empty)
            {
                cmb_Frequency_unitEdit.FindItemByValue(Convert.ToString(jobFrequencyUnit)).Selected = true;
            }
            else
            {
                // cmb_Frequency_unitEdit.ClearSelection();
            }
        }


    }
    private void BindStatusEdit(RadComboBox cmb_statusEdit, string jobStatus)
    {
        DataSet ds = new DataSet();
        TypeProfileClient ctl = new TypeProfileClient();
        TypeModel mdl = new TypeModel();
        ds = ctl.proc_get_job_status(mdl, SessionController.ConnectionString);

        cmb_statusEdit.DataTextField = "status";
        cmb_statusEdit.DataValueField = "pk_job_status_id";
        cmb_statusEdit.DataSource = ds;
        cmb_statusEdit.DataBind();



        if (ds.Tables[0].Rows.Count > 0)
        {
            if (!(string.IsNullOrEmpty((Convert.ToString(jobStatus)))) && (Convert.ToString(jobStatus)) != Convert.ToString(Guid.Empty))
            {
                cmb_statusEdit.FindItemByValue(Convert.ToString(jobStatus)).Selected = true;
            }
            else
            {
                // cmb_statusEdit.ClearSelection();
            }
        }

    }
    private void BindCategoryEdit(RadComboBox cmbCateroryEdit, string jobCategory)
    {
        DataSet ds = new DataSet();
        TypeProfileClient ctl = new TypeProfileClient();
        TypeModel mdl = new TypeModel();
        ds = ctl.proc_get_job_category(mdl, SessionController.ConnectionString);
        cmbCateroryEdit.DataTextField = "job_category_name";

        cmbCateroryEdit.DataValueField = "pk_job_category";
        cmbCateroryEdit.DataSource = ds;
        cmbCateroryEdit.DataBind();



        if (ds.Tables[0].Rows.Count > 0)
        {
            if (!(string.IsNullOrEmpty((Convert.ToString(jobCategory)))) && (Convert.ToString(jobCategory)) != Convert.ToString(Guid.Empty))
            {
                cmbCateroryEdit.FindItemByValue(Convert.ToString(jobCategory)).Selected = true;
            }
            else
            {
                //  cmbCateroryEdit.ClearSelection();
            }
        }

    }
    private void BindResourcesEdit(RadComboBox cmb_resourceEdit, Guid task_id, Guid type_id)
    {
        DataSet ds = new DataSet();
        TypeModel mdl = new TypeModel();
        TypeProfileClient ctl = new TypeProfileClient();
        mdl.Type_Id = type_id;
        mdl.Txt_Search = "";
        mdl.Type_Id = new Guid(hf_type_id.Value);
        mdl.jobTaskId = task_id;
        ds = ctl.proc_get_types_resources(mdl, SessionController.ConnectionString);
        cmb_resourceEdit.DataTextField = "Resource_name";
        cmb_resourceEdit.DataValueField = "pk_resource_id";
        cmb_resourceEdit.DataSource = ds;
        cmb_resourceEdit.DataBind();

        string resources = "";
        string resource_naems = "";
        DataSet ds_resources = ctl.proc_get_resources(mdl, SessionController.ConnectionString);

        if (ds_resources.Tables.Count > 0 && ds_resources.Tables[0].Rows.Count > 0)
        {
            resources = Convert.ToString(ds_resources.Tables[0].Rows[0]["resources"]);
        }

        for (int k = 0; k < cmb_resourceEdit.Items.Count; k++)
        {
            Telerik.Web.UI.RadComboBoxItem rcbItem = (Telerik.Web.UI.RadComboBoxItem)cmb_resourceEdit.Items[k];
            if (resources.Contains(rcbItem.Value.ToUpper()))
            {
                //  cmb_resourceEdit.SelectedValue = Convert.ToString(rcbItem.Value);
                CheckBox checkbox = (CheckBox)cmb_resourceEdit.Items[k].FindControl("CheckBox1");
                checkbox.Checked = true;
                if (k == 0)
                    resource_naems = rcbItem.Text;
                else if (k < (cmb_resourceEdit.Items.Count))
                {

                    resource_naems = resource_naems + "," + rcbItem.Text;
                }

            }
        }
        cmb_resourceEdit.Visible = true;
        cmb_resourceEdit.Visible = true;
        cmb_resourceEdit.Enabled = true;
        if (resource_naems.Length > 1)
            cmb_resourceEdit.Text = resource_naems.Remove(0, 1);

    }
    private void BindCategory()
    {
        DataSet ds = new DataSet();
        TypeProfileClient ctl = new TypeProfileClient();
        TypeModel mdl = new TypeModel();
        ds = ctl.proc_get_job_category(mdl, SessionController.ConnectionString);

        cmb_Category.DataTextField = "job_category_name";
        cmb_Category.DataValueField = "pk_job_category";
        cmb_Category.DataSource = ds;
        cmb_Category.DataBind();

    }
    private void BindStatus()
    {
        DataSet ds1 = new DataSet();
        TypeProfileClient ctl1 = new TypeProfileClient();
        TypeModel mdl1 = new TypeModel();
        ds1 = ctl1.proc_get_job_status(mdl1, SessionController.ConnectionString);
        cmb_status.DataTextField = "status";
        cmb_status.DataValueField = "pk_job_status_id";
        cmb_status.DataSource = ds1;
        cmb_status.DataBind();

    }
    private void Bindunits()
    {
        DataSet ds2 = new DataSet();
        TypeProfileClient ctl2 = new TypeProfileClient();
        TypeModel mdl2 = new TypeModel();
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
    private void BindResources(Guid type_id)
    {
        DataSet ds = new DataSet();
        TypeModel mdl = new TypeModel();
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
    private void Bindjobs(Guid type_id)
    {
        if (SessionController.Users_.UserId != null)
        {

            DataSet ds = new DataSet();
            TypeModel mdl = new TypeModel();
            TypeProfileClient ctl = new TypeProfileClient();
            mdl.Type_Id = type_id;
            mdl.Txt_Search = txtSearch.Text;
            ds = ctl.proc_get_types_job(mdl, SessionController.ConnectionString);

            rg_TypeJobs.DataSource = ds;
            rg_TypeJobs.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    private void SaveJob()
    {
        try
        {
            DataSet ds = new DataSet();
            TypeModel mdl = new TypeModel();
            TypeProfileClient ctl = new TypeProfileClient();
            mdl.jobid = Guid.Empty;

            mdl.jobTaskId = Guid.Empty;
            mdl.jobname = txtName.Text;
            mdl.Pk_resource_id = Guid.Empty;
            if (!(string.IsNullOrEmpty(cmb_Category.SelectedValue)))
                mdl.jobCategory = cmb_Category.SelectedValue;
            else
                mdl.jobCategory = Convert.ToString(Guid.Empty);
            mdl.jobdesc = txt_Description.Text;
            mdl.jobTaskNumber = Txttasknumber.Text;
            mdl.jobPriors = txtPriors.Text;
            if (!(string.IsNullOrEmpty(cmb_status.SelectedValue)))
                mdl.jobStatus = cmb_status.SelectedValue;
            else
                mdl.jobStatus = Convert.ToString(Guid.Empty);
            mdl.jobDuration = txtDuration.Text;
            if (!(string.IsNullOrEmpty(cmb_duration_unit.SelectedValue)))
                mdl.jobDurationUnit = new Guid(cmb_duration_unit.SelectedValue);
            else
                mdl.jobDurationUnit = Guid.Empty;
            if (!(radDatePicker.IsEmpty))
                mdl.jobStart = Convert.ToDateTime(Convert.ToDateTime(radDatePicker.SelectedDate));
            //else
            //    mdl.jobStart =  "1/1/1753 12:00:00";
            if (!(string.IsNullOrEmpty(cmb_start_unit.SelectedValue)))
                mdl.jobStartUnit = new Guid(cmb_start_unit.SelectedValue);
            else
                mdl.jobStartUnit = Guid.Empty;
            mdl.jobFrequency = txtFrequency.Text;
            if (!(string.IsNullOrEmpty(cmb_frequency_unit.SelectedValue)))
                mdl.jobFrequencyUnit = new Guid(cmb_frequency_unit.SelectedValue);
            else
                mdl.jobFrequencyUnit = Guid.Empty;

            // int itemschecked = cmb_resource.CheckedItems.Count;
            // String[] resourceArray = new String[itemschecked];
            //  var collection = cmb_resource.CheckedItems;
            int i = 0;
            //foreach (var item in collection)
            //{
            //    String value = item.Value;
            //    resourceArray[i] = value;
            //    i++;
            //}
            //  var resources = String.Join(",", resourceArray);
            // mdl.jobResourceName = resources;

            //if (!(string.IsNullOrEmpty(cmb_resource.SelectedValue)))
            //    mdl.jobResourceName = cmb_resource.SelectedValue;
            //else
            //    mdl.jobResourceName = Convert.ToString( Guid.Empty);
            if (!(string.IsNullOrEmpty(hf_resource_ids.Value)))
            {
                mdl.jobResourceName = Convert.ToString(hf_resource_ids.Value);
            }
            else
            {
                mdl.jobResourceName = Convert.ToString(Guid.Empty);
            }
            mdl.CreatedBy = new Guid(SessionController.Users_.UserId);
            mdl.fk_typeId = new Guid(hf_type_id.Value);
            mdl.Flag = "";
            ds = ctl.proc_insert_update_job_details(mdl, SessionController.ConnectionString);
            string duplicate_name = Convert.ToString(ds.Tables[0].Rows[0]["duplicate_flag"]);

            if (duplicate_name == "N")
            {
                Bindjobs(new Guid(hf_type_id.Value));
                radDatePicker.Clear();
                txt_Description.Text = "";
                txtName.Text = "";
                txtDuration.Text = "";
                txtFrequency.Text = "";
                //   cmb_resource.ClearSelection();
                //  cmb_resource.ClearCheckedItems();
                cmb_status.ClearSelection();
                txtPriors.Text = "";
                cmb_start_unit.ClearSelection();
                cmb_frequency_unit.ClearSelection();
                cmb_duration_unit.ClearSelection();
                cmb_Category.ClearSelection();
            }
            else if (duplicate_name == "Y")
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    private DataSet get_data(string pk_job_id)
    {
        DataSet ds = new DataSet();
        TypeModel mdl = new TypeModel();
        TypeProfileClient ctl = new TypeProfileClient();
        mdl.jobid = new Guid(pk_job_id);
        ds = ctl.proc_get_job_tasks(mdl, SessionController.ConnectionString);
        return ds;
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        if (SessionController.Users_.Permission_ds != null)
        {
            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
            {
                {
                    SetPermissions();
                }
            }
        }
    }

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='Type'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Jobs")
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
        // edit permission
        if (edit_permission == "N")
        {
            btnAddJob.Enabled = false;
            foreach (GridDataItem item in rg_TypeJobs.MasterTableView.Items)
            {
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = false;
            }

            foreach (GridDataItem item in rg_TypeJobs.MasterTableView.Items)
            {
                ImageButton imgbtnAddSubtask = (ImageButton)item.FindControl("imgbtnAddSubtask");
                imgbtnAddSubtask.Enabled = false;
            }
        }
        else
        {
            btnAddJob.Enabled = true;
            foreach (GridDataItem item in rg_TypeJobs.MasterTableView.Items)
            {
                (item["EditCommandColumn"].Controls[0] as ImageButton).Enabled = true;
            }
            foreach (GridDataItem item in rg_TypeJobs.MasterTableView.Items)
            {
                ImageButton imgbtnAddSubtask = (ImageButton)item.FindControl("imgbtnAddSubtask");
                imgbtnAddSubtask.Enabled = true;
            }
        }

        //delete permission
        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rg_TypeJobs.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }
        }
        else
        {
            foreach (GridDataItem item in rg_TypeJobs.MasterTableView.Items)
            {
                ImageButton imgbtndelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtndelete.Enabled = true;
            }
        }
    }

    #endregion





}