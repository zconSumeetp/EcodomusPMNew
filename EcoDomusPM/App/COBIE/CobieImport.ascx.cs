using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using EcoDomus.Session;
using COBie;
using System.Data;
using Telerik.Web.UI;
using System.IO;
using System.Data.OleDb;
//using COBieDBService;
using System.ServiceProcess;
using System.Management;
//using COBieService12;
using COBieImportService;
using System.Web.UI.HtmlControls;
using System.Threading;
using System.Web.SessionState;
using Facility;

public partial class App_COBIE_CobieImport : System.Web.UI.UserControl
{

    #region Global Variables
    string errormsg = null, filepath, filename;
    Guid uploaded_file_id;

    #endregion

   
    string flag;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
            }
            else
            {
                if (Session["UploadfileId"] != null)
                {
                    COBieClient cc = new COBieClient();
                    COBieModel cm = new COBieModel();
                    cm.uploaded_fileid = new Guid(Session["UploadfileId"].ToString());
                    if (!string.IsNullOrEmpty(hfstrprojectdId.Value))
                    {
                        cm.project_id = hfstrprojectdId.Value;
                    }
                    else
                        cm.project_id = Convert.ToString( Guid.Empty);
                    DataSet ds = cc.get_status_for_uploaded_file(cm, SessionController.ConnectionString);
                
                    if (ds.Tables.Count > 0)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            if (!string.IsNullOrEmpty(Convert.ToString( Session["Project_id"])))
                            {
                                if (Session["Project_id"] == Convert.ToString(SessionController.Users_.ProjectId))
                                {
                                    if ((ds.Tables[0].Rows[0]["status"].ToString() == "N"))
                                        lbluploadmsg.Text = "Importing File, Please wait...";

                                    else if (ds.Tables[0].Rows[0]["status"].ToString() == "ex")
                                        lbluploadmsg.Text = "We're sorry something went wrong, Import Failed...";
                                    else if (ds.Tables[0].Rows[0]["status"].ToString() == "D")

                                        lbluploadmsg.Text = "Please wait, Delete process is in progress, till that time you can not Upload same file...";
                                    else
                                        lbluploadmsg.Text = string.Empty;
                                }
                                else
                                    lbluploadmsg.Text = string.Empty;
                            }
                        }
                    }
                }

                if (SessionController.Users_.UserId != null)
                {

                    if (!IsPostBack)
                    {
                        ruImportLocation.Localization.Select = (string)GetGlobalResourceObject("Resource", "Select");
                        bindimportedfile_grid();

                    }
                    hfstrprojectdId.Value = SessionController.Users_.ProjectId.ToString();

                }
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {

        }

    }

    public void bindimportedfile_grid()
    {
        try
        {
            Guid userid;
            DataSet ds = new DataSet();
            userid = new Guid(SessionController.Users_.UserId);

            COBieClient cc = new COBieClient();
            COBieModel cm = new COBieModel();
            cm.user_id = userid;
            if (!string.IsNullOrEmpty(SessionController.Users_.ProjectId.ToString()))
            {

                cm.project_id = SessionController.Users_.ProjectId.ToString();
          
                ds = cc.get_imported_cobie_files(cm, SessionController.ConnectionString);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        flag = ds.Tables[0].Rows[0]["pk_uploaded_file_id"].ToString();


                    }
                    radgimported_files.DataSource = ds;
                    radgimported_files.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnupload_Click(object sender, EventArgs e)
    {
        upload();

    }


    void upload()
    {
        try
        {
          
           
            string strproject;
            string ExcelFiles = System.Configuration.ConfigurationManager.AppSettings["ExcelFiles"].ToString();
            string strDirExists5 = string.Empty;
            ImportServiceClient ccDB = new ImportServiceClient();
            errormsg = null;
            string constr = SessionController.ConnectionString;
            DataSet ds = new DataSet();
            COBieDBModel cmDB = new COBieDBModel();
            COBieModel cm = new COBieModel();
            COBieClient cc = new COBieClient();
            Byte[] documentcontents = null;

            if (!string.IsNullOrEmpty(hfstrprojectdId.Value.ToString()))
            {

                strproject = hfstrprojectdId.Value.ToString();
                Session["Project_id"] = strproject;

                strDirExists5 = Server.MapPath(ExcelFiles + strproject);
                DirectoryInfo de5 = new DirectoryInfo(strDirExists5);

                if (!de5.Exists)
                {
                    de5.Create();
                }
                foreach (UploadedFile file in ruImportLocation.UploadedFiles)
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

                    if (filename.Substring(filename.Length - 4, 4).ToString().ToLower() == "xlsx" || filename.Substring(filename.Length - 3, 3).ToString().ToLower() == "xls")
                    {
                        filepath = Path.Combine(Server.MapPath(ExcelFiles + strproject), filename);
                  
                        if (File.Exists(filepath))
                        {
                            File.Delete(filepath);
                        }

                        file.SaveAs(filepath, true);

                        FileStream objfilestream = new FileStream(filepath, FileMode.Open, FileAccess.Read);
                        int len = Convert.ToInt32(objfilestream.Length);

                        documentcontents = new Byte[len];
                        objfilestream.Read(documentcontents, 0, len);
                        objfilestream.Close();
                        cmDB.file_name = filename;
                        cmDB.documentcontents = documentcontents;
                        cmDB.project_id = strproject;
                        cm.project_id = cmDB.project_id;
                        cm.file_name = filename;
                        cm.filepath = System.Configuration.ConfigurationManager.AppSettings["ExcelFilesDB"].ToString() + strproject.ToString() + "\\" + filename.ToString();


                        ccDB.SaveFileTO_DBServer(cmDB);

                        cm.pk_import_request_id = new Guid("00000000-0000-0000-0000-000000000000");
                        cm.status = "N";
                        cmDB.userid = new Guid(SessionController.Users_.UserId.ToString());
                        cm.user_id = cmDB.userid;
                        cmDB.clientid = new Guid(SessionController.Users_.ClientID.ToString());
                        cm.clientid = cmDB.clientid;
                        DataSet ds1 = cc.insert_excel_import_request(cm, constr);
                        if (ds1.Tables.Count > 0)
                        {

                            hfstruploaded_file_id.Value = Convert.ToString(ds1.Tables[0].Rows[0]["fk_uploaded_file_id"]);
                        }

                        Session["UploadfileId"] = Convert.ToString(hfstruploaded_file_id.Value);
                        flag = "L";
                                        
                        //lbluploadmsg.Text = "Importing File, Please wait...";
                        lbluploadmsg.Text = "Uploading your file, please wait. After the file is uploaded, see the status of the import under the Status column in the grid below.";
                        bindimportedfile_grid();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:ImportRequestMessage();", true);
                    }
                }
                if (ruImportLocation.UploadedFiles.Count <= 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:ImportRequestMessage(0);", true);
                }
            }
          
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void radgimported_files_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        bindimportedfile_grid();
    }
    protected void radgimported_files_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        bindimportedfile_grid();
    }
    protected void radgimported_files_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        bindimportedfile_grid();
    }
    protected void radgimported_files_ItemCommand(object sender, GridCommandEventArgs e)
    {
        Guid pk_request_id;
        if (e.CommandName == "Deletefile")
        {
            Guid pk_upload_file_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_uploaded_file_id"].ToString());
            COBieModel cm = new COBieModel();
            COBieClient cc = new COBieClient();
       
            FacilityModel fm = new Facility.FacilityModel();
            FacilityClient fc = new Facility.FacilityClient();
            fm.Facility_Ids = pk_upload_file_id.ToString();
            fm.Entity = "Uploaded_file";
          
            Timer1.Enabled = false;
            fc.Set_delete_flag(fm, SessionController.ConnectionString);
       
            Timer1.Enabled = true;
        }
        bindimportedfile_grid();
    }
    protected void Timer1_click(object sender, EventArgs e)
    {
        bindimportedfile_grid();
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs e)
    {
         e.IsValid = (ruImportLocation.InvalidFiles.Count == 0);
    }
    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs e)
    {
        e.IsValid = (ruImportLocation.InvalidFiles.Count == 0);
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
                if (dr_profile["name"].ToString() == "Import")
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
            ruImportLocation.Enabled = false;
            btnupload.Enabled = false;

        }
        else
        {
            ruImportLocation.Enabled = true;
            btnupload.Enabled = true;

        }


        if (delete_permission == "N")
        {
            foreach (GridDataItem item in radgimported_files.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }
        }
        else
        {
            foreach (GridDataItem item in radgimported_files.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = true;
            }
        }


    }

}

