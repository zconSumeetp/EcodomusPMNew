<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingComparision.ascx.cs"
    Inherits="App_UserControls_UserControlNewUI_EnergyModelingComparision" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<style type="text/css">
    .StyleGrid td
    {
        padding-left: 5px;
        padding-right: 1px;
    }
    .Panel
    {
      font-family: Verdana;
      font-size:10px;
    }

    .CustomerPanel
    {
      font-size:10px;
      width: 300px;
    }

    .LineBreak
    {
      text-align: left;
      width: 980px;
    }

    .OrderTable
    {
      font-family: Verdana;
      font-size:10px;  
    }    
    .style4
    {
        width: 105px;
    }
    </style>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">

        /**
        * Show a modal dialog that will load a page containing a Repeater
        * that will be populated with records based on the 
        * provided 'ID'
        */
        function ShowOrderReport(CustomerID) {
            //window.showModalDialog("http://localhost/EcoDomus_PM/App/UserControls/UserControlNewUI/OrderReport.aspx?CustomerID=" + CustomerID, "",
            //"dialogWidth:600px;dialogHeight:500px;resizable:no;scrollbars:no");
        }
        
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
                    windows[0].set_modal(true);
                }
            }
            return false;
        }

        function ShowAASAlgoEditWindow(pk_simulation_AAS_id, pk_algorithm_id) {
            manager = $find("<%=rd_manager.ClientID%>");
            //alert(manager);
            var url;
            var url = "EnergyModelingAASAlgorithmEdit.aspx?pk_simulation_AAS_id=" + pk_simulation_AAS_id + "&pk_algorithm_id=" + pk_algorithm_id;
            if (manager != null) {
                var windows = manager.get_windows();
                if (window[2] != null) {
                    windows[2].setUrl(url);
                    windows[2].show();
                    windows[2].set_modal(true);
                }
            }
            return false;
        }

        function openEnergyModelingAAS() {
            manager = $find("<%=rd_manager.ClientID%>");
            //alert(manager);
            var url;
            var url = "EnergyModelingAAS.aspx";
            if (manager != null) {
                var windows = manager.get_windows();
                if (window[1] != null) {
                    windows[1].setUrl(url);
                    windows[1].show();
                    windows[1].set_modal(true);
                }
            }
            return false;
        }


        function showMenuAt(e) {
            var contextMenu = $find(""),
                x = parseInt($get("coordX").value),
                y = parseInt($get("coordY").value);
            if (isNaN(x) || isNaN(y)) {
                alert("Please provide valid integer coordinates");
                return;
            }
            $telerik.cancelRawEvent(e);
            contextMenu.showAt(x, y);
        }


        function showPerformanceOrder(e) {
            var contextMenu = $find("");
            $telerik.cancelRawEvent(e);
            if ((!e.relatedTarget) || (!$telerik.isDescendantOrSelf(contextMenu.get_element(), e.relatedTarget))) {
                contextMenu.show(e);
            }
        }

        function showMenus(e) {
            var contextMenu = $find("");
            $telerik.cancelRawEvent(e);
            if ((!e.relatedTarget) || (!$telerik.isDescendantOrSelf(contextMenu.get_element(), e.relatedTarget))) {
                contextMenu.show(e);
            }
        }

        function showAASMenus(e) {
            var contextMenu = $find("<%= rcm_AAS.ClientID %>");
            $telerik.cancelRawEvent(e);
            if ((!e.relatedTarget) || (!$telerik.isDescendantOrSelf(contextMenu.get_element(), e.relatedTarget))) {
                contextMenu.show(e);

            }
        }

        function refreshgrid() {

        }

        function get_height() {
            var height = document.getElementById("div_grap").style.height;
            return height;
        }
       
    </script>
</telerik:RadCodeBlock>
<link type="text/css" rel="Stylesheet" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
 <meta http-equiv="X-UA-Compatible" content="IE=7" charset='utf-8'/>
    <title>Energy Modeling Comparision</title>
