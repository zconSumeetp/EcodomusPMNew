using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.DataVisualization.Charting;

namespace EcoDomus_Analysis
{
    public class Performance_Analysis
    {
        // SQL Data connection for the client db
        public SQL_Data_Connection ecodomus_client;

        // a collection of algorithms
        public Analysis_Alorithm_Collection algorithms;

        // a collection of zones
        Analysis_Zone_Collection zones;

        // start and end date / time for analysis
        public DateTime Start_DateTime;
        public DateTime End_DateTime;

        public string fk_facility_id;
        public string fk_project_id;
        public string fk_system_id;
        public string fk_zone_id;
        public string fk_space_id;
        public string fk_asset_id;
        public string fk_attribute_id;

        // constructor for the main class
        public Performance_Analysis()
        {
            ecodomus_client = new SQL_Data_Connection();
            algorithms = new Analysis_Alorithm_Collection();
            zones = new Analysis_Zone_Collection();
            fk_facility_id = Guid.Empty.ToString();
            fk_project_id = Guid.Empty.ToString();
            fk_system_id = Guid.Empty.ToString();
            fk_zone_id = Guid.Empty.ToString();
            fk_space_id = Guid.Empty.ToString();
            fk_asset_id = Guid.Empty.ToString();
            fk_attribute_id = Guid.Empty.ToString();
            Start_DateTime = new DateTime();
            End_DateTime = new DateTime();
        }

        // 2 Point linear Interpolation
        double interpolate( double x0, double y0, double x1, double y1, double x )
        {
            return y0*(x - x1)/(x0 - x1) + y1*(x - x0)/(x1 - x0);
        }

        // Linear Interpolation
        double LinearInterpolate(double y1, double y2, double mu)
        {
            return (y1 * (1 - mu) + y2 * mu);
        }

        // Cosine Interpolation
        double CosineInterpolate(double y1, double y2, double mu)
        {
            double mu2;
            mu2 = (1 - Math.Cos(mu * Math.PI)) / 2;
            return (y1 * (1 - mu2) + y2 * mu2);
        }
        
        // a zone
        public class Analysis_Zone_Item
        {
            public string pk_zone_id;
            public string zone_name;
            public Analysis_Data_Item_Collection Data_Items;
            public Analysis_Space_Item_Collection spaces;
            public double PerformanceValue;

            public Analysis_Zone_Item()
            {
                pk_zone_id = "";
                zone_name = "";
                Data_Items = new Analysis_Data_Item_Collection();
                spaces = new Analysis_Space_Item_Collection(); 
                PerformanceValue = 0.0f;
            }

            public int Load_Spaces(ref SQL_Data_Connection conn, string s_facility_id)
            {
                string strSQLQuery;
                int iSpacesFound = 0;

                spaces.Clear();

                strSQLQuery = "select ";
                strSQLQuery += "tbl_zone_space_linkup.fk_zone_id as 'zone_id' ";
                strSQLQuery += ",tbl_location.pk_location_id AS space_id ";
                strSQLQuery += ",tbl_location.fk_facility_id ";
                strSQLQuery += ",tbl_location.description AS space_desc ";
                strSQLQuery += ",tbl_location.name AS space_name ";
                strSQLQuery += ",tbl_facility.name AS facility_name ";
                strSQLQuery += "from tbl_location ";
                strSQLQuery += "INNER JOIN vw_get_entity ";
                strSQLQuery += "ON vw_get_entity.pk_entity_id = tbl_location.fk_entity_id ";
                strSQLQuery += "AND vw_get_entity.entity_name = 'Space' ";
                strSQLQuery += "INNER JOIN tbl_facility ";
                strSQLQuery += "ON tbl_facility.pk_facility_id = tbl_location.fk_facility_id ";
                strSQLQuery += "LEFT JOIN tbl_zone_space_linkup ";
                strSQLQuery += "on tbl_zone_space_linkup.fk_space_id= tbl_location.pk_location_id ";
                strSQLQuery += "where tbl_location.fk_facility_id = '" + s_facility_id + "' ";
                strSQLQuery += "AND tbl_zone_space_linkup.fk_zone_id = '" + pk_zone_id + "' ";
                strSQLQuery += "AND tbl_location.fk_location_parent_id IS NOT NULL ";
                strSQLQuery += "ORDER BY tbl_location.name ";

                conn.sql_command = conn.sql_connection.CreateCommand();
                conn.sql_command.CommandText = strSQLQuery;
                conn.sql_reader = conn.sql_command.ExecuteReader();

                while (conn.sql_reader.Read())
                {
                    Analysis_Space_Item space_item = new Analysis_Space_Item();
                    space_item.space_id = conn.sql_reader["space_id"].ToString();
                    space_item.space_name = conn.sql_reader["space_name"].ToString();
                    spaces.Add(space_item);
                    iSpacesFound++;
                }

                conn.sql_reader.Close();

                return iSpacesFound;
            }
        }

        // a collection of zones
        public class Analysis_Zone_Collection : System.Collections.CollectionBase
        {
            public void Add(Analysis_Zone_Item aItem)
            {
                List.Add(aItem);
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
            public Analysis_Zone_Item Item(int Index)
            {
                return (Analysis_Zone_Item)List[Index];
            }
        }

        // an asset attribute, will hold the info and BAS data for a single point
        public class Analysis_Attribute_Item
        {
            public double PerformanceValue;

            public string pk_asset_id;
            public string fk_omniclass_detail_id;

            public bool BAS_Enabled;
            public string tag_name;
            public Analysis_Data_Item_Collection Data_Items;

            public string attribute_id;
            public string attribute_name;
            public string attribute_value;

            public string pk_type_id;
            public string type_name;
            public string type_description;
            public string type_attribute_name;
            public string type_attribute_value;

