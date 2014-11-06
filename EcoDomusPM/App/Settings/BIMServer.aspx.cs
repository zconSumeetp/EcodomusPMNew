using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.IO;
using Telerik.Web.UI;
using System.Data;
using System.Threading;
using System.Globalization;
using System.Text.RegularExpressions;
using Locations;
using Asset;
using System.Web.Configuration;
using Facility;
using System.Configuration;
using System.Web.Services;
using System.Xml;

public partial class App_Settings_BIMServer : System.Web.UI.Page
{
    Guid FileID;
    string filepath = string.Empty;
    public string navis_class_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {

                if (!IsPostBack)
                {
                    if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                    {

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                    }
                    else
                    {

                        ruImportLocation.Localization.Select = (string)GetGlobalResourceObject("Resource", "Select");
                        if (SessionController.Users_.is_PM_FM == "PM")
                        {
                            bindBimfileforfacilty();
                            //GetUploadedFilesPM();
                            //bindmasterfiles();
                        }
                        else
                        {
                            GetUploadedFiles();
                       
                            Session["name"] = null;
                        }
                        BindFacility();
                    }



                }
                else
                {
                    if (navis_view.InnerHtml.Trim() != "")
                        navis_view.InnerHtml = "";
                    BindFacility();
                }

                /* Added By: Priyanka S
                 * Purpose: Show default selected facility id only one facility is assigned to project
                */
                FacilityModel fm = new FacilityModel();
                FacilityClient fc = new FacilityClient();
                DataSet dsFacility = new DataSet();
                fm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                fm.Search_text_name = "";
                fm.Doc_flag = "floor";
                dsFacility = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);

