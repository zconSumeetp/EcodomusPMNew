using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attributes;
using AttributeTemplate;
using EcoDomus.Session;
using System.Data;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;
using DisplayUnitType = AttributeTemplate.DisplayUnitType;
using EntityAttributeValueDto = AttributeTemplate.EntityAttributeValueDto;

public partial class App_Settings_AddRequiredAttributesNew : System.Web.UI.Page
{
    #region Global Variables Declarations
    string omniclass_detail_id = "";
    string[] ids;
    List<String> ls = new List<string>();
    string name = "";
    DataSet ds_types = new DataSet();
    #endregion
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        try
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

                        for (int i = 0; i < ls.Count; i++)
                        {
                            omniclass_detail_id = omniclass_detail_id + ls[i].ToString() + ",";

                        }
                        omniclass_detail_id = omniclass_detail_id.Substring(0, omniclass_detail_id.Length - 1);
                        
                        BindGroupList();
                        BindRequiredAttributeValues();
                        hf_attribute_value_id.Value = Guid.Empty.ToString();
                        BindRadComboBoxAttributeType();
                    }
                    catch (Exception ex)
                    {

                        throw ex;
                    }
                }
                if (!IsPostBack)
                {

                    //div_add_new.Visible = false;
                    BindGroupList();
                    BindRequiredAttributeValues();
                    // bind_uom();
                    hf_attribute_value_id.Value = Guid.Empty.ToString();

                    BindRadComboBoxAttributeType();

                }
            }
            else
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }

            var scriptManager = ScriptManager.GetCurrent(Page);
            scriptManager.Scripts.Add(new ScriptReference { Path = ResolveUrl("~/App/UserControls/PropertyValueControl/PropertyValueControl.js") });
            scriptManager.Scripts.Add(new ScriptReference { Path = ResolveUrl("~/App/UserControls/YesNoRadioControl/YesNoRadioControl.js") });
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    #endregion
    #region Private Methods
    protected override void InitializeCulture()
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                string culture = Session["Culture"].ToString();
                if (culture == null)
                {
                    culture = "en-US";
                }
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
            }
        }
        catch (Exception ex)
        {

            Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    protected void BindRequiredAttributeValues()
    {
        try
        {
            var am = new AttributeTemplateModel();
            var ac = new AttributeTemplateClient();
            var ds = new DataSet();
            if (cmb_attribute_group_list.SelectedValue == "")
            {
                am.Attribute_Group_Ids = Guid.Empty.ToString();
            }
            else
            {
                am.Attribute_Group_Ids = !String.IsNullOrEmpty(cmb_attribute_group_list.Text) ? cmb_attribute_group_list.FindItemByText(cmb_attribute_group_list.Text).Value : cmb_attribute_group_list.SelectedValue;
                
            }
            am.Attribute_template_id = Guid.Empty;
            am.Attribute_name = "";
            ds = ac.GetRequiredAttributesUnderGroup(am, SessionController.ConnectionString);
            rg_attribute.DataSource = ds;
            rg_attribute.DataBind();


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void navigate(object sender, EventArgs e)
    {
        BindRequiredAttributeValues();
    }
    protected void BindGroupList()
    {
        var am = new AttributeTemplateModel();
        var ac = new AttributeTemplateClient();
        var ds = new DataSet();

        try
        {
            am.Attribute_Group_Name = "";
            ds = ac.GetRequiredAttributeGroups(am, SessionController.ConnectionString);
            cmb_attribute_group_list.DataTextField = "group_name";
            cmb_attribute_group_list.DataValueField = "pk_required_attribute_group_id";
            cmb_attribute_group_list.DataSource = ds;
            cmb_attribute_group_list.DataBind();
            cmb_attribute_grp_list.DataTextField = "group_name";
            cmb_attribute_grp_list.DataValueField = "pk_required_attribute_group_id";
            cmb_attribute_grp_list.DataSource = ds;
            cmb_attribute_grp_list.DataBind();


        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    #endregion
    #region Event Handlers
    protected void btn_assign_click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                var am = new AttributeTemplateModel();
                var ac = new AttributeTemplateClient();
                am.Attribute_Group_Id = new Guid(cmb_attribute_group_list.SelectedValue.ToString());
                am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
                am.Omniclass_ids = omniclass_detail_id;
                am.Entity_id = new Guid(Request.QueryString["entity_id"].ToString());
                am.User_Id = new Guid(SessionController.Users_.UserId);
                ac.AssignAttributeGroupToTemplate(am, SessionController.ConnectionString);
                string str = cmb_attribute_group_list.SelectedItem.Text.ToString();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "SuccessPupup('" + str + "');", true);

                am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
                am.Omniclass_ids = omniclass_detail_id;
                am.Entity_id = new Guid(Request.QueryString["entity_id"].ToString());
                ds_types = ac.GetTypesIds(am, SessionController.ConnectionString);
                try
                {


                    if (ds_types.Tables[0].Rows.Count > 0)
                    {
                        am.User_Id = new Guid(SessionController.Users_.UserId);
                        am.Entity_id = new Guid(Request.QueryString["entity_id"].ToString());
                        am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
                        //am.Attribute_Group_Id = new Guid(cmb_attribute_group_list.SelectedValue.ToString());
                        for (int i = 0; i < ds_types.Tables[0].Rows.Count; i++)
                        {
                            string row_id = ds_types.Tables[0].Rows[i]["row_id"].ToString();
                            string omniclass_id = ds_types.Tables[0].Rows[i]["fk_omniclass_detail_id"].ToString();
                            string group_id = ds_types.Tables[0].Rows[i]["fk_required_attribute_group_id"].ToString();
                            am.Fk_row_id = new Guid(row_id);
                            am.Omniclass_id = new Guid(omniclass_id);
                            am.Attribute_Group_Id = new Guid(group_id);
                            am.Old_Attribute_Name = "";
                            am.New_Attribute_Name = "";
                            DataSet ds_1 = new DataSet();
                            ds_1 = ac.InsertAttributeToEntity(am, SessionController.ConnectionString);

                        }
                    }
                }
                catch (Exception ex)
                {

                    //throw;
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
    protected void btnUnAssign_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                var am = new AttributeTemplateModel();
                var ac = new AttributeTemplateClient();
                am.Attribute_Group_Id = new Guid(cmb_attribute_group_list.SelectedValue);
                am.Attribute_template_id = new Guid(Request.QueryString["templateId"]);
                am.Omniclass_ids = omniclass_detail_id;
                am.Entity_id = new Guid(Request.QueryString["entity_id"]);
                am.User_Id = new Guid(SessionController.Users_.UserId);
                //ac.AssignAttributeGroupToTemplate(am, SessionController.ConnectionString);
                string str = cmb_attribute_group_list.SelectedItem.Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "SuccessPupupUnAssign('" + str + "');", true);

                am.Attribute_template_id = new Guid(Request.QueryString["templateId"]);
                am.Omniclass_ids = omniclass_detail_id;
                am.Entity_id = new Guid(Request.QueryString["entity_id"]);
                ds_types = ac.GetTypesIds(am, SessionController.ConnectionString);
                try
                {
                    if (ds_types.Tables[0].Rows.Count > 0)
                    {
                        am.User_Id = new Guid(SessionController.Users_.UserId);
                        am.Entity_id = new Guid(Request.QueryString["entity_id"]);
                        am.Attribute_template_id = new Guid(Request.QueryString["templateId"]);
                        //am.Attribute_Group_Id = new Guid(cmb_attribute_group_list.SelectedValue.ToString());
                        for (int i = 0; i < ds_types.Tables[0].Rows.Count; i++)
                        {
                            string row_id = ds_types.Tables[0].Rows[i]["row_id"].ToString();
                            string omniclass_id = ds_types.Tables[0].Rows[i]["fk_omniclass_detail_id"].ToString();
                            //string group_id = ds_types.Tables[0].Rows[i]["fk_required_attribute_group_id"].ToString();
                            am.Fk_row_id = new Guid(row_id);
                            am.Omniclass_id = new Guid(omniclass_id);
                            //am.Attribute_Group_Id = new Guid(group_id);
                            am.Old_Attribute_Name = "";
                            am.New_Attribute_Name = "";
                            DataSet ds_1 = new DataSet();
                            ds_1 = ac.UnassignAttributesFromEntities(am, SessionController.ConnectionString);

                        }
                    }
                }
                catch (Exception ex)
                {

                    //throw;
                }

                //Unassign group attributes from Required attributes 

                try
                {
                    if (ds_types.Tables[0].Rows.Count > 0)
                    {
                        am.User_Id = new Guid(SessionController.Users_.UserId);
                        am.Entity_id = new Guid(Request.QueryString["entity_id"]);
                        am.Attribute_template_id = new Guid(Request.QueryString["templateId"]);
                        for (int i = 0; i < ds_types.Tables[0].Rows.Count; i++)
                        {   
                            string omniclass_id = ds_types.Tables[0].Rows[i]["fk_omniclass_detail_id"].ToString();
                            am.Omniclass_id = new Guid(omniclass_id);
                            var ds_required_attr = new DataSet();
                            ds_required_attr = ac.UnassignGroupAttributesFromRequiredAttributes(am, SessionController.ConnectionString);
                
                        }
                    }
                }
                catch (Exception)
                {
                    
                   // throw;
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
    protected void cmb_attribute_group_list_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        BindRequiredAttributeValues();
        hf_group_id.Value = cmb_attribute_group_list.SelectedItem.Value;
    }
    public void rdBtnAddExistingAttributes_CheckedChanged(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                div_add_existing.Visible = true;
                div_add_new.Visible = false;
                BindRequiredAttributeValues();
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

    public void rdBtnAddNewAttribtues_CheckedChanged(object sender, EventArgs e)
    {
        div_add_new.Visible = true;
        div_add_existing.Visible = false;
        //bind_uom();
    }

    protected void rg_attribute_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                BindRequiredAttributeValues();
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



    protected void rg_attribute_PageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                BindRequiredAttributeValues();
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

    protected void rg_attribute_SortCommand(object source, GridSortCommandEventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                BindRequiredAttributeValues();
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
    protected void btn_save_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                InsertUpdateAttribute();

                 if (rdBtnAddNewAttribtues.Checked)
                    {
                        div_add_existing.Visible = true;
                        div_add_new.Visible = false;
                        cmb_attribute_group_list.SelectedValue = cmb_attribute_grp_list.SelectedValue;
                        BindRequiredAttributeValues();
                        rdBtnAddExistingAttributes.Checked = true;
                        rdBtnAddNewAttribtues.Checked = false;
                        BindRadComboBoxAttributeType();
                    }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "switch", "AddRequiredAttributeNewShowAddExisting();", true);
        }
    }

    private void InsertUpdateAttribute()
    {

        var userId = new Guid(SessionController.Users_.UserId);
        using (var attributeClient = new AttributeTemplateClient())
        {
            var atvm = new AttributeTemplateViewModel { AttributeValueDto = new EntityAttributeValueDto() };
            atvm.AttributeValueDto.IntegerValue = PropertyValueControl.IntegerValue;
            atvm.AttributeValueDto.DoubleValue = PropertyValueControl.DoubleValue;
            atvm.AttributeValueDto.DateTimeValue = PropertyValueControl.DateTimeValue;
            atvm.AttributeValueDto.StringValue = PropertyValueControl.StringValue;

            atvm.AttributeType = PropertyValueControl.AttributeType.ToString();
            atvm.AttributeValueDto.DisplayUnitType = (DisplayUnitType?)PropertyValueControl.DisplayUnitType;

            atvm.GroupId = new Guid(cmb_attribute_grp_list.SelectedValue);
            atvm.AttributeName = txtaddattribute.Text;
            atvm.TemplateId = new Guid(Request.QueryString["templateId"]);
            atvm.UserId = userId;

            attributeClient.AddUpdateAttribute(SessionController.ConnectionString, atvm);
        }
    }

    protected void ibtn_close_Click(object sender, ImageClickEventArgs e)
    {

    }
    #endregion

    private void BindRadComboBoxAttributeType()
    {
        if (RadComboBoxAttributeType.Items.Count == 0)
        {
            AttributeTypeDto[] attributeTypes;
            using (var attributeClient = new AttributeClient())
            {
                attributeTypes = attributeClient.GetAttributeType();
            }
            RadComboBoxAttributeType.DataTextField = "AttributeType";
            RadComboBoxAttributeType.DataValueField = "AttributeType";
            RadComboBoxAttributeType.DataSource = attributeTypes;
        
            RadComboBoxAttributeType.DataBind();

            if (RadComboBoxAttributeType.Items.Count > 0)
                RadComboBoxAttributeType.Items[0].Selected = true;

            RadComboBoxAttributeType.SelectedValue = AttributeType.Text.ToString();

            PropertyValueControl.AttributeType = AttributeType.Text;
            var item = RadComboBoxAttributeType.Items.FindItemByText(RadComboBoxAttributeType.Text);
            var unitType = !string.IsNullOrEmpty(item.Attributes["UnitType"]) ? (Attributes.UnitType)Enum.Parse(typeof(Attributes.UnitType),
                item.Attributes["UnitType"]) : (Attributes.UnitType?)null;
            PropertyValueControl.UnitType = unitType;
        }
    }

    protected void Test_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        
    }

    protected void RadComboBoxAttributeType_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        PropertyValueControl.AttributeType = (AttributeType)Enum.Parse(typeof(AttributeType), RadComboBoxAttributeType.SelectedValue);
        var unitType = !string.IsNullOrEmpty(RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) ? (Attributes.UnitType)Enum.Parse(typeof(Attributes.UnitType), RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) : (Attributes.UnitType?)null;
        PropertyValueControl.UnitType = unitType;
    }

    protected void RadComboBoxAttributeType_OnItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        var attributeTypeDto = (AttributeTypeDto)e.Item.DataItem;
        e.Item.Attributes["UnitType"] = attributeTypeDto.UnitType.ToString();
        e.Item.Attributes["DataType"] = attributeTypeDto.DataType.ToString();
    }
}