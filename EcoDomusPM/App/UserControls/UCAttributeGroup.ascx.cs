using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using AttributeTemplate;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;

public partial class App_UserControls_UCAttributeGroup : System.Web.UI.UserControl
{
    #region Global Variables Declarations
    string temp_id = "";
    #endregion
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            var hf_tab_click = (HiddenField)Page.FindControl("hf_tab_click");
            if (hf_tab_click.Value == "Y")
            {
                HiddenField hf_tempalte_id = (HiddenField)Page.FindControl("hfTemplate_id");
                HiddenField hf_flag_first = (HiddenField)Page.FindControl("hf_flag_first");
                temp_id = hf_tempalte_id.Value.ToString();
                if (!IsPostBack)
                {
                    Bind_Grid();

                }
                if (hf_flag_first.Value.ToString() == "Y")
                {

                    Bind_Grid();

                }
                tbl_add.Visible = false;
                tr_btn_add.Visible = true;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    #endregion
    #region Private Methods
    public void Bind_Grid()
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            DataSet ds = new DataSet();
            am.Attribute_Group_Name = txt_search.Text;
            ds = ac.GetRequiredAttributeGroups(am, SessionController.ConnectionString);

            if (ds.Tables.Count > 0)
            {
                rg_attribute_group.DataSource = ds;
                rg_attribute_group.DataBind();

            }
            HiddenField hf_flag_first = (HiddenField)Page.FindControl("hf_flag_first");
            hf_flag_first.Value = "N";
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }
    private void GoToNextTab()
    {

        RadTabStrip tabStrip = (RadTabStrip)Page.FindControl("RadTabStrip1");
        RadTab Attribute_detail = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", "Attribute_Details"));
        RadTab facility = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", "Attribute_Group"));
        Attribute_detail.Enabled = true;
        Attribute_detail.Selected = true;
        facility.Enabled = false;

        GoToNextPageView();

    }
    private void GoToNextPageView()
    {
        try
        {
            var multiPage = (RadMultiPage)Page.FindControl("RadMultiPage1");
            var PageView = multiPage.FindPageViewByID(@"~/App/UserControls/UCAttributeDetails.ascx");
            if(PageView != null)
                multiPage.PageViews.Remove(PageView);
            PageView = new RadPageView {ID = @"~/App/UserControls/UCAttributeDetails.ascx"};
            multiPage.PageViews.Add(PageView);
            PageView.Selected = true;

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    #endregion
    #region Event Handlers
    protected void btnAttributeGroup_Click(object source, EventArgs e)
    {
        try
        {
            tbl_add.Visible = true;
            tr_btn_add.Visible = false;
            txtAttributeGroupName.Text = "";

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {

        try
        {
            if (Page.IsValid)
            {
                int i = 0;
                foreach (GridDataItem item in rg_attribute_group.MasterTableView.Items)
                {

                    if (item.Selected == true)
                    {
                        i++;

                        HiddenField hf_group_ID = (HiddenField)Page.FindControl("hf_group_id");
                        hf_group_ID.Value = item.GetDataKeyValue("pk_required_attribute_group_id").ToString();
                        HiddenField hf_flag_first = (HiddenField)Page.FindControl("hf_flag_first");
                        hf_flag_first.Value = "Y";
                        HiddenField hf_flag = (HiddenField)Page.FindControl("hf_flag");
                        hf_flag.Value = "Y";
                        //HiddenField hf_tab_click = (HiddenField)Page.FindControl("hf_tab_click");
                        //hf_tab_click.Value = "N";
                    }
                }
                if (i == 1)
                {

                    GoToNextTab();
                }
                else
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "chkselect();", true);
                }
            }
        }

        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_attribute_group_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            Bind_Grid();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    protected void rg_attribute_group_PageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            Bind_Grid();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    protected void rg_attribute_group_SortCommand(object source, GridSortCommandEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            Bind_Grid();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    protected void rg_attribute_group_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            if (e.Item is GridDataItem)
            {
                if (e.CommandName == "Edit_")
                {
                    tbl_add.Visible = true;
                    hf_temp_group_id.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_required_attribute_group_id"].ToString();
                    am.Attribute_template_id = new Guid(hf_temp_group_id.Value);
                    txtAttributeGroupName.Text = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["group_name"].ToString();
                    tr_btn_add.Visible = false;

                }
                else if (e.CommandName == "delete")
                {

                    hf_temp_group_id.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_required_attribute_group_id"].ToString();
                    am.Attribute_Group_Id = new Guid(hf_temp_group_id.Value);
                    ac.DeleteRequiredAttributeGroup(am, SessionController.ConnectionString);
                    Bind_Grid();
                    hf_temp_group_id.Value = "";
                }

            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    protected void btn_save_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                AttributeTemplateModel am = new AttributeTemplateModel();
                AttributeTemplateClient ac = new AttributeTemplateClient();
                DataSet ds = new DataSet();
                if (hf_temp_group_id.Value == "" || hf_temp_group_id.Value == Guid.Empty.ToString())
                {
                    am.Attribute_Group_Id = Guid.Empty;
                }
                else
                {
                    am.Attribute_Group_Id = new Guid(hf_temp_group_id.Value);

                }
                am.Attribute_Group_Name = txtAttributeGroupName.Text;
                am.User_Id = new Guid(SessionController.Users_.UserId);
                ds = ac.InsertUpdateAttributeGroup(am, SessionController.ConnectionString);
                if (ds.Tables[0].Rows[0]["id"] == Guid.Empty.ToString())
                {


                }
                else
                {
                    Bind_Grid();
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
    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        tr_btn_add.Visible = true;
        tbl_add.Visible = false;
        hf_temp_group_id.Value = "";
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                Bind_Grid();
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    protected void lbtn_next_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                int i = 0;
                foreach (GridDataItem item in rg_attribute_group.MasterTableView.Items)
                {

                    if (item.Selected == true)
                    {
                        i++;

                        var hfGroupId = (HiddenField)Page.FindControl("hf_group_id");
                        hfGroupId.Value = item.GetDataKeyValue("pk_required_attribute_group_id").ToString();
                        var hfFlagFirst = (HiddenField)Page.FindControl("hf_flag_first");
                        hfFlagFirst.Value = "Y";
                        var hfFlag = (HiddenField)Page.FindControl("hf_flag");
                        hfFlag.Value = "Y";
                    }
                }
                if (i == 1)
                {

                    GoToNextTab();
                }
                else
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "chkselect();", true);
                }
            }
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void lbtn_back_Click(object sender, EventArgs e)
    {

    }
    protected void ibtn_back_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void ibtn_next_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                int i = 0;
                foreach (GridDataItem item in rg_attribute_group.MasterTableView.Items)
                {

                    if (item.Selected == true)
                    {
                        i++;

                        HiddenField hf_group_ID = (HiddenField)Page.FindControl("hf_group_id");
                        hf_group_ID.Value = item.GetDataKeyValue("pk_required_attribute_group_id").ToString();
                        HiddenField hf_flag_first = (HiddenField)Page.FindControl("hf_flag_first");
                        hf_flag_first.Value = "Y";
                        HiddenField hf_flag = (HiddenField)Page.FindControl("hf_flag");
                        hf_flag.Value = "Y";
                        //HiddenField hf_tab_click = (HiddenField)Page.FindControl("hf_tab_click");
                        //hf_tab_click.Value = "N";
                    }
                }
                if (i == 1)
                {

                    GoToNextTab();
                }
                else
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "chkselect();", true);
                }
            }
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void OnClick_BtnSearch(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                Bind_Grid();
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
    #endregion
}