            public Analysis_Attribute_Item()
            {
                PerformanceValue = 0.0f;
                pk_asset_id = "";
                fk_omniclass_detail_id = "";
                BAS_Enabled = false;
                tag_name = "";

                attribute_id = "";
                attribute_name = "";
                attribute_value = "";

                pk_type_id = "";
                type_name = "";
                type_description = "";
                type_attribute_name = "";
                type_attribute_value = "";

                Data_Items = new Analysis_Data_Item_Collection();
            }
        }

        // a collection of asset attributes
        public class Analysis_Attribute_Collection : System.Collections.CollectionBase
        {
            public void Add(Analysis_Attribute_Item aItem)
            {
                List.Add(aItem);
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
            public Analysis_Attribute_Item Item(int Index)
            {
                return (Analysis_Attribute_Item)List[Index];
            }
        }
        
        // a asset item
        public class Analysis_Asset_Item
        {
            public string asset_id;
            public string asset_name;
            public string asset_type;
            public string asset_omniclass;
            public Analysis_Attribute_Collection attributes;
            public Analysis_Attribute_Collection type_attributes;

            public Analysis_Asset_Item()
            {
                asset_id = "";
                asset_name = "";
                asset_type = "";
                asset_omniclass = "";
                attributes = new Analysis_Attribute_Collection();
                type_attributes = new Analysis_Attribute_Collection();
            }

            public int Load_Attributes(ref SQL_Data_Connection conn, string s_asset_id)
            {
                string strSQLQuery;
                int iAttributesFound = 0;

                strSQLQuery = "SELECT ";
                strSQLQuery += "[tbl_asset].[pk_asset_id] ";
                strSQLQuery += ",[tbl_asset].[fk_facility_id] ";
                strSQLQuery += ",[tbl_asset].[name] as [AssetName] ";
                strSQLQuery += ",[tbl_asset_attribute].[pk_asset_attribute_id] ";
                strSQLQuery += ",[tbl_asset_attribute].[name] as [AttributeName] ";
                strSQLQuery += ",[tbl_asset_attribute_value].[value] ";
                strSQLQuery += ",[tbl_asset_attribute_value].[fk_uom_id] ";
                strSQLQuery += "FROM [tbl_asset_attribute] ";
                strSQLQuery += "INNER JOIN [tbl_asset] ON [tbl_asset].[pk_asset_id] = [tbl_asset_attribute].[fk_asset_id] ";
                strSQLQuery += "INNER JOIN [tbl_asset_attribute_value] ON [tbl_asset_attribute_value].[fk_asset_attribute_id] = [tbl_asset_attribute].[pk_asset_attribute_id] ";
                strSQLQuery += "WHERE [tbl_asset].[pk_asset_id] = '" + s_asset_id + "' ";
                strSQLQuery += "order by [tbl_asset].[pk_asset_id], [tbl_asset_attribute].[name] ";

                conn.sql_command = conn.sql_connection.CreateCommand();
                conn.sql_command.CommandText = strSQLQuery;
                conn.sql_reader = conn.sql_command.ExecuteReader();

                while (conn.sql_reader.Read())
                {
                    Analysis_Attribute_Item attribute_item = new Analysis_Attribute_Item();

                    attribute_item.pk_asset_id = conn.sql_reader["pk_asset_id"].ToString();
                    attribute_item.attribute_id = conn.sql_reader["pk_asset_attribute_id"].ToString();
                    attribute_item.attribute_name = conn.sql_reader["AttributeName"].ToString();
                    attribute_item.attribute_value = conn.sql_reader["value"].ToString();
                    attributes.Add(attribute_item);

                    iAttributesFound++;
                }

                conn.sql_reader.Close();

                return iAttributesFound;
            }

            public int Load_Type_Attributes(ref SQL_Data_Connection conn, string s_asset_id)
            {
                string strSQLQuery;
                int iAttributesFound = 0;

                strSQLQuery = "SELECT ";

                strSQLQuery += "ta.pk_asset_id ";
                strSQLQuery += ",tbl_type.pk_type_id ";
                strSQLQuery += ",tbl_type.fk_omniclass_detail_id ";
                strSQLQuery += ",tbl_type.name as [type_name] ";
                strSQLQuery += ",tbl_type.description as type_description ";
                strSQLQuery += ",tbl_type_attribute.name as type_attribute_name ";
                strSQLQuery += ",[tbl_type_attribute_value].value  as type_attribute_value ";
                strSQLQuery += "FROM tbl_location ";

                strSQLQuery += "INNER JOIN tbl_space_asset_linkup tsal ";
                strSQLQuery += "ON tsal.fk_space_id=tbl_location.pk_location_id ";

                strSQLQuery += "INNER JOIN tbl_asset ta ON ";
                strSQLQuery += "ta.pk_asset_id=tsal.fk_asset_id ";

                strSQLQuery += "INNER JOIN tbl_type ON  ";
                strSQLQuery += "tbl_type.pk_type_id=ta.fk_type_id ";

                strSQLQuery += "INNER JOIN tbl_type_attribute ON ";
                strSQLQuery += "tbl_type_attribute.fk_type_id = tbl_type.pk_type_id ";

                strSQLQuery += "INNER JOIN [tbl_type_attribute_value] ON ";
                strSQLQuery += "[tbl_type_attribute_value].fk_type_attribute_id = [tbl_type_attribute].pk_type_attribute_id ";

                strSQLQuery += "WHERE ta.pk_asset_id = '" + s_asset_id + "' ";
                strSQLQuery += "ORDER BY tbl_type_attribute.name ";

                conn.sql_command = conn.sql_connection.CreateCommand();
                conn.sql_command.CommandText = strSQLQuery;
                conn.sql_reader = conn.sql_command.ExecuteReader();

                while (conn.sql_reader.Read())
                {
                    Analysis_Attribute_Item attribute_item = new Analysis_Attribute_Item();

                    attribute_item.pk_asset_id = conn.sql_reader["pk_asset_id"].ToString();
                    attribute_item.pk_type_id = conn.sql_reader["pk_type_id"].ToString();
                    attribute_item.fk_omniclass_detail_id = conn.sql_reader["fk_omniclass_detail_id"].ToString();
                    attribute_item.type_name = conn.sql_reader["type_name"].ToString();
                    attribute_item.type_description = conn.sql_reader["type_description"].ToString();
                    attribute_item.type_attribute_name = conn.sql_reader["type_attribute_name"].ToString();
                    attribute_item.type_attribute_value = conn.sql_reader["type_attribute_value"].ToString();

                    type_attributes.Add(attribute_item);

                    iAttributesFound++;
                }

                conn.sql_reader.Close();

                return iAttributesFound;
            }
        }

