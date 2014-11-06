using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using Telerik.Web.UI;
using AttributeTemplate;
using System.Data;
using System.Threading;
using System.Globalization;
using Report;
using User;
using System.Collections;

public partial class App_Settings_RequiredAttribute : System.Web.UI.Page
{
    string tempPageSize = "";
    bool flag = false;
    #region Global Variable Declarations
    Guid guidRequiredAttributeTemplateId;
    public ArrayList arrayList = new ArrayList();
    List<String> ls = new List<string>();
    #endregion

    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {

        if (SessionController.Users_.UserId != null)
        {
            if (Request.QueryString["RequiredAttributeTemplateId"] != null)
            {
                guidRequiredAttributeTemplateId = new Guid(Request.QueryString["RequiredAttributeTemplateId"]);
                hfRequiredAttributeTemplateId.Value = Request.QueryString["RequiredAttributeTemplateId"];
                //hfEntityId.Value = Request.QueryString["entity_id"];
                Session["templateid"] = guidRequiredAttributeTemplateId;
            }
            else
            {
                guidRequiredAttributeTemplateId = new Guid(Session["templateid"].ToString());
                hfRequiredAttributeTemplateId.Value = Session["templateid"].ToString();
            }
            if (Request.QueryString["Name"] != null)
            {
                lbl_template_name.Text = Request.QueryString["Name"].ToString();
                hf_template_name.Value = lbl_template_name.Text;
                Session["Name"] = lbl_template_name.Text;
            }
            else
            {
                lbl_template_name.Text = Session["Name"].ToString();
                hf_template_name.Value = lbl_template_name.Text;
            }

            if (!IsPostBack)
            {
                ViewState["SelectedOmniClassID"] = null;
                if (Request.QueryString["GlobalFlag"] == "Y")
                {
                    rg_omniclass.Columns[3].Visible = false;
                }
                else
                {
                    rg_omniclass.Columns[3].Visible = true;
                }
                rdBtnOmniClass.Visible = false;
                rdBtnOmniClass2.Visible = false;

                hfUserPMPageSize.Value = Convert.ToString(Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids) - 2);
                tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                tempPageSize = Convert.ToString(Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids) - 2);
                bindentity();
                BindOmniClass();
                //hf_entity_id.Value = cmb_type.SelectedValue.ToString();
                hf_entity_id.Value = cmb_type.SelectedItem.Value.ToString();
            }
        }
        else
        {
            Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
        }
    }

    #endregion

    #region mymethods

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

    protected void bindentity()
    {
        AttributeTemplateModel am = new AttributeTemplateModel();
        AttributeTemplateClient ac = new AttributeTemplateClient();
        DataSet ds = new DataSet();
        try
        {
            am.Flag = "template";
            ds = ac.BindEntity(am, SessionController.ConnectionString);
            cmb_type.DataTextField = "entity_name";
            cmb_type.DataValueField = "pk_entity_id";
           
            cmb_type.DataSource = ds;
            cmb_type.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void BindOmniClass()
    {
        AttributeTemplateModel am = new AttributeTemplateModel();
        AttributeTemplateClient ac = new AttributeTemplateClient();
        DataSet ds = new DataSet();

        if (Request.QueryString["RequiredAttributeTemplateId"] != null)
        {
            guidRequiredAttributeTemplateId = new Guid(Request.QueryString["RequiredAttributeTemplateId"]);
        }

        am.Attribute_template_id = guidRequiredAttributeTemplateId;

        if (cmb_type.SelectedItem != null)
        {
            am.EntityID = new Guid(cmb_type.SelectedValue.ToString());
        }

        am.Search = txtSearch.Text;
        if (rdBtnOmniClass.Checked)
        {
            am.Omniclassversion = "OmniClass 2010";
        }
        else if (rdBtnOmniClass2.Checked)
        {
            am.Omniclassversion = "OmniClass 2006";
        }
        ds = ac.BindRequiredAttributeTemplateValues(am, SessionController.ConnectionString);

        rg_omniclass.AllowCustomPaging = true;
        if (tempPageSize != "")
            rg_omniclass.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
        rg_omniclass.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
        rg_omniclass.DataSource = ds;
        rg_omniclass.DataBind();
        hf_organization_id.Value = Convert.ToString(ds.Tables[1].Rows[0]["organization_id"]);


    }

    protected void GetSelectedRows()
    {
        try
        {
            SessionToArrayList();

            foreach (GridDataItem item in rg_omniclass.Items)
            {
                string strIndex = rg_omniclass.MasterTableView.CurrentPageIndex.ToString();
                // string comp_id = item.GetDataKeyValue("Assetid").ToString();
                string comp_id = item["omniclass_id"].Text;

                if (item.Selected)
                {
                    if (!arrayList.Contains(comp_id.ToString()))
                    {
                        arrayList.Add(comp_id.ToString());
                    }
                }
                else
                {
                    if (arrayList.Contains(comp_id.ToString()))
                    {
                        arrayList.Remove(comp_id.ToString());
                    }
                }
            }

            ViewState["SelectedOmniClassID"] = arrayList;
            ArrayList comp_list = (ArrayList)ViewState["SelectedOmniClassID"];
            string id = "";
            if (comp_list.Count > 0)
            {
                for (int i = 0; i < comp_list.Count; i++)
                {
                    id = id + comp_list[i].ToString() + ",";

                }
                id = id.Substring(0, id.Length - 1);
                hf_OmniClass_id.Value = id;

            }
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void ReSelectedRows()
    {
        try
        {
            foreach (GridDataItem item in rg_omniclass.Items)
            {
                string omniclass_id = item.GetDataKeyValue("omniclass_id").ToString();//item["Assetid"].Text;

                if (arrayList.Contains(omniclass_id.ToString()))
                {
                    item.Selected = true;

                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void SessionToArrayList()
    {
        try
        {
            if (ViewState["SelectedOmniClassID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedOmniClassID"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    #endregion

    #region Event Handlers

    protected void rgOmniClass_ItemDataBound(object sender, GridItemEventArgs e)
    {
        ReSelectedRows();
        
    }

    protected void cmb_type_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {

        BindOmniClass();
        hf_entity_id.Value = cmb_type.SelectedItem.Value.ToString();
    }

    protected void rdBtnOmniClass2_CheckedChanged(object sender, EventArgs e)
    {
        BindOmniClass();
    }

    protected void rdBtnOmniClass_CheckedChanged(object sender, EventArgs e)
    {
        BindOmniClass();
    }

    protected void btn_search_click(object sender, EventArgs e)
    {
        BindOmniClass();
    }

    protected void btnSearchClick(object sender, EventArgs e)
    {
        BindOmniClass();
    }
    
    protected void btnrefreshgrid_Click(object sender, EventArgs e)
    {

        ViewState["SelectedOmniClassID"] = null;
        hf_OmniClass_id.Value = "";
        rg_omniclass.MasterTableView.CurrentPageIndex = 0;
        BindOmniClass();
    }

    protected void btn_refresh_grid_new_Click(object sender, EventArgs e)
    {
        ViewState["SelectedOmniClassID"] = null;
        hf_OmniClass_id.Value = "";
        rg_omniclass.MasterTableView.CurrentPageIndex = 0;
        BindOmniClass();

    }

    protected void rg_omniclass_pageindexchanged(object source, GridPageChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindOmniClass();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_omniclass_pagesizechanged(object source, GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindOmniClass();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_omniclass_sort_command(object source, GridSortCommandEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindOmniClass();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    #endregion

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
           
            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    {
                        SetPermissions();
                    }
                }
            }
        }
        catch (Exception)
        {

            throw;
        }
    }

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='Facility'")[0];
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

        string delete_permission = dr["delete_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();

        if (edit_permission == "N")
        {
            btnaddrequiredattributes.Enabled = false;
            btnaddrequireddocuments.Enabled = false;
            btnaddnamingconvention.Enabled = false;
        }
        else
        {
            btnaddrequiredattributes.Enabled = true;
            btnaddrequireddocuments.Enabled = true;
            btnaddnamingconvention.Enabled = true;
        }

    }

  
}