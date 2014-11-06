using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EcoDomus.Session;
using System.Text;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;
using Facility;
using TypeProfile;


public partial class App_Asset_TypeProfile : System.Web.UI.Page
{
    string fac = "";
    Guid TypeId = Guid.Empty;
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
                if (Request.QueryString["popupflag"] == "popup")
                {
                    tbltitle.Style.Value = "display:inline";
                    hfpopupflag.Value = "popup";
                    lblpopup.Visible = true;
                    //divProfilePage.Style.Add("margin-left", "30px");
                    btnclose.Visible = true;
                }
                else
                {
                    tbltitle.Style.Value = "display:none";
                    btnclose.Visible = false;
                    lblpopup.Visible = false;
                }
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "SetCaption", "SetCaption();", true);
                if (!IsPostBack)
                {
                    if (SessionController.Users_.is_PM_FM == "FM")
                    {
                        btnBrowseByManufacturer.Visible = false;
                        btnAddByModelNumber.Visible = false;

                        hfProductAssigned.Value = "N ";

                        BindAssets();
                        bind_WarrantyGuarantorParts();
                        BindUniformat();
                        BindMasterformat();
                        BindDurationUnit();

                        TypeId = new Guid(Request.QueryString["type_id"].ToString());
                        if ((Request.QueryString["type_id"].ToString()) != "00000000-0000-0000-0000-000000000000")
                        {
                            GridSortExpression sortExpr = new GridSortExpression();
                            sortExpr.FieldName = "name";
                            sortExpr.SortOrder = GridSortOrder.Ascending;
                            //Add sort expression, which will sort against first column
                            // RgFacilityList.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                            BindTypeProfileInformation(TypeId);
                        }
                        else
                        {
                            btnBrowseByManufacturer.Visible = false;
                            btnAddByModelNumber.Visible = false;
                        }
                    }
                    else
                    {
                        if (Request.QueryString["type_id"] != null)
                        {
                            if (Request.QueryString["type_id"].ToString() != "")
                            {
                                if (Request.QueryString["type_id"].ToString() == Guid.Empty.ToString())
                                {
                                    hf_type_id.Value = Request.QueryString["type_id"].ToString();
                                    EnableControl();
                                }
                                else
                                {
                                    hf_type_id.Value = Request.QueryString["type_id"].ToString();
                                    Guid type_id = new Guid(hf_type_id.Value);
                                    disableControl();
                                    BindAssets();
                                    BindDurationUnit();
                                    GridSortExpression sortExpr = new GridSortExpression();
                                    sortExpr.FieldName = "name";
                                    sortExpr.SortOrder = GridSortOrder.Ascending;
                                    //    //Add sort expression, which will sort against first column
                                    //RgFacilityList.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                                    BindTypeProfileInformation(type_id);
                                 }
                            }
                        }
                        else
                        {
                            hf_type_id.Value = Guid.Empty.ToString();
                            EnableControl();
                        }
                        // cmb_facility.Visible = true;
                        lnk_assgnFacility.Visible = false;
                        //BindAssets();
                        // bindfacility();
                        //BindUniformat();
                        //  BindMasterformat();
                        BindDurationUnit();
                        //COmmented 28_04_2012
                        //TypeId = new Guid(Request.QueryString["type_id"].ToString());
                        //if ((Request.QueryString["type_id"].ToString()) != "00000000-0000-0000-0000-000000000000")
                        //{
                        //    GridSortExpression sortExpr = new GridSortExpression();
                        //    sortExpr.FieldName = "name";
                        //    sortExpr.SortOrder = GridSortOrder.Ascending;
                        //    //Add sort expression, which will sort against first column
                        //   RgFacilityList.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                        //    BindTypeProfileInformation(TypeId);
                        //}
                        //else
                        //{
                        //    btnBrowseByManufacturer.Visible = false;
                        //    btnAddByModelNumber.Visible = false;
                        //}

                    }
                }

                //if (btnEdit.Text == "Edit")
                //{
                //    btnCancel.Visible = false;
                //    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "SetCaption", "SetCaption1();", false);
                //}
                //else
                //    btnCancel.Visible = true;

               

            }
            else
            {
              
                //Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }
            show_hide_standards();
            LinkButton2.Visible = false;
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Page_Load:" + ex.ToString();
        }
    }


    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {

            if (SessionController.Users_.UserSystemRole == "GU")
            {
                btnDelete.Visible = false;
                btnEdit.Visible = false;

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
            DataRow dr_component = ds_component.Tables[0].Select("name='Type'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Type Profile")
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
        if (dr["name"].ToString() == "Type Profile")
        {
            objPermission.SetEditable(btnDelete, delete_permission);
            objPermission.SetEditable(btnEdit, edit_permission);
        }
    }

    protected void show_hide_standards()
    {
        DataSet ds_TypeCount = new DataSet();

        DataSet ds = new DataSet();
        TypeModel tm = new TypeModel();
        TypeProfileClient tc = new TypeProfileClient();

        tm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
        tm.Flag = "type";
        //original code is this
        //tm.Txt_Search = SessionController.Users_.TypeSearchText;
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
            if (Master_flag == "")
            {
                lblMasterFormat.Visible = false;
                lblMasterFormat1.Visible = false;
                LinkButton2.Visible = false;
            }
            else
            {
                lblMasterFormat.Visible = true;
                lblMasterFormat1.Visible = true;
                LinkButton2.Visible = true;
            }
            if (UniClass_flag == "")
            {
                lbl_uniclass_value.Visible = false;
                //td_uniclass.Visible = false;
            }
            else
            {
                lbl_uniclass_value.Visible = true;
                lblOmniClass.Visible = false;
                //td_uniclass.Visible = true;
            }
            if (UniFormat_flag == "")
            {
                td_uniformat1.Visible = false;
                td_uniformat.Visible = false;
            }
            else
            {
                td_uniformat1.Visible = true;
                td_uniformat.Visible = true;
            }
            if (OmniClass_flag == "")
            {
                lblOmniClass.Visible = false;
                //td_omniclass1.Visible = false;
                //td_omniclass.Visible = false;
            }
            else
            {
                lblOmniClass.Visible = true;
                lbl_uniclass_value.Visible = false;
                //td_omniclass1.Visible = true;
                //td_omniclass.Visible = true;
            }
        }

    }

    protected void bindfacility()
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        DataSet ds = new DataSet();
        DataSet ds1 = new DataSet();
        try
        {
            fm.Project_id = new Guid(SessionController.Users_.ProjectId);
            fm.Search_text_name = "";
            fm.Doc_flag = "floor";
            ds = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                cmb_facility.DataTextField = "name";
                cmb_facility.DataValueField = "pk_facility_id";
                cmb_facility.DataSource = ds;
                cmb_facility.DataBind();
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void navigate(object sender, EventArgs e)
    {
        //bindfacility();
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
        catch (Exception)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);

        }
    }

    private void BindTypeProfileInformation(Guid TypeId)
    {
        try
        {
            DataSet ds = new DataSet();
            DataSet ds_fac = new DataSet();
            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
            TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
            mdl.Type_Id = TypeId;
            ds = TypeClient.GetTypeProfileInformation(mdl, SessionController.ConnectionString);
            BindDataToControls(ds);
            bindfacilityinformation(TypeId);
            // disableControl();
        }
        catch (Exception ex)
        {

            lblMsg.Text = "BindTypeProfileInformation:" + ex.ToString();
        }

    }

    protected void bindfacilityinformation(Guid TypeId)
    {
        DataSet ds_fac = new DataSet();
        string name = "";
        TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
        TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
        mdl.Type_Id = TypeId;
        ds_fac = TypeClient.Getfacilitynamepm(mdl, SessionController.ConnectionString);
        foreach (DataRow dr in ds_fac.Tables[0].Rows)
        {
            name = name + dr["name"].ToString() + ",";
        }
        if (name.Length > 0)
        {
            name = name.Remove(name.ToString().Length - 1, 1);
        }

        lblFacility.Text = name.Length > 50 ? name.Substring(0, 50) + "..." : name;
        lblFacility.ToolTip = name;

        string fac_id = "";
        foreach (DataRow dr in ds_fac.Tables[0].Rows)
        {
            fac_id = fac_id + dr["pk_facility_id"].ToString() + ",";
        }
        if (fac_id.Length > 0)
        {
            fac_id = fac_id.Remove(fac_id.ToString().Length - 1, 1);
        }
        cmb_facility.SelectedValue = fac_id.ToString();

        //string[] val = name.Split(',');
        //for (int i = 0; i <= val.Length - 1; i++)
        //{
        //    if (val[i].ToString() != "")
        //    {
        //        var chkbox = (CheckBox)cmb_facility.Items.FindItemByText(val[i]).FindControl("CheckBox1");
        //        chkbox.Checked = true;
        //    }
        //}

    }

    //private void BindFacilityGrid(Guid TypeId)
    //{
    //    DataSet ds_fac = new DataSet();
    //    TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
    //    TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
    //    mdl.Type_Id = TypeId;
    //    mdl.User_id = new Guid(SessionController.Users_.UserId);
    //    mdl.ClientId = new Guid(SessionController.Users_.ClientID);
    //    mdl.Organization_Id = new Guid(SessionController.Users_.OrganizationID);
    //    mdl.System_Role = SessionController.Users_.UserSystemRole;
    //    ds_fac = TypeClient.GetFaciliyListForType(mdl, SessionController.ConnectionString);
    //    RgFacilityList.DataSource = ds_fac;
    //    RgFacilityList.DataBind();
    //}


    private void disableControl()
    {
        lnkSelectManufacturer.Visible = false;
        btnOmniClass.Visible = false;
        lnk_assgnFacility.Visible = false;

        // RgFacilityList.Visible = false;
        cmb_facility.Visible = false;

        cmb_facility.Visible = false;
        LinkButton1.Visible = false;
        LinkButton2.Visible = false;
        LinkButton3.Visible = false;
        LinkButton4.Visible = false;


        cmbAssetType.Style["Display"] = "None";
        cmbAssetType.Visible = false;
        lblAssetType.Visible = true;

        cmbMasterFormat.Style["Display"] = "None";
        cmbMasterFormat.Visible = false;
        lblMasterFormat.Visible = true;

        cmbUniFormat.Style["Display"] = "None";
        cmbUniFormat.Visible = false;
        lblUniFormat.Visible = true;

        cmbWarrantyDurationUnit.Style["Display"] = "None";
        cmbWarrantyDurationUnit.Visible = false;
        lblWarrantyDurationUnit.Visible = true;

        cmbWarrantyGuarantorLabor.Style["Display"] = "None";
        cmbWarrantyGuarantorLabor.Visible = false;
        lblWarrantyGuarantorLabor.Visible = true;

        cmbWarrantyGurantorPart.Style["Display"] = "None";
        cmbWarrantyGurantorPart.Visible = false;
        lblWarrantyGuarantorParts.Visible = true;

        // txtName.ReadOnly = true;
        // txtName.CssClass = "SmallTextBoxBorder";

        txtDescription.ReadOnly = true;
        txtDescription.CssClass = "SmallTextBoxBorder";
        //txtExpectedLife.ReadOnly = true;
        //txtExpectedLife.CssClass = "SmallTextBoxBorder";
       // txtModelNumber.ReadOnly = true;
        //txtModelNumber.CssClass = "SmallTextBoxBorder";
        //txtPartNumber.ReadOnly = true;
        //txtPartNumber.CssClass = "SmallTextBoxBorder";
        //txtReplacementCost.ReadOnly = true;
        //txtReplacementCost.CssClass = "SmallTextBoxBorder";
       // txtWarrantyDescription.ReadOnly = true;
        //txtWarrantyDescription.CssClass = "SmallTextBoxBorder";
        //txtWarrantyDurationLabor.ReadOnly = true;
        //txtWarrantyDurationLabor.CssClass = "SmallTextBoxBorder";
       // txtWarrantyDurationPart.ReadOnly = true;
        //txtWarrantyDurationPart.CssClass = "SmallTextBoxBorder";
    }

    //for edit mode enable all dropdowns and textboxes
    private void EnableControl()
    {

        lnkSelectManufacturer.Visible = true;
        btnOmniClass.Visible = true;
        lnk_assgnFacility.Visible = false;

        cmbAssetType.Style["Display"] = "Block";
        cmbAssetType.Visible = true;
        lblAssetType.Visible = false;

        //cmbMasterFormat.Style["Display"] = "Block";
        LinkButton1.Visible = true; ;
        //cmbMasterFormat.Visible = true;
        lblMasterFormat.Visible = true;

        cmbUniFormat.Style["Display"] = "Block";

        //cmbUniFormat.Visible = true;
        LinkButton2.Visible = true;
        lblUniFormat.Visible = true;

        LinkButton3.Visible = true;
        lblDesigner.Visible = true;

        LinkButton4.Visible = true;
        lblContractor.Visible = true;


        cmbWarrantyDurationUnit.Style["Display"] = "Block";
        cmbWarrantyDurationUnit.Visible = true;
        lblWarrantyDurationUnit.Visible = false;

        cmbWarrantyGuarantorLabor.Style["Display"] = "Block";
        cmbWarrantyGuarantorLabor.Visible = true;
        lblWarrantyGuarantorLabor.Visible = false;

        cmbWarrantyGurantorPart.Style["Display"] = "Block";
        cmbWarrantyGurantorPart.Visible = true;
        lblWarrantyGuarantorParts.Visible = false;

        cmb_facility.Visible = true;

        lblFacility.Visible = false;


        // txtName.ReadOnly = false;
        // txtName.CssClass = "SmallTextBox";

        txtDescription.ReadOnly = false;
        txtDescription.CssClass = "SmallTextBox";
       // txtExpectedLife.ReadOnly = false;
       // txtExpectedLife.CssClass = "SmallTextBox";
        //txtModelNumber.ReadOnly = false;
        //txtModelNumber.CssClass = "SmallTextBox";
        //txtPartNumber.ReadOnly = false;
        //txtPartNumber.CssClass = "SmallTextBox";
        //txtReplacementCost.ReadOnly = false;
        //txtReplacementCost.CssClass = "SmallTextBox";
        //txtWarrantyDescription.ReadOnly = false;
        //txtWarrantyDescription.CssClass = "SmallTextBox";
        //txtWarrantyDurationLabor.ReadOnly = false;
        //txtWarrantyDurationLabor.CssClass = "SmallTextBox";
        //txtWarrantyDurationPart.ReadOnly = false;
        //txtWarrantyDurationPart.CssClass = "SmallTextBox";


        DataSet ds_fac = new DataSet();
        string name = "";
        TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
        TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
        mdl.Type_Id = new Guid(hf_type_id.Value.ToString());
        ds_fac = TypeClient.Getfacilitynamepm(mdl, SessionController.ConnectionString);

        //string fac_id = "";
        //foreach (DataRow dr in ds_fac.Tables[0].Rows)
        //{
        //    fac_id = fac_id + dr["pk_facility_id"].ToString() + ",";
        //}
        //if (fac_id.Length > 0)
        //{
        //    fac_id = fac_id.Remove(fac_id.ToString().Length - 1, 1);
        //}
        //cmb_facility.SelectedValue = fac_id.ToString();

        string[] val = name.Split(',');
        for (int i = 0; i <= name.Length - 1; i++)
        {
            if (val[i].ToString() != "")
            {
                var chkbox = (CheckBox)cmb_facility.Items.FindItemByText(val[i]).FindControl("CheckBox1");
                if (chkbox.HasAttributes.ToString() == val[i].ToString())
                {
                    chkbox.Checked = true;
                }
            }
        }


    }


    private void BindDataToControls(DataSet ds)
    {
        try
        {
            //btnEdit.Text = "Edit";
            btnBrowseByManufacturer.Visible = false;
            btnAddByModelNumber.Visible = false;

            hf_type_id.Value = ds.Tables[0].Rows[0]["pk_type_id"].ToString();

            //txtName.Text = ds.Tables[0].Rows[0]["type_name"].ToString();
            //hf_type_name.Value = ds.Tables[0].Rows[0]["type_name"].ToString();
            //txtDescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
            lblDescription.Text = ds.Tables[0].Rows[0]["description"].ToString().Length > 55 ? ds.Tables[0].Rows[0]["description"].ToString().Substring(0, 55) + "..." : ds.Tables[0].Rows[0]["description"].ToString();
            lblDescription.ToolTip = ds.Tables[0].Rows[0]["description"].ToString();
            lblOmniClass.Text = ds.Tables[0].Rows[0]["omniclass_name"].ToString().Length > 55 ? ds.Tables[0].Rows[0]["omniclass_name"].ToString().Substring(0, 55) + "..." : ds.Tables[0].Rows[0]["omniclass_name"].ToString();
            lblOmniClass.ToolTip = ds.Tables[0].Rows[0]["omniclass_name"].ToString();
            hf_lblOmniClassid.Value = ds.Tables[0].Rows[0]["fk_omniclass_detail_id"].ToString();
            lblmanufacturer.Text = ds.Tables[0].Rows[0]["manufacturer_name"].ToString().Length > 55 ? ds.Tables[0].Rows[0]["manufacturer_name"].ToString().Substring(0, 55) + "..." : ds.Tables[0].Rows[0]["manufacturer_name"].ToString();
            lblmanufacturer.ToolTip = ds.Tables[0].Rows[0]["manufacturer_name"].ToString();
           
            lbl_uniclass_value.Text = ds.Tables[0].Rows[0]["uniclass"].ToString();
          
            if (lblmanufacturer.Text != "" && btnEdit.Text != "Edit")
            {
                btnBrowseByManufacturer.Visible = true;
            }

            hf_man_org_id.Value = ds.Tables[0].Rows[0]["fk_manufacturer_id"].ToString();

            bind_WarrantyGuarantorParts();

            cmbAssetType.SelectedValue = ds.Tables[0].Rows[0]["fk_asset_type_id"].ToString();
            if (cmbAssetType.SelectedValue == "00000000-0000-0000-0000-000000000000")
            {
                lblAssetType.Text = "N/A";
            }
            else
            {
                lblAssetType.Text = cmbAssetType.SelectedItem.Text;
            }
            //txtModelNumber.Text = ds.Tables[0].Rows[0]["model_number"].ToString();
            lblModelNumber.Text = ds.Tables[0].Rows[0]["model_number"].ToString();
            //txtWarrantyDurationPart.Text = ds.Tables[0].Rows[0]["Warranty_duration_parts"].ToString();
            lblWarrantyDurationPart.Text = ds.Tables[0].Rows[0]["Warranty_duration_parts"].ToString().Length > 55 ? ds.Tables[0].Rows[0]["Warranty_duration_parts"].ToString().Substring(0, 55) + "..." : ds.Tables[0].Rows[0]["Warranty_duration_parts"].ToString();
            lblWarrantyDurationPart.ToolTip = ds.Tables[0].Rows[0]["Warranty_duration_parts"].ToString();
            //txtWarrantyDurationLabor.Text = ds.Tables[0].Rows[0]["Warranty_duration_labor"].ToString();
            lblWarrantyDurationLabor.Text = ds.Tables[0].Rows[0]["Warranty_duration_labor"].ToString();
            cmbWarrantyGurantorPart.SelectedValue = ds.Tables[0].Rows[0]["fk_warranty_guarantor_parts_id"].ToString();
            if (cmbWarrantyGurantorPart.SelectedValue == "00000000-0000-0000-0000-000000000000")
            {
                lblWarrantyGuarantorParts.Text = "N/A";

            }
            else
            {
                lblWarrantyGuarantorParts.Text = cmbWarrantyGurantorPart.SelectedItem.Text.Length > 55 ? cmbWarrantyGurantorPart.SelectedItem.Text.Substring(0, 55) + "..." : cmbWarrantyGurantorPart.SelectedItem.Text;
                lblWarrantyGuarantorParts.ToolTip = cmbWarrantyGurantorPart.SelectedItem.Text;
            }
            cmbWarrantyGuarantorLabor.SelectedValue = ds.Tables[0].Rows[0]["fk_warranty_guarantor_labor_id"].ToString();
            if (cmbWarrantyGuarantorLabor.SelectedValue == "00000000-0000-0000-0000-000000000000")
            {
                lblWarrantyGuarantorLabor.Text = "N/A";
            }
            else
            {
                //lblWarrantyGuarantorLabor.Text = cmbWarrantyGuarantorLabor.SelectedItem.Text;
                lblWarrantyGuarantorLabor.Text = cmbWarrantyGurantorPart.SelectedItem.Text.Length > 55 ? cmbWarrantyGurantorPart.SelectedItem.Text.Substring(0, 55) + "..." : cmbWarrantyGurantorPart.SelectedItem.Text;
                lblWarrantyGuarantorLabor.ToolTip = cmbWarrantyGurantorPart.SelectedItem.Text;
            }

           // txtWarrantyDescription.Text = ds.Tables[0].Rows[0]["Warranty_description"].ToString();
           //( ds.Tables[0].Rows[0]["Warranty_description"].ToString().Equals("") )?(lblWarrantyDescription.Text = ds.Tables[0].Rows[0]["Warranty_description"].ToString() ):( lblWarrantyDescription.Text = "----");
          //Chnages Code for Blank Values not Shows on Front end
            if (!(ds.Tables[0].Rows[0]["Warranty_description"].ToString().Equals("")))
            {
                lblWarrantyDescription.Text = ds.Tables[0].Rows[0]["Warranty_description"].ToString().Length > 55 ? ds.Tables[0].Rows[0]["Warranty_description"].ToString().Substring(0, 55) + "..." : ds.Tables[0].Rows[0]["Warranty_description"].ToString();
                lblWarrantyDescription.ToolTip = ds.Tables[0].Rows[0]["Warranty_description"].ToString();
            }
          
               // lblWarrantyDescription.Text = "----".ToString(); // by pratik to remove the -- from warranty description on 2/5/2014
            //txtReplacementCost.Text = ds.Tables[0].Rows[0]["Replacement_cost"].ToString();
            lblReplacementCost.Text = ds.Tables[0].Rows[0]["Replacement_cost"].ToString().Length > 55 ? ds.Tables[0].Rows[0]["Replacement_cost"].ToString().Substring(0, 55) + "..." : ds.Tables[0].Rows[0]["Replacement_cost"].ToString();
            lblReplacementCost.ToolTip = ds.Tables[0].Rows[0]["Replacement_cost"].ToString();
            cmbWarrantyDurationUnit.SelectedValue = ds.Tables[0].Rows[0]["fk_warranty_duration_unit"].ToString();
            if (cmbWarrantyDurationUnit.SelectedValue == "00000000-0000-0000-0000-000000000000")
            {
                lblWarrantyDurationUnit.Text = "N/A";
            }
            else
            {
                lblWarrantyDurationUnit.Text = cmbWarrantyDurationUnit.SelectedItem.Text;
                lblWarrantyDurationUnit.ToolTip = cmbWarrantyDurationUnit.SelectedItem.Text;
            }
            //txtExpectedLife.Text = ds.Tables[0].Rows[0]["Expected_life"].ToString();
            lblExpectedLife.Text = ds.Tables[0].Rows[0]["Expected_life"].ToString();
            lblExpectedLife.ToolTip = ds.Tables[0].Rows[0]["Expected_life"].ToString().Length > 55 ? ds.Tables[0].Rows[0]["Expected_life"].ToString().Substring(0, 55) + "..." : ds.Tables[0].Rows[0]["Expected_life"].ToString();
            //txtPartNumber.Text = ds.Tables[0].Rows[0]["Part_number"].ToString();
            if (!(ds.Tables[0].Rows[0]["Part_number"].ToString().Equals("")))
            {
                lblPartNumber.ToolTip = ds.Tables[0].Rows[0]["Part_number"].ToString();
                lblPartNumber.Text = ds.Tables[0].Rows[0]["Part_number"].ToString().Length > 55 ? ds.Tables[0].Rows[0]["Part_number"].ToString().Substring(0, 55) + "..." : ds.Tables[0].Rows[0]["Part_number"].ToString();
            }
            else

            lblMasterFormat.ToolTip = ds.Tables[0].Rows[0]["Master_format"].ToString();
            lblMasterFormat.Text = ds.Tables[0].Rows[0]["Master_format"].ToString();//.Length > 55 ? ds.Tables[0].Rows[0]["Master_format"].ToString().Substring(0, 55) + "..." : ds.Tables[0].Rows[0]["Master_format"].ToString();
            lblUniFormat.Text = ds.Tables[0].Rows[0]["uniformat"].ToString();
            lblUniFormat.ToolTip = ds.Tables[0].Rows[0]["uniformat"].ToString();
            lblDesigner.Text = ds.Tables[0].Rows[0]["Designer"].ToString().Length > 55 ? ds.Tables[0].Rows[0]["Designer"].ToString().Substring(0, 55) + "..." : ds.Tables[0].Rows[0]["Designer"].ToString();
            lblDesigner.ToolTip = ds.Tables[0].Rows[0]["Designer"].ToString();
            lblContractor.Text = ds.Tables[0].Rows[0]["Contractor"].ToString();
            lblContractor.ToolTip = ds.Tables[0].Rows[0]["Contractor"].ToString();

            hfFormatId.Value = ds.Tables[0].Rows[0]["fk_masterformat_id"].ToString();
            hfuniformat_id.Value = ds.Tables[0].Rows[0]["fk_uniformat_id"].ToString();






            //DataSet ds1 = new DataSet();
            //TypeProfile.TypeModel tm = new TypeProfile.TypeModel();
            //TypeProfile.TypeProfileClient tc = new TypeProfile.TypeProfileClient();
            //tm.Type_Id = TypeId;
            //tm.User_id = new Guid(SessionController.Users_.UserId.ToString());
            //tm.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
            //tm.Organization_Id = new Guid(SessionController.Users_.OrganizationID.ToString());
            //tm.System_Role = SessionController.Users_.UserSystemRole.ToString();
            //ds1 = tc.Getfacilitynamepm(tm, SessionController.ConnectionString);
            //lblFacility.Text = ds1.Tables[0].Rows[0]["facility_name"].ToString();  


            //cmb_facility.SelectedValue = ds.Tables[0].Rows[0]["facility_id"].ToString();
            //hfselectedId.Value = ds.Tables[0].Rows[0]["facility_id"].ToString();

            //cmbUniFormat.SelectedValue = ds.Tables[0].Rows[0]["fk_uniformat_id"].ToString();
            //if (cmbUniFormat.SelectedValue == "00000000-0000-0000-0000-000000000000")
            //{
            //    lblUniFormat.Text = "N/A";
            //}
            //else
            //{
            //    lblUniFormat.Text = cmbUniFormat.SelectedItem.Text;
            //}
            //cmbMasterFormat.SelectedValue = ds.Tables[0].Rows[0]["fk_manufacturer_id"].ToString();
            //if (cmbMasterFormat.SelectedValue == "00000000-0000-0000-0000-000000000000")
            //{
            //    lblMasterFormat.Text = "N/A";
            //}
            //else
            //{
            //    lblMasterFormat.Text = cmbMasterFormat.SelectedItem.Text;
            //}
        }
        catch (Exception ex)
        {

            lblMsg.Text = "BindDataToControls:" + ex.ToString();
        }
    }

    private void BindMasterformat()
    {
        try
        {

            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
            DataSet ds = TypeClient.GetMasterformat(SessionController.ConnectionString); ;
            cmbMasterFormat.DataTextField = "Name";
            cmbMasterFormat.DataValueField = "Id";

            cmbMasterFormat.DataSource = ds;
            cmbMasterFormat.DataBind();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Bind BindMasterformat:-" + ex.Message;
        }
    }

    protected void BindAssets()
    {
        try
        {
            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
            DataSet ds = TypeClient.GetAssetType(SessionController.ConnectionString); ;

            cmbAssetType.DataTextField = "asset_description";
            cmbAssetType.DataValueField = "asset_type_id";
            cmbAssetType.DataSource = ds;
            cmbAssetType.DataBind();


        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message.ToString();
        }

    }

    protected void bind_WarrantyGuarantorParts()
    {

        TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
        TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
        if (hf_man_org_id.Value.ToString() != "")
        {
            mdl.Organization_Id = new Guid(hf_man_org_id.Value.ToString());
        }
        else
        {
            mdl.Organization_Id = new Guid("00000000-0000-0000-0000-000000000000");
        }
        DataSet ds = TypeClient.Getguarantor(mdl, SessionController.ConnectionString); ;

        cmbWarrantyGurantorPart.DataTextField = "name";
        cmbWarrantyGurantorPart.DataValueField = "ID";
        cmbWarrantyGurantorPart.DataSource = ds;
        cmbWarrantyGurantorPart.DataBind();

        cmbWarrantyGuarantorLabor.DataTextField = "name";
        cmbWarrantyGuarantorLabor.DataValueField = "ID";
        cmbWarrantyGuarantorLabor.DataSource = ds;
        cmbWarrantyGuarantorLabor.DataBind();


    }


    protected void BindDurationUnit()
    {
        try
        {

            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
            DataSet ds = TypeClient.GetDurationunit(SessionController.ConnectionString); ;

            cmbWarrantyDurationUnit.DataTextField = "Name";
            cmbWarrantyDurationUnit.DataValueField = "Id";

            cmbWarrantyDurationUnit.DataSource = ds;
            cmbWarrantyDurationUnit.DataBind();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "BindDurationUnit:-" + ex.Message;
        }

    }
    protected void BindDesigner()
    {
        try
        {

            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
            DataSet ds = TypeClient.GetUniformat(SessionController.ConnectionString);
            cmbDesigner.DataTextField = "Name";
            cmbDesigner.DataValueField = "Id";

            cmbDesigner.DataSource = ds;
            cmbDesigner.DataBind();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Bind Designer:-" + ex.Message;
        }
    }
    protected void BindContractor()
    {
        try
        {

            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();

            DataSet ds = TypeClient.GetMasterformat(SessionController.ConnectionString);
            cmbContractor.DataTextField = "Name";
            cmbContractor.DataValueField = "ID";
            cmbContractor.DataSource = ds;
            cmbContractor.DataBind();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Bind Designer:-" + ex.Message;
        }
    }

    protected void BindUniformat()
    {
        try
        {

            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
            DataSet ds = TypeClient.GetUniformat(SessionController.ConnectionString); ;
            cmbUniFormat.DataTextField = "Name";
            cmbUniFormat.DataValueField = "Id";

            cmbUniFormat.DataSource = ds;
            cmbUniFormat.DataBind();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Bind Uniformat:-" + ex.Message;
        }
    }

    protected void btnselect1_Click(object sender, EventArgs e)
    {
        try
        {
            string facility_ids = hfselectedId.Value.ToString();
            string facility_names = hfselectedname.Value.ToString();


            string[] ids = new string[100];
            ids = facility_ids.Split(',');

            string[] names = new string[100];
            names = facility_names.Split(',');

            DataTable dt = new DataTable("Temp");

            dt.Columns.Add(new DataColumn("facility_id", typeof(string)));
            dt.Columns.Add(new DataColumn("name", typeof(string)));


            for (int i = 0; i <= ids.Length - 1; i++)
            {

                dt.Rows.Add(ids[i].ToString(), names[i].ToString());

            }
            // RgFacilityList.DataSource = dt;
            // RgFacilityList.DataBind();
        }

        catch (Exception ex)
        {

        }
    }


    protected void btnFillGurantorDropdown_Click(object sender, EventArgs e)
    {
        lblmanufacturer.Text = hf_manufaturer_selected_name.Value;

        if (lblmanufacturer.Text != "")
        {
            btnBrowseByManufacturer.Visible = true;
        }
        bind_WarrantyGuarantorParts();
        lblOmniClass.Text = hfOmniClassName.Value.ToString();
    }
    //protected void btnSave_Click(object sender, EventArgs e)
    //{
    //    TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
    //    TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
    //    TypeProfile.TypeModel return_mdl = new TypeProfile.TypeModel();
    //    try
    //    {
    //            StringBuilder strAttribute = new StringBuilder();
    //            strAttribute.Append("<root><folder Name='Model number' Value='" + txtModelNumber.Text.Trim() + "'></folder>");
    //            strAttribute.Append("<folder Name=' Warranty duration parts' Value='" + txtWarrantyDurationPart.Text.Trim() + "'></folder>");
    //            strAttribute.Append("<folder Name=' Warranty duration labor' Value='" + txtWarrantyDurationLabor.Text.Trim() + "'></folder>");
    //            strAttribute.Append("<folder Name='Warranty description' Value='" + txtWarrantyDescription.Text.Trim() + "'></folder>");
    //            strAttribute.Append("<folder Name=' Replacement cost' Value='" + txtReplacementCost.Text.Trim() + "'></folder>");
    //            strAttribute.Append("<folder Name=' Part number' Value='" + txtPartNumber.Text.Trim() + "'></folder>");
    //            //strAttribute.Append("<folder Name=' Expected life' Value='" + txte.Text.Trim() + "'></folder>");

    //            strAttribute.Append("<folder Name='Expected life' Value='" + txtExpectedLife.Text.Trim() + "'></folder></root>");

    //            if (Request.QueryString["type_id"] != "00000000-0000-0000-0000-000000000000")
    //            {
    //                mdl.Type_Id = new Guid(Request.QueryString["type_id"].ToString());
    //            }
    //            else
    //            {
    //                mdl.Type_Id = Guid.Empty;
    //            }

    //           // mdl.Txt_Type_Name = txtName.Text;
    //            mdl.Txt_Description = txtDescription.Text;
    //            if (hf_lblOmniClassid.Value != "")
    //            {
    //                mdl.Fk_Omniclass_Id = new Guid(hf_lblOmniClassid.Value);
    //            }
    //            else
    //            {
    //                mdl.Fk_Omniclass_Id = Guid.Empty;
    //            }

    //            if (hf_man_org_id.Value != "")
    //            {
    //                mdl.Fk_Manufacturer_Id = new Guid(hf_man_org_id.Value);
    //            }
    //            else
    //            {
    //                mdl.Fk_Manufacturer_Id = Guid.Empty;
    //            }
    //            mdl.Fk_Asset_Type_id = new Guid(cmbAssetType.SelectedValue.ToString());
    //            System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
    //            foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmb_facility.Items)
    //            {
    //                if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
    //                {
    //                    facilityvalues.Append(rcbItem.Value);
    //                    facilityvalues.Append(",");
    //                }
    //            }
    //            if (facilityvalues.Length > 0)
    //            {
    //                facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
    //            }

    //            if (mdl.Type_Id == Guid.Empty)
    //            {
    //                fac = facilityvalues.ToString();
    //                mdl.Facility_Ids = facilityvalues.ToString();
    //            }
    //            else
    //            {
    //                mdl.Facility_Ids = facilityvalues.ToString();
    //                mdl.Facility_Ids = hfselectedId.Value.ToString();
    //            }

    //            /* if (mdl.Facility_Ids == "")
    //             {
    //                 hfselectedId.Value = mdl.Facility_Ids;
    //                 ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "ValidateFacility();", true);
    //             }*/


    //            if (cmbWarrantyGurantorPart.SelectedValue == "")
    //            {
    //                mdl.Fk_Warranty_Guarranter_part_id = Guid.Empty;
    //            }
    //            else
    //            {
    //                mdl.Fk_Warranty_Guarranter_part_id = new Guid(cmbWarrantyGurantorPart.SelectedValue.ToString());
    //            }


    //            if (cmbWarrantyGuarantorLabor.SelectedValue == "")
    //            {
    //                mdl.Fk_Warranty_Guarranter_labour_id = Guid.Empty;
    //            }
    //            else
    //            {
    //                mdl.Fk_Warranty_Guarranter_labour_id = new Guid(cmbWarrantyGuarantorLabor.SelectedValue.ToString());
    //            }
    //            mdl.Fk_Warranty_duration_Unit_id = new Guid(cmbWarrantyDurationUnit.SelectedValue.ToString());

    //            if (hfFormatId.Value == "")
    //            {
    //                mdl.Fk_Masterformat_Id = Guid.Empty;
    //            }
    //            else
    //            {
    //                mdl.Fk_Masterformat_Id = new Guid(hfFormatId.Value);
    //            }
    //            if (hfuniformat_id.Value == "")
    //            {
    //                mdl.Fk_Uniformat_id = Guid.Empty;
    //            }
    //            else
    //            {
    //                mdl.Fk_Uniformat_id = new Guid(hfuniformat_id.Value);
    //            }
    //            if (hfDesignerId.Value == "")
    //            {

    //                mdl.DesignerOrContractor_id = Guid.Empty;
    //            }
    //            else
    //            {


    //            }


    //            mdl.Fk_Masterformat_Id = new Guid(cmbMasterFormat.SelectedValue.ToString());
    //            mdl.Fk_Uniformat_id = new Guid(cmbUniFormat.SelectedValue.ToString());
    //            mdl.Facility_Ids = hfselectedId.Value;


    //            mdl.AttributeValue = strAttribute.ToString().Replace("'", "\"");
    //            if (hfProductAssigned.Value == "Y")
    //            {

    //            }


    //            if (mdl.Facility_Ids == "")
    //            {
    //                hfselectedId.Value = mdl.Facility_Ids;
    //                ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "ValidateFacility();", true);
    //            }

    //            else
    //            {

    //                return_mdl = TypeClient.InsertUpdateTypeProfile(mdl, SessionController.ConnectionString);
    //                if (hfContractorId.Value != "")
    //                {
    //                    mdl.DesignerOrContractor_id = new Guid(hfContractorId.Value);
    //                    mdl.Flag = "C";
    //                    mdl.Type_Id = return_mdl.Type_Id;
    //                    TypeClient.UpdateDesignerContractorPM(mdl, SessionController.ConnectionString);
    //                }
    //                if (hfDesignerId.Value != "")
    //                {
    //                    mdl.DesignerOrContractor_id = new Guid(hfDesignerId.Value);
    //                    mdl.Flag = "D";
    //                    mdl.Type_Id = return_mdl.Type_Id;
    //                    TypeClient.UpdateDesignerContractorPM(mdl, SessionController.ConnectionString);
    //                }
    //            }
    //            string error = return_mdl.Error.ToString();
    //            Guid newtype_id = new Guid(return_mdl.Type_Id.ToString());
    //            hf_type_id.Value = newtype_id.ToString();
    //            if (error == "N")
    //            {
    //                str_qry.Value = newtype_id.ToString();
    //                ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);
    //            }
    //            else
    //            {
    //                lblMsg.Text = error.ToString();
    //            }
    //            ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "GoToTypeProfile();", true);

    //        //else
    //        //{
    //        //    btnEdit.Text = "Save";
    //        //    btnCancel.Visible = true;
    //        //}
    //        btnBrowseByManufacturer.Visible = true;
    //        btnAddByModelNumber.Visible = true;
    //        EnableControl();

    //    }
    //    catch (Exception ex)
    //    {
    //        lblMsg.Text = "btnSave_Click:-" + ex.Message;

    //    }

    //}

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Request.QueryString["popupflag"]) == "popup")
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParentpopup();", true);
            else
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);
            hf_page.Value = "typeprofile";
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }


    protected void btnSetProductData_Click(object sender, EventArgs e)
    {
        lblOmniClass.Visible = true;
        lblOmniClass.Text = hfOmniClassName.Value.ToString();
        lblmanufacturer.Visible = true;
        lblmanufacturer.Text = hfManufacturerName.Value.ToString();
        if (lblmanufacturer.Text != "")
        {
            bind_WarrantyGuarantorParts();
            // btnBrowseByManufacturer.Visible = true;
        }
        if (hfAssetTypeId.Value != "")
        {
            cmbAssetType.FindItemByValue(hfAssetTypeId.Value).Selected = true;
        }
        else
        {
            cmbAssetType.ClearSelection();
        }
        if (hfWarrantyDurationUnit.Value != "")
        {
            cmbWarrantyDurationUnit.FindItemByText(hfWarrantyDurationUnit.Value).Selected = true;
        }
        else
        {
            cmbWarrantyDurationUnit.ClearSelection();
        }
        if (hfUniFormatId.Value != "")
        {
            cmbUniFormat.ClearSelection();

        }

        if (hfWarrantyGuarantorLaborId.Value != "")
        {
            cmbWarrantyGuarantorLabor.FindItemByValue(hfWarrantyGuarantorLaborId.Value).Selected = true;
        }
        else
        {
            cmbWarrantyGuarantorLabor.ClearSelection();
        }
        if (hfWarrantyGuarantorPartsId.Value != "")
        {
            cmbWarrantyGurantorPart.FindItemByValue(hfWarrantyGuarantorPartsId.Value).Selected = true;
        }
        else
        {
            cmbWarrantyGurantorPart.ClearSelection();
        }


        //lblmanufacturer.Visible = true;
        //lnkManufacturer.Visible = true;
    }


    //protected void RgFacilityList_OnItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    //{
    //    if (e.CommandName == "facility_Profile")
    //    {

    //        string facility_id;
    //        facility_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["facility_id"].ToString();
    //        // ScriptManager.RegisterStartupScript(this, this.GetType(), "Delete", "NavigateToFacilityProfile(facility_id);", true);
    //        // Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId==" + facility_id.ToString(), false);
    //        string value = "<script language='javascript'>NavigateToFacilityProfile('" + facility_id + "')</script>";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
    //    }


    //}

    //protected void RgFacilityList_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    //{
    //    try
    //    {
    //        TypeId = new Guid(Request.QueryString["type_id"].ToString());
    //        BindFacilityGrid(TypeId);

    //    }
    //    catch (Exception ex)
    //    {

    //        throw ex;
    //    }
    //}

    //protected void RgFacilityList_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
    //{
    //    try
    //    {
    //        TypeId = new Guid(Request.QueryString["type_id"].ToString());
    //        BindFacilityGrid(TypeId);

    //    }
    //    catch (Exception ex)
    //    {

    //        throw ex;
    //    }
    //}


    //protected void RgFacilityList_OnSortCommand(object source, GridSortCommandEventArgs e)
    //{
    //    try
    //    {
    //        TypeId = new Guid(Request.QueryString["type_id"].ToString());
    //        BindFacilityGrid(TypeId);

    //    }
    //    catch (Exception ex)
    //    {

    //        throw ex;
    //    }
    //}


    //protected void btnCancel_click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        if (btnEdit.Text == "Save")
    //        {
    //            //btnCancel.Visible = false;
    //            if (SessionController.Users_.AssetId != Guid.Empty.ToString())
    //            {
    //                Response.Redirect("TypeProfile.aspx?type_id=" + hf_type_id.Value.ToString());
    //            }
    //            else
    //            {
    //                //ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "Navigate();", true);
    //            }


    //        }
    //        //    else if (btnEdit.Text == "Edit")
    //        //        //Response.Redirect("FindAsset.aspx");


    //        //}
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}
    protected void btnassign_click(object sender, EventArgs e)
    {
        if (hfFormatId.Value != "")
        {
            lblMasterFormat.Text = hfformatname.Value.ToString();
        }
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

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {


            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
            TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
            mdl.Type_Id = new Guid(hf_type_id.Value);
            TypeClient.DeleteType(mdl, SessionController.ConnectionString);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "naviagate", "naviagatetoProject();", true);

        }

        catch (Exception ex)
        {
            throw ex;
        }


    }
}