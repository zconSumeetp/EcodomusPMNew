using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attributes;
using EcoDomus.Session;
using Telerik.Web.UI;
using UnitType = Attributes.UnitType;

namespace App.UserControls
{
    public partial class PropertyValueControl : UserControlBase
    {
        public string OnClientBlur { get; set; }

        private readonly List<DisplayUnitType?> _textTypeExceptionUnit = new List<DisplayUnitType?>();

        public String TextTypeExceptionUnit
        {
            get
            {
                var separate = false;
                var builder = new StringBuilder();
                builder.Append("[");

                foreach (var t in _textTypeExceptionUnit)
                {
                    if (separate)
                    {
                        builder.Append(",");
                    }
                    else
                    {
                        separate = true;
                    }

                    builder.Append(String.Format("\"{0}\"", t));
                }

                builder.Append("]");

                return builder.ToString();
            }
        }

        private enum EditingMode
        {
            Text,
            Integer,
            Boolean,
            DateTime,
            List,
            Float
        };

        private const string SelectedTypeKey = "AttributeType";
        private const AttributeType DefaultAttributeType = AttributeType.Text;

        public AttributeType AttributeType
        {
            set
            {
                ViewState[SelectedTypeKey] = value;
                SetEditingMode(DisplayUnitType, value);
            }
            get
            {
                if (ViewState[SelectedTypeKey] != null)
                {
                    return (AttributeType)ViewState[SelectedTypeKey];
                }
                return DefaultAttributeType;
            }
        }

        private void SetEditingMode(DisplayUnitType? displayUnitType, AttributeType type)
        {
            SetEditingMode(_textTypeExceptionUnit.Contains(displayUnitType)
                ? EditingMode.Text
                : DetermineEditingMode(type));
        }

        private EditingMode DetermineEditingMode(AttributeType type)
        {
            EditingMode editingMode;

            switch (type)
            {
                case AttributeType.Text:
                case AttributeType.URL:
                    editingMode = EditingMode.Text;
                    break;
                case AttributeType.Integer:
                case AttributeType.Number:
                case AttributeType.Period:
                    editingMode = EditingMode.Integer;
                    break;
                case AttributeType.YesNo:
                    editingMode = EditingMode.Boolean;
                    break;
                case AttributeType.DateTime:
                    editingMode = EditingMode.DateTime;
                    break;
                case AttributeType.List:
                    editingMode = EditingMode.List;
                    break;
                default:
                    editingMode = EditingMode.Float;
                    break;
            }

            return editingMode;
        }

        public string SelectedControlClientId { get; set; }

        public Type SelectedControlType { get; set; }

        protected Control SelectedControl { get; set; }

        private void SetEditingMode(EditingMode editingMode)
        {
            RadTextBoxTextRegularValidator.Enabled = false;

            switch (editingMode)
            {
                case EditingMode.Text:
                    RadPageViewText.Selected = true;
                    RadTextBoxTextRegularValidator.ValidationExpression = TryGetRegularExpression(DisplayUnitType);
                    RadTextBoxTextRegularValidator.Enabled = true;

                    SelectedControl = RadTextBoxText;
                    SelectedControlType = typeof(RadTextBox);
                    break;

                case EditingMode.Float:
                    RadPageViewNumeric.Selected = true;
                    RadNumericTextBox.NumberFormat.DecimalDigits = 2;

                    SelectedControl = RadNumericTextBox;
                    SelectedControlType = typeof(RadNumericTextBox);
                    break;

                case EditingMode.Integer:
                    RadPageViewNumeric.Selected = true;
                    RadNumericTextBox.NumberFormat.DecimalDigits = 0;

                    SelectedControl = RadNumericTextBox;
                    SelectedControlType = typeof(RadNumericTextBox);
                    break;

                case EditingMode.Boolean:
                    RadPageViewBoolean.Selected = true;

                    SelectedControl = YesNoRadioControl;
                    SelectedControlType = typeof(YesNoRadioControl.YesNoRadioControl);
                    break;

                case EditingMode.DateTime:
                    RadPageViewDateTime.Selected = true;

                    SelectedControl = RadDatePicker;
                    SelectedControlType = typeof(RadDatePicker);
                    break;

                case EditingMode.List:
                    RadPageViewList.Selected = true;

                    SelectedControl = RadComboBoxList;
                    SelectedControlType = typeof(RadComboBox);
                    break;
            }

            if (editingMode != EditingMode.List) return;

            BindRadComboBoxList();

            if (RadComboBoxList.Items.Count > 0)
            {
                RadComboBoxList.Items[0].Selected = true;
            }
        }

