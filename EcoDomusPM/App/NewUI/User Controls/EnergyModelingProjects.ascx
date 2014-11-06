<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingProjects.ascx.cs"
    Inherits="App_NewUI_User_Controls_EnergyModelingProjects" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Hay" DecoratedControls="Buttons" />
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        function RowSelected(sender, eventArgs) {
            
            var grid = sender;
            var MasterTable = grid.get_masterTableView(); var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
            var cell_project_id = MasterTable.getCellByColumnUniqueName(row, "pk_energymodel_simulation_profile");
            var cell_project_name = MasterTable.getCellByColumnUniqueName(row, "profile_name");
            var id = cell_project_id.innerHTML;
            var name = cell_project_name.innerHTML;
            //var url = "EnergyZones.aspx?pk_energymodel_simulation_profile=" + id + "&project_name=" + name;
            var url = "EnergyModelingProjectDetails.aspx?pk_energymodel_simulation_profile=" + id + "&project_name=" + name;
            top.location.href(url);

        }

        var panelBar;
        var panelBarProductsTab;
        var multiPage;

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }

        function SetProjectID(sender, eventArgs) {
            var grid = sender;
            var MasterTable = grid.get_masterTableView(); var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
            var cell_project = MasterTable.getCellByColumnUniqueName(row, "pk_energymodel_simulation_profile");
            //here cell.innerHTML holds the value of the cell
            set_project_id(cell_project.innerHTML);
        }

        function UnsetProjectID(sender, eventArgs) {
            set_project_id("");
        }

        function delete_project() {
            var answer = confirm("Are you sure you want to delete this item?")
            if (answer)
                return true;
            else
                return false;

        }

    </script>
</telerik:RadCodeBlock>
<div>
    <telerik:RadPanelBar ID="RadPanelBar1" runat="server" Width="100%" ExpandMode="MultipleExpandedItems"
        BorderWidth="0" BorderColor="White">
        <ExpandAnimation Type="OutSine" />
        <Items>
            <telerik:RadPanelItem Expanded="true" Text="Energy Modeling Projects" IsSeparator="false" BorderWidth="0" BorderColor="Transparent">
                <HeaderTemplate>
                    <asp:Panel ID="pnlFacilities" runat="server" DefaultButton="btn_searchimg" BorderWidth="0" BorderColor="Transparent">
                    <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                        <tr>
                            <td width="2%">
                            </td>
                            <td onclick="stopPropagation(event)" align="left">
                                <asp:Label runat="server" Text="Energy Modeling Projects" Font-Size="Small" ID="lbl_grid_head"
                                    CssClass="gridHeadText" Width="190px"></asp:Label>
                            </td>
                            <td align="right" onclick="stopPropagation(event)">
                                <div id="div_search" onclick="stopPropagation(event)" style="background-color: White;
                                    width: 170px;">
                                    <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                        width: 100%;">
                                        <tr style="border-spacing=0px;">
                                            <td align="left" width="70%" rowspan="0px" style="background-color: White; height: inherit;
                                                padding-bottom: 0px;">
                                                <telerik:RadTextBox CssClass="txtboxHeight" runat="server" EmptyMessage="Search"
                                                    BorderColor="White" ID="txt_search" Height="10px" Width="100%">
                                                </telerik:RadTextBox>
                                            </td>
                                            <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 12px;
                                                padding-bottom: 0px;">
                                                <asp:ImageButton ClientIDMode="Static" OnClick="btn_searchimg_OnClick" ID="btn_searchimg"
                                                    Height="10px" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
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
                    <table   cellpadding="0" cellspacing="0" width="100%" style=" background-color:#707070; border-width:0px;">
                       <tr>
                            <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height:1px">
                            </td>
                        </tr>
                    </table>
                    </asp:Panel>
                </HeaderTemplate>
           
                <ContentTemplate>
                    <telerik:RadGrid ID="rgProjects" runat="server" PageSize="10" AllowPaging="true"
                        HeaderStyle-Font-Bold="true" BorderWidth="0" HeaderStyle-BorderWidth="0" AllowSorting="true"
                        PagerStyle-AlwaysVisible="true" AllowMultiRowSelection="true" AutoGenerateColumns="false"
                        OnItemEvent="rgProjects_OnItemEvent" Width="100%" OnItemDataBound="rgProjects_OnItemDataBound"
                        OnPageSizeChanged="rgProjects_PageSizeChanged" OnPageIndexChanged="rgProjects_PageIndexChanged"
                        OnSortCommand="rgProjects_OnSortCommand" OnItemCreated="rgProjects_ItemCreated">
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                            <ClientEvents OnRowDblClick="RowSelected" OnRowSelected="SetProjectID" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="pk_energymodel_simulation_profile,profile_name" HeaderStyle-CssClass="gridHeaderText">
                            <PagerStyle HorizontalAlign="Right" Mode="NextPrevNumericAndAdvanced" AlwaysVisible="true" />
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_energymodel_simulation_profile" Visible="true"
                                    Display="false" UniqueName="pk_energymodel_simulation_profile">
                                    <ItemStyle CssClass="column" Width="5%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="profile_name" HeaderText="<%$Resources:Resource,Name%>"
                                    UniqueName="profile_name" HeaderStyle-ForeColor="GrayText">
                                    <ItemStyle Wrap="true" Width="30%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="citystate" HeaderText="City/State" UniqueName="City_state"
                                    HeaderStyle-ForeColor="GrayText">
                                    <ItemStyle Wrap="true" Width="25%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>"
                                    UniqueName="description" HeaderStyle-ForeColor="GrayText">
                                    <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="false" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn UniqueName="remove" SortExpression="Remove" HeaderText="Delete"
                                    HeaderStyle-Width="10%" HeaderStyle-ForeColor="GrayText">
                                    <ItemStyle CssClass="column" />
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" runat="server"
                                            CommandName="delete" OnClientClick="javascript:return delete_project();" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </ContentTemplate>
            </telerik:RadPanelItem>
        </Items>
    </telerik:RadPanelBar>
    <asp:HiddenField ID="hfcount" runat="server" />
</div>
