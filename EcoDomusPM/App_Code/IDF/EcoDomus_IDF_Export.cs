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
using System.Threading;
using System.Globalization;
using System.Collections;
using EnergyPlus;


public class EnergyModelingtIDFExport 
{
    static EcoDomus_IDF_Export IDF_Exporter;

    public void IDF_Export( string fileName, string facilityId)
    {
        IDF_Exporter = new EcoDomus_IDF_Export();

        // setup the guids for our data
        IDF_Exporter.pk_facility_id = facilityId;
        IDF_Exporter.pk_project_id = "00000000-0000-0000-0000-000000000000";

        // setup the client db conn string
        IDF_Exporter.ClientDBName = "gsa2";
        IDF_Exporter.ecodomus_client.sql_connection.ConnectionString = IDF_Exporter.getConnstr();
        IDF_Exporter.ecodomus_client.sql_connection.ConnectionString += "; MultipleActiveResultSets=True;";

        // try to connect
        if (IDF_Exporter.ConnectClientDatabase())
        {
            // show debug info ?
            IDF_Exporter.bShowDebugOutput = true;

            // export the file
            string fName = fileName;
            long objects_exported = IDF_Exporter.Export_IDF_File(IDF_Exporter.pk_facility_id, IDF_Exporter.pk_project_id, fName);

            // close the db
            IDF_Exporter.CloseClientDatabase();
        }


    }
}

public class EcoDomus_IDF_Export
{
    // class version
    public const double version = 1.1;

    public EcoDomus_Data_Connection ecodomus_client;
    System.IO.StreamWriter idf_file;

    public bool bShowDebugOutput;
    public string ClientDBName;
    public string IDF_Version;
    public string pk_energymodel_simulation_object_id;
    public string pk_energymodel_simulation_object_value_id;
    public string pk_energymodel_simulation_profile;
    public string pk_facility_id;
    public string pk_project_id;
    public string pk_system_id;
    public string pk_zone_id;
    public string pk_asset_id;

    public EcoDomus_IDF_Export()
    {
        bShowDebugOutput = false;
        ClientDBName = "gsa2";
        IDF_Version = "0.0";

        pk_energymodel_simulation_object_id = "00000000-0000-0000-0000-000000000000";
        pk_energymodel_simulation_object_value_id = "00000000-0000-0000-0000-000000000000";
        pk_energymodel_simulation_profile = "00000000-0000-0000-0000-000000000000";
        pk_facility_id = "00000000-0000-0000-0000-000000000000";
        pk_project_id = "00000000-0000-0000-0000-000000000000";
        pk_system_id = "00000000-0000-0000-0000-000000000000";
        pk_zone_id = "00000000-0000-0000-0000-000000000000";
        pk_asset_id = "00000000-0000-0000-0000-000000000000";

        // EcoDomus Client Connection 
        ecodomus_client = new EcoDomus_Data_Connection();
        ecodomus_client.bCancel = false;
        ecodomus_client.bOpened = false;

        // Default database connection for testing
        //IDF_Exporter.ClientDBName = "gsa2";
        //IDF_Exporter.ecodomus_client.sql_connection.ConnectionString = @"Data Source=" + @"DaveAdkisson-PC\SQLExpress" + ";";
        //IDF_Exporter.ecodomus_client.sql_connection.ConnectionString += "Initial Catalog=" + IDF_Exporter.ClientDBName + ";";
        //IDF_Exporter.ecodomus_client.sql_connection.ConnectionString += "User Id=" + "sa" + ";";
        //IDF_Exporter.ecodomus_client.sql_connection.ConnectionString += "Password=" + "ecodomus@123" + ";";
        //IDF_Exporter.ecodomus_client.sql_connection.ConnectionString += "MultipleActiveResultSets=True;";
    }


    public string getConnstr()
    {
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        string con_str = obj_energy_plus_client.Get_Connection_String(obj_energy_plus_model, SessionController.ConnectionString);
        return con_str;
    }

    public void ShowDebugMessage(string strMessage)
    {
        // change the output as needed, here it is just console output
        Console.WriteLine(strMessage);
    }

    // open the client db
    public bool ConnectClientDatabase()
    {
        bool bConnected = false;
        try
        {
            ecodomus_client.sql_connection.Open();
            if (ecodomus_client.sql_connection.State == ConnectionState.Open)
            {
                bConnected = true;
            }
            else
            {
                bConnected = false;
            }
        }
        catch (Exception ex)
        {
            bConnected = false;
        }
        return bConnected;
    }

    // close the client db
    public bool CloseClientDatabase()
    {
        bool bConnected = false;
        try
        {
            ecodomus_client.sql_connection.Close();
            bConnected = false;
        }
        catch (Exception ex)
        {
            bConnected = false;
        }
        return bConnected;
    }

