using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EcoDomus.Session;
using BIMModel;
using Telerik.Web.UI;

public partial class App_Settings_LODModelViewer : System.Web.UI.Page
{
    public string navis_class_id;
    DataSet ds_file = new DataSet();
    public static string FileId;
    string conTest = "Data Source=208.83.233.66\\sqlexpress;Initial Catalog=EcoDomus_Central;User ID=sa;Password=ecodomus@123;Connect Timeout=50000000";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId == null)
            {
                Response.Redirect("~/App/LoginPM.aspx?Error=Session", true);
            }
            DataSet ds = new DataSet();
            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            BIMModel.BIMModels mdl = new BIMModel.BIMModels();
            mdl.User_id = new Guid(SessionController.Users_.UserId);
            ds = BIMModelClient.GetViewerForUser(mdl, SessionController.ConnectionString);
            if (ds != null)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    navis_class_id = ds.Tables[0].Rows[0]["class_id"].ToString();
                }
                else
                {
                    navis_class_id = "CLSID:8A8F9690-5695-42D5-AD50-6FA695F8B634";      // New classid
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

        if (!IsPostBack)
        {
            FileId = "2aa0ec54-dec7-426e-aef6-cd2ddac82638";

            string mappath;
            mappath = "<p style='text-align: center'><object id='NWControl01' height='55%' width='100%' classid='" + navis_class_id + "' codebase='../../Bin/Navisworks ActiveX Redistributable Setup.exe' ><param name='_cx' value='30000'><param name='_cy' value='12000'>";

            BIMModel.BIMModels mdl = new BIMModel.BIMModels();
            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            mdl.File_id = new Guid(FileId);
            ds_file = BIMModelClient.getuploadedfileinformation(mdl, SessionController.ConnectionString);
           
            mappath = mappath + "<param name='SRC' value='" + Request.Url.GetLeftPart(UriPartial.Authority) + ds_file.Tables[0].Rows[0]["file_path"].ToString().Substring(1) + "/" + ds_file.Tables[0].Rows[0]["file_name"].ToString() + "'></object></p>";
            divModel.InnerHtml = mappath;

            BindLODReport();

            BindComponentGrid();
            Bind_Type();
            Bind_Documents("Asset", new Guid("6633e4a4-f583-4e17-b702-84977acd299c"));
            hf_component_id.Value = "6633e4a4-f583-4e17-b702-84977acd299c";
            BindViewPointsComponents();
        }
    }

    public void BindComponentGrid()
    {
        DataSet ds = new DataSet();

        BIMModels BIMModels = new BIMModels();
        BIMModelClient BIMModelClient = new BIMModelClient();
        BIMModels.File_id = new Guid("be461f40-d634-4eb4-8111-238e96d63f1c");
        BIMModels.Model_id = "166873";
        BIMModels.Asset_id = new Guid("00000000-0000-0000-0000-000000000000");
        ds = BIMModelClient.getattributesformodelviewer(BIMModels, SessionController.ConnectionString);

        rd_component.DataSource = ds;
        rd_assigned_components.DataBind();
    }

    public void Bind_Type()
    {
        try
        {
            BIMModels BIMModels = new BIMModels();
            BIMModelClient BIMModelClient = new BIMModelClient();
            DataSet ds = new DataSet();
            BIMModels.File_id = new Guid("be461f40-d634-4eb4-8111-238e96d63f1c");
            BIMModels.Model_id = "166873";
            BIMModels.Asset_id = new Guid("00000000-0000-0000-0000-000000000000");

            ds = BIMModelClient.GetTypeAttributesModelViewer(BIMModels, SessionController.ConnectionString);
            rd_type.DataSource = ds;
            rd_type.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void Bind_Documents(string flag, Guid asset_id)
    {
        try
        {
            DataSet ds = new DataSet();
            BIMModels mdl = new BIMModels();
            BIMModelClient bmc = new BIMModelClient();
            mdl.Asset_id = asset_id;
            mdl.Flag = flag.Equals("Asset") ? "asset" : "space";
            ds = bmc.GetDocumentModelViewer(mdl, SessionController.ConnectionString);
            rd_document.DataSource = ds;
            rd_document.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void BindLODReport()
    {
        BindAssignedComponents();
        BindUnAssignedComponents();
        BindMissingComponents();
    }

    public void BindViewPointsComponents()
    {
        DataSet ds = new DataSet();

        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(conTest);
        con.Open();
        string qry = "select 'VAV-001' as component_name, 'VAV w/Reheat 6in' as component_type";
        qry += " Union all select 'VAV-337' as component_name, 'VAV w/Reheat 6in' as component_type";
        qry += " Union all select 'PUMP-325' as component_name, 'Centrifugal Pump' as component_type";
        qry += " Union all select 'PUMP-854' as component_name, 'Centrifugal Pump' as component_type";
        qry += " Union all select 'VLV-052' as component_name, 'Valve, Backflow' as component_type";
        qry += " Union all select 'VLV-212' as component_name, 'Valve, Backflow' as component_type";
        qry += " Union all select 'VLV-852' as component_name, 'Valve, Backflow' as component_type";
        qry += " Union all select 'Pump-5236' as component_name, 'Cent Pump' as component_type";
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(qry, con);
        System.Data.SqlClient.SqlDataAdapter da = new System.Data.SqlClient.SqlDataAdapter(cmd);
        da.Fill(ds);
        con.Close();

        rd_selected_components.DataSource = ds;
        rd_selected_components.DataBind();
    }

    public void BindAssignedComponents()
    {
        DataSet ds = new DataSet();

        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(conTest);
        con.Open();
        string qry = "select 'Supply Air' as element_id, '21-23 30 60 10' as omniclass_id, 'D3060.10' as uniformat_id, '32' as no_of_components";
        qry += " Union all select 'Return Air' as element_id, '21-23 30 60 20' as omniclass_id, 'D3060.20' as uniformat_id, '85' as no_of_components";
        qry += " Union all select 'Exhaust Air' as element_id, '21-23 30 60 30' as omniclass_id, 'D3060.30' as uniformat_id, '23' as no_of_components";
        qry += " Union all select 'Outside Air' as element_id, '21-23 30 60 40' as omniclass_id, 'D3060.40' as uniformat_id, '27' as no_of_components";
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(qry, con);
        System.Data.SqlClient.SqlDataAdapter da = new System.Data.SqlClient.SqlDataAdapter(cmd);
        da.Fill(ds);
        con.Close();

        rd_assigned_components.DataSource = ds;
        rd_assigned_components.DataBind();
    }

    public void BindUnAssignedComponents()
    {
        DataSet ds = new DataSet();

        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(conTest);
        con.Open();
        string qry = "select 'Pipe 1' as Type, '122' as no_of_components";
        qry += " Union all select 'Pipe 2' as Type, '34' as no_of_components";
        qry += " Union all select 'Valv 6in' as Type, '11' as no_of_components";
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(qry, con);
        System.Data.SqlClient.SqlDataAdapter da = new System.Data.SqlClient.SqlDataAdapter(cmd);
        da.Fill(ds);
        con.Close();

        rd_unassigned_components.DataSource = ds;
        rd_unassigned_components.DataBind();
    }

    public void BindMissingComponents()
    {
        DataSet ds = new DataSet();

        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(conTest);
        con.Open();
        string qry = "select 'Distributed Audio-Video' as element_id, '21-04 60 60 100' as omniclass_id, 'D3060.20' as uniformat_id";
        qry += " Union all select 'Healthcare Communations' as element_id, '21-23 30 60 30' as omniclass_id, 'D3060.30' as uniformat_id";
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(qry, con);
        System.Data.SqlClient.SqlDataAdapter da = new System.Data.SqlClient.SqlDataAdapter(cmd);
        da.Fill(ds);
        con.Close();

        rd_missing_components.DataSource = ds;
        rd_missing_components.DataBind();
    }

    protected void rd_component_ColumnCreated(object sender, GridColumnCreatedEventArgs e)
    {
        if (e.Column is GridGroupSplitterColumn)
        {
            (e.Column as GridGroupSplitterColumn).ExpandImageUrl = "~/App/Images/Icons/asset_carrot_down.png";
            (e.Column as GridGroupSplitterColumn).CollapseImageUrl = "~/App/Images/Icons/asset_carrot_up.png";
        }
    }

    protected void rd_type_ColumnCreated(object sender, GridColumnCreatedEventArgs e)
    {
        if (e.Column is GridGroupSplitterColumn)
        {
            (e.Column as GridGroupSplitterColumn).ExpandImageUrl = "~/App/Images/Icons/asset_carrot_down.png";
            (e.Column as GridGroupSplitterColumn).CollapseImageUrl = "~/App/Images/Icons/asset_carrot_up.png";
        }
    }

    protected void rd_document_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        Bind_Documents("Asset", new Guid("6633e4a4-f583-4e17-b702-84977acd299c"));
    }

    protected void btnAddViewpoint_OnClick(object sender, EventArgs e)
    {

    }

    protected void btnAddWorkorder_OnClick(object sender, EventArgs e)
    {

    }

    protected void btnAddDocument_OnClick(object sender, EventArgs e)
    {

    }
}