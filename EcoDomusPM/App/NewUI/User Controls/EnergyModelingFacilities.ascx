<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingFacilities.ascx.cs"
    Inherits="App_NewUI_User_Controls_EnergyModelingFacilities" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Hay" DecoratedControls="Buttons" />
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server" >
    <script type="text/javascript">
        function RowSelected(sender, eventArgs) {
            var grid = sender;
            var MasterTable = grid.get_masterTableView(); var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
            var cell_facility_id = MasterTable.getCellByColumnUniqueName(row, "pk_facility_id");
            var id = cell_facility_id.innerHTML;
            var cell_facility_name = MasterTable.getCellByColumnUniqueName(row, "name");
            var name = cell_facility_name.innerHTML;
         
            var url = "EnergyModelingProjects.aspx?pk_facility_id=" + id+"&facility_name="+name;
            top.location.href(url);

        }

        
        function pagesize(sender, GridCommandEventArgs) {

            sender.set_value(10);
          
        }

        var panelBar;
        var panelBarProductsTab;
        var multiPage;

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }
        

        function openEnergyModelingWizard() {
            manager = $find("<%=rd_manager.ClientID%>");
            var url;
            var url = "EnergyModelingWizardWindow.aspx";
            if (manager != null) {
                var windows = manager.get_windows();
                if (windows[0] != null) { //changed line
                    windows[0].setUrl(url);

                    windows[0].show();
                    windows[0].set_modal(false);

                }
            }
            return false;
        }

        function delete_facility() {
            var answer = confirm("Are you sure you want to delete this item?")
            if (answer)
                return true;
            else
                return false;

        }
      
    </script>
</telerik:RadCodeBlock>

