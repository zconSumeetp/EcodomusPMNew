<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="OrganizationProfile.aspx.cs"
    Inherits="App_Reports_OrganizationProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <telerik:RadCodeBlock ID="r1" runat="server">
        <%--<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">--%>
        <%-- <script type="text/javascript" language="javascript">--%>
        <%--  //window.onload = setFocus;--%>
        <%--</script>--%>
        <script type="text/javascript" language="javascript">

            function onlyNumbers(evt) {
                var e = event || evt; // for trans-browser compatibility
                var charCode = e.which || e.keyCode;

                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;

                return true;


            }

            function delete_() {
                var flag;
                flag = confirm("Are you sure you want to delete this Organization?");
                return flag;
            }

            function Navigate() {

                top.location.href = 'Organizations.aspx';
            }

            function chklbl() {

                var btnvalue = document.getElementById("btnEdit").value;
                var pincode = document.getElementById("txtPostalCode").value;

                if (btnvalue == "Edit") {
                    return true;
                }
                else {

                    if (pincode.length < 5) {
                        if (pincode != "") {
                            document.getElementById("lbltestPin").innerText = "Enter 5 digit Pincode";
                            document.getElementById("txtPostalCode").focus();
                            return false;
                        }

                        else {
                            return true;
                        }
                    }

                    else {

                        return true;
                    }
                }

            }


            function Text_Changed(eve) {

                var combo = $find("cmbState");
                if (combo != null) {


                    var text = combo.get_text();

                    if (text == " --Select--") {

                        document.getElementById("lblError").innerText = "*";
                        document.getElementById("lblMsg").innerText = "Please select State";
                        //alert("please select state");
                        return false;
                    }
                    else {

                        document.getElementById("lblError").innerText = "";
                        document.getElementById("lblMsg").innerText = "";
                        return true;
                    }
                }

            }

            function get1() {
                var answer = confirm("Do you want to delete this Organization?")
                if (answer)
                    return true;
                else
                    return false;

            }

            function Navigate() {

                top.location.href = 'Organizations.aspx';
            }

            function GetParentQueryString() {
                //alert('Hi');

                var query = parent.location.search.substring(1);
                var vars = query.split("&");
                //alert(vars[1]);
                var flag = vars[1].split("=");
                document.getElementById("hfIsfromClient").value = flag;


            }

            function SetCaption() {

                var query = parent.location.search.substring(1);
                var vars = query.split("&");
                //alert(vars[1]);
                var flag = vars[1].split("=");
                //alert(abc[1]);
                document.getElementById('hfIsfromClient').value = flag[1];

                if (flag[1] == "Y") {
                    if (document.getElementById('btnEdit').value == "Save") {
                        document.getElementById('org_profile_cap').innerText = "Request to add new organization";
                    }
                    else {
                        document.getElementById('org_profile_cap').innerText = "";
                    }

                }
                else {
                    if (document.getElementById('btnEdit').value == "Save") {
                        //                    document.getElementById('org_profile_cap').innerText = "Organization Profile";
                    }
                    else {
                        document.getElementById('org_profile_cap').innerText = "";
                    }

                }

            }
            function getQueryVariable(id) {
                //debugger

                //alert(parent.location.search)

                var query = parent.location.search.substring(1);
                var vars = query.split("&");

                var flag = vars[0].split("=");  //var flag = vars[1].split("=");
                var flag1 = vars[1].split("&");  //var flag1 = vars[2].split("&");
                var flag2 = flag1[0].split("=");

                document.getElementById('hfIsfromClient').value = flag1[1];

                //earlier = if (flag[1] == "Y")
                if (flag1[1] == "Y") {

                    top.window.CallClickEvent('AddNewOrganization.aspx');

                }
                //earlier =  else if (flag[1] == 'N' || flag2[1] == 'N') {
                else if (flag1[1] == 'N' || flag2[1] == 'N') {

                    if (id == "00000000-0000-0000-0000-000000000000") {
                        top.location.href = 'Organizations.aspx';
                    }
                    else {

                        var url = "../Settings/SettingsMenu.aspx?" + query;
                        parent.location.href(url);
                    }
                }
                else {
                    if (id == "00000000-0000-0000-0000-000000000000") {
                        top.location.href = 'AddNewOrganization.aspx';
                    }
                    else {

                        var url = "../Settings/SettingsMenu.aspx?" + query;
                        parent.location.href(url);

                    }

                }
            }

            function RefreshParent() {

                var query = parent.location.search.substring(1);
                var vars = query.split("&");
                //alert(vars[1]);
                var flag = vars[0].split("=");
                //alert(abc[1]);
                var str = window.parent.location.href;

                if (str.indexOf("Organization_name") == -1) {
                    var name = document.getElementById("str_name").value;
                    str = str + "?Organization_name=" + name;
                }

                // alert(window.parent.location.href);
                var reg = new RegExp(flag[1], 'g');

                str = str.replace(reg, document.getElementById('str_qry').value);
                window.parent.location.href = str;
            }

            function openAddNewStatePopup(reg) {
                //debugger
                var url
                if (reg.id == "lnk_btn_addnewState") {
                    var id = $find("cmb_Country")

                    url = "../Settings/AddNewState.aspx?Id=" + id._value + "&flag=state";

                }

                else if (reg.id == "lnk_btn_addnewCity") {

                    var id = $find("cmbState")

                    url = "../Settings/AddNewState.aspx?Id=" + id._value + "&flag=city";

                }
                else {

                    url = "../Settings/AddNewState.aspx?Id=00000000-0000-0000-0000-000000000000&flag=country";

                }
                manager = $find("rad_window");
                if (manager != null) {
                    var windows = manager.get_windows();
                    var intWidth = document.body.clientWidth;
                    windows[0]._left = parseInt(intWidth * (0.2));
                    windows[0]._width = parseInt(intWidth * 0.6);
                    var intHeight = document.body.clientHeight;
                    windows[0]._top = 5;
                    windows[0]._height = parseInt(intHeight * 0.90);
                    windows[0].setUrl(url);
                    //windows[0].set_modal(false);
                    windows[0].show();
                }
                return false;
            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }
            function refreshgrid_country() {
                document.getElementById("btnrefresh").click();
            }
            function refreshgrid_state() {

                document.getElementById("btnrefresh_state").click();
            }
            function OpenOmniclassWindow() {
                //var url = "../Locations/AssignOmniclass.aspx?Item_type=Organization";
                var url = "../Settings/AddOmniclassUniclass.aspx?Item_type=Organization";
                manager = $find("<%= rd_manger_NewUI.ClientID %>");
                var windows = manager.get_windows();
                windows[0].show();
                windows[0].setUrl(url);
                windows[0].moveTo(200, 10);
                windows[0].set_height(580);
                //windows[0].set_modal(false);
                return false;
            }
            //This function returns rad window instance to resize it popup
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }
            function resizePopup(str) {

                window.document.clear();
                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    if (str == 'expand') {
                        wnd.set_height(document.body.scrollHeight + 50);
                        //  wnd.set_width(document.body.scrollWidth + 50); resizePopup('popResizeBack')
                    }
                    else if (str == 'CollapsPopup') {
                        //wnd.set_width(document.body.scrollWidth - 20);
                        wnd.set_height(document.body.scrollHeight + 50);
                    }
                    else if (str == 'expandMesage') {
                        wnd.set_height(document.body.scrollHeight + 70);
                        //  wnd.set_width(document.body.scrollWidth + 50); resizePopup('popResizeBack')
                    }
                    else if (str == 'popResize') {
                        wnd.set_height(document.body.scrollHeight + 260);
                        wnd.set_width(document.body.scrollWidth + 20);
                    }
                    else if (str == 'popResizeBack') {
                        wnd.set_height(document.body.scrollHeight + 50);
                        //wnd.set_width(document.body.scrollWidth + 20);
                    }
                }
            }

            function load_omni_class(name, id) {
            
                
                document.getElementById('lbl_category').innerText = name;
                document.getElementById('hf_uniclass_id').value = '';
                document.getElementById('hf_lblOmniClassid').value = id;

            }
            function CloseWindow(){
                var rdw = GetRadWindow();
                rdw.close();
                
                //self.close();
            }

        </script>
        <style type="text/css">
        th {
	        font-size: 12px;
	        font-weight: normal;
	        color: #330000;
	        vertical-align:top;
	        font-weight:bolder;
	        font-family: Arial, Helvetica, sans-serif;
	        
	        padding-top:0px; 
	   }
	 td{
	         font-size : 12px;
	         font-weight : normal;
	         padding-left: 0px;
	         font-weight:normal;
	         font-family: Arial, Helvetica, sans-serif;
	         vertical-align:top;
	         text-align:left;
	         table-layout:fixed;
	    }
        </style>
    </telerik:RadCodeBlock>
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin: 0px 0px 0px 0px;">
    <form id="form1" runat="server" style="margin: 0px 0px 0px 0px;">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager" EnableScriptCombine="false">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <table id="orgprofile" width="100%" style="vertical-align: top; margin-left: 20px;
        margin-top: 0px; border: 0px;" cellpadding="0" cellspacing="0" border="0">
        <caption id="org_profile_cap" runat="server" style="width: 400px">
            <%-- <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Organization_Profile%>"></asp:Label>--%>
        </caption>
        <tr>
            <td style="height: 10px;">
            </td>
        </tr>
        <tr>
            <th align="left" style="width: 15%;">
                <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, Name%>"></asp:Label>:
                <%--<span id="spanName" runat="server" style="color: Red">*</span>--%>
            </th>
            <td style="width: 25%;">
                <asp:TextBox CssClass="SmallTextBox"  ID="txtName" Width="200px" runat="server" TabIndex="1"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:Label ID="lblName" ForeColor="Red" runat="server"></asp:Label>
            </td>
            <th align="left" style="width: 15%;">
                <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, street_Address%>"></asp:Label>:
                <%--<span id="spanAddre1" runat="server" style="color: Red">*</span>--%>
            </th>
            <td>
                <asp:TextBox CssClass="SmallTextBox" ID="txtAddress1" runat="server" TabIndex="8"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtAddress1"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="height: 8px">
            </td>
        </tr>
        <tr>
            <th align="left">
                <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, Abbreviation%>"></asp:Label>:
                <%--<span id="spanAbbreviation" runat="server" style="color: red">*</span>--%>
            </th>
            <td>
                <asp:TextBox CssClass="SmallTextBox" ID="txtAbbreviation" Width="200px" runat="server"
                    TabIndex="2"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAbbreviation" runat="server" ControlToValidate="txtAbbreviation"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="true"></asp:RequiredFieldValidator>
                <asp:Label ID="lblAbbreviation" runat="server"></asp:Label>
            </td>
            <th align="left">
                <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource,  City%>"></asp:Label>:
                <%--<span id="span4" runat="server" style="color: Red">*</span>--%>
            </th>
            <td>
                <%--<telerik:RadComboBox ID="cmbCity" runat="server" Width="185px" TabIndex="6" Height="100px" Filter="Contains">
               <Items>
                <telerik:RadComboBoxItem Selected="true" Text="--Select--" Value="0" />
                </Items>
                </telerik:RadComboBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cmbCity"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red" InitialValue="--Select--"
                    SetFocusOnError="True">
                </asp:RequiredFieldValidator>
                
                <asp:LinkButton ID="lnk_btn_addnewCity" CssClass="linkText" OnClientClick="javascript:return openAddNewStatePopup(this)"
                    Text="Add new" runat="server"></asp:LinkButton>--%>
                <asp:TextBox ID="txtcity" CssClass="SmallTextBox" runat="server" TabIndex="10" AutoCompleteType="Disabled" ></asp:TextBox>
                <%-- <asp:RequiredFieldValidator ID="rfvcity" runat="server" ControlToValidate="txtcity" Display="Dynamic" 
                     ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
                <asp:Label ID="lblCity" CssClass="linkText" runat="server"></asp:Label>
                <asp:Label ID="lblMsg" CssClass="linkText" Text="" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="height: 8px">
            </td>
        </tr>
        <tr>
            <th align="left">
                <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource,  Website%>"></asp:Label>:
                <%--<span id="spanWebsite" runat="server" style="color: Red">*</span>--%>
            </th>
            <td>
                <asp:TextBox ID="txtWebsite" CssClass="SmallTextBox" Width="200px" runat="server"
                    TabIndex="3"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtWebsite"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ValidationGroup="my_validation"
                    ControlToValidate="txtWebsite" ErrorMessage="Enter proper web address" SetFocusOnError="True"
                    ValidationExpression="www.[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"></asp:RegularExpressionValidator>--%>
            </td>
            <th align="left">
                <asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource,  State%>"></asp:Label>:
                <%--<span id="span2" runat="server" style="color: Red">*</span>--%>
            </th>
            <td>
                <table>
                    <tr>
                        <td>
                            <telerik:RadComboBox ID="cmbState" InitialValue="--Select--" runat="server" Width="185px"
                                Height="100px" TabIndex="11" AutoPostBack="true" Filter="Contains">
                            </telerik:RadComboBox>
                            <asp:Label ID="lblState" CssClass="linkText" runat="server"></asp:Label>
                            <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                        </td>
                        <td>
                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="cmbState"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" InitialValue="--Select--" ForeColor="Red"
                    SetFocusOnError="True">
                  </asp:RequiredFieldValidator>--%>
                        </td>
                        <td>
                            <%-- <asp:Label ID="lbl_addnew" CssClass="linkText" Text="Add new" runat="server"></asp:Label>--%>
                            <asp:LinkButton ID="lnk_btn_addnewState" CssClass="linkText" OnClientClick="javascript:return openAddNewStatePopup(this)"
                                Text="Add new" runat="server"></asp:LinkButton>
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
            <th align="left">
                <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource,  Type%>"></asp:Label>:
                <%--<span id="span1" runat="server" style="color: Red">*</span>--%>
            </th>
            <td>
                <telerik:RadComboBox ID="cmbOrganizationType" runat="server" InitialValue="--Select--"
                    Width="200px" TabIndex="4" Height="140px" Filter="Contains">
                </telerik:RadComboBox>
                <asp:Label ID="lblOrganizationType" CssClass="linkText" runat="server"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cmbOrganizationType"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" InitialValue="--Select--"
                    ForeColor="Red" SetFocusOnError="True">
                </asp:RequiredFieldValidator>
            </td>
            <th align="left">
                <asp:Label ID="Label11" runat="server" Text="<%$Resources:Resource, Zip_Postal_Code%>"></asp:Label>:
            </th>
            <td>
                <asp:TextBox CssClass="SmallTextBox" ID="txtPostalCode" runat="server" TabIndex="12"></asp:TextBox>
                <asp:Label runat="server" ID="lbltestPin" Text="" ForeColor="Red"></asp:Label>
                <%--MaxLength="5"onkeypress="return onlyNumbers();" onpaste="return false"--%>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtPostalCode"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
            </td>
        </tr>
        <tr>
            <td style="height: 8px">
            </td>
        </tr>
        <tr>
            <th align="left">
                <asp:Label ID="Label10" runat="server" Text="<%$Resources:Resource,   Primary_Contact%>"></asp:Label>:
            </th>
            <td>
                <telerik:RadComboBox ID="cmbPrimaryContact" runat="server" TabIndex="5" Width="200px"
                    InitialValue="--Select--" Height="140px" Filter="Contains">
                </telerik:RadComboBox>
                <asp:Label ID="lblPrimaryContact" CssClass="linkText" runat="server"></asp:Label>
            </td>
            <th align="left">
                <asp:Label ID="Label13" runat="server" Text="<%$Resources:Resource,   Country%>"></asp:Label>:
                <%--<span id="spanCountry" runat="server" style="color: Red">*</span>--%>
            </th>
            <td>
                <table>
                    <tr>
                        <td>
                            <telerik:RadComboBox ID="cmb_Country" runat="server" Width="185px" TabIndex="13"
                                AutoPostBack="true" Height="100px" OnSelectedIndexChanged="cmb_Country_SelectedIndexChanged"
                                Filter="Contains">
                            </telerik:RadComboBox>
                            <asp:Label ID="lblCountry" CssClass="linkText" runat="server"></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cmb_Country"
                                Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                                SetFocusOnError="True">
                            </asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:LinkButton ID="lnk_btn_addnewCountry" CssClass="linkText" OnClientClick="javascript:return openAddNewStatePopup(this)"
                                Text="Add new" runat="server"></asp:LinkButton>
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
            <th align="left">
                <asp:Label ID="Label12" runat="server" Text="<%$Resources:Resource,   Phone%>"></asp:Label>:
            </th>
            <td class="style1">
                <asp:TextBox CssClass="SmallTextBox" Width="200px" ID="txtPhone" runat="server" TabIndex="6"
                    MaxLength="25"></asp:TextBox>
                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPhone"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
            </td>
           <th align="left" style="width: 190px; display:none">
                <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,  Address2%>"></asp:Label>:
            </th>
            <td style="display:none;">
                <asp:TextBox ID="txtAddress2" CssClass="SmallTextBox" runat="server" TabIndex="9"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="height: 8px">
            </td>
        </tr>
        <tr>
            <th align="left">
                <asp:Label ID="Label14" runat="server" Text="<%$Resources:Resource, Category%>"></asp:Label>:
            </th>
            <td >
                <div runat="server" id="td_category">
                <asp:LinkButton ID="lnkAddOmniclass" runat="server" CssClass="linkText" OnClientClick="javascript:return OpenOmniclassWindow()"
                    TabIndex="3">
                    <asp:Label ID="Label20" Text="<%$Resources:Resource, Add%>" runat="server" CssClass="Label"></asp:Label></asp:LinkButton>
                <asp:Label ID="lbl_category" runat="server" />
                </div>
            </td>
        </tr>
        <tr>
            <td style="height: 30px">
            </td>
            <td style="height: 30px">
                <asp:Label ID="lblMessage" ForeColor="Red" runat="server"></asp:Label>
               <%-- <telerik:RadComboBox ID="cmbOmniclassType" runat="server" TabIndex="7" Width="200px"
                    Height="140px" Filter="Contains">
                </telerik:RadComboBox>
                <asp:Label ID="lblOmniclassType" CssClass="linkText" runat="server"></asp:Label>--%>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="left">
                <%-- <a onclick="javascript:return chklbl();">--%>
                <asp:Button ID="btnEdit" runat="server" Text="<%$Resources:Resource, Save%>" Width="100px"
                    TabIndex="14" ValidationGroup="my_validation" OnClick="btnEdit_Click" /><%--</a>--%>&nbsp;&nbsp;
                <%--<asp:Button ID="btnEnable" runat="server" Text="Edit" Width="100px" TabIndex="16"
                    CausesValidation="false" />&nbsp;&nbsp;--%>
                <asp:Button ID="btnCancel" runat="server" Text="<%$Resources:Resource, Cancel%>"
                    CausesValidation="false" Width="100px" TabIndex="15" OnClick="btnCancel_Click" />&nbsp;&nbsp;<%--OnClientClick="javascript:getQueryVariable()"--%>
                <%--<asp:Button ID="btnDelete" runat="server" Text="Delete" Width="100px" TabIndex="16"
                    Visible="False" OnClientClick="javascript:return get1();"/>&nbsp;&nbsp;--%>
                <asp:Button ID="btnDelete" runat="server" Text="<%$Resources:Resource, Delete%>"
                    CausesValidation="false" Width="100px" TabIndex="15" OnClick="btnDelete_Click"
                    OnClientClick="javascript:return delete_()" />
            </td>
            <td style="display: none;">
                <asp:Button ID="btnrefresh" OnClick="btnrefresh_Click" runat="server" />
                <asp:Button ID="btnrefresh_state" OnClick="btnrefresh_state_Click" runat="server" />
            </td>
             
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <%-- <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>--%>
    <telerik:RadAjaxManager ID="organizationProfilesManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbState">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbCity" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmb_country">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnrefresh_state">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmb_country">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cmbCity" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="lnk_btn_addnewCountry">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cmbCity" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="rad_window" runat="server" VisibleStatusbar="false" Skin="">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="None" Behavior="Move,Resize"
                KeepInScreenBounds="true" ReloadOnShow="True"  VisibleStatusbar="false" VisibleTitlebar="false"
                >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:HiddenField ID="hdnfldparent" runat="server" />
    <asp:HiddenField ID="hfIsfromClient" runat="server" />
    <asp:HiddenField ID="str_qry" runat="server" />
    <asp:HiddenField ID="str_name" runat="server" />
    <asp:HiddenField runat="server" ID="hf_lblOmniClassid" />
    <asp:HiddenField runat="server" ID="hf_uniclass_id" />
    <asp:HiddenField ID="hf_uniclass" runat="server" />
    <asp:HiddenField ID="hf_omniclass" runat="server" />
    <asp:HiddenField ID="hf_category_name" runat="server" />
     <div>
        <telerik:RadWindowManager ID="rd_manger_NewUI" runat="server" BorderColor="Black"
            BorderWidth="2" Skin="">
            <Windows>
                <telerik:RadWindow ID="rd_window_master_Uniformat" runat="server" ReloadOnShow="false"
                    Width="550" AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false"
                    OffsetElementID="btn_search" VisibleStatusbar="false" VisibleOnPageLoad="false"
                    Behaviors="Resize,Move" BorderColor="Black" EnableAjaxSkinRendering="false" EnableShadow="true"
                    BackColor="Black" VisibleTitlebar="false" BorderWidth="2" Overlay="false">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
    </form>
</body>
<%--</asp:Content>--%>
</html>
