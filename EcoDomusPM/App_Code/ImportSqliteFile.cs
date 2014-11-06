using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using EnergyPlus;
using EcoDomus.Session;
using System.Diagnostics;
using System.IO;
using System.Data.SQLite;

/// <summary>
/// Summary description for ImportSqliteFile
/// </summary>
public class ImportSqliteFile
{
    static EcoDomus_Data_Connection ecodomus_client;
    static SQLiteConnection sqlite_connection;
    static SQLiteCommand sqlite_command;
    static ZoneItemCollection zones_collection;
    static MeterItemCollection meters_collection;
    public ImportSqliteFile()
    {
    }
    public string getConnstr()
    {
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        string con_str = obj_energy_plus_client.Get_Connection_String(obj_energy_plus_model, SessionController.ConnectionString);
        return con_str;
    }
		 public void GetRunSimulationRequest(string filepath,string Idffilename,string weatherfilePath,string weatherfilename)
        {
            DataSet ds = new DataSet();
            DataSet dset = new DataSet();
            try
            {
                SqlConnection cn = default(SqlConnection);
                string strCn = null;
                SqlCommand cmd = default(SqlCommand);
                strCn = getConnstr();
             
               
                Guid userid;
               
             
                        userid = new Guid(SessionController.Users_.UserId);
                        
                        //UpdateStautsForRequest(dt, i, "P", strCn);

                        RunSimulationTools(filepath, Idffilename, weatherfilePath, weatherfilename);
                        string file_name = Idffilename;
                            string file_path = filepath;
                            DeleteSimulationData(new Guid(SessionController.Users_.Em_facility_id), strCn);
                            if (string.IsNullOrEmpty(SessionController.Users_.Profileid))
                                SessionController.Users_.Profileid = Guid.Empty.ToString();
                            EnergyModelingSqlLiteImport(strCn, SessionController.Users_.Em_facility_id, SessionController.Users_.Profileid, Guid.Empty.ToString(), file_name, file_path);
                       
                        //UpdateStautsForRequest(dt, i, "C", strCn);
                  
            }
            catch (Exception ex)
            {

                //throw ex;
            }
        }

        private void DeleteSimulationData(Guid facility_id, string conn)
        {

            SqlCommand cmd = default(SqlCommand);
            SqlConnection cn = default(SqlConnection);
            try
            {
                cn = new SqlConnection(conn);
                cmd = new SqlCommand("proc_delete_energy_modeling_simulation_records", cn);
                cmd.Parameters.AddWithValue("@facility_id", facility_id);

                cmd.CommandType = CommandType.StoredProcedure;
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                cmd.CommandTimeout = 3600;
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                //log_file_writer("Check the Service: proc_InsertUpdate_Export_Request ", Convert.ToString(ex.Message));
                //throw ex;
            }
            finally
            {
                cn.Close();

            }


        }

        private void RunSimulationTools(string file_path, string file_name, string weather_file_path, string weather_file_name)
        {
            try
            {
                string full_path = Path.Combine(file_path, file_name);
                string file_extension = Path.GetExtension(full_path);
                full_path = full_path.Replace(file_extension, "");
                string full_weather_path = Path.Combine(weather_file_path, weather_file_name);
                //full_weather_path = "";
                string weather_file_extension = Path.GetExtension(full_weather_path);
                // full_path = full_path.Replace(file_extension, "");
                ProcessStartInfo startInfo = new ProcessStartInfo();
                startInfo.CreateNoWindow = false;
                startInfo.UseShellExecute = false;
                startInfo.FileName = Convert.ToString(ConfigurationManager.AppSettings["EPBatchFilePath"]) + "RunEPlus.bat ";
                startInfo.WindowStyle = ProcessWindowStyle.Normal;
                startInfo.WorkingDirectory = Convert.ToString(ConfigurationManager.AppSettings["EPBatchFilePath"]);
                //string[] args = { full_path, file_path , Convert.ToString(ConfigurationManager.AppSettings["EPBatchFilePath"])+"PostProcess\\ReadVarsESO.exe", full_weather_path };

                string[] args = { "\"" + full_path + "\"", file_path, Convert.ToString(ConfigurationManager.AppSettings["EPBatchFilePath"]) + "PostProcess\\ReadVarsESO.exe", full_weather_path };
                startInfo.Arguments = String.Join(" ", args);                 //"\"" + full_path + "\"";

                Process exeProcess = Process.Start(startInfo);



                //ProcessStartInfo startInfo = new ProcessStartInfo();
                //startInfo.CreateNoWindow = false;
                //startInfo.UseShellExecute = false;
                //startInfo.FileName = "C:\\EnergyPlusV7-0-0\\RunEPlus.bat";
                //startInfo.WindowStyle = ProcessWindowStyle.Normal;
                //string[] args = { @"C:\Users\priyankas\Desktop\EM\4ZoneWithShading_Simple_1", @"C:\Users\priyankas\Desktop\EM\", @"C:\EnergyPlusV7-0-0\PostProcess\ReadVarsESO.exe", @"C:\Users\priyankas\Desktop\EM\USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw" };
                //startInfo.Arguments = String.Join(" ", args);
                //startInfo.WorkingDirectory = Convert.ToString("C:\\EnergyPlusV7-0-0\\");
                //Process exeProcess = Process.Start(startInfo);

            }
            catch (Exception ex)
            {

                //throw ex;
            }
        }

        private void UpdateStautsForRequest(DataTable dt, int RowNo, string status, string conn)
        {
            SqlCommand cmd = default(SqlCommand);
            SqlConnection cn = default(SqlConnection);
            try
            {
                cn = new SqlConnection(conn);
                cmd = new SqlCommand("proc_insert_update_energy_modeling_simulation_request", cn);
                cmd.Parameters.AddWithValue("@pk_energymodel_simulation_request_id", dt.Rows[RowNo]["pk_energymodel_simulation_request_id"]);
                cmd.Parameters.AddWithValue("@fk_client_id", dt.Rows[RowNo]["fk_client_id"]);
                cmd.Parameters.AddWithValue("@fk_facility_id", dt.Rows[RowNo]["fk_facility_id"]);
                cmd.Parameters.AddWithValue("@fk_user_id", dt.Rows[RowNo]["fk_user_id"]);
                cmd.Parameters.AddWithValue("@fk_project_id", dt.Rows[RowNo]["fk_project_id"]);
                cmd.Parameters.AddWithValue("@uploaded_file_id", dt.Rows[RowNo]["uploaded_file_id"]);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@filepath", dt.Rows[RowNo]["filepath"]);
                cmd.Parameters.AddWithValue("@filename", dt.Rows[RowNo]["filename"]);
                cmd.Parameters.AddWithValue("@weather_file_name", dt.Rows[RowNo]["weather_file_name"]);
                cmd.Parameters.AddWithValue("@weather_file_path", dt.Rows[RowNo]["weather_file_path"]);
                cmd.CommandType = CommandType.StoredProcedure;
                if (cn.State == ConnectionState.Closed)
                cn.Open();
                cmd.CommandTimeout = 3600;
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                //log_file_writer("Check the Service: proc_InsertUpdate_Export_Request ", Convert.ToString(ex.Message));
                //throw ex;
            }
            finally
            {
                cn.Close();

            }
        }


