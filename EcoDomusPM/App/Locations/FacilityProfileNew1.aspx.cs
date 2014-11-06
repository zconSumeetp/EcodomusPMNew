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
//--------
using System.Data.OleDb;
using System.IO;
using System.Xml;
using System.Net;
using System.Text;

public partial class App_Reports_FacilityProfileNew1 : System.Web.UI.Page
{
     
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null && SessionController.Users_.UserId != string.Empty)
        {
           if(!IsPostBack)
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
                        BindHierarchyRelation();
                    }
                }
                else
                {
                    try
                    {
                        //BindDocuments();
                        lnkEditLocation.Visible = true;
                        btnEdit.Visible = false;
                        //btnAddDocument.Visible = true;
                        btnGetLatitudeLongitude.Visible = true;
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
                        hfFacility_id.Value = SessionController.Users_.facilityID;
                        //hfFacility_id.Value =  Request.QueryString["FacilityId"].ToString();
                        if (!IsPostBack)
                        {
                            EnableDisable("D");
                            BindFacilityProfile();
                            BindTemplate();
                            GridSortExpression sortExpr = new GridSortExpression();
                            sortExpr.FieldName = "document_name";
                            sortExpr.SortOrder = GridSortOrder.Ascending;
                            //Add sort expression, which will sort against first column
                            //rgDocuments.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                            //BindDocuments();
                            //string nw = "<script language='javascript'>top.window.document.getElementById('ctl00_ContentPlaceHolder1_rmSettingsMenu').style.display = 'inline';</script>";
                            //Page.ClientScript.RegisterStartupScript(this.GetType(), "scriptOrgId", nw);
                        }
                        BindHierarchyRelation();
                    }
                }
                else
                {
                    try
                    {
                        //BindDocuments();
                        lnkEditLocation.Visible = true;
                        btnEdit.Visible = false;
                        //btnAddDocument.Visible = true;
                        btnGetLatitudeLongitude.Visible = true;
                        SessionController.Users_.facilityID = Guid.Empty.ToString();
                        BindTemplate();
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
            Response.Redirect("~\\app\\Loginpm.aspx?Error=Session");
        }

    }



    protected void BindHierarchyRelation()
    {
        try
        {

            DataSet ds;
            int lvl_count = 0;
            int i, j;
            FacilityClient facObjClientCtrl = new FacilityClient();
            FacilityModel facObjFacilityModel = new FacilityModel();
            facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
            ds = facObjClientCtrl.Get_hierarchy_for_facility_profile(facObjFacilityModel, SessionController.ConnectionString);

            if (ds.Tables[0].Rows.Count > 0)
            {
                lvl_count = ds.Tables[0].Rows.Count;
            }

            tblHierarchy.Rows.Clear();
            for (i = 0; i < lvl_count; i++)
            {
                TableRow tr = new TableRow();
                for (j = 1; j <= 2; j++)
                {
                    TableCell td = new TableCell();
                    switch (j)
                    {
                        case 1:
                            td.Text = ds.Tables[0].Rows[i]["hierarchy_name"].ToString() + ":";
                            break;
                        case 2:
                            td.Text = ds.Tables[0].Rows[i]["hierarchy_data_Name"].ToString() + "";
                            break;
                        default:
                            break;
                    }
                    tr.Controls.Add(td);
                }

                tblHierarchy.Controls.Add(tr);
            }




        }
        catch (Exception ex)
        {

            lblMsg.Text = ex.Message.ToString();
        }
    }

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
            Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
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
            //btnAddDocument.Visible = false;
            btnGetLatitudeLongitude.Visible = false;

            btnsave.Visible = false;
            //btnsave.Text = "Edit";
            lbl_attribute_template.Visible = true;
            cmb_template.Visible = false;

        }

        else
        {
            lbl_attribute_template.Visible = false;
            cmb_template.Visible = true;


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

            btnsave.Visible = true;
            btnEdit.Visible = false;

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

    protected void BindFacilityProfile()
    {
        DataSet ds = new DataSet();
        FacilityClient facObjClientCtrl = new FacilityClient();
        FacilityModel facObjFacilityModel = new FacilityModel();
        facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
        //facObjFacilityModel.Facility_id = new Guid(hfFacility_id.Value);
        ds = facObjClientCtrl.proc_get_facility_data(facObjFacilityModel, SessionController.ConnectionString);

        if (ds.Tables[0].Rows.Count > 0)
        {
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
            lblcategories.Text = ds.Tables[0].Rows[0]["category_name"].ToString();
            hf_lblOmniClassid.Value = ds.Tables[0].Rows[0]["omniclass_id"].ToString();
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

            txtZipPostal.Text = ds.Tables[0].Rows[0]["zip_postal_code"].ToString();
            txtLatitude.Text = ds.Tables[0].Rows[0]["latitude"].ToString();
            txtLongitude.Text = ds.Tables[0].Rows[0]["longitude"].ToString();

            lbl_attribute_template.Text = ds.Tables[0].Rows[0]["att_name"].ToString();
            cmb_template.SelectedValue = ds.Tables[0].Rows[0]["pk_attribute_template_id"].ToString();




            /*added*/
            hf_facility_name.Value = ds.Tables[0].Rows[0]["name"].ToString();
            SessionController.Users_.facilityName = hf_facility_name.Value;
            /*added*/



            btnEdit.Visible = true;


            /*************************Insert into recent facility******************************************/
            if (SessionController.Users_.UserSystemRole != "SA")
            {
                LoginModel dm = new LoginModel();
                LoginClient dc = new LoginClient();
                dm.UserId = new Guid(SessionController.Users_.UserId.ToString());
                dm.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
                dm.entityName = "Facility";
                dm.Row_id = (SessionController.Users_.facilityID.ToString());
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

            //facObjFacilityModel.FacilityName = SessionController.Users_.facilityName; earlier
            facObjFacilityModel.Address1 = txtAddress1.Text;
            facObjFacilityModel.Address2 = txtAddress2.Text;
            facObjFacilityModel.Zip_Postal = txtZipPostal.Text;

            facObjFacilityModel.latitude = txtLatitude.Text;
            facObjFacilityModel.longitude = txtLongitude.Text;

            facObjFacilityModel.Description = txtDescription.Text;
            facObjFacilityModel.SiteName = txtSiteName.Text;
            facObjFacilityModel.User_Id = new Guid(SessionController.Users_.UserId.ToString());

            if (cmb_template.SelectedValue == Guid.Empty.ToString())
            {
            }

            else
            {

            }

            facObjClientCtrl.Insert_Update_Facility_Profile(facObjFacilityModel, SessionController.ConnectionString);

            BindFacilityProfile();
            //BindDocuments();

            EnableDisable("D");
            btnCancel.Visible = false;
            lnkEditLocation.Visible = false;
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
                facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
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
            facObjFacilityModel.Address1 = txtAddress1.Text;
            facObjFacilityModel.Address2 = txtAddress2.Text;
            facObjFacilityModel.Zip_Postal = txtZipPostal.Text;

            facObjFacilityModel.latitude = txtLatitude.Text;
            facObjFacilityModel.longitude = txtLongitude.Text;

            facObjFacilityModel.Description = txtDescription.Text;
            facObjFacilityModel.SiteName = txtSiteName.Text;
            facObjFacilityModel.User_Id = new Guid(SessionController.Users_.UserId.ToString());

            if (cmb_template.SelectedValue == Guid.Empty.ToString())
            {
                facObjFacilityModel.Attribute_Template_id = Guid.Empty;
            }
            else
            {
                facObjFacilityModel.Attribute_Template_id = new Guid(cmb_template.SelectedValue.ToString());
            }
            ds = facObjClientCtrl.InsertUpdateFacilityPM(facObjFacilityModel, SessionController.ConnectionString);

            hfFacility_id.Value = ds.Tables[0].Rows[0]["facility_id"].ToString();

            SessionController.Users_.facilityID = hfFacility_id.Value.ToString();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "GoToFacilityProfile();", true);
            // Response.Redirect("../Locations/FacilityMenu.aspx?FacilityId=" + hfFacility_id.Value);

            //BindFacilityProfile();            
            //EnableDisable("D");
            //btnCancel.Visible = false;
            //lnkEditLocation.Visible = false;
            //rgDocuments.Columns[2].Visible = false;

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
        btnGetLatitudeLongitude.Visible = true;
        lnkEditLocation.Visible = true;
    }

    protected void btn_refresh_Click(object sender, EventArgs e)
    {
        //BindDocuments();
        BindHierarchyRelation();

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {

        EnableDisable("D");
        BindFacilityProfile();


        //BindDocuments();

        btnCancel.Visible = false;

        //rgDocuments.Columns[2].Visible = false;
        lnkEditLocation.Visible = false;
    }


    protected void BindTemplate()
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        DataSet ds = new DataSet();
        try
        {
            fm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
            ds = fc.BindTemplateForFacility(fm, SessionController.ConnectionString);
            cmb_template.DataTextField = "template_name";
            cmb_template.DataValueField = "pk_required_attribute_template_id";
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
        fc.delete_facility_pm(fm ,SessionController.ConnectionString);

        ScriptManager.RegisterStartupScript(this, this.GetType(), "FacilityPM", "NavigateToFacilityPM();", true);
    
    }
}