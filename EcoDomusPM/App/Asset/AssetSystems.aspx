<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssetSystems.aspx.cs" Inherits="App.Asset.AssetSystems" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Systems</title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />

    <style type="text/css">
        .RadWindow_Default .rwCorner .rwTopLeft, .RadWindow_Default .rwTitlebar
        {
            width: 600px;
            height: 500px;
        }

        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }

        .rpbItemHeader
        {
            background-color: #808080;
        }

        .font-weight-bold
        {
            font-weight: bold;
        }
    </style>
</head>

<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" defaultfocus="txtcriteria">
        
        <telerik:RadCodeBlock ID="loadPopUp" runat="server">
            <script type="text/javascript" language="javascript">
                window.onload = body_load;

                function resize_Nice_Scroll() {
                    $(".divScroll").getNiceScroll().resize();
                }

                function body_load() {
                    document.getElementById("<%=txtcriteria.ClientID %>").focus();
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

                function delete_systems() {
                    var answer = confirm("Do you want to delete this System?")
                    return answer;
                }

                function Clear() {
                    try {
                        document.getElementById("txtcriteria").value = "";
                        return false;
                    }
                    catch (e) {
                        alert(e.message + "  " + e.Number);
                        return false;
                    }
                }

                function stopPropagation(e) {
                    e.cancelBubble = true;

                    if (e.stopPropagation)
                        e.stopPropagation();
                }

                function LogoutNavigation() {
                    var query = parent.location.href;
                    top.location.href(query);
                }
  
                function AssignSystem_popup() {
                    var url = "../Asset/AssignSystem.aspx";
                    manager = $find("<%= rad_window.ClientID %>");
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                }

                function gotoPage(id, pagename) {
                    if (pagename == "Systems") {
                        top.location.href = "SystemMenu.aspx?system_id=" + id;
                    }
                }

                function refreshgrid() {
                    document.getElementById("btn_refresh").click();
                }

                function unassignAsset() {
                    alert("Please select system to unassign");
                }

                function RadButtonUnassignAsset_OnClientClicking(sender, eventArgs) {
                    var selectedRowsCount = $find("<%=RadGridSystems.ClientID %>").get_masterTableView().get_selectedItems().length;
                    if (selectedRowsCount == 0) {
                        eventArgs.set_cancel(true);
                        alert("Please select system to unassign");
                    }
                }
            </script>
        </telerik:RadCodeBlock>
        
        <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />

        <telerik:RadScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="360000">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </telerik:RadScriptManager>
        <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    
        <div>
            <table border="0" style="width: 100%;table-layout:fixed;padding-left:20px;">
                <tr>
                    <td align="left" class="style1 centerAlign">
                        <telerik:RadButton ID="btnassignSystem" runat="server" Text="<%$Resources:Resource,Assign_System%>" OnClientClicked="AssignSystem_popup" AutoPostBack="False" />
                        <telerik:RadButton ID ="RadButtonUnassignAsset" runat ="server" Skin="Default" Text="<%$Resources:Resource,Unassign_System%>" OnClientClicking="RadButtonUnassignAsset_OnClientClicking" onclick="RadButtonUnassignAsset_Click" />
                        <asp:HiddenField ID="hfItems_id" runat="server" />
                        <asp:HiddenField ID="hfnames" runat="server" />
                        <asp:HiddenField ID="hfdscnt" runat="server" />
                        <div style="display:none;">
                            <asp:Button ID="btn_refresh" runat="server" OnClick="btn_refresh_Click" Style="display: none;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="centerAlign"  style="width:100%;">
                        <div class="rpbItemHeader">
                            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                                <tr>
                                    <td align="left" class="entityImage"  style="width: 50%;">
                                        <asp:Label runat="server" ID="lbl_grid_head" CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Text="<%$Resources:Resource, System%>" Font-Names="Arial" Font-Size="12" />
                                    </td>
                                    <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;">
                                        <div id="div_search" style="width: 200px; background-color: white;" >
                                            <asp:Panel ID="panelSearch" runat="server"> 
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server" Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtcriteria" Width="180px" />
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ClientIDMode="Static" ID="btnSearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnsearch_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </div>
                                    </td>
                                    <td align="right" style="padding: 4px 6px 0 0;">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="divSelectedDomponentContent" >
                            <telerik:RadGrid AllowMultiRowSelection="true" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="false" BorderWidth="1px" GridLines="None" 
                                             ID="RadGridSystems" ItemStyle-Wrap="false" OnItemCommand="RadGridSystems_ItemCommand" OnItemDataBound="RadGridSystems_OnItemDataBound" 
                                             OnPageIndexChanged="RadGridSystems_OnPageIndexChanged" OnPageSizeChanged="RadGridSystems_OnPageSizeChanged" 
                                             OnSortCommand="RadGridSystems_OnSortCommand" PagerStyle-AlwaysVisible="true" PageSize="10" runat="server" skin="Default">
                                <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                <ClientSettings>
                                    <Selecting AllowRowSelect="true" />
                                    <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                </ClientSettings>
                                <MasterTableView DataKeyNames="Id">
                                    <Columns>
                                        <telerik:GridClientSelectColumn Resizable="False">
                                            <ItemStyle Width="41px" HorizontalAlign="Center" CssClass="column" />
                                            <HeaderStyle Width="41px" HorizontalAlign="Center" />
                                        </telerik:GridClientSelectColumn>
                                        <telerik:GridTemplateColumn UniqueName="Name" HeaderText="<%$Resources:Resource, Name%>">
                                            <ItemTemplate>
                                                <telerik:RadButton runat="server" ButtonType="LinkButton" ID="RadButtonSystemLink" Text='<%# DataBinder.Eval(Container.DataItem, "Name")%>' AutoPostBack="False" 
                                                                   BorderStyle="None" ToolTip='<%# DataBinder.Eval(Container.DataItem, "Name")%>' style="text-decoration: underline" />                                            
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource, Description%>" UniqueName="description" SortExpression="description">
                                            <ItemStyle CssClass="column" Width="40%" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn UniqueName="IsMain" HeaderText="<%$Resources:Resource, Set_as_main%>">
                                            <ItemTemplate>
                                                <telerik:RadButton runat="server" ID="RadButtonSetAsMain" Text="<%$Resources:Resource, Set_as_main%>" ToolTip="<%$Resources:Resource, Set_as_main%>" OnClick="RadButtonSetAsMain_OnClick">
                                                    <%--<Image ImageUrl="~/App/Images/Icons/edit.gif" IsBackgroundImage="True" />--%>
                                                </telerik:RadButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="height:10px;">
                    </td>
                </tr>
            </table>
        </div>
    
        <telerik:RadWindowManager ID="rad_window" runat="server" BackColor="#EEEEEE" VisibleTitlebar="true" Title="<%$Resources:Resource,Assign_System%>" Behaviors="Close,Move" 
                                  BorderWidth="0px" Skin="Simple" BorderStyle="None">
            <Windows>
                <telerik:RadWindow AutoSize="false" BackColor="#EEEEEE" Height="450" ID="rd_profile_popup" maxWidth="600" Modal="true" orderWidth="0px" ReloadOnShow="True" runat="server" 
                                   Top="10" VisibleOnPageLoad="false" Width="520" />
            </Windows>
        </telerik:RadWindowManager>

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnsearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadGridSystems" LoadingPanelID="loadingPanel1" />
                   </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadGridSystems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadGridSystems" LoadingPanelID="loadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
    
        <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px" Skin="Default" />
    </form>
</body>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
    <style type="text/css">
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
