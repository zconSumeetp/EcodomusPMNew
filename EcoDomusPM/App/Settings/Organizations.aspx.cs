using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Login;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;


public partial class App_Settings_Organizations : System.Web.UI.Page
{
    #region Global variable declaration
    DataSet ds = new DataSet();
    string tempPageSize = "";
    bool flag = false;
    #endregion
  
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            txtSearch.Attributes.Add("onKeyPress", "doClick('" + btnSearch.ClientID + "',event)");
            if (SessionController.Users_.UserId != null)
            {

                if (!IsPostBack)
                {
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    RgOrganizations.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                    BindOrganizationTypes();
                    hfOrgnizatioPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    BindOrganizations();

                }
            }
            else
            {
                Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Page_Load:- " + ex.Message.ToString();
        }
    }

    //protected void Page_PreInit(object sender, EventArgs e)
    //{
    //    if (Request.QueryString["flag"] == "nomaster")
    //    {
    //        Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";
    //    }
    //}
    
    #endregion

    #region My Methods

    protected override void InitializeCulture()
    {
        string culture = Session["Culture"].ToString();
        if (culture == null)
        {
            culture = "en-US";
        }
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
    }


    //To bind all organization types
    private void BindOrganizationTypes()
    {
        DataSet ds = new DataSet();
        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
        Organization.OrganizationModel mdl = new Organization.OrganizationModel();
        ds = obj_ctrl.GetOrganizationType();
        cmbOrganizationType.DataTextField = "name";
        cmbOrganizationType.DataValueField = "organization_type_id";
        cmbOrganizationType.DataSource = ds;
        cmbOrganizationType.DataBind();
    }

    //To bind organization grid according to org.type and search text.
    private void BindOrganizations()
    {
        try
        {

            DataSet ds = new DataSet();
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            mdl.OrganizationType_Id = new Guid(cmbOrganizationType.SelectedValue);
            mdl.txt_Search = txtSearch.Text;
            ds = obj_ctrl.GetOrganization(mdl);
          
            if (ds.Tables.Count > 0)
            {

                RgOrganizations.DataSource = ds;
                ViewState["OrganizationData"] = ds;
                BindOrganizationData(ref ds);
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = "BindOrganizations:- " + ex.Message.ToString();
        }
    }

    void ReBindOrganization()
    {
        try
        {
            DataSet ds;
            ds = (DataSet)ViewState["OrganizationData"];
            BindOrganizationData(ref ds);
        }
        catch (Exception ex)
        {
            lblMessage.Text = "ReBindOrganization:- " + ex.Message.ToString();
        }

    }

    private void BindOrganizationData(ref DataSet ds)
    {
        RgOrganizations.AllowCustomPaging = true;
        if (tempPageSize != "")
            RgOrganizations.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
        RgOrganizations.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
        if (ds.Tables.Count > 0)
        {
            RgOrganizations.DataSource = ds;
            RgOrganizations.DataBind();
        }
    }
    #endregion

    #region Event Handlers

    protected void RgOrganizations_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {

            if (e.Item is GridPagerItem)
            {

                RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                cb.Items.Sort(new PagerRadComboBoxItemComparer());
                if (tempPageSize != "")
                {
                    cb.Items.FindItemByValue(tempPageSize).Selected = true;
                }
            }


            //condiation binds header tool tip
            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in RgOrganizations.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                    if (column is GridButtonColumn)
                    {
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                    if (column is GridTemplateColumn)
                    {
                        ////if the sorting feature of the grid is enabled
                        if (column.HeaderText != "" && column.UniqueName == "delete")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                }
            }

            if (e.Item is GridDataItem)
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                foreach (GridColumn column in RgOrganizations.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null)
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                        }
                    }
                    else if (column is GridButtonColumn)
                    {

                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "Name")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());

                    }

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    
    }

    protected void RgOrganizations_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        ReBindOrganization();
        flag = false;
    }
    protected void RgOrganizations_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        tempPageSize = e.NewPageSize.ToString();
        if (!flag)
        {
            flag = true;
            ReBindOrganization();
        }
       
    }
    protected void cmbOrganizationType_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        BindOrganizations();

    }
    protected void OnItemCommand_RgOrganizations(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "EditOrganization")
        {

            string Organization_Id;
            string user_role=e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Role"].ToString();
            Organization_Id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ID"].ToString();
            string primary_contact = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["primary_contact"].ToString();
            string Organization_Name = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["name"].ToString();

            Response.Redirect("~/App/Settings/SettingsMenu.aspx?organization_id=" + Organization_Id.ToString() + "&IsfromClient=N&user_role=" + user_role + "&UserId=" + primary_contact + "&Organization_name=" + Organization_Name, false);
            //Response.Redirect("OrganizationProfile.aspx");
        }

        if (e.CommandName == "RemoveOrganization")
        {
            try
            {
                Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
                Organization.OrganizationModel mdl = new Organization.OrganizationModel();
               // mdl.Organization_Id = new Guid(Request.QueryString["Organization_Id"].ToString());
                mdl.Organization_Id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ID"].ToString());
                obj_ctrl.DeleteOrganization(mdl);
                BindOrganizations();
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Delete", "getQueryVariable();", true);
                // Response.Redirect("~/App/Settings/SettingsMenu.aspx");

            }
            catch (Exception ex)
            {
                lblMessage.Text = "RemoveOrganization" + ex.Message.ToString();
            }
        }
    }
    protected void RgOrganizations_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        ReBindOrganization();
    }
    protected void btnNewOrganization_Click(object sender, EventArgs e)
    {
        Session["OrganizationId"] = "00000000-0000-0000-0000-000000000000";

        Response.Redirect("~/App/Settings/SettingsMenu.aspx?organization_id=00000000-0000-0000-0000-000000000000&IsfromClient=N", false);
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {

        try
        {
            BindOrganizations();
        }
        catch (Exception ex)
        {
            Response.Write("btnSearch_Click:-" + ex.Message.ToString());
        }
    }
    #endregion

  
}