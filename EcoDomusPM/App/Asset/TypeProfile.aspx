<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="TypeProfile.aspx.cs"
    Inherits="App_Asset_TypeProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head id="Head1" runat="server">
    <title></title>
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script src="../../App_Themes/EcoDomus/jquery-1.8.3.js" type="text/javascript"></script>
        <script type="text/javascript" language="javascript">


            function GoToTypeProfile() {
                var url = "../Asset/TypeProfileMenu.aspx?type_id=" + document.getElementById("hf_type_id").value;
            }
            function GoToTypeProfilepopup() {

                var url = "../Asset/TypeProfileNew.aspx?type_id=" + document.getElementById("hf_type_id").value + "&popupflag=popup";
                window.location.href = url;
                resizeReverse();
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
                //$find("<%= cmb_facility.ClientID %>").hideDropDown();
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
            function resizeReverse() {
                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    wnd.set_height(document.body.scrollHeight - 15);
                    wnd.set_width(document.body.scrollWidth - 100);
                }
            }
            function Navigatepopup() {
                str = str = '../Asset/TypeProfileNew.aspx?type_id=' + document.getElementById('hf_type_id').value + "&popupflag=popup";
                window.location.href = str;
                //window.parent.resizeReverse();
                resizeReverse();
            }

            function Navigate() {


                if (document.getElementById('hf_type_id').value == '00000000-0000-0000-0000-000000000000') {
                    top.location.href = 'TypePM.aspx';
                }
                else {

                    str = str = '../Asset/TypeProfileMenu.aspx?type_id=' + document.getElementById('hf_type_id').value;
                    window.parent.location.href = str;
                }
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
            //This function returns rad window instance to resize it popup
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function resizeParentpopup() {
                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    wnd.set_height(document.body.scrollHeight + 160);
                }

            }

            function resizeParentPopupReversBack() {
                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    wnd.set_height(document.body.scrollHeight + 50);
                }

            }

            function openpopupEditMasterFormat(str) {

                manager = $find("rd_manger_NewUI");
                var url;
                var type_id;
                type_id = document.getElementById("hf_type_id").value;
                var url = "../Asset/EditMasterFormatUniFormat.aspx?flag=" + str + "&type_id=" + type_id + ",";
                if (manager != null) {

                    var window = manager.get_windows();
                    if (window[0] != null) {
                        // var windows = manager.get_windows();
                        window[0].setUrl(url);
                        var bounds = window[0].getWindowBounds();
                        var x = bounds.x;
                        var y = bounds.y;
                        //window[0].moveTo(x-30, 1);

                        if (str == 'OmniClass') {
                            window[0]._titleElement.innerHTML = " Assign OmniClass";
                            resizeParentpopup();
                        }
                        else if (str == 'UniFormat') {
                            window[0]._titleElement.innerHTML = " Assign UniFormat";
                            window[0]._height = 300;
                            resizeParentpopup();
                        }
                        else if (str == 'Masterformat') {
                            window[0]._titleElement.innerHTML = " Assign MasterFormat";
                        }
                        window[0].show();
                        window[0].set_modal(false);
                    }
                    //windows[0].set_modal(false);
                }


                return false;
            }
            function getParameterByName(name) {
                name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
                var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
                return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
            }

            function openpopupEditContractor(str) {

                manager = $find("rd_Designer_contractor");
                var url;
                var type_id;
                type_id = document.getElementById("hf_type_id").value;
                //                var url = "../Asset/EditDesignerContractor.aspx?flag=" + str + "&type_id=" + type_id + ",";

                //popupflag=popup
                var url = "blank";
                if (this.getParameterByName('popupflag') == 'popup')
                    url = "../Asset/EditDesignerContractorNew.aspx?flag=" + str + "&IfFromTypePM=N&type_id=" + type_id + "&popupflag=popup,";
                else
                    url = "../Asset/EditDesignerContractorNew.aspx?flag=" + str + "&IfFromTypePM=N&type_id=" + type_id + "&popupflag=,";
                if (manager != null) {

                    var windows = manager.get_windows();
                    if (window[0] != null) {
                        windows[0].setUrl(url);
                        var bounds = windows[0].getWindowBounds();
                        var x = bounds.x;
                        var y = bounds.y;
                        // window[0].moveTo(x - 30, 1);
                        windows[0].show();
                        windows[0].set_modal(false);
                        windows[0]._titleElement.innerHTML = "Assign Contractor";

                    }
                    //windows[0].set_modal(false);
                }
                resizeParentpopup();
                return false;
            }
            function openpopupEditDesigner(str) {
                manager = $find("rd_Designer_contractor");
                var url;
                var type_id;
                type_id = document.getElementById("hf_type_id").value;
                //                var url = "../Asset/EditDesignerContractor.aspx?flag=" + str + "&type_id=" + type_id + ",";
                var url = "blank";
                if (this.getParameterByName('popupflag') == 'popup')
                    url = "../Asset/EditDesignerContractorNew.aspx?flag=" + str + "&IsFromTypePM=N&type_id=" + type_id + "&popupflag=popup,";
                else
                    url = "../Asset/EditDesignerContractorNew.aspx?flag=" + str + "&IsFromTypePM=N&type_id=" + type_id + "&popupflag=,";
                if (manager != null) {
                    var windows = manager.get_windows();
                    if (window[0] != null) {
                        windows[0].setUrl(url);
                        var bounds = windows[0].getWindowBounds();
                        var x = bounds.x;
                        var y = bounds.y;
                        //window[0].moveTo(x - 30, 1);
                        windows[0].show();
                        windows[0].set_modal(false);
                        windows[0]._titleElement.innerHTML = "Assign Designer";
                        //windows[0].set_modal(false);
                        resizeParentpopup();
                    }
                }

                return false;
            }


            function btnAddByModelNumber_click() {

                manager = $find("radWindowMgrAddModelNumber");
                var url = "../Asset/AddModelNumber.aspx?organization_id=00000000-0000-0000-0000-000000000000";

                if (manager != null) {
                    var windows = manager.get_windows();
                    if (window[0] != null) {
                        windows[0].setUrl(url);
                        var bounds = windows[0].getWindowBounds();
                        var x = bounds.x;
                        var y = bounds.y;
                        windows[0].show();
                        windows[0].set_modal(false);
                        windows[0]._titleElement.innerHTML = "Products";
                        //  windows[0].moveTo(x - 30, 20);
                        resizeParentpopup();
                    }
                }

                return false;
            }

            function btnBrowseByManufacturer_click() {

                //var url = "../Asset/AddModelNumber.aspx?organization_id=" + document.getElementById('hf_man_org_id').value;
                var url = "../Asset/AddModelNumber.aspx?organization_id=00000000-0000-0000-0000-000000000000";
                manager = $find("radWindowMgrAddModelNumber");
                if (manager != null) {
                    var windows = manager.get_windows();
                    if (window[0] != null) {
                        windows[0].setUrl(url);
                        var bounds = windows[0].getWindowBounds();
                        var x = bounds.x;
                        var y = bounds.y;
                        windows[0].show();
                        windows[0].set_modal(false);
                        windows[0]._titleElement.innerHTML = "Products";
                        //  windows[0].moveTo(x - 30, 20);
                        resizeParentpopup();
                    }
                }

                return false;
            }

            function openuniclasspopup() {

                manager = $find("<%=rd_manger_NewUI1.ClientID%>");
                var type_id;
                type_id = document.getElementById("hf_type_id").value;
                // var itemtodelete;
                //itemtodelete = document.getElementById("ContentPlaceHolder1_hf_type_id").value;
                var url = "../Asset/EditMasterFormatUniFormatNew.aspx?type_id=" + type_id + "&uniclasstypeprofile=y";  //+ itemtodelete.toString();
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                    windows[0].set_modal(false);
                    //windows[0].moveTo(270, 100);
                    // window[0]._width = "540px";
                    //window[0]._height ="400";
                }
                return false;
            }


            function openpopupSelectManufacturer(name) {

                //manager = $find("rad_windowmgr");
                manager = $find("rd_manufacturer_new");
                var url;
                var url = "";
                if (this.getParameterByName('popupflag') == 'popup')
                    url = "../Asset/AddSelectManufacturerpopup.aspx?Name=" + name + "&popupflag=popup";
                else
                    url = "../Asset/AddSelectManufacturerpopup.aspx?Name=" + name + "&popupflag=";
                if (manager != null) {
                    var windows = manager.get_windows();

                    windows[0].setUrl(url);
                    windows[0].show();
                    windows[0].set_modal(false);
                    windows[0]._titleElement.innerHTML = "Assign Manufacturer";

                    //                    if (url == '../Asset/AddSelectManufacturerpopup.aspx') {
                    //                        windows[0]._titleElement.innerHTML = "EcoDomus PM: Assign Manufacturer";
                    //                    }
                    //windows[0].set_modal(false);
                    //windows[2].center();
                }
                resizeParentpopup();
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
                str = '../Asset/TypeProfileMenu.aspx?type_id=' + document.getElementById('hf_type_id').value;
                window.parent.location.href = str;
            }

            function refreshgrid() {


            }
            function refreshgrid_new(flag_name) {
                if (flag_name != null) {
                    document.getElementById('hf_flag_name').value = flag_name;
                }
                document.getElementById("btnAssign").click();

            }

            function buttoncallback_Type() {
                document.getElementById("btnselect1").click();
            }
            function closewindow() {
                window.close();
            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }
            function refreshuniclasslable(uniclass_name, id) {

                document.getElementById("lbl_uniclass_value").innerHTML = uniclass_name;
                document.getElementById("hf_uniclass_id").value = id;
            }

        </script>


        
        <script type="text/javascript">


            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : event.keyCode
                var error = document.getElementById("lblErrorMessage");
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                   
                     error.innerHTML = "<br />Please enter numeric value only"
                  
                    return false;
                }
                error.innerHTML = "";
                return true;
            }
 
   </script>


    </telerik:RadCodeBlock>
    <style type="text/css">
        th
        {
            font-size: 12px;
            font-weight: normal;
            color: #330000;
            vertical-align: top;
            font-weight: bolder;
            font-family: Arial, Helvetica, sans-serif;
        }
        td
        {
            font-size: 12px;
            font-weight: normal;
            padding-left: 0px;
            font-weight: normal;
            font-family: Arial, Helvetica, sans-serif;
            vertical-align: top;
            text-align: left;
            table-layout: fixed;
        }
        .rfdButton INPUT[type='submit'].rfdDecorated
        {
            padding: 0 6px 0 10px;
            background-position: left -22px;
            height: 22px;
            padding: 0 6px 0 10px;
            margin-right: 0px;
        }
        
        .RadWindow_Simple
        {
            border: solid 0px #616161;
        }
    </style>
