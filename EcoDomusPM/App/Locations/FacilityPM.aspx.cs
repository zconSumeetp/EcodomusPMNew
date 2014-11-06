using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using Facility;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using Locations;
using Facility; 
using System.Threading;
using System.Globalization;

public partial class App_Locations_FacilityPM : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flag = false;
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

    protected void Page_Load(object sender, EventArgs e)
    {
        txt_search.Attributes.Add("onKeyPress", "doClick('" + btn_search.ClientID + "',event)");
        if (SessionController.Users_.UserId != null)
        {
            if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
            }
            else
            {
                if (!IsPostBack)
                {

                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgFacility.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    hfFacilityPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    BindFacilities();
                }
            }
        }
        else
        {
            Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
        }
    }

    protected void BindFacilities()
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        DataSet ds = new DataSet();
        try
        {
            fm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
            fm.Search_text_name = txt_search.Text;
            fm.Doc_flag = "floor";
            ds = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);
            rgFacility.AllowCustomPaging = true;
            // rgdocument.AllowPaging = true;
            if (tempPageSize != "")
            rgFacility.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgFacility.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));

            rgFacility.DataSource = ds;
            rgFacility.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgFacility_OnSortCommand(object sender, GridSortCommandEventArgs e)
    {
        BindFacilities();
    }

    protected void rgFacility_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        BindFacilities();
        flag = false;   
    }

    protected void rgFacility_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            Guid facility_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_facility_id"].ToString());
            string facilityname = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["name"].ToString();
            SessionController.Users_.facilityID = facility_id.ToString();
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + facility_id + "&FacilityName=" + facilityname + "&profileflag=new&IsFromFacility=Y", false);
        }
        else if (e.CommandName == "Delete_")
        {
            FacilityModel fm = new FacilityModel();
            FacilityClient fc = new FacilityClient();
            DataSet ds = new DataSet();
            Guid facility_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_facility_id"].ToString());
            ds = fc.proc_get_facility_data(fm, SessionController.ConnectionString);
            string entity_id = ds.Tables[1].Rows[0]["pk_entity_id"].ToString();

            LocationsModel lm = new LocationsModel();
            LocationsClient lc = new LocationsClient();
            DataSet ds1 = new DataSet();
            lm.Location_id = facility_id;
            lm.Entity_id = new Guid(entity_id.ToString());
            ds = lc.delete_Location(SessionController.ConnectionString, lm);
            BindFacilities();
        }
    }

    protected void btn_facility_click(object sender, EventArgs e)
    {
        Guid facility_id;
        SessionController.Users_.facilityID = Guid.Empty.ToString();
        //facility_id = new Guid(Guid.Empty.ToString());
        Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + SessionController.Users_.facilityID + "&profileflag=old", false);
        //Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + facility_id.ToString(), false);
    }

    protected void btn_search_click(object sender, EventArgs e)
    {
        BindFacilities();
    }

    protected void btn_delete_click(object sender, EventArgs e)
    {
        try
        {
            if (rgFacility.SelectedItems.Count > 0)
            {
                System.Text.StringBuilder strSystemIds = new System.Text.StringBuilder();
                for (int i = 0; i < rgFacility.SelectedItems.Count; i++)
                {
                    strSystemIds.Append(rgFacility.SelectedItems[i].Cells[2].Text);
                    strSystemIds.Append(",");
                }

                string fac_ids = strSystemIds.ToString();
                if (fac_ids.Length > 0)
                {
                    fac_ids = fac_ids.Remove(fac_ids.ToString().Length - 1, 1);
                }
                //******************Old code before delete_flag functionalirty************
                FacilityModel fm = new Facility.FacilityModel();
                FacilityClient fc = new Facility.FacilityClient();
                fm.Facility_Ids = fac_ids;
                fm.Entity = "Facility";
                //fc.delete_facility_pm(fm, SessionController.ConnectionString);
                //*******************End**********************
                //***********new code modified by Ganesh 19/07/2012*********

                fc.Set_delete_flag(fm, SessionController.ConnectionString);
                //************ENd ****************************

                BindFacilities();

            }
            //else
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
            //}
        }
        catch (Exception ex)
        {

        }
    }

    protected void rgFacility_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        tempPageSize = e.NewPageSize.ToString();
        if (!flag)
        {
            flag = true;


            BindFacilities();
        }
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU" || SessionController.Users_.UserSystemRole == "PA")
            {
                btndelete.Visible = false;
                btnShowAdd.Visible = false;
            }
            // BindFacilities();
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
        catch (Exception)
        {

            throw;
        }
    }

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='Facility'")[0];
            SetPermissionToControl(dr_component);


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

        if (dr["Control_label_id"].ToString() == "btndelete")
        {
            objPermission.SetEditable(btndelete, delete_permission);
            objPermission.SetEditable(btnShowAdd, edit_permission);
        }

    }

    protected void rgFacility_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {

            if (e.Item is GridPagerItem)
            {

                RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                cb.Items.Sort(new PagerRadComboBoxItemComparer());
                if (tempPageSize != "")
                {
                    cb.Items.FindItemByValue(tempPageSize).Selected = true;
                }


            }

            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rgFacility.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                    if (column is GridButtonColumn)
                    {
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                    if (column is GridTemplateColumn)
                    {
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                }
            }

            if (e.Item is GridDataItem)
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                foreach (GridColumn column in rgFacility.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "description")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2].ToString());
                        }
                    }
                    else if (column is GridButtonColumn)
                    {
                       
                         if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "facname")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[1].ToString());
                       
                    }

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
