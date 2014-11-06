using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Text;
using System.Data;
using Asset;
//using EcoDomus.AccessRoles;
using System.Threading;
using System.Globalization;
using Login;
using TypeProfile;
using Facility;
using EcoDomus.Common;


public partial class App_Settings_AssetProfile : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            lblNoClones.Visible = false;
            txtNoOfClones.Visible = false;
            btnCreateClones.Visible = false;
            //Added by Priyanka J on 01-06-2012
            LoginClient loginControl = new LoginClient();
            LoginModel loginModel = new LoginModel();


            if (SessionController.Users_.UserLoginDetailId != null)
            {
                loginModel.LoginId = new Guid(SessionController.Users_.UserLoginDetailId);
            }
            else
                loginModel.LoginId = Guid.Empty;

            string user_id = loginControl.GetLoginUserDetail(loginModel);

            //Master.CheckUserLoginDetail();

            //---------------------------------------
            if ((SessionController.Users_.UserId != null) && (user_id != ""))
            {
                if (Convert.ToString(Request.QueryString["popupflag"]) == "popup")
                {
                    hfpopupflag.Value = Convert.ToString(Request.QueryString["popupflag"]);
                    tblheader.Style.Value = ("text-align:left; font-size :large ;margin:2px 0px 2px 2px;");
                    lblpopup.Text = "Component Profile";

                    lblpopup.Visible = true;
                    //divProfilePage.Style.Add("margin-left", "30px");
                    btnclose.Visible = true;

                }
                else
                {
                    lblpopup.Visible = false;
                    btnclose.Visible = false;
                }

                string pagename = GetCurrentPageName();
                if (!IsPostBack)
                {
                    //SystemRoleAccess Systemrole = new SystemRoleAccess();
                    //Systemrole.disableControls(ref btnsave);

                    //Bind dropdown of facility present on notification window:-
                    FacilityModel fm = new FacilityModel();
                    FacilityClient fc = new FacilityClient();
                    DataSet ds_facility = new DataSet();
                    fm.Project_id = new Guid(SessionController.Users_.ProjectId);
                    fm.Search_text_name = "";
                    fm.Doc_flag = "";
                    ds_facility = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);
                    cmbfacility.DataSource = ds_facility;
                    cmbfacility.DataTextField = "name";
                    cmbfacility.DataValueField = "pk_facility_id";
                    cmbfacility.DataBind();

                    //-------------------------------------------------------------

                    if (Request.QueryString["assetid"] != null)
                    {
                        if (Request.QueryString["assetid"].ToString() != "")
                        {

                            if (Request.QueryString["assetid"].ToString() == Guid.Empty.ToString())
                            {
                                hfAssetid.Value = Request.QueryString["assetid"].ToString();
                                EnableControl();
                            }
                            else
                            {
                                hfAssetid.Value = Request.QueryString["assetid"].ToString();
                                DisableControl();
                                Get_AssetProfile(hfAssetid.Value);

                                //Permissions objPermission = new Permissions();
                                //objPermission.SetVisibility(lbldescription, "N");
                                //objPermission.SetVisibility(lbl_Description, "N");

                                BindLocationGrid(hfAssetid.Value);
                                SessionController.Users_.AssetId = hfAssetid.Value;
                            }
                        }
                    }

                    else
                    {
                        SessionController.Users_.AssetId = Guid.Empty.ToString();
                        EnableControl();
                        //rgLocation.Visible = false;

                        if (SessionController.Users_.is_PM_FM == "PM")
                        {

                            BindType_PM();
                        }
                    }
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

    protected void Page_Prerender(object sender, EventArgs e)
     {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                btnClone.Visible = false;
                btndelete.Visible = false;
                btnsave.Visible = false;
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

            //redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
    public string GetCurrentPageName()
    {
        string sPath = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
        System.IO.FileInfo oInfo = new System.IO.FileInfo(sPath);
        string sRet = oInfo.Name;
        return sRet;
    }
    protected void BindType()
    {
        AssetClient obj_assetclient = new AssetClient();
        AssetModel obj_assetmodel = new AssetModel();
        DataSet AssetTypes = new DataSet();
        obj_assetmodel.Fk_facility_id = new Guid(SessionController.Users_.facilityID);
        AssetTypes = obj_assetclient.GetAssetTypes(obj_assetmodel, SessionController.ConnectionString);
        ddltypename.DataSource = AssetTypes;
        ddltypename.DataTextField = "name";
        ddltypename.DataValueField = "type_id";
        ddltypename.DataBind();
    }
    // Bind Location tree and grid
    private void BindLocationGrid(string AssetId)
    {
        try
        {
            string spacename;
            AssetClient obj_assetclient = new AssetClient();
            AssetModel obj_assetmodel = new AssetModel();
            DataSet ds_locations = new DataSet();
            lblspace.Visible = true;
            UCLocation1.Visible = false;
            //rgLocation.Visible = false ;

            obj_assetmodel.Asset_id = new Guid(AssetId);
            ds_locations = obj_assetclient.GetAssetLocations(SessionController.ConnectionString, obj_assetmodel);
            if (ds_locations.Tables[0].Rows.Count > 0)
            {
                //rgLocation.DataSource = ds_locations;
                //rgLocation.DataBind();

                for (int i = 0; i < ds_locations.Tables[0].Rows.Count; i++)
                {
                    lblspace.Text = lblspace.Text + ", " + ds_locations.Tables[0].Rows[i]["linkspace"].ToString();
                }
                if (lblspace.Text[0].ToString().Equals(","))
                {
                    spacename = lblspace.Text;
                    spacename = spacename.Remove(0, 1);  // to remove ',' which is present before first space name
                    lblspace.Text = spacename;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void BindLocationTree(string AssetId)
    {
        try
        {
            AssetClient obj_assetclient = new AssetClient();
            AssetModel obj_assetmodel = new AssetModel();
            DataSet ds_locations = new DataSet();

            //rgLocation.Visible = false;
            lblspace.Visible = false;
            UCLocation1.Visible = true;

            obj_assetmodel.Asset_id = new Guid(AssetId);
            ds_locations = obj_assetclient.GetAssetLocations(SessionController.ConnectionString, obj_assetmodel);

            RadTreeView rtvLocationSpaces = (RadTreeView)UCLocation1.FindControl("rtvLocationSpaces");
            rtvLocationSpaces.ExpandAllNodes();
            if (rtvLocationSpaces != null)
            {
                System.Collections.Generic.IList<RadTreeNode> nodes = rtvLocationSpaces.GetAllNodes();
                foreach (RadTreeNode node in nodes)
                {
                    if (ds_locations.Tables.Count > 0)
                    {
                        for (int i = 0; i < ds_locations.Tables[0].Rows.Count; i++)
                        {
                            if (node.Value.ToUpper() == ds_locations.Tables[0].Rows[i]["locationid"].ToString().ToUpper())
                            {
                                node.Checked = true;
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
        }
    }

    public void Get_AssetProfile(string AssetId)
    {
        try
        {
            Guid Type_Id = Guid.Empty;
            AssetClient obj_assetclient = new AssetClient();
            AssetModel obj_assetmodel = new AssetModel();
            DataSet AssetProfile = new DataSet();
            obj_assetmodel.Asset_id = new Guid(AssetId);

            AssetProfile = obj_assetclient.Get_AssetProfile(obj_assetmodel, SessionController.ConnectionString);
            DataTable dt = new DataTable();
            dt = AssetProfile.Tables[0];
            string warrantystartdate = string.Empty;
            string warrentyEndDate = string.Empty;
            if (AssetProfile.Tables[0].Rows.Count > 0)
            {
                if (AssetProfile.Tables[0].Rows[0] != null)
                {
                    string installationdate;
               
                    //lblname.Text = AssetProfile.Tables[0].Rows[0]["name"].ToString();
                    lbldescription.Text = AssetProfile.Tables[0].Rows[0]["description"].ToString();
                    lblSerialNo.Text = AssetProfile.Tables[0].Rows[0]["SerialNumber"].ToString(); ;
                    lbltagnumber.Text = AssetProfile.Tables[0].Rows[0]["Tagnumber"].ToString(); ;
                    lblbarcode.Text = AssetProfile.Tables[0].Rows[0]["Barcode"].ToString();
                    lblassetidentifier.Text = AssetProfile.Tables[0].Rows[0]["AssetIdentifier"].ToString();
                    installationdate = AssetProfile.Tables[0].Rows[0]["InstallationDate"].ToString();
                    warrantystartdate = AssetProfile.Tables[0].Rows[0]["WarrantyStartDate"].ToString();
                    warrentyEndDate = AssetProfile.Tables[0].Rows[0]["WarrantyEndDate"].ToString();
                    lblAssetIsLinked.Text = HttpContext.GetGlobalResourceObject("Resource", AssetProfile.Tables[0].Rows[0]["AssetIsLinkedInBIM"].ToString()).ToString();

                    if (installationdate != "" && installationdate != null)
                    {
                        lblinstallationdate.Text = installationdate.Substring(0, 8);
                    }
                    if (warrantystartdate != "" && warrantystartdate != null)
                    {
                        lblwarrantystart.Text = warrantystartdate.Substring(0, 8);
                    }

                    if (!string.IsNullOrEmpty(warrentyEndDate))
                    {
                        lblWarrentyEnd.Text = warrentyEndDate.Substring(0, 8);
                    }

                    //lblinstallationdate.Text = AssetProfile.Tables[0].Rows[0]["InstallationDate"].ToString();
                    //lblwarrantystart.Text = AssetProfile.Tables[0].Rows[0]["WarrantyStartDate"].ToString();
                    lbltypename.Text = AssetProfile.Tables[0].Rows[0]["TypeName"].ToString();
                    if (AssetProfile.Tables[0].Rows[0]["fk_type_id"].ToString() != "")
                    {
                        Type_Id = new Guid(AssetProfile.Tables[0].Rows[0]["fk_type_id"].ToString());
                    }
                    lblConditionTypeValue.Text = AssetProfile.Tables[0].Rows[0]["ConditionType"].ToString();
                    // hfFacilityid.Value = AssetProfile.Tables[0].Rows[0]["fk_facility_id"].ToString();
                }
            }
            ViewState["id"] = Type_Id;


            //lblname.Visible = true;
            lbldescription.Visible = true;
            lblSerialNo.Visible = true;
            lbltagnumber.Visible = true;
            lblbarcode.Visible = true;
            lblassetidentifier.Visible = true;
            lblinstallationdate.Visible = true;
            lblwarrantystart.Visible = true;
            lbltypename.Visible = true;
            lblConditionTypeValue.Visible = true;
            // txtassetname.Visible = false;
            txtdescrption.Visible = false;
            txtSerialNo.Visible = false;
            txttagnumber.Visible = false;
            txtbarcode.Visible = false;
            txtassetidentifier.Visible = false;
            rdpinstallationdate.Visible = false;
            rdpwarrantytart.Visible = false;
            ddltypename.Visible = false;

            rcmbConditionType.Visible = false;
            // rdpWarrentyEndDate Added for Task
            rdpWarrentyEndDate.Visible = false;

            //btnsave.Text = "Edit";
            btnsave.Text = (string)GetGlobalResourceObject("Resource", "Edit");



            /*************************Insert into recent Assets******************************************/
            LoginModel dm = new LoginModel();
            LoginClient dc = new LoginClient();
            dm.UserId = new Guid(SessionController.Users_.UserId.ToString());
            dm.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
            dm.entityName = "Asset";
            dm.Row_id = (AssetId.ToString());
            dc.InsertRecentUserData(dm);
            /**********************************************************************************************/

         
           
            //Sumeet

            warranty_date_calculations(Type_Id, warrentyEndDate, warrantystartdate);

            //End Sumeet

         
        }
            catch (Exception ex)
            {
                throw ex;
            }
        }

   

    protected string insert_update_Asset(string facility)
    {
        string AssetId = (Guid.Empty).ToString();
        // string facility = "";
        try
        {
            StringBuilder strAssetAttributes = new StringBuilder();

            strAssetAttributes.Append("<root><folder Name='SerialNumber' Value='" + txtSerialNo.Text.Trim() + "'></folder>");
            strAssetAttributes.Append("<folder Name='Tagnumber' Value='" + txttagnumber.Text.Trim() + "'></folder>");
            if (rdpinstallationdate.SelectedDate != null)
            {
                strAssetAttributes.Append("<folder Name='InstallationDate' Value='" + rdpinstallationdate.SelectedDate.Value.ToShortDateString() + "'></folder>");
            }
            strAssetAttributes.Append("<folder Name='Barcode' Value='" + txtbarcode.Text.Trim() + "'></folder>");
            if (rdpwarrantytart.SelectedDate != null)
            {
                strAssetAttributes.Append("<folder Name='WarrantyStartDate' Value='" + rdpwarrantytart.SelectedDate.Value.ToShortDateString() + "'></folder>");
            }
            strAssetAttributes.Append("<folder Name='AssetIdentifier' Value='" + txtassetidentifier.Text.Trim() + "'></folder>");
            if (lblConditionTypeValue.Text != "--Select--")
            {


                strAssetAttributes.Append("<folder Name='ConditionType' Value='" + rcmbConditionType.SelectedItem.Text.Trim() + "'></folder></root>");
                // rcmbConditionType.Visible = false;
                // lblConditionTypeValue.Text = string.Empty;

            }
            else
            {
                lblConditionTypeValue.Text = string.Empty;
                strAssetAttributes.Append("<folder Name='ConditionType' Value='" + lblConditionTypeValue.Text.Trim() + "'></folder></root>");
            }
            AssetClient obj_assetclient = new AssetClient();
            AssetModel obj_assetmodel = new AssetModel();
            DataSet ds_pk_Asset_id = new DataSet();

            obj_assetmodel.Asset_id = new Guid(SessionController.Users_.AssetId);
            if (SessionController.Users_.is_PM_FM == "FM")
            {
                obj_assetmodel.Fk_facility_id = new Guid(SessionController.Users_.facilityID);
            }
            else if (SessionController.Users_.is_PM_FM == "PM")
            {
                obj_assetmodel.Fk_facility_id = new Guid(facility.ToString());
            }
            obj_assetmodel.Type_id = new Guid(ddltypename.SelectedValue.ToString());
            obj_assetmodel.Uploaded_file_id = Guid.Empty;
            // obj_assetmodel.Name = txtassetname.Text;
            obj_assetmodel.Description = txtdescrption.Text;
            obj_assetmodel.User_id = new Guid(SessionController.Users_.UserId);
            obj_assetmodel.Attribute = strAssetAttributes.ToString().Replace("'", "\"");

            // Assign locations to asset
            RadTreeView rtvlocation = (RadTreeView)UCLocation1.FindControl("rtvLocationSpaces");
            rtvlocation.ExpandAllNodes();
            string locationids = "";
            if (rtvlocation != null)
            {

                System.Collections.Generic.IList<RadTreeNode> locationCollection = rtvlocation.CheckedNodes;

                foreach (RadTreeNode location in locationCollection)
                {
                    if (location.ParentNode.Value != "00000000-0000-0000-0000-000000000000")
                        locationids = locationids + location.Value.ToString() + ",";
                }
                if (locationids.Length > 0)
                    locationids = locationids.Substring(0, locationids.Length - 1);
            }
            obj_assetmodel.Locationids = locationids;
            ds_pk_Asset_id = obj_assetclient.Insert_Update_Asset(obj_assetmodel, SessionController.ConnectionString);
            //AssetId = (Guid.Empty).ToString();
            if (ds_pk_Asset_id.Tables.Count > 0)
            {
                AssetId = ds_pk_Asset_id.Tables[0].Rows[0][0].ToString();
                SessionController.Users_.AssetId = AssetId;
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return AssetId;


    }


    protected void btnsave_Click(object sender, EventArgs e)
    {

        try
        {

            if (hfpopupflag.Value == "popup")
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParentpopup();", true);
            else
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);

            hf_page.Value = "typeprofile";
            ////if (btnsave.Text == "Edit")
            ////{
            //btnsave.Text = "Save";

            //lblname.Visible = false;
            ////lbldescription.Visible = false;
            ////lblSerialNo.Visible = false;
            ////lbltagnumber.Visible = false;
            ////lblbarcode.Visible = false;
            ////lblassetidentifier.Visible = false;
            ////lblinstallationdate.Visible = false;
            ////lblwarrantystart.Visible = false;
            ////lbltypename.Visible = false;
            ////lblConditionTypeValue.Visible = false;

            // txtassetname.Visible = true;
            ////txtdescrption.Visible = true;
            ////txtSerialNo.Visible = true;
            ////txttagnumber.Visible = true;
            ////txtbarcode.Visible = true;
            ////txtassetidentifier.Visible = true;
            ////rdpinstallationdate.Visible = true;
            ////rdpwarrantytart.Visible = true;
            ////ddltypename.Visible = true;
            ////rcmbConditionType.Visible = true;
            //BindType();
            ////BindType_PM();

            ////if (ddltypename.Items.Count > 1 && !string.IsNullOrEmpty(lbltypename.Text))
            ////{
            //if (ddltypename.FindItemByText(lbltypename.Text).ToString() != null)//added now
            ////    ddltypename.FindItemByText(lbltypename.Text).Selected = true;
            ////}

            ////if (lblConditionTypeValue.Text != string.Empty)
            ////{
            //rcmbConditionType.SelectedItem.Text = lblConditionTypeValue.Text;
            // if (rcmbConditionType.FindItemByText(lblConditionTypeValue.Text.ToString()) != null)// added now
            // {
            ////rcmbConditionType.FindItemByText(lblConditionTypeValue.Text.ToString()).Selected = true;
            // }
            ////}




            // txtassetname.Text = lblname.Text;
            ////txtdescrption.Text = lbldescription.Text;
            ////txtSerialNo.Text = lblSerialNo.Text;
            ////txttagnumber.Text = lbltagnumber.Text;
            ////txtbarcode.Text = lblbarcode.Text;
            ////txtassetidentifier.Text = lblassetidentifier.Text;
            ////if (!string.IsNullOrEmpty(lblinstallationdate.Text))
            ////{
            ////    rdpinstallationdate.SelectedDate = Convert.ToDateTime(lblinstallationdate.Text.ToString());
            ////}
            ////if (!string.IsNullOrEmpty(lblwarrantystart.Text))
            ////{
            ////    rdpwarrantytart.SelectedDate = Convert.ToDateTime(lblwarrantystart.Text.ToString());
            ////}

            ////BindLocationTree(SessionController.Users_.AssetId);
            ////}
            ////else //user is saving component.
            ////{
            ////    string facility = "";
            ////    facility = chklocation();

            ////    if (facility != "notification")
            ////    {
            ////        //obj_assetmodel.Fk_facility_id = new Guid(facility.ToString());
            ////        string AssetId = insert_update_Asset(facility);
            ////        SessionController.Users_.AssetId = AssetId;
            ////        //Response.Redirect("AssetMenu.aspx?pagevalue=AssetProfile &assetid=" + AssetId);
            ////        string value = "<script language='javascript'>GotoProfile('" + AssetId + "')</script>";
            ////        Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
            ////        //btnsave.Text = "Edit";
            ////        //Get_AssetProfile(AssetId);
            ////        //BindLocationGrid(AssetId);
            ////    }
            ////}

        }
        catch (Exception ex)
        {
            throw ex;
        }


    }

    protected void btncancel_Click(object sender, EventArgs e)
    {
        try
        {
            if (btnsave.Text == "Save")
            {
                if (SessionController.Users_.AssetId != Guid.Empty.ToString())
                {
                    Response.Redirect("AssetProfile.aspx?assetid=" + SessionController.Users_.AssetId.ToString());
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindAsset", "NavigateToFindAsset();", true);
                }
            }
            //else if (btnsave.Text == "Edit")
            else if (btnsave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))

                //Response.Redirect("FindAsset.aspx");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "FindAsset", "NavigateToFindAsset();", true);

        }
        catch (Exception ex)
        {
        }
    }



    //protected void rgLocation_OnSortCommand(object source, GridSortCommandEventArgs e)
    //{ 
    //    BindLocationGrid(SessionController.Users_.AssetId );
    //}


    public void typelink(object sender, EventArgs e)
    {
        string id = ViewState["id"].ToString();
        string value = "<script language='javascript'>GotoTypeProfile('" + id + "')</script>";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
    }

    protected void BindType_PM()
    {
        TypeProfileClient obj_client = new TypeProfileClient();
        TypeModel obj_model = new TypeModel();
        DataSet ProjectTypes = new DataSet();
        obj_model.Project_id = new Guid(SessionController.Users_.ProjectId);
        obj_model.Flag = "";
        obj_model.Txt_Search = "";
        ProjectTypes = obj_client.bindtypepm(obj_model, SessionController.ConnectionString);
        ddltypename.DataSource = ProjectTypes;
        ddltypename.DataTextField = "name";
        ddltypename.DataValueField = "pk_type_id";
        ddltypename.DataBind();
    }

    protected string chklocation()
    {
        RadTreeView rtvlocation = (RadTreeView)UCLocation1.FindControl("rtvLocationSpaces");
        rtvlocation.ExpandAllNodes();
        string locationids = "";
        string parent = "";
        if (rtvlocation.CheckedNodes.Count != 0) //If at least one node is checked.
        {
            // var InitialParent = "";
            System.Collections.Generic.IList<RadTreeNode> locationCollection = rtvlocation.CheckedNodes;
            var parent1 = rtvlocation.CheckedNodes[0].ParentNode.Value;

            foreach (RadTreeNode location in locationCollection)
            {
                if (location.ParentNode.Value != Guid.Empty.ToString())
                {
                    locationids = locationids + location.Value.ToString() + ",";
                }
                parent = location.ParentNode.Value;

                if (parent != parent1)
                {
                    string value = "<script language='javascript'>alertforsinglefac();</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
                }
                //ViewState["InitialParent"]= parent;
                //if (parent != InitialParent)
                //{
                //    Page.ClientScript.RegisterStartupScript(typeof(Page), "", "<script language=JavaScript>openpopupSelectFacility();</script>"); 

                //}
                //else
                //{
                //    InitialParent = parent;
                //}
            }
            if (locationids.Length > 0)
                locationids = locationids.Substring(0, locationids.Length - 1);


        }
        else
        {
            //open a popup of project facilities for user to select one of them. 

            //string value = "<script language='javascript'>openpopupSelectFacility()</script>";
            // Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);

        }

        if (parent != "")
        {
            return parent;
        }
        else
        {
            return "notification";
        }


    }
    protected void btngetdefaultfacility_Click(object sender, EventArgs e)
    {
        try
        {
            AssetClient objAsset_ctrl = new AssetClient();
            AssetModel objAsset_mdl = new AssetModel();
            DataSet ds_facility = new DataSet();
            objAsset_mdl.row_id = SessionController.Users_.ProjectId;
            // ds_facility = objAsset_ctrl.GetDefault_facility(SessionController.ConnectionString, objAsset_mdl);

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void btndelete_Click(object sender, EventArgs e)
    {


        try
        {
            FacilityClient objfacctrl = new FacilityClient();
            FacilityModel objfacmdl = new FacilityModel();

            objfacmdl.Facility_Ids = hfAssetid.Value.ToString(); //strComponentIds.ToString(); //Variable Facility_Ids from model class is used to pass component ids.
            objfacmdl.Entity = "Component";
            objfacmdl.Facility_Ids.Trim();
            objfacmdl.Facility_Ids.Trim(',');
            objfacctrl.delete_facility_pm(objfacmdl, SessionController.ConnectionString);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ComponentPM", "naviagatetoProject();", true);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnOK_click(object sender, EventArgs e)
    {
        string fac_id = cmbfacility.SelectedValue.ToString();
        if (fac_id == Guid.Empty.ToString())
        {
            string value = "<script language='javascript'>alert('Please select facility from dropdown and then click OK.');</script>";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "script2", value);
        }
        else
        {
            string AssetId = insert_update_Asset(fac_id);
            SessionController.Users_.AssetId = AssetId;
            //Response.Redirect("AssetMenu.aspx?pagevalue=AssetProfile &assetid=" + AssetId);
            string value = "<script language='javascript'>GotoProfile('" + AssetId + "')</script>";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
        }

    }

    protected void DisableControl()
    {

        lbldescription.Visible = false;
        lblSerialNo.Visible = false;
        lbltagnumber.Visible = false;
        lblbarcode.Visible = false;
        lblassetidentifier.Visible = false;
        lblinstallationdate.Visible = false;
        lblwarrantystart.Visible = false;
        lbltypename.Visible = false;
        lblConditionTypeValue.Visible = false;
        lblspace.Visible = false;
        lblLinkedInBIM.Visible = true;
        lblAssetIsLinked.Visible = true;

        //txtassetname.Visible = true;

    }
    protected void EnableControl()
    {
        //txtdescrption.Visible = true;
        //txtSerialNo.Visible = true;
        //txttagnumber.Visible = true;
        //txtbarcode.Visible = true;
        //txtassetidentifier.Visible = true;
        //rdpinstallationdate.Visible = true;
        //rdpwarrantytart.Visible = true;
        //ddltypename.Visible = true;
        //rcmbConditionType.Visible = true;
        lblLinkedInBIM.Visible = false;
        lblAssetIsLinked.Visible = false;
        lbldescription.Visible = true;
        lblSerialNo.Visible = true;
        lbltagnumber.Visible = true;
        lblbarcode.Visible = true;
        lblassetidentifier.Visible = true;
        lblinstallationdate.Visible = true;
        lblwarrantystart.Visible = true;
        lbltypename.Visible = true;

        // txtassetname.Visible = false;
        txtdescrption.Visible = false;
        txtSerialNo.Visible = false;
        txttagnumber.Visible = false;
        txtbarcode.Visible = false;
        txtassetidentifier.Visible = false;
        rdpinstallationdate.Visible = false;
        rdpwarrantytart.Visible = false;
        // rdpWarrentyEndDate Added for Task
        rdpWarrentyEndDate.Visible = false;      
        ddltypename.Visible = false;
        lblConditionTypeValue.Visible = true;
        rcmbConditionType.Visible = false;
        //btnsave.Text = "Edit";
        btnsave.Text = (string)GetGlobalResourceObject("Resource", "Edit");



        /*************************Insert into recent Assets******************************************/
        LoginModel dm = new LoginModel();
        LoginClient dc = new LoginClient();
        dm.UserId = new Guid(SessionController.Users_.UserId.ToString());
        dm.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
        dm.entityName = "Asset";

        dm.Row_id = (hfAssetid.Value);
        dc.InsertRecentUserData(dm);

    }



    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='Component'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Component Profile")
                {
                    // Edit/Delete permission for component
                    SetPermissionToControl(dr_profile);

                    //// permissions for component profile fields
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
        // string view_permission = dr["view_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();
        // delete button on component profile

        if (dr["name"].ToString() == "Component Profile")
        {
            objPermission.SetEditable(btndelete, delete_permission);
            objPermission.SetEditable(btnsave, edit_permission);
            objPermission.SetEditable(btnClone, edit_permission);
        }


    }
    protected void btnClone_Click(object sender, EventArgs e)
    {

        lblNoClones.Visible = true;
        txtNoOfClones.Visible = true;
        btnCreateClones.Visible = true;
        btnsave.Visible = false;
        btndelete.Visible = false;
        btnClone.Visible = false;
        lblLinkedInBIM.Visible = false;
        lblAssetIsLinked.Visible = false;
    }

    protected void btnCreateClones_Click(object sender, EventArgs e)
    {
        try
        {
            AssetClient objAsset_ctrl = new AssetClient();
            AssetModel objAsset_mdl = new AssetModel();
            DataSet ds_clone = new DataSet();
            objAsset_mdl.Asset_id = new Guid(Request.QueryString["assetid"]);
            objAsset_mdl.User_id = new Guid(SessionController.Users_.UserId);
            objAsset_mdl.No_of_clone = Convert.ToInt32(txtNoOfClones.Text);
            ds_clone = objAsset_ctrl.create_clone_component(objAsset_mdl, SessionController.ConnectionString);
            string AssetName = ds_clone.Tables[0].Rows[0]["AssetName"].ToString();
            //  Page.ClientScript.RegisterStartupScript(GetType(), "MyKey", "CloneCreated();", true);
            btnsave.Visible = true;
            btndelete.Visible = true;
            btnClone.Visible = true;
            lblLinkedInBIM.Visible = true;
            lblAssetIsLinked.Visible = true;
            txtNoOfClones.Text = "";
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #region changes by Sumeet
    /// <summary>
    /// Warranty date calculations according to warrenty duration parts on type profile
    /// </summary>
    /// <param name="Type_Id"></param>
    /// <param name="warrantyEnd"></param>
    /// <param name="warrantyStartDate"></param>
    protected void warranty_date_calculations(Guid Type_Id, string warrantyEnd, string warrantyStartDate)
    {
        try
        {
            TypeProfileInfo typeInfoObject = new TypeProfileInfo();
            int durationParts = typeInfoObject.GetDurationParts(Type_Id.ToString());


            if (string.IsNullOrEmpty(warrantyEnd))
            {
                if (!string.IsNullOrEmpty(warrantyStartDate))

                    lblWarrentyEnd.Text = Convert.ToDateTime(warrantyStartDate).AddDays(durationParts).ToString("MM/dd/yy");
            }
        }
        catch (Exception exc)
        {

            throw exc;
        }
    }

    #endregion
}