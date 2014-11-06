<%@ Page Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true" CodeFile="EnergyModelingSimulationOutput.aspx.cs" Inherits="App_NewUI_EnergyModelingSimulationOutput" %>
<%@ Register Src="~/App/UserControls/UserControlNewUI/EnergyModelingSimulation.ascx" TagName="simulation" TagPrefix="em" %>
<%@ Register Src="~/App/UserControls/UserControlNewUI/EnergyModelingSimulationOutput.ascx"  TagName="output" TagPrefix="em"%>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
 <script type="text/javascript" >
     
 </script>
</telerik:RadCodeBlock>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="RadioButtons, Buttons, Scrollbars, Textbox, Select" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/Skins/MyCustomTabStrip/TabStrip.MyCustomTabStrip.css" />
    <table border="0" cellpadding="0" cellspacing="0" width="98%">
        <tr>
            <td style="border-bottom-color: transparent; border-bottom-width: 0px">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color: #F7F7F7;
                    border-collapse: collapse; border-width: 0px">
                    <tr>
                        <td style="background-color: #F7F7F7">
                            <telerik:RadTabStrip ID="radtabstrip_simulation_output" runat="server" MultiPageID="rmp_simulation_output"
                                SelectedIndex="0" Width="178px" EnableEmbeddedSkins="False" Skin="MyCustomTabStrip"
                                ShowBaseLine="True">
                                <Tabs>
                                    <telerik:RadTab Text="Simulation" Font-Bold="true" runat="server" PageViewID="rpv_simulation"
                                        BorderColor="Gray" Selected="True">
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Output" Font-Bold="true" runat="server" PageViewID="rpv_output"
                                        Selected="True">
                                    </telerik:RadTab>
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
                <telerik:RadMultiPage ID="rmp_simulation_output" runat="server" SelectedIndex="0" Width="100%">
                    <telerik:RadPageView runat="server" ID="rpv_simulation" Selected="true">
                        <em:simulation ID="comparision1" runat="server"></em:simulation>
                    </telerik:RadPageView>
                    <telerik:RadPageView runat="server" ID="rpv_output" Selected="false">
                        <em:output ID="browse" runat="server"></em:output>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
    </table>
</asp:Content>
