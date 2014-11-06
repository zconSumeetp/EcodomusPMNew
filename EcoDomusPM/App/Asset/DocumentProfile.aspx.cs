using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Telerik.Web.UI;
using EcoDomus.Session;
using Facility;
using Locations;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using AttributeTemplate;
using System.Globalization;
using System.Threading;
using System.Configuration;


public partial class App_Asset_DocumentProfile : System.Web.UI.Page
{
    string CommonVirtualPath = ConfigurationManager.AppSettings["CommonFilePath"].ToString();


    #region page events
    protected void Page_PreInit(object sender, EventArgs e)
    {

        if (Request.QueryString["popupflag"] == "popup")
        {
            //Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";

        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null && SessionController.Users_.UserId != string.Empty)
        {
            if (Convert.ToString(Request.QueryString["popupflag"]) == "popup")
            {
                hfpopupflag.Value = Convert.ToString(Request.QueryString["popupflag"]);
                tblHeader1.Style.Value = " display:inline;margin:2px 0px 2px 2px;";
                Label3.Visible = true;
                Label1.Visible = false;
                
                

                //divLeftSpace.Style.Value = "padding-left:20px;";

               //divProfilePage.Style.Add("margin-left", "20px");
                btnclose.Visible = true;
            }
            else
            {
                
                btnclose.Visible = false;
                Label1.Visible = false;
                Label3.Visible = false;
                
            }
                 
            if (!IsPostBack)
            {
                BindCategories();
                BindStages();
                BindApprovalby();
                BindEntity();
                if (Request.QueryString["DocumentId"] != null)
                {
                    if (Request.QueryString["DocumentId"] != Guid.Empty.ToString())
                    {
                        hf_document_id.Value = Request.QueryString["DocumentId"].ToString();
                        hf_row_ids.Value = Request.QueryString["fk_row_id"].ToString();
                        hf_entity_name.Value = Convert.ToString(Request.QueryString["entity_name"]);
                        // HiddenField hf = (HiddenField)PreviousPage.Master.FindControl("hf_row_ids");

                        if (!IsPostBack)
                        {
                            EnableDisable("D");
                            BindDocumentProfile();
                        }

                    }
                    else
                    {
                        EnableDisable("E");
                        hf_document_id.Value = Guid.Empty.ToString();

                    }
                    if (Request.QueryString["entity_name"] != null)
                    {

                        hf_entityname.Value = Request.QueryString["entity_name"].ToString();
                    }
                }
            }
        }
    }
    #endregion

    #region Eventhandlers
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (lblentityname.Text != "")
            {
                hf_lbl_entitynames.Value = lblentityname.Text;
            }

            if (hf_row_ids.Value != "" && hf_lbl_entitynames.Value != "")
            {
                string strFacilityId = "";
                FacilityClient facObjClientCtrl = new FacilityClient();
                FacilityModel facObjFacilityModel = new FacilityModel();
                //---To get 1 or more facilities of the entity -------------------------
                DataSet ds_facility = new DataSet();
                if (hf_row_ids.Value != "")
                {
                    facObjFacilityModel.Fk_row_ids = hf_row_ids.Value.ToString();
                }
                else
                {
                    facObjFacilityModel.Fk_row_ids = Guid.Empty.ToString();
                }
                facObjFacilityModel.Entity = rcbentity.Text.ToString();
                ds_facility = facObjClientCtrl.GetFacility_of_entity(facObjFacilityModel, SessionController.ConnectionString);
                if (ds_facility.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < ds_facility.Tables[0].Rows.Count; i++)
                    {
                        strFacilityId = strFacilityId + ds_facility.Tables[0].Rows[i]["Facility_id"] + ",";

                    }
                    strFacilityId = strFacilityId.Substring(0, strFacilityId.Length - 1);
                    //strFacilityId = ds_facility.Tables[0].Rows[0]["Facility_id"].ToString();
                    facObjFacilityModel.FacilityName = ds_facility.Tables[0].Rows[0]["Facility_id"].ToString();
                }
                else
                {
                    strFacilityId = "";
                }


