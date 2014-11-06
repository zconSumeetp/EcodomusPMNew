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

public partial class App_COBIE_ComponentReportExport : System.Web.UI.UserControl
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
        }
    }
    protected void Page_Prerender(object sender, EventArgs e)
    {

        if (SessionController.Users_.UserSystemRole == "PA")
        {
            foreach (GridDataItem item in rgexportedfiles.MasterTableView.Items)
            {
                ImageButton img_btn = item.FindControl("imgbtnDelete") as ImageButton;
                if (img_btn != null)
                {
                    img_btn.Visible = false;
                }

            }

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

            //if (SessionController.Users_.IsFacility == "yes")
            //{
            //    cmbfacility.Visible = true;
            //    lblfacility.Visible = true;
            //    cmbfacility.SelectedValue = SessionController.Users_.facilityID;
            //    cmbfacility.Enabled = false;
            //}
            //else
            //{
            cmbfacility.Visible = true;
            lblfacility.Visible = true;
            cmbfacility.Enabled = true;
            //}

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    //protected void radbtn_export_cobie_Click(object sender, EventArgs e)
    //{
    //    try
    //    {            
    //        if (cmbfacility.SelectedValue != null && cmbfacility.SelectedValue != "")
    //        {
    //            string designer_organization_id = "";
    //            string contrator_organization_id = "";
    //            if (rtvtypeorgfilters != null)
    //            {
    //                System.Collections.Generic.IList<RadTreeNode> OrganizationCollection = rtvtypeorgfilters.CheckedNodes;

    //                if (OrganizationCollection.Count > 0)
    //                {
    //                    foreach (RadTreeNode organization in OrganizationCollection)
    //                    {
    //                        if (organization.ParentNode != null)
    //                        {
    //                            if (organization.ParentNode.Text == "Contractor")
    //                            {
    //                                if (organization.ParentNode.Value != Guid.Empty.ToString() && organization.Value != Guid.Empty.ToString())
    //                                {
    //                                    contrator_organization_id = contrator_organization_id + organization.Value.ToString() + ",";
    //                                }
    //                            }
    //                            else
    //                            {
    //                                if (organization.ParentNode.Value != Guid.Empty.ToString() && organization.Value != Guid.Empty.ToString())
    //                                {
    //                                    designer_organization_id = designer_organization_id + organization.Value.ToString() + ",";
    //                                }
    //                            }
    //                        }
    //                        else
    //                            break;
    //                    }
    //                    if (designer_organization_id.Length > 0)
    //                        designer_organization_id = designer_organization_id.Substring(0, designer_organization_id.Length - 1);//For removing comma at the end           
    //                    if (contrator_organization_id.Length > 0)
    //                        contrator_organization_id = contrator_organization_id.Substring(0, contrator_organization_id.Length - 1);//For removing comma at the end           

    //                    ///------------------------------------File Path ------------------------------------------///////
    //                    string filePathFolder = "C:\\inetpub\\wwwroot\\EcoDomus_PM_New_UI\\EcoDomus PM_FM\\Files\\COBiefiles/";
    //                    ////////////////////////"C:\\inetpub\\wwwroot\\EcoDomus_PM_New_UI\\Files\\COBieFiles

    //                    string strFile = cmbfacility.SelectedItem.Text + System.DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";

    //                    string filePath = filePathFolder + strFile;



    //                    Client.ClientClient obj_ctrl = new Client.ClientClient();
    //                    Client.ClientModel obj_mdl = new Client.ClientModel();
    //                    obj_mdl.Pk_request_id = new Guid("00000000-0000-0000-0000-000000000000");
    //                    obj_mdl.ClientId = new Guid(SessionController.Users_.ClientID);
    //                    obj_mdl.Fk_facility_id = new Guid(cmbfacility.SelectedValue);
    //                    obj_mdl.UserId = new Guid(SessionController.Users_.UserId);
    //                    obj_mdl.Fk_designer_organization_id = designer_organization_id;
    //                    obj_mdl.Fk_contractor_organization_id = contrator_organization_id;
    //                    obj_mdl.Fk_project_id = new Guid(SessionController.Users_.ProjectId);
    //                    obj_mdl.Status = "N";
    //                    obj_mdl.Cobie_filepath = filePath;

    //                    obj_ctrl.InsertCobieExportRequest(obj_mdl);
    //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:RequestMessage(0);", true);
    //                }
    //                else
    //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:RequestMessage(2);", true);
    //            }

    //        }
    //        else
    //            ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:RequestMessage(1);", true);
    //    }
    //    catch (Exception ex)
    //    { throw ex; }


    //}
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
            cm.status = "DCAM";
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
            cm.project_id = SessionController.Users_.ProjectId;
            DataSet ds = cc.proc_get_designer_contractor_export(cm,SessionController.ConnectionString);
            rtvtypeorgfilters.DataSource = ds;
            rtvtypeorgfilters.ExpandAllNodes();
        }
        catch (Exception ex)
        { throw ex; }
    }


    protected void btnGenerateComponentAnalysisReport_Click(object sender, EventArgs e)
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
                                if (organization.ParentNode.Text == "Contractor")
                                {
                                    if (organization.ParentNode.Value != Guid.Empty.ToString() && organization.Value != Guid.Empty.ToString())
                                    {
                                        contrator_organization_id = contrator_organization_id + organization.Value.ToString() + ",";
                                    }
                                }
                                else
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
                        ///string filePathFolder = "C:\\inetpub\\wwwroot\\EcoDomus_PM_New_UI\\EcoDomus PM_FM\\Files\\COBiefiles/";
                        string filePathFolder = "D:\\COBie\\Export_windows_service/";
                        // string filePathFolder = "D:\\Code to be mpovded to server\\EcoDomusPM\\EcoDomus_PM_FM\\Files\\COBiefiles/";
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
                        obj_mdl.Status = "ND";
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
}