        private static String TryGetRegularExpression(DisplayUnitType? displayUnitType)
        {
            var expression = ".*";

            if (displayUnitType == null)
                return expression;

            try
            {
                using (var client = new AttributeClient())
                {
                    expression = client.GetAttributeValueParserRegularExpression((DisplayUnitType)displayUnitType);
                }
            }
            catch (Exception)
            {
            }

            return expression;
        }

        public string StringValue
        {
            get
            {
                return AttributeType == AttributeType.List ? RadComboBoxList.Text : RadTextBoxText.Text;
            }
            set
            {
                if (AttributeType == AttributeType.List)
                {
                    var item = RadComboBoxList.FindItemByText(value);
                    if (item != null)
                    {
                        item.Selected = true;
                    }
                    else
                    {
                        item = new RadComboBoxItem
                        {
                            Text = value
                        };
                        RadComboBoxList.Items.Add(item);
                        item.Selected = true;
                    }
                }
                else
                {
                    RadTextBoxText.Text = value;
                }

            }
        }

        public Double? DoubleValue
        {
            get
            {
                Double d;
                if (Double.TryParse(RadNumericTextBox.Text, NumberStyles.Any, CultureInfo.CurrentUICulture, out d))
                {
                    return d;
                }
                return null;
            }
            set
            {
                if (value.HasValue)
                {
                    RadNumericTextBox.Text = value.Value.ToString(Thread.CurrentThread.CurrentUICulture);
                }
            }
        }

        public int? IntegerValue
        {
            get
            {
                if (AttributeType == AttributeType.YesNo) return YesNoRadioControl.Value ? 1 : 0;

                int i;
                if (int.TryParse(RadNumericTextBox.Text, NumberStyles.Any, CultureInfo.CurrentUICulture, out i))
                {
                    return i;
                }
                return null;
            }
            set
            {
                if (!value.HasValue) return;

                RadNumericTextBox.Text = value.Value.ToString(Thread.CurrentThread.CurrentUICulture);

                YesNoRadioControl.Value = value.Value != 0;
            }
        }

        public DateTime? DateTimeValue
        {
            get
            {
                return RadDatePicker.SelectedDate;
            }
            set
            {
                if (value.HasValue)
                {
                    RadDatePicker.SelectedDate = value.Value;
                }
            }
        }

        public DisplayUnitType? DisplayUnitType
        {
            get
            {
                if (!string.IsNullOrEmpty(RadComboBoxUnit.SelectedValue))
                {
                    return (DisplayUnitType)Enum.Parse(typeof(DisplayUnitType), RadComboBoxUnit.SelectedValue);
                }
                return null;
            }
            set
            {
                if (value.HasValue)
                {
                    RadComboBoxUnit.SelectedValue = value.ToString();
                }
                else
                {
                    RadComboBoxUnit.ClearSelection();
                }

                SetEditingMode(value, AttributeType);
            }
        }

        private const string AttributeNameKey = "AttributeName";
        public string AttributeName
        {
            get
            {
                return ViewState[AttributeNameKey] as string;
            }
            set
            {
                ViewState[AttributeNameKey] = value;
            }
        }

        private const string UnitTypeKey = "UnitType";
        public UnitType? UnitType
        {
            get
            {
                return ViewState[UnitTypeKey] is UnitType ? (UnitType)ViewState[UnitTypeKey] : (UnitType?)null;
            }
            set
            {
                ViewState[UnitTypeKey] = value;

                if (!_fastEditingMode)
                {
                    RadComboBoxUnit.Visible = value.HasValue;
                }

                if (value.HasValue)
                {
                    BindUnitsForUnitType(value.Value);
                }
                else
                {
                    RadComboBoxUnit.Items.Clear();
                }

                SetEditingMode(DisplayUnitType, AttributeType);
            }
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            using (var client = new AttributeClient())
            {
                _textTypeExceptionUnit.AddRange(client.GetDisplayUnitType().Where(t => t.DataType != null).Select(t => (DisplayUnitType?)t.DisplayUnitType).ToList());
            }
        }

