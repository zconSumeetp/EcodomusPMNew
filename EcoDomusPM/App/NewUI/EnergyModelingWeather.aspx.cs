using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Web.Configuration;
using System.IO;
using EcoDomus.Session;
using EnergyPlus;
using System.Data;


public partial class App_NewUI_EnergyModelingWeather : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {
                if (SessionController.Users_.ProfileName != null)
                {
                    lbl_project_name.Text = SessionController.Users_.ProfileName.ToString();
                }
                LoadWeatherFileInListBox();

                //if (SessionController.Users_.Em_Weather_File_Name != null)
                //{
                //    if (lb_weather_files.Items.Count > 0)
                //    {
                //        txt_weather_file_name.Text = SessionController.Users_.Em_Weather_File_Name.ToString();
                //        RadListBoxItem item = lb_weather_files.FindItemByText(SessionController.Users_.Em_Weather_File_Name.ToString());
                //        item.Selected = true;
                //    }
                //}
                //else
                //{
                    GetLastWeatherFile();
                
                //}
                lbl_1.Text = "Note:NOAA Weather Stations are recorded at 15 minute" +
                              " intervals however not all weather stations update " +
                               "readings more than per hour";
                lbl_2.Text = "Compressed file (.zip) which contains the following files Energy " +
                              "Plus weather files(EPW)" + "A summary report on the data (STAT)" +
                               " An ASHRAE Design Conditions Design Day Data file (DDY)";
                lbl_3.Text = "Files are named using the ISO standards three-letter country" +
                              "abbreviation (i.e. CUB for Cuba),followed by the location name," +
                               "World Meteorological Organization designation (WMO) and the source format (CTZ2, " +
                               "CWEC, City UHK,CSWD,CTYW,ETMY,IGDG,IMGW,IMS,INETI,ISHRAE,ITMY," +
                               "IWEC,KISR,NWA,RMY,SWEC,SEAR, or TMY3)";
                
               
               
            }
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);

    }

    protected void lb_weather_files_SelectedIndexChanged(object sender, EventArgs e)
    {
        //try
        //{
        txt_weather_file_name.Text = lb_weather_files.SelectedItem.Text;
        SessionController.Users_.Em_Weather_File_Name = lb_weather_files.SelectedItem.Text;

        //}
        //catch (Exception ex)
        //{

        //    throw ex;
        //}
    }

    protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }

    private void GetLastWeatherFile()
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
                    obj_energy_plus_model.pk_profileid = new Guid(SessionController.Users_.Profileid);
                }
                ds = obj_energy_plus_client.GetLastWeatherDataFile(obj_energy_plus_model, SessionController.ConnectionString);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (ds.Tables[0].Rows[0]["weather_file_name"].ToString()!= "")
                        {
                            if (lb_weather_files.Items.Count > 0)
                            {
                                txt_weather_file_name.Text = ds.Tables[0].Rows[0]["weather_file_name"].ToString();
                                SessionController.Users_.Em_Weather_File_Name = ds.Tables[0].Rows[0]["weather_file_name"].ToString();
                                RadListBoxItem item = lb_weather_files.FindItemByText(ds.Tables[0].Rows[0]["weather_file_name"].ToString());
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
        }
        catch (Exception es)
        {
            throw es;
        }
    
    }
    private void LoadWeatherFileInListBox()
    {
        try
        {
            lb_weather_files.Items.Clear();
            string path = WebConfigurationManager.AppSettings["EnergyPlusWeatherFilePath"];
          //  path = Server.MapPath(path);
            string[] files=Directory.GetFiles(path, "*.epw", SearchOption.AllDirectories);
         
       
            foreach (string file in files)
            {
                string name = Path.GetFileName(file);
                RadListBoxItem lb_item = new RadListBoxItem(name,name);
                lb_weather_files.Items.Add(lb_item);
            }

        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void btn_show_Click(object sender, EventArgs e)
    {
        try
        {
            string file_path = "";
            string file_name = "";
            string save_path = "";
            foreach (UploadedFile file in ru_file.UploadedFiles)
            {
                file_path = file.FileName;
                file_name = file.GetName();
                string path = WebConfigurationManager.AppSettings["EnergyPlusWeatherFilePath"];
                path = Server.MapPath(path);
                DirectoryInfo dir_info = new DirectoryInfo(path);
                if (!dir_info.Exists)
                {
                    dir_info.Create();
                    save_path = Path.Combine(path, file_name);
                }
                else
                {
                    save_path = Path.Combine(path, file_name);
                }
                file.SaveAs(save_path,true);
            }
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }


    protected void rbtn_upload_file_Click(object sender, EventArgs e)
    {
        string file_path = "";
        string file_name = "";
        string save_path = "";
        foreach (UploadedFile file in ru_file.UploadedFiles)
        {
            file_path = file.FileName;
            file_name = file.GetName();
            string path = WebConfigurationManager.AppSettings["EnergyPlusWeatherFilePath"];
            //path = Server.MapPath(path);
            DirectoryInfo dir_info = new DirectoryInfo(path);
            if (!dir_info.Exists)
            {
                dir_info.Create();
                save_path = Path.Combine(path, file_name);
            }
            else
            {
                save_path = Path.Combine(path, file_name);
            }
            file.SaveAs(save_path, true);
        }

        LoadWeatherFileInListBox();
    }

    protected void lb_weather_files_SelectedIndexChanged1(object sender, EventArgs e)
    {
        try
        {
            if (lb_weather_files.Items.Count > 0)
            {
                txt_weather_file_name.Text = lb_weather_files.SelectedItem.Text;
                SessionController.Users_.Em_Weather_File_Name = lb_weather_files.SelectedItem.Text;
            }
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
       
    }
}