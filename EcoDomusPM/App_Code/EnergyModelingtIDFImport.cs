using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using EcoDomus.Session;
using EnergyPlus;

/// <summary>
/// Summary description for EnergyModelingtIDFImport
/// </summary>
public class EnergyModelingtIDFImport
{

    static EcoDomus_IDF_Import IDF_Importer;

    public void IDF_Import( string fileName,string facilityId)
    {
        IDF_Importer = new EcoDomus_IDF_Import();

        // setup the guids for our data
        IDF_Importer.pk_energymodel_simulation_object_id = "";
        IDF_Importer.pk_energymodel_simulation_profile = "BC73CFC4-61F0-49BA-8654-DAA4BEE06E76";
        IDF_Importer.pk_facility_id = facilityId;
        IDF_Importer.pk_project_id = Guid.Empty.ToString();

        // setup the client db conn string
        //IDF_Object objConn = new IDF_Object();
        //IDF_Importer.ecodomus_client.sql_connection.ConnectionString = objConn.getConnstr();

        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        string con_str = obj_energy_plus_client.Get_Connection_String(obj_energy_plus_model, SessionController.ConnectionString);

        IDF_Importer.ecodomus_client.sql_connection.ConnectionString = con_str;

        IDF_Importer.ecodomus_client.sql_connection.ConnectionString += "; MultipleActiveResultSets=True;";

        // try to connect
        if (IDF_Importer.ConnectClientDatabase())
        {
            // show debug info ?
            IDF_Importer.bShowDebugOutput = true;

            // import the file
            string fName = fileName;
            long objects_imported = IDF_Importer.Import_IDF_File(fName);

            // close the db
            IDF_Importer.CloseClientDatabase();
        }
    }
       
}

public class IDF_Object
{
    public string name;
    public string IDD_Class;
    public string pk_object_id;
    public string associated_object;
    public string pk_associated_object_id;
    public string[] arrFields;
    public string[] arrComments;
    public string[] line_items;
    public bool bMultiLineObject;
    public bool SaveData;
    public bool Saved;
    public long pos_start;
    public long pos_end;
    public long import_order;

    public IDF_Object()
    {
        name = "";
        pk_object_id = Guid.Empty.ToString();
        line_items = new string[1];
        arrFields = new string[1];
        arrComments = new string[1];
        IDD_Class = "";
        associated_object = "";
        pk_associated_object_id = Guid.Empty.ToString();
        SaveData = false;
        bMultiLineObject = false;
        pos_start = 0;
        pos_end = 0;
        import_order = 0;
        Saved = false;
    }

    public void AddLineItem(string strLine, bool bAddLine)
    {
        line_items[line_items.Length - 1] = strLine;
        if (bAddLine)
            Array.Resize(ref line_items, line_items.Length + 1);
    }

    public int AddFieldItem(string item, string comment)
    {
        arrFields[arrFields.Length - 1] = item.Trim();
        arrComments[arrComments.Length - 1] = comment.Trim();

        Array.Resize(ref arrFields, arrFields.Length + 1);
        Array.Resize(ref arrComments, arrComments.Length + 1);

        return arrFields.Length;
    }

