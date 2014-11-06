<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Designer.ascx.cs" Inherits="App_Locations_Designer" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<title>EcoDomus FM : Assign Designer</title>
<script type="text/javascript" language="javascript">
       
</script>
<telerik:RadCodeBlock ID="radcodeblock1" runat="server">
    <script type="text/javascript" language="javascript">

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function resizePopup() {

            // window.parent.resizeParentPopupReversBack();
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

            window.parent.resizeParentPopupReversBack();
            return false;
            //self.close();
        }


        function select_Contractor(id, name) {

            var rdw = GetRadWindow();
            if (window.parent.location.href.indexOf('TypePM') == -1) {
                parent.document.getElementById('hfContractorId').value = id;
                parent.document.getElementById('hfContractorName').value = name;
                parent.document.getElementById('lblContractor').innerHTML = name;

                //rdw.BrowserWindow.load_omni_class(name, id);

                //window.close();
            }
            //var rdw = GetRadWindow();
            window.parent.refreshgrid();
            rdw.close();
        }
        function select_Designer(id, name) {

            var rdw = GetRadWindow();
            if (window.parent.location.href.indexOf('TypePM') == -1) {
                parent.document.getElementById('hfDesignerId').value = id;
                parent.document.getElementById('hfDesignerName').value = name;
                parent.document.getElementById('lblDesigner').innerHTML = name;

                // rdw.BrowserWindow.load_omni_class(name, id);

                //window.close();
            }
            //var rdw = GetRadWindow();
            window.parent.refreshgrid();

            rdw.close();
            window.parent.resizeParentPopupReversBack();
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

        function assigncontractor() {
            alert("Please Select Contractor");
        }
        function assigndesigner() {

            alert("Please Select Designer");
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

                    wnd.set_height(document.body.scrollHeight + 380)
                    back = "";
                }
                //  wnd.set_width(document.body.scrollWidth )
            }

        }
        function stopPro(e) {
            adjust_height_width();

        }
        var previous = "";
        function adjust_height_width() {


            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                if (previous == "") {
                    wnd.set_height(document.body.scrollHeight - 260)
                    previous = "1";
                }
                else {

                    wnd.set_height(document.body.scrollHeight + 400)
                    previous = "";
                }
                //  wnd.set_width(document.body.scrollWidth )
            }

        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }
        window.onload = adjust_height;
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
<style type="text/css">
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
      HTML
            {
                overflow: hidden;
                           
            }
            .div_outer  
            {
                overflow:hidden;
                border:1; 
                height:500px; 
                border-style:solid; 
                border-width:1px;  
                border-color: #808080;
            }
            
    </style>
    <%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
   
<div style="background-position: white; background: #EEEEEE; padding: 0px; margin: 0px 0px 0px 0px;">
   
    <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" Skin="Default" DecoratedControls="Buttons,ScrollBars" />
    <div style="padding-left: 0px;" align="center">
        <table width="95%" border="0" style="background-color: #EEEEEE; border-collapse: collapse;"
            cellpadding="0" cellspacing="0">
            
            <tr align="center">
                <td>
                    

                    <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="99%" BorderWidth="0" 
                        ExpandMode="MultipleExpandedItems" BorderColor="Transparent">
                        <ExpandAnimation Type="OutSine" />
                        <Items>
                            <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                                BorderWidth="0" BorderColor="Transparent">
                                <HeaderTemplate>
                                    <asp:Panel ID="pnl_job" runat="server" DefaultButton="btn_search" BorderWidth="0"
                                        Width="100%" BorderColor="Transparent">
                                        <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                            <tr>
                                                <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                    <asp:Label runat="server" Text="<%$Resources:Resource, Assign_Designer%>" ID="lbl_grid_head" CssClass="gridHeadText"
                                                        Width="70%" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                                </td>
                                                <td class="collapsRemove" align="right" onclick="stopPropagation(event)" >
                                                    <div id="div_search" style="background-color: White; width: 170px;" onclick="stopPropagation(event)">
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
                                                                    <asp:ImageButton ClientIDMode="Static" OnClick="OnClick_BtnSearch" ID="btn_search"
                                                                        Height="13px" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                                <td align="center" class="dropDownImage">
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
                                    <telerik:RadGrid ID="rg_designer" runat="server" AllowPaging="True" AutoGenerateColumns="false"
                                        AllowSorting="True" PagerStyle-AlwaysVisible="true" Width="100%" PageSize="10"
                                        GridLines="None" OnItemDataBound="rg_designer_OnItemDataBound" OnSortCommand="rg_designer_OnSortCommand"
                                        OnPageSizeChanged="rg_designer_OnPageSizeChanged" OnPageIndexChanged="rg_designer_PageIndexChanged"
                                        OnItemCreated="rg_designer_ItemCreated" Skin="Default">
                                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" PageButtonCount="5" />
                                        <ClientSettings>
                                            <Selecting AllowRowSelect="true" />
                                            <Scrolling AllowScroll="true" UseStaticHeaders="false"   />
                                        </ClientSettings>
                                        <MasterTableView ClientDataKeyNames="pk_organization_id" DataKeyNames="pk_organization_id">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="pk_organization_id" Visible="false">
                                                    <ItemStyle CssClass="column" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridClientSelectColumn>
                                                    <ItemStyle Width="5%" />
                                                    <HeaderStyle Width="5%"  />
                                                </telerik:GridClientSelectColumn>
                                                <telerik:GridBoundColumn DataField="OrganizationName" SortExpression="OrganizationName"
                                                    HeaderText="<%$Resources:Resource, Organization_Name%>">
                                                    <ItemStyle CssClass="column" Width="70%" Wrap="false"   />
                                                    <HeaderStyle CssClass="column" Width="70%" Wrap="false"   />
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True"  ScrollHeight="342px" ></Scrolling>
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                    
                                </ContentTemplate>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:RadPanelBar>

                </td>
            </tr>
            <tr>
                <td style="height: 10px;">
                </td>
            </tr>
            <tr>
                <td align="left" class="style1">
                    <asp:Button ID="btnassigndesigner" runat="server" Text="<%$Resources:Resource, Assign%>"
                        OnClick="btn_select_click" Width="70px" />
                    <asp:HiddenField ID="hfItems_id" runat="server" />
                    <asp:Button ID="btn_close" runat="server" Text="<%$Resources:Resource, Close%>" OnClientClick="javascript:return closeWindow();"
                        Width="70px" />
                    <asp:Button ID="btnAddDesigner" runat="server" Text="<%$Resources:Resource,Add_Designer%>" OnClientClick="resizePopup();"
                        Width="120px" TabIndex="4" OnClick="btnAdd_Designer_Click1" />
                    <asp:HiddenField ID="hfnames" runat="server" />
                    <asp:HiddenField ID="hfdscnt" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadAjaxManager ID="ramSystem" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnassigndesigner">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_designer" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_designer" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting> 
            <telerik:AjaxSetting AjaxControlID="rg_designer">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_designer" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
</div>
