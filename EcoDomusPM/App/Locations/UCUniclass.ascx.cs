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
public partial class App_Locations_UCUniclass : System.Web.UI.UserControl
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
                    if (Request.QueryString["IsFromTypePM"].ToString() == "Y" && hf_is_firsttime.Value=="")
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
            // bind_data();

        }



    }


    public void bind_data()
    {
        try
        {

            Product.ProductClient locobj_crtl1 = new Product.ProductClient();
            Product.ProductModel locobj_mdl1 = new Product.ProductModel();
            DataSet ds_category1 = new DataSet();

            locobj_mdl1.Entity_name = "Type";
            locobj_mdl1.Category = txtSearchnew.Text;
            locobj_mdl1.Standard_name = "uniclass";
            ds_category1 = locobj_crtl1.GetOmniClasses(locobj_mdl1);

            if (ds_category1.Tables.Count > 0)
            {
                rg_uniclass.DataSource = ds_category1;
                rg_uniclass.DataBind();
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

                if (!string.IsNullOrEmpty(ids))
                {
                    TypeModel tm1 = new TypeModel();
                    TypeProfileClient tc1 = new TypeProfileClient();
                    tm1.Type_Ids = ids;
                    tm1.Fk_uniclass_id = new Guid(id1);
                    if (Request.QueryString["IsFromTypePM"] != null)
                    {
                        if (Request.QueryString["IsFromTypePM"] != "")
                        {
                            if (Request.QueryString["IsFromTypePM"] == "Y")
                            {
                                tc1.update_uniclass_for_type_pm(tm1, SessionController.ConnectionString);
                            }
                        }
                    }
                   // tc1.update_uniclass_for_type_pm(tm1, SessionController.ConnectionString);
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_Sub_System1('" + id1 + "','" + name1 + "')</script>", false);
                   // ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:select_Sub_System1();", true);
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:refreshpage();", true);
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