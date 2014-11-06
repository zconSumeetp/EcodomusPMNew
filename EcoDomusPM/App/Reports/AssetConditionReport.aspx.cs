using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using Locations;
using Report;
using Telerik.Web.UI;


public partial class App_Reports_AssetConditionReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    { 
        try
        {
         if (SessionController.Users_.UserId != null)
                {

                }
                CheckBox chk_facility = (CheckBox)Master.FindControl("chkfacility");
                if (chk_facility.Checked == true)
                {
                    cmbfacility.SelectedValue = SessionController.Users_.facilityID;
                    hfFacilityid.Value = SessionController.Users_.facilityID.ToString();
                    cmbfacility.Enabled = false;
                }
                else
                {
                    cmbfacility.Enabled = true;
                }
                if (!IsPostBack)
                {              
                    BindFacility();                    
                }
                bindchart();
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                rgConditionReport.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                bindgrid();
                    
            }
        catch (Exception ex)
        {
        }
    }

    private void BindFacility()
    {
        try
        {
            DataSet ds_facility = new DataSet();
            LocationsClient locObj_crtl = new LocationsClient();
            LocationsModel locObj_mdl = new LocationsModel();
            locObj_mdl.User_id = new Guid(SessionController.Users_.UserId);
            ds_facility = locObj_crtl.Get_Facility(SessionController.ConnectionString, locObj_mdl);
            cmbfacility.DataTextField = "name";
            cmbfacility.DataValueField = "ID";
            cmbfacility.DataSource = ds_facility;
            cmbfacility.DataBind();

            if (SessionController.Users_.IsFacility == "yes")
            {
                cmbfacility.Visible = true;
                lblfacility.Visible = true;
                cmbfacility.SelectedValue = SessionController.Users_.facilityID;
                cmbfacility.Enabled = false;
            }
            else
            {
                cmbfacility.Visible = true;
                lblfacility.Visible = true;
                cmbfacility.Enabled = true;
            }

        }
        catch (Exception ex)
        {
        }
    }

    private void bindchart()
    {
        try
        {
            ReportClient objclient = new ReportClient();
            ReportModel objmodel = new ReportModel();
            DataSet ds = new DataSet();
            objmodel.Facility_id = getFacilities();
            ds = objclient.GetAssetConditionReport(objmodel, SessionController.ConnectionString);
            RadChart2.DataSource = ds.Tables[1];
            RadChart2.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private string getFacilities()
    {
        string Facility_id;
        try
        {

            DataSet ds_Search_assets = new DataSet();

            if (SessionController.Users_.IsFacility == "yes")
            {
                Facility_id = SessionController.Users_.facilityID;
            }
            else
            {
                System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
                foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
                    {
                        facilityvalues.Append(rcbItem.Value);
                        facilityvalues.Append(",");
                    }
                }
                if (facilityvalues.ToString().Length > 0)
                {
                    facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
                }
                Facility_id = facilityvalues.ToString();
            }
            return Facility_id;
        }
        catch (Exception ex)
        {
            return Facility_id = "";
        }

    }

    private void bindgrid()
    {
        try
        {
            ReportClient objClient = new ReportClient();
            ReportModel objModel = new ReportModel();
            DataSet ds = new DataSet();
            objModel.Facility_id = getFacilities();
            ds = objClient.GetAssetConditionReport(objModel, SessionController.ConnectionString);
            rgConditionReport.DataSource = ds.Tables[0];
            rgConditionReport.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void cmbfacility_ItemDataBound(object sender, Telerik.Web.UI.RadComboBoxItemEventArgs e)
    {
        try
        {
            ((CheckBox)e.Item.FindControl("CheckBox1")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void RadChart2_ItemDataBound(object sender, Telerik.Charting.ChartItemDataBoundEventArgs e)
    {
        e.SeriesItem.Name = ((DataRowView)e.DataItem)["value"].ToString();

    }

    protected void btnGenerateReport_Click(object sender, EventArgs e)
    {
        bindchart();
        bindgrid();
    }

    protected void rgConditionReport_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        bindgrid();
    }

    protected void rgConditionReport_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        bindgrid();
    }

    protected void rgConditionReport_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        Guid asset_id;
        if (e.CommandName == "Edit_")
        {
            LinkButton linkAssetName = e.Item.FindControl("linkAssetName") as LinkButton;
            asset_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_asset_id"].ToString());
            Response.Redirect("~/App/Asset/AssetMenu.aspx?assetid=" + asset_id + "&pagevalue=AssetProfile", false);
        }
    }
}