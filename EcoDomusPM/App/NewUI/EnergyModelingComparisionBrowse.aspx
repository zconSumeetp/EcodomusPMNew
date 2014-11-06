<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true" CodeFile="EnergyModelingComparisionBrowse.aspx.cs" Inherits="App_NewUI_EnergyModelingComparisionBrowse" EnableEventValidation="false" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Charting" tagprefix="telerik" %>
<%@ Register Src="~/App/UserControls/UserControlNewUI/EnergyModelingComparision.ascx" TagName="comparision" TagPrefix="em" %>
<%--<%@ Register Src="~/App/UserControls/UserControlNewUI/EnergyModelingBrowse.ascx"  TagName="browse" TagPrefix="em"%>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <script type="text/javascript">
     function adjust_height() {
         var wnd = GetRadWindow();
         if (wnd != null) {
             var bounds = wnd.getWindowBounds();
             var x = bounds.x;
             var y = bounds.y;
             //alert(x);
             //alert(y);
             wnd.moveTo(x, 25);
             //alert('window page' + document.body.scrollHeight);
             wnd.set_height(document.body.scrollHeight + 20)
             // alert('window page' + document.body.offsetWidth);
             //wnd.set_width(document.body.scrollWidth+200)
         }
     }


 </script>
 <%--<asp:ScriptManager ID="ScriptManagerId" runat="server" AsyncPostBackTimeout="3600">
    </asp:ScriptManager>--%>
    <asp:ScriptManagerProxy ID="ScriptManager1" runat="server"></asp:ScriptManagerProxy>
 
 <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" 
        DecoratedControls="RadioButtons, Buttons, Scrollbars, Textbox, Select" />
        <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
        <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/Skins/MyCustomTabStrip/TabStrip.MyCustomTabStrip.css" />
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td style="border-bottom-color: transparent; border-bottom-width: 0px">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color: #F7F7F7;border-collapse: collapse; border-width: 0px">
                    <tr>
                        <td style="background-color: #F7F7F7">
                            <telerik:RadTabStrip ID="radtabstrip_Statements" runat="server" MultiPageID="rmp_comparision_browse"
                                SelectedIndex="0"  Width="105px"   Skin="Default"
                                ShowBaseLine="True" >
                                <Tabs>
                                    <telerik:RadTab Text="Comparison" Font-Bold="true" runat="server" PageViewID="rpv_comparision"
                                        BorderColor="Gray" Selected="True">
                                    </telerik:RadTab>
                                   <%-- <telerik:RadTab Text="Browse" Font-Bold="true" runat="server" 
                                        PageViewID="rpv_browse" Selected="True">
                                    </telerik:RadTab>--%>
                                </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                        <td align="right">
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
                <telerik:RadMultiPage ID="rmp_comparision_browse" runat="server" 
                    SelectedIndex="0">
                    <telerik:RadPageView runat="server" ID="rpv_comparision" Selected="true" >
                        <em:comparision ID="comparision1" runat="server" />
                    </telerik:RadPageView>
                     <%--<telerik:RadPageView runat="server" ID="rpv_browse" Selected="false">
                     <em:browse id="browse" runat="server"></em:browse>
                     </telerik:RadPageView>--%>
                </telerik:RadMultiPage>
            </td>
        </tr>
    </table>

    
</asp:Content>

