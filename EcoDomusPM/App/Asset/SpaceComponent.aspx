<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SpaceComponent.aspx.cs" Inherits="SpaceComponent" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Component</title>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript"> 

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

            function gotoPage(id, pagename) {
                var url;
                if (pagename == "Asset") {
                    url = "AssetMenu.aspx?assetid=" + id; //  + "&pagevalue=AssetProfile";
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

            function OnClientDropDownClosing(sender, eventArgs) {
                eventArgs.set_cancel(false);
            }

            function deleteLocation() {
                var flag;
                flag = confirm("Do you want to UnAssign this Asset?");
                return flag;
            }

            function checkboxClick(sender) {

                collectSelectedItems(sender);
            }

            function getItemCheckBox(item) {
                //Get the 'div' representing the current RadComboBox Item.
                var itemDiv = item.get_element();

                //Get the collection of all 'input' elements in the 'div' (which are contained in the Item).
                var inputs = itemDiv.getElementsByTagName("input");

                for (var inputIndex = 0; inputIndex < inputs.length; inputIndex++) {
                    var input = inputs[inputIndex];

                    //Check the type of the current 'input' element.
                    if (input.type == "checkbox") {
                        return input;
                    }
                }

                return null;
            }

            function collectSelectedItems(sender) {
                var combo = $find(sender);
                var items = combo.get_items();

                var selectedItemsTexts = "";
                var selectedItemsValues = "";

                var itemsCount = items.get_count();

                for (var itemIndex = 0; itemIndex < itemsCount; itemIndex++) {
                    var item = items.getItem(itemIndex);

                    var checkbox = getItemCheckBox(item);

                    //Check whether the Item's CheckBox) is checked.
                    if (checkbox.checked) {
                        selectedItemsTexts += item.get_text() + ", ";
                        selectedItemsValues += item.get_value() + ", ";
                    }
                }

                selectedItemsTexts = selectedItemsTexts.substring(0, selectedItemsTexts.length - 2);
                selectedItemsValues = selectedItemsValues.substring(0, selectedItemsValues.length - 2);

                //Set the text of the RadComboBox with the texts of the selected Items, separated by ','.
                combo.set_text(selectedItemsTexts);

                //Set the comboValue hidden field value with values of the selected Items, separated by ','.

                if (selectedItemsValues == "") {
                    combo.clearSelection();
                }
            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog      
                else if (window.frameElement != null) {
                    if (window.frameElement.radWindow)
                        oWindow = window.frameElement.radWindow; //IE (and Moz as well)      
                }
                return oWindow;
            }

            function Openfacilitylist() {

                manager = $find("rd_manger_NewUI");
                // manager = $find("<%=rad_windowmgr.ClientID %>");

                var url = "../Asset/AssignAsset.aspx?facilitystatus=" + document.getElementById("<%=hdnfacility.ClientID%>").value + "&id=" + document.getElementById("<%=hfid.ClientID%>").value + "&name=" + document.getElementById("<%=hfentityname.ClientID%>").value;

                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                   // windows[0].model(false);
                    windows[0].show();
                    //windows[0].moveTo(100, 5);
                    //windows[0].model(false); 
                    windows[0].center();
                }
                return false;
            }

            function refreshgrid_asset() {
                document.getElementById("btn_refresh").click();
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

            function OpenCompo() {
                var empty = document.getElementById("hdnEmptyGuid").value;

                url = "AssetMenu.aspx?assetid=" + empty + "&SpaceId=" + document.getElementById("<%=hfid.ClientID%>").value;
                top.location.href(url);

            }


            //    function delete_component() {
            //        var flag = confirm("Do you want to delete this Component?");
            //        return flag;
            //    }
      
        </script>
        <script type="text/javascript" language="javascript">
            window.onload = body_load;
            function body_load() {
                if (document.getElementById("<%=txtcriteria.ClientID %>") != null)
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
                    scrollArea.style.height = ((parseInt(pageSize) - 2) * 40) + "px";
                }

            }
        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
        
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
    </style>
    <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG');  padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" defaultfocus="txtcriteria">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
     </asp:ScriptManager>
    <%--<script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>--%>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
        <table   style="font-family: Arial, Helvetica, sans-serif; table-layout: fixed;
        border-bottom-style: none; border-bottom-width: 0px; width: 100%; overflow: hidden;">
        <tr>
                <td class="centerAlign">
                    <asp:Button ID="btnaddasset"  Width="150px" runat="server" Text="<%$Resources:Resource, Assign_Component%>" EnableTheming="false"
                     OnClientClick="javascript:return Openfacilitylist();" />
                    <asp:Button ID="btnunassignasset" runat="server" Width="150px" Text="<%$Resources:Resource, Unassign_Component%>" Visible="true" EnableTheming="false"
                     OnClick="btnunassignasset_Click" />
                     <asp:Button ID="btnAddCompo" runat="server" Width="150px" Text="<%$Resources:Resource, Add_Component%>" Visible="true" EnableTheming="false"
                     OnClientClick="javascript:return OpenCompo();" />
                   
                </td>
            </tr>
            <tr>
                <td class="centerAlign" >
                    <div class="rpbItemHeader">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                            <tr>
                                <td align="left" class="entityImage" >
                                    <asp:Label runat="server" ID="lbl_grid_head" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12" Text="<%$Resources:Resource,Room_Data_Sheet%>" CssClass="gridHeadText" Width="100%"></asp:Label>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                    >
                                    <div id="div_search" style="width: 200px; background-color: white;"  >
                                        <asp:Panel ID="panelSearch" runat="server">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtcriteria" Width="180px">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ClientIDMode="Static" ID="btnsearch" Height="13px" runat="server"
                                                            ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnsearch_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                                <td align="right" style="padding: 4px 4px 0 0; width: 20px;">
                                   <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                        ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContent" >
                        <telerik:RadGrid runat="server" ID="rgasset" BorderWidth="1px" GridLines="None"
                            AllowPaging="true" PageSize="10" AutoGenerateColumns="False" AllowSorting="True"
                            PagerStyle-AlwaysVisible="false" AllowMultiRowSelection="true"  Width="100%" AllowCustomPaging="true"
                            OnItemCommand="rgasset_ItemCommand" OnItemDataBound="rgasset_OnItemDataBound"
                            OnSortCommand="btnsearch_Click" OnPageIndexChanged="btnsearch_Click" OnPageSizeChanged="btnsearch_Click">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="true" />
                            <ClientSettings EnableAlternatingItems="true" >
                                <Selecting AllowRowSelect="true" />
                                 <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="400" />
                              <ClientEvents OnGridCreated="GridCreated" />
                            </ClientSettings>
                            <MasterTableView DataKeyNames="Assetid" ClientDataKeyNames="Assetid">
                                  <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                                 <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                 <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                 <FooterStyle Height="25px" Font-Names="Arial" />
                                <Columns>
                                    
                                    <telerik:GridBoundColumn DataField="Assetid" HeaderText="AssetId" UniqueName="AssetId"
                                        Visible="false" SortExpression="Assetid">
                                    </telerik:GridBoundColumn>
                                   <telerik:GridClientSelectColumn>
                                        <ItemStyle Width="5%" Wrap="false" />
                                        <HeaderStyle Width="5%" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridBoundColumn DataField="linkasset" SortExpression="Asset_Name" HeaderText="<%$Resources:Resource, Component_Name%>"
                                        UniqueName="linkasset">
                                        <ItemStyle Width="60%" Wrap="false" />
                                        <HeaderStyle Width="60%"  />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="linktype" HeaderText="<%$Resources:Resource, Type_Name%>"
                                        UniqueName="linktype">
                                      <ItemStyle Width="30%" Wrap="false" />
                                        <HeaderStyle Width="30%"  />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="space_name" HeaderText="<%$Resources:Resource, Space%>"
                                        UniqueName="Location" SortExpression="space_name">
                                     <%--   <ItemStyle  Wrap="false" />--%>
                                    </telerik:GridBoundColumn>
                                    
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
        </table>
       <telerik:RadWindowManager Visible="true" ID="rad_windowmgr" runat="server" VisibleStatusbar="false"
        Skin="Default" AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false"
        KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" Visible="true" runat="server" Animation="None"
                Height="400px" Width="650px" Title="EcoDomus PM: Assign Component" KeepInScreenBounds="true"
                ReloadOnShow="false" Behaviors="Move, Resize" OffsetElementID="btnsearch" VisibleStatusbar="false"
                VisibleOnPageLoad="false" AutoSize="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_manger_NewUI" runat="server"  BackColor="#EEEEEE" VisibleTitlebar="true"  Title="<%$Resources:Resource,Assign_Component%>" Behaviors="Close,Move" 
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rd_window_master_Uniformat" runat="server" 
                Width="600"   BorderWidth="0px" Top="05"  Modal="false"  EnableShadow="false"
                ReloadOnShow="True"  VisibleOnPageLoad="false"  BackColor="#EEEEEE">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" BorderColor="Black"
        BorderWidth="2" Skin="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindow1" runat="server" ReloadOnShow="false" Width="600"
                AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" Behaviors="Resize,Move" BorderColor="Black"
                EnableAjaxSkinRendering="false" EnableShadow="true" BackColor="Black" VisibleTitlebar="false"
                BorderWidth="2" Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager> 
   <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgasset">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnsearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
           
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
   
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
    <asp:HiddenField runat="server" ID="hdnEmptyGuid" />
    <asp:HiddenField runat="server" ID="hfentityname" />
    <asp:HiddenField runat="server" ID="hfid" />
     <asp:HiddenField ID="hfDocumentPMPageSize"  runat="server" Value="" />
    <asp:HiddenField ID="hdnfacility" runat="server" />
    <div style="display: none;">
        <asp:Button ID="btn_refresh" runat="server" OnClick="btn_refresh_Click" Style="display: none;" />
    </div>
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
