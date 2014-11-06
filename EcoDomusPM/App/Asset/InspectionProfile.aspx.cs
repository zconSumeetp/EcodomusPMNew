using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using Inspections;
using System.Data;
using System.Threading;
using System.Globalization;


public partial class App_Asset_InspectionProfile : System.Web.UI.Page
{
    #region Page Load
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    if (Request.QueryString["InspectionId"] != null)
                    {
                        hfinspectionid.Value = Request.QueryString["InspectionId"].ToString();

                    }
                    else
                    {
                        hfinspectionid.Value = Guid.Empty.ToString();
                    }

                    hfuserid.Value = SessionController.Users_.UserId.ToString();
                    BindInspectionProfile();
                    

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    #endregion

    #region Private methods
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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
    protected void BindInspectionProfile()
    {
        try
        {
            DataSet ds = new DataSet();
            Inspections.InspectionModel objins_mdl = new InspectionModel();
            Inspections.InspectionsClient objins_ctrl = new InspectionsClient();

            objins_mdl.Inspection_id = new Guid(hfinspectionid.Value);
            ds = objins_ctrl.proc_get_inspection_data(objins_mdl, SessionController.ConnectionString);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtName.Text = ds.Tables[0].Rows[0]["name"].ToString();
                txtDescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
                dt_Inspection.SelectedDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["inspection_date"].ToString());
                lblfacility.Text = ds.Tables[0].Rows[0]["facility_name"].ToString();
                hffacilityname.Value = lblfacility.Text;
                hffacilityid.Value = ds.Tables[0].Rows[0]["fk_facility_id"].ToString();
                EnableDisable("D");
            }
            else 
            {
                EnableDisable("E");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void EnableDisable(string flag)
    {
        try
        {
            if (flag == "D")
            {
                lblName.Text = txtName.Text;
                lblDescription.Text = txtDescription.Text;
                lblDate.Text = dt_Inspection.SelectedDate.Value.ToShortDateString();
               
                txtDescription.Visible = false;
                txtName.Visible = false;
                dt_Inspection.Visible = false;
                lnkbtnfacility.Visible = false;

                lblName.Visible = true;
                lblfacility.Visible = true;
                lblDescription.Visible = true;
                lblDate.Visible = true;

                //btnSave.Text = "Edit";
                btnSave.Text = (string)GetGlobalResourceObject("Resource", "Edit");

                

            }

            else
            {
                txtDescription.Visible = true;
                txtName.Visible = true;
                dt_Inspection.Visible = true;
                lblfacility.Visible = true;

                lnkbtnfacility.Visible = true;
                lblDescription.Visible = false;
                lblName.Visible = false;
                lblDate.Visible = false;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region EventHandlers
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            //if (btnSave.Text == "Edit")
            if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
                
            {
                BindInspectionProfile();
                EnableDisable("E");
                //btnSave.Text = "Save";
                btnSave.Text = (string)GetGlobalResourceObject("Resource", "Save");
                btnCancel.Visible = true;
            }
            else
            {
                //if (btnSave.Text == "Save")
                if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Save"))

                {
                    if (hffacilityid.Value.ToString() != "")
                    {

                        Inspections.InspectionsClient Insp_obj_crtl = new InspectionsClient();
                        Inspections.InspectionModel Get_obj_mdl = new InspectionModel();
                        Inspections.InspectionModel Insp_obj_mdl = new InspectionModel();
                        Insp_obj_mdl.Name = txtName.Text;
                        Insp_obj_mdl.Inspection_id = new Guid(hfinspectionid.Value);
                        Insp_obj_mdl.Fk_facility_id = hffacilityid.Value.ToString();
                        Insp_obj_mdl.Facility_name = hffacilityname.Value.ToString();

                        Insp_obj_mdl.Description = txtDescription.Text;

                        if (dt_Inspection.SelectedDate != null)
                        {
                            Insp_obj_mdl.Inspection_date = dt_Inspection.SelectedDate.Value.ToShortDateString();
                        }
                        else
                        {
                            Insp_obj_mdl.Inspection_date = "";
                        }
                        if (hfinspectionid.Value.ToString() != Guid.Empty.ToString())
                        {
                            Insp_obj_mdl.New_inspection_id = Guid.Empty;
                        }

                        Insp_obj_mdl.User_id = new Guid(SessionController.Users_.UserId);
                        Get_obj_mdl = Insp_obj_crtl.Insert_Update_Inspection(Insp_obj_mdl, SessionController.ConnectionString);
                        if (hfinspectionid.Value.ToString() == "00000000-0000-0000-0000-000000000000")
                        {
                            hfinspectionid.Value = Get_obj_mdl.New_inspection_id.ToString();
                        }


                        BindInspectionProfile();
                        EnableDisable("D");
                        string value = "<script language='javascript'>GotoProfile('" + hfinspectionid.Value + "')</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
                    }
                    else
                    {
                        lblvalidate.Visible = true;

                    }

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            //if (btnSave.Text == "Save")
            if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Save"))
            {
                if (Request.QueryString["InspectionId"] != null)
                {
                    Response.Redirect("InspectionProfile.aspx?inspectionid=" + hfinspectionid.Value);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Inspections", "NavigateToFindInspection();", true);
                }
            }
            //else if (btnSave.Text == "Edit")
            else if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
                

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Inspections", "NavigateToFindInspection();", true);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion
}