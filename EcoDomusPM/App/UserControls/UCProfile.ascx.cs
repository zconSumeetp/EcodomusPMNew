using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using Facility;
using EcoDomus.Session;
using AttributeTemplate;



public partial class App_UserControls_UCProfile : System.Web.UI.UserControl
{
    #region Global Variable Declarations
    string flag = "";
    string TemplateName = "";
    Guid Template_id = Guid.Empty;
    string facility_ids = "";
    #endregion
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                if (SessionController.Users_.UserId != null)
                {
                    HiddenField hf_flag = (HiddenField)Page.FindControl("hf_flag");
                    HiddenField hf_template_id = (HiddenField)Page.FindControl("hftemplate_id");
                    HiddenField hfglobal_flag = (HiddenField)Page.FindControl("hfglobal_flag");
                    HiddenField hf_template_name = (HiddenField)Page.FindControl("hfTemplate_name");
                    string flag = hf_flag.Value.ToString();
                    if (hfglobal_flag.Value != "")
                    {
                        if (hfglobal_flag.Value.ToString() == "Y")
                        {
                            txtaddattribute.Enabled = false;
                        }


                    }
                    if (hf_template_id.Value != "")
                    {
                        Template_id = new Guid(hf_template_id.Value.ToString());
                    }

                    if (!IsPostBack)
                    {
                        BindFacility();

                        if (flag == "Y")
                        {
                            TemplateName = hf_template_name.Value;
                            BindControls();
                        }
                    }
                }
            }
            catch (Exception ex)
            {

                Response.Redirect("~/App/LoginPM.aspx");
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }
    #endregion
    #region Private Methods
    private void BindFacility()
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            DataSet ds_facility = new DataSet();
            ds_facility = ac.GetFacilitiesForTemplate(am, SessionController.ConnectionString);
            if (ds_facility.Tables[0].Rows.Count > 0)
            {
                cmbox_facility_list.DataTextField = "name";
                cmbox_facility_list.DataValueField = "pk_facility_id";
                cmbox_facility_list.DataSource = ds_facility;
                cmbox_facility_list.DataBind();
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public void BindControls()
    {
        try
        {
            txtaddattribute.Text = TemplateName.ToString();
            BindFacilityInformation();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void BindFacilityInformation()
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            DataSet ds = new DataSet();
            string name = "";
            am.Attribute_template_id = Template_id;
            ds = ac.GetFacilityNamesForTemplate(am, SessionController.ConnectionString);
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                name = name + dr["name"].ToString() + ",";
            }
            if (name.Length > 0)
            {
                name = name.Remove(name.ToString().Length - 1, 1);
            }
            //lblFacility.Text = name;
            string fac_id = "";
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                fac_id = fac_id + dr["pk_facility_id"].ToString() + ",";
            }
            if (fac_id.Length > 0)
            {
                fac_id = fac_id.Remove(fac_id.ToString().Length - 1, 1);
            }
            cmbox_facility_list.SelectedValue = fac_id.ToString();
            string[] val = fac_id.Split(',');
            List<string> listFacilityNames = new List<string>(val);
            //cmbox_facility_list.SelectedValue = lblFacility.Text;
            for (int j = 0; j < cmbox_facility_list.Items.Count; j++)
            {
                foreach (string temp in listFacilityNames)
                {
                    if (cmbox_facility_list.Items[j].Value == temp)
                    {
                        CheckBox checkbox = (CheckBox)cmbox_facility_list.Items[j].FindControl("chkfacility");
                        checkbox.Checked = true;
                    }
                }
            }
            cmbox_facility_list.Text = name;

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    private void GoToNextTab()
    {

        RadTabStrip tabStrip = (RadTabStrip)Page.FindControl("RadTabStrip1");
        RadTab facility = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", "Classifications"));
        facility.Enabled = true;
        facility.Selected = true;
        //RadMultiPage multiPage = (RadMultiPage)userContentHolder.FindControl("rmpageSetupSync");
        //RadPageView facilityPageView = multiPage.FindPageViewByID("facility");
        //facilityPageView.Selected = true;

        //27 Jan 2012
        GoToNextPageView();
    }
    private void GoToNextPageView()
    {
        try
        {
            RadMultiPage multiPage = (RadMultiPage)Page.FindControl("RadMultiPage1");
            RadPageView PageView = multiPage.FindPageViewByID(@"~/App/UserControls/UCClassifications.ascx");
            if (PageView == null)
            {
                PageView = new RadPageView();
                PageView.ID = @"~/App/UserControls/UCClassifications.ascx";
                multiPage.PageViews.Add(PageView);
            }
            PageView.Selected = true;

            //RadMultiPage multiPage = (RadMultiPage)Page.FindControl("RadMultiPage1");
            //RadPageView FacilityPageView = multiPage.FindPageViewByID(@"~/App/UserControls/" + "UCAttributeDetail.ascx");
            //if (FacilityPageView == null)
            //{
            //    FacilityPageView = new RadPageView();
            //    FacilityPageView.ID = @"~/App/UserControls/" + "UCAttributeDetail.ascx";

            //    multiPage.PageViews.Add(FacilityPageView);
            //}
            //FacilityPageView.Selected = true;

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    #endregion
    #region Event Handlers
    protected void cmbox_facility_list_ItemDataBound(object sender, Telerik.Web.UI.RadComboBoxItemEventArgs e)
    {
        try
        {
            ((CheckBox)e.Item.FindControl("chkfacility")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");
            //BindFacility();

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                AttributeTemplateModel am = new AttributeTemplateModel();
                AttributeTemplateClient ac = new AttributeTemplateClient();
                if (Template_id == Guid.Empty)
                {
                    am.Attribute_template_id = Guid.Empty;
                }
                else
                {
                    am.Attribute_template_id = Template_id;
                }
                am.Template_name = txtaddattribute.Text;
                am.Organization_id = new Guid(SessionController.Users_.OrganizationID.ToString());
                am.User_Id = new Guid(SessionController.Users_.UserId.ToString());
                System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
                foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbox_facility_list.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("chkfacility")).Checked)
                    {
                        facilityvalues.Append(rcbItem.Value);
                        facilityvalues.Append(",");
                    }
                }
                if (facilityvalues.ToString().Length > 0)
                {
                    facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
                }
                am.Facility_Ids = facilityvalues.ToString();
                DataSet ds = new DataSet();
                ds = ac.InsertUpdateAttributeTemplate(am, SessionController.ConnectionString);
                if (ds.Tables[0].Rows[0]["id"].ToString() == Guid.Empty.ToString())
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
                }
                else
                {

                    string id = ds.Tables[0].Rows[0]["id"].ToString();


                    GoToNextTab();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }


        }
    }

    protected void lbtn_next_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (Page.IsValid)
            {
                try
                {
                    AttributeTemplateModel am = new AttributeTemplateModel();
                    AttributeTemplateClient ac = new AttributeTemplateClient();
                    if (Template_id == Guid.Empty)
                    {
                        am.Attribute_template_id = Guid.Empty;
                    }
                    else
                    {
                        am.Attribute_template_id = Template_id;
                    }
                    am.Template_name = txtaddattribute.Text;
                    am.ProjectId = new Guid(SessionController.Users_.ProjectId.ToString()); 
                    am.User_Id = new Guid(SessionController.Users_.UserId.ToString());
                    System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
                    foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbox_facility_list.Items)
                    {
                        if (((CheckBox)rcbItem.FindControl("chkfacility")).Checked)
                        {
                            facilityvalues.Append(rcbItem.Value);
                            facilityvalues.Append(","); 
                        }
                    }
                    if (facilityvalues.ToString().Length > 0)
                    {
                        facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
                    }
                    am.Facility_Ids = facilityvalues.ToString();
                    DataSet ds = new DataSet();
                    ds = ac.InsertUpdateAttributeTemplate(am, SessionController.ConnectionString);
                    if (ds.Tables[0].Rows[0]["id"].ToString() == Guid.Empty.ToString())
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
                    }
                    else
                    {

                        string id = ds.Tables[0].Rows[0]["id"].ToString();


                        GoToNextTab();
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }


            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    protected void ibtn_next_Click(object sender, ImageClickEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (Page.IsValid)
            {
                try
                {
                    AttributeTemplateModel am = new AttributeTemplateModel();
                    AttributeTemplateClient ac = new AttributeTemplateClient();
                    if (Template_id == Guid.Empty)
                    {
                        am.Attribute_template_id = Guid.Empty;
                    }
                    else
                    {
                        am.Attribute_template_id = Template_id;
                    }
                    am.Template_name = txtaddattribute.Text;
                    am.Organization_id = new Guid(SessionController.Users_.ClientID.ToString()); // new Guid(SessionController.Users_.OrganizationID.ToString());
                    am.User_Id = new Guid(SessionController.Users_.UserId.ToString());
                    System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
                    foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbox_facility_list.Items)
                    {
                        if (((CheckBox)rcbItem.FindControl("chkfacility")).Checked)
                        {
                            facilityvalues.Append(rcbItem.Value);
                            facilityvalues.Append(",");
                        }
                    }
                    if (facilityvalues.ToString().Length > 0)
                    {
                        facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
                    }
                    am.Facility_Ids = facilityvalues.ToString();
                    DataSet ds = new DataSet();
                    ds = ac.InsertUpdateAttributeTemplate(am, SessionController.ConnectionString);
                    if (ds.Tables[0].Rows[0]["id"].ToString() == Guid.Empty.ToString())
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
                    }
                    else
                    {

                        string id = ds.Tables[0].Rows[0]["id"].ToString();


                        GoToNextTab();
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }


            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    protected void lbtn_back_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                AttributeTemplateModel am = new AttributeTemplateModel();
                AttributeTemplateClient ac = new AttributeTemplateClient();
                if (Template_id == Guid.Empty)
                {
                    am.Attribute_template_id = Guid.Empty;
                }
                else
                {
                    am.Attribute_template_id = Template_id;
                }
                am.Template_name = txtaddattribute.Text;
                am.Organization_id = new Guid(SessionController.Users_.OrganizationID.ToString());
                am.User_Id = new Guid(SessionController.Users_.UserId.ToString());
                System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
                foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbox_facility_list.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("chkfacility")).Checked)
                    {
                        facilityvalues.Append(rcbItem.Value);
                        facilityvalues.Append(",");
                    }
                }
                if (facilityvalues.ToString().Length > 0)
                {
                    facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
                }
                am.Facility_Ids = facilityvalues.ToString();
                DataSet ds = new DataSet();
                ds = ac.InsertUpdateAttributeTemplate(am, SessionController.ConnectionString);
                if (ds.Tables[0].Rows[0]["id"].ToString() == Guid.Empty.ToString())
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
                }
                else
                {

                    string id = ds.Tables[0].Rows[0]["id"].ToString();


                    GoToNextTab();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }


        }
    }
    protected void ibtn_back_Click(object sender, ImageClickEventArgs e)
    {

    }
    #endregion
}