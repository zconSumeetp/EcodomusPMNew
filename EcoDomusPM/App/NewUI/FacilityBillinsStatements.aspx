<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomusPM_Master.master"  AutoEventWireup="true"
    CodeFile="FacilityBillinsStatements.aspx.cs" Inherits="App_NewUI_FacilityBillinsStatements" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/App/NewUI/User Controls/AddUtilityData.ascx" TagName="FacilityBillimgStatement"
    TagPrefix="FBS" %>
<%@ Register Src="~/App/NewUI/User Controls/UtilityRateSchedules.ascx" TagName="UtilityRateschedules"
    TagPrefix="URS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        var panelBar;
        var panelBarProductsTab;
        var multiPage;

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }
    </script>
    <style type="text/css">
        div
        {
            overflow-x: hidden;
        }
      
      
    </style>
    <link href="../../App_Themes/EcoDomus/Skins/MyCustomTabStrip/TabStrip.MyCustomTabStrip.css"
        rel="stylesheet" type="text/css" />
  <%--  <link href="../../Skins/MyCustomTabStrip/TabStrip.MyCustomTabStrip.css" rel="stylesheet"
        type="text/css" />--%>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" DecoratedControls="RadioButtons,Scrollbars,Buttons" />
    <table id="tbl_containing" runat="server" border="0" width="95%" class="tablecolor"
        cellpadding="0" cellspacing="0">
        <tr id="tr_radtab">
            <td width="100%">
                <table width="95%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <telerik:RadTabStrip ID="radtabstrip_Statements" runat="server" MultiPageID="RadMultiPageStatements"
                                SelectedIndex="0" EnableEmbeddedSkins="false" Skin="MyCustomTabStrip">
                                <Tabs>
                                    <telerik:RadTab Text="Statements" Font-Bold="true" runat="server" PageViewID="radPageView_statements"
                                        BorderColor="Gray" Selected="True">
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Rate Schedules" Font-Bold="true" runat="server" PageViewID="radPageView_schedules">
                                    </telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                         <td align="right">
                                            <asp:ImageButton ID="ibtn_Edit" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                                Width="15" Height="15" ImageAlign="Bottom" />
                                        </td>
                                        <td width="4%" align="right" right" style="padding-right:5px;vertical-align:middle;">
                                            <asp:LinkButton ID="lbtn_edit" ForeColor="#585858" Font-Bold="true" Font-Names="Arial"
                                                runat="server" Text="EDIT" CssClass="lnkButton"></asp:LinkButton>
                                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width="100%">
                <telerik:RadMultiPage ID="RadMultiPageStatements" runat="server" SelectedIndex="0">
                    <telerik:RadPageView runat="server" ID="radPageView_statements" Selected="true">
                        <FBS:FacilityBillimgStatement ID="FBS" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView runat="server" ID="radPageView_schedules">
                        <URS:UtilityRateschedules ID="URS" runat="server" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
    </table>
</asp:Content>
