using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attributes;
using EcoDomus.Session;
using Telerik.Web.UI;

namespace App.UserControls
{
    public partial class AttributesControl : UserControlBase
    {
        public Guid EntityId { get; set; }

        public EntityType EntityType { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            HiddenFieldIsPageSizeCalculated.Value = IsPageSizeCalculated.ToString();

            RadButtonDeleteAttributesOfAllTypes.Visible = (EntityType == EntityType.Type);
        }

        public void Rebind()
        {
            //if (IsPageSizeCalculated)
            {
                RadGridAttributes.Rebind();
            }
        }

        private void SetEmptyDataSourceForRadGridAttributes()
        {
            RadGridAttributes.DataSource = new DataTable();
        }

        private void SetDataSourceForRadGridAttributes()
        {
            var attributeClient = new AttributeClient();

            var response =
                attributeClient.GetEntityAttributes
                (
                    EntityType, EntityId,
                    null,
                    null,
                    SessionController.ConnectionString
                );

            RadGridAttributes.VirtualItemCount = response.TotalCount;
            RadGridAttributes.DataSource = response.Items.OrderBy(x => x.Group).ThenBy(x => x.Name);
        }

        protected void RadGridAttributes_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
        {
            const string searchText = "";
            var pageIndex = e.NewPageIndex;
            var pageSize = RadGridAttributes.PageSize;
            AddHistoryPoint(searchText, pageIndex, pageSize);
        }

        protected void RadGridAttributes_OnUpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                var editedItem = e.Item as GridEditableItem;

