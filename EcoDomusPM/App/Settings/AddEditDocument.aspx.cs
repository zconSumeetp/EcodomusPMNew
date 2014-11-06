using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using Locations;
using EcoDomus.Session;
using AttributeTemplate;
using System.Collections;
using System.Threading;
using System.Globalization;


public partial class App_Settings_AddEditDocument : System.Web.UI.Page
{
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {
                lbldoc.Text = Request.QueryString["Name"].ToString().Replace('�', ' ');
                BindCategories();
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "document_type_name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                rgdocument.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                bind_document_grid();
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
            ds_doc_type = locObj_crtl.get_document_type(SessionController.ConnectionString,locObj_mdl);
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
    public void bind_document_grid()
    {
        AttributeTemplateModel am = new AttributeTemplateModel();
        AttributeTemplateClient ac = new AttributeTemplateClient();
        DataSet ds = new DataSet();
        try
        {
            am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
            am.Omniclass_id = new Guid(Request.QueryString["omniclass_detail_id"].ToString());
            am.EntityID = new Guid(Request.QueryString["entity_id"].ToString());
            ds = ac.BindRequiredDocument(am, SessionController.ConnectionString);
            rgdocument.DataSource = ds;
            rgdocument.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion
    #region Page Events
    protected void rgdocument_ItemCommand(object source, GridCommandEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            if (e.CommandName == "deletedocument")
            {
                Guid document_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_required_document_id"].ToString());
                am.PK_Doc_id = document_id;
                ac.DeleteRequiredDocument(am, SessionController.ConnectionString);
                bind_document_grid();
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }

    protected void btnAddedit_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            DataSet ds = new DataSet();
            try
            {
                am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
                am.Omniclass_ids = Request.QueryString["omniclass_detail_id"].ToString();
                am.EntityID = new Guid(Request.QueryString["entity_id"].ToString());
                am.Doc_type_id = new Guid(cmb_type.SelectedValue.ToString());
                ds = ac.InsertRequiredDocument(am, SessionController.ConnectionString);
                lblerror.Text = "";
                if (ds.Tables[0].Rows[0]["flag"].ToString() == "0")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_height();", true);
                    bind_document_grid();
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
    protected void rgdocument_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                bind_document_grid();
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
    protected void rgdocument_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                bind_document_grid();
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
    protected void rgdocument_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        bind_document_grid();
    }
    protected void ibtn_close_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void cmb_type_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_height();", true);
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

    #endregion
   
}