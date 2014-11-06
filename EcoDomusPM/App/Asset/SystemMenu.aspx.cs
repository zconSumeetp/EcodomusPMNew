using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using EcoDomus.Session;
using BIMModel;
using System.Globalization;
using System.Threading;
using Telerik.Web.UI;

public partial class App_Settings_SettingsMenu : System.Web.UI.Page
{
    #region Page Events
    protected void Page_Load(object sendSystemIDer, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (SessionController.Users_.UserId != null)
                {
                    if (Request.QueryString["pagevalue"] == null)
                    
                    {
                        if (Request.QueryString["system_id"] != null)
                        {
                            string value = "";
                            if (Request.QueryString["page_load"] != null)
                            {
                                 value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','SystemProfile.aspx?system_id=" + Request.QueryString["system_id"] + "'+'&value=system');sitemapSystem();</script>";
                            }//added

                            else if (Request.QueryString["system_id"] == Guid.Empty.ToString())
                            {
                                value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','SystemProfile.aspx?system_id=" + Request.QueryString["system_id"] + "'+'&value=blank');sitemapSystem();</script>";
                            }

                            else 
                            {
                                value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','SystemProfile_1.aspx?system_id=" + Request.QueryString["system_id"] + "');sitemapSystem();</script>";
                            }

                            Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
                            hfSystemId.Value = Request.QueryString["system_id"].ToString();
                            Guid derypted_type_id = new Guid(hfSystemId.Value);
                            if (derypted_type_id == Guid.Empty)
                            {
                                rtsSystemProfile.Style.Add("display", "none");
                            }
                            else
                            {
                                rtsSystemProfile.Style.Add("display", "inline");
                            }

                            if (Request.QueryString["system_id"] == Guid.Empty.ToString())
                            {
                                systemProfile.Visible = true;
                                //lblsystemprofile.Text = "System Profile";
                            }
                            else
                            {
                                //////To get the name of current system:- //////////////////////
                                system.Visible = true;

                                Systems.SystemsModel objSysModel = new Systems.SystemsModel();
                                Systems.SystemsClient objSysClient = new Systems.SystemsClient();
                                DataSet ds_systemprofile = new DataSet();
                                if (hfSystemId.Value == Guid.Empty.ToString())
                                {
                                    objSysModel.SystemId = Guid.Empty;
                                }
                                else
                                {
                                    objSysModel.SystemId = new Guid(hfSystemId.Value);
                                }
                                ds_systemprofile = objSysClient.GetSystemProfile(objSysModel, SessionController.ConnectionString);

                                string systemname = ds_systemprofile.Tables[0].Rows[0]["SystemName"].ToString();
                                lblsystemname.Text = systemname;
                                hf_facility_id.Value = ds_systemprofile.Tables[0].Rows[0]["pk_facility_id"].ToString();
                                ///////////////////////////////////////////////////////
                            }
                           
                            /*******************************BIM***********************************************/
                            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
                            BIMModel.BIMModels mdl = new BIMModel.BIMModels();
                            DataSet ds1 = new DataSet();
                            string filename = string.Empty;
                            mdl.System_id = hfSystemId.Value.ToString();
                            ds1 = BIMModelClient.GetUploadedFileForSystem(mdl, SessionController.ConnectionString);
                            //hf_fk_masterfile_id.Value = ds1.Tables[0].Rows[0]["fk_master_file_id"].ToString();
                           
                            if (ds1.Tables[0].Rows.Count > 0 && ds1.Tables[0].Rows[0]["uploaded_file_id"].ToString()!="")
                            {
                                hfUploaded_File_Id.Value = ds1.Tables[0].Rows[0]["uploaded_file_id"].ToString();
                                filename = ds1.Tables[0].Rows[0]["file_name"].ToString();
                                if (filename.Substring(filename.Length - 3, 3).ToString().ToLower() == "nwd")
                                {
                                    hf_file_ext.Value = "nwd";
                                }
                                else
                                {
                                    hf_file_ext.Value = "hsf";
                                }
                            }
                            else
                            {
                                hfUploaded_File_Id.Value = Guid.Empty.ToString();
                            }
                            if (ds1.Tables[0].Rows.Count > 0 && ds1.Tables[0].Rows[0]["fk_master_file_id"].ToString() != "")
                            {
                                hf_fk_masterfile_id.Value = ds1.Tables[0].Rows[0]["fk_master_file_id"].ToString();

                            }
                            else
                            {
                                hf_fk_masterfile_id.Value = Guid.Empty.ToString();
                            }
                            
                        }
                       
                    }
                    else
                    {
                        
                        hfSystemId.Value = Request.QueryString["hfSystemId"].ToString();
                        string abvalue = Request.QueryString["pagevalue"].ToString();
                        string value = "<script language='javascript'>pageload('" + abvalue + "')</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);

                    }

                    DataSet ds = new DataSet();
                    Systems.SystemsModel objSystemsModel = new Systems.SystemsModel();
                    Systems.SystemsClient objSystemsClient = new Systems.SystemsClient();
                    objSystemsModel.EntityName = "System";
                    objSystemsModel.Culture = Session["Culture"].ToString();
                    ds = objSystemsClient.GetMenuForSystem(objSystemsModel, SessionController.ConnectionString);
                    rtsSystemProfile.DataTextField = "page_heading1";
                    rtsSystemProfile.DataFieldID = "pk_setting_page_Id";
                    //rtsSystemProfile.DataNavigateUrlField = "NavigateUrl";
                    rtsSystemProfile.DataValueField = "page_heading";
                    rtsSystemProfile.DataSource = ds;
                    rtsSystemProfile.DataBind();
                }
            }
            else
            {
                string Updatedvalue = "<script language='javascript'>top.window.CallClickEvent(~/App/loginpm.aspx)')</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script", Updatedvalue);
            }
        }
        catch (Exception ex)
        {
            throw ex;
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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {
        Response.Redirect(url, false);
    }
    protected void btnclick_Click(object sender, EventArgs e)
    {
        string tabName = hfSelectedIndex.Value;
        //if (tabName.Equals((string)GetGlobalResourceObject("Resource", "Components")))
        //{
        //    tabName = (string)GetGlobalResourceObject("Resource", "Assets");
        //}
        if (tabName.Contains(" "))
        {
            tabName = tabName.Trim().Replace(" ", "_");
        }
        ContentPlaceHolder ctnobj = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
        if (ctnobj != null)
        {
            RadTabStrip tabStrip = (RadTabStrip)ctnobj.FindControl("rtsSystemProfile");
            if (tabStrip != null)
            {
                RadTab objTab = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", tabName));
                if (objTab != null)
                {
                    objTab.Enabled = true;
                    objTab.Selected = true;
                }
            }
        }

        //string tabIndex = hfSelectedIndex.Value;
        //if (tabIndex == (string)GetGlobalResourceObject("Resource", "System_Profile"))
        //{
        //    rtsSystemProfile.SelectedIndex = 0;
        //    hfSelectedIndex.Value = "";
        //}
        //if (tabIndex == (string)GetGlobalResourceObject("Resource", "Subsystems"))
        //{
        //    rtsSystemProfile.SelectedIndex = 1;
        //    hfSelectedIndex.Value = "";
        //}
        //if (tabIndex == (string)GetGlobalResourceObject("Resource", "Components"))
        //{
        //    rtsSystemProfile.SelectedIndex = 2;
        //    hfSelectedIndex.Value = "";
        //}
        //if (tabIndex == (string)GetGlobalResourceObject("Resource", "Documents"))
        //{
        //    rtsSystemProfile.SelectedIndex = 3;
        //    hfSelectedIndex.Value = "";
        //}
        //if (tabIndex == (string)GetGlobalResourceObject("Resource", "View_In_BIM"))
        //{
        //    rtsSystemProfile.SelectedIndex = 4;
        //    hfSelectedIndex.Value = "";
        //}

    }
    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "CBU")
            {
                ContentPlaceHolder ctnobj = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
                RadTabStrip tabStrip = (RadTabStrip)ctnobj.FindControl("rtsSystemProfile");
                if (tabStrip != null)
                {
                    RadTab objTab = tabStrip.FindTabByValue("View in BIM");
                    if (objTab != null)
                    {
                        objTab.Visible = false;

                    }
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    #endregion

}