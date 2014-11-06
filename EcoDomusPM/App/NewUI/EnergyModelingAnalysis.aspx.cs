using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using EnergyPlus;
using System.Data;
using Telerik.Web.UI;

public partial class App_NewUI_EnergyModelingAnalysis : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_update_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime dt_from = rdtp_from.SelectedDate.Value;
            DateTime date_from = Convert.ToDateTime(rdtp_from.SelectedDate);
            DateTime date_to = Convert.ToDateTime(rdtp_to.SelectedDate);
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
            DataTable dt = new DataTable();
            DataColumn col = new DataColumn("time_stamp");
            col.DataType = typeof(string);
            dt.Columns.Add(col);
            col = new DataColumn("AttributeValue");
            col.DataType = typeof(string);
            dt.Columns.Add(col);

            obj_enery_plus_model.Asset_id = new Guid("07ACD74A-D4FC-40D3-B9C0-EDCCEEBC8326");
            obj_enery_plus_model.FrmTimeStmp = Convert.ToDateTime(rdtp_from.SelectedDate);
            obj_enery_plus_model.ToTimeStmp = Convert.ToDateTime(rdtp_to.SelectedDate);
            obj_enery_plus_model.attributeids = "C687EABA-73F6-44D9-8640-130BB25FB471";
            ds = obj_enery_plus_client.Get_Simulation_BAS_Attribute_Series(obj_enery_plus_model, SessionController.ConnectionString);
           

            rc_linechart.DataSource = ds;
            rc_linechart.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rc_linechart_ItemDataBound(object sender, Telerik.Charting.ChartItemDataBoundEventArgs e)
    {
        try
        {
            if (((DataRowView)e.DataItem)["time_stamp1"] != null && ((DataRowView)e.DataItem)["time_stamp1"] != "")
            {
                e.SeriesItem.ActiveRegion.Tooltip += "[" + ((DataRowView)e.DataItem)["time_stamp1"] + " : " + String.Format("{0:0.00}", e.SeriesItem.YValue) + "]";
            }
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
        //if (e.SeriesItem.YValue > 30)
        //{
        //    e.SeriesItem.ActiveRegion.Tooltip = "Attention! Temperature too high! " + '\n';
        //}
        //else if (e.SeriesItem.YValue < 10)
        //{
        //    e.SeriesItem.ActiveRegion.Tooltip = "Attention! Temperature too low! " + '\n';
        //}
       
    }

    protected void rtv_entity_NodeClick(object sender, RadTreeNodeEventArgs e)
    {
        try
        {
            //if (rtv_entity.SelectedNode.ParentNode != null)
            //{
            //    string val = rtv_entity.SelectedNode.Value;
            //    string node_text = rtv_entity.SelectedNode.Text;
            //    lbl_name.Text = node_text;
            //}
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rcm_performance_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        try
        {
            lbl_performance.Text = rcm_performance.SelectedItem.Value;
            //BindToDataSet(rtv_entity);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    void BindToDataSet(RadTreeView rtv_entity)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            if (SessionController.Users_.Em_facility_id != null && SessionController.Users_.Profileid != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                obj_energy_plus_model.pk_profileid = new Guid(SessionController.Users_.Profileid);
                ds = obj_energy_plus_client.Get_Energy_Modeling_Spatial_Hierarchy(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    rtv_entity.DataTextField = "Name";
                    rtv_entity.DataFieldID = "ID";
                    rtv_entity.DataValueField = "ID";
                    rtv_entity.DataFieldParentID = "ParentId";

                    rtv_entity.DataSource = ds;
                    rtv_entity.DataBind();
                    rtv_entity.ExpandAllNodes();
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
}