        // a collection of asset items
        public class Analysis_Asset_Item_Collection : System.Collections.CollectionBase
        {
            public void Add(Analysis_Asset_Item aItem)
            {
                List.Add(aItem);
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
            public Analysis_Asset_Item Item(int Index)
            {
                return (Analysis_Asset_Item)List[Index];
            }
        }

        // a space item
        public class Analysis_Space_Item
        {
            public string space_id;
            public string space_name;
            public Analysis_Asset_Item_Collection assets;

            public Analysis_Space_Item()
            {
                space_id = "";
                space_name = "";
                assets = new Analysis_Asset_Item_Collection();
            }

            public int Load_Assets(ref SQL_Data_Connection conn, string s_space_id)
            {
                string strSQLQuery;
                int iAssetsFound = 0;

                assets.Clear();

                strSQLQuery = "SELECT ";
                strSQLQuery += "ta.pk_asset_id ";
                strSQLQuery += ",tbl_type.pk_type_id ";
                strSQLQuery += ",tbl_type.fk_omniclass_detail_id ";
                strSQLQuery += ",tbl_location.name ";
                strSQLQuery += ",tbl_location.description ";
                strSQLQuery += ",ta.name as asset_name";
                strSQLQuery += ",ta.description ";
                strSQLQuery += ",tbl_type.name ";
                strSQLQuery += ",tbl_type.description ";
                strSQLQuery += "FROM tbl_location ";
                strSQLQuery += "INNER JOIN tbl_space_asset_linkup tsal ";
                strSQLQuery += "ON tsal.fk_space_id=tbl_location.pk_location_id ";
                strSQLQuery += "inner JOIN tbl_asset ta ON ";
                strSQLQuery += "ta.pk_asset_id=tsal.fk_asset_id ";
                strSQLQuery += "inner JOIN tbl_type ON ";
                strSQLQuery += "tbl_type.pk_type_id=ta.fk_type_id ";
                strSQLQuery += "WHERE tbl_location.pk_location_id = '" + s_space_id + "' ";
                strSQLQuery += "ORDER BY tbl_location.name";

                conn.sql_command = conn.sql_connection.CreateCommand();
                conn.sql_command.CommandText = strSQLQuery;
                conn.sql_reader = conn.sql_command.ExecuteReader();

                while (conn.sql_reader.Read())
                {
                    Analysis_Asset_Item asset_item = new Analysis_Asset_Item();
                    asset_item.asset_id = conn.sql_reader["pk_asset_id"].ToString();
                    asset_item.asset_name = conn.sql_reader["asset_name"].ToString();
                    asset_item.asset_type = conn.sql_reader["asset_name"].ToString();

                    assets.Add(asset_item);
                    iAssetsFound++;
                }

                conn.sql_reader.Close();

                return iAssetsFound;
            }
        }

        // a collection of space items
        public class Analysis_Space_Item_Collection : System.Collections.CollectionBase
        {
            public void Add(Analysis_Space_Item aItem)
            {
                List.Add(aItem);
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
            public Analysis_Space_Item Item(int Index)
            {
                return (Analysis_Space_Item)List[Index];
            }
        }

        // an analysis data item for a single historical data point.
        public class Analysis_Data_Item
        {
            public bool bIsInTolerance;

            // Value / DateTime pair
            public float Y_Value;
            public float Y_Value_Converted;
            public DateTime X_Value;

            public Analysis_Data_Item()
            {
                bIsInTolerance = false;
                Y_Value = 0.0f;
                Y_Value_Converted = 0.0f;
                X_Value = new DateTime();
            }
        }

        // a collection of data items
        public class Analysis_Data_Item_Collection : System.Collections.CollectionBase
        {
            public void Add(Analysis_Data_Item aItem)
            {
                List.Add(aItem);
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
            public Analysis_Data_Item Item(int Index)
            {
                return (Analysis_Data_Item)List[Index];
            }
        }

        // an analysis algorithm
        public class Analysis_Alorithm
        {
            public string pk_algorithm_id;
            public string fk_facility_id;
            public string fk_project_id;
            public string Message;
            public string IDD_Class;
            public string IDD_Class_Field;
            public string Omni_Class;
            public string Attribute_Name;
            public string Comparision_Operator;
            public string Tolerance_Operator;
            public float Tolerance;
            public string Impact_Operator;
            public float Impact;

            public Analysis_Alorithm()
            {
                pk_algorithm_id = "";
                fk_facility_id = "";
                fk_project_id = "";
                Message = "";
                IDD_Class = "";
                IDD_Class_Field = "";
                Omni_Class = "";
                Attribute_Name = "";
                Comparision_Operator = "";
                Tolerance_Operator = "";
                Tolerance = 0.0f;
                Impact_Operator = "";
                Impact = 0.0f;
            }
        }

