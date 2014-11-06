using System;

using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;

using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

using EnergyPlus;
using EcoDomus.Session;
using EcoDomus_Analysis;

using Telerik.Web.UI;
using Telerik.Charting;

using System.Web.UI.DataVisualization.Charting;
using System.Drawing;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Text;

public partial class App_UserControls_UserControlNewUI_EnergyModelingComparision : System.Web.UI.UserControl
{
    public class ChartDataItem
    {
        public string pk_result_id;
        public string s_facility_id;
        public string s_project_id;
        public string s_simulation_id;
        public string sIDD_Class;
        public string sIDD_Class_Field;
        public string s_zone_id;
        public string s_zone_name;
        public string sOmni_Class;
        public string sAsset_Attribute_Name;
        public string sTagName;
        public string s_asset_attribute_id;
        public double dPerformanceValue;
        public double dTolerance;
        public DateTime start_date;
        public DateTime end_date;
        public string sConnectionString;

        public ChartDataItem()
        {
            pk_result_id = "";
            s_facility_id = "";
            s_project_id = "";
            s_simulation_id = "";
            sIDD_Class = "";
            sIDD_Class_Field = "";
            s_zone_id = "";
            s_zone_name = "";
            sOmni_Class = "";
            sAsset_Attribute_Name = "";
            sTagName = "";
            s_asset_attribute_id = "";
            dPerformanceValue = 0.0f;
            dTolerance = 0.0f;
            sConnectionString = "";
        }
    }

    public struct MyValuePairStruct
    {
        private string _sKey;
        public string sKey
        {
            get { return _sKey; }
            set { _sKey = value; }
        }
        private string _sValue;
        public string sValue
        {
            get { return _sValue; }
            set { _sValue = value; }
        }
    }

    static ChartDataItem last_chart_data = new ChartDataItem();
    SQL_Data_Connection ecodomus_client = new SQL_Data_Connection();
    static bool bShow_AAS = false;

