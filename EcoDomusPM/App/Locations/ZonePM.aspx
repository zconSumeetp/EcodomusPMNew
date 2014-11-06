<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="ZonePM.aspx.cs" Inherits="App_Locations_ZonePM" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
        <script type="text/javascript" language="javascript">
            function validate_space() {
                alert("This space is not linked with BIM");
            }


            ///for opening spaces popup 
            function AssignSpace_popup(url) {

                //url = "../Locations/AssignSpace.aspx?id=f758670f-dad4-4809-944e-6d662a18c560"; //document.getElementById('hf_zone_id').value;
                manager = $find("<%= rad_window.ClientID %>");
                var windows = manager.get_windows();
                windows[0].show();
                windows[0].setUrl(url);

                //return false;
            }

            //this function gets assignes the spaces to particular zone
            //Gets called from popup
            function callback_zone_pm(Id, Name, zone_id) {


                //                window.parent.document.getElementById("ContentPlaceHolder1_hf_selected_id").value = Id;
                //                window.parent.document.getElementById("ContentPlaceHolder1_hf_selected_name").value = Name;
                //                window.parent.document.getElementById("ContentPlaceHolder1_hf_zone_id").value = zone_id;
                //                document.getElementById("<%= btn_assign_spaces.ClientID %>").click();


                $("#<%= hf_selected_id.ClientID %>").val(Id);
                $("#<%= hf_selected_name.ClientID %>").val(Name);
                $("#<%= hf_zone_id.ClientID %>").val(zone_id);

                document.getElementById("<%= btn_assign_spaces.ClientID %>").click();

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
            window.onload = body_load;

            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }
            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {
                //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
                var pageSize = document.getElementById("ContentPlaceHolder1_hfZonePMPageSize").value;
                var scrollArea = sender.GridDataDiv;
                var dataHeight = sender.get_masterTableView().get_element().clientHeight;
                //sender.get_masterTableView().set_pageSize(pageSize);
                if (dataHeight < parseInt(pageSize) * 39) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 39 - 12) + "px";
                }

            }

        </script>
        <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
        <script type="text/javascript" language="javascript">
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
            function disp() {
                var notification = $find("<%=rd_display_window.ClientID %>");
                notification.show();
                return false;
            }

            function fn_Clear() {
                try {
                    document.getElementById("ContentPlaceHolder1_txt_search").value = "";
                    return false;
                }
                catch (e) {
                    alert(e.message + "  " + e.Number);
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

                //document.getElementById('ContentPlaceHolder1_hf_facility_id').value = selectedItemsValues;
            }

        </script>
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
            
            
            
            .divProperties
            {
                background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
            }
            .rpbItemHeader
            {
                background-color: #808080;
            }
        </style>
    </telerik:RadCodeBlock>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <telerik:RadFormDecorator ID="rdfAll" DecoratedControls="Scrollbars,Buttons" Skin="Default"
        runat="server" />
    <asp:Panel ID="pnlZonesId" runat="server" DefaultButton="btn_search">
        <table width="100%" style="table-layout: fixed;">
            <tr>
                <td class="topbuttons">
                    <asp:Button ID="btn_display_column" runat="server" Text=" <%$Resources:Resource,Display_Columns%>"
                        OnClientClick="javascript:return disp();" Visible="false" />
                    <asp:Button ID="btnadd" runat="server" Text="<%$Resources:Resource,Add_Zone%>" Width="100px"
                        CausesValidation="false" OnClick="btnadd_Click" />
                    <asp:Button ID="btn_delete" runat="server" Text="<%$Resources:Resource,Delete%>"
                        Width="100px" CausesValidation="false" OnClick="btndelete_Click" OnClientClick="javascript:return validate();"
                        Visible="true" />
                    <asp:Button ID="btnclose" runat="server" Text="Close" Visible="false" Width="100px"
                        OnClientClick="javascript:close_Window();" CausesValidation="false" />
                </td>
            </tr>
            <tr>
                <td style="display: none;">
                    <table>
                        <tr>
                            <td style="padding-top: 0px; display: none" align="left">
                                <asp:HiddenField ID="hfZonePMPageSize" runat="server" Value="" />
                                <asp:Label ID="lblError" runat="server" Style="color: Red;"></asp:Label>
                                <asp:HiddenField ID="hfLocation_id" runat="server" />
                                <asp:HiddenField ID="hf_facility_id" runat="server" />
                                <asp:HiddenField ID="hf_selected_id" runat="server" />
                                <asp:HiddenField ID="hf_selected_name" runat="server" />
                                <asp:HiddenField ID="hf_zone_id" runat="server" />
                                <asp:HiddenField ID="hf_pk_zone_id" runat="server" />
                                <asp:HiddenField ID="hf_entity_id" runat="server" />
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
                                <td align="left" class="entityImage" style="width: 35%;">
                                    <asp:Label runat="server" Text="<%$Resources:Resource,Zones%>" ID="lbl_grid_head"
                                        CssClass="gridHeadText" Width="100px" ForeColor="#F8F8F8" Font-Names="Arial"
                                        Font-Size="12"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblfacility" runat="server" Text="<%$Resources:Resource,Facility%>"
                                        CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10">:</asp:Label>
                                    <telerik:RadComboBox ID="cmbfacility" runat="server" Width="175px" Filter="Contains"
                                        ViewStateMode="Enabled" OnItemDataBound="cmbfacility_ItemDataBound" AllowCustomText="true"
                                        onkeypress="return tabOnly(event)">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox2" runat="server" Text='<%#Eval("name") %>' />
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;">
                                    <div id="div1" style="width: 200px; background-color: white;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                        Height="100%" EmptyMessage="<%$Resources:Resource,Search%>" BorderColor="White" ID="txt_search" Width="180px">
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
                                <td align="right" style="padding: 4px 6px 0 0;">
                                    <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContent" class="divProperties RightMenu_1_Content">
                        <telerik:RadGrid ID="rg_zone" runat="server" ShowStatusBar="true" Width="100%" AutoGenerateColumns="False"
                            PageSize="7" AllowSorting="True" AllowMultiRowSelection="true" AllowPaging="True"
                            OnDetailTableDataBind="rg_zone_DetailTableDataBind" OnNeedDataSource="rg_zone_NeedDataSource"
                            OnItemCommand="rg_zone_ItemCommand" OnPreRender="rg_zone_PreRender" OnItemDataBound="rg_zone_ItemDataBound">
                            <PagerStyle Mode="NumericPages"></PagerStyle>
                            <ClientSettings>
                                <Selecting AllowRowSelect="true" CellSelectionMode="MultiCell" />
                                <Scrolling AllowScroll="true" ScrollHeight="480" UseStaticHeaders="true" />
                                <ClientEvents OnGridCreated="GridCreated" />
                            </ClientSettings>
                            <MasterTableView DataKeyNames="pk_zone_id" AllowMultiColumnSorting="True" PagerStyle-VerticalAlign="Bottom"
                                PagerStyle-Mode="NextPrevAndNumeric" PagerStyle-AlwaysVisible="true" Width="100%"
                                PageSize="10" AllowPaging="true">
                                <ItemStyle Height="20px" Font-Names="Arial" Font-Size="10" VerticalAlign="Middle" />
                                <AlternatingItemStyle Height="20px" Font-Names="Arial" Font-Size="10" VerticalAlign="Middle" />
                                <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                <FooterStyle Height="23px" Font-Names="Arial" />
                                <Columns>
                                    <%--columns from outermost table--%>
                                    <telerik:GridClientSelectColumn>
                                        <ItemStyle Width="5%" />
                                        <HeaderStyle Width="5%" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridBoundColumn SortExpression="pk_zone_id" HeaderText="pk_zone_id" HeaderButtonType="TextButton"
                                        DataField="pk_zone_id" Visible="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="name" UniqueName="zone_name"
                                        CommandName="Edit" HeaderText="<%$Resources:Resource,Zone_Name%>" SortExpression="zone_name">
                                        <HeaderStyle Width="20%" Wrap="false" />
                                        <ItemStyle Width="20%" Wrap="false" Font-Underline="true" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn SortExpression="name" HeaderText="<%$Resources:Resource,zone_name%>"
                                        HeaderButtonType="TextButton" DataField="name">
                                        <HeaderStyle Width="0%" Wrap="false" />
                                        <ItemStyle Width="0%" Wrap="false" Font-Underline="true" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn SortExpression="Description" HeaderText="<%$Resources:Resource,Description%>"
                                        HeaderButtonType="TextButton" DataField="Description">
                                        <HeaderStyle Width="20%" Wrap="false" />
                                        <ItemStyle Width="20%" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn SortExpression="total_net_area" HeaderText="<%$Resources:Resource, Total_net_area%>"
                                        HeaderButtonType="TextButton" DataField="total_net_area">
                                        <HeaderStyle Width="20%" Wrap="false" />
                                        <ItemStyle Width="20%" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn SortExpression="total_gross_area" HeaderText="<%$Resources:Resource, Total_gross_area%>"
                                        HeaderButtonType="TextButton" DataField="total_gross_area">
                                        <HeaderStyle Width="15%" Wrap="false" />
                                        <ItemStyle Width="15%" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="<%$Resources:Resource, Assign_Space%>"
                                        UniqueName="Assign_Space">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btn_Assign_Space" runat="server" ImageUrl="~/App/Images/Icons/asset_add_sm.png"
                                                CommandName="Assign_space" CausesValidation="false" AlternateText="<%$Resources:Resource, Assign_Space%>" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="10%" HorizontalAlign="Center" />
                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="<%$Resources:Resource,Color%>" UniqueName="color">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btn_color_select" CommandName="color" runat="server" ImageUrl="~/App/Images/Icons/asset_arrow_lg.png" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="10%" HorizontalAlign="Center" />
                                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn SortExpression="color_code" HeaderText="color_code" HeaderButtonType="TextButton"
                                        DataField="color_code" Visible="false">
                                        <HeaderStyle Width="0%" Wrap="false" />
                                        <ItemStyle Width="0%" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn SortExpression="entity_id" HeaderText="entity_id" HeaderButtonType="TextButton"
                                        DataField="entity_id" Visible="false">
                                        <HeaderStyle Width="0%" Wrap="false" />
                                        <ItemStyle Width="0%" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <DetailTables>
                                    <telerik:GridTableView DataKeyNames="space_id" Name="space_id" PagerStyle-VerticalAlign="Bottom"
                                        PagerStyle-Mode="NextPrevAndNumeric" PagerStyle-AlwaysVisible="true" Width="100%"
                                        PageSize="10" AllowPaging="true">
                                        <Columns>
                                            <%--columns from first details view--%>
                                            <telerik:GridBoundColumn SortExpression="space_id" HeaderText="space_id" HeaderButtonType="TextButton"
                                                DataField="space_id" Visible="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="space_name" UniqueName="space_name"
                                                CommandName="Edit_space" HeaderText="<%$Resources:Resource,space_name%>" SortExpression="space_name">
                                                <HeaderStyle Width="20%" Wrap="false" />
                                                <ItemStyle Width="20%" Wrap="false" Font-Underline="true" />
                                            </telerik:GridButtonColumn>
                                            <telerik:GridBoundColumn SortExpression="space_description" HeaderText="<%$Resources:Resource,Description%>"
                                                HeaderButtonType="TextButton" DataField="space_description" UniqueName="space_description">
                                                <HeaderStyle Width="20%" />
                                                <ItemStyle Width="20%" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="floor_name" UniqueName="floor_name"
                                                CommandName="Edit_floor" HeaderText="<%$Resources:Resource,floor_name%>" SortExpression="floor_name">
                                                <HeaderStyle Width="20%" Wrap="false" />
                                                <ItemStyle Width="20%" Wrap="false" Font-Underline="true" />
                                            </telerik:GridButtonColumn>
                                            <telerik:GridBoundColumn SortExpression="floor_id" HeaderText="<%$Resources:Resource,floor_name%>"
                                                HeaderButtonType="TextButton" DataField="floor_id" UniqueName="floor_id" Visible="false">
                                                <HeaderStyle Width="0%" />
                                                <ItemStyle Width="0%" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn SortExpression="net_area" HeaderText="<%$Resources:Resource,Net_area%>"
                                                HeaderButtonType="TextButton" DataField="net_area" UniqueName="net_area">
                                                <HeaderStyle Width="10%" />
                                                <ItemStyle Width="10%" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn SortExpression="gross_area" HeaderText="<%$Resources:Resource,Gross_area%>"
                                                HeaderButtonType="TextButton" DataField="gross_area" UniqueName="gross_area">
                                                <HeaderStyle Width="10%" />
                                                <ItemStyle Width="10%" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="<%$Resources:Resource, Show_Model%>"
                                                UniqueName="bim">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_bim" CommandName="BIM" runat="server" CausesValidation="false"
                                                        AlternateText="<%$Resources:Resource, BIM%>" ImageUrl="~/App/Images/Icons/icon_BIMview_sm.png" />
                                                </ItemTemplate>
                                                <HeaderStyle Width="10%" HorizontalAlign="Center" />
                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="<%$Resources:Resource, Unassign_space%>"
                                                UniqueName="bim">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_Unassign_space" CommandName="Unassign_space" runat="server"
                                                        CausesValidation="false" AlternateText="<%$Resources:Resource, BIM%>" ImageUrl="~/App/Images/Icons/icon-close.png" />
                                                </ItemTemplate>
                                                <HeaderStyle Width="10%" HorizontalAlign="Center" />
                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn SortExpression="fk_facility_id" HeaderText="<%$Resources:Resource,Facility%>"
                                                HeaderButtonType="TextButton" DataField="fk_facility_id" UniqueName="fk_facility_id"
                                                Visible="false">
                                                <HeaderStyle Width="0%" />
                                                <ItemStyle Width="0%" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </telerik:GridTableView>
                                </DetailTables>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td>
                    
                </td>
            </tr>
        </table>
        <div style="display: none">
            <asp:Button ID="btn_navigate" runat="server" OnClick="navigate" />
            <asp:Button ID="btn_assign_spaces" runat="server" OnClick="btn_assign_spaces_Click" />
        </div>
    </asp:Panel>
    <telerik:RadWindowManager Visible="true" ID="rad_window" VisibleStatusbar="false"
        AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server"
        KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_spaces_popup" runat="server" Animation="Slide"
                Behaviors="Move, Resize" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="false"
                AutoSize="false" Width="700" Height="500" VisibleStatusbar="false" VisibleOnPageLoad="false"
                Top="15px" Left="300px" Skin="">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager Visible="true" ID="rad_window_color_picker" VisibleStatusbar="false"
        AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server"
        KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rad_window_color" runat="server" Animation="Slide"
                Behaviors="Move, Resize" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="false"
                AutoSize="false" Width="300" Height="100" VisibleStatusbar="false" VisibleOnPageLoad="false"
                Top="155px" Left="500px" Skin="">
                <ContentTemplate>
                    <table width="100%" style="background-image: url('../Images/asset_zebra-bkgrd_gray2.PNG');
                        padding: 0px; margin: 0px 0px 0px 0px; width: 100%; overflow: hidden;" border="0">
                        <tr>
                            <%-- <td>
                                <telerik:RadColorPicker runat="server" ID="RadColorPicker1" Columns="18" PaletteModes="All"
                                    ShowIcon="true" AccessKey="K" Skin="Metro" Width="250">
                                </telerik:RadColorPicker>
                            </td>
                            <td>
                                <asp:Button runat="server" ID="btn_save" Text="<%$Resources:Resource, Save%>" OnClick="btn_save_Click" />
                            </td>--%>
                        </tr>
                        <tr>
                        </tr>
                    </table>
                </ContentTemplate>
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadToolTip ID="rtip_setting_info" HideEvent="ManualClose" ShowEvent="FromCode"
        OffsetX="-21" OffsetY="50" ShowCallout="false" AutoCloseDelay="50000" RelativeTo="Element"
        TargetControlID="btnSettingsExpand" Position="BottomLeft" Sticky="false" runat="server"
        Width="160px" Skin="" OnClientBeforeShow="adjust_position">
        <div style="border: 1px solid black">
            <table width="100%" style="background-image: url('../Images/asset_zebra-bkgrd_gray2.PNG');
                padding: 0px; margin: 0px 0px 0px 0px; width: 100%; overflow: hidden;" border="0">
                <tr style="width: 100%; height:12px;">
                    <td class="wizardHeadImage" colspan="2">
                        <div class="wizardLeftImage">
                            <asp:Label ID="lbl_classification_details" Text="<%$Resources:Resource,Color %>"
                                Font-Names="Verdana" Font-Size="11pt" runat="server"></asp:Label>
                        </div>
                        <div class="wizardRightImage">
                            <asp:ImageButton ID="img_btn_close_details" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                CausesValidation="false" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadColorPicker runat="server" ID="RadColorPicker1" Columns="18" PaletteModes="All"
                            ShowIcon="true" AccessKey="K" Skin="Metro" Width="250">
                        </telerik:RadColorPicker>
                    </td>
                    <td>
                        <asp:Button runat="server" ID="btn_save" Text="<%$Resources:Resource, Save%>" OnClick="btn_save_Click" />
                    </td>
                </tr>
                <tr>
                </tr>
            </table>
        </div>
    </telerik:RadToolTip>
    <telerik:RadCodeBlock ID="loadPopUp" runat="server">
        <script language="javascript" type="text/javascript">

            function adjust_position(sender, eventArgs) {
                var screen_width = screen.width;
                var screen_hieght = screen.height;
                sender._offsetY = screen_hieght / 3;
                sender._offsetX = screen_width / 3;
            }


            function color_popup1(id, entity_id) {

                document.getElementById("<%= hf_pk_zone_id.ClientID %>").value = id;
                document.getElementById("<%= hf_entity_id.ClientID %>").value = entity_id;

                manager = $find("<%= rad_window_color_picker.ClientID %>");
                var windows = manager.get_windows();
                windows[0].show();
                //windows[0].setUrl(url);

                return false;
            }
            function color_popup(id, entity_id) {
                document.getElementById("<%= hf_pk_zone_id.ClientID %>").value = id;
                document.getElementById("<%= hf_entity_id.ClientID %>").value = entity_id;

                var rtip_setting_info = $find("<%=rtip_setting_info.ClientID %>");
                if (rtip_setting_info != null) {
                    rtip_setting_info.show();
                }
                return false;
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadNotification ID="rd_display_window" runat="server" Width="225" KeepOnMouseOver="true"
        Position="TopCenter" AutoCloseDelay="500000" EnableRoundedCorners="true" EnableShadow="true"
        Skin="Default" OffsetX="-300" OffsetY="75" LoadContentOn="PageLoad" Title="TagNumber/SerialNumber">
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
                    <telerik:AjaxUpdatedControl ControlID="rg_zone" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_zone" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rg_zone">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_zone" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_assign_spaces">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_zone" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_save">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btn_save" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="rg_zone" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
        <%--<img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />--%>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
