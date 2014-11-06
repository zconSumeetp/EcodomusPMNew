using System;
using Attributes;
using EcoDomus.Session;
using Telerik.Web.UI;
using UnitType = Attributes.UnitType;
using System.Linq;

namespace App.UserControls
{
    public partial class AttributeDetails : System.Web.UI.UserControl
    {
        public object DataItem
        {
            get;
            set;
        }

        public string SelectedType
        {
            get { return (string)ViewState["AttributeType"]; }
            set { ViewState["AttributeType"] = value; }
        }

        public string GroupName
        {
            get { return RadComboBoxGroup.Text; }
        }

        public string AttributeName
        {
            get { return RadTextBoxAttributeName.Text; }
        }

        public string StringValue
        {
            get { return PropertyValueControl.StringValue; }
        }

        public Double? DoubleValue
        {
            get { return PropertyValueControl.DoubleValue; }
        }

        public int? IntegerValue
        {
            get { return PropertyValueControl.IntegerValue; }
        }

        public DateTime? DateTimeValue
        {
            get { return PropertyValueControl.DateTimeValue; }
        }

        public DisplayUnitType? DisplayUnitType
        {
            get { return PropertyValueControl.DisplayUnitType; }
        }

        public string Description
        {
            get { return RadTextBoxAttributeDescription.Text; }
        }

        public AttributeType AttributeType
        {
            get { return (AttributeType)Enum.Parse(typeof(AttributeType), RadComboBoxAttributeType.SelectedValue); }
        }

        public Stage Stage
        {
            get
            {
                return new Stage
                {
                    Id = new Guid(RadComboBoxStage.SelectedItem.Value),
                    StageName = RadComboBoxStage.SelectedItem.Text
                };
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            // Update
            var attributeViewModel = DataItem as AttributeViewModel;
            if (attributeViewModel != null)
            {
                BindRadComboBoxGroup();
                RadComboBoxGroup.SelectedValue = attributeViewModel.Group;

                RadTextBoxAttributeName.Text = attributeViewModel.Name;
                RadTextBoxAttributeDescription.Text = attributeViewModel.Description;

                BindRadComboBoxAttributeType();
                RadComboBoxAttributeType.SelectedValue = attributeViewModel.AttributeType.ToString();

                PropertyValueControl.AttributeName = attributeViewModel.Name;
                PropertyValueControl.AttributeType = (AttributeType)Enum.Parse(typeof(AttributeType), RadComboBoxAttributeType.SelectedValue);
                PropertyValueControl.StringValue = attributeViewModel.StringValue;
                PropertyValueControl.IntegerValue = attributeViewModel.IntegerValue;
                PropertyValueControl.DoubleValue = attributeViewModel.DoubleValue;
                PropertyValueControl.DateTimeValue = attributeViewModel.DateTimeValue;
                var unitType = !string.IsNullOrEmpty(RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) ? (UnitType)Enum.Parse(typeof(UnitType), RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) : (UnitType?)null;
                PropertyValueControl.UnitType = unitType;
                PropertyValueControl.DisplayUnitType = attributeViewModel.DisplayUnitType;

                BindRadComboBoxStage();
                RadComboBoxStage.SelectedValue = attributeViewModel.StageId.ToString();
            }
            // Insert
            if (DataItem is GridInsertionObject)
            {
                BindRadComboBoxGroup();
                BindRadComboBoxAttributeType();

                PropertyValueControl.AttributeType = (AttributeType)Enum.Parse(typeof(AttributeType), RadComboBoxAttributeType.SelectedValue);
                var unitType = !string.IsNullOrEmpty(RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) ? (UnitType)Enum.Parse(typeof(UnitType), RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) : (UnitType?)null;
                PropertyValueControl.UnitType = unitType;

                BindRadComboBoxStage();
            }
        }

        protected void RadComboBoxAttributeType_OnItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            var attributeTypeDto = (AttributeTypeDto)e.Item.DataItem;
            e.Item.Attributes["UnitType"] = attributeTypeDto.UnitType.ToString();
            e.Item.Attributes["DataType"] = attributeTypeDto.DataType.ToString();
        }

        protected void RadComboBoxAttributeType_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            PropertyValueControl.AttributeType = (AttributeType)Enum.Parse(typeof(AttributeType), RadComboBoxAttributeType.SelectedValue);
            var unitType = !string.IsNullOrEmpty(RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) ? (UnitType)Enum.Parse(typeof(UnitType), RadComboBoxAttributeType.SelectedItem.Attributes["UnitType"]) : (UnitType?)null;
            PropertyValueControl.UnitType = unitType;
        }

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

        private void BindRadComboBoxGroup()
        {
            using (var attributeClient = new AttributeClient())
            {
                RadComboBoxGroup.DataSource = attributeClient.GetAllGroups(SessionController.ConnectionString).OrderBy(g => g);
                RadComboBoxGroup.DataBind();
            }

            if (RadComboBoxGroup.Items.Count > 0)
                RadComboBoxGroup.Items[0].Selected = true;
        }

        private void BindRadComboBoxStage()
        {
            using (var attributeClient = new AttributeClient())
            {
                RadComboBoxStage.DataSource =
                    attributeClient.GetStages(SessionController.ConnectionString).OrderBy(s => s.StageName);
                RadComboBoxStage.DataTextField = "StageName";
                RadComboBoxStage.DataValueField = "Id";
                RadComboBoxStage.DataBind();
            }
            // Set default stage value as "As Built"
            var item = RadComboBoxStage.FindItemByText("As Built");
            if (item != null)
            {
                item.Selected = true;
            }
        }
    }
}