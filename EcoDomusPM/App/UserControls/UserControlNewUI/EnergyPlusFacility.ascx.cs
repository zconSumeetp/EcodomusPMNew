using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using Facility;
using System.Data;
using Telerik.Web.UI;
using EnergyPlus;

public partial class App_UserControls_EnergyPlusFacility : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (hf_is_loaded.Value.Equals("No"))
            {
                //lbl_facility_desc.Text = "The Camden Federal Courthouse Complex consists of two buildings," +
                //                "the Post Office & Courthouse Building and a Courthouse Annex." +
                //                "The buildings are attached through a link-way." +
                //                "The building identified as the Post Office & Courthouse" +
                //                "building is located at 401 Market Street, and consists of file floors and a basement," +
                //                "encompassing approximately 99,924 GSF. The Annex Building located at 400 Cooper Street," +
                //                "consists of six floors, a basement, a sub-basement,and a penthouse, encompassing approximately 185,896 GSF.";
                BindFacilities();
                
                hf_is_loaded.Value = "Yes";
            }
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "script1", "adjust_frame_height();", true);
        }

    }

    protected void BindFacilities()
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        DataSet ds = new DataSet();
        try
        {
            fm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
            fm.Search_text_name = "";
            fm.Doc_flag = "floor";
            obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.ProjectId);
            obj_energy_plus_model.Search_text_name = "";
            ds = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);
            rg_facility.DataSource = ds;
            rg_facility.DataBind();
            
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rg_facility_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            BindFacilities();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "script2", "adjust_height();", true);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_facility_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            BindFacilities();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "script3", "adjust_height();", true);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
   


    private void GoToNextTab()
    {

        RadTabStrip tabStrip = (RadTabStrip)Page.FindControl("rts_energy_plus");
        RadTab select_template = tabStrip.FindTabByValue("EnergyPlusTemplate");
        select_template.Enabled = true;
        select_template.Selected = true;
        GoToNextPageView();
    }

    private void GoToNextPageView()
    {
        try
        {
            RadMultiPage rmp_energy_plus = (RadMultiPage)Page.FindControl("rmp_energy_plus");
            RadPageView rpv_template = rmp_energy_plus.FindPageViewByID(@"~/App/UserControls/UserControlNewUI/" + "EnergyPlusTemplate");
            if (rpv_template == null)
            {
                rpv_template = new RadPageView();
                rpv_template.ID = @"~/App/UserControls/UserControlNewUI/" + "EnergyPlusTemplate";
                rmp_energy_plus.PageViews.Add(rpv_template);
            }
            rpv_template.Selected = true;
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
            InsertUpdateEMFacility();
            GoToNextTab();
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
            InsertUpdateEMFacility();
            GoToNextTab();

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

    private void InsertUpdateEMFacility()
    {
        EnergyPlusClient obj_energy_model_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_model_model = new EnergyPlusModel();
        try
        {
            string cnt = rg_facility.SelectedItems.Count.ToString() ;
            if (rg_facility.SelectedItems.Count > 0)
            {
                HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
                if (hf_facility_id != null)
                {
                    hf_facility_id.Value =  new Guid(rg_facility.SelectedValues["pk_facility_id"].ToString()).ToString();
                    SessionController.Users_.Em_facility_id = hf_facility_id.Value;
                }
                HiddenField hf_facility_name = (HiddenField)Page.FindControl("hf_facility_name");
                if (hf_facility_name != null)
                { 
                hf_facility_name.Value=rg_facility.SelectedValues["name"].ToString();
                }
                obj_energy_model_model.Fk_facility_id = new Guid(rg_facility.SelectedValues["pk_facility_id"].ToString());
                obj_energy_model_client.Insert_Update_Energy_Modeling_Facility(obj_energy_model_model, SessionController.ConnectionString);
                lbl_facility_desc.Text = rg_facility.SelectedValues["description"].ToString();
                lbl_facility_name.Text = rg_facility.SelectedValues["name"].ToString();
            }
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
            RadTab select_template = tabStrip.FindTabByValue("EnergyPlusFacility");
            select_template.Enabled = true;
            select_template.Selected = true;
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
}