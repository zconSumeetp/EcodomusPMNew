using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using EcoDomus.Session;
using Telerik.Web.UI;
using System;
using Asset;
using System.Threading;
using System.Globalization;
using BIMModel;
using System.Collections.Generic;
using System.Collections;

public partial class App_Settings_facilityassets : System.Web.UI.Page
{

    public System.Collections.ArrayList arrayList = new ArrayList();
    List<String> ls = new List<string>();
    int TotalItemCount;

    #region Page events

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)  
        {
            //hdnfacility.Value = SessionController.Users_.facilityID.ToString();
            //hfid.Value = Request.QueryString["id"].ToString();
            //hfentityname.Value = Request.QueryString["name"].ToString();
            //////

            ViewState["SelectedassetID"] = null;
            ViewState["PageSize"] = 10;
            ViewState["PageIndex"] = 0;
            ViewState["SortExpression"] = "asset_name";


            ///////
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "asset_name";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            //Add sort expression, which will sort against first column
            rg_asset.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
            BindAssets();

        } 
        else
        {

            ViewState["SelectedassetID"] = null;
            //ViewState["PageSize"] = 10;
            ViewState["PageIndex"] = 0;
            ViewState["SortExpression"] = "asset_name";
        }

    }

    #endregion


    #region Private Methods

    private void BindAssets()
    {

        //rg_asset_OnNeedDataSource(null, null); // by pratik on 2/6/2014 for search link data for component
        //BindComponent_view_state();

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

    public void BindComponent_view_state()
    {
        try
        {
            //rg_asset.DataSource = (DataSet)ViewState["comp_Dataset"];
           // rg_asset.DataBind();
            rg_asset.Rebind();
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


            foreach (GridDataItem item in rg_asset.Items)
            {
                string strIndex = rg_asset.MasterTableView.CurrentPageIndex.ToString();
                // string comp_id = item.GetDataKeyValue("Assetid").ToString();
                string comp_id = item["pk_asset_id"].Text;

                if (item.Selected)
                {
                    if (!arrayList.Contains(comp_id.ToString()))
                    {
                        arrayList.Add(comp_id.ToString());
                    }
                }
                else
                {
                    if (arrayList.Contains(comp_id.ToString()))
                    {
                        arrayList.Remove(comp_id.ToString());
                    }
                }
            }

            ViewState["SelectedassetID"] = arrayList;
            ArrayList comp_list = (ArrayList)ViewState["SelectedassetID"];
            string id = "";
            if (comp_list.Count > 0)
            {
                for (int i = 0; i < comp_list.Count; i++)
                {
                    id = id + comp_list[i].ToString() + ",";

                }
                id = id.Substring(0, id.Length - 1);
                hf_asset_id.Value = id;

            }
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
            foreach (GridDataItem item in rg_asset.Items)
            {
                string systems_id = Convert.ToString(item.GetDataKeyValue("pk_asset_id"));//item["Assetid"].Text;

                if (arrayList.Contains(systems_id.ToString()))
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
    protected void SessionToArrayList()
    {
        try
        {
            if (ViewState["SelectedassetID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedassetID"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    #endregion


    #region Grid Events



    protected void rg_component_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();

            if (e.NewPageSize != 10 && e.NewPageSize != 20 && e.NewPageSize != 50)
            {
                ViewState["PageSize"] = 0;
                ViewState["PageIndex"] = 0;

            }
            else
            {
                ViewState["PageSize"] = e.NewPageSize;
                int compo_count = Int32.Parse(ViewState["ComponentCount"].ToString());
                int page_size = Int32.Parse(ViewState["PageSize"].ToString());
                int page_index = Int32.Parse(ViewState["PageIndex"].ToString());
                int maxpg_index = (compo_count / page_size) + 1;
                if (page_index >= maxpg_index)
                {
                    ViewState["PageIndex"] = 0;
                }

            }

            BindComponent_view_state();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rg_component_SortCommand(object source, GridSortCommandEventArgs e)
    {
        GetSelectedRows();
        ViewState["SortExpression"] = e.SortExpression;
        if (e.NewSortOrder.ToString() == "Descending")
        {
            ViewState["SortExpression"] = ViewState["SortExpression"].ToString() + " DESC";
        }
        BindComponent_view_state();
    }

    protected void rg_component_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            ViewState["PageIndex"] = e.NewPageIndex;
            BindAssets();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void cmbcriteria_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        BindAssets();

    }

    protected void rgassets_OnItemEvent(object sender, GridItemEventArgs e)
    {

        if (e.EventInfo is GridInitializePagerItem)
        {

            TotalItemCount = (e.EventInfo as GridInitializePagerItem).PagingManager.DataSourceCount;

        }
        hf_count.Value = TotalItemCount.ToString();

    }

    protected void rgassetd_OnItemDataBound(object sender, GridItemEventArgs e)
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



    #endregion


    #region Event Handlers


    protected void btnSelect_Click(Object sender, EventArgs e)
    {
        string id = "";

        try
        {
            if (rg_asset.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {

                id = Convert.ToString(rg_asset.SelectedValue);

                DataSet ds = new DataSet();
                BIMModelClient objbim_Client = new BIMModelClient();
                BIMModels objbim_Model = new BIMModels();

                objbim_Model.Asset_id = new Guid(id);
                objbim_Model.External_asset_id = Convert.ToString(Request.QueryString["element_numeric_id"]);
                objbim_Model.File_id = new Guid(Convert.ToString(Request.QueryString["file_id"]));
                objbim_Model.User_id = new Guid(SessionController.Users_.UserId);
                //objbim_Client.proc_assign_asset_for_bim(objbim_Model, SessionController.ConnectionString);

                switch (radcombo_asset_status.SelectedValue)
                {

                    case "Overwrite":
                        objbim_Client.proc_assign_asset_for_bim(objbim_Model, SessionController.ConnectionString);
                        ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>closeWindow()</script>");
                        break;

                    case "Existing":
                        if (Request.QueryString["properties"] != "no property")
                        {
                            objbim_Client.proc_replace_asset_for_model(objbim_Model, SessionController.ConnectionString);
                            ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>closeWindow()</script>");
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "merge", "existattributealert();", true);
                        }
                        break;

                    case "Merge":
                        if (Request.QueryString["properties"] != "no property")
                        {
                            objbim_Client.proc_merge_type_attribute(objbim_Model, SessionController.ConnectionString);
                            objbim_Client.proc_merge_asset_attribute(objbim_Model, SessionController.ConnectionString);
                            ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>closeWindow()</script>");
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "merge", "mergeattributealert();", true);
                        }
                        break;

                }

                ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>closeWindow()</script>");
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        rg_asset.Rebind();

    }

    protected void rg_asset_OnNeedDataSource(object sender, EventArgs e)
    {
        var ds = new DataSet();
        var bimModelClient = new BIMModelClient();
        var bimModels = new BIMModels();

        var ds_ComponentCount = new DataSet();
        var objlocMdl = new BIMModels();
        var objlocCrtl = new BIMModelClient();


        objlocMdl.Fk_facility_id = new Guid(Request.QueryString["facility_id"]);
        objlocMdl.Search_text = txtClass.Text.Trim();
        objlocMdl.Search_criteria = cmbcriteria.SelectedItem.Text;
        ds_ComponentCount = objlocCrtl.proc_get_facility_assets_for_bim_count_v1(objlocMdl, SessionController.ConnectionString);
        rg_asset.VirtualItemCount = Int32.Parse(ds_ComponentCount.Tables[0].Rows[0]["Cnt"].ToString());
        ViewState["ComponentCount"] = Int32.Parse(ds_ComponentCount.Tables[0].Rows[0]["Cnt"].ToString());


        bimModels.Fk_facility_id = new Guid(Request.QueryString["facility_id"]);
        bimModels.Search_text = txtClass.Text.Trim();
        bimModels.Search_criteria = cmbcriteria.SelectedItem.Text;
        bimModels.Pagesize = Int32.Parse(ViewState["PageSize"].ToString());

        bimModels.Pageindex = Int32.Parse(ViewState["PageIndex"].ToString());
        bimModels.Orderby = ViewState["SortExpression"].ToString();

        ds = bimModelClient.proc_get_facility_assets_for_bim(bimModels, SessionController.ConnectionString);


        rg_asset.MasterTableView.DataSource = ds;
       

        ViewState["comp_Dataset"] = ds;
    }

    protected void radcombo_asset_status_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {

    }
    #endregion
}