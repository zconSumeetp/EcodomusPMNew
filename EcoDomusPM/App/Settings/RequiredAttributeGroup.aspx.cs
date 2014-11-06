using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attributes;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;
using AttributeTemplate;
using System.Data;
using EcoDomus.Session;
using DisplayUnitType = AttributeTemplate.DisplayUnitType;
using EntityAttributeValueDto = AttributeTemplate.EntityAttributeValueDto;
using UnitType = System.Web.UI.WebControls.UnitType;

public partial class App_Settings_RequiredAttributeGroup : System.Web.UI.Page
{
    #region Global Variable Declarations
    string omniclass_detail_id = "";
    string[] ids;
    string temp_id = "";
    List<String> ls = new List<string>();
    string name = "";
    string update_flag = "";
    string group_id = "";
    Guid? EditItemId { get; set; }
    #endregion
    #region Page Event
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                if (Request.QueryString["templateId"] != null)
                    {
                        hfTemplate_id.Value = Request.QueryString["templateId"];

                    }
                    if (Request.QueryString["entity_id"] != null)
                    {
                        hf_entity_id.Value = Request.QueryString["entity_id"].ToString();
                    }
                    if (!IsPostBack)
                    {
                        // Attribute Group
                        AddTab((string)GetGlobalResourceObject("Resource", "Attribute_Group"), true);
                        //var pageView = new RadPageView();
                        //pageView.ID = @"~/App/UserControls/UCAttributeGroup.ascx";
                        //RadMultiPage1.PageViews.Add(pageView);
                        //AddTabImage("", "EnergyPlusFacility", false);
                        //AddTab((string)GetGlobalResourceObject("Resource", "Attribute_Details"), false);
                        hf_flag.Value = "Y";
                        hf_flag_first.Value = "Y";
                        hf_tab_click.Value = "Y";
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

        if (StartWindow == 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "RequiredAttributeGroupLib.AttributeGroup.SetAttributeWindowHeight();", true);
            StartWindow = 1;
        }

        var scriptManager = ScriptManager.GetCurrent(Page);
        scriptManager.Scripts.Add(new ScriptReference { Path = ResolveUrl("~/App/UserControls/PropertyValueControl/PropertyValueControl.js") });
        scriptManager.Scripts.Add(new ScriptReference { Path = ResolveUrl("~/App/UserControls/YesNoRadioControl/YesNoRadioControl.js") });

