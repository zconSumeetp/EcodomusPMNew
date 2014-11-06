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
public partial class App_Locations_UCOmniclassUniclass : System.Web.UI.UserControl
{
    static string Item_type;

    string type_id = "";
    string ids = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["type_id"] != null)
        {
            string id = Request.QueryString["type_id"].ToString();
            if (id.EndsWith(","))
            {
                id = id.Substring(0, id.Length - 1);
            }
            string[] parameters = id.Split(',');
            foreach (string id1 in parameters)
            {
                type_id = type_id + id1 + ",";

            }
            ids = type_id.Substring(0, type_id.Length - 1);

        }

        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "Category";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rg_uniclass.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                bind_data();

                //   ddlomniclass.Visible = false;
            }
            else
            {

                if (Request.QueryString["IsFromTypePM"] != null)
                {
                    if (Request.QueryString["IsFromTypePM"].ToString() == "Y" && hf_is_firsttime.Value == "")
                    {
                        GridSortExpression sortExpr = new GridSortExpression();
                        sortExpr.FieldName = "Category";
                        sortExpr.SortOrder = GridSortOrder.Ascending;
                        //Add sort expression, which will sort against first column
                        rg_uniclass.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                        bind_data();
                        hf_is_firsttime.Value = "N";
                    }

                }
            }

            // RadTabStrip tabStrip = (RadTabStrip)Page.FindControl("RadTabStrip1");
            HiddenField hf_OmniclassFlag12 = (HiddenField)Page.FindControl("hf_OmniclassFlag");
            //if (hf_OmniclassFlag.Value == "" && hf_is_firsttime.Value != "N")
            //{
            //    bind_data();
            //    hf_is_firsttime.Value = "N";
            //}
            if (hf_OmniclassFlag12.Value != hf_OmniclassFlag1.Value)
            {
                bind_data();
            }
        }
    }


    public void bind_data()
    {
        try
        {
            DataSet ds_category1 = new DataSet();
            HiddenField hf_OmniclassFlag = (HiddenField)Page.FindControl("hf_OmniclassFlag");
            hf_OmniclassFlag1.Value = hf_OmniclassFlag.Value;
            if (hf_OmniclassFlag.Value == "")
            {
                Product.ProductClient locobj_crtl1 = new Product.ProductClient();
                Product.ProductModel locobj_mdl1 = new Product.ProductModel();


                locobj_mdl1.Entity_name = "Organization";
                locobj_mdl1.Category = txtSearchnew.Text;
                locobj_mdl1.Standard_name = "Omniclass 2006";
                ds_category1 = locobj_crtl1.GetOmniClasses(locobj_mdl1);

                if (ds_category1.Tables.Count > 0)
                {
                    rg_uniclass.DataSource = ds_category1;
                    rg_uniclass.DataBind();
                }
            }
            else if (hf_OmniclassFlag.Value == "OmniClass")
            {
                Product.ProductClient locobj_crtl1 = new Product.ProductClient();
                Product.ProductModel locobj_mdl1 = new Product.ProductModel();


                locobj_mdl1.Entity_name = "Organization";
                locobj_mdl1.Category = txtSearchnew.Text;
                locobj_mdl1.Standard_name = "Omniclass 2006";
                ds_category1 = locobj_crtl1.GetOmniClasses(locobj_mdl1);

                if (ds_category1.Tables.Count > 0)
                {
                    rg_uniclass.DataSource = ds_category1;
                    rg_uniclass.DataBind();
                }
                #region for union of omniclass 2006 and 2010
                //UserClient ctrl = new UserClient();
                //UserModel mdl = new UserModel();
                //ds_category1 = ctrl.get_omniclass_type_for_user_organization();
                //rg_uniclass.DataSource = ds_category1;
                //rg_uniclass.DataBind();
                //lbl_grid_head.Text = (string)GetGlobalResourceObject("Resource", "Assign_OmniClass");
                #endregion

            }
            else if (hf_OmniclassFlag.Value == "UniClass")
            {
                Product.ProductClient locobj_crtl1 = new Product.ProductClient();
                Product.ProductModel locobj_mdl1 = new Product.ProductModel();
               

                locobj_mdl1.Entity_name = "Organization";
                locobj_mdl1.Category = txtSearchnew.Text;
                locobj_mdl1.Standard_name = "uniclass";
                ds_category1 = locobj_crtl1.GetOmniClasses(locobj_mdl1);

                if (ds_category1.Tables.Count > 0)
                {
                    rg_uniclass.DataSource = ds_category1;
                    rg_uniclass.DataBind();
                }
            }

        }
        catch (Exception ex)
        {
            Response.Write("Page_Load:- " + ex.Message.ToString());
        }
    }

    protected void OnClick_BtnSearch1(object sender, ImageClickEventArgs e)
    {
        bind_data();
    }
    protected void rg_uniclass_ItemDataBound(object sender, GridItemEventArgs e)
    {
        // bind_data();
    }
    protected void rg_uniclass_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        bind_data();
    }
    protected void rg_uniclass_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        bind_data();
    }
    protected void rg_uniclass_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        bind_data();
    }
    protected void rg_uniclass_ItemEvent(object sender, GridItemEventArgs e)
    {
        //  bind_data();
    }
    protected void rg_uniclass_ItemCreated(object sender, GridItemEventArgs e)
    {
        //  bind_data();
    }
    protected void btn_select_click(object sender, EventArgs e)
    {
        // bind_data();
    }
    protected void ddlomniclass_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        //  bind_data();
    }
    protected void rg_uniclass_OnItemDataBound(object sender, GridItemEventArgs e)
    {

    }
    protected void btn_assign_uniclass_Click(object sender, EventArgs e)
    {
        string id1 = "", name1 = "";
        try
        {

            if (rg_uniclass.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                for (int i = 0; i < rg_uniclass.SelectedItems.Count; i++)
                {
                    id1 = id1 + rg_uniclass.SelectedItems[i].Cells[2].Text + ",";
                    name1 = name1 + rg_uniclass.SelectedItems[i].Cells[4].Text + ",";
                }
                id1 = id1.Substring(0, id1.Length - 1);
                name1 = name1.Substring(0, name1.Length - 1);

                if (!string.IsNullOrEmpty(id1))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_Sub_System1('" + id1 + "','" + name1 + "')</script>", false);
                }
                else { }
                // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_Sub_System('" + id + "','" + name + "')</script>", false);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_uniclass('" + id1 + "','" + name1 + "');</script>", false);
            }
        }

        catch (Exception ex)
        {
            Response.Write("btnSelect_Click:-" + ex.Message);
        }

    }
}