</head>
<body style="background: transparent; background-image: url('../Images/asset_zebra-bkgrd_gray2.PNG');
    padding: 0px; margin: 0px 0px 0px 0px;">
    <form id="form1" runat="server" defaultfocus="txtName">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <%--<telerik:RadFormDecorator ID="rdftype" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />--%>
    <div id="divProfilePage" runat="server" style="width: 10%; padding: 2px; display: none;">
        <table runat="server" id="tbltitle" border="0" cellpadding="0" cellspacing="0" width="100%"
            style="border-collapse: collapse; display: none;">
            <tr>
                <td class="wizardHeadImage" style="display: none;">
                    <div class="wizardLeftImage">
                        <asp:Label ID="lblpopup" runat="server" Font-Size="Small" Text="<%$Resources:Resource,Type_Profile%>">:</asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClientClick="javascript:return closewindow();" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div id="divProfilePage1" runat="server" style="width: 100%; padding: 2px;">
        <table style="width: 100%;">
            <tr>
                <td style="width: 100%; padding-left: 20px;">
                    <table id="type_profprofile" style="vertical-align: middle; margin-top: 10px; border: 0px;"
                        cellpadding="0" cellspacing="0" border="0" width="100%">
                        <tr>
                            <th align="left" style="width: 15%">
                                <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Name%>">:</asp:Label>:
                            </th>
                            <td style="width: 25%">
                                <asp:TextBox CssClass="SmallTextBox" ID="txtName" Width="200px" runat="server" TabIndex="1"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName"
                                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                                    SetFocusOnError="True">
                                </asp:RequiredFieldValidator>
                            </td>
                            <th align="left" style="width: 15%">
                                <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,Description%>">:</asp:Label>:
                            </th>
                            <td style="width: 25%">
                                <asp:TextBox CssClass="SmallTextBox" ID="txtDescription" Width="200px" runat="server"
                                    TabIndex="11"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 8px">
                            </td>
                        </tr>
                        <tr>
                            <th align="left" runat="server" id="td_omniclass">
                                <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource,category%>">:</asp:Label>:
                            </th>
                            <td align="left" style="">
                                <table width="100%">
                                    <tr>
                                        <td runat="server" id="td_omniclass1">
                                            <asp:Label ID="lblOmniClass" runat="server" Text="" Style="font-size: 11px;"></asp:Label>
                                            <asp:LinkButton ID="btnOmniClass" runat="server" Text="<%$Resources:Resource,Select_Add%>"
                                                CssClass="linkText" OnClientClick="javascript:return openpopupEditMasterFormat('OmniClass')"
                                                TabIndex="2"></asp:LinkButton>
                                            <%--<asp:Label ID="Label21" runat="server" ></asp:Label></asp:LinkButton>--%>
                                        </td>
                                        <td runat="server" id="td_uniclass1">
                                            <asp:Label ID="lbl_uniclass_value" runat="server" Text="" CssClass="LabelText"></asp:Label>
                                            <asp:LinkButton ID="LinkButton5" CssClass="linkText" Text="<%$Resources:Resource,Select_Add%>"
                                                runat="server" OnClientClick="javascript:return openuniclasspopup()" TabIndex="21">
                                    <%--<asp:Label ID="Label8" runat="server" ></asp:Label>--%>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <th align="left" style="width: 190px">
                                <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,Manufacturer%>">:</asp:Label>:
                            </th>
                            <td style="width: 220px">
                                <table cellspacing="4">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblmanufacturer" CssClass="linkText" runat="Server"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:LinkButton ID="lnkManufacturer" TabIndex="12" CssClass="linkText" runat="server"></asp:LinkButton>
                                        </td>
                                        <td align="left">
                                            <asp:LinkButton ID="lnkSelectManufacturer" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupSelectManufacturer()"
                                                TabIndex="11">
                                                <asp:Label ID="Label27" runat="server" Text="<%$Resources:Resource,Select_Add%>"></asp:Label></asp:LinkButton>
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
                            <th align="left" style="width: 190px">
                                <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource,Asset_Type%>"></asp:Label>:
                            </th>
                            <td style="width: 220px">
                                <telerik:RadComboBox ID="cmbAssetType" runat="server" InitialValue="--Select--" Width="200px"
                                    TabIndex="3" Height="140px" Filter="Contains">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblAssetType" CssClass="linkText" runat="server"></asp:Label>
                            </td>
                            <th align="left" style="width: 190px">
                                <asp:Label ID="Label16" runat="server" Text="<%$Resources:Resource,Warranty_duration_parts%>">:</asp:Label>:
                            </th>
                            <td>
                                <asp:TextBox CssClass="SmallTextBox" ID="txtWarrantyDurationPart" Width="200px" runat="server"
                                    TabIndex="13" onkeypress="return isNumberKey(event)" onpaste="return false"  ></asp:TextBox>
                                    <asp:Label ID="lblDays" Text="Days" runat="server"></asp:Label>
                                    <asp:Label ID="lblErrorMessage" Text="" runat="server"  ForeColor="Red"></asp:Label>
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
                            <td style="width: 220px">
                                <asp:TextBox CssClass="SmallTextBox" ID="txtModelNumber" Width="200px" runat="server"
                                    TabIndex="4"></asp:TextBox>
                            </td>
                            <th align="left" style="width: 190px">
                                <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Warranty_Duration_Labor%>">:</asp:Label>:
                            </th>
                            <td style="width: 220px">
                                <asp:TextBox CssClass="SmallTextBox" ID="txtWarrantyDurationLabor" Width="200px"
                                    runat="server" TabIndex="14"></asp:TextBox>
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
                            <td style="width: 220px">
                                <table cellspacing="4">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblWarrantyGuarantorParts" CssClass="linkText" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="LinkButton7" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupSelectManufacturer('Warranty_Parts')"
                                                TabIndex="9">
                                                <asp:Label ID="Label29" runat="server" Text="<%$Resources:Resource,Select_Add%>"></asp:Label></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                                <%--<telerik:RadComboBox ID="cmbWarrantyGurantorPart" runat="server" InitialValue="--Select--"
                        Width="200px" TabIndex="5" Height="140px" Filter="Contains">
                    </telerik:RadComboBox>--%>
                            </td>
                            <th align="left" style="width: 190px">
                                <asp:Label ID="Label15" runat="server" Text="<%$Resources:Resource,Warranty_Description%>">:</asp:Label>:
                            </th>
                            <td>
                                <asp:TextBox CssClass="SmallTextBox" ID="txtWarrantyDescription" Width="200px" runat="server"
                                    TabIndex="15"></asp:TextBox>
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
                            <td style="width: 220px">
                                <%--<telerik:RadComboBox ID="cmbWarrantyGuarantorLabor" runat="server" InitialValue="--Select--"
                        Width="200px" TabIndex="6" Height="140px" Filter="Contains">
                    </telerik:RadComboBox>--%>
                                <table cellspacing="4">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblWarrantyGuarantorLabor" CssClass="linkText" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="LinkButton6" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupSelectManufacturer('Warranty_Labor')"
                                                TabIndex="9">
                                                <asp:Label ID="Label28" runat="server" Text="<%$Resources:Resource,Select_Add%>"></asp:Label></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <th align="left" style="width: 190px">
                                <asp:Label ID="Label18" runat="server" Text="<%$Resources:Resource,Warranty_Duration_Unit%>">:</asp:Label>:
                            </th>
                            <td style="width: 220px">
                                <telerik:RadComboBox ID="cmbWarrantyDurationUnit" runat="server" InitialValue="--Select--"
                                    Width="200px" TabIndex="16" Height="140px" Filter="Contains">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblWarrantyDurationUnit" CssClass="linkText" runat="server"></asp:Label>
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
                            <td style="width: 220px">
                                <asp:TextBox CssClass="SmallTextBox" ID="txtReplacementCost" Width="200px" runat="server"
                                    TabIndex="7"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator_txtReplacementCost" ControlToValidate="txtReplacementCost"
                                    runat="server" ErrorMessage="Only numbers allowed" ValidationGroup="my_validation"
                                    ValidationExpression="^-?\d*\.?\d*"></asp:RegularExpressionValidator>
                            </td>
                            <th align="left" style="width: 190px">
                                <asp:Label ID="Label12" runat="server" Text="<%$Resources:Resource,Part_Number%>">:</asp:Label>:
                            </th>
                            <td style="width: 220px">
                                <asp:TextBox CssClass="SmallTextBox" ID="txtPartNumber" Width="200px" runat="server"
                                    TabIndex="17"></asp:TextBox>
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
                            <td style="width: 220px">
                                <asp:TextBox CssClass="SmallTextBox" ID="txtExpectedLife" Width="200px" runat="server"
                                    TabIndex="8"></asp:TextBox>
                            </td>
                            <th align="left" style="width: 190px" runat="server" id="td_masterformat">
                                <asp:Label ID="Label20" runat="server" Text="<%$Resources:Resource,Masterformat%>">:</asp:Label>:
                            </th>
                            <td style="width: 220px" runat="server" id="td_masterformat1">
                                <telerik:RadComboBox ID="cmbMasterFormat" InitialValue="--Select--" runat="server"
                                    Visible="false" Width="200px" Height="140px" TabIndex="18" AutoPostBack="true"
                                    Filter="Contains">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblMasterFormat" CssClass="linkText" runat="server"></asp:Label>
                                <asp:LinkButton ID="LinkButton2" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupEditMasterFormat('Masterformat')"
                                    TabIndex="18">
                                    <asp:Label ID="Label23" runat="server" Text="<%$Resources:Resource,Select_Add%>"></asp:Label></asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 8px">
                            </td>
                        </tr>
                        <tr>
                            <th align="left" runat="server" id="td_uniformat">
                                <asp:Label ID="Uniformat" runat="server" Text="<%$Resources:Resource,Uniformat%>">:</asp:Label>:
                            </th>
                            <td style="width: 220px" runat="server" id="td_uniformat1">
                                <table>
                                    <tr>
                                        <td>
                                            <telerik:RadComboBox ID="cmbUniFormat" runat="server" InitialValue="--Select--" Visible="false"
                                                Height="140px" Filter="Contains">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblUniFormat" CssClass="linkText" runat="server"></asp:Label>
                                        </td>
                                        <td style="padding-left: 0px;">
                                            <asp:LinkButton ID="LinkButton1" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupEditMasterFormat('UniFormat')"
                                                TabIndex="9">
                                                <asp:Label ID="Label22" runat="server" Text="<%$Resources:Resource,Select_Add%>"></asp:Label></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <th align="left">
                                <asp:Label ID="Label19" runat="server" Text="<%$Resources:Resource,Facility%>">:</asp:Label>:
                            </th>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblFacility" CssClass="linkText" runat="server"></asp:Label>
                                            <asp:LinkButton ID="lnk_assgnFacility" TabIndex="9" CssClass="linkText" runat="server"
                                                OnClientClick="javascript:return openpopupSelectFacility()">
                                                <asp:Label ID="Label26" runat="server" Text="<%$Resources:Resource,Select_Add%>"></asp:Label></asp:LinkButton>
                                            <telerik:RadComboBox TabIndex="20" InitialValue="--Select--" ID="cmb_facility" Filter="Contains"
                                                runat="server" OnItemDataBound="cmbfacility_ItemDataBound" AllowCustomText="True"
                                                Width="200px" Height="130px" onkeypress="return tabOnly(event)" Visible="true">
                                                <%--EmptyMessage="--Select--"--%>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="CheckBox1" runat="server" Text='<%# Eval("name") %>' />
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="cmb_facility"
                                                Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                                                SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 8px">
                            </td>
                        </tr>
                        <tr>
                            <th align="left" style="width: 190px">
                                <asp:Label ID="Label17" runat="server" Text="<%$Resources:Resource,Designer%>">:</asp:Label>:
                            </th>
                            <td style="width: 220px">
                                <telerik:RadComboBox ID="cmbDesigner" runat="server" InitialValue="--Select--" Visible="false"
                                    TabIndex="10" Height="140px" Filter="Contains">
                                </telerik:RadComboBox>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblDesigner" CssClass="linkText" runat="server"></asp:Label>
                                        </td>
                                        <td style="padding-left: 2px;">
                                            <asp:LinkButton ID="LinkButton3" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupEditDesigner('Designer')"
                                                TabIndex="10">
                                                <asp:Label ID="Label24" runat="server" Text="<%$Resources:Resource,Select_Add%>"></asp:Label></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <th align="left">
                                <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource,Contractor%>">:</asp:Label>:
                            </th>
                            <td style="width: 220px">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblContractor" CssClass="linkText" runat="server"></asp:Label>
                                        </td>
                                        <td style="padding-left: 2px;">
                                            <asp:LinkButton ID="LinkButton4" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupEditContractor('Contractor')"
                                                TabIndex="21">
                                                <asp:Label ID="Label25" runat="server" Text="<%$Resources:Resource,Select_Add%>"></asp:Label>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="left" style="height: 40px; vertical-align: middle">
                                <table border="0" style="font-family: Arial, Helvetica, sans-serif; table-layout: fixed;
                                    border-bottom-style: none; border-bottom-width: 0px; width: 100%; overflow: hidden;">
                                    <tr>
                                        <td style="height: 35px; padding-bottom: 0px; padding-left: 0px; padding-top: 10px;
                                            width: 100%;">
                                            <%-- <asp:Button ID="btnEdit" runat="server" Font-Names="Arial"  Text="<%$Resources:Resource,Save%>" Width="100px" 
                                    OnClick="btnEdit_Click"  />--%>
                                            <telerik:RadButton ID="btnEdit" Width="100px" OnClick="btnEdit_Click" runat="server"
                                                Font-Names="Arial" Text="<%$Resources:Resource,Save%>" ValidationGroup="my_validation">
                                            </telerik:RadButton>
                                            <%-- <asp:Button ID="btnAddByModelNumber" Width="160px" Font-Names="Arial" runat="server" Text="<%$Resources:Resource, Add_By_Model_number%>"
                                    OnClientClick="javascript:return btnAddByModelNumber_click();" TabIndex="23" /> --%>
                                            <telerik:RadButton ID="btnAddByModelNumber" Width="160px" Font-Names="Arial" runat="server"
                                                Text="<%$Resources:Resource, Add_By_Model_number%>" OnClientClicked="btnAddByModelNumber_click"
                                                AutoPostBack="false" TabIndex="23">
                                            </telerik:RadButton>
                                            <%--  <asp:Button ID="btnBrowseByManufacturer" runat="server" Font-Names="Arial" Text="<%$Resources:Resource, Browse_By_Manufacturer%>"
                                    Width="160px" OnClientClick="javascript:return btnBrowseByManufacturer_click();"
                                    TabIndex="24" />--%>
                                            <telerik:RadButton ID="btnBrowseByManufacturer" AutoPostBack="false" runat="server"
                                                Font-Names="Arial" Text="<%$Resources:Resource, Browse_By_Manufacturer%>" Width="160px"
                                                OnClientClicked="btnBrowseByManufacturer_click" TabIndex="24">
                                            </telerik:RadButton>
                                            <%--<asp:Button ID="btnCancel" runat="server" Font-Names="Arial" Text="<%$Resources:Resource,Cancel%>" Width="100px"
                                    OnClick="btnCancel_click" TabIndex="25" />
                                            --%>
                                            <telerik:RadButton ID="btnCancel" runat="server" Font-Names="Arial" Text="<%$Resources:Resource,Cancel%>"
                                                Width="100px" OnClick="btnCancel_click" TabIndex="25">
                                            </telerik:RadButton>
                                            <%--<asp:Button ID="btnDelete" runat="server" Text="<%$Resources:Resource,Delete%>" Width="100px" Font-Names="Arial"
                                    TabIndex="26" ValidationGroup="my_validation" />--%>
                                            <telerik:RadButton ID="btnDelete" runat="server" Text="<%$Resources:Resource,Delete%>"
                                                AutoPostBack="false" Width="100px" Font-Names="Arial" TabIndex="26" ValidationGroup="my_validation">
                                            </telerik:RadButton>
                                            <%--  <asp:Button ID="btnclose" runat="server" Width="100px" Text="<%$Resources:Resource, Close%>" Font-Names="Arial"
                                    OnClientClick="Javascript:closewindow();" /> --%>
                                            <telerik:RadButton ID="btnclose" runat="server" Width="100px" AutoPostBack="false"
                                                Text="<%$Resources:Resource, Close%>" Font-Names="Arial" OnClientClicked="closewindow">
                                            </telerik:RadButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" style="width: 100%; height: 10px">
                            </td>
                        </tr>
                        <%--<tr id="tr_uniclass" runat="server">
                <th align="left" runat="server" id="td_uniclass">
                    <asp:Label runat="server" ID="lblUniClass" Text="UniClass:"></asp:Label>
                </th>
                
                <th>
                </th>
            </tr>--%>
                        <tr>
                            <td style="height: 8px">
                            </td>
                            <td colspan="4">
                                <table runat="server" id="tbl_facility">
                                    <tr>
                                        <td>
                                            <telerik:RadGrid ID="RgFacilityList" runat="server" BorderWidth="1px" CellPadding="0"
                                                PageSize="5" OnPageSizeChanged="RgFacilityList_OnPageSizeChanged" Width="80%"
                                                AllowPaging="True" OnItemCommand="RgFacilityList_OnItemCommand" OnPageIndexChanged="RgFacilityList_OnPageIndexChanged"
                                                AutoGenerateColumns="False" OnSortCommand="RgFacilityList_OnSortCommand" Skin="Default"
                                                PagerStyle-AlwaysVisible="true" AllowSorting="True" GridLines="None">
                                                <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" />
                                                <MasterTableView DataKeyNames="facility_id">
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="facility_id" HeaderText="facility_id" Visible="false">
                                                            <ItemStyle CssClass="column" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="name" CommandName="facility_Profile"
                                                            HeaderText="Facility Name" SortExpression="name">
                                                            <ItemStyle CssClass="column" Font-Underline="true" Width="500px" />
                                                        </telerik:GridButtonColumn>
                                                        <%--<telerik:GridTemplateColumn DataField="facility_id" UniqueName="facility_id">
                                <ItemStyle CssClass="column" Width="5%" />
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" Name="imgbtnDelete" runat="server" alt="Delete"
                                        CommandName="deletecomponent" ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return deleteComponent();" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>--%>
                                                    </Columns>
                                                </MasterTableView>
                                                <AlternatingItemStyle CssClass="alternateColor" />
                                            </telerik:RadGrid>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadFormDecorator ID="rdftype" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmb_facility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmb_facility" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnAssign">
                <UpdatedControls>
                    <%--<telerik:AjaxUpdatedControl ControlID="cmbWarrantyGuarantorLabor" />--%>
                    <telerik:AjaxUpdatedControl ControlID="lblWarrantyGuarantorParts" />
                    <telerik:AjaxUpdatedControl ControlID="lblWarrantyGuarantorLabor" />
                    <telerik:AjaxUpdatedControl ControlID="lblmanufacturer" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="radWindowMgrAddModelNumber" runat="server" VisibleTitlebar="true"
        Behaviors="Close,Move" BorderWidth="0px" Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="radWindowAddClient" runat="server" ReloadOnShow="false" Width="600px"
                DestroyOnClose="false" AutoSize="false" Modal="true" VisibleStatusbar="false"
                VisibleOnPageLoad="false" Height="460" EnableAjaxSkinRendering="false" BorderWidth="0"
                Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_Designer_contractor" runat="server" VisibleTitlebar="true"
        Title="Assign OmniClass" Behaviors="Close,Move" BorderWidth="0px" Skin="Simple"
        BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="RadWindow4" runat="server" ReloadOnShow="false" Width="600"
                AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" EnableAjaxSkinRendering="false"
                EnableShadow="true" Modal="true" Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_manufacturer_new" runat="server" VisibleTitlebar="true"
        Title="Assign OmniClass" Behaviors="Close,Move" BorderWidth="0px" Skin="Simple"
        BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="RadWindow3" runat="server" ReloadOnShow="false" Width="600"
                AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false" VisibleStatusbar="false"
                VisibleOnPageLoad="false" Behaviors="Close,Move" EnableAjaxSkinRendering="false"
                EnableShadow="true" Top="5" Modal="true" BorderWidth="0" Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rad_windowmgr" runat="server" Skin="Default" VisibleStatusbar="false">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="Slide" KeepInScreenBounds="true"
                ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false" Width="600" Height="400"
                VisibleStatusbar="false" VisibleOnPageLoad="false" Skin="" Behaviors="Move,Resize">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="RadWindowManager_masterformat" runat="server" VisibleTitlebar="true"
        Title="Assign OmniClass" Behaviors="Close,Move" BorderWidth="0px" Skin="Simple"
        BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rd_window_masterformat" runat="server" ReloadOnShow="false"
                VisibleTitlebar="true" AutoSize="false" Width="630" Height="400" VisibleStatusbar="false"
                VisibleOnPageLoad="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_manger_NewUI" runat="server" VisibleTitlebar="true"
        Title="Assign OmniClass" Behaviors="Close,Move" BorderWidth="0px" Skin="Simple"
        BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rd_window_master_Uniformat" runat="server" ReloadOnShow="false"
                Width="600px" DestroyOnClose="false" OffsetElementID="btn_search" VisibleStatusbar="false"
                VisibleOnPageLoad="false" Height="400" EnableAjaxSkinRendering="false" AutoSize="false"
                EnableShadow="true" BackColor="Black" Modal="true" BorderWidth="0" Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="RadWindowManager_designer" runat="server" Skin="" VisibleStatusbar="false">
        <Windows>
            <telerik:RadWindow ID="RadWindow1" runat="server" Title="EcoDomus PM : Assign Designer/Contractor"
                ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false" Width="630" Height="400"
                VisibleStatusbar="false" VisibleOnPageLoad="false" Skin="Default" Behaviors="Move,Resize">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="RadWindowManager_contractor" runat="server" Skin="Default"
        VisibleStatusbar="false">
        <Windows>
            <telerik:RadWindow ID="RadWindow2" runat="server" Title="EcoDomus PM :  Assign Designer/Contractor"
                ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false" Width="630" Height="400"
                VisibleStatusbar="false" VisibleOnPageLoad="false" Skin="Default" Behaviors="Move,Resize">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_manger_NewUI1" runat="server" VisibleTitlebar="true"
        Title="Assign UniClass" Behaviors="Close,Move" BorderWidth="0px" Skin="Simple"
        BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rd_window_master_Uniformat1" runat="server" ReloadOnShow="false"
                Width="600" Height="380" AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false"
                Modal="true" VisibleStatusbar="false" VisibleOnPageLoad="false" BorderColor="Black"
                EnableAjaxSkinRendering="false" EnableShadow="true" BackColor="Black" BorderWidth="0"
                Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <div style="display: none">
        <asp:Button ID="btnselect1" Name="btnselect" runat="server" OnClick="btnselect1_Click" />
        <asp:Button ID="btnAssign" Name="btnAssign" runat="server" OnClick="btn_Assign_Click" />
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
        <asp:Button ID="btn_assign" runat="server" OnClick="btnassign_click" />
        <asp:Button ID="btn_navigate" runat="server" OnClick="navigate" />
    </div>
    <asp:HiddenField ID="hfFormatId" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfformatname" runat="server" />
    <asp:HiddenField ID="hf_facility_id" runat="server" />
    <asp:HiddenField ID="hf_type_id" runat="server" />
    <asp:HiddenField ID="hfuniformat_id" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfuniformatname" runat="server" />
    <asp:HiddenField ID="hfpopupflag" runat="server" />
    <asp:HiddenField ID="hf_uniclass_id" runat="server" />
    <asp:HiddenField ID="hf_WarrantyGarantyLabor" runat="server" />
    <asp:HiddenField ID="hf_WarrantyGarantyPart" runat="server" />
    <asp:HiddenField ID="hf_WarrantyGarantyLabor_id" runat="server" />
    <asp:HiddenField ID="hf_WarrantyGarantyPart_id" runat="server" />
    <asp:HiddenField ID="hf_flag_name" runat="server" />
    </form>
</body>
<%--Please don't move this link to anywhere on th page--%>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
<style type="text/css">
    .RadWindow_Simple
    {
        border: solid 0px #616161;
    }
</style>
</html>