        //-------------- import sqLITE

        private void EnergyModelingSqlLiteImport(string Constr, string facilityId, string projectId, string em_simulation_id, string file_name, string file_path)
        {
            string file = Path.GetFileNameWithoutExtension(file_name);
            file = file + ".sql";

            string full_path = Path.Combine(file_path, file);
            if (File.Exists(full_path))
            {
                string ClientDBName;
                bool bSaveCurrentRecord = false;
                double dDummy = 0.0;
                string strTmp = "";
                string[] strTableName;
                string[] strTableNameEcoDomus;

                string strInsertQuery = "";
                string strInsertFieldNames = "";
                string strInsertFieldValues = "";

                string strGuidNames = "";
                string strGuidValues = "";

                string strKeyValue = "";
                string strVariableName = "";
                string strFieldName = "";

                int iTableIndex = 0;
                int iTableCount = 0;
                int i_InsertCount = 0;
                int i_FailedCount = 0;
                var path_to_db = "";

                // zone collection
                zones_collection = new ZoneItemCollection();

                // meter collection
                meters_collection = new MeterItemCollection();

                // EcoDomus Client Connection ------------------------------------------------------------------------------------
                ecodomus_client = new EcoDomus_Data_Connection();
                ecodomus_client.bCancel = false;
                ecodomus_client.bOpened = false;

                // setup any guids we need

                path_to_db = full_path;
                ecodomus_client.fk_facility_id = facilityId;                  // fk_facility_id to test with
                ecodomus_client.fk_project_id = projectId;                    // fk_project_id  to test with
                ecodomus_client.fk_simulation_id = em_simulation_id;          // fk_simulation_id to test with

                //delete records in table for current facility id

                ///////////////////////////////////////////////////


                // setup the connection string
                ecodomus_client.sql_connection.ConnectionString = Constr;

                // open the database
                ecodomus_client.sql_connection.Open();
                if (ecodomus_client.sql_connection.State == ConnectionState.Open)
                {
                    ecodomus_client.bOpened = true;
                }

                // SQLite Data Connection ---------------------------------------------------------------------------------------
                sqlite_connection = new SQLiteConnection("Data Source=" + path_to_db + ";");
                sqlite_command = sqlite_connection.CreateCommand();
                bool bSQLiteOpened = false;

                // open the database
                sqlite_connection.Open();
                if (sqlite_connection.State == ConnectionState.Open)
                {
                    bSQLiteOpened = true;
                }

                // if the db opened
                if (bSQLiteOpened)
                {
                    // debugging - Insert the zones from here ?
                    //InsertZonesForDebugging();

                    // clear the errors from the last import of this facility and project SQLite data
                    ClearImportErrors();

                    long l_ZonesAdded = GetZoneCollection();
                    long l_MetersAdded = GetMeterCollection();

                    iTableCount = 10;
                    strTableName = new string[iTableCount];
                    strTableNameEcoDomus = new string[iTableCount];

                    strTableName[0] = "ReportVariableDataDictionary";
                    strTableNameEcoDomus[0] = "tbl_energymodeling_ReportVariableDataDictionary";

                    strTableName[1] = "ReportMeterDataDictionary";
                    strTableNameEcoDomus[1] = "tbl_energymodeling_ReportMeterDataDictionary";

                    strTableName[2] = "ReportVariableData";
                    strTableNameEcoDomus[2] = "tbl_energymodeling_ReportVariableData";

                    strTableName[3] = "ReportVariableExtendedData";
                    strTableNameEcoDomus[3] = "tbl_energymodeling_ReportVariableExtendedData";

                    strTableName[4] = "Time";
                    strTableNameEcoDomus[4] = "tbl_energymodeling_Time";

                    strTableName[5] = "ReportMeterData";
                    strTableNameEcoDomus[5] = "tbl_energymodeling_ReportMeterData";

                    strTableName[6] = "ReportMeterExtendedData";
                    strTableNameEcoDomus[6] = "tbl_energymodeling_ReportMeterExtendedData";

                    strTableName[7] = "ZoneGroups";
                    strTableNameEcoDomus[7] = "tbl_energymodeling_ZoneGroups";

                    strTableName[8] = "ZoneLists";
                    strTableNameEcoDomus[8] = "tbl_energymodeling_ZoneLists";

                    strTableName[9] = "Zones";
                    strTableNameEcoDomus[9] = "tbl_energymodeling_Zones";

                    for (iTableIndex = 0; iTableIndex < iTableCount; iTableIndex++)
                    {
                        sqlite_command.CommandText = "SELECT * FROM " + strTableName[iTableIndex];
                        i_InsertCount = 0;
                        i_FailedCount = 0;

                        SQLiteDataReader sqlite_datareader = sqlite_command.ExecuteReader();
                        while (sqlite_datareader.Read())
                        {
                            bSaveCurrentRecord = false;

                            // get guid data for variable Dictionary items
                            if (strTableName[iTableIndex] == "ReportVariableDataDictionary")
                            {
                                try
                                {
                                    strKeyValue = sqlite_datareader["KeyValue"].ToString();
                                    strVariableName = sqlite_datareader["VariableName"].ToString();
                                    ZoneItem z = GetZoneItemByName(strKeyValue);
                                    ecodomus_client.fk_zone_id = z.pk_zone_id;
                                    ecodomus_client.fk_attribute_id = Guid.Empty.ToString();
                                    bSaveCurrentRecord = z.SaveData;
                                }
                                catch (Exception ex)
                                {

                                    throw;
                                }

                            }

                            // get guid data for Variable Data items
                            if (strTableName[iTableIndex] == "ReportVariableData")
                            {
                                try
                                {
                                    long l_DictIndex = long.Parse(sqlite_datareader["ReportVariableDataDictionaryIndex"].ToString());
                                    ZoneItem z = GetZoneItemByIndex(l_DictIndex);
                                    ecodomus_client.fk_zone_id = z.pk_zone_id;
                                    ecodomus_client.fk_attribute_id = Guid.Empty.ToString();
                                    bSaveCurrentRecord = z.SaveData;
                                }
                                catch (Exception ex)
                                {

                                    throw;
                                }

                            }

                            // ReportVariableExtendedData
                            if (strTableName[iTableIndex] == "ReportVariableExtendedData")
                            {
                                try
                                {
                                    long l_DictIndex = long.Parse(sqlite_datareader["ReportVariableExtendedDataIndex"].ToString());
                                    ZoneItem z = GetZoneItemByIndex(l_DictIndex);
                                    ecodomus_client.fk_zone_id = z.pk_zone_id;
                                    ecodomus_client.fk_attribute_id = Guid.Empty.ToString();
                                    bSaveCurrentRecord = z.SaveData;
                                }
                                catch (Exception ex)
                                {

                                }
                            }

                            // get guid data for meter Dictionary items
                            if (strTableName[iTableIndex] == "ReportMeterDataDictionary")
                            {
                                try
                                {
                                    long l_DictIndex = long.Parse(sqlite_datareader["ReportMeterDataDictionaryIndex"].ToString());
                                    MeterItem m = GetMeterItemByIndex(l_DictIndex);
                                    ecodomus_client.fk_meter_id = m.pk_meter_id;
                                    bSaveCurrentRecord = m.SaveData;
                                }
                                catch (Exception ex)
                                {

                                    throw;
                                }

                            }

                            // get guid data for Meter Data items
                            if (strTableName[iTableIndex] == "ReportMeterData")
                            {
                                try
                                {
                                    long l_DictIndex = long.Parse(sqlite_datareader["ReportMeterDataDictionaryIndex"].ToString());
                                    MeterItem m = GetMeterItemByIndex(l_DictIndex);
                                    ecodomus_client.fk_meter_id = m.pk_meter_id;
                                    bSaveCurrentRecord = m.SaveData;
                                }
                                catch (Exception ex)
                                {

                                    throw;
                                }

                            }

                            // the zones data, there is some extended zone data here we may want.
                            if (strTableName[iTableIndex] == "Zones")
                            {
                                try
                                {
                                    string sName = sqlite_datareader["ZoneName"].ToString();
                                    ZoneItem z = GetZoneItemByName(sName);
                                    ecodomus_client.fk_zone_id = z.pk_zone_id;
                                    ecodomus_client.fk_attribute_id = Guid.Empty.ToString();
                                    bSaveCurrentRecord = z.SaveData;
                                }
                                catch (Exception ex)
                                {

                                    throw;
                                }

                            }

                            // always save the time data
                            if (strTableName[iTableIndex] == "Time")
                                bSaveCurrentRecord = true;

                            // save this record ?
                            if (bSaveCurrentRecord == true)
                            {
                                // build an insert query
                                strInsertQuery = "INSERT INTO " + strTableNameEcoDomus[iTableIndex] + "(";
                                strInsertFieldNames = "";
                                strInsertFieldValues = "";
                                for (int i = 0; i < sqlite_datareader.FieldCount; i++)
                                {
                                    // ignore data with empty values
                                    if (sqlite_datareader.GetValue(i).ToString().Length > 0)
                                    {
                                        // get the field name
                                        strFieldName = sqlite_datareader.GetName(i).ToString();
                                        strInsertFieldNames += strFieldName + ",";

                                        // test the data type, if a string then prepend and append "'"
                                        if (double.TryParse(sqlite_datareader[sqlite_datareader.GetName(i).ToString()].ToString(), out dDummy))
                                            strInsertFieldValues += sqlite_datareader.GetValue(i).ToString() + ",";
                                        else
                                            strInsertFieldValues += "'" + sqlite_datareader.GetValue(i).ToString() + "',";
                                    }
                                }

                                // trim the last unused comma in the strInsertFieldNames
                                strTmp = strInsertFieldNames.Substring(0, strInsertFieldNames.Length - 1);
                                strInsertFieldNames = strTmp;

                                // trim the last unused comma in the strInsertFieldValues
                                strTmp = strInsertFieldValues.Substring(0, strInsertFieldValues.Length - 1);
                                strInsertFieldValues = strTmp;

                                // update the guid data ?
                                if (strTableName[iTableIndex].Contains("Zone") == true)
                                {
                                    strGuidNames = "fk_facility_id, fk_zone_id, ";
                                    strGuidValues = "'" + ecodomus_client.fk_facility_id + "','" + ecodomus_client.fk_zone_id + "', ";
                                }
                                else
                                {
                                    if (strTableName[iTableIndex].Contains("Time") == true)
                                    {
                                        strGuidNames = "fk_facility_id, fk_project_id, fk_simulation_id, ";
                                        strGuidValues = "'" + ecodomus_client.fk_facility_id + "','" + ecodomus_client.fk_project_id + "','" + ecodomus_client.fk_simulation_id + "',";
                                    }
                                    else
                                    {
                                        strGuidNames = "fk_facility_id, fk_project_id, fk_simulation_id, fk_zone_id, fk_attribute_id, ";
                                        strGuidValues = "'" + ecodomus_client.fk_facility_id + "','" + ecodomus_client.fk_project_id + "','" + ecodomus_client.fk_simulation_id + "','" + ecodomus_client.fk_zone_id + "','" + ecodomus_client.fk_attribute_id + "',";
                                    }
                                }

                                // build the final query 
                                strInsertQuery += strGuidNames;
                                strInsertQuery += strInsertFieldNames;
                                strInsertQuery += ")VALUES(";
                                strInsertQuery += strGuidValues;
                                strInsertQuery += strInsertFieldValues;
                                strInsertQuery += ")";

                                if (ecodomus_client.bOpened)
                                {
                                    // setup the insert command
                                    ecodomus_client.sql_write_command.CommandType = System.Data.CommandType.Text;
                                    ecodomus_client.sql_write_command.CommandText = strInsertQuery;
                                    ecodomus_client.sql_write_command.Connection = ecodomus_client.sql_connection;

                                    try
                                    {
                                        ecodomus_client.sql_write_command.ExecuteNonQuery();
                                        i_InsertCount++;
                                    }
                                    catch (Exception ex)
                                    {
                                        i_FailedCount++;
                                    }
                                }

                            }
                        }
                        sqlite_datareader.Close();
                    }

                }
            }
        }

