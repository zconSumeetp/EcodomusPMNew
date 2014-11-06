<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Contractor.ascx.cs" Inherits="App_Locations_Contractor" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<title>EcoDomus FM : Assign Contractor</title>
<telerik:RadCodeBlock ID="radcodeblock1" runat="server">
    <script type="text/javascript" language="javascript">
        function setFocus() {
            document.getElementById("<%=txtSearch.ClientID %>").focus();

        }

        // window.onload = setFocus;
    </script>
    <script type="text/javascript" language="javascript">

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        function select_Contractor(id, name) {

            var rdw = GetRadWindow();
            if (window.parent.location.href.indexOf('TypePM') == -1) {
                parent.document.getElementById('hfContractorId').value = id;
                parent.document.getElementById('hfContractorName').value = name;
                parent.document.getElementById('lblContractor').innerHTML = name;

                // rdw.BrowserWindow.load_omni_class(name, id);

                //window.close();
            }
            //var rdw = GetRadWindow();
            rdw.close();
            window.parent.resizeParentPopupReversBack();
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
//            var rdw = GetRadWindow();
//            rdw.close();
            //self.close();
            GetRadWindow().close();
            window.parent.resizeParentPopupReversBack();
            return false;
        }

        function select_Sub_System(id, name) {

            var rdw = GetRadWindow();
            if (window.parent.location.href.indexOf('TypePM') == -1) {

                rdw.BrowserWindow.load_omni_class(name, id);

                //window.close();
            }
            //var rdw = GetRadWindow();
            rdw.close();
        }

        function resizePopup() {
          
           // window.parent.resizeParentPopupReversBack();
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

            alert("Please Select Contractor");
        }
        function refreshpage() {

            window.parent.refreshgrid();
            var oWnd = GetRadWindow();
            oWnd.close();
            window.parent.resizeParentPopupReversBack();
        }
        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }
        window.onload = adjust_height;
    </script>
</telerik:RadCodeBlock>
<telerik:RadCodeBlock ID="radcodeblock2" runat="server">
    <script language="javascript" type="text/javascript">
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }

        function clear_txt() {
            document.getElementById("<%=txtSearch.ClientID%>").value = "";
            return false;
        }

        function stopProContractor(e) {
            adjust_height_contractor();

        }
        var back = "";
        function adjust_height_contractor() {

            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                if (back == "") {
                    wnd.set_height(document.body.scrollHeight - 280)
                    back = "1";
                }
                else {

                    wnd.set_height(document.body.scrollHeight + 390)
                    back = "";
                }
                //  wnd.set_width(document.body.scrollWidth )
            }

        }
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
<link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
<div style="background-position: white; background: #EEEEEE; padding: 0px; margin: 0px 20px 0px 0px;"
    align="center" width="100%">

    <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" Skin="Default" DecoratedControls="Buttons,ScrollBars" />
    <div style="padding-left: 12px;" align="center">
        <table width="95%" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;">
            <tr>
                <td height="05px">
                </td>
            </tr>
            <tr align="center">
                <td align="right">
                <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" BorderWidth="0" 
                        ExpandMode="MultipleExpandedItems" BorderColor="Transparent">
                        <ExpandAnimation Type="OutSine" />
                        <Items>
                            <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                                BorderWidth="0" BorderColor="Transparent">
                                <HeaderTemplate>
                                <asp:Panel ID="pnl_job" runat="server" DefaultButton="btnSearch" BorderWidth="0"
                        Width="100%" BorderColor="Transparent">
                        <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                            <tr>
                                <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                    <asp:Label runat="server" Text="<%$Resources:Resource, Assign_Contractor%>" ID="lbl_grid_head"
                                        CssClass="gridHeadText" Width="70%" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                </td>
                                <td class="collapsRemove" align="right" onclick="stopPropagation(event)" >
                                    <div id="div_search" style="background-color: White; width: 170px;">
                                        <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                            width: 100%;">
                                            <tr style="border-spacing=0px;">
                                                <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                    padding-bottom: 0px;">
                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="100%">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                    padding-bottom: 0px;">
                                                    <asp:ImageButton ClientIDMode="Static" OnClick="btnSearch_OnClick" ID="btnSearch"
                                                        Height="13px" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                    <td align="center" class="dropDownImage" >
                                    <asp:Image runat="server" Visible="false" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
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
                                <telerik:RadGrid ID="rg_contractor" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="false" GridLines="None" OnItemCreated="rg_contractor_ItemCreated"
                        OnItemDataBound="rg_contractor_OnItemDataBound" OnPageIndexChanged="rg_contractor_PageIndexChanged"
                        OnPageSizeChanged="rg_contractor_PageSizeChanged" OnSortCommand="rg_contractor_SortCommand"
                        PagerStyle-AlwaysVisible="true" PageSize="10" Skin="Default" Width="100%">
                        <PagerStyle HorizontalAlign="Right" Mode="NextPrevAndNumeric" />
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                        </ClientSettings>
                        <MasterTableView ClientDataKeyNames="pk_organization_id" DataKeyNames="pk_organization_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_organization_id" Visible="false">
                                    <ItemStyle CssClass="column" />
                                </telerik:GridBoundColumn>
                                <telerik:GridClientSelectColumn>
                                    <ItemStyle Width="5%" />
                                    <HeaderStyle Width="5%" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="OrganizationName" HeaderText="<%$Resources:Resource, Organization_Name%>"
                                    SortExpression="OrganizationName">
                                    <ItemStyle CssClass="column" Width="90%" Wrap="false" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                        <ClientSettings>
                            <Scrolling AllowScroll="True" ScrollHeight="343px"></Scrolling>
                        </ClientSettings>
                    </telerik:RadGrid>
                                </ContentTemplate>
                    </telerik:RadPanelItem>
                   
                   </Items>
                   </telerik:RadPanelBar>
                </td>
            </tr>
           
            <tr>
                <td align="center">
                    
                </td>
            </tr>
            <tr>
                <td style="height: 10px;">
                </td>
            </tr>
            <tr>
                <td align="left" class="style1">
                    <asp:Button ID="btnassigncontractor" runat="server" OnClick="btn_select_click" Text="<%$Resources:Resource, Assign%>"
                        Width="70px" />
                    <asp:HiddenField ID="hfItems_id" runat="server" />
                    <asp:Button ID="btn_close" runat="server" OnClientClick="javascript:return closeWindow();"
                        Text="<%$Resources:Resource, Close%>" Width="70px" />
                    <asp:Button ID="btnAddDesigner" runat="server" OnClick="btnAdd_Contractor_Click1" OnClientClick="resizePopup();"
                        TabIndex="4" Text="<%$Resources:Resource,Add_Contractor%>" Width="120px" />
                    <asp:HiddenField ID="hfnames" runat="server" />
                    <asp:HiddenField ID="hfdscnt" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadAjaxManager ID="ramSystem" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnassigncontractor">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_contractor" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_contractor" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnclear">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtSearch" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rg_contractor">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_contractor" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <%--<telerik:RadAjaxLoadingPanel Skin="Forest" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">--%>
    <%-- </telerik:RadAjaxLoadingPanel>--%>
</div>
