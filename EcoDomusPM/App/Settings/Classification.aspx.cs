using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using EcoDomus.Session;
using Organization;
using AttributeTemplate;
using System.Threading;
using System.Globalization;

public partial class App_Settings_Classification : System.Web.UI.Page
{
    /// Page load
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            calculate_page_size();
            bindEntities();
            bindEntities_classification_details();
        }
    }

    /// cross culture 
    /// 
    /// </summary>
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

    /// Page redirection method
    /// 
    /// </summary>
    /// <param name="url"></param>
    public void redirect_page(string url)
    {
        Response.Redirect(url, false);
    }

    /// Dynamic page size calculation
    /// 
    /// </summary>
    protected void calculate_page_size()
    {
        int page_size;
        int.TryParse(SessionController.Users_.DefaultPageSizeGrids, out page_size);
        if (page_size != 0)
        {
            page_size = page_size + 3;
        }
        hfClassificationPageSize.Value = Convert.ToString(page_size);
    }

    /// Bind entity dropdown 
    /// 
    /// </summary>
    private void bindEntities()
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            DataSet ds = new DataSet();
            try
            {
                am.Flag = "MI template";
                ds = ac.BindEntity(am, SessionController.ConnectionString);
                cmbentity.DataSource = ds;
                cmbentity.DataTextField = "entity_name";
                cmbentity.DataValueField = "pk_entity_id";
                cmbentity.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        catch (Exception)
        {

            throw;
        }
    }

    /// Bind entity dropdown for classification details 
    /// 
    /// </summary>
    private void bindEntities_classification_details()
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            DataSet ds = new DataSet();
            try
            {
                am.Flag = "MI template";
                ds = ac.BindEntity(am, SessionController.ConnectionString);
                cmb_select_entity.DataSource = ds;
                cmb_select_entity.DataTextField = "entity_name";
                cmb_select_entity.DataValueField = "pk_entity_id";
                cmb_select_entity.DataBind();
                cmb_select_entity.SelectedIndex = 0;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        catch (Exception)
        {

            throw;
        }
    }

    #region User defined events
    /// Close rad window and refresh grid
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_close_Click(object sender, EventArgs e)
    {
        txt_standard_code.Text = "";
        txt_Standard_name.Text = "";
        txt_standard_details_name.Text = "";
        rg_classification.Rebind();
        // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script1", "AssignSpace_popup();", true);
    }

    /// save new standard in tbl_standard
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_save_standard_click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            OrganizationClient cli = new OrganizationClient();
            OrganizationModel mdl = new OrganizationModel();
            mdl.Name = txt_Standard_name.Text;
            mdl.Organization_Id = new Guid(Request.QueryString["Organization_Id"]);
            ds = cli.Insert_custom_standard(mdl);
            txt_Standard_name.Text = "";
            rg_classification.Rebind();

        }
        catch (Exception)
        {

            throw;
        }
    }

    ///  save new standard details in tbl_standard_details
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_save_standard_details_click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            Guid standard_id = new Guid(hf_pk_standard_id.Value);
            OrganizationClient cli = new OrganizationClient();
            OrganizationModel mdl = new OrganizationModel();
            mdl.Standard_id = standard_id;
            mdl.Standard_details_name = txt_standard_details_name.Text.Trim();
            mdl.Standard_details_code = txt_standard_code.Text.Trim();
            mdl.Entity_id = new Guid(cmbentity.SelectedValue);
            ds = cli.Insert_custom_standard_details(mdl);
            string response_msg = Convert.ToString(ds.Tables[0].Rows[0]["response"]);
            if (response_msg == "Already exists")
                lbl_msg.Text = "Record already exists..";
            else
                lbl_msg.Text = "Record inserted..";

            txt_standard_code.Text = string.Empty;
            txt_standard_details_name.Text = string.Empty;
            txt_standard_code.Focus();

        }
        catch (Exception)
        {

            throw;
        }
    }

    #endregion

    //#region Grid events
    /// NeedDataSource gets called on every rebind 
    /// 
    /// </summary>
    protected void rg_classification_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        if (!e.IsFromDetailTable)
        {
            DataSet ds_classification = new DataSet();
            OrganizationClient cli = new OrganizationClient();
            OrganizationModel mdl = new OrganizationModel();
            mdl.Organization_Id = new Guid(Request.QueryString["Organization_Id"]);
            ds_classification = cli.Get_organization_standards(mdl);
            rg_classification.DataSource = ds_classification;
            int pagesize;
            int.TryParse(hfClassificationPageSize.Value, out pagesize);
            if (pagesize != 0)
                rg_classification.PageSize = pagesize;
            else
                rg_classification.PageSize = 10;

        }
    }

    /// bind internal grid 
    /// 
    /// </summary>
    protected void rg_classification_DetailTableDataBind(object source, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "space_id"://binding different entity types to inner grid 
                {

                    break;
                }



        }
    }

    /// PreRender event for grid 
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rg_classification_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //rg_MI_report.MasterTableView.Items[0].Expanded = true;
            //rg_MI_report.MasterTableView.Items[0].ChildItem.NestedTableViews[0].Items[0].Expanded = true;
            //RadGrid1.MasterTableView.Items[1].Expanded = true;
        }
    }

    /// Grid ItemCommand event
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rg_classification_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "details")
        {
            GridDataItem ditem = (GridDataItem)e.Item;
            string pk_standard_id = ditem["pk_standard_id"].Text;
            //hf_pk_standard_id.Value
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script1", "Classification_details_popup('" + pk_standard_id + "');", true);
            return;
        }
        if (e.CommandName == "delete")
        {
            GridDataItem ditem = (GridDataItem)e.Item;
            Guid pk_standard_id = new Guid(ditem["pk_standard_id"].Text);
            DataSet ds = new DataSet();
            OrganizationClient cli = new OrganizationClient();
            OrganizationModel mdl = new OrganizationModel();
            mdl.Standard_id = pk_standard_id;
            ds = cli.Delete_custom_standard(mdl);

            return;
        }
        if (e.CommandName == "standard_details")
        {
            GridDataItem ditem = (GridDataItem)e.Item;
            string pk_standard_id = ditem["pk_standard_id"].Text;
            string flag = ditem["Default_standard"].Text;
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script1", "Show_classification_details_popup('" + pk_standard_id + "','" + flag + "');", true);

        }

    }

    /// Item data bound event for manupulating the objects dynamically 
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rg_classification_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem ditem = (GridDataItem)e.Item;
            string flag = ditem["Default_standard"].Text;
            if (flag == "Y")
            {
                e.Item.FindControl("btn_delete").Visible = false;
                e.Item.FindControl("btn_Assign_Standard_Details").Visible = false;
            }

        }
    }

    //#endregion


    /// NeedDataSource gets called on every rebind 
    /// 
    /// </summary>
    protected void rg_classification_details_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        if (!e.IsFromDetailTable)
        {
            DataSet ds_classification_details = new DataSet();
            OrganizationClient cli = new OrganizationClient();
            OrganizationModel mdl = new OrganizationModel();
            Guid standard_id;
            if (hf_pk_standard_id.Value != "" && hf_pk_standard_id.Value != null)
            {
                standard_id = new Guid(hf_pk_standard_id.Value);
            }
            else
            {
                standard_id = Guid.Empty;
            }
            mdl.Standard_id = standard_id;
            mdl.txt_Search = txt_search.Text.Trim();
            mdl.Entity_id = new Guid(cmb_select_entity.SelectedValue);
            ds_classification_details = cli.Get_Custom_Standard_Details(mdl);
            rg_classification_details.DataSource = ds_classification_details;

        }
    }

    /// bind internal grid 
    /// 
    /// </summary>
    protected void rg_classification_details_DetailTableDataBind(object source, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "space_id"://binding different entity types to inner grid 
                {

                    break;
                }



        }
    }

    /// PreRender event for grid 
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rg_classification_details_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //rg_MI_report.MasterTableView.Items[0].Expanded = true;
            //rg_MI_report.MasterTableView.Items[0].ChildItem.NestedTableViews[0].Items[0].Expanded = true;
            //RadGrid1.MasterTableView.Items[1].Expanded = true;
        }
    }

    /// Grid ItemCommand event
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rg_classification_details_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "delete_detail")
        {
            GridDataItem ditem = (GridDataItem)e.Item;
            string standard_id = ditem["CategoryID"].Text;
            DataSet ds = new DataSet();
            OrganizationClient cli = new OrganizationClient();
            OrganizationModel mdl = new OrganizationModel();
            mdl.Standard_ids = standard_id;
            ds = cli.Delete_Custom_Standard_Details(mdl);
            rg_classification_details.Rebind();
            return;
        }


    }

    /// Item data bound event for manupulating the objects dynamically 
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rg_classification_details_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            if (hf_default_standard.Value == "Y")
                e.Item.FindControl("btn_delete_detail").Visible = false;
        }
    }


    /// regresh details grid
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_refresh_details_grid_Click(object sender, EventArgs e)
    {
        rg_classification_details.Rebind();
    }

    /// Detail grid search functionality
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btn_search_click(object sender, EventArgs e)
    {
        rg_classification_details.Rebind();
    }
}