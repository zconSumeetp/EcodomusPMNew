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

public partial class App_Central_ProductProfile : System.Web.UI.Page
{

    Guid OrganizationID;
    Guid ProductId;


    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    bind_WarrantyGuarantorParts();
                    BindProductProfile();
                    BindAssets();
                    BindDurationUnit();
                    BindUniformat();
                    //  btnCancel.Visible = false;

                    DataSet ds = new DataSet();

                    Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
                    Organization.OrganizationModel mdl = new Organization.OrganizationModel();

                    mdl.Organization_Id = new Guid(Request.QueryString["organization_id"]);
                    ds = obj_ctrl.GetOranizationInformation(mdl);
                    lblProductManufacturer.Text = ds.Tables[0].Rows[0]["OrganizationName"].ToString();


                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            
            }
            //else
            //{
            //    btnCancel.Visible = true;
            //}
        }
        catch (Exception ex)
        {
           // Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    #endregion


    #region Private Methods

    protected void toggle(string flag)
    {
        try
        {
            if (flag.Equals("Y"))
            {
                //txtProductName.Visible = false;
                txtdescrption.Visible = false;
                tr_lname.Style.Add("display", "none");
                txtModelNo.Visible = false;
                //ddlcategory.Visible = false;
                //lnkmanufacturer.Visible = false;
                //lnkBtnSelectManufaturer.Visible = false;
                //lnkbtnProvider.Visible = false;
                //lbtnaddmanufacturer.Visible = false;
                txtPartNo.Visible = false;

                ddlWarrantyGuarantorParts.Visible = false;
                ddlWarrantyGuarantorLabor.Visible = false;
                txtWarrantyDurationPart.Visible = false;
                txtWarrantyDurationLabor.Visible = false;

                ddlAssetType.Visible = false;
                ddlUniformat.Visible = false;
                txtWDescription.Visible = false;
                ddlDurationUnit.Visible = false;
                txtRcost.Visible = false;
                txtExpectedlife.Visible = false;

                lblWarrantyDurationPart.Visible = true;
                lblWarrantyDurationLabor.Visible = true;
                lblAssetType.Visible = true;
                lblUniformat.Visible = true;
                lblWDescription.Visible = true;
                lblDurationUnit.Visible = true;
                lblRcost.Visible = true;
                lblExpectedlife.Visible = true;

               
                btnOmniClass.Visible = false;
                lblModelNo.Visible = true;
                lbldescription.Visible = true;
            
                lblWarrantyGuarantorLabor.Visible = true;
                lblWarrantyGuarantorParts.Visible = true;
                lblPartNo.Visible = true;
                btnCancel.Visible = false;
                btnDelete.Visible = true;
            
            }
            else
            {
                
                txtdescrption.Visible = true;
                tr_lname.Style.Add("display", "inline");
                txtModelNo.Visible = true;
                
                txtPartNo.Visible = true;

               
               
                ddlWarrantyGuarantorParts.Visible = true;
                ddlWarrantyGuarantorLabor.Visible = true;
                txtWarrantyDurationPart.Visible = true;
                txtWarrantyDurationLabor.Visible = true;

                lblWarrantyGuarantorLabor.Visible = false;
                lblWarrantyGuarantorParts.Visible = false;
                lblPartNo.Visible = false;
                

                lblWarrantyDurationPart.Visible = false;
                lblWarrantyDurationLabor.Visible = false;

                btnOmniClass.Visible = true;
                lblModelNo.Visible = false;
                lbldescription.Visible = false;


                ddlAssetType.Visible = true;
                ddlUniformat.Visible = true;
                txtWDescription.Visible = true;
                ddlDurationUnit.Visible = true;
                txtRcost.Visible = true;
                txtExpectedlife.Visible = true;


                lblAssetType.Visible = false;
                lblUniformat.Visible = false;
                lblWDescription.Visible = false;
                lblDurationUnit.Visible = false;
                lblRcost.Visible = false;
                lblExpectedlife.Visible = false;
                btnCancel.Visible = true;
                btnDelete.Visible = false;
              
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "toggle:-" + ex.Message.ToString();
        }
    }

    protected void BindProductProfile()
    {
        try
        {
            if (Request.QueryString["ProductId"].ToString() == "00000000-0000-0000-0000-000000000000")
            {
                toggle("N");
                btnSave.Text = "Save";
            }
            else
            {
                toggle("Y");
                Product.ProductClient ProductClient = new Product.ProductClient();
                Product.ProductModel ProductModel = new Product.ProductModel();
                
                ProductModel.ProductId = new Guid(Request.QueryString["ProductId"].ToString());
                DataSet ds = ProductClient.Getproductsbyid(ProductModel);


                if (ds.Tables[0].Rows.Count > 0)
                {


                    lbldescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
                    txtdescrption.Text = ds.Tables[0].Rows[0]["description"].ToString();
                    lblOmniClass.Text = ds.Tables[0].Rows[0]["omniclass_name"].ToString();
                    txtlname.Text = ds.Tables[0].Rows[0]["long_name"].ToString();
                    hflname.Value = ds.Tables[0].Rows[0]["long_name"].ToString();
                    txtsname.Text = ds.Tables[0].Rows[0]["short_name"].ToString();

                    ddlAssetType.SelectedValue = ds.Tables[0].Rows[0]["asset_id"].ToString(); ;
                    lblAssetType.Text = ds.Tables[0].Rows[0]["asset"].ToString();

                    ddlUniformat.SelectedValue = ds.Tables[0].Rows[0]["uniformat_id"].ToString();
                    lblUniformat.Text = ds.Tables[0].Rows[0]["uniformat"].ToString();

                    txtWarrantyDurationPart.Text = ds.Tables[0].Rows[0]["warranty_duration_parts"].ToString();
                    lblWarrantyDurationPart.Text = ds.Tables[0].Rows[0]["warranty_duration_parts"].ToString();

                    txtWarrantyDurationLabor.Text = ds.Tables[0].Rows[0]["warranty_duration_labor"].ToString();
                    lblWarrantyDurationLabor.Text = ds.Tables[0].Rows[0]["warranty_duration_labor"].ToString();

                    txtWDescription.Text = ds.Tables[0].Rows[0]["warranty_description"].ToString();
                    lblWDescription.Text = ds.Tables[0].Rows[0]["warranty_description"].ToString();

                    ddlDurationUnit.SelectedValue = ds.Tables[0].Rows[0]["warranty_duration_unit"].ToString();
                    lblDurationUnit.Text = ds.Tables[0].Rows[0]["warranty_duration_unit"].ToString();

                    txtRcost.Text = ds.Tables[0].Rows[0]["replacement_cost"].ToString();
                    lblRcost.Text = ds.Tables[0].Rows[0]["replacement_cost"].ToString();

                    txtExpectedlife.Text = ds.Tables[0].Rows[0]["expected_life"].ToString();
                    lblExpectedlife.Text = ds.Tables[0].Rows[0]["expected_life"].ToString();

                    txtModelNo.Text = ds.Tables[0].Rows[0]["model_number"].ToString();
                    lblModelNo.Text = ds.Tables[0].Rows[0]["model_number"].ToString();

                    lblWarrantyGuarantorLabor.Text = ds.Tables[0].Rows[0]["WarrantyGuarantorLabor"].ToString();
                    if (ds.Tables[0].Rows[0]["WarrantyGuarantorLabor_Id"].ToString() != "")
                        ddlWarrantyGuarantorLabor.SelectedValue = ds.Tables[0].Rows[0]["WarrantyGuarantorLabor_Id"].ToString();
                    else
                        ddlWarrantyGuarantorLabor.SelectedValue = "00000000-0000-0000-0000-000000000000";
                    lblWarrantyGuarantorParts.Text = ds.Tables[0].Rows[0]["WarrantyGuarantorParts"].ToString();
                    if (ds.Tables[0].Rows[0]["WarrantyGuarantorParts_Id"].ToString() != "")
                        ddlWarrantyGuarantorParts.SelectedValue = ds.Tables[0].Rows[0]["WarrantyGuarantorParts_Id"].ToString();
                    else
                        ddlWarrantyGuarantorParts.SelectedValue = "00000000-0000-0000-0000-000000000000";
                    lblPartNo.Text = ds.Tables[0].Rows[0]["part_number"].ToString();
                    txtPartNo.Text = ds.Tables[0].Rows[0]["part_number"].ToString();



                    hfProductManufacturerOrgPriUserId.Value = ds.Tables[1].Rows[0]["OrganizationPriUserId"].ToString();

                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "BindProjectRegister:- " + ex.Message;
        }

        finally
        {

        }

    }

    protected void BindUniformat()
    {
        try
        {
            Product.ProductClient ProductClient = new Product.ProductClient();
            DataSet ds = ProductClient.GetUniformat();

            ddlUniformat.DataTextField = "Name";
            ddlUniformat.DataValueField = "Id";

            ddlUniformat.DataSource = ds;
            ddlUniformat.DataBind();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Bind Uniformat:-" + ex.Message;
        }
    }

    protected void BindAssets()
    {
        try
        {
            Product.ProductClient ProductClient = new Product.ProductClient();
            DataSet ds = ProductClient.GetAssetType();

            ddlAssetType.DataTextField = "asset_description";
            ddlAssetType.DataValueField = "asset_type_id";
            ddlAssetType.DataSource = ds;
            ddlAssetType.DataBind();
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message.ToString();
        }

    }

    protected void BindDurationUnit()
    {
        try
        {
            Product.ProductClient ProductClient = new Product.ProductClient();
            DataSet ds = ProductClient.GetDurationunit();

            ddlDurationUnit.DataTextField = "Name";
            ddlDurationUnit.DataValueField = "Name";

            ddlDurationUnit.DataSource = ds;
            ddlDurationUnit.DataBind();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "BindDurationUnit:-" + ex.Message;
        }

    }

    protected void bind_WarrantyGuarantorParts()
    {
        Product.ProductClient ProductClient = new Product.ProductClient();
        Product.ProductModel ProductModel = new Product.ProductModel();
        ProductModel.OrganizationId = new Guid(Request.QueryString["organization_id"]);
        DataSet ds = ProductClient.Getguarantor(ProductModel);


        ddlWarrantyGuarantorParts.DataTextField = "provider_name";
        ddlWarrantyGuarantorParts.DataValueField = "provider_id";
        ddlWarrantyGuarantorParts.DataSource = ds;
        ddlWarrantyGuarantorParts.DataBind();

        ddlWarrantyGuarantorLabor.DataTextField = "provider_name";
        ddlWarrantyGuarantorLabor.DataValueField = "provider_id";
        ddlWarrantyGuarantorLabor.DataSource = ds;
        ddlWarrantyGuarantorLabor.DataBind();

    }

    protected void InsertupdateProductProfile()
    {
        try
        {
            Product.ProductClient ProductClient = new Product.ProductClient();
            Product.ProductModel ProductModel = new Product.ProductModel();

            //ProdM.OmniclassId = new Guid(hf_lblOmniClassid.Value.ToString());
           
            ProductModel.OmniClassId = hf_lblOmniClassid.Value.Equals("") ? Guid.Empty : new Guid(hf_lblOmniClassid.Value);
            ProductModel.Description = txtdescrption.Text.ToString();
            ProductModel.Long_name = txtlname.Text.ToString();
            ProductModel.Short_name = txtsname.Text.ToString();
            ProductModel.Model_number = txtModelNo.Text.ToString();
            ProductModel.Part_number = txtPartNo.Text.ToString();
            ProductModel.Warranty_guarantor_parts_id = ddlWarrantyGuarantorParts.SelectedItem.Value;
            ProductModel.Warranty_guarantor_labor_id = ddlWarrantyGuarantorLabor.SelectedItem.Value;

            ProductModel.Asset_type_id = new Guid(ddlAssetType.SelectedItem.Value); ;
            ProductModel.Expected_life = txtExpectedlife.Text;
            ProductModel.Replacement_cost = txtRcost.Text;
            ProductModel.Uniformat_id = new Guid(ddlUniformat.SelectedItem.Value);
            ProductModel.Warranty_description = txtWDescription.Text;
            ProductModel.Warranty_duration_labor = txtWarrantyDurationLabor.Text;
            ProductModel.Warranty_duration_parts = txtWarrantyDurationPart.Text;
            ProductModel.Warranty_duration_unit = ddlDurationUnit.SelectedItem.Value;
            if (Request.QueryString["Organization_id"] != null)

                ProductModel.OrganizationId = new Guid(Request.QueryString["Organization_id"].ToString());
            else
                ProductModel.OrganizationId = Guid.Empty;

            if (ddlDurationUnit.SelectedItem.Text.Equals("--Select--"))
            {
                ProductModel.Warranty_duration_unit = "";
            }


            ProductModel.ProductId = new Guid(Request.QueryString["ProductId"].ToString());



            string ExistsFlag = ProductClient.InsertUpdateProduct(ProductModel);
            if (ExistsFlag == "Y")
            {
                lblError.Text = "Product Already Exists";
                toggle("N"); //added by Priyanka
                btnSave.Text = "Save";  // added by Priyanka
            }
            else if (ExistsFlag == "N")
            {
                Response.Redirect("~/App/Settings/Product.aspx?Organization_Id=" + new Guid(Request.QueryString["organization_id"].ToString()), false);
            }
            else
            BindProductProfile();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "updateProductProfile:-" + ex.Message.ToString();
        }

    }

    #endregion


    #region Event Handlers

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (btnSave.Text.Equals("Save"))
            {
                btnSave.Text = "Edit";
                //btnCancel.Visible = true;
                toggle("Y");
                InsertupdateProductProfile();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>refreshLname()</script>");
                //Guid p_id= new Guid(Request.QueryString["ProductId"].ToString());

            }
            else
            {
                btnSave.Text = "Save";
                //btnCancel.Visible =false;
                toggle("N");
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "btnSave_Click:-" + ex.Message.ToString();
        }

    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
      
        Product.ProductModel ProductModel = new Product.ProductModel();
        Product.ProductClient ProductClient = new Product.ProductClient();

        ProductModel.ProductId = new Guid(Request.QueryString["ProductId"].ToString()); ;
        ProductClient.DeleteProduct(ProductModel);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NaviagtetoProductGrid();", true);
    
    
    }

    //protected void rgDocument_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    //{
    //    try
    //    {
    //        if (e.Item is )
    //        {
    //            HyperLink hyper_path = e.Item.FindControl("hlnkDocName") as HyperLink;
    //            Label lblDoc = e.Item.FindControl("lblDocName") as Label;

    //            if (((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[3] != "")
    //            {
    //                hyper_path.Visible = true;
    //                lblDoc.Visible = false;
    //                if (hyper_path.NavigateUrl.ToString() != "")
    //                {
    //                    hyper_path.NavigateUrl = ((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[4].ToString();
    //                }
    //            }
    //            else
    //            {
    //                hyper_path.Visible = false;
    //                lblDoc.Visible = true;
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        lblMsg.Text = "rgDocument_ItemDataBound:-" + ex.Message;
    //    }
    //}

    protected void rgDocument_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            Guid document_id = Guid.Empty;
            //if (e.CommandName == "deleteDocument")
            //{
            //    document_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["document_id"].ToString());
            //    //string flag = (e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["flag"].ToString());
            //    hfDocumentId.Value = document_id.ToString();
            //    ProductsModel ProjectDM = new ProductsModel();
            //    ProductsControl ProjectDC = new ProductsControl(SystemConstants.getConnectionFile());

            //    ProjectDM.document_id = new Guid(hfDocumentId.Value);

            //    ProjectDC.proc_trash_product_document(ProjectDM);

            //    //bindProductDocument();


            }

            //if (e.CommandName == "ChangePageSize")
            //{
            //    bindProductDocument();
            //}
            //if (e.CommandName == "Page")
            //{
            //    bindProductDocument();
            //}



        
        catch (Exception ex)
        {
            lblMsg.Text = "rgDocument_ItemCommand:-" + ex.Message;
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            toggle("Y");
            if (btnSave.Text == "Save" && Request.QueryString["productId"] != "00000000-0000-0000-0000-000000000000")
            {
                btnSave.Text = "Edit";
                //btnCancel.Visible = true;
            }
                
            else
            {


                Response.Redirect("~/App/Settings/Product.aspx?Organization_Id=" + hf_organizationId .Value+ "", false);
               // 
            }
            
           // btnCancel.Visible = false;
            // Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>UpdateTypeName();</script>");
        }
        catch (Exception ex)
        {
            lblMsg.Text = "btnCancel_Click:-" + ex.Message.ToString();
        }
    }

    protected void btnRefreshDoc_Click(object sender, EventArgs e)
    {
        try
        {
            //bindProductDocument();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "btnRefreshDoc_Click:-" + ex.Message.ToString();
        }
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
        catch (Exception)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        
        }
     }


   
}