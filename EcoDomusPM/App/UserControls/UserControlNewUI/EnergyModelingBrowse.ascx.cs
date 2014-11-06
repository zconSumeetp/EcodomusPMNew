using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Charting;
using System.Data;
using EnergyPlus;
using EcoDomus.Session;

public partial class App_UserControls_UserControlNewUI_EnergyModelingBrowse : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btn_update_data_Click(object sender, EventArgs e)
    {
        try
        {
            //DateTime rdtp_start = rdtp_st;
            DateTime date_from = Convert.ToDateTime(rdtp_start.SelectedDate);
            DateTime date_to = Convert.ToDateTime(rdtp_end.SelectedDate);
            BindSimBASComparisonGraph();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void BindSimBASComparisonGraph()
    {
        try
        {
            EnergyPlusClient obj_enery_plus_client = new EnergyPlusClient();
            EnergyPlusModel obj_enery_plus_model = new EnergyPlusModel();
            DataSet ds = new DataSet();
            obj_enery_plus_model.Asset_id = new Guid("07ACD74A-D4FC-40D3-B9C0-EDCCEEBC8326");
            obj_enery_plus_model.FrmTimeStmp = Convert.ToDateTime(rdtp_start.SelectedDate);
            obj_enery_plus_model.ToTimeStmp = Convert.ToDateTime(rdtp_end.SelectedDate);
            obj_enery_plus_model.attributeids = "C687EABA-73F6-44D9-8640-130BB25FB471,A2286C11-13BE-45FC-AAF9-38AEF14CD8C8,1324349F-43A4-4993-BAFB-6066221DF03E,4F895C74-3496-4F50-A08E-66B403D64BF0,A9CDDA8F-66C2-47A2-89D5-7FD8A15C3289,189B3BF9-61F1-4B75-887B-8D66D9D6F415";
            ds = obj_enery_plus_client.Get_Simulation_BAS_Attribute_Series(obj_enery_plus_model, SessionController.ConnectionString);
            if (ds.Tables.Count > 0)
            {
                rc_linechart.Clear();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (int i = 1; i < ds.Tables[0].Columns.Count; i++)
                    {
                        ChartSeries series = new ChartSeries();
                        series.DataYColumn = ds.Tables[0].Columns[i].ColumnName;
                        series.Name = ds.Tables[0].Columns[i].ColumnName;
                        series.Appearance.ShowLabels = false;
                        series.Type = ChartSeriesType.Line;
                        rc_linechart.AddChartSeries(series);
                    }
                    rc_linechart.DataSource = ds;
                    rc_linechart.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
}