                if (dsFacility.Tables.Count > 0)
                {
                    if (dsFacility.Tables[0].Rows.Count == 1)
                    {
                        hfselectedId.Value = dsFacility.Tables[0].Rows[0]["pk_facility_id"].ToString();
                        hfselectedname.Value = dsFacility.Tables[0].Rows[0]["name"].ToString();
                        lblselectedfacility.Text = dsFacility.Tables[0].Rows[0]["name"].ToString();
                        lnk_assgnFacility.Enabled = false;
                        if (!IsPostBack)               
                          bindmasterfiles();
                    }
                    else
                        lnk_assgnFacility.Enabled = true;
                }
                else
                    lnk_assgnFacility.Enabled = true;
            }
            else
            {
                Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            }
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);

            //BindFacility();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void page_prerender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "GU")
        {
           // btn_download.Visible = false;
          //  btnreplace.Visible = false;
            btnSubmit.Visible = false;
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                foreach (GridItem item in rguploadedfiles.MasterTableView.Items)
                {
                    ImageButton btn = item.FindControl("imgbtnremove") as ImageButton;
                    if (btn != null)
                    {
                        btn.Visible = false;
                    }
                   
                }
            }
        }

        if (SessionController.Users_.IsFacility == "yes")
        {
            lnk_assgnFacility.Visible = false;
            hfselectedId.Value = "";
            hfselectedname.Value = "";
          
        }
        else
        {
            lnk_assgnFacility.Visible = true;

        }

        if (SessionController.Users_.Permission_ds != null)
        {
            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
            {
                {
                    SetPermissions(); 
                }
            }
        }
        if (!Page.IsPostBack)
        {


           // rguploadedfiles.MasterTableView.HierarchyDefaultExpanded = true;
            
            //rguploadedfiles.MasterTableView.DetailTables[0].HierarchyDefaultExpanded = true;
           
            //rguploadedfiles.Rebind(); 
        } 
    }
    private void BindFacility()
    {
        try
        {
            DataSet ds_facility = new DataSet();
            LocationsClient locObj_crtl = new LocationsClient();
            LocationsModel locObj_mdl = new LocationsModel();
            locObj_mdl.User_id = new Guid(SessionController.Users_.UserId);
            ds_facility = locObj_crtl.Get_Facility(SessionController.ConnectionString, locObj_mdl);
           // cmbfacility.DataTextField = "name";
           // cmbfacility.DataValueField = "ID";
           // cmbfacility.DataSource = ds_facility;
           // cmbfacility.DataBind();

            if (SessionController.Users_.IsFacility == "yes")
            {
               // cmbfacility.Visible = true;
               
              //  cmbfacility.SelectedValue = SessionController.Users_.facilityID;
              //  cmbfacility.Enabled = false;
            }
            else
            {
              //  cmbfacility.Visible = true;
               //  cmbfacility.Enabled = true;
            }

        }
        catch (Exception ex)
        {
        }
    }

    public void GetUploadedFilesPM()
    {
        try
        {
            DataSet ds = new DataSet();
            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            BIMModel.BIMModels mdl = new BIMModel.BIMModels();
            string p = SessionController.Users_.ProjectId.ToString();

            mdl.Project_id =new Guid(SessionController.Users_.ProjectId.ToString());
           // mdl.Fk_facility_id =new Guid( lblselectedfacility.Text.ToString());
       
            ds = BIMModelClient.GetUploadedFilesModelServerPM(mdl, SessionController.ConnectionString);
            rguploadedfiles.DataSource = ds;
            rguploadedfiles.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void bindmasterfiles()
    {

        try
        {

            DataSet ds = new DataSet();
            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            BIMModel.BIMModels mdl = new BIMModel.BIMModels();

            mdl.Fk_facility_id = new Guid(hfselectedId.Value);

            ds = BIMModelClient.proc_get_master_model_files(mdl, SessionController.ConnectionString);
            cmbmasterfiles.DataSource = ds;
            cmbmasterfiles.DataBind();
        }


        catch (Exception ex)
        {

            throw ex;
        }
    }
    private void GetUploadedFiles()
    {
        try
        {
            DataSet ds = new DataSet();
            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            BIMModel.BIMModels mdl = new BIMModel.BIMModels();

            //mdl.Fk_facility_id = new Guid(SessionController.Users_.facilityID);
            mdl.Fk_facility_id = new Guid(hfselectedId.Value.ToString());

            ds = BIMModelClient.getuploadedfiles(mdl, SessionController.ConnectionString);

            rguploadedfiles.DataSource = ds;
            rguploadedfiles.DataBind();
            

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
       
         //  ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>sethdnfield();</script>");
        if (hfselectedId.Value == "" && hfselectedId.Value == "")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>sethdnfield();</script>");
        }

        else
        {

            if (cmbmasterfiles.SelectedItem.Value == "" || cmbmasterfiles.SelectedItem.Value.Equals("00000000-0000-0000-0000-000000000000"))
            {
                if (Request.Form["rdselect"] != null)
                {
                    if (hfselectedId.Value != Guid.Empty.ToString() && hfselectedId.Value != "")
                    {
                        hfselected_fileid.Value = Request.Form["rdselect"].Split(',')[0];
                        insertintoHistroy(new Guid(hfselected_fileid.Value.ToString()), new Guid(SessionController.Users_.UserId));
                        UploadFile(new Guid(hfselected_fileid.Value.ToString()));
                        GetUploadedFilesPM();
                        bindmasterfiles();
                        hfselectedId.Value = "";
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script4", "<script language='javascript'>result_msg('Please select file to replace.')</script>");
                    }
                }
                else
                {
                    UploadFile(Guid.Empty);
                    GetUploadedFilesPM();
                    //  bindBimfileforfacilty();

                    hfselectedId.Value = "";
                }
            }
            else
            {

                try
                {
                    //Following if and else conditions are added by Priyanka J on 03rd May,2012
                    if (Request.Form["rdselect"] != null)
                    {
                        if (hfselectedId.Value != Guid.Empty.ToString() && hfselectedId.Value != "")
                        {
                            hfselected_fileid.Value = Request.Form["rdselect"].Split(',')[0];
                            insertintoHistroy(new Guid(hfselected_fileid.Value.ToString()), new Guid(SessionController.Users_.UserId));
                            UploadFile(new Guid(hfselected_fileid.Value.ToString()));
                            GetUploadedFilesPM();
                            //  bindBimfileforfacilty();
                            bindmasterfiles();
                            hfselectedId.Value = "";
                        }
                        else
                        {

                            Page.ClientScript.RegisterStartupScript(this.GetType(), "script4", "<script language='javascript'>result_msg('Please select facility.')</script>");
                        }
                    }

                    else
                    {

                        UploadChildFile(new Guid(cmbmasterfiles.SelectedItem.Value.ToString()));
                        // Page.ClientScript.RegisterStartupScript(this.GetType(), "script4", "<script language='javascript'>result_msg('Please select file to replace.')</script>");
                    }
                }
                catch (Exception ex)
                {

                    throw ex;
                }

            }
        }
      


    }

    protected override void InitializeCulture()
    {
        try
        {
            string culture = Session["Culture"].ToString();
            if (culture == null)
            {
                culture = "en-US";
            }
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
        }
        catch (Exception ex)
        {

            redirect_page("~\\app\\Loginpm.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
      
   

    private void UploadFile(Guid selected_fileid)
    {
        
        try
        {

            string strfacilityID;
            if (!string.IsNullOrEmpty(hfselectedId.Value.ToString()))
            {
                strfacilityID = hfselectedId.Value.ToString();
            }
            else
            {
                strfacilityID = Request.Form["rdselect"].Split(',')[1];
            }

            string commonvirtualpath = ConfigurationManager.AppSettings["CommonFilePath"] + "NWD Files/" + strfacilityID;
            string commonphysicalpath = Server.MapPath(commonvirtualpath);


            DirectoryInfo de5 = new DirectoryInfo(commonphysicalpath);

            if (!de5.Exists)
            {
                de5.Create();
            }
            foreach (UploadedFile f in ruImportLocation.UploadedFiles)
            {
                string filename = string.Empty;
                filename = f.GetName();
                filename = filename.Replace("&", "_");
                filename = filename.Replace("#", "_");
                filename = filename.Replace("%", "_");
                filename = filename.Replace("*", "_");
                filename = filename.Replace("{", "_");
                filename = filename.Replace("}", "_");
                filename = filename.Replace("\\", "_");
                filename = filename.Replace(":", "_");
                filename = filename.Replace("<", "_");
                filename = filename.Replace(">", "_");
                filename = filename.Replace("?", "_");
                filename = filename.Replace("/", "_");
                hfifcxmlpath.Value = f.GetName();



                if (filename.Substring(filename.Length - 3, 3).ToString().ToLower() == "nwd" || filename.Substring(filename.Length - 3, 3).ToString().ToLower() == "hsf" || filename.Substring(filename.Length - 3, 3).ToString().ToLower() == "dwf")
                {

                    filepath = Path.Combine((commonphysicalpath), filename);
                    f.SaveAs(filepath, true);
                    SaveNWDFileName(filename, commonphysicalpath, f.ContentLength, selected_fileid, commonvirtualpath);


                }
            }
        }

        catch (Exception ex)
        {
            throw ex;

        }
    }



    //ForUploading Child File
    private void UploadChildFile(Guid selected_fileid)
    {

        try
        {

            string strfacilityID;
            if (!string.IsNullOrEmpty(hf_facilityid.Value.ToString()))
            {
                strfacilityID = hf_facilityid.Value.ToString();
            }
            else
            {
                strfacilityID = hfselectedId.Value.ToString();
            }

            string commonvirtualpath = ConfigurationManager.AppSettings["CommonFilePath"] + "NWD Files/" + strfacilityID;
            string commonphysicalpath = Server.MapPath(commonvirtualpath);


            DirectoryInfo de5 = new DirectoryInfo(commonphysicalpath);

            if (!de5.Exists)
            {
                de5.Create();
            }
            foreach (UploadedFile f in ruImportLocation.UploadedFiles)
            {
                string filename = string.Empty;
                filename = f.GetName();
                filename = filename.Replace("&", "_");
                filename = filename.Replace("#", "_");
                filename = filename.Replace("%", "_");
                filename = filename.Replace("*", "_");
                filename = filename.Replace("{", "_");
                filename = filename.Replace("}", "_");
                filename = filename.Replace("\\", "_");
                filename = filename.Replace(":", "_");
                filename = filename.Replace("<", "_");
                filename = filename.Replace(">", "_");
                filename = filename.Replace("?", "_");
                filename = filename.Replace("/", "_");
                hfifcxmlpath.Value = f.GetName();



                if (filename.Substring(filename.Length - 3, 3).ToString().ToLower() == "nwd" || filename.Substring(filename.Length - 3, 3).ToString().ToLower() == "hsf" || filename.Substring(filename.Length - 3, 3).ToString().ToLower() == "dwf")
                {

                    filepath = Path.Combine((commonphysicalpath), filename);
                    f.SaveAs(filepath, true);
                    SaveNWDFileName(filename, commonphysicalpath, f.ContentLength, selected_fileid, commonvirtualpath);


                }
            }
        }

        catch (Exception ex)
        {
            throw ex;

        }
    }
    
    public void SaveNWDFileName(string filename, string filepath, int filesize, Guid selected_fileid,string virtualpath)
    {
        try
        {
            Guid uploadfileid=selected_fileid;
            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            BIMModel.BIMModels mdl = new BIMModel.BIMModels();
            if (cmbmasterfiles.SelectedValue.ToString() == "" || cmbmasterfiles.SelectedValue.ToString() == Guid.Empty.ToString())
            {

                mdl.Masterflag = "Y";
                masterflag.Value = "Y";
                mdl.Fk_master_file_id = Guid.Empty;
            }
            else
            {
                mdl.Masterflag = "N";
                masterflag.Value = "N";
                mdl.Fk_master_file_id = new Guid(cmbmasterfiles.SelectedValue);
                uploadfileid = new Guid("00000000-0000-0000-0000-000000000000");


            }

            //filesize = filesize/(1024*1024);
            mdl.File_name = filename;

            mdl.File_path = virtualpath;//filepath earlier



            //mdl.File_name = filename.Substring(filename.Length - 3, 3).ToString().ToLower().ToString();
            mdl.File_type = "M";
            mdl.Filesize = filesize.ToString();
           
            if (hfselectedId.Value == "")
                {
                hfselected_fileid.Value = Request.Form["rdselect"].Split(',')[1];
                mdl.Fk_facility_id = new Guid(hfselected_fileid.Value);
                }
            else
                {
                mdl.Fk_facility_id = new Guid(hfselectedId.Value);
                }

                
            //}
            mdl.Uploaded_by = new Guid(SessionController.Users_.UserId);

            //*******//
            mdl.Pk_file_Id = uploadfileid.ToString();
            //bindselectedlocations();
            //nvm.facility_id = new Guid(ddlFacility.SelectedValue);
            DataSet ds = new DataSet();
            ds = BIMModelClient.InsertUpdateBIMModel(mdl, SessionController.ConnectionString);

            fileid.Value = ds.Tables[0].Rows[0]["file_id"].ToString();

            //navis_fileID = new Guid(ds.Tables[1].Rows[0]["fileid"].ToString());

            //rtvLocation.ClearCheckedNodes();

            string file_path_return = ds.Tables[0].Rows[0]["file_path_return"].ToString();
            //file_path_return = "~" + ds.Tables[0].Rows[0]["file_path_return"].ToString();

            if (ds.Tables[0].Rows[0]["Status"].ToString() == "Exists")
            {
                MessageBox("The file  " + filename + " already exists for this project.");
            }
            else
            {
                if (filename.Substring(filename.Length - 3, 3).ToString().ToLower() == "nwd")
                     load_activex(file_path_return);
            }

            bindmasterfiles();
        }

        catch (Exception ex)
        {
            throw ex;
        }
    }
    
    
    
    public void load_activex(string file_path)
    {
        
        
        string mappath;
        navis_class_id = "CLSID:8A8F9690-5695-42D5-AD50-6FA695F8B634";  // New classid
       // string RequestUrl = System.Configuration.ConfigurationManager.AppSettings["RequestUrl"].ToString();
        try
        {
            DataSet ds = new DataSet();
            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            BIMModel.BIMModels mdl = new BIMModel.BIMModels();
            mdl.User_id = new Guid(SessionController.Users_.UserId);
            ds = BIMModelClient.GetViewerForUser(mdl, SessionController.ConnectionString);
            if (ds != null)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    navis_class_id = ds.Tables[0].Rows[0]["class_id"].ToString();
                }
                else
                {
                    navis_class_id = "CLSID:8A8F9690-5695-42D5-AD50-6FA695F8B634";      // New classid
                }
            }


        }
        catch (Exception ex)
        {

            throw ex;
        }
        mappath = "<p height='20px' style='text-align: center'><object id='NWControl01' style='margin-top:20px' width='1000px' height='20px' classid='" + navis_class_id + "' codebase='../../Bin/Navisworks ActiveX Redistributable Setup.exe'><param name='_cx' value='240000'><param name='_cy' value='10000'>";

        mappath = mappath + "<param name='SRC' value='" + Request.Url.GetLeftPart(UriPartial.Authority) + file_path.Replace("~", "") + "'></object></p>";

       // string temppath = Server.MapPath(file_path);
       // mappath = mappath + "<param name='SRC' value='" + temppath + "'></object></p>";

        navis_view.InnerHtml = mappath;

        // Page.ClientScript.RegisterStartupScript(this.GetType(), "script4", "<script language='javascript'>btnextactclick()</script>");

    }

    protected void MessageBox(string msg)
    {
        Label lbl = new Label();
        lbl.Text = "<script language='javascript'>" + Environment.NewLine + "window.alert('" + msg + "')</script>";
        Page.Controls.Add(lbl);
    }
    protected void rguploadedfiles_OnPageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        //GetUploadedFilesPM();
        bindBimfileforfacilty();
    }
    protected void rguploadedfiles_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        //GetUploadedFilesPM();
        bindBimfileforfacilty();
    }
    protected void rguploadedfiles_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
       //GetUploadedFilesPM();
        bindBimfileforfacilty();
    }
    protected void rguploadedfiles_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "ParentFiles")
            {
                if (e.Item is Telerik.Web.UI.GridDataItem)
                {

                    ImageButton btn_bim = e.Item.FindControl("btn_bim") as ImageButton;



                    btn_bim.Attributes.Add("onclick", "javascript:return jump_model('" + e.Item.Cells[3].Text + "','" + e.Item.Cells[4].Text + "','" + e.Item.Cells[5].Text + "','" + e.Item.Cells[9].Text + "')");


                    btn_bim.Visible = true;

                }
            } 
            else if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "childFiles")
            {
                if (e.Item is Telerik.Web.UI.GridDataItem)
                {

                    ImageButton btn_bim = e.Item.FindControl("btn_bim") as ImageButton;



                    btn_bim.Attributes.Add("onclick", "javascript:return jump_model('" + e.Item.Cells[3].Text + "','" + e.Item.Cells[4].Text + "','" + e.Item.Cells[5].Text + "','" + e.Item.Cells[9].Text + "')");


                    btn_bim.Visible = true;
                  
                }
              
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    
    protected void btn_extract_data_OnClick(object sender, EventArgs e)
    {     
        hf_view_pt.Value = hf_view_pt.Value;
        insert_view_pt();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "message", "javascript:message();", true);
    }
     private void insert_view_pt()
    {
       /* DataSet ds=new DataSet();
        BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
        BIMModel.BIMModels mdl = new BIMModel.BIMModels();
        mdl.File_id = new Guid(fileid.Value);
        mdl.Navis_view_points = hf_view_pt.Value;
        BIMModelClient.InsertviewPoints(mdl, SessionController.ConnectionString);*/
        try
        {
            var dtViewpoint = new DataTable();
            dtViewpoint.Columns.Add("pk_view_id", typeof(Guid));
            dtViewpoint.Columns.Add("fk_uploaded_file_id", typeof(Guid));
            dtViewpoint.Columns.Add("fk_nw_id", typeof(string));
            dtViewpoint.Columns.Add("fk_view_id", typeof(Guid));
            dtViewpoint.Columns.Add("view_name", typeof(string));
            dtViewpoint.Columns.Add("view_number", typeof(string));
            dtViewpoint.Columns.Add("nw_id", typeof(string));
            dtViewpoint.Columns.Add("is_folder", typeof(char));

            XmlDocument xDoc = new XmlDocument();
            xDoc.LoadXml(hf_view_pt.Value.Replace("&", "and"));
            //  xDoc.LoadXml(hf_view_pt.Value.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;").Replace("\"", "&quot;").Replace("'", "&apos;"));
            XmlNodeList aNodes = xDoc.SelectNodes("/root");
            Guid ParentId;
            foreach (XmlNode node in aNodes)
            {
                ParentId = Guid.Empty;
                if (node.HasChildNodes)
                {
                    GetChildViewFromXml(node.ChildNodes, ParentId, "0", dtViewpoint);
                }

            }

            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            BIMModel.BIMModels mdl = new BIMModel.BIMModels();
            DataSet ds = new DataSet();
            ds.Tables.Add(dtViewpoint);
            mdl.DtViewpoint = ds;
            BIMModelClient.InsertviewPointsV1(mdl, SessionController.ConnectionString);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

     protected void GetChildViewFromXml(XmlNodeList CNodes, Guid ParentId, string parentName, DataTable Viewpoint)
     {
         try
         {
             Guid ChildParentId = Guid.Empty;
             foreach (XmlNode node in CNodes)
             {
                 if (node.HasChildNodes)
                 {
                     ChildParentId = Guid.NewGuid();
                     Viewpoint.Rows.Add(new object[] { ChildParentId, new Guid(fileid.Value), parentName, ParentId == Guid.Empty ? (object)DBNull.Value : ParentId, node.Attributes["name"].Value.ToString(), node.Attributes["sqn_number"].Value.ToString(), node.Attributes["id"].Value.ToString(), 'Y' });
                     GetChildViewFromXml(node.ChildNodes, ChildParentId, node.Attributes["name"].Value.ToString(), Viewpoint);
                 }
                 else
                 {
                     if (ParentId == Guid.Empty)
                         Viewpoint.Rows.Add(new object[] { Guid.NewGuid(), new Guid(fileid.Value), parentName, DBNull.Value, node.Attributes["name"].Value.ToString(), node.Attributes["sqn_number"].Value.ToString(), node.Attributes["id"].Value.ToString(), 'N' });
                     else
                         Viewpoint.Rows.Add(new object[] { Guid.NewGuid(), new Guid(fileid.Value), parentName, ParentId, node.Attributes["name"].Value.ToString(), node.Attributes["sqn_number"].Value.ToString(), node.Attributes["id"].Value.ToString(), 'N' });

                 }
             }
         }
         catch (Exception ex)
         {
             throw ex;
         }
     }
     protected void DeleteUplodedFile(Guid FileID)
     {
         string filename = string.Empty;
         String facilityId = string.Empty;
         try
         {

             BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
             BIMModel.BIMModels mdl = new BIMModel.BIMModels();
             DataSet ds = new DataSet();
             Regex name = new Regex("OtherFiles");


             mdl.File_id = FileID;
             ds = BIMModelClient.GetUploadedFileDetails(mdl, SessionController.ConnectionString);
             filename = Convert.ToString(ds.Tables[0].Rows[0]["file_name"]);
             if (filename != "" && filename != "<Empty>")
             {

                 facilityId = Convert.ToString(ds.Tables[0].Rows[0]["fk_facility_id"]);
                 Match file_path_string = name.Match(ds.Tables[0].Rows[0]["file_path"].ToString());


                 if (filename.Substring((filename.Length - 3), 3).ToString() == "ifc")
                 {
                     filepath = Server.MapPath("~/App/Files/" + facilityId + "/" + filename);
                 }
                 else
                     if (filename.Substring((filename.Length - 3), 3).ToString() == "xls")
                     {
                         filepath = Server.MapPath("~/App/Files/Documents" + facilityId + "/" + filename);
                     }
                     else

                         if (filename.Substring((filename.Length - 3), 3).ToString() == "xml")
                         {
                             filepath = Server.MapPath("~/App/Files/NWD Files/" + facilityId + "/" + filename);
                         }
                         else

                             if (filename.Substring((filename.Length - 6), 6).ToString().ToLower() == "ifcxml")
                             {
                                 filepath = Server.MapPath("~/App/BIM/UploadedFiles/IFCXmlFiles/" + facilityId + "/" + filename);
                             }
                             else
                             {
                                 if (filename.Substring((filename.Length - 3), 3).ToString().ToLower() == "nwd")
                                 {
                                     if (file_path_string.Success)
                                     {
                                         filepath = ds.Tables[0].Rows[0]["file_path"].ToString();
                                     }
                                     else
                                     {
                                         filepath = Server.MapPath(ds.Tables[0].Rows[0]["file_path"].ToString());

                                     }
                                 }
                                 else
                                     filepath = Server.MapPath("~/App/Files/" + facilityId + "/" + filename);
                             }

                 if (Directory.Exists(filepath))
                 {
                     string[] files = Directory.GetFiles(filepath);
                     string[] dirs = Directory.GetDirectories(filepath);

                     foreach (string file in files)
                     {
                         //added on 21-05-12 ---------------------------------------- 
                         string completefilepath = file;
                         int index = completefilepath.LastIndexOf('\\');
                         string actual_file = completefilepath.Substring(index + 1);

                         if (filename == actual_file)
                         {
                             //--------------------------------------------------------
                             File.SetAttributes(file, FileAttributes.Normal);
                             File.Delete(file);
                         }
                     }

                     // Directory.Delete(filepath, false);

                 }

                 if (File.Exists(filepath))
                 {
                     FileInfo file = new FileInfo(filepath);
                     file.Delete();
                 }
                 //********************old code for delete file******************
                 //BIMModelClient.DeleteUploadedFile(mdl, SessionController.ConnectionString);
                 //*****}***************end******************************
             }
             //***********new code modified by Ganesh 20/07/2012*********
             FacilityModel fm = new Facility.FacilityModel();
             FacilityClient fc = new Facility.FacilityClient();
             fm.Facility_Ids = FileID.ToString();
             fm.Entity = "Uploaded_file";
             fc.Set_delete_flag(fm, SessionController.ConnectionString);
             //********************end*******************
          //  GetUploadedFilesPM(); 
            bindBimfileforfacilty();


         }

         catch (Exception ex)
         {
             throw ex;
         }
     }

     //protected void DeleteUplodedFile(Guid FileID)
     //{
     //    string filename = string.Empty;
     //    String facilityId=string.Empty; 
     //    try
     //    {

     //        BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
     //        BIMModel.BIMModels mdl = new BIMModel.BIMModels();
     //        DataSet ds = new DataSet();
     //        Regex name = new Regex("OtherFiles");
             

     //        mdl.File_id = FileID;
     //        ds = BIMModelClient.GetUploadedFileDetails(mdl, SessionController.ConnectionString);
     //        filename = Convert.ToString(ds.Tables[0].Rows[0]["file_name"]);
     //        if(filename!="")
     //        {
            
     //        facilityId=Convert.ToString(ds.Tables[0].Rows[0]["fk_facility_id"]);  
     //        Match file_path_string = name.Match(ds.Tables[0].Rows[0]["file_path"].ToString());


     //        if (filename.Substring((filename.Length - 3), 3).ToString() == "ifc")
     //        {
     //            filepath = Server.MapPath("~/App/Files/" + facilityId + "/" + filename);
     //        }
     //        else
     //            if (filename.Substring((filename.Length - 3), 3).ToString() == "xls")
     //            {
     //                filepath = Server.MapPath("~/App/Files/Documents" + facilityId + "/" + filename);
     //            }
     //            else

     //                if (filename.Substring((filename.Length - 3), 3).ToString() == "xml")
     //                {
     //                    filepath = Server.MapPath("~/App/Files/NWD Files/" + facilityId + "/" + filename);
     //                }
     //                else

     //                    if (filename.Substring((filename.Length - 6), 6).ToString().ToLower() == "ifcxml")
     //                    {
     //                        filepath = Server.MapPath("~/App/BIM/UploadedFiles/IFCXmlFiles/" + facilityId + "/" + filename);
     //                    }
     //                    else
     //                    {
     //                        if (filename.Substring((filename.Length - 3), 3).ToString().ToLower() == "nwd")
     //                        {
     //                            if (file_path_string.Success)
     //                            {
     //                                filepath = ds.Tables[0].Rows[0]["file_path"].ToString();
     //                            }
     //                            else
     //                            {
     //                                filepath = Server.MapPath(ds.Tables[0].Rows[0]["file_path"].ToString());
                                   
     //                            }
     //                        }
     //                        else
     //                            filepath = Server.MapPath("~/App/Files/" + facilityId + "/" + filename);
     //                    }

     //        if (Directory.Exists(filepath))
     //        {
     //                 string[] files = Directory.GetFiles(filepath);
     //                 string[] dirs = Directory.GetDirectories(filepath);

     //                         foreach (string file in files)
     //                              {
     //                                //added on 21-05-12 ---------------------------------------- 
     //                                string completefilepath = file;
     //                                int index = completefilepath.LastIndexOf('\\');
     //                                string actual_file = completefilepath.Substring(index + 1);

     //                                if (filename == actual_file)
     //                                {
     //                                 //--------------------------------------------------------
     //                                    File.SetAttributes(file, FileAttributes.Normal);
     //                                    File.Delete(file);
     //                                }
     //                              }
                                            
     //            // Directory.Delete(filepath, false);
    
     //        }

     //        if (File.Exists(filepath))
     //        {
     //            FileInfo file = new FileInfo(filepath);
     //            file.Delete();
     //        }
     //        //********************old code for delete file******************
     //        //BIMModelClient.DeleteUploadedFile(mdl, SessionController.ConnectionString);
     //       //********************end******************************
             
     //        //***********new code modified by Ganesh 20/07/2012*********
     //        FacilityModel fm = new Facility.FacilityModel();
     //        FacilityClient fc = new Facility.FacilityClient();
     //        fm.Facility_Ids = FileID.ToString();
     //        fm.Entity = "Uploaded_file";
     //        fc.Set_delete_flag(fm, SessionController.ConnectionString);
     //            //********************end*******************
     //        GetUploadedFilesPM();
     //        }
     //        else
     //        {}
     //    }

     //    catch (Exception ex)
     //    {
     //        throw ex;
     //    }
     //}

     protected void rguploadedfiles_OnItemCommand(object sender, GridCommandEventArgs e)
     {
         try
         {
             if (e.CommandName == "delete")
             {
                 FileID = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_uploaded_file_id"].ToString());
                 DeleteUplodedFile(FileID);
                // bindmasterfiles();
             }
            

         }
         catch (Exception ex)
         {
             throw ex;
         }
         if (e.CommandName == "delete_child")
             
         {
             GridDataItem item = (GridDataItem)e.Item;
           
             FileID = new Guid((e.Item as GridDataItem).GetDataKeyValue("pk_uploaded_file_id").ToString());                    
           
             DeleteUplodedFile(FileID);
         }
         if (e.CommandName == "history")
         {
             Guid facilityid;
             GridDataItem item = (GridDataItem)e.Item;
             FileID = new Guid((e.Item as GridDataItem).GetDataKeyValue("pk_uploaded_file_id").ToString());
             if ((e.Item as GridDataItem).GetDataKeyValue("pk_facility_id") != null)
             {
                 facilityid = new Guid((e.Item as GridDataItem).GetDataKeyValue("pk_facility_id").ToString());
             }
             else
             {
                 facilityid = new Guid((e.Item.OwnerTableView.ParentItem as GridDataItem).GetDataKeyValue("pk_facility_id").ToString());
             }
           
             

             ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script1", " openpopupSelectFacility1('"+FileID+"','"+facilityid+"');", true);
         }

     }
     protected void btnreplace_Click(object sender, EventArgs e)
     {
         try
         {
             //Following if and else conditions are added by Priyanka J on 03rd May,2012
             if (Request.Form["rdselect"] != null)
             {
                 if (hfselectedId.Value != Guid.Empty.ToString() && hfselectedId.Value != "")
                 {
                     hfselected_fileid.Value = Request.Form["rdselect"].Split(',')[0];
                     UploadFile(new Guid(hfselected_fileid.Value.ToString()));
                    // GetUploadedFilesPM();
                     bindBimfileforfacilty();
                     bindmasterfiles();
                     hfselectedId.Value = "";
                 }
                 else
                 {

                     Page.ClientScript.RegisterStartupScript(this.GetType(), "script4", "<script language='javascript'>result_msg('Please select facility.')</script>");
                 }
             }
             else
             {
                 Page.ClientScript.RegisterStartupScript(this.GetType(), "script4", "<script language='javascript'>result_msg('Please select file to replace.')</script>");
             }
         }
          catch (Exception ex)
         {
             
             throw ex;
         }
     }
     protected void btn_download_Click(object sender, EventArgs e)
     {
         try
         {
             DataSet ds = new DataSet();
             BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
             BIMModel.BIMModels mdl = new BIMModel.BIMModels();

                 if (Request.Form["rdselect"] != null)
                 {
                     hfselected_fileid.Value = Request.Form["rdselect"].Split(',')[0];
                 
                     if (!(hfselected_fileid.Value == null || hfselected_fileid.Value.ToString().Equals("")))
                     {
                         mdl.File_id = new Guid(hfselected_fileid.Value);
                         ds = BIMModelClient.proc_get_file_path_by_id(mdl, SessionController.ConnectionString);
                          if (ds.Tables[0].Rows.Count > 0)
                         {
                             Response.Redirect(ds.Tables[0].Rows[0]["file_path"].ToString());
                             // Server.Transfer("testfm.ecodomus.com+ds.Tables[0].Rows[0]["file_path"].ToString()));

                         }
                     }
                 }
                 else
                 {
                     //Page.ClientScript.RegisterStartupScript(this.GetType(), "script4", "<script language='javascript'>result_msg('Please select file to download.')</script>");
                     ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script1", " result_msg('Please select file to download.');", true);
                 }
            
         }
         catch (Exception ex)
         {

             throw ex;
         }
     }
     protected void btn_refresh_Click(object sender, EventArgs e)
     {
         try
         {
             bindmasterfiles();
             bindBimfileforfacilty();

         }
         catch (Exception ex) 
         {
             
             throw ex;
         }

         
     
     }


     private void SetPermissions()
     {
         try
         {
             DataSet ds_component = SessionController.Users_.Permission_ds;
             DataRow dr_component = ds_component.Tables[0].Select("name='BIM Server'")[0];
             SetPermissionToControl(dr_component);


         }
         catch (Exception ex)
         {
             throw ex;
         }
     }

     private void SetPermissionToControl(DataRow dr)
     {
         Permissions objPermission = new Permissions();
         string edit_permission = dr["edit_permission"].ToString();
         string delete_permission = dr["delete_permission"].ToString();
        // objPermission.SetEditable(btnreplace, edit_permission);
         //objPermission.SetEditable(btn_download, edit_permission);
         objPermission.SetEditable(btnSubmit, edit_permission);

         if (delete_permission == "N")
         {
             foreach (GridDataItem item in rguploadedfiles.MasterTableView.Items)
             {
                 ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnremove");
                 imgbtnDelete.Enabled = false;
             }
         }
         else
         {
             foreach (GridDataItem item in rguploadedfiles.MasterTableView.Items)
             {
                 ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnremove");
                 imgbtnDelete.Enabled = true;
             }
         }


     }

     protected void rg_childfilebind(object source, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
     {
         DataSet ds = new DataSet();
         BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
         BIMModel.BIMModels mdl = new BIMModel.BIMModels();
        

         GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
      
         string masterFileId = Convert.ToString((dataItem as GridDataItem).GetDataKeyValue("pk_uploaded_file_id")).Trim();

         string facilityId = Convert.ToString((dataItem as GridDataItem).GetDataKeyValue("pk_facility_id")).Trim();
         mdl.Pk_file_Id =masterFileId;       
         mdl.Fk_facility_id = new Guid(facilityId);


         ds = BIMModelClient.getuploadedfiles(mdl, SessionController.ConnectionString);
         if (ds.Tables[0].Rows.Count > 0)
         {

             e.DetailTableView.DataSource = ds;
         }
         else
         {
             e.DetailTableView.Enabled = false;
         }
       
        
     }
     protected void bindBimfileforfacilty()
     {
         DataSet ds = new DataSet();
         BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
         BIMModel.BIMModels mdl = new BIMModel.BIMModels();

         if (hfselectedId.Value.ToString() == "")
         {
             mdl.Fk_facility_id =Guid.Empty;
         }
         else
         {
             mdl.Fk_facility_id = new Guid(hfselectedId.Value.ToString());
         }
         mdl.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
         ds=BIMModelClient.getuploadedfilesforfacility(mdl,SessionController.ConnectionString);
         rguploadedfiles.DataSource = ds;
         rguploadedfiles.DataBind();
       //  rguploadedfiles.MasterTableView.Rebind();


     }

     protected void insertintoHistroy(Guid FileId,Guid userid)
     {

         DataSet ds = new DataSet();
         BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
         BIMModel.BIMModels mdl = new BIMModel.BIMModels();
         mdl.File_id = FileId;
         mdl.User_id =userid;
         BIMModelClient.proc_insert_Bim_history(mdl, SessionController.ConnectionString);
 
     }

     public void redirectToModelViewer(string url)
     {
         Response.Redirect(url);
     }

  
    

    

  
}