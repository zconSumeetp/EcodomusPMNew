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

public partial class testIDFPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string filename1 = "4ZoneWithShading_Simple_1.idf";
            string file_path = @"C:\inetpub\wwwroot\EcoDomus_PM_New\EcoDomus_PM_FM\App\Files\SimulationFiles\15722684-6156-4971-a19e-0622b1a0303b";
            string full_path = Path.Combine(@"C:\inetpub\wwwroot\EcoDomus_PM_New\EcoDomus_PM_FM\App\Files\SimulationFiles\15722684-6156-4971-a19e-0622b1a0303b", "4ZoneWithShading_Simple_1.idf");
                string file_extension = Path.GetExtension(full_path);
                full_path = full_path.Replace(file_extension, "");
                string full_weather_path = Path.Combine("", "");
                //full_weather_path = "";
                string weather_file_extension = Path.GetExtension(full_weather_path);
                // full_path = full_path.Replace(file_extension, "");
                Process p = new Process();
                p.StartInfo.CreateNoWindow = true;
          
                p.StartInfo.UseShellExecute = false;
                p.StartInfo.FileName = @"C:\EnergyPlusV7-2-0\RunEPlus.bat";
                p.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
                p.StartInfo.WorkingDirectory = @"C:\EnergyPlusV7-2-0\";
                string[] args = { full_path, file_path, Convert.ToString(ConfigurationManager.AppSettings["EPBatchFilePath"]) + "PostProcess\\ReadVarsESO.bat", @"C:\EnergyPlusV7-2-0\WeatherData\USA_CA_San.Francisco.Intl.AP.724940_TMY3.epw" };

               // string[] args = { "\"" + full_path + "\""};
                p.StartInfo.Arguments ="\"" + full_path + "\"";

                p.Start();
        }
        catch (Exception ex)
        {
            
           
            Response.Write(ex.Message.ToString());
            throw;
        }

    }
}