<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="TypeProfileNew.aspx.cs"
    Inherits="App_Asset_TypeProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function CancelWindow() {
                window.close();
            }

            function GoToTypeProfile() {
                var url = "../Asset/TypeProfileMenu.aspx?type_id=" + document.getElementById("hf_type_id").value;
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
                //document.getElementById('ContentPlaceHolder1_btn_navigate').click();
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
                document.getElementById('hf_facility_id').value = selectedItemsValues;
            }

            function ValidateFacility() {

                if (document.getElementById('btnEdit').value == "Save") {
                    var temp = document.getElementById('hfselectedId').value;
                    if (temp == "") {
                        alert("Please select facility!");
                        return false;
                    }
                    if (document.getElementById("txtName").value == "") {
                        alert("Please give type name!");
                        return false;

                    }
                }
                else {
                    return true;
                }
            }

            function product_info() {
                document.getElementById("btnSetProductData").click();
            }


            function Navigate() {
                if (document.getElementById('hf_type_id').value == '00000000-0000-0000-0000-000000000000') {
                    top.location.href = 'TypePM.aspx';
                }
                else {
                    if (document.getElementById('btnEdit') == null) {
                        var query = parent.location.search.substring(1);
                        var flag = query.split("=");
                        var reg = new RegExp(flag[1], 'g');
                        var str = window.parent.location.href;
                        str = str.replace(reg, document.getElementById('hf_type_id').value);
                        window.parent.location.href = str;
                    }
                    else {
                        top.location.href = 'TypePM.aspx';
                    }
                }

            }


            function btnAddByModelNumber_click() {
                var url = "../Asset/AddModelNumber.aspx?organization_id=00000000-0000-0000-0000-000000000000";
                manager = $find("<%= radWindowMgrAddModelNumber.ClientID%>");
                //if (manager != null) {
                var windows = manager.get_windows();
                var intWidth = document.body.clientWidth;
                windows[0]._left = parseInt(intWidth * (0.2));
                windows[0]._width = parseInt(intWidth * 0.6);
                var intHeight = document.body.clientHeight;
                windows[0]._top = 50;
                windows[0]._height = "600";
                //parseInt(intHeight * 0.75);
                windows[0].setUrl(url);
                windows[0].show();
                // }
                //windows[0].set_modal(false);
                return false;
            }

            function btnBrowseByManufacturer_click() {
                //var url = "../Asset/AddModelNumber.aspx?organization_id=" + document.getElementById('hf_man_org_id').value;
                var url = "../Asset/AddModelNumber.aspx?organization_id=00000000-0000-0000-0000-000000000000";
                manager = $find("<%= radWindowMgrAddModelNumber.ClientID%>");
                if (manager != null) {
                    var windows = manager.get_windows();
                    var intWidth = document.body.clientWidth;
                    windows[0]._left = parseInt(intWidth * (0.2));
                    windows[0]._width = parseInt(intWidth * 0.6);
                    var intHeight = document.body.clientHeight;
                    windows[0]._top = 50;
                    windows[0]._height = "600";
                    // parseInt(intHeight * 0.75);
                    windows[0].setUrl(url);
                    windows[0].show();
                }
                //windows[0].set_modal(false);
                return false;
            }

            

            function NavigateToFacilityProfile(facility_id) {

                top.location.href = "../Locations/FacilityMenu.aspx?FacilityId=" + facility_id;
                //parent.window.location.href=("../Locations/FacilityMenu.aspx?FacilityId=" + facility_id, false);
            }
            function load_omni_class(name, id) {

                document.getElementById("hf_lblOmniClassid").value = id;
                var reg = new RegExp('&nbsp;', 'g');
                name = name.replace(reg, ' ');
                document.getElementById("lblOmniClass").innerText = name;
                document.getElementById("hfOmniClassName").innerText = name;
            }

            function load_manufacturer(name, id) {
                document.getElementById("hf_man_org_id").value = id;
                var reg = new RegExp('&nbsp;', 'g');
                name = name.replace(reg, ' ');
                // document.getElementById("lblmanufacturer").innerText = name;
                document.getElementById("hf_manufaturer_selected_name").value = name;
                document.getElementById("btnFillGurantorDropdown").click();

            }
            function openpopupaddomniclasslinkup() {
                manager = $find("rad_windowmgr");
                var url;
                var url = "../Locations/AssignOmniclass.aspx?Item_type=type";

                if (manager != null) {
                    var windows = manager.get_windows();
                    //               
                    windows[0].setUrl(url);
                    windows[0].show();
                    //windows[0].set_modal(false);
                    // windows[0].center();
                }
                return false;
            }

            function openpopupEditMasterFormat() {
                manager = $find("RadWindowManager_masterformat");
                var url;
                var type_id;
                type_id = document.getElementById("hf_type_id").value;
                var url = "../Asset/EditMasterFormatUniFormat.aspx?type_id=" + type_id + "";
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                    //windows[0].set_modal(false);
                }
                return false;
            }

            function openpopupEditDesigner() {
                manager = $find("RadWindowManager_designer");
                var url;
                var type_id;
                type_id = document.getElementById("hf_type_id").value;
                var url = "../Asset/EditDesignerContractor.aspx?type_id=" + type_id + "";
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                    //windows[0].set_modal(false);
                }
                return false;
            }
            function openpopupEditContractor() {
                manager = $find("RadWindowManager_contractor");
                var url;
                var type_id;
                type_id = document.getElementById("hf_type_id").value;
                var url = "../Asset/EditDesignerContractor.aspx?type_id=" + type_id + "";
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                    //windows[0].set_modal(false);
                }
                return false;
            }

            function delete_() {
                var flag;
                flag = confirm("Are you sure you want to delete?");
                return flag;
            }



            function openpopupSelectManufacturer() {
                manager = $find("rad_windowmgr");
                //debugger
                var url;
                var url = "../Asset/AddSelectManufacturerpopup.aspx";
                if (manager != null) {
                    var windows = manager.get_windows();

                    windows[0].setUrl(url);
                    windows[0].show();
                    //windows[0].set_modal(false);
                    //windows[2].center();
                }
                return false;


            }

            function openpopupSelectFacility() {
               manager = $find("rad_windowmgr");
                var url;
                var url = "../Asset/SelectFacilityPopup.aspx";

                if (manager != null) {
                    var windows = manager.get_windows();

                    windows[0].setUrl(url);
                    windows[0].show();
                    //windows[0].set_modal(false);
                    //windows[2].center();
                }
                return false;
            }

            function RefreshParent() {
                //             var query = parent.location.search.substring(1);
                //             var flag = query.split("=");
                //             //var flag = vars[0].split("=");
                //             // alert(window.parent.location.href);
                //             var reg = new RegExp(flag[1], 'g');
                //             var str = window.parent.location.href;
                //             str = str.replace(reg, document.getElementById('str_qry').value);

                str = str = '../Asset/TypeProfileMenu.aspx?type_id=' + document.getElementById('hf_type_id').value + "&page_load=TypeProfile";
                window.parent.location.href = str;
            }

            //This function returns rad window instance to resize it popup
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

           function resizeReverse(){
                 window.document.clear();
                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    wnd.set_height(document.body.scrollHeight + 10);
                   // wnd.set_width(document.body.scrollWidth + 160);
                }
            }

            function RefreshParentpopup() {
                
                str = str = "../Asset/TypeProfile.aspx?type_id=" + document.getElementById('hf_type_id').value + "&page_load=TypeProfile&popupflag=popup&value=type";
                window.location.href = str;
                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    wnd.set_height(document.body.scrollHeight + 110);
                    wnd.set_width(document.body.scrollWidth + 160);
                }
                //window.resizeTo(700, 400);
                //window.parent.resizeTo(800,500);
            }


            function refreshgrid() {

            }

            function buttoncallback_Type() {
                document.getElementById("btnselect1").click();
            }
            function naviagatetoProject() {
                top.location.href = "TypePM.aspx";

            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }
            function closewindow() {
                window.close();
            }

        </script>
    </telerik:RadCodeBlock>
     <style type="text/css">
   th {
	    font-size: 12px;
	    font-weight: lighter;
	    color:#000000;
	     
	    font-family:Arial;
	 }
	 td{
	     font-size : 12px;
	     font-weight : lighter;
	     color: #000000;
	     padding-left: 0px;
	     font-weight:bolder;
	     font-family: Arial ;
	     vertical-align:top;
	     text-align:left;
	     table-layout:fixed;
	 }
	
	 .lblTextCss
	 {
	     font-size: 12px;
	     font-weight:normal;
	     font-family:Arial;
	 }
	.wpr {
            width: 2%;
            overflow: hidden;
            display:block;
            white-space: nowrap;
            border: 1px solid black;
            
       }
	    .buttonstyle
	    {
	        background-color:Black;
	    }
	
	
	 .widthTh
	 {
	     width:11px;
	 }
    </style>

