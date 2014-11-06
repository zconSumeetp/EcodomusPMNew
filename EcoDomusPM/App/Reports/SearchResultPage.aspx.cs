using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using Report;
using Telerik.Web.UI;
using System.Data;
using System.Threading;
using System.Globalization;
public partial class App_Reports_SearchResultPage : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flag = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    //hfSearchResultPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    tempPageSize = Convert.ToString((Convert.ToInt32(tempPageSize) + 1));
                    hfSearchResultPMPageSize.Value = tempPageSize;
                    BindSearchedEntityData();
                }

            }

        }
        catch (Exception)
        {
            
            throw;
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

    private void BindSearchedEntityData()
    {
        ReportClient obj_report_client = new ReportClient();
        ReportModel obj_report_model = new ReportModel();
        DataSet ds = new DataSet();
        string[] arr_srch_entity = new string[4];
        List<string> entity = new List<string>();
        try
        {
            string srch_entity = Request.QueryString["srch_entity"];
            string srch_txt = Convert.ToString(Request.QueryString["srch_txt"]);
            ViewState["srch_txt"] = srch_txt;
            obj_report_model.Search_text = srch_txt;

            Label lbl_search_entity = Master.FindControl("lbl_search_entity") as Label;

            RadToolTipManager manager = Master.FindControl("RadToolTip5") as RadToolTipManager;

            if (lbl_search_entity != null)
            {
                if (srch_entity.Length > 15)
                {
                    lbl_search_entity.Text = srch_entity.Substring(0, 12)+"...";
                    
                        //manager.TargetControls[0].TargetControlID = "lbl_search_entity";
                        //lbl_search_entity.ToolTip = srch_entity.Substring(0, 12) + "...";
                   
                }
                else
                {
                    lbl_search_entity.Text = srch_entity;
                    //lbl_search_entity.ToolTip = srch_entity.Substring(0, 12) + "...";
                }
            }

            if (!string.IsNullOrEmpty(srch_entity))
            {

                arr_srch_entity = srch_entity.TrimEnd(',').Split(',');
                entity = arr_srch_entity.ToList<string>();
            }

            RadTextBox txt_search = Master.FindControl("txtcriteriaMtr") as RadTextBox;
            if (txt_search != null)
            {

                txt_search.Text = srch_txt;
            }

            CheckBox chk_facility = Master.FindControl("chk_facilities") as CheckBox;
            if (chk_facility != null)
            {
                if (entity.Contains("Facilities"))
                {
                    obj_report_model.Is_facility = "Y";
                    chk_facility.Checked = true;

                }
                else
                {
                    obj_report_model.Is_facility = "N";
                }
            }

            CheckBox chk_projects = Master.FindControl("chk_projects") as CheckBox;
            if (chk_projects != null)
            {
                if (entity.Contains("Projects"))
                {
                    obj_report_model.Is_project = "Y";
                    chk_projects.Checked = true;

                }
                else
                {
                    obj_report_model.Is_project = "N";
                }
            }


            CheckBox chk_locations = Master.FindControl("chk_locations") as CheckBox;
            if (chk_locations != null)
            {
                if (entity.Contains("Locations"))
                {
                    obj_report_model.Is_location = "Y";
                    chk_locations.Checked = true;
                }
                else
                {
                    obj_report_model.Is_location = "N";
                }

            }

            CheckBox chk_Component = Master.FindControl("chk_Component") as CheckBox;
            if (chk_Component != null)
            {
                if (entity.Contains("Component"))
                {
                    obj_report_model.Is_equipment = "Y";
                    chk_Component.Checked = true;
                }
                else
                {
                    obj_report_model.Is_equipment = "N";
                }

            } 
            
            if (!string.IsNullOrEmpty(SessionController.Users_.ProjectId))
            {
                obj_report_model.fkproject_id = SessionController.Users_.ProjectId;
                obj_report_model.UserId =new Guid( SessionController.Users_.UserId);
                
                
                ds = obj_report_client.proc_get_searched_entity_data(obj_report_model, SessionController.ConnectionString);
                if (ds != null)
                { 
                    if (ds.Tables.Count > 0)
                    {
if (obj_report_model.Is_equipment.Equals("N") && obj_report_model.Is_facility.Equals("N") && obj_report_model.Is_location.Equals("N") && obj_report_model.Is_project.Equals("Y"))
                        {
                           rg_searched_data.MasterTableView.Columns[3].Visible = false;
                          
                        }
                       rg_searched_data.AllowCustomPaging = true;
                        if (tempPageSize != "")                            
                        rg_searched_data.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
                        rg_searched_data.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
                        rg_searched_data.DataSource = ds;
                        rg_searched_data.DataBind();

                    }
                    else
                    {
                        rg_searched_data.DataSource = string.Empty;
                        rg_searched_data.DataBind();
                    
                    }
                }
            }
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void rg_searched_data_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            BindSearchedEntityData();
            flag = false;
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void rg_searched_data_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
           tempPageSize = e.NewPageSize.ToString();
            if (!flag)
            {
                flag = true;
                BindSearchedEntityData();
                   
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_searched_data_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        try
        {
            BindSearchedEntityData();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_searched_data_ItemCommand(object sender, GridCommandEventArgs e)
    {
        string entity=string.Empty;
        try
        {
            if (e.CommandName == "Edit")
            {
                if (!string.IsNullOrEmpty(Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["entity"])))
                {

                    entity = Convert.ToString(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["entity"]);
                    if (entity.Equals("Facility"))
                    {
                        Guid facility_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_id"].ToString());
                        string facilityname = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["name"].ToString();
                        SessionController.Users_.facilityID = facility_id.ToString();
                        Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + facility_id + "&FacilityName=" + facilityname + "&profileflag=new&IsFromFacility=Y", false);
                    }
                    if (entity.Equals("Project"))
                    {
                        string pk_project_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_id"].ToString();
                        string project_name = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["name"].ToString();
                    
                        SessionController.Users_.ProjectId = pk_project_id;
                        SessionController.Users_.ProjectName = project_name;
                        //added to kill all sessionvalues of type page
                        SessionController.Users_.TypePageSize = null;
                        SessionController.Users_.TypePageIndex = null;
                        SessionController.Users_.TypeCount = null;
                        SessionController.Users_.TypeCheckedCheckboxes = null;
                        SessionController.Users_.TypeSearchText = null;
                        SessionController.Users_.TypeSortExpression = null;
                        SessionController.Users_.TypeFacilities = null;
                        SessionController.Users_.TypeSelectedFacilities = null;
                        //added to kill all sessionvalues of component page
                        SessionController.Users_.ComponentPageSize = null;
                        SessionController.Users_.ComponentPageIndex = null;
                        SessionController.Users_.ComponentCount = null;
                        SessionController.Users_.ComponentCheckedCheckboxes = null;
                        SessionController.Users_.ComponentSearchText = null;
                        SessionController.Users_.ComponentSortExpression = null;
                        SessionController.Users_.ComponentFacilities = null;
                        SessionController.Users_.ComponentSelectedFacilities = null;
                        //added to kill session value of space 
                        SessionController.Users_.SpaceFacilities = null;

                        Response.Redirect("~/App/Settings/ProjectMenu.aspx?pk_project_id=" + pk_project_id+"&Flag=SPP+&pagevalue=ProjectProfile", false);
                        
                    }
                    if (entity.Equals("Space"))
                    {
                        Guid space_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_id"].ToString());
                        //SessionController.Users_.facilityID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_facility_id"].ToString();
                        Response.Redirect("~/App/Locations/FacilityMenu.aspx?IsFromSpace=y&pagevalue=Space Profile&id=" + space_id + "&profileflag=new");
                    }
                    if (entity.Equals("Component"))
                    {
                        Guid assetid = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_id"].ToString());
                        //Guid facilityid = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["facilityid"].ToString());
                        Response.Redirect("~/App/Asset/AssetMenu.aspx?assetid=" + assetid, false);
                    }
                }
            }

        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void  rg_searched_data_OnItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        try
        {

            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rg_searched_data.MasterTableView.RenderColumns)
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
                        ////if the sorting feature of the grid is enabled
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                }
            }


            if (e.Item is GridPagerItem)
            {

                RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                cb.Items.Sort(new PagerRadComboBoxItemComparer());
                if (tempPageSize != "")
                {
                    cb.Items.FindItemByValue(tempPageSize).Selected = true;
                }


            }

            if (e.Item is GridDataItem)
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                foreach (GridColumn column in rg_searched_data.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "OrganizationName")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2].ToString());
                        }
                        else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName != "Email" && column.UniqueName != "enabled")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                        }
                        else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "email")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[4].ToString());
                        }
                        else if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "status")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[9].ToString());
                        }
                    }

                    else if (column is GridButtonColumn)
                    {

                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "facname")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[1].ToString());

                    }
                    /*
                                        else if (column is GridTemplateColumn)
                                        {

                                            if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "email")
                                            {
                                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[4].ToString());
                                            }
                                            if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "status")
                                            {
                                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[9].ToString());
                                            }
                                        }
                     * */   
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}

  