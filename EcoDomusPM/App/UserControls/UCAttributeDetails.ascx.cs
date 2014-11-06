using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using AttributeTemplate;
using EcoDomus.Session;
using System.Data;
using System.Threading;
using System.Globalization;
using Attributes;
using DisplayUnitType = AttributeTemplate.DisplayUnitType;
using EntityAttributeValueDto = AttributeTemplate.EntityAttributeValueDto;
using UnitType = Attributes.UnitType;

public partial class App_UserControls_UCAttributeDetails : System.Web.UI.UserControl
{
    #region Global Variable Declarations
    string group_id = "";
    string temp_id = "";
    string update_flag = "";
    //string postbackflag = "Y";
    #endregion
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            var hfgroup_id = (HiddenField)Page.FindControl("hf_group_id");
            var hf_tempalte_id = (HiddenField)Page.FindControl("hfTemplate_id");
            var hf_flag = (HiddenField)Page.FindControl("hf_flag");
            temp_id = hf_tempalte_id.Value;
            if (hfgroup_id.Value != null && hfgroup_id.Value != "")
            {
                group_id = hfgroup_id.Value;
            }
            if (!IsPostBack)
            {



            }
            if (hf_flag.Value == "Y")
            {
                BindRequiredAttributes();
                bind_uom();
            }

            tr_add_attribute.Visible = false;
            lblMsg.Text = "";
            //Clear();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

        var scriptManager = ScriptManager.GetCurrent(Page);
        scriptManager.Scripts.Add(new ScriptReference { Path = ResolveUrl("~/App/UserControls/PropertyValueControl/PropertyValueControl.js") });
        scriptManager.Scripts.Add(new ScriptReference { Path = ResolveUrl("~/App/UserControls/YesNoRadioControl/YesNoRadioControl.js") });

