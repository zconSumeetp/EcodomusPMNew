using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Collections;
using System.Data;
using SetupSync;
using EcoDomus.Session;

public partial class App_UserControls_SpaceTypeCS : System.Web.UI.UserControl
{
    public ArrayList arrayList = new ArrayList();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["pk_external_system_configuration_id"].ToString() != Guid.Empty.ToString())
            {

                if (hdnSpaceTypeLoaded.Value.Equals("false") == true)
                {

                    //Session["SelectedOminClassID"] = null; 
                    ViewState["SelectedSpaceID"] = null;
                    Fill_Grid_Mapped_Spaces(new Guid(Request.QueryString["pk_external_system_configuration_id"]));
                    hdnSpaceTypeLoaded.Value = "true";
                }
            }
            else
            {

                if (hdnSpaceTypeLoaded.Value.Equals("false") == true)
                {
                    ViewState["SelectedSpaceID"] = null;
                    BindSpaceGrid();
                    hdnSpaceTypeLoaded.Value = "true";
                }
            }


            //if (SessionController.Users_.Configuration_id.ToString() != Guid.Empty.ToString())
            //{
            //    if (hdnAssetTypeLoaded.Value.Equals("false") == true)
            //    {
            //        Fill_Grid_Mapped_OmniClass(new Guid(Request.QueryString["pk_external_system_configuration_id"]));
            //        hdnAssetTypeLoaded.Value = "true";
            //    }


            //}

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void btnLoadAssetTypeGrid_Click(object sender, EventArgs e)
    {
        try
        {
            Fill_Grid_Mapped_Spaces(new Guid(Request.QueryString["pk_external_system_configuration_id"]));

        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    private void Fill_Grid_Mapped_Spaces(Guid configuration_id)
    {
        SetupSyncClient obj_setupSync_client = new SetupSyncClient();
        SetupSyncModel obj_setupSync_model = new SetupSyncModel();
        DataSet ds = null;
        try 
        {
            BindSpaceGrid();
            obj_setupSync_model.External_system_configuration_id = configuration_id;
            ds = obj_setupSync_client.Get_mapped_space_type_details(obj_setupSync_model, SessionController.ConnectionString);
            arrayList = ConvertDataSetToArrayList(ds);
            if (ViewState["SelectedSpaceID"] == null)
            {
                ViewState["SelectedSpaceID"] = arrayList;
            }
            DataRow dr;
            int i = 0;
            //RgAssetType.Rebind();
            for (i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                dr = ds.Tables[0].Rows[i];
                Guid IDValue = (Guid)dr[0];
                foreach (GridDataItem item in RgSpaceType.Items)
                {
                    string omniClassID = item["pk_standard_detail_id"].Text.ToString();
                    if (omniClassID != null && omniClassID.Equals(IDValue.ToString()) == true)
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

    private void UpdatePreview()
    {
        try
        {
            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            Control previewControl = userContentHolder.FindControl("previewControl");
            Image imgSyncProfile = (Image)previewControl.FindControl("imgSpaceType");
            imgSyncProfile.Visible = true;

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
            RadTab assetType = tabStrip.FindTabByText("Map Integration");
            assetType.Enabled = true;
            assetType.Selected = true;
            //RadMultiPage multiPage = (RadMultiPage)userContentHolder.FindControl("rmpageSetupSync");
            //RadPageView assetTypePageView = multiPage.FindPageViewByID("scheduler");
            //assetTypePageView.Selected = true;
            GoToNextPageView();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void GoToNextPageView()
    {
        try
        {
            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            RadMultiPage multiPage = (RadMultiPage)userContentHolder.FindControl("rmpageSetupSync");
            RadPageView SchedulerPageView = multiPage.FindPageViewByID(@"~/App/UserControls/" + "MapIntegration");
            if (SchedulerPageView == null)
            {
                SchedulerPageView = new RadPageView();
                SchedulerPageView.ID = @"~/App/UserControls/" + "MapIntegration";

                multiPage.PageViews.Add(SchedulerPageView);
            }
            SchedulerPageView.Selected = true;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void BindSpaceGrid()
    {
        SetupSyncClient obj_setupSync_client = new SetupSyncClient();
        SetupSyncModel obj_setupSync_model = new SetupSyncModel();
        DataSet ds = new DataSet();
        try
        {
            obj_setupSync_model.Search_value = txtSearch.Text.Trim();
            ds = obj_setupSync_client.Get_mapping_space_type_details(obj_setupSync_model, SessionController.ConnectionString);
            RgSpaceType.DataSource = ds;
            RgSpaceType.DataBind();

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void nextButton_Click(object sender, EventArgs e)
    {
        try
        {
            string id = "";
            string name = "";

            GetSelectedRows();
            ArrayList omniClass_list = (ArrayList)ViewState["SelectedSpaceID"];
            if (omniClass_list.Count > 0)
            {
                for (int i = 0; i < omniClass_list.Count; i++)
                {
                    id = id + omniClass_list[i].ToString() + ",";

                }
                id = id.Substring(0, id.Length - 1);
            }
            ViewState["SelectedSpaceID"] = omniClass_list;
            //if (RgAssetType.SelectedItems.Count > 0)
            //{
            //    for (int i = 0; i < RgAssetType.SelectedItems.Count; i++)
            //    {
            //        id = id + RgAssetType.SelectedItems[i].Cells[2].Text + ",";
            //        name = name + RgAssetType.SelectedItems[i].Cells[4].Text + ",";

            //    }
            //    id = id.Substring(0, id.Length - 1);
            //    name = name.Substring(0, name.Length - 1);
            //    name = name.Replace("'", "#");

            //}

            if (Request.QueryString["pk_external_system_configuration_id"] != Guid.Empty.ToString())
            {
                Update_selected_OmniClasses_space(name, id);
                //Insert_selected_facility(name, id);
            }
            else
            {
                Insert_Selected_OmniClasses_space(name, id);

            }
            UpdatePreview();

            GoToNextTab();
        }
        catch (Exception ex)
        {
            //Response.Write("<script>alert('" + Server.HtmlEncode(ex.ToString()) + "')</script>");
            throw ex;
        }

    }

    private void Update_selected_OmniClasses_space(string name, string id)
    {
        SetupSyncClient obj_setupSync_client = new SetupSyncClient();
        SetupSyncModel obj_setupSync_model = new SetupSyncModel();

        try
        {
            //obj_setupSync_model.Table_name = "tbl_external_system_omniclass_space_linkup";
            //obj_setupSync_model.External_system_configuration_id = new Guid(SessionController.Users_.Configuration_id);
            //obj_setupSync_model.Created_by_user_id = new Guid(SessionController.Users_.UserId);
            //obj_setupSync_model.Ecodomus_system_data_id = id.ToString();
            //obj_setupSync_client.Update_mapped_omniClass_space_details(obj_setupSync_model, SessionController.ConnectionString);

            obj_setupSync_model.Table_name = "tbl_external_system_omniclass_space_linkup";
            obj_setupSync_model.External_system_configuration_id = new Guid(SessionController.Users_.Configuration_id);
            obj_setupSync_model.Created_by_user_id = new Guid(SessionController.Users_.UserId);
            obj_setupSync_model.Ecodomus_system_data_id = id.ToString();
            obj_setupSync_client.Update_mapped_omniClass_entity_data(obj_setupSync_model, SessionController.ConnectionString);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void Insert_Selected_OmniClasses_space(string name, string id)
    {
        SetupSyncClient obj_setupSync_client = new SetupSyncClient();
        SetupSyncModel obj_setupSync_model = new SetupSyncModel();
        try
        {
            obj_setupSync_model.Table_name = "tbl_external_system_omniclass_space_linkup";
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            Fill_Grid_Mapped_Spaces(new Guid(Request.QueryString["pk_external_system_configuration_id"]));
            // BindOmniClassGrid();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void RgSpaceType_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {

            GetSelectedRows();
            BindSpaceGrid();
            //if (Request.QueryString["pk_external_system_configuration_id"].ToString() != Guid.Empty.ToString())
            //{
            //    //BindOmniClassGrid();
            //    Fill_Grid_Mapped_OmniClass(new Guid(Request.QueryString["pk_external_system_configuration_id"]));

            //}
            //else
            //{
            //    GetSelectedRows();
            //    BindOmniClassGrid();
            //}

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

            foreach (GridDataItem item in RgSpaceType.Items)
            {
                string strIndex = RgSpaceType.MasterTableView.CurrentPageIndex.ToString();
                string standard_id = item["pk_standard_detail_id"].Text;

                if (item.Selected)
                {
                    if (!arrayList.Contains(standard_id.ToString()))
                    {
                        arrayList.Add(standard_id.ToString());
                    }
                }
                else
                {
                    if (arrayList.Contains(standard_id.ToString()))
                    {
                        arrayList.Remove(standard_id.ToString());
                    }
                }
            }

            ViewState["SelectedSpaceID"] = arrayList;
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
                alist.Add(dtRow["pk_standard_detail_id"].ToString());
            }

            return alist;

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
            if (ViewState["SelectedSpaceID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedSpaceID"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void RgSpaceType_DataBound(object sender, EventArgs e)
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

    protected void ReSelectedRows()
    {
        try
        {
            foreach (GridDataItem item in RgSpaceType.Items)
            {
                string CustomerID = item["pk_standard_detail_id"].Text;
                if (arrayList.Contains(CustomerID.ToString()))
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

    protected void RgSpaceType_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindSpaceGrid();
            //Fill_Grid_Mapped_OmniClass(new Guid(Request.QueryString["pk_external_system_configuration_id"]));
            //BindOmniClassGrid();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void RgSpaceType_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        try
        {
            Fill_Grid_Mapped_Spaces(new Guid(Request.QueryString["pk_external_system_configuration_id"]));
            //BindOmniClassGrid();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
}