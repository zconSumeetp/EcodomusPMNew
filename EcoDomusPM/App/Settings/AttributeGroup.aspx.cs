using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attributes;
using Telerik.Web.UI;
using AttributeTemplate;
using System.Data;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;
using UnitType = System.Web.UI.WebControls.UnitType;

public partial class App_Settings_AttributeGroup : System.Web.UI.Page
{
    #region Global Variable Declarations
    List<String> ls = new List<string>();
    List<String> ls_value = new List<string>();
    List<String> ls_ids = new List<string>();
    List<String> ls_choice = new List<string>();
    List<String> ls_choice_attribute = new List<string>();
    List<String> ls_choice_ids = new List<string>();
    static DataSet dsUOM;
    string tempPageSize = "";
    bool flag = false;
    string group_id = "";
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
            string omniclass_name = Request.QueryString["Name"];
            string template_name = Request.QueryString["template_name"];
            string group_name = Request.QueryString["attribute_name"];
            if (!IsPostBack)
            {
                lbl_OmniClass_name.Text = omniclass_name;
                lbl_template_name.Text = template_name;
                lbl_group_name.Text = group_name;
                hfAttributeTemplateId.Value = Request.QueryString["templateId"];
                hf_group_id.Value = Request.QueryString["group_id"];
                hf_group_name.Value = Request.QueryString["attribute_name"];
                hf_OmniClass_id.Value = Request.QueryString["omniclass_detail_id"];
                hfEntityId.Value = Request.QueryString["entity_id"];

                var sortExpr = new GridSortExpression();
                sortExpr.FieldName = "Attribute_name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rg_group_attribute.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                var AttributeTemplateClient = new AttributeTemplate.AttributeTemplateClient();
                var AttributeTemplateModel = new AttributeTemplate.AttributeTemplateModel();

                dsUOM = AttributeTemplateClient.BindUOM(SessionController.ConnectionString);

                hfUserPMPageSize.Value = Convert.ToString(Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids) - 2);
                tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                tempPageSize = Convert.ToString(Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids) - 2);
                BindRequiredAttributes();

             }
        }
        else
        {

            Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
        }
        //bind_uom();


    }
    #endregion
    #region Private Method
    protected override void InitializeCulture()
    {
        try
        {
            var culture = Session["Culture"].ToString();
            if (culture == null)
            {
                culture = "en-US";
            }
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
        }
        catch (Exception ex)
        {

            Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
        }

    }

    protected void btnclose_Click(object sender, EventArgs e)
    {

    }
    protected void ibtn_close_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void RadComboBoxAttributeType_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        //PropertyValueControl.AttributeType = (AttributeType)Enum.Parse(typeof(AttributeType), RadComboBoxAttributeType.SelectedValue);
        //var unitType = !string.IsNullOrEmpty(RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) ? (UnitType)Enum.Parse(typeof(UnitType), RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) : (UnitType?)null;
        //PropertyValueControl.UnitType = (Attributes.UnitType?) unitType;
    }

    protected void RadComboBoxAttributeType_OnItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        var attributeTypeDto = (AttributeTypeDto)e.Item.DataItem;
        e.Item.Attributes["UnitType"] = attributeTypeDto.UnitType.ToString();
        e.Item.Attributes["DataType"] = attributeTypeDto.DataType.ToString();

    }

    protected void BindRequiredAttributes()
    {
        var am = new AttributeTemplateModel();
        var ac = new AttributeTemplateClient();
        var ds = new DataSet();
        try
        {

            am.Attribute_Group_Ids = Request.QueryString["group_id"].ToString();
            am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
            am.Attribute_name = txtSearch.Text;
            ds = ac.GetRequiredAttributesUnderGroup(am, SessionController.ConnectionString);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                //ls.Add(ds.Tables[0].Rows[i]["pk_unit_of_measurement_id"].ToString());
                ls_value.Add(ds.Tables[0].Rows[i]["is_choice"].ToString());
                ls_ids.Add(ds.Tables[0].Rows[i]["pk_required_group_attribute_id"].ToString());
            }

            for (var i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (!String.IsNullOrEmpty(ds.Tables[0].Rows[i]["display_unit_type"].ToString()))
                {
                    ds.Tables[0].Rows[i]["value"] += " " + GetGlobalResourceObject("Resource", string.Format("{0}_SHORT", ds.Tables[0].Rows[i]["display_unit_type"]));
                }
            }

            if (ds.Tables[1].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    ls_choice.Add(ds.Tables[1].Rows[i]["pk_group_attribute_choice_id"].ToString());
                    ls_choice_attribute.Add(ds.Tables[1].Rows[i]["pk_required_group_attribute_id"].ToString());
                    ls_choice_ids.Add(ds.Tables[1].Rows[i]["pk_group_attribute_choice_id"].ToString());
                }

            }

            rg_group_attribute.DataSource = ds;
            rg_group_attribute.AllowCustomPaging = true;
            if (tempPageSize != "")
                rg_group_attribute.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rg_group_attribute.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
            rg_group_attribute.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    #endregion
    #region Event Handlers
    protected void rg_group_attribute_ItemDataBound(object sender, GridItemEventArgs e)
    {
        //  BindRequiredAttributes();
        if (e.Item is GridDataItem)
        {
            var cmb_UOM = (RadComboBox)e.Item.FindControl("cmb_UOM_list");
            var val = (Label)e.Item.FindControl("MakeTextBox");
            var value = new TextBox();
            value.Text = val.Text;
            var valuelist = (RadComboBox)e.Item.FindControl("cmb_value_list");
            var checkBox = (CheckBox)e.Item.FindControl("CheckedFiled");
            var am = new AttributeTemplateModel();
            var ac = new AttributeTemplateClient();
            var ds = new DataSet();
            var ds_value = new DataSet();
            if (valuelist != null)
            {

                if (ls_value[Convert.ToInt32(rg_group_attribute.CurrentPageIndex + e.Item.ItemIndex.ToString())] == "1")
                {
                    value.Visible = false;
                    valuelist.Visible = true;
                    am.Attributeid = new Guid(ls_ids[Convert.ToInt32(rg_group_attribute.CurrentPageIndex + e.Item.ItemIndex.ToString())]);
                    ds_value = ac.GetValuesListForAttribute(am, SessionController.ConnectionString);
                    valuelist.DataTextField = "value";
                    valuelist.DataValueField = "pk_group_attribute_choice_id";
                    valuelist.DataSource = ds_value;
                    valuelist.DataBind();
                    if (ls_choice.Count > 0)
                    {
                        for (int i = 0; i < ls_choice.Count; i++)
                        {
                            if (ls_choice_attribute[i] == ls_ids[Convert.ToInt32(rg_group_attribute.CurrentPageIndex + e.Item.ItemIndex.ToString())])
                            {
                                valuelist.SelectedValue = ls_choice_ids[i];
                            }
                        }
                        //valuelist.SelectedValue = ls_choice[Convert.ToInt32(rg_group_attribute.CurrentPageIndex.ToString() + e.Item.ItemIndex.ToString())].ToString();

                    }

                }
                else
                {
                    value.Visible = true;
                    valuelist.Visible = false;
                }

            }

            var item = e.Item as GridDataItem;

            var dr = item.DataItem as DataRowView;

            if (dr != null)
                if (dr.Row.ItemArray[6].Equals(AttributeType.YesNo.ToString()))
                {
                    checkBox.Visible = true;
                    val.Visible = value.Visible = false;
                    if (value.Text.Equals("1"))
                    {
                        checkBox.Checked = true;
                    }
                }

            if (cmb_UOM != null)
            {
                cmb_UOM.DataTextField = "unit";
                cmb_UOM.DataValueField = "pk_unit_of_measurement_id";
                cmb_UOM.DataSource = dsUOM;
                cmb_UOM.DataBind();



                if (ls[Convert.ToInt32(rg_group_attribute.CurrentPageIndex.ToString() + e.Item.ItemIndex)] != "")
                {
                    cmb_UOM.SelectedValue = ls[Convert.ToInt32(rg_group_attribute.CurrentPageIndex + e.Item.ItemIndex.ToString())];
                }

            }
        }

    }
    protected void rg_group_attribute_pageindexchanged(object source, GridPageChangedEventArgs e)
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

    protected void rg_group_attribute_pagesizechanged(object source, GridPageSizeChangedEventArgs e)
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

    protected void rg_group_attribute_Sort_command(object source, GridSortCommandEventArgs e)
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

    protected void btn_search_click(object sender, EventArgs e)
    {
        BindRequiredAttributes();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            var am = new AttributeTemplateModel();
            var ac = new AttributeTemplateClient();
            var ds = new DataSet();
            string str = "";
            if (rg_group_attribute.SelectedValue != null)
            {

                foreach (Telerik.Web.UI.GridDataItem item in rg_group_attribute.SelectedItems)
                {
                    var cmb_UOM = (RadComboBox)item.FindControl("cmb_UOM_list");
                    var value = (TextBox)item.FindControl("MakeTextBox");
                    var cmb_value = (RadComboBox)item.FindControl("cmb_value_list");
                    am.Attributeid = new Guid(item.GetDataKeyValue("pk_required_group_attribute_id").ToString());
                    am.Attribute_Group_Id = new Guid(Request.QueryString["group_id"].ToString());
                    if (cmb_value != null && value != null)
                    {
                        str = cmb_value.SelectedValue;
                        if (str == "")
                        {
                            am.Attribute_Value = value.Text;
                        }
                        else if (str == Guid.Empty.ToString())
                        {
                            am.Attribute_Value = "";
                        }
                        else
                        {
                            am.Attribute_Value = cmb_value.Text;

                        }
                    }

                    am.UOM_id = new Guid(cmb_UOM.SelectedValue);
                    am.Attribute_template_id = new Guid(hfAttributeTemplateId.Value);
                    am.User_Id = new Guid(SessionController.Users_.UserId);
                    ds = ac.UpdateGroupAttributeFileds(am, SessionController.ConnectionString);

                    var ds1 = new DataSet();
                    am.Attributeid = new Guid(ds.Tables[0].Rows[0]["id"].ToString());
                    am.Abbreviation = ds.Tables[0].Rows[0]["abbreviation"].ToString();
                    am.Attribute_name = item.GetDataKeyValue("Attribute_name").ToString();
                    am.Attribute_Group_Id = new Guid(Request.QueryString["group_id"].ToString());
                    am.User_Id = new Guid(SessionController.Users_.UserId);
                    am.Old_Attribute_Name = item.GetDataKeyValue("Attribute_name").ToString();
                    ds1 = ac.UpdateRequiredAttributeTableForGroup(am, SessionController.ConnectionString);
                    if (ds1.Tables.Count > 1)
                    {
                        if (ds1.Tables[1].Rows[0]["flag"].ToString() == "Y")
                        {
                            for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                            {
                                var ds_types = new DataSet();
                                am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
                                am.Omniclass_ids = ds1.Tables[0].Rows[i]["fk_omniclass_id"].ToString();
                                am.Entity_id = new Guid(ds1.Tables[0].Rows[i]["fk_entity_id"].ToString());
                                ds_types = ac.GetTypesIds(am, SessionController.ConnectionString);
                                try
                                {

                                    if (ds_types.Tables[0].Rows.Count > 0)
                                    {
                                        am.User_Id = new Guid(SessionController.Users_.UserId);
                                        for (int j = 0; j < ds_types.Tables[0].Rows.Count; j++)
                                        {
                                            string row_id = ds_types.Tables[0].Rows[j]["row_id"].ToString();
                                            string omniclass_id = ds_types.Tables[0].Rows[j]["fk_omniclass_detail_id"].ToString();
                                            string group_ids = ds_types.Tables[0].Rows[j]["fk_required_attribute_group_id"].ToString();
                                            am.Fk_row_id = new Guid(row_id);
                                            am.Omniclass_id = new Guid(omniclass_id);
                                            am.Attribute_Group_Id = new Guid(group_ids);
                                            am.Attribute_template_id = new Guid(Request.QueryString["templateId"].ToString());
                                            am.Entity_id = new Guid(ds1.Tables[0].Rows[i]["fk_entity_id"].ToString());
                                            am.Old_Attribute_Name = item.GetDataKeyValue("Attribute_name").ToString();
                                            am.New_Attribute_Name = item.GetDataKeyValue("Attribute_name").ToString();
                                            var ds_1 = new DataSet();
                                            ds_1 = ac.InsertAttributeToEntity(am, SessionController.ConnectionString);

                                        }
                                    }


                                }
                                catch (Exception)
                                {

                                    throw;
                                }

                            }

                        }
                    }
                }
            }
            
            BindRequiredAttributes();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            var am = new AttributeTemplateModel();
            var ac = new AttributeTemplateClient();
            string attributeIds = hf_attribute_ids.Value;
            attributeIds = attributeIds.Substring(0, attributeIds.Length - 1);
            string attributeNames = hf_attribute_names.Value;
            attributeNames = attributeNames.Substring(0, attributeNames.Length - 1);
            am.Attribute_Ids = attributeIds;
            am.Attribute_Group_Id = new Guid(Request.QueryString["group_id"]);
            am.Attribute_name = attributeNames;
            ac.DeleteRequiredttributeUnderGroup(am, SessionController.ConnectionString);
            BindRequiredAttributes();



        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
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

    protected void btnCancel_Click(object sender, EventArgs e)
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
    protected void btn_search_click(object sender, ImageClickEventArgs e)
    {
        BindRequiredAttributes();
    }
    #endregion

    protected void rg_group_attribute_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "cancel")
        {
            btnCancel_Click(null, null);
        }
        else if (e.CommandName == "saveChanges")
        {
            btnSave_Click(null, null);
        }
        else if (e.CommandName == "deleteAttributes")
        {
            btnDelete_Click(null, null);
        }
    }
}