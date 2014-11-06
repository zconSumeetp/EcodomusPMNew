<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SubAssembly.aspx.cs" Inherits="App_Asset_SubAssembly" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head >
    <title>Assign Sub assembly</title>
    <script type="text/javascript" language="javascript"> 
        function gotoPage(id, pagename) {
            var url;

            if (pagename == "Asset") {
                url = "AssetMenu.aspx?assetid=" + id; //+ //"&pagevalue=AssetProfile";
            }
            else if (pagename == "Type") {
                url = "TypeProfileMenu.aspx?type_id=" + id;
                //alert("Page Under Construction");
                //return false;
            }
            else if (pagename == "Space") {
                url = "../Locations/FacilityMenu.aspx?pagevalue=Space Profile&id=" + id;
            }

            top.location.href(url);
        }

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }

        function load_popup(reg) {
            var url = "AssignSubAssembly.aspx?asset_id=" + document.getElementById("hfAsset_id").value + "&facility_id=" + document.getElementById("hfFacility_id").value;
            manager = $find("<%= rad_window.ClientID %>");
            var windows = manager.get_windows();
            windows[0].show();
            windows[0].setUrl(url);

            windows[0].set_modal(false);
            var obj = parent.window.frames[1];
            if (obj != null) {

                window.parent.resize_iframe(parent.window.frames[1]);

            }

            return false;
        }

        function resize_frame_page() {
            //window.resizeTo(1000, height);

            var docHeight;
            try {
                var obj = parent.window.frames[1];
                if (obj != null) {

                    window.parent.resize_iframe(parent.window.frames[1]);

                }
            }
            catch (e) {
                window.status = 'Error: ' + e.number + '; ' + e.description;
            }

        }

        function Unassign_SubAssembly() {
            var s1 = $find("rg_subassembly");
            var MasterTable = s1.get_masterTableView();
            var selectedRows = MasterTable.get_selectedItems();
            var s = "";

            for (var i = 0; i < selectedRows.length; i++) {
                s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("pk_asset_id") + ",";
            }

            if (s == "") {
                alert("Please select component");
                return false;
            }
            else {
                document.getElementById("hfrow_ids").value = s;
                return true;
            }

        }

        function refreshgrid() {
            document.getElementById("btn_refresh").click();
        }

        function fn_Clear() {
            try {
                document.getElementById("txt_search").value = "";
                return false;
            }
            catch (e) {
                alert(e.message + "  " + e.Number);
                return false;
            }
        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }
        function resize_frame_page() {
            //window.resizeTo(1000, height);

            var docHeight;
            try {
                var obj = parent.window.frames[1];
                if (obj != null) {

                    window.parent.resize_iframe(parent.window.frames[1]);

                }
            }
            catch (e) {
                window.status = 'Error: ' + e.number + '; ' + e.description;
            }

        }


    </script>
    <script type="text/javascript" language="javascript">
        //window.onload = body_load;

        function resize_Nice_Scroll() {

            $(".divScroll").getNiceScroll().resize();
        }

        function body_load() {

            $("html").css('overflow-y', 'hidden');
            $("html").css('overflow-x', 'auto');
            var screenhtg = parseInt(window.screen.height * 0.65);
            document.getElementById("divSelectedDomponentContent").style.height = screenhtg * 0.61;
            $(".divScroll").niceScroll({ touchbehavior: false, cursorcolor: "#969696", cursoropacitymax: 0.8, cursorborder: "none", cursorwidth: 08, background: "#cccccc", overflow: "hidden" });
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
        }   

</script>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <style type="text/css">
        .RadWindow_Default .rwCorner .rwTopLeft, .RadWindow_Default .rwTitlebar
        {
            width: 600px;
            height: 200px;
        }
        
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
        html
        {
            overflow-y: hidden;
            overflow-x: Auto;
        }
    </style>
</head>

