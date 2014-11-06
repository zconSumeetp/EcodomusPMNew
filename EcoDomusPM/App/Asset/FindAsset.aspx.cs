using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Locations;
using EcoDomus.Session;
using Asset;
using Telerik.Web.UI;
//using EcoDomus.AccessRoles;
using System.Threading;
using System.Globalization;



public partial class App_Asset_FindAsset : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtcriteria.Attributes.Add("onKeyPress", "doClick('" + btnsearch.ClientID + "',event)");
            if (SessionController.Users_.UserId != null)
            {

                //if (SessionController.Users_.SystemRoleAccess == "Other OA")
                //{

                //    foreach (GridColumn column in rgasset.Columns)
                //    {
                //        if (column.UniqueName == "remove")
                //        {
                //            column.Visible = false;
                //            break;
                //        }

                //    }
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

                    BindSearchBy();
                    BindFacility();

                    // BindGrid();
                }
                // BindGrid();
            }
        
        catch (Exception ex)
        {
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
    private void SetaccesstopageControls()
    {

        DataSet ds = new DataSet();
        DataTable dt = new DataTable();

        DataColumn Control_type = new DataColumn("Control_type", typeof(string));
        Control_type.DataType = System.Type.GetType("System.String");
        DataColumn Control_id = new DataColumn("Control_id");
        Control_id.DataType = System.Type.GetType("System.String");
        DataRow dr = dt.NewRow();
        dt.Rows.Add(dr);
        DataRow drgrid = dt.NewRow();
        dt.Rows.Add(drgrid);

        dt.Columns.Add(Control_type);
        dt.Columns.Add(Control_id);

       
        dr["Control_type"] = "Button";
        dr["Control_id"] = "btnaddasset";
        drgrid["Control_type"] = "GridView";
        drgrid["Control_id"] = "rgasset";


        foreach (DataRow drs in dt.Rows)
        {
            if (Convert.ToString(drs["Control_type"]) == "Button" && Convert.ToString(drs["Control_id"]) == "btnaddasset")
            {
                btnaddasset.Visible = false;
            }
            if (Convert.ToString(drs["Control_type"]) == "GridView"  && Convert.ToString(drs["Control_id"]) == "rgasset")
            {
                foreach (GridColumn column in rgasset.Columns)
                {
                    if (column.UniqueName == "remove")
                    {
                        column.Visible = false;
                        break;
                    }

                }
            }

        }


    }
    protected void Page_Prerender(object sender, EventArgs e)
    {
        //RadComboBox objComboBox = (RadComboBox)UCComboFacility1.FindControl("cmbFacility");
        //if (SessionController.Users_.IsFacility == "yes")
        //{

        //    objComboBox.SelectedValue = SessionController.Users_.facilityID;
        //    objComboBox.Enabled = false;
        //}
        //else
        //{

        //    objComboBox.Enabled = true;
        //}




        if (!Page.IsPostBack)
        {
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "Asset_Name";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            //Add sort expression, which will sort against first column
            rgasset.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
            
            BindGrid();
            //if (SessionController.Users_.SystemRoleAccess == "Other OA" || SessionController.Users_.SystemRoleAccess == "FA")
            //{
            //    SetaccesstopageControls();
            //}
            
        }
        else if (Request.Params.Get("__EVENTTARGET") == "ctl00$chkfacility")
        {
            BindGrid();

        }
    }
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        try
        {
            BindGrid();
        }
        catch (Exception)
        {

            throw;
        }

    }

    // Bind facilities to facility Dropdown according to user
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

    private void BindSearchBy()
    {
        try
        {
            DataSet ds_location = new DataSet();
            AssetClient assetObj_crtl = new AssetClient();
            ds_location = assetObj_crtl.Getentityforfindasset(SessionController.ConnectionString);
            cmblocation.DataTextField = "entity_name";
            cmblocation.DataValueField = "pk_entity_id";
            cmblocation.DataSource = ds_location;
            cmblocation.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    protected void BindGrid()
    {
        try
        {
            AssetModel objloc_mdl = new AssetModel();
            AssetClient objloc_crtl = new AssetClient();
            DataSet ds_Search_assets = new DataSet();
            objloc_mdl.EntityName = cmblocation.SelectedItem.Text;
            objloc_mdl.CriteriaName = cmbcriteria.SelectedItem.Text;
            objloc_mdl.CriteriaText = txtcriteria.Text;
            objloc_mdl.User_id = new Guid(SessionController.Users_.UserId.ToString());

            if (SessionController.Users_.IsFacility == "yes")
            {
                objloc_mdl.FacilityNames = SessionController.Users_.facilityID;
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
                objloc_mdl.FacilityNames = facilityvalues.ToString();
            }

            ds_Search_assets = objloc_crtl.Search_Assets(SessionController.ConnectionString, objloc_mdl);

            rgasset.DataSource = ds_Search_assets;
            rgasset.DataBind();
            rgasset.Visible = true;
        }
        catch (Exception ex)
        {
        }
    }

    protected void rgasset_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            AssetModel objloc_mdl = new AssetModel();
            AssetClient objloc_crtl = new AssetClient();

            objloc_mdl.Asset_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Assetid"].ToString());

            if (e.CommandName == "delete")
            {
                objloc_crtl.delete_Asset(SessionController.ConnectionString, objloc_mdl);
            }


            BindGrid();
        }
        catch (Exception ex)
        {

        }

    }

    protected void btnaddasset_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("AssetMenu.aspx");
        }
        catch (Exception ex)
        {
        }
    }

    protected void cmbfacility_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        try
        {
            ((CheckBox)e.Item.FindControl("CheckBox1")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");

        }
        catch (Exception ex)
        {
        }
    }
}