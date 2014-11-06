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
using System.Text.RegularExpressions;
using EcoDomus.Common;


public partial class App_Settings_AssetProfile : System.Web.UI.Page
{
    int component_space = 0;
    string fac_id = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (SessionController.Users_.UserId != null)
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
                    if (Request.QueryString["assetid"].ToString() == Guid.Empty.ToString() && Request.QueryString["value"].ToString() != "asset" && Request.QueryString["value"].ToString() != "blank")
                    {
                        hfAssetid.Value = Request.QueryString["assetid"].ToString();
                        hfTypeId.Value = Request.QueryString["value"].ToString();
                        //BindType_PM();
                        EnableControl();
                    }


                    else if (Request.QueryString["assetid"] != null && Request.QueryString["value"].ToString() == "asset")
                    {

                        hfAssetid.Value = Request.QueryString["assetid"].ToString();
                        EnableControl();
                        //DisableControl();
                        //BindType_PM();
                        Get_AssetProfile(hfAssetid.Value);
                        //if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                        //{
                        //    {
                        //        SetPermissions();
                        //    }
                        //}


                        SessionController.Users_.AssetId = hfAssetid.Value;

                    }
                    else if (Request.QueryString["assetid"].ToString() == Guid.Empty.ToString() && Request.QueryString["value"].ToString() == "blank")
                    {
                        hfAssetid.Value = Request.QueryString["assetid"].ToString();
                        //BindType_PM();
                        EnableControl();
                    }


                    else
                    {
                        SessionController.Users_.AssetId = Guid.Empty.ToString();
                        DisableControl();
                        //rgLocation.Visible = false;
                        if (SessionController.Users_.is_PM_FM == "PM")
                        {
                            BindType_PM();
                        }
                        Get_AssetProfile(hfAssetid.Value);

                    }



                    //else
                    //{

                    //    hfAssetid.Value = Guid.Empty.ToString();
                    //    EnableControl();
                    //}



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

    //private void SetPermissions()
    //{ 
    //    try
    //    {
    //        DataSet ds_component = SessionController.Users_.Permission_ds;
    //        DataRow dr_component = ds_component.Tables[0].Select("name='Component'")[0];
    //        DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
    //        foreach (DataRow dr_profile in dr_submenu_component)
    //        {
    //            if (dr_profile["name"].ToString() == "Component Profile")
    //            {

    //                DataRow[] dr_fields_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_profile["pk_project_role_controls"] + "'");
    //                foreach (DataRow dr in dr_fields_component)
    //                {
    //                    SetPermissionToControl(dr);
    //                }

    //            }
    //        }


    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    //private void SetPermissionToControl(DataRow dr)
    //{
    //    Permissions objPermission = new Permissions();
    //    string view_permission = dr["view_permission"].ToString();
    //    string edit_permission = dr["edit_permission"].ToString();
    //    switch (dr["Control_id"].ToString())
    //    {
    //        case "txtassetname":
    //            objPermission.SetVisibility(txtassetname, view_permission);
    //            objPermission.SetEditable(txtassetname, edit_permission);
    //            break;
    //        case "txtdescrption":
    //            objPermission.SetVisibility(txtdescrption, view_permission);
    //            objPermission.SetEditable(txtdescrption, edit_permission);
    //            break;
    //        case "txtSerialNo":
    //            objPermission.SetVisibility(txtSerialNo, view_permission);
    //            objPermission.SetEditable(txtSerialNo, edit_permission);
    //            break;
    //        case "txtbarcode":
    //            objPermission.SetVisibility(txtbarcode, view_permission);
    //            objPermission.SetEditable(txtbarcode, edit_permission);
    //            break;
    //        case "txtassetidentifier":
    //            objPermission.SetVisibility(txtassetidentifier, view_permission);
    //            objPermission.SetEditable(txtassetidentifier, edit_permission);
    //            break;
    //        case "txttagnumber":
    //            objPermission.SetVisibility(txttagnumber, view_permission);
    //            objPermission.SetEditable(txttagnumber, edit_permission);
    //            break;

