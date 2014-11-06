using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using Asset ;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;


public partial class App_Asset_AssignSystem : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try 
        {
                
            if (SessionController.Users_.UserId != null)
               {
                   if (!IsPostBack)
                   {
                       GridSortExpression sortExpr = new GridSortExpression();
                       sortExpr.FieldName = "name";
                       sortExpr.SortOrder = GridSortOrder.Ascending;
                       //Add sort expression, which will sort against first column
                       rg_System.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                       if (SessionController.Users_.is_PM_FM == "FM")
                       {
                           bind_data();
                       }
                       if (SessionController.Users_.is_PM_FM == "PM")
                       {
                           bind_data_for_project();
                       }
                       
                   }       
    
               }
                
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void bind_data()
    {
        try
        {

            AssetClient locobj_crtl = new AssetClient();
            AssetModel locobj_mdl = new AssetModel();
            DataSet ds_System = new DataSet();

            //locobj_mdl.Entity_name = Request.QueryString["Item_type"].ToString();
            locobj_mdl.CriteriaText  = txtSearch.Text;
            locobj_mdl.Fk_facility_id = new Guid(SessionController.Users_.facilityID);
            locobj_mdl.Asset_id = new Guid(SessionController.Users_.AssetId);
            ds_System = locobj_crtl.get_systems_for_facility(locobj_mdl, SessionController.ConnectionString);

            if (ds_System.Tables.Count > 0)
            {
                rg_System.DataSource = ds_System;
                rg_System.DataBind();
            }


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void bind_data_for_project()
    {
        try
        {

            AssetClient locobj_crtl = new AssetClient();
            AssetModel locobj_mdl = new AssetModel();
            DataSet ds_System = new DataSet();

            //locobj_mdl.Entity_name = Request.QueryString["Item_type"].ToString();
            locobj_mdl.CriteriaText = txtSearch.Text;
            locobj_mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
            locobj_mdl.Asset_id = new Guid(SessionController.Users_.AssetId);
            ds_System = locobj_crtl.get_systems_for_facility_under_project(locobj_mdl, SessionController.ConnectionString);

            if (ds_System.Tables.Count > 0)
            {
                rg_System.DataSource = ds_System;
                rg_System.DataBind();
            }


        }
        catch (Exception ex)
        {
            Response.Write("Page_Load:- " + ex.Message.ToString());
        }
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        bind_data_for_project();
    }

    protected void rg_system_OnItemDataBound(object sender, GridItemEventArgs e)
    { 
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            RadioButton radbtn = (RadioButton)item.FindControl("rd_check_btn");
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

    protected void btn_select_click(Object sender, EventArgs e)
    {
        string id = "", name = "";
        try
        {
            if (rg_System.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                for (int i = 0; i < rg_System.SelectedItems.Count; i++)
                {
                    id = id + rg_System.SelectedItems[i].Cells[2].Text + ",";
                    name = name + rg_System.SelectedItems[i].Cells[4].Text + ",";
                }
                id = id.Substring(0, id.Length - 1);
                name = name.Substring(0, name.Length - 1);

                AssetClient locobj_crtl = new AssetClient();
                AssetModel locobj_mdl = new AssetModel();

                locobj_mdl.Asset_id = new Guid(SessionController.Users_.AssetId);
                locobj_mdl.System_id = id;
                locobj_crtl.assign_systems_to_asset(locobj_mdl, SessionController.ConnectionString);
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>closeWindow()</script>", false);
                //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_Sub_System('" + id + "','" + name + "')</script>", false);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>assignomniclass();</script>", false);
            }
        }

        catch (Exception ex)
        {
            Response.Write("btnSelect_Click:-" + ex.Message);
        }
    }
}