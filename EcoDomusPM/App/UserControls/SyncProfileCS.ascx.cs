using System;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Web.UI;
using SetupSync;
using System.Threading;
using System.Globalization;
using EcoDomus.Session;
using System.IO;
using System.Configuration;
using System.Xml;
using System.Text;

[ValidationProperty("Text")]
public partial class Setup_Sync_SyncCS : System.Web.UI.UserControl
{


    protected void Page_Load(object sender, System.EventArgs e)
    {

        if (!IsPostBack)
        {
            ViewState["insertId"] = Request.QueryString["pk_external_system_configuration_id"];
            Bind_External_SystemDropDown();
            this.disableOtherOpetion();
            if (Request.QueryString["pk_external_system_configuration_id"] != Guid.Empty.ToString())
            {
                Fill_configuration_data(Request.QueryString["pk_external_system_configuration_id"]);
            }
            lblErrMsg.Text = "";
            //Settings_For_Prolog_Converge();
        }
        lblErrMsg.Text = "";
    }

    private void Settings_For_Prolog_Converge()
    {

        ddlExternalSystem.SelectedIndex = ddlExternalSystem.FindItemByText("Prolog").Index;
        ddlExternalSystem.Enabled = false;
        divUserPassConnString.Visible = true;
        divconnString.Visible = false;
        lblServiceClientUrl.Text = "Host";
        lblServiceClient.Text = "Portfolio Name";
    }
    /// <summary>
    /// This stub disable the items which is not for pm
    /// </summary>
    void disableOtherOpetion()
    {
        foreach (RadComboBoxItem rcbItem in ddlExternalSystem.Items)
        {
            if (rcbItem.Text.ToString().ToLower().Equals("tekla") || rcbItem.Text.ToString().ToLower().Equals("prolog") || rcbItem.Text.Equals(" --Select--")) ;

            else
                rcbItem.Enabled = false;
        }
        
    }
    private void Bind_External_SystemDropDown()
    {
        try
        {
            SetupSyncClient obj_setSync_client = new SetupSyncClient();
            SetupSyncModel obj_setSync_model = new SetupSyncModel();
            DataSet ds = obj_setSync_client.Get_external_system_details(obj_setSync_model, SessionController.ConnectionString);
            ddlExternalSystem.DataSource = ds;
            ddlExternalSystem.DataTextField = "external_system_name";
            ddlExternalSystem.DataValueField = "pk_external_system_id";
            ddlExternalSystem.DataBind();
          
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void nextButton_Click(object sender, EventArgs e)
    {

        try
        {
            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            HiddenField hf_external_system = (HiddenField)userContentHolder.FindControl("hf_external_system");
            if (hf_external_system != null)
            {
                hf_external_system.Value = ddlExternalSystem.SelectedItem.Text;
            }
            if (ViewState["insertId"].ToString() != Guid.Empty.ToString())
            {

                Update_configuration_data(ViewState["insertId"].ToString());
            }
            else
            {

                string newId = Insert_configuration_data();
                ViewState["insertId"] = newId;
            }
            InsertUpdateObjectInpFileData();

            UpdatePreview();
            GoToNextTab();
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "setValues", "setValuesFacility();", true);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void Fill_configuration_data(string pk_external_system_configuration_id)
    {
        SetupSyncClient obj_setSync_client = new SetupSyncClient();
        SetupSyncModel obj_setSync_model = new SetupSyncModel();
        try
        {
            obj_setSync_model.Pk_external_system_configuration_id = new Guid(pk_external_system_configuration_id);
            DataSet ds = obj_setSync_client.Get_sync_profile_data(obj_setSync_model, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtConfigName.Text = ds.Tables[0].Rows[0]["configuration_name"].ToString();
                txtServiceUrl.Text = ds.Tables[0].Rows[0]["service_url"].ToString();
                txtServiceAuthUrl.Text = ds.Tables[0].Rows[0]["service_auth_url"].ToString();
                txtUserName.Text = ds.Tables[0].Rows[0]["service_username"].ToString();
                txtPassword.Attributes.Add("value", ds.Tables[0].Rows[0]["service_password"].ToString());
                txtServiceclient.Text = ds.Tables[0].Rows[0]["service_client"].ToString();
                txtURL.Text = ds.Tables[0].Rows[0]["connction_string"].ToString();

                ddlExternalSystem.SelectedValue = ds.Tables[0].Rows[0]["pk_external_system_id"].ToString();
                string name = ds.Tables[0].Rows[0]["external_system_name"].ToString();
                ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
                HiddenField hf_external_system = (HiddenField)userContentHolder.FindControl("hf_external_system");
                if (hf_external_system != null)
                {
                    hf_external_system.Value = name;
                }
                HiddenField hf_file_path = (HiddenField)userContentHolder.FindControl("hf_file_path");
                if (hf_file_path != null)
                {
                    hf_file_path.Value = ds.Tables[0].Rows[0]["connction_string"].ToString();
                }
                if (name.Equals("TMA", StringComparison.CurrentCultureIgnoreCase))
                {
                    divUserPassConnString.Visible = true;
                }
                else if (name.Equals("Corrigo", StringComparison.CurrentCultureIgnoreCase))
                {
                    lblServiceClient.Text = "Company Name";
                    divUserPassConnString.Visible = true;
                }
                else if (name.Equals("ArchiBus", StringComparison.CurrentCultureIgnoreCase))
                {

                    divUserPassConnString.Visible = true;
                }
                else if (name.Equals("BIM 360", StringComparison.CurrentCultureIgnoreCase))
                {

                    divUserPassConnString.Visible = true;
                }
                else if (name.Equals("Tekla", StringComparison.CurrentCultureIgnoreCase))
                {

                    divFileUpload.Visible = true; 
                }
                else if (name.Equals("Prolog", StringComparison.CurrentCultureIgnoreCase))
                {

                    lblServiceClientUrl.Text = "Host";
                    lblServiceClient.Text = "Portfolio Name";
                    divUserPassConnString.Visible = true;
                    divconnString.Visible = false;
                    divFileUpload.Visible = false;
                }
                else
                {
                    divconnString.Visible = true;

                }
            }

        }

        catch (Exception ex)
        {

            throw ex;
        }
    }

    private string Insert_configuration_data()
    {
        SetupSyncClient obj_setSync_client = new SetupSyncClient();
        SetupSyncModel obj_setSync_model = new SetupSyncModel();
        try
        {
            obj_setSync_model.Pk_external_system_configuration_id = new Guid(Request.QueryString["pk_external_system_configuration_id"]);
            obj_setSync_model.External_system_id = new Guid(ddlExternalSystem.SelectedValue);
            obj_setSync_model.Configuration_name = txtConfigName.Text;
            obj_setSync_model.Service_url = txtServiceUrl.Text;
            obj_setSync_model.Service_auth_url = txtServiceAuthUrl.Text;
            obj_setSync_model.Service_username = txtUserName.Text;
            obj_setSync_model.Service_password = txtPassword.Text;
            obj_setSync_model.Service_client = txtServiceclient.Text;
            obj_setSync_model.Configuration_status = "0";
            if (ddlExternalSystem.SelectedItem.Text.Equals("Tekla"))
            {
                ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
                HiddenField hf_file_path = (HiddenField)userContentHolder.FindControl("hf_file_path");
                if (hf_file_path != null)
                {

                    obj_setSync_model.Connection_string = hf_file_path.Value;
                }
            }
            else
            {
                obj_setSync_model.Connection_string = txtURL.Text.ToString();
            }

            obj_setSync_model.Created_by_user_id = new Guid(SessionController.Users_.UserId);
            obj_setSync_model.Modified_by_user_id = new Guid(SessionController.Users_.UserId);
            DataSet ds = obj_setSync_client.Insert_Update_Configuration(obj_setSync_model, SessionController.ConnectionString);
            string newId = ds.Tables[0].Rows[0].ItemArray[0].ToString();
            SessionController.Users_.External_system_id = new Guid(ddlExternalSystem.SelectedValue).ToString();
            SessionController.Users_.Configuration_id = newId;
            Session["external_SystemId"] = obj_setSync_model.External_system_id.ToString();
            Session["configuration_id"] = newId;
            return newId;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void Update_configuration_data(string pk_external_system_configuration_id)
    {
        SetupSyncClient obj_setSync_client = new SetupSyncClient();
        SetupSyncModel obj_setSync_model = new SetupSyncModel();
        try
        {
            obj_setSync_model.Pk_external_system_configuration_id = new Guid(pk_external_system_configuration_id);
            obj_setSync_model.External_system_id = new Guid(ddlExternalSystem.SelectedValue);
            obj_setSync_model.Configuration_name = txtConfigName.Text;
            obj_setSync_model.Service_url = txtServiceUrl.Text;
            obj_setSync_model.Service_auth_url = txtServiceAuthUrl.Text;
            obj_setSync_model.Service_username = txtUserName.Text;
            obj_setSync_model.Service_password = txtPassword.Text;
            obj_setSync_model.Service_client = txtServiceclient.Text;
            obj_setSync_model.Configuration_status = "0";
            if (ddlExternalSystem.SelectedItem.Text.Equals("Tekla"))
            {
                ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
                HiddenField hf_file_path = (HiddenField)userContentHolder.FindControl("hf_file_path");
                if (hf_file_path != null)
                {

                    obj_setSync_model.Connection_string = hf_file_path.Value;
                }
            }
            else
            {
                obj_setSync_model.Connection_string = txtURL.Text.ToString();
            }
            //obj_setSync_model.Connection_string = txtURL.Text.ToString();
            obj_setSync_model.Created_by_user_id = new Guid(SessionController.Users_.UserId);
            obj_setSync_model.Modified_by_user_id = new Guid(SessionController.Users_.UserId);
            obj_setSync_client.Insert_Update_Configuration(obj_setSync_model, SessionController.ConnectionString);
            SessionController.Users_.External_system_id = new Guid(ddlExternalSystem.SelectedValue).ToString();
            SessionController.Users_.Configuration_id = new Guid(pk_external_system_configuration_id).ToString();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void GoToNextTab()
    {
        ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
        RadTabStrip tabStrip = (RadTabStrip)userContentHolder.FindControl("rdstripSetupSync");
        //RadTab facility = tabStrip.FindTabByText("Facility");
        RadTab facility = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", "Facility"));
        facility.Enabled = true;
        facility.Selected = true;

        GoToNextPageView();
    }

    private void GoToNextPageView()
    {
        try
        {

            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            RadMultiPage multiPage = (RadMultiPage)userContentHolder.FindControl("rmpageSetupSync");
            RadPageView FacilityPageView = multiPage.FindPageViewByID(@"~/App/UserControls/" + "Facility");
            if (FacilityPageView == null)
            {
                FacilityPageView = new RadPageView();
                FacilityPageView.ID = @"~/App/UserControls/" + "Facility";

                multiPage.PageViews.Add(FacilityPageView);
            }
            FacilityPageView.Selected = true;

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void UpdatePreview()
    {
        try
        {
            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            Control previewControl = userContentHolder.FindControl("previewControl");
            Image imgSyncProfile = (Image)previewControl.FindControl("imgSycProfile");
            imgSyncProfile.Visible = true;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void ddlExternalSystem_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            string value = ddlExternalSystem.SelectedValue.ToString();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "myScript", "<script language=JavaScript>funDisplayConnStringBox('" + value + "');</script>", false);
            btnNext.Enabled = true;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void ddlExternalSystem_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            HiddenField hf_external_system = (HiddenField)userContentHolder.FindControl("hf_external_system");
            if (hf_external_system != null)
                {
                    hf_external_system.Value = ddlExternalSystem.SelectedItem.Text;
                }

            if (ddlExternalSystem.SelectedItem.Text.Equals("Maximo"))
            {
                divUserPassConnString.Visible = true;
                divconnString.Visible = false;
                divFileUpload.Visible = false;
            }

            if (ddlExternalSystem.SelectedItem.Text.Equals("TMA"))
            {
                divUserPassConnString.Visible = true;
                divconnString.Visible = false;
                divFileUpload.Visible = false;
                //divCorrigoConnString.Visible = false;

                // txtServiceUrl.Text = "http://208.83.236.18/TMA/webtma/webservice/businessobjectsync.asmx";
                // txtServiceAuthUrl.Text = "http://208.83.236.18/TMA/webtma/webservice/loginadmin.asmx";
                //txtUserName.Text = "wade";
                //txtPassword.Text = "tma";
                //txtServiceclient.Text = "ecodomus";
            }

            if (ddlExternalSystem.SelectedItem.Text.Equals("ARCHIBUS"))
            {
                divUserPassConnString.Visible = true;
                divconnString.Visible = false;
                divFileUpload.Visible = false;
                //divCorrigoConnString.Visible = false;


            }

            if (ddlExternalSystem.SelectedItem.Text.Equals("Corrigo"))
            {
                //divCorrigoConnString.Visible = true;
                divUserPassConnString.Visible = true;
                divconnString.Visible = false;
                divFileUpload.Visible = false;
                lblServiceClient.Text = "Company Name";
                txtServiceUrl.Text = "http://www.worktrack.com/Facilities/login.aspx";
                txtServiceAuthUrl.Text = "http://www.worktrack.com/Facilities/login.aspx";
                txtUserName.Text = "wsdk";
                txtPassword.Text = "e(0d0mus!";
                txtServiceclient.Text = "Test WWC";
            }

            if (ddlExternalSystem.SelectedItem.Text.Equals("FAMIS"))
            {
                divconnString.Visible = true;
                divUserPassConnString.Visible = false;
                divFileUpload.Visible = false;
            }

            if (ddlExternalSystem.SelectedItem.Text.Equals("BIM 360"))
            {
                divconnString.Visible = false;
                divFileUpload.Visible = false;
                divUserPassConnString.Visible = true;
               
            }
            if (ddlExternalSystem.SelectedItem.Text.Equals("Tekla"))
            {
                divconnString.Visible = false;
                divUserPassConnString.Visible = false;
                divFileUpload.Visible = true;
            }
            if (ddlExternalSystem.SelectedItem.Text.Equals("Prolog"))
            {
                lblServiceClientUrl.Text = "Host";
                lblServiceClient.Text = "Portfolio Name";
                divUserPassConnString.Visible = true;
                divconnString.Visible = false;
                divFileUpload.Visible = false;
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btnupload_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (UploadedFile file in ruImportOjectInp.UploadedFiles)
            {
                string file_path = file.FileName;
                string file_name = file.GetName();
                string commonvirtualpath = ConfigurationManager.AppSettings["CommonFilePath"] + "Object Files/" + SessionController.Users_.facilityID;
                string virtual_path=Path.Combine(commonvirtualpath, file_name);
                string commonphysicalpath = Server.MapPath(commonvirtualpath);
                DirectoryInfo dir_object = new DirectoryInfo(commonphysicalpath);
                string save_path = Path.Combine(commonphysicalpath, file_name);

                if (!dir_object.Exists)
                {
                    dir_object.Create();
                }

                file.SaveAs(save_path, true);
                ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
                HiddenField hf_file_path = (HiddenField)userContentHolder.FindControl("hf_file_path");
                if (hf_file_path != null)
                {
                    hf_file_path.Value = virtual_path;
                }

                lblErrMsg.Text = "File Is Uploaded Successfully..!";
            }
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }


    public void InsertUpdateObjectInpFileData()
    {
        try
        {
            SetupSyncClient obj_setup_sync_client = new SetupSyncClient();
            SetupSyncModel obj_setup_sync_model = new SetupSyncModel();
            DataSet ds = new DataSet();
            char[] char_array = new char[] { ',', '\"' };
            string group_name = string.Empty;
            StringBuilder sb = new StringBuilder();
            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            HiddenField hf_file_path = (HiddenField)userContentHolder.FindControl("hf_file_path");
            if (hf_file_path != null)
            {
                string file_name = Server.MapPath(hf_file_path.Value);
                if (!hf_file_path.Value.Equals(""))
                {
                    string commonvirtualpath = ConfigurationManager.AppSettings["CommonFilePath"] + "Object Files/" + SessionController.Users_.facilityID;
                    string commonphysicalpath = Server.MapPath(commonvirtualpath);
                    string xml_file_path = Path.Combine(commonphysicalpath, "object.xml");
                    XmlTextWriter writer = new XmlTextWriter(xml_file_path, System.Text.Encoding.UTF8);
                    writer.WriteStartDocument(true);
                    writer.Formatting = Formatting.Indented;
                    writer.Indentation = 2;
                    writer.WriteStartElement("Attributes");
                    string[] lines = File.ReadAllLines(file_name);
                    for (int i = 0; i < lines.Length; i++)
                    {
                        int j = i;
                        if (lines[i].Trim().StartsWith("tab_page", StringComparison.CurrentCultureIgnoreCase) || lines[i].Trim().Contains("tab_page"))
                        {
                            string[] values = lines[i].Trim().Split(char_array);
                            group_name = values[1];
                            continue;
                        }
                        if (lines[i].Trim().StartsWith("unique_attribute") || lines[i].Trim().Contains("unique_attribute"))
                        {
                            writer.WriteStartElement("Attribute");
                            string[] values = lines[i].Split(char_array, StringSplitOptions.RemoveEmptyEntries);
                            if (values.Length > 3)
                            {
                                writer.WriteElementString("TypeId", values[1]);
                                writer.WriteElementString("TypeValue", values[3].Replace(":", ""));
                                writer.WriteElementString("Group", group_name);
                            }
                            writer.WriteEndElement();
                        }
                    }
                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                    writer.Close();
                    DataTable table = new DataTable();
                    table.Columns.Add("TypeId", typeof(string));
                    table.Columns.Add("TypeValue", typeof(string));
                    table.Columns.Add("Group", typeof(string));
                    ds.CaseSensitive = false;
                    ds.ReadXml(xml_file_path);
                    if (ds != null)
                    {
                        if (ds.Tables.Count > 0)
                        {
                            if (ds.Tables[0].Rows.Count > 0)
                            { 
                                for(int i=0;i<ds.Tables[0].Rows.Count;i++)
                                {

                                Guid fk_entity_id = Guid.Empty;
                                obj_setup_sync_model.External_system_data_id = Convert.ToString(ds.Tables[0].Rows[i]["TypeId"]);
                                obj_setup_sync_model.External_system_code_dec = Convert.ToString(ds.Tables[0].Rows[i]["TypeValue"]);
                                obj_setup_sync_model.Group_name = Convert.ToString(ds.Tables[0].Rows[i]["Group"]);
                                if (SessionController.Users_.Configuration_id != null)
                                {
                                    obj_setup_sync_model.External_system_configuration_id = new Guid(SessionController.Users_.Configuration_id);
                                }
                                obj_setup_sync_client.Insert_Update_External_System_Entity_Attribute_Mapping_Data(obj_setup_sync_model, SessionController.ConnectionString);
                                }
                            
                            }
                        }
                    
                    }
                    

                }
                
                
            }
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }
}