                //-----------------------------------------------------------------------

                facObjFacilityModel.User_Id = new Guid(SessionController.Users_.UserId.ToString());
                facObjFacilityModel.Document_Id = new Guid(Request.QueryString["DocumentId"]);
                if (Request.QueryString["DocumentId"].ToString() == Guid.Empty.ToString())
                {

                    facObjFacilityModel.Old_Document_Name = "";
                }
                else
                {
                    facObjFacilityModel.Old_Document_Name = hf_old_document_name.Value;

                }
                if ((hf_row_ids.Value == null) || (hf_row_ids.Value == ""))
                {
                    facObjFacilityModel.Fk_row_ids = Guid.Empty.ToString();
                }
                else
                {
                    facObjFacilityModel.Fk_row_ids = hf_row_ids.Value.ToString();
                }

                facObjFacilityModel.Entity = rcbentity.Text;
                facObjFacilityModel.Document_type_id = new Guid(rcbcategory.SelectedValue);
                facObjFacilityModel.Fk_stage_id = new Guid(rcbstage.SelectedValue);
                facObjFacilityModel.Fk_approval_id = new Guid(rcbapproval.SelectedValue);


                string filename = DocumentUpload(strFacilityId);


                facObjFacilityModel.Document_Name = txtname.Text;
                facObjFacilityModel.Description = txtdescription.Text;

