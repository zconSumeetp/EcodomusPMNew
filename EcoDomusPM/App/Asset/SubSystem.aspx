<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="SubSystem.aspx.cs"
    Inherits="App_Asset_System" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="../UserControls/UCComboFacility.ascx" TagName="UserControlComboFacility"
    TagPrefix="uc1" %>
<html>
<head>
    <telerik:RadWindowManager Visible="true" ID="rad_window"  runat="server" VisibleTitlebar="true"  Title="Assign Classification" Behaviors="Close,Move" 
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" Width="600" Height="500" Title="<%$Resources:Resource, Assign_Subsystem%>"  ReloadOnShow="false"  AutoSize="false"
                VisibleStatusbar="false" VisibleOnPageLoad="false" BorderWidth="0px"  EnableShadow="true" BackColor="#EEEEEE">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <title>SubSystem</title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
   
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadCodeBlock ID="loadPopUp" runat="server">
        <script language="javascript" type="text/javascript">
            function RefreshParent() {
                var query = parent.location.search.substring(1);
                var flag = query.split("=");
                var reg = new RegExp(flag[1], 'g');
                var str = window.parent.location.href;
                str = str.replace(reg, document.getElementById('hfSubsystemId').value);
                window.parent.location.href = str;
            }
            function OpenAssignSubSystemWindow() {
                var url = "../Asset/AssignSubSystem.aspx?system_id=" + document.getElementById("hfSystemId").value;
                manager = $find("<%= rad_window.ClientID %>");
                var windows = manager.get_windows();
                
                windows[0].show();
                windows[0].setUrl(url);
               // window[0].moveTo(08, 22);
                //windows[0].set_modal(false);
                return false;
            }
            function checkSelectionForSystem() {

                var grid = $find("<%=rgSubSystems.ClientID %>");
                    var MasterTable = grid.get_masterTableView();
                    var selectedRows = MasterTable.get_selectedItems();
                    if (selectedRows.length > 0) {
                        return false ;
                    }
                    else {
                        alert('Please Select System');
                        return true; 
                    }
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
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

        </script>
    </telerik:RadCodeBlock>
    <script type="text/javascript" language="javascript">
        window.onload = body_load;
        function body_load() {
            document.getElementById("<%=txtcriteria.ClientID %>").focus();
            var screenhtg = parseInt(window.screen.height * 0.65);
            document.getElementById("divSelectedDomponentContent").style.height = screenhtg * 0.69;
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
        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {
            //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
            var pageSize = document.getElementById("hfDocumentPMPageSize").value;
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
    <style type="text/css">
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
       
    </style>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" style="margin: 0 0 0 0" defaultfocus="txtcriteria">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="360000">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <div style="width: 100%;">
     
            <table style="margin:0 0 0 0px; padding:0 0 0 0px; " align="left" width="100%">
                <tr>
                    <td class="centerAlign">
                        <table>
                            <tr>
                                <td>
                                    <asp:Button ID="btnAddSubSystems" runat="server" Text="<%$Resources:Resource, Assign_Subsystem%>"
                                        Width="100px" CausesValidation="false" OnClientClick="javascript:return OpenAssignSubSystemWindow();"
                                        Skin="Default" />
                                </td>
                                <td>
                                    <asp:Button ID="btnUnassignSubsystems" runat="server" Text="<%$Resources:Resource, Unassign_Subsystem%>"
                                        Width="140px" CausesValidation="false" Skin="Default" OnClick="btnUnassignSubsystems_Click" OnClientClick="javascript:checkSelectionForSystem();" UseSubmitBehavior="false"  />
                                </td>
                                <td>
                                    <%-- <telerik:RadButton ID="btnCancel" runat="server" Text="<%$Resources:Resource, Cancel%>" Width="50px" Skin="Hay"
                                    OnClick="btnCancel_Click" />--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="centerAlign">
                        <div class="rpbItemHeader">
                            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                                <tr>
                                    <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width: 50%;">
                                        <asp:Label runat="server" ID="lbl_grid_head" CssClass="gridHeadText" Width="200px"
                                            ForeColor="#F8F8F8" Font-Names="Arial" Text="<%$Resources:Resource, subsystem%>" Font-Size="12"></asp:Label>
                                    </td>
                                    <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                        onclick="stopPropagation(event)">
                                        <div id="div_search" style="width: 200px; background-color: white;" >
                                              <asp:Panel ID="panelSearch" runat="server">  
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="<%$Resources:Resource, Search%>" BorderColor="White" ID="txtcriteria" Width="180px">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ClientIDMode="Static" ID="btnsearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                            OnClick="btnsearch_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                            </asp:Panel>
                                        </div>
                                    </td>
                                    <td align="right" style="padding: 4px 6px 0 0;">
                                       <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div id="divSelectedDomponentContent">
                            <telerik:RadGrid ID="rgSubSystems" AllowMultiRowSelection="true" runat="server" AllowPaging="True"
                                OnItemCommand="rgSubSystems_ItemCommand" OnPageIndexChanged="btnsearch_Click"
                                OnPageSizeChanged="btnsearch_Click" OnSortCommand="btnsearch_Click" AutoGenerateColumns="false"
                                AllowSorting="True" Visible="true" PagerStyle-AlwaysVisible="true" Skin="Default" Width="100%"
                                OnItemDataBound="rgSubSystems_OnItemDataBound" BorderWidth="1px" PageSize="10" GridLines="None"
                                ItemStyle-Wrap="false">
                                <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                    <Selecting AllowRowSelect="true" />
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                              <ClientEvents OnGridCreated="GridCreated" />
                                </ClientSettings>
                                <MasterTableView DataKeyNames="SubsystemId">
                                    <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                              <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                              <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                              <FooterStyle Height="25px" Font-Names="Arial" />
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="SubsystemId" HeaderText="SubsystemId" UniqueName="SubsystemId"
                                            Visible="False" SortExpression="SubsystemId">
                                            <ItemStyle  Width="10%" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="SystemId" HeaderText="SystemId" UniqueName="SystemId"
                                            Visible="False" SortExpression="SystemId">
                                            <ItemStyle  Width="10%" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridClientSelectColumn>
                                            <ItemStyle Width="5%" />
                                            <HeaderStyle Width="5%" />
                                        </telerik:GridClientSelectColumn>
                                        <telerik:GridTemplateColumn DataField="SubsystemName" UniqueName="SubsystemName"
                                            HeaderText="<%$Resources:Resource, Subsystem_Name%>" SortExpression="SubsystemName">
                                            <HeaderStyle   Width="40%" Wrap="false" />
                                            <ItemStyle  Width="40%" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnSubsystemName" CommandName="SubsystemNameProfile" Text='<%# DataBinder.Eval(Container.DataItem,"SubsystemName")%>'
                                                    runat="server"></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="category" HeaderText="<%$Resources:Resource, Category%>"
                                            UniqueName="category" Visible="true" SortExpression="category">
                                            <ItemStyle  Width="40%" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="SubsystemDescription" HeaderText="<%$Resources:Resource, Description%>"
                                            UniqueName="SubsystemDescription" Visible="true" SortExpression="SubsystemDescription">
                                            <ItemStyle  Width="40%" Wrap="false" />
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
                        <asp:HiddenField ID="hfSubsystemId" runat="server" />
                        <asp:HiddenField ID="hfSystemId" runat="server" />
                        <asp:HiddenField ID="hfDocumentPMPageSize"  runat="server" Value="" />
                    </td>
                </tr>
            </table>
      
        <telerik:RadAjaxManager ID="radAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rgSubSystems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rgSubSystems" />
                        <telerik:AjaxUpdatedControl ControlID="hfSubsystemId" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnclear">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="txtcriteria" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnsearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="txtcriteria" />
                        <telerik:AjaxUpdatedControl ControlID="rgSubSystems" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnUnassignSubsystems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="txtcriteria" />
                        <telerik:AjaxUpdatedControl ControlID="rgSubSystems" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
            Height="75px" Width="75px">
        </telerik:RadAjaxLoadingPanel>
    </div>
    </form>
</body>
 <link href="../../App_Themes/EcoDomus/PopupStyleSheet.css" rel="stylesheet" type="text/css" />
</html>