        BindRadComboBoxAttributeType();
        InitAttributeGroup();
        InitAtributeDetail();
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
            var unitType = !string.IsNullOrEmpty(RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) ? (Attributes.UnitType)Enum.Parse(typeof(Attributes.UnitType), RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) : (Attributes.UnitType?)null;
            PropertyValueControl.UnitType = unitType;
        }
    }

    protected void RadComboBoxAttributeType_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

    #region Private Methods
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

            //redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }
    private void AddTab(string tabName, bool enabled)
    {

        RadTab tab = new RadTab();
        tab.Text = tabName;
        tab.Height = 300;
        tab.Enabled = enabled;
        //tab.CssClass = "activeCourses";
        //tab.SelectedCssClass = "activeCoursesSelected";
        //RadTabStrip1.Tabs.Add(tab);
    }
    private void AddTabImage(string tabName, string tabValue, bool enabled)
    {
        try
        {
            RadTab tab = new RadTab(tabName);
            tab.Enabled = enabled;
            tab.DisabledImageUrl = "~/App/Images/Icons/asset_wizard_arrow_selected.png";
            tab.Width = 165;
            tab.IsSeparator = false;
            //RadTabStrip1.Tabs.Add(tab);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    private void AddPageView(RadTab tab)
    {
        RadPageView pageView = new RadPageView();
        pageView.ID = tab.Text;
        //RadMultiPage1.PageViews.Add(pageView);
        //pageView.CssClass = "pageView";
        tab.PageViewID = pageView.ID;
    }
    #endregion
    #region Event Handlers
    protected void RadMultiPage1_PageViewCreated(object sender, RadMultiPageEventArgs e)
    {
        Control pageViewContents = LoadControl(e.PageView.ID);
        pageViewContents.ID = e.PageView.ID + "AttributeGroup";
        e.PageView.Controls.Add(pageViewContents);
    }
    protected void rdstripSetupSync_TabClick(object sender, RadTabStripEventArgs e)
    {
        try
        {
            string TabName = e.Tab.Text.Replace(" ", "").Trim().ToString();
           // GoToNextPageView(TabName);
        }
        catch (Exception ex)
        {
            //Response.Write("<script>alert('" + Server.HtmlEncode(ex.Message) + "')</script>");
            throw ex;
        }
    }
    protected void RadTabStrip1_TabClick(object sender, RadTabStripEventArgs e)
    {
        AddPageView(e.Tab);
        e.Tab.PageView.Selected = true;
    }
    
    protected void ibtn_close_Click(object sender, ImageClickEventArgs e)
    {

    }
    #endregion

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

    protected void BindRequiredAttributes()
    {
        var am = new AttributeTemplateModel();
        var ac = new AttributeTemplateClient();
        var ds = new DataSet();
        try
        {
            var hfgroup_id = (HiddenField)Page.FindControl("hf_group_id");
            if (String.IsNullOrEmpty(hfgroup_id.Value))
                return;
            am.Attribute_Group_Ids = hfgroup_id.Value;
            am.Attribute_template_id = new Guid(temp_id);
            am.Attribute_name = txt_search1.Text;
            var attributes = ac.GetRequiredAttributesByAttributeGroupId(SessionController.ConnectionString,
                new Guid(hfgroup_id.Value));
            //ds = ac.GetRequiredAttributesUnderGroup(am, SessionController.ConnectionString);
            //rg_attribute_group.DataSource = ds;
            rg_attribute_group.DataSource = attributes;
            rg_attribute_group.DataBind();
            var hf_flag = (HiddenField)Page.FindControl("hf_flag");
            hf_flag.Value = "N";

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
       // tr_add_attribute.Visible = true;
        tr_attribute.Visible = false;
        hf_temp_flag.Value = "";
        Clear();
    }

    public void Clear()
    {
        txtaddattribute.Text = "";
        txtDescription.Text = "";
        txt_search1.Text = "";
    }

    protected void rg_attribute_group_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.Item is GridDataItem)
            {
                var am = new AttributeTemplateModel();
                var ac = new AttributeTemplateClient();
                if (e.CommandName == "deleteAttribute")
                {
                    am.Attribute_Ids = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["GroupId"].ToString();
                    am.Attribute_Group_Id = new Guid(group_id);
                    am.Attribute_name = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["AttributeName"].ToString();
                    ac.DeleteRequiredttributeUnderGroup(am, SessionController.ConnectionString);
                    BindRequiredAttributes();

                }
                if (e.CommandName == "Edit")
                {
                    DisplayEditForm(e.Item as GridDataItem);
                    //tr_add_attribute.Visible = true;
                    tr_attribute.Visible = false;
                    e.Canceled = true;
                    update_flag = "Y";
                    BindRequiredAttributes();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ViewAddAtrributesDialogPath();", true);
                }

                if (e.CommandName == "Edit_")
                {
                    Table1.Visible = true;
                    hf_temp_group_id.Value = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_required_attribute_group_id"].ToString();
                    am.Attribute_template_id = new Guid(hf_temp_group_id.Value);
                    TextBox1.Text = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["group_name"].ToString();
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
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void DisplayEditForm(GridDataItem selectedItem)
    {

        try
        {
            hf_temp_flag.Value = selectedItem.GetDataKeyValue("GroupId").ToString();
            EditItemId = new Guid(selectedItem.GetDataKeyValue("GroupId").ToString());
            txtaddattribute.Text = selectedItem["AttributeName"].Text;
            if (selectedItem["Description"].Text == "" || selectedItem["Description"].Text == "&nbsp;")
            { txtDescription.Text = ""; }
            else
            { txtDescription.Text = selectedItem["Description"].Text; }
            if (!String.IsNullOrEmpty(selectedItem["AttributeType"].Text))
            {
                RadComboBoxAttributeType.SelectedValue = selectedItem["AttributeType"].Text;

                PropertyValueControl.AttributeType = (AttributeType)Enum.Parse(typeof(AttributeType), RadComboBoxAttributeType.SelectedValue);
                var unitType = !string.IsNullOrEmpty(RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) ? (Attributes.UnitType)Enum.Parse(typeof(Attributes.UnitType), RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) : (Attributes.UnitType?)null;
                PropertyValueControl.UnitType = unitType;
                switch (PropertyValueControl.AttributeType)
                {
                    case AttributeType.Text:
                    case AttributeType.URL:
                    case AttributeType.List:
                        PropertyValueControl.StringValue = selectedItem["StringValue"].Text;
                        break;
                    case AttributeType.Integer:
                    case AttributeType.Number:
                    case AttributeType.Period:
                    case AttributeType.YesNo:
                        PropertyValueControl.IntegerValue = Convert.ToInt32(selectedItem["IntegerValue"].Text);
                        break;
                    case AttributeType.DateTime:
                        PropertyValueControl.DateTimeValue = Convert.ToDateTime(selectedItem["DateTimeValue"].Text);
                        break;
                    default:
                        PropertyValueControl.DoubleValue = PropertyValueControl.DoubleValue = Convert.ToDouble(selectedItem["DoubleValue"].Text);
                        break;
                }
                
                if (!String.IsNullOrEmpty(selectedItem["DisplayUnitType"].Text) && !selectedItem["DisplayUnitType"].Text.Equals("&nbsp;"))
                {
                    PropertyValueControl.DisplayUnitType = (Attributes.DisplayUnitType)Enum.Parse(typeof(Attributes.DisplayUnitType), selectedItem["DisplayUnitType"].Text);
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btn_save_Click(object sender, EventArgs e)
    {
        try
        {
            InsertUpdateAttribute();
            BindRequiredAttributes();
            ClearAttribteDetailControls();
            tr_attribute.Visible = true;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "RequiredAttributeGroupLib.AttributeDetail.SetAttributeWindowHeightSmall();", true);
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
            if(EditItemId != null){}
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
        ClearAttribteDetailControls();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "RequiredAttributeGroupLib.AttributeDetail.SetAttributeWindowHeightSmall();", true);
        //tr_add_attribute.Visible = false;

    }

    protected void btnAttributeGroup_cancel_Click(object sender, EventArgs e)
    {
        ClearAttributeGroupControls();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "RequiredAttributeGroupLib.AttributeGroup.SetAttributeWindowHeight();", true);
    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        var hfFlag = (HiddenField)Page.FindControl("hf_flag");
        hfFlag.Value = "Y";
    }
    protected void ibtn_back_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            var hfFlag = (HiddenField)Page.FindControl("hf_flag");
            hfFlag.Value = "Y";
            PreviousStep();

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
            var hfFlag = (HiddenField)Page.FindControl("hf_flag");
            hfFlag.Value = "Y";
            PreviousStep();
        }
        catch (Exception)
        {

            throw;
        }

    }
    protected void lbtn_next_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "RequiredAttributeGroupLib.AttributeGroup.SetAttributeWindowHeight();", true);
    }
    protected void ibtn_next_Click(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "RequiredAttributeGroupLib.AttributeGroup.SetAttributeWindowHeight();", true);
    }

    private void InitAtributeDetail()
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
            }

            //tr_add_attribute.Visible = false;
            lblMsg.Text = "";
            //Clear();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }

    //========================================Details Methods

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


    public void Bind_Grid()
    {
        try
        {
            var am = new AttributeTemplateModel();
            var ac = new AttributeTemplateClient();
            var ds = new DataSet();
            am.Attribute_Group_Name = txt_search.Text;
            ds = ac.GetRequiredAttributeGroups(am, SessionController.ConnectionString);

            if (ds.Tables.Count > 0)
            {
                RadGrid1.DataSource = ds;
                RadGrid1.DataBind();

            }
            var hf_flag_first = (HiddenField)Page.FindControl("hf_flag_first");
            hf_flag_first.Value = "N";
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnAttributeGroup_Click(object source, EventArgs e)
    {
        try
        {
            Table1.Visible = true;
            tr_btn_add.Visible = false;
            txtAttributeGroupName.Text = "";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "RequiredAttributeGroupLib.AttributeGroup.SetAttributeWindowFullHeight();", true);
            
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void InitAttributeGroup()
    {
        if (SessionController.Users_.UserId != null)
        {
            var hf_tab_click = (HiddenField)Page.FindControl("hf_tab_click");
            if (hf_tab_click.Value == "Y")
            {
                var hf_tempalte_id = (HiddenField)Page.FindControl("hfTemplate_id");
                var hf_flag_first = (HiddenField)Page.FindControl("hf_flag_first");

                temp_id = hf_tempalte_id.Value.ToString();
                if (!IsPostBack)
                {
                    Bind_Grid();

                }
                if (hf_flag_first.Value.ToString() == "Y")
                {

                    Bind_Grid();

                }
                Table1.Visible = false;
                tr_btn_add.Visible = true;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
        
    }

    protected void lbtnGroup_next_Click(object Object, EventArgs e)
    {
        NextStepGroup();
    }

    protected void ibtnGroup_next_Click(object Object, EventArgs e)
    {
        NextStepGroup();
    }

    private void NextStepGroup()
    {
        try
        {
            if (Page.IsValid)
            {
                int i = 0;
                foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
                {

                    if (item.Selected == true)
                    {
                        i++;

                        var hf_group_ID = (HiddenField)Page.FindControl("hf_group_id");
                        hf_group_ID.Value = item.GetDataKeyValue("pk_required_attribute_group_id").ToString();
                        var hf_flag_first = (HiddenField)Page.FindControl("hf_flag_first");
                        hf_flag_first.Value = "Y";
                        var hf_flag = (HiddenField)Page.FindControl("hf_flag");
                        hf_flag.Value = "Y";

                    }
                }
                if (i == 1)
                {

                    // GoToNextTab();
                    AttributeGroupPanel.Visible = false;
                    AttributeDetailPanel.Visible = true;
                    InitAtributeDetail();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "RequiredAttributeGroupLib.AttributeDetail.SetAttributeWindowHeightSmall();", true);
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

    protected void PreviousStep()
    {
        AttributeDetailPanel.Visible = false;
        AttributeGroupPanel.Visible = true;
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "RequiredAttributeGroupLib.AttributeGroup.SetAttributeWindowHeight();", true);
    }

    void ClearAttribteDetailControls()
    {
        txtaddattribute.Text = "";
        txtDescription.Text = "";
        PropertyValueControl.StringValue = "";
        PropertyValueControl.IntegerValue = 0;
        PropertyValueControl.DoubleValue = 0;
        PropertyValueControl.DateTimeValue = DateTime.Now;
        PropertyValueControl.AttributeType = AttributeType.Text;
    }

    void ClearAttributeGroupControls()
    {
        TextBox1.Text = "";
    }

    protected void btnAttributeGroup_save_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            try
            {
                var am = new AttributeTemplateModel();
                var ac = new AttributeTemplateClient();
                var ds = new DataSet();
                if (hf_temp_group_id.Value == "" || hf_temp_group_id.Value == Guid.Empty.ToString())
                {
                    am.Attribute_Group_Id = Guid.Empty;
                }
                else
                {
                    am.Attribute_Group_Id = new Guid(hf_temp_group_id.Value);

                }
                am.Attribute_Group_Name = TextBox1.Text;
                am.User_Id = new Guid(SessionController.Users_.UserId);
                ds = ac.InsertUpdateAttributeGroup(am, SessionController.ConnectionString);
                if (ds.Tables[0].Rows[0]["id"] == Guid.Empty.ToString())
                {


                }
                else
                {
                    Bind_Grid();
                    ClearAttributeGroupControls();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "RequiredAttributeGroupLib.AttributeGroup.SetAttributeWindowHeight();", true);
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

    int StartWindow
    {
        get
        {
            object o = ViewState["StartWindow"];
            return (o == null || (int)o == 0) ? 0 : 1;
        }
        set
        {
            ViewState["StartWindow"] = value;
        }
    }
}
