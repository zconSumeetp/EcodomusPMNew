<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignSubSystem.aspx.cs" Inherits="App_omniclasslinkup" EnableEventValidation="false" %>

    <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
 <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <title></title>

    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
    <script type="text/javascript" language="javascript">

        function setFocus() {
            //                document.getElementById("<%=txtSearch.ClientID %>").focus();

        }
        window.onload = setFocus;

        function stopPropagation(e) {
            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }
        function setBlur() {
            if (document.getElementById("<%=txtSearch.ClientID %>") != null)
                document.getElementById("<%=txtSearch.ClientID %>").blur();

        }
        window.onblur = setBlur;




        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function closeWindow_assign() {
            document.getElementById("<%=txtSearch.ClientID %>").blur();
            var rdw = GetRadWindow();
            rdw.close();

        }

        function closeWindow() {
            setBlur();
            document.getElementById("<%=txtSearch.ClientID %>").blur();
            var rdw = GetRadWindow();
            rdw.close();

        }

        function RefreshSubsystem(id, name) {

            var rdw = GetRadWindow();
            rdw.BrowserWindow.document.getElementById('btnsearch').click();

            rdw.close();
        }

        function assignSubsystem() {
            alert("Please Select Subsystem");
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
</head>
<body style="background-position: white; background: #EEEEEE; padding: 0px; margin: 0px 0px 0px 0px;background-color: #EEEEEE; ">
    <telerik:RadCodeBlock ID="radcodeblock2" runat="server">

        <script language="javascript" type="text/javascript">


            function clear_txt() {
                document.getElementById("txtSearch").value = "";
                return false;
            }
    
        </script>

    </telerik:RadCodeBlock>
    <form id="form1" runat="server" defaultfocus="txtSearch">
      <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="issueProfilesManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_asset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="rg_asset">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_asset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <telerik:RadFormDecorator ID="RadFormDecorator1" DecoratedControls="Buttons,Scrollbars" Skin="Default"
            runat="server" />
        
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td class="centerAlign" style="width: 100%;padding:10px;">
                    <div class="rpbItemHeader">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;height:30px; ">
                            <tr>
                                <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width: 50%;">
                                    <asp:Label runat="server" ID="lbl_grid_head" CssClass="gridHeadText" Width="200px"
                                        ForeColor="#F8F8F8" Font-Names="Arial" Text="<%$Resources:Resource,Select_Subsystems%>" Font-Size="12"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:Panel ID="panel1" runat="server" DefaultButton="btnSearch">
                                        <div id="div_search" style="background-color: White; width: 180px;">
                                            <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                width: 100%;">
                                                <tr style="border-spacing=0px;">
                                                    <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                        padding-bottom: 0px;">
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="<%$Resources:Resource,Search%>" BorderColor="White" ID="txtSearch" Width="100%">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                        padding-bottom: 0px;">
                                                        <asp:ImageButton ClientIDMode="Static" OnClick="btnSearch_OnClick" ID="btnSearch"
                                                            Height="100%" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </asp:Panel>
                                </td>
                                <td align="right" style="padding: 4px 6px 0 0;">
                                    <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContent">
                        <telerik:RadGrid ID="rgSubSystems" runat="server" AllowPaging="True" AutoGenerateColumns="false"
                            AllowSorting="True" PagerStyle-AlwaysVisible="true" BorderWidth="1px" PageSize="10"
                            GridLines="None" OnSortCommand="btnSearch_OnClick" OnPageSizeChanged="btnSearch_OnClick"
                            OnPageIndexChanged="btnSearch_OnClick" AllowMultiRowSelection="true" Skin="Default">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                            <ClientSettings>
                                <Selecting AllowRowSelect="true" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="280px" />
                            </ClientSettings>
                            <MasterTableView ClientDataKeyNames="SystemId" DataKeyNames="SystemId">
                                <ItemStyle Width="100%" />
                                <HeaderStyle Width="100%" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="SystemId" Visible="false">
                                        
                                    </telerik:GridBoundColumn>
                                    <telerik:GridClientSelectColumn>
                                        <ItemStyle Width="20px" />
                                        <HeaderStyle Width="20px" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridBoundColumn DataField="SystemName" HeaderText="<%$Resources:Resource,System_Name%>">
                                         <ItemStyle Width="300px" />
                                        <HeaderStyle Width="300px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SystemDescription" HeaderText="<%$Resources:Resource,Description%>">
                                       <ItemStyle Width="200px" />
                                        <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="centerAlign" align="left">
                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="btnAssignSubsystems" runat="server" Text="<%$Resources:Resource,Assign_Subsystem%>"
                                    OnClick="btnAssignSubsystems_click" />
                            </td>
                            <td>
                                <asp:Button ID="btn_close" runat="server" Text="<%$Resources:Resource,Close%>" OnClientClick="javascript:closeWindow();"
                                    Width="70px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:HiddenField ID="hfItems_id" runat="server" />
                            </td>
                            <td>
                                <asp:HiddenField ID="hfnames" runat="server" />
                            </td>
                            <td>
                                <asp:HiddenField ID="hfdscnt" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>   
     </div>
    <telerik:RadAjaxManager ID="ramSystem" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnAssignSubsystems">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgSubSystems" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgSubSystems" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txtSearch" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgSubSystems">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgSubSystems" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
