using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Telerik.Web.UI;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Session;
using Facility;
using System.Data;
using Locations;
using System.Threading;
using System.Globalization;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;


public partial class App_Locations_AddDocument : System.Web.UI.Page
{



    string CommonVirtualPath = ConfigurationManager.AppSettings["CommonFilePath"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            rpaImportLocation.Localization.TotalFiles = (string)GetGlobalResourceObject("Resource", "Total_Files");
            rpaImportLocation.Localization.UploadedFiles = (string)GetGlobalResourceObject("Resource", "Uploaded_Files");
            rpaImportLocation.Localization.CurrentFileName = (string)GetGlobalResourceObject("Resource", "Uploading_File");
            rpaImportLocation.Localization.Cancel = (string)GetGlobalResourceObject("Resource", "Cancel");
            rpaImportLocation.Localization.ElapsedTime = (string)GetGlobalResourceObject("Resource", "Elapsed_Time");
            rpaImportLocation.Localization.EstimatedTime = (string)GetGlobalResourceObject("Resource", "Estimated_Time");
            rpaImportLocation.Localization.Total = (string)GetGlobalResourceObject("Resource", "Total");
            rpaImportLocation.Localization.TransferSpeed = (string)GetGlobalResourceObject("Resource", "Transfer_Speed");
            rpaImportLocation.Localization.Uploaded = (string)GetGlobalResourceObject("Resource", "Uploaded");
            binddocumenttypedropdown();
            //BindStages();
            //BindApprovalby();            

            if (Request.QueryString["Document_Id"] != Guid.Empty.ToString())
            {

               
                FacilityModel fm = new FacilityModel();
                txtName.Text = Request.QueryString["Document_Name"].ToString();
                txtdescription.Text = Request.QueryString["Document_Desc"].ToString();
                rcbcategory.FindItemByText(Request.QueryString["Document_cat"].ToString()).Selected=true;


            }
        }
    }

    protected void binddocumenttypedropdown()
    {

        Product.ProductClient ProductClient = new Product.ProductClient();
        Product.ProductModel ProductModel = new Product.ProductModel();

        DataSet ds = ProductClient.GetDocumentType(ProductModel);
        rcbcategory.DataTextField = "type_name";
        rcbcategory.DataValueField = "pk_doc_type_id";
        rcbcategory.DataSource = ds;
        rcbcategory.DataBind();
    }
    public string Upload()
    {
        //  string strProjectName = Session["ProjectId"].ToString();
        string strDirExists = string.Empty;
        string filename = "";
        string filepath = string.Empty;
        try
        {

            strDirExists = Server.MapPath("~/App/Settings/Products/Documents/");
            DirectoryInfo de = new DirectoryInfo(strDirExists);
            if (!de.Exists)
            {
                de.Create();
            }

            foreach (UploadedFile f in ruDocument.UploadedFiles)
            {
                filename = f.GetName();
                filepath = Path.Combine(Server.MapPath("~/App/Settings/Products/Documents/"), filename);
                hfAttachedFile.Value = "~/App/Settings/Products/Documents/" + filename;
                f.SaveAs(filepath, true);
                //SaveFileName(filename);
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "CsvUpload :-" + ex.Message.ToString();
        }
        return filename;

    }

    private void BindProductName()
    {

        Product.ProductClient ProductClient = new Product.ProductClient();
        Product.ProductModel ProductModel = new Product.ProductModel();

        ProductModel.ProductId = new Guid(Request.QueryString["ProductId"].ToString());

        DataSet ds = ProductClient.Getproductsbyid(ProductModel);


        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    //lblproduct.Text = ds.Tables[0].Rows[0]["long_name"].ToString();
        //    lblproduct.Text = ds.Tables[0].Rows[0]["model_number"].ToString();
        //}
    }

    protected void btnDocSave_Click(object sender, EventArgs e)
    {
        try
        {

            Product.ProductClient ProductClient = new Product.ProductClient();
            Product.ProductModel ProductModel = new Product.ProductModel();
            ProductModel.ProductId = Guid.Parse(Request.QueryString["ProductId"].ToString());
            ProductModel.Document_id = Guid.Parse(Request.QueryString["Document_Id"].ToString());
            ProductModel.Category = rcbcategory.SelectedItem.Text;
            ProductModel.DocumentName = txtName.Text.Trim();
            ProductModel.Description = txtdescription.Text.Trim();

            ProductModel.FileName = Upload();

            ProductModel.Path = hfAttachedFile.Value;


            string existsflag = ProductClient.InsertProductDocument(ProductModel);
            if (existsflag == "Y")
            {
                lblError.Text = "This document already exists!";
            }
        //    binddocumenttypedropdown();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>ColseAfterSave();</script>", false);
        }
        catch (Exception ex)
        {
            lblMsg.Text = "btnDocSave_Click:-" + ex.ToString();
        }
    }

}