<div>
<table width="95%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td>
    <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" ExpandMode="MultipleExpandedItems" BorderWidth="0" BorderColor="White" >
        <ExpandAnimation Type="OutSine" />
        <Items>

            <telerik:RadPanelItem Expanded="true" Text="Energy Modeling Facility" IsSeparator="false" BorderWidth="0" BorderColor="Transparent">
                <HeaderTemplate>
                    <asp:Panel ID="pnlFacilities" runat="server" DefaultButton="btn_searchimg" BorderWidth="0"
                        BorderColor="Transparent" ScrollBars="None">
                        <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                            <tr>
                                <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                    <asp:Image ID="igm_building" runat="server" Style="padding-right: 3px; vertical-align: middle;"
                                        ImageAlign="Left" ImageUrl="~/App/Images/Icons/icon_facilities_sm_white.png" />
                                    <asp:Label runat="server" Text="Energy Modeling Facilities" ID="lbl_grid_head" CssClass="gridHeadText"
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
                                                        EmptyMessage="Search" BorderColor="White" ID="txt_search" Height="13px" Width="100%">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                    padding-bottom: 0px;">
                                                    <asp:ImageButton ClientIDMode="Static" OnClick="OnClick_BtnSearch" ID="btn_searchimg"
                                                        Height="13px" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
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
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #707070;
                            border-width: 0px;">
                            <tr>
                                <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </HeaderTemplate>
                <ContentTemplate>
                
                    <telerik:RadGrid ID="rg_facility" runat="server" AutoGenerateColumns="False" BorderWidth="0"
                        HeaderStyle-BorderWidth="0" AllowSorting="True" AllowPaging="True" PageSize="10"
                        GridLines="None" AllowMultiRowSelection="true" PagerStyle-AlwaysVisible="true"
                        OnItemDataBound="rg_facility_ItemDataBound" OnPageSizeChanged="rg_facility_PageSizeChanged"
                        OnPageIndexChanged="rg_facility_PageIndexChanged" OnSortCommand="rg_facility_OnSortCommand"
                        OnItemCreated="rg_facility_ItemCreated" OnItemCommand="rg_facility_ItemCommand">
                          <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />

                            <ClientEvents  OnRowDblClick="RowSelected"/>
                        </ClientSettings>
                        <PagerStyle Mode="NextPrevNumericAndAdvanced" HorizontalAlign="Right" Width="100%"
                            AlwaysVisible="true" />
                        <MasterTableView DataKeyNames="pk_facility_id,name" ClientDataKeyNames="pk_facility_id,name" AllowMultiColumnSorting="True" 
                            GroupLoadMode="Server" ExpandCollapseColumn-Visible="false" HeaderStyle-CssClass="gridHeaderText">
                            <%--   <PagerStyle  BackColor="White" ForeColor="Black" HorizontalAlign="Center" />
                            <PagerTemplate >
                                <table border="0" width="100%" align="right" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td height="1px" style="background-color: Orange;" colspan="9">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="1%">
                                        </td>
                                        <td width="3%" align="right">
                                            <asp:Label ID="lblgotopage" runat="server" Text="Go to:">
                                            </asp:Label>
                                        </td>
                                        <td width="2%" align="left">
                                            <asp:TextBox ID="txtgotopage" OnTextChanged="txtgotopage_textChanged" ClientIDMode="Static" runat="server" Width="60%" Text='<%# (int)DataBinder.Eval(Container, "OwnerTableView.CurrentPageIndex") + 1 %>'>
                                            </asp:TextBox>
                                        </td>
                                         <td width="3%">
                                              <asp:LinkButton ID="btngotopage" Text="Go"  ClientIDMode="Static"  runat="server" CommandName="gotoPage"
                                                    CommandArgument="gotoPage" />
                                              </td>
                                        <td width="4%" align="right">
                                            <asp:Label ID="lblshowrows" runat="server" Text="Show rows:">
                                            </asp:Label>
                                        </td>
                                        <td width="4%" align="left">
                                            <telerik:RadNumericTextBox ID="txtradnumeriktextbox" runat="server" ShowSpinButtons="true"
                                                Width="60%" Type="Number" MinValue="0">
                                                <IncrementSettings Step="1" />
                                                <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                            </telerik:RadNumericTextBox>
                                        </td>
                                        <td width="4%" align="left">
                                            <asp:Label ID="lbltotal" runat="server" Text="1-7 of 88">
                                            </asp:Label>
                                        </td>
                                        <td width="7%" align="left">
                                            <asp:ImageButton Height="25px" ID="ibtnleft" runat="server" ImageUrl="~/App/Images/Icons/left_btn.png" />
                                            <asp:ImageButton Height="25px" ID="ibtnright" runat="server" ImageUrl="~/App/Images/Icons/right_btn.png" />
                                        </td>
                                        <td align="right" width="20%">
                                            <asp:ImageButton ID="ibtnNewEnergyModeling" runat="server" ImageUrl="~/App/Images/Icons/AddEnergyModeling.png"
                                                BorderWidth="0" OnClientClick="javascript:return openEnergyModelingWizard();"></asp:ImageButton>
                                        </td>
                                        <td width="1%">
                                        </td>
                                    </tr>
                                </table>
                            </PagerTemplate>--%>
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_facility_id"  Visible="true" Display="false">
                                    <ItemStyle CssClass="column"   Width="10%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Name%>"
                                    UniqueName="name" HeaderStyle-ForeColor="GrayText">
                                    <ItemStyle Wrap="true" Width="30%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="City_state" HeaderText="City/State" UniqueName="City_state"
                                    HeaderStyle-ForeColor="GrayText">
                                    <ItemStyle Wrap="true" Width="30%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>"
                                    UniqueName="description" HeaderStyle-ForeColor="GrayText">
                                    <ItemStyle Wrap="true" Width="30%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn UniqueName="remove" SortExpression="Remove"  HeaderText="Delete"  HeaderStyle-Width="10%" HeaderStyle-ForeColor="GrayText">
                                            <ItemStyle CssClass="column"  />
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" runat="server"
                                                    CommandName="delete" OnClientClick="javascript:return delete_facility();" />
                                            </ItemTemplate>
                                 </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid> 

                </ContentTemplate>
            </telerik:RadPanelItem>
        </Items>
    </telerik:RadPanelBar>
    </td>
    </tr>
    <tr>
        <td align="right" >
            <asp:ImageButton ID="ibtnNewEnergyModeling" runat="server" ImageUrl="~/App/Images/Icons/AddEnergyModeling.png"
                BorderWidth="0" OnClientClick="javascript:return openEnergyModelingWizard();">
            </asp:ImageButton>
        </td>
    </tr>
    </table>   
    <telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Red" Skin="">
        <Windows>
            <telerik:RadWindow ID="rd_window_modeling_wizard" runat="server" ReloadOnShow="false"
                Width="900" height="450"  AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" Behaviors="Resize,Move" BorderColor="Black"
                EnableAjaxSkinRendering="false" BorderStyle="None" BackColor="Red" VisibleTitlebar="false"
                Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
                       
</div>

