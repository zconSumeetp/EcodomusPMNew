using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.IO;
using Facility;
using System.Threading;
using System.Globalization;



public partial class App_Asset_AddIssue : System.Web.UI.Page
{

    #region Page Events
    protected void Page_PreInit(object sender, EventArgs e)
    {

        if (Request.QueryString["popupflag"] == "popup")
        {
            Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";

        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
            }
            else
            {


                ruDocument.Localization.Select = (string)GetGlobalResourceObject("Resource", "Select");
                if (Convert.ToString(Request.QueryString["popupflag"]) == "popup")
                {
                    hfpopupflag.Value = Convert.ToString(Request.QueryString["popupflag"]);
                    Label3.Visible = true;
                    btnclose.Visible = true;
                }
                else
                    btnclose.Visible = false;
                if (!Page.IsPostBack)
                {

                    BindIssueCategory();
                    bindimpactriskchance();
                    BindInspections();
                    bind_status_dropdown();
                    switch (Request.QueryString["issue_id"])
                    {
                        case null:

                            break;
                        case "00000000-0000-0000-0000-000000000000":
                            Toogle(IssueProfileEnum.AddProfile);
                            break;
                        default:
                            Toogle(IssueProfileEnum.BindProfile);
                            break;
                    }
                }
            }

        }