                if (editedItem != null)
                {
                    var attributeId = (Guid)editedItem.GetDataKeyValue("AttributeId");
                    var attributeDetails = (AttributeDetails)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);
                    InsertUpdateAttributeFromAttributeDetails(EntityType, EntityId, attributeId, attributeDetails);
                }
            }
            catch (Exception ex)
            {
                ShowErrorMessage(ex);
            }
        }

        protected void RadGridAttributes_OnInsertCommand(object sender, GridCommandEventArgs e)
        {
            var attributeId = Guid.Empty;
            var attributeDetails = (AttributeDetails)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);
            InsertUpdateAttributeFromAttributeDetails(EntityType, EntityId, attributeId, attributeDetails);
        }

        private void InsertUpdateAttributeFromAttributeDetails(EntityType entityType, Guid entityId, Guid attributeId, AttributeDetails attributeDetails)
        {
            var groupName = attributeDetails.GroupName;
            var attributeName = attributeDetails.AttributeName;
            var description = attributeDetails.Description;
            var stringValue = attributeDetails.StringValue;
            var doubleValue = attributeDetails.DoubleValue;
            var integerValue = attributeDetails.IntegerValue;
            var dateTimeValue = attributeDetails.DateTimeValue;
            var displayUnitType = attributeDetails.DisplayUnitType;
            var attributeType = attributeDetails.AttributeType;
            var stage = attributeDetails.Stage;
            InsertUpdateAttribute(entityType, entityId, attributeId, groupName, attributeName, stringValue, doubleValue, integerValue, dateTimeValue, displayUnitType, description, attributeType, stage);
        }

        protected void RadGridAttributes_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            var item = e.Item;

            // Binding mode
            var gridItem = item as GridDataItem;
            if (gridItem != null)
            {
                var attributeViewModel = (AttributeViewModel)gridItem.DataItem;

                var displayUnitShort = attributeViewModel.DisplayUnitType == null ? "" : GetGlobalResourceObject("Resource", attributeViewModel.DisplayUnitType + "_SHORT");

                var labelAttributeValue = (Label)gridItem["AttributeValue"].FindControl("LabelAttributeValue");
                var checkBoxAttributeValue = (CheckBox)gridItem["AttributeValue"].FindControl("CheckBoxAttributeValue");

                if (labelAttributeValue != null)
                {
                    switch (attributeViewModel.AttributeType)
                    {
                        case AttributeType.URL:
                            labelAttributeValue.Text = @"<a target=""_blank"" href=""" + attributeViewModel.Value + @" "">" + attributeViewModel.Value + @"</a>";
                            labelAttributeValue.ToolTip = attributeViewModel.Value;
                            break;

                        case AttributeType.YesNo:
                            var integerValue = attributeViewModel.IntegerValue;
                            if (integerValue.HasValue && Convert.ToBoolean(integerValue.Value))
                            {
                                checkBoxAttributeValue.Checked = true;
                            }
                            checkBoxAttributeValue.Visible = true;
                            labelAttributeValue.Visible = false;
                            labelAttributeValue.ToolTip = labelAttributeValue.Text;
                            break;

                        default:
                            labelAttributeValue.Text = attributeViewModel.Value + @" " + displayUnitShort;
                            labelAttributeValue.ToolTip = labelAttributeValue.Text;
                            break;
                    }
                }

                // set 'Select' column checkboxes tooltip
                var checkBox = (CheckBox)gridItem["Select"].Controls[0];
                checkBox.ToolTip = @"Select";
            }
        }

        private void InsertUpdateAttribute(EntityType entityType, Guid entityId, Guid attributeId, string groupName, string name, string stringValue, Double? doubleValue, int? integerValue,
                                           DateTime? dateTimeValue, DisplayUnitType? displayUnitType, string description, AttributeType attributeType, Stage stage)
        {
            var userId = new Guid(SessionController.Users_.UserId);
            var clientId = new Guid(SessionController.Users_.ClientID);
            using (var attributeClient = new AttributeClient())
            {
                attributeClient.SaveEntityAttribute
                (
                    entityType,

                    new EntityAttributeDto
                    {
                        FkEntityId = entityId,
                        AttributeId = attributeId,
                        GroupName = groupName,
                        Name = name,
                        Description = description,
                        AttributeType = attributeType,
                        CreatedByUserId = userId
                    },

                    new EntityAttributeValueDto
                    {
                        StringValue = stringValue,
                        DoubleValue = doubleValue,
                        IntegerValue = integerValue,
                        DateTimeValue = dateTimeValue,
                        DisplayUnitType = displayUnitType,
                        FkStageId = stage.Id
                    },

                    SessionController.ConnectionString
                );
            }
        }

        protected void RadGridAttributes_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (IsNavigating) return;

            //if (!IsPageSizeCalculated)
            //{
            //    SetEmptyDataSourceForRadGridAttributes();
            //}
            //else
            //{
                SetDataSourceForRadGridAttributes();
            //}
        }

        protected void RadButtonCommand_OnCommand(object sender, CommandEventArgs e)
        {
            var command = GetCommandFromCommandEventArgs(e);
            var commandArgument = GetCommandArgumentFromCommandEventArgs(e);

            ExecuteCommand(ref RadGridAttributes, command, commandArgument);

            HiddenFieldIsPageSizeCalculated.Value = IsPageSizeCalculated.ToString();
        }

        protected void ScriptManagerProxy_OnNavigate(object sender, HistoryEventArgs e)
        {
            if (!Displayed) return;

            RestoreState(ref RadGridAttributes, e.State);
            SetDataSourceForRadGridAttributes();
            RadGridAttributes.DataBind();
        }

        protected void RadGridAttributes_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
        {
            const string searchText = "";
            var pageIndex = RadGridAttributes.CurrentPageIndex;
            var pageSize = e.NewPageSize;
            AddHistoryPoint(searchText, pageIndex, pageSize);
        }

        private string GetSelectedAtrributesCommaSeparatedList()
        {
            var selectedItems = RadGridAttributes.SelectedItems;

            var attributeIdsList = (from GridItem selectedItem
                                      in selectedItems
                                    select (Guid)selectedItem.OwnerTableView.DataKeyValues[selectedItem.ItemIndex]["AttributeId"]).ToList();

            return String.Join(",", attributeIdsList);    
        }

        protected void RadButtonDeleteAttributes_OnClick(object sender, EventArgs e)
        {
            var attributeModel = new AttributeModel
            {
                Entiy = EntityType.ToString(),
                Entiy_data_id = EntityId,
                Attribute_ids = GetSelectedAtrributesCommaSeparatedList()
            };

            using (var attributeClient = new AttributeClient())
            {
                attributeClient.DeleteAttributes(attributeModel, SessionController.ConnectionString);
            }

            RadGridAttributes.Rebind();
        }

        protected void RadButtonDeleteAttributesOfAllTypes_OnClick(object sender, EventArgs e)
        {
            var attributeModel = new AttributeModel
            {
                Project_id = new Guid(SessionController.Users_.ProjectId),
                Is_delete_for_all = "Y",
                Entiy = EntityType.ToString(),
                Entiy_data_id = EntityId,
                Attribute_ids = GetSelectedAtrributesCommaSeparatedList()
            };

            using (var attributeClient = new AttributeClient())
            {
                attributeClient.DeleteAttributesAll(attributeModel, SessionController.ConnectionString);
            }

            RadGridAttributes.Rebind();
        }
    }
}