        private void SqlLiteImport(string Constr, string facilityId, string projectId, string em_simulation_id, string file_name, string file_path)
        {
            try
            {
                string file = Path.GetFileNameWithoutExtension(file_name);
                file = file + ".sql";

                string full_path = Path.Combine(file_path, file);
                if (File.Exists(full_path))
                {

                    bool bSaveCurrentRecord = false;
                    double dDummy = 0.0;
                    string strTmp = "";
                    string[] strTableName;
                    string[] strTableNameEcoDomus;

                    string strInsertQuery = "";
                    string strInsertFieldNames = "";
                    string strInsertFieldValues = "";

                    string strGuidNames = "";
                    string strGuidValues = "";

                    string strKeyValue = "";
                    string strVariableName = "";
                    string strFieldName = "";

                    int iTableIndex = 0;
                    int iTableCount = 0;
                    int i_InsertCount = 0;
                    int i_FailedCount = 0;
                    var path_to_db = "";

                    // zone collection
                    zones_collection = new ZoneItemCollection();

                    // meter collection
                    meters_collection = new MeterItemCollection();

                    // EcoDomus Client Connection ------------------------------------------------------------------------------------
                    ecodomus_client = new EcoDomus_Data_Connection();
                    ecodomus_client.bCancel = false;
                    ecodomus_client.bOpened = false;


                    path_to_db = full_path;
                    ecodomus_client.fk_facility_id = facilityId;            // fk_facility_id to test with
                    ecodomus_client.fk_project_id = projectId;             // fk_project_id  to test with
                    ecodomus_client.fk_simulation_id = em_simulation_id;          // fk_simulation_id to test with



                    ecodomus_client.sql_connection.ConnectionString = Constr;
                    // open the database
                    ecodomus_client.sql_connection.Open();
                    if (ecodomus_client.sql_connection.State == ConnectionState.Open)
                    {
                        ecodomus_client.bOpened = true;
                    }

                    // SQLite Data Connection ---------------------------------------------------------------------------------------
                    sqlite_connection = new SQLiteConnection("Data Source=" + path_to_db + ";");
                    sqlite_command = sqlite_connection.CreateCommand();
                    bool bSQLiteOpened = false;

                    // open the database
                    sqlite_connection.Open();
                    if (sqlite_connection.State == ConnectionState.Open)
                    {
                        bSQLiteOpened = true;
                    }

                    // if the db opened
                    if (bSQLiteOpened)
                    {
                        // debugging - Insert the zones from here ?
                        //InsertZonesForDebugging();

                        // clear the errors from the last import of this facility and project SQLite data
                        ClearImportErrors();

                        long l_ZonesAdded = GetZoneCollection();
                        long l_MetersAdded = GetMeterCollection();

                        iTableCount = 10;
                        strTableName = new string[iTableCount];
                        strTableNameEcoDomus = new string[iTableCount];

                        strTableName[0] = "ReportVariableDataDictionary";
                        strTableNameEcoDomus[0] = "tbl_energymodeling_ReportVariableDataDictionary";

                        strTableName[1] = "ReportMeterDataDictionary";
                        strTableNameEcoDomus[1] = "tbl_energymodeling_ReportMeterDataDictionary";

                        strTableName[2] = "ReportVariableData";
                        strTableNameEcoDomus[2] = "tbl_energymodeling_ReportVariableData";

                        strTableName[3] = "ReportVariableExtendedData";
                        strTableNameEcoDomus[3] = "tbl_energymodeling_ReportVariableExtendedData";

                        strTableName[4] = "Time";
                        strTableNameEcoDomus[4] = "tbl_energymodeling_Time";

                        strTableName[5] = "ReportMeterData";
                        strTableNameEcoDomus[5] = "tbl_energymodeling_ReportMeterData";

                        strTableName[6] = "ReportMeterExtendedData";
                        strTableNameEcoDomus[6] = "tbl_energymodeling_ReportMeterExtendedData";

                        strTableName[7] = "ZoneGroups";
                        strTableNameEcoDomus[7] = "tbl_energymodeling_ZoneGroups";

                        strTableName[8] = "ZoneLists";
                        strTableNameEcoDomus[8] = "tbl_energymodeling_ZoneLists";

                        strTableName[9] = "Zones";
                        strTableNameEcoDomus[9] = "tbl_energymodeling_Zones";

                        for (iTableIndex = 0; iTableIndex < iTableCount; iTableIndex++)
                        {
                            sqlite_command.CommandText = "SELECT * FROM " + strTableName[iTableIndex];
                            i_InsertCount = 0;
                            i_FailedCount = 0;

                            SQLiteDataReader sqlite_datareader = sqlite_command.ExecuteReader();
                            while (sqlite_datareader.Read())
                            {
                                bSaveCurrentRecord = false;

                                // get guid data for variable Dictionary items
                                if (strTableName[iTableIndex] == "ReportVariableDataDictionary")
                                {
                                    try
                                    {
                                        strKeyValue = sqlite_datareader["KeyValue"].ToString();
                                        strVariableName = sqlite_datareader["VariableName"].ToString();
                                        ZoneItem z = GetZoneItemByName(strKeyValue);
                                        ecodomus_client.fk_zone_id = z.pk_zone_id;
                                        ecodomus_client.fk_attribute_id = Guid.Empty.ToString();
                                        bSaveCurrentRecord = z.SaveData;
                                    }
                                    catch (Exception ex)
                                    {
                                        
                                        throw ex;
                                    }
                                   
                                }

                                // get guid data for Variable Data items
                                if (strTableName[iTableIndex] == "ReportVariableData")
                                {
                                    try
                                    {
                                        long l_DictIndex = long.Parse(sqlite_datareader["ReportVariableDataDictionaryIndex"].ToString());
                                        ZoneItem z = GetZoneItemByIndex(l_DictIndex);
                                        ecodomus_client.fk_zone_id = z.pk_zone_id;
                                        ecodomus_client.fk_attribute_id = Guid.Empty.ToString();
                                        bSaveCurrentRecord = z.SaveData;
                                    }
                                    catch (Exception ex)
                                    {

                                        throw ex;
                                    }
                                    
                                }

                                // ReportVariableExtendedData
                                if (strTableName[iTableIndex] == "ReportVariableExtendedData")
                                {
                                    try
                                    {
                                        long l_DictIndex = long.Parse(sqlite_datareader["ReportVariableDataDictionaryIndex"].ToString());
                                        ZoneItem z = GetZoneItemByIndex(l_DictIndex);
                                        ecodomus_client.fk_zone_id = z.pk_zone_id;
                                        ecodomus_client.fk_attribute_id = Guid.Empty.ToString();
                                        bSaveCurrentRecord = z.SaveData;
                                    }
                                    catch (Exception ex)
                                    {

                                        throw ex;
                                    }
                                    
                                }

                                // get guid data for meter Dictionary items
                                if (strTableName[iTableIndex] == "ReportMeterDataDictionary")
                                {
                                    try
                                    {
                                        long l_DictIndex = long.Parse(sqlite_datareader["ReportMeterDataDictionaryIndex"].ToString());
                                        MeterItem m = GetMeterItemByIndex(l_DictIndex);
                                        ecodomus_client.fk_meter_id = m.pk_meter_id;
                                        bSaveCurrentRecord = m.SaveData;
                                    }
                                    catch (Exception ex)
                                    {

                                        throw ex;
                                    }
                                    
                                }

                                // get guid data for Meter Data items
                                if (strTableName[iTableIndex] == "ReportMeterData")
                                {
                                    try
                                    {
                                        long l_DictIndex = long.Parse(sqlite_datareader["ReportMeterDataDictionaryIndex"].ToString());
                                        MeterItem m = GetMeterItemByIndex(l_DictIndex);
                                        ecodomus_client.fk_meter_id = m.pk_meter_id;
                                        bSaveCurrentRecord = m.SaveData;
                                    }
                                    catch (Exception ex)
                                    {

                                        throw ex;
                                    }
                                    
                                }

                                // the zones data, there is some extended zone data here we may want.
                                if (strTableName[iTableIndex] == "Zones")
                                {
                                    try
                                    {
                                        string sName = sqlite_datareader["ZoneName"].ToString();
                                        ZoneItem z = GetZoneItemByName(sName);
                                        ecodomus_client.fk_zone_id = z.pk_zone_id;
                                        ecodomus_client.fk_attribute_id = Guid.Empty.ToString();
                                        bSaveCurrentRecord = z.SaveData;
                                    }
                                    catch (Exception ex)
                                    {

                                        throw ex;
                                    }
                                    
                                }

                                // always save the time data
                                if (strTableName[iTableIndex] == "Time")
                                    bSaveCurrentRecord = true;

                                // save this record ?
                                if (bSaveCurrentRecord == true)
                                {

                                    // build an insert query
                                    strInsertQuery = "INSERT INTO " + strTableNameEcoDomus[iTableIndex] + "(";
                                    strInsertFieldNames = "";
                                    strInsertFieldValues = "";
                                    for (int i = 0; i < sqlite_datareader.FieldCount; i++)
                                    {
                                        // ignore data with empty values
                                        if (sqlite_datareader.GetValue(i).ToString().Length > 0)
                                        {
                                            // get the field name
                                            strFieldName = sqlite_datareader.GetName(i).ToString();
                                            strInsertFieldNames += strFieldName + ",";

                                            // test the data type, if a string then prepend and append "'"
                                            if (double.TryParse(sqlite_datareader[sqlite_datareader.GetName(i).ToString()].ToString(), out dDummy))
                                                strInsertFieldValues += sqlite_datareader.GetValue(i).ToString() + ",";
                                            else
                                                strInsertFieldValues += "'" + sqlite_datareader.GetValue(i).ToString() + "',";
                                        }
                                    }

                                    // trim the last unused comma in the strInsertFieldNames
                                    strTmp = strInsertFieldNames.Substring(0, strInsertFieldNames.Length - 1);
                                    strInsertFieldNames = strTmp;

                                    // trim the last unused comma in the strInsertFieldValues
                                    strTmp = strInsertFieldValues.Substring(0, strInsertFieldValues.Length - 1);
                                    strInsertFieldValues = strTmp;

                                    // update the guid data ?
                                    if (strTableName[iTableIndex].Contains("Zone") == true)
                                    {
                                        strGuidNames = "fk_facility_id, fk_zone_id, ";
                                        strGuidValues = "'" + ecodomus_client.fk_facility_id + "','" + ecodomus_client.fk_zone_id + "', ";
                                    }
                                    else
                                    {
                                        if (strTableName[iTableIndex].Contains("Time") == true)
                                        {
                                            strGuidNames = "fk_facility_id, fk_project_id, fk_simulation_id, ";
                                            strGuidValues = "'" + ecodomus_client.fk_facility_id + "','" + ecodomus_client.fk_project_id + "','" + ecodomus_client.fk_simulation_id + "',";
                                        }
                                        else
                                        {
                                            strGuidNames = "fk_facility_id, fk_project_id, fk_simulation_id, fk_zone_id, fk_attribute_id, ";
                                            strGuidValues = "'" + ecodomus_client.fk_facility_id + "','" + ecodomus_client.fk_project_id + "','" + ecodomus_client.fk_simulation_id + "','" + ecodomus_client.fk_zone_id + "','" + ecodomus_client.fk_attribute_id + "',";
                                        }
                                    }

                                    // build the final query 
                                    strInsertQuery += strGuidNames;
                                    strInsertQuery += strInsertFieldNames;
                                    strInsertQuery += ")VALUES(";
                                    strInsertQuery += strGuidValues;
                                    strInsertQuery += strInsertFieldValues;
                                    strInsertQuery += ")";

                                    if (ecodomus_client.bOpened)
                                    {
                                        // setup the insert command
                                        ecodomus_client.sql_write_command.CommandType = System.Data.CommandType.Text;
                                        ecodomus_client.sql_write_command.CommandText = strInsertQuery;
                                        ecodomus_client.sql_write_command.Connection = ecodomus_client.sql_connection;

                                        try
                                        {
                                            ecodomus_client.sql_write_command.ExecuteNonQuery();
                                            i_InsertCount++;
                                        }
                                        catch (Exception ex)
                                        {
                                            i_FailedCount++;
                                            //throw ex;
                                        }
                                    }

                                }
                            }

                            sqlite_datareader.Close();
                            //ecodomus_client.sql_connection.Close();
                            //sqlite_connection.Close();
                        }

                    }

                }

            }
            catch (Exception ex)
            {
                
               // throw ex;
            }

           

        }

