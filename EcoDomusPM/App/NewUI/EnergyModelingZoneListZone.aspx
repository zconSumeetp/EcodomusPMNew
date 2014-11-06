<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingZoneListZone.aspx.cs"
    Inherits="App_NewUI_EnergyModelingZoneListZone" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <style type="text/css">
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
    <script type="text/javascript" language="javascript">

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }


        function CloseWindow() {
            GetRadWindow().BrowserWindow.referesh_project_page();
            GetRadWindow().close();
            top.location.reload();
            return false;
        }


        function cancel() {
            GetRadWindow().close();
            return false;
        }




        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }
        

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <table border="0" cellpadding="0" cellspacing="0" width="100%" 
        style="border-collapse: collapse; height: 170px;">
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
                    <tr>
                        <td class="wizardHeadImage">
                            <div class="wizardLeftImage">
                                <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/attachment.png"
                                    Height="20" />
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="lbl_header" Text="Zone List : " runat="server"></asp:Label>
                                <asp:Label ID="lbl_header_name" runat="server"></asp:Label>
                            </div>
                            <div class="wizardRightImage">
                                <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                    OnClick="ibtn_close_Click" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                 
                        <td class="tdValign" style="padding-left: 0px; padding-right: 0px;">
                            <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" BorderWidth="0"
                                ExpandMode="MultipleExpandedItems" BorderColor="Transparent" OnItemClick="RadPanelBar1_ItemClick">
                                <ExpandAnimation Type="OutSine" />
                                <Items>
                                    <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                                        BorderWidth="0" BorderColor="Transparent">
                                        <HeaderTemplate>


                                            <asp:Panel ID="pnl_job" runat="server" DefaultButton="btn_search" BorderWidth="0" ScrollBars="None"
                                                Width="100%" BorderColor="Transparent">


                                                <table id="tbl_jobs" cellpadding="0" cellspacing="0" class="gridRadPnlHeader" runat="server"
                                                    width="100%">


                                                    <tr>
                                                        <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                            <asp:Label runat="server" Text="Select Zones" ID="lbl_grid_head" CssClass="gridHeadText"
                                                                Width="200px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                                        </td>
                                                        <td align="right" onclick="stopPropagation(event)">
                                                            <div id="div_search" onclick="stopPropagation(event)" style="background-color: White;
                                                                width: 170px;">
                                                                <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                                    width: 100%;">
                                                                    <tr style="border-spacing=0px;">
                                                                        <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                                            padding-bottom: 0px;">
                                                                            <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                                Height="100%" EmptyMessage="Search" BorderColor="White" ID="txt_search" Width="100%">
                                                                            </telerik:RadTextBox>
                                                                        </td>
                                                                        <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                                            padding-bottom: 0px;">
                                                                            <asp:ImageButton ClientIDMode="Static" ID="btn_search" Height="13px" runat="server"
                                                                                ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btn_search_click" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>

                                                        <td align="center" class="dropDownImage">
                                                            <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" 
                                                                ID="img_arrow" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table id="tbl_jobs1" runat="server" cellpadding="0" cellspacing="0" width="100%"
                                                    style="background-color: #707070; border-width: 0px;">
                                                    <tr>
                                                        <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>




                                        </HeaderTemplate>
                                        <ContentTemplate>
                                            <telerik:RadGrid ID="rg_zones_zonelist" runat="server" EnableViewState="true"  PageSize="10"  AllowPaging="true" OnItemDataBound="rg_zones_zonelist_item_databound"
                                                AllowSorting="True" AutoGenerateColumns="False" CellPadding="0" Width="100%" 
                                               GridLines="None"  AllowMultiRowSelection="true" OnPageIndexChanged="rg_zones_zonelist_PageIndexChanged" OnPageSizeChanged="rg_zones_zonelist_PageSizeChanged" OnSortCommand="rg_zones_zonelist_SortCommand"
                                               EnableEmbeddedSkins="true" ItemStyle-Wrap="false">
                                                <ClientSettings>
                                                    <Selecting AllowRowSelect="true" />
                                                </ClientSettings>

                                              
                                              
                                                <MasterTableView AllowMultiColumnSorting="true" ClientDataKeyNames="zonename,volume,pk_location_id"
                                                    DataKeyNames="zonename,volume,pk_location_id"  
                                                    >


                                                    <PagerStyle AlwaysVisible="true" HorizontalAlign="Right" Mode="NextPrevNumericAndAdvanced"
                                                        Width="100%" />
                                                    <Columns>
                                                        <telerik:GridClientSelectColumn ButtonType="ImageButton" HeaderStyle-VerticalAlign="Top"
                                                            HeaderStyle-Width="20px" ImageUrl="../Images/checkbox2.png">
                                                        </telerik:GridClientSelectColumn>


                                                           <telerik:GridBoundColumn DataField="pk_location_id" UniqueName="pk_location_id" Visible="true" Display="false">
                                                                                <ItemStyle CssClass="column" Width="3%" />
                                                                            </telerik:GridBoundColumn>
                                                      
                                                        <telerik:GridBoundColumn HeaderStyle-ForeColor="#404040" HeaderStyle-Font-Size="13px"
                                                            HeaderStyle-Font-Bold="true" DataField="zonename" HeaderText="Zone Name">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderStyle-ForeColor="#404040" HeaderStyle-Font-Size="13px"
                                                            HeaderStyle-Font-Bold="true" DataField="volume" HeaderText="Zone Volume">
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
                                                    </MasterTableView>
                                            </telerik:RadGrid>
                                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
        <td style="background-color: #F7F7F7; height:40px;" align="justify">
          <asp:ImageButton ID="ImageButton1" ImageAlign="Left" runat="server" Enabled="true" ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm.png"
                         CssClass="wizardRightImage"/>
         <asp:Button ID="btn_apply" runat="server" Text="Apply" Enabled="true" 
                BackColor="Transparent" CssClass="wizardRightImage" BorderStyle="None" 
                BorderWidth="0px" onclick="btn_apply_Click1" />
        
                         <asp:Button ID="btn_cancel" runat="server" Text="Cancel" Enabled="true" BackColor="Transparent" CssClass="wizardRightImage" BorderStyle="None" BorderWidth="0px" OnClientClick="javascript:return CloseWindow();" />
        </td>
        </tr>

    </table>
    
    <%--<div style="float:right;height:50px">
    <asp:Button ID="btn_cancel" Text="Cancel" runat="server" Height="30px" />
    </div>
--%>





    </form>
</body>
</html>
