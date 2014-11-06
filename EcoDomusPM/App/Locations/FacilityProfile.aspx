<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="FacilityProfile.aspx.cs"
    Inherits="App_Locations_FacilityProfile" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head> 
    <title>Facility Profile </title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <%--Added by Rajendra barhate--%>
     <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />

  <%--  <script language="javascript" type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=false"></script>--%>
  <script type="text/javascript" src="../../App_Themes/EcoDomus/Googlemaps.js"></script> 
    <script language="javascript" type="text/javascript">

        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;

        }

        function chklbl() {


            var pincode = document.getElementById("txtZipPostal").value;

            if (pincode.length < 5) {
                if (pincode != "") {
                    document.getElementById("lbltestPin").innerText = "Enter 5 digit Pincode";
                    document.getElementById("txtZipPostal").focus();
                    if (document.getElementById("txtfacilityname").value == "") {
                        document.getElementById("lblMsgError").innerText = "*";
                        return false;
                    }
                    return false;
                }

                else {
                    if (document.getElementById("txtfacilityname").value == "") {
                        document.getElementById("lblMsgError").innerText = "*";
                        return false;
                    }
                    else
                        return true;
                }
            }

            else {
                if (document.getElementById("txtfacilityname").value == "") {
                    document.getElementById("lblMsgError").innerText = "*";
                    return false;
                }
                else

                    return true;
            }

        }


        function allowOnlyNumber(evt) {

            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 44 && charCode < 58 && charCode != 47) {
                document.getElementById("<%=lblMsgValidate.ClientID %>").innerText = "";
                return true;
            }
            else {
                var str = document.getElementById("<%=lblhdn.ClientID %>").innerText;
                document.getElementById("<%=lblMsgValidate.ClientID %>").innerText = str;
                return false;
            }
        }
        function allowOnlyNumberLat(evt) {

            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 44 && charCode < 58 && charCode != 47) {
                document.getElementById("<%=lblValidate.ClientID %>").innerText = "";
                return true;
            }
            else {

                var str = document.getElementById("<%=lblhdn.ClientID %>").innerText;
                document.getElementById("<%=lblValidate.ClientID %>").innerText = str;
                return false;
            }
        }
        function close_Window() {
            window.close();
            return false;
        }

        function NavigateToFacilityPM() {

            top.location.href = "FacilityPM.aspx";


        }



        function deleteDocument() {
            var flag;
            flag = confirm("Are you sure you want to delete this Document?");
            return flag;
        }

        function GoToFacilityProfile() {

            var url = "../Locations/FacilityMenu.aspx?FacilityId=" + document.getElementById("hfFacility_id").value + "&profileflag=new";
            top.location.href = url;

        }

        function GoToFacilityProfilepopup() {

            var url = "../Locations/FacilityProfileNew.aspx?FacilityId=" + document.getElementById("hfFacility_id").value + "&profileflag=new&popupflag=popup";
            window.location.href = url;

        }

        var geocoder;

        function GetLatLngFacility() {

            geocoder = new google.maps.Geocoder();
            var strAddress1 = document.getElementById("txtAddress1").value;
            var strAddress2 = document.getElementById("txtAddress2").value;
            var strZipPostal = document.getElementById("txtZipPostal").value;
            if ((strAddress1 == "") | (strAddress2 == "") | (strZipPostal == "") | (strAddress1 == "N/A") | (strAddress2 == "N/A") | (strZipPostal == "N/A")) {
                alert("Address 1 , Address 2 and Zip Postal code are compulsary fields to get location. Please enter city name in Address 1 and city state in Address 2.");
                return false;
            }
            else {

                var strCompleteAddress = strAddress1 + ',' + strAddress2 + ',' + strZipPostal + ', USA';

                geocoder.geocode(
                                  { 'address': strCompleteAddress },
                                  function (results, status) {
                                      if (status == google.maps.GeocoderStatus.OK) {
                                          getLocation(results);
                                          // document.getElementById('ctl00_ContentPlaceHolder1_hfFacilityLatitude').value = results[0].geometry.location.lat();
                                          // document.getElementById('ctl00_ContentPlaceHolder1_hfFacilityLongitude').value = results[0].geometry.location.lng();

                                      }
                                  }
                             )
            }
        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }

        function getLocation(results) {

            document.getElementById('hfFacilityLatitude').value = results[0].geometry.location.lat();
            document.getElementById('hfFacilityLongitude').value = results[0].geometry.location.lng();


            document.getElementById('txtLatitude').value = results[0].geometry.location.lat();
            // document.getElementById('hfFacilityLatitude').value;
            //results[0].geometry.location.lat();
            document.getElementById('txtLongitude').value = results[0].geometry.location.lng();
            //document.getElementById('hfFacilityLongitude').value;
            //results[0].geometry.location.lng();

        }
        //                     function ClearLatLngTexts() {
        //                     debugger
        //                         document.getElementById('txtLatitude').value = "";
        //                         document.getElementById('txtLongitude').value = "";
        //                     }


        function Text_Changed(eve) {

            var combo = $find("cmbState");
            if (combo != null) {


                var text = combo.get_text();

                if (text == " --Select--") {

                    document.getElementById("lblError").innerText = "*";
                    document.getElementById("lblMsg1").innerText = "Please select state";
                    //alert("please select state");
                    return false;
                }
                else {

                    document.getElementById("lblError").innerText = "";
                    document.getElementById("lblMsg1").innerText = "";
                    return true;
                }


            }


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
            // document.getElementById('hf_facility_id').value = selectedItemsValues;
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


    </script>
    <script type="text/javascript">
        function setFocus() {
            document.getElementById("<%=txtfacilityname.ClientID %>").focus();
        }
        function close_Window() {
            window.close();
            return false;
        }
        function adjustHeight() {

            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                wnd.set_height(document.body.scrollHeight + 30)
                wnd.set_width(document.body.scrollWidth + 30)
            }
        }
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function adjsutHeightToReverce() {
            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                wnd.set_height(document.body.scrollHeight + 50)
                wnd.set_width(document.body.scrollWidth + 10)
            }
        }

        function adjust_height() {
          var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                //alert(x);
                //alert(y);
                //  if (x == 0)
                wnd.moveTo(x + 25, 5);

                wnd.set_height(document.body.scrollHeight + 40)
                if (document.getElementById('hf_size').value == "ALL") {
                    wnd.set_height(document.body.scrollHeight + 40)
                    wnd.set_width(document.body.scrollWidth - 100);
                    document.getElementById('hf_size').value = "";
                }

                // wnd.set_height(450);
            }
            window.parent.adjustHeight();
        }

        //window.onload = adjust_height;

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

    </script>
    
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG');  padding: 0px; margin: 0 0 0 0;" onload="setFocus();">
    <form id="form1" runat="server" style="margin: 0 0 0 0;">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div id="divProfilePage" style = " width : 100% ;" runat="server">

    <table id = "tblHeader" runat="server" border="0" width="100%" style=" display:none;" cellspacing="0">
            <tr>
                <td class="wizardHeadImage" style=" display:none;" >
                    <div class="wizardLeftImage">
                        <asp:Label ID="lblfacilityProfile" runat="server" Text="<%$Resources:Resource,Facility_Profile%>" Visible="false" Font-Names="Verdana" Font-Size="11pt"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" Width="15px" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                          OnClientClick="Javascript:return close_Window();" />
                    </div>
                </td>
            </tr>
  </table>
        <div id="Profile" style = " ">
            <table id="facProfile"  style="margin:0px;width:100%" cellspacing="0" border="0">
                
                <tr style="height: 25px;">
                    <td align="left" style="width: 30%;">
                        <b>
                            <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, Name%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 40%;">
                        <asp:TextBox ID="txtfacilityname" TabIndex="1" runat="server" CssClass="SmallTextBox"></asp:TextBox>
                        <asp:Label ID="lblMsgError" Text="" runat="server" ForeColor="Red"></asp:Label>
                        <asp:Label ID="lblfacilityname" Visible="False" runat="server" CssClass="linkText"></asp:Label>
                        <asp:RequiredFieldValidator ID="rf_validatorfacilityname" runat="server" ControlToValidate="txtfacilityname"
                            ErrorMessage="*" ForeColor="Red" Display="Dynamic" ValidationGroup="rf_validationgroup"
                            SetFocusOnError="true"> 
                        </asp:RequiredFieldValidator>
                    </td>
                    <td align="left" style="width: 40%;">
                        <b>
                            <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource, Description%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 30%;">
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="SmallTextBox" TabIndex="7"></asp:TextBox>
                        <asp:Label ID="lblDescription" runat="server" Visible="false" CssClass="linkText"></asp:Label>
                    </td>
                </tr>
                <tr style="height: 25px;">
                    <td align="left">
                        <b>
                            <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, Category%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 30%;">
                       
                        <div runat="server" id="td_category">
                         <asp:Label ID="lblcategories" runat="server" CssClass="linkText"></asp:Label>&nbsp;
                        <asp:LinkButton ID="lnkCategories" runat="server" Text="<%$Resources:Resource, Select%>"
                            OnClientClick="javascript:return omniclass_popup();" TabIndex="2"></asp:LinkButton>
                            </div>
                    </td>
                    <td align="left">
                        <b>
                            <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource, Street_Address%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 30%;">
                        <asp:TextBox ID="txtAddress1" runat="server" CssClass="SmallTextBox" TabIndex="8"></asp:TextBox>
                        <asp:Label ID="lblAddress1" Visible="false" runat="server" CssClass="linkText"></asp:Label>
                    </td>
                </tr>
                <tr style="height: 25px;">
                    <td align="left">
                        <b>
                            <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, Site_Name%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 30%;">
                        <asp:TextBox ID="txtSiteName" runat="server" CssClass="SmallTextBox" TabIndex="3"></asp:TextBox>
                        <asp:Label ID="lblsitename" runat="server" CssClass="linkText" Visible="False"></asp:Label>
                    </td>
                    <td align="left">
                        <b>
                            <asp:Label ID="Label15" runat="server" Text="<%$Resources:Resource,  City%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 30%;">
                        <asp:TextBox ID="txtCity" runat="server" CssClass="SmallTextBox" TabIndex="9" 
                             AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:Label ID="lblCity" runat="server" Visible="false" CssClass="linkText"></asp:Label>
                        <asp:Label ID="lblMsg1" CssClass="linkText" Text="" runat="server"></asp:Label>
                    </td>
                    
                </tr>
                <tr style="height: 25px;">
                    <td align="left">
                        <b>
                            <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource, Area_Measurement%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 30%;">
                        <asp:TextBox ID="txtAreaMeasurement" runat="server" CssClass="SmallTextBox" TabIndex="3"></asp:TextBox>
                        <asp:Label ID="lblAreaMeasurement" runat="server" CssClass="linkText" Visible="False"></asp:Label>
                    </td>
                     <td align="left">
                        <b>
                            <asp:Label ID="Label19" runat="server" Text="<%$Resources:Resource,  State%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 30%;">
                        <telerik:RadComboBox ID="cmbState" InitialValue="--Select--" runat="server" Width="185px"
                            Height="100px" TabIndex="11" AutoPostBack="true" Filter="Contains">
                        </telerik:RadComboBox>
                        <asp:Label ID="lblState" runat="server" Visible="false" CssClass="linkText"></asp:Label>
                        <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr style="height: 25px;">
                    <td align="left">
                        <b>
                            <asp:Label ID="Label17" runat="server" Text="<%$Resources:Resource, Project_Name%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 30%;">
                        <asp:Label ID="lblProjectName" runat="server" CssClass="linkText" Visible="False"></asp:Label>
                    </td>
                     <td align="left">
                        <b>
                            <asp:Label ID="Label10" runat="server" Text="<%$Resources:Resource,  Country%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 30%;">
                        <telerik:RadComboBox ID="cmbCountry" runat="server" Width="185px" OnSelectedIndexChanged="cmbCountry_SelectedIndexChanged"
                            AutoPostBack="True" Filter="Contains" TabIndex="17">
                        </telerik:RadComboBox>
                        <asp:Label ID="lblCountry" Visible="false" runat="server" CssClass="linkText"></asp:Label>
                    </td>
                   
                </tr>
                <tr style="height: 25px;">
                    <td align="left">
                        <b>
                            <asp:Label ID="Label11" runat="server" Text="<%$Resources:Resource,  Latitude%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 30%;">
                        <asp:TextBox ID="txtLatitude" runat="server" CssClass="SmallTextBox" TabIndex="4"
                            onkeypress="return allowOnlyNumberLat(event);"></asp:TextBox>
                        <asp:Label ID="lblValidate" ForeColor="Red" Text="" runat="server"></asp:Label>
                        <asp:Label ID="lblLatitude" Visible="false" runat="server" CssClass="linkText"></asp:Label>
                    </td>
                     <td align="left">
                        <b>
                            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,  Zip_Postal_Code%>"></asp:Label>:</b>
                    </td>
                    <td>
                        <asp:TextBox ID="txtZipPostal" runat="server" CssClass="SmallTextBox" TabIndex="10"></asp:TextBox>
                        <%--MaxLength="5"onpaste="return false" onkeypress="return onlyNumbers();"--%>
                        <asp:Label runat="server" ID="lbltestPin" Text="" ForeColor="Red"></asp:Label>
                        <asp:Label ID="lblZipPostal" Visible="false" runat="server" CssClass="linkText"></asp:Label>
                    </td>
                   
                </tr>
                <tr style="height: 25px;">
                    <td align="left">
                        <b>
                            <asp:Label ID="Label12" runat="server" Text="<%$Resources:Resource,  Longitude%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 30%;">
                        <asp:TextBox ID="txtLongitude" runat="server" CssClass="SmallTextBox" TabIndex="5"
                            onkeypress="return allowOnlyNumber(event);"></asp:TextBox>
                        <asp:Label ID="lblMsgValidate" ForeColor="Red" Text="" runat="server"></asp:Label>
                        <asp:Label ID="lblLongitude" runat="server" Visible="false" CssClass="linkText"></asp:Label>
                    </td>
                    <td>
                        <b>
                            <asp:Label ID="Label14" runat="server" Text="<%$Resources:Resource, Linear_Units%>"></asp:Label>:
                        </b>
                    </td>
                    <td>
                        <asp:TextBox ID="txtLinear_Units" runat="server" CssClass="SmallTextBox" TabIndex="12"></asp:TextBox>
                        <asp:Label ID="lblLinear_Units" runat="server"></asp:Label>
                    </td>
                </tr>
                <%-- <tr style="height: 25px;">
                    <td valign="top">
                        <b>
                            <asp:Label ID="Label14" runat="server" Text="<%$Resources:Resource, Location_Hierarchy%>"></asp:Label>:</b>
                    </td>
                    <td valign="top">
                        <asp:Table Width="200px" runat="server" ID="tblHierarchy" BorderColor="White">
                        </asp:Table>
                        <asp:LinkButton Visible="false" ID="lnkEditLocation" runat="server" Text="<%$Resources:Resource, Edit_Location_Hierarchy%>"
                            OnClientClick="javascript:return hierarchy_popup();" TabIndex="6"></asp:LinkButton>
                    </td>
                    <td align="left">
                    </td>
                    <td>
                    </td>
                </tr>--%>
                <tr>
                    <td>
                        <b>
                            <asp:Label ID="Label20" runat="server" Text="<%$Resources:Resource, Currency_Units%>"></asp:Label>:
                        </b>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCurrency_Units" runat="server" CssClass="SmallTextBox" TabIndex="12"></asp:TextBox>
                        <asp:Label ID="lblCurrency_Units" runat="server"></asp:Label>
                    </td>
                    <td>
                        <b>
                            <asp:Label ID="Label18" runat="server" Text="<%$Resources:Resource, Volume_Units%>"></asp:Label>:
                        </b>
                    </td>
                    <td>
                        <asp:TextBox ID="txtVolume_Units" runat="server" CssClass="SmallTextBox" TabIndex="12"></asp:TextBox>
                        <asp:Label ID="lblVolume_Units" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource, Area_Units%>"></asp:Label>:
                        </b>
                    </td>
                    <td>
                        <asp:TextBox ID="txtArea_Units" runat="server" CssClass="SmallTextBox" TabIndex="13"></asp:TextBox>
                        <asp:Label ID="lblArea_Units" runat="server"></asp:Label>
                    </td>
                    <td align="left" valign="top">
                        <div id="dvcreatedon" runat="server">
                            <b>
                                <asp:Label ID="Label13" runat="server" Text="<%$Resources:Resource, Created_On%>"></asp:Label>:</b>
                        </div>
                        <%-- <b>
                            <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource, Image%>" CssClass="LabelText"></asp:Label>:</b>--%>
                    </td>
                    <td valign="top" style="text-align: left; width: 30%;">
                        <asp:Label ID="lblCreatedOn" runat="server" Visible="false" CssClass="linkText"></asp:Label>
                        <%-- <asp:Label ID="lblimagename" runat="server"></asp:Label>
                        <telerik:RadUpload ID="rduploadimage" runat="server" ControlObjectsVisibility="None"
                            Width="230px" TabIndex="12">
                        </telerik:RadUpload>--%>
                    </td>
                </tr>
                <tr style="height: 20px;">
                    <td align="left" runat="server" id="td_template">
                        <b>
                            <asp:Label ID="Label16" runat="server" Text="<%$Resources:Resource, Attribute_Template%>"></asp:Label>:</b>
                    </td>
                    <td runat="server" id="td_template1">
                        <telerik:RadComboBox ID="cmb_template" runat="server" TabIndex="11" Width="180px" Height="150"
                            EmptyMessage="--Select--" OnItemDataBound="cmbtemplate_ItemDataBound">
                            <ItemTemplate>
                                <asp:CheckBox ID="chk_template" runat="server" Text='<%# Eval("template_name") %>' />
                            </ItemTemplate>
                        </telerik:RadComboBox>
                        <asp:Label ID="lbl_attribute_template" runat="server" Visible="false"></asp:Label>
                    </td>
                    <td align="left" style="display:none;">
                        <b>
                            <asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource,  Address_2%>"></asp:Label>:</b>
                    </td>
                    <td style="text-align: left; width: 30%; display:none">
                        <asp:TextBox ID="txtAddress2" runat="server" CssClass="SmallTextBox" TabIndex="9"></asp:TextBox>
                        <asp:Label ID="lblAddress2" runat="server" Visible="false" CssClass="linkText"></asp:Label>
                    </td>
                    <%--  <td align="left" valign="top">
                    <b>
                        <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource, Image%>" CssClass="LabelText"></asp:Label>:</b>
                </td>
                <td valign="top">
                    <asp:Label ID="lblimagename" runat="server" ></asp:Label>
                    <telerik:RadUpload ID="rduploadimage" runat="server" ControlObjectsVisibility="None"
                        Width="230px" TabIndex="12">
                    </telerik:RadUpload>
                 
                </td>--%>
                   
                </tr>
                <tr >
                    <td colspan="4" style="height: 20px; padding-top : 05px;">
                        <%-- <a onclick="javascript:return chklbl();">--%>
                        <asp:Button ID="btnsave" runat="server" Text="<%$Resources:Resource, Save%>" Width="80px"
                            OnClick="btnsave_Click" ValidationGroup="rf_validationgroup" TabIndex="13" Skin="Default" /><%--</a>--%>
                        <asp:Button ID="btnEdit" runat="server" Text="<%$Resources:Resource, Edit%>" Width="80px"
                            OnClick="btnedit_Click" TabIndex="13" />&nbsp;&nbsp; 
                        <asp:Button ID="btnDelete" runat="server" Text="<%$Resources:Resource, Delete%>"
                            skin="Default" Width="80" OnClick="btnDelete_Click" />
                        <asp:Button ID="btnCancel" runat="server" Visible="false" Text="<%$Resources:Resource, Cancel%>"
                            Width="80px" CausesValidation="false" OnClick="btnCancel_Click" TabIndex="14" />&nbsp;&nbsp;
                        <%--    <asp:Button ID="btnclose" runat="server" Text="<%$Resources:Resource, Close%>" Visible="false"  />--%>
                        <asp:Button ID="btnclose" runat="server" Text="<%$Resources:Resource, Close%>" Visible="false"
                            Width="80px" OnClientClick="javascript:close_Window();" CausesValidation="false" />
                    </td>
                </tr>
                <tr>
                    <th class="style1">
                    </th>
                    <td>
                        <asp:Label ID="lblMsg" runat="server" ForeColor="red"></asp:Label>
                    </td>
                    <th>
                    </th>
                  
                </tr>
            </table>
            <div id="divbtn" style="display: none;">
                <asp:HiddenField ID="hfFacility_id" runat="server" />
                <asp:HiddenField ID="hf_lblOmniClassid" runat="server" />
                <asp:HiddenField ID="hf_facility_name" runat="server" />
                <asp:HiddenField ID="hfFacilityLatitude" runat="server" />
                <asp:HiddenField ID="hfFacilityLongitude" runat="server" />
                 <asp:HiddenField ID="hf_uniclass" runat="server" />
                 <asp:HiddenField ID="hf_omniclass" runat="server" />
                 <asp:HiddenField ID = "hf_uniclass_id" runat="server" />
                <asp:HiddenField ID="hfpopupflag" runat="server" ClientIDMode="Static" />
                <asp:Button ID="btn_refresh" runat="server" OnClick="btn_refresh_Click" Style="display: none;" />
                <asp:Label ID="lblhdn" runat="server" Text="<%$Resources:Resource, Please_enter_number%>"
                    Style="display: none;"></asp:Label>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfAttachedFile" runat="server" />
    <telerik:RadWindowManager Visible="true" ID="rad_window" VisibleStatusbar="false"
        OffsetElementID="" AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false"
        runat="server" KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" OffsetElementID="txtfacilityname"
                Animation="Slide" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="true"
                AutoSize="false" Width="600" Height="400" VisibleStatusbar="false" Behaviors="Move, Resize"
                VisibleOnPageLoad="false" Skin="">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_manger_NewUI" runat="server"  VisibleTitlebar="true"  Title="Assign Category" Behaviors="Close,Move" 
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rd_window_master_Uniformat" runat="server" Width="550" AutoSizeBehaviors="Height" 
               DestroyOnClose="false" AutoSize="false" VisibleStatusbar="false" VisibleOnPageLoad="false" EnableAjaxSkinRendering="false" BackColor="#EEEEEE" 
               BorderWidth="0px" >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadCodeBlock ID="loadPopUp" runat="server">
        <script language="javascript" type="text/javascript">

            function deleteProduct() {
                var flag;
                flag = confirm("Do you want to delete this document?");
                return flag;
            }

            function load_popup(reg) {
                var url = "../Locations/AddDocument.aspx?Item_type=Facility&fk_row_id=" + document.getElementById("hfFacility_id").value + "&Document_Id=" + reg.pk_document_id; ;
                manager = $find("<%= rad_window.ClientID %>");
                var windows = manager.get_windows();
                windows[0].show();
                windows[0].setUrl(url);
                return false;
            }


            function omniclass_popup() {
                var url = "../Locations/AssignOmniclass.aspx?Item_type=Facility&id=" + document.getElementById("hfFacility_id").value;
                manager = $find("<%= rd_manger_NewUI.ClientID %>");
                var windows = manager.get_windows();
                windows[0].show();
                windows[0].setUrl(url);
               
                return false;
            }

            function hierarchy_popup() {
                var url = "../Locations/SetLocationHierarchy.aspx?Item_type=Facility&id=" + document.getElementById("hfFacility_id").value;
                manager = $find("<%= rad_window.ClientID %>");
                var windows = manager.get_windows();
                windows[0].show();
                windows[0].setUrl(url);
                return false;
            }




            function regreshgrid() {
                document.getElementById("btn_refresh").click();
            }



            function load_omni_class(name, id) {
                var isuniclass = document.getElementById('hf_uniclass').value;
                if (isuniclass == 'Y') {
                    document.getElementById('hf_uniclass_id').value = id;
                    document.getElementById('hf_lblOmniClassid').value = '';
                }
                else {
                    document.getElementById('hf_uniclass_id').value = '';
                    document.getElementById('hf_lblOmniClassid').value = id;
                }
               
                
                
                var reg = new RegExp('&nbsp;', 'g');
                name = name.replace(reg, ' ');
                document.getElementById("lblcategories").innerText = name;
            }
         

                  
        </script>
    </telerik:RadCodeBlock>
    </form>
</body>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
<style type="text/css">
        .style1
        {
            width: 19%;
        }
        .RadWindow_Simple
        {
            border: solid 0px #616161;
        }
        .RadWindow .rwTitleRow EM
            {
                font:normal 15px "Segoe UI",Arial;
                overflow:hidden;
                white-space:nowrap;
                float:left;
                text-transform:inherit;
                padding-top:0px;
                padding-left:10px;
            }
    </style>
</html>