        // get a guid for a Dictionary Item
        static string GetGuidForDictionaryItem(string sKeyValue, string sVariableName)
        {
            string strFoundGuid = "00000000-0000-0000-0000-000000000000";
            string strZone_ID = "";

            // get the zone id
            strZone_ID = GetZoneID(ecodomus_client.fk_facility_id, sKeyValue);

            // search the spaces in the zone for the sVariableName
            //strFoundGuid = SearchSpacesInZone(ecodomus_client.fk_facility_id, strZone_ID, sVariableName);

            return strFoundGuid;
        }

        static string SearchSpacesInZone(string pk_facility_id, string pk_zone_id, string sAttributeName)
        {
            string strFoundGuid = "00000000-0000-0000-0000-000000000000";
            string strSQLQuery = "";
            string[] arr_space_ids;
            int iSpaceCount = 0;

            if (ecodomus_client.sql_connection.State == ConnectionState.Open)
            {
                strSQLQuery = "SELECT ";
                strSQLQuery += "tbl_zone_space_linkup.fk_zone_id as 'zone_id', ";
                strSQLQuery += "tbl_location.pk_location_id AS space_id, ";
                strSQLQuery += "tbl_location.fk_facility_id ";
                strSQLQuery += "from tbl_location ";
                strSQLQuery += "INNER JOIN vw_get_entity ";
                strSQLQuery += "ON vw_get_entity.pk_entity_id = tbl_location.fk_entity_id ";
                strSQLQuery += "AND vw_get_entity.entity_name = 'Space' ";
                strSQLQuery += "INNER JOIN tbl_facility ";
                strSQLQuery += "ON tbl_facility.pk_facility_id = tbl_location.fk_facility_id ";
                strSQLQuery += "LEFT JOIN tbl_zone_space_linkup ";
                strSQLQuery += "on tbl_zone_space_linkup.fk_space_id= tbl_location.pk_location_id ";
                strSQLQuery += "where tbl_location.fk_facility_id = '" + pk_facility_id + "' ";
                strSQLQuery += "AND tbl_zone_space_linkup.fk_zone_id = '" + pk_zone_id + "' ";
                strSQLQuery += "AND tbl_location.fk_location_parent_id IS NOT NULL ";
                strSQLQuery += "ORDER BY tbl_location.name";

                ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                ecodomus_client.sql_command.CommandText = strSQLQuery;
                ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                // just count the records
                while (ecodomus_client.sql_reader.Read())
                {
                    iSpaceCount++;
                }
                ecodomus_client.sql_reader.Close();

                // now alloc an array and copy the guids to the array
                arr_space_ids = new string[iSpaceCount];
                ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();
                int x = 0;
                while (ecodomus_client.sql_reader.Read())
                {
                    arr_space_ids[x] = ecodomus_client.sql_reader["space_id"].ToString();
                    x++;
                }
                ecodomus_client.sql_reader.Close();

                for (int j = 0; j < iSpaceCount; j++)
                {
                    strFoundGuid = SearchAssetsInSpace(pk_facility_id, arr_space_ids[j], sAttributeName);
                    if (strFoundGuid != "00000000-0000-0000-0000-000000000000")
                        break;
                }

            }

            return strFoundGuid;

        }

