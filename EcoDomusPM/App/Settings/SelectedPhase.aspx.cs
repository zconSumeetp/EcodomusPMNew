using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using Telerik.Web.UI;
using Organization;
using System.Globalization;
using System.Threading;

public partial class App_Settings_SelectedPhase : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hfPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
        string strproject_id;
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    if (SessionController.Users_.ProjectId != null)
                    {
                        strproject_id = SessionController.Users_.ProjectId.ToString();
                    }
                    Guid pk_phase_id = new Guid(Request.QueryString["pk_phase_id"].ToString());
                    hforganization_id.Value = Request.QueryString["fk_organization_id"].ToString();
                    hfphaseid.Value = Convert.ToString(pk_phase_id);
                    string phase_name = Convert.ToString(Request.QueryString["phase"]);
                    lblphaseName.Text = phase_name;
                    bind_tree();
                    lblsavemsg.Visible = false;
                    
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

            // redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }
    public void bind_tree()
    {
        try
        {
            //Report.ReportClient pc = new Report.ReportClient();
            //Report.ReportModel pm = new Report.ReportModel();
            OrganizationClient pc = new OrganizationClient();
            OrganizationModel pm = new OrganizationModel();

            DataSet ds = new DataSet();
            pm.Organization_Id =new Guid( hforganization_id.Value);
            //if (SessionController.Users_.ProjectId != null)
            //{
            //    pm.fkproject_id = SessionController.Users_.ProjectId.ToString();
            //}
            pm.Phase_id = new Guid(hfphaseid.Value);
            //if (SessionController.ConnectionString != null)
            //{
            ds = pc.proc_bind_entity_field_tree(pm);

                rtvsheetnames.DataFieldID = "Id";
                rtvsheetnames.DataFieldParentID = "ParentId";
                rtvsheetnames.DataTextField = "SheetNames";
                rtvsheetnames.DataValueField = "Id";
                rtvsheetnames.DataSource = ds;
                rtvsheetnames.DataBind();
                this.rtvsheetnames.Nodes[0].Expanded = true;
                string strentityid = "";
                string strfieldid = "";
                if (ds.Tables[1].Rows.Count > 0)
                    strentityid = ds.Tables[1].Rows[0]["Entities"].ToString();
                if (ds.Tables[2].Rows.Count > 0)
                    strfieldid = ds.Tables[2].Rows[0]["Fields"].ToString();
                System.Collections.Generic.IList<RadTreeNode> nodes = rtvsheetnames.GetAllNodes();

                foreach (RadTreeNode node in nodes)
                {

                    if (node.Level == 1)
                    {
                        node.Expanded = false;
                        if (strentityid.ToLower().Contains(node.Value.ToString().ToLower()))
                        {
                            node.Checked = true;
                        }
                        else
                        {
                            node.Checked = false;
                        }
                    }
                    else if (node.Level == 2)
                    {
                        node.Expanded = false;
                        if (strfieldid.ToLower().Contains(node.Value.ToString().ToLower()))
                        {
                            node.Checked = true;
                        }
                        else
                        {
                            node.Checked = false;
                        }

                    }
                }
           // }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string strSheetids = "";
            string strfieldids = "";
            string flag = "False";
            //Report.ReportClient pc = new Report.ReportClient();
            //Report.ReportModel pm = new Report.ReportModel();
            OrganizationClient pc = new OrganizationClient();
            OrganizationModel pm = new OrganizationModel();
           
            string strproject = Convert.ToString(SessionController.Users_.ProjectId);

            if (rtvsheetnames != null)
            {
                System.Collections.Generic.IList<RadTreeNode> SheetCollection = rtvsheetnames.CheckedNodes;

                if (SheetCollection.Count > 0)
                {
                    foreach (RadTreeNode sheet in SheetCollection)
                    {
                        if (sheet.ParentNode != null)
                        {
                            //if (sheet.ParentNode.Text == "Sheet Names")
                            //{
                            if (sheet.Value != Guid.Empty.ToString() && sheet.Value != Guid.Empty.ToString())
                            {
                                //  System.Collections.Generic.IList<RadTreeNode> fieldCollection = rtvsheetnames.;
                                if (sheet.Checked == true && sheet.ParentNode.Text == "Sheet Names")
                                {
                                    strSheetids = strSheetids + sheet.Value.ToString() + ",";
                                }
                                foreach (RadTreeNode field in SheetCollection)
                                {
                                    if (field.ParentNode != null)
                                    {
                                        //if (field.ParentNode.ID == sheet.ID)
                                        //{
                                        if (!strfieldids.Contains(field.Value.ToString()) && field.Text != "Sheet Names")
                                        {
                                            strfieldids = strfieldids + field.Value.ToString() + ",";
                                        }
                                        // }
                                        if (field.ParentNode.Checked == false)
                                        {
                                            flag = "True";
                                            if (!strSheetids.Contains(field.ParentNode.Value.ToString()))
                                            {
                                                strSheetids = strSheetids + field.ParentNode.Value.ToString() + ",";
                                            }
                                        }
                                    }

                                }

                            }
                            // }

                        }
                        flag = "False";
                    }

                    if (strSheetids.Length > 0)
                        strSheetids = strSheetids.Substring(0, strSheetids.Length - 1);//For removing comma at the end
                    if (strfieldids.Length > 0)
                        strfieldids = strfieldids.Substring(0, strfieldids.Length - 1);
                    // ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:RequestMessage(0);", true);
                }
                pm.StrEntityid= strSheetids;
                pm.Organization_Id =new Guid( hforganization_id.Value);
               // pm.fkproject_id = SessionController.Users_.ProjectId;
                pm.Phase_id =new Guid( hfphaseid.Value);
                pm.StrField_id = strfieldids;

                pc.proc_insrt_update_selected_phase_status(pm);
                Response.Redirect("Phases.aspx?organization_id=" + hforganization_id.Value, false);
                lblsavemsg.Text = "Saved Successfully";
                lblsavemsg.Visible = true;
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

            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    SetPermissions();
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
            DataRow dr_component = ds_component.Tables[0].Select("name='BIM Server'")[0];
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Organization")
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
        }
        else
        {
            btnSave.Enabled = true;
        }
    }
} 
