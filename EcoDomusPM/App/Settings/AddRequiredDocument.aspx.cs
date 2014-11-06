using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using EcoDomus.Session;
using Locations;
using AttributeTemplate;
using System.Threading;
using System.Globalization;



public partial class App_Settings_AddRequiredDocument : System.Web.UI.Page
{
    #region Global Variables Declarations
    string omniclass_id = "";
    List<String> ls = new List<string>();
    string[] ids;
    Guid template_id;
    #endregion
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (Request.QueryString["templateId"] != null)
            {
                if (Request.QueryString["templateId"].ToString() != "")
                {
                    //lbladdcompattribute.Text = Request.QueryString["Name"].ToString().Replace('�', ' ');
                    omniclass_id = Request.QueryString["omniclass_detail_id"].ToString();
                    omniclass_id = omniclass_id.Substring(0, omniclass_id.Length - 1);
                    ids = omniclass_id.Split(',');
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
                    omniclass_id = "";
                    for (int i = 0; i < ls.Count; i++)
                    {
                        omniclass_id = omniclass_id + ls[i].ToString() + ",";

                    }
                    omniclass_id = omniclass_id.Substring(0, omniclass_id.Length - 1);
                }
            }

            if (Request.QueryString["templateId"] != null)
            {
                template_id = new Guid(Request.QueryString["templateId"]);

            }
            if (!IsPostBack)
            {
                BindCategories();
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
    protected void BindCategories()
    {
        try
        {
            DataSet ds_doc_type = new DataSet();
            LocationsClient locObj_crtl = new LocationsClient();
            LocationsModel locObj_mdl = new LocationsModel();

            if (Convert.ToString(Request.QueryString["templateId"]) != "")
                locObj_mdl.Attribute_template_id = new Guid(Convert.ToString(Request.QueryString["templateId"]));
            else
                locObj_mdl.Attribute_template_id = Guid.Empty;

            locObj_mdl.ProjectId = Guid.Empty;


            locObj_mdl.OrganizationID = SessionController.Users_.OrganizationID;
            ds_doc_type = locObj_crtl.get_document_type(SessionController.ConnectionString, locObj_mdl);

            cmb_type.DataTextField = "type_name";
            cmb_type.DataValueField = "doc_type_id";
            cmb_type.DataSource = ds_doc_type;
            cmb_type.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion
    #region Event Handlers
    protected void btnAddedit_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            DataSet ds = new DataSet();
            try
            {
                am.Attribute_template_id = template_id;
                am.Doc_type_id = new Guid(cmb_type.SelectedValue);
                am.EntityID = new Guid(Request.QueryString["entity_id"].ToString());
                am.Omniclass_ids = omniclass_id;
                ds = ac.InsertRequiredDocument(am, SessionController.ConnectionString);
                if (ds.Tables[0].Rows[0]["flag"].ToString() == "0")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "The required document '" + cmb_type.SelectedItem.Text + "' is saved successfully.";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "refreshParentGrid();", true);
                }
                

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