</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG');padding: 0px; margin: 0px 0px 0px 0px;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdftype" runat="server" Skin="Default" CssClass="buttonstyle" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div id="divProfilePage" runat="server"  style="padding:2px;">
        <table runat="server" id="tbltitle" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;display:none;">
        <tr>
            <td class="wizardHeadImage" style="display:none;" >
                <div class="wizardLeftImage">
                     <asp:Label ID="lblpopup" runat="server" Font-Size="Medium" Text="<%$Resources:Resource,Type_Profile%>">:</asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                         OnClientClick="javascript:return CancelWindow();" />
                </div>
            </td>
        </tr>
    </table>
    <table id="type_profprofile"  style="vertical-align:middle; margin-top:10px; margin-left:20px;
                    border: 1;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <th align="left" style="width: 190px;" valign="bottom">
                    <asp:Label ID="Label3" Font-Names="arial" runat="server" Text="<%$Resources:Resource,Description%>">:</asp:Label>:
                </th>
                <td style="width: 350px;" align="left" valign="bottom">
                    <asp:TextBox CssClass="SmallTextBox" ID="txtDescription" Width="500px" runat="server" TextMode="MultiLine" Visible="false"
                        TabIndex="10"></asp:TextBox>
                      <asp:Label ID="lblDescription" CssClass="linkText lblTextCss" runat="Server"></asp:Label>
                </td>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,Manufacturer%>">:</asp:Label>:
                </th>
                <td style="width: 220px">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblmanufacturer" CssClass="linkText lblTextCss" runat="Server"></asp:Label>
                            </td>
                            <td align="left">
                                &nbsp&nbsp&nbsp;
                                <asp:LinkButton ID="lnkManufacturer" CssClass="linkText" runat="server"></asp:LinkButton>
                            </td>
                            <td align="left">
                                <asp:LinkButton ID="lnkSelectManufacturer" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupSelectManufacturer()"
                                    TabIndex="11">Select/Add</asp:LinkButton>
                            </td>
                            <%-- <td align="left">
                         <asp:LinkButton ID="lnkAddManufacturer" CssClass="linkText" runat="server">Add</asp:LinkButton>
                     </td>--%>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width: 190px" runat="server" id="td_omniclass">
                    <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource,Category%>">:</asp:Label>:
                </th>
                <td align="left" style="width: 350px" runat="server" id="td_omniclass1">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblOmniClass" runat="server" CssClass="linkText lblTextCss" Text="" Style=""></asp:Label>
                                <asp:Label ID="lbl_uniclass_value" runat="server" Text="" CssClass="linkText lblTextCss"></asp:Label>
                                <asp:LinkButton ID="btnOmniClass" runat="server" CssClass="linkText" OnClientClick="javascript:return openpopupEditMasterFormat()"
                                    TabIndex="2" Visible="false">Add</asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label17" runat="server" Text="<%$Resources:Resource,Warranty_Duration_Parts%>">:</asp:Label>:
                </th>
                <td>
                    <%--<asp:TextBox CssClass="SmallTextBox" ID="txtWarrantyDurationPart" Width="200px" runat="server"
                        TabIndex="12"></asp:TextBox>--%>
                    <asp:Label ID="lblWarrantyDurationPart" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource,Asset_Type%>">:</asp:Label>:
                </th>
                <td style="width: 350px">
                    <telerik:RadComboBox ID="cmbAssetType" runat="server" InitialValue="--Select--" Width="200px"
                        TabIndex="3" Height="140px" Filter="Contains">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblAssetType" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label16" runat="server" Text="<%$Resources:Resource,Warranty_Duration_Labor%>">:</asp:Label>:
                </th>
                <td style="width: 350px">
                    <%--<asp:TextBox CssClass="SmallTextBox" ID="txtWarrantyDurationLabor" Width="200px"
                        runat="server" TabIndex="13"></asp:TextBox>--%>
                <asp:Label ID="lblWarrantyDurationLabor" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label10" runat="server" Text="<%$Resources:Resource,Model_Number%>">:</asp:Label>:
                </th>
                <td style="width: 350px">
                  <%--  <asp:TextBox CssClass="SmallTextBox" ID="txtModelNumber" Width="200px" runat="server" 
                        TabIndex="4"></asp:TextBox>--%>
                <asp:Label ID="lblModelNumber" CssClass="linkText lblTextCss lblTextCss" runat="server"></asp:Label>
                </td>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label15" runat="server" Text="<%$Resources:Resource,Warranty_Description%>">:</asp:Label>:
                </th>
                <td>
                   <%-- <asp:TextBox CssClass="SmallTextBox" ID="txtWarrantyDescription" Width="200px" runat="server"
                        TabIndex="14"></asp:TextBox>--%>
                <asp:Label ID="lblWarrantyDescription"  CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label14" runat="server" Text="<%$Resources:Resource,Warranty_Guarantor_Parts%>">:</asp:Label>:
                </th>
                <td style="width: 350px">
                    <telerik:RadComboBox ID="cmbWarrantyGurantorPart" runat="server" InitialValue="--Select--" Visible="false"
                        Width="200px" TabIndex="5" Height="140px" Filter="Contains">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblWarrantyGuarantorParts" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label18" runat="server" Text="<%$Resources:Resource,Warranty_Duration_Unit%>">:</asp:Label>:
                </th>
                <td style="width: 350px">
                    <telerik:RadComboBox ID="cmbWarrantyDurationUnit" runat="server" InitialValue="--Select--"
                        Width="200px" TabIndex="15" Height="140px" Filter="Contains">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblWarrantyDurationUnit" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label13" runat="server" Text="<%$Resources:Resource,Warranty_Guarantor_Labor%>">:</asp:Label>:
                </th>
                <td style="width: 350px">
                    <telerik:RadComboBox ID="cmbWarrantyGuarantorLabor" runat="server" InitialValue="--Select--"
                        Width="200px" TabIndex="6" Height="140px" Filter="Contains">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblWarrantyGuarantorLabor" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label12" runat="server" Text="<%$Resources:Resource,Part_Number%>">:</asp:Label>:
                </th>
                <td style="width: 350px">
                   <%-- <asp:TextBox CssClass="SmallTextBox" ID="txtPartNumber" Width="200px" runat="server"
                        TabIndex="16"></asp:TextBox>--%>
               <asp:Label ID="lblPartNumber" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label11" runat="server" Text="<%$Resources:Resource,Replacement_Cost%>">:</asp:Label>:
                </th>
                <td style="width: 350px">
                   <%-- <asp:TextBox CssClass="SmallTextBox" ID="txtReplacementCost" Width="200px" runat="server"
                        TabIndex="7"></asp:TextBox>--%>
                 <asp:Label ID="lblReplacementCost" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
                <th align="left" style="width: 190px">
                   <asp:Label runat="server" id="lblMasterFormat1"  text="MasterFormat:"></asp:Label>
                </th>
                <td style="width: 350px">
                    <telerik:RadComboBox ID="cmbMasterFormat" InitialValue="--Select--" runat="server"
                        Visible="false" Width="200px" Height="140px" TabIndex="17" AutoPostBack="true"
                        Filter="Contains">
                    </telerik:RadComboBox>
                    <asp:LinkButton ID="LinkButton2" CssClass="linkText"  runat="server" OnClientClick="javascript:return openpopupEditMasterFormat()"
                        TabIndex="11">Select/Add</asp:LinkButton>
                    <asp:Label ID="lblMasterFormat" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource,Expected_Life%>">:</asp:Label>:
                </th>
                <td style="width: 350px">
                  <%--  <asp:TextBox CssClass="SmallTextBox" ID="txtExpectedLife" Width="200px" runat="server"
                        TabIndex="8"></asp:TextBox>--%>
               <asp:Label ID="lblExpectedLife" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
                <th align="left" style="width: 190px" runat="server" id="td_uniformat" >
                    <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource,UniFormat%>">:</asp:Label>:
                </th>
                <td style="width: 350px"  runat="server" id="td_uniformat1">
                    <telerik:RadComboBox ID="cmbUniFormat" runat="server" InitialValue="--Select--" Width="200px"
                        Visible="false" TabIndex="9" Height="140px" Filter="Contains">
                    </telerik:RadComboBox>
                    <asp:LinkButton ID="LinkButton1" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupEditMasterFormat()"
                        TabIndex="11">Select/Add</asp:LinkButton>
                    <asp:Label ID="lblUniFormat" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource,Facility%>">:</asp:Label>:
                </th>
                <td style="width: 350px">
                    <%-- <telerik:RadComboBox ID="cmbFacility" InitialValue="--Select--" runat="server" Width="200px"
                 Height="140px" TabIndex="5" AutoPostBack="true" Filter="Contains">
             </telerik:RadComboBox>--%>
                    <asp:Label ID="lblFacility" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                    <asp:LinkButton ID="lnk_assgnFacility" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupSelectFacility()"
                        TabIndex="18">Select</asp:LinkButton>
                    <telerik:RadComboBox Width="170px" InitialValue="--Select--" ID="cmb_facility" Filter="Contains"
                        runat="server" OnItemDataBound="cmbfacility_ItemDataBound" AllowCustomText="True"
                        onkeypress="return tabOnly(event)" Visible="true">
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Text='<%# Eval("name") %>' />
                        </ItemTemplate>
                    </telerik:RadComboBox>
                </td>
                <th align="left" style="width: 190px">
                    <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Contractor%>">:</asp:Label>:
                </th>
                <td style="width: 350px">
                    <telerik:RadComboBox ID="cmbContractor" runat="server" InitialValue="--Select--"
                        Width="200px" Visible="false" TabIndex="9" Height="140px" Filter="Contains">
                    </telerik:RadComboBox>
                    <asp:LinkButton ID="LinkButton4" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupEditContractor()"
                        TabIndex="11">Select/Add</asp:LinkButton>
                    <asp:Label ID="lblContractor" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
             <th align="left" style="width: 190px" id="td_uniclass" runat="server">
                  <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Designer%>">:</asp:Label>:
                </th>
                <%--<td align="left" style="width: 190px;">
                    <asp:Label ID="lbl_uniclass" runat="server" Text="Uniclass"></asp:Label>
                </td>--%>
                <td style="width: 350px" id="td_uniclass_link" runat="server">
                    <asp:LinkButton ID="LinkButton3" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupEditDesigner()"
                        TabIndex="11">Select/Add</asp:LinkButton>
                    <asp:Label ID="lblDesigner" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
                <th align="left" style="width: 190px">
                    
                </th>
                <td style="width: 350px">
                    <telerik:RadComboBox ID="cmbDesigner" runat="server" InitialValue="--Select--" Width="200px"
                        Visible="false" TabIndex="9" Height="140px" Filter="Contains">
                    </telerik:RadComboBox>
                    
                </td>
            </tr>
            
           
            <tr>
                <td colspan="4" align="left" style="height: 40px;vertical-align:middle">
                    <%--<asp:Button ID="btnEdit" runat="server" Text="Save" Width="80px" TabIndex="19" ValidationGroup="my_validation"
                    OnClick="btnEdit_Click" />&nbsp;--%>
                    <%--<telerik:RadButton ID="btnSave" runat="server" Text="<%$Resources:Resource, Save%>" Width="70px"
                                Skin="Hay" onclick="btnSave_Click" TabIndex="5" ValidationGroup="my_validation"  />--%>
                    <asp:Button ID="btnEdit" runat="server" Text="<%$Resources:Resource, Edit%>"
                        Width="100px" OnClick="btnEdit_Click"  /> &nbsp;
                    <asp:Button ID="btnAddByModelNumber" Width="120px" runat="server" Text="<%$Resources:Resource, Add_By_Model_number%>"
                        OnClientClick="javascript:return btnAddByModelNumber_click();" />&nbsp;
                    <asp:Button ID="btnBrowseByManufacturer" runat="server" Text="<%$Resources:Resource, Browse_By_Manufacturer%>"
                        Width="130px" OnClientClick="javascript:return btnBrowseByManufacturer_click();" />&nbsp;
                    <%-- <asp:Button ID="btnCancel" runat="server" Text="Cancel" Width="100px" 
                    TabIndex="20"/>--%><%--OnClientClick="javascript:Navigate();"--%>
                    <asp:Button ID="btnDelete" runat="server" Text="<%$Resources:Resource, Delete%>"
                        Width="100px" TabIndex="20" ValidationGroup="my_validation" OnClick="btnDelete_Click"
                        OnClientClick="javascript:return delete_();" />&nbsp;
                    <asp:Button ID="btnclose" runat="server" Width="100" Text="<%$Resources:Resource, Close%>"
                        OnClientClick="Javascript:closewindow();" />
                </td>
            </tr>
           
        </table>

    </div>
    <telerik:RadWindowManager ID="radWindowMgrAddModelNumber" runat="server">
        <Windows>
            <telerik:RadWindow ID="radWindowAddClient" Title="Add New Client" runat="server"
                Animation="None" Behavior="Move,Resize" KeepInScreenBounds="true" ReloadOnShow="false"
                BorderStyle="Solid" VisibleStatusbar="false" Visible="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rad_windowmgr" runat="server" Skin="Forest" VisibleStatusbar="false">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="Slide" KeepInScreenBounds="true"
                ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false" Width="950" Height="500"
                Top="2px" VisibleStatusbar="false" VisibleOnPageLoad="false" Skin="Forest" Behaviors="Move,Resize">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="RadWindowManager_masterformat" runat="server" Skin="Forest"
        VisibleStatusbar="false">
        <Windows>
            <telerik:RadWindow ID="rd_window_masterformat" runat="server" Title="EcoDomus PM : Assign OmniClass/MasterFormat/UniFormat"
                ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false" Width="630" Height="400"
                Top="2px" VisibleStatusbar="false" VisibleOnPageLoad="false" Skin="Forest" Behaviors="Move,Resize,Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="RadWindowManager_designer" runat="server" Skin="Forest"
        VisibleStatusbar="false">
        <Windows>
            <telerik:RadWindow ID="RadWindow1" runat="server" Title="EcoDomus PM : Assign Designer/Contractor"
                ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false" Width="630" Height="400"
                Top="2px" VisibleStatusbar="false" VisibleOnPageLoad="false" Skin="Forest" Behaviors="Move,Resize,Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="RadWindowManager_contractor" runat="server" Skin="Forest"
        VisibleStatusbar="false">
        <Windows>
            <telerik:RadWindow ID="RadWindow2" runat="server" Title="EcoDomus PM :  Assign Designer/Contractor"
                ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false" Width="630" Height="400"
                Top="2px" VisibleStatusbar="false" VisibleOnPageLoad="false" Skin="Forest" Behaviors="Move,Resize,Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <div style="display: none">
        <asp:Button ID="btnselect1" Name="btnselect" runat="server" OnClick="btnselect1_Click" />
        <asp:Button ID="btnFillGurantorDropdown" Name="btnGurantor" runat="server" OnClick="btnFillGurantorDropdown_Click" />
        <asp:Button ID="btnSetProductData" runat="server" OnClick="btnSetProductData_Click" />
    </div>
    <div style="display: none">
        <asp:Label ID="lblMsg" runat="server" Text="" Style="font-size: 11px;"></asp:Label>
        <asp:HiddenField ID="hf_lblOmniClassid" runat="server" />
        <asp:HiddenField ID="hf_man_org_id" runat="server" />
        <asp:HiddenField ID="hfselectedId" runat="server" />
        <asp:HiddenField ID="hfselectedname" runat="server" />
        <asp:HiddenField ID="hf_type_name" runat="server" />
        <asp:HiddenField ID="hf_manufaturer_selected_name" runat="server" />
        <asp:HiddenField ID="hfManufacturerName" runat="server" />
        <asp:HiddenField ID="str_qry" runat="server" />
        <asp:HiddenField ID="hfProductId" runat="server" />
        <asp:HiddenField ID="hfManufacturerIdList" runat="server" />
        <asp:HiddenField ID="hfUniFormatId" runat="server" />
        <asp:HiddenField ID="hfDesignerId" runat="server" />
        <asp:HiddenField ID="hfDesignerName" runat="server" />
        <asp:HiddenField ID="hfContractorId" runat="server" />
        <asp:HiddenField ID="hfContractorName" runat="server" />
        <asp:HiddenField ID="hfWarrantyDurationUnitId" runat="server" />
        <asp:HiddenField ID="hfWarrantyDurationUnit" runat="server" />
        <asp:HiddenField ID="hfWarrantyGuarantorLaborId" runat="server" />
        <asp:HiddenField ID="hfWarrantyGuarantorLaborName" runat="server" />
        <%--<asp:HiddenField ID="hfOmniClassId" runat="server" />--%>
        <asp:HiddenField ID="hfAssetTypeId" runat="server" />
        <asp:HiddenField ID="hfWarrantyGuarantorPartsId" runat="server" />
        <asp:HiddenField ID="hfWarrantyGuarantorPartsName" runat="server" />
        <asp:HiddenField ID="hfProductAssigned" runat="server" />
        <asp:HiddenField ID="hfOmniClassName" runat="server" />
        <asp:HiddenField ID="hfpopupflag" runat="server" ClientIDMode="Static" />
        <asp:Button ID="btn_assign" runat="server" OnClick="btnassign_click" />
        <asp:Button ID="btn_navigate" runat="server" OnClick="navigate" />
    </div>
    <asp:HiddenField ID="hfFormatId" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfformatname" runat="server" />
    <asp:HiddenField ID="hf_facility_id" runat="server" />
    <asp:HiddenField ID="hf_type_id" runat="server" />
    <asp:HiddenField ID="hfuniformat_id" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfuniformatname" runat="server" />
    <asp:HiddenField ID="hf_page" runat="server" />
    </form>
</body>
</html>