    public bool ExportSimulationObject(string simulation_object_id, string object_name, string format, int minumum_number_fields)
    {
        string strSQLQuery = "";
        string field_value = "";
        string field_comment = "";
        string strOuputBlock = "";
        string sTmp = "";
        bool bSuccess = false;
        bool bIsMultiLineObject = false;
        int iRecordCount = 0;
        int iRowIndex = 0;

        if (format == "singleLine")
            bIsMultiLineObject = false;

        if (format == "choice")
            bIsMultiLineObject = false;

        if (format == "")
            bIsMultiLineObject = true;

        if (format == "object-list")
            bIsMultiLineObject = true;

        if (format == "vertices")
            bIsMultiLineObject = true;

        if (format == "Spectral")
            bIsMultiLineObject = true;

        if (format == "compactSchedule")
            bIsMultiLineObject = true;

        strSQLQuery = "SELECT [tbl_energymodel_simulation_objects].[pk_simulation_object_id] ";
        strSQLQuery += ",[fk_field_id] ";
        strSQLQuery += ",[value] ";
        strSQLQuery += ",[import_order_fields] ";
        strSQLQuery += ",[comment] ";
        strSQLQuery += "FROM [tbl_energymodel_simulation_objects] ";
        strSQLQuery += "INNER JOIN tbl_energymodel_simulation_object_values ON [tbl_energymodel_simulation_object_values].[pk_simulation_object_id] = [tbl_energymodel_simulation_objects].[pk_simulation_object_id] ";
        strSQLQuery += "WHERE [tbl_energymodel_simulation_objects].[pk_simulation_object_id] = '" + simulation_object_id + "' ";
        strSQLQuery += "ORDER BY [import_order_fields] asc ";

        ecodomus_client.sql_command2 = ecodomus_client.sql_connection.CreateCommand();
        ecodomus_client.sql_command2.CommandText = strSQLQuery;
        ecodomus_client.sql_reader2 = ecodomus_client.sql_command2.ExecuteReader();

        while (ecodomus_client.sql_reader2.Read())
            iRecordCount++;
        ecodomus_client.sql_reader2.Close();
        ecodomus_client.sql_reader2 = ecodomus_client.sql_command2.ExecuteReader();

        // multi line format ?
        if (bIsMultiLineObject)
            strOuputBlock = object_name + ",\r\n";
        else
            strOuputBlock = object_name + ",";

        while (ecodomus_client.sql_reader2.Read())
        {
            iRowIndex++;

            field_value = ecodomus_client.sql_reader2["value"].ToString();
            field_comment = ecodomus_client.sql_reader2["comment"].ToString();

            if (field_value == "NULL")
                field_value = "";

            // if this is the last property, terminate the object with a ;
            if (iRowIndex == iRecordCount)
                field_value += ";";
            else
                field_value += ",";

            // multi line format ?
            if (bIsMultiLineObject)
            {
                strOuputBlock += field_value.ToString() + " !- " + field_comment + "\r\n";
            }

            // singleline format ?
            if (!bIsMultiLineObject)
            {
                strOuputBlock += field_value.ToString();
            }
        }

        ecodomus_client.sql_reader2.Close();

        // trim the last comma 
        if (strOuputBlock.EndsWith(","))
        {
            sTmp = strOuputBlock.Remove(strOuputBlock.Length - 1);
            strOuputBlock = sTmp;
        }

        // end the object block of text with a semi colon
        strOuputBlock += "\r\n\r\n";

        idf_file.Write(strOuputBlock);

        ShowDebugMessage(strOuputBlock);

        return bSuccess;
    }

    byte[] GetBytes(string str)
    {
        byte[] bytes = new byte[str.Length * sizeof(char)];
        System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
        return bytes;
    }

    string GetString(byte[] bytes)
    {
        char[] chars = new char[bytes.Length / sizeof(char)];
        System.Buffer.BlockCopy(bytes, 0, chars, 0, bytes.Length);
        return new string(chars);
    }

    public long Export_IDF_File(string fk_facility_id, string pk_project_id, string file_name)
    {
        long Objects_Exported = 0;
        int Minumum_Number_Fields = 0;
        string strSQLQuery = "";
        string strSimObjectID = "";
        string strObjectName = "";
        string strFormat = "";
        string sTmp = "";


        // try to open the file, return -1 if we fail
        try
        {
            idf_file = new System.IO.StreamWriter(file_name);
        }
        catch (Exception ex)
        {
            ShowDebugMessage(ex.Message.ToString());
            return -1;
        }

        strSQLQuery = "SELECT [pk_simulation_object_id] ";
        strSQLQuery += ",[fk_facility_id] ";
        strSQLQuery += ",[fk_project_id] ";
        strSQLQuery += ",[fk_system_id] ";
        strSQLQuery += ",[fk_zone_id] ";
        strSQLQuery += ",[fk_asset_id] ";
        strSQLQuery += ",[fk_object_id] ";
        strSQLQuery += ",[file_version] ";
        strSQLQuery += ",[import_order_objects] ";
        strSQLQuery += ",[object_name] ";
        strSQLQuery += ",[minumum_number_of_fields] ";
        strSQLQuery += ",[format] ";
        strSQLQuery += "FROM [tbl_energymodel_simulation_objects] ";
        strSQLQuery += "INNER JOIN [tbl_energymodel_objects] ON [tbl_energymodel_objects].pk_object_id = [tbl_energymodel_simulation_objects].[fk_object_id] ";
        strSQLQuery += "WHERE [fk_facility_id] = '" + fk_facility_id + "' ";
        strSQLQuery += "AND [fk_project_id] = '" + pk_project_id + "' ";
        strSQLQuery += "ORDER BY [import_order_objects] ASC";

        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
        ecodomus_client.sql_command.CommandText = strSQLQuery;
        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

        while (ecodomus_client.sql_reader.Read())
        {
            strSimObjectID = ecodomus_client.sql_reader["pk_simulation_object_id"].ToString();
            strObjectName = ecodomus_client.sql_reader["object_name"].ToString();
            strFormat = ecodomus_client.sql_reader["format"].ToString();
            sTmp = ecodomus_client.sql_reader["minumum_number_of_fields"].ToString();

            if (sTmp.Length > 0)
                Minumum_Number_Fields = int.Parse(sTmp);
            else
                Minumum_Number_Fields = 1;

            ExportSimulationObject(strSimObjectID, strObjectName, strFormat, Minumum_Number_Fields);
            Objects_Exported++;
        }

        ecodomus_client.sql_reader.Close();

        idf_file.Close();

        return Objects_Exported;
    }
}