        // a collection of analysis algorithms 
        public class Analysis_Alorithm_Collection : System.Collections.CollectionBase
        {
            public void Add(Analysis_Alorithm aAlgorithm)
            {
                List.Add(aAlgorithm);
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
            public Analysis_Alorithm Item(int Index)
            {
                return (Analysis_Alorithm)List[Index];
            }
        }

        public class ConvertTemp
        {
            public  float ConvertCelsiusToFahrenheit(float c)
            {
                return (float)((9.0 / 5.0) * c) + 32;
            }
            public  float ConvertFahrenheitToCelsius(float f)
            {
                return (float)(5.0 / 9.0) * (f - 32);
            }
        }
        
        // run this after EnergyPlus runs the simulation and the SQLite data import has just finished.
        public bool RunAnalysis()
        {
            bool bSuccess = false;

            // load any algorithms to run
            int iAlgorithmCount = Load_Algorithms();
            if (iAlgorithmCount > 0)
            {
                // load the zones only one time
                long lZoneCount = Load_Zones(fk_facility_id);

                //  execute each algorithm
                foreach (Analysis_Alorithm algorithm in algorithms)
                {
                    // if the algorithm is based on a zone
                    if (algorithm.IDD_Class == "Zone")
                    {
                        // go over each zone
                        foreach(Analysis_Zone_Item zone in zones)
                        {
                            // load the spaces
                            int iSpacesFound = zone.Load_Spaces(ref ecodomus_client, fk_facility_id);

                            // for each space
                            foreach (Analysis_Space_Item space in zone.spaces)
                            {
                                // look for assets
                                int iAssetsFound = space.Load_Assets(ref ecodomus_client, space.space_id);

                                // for each asset,
                                foreach (Analysis_Asset_Item asset in space.assets)
                                {
                                    // get the asset type
                                    int iTypeAttributesFound = asset.Load_Type_Attributes(ref ecodomus_client, asset.asset_id);

                                    // for each type attribute
                                    foreach (Analysis_Attribute_Item type_attribute in asset.type_attributes)
                                    {
                                        // see if we can find an omniclass in the type attribute
                                        if (type_attribute.type_attribute_name == "OmniClass Number")
                                        {
                                            // ok, we got an omniclass, is it the one we are looking for ?
                                            if (type_attribute.type_attribute_value == algorithm.Omni_Class)
                                            {
                                                // yes, this asset has the omniclass type we are looking for 

                                                // get the standard asset attributes
                                                int iAttributesFound = asset.Load_Attributes(ref ecodomus_client, asset.asset_id);

                                                // for each attribute
                                                foreach (Analysis_Attribute_Item attribute in asset.attributes)
                                                {
                                                    // compare the attribute value to the algorithm attribute name
                                                    if (attribute.attribute_name == algorithm.Attribute_Name)
                                                    {
                                                        // copy the tag_name for the BAS from the value.
                                                        attribute.tag_name = attribute.attribute_value;

                                                        // select data for BAS tag_name contained in the attribute value
                                                        long lBAS_RecordsLoaded = Load_Data_Items(attribute, Start_DateTime, End_DateTime);
                                                        
                                                        // if we have BAS records ...
                                                        if (lBAS_RecordsLoaded > 0)
                                                        {
                                                            // select data from the zone
                                                            long lZoneRecords = Load_Zone_Data(fk_facility_id, fk_project_id, zone, algorithm.IDD_Class_Field, Start_DateTime, End_DateTime);

                                                            // if we have zone records ...
                                                            if (lZoneRecords > 0)
                                                            {
                                                                // test each bas point and see how it compares to the energy modeling data
                                                                foreach (Analysis_Data_Item bas_item in attribute.Data_Items)
                                                                {
                                                                    // 
                                                                    for (int i = 0; i < zone.Data_Items.Count; i++)
                                                                    {
                                                                        // current energy modeling item
                                                                        Analysis_Data_Item em_item = zone.Data_Items.Item(i);

                                                                        // do not compare the last data point or an error will occur from trying to index for the next_em_item at (i + 1)
                                                                        if (i < (zone.Data_Items.Count - 1))
                                                                        {
                                                                            // next energy modeling item
                                                                            Analysis_Data_Item next_em_item = zone.Data_Items.Item(i + 1);

                                                                            // find the 2 energy modeling points the BAS point is between on the X Axis (Date / Time)
                                                                            if ((bas_item.X_Value >= em_item.X_Value) && (bas_item.X_Value <= next_em_item.X_Value))
                                                                            {
                                                                                // convert the X Axis date/times to long integers for bas and energy modeling
                                                                                long X1 = em_item.X_Value.Ticks;
                                                                                long X2 = next_em_item.X_Value.Ticks;
                                                                                long xBas = bas_item.X_Value.Ticks;

                                                                                // Interpolate the energy modeling Y value for where the BAS point is at in time.
                                                                                double Y1 = em_item.Y_Value;
                                                                                double Y2 = next_em_item.Y_Value;
                                                                                double dInterpolatedY = interpolate(X1, Y1, X2, Y2, xBas);

                                                                                // apply the algorithm tolerance and create a tolerance band (upper limit and lower limit)
                                                                                double dInterpolatedMax = dInterpolatedY + algorithm.Tolerance;
                                                                                double dInterpolatedMin = dInterpolatedY - algorithm.Tolerance; 

                                                                                // our bas is in DEG F. so convert it. TODO - Later we need to lookup the BAS units and decide to convert or not.
                                                                                //bas_item.Y_Value_Converted = ConvertTemp.ConvertFahrenheitToCelsius(bas_item.Y_Value);

                                                                                // compare if the bas Y value is below or above our energy modeling interpolated Y Max and Y Min
                                                                                if ((bas_item.Y_Value_Converted >= dInterpolatedMin) && (bas_item.Y_Value_Converted <= dInterpolatedMax))
                                                                                {
                                                                                    // the bas data is close the the energy modeling data within the tolerance range
                                                                                    bas_item.bIsInTolerance = true;
                                                                                }
                                                                                else
                                                                                {
                                                                                    // the bas data is above or below the tolerance band of Y Max and Y Min
                                                                                    bas_item.bIsInTolerance = false;
                                                                                }
                                                                                break;
                                                                            }

                                                                        }

                                                                    }

                                                                }

                                                                int iRecordsTotal = 0;
                                                                int iRecordsInTolerance = 0;

                                                                // we compared the data, add up the totals to build percent
                                                                foreach (Analysis_Data_Item bas_item in attribute.Data_Items)
                                                                {
                                                                    iRecordsTotal++;
                                                                    if (bas_item.bIsInTolerance)
                                                                        iRecordsInTolerance++;
                                                                }

                                                                // finally calc the accuracy in percent.
                                                                double PercentAccurate = ((double)iRecordsInTolerance / (double)iRecordsTotal) * 100.0f;

                                                                // save a performance result record in the database
                                                                bool bSaved = SavePerformanceResult(Guid.NewGuid().ToString(), fk_facility_id, fk_project_id, fk_project_id, algorithm.IDD_Class, algorithm.IDD_Class_Field, zone.pk_zone_id, zone.zone_name, algorithm.Omni_Class, attribute.attribute_name, attribute.attribute_value, attribute.attribute_id, PercentAccurate, algorithm.Tolerance, Start_DateTime, End_DateTime);

                                                            }

                                                        }
                                                        
                                                    }

                                                }

                                            }

                                        }

                                    }

                                }

                            }

                        }

                    }

                }

            }
            
            return bSuccess;
        }

