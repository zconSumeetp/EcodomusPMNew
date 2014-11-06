<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="System.aspx.cs" Inherits="App_Asset_System" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="../UserControls/UCComboFacility.ascx" TagName="UserControlComboFacility"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 
    <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
    <script type="text/javascript" language="javascript">

        function resize_Nice_Scroll() {
             if (document.getElementById("<%=txtcriteria.ClientID %>") != null)
             document.getElementById("<%=txtcriteria.ClientID %>").focus();
        }


        function body_load() {
          var screenhtg = set_NiceScrollToPanel();
        if (document.getElementById("<%=txtcriteria.ClientID %>") != null)
            document.getElementById("<%=txtcriteria.ClientID %>").focus();
        }

        window.onload = body_load;

        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {
            //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
            var pageSize = document.getElementById("ContentPlaceHolder1_hfSystemPMPageSize").value;
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
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }
            function Clear() {
                try {

                    document.getElementById("ContentPlaceHolder1_txtcriteria").value = "";
                    document.getElementById("<%=txtcriteria.ClientID %>").focus();
                    return false;
                }
                catch (e) {
                    alert(e.message + "  " + e.Number);
                    return false;
                }
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

            function checkboxClick(sender) {

                collectSelectedItems(sender);
                document.getElementById('ContentPlaceHolder1_btn_refresh').click();
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
                }  //for closed

                selectedItemsTexts = selectedItemsTexts.substring(0, selectedItemsTexts.length - 2);
                selectedItemsValues = selectedItemsValues.substring(0, selectedItemsValues.length - 2);

                //Set the text of the RadComboBox with the texts of the selected Items, separated by ','.
                combo.set_text(selectedItemsTexts);

                //Set the comboValue hidden field value with values of the selected Items, separated by ','.

                if (selectedItemsValues == "") {
                    combo.clearSelection();
                }
                //document.getElementById('ContentPlaceHolder1_hfFacilityid').value = selectedItemsValues;   
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


            function gotoPage(id) {
                document.getElementById('ContentPlaceHolder1_hf_facility_id').value = id;
                document.getElementById('ContentPlaceHolder1_btn_navigate').click();
            }



            function validate() {
                alert("Please select atleast one system.");
                return false;
            }
            function ProjectValidation() {

                alert('Please select Project');
                window.location = '../Settings/Project.aspx';
                return false;

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
        </script>
        
        <script language="javascript" type="text/javascript">
            function confirmation() {

                var RadGrid1 = $find("<%=rgSystems.ClientID %>");
                var masterTable = $find("<%= rgSystems.ClientID %>").get_masterTableView();
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
                    flag = confirm("Do you want to delete this system?");
                    return flag;
                    //return true;
                }
                else {
                    alert("Please select system");
                    return false;

                }


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
    <asp:Panel ID="pnlSystemsId" runat="server" DefaultButton="btn_search" >
        <table  width="100%" style="table-layout:fixed;">
         <tr>
              <td class="topbuttons">
                   
                <asp:Button ID="btnAddSystem" runat="server" Text="<%$Resources:Resource, Add_System%>"
                                    Width="90px" Skin="Hay" OnClick="btnAddSystem_Click" />
                <asp:Button ID="btnDelete" runat="server" Text="<%$Resources:Resource, Delete%>"
                                    Width="90px" OnClick="btnDelete_Click" OnClientClick="if (!confirmation()) return false;" />
                         
                </td>
            </tr>
        
         <tr>
            <td  style="display:none;">
                <table>
                    <tr>
                        <td style="padding-top: 0px; display: none" align="left">
                            <asp:HiddenField ID="hfSystemPMPageSize" runat="server" Value="" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

         <tr>
           <td  class="centerAlign">
                 <div class="rpbItemHeader divBorder">
                     <table cellpadding="0" cellspacing="0" width="100%" style="background-color:#808080;">
                        <tr>
                            <td align="left" class="entityImage"  style="width:35%;">
                             <asp:Label runat="server" Text="<%$Resources:Resource,Systems%>" ID="lbl_grid_head"
                                                        CssClass="gridHeadText" Width="100px" ForeColor="#F8F8F8" Font-Names="Arial"
                                   Font-Size="12"></asp:Label>
                            </td>
                            <td >
                                                    <asp:Label ID="lblFacility" runat="server" Text="<%$Resources:Resource,Facility%>"
                                                        CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10">:</asp:Label>
                                                    <telerik:RadComboBox Width="170px" ID="cmbfacility" Filter="Contains" runat="server"
                                                        oncopy="return false;" AllowCustomText="True" onpaste="return false;" oncut="return false;"
                                                        onkeypress="return tabOnly(event)" onmousewheel="return false" OnItemDataBound="cmbfacility_ItemDataBound">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked="true" Text='<%# Eval("name") %>' />
                                                        </ItemTemplate>
                                 </telerik:RadComboBox>
                                              
                            </td>
                         <td align="right" style=" background-color:#808080;padding-top: 02px; padding-bottom: 02px;" >
                                <div id="div1" style="width: 200px; background-color: white;" >
                                    
                                    <table>
                                        <tr>
                                            <td>
                                            <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtcriteria" Width="180px">
                                                                    </telerik:RadTextBox>
                                            </td>
                                            <td>
                                            <asp:ImageButton ClientIDMode="Static" ID="btn_search"  runat="server"
                                                    ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnsearch_Click" />
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
                   <telerik:RadGrid ID="rgSystems" runat="server" AllowPaging="True" AllowCustomPaging="true"
                       BorderWidth="1px" AutoGenerateColumns="false" AllowSorting="True" PagerStyle-AlwaysVisible="true"
                       PageSize="10" GridLines="None" OnItemCommand="rgSystems_ItemCommand" OnItemDataBound='rgSystems_OnItemDataBound'
                       OnPageSizeChanged="rgSystems_PageSizeChanged" OnSortCommand='rgSystems_sortCommand'
                       OnPageIndexChanged="rgSystems_PageIndexChanged" OnItemEvent='rgSystems_OnItemEvent'
                       AllowMultiRowSelection="true" Skin="Default" ItemStyle-Wrap="false">
                       <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                       <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                           <Selecting AllowRowSelect="true" />
                           <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                           <ClientEvents OnGridCreated="GridCreated" />
                       </ClientSettings>
                       <MasterTableView ClientDataKeyNames="SystemsId" DataKeyNames="SystemsId">
                           <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                           <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                           <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                           <FooterStyle Height="25px" Font-Names="Arial" />
                           <Columns>
                               <telerik:GridBoundColumn DataField="SystemsId" Visible="false">
                                   <ItemStyle  Width="10%" />
                               </telerik:GridBoundColumn>
                               <telerik:GridClientSelectColumn>
                                   <ItemStyle Width="5%" />
                                   <HeaderStyle Width="5%" />
                               </telerik:GridClientSelectColumn>
                               <telerik:GridTemplateColumn DataField="SystemName" UniqueName="name" HeaderText="<%$Resources:Resource, System_Name%>"
                                   SortExpression="SystemName">
                                   <HeaderStyle  Width="30%" Wrap="false" />
                                   <ItemStyle  Width="30%" Wrap="false" />
                                   <ItemTemplate>
                                       <asp:LinkButton ID="lnkbtnName" CommandName="Systemprofile" Text='<%# DataBinder.Eval(Container.DataItem,"SystemName")%>'
                                           runat="server"></asp:LinkButton>
                                   </ItemTemplate>
                               </telerik:GridTemplateColumn>
                               <telerik:GridBoundColumn DataField="OmniClass" HeaderText="<%$Resources:Resource, Category%>"
                                   UniqueName="OmniClass" Visible="true" SortExpression="OmniClass">
                                   <HeaderStyle Width="30%" Wrap="false" />
                                   <ItemStyle  Width="30%" Wrap="false"/>
                               </telerik:GridBoundColumn>
                               <telerik:GridBoundColumn DataField="uniclass" HeaderText="<%$Resources:Resource, Category%>"
                                   UniqueName="uniclass" Visible="true" SortExpression="uniclass">
                                   <HeaderStyle  Width="30%" Wrap="false"/>
                                   <ItemStyle   Width="30%" Wrap="false" />
                               </telerik:GridBoundColumn>
                               <%--<telerik:GridBoundColumn DataField="FacilityName" HeaderText="<%$Resources:Resource, Facility%>" UniqueName="FacilityName"
                                Visible="true" SortExpression="FacilityName">
                                <ItemStyle  Width="30%" />
                            </telerik:GridBoundColumn>--%>
                               <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource, Description%>"
                                   UniqueName="description" Visible="true" SortExpression="description">
                                   <HeaderStyle  Width="30%" Wrap="false" />
                                   <ItemStyle   Width="30%" Wrap="false"/>
                               </telerik:GridBoundColumn>
                           </Columns>
                       </MasterTableView>
                   </telerik:RadGrid>
               </div>
                                                       
                </td>
            </tr>
          
            
        </table>
            </asp:Panel>
        <div style="display: none">
            <asp:Button ID="btn_refresh" runat="server" OnClick="refresh" />
        </div>

    <telerik:RadAjaxManagerProxy ID="radAjaxManager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgSystems">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgSystems" />
                    <telerik:AjaxUpdatedControl ControlID="txtcriteria" />
                    <telerik:AjaxUpdatedControl ControlID="btnsearch" />
                    <telerik:AjaxUpdatedControl ControlID="FacilityUserControlComboFacility" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnDelete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgSystems" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btn_search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgSystems"  LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgSystems">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgSystems" LoadingPanelID="RadAjaxLoadingPanel1"/>
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
                    <telerik:AjaxUpdatedControl ControlID="FacilityUserControlComboFacility" />
                    <telerik:AjaxUpdatedControl ControlID="rgSystems" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server" Height="75px"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
    <div style="display: none">
        <asp:Button ID="btn_navigate" runat="server" OnClick="navigate" />
    </div>
    <asp:HiddenField ID="hf_facility_id" runat="server" />
    <asp:HiddenField ID="hf_system_id" runat="server" />
    <asp:HiddenField ID="hf_count" runat="server" />
    <asp:HiddenField ID="hf_uniclass" runat="server" />
</asp:Content>