                string filepath = string.Empty;
                List<String> ls = new List<string>();
                ls = strFacilityId.Split(',').ToList();
                foreach (String item in ls)
                {
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
                        
                        //filepath = Path.Combine(Server.MapPath("~/App/Files/Documents/" + item), filename);
                        //hfAttachedFile.Value = "~/App/Files/Documents/" + item + "/" + filename;

                        filepath = Path.Combine(Server.MapPath(CommonVirtualPath + "/Documents/" + item), filename);
                        hfAttachedFile.Value = CommonVirtualPath + "Documents/" + item + "/" + filename;


                        file.SaveAs(filepath, true);

                    }
                }
                facObjFacilityModel.File_path = hfAttachedFile.Value;


                lbl_document_path.Text = hfAttachedFile.Value;//added
                facObjFacilityModel.Facility_Ids = hf_row_ids_old.Value;
               
                facObjFacilityModel = facObjClientCtrl.InsertUpdate_DocumentPM(facObjFacilityModel, SessionController.ConnectionString);
                string existsflag = facObjFacilityModel.existsflag;
                string newDocument_id = facObjFacilityModel.New_Document_ID.ToString();
                hf_document_id.Value = newDocument_id.ToString();
                lblMsg.Text += "Document with this name already exists for entity name:";
                if (!string.IsNullOrEmpty(existsflag) && (rcbentity.Text == "Type" || rcbentity.Text == "Asset" || rcbentity.Text == "Facility" || rcbentity.Text == "Space") && (existsflag != "N"))
                {
                    string[] output_flag = existsflag.Split(',');
                    foreach (string existsflagitem in output_flag)
                    {
                        if (existsflagitem != "")
                        {
                            string[] output = existsflagitem.Split(':');

                            lblMsg.Text += Environment.NewLine + output[1];
                        }

                    }

                    if (lblMsg.Text == "Document with this name already exists for entity name:")
                    {
                        lblMsg.Text = "";

                    }
                }
                else
                    if (existsflag == "Y")
                    {

                        lblMsg.Text = "Document with this name already exists.!!";
                    }
                    else
                    {
                        lblMsg.Text = "";
                        hf_entity_name.Value = rcbentity.Text;
                        BindDocumentProfile();
                        EnableDisable("D");
                        string value = "";
                        if (hfpopupflag.Value == "popup")
                            value = "<script language='javascript'>GotoProfilepopup('" + hf_document_id.Value + "','" + hf_row_ids.Value + "','" + hf_entity_name.Value + "')</script>";
                        else
                            value = "<script language='javascript'>GotoProfile('" + hf_document_id.Value + "','" + hf_row_ids.Value + "','" + hf_entity_name.Value + "')</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
                        //string nw = "<script language='javascript'>select();</script>";
                        // Page.ClientScript.RegisterStartupScript(this.GetType(), "scriptOrgId", nw);
                        //Response.Redirect("~/App/Asset/DocumentMenu.aspx?DocumentId=" + hf_document_id.Value + "&fk_row_id=" + hf_row_ids.Value + "&entity_name=" + facObjFacilityModel.Entity, false);
                    }
            }

            else
            {
                lblvalidate.Visible = true;
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        EnableDisable("E");
        btnSave.Visible = true;
        hf_flag.Value = "Y";
        //btnCancel.Visible = false;
        lnkselect.Visible = true;

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //if (new Guid(Request.QueryString["DocumentId"]) == Guid.Empty)
        //{
        if (hfpopupflag.Value == "popup")
            ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "Navigatepopup();", true);
        else
        {
            hf_row_ids.Value = hf_old_row_ids.Value;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "Navigate();", true);
        }
        //}
        //else
        //{

        //    //Response.Redirect("~/App/Asset/DocumentProfile.aspx?DocumentId=00000000-0000-0000-0000-000000000000&IsfromClient=Y&FromType=Y", true);
        //}


    }

    protected void rcbentity_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            hf_entityid.Value = rcbentity.SelectedValue.ToString();
            hf_entityname.Value = rcbentity.Text;
            lblentityname.Text = "";
            hf_lbl_entitynames.Value = "";
            hf_row_ids.Value = "";
            //divProfilePage.Style["margin"] = "-20 0 0 0";

            //string value = "<script language='javascript'>AlignProfilePage()</script>";
            //        Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
            //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>AlignProfilePage();</script>", false);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
     
    #endregion

    #region Private methods
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
    public string DocumentUpload(string strFacilityId)
    {

        string strDirExists = string.Empty;
        string filename = "";
        string filepath = string.Empty;
        List<String> ls = new List<string>();
        ls = strFacilityId.Split(',').ToList();
        try
        {
            foreach (String item in ls)
            {
                
                //strDirExists = Server.MapPath("~/App/Files/Documents/" + item);

                strDirExists = Server.MapPath(CommonVirtualPath +"/Documents/" + item);


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

                    //filepath = Path.Combine(Server.MapPath("~/App/Files/Documents/" + item), filename);
                    //hfAttachedFile.Value = "~/App/Files/Documents/" + item + "/" + filename;

                    filepath = Path.Combine(Server.MapPath(CommonVirtualPath+"/Documents/" + item), filename);
                    hfAttachedFile.Value = CommonVirtualPath+"/Documents/" + item + "/" + filename;


                    hf_filename.Value = filename;
                    file.SaveAs(filepath, true);

                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "DocumentUpload :-" + ex.Message.ToString();
        }
        return filename;

    }

    protected void EnableDisable(string flag)
    {
        if (flag == "D")
        {
            txtname.Visible = false;
            txtdescription.Visible = false;
            rcbapproval.Visible = false;
            rcbcategory.Visible = false;
            rcbentity.Visible = false;
            rcbstage.Visible = false;
            ruDocument.Visible = false;

            lblname.Visible = true;
            lbldescription.Visible = true;
            lblentity.Visible = true;
            lblentityname.Visible = true;
            lblcategory.Visible = true;
            lblapproval.Visible = true;
            lblstage.Visible = true;
            lbl_document_path.Visible = true;
            lblcreated_by.Visible = true;
            lblcreated_on.Visible = true;

            lnkselect.Visible = false;

            btnEdit.Visible = true;
            btnSave.Visible = false;
            btnCancel.Visible = false;
            btnDelete.Visible = true;

        }

        else
        {
            txtdescription.Visible = true;
            txtname.Visible = true;
            rcbentity.Visible = true;
            rcbcategory.Visible = true;
            rcbapproval.Visible = true;
            rcbstage.Visible = true;
            ruDocument.Visible = true;


            lblname.Visible = false;
            lbldescription.Visible = false;
            lblentity.Visible = false;
            //lblentityname.Visible = false;
            lblcategory.Visible = false;
            lblapproval.Visible = false;
            lblstage.Visible = false;
            lbl_document_path.Visible = false;
            lblcreated_by.Visible = false;
            lblcreated_on.Visible = false;
            lblcreated_by_heading.Visible = false;
            lblcreated_on_heading.Visible = false;

            lnkselect.Visible = true;
            btnDelete.Visible = false;
            btnEdit.Visible = false;
            btnSave.Visible = true;
            btnCancel.Visible = true;

        }

    }

    protected void BindCategories()
    {

        try
        {

            DataSet ds_doc_type = new DataSet();
            LocationsClient locObj_crtl = new LocationsClient();
            LocationsModel locObj_mdl = new LocationsModel();
            
            locObj_mdl.ProjectId = new Guid(SessionController.Users_.ProjectId);
            locObj_mdl.Attribute_template_id = Guid.Empty;

            locObj_mdl.OrganizationID = SessionController.Users_.OrganizationID;
            ds_doc_type = locObj_crtl.Get_All_Document_Types(SessionController.ConnectionString, locObj_mdl);

            rcbcategory.DataTextField = "type_name";
            rcbcategory.DataValueField = "doc_type_id";
            rcbcategory.DataSource = ds_doc_type;
            rcbcategory.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
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

            rcbstage.DataTextField = "stage_name";
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

            rcbapproval.DataTextField = "approval_by";
            rcbapproval.DataValueField = "id";
            rcbapproval.DataSource = ds_Approvalby;
            rcbapproval.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void BindEntity()
    {
        try
        {
            DataSet ds_entity = new DataSet();
            AttributeTemplateClient attObj_crtl = new AttributeTemplateClient();
            AttributeTemplateModel attObj_mdl = new AttributeTemplateModel();
            attObj_mdl.Flag = "doc";
            ds_entity = attObj_crtl.BindEntity(attObj_mdl, SessionController.ConnectionString);

            rcbentity.DataTextField = "Entity";
            rcbentity.DataValueField = "pk_entity_id";
            rcbentity.DataSource = ds_entity;
            rcbentity.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    public void BindDocumentProfile()
    {

        DataSet ds = new DataSet();
        FacilityClient facObjClientCtrl = new FacilityClient();
        FacilityModel facObjFacilityModel = new FacilityModel();
        facObjFacilityModel.Document_Id = new Guid(hf_document_id.Value);
        if (hf_entity_name.Value != null)
        {
            if (hf_entity_name.Value == "Component")
            {

                facObjFacilityModel.Entity = "Asset";
            }
            else
            {
                facObjFacilityModel.Entity = hf_entity_name.Value;
            }
        }
        else
        {
            facObjFacilityModel.Entity = hf_entity_name.Value;
        }

        facObjFacilityModel.Fk_row_ids = hf_row_ids.Value;
        ds = facObjClientCtrl.proc_get_document_data_pm(facObjFacilityModel, SessionController.ConnectionString);

        if (ds.Tables[0].Rows.Count > 0)
        {
            txtname.Text = ds.Tables[0].Rows[0]["document_name"].ToString();
            lblname.Text = ds.Tables[0].Rows[0]["document_name"].ToString();
            hf_old_document_name.Value = ds.Tables[0].Rows[0]["document_name"].ToString();
            txtdescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
            lbldescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
            //rcbentity.SelectedItem.Text = ds.Tables[0].Rows[0]["entity_name"].ToString();
            lblentity.Text = ds.Tables[0].Rows[0]["entity_name"].ToString();
            hf_entity_name.Value = ds.Tables[0].Rows[0]["entity_name"].ToString();
            hf_entityid.Value = ds.Tables[0].Rows[0]["entity_id"].ToString();
            rcbentity.SelectedValue = ds.Tables[0].Rows[0]["entity_id"].ToString();
            hf_rowname.Value = ds.Tables[0].Rows[0]["RowName"].ToString();
            lblentityname.Text = ds.Tables[0].Rows[0]["RowName"].ToString();
            hf_rowid.Value = ds.Tables[0].Rows[0]["fk_row_id"].ToString();
            hf_row_ids.Value = ds.Tables[0].Rows[0]["fk_row_ids"].ToString();
            rcbcategory.SelectedValue = ds.Tables[0].Rows[0]["fk_document_type_id"].ToString();
            //lblcategory.Text = rcbcategory.Text;
            lblcategory.Text = rcbcategory.Text.Equals(" --Select--") ? "" : rcbcategory.Text;
            rcbstage.SelectedValue = ds.Tables[0].Rows[0]["fk_stage_id"].ToString();
            //lblstage.Text = rcbstage.Text;
            lblstage.Text = rcbstage.Text.Equals(" --Select--") ? "" : rcbstage.Text;
            rcbapproval.SelectedValue = ds.Tables[0].Rows[0]["fk_approval_by_id"].ToString();
            //lblapproval.Text = rcbapproval.Text;
            lblapproval.Text = rcbapproval.Text.Equals(" --Select--") ? "" : rcbapproval.Text;
            lblcreated_by.Text = ds.Tables[0].Rows[0]["created_by"].ToString();
            lblcreated_on.Text = ds.Tables[0].Rows[0]["created_on"].ToString();

            hfAttachedFile.Value = ds.Tables[0].Rows[0]["file_path"].ToString();
            lbl_document_path.Text = hfAttachedFile.Value;
            int index = lbl_document_path.Text.LastIndexOf('/');
            string actual_file = lbl_document_path.Text.Substring(index + 1);
            //lbl_document_path.Text = "<a href=" + Request.Url.GetLeftPart(UriPartial.Authority)+ hfAttachedFile.Value.Replace("~","") +" target='_blank' >" + actual_file + "</a>"; // hfAttachedFile.Value;

            //By Pratik 
            lbl_document_path.Text = "<a href=" + Request.Url.GetLeftPart(UriPartial.Authority) + hfAttachedFile.Value.Replace("~", "").Replace(" ", "%20") + " target='_blank' >" + actual_file + "</a>"; // hfAttachedFile.Value;
            //lbl_document_path.Text = actual_file;
            lbl_document_path.CssClass = "linkText";


            hf_facility_id.Value = ds.Tables[0].Rows[0]["fk_facility_id"].ToString();


        }
    }

    #endregion
    protected void btnDelete_click(object sender, EventArgs e)
    {
        FacilityClient objfacctrl = new FacilityClient();
        FacilityModel objfacmdl = new FacilityModel();
        try
        {
            //if (!Request.QueryString["DocumentId"].ToString().Equals(Guid.Empty.ToString()))
            //{
            //    objfacmdl.Facility_Ids = Request.QueryString["DocumentId"].ToString(); //Variable Facility_Ids from model class is used to pass component ids.
            //}
            objfacmdl.Document_Name = lblname.Text;
            if (hf_row_ids.Value.Equals(string.Empty))
            {
                objfacmdl.Fk_row_ids = hf_rowid.Value;
            }
            else
            {
                objfacmdl.Fk_row_ids = hf_row_ids.Value;
            }
            objfacctrl.delete_document_pm(objfacmdl, SessionController.ConnectionString);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "navigate();", true);
            //   Response.Redirect("Document.aspx");
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
            if (SessionController.Users_.UserSystemRole == "GU")
            {

                btnSave.Visible = false;
                btnDelete.Visible = false;
                btnEdit.Visible = false;
            }
            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
            {
                SetPermissions();
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
            DataRow dr_component = ds_component.Tables[0].Select("name='Document'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Document Profile")
                {
                    SetPermissionToControl(dr_profile);
                    //DataRow[] dr_fields_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_profile["pk_project_role_controls"] + "'");
                    //foreach (DataRow dr in dr_fields_component)
                    //{
                    //    SetPermissionToControl(dr);
                    //}

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
        //string add_permission = dr["add_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();
        // delete permission
        if (dr["Control_id"].ToString() == "btnDelete")
        {
            objPermission.SetEditable(btnDelete, delete_permission);
            objPermission.SetEditable(btnEdit, edit_permission);
        }



    }



}