        public bool GraphPerformanceResultByID(ref System.Web.UI.DataVisualization.Charting.Chart web_page_chart, string pk_result_id)
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

                GraphPerformanceResult(ref web_page_chart, 
                                                    ecodomus_client.sql_reader["pk_result_id"].ToString(),
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
                                                    DateTime.Parse(ecodomus_client.sql_reader["start_date"].ToString()),
                                                    DateTime.Parse(ecodomus_client.sql_reader["end_date"].ToString()));
                break;

            }

            ecodomus_client.sql_reader.Close();

            return bSuccess;
        }


        // graph a performance result
        public bool GraphPerformanceResult(ref System.Web.UI.DataVisualization.Charting.Chart web_page_chart,
                string pk_result_id,
                string s_facility_id,
                string s_project_id,
                string s_simulation_id,
                string sIDD_Class,
                string sIDD_Class_Field,
                string s_zone_id,
                string s_zone_name,
                string sOmni_Class,
                string sAsset_Attribute_Name,
                string sAsset_Attribute_Value,
                string s_asset_attribute_id,
                double dPerformanceValue,
                double dTolerance,
                DateTime start_date,
                DateTime end_date)
        {
            bool bSuccess = false;
            string strSQLQuery = "";

            // config the chart
            web_page_chart.Series.Clear();
            web_page_chart.Series.Add("Data_Items");
            web_page_chart.Series.Add("EM_Data");
            web_page_chart.Series.Add("WEATHER_Data");
            web_page_chart.Series.Add("ToleranceBand");

            web_page_chart.Series["EM_Data"].Color = Color.FromArgb(255, 255, 165, 0);
            web_page_chart.Series["EM_Data"].ChartType = SeriesChartType.Line;
            web_page_chart.Series["EM_Data"].MarkerStyle = MarkerStyle.None;
            web_page_chart.Series["EM_Data"].BorderWidth = 2;
            web_page_chart.Series["EM_Data"].BorderDashStyle = ChartDashStyle.Dash;
            web_page_chart.Series["EM_Data"].XAxisType = AxisType.Primary;

            web_page_chart.Series["Data_Items"].ChartType = SeriesChartType.Line;
            //chart1.Series["Data_Items"].Color = Color.FromArgb(255, 128, 0, 0);
            web_page_chart.Series["Data_Items"].Color = Color.Blue;

            web_page_chart.Series["Data_Items"].MarkerStyle = MarkerStyle.None;
            web_page_chart.Series["Data_Items"].BorderWidth = 2;
            web_page_chart.Series["Data_Items"].XAxisType = AxisType.Secondary;

            web_page_chart.Series["WEATHER_Data"].ChartType = SeriesChartType.Line;
            web_page_chart.Series["WEATHER_Data"].MarkerStyle = MarkerStyle.Circle;
            web_page_chart.Series["WEATHER_Data"].BorderWidth = 3;

            //chart1.Series["ToleranceBand"].Color = Color.FromArgb(50, 255, 165, 0);
            web_page_chart.Series["ToleranceBand"].Color = Color.FromArgb(35, 60, 179, 113);
            web_page_chart.Series["ToleranceBand"].ChartType = SeriesChartType.SplineRange;
            web_page_chart.Series["ToleranceBand"].XAxisType = AxisType.Primary;
            web_page_chart.Series["ToleranceBand"]["LineTension"] = "0.6";

            web_page_chart.ChartAreas["ChartArea1"].AxisX.IsMarginVisible = false;
            web_page_chart.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = false;
            web_page_chart.ChartAreas["ChartArea1"].AxisX.LabelStyle.IsEndLabelVisible = true;
            web_page_chart.ChartAreas["ChartArea1"].BackSecondaryColor = Color.LightGray;
            web_page_chart.ChartAreas["ChartArea1"].BackGradientStyle = GradientStyle.TopBottom;
            web_page_chart.ChartAreas["ChartArea1"].Area3DStyle.LightStyle = LightStyle.Simplistic;
            web_page_chart.ChartAreas["ChartArea1"].Area3DStyle.Perspective = 10;
            web_page_chart.ChartAreas["ChartArea1"].Area3DStyle.IsRightAngleAxes = false;

            web_page_chart.AntiAliasing = AntiAliasingStyles.All;
            web_page_chart.TextAntiAliasingQuality = TextAntiAliasingQuality.High;

            web_page_chart.ChartAreas[0].AxisX.LabelStyle.Format = "MM/dd/yyyy HH:mm";

            web_page_chart.ChartAreas[0].AxisX2.LabelStyle.Enabled = false;
            web_page_chart.ChartAreas[0].AxisX2.MajorGrid.Enabled = false;
            web_page_chart.ChartAreas[0].AxisX2.MinorGrid.Enabled = false;
            web_page_chart.ChartAreas[0].AxisX2.MajorTickMark.Enabled = false;
            web_page_chart.ChartAreas[0].AxisX2.MinorGrid.Enabled = false;
            web_page_chart.ChartAreas[0].AxisX2.MinorTickMark.Enabled = false;

            web_page_chart.ChartAreas[0].AxisY.LabelStyle.Format = "0.00";

            double dMax = -10000000000.0f;
            double dMin = 10000000000.0f;

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
            strSQLQuery += "AND [tbl_energymodeling_ReportVariableData].[fk_project_id] = '" + s_project_id + "' ";
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
                double dVal = double.Parse(ecodomus_client.sql_reader["VariableValue"].ToString());

                if (dVal > dMax)
                    dMax = dVal;
                if (dVal < dMin)
                    dMin = dVal;

                string sMonth = string.Format("{0:00}", ecodomus_client.sql_reader["Month"]);
                string sDay = string.Format("{0:00}", ecodomus_client.sql_reader["Day"]);
                string sHour = string.Format("{0:00}", int.Parse(ecodomus_client.sql_reader["Hour"].ToString()) - 1);
                string sMinute = string.Format("{0:00}", ecodomus_client.sql_reader["Minute"]);
                string sYear = DateTime.Now.Year.ToString();

                DateTime dt = DateTime.Parse(sMonth + "/" + sDay + "/" + sYear + " " + sHour + ":" + sMinute + ":00");

                if ((dt >= start_date) && (dt <= end_date))
                {
                    dValues[yValue1.Length - 1] = dVal;
                    yValue1[yValue1.Length - 1] = (dVal - dTolerance);
                    yValue2[yValue1.Length - 1] = (dVal + dTolerance);
                    dtValues[yValue1.Length - 1] = dt.ToString();

                    int iNewLen = yValue1.Length + 1;
                    Array.Resize(ref dValues, iNewLen);
                    Array.Resize(ref yValue1, iNewLen);
                    Array.Resize(ref yValue2, iNewLen);
                    Array.Resize(ref dtValues, iNewLen);
                }
            }
            ecodomus_client.sql_reader.Close();

