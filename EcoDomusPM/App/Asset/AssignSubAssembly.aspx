<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignSubAssembly.aspx.cs" Inherits="App_Asset_AssignSubAssembly" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>

<head>
<%--<title>Assign Sub assembly </title>--%>
    <script type="text/javascript" language="javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function closeWindow() {
            var rdw = GetRadWindow();
            //rdw.BrowserWindow.refreshGrid();
            rdw.close();
        }
        function refreshParent() {

            window.parent.refreshgrid();
            var rdw = GetRadWindow();
            rdw.close();
        } 
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
        function Assign_SubAssembly()
        {
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

        function delete_() {
            var flag;
            flag = confirm("Do you want to delete this document?");
            return flag;
        }

        function regreshgrid() {
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
        


    </script>
        <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
<%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
     <telerik:RadCodeBlock ID="radcodeblock2" runat="server">

        <script language="javascript" type="text/javascript">


            function clear_txt() {
                document.getElementById("txt_search").value = "";
                return false;
            }
    
        </script>

    </telerik:RadCodeBlock>
</head>
<body style="background-color:#EEEEEE; padding: 0px;margin:0px;">
   
    <form id="form1" runat="server" defaultfocus="txt_search">
      <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="issueProfilesManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btn_search">
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
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <telerik:RadFormDecorator ID="RadFormDecorator1" DecoratedControls="Buttons,Scrollbars" Skin="Default"
            runat="server" />
          <table width="100%" cellpadding="0" cellspacing="0" border="0">
                
                <tr>
                    <td class="centerAlign" style="padding:10px;">
                     <div class="rpbItemHeader">
                        <table border="0" width="100%" style="" cellpadding="0" cellspacing="0">
                            <tr align="center">
                                <td align="right">
                                    <asp:Panel ID="panel1" runat="server" DefaultButton="btn_search">
                                        <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                            <tr>
                                                <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                    <asp:Label runat="server" Text="<%$Resources:Resource, Select_Entity%>" ID="lbl_grid_head"
                                                        CssClass="gridHeadText" Width="204px" ForeColor="#F8F8F8" Font-Names="Arial"
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
                                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txt_search" Width="100%">
                                                                    </telerik:RadTextBox>
                                                                </td>
                                                                <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                                    padding-bottom: 0px;">
                                                                    <asp:ImageButton ClientIDMode="Static" ID="btn_search" Height="14px"
                                                                        runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btn_Search" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                                <td align="right" style="padding-right:10px;" class="dropDownImage">
                                                   <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                        ID="img_arrow" />--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        </div>
                        
                        <div id="divSelectedDomponentContent">
                            <telerik:RadGrid ID="rg_subassembly" runat="server" AllowPaging="true" PageSize="10"
                                AutoGenerateColumns="false" Visible="true" AllowSorting="true" PagerStyle-AlwaysVisible="true"
                                OnItemCommand="rg_subassembly_ItemCommand" Skin="Default" BorderWidth="1px" OnSortCommand="rg_subassembly_OnSortCommand"
                                OnPageIndexChanged="rg_subassembly_OnPageIndexChanged" OnPageSizeChanged="rg_subassembly_OnPageSizeChanged"
                                ItemStyle-Wrap="false" AllowMultiRowSelection="true">
                                <ClientSettings>
                                    <Selecting AllowRowSelect="true" />
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="282px" />
                                </ClientSettings> 
                                <MasterTableView DataKeyNames="pk_asset_id" ClientDataKeyNames="pk_asset_id">
                                    <Columns>
                                        <telerik:GridClientSelectColumn>
                                            <ItemStyle Width="10%" CssClass="column" />
                                            <HeaderStyle Width="10%" />
                                        </telerik:GridClientSelectColumn>
                                        <telerik:GridBoundColumn DataField="pk_asset_id" HeaderText="ID" Visible="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="asset_name" HeaderText="<%$Resources:Resource, Component_Name%>"
                                            SortExpression="asset_name">
                                            <ItemStyle CssClass="column" Wrap="false" Width="50%" />
                                            <HeaderStyle CssClass="column" Wrap="false" Width="50%" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="asset_description" UniqueName="Description" HeaderText="<%$Resources:Resource, Description%>">
                                            <ItemStyle CssClass="column" Width="30%" Wrap="false" />
                                            <HeaderStyle CssClass="column" Width="30%" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                     </td>
                </tr>
             <tr>
            <td style="padding-left:10px;">
                <asp:Button ID="btn_Assign_Sub_Assembly"  Width="120px" runat="server" Text="<%$Resources:Resource, Assign_SubAssembly%>" OnClientClick="javascript:return Assign_SubAssembly()" 
                    onclick="btn_Assign_Sub_Assembly_Click"/> &nbsp;&nbsp;
                 <asp:Button ID="btn_Close"  Width="120px" runat="server" Text="<%$Resources:Resource, Close%>" OnClientClick="javascript:return closeWindow()" />             
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfAsset_id" runat="server" />
                <asp:HiddenField ID="hfrow_ids" runat="server" />
            </td>
        </tr>

    </table>
    </div>
    </asp:Panel>
      <div id="divbtn" style="display:none;">
       <asp:Button ID="btn_refresh"  runat="server" Style="display:none;"   OnClick="btn_refresh_Click" />
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
        </AjaxSettings>
   </telerik:RadAjaxManager>
    
       <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px" Skin="Forest">
      
    </telerik:RadAjaxLoadingPanel>


    
    </form>
</body>
</html>
