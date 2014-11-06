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
    Guid pk_document_id = Guid.Empty;


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
            BindCategories();
            BindStages();
            BindApprovalby();            
            
           if (Request.QueryString["Document_Id"] != Guid.Empty.ToString() )
            {
                if (Request.QueryString["Flag"] == "Model")
                {
                    hdnfrommodel.Value = "True";
                }
                if (Request.QueryString["Flag"] == "Model"  && Request.QueryString["Item_type"]=="Asset")
                {
                    btn_delete.Visible = true;
                    Bind_Entity();
                    FacilityModel fm = new FacilityModel();
                    FacilityClient fc = new FacilityClient();
                    DataSet ds = new DataSet();
                    fm.Facility_id = new Guid(Request.QueryString["fk_row_id"].ToString());
                    fm.Doc_flag = Request.QueryString["Item_type"];
                    ds = fc.Get_Entity_Name_Document(fm, SessionController.ConnectionString);
                    lbl_Component.Visible = true;
                    //lbl_Component.Text = "Asset:";
                    //lbl_Component.Text = "Entity:";

                    if (Request.QueryString["entity_name"].ToString() == "Type")
                    {
                        //lbl_Component.Text = "Type Name:";
                        lbl_Type_name.Visible = true;
                        lbl_Component.Visible = false;
                        lbl_Space_Name.Visible = false;


                        lbl_Component_Name.Visible = true;
                        lbl_Component_Name.Text = ds.Tables[0].Rows[0]["typename"].ToString();
                        cmb_sheet_name.SelectedItem.Text = "Type";
                        hf_type_id.Value = Request.QueryString["entity_id"].ToString();
                    }
                    else if (Request.QueryString["entity_name"].ToString() == "Asset")
                    {
                        //lbl_Component.Text = "Asset Name:";
                        lbl_Type_name.Visible = false;
                        lbl_Component.Visible = true;
                        lbl_Space_Name.Visible = false;

                        lbl_Component_Name.Visible = true;
                        lbl_Component_Name.Text = ds.Tables[0].Rows[0]["name"].ToString();
                        cmb_sheet_name.SelectedItem.Text = "Asset";
                        //hf_type_id.Value = Request.QueryString["fk_row_id"].ToString();
                    }

                    //lbl_Component_Name.Visible = true;
                    //lbl_Component_Name.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    cmb_sheet_name.Enabled = false;
                    hf_document_id.Value = Request.QueryString["Document_Id"].ToString();
                    Bind_Document_by_Id(hf_document_id.Value);

                }

                else if (Request.QueryString["Flag"] == "Model"  && Request.QueryString["Item_type"]=="Space")
                {
                    btn_delete.Visible = true;
                    hdnfrommodel.Value = "True";
                    Bind_Entity();
                    FacilityModel fm = new FacilityModel();
                    FacilityClient fc = new FacilityClient();
                    DataSet ds = new DataSet();
                    fm.Facility_id = new Guid(Request.QueryString["fk_row_id"].ToString());
                    fm.Doc_flag = Request.QueryString["Item_type"];
                    ds = fc.Get_Entity_Name_Document(fm, SessionController.ConnectionString);
                    lbl_Component.Visible = false;
                    //lbl_Component.Text = "Space:"; earlier
                    //lbl_Component.Text = "Entity:";

                    //lbl_Component.Text = "Space Name:";
                    lbl_Space_Name.Visible = true;
                    lbl_Component_Name.Visible = false;
                    lbl_Type_name.Visible = false;


                    cmb_sheet_name.SelectedItem.Text = "Space";
                    cmb_sheet_name.Enabled = false;

                    lbl_Component_Name.Visible = true;
                    lbl_Component_Name.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    hf_document_id.Value = Request.QueryString["Document_Id"].ToString();
                    Bind_Document_by_Id(hf_document_id.Value);
                }
                else
                {
                    hf_document_id.Value = Request.QueryString["Document_Id"].ToString();
                    Bind_Document_by_Id(hf_document_id.Value);
                    lbl_add_document.Visible = false;
                    cmb_sheet_name.Visible = false;
                    lbl_Component.Visible = false;
                    lbl_Component_Name.Visible = false;
                    btn_delete.Visible = false;
                }
            }
            else
            {
                if (Request.QueryString["Flag"] == "Model" && Request.QueryString["Item_type"]=="Asset")
                {

                    btn_delete.Visible = false;
                    hdnfrommodel.Value = "True";
                    Bind_Entity();
                    cmb_sheet_name.SelectedValue = "Asset";
                    FacilityModel fm = new FacilityModel();
                    FacilityClient fc = new FacilityClient();
                    DataSet ds = new DataSet();
                    if (Request.QueryString["fk_row_id"].ToString() == Guid.Empty.ToString())
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "Validation();", true);
                    }
                    else
                    {
                        fm.Facility_id = new Guid(Request.QueryString["fk_row_id"].ToString());
                    }
                    fm.Doc_flag = Request.QueryString["Item_type"];
                    ds = fc.Get_Entity_Name_Document(fm, SessionController.ConnectionString);
                    lbl_Component.Visible = true;
                    //lbl_Component.Text = "Asset:"; earlier

                    //lbl_Component.Text = "Entity:";
                    lbl_Component_Name.Visible = true;

                    if (cmb_sheet_name.SelectedItem.Text == "Asset")
                    {
                        //lbl_Component.Text = "Asset Name:";
                        lbl_Type_name.Visible = false;
                        lbl_Component.Visible = true;
                        lbl_Space_Name.Visible = false;
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            lbl_Component_Name.Text = ds.Tables[0].Rows[0]["name"].ToString();
                        }
                        else
                        {
                            lbl_Component_Name.Text = "";
                        }
                        hf_asset_id.Value = Request.QueryString["fk_row_id"].ToString();

                    }
                    else if (cmb_sheet_name.SelectedItem.Text == "Type")
                    {
                        //lbl_Component.Text = "Type Name:";
                        lbl_Type_name.Visible = true;
                        lbl_Component.Visible = false;
                        lbl_Space_Name.Visible = false;

                        lbl_Component_Name.Text = ds.Tables[0].Rows[0]["typename"].ToString();
                        hf_type_id.Value = ds.Tables[0].Rows[0]["pk_type_id"].ToString();
                    }

                    hf_document_id.Value = Guid.Empty.ToString();    


                    //lbl_Component_Name.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    //hf_document_id.Value = Guid.Empty.ToString();                

                }
                else if (Request.QueryString["Flag"] == "Model" && Request.QueryString["Item_type"] == "Space")
                {
                    btn_delete.Visible = false;
                    hdnfrommodel.Value = "True";
                    Bind_Entity();                   
                    FacilityModel fm = new FacilityModel();
                    FacilityClient fc = new FacilityClient();
                    DataSet ds = new DataSet();
                    fm.Facility_id = new Guid(Request.QueryString["fk_row_id"].ToString());
                    fm.Doc_flag = Request.QueryString["Item_type"];
                    ds = fc.Get_Entity_Name_Document(fm, SessionController.ConnectionString);
                    lbl_Component.Visible = true;
                    //lbl_Component.Text = "Space:";
                    //lbl_Component.Text = "Entity:";

                    //lbl_Component.Text = "Space Name:";
                    lbl_Type_name.Visible = false;
                    lbl_Component.Visible = false;
                    lbl_Space_Name.Visible = true;

                    lbl_Component_Name.Visible = true;
                    lbl_Component_Name.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    hf_document_id.Value = Guid.Empty.ToString();      

                }
                else if (Request.QueryString["Flag"] == "Model" && Request.QueryString["Item_type"] == "System")
                {
                    btn_delete.Visible = false;
                    hdnfrommodel.Value = "True";
                    Bind_Entity();
                    FacilityModel fm = new FacilityModel();
                    FacilityClient fc = new FacilityClient();
                    DataSet ds = new DataSet();
                    fm.Facility_id = new Guid(Request.QueryString["fk_row_id"].ToString());
                    fm.Doc_flag = Request.QueryString["Item_type"];
                    ds = fc.Get_Entity_Name_Document(fm, SessionController.ConnectionString);
                    lbl_Component.Visible = false;
                    lbl_system_name.Visible = true;
                    lbl_Component_Name.Visible = true;
                    lbl_Component_Name.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    hf_document_id.Value = Guid.Empty.ToString();   
                }
                else
                {
                    btn_delete.Visible = false;
                    txtName.Text = "";
                    hf_document_id.Value = Guid.Empty.ToString();
                    lbl_add_document.Visible = false;
                    cmb_sheet_name.Visible = false;
                    lbl_Component.Visible = false;
                    lbl_Component_Name.Visible = false;
                    Bind_Entity();
                }

            }
        }
    }

    protected void page_prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {

                btn_delete.Visible = false;
                BtnDocSave.Visible = false;
            }

            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    {
                        SetPermissions();
                    }
                }
            }
        }
        catch (Exception es)
        {
            throw es;
        }
    }

    protected void Bind_Entity()
    {
        DataSet ds = new DataSet();
        FacilityModel fm = new FacilityModel();
        FacilityClient facObjClientCtrl = new FacilityClient();
        try
        {
            if (Request.QueryString["Flag"] == "Model" && Request.QueryString["Item_type"] == "Asset")
            {
                cmb_sheet_name.DataValueField = "ID";
                cmb_sheet_name.DataTextField = "Name";
                fm.Doc_flag = "a";
                cmb_sheet_name.DataSource = facObjClientCtrl.Get_Entity_Model_Viewer(fm,SessionController.ConnectionString);
                cmb_sheet_name.SelectedIndex = 0;
                cmb_sheet_name.DataBind();
            }
            else if (Request.QueryString["Flag"] == "Model" && Request.QueryString["Item_type"] == "Space")
            {
                cmb_sheet_name.DataValueField = "ID";
                cmb_sheet_name.DataTextField = "Name";
                fm.Doc_flag = "s";
                cmb_sheet_name.DataSource = facObjClientCtrl.Get_Entity_Model_Viewer(fm,SessionController.ConnectionString);
                cmb_sheet_name.SelectedIndex = 1;
                cmb_sheet_name.DataBind();
            }
            else if (Request.QueryString["Flag"] == "Model" && Request.QueryString["Item_type"] == "System")
            {
                cmb_sheet_name.DataValueField = "ID";
                cmb_sheet_name.DataTextField = "Name";
                fm.Doc_flag = "Sys";
                cmb_sheet_name.DataSource = facObjClientCtrl.Get_Entity_Model_Viewer(fm, SessionController.ConnectionString);
                cmb_sheet_name.SelectedIndex = 1;
                cmb_sheet_name.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
      
    protected void Bind_Document_by_Id(string document_id)
    {
        DataSet ds = new DataSet();
        FacilityClient facObjClientCtrl = new FacilityClient();
        FacilityModel facObjFacilityModel = new FacilityModel();

        try
        {
            facObjFacilityModel.Document_Id =new Guid(document_id.ToString());
            ds = facObjClientCtrl.Get_document_document_profile(facObjFacilityModel,SessionController.ConnectionString);
            txtName.Text = ds.Tables[0].Rows[0]["document_name"].ToString();
           
             rcbcategory.SelectedValue = ds.Tables[0].Rows[0]["fk_document_type_id"].ToString();
             rcbstage.SelectedValue = ds.Tables[0].Rows[0]["fk_stage_id"].ToString();
          
             rcbapprovalby.SelectedValue = ds.Tables[0].Rows[0]["fk_approval_by_id"].ToString();

            hfAttachedFile.Value=ds.Tables[0].Rows[0]["file_path"].ToString();
            lbl_document_path.Text = hfAttachedFile.Value;
            lbl_document_path.Visible = false;
        }
        catch (Exception ex)
        {
            throw ex;
        }
     }

    protected void btnDocSave_Click(object sender, EventArgs e)
    {
        try
        {
            FacilityClient facObjClientCtrl = new FacilityClient();
            FacilityModel facObjFacilityModel = new FacilityModel();
            //---To get 1 or more facilities of the entity -------------------------
            DataSet ds_facility = new DataSet();
            facObjFacilityModel.Fk_row_ids= Request.QueryString["fk_row_id"].ToString();
      
            facObjFacilityModel.Entity =  Request.QueryString["Item_type"];
            ds_facility = facObjClientCtrl.GetFacility_of_entity(facObjFacilityModel, SessionController.ConnectionString);
            //----------------------------------------------------------------------
            #region commented
            //System.Text.StringBuilder FacilityIds = new System.Text.StringBuilder();
            //for (int k = 0; k < ds_facility.Tables[0].Rows.Count; k++)
            //{
            //    FacilityIds.Append(ds_facility.Tables[0].Rows[k]["Facility_id"].ToString());
            //    FacilityIds.Append(",");
                
            //}
            //if (FacilityIds.ToString().Length > 0)
            //{
            //    FacilityIds = FacilityIds.Remove(FacilityIds.ToString().Length - 1, 1);
            //}
            //facObjFacilityModel.Facility_Ids = FacilityIds.ToString();
            #endregion


            //for (int j = 0; j < ds_facility.Tables[0].Rows.Count; j++)
            //{
                
                facObjFacilityModel.Document_Id = new Guid(hf_document_id.Value.ToString());
                facObjFacilityModel.Fk_row_id = new Guid(Request.QueryString["fk_row_id"]);
                //facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);

                facObjFacilityModel.Facility_id  = new Guid(ds_facility.Tables[0].Rows[0]["Facility_id"].ToString());
                if (Request.QueryString["flag"] == "Model")
                {
                    facObjFacilityModel.Entity = cmb_sheet_name.SelectedItem.Text.ToString(); 
                }
                else
                {
                     facObjFacilityModel.Entity =Request.QueryString["Item_type"];
                }
                    facObjFacilityModel.Document_type_id = new Guid(rcbcategory.SelectedValue);
                facObjFacilityModel.Fk_stage_id = new Guid(rcbstage.SelectedValue);
                facObjFacilityModel.Fk_approval_id = new Guid(rcbapprovalby.SelectedValue);
                //string strFacilityId = SessionController.Users_.facilityID.ToString();
                string strFacilityId = ds_facility.Tables[0].Rows[0]["Facility_id"].ToString();
                

                string filename = DocumentUpload(strFacilityId);
                facObjFacilityModel.Document_Name = txtName.Text;

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


                   

                        filepath = Path.Combine(Server.MapPath(CommonVirtualPath + "/Documents/" + strFacilityId), filename);
                        hfAttachedFile.Value = CommonVirtualPath + "/Documents/" + strFacilityId + "/" + filename;
                        file.SaveAs(filepath, true);
                    
                   

                }
                facObjFacilityModel.File_path = hfAttachedFile.Value;


                lbl_document_path.Text = hfAttachedFile.Value;//added


                facObjFacilityModel = facObjClientCtrl.Add_Facility_DocumentPM(facObjFacilityModel, SessionController.ConnectionString);
                string existsflag = facObjFacilityModel.existsflag;
                string newDocument_id = facObjFacilityModel.New_Document_ID.ToString();

                //ViewState["existsflagvalue"]= existsflag;
                if (existsflag == "Y")
                {
                    lblMsg.Text = "Document with this name already exists..!";
                    
                }
            //} // for closed.    
                else
                {
                   string nw = "<script language='javascript'>DocumentGrid();</script>";
                   Page.ClientScript.RegisterStartupScript(this.GetType(), "scriptOrgId", nw);
                }
            
                           
        }
        catch (Exception ex) 
        {
            throw ex;
        }

    }
 
    protected void BindCategories()
    { 
        try
        {
            DataSet ds_doc_type = new DataSet();
            LocationsClient locObj_crtl = new LocationsClient();
            LocationsModel locObj_mdl = new LocationsModel();

            locObj_mdl.Attribute_template_id = Guid.Empty;
            locObj_mdl.ProjectId =  new Guid(SessionController.Users_.ProjectId);

            locObj_mdl.OrganizationID = SessionController.Users_.OrganizationID;
            ds_doc_type = locObj_crtl.get_document_type(SessionController.ConnectionString,locObj_mdl);

            rcbcategory.DataTextField = "type_name";
            rcbcategory.DataValueField = "doc_type_id";
            rcbcategory.DataSource = ds_doc_type;
            rcbcategory.DataBind();
        }
        catch (Exception ex)
        {

            lblMsg.Text = "btnDocSave_Click :-" + ex.Message.ToString();
        }

    }

    protected void BindStages()
    { 

        try
        {

            DataSet ds_stages = new DataSet(); 
            LocationsClient locObj_crtl = new LocationsClient();
            LocationsModel locObj_mdl = new LocationsModel();
            locObj_mdl.OrganizationID = SessionController.Users_.OrganizationID;
            ds_stages = locObj_crtl.get_stages(SessionController.ConnectionString);

            rcbstage .DataTextField = "stage_name";
            rcbstage.DataValueField = "id";
            rcbstage.DataSource = ds_stages;
            rcbstage.DataBind();
        }
        catch (Exception ex)
        {

            lblMsg.Text = "btnDocSave_Click :-" + ex.Message.ToString();
        }

    }

    protected void BindApprovalby()
    { 

        try
        {

            DataSet ds_Approvalby = new DataSet(); 
            LocationsClient locObj_crtl = new LocationsClient();
            LocationsModel locObj_mdl = new LocationsModel();                       


            

            locObj_mdl.OrganizationID = SessionController.Users_.OrganizationID;
            ds_Approvalby = locObj_crtl.get_approval_by(SessionController.ConnectionString);

            rcbapprovalby.DataTextField = "approval_by";
            rcbapprovalby.DataValueField = "id";
            rcbapprovalby.DataSource = ds_Approvalby;
            rcbapprovalby.DataBind();
        }
        catch (Exception ex)
        {

            lblMsg.Text = "btnDocSave_Click :-" + ex.Message.ToString();
        }

    }

    public string DocumentUpload(string strFacilityId)
    {
        //string strFacilityId = SessionController.Users_.facilityID.ToString();

        string strDirExists = string.Empty;
        string filename = "";
        string filepath = string.Empty;
        try
        {
            
            //strDirExists = Server.MapPath("~/App/Files/Documents/" + strFacilityId);

            strDirExists = Server.MapPath(CommonVirtualPath + "/Documents/" + strFacilityId);


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
                
                //filepath = Path.Combine(Server.MapPath("~/App/Files/Documents/" + strFacilityId), filename);
                //hfAttachedFile.Value = "~/App/Files/Documents/" + strFacilityId + "/" + filename;

                filepath = Path.Combine(Server.MapPath(CommonVirtualPath + "/Documents/" + strFacilityId), filename);
                hfAttachedFile.Value = CommonVirtualPath + "/Documents/" + strFacilityId + "/" + filename;

                file.SaveAs(filepath, true);
        
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "DocumentUpload :-" + ex.Message.ToString();
        }
        return filename;

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

    protected void btn_delete_Click(object sender, EventArgs e)
    {
        try
        {
            Guid document_id = new Guid(Request.QueryString["Document_Id"].ToString());
            FacilityClient facObjClientCtrl = new FacilityClient();
            FacilityModel facObjFacilityModel = new FacilityModel();
            facObjFacilityModel.Document_Id = document_id;
            facObjClientCtrl.Delete_Document(facObjFacilityModel, SessionController.ConnectionString);
            string nw = "<script language='javascript'>select();</script>";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "scriptOrgId", nw);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void cmb_sheet_name_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        DataSet ds = new DataSet();
        fm.Facility_id = new Guid(Request.QueryString["fk_row_id"].ToString());
        fm.Doc_flag = Request.QueryString["Item_type"];
        ds = fc.Get_Entity_Name_Document(fm, SessionController.ConnectionString);
        if (cmb_sheet_name.SelectedItem.Text == "Type")
        {
            //lbl_Component.Text = "Type Name:"; earlier

            lbl_Type_name.Visible = true;
            lbl_Component.Visible = false;
            lbl_Space_Name.Visible = false;

            lbl_Component_Name.Text = ds.Tables[0].Rows[0]["typename"].ToString();
            hf_type_id.Value = ds.Tables[0].Rows[0]["pk_type_id"].ToString();
        }
        else if (cmb_sheet_name.SelectedItem.Text == "Asset")
        {
            //lbl_Component.Text="Asset Name:"; earlier

            lbl_Type_name.Visible = false;
            lbl_Component.Visible = true;
            lbl_Space_Name.Visible = false;


            lbl_Component_Name.Text = ds.Tables[0].Rows[0]["name"].ToString();
            hf_asset_id.Value = Request.QueryString["fk_row_id"].ToString();
        }
    }

    private void SetPermissions()
    {
        try
        {
            string str = Request.QueryString.ToString();
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='BIM Server'")[0];
            SetPermissionToControl(dr_component);


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SetPermissionToControl(DataRow dr)
    {
        Permissions objPermission = new Permissions();
        string edit_permission = dr["edit_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();
      


        if (delete_permission == "N")
        {
            btn_delete.Enabled = false;
        }
        else
        {
            btn_delete.Enabled = true;
        }


        //if (edit_permission == "N")
        //{
        //    BtnDocSave.Enabled = false;
        //}
        //else
        //{
        //    BtnDocSave.Enabled = true;
        //}

    }
}

