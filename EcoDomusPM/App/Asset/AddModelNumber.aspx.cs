using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using Product;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;

public partial class App_Asset_AddModelNumber : System.Web.UI.Page
{
     protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {         
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "model_number";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            //Add sort expression, which will sort against first column
            rgProducts.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
            bindProducts();
        }
    }

    protected void bindProducts()
    {
        ProductClient ctrl = new ProductClient();
        ProductModel mdl = new ProductModel();
        DataSet ds = new DataSet();
        mdl.Searchstring = txtSearch.Text.ToString();
        mdl.OrganizationId =new Guid(Request.QueryString["organization_id"].ToString());
        mdl.Client_Id =new Guid(SessionController.Users_.ClientID.ToString());
        ds = ctrl.GetOrganizationsProducts(mdl);

        rgProducts.DataSource = ds;
        rgProducts.DataBind();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindProducts();
    }

    protected void rgProducts_OnSortCommand(object source, GridSortCommandEventArgs e)
    {
        bindProducts();
    }

    protected void rgProducts_OnPageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        bindProducts();
    }

    protected void rgProducts_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        bindProducts();
    }

    protected void rgProducts_OnItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

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

    protected void btnAssignProduct_Click(object sender, EventArgs e)
    {
        try
        {
            if (rgProducts.SelectedValue != null)
            { 
                foreach(Telerik.Web.UI.GridDataItem item in rgProducts.SelectedItems)
                {
                    string product_id = item["pk_product_id"].Text.ToString();
                    DataSet ds = new DataSet();
                    ProductClient ctrl = new ProductClient();
                    ProductModel mdl = new ProductModel();
                    mdl.ProductId = new Guid(product_id);

                    ds = ctrl.Getproductsbyid(mdl);

                    hfProductId.Value = product_id;
                    hfAssetType.Value = ds.Tables[0].Rows[0]["asset"].ToString();
                    hfAssetTypeId.Value = ds.Tables[0].Rows[0]["asset_id"].ToString();
                    hfDescription.Value = ds.Tables[0].Rows[0]["description"].ToString();
                    hfExpectedLife.Value = ds.Tables[0].Rows[0]["expected_life"].ToString();
                    hfManufacturerId.Value = ds.Tables[0].Rows[0]["manufacturer_id"].ToString();
                    hfManufacturerName.Value = ds.Tables[0].Rows[0]["manufacturer"].ToString();
                    hfModelNumber.Value = ds.Tables[0].Rows[0]["model_number"].ToString();
                    hfOmniClassId.Value = ds.Tables[0].Rows[0]["omniclass_id"].ToString();
                    hfOmniClassName.Value = ds.Tables[0].Rows[0]["omniclass_name"].ToString();
                    hfPartNumber.Value = ds.Tables[0].Rows[0]["part_number"].ToString();
                    hfReplacementCost.Value = ds.Tables[0].Rows[0]["replacement_cost"].ToString();
                    hfUniFormat.Value = ds.Tables[0].Rows[0]["uniformat"].ToString();
                    hfUniFormatId.Value = ds.Tables[0].Rows[0]["uniformat_id"].ToString();
                    hfWarrantyDescription.Value = ds.Tables[0].Rows[0]["warranty_description"].ToString();
                    hfWarrantyDurationLabor.Value = ds.Tables[0].Rows[0]["warranty_duration_labor"].ToString();
                    hfWarrantyDurationParts.Value = ds.Tables[0].Rows[0]["warranty_duration_parts"].ToString();
                    hfWarrantyDurationUnit.Value = ds.Tables[0].Rows[0]["warranty_duration_unit"].ToString();
                    //hfWarrantyDurationUnitId.Value = ds.Tables[0].Rows[0][""].ToString();
                    hfWarrantyGuarantorLabor.Value = ds.Tables[0].Rows[0]["WarrantyGuarantorLabor"].ToString();
                    hfWarrantyGuarantorLaborId.Value = ds.Tables[0].Rows[0]["WarrantyGuarantorLabor_Id"].ToString();
                    hfWarrantyGuarantorParts.Value = ds.Tables[0].Rows[0]["WarrantyGuarantorParts"].ToString();
                    hfWarrantyGuarantorPartsId.Value = ds.Tables[0].Rows[0]["WarrantyGuarantorPartsId"].ToString();
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "script1", "<script language='javascript'>AssignProductAttributesToType();</script>", false);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}