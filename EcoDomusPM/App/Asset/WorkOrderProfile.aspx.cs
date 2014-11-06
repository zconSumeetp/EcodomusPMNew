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
using WorkOrder;
using System.Configuration;



public partial class App_Asset_WorkOrderProfile : System.Web.UI.Page
{
    DataSet ds_log = new DataSet();
    string User_nodes = "";
    string locations = "";
    string document_name= "";

    string CommonVirtualPath = ConfigurationManager.AppSettings["CommonFilePath"].ToString();


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
                if (Convert.ToString(Request.QueryString["popupflag"]) == "popup")
                {
                    hfpopupflag.Value = Convert.ToString(Request.QueryString["popupflag"]);
                    tbltitle.Style.Value = "display:inline";
                    //  lblpopup.Text = "Component Profile";
                    //   lblpopup.Visible = true;
                   // div1.Style.Add("margin-left", "30px");
                    btnclose.Visible = true;

                }
                else
                {
                    tbltitle.Style.Value = "display:none";
                    //lblpopup.Visible = false;
                    btnclose.Visible = false;
                }

                if (!Page.IsPostBack)
                {

                    BindIssueCategory();
                    bindimpactriskchance();
                    BindInspections();
                    bind_status_dropdown();
                    switch (Request.QueryString["work_order_id"])
                    {
                        case null:

                            break;
                        case "00000000-0000-0000-0000-000000000000":
                            Toogle(IssueProfileEnum1.AddProfile);
                            SetWorkOrderDefaultValues();
                            break;
                        default:
                            Toogle(IssueProfileEnum1.BindProfile);
                            break;
                    }
                }
            }
        }

        else
        {


        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);
    }

    protected void SetWorkOrderDefaultValues()
    {
        DataSet ds = new DataSet();
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();
        try
        {
            ds = IssueClient.Get_Default_Values_For_Workorder(IssueModel, SessionController.ConnectionString);
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0] != null)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        rcbType.SelectedValue = ds.Tables[0].Rows[0]["pk_work_order_category_id"].ToString();
                    }

                }
                if (ds.Tables[1] != null)
                {
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        rcb_Status.SelectedValue = ds.Tables[1].Rows[0]["pk_status_id"].ToString();
                    }

                }
                if (ds.Tables[2] != null)
                {
                    if (ds.Tables[2].Rows.Count > 0)
                    {
                        ddlpriority.SelectedValue = ds.Tables[2].Rows[0]["pk_priority_id"].ToString();
                    }

                }

            }
            rdpstartdate.SelectedDate = DateTime.Today.AddDays(1);
            rdpenddate.SelectedDate = DateTime.Today.AddDays(2);

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "GU")
        {

            btn_delete.Visible = false;
            if (Request.QueryString["work_order_id"].ToString() == Guid.Empty.ToString())
            {
                btnSave.Visible = false;
            }
        
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
            
            //rtvLocationSpaces.ExpandAllNodes();
            if (rtvLocationSpaces != null)
            {

                System.Collections.Generic.IList<RadTreeNode> nodes = rtvLocationSpaces.GetAllNodes();
                foreach (RadTreeNode node in nodes)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        if (node.Value.ToUpper() == ds.Tables[0].Rows[i]["fk_space_id"].ToString().ToUpper())
                        {
                            node.Checked = true;
                        }
                    }
                }
            }

        }

        if (SessionController.Users_.Permission_ds != null)
        {
            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
            {
                SetPermissions();
            }
        }
    }

    #region Private Methods

    private void BindAssignedTo()
    {


        DataSet ds = new DataSet();
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();

        IssueModel.Pk_issues_id = new Guid(Request.QueryString["work_order_id"]);
        ds = IssueClient.GetIssueAssign(IssueModel, SessionController.ConnectionString);

        rgAssignTo.DataSource = ds;
        rgAssignTo.DataBind();


    }

    private void BindLocation()
    {



        DataSet ds = new DataSet();
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();

        IssueModel.Pk_issues_id = new Guid(Request.QueryString["work_order_id"]);
        ds = IssueClient.GetIssueLocations(IssueModel, SessionController.ConnectionString);
        ViewState["locations_view_state"] = ds;
        rgLocation.DataSource = ds;
        rgLocation.DataBind();




        RadTreeView rtvLocationSpaces = (RadTreeView)UCLocation1.FindControl("rtvLocationSpaces");
        
        //rtvLocationSpaces.ExpandAllNodes();
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
    private void BindWorkOrderLog()
    {
        try
        {
            Issue.IssueClient IssueClient = new Issue.IssueClient();
            Issue.IssueModel IssueModel = new Issue.IssueModel();
            IssueModel.Pk_issues_id = new Guid(Request.QueryString["work_order_id"]);
            DataSet ds = IssueClient.GetWorkOrderLog(IssueModel, SessionController.ConnectionString.ToString());
            rg_work_order_log.DataSource = ds;
            rg_work_order_log.DataBind();

        }
        catch (Exception ex)
        {

            throw ex;
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
        try
        {
            Issue.IssueClient IssueClient = new Issue.IssueClient();
            Issue.IssueModel IssueModel = new Issue.IssueModel();

            DataSet ds = IssueClient.IssueType(IssueModel, SessionController.ConnectionString.ToString());

            rcbType.DataSource = ds;
            rcbType.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }



    }

    private void BindIssueProfile()
    {
        try
        {

            Issue.IssueClient IssueClient = new Issue.IssueClient();
            Issue.IssueModel IssueModel = new Issue.IssueModel();
            IssueModel.Pk_issues_id = new Guid(Request.QueryString["work_order_id"]);
            DataSet ds = IssueClient.GetIssueProfile(IssueModel, SessionController.ConnectionString.ToString());
            ViewState["work_order_view_state"]=ds;
            if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Save"))
            {
                lbl_work_order_number.Text = ds.Tables[0].Rows[0]["work_order_number"].ToString();

                txtName.Text = ds.Tables[0].Rows[0]["name"].ToString();
                rcbType.SelectedValue = ds.Tables[0].Rows[0]["fk_work_order_type_id"].ToString();
                txtDescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
                txtMitigation.Text = ds.Tables[0].Rows[0]["mitigation"].ToString();

                if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["startdate"].ToString()))
                    rdpstartdate.SelectedDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["startdate"].ToString());

                if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["enddate"].ToString()))
                    rdpenddate.SelectedDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["enddate"].ToString());

                ddlpriority.SelectedValue = ds.Tables[0].Rows[0]["fk_priority_id"].ToString();
                txt_request.Text = ds.Tables[0].Rows[0]["requested_by"].ToString();



                // lblIssueStatus.Text = ds.Tables[0].Rows[0]["issuestatus"].ToString();
                try
                {

                    rcb_Status.FindItemByText(ds.Tables[0].Rows[0]["work_orderstatus"].ToString()).Selected = true; // status drop down
                }
                catch (Exception ex)
                {

                }
                rcbChance.SelectedValue = ds.Tables[0].Rows[0]["fk_chance_id"].ToString();
                rcbImpact.SelectedValue = ds.Tables[0].Rows[0]["fk_impact_id"].ToString();
                rcbRisk.SelectedValue = ds.Tables[0].Rows[0]["fk_risk_id"].ToString();
                lbl_Comp_name.Text = ds.Tables[0].Rows[0]["assetname"].ToString();
                hf_comp_name.Value = ds.Tables[0].Rows[0]["assetname"].ToString();
                lbl_type_name.Text = ds.Tables[0].Rows[0]["typename"].ToString();
                hf_type_name.Value = ds.Tables[0].Rows[0]["typename"].ToString();
                hfdocument_id.Value = ds.Tables[0].Rows[0]["pk_document_id"].ToString();
                //rcbinspection.SelectedValue = ds.Tables[0].Rows[0]["pk_inspection_id"].ToString();
                ds = new DataSet();
                ds = IssueClient.GetIssueOwner(IssueModel, SessionController.ConnectionString);
                ViewState["Assigned_by"] = ds;
                RadTreeView rtvAssignTo = (RadTreeView)UCComboAssignedTo1.FindControl("rtvOrganizationUsers");
                //rtvAssignTo.ExpandAllNodes();
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
            if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
            {
                lbl_work_order_number.Text = ds.Tables[0].Rows[0]["work_order_number"].ToString();

                lblname.Text = ds.Tables[0].Rows[0]["name"].ToString();
                lblType.Text = ds.Tables[0].Rows[0]["work_order_category_name"].ToString();
                lblDescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
                lblChance.Text = ds.Tables[0].Rows[0]["work_order_chance_name"].ToString();
                lblImpact.Text = ds.Tables[0].Rows[0]["work_order_impact_name"].ToString();
                lblRisk.Text = ds.Tables[0].Rows[0]["work_order_risk_name"].ToString();
                lblMitigation.Text = ds.Tables[0].Rows[0]["mitigation"].ToString();
                lbl_Comp_name.Text = ds.Tables[0].Rows[0]["linkasset"].ToString();
                lbl_type_name.Text = ds.Tables[0].Rows[0]["linktype"].ToString();

                hf_lbl_comp_id.Value = ds.Tables[0].Rows[0]["Fk_asset_id"].ToString();
                lnkDocument.Text = ds.Tables[0].Rows[0]["document_name"].ToString();
                hfFilename.Value = ds.Tables[0].Rows[0]["document_name"].ToString();       // document upload
                lnkDocument.NavigateUrl = ds.Tables[0].Rows[0]["file_path"].ToString();
                hfFilePath.Value = ds.Tables[0].Rows[0]["file_path"].ToString();            // document upload
                hfdocument_id.Value = ds.Tables[0].Rows[0]["pk_document_id"].ToString();
                //lblinspection.Text = ds.Tables[0].Rows[0]["inspectioname"].ToString();
                if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["enddate"].ToString()))
                {
                    DateTime dt = Convert.ToDateTime(ds.Tables[0].Rows[0]["enddate"].ToString());
                    lblenddate.Text = dt.ToString("MM/dd/yy");
                }

                if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["startdate"].ToString()))
                {
                    DateTime dt = Convert.ToDateTime(ds.Tables[0].Rows[0]["startdate"].ToString());
                    lblstartdate.Text = dt.ToString("MM/dd/yy");
                }


                lblpriority.Text = ds.Tables[0].Rows[0]["priority"].ToString();
                lblrequestby.Text = ds.Tables[0].Rows[0]["requested_by"].ToString();



                lblIssueStatus.Text = ds.Tables[0].Rows[0]["work_orderstatus"].ToString();

                if (lblIssueStatus.Text == "Resolved")
                    //btn_resolve.Text = "Open";
                    btn_resolve.Text = (string)GetGlobalResourceObject("Resource", "Open");
                else
                    //btn_resolve.Text = "Resolved";
                    btn_resolve.Text = (string)GetGlobalResourceObject("Resource", "Resolved");

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
            //          hfFilename.Value = ds.Tables[0].Rows[0]["document_name"].ToString();       // document upload
            //        lnkDocument.NavigateUrl = ds.Tables[0].Rows[0]["file_path"].ToString();
            //          hfFilePath.Value = ds.Tables[0].Rows[0]["file_path"].ToString();            // document upload
            //        hfdocument_id.Value = ds.Tables[0].Rows[0]["pk_document_id"].ToString();
            //        lblinspection.Text = ds.Tables[0].Rows[0]["inspectioname"].ToString();
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
            //       // lblIssueStatus.Text = ds.Tables[0].Rows[0]["issuestatus"].ToString();
            //         rcb_Status.FindItemByText(ds.Tables[0].Rows[0]["issuestatus"].ToString()).Selected = true; // status drop down
            //        rcbChance.SelectedValue = ds.Tables[0].Rows[0]["fk_chance_id"].ToString();
            //        rcbImpact.SelectedValue = ds.Tables[0].Rows[0]["fk_impact_id"].ToString();
            //        rcbRisk.SelectedValue = ds.Tables[0].Rows[0]["fk_risk_id"].ToString();
            //        lbl_Comp_name.Text = ds.Tables[0].Rows[0]["assetname"].ToString();
            //        lbl_type_name.Text = ds.Tables[0].Rows[0]["typename"].ToString();
            //        hfdocument_id.Value = ds.Tables[0].Rows[0]["pk_document_id"].ToString();
            //        rcbinspection.SelectedValue = ds.Tables[0].Rows[0]["pk_inspection_id"].ToString();
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
        catch (Exception)
        {

            throw;
        }

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

        #region Priority
        IssueClient = new Issue.IssueClient();
        IssueModel = new Issue.IssueModel();
        IssueModel.Dlltype = "priority";
        ddlpriority.DataTextField = "priority_value";
        ddlpriority.DataValueField = "pk_priority_id";
        ds = new DataSet();
        ds = IssueClient.GetRiskChanceImpact(IssueModel, SessionController.ConnectionString.ToString());
        ddlpriority.DataSource = ds;
        ddlpriority.DataBind();

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

        // rcbinspection.DataSource = ds;
        // rcbinspection.DataBind();

        if (!string.IsNullOrEmpty(Request.QueryString["inspectionid"]))
        {
            //rcbinspection.SelectedValue = Request.QueryString["inspectionid"].ToString();
        }




    }

    private void Toogle(IssueProfileEnum1 IssueProfile)
    {

        switch (IssueProfile)
        {
            case IssueProfileEnum1.AddProfile:
                lblname.Visible = false;
                lblChance.Visible = false;
                //lbldeadline.Visible = false;
                lblDescription.Visible = false;
                lblImpact.Visible = false;
                lblMitigation.Visible = false;
                btn_delete.Visible = false;
                btn_resolve.Visible = false;
                rgLocation.Visible = false;
                RadPanelBar2.Visible = false;
                rg_work_order_log.Visible = false;
                RadPanelBar1.Visible = false;
                lbl_WorkOrderLog.Visible = false;
                td_work_order_log.Visible = false;
                rgAssignTo.Visible = false;
                RadPanelBar3.Visible = false;
                lblIssueStatus.Visible = false; // status lable
                lblstartdate.Visible = false;
                lblenddate.Visible = false;
                lblrequestby.Visible = false;
                lblpriority.Visible = false;
                lblIssueStatus.Text = "Open";

                //if (Request.QueryString["assetid"] != null)
                //{
                //     WorkOrderModel wm = new WorkOrderModel();
                //    WorkOrderClient wc = new WorkOrderClient();
                //    DataSet ds = new DataSet();
                //    hf_lbl_comp_id.Value = Request.QueryString["assetid"].ToString();
                //    wm.Fk_Asset_Id = hf_lbl_comp_id.Value;
                //    ds = wc.GetAssetName(wm, SessionController.ConnectionString);                    
                //    lbl_Comp_name.Text = ds.Tables[0].Rows[0]["name"].ToString();

                //}




                if (!string.IsNullOrEmpty(Request.QueryString["assetid"]))
                {
                    DataSet ds = new DataSet();
                    Issue.IssueClient IssueClient = new Issue.IssueClient();
                    Issue.IssueModel IssueModel = new Issue.IssueModel();

                    IssueModel.FacilityID = Guid.Empty;
                    IssueModel.Search_text = string.Empty;
                    IssueModel.Fk_asset_id = new Guid(Request.QueryString["assetid"]);
                    ds = IssueClient.GetFacilityAssetsV1(IssueModel, SessionController.ConnectionString);


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

            case IssueProfileEnum1.BindProfile:


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
                //issue_dead_line.Visible = false;
                btn_add_Comp.Visible = false;
                lnkDocument.Visible = false;
                ruDocument.Visible = false;
                //btnUpload.Visible = false;
                UCLocation1.Visible = false;
                UCComboAssignedTo1.Visible = false;
                lnkDocument.Visible = true;
                //rcbinspection.Visible = false;
                rcb_Status.Visible = false;
                rdpstartdate.Visible = false;
                rdpenddate.Visible = false;

                //ddlRequestedBy.Visible = false;
                txt_request.Visible = false;
                ddlpriority.Visible = false;
                lblrequestby.Visible = true;

                //status drop down
                BindIssueProfile();
                BindLocation();
                
                BindAssignedTo();
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "Updated_On";
                    sortExpr.SortOrder = GridSortOrder.Descending;
                    //Add sort expression, which will sort against first column
                    rg_work_order_log.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                BindWorkOrderLog();
                
                break;

            case IssueProfileEnum1.SaveProfile:

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
                //issue_dead_line.Visible = true;
                btn_add_Comp.Visible = true;
                lnkDocument.Visible = true;
                ruDocument.Visible = true;
                //btnUpload.Visible = true;
                UCComboAssignedTo1.Visible = true;
                UCLocation1.Visible = true;
                //rcbinspection.Visible = true;
                rdpstartdate.Visible = true;
                rdpenddate.Visible = true;
                ddlpriority.Visible = true;

                //ddlRequestedBy.Visible = true;
                txt_request.Visible = true;
                lblrequestby.Visible = false;

                rgLocation.Visible = false;
                RadPanelBar2.Visible = false;
                rg_work_order_log.Visible = false;
                RadPanelBar1.Visible = false;
                td_work_order_log.Visible = false;
                lbl_WorkOrderLog.Visible = false;
                td_work_order_log.Visible = false;
                btn_resolve.Visible = false;
                btn_delete.Visible = false;
                lblType.Visible = false;
                lblRisk.Visible = false;
                lblname.Visible = false;
                lblIssueStatus.Visible = false;                 //status  lable
                lblChance.Visible = false;
                //lbldeadline.Visible = false;
                lblDescription.Visible = false;
                lblImpact.Visible = false;
                lblMitigation.Visible = false;
                btn_delete.Visible = false;
                btn_resolve.Visible = false;
                rgAssignTo.Visible = false;
                RadPanelBar3.Visible = false;
                //lblinspection.Visible = false;
                lblstartdate.Visible = false;
                lblenddate.Visible = false;
                lblrequestby.Visible = false;
                lblpriority.Visible = false;
             

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

        //   facObjFacilityModel.Fk_row_id = new Guid(hf_lbl_comp_id.Value);
        // facObjFacilityModel.Entity = "Component";

        // facObjFacilityModel.Fk_row_id =new Guid( hfworkorderid.Value);
        facObjFacilityModel.Fk_row_ids = hfworkorderid.Value.ToString();
        facObjFacilityModel.Entity = "Issue";
        string strDirExists = string.Empty;
        string filename = "";
        string filepath = string.Empty;


        ds_facility = facObjClientCtrl.GetFacility_of_entity(facObjFacilityModel, SessionController.ConnectionString);

        if (ds_facility.Tables[0].Rows.Count > 0)
        {
            string strFacilityId = ds_facility.Tables[0].Rows[0]["Facility_id"].ToString();// SessionController.Users_.facilityID.ToString();



            try
            {
                //strDirExists = Server.MapPath("~/App/Files/Documents/" + strFacilityId);

            strDirExists = Server.MapPath(CommonVirtualPath + "/Documents/" + strFacilityId);

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
                   
                    
                    //filepath = Path.Combine(Server.MapPath("~/App/Files/Documents/" + strFacilityId), filename);
                    //hfAttachedFile.Value = "~/App/Files/Documents/" + strFacilityId + "/" + filename;

                    filepath = Path.Combine(Server.MapPath(CommonVirtualPath + "/Documents/" + strFacilityId), filename);
                    hfAttachedFile.Value = CommonVirtualPath + "/Documents/" + strFacilityId + "/" + filename;


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
        }
        else
        {
            filename = "";
            hfAttachedFile.Value = "";
        }

        return filename;

    }

    #endregion

    #region Event Handlers


    static Random _r = new Random();


    protected void btnSave_click(object sender, EventArgs e)
    {
        if (btnSave.Text == (string)GetGlobalResourceObject("Resource", "Edit"))
        {
            Toogle(IssueProfileEnum1.SaveProfile);
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
                {
                    userNode = userNode.Substring(0, userNode.Length - 1);
                    User_nodes = userNode;
                }
            }
            if (rtvlocation != null)
            {

                System.Collections.Generic.IList<RadTreeNode> locationCollection = rtvlocation.CheckedNodes;

                foreach (RadTreeNode location in locationCollection)
                {
                    if (location.ParentNode.Value != "00000000-0000-0000-0000-000000000000")
                    {
                        locationids = locationids + location.Value.ToString() + ",";
                        ViewState["fac_id_for_document"] = location.ParentNode.Value;
                    }
                }
                if (locationids.Length > 0)
                {
                    locationids = locationids.Substring(0, locationids.Length - 1);
                    locations = locationids;
                }
            }

            Issue.IssueClient IssueClient = new Issue.IssueClient();
            Issue.IssueModel IssueModel = new Issue.IssueModel();
            if (Request.QueryString["work_order_id"] == "00000000-0000-0000-0000-000000000000")
            {
                IssueModel.Pk_issues_id = Guid.Empty;
                IssueModel.Work_order_number = "WO" + _r.Next().ToString();
            }
            else
            {
                IssueModel.Pk_issues_id = new Guid(Request.QueryString["work_order_id"].ToString());
                hfworkorderid.Value = Request.QueryString["work_order_id"].ToString();
                IssueModel.Work_order_number = lbl_work_order_number.Text;
            }

            IssueModel.Description = txtDescription.Text.ToString().Trim();
            // IssueModel.Inspection = new Guid(rcbinspection.SelectedValue);
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
            if (rdpstartdate.SelectedDate == null)
            {
                IssueModel.Start_date = DateTime.Now;
            }
            else
            {
                IssueModel.Start_date = (DateTime)rdpstartdate.SelectedDate;
            }
            if (rdpenddate.SelectedDate == null)
            {
                IssueModel.Deadline = DateTime.Now;
            }
            else
            {
                IssueModel.Deadline = (DateTime)rdpenddate.SelectedDate;
            }

            IssueModel.Fk_priority_id = new Guid(ddlpriority.SelectedValue);
            IssueModel.Requested_by = txt_request.Text;
            if (locationids.Length == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
            }
            else
            {
               
                IssueModel.Returned_pk_issues_id = IssueClient.InsertUpdateIssues(IssueModel, SessionController.ConnectionString);
                if (IssueModel.Returned_pk_issues_id != Guid.Empty)
                {
                    
                    //IssueModel.Document_id = Guid.Empty;
                    if (hfdocument_id.Value == "")
                    {
                        IssueModel.Document_id = Guid.Empty;
                    }
                    else
                    {
                        IssueModel.Document_id = new Guid(hfdocument_id.Value);
                    }

                    IssueModel.Fk_row_id = IssueModel.Returned_pk_issues_id;
                    hfworkorderid.Value = IssueModel.Fk_row_id.ToString();
                    IssueModel.Entity = "Issue";
                    IssueModel.Document_name = DocumentUpload();
                    IssueModel.File_path = hfAttachedFile.Value;
                    IssueModel.Fk_user_id = new Guid(SessionController.Users_.UserId);
                    document_name = DocumentUpload();
                    GetUpdatedFields();
                    if (document_name != "")
                        IssueClient.InsertUpdateIssuesDocument(IssueModel, SessionController.ConnectionString);

                    string existsflag = IssueModel.Existsflag;
                    string newDocument_id = IssueModel.New_document_id.ToString();
                   
                    updateIssueStatus();   // update issue status 
                    if (Convert.ToString(Request.QueryString["popupflag"]) == "popup")
                    {
                        Response.Redirect("WorkOrderProfile.aspx?work_order_id=" + IssueModel.Returned_pk_issues_id + "&popupflag=popup");
                    }
                    else
                        Response.Redirect("WorkOrderProfile.aspx?work_order_id=" + IssueModel.Returned_pk_issues_id + "");
                }
                else
                {
                    if (hfdocument_id.Value.ToString().Equals(""))
                    {
                        hfdocument_id.Value = Guid.Empty.ToString();
                    }
                    IssueModel.Document_id = new Guid(hfdocument_id.Value);
                    IssueModel.Fk_row_id = new Guid(Request.QueryString["work_order_id"]);
                    IssueModel.Entity = "Issue";
                    IssueModel.Document_name = DocumentUpload();
                    IssueModel.File_path = hfAttachedFile.Value;
                    IssueModel.Fk_user_id = new Guid(SessionController.Users_.UserId);
                    if (IssueModel.Document_name != "")
                        IssueClient.InsertUpdateIssuesDocument(IssueModel, SessionController.ConnectionString);
                    string existsflag = IssueModel.Existsflag;
                    string newDocument_id = IssueModel.New_document_id.ToString();
                    updateIssueStatus();   // update issue status 
                    if (Convert.ToString(Request.QueryString["popupflag"]) == "popup")
                    {
                        Response.Redirect("WorkOrderProfile.aspx?work_order_id=" + Request.QueryString["work_order_id"] + "&popupflag=popup");

                    }
                    else
                        Response.Redirect("WorkOrderProfile.aspx?work_order_id=" + Request.QueryString["work_order_id"] + "");
                }
            }
        }
    }
    private void GetUpdatedFields()
    {
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();
        IssueModel.Pk_issues_id = new Guid(Request.QueryString["work_order_id"]);
        DataSet ds = IssueClient.GetIssueProfile(IssueModel, SessionController.ConnectionString.ToString());
        ds_log = ds;
        ds_log = (DataSet)ViewState["work_order_view_state"];
        DataSet ds_location = new DataSet();
       // IssueModel.Pk_issues_id = new Guid(Request.QueryString["work_order_id"]);
        ds_location= (DataSet)ViewState["locations_view_state"];
        DataSet ds_assigned_user = new DataSet();
        ds_assigned_user = (DataSet)ViewState["Assigned_by"];
        string description_log= "";

        string loc_ids = "";
        string user_ids = "";
        if (ds_log != null)
        {
            if (ds_log.Tables[0].Rows.Count > 0)
            {
                if (Request.QueryString["work_order_id"] != "00000000-0000-0000-0000-000000000000")
                {
                    if (ds_log.Tables[0].Rows[0]["name"].ToString() != txtName.Text.ToString())
                    {
                        description_log = description_log + (string)GetGlobalResourceObject("Resource", "Issue_Name")+",";
                    }
                    if (txtDescription.Text.ToString().Trim() != ds_log.Tables[0].Rows[0]["description"].ToString())
                    {
                        description_log = description_log + (string)GetGlobalResourceObject("Resource", "Description")+",";
                    }

                    if (ds_log.Tables[0].Rows[0]["mitigation"].ToString() != txtMitigation.Text.ToString().Trim())
                    {
                        description_log = description_log +(string)GetGlobalResourceObject("Resource", "Mitigation")+ ",";
                    }
                    if (ds_log.Tables[0].Rows[0]["fk_work_order_type_id"].ToString() != rcbType.SelectedValue.ToString())
                    {
                        description_log = description_log + (string)GetGlobalResourceObject("Resource", "Issue_Type") + ",";
                    }
                    if (!string.IsNullOrEmpty(ds_log.Tables[0].Rows[0]["startdate"].ToString()))
                    {
                        if (Convert.ToDateTime(ds_log.Tables[0].Rows[0]["startdate"].ToString()) != rdpstartdate.SelectedDate)
                        {
                            description_log = description_log + (string)GetGlobalResourceObject("Resource", "Start_Date") + ",";
                        }
                    }
                    if (!string.IsNullOrEmpty(ds_log.Tables[0].Rows[0]["enddate"].ToString()))
                    {
                        if (Convert.ToDateTime(ds_log.Tables[0].Rows[0]["enddate"].ToString()) != rdpenddate.SelectedDate)
                        {
                            description_log = description_log +(string)GetGlobalResourceObject("Resource", "End_Date")+ ",";
                        }
                    }
                    if (ds_log.Tables[0].Rows[0]["fk_priority_id"].ToString() != ddlpriority.SelectedValue.ToString())
                    {
                        description_log = description_log + (string)GetGlobalResourceObject("Resource", "Priority") + ",";
                    
                    }
                    if (ds_log.Tables[0].Rows[0]["requested_by"].ToString() != txt_request.Text.ToString())
                    {
                        description_log = description_log + (string)GetGlobalResourceObject("Resource", "Requested_By")+ ",";
                    }
                    if (ds_log.Tables[0].Rows[0]["fk_chance_id"].ToString() != rcbChance.SelectedValue.ToString())
                    {
                        description_log = description_log +(string)GetGlobalResourceObject("Resource", "Chance")+ ",";
                    }
                    if (ds_log.Tables[0].Rows[0]["fk_impact_id"].ToString()!=rcbImpact.SelectedValue.ToString())
                    {
                        description_log = description_log +(string)GetGlobalResourceObject("Resource", "Impact")+ ",";
                    }
                    if (ds_log.Tables[0].Rows[0]["fk_risk_id"].ToString() != rcbRisk.SelectedValue.ToString())
                    {
                        description_log = description_log + (string)GetGlobalResourceObject("Resource", "Risk")+ ",";
                    }
                    if (ds_log.Tables[0].Rows[0]["assetname"].ToString() !=hf_comp_name.Value.ToString())
                    {
                        description_log = description_log + (string)GetGlobalResourceObject("Resource", "Component")+ ",";
                    }
                    if (ds_log.Tables[0].Rows[0]["typename"].ToString() != hf_type_name.Value.ToString())
                    {
                        description_log = description_log +(string)GetGlobalResourceObject("Resource", "Type")+ ",";
                    }
                    if (ds_log.Tables[0].Rows[0]["document_name"].ToString() != document_name.ToString())
                    {
                        description_log = description_log +(string)GetGlobalResourceObject("Resource", "Document")+ ",";
                    }
                    if (ds_log.Tables[0].Rows[0]["fk_status_id"].ToString() != rcb_Status.SelectedValue.ToString())
                    {
                        description_log = description_log +(string)GetGlobalResourceObject("Resource", "Status")+ ",";
                    }
                    for (int i = 0; i < ds_location.Tables[0].Rows.Count; i++)
                    {
                        loc_ids = loc_ids + ds_location.Tables[0].Rows[i]["pk_location_id"].ToString() + ",";
                    }
                    if (ds_location.Tables[0].Rows.Count > 0)
                    {
                        loc_ids = loc_ids.Substring(0, loc_ids.Length - 1);
                    }
                    List<string> locations_ids = loc_ids.Split(',').ToList<string>();
                    List<string> old_locations_ids = locations.Split(',').ToList<string>();
                    int count = 0;
                    if (locations_ids.Count== old_locations_ids.Count)
                    {
                        for (int i = 0; i < locations_ids.Count; i++)
                        {
                            if (!locations_ids.Contains(old_locations_ids[i].ToString()))
                            {
                                count = count + 1;
                            }
                        }
                          
                        if (count > 0)
                        {
                            description_log = description_log + (string)GetGlobalResourceObject("Resource", "Location")+ ",";
                        }
                    }
                    else
                    {
                        description_log = description_log + (string)GetGlobalResourceObject("Resource", "Location") + ",";
                    }
                    for (int i = 0; i < ds_assigned_user.Tables[0].Rows.Count; i++)
                    {
                        user_ids = user_ids + ds_assigned_user.Tables[0].Rows[i]["pk_user_id"].ToString() + ",";
                    }
                    if (ds_assigned_user.Tables[0].Rows.Count > 0)
                    {
                        user_ids = user_ids.Substring(0, user_ids.Length - 1);
                       
                    }
                    List<string> User_Ids = user_ids.Split(',').ToList<string>();
                    List<string> Old_User_Ids = User_nodes.Split(',').ToList<string>();
                    int count_user = 0;
                    if (User_Ids.Count == Old_User_Ids.Count)
                    {
                        for (int i = 0; i < User_Ids.Count; i++)
                        {
                            if (!User_Ids.Contains(Old_User_Ids[i].ToString()))
                            {
                                count_user = count_user + 1;
                            }
                        }
                        if (count_user > 0)
                        {
                            description_log = description_log +(string)GetGlobalResourceObject("Resource", "Assigned_To")+ ",";
                        }
                    }
                    else
                    {
                        description_log = description_log + (string)GetGlobalResourceObject("Resource", "Assigned_To") + ",";
                    }
                    Issue.IssueClient IClient = new Issue.IssueClient();
                    Issue.IssueModel IModel = new Issue.IssueModel();
                   
                    if (description_log != "")
                    {
                        IModel.Pk_issues_id = new Guid(Request.QueryString["work_order_id"]);
                        IModel.UserId = new Guid(SessionController.Users_.UserId);
                        description_log = description_log.Substring(0, description_log.Length-1 );
                        IModel.Description = (string)GetGlobalResourceObject("Resource", "Updated")+" " + description_log;
                        IClient.InsertWorkOrderLog(IModel, SessionController.ConnectionString);
                    }
                    ViewState["locations_view_state"] = null;
                    ViewState["work_order_view_state"] = null;
                    ViewState["Assigned_by"] = null;

                }
            
            }
        
        }
    }
    // for issue status drop down value change
    protected void updateIssueStatus()
    {
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();
        IssueModel.Issue_status = rcb_Status.Text.ToString();
        IssueModel.Pk_issues_id = new Guid(Request.QueryString["work_order_id"]);
        IssueClient.UpdateIssueStatus(IssueModel, SessionController.ConnectionString);

    }

    protected void cancel_click(object sender, EventArgs e)
    {

        //if (Request.QueryString["issue_id"] != "00000000-0000-0000-0000-000000000000" && btnSave.Text == "Save")
        if (Request.QueryString["work_order_id"] != "00000000-0000-0000-0000-000000000000" && btnSave.Text == (string)GetGlobalResourceObject("Resource", "Save"))
        {
            if (Convert.ToString(Request.QueryString["popupflag"]) == "popup")
            {
                Response.Redirect("WorkOrderProfile.aspx?work_order_id=" + Request.QueryString["work_order_id"] + "&popupflag=popup");
            }
            else
                Response.Redirect("../asset/WorkOrderProfile.aspx?work_order_id=" + Request.QueryString["work_order_id"] + "", true);
        }
        else

            Response.Redirect("../asset/WorkOrder.aspx");

    }

    protected void btnresolve_click(object sender, EventArgs e)
    {
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();

        if (btn_resolve.Text == (string)GetGlobalResourceObject("Resource", "Open"))
        {
            IssueModel.Issue_status = "Open";
        }
        else if (btn_resolve.Text == (string)GetGlobalResourceObject("Resource", "Resolved"))
        {
            IssueModel.Issue_status = "Resolved";
        }




        // IssueModel.Issue_status = btn_resolve.Text;
        IssueModel.Pk_issues_id = new Guid(Request.QueryString["work_order_id"]);
        IssueClient.UpdateIssueStatus(IssueModel, SessionController.ConnectionString);




        if (btn_resolve.Text == (string)GetGlobalResourceObject("Resource", "Resolved"))
        {
            btn_resolve.Text = (string)GetGlobalResourceObject("Resource", "Open");
            BindIssueProfile();
        }
        else
        {
            btn_resolve.Text = (string)GetGlobalResourceObject("Resource", "Resolved");
            BindIssueProfile();
        }


        //switch (btn_resolve.Text)
        //{
        //    case "Resolved":
        //        btn_resolve.Text = (string)GetGlobalResourceObject("Resource", "Open");
        //        BindIssueProfile();
        //        break;
        //    case "Open":
        //        btn_resolve.Text = (string)GetGlobalResourceObject("Resource", "Resolved");
        //        BindIssueProfile();
        //        break;

        //    default:

        //        break;
        //}


    }

    protected void btndelete_click(object sender, EventArgs e)
    {
        Issue.IssueClient IssueClient = new Issue.IssueClient();
        Issue.IssueModel IssueModel = new Issue.IssueModel();
        IssueModel.Issue_status = btn_resolve.Text;
        IssueModel.Pk_issues_id = new Guid(Request.QueryString["work_order_id"]);
        IssueClient.DeleteIssue(IssueModel, SessionController.ConnectionString);
        if (Convert.ToString(Request.QueryString["popupflag"]) == "popup")
        {
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "closewindow();", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "navigate();", true);
            // Response.Redirect("../asset/WorkOrder.aspx?popupflag=popup" , true);
        }
        else
            Response.Redirect("../asset/WorkOrder.aspx", true);
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

    protected void rgAssignTo_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        BindAssignedTo();
    }

    protected void rgAssignTo_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        BindAssignedTo();
    }

    protected void rgAssignTo_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        BindAssignedTo();
    }

    protected void rgLocation_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        BindLocation();
    }

    protected void rgLocation_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        BindLocation();
    }

    protected void rgLocation_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        BindLocation();
    }
    protected void rg_work_order_log_OnSortCommand(object source, GridSortCommandEventArgs e)
    {
        BindWorkOrderLog();
    }

    protected void rg_work_order_log_OnPageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        BindWorkOrderLog();
    }

    protected void rg_work_order_log_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindWorkOrderLog();
       
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

            redirect_page("~\\app\\Login.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

 

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='BIM Server'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Activities")
                {
                    SetPermissionToControl(dr_profile);
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
        string delete_permission = dr["delete_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();

        if (edit_permission == "N")
        {
            btnSave.Enabled = false;
            btn_resolve.Enabled = false;
          
        }
        else
        {
            btnSave.Enabled = true;
            btn_resolve.Enabled = true;
            
        }

        if (delete_permission == "N")
        {
            btn_delete.Enabled = false;     
        }
        else 
        {
            btn_delete.Enabled = true;
        }
    }

}

public enum IssueProfileEnum1
{
    BindProfile,
    SaveProfile,
    AddProfile
}