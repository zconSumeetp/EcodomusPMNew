<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Omniclass.ascx.cs" Inherits="App_Locations_Omniclass" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html><head>
<title>EcoDomus FM : Assign OmniClass</title>
 <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
 <%--<link href="../../App_Themes/EcoDomus/style.css" rel="stylesheet" type="text/css" />--%>
<script type="text/javascript" language="javascript">
    function setFocus() {


    }
    window.onload = setFocus;
</script> 
<telerik:RadCodeBlock ID="radcodeblock1" runat="server">
    <script type="text/javascript" language="javascript">

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function closeWindow_assign() {
            var rdw = GetRadWindow();
            rdw.close();
            window.parent.resizeParentPopupReversBack();
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
            //self.close();
        }

        function select_Sub_System(id, name) {

            var rdw = GetRadWindow();
            if (window.parent.location.href.indexOf('TypePM') == -1) {

                rdw.BrowserWindow.load_omni_class(name, id);

                //window.close();
            }
            //var rdw = GetRadWindow();
            window.parent.refreshgrid();
            rdw.close();
            window.parent.resizeParentPopupReversBack();
            //GetRadWindow().BrowserWindow.refreshGrid();

            //                window.opener.load_omni_class(name, id);
            //                self.close();
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
            alert("Please Select OmniClass");
        }
        function refreshpage() {

            window.parent.refreshgrid();
            var oWnd = GetRadWindow();
            oWnd.close();
            window.parent.resizeParentPopupReversBack();
        }
        function clear_txt() {

            return false;
        }
        function stopPropagation(e) {
            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }
        window.onload = adjust_height;
    </script>
</telerik:RadCodeBlock>
<style type="text/css">
    
    .style1
    {
        width: 1036px;
    }
    .divout
    {
       background-position: white; 
       background-color: #EEEEEE;
       margin:  0px 0px 0px 0px; 
       
    }
</style></head>
<body>
<div class="divout" >
 
   
    <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server"  DecoratedControls="Buttons,ScrollBars" />
    
        <div align="center" style="width:100%;" >
            <table width="95%" cellpadding="0" cellspacing="0" border="0" >
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
                              <asp:Panel ID="panelSearch" runat="server" DefaultButton="btn_search">
                        <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                            <tr>
                                <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                    <asp:Label runat="server" Text="<%$Resources:Resource, Assign_OmniClass%>" ID="lbl_grid_head"
                                        CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Font-Names="Arial"
                                        Font-Size="12"></asp:Label>
                                </td>
                                <td align="right" class="collapsRemove"  onclick="stopPropagation(event)">
                                    <div id="div_search"   style="background-color: White;
                                        width: 170px;">
                                        <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                            width: 100%;">
                                            <tr style="border-spacing=0px;">
                                                <td align="left" onclick="stopPropagation(event)"  width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                    padding-bottom: 0px;">
                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                        Height="100%" onclick="stopPropagation(event)" EmptyMessage="Search" BorderColor="White" ID="txt_search" Width="100%">
                                                    </telerik:RadTextBox  >
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
                         <telerik:RadGrid ID="rg_omniclass" runat="server" AllowPaging="True" AutoGenerateColumns="false"
                            AllowSorting="True" PagerStyle-AlwaysVisible="true" Width="100%" PageSize="10"
                            GridLines="None" OnItemDataBound="rg_omniclass_OnItemDataBound" OnSortCommand="rg_omniclass_OnSortCommand"
                            OnPageSizeChanged="rg_omniclass_OnPageSizeChanged" OnPageIndexChanged="rg_omniclass_OnPageSizeChanged"
                            OnItemEvent="rg_omniclass_OnItemEvent" OnItemCreated="rg_omniclass_ItemCreated" Skin="Default">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                            <ClientSettings>
                                <Selecting AllowRowSelect="true" />
                                <Scrolling AllowScroll="true" ScrollHeight="364" />
                            </ClientSettings>
                            <MasterTableView ClientDataKeyNames="CategoryID" DataKeyNames="CategoryID">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="CategoryID" Visible="false">
                                        <ItemStyle CssClass="column" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridClientSelectColumn>
                                        <ItemStyle Width="10%" />
                                        <HeaderStyle Width="10%" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridBoundColumn DataField="Category" SortExpression="Category" HeaderText="<%$Resources:Resource, Category%>">
                                        <HeaderStyle Width="90%" />
                                        <ItemStyle CssClass="column" Width="90%" />
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
                    <td style="height: 10px;">
                    </td>
                </tr>
                <tr>
                    <td align="left" style="" >
                        <telerik:RadButton ID="btnassignomniclass" runat="server" Text="<%$Resources:Resource, Assign_OmniClass%>"
                            OnClick="btn_select_click" />
                        <telerik:RadButton ID="btn_close" runat="server" Text="<%$Resources:Resource, Close%>"
                            OnClientClicked="closeWindow" Width="70px" />
                        <asp:HiddenField ID="hfnames" runat="server" />
                        <asp:HiddenField ID="hfdscnt" runat="server" />
                        <asp:HiddenField ID="hfItems_id" runat="server" />
                    
                    </td>
                </tr>
                <tr style="display: none;">
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
    
    <telerik:RadAjaxManager ID="ramSystem" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnassignomniclass">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_omniclass" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <%--   <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_omniclass" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
            <telerik:AjaxSetting AjaxControlID="rg_omniclass">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_omniclass" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="btn_search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_omniclass" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel  ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
</div>
</body>
</html>