        BindRadComboBoxAttributeType();
    }
    #endregion
    #region Private Method
    private void GoToNextTab()
    {

        var tabStrip = (RadTabStrip)Page.FindControl("RadTabStrip1");
        var AttribtueGroup = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", "Attribute_Group"));
        var AttribtueDetail = tabStrip.FindTabByText("Attribute Detail");
        AttribtueGroup.Enabled = true;
        AttribtueGroup.Selected = true;
        //  AttribtueDetail.Enabled = false;



        GoToNextPageView();
    }
    public void Clear()
    {
        txtaddattribute.Text = "";
        txtDescription.Text = "";
        //txtValue.Text = "";
        txt_search1.Text = "";
        //cmbox_uom_list.SelectedIndex = 0;
        //  lblMsg.Visible = false;

    }
    private void GoToNextPageView()
    {
        try
        {
            var multiPage = (RadMultiPage)Page.FindControl("RadMultiPage1");
            var PageView = multiPage.FindPageViewByID(@"~/App/UserControls/UCAttributeGroup.ascx");
            if (PageView == null)
            {
                PageView = new RadPageView();
                PageView.ID = @"~/App/UserControls/UCAttributeGroup.ascx";
                multiPage.PageViews.Add(PageView);
            }
            PageView.Selected = true;

            PageView = multiPage.FindPageViewByID(@"~/App/UserControls/UCAttributeDetails.ascx");
            PageView.Enabled = false;


        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void BindRequiredAttributes()
    {
        AttributeTemplateModel am = new AttributeTemplateModel();
        AttributeTemplateClient ac = new AttributeTemplateClient();
        var ds = new DataSet();
        try
        {
            var hfgroup_id = (HiddenField)Page.FindControl("hf_group_id");
            am.Attribute_Group_Ids = hfgroup_id.Value;
            am.Attribute_template_id = new Guid(temp_id);
            am.Attribute_name = txt_search1.Text;
            ds = ac.GetRequiredAttributesUnderGroup(am, SessionController.ConnectionString);
            rg_attribute_group.DataSource = ds;
            rg_attribute_group.DataBind();
            var hf_flag = (HiddenField)Page.FindControl("hf_flag");
            hf_flag.Value = "N";

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void DisplayEditForm(GridDataItem selectedItem)
    {

        try
        {
            hf_temp_flag.Value = selectedItem.GetDataKeyValue("pk_required_group_attribute_id").ToString();
            txtaddattribute.Text = selectedItem["Attribute_name"].Text;
            if (selectedItem["description"].Text == "" || selectedItem["description"].Text == "&nbsp;")
            { txtDescription.Text = ""; }
            else
            { txtDescription.Text = selectedItem["description"].Text; }
            if (selectedItem["Value"].Text == "" || selectedItem["Value"].Text == "&nbsp;")
            {
                //txtValue.Text = "";
            }
            else
            {
                //txtValue.Text = selectedItem["Value"].Text;
            }

            if (selectedItem["pk_unit_of_measurement_id"].Text != "" ||
                selectedItem["pk_unit_of_measurement_id"].Text != "&nbsp;")
            {
                //  cmbox_uom_list.SelectedValue = selectedItem["pk_unit_of_measurement_id"].Text;
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void bind_uom()
    {
        //AttributeTemplateModel am = new AttributeTemplateModel();
        //AttributeTemplateClient ac = new AttributeTemplateClient();
        //DataSet ds = new DataSet();
        //try
        //{
        //    ds = ac.BindUOM(SessionController.ConnectionString);
        //    cmbox_uom_list.DataTextField = "unit";
        //    cmbox_uom_list.DataValueField = "pk_unit_of_measurement_id";
        //    cmbox_uom_list.DataSource = ds;
        //    cmbox_uom_list.DataBind();

        //}
        //catch (Exception ex)
        //{
        //    throw ex;
        //}

    }
    #endregion
    #region Event Handlers
    protected void rg_attribute_group_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.Item is GridDataItem)
            {
                if (e.CommandName == "deleteAttribute")
                {
                    AttributeTemplateModel am = new AttributeTemplateModel();
                    AttributeTemplateClient ac = new AttributeTemplateClient();
                    am.Attribute_Ids = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_required_group_attribute_id"].ToString();
                    am.Attribute_Group_Id = new Guid(group_id);
                    am.Attribute_name = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Attribute_name"].ToString();
                    ac.DeleteRequiredttributeUnderGroup(am, SessionController.ConnectionString);
                    BindRequiredAttributes();

                }
                if (e.CommandName == "Edit")
                {
                    DisplayEditForm(e.Item as GridDataItem);
                    tr_add_attribute.Visible = true;
                    tr_attribute.Visible = false;
                    e.Canceled = true;
                    update_flag = "Y";
                    BindRequiredAttributes();
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
        BindRequiredAttributes();
    }

    protected void rg_attribute_group_PageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        BindRequiredAttributes(); ;
    }

    protected void rg_attribute_group_SortCommand(object source, GridSortCommandEventArgs e)
    {
        BindRequiredAttributes(); ;
    }
    protected void btnAtttribute_Click(object sender, EventArgs e)
    {
        tr_add_attribute.Visible = true;
        tr_attribute.Visible = false;
        hf_temp_flag.Value = "";
        Clear();
    }

    protected void btn_save_Click(object sender, EventArgs e)
    {
        try
        {

            InsertUpdateAttribute();

            //AttributeTemplateModel am = new AttributeTemplateModel();
            //AttributeTemplateClient ac = new AttributeTemplateClient();
            //DataSet ds = new DataSet();
            //if (hf_temp_flag.Value == "")
            //{
            //    am.Attributeid = Guid.Empty;
            //    update_flag = "N";
            //}
            //else
            //{
            //    am.Attributeid = new Guid(hf_temp_flag.Value);
            //    update_flag = "Y";
            //}
            //am.Attribute_name = txtaddattribute.Text;

            //am.Attribute_Group_Id = new Guid(group_id);
            //am.Description = txtDescription.Text;
            ////am.Attribute_Value = //txtValue.Text;
            //am.User_Id = new Guid(SessionController.Users_.UserId);
            ////am.UOM_id =new Guid(cmbox_uom_list.SelectedItem.Value);

            //ds = ac.InsertRequiredAttributeUnderGroup(am, SessionController.ConnectionString);
            //if (ds.Tables[0].Rows[0]["flag"].ToString() == "Y")
            //{
            //    lblMsg.Visible = true;
            //    lblMsg.Text = "Attribute with this name already exists";
            //    tr_attribute.Visible = false;
            //    tr_add_attribute.Visible = true;

            //}
            //else
            //{
            //    var hfEntityId = (HiddenField)Page.FindControl("hf_entity_id");

            //    var ds1 = new DataSet();
            //    if (update_flag == "Y")
            //    {
            //        am.Attributeid = new Guid(ds.Tables[0].Rows[0]["id"].ToString());
            //        am.Old_Attribute_Name = ds.Tables[0].Rows[0]["old_attribute_name"].ToString();

            //    }
            //    else
            //    {
            //        am.Attributeid = Guid.Empty;
            //        am.Old_Attribute_Name = "";
            //    }
            //    //  am.Attribute_template_id = new Guid(temp_id);
            //    am.Attribute_name = txtaddattribute.Text;
            //    // am.Entity_id = new Guid(hf_entity_id.Value);

            //    am.Attribute_Group_Id = new Guid(group_id);
            //    am.User_Id = new Guid(SessionController.Users_.UserId);
            //    am.Abbreviation = txtDescription.Text;
            //    ds1 = ac.UpdateRequiredAttributeTableForGroup(am, SessionController.ConnectionString);

            //    if (ds1.Tables.Count > 1)
            //    {
            //        if (ds1.Tables[1].Rows[0]["flag"].ToString() == "Y")
            //        {
            //            for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
            //            {
            //                var ds_types = new DataSet();
            //                am.Attribute_template_id = new Guid(temp_id);
            //                am.Omniclass_ids = ds1.Tables[0].Rows[i]["fk_omniclass_id"].ToString();
            //                am.Entity_id = new Guid(ds1.Tables[0].Rows[i]["fk_entity_id"].ToString());
            //                ds_types = ac.GetTypesIds(am, SessionController.ConnectionString);
            //                try
            //                {

            //                    if (ds_types.Tables[0].Rows.Count > 0)
            //                    {
            //                        am.User_Id = new Guid(SessionController.Users_.UserId);
            //                        for (int j = 0; j < ds_types.Tables[0].Rows.Count; j++)
            //                        {
            //                            string row_id = ds_types.Tables[0].Rows[j]["row_id"].ToString();
            //                            string omniclass_id = ds_types.Tables[0].Rows[j]["fk_omniclass_detail_id"].ToString();
            //                            string group_ids = ds_types.Tables[0].Rows[j]["fk_required_attribute_group_id"].ToString();
            //                            am.Fk_row_id = new Guid(row_id);
            //                            am.Omniclass_id = new Guid(omniclass_id);
            //                            am.Attribute_Group_Id = new Guid(group_ids);
            //                            am.Attribute_template_id = new Guid(temp_id);
            //                            am.Entity_id = new Guid(ds1.Tables[0].Rows[i]["fk_entity_id"].ToString());
            //                            if (update_flag == "Y")
            //                            {
            //                                am.Old_Attribute_Name = ds.Tables[0].Rows[0]["old_attribute_name"].ToString();
            //                                am.New_Attribute_Name = txtaddattribute.Text;
            //                            }
            //                            else
            //                            {

            //                                am.Old_Attribute_Name = "";
            //                                am.New_Attribute_Name = "";
            //                            }
            //                            var ds_1 = new DataSet();
            //                            ds_1 = ac.InsertAttributeToEntity(am, SessionController.ConnectionString);

            //                        }
            //                    }
            //                }
            //                catch (Exception)
            //                {

            //                    //throw;
            //                }

            //            }

            //        }
            //    }
                BindRequiredAttributes();
                tr_attribute.Visible = true;




           // }

        }
        catch (Exception ex)
        {

            throw ex;
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

            atvm.GroupId = new Guid(group_id);
            atvm.AttributeName = txtaddattribute.Text;
            atvm.TemplateId = new Guid(temp_id);
            atvm.UserId = userId;

            attributeClient.AddUpdateAttribute(SessionController.ConnectionString, atvm);
        }
    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        tr_attribute.Visible = true;
        tr_add_attribute.Visible = false;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            BindRequiredAttributes();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {

        GoToNextTab();
        var hfFlag = (HiddenField)Page.FindControl("hf_flag");
        hfFlag.Value = "Y";
    }
    protected void ibtn_back_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            GoToNextTab();
            var hfFlag = (HiddenField)Page.FindControl("hf_flag");
            hfFlag.Value = "Y";

        }
        catch (Exception)
        {

            throw;
        }
    }
    protected void lbtn_back_Click(object sender, EventArgs e)
    {
        try
        {
            GoToNextTab();
            var hfFlag = (HiddenField)Page.FindControl("hf_flag");
            hfFlag.Value = "Y";

        }
        catch (Exception)
        {

            throw;
        }

    }
    protected void lbtn_next_Click(object sender, EventArgs e)
    {

    }
    protected void ibtn_next_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void OnClick_BtnSearch1(object sender, EventArgs e)
    {
        try
        {
            BindRequiredAttributes();
        }
        catch (Exception ex)
        {

            throw ex;
        }
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

            PropertyValueControl.AttributeType = (AttributeType)Enum.Parse(typeof(AttributeType), RadComboBoxAttributeType.SelectedValue);
            var unitType = !string.IsNullOrEmpty(RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) ? (UnitType)Enum.Parse(typeof(UnitType), RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) : (UnitType?)null;
            PropertyValueControl.UnitType = unitType;
        }
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