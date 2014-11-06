using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using Telerik.Web.UI;
using SetupSync;
using System.Data;
using System.Xml;
using System.Text;
using System.Configuration;
using EcoDomus.Session;
using System.IO;

public partial class App_UserControls_AttributeMappingCS : System.Web.UI.UserControl
{
    public ArrayList arrayList = new ArrayList();
    public Hashtable ht_ext_eco_id = new Hashtable();
    public Hashtable ht_ext_group = new Hashtable();
    protected void Page_Load(object sender, EventArgs e)
    {
        try 
        {
            if (SessionController.Users_.UserId != null)
            {
                if (Request.QueryString["pk_external_system_configuration_id"].ToString() != Guid.Empty.ToString())
                {
                    if (hf_attribute_loaded.Value.Equals("false") == true)
                    {
                        GetMappedAttributeDetails();
                        GetObjectInpFile();
                        hf_attribute_loaded.Value = "true";

                    }
                }

                else
                {
                    if (hf_attribute_loaded.Value.Equals("false") == true)
                    {

                        GetObjectInpFile();
                        hf_attribute_loaded.Value = "true";
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void GetMappedAttributeDetails()
    {
        SetupSyncClient obj_setup_sync_client = new SetupSyncClient();
        SetupSyncModel obj_setup_sync_model = new SetupSyncModel();
        DataSet ds = new DataSet();
        try
        {
            if (!string.IsNullOrEmpty(Convert.ToString(Request.QueryString["pk_external_system_configuration_id"])))
            {
                obj_setup_sync_model.External_system_configuration_id = new Guid(Convert.ToString(Request.QueryString["pk_external_system_configuration_id"]));
                ds = obj_setup_sync_client.Get_Entity_Profile_Attribute_Mapping_Data(obj_setup_sync_model, SessionController.ConnectionString);
                if (ds != null)
                {
                    if (ds.Tables.Count > 0)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                string ext_id = Convert.ToString(ds.Tables[0].Rows[i]["TypeId"]);
                                string eco_id = Convert.ToString(ds.Tables[0].Rows[i]["TypeValue"]);
                                if (ht_ext_eco_id != null)
                                {
                                    if (!ht_ext_eco_id.Contains(ext_id))
                                    {
                                        ht_ext_eco_id.Add(ext_id, eco_id);
                                    }
                                }

                            }
                        }

                    }

                }
                if (ht_ext_eco_id != null)
                {
                    ViewState["SelectedAttributeID"] = ht_ext_eco_id;
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    protected void rgAttributes_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            GetObjectInpFile();
        }
        catch (Exception ex)
        {

            throw;
        }
    }

    public void GetObjectInpFile()
    {
        SetupSyncClient obj_setup_sync_client = new SetupSyncClient();
        SetupSyncModel obj_setup_sync_model = new SetupSyncModel();
        DataSet ds = new DataSet();
        try
        {
            if (SessionController.Users_.Configuration_id != null)
            {
                obj_setup_sync_model.External_system_configuration_id = new Guid(SessionController.Users_.Configuration_id);
                obj_setup_sync_model.Search_value = txtSearchAM.Text;
                ds = obj_setup_sync_client.Get_External_System_Attribute_Data(obj_setup_sync_model, SessionController.ConnectionString);
                if (ds.Tables.Count > 0)
                {
                    rgAttributes.DataSource = ds;
                    rgAttributes.DataBind();
                }
                else
                {
                    rgAttributes.DataSource = string.Empty;
                    rgAttributes.DataBind();
                }

            }

        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    
    }
    public void GetObjectInpFile_XML()
    {
        try
        {
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
                                writer.WriteElementString("Attribute_group", group_name);
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
                    table.Columns.Add("Attribute_group", typeof(string));
                    ds.CaseSensitive = false;
                    ds.ReadXml(xml_file_path);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        DataRow[] Rows = ds.Tables[0].Select("TypeValue LIKE '%" + txtSearchAM.Text.Trim() + "%'");
                        if (Rows.Length > 0)
                        {
                            foreach (DataRow dr in Rows)
                            {
                                table.Rows.Add(dr.ItemArray);
                            }
                        }
                    }

                    rgAttributes.DataSource = table;
                    rgAttributes.DataBind();

                }
            }
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rgAttributes_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            GetObjectInpFile();
        }
        catch (Exception ex)
        {

            throw;
        }
    }
    protected void rgAttributes_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            SetupSyncClient obj_setupSync_client = new SetupSyncClient();
            SetupSyncModel obj_setupSync_model = new SetupSyncModel();

            if (ViewState["eco_attribute"] == null)
            {
                obj_setupSync_model.External_system_configuration_id = Guid.Empty;
                ds = obj_setupSync_client.Get_Entity_Profile_Attribute_Mapping_Data(obj_setupSync_model, SessionController.ConnectionString);
                ViewState["eco_attribute"] = ds;
            }
            else
            {
                ds = ViewState["eco_attribute"] as DataSet;
                if (ds != null)
                {
                    RadComboBox cmbExternalSystem = (RadComboBox)e.Item.FindControl("cmbExternalSystem");
                    if (cmbExternalSystem != null)
                    {
                        RadComboBox rcbx = rgAttributes.MasterTableView.FindControl("cmbExternalSystem") as RadComboBox;
                        if (cmbExternalSystem != null)
                        {
                            cmbExternalSystem.DataTextField = "TypeValue";
                            cmbExternalSystem.DataValueField = "TypeId";
                            cmbExternalSystem.DataSource = ds;
                            cmbExternalSystem.DataBind();
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
    protected void btn_map_Click(object sender, EventArgs e)
    {
        try
        {
            SetupSyncClient obj_setupSync_client = new SetupSyncClient();
            SetupSyncModel obj_setupSync_model = new SetupSyncModel();
            GetSelectedRows();
            if (ht_ext_eco_id != null)
            {
                if (ht_ext_eco_id.Count > 0)
                {
                    foreach (string key in ht_ext_eco_id.Keys)
                    {

                        if (ht_ext_eco_id.Contains(key))
                        {
                            obj_setupSync_model.External_system_data_id = key;
                            obj_setupSync_model.Ecodomus_system_data_id = Convert.ToString(ht_ext_eco_id[key]);

                            obj_setupSync_model.Created_by_user_id = new Guid(SessionController.Users_.UserId);
                            if (ht_ext_eco_id != null)
                            {
                                if (ht_ext_group.Count > 0)
                                {
                                    obj_setupSync_model.Group_name = Convert.ToString(ht_ext_group[key]);
                                }
                            }
                            obj_setupSync_model.External_system_configuration_id = new Guid(SessionController.Users_.Configuration_id);
                            obj_setupSync_client.Insert_Update_External_System_Entity_Profile_Attribute_Data(obj_setupSync_model, SessionController.ConnectionString);
                        }
                    }
                   
                }
            } 
            lblMapMsg.Text = "Mapping Done";//(string)GetGlobalResourceObject("Resource", "Mapping_Done"); //"Mapping Done";

            //foreach (GridDataItem item in rgAttributes.Items)
            //{
            //    RadComboBox cmbExternalSystem = (RadComboBox)item.FindControl("cmbExternalSystem");
            //    if (!cmbExternalSystem.Text.ToString().Equals(" --Select--"))
            //    {
            //        obj_setupSync_model.External_system_data_id = item.OwnerTableView.DataKeyValues[item.ItemIndex]["TypeId"].ToString();
            //        obj_setupSync_model.Ecodomus_system_data_id = cmbExternalSystem.SelectedValue;
            //        obj_setupSync_model.Group_name=item.OwnerTableView.DataKeyValues[item.ItemIndex]["Group"].ToString();
            //        obj_setupSync_model.Created_by_user_id = new Guid(SessionController.Users_.UserId);
            //        obj_setupSync_client.Insert_Update_External_System_Entity_Profile_Attribute_Data(obj_setupSync_model,SessionController.ConnectionString);

            //    }
            //}
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void GetSelectedRows()
    {
        try
        {
            SessionToHashTable();

            foreach (GridDataItem item in rgAttributes.Items)
            {
                RadComboBox cmbExternalSystem = (RadComboBox)item.FindControl("cmbExternalSystem");
                string ext_id = item.OwnerTableView.DataKeyValues[item.ItemIndex]["TypeId"].ToString();
                string group_name = item.OwnerTableView.DataKeyValues[item.ItemIndex]["attribute_group"].ToString();
                string eco_id = cmbExternalSystem.SelectedValue;
                if (!cmbExternalSystem.Text.ToString().Equals(" --Select--"))
                {
                    if (ht_ext_eco_id != null)
                    {
                        if (!ht_ext_eco_id.ContainsKey(ext_id))
                        {
                            //arrayList.Add(facility_id.ToString());
                            ht_ext_eco_id.Add(ext_id, eco_id);
                            ht_ext_group.Add(ext_id, group_name);
                        }

                    }
                }
                else
                {
                    if (ht_ext_eco_id != null)
                    {
                        if (ht_ext_eco_id.ContainsKey(ext_id))
                        {
                            //arrayList.Remove(facility_id.ToString());
                            ht_ext_eco_id.Remove(ext_id);
                            ht_ext_group.Remove(ext_id);
                        }
                    }
                }

            }
            if (ht_ext_eco_id != null)
            {
                if (ht_ext_eco_id.Count > 0)
                {
                    ViewState["SelectedAttributeID"] = ht_ext_eco_id;
                    ViewState["SelectGroupName"] = ht_ext_group;
                }
            }
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void SessionToHashTable()
    {
        try
        {
            if (ViewState["SelectedAttributeID"] != null)
            {
                ht_ext_eco_id = (Hashtable)ViewState["SelectedAttributeID"];
            }
            if (ViewState["SelectGroupName"] != null)
            {
                ht_ext_group = (Hashtable)ViewState["SelectGroupName"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void ReSelectedRows()
    {
        try
        {
            foreach (GridDataItem item in rgAttributes.Items)
            {
                //string facility_id = item["facility_id"].Text;
                RadComboBox cmbExternalSystem = (RadComboBox)item.FindControl("cmbExternalSystem");
                if (cmbExternalSystem != null)
                {
                    string ext_id = item.OwnerTableView.DataKeyValues[item.ItemIndex]["TypeId"].ToString();
                    string eco_id = cmbExternalSystem.SelectedItem.Value;
                    if (ht_ext_eco_id != null)
                    {
                        if (ht_ext_eco_id.Count > 0)
                        {
                            if (ht_ext_eco_id.Contains(ext_id))
                            {
                                //item.Selected = true;
                                cmbExternalSystem.SelectedValue = Convert.ToString(ht_ext_eco_id[ext_id]);
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
    protected void rgAttributes_DataBound(object sender, EventArgs e)
    {
        try
        {
            ReSelectedRows();
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
            UpdatePreview();
            GoToNextTab();
        }
        catch (Exception ex)
        {

            throw;
        }

        //ScriptManager.RegisterStartupScript(this, this.GetType(), "setValues", "setValues();", true);
    }

    private void GoToNextTab()
    {
        try
        {
            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            RadTabStrip tabStrip = (RadTabStrip)userContentHolder.FindControl("rdstripSetupSync");
            //RadTab assetType = tabStrip.FindTabByText("Scheduler");
            RadTab assetType = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", "Scheduler"));
            assetType.Enabled = true;
            assetType.Selected = true;
            GoToNextPageView();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void GoToNextPageView()
    {
        try
        {
            ContentPlaceHolder userContentHolder = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
            RadMultiPage multiPage = (RadMultiPage)userContentHolder.FindControl("rmpageSetupSync");
            RadPageView AssetTypePageView = multiPage.FindPageViewByID(@"~/App/UserControls/" + "Scheduler");
            if (AssetTypePageView == null)
            {
                AssetTypePageView = new RadPageView();
                AssetTypePageView.ID = @"~/App/UserControls/" + "Scheduler";

                multiPage.PageViews.Add(AssetTypePageView);
            }
            AssetTypePageView.Selected = true;
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
            System.Web.UI.WebControls.Image imgSyncProfile = (System.Web.UI.WebControls.Image)previewControl.FindControl("imgMapIntegration");
            imgSyncProfile.Visible = true;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btnSearch_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            GetSelectedRows();
            GetObjectInpFile();
        }
        catch (Exception ex)
        {

            throw;
        }
    }
}