            int iFinalLen = yValue1.Length - 1;
            Array.Resize(ref dValues, iFinalLen);
            Array.Resize(ref yValue1, iFinalLen);
            Array.Resize(ref yValue2, iFinalLen);
            Array.Resize(ref dtValues, iFinalLen);

            web_page_chart.Series["EM_Data"].Points.DataBindXY(dtValues, dValues);
            web_page_chart.Series["ToleranceBand"].Points.DataBindY(yValue1, yValue2);

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
            strSQLQuery += "WHERE [tag_name] = '" + sAsset_Attribute_Value + "' ";
            strSQLQuery += "AND [time_stamp] >= '" + start_date + "' AND [time_stamp] <= '" + end_date + "' ORDER BY [time_stamp] asc";

            ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
            ecodomus_client.sql_command.CommandText = strSQLQuery;
            ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

            while (ecodomus_client.sql_reader.Read())
            {
                double dVal = double.Parse(ecodomus_client.sql_reader["current_value"].ToString());
                //double dValC = ConvertTemp.ConvertFahrenheitToCelsius((float)dVal);

                //if (dValC > dMax)
                //    dMax = dValC;
                //if (dValC < dMin)
                //    dMin = dValC;

                DateTime dt = DateTime.Parse(ecodomus_client.sql_reader["time_stamp"].ToString());
                //chart1.Series["Data_Items"].Points.AddXY(dt, dValC);
                //web_page_chart.Series["Data_Items"].Points.AddY(dValC);

            }

            ecodomus_client.sql_reader.Close();

            return bSuccess;
        }

