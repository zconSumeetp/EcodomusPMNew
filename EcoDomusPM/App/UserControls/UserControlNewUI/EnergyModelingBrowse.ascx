<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingBrowse.ascx.cs" Inherits="App_UserControls_UserControlNewUI_EnergyModelingBrowse" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Charting" tagprefix="telerik" %>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
    </script>
</telerik:RadCodeBlock>
    <link type="text/css" rel="Stylesheet" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />


<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" 
        DecoratedControls="RadioButtons, Buttons, Scrollbars, Textbox, Select" />
<table border="2" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;
    border-top-color: transparent; border-top-width: 0px;">
    <tr>
        <td style="padding-top: 15px; padding-left: 15px; height: 57px; border-color: transparent;
            border-width: 0px">
            <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse"
                width="98%">
                <tr>
                    <td style="width: 50%" valign="top">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td style="background-image: url('/App/Images/asset_container_2.png'); height: 40px;
                                    width: 250px; background-repeat: no-repeat;" align="center">
                                    <asp:Label ID="lbl_project_name" runat="server" Text="Project Name" Font-Size="10"
                                        ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                </td>
                                <td style="width: 5px">
                                </td>
                                <td style="background-image: url('/App/Images/asset_container_3.png'); height: 40px;
                                    width: 200px; background-repeat: no-repeat" align="center">
                                    <asp:Label ID="lbl_list" runat="server" Text="Browse Data" Font-Size="10" ForeColor="Red"
                                        CssClass="normalLabel"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 50%; padding-left: 20px" align="right" valign="bottom">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="padding-left: 25px">
                                    <asp:Button ID="btn_print" Text="Print" runat="server" Width="50" />
                                </td>
                                <td style="width: 5px">
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cmb_BAS_SIM_report" runat="server" Width="300px" ExpandDirection="Down"
                                        ZIndex="10" AutoPostBack="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
     <tr>
        <td style="padding-top: 10px; padding-left: 15px;">
            <table border="1" cellpadding="0" cellspacing="0" width="98%" style="border-collapse: collapse;
                border-color: #D2D2D2">
                <tr style="background-color: #F4F4F4">
                    <td style="padding-left: 10px; width: 30%; height: 25px">
                        <asp:Label ID="lbl_building_hierarchy" runat="server" Text="Search" CssClass="normalLabelBold"></asp:Label>
                    </td>
                    <td style="width: 70%;padding-left: 10px;">
                     <asp:Label ID="lbl_date_time_range" runat="server" Text="Date/Time Range" CssClass="normalLabelBold"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center" style="height: 30px">
                        <asp:Button ID="btn_search" Text="Search" runat="server" Width="50" />
                        <asp:TextBox ID="txt_search" Width="150" runat="server"></asp:TextBox>
                    </td>
                    <td align="center">
                        <table border="0" cellpadding="0" cellspacing="0" width="98%">
                            <tr>
                                <td style="padding-left: 15px">
                                </td>
                                <td>
                                    <asp:Button ID="btn_update_data" Text="Update Data" runat="server" Width="80" 
                                        onclick="btn_update_data_Click" />
                                </td>
                                <td>
                                    <asp:Label ID="lbl_start" Text="Start:" runat="server" CssClass="normalLabel"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadDateTimePicker ID="rdtp_start" runat="server">
                                        <Calendar ID="Calendar2" runat="server" EnableKeyboardNavigation="true">
                                        </Calendar>
                                         <DateInput ID="DateInput1" ToolTip="Date input" runat="server">
                                        </DateInput>
                                    </telerik:RadDateTimePicker>
                                </td>
                                <td>
                                    <asp:Label ID="Label1" Text="Stop:" runat="server" CssClass="normalLabel"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadDateTimePicker ID="rdtp_end" runat="server">
                                        <Calendar ID="Calendar1" runat="server" EnableKeyboardNavigation="true">
                                        </Calendar>
                                        <DateInput ID="DateInput2" ToolTip="Date input" runat="server">
                                        </DateInput>
                                    </telerik:RadDateTimePicker>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="background-color: #F4F4F4">
                    <td style="height: 25px; padding-left: 10px;">
                        <asp:Label ID="lbl_data_point" runat="server" Text="Data Point" CssClass="normalLabelBold"></asp:Label>
                    </td>
                    <td style="padding-left: 10px;">
                        <div style="float: left">
                            <asp:Label ID="lbl_spreadsheet" runat="server" Text="Spreadsheet" CssClass="normalLabelBold"></asp:Label>
                        </div>
                        <div style="float: right">
                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/asset_arrow_lg.png"
                                ImageAlign="Middle"  />
                        </div>
                    </td>
                </tr>
                <tr style="background-color: #F4F4F4">
                    <td style="height: 25px; padding-left: 2px;">
                        <div style="float: left">
                            <asp:Image ID="img_bas_data_point" runat="server" ImageUrl="~/App/Images/Icons/bas_point.png" />
                            <asp:Label ID="lbl_bas_data_point" runat="server" Text="BAS Data Points" CssClass="normalLabel"></asp:Label>
                        </div>
                        <div style="float: right">
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/App/Images/Icons/sim_point.png" />
                            <asp:Label ID="lbl_sim_data_point" runat="server" Text="Simulation Data Point" CssClass="normalLabel"></asp:Label>
                        </div>
                    </td>
                    <td style="padding-left: 10px;">
                        <div style="float: left">
                            <asp:Label ID="Label3" runat="server" Text="Chart" CssClass="normalLabelBold"></asp:Label>
                        </div>
                        <div style="float: right">
                            <asp:ImageButton ID="ibtn_performance" runat="server" ImageUrl="~/App/Images/Icons/asset_arrow_lg.png"
                                ImageAlign="Middle" />
                        </div>
                    </td>
                </tr>
                <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" width="0">
                        <tr>
                            <td>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <telerik:RadChart ID="rc_linechart" runat="server" AutoLayout="True" Skin="Telerik"
                                            Width="750px" DefaultType="Spline">
                                            <ChartTitle Visible="false">
                                                <Appearance Dimensions-Margins="3%, 10px, 14px, 6%" Visible="False">
                                                    <FillStyle MainColor="">
                                                    </FillStyle>
                                                </Appearance>
                                                <TextBlock>
                                                    <Appearance TextProperties-Color="86, 88, 89" TextProperties-Font="Verdana, 22px">
                                                    </Appearance>
                                                </TextBlock>
                                            </ChartTitle>
                                            <Appearance>
                                                <FillStyle FillType="ComplexGradient">
                                                    <FillSettings>
                                                        <ComplexGradient>
                                                            <telerik:GradientElement Color="243, 253, 255"></telerik:GradientElement>
                                                            <telerik:GradientElement Color="White" Position="0.5"></telerik:GradientElement>
                                                            <telerik:GradientElement Color="243, 253, 255" Position="1"></telerik:GradientElement>
                                                        </ComplexGradient>
                                                    </FillSettings>
                                                </FillStyle>
                                                <Border Color="212, 221, 222"></Border>
                                            </Appearance>
                                            <PlotArea>
                                                <XAxis DataLabelsColumn="time_stamp1">
                                                    <Appearance>
                                                        <TextAppearance TextProperties-Font="Arial, 8.25pt, style=Bold">
                                                        </TextAppearance>
                                                        <MajorGridLines Color="196, 196, 196" Width="0" />
                                                        <LabelAppearance RotationAngle="90">
                                                        </LabelAppearance>
                                                    </Appearance>
                                                    <AxisLabel>
                                                        <Appearance Dimensions-Paddings="1px, 1px, 10%, 1px">
                                                        </Appearance>
                                                        <TextBlock>
                                                            <Appearance TextProperties-Color="51, 51, 51">
                                                            </Appearance>
                                                        </TextBlock>
                                                    </AxisLabel>
                                                </XAxis>
                                                <YAxis AxisMode="Extended">
                                                    <Appearance>
                                                        <MajorGridLines Color="196, 196, 196" />
                                                        <MinorGridLines Color="196, 196, 196" Width="0" />
                                                        <TextAppearance TextProperties-Font="Arial, 8.25pt, style=Bold">
                                                        </TextAppearance>
                                                    </Appearance>
                                                    <AxisLabel>
                                                        <TextBlock>
                                                            <Appearance TextProperties-Color="220, 158, 119">
                                                            </Appearance>
                                                        </TextBlock>
                                                    </AxisLabel>
                                                </YAxis>
                                                <Appearance>
                                                    <FillStyle MainColor="Transparent" SecondColor="Transparent">
                                                    </FillStyle>
                                                    <Border Color="Gray"></Border>
                                                </Appearance>
                                                <EmptySeriesMessage TextBlock-Text="No Data To Display">
                                                    <TextBlock Text="No Data To Display">
                                                    </TextBlock>
                                                </EmptySeriesMessage>
                                            </PlotArea>
                                            <Legend Visible="true" Appearance-Location="OutsidePlotArea">
                                                <Appearance Visible="true" Shadow-Position="Behind" Border-Width="1" Position-AlignedPosition="Right"
                                                    Figure="Circle">
                                                    <ItemTextAppearance TextProperties-Color="86, 88, 89">
                                                    </ItemTextAppearance>
                                                    <ItemMarkerAppearance Figure="Circle">
                                                    </ItemMarkerAppearance>
                                                    <FillStyle MainColor="">
                                                    </FillStyle>
                                                    <Border Color="Gray"></Border>
                                                    <Shadow Position="Behind" />
                                                </Appearance>
                                                <TextBlock>
                                                    <Appearance TextProperties-Color="86, 88, 89" Position-AlignedPosition="Top">
                                                    </Appearance>
                                                </TextBlock>
                                            </Legend>
                                        </telerik:RadChart>
                                        <telerik:RadToolTipManager ID="RadToolTipManager1" runat="server" Skin="Default"
                                            Animation="Slide" Position="TopCenter" EnableShadow="true" AutoTooltipify="true">
                                        </telerik:RadToolTipManager>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </td>
                </tr>
            </table>
        </td>
        </tr>
</table>
