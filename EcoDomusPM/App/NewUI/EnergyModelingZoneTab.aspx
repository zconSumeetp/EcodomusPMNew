<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true" CodeFile="EnergyModelingZoneTab.aspx.cs" Inherits="App_NewUI_EnergyModelingZoneTab" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Src="~/App/UserControls/UserControlNewUI/EnergyModelingZones.ascx" TagName="zone" TagPrefix="em" %>
<%@ Register Src="~/App/UserControls/UserControlNewUI/EnergyModelingZoneList.ascx"  TagName="zonelist" TagPrefix="em"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript" language="javascript">
    function adjust_height() {
        var wnd = GetRadWindow();
        if (wnd != null) {
            var bounds = wnd.getWindowBounds();
            var x = bounds.x;
            var y = bounds.y;        
            wnd.moveTo(x, 25);        
            wnd.set_height(document.body.scrollHeight + 20)        
        }
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    }

    function NiceScrollOnload() {
        if (screen.height > 721) {
            $("html").css('overflow-y', 'hidden');
            $("html").css('overflow-x', 'auto');
        }
        var screenhtg = set_NiceScrollToPanel();
    }

    
</script>
<link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
<link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/Skins/MyCustomTabStrip/TabStrip.MyCustomTabStrip.css" />

<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" 
        DecoratedControls="RadioButtons, Buttons, Scrollbars, Textbox, Select" />
        

      <asp:Panel ID="pnlSearch" DefaultButton="" BorderColor="Transparent" BorderWidth="0" runat="server">
    <table border="0" cellpadding="0" cellspacing="0" width="98%">
        <tr>
            <td style="border-bottom-color: transparent; border-bottom-width: 0px">
         <%--       <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color: #F7F7F7;border-collapse: collapse; border-width: 0px">--%>

         <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse">
                    <tr>
                       <%-- <td style="background-color: #F7F7F7">--%>
                       <td style="">
                            <telerik:RadTabStrip ID="radtabstrip_Statements" runat="server" MultiPageID="rmp_zone"
                                SelectedIndex="0"  Width="170px"  Skin="MyCustomTabStrip" EnableEmbeddedSkins="false"
                                ShowBaseLine="True" >
                                <Tabs>
                                    <telerik:RadTab Text="Zones" Font-Bold="true" runat="server" PageViewID="rpv_zone" Selected="true"
                                        BorderColor="Gray">
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Zone Lists" Font-Bold="true" runat="server" PageViewID="rpv_zonelist">
                                    </telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                        <td align="right" style="">
                            <table border="0">
                                <tr>
                                    <td align="right">
                                        <asp:ImageButton ID="img_edit" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                            Width="15" Height="15" ImageAlign="Bottom" />
                                        <asp:LinkButton ID="lbtn_edit" runat="server" Text="EDIT" ForeColor="Black" CssClass="lnkButton"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>

                <telerik:RadMultiPage ID="rmp_zone" runat="server" 
                    SelectedIndex="0">

                    <telerik:RadPageView runat="server" ID="rpv_zone" Selected="true" >
                        
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                        
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <em:zone ID="zone" runat="server" />
                        
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                        
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </telerik:RadPageView>

                     <telerik:RadPageView runat="server" ID="rpv_zonelist" Selected="false">
                         
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                         
                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <em:zonelist id="zonelist" runat="server"/>
                         
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                         
                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     </telerik:RadPageView>


                </telerik:RadMultiPage>

            </td>
        </tr>
    </table>
    </asp:Panel>
</asp:Content>