        // save a performance record
        public bool SavePerformanceResult(string pk_result_id,
                        string s_facility_id,
                        string s_project_id,
                        string s_simulation_id,
                        string sIDD_Class,
                        string sIDD_Class_Field,
                        string s_zone_id,
                        string s_zone_name,
                        string sOmni_Class,
                        string sAsset_Attribute_Name,
                        string sAsset_Attribute_Value,
                        string s_asset_attribute_id,
                        double dPerformanceValue,
                        double dTolerance,
                        DateTime start_date,
                        DateTime end_date)
        {
            bool bSuccess = false;
            string strSQLQuery = "";

            strSQLQuery = "INSERT INTO [tbl_energymodel_simulation_analysis_results]";
            strSQLQuery += "([pk_result_id]";
            strSQLQuery += ",[fk_facility_id]";
            strSQLQuery += ",[fk_project_id]";
            strSQLQuery += ",[fk_simulation_id]";
            strSQLQuery += ",[IDD_Class]";
            strSQLQuery += ",[IDD_Class_Field]";
            strSQLQuery += ",[fk_zone_id]";
            strSQLQuery += ",[zone_name]";
            strSQLQuery += ",[Omni_Class]";
            strSQLQuery += ",[Asset_Attribute_Name]";
            strSQLQuery += ",[Asset_Attribute_Value]";
            strSQLQuery += ",[fk_asset_attribute_id]";
            strSQLQuery += ",[PerformanceValue]";
            strSQLQuery += ",[Tolerance]";
            strSQLQuery += ",[start_date]";
            strSQLQuery += ",[end_date])";
            strSQLQuery += "VALUES";
            strSQLQuery += "('" + pk_result_id + "' ";
            strSQLQuery += ",'" + s_facility_id + "' ";
            strSQLQuery += ",'" + s_project_id + "' ";
            strSQLQuery += ",'" + s_simulation_id + "' ";
            strSQLQuery += ",'" + sIDD_Class + "' ";
            strSQLQuery += ",'" + sIDD_Class_Field + "' ";
            strSQLQuery += ",'" + s_zone_id + "' ";
            strSQLQuery += ",'" + s_zone_name + "' ";
            strSQLQuery += ",'" + sOmni_Class + "' ";
            strSQLQuery += ",'" + sAsset_Attribute_Name + "' ";
            strSQLQuery += ",'" + sAsset_Attribute_Value + "' ";
            strSQLQuery += ",'" + s_asset_attribute_id + "' ";
            strSQLQuery += "," + dPerformanceValue;
            strSQLQuery += "," + dTolerance;
            strSQLQuery += ",'" + start_date + "' ";
            strSQLQuery += ",'" + end_date + "')";

            // setup the insert command
            ecodomus_client.sql_write_command.CommandType = System.Data.CommandType.Text;
            ecodomus_client.sql_write_command.CommandText = strSQLQuery;
            ecodomus_client.sql_write_command.Connection = ecodomus_client.sql_connection;

            try
            {
                ecodomus_client.sql_write_command.ExecuteNonQuery();
                bSuccess = true;
            }
            catch (Exception ex)
            {
                bSuccess = false;
            }

            return bSuccess;
        }

        public int Load_Algorithms()
        {
            int RecordCount = 0;
            string strSQLQuery = "";

            algorithms.Clear();

            strSQLQuery = "SELECT [pk_algorithm_id] ";
            strSQLQuery += ",[fk_facility_id] ";
            strSQLQuery += ",[fk_project_id] ";
            strSQLQuery += ",[Message] ";
            strSQLQuery += ",[IDD_Class] ";
            strSQLQuery += ",[IDD_Class_Field] ";
            strSQLQuery += ",[Omni_Class] ";
            strSQLQuery += ",[Attribute_Name] ";
            strSQLQuery += ",[Comparision_Operator] ";
            strSQLQuery += ",[Tolerance_Operator] ";
            strSQLQuery += ",[Tolerance] ";
            strSQLQuery += ",[Impact_Operator] ";
            strSQLQuery += ",[Impact] ";
            strSQLQuery += "FROM [tbl_energymodel_simulation_algorithm] ";
            strSQLQuery += "WHERE [fk_facility_id] = '" + fk_facility_id + "'";

            ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
            ecodomus_client.sql_command.CommandText = strSQLQuery;
            ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

            while (ecodomus_client.sql_reader.Read())
            {
                Analysis_Alorithm algorithm_item = new Analysis_Alorithm();

                algorithm_item.pk_algorithm_id = ecodomus_client.sql_reader["pk_algorithm_id"].ToString();
                algorithm_item.fk_facility_id = ecodomus_client.sql_reader["fk_facility_id"].ToString();
                algorithm_item.fk_project_id = ecodomus_client.sql_reader["fk_project_id"].ToString();
                algorithm_item.Message = ecodomus_client.sql_reader["Message"].ToString();
                algorithm_item.IDD_Class = ecodomus_client.sql_reader["IDD_Class"].ToString();
                algorithm_item.IDD_Class_Field = ecodomus_client.sql_reader["IDD_Class_Field"].ToString();
                algorithm_item.Omni_Class = ecodomus_client.sql_reader["Omni_Class"].ToString();
                algorithm_item.Attribute_Name = ecodomus_client.sql_reader["Attribute_Name"].ToString();
                algorithm_item.Comparision_Operator = ecodomus_client.sql_reader["Comparision_Operator"].ToString();
                algorithm_item.Tolerance_Operator = ecodomus_client.sql_reader["Tolerance_Operator"].ToString();
                algorithm_item.Tolerance = float.Parse(ecodomus_client.sql_reader["Tolerance"].ToString());
                algorithm_item.Impact_Operator = ecodomus_client.sql_reader["Impact_Operator"].ToString();
                algorithm_item.Impact = float.Parse(ecodomus_client.sql_reader["Impact"].ToString());

                algorithms.Add(algorithm_item);
                RecordCount++;
            }

            ecodomus_client.sql_reader.Close();

            return RecordCount;
        }

        public long Load_Systems(string s_facility_id)
        {
            long SystemsLoaded = 0;


            return SystemsLoaded;
        }
                
        public long Load_Zones(string s_facility_id)
        {
            string strSQLQuery = "";
            long ZonesLoaded = 0;
            Analysis_Zone_Item aNewZone;

            zones.Clear();

            strSQLQuery = "SELECT * FROM tbl_location tl ";
            strSQLQuery += "WHERE fk_entity_id=(SELECT vge.pk_entity_id ";
            strSQLQuery += "FROM vw_get_entity vge WHERE vge.entity_name='zone') ";
            strSQLQuery += "AND tl.fk_facility_id='" + s_facility_id + "'";

            ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
            ecodomus_client.sql_command.CommandText = strSQLQuery;
            ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

            while (ecodomus_client.sql_reader.Read())
            {
                aNewZone = new Analysis_Zone_Item();
                aNewZone.zone_name = ecodomus_client.sql_reader["name"].ToString();
                aNewZone.pk_zone_id = ecodomus_client.sql_reader["pk_location_id"].ToString();
                zones.Add(aNewZone);
                ZonesLoaded++;
            }
            ecodomus_client.sql_reader.Close();

            return ZonesLoaded;
        }