        static string SearchAssetsInSpace(string pk_facility_id, string pk_space_id, string sAttributeName)
        {
            string strFoundGuid = "00000000-0000-0000-0000-000000000000";
            string strSQLQuery = "";

            if (ecodomus_client.sql_connection.State == ConnectionState.Open)
            {
                strSQLQuery = "SELECT ";
                strSQLQuery += "tbl_facility.pk_facility_id, ";
                strSQLQuery += "tbl_asset.pk_asset_id, ";
                strSQLQuery += "tbl_asset_attribute.name, ";
                strSQLQuery += "tbl_asset_attribute.pk_asset_attribute_id AS attribute_id, ";
                strSQLQuery += "[pk_space_asset_id], ";
                strSQLQuery += "[fk_space_id], ";
                strSQLQuery += "[tbl_space_asset_linkup].[fk_asset_id] ";
                strSQLQuery += "FROM tbl_asset_attribute ";
                strSQLQuery += "INNER JOIN tbl_asset ";
                strSQLQuery += "ON tbl_asset_attribute.fk_asset_id = tbl_asset.pk_asset_id ";
                strSQLQuery += "INNER JOIN [tbl_space_asset_linkup] ";
                strSQLQuery += "ON tbl_asset_attribute.fk_asset_id = [tbl_space_asset_linkup].fk_asset_id ";
                strSQLQuery += "INNER JOIN tbl_facility ";
                strSQLQuery += "ON tbl_asset.fk_facility_id = tbl_facility.pk_facility_id ";
                strSQLQuery += "WHERE tbl_facility.pk_facility_id = '" + pk_facility_id + "' ";
                strSQLQuery += "AND [fk_space_id] = '" + pk_space_id + "' ";
                strSQLQuery += "AND tbl_asset_attribute.name = '" + sAttributeName + "'";

                ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                ecodomus_client.sql_command.CommandText = strSQLQuery;
                ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                while (ecodomus_client.sql_reader.Read())
                {
                    strFoundGuid = ecodomus_client.sql_reader["attribute_id"].ToString();
                }

                ecodomus_client.sql_reader.Close();

            }

            return strFoundGuid;

        }

