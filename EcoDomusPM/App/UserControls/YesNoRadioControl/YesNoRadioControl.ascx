<%@ Control Language="C#" AutoEventWireup="true" CodeFile="YesNoRadioControl.ascx.cs" Inherits="App.UserControls.YesNoRadioControl.YesNoRadioControl" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<telerik:RadScriptBlock runat="server">
    <script type="text/javascript">
        Sys.Application.add_init(function () {    // On 'add_init' $find not find 'RadButtonYes'
            $create
            (
                YesNoRadioControl,
                {
                    id: "<%= ClientID %>",
                    onClientBlurEventHandler: "<%= OnClientBlur %>",
                    radButtonYesClientId: "<%= RadButtonYes.ClientID %>",
                    radButtonNoClientId: "<%= RadButtonNo.ClientID %>"   // Must be last parameter
                }
            );
        });

        function RadButtonYes_OnClientLoad(s, e) {
            <%--var radButtonYesClientId = $find("<%= RadButtonYes.ClientID %>");
            debugger;--%>
        }
    </script>
</telerik:RadScriptBlock>

<div>
    <telerik:RadButton ID="RadButtonYes" runat="server" ToggleType="Radio" ButtonType="ToggleButton" Text="Yes" AutoPostBack="False" Checked="True" />
    <telerik:RadButton ID="RadButtonNo" runat="server" ToggleType="Radio" ButtonType="ToggleButton" Text="No" AutoPostBack="False" />
</div>