using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using Telerik.Web.UI;
using WorkOrder;
using System.Data.SqlClient;
using System.Data;
using System.Threading;
using System.Globalization;

public partial class App_Asset_FindWorkOrder : System.Web.UI.Page
{
   
    string fk_asset_id="";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["assetid"] != null)
        {
            fk_asset_id = Request.QueryString["assetid"].ToString();
        }
        else
        {
            fk_asset_id = "";
        }        
        hf_asset_id.Value = fk_asset_id;
        if (!IsPostBack)
        {
            //if (Request.QueryString["assetid"] != null)
            //{
            //    fk_asset_id = Request.QueryString["assetid"].ToString();
            //}
            //else
            //{
            //    fk_asset_id = "";
            //}
            ////fk_asset_id = "A5B797CA-B781-4740-A9C9-6599DE3CF986";
            //hf_asset_id.Value = fk_asset_id;
            WorkOrderModel wm = new WorkOrderModel();
            WorkOrderClient wc = new WorkOrderClient();
            DataSet ds = new DataSet();
            wm.Fk_Asset_Id = hf_asset_id.Value.ToString();
            ds = wc.GetAssetName(wm, SessionController.ConnectionString);
            //lbl_asset_value.Text = ds.Tables[0].Rows[0]["name"].ToString();
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "work_order_number";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            //Add sort expression, which will sort against first column
            rg_work_order.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
            bind_work_order(fk_asset_id.ToString());
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
    protected void bind_work_order(string asset_id)
    {
        WorkOrderModel wm = new WorkOrderModel();
        WorkOrderClient wc = new WorkOrderClient();
        DataSet ds = new DataSet();
        try
        {
            if (cmb_category.SelectedValue.ToString() == "Name")
            {
                wm.Fk_Asset_Id = fk_asset_id.ToString();
                wm.Criteria = "number";
                wm.Search = txt_search.Text;
                ds = wc.GetWorkOrder_Entity(wm, SessionController.ConnectionString);
                rg_work_order.DataSource = ds;
                rg_work_order.DataBind();                
            }
            else
            {
                wm.Fk_Asset_Id = fk_asset_id.ToString();
                wm.Criteria = "Desc";
                wm.Search = txt_search.Text;
                ds = wc.GetWorkOrder_Entity(wm, SessionController.ConnectionString);
                rg_work_order.DataSource = ds;
                rg_work_order.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void rg_work_order_OnPageIndexChanged(object source,GridPageChangedEventArgs e)
    {
        try
        {
            bind_work_order(fk_asset_id);
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }

    protected void rg_work_order_OnPageSizeChanged(object source,GridPageSizeChangedEventArgs e)
    {
        try
        {
            bind_work_order(fk_asset_id);
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }

    protected void rg_work_order_OnSortCommand(object source,GridSortCommandEventArgs e)
    {
        try
        {
            bind_work_order(fk_asset_id);
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
        


    protected void btn_Search_Click(object sender,EventArgs e)
    {
        bind_work_order(fk_asset_id);
    }



    protected void btn_add_Click(object sender, EventArgs e)
    {
        //Response.Redirect("~/app/Asset/WorkOrderProfile.aspx", false);
        Response.Redirect("~/app/Asset/WorkOrderProfile.aspx?asset_id=" + fk_asset_id, false);
    }

    protected void btn_Clear_Click(object sender,EventArgs e)
    {
        txt_search.Text = "";

    }


    protected void rg_work_order_ItemCommand(object source,Telerik.Web.UI.GridCommandEventArgs e)
    {
        Guid  work_order_id ;
        WorkOrderModel wm = new WorkOrderModel();
        WorkOrderClient wc = new WorkOrderClient();
        if (e.CommandName == "Edit_")
        {
            LinkButton lnk_work_order_name = e.Item.FindControl("linkWorkOrderName") as LinkButton;
            work_order_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_work_order_id"].ToString());
            this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "myUniqueKey",
                       "self.parent.location='../asset/workorderprofile.aspx?Work_order_id=" + work_order_id + "';", true);
            //Response.Redirect("~/App/Asset/WorkOrderProfile.aspx?Work_order_id=" + work_order_id, false);
        }
        else if (e.CommandName == "Delete")            
        {
                work_order_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_work_order_id"].ToString());
                wm.PK_Work_Order_Id = work_order_id.ToString();
                wc.DeleteWorkOrder(wm, SessionController.ConnectionString);
                bind_work_order(fk_asset_id);            
        }      
    }
}