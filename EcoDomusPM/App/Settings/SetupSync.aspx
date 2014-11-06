<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="SetupSync.aspx.cs" Inherits="App_Settings_SetupSync" %>

<%@ Reference Control="~/App/UserControls/SyncProfileCS.ascx" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/App/UserControls/PreviewCS.ascx" TagName="PreviewCS" TagPrefix="uc9" %>
<%--<%@ Register Src="../UserControls/SyncProfileCS.ascx" TagName="SyncCS" TagPrefix="uc1" %>
<%@ Register Src="../UserControls/FacilityCS.ascx" TagName="FacilityCS" TagPrefix="uc2" %>
<%@ Register Src="../UserControls/MapIntegrationCS.ascx" TagName="MapIntegrationCS" TagPrefix="uc3" %>
<%@ Register Src="../UserControls/AssetTypeCS.ascx" TagName="AssetTypeCS" TagPrefix="uc4" %>
<%@ Register Src="../UserControls/SchedulerCS.ascx" TagName="SchedulerCS" TagPrefix="uc5" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<style type="text/css">
.fieldsetstyle
    {
        border: 1.5px solid black;
    }
     
</style>
<script type="text/javascript" >
    window.onload = body_load;
    function body_load() {
        var screenhtg = set_NiceScrollToPanel();
    }
</script>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <%--<div style="background-color: #E2EACE; border: 2px">--%>
     <div style="background-color:transparent; border: 2px">
        <table width="100%" border="0" cellspacing="10" cellpadding="0">
            <caption>
                <asp:Label ID="lblWizardTitle" runat="server" Text="<%$Resources:Resource,Setup_Sync_Wizard%>"></asp:Label>
            </caption>
            <%-- <telerik:RadScriptManager ID="ScriptManager" runat="server" />--%>
            <%--<telerik:RadAjaxLoadingPanel runat="server" ID="LoadingPanel1">
            </telerik:RadAjaxLoadingPanel>
            <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel1" LoadingPanelID="LoadingPanel1"
                Height="100%">--%>
            <tr>
                <td colspan="2" style="width: 80%">
                    <telerik:RadTabStrip ID="rdstripSetupSync" SelectedIndex="0" runat="server" MultiPageID="rmpageSetupSync"
                      OnTabClick="rdstripSetupSync_TabClick" CausesValidation="True" ValidationGroup="LoginValidationGroup">
                    </telerik:RadTabStrip>
                </td>
            </tr>
            <tr>
                <td valign="top" style="width: 60%">
                   <%-- <fieldset class="fieldsetstyle1">--%>
                        <table width="100%">
                            <tr>
                                <td style="width: 100%">
                                    <telerik:RadMultiPage ID="rmpageSetupSync" runat="server" CssClass="multiPage" SelectedIndex="0"
                                        OnPageViewCreated="RadMultiPage1_PageViewCreated">
                                    </telerik:RadMultiPage>
                                </td>
                            </tr>
                        </table>
                   <%-- </fieldset>--%>
                </td>
                <td valign="top" style="width: 40%">
                    <fieldset class="fieldsetstyle">
                        <table width="100%">
                            <tr>
                                <td>
                                    <div>
                                        <uc9:PreviewCS ID="previewControl" runat="server" />
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
            <%--</telerik:RadAjaxPanel>--%>
        </table>
        <asp:HiddenField ID="hdnFacilityIDs" runat="server"></asp:HiddenField>
        <asp:HiddenField ID="hdnFacilityNames" runat="server"></asp:HiddenField>
        <asp:HiddenField ID="hf_file_path" runat="server" value=""/>
        <asp:HiddenField ID="hf_external_system" runat="server" Value="" />
    </div>
</asp:Content>
