using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EnergyPlus;
using EcoDomus.Session;
using System.Data;
using System.Text;

public partial class App_UserControls_EnergyPlusTemplate : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (hf_is_loaded.Value.Equals("No"))
                {
                    lbl_template_msg.Text = "Select a predefined template to create the initial energy modeling attributes that will be applied " +
                                             "to the facility, rooms, spaces, assets and equipment.";
                    HiddenField hf_facility_name = (HiddenField)Page.FindControl("hf_facility_name");
                    if (hf_facility_name != null)
                    {
                        lbl_facility_name.Text = hf_facility_name.Value;
                    }
                    HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
                    if (hf_facility_id != null)
                    {
                        if (!hf_facility_id.Value.Equals(""))
                        {
                            BindAttributeTemplateDropDown();
                            ShowEnergyModelingTemplateGroup();
                        }
                    }
                    hf_is_loaded.Value = "Yes";
                }

                //if (cmb_attribute_template.Items.Count == 0)
                //{
                //    HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
                //    if (hf_facility_id != null)
                //    {
                //        BindAttributeTemplateDropDown();
                //        ShowEnergyModelingTemplateGroup();
                //    }

                //}
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void BindAttributeTemplateDropDown()
    {
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        DataSet ds = new DataSet();
        try
        {
            HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
            if (hf_facility_id != null)
            {
                if (!hf_facility_id.Value.Equals(""))
                {
                    obj_energy_plus_model.Fk_facility_id = new Guid(hf_facility_id.Value);
                }
            }

            if (SessionController.Users_.Em_facility_id!=null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            }
            obj_energy_plus_model.Organization_id = new Guid(SessionController.Users_.OrganizationID);

            ds = obj_energy_plus_client.Get_All_Attribute_Template(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                cmb_attribute_template.DataTextField = "template_name";
                cmb_attribute_template.DataValueField = "pk_attribute_template_id";
                cmb_attribute_template.DataSource = ds;
                cmb_attribute_template.DataBind();

            }

            if (ds.Tables[1] != null)
            {
                if (ds.Tables[1].Rows.Count > 0)
                {
                    cmb_attribute_template.SelectedValue = ds.Tables[1].Rows[0]["fk_attribute_template_id"].ToString();

                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void lbtn_next_Click(object sender, EventArgs e)
    {
        try
        {
            AssignTemplateToFacility();
            GoToNextTab();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void AssignTemplateToFacility()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
            if (hf_facility_id != null)
            {
                if (cmb_attribute_template.Items.Count > 0)
                {
                    obj_energy_plus_model.Fk_facility_id = new Guid(hf_facility_id.Value);

                    obj_energy_plus_model.Pk_template_id = new Guid(cmb_attribute_template.SelectedValue);
                    obj_energy_plus_client.Insert_Update_Facility_Attribute_Template_Linkup(obj_energy_plus_model, SessionController.ConnectionString);
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ibtn_next_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            AssignTemplateToFacility();
            GoToNextTab();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void GoToNextTab()
    {

        RadTabStrip tabStrip = (RadTabStrip)Page.FindControl("rts_energy_plus");
        RadTab select_data = tabStrip.FindTabByValue("EnergyPlusData");
        select_data.Enabled = true;
        select_data.Selected = true;
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
            RadMultiPage rmp_energy_plus = (RadMultiPage)Page.FindControl("rmp_energy_plus");
            RadPageView rpv_data = rmp_energy_plus.FindPageViewByID(@"~/App/UserControls/UserControlNewUI/" + "EnergyPlusData");
            if (rpv_data == null)
            {
                rpv_data = new RadPageView();
                rpv_data.ID = @"~/App/UserControls/UserControlNewUI/" + "EnergyPlusData";
                rmp_energy_plus.PageViews.Add(rpv_data);
            }
            rpv_data.Selected = true;

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void lbtn_back_Click(object sender, EventArgs e)
    {
        try
        {
            GoToPreviousTab();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ibtn_back_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            GoToPreviousTab();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    private void GoToPreviousTab()
    {
        try
        {
            RadTabStrip tabStrip = (RadTabStrip)Page.FindControl("rts_energy_plus");
            RadTab select_facility = tabStrip.FindTabByValue("EnergyPlusFacility");
            select_facility.Enabled = true;
            select_facility.Selected = true;
            GoToPreviousPageView();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void GoToPreviousPageView()
    {
        try
        {
            RadMultiPage rmp_energy_plus = (RadMultiPage)Page.FindControl("rmp_energy_plus");
            RadPageView rpv_facility = rmp_energy_plus.FindPageViewByID(@"~/App/UserControls/UserControlNewUI/" + "EnergyPlusFacility");
            if (rpv_facility == null)
            {
                rpv_facility = new RadPageView();
                rpv_facility.ID = @"~/App/UserControls/UserControlNewUI/" + "EnergyPlusFacility";
                rmp_energy_plus.PageViews.Add(rpv_facility);
            }
            rpv_facility.Selected = true;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void cmb_attribute_template_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            ShowEnergyModelingTemplateGroup();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void ShowEnergyModelingTemplateGroup()
    {
        DataSet ds = new DataSet();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            if (cmb_attribute_template.Items.Count > 0)
            {
                if (cmb_attribute_template.SelectedValue != null)
                {
                    obj_energy_plus_model.Pk_template_id = new Guid(cmb_attribute_template.SelectedValue);
                    ds = obj_energy_plus_client.Get_Template_Groups(obj_energy_plus_model, SessionController.ConnectionString);
                    if (ds.Tables.Count > 0)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                lst_templates_items.Items.Add(ds.Tables[0].Rows[i]["group_name"].ToString());
                            }

                        }
                        //rtxt_template_items.Text = sb_group_details.ToString();
                    }
                    img_template.ImageUrl = "~/App/Images/Icons/asset_checkbox2.png";
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ibtn_search_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ShowEnergyModelingTemplateGroup();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void lst_templates_items_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string item_name = lst_templates_items.SelectedItem.Text;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
}