    private List<string> FavouriteCustomerList = new List<string>();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                ViewState["TreeData"] = null;
                rdtp_from.SelectedDate = DateTime.Now.AddHours(-24);
                rdtp_to.SelectedDate = DateTime.Now;
                BindSpatialTreeView(rtv_entity);
                BindImpactDetailsGrid(lbl_AAS.Text);
                bindWeatherSource();
                rc_linechart.DataSource = null;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        else
        {
            
        }
    }

    private void bindWeatherSource()
    {
        try
        {

            EnergyPlusClient obj_enery_plus_client = new EnergyPlusClient();
            EnergyPlusModel obj_enery_plus_model = new EnergyPlusModel();
            DataSet ds = new DataSet();
            ds = obj_enery_plus_client.Get_energymodeling_weather_sources(obj_enery_plus_model, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                rcb_weather_source.DataTextField = "stationName";
                rcb_weather_source.DataValueField = "pk_bas_weather_station_id";
                rcb_weather_source.DataSource = ds;
                rcb_weather_source.DataBind();
            }

        }
        catch (Exception ex)
        {

        }

    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        try
        {
            BindImpactDetailsGrid(lbl_AAS.Text);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void BindSimEMGraph()
    {
        try
        {
            bool bPerfCharted = false;
            double dMax = -10000000000.0f;
            double dMin = 10000000000.0f;
            Guid weatherSourceId = Guid.Empty;
            string strSQLQuery = "";

            long zReportVariableDataDictionaryIndex = 0;
            long zReportMeterDataDictionaryIndex = 0;

            string zVariableType;
            string zIndexGroup;
            string zTimestepType;
            string zKeyValue;
            string zVariableName;
            string zReportingFrequency;
            string zVariableUnits;

            EcoDomus_Analysis.Performance_Analysis.ConvertTemp ct = new Performance_Analysis.ConvertTemp();
            string sDesiredUnits = rcb_unit.SelectedItem.Value.ToUpper();

            EnergyPlusClient obj_enery_plus_client = new EnergyPlusClient();
            EnergyPlusModel obj_enery_plus_model = new EnergyPlusModel();

            rc_linechart.ChartAreas[0].AxisX.IsMarginVisible = false;
            rc_linechart.ChartAreas[0].Area3DStyle.Enable3D = false;
            rc_linechart.ChartAreas[0].AxisX.LabelStyle.IsEndLabelVisible = true;
            rc_linechart.AntiAliasing = AntiAliasingStyles.All;
            rc_linechart.TextAntiAliasingQuality = TextAntiAliasingQuality.High;
            rc_linechart.ChartAreas[0].AxisX.LabelAutoFitStyle = LabelAutoFitStyles.LabelsAngleStep30;
            rc_linechart.ChartAreas[0].AxisX.LabelStyle.Format = "MM/dd/yyyy HH:mm";
            rc_linechart.ChartAreas[0].AxisY.LabelStyle.Format = "0.0";

            string sConnectionString = obj_enery_plus_client.Get_Connection_String(obj_enery_plus_model, SessionController.ConnectionString) + ";MultipleActiveResultSets=True;"; //@"Data Source=ZCON-79\SQL2008R2;Initial Catalog=GSAR3;User Id=sa;Password=zcon@123;MultipleActiveResultSets=True;";
            ecodomus_client.sql_connection.ConnectionString = sConnectionString;

            if (ecodomus_client.ConnectClientDatabase())
            {
                foreach (TreeNode node in rtv_entity.CheckedNodes)
                {
                    zVariableUnits = "";

                    if (node.Value.StartsWith("[ATTRIBUTE]"))
                    {
                        // attribute_node.Value = "[ATTRIBUTE]" + ecodomus_client.sql_reader["pk_asset_attribute_id"].ToString() + ",[TAGNAME]" + tag_name;
                        string[] strParams = node.Value.ToString().Split(',');
                        string attribute_id = strParams[0].Replace("[ATTRIBUTE]", "");
                        string tag_name = strParams[1].Replace("[TAGNAME]", "");
                        string strChartLabel = strParams[2].Replace("[CHART_LABEL]", "");
                        string strUnits = strParams[3].Replace("[UNITS]", "");

                        strChartLabel += " (" + strUnits + ")";

                        rc_linechart.Series.Add(strChartLabel);
                        rc_linechart.Series[strChartLabel].ChartType = SeriesChartType.Line;
                        rc_linechart.Series[strChartLabel].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series[strChartLabel].BorderWidth = 2;
                        rc_linechart.Legends.Add(strChartLabel);
                        rc_linechart.Legends[strChartLabel].Docking = Docking.Bottom;
                        rc_linechart.Legends[strChartLabel].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends[strChartLabel].TableStyle = LegendTableStyle.Wide;
                        
                        // query and graph the BAS data ----------------------------------------------------
                        strSQLQuery = "SELECT [tag_name] ";
                        strSQLQuery += ",[time_stamp] ";
                        strSQLQuery += ",[day] ";
                        strSQLQuery += ",[month] ";
                        strSQLQuery += ",[year] ";
                        strSQLQuery += ",[dayofyear] ";
                        strSQLQuery += ",[current_value] ";
                        strSQLQuery += ",[last_value] ";
                        strSQLQuery += ",[delta] ";
                        strSQLQuery += ",[quality] ";
                        strSQLQuery += "FROM [tbl_bas_attribute_history] ";
                        strSQLQuery += "WHERE [tag_name] = '" + tag_name + "' ";
                        strSQLQuery += "AND [time_stamp] >= '" + Convert.ToDateTime(rdtp_from.SelectedDate) + "' AND [time_stamp] <= '" + Convert.ToDateTime(rdtp_to.SelectedDate) + "' ORDER BY [time_stamp] asc";

                        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                        ecodomus_client.sql_command.CommandText = strSQLQuery;
                        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                        while (ecodomus_client.sql_reader.Read())
                        {
                            double dRaw = double.Parse(ecodomus_client.sql_reader["current_value"].ToString());
                            double dVal;

                            // if the units are C, convert the BAS data to deg C.
                            //if (sDesiredUnits == "C")
                            //    dVal = ct.ConvertFahrenheitToCelsius((float)dRaw);
                            //else
                                dVal = dRaw;

                            if (dVal > dMax)
                                dMax = dVal;
                            if (dVal < dMin)
                                dMin = dVal;

                            DateTime dt = DateTime.Parse(ecodomus_client.sql_reader["time_stamp"].ToString());
                            rc_linechart.Series[strChartLabel].Points.AddXY(Convert.ToDateTime(dt), dVal);
                        }
                        ecodomus_client.sql_reader.Close();

                    }
                    
                    if (node.Value.StartsWith("[ZONE_ID]"))
                    {
                        string zone_attribute = "";
                        string zone_id = "";
                        string strChartLabel = "";
                        string[] strParams = node.Value.ToString().Split(',');

                        // split the id and variable name
                        Guid Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);

                        zone_id = strParams[0].Replace("[ZONE_ID]", "");
                        zone_attribute = strParams[1].Replace("[ZONE_VARIABLE]", "");
                        strChartLabel = strParams[2].Replace("[CHART_LABEL]", "");

                        // query for the zone details From Report Variable Data Dictionary
                        strSQLQuery = "SELECT [fk_facility_id] ";
                        strSQLQuery += ",[ReportVariableDataDictionaryIndex] ";
                        strSQLQuery += ",[VariableType] ";
                        strSQLQuery += ",[IndexGroup] ";
                        strSQLQuery += ",[TimestepType] ";
                        strSQLQuery += ",[KeyValue] ";
                        strSQLQuery += ",[VariableName] ";
                        strSQLQuery += ",[ReportingFrequency] ";
                        strSQLQuery += ",[VariableUnits] ";
                        strSQLQuery += "FROM [tbl_energymodeling_ReportVariableDataDictionary] ";
                        strSQLQuery += "WHERE [fk_zone_id] = '" + zone_id + "' ";
                        strSQLQuery += "AND [VariableName] = '" + zone_attribute + "'";

                        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                        ecodomus_client.sql_command.CommandText = strSQLQuery;
                        ecodomus_client.sql_command.CommandTimeout = 120;
                        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                        while (ecodomus_client.sql_reader.Read())
                        {
                            zReportVariableDataDictionaryIndex = long.Parse(ecodomus_client.sql_reader["ReportVariableDataDictionaryIndex"].ToString());
                            zVariableType = ecodomus_client.sql_reader["VariableType"].ToString();
                            zIndexGroup = ecodomus_client.sql_reader["IndexGroup"].ToString();
                            zTimestepType = ecodomus_client.sql_reader["TimestepType"].ToString();
                            zKeyValue = ecodomus_client.sql_reader["KeyValue"].ToString();
                            zVariableName = ecodomus_client.sql_reader["VariableName"].ToString();
                            zReportingFrequency = ecodomus_client.sql_reader["ReportingFrequency"].ToString();
                            zVariableUnits = ecodomus_client.sql_reader["VariableUnits"].ToString();
                            break;
                        }
                        ecodomus_client.sql_reader.Close();

                        strChartLabel.Trim();
                        strChartLabel += " (" + zVariableUnits + ")";

                        rc_linechart.Series.Add(strChartLabel);
                        rc_linechart.Series[strChartLabel].ChartType = SeriesChartType.Line;
                        rc_linechart.Series[strChartLabel].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series[strChartLabel].BorderWidth = 2;
                        rc_linechart.Legends.Add(strChartLabel);
                        rc_linechart.Legends[strChartLabel].Docking = Docking.Bottom;
                        rc_linechart.Legends[strChartLabel].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends[strChartLabel].TableStyle = LegendTableStyle.Wide;

                        string zProjectID = SessionController.Users_.Profileid.ToString();

                        strSQLQuery = "SELECT [VariableValue] ";
                        strSQLQuery += ",[Month] ";
                        strSQLQuery += ",[Day] "; 
                        strSQLQuery += ",[Hour] "; 
                        strSQLQuery += ",[Minute] "; 
                        strSQLQuery += ",[DayType] "; 
                        strSQLQuery += "FROM [tbl_energymodeling_ReportVariableData] "; 
                        strSQLQuery += "INNER JOIN [tbl_energymodeling_Time] on [tbl_energymodeling_ReportVariableData].TimeIndex = [tbl_energymodeling_Time].TimeIndex ";
                        strSQLQuery += "WHERE [fk_zone_id] = '" + zone_id + "' ";
                        strSQLQuery += "AND [tbl_energymodeling_ReportVariableData].[fk_project_id] = '" + zProjectID + "' ";
                        strSQLQuery += "AND [MONTH] BETWEEN " + Convert.ToInt32(rdtp_from.SelectedDate.Value.Month) + " AND " + Convert.ToInt32(rdtp_to.SelectedDate.Value.Month) + " ";
                        strSQLQuery += "AND [DAY] BETWEEN " + Convert.ToInt32(rdtp_from.SelectedDate.Value.Day) + " AND " + Convert.ToInt32(rdtp_to.SelectedDate.Value.Day) + " ";
                        strSQLQuery += "AND [ReportVariableDataDictionaryIndex] = " + zReportVariableDataDictionaryIndex + " ";
                        strSQLQuery += "ORDER BY [Month], [Day], [Hour], [Minute]";

                        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                        ecodomus_client.sql_command.CommandText = strSQLQuery;
                        ecodomus_client.sql_command.CommandTimeout = 240;
                        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                        double[] dValues = new double[1];
                        string[] dtValues = new string[1];

                        while (ecodomus_client.sql_reader.Read())
                        {
                            double dRaw = double.Parse(ecodomus_client.sql_reader["VariableValue"].ToString());
                            double dVal;

                            // if the units are F, convert the energy modeling data to deg f.
                            //if (sDesiredUnits == "F")
                            //    dVal = ct.ConvertCelsiusToFahrenheit((float)dRaw);
                            //else
                                dVal = dRaw;

                            if (dVal > dMax)
                                dMax = dVal;
                            if (dVal < dMin)
                                dMin = dVal;

                            string sMonth = string.Format("{0:00}", ecodomus_client.sql_reader["Month"]);
                            string sDay = string.Format("{0:00}", ecodomus_client.sql_reader["Day"]);
                            string sHour = string.Format("{0:00}", int.Parse(ecodomus_client.sql_reader["Hour"].ToString()) - 1);
                            string sMinute = string.Format("{0:00}", ecodomus_client.sql_reader["Minute"]);
                            string sYear = rdtp_from.SelectedDate.Value.Year.ToString();
                            DateTime dt = DateTime.Parse(sMonth + "/" + sDay + "/" + sYear + " " + sHour + ":" + sMinute + ":00");
                            
                            if ((dt >= Convert.ToDateTime(rdtp_from.SelectedDate)) && (dt <= Convert.ToDateTime(rdtp_to.SelectedDate)))
                            {
                                rc_linechart.Series[strChartLabel].Points.AddXY(Convert.ToDateTime(dt), dVal);
                            }
                        }
                        ecodomus_client.sql_reader.Close();                        
                    }

                    if (node.Value.StartsWith("[METER]"))
                    {
                        string[] strParams = node.Value.ToString().Split(',');
                        string MeterName = strParams[0].Replace("[METER]", "");
                        string Report_Freq = strParams[1].Replace("[REPORT_FREQ]", "");
                        string strChartLabel = MeterName.ToString() + " - " + Report_Freq.ToString();
                        Guid Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);

                        // query for the meter details From Meter Variable Data Dictionary
                        strSQLQuery = "SELECT [fk_facility_id] ";
                        strSQLQuery += ",[fk_project_id] ";
                        strSQLQuery += ",[fk_simulation_id] ";
                        strSQLQuery += ",[ReportMeterDataDictionaryIndex] ";
                        strSQLQuery += ",[VariableType] ";
                        strSQLQuery += ",[IndexGroup] ";
                        strSQLQuery += ",[TimestepType] ";
                        strSQLQuery += ",[KeyValue] ";
                        strSQLQuery += ",[VariableName] ";
                        strSQLQuery += ",[ReportingFrequency] ";
                        strSQLQuery += ",[VariableUnits] ";
                        strSQLQuery += "FROM [tbl_energymodeling_ReportMeterDataDictionary] ";
                        strSQLQuery += "WHERE [fk_facility_id] = '" + Fk_facility_id + "' ";
                        strSQLQuery += "AND [VariableName] = '" + MeterName + "'";

                        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                        ecodomus_client.sql_command.CommandText = strSQLQuery;
                        ecodomus_client.sql_command.CommandTimeout = 120;
                        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                        while (ecodomus_client.sql_reader.Read())
                        {
                            zReportMeterDataDictionaryIndex = long.Parse(ecodomus_client.sql_reader["ReportMeterDataDictionaryIndex"].ToString());
                            zVariableType = ecodomus_client.sql_reader["VariableType"].ToString();
                            zIndexGroup = ecodomus_client.sql_reader["IndexGroup"].ToString();
                            zTimestepType = ecodomus_client.sql_reader["TimestepType"].ToString();
                            zKeyValue = ecodomus_client.sql_reader["KeyValue"].ToString();
                            zVariableName = ecodomus_client.sql_reader["VariableName"].ToString();
                            zReportingFrequency = ecodomus_client.sql_reader["ReportingFrequency"].ToString();
                            zVariableUnits = ecodomus_client.sql_reader["VariableUnits"].ToString();
                            break;
                        }
                        ecodomus_client.sql_reader.Close();

                        strChartLabel.Trim();
                        strChartLabel += " (" + zVariableUnits + ")";

                        rc_linechart.Series.Add(strChartLabel);
                        rc_linechart.Series[strChartLabel].ChartType = SeriesChartType.Line;
                        rc_linechart.Series[strChartLabel].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series[strChartLabel].BorderWidth = 2;
                        rc_linechart.Legends.Add(strChartLabel);
                        rc_linechart.Legends[strChartLabel].Docking = Docking.Bottom;
                        rc_linechart.Legends[strChartLabel].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends[strChartLabel].TableStyle = LegendTableStyle.Wide;

                        // query and graph the energy modeling meter data ----------------------------------------------------
                        strSQLQuery = "SELECT [tbl_energymodeling_ReportMeterData].[ReportMeterDataDictionaryIndex] ";
                        strSQLQuery += ",[VariableValue] ";
                        strSQLQuery += ",[Month] ";
                        strSQLQuery += ",[Day] ";
                        strSQLQuery += ",[Hour] ";
                        strSQLQuery += ",[Minute] ";
                        strSQLQuery += ",[Interval] ";
                        strSQLQuery += ",[IntervalType] ";
                        strSQLQuery += ",[SimulationDays] ";
                        strSQLQuery += ",[DayType] ";
                        strSQLQuery += ",[EnvironmentPeriodIndex] ";
                        strSQLQuery += ",[VariableType] ";
                        strSQLQuery += ",[IndexGroup] ";
                        strSQLQuery += ",[TimestepType] ";
                        strSQLQuery += ",[VariableName] ";
                        strSQLQuery += ",[ReportingFrequency] ";
                        strSQLQuery += ",[VariableUnits] ";
                        strSQLQuery += "FROM [tbl_energymodeling_ReportMeterData] ";
                        strSQLQuery += "INNER JOIN [tbl_energymodeling_Time] on [tbl_energymodeling_ReportMeterData].TimeIndex = [tbl_energymodeling_Time].TimeIndex ";
                        strSQLQuery += "INNER JOIN [tbl_energymodeling_ReportMeterDataDictionary] ON [tbl_energymodeling_ReportMeterData].ReportMeterDataDictionaryIndex = [tbl_energymodeling_ReportMeterDataDictionary].ReportMeterDataDictionaryIndex ";
                        strSQLQuery += "WHERE [tbl_energymodeling_ReportMeterDataDictionary].[fk_facility_id] = '" + Fk_facility_id.ToString() + "' ";
                        strSQLQuery += "AND [tbl_energymodeling_ReportMeterDataDictionary].[VariableName] = '" + MeterName.ToString() + "' ";
                        strSQLQuery += "AND [tbl_energymodeling_ReportMeterDataDictionary].[ReportingFrequency] = '" + Report_Freq.ToString() + "' ";
                        strSQLQuery += "ORDER BY [tbl_energymodeling_ReportMeterData].[ReportMeterDataDictionaryIndex], [Month] ,[Day] ,[Hour] ,[Minute]";

                        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                        ecodomus_client.sql_command.CommandText = strSQLQuery;
                        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                        double[] dValues = new double[1];
                        string[] dtValues = new string[1];

                        while (ecodomus_client.sql_reader.Read())
                        {
                            double dRaw = double.Parse(ecodomus_client.sql_reader["VariableValue"].ToString());
                            double dVal;

                            // if the units are F, convert the energy modeling data to deg f.
                            //if (sDesiredUnits == "F")
                            //    dVal = ct.ConvertCelsiusToFahrenheit((float)dRaw);
                            //else
                                dVal = dRaw;

                            if (dVal > dMax)
                                dMax = dVal;
                            if (dVal < dMin)
                                dMin = dVal;

                            string sMonth = string.Format("{0:00}", ecodomus_client.sql_reader["Month"]);
                            string sDay = string.Format("{0:00}", ecodomus_client.sql_reader["Day"]);
                            string sHour = string.Format("{0:00}", int.Parse(ecodomus_client.sql_reader["Hour"].ToString()) - 1);
                            string sMinute = string.Format("{0:00}", ecodomus_client.sql_reader["Minute"]);

                            string sYear = rdtp_from.SelectedDate.Value.Year.ToString();

                            DateTime dt = DateTime.Parse(sMonth + "/" + sDay + "/" + sYear + " " + sHour + ":" + sMinute + ":00");

                            if ((dt >= Convert.ToDateTime(rdtp_from.SelectedDate)) && (dt <= Convert.ToDateTime(rdtp_to.SelectedDate)))
                            {
                                rc_linechart.Series[strChartLabel].Points.AddXY(Convert.ToDateTime(dt), dVal);
                            }
                        }
                        ecodomus_client.sql_reader.Close();
                        
                    }

                    if (node.Value.StartsWith("[PERFORMANCE_RESULT]"))
                    {
                        string value = node.Value.Replace("[PERFORMANCE_RESULT]", "").ToString();
                        if (!value.Equals(""))
                        {
                            GraphPerformanceResultByID(value, Convert.ToDateTime(rdtp_from.SelectedDate), Convert.ToDateTime(rdtp_to.SelectedDate));
                            bPerfCharted = true;
                        }
                    }
                }

                // add the weather ?
                // query and graph the weather data ----------------------------------------------------
                string weatherdatavalues = "";
                string Station_Name = "";
                string Station_ID = "";

                for (int k = 0; k < rcb_weather_source.CheckedItems.Count; k++)
                {
                    if (rcb_weather_source.CheckedItems[k].Checked == true)
                    {
                        weatherSourceId = new Guid(rcb_weather_source.CheckedItems[k].Value);
                        Station_Name = rcb_weather_source.CheckedItems[k].Text.ToString();
                        Station_ID = rcb_weather_source.CheckedItems[k].Text.Substring(0, 4);
                    }
                }

                for (int k = 0; k < rcb_weather_data.CheckedItems.Count; k++)
                {
                    weatherdatavalues = weatherdatavalues + rcb_weather_data.CheckedItems[k].Value + ",";
                }

                if (weatherdatavalues != "")
                    weatherdatavalues = weatherdatavalues.TrimEnd(',');

                if (weatherSourceId != Guid.Empty && weatherdatavalues != "")
                {
                    strSQLQuery = "SELECT [station_id] ";
                    strSQLQuery += ",[timestamp_local] ";
                    strSQLQuery += ",[weather] ";

                    if (rcb_weather_data.Items[0].Checked == true)
                    {
                        strSQLQuery += ",[temp_c] ";
                        rc_linechart.Series.Add("temp_c");
                        rc_linechart.Legends.Add("temp_c");
                        rc_linechart.Legends["temp_c"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["temp_c"].Docking = Docking.Bottom;
                        rc_linechart.Series["temp_c"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["temp_c"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["temp_c"].BorderWidth = 2;
                        rc_linechart.Series["temp_c"].XAxisType = AxisType.Secondary;
                    }

                    if (rcb_weather_data.Items[1].Checked == true)
                    {
                        strSQLQuery += ",[temp_f] ";
                        rc_linechart.Series.Add("temp_f");
                        rc_linechart.Legends.Add("temp_f");
                        rc_linechart.Legends["temp_f"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["temp_f"].Docking = Docking.Bottom;
                        rc_linechart.Series["temp_f"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["temp_f"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["temp_f"].BorderWidth = 2;
                        rc_linechart.Series["temp_f"].XAxisType = AxisType.Secondary;
                    }


                    if (rcb_weather_data.Items[2].Checked == true)
                    {
                        strSQLQuery += ",[relative_humidity] ";
                        rc_linechart.Series.Add("relative_humidity");
                        rc_linechart.Legends.Add("relative_humidity");
                        rc_linechart.Legends["relative_humidity"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["relative_humidity"].Docking = Docking.Bottom;
                        rc_linechart.Series["relative_humidity"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["relative_humidity"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["relative_humidity"].BorderWidth = 2;
                        rc_linechart.Series["relative_humidity"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[3].Checked == true)
                    {
                        strSQLQuery += ",[wind_degrees] ";
                        rc_linechart.Series.Add("wind_degrees");
                        rc_linechart.Legends.Add("wind_degrees");
                        rc_linechart.Legends["wind_degrees"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["wind_degrees"].Docking = Docking.Bottom;
                        rc_linechart.Series["wind_degrees"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["wind_degrees"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["wind_degrees"].BorderWidth = 2;
                        rc_linechart.Series["wind_degrees"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[4].Checked == true)
                    {
                        strSQLQuery += ",[wind_mph] ";
                        rc_linechart.Series.Add("wind_mph");
                        rc_linechart.Legends.Add("wind_mph");
                        rc_linechart.Legends["wind_mph"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["wind_mph"].Docking = Docking.Bottom;
                        rc_linechart.Series["wind_mph"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["wind_mph"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["wind_mph"].BorderWidth = 2;
                        rc_linechart.Series["wind_mph"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[5].Checked == true)
                    {
                        strSQLQuery += ",[wind_gust_mph] ";
                        rc_linechart.Series.Add("wind_gust_mph");
                        rc_linechart.Legends.Add("wind_gust_mph");
                        rc_linechart.Legends["wind_gust_mph"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["wind_gust_mph"].Docking = Docking.Bottom;
                        rc_linechart.Series["wind_gust_mph"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["wind_gust_mph"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["wind_gust_mph"].BorderWidth = 2;
                        rc_linechart.Series["wind_gust_mph"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[6].Checked == true)
                    {
                        strSQLQuery += ",[wind_kt] ";
                        rc_linechart.Series.Add("wind_kt");
                        rc_linechart.Legends.Add("wind_kt");
                        rc_linechart.Legends["wind_kt"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["wind_kt"].Docking = Docking.Bottom;
                        rc_linechart.Series["wind_kt"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["wind_kt"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["wind_kt"].BorderWidth = 2;
                        rc_linechart.Series["wind_kt"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[7].Checked == true)
                    {
                        strSQLQuery += ",[wind_gust_kt] ";
                        rc_linechart.Series.Add("wind_gust_kt");
                        rc_linechart.Legends.Add("wind_gust_kt");
                        rc_linechart.Legends["wind_gust_kt"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["wind_gust_kt"].Docking = Docking.Bottom;
                        rc_linechart.Series["wind_gust_kt"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["wind_gust_kt"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["wind_gust_kt"].BorderWidth = 2;
                        rc_linechart.Series["wind_gust_kt"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[8].Checked == true)
                    {
                        strSQLQuery += ",[pressure_mb] ";
                        rc_linechart.Series.Add("pressure_mb");
                        rc_linechart.Legends.Add("pressure_mb");
                        rc_linechart.Legends["pressure_mb"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["pressure_mb"].Docking = Docking.Bottom;
                        rc_linechart.Series["pressure_mb"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["pressure_mb"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["pressure_mb"].BorderWidth = 2;
                        rc_linechart.Series["pressure_mb"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[9].Checked == true)
                    {
                        strSQLQuery += ",[pressure_in] ";
                        rc_linechart.Series.Add("pressure_in");
                        rc_linechart.Legends.Add("pressure_in");
                        rc_linechart.Legends["pressure_in"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["pressure_in"].Docking = Docking.Bottom;
                        rc_linechart.Series["pressure_in"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["pressure_in"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["pressure_in"].BorderWidth = 2;
                        rc_linechart.Series["pressure_in"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[10].Checked == true)
                    {
                        strSQLQuery += ",[dewpoint_f] ";
                        rc_linechart.Series.Add("dewpoint_f");
                        rc_linechart.Legends.Add("dewpoint_f");
                        rc_linechart.Legends["dewpoint_f"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["dewpoint_f"].Docking = Docking.Bottom;
                        rc_linechart.Series["dewpoint_f"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["dewpoint_f"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["dewpoint_f"].BorderWidth = 2;
                        rc_linechart.Series["dewpoint_f"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[11].Checked == true)
                    {
                        strSQLQuery += ",[dewpoint_c] ";
                        rc_linechart.Series.Add("dewpoint_c");
                        rc_linechart.Legends.Add("dewpoint_c");
                        rc_linechart.Legends["dewpoint_c"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["dewpoint_c"].Docking = Docking.Bottom;
                        rc_linechart.Series["dewpoint_c"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["dewpoint_c"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["dewpoint_c"].BorderWidth = 2;
                        rc_linechart.Series["dewpoint_c"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[12].Checked == true)
                    {
                        strSQLQuery += ",[heat_index_f] ";
                        rc_linechart.Series.Add("heat_index_f");
                        rc_linechart.Legends.Add("heat_index_f");
                        rc_linechart.Legends["heat_index_f"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["heat_index_f"].Docking = Docking.Bottom;
                        rc_linechart.Series["heat_index_f"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["heat_index_f"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["heat_index_f"].BorderWidth = 2;
                        rc_linechart.Series["heat_index_f"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[13].Checked == true)
                    {
                        strSQLQuery += ",[heat_index_c] ";
                        rc_linechart.Series.Add("heat_index_c");
                        rc_linechart.Legends.Add("heat_index_c");
                        rc_linechart.Legends["heat_index_c"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["heat_index_c"].Docking = Docking.Bottom;
                        rc_linechart.Series["heat_index_c"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["heat_index_c"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["heat_index_c"].BorderWidth = 2;
                        rc_linechart.Series["heat_index_c"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[14].Checked == true)
                    {
                        strSQLQuery += ",[windchill_f] ";
                        rc_linechart.Series.Add("windchill_f");
                        rc_linechart.Legends.Add("windchill_f");
                        rc_linechart.Legends["windchill_f"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["windchill_f"].Docking = Docking.Bottom;
                        rc_linechart.Series["windchill_f"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["windchill_f"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["windchill_f"].BorderWidth = 2;
                        rc_linechart.Series["windchill_f"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[15].Checked == true)
                    {
                        strSQLQuery += ",[windchill_c] ";
                        rc_linechart.Series.Add("windchill_c");
                        rc_linechart.Legends.Add("windchill_c");
                        rc_linechart.Legends["windchill_c"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["windchill_c"].Docking = Docking.Bottom;
                        rc_linechart.Series["windchill_c"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["windchill_c"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["windchill_c"].BorderWidth = 2;
                        rc_linechart.Series["windchill_c"].XAxisType = AxisType.Secondary;

                    }

                    if (rcb_weather_data.Items[16].Checked == true)
                    {
                        strSQLQuery += ",[visibility_mi] ";
                        rc_linechart.Series.Add("visibility_mi");
                        rc_linechart.Legends.Add("visibility_mi");
                        rc_linechart.Legends["visibility_mi"].Alignment = System.Drawing.StringAlignment.Center;
                        rc_linechart.Legends["visibility_mi"].Docking = Docking.Bottom;
                        rc_linechart.Series["visibility_mi"].ChartType = SeriesChartType.Line;
                        rc_linechart.Series["visibility_mi"].MarkerStyle = MarkerStyle.None;
                        rc_linechart.Series["visibility_mi"].BorderWidth = 2;
                        rc_linechart.Series["visibility_mi"].XAxisType = AxisType.Secondary;
                    }

                    strSQLQuery += "FROM [tbl_bas_weather_history] ";
                    strSQLQuery += "WHERE [station_id] = '" + Station_ID + "' ";
                    strSQLQuery += "AND [timestamp_local] >= '" + Convert.ToDateTime(rdtp_from.SelectedDate) + "' AND [timestamp_local] <= '" + Convert.ToDateTime(rdtp_to.SelectedDate) + "' ORDER BY [timestamp_local] asc";

                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandText = strSQLQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    double d_weather_val;

                    while (ecodomus_client.sql_reader.Read())
                    {

                        if (rcb_weather_data.Items[0].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["temp_c"].ToString());
                            //rc_linechart.Series["temp_c"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["temp_c"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;
                        }

                        if (rcb_weather_data.Items[1].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["temp_f"].ToString());
                            //rc_linechart.Series["temp_f"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["temp_f"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;
                        }

                        //[relative_humidity] ";
                        if (rcb_weather_data.Items[2].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["relative_humidity"].ToString());
                            //rc_linechart.Series["relative_humidity"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["relative_humidity"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[wind_degrees] ";
                        if (rcb_weather_data.Items[3].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["wind_degrees"].ToString());
                            //rc_linechart.Series["wind_degrees"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["wind_degrees"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[wind_mph] ";
                        if (rcb_weather_data.Items[4].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["wind_mph"].ToString());
                            //rc_linechart.Series["wind_mph"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["wind_mph"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[wind_gust_mph] ";
                        if (rcb_weather_data.Items[5].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["wind_gust_mph"].ToString());
                            //rc_linechart.Series["wind_gust_mph"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["wind_gust_mph"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[wind_kt] ";
                        if (rcb_weather_data.Items[6].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["wind_kt"].ToString());
                            //rc_linechart.Series["wind_kt"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["wind_kt"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[wind_gust_kt] ";
                        if (rcb_weather_data.Items[7].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["wind_gust_kt"].ToString());
                            //rc_linechart.Series["wind_gust_kt"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["wind_gust_kt"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[pressure_mb] ";
                        if (rcb_weather_data.Items[8].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["pressure_mb"].ToString());
                            //rc_linechart.Series["pressure_mb"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["pressure_mb"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[pressure_in] ";
                        if (rcb_weather_data.Items[9].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["pressure_in"].ToString());
                            //rc_linechart.Series["pressure_in"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["pressure_in"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[dewpoint_f] ";
                        if (rcb_weather_data.Items[10].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["dewpoint_f"].ToString());
                            //rc_linechart.Series["dewpoint_f"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["dewpoint_f"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[dewpoint_c] ";
                        if (rcb_weather_data.Items[11].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["dewpoint_c"].ToString());
                            //rc_linechart.Series["dewpoint_c"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["dewpoint_c"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[heat_index_f] ";
                        if (rcb_weather_data.Items[12].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["heat_index_f"].ToString());
                            //rc_linechart.Series["heat_index_f"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["heat_index_f"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[heat_index_c] ";
                        if (rcb_weather_data.Items[13].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["heat_index_c"].ToString());
                            //rc_linechart.Series["heat_index_c"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["heat_index_c"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[windchill_f] ";
                        if (rcb_weather_data.Items[14].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["windchill_f"].ToString());
                            //rc_linechart.Series["windchill_f"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["windchill_f"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[windchill_c] ";
                        if (rcb_weather_data.Items[15].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["windchill_c"].ToString());
                            //rc_linechart.Series["windchill_c"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["windchill_c"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                        //[visibility_mi] ";
                        if (rcb_weather_data.Items[16].Checked == true)
                        {
                            d_weather_val = double.Parse(ecodomus_client.sql_reader["visibility_mi"].ToString());
                            //rc_linechart.Series["visibility_mi"].Points.AddY(d_weather_val);
                            DateTime dt_weather_date = DateTime.Parse(ecodomus_client.sql_reader["timestamp_local"].ToString());
                            rc_linechart.Series["visibility_mi"].Points.AddXY(dt_weather_date, d_weather_val);

                            if (d_weather_val > dMax)
                                dMax = d_weather_val;
                            if (d_weather_val < dMin)
                                dMin = d_weather_val;

                        }

                    }

                    ecodomus_client.sql_reader.Close();
                }

                if (!bPerfCharted)
                {
                    rc_linechart.ChartAreas[0].AxisY.Minimum = dMin - 0.5;
                    rc_linechart.ChartAreas[0].AxisY.Maximum = dMax + 0.5;
                }
            }

            ecodomus_client.CloseClientDatabase();

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void BindImpactDetailsGrid(string AAS_name)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
                if (SessionController.Users_.Profileid != null)
                {
                    obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
                }
                obj_energy_plus_model.Name = AAS_name;
                ds = obj_energy_plus_client.Get_Energy_Modeling_AAS_Data(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables.Count > 0)
                {
                    
                        rg_impact_details.DataSource = ds;
                        rg_impact_details.DataBind();
                   
                }
                else
                {
                    rg_impact_details.DataSource = string.Empty;
                    rg_impact_details.DataBind();
                }
            }


            //DataTable tbl = new DataTable();
            //DataColumn col = new DataColumn("description");
            //col.DataType = typeof(string);
            //tbl.Columns.Add(col);
            //tbl.Rows.Add(new object[] { "Building automation system VAV temperature sensors are within 1 deg accuracy" });
            //tbl.Rows.Add(new object[] { "Building automation system VAV air flow sensor is within 50 cfm accuracy" });
            //tbl.Rows.Add(new object[] { "Building automation system VAV has been air balanced and calibrated at min and max cfm" });
            //rg_impact_details.DataSource = tbl;
            //rg_impact_details.DataBind();
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
            //if (((DataRowView)e.DataItem)["time_stamp"] != null && ((DataRowView)e.DataItem)["time_stamp"] != "")
            //{
            //    e.SeriesItem.ActiveRegion.Tooltip += "[" + ((DataRowView)e.DataItem)["time_stamp"] + " : " + String.Format("{0:0.00}", e.SeriesItem.YValue) + "]";
            //}
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    void BindSpatialTreeView(TreeView rtv_entity)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        string strFacility = "";

        try
        {
            rtv_entity.Nodes.Clear();

            if (SessionController.Users_.Em_facility_id != null)
            {
                rtv_entity.Nodes.Clear();
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);

                if (SessionController.Users_.Profileid != null)
                {
                    obj_energy_plus_model.pk_profileid = new Guid(SessionController.Users_.Profileid);
                }

                string sConnectionString = obj_energy_plus_client.Get_Connection_String(obj_energy_plus_model, SessionController.ConnectionString) + ";MultipleActiveResultSets=True;"; //@"Data Source=ZCON-79\SQL2008R2;Initial Catalog=GSAR3;User Id=sa;Password=zcon@123;MultipleActiveResultSets=True;";
                ecodomus_client.sql_connection.ConnectionString = sConnectionString;
                if (ecodomus_client.ConnectClientDatabase())
                {
                    // get the building
                    string strQuery;
                    TreeNode root = new TreeNode();
                    strQuery = "SELECT [name] FROM [tbl_facility] WHERE pk_facility_id = '" + obj_energy_plus_model.Fk_facility_id + "'";
                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandText = strQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    while (ecodomus_client.sql_reader.Read())
                    {
                        strFacility = ecodomus_client.sql_reader["name"].ToString();
                        root.Text = strFacility;
                        root.ToolTip = strFacility;
                        root.Value = "[FACILITY]" + obj_energy_plus_model.Fk_facility_id.ToString();
                        root.PopulateOnDemand = false;
                        root.SelectAction = TreeNodeSelectAction.Expand;
                        root.Expanded = true;
                        rtv_entity.Nodes.Add(root);
                    }
                    ecodomus_client.sql_reader.Close();

                    // create the systems folder
                    TreeNode systems_folder_node = new TreeNode();
                    systems_folder_node.Text = "Systems";
                    systems_folder_node.ToolTip = "Systems";
                    systems_folder_node.Value = "[FOLDER_SYSTEM]";
                    systems_folder_node.PopulateOnDemand = false;
                    systems_folder_node.SelectAction = TreeNodeSelectAction.Select;
                    root.ChildNodes.Add(systems_folder_node);

                    // create the floors folder
                    TreeNode floor_folder_node = new TreeNode();
                    floor_folder_node.Text = "Floors";
                    floor_folder_node.ToolTip = "Floors";
                    floor_folder_node.Value = "[FOLDER_FLOOR]";
                    floor_folder_node.PopulateOnDemand = false;
                    floor_folder_node.SelectAction = TreeNodeSelectAction.Select;
                    root.ChildNodes.Add(floor_folder_node);

                    // create the zones folder
                    TreeNode zones_folder_node = new TreeNode();
                    zones_folder_node.Text = "Zones";
                    zones_folder_node.ToolTip = "Zones";
                    zones_folder_node.Value = "[FOLDER_ZONE]";
                    zones_folder_node.PopulateOnDemand = false;
                    zones_folder_node.SelectAction = TreeNodeSelectAction.Select;
                    root.ChildNodes.Add(zones_folder_node);

                    // create the building meters folder
                    TreeNode meters_folder_node = new TreeNode();
                    meters_folder_node.Text = "Meters";
                    meters_folder_node.ToolTip = "Meters";
                    meters_folder_node.Value = "[FOLDER_METER]";
                    meters_folder_node.PopulateOnDemand = false;
                    meters_folder_node.SelectAction = TreeNodeSelectAction.Select;
                    root.ChildNodes.Add(meters_folder_node);

                    // create the performance folder
                    TreeNode performance_folder_node = new TreeNode();
                    performance_folder_node.Text = "Performance";
                    performance_folder_node.ToolTip = "Performance";
                    performance_folder_node.Value = "[FOLDER_PERFORMANCE]";
                    performance_folder_node.PopulateOnDemand = false;
                    performance_folder_node.SelectAction = TreeNodeSelectAction.Select;
                    root.ChildNodes.Add(performance_folder_node);

                    // load the sim run entries
                    strQuery = "SELECT [pk_energymodel_simulation_request_id] ";
                    strQuery += ",[fk_client_id] ";
                    strQuery += ",[fk_facility_id] ";
                    strQuery += ",[fk_user_id] ";
                    strQuery += ",[fk_project_id] ";
                    strQuery += ",[uploaded_file_id] ";
                    strQuery += ",[status] ";
                    strQuery += ",[filepath] ";
                    strQuery += ",[filename] ";
                    strQuery += ",[filesize] ";
                    strQuery += ",[createdon] ";
                    strQuery += ",[createdby] ";
                    strQuery += ",[modifiedon] ";
                    strQuery += ",[modifiedby] ";
                    strQuery += ",[weather_file_name] ";
                    strQuery += ",[weather_file_path] ";
                    strQuery += ",[message] ";
                    strQuery += ",[status_value] ";
                    strQuery += "FROM [EcoDomus_Central].[dbo].[tbl_energymodel_simulation_request] ";
                    strQuery += "WHERE [fk_facility_id] = '" + obj_energy_plus_model.Fk_facility_id + "' ";
                    strQuery += "ORDER BY [createdon] DESC";

                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandText = strQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    cmb_sim_run.Items.Clear();
                    while (ecodomus_client.sql_reader.Read())
                    {
                        string IDF_FileName = ecodomus_client.sql_reader["filename"].ToString();
                        string Weather_FileName = ecodomus_client.sql_reader["weather_file_name"].ToString();
                        string strDateTime = ecodomus_client.sql_reader["createdon"].ToString();

                        string strValue;
                        strValue = "[SIM_REQUEST_ID]" + ecodomus_client.sql_reader["pk_energymodel_simulation_request_id"].ToString() + ",";
                        strValue += "[SIM_FACILITY_ID]" + ecodomus_client.sql_reader["fk_facility_id"].ToString() +",";
                        strValue += "[SIM_PROJECT_ID]" + ecodomus_client.sql_reader["fk_project_id"].ToString();

                        RadComboBoxItem item = new RadComboBoxItem();
                        item.Text = strFacility + " (" + IDF_FileName + " - " + strDateTime + ")";
                        item.Value = strValue.ToString();
                        cmb_sim_run.Items.Add(item);
                    }
                    ecodomus_client.sql_reader.Close();

                    ecodomus_client.CloseClientDatabase();
                }

            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void CreateChildNode(TreeNode node, DataTable Dt)
    {
        try
        {
            DataRow[] Rows = Dt.Select("ParentId ='" + node.Value + "'");
            if (Rows.Length == 0) { return; }
            for (int i = 0; i < Rows.Length; i++)
            {
                //TreeNode Childnode = new TreeNode(Rows[i]["Name"].ToString(), Rows[i]["Id"].ToString());
                TreeNode Childnode = new TreeNode();
                string name = Rows[i]["Name"].ToString();
                string value = Rows[i]["Id"].ToString();
                if (name.Length > 0)
                {
                    if (name.Length >= 30)
                    {
                        Childnode.Text = name.Substring(0, 29) + "...";
                        Childnode.ToolTip = name;
                    }
                    else
                    {
                        Childnode.Text = name;
                        Childnode.ToolTip = name;
                    }
                }
                Childnode.Value = value;
                Childnode.SelectAction = TreeNodeSelectAction.Expand;
                Childnode.SelectAction = TreeNodeSelectAction.Select;
                node.ChildNodes.Add(Childnode);
                node.ExpandAll();
                CreateChildNode(Childnode, Dt);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public void CreateNode(TreeNode node, DataTable Dt)
    {
        try
        {
            string node_value = "";
            int index = node.Value.LastIndexOf("##");

            if (index > 0)
            {
                node_value = node.Value.Remove(36);

            }
            DataRow[] Rows = Dt.Select("ParentId ='" + node_value + "'");
            if (Rows.Length == 0)
            {
                return;
            }
            for (int i = 0; i < Rows.Length; i++)
            {
                TreeNode Childnode = new TreeNode();
                Childnode.Text = Rows[i]["Name"].ToString();
                Childnode.Value = Rows[i]["value"].ToString();

                Childnode.SelectAction = TreeNodeSelectAction.Expand;
                Childnode.SelectAction = TreeNodeSelectAction.Select;

                //Childnode.PopulateOnDemand = true;
                //DataRow[] ChildRows = Dt.Select("ParentId ='" + Childnode.Value + "'");
                //if (ChildRows.Length > 0)
                //{
                //    Childnode.ShowCheckBox = false;
                //    node.ChildNodes.Add(Childnode);
                //}
                //else
                //{
                //    Childnode.ShowCheckBox = true;
                //    node.ChildNodes.Add(Childnode);
                //}

                Childnode.ShowCheckBox = true;
                node.ChildNodes.Add(Childnode);
                node.CollapseAll();
                CreateNode(Childnode, Dt);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    
    protected void rtv_entity_NodeClick(object sender, RadTreeNodeEventArgs e)
    {

    }

    protected void btn_DeselectAll(object sender, EventArgs e)
    {
        for (int i=0; i < rtv_entity.Nodes.Count; i++ )
        {
            if (rtv_entity.Nodes[i].Checked == true)
                rtv_entity.Nodes[i].Checked = false;
        }
    }

    protected void btn_update_Click(object sender, EventArgs e)
    {
        try
        {
            BindSimEMGraph();
        }
        catch (Exception ex)
        {
           
        }
    }

    protected void rtv_entity_SelectedNodeChanged(object sender, EventArgs e)
    {

        EnergyPlusClient obj_energy_plus_client=new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();

        // if the current node has no children, try to load them
        if (rtv_entity.SelectedNode.ChildNodes.Count == 0)
        {
            Guid Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            string sConnectionString = obj_energy_plus_client.Get_Connection_String(obj_energy_plus_model, SessionController.ConnectionString) + ";MultipleActiveResultSets=True;"; //@"Data Source=ZCON-79\SQL2008R2;Initial Catalog=GSAR3;User Id=sa;Password=zcon@123;MultipleActiveResultSets=True;";
            ecodomus_client.sql_connection.ConnectionString = sConnectionString;
            if (ecodomus_client.ConnectClientDatabase())
            {

                if (rtv_entity.SelectedNode.Value.StartsWith("[FOLDER_SYSTEM]"))
                {
                    string strQuery = "SELECT ";
                    strQuery += "tbl_system.pk_system_id, ";
                    strQuery += "tbl_system.name, ";
                    strQuery += "tbl_system.description ";
                    strQuery += "FROM tbl_system ";
                    strQuery += "INNER JOIN tbl_system_facility_linkup ";
                    strQuery += "ON tbl_system_facility_linkup.fk_system_id=tbl_system.pk_system_id ";
                    strQuery += "AND tbl_system_facility_linkup.fk_facility_id = '" + Fk_facility_id + "' ";
                    strQuery += "left JOIN tbl_uploaded_file tuf ";
                    strQuery += "ON tuf.pk_uploaded_file_id = tbl_system.fk_uploaded_file_id ";
                    strQuery += "ORDER BY [name] ";

                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandText = strQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    while (ecodomus_client.sql_reader.Read())
                    {
                        string strSystemName = ecodomus_client.sql_reader["name"].ToString();
                        string strSystemID = ecodomus_client.sql_reader["pk_system_id"].ToString();

                        TreeNode system_node = new TreeNode();
                        system_node.Text = strSystemName;
                        system_node.ToolTip = strSystemName;
                        system_node.Value = "[SYSTEM]" + strSystemID;
                        system_node.PopulateOnDemand = false;
                        system_node.SelectAction = TreeNodeSelectAction.Select;
                        rtv_entity.SelectedNode.ChildNodes.Add(system_node);
                    }

                    ecodomus_client.sql_reader.Close();
                    rtv_entity.SelectedNode.Expanded = true;
                }

                if (rtv_entity.SelectedNode.Value.StartsWith("[SYSTEM]"))
                {
                    string id = rtv_entity.SelectedNode.Value.Replace("[SYSTEM]", "").ToString();
                    string strQuery = "SELECT fk_system_id ";
                    strQuery += ",fk_asset_id ";
                    strQuery += ",[tbl_asset].name ";
                    strQuery += "FROM tbl_system_asset_linkup ";
                    strQuery += "INNER JOIN [tbl_asset] ";
                    strQuery += "ON tbl_system_asset_linkup.fk_asset_id = [tbl_asset].pk_asset_id ";
                    strQuery += "WHERE fk_system_id = '" + id + "' ";
                    strQuery += "ORDER BY [name]";

                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandText = strQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    while (ecodomus_client.sql_reader.Read())
                    {
                        string strName = ecodomus_client.sql_reader["name"].ToString();
                        string strID = ecodomus_client.sql_reader["fk_asset_id"].ToString();

                        TreeNode asset_node = new TreeNode();
                        asset_node.Text = strName;
                        asset_node.ToolTip = strName;
                        asset_node.Value = "[ASSET]" + strID;
                        asset_node.PopulateOnDemand = false;
                        asset_node.SelectAction = TreeNodeSelectAction.Select;
                        asset_node.ShowCheckBox = false;
                        rtv_entity.SelectedNode.ChildNodes.Add(asset_node);
                    }

                    ecodomus_client.sql_reader.Close();
                    rtv_entity.SelectedNode.Expanded = true;
                }

                // [FOLDER_FLOOR]
                if (rtv_entity.SelectedNode.Value.StartsWith("[FOLDER_FLOOR]"))
                {
                    // get the floors, put them the floor folder
                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandType = CommandType.StoredProcedure;
                    ecodomus_client.sql_command.CommandText = "proc_get_floors_for_facility";
                    ecodomus_client.sql_command.Parameters.AddWithValue("@fk_facility_id", Fk_facility_id.ToString());
                    ecodomus_client.sql_command.Parameters.AddWithValue("@txtsearch", "");
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    while (ecodomus_client.sql_reader.Read())
                    {
                        string strFloorName = ecodomus_client.sql_reader["floor_name"].ToString();
                        TreeNode floor_node = new TreeNode();
                        floor_node.Text = strFloorName;
                        floor_node.ToolTip = strFloorName;
                        floor_node.Value = "[FLOOR]" + ecodomus_client.sql_reader["floor_id"].ToString();
                        floor_node.PopulateOnDemand = false;
                        floor_node.SelectAction = TreeNodeSelectAction.Select;
                        rtv_entity.SelectedNode.ChildNodes.Add(floor_node);
                    }
                    ecodomus_client.sql_reader.Close();
                    rtv_entity.SelectedNode.Expanded = true;
                }

                // [FOLDER_ZONE]
                if (rtv_entity.SelectedNode.Value.StartsWith("[FOLDER_ZONE]"))
                {
                    // get the zones, put them in the zones folder
                    string strQuery = "SELECT * FROM tbl_location tl ";
                    strQuery += "WHERE fk_entity_id=(SELECT vge.pk_entity_id ";
                    strQuery += "FROM vw_get_entity vge WHERE vge.entity_name='zone') ";
                    strQuery += "AND tl.fk_facility_id = '" + Fk_facility_id.ToString() + "'";
                    strQuery += "ORDER BY [name] ";

                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandText = strQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    while (ecodomus_client.sql_reader.Read())
                    {
                        string strZoneName = ecodomus_client.sql_reader["name"].ToString();
                        TreeNode zone_node = new TreeNode();
                        zone_node.Text = strZoneName;
                        zone_node.ToolTip = strZoneName;
                        zone_node.Value = "[ZONE]" + ecodomus_client.sql_reader["pk_location_id"].ToString();
                        zone_node.PopulateOnDemand = false;
                        zone_node.SelectAction = TreeNodeSelectAction.Select;
                        rtv_entity.SelectedNode.ChildNodes.Add(zone_node);
                    }
                    ecodomus_client.sql_reader.Close();
                    rtv_entity.SelectedNode.Expanded = true;
                }

                // [FOLDER_METER]
                if (rtv_entity.SelectedNode.Value.StartsWith("[FOLDER_METER]"))
                {
                    // get the meters, put them in the meters folder
                    string strQuery = "SELECT [fk_facility_id] ";
                    strQuery += ",[ReportMeterDataDictionaryIndex] ";
                    strQuery += ",[VariableType] ";
                    strQuery += ",[IndexGroup] ";
                    strQuery += ",[TimestepType] ";
                    strQuery += ",[VariableName] ";
                    strQuery += ",[ReportingFrequency] ";
                    strQuery += ",[VariableUnits] ";
                    strQuery += "FROM [tbl_energymodeling_ReportMeterDataDictionary] ";
                    strQuery += "WHERE [fk_facility_id] = '" + Fk_facility_id.ToString() + "' ";
                    strQuery += "ORDER BY [VariableName]";

                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandText = strQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    while (ecodomus_client.sql_reader.Read())
                    {
                        string strMeterName = ecodomus_client.sql_reader["VariableName"].ToString();
                        string strReportingFreq = ecodomus_client.sql_reader["ReportingFrequency"].ToString();

                        TreeNode meter_node = new TreeNode();
                        meter_node.Text = strMeterName.ToString() + " - " + strReportingFreq.ToString();
                        meter_node.ToolTip = strMeterName.ToString() + " - " + strReportingFreq.ToString();
                        meter_node.Value = "[METER]" + strMeterName.ToString() + ",[REPORT_FREQ]" + strReportingFreq;
                        meter_node.PopulateOnDemand = false;
                        meter_node.SelectAction = TreeNodeSelectAction.Select;
                        meter_node.ShowCheckBox = true;
                        rtv_entity.SelectedNode.ChildNodes.Add(meter_node);
                    }
                    ecodomus_client.sql_reader.Close();
                    rtv_entity.SelectedNode.Expanded = true;
                }

                // [FOLDER_PERFORMANCE]
                if (rtv_entity.SelectedNode.Value.StartsWith("[FOLDER_PERFORMANCE]"))
                {
                    // get the analysis results, put them in the performance folder
                    string strQuery = "SELECT [pk_result_id] ";
                    strQuery += ",[zone_name] ";
                    strQuery += ",[PerformanceValue] ";
                    strQuery += "FROM [tbl_energymodel_simulation_analysis_results] ";
                    strQuery += "WHERE [fk_facility_id] = '" + Fk_facility_id.ToString() + "' ";
                    strQuery += "ORDER BY [PerformanceValue] DESC";

                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandText = strQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    while (ecodomus_client.sql_reader.Read())
                    {
                        float fValue = float.Parse(ecodomus_client.sql_reader["PerformanceValue"].ToString());
                        string strValue = string.Format("{0:0.0}.", fValue);

                        string strName = ecodomus_client.sql_reader["zone_name"].ToString();
                        string strID = ecodomus_client.sql_reader["pk_result_id"].ToString();

                        TreeNode perf_node = new TreeNode();
                        perf_node.Text = "(" + strValue + ") " + strName.ToString();
                        perf_node.ToolTip = "(" + strValue + ") " + strName.ToString();
                        perf_node.Value = "[PERFORMANCE_RESULT]" + strID.ToString();
                        perf_node.PopulateOnDemand = false;
                        perf_node.SelectAction = TreeNodeSelectAction.Select;
                        perf_node.ShowCheckBox = true;
                        rtv_entity.SelectedNode.ChildNodes.Add(perf_node);
                    }
                    ecodomus_client.sql_reader.Close();
                    rtv_entity.SelectedNode.Expanded = true;
                }

                // if selected node starts with "[ZONE] ", load the spaces for the zone
                if (rtv_entity.SelectedNode.Value.StartsWith("[ZONE]"))
                {
                    Hashtable ht_spaces = new Hashtable();
                    string zone_id = rtv_entity.SelectedNode.Value.Replace("[ZONE]", "").ToString();
                    string zone_name = rtv_entity.SelectedNode.ToolTip.ToString();

                    string strQuery = "select ";
                    strQuery += "tbl_zone_space_linkup.fk_zone_id as 'zone_id' ";
                    strQuery += ",tbl_location.pk_location_id AS space_id  ";
                    strQuery += ",tbl_location.fk_facility_id  ";
                    strQuery += ",tbl_location.description AS space_desc  ";
                    strQuery += ",tbl_location.name AS space_name  ";
                    strQuery += ",tbl_facility.name AS facility_name  ";
                    strQuery += "from tbl_location  ";
                    strQuery += "INNER JOIN vw_get_entity  ";
                    strQuery += "ON vw_get_entity.pk_entity_id = tbl_location.fk_entity_id  ";
                    strQuery += "AND vw_get_entity.entity_name = 'Space'  ";
                    strQuery += "INNER JOIN tbl_facility ";
                    strQuery += "ON tbl_facility.pk_facility_id = tbl_location.fk_facility_id  ";
                    strQuery += "LEFT JOIN tbl_zone_space_linkup  ";
                    strQuery += "on tbl_zone_space_linkup.fk_space_id= tbl_location.pk_location_id  ";
                    strQuery += "where tbl_location.fk_facility_id = '" + Fk_facility_id + "' ";
                    strQuery += "AND tbl_zone_space_linkup.fk_zone_id = '" + zone_id + "' ";
                    strQuery += "AND tbl_location.fk_location_parent_id IS NOT NULL  ";
                    strQuery += "ORDER BY tbl_location.name ";

                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandType = CommandType.Text;
                    ecodomus_client.sql_command.CommandText = strQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    // save the name and id to a hash table for now
                    while (ecodomus_client.sql_reader.Read())
                    {
                        ht_spaces.Add(ecodomus_client.sql_reader["space_id"].ToString(), ecodomus_client.sql_reader["space_name"].ToString());
                    }
                    ecodomus_client.sql_reader.Close();

                    foreach (string space_id in ht_spaces.Keys)
                    {
                        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                        ecodomus_client.sql_command.CommandType = CommandType.StoredProcedure;
                        ecodomus_client.sql_command.CommandText = "proc_get_spaceprofile_byid";
                        ecodomus_client.sql_command.Parameters.AddWithValue("@Location_ID", space_id);
                        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                        while (ecodomus_client.sql_reader.Read())
                        {
                            string strSpaceName = ecodomus_client.sql_reader["SpaceName"].ToString();
                            string strSpaceDesc = ecodomus_client.sql_reader["Description"].ToString();

                            TreeNode space_node = new TreeNode();
                            space_node.Text = strSpaceName + " (" + strSpaceDesc + ")";
                            space_node.ToolTip = strSpaceName;
                            space_node.Value = "[SPACE]" + space_id;
                            space_node.PopulateOnDemand = false;
                            space_node.SelectAction = TreeNodeSelectAction.Select;
                            rtv_entity.SelectedNode.ChildNodes.Add(space_node);

                        }
                        ecodomus_client.sql_reader.Close();
                    }
                    rtv_entity.SelectedNode.Expanded = true;

                    // load the zone energy modeling variables from tbl_energymodeling_ReportVariableDataDictionary for this zone
                    string sSQLQuery = "SELECT [fk_facility_id] ";
                    sSQLQuery += ",[fk_project_id] ";
                    sSQLQuery += ",[fk_simulation_id] ";
                    sSQLQuery += ",[fk_zone_id] ";
                    sSQLQuery += ",[fk_attribute_id] ";
                    sSQLQuery += ",[createdon] ";
                    sSQLQuery += ",[ReportVariableDataDictionaryIndex] ";
                    sSQLQuery += ",[VariableType] ";
                    sSQLQuery += ",[IndexGroup] ";
                    sSQLQuery += ",[TimestepType] ";
                    sSQLQuery += ",[KeyValue] ";
                    sSQLQuery += ",[VariableName] ";
                    sSQLQuery += ",[ReportingFrequency] ";
                    sSQLQuery += ",[ScheduleName] ";
                    sSQLQuery += ",[VariableUnits] ";
                    sSQLQuery += "FROM [tbl_energymodeling_ReportVariableDataDictionary] ";
                    sSQLQuery += "WHERE [fk_zone_id] = '" + zone_id + "'";
                    sSQLQuery += "ORDER BY [VariableName]";

                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandType = CommandType.Text;
                    ecodomus_client.sql_command.CommandText = sSQLQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    while (ecodomus_client.sql_reader.Read())
                    {
                        string strAttributeName = ecodomus_client.sql_reader["VariableName"].ToString();

                        TreeNode attribute_node = new TreeNode();
                        attribute_node.Text = strAttributeName;
                        attribute_node.ToolTip = zone_name + " - " + strAttributeName;
                        attribute_node.Value = "[ZONE_ID]" + zone_id + ",[ZONE_VARIABLE]" + strAttributeName + ",[CHART_LABEL]" + zone_name + " - " + strAttributeName;
                        attribute_node.PopulateOnDemand = false;
                        attribute_node.SelectAction = TreeNodeSelectAction.Select;
                        attribute_node.ShowCheckBox = true;
                        attribute_node.Expanded = true;
                        rtv_entity.SelectedNode.ChildNodes.Add(attribute_node);
                    }
                    ecodomus_client.sql_reader.Close();
                }

                // if selected node starts with "[FLOOR] ", load the spaces for the floor
                if (rtv_entity.SelectedNode.Value.StartsWith("[FLOOR]"))
                {
                    // get the spaces for a floor --------------------------------------------------------------
                    string strSpaceQuery = "SELECT pk_location_id AS ID,name AS Name ";
                    strSpaceQuery += "FROM tbl_location ";
                    strSpaceQuery += "INNER JOIN vw_get_entity ";
                    strSpaceQuery += "ON tbl_location.fk_entity_id=vw_get_entity.pk_entity_id ";
                    strSpaceQuery += "WHERE vw_get_entity.entity_name='Space' ";
                    strSpaceQuery += "AND tbl_location.fk_location_parent_id = '" + rtv_entity.SelectedNode.Value.Replace("[FLOOR]", "").ToString() + "' ";
                    strSpaceQuery += "ORDER BY Name";

                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandType = CommandType.Text;
                    ecodomus_client.sql_command.CommandText = strSpaceQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();
                      
                    List<MyValuePairStruct> mySpaceList = new List<MyValuePairStruct>();
                    while (ecodomus_client.sql_reader.Read())
                    {
                        MyValuePairStruct item = new MyValuePairStruct();
                        item.sKey = ecodomus_client.sql_reader["id"].ToString();
                        item.sValue = ecodomus_client.sql_reader["Name"].ToString();
                        mySpaceList.Add(item);
                    }
                    ecodomus_client.sql_reader.Close();

                    foreach (MyValuePairStruct space in mySpaceList)
                    {
                        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                        ecodomus_client.sql_command.CommandType = CommandType.StoredProcedure;
                        ecodomus_client.sql_command.CommandText = "proc_get_spaceprofile_byid";
                        ecodomus_client.sql_command.Parameters.AddWithValue("@Location_ID", space.sKey.ToString());
                        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();
                        while (ecodomus_client.sql_reader.Read())
                        {
                            string strSpaceName = ecodomus_client.sql_reader["SpaceName"].ToString();
                            string strSpaceDesc = ecodomus_client.sql_reader["Description"].ToString();
                            TreeNode space_node = new TreeNode();
                            space_node.Text = strSpaceName + " (" + strSpaceDesc + ")";
                            space_node.ToolTip = strSpaceName + " (" + strSpaceDesc + ")";
                            space_node.Value = "[SPACE]" + space.sKey.ToString();
                            space_node.PopulateOnDemand = false;
                            space_node.SelectAction = TreeNodeSelectAction.Select;
                            rtv_entity.SelectedNode.ChildNodes.Add(space_node);
                        }
                        ecodomus_client.sql_reader.Close();
                    }
                    rtv_entity.SelectedNode.Expanded = true;
                        
                }

                // if selected node starts with "[SPACE] ", load the assets and attributes for the space
                if (rtv_entity.SelectedNode.Value.StartsWith("[SPACE]"))
                {
                    //// get the assets for a space --------------------------------------------------------------
                    string strSQLQuery = "SELECT [tbl_asset].[pk_asset_id] AS asset_id";
                    strSQLQuery += ",[tbl_space_asset_linkup].fk_space_id ";
                    strSQLQuery += ",[tbl_asset].[fk_facility_id] ";
                    strSQLQuery += ",[tbl_asset].[name] as [AssetName] ";
                    strSQLQuery += ",[tbl_asset_attribute].[pk_asset_attribute_id] ";
                    strSQLQuery += ",[tbl_asset_attribute].[name] as [AttributeName] ";
                    strSQLQuery += ",[tbl_asset_attribute].[bas_enabled] ";
                    strSQLQuery += ",[tbl_asset_attribute].[bas_tag_name] ";
                    strSQLQuery += ",[tbl_asset_attribute].[fk_bas_server_id] ";
                    strSQLQuery += ",[tbl_asset_attribute].[fk_bas_recording_type_id] ";
                    strSQLQuery += ",[tbl_bas_server].[name] ";
                    strSQLQuery += ",[tbl_bas_server].[bas_server_url] ";
                    strSQLQuery += ",[tbl_bas_server].[login_user_name] ";
                    strSQLQuery += ",[tbl_bas_server].[login_user_password] ";
                    strSQLQuery += "FROM [tbl_asset_attribute] ";
                    strSQLQuery += "INNER JOIN [tbl_asset] ON [tbl_asset].[pk_asset_id] = [tbl_asset_attribute].[fk_asset_id] ";
                    strSQLQuery += "INNER JOIN [tbl_bas_server] ON [tbl_bas_server].[pk_bas_server_id] = [tbl_asset_attribute].[fk_bas_server_id] ";
                    strSQLQuery += "INNER JOIN [tbl_space_asset_linkup] ON [tbl_space_asset_linkup].fk_asset_id = [tbl_asset].[pk_asset_id] ";
                    strSQLQuery += "WHERE [tbl_space_asset_linkup].fk_space_id = '" + rtv_entity.SelectedNode.Value.Replace("[SPACE]", "").ToString() + "' ";
                    strSQLQuery += "AND [bas_enabled] = 1 ";
                    strSQLQuery += "ORDER BY AssetName";

                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandType = CommandType.Text;
                    ecodomus_client.sql_command.CommandText = strSQLQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    Hashtable ht_assets = new Hashtable();

                    while (ecodomus_client.sql_reader.Read())
                    {
                        bool bExists = false;
                        foreach (DictionaryEntry asset in ht_assets)
                        {
                            if (asset.Key.ToString() == ecodomus_client.sql_reader["asset_id"].ToString())
                                bExists = true;
                        }

                        if (bExists == false)
                        {
                            ht_assets.Add(ecodomus_client.sql_reader["asset_id"].ToString(), ecodomus_client.sql_reader["AssetName"].ToString());

                            TreeNode asset_node = new TreeNode();
                            asset_node.Text = ecodomus_client.sql_reader["AssetName"].ToString();
                            asset_node.ToolTip = ecodomus_client.sql_reader["AssetName"].ToString();
                            asset_node.Value = "[ASSET]" + ecodomus_client.sql_reader["asset_id"].ToString();
                            asset_node.PopulateOnDemand = false;
                            asset_node.SelectAction = TreeNodeSelectAction.Select;
                            asset_node.ShowCheckBox = false;
                            rtv_entity.SelectedNode.ChildNodes.Add(asset_node);
                        }

                    }
                    ecodomus_client.sql_reader.Close();
                    rtv_entity.SelectedNode.Expanded = true;
                }

                // get asset attributes ?
                if (rtv_entity.SelectedNode.Value.StartsWith("[ASSET]"))
                {
                    //string sSQLQuery = "SELECT [tbl_asset_attribute].[pk_asset_attribute_id] ";
                    //sSQLQuery += ",[tbl_asset_attribute].[fk_asset_id] ";
                    //sSQLQuery += ",[tbl_asset_attribute].[name] ";
                    //sSQLQuery += ",[tbl_asset_attribute].[bas_enabled] ";
                    //sSQLQuery += ",[tbl_asset_attribute].[bas_tag_name] ";
                    //sSQLQuery += ",[tbl_asset_attribute].[fk_bas_server_id] ";
                    //sSQLQuery += ",[tbl_asset_attribute].[description] ";
                    //sSQLQuery += ",[tbl_asset_attribute_value].[value] ";
                    //sSQLQuery += ",[tbl_asset_attribute_value].[fk_uom_id] ";
                    //sSQLQuery += "FROM [tbl_asset_attribute] ";
                    //sSQLQuery += "INNER JOIN [tbl_asset_attribute_value] ON ";
                    //sSQLQuery += "[tbl_asset_attribute].[pk_asset_attribute_id] = [tbl_asset_attribute_value].[fk_asset_attribute_id] ";
                    //sSQLQuery += "WHERE [fk_asset_id] = '" + rtv_entity.SelectedNode.Value.Replace("[ASSET]", "").ToString() + "'";

                    string sSQLQuery = "SELECT [tbl_asset_attribute].[pk_asset_attribute_id] ";
                    sSQLQuery += ",[tbl_asset_attribute].[fk_asset_id] ";
                    sSQLQuery += ",[tbl_asset_attribute].[name] ";
                    sSQLQuery += ",[tbl_asset_attribute].[bas_enabled] ";
                    sSQLQuery += ",[tbl_asset_attribute].[bas_tag_name] ";
                    sSQLQuery += ",[tbl_asset_attribute].[fk_bas_server_id] ";
                    sSQLQuery += ",[tbl_asset_attribute].[description] ";
                    sSQLQuery += ",[tbl_asset_attribute_value].[value] ";
                    sSQLQuery += ",[tbl_asset_attribute_value].[fk_uom_id] ";
                    sSQLQuery += ",[vw_get_uom].[unit_of_measurement] ";
                    sSQLQuery += "FROM [tbl_asset_attribute] ";
                    sSQLQuery += "INNER JOIN [tbl_asset_attribute_value] ON ";
                    sSQLQuery += "[tbl_asset_attribute].[pk_asset_attribute_id] = [tbl_asset_attribute_value].[fk_asset_attribute_id] ";
                    sSQLQuery += "INNER JOIN [vw_get_uom] ON ";
                    sSQLQuery += "[tbl_asset_attribute_value].fk_uom_id = [vw_get_uom].pk_unit_of_measurement_id ";
                    sSQLQuery += "WHERE [fk_asset_id] = '" + rtv_entity.SelectedNode.Value.Replace("[ASSET]", "").ToString() + "'";

                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandType = CommandType.Text;
                    ecodomus_client.sql_command.CommandText = sSQLQuery;
                    ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                    while (ecodomus_client.sql_reader.Read())
                    {
                        string strAttributeName = ecodomus_client.sql_reader["name"].ToString();
                        string strAttributeValue = ecodomus_client.sql_reader["value"].ToString();
                        string strBASEnabled = ecodomus_client.sql_reader["bas_enabled"].ToString();
                        string tag_name = ecodomus_client.sql_reader["bas_tag_name"].ToString();
                        string asset_name = rtv_entity.SelectedNode.ToolTip.ToString();
                        string sUnits = ecodomus_client.sql_reader["unit_of_measurement"].ToString();

                        if (strBASEnabled.Equals("1") || strBASEnabled.Equals("True"))
                        {
                            TreeNode attribute_node = new TreeNode();
                            attribute_node.Text = strAttributeName;
                            attribute_node.ToolTip = strAttributeValue;
                            attribute_node.Value = "[ATTRIBUTE]" + ecodomus_client.sql_reader["pk_asset_attribute_id"].ToString() + ",[TAGNAME]" + tag_name + ",[CHART_LABEL]" + asset_name + " - " + strAttributeName + ",[UNITS]" + sUnits;
                            attribute_node.PopulateOnDemand = false;
                            attribute_node.SelectAction = TreeNodeSelectAction.Select;
                            attribute_node.ShowCheckBox = true;
                            attribute_node.Expanded = true;
                            rtv_entity.SelectedNode.ChildNodes.Add(attribute_node);
                        }
                    }

                    ecodomus_client.sql_reader.Close();
                    rtv_entity.SelectedNode.Expanded = true;

                }
            }

            ecodomus_client.CloseClientDatabase();
        }

    }

    protected void rtv_entity_TreeNodePopulate(object sender, TreeNodeEventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        DataTable Dt = new DataTable();

        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            }

            if (SessionController.Users_.Profileid != null)
            {
                obj_energy_plus_model.pk_profileid = new Guid(SessionController.Users_.Profileid);
                //ds = obj_energy_plus_client.Get_Energy_Modeling_Spatial_Hierarchy(obj_energy_plus_model, SessionController.ConnectionString);
            }

            if (ViewState["TreeData"] != null)
            {
                ds = (DataSet)ViewState["TreeData"];
            }

            string node_value = "";
            int index = e.Node.Value.LastIndexOf("##");

            if (index > 0)
            {
                string[] Result= e.Node.Value.Split(new[] { "##" }, StringSplitOptions.None);
                if (Result.Count() > 0)
                {
                    node_value = Result[0];
                    //node_value = e.Node.Value.Remove(36);
                }
                //node.Value= node.Value.Remove(36);
            }

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow[] Rows = ds.Tables[0].Select("ParentId ='" + node_value + "'");
                    if (Rows.Length == 0)
                    {
                        return;
                    }

                    for (int i = 0; i < Rows.Length; i++)
                    {
                        TreeNode Childnode = new TreeNode();
                        string name = Rows[i]["Name"].ToString();
                        string value = Rows[i]["value"].ToString();
                        if (name.Length > 0)
                        {
                            if (name.Length >= 30)
                            {
                                Childnode.Text = name.Substring(0,29)+"...";
                                Childnode.ToolTip = name;
                            }
                            else
                            {
                                Childnode.Text = name;
                                Childnode.ToolTip = name;
                            }
                        }
                        Childnode.Value = value;
                        Childnode.ShowCheckBox = true;
                        Childnode.SelectAction = TreeNodeSelectAction.Expand;
                        Childnode.PopulateOnDemand = true;
                        e.Node.ChildNodes.Add(Childnode);
                        //CreateNode(Childnode, Dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rcm_AAS_ItemClick(object sender, RadMenuEventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            if (SessionController.Users_.Em_facility_id != null)
            {
                lbl_AAS.Text = rcm_AAS.SelectedItem.Text;
                BindImpactDetailsGrid(rcm_AAS.SelectedItem.Value);
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    
    protected void rg_impact_details_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                string id = item["pk_algorithm_id"].Text;
                ImageButton img_impact = (ImageButton)item.FindControl("img_impact");//accessing ImageButton

                if (img_impact != null)
                {
                    if (id.Equals("&nbsp;", StringComparison.CurrentCultureIgnoreCase) || id.Equals("", StringComparison.CurrentCultureIgnoreCase))
                    {
                        img_impact.ImageUrl = "~/App/Images/Icons/asset_add_sm.png";
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    
    protected void rg_impact_details_ItemCreated(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridDataItem)
            {

                ImageButton editLink = (ImageButton)e.Item.FindControl("img_impact");
                if (editLink != null)
                {
                    editLink.Attributes["href"] = "#";
                    editLink.Attributes["onclick"] = String.Format("return ShowAASAlgoEditWindow('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_simulation_AAS_id"], e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_algorithm_id"]);
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_impact_details_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
            EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
            if (SessionController.Users_.Em_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            }
            if (SessionController.Users_.Profileid != null)
            {
                obj_energy_plus_model.Pk_project_id = new Guid(SessionController.Users_.Profileid);
            }
            if (e.CommandName == "delete")
            {
                string id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_simulation_AAS_id"].ToString();
                obj_energy_plus_model.Pk_simulation_AAS_id = new Guid(id);
                obj_energy_plus_client.Delete_Energy_Modeling_AAS_Data(obj_energy_plus_model, SessionController.ConnectionString);
                BindImpactDetailsGrid(lbl_AAS.Text);
            }

        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    
    protected void rg_impact_details_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
             BindImpactDetailsGrid(lbl_AAS.Text);
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }

    protected void rg_impact_details_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            BindImpactDetailsGrid(lbl_AAS.Text);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_impact_details_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        try
        {
            BindImpactDetailsGrid(lbl_AAS.Text);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    public bool GraphPerformanceResultByID(string pk_result_id, DateTime start_date, DateTime end_date)
    {
        bool bSuccess = false;
        string strSQLQuery = "";

        strSQLQuery = "SELECT [pk_result_id] ";
        strSQLQuery += ",[fk_facility_id] ";
        strSQLQuery += ",[fk_project_id] ";
        strSQLQuery += ",[fk_simulation_id] ";
        strSQLQuery += ",[IDD_Class] ";
        strSQLQuery += ",[IDD_Class_Field] ";
        strSQLQuery += ",[fk_zone_id] ";
        strSQLQuery += ",[zone_name] ";
        strSQLQuery += ",[Omni_Class] ";
        strSQLQuery += ",[Asset_Attribute_Name] ";
        strSQLQuery += ",[Asset_Attribute_Value] ";
        strSQLQuery += ",[fk_asset_attribute_id] ";
        strSQLQuery += ",[PerformanceValue] ";
        strSQLQuery += ",[Tolerance] ";
        strSQLQuery += ",[start_date] ";
        strSQLQuery += ",[end_date] ";
        strSQLQuery += "FROM [tbl_energymodel_simulation_analysis_results] ";
        strSQLQuery += "WHERE [pk_result_id] = '" + pk_result_id + "'";

        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
        ecodomus_client.sql_command.CommandText = strSQLQuery;
        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

        while (ecodomus_client.sql_reader.Read())
        {
            last_chart_data.pk_result_id = ecodomus_client.sql_reader["pk_result_id"].ToString();
            last_chart_data.s_facility_id = ecodomus_client.sql_reader["fk_facility_id"].ToString();
            last_chart_data.s_project_id = ecodomus_client.sql_reader["fk_project_id"].ToString();
            last_chart_data.s_simulation_id = ecodomus_client.sql_reader["fk_simulation_id"].ToString();
            last_chart_data.sIDD_Class = ecodomus_client.sql_reader["IDD_Class"].ToString();
            last_chart_data.sIDD_Class_Field = ecodomus_client.sql_reader["IDD_Class_Field"].ToString();
            last_chart_data.s_zone_id = ecodomus_client.sql_reader["fk_zone_id"].ToString();
            last_chart_data.s_zone_name = ecodomus_client.sql_reader["zone_name"].ToString();
            last_chart_data.sOmni_Class = ecodomus_client.sql_reader["Omni_Class"].ToString();
            last_chart_data.sAsset_Attribute_Name = ecodomus_client.sql_reader["Asset_Attribute_Name"].ToString();
            last_chart_data.sTagName = ecodomus_client.sql_reader["Asset_Attribute_Value"].ToString();
            last_chart_data.s_asset_attribute_id = ecodomus_client.sql_reader["fk_asset_attribute_id"].ToString();
            last_chart_data.dPerformanceValue = double.Parse(ecodomus_client.sql_reader["PerformanceValue"].ToString());
            last_chart_data.dTolerance = double.Parse(ecodomus_client.sql_reader["Tolerance"].ToString());

            //last_chart_data.start_date = DateTime.Parse(ecodomus_client.sql_reader["start_date"].ToString());
            //last_chart_data.end_date = DateTime.Parse(ecodomus_client.sql_reader["end_date"].ToString());
            last_chart_data.start_date = start_date;
            last_chart_data.end_date = end_date;
            
            GraphPerformanceResult(ecodomus_client.sql_reader["pk_result_id"].ToString(),
                                                ecodomus_client.sql_reader["fk_facility_id"].ToString(),
                                                ecodomus_client.sql_reader["fk_project_id"].ToString(),
                                                ecodomus_client.sql_reader["fk_simulation_id"].ToString(),
                                                ecodomus_client.sql_reader["IDD_Class"].ToString(),
                                                ecodomus_client.sql_reader["IDD_Class_Field"].ToString(),
                                                ecodomus_client.sql_reader["fk_zone_id"].ToString(),
                                                ecodomus_client.sql_reader["zone_name"].ToString(),
                                                ecodomus_client.sql_reader["Omni_Class"].ToString(),
                                                ecodomus_client.sql_reader["Asset_Attribute_Name"].ToString(),
                                                ecodomus_client.sql_reader["Asset_Attribute_Value"].ToString(),
                                                ecodomus_client.sql_reader["fk_asset_attribute_id"].ToString(),
                                                double.Parse(ecodomus_client.sql_reader["PerformanceValue"].ToString()),
                                                double.Parse(ecodomus_client.sql_reader["Tolerance"].ToString()),
                                                start_date,
                                                end_date);


            break;

        }

        ecodomus_client.sql_reader.Close();

        return bSuccess;
    }

    public bool GraphPerformanceResult(string pk_result_id,
                string s_facility_id,
                string s_project_id,
                string s_simulation_id,
                string sIDD_Class,
                string sIDD_Class_Field,
                string s_zone_id,
                string s_zone_name,
                string sOmni_Class,
                string sAsset_Attribute_Name,
                string sTagName,
                string s_asset_attribute_id,
                double dPerformanceValue,
                double dTolerance,
                DateTime start_date,
                DateTime end_date)
    {
        EcoDomus_Analysis.Performance_Analysis.ConvertTemp ct = new Performance_Analysis.ConvertTemp();

        bool bSuccess = false;
        string strSQLQuery = "";
        string sBAS_Label = "BAS: " + sTagName;
        string sEM_Label = "EM: " + s_zone_name;
        string sToleranceLabel;

        double dAdjustedTolerance = 0.0;
        double dMax = -10000000000.0f;
        double dMin = 10000000000.0f;
        
        string sUnits = rcb_unit.SelectedItem.Value.ToUpper();

        // the tolerance is stored in Deg C, convert to Deg F ?
        if (sUnits == "F")
            dAdjustedTolerance = dTolerance * 1.8;
        else
            dAdjustedTolerance = dTolerance;

        sToleranceLabel = "Tolerance Band: " + dAdjustedTolerance.ToString() + " Deg " + sUnits;

        // config the chart
        rc_linechart.Series.Clear();

        rc_linechart.Series.Add(sBAS_Label);
        rc_linechart.Series.Add(sEM_Label);
        rc_linechart.Series.Add(sToleranceLabel);

        rc_linechart.Legends.Add(sBAS_Label);
        rc_linechart.Legends.Add(sEM_Label);
        rc_linechart.Legends.Add(sToleranceLabel);

        rc_linechart.Legends[sBAS_Label].Alignment = System.Drawing.StringAlignment.Center;
        rc_linechart.Legends[sEM_Label].Alignment = System.Drawing.StringAlignment.Center;
        rc_linechart.Legends[sToleranceLabel].Alignment = System.Drawing.StringAlignment.Center;

        rc_linechart.Legends[sBAS_Label].Docking = Docking.Bottom;
        rc_linechart.Legends[sEM_Label].Docking = Docking.Bottom;
        rc_linechart.Legends[sToleranceLabel].Docking = Docking.Bottom;

        rc_linechart.Series[sEM_Label].Color = Color.FromArgb(255, 255, 165, 0);
        rc_linechart.Series[sEM_Label].ChartType = SeriesChartType.Line;
        rc_linechart.Series[sEM_Label].MarkerStyle = MarkerStyle.None;
        rc_linechart.Series[sEM_Label].BorderWidth = 2;
        rc_linechart.Series[sEM_Label].XAxisType = AxisType.Primary;

        rc_linechart.Series[sBAS_Label].ChartType = SeriesChartType.Line;
        rc_linechart.Series[sBAS_Label].Color = Color.Blue;
        rc_linechart.Series[sBAS_Label].MarkerStyle = MarkerStyle.None;
        rc_linechart.Series[sBAS_Label].BorderWidth = 2;
        rc_linechart.Series[sBAS_Label].XAxisType = AxisType.Secondary;

        rc_linechart.Series[sToleranceLabel].Color = Color.FromArgb(35, 60, 179, 113);
        rc_linechart.Series[sToleranceLabel].ChartType = SeriesChartType.SplineRange;
        rc_linechart.Series[sToleranceLabel].XAxisType = AxisType.Primary;
        rc_linechart.Series[sToleranceLabel]["LineTension"] = "0.6";

        rc_linechart.ChartAreas[0].AxisX.IsMarginVisible = false;
        rc_linechart.ChartAreas[0].Area3DStyle.Enable3D = false;
        rc_linechart.ChartAreas[0].AxisX.LabelStyle.IsEndLabelVisible = true;
        rc_linechart.ChartAreas[0].BackSecondaryColor = Color.White;
        rc_linechart.ChartAreas[0].BackGradientStyle = GradientStyle.None;
        rc_linechart.ChartAreas[0].Area3DStyle.LightStyle = LightStyle.Simplistic;
        rc_linechart.ChartAreas[0].Area3DStyle.Perspective = 10;
        rc_linechart.ChartAreas[0].Area3DStyle.IsRightAngleAxes = false;

        rc_linechart.AntiAliasing = AntiAliasingStyles.All;
        rc_linechart.TextAntiAliasingQuality = TextAntiAliasingQuality.High;

        rc_linechart.ChartAreas[0].AxisX.LabelStyle.Format = "MM/dd/yyyy HH:mm";
        rc_linechart.ChartAreas[0].AxisX2.LabelStyle.Enabled = false;
        rc_linechart.ChartAreas[0].AxisX2.MajorGrid.Enabled = false;
        rc_linechart.ChartAreas[0].AxisX2.MinorGrid.Enabled = false;
        rc_linechart.ChartAreas[0].AxisX2.MajorTickMark.Enabled = false;
        rc_linechart.ChartAreas[0].AxisX2.MinorGrid.Enabled = false;
        rc_linechart.ChartAreas[0].AxisX2.MinorTickMark.Enabled = false;

        rc_linechart.ChartAreas[0].AxisY.LabelStyle.Format = "0.00";

        // query and graph the energy modeling data ----------------------------------------------------
        strSQLQuery = "SELECT [VariableValue] ";
        strSQLQuery += ",[Month] ";
        strSQLQuery += ",[Day] ";
        strSQLQuery += ",[Hour] ";
        strSQLQuery += ",[Minute] ";
        strSQLQuery += ",[DayType] ";
        strSQLQuery += ",[KeyValue] ";
        strSQLQuery += ",[VariableName] ";
        strSQLQuery += ",[VariableUnits] ";
        strSQLQuery += "FROM [tbl_energymodeling_ReportVariableData] ";

        strSQLQuery += "INNER JOIN [tbl_energymodeling_Time] on [tbl_energymodeling_ReportVariableData].TimeIndex = [tbl_energymodeling_Time].TimeIndex ";
        strSQLQuery += "INNER JOIN [tbl_energymodeling_ReportVariableDataDictionary] ON [tbl_energymodeling_ReportVariableData].ReportVariableDataDictionaryIndex = [tbl_energymodeling_ReportVariableDataDictionary].ReportVariableDataDictionaryIndex ";

        strSQLQuery += "WHERE [tbl_energymodeling_ReportVariableData].[fk_facility_id] = '" + s_facility_id + "' ";
        strSQLQuery += "AND [tbl_energymodeling_ReportVariableData].[fk_zone_id] = '" + s_zone_id + "' ";

        strSQLQuery += "AND [MONTH] BETWEEN " + start_date.Month + " AND " + end_date.Month + " ";
        strSQLQuery += "AND [DAY] BETWEEN " + start_date.Day + " AND " + end_date.Day + " ";

        strSQLQuery += "AND [VariableName] = '" + sIDD_Class_Field + "' ";
        strSQLQuery += "order by [Month], [Day], [Hour], [Minute]";

        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
        ecodomus_client.sql_command.CommandText = strSQLQuery;
        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

        double[] dValues = new double[1];
        double[] yValue1 = new double[1];
        double[] yValue2 = new double[1];
        string[] dtValues = new string[1];

        while (ecodomus_client.sql_reader.Read())
        {
            double dRaw = double.Parse(ecodomus_client.sql_reader["VariableValue"].ToString());
            double dVal;

            // if the units are F, convert the energy modeling data to deg f.
            if (sUnits == "F")
                dVal = ct.ConvertCelsiusToFahrenheit((float)dRaw);
            else
                dVal = dRaw;

            if (dVal > dMax)
                dMax = dVal;
            if (dVal < dMin)
                dMin = dVal;

            string sMonth = string.Format("{0:00}", ecodomus_client.sql_reader["Month"]);
            string sDay = string.Format("{0:00}", ecodomus_client.sql_reader["Day"]);
            string sHour = string.Format("{0:00}", int.Parse(ecodomus_client.sql_reader["Hour"].ToString()) - 1);
            string sMinute = string.Format("{0:00}", ecodomus_client.sql_reader["Minute"]);
            string sYear = rdtp_from.SelectedDate.Value.Year.ToString();

            DateTime dt = DateTime.Parse(sMonth + "/" + sDay + "/" + sYear + " " + sHour + ":" + sMinute + ":00");

            if ((dt >= start_date) && (dt <= end_date))
            {
                dValues[yValue1.Length - 1] = dVal;
                yValue1[yValue1.Length - 1] = (dVal - dAdjustedTolerance);
                yValue2[yValue1.Length - 1] = (dVal + dAdjustedTolerance);
                dtValues[yValue1.Length - 1] = dt.ToString();

                if ((dVal + dAdjustedTolerance) > dMax)
                    dMax = (dVal + dAdjustedTolerance);

                if ((dVal - dAdjustedTolerance) < dMin)
                    dMin = (dVal - dAdjustedTolerance);

                int iNewLen = yValue1.Length + 1;
                Array.Resize(ref dValues, iNewLen);
                Array.Resize(ref yValue1, iNewLen);
                Array.Resize(ref yValue2, iNewLen);
                Array.Resize(ref dtValues, iNewLen);

                //if (CheckBox2.Checked == true)
                //{
                //    DataRow row1 = dtGridView.NewRow();
                //    row1[0] = sEM_Label;
                //    row1[1] = dt.ToString();
                //    row1[2] = dVal.ToString();
                //    dtGridView.Rows.Add(row1);
                //}
            }
        }
        ecodomus_client.sql_reader.Close();

        int iFinalLen = yValue1.Length - 1;
        Array.Resize(ref dValues, iFinalLen);
        Array.Resize(ref yValue1, iFinalLen);
        Array.Resize(ref yValue2, iFinalLen);
        Array.Resize(ref dtValues, iFinalLen);

        rc_linechart.Series[sEM_Label].Points.DataBindXY(dtValues, dValues);
        rc_linechart.Series[sToleranceLabel].Points.DataBindY(yValue1, yValue2);

        // query and graph the BAS data ----------------------------------------------------
        strSQLQuery = "SELECT [tag_name] ";
        strSQLQuery += ",[time_stamp] ";
        strSQLQuery += ",[day] ";
        strSQLQuery += ",[month] ";
        strSQLQuery += ",[year] ";
        strSQLQuery += ",[dayofyear] ";
        strSQLQuery += ",[current_value] ";
        strSQLQuery += ",[last_value] ";
        strSQLQuery += ",[delta] ";
        strSQLQuery += ",[quality] ";
        strSQLQuery += "FROM [tbl_bas_attribute_history] ";
        strSQLQuery += "WHERE [tag_name] = '" + sTagName + "' ";
        strSQLQuery += "AND [time_stamp] >= '" + start_date + "' AND [time_stamp] <= '" + end_date + "' ORDER BY [time_stamp] asc";

        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
        ecodomus_client.sql_command.CommandText = strSQLQuery;
        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

        while (ecodomus_client.sql_reader.Read())
        {
            double dRaw = double.Parse(ecodomus_client.sql_reader["current_value"].ToString());
            double dVal;

            // if the units are C, convert the BAS data to deg C.
            if (sUnits == "C")
                dVal = ct.ConvertFahrenheitToCelsius((float)dRaw);
            else
                dVal = dRaw;

            if (dVal > dMax)
                dMax = dVal;
            if (dVal < dMin)
                dMin = dVal;

            DateTime dt = DateTime.Parse(ecodomus_client.sql_reader["time_stamp"].ToString());
            rc_linechart.Series[sBAS_Label].Points.AddY(dVal);

            //if (CheckBox2.Checked == true)
            //{
            //    DataRow row1 = dtGridView.NewRow();
            //    row1[0] = sBAS_Label;
            //    row1[1] = dt.ToString();
            //    row1[2] = dVal.ToString();
            //    dtGridView.Rows.Add(row1);
            //}
        }
        ecodomus_client.sql_reader.Close();

        // query and graph the weather data ----------------------------------------------------
        Guid weatherSourceId = Guid.Empty;
        string weatherdatavalues = "";
        string Station_Name = "";
        string Station_ID = "";

        for (int k = 0; k < rcb_weather_source.CheckedItems.Count; k++)
        {
            if (rcb_weather_source.CheckedItems[k].Checked == true)
            {
                weatherSourceId = new Guid(rcb_weather_source.CheckedItems[k].Value);
                Station_Name = rcb_weather_source.CheckedItems[k].Text.ToString();
                Station_ID = rcb_weather_source.CheckedItems[k].Text.Substring(0, 4);
            }
        }

        for (int k = 0; k < rcb_weather_data.CheckedItems.Count; k++)
        {
            weatherdatavalues = weatherdatavalues + rcb_weather_data.CheckedItems[k].Value + ",";
        }

        if (weatherdatavalues != "")
            weatherdatavalues = weatherdatavalues.TrimEnd(',');

        if (weatherSourceId != Guid.Empty && weatherdatavalues != "")
        {
            strSQLQuery = "SELECT [station_id] ";
            strSQLQuery += ",[timestamp_local] ";
            strSQLQuery += ",[weather] ";

            if (rcb_weather_data.Items[0].Checked == true)
            {
                strSQLQuery += ",[temp_c] ";
                rc_linechart.Series.Add("temp_c");
                rc_linechart.Legends.Add("temp_c");
                rc_linechart.Legends["temp_c"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["temp_c"].Docking = Docking.Bottom;
                rc_linechart.Series["temp_c"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["temp_c"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["temp_c"].BorderWidth = 2;
                rc_linechart.Series["temp_c"].XAxisType = AxisType.Secondary;
            }

            if (rcb_weather_data.Items[1].Checked == true)
            {
                strSQLQuery += ",[temp_f] ";
                rc_linechart.Series.Add("temp_f");
                rc_linechart.Legends.Add("temp_f");
                rc_linechart.Legends["temp_f"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["temp_f"].Docking = Docking.Bottom;
                rc_linechart.Series["temp_f"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["temp_f"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["temp_f"].BorderWidth = 2;
                rc_linechart.Series["temp_f"].XAxisType = AxisType.Secondary;
            }


            if (rcb_weather_data.Items[2].Checked == true)
            {
                strSQLQuery += ",[relative_humidity] ";
                rc_linechart.Series.Add("relative_humidity");
                rc_linechart.Legends.Add("relative_humidity");
                rc_linechart.Legends["relative_humidity"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["relative_humidity"].Docking = Docking.Bottom;
                rc_linechart.Series["relative_humidity"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["relative_humidity"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["relative_humidity"].BorderWidth = 2;
                rc_linechart.Series["relative_humidity"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[3].Checked == true)
            {
                strSQLQuery += ",[wind_degrees] ";
                rc_linechart.Series.Add("wind_degrees");
                rc_linechart.Legends.Add("wind_degrees");
                rc_linechart.Legends["wind_degrees"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["wind_degrees"].Docking = Docking.Bottom;
                rc_linechart.Series["wind_degrees"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["wind_degrees"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["wind_degrees"].BorderWidth = 2;
                rc_linechart.Series["wind_degrees"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[4].Checked == true)
            {
                strSQLQuery += ",[wind_mph] ";
                rc_linechart.Series.Add("wind_mph");
                rc_linechart.Legends.Add("wind_mph");
                rc_linechart.Legends["wind_mph"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["wind_mph"].Docking = Docking.Bottom;
                rc_linechart.Series["wind_mph"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["wind_mph"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["wind_mph"].BorderWidth = 2;
                rc_linechart.Series["wind_mph"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[5].Checked == true)
            {
                strSQLQuery += ",[wind_gust_mph] ";
                rc_linechart.Series.Add("wind_gust_mph");
                rc_linechart.Legends.Add("wind_gust_mph");
                rc_linechart.Legends["wind_gust_mph"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["wind_gust_mph"].Docking = Docking.Bottom;
                rc_linechart.Series["wind_gust_mph"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["wind_gust_mph"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["wind_gust_mph"].BorderWidth = 2;
                rc_linechart.Series["wind_gust_mph"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[6].Checked == true)
            {
                strSQLQuery += ",[wind_kt] ";
                rc_linechart.Series.Add("wind_kt");
                rc_linechart.Legends.Add("wind_kt");
                rc_linechart.Legends["wind_kt"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["wind_kt"].Docking = Docking.Bottom;
                rc_linechart.Series["wind_kt"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["wind_kt"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["wind_kt"].BorderWidth = 2;
                rc_linechart.Series["wind_kt"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[7].Checked == true)
            {
                strSQLQuery += ",[wind_gust_kt] ";
                rc_linechart.Series.Add("wind_gust_kt");
                rc_linechart.Legends.Add("wind_gust_kt");
                rc_linechart.Legends["wind_gust_kt"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["wind_gust_kt"].Docking = Docking.Bottom;
                rc_linechart.Series["wind_gust_kt"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["wind_gust_kt"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["wind_gust_kt"].BorderWidth = 2;
                rc_linechart.Series["wind_gust_kt"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[8].Checked == true)
            {
                strSQLQuery += ",[pressure_mb] ";
                rc_linechart.Series.Add("pressure_mb");
                rc_linechart.Legends.Add("pressure_mb");
                rc_linechart.Legends["pressure_mb"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["pressure_mb"].Docking = Docking.Bottom;
                rc_linechart.Series["pressure_mb"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["pressure_mb"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["pressure_mb"].BorderWidth = 2;
                rc_linechart.Series["pressure_mb"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[9].Checked == true)
            {
                strSQLQuery += ",[pressure_in] ";
                rc_linechart.Series.Add("pressure_in");
                rc_linechart.Legends.Add("pressure_in");
                rc_linechart.Legends["pressure_in"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["pressure_in"].Docking = Docking.Bottom;
                rc_linechart.Series["pressure_in"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["pressure_in"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["pressure_in"].BorderWidth = 2;
                rc_linechart.Series["pressure_in"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[10].Checked == true)
            {
                strSQLQuery += ",[dewpoint_f] ";
                rc_linechart.Series.Add("dewpoint_f");
                rc_linechart.Legends.Add("dewpoint_f");
                rc_linechart.Legends["dewpoint_f"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["dewpoint_f"].Docking = Docking.Bottom;
                rc_linechart.Series["dewpoint_f"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["dewpoint_f"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["dewpoint_f"].BorderWidth = 2;
                rc_linechart.Series["dewpoint_f"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[11].Checked == true)
            {
                strSQLQuery += ",[dewpoint_c] ";
                rc_linechart.Series.Add("dewpoint_c");
                rc_linechart.Legends.Add("dewpoint_c");
                rc_linechart.Legends["dewpoint_c"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["dewpoint_c"].Docking = Docking.Bottom;
                rc_linechart.Series["dewpoint_c"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["dewpoint_c"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["dewpoint_c"].BorderWidth = 2;
                rc_linechart.Series["dewpoint_c"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[12].Checked == true)
            {
                strSQLQuery += ",[heat_index_f] ";
                rc_linechart.Series.Add("heat_index_f");
                rc_linechart.Legends.Add("heat_index_f");
                rc_linechart.Legends["heat_index_f"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["heat_index_f"].Docking = Docking.Bottom;
                rc_linechart.Series["heat_index_f"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["heat_index_f"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["heat_index_f"].BorderWidth = 2;
                rc_linechart.Series["heat_index_f"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[13].Checked == true)
            {
                strSQLQuery += ",[heat_index_c] ";
                rc_linechart.Series.Add("heat_index_c");
                rc_linechart.Legends.Add("heat_index_c");
                rc_linechart.Legends["heat_index_c"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["heat_index_c"].Docking = Docking.Bottom;
                rc_linechart.Series["heat_index_c"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["heat_index_c"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["heat_index_c"].BorderWidth = 2;
                rc_linechart.Series["heat_index_c"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[14].Checked == true)
            {
                strSQLQuery += ",[windchill_f] ";
                rc_linechart.Series.Add("windchill_f");
                rc_linechart.Legends.Add("windchill_f");
                rc_linechart.Legends["windchill_f"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["windchill_f"].Docking = Docking.Bottom;
                rc_linechart.Series["windchill_f"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["windchill_f"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["windchill_f"].BorderWidth = 2;
                rc_linechart.Series["windchill_f"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[15].Checked == true)
            {
                strSQLQuery += ",[windchill_c] ";
                rc_linechart.Series.Add("windchill_c");
                rc_linechart.Legends.Add("windchill_c");
                rc_linechart.Legends["windchill_c"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["windchill_c"].Docking = Docking.Bottom;
                rc_linechart.Series["windchill_c"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["windchill_c"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["windchill_c"].BorderWidth = 2;
                rc_linechart.Series["windchill_c"].XAxisType = AxisType.Secondary;

            }

            if (rcb_weather_data.Items[16].Checked == true)
            {
                strSQLQuery += ",[visibility_mi] ";
                rc_linechart.Series.Add("visibility_mi");
                rc_linechart.Legends.Add("visibility_mi");
                rc_linechart.Legends["visibility_mi"].Alignment = System.Drawing.StringAlignment.Center;
                rc_linechart.Legends["visibility_mi"].Docking = Docking.Bottom;
                rc_linechart.Series["visibility_mi"].ChartType = SeriesChartType.Line;
                rc_linechart.Series["visibility_mi"].MarkerStyle = MarkerStyle.None;
                rc_linechart.Series["visibility_mi"].BorderWidth = 2;
                rc_linechart.Series["visibility_mi"].XAxisType = AxisType.Secondary;
            }

            strSQLQuery += "FROM [tbl_bas_weather_history] ";
            strSQLQuery += "WHERE [station_id] = '" + Station_ID + "' ";
            strSQLQuery += "AND [timestamp_local] >= '" + start_date + "' AND [timestamp_local] <= '" + end_date + "' ORDER BY [timestamp_local] asc";

            ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
            ecodomus_client.sql_command.CommandText = strSQLQuery;
            ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

            double d_weather_val;

            while (ecodomus_client.sql_reader.Read())
            {

                if (rcb_weather_data.Items[0].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["temp_c"].ToString());
                    rc_linechart.Series["temp_c"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;
                }

                if (rcb_weather_data.Items[1].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["temp_f"].ToString());
                    rc_linechart.Series["temp_f"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;
                }

                //[relative_humidity] ";
                if (rcb_weather_data.Items[2].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["relative_humidity"].ToString());
                    rc_linechart.Series["relative_humidity"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[wind_degrees] ";
                if (rcb_weather_data.Items[3].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["wind_degrees"].ToString());
                    rc_linechart.Series["wind_degrees"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[wind_mph] ";
                if (rcb_weather_data.Items[4].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["wind_mph"].ToString());
                    rc_linechart.Series["wind_mph"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[wind_gust_mph] ";
                if (rcb_weather_data.Items[5].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["wind_gust_mph"].ToString());
                    rc_linechart.Series["wind_gust_mph"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[wind_kt] ";
                if (rcb_weather_data.Items[6].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["wind_kt"].ToString());
                    rc_linechart.Series["wind_kt"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[wind_gust_kt] ";
                if (rcb_weather_data.Items[7].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["wind_gust_kt"].ToString());
                    rc_linechart.Series["wind_gust_kt"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[pressure_mb] ";
                if (rcb_weather_data.Items[8].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["pressure_mb"].ToString());
                    rc_linechart.Series["pressure_mb"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[pressure_in] ";
                if (rcb_weather_data.Items[9].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["pressure_in"].ToString());
                    rc_linechart.Series["pressure_in"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[dewpoint_f] ";
                if (rcb_weather_data.Items[10].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["dewpoint_f"].ToString());
                    rc_linechart.Series["dewpoint_f"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[dewpoint_c] ";
                if (rcb_weather_data.Items[11].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["dewpoint_c"].ToString());
                    rc_linechart.Series["dewpoint_c"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[heat_index_f] ";
                if (rcb_weather_data.Items[12].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["heat_index_f"].ToString());
                    rc_linechart.Series["heat_index_f"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[heat_index_c] ";
                if (rcb_weather_data.Items[13].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["heat_index_c"].ToString());
                    rc_linechart.Series["heat_index_c"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[windchill_f] ";
                if (rcb_weather_data.Items[14].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["windchill_f"].ToString());
                    rc_linechart.Series["windchill_f"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[windchill_c] ";
                if (rcb_weather_data.Items[15].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["windchill_c"].ToString());
                    rc_linechart.Series["windchill_c"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

                //[visibility_mi] ";
                if (rcb_weather_data.Items[16].Checked == true)
                {
                    d_weather_val = double.Parse(ecodomus_client.sql_reader["visibility_mi"].ToString());
                    rc_linechart.Series["visibility_mi"].Points.AddY(d_weather_val);
                    if (d_weather_val > dMax)
                        dMax = d_weather_val;
                    if (d_weather_val < dMin)
                        dMin = d_weather_val;

                }

            }

            ecodomus_client.sql_reader.Close();
        }

        rc_linechart.ChartAreas[0].AxisY.Minimum = dMin - 0.5;
        rc_linechart.ChartAreas[0].AxisY.Maximum = dMax + 0.5;

        rc_linechart.Titles.Add("BAS: " + sTagName + " vs. EM Zone: " + s_zone_name + "   (" + dPerformanceValue.ToString("F1") + " % Accuracy With " + dAdjustedTolerance.ToString() + " Deg " + sUnits + ". Tolerance)");

        return bSuccess;
    }


    protected void cmb_week_type0_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {

    }

    protected void cmb_sim_run_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {


    }

    protected void cmb_sim_run_ItemsChecked(object sender, RadComboBoxItemEventArgs e)
    {
        bool bFound = false;
        string s_field_name = "";
        string s_field_value = "";
        string strBeginMonth = "";
        string strEndMonth = "";
        string strBeginDayOfMonth = "";
        string strEndDayOfMonth = "";
        string strStartYear = "";

        // ignore unchecked items
        if (e.Item.Checked == true)
        {
            // deselect all the other items
            int iSelectedIndex = e.Item.Index;
            for (int i = 0; i < cmb_sim_run.Items.Count; i++)
            {
                if (i != iSelectedIndex)
                    cmb_sim_run.Items[i].Checked = false;
            }

            // get the data for the selected one
            EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
            EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();

            string sConnectionString = obj_energy_plus_client.Get_Connection_String(obj_energy_plus_model, SessionController.ConnectionString) + ";MultipleActiveResultSets=True;"; //@"Data Source=ZCON-79\SQL2008R2;Initial Catalog=GSAR3;User Id=sa;Password=zcon@123;MultipleActiveResultSets=True;";
            ecodomus_client.sql_connection.ConnectionString = sConnectionString;
            if (ecodomus_client.ConnectClientDatabase())
            {

                string[] sItems = e.Item.Value.Split(',');
                string s_sim_request_id = sItems[0].Replace("[SIM_REQUEST_ID]", "").ToString();
                string s_facility_id = sItems[1].Replace("[SIM_FACILITY_ID]", "").ToString();
                string s_project_id = sItems[2].Replace("[SIM_PROJECT_ID]", "").ToString();     // "d1b6bd96-00a8-4464-a489-6954ddc7b36c"
                //= new Guid(SessionController.Users_.Profileid);
                string strSQLQuery = "";
                strSQLQuery += "SELECT field_name ,value from ";
	            strSQLQuery += "tbl_energymodel_simulation_object_values ";
	            strSQLQuery += "INNER JOIN tbl_energymodel_object_fields ";
	            strSQLQuery += "ON tbl_energymodel_simulation_object_values.fk_field_id=tbl_energymodel_object_fields.pk_field_id ";
	            strSQLQuery += "INNER JOIN tbl_energymodel_objects "; 
	            strSQLQuery += "ON tbl_energymodel_object_fields.fk_object_id=tbl_energymodel_objects.pk_object_id ";
	            strSQLQuery += "INNER JOIN tbl_energymodel_simulation_objects "; 
	            strSQLQuery += "ON tbl_energymodel_simulation_objects.pk_simulation_object_id=tbl_energymodel_simulation_object_values.pk_simulation_object_id ";
	            strSQLQuery += "WHERE tbl_energymodel_objects.object_name='RunPeriod' ";
                strSQLQuery += "AND tbl_energymodel_simulation_objects.fk_facility_id='" + s_facility_id + "' ";

                ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                ecodomus_client.sql_command.CommandType = CommandType.Text;
                ecodomus_client.sql_command.CommandText = strSQLQuery;
                ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                while (ecodomus_client.sql_reader.Read())
                {
                    s_field_name = ecodomus_client.sql_reader["field_name"].ToString();
                    s_field_value = ecodomus_client.sql_reader["value"].ToString();

                    switch (s_field_name)
                    {
                        case "Begin Month":
                            strBeginMonth = s_field_value;
                            bFound = true;
                            break;

                        case "End Month":
                            strEndMonth = s_field_value;
                            break;

                        case "Begin Day of Month":
                            strBeginDayOfMonth = s_field_value;
                            break;

                        case "End Day of Month":
                            strEndDayOfMonth = s_field_value;
                            break;

                        case "Start Year":
                            strStartYear = s_field_value;
                            break;

                        default:
                            break;
                    }
                }

                ecodomus_client.sql_reader.Close();
                ecodomus_client.CloseClientDatabase();
            }

            if (strStartYear.Length == 0)
                strStartYear = DateTime.Now.Year.ToString();

            if (bFound)
            {
                rdtp_from.SelectedDate = Convert.ToDateTime(strBeginMonth + "/" + strBeginDayOfMonth + "/" + strStartYear);
                rdtp_to.SelectedDate = Convert.ToDateTime(strEndMonth + "/" + strEndDayOfMonth + "/" + strStartYear);
            }
            else
            {
                rdtp_from.SelectedDate = Convert.ToDateTime("1/1/" + DateTime.Now.Year.ToString());
                rdtp_to.SelectedDate = Convert.ToDateTime("12/31/" + DateTime.Now.Year.ToString());
            }
        }
    }

    private void ShowPopUpMsg(string msg)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("alert('");
        sb.Append(msg.Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'"));
        sb.Append("');");
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showalert", sb.ToString(), true);
    }

    //protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    //{

    //    if (CheckBox1.Checked == true)
    //        Panel_AAS.Visible = true;
    //    else
    //        Panel_AAS.Visible = false;

    //    if ((CheckBox1.Checked == true) || (CheckBox2.Checked == true))
    //    {
    //        int iTotalHeight = 728;
    //        if (CheckBox2.Checked == true)
    //            iTotalHeight -= 175;
    //        if (CheckBox1.Checked == true)
    //            iTotalHeight -= 153;
    //        rc_linechart.Height = iTotalHeight;
    //    }
    //    else
    //    {
    //        rc_linechart.Height = 728;
    //    }

    //}
    
    //protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (CheckBox2.Checked == true)
    //        Panel_DataTable.Visible = true;
    //    else
    //        Panel_DataTable.Visible = false;

    //    if ((CheckBox1.Checked == true) || (CheckBox2.Checked == true))
    //    {
    //        int iTotalHeight = 728;
    //        if (CheckBox2.Checked == true)
    //            iTotalHeight -= 175;
    //        if (CheckBox1.Checked == true)
    //            iTotalHeight -= 153;
    //        rc_linechart.Height = iTotalHeight;
    //    }
    //    else
    //    {
    //        rc_linechart.Height = 728;
    //    }
    //}

    //protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    //{
 
    //}

    protected void rcb_unit0_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        switch (e.Text)
        {
            case "Chart":
                MultiView1.SetActiveView(tab1);
                break;
            //case "Settings":
            //    MultiView1.SetActiveView(tab2);
            //    break;
            //case "Data":
            //    MultiView1.SetActiveView(tab3);
            //    break;
            default:
                break;
        }
    }
    protected void SearchButton_Click(object sender, EventArgs e)
    {

    }
}

//        sql_command = sql_connection.CreateCommand();
//        sql_command.CommandType = CommandType.StoredProcedure;
//        sql_command.CommandText = "select_bas_history_by_tagname";
//        sql_command.Parameters.AddWithValue("@TagName", strTagName);
//        sql_command.Parameters.AddWithValue("@FromDate", dtStart.ToString());
//        sql_command.Parameters.AddWithValue("@ToDate", dtEnd.ToString());
//        mySqlDataAdapter = new SqlDataAdapter(sql_command);
//        mySqlDataAdapter.Fill(dsTest);