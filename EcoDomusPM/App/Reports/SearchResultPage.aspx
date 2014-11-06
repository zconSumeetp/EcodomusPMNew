<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true" CodeFile="SearchResultPage.aspx.cs" Inherits="App_Reports_SearchResultPage" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript" language="javascript">
        function body_load() {
            var screenhtg = set_NiceScrollToPanel();
         }
        function resize_nice_scroll() {
        
        }

        function RightMenu_expand_collapse(index) {

            var img = document.getElementById("RightMenu_" + index + "_img_expand_collapse");
            $('.RightMenu_' + index + '_Content').toggle();
            if (img.src.indexOf("asset_carrot_up") != -1) {
                img.src = img.src.replace("asset_carrot_up", "asset_carrot_down");
            }
            else {
                img.src = img.src.replace("asset_carrot_down", "asset_carrot_up");
            }
            $(".divScroll").getNiceScroll().resize();
            $('.rpSlide').getNiceScroll().resize();
        }

        function closeRecentEntityWindow(entity) {

            $('#tblRecent' + entity).hide();

        }
        window.onload = body_load;

        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {
            //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
           
            var pageSize = document.getElementById("ContentPlaceHolder1_hfSearchResultPMPageSize").value;
            var scrollArea = sender.GridDataDiv;
            var dataHeight = sender.get_masterTableView().get_element().clientHeight;
            //sender.get_masterTableView().set_pageSize(pageSize);
            if (dataHeight < parseInt(pageSize) * 40) {
                scrollArea.style.height = dataHeight + "px";
            }
            else {
                scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
            }

        }

    </script>
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
       
        
        <tr>
            <td class="centerAlign" >
                <div id="dv_searched_facility" runat="server" style="display: block">
                    <table cellpadding="0" cellspacing="0" style="table-layout: fixed;" id="tblRecentSearchedFacility"
                        width="100%">
                        <tr style="background-color: #808080">
                            <td align="left" style="padding:3px;" class="entityImage">
                                <asp:Image ID="Image6" runat="server" Style="padding-right: 3px; vertical-align: middle;"
                                    ImageAlign="Left" ImageUrl="~/App/Images/Icons/search_icon.jpg" />
                                <asp:Label runat="server" Text="Search Result" ID="Label5" CssClass="gridHeadText"
                                    Width="150px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                <asp:Label ID="Label6" runat="server" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                            </td>
                            <td align="right">
                                <%--<asp:Label ID="Label7" runat="server" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10"
                                    Text="Export"></asp:Label>--%>
                            </td>
                            <td align="right" style="width: 25px; padding: 4px 4px 0 0;">
                               <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_export_sm_white.png"
                                    ClientIDMode="Static" ID="Image7" onClick="RightMenu_expand_collapse(1)" />--%>
                            </td>
                            <td align="right" style="width: 25px; padding: 4px 4px 0 0;">
                                <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                    ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                            </td>
                            <td align="right" style="width: 25px; padding: 4px 4px 0 0;">
                               <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_close_lg_white.png"
                                    onclick="closeRecentEntityWindow('SearchedFacility');" ClientIDMode="Static"
                                    ID="Image9" />--%>
                            </td>
                        </tr>
                        <tr>
                            <td id="td1" runat="server" align="left" style="vertical-align: top" colspan="5">
                                <div id="divSearchedFacilityContent" class="divScroll RightMenu_1_Content" >
                                    <telerik:RadGrid ID="rg_searched_data" runat="server" AllowPaging="True" AllowSorting="True"
                                        AutoGenerateColumns="False" BorderWidth="1px" PagerStyle-AlwaysVisible="true"
                                        AllowMultiRowSelection="true" PageSize="10" EnableEmbeddedSkins="true" 
                                        Skin="Default" onpageindexchanged="rg_searched_data_PageIndexChanged" 
                                        onpagesizechanged="rg_searched_data_PageSizeChanged"  OnItemDataBound="rg_searched_data_OnItemDataBound"
                                        onsortcommand="rg_searched_data_SortCommand" 
                                        onitemcommand="rg_searched_data_ItemCommand">
                                         <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                                        <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                            <Selecting AllowRowSelect="true" />
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                                            <ClientEvents OnGridCreated="GridCreated" />
                                        </ClientSettings>
                                        <MasterTableView DataKeyNames="pk_id,name,entity,facility_id">
                                           <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                                            <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                            <FooterStyle Height="25px" Font-Names="Arial" />
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="pk_id" Visible="false">
                                                    <ItemStyle  Width="10%" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="facility_id" Visible="false">
                                                    <ItemStyle  Width="10%" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridButtonColumn ButtonType="LinkButton" ItemStyle-Font-Underline="true" HeaderStyle-Width="25%"
                                                    UniqueName="facname" CommandName="Edit" CommandArgument="sel" SortExpression="name"
                                                    HeaderText="<%$Resources:Resource,Name%>" HeaderStyle-Wrap="false" DataTextField="name">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle  Wrap="false" Font-Underline="true" />
                                                </telerik:GridButtonColumn>
                                                <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>" HeaderStyle-Width="25%"
                                                    UniqueName="description">
                                                    <ItemStyle  Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle HorizontalAlign="Left" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="entity" HeaderText="<%$Resources:Resource,Entity%>" HeaderStyle-Width="25%"
                                                    UniqueName="entity">
                                                    <ItemStyle  Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle HorizontalAlign="Left" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
         <tr>
              <td style="display: none;">
                  <table>
                      <tr>
                          <td style="padding-top: 0px; display: none" align="left">
                              <asp:HiddenField ID="hfSearchResultPMPageSize" runat="server" Value="" />
                              
                          </td>
                      </tr>
                  </table>
              </td>
          </tr>
    </table>

    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_searched_data">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_searched_data" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
             <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

