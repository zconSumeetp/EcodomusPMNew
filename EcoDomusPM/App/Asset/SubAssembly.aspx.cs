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

public partial class App_Asset_SubAssembly : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["assetid"].ToString() != "")
                {

                    hfAsset_id.Value = Request.QueryString["assetid"].ToString();
                    if (Request.QueryString["facility_id"].ToString() != "")
                    {
                        hfFacility_id.Value = Request.QueryString["facility_id"].ToString();
                    }
                }

                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "linkasset";
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
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

    }

    protected void rg_subassembly_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        BindSubAssembly();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

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
            Asset_Model.Asset_id = new Guid(hfAsset_id.Value);
            Asset_Model.Search_Text = txt_search.Text;
            ds = Asset_Client.GetSubAssembly(SessionController.ConnectionString, Asset_Model);
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
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "resize_frame_page()", true);
    }

    protected void btn_Unassign_Click(object sender, EventArgs e)
    {
        try
        {
            AssetModel Asset_Model = new AssetModel();
            AssetClient Asset_Client = new AssetClient();
            DataSet ds = new DataSet();
            Asset_Model.Asset_id = new Guid(hfAsset_id.Value);
            Asset_Model.Fk_Assembly_ids = hfrow_ids.Value;
            Asset_Client.UnassignSubAssemblyFromComponent(SessionController.ConnectionString, Asset_Model);
            BindSubAssembly();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                btn_Assign_Sub_Assembly.Visible = false;
                btn_Unassign.Visible = false;

            }
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
            DataRow dr_component = ds_component.Tables[0].Select("name='Component'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Component Profile")
                {
                    SetPermissionToControl(dr_profile);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SetPermissionToControl(DataRow dr)
    {
        Permissions objPermission = new Permissions();
        string edit_permission = dr["edit_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();

        if (dr["name"].ToString() == "Component Profile")
        {
            objPermission.SetEditable(btn_Unassign, delete_permission);
            objPermission.SetEditable(btn_Assign_Sub_Assembly, edit_permission);

        }


    }

}