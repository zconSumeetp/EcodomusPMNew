using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using System.Threading;
using System.Globalization;
using Facility;
using TypeProfile;

public partial class App_Asset_SystemProfile : System.Web.UI.Page
{
    #region Page Events
    string Master_flag = "";
    string UniClass_flag = "";
    string UniFormat_flag = "";
    string OmniClass_flag = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (Convert.ToString(Request.QueryString["popupflag"]) == "popup")
                {
                    hfpopupflag.Value = Convert.ToString(Request.QueryString["popupflag"]); 
                    tbltitle.Style.Value = "display:inline";
                    lblpopup.Text = "System Profile";
                    //divProfilePage.Style.Add("margin-left", "30px");
                    lblpopup.Visible = true;
                    btnclose.Visible = true;
                }
                else
                {
                    tbltitle.Style.Value = "display:none";
                    lblpopup.Visible = false;
                    btnclose.Visible = false;
                }
                if (!IsPostBack)
                {

                    if (Request.QueryString["system_id"] != null)
                    {
                        if (Request.QueryString["system_id"].ToString() != "")
                        {

                            if (Request.QueryString["system_id"] != null && Request.QueryString["value"].ToString() == "system")
                            {
                                hfSystemId.Value = Request.QueryString["system_id"].ToString();
                                Unlabel();
                                BindSystem();
                            }

                            else if (Request.QueryString["system_id"].ToString() == Guid.Empty.ToString() && Request.QueryString["value"].ToString() == "blank")
                            {
                                hfSystemId.Value = Request.QueryString["system_id"].ToString();
                                Unlabel();
                            }

                            else
                            {
                                hfSystemId.Value = Request.QueryString["system_id"].ToString();
                                Label();
                                BindSystem();
                            }
                        }
                    }
                    else
                    {
                        hfSystemId.Value = Guid.Empty.ToString();
                        Unlabel();
                    }
                }
               //  show_hide_standards();
            }
            else
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void Page_Prerender(object sender, EventArgs e)
    {
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

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='System'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "System Profile")
                {
                    // Edit/Delete permission for component
                    SetPermissionToControl(dr_profile);

                    // permissions for component profile fields
                    DataRow[] dr_fields_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_profile["pk_project_role_controls"] + "'");
                    foreach (DataRow dr in dr_fields_component)
                    {
                        SetPermissionToControl(dr);
                    }

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
        string view_permission = dr["view_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();
        // delete button on component profile
        if (dr["name"].ToString() == "System Profile")
        {
            objPermission.SetEditable(btndelete, delete_permission);
        }
    }

    #endregion

    #region Event Handlers

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                Systems.SystemsClient objSystemsClient = new Systems.SystemsClient();
                Systems.SystemsModel objSystemsModel = new Systems.SystemsModel();

                if (hfSystemId.Value != "")
                {
                    if (hfSystemId.Value == Guid.Empty.ToString())
                    {
                        objSystemsModel.SystemId = Guid.Empty;
                    }
                    else
                    {
                        objSystemsModel.SystemId = new Guid(hfSystemId.Value);
                    }
                }

                objSystemsModel.Description = txtDescription.Text;
                objSystemsModel.SystemName = txtSystemName.Text;
                objSystemsModel.UserId = new Guid(SessionController.Users_.UserId);

                // Telerik.Web.UI.RadComboBox objCmbFacility = (Telerik.Web.UI.RadComboBox)FacilityUserControlComboFacility.FindControl("cmbFacility");
                // UserControl.UserControlClient objUserControlClient = new UserControl.UserControlClient();
                // string strRoleDesr = SessionController.Users_.UserRoleDescription;
                // string strRole = SessionController.Users_.UserSystemRole;
                System.Text.StringBuilder strFacilityIds = new System.Text.StringBuilder();
                foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
                    {
                        strFacilityIds.Append(rcbItem.Value);
                        strFacilityIds.Append(",");
                    }
                }
                if (strFacilityIds.ToString().Length > 0)
                {
                    strFacilityIds = strFacilityIds.Remove(strFacilityIds.ToString().Length - 1, 1);
                }

                objSystemsModel.FacilityIds = strFacilityIds.ToString();

                if (hf_lblOmniClassid.Value == "")
                {
                    objSystemsModel.OmniclassId = Guid.Empty;
                }
                else
                {
                    objSystemsModel.OmniclassId = new Guid(hf_lblOmniClassid.Value);
                }

                if (hf_uniclass_id.Value == "")
                {
                    objSystemsModel.UniclassId = Guid.Empty;
                }
                else
                {
                    objSystemsModel.UniclassId = new Guid(hf_uniclass_id.Value);
                }

                Guid guidNewSystemId = new Guid();
                guidNewSystemId = objSystemsClient.InsertUpdateSystem(objSystemsModel, SessionController.ConnectionString);
                hfSystemId.Value = guidNewSystemId.ToString();
                if (hfpopupflag.Value == "popup")
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParentpopup();", true);
                else
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);

            }
            else
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    /*   protected void btnEdit_Click(object sender, EventArgs e)
       {
           try
           {
               Unlabel();
               BindSystem();
           }
           catch (Exception ex)
           {
               throw ex;
           }
       }*/

    protected void btndelete_Click(object sender, EventArgs e)
    {
        try
        {

            Systems.SystemsModel objSystemsModel = new Systems.SystemsModel();
            Systems.SystemsClient objSystemsClient = new Systems.SystemsClient();
            objSystemsModel.SystemIds = hfSystemId.Value;
            objSystemsModel.SystemIds.Trim();
            objSystemsModel.SystemIds.Trim(',');
            objSystemsClient.DeleteSystems(objSystemsModel, SessionController.ConnectionString);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "naviagate", "naviagatetoProject();", true);

        }

        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void cmbfacility_ItemDataBound(object sender, Telerik.Web.UI.RadComboBoxItemEventArgs e)
    {
        try
        {
            ((CheckBox)e.Item.FindControl("CheckBox1")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");
            //BindFacility();

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

    #region Private Methods
    protected void show_hide_standards()
    {
        DataSet ds_TypeCount = new DataSet();

        DataSet ds = new DataSet();
        TypeModel tm = new TypeModel();
        TypeProfileClient tc = new TypeProfileClient();

        tm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
        tm.Flag = "type";
        tm.Txt_Search = "";
        ds_TypeCount = tc.bindtypepm_count_v1(tm, SessionController.ConnectionString);

        if (ds_TypeCount.Tables[2] != null)
        {
            if (ds_TypeCount.Tables[2].Rows.Count > 0)
            {
                for (int i = 0; i < ds_TypeCount.Tables[2].Rows.Count; i++)
                {
                    if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "MasterFormat")
                    {
                        Master_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                    }
                    else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "OmniClass 2010")
                    {
                        OmniClass_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                    }
                    else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "UniFormat")
                    {
                        UniFormat_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                    }
                    else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "UniClass")
                    {
                        UniClass_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                    }
                }
            }
            if (UniClass_flag != "")
            {
                hf_uniclass.Value = "Y";
            }
            else
            {
                hf_uniclass.Value = "N";
            }
            if (OmniClass_flag != "")
            {
                hf_omniclass.Value = "Y";
            }
            else
            {
                hf_omniclass.Value = "N";
            }

            if (hf_omniclass.Value == "N" && hf_uniclass.Value == "N")
            {
                td_category.Style.Add("display", "none");
            }
        }

    }

    private void BindSystem()
    {
        try
        {
            show_hide_standards();
            Systems.SystemsModel objSystemsModel = new Systems.SystemsModel();
            Systems.SystemsClient objSystemsClient = new Systems.SystemsClient();
            DataSet ds = new DataSet();
            if (hfSystemId.Value == Guid.Empty.ToString())
            {
                objSystemsModel.SystemId = Guid.Empty;
            }
            else
            {
                objSystemsModel.SystemId = new Guid(hfSystemId.Value);
            }
            ds = objSystemsClient.GetSystemProfile(objSystemsModel, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblSystemName.Text = ds.Tables[0].Rows[0]["SystemName"].ToString();
                txtSystemName.Text = ds.Tables[0].Rows[0]["SystemName"].ToString();

                lblFacilityNames.Text = ds.Tables[0].Rows[0]["FacilityNames"].ToString();

                string strFacilityNames = ds.Tables[0].Rows[0]["FacilityNames"].ToString();
                string[] arrStrFacilityNames = strFacilityNames.Split(',');
                List<string> listFacilityNames = new List<string>(arrStrFacilityNames);

                cmbfacility.SelectedValue = lblFacilityNames.Text;
                for (int j = 0; j < cmbfacility.Items.Count; j++)
                {
                    foreach (string temp in arrStrFacilityNames)
                    {
                        if (cmbfacility.Items[j].Text == temp)
                        {
                            CheckBox checkbox = (CheckBox)cmbfacility.Items[j].FindControl("CheckBox1");
                            checkbox.Checked = true;
                        }
                    }
                }
                cmbfacility.Text = ds.Tables[0].Rows[0]["FacilityNames"].ToString();
                #region If Treeview is present instead of combobox
                //Telerik.Web.UI.RadComboBox objCmbFacility = (Telerik.Web.UI.RadComboBox)FacilityUserControlComboFacility.FindControl("cmbFacility");          
                //foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
                //{
                //    Telerik.Web.UI.RadTreeView objRadTreeView = (Telerik.Web.UI.RadTreeView)rcbItem.FindControl("rtvFacilities");
                //    foreach (Telerik.Web.UI.RadTreeNode rootNode in objRadTreeView.Nodes)
                //    {
                //        foreach (string strFacilityName in listFacilityNames)
                //        {

                //            foreach (Telerik.Web.UI.RadTreeNode Node in rootNode.Nodes)
                //            {
                //                if (Node.Text.Equals(strFacilityName))
                //                {
                //                    Node.Checked = true;
                //                }
                //            }
                //        }

                //    }
                //}
                #endregion
                lblSystemDescription.Text = ds.Tables[0].Rows[0]["SystemDescription"].ToString();
                txtDescription.Text = ds.Tables[0].Rows[0]["SystemDescription"].ToString();
                if (hf_uniclass.Value != "")
                {
                    if (hf_uniclass.Value == "Y")
                    {
                        lblOmniClass.Text = ds.Tables[0].Rows[0]["UniclassName"].ToString();
                        hf_uniclass_id.Value = ds.Tables[0].Rows[0]["uniclassid"].ToString();
                    }
                    else
                    {
                        lblOmniClass.Text = ds.Tables[0].Rows[0]["OmniclassName"].ToString();
                        hf_lblOmniClassid.Value = ds.Tables[0].Rows[0]["OmniclassId"].ToString();
                    }
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void Label()
    {
        try
        {
            lblSystemName.Visible = true;
            txtSystemName.Visible = false;


            lblSystemDescription.Visible = true;
            txtDescription.Visible = false;

            lblFacilityNames.Visible = true;
            cmbfacility.Visible = false;
            //FacilityUserControlComboFacility.Visible = false;

            lnkAddOmniclass.Visible = false;
            lblOmniClass.Visible = true;

            //btnEdit.Visible = true;

            btnSave.Visible = false;
            btnCancel.Visible = false;
            btndelete.Visible = true;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void Unlabel()
    {
        try
        {
            lblSystemName.Visible = false;
            txtSystemName.Visible = true;


            lblSystemDescription.Visible = false;
            txtDescription.Visible = true;

            lblFacilityNames.Visible = false;

            BindFacility();

            cmbfacility.Visible = true;
            //FacilityUserControlComboFacility.Visible = true ;

            lnkAddOmniclass.Visible = true;
            lblOmniClass.Visible = true;

            //btnEdit.Visible = false; added

            btnSave.Visible = true;
            btnCancel.Visible = true;
            btndelete.Visible = false;
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    void BindFacility()
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        DataSet ds_facilitypm = new DataSet();
        fm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
        fm.Search_text_name = "";
        fm.Doc_flag = "floor";
        ds_facilitypm = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);
        cmbfacility.DataTextField = "name";
        cmbfacility.DataValueField = "pk_facility_id";
        cmbfacility.DataSource = ds_facilitypm;
        cmbfacility.DataBind();
    }

    #endregion


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

            // redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (hfSystemId.Value == "00000000-0000-0000-0000-000000000000")
        {
            //top.location.href = 'System.aspx';
            //Response.Redirect("System.aspx?");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "Navigate();", true);
        }
        else
        {

            if (hfpopupflag.Value == "popup")
            {
                //str = '../Asset/Systemprofile_1.aspx?system_id=' + document.getElementById('hfSystemId').value + "&popupflag=popup&value=system";
                //window.location.href = str;
                // Response.Redirect("../Asset/Systemprofile_1.aspx?system_id=" + hfSystemId.Value.ToString() + "&popupflag=popup");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "Navigate();", true);
            }
            else
            {
                //str = str = '../Asset/SystemMenu.aspx?system_id=' + document.getElementById('hfSystemId').value;
                //  Response.Redirect("Systemprofile.aspx?system_id=" + hfSystemId.Value.ToString());
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "Navigate();", true);
            }
        }

    }
}