</head>
<body>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Default, Textbox, Select" BackColor="White" />
    <table border="0">
        <tr>
            <td align="left" colspan="3" style="height:10px;">
        </td>
        </tr>
        <tr>
            <td valign="top">
                <table border="0">
                    <tr style="background-color: #E2E2E2;">
                        <td style="padding-left: 5px; height:22px;">
                            <asp:Label ID="Label1" runat="server" Text="Select Simulation Run" CssClass="normalLabelBold"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #F4F4F4">
                        <td>
                            <telerik:RadComboBox ID="cmb_sim_run"
                                runat="server"
                                Height="300px" 
                                Width="325px"
                                ExpandDirection="Down"
                                DropDownWidth="450px"
                                Skin="Office2010Silver"
                                Text="" onselectedindexchanged="cmb_sim_run_SelectedIndexChanged" 
                                AutoPostBack="True" CheckBoxes="True" 
                                onitemchecked="cmb_sim_run_ItemsChecked">
                                <Items>
                                        <telerik:RadComboBoxItem Value="SIMRUN" Text="Select Simulation Run" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="height:10px;">
                        </td>
                    </tr>
                    <tr style="background-color: #E2E2E2">
                        <td style="padding-left: 5px; width:35%; height: 22px">
                            <asp:Label ID="lbl_building_hierarchy" runat="server" Text="Building Hierarchy" CssClass="normalLabelBold"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" cellpadding="0" cellspacing="0" 
                                style="width: 100%; height: 23px;">
                                <tr>
                                   <td colspan="2">
                                                <telerik:RadComboBox ID="rcb_unit0" runat="server" ExpandDirection="Down" 
                                                    Skin="Office2010Silver" Width="165px" Height="75px" AutoPostBack="True" 
                                                    onselectedindexchanged="rcb_unit0_SelectedIndexChanged">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Selected="true" Text="Chart" Value="Chart" />
                                                    </Items>
<%--                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Data" Value="Data" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Settings" Value="Settings" />
                                                    </Items>
--%>
                                                </telerik:RadComboBox>
                                       
                                    </td>
                                    <td align="right">
                                    <asp:Button ID="btn_update" Text="Update" runat="server" 
                                            OnClick="btn_update_Click" Font-Size="Small" Width="160px" 
                                            style="margin-left: 0px"/>
                                   </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="height:10px;">
                        </td>
                    </tr>
                    <tr>
                        <td valign="top"
                            align="left">
                            <div style="border-style:solid; border-width:1px; border-color:Gray; height:505px; width:325px;overflow:auto;">
                                <asp:UpdatePanel runat="server" ID="Panel1">
                                    <ContentTemplate>
                                        <asp:TreeView ID="rtv_entity" runat="server" CssClass="normalLabel" CollapseImageUrl="~/App/Images/Icons/expand_arrow.png"
                                            ExpandImageUrl="~/App/Images/Icons/collapse_arrow.png" EnableViewState="true"
                                            ExpandDepth="0" OnTreeNodePopulate="rtv_entity_TreeNodePopulate" 
                                            OnSelectedNodeChanged="rtv_entity_SelectedNodeChanged" NodeIndent="8" 
                                            ShowLines="True" BorderStyle="None" Height="505px" Width="325px">
                                            <SelectedNodeStyle ForeColor="#0066FF" />
                                        </asp:TreeView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td style ="width:5px"></td>
            <td style ="width:700px" align="left" valign="top">
                <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                    <asp:View ID="tab1" runat="server"  >
                        <table width="700" style="border-collapse:collapse;">
                            <tr valign="top">
                                <td class="TabArea" style="width: 700px">
                                    <table border="0">
                                        <tr style="background-color: #E2E2E2; height:22px;">
                                            <td style="padding-left: 5px" width="300px">
                                                <asp:Label ID="Label2" runat="server" CssClass="normalLabelBold" 
                                                    Text="Output Format"></asp:Label>
                                            </td>
                                            <td style="padding-left: 5px" width="165">
                                                <asp:Label ID="Label5" runat="server" CssClass="normalLabelBold" Text="From"></asp:Label>
                                            </td>
                                            <td style="padding-left: 5px" width="165">
                                                <asp:Label ID="Label6" runat="server" CssClass="normalLabelBold" Text="To"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-top: 0px; padding-left: 0px;">
                                                <telerik:RadComboBox ID="output_format" runat="server" DropDownWidth="300px" 
                                                    ExpandDirection="Down" Height="300px" Skin="Office2010Silver" Text="" 
                                                    Width="350px">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="None" Value="None" />
<%--                                                        <telerik:RadComboBoxItem Text="Cost Calculation" Value="Cost Calculation" />
                                                        <telerik:RadComboBoxItem Text="Energy Model Cost Comparision" Value="Energy Model Cost Comparision" />
