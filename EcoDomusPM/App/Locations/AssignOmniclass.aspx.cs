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
using User;

public partial class App_omniclasslinkup : System.Web.UI.Page
{
    static string Item_type;
    string Master_flag = "";
    string UniClass_flag = "";
    string UniFormat_flag = "";
    string OmniClass_flag = "";


    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString.Count > 0)
        {
            if (SessionController.Users_.UserId != null)
            {
                if (Request.QueryString["Item_type"] != "" || Request.QueryString["Item_type"] != null)
                {
                    Item_type = Request.QueryString["Item_type"].ToString();

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
                    // ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_height();", true);
                }
            }
        }
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

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        bind_data();
    }

    protected void show_hide_standards()
    {
        try
        {

            DataSet ds_TypeCount = new DataSet();

            DataSet ds = new DataSet();
            TypeModel tm = new TypeModel();
            TypeProfileClient tc = new TypeProfileClient();
            if (!string.IsNullOrEmpty(Convert.ToString(SessionController.Users_.ProjectId)))
            {
                tm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                tm.Flag = "type";
                tm.Txt_Search = "";
                ds_TypeCount = tc.bindtypepm_count_v1(tm, SessionController.ConnectionString);

                if (ds_TypeCount.Tables[2] != null)
                {
                    if (ds_TypeCount.Tables[2].Rows.Count > 0)
                    {
                        for (int i = 0; i < ds_TypeCount.Tables[2].Rows.Count; i++)
                        {
                            if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "MasterFormat")
                            {
                                Master_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                            }
                            else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "OmniClass 2010")
                            {
                                OmniClass_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                            }
                            else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "UniFormat")
                            {
                                UniFormat_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                            }
                            else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "UniClass")
                            {
                                UniClass_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                            }
                        }
                    }
                    if (UniClass_flag != "")
                    {
                        btnassignomniclass.Text = (string)GetGlobalResourceObject("Resource", "Assign_UniClass");
                        hf_uniclass.Value = "Y";
                    }
                    else
                    {
                        btnassignomniclass.Text = (string)GetGlobalResourceObject("Resource", "Assign_OmniClass");
                        hf_uniclass.Value = "N";
                    }
                }

            }
            else
            {
                hf_uniclass.Value = "N";
                OmniClass_flag = "OmniClass 2010";
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
            show_hide_standards();
            DataSet ds_category = new DataSet();
            if (Request.QueryString["Item_type"] != null)
            {
                if (Request.QueryString["Item_type"] == "Organization" && hf_uniclass.Value == "N")
                {
                    UserClient ctrl = new UserClient();
                    UserModel mdl = new UserModel();
                    ds_category = ctrl.get_omniclass_type_for_user_organization();
                    rg_omniclass.DataSource = ds_category;
                    rg_omniclass.DataBind();
                    lbl_grid_head.Text = (string)GetGlobalResourceObject("Resource", "Assign_OmniClass");

                }
                else
                {
                    Product.ProductClient locobj_crtl = new Product.ProductClient();
                    Product.ProductModel locobj_mdl = new Product.ProductModel();


                    locobj_mdl.Entity_name = Request.QueryString["Item_type"].ToString();
                    locobj_mdl.Category = txt_search.Text;
                    //locobj_mdl.Standard_name = ddlomniclass.SelectedItem.Text;
                    if (OmniClass_flag != "")
                    {
                        locobj_mdl.Standard_name = OmniClass_flag;
                        lbl_grid_head.Text = (string)GetGlobalResourceObject("Resource", "Assign_OmniClass");
                    }
                    else if (UniClass_flag != "")
                    {
                        locobj_mdl.Standard_name = UniClass_flag;
                        lbl_grid_head.Text = (string)GetGlobalResourceObject("Resource", "Assign_UniClass");
                    }

                    ds_category = locobj_crtl.GetOmniClasses(locobj_mdl);

                    if (ds_category.Tables.Count > 0)
                    {
                        rg_omniclass.DataSource = ds_category;
                        rg_omniclass.DataBind();
                    }
                }

            }
            else
            {
                Product.ProductClient locobj_crtl = new Product.ProductClient();
                Product.ProductModel locobj_mdl = new Product.ProductModel();


                locobj_mdl.Entity_name = Request.QueryString["Item_type"].ToString();
                locobj_mdl.Category = txt_search.Text;
                //locobj_mdl.Standard_name = ddlomniclass.SelectedItem.Text;
                if (OmniClass_flag != "")
                {
                    locobj_mdl.Standard_name = OmniClass_flag;
                    lbl_grid_head.Text = (string)GetGlobalResourceObject("Resource", "Assign_OmniClass");
                }
                else if (UniClass_flag != "")
                {
                    locobj_mdl.Standard_name = UniClass_flag;
                    lbl_grid_head.Text = (string)GetGlobalResourceObject("Resource", "Assign_UniClass");
                }

                ds_category = locobj_crtl.GetOmniClasses(locobj_mdl);

                if (ds_category.Tables.Count > 0)
                {
                    rg_omniclass.DataSource = ds_category;
                    rg_omniclass.DataBind();
                }
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
            //bind_views_tate_data();
            bind_data();
            if (e.NewPageSize != 10 && e.NewPageSize != 20 && e.NewPageSize != 50)
            {
                hf_size.Value = "ALL";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_width();", true);
            }
            else
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_height();", true);
            }
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
                    name = name + rg_omniclass.SelectedItems[i].Cells[4].Text.Replace("'"," ") + ",";
                }
                id = id.Substring(0, id.Length - 1);
                name = name.Substring(0, name.Length - 1);

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

    protected override void InitializeCulture()
    {
        if (SessionController.Users_.UserId != null)
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

                throw ex;
            }
        }
        else
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
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
        bind_data();
    }
    protected void ibtn_close_Click(object sender, ImageClickEventArgs e)
    {

    }
}