    //        case "rcmbConditionType":
    //            objPermission.SetEditable(rcmbConditionType, edit_permission);
    //            break;

    //        case "rdpwarrantytart":
    //            objPermission.SetEditable(rdpwarrantytart, edit_permission);
    //            break;

    //        case "rdpinstallationdate":
    //            objPermission.SetEditable(rdpinstallationdate, edit_permission);
    //            break;
    //        default :
    //            break;
    //    }
    //} 



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

            UCLocation1.Visible = false;
            //rgLocation.Visible = false ;
            lblspace.Visible = true;
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
    protected void page_prerender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindLocationTree(hfAssetid.Value);

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
            //#########
            //UserControl.UserControlClient objUserControlClient = new UserControl.UserControlClient();
            //UserControl.UserControlModel objUserControlModel = new UserControl.UserControlModel();
            //objUserControlModel.UserId = new Guid(SessionController.Users_.ProjectId);
            //DataSet ds = new DataSet();
            //ds = objUserControlClient.GetSpacesforProject(objUserControlModel, SessionController.ConnectionString);
            //if (ds.Tables.Count > 0)
            //{
            //    if (ds.Tables[0].Rows.Count > 0)
            //    {
            //        rtvLocationSpaces.DataTextField = "Name";
            //        rtvLocationSpaces.DataValueField = "Id";

            //        rtvLocationSpaces.DataFieldParentID = "ParentId";
            //        rtvLocationSpaces.DataFieldID = "Id";

            //        rtvLocationSpaces.DataSource = ds;
            //        rtvLocationSpaces.DataBind();
            //        rtvLocationSpaces.ExpandAllNodes();

            //    }

            //}


            rtvLocationSpaces.CollapseAllNodes();

            System.Collections.Generic.IList<RadTreeNode> nodes = rtvLocationSpaces.GetAllNodes();