--%>                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                            <td style="padding-top: 0px; padding-left: 0px;">
                                                <telerik:RadDateTimePicker ID="rdtp_from" runat="server" 
                                                    Skin="Office2010Silver" Width="170px">
                                                    <TimeView CellSpacing="-1">
                                                    </TimeView>
                                                    <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                                    <Calendar ID="Calendar2" runat="server" EnableKeyboardNavigation="true" 
                                                        Skin="Office2010Silver">
                                                    </Calendar>
                                                    <DateInput ID="DateInput1" runat="server" ToolTip="Date input">
                                                    </DateInput>
                                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                </telerik:RadDateTimePicker>
                                            </td>
                                            <td style="padding-left: 0px">
                                                <telerik:RadDateTimePicker ID="rdtp_to" runat="server" Skin="Office2010Silver" 
                                                    Width="170px">
                                                    <TimeView CellSpacing="-1">
                                                    </TimeView>
                                                    <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                                    <Calendar ID="Calendar1" runat="server" EnableKeyboardNavigation="true" 
                                                        Skin="Office2010Silver">
                                                    </Calendar>
                                                    <DateInput ID="DateInput2" runat="server" ToolTip="Date input">
                                                    </DateInput>
                                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                </telerik:RadDateTimePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="height:10px;">
                                            </td>
                                        </tr>
                                        <tr style="height:22px; background-color: #E2E2E2;">
                                            <td style="padding-left: 5px" width="300">
                                                <asp:Label ID="Label11" runat="server" CssClass="normalLabelBold" 
                                                    Text="Weather Source"></asp:Label>
                                            </td>
                                            <td style="padding-left: 5px">
                                                <asp:Label ID="Label3" runat="server" CssClass="normalLabelBold" Text="Weather"></asp:Label>
                                            </td>
                                            <td style="padding-left: 5px" width="155">
                                                <asp:Label ID="Label4" runat="server" CssClass="normalLabelBold" Text="Units"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 0px">
                                                <telerik:RadComboBox ID="rcb_weather_source" runat="server" CheckBoxes="true" 
                                                    DropDownHeight="300px" DropDownWidth="300px" ExpandDirection="Down" 
                                                    Height="300px" Skin="Office2010Silver" Text="" Width="350px">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Select Output Format" Value="SIMRUN" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                            <td style="padding-left: 0px">
                                                <telerik:RadComboBox ID="rcb_weather_data" runat="server" CheckBoxes="true" 
                                                    ExpandDirection="Down" Skin="Office2010Silver" Width="170px">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Temperateure C" Value="temp_c" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Temperateure F" Value="temp_f" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Relative Humidity" Value="relative_humidity" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Wind Degree" Value="wind_degrees" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Wind MPH" Value="wind_mph" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Wind Gust MPH" Value="wind_gust_mph" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Wind KT" Value="wind_kt" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Wind Gust KT" Value="wind_gust_kt" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Pressure MB" Value="pressure_mb" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Pressure In" Value="pressure_in" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Dewpoint F" Value="dewpoint_f" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Dewpoint C" Value="dewpoint_c" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Heat Index F" Value="heat_index_f" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Heat Index C" Value="heat_index_c" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Windchill F" Value="windchill_f" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Windchill C" Value="windchill_c" />
                                                    </Items>
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Visibility MI" Value="visibility_mi" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                            <td style="padding-left: 0px">
                                                <telerik:RadComboBox ID="rcb_unit" runat="server" ExpandDirection="Down" 
                                                    Skin="Office2010Silver" Width="175px" Height="22px">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Selected="true" Text="DEG F" Value="f" />
                                                        <telerik:RadComboBoxItem runat="server" Owner="rcb_unit" Text="DEG C" 
                                                            Value="c" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="height:10px;">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <asp:Chart ID="rc_linechart" runat="server" Width="700px" 
                                                    height="505px" BorderlineWidth="1" BorderlineColor="Gray" 
                                                    BorderlineDashStyle="Solid">
                                                    <ChartAreas>
                                                        <asp:ChartArea Name="ChartArea1">
                                                            <AxisX>
                                                                <LabelStyle Angle="90" />
                                                            </AxisX>
                                                        </asp:ChartArea>
                                                    </ChartAreas>
                                                </asp:Chart>
                                            </td>
                                        </tr>

                                    </table>
                                 </td>
                            </tr>
                        </table>
                    </asp:View>
                </asp:MultiView>            
            </td>
        </tr>
        <tr>
            <td align="left" colspan="3" style="height:5px;">
            </td>
        </tr>
        <tr align="left">
            <td align="left" colspan="3">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse; border-color: #D2D2D2">
                    <tr>
                        <td valign="top" align="left" style="padding-left: 0px">
                            <asp:panel ID="Panel_AAS" runat="server" Height="153px" Visible="true" width="100%">
                                <table border="1" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td align="left" style="background-color: #E2E2E2">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;
                                                background-color: #CFCFCF">
                                                <tr>
                                                    <td style="padding-left: 5px; width: 45%; float: left; vertical-align: bottom">
                                                        <asp:Label ID="lbl_AAS" runat="server" Text="Assumption" CssClass="normalLabelBold"></asp:Label>
                                                        <asp:ImageButton ID="ibtn_measurement_assumptions" runat="server" ImageAlign="Top"
                                                            ImageUrl="~/App/Images/Icons/asset_arrow_lg.png" OnClientClick="showAASMenus(event)" />
                                                    </td>
                                                    <td style="width: 10%">
                                                        <asp:Label ID="lbl_errors" runat="server" Text="0 Errors" ForeColor="#800000" CssClass="normalLabel"></asp:Label>
                                                    </td>
                                                    <td style="width: 5%">
                                                    </td>
                                                    <td style="width: 10%">
                                                        <asp:Label ID="lbl_warning" runat="server" Text="0 Warnings" ForeColor="#F88C0C"
                                                            CssClass="normalLabel"></asp:Label>
                                                    </td>
                                                    <td style="width: 10%">
                                                    </td>
                                                    <td style="padding-left: 15px" align="right">
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td style="padding-left: 10px" align="right">
                                                    </td>
                                                    <td style="padding-right: 5px">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="background-color: #E2E2E2">
                                            <telerik:RadGrid ID="rg_impact_details" runat="server" AllowPaging="true" PageSize="10"
                                                BorderColor="White" BorderWidth="2" AllowMultiRowSelection="true" PagerStyle-AlwaysVisible="true"
                                                AutoGenerateColumns="false" Width="100%" OnItemDataBound="rg_impact_details_ItemDataBound"
                                                OnItemCreated="rg_impact_details_ItemCreated" OnItemCommand="rg_impact_details_ItemCommand"
                                                OnPageIndexChanged="rg_impact_details_PageIndexChanged" OnPageSizeChanged="rg_impact_details_PageSizeChanged"
                                                OnSortCommand="rg_impact_details_SortCommand">
                                                <ClientSettings>
                                                    <Selecting AllowRowSelect="true" />
                                                </ClientSettings>
                                                <MasterTableView DataKeyNames="pk_simulation_AAS_id,pk_algorithm_id" HeaderStyle-CssClass="gridHeaderText"
                                                    CellPadding="0" CellSpacing="0">
                                                    <PagerStyle HorizontalAlign="Right" Mode="NextPrevNumericAndAdvanced" AlwaysVisible="true"
                                                        PageSizeLabelText="Show Rows" />
                                                    <AlternatingItemStyle BackColor="#F8F8F8" />
                                                    <HeaderStyle BorderColor="Orange" BorderStyle="Solid" />
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="pk_simulation_AAS_id" HeaderText="Type" UniqueName="pk_simulation_AAS_id"
                                                            Display="false">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="pk_algorithm_id" HeaderText="Type" UniqueName="pk_algorithm_id"
                                                            Display="false">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="type" HeaderText="Type" UniqueName="type">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Message" HeaderText="Description" UniqueName="Message">
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
                                        <td align="left" style="background-color: #E2E2E2; vertical-align: top">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
                                                <tr>
                                                    <td colspan="6" style="height: 1px; background-color: Orange">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 10%">
                                                    </td>
                                                    <td>
                                                        <%--<asp:ImageButton ID="ibtn_measurement_assumption" runat="server" ImageUrl="~/App/Images/Icons/measurement_assumption.png" />--%>
                                                    </td>
                                                    <td>
                                                        <%--<asp:ImageButton ID="ibtn_simulation_assumption" runat="server" ImageUrl="~/App/Images/Icons/simulation_assumption.png"
                                                        OnClientClick="javascript:return openEnergyModelingWizard();" />--%>
                                                    </td>
                                                    <td>
                                                        <%--<asp:ImageButton ID="ibtn_simulation_approximation" runat="server" ImageUrl="~/App/Images/Icons/simulation_approximation.png" />--%>
                                                    </td>
                                                    <td>
                                                        <%--<asp:ImageButton ID="ibtn_simulation_simplification" runat="server" ImageUrl="~/App/Images/Icons/simulation_simplification.png" />--%>
                                                    </td>
                                                    <td align="right">
                                                        <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/App/Images/Icons/AAS.png"
                                                            OnClientClick="javascript:return openEnergyModelingAAS();" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <telerik:RadContextMenu ID="rcm_AAS" runat="server" EnableRoundedCorners="true" Width="60px"
        EnableShadows="true" Skin="Vista" CssClass="normalLabel" OnItemClick="rcm_AAS_ItemClick">
        <Items>
            <telerik:RadMenuItem Text="Assumption" Font-Names="Arial" Value="Assumption" />
            <telerik:RadMenuItem Text="Approximation" Font-Names="Arial" Value="Approximation" />
            <telerik:RadMenuItem Text="Simplification" Font-Names="Arial" Value="Simplification" />
        </Items>
    </telerik:RadContextMenu>
    <telerik:RadContextMenu ID="rcm_wtb_btw" runat="server" 
        EnableRoundedCorners="true" Width="65px"
        EnableShadows="true" Skin="Vista" CssClass="normalLabel">
        <Items>
            <telerik:RadMenuItem Text="Worst To Best" Font-Names="Arial" Value="WTB" />
            <telerik:RadMenuItem Text="Best To Worst" Font-Names="Arial" Value="BTW" />
        </Items>
    </telerik:RadContextMenu>
    <telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Red" Skin="Office2010Silver">
        <Windows>
            <telerik:RadWindow ID="RadWindow0" runat="server" ReloadOnShow="false" Width="900"
                AutoSize="false" VisibleStatusbar="false" VisibleOnPageLoad="false" Behaviors="Resize,Move"
                BorderColor="Black" BorderStyle="None" BackColor="Red" VisibleTitlebar="false"
                Overlay="true">
            </telerik:RadWindow>
        </Windows>
        <Windows>
            <telerik:RadWindow ID="RadWindow1" runat="server" ReloadOnShow="false" Height="370" OnClientClose="refreshgrid"
                Width="550" AutoSize="false" VisibleStatusbar="false"
                VisibleOnPageLoad="false" Behaviors="Resize,Move" BorderColor="Black" BorderStyle="None"
                BackColor="Red" VisibleTitlebar="false" Overlay="true">
            </telerik:RadWindow>
        </Windows>
        <Windows>
            <telerik:RadWindow ID="RadWindow2" runat="server" ReloadOnShow="false" Height="500" OnClientClose="refreshgrid"
                Width="750" AutoSize="false" VisibleStatusbar="false" VisibleOnPageLoad="false"
                Behaviors="Resize,Move" BorderColor="Black" BorderStyle="None" BackColor="Red"
                VisibleTitlebar="false" Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager2" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btn_update">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rc_linechart" LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelRenderMode="Inline" />
