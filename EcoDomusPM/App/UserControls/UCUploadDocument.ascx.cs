using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Telerik.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using Facility;
using EcoDomus.Session;
using System.Configuration;
using System.Threading;
using System.Globalization;


public partial class App_UserControls_UCUploadDocument : System.Web.UI.UserControl
{
    string TargetVirtualPath = "~/App/Files/Documents/Temp/";
    string CommonVirtualPath = ConfigurationManager.AppSettings["CommonFilePath"].ToString(); 


    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Request.QueryString["popupflag"] == "popup")
        {
            Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        TargetVirtualPath = CommonVirtualPath + "Documents/Temp/";

        if (!IsPostBack)
        {
            string TargetPhysicalPath = HttpContext.Current.Request.MapPath(TargetVirtualPath);
            if (!Directory.Exists(TargetPhysicalPath))
            {
                Directory.CreateDirectory(TargetPhysicalPath);
            }
            AsyncUploadFiles.TargetFolder = TargetPhysicalPath;

            BindFacilities();
        }
    }

    public void BindFacilities()
    {
        try
        {
            DataSet ds_facility = new DataSet();
            FacilityClient locObj_crtl = new FacilityClient();
            FacilityModel locObj_mdl = new FacilityModel();
            locObj_mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
            locObj_mdl.Search_text_name = "";
            locObj_mdl.Doc_flag = "floor";
            ds_facility = locObj_crtl.GetFacilitiesPM(locObj_mdl, SessionController.ConnectionString);
            if (ds_facility.Tables[0].Rows.Count > 0)
            {
                cmbfacility.DataTextField = "name";
                cmbfacility.DataValueField = "pk_facility_id";
                cmbfacility.DataSource = ds_facility;
                cmbfacility.DataBind();
                string name = ds_facility.Tables[0].Rows[0]["name"].ToString();
                cmbfacility.Text = name;
                cmbfacility.SelectedIndex = 0;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        try
        {
            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            RadTabStrip tabStrip = (RadTabStrip)userContentHolder.FindControl("rts_upload_document");
            RadTab UCMapDocuments = tabStrip.FindTabByValue("UCMapDocuments");
            RadTab UCUploadDocument = tabStrip.FindTabByValue("UCUploadDocument");
            UCUploadDocument.Enabled = false;
            UCMapDocuments.Enabled = true;
            UCMapDocuments.Selected = true;

            RadMultiPage rmp_upload_document = (RadMultiPage)userContentHolder.FindControl("rmp_upload_document");
            RadPageView rpv_template = rmp_upload_document.FindPageViewByID(@"~/App/UserControls/" + "UCMapDocuments");
            if (rpv_template == null)
            {
                rpv_template = new RadPageView();
                rpv_template.ID = @"~/App/UserControls/" + "UCMapDocuments";
                rmp_upload_document.PageViews.Add(rpv_template);
            }
            rpv_template.Selected = true;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    /* Saves all the Uploaded Files */
    protected void btnDummy_OnClick(object sender, EventArgs e)
    {
        try
        {

            Session["facilityid"] = cmbfacility.SelectedValue;

            string FacilityVirtualPath = CommonVirtualPath + string.Format("Documents/{0}/", cmbfacility.SelectedValue);
            string FacilityPhysicalPath = HttpContext.Current.Request.MapPath(FacilityVirtualPath);
            if (!Directory.Exists(FacilityPhysicalPath))
            {
                Directory.CreateDirectory(FacilityPhysicalPath);
            }

            string TargetPhysicalPath = HttpContext.Current.Request.MapPath(TargetVirtualPath);
            List<Guid> UploadedDocumentIds = new List<Guid>();

            List<string> FailedFileNames = new List<string>();
            AsyncUploadFiles.Enabled = false;

            foreach (UploadedFile file in AsyncUploadFiles.UploadedFiles)
            {
                string DestFilePhyPath = FacilityPhysicalPath + file.GetName();
                string filename = file.GetName().Replace("&", "_").Replace("#", "_").Replace("%", "_").Replace("*", "_").Replace("{", "_").Replace("}", "_");
                filename = filename.Replace("&", "_").Replace("#", "_").Replace("%", "_").Replace("*", "_").Replace("{", "_").Replace("}", "_");
                filename = filename.Replace("\\", "_").Replace(":", "_").Replace("<", "_").Replace("?", "_").Replace(">", "_").Replace("/", "_").Replace(">", "_");
               
                string FileNameWOExt=file.GetNameWithoutExtension().Replace("&", "_").Replace("#", "_").Replace("%", "_").Replace("*", "_").Replace("{", "_").Replace("}", "_");
                FileNameWOExt=FileNameWOExt.Replace("\\", "_").Replace(":", "_").Replace("<", "_").Replace("?", "_").Replace(">", "_").Replace("/", "_").Replace(">", "_");

                Guid newDocumentId = AddFilesToDocument(FacilityVirtualPath + filename, FileNameWOExt);

                if (newDocumentId.Equals(Guid.Empty))
                {
                    FailedFileNames.Add(FileNameWOExt);
                }
                else
                {
                    if (File.Exists(FacilityPhysicalPath + filename))  //If any old version of file is present
                    {
                        File.Delete(FacilityPhysicalPath + filename);
                    }

                    File.Move(TargetPhysicalPath + file.GetName(), FacilityPhysicalPath + filename);

                    UploadedDocumentIds.Add(newDocumentId);
                }
            }

            SessionController.Users_.BulkUploadFacilityId = cmbfacility.SelectedValue;
            SessionController.Users_.BulkUploadDocumentIds = String.Join(",", UploadedDocumentIds.Select(x => x.ToString()).ToArray());

            if (FailedFileNames.Count == 0)
            {
                cmbfacility.Enabled = false;
                AsyncUploadFiles.Enabled = false;
                lblMessege.Text = "All the files are uploaded successfully, please click next to map the documents.";
                lblMessege.Visible = true;
                lblErrorMessege.Visible = false;
                btnNext.Enabled = true;
                img_entity.Enabled = true;
            }
            else if (UploadedDocumentIds.Count > 0)
            {
                cmbfacility.Enabled = false;
                AsyncUploadFiles.Enabled = false;
                lblMessege.Text = "Few files uploaded successfully, click next if still want to continue...";
                lblMessege.Visible = true;
                lblErrorMessege.Text += "Already present File(s): " + String.Join(", ", FailedFileNames.Select(x => x.ToString()).ToArray());
                lblErrorMessege.Visible = true;
                btnNext.Enabled = true;
                img_entity.Enabled = true;
            }
            else
            {
                lblErrorMessege.Text = "No documents uploaded,</br>All the selected documents are already present for selected Facility " + cmbfacility.SelectedItem.Text;
                lblErrorMessege.Visible = true;
                lblMessege.Visible = false;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    public Guid AddFilesToDocument(string FilePath, string FileName)
    {
        FacilityClient facObjClientCtrl = new FacilityClient();
        FacilityModel facObjFacilityModel = new FacilityModel();
        facObjFacilityModel.Document_Name = FileName;        
        facObjFacilityModel.Fk_row_ids = cmbfacility.SelectedValue;
        facObjFacilityModel.File_path = FilePath;        
        facObjFacilityModel.User_Id = new Guid(SessionController.Users_.UserId.ToString());
        
        facObjFacilityModel.Document_Id = new Guid(Guid.Empty.ToString());
        facObjFacilityModel.Old_Document_Name = string.Empty;        
        facObjFacilityModel.Entity = string.Empty;
        facObjFacilityModel.Facility_Ids = string.Empty;
        facObjFacilityModel.Description = string.Empty;
        facObjFacilityModel.Document_type_id = new Guid(Guid.Empty.ToString());
        facObjFacilityModel.Fk_stage_id = new Guid(Guid.Empty.ToString());
        facObjFacilityModel.Fk_approval_id = new Guid(Guid.Empty.ToString());
        facObjFacilityModel.FacilityName = cmbfacility.SelectedValue;
        facObjFacilityModel = facObjClientCtrl.InsertUpdate_DocumentPM(facObjFacilityModel, SessionController.ConnectionString);

        return facObjFacilityModel.New_Document_ID;
    }
  
}