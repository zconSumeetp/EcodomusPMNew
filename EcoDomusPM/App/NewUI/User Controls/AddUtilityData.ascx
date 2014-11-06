<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddUtilityData.ascx.cs" Inherits="App_NewUI_AddUtilityData" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI"  TagPrefix="telerik"%>
  <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Hay" DecoratedControls="Buttons" />
  <telerik:RadCodeBlock  ID="RadCodeBlock1" runat="server">
  <script type="text/javascript">

      var panelBar;
      var panelBarProductsTab;
      var multiPage;

      function stopPropagation(e) {

          e.cancelBubble = true;

          if (e.stopPropagation)
              e.stopPropagation();
      }

      function SetUtilityDataID(sender, eventArgs) {
     
          var grid = sender;
          var MasterTable = grid.get_masterTableView();
          var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
          var cell_utility_data = MasterTable.getCellByColumnUniqueName(row, "pk_energymodel_facility_billing_statements");
          //here cell.innerHTML holds the value of the cell
          set_utility_data_id(cell_utility_data.innerHTML);
      }

      function UnsetProjectID(sender, eventArgs) {
          set_project_id("");
      }

      function OpenUtilityDataPopup() {
      
          manager = $find("<%=rd_manager.ClientID%>");
          var url;
          var url = "EnergyModelingAddUtilityData.aspx";
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

    </script>
  
  </telerik:RadCodeBlock>
  <div>
  <table width="95%" border="0" cellpadding="0" cellspacing="0">
  <tr>
  <td>
  <telerik:RadPanelBar ID="RadPanelBar1" runat="server" Width="100%" ExpandMode="MultipleExpandedItems"
                            BorderWidth="0" BorderColor="White">
                            <ExpandAnimation Type="OutSine" />
                            <Items>
                                <telerik:RadPanelItem BorderWidth="0" BorderColor="Transparent"  Expanded="true" Text="Facility Billing Statements" IsSeparator="false">
                                    <HeaderTemplate>
                                     <asp:Panel ID="pnlFacilities" runat="server" DefaultButton="btn_searchimg" BorderWidth="0" BorderColor="Transparent">
                                        <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                            <tr>
                                                <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                    <asp:Image ID="igm_building" runat="server" Style="padding-right: 3px; vertical-align: middle;"
                                                        ImageAlign="Left" ImageUrl="~/App/Images/Icons/icon_facilities_sm_white.png" />
                                                    <asp:Label runat="server" Text="Facility Billing Statements" ID="Label1"  CssClass="gridHeadText"
                                                        Width="190px" Font-Size="Small"></asp:Label>
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
                                                                    <asp:ImageButton ID="btn_searchimg" Height="10px" runat="server"  OnClick="btn_searchimg_OnClick"  ImageUrl="~/App/Images/Icons/icon_search_sm.png"  />
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
                                                  border-width: 2px;">
                                                  <tr>
                                                      <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                                                      </td>
                                                  </tr>
                                              </table>
                                        </asp:Panel>
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <telerik:RadGrid ID="rgStatements" runat="server" PageSize="10" AllowPaging="true"
                                            PagerStyle-AlwaysVisible="true" BorderColor="Black" AllowMultiRowSelection="true"
                                            BorderWidth="0" AutoGenerateColumns="false"
                                          OnPageSizeChanged="rgStatements_PageSizeChanged"
                                            OnPageIndexChanged="rgStatements_PageIndexChanged" OnSortCommand="rgStatements_OnSortCommand"
                                            >
                                            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                            <ClientSettings EnableRowHoverStyle="true">
                                                <Selecting AllowRowSelect="true" />
                                                 <ClientEvents OnRowSelected="SetUtilityDataID"/>
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="pk_energymodel_facility_billing_statements,Types_of_services"
                                                HeaderStyle-CssClass="gridHeaderText">
                                                <PagerStyle HorizontalAlign="Right" Mode="NextPrevNumericAndAdvanced" AlwaysVisible="true"
                                                    PageSizeLabelText="Show Rows" />
                                                <%-- <PagerStyle BackColor="White" ForeColor="Black"  HorizontalAlign="Center" />
                                                <PagerTemplate>
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
                                                            <td width="3%" align="left">
                                                                <asp:TextBox ID="txtgotopage" runat="server" Width="60%">
                                                                </asp:TextBox>
                                                            </td>
                                                            <td width="4%" align="right">
                                                                <asp:Label ID="lblshowrows" runat="server" Text="Show rows:">
                                                                </asp:Label>
                                                            </td>
                                                            <td width="4%" align="left">
                                                                <telerik:RadNumericTextBox ID="txtradnumeriktextbox" runat="server" ShowSpinButtons="true"
                                                                    Width="60%" Type="Number" DataType="intger" MinValue="0">
                                                                    <IncrementSettings Step="1"  />
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
                                                                <asp:ImageButton ID="ibtnNewUtilityData"   style="border-spacing:0px; border-top-style:none; border-top-width:0px; margin-top:auto; "  runat="server" ImageUrl="~/App/Images/Icons/AddUtilityData.png"
                                                                    BorderWidth="0"></asp:ImageButton>
                                                            </td>
                                                            <td width="1%">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </PagerTemplate>--%>
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="pk_energymodel_facility_billing_statements" Visible="true" Display="false">
                                                        <ItemStyle CssClass="column" Width="10%" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Types_of_services" HeaderText="Type of Service"
                                                        UniqueName="Types_of_services" HeaderStyle-ForeColor="GrayText" HeaderStyle-Font-Bold="true"
                                                        HeaderStyle-Font-Size="Small">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Meter#" HeaderText="Meter#" UniqueName="Meter"
                                                        HeaderStyle-ForeColor="GrayText" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Small">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="READ_date" HeaderText="Read Date" UniqueName="READ_date"
                                                        HeaderStyle-ForeColor="GrayText" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Small">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Previous" HeaderText="Previous" UniqueName="Previous"
                                                        HeaderStyle-ForeColor="GrayText" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Small">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="CURREN" HeaderText="Current" UniqueName="CURREN"
                                                        HeaderStyle-ForeColor="GrayText" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Small">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Multiplier" HeaderText="Multiplier" UniqueName="Multiplier"
                                                        HeaderStyle-ForeColor="GrayText" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Small">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Usage" HeaderText="Usage" UniqueName="Usage"
                                                        HeaderStyle-ForeColor="GrayText" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Small">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="amount" HeaderText="Amount" UniqueName="amount"
                                                        HeaderStyle-ForeColor="GrayText" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Small">
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
        <tr>
        <td align="right" >
            <asp:ImageButton ID="ibtnNewEnergyModeling" runat="server" ImageUrl="~/App/Images/Icons/AddUtilityData.png"
                BorderWidth="0" OnClientClick="javascript:return OpenUtilityDataPopup();">
            </asp:ImageButton>
        </td>
    </tr>
    </table>        
    
     <telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Red" Skin="">
        <Windows>
             <telerik:RadWindow ID="rd_add_project" runat="server" ReloadOnShow="false" Height="375"
                Width="350" DestroyOnClose="true" AutoSize="false" OffsetElementID="btn_search" 
                VisibleStatusbar="false" VisibleOnPageLoad="false"  BorderColor="Black"
                EnableAjaxSkinRendering="false" BorderStyle="None" BackColor="Red" VisibleTitlebar="false"
                Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>     
  </div>