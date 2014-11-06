using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using TypeProfile;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;
using SetupSync;
using System.Collections;

public partial class App_UserControls_FacilityCS : System.Web.UI.UserControl
{
    public ArrayList arrayList = new ArrayList();
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "name";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            //Add sort expression, which will sort against first column
            RgFacility.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

            if (Request.QueryString["pk_external_system_configuration_id"].ToString() != Guid.Empty.ToString())
            {

                if (hdnFacilityLoaded.Value.Equals("false") == true)
                {

                    //Session["SelectedFacilityID"] = null; 
                    ViewState["SelectedFacilityID"] = null;
                    Fill_Grid_Mapped_Facility(new Guid(Request.QueryString["pk_external_system_configuration_id"]));
                    hdnFacilityLoaded.Value = "true";
                }
            }
            else
            {

                if (hdnFacilityLoaded.Value.Equals("false") == true)
                {
                    ViewState["SelectedFacilityID"] = null;
                    BindFacilityGrid();
                    hdnFacilityLoaded.Value = "true";
                }
            }



        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void btnloadfacilitydetails_click(object sender, EventArgs e)
    {
        try
        {
            Fill_Grid_Mapped_Facility(new Guid(Request.QueryString["pk_external_system_configuration_id"]));
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }




    private void BindFacilityGrid()
    {
        try
        {
            DataSet ds = new DataSet();
            TypeProfile.TypeProfileClient obj_type = new TypeProfileClient();
            TypeProfile.TypeModel mdl = new TypeModel();
            mdl.Organization_Id = new Guid(SessionController.Users_.OrganizationID.ToString());
            mdl.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
            mdl.User_id = new Guid(SessionController.Users_.UserId.ToString());
            mdl.System_Role = SessionController.Users_.UserSystemRole.ToString();
            mdl.Txt_Search = txtSearch.Text;
            ds = obj_type.GetFacilityList(mdl, SessionController.ConnectionString);
            RgFacility.DataSource = ds;
            RgFacility.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void Fill_Grid_Mapped_Facility(Guid configuration_id)
    {

        try
        {
            SetupSyncClient obj_setupSync_client = new SetupSyncClient();
            SetupSyncModel obj_setupSync_model = new SetupSyncModel();
            ArrayList alist = new ArrayList();
            BindFacilityGrid();
            DataSet ds = null;
            obj_setupSync_model.External_system_configuration_id = configuration_id;
            ds = obj_setupSync_client.Get_mapped_facility_details(obj_setupSync_model, SessionController.ConnectionString);
            arrayList = ConvertDataSetToArrayList(ds);
            if (ViewState["SelectedFacilityID"] == null)
            {
                ViewState["SelectedFacilityID"] = arrayList;
            }
            DataRow dr;
            int i = 0;
            //RgFacility.Rebind();

            for (i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                dr = ds.Tables[0].Rows[i];
                Guid IDValue = (Guid)dr[0];
                foreach (GridDataItem item in RgFacility.Items)
                {
                    string facilityID = item["facility_id"].Text.ToString();
                    if (facilityID != null && facilityID.Equals(IDValue.ToString()) == true)
                    {
                        //Telerik.Web.UI.GridTableCell obj = (Telerik.Web.UI.GridTableCell)item["GridCheckBox"];
                        //System.Web.UI.WebControls.CheckBox chkbox = (System.Web.UI.WebControls.CheckBox)obj.Controls[0];
                        try
                        {
                            item.Selected = true;
                        }
                        catch (Exception exp)
                        {
                            throw exp;
                        }
                    }
                }


            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void nextButton_Click(object sender, EventArgs e)
    {
        string id = "";
        string name = "";
        try
        {
            GetSelectedRows();
            ArrayList facility_list = (ArrayList)ViewState["SelectedFacilityID"];
            if (facility_list.Count > 0)
            {
                for (int i = 0; i < facility_list.Count; i++)
                {
                    id = id + facility_list[i].ToString() + ",";

                }
                id = id.Substring(0, id.Length - 1);
            }

            ViewState["SelectedFacilityID"] = facility_list;

            if (Request.QueryString["pk_external_system_configuration_id"] != Guid.Empty.ToString())
            {
                Update_selected_facility(name, id);
            }
            else
            {
                Insert_selected_facility(name, id);

            }
            UpdatePreview();
            GoToNextTab();

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void Insert_selected_facility(string name, string id)
    {
        SetupSyncClient obj_setupSync_client = new SetupSyncClient();
        SetupSyncModel obj_setupSync_model = new SetupSyncModel();
        try
        {
            obj_setupSync_model.Table_name = "tbl_external_system_facility_linkup";
            obj_setupSync_model.External_system_configuration_id = new Guid(SessionController.Users_.Configuration_id);
            obj_setupSync_model.Created_by_user_id = new Guid(SessionController.Users_.UserId.ToString());
            obj_setupSync_model.External_system_data_id = "";
            obj_setupSync_model.Ecodomus_system_data_id = id.ToString();
            obj_setupSync_client.Insert_mapping_entity_details(obj_setupSync_model, SessionController.ConnectionString);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void Update_selected_facility(string name, string id)
    {
        SetupSyncClient obj_setupSync_client = new SetupSyncClient();
        SetupSyncModel obj_setupSync_model = new SetupSyncModel();

        try
        {
            obj_setupSync_model.Table_name = "tbl_external_system_facility_linkup";
            obj_setupSync_model.External_system_configuration_id = new Guid(SessionController.Users_.Configuration_id);
            obj_setupSync_model.Created_by_user_id = new Guid(SessionController.Users_.UserId);
            obj_setupSync_model.Ecodomus_system_data_id = id.ToString();
            obj_setupSync_client.Update_mapped_facility_details(obj_setupSync_model, SessionController.ConnectionString);

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void GoToNextTab()
    {
        try
        {
            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            RadTabStrip tabStrip = (RadTabStrip)userContentHolder.FindControl("rdstripSetupSync");
            string page_name = string.Empty;
            HiddenField hf_external_system = (HiddenField)userContentHolder.FindControl("hf_external_system");
            if (hf_external_system != null)
            {
                if (hf_external_system.Value.Equals("Tekla"))
                {
                    page_name = "AttributeMapping";
                    RadTab mapIntegration = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", "Map_Integration"));
                    mapIntegration.Enabled = true;
                    mapIntegration.Selected = true;

                    //27 Jan 2012
                    GoToNextPageView(page_name);
                }
                else
                {
                    page_name = "MapIntegration";
                    RadTab mapIntegration = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", "Map_Integration"));
                    mapIntegration.Enabled = true;
                    mapIntegration.Selected = true;

                    //27 Jan 2012
                    GoToNextPageView(page_name);
                }
            }
            else
            {
                page_name = "MapIntegration";
                RadTab mapIntegration = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", "Map_Integration"));
                mapIntegration.Enabled = true;
                mapIntegration.Selected = true;

                //27 Jan 2012
                GoToNextPageView(page_name);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void GoToNextPageView(string page_name)
    {
        try
        {
            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            RadMultiPage multiPage = (RadMultiPage)userContentHolder.FindControl("rmpageSetupSync");
            RadPageView MapIntegrationPageView = multiPage.FindPageViewByID(@"~/App/UserControls/" + page_name);
            if (MapIntegrationPageView == null)
            {
                MapIntegrationPageView = new RadPageView();
                MapIntegrationPageView.ID = @"~/App/UserControls/" + page_name;
                multiPage.PageViews.Add(MapIntegrationPageView);
            }
            MapIntegrationPageView.Selected = true;

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void UpdatePreview()
    {
        try
        {
            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            Control previewControl = userContentHolder.FindControl("previewControl");
            Image imgSyncProfile = (Image)previewControl.FindControl("imgFacility");
            imgSyncProfile.Visible = true;
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    protected void RgFacility_pageindexchanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindFacilityGrid();

            //Fill_Grid_Mapped_Facility(new Guid(Request.QueryString["pk_external_system_configuration_id"]));

            //if (Request.QueryString["pk_external_system_configuration_id"].ToString() != Guid.Empty.ToString())
            //{

            //    //GetSelectedRows();
            //    Fill_Grid_Mapped_Facility(new Guid(Request.QueryString["pk_external_system_configuration_id"]));

            //}
            //else
            //{
            //    GetSelectedRows();
            //    BindFacilityGrid();
            //}

        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    private ArrayList ConvertDataSetToArrayList(DataSet ds)
    {
        try
        {
            //DataSet ds = (DataSet)Session["selectedRows"];
            ArrayList alist = new ArrayList();
            foreach (DataRow dtRow in ds.Tables[0].Rows)
            {
                alist.Add(dtRow["facility_id"].ToString());
            }

            return alist;

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void GetSelectedRows()
    {
        try
        {
            SessionToArrayList();

            foreach (GridDataItem item in RgFacility.Items)
            {
                string strIndex = RgFacility.MasterTableView.CurrentPageIndex.ToString();
                string facility_id = item["facility_id"].Text;

                if (item.Selected)
                {
                    if (!arrayList.Contains(facility_id.ToString()))
                    {
                        arrayList.Add(facility_id.ToString());
                    }
                }
                else
                {
                    if (arrayList.Contains(facility_id.ToString()))
                    {
                        arrayList.Remove(facility_id.ToString());
                    }
                }
            }

            ViewState["SelectedFacilityID"] = arrayList;
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void ReSelectedRows()
    {
        try
        {
            foreach (GridDataItem item in RgFacility.Items)
            {
                string facility_id = item["facility_id"].Text;
                if (arrayList.Contains(facility_id.ToString()))
                {
                    item.Selected = true;
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void RgFacility_DataBound(object sender, EventArgs e)
    {
        try
        {
            ReSelectedRows();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void SessionToArrayList()
    {
        try
        {
            if (ViewState["SelectedFacilityID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedFacilityID"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void RgFacility_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {

        try
        {
            GetSelectedRows();
            BindFacilityGrid();
            //Fill_Grid_Mapped_Facility(new Guid(Request.QueryString["pk_external_system_configuration_id"]));
            //BindFacilityGrid();


        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void RgFacility_sortcommand(object sender, GridSortCommandEventArgs e)
    {

        try
        {
            Fill_Grid_Mapped_Facility(new Guid(Request.QueryString["pk_external_system_configuration_id"]));
            //BindFacilityGrid();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {

        try
        {
            GetSelectedRows();
            BindFacilityGrid();
            //Fill_Grid_Mapped_Facility(new Guid(Request.QueryString["pk_external_system_configuration_id"]));
            //BindFacilityGrid();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void RgFacility_PreRender(object sender, EventArgs e)
    {
        try
        {
            if (Session["selectedItems"] != null)
            {
                ArrayList selectedItems = (ArrayList)Session["selectedItems"];
                Int16 stackIndex;
                for (stackIndex = 0; stackIndex <= selectedItems.Count - 1; stackIndex++)
                {
                    string curItem = selectedItems[stackIndex].ToString();
                    foreach (GridItem item in RgFacility.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (curItem.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["CustomerID"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void RgFacility_ItemCommand(object source, GridCommandEventArgs e)
    {
        try
        {
            ArrayList selectedItems;
            if (Session["selectedItems"] == null)
            {
                selectedItems = new ArrayList();
            }
            else
            {
                selectedItems = (ArrayList)Session["selectedItems"];
            }
            if (e.CommandName == RadGrid.SelectCommandName && e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;
                string customerID = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["facility_id"].ToString();
                selectedItems.Add(customerID);
                Session["selectedItems"] = selectedItems;
            }
            if (e.CommandName == RadGrid.DeselectCommandName && e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;
                string customerID = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["facility_id"].ToString();
                selectedItems.Remove(customerID);
                Session["selectedItems"] = selectedItems;
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
}