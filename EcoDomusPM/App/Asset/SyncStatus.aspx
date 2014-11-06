<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SyncStatus.aspx.cs" Inherits="App_Asset_SynchronizeFacility" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ecodomus FM Synch Status</title>
    <style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
</head>
<body style="margin: 0px 0px 0px 0px; padding-top: 0; background: white;">
    <script language="javascript" type="text/javascript">
        function close_() {
            window.close();
            return false;
        }

        function showtabs(lbl) {
            // alert("hi");
            var gridtitle = document.getElementById("<%=lblGridTitle.ClientID %>");
            if (lbl == '1') {

                gridtitle.innerHTML = "Completed items during import";
            }
            else if (lbl == '2') {

                gridtitle.innerHTML = "Completed items during export";
            }
            if (lbl == '3') {

                gridtitle.innerHTML = "Failed items during import";
            }
            if (lbl == '4') {

                gridtitle.innerHTML = "Failed items during export";
            }

            var vis = document.getElementById('<%=RadTabStrip1.ClientID%>');
            var wis = document.getElementById('<%=RadMultiPage1.ClientID%>');


            vis.style.display = "block";
            wis.style.display = "block";

            return false;


        }
    </script>
    <form id="form1" runat="server">
    <table border="0" width="700px" style="margin: 50px 0px 0px 70px">
        <caption>
            <asp:Label ID="lblSyncRes" runat="server" Text="<%$Resources:Resource,Synchronization_Result_For%>"></asp:Label>
            <asp:Label ID="lblextsys" runat="server" Text=""></asp:Label>
        </caption>
        <tr>
            <td colspan="2" align="left">
                <asp:Label ID="lblSync" CssClass="Label" runat="server" Text="<%$Resources:Resource,Synchronization_Type%>"></asp:Label>:-
                <asp:Label ID="lblSyncType" CssClass="Label" runat="server" Text="Manual"></asp:Label>
                <%-- <asp:Label ID="lblSyncType" CssClass="Header" runat="server" Text="Label" Visible ="false"></asp:Label>--%>
            </td>
        </tr>
        <tr>
            <td colspan="2" height="20px">
            </td>
        </tr>
        <tr>
            <td class="style1">
                <asp:Label ID="Label5" CssClass="captiondock" runat="server" Text="<%$Resources:Resource,Import%>"></asp:Label>
            </td>
            <td>
                <asp:Label ID="Label6" CssClass="captiondock" runat="server" Text="<%$Resources:Resource,Export%>"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style1">
                <asp:Label ID="Label7" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,Total_Imported_Data_Transfer%>"></asp:Label>:
                <asp:Label ID="lblTotalImportedlData" CssClass="LabelText" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="style1">
                <asp:Label ID="Label8" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,Total_Exported_Data_Transfer%>"></asp:Label>:
                <asp:Label ID="lblTotalExportedData" CssClass="LabelText" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style1">
                <asp:Label ID="Label11" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,Items_Completed%>"></asp:Label>:
                <asp:LinkButton ID="LnkBtnImportedCompleted" runat="server" OnClientClick="javasctript:return showtabs('1')">
                    <asp:Label ID="lblImportedCompleted" CssClass="LabelText" runat="server" Text="Label"></asp:Label></asp:LinkButton>
            </td>
            <td>
                <asp:Label ID="Label13" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,Items_Completed%>"></asp:Label>:
                <asp:LinkButton ID="LnkBtnExportedCompleted" runat="server" OnClientClick="javasctript:return showtabs('2')">
                    <asp:Label ID="lblExportedCompleted" CssClass="LabelText" runat="server" Text="Label"></asp:Label></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td class="style1">
                <asp:Label ID="Label15" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,Items_Failed%>"></asp:Label>:
                <asp:LinkButton ID="LnkBtnImportedFailed" runat="server" OnClientClick="javasctript:return showtabs('3')">
                    <asp:Label ID="lblImportedFailed" CssClass="LabelText" runat="server" Text="Label"></asp:Label></asp:LinkButton>
            </td>
            <td>
                <asp:Label ID="Label17" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,Items_Failed%>"></asp:Label>:
                <asp:LinkButton ID="LnkBtnExportedFailed" runat="server" OnClientClick="javasctript:return showtabs('4')">
                    <asp:Label ID="lblExportedFailed" CssClass="LabelText" runat="server" Text="Label"></asp:Label></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td class="style1">
                <asp:Label ID="Label19" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,Items_Remaining%>"></asp:Label>:
                <asp:Label ID="lblImportedRemain" CssClass="LabelText" runat="server" Text="0"></asp:Label>
            </td>
            <td>
                <asp:Label ID="Label21" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,Items_Remaining%>"></asp:Label>:
                <asp:Label ID="lblExportedRemain" CssClass="LabelText" runat="server" Text="0"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2" height="20px">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="lblGridTitle" CssClass="captiondock" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="style5">
                <telerik:RadScriptManager ID="ScriptManager" runat="server" />
                <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1"
                    SelectedIndex="1" Align="Justify" ReorderTabsOnSelect="True" Width="450px" Height="24px"
                    Style="display: none">
                    <Tabs>
                        <telerik:RadTab Text="<%$Resources:Resource,Asset%>">
                        </telerik:RadTab>
                        <telerik:RadTab Text="<%$Resources:Resource,Spaces%>" Selected="True">
                        </telerik:RadTab>
                        <telerik:RadTab Text="Floors">
                        </telerik:RadTab>
                        <telerik:RadTab Text="<%$Resources:Resource,Work_orders%>">
                        </telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="RadMultiPage1" runat="server" CssClass="pageView" Width="345px"
                    Visible="True" SelectedIndex="1" Style="display: none">
                    <telerik:RadPageView ID="rpv_asset_tab" runat="server">
                        <telerik:RadGrid ID="rg_asset" runat="server" AutoGenerateColumns="false" AllowPaging="True"
                            Width="450" AllowSorting="True" CellSpacing="0" GridLines="None">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="450" />
                            <MasterTableView DataKeyNames="pk_asset_id">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="pk_asset_id" HeaderText="asset id" Visible="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="asset_done" HeaderText="Assets Name"
                                        UniqueName="assetName">
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView></telerik:RadGrid></telerik:RadPageView>
                    <telerik:RadPageView ID="rpv_space_tab" runat="server">
                        <telerik:RadGrid ID="rg_spaces" runat="server" AutoGenerateColumns="false" AllowPaging="True"
                            Width="450" AllowSorting="True" CellSpacing="0" GridLines="None">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="450" />
                            <MasterTableView DataKeyNames="pk_location_id">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="pk_location_id" HeaderText="asset id" Visible="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="space_done" HeaderText="Space Name">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView></telerik:RadGrid></telerik:RadPageView>
                    <telerik:RadPageView ID="rpv_floors" runat="server">
                        <telerik:RadGrid ID="rg_floor" runat="server" AutoGenerateColumns="false" AllowPaging="True"
                            AllowSorting="True" Width="450" CellSpacing="0" GridLines="None">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="450" />
                            <MasterTableView DataKeyNames="">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="pk_location_id" HeaderText="location id" Visible="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="floor_done" HeaderText="Floor Name">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView></telerik:RadGrid></telerik:RadPageView>
                    <telerik:RadPageView ID="rpv_work_order" runat="server" Height="16px" Width="345px">
                    <telerik:RadGrid ID="rg_work_order" runat="server" AutoGenerateColumns="false" AllowPaging="True"
                            Width="450" AllowSorting="True" CellSpacing="0" GridLines="None">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="450" />
                            <MasterTableView DataKeyNames="pk_work_order_id">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="pk_work_order_id" HeaderText="asset id" Visible="false">
                                    </telerik:GridBoundColumn>                                    
                                    <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="work_order_number" HeaderText="Work Order Name"
                                        UniqueName="work_orderName">
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn DataField="work_order_desc" HeaderText="Description" UniqueName="Description">
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView></telerik:RadGrid>
                    </telerik:RadPageView>
                   
                </telerik:RadMultiPage>
            </td>
        </tr>
        <%--<tr>
            <td class="style1">
                <asp:Button ID="btnClose" runat="server" Text="<%$Resources:Resource,Close%>" Width="65px"
                    Height="25px" OnClientClick="close_()" />
            </td>
        </tr>--%>
    </table>
    </form>
</body>
</html>
