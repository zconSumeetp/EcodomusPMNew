using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.IO;
using System.Text;
using System.Web.Configuration;
using EnergyPlus;
using System.Data;

public partial class App_UserControls_EnergyPlusData : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (hf_is_loaded.Value.Equals("No"))
            {
                BindEnergyModelingFileList();
                hf_is_loaded.Value = "Yes";
            }
        }
    }

    private void BindEnergyModelingFileList()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            lst_file_info.Items.Clear();
            HiddenField hf_facility_id = (HiddenField)Page.FindControl("hf_facility_id");
            if (hf_facility_id != null)
            {
                obj_energy_plus_model.Fk_facility_id = new Guid(hf_facility_id.Value);
                ds = obj_energy_plus_client.Get_Energy_Modeling_File_List_For_Facility(obj_energy_plus_model, SessionController.ConnectionString);
                //cmb_file_list.DataValueField = "pk_file_id";
                //cmb_file_list.DataTextField = "idf_file_name";
                //cmb_file_list.DataSource = ds;
                //cmb_file_list.DataBind();
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    ListItem li = new ListItem(ds.Tables[0].Rows[i]["idf_file_name"].ToString(), ds.Tables[0].Rows[i]["pk_file_id"].ToString());
                    lst_file_info.Items.Add(li);
                }
            }
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void lbtn_next_Click(object sender, EventArgs e)
    {
        try
        {
            HiddenField hf_file_name = (HiddenField)Page.FindControl("hf_file_name");
            if (hf_file_name != null)
            {
                if (hf_file_name.Value.Equals(""))
                {
                    if (lst_file_info.Items.Count>0)
                    {
                        if (lst_file_info.SelectedIndex!=-1)
                        {
                            SessionController.Users_.FileID = lst_file_info.SelectedItem.Value;
                            hf_file_name.Value = lst_file_info.SelectedItem.Text;
                        }
                    }
                }
            }
            
            if (chk_none.Checked)
            {
                GoToLastTab();
            }
            else
            {
                GoToNextTab();
                
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    private void GoToLastTab()
    {
        try
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ibtn_next_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            HiddenField hf_file_name = (HiddenField)Page.FindControl("hf_file_name");
            if (hf_file_name != null)
            {
                if (hf_file_name.Value.Equals(""))
                {
                    if (lst_file_info.Items.Count > 0)
                    {
                        if (lst_file_info.SelectedIndex != -1)
                        {
                            SessionController.Users_.FileID = lst_file_info.SelectedItem.Value;
                            hf_file_name.Value = lst_file_info.SelectedItem.Text;
                        }
                    }
                }
            }

            if (chk_none.Checked)
            {
                GoToLastTab();
            }
            else
            {
                GoToNextTab();

            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    private void GoToNextTab()
    {
        try
        {
            RadTabStrip tabStrip = (RadTabStrip)Page.FindControl("rts_energy_plus");
            RadTab import_data = tabStrip.FindTabByValue("EnergyPlusImportData");
            import_data.Enabled = true;
            import_data.Selected = true;
            GoToNextPageView();
        }
        catch (Exception ex)
        { 
            throw ex;
        }
    }

    private void GoToNextPageView()
    {
        try
        {
            RadMultiPage rmp_energy_plus = (RadMultiPage)Page.FindControl("rmp_energy_plus");
            RadPageView rpv_import_data = rmp_energy_plus.FindPageViewByID(@"~/App/UserControls/UserControlNewUI/" + "EnergyPlusImportData");
            if (rpv_import_data == null)
            {
                rpv_import_data = new RadPageView();
                rpv_import_data.ID = @"~/App/UserControls/UserControlNewUI/" + "EnergyPlusImportData";
                rmp_energy_plus.PageViews.Add(rpv_import_data);
            }
            rpv_import_data.Selected = true;
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void lbtn_back_Click(object sender, EventArgs e)
    {
        try
        {
            GoToPreviousTab();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void ibtn_back_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            GoToPreviousTab();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void GoToPreviousTab()
    {
        try
        {
            RadTabStrip tabStrip = (RadTabStrip)Page.FindControl("rts_energy_plus");
            RadTab select_template = tabStrip.FindTabByValue("EnergyPlusTemplate");
            select_template.Enabled = true;
            select_template.Selected = true;
            GoToPreviousPageView();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void GoToPreviousPageView()
    {
        try
        {
            RadMultiPage rmp_energy_plus = (RadMultiPage)Page.FindControl("rmp_energy_plus");
            RadPageView rpv_template = rmp_energy_plus.FindPageViewByID(@"~/App/UserControls/UserControlNewUI/" + "EnergyPlusTemplate");
            if (rpv_template == null)
            {
                rpv_template = new RadPageView();
                rpv_template.ID = @"~/App/UserControls/UserControlNewUI/" + "EnergyPlusTemplate";
                rmp_energy_plus.PageViews.Add(rpv_template);
            }
            rpv_template.Selected = true;
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
            lbtn_next.Enabled = false;
            ibtn_next.Enabled = false;
             string file_path="";
             string file_name = "";
             string save_path = "";
             foreach (UploadedFile file in ru_file.UploadedFiles)
            {
                file_path = file.FileName;
                file_name = file.GetName();
                string path = WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id;
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
                file.SaveAs(save_path, true);
                 // Add file inforamtion to database

                EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
                SimulationFileModel obj_simulation_file_model = new SimulationFileModel();
             
                      HiddenField hf_facility_id=(HiddenField)Page.FindControl("hf_facility_id");
                   if(hf_facility_id != null)
                 {
                     obj_simulation_file_model.PK_FACILITY_ID = new Guid(hf_facility_id.Value.ToString());
                     obj_simulation_file_model.SIMULATIONFILENAME = file_name;
                     DataSet ds = new DataSet();
                     ds=obj_energy_plus_client.Add_Simulation_File_Name(obj_simulation_file_model, SessionController.ConnectionString);
                    // PK_FILE_ID = Guid.Parse(ds.Tables[0].Rows[0]["pk_file_id"].ToString());
                    // if (PK_FILE_ID.Equals(Guid.Empty)) return;
                     if (ds.Tables.Count > 0)
                     {
                         if (ds.Tables[0].Rows.Count > 0)
                         {
                             SessionController.Users_.FileID = ds.Tables[0].Rows[0]["pk_file_id"].ToString();
                         }
                         else
                         {
                             SessionController.Users_.FileID = Guid.Empty.ToString();
                         }
                     }
                     
                 }
              //  DisplayFileInformation(file_path);
                BindEnergyModelingFileList();
            }
            HiddenField hf_file_name = (HiddenField)Page.FindControl("hf_file_name");
            if (hf_file_name != null)
            {
                hf_file_name.Value = file_name;
            }
            HiddenField hf_file_full_path = (HiddenField)Page.FindControl("hf_file_full_path");
            if (hf_file_full_path != null)
            {
                hf_file_full_path.Value = file_path;
            }

            lbtn_next.Enabled = true;
            ibtn_next.Enabled = true;
         
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void DisplayFileInformation(string file_path)
    {
        try
        {
            lst_file_info.Items.Clear();
            if (File.Exists(file_path))
            {
                FileInfo file_info = new FileInfo(file_path);
                string size = string.Format("{0:0.000}", (file_info.Length / 1024.0));
                string created_date = file_info.CreationTime.ToString("F");
                string modfied_date = file_info.LastWriteTime.ToString("F");
                string last_accessed = file_info.LastAccessTime.ToString("F");

                lst_file_info.Items.Add("Size:            " + size + "MB (" + string.Format("{0:000}", file_info.Length) + "bytes)");
                lst_file_info.Items.Add("Size on disk:    " + size + "MB (" + file_info.Length + "bytes)");
                lst_file_info.Items.Add("Created:         " + created_date);
                lst_file_info.Items.Add("Modified:        " + modfied_date);
                lst_file_info.Items.Add("Accessed:         " + last_accessed);
            }
            else
            { 
            
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
   
    protected void Label1_Click(object sender, EventArgs e)
    {
        try
        {
            if (chk_none.Checked)
            {
                GoToLastTab();
            }
            else
            {
                GoToNextTab();

            }

        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void cmb_file_list_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            lbtn_next.Enabled = true;
            ibtn_next.Enabled = true;

        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
    protected void rbtn_upload_Click(object sender, EventArgs e)
    {
        try
        {
            lbtn_next.Enabled = false;
            ibtn_next.Enabled = false;
            string file_path = "";
            string file_name = "";
            string save_path = "";
            foreach (UploadedFile file in ru_file.UploadedFiles)
            {
                file_path = file.FileName;
                file_name = file.GetName();
                string path = WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + SessionController.Users_.Em_facility_id;
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
                file.SaveAs(save_path, true);
                DisplayFileInformation(save_path);
                BindEnergyModelingFileList();

            }
            HiddenField hf_file_name = (HiddenField)Page.FindControl("hf_file_name");
            if (hf_file_name != null)
            {
                hf_file_name.Value = file_name;
            }
            lbtn_next.Enabled = true;
            ibtn_next.Enabled = true;

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
}