        static int InsertZonesForDebugging()
        {
            int iInsertedCount = 0;
            int iFailedCount = 0;
            string strSQLQuery = "";

            string str_location_id = "";
            string str_facility_id = "";
            string str_name = "";
            string str_description = "";
            string str_category = "";
            string str_user_id = "";

            sqlite_command.CommandText = "SELECT * FROM Zones";
            SQLiteDataReader sqlite_datareader = sqlite_command.ExecuteReader();
            while (sqlite_datareader.Read())
            {
                ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                ecodomus_client.sql_command.CommandType = CommandType.StoredProcedure;
                ecodomus_client.sql_command.CommandText = "proc_insert_update_zone_profile";

                str_location_id = Guid.Empty.ToString();
                str_facility_id = ecodomus_client.fk_facility_id.ToString();

                str_name = sqlite_datareader["ZoneName"].ToString();
                str_description = sqlite_datareader["ZoneName"].ToString();

                str_category = "Zone";
                str_user_id = "00000000-0000-0000-0000-000000000000";

                ecodomus_client.sql_command.Parameters.AddWithValue("location_id", str_location_id);
                ecodomus_client.sql_command.Parameters.AddWithValue("fk_facility_id", str_facility_id);
                ecodomus_client.sql_command.Parameters.AddWithValue("name", str_name);
                ecodomus_client.sql_command.Parameters.AddWithValue("description", str_description);
                ecodomus_client.sql_command.Parameters.AddWithValue("category", str_category);
                ecodomus_client.sql_command.Parameters.AddWithValue("user_id", str_user_id);

                try
                {
                    ecodomus_client.sql_command.ExecuteNonQuery();
                    iInsertedCount++;
                }
                catch (Exception ex)
                {
                    iFailedCount++;
                }

            }

            return iInsertedCount;
        }

