<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomusPM_Master.master"  AutoEventWireup="true" CodeFile="EnergyModelingAnalysis.aspx.cs" Inherits="App_NewUI_EnergyModelingAnalysis" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Charting" tagprefix="telerik" %>
<%@ Register Src="~/App/UserControls/UserControlNewUI/EnergyModelingComparision.ascx" TagName="comparision" TagPrefix="em" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server" >
    <script type="text/javascript">
        function openEnergyModelingWizard() {
            manager = $find("<%=rd_manager.ClientID%>");
            //alert(manager);
            var url;
            var url = "EnergyModelingComparisionPopup.aspx";
            if (manager != null) {
                var windows = manager.get_windows();
                if (window[0] != null) {
                    windows[0].setUrl(url);
                    windows[0].show();
                    windows[0].set_modal(false);
                }
            }
            return false;
        }
        function showMenuAt(e) {
            var contextMenu = $find("<%= rcm_performance.ClientID %>"),
                x = parseInt($get("coordX").value),
                y = parseInt($get("coordY").value);
            if (isNaN(x) || isNaN(y)) {
                alert("Please provide valid integer coordinates");
                return;
            }
            $telerik.cancelRawEvent(e);
            contextMenu.showAt(x, y);
        }

        function showMenus(e) {
            var contextMenu = $find("<%= rcm_performance.ClientID %>");
            $telerik.cancelRawEvent(e);
            if ((!e.relatedTarget) || (!$telerik.isDescendantOrSelf(contextMenu.get_element(), e.relatedTarget))) {
                contextMenu.show(e);

            }
        }
        
       
        </script>

        </telerik:RadCodeBlock>
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" 
        DecoratedControls="RadioButtons, Buttons" />
