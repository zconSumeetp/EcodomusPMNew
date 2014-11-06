using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using COBie;
using System.Data;
using EcoDomus.Session;
using Facility;
using System.Data.SqlClient;
using System.IO;
using ComponentAce.Compression.ZipForge;
using ComponentAce.Compression.Archiver;

public partial class App_COBIE_CobieExport : System.Web.UI.UserControl
{
    Guid projectId;
    string filepath = string.Empty;
    Guid FileID; string flag;
    Guid fileidguid;
    int ext = 0;
    string myfilename = string.Empty;
    string Export_Docs_foldername = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
            {

                //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
            }
            else
            {
                BindFacility();
                rgexportedfiles.DataBind();
                ViewState["TabIndex"] = 1;
                rtvtypeorgfilters.DataBind();
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);

        }
    }

    public void load_cobie_grid()
    {
        //Tokmo.Common.ImportLocation.Control.import_excel_ByService_control cb_service_crtl = new import_excel_ByService_control(SystemConstants.getConnectionFile());
        //Tokmo.Common.ImportLocation.Model.import_excelByService_model obj_cb_service_model = new Tokmo.Common.ImportLocation.Model.import_excelByService_model();
        //try
        //{
        //    DataSet ds = new DataSet();
        //    obj_cb_service_model.get_projectID = projectId;
        //    obj_cb_service_model.get_userID = user_id;
        //    cb_service_crtl.proc_get_new_record_cb_window_service(obj_cb_service_model, ref ds);
        //    rg_ready_cobie_file.Visible = true;
        //    lbl_msg.Visible = true;
        //    rg_ready_cobie_file.DataSource = ds;
        //    rg_ready_cobie_file.DataBind();
        //}
        //catch (Exception ex)
        //{

        //}
    }

    protected void cmbfacility_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        try
        {
            ((CheckBox)e.Item.FindControl("CheckBox1")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void BindFacility()
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
            cmbfacility.DataTextField = "name";
            cmbfacility.DataValueField = "pk_facility_id";
            cmbfacility.DataSource = ds_facility;
            cmbfacility.DataBind();

            if (ds_facility != null)
            {
                if (ds_facility.Tables[0].Rows.Count == 1)
                {
                    CheckBox checkbox = (CheckBox)cmbfacility.Items[0].FindControl("CheckBox1");
                    checkbox.Checked = true;
                    cmbfacility.SelectedValue = ds_facility.Tables[0].Rows[0]["pk_facility_id"].ToString();
                    cmbfacility.Text = ds_facility.Tables[0].Rows[0]["name"].ToString();

                }
                cmbfacility.Visible = true;
                lblfacility.Visible = true;
                cmbfacility.Enabled = true;

            }


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void radbtn_export_cobie_Click(object sender, EventArgs e)
    {
        try
        {
            if (cmbfacility.SelectedValue != null && cmbfacility.SelectedValue != "")
            {
                string designer_organization_id = "";
                string contrator_organization_id = "";
                if (rtvtypeorgfilters != null)
                {
                    System.Collections.Generic.IList<RadTreeNode> OrganizationCollection = rtvtypeorgfilters.CheckedNodes;

                    if (OrganizationCollection.Count > 0)
                    {
                        foreach (RadTreeNode organization in OrganizationCollection)
                        {
                            if (organization.ParentNode != null)
                            {
                                if (organization.ParentNode.Text == "General Contractor")
                                {
                                    if (organization.ParentNode.Value != Guid.Empty.ToString() && organization.Value != Guid.Empty.ToString())
                                    {
                                        contrator_organization_id = contrator_organization_id + organization.Value.ToString() + ",";
                                    }
                                }
                                else if (organization.ParentNode.Text == "Architects or Engineers") 
                                {
                                    if (organization.ParentNode.Value != Guid.Empty.ToString() && organization.Value != Guid.Empty.ToString())
                                    {
                                        designer_organization_id = designer_organization_id + organization.Value.ToString() + ",";
                                    }
                                }
                            }
                            else
                                break;
                        }
                        if (designer_organization_id.Length > 0)
                            designer_organization_id = designer_organization_id.Substring(0, designer_organization_id.Length - 1);//For removing comma at the end           
                        if (contrator_organization_id.Length > 0)
                            contrator_organization_id = contrator_organization_id.Substring(0, contrator_organization_id.Length - 1);//For removing comma at the end           

                        ///------------------------------------File Path ------------------------------------------///////
                        string filePathFolder = "C:\\inetpub\\wwwroot\\EcoDomus_PM_New_UI\\EcoDomus PM_FM\\Files\\COBiefiles/";
                        ////////////////////////"C:\\inetpub\\wwwroot\\EcoDomus_PM_New_UI\\Files\\COBieFiles

                        string strFile = cmbfacility.SelectedItem.Text + System.DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";

                        string filePath = filePathFolder + strFile;



                        Client.ClientClient obj_ctrl = new Client.ClientClient();
                        Client.ClientModel obj_mdl = new Client.ClientModel();
                        obj_mdl.Pk_request_id = new Guid("00000000-0000-0000-0000-000000000000");
                        obj_mdl.ClientId = new Guid(SessionController.Users_.ClientID);
                        obj_mdl.Fk_facility_id = new Guid(cmbfacility.SelectedValue);
                        obj_mdl.UserId = new Guid(SessionController.Users_.UserId);
                        obj_mdl.Fk_designer_organization_id = designer_organization_id;
                        obj_mdl.Fk_contractor_organization_id = contrator_organization_id;
                        obj_mdl.Fk_project_id = new Guid(SessionController.Users_.ProjectId);
                        obj_mdl.Status = "N";
                        obj_mdl.Cobie_filepath = filePath;

                        obj_ctrl.InsertCobieExportRequest(obj_mdl);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:RequestMessage(0);", true);
                    }
                    else
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:RequestMessage(2);", true);
                }

            }
            else
                ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:RequestMessage(1);", true);
        }
        catch (Exception ex)
        { throw ex; }


    }

    protected void rgexportedfiles_DataBinding(object sender, EventArgs e)
    {
        try
        {
            Bind_exported_file();
        }
        catch (Exception ex)
        { throw ex; }
    }

    private void Bind_exported_file()
    {
        try
        {
            COBieModel cm = new COBieModel();
            COBieClient cc = new COBieClient();
            cm.user_id = new Guid(SessionController.Users_.UserId);
            cm.project_id = SessionController.Users_.ProjectId;
            DataSet ds = cc.proc_get_exportedfile(cm, SessionController.ConnectionString);
            rgexportedfiles.DataSource = ds;
        }
        catch (Exception ex)
        { throw ex; }
    }

    protected void rgexportedfiles_ItemCommand(object sender, GridCommandEventArgs e)
    {
        Guid pk_request_id;
        if (e.CommandName == "Deletefile")
        {
            pk_request_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_request_id"].ToString());

            COBieModel cm = new COBieModel();
            COBieClient cc = new COBieClient();
            cm.Pk_request_id = pk_request_id;
            cc.proc_DeleteFile(cm, SessionController.ConnectionString);
            Bind_exported_file();
        }
    }

    protected void rgexportedfiles_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (SessionController.Users_.ProjectId != null && SessionController.Users_.ProjectId != Guid.Empty.ToString())
        {
            Bind_exported_file();
        }

    }

    protected void Timer1_click(object sender, EventArgs e)
    {
        rgexportedfiles.Rebind();
    }

    protected void rtvtypeorgfilters_OnDataBinding(object sender, EventArgs e)
    {
        try
        {
            Bind_designer_contractor();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void Bind_designer_contractor()
    {
        try
        {
            COBieModel cm = new COBieModel();
            COBieClient cc = new COBieClient();
            cm.project_id = SessionController.Users_.ProjectId.ToString();
            DataSet ds = cc.proc_get_designer_contractor_export(cm, SessionController.ConnectionString);
            rtvtypeorgfilters.DataSource = ds;
            rtvtypeorgfilters.ExpandAllNodes();
        }
        catch (Exception ex)
        { 
            throw ex;
        }
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    SetPermissions();
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='BIM Server'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Export")
                {
                    SetPermissionToControl(dr_profile);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SetPermissionToControl(DataRow dr)
    {
        Permissions objPermission = new Permissions();
        string delete_permission = dr["delete_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();
        if (edit_permission == "N")
        {
            radbtn_export_cobie.Enabled = false;
        }
        else
        {
            radbtn_export_cobie.Enabled = true;
        }


        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rgexportedfiles.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }
        }
        else
        {
            foreach (GridDataItem item in rgexportedfiles.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = true;
            }
        }


    }

    protected void btn_download_doc_Click(object sender, EventArgs e)
    {
        UInt64 NoOfFilesToBeDownloaded = 0;
        bool copiedfileflag = false;
        string strSelectedFacilityId = "";

        try
        {

            if (cmbfacility.SelectedValue != null && cmbfacility.SelectedValue != "")
            {
                FacilityModel fm = new FacilityModel();
                FacilityClient fc = new FacilityClient();
                DataSet ds = new DataSet();
                fm.Facility_id = new Guid(cmbfacility.SelectedValue);
                strSelectedFacilityId = cmbfacility.SelectedValue;



                ds = fc.GetFilesByFacilityForExport(fm, SessionController.ConnectionString);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    NoOfFilesToBeDownloaded = CopyFilesTo(ds, strSelectedFacilityId);
                    copiedfileflag = true;
                    if (copiedfileflag)
                    {
                        string folderpath = Server.MapPath("~/App/Files/Export_Docs/Export_Docs_" + System.DateTime.Now.ToString("yyyyMMddHHmmss") + "/");
                        if (!Directory.Exists(folderpath))
                        {
                            Directory.CreateDirectory(folderpath);
                        }
                        string Zipfolderpath = Server.MapPath("~/App/Files/Export_Docs/");

                        // Zip(folderpath, Export_Docs_foldername, Zipfolderpath);

                        ZIPFOLDER(Zipfolderpath + Export_Docs_foldername, folderpath);

                        if (NoOfFilesToBeDownloaded > 0)
                        {
                            Response.Redirect("~/App/Files/Export_Docs/" + Export_Docs_foldername + ".zip", true);
                        }
                        else
                        {
                        }
                    }
                }
            }
            else
            {
            }
        }

        catch (Exception ex)
        {
            throw ex;
        }

    }

    public UInt64 CopyFilesTo(DataSet Attached_files, string strSelectedFacilityId)
    {
        string files_Directory = "";
        string Server_filepath = "";
        string projectId = "";
        string filename = "";
        UInt64 NoOfFilesToBeDownloaded = 0;
        for (int i = 0; i < Attached_files.Tables[0].Rows.Count; i++)
        {
            try
            {

                Export_Docs_foldername = "Export_Docs_" + System.DateTime.Now.ToString("yyyyMMddHHmmss")+"";

                if (Attached_files.Tables[0].Rows[i]["filepath"].ToString().Contains("Documents"))
                {
                    files_Directory = Server.MapPath("~/App/Files/Export_Docs/" + "Export_Docs_" + System.DateTime.Now.ToString("yyyyMMddHHmmss") + "/");
                }
                string path = "";
                //Create Directory for tbl_uploaded_files_Directory
                if (!Directory.Exists(files_Directory))
                {
                    //Directory.Delete(files_Directory, true);
                    Directory.CreateDirectory(files_Directory);
                }
                if (Attached_files.Tables[0].Rows[i]["filename"] != null || Attached_files.Tables[0].Rows[i]["filename"] != "")
                {
                    filename = Attached_files.Tables[0].Rows[i]["filename"].ToString();
                }
                Server_filepath = Attached_files.Tables[0].Rows[i]["filepath"].ToString();


                path = Server.MapPath(Server_filepath);

                if (File.Exists(path))
                {

                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script2", "javascript:alert('" + files_Directory + filename + "')", true);

                    File.Copy(path, files_Directory + filename, true);

                    NoOfFilesToBeDownloaded++;
                }
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "script2", "javascript:alert('" + NoOfFilesToBeDownloaded + "')", true);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }

        return NoOfFilesToBeDownloaded;


    }
    public void Zip(string fileToZip, string filename, string Zipfolderpath)
    {

        try
        {
            Chilkat.Zip zip = new Chilkat.Zip();
            bool unlocked = false;
            unlocked = zip.UnlockComponent("IGORSTZIP_rxLaHG9qnWwG");
            if ((!unlocked))
            {
                return;
            }
            //fileToZip & Zip Folder Name
            string Path = fileToZip;
            zip.NewZip(Zipfolderpath + filename + ".zip");
            bool success = false;
            success = zip.AppendFiles(fileToZip, true);
            if ((!success))
            {
                return;
            }
            success = zip.WriteZipAndClose();
        }
        catch (Exception ep)
        {

        }
    }


    public void ZIPFOLDER(string FOLDERSTING, string sourcepath)
    {
        ZipForge archiver = new ZipForge();

        try
        {
            // Set the name of the archive file we want to create
            archiver.FileName = FOLDERSTING + ".zip";

            // Because we create a new archive, 
            // we set fileMode to System.IO.FileMode.Create
            archiver.OpenArchive(System.IO.FileMode.Create);
            // Set base (default) directory for all archive operations
            archiver.BaseDir = FOLDERSTING;
            // Add the c:\Test folder to the archive with all subfolders
            archiver.AddFiles("*.*");
            archiver.CloseArchive();
            // Catch all exceptions of the ArchiverException type        
        }
        catch (ArchiverException ae)
        {
            Console.WriteLine("Message: {0} Error code: {1}", ae.Message, ae.ErrorCode);
            // Wait for the  key to be pressed
            Console.ReadLine();
        }

    }

}