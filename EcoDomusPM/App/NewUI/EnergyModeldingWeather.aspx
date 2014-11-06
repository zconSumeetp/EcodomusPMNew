<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomusPM_Master.master"  AutoEventWireup="true"
    CodeFile="EnergyModeldingWeather.aspx.cs" Inherits="App_NewUI_EnergyModeldingWeather" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
            <tr>
                <td style="width: 1042px">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color: #F7F7F7;
                        border-collapse: collapse; border-width: 0px">
                        <tr>
                            <td style="width: 10%">
                                <asp:Image ID="img_weather_tab" runat="server" ImageUrl="~/App/Images/Icons/Tab.png"
                                    Height="35" Width="90" />
                            </td>
                            <td style="width: 80%">
                            </td>
                            <td style="width: 10%" align="right">
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
                <td valign="top" style="width: 1042px">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin: 0px">
                        <tr>
                            <td style="padding-top: 15px; width: 500px;">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="background-image: url('/App/Images/asset_container_2.png'); height: 40px;
                                            width: 200px; background-repeat: no-repeat;" align="center">
                                            <asp:Label ID="lbl_project_name" runat="server" Text="Annex Simulation Project 1"
                                                Font-Size="10" ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                        </td>
                                        <td style="width: 5px">
                                        </td>
                                        <td style="background-image: url('/App/Images/asset_container_3.png'); height: 40px;
                                            width: 200px; background-repeat: no-repeat" align="center">
                                            <asp:Label ID="lbl_list" runat="server" Text="Weather" Font-Size="10" ForeColor="Red"
                                                CssClass="normalLabel"></asp:Label>
                                        </td>
                                        <%--     <td style="height: 15px; padding-left: 10px">
                                        <telerik:RadComboBox ID="cmb_search" runat="server" Width="200px" ExpandDirection="Down"
                                            Height="10px" ZIndex="10" Skin="Default">
                                        </telerik:RadComboBox>
                                    </td>--%>
                                        <%--  <td style="vertical-align: middle; padding-left: 5px; height: 15px" align="center">
                                        <asp:ImageButton ID="ibtn_search" runat="server" ImageUrl="~/App/Images/Icons/btnSearch.png" />
                                    </td>--%>
                                    </tr>
                                </table>
                                <table border="0" cellpadding="0" cellspacing="0" style="margin-top: 15px; margin-bottom: 15px;
                                    margin-left: 25px; width: 130px;">
                                    <asp:Label ID="lblheading" Text="Select weather configuration for the simulation project."
                                        runat="server" ForeColor="Black" Width="500" Font-Bold="true" Font-Size="Small"></asp:Label>
                                </table>
                                <table border="0" width="100%" cellpadding="0" cellspacing="0" align="left" style="background-image: url('/App/Images/asset_button_orange_large.png');
                                    background-repeat: no-repeat; background-position: inherit; height: 26px; width: 340px;
                                    margin-top: 0px; margin-bottom: 0px; margin-left: 25px;">
                                    <tr>
                                        <td style="padding-left: 5px; vertical-align: middle; width: 40px;">
                                            <%--<asp:CheckBox ID="chk_no_template" runat="server" Text="No Template"  CssClass="normalLabel"/>--%>
                                            <asp:Image ID="img_no_template" runat="server" ImageUrl="~/App/Images/Icons/asset_checkbox1.png" />
                                        </td>
                                        <td valign="middle" style="padding-left: 0px;">
                                            <asp:Label ID="lbl_none" runat="server" Text="NOAA Weather Data" CssClass="LabelNormal"
                                                Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width: 1042px">
                    <table>
                        <tr>
                            <td>
                                <table border="0" width="100%" cellpadding="0" cellspacing="0" align="left" style="background-repeat: no-repeat;
                                    background-position: inherit; height: 26px; width: 200px; margin-top: 0px; margin-bottom: 0px;
                                    margin-left: 25px;">
                                    <tr>
                                        <td style="padding-left: 5px;">
                                            <asp:Label ID="Label1" runat="server" Text="Select NOAA Weather Station" CssClass="LabelNormal"
                                                Font-Bold="true" ForeColor="#707070"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="padding-left: 140px;" >
                                <telerik:radbutton id="btnConfigure" runat="server" width="150px" text="Configure NOAA Weather"></telerik:radbutton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding-top: 0px; padding-left: 30px;">
                    <telerik:radcombobox id="cmb_Weatherstation" backcolor="#F7E7BD" forecolor="#F7E7BD" runat="server" width="488px">
                            
                         <Items>
                            <telerik:RadComboBoxItem Text="None" Value="" />
                            <telerik:RadComboBoxItem Text="1" Value=";" Selected="true" />
                            <telerik:RadComboBoxItem Text="2" Value="," />
                            <telerik:RadComboBoxItem Text="3" Value="|" />
                            <telerik:RadComboBoxItem Text="4" Value=";," />
                        </Items>
             
                             </telerik:radcombobox>
                </td>
            </tr>

            <tr>
                <td>
                      
                        <table border="0" width="100%" cellpadding="0" cellspacing="0" align="left" style="background-image: url('/App/Images/asset_button_orange_large.png');
                                    background-repeat: no-repeat; background-position: inherit; height: 26px; width: 340px;
                                    margin-top: 80px; margin-bottom: 15px; margin-left: 25px;">
                                    <tr>
                                        <td style="padding-left: 5px; vertical-align: middle; width: 40px;">
                                            <%--<asp:CheckBox ID="chk_no_template" runat="server" Text="No Template"  CssClass="normalLabel"/>--%>
                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/App/Images/Icons/asset_checkbox1.png" />
                                        </td>
                                        <td valign="middle" style="padding-left: 0px;">
                                            <asp:Label ID="Label3" runat="server" Text="Weather Data From File" CssClass="LabelNormal"
                                                Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                       </table>
                
                </td>
            
            
            
            
            </tr>
            <tr>
             <td style="width: 1042px">
                    <table>
                        <tr>
                            <td>
                                <table border="0" width="100%" cellpadding="0" cellspacing="0" align="left" style="background-repeat: no-repeat;
                                    background-position: inherit; height: 26px; width: 200px; margin-top: 15px; margin-bottom: 15px;
                                    margin-left: 25px;">
                                    <tr>
                                        <td style="padding-left: 5px;">
                                            <asp:Label ID="Label4" runat="server" Text="Select Weather Data File" CssClass="LabelNormal"
                                                Font-Bold="true" ForeColor="#707070"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="padding-left: 140px;" >
                                <telerik:radbutton id="btnUpload" runat="server" width="150px" text="Upload Weather Data Files"></telerik:radbutton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
              <td colspan="2" style="padding-top: 15px; padding-left: 30px;">
                    <telerik:radcombobox id="cmb_Weatherdata" backcolor="#F7E7BD" forecolor="#F7E7BD" runat="server" width="488px" SkinID="#F7E7BD">
                            
                         <Items>
                            <telerik:RadComboBoxItem Text="None" Value="" />
                            <telerik:RadComboBoxItem Text="1" Value=";" Selected="true" />
                            <telerik:RadComboBoxItem Text="2" Value="," />
                            <telerik:RadComboBoxItem Text="3" Value="|" />
                            <telerik:RadComboBoxItem Text="4" Value=";," />
                        </Items>
             
                             </telerik:radcombobox>
                </td>
            </tr>
            <tr>
                <td style="padding-top: 70px; padding-left: 30px;">
                    <asp:Label ID="lbllinkheading" runat="server" Text="Additional weather data files are available at:-" CssClass="LabelNormal"></asp:Label> <br />
                    <a href="http://apps1.eere.energy.gov/buildings/energyplus/cfm/weather_data.cfm">http://apps1.eere.energy.gov/buildings/energyplus/cfm/weather_data.cfm </a>
                
                </td>
            
            </tr>

        </table>
        <%-- Main table closes here--%>
    </div>
</asp:Content>
