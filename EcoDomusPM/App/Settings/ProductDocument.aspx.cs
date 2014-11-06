using System;
using System.Data;
using System.Globalization;
using System.IO;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using Product;
using Telerik.Web.UI;

namespace App.Settings
{
    public partial class AppCentralProductDocument : Page
    {
        public Guid ProductId;
        private string Category { get; set; }
        private string DocumentName { get; set; }
        private string DocumentDescription { get; set; }
        private bool Update { get; set; }

        #region Page Events

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (SessionController.Users_.UserId != null)
                {
                    if (Request.QueryString["Ispopup"] != null)
                    {
                        if (Request.QueryString["Ispopup"] == "Y")
                        {
                            tblAdd.Visible = true;
                            tblAdddocument.Visible = true;
                            tblAdddocument.Style.Add("display", "block");
                            RadButton1.Visible = false;
                            divblock.Visible = false;
                            Category = Request.QueryString["category"];
                            DocumentName = Request.QueryString["document_name"];
                            DocumentDescription = Request.QueryString["document_desc"];
                            Update = Convert.ToBoolean(Request.QueryString["update"]);
                        
                            if (!IsPostBack)
                            {
                                binddocumenttypedropdown();
                            }
                        }
                    
                        if (Request.QueryString["category"].Equals("undefined"))
                        {
                            UploadFileLabel.Visible = true;
                            ruDocument.Visible = true;
                        }
                        else
                        {
                            ruDocument.Visible = false;
                            UploadFileLabel.Visible = false;
                        }
                    }
                    if (Request.QueryString["ProductId"] != null)
                    {
                        ProductId = new Guid(Request.QueryString["ProductId"]);
                        hfproductId.Value = Request.QueryString["ProductId"];
                    }

                    else
                    {
                        ProductId = Guid.Empty;
                    }
                    if (Request.QueryString["Ispopup"] != "Y")
                    {

                        var ds = new DataSet();

                        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
                        Organization.OrganizationModel mdl = new Organization.OrganizationModel();
                        hfOrgId.Value = (Request.QueryString["organization_id"]);
                        mdl.Organization_Id = new Guid(Request.QueryString["organization_id"]);

                        ds = obj_ctrl.GetOranizationInformation(mdl);
                        lblProductManufacturer.Text = ds.Tables[0].Rows[0]["OrganizationName"].ToString();

                    }
                    if (!Page.IsPostBack)
                    {

                        var sortExpr = new GridSortExpression
                        {
                            FieldName = "document_name",
                            SortOrder = GridSortOrder.Ascending
                        };
                        //Add sort expression, which will sort against first column
                        rgProductDoc.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                        BindProductName();
                        bindProductDocument();
                        binddocumenttypedropdown();
                        txtdescription.Text = DocumentDescription;
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);

                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        #endregion





        #region Private Methods


        protected void bindProductDocument()
        {
            try
            {
                var productClient = new ProductClient();
                var productModel = new ProductModel();
                productModel.Searchstring = txtSearch.Text.ToString();
                productModel.ProductId = ProductId;
                var ds = productClient.GetProductDocument(productModel);
                rgProductDoc.DataSource = ds;
                rgProductDoc.DataBind();
                rcbcategory.DataSource = ds;
                rcbcategory.DataBind();
            }
            catch (Exception ex)
            {
                //  lblMsg.Text = "bindProductDocument:-" + ex.Message.ToString();
            }
        }

        protected void binddocumenttypedropdown() {

            var productClient = new ProductClient();
            var productModel=new ProductModel();

            var ds = productClient.GetDocumentType(productModel);
            rcbcategory.DataTextField = "type_name";
            rcbcategory.DataValueField = "pk_doc_type_id";
            rcbcategory.DataSource = ds;
            rcbcategory.DataBind();
            var item = rcbcategory.Items.FindItemByText(Category);
            if (item != null) 
                item.Selected = true;
        
        

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
                var de = new DirectoryInfo(strDirExists);
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

            var productClient = new ProductClient();
            var productModel = new ProductModel {ProductId = new Guid(Request.QueryString["ProductId"])};

            var ds = productClient.Getproductsbyid(productModel);


            if (ds.Tables[0].Rows.Count > 0)
            {
                lblproduct.Text = ds.Tables[0].Rows[0]["model_number"].ToString();
                txtName.Text = DocumentName;
            }
        }


        #endregion


        #region Event Handlers

        protected void btnDocSave_Click(object sender, EventArgs e)
        {
            try
            {

                var productClient = new ProductClient();
                var productModel = new ProductModel();
                
                if (ProductId == Guid.Empty)
                {
                    productModel.ProductId = Guid.Empty;
                }
                else
                {
                    productModel.ProductId = ProductId; ;
                }

                if (Update)
                {
                    var productDocument = new ProductDocumentDto
                    {
                        CategoryId = new Guid(rcbcategory.SelectedItem.Value),
                        DocumentName = txtName.Text.Trim(),
                        DocumentDescription = txtdescription.Text.Trim(),
                        FileName = Request.QueryString["file_name"],
                        Path = Request.QueryString["file_path"],
                        ProductId = ProductId,
                        Id = new Guid(Request.QueryString["document_id"])
                    };

                    productClient.InsertUpdateDocument(SessionController.ConnectionString, productDocument);
                    
                    ClientScript.RegisterStartupScript(GetType(), "script", "<script language='javascript'>CloseWindow();</script>");
                }
                else
                {
                    productModel.Category = rcbcategory.SelectedItem.Text;
                    productModel.Category_id = new Guid(rcbcategory.SelectedItem.Value);
                    productModel.DocumentName = txtName.Text.Trim();
                    productModel.Description = txtdescription.Text.Trim();
                    productModel.FileName = Upload();
                    productModel.Path = hfAttachedFile.Value;

                    string existsflag = productClient.InsertProductDocument(productModel);
                    if (existsflag == "Y")
                    {
                        lblError.Text = "This document already exists!";
                        tblAdddocument.Style.Add("display", "inline");
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>CloseWindow();</script>");
                    }
                }
            


                

                binddocumenttypedropdown();



            }
            catch (Exception ex)
            {
                lblMsg.Text = "btnDocSave_Click:-" + ex;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                bindProductDocument();
            }
            catch (Exception ex)
            {
                lblMsg.Text = @"btnSearch_Click:-" + ex.Message;
            }
        }
        #endregion

   
        #region Grid Events

        protected void rgDocument_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
                {
                    var hyperPath = e.Item.FindControl("hlnkDocName") as HyperLink;
                    var lblDoc = e.Item.FindControl("lblDocName") as Label;

                    if ((string) ((DataRowView)(e.Item.DataItem)).Row.ItemArray[3] != "")
                    {
                        if (hyperPath != null)
                        {
                            hyperPath.Visible = true;
                            if (lblDoc != null) lblDoc.Visible = false;
                            if (hyperPath.NavigateUrl != "")
                            {
                                hyperPath.NavigateUrl = ((DataRowView)(e.Item.DataItem)).Row.ItemArray[4].ToString();
                            }
                        }
                    }
                    else
                    {
                        if (hyperPath != null) hyperPath.Visible = false;
                        if (lblDoc != null) lblDoc.Visible = true;
                    }
                }

        }

        
        protected void rgDocument_ItemCommand(object source, GridCommandEventArgs e)
        {
            try
            {
                var document_id = Guid.Empty;
                if (e.CommandName == "deleteDocument")
                {
                    document_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["document_id"].ToString());
              
                    hfDocumentId.Value = document_id.ToString();

                    var productClient = new ProductClient();
                    var productModel = new ProductModel {Document_id = new Guid(hfDocumentId.Value)};

                    productClient.DeleteProductDocument(productModel);
                    bindProductDocument();

                }

                if (e.CommandName == "ChangePageSize")
                {
                    bindProductDocument();
                }
                if (e.CommandName == "Page")
                {
                    bindProductDocument();
                }



            }
            catch (Exception ex)
            {
                lblMsg.Text = "rgDocument_ItemCommand:-" + ex.Message;
            }
        }

        protected void rgProductDoc_onSortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
        {
            try
            {
                bindProductDocument();
            }
            catch (Exception ex)
            {
                lblMsg.Text = @"rgProducts_onSortCommand:-" + ex.Message;
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

        protected void btn_refresh_doc_Click(object sender, EventArgs e)
        {
            bindProductDocument();
        }
    }
}