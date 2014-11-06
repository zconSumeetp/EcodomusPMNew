<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ComponentPM.aspx.cs" Inherits="App_Asset_ComponentPM"
    MasterPageFile="~/App/EcoDomus_PM_New.master"%> 
<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
--%> <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> <%@ Register TagPrefix="asp" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2012.1.411.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
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
         
        .column
        {
            font-size: 13px;
            font-family: Arial;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .column > a
        {
            width: 100%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;        
        }

        .header-cell
        {
            border-left: 1px solid #808080 !important;
        }

        .first-column {
            border-left: none;
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
      
            
    </style>    
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" language="javascript">

            function stopPropagation(e) { 

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            function chkgrid() {
                var s1 = $find("<%=rgasset.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();

                if (selectedRows.length != 0) {

                    return true;
                }
                else {
                    alert('Please select atleast one component');
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
            function resize_Nice_Scroll() {
                set_NiceScrollToPanel();
                if (document.getElementById("<%=txtcriteria.ClientID %>") != null)
                    document.getElementById("<%=txtcriteria.ClientID %>").focus();
            }
            function body_load() {
                var screenhtg = set_NiceScrollToPanel();
                if (document.getElementById("<%=txtcriteria.ClientID %>") != null)
                 document.getElementById("<%=txtcriteria.ClientID %>").focus();
            }

             //This Function set scroll Height to fix when docheight is less than scrollHeight
             function GridCreated(sender, args) {
                 //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
                 var pageSize = document.getElementById("ContentPlaceHolder1_hfCompPMPageSize").value;
                 var scrollArea = sender.GridDataDiv;
                 var dataHeight = sender.get_masterTableView().get_element().clientHeight;

                 if (dataHeight < parseInt(pageSize) * 40) {
                     scrollArea.style.height = dataHeight + "px";
                 }
                 else {
                     scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
                 }
                
             }
            window.onload = body_load;
            

        </script>
        <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">


            function disp() {
                var notification = $find("<%=rd_display_window.ClientID %>");
                notification.show();
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
            function Clear() {
                try {
                    document.getElementById("<%=txtcriteria.ClientID %>").value = "";
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
            function ProjectValidation() {

                alert('Please select Project');
                window.location = '../Settings/Project.aspx';
                return false;

            }

            function gotoPage(id, pagename) {
                
                var url;
                if (pagename == "Asset") {
                    url = "AssetMenu.aspx?assetid=" + id;  //+ "&pagevalue=AssetProfile";
                }
                else
                    if (pagename == "Type") {
                        url = "TypeProfileMenu.aspx?type_id=" + id;
                        //alert("Page Under Construction");
                    }
                    else if (pagename == "Facility") {
                        url = "../Locations/FacilityMenu.aspx?IsFromFacility=Y&FacilityId=" + id;

                    }
                    else if (pagename == "System") {
                        url = "SystemMenu.aspx?system_id=" + id;

                    }
                    else if (pagename == "Space") {
                        url = "../Locations/FacilityMenu.aspx?IsFromSpace=Y&pagevalue=Space Profile&id=" + id;

                    }

                window.location.href(url);
            }

            function OnClientDropDownClosing(sender, eventArgs) {
                eventArgs.set_cancel(false);
            }

            function deleteLocation() {

                var RadGrid1 = $find("<%=rgasset.ClientID %>");
                var masterTable = $find("<%= rgasset.ClientID %>").get_masterTableView();
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
                    flag = confirm("Do you want to delete this component?");
                    return flag;
                    //return true;
                }
                else {
                    alert("Please select component");
                    return false;

                }


            }

            function refreshgrid(name) {

                document.getElementById("<%=txtcriteria.ClientID %>").value = name;
                document.getElementById("ContentPlaceHolder1_btn_refresh").click();


            }


            function checkboxClick(sender) {

                collectSelectedItems(sender);
                document.getElementById('ContentPlaceHolder1_btn_navigate').click();

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

            function oponUpdateNamesPopup() {

                var s1 = $find("<%=rgasset.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                var s2 = "";
                if (document.getElementById("<%=hf_component_id.ClientID%>").value != "") {

                    s = document.getElementById("<%=hf_component_id.ClientID%>").value + ",";

                }
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("Assetid") + ",";
                    s2 = s2 + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("Assetid") + ",";
                }

                if (s == "") {
                    alert("Please select component");
                    return false;
                }
                else {

                    manager = $find("<%=rd_manager1.ClientID%>");
                    if (document.getElementById("<%=hf_component_id.ClientID%>").value != "") {

                        var url = "../Asset/UpdateComponentNames.aspx?Component_id=" + s;
                    }
                    else {
                        var url = "../Asset/UpdateComponentNames.aspx?Component_id=" + s2;
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
            function ShowFullEntityName(lblEntityName) {

                var lblEntityNameId = lblEntityName.id;
                var hfId = lblEntityNameId.replace("lblEntityNames", "hfEntityNamesFull");
                var tooltip = $find("<%=RadToolTip1.ClientID %>");

                tooltip.set_targetControlID(lblEntityNameId);
                tooltip.set_text(document.getElementById(hfId).value);
                window.setTimeout(function () {
                    tooltip.show();
                }, 100);
            }
             
            function HideTooltip() {
                var tooltip = Telerik.Web.UI.RadToolTip.getCurrent();
                if (tooltip) tooltip.hide();
            }
            function navigate_facilitybarcode(selectedtab, facilityId) {
                var url = "../Locations/FacilityMenu.aspx?Facilityid=" + facilityId + "&entity_name=Facility&profileflag=new&IsFromFacility=Y&selectedtab=" + selectedtab;
                // http: //localhost:50087/EcoDomusPM/App/Locations/FacilityMenu.aspx?FacilityId=1019b183-6d3a-40e7-824b-627c68a87804&FacilityName=Building%20USC&profileflag=new&IsFromFacility=Y
                window.location.href(url);
            }
            function Configurefacility() {

                alert("Barcode is not configured");
                

            }
        </script>
</telerik:RadCodeBlock>
       <telerik:RadToolTip runat="server" ID="RadToolTip1" HideEvent="ManualClose" ShowEvent="FromCode"
        RelativeTo="Element" Sticky="true" Skin="Default" Width="200px">
    </telerik:RadToolTip>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    
    <asp:Panel ID="pnlComponentsId" runat="server" DefaultButton="btn_search" >
    <table width="100%" style="font-family: Arial, Helvetica, sans-serif; table-layout: fixed;
        border-bottom-style: none; border-bottom-width: 0px; width: 100%; overflow: hidden;">
        <tr>
            <td style="height: 25px;padding-bottom:0px;padding-left:02px;width: 100%;">
            <asp:Button ID="btnaddcomponent" runat="server" Width="110px"  Text="<%$Resources:Resource,Add_Component%>"
                    OnClick="btnaddcomponent_Click" />
               <asp:Button ID="btn_display_column" runat="server" Width="110px" Text=" <%$Resources:Resource,Display_Columns%>"
                    OnClientClick="javascript:return disp();" />
               
               
                <asp:Button ID="btnGenerateBarcode" runat="server" Text="<%$Resources:Resource,Generate_Barcode%>"
                    Width="110px" Skin="Default" OnClientClick="javascript:return chkgrid();" OnClick="btnGenerateBarcode_Click" />
               
                <asp:Button ID="btnUpdateNames" runat="server" Text="<%$Resources:Resource,Update_Names%>"
                    OnClientClick="javascript:return oponUpdateNamesPopup();" Width="110px" Skin="Default" />
                 
                <asp:Button ID="btnDelete" runat="server" Text="<%$Resources:Resource,Delete%>" OnClientClick="javascript:return deleteLocation();"
                    OnClick="btnDelete_click" Width="100px" Skin="Default" />
            </td>
        </tr>

        <tr>
       <td style="padding-top:0px;display:none" align="left">
      <table >
         <tr>
            <td>
                <asp:HiddenField ID="hfFacilityid" runat="server" />
                <asp:HiddenField ID="hfCompPMPageSize"  runat="server" Value="" />
            </td>
        </tr>
    </table>
            </td>
        </tr>
        <tr>
            <td colspan="6" class="centerAlign" >
                  <div class="rpbItemHeader">
                      <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                          <tr>
                              <td align="left" class="entityImage" style="width: 35%;">
                                  <asp:Label runat="server" Text="Components" ID="lbl_grid_head" CssClass="gridHeadText"
                                      Width="250px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                              </td>
                              <td>
                                  <asp:Label ID="lblfacility" runat="server" Text="<%$Resources:Resource,Facility%>"
                                      CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10"></asp:Label>
                                      <asp:Label runat="server" Text=":" ID="Label1" CssClass="gridHeadText"
                                     ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                  <telerik:RadComboBox Width="170px" ID="cmbfacility" Filter="Contains" runat="server"
                                      ViewStateMode="Enabled" OnItemDataBound="cmbfacility_ItemDataBound" AllowCustomText="True"
                                      onkeypress="return tabOnly(event)" onmousewheel="return false">
                                      <ItemTemplate>
                                          <asp:CheckBox ID="CheckBox1" runat="server" Text='<%# Eval("name") %>' />
                                      </ItemTemplate>
                                  </telerik:RadComboBox>
                              </td>
                              <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;">
                                  <div id="div_search" style="width: 200px; background-color: white;">
                                      <table>
                                          <tr>
                                              <td>
                                                  <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                      Height="100%" EmptyMessage="Search"  BorderColor="White" ID="txtcriteria" Width="180px">
                                                  </telerik:RadTextBox>
                                              </td>
                                              <td>
                                                  <asp:ImageButton ClientIDMode="Static" ID="btn_search" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                      OnClick="btnsearch_Click" />
                                              </td>
                                          </tr>
                                      </table>
                                  </div>
                              </td>
                              <td align="right" style="padding: 4px 6px 0 0;">
                              </td>
                          </tr>
                      </table>
                </div>
                <div id="divSelectedDomponentContent" style="height:100%;"  class="divProperties RightMenu_1_Content">
                      <telerik:RadGrid runat="server" ID="rgasset" BorderWidth="1px" AllowPaging="true"
                          ItemStyle-Wrap="false" AllowCustomPaging="true" AutoGenerateColumns="False" AllowSorting="True"
                          PagerStyle-AlwaysVisible="false" Visible="false" AllowMultiRowSelection="true" OnItemCreated="rgassets_OnItemCreated"
                          Skin="Default" OnItemCommand="rgasset_ItemCommand" OnItemDataBound="rgasset_OnItemDataBound"
                          OnItemEvent="rgasset_OnItemEvent" OnNeedDataSource="rgasset_NeedDataSource" OnPageIndexChanged="rgasset_PageIndexChanged"
                          OnPageSizeChanged="rgasset_PageSizeChanged" OnSortCommand="rgasset_SortCommand">
                          <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="true" />
                          <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                              <Selecting AllowRowSelect="true" />
                              <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400"  />
                              <ClientEvents OnGridCreated="GridCreated" />
                              <Resizing AllowColumnResize="True" ClipCellContentOnResize="True" EnableRealTimeResize="True" ResizeGridOnColumnResize="False" />
                              <ClientMessages ColumnResizeTooltipFormatString="" />
                          </ClientSettings>
                          <MasterTableView DataKeyNames="Assetid" ClientDataKeyNames="Assetid" TableLayout="Fixed">
                            <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10" Wrap="False" />
                            <AlternatingItemStyle Height="31px"  Font-Names="Arial" Font-Size="10" />
                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" CssClass="header-cell" />
                            <FooterStyle Height="25px" Font-Names="Arial"/>
                              <Columns>
                                  <telerik:GridBoundColumn DataField="Assetid" HeaderText="AssetId" UniqueName="AssetId"
                                      Visible="false" SortExpression="Assetid">
                                  </telerik:GridBoundColumn>
                                  <telerik:GridClientSelectColumn UniqueName="chkSelect" Resizable="False">
                                      <ItemStyle Width="28px" Wrap="false" HorizontalAlign="Center" />
                                      <HeaderStyle Width="28px" Wrap="false" CssClass="first-column" HorizontalAlign="Center" />
                                  </telerik:GridClientSelectColumn>
                                  <telerik:GridBoundColumn DataField="linkasset" HeaderText="<%$Resources:Resource,Component_Name%>"
                                      UniqueName="linkasset" SortExpression="Asset_Name">
                                      <HeaderStyle Wrap="true" /> 
                                      <ItemStyle Wrap="false" CssClass="column" /> 
                                  </telerik:GridBoundColumn>
                                  <telerik:GridBoundColumn DataField="Space_Name" HeaderText="<%$Resources:Resource,Location%>"
                                      UniqueName="Location" SortExpression="Space_Name_ipad">
                                      <HeaderStyle Wrap="true" /> 
                                      <ItemStyle Wrap="false" CssClass="column" /> 
                                  </telerik:GridBoundColumn>
                                  
                                  

                                  <telerik:GridBoundColumn DataField="Asset_Description" HeaderText="<%$Resources:Resource,Description%>"
                                UniqueName="Description" SortExpression="Asset_Description" DataFormatString="<nobr>{0}</nobr>">
                                      <HeaderStyle Wrap="true" /> 
                                      <ItemStyle Wrap="false" CssClass="column" /> 
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn DataField="linktype" HeaderText="<%$Resources:Resource,Type%>"
                                      UniqueName="linktype" SortExpression="Type_Name">
                                      <HeaderStyle /> 
                                      <ItemStyle Wrap="false" CssClass="column" /> 
                                  </telerik:GridBoundColumn>
                                  <telerik:GridBoundColumn DataField="System_Name" HeaderText="<%$Resources:Resource,System%>"
                                      UniqueName="System" SortExpression="System_Name_iPad" DataFormatString="<nobr>{0}</nobr>">
                                     <HeaderStyle Wrap="true" /> 
                                     <ItemStyle Wrap="false" CssClass="column" /> 
                                  </telerik:GridBoundColumn>
                                  <telerik:GridBoundColumn DataField="linkfacility" HeaderText="<%$Resources:Resource,Facility%>"
                                      UniqueName="Location" SortExpression="Facility_Name" Visible="false">
                                      <HeaderStyle /> 
                                      <ItemStyle Wrap="false" CssClass="column" /> 
                                  </telerik:GridBoundColumn>
                                  <telerik:GridBoundColumn DataField="Tagnumber" HeaderText="<%$Resources:Resource,Tag_Number%>"
                                      UniqueName="Tagnumber">
                                      <HeaderStyle Wrap="false" /> 
                                      <ItemStyle Wrap="false" CssClass="column" /> 
                                  </telerik:GridBoundColumn>
                                  <telerik:GridBoundColumn DataField="SerialNumber" HeaderText="<%$Resources:Resource,Serial_Number%>"
                                      UniqueName="SerialNumber">
                                      <HeaderStyle Wrap="false" /> 
                                      <ItemStyle Wrap="false" CssClass="column" /> 
                                  </telerik:GridBoundColumn>
                                  <telerik:GridBoundColumn DataField="Status" HeaderText="Linked To BIM" Visible="true"
                                      UniqueName="LinkToBIM">
                                      <HeaderStyle Wrap="false" /> 
                                      <ItemStyle Wrap="false" CssClass="column" /> 
                                  </telerik:GridBoundColumn>
                              </Columns>
                          </MasterTableView>
                      </telerik:RadGrid>
                   </div>

               </td>
        </tr>
        <tr style="display: none;">
            <td style="width: 236px">
                <asp:Label ID="lblfacility1" runat="server" Text="<%$Resources:Resource,Facility%>"
                    CssClass="Label"></asp:Label>:
            
            </td>
            <td style="display: none;">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnsearch" runat="server" Text="<%$Resources:Resource,Search%>"
                                Width="90px" Skin="Default" OnClick="btnsearch_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnclear" runat="server" Text="<%$Resources:Resource,Clear%>" Width="90px"
                                UseSubmitBehavior="false" Skin="Default" OnClientClick="javascript:return Clear();" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
         
    </table>
        
    </asp:Panel>
    <telerik:RadNotification ID="rd_display_window" runat="server" Width="225" KeepOnMouseOver="true"
        Position="TopCenter" AutoCloseDelay="500000" EnableRoundedCorners="true" EnableShadow="true"
        Skin="Default" OffsetX="-300" OffsetY="75" LoadContentOn="PageLoad" Title="TagNumber/SerialNumber">
        <ContentTemplate>
            <asp:Panel ID="panel_bar" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_tagNo" runat="server" Text="<%$Resources:Resource,Tag_Number%>"
                                AutoPostBack="true" OnCheckedChanged="chk_tagNo_click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_serialNo" runat="server" Text="<%$Resources:Resource,Serial_Number%>"
                                AutoPostBack="true" OnCheckedChanged="chk_serialNo_click" />
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <asp:CheckBox ID="chk_LinkToBIM" runat="server" Text="Linked To BIM"
                                AutoPostBack="true" OnCheckedChanged="chk_LinkToBIM_click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </ContentTemplate>
    </telerik:RadNotification>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="chk_tagNo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chk_serialNo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgasset">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_refresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chk_LinkToBIM">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btn_search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1"  Skin="Default" runat="server" Height="50px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="rd_manager1" runat="server"  VisibleTitlebar="true"  Title="Update Component Name" Behaviors="Close,Move" 
        BorderWidth="0px"  Skin="Simple" BorderStyle="None" >
        <Windows>
            <telerik:RadWindow ID="RadWindow3" runat="server" 
                ReloadOnShow="false"  AutoSize="false" Width="400px" Height="130px"
                VisibleStatusbar="false" VisibleOnPageLoad="false" BorderWidth="0px"  EnableShadow="true" BackColor="#EEEEEE" >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <div style="display: none">
        <asp:Button ID="btn_navigate" runat="server" OnClick="navigate" />
        <asp:Button ID="btn_refresh" runat="server" OnClick="btn_refresh_click" />
    </div>
    <asp:HiddenField ID="hfAssetId" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:HiddenField ID="hf_component_id" runat="server" />
            <asp:HiddenField ID="hfcount" runat="server" />
            <asp:HiddenField ID="hfSelectedFacilities" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
