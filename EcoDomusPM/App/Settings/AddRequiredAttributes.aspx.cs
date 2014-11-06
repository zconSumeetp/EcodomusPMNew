using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attributes;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.Data;
using System.Threading;
using System.Globalization;
using AttributeTemplate;
using DisplayUnitType = AttributeTemplate.DisplayUnitType;
using EntityAttributeValueDto = AttributeTemplate.EntityAttributeValueDto;
using UnitType = Attributes.UnitType;


public partial class App_Settings_AddRequiredAttributes : System.Web.UI.Page
{
    #region Global Variables
    string group_id = "";
    List<String> _ls = new List<string>();
    string[] ids;
    string update_flag = "";

    public object DataItem
    {
        get;
        set;
    }
    
    #endregion


   
   
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (Request.QueryString["templateId"] != null)
            {
                if (Request.QueryString["templateId"] != "")
                {
                    group_id = Request.QueryString["group_id"];
                    lblGroupName.Text = Request.QueryString["Name"];


                }
            }
            if (!IsPostBack)
            {

                BindRadComboBoxAttributeType();
                BindPropertyValue();
                if (Request.QueryString["attribute_id"] != null)
                {
                    hf_attribute_id.Value = Request.QueryString["attribute_id"];
                    BindAttributeFileds(hf_attribute_id.Value);
                }
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
            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }
    }

    public void redirect_page(string url)
    {
        Response.Redirect(url, false);
    }
    protected void BindAttributeFileds(string attribute_id)
    {
        var ac = new AttributeTemplateClient();
        try
        {
            AttributeTemplateViewModel atvm = ac.GetEditableAttributeFields(SessionController.ConnectionString, new Guid(attribute_id), new Guid(Request.QueryString["group_id"]));
            
            txtaddattribute.Text = atvm.AttributeName;
            txtAbbrivations.Text = atvm.Description;
            if (!String.IsNullOrEmpty(atvm.AttributeType))
            {
                var item = RadComboBoxAttributeType.Items.FindItemByText(atvm.AttributeType);
                item.Selected = true;
                PropertyValueControl.AttributeType = (AttributeType)Enum.Parse(typeof(AttributeType), atvm.AttributeType);
            }
            
            PropertyValueControl.DisplayUnitType =  (Attributes.DisplayUnitType?) atvm.AttributeValueDto.DisplayUnitType;
            PropertyValueControl.StringValue = atvm.AttributeValueDto.StringValue;
            PropertyValueControl.DoubleValue = atvm.AttributeValueDto.DoubleValue;
            PropertyValueControl.IntegerValue = atvm.AttributeValueDto.IntegerValue;
            PropertyValueControl.DateTimeValue = atvm.AttributeValueDto.DateTimeValue;

            
            
            var unitType = !string.IsNullOrEmpty(RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) ? (UnitType)Enum.Parse(typeof(UnitType), RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) : (UnitType?)null;
            PropertyValueControl.UnitType = unitType;
            
            
            BindPropertyValueUpdate();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void bind_uom()
    {
        
    }
    #endregion
    #region Event Handlers
    protected void btnAdd_Click(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                    InsertUpdateAttribute();

                    lblMsgSuccess.Visible = true;
                    lblMsgSuccess.Text = "Attribute with name " + "'" + txtaddattribute.Text + "'" + " is saved succesfully!";

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

    private void InsertUpdateAttribute()
    {

        var userId = new Guid(SessionController.Users_.UserId);
        using (var attributeClient = new AttributeTemplateClient())
        {
            var atvm = new AttributeTemplateViewModel {AttributeValueDto = new EntityAttributeValueDto()};
            atvm.AttributeValueDto.IntegerValue = PropertyValueControl.IntegerValue;
            atvm.AttributeValueDto.DoubleValue = PropertyValueControl.DoubleValue;
            atvm.AttributeValueDto.DateTimeValue = PropertyValueControl.DateTimeValue;
            atvm.AttributeValueDto.StringValue = PropertyValueControl.StringValue;

            atvm.AttributeType = PropertyValueControl.AttributeType.ToString();
            atvm.AttributeValueDto.DisplayUnitType = (DisplayUnitType?) PropertyValueControl.DisplayUnitType;

            atvm.GroupId = new Guid(group_id);
            atvm.AttributeName = txtaddattribute.Text;
            atvm.TemplateId = new Guid(Request.QueryString["templateId"]);
            atvm.UserId = userId;
             
            attributeClient.AddUpdateAttribute(SessionController.ConnectionString, atvm);
        }
    }

    protected void btnclose_Click(object sender, EventArgs e)
    {

    }
    protected void ibtn_close_Click(object sender, ImageClickEventArgs e)
    {

    }
    #endregion

    private void BindRadComboBoxAttributeType()
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
    }

    private void BindPropertyValue()
    {
        PropertyValueControl.AttributeType = (AttributeType)Enum.Parse(typeof(AttributeType), RadComboBoxAttributeType.SelectedValue);
        PropertyValueControl.StringValue = String.Empty;
        PropertyValueControl.IntegerValue = 0;
        PropertyValueControl.DoubleValue = 0.0;
        PropertyValueControl.DateTimeValue = DateTime.Now;
        var unitType = !string.IsNullOrEmpty(RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) ? (UnitType)Enum.Parse(typeof(UnitType), RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) : (UnitType?)null;
        PropertyValueControl.UnitType = unitType;

    }

    private void BindPropertyValueUpdate()
    {
        
    }

    protected void RadComboBoxAttributeType_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        PropertyValueControl.AttributeType = (AttributeType)Enum.Parse(typeof(AttributeType), RadComboBoxAttributeType.SelectedValue);
        var unitType = !string.IsNullOrEmpty(RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) ? (UnitType)Enum.Parse(typeof(UnitType), RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) : (UnitType?)null;
        PropertyValueControl.UnitType = unitType;
    }

    protected void RadComboBoxAttributeType_OnItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        var attributeTypeDto = (AttributeTypeDto)e.Item.DataItem;
        e.Item.Attributes["UnitType"] = attributeTypeDto.UnitType.ToString();
        e.Item.Attributes["DataType"] = attributeTypeDto.DataType.ToString();
    }
}