using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using EnergyPlus;
using System.Data;
using Telerik.Charting;
using Telerik.Charting.Styles;
using System.Drawing;
using Telerik.Web.UI;

public partial class App_NewUI_EnergyModelingReport : System.Web.UI.Page
{
    string pagesize = "";
    string pageindex = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                lbl_project_name.Text = Convert.ToString(SessionController.Users_.ProfileName);
                lblProjectName.Text = Convert.ToString(SessionController.Users_.ProfileName);
                if (SessionController.Users_.Em_facility_id != null && SessionController.Users_.Profileid != null)
                {
                    BindMonthlySummaryReport();
                    BindSpaceGain();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);
 
    }

    public void BindMonthlySummaryReport()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        { 
            rtvSummaryReport.Nodes.Clear();
            obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            obj_energy_plus_model.pk_profileid = new Guid(SessionController.Users_.Profileid);
            ds = obj_energy_plus_client.Get_Energy_Modeling_Monthly_Summary_Report_Hierarchy(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow[] Rows = ds.Tables[0].Select("ParentId IS NULL"); // Get all parents nodes
                for (int i = 0; i < Rows.Length; i++)
                {
                    TreeNode root = new TreeNode(Rows[i]["Name"].ToString(), Rows[i]["Id"].ToString());
                    root.SelectAction = TreeNodeSelectAction.Expand;
                    CreateNode(root, ds.Tables[0]);
                    rtvSummaryReport.Nodes.Add(root);
                }
            }

                
           
        }
        catch (Exception e)
        { 
         throw e;
        }
    }

    public void CreateNode(TreeNode node, DataTable Dt)
    {
        try
        {
            DataRow[] Rows = Dt.Select("ParentId ='" + node.Value + "'");
            if (Rows.Length == 0) { return; }
            for (int i = 0; i < Rows.Length; i++)
            {
                TreeNode Childnode = new TreeNode(Rows[i]["Name"].ToString(), Rows[i]["Id"].ToString());
                Childnode.SelectAction = TreeNodeSelectAction.Expand;
                Childnode.SelectAction = TreeNodeSelectAction.Select;
                node.ChildNodes.Add(Childnode);
                node.ExpandAll();
                CreateNode(Childnode, Dt);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    public void BindSpaceGain()
    {
         EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
         EnergyPlusModel obj_energy_plus_model= new EnergyPlusModel();
         DataSet ds = new DataSet();

         obj_energy_plus_model.Fk_facility_id =  new Guid(SessionController.Users_.Em_facility_id);
         obj_energy_plus_model.pk_profileid =  new Guid(SessionController.Users_.Profileid);
         ds = obj_energy_plus_client.Get_Energy_Modeling_Space_Gains_Monthly_Report(obj_energy_plus_model, SessionController.ConnectionString);
         if (ds.Tables != null)
         {
             if (ds.Tables[0].Rows.Count > 0)
             {
                 
                 lblProjectName.Text = ds.Tables[0].Rows[0]["ProjectName"].ToString();
                 lbl_project_name.Text = ds.Tables[0].Rows[0]["ProjectName"].ToString();
                 if (ds.Tables[0].Rows[0]["LogoPath"].ToString() != "")
                 {
                     imgProjectLogo.ImageUrl = Server.MapPath(ds.Tables[0].Rows[0]["LogoPath"].ToString());
                 }
                 else
                 {
 
                 }
                 rgBardata.DataSource = ds;
                 rgBardata.DataBind();
                 rgPieData.DataSource = ds;
                 rgPieData.DataBind();
                
                
             }
             else 
             {

             rgBardata.DataSource = string.Empty;
             rgBardata.DataBind();
             rgPieData.DataSource = string.Empty;
             rgPieData.DataBind();

             }
             BindBarChartGraph();
             BindPieChartGraph();
         }
    }

    private void BindBarChartGraph()
    {
        try
        {
            EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
            EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
            DataSet ds = new DataSet();
            chrtBars.Chart.Series.Clear();
            obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id); // new Guid("9a029933-ac8e-41f6-bd06-5426798e6a64");// 
            obj_energy_plus_model.pk_profileid = new Guid(SessionController.Users_.Profileid);  //new Guid(SessionController.Users_.Profileid);
            ds = obj_energy_plus_client.Get_Energy_Modeling_Space_Gains_Monthly_Report(obj_energy_plus_model, SessionController.ConnectionString);
           
             if (ds.Tables.Count > 0)
            {
                ds.Tables[0].Columns.Remove("LogoPath");
                ds.Tables[0].Columns.Remove("ProjectName");
                   ds.Tables[0].Columns.Remove("pk_floor_id");
                   ds.Tables[0].Columns.Remove("pk_space_id");
                 
                     
                if (ds.Tables[0].Rows.Count > 0)
                {

                    for (int i = 1; i < ds.Tables[0].Columns.Count; i++)
                    {
                        ChartSeries series = new ChartSeries();
                        series.DataYColumn = ds.Tables[0].Columns[i].ColumnName;
                        series.Name = ds.Tables[0].Columns[i].ColumnName;
                        series.Appearance.ShowLabels = true;
                        series.Appearance.FillStyle.MainColor = System.Drawing.Color.Goldenrod;
                        series.Appearance.FillStyle.SecondColor = System.Drawing.Color.DarkGoldenrod;
                        series.Type = ChartSeriesType.Bar;
                        chrtBars.AddChartSeries(series);
                       
                    }
                    chrtBars.DataSource = ds;
                    chrtBars.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void BindPieChartGraph()
    {
        try
        {
            EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
            EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
            DataSet ds = new DataSet();
            chrtPie.Chart.Series.Clear();
            obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            obj_energy_plus_model.pk_profileid = new Guid(SessionController.Users_.Profileid);
            ds = obj_energy_plus_client.Get_Energy_Modeling_Space_Gains_Monthly_Report(obj_energy_plus_model, SessionController.ConnectionString);

            chrtPie.DataSource = ds;

            this.chrtPie.Series.Add(new ChartSeries { DataYColumn = "value", DataLabelsColumn = "name", Type = ChartSeriesType.Pie, });

            this.chrtPie.Series[0].Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.ItemLabels;
            this.chrtPie.Series[0].Appearance.ShowLabels = false;

            this.chrtPie.BeforeLayout += chrtPie_BeforeLayout;
            this.chrtPie.DataBind();
             
            
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    void chrtPie_BeforeLayout(object sender, EventArgs e)
    {
        for (int i = 0; i < this.chrtPie.Legend.Items.Count; i++)
        {
            var legendItemLabel = this.chrtPie.Legend.Items[i].TextBlock.Text;

            legendItemLabel = legendItemLabel.ToString();

            this.chrtPie.Legend.Items[i].TextBlock.Text = legendItemLabel;
        }
    }
    protected void rtvSummaryReport_SelectedNodeChanged(object sender, EventArgs e)
    {
        try
        {
            string value = rtvSummaryReport.SelectedNode.Value;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rgBardata_OnPageIndexChanged(object source, GridPageChangedEventArgs e)
    {
       BindSpaceGain();
    }
    protected void rgPieData_OnPageIndexChanged(object source, GridPageChangedEventArgs e)
    {
       BindSpaceGain();
    }
    protected void rgPieData_OnPageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        BindSpaceGain();
    }
    protected void rgBardata_OnPageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
      
        BindSpaceGain();
    }



}