            foreach (RadTreeNode node in nodes)
            {
                if (Request.QueryString["value"] != null)
                {
                    if (node.Value.ToUpper() == Request.QueryString["value"].ToString().ToUpper())
                    {
                        node.Checked = true;
                    }
                }
                if (ds_locations.Tables.Count > 0)
                {
                    if (ds_locations.Tables[0].Rows.Count > 0)
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

                if (node.Level == 0 || node.Level == 1)
                {
                    node.Checkable = false;
                }
                else
                {
                    node.Checkable = true;
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

            if (AssetProfile.Tables[0].Rows.Count > 0)
            {
                if (AssetProfile.Tables[0].Rows[0] != null)
                {
                    txtassetname.Text = AssetProfile.Tables[0].Rows[0]["name"].ToString();
                    txtdescrption.Text = AssetProfile.Tables[0].Rows[0]["description"].ToString();
                    txtSerialNo.Text = AssetProfile.Tables[0].Rows[0]["SerialNumber"].ToString(); ;
                    txttagnumber.Text = AssetProfile.Tables[0].Rows[0]["Tagnumber"].ToString(); ;
                    txtbarcode.Text = AssetProfile.Tables[0].Rows[0]["Barcode"].ToString();
                    txtassetidentifier.Text = AssetProfile.Tables[0].Rows[0]["AssetIdentifier"].ToString();
                    if (!string.IsNullOrEmpty(AssetProfile.Tables[0].Rows[0]["InstallationDate"].ToString()))
                        rdpinstallationdate.SelectedDate = Convert.ToDateTime(AssetProfile.Tables[0].Rows[0]["InstallationDate"].ToString());
                    if (!string.IsNullOrEmpty(AssetProfile.Tables[0].Rows[0]["WarrantyStartDate"].ToString()))
                        rdpwarrantytart.SelectedDate = Convert.ToDateTime(AssetProfile.Tables[0].Rows[0]["WarrantyStartDate"].ToString());


                    //ddltypename.SelectedItem.Text = AssetProfile.Tables[0].Rows[0]["TypeName"].ToString();
                    if (AssetProfile.Tables[0].Rows[0]["fk_type_id"].ToString() != "")
                    {
                        Type_Id = new Guid(AssetProfile.Tables[0].Rows[0]["fk_type_id"].ToString());
                    }
                    ddltypename.SelectedValue = Type_Id.ToString();
                    if (AssetProfile.Tables[0].Rows[0]["ConditionType"].ToString() == "")
                    {
                        rcmbConditionType.SelectedItem.Text = "--Select--";// AssetProfile.Tables[0].Rows[0]["ConditionType"].ToString();
                    }
                    else
                    {
                        rcmbConditionType.SelectedItem.Text = AssetProfile.Tables[0].Rows[0]["ConditionType"].ToString();
                    }


                    hfFacilityid.Value = AssetProfile.Tables[0].Rows[0]["fk_facility_id"].ToString();

                    //Sumeet
                    string  warrantyEnd = AssetProfile.Tables[0].Rows[0]["WarrantyEndDate"].ToString();
                    warranty_date_calculations(Type_Id, warrantyEnd);
                    //End Sumeet
                }
            }
            ViewState["id"] = Type_Id;


            //lblname.Visible = true;
            //lbldescription.Visible = true;
            //lblSerialNo.Visible = true;
            //lbltagnumber.Visible = true;
            //lblbarcode.Visible = true;
            //lblassetidentifier.Visible = true;
            //lblinstallationdate.Visible = true;
            //lblwarrantystart.Visible = true;
            //lbltypename.Visible = true;

            //txtassetname.Visible = false;
            //txtdescrption.Visible = false;
            //txtSerialNo.Visible = false;
            //txttagnumber.Visible = false;
            //txtbarcode.Visible = false;
            //txtassetidentifier.Visible = false;
            //rdpinstallationdate.Visible = false;
            //rdpwarrantytart.Visible = false;
            //ddltypename.Visible = false;
            //lblConditionTypeValue.Visible = true;
            //rcmbConditionType.Visible = false;
            //btnsave.Text = "Edit";


            /*************************Insert into recent Assets******************************************/
            LoginModel dm = new LoginModel();
            LoginClient dc = new LoginClient();
            dm.UserId = new Guid(SessionController.Users_.UserId.ToString());
            dm.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
            dm.entityName = "Asset";
            dm.Row_id = (AssetId.ToString());
            dc.InsertRecentUserData(dm);
            /**********************************************************************************************/

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

 
    protected string insert_update_Asset(string facility)
    {
        // string AssetId = (Guid.Empty).ToString();
        string AssetId = hfAssetid.Value;
        // string facility = "";
        try
        {
            string pattren = "&";
            StringBuilder strAssetAttributes = new StringBuilder();
            strAssetAttributes.Append("<root><folder Name='SerialNumber' Value='" + GetXMLValue(Regex.Replace(txtSerialNo.Text.Trim(), pattren, "&amp;", RegexOptions.IgnoreCase)) + "'></folder>");
            strAssetAttributes.Append("<folder Name='Tagnumber' Value='" + GetXMLValue(Regex.Replace(txttagnumber.Text.Trim(), pattren, "&amp;", RegexOptions.IgnoreCase)) + "'></folder>");
            if (rdpinstallationdate.SelectedDate != null)
            {
                rdpinstallationdate.DateInput.Text.ToString();

                strAssetAttributes.Append("<folder Name='InstallationDate' Value='" + rdpinstallationdate.SelectedDate.Value.ToString("s") + "'></folder>");
            }
            else
            {
                strAssetAttributes.Append("<folder Name='InstallationDate' Value=''></folder>");
            }
            strAssetAttributes.Append("<folder Name='Barcode' Value='" + GetXMLValue(Regex.Replace(txtbarcode.Text.Trim(), pattren, "&amp;", RegexOptions.IgnoreCase)) + "'></folder>");
            if (rdpwarrantytart.SelectedDate != null)
            {

                strAssetAttributes.Append("<folder Name='Warranty Start Date' Value='" + rdpwarrantytart.SelectedDate.Value.ToString("s") + "'></folder>");
            }
            else
            {
                strAssetAttributes.Append("<folder Name='Warranty Start Date' Value=''></folder>");

            }

            //Sumeet


            if (rdpWarrentyEndDate.SelectedDate != null)
            {

                strAssetAttributes.Append("<folder Name='Warranty End Date' Value='" + rdpWarrentyEndDate.SelectedDate.Value.ToString("s") + "'></folder>");
            }
            else
            {
                strAssetAttributes.Append("<folder Name='Warranty End Date' Value=''></folder>");

            }


            //End Sumeet



            strAssetAttributes.Append("<folder Name='AssetIdentifier' Value='" + GetXMLValue(Regex.Replace(txtassetidentifier.Text.Trim(), pattren, "&amp;", RegexOptions.IgnoreCase)) + "'></folder>");
            if (rcmbConditionType.SelectedItem.Text != "--Select--")
            {


                strAssetAttributes.Append("<folder Name='ConditionType' Value='" + GetXMLValue(rcmbConditionType.SelectedItem.Text.Trim()) + "'></folder></root>");
                // rcmbConditionType.Visible = false;
                // lblConditionTypeValue.Text = string.Empty;

            }
            else
            {
                lblConditionTypeValue.Text = string.Empty;
                strAssetAttributes.Append("<folder Name='ConditionType' Value='" + GetXMLValue(lblConditionTypeValue.Text.Trim()) + "'></folder></root>");
            }
            AssetClient obj_assetclient = new AssetClient();
            AssetModel obj_assetmodel = new AssetModel();
            DataSet ds_pk_Asset_id = new DataSet();

            // obj_assetmodel.Asset_id = new Guid(SessionController.Users_.AssetId);


            obj_assetmodel.Fk_facility_id = new Guid(facility.ToString());

            obj_assetmodel.Type_id = new Guid(ddltypename.SelectedValue.ToString());
            obj_assetmodel.Uploaded_file_id = Guid.Empty;
            obj_assetmodel.Name = txtassetname.Text;
            obj_assetmodel.Description = txtdescrption.Text;
            obj_assetmodel.User_id = new Guid(SessionController.Users_.UserId);
            obj_assetmodel.Attribute = strAssetAttributes.ToString().Replace("\'", " \"");
            //obj_assetmodel.Attribute = obj_assetmodel.Attribute.ToString().
            obj_assetmodel.Asset_id = new Guid(hfAssetid.Value);

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
                hfAssetid.Value = AssetId;
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return AssetId;


    }

    public string GetXMLValue(string pInputValue)
    {
        try
        {
            if (pInputValue == null) return null;

            //pInputValue = pInputValue.Replace("&", "&amp;");
            pInputValue = pInputValue.Replace("'", "&apos;");
            pInputValue = pInputValue.Replace("\"", "&quot;");
            pInputValue = pInputValue.Replace("(", "&lpar;");
            pInputValue = pInputValue.Replace(")", "&rpar;");
            pInputValue = pInputValue.Replace("-", "&#45;");
            // pInputValue = pInputValue.Replace("/", "&sol;");
            pInputValue = pInputValue.Replace(":", "&colon;");
            pInputValue = pInputValue.Replace("<", "&lt;");
            pInputValue = pInputValue.Replace(">", "&gt;");
            pInputValue = pInputValue.Replace("=", "&equals;");
            //pInputValue = pInputValue.Replace("&", "&amp;");
            return pInputValue;
        }
        catch (Exception)
        {
        }
        return null;
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {

        try
        {
            if (SessionController.Users_.UserId != null)
            {
                //if (btnsave.Text == "Edit")
                if (btnsave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
                {
                    //btnsave.Text = "Save";
                    btnsave.Text = (string)GetGlobalResourceObject("Resource", "Save");


                    lblname.Visible = false;
                    lbldescription.Visible = false;
                    lblSerialNo.Visible = false;
                    lbltagnumber.Visible = false;
                    lblbarcode.Visible = false;
                    lblassetidentifier.Visible = false;
                    lblinstallationdate.Visible = false;
                    lblwarrantystart.Visible = false;
                    lbltypename.Visible = false;
                    lblConditionTypeValue.Visible = false;

                    txtassetname.Visible = true;
                    txtdescrption.Visible = true;
                    txtSerialNo.Visible = true;
                    txttagnumber.Visible = true;
                    txtbarcode.Visible = true;
                    txtassetidentifier.Visible = true;
                    rdpinstallationdate.Visible = true;
                    rdpwarrantytart.Visible = true;
                    ddltypename.Visible = true;
                    rcmbConditionType.Visible = true;
                    //BindType();
                    // BindType_PM();

                    if (ddltypename.Items.Count > 1 && !string.IsNullOrEmpty(lbltypename.Text))
                    {
                        //if (ddltypename.FindItemByText(lbltypename.Text).ToString() != null)//added now
                        ddltypename.FindItemByText(lbltypename.Text).Selected = true;
                    }

                    if (lblConditionTypeValue.Text != string.Empty)
                    {
                        //rcmbConditionType.SelectedItem.Text = lblConditionTypeValue.Text;
                        // if (rcmbConditionType.FindItemByText(lblConditionTypeValue.Text.ToString()) != null)// added now
                        // {
                        rcmbConditionType.FindItemByText(lblConditionTypeValue.Text.ToString()).Selected = true;
                        // }
                    }




                    txtassetname.Text = lblname.Text;
                    txtdescrption.Text = lbldescription.Text;
                    txtSerialNo.Text = lblSerialNo.Text;
                    txttagnumber.Text = lbltagnumber.Text;
                    txtbarcode.Text = lblbarcode.Text;
                    txtassetidentifier.Text = lblassetidentifier.Text;
                    if (!string.IsNullOrEmpty(lblinstallationdate.Text))
                    {
                        lblinstallationdate.Text = rdpinstallationdate.SelectedDate.ToString();
                        //rdpinstallationdate.SelectedDate = Convert.ToDateTime(lblinstallationdate.Text.ToString());
                    }
                    if (!string.IsNullOrEmpty(lblwarrantystart.Text))
                    {
                        rdpwarrantytart.SelectedDate = Convert.ToDateTime(lblwarrantystart.Text.ToString());
                    }

                    BindLocationTree(SessionController.Users_.AssetId);

                    //Permissions objPermission = new Permissions();
                    //  objPermission.SetVisibility(txtdescrption, "N");
                }
                else //user is saving component.
                {
                    string facility = "";
                    facility = chklocation();

                    string ispresent = "";
                    ValidateEntitiy obj_validate = new ValidateEntitiy();

                    if ((facility != "notification") && (facility != "chkspace"))
                    {
                        ispresent = obj_validate.vaildate_asset_type(txtassetname.Text, "asset", new Guid(facility));
                        if (Convert.ToString(Request.QueryString["assetid"]) == "00000000-0000-0000-0000-000000000000")
                        {
                            if (ispresent != "y")
                            {
                                string AssetId = insert_update_Asset(facility);
                                hfAssetid.Value = AssetId.ToString(); ;
                                SessionController.Users_.AssetId = AssetId;

                                if (hfpopupflag.Value == "popup")
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindAsset", "RefreshParentpopup();", true);
                                else
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindAsset", "RefreshParent();", true);
                            }
                            else
                            {
                                Response.Write("<script>alert('Asset Name already exist');</script>");
                            }
                        }
                        else
                        {
                            //obj_assetmodel.Fk_facility_id = new Guid(facility.ToString());
                            string AssetId = insert_update_Asset(facility);
                            hfAssetid.Value = AssetId.ToString(); ;
                            SessionController.Users_.AssetId = AssetId;
                            //Response.Redirect("AssetMenu.aspx?pagevalue=AssetProfile &assetid=" + AssetId);
                            //01_05//string value = "<script language='javascript'>GotoProfile('" + AssetId + "')</script>";
                            //Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
                            // ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);
                            //btnsave.Text = "Edit";
                            //Get_AssetProfile(AssetId);
                            // BindLocationGrid(AssetId);                     
                            if (hfpopupflag.Value == "popup")
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "FindAsset", "RefreshParentpopup();", true);
                            else
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "FindAsset", "RefreshParent();", true);
                        }
                    }/////////////////27-11-2012///////////////////////////////
                    else if (facility == "notification")
                    {
                        ispresent = obj_validate.vaildate_asset_type(txtassetname.Text, "asset", new Guid(hfFacilityid.Value));
                        if (Convert.ToString(Request.QueryString["assetid"]) == "00000000-0000-0000-0000-000000000000")
                        {
                            if (ispresent != "y")
                            {
                                string AssetId = insert_update_Asset(hfFacilityid.Value);
                                SessionController.Users_.AssetId = AssetId;
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);
                            }
                            else
                            {
                                Response.Write("<script>alert('Asset Name already exist');</script>");
                            }
                        }
                        else
                        {
                            string AssetId = insert_update_Asset(hfFacilityid.Value);
                            SessionController.Users_.AssetId = AssetId;
                            //if (hfpopupflag.Value == "popup")
                            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParentpopup();", true);
                            //else
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParentpopup();", true);
                        }
                    }

                    if (facility == "notification" || facility == "chkspace")
                    {
                        RadTreeView rtvLocationSpaces = (RadTreeView)UCLocation1.FindControl("rtvLocationSpaces");
                        rtvLocationSpaces.ExpandAllNodes();
                        rtvLocationSpaces.Height = 200;
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

    protected void btncancel_Click(object sender, EventArgs e)
    {
        try
        {
            //if (btnsave.Text == "Save")
            if (btnsave.Text == (string)GetGlobalResourceObject("Resource", "Save"))
            {
                if (hfAssetid.Value != Guid.Empty.ToString())
                {
                    if (hfpopupflag.Value == "popup")
                    {

                        //Response.Redirect("AssetProfileNew.aspx?assetid=" + SessionController.Users_.AssetId.ToString() + "&popupflag=popup");
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "resizePopup('parentWindow');", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParentpopup();", true);
                    }
                    else
                    {
                        Response.Redirect("AssetProfileNew.aspx?assetid=" + SessionController.Users_.AssetId.ToString());
                    }
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

        if (Request.QueryString["value"] != null)
            ddltypename.SelectedValue = Request.QueryString["value"].ToString();

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

                if (parent == Guid.Empty.ToString() || parent1 == Guid.Empty.ToString())
                {
                    component_space = 1;
                    string value = "<script language='javascript'>alertmsg('Please select space.');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
                    // ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "alertmsg(Please select locations under single facility.);", true);

                }
                else if (parent != parent1)
                {
                    component_space = 1;
                    string value = "<script language='javascript'>alertmsg('Please select spaces under one facility.');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "alertmsg(Please dont select facility. Please select the spaces under facility.);", true);
                }
                else if (rtvlocation.CheckedNodes.Count > 2)
                {
                    component_space = 1;
                    string value = "<script language='javascript'>alertmsg('Please select maximum two spaces .');</script>";
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

        if ((parent != "") && (component_space != 1))
        {
            return parent;
        }
        else if ((parent != "") && (component_space == 1))
        {
            return "chkspace";
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

    //protected void btnOK_click(object sender, EventArgs e)
    //{
    //    string fac_id = cmbfacility.SelectedValue.ToString();
    //    if (fac_id == Guid.Empty.ToString())
    //    {
    //        string value = "<script language='javascript'>alert('Please select space.');</script>";
    //        Page.ClientScript.RegisterStartupScript(this.GetType(), "script2", value);

    //        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);   //already commented
    //    }
    //    else
    //    {
    //        string AssetId = insert_update_Asset(fac_id);
    //        SessionController.Users_.AssetId = AssetId;
    //        //Response.Redirect("AssetMenu.aspx?pagevalue=AssetProfile &assetid=" + AssetId);
    //        //string value = "<script language='javascript'>GotoProfile('" + AssetId + "')</script>";
    //        //Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
    //        if (hfpopupflag.Value == "popup")
    //            ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParentpopup();", true);
    //        else
    //            ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);

    //    }

    //}
    protected void btnOK_click(object sender, EventArgs e)
    {
        string fac_id = cmbfacility.SelectedValue.ToString();
        hfFacilityid.Value = fac_id;
        if (fac_id == Guid.Empty.ToString())
        {
            //string value = "<script language='javascript'>alert('Please select space.');</script>";
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "script2", value);

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);   //already commented
        }
        else
        {
            //string AssetId = insert_update_Asset(fac_id);
            //SessionController.Users_.AssetId = AssetId;

            //Response.Redirect("AssetMenu.aspx?pagevalue=AssetProfile &assetid=" + AssetId);     //already commented
            //string value = "<script language='javascript'>GotoProfile('" + AssetId + "')</script>";    //already commented
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);     //already commented

            //if (hfpopupflag.Value == "popup")
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParentpopup();", true);
            //else
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Refresh", "RefreshParent();", true);

        }

    }


    protected void DisableControl()
    {

        //lbldescription.Visible = false;
        //lblSerialNo.Visible = false;
        //lbltagnumber.Visible = false;
        //lblbarcode.Visible = false;
        //lblassetidentifier.Visible = false;
        //lblinstallationdate.Visible = false;
        //lblwarrantystart.Visible = false;
        //lbltypename.Visible = false;
        //lblConditionTypeValue.Visible = false;
        //lblspace.Visible = false;
        txtassetname.Visible = false;
        txtdescrption.Visible = false;
        txtSerialNo.Visible = false;
        txttagnumber.Visible = false;
        txtbarcode.Visible = false;
        txtassetidentifier.Visible = false;
        rdpinstallationdate.Visible = false;
        rdpwarrantytart.Visible = false;
        ddltypename.Visible = false;
        lblConditionTypeValue.Visible = true;
        rcmbConditionType.Visible = false;

        //txtassetname.Visible = true;
        //Sumeet
        rdpWarrentyEndDate.Visible = false;
    }
    protected void EnableControl()
    {
        lblname.Visible = false;
        lbldescription.Visible = false;
        lblSerialNo.Visible = false;
        lbltagnumber.Visible = false;
        lblbarcode.Visible = false;
        lblassetidentifier.Visible = false;
        lblinstallationdate.Visible = false;
        lblwarrantystart.Visible = false;
        lbltypename.Visible = false;
        lblConditionTypeValue.Visible = false;

        txtassetname.Visible = true;
        txtdescrption.Visible = true;
        txtSerialNo.Visible = true;
        txttagnumber.Visible = true;
        txtbarcode.Visible = true;
        txtassetidentifier.Visible = true;
        rdpinstallationdate.Visible = true;
        rdpwarrantytart.Visible = true;
        ddltypename.Visible = true;
        rcmbConditionType.Visible = true;
        //Sumeet
        rdpWarrentyEndDate.Visible = true;

        //BindType();
        BindType_PM();

        if (ddltypename.Items.Count > 1 && !string.IsNullOrEmpty(lbltypename.Text))
        {
            //if (ddltypename.FindItemByText(lbltypename.Text).ToString() != null)//added now
            ddltypename.FindItemByText(lbltypename.Text).Selected = true;
        }

        if (lblConditionTypeValue.Text != string.Empty)
        {
            //rcmbConditionType.SelectedItem.Text = lblConditionTypeValue.Text;
            // if (rcmbConditionType.FindItemByText(lblConditionTypeValue.Text.ToString()) != null)// added now
            // {
            rcmbConditionType.FindItemByText(lblConditionTypeValue.Text.ToString()).Selected = true;
            // }
        }




        //txtassetname.Text = lblname.Text;
        //txtdescrption.Text = lbldescription.Text;
        //txtSerialNo.Text = lblSerialNo.Text;
        //txttagnumber.Text = lbltagnumber.Text;
        //txtbarcode.Text = lblbarcode.Text;
        //txtassetidentifier.Text = lblassetidentifier.Text;
        //if (!string.IsNullOrEmpty(lblinstallationdate.Text))
        //{
        //    rdpinstallationdate.SelectedDate = Convert.ToDateTime(lblinstallationdate.Text.ToString());
        //}
        //if (!string.IsNullOrEmpty(lblwarrantystart.Text))
        //{
        //    rdpwarrantytart.SelectedDate = Convert.ToDateTime(lblwarrantystart.Text.ToString());
        //}

        //BindLocationTree(SessionController.Users_.AssetId);
        //txtdescrption.Visible = true;
        //txtSerialNo.Visible = true;
        //txttagnumber.Visible = true;
        //txtbarcode.Visible = true;
        //txtassetidentifier.Visible = true;
        //rdpinstallationdate.Visible = true;
        //rdpwarrantytart.Visible = true;
        //ddltypename.Visible = true;
        //rcmbConditionType.Visible = true;

    }

    #region changes by Sumeet 

    /// <summary>
    /// Warranty date calculations according to warrenty duration parts on type profile
    /// </summary>
    /// <param name="Type_Id"></param>
    /// <param name="warrantyEnd"></param>
    protected void warranty_date_calculations(Guid Type_Id, string warrantyEnd)
    {
        try
        {
            TypeProfileInfo typeInfoObject = new TypeProfileInfo();
            int durationParts = typeInfoObject.GetDurationParts(Type_Id.ToString());

            if (string.IsNullOrEmpty(warrantyEnd))
            {
                if (!string.IsNullOrEmpty(rdpwarrantytart.SelectedDate.ToString()))
                    rdpWarrentyEndDate.SelectedDate = Convert.ToDateTime(rdpwarrantytart.SelectedDate.ToString()).AddDays(durationParts);
            }
            else
                rdpWarrentyEndDate.SelectedDate = Convert.ToDateTime(warrantyEnd);

            hfWarrentyDurationParts.Value = durationParts.ToString();
        }
        catch (Exception exc)
        {

            throw exc;
        }
    }



    /// <summary>
    ///  Index change function added for getting warrenty duration part for perticular type when type is changed for component profile
    /// </summary>
    /// <param name="o"></param>
    /// <param name="e"></param>
    protected void ddltypename_SelectedIndexChanged(object o, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            string typeID = ddltypename.SelectedValue.ToString();
            TypeProfileInfo typeInfoObject = new TypeProfileInfo();
            int durationParts = typeInfoObject.GetDurationParts(typeID);
            hfWarrentyDurationParts.Value = durationParts.ToString();
            if (!string.IsNullOrEmpty(rdpwarrantytart.SelectedDate.ToString()))
                rdpWarrentyEndDate.SelectedDate = Convert.ToDateTime(rdpwarrantytart.SelectedDate.ToString()).AddDays(durationParts);
        }
        catch (Exception exc)
        {

            throw exc;
        }


    }

    #endregion 
}