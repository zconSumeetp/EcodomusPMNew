using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AttributeTemplate;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.Data;
using System.Threading;
using System.Globalization;

public partial class App_Settings_AddEditRequiredAttributes : System.Web.UI.Page
{
    string update_flag = "";
    string group_flag = "";
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
            if (Request.QueryString["Name"] != null)
            {
                if (Request.QueryString["Name"].ToString() != "")
                {
                    lbl_omniclass_name.Text = Request.QueryString["Name"].ToString().Replace('�', ' ');
                }
            }
            if (!IsPostBack)
            {
                
                lblmsg.Text = "";
                //lblError.Visible = false;
                tradd.Visible = false;
                bind_uom();
                BindRequiredAttributeValues();
            }
        }
        else
        {
        }
    }

    protected void bind_uom()
    {
        AttributeTemplateModel am = new AttributeTemplateModel();
        AttributeTemplateClient ac = new AttributeTemplateClient();
        DataSet ds = new DataSet();
        try
        {
            ds = ac.BindUOM(SessionController.ConnectionString);
            cmbox_uom_list.DataTextField = "unit";
            cmbox_uom_list.DataValueField = "pk_unit_of_measurement_id";
            cmbox_uom_list.DataSource = ds;
            cmbox_uom_list.DataBind();

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void btn_Save_click(object sender, EventArgs e)
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            DataSet ds = new DataSet();
            if (hfattributeid.Value == Guid.Empty.ToString())
            {
                am.Attributeid = Guid.Empty;
                update_flag = "N";
            }
            else
            {
                am.Attributeid = new Guid(hfattributeid.Value.ToString());
                update_flag = "Y";
            }
            am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());

            am.Omniclass_ids = Request.QueryString["omniclass_detail_id"].ToString();


            am.EntityID = new Guid(Request.QueryString["entity_id"].ToString());
            am.UOM_id = new Guid(cmbox_uom_list.SelectedValue.ToString());
            am.Attribute_name = txtaddattribute.Text;
            am.Abbreviation = txtAbbrivations.Text;
            am.Attribute_Value = txtValue.Text;
            am.User_Id = new Guid(SessionController.Users_.UserId.ToString());
            if (hf_group_id.Value != "")
            {
                am.Attribute_Group_Id = new Guid(hf_group_id.Value);
                if (hf_group_id.Value == Guid.Empty.ToString())
                {
                    group_flag = "N";
                }
                else
                {
                    group_flag = "Y";
                }
            }
            else
            {
                am.Attribute_Group_Id = Guid.Empty;
                group_flag = "N";
            }

            ds = ac.InsertRequiredAttribute(am, SessionController.ConnectionString);



            if (ds.Tables[1].Rows[0]["flag"].ToString() == "Y")
            {
                lblmsg.Visible = true;
                lblmsg.Text = "This required attribute is already present.";
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "displayErrormsg("+lblError.Text+");", true);
            }
            else
            {

                DataSet ds_types = new DataSet();
                am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
                if (group_flag == "Y")
                {
                    for (int k = 0; k < ds.Tables[2].Rows.Count; k++)
                    {
                        am.Omniclass_ids = ds.Tables[2].Rows[k]["fk_omniclass_id"].ToString();
                        am.Entity_id = new Guid(ds.Tables[2].Rows[k]["fk_entity_id"].ToString());
                        ds_types = ac.GetTypesIds(am, SessionController.ConnectionString);
                        try
                        {
                            if (ds_types.Tables[0].Rows.Count > 0)
                            {
                                am.User_Id = new Guid(SessionController.Users_.UserId);
                                for (int i = 0; i < ds_types.Tables[0].Rows.Count; i++)
                                {
                                    string row_id = ds_types.Tables[0].Rows[i]["row_id"].ToString();
                                    string omniclass_id = ds_types.Tables[0].Rows[i]["fk_omniclass_detail_id"].ToString();
                                    string group_id = ds_types.Tables[0].Rows[i]["fk_required_attribute_group_id"].ToString();
                                    am.Fk_row_id = new Guid(row_id);
                                    am.Omniclass_id = new Guid(omniclass_id);
                                    am.Attribute_Group_Id = new Guid(group_id);
                                    am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
                                    am.Omniclass_ids = Request.QueryString["omniclass_detail_id"].ToString();
                                    am.Entity_id = new Guid(ds.Tables[2].Rows[k]["fk_entity_id"].ToString());
                                    if (update_flag == "Y")
                                    {
                                        am.Old_Attribute_Name = ds.Tables[0].Rows[0]["old_attribute_name"].ToString();
                                        am.New_Attribute_Name = txtaddattribute.Text;
                                    }
                                    else
                                    {
                                        am.Old_Attribute_Name = "";
                                        am.New_Attribute_Name = "";
                                    }
                                    DataSet ds_1 = new DataSet();
                                    ds_1 = ac.InsertAttributeToEntity(am, SessionController.ConnectionString);

                                }
                            }
                        }
                        catch (Exception ex)
                        {

                            // throw;
                        }
                    }

                }
                else
                {
                    am.Omniclass_ids = Request.QueryString["omniclass_detail_id"].ToString();
                    am.Entity_id = new Guid(Request.QueryString["entity_id"].ToString());
                    ds_types = ac.GetTypesIds(am, SessionController.ConnectionString);
                    try
                    {
                        if (ds_types.Tables[0].Rows.Count > 0)
                        {
                            am.User_Id = new Guid(SessionController.Users_.UserId);
                            for (int i = 0; i < ds_types.Tables[0].Rows.Count; i++)
                            {
                                string row_id = ds_types.Tables[0].Rows[i]["row_id"].ToString();
                                string omniclass_id = ds_types.Tables[0].Rows[i]["fk_omniclass_detail_id"].ToString();
                                string group_id = ds_types.Tables[0].Rows[i]["fk_required_attribute_group_id"].ToString();
                                am.Fk_row_id = new Guid(row_id);
                                am.Omniclass_id = new Guid(omniclass_id);
                                am.Attribute_Group_Id = new Guid(group_id);
                                am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
                                am.Omniclass_ids = Request.QueryString["omniclass_detail_id"].ToString();
                                am.Entity_id = new Guid(Request.QueryString["entity_id"].ToString());
                                if (update_flag == "Y")
                                {
                                    am.Old_Attribute_Name = ds.Tables[0].Rows[0]["old_attribute_name"].ToString();
                                    am.New_Attribute_Name = txtaddattribute.Text;
                                }
                                else
                                {
                                    am.Old_Attribute_Name = "";
                                    am.New_Attribute_Name = "";
                                }
                                DataSet ds_1 = new DataSet();
                                ds_1 = ac.InsertAttributeToEntity(am, SessionController.ConnectionString);

                            }
                        }
                    }
                    catch (Exception ex)
                    {

                        //  throw;
                    }
                }
            }

            tradd.Visible = false;
            BindRequiredAttributeValues();

            traddclose.Visible = true;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void BindRequiredAttributeValues()
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            DataSet ds = new DataSet();
            if (Request.QueryString["templateId"] != null)
            {
                am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
            }
            if (Request.QueryString["entity_id"] != null)
            {
                am.EntityID = new Guid(Request.QueryString["entity_id"].ToString());
            }
            if (Request.QueryString["omniclass_detail_id"] != null)
            {
                am.Omniclass_id = new Guid(Request.QueryString["omniclass_detail_id"].ToString());
            }
            if (Request.QueryString["attribute_name"] != null)
            {
                if (update_flag == "Y")
                {

                    am.Attribute_name = txtaddattribute.Text;
                }
                else
                {
                    am.Attribute_name = Request.QueryString["attribute_name"].ToString();
                }
            }
            ds = ac.BindRequiredAttributeValues(am, SessionController.ConnectionString);

            if (ds.Tables[0].Rows.Count > 0)
            {

                rgAttribute.DataSource = ds;
                rgAttribute.DataBind();
                rgAttribute.Visible = true;
                lblError.Text = "";

            }

            else
            {
                rgAttribute.DataSource = ds;
                rgAttribute.DataBind();
                rgAttribute.Visible = true;
                lblError.Text = "There are no required attribute for this Class";
                //rgAttribute.Visible = false;

            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btn_add_click(object sender, EventArgs e)
    {

        tradd.Visible = true;
        txtaddattribute.Text = "";
        txtAbbrivations.Text = "";
        lblmsg.Text = "";
        if (cmbox_uom_list.SelectedValue != Guid.Empty.ToString())
        {
            cmbox_uom_list.SelectedValue = Guid.Empty.ToString();
            cmbox_uom_list.ClearSelection();
        }
        traddclose.Visible = false;
        hfattributeid.Value = Guid.Empty.ToString();
    }

    protected void btn_cancel_click(object sender, EventArgs e)
    {
        tradd.Visible = false;
        traddclose.Visible = true;
        //btn_add.Visible = true;
        //bnt_close.Visible = true;
    }

    protected void rgAttribute_OnPageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        BindRequiredAttributeValues();
    }

    protected void rgAttribute_OnPageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindRequiredAttributeValues();
    }

    protected void rgAttribute_OnSortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        BindRequiredAttributeValues();
    }

    protected void rgAttribute_OnItemCommand(object source, GridCommandEventArgs e)
    {
        try
        {
            AttributeTemplateModel am = new AttributeTemplateModel();
            AttributeTemplateClient ac = new AttributeTemplateClient();
            if (e.Item is GridDataItem)
            {
                if (e.CommandName == "deleteattributes")
                {
                    DataSet ds = new DataSet();
                    LinkButton lnkPkRequiredAttributeTemplateValueId = e.Item.FindControl("lnkDelete") as LinkButton;
                    LinkButton lnkPkRequiredAttributeTemplateValueIdForDelete = e.Item.FindControl("lnkDelete") as LinkButton;
                    am.Attributeid = new Guid(lnkPkRequiredAttributeTemplateValueIdForDelete.Text);
                    ac.DeleteRequiredttribute(am, SessionController.ConnectionString);
                    BindRequiredAttributeValues();
                    lblmsg.Text = "";
                }
                else if (e.CommandName == "editTemplate")
                {
                    tradd.Visible = true;
                    LinkButton lnkPkRequiredAttributeTemplateValueId = e.Item.FindControl("lnkPkattribute_value_id") as LinkButton;
                    DataSet ds = new DataSet();
                    am.Attributeid = new Guid(lnkPkRequiredAttributeTemplateValueId.Text);
                    ds = ac.GetRequiredAttributeId(am, SessionController.ConnectionString);
                    hfattributeid.Value = lnkPkRequiredAttributeTemplateValueId.Text;
                    txtaddattribute.Text = ds.Tables[0].Rows[0]["attribute_name"].ToString();
                    txtAbbrivations.Text = ds.Tables[0].Rows[0]["abbreviation"].ToString();
                    txtValue.Text = ds.Tables[0].Rows[0]["value"].ToString();
                    cmbox_uom_list.SelectedValue = ds.Tables[0].Rows[0]["fk_uom_id"].ToString();
                    hf_group_id.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["fk_required_attribute_group_id"].ToString();
                    traddclose.Visible = false;
                    lblmsg.Text = "";
                    update_flag = "Y";
                }
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "rgAttribute_OnItemCommand:- " + ex.Message;
        }
    }
}