        static long GetZoneCollection()
        {
            long l_ZonesAdded = 0;

            // list the zones and get the guids for them
            ZoneItem zone_item;
            sqlite_command.CommandText = "SELECT * FROM ReportVariableDataDictionary";
            SQLiteDataReader sqlite_zonereader = sqlite_command.ExecuteReader();
            while (sqlite_zonereader.Read())
            {
                zone_item = new ZoneItem();

                zone_item.zone_name = sqlite_zonereader["KeyValue"].ToString();
                zone_item.DictionaryIndex = long.Parse(sqlite_zonereader["ReportVariableDataDictionaryIndex"].ToString());
                zone_item.pk_zone_id = GetZoneID(ecodomus_client.fk_facility_id, zone_item.zone_name);

                // did we find the item in EcoDomus ?
                if (zone_item.pk_zone_id == Guid.Empty.ToString())
                {
                    TrackImportError("Missing Zone in EcoDomus: " + zone_item.zone_name);
                    zone_item.SaveData = false;
                }
                else
                    zone_item.SaveData = true;

                try
                {
                    zones_collection.Add(zone_item);
                    l_ZonesAdded++;
                }
                catch (Exception ex)
                {
                    //
                }
            }
            sqlite_zonereader.Close();

            return l_ZonesAdded;
        }

        static ZoneItem GetZoneItemByName(string sName)
        {
            ZoneItem z = new ZoneItem();

            if (zones_collection.Count > 0)
            {
                foreach (ZoneItem zone in zones_collection)
                {
                    if (zone.zone_name == sName)
                    {
                        z.DictionaryIndex = zone.DictionaryIndex;
                        z.pk_zone_id = zone.pk_zone_id;
                        z.zone_name = zone.zone_name;
                        z.SaveData = zone.SaveData;
                        break;
                    }
                }
            }

            return z;
        }

        static ZoneItem GetZoneItemByIndex(long l_DictionaryIndex)
        {
            ZoneItem z = new ZoneItem();

            if (zones_collection.Count > 0)
            {
                foreach (ZoneItem zone in zones_collection)
                {
                    if (zone.DictionaryIndex == l_DictionaryIndex)
                    {
                        z.DictionaryIndex = zone.DictionaryIndex;
                        z.pk_zone_id = zone.pk_zone_id;
                        z.zone_name = zone.zone_name;
                        z.SaveData = zone.SaveData;
                        break;
                    }
                }
            }

            return z;
        }

        static string GetZoneID(string pk_facility_id, string sZoneName)
        {
            string strFoundGuid = "00000000-0000-0000-0000-000000000000";
            string strSQLQuery = "";

            if (ecodomus_client.sql_connection.State == ConnectionState.Open)
            {
                strSQLQuery = "SELECT * FROM tbl_location tl ";
                strSQLQuery += "WHERE fk_entity_id=(SELECT vge.pk_entity_id FROM vw_get_entity vge WHERE vge.entity_name='zone') ";
                strSQLQuery += "AND tl.fk_facility_id = '" + pk_facility_id + "' ";
                strSQLQuery += "AND name = '" + sZoneName + "'";

                ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                ecodomus_client.sql_command.CommandText = strSQLQuery;
                ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                while (ecodomus_client.sql_reader.Read())
                {
                    strFoundGuid = ecodomus_client.sql_reader["pk_location_id"].ToString();
                }

                ecodomus_client.sql_reader.Close();
            }

            return strFoundGuid;
        }

        static string GetZoneAttributeID(string pk_facility_id, string pk_zone_id, string sAtributeName)
        {
            string strFoundGuid = "00000000-0000-0000-0000-000000000000";
            string strSQLQuery = "";

            if (ecodomus_client.sql_connection.State == ConnectionState.Open)
            {


            }

            return strFoundGuid;
        }

        static long GetMeterCollection()
        {
            long l_MetersAdded = 0;



            MeterItem meter_item;

            sqlite_command.CommandText = "SELECT * FROM ReportMeterDataDictionary";

            SQLiteDataReader sqlite_meterreader = sqlite_command.ExecuteReader();



            while (sqlite_meterreader.Read())
            {

                meter_item = new MeterItem();

                meter_item.IndexGroup = sqlite_meterreader["IndexGroup"].ToString();

                meter_item.VariableName = sqlite_meterreader["VariableName"].ToString();

                meter_item.DictionaryIndex = long.Parse(sqlite_meterreader["ReportMeterDataDictionaryIndex"].ToString());

                meter_item.pk_meter_id = GetMeterID(ecodomus_client.fk_facility_id, meter_item.IndexGroup, meter_item.VariableName);



                // did we find the item in EcoDomus ?, if not just track the issue and let the meter data still be saved

                // so we can graph it on the analysis page.

                if (meter_item.pk_meter_id == Guid.Empty.ToString())
                {

                    TrackImportError("Warning: Missing Asset For Meter in EcoDomus: " + meter_item.IndexGroup + " : " + meter_item.VariableName);

                    meter_item.SaveData = true;

                }

                else

                    meter_item.SaveData = true;



                try
                {

                    meters_collection.Add(meter_item);



                    l_MetersAdded++;

                }

                catch (Exception ex)
                {

                    //

                }

            }

            sqlite_meterreader.Close();



            return l_MetersAdded;
        }

        static MeterItem GetMeterItemByName(string sIndexGroup, string sVariableName)
        {
            MeterItem m = new MeterItem();

            if (meters_collection.Count > 0)
            {
                foreach (MeterItem meter in meters_collection)
                {
                    if ((meter.IndexGroup == sIndexGroup) && (meter.VariableName == sVariableName))
                    {
                        m.DictionaryIndex = meter.DictionaryIndex;
                        m.pk_meter_id = meter.pk_meter_id;
                        m.IndexGroup = meter.IndexGroup;
                        m.VariableName = meter.VariableName;
                        m.SaveData = meter.SaveData;
                        break;
                    }
                }
            }

            return m;
        }

