using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Facility;
using Locations;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;
using Dashboard;
using Login;
using User;
//--------
using System.Data.OleDb;
using System.IO;
using System.Xml;
using System.Net;
using System.Text;
using AttributeTemplate;
using TypeProfile;

public partial class App_Locations_FacilityProfile : System.Web.UI.Page
{
    string template_id = "";
    string Master_flag = "";
    string UniClass_flag = "";
    string UniFormat_flag = "";
    string OmniClass_flag = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (SessionController.Users_.UserId != null && SessionController.Users_.UserId != string.Empty)
        {

            if (Request.QueryString["popupflag"] == "popup")
            {
                hfpopupflag.Value = "popup";
             //lblpoupmsg.Text = "Space Profile";
                tblHeader.Style.Value = "dispaly:inline;text-align:left; font-size :large ;margin:2px 0px 2px 2px;";
                lblfacilityProfile.Visible = true;
                //divProfilePage.Style.Add("margin-left", "30px");
                //  divProfilePage.Style.Add("margin-bottom", "30px");
                btnclose.Visible = true;

            }
            else
            {
                btnclose.Visible = false;
            }

            if (!IsPostBack)
            {

                if (SessionController.Users_.is_PM_FM == "FM")
                {
                    if (Request.QueryString["FacilityId"] != null)
                    {
                        if (Request.QueryString["FacilityId"] != Guid.Empty.ToString())
                        {
                            hfFacility_id.Value = SessionController.Users_.facilityID;
                            if (!IsPostBack)
                            {
                                EnableDisable("D");
                                BindFacilityProfile();


                                GridSortExpression sortExpr = new GridSortExpression();
                                sortExpr.FieldName = "document_name";
                                sortExpr.SortOrder = GridSortOrder.Ascending;
                                //Add sort expression, which will sort against first column
                                //rgDocuments.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                                //BindDocuments();
                                // BindLocationHierarchy();
                                //string nw = "<script language='javascript'>top.window.document.getElementById('ctl00_ContentPlaceHolder1_rmSettingsMenu').style.display = 'inline';</script>";
                                //Page.ClientScript.RegisterStartupScript(this.GetType(), "scriptOrgId", nw);

                            }
                            //BindHierarchyRelation();
                        }
                    }
                    else
                    {
                        try
                        {
                            //BindDocuments();
                            //lnkEditLocation.Visible = true;
                            btnEdit.Visible = false;
                            //btnAddDocument.Visible = true;
                            // btnGetLatitudeLongitude.Visible = true;
                            SessionController.Users_.facilityID = Guid.Empty.ToString();
                        }
                        catch (Exception)
                        {

                            throw;
                        }
                    }
                }
                else if (SessionController.Users_.is_PM_FM == "PM")
                {
                    if (Request.QueryString["FacilityId"] != null)
                    {
                        if (Request.QueryString["FacilityId"] != Guid.Empty.ToString())
                        {
                            // hfFacility_id.Value = SessionController.Users_.facilityID;
                            hfFacility_id.Value = Request.QueryString["FacilityId"].ToString();
                            if (!IsPostBack)
                            {
                                bindCountry();
                                BindState();
                                EnableDisable("E");
                                BindTemplate();
                                BindFacilityProfile();

                                GridSortExpression sortExpr = new GridSortExpression();
                                sortExpr.FieldName = "document_name";
                                sortExpr.SortOrder = GridSortOrder.Ascending;
                                //Add sort expression, which will sort against first column
                                //rgDocuments.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                                //BindDocuments();
                                //string nw = "<script language='javascript'>top.window.document.getElementById('ctl00_ContentPlaceHolder1_rmSettingsMenu').style.display = 'inline';</script>";
                                //Page.ClientScript.RegisterStartupScript(this.GetType(), "scriptOrgId", nw);
                                //lnkEditLocation.Visible = true;
                            }
                            //BindHierarchyRelation();
                        }
                    }
                    else
                    {
                        try
                        {
                            //BindDocuments();
                            bindCountry();
                            lblProjectName.Visible = true;
                            lblProjectName.Text = SessionController.Users_.ProjectName;
                            dvcreatedon.Visible = false;
                            //lnkEditLocation.Visible = true;
                            btnEdit.Visible = false;
                            btnDelete.Visible = false;
                            btnCancel.Visible = true;
                            //btnAddDocument.Visible = true;
                            //btnGetLatitudeLongitude.Visible = true;
                            SessionController.Users_.facilityID = Guid.Empty.ToString();
                            BindTemplate();
                            string OrganizationId = "";

                            Project.ProjectModel pm = new Project.ProjectModel();
                            Project.ProjectClient pc = new Project.ProjectClient();
                            pm.Project_id = new Guid(SessionController.Users_.ProjectId);
                            SessionController.Users_.ProjectId = pm.Project_id.ToString();
                            DataSet ds = pc.GetProjectDataById(pm, SessionController.ConnectionString);
                            if (ds.Tables.Count > 0)
                            {
                                if (ds.Tables[0].Rows.Count > 0)
                                {
                                    OrganizationId = ds.Tables[0].Rows[0]["fk_owner_organization_id"].ToString();
                                }
                            }

                            string SelectedState = "";
                            if (!OrganizationId.Equals(""))
                            {
                                ds = new DataSet();
                                Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
                                Organization.OrganizationModel mdl = new Organization.OrganizationModel();

                                mdl.Organization_Id = new Guid(OrganizationId);
                                ds = obj_ctrl.GetOranizationInformation(mdl);
                                if (ds.Tables.Count > 0)
                                {
                                    if (ds.Tables[0].Rows.Count > 0)
                                    {
                                        txtAddress1.Text = ds.Tables[0].Rows[0]["Address_1"].ToString();
                                        txtAddress2.Text = ds.Tables[0].Rows[0]["Address_2"].ToString();
                                        txtZipPostal.Text = ds.Tables[0].Rows[0]["postalCode"].ToString();
                                        txtCity.Text = ds.Tables[0].Rows[0]["city_name"].ToString();
                                        cmbCountry.SelectedValue = ds.Tables[0].Rows[0]["countryId"].ToString();
                                        SelectedState = ds.Tables[0].Rows[0]["stateId"].ToString();
                                    }
                                }
                            }

                            BindState();
                            if (!SelectedState.Equals(""))
                            {
                                cmbState.SelectedValue = SelectedState;
                            }                           

                        }
                        catch (Exception)
                        {

                            throw;
                        }
                    }
                }
            }
        }
        else
        {
            //  Response.Redirect("~\\app\\Loginpm.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }
    protected void Page_Prerender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "GU" || SessionController.Users_.UserSystemRole == "PA" || SessionController.Users_.UserSystemRole == "CBU")
        {
            td_template.Visible = false;
            td_template1.Visible = false;

        }

    }


    //protected void BindHierarchyRelation()
    //{
    //    try
    //    {

    //        DataSet ds;
    //        int lvl_count = 0;
    //        int i, j;
    //        FacilityClient facObjClientCtrl = new FacilityClient();
    //        FacilityModel facObjFacilityModel = new FacilityModel();
    //        facObjFacilityModel.Facility_id = new Guid(hfFacility_id.Value);// new Guid(SessionController.Users_.facilityID);
    //        ds = facObjClientCtrl.Get_hierarchy_for_facility_profile(facObjFacilityModel, SessionController.ConnectionString);

    //        if (ds.Tables[0].Rows.Count > 0)
    //        {
    //            lvl_count = ds.Tables[0].Rows.Count;
    //        }

    //        // tblHierarchy.Rows.Clear();
    //        for (i = 0; i < lvl_count; i++)
    //        {
    //            TableRow tr = new TableRow();
    //            for (j = 1; j <= 2; j++)
    //            {
    //                TableCell td = new TableCell();
    //                td.Style.Add("width", "30%");
    //                switch (j)
    //                {
    //                    case 1:
    //                        td.Text = ds.Tables[0].Rows[i]["hierarchy_name"].ToString() + ":";
    //                        break;
    //                    case 2:
    //                        td.Text = ds.Tables[0].Rows[i]["hierarchy_data_Name"].ToString() + "";
    //                        break;
    //                    default:
    //                        break;
    //                }
    //                tr.Controls.Add(td);
    //            }

    //            // tblHierarchy.Controls.Add(tr);
    //        }




    //    }
    //    catch (Exception ex)
    //    {

    //        lblMsg.Text = ex.Message.ToString();
    //    }
    //}

    #region comment

    //protected void BindLocationHierarchy()
    //{

    //    try
    //    {

    //        DataSet ds;
    //        int lvl_count = 0;
    //        FacilityClient facObjClientCtrl = new FacilityClient();
    //        FacilityModel facObjFacilityModel = new FacilityModel();
    //        facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
    //        ds = facObjClientCtrl.Get_heirarchy_structure_for_facility(facObjFacilityModel, SessionController.ConnectionString);
    //        if (ds.Tables[0].Rows.Count > 0)
    //        {
    //            lvl_count = ds.Tables[0].Rows.Count;
    //        }


    //        for (int i = 0; i < lvl_count; i++)
    //        {
    //            TableRow tr = new TableRow();
    //            tr = (TableRow)aspTblHierarchy.FindControl("level" + i);
    //            tr.Visible = true;


    //            TableCell tc = new TableCell();
    //            tc = (TableCell)aspTblHierarchy.FindControl("tc_level" + i + "_hierarchy_name");
    //            tc.Text = ds.Tables[0].Rows[i]["hierarchy_name"].ToString();

    //            DataSet ds_ddl_data = new DataSet();

    //            if (ds.Tables[0].Rows[i]["custom_flag"].ToString() == "N")
    //            {


    //                FacilityClient facClient = new FacilityClient();
    //                FacilityModel facModel = new FacilityModel();
    //                facModel.TableName = ds.Tables[0].Rows[i]["db_table_name"].ToString();
    //                facModel.ConditionValue = "N";
    //                facModel.Facility_id = new Guid(SessionController.Users_.facilityID);
    //                facModel.Pk_Hierarchy_Table_Id = new Guid(ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString());
    //                ds_ddl_data = facClient.Get_Hierarchy_Dropdown_Data(facModel, SessionController.ConnectionString);




    //            }
    //            else
    //            {
    //                FacilityClient facClient = new FacilityClient();
    //                FacilityModel facModel = new FacilityModel();
    //                facModel.TableName = ds.Tables[0].Rows[i]["db_table_name"].ToString();
    //                facModel.ConditionValue = "Y";
    //                facModel.Pk_Hierarchy_Table_Id =new Guid(ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString());
    //                facModel.Facility_id = new Guid(SessionController.Users_.facilityID);
    //                facModel.Facility_id = new Guid(SessionController.Users_.facilityID);



    //                ds_ddl_data = facClient.Get_Hierarchy_Dropdown_Data(facModel, SessionController.ConnectionString);


    //            }


    //            RadComboBox ddl = new RadComboBox();
    //            ddl = (RadComboBox)aspTblHierarchy.FindControl("rcblevel" + i);
    //            ddl.Width = 185;
    //            ddl.Height = 100;
    //            //ddl.Filter = Contains; 
    //            ddl.DataSource = ds_ddl_data;
    //            ddl.DataTextField = ds.Tables[0].Rows[i]["db_col_name"].ToString();
    //            ddl.DataValueField = ds.Tables[0].Rows[i]["db_col_id"].ToString();
    //            ddl.DataBind();









    //        }

    //        BindHierarchyDropdowns(ds);




    //    }
    //    catch (Exception ex)
    //    {
    //        lblMsg.Text = ex.Message.ToString(); 

    //    }


    //}


    //protected void BindHierarchyDropdowns(DataSet ds)
    //{
    //    try
    //    {


    //    }
    //    catch (Exception ex)
    //    {

    //         lblMsg.Text = ex.Message.ToString(); 
    //    }
    //}

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
            //Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }

    //protected void rgDocuments_SortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    //{
    //    try
    //    {
    //        BindDocuments();
    //    }
    //    catch (Exception ex)
    //    {

    //        lblMsg.Text = ex.Message.ToString();
    //    }

    //}

    //protected void rgDocuments_PageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    //{
    //    try
    //    {
    //        BindDocuments();
    //    }
    //    catch (Exception ex)
    //    {

    //        lblMsg.Text = ex.Message.ToString();
    //    }

    //}

    //protected void rgDocuments_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    //{


    //    try
    //    {
    //        BindDocuments();

    //    }
    //    catch (Exception ex)
    //    {

    //        lblMsg.Text = ex.Message.ToString();
    //    }

    //}

    protected void EnableDisable(string flag)
    {
        if (flag == "D")
        {
            txtDescription.Visible = false;
            //txtExtSysFacility.Visible = false;
            //txtExtSysSite.Visible = false;
            txtfacilityname.Visible = false;
            // txtOrganization.Visible = false;
            txtSiteName.Visible = false;
            lblcategories.Visible = true;
            lblDescription.Visible = true;
            //lblExtSysFacility.Visible = true;
            //lblExtSysSite.Visible = true;
            lblfacilityname.Visible = true;
            //lblMsg.Visible = true;
            //     lblOrganization.Visible = true;
            lblsitename.Visible = true;
            lnkCategories.Visible = false;
            txtAddress1.Visible = false;
            txtAddress2.Visible = false;
            lblAddress1.Visible = true;
            lblAddress2.Visible = true;
            txtZipPostal.Visible = false;
            txtLatitude.Visible = false;
            txtLongitude.Visible = false;
            lblZipPostal.Visible = true;
            lblLatitude.Visible = true;
            lblLongitude.Visible = true;

            txtCurrency_Units.Visible = false;
            lblCurrency_Units.Visible = true;
            txtArea_Units.Visible = false;
            lblArea_Units.Visible = true;
            txtLinear_Units.Visible = false;
            lblLinear_Units.Visible = true;
            txtVolume_Units.Visible = false;
            lblVolume_Units.Visible = true;

            //btnAddDocument.Visible = false;
            // btnGetLatitudeLongitude.Visible = false;

            btnsave.Visible = false;
            btnEdit.Visible = true;
            btnDelete.Visible = true;
            //lbl_attribute_template.Visible = true;
            // cmb_template.Visible = false;
            //rduploadimage.Visible = true;


            //--on-23-07-12----
            txtCity.Visible = false;
            lblCity.Visible = true;
            txtAreaMeasurement.Visible = false;
            lblAreaMeasurement.Visible = true;
            lblCreatedOn.Visible = true;
            lblProjectName.Visible = true;
            cmbState.Visible = false;
            cmbCountry.Visible = false;
            lblState.Visible = true;
            lblCountry.Visible = true;
            //-----------------

        }

        else
        {
            //lbl_attribute_template.Visible = false;
            // //cmb_template.Visible = true;


            txtDescription.Visible = true;
            //txtExtSysFacility.Visible = true;
            //txtExtSysSite.Visible = true;

            txtfacilityname.Visible = true;
            //txtOrganization.Visible = true;
            txtSiteName.Visible = true;
            lblcategories.Visible = true;
            lblDescription.Visible = false;
            //lblExtSysFacility.Visible = false;
            //lblExtSysSite.Visible = false;
            lblfacilityname.Visible = false;
            //lblMsg.Visible = true;
            // lblOrganization.Visible = false;
            lblsitename.Visible = false;
            lnkCategories.Visible = true;
            txtAddress1.Visible = true;
            txtAddress2.Visible = true;
            lblAddress1.Visible = false;
            lblAddress2.Visible = false;
            txtZipPostal.Visible = true;
            txtLatitude.Visible = true;
            txtLongitude.Visible = true;
            lblZipPostal.Visible = false;
            lblLatitude.Visible = false;
            lblLongitude.Visible = false;

            txtCurrency_Units.Visible = true;
            lblCurrency_Units.Visible = false;
            txtArea_Units.Visible = true;
            lblArea_Units.Visible = false;
            txtLinear_Units.Visible = true;
            lblLinear_Units.Visible = false;
            txtVolume_Units.Visible = true;
            lblVolume_Units.Visible = false;

            btnsave.Visible = true;
            btnEdit.Visible = false;
            btnCancel.Visible = true;
            btnDelete.Visible = false;
            //rduploadimage.Visible = true;

            //--on-23-07-12----
            txtCity.Visible = true;
            lblCity.Visible = false;
            txtAreaMeasurement.Visible = true;
            lblAreaMeasurement.Visible = false;
            dvcreatedon.Visible = false;
            lblProjectName.Visible = true;
            cmbState.Visible = true;
            cmbCountry.Visible = true;
            lblState.Visible = false;
            lblCountry.Visible = false;
            //-----------------
        }

    }

    //protected void BindDocuments()
    //{
    //    try
    //    {
    //        if (SessionController.Users_.is_PM_FM == "FM")
    //        {

    //            DataSet ds = new DataSet();
    //            FacilityClient facObjClientCtrl = new FacilityClient();
    //            FacilityModel facObjFacilityModel = new FacilityModel();
    //            if (SessionController.Users_.facilityID != null)
    //            {
    //                facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
    //            }
    //            else
    //            {
    //                facObjFacilityModel.Facility_id = Guid.Empty;
    //            }
    //            ds = facObjClientCtrl.GetFacilityDocuments(facObjFacilityModel, SessionController.ConnectionString);
    //            //rgDocuments.DataSource = ds;
    //            //rgDocuments.DataBind();
    //        }
    //        else
    //        {
    //            if (SessionController.Users_.facilityID != null)
    //            {
    //                DataSet ds = new DataSet();
    //                FacilityClient facObjClientCtrl = new FacilityClient();
    //                FacilityModel facObjFacilityModel = new FacilityModel();
    //                facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
    //                ds = facObjClientCtrl.GetFacilityDocuments(facObjFacilityModel, SessionController.ConnectionString);
    //                //rgDocuments.DataSource = ds;
    //                //rgDocuments.DataBind();
    //            }
    //            else
    //            {
    //                DataSet ds = new DataSet();
    //                FacilityClient facObjClientCtrl = new FacilityClient();
    //                FacilityModel facObjFacilityModel = new FacilityModel();
    //                facObjFacilityModel.Facility_id = Guid.Empty;
    //                ds = facObjClientCtrl.GetFacilityDocuments(facObjFacilityModel, SessionController.ConnectionString);
    //                //rgDocuments.DataSource = ds;
    //                //rgDocuments.DataBind();
    //            }

    //        }

    //    }
    //    catch (Exception ex)
    //    {

    //        lblMsg.Text = ex.Message.ToString();
    //    }


    //}
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
  
    protected void BindFacilityProfile()
    {
        show_hide_standards();
        DataSet ds = new DataSet();
        FacilityClient facObjClientCtrl = new FacilityClient();
        FacilityModel facObjFacilityModel = new FacilityModel();
        facObjFacilityModel.Facility_id = new Guid(hfFacility_id.Value);
        //facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
        //facObjFacilityModel.Facility_id = new Guid(hfFacility_id.Value);
        ds = facObjClientCtrl.proc_get_facility_data(facObjFacilityModel, SessionController.ConnectionString);

        if (ds.Tables[0].Rows.Count > 0)
        {
            string city;
            string pincode;
            txtAddress1.Text = ds.Tables[0].Rows[0]["address_1"].ToString();
            lblAddress1.Text = ds.Tables[0].Rows[0]["address_1"].ToString();
            txtAddress2.Text = ds.Tables[0].Rows[0]["address_2"].ToString();
            lblAddress2.Text = ds.Tables[0].Rows[0]["address_2"].ToString();

            txtDescription.Text = ds.Tables[0].Rows[0]["description"].ToString();

            //txtExtSysFacility.Text = ds.Tables[0].Rows[0]["ext_facility"].ToString();
            //txtExtSysSite.Text = ds.Tables[0].Rows[0]["ext_site"].ToString();
            txtfacilityname.Text = ds.Tables[0].Rows[0]["name"].ToString();
            //txtOrganization.Text = ds.Tables[0].Rows[0][""].ToString();
            txtSiteName.Text = ds.Tables[0].Rows[0]["site_name"].ToString();
            if (hf_uniclass.Value != "")
            {
                if (hf_uniclass.Value == "Y")
                {
                    lblcategories.Text = ds.Tables[0].Rows[0]["category_name_uniclass"].ToString();
                    hf_uniclass_id.Value = ds.Tables[0].Rows[0]["uniclass_id"].ToString();
                }
                else
                {
                    lblcategories.Text = ds.Tables[0].Rows[0]["category_name"].ToString();
                    hf_lblOmniClassid.Value = ds.Tables[0].Rows[0]["omniclass_id"].ToString();
                }
            }
        
            
            lblDescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
            //lblExtSysFacility.Text = ds.Tables[0].Rows[0]["ext_facility"].ToString();
            //lblExtSysSite.Text = ds.Tables[0].Rows[0]["ext_site"].ToString();
            lblfacilityname.Text = ds.Tables[0].Rows[0]["name"].ToString();
            //lblMsg.Visible = true;
            //  lblOrganization.Text = ds.Tables[0].Rows[0][""].ToString();
            lblsitename.Text = ds.Tables[0].Rows[0]["site_name"].ToString();


            lblZipPostal.Text = ds.Tables[0].Rows[0]["zip_postal_code"].ToString();
            lblLongitude.Text = ds.Tables[0].Rows[0]["longitude"].ToString();
            lblLatitude.Text = ds.Tables[0].Rows[0]["latitude"].ToString();
            pincode = ds.Tables[0].Rows[0]["zip_postal_code"].ToString();
            if (pincode == "N/A")
            {
                txtZipPostal.Text = "";
            }
            else
            {
                txtZipPostal.Text = ds.Tables[0].Rows[0]["zip_postal_code"].ToString();
            }
            //txtZipPostal.Text = ds.Tables[0].Rows[0]["zip_postal_code"].ToString();
            txtLatitude.Text = ds.Tables[0].Rows[0]["latitude"].ToString();
            txtLongitude.Text = ds.Tables[0].Rows[0]["longitude"].ToString();

            //lbl_attribute_template.Text = ds.Tables[0].Rows[0]["att_name"].ToString();
            // cmb_template.SelectedValue = ds.Tables[0].Rows[0]["pk_attribute_template_id"].ToString();
            //lblimagename.Text = ds.Tables[0].Rows[0]["image_path"].ToString();
            //lblimagename.Visible = false;

            // rduploadimage.OnClientAdding= lblimagename.Text;
            //  rduploadimage.
            // rduploadimage.UploadedFiles[0].Equals(ds.Tables[0].Rows[0]["image_path"].ToString());

            //----on-23-07-2012----------------------------------------------
            lblCreatedOn.Text = ds.Tables[0].Rows[0]["created_on"].ToString();
            lblProjectName.Text = ds.Tables[0].Rows[0]["Project_name"].ToString();
            lblAreaMeasurement.Text = ds.Tables[0].Rows[0]["area_measurement"].ToString();
            lblCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
            lblState.Text = ds.Tables[0].Rows[0]["state_name"].ToString();
            lblCountry.Text = ds.Tables[0].Rows[0]["country_name"].ToString();
            cmbCountry.SelectedValue = ds.Tables[0].Rows[0]["country_id"].ToString();
            BindState();
            cmbState.SelectedValue = ds.Tables[0].Rows[0]["pk_state_id"].ToString();
            txtAreaMeasurement.Text = ds.Tables[0].Rows[0]["area_measurement"].ToString();

            lblCurrency_Units.Text = ds.Tables[0].Rows[0]["currency_units"].ToString();
            txtCurrency_Units.Text = ds.Tables[0].Rows[0]["currency_units"].ToString();
            lblLinear_Units.Text = ds.Tables[0].Rows[0]["linear_units"].ToString();
            txtLinear_Units.Text = ds.Tables[0].Rows[0]["linear_units"].ToString();
            lblArea_Units.Text = ds.Tables[0].Rows[0]["area_units"].ToString();
            txtArea_Units.Text = ds.Tables[0].Rows[0]["area_units"].ToString();
            lblVolume_Units.Text = ds.Tables[0].Rows[0]["volume_units"].ToString();
            txtVolume_Units.Text = ds.Tables[0].Rows[0]["volume_units"].ToString();


            city = ds.Tables[0].Rows[0]["City"].ToString();
            if (city == "N/A")
            {
                txtCity.Text = "";
            }
            else
            {
                txtCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
            }
            // txtCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
            cmbState.SelectedValue = ds.Tables[0].Rows[0]["pk_state_id"].ToString();
            cmbCountry.SelectedValue = ds.Tables[0].Rows[0]["country_id"].ToString();

            //---------------------------------------------------------------

            //--Modified by ganesh------//
            string template_name = "";
            if ((ds.Tables[1].Rows[0]["templates_name"].ToString()).Length > 0)
            {

                foreach (DataRow dr in ds.Tables[2].Rows)
                {
                    template_name = template_name + dr["template_name"].ToString() + ",";
                }
                if (template_name.Length > 0)
                {
                    template_name = template_name.Remove(template_name.ToString().Length - 1, 1);
                }


                foreach (DataRow dr in ds.Tables[2].Rows)
                {
                    template_id = template_id + dr["pk_attribute_template_id"].ToString() + ",";
                }
                if (template_id.Length > 0)
                {
                    template_id = template_id.Remove(template_id.ToString().Length - 1, 1);
                }
                cmb_template.SelectedValue = template_id.ToString();

                string[] val = template_name.Split(',');
                List<string> listTemplateNames = new List<string>(val);
                //cmb_template.SelectedValue = lblFacility.Text;
                for (int j = 0; j < cmb_template.Items.Count; j++)
                {
                    foreach (string temp in listTemplateNames)
                    {
                        if (cmb_template.Items[j].Text == temp)
                        {
                            CheckBox checkbox = (CheckBox)cmb_template.Items[j].FindControl("chk_template");
                            checkbox.Checked = true;
                        }
                    }
                }
                cmb_template.Text = template_name;


            }
            //----End---------------//

            /*added*/
            hf_facility_name.Value = ds.Tables[0].Rows[0]["name"].ToString();
            SessionController.Users_.facilityName = hf_facility_name.Value;
            /*added*/



            //btnEdit.Visible = true;


            /*************************Insert into recent facility******************************************/
            if (SessionController.Users_.UserSystemRole != "SA")
            {
                LoginModel dm = new LoginModel();
                LoginClient dc = new LoginClient();
                dm.UserId = new Guid(SessionController.Users_.UserId.ToString());
                dm.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
                dm.entityName = "Facility";
                dm.Row_id = hfFacility_id.Value.ToString(); //(SessionController.Users_.facilityID.ToString());
                dc.InsertRecentUserData(dm);
            }
            /**********************************************************************************************/

        }

    }

    protected void rgDocument_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            Guid document_id = Guid.Empty;
            if (e.CommandName == "deleteProduct")
            {
                document_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["document_id"].ToString());

                FacilityClient facObjClientCtrl = new FacilityClient();
                FacilityModel facObjFacilityModel = new FacilityModel();
                facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
                facObjFacilityModel.Document_Id = document_id;
                facObjClientCtrl.Delete_Document(facObjFacilityModel, SessionController.ConnectionString);
                //BindDocuments();
            }


        }
        catch (Exception ex)
        {
            lblMsg.Text = "rgDocument_ItemCommand:-" + ex.Message;
        }
    }


    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (SessionController.Users_.is_PM_FM == "FM")
                {
                    FacilityClient facObjClientCtrl = new FacilityClient();
                    FacilityModel facObjFacilityModel = new FacilityModel();
                    if (SessionController.Users_.facilityID == Guid.Empty.ToString())
                    {
                        facObjFacilityModel.Facility_id = Guid.Empty;
                        facObjFacilityModel.FacilityName = txtfacilityname.Text.Trim();
                    }
                    else
                    {
                        facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
                        // facObjFacilityModel.FacilityName = SessionController.Users_.facilityName;
                        facObjFacilityModel.FacilityName = txtfacilityname.Text.ToString();
                    }

                    if (hf_lblOmniClassid.Value == "")
                    {
                        facObjFacilityModel.Fk_Omniclass_Id = Guid.Empty;
                    }
                    else
                    {
                        facObjFacilityModel.Fk_Omniclass_Id = new Guid(hf_lblOmniClassid.Value.ToString());
                    }
                    //xxx
                    //if (hf_uniclass_id.Value == "")
                    //{
                    //    facObjFacilityModel.Fk_uniclass_id = Guid.Empty;
                    //}
                    //else
                    //{
                    //    facObjFacilityModel.Fk_uniclass_id = new Guid(hf_uniclass_id.Value);
                    //}
                    facObjFacilityModel.FacilityName = SessionController.Users_.facilityName; 
                    facObjFacilityModel.Address1 = txtAddress1.Text;
                    facObjFacilityModel.Address2 = txtAddress2.Text;
                    facObjFacilityModel.Zip_Postal = txtZipPostal.Text;

                    facObjFacilityModel.latitude = txtLatitude.Text;
                    facObjFacilityModel.longitude = txtLongitude.Text;

                    facObjFacilityModel.Description = txtDescription.Text;
                    facObjFacilityModel.SiteName = txtSiteName.Text;
                    facObjFacilityModel.User_Id = new Guid(SessionController.Users_.UserId.ToString());

                    //if (cmb_template.SelectedValue == Guid.Empty.ToString())
                    //{
                    //}

                    //else
                    //{

                    //}


                    facObjClientCtrl.Insert_Update_Facility_Profile(facObjFacilityModel, SessionController.ConnectionString);

                    BindFacilityProfile();
                    //BindDocuments();

                    EnableDisable("D");
                    btnCancel.Visible = false;
                    //lnkEditLocation.Visible = false;
                    //rgDocuments.Columns[2].Visible = false;
                }

                else if (SessionController.Users_.is_PM_FM == "PM")
                {
                    FacilityClient facObjClientCtrl = new FacilityClient();
                    FacilityModel facObjFacilityModel = new FacilityModel();
                    DataSet ds = new DataSet();
                    facObjFacilityModel.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                    if (SessionController.Users_.facilityID == Guid.Empty.ToString())
                    {
                        facObjFacilityModel.Facility_id = Guid.Empty;
                    }
                    else
                    {
                        facObjFacilityModel.Facility_id = new Guid(hfFacility_id.Value); //new Guid(SessionController.Users_.facilityID);
                    }

                    facObjFacilityModel.FacilityName = txtfacilityname.Text.Trim();

                    SessionController.Users_.facilityName = facObjFacilityModel.FacilityName.ToString();

                    if (hf_lblOmniClassid.Value == "")
                    {
                        facObjFacilityModel.Fk_Omniclass_Id = Guid.Empty;
                    }
                    else
                    {
                        facObjFacilityModel.Fk_Omniclass_Id = new Guid(hf_lblOmniClassid.Value.ToString());
                    }
                    if (hf_uniclass_id.Value == "")
                    {
                        facObjFacilityModel.Fk_uniclass_id = Guid.Empty;
                    }
                    else
                    {
                        facObjFacilityModel.Fk_uniclass_id = new Guid(hf_uniclass_id.Value);
                    }
                    facObjFacilityModel.Address1 = txtAddress1.Text;
                    facObjFacilityModel.Address2 = txtAddress2.Text;
                    //----------------on-23-07-12-------------------------------------
                    facObjFacilityModel.City = txtCity.Text;
                    facObjFacilityModel.Fk_state_id = new Guid(cmbState.SelectedValue);
                    facObjFacilityModel.Fk_country_id = new Guid(cmbCountry.SelectedValue);
                    facObjFacilityModel.Areameasurement = txtAreaMeasurement.Text;
                    facObjFacilityModel.Created_on = DateTime.Now;
                    facObjFacilityModel.Project_name = SessionController.Users_.ProjectName;
                    //---------------------------------------------------------------

                    facObjFacilityModel.Zip_Postal = txtZipPostal.Text;
                    facObjFacilityModel.latitude = txtLatitude.Text;
                    facObjFacilityModel.longitude = txtLongitude.Text;

                    facObjFacilityModel.Description = txtDescription.Text;
                    facObjFacilityModel.SiteName = txtSiteName.Text;
                    facObjFacilityModel.Currency_Units = txtCurrency_Units.Text;
                    facObjFacilityModel.Linear_Units = txtLinear_Units.Text;
                    facObjFacilityModel.Area_Units = txtArea_Units.Text;
                    facObjFacilityModel.Volume_Units = txtVolume_Units.Text;
                    facObjFacilityModel.User_Id = new Guid(SessionController.Users_.UserId.ToString());

                    //if (cmb_template.SelectedValue == Guid.Empty.ToString())
                    //{
                    //    facObjFacilityModel.Attribute_Template_id = Guid.Empty;
                    //}
                    //else
                    //{
                    //    facObjFacilityModel.Attribute_Template_id = new Guid(cmb_template.SelectedValue.ToString());
                    //}

                    //---------------Added by Ganesh -----------//

                    System.Text.StringBuilder temaplte_ids = new System.Text.StringBuilder();
                    foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmb_template.Items)
                    {
                        if (((CheckBox)rcbItem.FindControl("chk_template")).Checked)
                        {
                            temaplte_ids.Append(rcbItem.Value);
                            temaplte_ids.Append(",");
                        }
                    }
                    if (temaplte_ids.Length > 0)
                    {
                        temaplte_ids = temaplte_ids.Remove(temaplte_ids.ToString().Length - 1, 1);
                        template_id = temaplte_ids.ToString();
                    }



                    //-----------End---------------------//
                    //if (DocumentUpload().ToString() == "")
                    //{
                    //    facObjFacilityModel.Image_name = lblimagename.Text;

                    //}
                    //else
                    //{
                    //    facObjFacilityModel.Image_name = DocumentUpload();
                    //}

                    ds = facObjClientCtrl.InsertUpdateFacilityPM(facObjFacilityModel, SessionController.ConnectionString);

                    hfFacility_id.Value = ds.Tables[0].Rows[0]["facility_id"].ToString();
                    if (template_id != "")
                    {
                        UpdateFacility_Template_Linkup(template_id);
                    }


                    SessionController.Users_.facilityID = hfFacility_id.Value.ToString();
                    if (hfpopupflag.Value == "popup")
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "GoToFacilityProfilepopup();", true);
                    else
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "GoToFacilityProfile();", true);
                    // Response.Redirect("../Locations/FacilityMenu.aspx?FacilityId=" + hfFacility_id.Value);

                    //BindFacilityProfile();            
                    //EnableDisable("D");
                    //btnCancel.Visible = false;
                    //lnkEditLocation.Visible = false;
                    //rgDocuments.Columns[2].Visible = false;

                }
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

    protected void UpdateFacility_Template_Linkup(string temp_ids)
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            DataSet ds = new DataSet();
            am.Attribute_template_ids = temp_ids;
            am.Facility_Id = new Guid(hfFacility_id.Value.ToString());
            ac.UpdateFaciltiyAttributeTemplateLinkup(am, SessionController.ConnectionString);


        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void btnedit_Click(object sender, EventArgs e)
    {
        //rgDocuments.Columns[2].Visible = true;
        //BindDocuments();
        EnableDisable("E");
        btnsave.Visible = true;
        btnCancel.Visible = true;
        //btnAddDocument.Visible = true;
        // btnGetLatitudeLongitude.Visible = true;
        //lnkEditLocation.Visible = true;

    }

    protected void btn_refresh_Click(object sender, EventArgs e)
    {
        //BindDocuments();
        //BindHierarchyRelation();

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //BindDocuments();
        //rgDocuments.Columns[2].Visible = false;
        //  if(hfpopupflag.Value=="popup")

        if (hfFacility_id.Value == "")
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "FacilityPM", "NavigateToFacilityPM();", true);
        }
        else
        {
            if (hfpopupflag.Value == "popup")
                ScriptManager.RegisterStartupScript(this, this.GetType(), "FacilityPM", "GoToFacilityProfilepopup();", true);
            else
                ScriptManager.RegisterStartupScript(this, this.GetType(), "FacilityPM", "GoToFacilityProfile();", true);
        }
        //EnableDisable("D");
        //BindFacilityProfile();
        //btnCancel.Visible = false;
        //lnkEditLocation.Visible = false;
    }
    //public string DocumentUpload()
    //{
    //    string strFacilityId = "";
    //    if (hfFacility_id.Value != "")
    //        strFacilityId = hfFacility_id.Value.ToString(); //.Users_.facilityID.ToString();
    //    else
    //        strFacilityId = SessionController.Users_.facilityID.ToString();


    //    string strDirExists = string.Empty;
    //    string filename = "";
    //    string filepath = string.Empty;
    //    try
    //    {
    //        strDirExists = Server.MapPath("~/App/Files/Documents/" + strFacilityId);
    //        DirectoryInfo de = new DirectoryInfo(strDirExists);
    //        if (!de.Exists)
    //        {
    //            de.Create();

    //        }
    //        if (rduploadimage.UploadedFiles.Count > 0)                         // document upload
    //        {

    //            foreach (UploadedFile file in rduploadimage.UploadedFiles)
    //            {
    //                filename = file.GetName();
    //                filename = filename.Replace("&", "_");
    //                filename = filename.Replace("#", "_");
    //                filename = filename.Replace("%", "_");
    //                filename = filename.Replace("*", "_");
    //                filename = filename.Replace("{", "_");
    //                filename = filename.Replace("}", "_");
    //                filename = filename.Replace("\\", "_");
    //                filename = filename.Replace(":", "_");
    //                filename = filename.Replace("<", "_");
    //                filename = filename.Replace(">", "_");
    //                filename = filename.Replace("?", "_");
    //                filename = filename.Replace("/", "_");
    //                filepath = Path.Combine(Server.MapPath("~/App/Files/Documents/" + strFacilityId), filename);
    //                hfAttachedFile.Value = "~/App/Files/Documents/" + strFacilityId + "/" + filename;
    //                file.SaveAs(filepath, true);

    //            }
    //        }
    //        else                                                    // document upload
    //        {
    //            //filename = hfFilename.Value.ToString();
    //            //hfAttachedFile.Value = hfFilePath.Value.ToString();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //    return filename;

    //}

    protected void BindTemplate()
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        DataSet ds = new DataSet();
        try
        {
            fm.Project_id= new Guid(SessionController.Users_.ProjectId);
            fm.OrganizationId = new Guid(SessionController.Users_.OrganizationID.ToString());
            ds = fc.BindTemplateForFacility(fm, SessionController.ConnectionString);
            cmb_template.DataTextField = "template_name";
            cmb_template.DataValueField = "pk_attribute_template_id";
            cmb_template.DataSource = ds;
            cmb_template.DataBind();

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();

        //fm.Entity = "Facility";
        // ds = fc.proc_get_entity_id(fm, SessionController.ConnectionString);
        //string entity_id = ds.Tables[0].Rows[0]["pk_entity_id"].ToString();

        fm.Facility_Ids = hfFacility_id.Value.ToString();
        fm.Entity = "Facility";
        fc.delete_facility_pm(fm, SessionController.ConnectionString);

        ScriptManager.RegisterStartupScript(this, this.GetType(), "FacilityPM", "NavigateToFacilityPM();", true);

    }

    protected void BindState()
    {
        DataSet ds = new DataSet();
        try
        {
            UserClient ctrl = new UserClient();
            UserModel mdl = new UserModel();
            mdl.CountryId = new Guid(cmbCountry.SelectedValue);
            ds = ctrl.bindState(mdl);
            cmbState.DataValueField = "state_id";
            cmbState.DataTextField = "name";
            cmbState.DataSource = ds;
            cmbState.DataBind();

            //size of dropdown
            int cmb_size = 250;
            cmb_size = cmb_size < (cmbState.Items.Count) * 18 ? cmb_size : (cmbState.Items.Count) * 18;
            cmbState.Height = 100;
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void bindCountry()
    {
        DataSet ds = new DataSet();
        try
        {
            UserClient ctrl = new UserClient();
            UserModel mdl = new UserModel();
            ds = ctrl.GetCountry();
            cmbCountry.DataValueField = "Id";
            cmbCountry.DataTextField = "Name";
            cmbCountry.DataSource = ds;
            cmbCountry.DataBind();
            cmbCountry.SelectedItem.Text = "USA";

            //size of dropdown
            int cmb_size = 250;
            cmb_size = cmb_size < (cmbCountry.Items.Count) * 18 ? cmb_size : (cmbCountry.Items.Count) * 18;
            cmbCountry.Height = 100;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void cmbCountry_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        BindState();
    }
    protected void cmbtemplate_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        try
        {
            ((CheckBox)e.Item.FindControl("chk_template")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}