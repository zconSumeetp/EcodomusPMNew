using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AttributeTemplate;
using EcoDomus.Session;
using System.Data;
using System.Threading;
using System.Globalization;

public partial class App_Settings_AddEditNames : System.Web.UI.Page
{
    #region Global Variable Declarations
    string omniclass_detail_id = "";
    string[] ids;
    List<String> ls = new List<string>();
    string name = "";
    #endregion
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (Request.QueryString["omniclass_detail_id"] != null)
            {
                try
                {
                    omniclass_detail_id = Request.QueryString["omniclass_detail_id"].ToString();
                    omniclass_detail_id = omniclass_detail_id.Substring(0, omniclass_detail_id.Length - 1);
                    ids = omniclass_detail_id.Split(',');
                    if (ids.Length > 0)
                    {
                        for (int i = 0; i < ids.Length; i++)
                        {
                            if (!ls.Contains(ids[i].ToString()))
                            {
                                ls.Add(ids[i].ToString());
                            }
                        }
                    }
                    omniclass_detail_id = "";

                    for (int i = 0; i < 1; i++)
                    {
                        omniclass_detail_id = omniclass_detail_id + ls[i].ToString() + ",";

                    }
                    omniclass_detail_id = omniclass_detail_id.Substring(0, omniclass_detail_id.Length - 1);
                }
                catch (Exception ex)
                {

                    throw ex;
                }
            }
            l1.Text = Request.QueryString["Name"].ToString().Replace('�', ' ');
            if (!IsPostBack)
            {
                bindomniclassnames();
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    #endregion 
    #region Private Methods
    protected override void InitializeCulture()
    {
        if (SessionController.Users_.UserId != null)
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
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
    protected void bindomniclassnames()
    {
        AttributeTemplateModel am = new AttributeTemplateModel();
        AttributeTemplateClient ac = new AttributeTemplateClient();
        DataSet ds = new DataSet();
        try
        {
            //am.Omniclass_id = new Guid(Request.QueryString["omniclass_detail_id"].ToString());

            am.Omniclass_id = new Guid(omniclass_detail_id);

            am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
            am.Entity_id = new Guid(Request.QueryString["entity_id"].ToString());
            ds = ac.Get_omniclass_names_for_naming_convention(am, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtLongName.Text = ds.Tables[0].Rows[0]["OmniClassName"].ToString();
                txtShortName.Text = ds.Tables[0].Rows[0]["ShortName"].ToString();
                if (ds.Tables[0].Columns["custom_name"] != null)
                {
                    if (ds.Tables[0].Rows[0]["custom_name"] != null)
                    {
                        txtCustomName.Text = ds.Tables[0].Rows[0]["custom_name"].ToString();
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
    #region Event Handlers
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            DataSet ds = new DataSet();
            try
            {
                //am.Omniclass_id =new Guid(Request.QueryString["omniclass_detail_id"].ToString());
                am.Omniclass_ids = omniclass_detail_id;
                am.EntityID = new Guid(Request.QueryString["entity_id"].ToString());
                am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
                am.Customname = txtCustomName.Text;
                am.LongName = txtLongName.Text;
                am.Shortname = txtShortName.Text;
                ac.InsertUpdateNamingConvention(am, SessionController.ConnectionString);
                string Updatedvalue = "<script language='javascript'>refresh_page();</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script", Updatedvalue);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    protected void ibtn_close_Click(object sender, ImageClickEventArgs e)
    {

    }
    #endregion
}