        else
        {


        }
    }


    protected void Page_Prerender(object sender, EventArgs e)
    {
        if (SessionController.Users_.IsFacility == "yes")
        {
            hdnfacility.Value = "facilitySelected";

        }
        else
        {

            hdnfacility.Value = "nofacilitySelected";
        }

        if (!string.IsNullOrEmpty(Request.QueryString["assetid"]))
        {
            DataSet ds = new DataSet();
            Issue.IssueClient IssueClient = new Issue.IssueClient();
            Issue.IssueModel IssueModel = new Issue.IssueModel();
            ds = new DataSet();
            IssueClient = new Issue.IssueClient();
            IssueModel = new Issue.IssueModel();

            IssueModel.FacilityID = Guid.Empty;
            IssueModel.Search_text = string.Empty;
            IssueModel.Fk_asset_id = new Guid(Request.QueryString["assetid"]);
            ds = IssueClient.GetFacilityAssets(IssueModel, SessionController.ConnectionString);
            RadTreeView rtvLocationSpaces = (RadTreeView)UCLocation1.FindControl("rtvLocationSpaces");

            rtvLocationSpaces.ExpandAllNodes();
            if (rtvLocationSpaces != null)
            {

                System.Collections.Generic.IList<RadTreeNode> nodes = rtvLocationSpaces.GetAllNodes();
                //foreach (RadTreeNode node in nodes)
                //{
                //    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                //    {
                //        if (node.Value.ToUpper() == ds.Tables[0].Rows[i]["fk_space_id"].ToString().ToUpper())
                //        {
                //            node.Checked = true;
                //        }
                //    }
                //}
            }

        }

    }

    #endregion



    #region Private Methods

    private void BindAssignedTo()
    {


        DataSet ds = new DataSet();
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();

        IssueModel.Pk_issues_id = new Guid(Request.QueryString["issue_id"]);
        ds = IssueClient.GetIssueAssign(IssueModel, SessionController.ConnectionString);

        rgAssignTo.DataSource = ds;
        rgAssignTo.DataBind();


    }

    private void BindLocation()
    {



        DataSet ds = new DataSet();
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();

        IssueModel.Pk_issues_id = new Guid(Request.QueryString["issue_id"]);
        ds = IssueClient.GetIssueLocations(IssueModel, SessionController.ConnectionString);

        rgLocation.DataSource = ds;
        rgLocation.DataBind();




        RadTreeView rtvLocationSpaces = (RadTreeView)UCLocation1.FindControl("rtvLocationSpaces");

        rtvLocationSpaces.ExpandAllNodes();
        if (rtvLocationSpaces != null)
        {

            System.Collections.Generic.IList<RadTreeNode> nodes = rtvLocationSpaces.GetAllNodes();
            foreach (RadTreeNode node in nodes)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (node.Value.ToUpper() == ds.Tables[0].Rows[i]["pk_location_id"].ToString().ToUpper())
                    {
                        node.Checked = true;
                    }
                }
            }
        }

    }

    protected void bind_status_dropdown()
    {
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();

        DataSet ds = IssueClient.GetStatusForIssue(IssueModel, SessionController.ConnectionString.ToString());
        rcb_Status.DataTextField = "name";
        rcb_Status.DataValueField = "pk_status_id";
        rcb_Status.DataSource = ds.Tables[0];
        rcb_Status.DataBind();

    }

    private void BindIssueCategory()
    {
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();

        DataSet ds = IssueClient.IssueType(IssueModel, SessionController.ConnectionString.ToString());

        rcbType.DataSource = ds;
        rcbType.DataBind();


    }

    private void BindIssueProfile()
    {
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();
        IssueModel.Pk_issues_id = new Guid(Request.QueryString["issue_id"]);
        DataSet ds = IssueClient.GetIssueProfile(IssueModel, SessionController.ConnectionString.ToString());

        //if (btnSave.Text == "Edit")
        if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
        {
            lblname.Text = ds.Tables[0].Rows[0]["name"].ToString();
            lblType.Text = ds.Tables[0].Rows[0]["issue_category_name"].ToString();
            lblDescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
            lblChance.Text = ds.Tables[0].Rows[0]["issue_chance_name"].ToString();
            lblImpact.Text = ds.Tables[0].Rows[0]["issue_impact_name"].ToString();
            lblRisk.Text = ds.Tables[0].Rows[0]["issue_risk_name"].ToString();
            lblMitigation.Text = ds.Tables[0].Rows[0]["mitigation"].ToString();
            lbl_Comp_name.Text = ds.Tables[0].Rows[0]["linkasset"].ToString();
            lbl_type_name.Text = ds.Tables[0].Rows[0]["linktype"].ToString();

            hf_lbl_comp_id.Value = ds.Tables[0].Rows[0]["Fk_asset_id"].ToString();
            lnkDocument.Text = ds.Tables[0].Rows[0]["document_name"].ToString();
            hfFilename.Value = ds.Tables[0].Rows[0]["document_name"].ToString();       // document upload
            lnkDocument.NavigateUrl = ds.Tables[0].Rows[0]["file_path"].ToString();
            hfFilePath.Value = ds.Tables[0].Rows[0]["file_path"].ToString();            // document upload
            hfdocument_id.Value = ds.Tables[0].Rows[0]["pk_document_id"].ToString();
            // lblinspection.Text = ds.Tables[0].Rows[0]["inspectioname"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["deadline"].ToString()))
            {
                DateTime dt = Convert.ToDateTime(ds.Tables[0].Rows[0]["deadline"].ToString());
                lbldeadline.Text = dt.ToString("MM/dd/yyyy");
            }

            lblIssueStatus.Text = ds.Tables[0].Rows[0]["issuestatus"].ToString();
            if (lblIssueStatus.Text == "Resolved")
                btn_resolve.Text = "Open";
            else
                btn_resolve.Text = "Resolved";

        }
        //if (btnSave.Text == "Save")
        if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Save"))
        {
            txtName.Text = ds.Tables[0].Rows[0]["name"].ToString();
            rcbType.SelectedValue = ds.Tables[0].Rows[0]["fk_issue_type_id"].ToString();

            txtDescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
            txtMitigation.Text = ds.Tables[0].Rows[0]["mitigation"].ToString();
            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["deadline"].ToString()))
                issue_dead_line.SelectedDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["deadline"].ToString());
            // lblIssueStatus.Text = ds.Tables[0].Rows[0]["issuestatus"].ToString();
            rcb_Status.FindItemByText(ds.Tables[0].Rows[0]["issuestatus"].ToString()).Selected = true; // status drop down
            rcbChance.SelectedValue = ds.Tables[0].Rows[0]["fk_chance_id"].ToString();
            rcbImpact.SelectedValue = ds.Tables[0].Rows[0]["fk_impact_id"].ToString();
            rcbRisk.SelectedValue = ds.Tables[0].Rows[0]["fk_risk_id"].ToString();
            lbl_Comp_name.Text = ds.Tables[0].Rows[0]["assetname"].ToString();
            lbl_type_name.Text = ds.Tables[0].Rows[0]["typename"].ToString();
            hfdocument_id.Value = ds.Tables[0].Rows[0]["pk_document_id"].ToString();
            // rcbinspection.SelectedValue = ds.Tables[0].Rows[0]["pk_inspection_id"].ToString();
            ds = new DataSet();



            ds = IssueClient.GetIssueOwner(IssueModel, SessionController.ConnectionString);
            RadTreeView rtvAssignTo = (RadTreeView)UCComboAssignedTo1.FindControl("rtvOrganizationUsers");
            rtvAssignTo.ExpandAllNodes();
            if (rtvAssignTo != null)
            {

                System.Collections.Generic.IList<RadTreeNode> nodes = rtvAssignTo.GetAllNodes();
                foreach (RadTreeNode node in nodes)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        if (node.Value.ToUpper() == ds.Tables[0].Rows[i]["pk_user_id"].ToString().ToUpper())
                        {
                            node.Checked = true;
                        }
                    }
                }
            }

            BindLocation();

        }

        //switch (btnSave.Text)
        //{
        //    case "Edit":

        //        lblname.Text = ds.Tables[0].Rows[0]["name"].ToString();
        //        lblType.Text = ds.Tables[0].Rows[0]["issue_category_name"].ToString();
        //        lblDescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
        //        lblChance.Text = ds.Tables[0].Rows[0]["issue_chance_name"].ToString();
        //        lblImpact.Text = ds.Tables[0].Rows[0]["issue_impact_name"].ToString();
        //        lblRisk.Text = ds.Tables[0].Rows[0]["issue_risk_name"].ToString();
        //        lblMitigation.Text = ds.Tables[0].Rows[0]["mitigation"].ToString();
        //        lbl_Comp_name.Text = ds.Tables[0].Rows[0]["linkasset"].ToString();
        //        lbl_type_name.Text = ds.Tables[0].Rows[0]["linktype"].ToString();

        //        hf_lbl_comp_id.Value = ds.Tables[0].Rows[0]["Fk_asset_id"].ToString();
        //        lnkDocument.Text = ds.Tables[0].Rows[0]["document_name"].ToString();
        //        hfFilename.Value = ds.Tables[0].Rows[0]["document_name"].ToString();       // document upload
        //        lnkDocument.NavigateUrl = ds.Tables[0].Rows[0]["file_path"].ToString();
        //        hfFilePath.Value = ds.Tables[0].Rows[0]["file_path"].ToString();            // document upload
        //        hfdocument_id.Value = ds.Tables[0].Rows[0]["pk_document_id"].ToString();
        //       // lblinspection.Text = ds.Tables[0].Rows[0]["inspectioname"].ToString();
        //        if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["deadline"].ToString()))
        //        {
        //            DateTime dt = Convert.ToDateTime(ds.Tables[0].Rows[0]["deadline"].ToString());
        //            lbldeadline.Text = dt.ToString("MM/dd/yyyy");
        //        }

        //        lblIssueStatus.Text = ds.Tables[0].Rows[0]["issuestatus"].ToString();
        //        if (lblIssueStatus.Text == "Resolved")
        //            btn_resolve.Text = "Open";
        //        else
        //            btn_resolve.Text = "Resolved";




        //        break;

        //    case "Save":

        //        txtName.Text = ds.Tables[0].Rows[0]["name"].ToString();
        //        rcbType.SelectedValue = ds.Tables[0].Rows[0]["fk_issue_type_id"].ToString();

        //        txtDescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
        //        txtMitigation.Text = ds.Tables[0].Rows[0]["mitigation"].ToString();
        //        if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["deadline"].ToString()))
        //            issue_dead_line.SelectedDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["deadline"].ToString());
        //        // lblIssueStatus.Text = ds.Tables[0].Rows[0]["issuestatus"].ToString();
        //        rcb_Status.FindItemByText(ds.Tables[0].Rows[0]["issuestatus"].ToString()).Selected = true; // status drop down
        //        rcbChance.SelectedValue = ds.Tables[0].Rows[0]["fk_chance_id"].ToString();
        //        rcbImpact.SelectedValue = ds.Tables[0].Rows[0]["fk_impact_id"].ToString();
        //        rcbRisk.SelectedValue = ds.Tables[0].Rows[0]["fk_risk_id"].ToString();
        //        lbl_Comp_name.Text = ds.Tables[0].Rows[0]["assetname"].ToString();
        //        lbl_type_name.Text = ds.Tables[0].Rows[0]["typename"].ToString();
        //        hfdocument_id.Value = ds.Tables[0].Rows[0]["pk_document_id"].ToString();
        //       // rcbinspection.SelectedValue = ds.Tables[0].Rows[0]["pk_inspection_id"].ToString();
        //        ds = new DataSet();



        //        ds = IssueClient.GetIssueOwner(IssueModel, SessionController.ConnectionString);
        //        RadTreeView rtvAssignTo = (RadTreeView)UCComboAssignedTo1.FindControl("rtvOrganizationUsers");
        //        rtvAssignTo.ExpandAllNodes();
        //        if (rtvAssignTo != null)
        //        {

        //            System.Collections.Generic.IList<RadTreeNode> nodes = rtvAssignTo.GetAllNodes();
        //            foreach (RadTreeNode node in nodes)
        //            {
        //                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        //                {
        //                    if (node.Value.ToUpper() == ds.Tables[0].Rows[i]["pk_user_id"].ToString().ToUpper())
        //                    {
        //                        node.Checked = true;
        //                    }
        //                }
        //            }
        //        }

        //        BindLocation();

        //        break;


        //    default:
        //        break;
        //}



    }

    private void bindimpactriskchance()
    {

        #region Risk

        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();
        IssueModel.Dlltype = "risk";
        DataSet ds = IssueClient.GetRiskChanceImpact(IssueModel, SessionController.ConnectionString.ToString());

        rcbRisk.DataSource = ds;
        rcbRisk.DataBind();
        #endregion


        #region Chance
        IssueClient = new Issue.IssueClient();
        IssueModel = new Issue.IssueModel();
        IssueModel.Dlltype = "chance";
        ds = new DataSet();
        ds = IssueClient.GetRiskChanceImpact(IssueModel, SessionController.ConnectionString.ToString());

        rcbChance.DataSource = ds;
        rcbChance.DataBind();

        #endregion


        #region MyRegion
        IssueClient = new Issue.IssueClient();
        IssueModel = new Issue.IssueModel();
        IssueModel.Dlltype = "impact";
        ds = new DataSet();
        ds = IssueClient.GetRiskChanceImpact(IssueModel, SessionController.ConnectionString.ToString());

        rcbImpact.DataSource = ds;
        rcbImpact.DataBind();

        #endregion


    }

    private void BindInspections()
    {


        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();

        if (SessionController.Users_.IsFacility == "yes")
        {
            IssueModel.FacilityID = new Guid(SessionController.Users_.facilityID);

        }
        else
        {

            IssueModel.FacilityID = Guid.Empty;
        }




        DataSet ds = IssueClient.GetInspections(IssueModel, SessionController.ConnectionString.ToString());

        //rcbinspection.DataSource = ds;
        // rcbinspection.DataBind();

        //if (!string.IsNullOrEmpty(Request.QueryString["inspectionid"]))
        //{
        //    rcbinspection.SelectedValue = Request.QueryString["inspectionid"].ToString();
        //}




    }

    private void Toogle(IssueProfileEnum IssueProfile)
    {

        switch (IssueProfile)
        {
            case IssueProfileEnum.AddProfile:

                lblname.Visible = false;
                lblChance.Visible = false;
                lbldeadline.Visible = false;
                lblDescription.Visible = false;
                lblImpact.Visible = false;
                lblMitigation.Visible = false;
                btn_delete.Visible = false;
                btn_resolve.Visible = false;
                rgLocation.Visible = false;
                rgAssignTo.Visible = false;
                lblIssueStatus.Visible = false; // status lable
                lblIssueStatus.Text = "Open";
                if (!string.IsNullOrEmpty(Request.QueryString["assetid"]))
                {
                    DataSet ds = new DataSet();
                    Issue.IssueClient IssueClient = new Issue.IssueClient();
                    Issue.IssueModel IssueModel = new Issue.IssueModel();

                    IssueModel.FacilityID = Guid.Empty;
                    IssueModel.Search_text = string.Empty;
                    IssueModel.Fk_asset_id = new Guid(Request.QueryString["assetid"]);
                    ds = IssueClient.GetFacilityAssets(IssueModel, SessionController.ConnectionString);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        lbl_Comp_name.Text = ds.Tables[0].Rows[0]["AssetName"].ToString();
                        lbl_type_name.Text = ds.Tables[0].Rows[0]["TypeName"].ToString();
                        hf_lbl_comp_id.Value = ds.Tables[0].Rows[0]["pk_asset_id"].ToString();

                    }
                    else
                    {

                    }



                }



                break;

            case IssueProfileEnum.BindProfile:

                rcbChance.Visible = false;
                rcbImpact.Visible = false;
                rcbRisk.Visible = false;
                rcbType.Visible = false;
                txtDescription.Visible = false;
                txtMitigation.Visible = false;
                txtName.Visible = false;
                //btnSave.Text = "Edit";
                btnSave.Text = (string)GetGlobalResourceObject("Resource", "Edit");

                btnCancel.Visible = false;
                issue_dead_line.Visible = false;
                btn_add_Comp.Visible = false;
                lnkDocument.Visible = false;
                ruDocument.Visible = false;
                //btnUpload.Visible = false;
                UCLocation1.Visible = false;
                UCComboAssignedTo1.Visible = false;
                lnkDocument.Visible = true;
                // rcbinspection.Visible = false;
                rcb_Status.Visible = false;              //status drop down
                BindIssueProfile();
                BindLocation();
                BindAssignedTo();

                break;

            case IssueProfileEnum.SaveProfile:

                rcbChance.Visible = true;
                rcbImpact.Visible = true;
                rcbRisk.Visible = true;
                rcbType.Visible = true;
                rcb_Status.Visible = true;                  //status drop down
                txtDescription.Visible = true;
                txtMitigation.Visible = true;
                txtName.Visible = true;
                //btnSave.Text = "Save";
                btnSave.Text = (string)GetGlobalResourceObject("Resource", "Save");

                btnCancel.Visible = true;
                issue_dead_line.Visible = true;
                btn_add_Comp.Visible = true;
                lnkDocument.Visible = true;
                ruDocument.Visible = true;
                //btnUpload.Visible = true;
                UCComboAssignedTo1.Visible = true;
                UCLocation1.Visible = true;
                //rcbinspection.Visible = true;


                rgLocation.Visible = false;
                btn_resolve.Visible = false;
                btn_delete.Visible = false;
                lblType.Visible = false;
                lblRisk.Visible = false;
                lblname.Visible = false;
                lblIssueStatus.Visible = false;                 //status  lable
                lblChance.Visible = false;
                lbldeadline.Visible = false;
                lblDescription.Visible = false;
                lblImpact.Visible = false;
                lblMitigation.Visible = false;
                btn_delete.Visible = false;
                btn_resolve.Visible = false;
                rgAssignTo.Visible = false;
                //lblinspection.Visible = false;

                break;

            default:

                break;
        }







    }


    public string DocumentUpload()
    {


        FacilityClient facObjClientCtrl = new FacilityClient();
        FacilityModel facObjFacilityModel = new FacilityModel();
        //---To get 1 or more facilities of the entity -------------------------
        DataSet ds_facility = new DataSet();
        facObjFacilityModel.Fk_row_id = new Guid(hf_lbl_comp_id.Value);
        facObjFacilityModel.Entity = "Component";
        ds_facility = facObjClientCtrl.GetFacility_of_entity(facObjFacilityModel, SessionController.ConnectionString);
        string strFacilityId = ds_facility.Tables[0].Rows[0]["Facility_id"].ToString();// SessionController.Users_.facilityID.ToString();

        string strDirExists = string.Empty;
        string filename = "";
        string filepath = string.Empty;
        try
        {
            strDirExists = Server.MapPath("~/App/Files/Documents/" + strFacilityId);
            DirectoryInfo de = new DirectoryInfo(strDirExists);
            if (!de.Exists)
            {
                de.Create();
            }
            if (ruDocument.UploadedFiles.Count > 0)                         // document upload
            {

                foreach (UploadedFile file in ruDocument.UploadedFiles)
                {
                    filename = file.GetName();
                    filename = filename.Replace("&", "_");
                    filename = filename.Replace("#", "_");
                    filename = filename.Replace("%", "_");
                    filename = filename.Replace("*", "_");
                    filename = filename.Replace("{", "_");
                    filename = filename.Replace("}", "_");
                    filename = filename.Replace("\\", "_");
                    filename = filename.Replace(":", "_");
                    filename = filename.Replace("<", "_");
                    filename = filename.Replace(">", "_");
                    filename = filename.Replace("?", "_");
                    filename = filename.Replace("/", "_");
                    filepath = Path.Combine(Server.MapPath("~/App/Files/Documents/" + strFacilityId), filename);
                    hfAttachedFile.Value = "~/App/Files/Documents/" + strFacilityId + "/" + filename;
                    file.SaveAs(filepath, true);

                }
            }
            else                                                    // document upload
            {
                filename = hfFilename.Value.ToString();
                hfAttachedFile.Value = hfFilePath.Value.ToString();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return filename;

    }

    #endregion



    #region Event Handlers

    protected void btnSave_click(object sender, EventArgs e)
    {
        //if (btnSave.Text == "Edit")
        if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
        {
            Toogle(IssueProfileEnum.SaveProfile);
            BindIssueProfile();
        }
        else
        {

            RadTreeView rtvAssignTo = (RadTreeView)UCComboAssignedTo1.FindControl("rtvOrganizationUsers");
            RadTreeView rtvlocation = (RadTreeView)UCLocation1.FindControl("rtvLocationSpaces");
            string userNode = "";
            string locationids = "";
            if (rtvAssignTo != null)
            {

                System.Collections.Generic.IList<RadTreeNode> userCollection = rtvAssignTo.CheckedNodes;

                foreach (RadTreeNode user in userCollection)
                {
                    if (user.ParentNode.Value != "00000000-0000-0000-0000-000000000000")
                        userNode = userNode + user.Value.ToString() + ",";
                }
                if (userNode.Length > 0)
                    userNode = userNode.Substring(0, userNode.Length - 1);
            }
            if (rtvlocation != null)
            {

                System.Collections.Generic.IList<RadTreeNode> locationCollection = rtvlocation.CheckedNodes;

                foreach (RadTreeNode location in locationCollection)
                {
                    if (location.ParentNode != null)
                    {
                        if (location.ParentNode.Value != "00000000-0000-0000-0000-000000000000")
                            locationids = locationids + location.Value.ToString() + ",";
                    }
                }
                if (locationids.Length > 0)
                    locationids = locationids.Substring(0, locationids.Length - 1);
            }

            Issue.IssueClient IssueClient = new Issue.IssueClient();
            Issue.IssueModel IssueModel = new Issue.IssueModel();
            if (Request.QueryString["issue_id"] == "00000000-0000-0000-0000-000000000000")
            {
                IssueModel.Pk_issues_id = Guid.Empty;
            }
            else
            {
                IssueModel.Pk_issues_id = new Guid(Request.QueryString["issue_id"].ToString());
            }


            if (issue_dead_line.SelectedDate.HasValue)
                IssueModel.Deadline = issue_dead_line.SelectedDate.Value;
            IssueModel.Description = txtDescription.Text.ToString().Trim();
            //IssueModel.Inspection = new Guid(rcbinspection.SelectedValue);
            IssueModel.Issue_name = txtName.Text.ToString().Trim();
            IssueModel.Mitigation = txtMitigation.Text.ToString().Trim();
            IssueModel.Fk_asset_id = new Guid(hf_lbl_comp_id.Value.Equals("") ? "" + Guid.Empty : hf_lbl_comp_id.Value);
            IssueModel.Fk_chance_id = new Guid(rcbChance.SelectedValue);
            IssueModel.Fk_impact_id = new Guid(rcbImpact.SelectedValue);
            IssueModel.Fk_risk_id = new Guid(rcbRisk.SelectedValue);
            IssueModel.Fk_issue_type_id = new Guid(rcbType.SelectedValue);
            IssueModel.Fk_status_id = new Guid(rcb_Status.SelectedValue);  // status id
            IssueModel.Location = locationids;
            IssueModel.Fk_uploaded_file_id = Guid.Empty;
            IssueModel.Fk_user_id = Guid.Empty;
            IssueModel.Owner = userNode;
            IssueModel.UserId = new Guid(SessionController.Users_.UserId);

            IssueModel.Returned_pk_issues_id = IssueClient.InsertUpdateIssues(IssueModel, SessionController.ConnectionString);
            if (IssueModel.Returned_pk_issues_id != Guid.Empty)
            {


                //CheckBox chk_facility = (CheckBox)Master.FindControl("chkfacility");
                //if (SessionController.Users_.facilityID != null)
                //{

                //    IssueModel.FacilityID = new Guid(SessionController.Users_.facilityID);
                //}
                //else
                //{
                //    IssueModel.FacilityID = Guid.Empty;

                //}

                IssueModel.Document_id = Guid.Empty;
                IssueModel.Fk_row_id = IssueModel.Returned_pk_issues_id;
                IssueModel.Entity = "Issue";
                IssueModel.Document_name = DocumentUpload();
                IssueModel.File_path = hfAttachedFile.Value;
                IssueModel.Fk_user_id = new Guid(SessionController.Users_.UserId);

                IssueClient.InsertUpdateIssuesDocument(IssueModel, SessionController.ConnectionString);
                string existsflag = IssueModel.Existsflag;
                string newDocument_id = IssueModel.New_document_id.ToString();
                updateIssueStatus();   // update issue status 


                Response.Redirect("IssueProfile.aspx?issue_id=" + IssueModel.Returned_pk_issues_id + "");
            }
            else
            {
                //CheckBox chk_facility = (CheckBox)Master.FindControl("chkfacility");
                //if (SessionController.Users_.facilityID != null)
                //{

                //    IssueModel.FacilityID = new Guid(SessionController.Users_.facilityID);
                //}
                //else
                //{
                //    IssueModel.FacilityID = Guid.Empty;

                //}

                IssueModel.Document_id = new Guid(hfdocument_id.Value);
                IssueModel.Fk_row_id = new Guid(Request.QueryString["issue_id"]);
                IssueModel.Entity = "Issue";
                IssueModel.Document_name = DocumentUpload();
                IssueModel.File_path = hfAttachedFile.Value;
                IssueModel.Fk_user_id = new Guid(SessionController.Users_.UserId);

                IssueClient.InsertUpdateIssuesDocument(IssueModel, SessionController.ConnectionString);
                string existsflag = IssueModel.Existsflag;
                string newDocument_id = IssueModel.New_document_id.ToString();
                updateIssueStatus();   // update issue status 
                if (hfpopupflag.Value == "popup")
                    Response.Redirect("IssueProfile.aspx?issue_id=" + Request.QueryString["issue_id"] + "&popupflag=popup" + "");
                else
                    Response.Redirect("IssueProfile.aspx?issue_id=" + Request.QueryString["issue_id"] + "");
            }

        }
    }

    // for issue status drop down value change
    protected void updateIssueStatus()
    {
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();


        IssueModel.Issue_status = rcb_Status.Text.ToString();
        IssueModel.Pk_issues_id = new Guid(Request.QueryString["issue_id"]);
        IssueClient.UpdateIssueStatus(IssueModel, SessionController.ConnectionString);

    }
    protected void cancel_click(object sender, EventArgs e)
    {

        //if (Request.QueryString["issue_id"] != "00000000-0000-0000-0000-000000000000" && btnSave.Text == "Save")
        if (Request.QueryString["issue_id"] != "00000000-0000-0000-0000-000000000000" && btnSave.Text == (string)GetGlobalResourceObject("Resource", "Save"))
        {
            if (hfpopupflag.Value == "popup")
                Response.Redirect("../asset/IssueProfile.aspx?issue_id=" + Request.QueryString["issue_id"] + "&popupflag=popup" + "", true);
            else
                Response.Redirect("../asset/IssueProfile.aspx?issue_id=" + Request.QueryString["issue_id"] + "", true);

        }
        else
        {

            Response.Redirect("../asset/Issues.aspx");

        }
    }

    protected void btnresolve_click(object sender, EventArgs e)
    {
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();


        IssueModel.Issue_status = btn_resolve.Text;
        IssueModel.Pk_issues_id = new Guid(Request.QueryString["issue_id"]);
        IssueClient.UpdateIssueStatus(IssueModel, SessionController.ConnectionString);

        switch (btn_resolve.Text)
        {

            case "Resolved":
                btn_resolve.Text = "Open";
                BindIssueProfile();
                break;
            case "Open":
                btn_resolve.Text = "Resolved";
                BindIssueProfile();
                break;

            default:

                break;

        }


    }

    protected void btndelete_click(object sender, EventArgs e)
    {
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();


        IssueModel.Issue_status = btn_resolve.Text;
        IssueModel.Pk_issues_id = new Guid(Request.QueryString["issue_id"]);
        IssueClient.DeleteIssue(IssueModel, SessionController.ConnectionString);

        Response.Redirect("../asset/issues.aspx", true);

    }


    protected void btn_add_Comp_click(object sender, EventArgs e)
    {
        try
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "navigate", "Openfacilitylist();", true);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void rgAssignTo_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
    {

        try
        {
            BindAssignedTo();
        }

        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rgLocation_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
    {

        try
        {
            BindLocation();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rgLocation_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {

        try
        {
            BindLocation();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rgAssignTo_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            BindAssignedTo();
        }
        catch (Exception ex)
        {

            throw ex;
        }
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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

}

public enum IssueProfileEnum
{
    BindProfile,
    SaveProfile,
    AddProfile
}