<link type="text/css" rel="Stylesheet" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <table border="0" cellpadding="0" cellspacing="0" width="98%">
        <tr>
            <td style="border-bottom-color: transparent; border-bottom-width: 0px">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color: #F7F7F7;
                    border-collapse: collapse; border-width: 0px">
                    <tr>
                        <td style="background-color: #F7F7F7">
                            <telerik:RadTabStrip ID="radtabstrip_Statements" runat="server" MultiPageID="rmp_comparision_browse"
                                SelectedIndex="0" Width="190px" ShowBaseLine="True" Skin="Office2010Silver">
                                <Tabs>
                                    <telerik:RadTab Text="Comparision" Font-Bold="true" runat="server" PageViewID="rpv_comparision"
                                        BorderColor="Gray">
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Browse" Font-Bold="true" runat="server" PageViewID="rpv_browse"
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
                <telerik:RadMultiPage ID="rmp_comparision_browse" runat="server" SelectedIndex="1">
                    <telerik:RadPageView runat="server" ID="rpv_comparision" Selected="true">
                        <table border="2" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;
                            border-top-color: transparent; border-top-width: 0px;">
                            <tr>
                                <td style="padding-top: 15px; padding-left: 15px; height: 57px; border-color: transparent;
                                    border-width: 0px">
                                    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse"
                                        width="98%">
                                        <tr>
                                            <td style="width: 40%" valign="top">
                                                <table border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="background-image: url('/App/Images/asset_container_2.png'); height: 40px;
                                                            width: 200px; background-repeat: no-repeat;" align="center">
                                                            <asp:Label ID="lbl_project_name" runat="server" Text="Project Name" Font-Size="10"
                                                                ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                                        </td>
                                                        <td style="width: 5px">
                                                        </td>
                                                        <td style="background-image: url('/App/Images/asset_container_3.png'); height: 40px;
                                                            width: 200px; background-repeat: no-repeat" align="center">
                                                            <asp:Label ID="lbl_list" runat="server" Text="Simulation Control" Font-Size="10"
                                                                ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                                        </td>
                                                        <td style="padding-left: 25px">
                                                            <asp:Button ID="btn_update" Text="Update" runat="server" Width="50" OnClick="btn_update_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 60%; padding-left: 30px" align="right">
                                                <table border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox runat="server" ID="chk_compare_prev" Text="Compare Previous" Style="font-family: Arial,sans-serif;
                                                                font-size: 12px;" />
                                                        </td>
                                                        <td style="padding-left: 30px">
                                                            <asp:CheckBox runat="server" ID="chk_compare" Text="Compare" Style="font-family: Arial,sans-serif;
                                                                font-size: 12px;" />
                                                        </td>
                                                        <td colspan="2">
                                                            <telerik:RadDateTimePicker ID="rdtp_from" runat="server">
                                                                <Calendar ID="Calendar2" runat="server" EnableKeyboardNavigation="true">
                                                                </Calendar>
                                                                <DateInput ID="DateInput1" ToolTip="Date input" runat="server">
                                                                </DateInput>
                                                            </telerik:RadDateTimePicker>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-top: 5px">
                                                            <telerik:RadComboBox ID="cmb_week_type" runat="server" Height="40" Width="150" ExpandDirection="Down"
                                                                Skin="Default">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label runat="server" Text="To" ID="lbl_to" Style="font-family: Arial,sans-serif;
                                                                font-size: 12px;"></asp:Label>
                                                        </td>
                                                        <td colspan="2">
                                                            <telerik:RadDateTimePicker ID="rdtp_to" runat="server">
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
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 15px; padding-left: 15px;">
                                    <table border="1" cellpadding="0" cellspacing="0" width="98%" style="border-collapse: collapse;
                                        border-color: #D2D2D2">
                                        <tr style="background-color: #F4F4F4">
                                            <td style="padding-left: 15px">
                                                <asp:Label ID="lbl_building_hierarchy" runat="server" Text="Building Hierarchy" CssClass="normalLabelBold"></asp:Label>
                                            </td>
                                            <td class="style2">
                                            </td>
                                        </tr>
                                        <tr style="background-color: #E2E2E2">
                                            <td style="height: 30px;" align="center">
                                                <table border="0" cellpadding="0" cellspacing="0" width="98%">
                                                    <tr>
                                                        <td style="vertical-align: middle" align="right">
                                                            <asp:Label ID="lbl_performance" runat="server" Text="Performance" Style="font-family: Arial,sans-serif;
                                                                font-size: 12px;"></asp:Label>
                                                        </td>
                                                        <td style="padding-left: 5px" align="left">
                                                            <asp:ImageButton ID="ibtn_performance" runat="server" ImageUrl="~/App/Images/Icons/asset_arrow_lg.png"
                                                                ImageAlign="Middle" OnClientClick="showMenus(event)" />
                                                        </td>
                                                        <td style="width: 20%">
                                                        </td>
                                                        <td style="vertical-align: middle" align="right">
                                                            <asp:Label ID="lbl_worstToBest" runat="server" Text="Worst To Best" Style="font-family: Arial,sans-serif;
                                                                font-size: 12px;"></asp:Label>
                                                        </td>
                                                        <td style="padding-left: 5px" align="left">
                                                            <asp:ImageButton ID="ibtn_worstToBest" runat="server" ImageUrl="~/App/Images/Icons/asset_arrow_lg.png"
                                                                ImageAlign="Middle" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td style="width: 80%; padding-left: 15px">
                                                            <asp:Label ID="lbl_name" runat="server" Text="02065 BURNS CHAMBER" Style="font-family: Arial,sans-serif;
                                                                font-size: 12px;"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%" align="right">
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:ImageButton ID="ibtn_export" runat="server" ImageUrl="~/App/Images/Icons/icon_documents_sm.png" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lbl_export" runat="server" Text="Export" Style="font-family: Arial,sans-serif;
                                                                            font-size: 12px;"></asp:Label>
                                                                    </td>
                                                                    <td style="padding-left: 10px" align="right">
                                                                        <asp:ImageButton ID="ibtn_print" runat="server" ImageUrl="~/App/Images/Icons/printer.png" />
                                                                    </td>
                                                                    <td style="padding-right: 5px">
                                                                        <asp:Label ID="lbl_print" runat="server" Text="Print" Style="font-family: Arial,sans-serif;
                                                                            font-size: 12px;"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 150px; border-bottom-width: 0px; border-bottom-color: transparent"
                                                valign="top">
                                                
                                            </td>
                                            <td valign="top" align="center">
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <telerik:RadChart ID="rc_linechart" runat="server" AutoLayout="True" Skin="Telerik"
                                    Width="650px" DefaultType="Spline" OnItemDataBound="rc_linechart_ItemDataBound">
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
                                    <Series>
                                        <telerik:ChartSeries DataYColumn="AttributeValue" Name="BAS" Type="Line">
                                            <Appearance ShowLabels="false">
                                                <TextAppearance TextProperties-Font="Arial, 8.25pt">
                                                </TextAppearance>
                                                <FillStyle MainColor="#BE4B48" FillType="Solid">
                                                    <FillSettings GradientMode="Vertical">
                                                        <ComplexGradient>
                                                            <telerik:GradientElement Color="213, 247, 255" />
                                                            <telerik:GradientElement Color="193, 239, 252" Position="0.5" />
                                                            <telerik:GradientElement Color="157, 217, 238" Position="1" />
                                                        </ComplexGradient>
                                                    </FillSettings>
                                                </FillStyle>
                                                <PointMark Visible="True" Border-Width="0" Border-Color="#BE4B48" Dimensions-AutoSize="false"
                                                    Dimensions-Height="8px" Dimensions-Width="8px">
                                                    <FillStyle MainColor="#BE4B48" FillType="solid">
                                                    </FillStyle>
                                                    <Border Color="190, 75, 72" Width="0" />
                                                </PointMark>
                                                <Border Color="" />
                                            </Appearance>
                                        </telerik:ChartSeries>
                                    </Series>
                                    <PlotArea>
                                        <XAxis DataLabelsColumn="time_stamp1">
                                            <Appearance ValueFormat="LongDate">
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
                                        <Appearance Visible="true" Shadow-Position="Behind" Border-Width="1" Position-AlignedPosition="Top"
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
                                        <tr>
                                            <td style="border-top-width: 0px; border-top-color: transparent; border-bottom-width: 0px;
                                                border-bottom-color: transparent">
                                            </td>
                                            <td align="left" style="background-color: #E2E2E2">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;
                                                    background-color: #CFCFCF">
                                                    <tr>
                                                        <td style="padding-left: 5px; width: 45%; float: left; vertical-align: bottom">
                                                            <asp:Label ID="lbl_measurement_assumptions" runat="server" Text="Measurement Assumptions"
                                                                Style="font-family: Arial, sans-serif; font-size: 12px; font-weight: bold;"></asp:Label>
                                                            <asp:ImageButton ID="ibtn_measurement_assumptions" runat="server" ImageAlign="Top"
                                                                ImageUrl="~/App/Images/Icons/asset_arrow_lg.png" />
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="lbl_errors" runat="server" Text="0 Errors" ForeColor="#800000" Style="font-family: Arial,sans-serif;
                                                                font-size: 12px;"></asp:Label>
                                                        </td>
                                                        <td style="width: 5%">
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="lbl_warning" runat="server" Text="0 Warnings" ForeColor="#F88C0C"
                                                                Style="font-family: Arial,sans-serif; font-size: 12px;"></asp:Label>
                                                        </td>
                                                        <td style="width: 10%">
                                                        </td>
                                                        <td style="padding-left: 15px" align="right">
                                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon_documents_sm.png" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" runat="server" Text="Export" Style="font-family: Arial,sans-serif;
                                                                font-size: 12px;"></asp:Label>
                                                        </td>
                                                        <td style="padding-left: 10px" align="right">
                                                            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/App/Images/Icons/printer.png" />
                                                        </td>
                                                        <td style="padding-right: 5px">
                                                            <asp:Label ID="Label2" runat="server" Text="Print" Style="font-family: Arial,sans-serif;
                                                                font-size: 12px;"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="border-top-width: 0px; border-top-color: transparent; border-bottom-width: 0px;
                                                border-bottom-color: transparent">
                                            </td>
                                            <td align="left" style="background-color: #E2E2E2">
                                                <telerik:RadGrid ID="rg_impact_details" runat="server" AllowPaging="true" PageSize="10"
                                                    BorderColor="White" BorderWidth="2" AllowMultiRowSelection="true" PagerStyle-AlwaysVisible="true"
                                                    AutoGenerateColumns="false" Width="100%">
                                                    <ClientSettings EnableRowHoverStyle="true">
                                                        <Selecting AllowRowSelect="true" />
                                                    </ClientSettings>
                                                    <MasterTableView DataKeyNames="" HeaderStyle-CssClass="gridHeaderText">
                                                        <PagerStyle HorizontalAlign="Right" Mode="NextPrevNumericAndAdvanced" AlwaysVisible="true"
                                                            PageSizeLabelText="Show Rows" />
                                                        <AlternatingItemStyle BackColor="#F8F8F8" />
                                                        <HeaderStyle BorderColor="Orange" BorderStyle="Solid" />
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="description" HeaderText="Description" UniqueName="description">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn UniqueName="impact" HeaderText="Impact" ItemStyle-HorizontalAlign="Center"
                                                                ItemStyle-Width="15%">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="img_impact" ImageUrl="~/App/Images/Icons/icon_edit_sm.png" ImageAlign="Left"
                                                                        runat="server" CommandName="delete" CssClass="cursorStyle" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn UniqueName="delete" HeaderText="Delete" ItemStyle-HorizontalAlign="Center"
                                                                ItemStyle-Width="15%">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="img_delete" ImageUrl="~/App/Images/Icons/asset_close_black.png"
                                                                        ImageAlign="Left" runat="server" CommandName="delete" CssClass="cursorStyle" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="border-top-width: 0px; border-top-color: transparent">
                                            </td>
                                            <td align="left" style="background-color: #E2E2E2; vertical-align: top">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
                                                    <tr>
                                                        <td colspan="6" style="height: 1px; background-color: Orange">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 10%">
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:ImageButton ID="ibtn_measurement_assumption" runat="server" ImageUrl="~/App/Images/Icons/measurement_assumption.png" />
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:ImageButton ID="ibtn_simulation_assumption" runat="server" ImageUrl="~/App/Images/Icons/simulation_assumption.png"
                                                                OnClientClick="javascript:return openEnergyModelingWizard();" />
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:ImageButton ID="ibtn_simulation_approximation" runat="server" ImageUrl="~/App/Images/Icons/simulation_approximation.png" />
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:ImageButton ID="ibtn_simulation_simplification" runat="server" ImageUrl="~/App/Images/Icons/simulation_simplification.png" />
                                                        </td>
                                                        <td style="width: 10%">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 20px">
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>
                    <telerik:RadPageView runat="server" ID="rpv_browse" Selected="false">
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
    </table>

    <telerik:RadContextMenu ID="rcm_performance" runat="server" EnableRoundedCorners="true"
        Width="60px" EnableShadows="true" OnItemClick="rcm_performance_ItemClick" Skin="Vista"
        CssClass="normalLabel">
        <Items>
            <telerik:RadMenuItem Text="HVAC" Font-Names="Arial" Value="HVAC" />
            <telerik:RadMenuItem Text="Spatial(Floors/Rooms)" Font-Names="Arial" Value="Spatial" />
            <telerik:RadMenuItem Text="Performance" Font-Names="Arial" Value="Performance" />
        </Items>
    </telerik:RadContextMenu>

    <telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Red">
        <Windows>
            <telerik:RadWindow ID="rd_window_modeling_wizard" runat="server" ReloadOnShow="false"
                Width="900" AutoSize="false" VisibleStatusbar="false" VisibleOnPageLoad="false"
                Behaviors="Resize,Move" BorderColor="Black" EnableAjaxSkinRendering="false" BorderStyle="None"
                BackColor="Red" VisibleTitlebar="false" Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>


