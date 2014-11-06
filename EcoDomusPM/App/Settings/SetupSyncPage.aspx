<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="SetupSyncPage.aspx.cs" Inherits="App_Settings_SetupSyncPage" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    
    <link href="../../App_Themes/EcoDomus/New_UI_Panelbar.css" rel="stylesheet" type="text/css" />
    <link href="../../App_Themes/EcoDomus/NEWUI_Grid.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="loadPopUp" runat="server">
        <script type="text/javascript">
            function gotoPage(id, pagename) {
                var url;

                if (pagename == "SyncProfile") {
                    url = "SetupSync.aspx?pk_external_system_configuration_id=" + id + "&pagevalue=SetupSync";
                }
                else if (pagename == "Facility") {

                    url = "../Locations/FacilityMenu.aspx?FacilityId=" + id;
                }

                location.href(url);
            }
        </script>
        <script type="text/javascript">
            function delete_configuration() {
                var answer = confirm("Are you sure you want to delete this item?")
                if (answer)
                    return true;
                else
                    return false;

            }

            function Clear() {

                document.getElementById("<%=txtsearch.ClientID %>").value = "";
                return false;

            }
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            function GridCreated(sender, args) {
                //alert(sender.get_masterTableView().get_pageSize());
                var pageSize = document.getElementById("ContentPlaceHolder1_hfTypePMPageSize").value;
                var scrollArea = sender.GridDataDiv;
                var dataHeight = sender.get_masterTableView().get_element().clientHeight;

                if (dataHeight < parseInt(pageSize) * 40) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
                }

                //sender.get_masterTableView().set_pageSize(globalPageHeight);
            }
            window.onload = body_load;
            function body_load() {
                var screenhtg = set_NiceScrollToPanel();
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadFormDecorator ID="rdfSetupSync" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div style="margin:0px;">
        <asp:Panel ID="panelSearch" runat="server" DefaultButton="radbtnsearch">
            <table width="100%" align="center" style="table-layout: fixed;">
                <tr>
                    <td align="left">
                        <telerik:RadButton ID="btnNext" runat="server" Text="<%$Resources:Resource,Add_Configuration%>"
                            Skin="Default" Enabled="true" OnClick="btnNext_Click" />
                              <asp:HiddenField ID="hfTypePMPageSize" runat="server" Value="" />
                    </td>
                </tr>
                <tr>
                    <td class="centerAlign" align="left">
                        <div class="rpbItemHeader ">
                            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                                <tr>
                                    <td align="left" class="entityImage" style="width: 50%;">
                                        <asp:Label runat="server" Text="<%$Resources:Resource,Setup_Sync_Configuration%>"
                                            ID="lbl_grid_head" CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8"
                                            Font-Names="Arial" Font-Size="12"></asp:Label>
                                    </td>
                                    <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;">
                                        <div id="div_search" style="width: 200px; background-color: white;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtsearch" Width="180px">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ClientIDMode="Static" ID="radbtnsearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                            OnClick="radbtnsearch_click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td align="right" style="padding: 4px 4px 0 0;">
                                        <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div>
                            <telerik:RadGrid runat="server" ID="rgconfiguration" BorderWidth="1px" AllowPaging="true"
                                OnItemCommand="rgconfiguration_ItemCommand" PageSize="10" AutoGenerateColumns="False"
                                AllowSorting="True" Visible="true" Skin="Default" OnPageIndexChanged="rgconfiguration_PageIndexChanged"
                                OnPageSizeChanged="rgconfiguration_PageSizeChanged" OnSortCommand="rgconfiguration_SortCommand"
                                OnItemDataBound="rgconfiguration_ItemDataBound">
                                <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" AlwaysVisible="true" />
                                <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                    <Selecting AllowRowSelect="true" />
                                    <Scrolling AllowScroll="true" ScrollHeight="400" UseStaticHeaders="true" />
                                      <ClientEvents OnGridCreated="GridCreated" />
                                </ClientSettings>
                                <MasterTableView DataKeyNames="pk_external_system_configuration_id" AllowSorting="true">
                                    <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                    <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                    <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                    <FooterStyle Height="25px" Font-Names="Arial" />
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="pk_external_system_configuration_id" HeaderText="configuration_id"
                                            UniqueName="pk_external_system_configuration_id" SortExpression="configuration_name"
                                            Visible="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="pk_facility_id" HeaderText="facility_id" UniqueName="pk_facility_id"
                                            SortExpression="configuration_name" Visible="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="<%$Resources:Resource,Configuration_Name%>"
                                            DataField="configuration_name" UniqueName="configuration_name">
                                            <HeaderStyle Width="40%" Wrap="false" />
                                            <ItemStyle Width="40%" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="external_system_name" HeaderText="<%$Resources:Resource,External_System_Name%>"
                                            UniqueName="external_system_name" SortExpression="external_system_name">
                                            <HeaderStyle Width="25%" Wrap="false" />
                                            <ItemStyle Width="25%" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridBoundColumn DataField="external_system" HeaderText="<%$Resources:Resource,External_System%>"
                            UniqueName="external_system">
                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridButtonColumn DataTextField="linkfacility" HeaderText="<%$Resources:Resource,Facility_Name%>"
                                            UniqueName="name" SortExpression="name">
                                            <HeaderStyle Width="30%" Wrap="false" />
                                            <ItemStyle Width="25%" Wrap="false" />
                                        </telerik:GridButtonColumn>
                                        <telerik:GridTemplateColumn UniqueName="remove" SortExpression="Remove" ItemStyle-HorizontalAlign="Center"
                                            HeaderText="<%$Resources:Resource,Delete%>">
                                          <%--  <HeaderStyle Width="10%" Wrap="false" />
                                            <ItemStyle Width="10%" Wrap="false" />--%>
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" runat="server"
                                                    CommandName="delete" OnClientClick="javascript:return delete_configuration();"
                                                     Height="25px" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </td>
                </tr>
               
               
            </table>
        </asp:Panel>
    </div>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager" runat="server">
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxManagerProxy ID="organizationsManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="radbtnsearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgconfiguration" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgconfiguration">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgconfiguration" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
