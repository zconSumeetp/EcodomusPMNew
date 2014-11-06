using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Session;
using System.Data;
using Asset;
using BIMModel;
using System.Globalization;
using System.Threading;
using Telerik.Web.UI;

public partial class App_Asset_AssetMenu : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (Request.QueryString["pagevalue"] == null)
                {

                    if (Request.QueryString["assetid"] != null)
                    {


                        string value = "";
                        if (Request.QueryString["page_load"] != null)
                        {
                            value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','AssetProfile.aspx?assetid=" + Request.QueryString["assetid"] + "'+'&value=asset');</script>"; //sitemapSystem();
                        }//added

                        else   if (Request.QueryString["assetid"] == Guid.Empty.ToString() && Request.QueryString["TypeId"] == null && Request.QueryString["SpaceId"] == null)
                        {
                            value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','AssetProfile.aspx?assetid=" + Request.QueryString["assetid"] + "'+'&value=blank');</script>";//sitemapSystem();
                           
                        }
                            //redirected from type profile
                        else if (Request.QueryString["assetid"] == Guid.Empty.ToString() && Request.QueryString["TypeId"] != null && Request.QueryString["SpaceId"] == null)
                        {
                            value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','AssetProfile.aspx?assetid=" + Request.QueryString["assetid"] + "'+'&value=" + Request.QueryString["TypeId"] + "');</script>";//sitemapSystem();         
                        }

                            //redirected from space profile
                        else if (Request.QueryString["assetid"] == Guid.Empty.ToString() && Request.QueryString["TypeId"] == null && Request.QueryString["SpaceId"] != null)
                        {
                            value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','AssetProfile.aspx?assetid=" + Request.QueryString["assetid"] + "'+'&value=" + Request.QueryString["SpaceId"] + "');</script>";//sitemapSystem();         
                        }

                        else if (Request.QueryString["assetid"] != null && Request.QueryString["isFromMissingAttribute"] != null)
                        {
                            hfMissingAttribute.Value = Request.QueryString["attribute_name"].ToString();
                           value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','Attribute.aspx?entity_name=Asset&entity_id=" + Request.QueryString["assetid"] + "&attribute_name=" + hfMissingAttribute.Value + "');</script>";//sitemapSystem();
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
                            rtsComponentProfile.SelectedIndex = 1;
                        
                        }

                        else
                        {
                            value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','AssetProfileNew.aspx?assetid=" + Request.QueryString["assetid"] + "');</script>";//sitemapSystem();
                        }



                        Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);
                        hf_asset_id.Value = Request.QueryString["assetid"].ToString();

                        Guid derypted_asset_id = new Guid(hf_asset_id.Value);
                        if (derypted_asset_id == Guid.Empty)
                        {
                            rtsComponentProfile.Style.Add("display", "none");
                        }
                        else
                        {
                            rtsComponentProfile.Style.Add("display", "inline");
                        }

                        if (Request.QueryString["assetid"] == Guid.Empty.ToString())
                        {

                            componentProfile.Visible = true;
                        }
                        else if (Request.QueryString["assetid"] != Guid.Empty.ToString())
                        {
                            component.Visible = true;

                            hf_asset_id.Value = Request.QueryString["assetid"].ToString();
                            string id = hf_asset_id.Value;
                            //To get the name of a current asset
                            AssetClient obj_assetclient = new AssetClient();
                            AssetModel obj_assetmodel = new AssetModel();
                            DataSet ds_AssetProfile = new DataSet();
                            obj_assetmodel.Asset_id = new Guid(hf_asset_id.Value);

                            ds_AssetProfile = obj_assetclient.Get_AssetProfile(obj_assetmodel, SessionController.ConnectionString);
                            string assetname = ds_AssetProfile.Tables[0].Rows[0]["name"].ToString();
                            hfFacilityid.Value = ds_AssetProfile.Tables[0].Rows[0]["fk_facility_id"].ToString();
                            ViewState["FacilityId"] = hfFacilityid.Value;
                            lblcomponentname.Text = assetname;

                            Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
 


                            /************************************BIM***************************************************************/
                            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
                            BIMModel.BIMModels mdl = new BIMModel.BIMModels();
                            DataSet ds1 = new DataSet();
                            string filename = string.Empty;
                            mdl.Asset_id = new Guid(hf_asset_id.Value.ToString());
                            ds1 = BIMModelClient.GetUploadedFileForAsset(mdl, SessionController.ConnectionString);
                            if (ds1.Tables[0].Rows.Count > 0)
                            {
                                hf_uploaded_File_id.Value = ds1.Tables[0].Rows[0]["uploaded_file_id"].ToString();
                                hf_element_numeric_id.Value = ds1.Tables[0].Rows[0]["element_numeric_id"].ToString();
                                hf_fk_masterfile_id.Value = ds1.Tables[0].Rows[0]["fk_master_file_id"].ToString();
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
                                hf_uploaded_File_id.Value = Guid.Empty.ToString();
                                hf_element_numeric_id.Value = Guid.Empty.ToString();
                                hf_fk_masterfile_id.Value = Guid.Empty.ToString();
                            }

                           
                        }
                        else if (Request.QueryString["id"] != Guid.Empty.ToString())
                        {
                            component.Visible = true;
                            string abvalue = Request.QueryString["pagevalue"].ToString();
                            hf_asset_id.Value = Request.QueryString["id"].ToString();
                            string id = hf_asset_id.Value;
                            /*page*/
                            value = "<script language='javascript'>pageload('" + abvalue + "','" + id + "')</script>";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);

                            /************************************BIM***************************************************************/
                            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
                            BIMModel.BIMModels mdl = new BIMModel.BIMModels();
                            DataSet ds1 = new DataSet();
                            mdl.Asset_id = new Guid(hf_asset_id.Value.ToString());
                            ds1 = BIMModelClient.GetUploadedFileForAsset(mdl, SessionController.ConnectionString);
                            if (ds1.Tables[0].Rows.Count > 0)
                            {
                                hf_uploaded_File_id.Value = ds1.Tables[0].Rows[0]["uploaded_file_id"].ToString();
                                hf_element_numeric_id.Value = ds1.Tables[0].Rows[0]["element_numeric_id"].ToString();
                            }
                            else
                            {
                                hf_uploaded_File_id.Value = Guid.Empty.ToString();
                                hf_element_numeric_id.Value = Guid.Empty.ToString();
                            }

                        }

                    }

                }




                else
                {
                    componentProfile.Visible = true;
                }

                DataSet ds = new DataSet();

                AssetClient ObjAsset_crtl = new AssetClient();
                AssetModel ObjAsset_mdl = new AssetModel();
                 
                ObjAsset_mdl.EntityName = "Asset";
                ObjAsset_mdl.Culture = Session["Culture"].ToString();
                ds = ObjAsset_crtl.get_customised_left_menu(ObjAsset_mdl, SessionController.ConnectionString);
                
                DataSet ds_menu = new DataSet();
                ds_menu = ds;

                if (Session["Culture"].ToString() == "en-us")
                {
                    rtsComponentProfile.DataTextField = "page_heading";
                }
                else
                {
                    rtsComponentProfile.DataTextField = "page_heading1";
                }
                
                rtsComponentProfile.DataFieldID = "pk_setting_page_id";
                rtsComponentProfile.DataValueField = "page_heading";
                rtsComponentProfile.DataSource = ds_menu;

                rtsComponentProfile.DataBind();
                if (Request.QueryString["assetid"] == null)
                {
                    rtsComponentProfile.Visible = false;
                }


            }
            }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "CBU")
            {
                ContentPlaceHolder ctnobj = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
                RadTabStrip tabStrip = (RadTabStrip)ctnobj.FindControl("rtsComponentProfile");
                if (tabStrip != null)
                {
                    RadTab objTab = tabStrip.FindTabByValue("View in BIM");
                    RadTab objTab1 = tabStrip.FindTabByValue("Issues");
                    if (objTab != null)
                    {
                        objTab.Visible = false;

                    }
                    if (objTab1 != null)
                    {
                        objTab1.Visible = false;

                    }

                }

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
       
        ContentPlaceHolder ctnobj = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
        if (tabName.Contains(" "))
        {

        }
        if (ctnobj != null)
        {
            RadTabStrip tabStrip = (RadTabStrip)ctnobj.FindControl("rtsComponentProfile");
            if (tabStrip != null)
            {
                RadTab objTab = tabStrip.FindTabByValue(tabName);
                if (objTab != null)
                {
                    objTab.Enabled = true;
                    objTab.Selected = true;
                }
            }
        }
    }
}