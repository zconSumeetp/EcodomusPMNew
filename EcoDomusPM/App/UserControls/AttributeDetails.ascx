<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AttributeDetails.ascx.cs" Inherits="App.UserControls.AttributeDetails" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<%@ Register Src="PropertyValueControl/PropertyValueControl.ascx" TagName="PropertyValueControl" TagPrefix="uc" %>

<telerik:RadScriptBlock runat="server">
    <script type="text/javascript">
        function RadButtonUpdateDummy_OnClientClicked(sender, eventArgs) {
            if (Page_ClientValidate()) {
                var radButtonUpdate = $find("<%=RadButtonUpdate.ClientID%>");
                radButtonUpdate.click();
            }
        }

        function RadButtonInsertDummy_OnClientClicked(sender, eventArgs) {
            if (Page_ClientValidate()) {
                var radButtonInsert = $find("<%=RadButtonInsert.ClientID%>");
                radButtonInsert.click();
            }
        }

        function RadButtonCancelDummy_OnClientClicked(sender, eventArgs) {
            var radButtonCancel = $find("<%=RadButtonCancel.ClientID%>");
            radButtonCancel.click();
        }
    </script>
</telerik:RadScriptBlock>

<telerik:RadAjaxManagerProxy runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="RadAjaxPanel1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadAjaxPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1" Skin="Default" Width="100%" />

<telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel1" LoadingPanelID="RadAjaxLoadingPanel1" Width="100%">  
    <table style="width: 100%">
        <tr style="width: 100%">
            <td style="width: 100%">    
                <table style="margin-left: 10px">
                    <tr id="R1">
                        <td id="R1C1" style="vertical-align: middle; text-align: right">
                            <asp:Label runat="server" Text="<%$Resources:Resource, Group%>" />:
                        </td>
                        <td id="R1C2" style="border-left: 5px solid transparent; vertical-align: middle">
                            <telerik:RadComboBox ID="RadComboBoxGroup" runat="server" Width="250px"
                                                    AllowCustomText="True" AutoPostBack="False" MarkFirstMatch="True" CausesValidation="True" 
                                /><asp:RequiredFieldValidator runat="server" ControlToValidate="RadComboBoxGroup" ErrorMessage="*" ForeColor="Red" 
                                                                ValidationGroup="ValidationGroupAttributeDetails" />
                        </td>
                    </tr>
                    <tr id="R2">
                        <td id="R2C1" style="vertical-align: middle; text-align: right">
                            <asp:Label runat="server" Text="<%$Resources:Resource, Name%>" />:    
                        </td>
                        <td id="R2C2" style="border-left: 5px solid transparent; vertical-align: middle">
                            <telerik:RadTextBox runat="server" ID="RadTextBoxAttributeName" Width="250px" EmptyMessage="Enter attribute name" CausesValidation="True" 
                            /><asp:RequiredFieldValidator runat="server" ControlToValidate="RadTextBoxAttributeName" ErrorMessage="*" ForeColor="Red" 
                                                            ValidationGroup="ValidationGroupAttributeDetails" />
                        </td>    
                    </tr>
                    <tr id="R3">
                        <td id="R3C1" style="vertical-align: middle; text-align: right">
                            <asp:Label runat="server" Text="<%$Resources:Resource, Value%>" />:
                        </td>
                        <td id="R3C2" style="border-left: 5px solid transparent; vertical-align: middle">
                            <uc:PropertyValueControl ID="PropertyValueControl" runat="server" ControlsWidth="250px" Font-Size="12px" />
                        </td>  
                    </tr>
                    <tr id="R4">
                        <td id="R4C1" style="vertical-align: middle; text-align: right">
                            <asp:Label runat="server" Text="<%$Resources:Resource, Description%>" />:
                        </td>
                        <td id="R4C2" style="border-left: 5px solid transparent; vertical-align: middle">
                            <telerik:RadTextBox runat="server" ID="RadTextBoxAttributeDescription" Width="250px" />
                        </td>
                    </tr>
                    <tr id="R5">
                        <td id="R5C1" style="vertical-align: middle; text-align: right">
                            <asp:Label runat="server" Text="<%$Resources:Resource, Type%>" />:
                        </td>
                        <td id="R5C2" style="border-left: 5px solid transparent; vertical-align: middle">
                            <telerik:RadComboBox ID="RadComboBoxAttributeType" runat="server" AllowCustomText="False" AutoPostBack="True"
                                                    OnItemDataBound="RadComboBoxAttributeType_OnItemDataBound"  
                                                    OnSelectedIndexChanged="RadComboBoxAttributeType_OnSelectedIndexChanged"  Width="250px" CausesValidation="False" />
                        </td>
                    </tr>
                    <tr id="R6">
                        <td id="R6C1" style="vertical-align: middle; text-align: right">
                            <asp:Label runat="server" Text="<%$Resources:Resource, Stage%>" />:
                        </td>
                        <td id="R6C2" style="border-left: 5px solid transparent; vertical-align: middle">
                            <telerik:RadComboBox ID="RadComboBoxStage" runat="server" AllowCustomText="False" AutoPostBack="False"
                                                 Width="250px" CausesValidation="False" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="border-bottom: 5px solid transparent">
                <div style="display: inline; width: 15px"></div>
                <telerik:RadButton ID="RadButtonUpdateDummy" Text="<%$Resources:Resource, Update%>" runat="server"
                            Visible='<%# !(DataItem is GridInsertionObject) %>' ValidationGroup="ValidationGroupAttributeDetails" AutoPostBack="False"
                            OnClientClicked="RadButtonUpdateDummy_OnClientClicked" style="margin: 0; border: 0" />    
                <telerik:RadButton ID="RadButtonInsertDummy" Text="Insert" runat="server" CommandName="PerformInsert" Visible='<%# DataItem is GridInsertionObject %>' 
                            ValidationGroup="ValidationGroupAttributeDetails" AutoPostBack="False" OnClientClicked="RadButtonInsertDummy_OnClientClicked" />    
                <telerik:RadButton ID="RadButtonCancelDummy" Text="<%$Resources:Resource, Cancel%>" runat="server" CausesValidation="False" 
                            AutoPostBack="false" OnClientClicked="RadButtonCancelDummy_OnClientClicked" style="margin: 0; border: 0"/>    
            </td>
        </tr>
    </table>
</telerik:RadAjaxPanel>
<div style="display: none"> 
    <telerik:RadButton runat="server" ID="RadButtonUpdate" CommandName="Update" Visible='<%# !(DataItem is GridInsertionObject) %>' />
    <telerik:RadButton runat="server" ID="RadButtonInsert" CommandName="PerformInsert" Visible='<%# DataItem is GridInsertionObject %>' />
    <telerik:RadButton runat="server" ID="RadButtonCancel" CausesValidation="False" CommandName="Cancel" />
</div>