    public bool UnpackLineItems()
    {
        bool bError = false;
        bool bSkipThisField = false;
        string sTmp = "";
        string sUntil = "";
        string sValue = "";
        string sComment = "";

        // debug an object
        //if (IDD_Class == "BuildingSurface:Detailed")
        //    sTmp = "";    // set a breakpoint on this

        if (!bMultiLineObject)
        {
            string[] fields = line_items[0].Split(',');

            if (fields.Length == 2)
            {
                if (fields[1].EndsWith(";"))
                    sTmp = fields[1].Replace(";", "");
                else
                    sTmp = fields[1].Trim();
                fields[1] = sTmp;

                AddFieldItem(fields[1].Trim(), fields[0].Trim());
            }
            else
            {
                for (int j = 1; j < fields.Length; j++)
                {
                    // clean the data
                    if (fields[j].Contains(";"))
                        sTmp = fields[j].Replace(";", "");
                    else
                        sTmp = fields[j].Trim();
                    fields[j] = sTmp.Trim();

                    AddFieldItem(fields[j].Trim(), "");
                }
            }
        }
        else
        {
            // is a MultiLineObject

            // extract all the lines
            for (int i = 0; i < (line_items.Length - 1); i++)
            {
                // schedule entry ?
                if (line_items[i].Contains("Until:"))   
                {
                    // Until: 24:00,20;         !- Field 3

                    // Until: 24:00,20         !- Field 3

                    // Until: 24:00,            !- Field 3
                    // 20;                       !- Field 4

                    // Until: 24:00;            !- Field 3

                    string[] FieldWithComment = line_items[i].Split('!');
                    string[] fields = FieldWithComment[0].Split(',');

                    // fields[0] should always have "Until: XX:XX,"
                    // if fields[1] is empty, then value is on next line
                    string sField0 = fields[0].Trim();

                    if ((fields.Length == 2) || (fields.Length == 3) )
                    {
                        string sField1 = fields[1].Trim();

                        string sField2 = "";
                        if (fields.Length == 3)
                        {
                            sField2 = fields[2].Trim();
                            // sField2 should be just empty now
                        }

                        if (sField1.Length > 0)
                        {
                            sComment = FieldWithComment[1];
                            sUntil = sField0;
                            sValue = sField1;

                            sTmp = sUntil.Trim();
                            sUntil = sTmp.Trim();

                            if (sValue.Contains(";"))
                                sTmp = sValue.Replace(";", "");
                            else
                                sTmp = sValue.Trim();
                            sValue = sTmp.Trim();

                            AddFieldItem(sUntil, sComment);
                            AddFieldItem(sValue, "");
                        }
                        else
                        {
                            sUntil = sField0;
                            sComment = FieldWithComment[1];
                            AddFieldItem(sUntil, sComment);
                        }
                    }
                    else
                    {
                        sUntil = sField0;
                        if (sUntil.Contains(";"))
                            sTmp = sUntil.Replace(";", "");
                        else
                            sTmp = sUntil.Trim();
                        sUntil = sTmp.Trim();

                        sComment = FieldWithComment[1];
                        AddFieldItem(sUntil, sComment);
                    }

                }
                else
                    if (line_items[i].Contains('!'))
                    {
                        // if the line has a !, break it there
                        string[] FieldWithComment = line_items[i].Split('!');
                        string[] fields = FieldWithComment[0].Split(',');

                        bSkipThisField = false;

                        if ((FieldWithComment.Length == 2) && (fields.Length < 3))
                        {
                            // clean the data
                            if (fields[0].Contains(";"))
                                sTmp = fields[0].Replace(";", "");
                            else
                                sTmp = fields[0].Trim();
                            fields[0] = sTmp.Trim();

                            // clean the comment
                            if (FieldWithComment[1].Contains("- "))
                                sTmp = FieldWithComment[1].Replace("- ", "");
                            else
                                sTmp = FieldWithComment[1].Trim();
                            FieldWithComment[1] = sTmp;

                            if (FieldWithComment[1].Contains("{"))
                            {
                                sTmp = FieldWithComment[1].Substring(0, FieldWithComment[1].IndexOf("{"));
                                FieldWithComment[1] = sTmp.Trim();
                            }

                            if ((IDD_Class == "BuildingSurface:Detailed") || (IDD_Class == "Shading:Site:Detailed"))
                            {
                                if (FieldWithComment[1].StartsWith("X,Y,Z"))
                                {
                                    if (fields[0].Length == 0)
                                        bSkipThisField = true;
                                }
                            }

                            if (!bSkipThisField)
                                AddFieldItem(fields[0].Trim(), FieldWithComment[1].Trim());
                        }
                        else
                        {
                            // more than 2 data items on this line, like X,Y,Z, !- comment xyz
                            for (int j = 0; j < fields.Length; j++)
                            {
                                bSkipThisField = false;

                                // clean the data
                                if (fields[j].Contains(";"))
                                    sTmp = fields[j].Replace(";", "");
                                else
                                    sTmp = fields[j].Trim();
                                fields[j] = sTmp.Trim();

                                // clean the data
                                if (fields[j].Contains(","))
                                    sTmp = fields[j].Replace(",", "");
                                else
                                    sTmp = fields[j].Trim();
                                fields[j] = sTmp.Trim();

                                // XYZ triplets on one line ?
                                if (line_items[i].Contains("X,Y,Z"))
                                {
                                    if (fields.Length == 4)
                                    {
                                        if (j == 3)
                                        {
                                            // the 4th field is empty, ignore it
                                            bSkipThisField = true;
                                        }
                                    }
                                }

                                if (!bSkipThisField)
                                    AddFieldItem(fields[j].Trim(), "");
                            }
                        }
                    }
                    else
                    {
                        // no comment
                        string[] fields = line_items[i].Split(',');

                        // more than 2 data items on this line, like X,Y,Z, 
                        for (int j = 0; j < fields.Length; j++)
                        {
                            bSkipThisField = false;

                            // clean the data
                            if (fields[j].Contains(";"))
                                sTmp = fields[j].Replace(";", "");
                            else
                                sTmp = fields[j].Trim();
                            fields[j] = sTmp.Trim();

                            // clean the data
                            if (fields[j].Contains(","))
                                sTmp = fields[j].Replace(",", "");
                            else
                                sTmp = fields[j].Trim();
                            fields[j] = sTmp.Trim();

                            // XYZ triplets on one line ?
                            //if (line_items[i].Contains("X,Y,Z"))
                            //{
                            //if (fields.Length == 4)
                            //{
                            if (j == (fields.Length - 1))
                            {
                                // if the 4th field is empty, ignore it
                                sTmp = fields[j].Trim();

                                if (sTmp.Length == 0)
                                    bSkipThisField = true;
                            }
                            //}
                            //}

                            if (!bSkipThisField)
                                AddFieldItem(fields[j].Trim(), "");
                        }

                    }

            }

        }

        return bError;
    }

}