        public long Load_Data_Items(Analysis_Attribute_Item attribute, DateTime dtStart, DateTime dtEnd)
        {
            string strSQLQuery = "";
            long RecordCount = 0;

            attribute.Data_Items.Clear();

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
            strSQLQuery += "WHERE [tag_name] = '" + attribute.tag_name + "' ";
            strSQLQuery += "AND [time_stamp] >= '" + dtStart + "' AND [time_stamp] <= '" + dtEnd + "' ORDER BY [time_stamp] asc";

            ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
            ecodomus_client.sql_command.CommandText = strSQLQuery;
            ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

            while (ecodomus_client.sql_reader.Read())
            {
                float dVal = float.Parse(ecodomus_client.sql_reader["current_value"].ToString());
                //float dValC = ConvertTemp.ConvertFahrenheitToCelsius(dVal);
                DateTime dt = DateTime.Parse(ecodomus_client.sql_reader["time_stamp"].ToString());

                Analysis_Data_Item Data_Items = new Analysis_Data_Item();
                Data_Items.X_Value = dt;
                Data_Items.Y_Value = dVal;
                //Data_Items.Y_Value_Converted = dValC;

                attribute.Data_Items.Add(Data_Items);

                RecordCount++;
            }

            ecodomus_client.sql_reader.Close();

            return RecordCount;
        }

        public long Load_Zone_Data(string s_facility_id, string s_project_id, Analysis_Zone_Item aZone, string sReportVariable, DateTime dtStart, DateTime dtEnd)
        {
            long RecordsLoaded = 0;
            string strSQLQuery;
            float fVal;
            string sMonth;
            string sDay;
            string sHour;
            string sMinute;
            DateTime dt;
            Analysis_Data_Item em_data;

            aZone.Data_Items.Clear();

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
            strSQLQuery += "AND [tbl_energymodeling_ReportVariableData].[fk_project_id] = '" + s_project_id + "' ";
            strSQLQuery += "AND [tbl_energymodeling_ReportVariableData].[fk_zone_id] = '" + aZone.pk_zone_id + "' ";

            strSQLQuery += "AND [MONTH] BETWEEN " + dtStart.Month + " AND " + dtEnd.Month + " ";
            strSQLQuery += "AND [DAY] BETWEEN " + dtStart.Day + " AND " + dtEnd.Day + " ";

            strSQLQuery += "AND [VariableName] = '" + sReportVariable + "' ";
            strSQLQuery += "order by [Month], [Day], [Hour], [Minute]";

            ecodomus_client.sql_command = ecodomus_client.sql_connection.CreateCommand();
            ecodomus_client.sql_command.CommandText = strSQLQuery;
            ecodomus_client.sql_reader = ecodomus_client.sql_command.ExecuteReader();

            while (ecodomus_client.sql_reader.Read())
            {
                fVal = float.Parse(ecodomus_client.sql_reader["VariableValue"].ToString());
                sMonth = string.Format("{0:00}", ecodomus_client.sql_reader["Month"]);
                sDay = string.Format("{0:00}", ecodomus_client.sql_reader["Day"]);
                sHour = string.Format("{0:00}", int.Parse(ecodomus_client.sql_reader["Hour"].ToString()) - 1);
                sMinute = string.Format("{0:00}", ecodomus_client.sql_reader["Minute"]);
                dt = DateTime.Parse(sMonth + "/" + sDay + "/2013 " + sHour + ":" + sMinute + ":00");

                if ((dt >= dtStart) && (dt <= dtEnd))
                {
                    em_data = new Analysis_Data_Item();
                    em_data.X_Value = dt;
                    em_data.Y_Value = fVal;
                    aZone.Data_Items.Add(em_data);
                    RecordsLoaded++;
                }

            }
            ecodomus_client.sql_reader.Close();

            return RecordsLoaded;
        }

    }
    
    // utility classes
    public class SQL_Data_Connection
    {
        public SqlConnection sql_connection = new SqlConnection();
        public SqlCommand sql_write_command = new SqlCommand();
        public SqlCommand sql_command = new SqlCommand();
        public SqlCommand sql_command2 = new SqlCommand();
        public SqlDataReader sql_reader;
        public SqlDataReader sql_reader2;
        public string ClientDBName;

        public bool bCancel;
        public bool bOpened;
        public bool bConnected = false;

        public SQL_Data_Connection()
        {
            // setup a default connection string
            ClientDBName = "GSAR3";
            sql_connection.ConnectionString = @"Data Source=" + @"DaveAdkisson-PC\SQLExpress" + ";";
            sql_connection.ConnectionString += "Initial Catalog=" + ClientDBName + ";";
            sql_connection.ConnectionString += "User Id=" + "sa" + ";";
            sql_connection.ConnectionString += "Password=" + "ecodomus@123" + ";";
            sql_connection.ConnectionString += "MultipleActiveResultSets=True;";

            bCancel = false;
            bOpened = false;

        }

        // open the client db
        public bool ConnectClientDatabase()
        {
            try
            {
                sql_connection.Open();
                if (sql_connection.State == System.Data.ConnectionState.Open)
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
                sql_connection.Close();
                bConnected = false;
            }
            catch (Exception ex)
            {
                bConnected = false;
            }
            return bConnected;
        }
    
    }

}

