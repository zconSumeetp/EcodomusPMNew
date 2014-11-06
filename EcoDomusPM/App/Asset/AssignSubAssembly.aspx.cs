using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Asset;
using System.Data;
using EcoDomus.Session;
using System.Globalization;
using System.Threading;

public partial class App_Asset_AssignSubAssembly : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {

                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "asset_name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                rg_subassembly.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                BindSubAssembly();
            }
        }
        else
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);

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
    protected void rg_subassembly_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
        {
        BindSubAssembly();
        }
    protected void rg_subassembly_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
        {
        BindSubAssembly();
        }
    protected void rg_subassembly_ItemCommand(object sender, GridCommandEventArgs e)
        {
        BindSubAssembly();
        }
    protected void rg_subassembly_OnSortCommand(object sender, GridSortCommandEventArgs e)
        {
        BindSubAssembly();
        }
    public void BindSubAssembly()
        {

        try
            {
            AssetModel Asset_Model = new AssetModel();
            AssetClient Asset_Client = new AssetClient();
            DataSet ds = new DataSet();
            Asset_Model.Asset_id = new Guid(Request.QueryString["asset_id"].ToString());
            Asset_Model.Fk_facility_id = new Guid(Request.QueryString["facility_id"].ToString());
            Asset_Model.Search_Text = txt_search.Text;
            ds = Asset_Client.GetUnassignSubAssembly(SessionController.ConnectionString, Asset_Model);
            rg_subassembly.DataSource = ds;
            rg_subassembly.DataBind();
            }
        catch (Exception ex)
            {

            throw ex;
            }


        }
    protected void btn_Search(object sender, EventArgs e)
        {
        BindSubAssembly();
        }

    protected void btn_refresh_Click(object sender, EventArgs e)
        {
        BindSubAssembly();
        }
    protected void btn_Assign_Sub_Assembly_Click(object sender, EventArgs e)
        {
        try
            {
            AssetModel Asset_Model = new AssetModel();
            AssetClient Asset_Client = new AssetClient();
            DataSet ds = new DataSet();
            Asset_Model.Asset_id =new Guid(Request.QueryString["asset_id"].ToString());
            Asset_Model.Fk_Assembly_ids = hfrow_ids.Value;
            Asset_Client.AssignSubAssemblyToComponent(SessionController.ConnectionString, Asset_Model);
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>refreshParent();</script>", false);
            }
        catch (Exception ex)
            {
            
            throw ex;
            }
        
        
        }
}