public class IDF_ObjectCollection : System.Collections.CollectionBase
{
    public void Add(IDF_Object aPoint)
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

    public IDF_Object Item(int Index)
    {
        return (IDF_Object)List[Index];
    }
}


public class EcoDomus_IDF_Import
{
    public EcoDomus_Data_Connection ecodomus_client;
    IDF_ObjectCollection imported_objects;

    public bool bShowDebugOutput;
    public string ClientDBName;
    public string IDF_Version;
    public long import_order_objects;
    public int import_order_fields;

    public string pk_energymodel_simulation_object_id;
    public string pk_energymodel_simulation_object_value_id;
    public string pk_energymodel_simulation_profile;
    public string pk_facility_id;
    public string pk_project_id;
    public string pk_system_id;
    public string pk_zone_id;
    public string pk_asset_id;

    long CommentCounter;
    string strline;
    bool bStartsWithComment;
    bool bContainsComma;
    bool bEndsWithComma;
    bool bContainsColon;
    bool bContainsSemiColon;
    bool bObjectStart;
    bool bObjectEnd;
    bool bSingleLineObject;
    string FieldValue;
    string sTmp;
    string pk_field_id;
    string FieldComment;

    public EcoDomus_IDF_Import()
    {
        imported_objects = new IDF_ObjectCollection();

        bShowDebugOutput = false;
        ClientDBName = "gsa2";
        CommentCounter = 0;
        strline = "";
        bStartsWithComment = false;
        bContainsComma = false;
        bEndsWithComma = false;
        bContainsColon = false;
        bContainsSemiColon = false;
        bObjectStart = false;
        bObjectEnd = false;
        bSingleLineObject = false;
        FieldValue = "";
        sTmp = "";
        pk_field_id = "";
        FieldComment = "";

        IDF_Version = "0.0";
        import_order_objects = 0;
        import_order_fields = -1;

        pk_energymodel_simulation_object_id = "00000000-0000-0000-0000-000000000000";
        pk_energymodel_simulation_object_value_id = "00000000-0000-0000-0000-000000000000";
        pk_energymodel_simulation_profile = "00000000-0000-0000-0000-000000000000";
        pk_facility_id = "00000000-0000-0000-0000-000000000000";
        pk_project_id = "00000000-0000-0000-0000-000000000000";
        pk_system_id = "00000000-0000-0000-0000-000000000000";
        pk_zone_id = "00000000-0000-0000-0000-000000000000";
        pk_asset_id = "00000000-0000-0000-0000-000000000000";

        // EcoDomus Client Connection ---------------------------------------------
        ecodomus_client = new EcoDomus_Data_Connection();
        ecodomus_client.bCancel = false;
        ecodomus_client.bOpened = false;

        //ClientDBName = "gsa2";
        //ecodomus_client.sql_connection.ConnectionString = @"Data Source=" + @"DaveAdkisson-PC\SQLExpress" + ";";
        //ecodomus_client.sql_connection.ConnectionString += "Initial Catalog=" + ClientDBName + ";";
        //ecodomus_client.sql_connection.ConnectionString += "User Id=" + "sa" + ";";
        //ecodomus_client.sql_connection.ConnectionString += "Password=" + "ecodomus@123" + ";";
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

    string GetZoneID(string pk_facility_id, string sZoneName, bool bAllowCreation)
    {
        string strFoundGuid = "00000000-0000-0000-0000-000000000000";
        string strSQLQuery = "";
        bool bFound = false;
        bool bCreated = false;

        // if we are connected to the client db
        if (ecodomus_client.sql_connection.State == ConnectionState.Open)
        {
            // search for it !
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
                bFound = true;
                break;
            }
            ecodomus_client.sql_reader.Close();

            if (bAllowCreation)
            {
                // create it if not found and allowed ?
                if (!bFound)
                {
                    ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
                    ecodomus_client.sql_command.CommandType = CommandType.StoredProcedure;
                    ecodomus_client.sql_command.CommandText = "proc_insert_update_zone_profile";
                    ecodomus_client.sql_command.Parameters.AddWithValue("location_id", Guid.Empty.ToString());
                    ecodomus_client.sql_command.Parameters.AddWithValue("fk_facility_id", pk_facility_id);
                    ecodomus_client.sql_command.Parameters.AddWithValue("name", sZoneName);
                    ecodomus_client.sql_command.Parameters.AddWithValue("description", "");
                    ecodomus_client.sql_command.Parameters.AddWithValue("category", "Zone");
                    ecodomus_client.sql_command.Parameters.AddWithValue("user_id", "00000000-0000-0000-0000-000000000000");
                    try
                    {
                        ecodomus_client.sql_command.ExecuteNonQuery();
                        bCreated = true;
                    }
                    catch (Exception ex)
                    {
                        ShowDebugMessage(ex.Message.ToString());
                        bCreated = false;
                    }
                }

                // if we created it, lets get the guid. (this is the hard way to do it)
                // used to use SELECT @IDENTITY to get the last id inserted into the db
                if (bCreated)
                {
                    // search for it !
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
                        bFound = true;
                        break;
                    }
                    ecodomus_client.sql_reader.Close();
                }

            }

        }

