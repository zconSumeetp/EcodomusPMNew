using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for EcoDomus_Data_Connection
/// </summary>
public class EcoDomus_Data_Connection
{
    public SqlConnection sql_connection = new SqlConnection();
    public SqlCommand sql_write_command = new SqlCommand();
    public SqlCommand sql_command = new SqlCommand();
    public SqlCommand sql_command2 = new SqlCommand();
    public SqlDataReader sql_reader;
    public SqlDataReader sql_reader2;

    public string fk_facility_id;
    public string fk_project_id;
    public string fk_simulation_id;
    public string fk_system_id;
    public string fk_zone_id;
    public string fk_space_id;
    public string fk_asset_id;
    public string fk_meter_id;
    public string fk_attribute_id;
    public bool bCancel;
    public bool bOpened;
	
}