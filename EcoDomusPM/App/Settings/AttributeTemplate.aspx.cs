using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;
using EcoDomus.Session; 
using AttributeTemplate;
using System.Data;
using Telerik.Web.UI;
using User;

public partial class App_Settings_AttributeTemplate : System.Web.UI.Page
{
    string ecodomus_user = "";
    string tempPageSize = "";
    bool flag = false;
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

    protected void Page_Load(object sender, EventArgs e)
    {

        if (SessionController.Users_.UserId != null)
        {
            CheckUser();
            if (!IsPostBack)
            {
                if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                }
                else
                {
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "template_name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgRequiredAttriTemplate.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    tradd.Visible = false;
                    hfUserPMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                    tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                    tempPageSize = Convert.ToString(Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids));
                    BindTemplate();
                }
            }
        }
        else
        {
            Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
        }
    }

    protected void btnAddTemplate_OnClick(object sender, EventArgs e)
    {
        try
        {
            //tradd.Visible = true;
            //txtName.Focus();

            //btnAddTemplate.Visible = false;
            //hftemplateid.Value = "00000000-0000-0000-0000-000000000000";
            //txtName.Text = "";
            //lbl_add.Text = "Add Template";
        }
        catch (Exception ex)
        {
            lblErrMsg.Text = "btnAddTemplate_OnClick:- " + ex.Message;
        }
    }

    protected void btnCancel_OnClick(object sender, EventArgs e)
    {
        tradd.Visible = false;
        btnAddTemplate.Visible = true;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            if (hftemplateid.Value == Guid.Empty.ToString())
            {
                am.Attribute_template_id = Guid.Empty;
            }
            else
            {
                am.Attribute_template_id = new Guid(hftemplateid.Value.ToString());
            }
            am.Template_name = txtName.Text;
            am.Organization_id = new Guid(SessionController.Users_.OrganizationID.ToString());
            am.User_Id = new Guid(SessionController.Users_.UserId.ToString());
            DataSet ds = new DataSet();
            ds = ac.InsertUpdateAttributeTemplate(am, SessionController.ConnectionString);
            if (ds.Tables[0].Rows[0]["id"].ToString() == Guid.Empty.ToString())
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
            }
            else
            {
                tradd.Visible = false;
                btnAddTemplate.Visible = true;
                BindTemplate();
                string id = ds.Tables[0].Rows[0]["id"].ToString();
                hftemplateid.Value = id;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void BindTemplate()
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            DataSet ds = new DataSet();
            am.Organization_id = new Guid(SessionController.Users_.OrganizationID.ToString());
            am.Search = txt_search.Text;
            ds = ac.GetAttributeTemplate(am, SessionController.ConnectionString);
            rgRequiredAttriTemplate.DataSource = ds;
            rgRequiredAttriTemplate.AllowCustomPaging = true;
            if (tempPageSize != "")
                rgRequiredAttriTemplate.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgRequiredAttriTemplate.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
            rgRequiredAttriTemplate.DataBind();
            
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgRequiredAttriTemplate_OnSortCommand(object source, GridSortCommandEventArgs e)
    {
        BindTemplate();
    }

    protected void rgRequiredAttriTemplate_OnPageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        BindTemplate();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
    }

    protected void rgRequiredAttriTemplate_OnPageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        BindTemplate();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
    }

    protected void btn_search_click(object sender, EventArgs e)
    {
        BindTemplate();
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        try
        {
            BindTemplate();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void CheckUser()
    {
        UserClient ctrl = new UserClient();
        UserModel mdl = new UserModel();
        mdl.UserId = new Guid(SessionController.Users_.UserId);
        ecodomus_user = ctrl.CheckEcoDomusUser(mdl);
    
    }

    protected void rgRequiredAttriTemplate_ItemDataBound(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridDataItem)
        {
            if (e.Item.Cells[4].Text == "Y")
            {
                if (ecodomus_user == "Y")
                {
                    e.Item.FindControl("lnkEdit").Visible = true;
                }
                else
                {
                    e.Item.FindControl("lnkEdit").Visible = false;
                }
                e.Item.FindControl("imgbtnDelete").Visible = false;
            }

            else
            {
                e.Item.FindControl("lnkEdit").Visible = true;
                e.Item.FindControl("imgbtnDelete").Visible = true;
            }
        }

        if (e.Item is Telerik.Web.UI.GridDataItem)
        {
            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    DataSet ds_component = SessionController.Users_.Permission_ds;
                    DataRow dr_component = ds_component.Tables[0].Select("name='Facility'")[0];
                    DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
                    foreach (DataRow dr_profile in dr_submenu_component)
                    {
                        if (dr_profile["name"].ToString() == "Attributes")
                        {
                            Permissions objPermission = new Permissions();
                            string delete_permission = dr_profile["delete_permission"].ToString();
                            string edit_permission = dr_profile["edit_permission"].ToString();
                            string name = string.Empty;
                            string name1 = string.Empty;
                            if (edit_permission == "N")
                            {
                                LinkButton lnkname = (LinkButton)e.Item.FindControl("lnkName");
                                name = lnkname.Text.ToString();
                                lnkname.Enabled = false;
                                lnkname.ResolveUrl(name.Replace("&nbsp;", ""));
                            }

                            else
                            {
                                LinkButton lnkname = (LinkButton)e.Item.FindControl("lnkName");
                                name = lnkname.Text.ToString();
                                lnkname.Enabled = true;
                                lnkname.ResolveUrl(name.Replace("&nbsp;", ""));
                            }
                        }
                    }
                }
            }
        }
    }

    protected void rgRequiredAttriTemplate_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        AttributeTemplateModel am = new AttributeTemplateModel();
        AttributeTemplateClient ac = new AttributeTemplateClient();
        //hftemplateid.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_attribute_template_id"].ToString();
        //am.Attribute_template_id = new Guid(hftemplateid.Value.ToString());
        if (e.Item is GridDataItem)
        {
            //if (e.CommandName == "Edit_")
            //{
            //    tradd.Visible = true;
            //    LinkButton lnbRegisterName = e.Item.FindControl("lnkName") as LinkButton;
            //    hftemplateid.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_attribute_template_id"].ToString();
            //    am.Attribute_template_id = new Guid(hftemplateid.Value.ToString());
            //    txtName.Text = lnbRegisterName.Text;
            //    lbl_add.Text = "Edit Template";
            //    btnAddTemplate.Visible = false;
            //}
            // else
            if (e.CommandName == "delete")
            {
                LinkButton lnbRegisterName = e.Item.FindControl("lnkName") as LinkButton;
                hftemplateid.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_attribute_template_id"].ToString();
                am.Attribute_template_id = new Guid(hftemplateid.Value.ToString());
                ac.DeleteattributeTemplate(am, SessionController.ConnectionString);
                BindTemplate();
            }
            else if (e.CommandName == "clonetemplate")
            {
                hftemplateid.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_attribute_template_id"].ToString();
                am.Attribute_template_id = new Guid(hftemplateid.Value.ToString());
                am.Organization_id = new Guid(SessionController.Users_.OrganizationID.ToString());
                am.User_Id = new Guid(SessionController.Users_.UserId.ToString());
                ac.CloneattributeTemplate(am, SessionController.ConnectionString);
                BindTemplate();
            }
            else if (e.CommandName == "selecttemplate")
            {
                LinkButton lnkbtn1 = e.Item.FindControl("lnkName") as LinkButton;
                hftemplateid.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_attribute_template_id"].ToString();
                am.Attribute_template_id = new Guid(hftemplateid.Value.ToString());
                string strGlobalFlag = e.Item.Cells[4].Text;
                Response.Redirect("~/app/settings/RequiredAttribute.aspx?RequiredAttributeTemplateId=" + hftemplateid.Value.ToString() + "&Name=" + lnkbtn1.Text + "&GlobalFlag=" + strGlobalFlag, false);
            }
        }
    }

    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            BindTemplate();
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
            DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
            foreach (DataRow dr_profile in dr_submenu_component)
            {
                if (dr_profile["name"].ToString() == "Attributes")
                {
                    SetPermissionToControl(dr_profile);
                }
            }
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

        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rgRequiredAttriTemplate.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }
        }
        else
        {
            foreach (GridDataItem item in rgRequiredAttriTemplate.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = true;
            }
        }


        if (edit_permission == "N")
        {

            foreach (GridDataItem item in rgRequiredAttriTemplate.MasterTableView.Items)
            {
                ImageButton btnclone = (ImageButton)item.FindControl("imgbtnClone");
                btnclone.Enabled = false;
            }
            btnAddTemplate.Enabled = false;
        }
        else
        {
            foreach (GridDataItem item in rgRequiredAttriTemplate.MasterTableView.Items)
            {
                ImageButton btnclone = (ImageButton)item.FindControl("imgbtnClone");
                btnclone.Enabled = true;
            }
            btnAddTemplate.Enabled = true;
        }


    }
}