        public System.Web.UI.WebControls.Unit ControlsWidth
        {
            set
            {
                RadTextBoxText.Width = value;
                RadNumericTextBox.Width = value;
                RadDatePicker.Width = value;
                RadComboBoxList.Width = value;
                //RadComboBoxUnit.Width = value;
            }
        }

        private bool _fastEditingMode;
        public bool FastEditingMode
        {
            get { return _fastEditingMode; }
            set
            {
                _fastEditingMode = value;

                RadComboBoxUnit.Visible = !value;
            }
        }

        public FontInfo Font
        {
            get { return RadTextBoxText.Font; }
            set
            {
                RadTextBoxText.Font.CopyFrom(value);
                RadNumericTextBox.Font.CopyFrom(value);
                YesNoRadioControl.Font.CopyFrom(value);
                RadDatePicker.Font.CopyFrom(value);
                RadComboBoxList.Font.CopyFrom(value);
                RadComboBoxUnit.Font.CopyFrom(value);
            }
        }

        public PropertyValueControl()
        {
            _fastEditingMode = false;
        }

        private void BindUnitsForUnitType(UnitType unitType)
        {
            using (var attributeClient = new AttributeClient())
            {
                var unitArray = attributeClient.GetUnitsOfUnitType(unitType);

                RadComboBoxUnit.DataSource = unitArray.Select(u => new { Value = u.ToString(), Name = GetGlobalResourceObject("Resource", u.ToString()) }).ToList();
                RadComboBoxUnit.DataBind();
            }
        }

        private void BindRadComboBoxList()
        {
            dynamic ecodomusMasterPage = Page.Master;
            if (ecodomusMasterPage == null) return;

            var facilityIds = ecodomusMasterPage.GetCheckedFacilityIds().ToArray();
            string[] valuesOfAttribute;

            using (var attributeClient = new AttributeClient())
            {
                valuesOfAttribute = attributeClient.GetAllValuesOfStringAttribute(AttributeName, facilityIds, SessionController.ConnectionString);
            }

            RadComboBoxList.DataSource = valuesOfAttribute.OrderBy(v => v);
            RadComboBoxList.DataBind();
        }

        protected void btnUnit_IndexChanged_Click(object sender, EventArgs e)
        {
            var displayUnitType = (DisplayUnitType)Enum.Parse(typeof(DisplayUnitType), RadComboBoxUnit.SelectedValue);
            SetEditingMode(displayUnitType, AttributeType);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //ScriptManager.RegisterClientScriptInclude(Page, typeof(Page), "PropertyValueControl", ResolveClientUrl("PropertyValueControl.js"));

            //var scriptManager = ScriptManager.GetCurrent(Page);
            //scriptManager.Scripts.Add(new ScriptReference{Path = ResolveClientUrl("PropertyValueControl.js")});

            const bool needToAddScriptTags = true;
            var clientIdWithoutInvalidCharacters = GetClientIdWithoutInvalidCharacters();

            // RadComboBoxUnit.OnClientSelectedIndexChanging
            var radComboBoxUnitOnClientSelectedIndexChangingFunctionName = "RadComboBoxUnitOnClientSelectedIndexChanging" + clientIdWithoutInvalidCharacters;
            
            var radComboBoxUnitOnClientSelectedIndexChangingFunctionScript =
                "function " + radComboBoxUnitOnClientSelectedIndexChangingFunctionName + " (s, e) {" +
                //" try{ "+
                    "var propertyValueControl = $find(\"" + ClientID + "\");" +
                    "propertyValueControl.comboBoxUnit_IndexChanging(s, e);" + 
                  //  " } catch(e) {} "+
                "}";

            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), radComboBoxUnitOnClientSelectedIndexChangingFunctionName, radComboBoxUnitOnClientSelectedIndexChangingFunctionScript, needToAddScriptTags);

            RadComboBoxUnit.OnClientSelectedIndexChanging = radComboBoxUnitOnClientSelectedIndexChangingFunctionName;



