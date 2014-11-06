<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="FloorsPM.aspx.cs" Inherits="App_Locations_FloorsPM" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
    <script type="text/javascript" language="javascript">

        function disp() {
            var notification = $find("<%=rd_display_window.ClientID %>");
            notification.show();
            return false;
        }
        function doClick(buttonName, e) {
            //the purpose of this function is to allow the enter key to 
            //point to the correct button to click.
            var key;

            if (window.event)
                key = window.event.keyCode;     //IE
            else
                key = e.which;     //firefox

            if (key == 13) {
                //Get the button the user wants to have clicked
                var btn = document.getElementById(buttonName);
                if (btn != null) { //If we find the button click it
                    btn.click();
                    event.keyCode = 0
                }
            }
        }
        function resize_Nice_Scroll() {
                  
            if (document.getElementById("<%=txt_search.ClientID %>") != null)
                document.getElementById("<%=txt_search.ClientID %>").focus();
        }
 
        function body_load() {
            var screenhtg = set_NiceScrollToPanel();
            if (document.getElementById("<%=txt_search.ClientID %>") != null)
                document.getElementById("<%=txt_search.ClientID %>").focus();
        
        }

        window.onload = body_load;

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }
        function divSelectedDomponentContent_onmouseover() {
            resize_Nice_Scroll();
        }

        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {
            //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
            var pageSize = document.getElementById("ContentPlaceHolder1_hfFloorsPMPageSize").value;
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

    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
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
        function Clear_text_box() {
            try {
                document.getElementById("ContentPlaceHolder1_txt_search").value = "";
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
            window.location.href(url);
        }
        function ProjectValidation() {

            alert('Please select Project');
            window.location = '../Settings/Project.aspx';
            return false;

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

        function navigate_floor() {
            var url = "../locations/facilitymenu.aspx?pagevalue=Floor Profile&id=" + document.getElementById("ContentPlaceHolder1_hf_floor_id").value;
            window.location.href(url);
        }


        function validate() {
            alert("Select atleast one Floor.....!");
            return false;
        }


        function confirmation() {
            var RadGrid1 = $find("<%=rg_floors.ClientID %>");
            var masterTable = $find("<%= rg_floors.ClientID %>").get_masterTableView();
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
                flag = confirm("Do you want to delete this floor?");
                return flag;
                //return true;
            }
            else {
                alert("Please select floor");
                return false;

            }
            //            var flag;
            //            flag = confirm("Are you sure you want to delete?");
            //            if (flag)
            //                return true;
            //            else
            //                return false;
        }



    </script>
    <style type="text/css">
        
        
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
        
     
            
            .divProperties
                {
                    background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
                }
            .rpbItemHeader
             {
            background-color:#808080;
             }
             
    </style>
    </telerik:RadCodeBlock>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />


    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <asp:Panel ID="pnlFloorsId" runat="server" DefaultButton="btn_search" >
    <table width="100%;" style="table-layout: fixed;">
            <tr>
                <td class="topbuttons">
                    <asp:Button ID="btnaddfloor" Text="<%$Resources:Resource,Add_Floor%>" runat="server"
                        Width="100px" OnClick="btnaddfloor_Click" />
                    <asp:Button ID="btn_display_column" runat="server" Text=" <%$Resources:Resource,Display_Columns%>"
                        OnClientClick="javascript:return disp();" />
                    <asp:Button ID="btndelete" Text="<%$Resources:Resource,Delete%>" runat="server" Width="100px"
                        OnClick="btn_delete_click" OnClientClick="javascript:return confirmation();" />
                </td>
            </tr>
            <tr>
            <td  style="display:none;">
                <table>
                    <tr>
                        <td style="padding-top: 0px; display: none" align="left">
                            <asp:HiddenField ID="hfFloorsPMPageSize" runat="server" Value="" />
                           
                        </td>
                    </tr>
                </table>
            </td>
          </tr>
            <tr>
                <td class="centerAlign">
                    <div class="rpbItemHeader divBorder">
                        <table cellpadding="0" cellspacing="0" width="100%" style="table-layout: fixed; background-color: #808080;">
                            <tr>
                                <td align="left" class="entityImage" >
                                    <asp:Label runat="server" Text="<%$Resources:Resource,Floors%>" ID="lbl_grid_head"
                                        CssClass="gridHeadText" Width="100px" ForeColor="#F8F8F8" Font-Names="Arial"
                                        Font-Size="12"></asp:Label>
                                </td>
                                <td >
                                    <asp:Label ID="lbl_facility" runat="server" Text="<%$Resources:Resource,Facility%>"
                                        CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10">:</asp:Label>
                                   <asp:Label ID="lblCol2" runat="server"  Text=":"  CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10" ></asp:Label>
                                    <telerik:RadComboBox Width="170px" ID="cmb_facility" Filter="Contains" runat="server"
                                        OnItemDataBound="cmbfacility_ItemDataBound" AllowCustomText="True" onkeypress="return tabOnly(event)"
                                        Visible="true">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked="true" Text='<%# Eval("name") %>' />
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_criteria" runat="server" Text="<%$Resources:Resource,Criteria%>"
                                        CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10"></asp:Label>
                                   <asp:Label ID="lblCol1" runat="server"  Text=":"  CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10" ></asp:Label>
                                    <telerik:RadComboBox ID="cmb_criteria" runat="server" AutoPostBack="true" Filter="Contains"
                                        Height="100px" TabIndex="14" Width="150px">
                                        <Items>
                                            <telerik:RadComboBoxItem Value="Name" Text="Name" Selected="True" runat="server"
                                                Font-Size="11px" />
                                            <telerik:RadComboBoxItem Value="Description" Text="Description" runat="server" Font-Size="11px" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                    >
                                    <div id="div1" style="width: 200px; background-color: white;" >
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txt_search" Width="180px">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ClientIDMode="Static" ID="btn_search" Height="13px" runat="server"
                                                        ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btn_search_click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td align="right" style="padding: 4px 2px 0 0; width: 1%;">
                                   <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                        ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />
                                --%></td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContent" class="divProperties RightMenu_1_Content">
                        <telerik:RadGrid ID="rg_floors" runat="server" AllowSorting="true" AllowPaging="true"
                            BorderWidth="1px" AutoGenerateColumns="false" Skin="Default" PagerStyle-AlwaysVisible="true"
                            OnSortCommand="rg_floorsSortCommand" OnItemCommand="rg_floors_ItemCommand" AllowMultiRowSelection="true"
                            OnPageIndexChanged="rg_floorsPageIndexChanged" OnPageSizeChanged="rg_floorsPageSizeChanged"
                            PageSize="10" ItemStyle-Wrap="false" OnItemDataBound="rg_floors_OnItemDataBound">
                           <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                           <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                               <Selecting AllowRowSelect="true" />
                               <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                               <ClientEvents OnGridCreated="GridCreated" />
                           </ClientSettings>
                          <MasterTableView DataKeyNames="Floor_id,pk_facility_id">
                               <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                               <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                               <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                               <FooterStyle Height="25px" Font-Names="Arial" />
                           
                                <Columns>
                                    <telerik:GridBoundColumn DataField="Floor_id" Visible="false">
                                        <ItemStyle  Width="10%" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridClientSelectColumn>
                                        <ItemStyle Width="5%" />
                                        <HeaderStyle Width="5%" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridButtonColumn ButtonType="LinkButton" UniqueName="floor_name" DataTextField="FloorName"
                                        HeaderText="<%$Resources:Resource,Floor_Name%>" SortExpression="FloorName" CommandName="FloorProfile">
                                        <HeaderStyle Wrap="false" Width="30%" />
                                        <ItemStyle Wrap="false" Width="30%" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn DataField="FloorDescription" UniqueName="description" HeaderText="<%$Resources:Resource,Description%>">
                                        <HeaderStyle Wrap="false" Width="25%" />
                                        <ItemStyle Wrap="false" Width="25%" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="linkfacility" Visible="false" HeaderText="<%$Resources:Resource,Facility%>"
                                        UniqueName="linkfacility">
                                        <HeaderStyle Wrap="false" Width="15%" />
                                        <ItemStyle Wrap="false" Width="15%" />
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
                VisibleOnPageLoad="false" Skin="Forest">
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
    <telerik:RadAjaxManagerProxy runat="server">
    </telerik:RadAjaxManagerProxy>
    <telerik:RadNotification ID="rd_display_window" runat="server" Width="225" KeepOnMouseOver="true"
        Position="TopCenter" AutoCloseDelay="500000" EnableRoundedCorners="true" EnableShadow="true"
        Skin="Default"   OffsetX="-300" OffsetY="75" LoadContentOn="PageLoad" Title="TagNumber/SerialNumber">
        <ContentTemplate>
            <asp:Panel ID="panel_bar" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_facility" runat="server" Text="<%$Resources:Resource,facility%>"
                                AutoPostBack="true" OnCheckedChanged="chk_facility_click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </ContentTemplate>
    </telerik:RadNotification>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="chk_facility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_floors" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_floors" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rg_floors">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_floors" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server"  Skin="Default" Height="75px" Width="75px">
        <%--<img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />--%>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