<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG');padding: 0px">
    <form id="form1" runat="server" defaultfocus="txt_search">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="360000">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <asp:Panel ID="panelSearch" runat="server">
     <telerik:RadFormDecorator ID="RadFormDecorator" runat="server" Skin="Default" DecoratedControls="Buttons" />
        <table style="table-layout:fixed; width: 100%" align="left" border="0">
           <tr>
                <td class="centerAlign">
                    <asp:Button ID="btn_Assign_Sub_Assembly" Width="120px" runat="server" Text="<%$Resources:Resource, Assign_SubAssembly%>"
                        OnClientClick="javascript:return load_popup()" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btn_Unassign" Width="160px" runat="server" Text="<%$Resources:Resource, Unassign_SubAssembly%>"
                        OnClientClick="javascript:return Unassign_SubAssembly()" OnClick="btn_Unassign_Click" />
                </td>
            </tr>
            <tr>
                <td class="centerAlign">
                    <div class="rpbItemHeader">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                            <tr>
                                <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width: 50%;">
                                    <asp:Label runat="server" ID="lbl_grid_head" CssClass="gridHeadText" Width="200px"
                                        ForeColor="#F8F8F8" Text="<%$Resources:Resource,SubAssembly%>" Font-Names="Arial" Font-Size="12"></asp:Label>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                    onclick="stopPropagation(event)">
                                    <div id="div_search" style="width: 200px; background-color: white;" onclick="stopPropagation(event)">
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txt_search" Width="180px">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ClientIDMode="Static" ID="btn_search" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                        OnClick="btn_Search" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td align="right" style="padding: 4px 6px 0 0;">
                                   <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                        ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContent" >
                        <telerik:RadGrid ID="rg_subassembly" runat="server" AllowPaging="true" PageSize="10" BorderWidth="1px"
                            AutoGenerateColumns="false" Visible="true" AllowSorting="true" PagerStyle-AlwaysVisible="true"
                            Width="100%" OnItemCommand="rg_subassembly_ItemCommand" Skin="Default" OnSortCommand="rg_subassembly_OnSortCommand"
                            OnPageIndexChanged="rg_subassembly_OnPageIndexChanged" OnPageSizeChanged="rg_subassembly_OnPageSizeChanged"
                            ItemStyle-Wrap="false" AllowMultiRowSelection="true">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" AlwaysVisible="true" />
                            <ClientSettings>
                                <Selecting AllowRowSelect="true" />
                                <Resizing AllowColumnResize="false" AllowRowResize="false" ResizeGridOnColumnResize="false"     ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                            </ClientSettings>
                            <MasterTableView DataKeyNames="pk_asset_id" ClientDataKeyNames="pk_asset_id">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="pk_asset_id" HeaderText="ID" Visible="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridClientSelectColumn UniqueName="chkSelect">
                                        <ItemStyle Width="1px" Wrap="false" />
                                        <HeaderStyle Width="1px" Wrap="false" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridBoundColumn DataField="linkasset" HeaderText="<%$Resources:Resource, Component_Name%>"
                                        SortExpression="linkasset">
                                        <ItemStyle CssClass="column1" Width="50%" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="asset_description" UniqueName="Description" HeaderText="<%$Resources:Resource, Description%>">
                                        <ItemStyle CssClass="column1" Width="50%" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid> 
                    </div>
                </td>
            </tr>
            <tr>
                <td style="height: 10px"> 
                </td>
            </tr>
            
            <tr>
                <td>
                    <asp:HiddenField ID="hfAsset_id" runat="server" />
                    <asp:HiddenField ID="hfEntity" runat="server" />
                    <asp:HiddenField ID="hfrow_ids" runat="server" />
                    <asp:HiddenField ID="hfFacility_id" runat="server" />
                </td>
            </tr>
            <telerik:RadWindowManager Visible="true" ID="rad_window" runat="server" BackColor="#EEEEEE" VisibleTitlebar="true" Title="<%$Resources:Resource,Assign_SubAssembly%>" Behaviors="Close,Move" 
            BorderWidth="0px"  Skin="Simple" BorderStyle="None">
                <Windows>
                    <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" 
                        Width="600" Height="450"  BorderWidth="0px" Top="10"  Modal="true" 
                         ReloadOnShow="True"  VisibleOnPageLoad="false"  
                             BackColor="#EEEEEE">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
        </table>
    </asp:Panel>
    <div id="divbtn" style="display: none;">
        <asp:Button ID="btn_refresh" runat="server" Style="display: none;" OnClick="btn_refresh_Click" />
    </div>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_subassembly">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_subassembly" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_subassembly" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_refresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_subassembly" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
<style>
     .RadWindow_Simple
        {
            border: solid 0px #616161;
        }
        .rwWindowContent
        {
            background-color:#EEEEEE;
        }
</style>
</html>
