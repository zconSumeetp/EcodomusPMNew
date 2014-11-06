<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Asset.aspx.cs" Inherits="App_Asset_Asset" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head  runat="server" id="head1"> 
     <title>Asset</title>
        <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
        <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
      <%--  <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />--%>
 </head>
  
 <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server"> 
    <script type="text/javascript" language="javascript">
        window.onload = body_load;
        function resize_Nice_Scroll() {

            $(".divScroll").getNiceScroll().resize();
        }
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
        function GridCreated(sender, args) {
            //debugger;
            //alert(sender.get_masterTableView().get_pageSize());
            var pageSize = document.getElementById("hfAttributePMPageSize").value;
            var scrollArea = sender.GridDataDiv;
            var dataHeight = sender.get_masterTableView().get_element().clientHeight;

            if (dataHeight < parseInt(pageSize) * 40) {
                scrollArea.style.height = dataHeight + "px";
            }
            else {
                scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
            }

            //sender.get_masterTableView().set_pageSize(globalPageHeight);
        }
    </script>
    <script language="javascript" type="text/javascript" >

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
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

        function Openfacilitylist() {

            manager = $find("<%= rd_manger_NewUI.ClientID %>");
            var url;
            var url = "../Asset/AssignAsset.aspx?facilitystatus=" + document.getElementById("<%=hdnfacility.ClientID%>").value + "&id=" + document.getElementById("<%=hfid.ClientID%>").value + "&name=" + document.getElementById("<%=hfentityname.ClientID%>").value;

            if (manager != null) {
                var windows = manager.get_windows();
                windows[0].setUrl(url);
                windows[0].show();
                //            windows[0]._width = "540px";
                //            windows[0]._height = "540px";
                windows[0].center();
            }
            return false;
        }

        function refreshgrid(name) {

            if (name != "")
                document.getElementById("txtcriteria").value = name;
            document.getElementById("btn_refresh").click();

        }
        function refreshgrid_asset() {

            document.getElementById("btn_refresh").click();

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
        function openUpdateNamesPopup() {

            var s1 = $find("<%=rgasset.ClientID %>");
            var MasterTable = s1.get_masterTableView();
            var selectedRows = MasterTable.get_selectedItems();
            var s = "";
            var s2 = "";
            if (document.getElementById("hf_component_id").value != "") {

                s = document.getElementById("hf_component_id").value + ",";
            }
            for (var i = 0; i < selectedRows.length; i++) {
                s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("Assetid") + ",";
                s2 = s2 + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("Assetid") + ",";
            }

            if (s == "") {
                alert("Please Select Component");
                return false;
            }
            else {

                manager = $find("<%=rd_manager.ClientID%>");
                if (document.getElementById("hf_component_id").value != "") {
                    var url = "../Asset/UpdateComponentNames.aspx?Component_id=" + s;
                }
                else {

                    var url = "../Asset/UpdateComponentNames.aspx?Component_id=" + s;
                }
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                    windows[0]._width = "540px";
                    windows[0]._height = "540px";
                    windows[0]._title = "EcoDomus PM :Update Names"
                }
                return false;
            }


        }

        function OpenCompo() {
            var empty = document.getElementById("hdnEmptyGuid").value;

            url = "AssetMenu.aspx?assetid=" + empty + "&TypeId=" + document.getElementById("<%=hfid.ClientID%>").value;
            top.location.href(url);

        }
        
</script>
    
    <style type="text/css">
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
            height:100%;
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
  
            
            
    </style>
  
    </telerik:RadCodeBlock>
   <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />  