        return strFoundGuid;
    }

    public long Import_IDF_File(string file_name)
    {
        System.IO.StreamReader file;
        long ObjectsImported = 0;
        IDF_Object object_item = new IDF_Object();
        bool bObjectSaved = false;
        bool bFieldSaved = false;

        bObjectEnd = false;
        bObjectStart = false;
        bSingleLineObject = false;
        import_order_objects = 0;

        // try to open the file, return -1 if we fail
        try
        {
            file = new System.IO.StreamReader(file_name);
        }
        catch (Exception ex)
        {
            return -1;
        }

        // for every line in the file ...
        while ((strline = file.ReadLine()) != null)
        {
            // remember what special chars are on this line ?
            bStartsWithComment = strline.StartsWith("!");
            bContainsComma = strline.Contains(",");
            bEndsWithComma = strline.EndsWith(",");
            bContainsColon = strline.Contains(":");
            bContainsSemiColon = strline.Contains(";");
            bSingleLineObject = false;

            // line starts with a comment ?
            if (bStartsWithComment)
            {
                // ignore comment
                CommentCounter++;
            }
            else
            {
                // complete simple object name on one line like Version,7.2; ?
                if (!bObjectStart && !bContainsColon && bContainsComma && bContainsSemiColon)
                {
                    import_order_objects++;
                    object_item = new IDF_Object();

                    // get the IDD class
                    string[] fields = strline.Split(',');
                    object_item.IDD_Class = fields[0].Trim();

                    object_item.import_order = import_order_objects;
                    object_item.AddLineItem(strline, false);
                    object_item.UnpackLineItems();
                    imported_objects.Add(object_item);

                    bSingleLineObject = true;
                    bObjectStart = false;
                    bObjectEnd = false;
                }

                // complete multipart object name and fields on one line like:
                // "Site:GroundTemperature:BuildingSurface,20,20,20,20,20,20,20,20,20,20,20,20;" ?
                if (!bObjectStart && bContainsColon && bContainsComma && bContainsSemiColon)
                {
                    import_order_objects++;
                    object_item = new IDF_Object();

                    // get the IDD class
                    string[] fields = strline.Split(',');
                    object_item.IDD_Class = fields[0].Trim();

                    object_item.import_order = import_order_objects;
                    object_item.AddLineItem(strline, false);
                    object_item.UnpackLineItems();
                    imported_objects.Add(object_item);

                    bSingleLineObject = true;
                    bObjectStart = false;
                    bObjectEnd = false;
                }

                // data fields for the current object ?
                if (!bSingleLineObject && bObjectStart && !bObjectEnd && bContainsComma && !bContainsSemiColon)
                {
                    object_item.AddLineItem(strline, true);
                }

                // does this line have a object starting on this line and continuing on the next lines ?
                if (!bSingleLineObject && !bObjectStart && bEndsWithComma)
                {
                    import_order_objects++;

                    object_item = new IDF_Object();
                    object_item.bMultiLineObject = true;
                    object_item.import_order = import_order_objects;

                    // get the IDD class
                    sTmp = strline.Replace(",", "");
                    object_item.IDD_Class = sTmp.Trim();

                    bObjectStart = true;
                    bObjectEnd = false;
                }

                // last data field for the current object ?
                if (!bSingleLineObject && bObjectStart && !bObjectEnd && bContainsSemiColon)
                {
                    object_item.AddLineItem(strline, true);
                    bObjectEnd = true;
                }

                // ended the current object ?
                if (!bSingleLineObject && bObjectStart && bObjectEnd)
                {
                    object_item.UnpackLineItems();
                    imported_objects.Add(object_item);
                    bObjectStart = false;
                    bObjectEnd = false;
                }

            }

        }

        // close the file
        file.Close();

        // now save our data in the imported_objects collection ...

        bool bSaveObjectNow = false;

        // list of object types we need to process first, like Systems, Zones, etc.
        string[] IDD_Classes_Process_First = new string[5];
        string[] IDD_Classes_Process_LinkItem = new string[5];

        IDD_Classes_Process_First[0] = "Zone";
        IDD_Classes_Process_LinkItem[0] = "Name";

        IDD_Classes_Process_First[1] = "People";
        IDD_Classes_Process_LinkItem[1] = "Zone or ZoneList Name";

        IDD_Classes_Process_First[2] = "Lights";
        IDD_Classes_Process_LinkItem[2] = "Zone or ZoneList Name";

        IDD_Classes_Process_First[3] = "ElectricEquipment";
        IDD_Classes_Process_LinkItem[3] = "Zone or ZoneList Name";

        IDD_Classes_Process_First[4] = "";
        IDD_Classes_Process_LinkItem[4] = "";

        for (int ProcessIndex = 0; ProcessIndex < 5; ProcessIndex++)
        {
            foreach (IDF_Object obj in imported_objects)
            {
                if ((obj.IDD_Class == IDD_Classes_Process_First[ProcessIndex]) && (ProcessIndex != 4))
                {
                    // get the associated object name 
                    obj.associated_object = GetCollectionObjectValue(obj, IDD_Classes_Process_LinkItem[ProcessIndex]);

                    // if were looking for a zone, allow it to be created
                    if (IDD_Classes_Process_First[ProcessIndex] == "Zone")
                        obj.pk_associated_object_id = GetZoneID(pk_facility_id, obj.associated_object, true);
                    else
                    {
                        // if were looking for something related to a zone, do not create it
                        obj.pk_associated_object_id = GetZoneID(pk_facility_id, obj.associated_object, false);
                    }

                    // flag to save this one now
                    bSaveObjectNow = true;
                }
                else
                {
                    if (ProcessIndex == 4)
                        bSaveObjectNow = true;
                    else
                        bSaveObjectNow = false;
                }

                if ((bSaveObjectNow) && (obj.Saved == false))
                {
                    obj.pk_object_id = Is_IDD_Object(obj.IDD_Class);
                    if (obj.pk_object_id.Length == 0)
                    {
                        obj.pk_object_id = Guid.Empty.ToString();
                    }

                    Console.Write(obj.import_order + " - " + obj.pk_object_id + " " + obj.IDD_Class + "\r\n");
                    if (obj.pk_object_id.Length > 0)
                    {
                        pk_energymodel_simulation_object_id = Guid.NewGuid().ToString();
                        bObjectSaved = SaveSimObject(pk_energymodel_simulation_object_id,
                                                                pk_facility_id,
                                                                pk_project_id,
                                                                pk_system_id,
                                                                obj.pk_associated_object_id,
                                                                pk_asset_id,
                                                                obj.pk_object_id,
                                                                IDF_Version,
                                                                obj.import_order,
                                                                "");
                        if (bObjectSaved)
                        {
                            obj.Saved = true;

                            import_order_fields = 0;
                            for (int i = 0; i < (obj.arrFields.Length - 1); i++)
                            {
                                FieldValue = obj.arrFields[i].Trim();
                                FieldComment = obj.arrComments[i].Trim();

                                // IDD only defines the first 100 field items, after that use a empty guid.
                                if (i > 100)
                                {
                                    pk_field_id = Guid.Empty.ToString();
                                }
                                else
                                {
                                    pk_field_id = GetFieldID(obj.pk_object_id, import_order_fields, FieldComment);
                                }

                                pk_energymodel_simulation_object_value_id = Guid.NewGuid().ToString();
                                bFieldSaved = SaveSimObjectValue(pk_energymodel_simulation_object_value_id,
                                                                        pk_energymodel_simulation_object_id,
                                                                        pk_field_id,
                                                                        FieldValue,
                                                                        import_order_fields,
                                                                        FieldComment);
                                import_order_fields++;
                            }
                        }
                        else
                        {
                            TrackImportError(pk_energymodel_simulation_profile,
                                                pk_facility_id,
                                                pk_project_id,
                                                obj.pk_object_id,
                                                obj.IDD_Class,
                                                IDF_Version,
                                                import_order_objects,
                                                0);
                        }
                    }
                }
            }
        }

        return ObjectsImported;
    }

    string GetCollectionObjectValue(IDF_Object idf_object, string FieldName)
    {
        string sFieldValue = "";

        for (int i = 0; i < idf_object.arrComments.Length; i++)
        {
            if (idf_object.arrComments[i] == FieldName)
            {
                sFieldValue = idf_object.arrFields[i].ToString();
                break;
            }
        }

        return sFieldValue;
    }

    bool SaveSimObject(string s_simulation_object_id,
        string s_facility_id,
        string s_project_id,
        string s_system_id,
        string s_zone_id,
        string s_asset_id,
        string s_object_id,
        string s_file_version,
        long import_order_objects,
        string s_export_format)
    {

        bool bSuccess = false;
        string sSQLInsert = "";
        bool bUseStoredProcedure = true;

        if (bUseStoredProcedure)
        {
            ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
            ecodomus_client.sql_command.CommandType = CommandType.StoredProcedure;
            ecodomus_client.sql_command.CommandText = "proc_SaveSimObject";

            ecodomus_client.sql_command.Parameters.AddWithValue("pk_simulation_object_id", s_simulation_object_id);
            ecodomus_client.sql_command.Parameters.AddWithValue("fk_facility_id", s_facility_id);
            ecodomus_client.sql_command.Parameters.AddWithValue("fk_project_id", s_project_id);
            ecodomus_client.sql_command.Parameters.AddWithValue("fk_system_id", s_system_id);
            ecodomus_client.sql_command.Parameters.AddWithValue("fk_zone_id", s_zone_id);
            ecodomus_client.sql_command.Parameters.AddWithValue("fk_asset_id", s_asset_id);
            ecodomus_client.sql_command.Parameters.AddWithValue("fk_object_id", s_object_id);
            ecodomus_client.sql_command.Parameters.AddWithValue("file_version", s_file_version);
            ecodomus_client.sql_command.Parameters.AddWithValue("import_order_objects", import_order_objects);
            ecodomus_client.sql_command.Parameters.AddWithValue("export_format", s_export_format);

            try
            {
                ecodomus_client.sql_command.ExecuteNonQuery();
                bSuccess = true;
            }
            catch (Exception ex)
            {
                ShowDebugMessage(ex.Message.ToString());
                bSuccess = false;
            }
        }
        else
        {
            sSQLInsert = "INSERT INTO [tbl_energymodel_simulation_objects]";
            sSQLInsert += "([pk_simulation_object_id]";
            sSQLInsert += ",[fk_facility_id]";
            sSQLInsert += ",[fk_project_id]";
            sSQLInsert += ",[fk_system_id]";
            sSQLInsert += ",[fk_zone_id]";
            sSQLInsert += ",[fk_asset_id]";
            sSQLInsert += ",[fk_object_id]";
            sSQLInsert += ",[file_version]";
            sSQLInsert += ",[import_order_objects]";
            sSQLInsert += ",[export_format]";
            sSQLInsert += ")VALUES(";
            sSQLInsert += "'" + s_simulation_object_id + "'";
            sSQLInsert += ",'" + s_facility_id + "'";
            sSQLInsert += ",'" + s_project_id + "'";
            sSQLInsert += ",'" + s_system_id + "'";
            sSQLInsert += ",'" + s_zone_id + "'";
            sSQLInsert += ",'" + s_asset_id + "'";
            sSQLInsert += ",'" + s_object_id + "'";
            sSQLInsert += ",'" + s_file_version + "'";
            sSQLInsert += "," + import_order_objects;
            sSQLInsert += ",'" + s_export_format + "'";
            sSQLInsert += ")";

            if (ecodomus_client.sql_connection.State == ConnectionState.Open)
            {
                try
                {
                    ecodomus_client.sql_write_command.CommandType = System.Data.CommandType.Text;
                    ecodomus_client.sql_write_command.CommandText = sSQLInsert;
                    ecodomus_client.sql_write_command.Connection = ecodomus_client.sql_connection;
                    ecodomus_client.sql_write_command.ExecuteNonQuery();
                    bSuccess = true;
                }
                catch (Exception ex)
                {
                    bSuccess = false;
                }
            }
        }

        return bSuccess;
    }

    bool SaveSimObjectValue(string s_simulation_value_id,
        string s_simulation_object_id,
        string s_field_id,
        string s_value,
        int import_order_fields,
        string sFieldComment)
    {

        bool bSuccess = false;
        string sSQLInsert = "";
        bool bUseStoredProcedure = true;

        if (bUseStoredProcedure)
        {
            ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
            ecodomus_client.sql_command.CommandType = CommandType.StoredProcedure;
            ecodomus_client.sql_command.CommandText = "proc_SaveSimObjectValue";

            ecodomus_client.sql_command.Parameters.AddWithValue("pk_simulation_value_id", s_simulation_value_id);
            ecodomus_client.sql_command.Parameters.AddWithValue("pk_simulation_object_id", s_simulation_object_id);
            ecodomus_client.sql_command.Parameters.AddWithValue("fk_field_id", s_field_id);
            ecodomus_client.sql_command.Parameters.AddWithValue("value", s_value);
            ecodomus_client.sql_command.Parameters.AddWithValue("import_order_fields", import_order_fields);
            ecodomus_client.sql_command.Parameters.AddWithValue("comment", sFieldComment);

            try
            {
                ecodomus_client.sql_command.ExecuteNonQuery();
                bSuccess = true;
            }
            catch (Exception ex)
            {
                ShowDebugMessage(ex.Message.ToString());
                bSuccess = false;
            }

        }
        else
        {
            sSQLInsert = "INSERT INTO [tbl_energymodel_simulation_object_values]";
            sSQLInsert += "([pk_simulation_value_id]";
            sSQLInsert += ",[pk_simulation_object_id]";
            sSQLInsert += ",[fk_field_id]";
            sSQLInsert += ",[value]";
            sSQLInsert += ",[import_order_fields]";
            sSQLInsert += ",[comment]";
            sSQLInsert += ")VALUES(";
            sSQLInsert += "'" + s_simulation_value_id + "'";
            sSQLInsert += ",'" + s_simulation_object_id + "'";
            sSQLInsert += ",'" + s_field_id + "'";
            sSQLInsert += ",'" + s_value + "'";
            sSQLInsert += "," + import_order_fields;
            sSQLInsert += ",'" + sFieldComment + "'";
            sSQLInsert += ")";

            if (ecodomus_client.sql_connection.State == ConnectionState.Open)
            {
                try
                {
                    ecodomus_client.sql_write_command.CommandType = System.Data.CommandType.Text;
                    ecodomus_client.sql_write_command.CommandText = sSQLInsert;
                    ecodomus_client.sql_write_command.Connection = ecodomus_client.sql_connection;
                    ecodomus_client.sql_write_command.ExecuteNonQuery();
                    bSuccess = true;
                }
                catch (Exception ex)
                {
                    bSuccess = false;
                }
            }
        }

        return bSuccess;
    }

    bool TrackImportError(string s_energymodel_simulation_profile,
        string s_facility_id,
        string s_project_id,
        string s_object_id,
        string s_lineitem,
        string s_file_version,
        long import_order_objects,
        int import_order_fields)
    {

        bool bSuccess = false;
        string sSQLInsert = "";

        sSQLInsert = "INSERT INTO [tbl_energymodel_simulation_import_error]";
        sSQLInsert += "([pk_error_id]";
        sSQLInsert += ",[fk_energymodel_simulation_profile]";
        sSQLInsert += ",[fk_facility_id]";
        sSQLInsert += ",[fk_project_id]";
        sSQLInsert += ",[fk_object_id]";
        sSQLInsert += ",[lineitem]";
        sSQLInsert += ",[file_version]";
        sSQLInsert += ",[import_order_objects]";
        sSQLInsert += ",[import_order_fields]";
        sSQLInsert += ")VALUES(";
        sSQLInsert += "'" + Guid.NewGuid().ToString() + "'";
        sSQLInsert += ",'" + s_energymodel_simulation_profile + "'";
        sSQLInsert += ",'" + s_facility_id + "'";
        sSQLInsert += ",'" + s_project_id + "'";
        sSQLInsert += ",'" + s_object_id + "'";
        sSQLInsert += ",'" + s_lineitem + "'";
        sSQLInsert += ",'" + s_file_version + "'";
        sSQLInsert += "," + import_order_objects;
        sSQLInsert += "," + import_order_fields;
        sSQLInsert += ")";

        if (ecodomus_client.sql_connection.State == ConnectionState.Open)
        {
            ecodomus_client.sql_write_command.CommandType = System.Data.CommandType.Text;
            ecodomus_client.sql_write_command.CommandText = sSQLInsert;
            ecodomus_client.sql_write_command.Connection = ecodomus_client.sql_connection;
            ecodomus_client.sql_write_command.ExecuteNonQuery();
        }

        return bSuccess;
    }

    string GetFieldID(string pk_object_id, int iFieldIndex, string field_name)
    {
        string strFieldID = "";
        string strFieldName = "";
        string strSQLQuery = "";
        int RecordIndex = -1;

        strSQLQuery = "SELECT [SEQ_ID] ";
        strSQLQuery += ",[pk_field_id] ";
        strSQLQuery += ",[fk_object_id] ";
        strSQLQuery += ",[field_index] ";
        strSQLQuery += ",[field_name] ";
        strSQLQuery += ",[is_required] ";
        strSQLQuery += ",[minimum_value] ";
        strSQLQuery += ",[maximum_value] ";
        strSQLQuery += ",[default_value] ";
        strSQLQuery += ",[data_type] ";
        strSQLQuery += ",[is_object_list] ";
        strSQLQuery += ",[is_reference] ";
        strSQLQuery += "FROM [tbl_energymodel_object_fields] ";
        strSQLQuery += "WHERE [fk_object_id] = '" + pk_object_id + "' ";
        strSQLQuery += "ORDER BY [SEQ_ID] ASC";

        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
        ecodomus_client.sql_command.CommandText = strSQLQuery;
        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

        // record counters
        int iRecordCount = -1;

        while (ecodomus_client.sql_reader.Read())
            iRecordCount++;
        ecodomus_client.sql_reader.Close();

        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

        while (ecodomus_client.sql_reader.Read())
        {
            RecordIndex++;

            if (RecordIndex == iFieldIndex)
            {
                strFieldName = ecodomus_client.sql_reader["field_name"].ToString();
                strFieldID = ecodomus_client.sql_reader["pk_field_id"].ToString();
                break;
            }

        }

        ecodomus_client.sql_reader.Close();

        return strFieldID;
    }

    string Is_IDD_Object(string strName)
    {
        string strSQLQuery = "";
        string strObjectID = "";

        strSQLQuery = "SELECT [SEQ_ID] ";
        strSQLQuery += ",[pk_object_id] ";
        strSQLQuery += ",[object_group_name] ";
        strSQLQuery += ",[object_name] ";
        strSQLQuery += ",[is_unique] ";
        strSQLQuery += ",[is_required] ";
        strSQLQuery += ",[is_obsolete] ";
        strSQLQuery += ",[minumum_number_of_fields] ";
        strSQLQuery += ",[extensible_number_of_fields] ";
        strSQLQuery += ",[is_extensible] ";
        strSQLQuery += ",[format] ";
        strSQLQuery += ",[comments] ";
        strSQLQuery += "FROM [tbl_energymodel_objects] ";
        strSQLQuery += "WHERE [object_name] = '" + strName + "'";

        ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
        ecodomus_client.sql_command.CommandText = strSQLQuery;
        ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

        while (ecodomus_client.sql_reader.Read())
        {
            strObjectID = ecodomus_client.sql_reader["pk_object_id"].ToString();
        }

        ecodomus_client.sql_reader.Close();

        return strObjectID;
    }

}