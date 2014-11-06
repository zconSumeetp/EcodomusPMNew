using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;

public partial class App_Central_Product : System.Web.UI.Page
{

    Guid organizationId = Guid.Empty;
    Guid ProductId;


    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            
               if (SessionController.Users_.UserId != null)
                   {

                         if (!string.IsNullOrEmpty(Convert.ToString(Request.QueryString["Organization_Id"])))
                         {
                             organizationId = new Guid(Convert.ToString(Request.QueryString["Organization_Id"]));
                         }
                         else
                             organizationId = new Guid("00000000-0000-0000-0000-000000000000");

                         hfIsFromProduct.Value = "y";
                        if (!IsPostBack)
                            {

                                DataSet ds = new DataSet();

                                Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
                                Organization.OrganizationModel mdl = new Organization.OrganizationModel();

                                mdl.Organization_Id = new Guid(Request.QueryString["organization_id"]);
                                ds = obj_ctrl.GetOranizationInformation(mdl);
                                lbltitleOrg.Text = ds.Tables[0].Rows[0]["OrganizationName"].ToString();

                                //To sort the grid according to first column on page load:-
                                GridSortExpression sortExpr = new GridSortExpression();
                                sortExpr.FieldName = "model_number";
                                sortExpr.SortOrder = GridSortOrder.Ascending;
                                //Add sort expression, which will sort against first column
                                rgProducts.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                                bindProducts();
                            }
                      }
                     else
                      {
                            //string Updatedvalue = "<script language='javascript'>top.window.CallClickEvent(~/App/loginPM.aspx)')</script>";
                            //Page.ClientScript.RegisterStartupScript(this.GetType(), "script", Updatedvalue);
                          ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
                        }
                    }
                //    else
                //    {
                //        string Updatedvalue = "<script language='javascript'>top.window.CallClickEvent(~/App/LoginPM.aspx)')</script>";
                //        Page.ClientScript.RegisterStartupScript(this.GetType(), "script", Updatedvalue);
                //    }
                //}
            
        
        catch (Exception ex)
        {
            //Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    #endregion


    #region Private Methods

    protected void bindProducts()
    {
        try
        {

            
            
            Product.ProductClient ProductClient = new Product.ProductClient();
            Product.ProductModel ProductModel = new Product.ProductModel();

            ProductModel.OrganizationId = organizationId;
            ProductModel.Searchstring = txtSearch.Text.ToString();
            DataSet ds = ProductClient.GetProducts(ProductModel);
            rgProducts.DataSource = ds;
            rgProducts.DataBind();





        }
        catch (Exception ex)
        {
            lblMsg.Text = "bindProducts:-" + ex.Message.ToString();
        }
    }


    #endregion


    #region Grid Events


    protected void rgProduct_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            

            if (e.CommandName == "deleteProduct")
            {
                ProductId = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_product_id"].ToString());
                delete_Product(ProductId);
                bindProducts();
            }


        }
        catch (Exception ex)
        {
            lblMsg.Text = "rgProduct_ItemCommand:-" + ex.Message.ToString();
        }


    }

    
    void delete_Product(Guid product_id)
    {
        try
        {
            Product.ProductModel ProductModel = new Product.ProductModel();
            Product.ProductClient ProductClient = new Product.ProductClient();

            ProductModel.ProductId = product_id;
            ProductClient.DeleteProduct(ProductModel);
            
        }
        catch (Exception ex)
        {
            lblMsg.Text = "delete_Product:-" + ex.Message.ToString();
        }


    }


    protected void rgProducts_OnPageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {
            bindProducts();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }
        catch (Exception ex)
        {
            lblMsg.Text = "rgProducts_OnPageIndexChanged:-" + ex.Message.ToString();
        }
    }

    protected void rgProducts_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            bindProducts();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }
        catch (Exception ex)
        {
            lblMsg.Text = "rgProducts_OnPageSizeChanged:-" + ex.Message.ToString();
        }

    }

    protected void rgProducts_onSortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            bindProducts();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "rgProducts_onSortCommand:-" + ex.Message.ToString();
        }
    }

    #endregion


    #region Event Handlers


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            bindProducts();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "btnSearch_Click:-" + ex.Message.ToString();
        }
    }


    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            txtSearch.Text = "";
        }
        catch (Exception ex)
        {
            lblMsg.Text = "btnClear_Click:-" + ex.Message.ToString();
        }
    }

    protected void btnAddProduct_Click(object sender, EventArgs e)
    {

        Response.Redirect("~/App/Settings/ProductProfile.aspx?organization_id=" + new Guid(Request.QueryString["Organization_Id"].ToString()) + "&ProductId=00000000-0000-0000-0000-000000000000", false);
    }
    #endregion


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

            //redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }


}