<%--                    <telerik:AjaxUpdatedControl ControlID="Grid_DataView" LoadingPanelID="RadAjaxLoadingPanel2" UpdatePanelRenderMode="Inline" />
--%>                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
<%--        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rtv_entity">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rc_linechart" UpdatePanelRenderMode="Inline"
                        LoadingPanelID="RadAjaxLoadingPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>
<%--        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_impact_details" UpdatePanelRenderMode="Inline"
                        LoadingPanelID="RadAjaxLoadingPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_impact_details">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_impact_details" UpdatePanelRenderMode="Inline"
                        LoadingPanelID="RadAjaxLoadingPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rcm_AAS">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_impact_details" UpdatePanelRenderMode="Inline"
                        LoadingPanelID="RadAjaxLoadingPanel2" />
                    <telerik:AjaxUpdatedControl ControlID="lbl_AAS" UpdatePanelRenderMode="Inline" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rcm_wtb_btw">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lbl_worstToBest" UpdatePanelRenderMode="Inline"
                        LoadingPanelID="RadAjaxLoadingPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" IsSticky="false"
        Transparency="50">
        <asp:Image ID="Image1" runat="server" ImageUrl="~/App/Images/Icons/loading.gif" AlternateText="Loading"
            ImageAlign="Middle"></asp:Image>
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" IsSticky="false"
        Transparency="50">
        <asp:Image ID="Image2" runat="server" ImageUrl="~/App/Images/Icons/loading_img21.gif"
            AlternateText="Loading" ImageAlign="AbsMiddle"></asp:Image>
    </telerik:RadAjaxLoadingPanel>
</body>
</html>
