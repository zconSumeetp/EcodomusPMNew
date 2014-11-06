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

public partial class App_Asset_AssignAsset : System.Web.UI.Page
{
    #region Page events

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //hdnfacility.Value = SessionController.Users_.facilityID.ToString();
            hfid.Value = Request.QueryString["id"].ToString();
            hfentityname.Value = Request.QueryString["name"].ToString();
             
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "AssetName";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            //Add sort expression, which will sort against first column
            rg_asset.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

            ViewState["PageSize"] = 10;
            ViewState["PageIndex"] = 0;
            ViewState["SortExpression"] = "AssetName";
            Bindgrid();

        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_height();", true);

    }

    #endregion


    #region Private Methods

    private void Bindgrid()
    {
        if (hfentityname.Value == "system")
        {
             BindAssets();
        }
        else if (hfentityname.Value == "Space")
        {
            BindAssetsforspace();

        }
        else if (hfentityname.Value == "type")
        {
            BindAssetsfortype();
        }
    }

    private void BindAssets()
    {
        //--To get the facility id/s of the current system------------------------
        string fac_ids = "";
        Systems.SystemsModel objSystemsModel = new Systems.SystemsModel();
        Systems.SystemsClient objSystemsClient = new Systems.SystemsClient();
        DataSet ds_system = new DataSet();
        
        objSystemsModel.SystemId = new Guid(hfid.Value);

        ds_system = objSystemsClient.GetSystemProfile(objSystemsModel, SessionController.ConnectionString);
        if (ds_system.Tables[0].Rows.Count > 0)
        {
             fac_ids = ds_system.Tables[0].Rows[0]["pk_facility_id"].ToString();
        }
        //------------------------------------------------------------------------

        DataSet ds = new DataSet();
        DataSet ds_ComponentforsystemCount = new DataSet();
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();


        IssueModel.Description = fac_ids; // Description variable from model class is used to pass facility ids
        IssueModel.Fk_system_id = new Guid(hfid.Value);
        IssueModel.Search_text = txt_search.Text.Trim().Replace("'", "''"); 

        //---------------------------added to bind only 10 components at a time----------------------------------------------------------

        ds_ComponentforsystemCount = IssueClient.Get_assets_for_system_Count(SessionController.ConnectionString, IssueModel);
        rg_asset.VirtualItemCount = Int32.Parse(ds_ComponentforsystemCount.Tables[0].Rows[0]["Cnt"].ToString());
        ViewState["ComponentCount"] = Int32.Parse(ds_ComponentforsystemCount.Tables[0].Rows[0]["Cnt"].ToString());

        IssueModel.Pagesize = Int32.Parse(ViewState["PageSize"].ToString());

        IssueModel.Pageindex = Int32.Parse(ViewState["PageIndex"].ToString());
        IssueModel.Orderby = ViewState["SortExpression"].ToString();
        //-------------------------------------------------------------------------------------------------------------------------------------------

        ds = IssueClient.GetFacilityAssets_PM(IssueModel, SessionController.ConnectionString);

        rg_asset.DataSource = ds;
        rg_asset.DataBind();

        //ViewState["comp_Dataset"] = ds;


    }

    private void BindAssetsforspace()
    {   
       
        DataSet ds = new DataSet();
        DataSet ds_ComponentforspaceCount = new DataSet();
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();

        IssueModel.Project_ID = new Guid(SessionController.Users_.ProjectId);
        IssueModel.Fk_system_id = new Guid(hfid.Value);
        IssueModel.Search_text = txt_search.Text.Trim().Replace("'", "''"); 

        //---------------------------added to bind only 10 components at a time----------------------------------------------------------

        ds_ComponentforspaceCount = IssueClient.Get_assets_for_space_Count(SessionController.ConnectionString, IssueModel);
        rg_asset.VirtualItemCount = Int32.Parse(ds_ComponentforspaceCount.Tables[0].Rows[0]["Cnt"].ToString());
        ViewState["ComponentCount"] = Int32.Parse(ds_ComponentforspaceCount.Tables[0].Rows[0]["Cnt"].ToString());

        IssueModel.Pagesize = Int32.Parse(ViewState["PageSize"].ToString());

        IssueModel.Pageindex = Int32.Parse(ViewState["PageIndex"].ToString());
        IssueModel.Orderby = ViewState["SortExpression"].ToString();
        //-------------------------------------------------------------------------------------------------------------------------------------------

        ds = IssueClient.GetFacilityAssetsForSpace_PM(IssueModel, SessionController.ConnectionString);

        rg_asset.DataSource = ds;
        rg_asset.DataBind();

       // ViewState["comp_Dataset"] = ds;


    }
    private void BindAssetsfortype()
    {
        try
        {
            //------------------------------------------------------------------------
            string fac_ids = "";
            DataSet ds = new DataSet();
            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
            TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
            mdl.Type_Id = new Guid(hfid.Value);
            mdl.ClientId = new Guid(SessionController.Users_.ClientID);
            mdl.Organization_Id = new Guid(SessionController.Users_.OrganizationID);
            mdl.User_id = new Guid(SessionController.Users_.UserId);
            mdl.System_Role = SessionController.Users_.UserSystemRole;
            ds = TypeClient.GetFaciliyListForType(mdl, SessionController.ConnectionString);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                fac_ids = fac_ids + ds.Tables[0].Rows[i]["facility_id"].ToString() + ",";
            }
            string facility_ids = fac_ids.Substring(0, fac_ids.Length - 1);

            TypeProfile.TypeModel md = new TypeProfile.TypeModel();
            DataSet ds_type = new DataSet();
            DataSet ds_ComponentfortypeCount = new DataSet();

            md.Type_Id = new Guid(hfid.Value);
            md.Facility_Ids = facility_ids;
            md.Txt_Search = txt_search.Text.Trim().Replace("'", "''"); 

            //---------------------------added to bind only 10 components at a time----------------------------------------------------------

            ds_ComponentfortypeCount = TypeClient.Get_assets_for_type_Count(SessionController.ConnectionString, md);
            rg_asset.VirtualItemCount = Int32.Parse(ds_ComponentfortypeCount.Tables[0].Rows[0]["Cnt"].ToString());
            ViewState["ComponentCount"] = Int32.Parse(ds_ComponentfortypeCount.Tables[0].Rows[0]["Cnt"].ToString());

            md.Pagesize = Int32.Parse(ViewState["PageSize"].ToString());

            md.Pageindex = Int32.Parse(ViewState["PageIndex"].ToString());
            md.Orderby = ViewState["SortExpression"].ToString();
            //-------------------------------------------------------------------------------------------------------------------------------------------

            ds_type = TypeClient.GetAssetTypePM(md, SessionController.ConnectionString);

            rg_asset.DataSource = ds_type;
            rg_asset.DataBind();

            //ViewState["comp_Dataset"] = ds_type;
        }
        catch (Exception ex)
        {

            throw ex;
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

    //public void BindComponent_view_state()
    //{
    //    try
    //    {
    //        rg_asset.DataSource = (DataSet)ViewState["comp_Dataset"];
    //        rg_asset.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    #endregion


    #region Grid Events



    protected void rg_component_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            //BindComponent_view_state();
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
            Bindgrid();
        }
        catch (Exception ex)
        {
            Response.Write("rg_component_PageSizeChanged :" + ex.Message.ToString());
        }
    }

    protected void rg_component_SortCommand(object source, GridSortCommandEventArgs e)
    {
        try
        {
            //BindComponent_view_state();
            ViewState["SortExpression"] = e.SortExpression;
            if (e.NewSortOrder.ToString() == "Descending")
            {
                ViewState["SortExpression"] = ViewState["SortExpression"].ToString() + " DESC";
            }
            Bindgrid();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rg_component_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        try
        {
            //BindComponent_view_state();
            ViewState["PageIndex"] = e.NewPageIndex;
            Bindgrid();
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
        string id = "", name = "", type_name = "";

        try
        {
            if (rg_asset.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                for (int i = 0; i < rg_asset.SelectedItems.Count; i++)
                {
                    id = id + rg_asset.SelectedItems[i].Cells[2].Text + ",";
                    name = name + rg_asset.SelectedItems[i].Cells[4].Text + ",";
                    type_name = type_name + rg_asset.SelectedItems[i].Cells[5].Text + ",";
                }
                id = id.Substring(0, id.Length - 1);
                name = name.Substring(0, name.Length - 1);
                type_name = type_name.Substring(0, type_name.Length - 1);
                type_name = type_name.Replace("'", "single");
                name = name.Replace("'", "single");

                DataSet ds = new DataSet();
                AssetClient objAsset_Client = new AssetClient();
                AssetModel objAsset_Model = new AssetModel();

                objAsset_Model.EntityName = (hfentityname.Value).ToString();
                objAsset_Model.Type_id = new Guid(hfid.Value);
                objAsset_Model.Name = id; //comma seperated asset ids

                objAsset_Client.Assign_Assets_for_entity(objAsset_Model, SessionController.ConnectionString);
                //ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>select_Sub_System('" + id + "','" + name + "','" + type_name + "')</script>");
                ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>closeWindow12()</script>");
               // ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "closeWindow12();", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>assignAsset()</script>");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ViewState["PageIndex"] = 0;
        ViewState["PageSize"] = 10;
        Bindgrid();
    }

    #endregion
}