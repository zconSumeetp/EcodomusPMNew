using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using System.Data.SqlClient;
using Login;
using Inspections;
using Telerik.Web.UI;
using TypeProfile;
using System.Threading;
using System.Globalization;
using Winnovative.WnvHtmlConvert;


public partial class App_Asset_Inspections : System.Web.UI.Page
{
    string fac_ids = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                Bind_Facility();
                
                if (!IsPostBack)
                {
                    RadComboBox objRadComboBox = (RadComboBox)UCComboFacility1.FindControl("cmbFacility");

                    if (SessionController.Users_.IsFacility == "yes")  //Single facility is selected in header.
                    {
                        objRadComboBox.SelectedValue = SessionController.Users_.facilityID;
                        objRadComboBox.Enabled = false;
                        fac_ids = SessionController.Users_.facilityID;
                    }
                    else
                    {
                        objRadComboBox.Visible = true;
                        objRadComboBox.Enabled = true;
                    }
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgInspections.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                    Bind_rgInspections();
                }
                
                else 
                {
                    if (SessionController.Users_.IsFacility == "no")//User has unchecked the checkbox.(He can access data in all facilities assigned to him.)
                    {
                        Bind_rgInspections();
                    }
                }

            }
            else
            {
                Response.Redirect("~/App/LoginPM.aspx");
            }
        }
        catch (Exception ex)
        {
           lblMessage.Text="Page_Load:-" + ex.Message.ToString();
        }
    }
    
      protected void Bind_Facility()
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                CheckBox chk_facility = (CheckBox)Master.FindControl("chkfacility");
                if (chk_facility.Checked == true)
                {

                    fac_ids = SessionController.Users_.facilityID;
                    RadComboBox objRadComboBox = (RadComboBox)UCComboFacility1.FindControl("cmbFacility");
                    objRadComboBox.SelectedValue = fac_ids;
                    objRadComboBox.Enabled = false;
                }
                else
                {

                    Telerik.Web.UI.RadComboBox objRadComboBox = (Telerik.Web.UI.RadComboBox)UCComboFacility1.FindControl("cmbFacility");

                    objRadComboBox.Enabled = true;
                    RadComboBox rc = (RadComboBox)UCComboFacility1.FindControl("cmbFacility");
                    System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();

                    foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in objRadComboBox.Items)
                    {
                        Telerik.Web.UI.RadTreeView objRadTreeView = (Telerik.Web.UI.RadTreeView)rcbItem.FindControl("rtvFacilities");
                        foreach (Telerik.Web.UI.RadTreeNode CheckedNode in objRadTreeView.CheckedNodes)
                        {

                            fac_ids = fac_ids + CheckedNode.Value + ","; ;

                        }
                        if (fac_ids.Length > 0)
                        {
                            fac_ids = fac_ids.Substring(0, fac_ids.Length - 1);
                        }

                    }
                    Bind_rgInspections(); 

                }
             }
        }

        catch (Exception)
        {
            throw;
        }
         
    }


    protected void Bind_rgInspections()
    {
        try
        {
                DataSet ds_inspections = new DataSet();
                Inspections.InspectionsClient Insp_obj_ctrl = new Inspections.InspectionsClient();
                Inspections.InspectionModel Insp_obj_mdl = new Inspections.InspectionModel();
                Insp_obj_mdl.Search_text = txtSearch.Text;
                Insp_obj_mdl.Fk_facility_id = fac_ids;

                ds_inspections = Insp_obj_ctrl.GetInspection(Insp_obj_mdl, SessionController.ConnectionString);

                if (ds_inspections.Tables.Count > 0)
                {
                    rgInspections.DataSource = ds_inspections;
                    rgInspections.DataBind();
                }
                else
                {
                }
            
            
            
        }
         catch(Exception ex)
        {
            throw ex;
        }
    }

    protected void btnAdd_Inspection_Click(object sender, EventArgs e)
    {
        
        Response.Redirect("~\\App\\Asset\\InspectionMenu.aspx?pagevalue=InspectionProfile&InspectionId=" + Guid.Empty);
    }

    protected void btnSearch_click(object sender, EventArgs e)
    {
        Bind_Facility();
        Bind_rgInspections();
    }

    protected void rgInspections_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "deleteinspection")
        {
            string inspectionId = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_inspection_id"].ToString();
            deleteinspection(inspectionId);
           
        }
        else if (e.CommandName == "profile")
        {
            string f_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_inspection_id"].ToString();
            hfInspectionID.Value = f_id;
            try
            {

                string nw = "<script language='javascript'>NavigateToInspectionProfile();</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "scriptOrgId", nw);

            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        else if (e.CommandName == "Facilityprofile")
        {
            string facility_id;
            facility_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["fk_facility_id"].ToString();
            SessionController.Users_.facilityID = facility_id;
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + facility_id.ToString(), false);
        }
    
    }
    protected void deleteinspection(string inspectionId)
    {
        Inspections.InspectionsClient ctrl = new Inspections.InspectionsClient();
        Inspections.InspectionModel mdl = new Inspections.InspectionModel();
        try
        {
            mdl.Inspection_id= new Guid(inspectionId);
            ctrl.DeleteInspection(mdl, SessionController.ConnectionString);
            Bind_Facility();
            Bind_rgInspections();
            
        }
        catch (Exception ex)
        {
            lblMsg.Text = "deleteinspection" + ex.Message.ToString();
        }

   }

    protected void rgInspections_SortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            Bind_Facility();
            Bind_rgInspections();
        }
        catch (Exception ex)
        {

            lblMsg.Text = ex.Message.ToString();
        }

    }
    protected void rgInspections_PageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {
            Bind_Facility();
            Bind_rgInspections();
        }
        catch (Exception ex)
        {

            lblMsg.Text = ex.Message.ToString();
        }

    }

    protected void rgInspections_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {


        try
        {
            Bind_Facility();
            Bind_rgInspections();

        }
        catch (Exception ex)
        {

            lblMsg.Text = "rgInspections_PageSizeChanged" + ex.Message.ToString();
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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }



}