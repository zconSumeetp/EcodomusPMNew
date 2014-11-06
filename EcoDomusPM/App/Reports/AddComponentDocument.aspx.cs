using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EcoDomus.Session;
using AttributeTemplate;
using Facility;
using Telerik.Web.UI;
using System.IO;
public partial class App_Reports_AddComponentDocument : System.Web.UI.Page
{
    Guid DocumentId;
    Guid entity_id;
    Guid entity_detail_id;
    Guid facility_id;
    Guid omniclass_id;
    Guid doc_type_id;
    string flagdoctype = "";
    string type_comp_flag;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            // flagdoctype = Request.QueryString["flag"].ToString(); Here We get the type of component document i.e. specifications , 0=andm etc

            if (Request.QueryString["flag"] != null)
            {
                if (Request.QueryString["type_comp_flag"] != null)
                {
                    type_comp_flag = Request.QueryString["type_comp_flag"].ToString();
                }
                if (Request.QueryString["facility_id"] != null)
                {
                    facility_id = new Guid(Request.QueryString["facility_id"].ToString());
                }
                if (Request.QueryString["entity_id"] != null)
                {
                    entity_id = new Guid(Request.QueryString["entity_id"].ToString());
                }
                if (Request.QueryString["Entity_detail_id"] != null)
                {
                    entity_detail_id = new Guid(Request.QueryString["Entity_detail_id"].ToString());
                }
                if (Request.QueryString["doc_type_id"] != null)
                {
                    doc_type_id = new Guid(Request.QueryString["doc_type_id"].ToString());
                }
                flagdoctype = Request.QueryString["flag"].ToString();
              
            //    hdcompdoctype.Value = "Component";
                if (flagdoctype == "w") // warranty document
                {
                    Label1.Text = "Warranty Document";
                    btnadddocument.Text = "Add  Warranty Document";
                }

                if (flagdoctype == "s") //specifications
                {
                    Label1.Text = "Specification";
                    btnadddocument.Text = "Add Specification Document";
                }
                if (flagdoctype == "Certificates") //Certificates
                {
                    Label1.Text = "Certificates";
                    btnadddocument.Text = "Add Certificates Document";
                }

                if (flagdoctype == "om") // O&M Manual
                {
                    Label1.Text = "O&M Manual";
                    btnadddocument.Text = "Add O&M Manual";
                }
                //if (flagdoctype == "Manufacturer_Instructions") //
                //{
                //    Label1.Text = "Manufacturer Instructions";
                //    btnadddocument.Text = "Add Manufacturer Instructions";
                //}

                //if (flagdoctype == "closeout_submittal")
                //{
                //    Label1.Text = "Closeout Submittal";
                //    btnadddocument.Text = "Add Closeout Submittal";
                //}

                //if (flagdoctype == "Request_for_Information")
                //{
                //    Label1.Text = "Request for Information";
                //    btnadddocument.Text = "Add Request for Information";
                //}


                //if (flagdoctype == "Contract_Specifications")
                //{
                //    Label1.Text = "Contract Specifications";
                //    btnadddocument.Text = "Add Contract Specifications";
                //}

                //if (flagdoctype == "Request_for_Information")
                //{
                //    Label1.Text = "Request for Information";
                //    btnadddocument.Text = "Add Request for Information";
                //}


                //if (flagdoctype == "Client_Requirements")
                //{
                //    Label1.Text = "Client Requirements";
                //    btnadddocument.Text = "Add Client Requirements";
                //}

                //if (flagdoctype == "Contract_Modifications")
                //{
                //    Label1.Text = "Contract Modifications";
                //    btnadddocument.Text = "Add Contract Modifications";
                //}

                //if (flagdoctype == "Design_Data")
                //{
                //    Label1.Text = "Design Data";
                //    btnadddocument.Text = "Add Design Data";
                //}

                //if (flagdoctype == "Preconstruction_Submittals")
                //{
                //    Label1.Text = "Preconstruction Submittals";
                //    btnadddocument.Text = "Add Preconstruction Submittals";
                //}
                //if (flagdoctype == "Design_Review_Comment")
                //{
                //    Label1.Text = "Design Review Comment";
                //    btnadddocument.Text = "Add Design Review Comment";
                //}

                //if (flagdoctype == "Design_Review_Comment")
                //{
                //    Label1.Text = "Design Review Comment";
                //    btnadddocument.Text = "Add Design Review Comment";
                //}

                //if (flagdoctype == "Manufacturer_Field_Reports")
                //{
                //    Label1.Text = "Manufacturer Field Reports";
                //    btnadddocument.Text = "Add Manufacturer Field Reports";
                //}

                //if (flagdoctype == "Product_Data")
                //{
                //    Label1.Text = "Product Data";
                //    btnadddocument.Text = "Add Product Data";
                //}

                //if (flagdoctype == "Request_for_Information")
                //{
                //    Label1.Text = "Request for Information";
                //    btnadddocument.Text = "Add Request for Information";
                //}

                //if (flagdoctype == "sample")
                //{
                //    Label1.Text = "Samples";
                //    btnadddocument.Text = "Add Samples";
                //}

                //if (flagdoctype == "Punch_List_Items")
                //{
                //    Label1.Text = "Punch List Items";
                //    btnadddocument.Text = "Add Punch List Items";
                //}


                //if (flagdoctype == "Test_Reports")
                //{
                //    Label1.Text = "Test Reports";
                //    btnadddocument.Text = "Add Test Reports";
                //}


                //if (flagdoctype == "Shop_Drawings")
                //{
                //    Label1.Text = "Shop Drawings";
                //    btnadddocument.Text = "Add Shop Drawings";
                //}


                //if (flagdoctype == "Contract_Drawings")
                //{
                //    Label1.Text = "Contract Drawings";
                //    btnadddocument.Text = "Add Contract Drawings";
                //}


                //if (flagdoctype == "samples")
                //{
                //    Label1.Text = "Samples";
                //    btnadddocument.Text = "Add Samples";
                //}
                //else  //By Pratik
                //{
                    Label1.Text = flagdoctype;
                    btnadddocument.Text = "Add " + flagdoctype;
                //}

            }
            // get the component or type or space id 
            if (Request.QueryString["id"] != null)
            {
                hfid.Value = Request.QueryString["id"].ToString();

            }

