<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCOmniclassUniclass.ascx.cs"
    Inherits="App_Locations_UCOmniclassUniclass" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head>
    <title>Assign uniclass</title>
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
        <script type="text/javascript" language="javascript">


            function select_Sub_System1(id, name) {
                
                var rdw = GetRadWindow();
                if (window.parent.location.href.indexOf('OrganizationProfile') > 0) {
                    window.parent.load_omni_class(name, id);
                    rdw.close();
                }
                else if (window.parent.location.href.indexOf('UserProfile') > 0) {
                    window.parent.load_omni_class(name, id);
                    rdw.close();
                }
                else if (window.parent.location.href.indexOf('ClientUserProfile') > 0) {
                    window.parent.load_omni_class(name, id);
                    rdw.close();

                }
                else {
                    window.parent.refreshgrid();
                    rdw.close();
                }

            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function closeWindow_assign() {
                var rdw = GetRadWindow();
                rdw.close();
            }

            function bindproviders() {
                var rdw = GetRadWindow();
                rdw.BrowserWindow.rebindgrid();
                rdw.close();
            }

            function closeWindow() {
                var rdw = GetRadWindow();
                rdw.close();
                CloseWindow();
                //self.close();
            }

            function load_me() {

                if (document.getElementById("hfnames").value == '' || document.getElementById("hfItems_id").value == '') {
                    alert("Select Category");
                    return false;
                }
                else {
                    window.parent.opener.load_omni_class(document.getElementById("hfnames").value, document.getElementById("hfItems_id").value);
                    self.close();
                }
            }

            function assignomniclass() {
                alert("Please Select Omniclass");
            }
            function refreshpage() {

                window.parent.refreshgrid();
                var oWnd = GetRadWindow();
                oWnd.close();
            }


            function select_uniclass(id) {

                if (id == "") {
                    alert("Please select Category");
                    return false;
                }

            }




            function clear_txt() {

                return false;
            }
            //                        function stopPropagation(e) {
            //                            e.cancelBubble = true;

            //                            if (e.stopPropagation)
            //                                e.stopPropagation();
            //                        }

          //  window.onload = adjust_height;
        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
        *
        {
            margin: 0;
            padding: 0;
        }
        .style1
        {
            width: 1036px;
        }
    </style>
</head>
<body>
    <div style="background-position: white; background-color: #EEEEEE; padding: 10px;
        margin: 0px 0px 0px 0px;">
        <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" />
        <div>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                 <tr align="center">
                    <td align="right">
                        <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch1">
                            <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                <tr>
                                    <td align="left" class="entityImage">
                                        <asp:Label runat="server" Text="<%$Resources:Resource, Assign_category%>" ID="lbl_grid_head"
                                            CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Font-Names="Arial"
                                            Font-Size="12"></asp:Label>
                                    </td>
                                    <td align="right">
                                        <div id="div_search" style="background-color: White; width: 170px;">
                                            <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                width: 100%;">
                                                <tr style="border-spacing=0px;">
                                                    <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                        padding-bottom: 0px;">
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearchnew" Width="100%">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                        padding-bottom: 0px;">
                                                        <asp:ImageButton ClientIDMode="Static" OnClick="OnClick_BtnSearch1" ID="btnSearch1"
                                                            Height="13px" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td style="padding-right:10px;" >
                                       <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ID="img_arrow" />--%>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td height="1px" style="background-color: Orange; border-collapse: collapse; width: 100%">
                    </td>
                </tr>
                <tr >
                    <td>
                        <fieldset style="border-style: solid; margin: 0px; border-left-color: #DCDCDC; border-top-color: #DCDCDC;
                            border-top-width: 0px; border-left-width: 1px; border-bottom-width: 1px; border-right-width: 1px;
                            border-bottom-color: #A0A0A0; border-right-color: #B4B4B4;">
                            <telerik:RadGrid ID="rg_uniclass" runat="server" AllowPaging="True" AutoGenerateColumns="false"
                                AllowSorting="True" PagerStyle-AlwaysVisible="true" PageSize="10"
                                GridLines="None" OnItemCreated="rg_uniclass_ItemCreated" OnItemDataBound="rg_uniclass_ItemDataBound"
                                OnItemEvent="rg_uniclass_ItemEvent" OnPageIndexChanged="rg_uniclass_PageIndexChanged"
                                OnPageSizeChanged="rg_uniclass_PageSizeChanged" OnSortCommand="rg_uniclass_SortCommand" >
                                <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                <ClientSettings>
                                    <Selecting AllowRowSelect="true" />
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="280" />
                                </ClientSettings>
                                <MasterTableView ClientDataKeyNames="CategoryID,Category" DataKeyNames="CategoryID,Category">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="CategoryID" Visible="false">
                                            <ItemStyle CssClass="column" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridClientSelectColumn>
                                           <%-- <ItemStyle Width="10%" />
                                            <HeaderStyle Width="10%" />--%>
                                        </telerik:GridClientSelectColumn>
                                        <telerik:GridBoundColumn DataField="Category" SortExpression="Category" HeaderText="<%$Resources:Resource, Category%>">
                                            <HeaderStyle Width="90%" />
                                            <ItemStyle CssClass="column" Width="90%" HorizontalAlign="Left" />
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td style="height: 10px;">
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btn_assign_uniclass" runat="server" OnClick="btn_assign_uniclass_Click"
                            Text="<%$Resources:Resource, Assign_category%>" Width="100px" />
                        <asp:Button ID="btn_close" runat="server" Text="<%$Resources:Resource, Close%>" OnClientClick="javascript:return closeWindow();"
                            Width="70px" />
                        <asp:HiddenField ID="hfnames" runat="server" />
                        <asp:HiddenField ID="hfdscnt" runat="server" />
                        <asp:HiddenField ID="hfItems_id" runat="server" />
                        <asp:HiddenField ID="hf_parent_page" runat="server" />
                        <asp:HiddenField ID="hf_is_firsttime" runat="server" Value="" />
                        <asp:HiddenField ID="hf_OmniclassFlag1" runat="server" Value="" />
                    </td>
                </tr>
                <tr style="display: none">
                    <td>
                        <%--<asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, OmniClass_version%>"></asp:Label>
                    :--%><telerik:RadComboBox ID="ddlomniclass" AutoPostBack="true" Filter="Contains"
                        runat="server" AllowCustomText="false" OnSelectedIndexChanged="ddlomniclass_SelectedIndexChanged">
                        <Items>
                            <telerik:RadComboBoxItem Text="OmniClass 2006" Value="N" />
                            <telerik:RadComboBoxItem Text="OmniClass 2010" Value="Y" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
        </div>
        <telerik:RadAjaxManager ID="ram123" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rg_uniclass">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_uniclass" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btn_search">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_uniclass" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"
            Height="75px" Width="75px">
        </telerik:RadAjaxLoadingPanel>
    </div>
</body>
</html>
