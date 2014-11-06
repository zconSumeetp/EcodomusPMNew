using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Threading;
using System.Globalization;
using SetupSync;
using EcoDomus.Session;
using System.Drawing;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;


public partial class App_UserControls_MapIntegrationCS : System.Web.UI.UserControl
{

    protected string strentity_code;
    public string Entity_code
    {
        get { return strentity_code; }
        set { strentity_code = value; }
    }

    protected string strentity_name;
    public string Entity_name
    {
        get { return strentity_name; }
        set { strentity_name = value; }
    }

    private string strtable_name;
    public string Table_Name
    {
        get
        {
            return strtable_name;
        }
        set
        {
            strtable_name = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {


        try
        {

            if (SessionController.Users_.Configuration_id.ToString() != Guid.Empty.ToString())
            {
                if (FacilityLoaded.Value.Equals("false") == true)
                {
                    Entity_code = "FACILITY";
                    Entity_name = (string)GetGlobalResourceObject("Resource", "Facility");// "Facility";
                    hdnEntityCode.Value = "FACILITY";
                    hdnEntityName.Value = (string)GetGlobalResourceObject("Resource", "Facility"); //"Facility";
                    hdnTableName.Value = "tbl_external_system_facility_linkup";
                    Fill_Grid_Mapped_Entity(new Guid(Request.QueryString["pk_external_system_configuration_id"]), Entity_code, Entity_name);
                    FacilityLoaded.Value = "true";
                }
                generate_entity_list(SessionController.Users_.Configuration_id.ToString());

            }
        }
        catch (Exception ex)
        {

            throw;
        }


    }

    private void generate_entity_list(string configuration_id)
    {
        try
        {
            DataSet ds = new DataSet();
            SetupSyncClient obj_setupSync_client = new SetupSyncClient();
            SetupSyncModel obj_setupSync_model = new SetupSyncModel();

            obj_setupSync_model.External_system_configuration_id = new Guid(configuration_id);
            ds = obj_setupSync_client.Get_external_system_mapping_details(obj_setupSync_model, SessionController.ConnectionString);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                TableRow tr = new TableRow();
                TableRow Space_tr = new TableRow();
                for (int j = 0; j < 1; j++)
                {
                    TableCell tc = new TableCell();
                    Button lnkBtn = new Button();
                    //lnkBtn.Text = "Map"+" "+ds.Tables[0].Rows[i]["entity_name"].ToString();
                    lnkBtn.Text = (string)GetGlobalResourceObject("Resource", "Map") + " " + ds.Tables[0].Rows[i]["entity_name"].ToString();
                    lnkBtn.ID = ds.Tables[0].Rows[i]["entity_code"].ToString();

                    lnkBtn.Click += new EventHandler(this.show_selected_entityGrid);

                    //lnkBtn.ForeColor = Color.FromArgb(153,0,51);
                    //lnkBtn.Font.Name = "Verdana";

                    lnkBtn.Font.Size = FontUnit.Small;
                    lnkBtn.Width = 140;
                    //lnkBtn.Font.Size = FontUnit.Medium;
                    // Add the control to the TableCell
                    tc.Controls.Add(lnkBtn);
                    // Add the TableCell to the TableRow
                    tr.Cells.Add(tc);
                }
                tblEntityNameList.Rows.Add(tr);
                tblEntityNameList.Rows.Add(Space_tr);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void show_selected_entityGrid(object sender, EventArgs e)
    {
        try
        {
            lblMapMsg.Text = "";
            //LinkButton lnkBtn = (LinkButton)sender;
            Button lnkBtn = (Button)sender;
            SetupSyncClient obj_setupSync_client = new SetupSyncClient();
            SetupSyncModel obj_setupSync_model = new SetupSyncModel();
            DataSet ds = new DataSet();
            obj_setupSync_model.External_system_configuration_id = new Guid(SessionController.Users_.Configuration_id);
            ds = obj_setupSync_client.Get_external_system_mapping_details(obj_setupSync_model, SessionController.ConnectionString);

            Entity_code = lnkBtn.ID.ToString();
            Entity_name = lnkBtn.Text;
            hdnEntityCode.Value = lnkBtn.ID.ToString();
            hdnEntityName.Value = lnkBtn.Text.ToString();


            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (ds.Tables[0].Rows[i]["entity_code"].ToString().Equals(Entity_code.ToString()))
                {

                    this.Table_Name = ds.Tables[0].Rows[i]["mapping_table_name"].ToString();
                    hdnTableName.Value = this.Table_Name;
                    break;
                }
            }


            if (Request.QueryString["pk_external_system_configuration_id"] != Guid.Empty.ToString())
            {
                Fill_Grid_Mapped_Entity(new Guid(Request.QueryString["pk_external_system_configuration_id"]), Entity_code, Entity_name);
            }
            else
            {
                Fill_External_System_Mapping_Grid(Entity_code, Entity_name);

            }



        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    private void Fill_Grid_Mapped_Entity(Guid guid, string Entity_code, string Entity_name)
    {

        try
        {
            string table_name = hdnTableName.Value.ToString();
            SetupSyncClient obj_setupSync_client = new SetupSyncClient();
            SetupSyncModel obj_setupSync_model = new SetupSyncModel();
            DataSet ds = null;
            Fill_External_System_Mapping_Grid(Entity_code, Entity_name);


        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void Fill_External_System_Mapping_Grid(string Entity_code, string Entity_name)
    {
        try
        {
            SetupSyncClient obj_setupSync_client = new SetupSyncClient();
            SetupSyncModel obj_setupSync_model = new SetupSyncModel();
            DataSet ds = new DataSet();

            obj_setupSync_model.Entity_code = Entity_code.ToString();
            obj_setupSync_model.User_id = new Guid(SessionController.Users_.UserId);
            obj_setupSync_model.External_system_configuration_id = new Guid(SessionController.Users_.Configuration_id.ToString());
            ds = obj_setupSync_client.Get_mapping_entity_details(obj_setupSync_model, SessionController.ConnectionString);
            //RgEntityMappingGrid.Columns[1].HeaderText = Entity_name.ToString().Replace("Map","");
            RgEntityMappingGrid.Columns[1].HeaderText = Entity_name.ToString().Replace((string)GetGlobalResourceObject("Resource", "Map"), "");
            RgEntityMappingGrid.DataSource = ds;
            RgEntityMappingGrid.DataBind();
            btnMap.Visible = true;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void OnItemDataBound_rgClient(object sender, GridItemEventArgs e)
    {

        try
        {
            DataSet ds = new DataSet();
            SetupSyncClient obj_setupSync_client = new SetupSyncClient();
            SetupSyncModel obj_setupSync_model = new SetupSyncModel();
            EcoDomus.ES.ExternalIntigration tmp = new EcoDomus.ES.ExternalIntigration();
            RadComboBox cmbExternalSystem = (RadComboBox)e.Item.FindControl("cmbExternalSystem");
            CryptoHelper objCryptoHelper = new CryptoHelper();


            if (cmbExternalSystem != null)
            {
                obj_setupSync_model.External_system_configuration_id = new Guid(SessionController.Users_.Configuration_id);
                ds = obj_setupSync_client.Get_external_system_mapping_details(obj_setupSync_model, SessionController.ConnectionString);
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (ds.Tables[0].Rows[i]["entity_code"].ToString().Equals(hdnEntityCode.Value.ToString()))
                    {
                        string configuration_id = SessionController.Users_.Configuration_id.ToString();
                        string external_entity_group_name = ds.Tables[0].Rows[i]["external_entity_group_name"].ToString();
                        string external_entity_name = ds.Tables[0].Rows[i]["external_entity_name"].ToString();
                        string external_entity_value_feild = ds.Tables[0].Rows[i]["external_entity_value_feild"].ToString();
                        string external_entity_id_field = ds.Tables[0].Rows[i]["external_entity_id_feild"].ToString();
                        //DataSet ds = tmp.GetMappingEntityDetails("104EEB4D-F440-E111-96C1-00101832264B", "OrganizationBusinessObjects", "Building", "PK", "fb_name");
                        DataSet external_system_ds = tmp.GetMappingEntityDetails(configuration_id, external_entity_group_name, external_entity_name.Trim(), external_entity_id_field.Trim(), external_entity_value_feild.Trim(), objCryptoHelper.Decrypt(SessionController.ConnectionString));
                        cmbExternalSystem.DataTextField = "TypeValue";
                        cmbExternalSystem.DataValueField = "TypeId";
                        cmbExternalSystem.DataSource = external_system_ds;
                        cmbExternalSystem.DataBind();
                    }

                }

            }
        }

        catch (Exception ex)
        {

            throw ex;
        }

      
    }

    protected void save_mapped_record(object sender, EventArgs e)
    {
        try
        {
            SetupSyncClient obj_setupSync_client = new SetupSyncClient();
            SetupSyncModel obj_setupSync_model = new SetupSyncModel();
            foreach (GridDataItem item in RgEntityMappingGrid.Items)
            {
                RadComboBox cmbExternalSystem = (RadComboBox)item.FindControl("cmbExternalSystem");
                string ecodomus_system_data_id = item.OwnerTableView.DataKeyValues[item.ItemIndex]["TypeId"].ToString();
                obj_setupSync_model.Table_name = hdnTableName.Value.ToString();
                obj_setupSync_model.External_system_configuration_id = new Guid(SessionController.Users_.Configuration_id);
                obj_setupSync_model.Ecodomus_system_data_id = ecodomus_system_data_id;
                obj_setupSync_model.External_system_data_id = cmbExternalSystem.SelectedValue.ToString();
                obj_setupSync_model.Created_by_user_id = new Guid(SessionController.Users_.UserId);
                obj_setupSync_model.Modified_by_user_id = new Guid(SessionController.Users_.UserId);
                if (!cmbExternalSystem.Text.ToString().Equals("-Select-"))
                {
                    obj_setupSync_client.Insert_and_update_entity_data(obj_setupSync_model, SessionController.ConnectionString);
                }
            }
            lblMapMsg.Text = (string)GetGlobalResourceObject("Resource", "Mapping_Done"); //"Mapping Done";
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


            //RadMultiPage multiPage = (RadMultiPage)userContentHolder.FindControl("rmpageSetupSync");
            //RadPageView assetTypePageView = multiPage.FindPageViewByID("assetType");
            //assetTypePageView.Selected = true;

            //27 Jan 2012
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
    protected void RgEntityMappingGrid_pageindexchanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            Fill_Grid_Mapped_Entity(new Guid(SessionController.Users_.Configuration_id), hdnEntityCode.Value.ToString(), hdnEntityName.Value.ToString());
            //Guid guid = new Guid(SessionController.Users_.Configuration_id);
            //Fill_Grid_Mapped_Entity(guid, Entity_code,Entity_name);
            //show_selected_entityGrid(null, null); 


        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void RgEntityMappingGrid_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            //Guid guid = new Guid(SessionController.Users_.Configuration_id);
            //Fill_Grid_Mapped_Entity(guid, Entity_code, Entity_name);
            Fill_Grid_Mapped_Entity(new Guid(SessionController.Users_.Configuration_id), hdnEntityCode.Value.ToString(), hdnEntityName.Value.ToString());
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void RgEntityMappingGrid_OnDataBound(object sender, EventArgs e)
    {
        SetupSyncClient obj_setupSync_client = new SetupSyncClient();
        SetupSyncModel obj_setupSync_model = new SetupSyncModel();
        DataSet ds = null;
        if (Request.QueryString["pk_external_system_configuration_id"].ToString() != Guid.Empty.ToString())
        {
            try
            {
                obj_setupSync_model.External_system_configuration_id = new Guid(SessionController.Users_.Configuration_id);
                obj_setupSync_model.Table_name = hdnTableName.Value.ToString();
                ds = obj_setupSync_client.Get_mapped_entity_details(obj_setupSync_model, SessionController.ConnectionString);
                DataRow dr;
                int i = 0;

                foreach (GridDataItem item in RgEntityMappingGrid.Items)
                {
                    string ecodomus_system_data_id = item.OwnerTableView.DataKeyValues[item.ItemIndex]["TypeId"].ToString();
                    for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        dr = ds.Tables[0].Rows[i];
                        string IDValue = dr[1].ToString();
                        if (ecodomus_system_data_id != null && ecodomus_system_data_id.ToString().Equals(dr[0].ToString()))
                        {
                            RadComboBox cmbExternalSystem = (RadComboBox)item.FindControl("cmbExternalSystem");
                            if (cmbExternalSystem != null)
                            {

                                cmbExternalSystem.SelectedValue = IDValue.ToString();


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
}