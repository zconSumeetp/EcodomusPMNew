<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PropertyValueControl.ascx.cs" Inherits="App.UserControls.PropertyValueControl" %>
<%@ Import Namespace="App.UserControls.YesNoRadioControl" %>
<%@ Import Namespace="Attributes" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="../YesNoRadioControl/YesNoRadioControl.ascx" TagPrefix="uc" TagName="YesNoRadioControl" %>

<telerik:RadScriptBlock runat="server">
    <script type="text/javascript">
        Sys.Application.add_load(function () {    // On 'add_init' $find not find telerik controls
            var prevInstance = $find("<%= ClientID %>");
            //console.log("Exist: " + !!prevInstance);
            if (prevInstance) return;

            $create
            (
                PropertyValueControl,
                {
                    id: "<%= ClientID %>",
                    onClientBlurEventHandler: "<%= OnClientBlur %>",
                    comboBoxUnit_IndexChange_UnitException: <%= TextTypeExceptionUnit %>,
                    comboBoxUnit_PrevUnitInException: false,
                    radAjaxManagerClientId: "<%= RadAjaxManager.GetCurrent(Page).ClientID %>",
                    btnUnitIndexChangedClientID: "<%= btnUnit_IndexChanged.ClientID %>",
                    selectedControlClientId: "<%= SelectedControlClientId %>",
                    selectedControlType: "<%= SelectedControlType %>",

                    radTextBoxType: "<%= typeof(RadTextBox) %>",
                    radNumericTextBoxType: "<%= typeof(RadNumericTextBox) %>",
                    yesNoRadioControlType: "<%= typeof(YesNoRadioControl) %>",
                    radDatePickerType: "<%= typeof(RadDatePicker) %>",
                    radComboBoxType: "<%= typeof(RadComboBox) %>",

                    radTextBoxTextClientId: "<%= RadTextBoxText.ClientID %>",
                    radNumericTextBoxClientId: "<%= RadNumericTextBox.ClientID %>",
                    yesNoRadioControlClientId: "<%= YesNoRadioControl.ClientID %>",
                    radDatePickerClientId: "<%= RadDatePicker.ClientID %>",
                    radComboBoxListClientId: "<%= RadComboBoxList.ClientID %>",

                    attributeType: "<%= AttributeType %>",

                    attributeTypeList: "<%= AttributeType.List %>",
                    attributeTypeYesNo: "<%= AttributeType.YesNo %>"

                }
            );
        });


    </script>
</telerik:RadScriptBlock>

<telerik:RadAjaxManagerProxy runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnUnit_IndexChanged"> 
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadAjaxPanelPropertyValueControl" LoadingPanelID="RadAjaxLoadingPanelPropertyValueControl" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanelPropertyValueControl" Skin="Default"></telerik:RadAjaxLoadingPanel>

<telerik:RadAjaxPanel runat="server" ID="RadAjaxPanelPropertyValueControl" style="border:0">
    <table style="border:0" cellpadding="0" cellspacing="0">
        <tr style="border:0">
            <td style="border:0">
                <telerik:RadMultiPage ID="RadMultiPageMultiControl" runat="server" SelectedIndex="0" RenderSelectedPageOnly="True">
                    <telerik:RadPageView runat="server" ID="RadPageViewText">
                         <telerik:RadTextBox ID="RadTextBoxText" runat="server"></telerik:RadTextBox>
                        <%--<telerik:RadTextBox ID="RadTextBoxText" runat="server" Width="150px" ValidationGroup="ValidationGroup1" SelectionOnFocus="CaretToEnd" />--%>
                    </telerik:RadPageView>
                    <telerik:RadPageView runat="server" ID="RadPageViewNumeric">
                        <telerik:RadNumericTextBox ID="RadNumericTextBox" runat="server" Width="150px" Value="0" SelectionOnFocus="CaretToEnd" EnableSingleInputRendering="True">
                            <IncrementSettings InterceptArrowKeys="True" InterceptMouseWheel="True" />
                            <NumberFormat GroupSeparator="" />
                        </telerik:RadNumericTextBox>
                    </telerik:RadPageView>
                    <telerik:RadPageView runat="server" ID="RadPageViewBoolean">
                        <uc:YesNoRadioControl runat="server" ID="YesNoRadioControl" />
                    </telerik:RadPageView>
                    <telerik:RadPageView runat="server" ID="RadPageViewDateTime">
                        <telerik:RadDatePicker ID="RadDatePicker" runat="server" Width="150px"> 
                            <DateInput runat="server" SelectionOnFocus="CaretToEnd" />
                        </telerik:RadDatePicker>
                    </telerik:RadPageView>
                    <telerik:RadPageView runat="server" ID="RadPageViewList">
                        <telerik:RadComboBox ID="RadComboBoxList" runat="server" AutoPostBack="False" CssClass="ComboBox" DropDownCssClass="ComboBoxDropDown" 
                                             Width="150px" AllowCustomText="True" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
            <td style="border-left: 5px solid transparent">
                <telerik:RadComboBox ID="RadComboBoxUnit" runat="server" Label="Unit:" DataTextField="Name" DataValueField="Value" AutoPostBack="False" CssClass="ComboBox" DropDownCssClass="ComboBoxDropDown" Width="150px" />
                <asp:RegularExpressionValidator runat="server" ClientIDMode="Static" ID="RadTextBoxTextRegularValidator" SetFocusOnError="true" ValidationGroup="ValidationGroup1" ValidationExpression='.*' ControlToValidate="RadTextBoxText" ErrorMessage="Invalid field format" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="HiddenFieldUnitTypeUnits" runat="server" />
    <%--<telerik:RadButton runat="server" ID="btnUnit_IndexChanged" Visible="false" OnClick="btnUnit_IndexChanged_Click"></telerik:RadButton>--%>
</telerik:RadAjaxPanel>
<div style="display: none"> 
    <telerik:RadButton runat="server" ID="btnUnit_IndexChanged" Visible="True" OnClick="btnUnit_IndexChanged_Click"></telerik:RadButton>
</div>
