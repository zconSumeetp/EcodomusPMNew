using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Telerik.Web.UI;
using System.Collections.Generic;
using Locations;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;
using TypeProfile;

public partial class App_Locations_Omniclass : System.Web.UI.UserControl
{
    static string Item_type;

    string type_id = "";
    string ids = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["type_id"] != null)
        {
            string id = Request.QueryString["type_id"].ToString();
            id = id.Substring(0, id.Length - 1);
            string[] parameters = id.Split(',');
            foreach (string id1 in parameters)
            {
                type_id = type_id + id1 + ",";

            }
            ids = type_id.Substring(0, type_id.Length - 1);
            //if (parameters.Length >= 1)
            //{
            //    type_id = parameters[0];
            //}
            //else
            //{
            //    type_id = parameters[0];
            //}
            //type_id = id;//.Remove(id.ToString().Length - 1, 1);

        }
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "Category";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rg_omniclass.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                bind_data();
                ddlomniclass.Visible = false;
            }
        }
        RadTabStrip tabStrip = (RadTabStrip)Page.FindControl("RadTabStrip1");

    }



    protected void rg_omniclass_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            RadioButton radbtn = (RadioButton)item.FindControl("rd_check_btn");
        }

    }

    protected void rg_omniclass_NeedDataSource(object source, GridNeedDataSourceEventArgs e)
    {

    }

    //protected void btnSearch_OnClick(object sender, EventArgs e)
    //{
    //   // bind_data();
    //   // ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_height();", true);
    //    //  Page.ClientScript.RegisterStartupScript(GetType(), "manage_height", "adjust_height();", true);
    //}
    //protected void OnClick_BtnSearch(object sender, EventArgs e)
    //{

    //     bind_data();

    //}

    public void bind_data()
    {
        try
        {

            Product.ProductClient locobj_crtl = new Product.ProductClient();
            Product.ProductModel locobj_mdl = new Product.ProductModel();
            DataSet ds_category = new DataSet();

            locobj_mdl.Entity_name = "Type";
            locobj_mdl.Category = txt_search.Text;
            locobj_mdl.Standard_name = ddlomniclass.SelectedItem.Text;
            ds_category = locobj_crtl.GetOmniClasses(locobj_mdl);

            if (ds_category.Tables.Count > 0)
            {
                rg_omniclass.DataSource = ds_category;
                rg_omniclass.DataBind();
            }
            
        }
        catch (Exception ex)
        {
            Response.Write("Page_Load:- " + ex.Message.ToString());
        }
    }



    protected void rg_omniclass_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            bind_views_tate_data();

        }
        catch (Exception ex)
        {
            Response.Write("rgProjects_PageSizeChanged" + ex.Message.ToString());
        }
    }

    protected void rg_omniclass_SortCommand(object source, GridSortCommandEventArgs e)
    {
        try
        {
            bind_views_tate_data();
        }
        catch (Exception ex)
        {
            Response.Write("rgProjects_SortCommand" + ex.Message.ToString());
        }
    }

    protected void rg_omniclass_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        try
        {
            bind_views_tate_data();

        }
        catch (Exception ex)
        {
            Response.Write("rgProjects_PageIndexChanged" + ex.Message.ToString());
        }
    }

    public void bind_views_tate_data()
    {
        DataSet ds;
        ds = (DataSet)ViewState["dataset"];
        rg_omniclass.DataSource = ds;
        rg_omniclass.DataBind();
    }


    protected void btn_select_click(Object sender, EventArgs e)
    {

        string id = "", name = "";
        try
        {
            if (rg_omniclass.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                for (int i = 0; i < rg_omniclass.SelectedItems.Count; i++)
                {
                    id = id + rg_omniclass.SelectedItems[i].Cells[2].Text + ",";
                    name = name + rg_omniclass.SelectedItems[i].Cells[4].Text + ",";
                }
                id = id.Substring(0, id.Length - 1);
                name = name.Substring(0, name.Length - 1);

                if (!string.IsNullOrEmpty(ids))
                {
                    TypeModel tm = new TypeModel();
                    TypeProfileClient tc = new TypeProfileClient();
                    tm.Type_Ids = ids;
                    tm.Fk_Omniclass_Id = new Guid(id);
                    tc.UpdateOmniclassForTypePM(tm, SessionController.ConnectionString);

                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_Sub_System('" + id + "','" + name + "')</script>", false);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:refreshpage();", true);
                    //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_Sub_System('" + id + "','" + name + "')</script>", false);
                }
                else
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_Sub_System('" + id + "','" + name + "')</script>", false);
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

    public class PagerRadComboBoxItemComparer : IComparer<RadComboBoxItem>, IComparer
    {


        public int Compare(RadComboBoxItem x, RadComboBoxItem y)
        {

            int rValue = 0;
            int lValue = 0;

            if (Int32.TryParse(x.Value, out lValue) && Int32.TryParse(y.Value, out rValue))
            {
                return lValue.CompareTo(rValue);
            }
            else
            {
                return x.Value.CompareTo(y.Value);

            }
        }

        #region IComparer Members

        public int Compare(object x, object y)
        {
            return Compare((RadComboBoxItem)x, (RadComboBoxItem)y);
        }

        #endregion
    }

    //protected override void InitializeCulture()
    //{
    //    string culture = Session["Culture"].ToString();
    //    if (culture == null)
    //    {
    //        culture = "en-US";
    //    }
    //    Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
    //    Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
    //}
    int TotalItemCount;
    protected void rg_omniclass_OnItemEvent(object sender, GridItemEventArgs e)
    {

        if (e.EventInfo is GridInitializePagerItem)
        {

            TotalItemCount = (e.EventInfo as GridInitializePagerItem).PagingManager.DataSourceCount;

        }
        hfdscnt.Value = TotalItemCount.ToString();

    }
    protected void rg_omniclass_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridPagerItem)
        {
            RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
            cb.Items.Clear();
            RadComboBoxItem item = new RadComboBoxItem("10", "10");

            item.Attributes.Add("ownerTableViewId", rg_omniclass.MasterTableView.ClientID);

            if (cb.Items.FindItemByValue("10") == null)
                cb.Items.Add(item);
            item = new RadComboBoxItem("20", "20");
            item.Attributes.Add("ownerTableViewId", rg_omniclass.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("20") == null)
                cb.Items.Add(item);
            item = new RadComboBoxItem("50", "50");
            item.Attributes.Add("ownerTableViewId", rg_omniclass.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("50") == null)
                cb.Items.Add(item);
            item = new RadComboBoxItem("All", hfdscnt.Value);
            item.Attributes.Add("ownerTableViewId", rg_omniclass.MasterTableView.ClientID);
            if (cb.Items.FindItemByValue("All") == null)
                cb.Items.Add(item);
            cb.Items.Sort(new PagerRadComboBoxItemComparer());
            if (cb.Items.FindItemByValue(rg_omniclass.PageSize.ToString()) != null)
                cb.Items.FindItemByValue(rg_omniclass.PageSize.ToString()).Selected = true;
        }
    }

    protected void ddlomniclass_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        bind_data();
    }

    protected void OnClick_BtnSearch(object sender, ImageClickEventArgs e)
    
    {
        try
        {
         
            bind_data();
          
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_omniclass_OnPageSizeChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            bind_data();
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
        
    }
    protected void rg_omniclass_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            bind_data();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_omniclass_OnSortCommand(object sender, GridSortCommandEventArgs e)
    {
        try
        {
            bind_data();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
}