<body style="background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); ; padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" defaultfocus="txtcriteria">
    
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeOut= "360000">
     <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
        </telerik:RadScriptManager>
  
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>


    
    
    
    
    <%--<div style="width:95%; border:1px solid red;height:450px;overflow:hidden;" class="divScroll">--%>
   <%-- <asp:updatepanel runat="server" ID="updatepanel1" EnableViewState="true" UpdateMode="Always"  >
    <ContentTemplate>--%>
    <asp:Panel ID="panelSearch" DefaultButton="btnSearch" runat="server">
        <div>

            <table width="100%" style="table-layout: fixed;">
               <tr >
                    <td align="left" class="centerAlign">
                        <%--This asp button added deu to functionality working fine plaese dont delete edit any code for this buttons--%>
                        <%--<asp:Button ID="btnassignSystem" runat="server" Text="<%$Resources:Resource, Assign_Component%>"
                            OnClientClick="javascript:return Openfacilitylist();" Font-Names="Lucida Sans Unicode"
                            Font-Size="X-Small" Height="23px" Width="170px" />--%>
                      <telerik:RadButton ID="btnassignSystem" runat="server" Text="<%$Resources:Resource, Assign_Component%>"
                            OnClientClicked="Openfacilitylist" AutoPostBack="false"></telerik:RadButton>
                        <telerik:RadButton ID="btnaddasset" runat="server" Visible="false" Text="<%$Resources:Resource, Assign_Component%>"
                            OnClientClicked="Openfacilitylist" />
                        <telerik:RadButton ID="btnunassignasset" runat="server" Text="<%$Resources:Resource, Unassign_Component%>"
                            OnClick="btnunassignasset_Click"  />
                        <telerik:RadButton ID="btnUpdateNames" runat="server" Skin="Default" Visible="false"
                            Text="<%$Resources:Resource, Update_Names%>" OnClientClicked="openUpdateNamesPopup" />
                        <%--<asp:Button ID="btnUpdateName" runat="server" Text="<%$Resources:Resource, Update_Names%>"
                            OnClientClick="javascript:return openUpdateNamesPopup();" Font-Names="Lucida Sans Unicode"
                            Font-Size="X-Small" Height="23px" Width="170px" />--%>
                         <telerik:RadButton ID="btnUpdateName" runat="server" Text="<%$Resources:Resource, Update_Names%>"
                            OnClientClicked="openUpdateNamesPopup" AutoPostBack="false" ></telerik:RadButton>
                        <telerik:RadButton ID="btnAddCompo" runat="server" Text="<%$Resources:Resource, Add_Component%>"
                            OnClientClicked="OpenCompo"  />
                        <asp:HiddenField runat="server" ID="hfentityname" />
                        <asp:HiddenField runat="server" ID="hfid" />
                        <asp:HiddenField ID="hdnfacility" runat="server" />
                        <asp:HiddenField ID="hf_component_id" runat="server" />
                        <asp:HiddenField ID="hdnEmptyGuid" runat="server" />
                        <asp:HiddenField ID="hfAttributePMPageSize" runat="server" />
                        <div style="display: none;">
                            <asp:Button ID="btn_refresh" runat="server" OnClick="btn_refresh_Click" Style="display: none;" />
                        </div>
                    </td>
                </tr>
               <tr>
                    <td>
                        <%-- <div style="width:95%; border:1px solid red; height:250px; overflow:hidden;" class="divScroll">--%>
                        <div class="rpbItemHeader">
                            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                                <tr>
                                    <td align="left" class="entityImage" >
                                        <asp:Label runat="server" ID="lbl_grid_head" Text="<%$Resources:Resource,Components%>" CssClass="gridHeadText" Width="200px"
                                            ForeColor="#F8F8F8" Font-Names="Arial"  Font-Size="12"></asp:Label>
                                    </td>
                                    </td>
                                    <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;    ">
                                        <div id="div_search" style="width: 200px; background-color: white;" >
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="<%$Resources:Resource,Search%>" BorderColor="White" ID="txtcriteria" Width="180px">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ClientIDMode="Static" ID="btnSearch" Height="13px" runat="server"
                                                            ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnsearch_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td align="right" style="padding: 4px 4px 0 0; width: 10px;">
                                        <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="divSelectedDomponentContent" >
                            <telerik:RadGrid runat="server" ID="rgasset" BorderWidth="1px" AllowPaging="true"
                                PageSize="10" AutoGenerateColumns="False" AllowSorting="True" PagerStyle-AlwaysVisible="false"
                                Visible="false" AllowMultiRowSelection="true" Skin="Default" 
                                Width="100%" ItemStyle-Wrap="false" OnSortCommand="btnsearch_Click" OnPageIndexChanged="rgasset_OnPageIndexChanged" 
                                OnItemDataBound="rgasset_OnItemDataBound" OnPageSizeChanged="rgasset_OnPageSizeChanged">
                                <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" AlwaysVisible="true"   />
                                <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true" >
                             
                                    <Selecting AllowRowSelect="true" />
                                     <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400"  />
                                     <ClientEvents OnGridCreated="GridCreated" />
                                </ClientSettings>
                                <MasterTableView DataKeyNames="Assetid" ClientDataKeyNames="Assetid">
                                    <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10"  />
                                    <AlternatingItemStyle Height="31px"  Font-Names="Arial" Font-Size="10" />
                                    <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                     <FooterStyle Height="25px" Font-Names="Arial"/>
                                    <Columns>
                                        <telerik:GridClientSelectColumn>
                                            <ItemStyle Width="1%"  />
                                            <HeaderStyle Width="5%" />
                                        </telerik:GridClientSelectColumn>
                                        <telerik:GridBoundColumn DataField="Assetid" HeaderText="AssetId" UniqueName="AssetId"
                                            Visible="false" SortExpression="Assetid">
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridTemplateColumn DataField="Asset_Name" HeaderText="AssetName" UniqueName="AssetName" SortExpression="Asset_Name">
                        <ItemStyle  Width="200" />
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkassetname" CommandName="AssetProfile"
                                     Text='<%# DataBinder.Eval(Container.DataItem,"Asset_Name") %>' runat="server" >
                                </asp:LinkButton>
                            </ItemTemplate>
                    </telerik:GridTemplateColumn>--%>
                                        <telerik:GridBoundColumn DataField="linkasset" SortExpression="Asset_Name" HeaderText="<%$Resources:Resource, Component_Name%>"
                                            UniqueName="linkasset">
                                            <ItemStyle  Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="linktype" HeaderText="<%$Resources:Resource, Type_Name%>"
                                            UniqueName="linktype">
                                            <ItemStyle  Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="space_name" HeaderText="<%$Resources:Resource, Location%>"
                                            UniqueName="Location" SortExpression="space_name">
                                            <ItemStyle  Wrap="false" />
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                        <%-- </div>--%>
                    </td>
                </tr>
            </table>
           
        </div>
        <telerik:RadWindowManager ID="rad_windowmgr" runat="server" VisibleStatusbar="false"
            Skin="Forest">
            <Windows>
                <telerik:RadWindow ID="radWindowAddNew" runat="server" OffsetElementID="txtcriteria"
                    Height="300px" Width="600px" Title="EcoDomus PM: Assign Component" KeepInScreenBounds="true"
                    ReloadOnShow="false" BorderStyle="Solid" Behaviors="Move, Resize" VisibleStatusbar="false"
                    AutoSize="false">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
        <telerik:RadWindowManager ID="rd_manager" runat="server"  VisibleTitlebar="true"  Title="Update Name" Behaviors="Close,Move" 
        BorderWidth="0px"  Skin="Simple" BorderStyle="None" >
            <Windows>
                <telerik:RadWindow ID="RadWindow3" runat="server" 
                ReloadOnShow="false"  AutoSize="false" Width="400px" Height="130px"
                VisibleStatusbar="false" VisibleOnPageLoad="false" BorderWidth="0px"  EnableShadow="true" BackColor="#EEEEEE">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
        <telerik:RadWindowManager ID="rd_manger_NewUI" runat="server"  VisibleTitlebar="true"  Title="<%$Resources:Resource,Assign_Component%>" Behaviors="Close,Move" 
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
            <Windows>
                <telerik:RadWindow ID="rd_window_master_Uniformat" 
                    runat="server"  BorderWidth="0px" Top="10"
                ReloadOnShow="True" Width="600"  VisibleOnPageLoad="false"  EnableAjaxSkinRendering="false"
                BackColor="#EEEEEE">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </asp:Panel>
   
 

<%--</ContentTemplate>
</asp:updatepanel>--%>
   <%--  </div>--%>

    <telerik:RadAjaxManager ID="ramAsset" EnableAJAX="true"  runat="server" >

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnUpdateNames">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <%--<telerik:AjaxSetting AjaxControlID="btnUpdateNames">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="hfid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="hdnfacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="hf_component_id">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
            <telerik:AjaxSetting AjaxControlID="btnunassignasset">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="rgasset">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
       <%--  <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />--%>
    </telerik:RadAjaxLoadingPanel>
        
    </form>
  
</body>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
<style>
     .RadWindow_Simple
        {
            border: solid 0px #616161;
        }
</style>
</html>