        static MeterItem GetMeterItemByIndex(long l_DictionaryIndex)
        {
            MeterItem m = new MeterItem();

            if (meters_collection.Count > 0)
            {
                foreach (MeterItem meter in meters_collection)
                {
                    if (meter.DictionaryIndex == l_DictionaryIndex)
                    {
                        m.DictionaryIndex = meter.DictionaryIndex;
                        m.pk_meter_id = meter.pk_meter_id;
                        m.IndexGroup = meter.IndexGroup;
                        m.VariableName = meter.VariableName;
                        m.SaveData = meter.SaveData;
                        break;
                    }
                }
            }

            return m;
        }

        // Meter ID should be a facility or asset attribute
        static string GetMeterID(string pk_facility_id, string sIndexGroup, string sVariableName)
        {
            string strFoundGuid = "00000000-0000-0000-0000-000000000000";
            string strSQLQuery = "";

            if (ecodomus_client.sql_connection.State == ConnectionState.Open)
            {
                //strSQLQuery = "SELECT * FROM tbl_location tl ";
                //strSQLQuery += "WHERE fk_entity_id=(SELECT vge.pk_entity_id FROM vw_get_entity vge WHERE vge.entity_name='zone') ";
                //strSQLQuery += "AND tl.fk_facility_id = '" + pk_facility_id + "' ";
                //strSQLQuery += "AND name = '" + sIndexGroup + "'";

                //ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                //ecodomus_client.sql_command.CommandText = strSQLQuery;
                //ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

                //while (ecodomus_client.sql_reader.Read())
                //{
                //    strFoundGuid = ecodomus_client.sql_reader["pk_location_id"].ToString();
                //}

                //ecodomus_client.sql_reader.Close();
            }

            return strFoundGuid;
        }

        static bool TrackImportError(string msg)
        {
            bool bSaved = false;
            string strInsertQuery = "";
            string strFieldNames = "";
            string strFieldValues = "";
            Guid g_ReportError = Guid.NewGuid();

            strFieldNames = "fk_ReportError_id, fk_facility_id, fk_project_id, fk_simulation_id, message";
            strFieldValues = "'" + g_ReportError.ToString() + "','" + ecodomus_client.fk_facility_id + "','" + ecodomus_client.fk_project_id + "','" + ecodomus_client.fk_simulation_id + "','" + msg + "'";

            // build the final query
            strInsertQuery = "INSERT INTO tbl_energymodeling_ReportImportError(";
            strInsertQuery += strFieldNames;
            strInsertQuery += ")VALUES(";
            strInsertQuery += strFieldValues;
            strInsertQuery += ")";

            if (ecodomus_client.bOpened)
            {
                // setup the insert command
                ecodomus_client.sql_write_command.CommandType = System.Data.CommandType.Text;
                ecodomus_client.sql_write_command.CommandText = strInsertQuery;
                ecodomus_client.sql_write_command.Connection = ecodomus_client.sql_connection;

                try
                {
                    ecodomus_client.sql_write_command.ExecuteNonQuery();
                    bSaved = true;
                }
                catch (Exception ex)
                {
                    bSaved = false;
                }
            }

            return bSaved;
        }

        static bool ClearImportErrors()
        {
            bool bCleared = false;
            string strInsertQuery = "";

            // build the final query
            strInsertQuery = "DELETE FROM tbl_energymodeling_ReportImportError ";
            strInsertQuery += "WHERE fk_facility_id = '" + ecodomus_client.fk_facility_id + "' ";
            strInsertQuery += "AND fk_project_id = '" + ecodomus_client.fk_project_id + "'";

            if (ecodomus_client.bOpened)
            {
                // setup the insert command
                ecodomus_client.sql_write_command.CommandType = System.Data.CommandType.Text;
                ecodomus_client.sql_write_command.CommandText = strInsertQuery;
                ecodomus_client.sql_write_command.Connection = ecodomus_client.sql_connection;

                try
                {
                    ecodomus_client.sql_write_command.ExecuteNonQuery();
                    bCleared = true;
                }
                catch (Exception ex)
                {
                    bCleared = false;
                }
            }

            return bCleared;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                StreamWriter sr = new StreamWriter(@"C:\SimulationErrorFile.txt");
                sr.Close();
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
	
}

//public class EcoDomus_Data_Connection
//{
//    public SqlConnection sql_connection = new SqlConnection();
//    public SqlCommand sql_command = new SqlCommand();
//    public SqlCommand sql_write_command = new SqlCommand();
//    public SqlDataReader sql_reader;
//    public SqlDataReader sql_reader2;

//    public string fk_facility_id;
//    public string fk_project_id;
//    public string fk_simulation_id;
//    public string fk_system_id;
//    public string fk_zone_id;
//    public string fk_space_id;
//    public string fk_asset_id;
//    public string fk_meter_id;
//    public string fk_attribute_id;

//    public bool bCancel;
//    public bool bOpened;
//}

public class ZoneItem
{
    public string zone_name;
    public string pk_zone_id;
    public long DictionaryIndex;
    public bool SaveData;

    public ZoneItem()
    {
        zone_name = "";
        pk_zone_id = Guid.Empty.ToString();
        DictionaryIndex = 0;
        SaveData = false;
    }
}

public class MeterItem
{
    public string pk_meter_id;
    public string IndexGroup;
    public string VariableName;
    public long DictionaryIndex;
    public bool SaveData;

    public MeterItem()
    {
        IndexGroup = "";
        VariableName = "";
        pk_meter_id = Guid.Empty.ToString();
        DictionaryIndex = 0;
        SaveData = false;
    }
}

public class ZoneItemCollection : System.Collections.CollectionBase
{
    public void Add(ZoneItem aPoint)
    {
        List.Add(aPoint);
    }

    public void Remove(int index)
    {
        if (index > Count - 1 || index < 0)
        {
            //Index not valid
        }
        else
        {
            List.RemoveAt(index);
        }
    }

    public ZoneItem Item(int Index)
    {
        return (ZoneItem)List[Index];
    }
}

public class MeterItemCollection : System.Collections.CollectionBase
{
    public void Add(MeterItem aMeter)
    {
        List.Add(aMeter);
    }

    public void Remove(int index)
    {
        if (index > Count - 1 || index < 0)
        {
            //Index not valid
        }
        else
        {
            List.RemoveAt(index);
        }
    }

    public MeterItem Item(int Index)
    {
        return (MeterItem)List[Index];
    }
}