<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddManufacturerOrganization.aspx.cs"
    Inherits="App_Asset_AddManufacturerOrganization" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <%--<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">--%>
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        function CloseWindow() {
            // var url = GetRadWindow().BrowserWindow.location.href; ;
            //   GetRadWindow().BrowserWindow.CloseWindow();
             window.parent.resizeParentPopupReversBack();
            GetRadWindow().close();
            return false;
        }
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;

        }

        function chklbl() {
           var pincode = document.getElementById("txtPostalCode").value;
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
            var answer = confirm("Are you sure you want to delete this Organization?")
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
            var flag = vars[0].split("=");
            document.getElementById("hfIsfromClient").value = flag;


        }

        function SetCaption() {
            // debugger
            var query = parent.location.search.substring(1);
            var query2 = location.search.substring(1);
            var vars = query.split("&");
            var designerFlag = query2.split("&")[3];
            //alert(vars[1]);
            var flag = vars[0].split("=");

            //alert(abc[1]);
            document.getElementById('hfIsfromClient').value = flag[1];

            if (flag[1] == "Y") {
                if (document.getElementById('btnEdit').value == "Save") {
                    document.getElementById('org_profile_cap').innerText = "Manufacturer Profile";
                }
                else {
                    document.getElementById('org_profile_cap').innerText = "Manufacturer Profile";
                }

            }

            else {
                if (designerFlag == "IsDesigner=Y") {
                    document.getElementById('org_profile_cap').innerText = "Designer Profile";
                }
                else if (designerFlag == "IsDesigner=N") {
                    document.getElementById('org_profile_cap').innerText = "Contractor Profile";
                }
                else {
                    document.getElementById('org_profile_cap').innerText = "Manufacturer Profile";
                }
            }

        }
        function getQueryVariable() {

            //alert(parent.location.search)
         
            var query = parent.location.search.substring(1);
            var vars = query.split("&");
            //alert(vars[1]);
            var flag = vars[1].split("=");
            var flag2 = vars[2].split("=");
            var flag3 = vars[3].split("=");
            //alert(abc[1]);
            document.getElementById('hfIsfromClient').value = flag[1];

            if (flag[1] == "Y") {
                top.window.CallClickEvent('AddNewOrganization.aspx');
            }
            else if (flag[1] == 'N') {
                if (flag3[1] == "Y") {

                    top.location.href = 'Organizations.aspx';

                }
                else {
                    top.location.href = 'SettingsMenu.aspx?' + query;

                }
                //  top.location.href = 'SettingsMenu.aspx?' + query;

            }
            else {

                top.location.href = 'SettingsMenu.aspx?' + query;

            }
        }
        function RefreshParent() {

            var query = parent.location.search.substring(1);
            var vars = query.split("&");
            //alert(vars[1]);
            var flag = vars[0].split("=");
            //alert(abc[1]);

            // alert(window.parent.location.href);
            var reg = new RegExp(flag[1], 'g');
            var str = window.parent.location.href;
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
                windows[0]._width = parseInt(intWidth * 0.7);
                var intHeight = document.body.clientHeight;
                windows[0]._top = 5;
                windows[0]._height = parseInt(intHeight * 0.90);
                windows[0].setUrl(url);
                //windows[0].set_modal(false);
                windows[0].show();
            }
            return false;
        }
        function delete_() {
            var flag;
            flag = confirm("Are you sure you want to delete this Organization?");
            return flag;
        }


        function refreshgrid_country() {
            document.getElementById("btnrefresh").click();
        }
        function refreshgrid_state() {

            document.getElementById("btnrefresh_state").click();
        }

        function setTitleToWindow(title){
            var wnd = GetRadWindow();
            wnd.set_title(title);
        }

        function adjust_width() {
            var wnd = GetRadWindow();
           
            if (wnd != null) {

                wnd.set_width(document.body.scrollWidth + 100)
                wnd.set_height(document.body.scrollHeight + 50);
            }
          
            window.parent.resizeParentPopupReversBack();

        }
        function window_width() {
           
            var wnd = GetRadWindow();
            if (wnd != null) {

                wnd.set_width(document.body.scrollWidth - 200);
                wnd.set_height(document.body.scrollHeight + 10);
            }
        }
        window.onload = adjust_width;
    </script>
    <style type="text/css">
        .style1
        {
            height: 10px;
            width: 234px;
        }
        .style2
        {
            width: 86px;
        }
        .style3
        {
            height: 30px;
            width: 86px;
        }
        .style4
        {
            height: 10px;
            width: 86px;
        }
        .style5
        {
            width: 234px;
        }
        .style6
        {
            height: 30px;
            width: 234px;
        }
        .rtsSelected
        {
            background-color: transparent;
            font-weight: bold;
            font-size: 14px;
            font-family: "Arial" , sans-serif;
        }
        
        .rtsIn
        {
            background-color: transparent;
            color: #696969;
        }
        .rtsImg
        {
            background-color: transparent;
            width: 22px;
            height: 40px;
            margin: 0px;
        }
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
</head>
<telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" Skin="Default" DecoratedControls="Buttons" />
<body style=" background: white;background-color: #EEEEEE; padding: 0px;">
    <form id="form1" runat="server" style="margin: 0px 0px 0px 0px;">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager" EnableScriptCombine="false">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <table width="100%" style="border-collapse: collapse;">
       <%-- <tr>
            <td class="wizardHeadImage">
                <div class="wizardLeftImage">
                    <asp:Label ID="lbl_header" Text="Add Designer/Contractor" Font-Names="Verdana" Font-Size="11pt"
                        runat="server"></asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                        OnClientClick="javascript:return CloseWindow();" />
                </div>
            </td>
        </tr>--%>
        <tr>
            <td>
                <div align="center" style="padding-left:10px;padding-right:10px;">
                    <table id="orgprofile" width="100%" style="vertical-align: top; margin-left: 0px;
                        margin-top: 0px; border: 1;" cellpadding="0" cellspacing="0" border="0">
                        <%-- <asp:Image ID="Image3" runat="server" ImageUrl="~/App/Images/Icons/organization_profile.gif" />--%>
                        <%--        <caption id="org_profile_cap" runat="server" style="width: 400px">
            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Organization_Profile%>"></asp:Label>
        </caption>--%>
                        <tr>
                            <td class="style4">
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style2">
                                <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, Name%>"></asp:Label>:
                            </th>
                            <td class="style5">
                                <asp:TextBox CssClass="SmallTextBox" ID="txtName" Width="200px" runat="server" TabIndex="1"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName"
                                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblName" ForeColor="Red" runat="server"></asp:Label>
                            </td>
                            <th align="left">
                                <asp:Label ID="Label14" runat="server" Text="<%$Resources:Resource, Omni_Class_Type%>"></asp:Label>:
                            </th>
                            <td>
                                <telerik:RadComboBox ID="cmbOmniclassType" runat="server" TabIndex="16" Width="185px"
                                    Height="140px" Filter="Contains">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblOmniclassType" CssClass="linkText" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style2">
                                <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, Abbreviation%>"></asp:Label>:
                            </th>
                            <td class="style5">
                                <asp:TextBox CssClass="SmallTextBox" ID="txtAbbreviation" Width="200px" runat="server"
                                    TabIndex="2"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvAbbreviation" runat="server" ControlToValidate="txtAbbreviation"
                                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                                    SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblAbbreviation" runat="server"></asp:Label>
                            </td>
                            <th align="left">
                                <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, Street_Address%>"></asp:Label>:
                            </th>
                            <td>
                                <asp:TextBox CssClass="SmallTextBox" ID="txtAddress1" runat="server" TabIndex="10"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtAddress1"
                                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style2">
                                <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource,  Website%>"></asp:Label>:
                            </th>
                            <td class="style5">
                                <asp:TextBox ID="txtWebsite" CssClass="SmallTextBox" Width="200px" runat="server"
                                    TabIndex="3"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtWebsite"
                                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                                    SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ValidationGroup="my_validation"
                                    ControlToValidate="txtWebsite" ErrorMessage="*" ForeColor="Red" SetFocusOnError="True"
                                    ValidationExpression="www.[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"></asp:RegularExpressionValidator>
                            </td>
                             <th align="left">
                                <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource,  City%>"></asp:Label>:
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
                                <asp:TextBox ID="txtcity" CssClass="SmallTextBox" runat="server" TabIndex="12" AutoCompleteType="Disabled" ></asp:TextBox>
                                <%--<asp:RequiredFieldValidator ID="rfvcity" runat="server" ControlToValidate="txtcity"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
                                <asp:Label ID="lblCity" CssClass="linkText" runat="server"></asp:Label>
                                <asp:Label ID="lblMsg" CssClass="linkText" Text="" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style2">
                                <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource,  Type%>"></asp:Label>:
                            </th>
                            <td class="style5">
                                <telerik:RadComboBox ID="cmbOrganizationType" runat="server" InitialValue="--Select--"
                                    Width="205px" TabIndex="4" Height="140px" Filter="Contains">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblOrganizationType" CssClass="linkText" runat="server"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cmbOrganizationType"
                                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" InitialValue="--Select--"
                                    ForeColor="Red" SetFocusOnError="True">
                                </asp:RequiredFieldValidator>
                            </td>
                           <th align="left">
                                <asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource,  State%>"></asp:Label>:
                            </th>
                            <td>
                                <telerik:RadComboBox ID="cmbState" InitialValue="--Select--" runat="server" Width="185px"
                                    Height="100px" TabIndex="13" AutoPostBack="true" Filter="Contains">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblState" CssClass="linkText" runat="server"></asp:Label>
                                <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="cmbState"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" InitialValue="--Select--"
                    ForeColor="Red" SetFocusOnError="True">
                </asp:RequiredFieldValidator>--%>
                                <%-- <asp:Label ID="lbl_addnew" CssClass="linkText" Text="Add new" runat="server"></asp:Label>--%>
                                <asp:LinkButton ID="lnk_btn_addnewState" CssClass="linkText" OnClientClick="javascript:return openAddNewStatePopup(this)"
                                    Text="Add new" runat="server"></asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style2">
                                <asp:Label ID="Label10" runat="server" Text="<%$Resources:Resource,First_Name%>"></asp:Label>:
                            </th>
                            <td align="left" class="style5">
                                <asp:TextBox ID="txtFirstName" CssClass="SmallTextBox" runat="server" Width="200px"
                                    TabIndex="6"></asp:TextBox>
                                <asp:Label ID="lblFirstName" runat="server" CssClass="LabelText"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtFirstName"
                                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                                    SetFocusOnError="True">
                                </asp:RequiredFieldValidator>
                            </td>
                            <th align="left">
                                <asp:Label ID="Label11" runat="server" Text="<%$Resources:Resource,   Zip_Postal_Code%>"></asp:Label>:
                            </th>
                            <td>
                                <asp:TextBox CssClass="SmallTextBox" ID="txtPostalCode" runat="server" TabIndex="14"></asp:TextBox>
                                <asp:Label runat="server" ID="lbltestPin" Text="" ForeColor="Red"></asp:Label>
                                <%--MaxLength="5"onkeypress="return onlyNumbers();" onpaste="return false"--%>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtPostalCode"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                            </td> 
                        </tr>
                        <tr>
                            <th align="left" class="style2">
                                <asp:Label ID="Label15" runat="server" Text="<%$Resources:Resource,Last_Name%>"></asp:Label>:
                            </th>
                            <td align="left" class="style5">
                                <asp:TextBox ID="txtLastName" CssClass="SmallTextBox" runat="server" Width="200px"
                                    TabIndex="7"></asp:TextBox>
                                <asp:Label ID="lblLastName" runat="server" CssClass="LabelText"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtLastName"
                                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                                    SetFocusOnError="True">
                                </asp:RequiredFieldValidator>
                            </td>
                             <th align="left">
                                <asp:Label ID="Label13" runat="server" Text="<%$Resources:Resource,   Country%>"></asp:Label>:
                            </th>
                            <td>
                                <telerik:RadComboBox ID="cmb_Country" runat="server" Width="185px" TabIndex="15"
                                    AutoPostBack="true" Height="100px" OnSelectedIndexChanged="cmb_Country_SelectedIndexChanged"
                                    Filter="Contains">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblCountry" CssClass="linkText" runat="server"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cmb_Country"
                                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                                    SetFocusOnError="True">
                                </asp:RequiredFieldValidator>
                                <asp:LinkButton ID="lnk_btn_addnewCountry" CssClass="linkText" OnClientClick="javascript:return openAddNewStatePopup(this)"
                                    Text="Add new" runat="server"></asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style2">
                                <asp:Label ID="Label16" runat="server" Text="<%$Resources:Resource,Email%>"></asp:Label>:
                            </th>
                            <td align="left" class="style5">
                                <asp:TextBox ID="txtEmail" CssClass="SmallTextBox" runat="server" Width="200px" TabIndex="8"></asp:TextBox>
                                <asp:Label ID="lblEmail" runat="server" CssClass="LabelText"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtEmail"
                                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                                    SetFocusOnError="True">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEmail"
                                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                                    SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                </asp:RegularExpressionValidator>
                            </td>
                          
                            <th align="left" style="display:none;">
                                <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,  Address2%>"></asp:Label>:
                            </th>
                            <td style="display:none;">
                                <asp:TextBox ID="txtAddress2" CssClass="SmallTextBox" runat="server" TabIndex="11"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style2">
                                <asp:Label ID="Label12" runat="server" Text="<%$Resources:Resource,   Phone%>"></asp:Label>:
                            </th>
                            <td class="style1">
                                <asp:TextBox CssClass="SmallTextBox" Width="200px" ID="txtPhone" runat="server" TabIndex="9"
                                    MaxLength="25"></asp:TextBox>
                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPhone"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="style3">
                            </td>
                            <td class="style6">
                                <asp:Label ID="lblMessage" ForeColor="Red" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" align="left">
                                <%--<a onclick="javascript:return chklbl();"> --%>
                                <asp:Button ID="btnEdit" runat="server" Text="<%$Resources:Resource, Save%>" Width="100px"
                                    TabIndex="14" ValidationGroup="my_validation"  OnClick="btnEdit_Click" skin="Default" /><%--</a>--%>&nbsp;&nbsp;
                                <%--<asp:Button ID="btnEnable" runat="server" Text="Edit" Width="100px" TabIndex="16"
                    CausesValidation="false" />&nbsp;&nbsp;--%>
                                <asp:Button ID="btnCancel" runat="server" Text="<%$Resources:Resource, Cancel%>"
                                    CausesValidation="false" skin="Default" Width="100px" TabIndex="15" OnClientClick="javascript:getQueryVariable()" />&nbsp;&nbsp;
                                <asp:Button ID="btnback" runat="server" Text="<%$Resources:Resource, Cancel%>" Width="100px"
                                    TabIndex="15" OnClick="btnCancel_Click" OnClientClick="javascript:window_width()" skin="Default" />&nbsp;&nbsp;
                                <asp:Button ID="btndelete" runat="server" Text="<%$Resources:Resource, Delete%>"
                                    CausesValidation="false" Width="100px" TabIndex="15" skin="Default" OnClientClick="javascript:return delete_()"
                                    OnClick="btndelete_Click" />
                                <%--<asp:Button ID="btnDelete" runat="server" Text="Delete" Width="100px" TabIndex="16"
                    Visible="False" OnClientClick="javascript:return get1();"/>&nbsp;&nbsp;--%>
                            </td>
                            <td style="display: none;">
                                <asp:Button ID="btnrefresh" OnClick="btnrefresh_Click" runat="server" />
                                <asp:Button ID="btnrefreshcmbcountry" runat="server" OnClick="btnrefreshcmbcountry_click" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="organizationProfilesManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbState">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbCity" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <%-- <telerik:AjaxSetting AjaxControlID="btnrefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
            <telerik:AjaxSetting AjaxControlID="cmb_country">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnrefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cmbCity" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnrefresh_state">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
                    <%--  <telerik:AjaxUpdatedControl ControlID="cmbCity" LoadingPanelID="loadingPanel1" />--%>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="rad_window" runat="server" VisibleStatusbar="false"  Skin="">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="None" Behavior="Move,Close"
                KeepInScreenBounds="true" ReloadOnShow="True" BorderStyle="Solid" VisibleStatusbar="false" VisibleTitlebar="false"
               >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:HiddenField ID="hdnfldparent" runat="server" />
    <asp:HiddenField ID="hfOrganizationid" runat="server" />
    <asp:HiddenField ID="hf_NewOrganizationid" runat="server" />
    <asp:HiddenField ID="hf_SystemRole" runat="server" />
    <asp:HiddenField ID="hfIsfromClient" runat="server" />
    <asp:HiddenField ID="str_qry" runat="server" />
    <div style="display: none">
        <asp:Button ID="btnrefresh_state" OnClick="btnrefreshState_Click" runat="server" />
    </div>
    </form>
</body>
<%--</asp:Content>--%>
</html>