            // RadComboBoxUnit.OnClientSelectedIndexChanged
            var radComboBoxUnitOnClientSelectedIndexChangedFunctionName = "RadComboBoxUnitOnClientSelectedIndexChanged" + clientIdWithoutInvalidCharacters;

            var radComboBoxUnitOnClientSelectedIndexChangedFunctionScript =
                "function " + radComboBoxUnitOnClientSelectedIndexChangedFunctionName + " (s, e) {" +
                //" try{ " +
                    "var propertyValueControl = $find(\"" + ClientID + "\");" +
                    "propertyValueControl.comboBoxUnit_IndexChanged(s, e);" +
                  //  " } catch(e) {} " +
                "}";

            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), radComboBoxUnitOnClientSelectedIndexChangedFunctionName, radComboBoxUnitOnClientSelectedIndexChangedFunctionScript, needToAddScriptTags);

            RadComboBoxUnit.OnClientSelectedIndexChanged = radComboBoxUnitOnClientSelectedIndexChangedFunctionName;



            // YesNoRadioControl.OnClientBlur
            //var onClientBlurFunctionName = "OnClientBlurFunctionName" + clientIdWithoutInvalidCharacters;

            //var onClientBlurFunctionScript =
            //    "function " + onClientBlurFunctionName + " () {" +
            //        "var propertyValueControl = $find(\"" + ClientID + "\");" +
            //        "propertyValueControl.tryInvokeOnBlurEventHandler();" +
            //    "}";

            //ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), onClientBlurFunctionName, onClientBlurFunctionScript, needToAddScriptTags);

            //YesNoRadioControl.OnClientBlur = onClientBlurFunctionName;

            var radTextBoxTextOnKeyPressFunctionName = "RadTextBoxTextOnKeyPress" + clientIdWithoutInvalidCharacters;

            var radTextBoxTextOnKeyPressFunctionScript =
                "function " + radTextBoxTextOnKeyPressFunctionName + "(s, e){" +
                    "var keyCode = e.get_keyCode();" +
                    "if (keyCode == 13) {" +
                        "e.get_domEvent().preventDefault();" +
                //"s.blur();" +
                        "return;" +
                    "}" +
                "}";

            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), radTextBoxTextOnKeyPressFunctionName, radTextBoxTextOnKeyPressFunctionScript, needToAddScriptTags);

            // RadTextBoxText ClientEvents
            //RadTextBoxText.ClientEvents.OnBlur = onClientBlurFunctionName;
            RadTextBoxText.ClientEvents.OnKeyPress = radTextBoxTextOnKeyPressFunctionName;

            // RadNumericTextBox ClientEvents
            //RadNumericTextBox.ClientEvents.OnBlur = onClientBlurFunctionName;
            RadNumericTextBox.ClientEvents.OnKeyPress = radTextBoxTextOnKeyPressFunctionName;

            // RadDatePicker ClientEvents
            //RadDatePicker.ClientEvents.OnPopupClosing = onClientBlurFunctionName;
            //RadDatePicker.DateInput.ClientEvents.OnBlur = onClientBlurFunctionName;
            RadDatePicker.DateInput.ClientEvents.OnKeyPress = radTextBoxTextOnKeyPressFunctionScript;

            var radComboBoxOnClientKeyPressingFunctionName = "radComboBoxOnClientKeyPressing" + clientIdWithoutInvalidCharacters;

            var radComboBoxOnClientKeyPressingFunctionScript =
                "function " + radComboBoxOnClientKeyPressingFunctionName + "(s, e){" +
                    "var keyCode = e.get_domEvent().keyCode;" +
                    "if (keyCode == 13) {" +
                        "e.get_domEvent().preventDefault();" +
                //onClientBlurFunctionName + "();" +
                        "return;" +
                    "}" +
                "}";

            // RadComboBoxList ClientEvents
            //RadComboBoxList.OnClientBlur = onClientBlurFunctionName;
            RadComboBoxList.OnClientKeyPressing = radComboBoxOnClientKeyPressingFunctionScript;
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (SelectedControl != null)
                SelectedControlClientId = SelectedControl.ClientID;
        }
    }
}