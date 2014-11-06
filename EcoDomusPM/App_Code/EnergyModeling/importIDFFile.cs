using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using EnergyPlus;
using System.Text;

/// <summary>
/// Summary description for importIDFFile
/// </summary>

namespace EcoDomus.Energymodeling
{
    public class importIDFFile
    {
        public importIDFFile()
        {
            //
            // TODO: Add constructor logic here
            //
        }



        public void ImportIdfFileforEM(string file_name)
        {

            try
            {

                DataSet ds = new DataSet();
                EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
                EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
                ds = obj_energy_plus_client.Get_energy_modeling_all_objects_fields(obj_energy_plus_model,Session.SessionController.ConnectionString);
                string OneLine = null;
                bool LineEnds = false;
                StringBuilder sb_Objectlist = new StringBuilder();
                string[] lines = System.IO.File.ReadAllLines(file_name);
                long import_order_objects = 0;

                string IDF_Version = "0.0";
                int objectcounter = 0;
                foreach (string line in lines)
                {
                    string tmp = null;
                    tmp = line;
                    tmp = tmp.Replace(Environment.NewLine, "");
                    tmp = tmp.Trim();

                    if (tmp.Length == 0) continue;
                    if (tmp.StartsWith("!") == true) continue;


                    if (tmp.IndexOf("!") > 0)
                        tmp = tmp.Substring(0, tmp.IndexOf("!"));

                    tmp = tmp.Trim();

                    if (OneLine == null)
                        OneLine = tmp;
                    else
                        OneLine = OneLine + tmp;

                    if (tmp.EndsWith(";") == true)
                    {
                        LineEnds = true;
                    }
                    else
                    {
                        continue;
                    }

                    string[] Splitters = { ",", ";" };
                    string[] Values = OneLine.Split(Splitters, StringSplitOptions.None);
                    Guid object_id = Guid.NewGuid();

                    for (int i = 0; i < Values.Length; i++)
                        Values[i] = Values[i].Trim();

                    if (Values[0] != null && Values[0] != "")
                    {
                        if (Values[0].ToLower() == "version")
                            IDF_Version = Values[1].Trim();

                        if (objectcounter == 200)
                        {
                            objectcounter = 0;
                            insertObjectData(sb_Objectlist.ToString());
                            sb_Objectlist.Clear();
                        }

                        objectcounter++;

                        import_order_objects++;
                        DataRow[] ZoneRows = ds.Tables[0].Select("object_name ='" + Values[0] + "'");
                        if (ZoneRows.Count() > 0)
                        {
                            sb_Objectlist.AppendLine("<Object name=\"" + Values[0] + "\" parent_id=\"" + object_id.ToString().Trim() + "\" object_id=\"" + ZoneRows[0]["pk_object_id"].ToString().Trim() + "\" obj_seq=\"" + import_order_objects.ToString().Trim() + "\"  version_id=\"" + IDF_Version + " \">");


                            for (int i = 0; i < ZoneRows.Count(); i++)
                            {
                                if ((i + 3) > Values.Count())
                                {
                                    //sb_Objectlist.AppendLine(" <Attribute  name=\"" + ZoneRows[i]["field_name"].ToString().Trim() + "\" value=\"" + str_blank + "\" field_id=\"" + ZoneRows[i]["pk_field_id"].ToString().Trim() + "\" field_seq=\"" + (i + 1) + "\"/>");
                                }

                                else
                                {
                                    sb_Objectlist.AppendLine(" <Attribute  name=\"" + ZoneRows[i]["field_name"].ToString().Trim() + "\" value=\"" + Values[i + 1].Trim() + "\" field_id=\"" + ZoneRows[i]["pk_field_id"].ToString().Trim() + "\" field_seq=\"" + (i + 1) + "\"/>");
                                }
                            }
                            sb_Objectlist.AppendLine("</Object>");
                        }

                    }

                    if (LineEnds == true)
                    {
                        OneLine = null;
                        LineEnds = false;
                    }


                }

                if (objectcounter > 0)
                {
                    insertObjectData(sb_Objectlist.ToString());
                }

                if (sb_Objectlist != null || sb_Objectlist.ToString() != "")
                {

                    sb_Objectlist.Clear();

                }


            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            { 
            
            }

        
        
    }

        public void insertObjectData(string object_xml)
        {

           
            try
            {
                DataSet ds = new DataSet();

                EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
                EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
                obj_energy_plus_model.Fk_facility_id = new Guid(Session.SessionController.Users_.Em_facility_id);
                obj_energy_plus_model.Pk_project_id = Guid.Empty;
                obj_energy_plus_model.Str_xml = object_xml;
                obj_energy_plus_client.Insert_New_Energy_Modeling_Object(obj_energy_plus_model, Session.SessionController.ConnectionString);
               

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

               
            }

        }
    

    }
}