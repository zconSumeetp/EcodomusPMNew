<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SpacePM.aspx.cs" MasterPageFile="~/App/EcoDomus_PM_New.master"
    Inherits="App_Locations_SpacePM" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" language="javascript">
            //        function setFocus() {
            //            document.getElementById("<%=txt_search.ClientID %>").focus();
            //             
            //        } 
            //        window.onload = setFocus;

            function resize_Nice_Scroll() {

                //$(".divScroll").getNiceScroll().resize();
                if (document.getElementById("<%=txt_search.ClientID %>") != null)
                    document.getElementById("<%=txt_search.ClientID %>").focus();
            }

            function body_load() {
                var screenhtg = set_NiceScrollToPanel();
                if (document.getElementById("<%=txt_search.ClientID %>") != null)
                    document.getElementById("<%=txt_search.ClientID %>").focus();
            }

            window.onload = body_load;
        

        </script>
        <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            function disp() {
                var notification = $find("<%=rd_display_window.ClientID %>");
                notification.show();
                return false;
            }

            function ProjectValidation() {

                alert('Please select Project');
                window.location = '../Settings/Project.aspx';
                return false;

            }


            function Clear_text_box() {
                try {
                    document.getElementById("ContentPlaceHolder1_txt_search").value = "";
                    document.getElementById("<%=txt_search.ClientID %>").focus();
                    return false;
                }
                catch (e) {
                    return false;
                }
            }
            function gotoPage(id, pagename) {


                if (pagename == "Facility") {
                    url = "../Locations/FacilityMenu.aspx?IsFromFacility=Y&FacilityId=" + id;
                }
                parent.location.href(url);
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


            function checkboxClick(sender) {
                collectSelectedItems(sender);
                document.getElementById('ContentPlaceHolder1_btn_navigate').click();
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
                document.getElementById('ContentPlaceHolder1_hf_facility_id').value = selectedItemsValues;
            }

            function navigate_space() {
                var f_id = "";
                var url = "../locations/facilitymenu.aspx?pagevalue=Space Profile&id=" + document.getElementById("ContentPlaceHolder1_hf_space_id").value + "&profileflag=old&floor_id=" + f_id;
                window.location.href(url);
            }
            function chkgrid() {
                var s1 = $find("<%=rg_spaces.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();

                if (selectedRows.length != 0) {

                    return true;
                }
                else {
                    alert('Please select atleast one space');
                    return false;
                }
            }

            function confirmation() {
                var RadGrid1 = $find("<%=rg_spaces.ClientID %>");
                var masterTable = $find("<%= rg_spaces.ClientID %>").get_masterTableView();
                var row = masterTable.get_dataItems().length;
                var cnt = 0;
                for (var i = 0; i < row; i++) {
                    var row1 = masterTable.get_dataItems()[i];
                    if (row1.get_selected()) {
                        cnt = cnt + 1;
                        //return true;
                        //return true;
                    }


                }
                if (cnt != 0) {

                    var flag;
                    flag = confirm("Do you want to delete this  Space?");
                    return flag;
                    //return true;
                }
                else {
                    alert("Please select space");
                    return false;

                }
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
            function Configurefacility() {

                alert("Barcode is not configured");

            }

            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {
                //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
                var pageSize = document.getElementById("ContentPlaceHolder1_hfSpacePMPageSize").value;
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
    </telerik:RadCodeBlock>
    <style type="text/css">
            body
            {
            }
            
            .searchImage
            {
                background-image: url('/App/Images/Icons/icon_search_sm.png');
                background-repeat: no-repeat;
                background-position: right;
                font-family: "Arial" , sans-serif;
                font-size: 12px;
            }
            .gridHeadText
            {
                font-family: "Verdana" , "Sans-Serif";
                font-style: normal;
                font-size: medium;
                color: White;
            }
            .entityImage
            {
                padding-left: 7px;
            }
            .gridHeaderText
            {
                font-family: "Arial" , sans-serif;
                font-size: 16px;
                height: 20px;
                font-weight: bold;
                background-color: #AFAFAF;
            }
            
            .gridRadPnlHeader
            {
                background-color: Gray;
                height: 30px;
                width: 100%;
                vertical-align: middle;
            }
            .captiondock
            {
                font-family: Arial, Helvetica, sans-serif;
                font-size: 14px;
                color: #990000;
                text-align: left;
                vertical-align: middle;
                margin-top: 10px;
                margin-bottom: 10px;
                font-weight: normal;
            }
            
            .gridRadPnlHeaderBottom
            {
                background-color: Orange;
                height: 1px;
                width: 100%;
            }
            .dropDownImage
            {
                right: 15px;
            }
            
            .searchTextBox
            {
                position: relative;
                right: 10px;
            }
            
            .wizardHeadImage
            {
                background-color: #FFA500;
                height: 30px;
                background-attachment: scroll;
                width: 100%;
                background-attachment: fixed;
                background-position: right;
                background-repeat: no-repeat;
                position: relative;
            }
            .wizardLeftImage
            {
                float: left;
                padding-left: 15px;
                vertical-align: middle;
                height: 20;
                right: 5px;
            }
            .wizardRightImage
            {
                float: right;
                padding-right: 10px;
                vertical-align: middle;
                height: 20;
            }
            
            
            
            .RadWindow_Default .rwCorner .rwTopLeft, .RadWindow_Default .rwTitlebar
            {
                width: 0px;
                height: 0px;
            }
            .RadWindow_Default .rwCorner .rwTopRight, .RadWindow_Default .rwIcon, .RadWindow_Default table .rwTopLeft, .RadWindow_Default table .rwTopRight, .RadWindow_Default table .rwFooterLeft, .RadWindow_Default table .rwFooterRight, .RadWindow_Default table .rwFooterCenter, .RadWindow_Default table .rwBodyLeft, .RadWindow_Default table .rwBodyRight, .RadWindow_Default table .rwTitlebar
            {
                background: none;
            }
            
            .RadWindow_Default table .rwStatusbar .rwLoading
            {
                background: none !important;
                border: 0px;
                display: none;
                width: 0px;
                height: 0px;
            }
            .RadWindow.rwMinimizedWindowShadow .RadWindow.rwMinimizedWindowShadow .rwTable, .normalLabel
            {
                font-family: "Arial" , sans-serif;
                font-size: 12px;
            }
            .normalLabelBold
            {
                font-family: "Arial" , sans-serif;
                font-size: 12px;
                font-weight: bold;
            }
            .headerBoldLabel
            {
                font-family: "Arial" , sans-serif;
                font-size: 16px;
                font-weight: bold;
            }
            
            .lblHeading
            {
                font-family: "Arial";
                font-size: 10px;
            }
            
            .tdValign
            {
                vertical-align: top;
                margin: 0;
            }
            .lnkButton
            {
                font-family: "Arial";
                font-size: 10px;
                color: Black;
                text-decoration: none;
            }
            
            .lnkButtonImg
            {
                height: 14px;
                vertical-align: bottom;
            }
            
            
            .lblBold
            {
                font-family: "Arial" , sans-serif;
                font-size: 12px;
                height: 20px;
                vertical-align: middle;
                font-weight: bold;
            }
            
            .gridHeaderBoldText
            {
                font-family: "Arial" , sans-serif;
                font-size: 14px;
                vertical-align: bottom;
                font-weight: bold;
            }
            
            
            .textAreaScrollBar
            {
                font-family: "Arial" , sans-serif;
                font-size: 12px;
                overflow: auto;
                padding-left: 10px;
                padding-top: 10px;
                border-left-color: #D4D4C3;
                border-top-color: #D4D4C3;
                border-bottom-color: #E8E8E8;
                border-right-color: #E8E8E8;
                height: 170px;
            }
            
           <%-- html
            {   
                
               overflow-y:hidden;
               -ms-overflow-x:auto;
              
            }--%>
            .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color:#808080;
        }
        .topbuttons
        {
                height: 25px;
                padding-bottom:0px;
                padding-left:02px;
                width: 100%;
        }
        </style>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <asp:Panel ID="panelSearch" runat="server" DefaultButton="btn_find">
        <table width="100%" style="table-layout: fixed;">
            <tr>
                <td class="topbuttons">
                    <asp:Button ID="btnaddspace" Text="<%$Resources:Resource,Add_Space%>" runat="server"
                        Width="100px" OnClick="btnaddspace_Click" />
                    <asp:Button ID="btn_display_column" runat="server" Text=" <%$Resources:Resource,Display_Columns%>"
                        OnClientClick="javascript:return disp();" />
                    <asp:Button ID="btnGenerateBarcode" runat="server" Text="<%$Resources:Resource,Generate_Barcode%>"
                        Width="130px" Skin="Default" OnClientClick="javascript:return chkgrid();" OnClick="btnGenerateBarcode_Click" />
                    <asp:Button ID="btnExcel" runat="server" Text="<%$Resources:Resource, Export_To_Excel%>"
                        Visible="true" OnClick="btnExcel_Click" />
                    <asp:Button ID="btndelete" Text="<%$Resources:Resource,Delete%>" runat="server" Width="100px"
                        OnClick="btn_delete_click" OnClientClick="javascript:return confirmation();" />
                </td>
            </tr>
            <tr>
                <td style="display: none;">
                    <table>
                        <tr>
                            <td>
                                <asp:HiddenField ID="hfSpacePMPageSize" runat="server" Value="" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="centerAlign">
                    <div class="rpbItemHeader divBorder">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                            <tr>
                                <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width: 35%;">
                                    <asp:Label runat="server" Text="<%$Resources:Resource,Spaces%>" ID="lbl_grid_head"
                                        CssClass="gridHeadText" Width="250px" ForeColor="#F8F8F8" Font-Names="Arial"
                                        Font-Size="12"></asp:Label>
                                </td>
                                <td onclick="stopPropagation(event)">
                                    <asp:Label ID="lbl_facility" runat="server" Text="<%$Resources:Resource,Facility%>"
                                        CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10">:</asp:Label>
                                    <telerik:RadComboBox Width="170px" ID="cmb_facility" Filter="Contains" runat="server"
                                        OnItemDataBound="cmbfacility_ItemDataBound" AllowCustomText="True" onkeypress="return tabOnly(event)">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox2" runat="server" OnCheckedChanged="checkchange" Text='<%#Eval("name") %>' />
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
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
                                                    <asp:ImageButton ClientIDMode="Static" ID="btn_find" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                        OnClick="btn_search_click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td align="right" style="padding: 4px 6px 0 0;">
                                    <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)"/>--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContent" class="divProperties RightMenu_1_Content">
                        <telerik:RadGrid ID="rg_spaces" runat="server" AllowSorting="true" AllowPaging="true"
                            BorderWidth="1px" AutoGenerateColumns="false" Skin="Default" PagerStyle-AlwaysVisible="true"
                            OnItemCreated="rg_spaces_OnItemCreated" ItemStyle-Wrap="false" OnSortCommand="rg_spacesSortCommand"
                            AllowMultiRowSelection="true" OnPageIndexChanged="rg_spacesPageIndexChanged"
                            OnItemCommand="rg_spaces_ItemCommand" OnPageSizeChanged="rg_spacesPageSizeChanged"
                            PageSize="10" OnItemDataBound="rg_spaces_OnItemDataBound" OnSelectedIndexChanged="rg_spaces_SelectedIndexChanged">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                            <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                <Selecting AllowRowSelect="true" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                                <ClientEvents OnGridCreated="GridCreated" />
                            </ClientSettings>
                            <MasterTableView DataKeyNames="Space_location_id,Floor_location_id,pk_facility_id,FloorName,Area">
                                <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                <FooterStyle Height="25px" Font-Names="Arial" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Space_location_id" Visible="false">
                                        <ItemStyle CssClass="column" Width="10%" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridClientSelectColumn>
                                        <ItemStyle Width="5%" Wrap="false" />
                                        <HeaderStyle Width="5%" Wrap="false" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridButtonColumn ButtonType="LinkButton" UniqueName="name" DataTextField="SpaceName"
                                        HeaderText="<%$Resources:Resource,Space_Name%>" SortExpression="SpaceName" CommandName="SpaceProfile">
                                        <ItemStyle Wrap="false" Width="15%" />
                                        <HeaderStyle Wrap="false" Width="15%" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>">
                                        <ItemStyle Wrap="false" />
                                        <HeaderStyle Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn ButtonType="LinkButton" UniqueName="name1" DataTextField="FloorName"
                                        HeaderText="<%$Resources:Resource,Floor%>" SortExpression="FloorName" CommandName="FloorProfile">
                                        <ItemStyle Wrap="false" />
                                        <HeaderStyle Wrap="false" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn DataField="Area" HeaderText="<%$Resources:Resource,Net_Area%>">
                                        <ItemStyle Wrap="false" />
                                        <HeaderStyle Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="linkfacility" HeaderText="<%$Resources:Resource,Facility%>"
                                        UniqueName="linkfacility">
                                        <ItemStyle Wrap="false" />
                                        <HeaderStyle Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Omniclass" HeaderText="<%$Resources:Resource,Category%>" SortExpression="OmniClass"
                                        Visible="true">
                                        <ItemStyle Wrap="false" />
                                        <HeaderStyle Wrap="false" />
                                    </telerik:GridBoundColumn>

                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <telerik:RadWindowManager Visible="true" ID="rad_window" VisibleStatusbar="false"
        AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server"
        KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" Title="Add Floors"
                Animation="Slide" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="true"
                AutoSize="false" Width="900" Height="500" VisibleStatusbar="false" Behaviors="Move, Resize"
                VisibleOnPageLoad="false" Skin="Default">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <div style="display: none">
        <asp:Button ID="btn_navigate" runat="server" OnClick="navigate" />
    </div>
    <asp:HiddenField ID="hf_facility_id" runat="server" />
    <asp:HiddenField ID="hf_floor_id" runat="server" />
    <asp:HiddenField ID="hf_space_id" runat="server" />
    <asp:HiddenField ID="HiddenField2" runat="server" />
    <telerik:RadNotification ID="rd_display_window" runat="server" Width="225" KeepOnMouseOver="true"
        Position="TopCenter" AutoCloseDelay="500000" EnableRoundedCorners="true" EnableShadow="true"
        Skin="Default" OffsetX="-300" OffsetY="75" LoadContentOn="PageLoad" Title="Display Columns">
        <ContentTemplate>
            <asp:Panel ID="panel_bar" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_facility" runat="server" Text="<%$Resources:Resource,facility%>"
                                AutoPostBack="true" OnCheckedChanged="chk_facility_click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_category" runat="server" Text="<%$Resources:Resource,Category%>"
                               OnCheckedChanged="chk_category_CheckedChanged" AutoPostBack="true" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </ContentTemplate>
    </telerik:RadNotification>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmb_facility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_spaces" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chk_facility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_spaces" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chk_category">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_spaces" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_display_column">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_spaces" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_find">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_spaces" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rg_spaces">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_spaces" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmb_facility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Content1" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
