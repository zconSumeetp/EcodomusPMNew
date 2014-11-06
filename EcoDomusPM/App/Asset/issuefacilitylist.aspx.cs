using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;
using Issue;


public partial class App_Asset_issuefacilitylist : System.Web.UI.Page
{

    #region Page events

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "AssetName";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            string project_id = SessionController.Users_.ProjectId.ToString();
            //Add sort expression, which will sort against first column
            rg_asset.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

            ViewState["PageSize"] = 10;
            ViewState["PageIndex"] = 0;
            ViewState["SortExpression"] = "AssetName";
            BindAssets();
        
        }

    }

    #endregion

     
   

    #region Private Methods

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


    private void BindAssets()
    {

        DataSet ds = new DataSet();
        DataSet ds_ComponentCount = new DataSet();
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();
        
   
        IssueModel.UserId = new Guid(SessionController.Users_.UserId);
        IssueModel.ClientId = new Guid(SessionController.Users_.ClientID);
        IssueModel.System_role = SessionController.Users_.UserSystemRole.ToString();
        IssueModel.Search_text = txtClass.Text.Trim().Replace("'", "''"); 
        IssueModel.Project_ID = new Guid(SessionController.Users_.ProjectId);

        //---------------------------added to bind only 10 components at a time----------------------------------------------------------
        ds_ComponentCount = IssueClient.Get_assets_for_workorder_Count(SessionController.ConnectionString, IssueModel);
        rg_asset.VirtualItemCount = Int32.Parse(ds_ComponentCount.Tables[0].Rows[0]["Cnt"].ToString());
        ViewState["ComponentCount"] = Int32.Parse(ds_ComponentCount.Tables[0].Rows[0]["Cnt"].ToString());

        IssueModel.Pagesize = Int32.Parse(ViewState["PageSize"].ToString());

        IssueModel.Pageindex = Int32.Parse(ViewState["PageIndex"].ToString());
        IssueModel.Orderby = ViewState["SortExpression"].ToString();
        //-------------------------------------------------------------------------------------------------------------------------------------------

        ds = IssueClient.GetFacilityAssetsPM(IssueModel, SessionController.ConnectionString);

        rg_asset.DataSource = ds;
        rg_asset.DataBind();

        //ViewState["comp_Dataset"] = ds;

    
    }


    public void BindComponent_view_state()
    {
        try
        {
            rg_asset.DataSource = (DataSet)ViewState["comp_Dataset"];
            rg_asset.DataBind();
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
            BindAssets();
            //BindComponent_view_state();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rg_component_SortCommand(object source, GridSortCommandEventArgs e)
    {
        try
        {
            ViewState["SortExpression"] = e.SortExpression;
            if (e.NewSortOrder.ToString() == "Descending")
            {
                ViewState["SortExpression"] = ViewState["SortExpression"].ToString() + " DESC";
            }
            BindAssets();
            //BindComponent_view_state();
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
            ViewState["PageIndex"] = e.NewPageIndex;
            BindAssets();
            //BindComponent_view_state();
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
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_Sub_System('" + id + "','" + name + "','" + type_name +  "')</script>", false);
                //this.Page.ClientScript.RegisterStartupScript(this.GetType(), "script", "assign_asset()", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>assign_asset();</script>", false);

               // if (!ClientScript.IsStartupScriptRegistered("alert"))
               // {
               //     ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Script", "<script language='javascript'>assign_asset();</script>;", true);
               // }
               ////ClientScript.RegisterStartupScript(this.GetType(), "script", "assign_asset()",true);
               // //ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>closewindow();</script>");
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
        BindAssets();
       
    }

    #endregion
    
}