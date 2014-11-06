using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using EcoDomus.Session;


public partial class App_UserControls_UserControlComboFacility : System.Web.UI.UserControl
{
    #region Page Events

    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack && SessionController.Users_.IsFacility == "yes")
            {
                BindCurrentFacility();
                Telerik.Web.UI.RadTreeView radTreeViewFacilities = (Telerik.Web.UI.RadTreeView)cmbFacility.Items[0].FindControl("rtvFacilities");
                radTreeViewFacilities.FindNodeByText(SessionController.Users_.facilityName).Checked = true;
                cmbFacility.Text = SessionController.Users_.facilityName;
                cmbFacility.Enabled = false;
            }
            else if (!IsPostBack && SessionController.Users_.IsFacility == "no")
            {
                cmbFacility.Text = "";
                cmbFacility.Enabled = true;
                BindFacilities();
            }
            else if (IsPostBack && SessionController.Users_.IsFacility == "yes")
            {
                BindCurrentFacility();
                Telerik.Web.UI.RadTreeView radTreeViewFacilities = (Telerik.Web.UI.RadTreeView)cmbFacility.Items[0].FindControl("rtvFacilities");
                radTreeViewFacilities.FindNodeByText(SessionController.Users_.facilityName).Checked = true;
                cmbFacility.Text = SessionController.Users_.facilityName;
                cmbFacility.Enabled = false;
            }
            else if (IsPostBack && SessionController.Users_.IsFacility == "no")
            {

                if (Request.Params.Get("__EVENTTARGET") == "ctl00$chkfacility")
                {
                    Telerik.Web.UI.RadTreeView radTreeViewFacilities = (Telerik.Web.UI.RadTreeView)cmbFacility.Items[0].FindControl("rtvFacilities");
                    cmbFacility.Enabled = true;
                    cmbFacility.Text = "";
                    BindFacilities();
                }
                
               
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

    #region Private Methods

    protected void BindFacilities()
    {
        try
        {
            UserControl.UserControlClient objUserControlClient = new UserControl.UserControlClient();
            UserControl.UserControlModel objUserControlModel = new UserControl.UserControlModel();
            objUserControlModel.UserId = new Guid(SessionController.Users_.UserId);
            objUserControlModel.ClientId = new Guid(SessionController.Users_.ClientID);
            objUserControlModel.Organization_id = new Guid(SessionController.Users_.OrganizationID);
            objUserControlModel.Systemrole = SessionController.Users_.UserSystemRole;
            objUserControlModel.Txt_search = "";
            DataSet ds = new DataSet();
            ds = objUserControlClient.GetFacilities(objUserControlModel, SessionController.ConnectionString);
            if (cmbFacility.Items.Count == 0)
            {
                cmbFacility.Items.Add(new Telerik.Web.UI.RadComboBoxItem());
            }
            Telerik.Web.UI.RadTreeView radTreeViewFacilities = (Telerik.Web.UI.RadTreeView)cmbFacility.Items[0].FindControl("rtvFacilities");
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    radTreeViewFacilities.DataTextField = "Name";
                    radTreeViewFacilities.DataValueField = "ID";
                    radTreeViewFacilities.DataFieldParentID = "ParentId";
                    radTreeViewFacilities.DataFieldID = "ID";

                    radTreeViewFacilities.DataSource = ds;
                    radTreeViewFacilities.DataBind();

                    if (radTreeViewFacilities.Nodes.Count > 0)
                    {
                        radTreeViewFacilities.Nodes[0].Expanded = true;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void BindCurrentFacility()
    {
        try
        {
            if (cmbFacility.Items.Count == 0)
            {
                cmbFacility.Items.Add(new Telerik.Web.UI.RadComboBoxItem());
            }
            Telerik.Web.UI.RadTreeView radTreeViewFacilities = (Telerik.Web.UI.RadTreeView)cmbFacility.Items[0].FindControl("rtvFacilities");
            radTreeViewFacilities.DataTextField = "Name";
            radTreeViewFacilities.DataValueField = "ID";
            radTreeViewFacilities.DataFieldParentID = "ParentId";
            radTreeViewFacilities.DataFieldID = "ID";

            DataTable dt = new DataTable();
            dt.Columns.Add("ID", Type.GetType("System.String"));
            dt.Columns.Add("Name", Type.GetType("System.String"));
            dt.Columns.Add("ParentId", Type.GetType("System.String"));
            dt.Columns.Add("order_by", Type.GetType("System.Int32"));

            dt.Rows.Add(dt.NewRow());
            dt.Rows[0]["ID"] = Guid.Empty.ToString();
            dt.Rows[0]["Name"] = "All Facilities";
            dt.Rows[0]["ParentId"] = System.DBNull.Value;
            dt.Rows[0]["order_by"] = 0;

            dt.Rows.Add(dt.NewRow());
            dt.Rows[1]["ID"] = SessionController.Users_.facilityID;
            dt.Rows[1]["Name"] = SessionController.Users_.facilityName;
            dt.Rows[1]["ParentId"] = Guid.Empty.ToString();
            dt.Rows[1]["order_by"] = 0;

            radTreeViewFacilities.DataSource = dt;
            radTreeViewFacilities.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

}