            if (!IsPostBack)
            {

                BindCategories();
                BindApproalBy();
                BindStage();
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "Name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rgDocument.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                BindDocumentsGrid();



            }
        }
        catch (Exception ex)
        {
            Response.Write("Page_Load:-" + ex.Message);
        }
    }
    protected void Page_Prerender(object sender, EventArgs e)
    {
       // BindDocumentsGrid();
        if (SessionController.Users_.UserSystemRole == "PA")
        {
            foreach (GridDataItem item in rgDocument.MasterTableView.Items)
            {
                ImageButton img_btn = item.FindControl("imgbtnDelete") as ImageButton;
                if (img_btn != null)
                {
                    img_btn.Visible = false;
                }
            }
            btnadddocument.Visible = false;
            BtnDocSave.Visible = false;

        }
    }
    protected void BindCategories()
    {
        try
        {
            string docType = flagdoctype.ToString();

            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();

            DataSet ds = new DataSet();

            ds = ac.Bind_doc_type_dropdown_document_checklist(SessionController.ConnectionString);

            rcbcategory.DataTextField = "document_type_name";
            rcbcategory.DataValueField = "pk_document_type_id";
            rcbcategory.DataSource = ds;
            rcbcategory.DataBind();
            if (flagdoctype == "w") // warranty document
            {
                rcbcategory.SelectedIndex = 21;
            }
            if (flagdoctype == "s") //specifications
            {
                rcbcategory.SelectedIndex = 19;
            }
            if (flagdoctype == "om") // O&M Manual
            {
                rcbcategory.SelectedIndex = 11;
            }
            //if (flagdoctype == "Manufacturer_Instructions") //
            //{
            //    rcbcategory.SelectedIndex = 10;
            //}

            //if (flagdoctype == "closeout_submittal")
            //{
            //    rcbcategory.SelectedIndex = 3;
            //}

            //if (flagdoctype == "Request_for_Information")
            //{
            //    rcbcategory.SelectedIndex = 15;
            //}


            //if (flagdoctype == "Contract_Specifications")
            //{
            //    rcbcategory.SelectedIndex = 6;
            //}

            //if (flagdoctype == "Client_Requirements")
            //{
            //    rcbcategory.SelectedIndex = 2;
            //}

            //if (flagdoctype == "Contract_Modifications")
            //{
            //    rcbcategory.SelectedIndex = 5;
            //}

            //if (flagdoctype == "Design_Data")
            //{
            //    rcbcategory.SelectedIndex = 7;
            //}

            //if (flagdoctype == "Preconstruction_Submittals")
            //{
            //    rcbcategory.SelectedIndex = 12;
            //}


            //if (flagdoctype == "Design_Review_Comment")
            //{
            //    rcbcategory.SelectedIndex = 8;
            //}

            //if (flagdoctype == "Manufacturer_Field_Reports")
            //{
            //    rcbcategory.SelectedIndex = 9;
            //}

            //if (flagdoctype == "Product_Data")
            //{
            //    rcbcategory.SelectedIndex = 13;
            //}

            //if (flagdoctype == "Request_for_Information")
            //{
            //    rcbcategory.SelectedIndex = 15;
            //}

            //if (flagdoctype == "Requests_for_Information")
            //{
            //    rcbcategory.SelectedIndex = 16;
            //}

            //if (flagdoctype == "Punch_List_Items")
            //{
            //    rcbcategory.SelectedIndex = 14;
            //}


            //if (flagdoctype == "Test_Reports")
            //{
            //    rcbcategory.SelectedIndex = 20;
            //}


            //if (flagdoctype == "Shop_Drawings")
            //{
            //    rcbcategory.SelectedIndex = 18;
            //}

             
            //if (flagdoctype == "sample")
            //{
            //    rcbcategory.SelectedIndex = 17;
            //}



            //if (flagdoctype == "Certificates")
            //{
            //    rcbcategory.SelectedIndex = 1;
            //}


            //if (flagdoctype == "Contract_Drawings")
            //{
            //    rcbcategory.SelectedIndex = 4;
            //}
            //else //By Pratik
            //{
                //rcbcategory.SelectedValue = flagdoctype;
                rcbcategory.SelectedItem.Text = flagdoctype;
            //}

        }
        catch (Exception ex)
        {
            lblMsg.Text = "BindCategories:-" + ex.Message;
        }
    }
    protected void BindApproalBy()
    {
        try
        {
            
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();

            DataSet ds = new DataSet();

            ds = ac.Bind_approval_by_dropdown_document_checklist(SessionController.ConnectionString);

            rcbapprovalby.DataTextField = "approval_by";
            rcbapprovalby.DataValueField = "id";
            rcbapprovalby.DataSource = ds;
            rcbapprovalby.DataBind();
            rcbapprovalby.SelectedIndex = 3;
        }
        catch (Exception ex)
        {
            lblMsg.Text = "BindApproalBy:-" + ex.Message;
        }
    }
    protected void BindStage()
    {
        try
        {

            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();

            DataSet ds = new DataSet();

            ds = ac.Bind_stage_dropdown_document_checklist(SessionController.ConnectionString);


            radStage.DataTextField = "stage_name";
            radStage.DataValueField = "pk_stage_id";
            radStage.DataSource = ds;
            radStage.DataBind();

            radStage.SelectedIndex = 2;

        }
        catch (Exception ex)
        {
            lblMsg.Text = "Bindstages:-" + ex.Message;
        }
    }
    protected void BindDocumentsGrid()
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();

            DataSet ds = new DataSet();
            am.Fk_row_id = entity_detail_id;
            am.Doc_type_id = doc_type_id;
            ds = ac.GetDocumentsDocumentsChecklist(am,SessionController.ConnectionString);
            rgDocument.DataSource = ds;
            rgDocument.DataBind();
            tbleitdocument.Style.Add("display", "none");
        }
        catch (Exception ex)
        {
            lblMsg.Text = "BindCategories:-" + ex.Message;
        }
    }
    protected void BtnDocSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (hfdocument_id.Value=="")
            {
                hfdocument_id.Value = Guid.Empty.ToString();
            }
          
            FacilityClient facObjClientCtrl = new FacilityClient();
            FacilityModel facObjFacilityModel = new FacilityModel();
          
            DataSet ds_facility = new DataSet();
            if (entity_detail_id!= null)
            {
                facObjFacilityModel.Fk_row_id = entity_detail_id;
            }
            else
            {
                facObjFacilityModel.Fk_row_id = Guid.Empty;
            }
             facObjFacilityModel.Entity_id = entity_id;


            facObjFacilityModel.Facility_id = facility_id;
            facObjFacilityModel.User_Id = new Guid(SessionController.Users_.UserId.ToString());
            facObjFacilityModel.Document_Id = new Guid(hfdocument_id.Value.ToString());


           
           // facObjFacilityModel.Document_type_id = new Guid(rcbcategory.SelectedValue);

            facObjFacilityModel.Document_type_id = new Guid(doc_type_id.ToString()); // By Pratik

            facObjFacilityModel.Fk_stage_id = new Guid(radStage.SelectedValue);
            facObjFacilityModel.Fk_approval_id = new Guid(rcbapprovalby.SelectedValue);


            string filename = DocumentUpload(facility_id.ToString());
            facObjFacilityModel.Document_Name = txtName.Text;
            facObjFacilityModel.Description = txtDirName.Text;

            string filepath = string.Empty;
            foreach (UploadedFile file in ruDocument.UploadedFiles)
            {
                filename = file.GetName();
                filename = filename.Replace("&", "_");
                filename = filename.Replace("#", "_");
                filename = filename.Replace("%", "_");
                filename = filename.Replace("*", "_");
                filename = filename.Replace("{", "_");
                filename = filename.Replace("}", "_");
                filename = filename.Replace("\\", "_");
                filename = filename.Replace(":", "_");
                filename = filename.Replace("<", "_");
                filename = filename.Replace(">", "_");
                filename = filename.Replace("?", "_");
                filename = filename.Replace("/", "_");
                filepath = Path.Combine(Server.MapPath("~/App/Files/Documents/" + facility_id.ToString()), filename);
                hfAttachedFile.Value = "~/App/Files/Documents/" + facility_id.ToString() + "/" + filename;
                file.SaveAs(filepath, true);

            }
            facObjFacilityModel.File_path = hfAttachedFile.Value;


            //lbl_document_path.Text = hfAttachedFile.Value;//added


            facObjFacilityModel = facObjClientCtrl.InsertUpdate_Document_document_checklist(facObjFacilityModel, SessionController.ConnectionString);
            string existsflag = facObjFacilityModel.existsflag;
            string newDocument_id = facObjFacilityModel.New_Document_ID.ToString();
            hfdocument_id.Value = newDocument_id.ToString();
            if (existsflag == "Y")
            {
                lblMsg.Text = "Document with this name already exists..!";

            }
            else
            {
                BindDocumentsGrid();
               // EnableDisable("D");
               // string value = "<script language='javascript'>GotoProfile('" + hf_document_id.Value + "')</script>";
               // Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
                //string nw = "<script language='javascript'>select();</script>";
                // Page.ClientScript.RegisterStartupScript(this.GetType(), "scriptOrgId", nw);
            }
            // }
            //else
            //{
            //    lblvalidate.Visible = true;
            //}

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public string DocumentUpload(string strFacilityId)
    {

        string strDirExists = string.Empty;
        string filename = "";
        string filepath = string.Empty;
        try
        {
            strDirExists = Server.MapPath("~/App/Files/Documents/" + strFacilityId);
            DirectoryInfo de = new DirectoryInfo(strDirExists);
            if (!de.Exists)
            {
                de.Create();
            }

            foreach (UploadedFile file in ruDocument.UploadedFiles)
            {
                filename = file.GetName();
                filename = filename.Replace("&", "_");
                filename = filename.Replace("#", "_");
                filename = filename.Replace("%", "_");
                filename = filename.Replace("*", "_");
                filename = filename.Replace("{", "_");
                filename = filename.Replace("}", "_");
                filename = filename.Replace("\\", "_");
                filename = filename.Replace(":", "_");
                filename = filename.Replace("<", "_");
                filename = filename.Replace(">", "_");
                filename = filename.Replace("?", "_");
                filename = filename.Replace("/", "_");
                filepath = Path.Combine(Server.MapPath("~/App/Files/Documents/" + strFacilityId), filename);
                hfAttachedFile.Value = "~/App/Files/Documents/" + strFacilityId + "/" + filename;
               // hf_filename.Value = filename;
                file.SaveAs(filepath, true);

            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "DocumentUpload :-" + ex.Message.ToString();
        }
        return filename;

    }
    protected void btnadddocument_Click(object sender, EventArgs e)
    {
        tbleitdocument.Style.Add("display", "inline");
        if (Request.QueryString["flag"] != null)
        {
           rcbcategory.Enabled = false;
        }
        hfdocument_id.Value = "";
        txtName.Text = "";
        hfAttachedFile.Value = "";
    }
    protected void rgDocument_OnItemCommand(object source, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "editDocument")
            {
                if (e.Item is GridDataItem)
                {
                    AttributeTemplateModel am = new AttributeTemplateModel();
                    AttributeTemplateClient ac = new AttributeTemplateClient();
                    DataSet ds = new DataSet();
                    Guid document_id;
                    GridDataItem dataItem = e.Item as GridDataItem;
                    document_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString());
                    hfdocument_id.Value = Convert.ToString(document_id);
                    tbleitdocument.Style.Add("display", "inline");
                   // Component_ChecklistDataContext db = new Component_ChecklistDataContext();
                    am.PK_Doc_id=document_id;
                    ds = ac.GetDocumentsDetailsDocumentsChecklist(am, SessionController.ConnectionString);
                    if (ds.Tables[0].Rows.Count > 0)
                    {

                        txtDirName.Text = ds.Tables[0].Rows[0]["Directory"].ToString();
                        txtName.Text = ds.Tables[0].Rows[0]["NAME"].ToString();
                        rcbapprovalby.SelectedValue = ds.Tables[0].Rows[0]["Fk_approvalby_id"].ToString();
                        rcbcategory.SelectedValue = ds.Tables[0].Rows[0]["Fk_category_id"].ToString();
                        radStage.SelectedValue = ds.Tables[0].Rows[0]["Fk_stage_id"].ToString();

                       // hffilename.Value = ds.Tables[0].Rows[0]["Directory"].ToString();
                        hfAttachedFile.Value = ds.Tables[0].Rows[0]["file_path"].ToString();
                    }
                }
            }

            if (e.CommandName == "deleteDocument")
            {
                if (e.Item is GridDataItem)
                {
                    AttributeTemplateModel am = new AttributeTemplateModel();
                    AttributeTemplateClient ac = new AttributeTemplateClient();

                    am.PK_Doc_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString());
                  
                    ac.Delete_document_doc_checklist(am,SessionController.ConnectionString);
                    BindDocumentsGrid();
                }
            }

        }

        catch (Exception ex)
        {
            lblMsg.Text = "rgDocument_ItemCommand:-" + ex.Message.ToString();
        }
         
    }
    protected void rgDocument_OnSortCommand(object source, GridSortCommandEventArgs e)
    {
        BindDocumentsGrid();
    }
    protected void rgDocument_OnPageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        BindDocumentsGrid();
    }
    protected void rgDocument_OnPageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindDocumentsGrid();
    }
}