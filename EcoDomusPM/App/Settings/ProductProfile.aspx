<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductProfile.aspx.cs" Inherits="App_Central_ProductProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<head>
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />

    <script type="text/javascript" language="javascript">

        function SetOrganizationId() {
        
            document.getElementById("hf_organizationId").value = parent.document.getElementById("ContentPlaceHolder1_hfOrgid").value;
            

        }
        function NaviagtetoProducts() {
        
        location.href = "SettingsMenu.aspx?organizationid=" + parent.document.getElementById("ContentPlaceHolder1_hfOrgid").value + "";


    }
    function NaviagtetoProductGrid() {

        
        top.location.href = "SettingsMenu.aspx?organizationid=" + parent.document.getElementById("ContentPlaceHolder1_hfOrgid").value + ""; 
    
    }

    function openpopupaddomniclasslinkup() {

        
            manager = $find("rad_windowmgr");
         
            var url = "../Locations/AssignOmniclass.aspx?Item_type=type";
          
            if (manager != null) {
                var windows = manager.get_windows();
                var intWidth = document.body.clientWidth;
                windows[0]._left = parseInt(intWidth * (0.2));
                windows[0]._width = parseInt(intWidth * 0.5);
                var intHeight = document.body.clientHeight;
                //windows[0]._top = 5;
               
                windows[0]._height = parseInt(intHeight * 1);
                windows[0].setUrl(url);
                windows[0].show();
//                windows[0].center();
            }
            return false;
         }
        function refreshDoc() {
            document.getElementById("btnRefreshDoc").click();
        }

        function refreshLname() {

            var strParentPagePath = parent.document.location.pathname;
            var parentPageName = strParentPagePath.substring(strParentPagePath.lastIndexOf("/", strParentPagePath) + 1, strParentPagePath.length);
            if (parentPageName == "ProductInformation.aspx") {
                parent.document.getElementById('ctl00_ContentPlaceHolder1_lblProductname').innerHTML = document.getElementById("hflname").value;
            }
            if (parentPageName == "OrganizationProductInformation.aspx") {
                parent.document.getElementById('lblProductname').innerHTML = document.getElementById("hflname").value;
            }

        }

        function buttoncallback() {
            document.getElementById("btnselect").click();
        }

        function buttoncallback_Type() {
            document.getElementById("btnselect1").click();
        }
        function close_window() {
            self.close;
            return false;
        }
        function button_add_system() {
            document.getElementById("ctl00_ContentPlaceHolder1_Sub_Sys_add").click();
        }

        function Addsubsystem() {
            var url = "subsystem.aspx";
            window.open(url, "Window1", "menubar=no,width=400,height=450,right=50,toolbar=no,scrollbars=yes");
            return false;
        }



        var supressDropDownClosing = false;

        function OnClientDropDownClosing(sender, eventArgs) {
            eventArgs.set_cancel(supressDropDownClosing);
        }

        function OnClientSelectedIndexChanging(sender, eventArgs) {
            eventArgs.set_cancel(supressDropDownClosing);
        }

        function OnClientDropDownOpening(sender, eventArgs) {
            supressDropDownClosing = true;
        }

        function OnClientBlur(sender) {
            supressDropDownClosing = false;
            sender.toggleDropDown();
        }

        function checkboxClick(sender) {

            collectSelectedItems(sender);
        }

        function bindgriddoc() {
            document.getElementById("btnbinddocs").click();
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
        function tabOnly(event) {
            if (event.keyCode != 9) { return false; }
        }
        function Validate() {

            var flag;
            flag = confirm("Do you want this product?");
            return flag;

        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }

//        function openpopupaddomniclasslinkup() {
//            var url = "../COBIE/omniclasslinkup.aspx?Item_type='type'";
//            window.open(url, "Window1", "menubar=no,width=500,height=450,right=50,toolbar=no,scrollbars=yes");
//            return false;
//        }

// 
    </script>

    <script type="text/javascript" language="javascript">

        function closeWindow() {
            window.opener.refreshgrid();
            window.close();
            return false;
        }

        function bindlable(filename) {

            document.getElementById("filename").value = filename;

            document.getElementById("btnselect").click();

        }
        function buttoncallback2() {
            document.getElementById("btnbinddropdowns").click();
        }




        function HideFrame(MyValue) {
            if (MyValue == 'hide') {
                document.getElementById('framepage').style.visibility = 'hidden';
            }
            else {
                document.getElementById('framepage').style.visibility = 'visible';
            }
        }

        function deleteSystem() {
            var flag;
            flag = confirm("Are you sure you want to delete this Document");
            return flag;
        }

        function bindgrid() {
            document.getElementById("btnselect").click();

        }

        function openAddDocument() {



            var strProductId = window.location.search.substring(1);
            var productIdSplit = strProductId.split("=");

            var productId = productIdSplit[1];

            var url = "../Settings/AddProductDocument.aspx?id=" + productId;
            window.open(url, "Window1", "menubar=no,width=700,height=480,right=50,toolbar=no,scrollbars=y");

            //document.getElementById("ctl00_ContentPlaceHolder1_btnAddDocument").click();


            return false;
        }
        function Select() {
            var winLeft = (screen.width - 580) / 2;
            var winTop = (screen.height - 680) / 2;

            window.open("SelectOmniClass.aspx");
            return false;
        }

        function opwin() {
            window.open("SelectSystem.aspx", "Window1", "menubar=no,width=450,height=500,toolbar=no,scrollbars=yes");
            return false;
        }

        function selectsystem() {

            document.getElementById("btnAddMore").click();
        }

        function buttoncallback() {
            document.getElementById("btnAddDocs").click();
        }
        function buttoncallbackprovider() {

        }

        function opwinGuarantor() {

            window.open("SelectWarrantyGuarantor.aspx", "Window1", "menubar=no,width=800,height=480,toolbar=no,scrollbars=yes");

            return false;
        }




        var supressDropDownClosing = false;

        function OnClientDropDownClosing(sender, eventArgs) {
            eventArgs.set_cancel(supressDropDownClosing);
        }

        function OnClientSelectedIndexChanging(sender, eventArgs) {
            eventArgs.set_cancel(supressDropDownClosing);
        }

        function OnClientDropDownOpening(sender, eventArgs) {
            supressDropDownClosing = true;
        }

        function OnClientBlur(sender) {
            supressDropDownClosing = false;

            sender.toggleDropDown();
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
        function tabOnly(event) {
            if (event.keyCode != 9) { return false; }
        }



        function hiddenvaluecombo() {

        }
        function openPopupcomponent(id) {

            var url = "../Reports/ComponentProfilepopup.aspx?component_id=" + id + "&popup_flag=Y";
            window.open(url, "Window1", "menubar=no,width=900,height=500,toolbar=no,scrollbars=yes,resizeable=yes");
            return false;

        }
        function load_omni_class(name, id) {
            document.getElementById("hf_lblOmniClassid").value = id;
            var reg = new RegExp('&nbsp;', 'g');
            name = name.replace(reg, ' ');
            document.getElementById("lblOmniClass").innerText = name;
        }
        function saveAllRegisterInfo() {
            document.getElementById("btnRefresh").click();
        }

        
        
    </script>

</head>
<body style="background-position: white;  padding: 0px; margin: 0px 0px 0px 0px;background: #F7F7F7;">
    <form id="formProductProfile" runat="server" style="margin-left:1%;">
    <asp:ScriptManager ID="ScriptManagerProductProfile" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div id="divMain">
        <table id="tblMain" width="70%" style="margin-top: 20px; margin-left: 20px;" border="0">
            <tr >
                <th id="Th1" colspan="2" runat="server" align="left">
                   <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Product_Manufacturer%>"></asp:Label>:
                    <asp:Label ID="lblProductManufacturer" runat="server"></asp:Label>
                </th>
            </tr>
            <tr>
                <td colspan="4" align="left">
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </td>
            </tr>
            <tr id="tr_lname" runat="server">
                <th align="left" width="15%">
                  <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,  Long_Name%>"></asp:Label>:
                </th>
                <td align="left" style="width: 20%">
                    <table>
                        <tr>
                            <td align="left">
                                <asp:TextBox TabIndex="2" ID="txtlname" CssClass="SmallTextBox" runat="server" Height="16px"
                                    Width="220px"></asp:TextBox>
                            </td>
                           
                        </tr>
                    </table>
                </td>
               
                
                <th align="left" style="width: 30%;">
                   <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,   Short_Name%>"></asp:Label>:
                </th>
                <td align="left" style="width: 20%">
                    <table>
                        <tr>
                            <td align="left">
                                <asp:TextBox TabIndex="9" ID="txtsname" CssClass="SmallTextBox" runat="server" Height="16px"
                                    Width="220px"></asp:TextBox>
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
                   <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, OmniClass%>"></asp:Label>:
                </th>
                <td align="left">
                    <table>
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblOmniClass" runat="server" Text=""  Style="font-size: 11px; width: 420px;"></asp:Label>
                            </td>
                            <td align="left">
                               
                                <asp:LinkButton ID="btnOmniClass" TabIndex="2" runat="server" OnClientClick="javascript:return openpopupaddomniclasslinkup()">Add</asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
              
                <th align="left" style="width: 190px">
                   <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource, Description%>"></asp:Label>:
                </th>
                <td align="left" style="width: 220px">
                    <table>
                        <tr>
                            <td align="left">
                                <asp:TextBox TabIndex="10" ID="txtdescrption" CssClass="SmallTextBox" runat="server"
                                    Height="16px" Width="220px"></asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:Label ID="lbldescription" CssClass="linkText" runat="Server"></asp:Label>
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
                <th align="left" style="width:190px">
                    <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource,  Model_Number%>"></asp:Label>:
                </th>
                <td align="left" >
                    <div>
                        <table>
                            <tr>
                                <td>
                                <table><tr><td>
                                    <asp:TextBox TabIndex="3" ID="txtModelNo" Width="220px" CssClass="SmallTextBox" runat="server"
                                        Height="16px"></asp:TextBox>
                                        </td><td>
                                    <asp:RequiredFieldValidator ID="ValidatorModelNo" runat="server" ControlToValidate="txtModelNo" Display="Dynamic"
                                        ErrorMessage="*" ValidationGroup="Valid" ForeColor="Red">
                                    </asp:RequiredFieldValidator>
                                    </td></tr></table>
                                </td>
                                <td>
                                    <asp:Label ID="lblModelNo" CssClass="linkText" runat="Server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
              
                <th align="left" style="width:190px">
                     <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource,    Part_Number%>"></asp:Label>:
                </th>
                <td align="left" >
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox TabIndex="11" ID="txtPartNo" Width="220px" CssClass="SmallTextBox" runat="server"
                                        Height="16px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblPartNo" CssClass="linkText" runat="Server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
             <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width:190px">
                    <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource,    Asset_Type %>"></asp:Label>:
                </th>
                <td align="left" >
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <div style="display: block">
                                        <telerik:RadComboBox ID="ddlAssetType" TabIndex="4" runat="server" Height="100px"
                                            AppendDataBoundItems="true" Width="220px">
                                        </telerik:RadComboBox>
                                    </div>
                                </td>
                                <td>
                                    <asp:Label ID="lblAssetType" CssClass="linkText" runat="Server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
               
                <th align="left" style="width:190px">
                    <asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource,  Uniformat %>"></asp:Label>:
                </th>
                <td align="left" >
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <div style="display: block">
                                        <telerik:RadComboBox ID="ddlUniformat" TabIndex="12" runat="server" Height="100px"
                                            AppendDataBoundItems="true" Width="220px">
                                        </telerik:RadComboBox>
                                    </div>
                                </td>
                                <td>
                                    <asp:Label ID="lblUniformat" CssClass="linkText" runat="Server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
             <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width:190px">
                     <asp:Label ID="Label10" runat="server" Text="<%$Resources:Resource, Warranty_Guarantor_Parts %>"></asp:Label>:
                </th>
                <td align="left" >
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <div style="display: block">
                                        <telerik:RadComboBox ID="ddlWarrantyGuarantorParts" TabIndex="5" runat="server" Height="100px"
                                            AppendDataBoundItems="true" Width="220px">
                                        </telerik:RadComboBox>
                                    </div>
                                </td>
                                <td>
                                    <asp:Label ID="lblWarrantyGuarantorParts" CssClass="linkText" runat="Server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
             
                <th align="left" style="width:190px">
                    <asp:Label ID="Label11" runat="server" Text="<%$Resources:Resource, Warranty_Guarantor_Labor %>"></asp:Label>:
                </th>
                <td align="left" >
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <div style="display: block">
                                        <telerik:RadComboBox ID="ddlWarrantyGuarantorLabor" TabIndex="13" runat="server" Height="100px"
                                            AppendDataBoundItems="true" Width="220px">
                                        </telerik:RadComboBox>
                                    </div>
                                </td>
                                <td>
                                    <asp:Label ID="lblWarrantyGuarantorLabor" CssClass="linkText" runat="Server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
             <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width:190px">
                    <asp:Label ID="Label12" runat="server" Text="<%$Resources:Resource, Warranty_Duration_Parts%>"></asp:Label>:
                </th>
                <td align="left" >
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox TabIndex="6" ID="txtWarrantyDurationPart" Width="220px" CssClass="SmallTextBox"
                                        runat="server" Height="16px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblWarrantyDurationPart" CssClass="linkText" runat="Server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
               
                <th align="left" style="width:190px">
                    <asp:Label ID="Label13" runat="server" Text="<%$Resources:Resource, Warranty_Duration_Labor%>"></asp:Label>:
                </th>
                <td align="left" >
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox TabIndex="14" ID="txtWarrantyDurationLabor" Width="220px" CssClass="SmallTextBox"
                                        runat="server" Height="16px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblWarrantyDurationLabor" CssClass="linkText" runat="Server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
             <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width:190px">  
                    <asp:Label ID="Label14" runat="server" Text="<%$Resources:Resource, Warranty_Description%>"></asp:Label>:
                </th>
                <td align="left" >
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox TabIndex="7" ID="txtWDescription" Width="220px" CssClass="SmallTextBox"
                                        runat="server" Height="16px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblWDescription" CssClass="linkText" runat="Server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
               
                <th align="left" style="width:190px">
                    <asp:Label ID="Label15" runat="server" Text="<%$Resources:Resource, Warranty_Duration_Unit%>"></asp:Label>:
                </th>
                <td align="left" >
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <div style="display: block">
                                        <telerik:RadComboBox ID="ddlDurationUnit" TabIndex="15" runat="server" Height="100px"
                                            AppendDataBoundItems="true" Width="220px">
                                        </telerik:RadComboBox>
                                    </div>
                                </td>
                                <td>
                                    <asp:Label ID="lblDurationUnit" CssClass="linkText" runat="Server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
             <tr>
                <td style="height: 8px">
                </td>
            </tr>
            <tr>
                <th align="left" style="width:190px">
                     <asp:Label ID="Label16" runat="server" Text="<%$Resources:Resource, Replacement_Cost%>"></asp:Label>:
                </th>
                <td align="left" >
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox TabIndex="8" ID="txtRcost" Width="220px" CssClass="SmallTextBox" runat="server"
                                        Height="16px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblRcost" CssClass="linkText" runat="Server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
             
                <th align="left" style="width:190px">
                    <asp:Label ID="Label17" runat="server" Text="<%$Resources:Resource,  Expected_Life%>"></asp:Label>:
                </th>
                <td align="left" >
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox TabIndex="16" ID="txtExpectedlife" Width="220px" CssClass="SmallTextBox"
                                        runat="server" Height="16px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblExpectedlife" CssClass="linkText" runat="Server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <br />
                </td>
            </tr>
           
            <tr>
                <td colspan="4" align="left" id="tdProductDoc" style="text-align: left; vertical-align: top;"
                    runat="server">
                   
                </td>
            </tr>
            <tr style="margin-top: 6px">
                <td align="left" colspan="4">
                    <br />
                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="btnSave" ValidationGroup="Valid" runat="server" Text="<%$Resources:Resource, Edit%>" Width="100px"
                                    TabIndex="17" OnClick="btnSave_Click"  />
                            </td>
                            <td>
                                <asp:Button ID="btnCancel" CausesValidation="false" runat="server" Text="<%$Resources:Resource, Cancel%>" Width="100px" OnClientClick="javascript:SetOrganizationId();"
                                    TabIndex="18" OnClick="btnCancel_Click" />
                            </td>
                            <td>
                            <asp:Button ID="btnDelete" CausesValidation="false" runat="server" Text="<%$Resources:Resource, Delete%>" Width="100px" OnClientClick="javascript:return Validate();"
                                    TabIndex="18" OnClick="btnDelete_Click" />
                            </td>
                            <td>
                               <%-- <asp:Button ID="btnAddDocument" runat="server" Text="Add Document" Width="100px"
                                    OnClientClick="javascript:return openAddDocument();" Visible="false" /--%>
                                    &nbsp;<asp:HiddenField ID="hfregister" runat="server" />
                    <div style="display: none">
                        <asp:Button ID="btnRefreshDoc" runat="server" ></asp:Button>
                    </div>
                    <asp:HiddenField ID="hfSystemId" runat="server" />
                    <asp:HiddenField ID="hfSystemName" runat="server" />
                    <asp:HiddenField ID="hfDocumentId" runat="server" />
                    <asp:HiddenField ID="hfDocumentName" runat="server" />
                    <asp:HiddenField ID="hfManufacturerId" runat="server" />
                    <asp:HiddenField ID="filename" runat="server" />
                    <asp:HiddenField ID="hfrfafile_path" runat="server" />
                    <asp:HiddenField ID="hfrfafile_id" runat="server" />
                    <asp:HiddenField ID="hfrfadoc_name" runat="server" />
                    <asp:HiddenField ID="Type_Attributes_Id" runat="Server" Value="" />
                    <asp:HiddenField ID="Type_Job_Id" runat="Server" Value="" />
                    <asp:HiddenField ID="Type_spares_Id" runat="Server" Value="" />
                    <asp:HiddenField ID="HiddenField1" runat="Server" Value="" />
                    <asp:HiddenField ID="hftype" runat="server" />
                    <asp:HiddenField ID="hftypename1" runat="server" />
                    <asp:HiddenField ID="hfProductManufacturerOrganizationId" runat="server" />
                    <asp:HiddenField ID="hfProductManufacturerOrgPriUserId" runat="server" />
                    <asp:HiddenField ID="hfProductId" runat="server" />
                    <asp:HiddenField ID="hflname" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblError" CssClass="Message" ForeColor="Red" runat="server"></asp:Label>
                </td>
            </tr>
            <tr style="height: 20px;">
                <td colspan="4" style="padding-left: 80px;">
                    <asp:Label ID="lblMsg" runat="server" ForeColor="red"></asp:Label>
                    <br />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <div style="display: none">
                        <asp:Button ID="btnselect" Name="btnselect" runat="server" />
                        <asp:Button ID="btnbinddocs" Name="btnselect" runat="server" />
                        <asp:Button ID="btnbinddropdowns" Name="btnbinddropdowns" runat="server" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hf_lblOmniClassid" runat="server" />
    <asp:HiddenField ID="hf_organizationId" runat="server" />
    <telerik:RadAjaxManager ID="AjaxManager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRefreshDoc">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProductDoc" LoadingPanelID="loadingPanelDoc" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanelDoc" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" /> 
    </telerik:RadAjaxLoadingPanel>


    <telerik:RadWindowManager ID="rad_windowmgr" runat="server" VisibleStatusbar="false" VisibleTitlebar="false" Skin="">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="None" Behavior="Close,Move" Top="10" Left = "100"
                KeepInScreenBounds="true" ReloadOnShow="False" VisibleStatusbar="false" Skin="" VisibleTitlebar="false" VisibleOnPageLoad="false" >
            </telerik:RadWindow>
           
        </Windows>
    </telerik:RadWindowManager>
    </form>
</body>

