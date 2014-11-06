<%@ Page Title="User Profile" Language="C#" AutoEventWireup="true"
    CodeFile="UserProfile.aspx.cs" Inherits="App.Settings.UserProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" language="javascript">
        function onlyNumbers(evt) {
                var e = event || evt; // for trans-browser compatibility
                var charCode = e.which || e.keyCode;

                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;

                return true;

            }

            function chklbl() {
                  
                  var btnvalue = document.getElementById("btnSave").value;
                  

                if (btnvalue == "Edit") {
                    return true;
                }
                else {
                    var pincode = document.getElementById("txtPostalCode").value;
                    var length = pincode.length;
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


            function OpenPopupSelectOrganization() {
                var url = "../Settings/SelectOrganizationPopup.aspx";
                manager = $find("<%=radWindowMgrSelectOrganization.ClientID%>");
                if (manager != null) {
                    var windows = manager.get_windows();
                    if (windows[0] != null) {
                        var intWidth = document.body.clientWidth;
                        windows[0]._left = parseInt(intWidth *0.12);
                        windows[0]._width = 500;

                        var intHeight = document.body.clientHeight;
                        windows[0]._top = 25;
                        windows[0]._height = 500;
                        windows[0].setUrl(url);
                        windows[0].show();
                        // windows[0].set_modal(false);
                        resizePopup('popResize');
                        return false;
                    }
                }
            }

            function RedirectToUser(ifmaster) {
                
                //var href = parent.location.href;
                var href = parent.location.href;
                var parenthref = parent.parent.location.href;
                if (parenthref.indexOf("SettingsMenu.aspx") != -1) {
                   // parent.parent.window.location.href = "../Settings/User.aspx?flag1=new&flag=&Organization_Id=" + document.getElementById('hfOrganization').value;
                   parent.parent.window.pageload("Contacts");
                }
                              
                else if (href.indexOf("UserMenu.aspx")!=-1) {
                    parent.window.location.href = "../Settings/User.aspx?Organization_Id=" + document.getElementById('hfOrganization').value;
                }
                else if (ifmaster == "from_no_master") {
                    parent.window.location.href = "../Settings/User.aspx?flag=no_master&Organization_Id=" + document.getElementById('hfOrganization').value;
                }
                else {
                    parent.window.location.href = "../Settings/User.aspx";
                }
                
            }

            function RedirectToUserProfile(userid, org_id) {
               
                var href = parent.location.href;
                var parenthref = parent.parent.location.href;
                if (parenthref.indexOf("SettingsMenu.aspx") != -1) {
                    parent.window.location.href = "../Settings/UserMenu.aspx?UserId=" + userid + "&flag=no_master&Organization_Id=" + document.getElementById('hfOrganization').value + "&flag1=no_radmenu";
                }
                else {
                    parent.window.location.href = "../Settings/UserMenu.aspx?UserId=" + userid + "&flag=&Organization_Id=" + document.getElementById('hfOrganization').value + "&flag1=showradmenu";
                }
            }
            function RedirectToUserProfilepopup(userid, org_id) {
            
               window.location.href="../Settings/UserProfile.aspx?UserId=" + userid + "&flag=&Organization_Id=" + document.getElementById('hfOrganization').value + "&flag1=showradmenu";
                
            }

            function openAddNewStatePopup(reg) {
                var url
                manager = $find("rad_window");
                var windows = manager.get_windows();
                var title = "";
                //debugger
                if (reg.id == "lnk_btn_addnewState") {
                    var id = $find("cmbCountry")

                    url = "../Settings/AddNewState.aspx?Id=" + id._value + "&flag=state";
                   title = "Add New State";
                }

                else if (reg.id == "lnk_btn_addnewCity") {

                    var id = $find("cmbState")

                    url = "../Settings/AddNewState.aspx?Id=" + id._value + "&flag=city";
                     title = "Add New City";
                }
                else {

                    document.getElementById('hfOrganization').value = document.getElementById("<%=txtPassword.ClientID %>").value;

                    url = "../Settings/AddNewState.aspx?Id=00000000-0000-0000-0000-000000000000&flag=country";
                     title = "Add New Country";
                }
               
                if (manager != null) {
                    
                    var intWidth = document.body.clientWidth;
                    windows[0]._left = parseInt(intWidth * (0.2));
                    windows[0]._width = parseInt(intWidth * 0.6);
                    var intHeight = document.body.clientHeight;
                    windows[0]._top = 5;
                    windows[0]._height = parseInt(intHeight * 0.85);
                    windows[0].setUrl(url);
                    windows[0]._titleElement.innerHTML = title;
                    windows[0].center();
                    windows[0].show();
                    return false;
                }
                return false;
            }

            function navigateurl() {

                //var href = parent.location.href;
                var href = parent.location.href;
                var parenthref = parent.parent.location.href;
                if (parenthref.indexOf("SettingsMenu.aspx") != -1) {
                    // parent.parent.window.location.href = "../Settings/User.aspx?flag1=new&flag=&Organization_Id=" + document.getElementById('hfOrganization').value;
                    parent.parent.window.pageload("Contacts");
                }

                else if (href.indexOf("UserMenu.aspx") != -1) {
                    parent.window.location.href = "../Settings/User.aspx?Organization_Id=" + document.getElementById('hfOrganization').value;
                }
                else if (ifmaster == "from_no_master") {
                    parent.window.location.href = "../Settings/User.aspx?flag=no_master&Organization_Id=" + document.getElementById('hfOrganization').value;
                }
                else {
                    parent.window.location.href = "../Settings/User.aspx";
                }

            }
            function validate() {
                var answer = confirm("Do you want to delete this User?")
                if (answer)
                    return true;
                else
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
                        wnd.set_height(document.body.scrollHeight  + 50);
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

            function LogoutNavigation() {
               
                var query = parent.location.href;
                top.location.href(query);

            }
            function closewindow() {
                window.close();
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
                windows[0].moveTo(130, 15);
                windows[0].set_height(530);
                //windows[0].set_modal(false);
                resizePopup('popResize');
                return false;
            }
            function PasswordValidationFails(errorMessg) {
                alert(errorMessg);
             }
            function load_omni_class(name, id) {

                document.getElementById('hf_uniclass_id').value = '';
                document.getElementById('hf_lblOmniClassid').value = id;
                document.getElementById('lbl_category').innerText = name;
                resizePopup('popResizeBack');
//                var isuniclass = document.getElementById('hf_uniclass').value;

//                if (isuniclass == 'Y') {
//                    document.getElementById('hf_uniclass_id').value = id;
//                    document.getElementById('hf_lblOmniClassid').value = '';
//                }
//                else {
//                    document.getElementById('hf_uniclass_id').value = '';
//                    document.getElementById('hf_lblOmniClassid').value = id;
//                }
//                var reg = new RegExp('&nbsp;', 'g');
//                name = name.replace(reg, ' ');


                //                document.getElementById('lbl_category').innerText = name;

               
               
            }

        </script>
        <style type="text/css">
            div.RadComboBox_Gray .rcbInput
            {
                height: 17px;
            }
        </style>
            <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
            <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
            <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    </telerik:RadCodeBlock>
    <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
    <style type="text/css">
        .style1
        {
            width: 50px;
        }
    </style>
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin:  0px 0px 0px 0px;">
    <form id="form1" runat="server" style="margin: 0px 0px 0px 0px;" defaultfocus="txtFirstName">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager" EnableScriptCombine="false">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <div  id="divProfilePage" style="width:99%;padding:2px;" runat="server" >
       <table id="tblheader" runat="server" border="0" width="100%" style="display:none;" cellspacing="0">
            <tr>
                <td class="wizardHeadImage" style="display:none;">
                    <div class="wizardLeftImage">
                        <asp:Label ID="lblpopup" runat="server" Text="" Visible="false" Font-Names="Verdana" Font-Size="11pt"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" Width="15px" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                          OnClientClick="Javascript:closewindow();" />
                    </div>
                </td>
            </tr>
      </table>
       <table  style="margin-top: 10px; margin-left: 20px;" border="0">
            <caption>
                <asp:Label ID="Label1" runat="server" Visible="false" Text="<%$Resources:Resource,User_Profile%>">:</asp:Label>
            </caption>
            <tr>
                <td colspan="4">
                </td>
            </tr>
            <tr>
                <th style="width: 15%" align="left">
                    <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,First_Name%>"></asp:Label>:
                </th>
                <td align="left" style="width: 30%">
                    <asp:TextBox ID="txtFirstName" CssClass="SmallTextBox" runat="server" TabIndex="1"></asp:TextBox>
                    <asp:Label ID="lblFirstName" runat="server" CssClass="LabelText"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtFirstName"
                        Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                        SetFocusOnError="True">
                    </asp:RequiredFieldValidator>
                </td>
                <th style="width: 15%" align="left">
                    <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,Phone%>"></asp:Label>:
                </th>
                <td align="left" style="width: 35%">
                    <asp:TextBox ID="txtPhoneNo" CssClass="SmallTextBox" runat="server" TabIndex="10"></asp:TextBox>
                    <asp:Label ID="lblPhoneNo" runat="server" CssClass="LabelText"></asp:Label>
                </td>
            </tr>
            <tr>
                <th align="left">
                    <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource,Last_Name%>"></asp:Label>:
                </th>
                <td align="left">
                    <asp:TextBox ID="txtLastName" CssClass="SmallTextBox" runat="server" TabIndex="2"></asp:TextBox>
                    <asp:Label ID="lblLastName" runat="server" CssClass="LabelText"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtLastName"
                        Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                        SetFocusOnError="True">
                    </asp:RequiredFieldValidator>
                </td>
                <th align="left">
                    <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,Email%>"></asp:Label>:
                </th>
                <td>
                    <asp:TextBox ID="txtEmail" CssClass="SmallTextBox" runat="server" TabIndex="11"></asp:TextBox>
                    <asp:Label ID="lblEmail" runat="server" CssClass="LabelText"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail"
                        Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                        SetFocusOnError="True">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEmail"
                        Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                        SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                    </asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <th align="left">
                    <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource,Title%>"></asp:Label>:
                </th>
                <td align="left">
                    <asp:TextBox ID="txtTitle" CssClass="SmallTextBox" runat="server" ></asp:TextBox>
                    <asp:Label ID="lblTitle" runat="server" CssClass="LabelText"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtTitle"
                        Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                        SetFocusOnError="True">
                    </asp:RequiredFieldValidator>
                </td>
                <th align="left">
                    <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource,Street_Address%>"></asp:Label>:
                </th>
                <td align="left" >
                 
                    <asp:TextBox ID="txtAddress1" CssClass="SmallTextBox" runat="server" TabIndex="12"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAddress1"
                        Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                        SetFocusOnError="True">
                    </asp:RequiredFieldValidator>
                    <asp:Label ID="lblAddress1" runat="server" CssClass="LabelText"></asp:Label>
                 
                </td>
            </tr>
            <tr>
                <th align="left">
                    <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource,Organization%>"></asp:Label>:
                </th>
                <td align="left">
                     <div id="div1" >
                    <asp:Label ID="lblOrganization" runat="server" CssClass="LabelText"></asp:Label>
                    <asp:LinkButton ID="btnSelectOrganization" runat="server" Visible="false" OnClientClick="javascript:return OpenPopupSelectOrganization()"
                        TabIndex="4">
                        <asp:Label ID="Label19" runat="server" Text="<%$Resources:Resource,Select%>"></asp:Label></asp:LinkButton>
                    </div>
                    <div id="divOrgId" style="display: none">
                        <asp:TextBox ID="txtOrganizationId" runat="server"></asp:TextBox>
                        <asp:Label ID="lblvalidate" runat="server" Text="*" CssClass="LabelNormal" Visible="false"
                        ForeColor="Red"></asp:Label>
                    </div>
                    
                    
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ControlToValidate="txtOrganizationId"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True">
                </asp:RequiredFieldValidator>--%>
                </td>
                <th align="left">
                    <asp:Label ID="Label11" runat="server" Text="<%$Resources:Resource,City%>"></asp:Label>:
                </th>
                <td>
                    <asp:TextBox ID="txtcity" CssClass="SmallTextBox" runat="server" TabIndex="14" AutoCompleteType="Disabled"></asp:TextBox>
                    <asp:Label ID="lblCity" CssClass="LabelText" runat="server"></asp:Label>
                    <asp:Label ID="lblMsg" CssClass="linkText" Text="" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th align="left">
                    <asp:Label ID="Label10" runat="server" Text="<%$Resources:Resource,System_Role%>"></asp:Label>:
                </th>
                <td align="left">
                    <telerik:RadComboBox ID="cmbSystemRole" runat="server" Width="185px" CssClass="" TabIndex="5" DataValueField = "systemRoleId" DataTextField = "systemRole">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblSystemRole" runat="server" CssClass="LabelText"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="cmbSystemRole"
                        InitialValue="--Select--" Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*"
                        ForeColor="Red" SetFocusOnError="True">
                    </asp:RequiredFieldValidator>
                </td>
                <th align="left">
                    <asp:Label ID="Label13" runat="server" Text="<%$Resources:Resource,State%>"></asp:Label>:
                </th>
                <td>
                    <table >
                        <tr>
                            <td>
                               <%-- <table style="text-align:left">
                                    <tr>
                                        <td>--%>
                                            <telerik:RadComboBox ID="cmbState" runat="server" Width="185px" AutoPostBack="true"  Height="200"
                                                Filter="Contains" TabIndex="15" DataValueField = "state_id" DataTextField = "name">
                                            </telerik:RadComboBox>
                                        </td>
                                         <td>
                                            <asp:Label ID="lblstate" runat="server"  CssClass="LabelText" ></asp:Label>
                                            <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="lnk_btn_addnewState" CssClass="linkText" OnClientClick="javascript:return openAddNewStatePopup(this)"
                                                Text="<%$Resources:Resource,Add_New%>" runat="server"></asp:LinkButton>
                                        </td>
                                       
                              <%--      </tr>
                                </table>--%>
                           <%-- </td>--%>
                            
                            <%--<td style="width:100px;">
                                
                            </td>--%>
                        </tr>
                    </table>
                </td>
                <%--<telerik:RadComboBox ID="cmbCity" runat="server" Width="185px" Filter="Contains" TabIndex="14">
                </telerik:RadComboBox>
                <asp:LinkButton ID="lnk_btn_addnewCity" CssClass="linkText" OnClientClick="javascript:return openAddNewStatePopup(this)"
                    Text="<%$Resources:Resource,Add_New%>" runat="server"></asp:LinkButton>--%>
            </tr>
            <tr>
                <th align="left">
                    <asp:Label ID="Label12" runat="server" Text="<%$Resources:Resource,Username%>"></asp:Label>:
                </th>
                <td align="left">
                    <asp:TextBox ID="txtUsername" CssClass="SmallTextBox" runat="server" TabIndex="6"></asp:TextBox>
                    <asp:Label ID="lblUsername" runat="server" CssClass="LabelText"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtUsername"
                        Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                        SetFocusOnError="True">
                    </asp:RequiredFieldValidator>
                </td>
                <th align="left">
                    <asp:Label ID="Label15" runat="server" Text="<%$Resources:Resource,Zip_Postal_Code%>"></asp:Label>:
                </th>
                <td>
                    <asp:TextBox ID="txtPostalCode" CssClass="SmallTextBox" runat="server" TabIndex="16"></asp:TextBox>
                    <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="5 digit" ControlToValidate="txtPostalCode" ValidationExpression="\d{5}" EnableClientScript="true" ></asp:RegularExpressionValidator>--%>
                    <asp:Label runat="server" ID="lbltestPin" Text="" ForeColor="Red"></asp:Label>
                    <asp:Label ID="lblPostalCode" runat="server" CssClass="LabelText"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtPostalCode"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True">
                </asp:RequiredFieldValidator>--%>
                    <%--     <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="txtPostalCode"
                    ErrorMessage="*" ForeColor="Red" ValidationGroup="my_validation" SetFocusOnError="True"
                    ValidationExpression="\d{5}(-\d{4})?"></asp:RegularExpressionValidator>--%>
                </td>
            </tr>
            <tr>
                <th align="left">
                    <asp:Label ID="Label14" runat="server" Text="<%$Resources:Resource,Password%>"></asp:Label>:
                </th>
                <td align="left" style="width: 200px">
                    <asp:TextBox ID="txtPassword" CssClass="SmallTextBoxV1" runat="server" TextMode="Password"
                        TabIndex="7"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtPassword"
                        Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
                <th align="left">
                    <asp:Label ID="Label17" runat="server" Text="<%$Resources:Resource,Country%>"></asp:Label>:
                </th>
                <td>
                    <table>
                        <tr>
                            <td>
                                <telerik:RadComboBox ID="cmbCountry" runat="server" Width="185px" OnSelectedIndexChanged="cmbCountry_SelectedIndexChanged"
                                    AutoPostBack="True" Filter="Contains" Height="25px" TabIndex="17" DataValueField = "Id" DataTextField = "Name">
                                </telerik:RadComboBox> 
                            </td>
                            <td>
                                <asp:LinkButton ID="lnk_btn_addnewCountry" CssClass="linkText" OnClientClick="javascript:return openAddNewStatePopup(this)"
                                    Text="<%$Resources:Resource,Add_New%>" runat="server"></asp:LinkButton>
                            </td>
                            <td>
                                <asp:Label ID="lblCountry" runat="server" CssClass="LabelText"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="cmbCountry"
                                    InitialValue="--Select--" Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*"
                                    ForeColor="Red" SetFocusOnError="True">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <th align="left">
                    <asp:Label ID="Label16" runat="server" Text="<%$Resources:Resource,Abbreviation%>"></asp:Label>:
                </th>
                <td align="left">
                    <asp:TextBox ID="txtAbbreviation" CssClass="SmallTextBox" runat="server" TabIndex="8"></asp:TextBox>
                    <asp:Label ID="lblAbbreviation" runat="server" CssClass="LabelText"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtAbbreviation"
                        Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                        SetFocusOnError="True">
                    </asp:RequiredFieldValidator>
                </td>
                <th align="left">
                    <asp:Label ID="Label21" runat="server" Text="<%$Resources:Resource,Time_Zone%>"></asp:Label>:
                </th>
                 <td>
                    <table>
                        <tr>
                            <td>
                                <telerik:RadComboBox ID="cmbTimeZone" runat="server" Width="185px" AutoPostBack="False" Filter="Contains" Height="25px" TabIndex="17" DataTextField = "DisplayName" DataValueField = "Id"> 
                                </telerik:RadComboBox>
                                <%--OnSelectedIndexChanged="cmbTimeZone_SelectedIndexChanged"--%> 
                            </td>
                            <%--<td>
                                <asp:LinkButton ID="LinkButton1" CssClass="linkText" OnClientClick="javascript:return openAddNewStatePopup(this)"
                                    Text="<%$Resources:Resource,Add_New%>" runat="server"></asp:LinkButton>
                            </td>--%>
                            <td>
                                <asp:Label ID="lblTimeZone" runat="server" CssClass="LabelText"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="cmbTimeZone"
                                    InitialValue="--Select--" Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*"
                                    ForeColor="Red" SetFocusOnError="True">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                    </table>
                </td>
                <%--
                <th align="left">
                    BIM Connector Installer:
                </th>
                <td class="linkText">
                    <table>--%>
                        <%-- <tr>
                            <td>
                                <asp:LinkButton Enabled="true" ID="lnkBimCon2011" runat="server" OnClick="lnkBimCon2011_Click">BIM Connector 2011 version 9.7.2012</asp:LinkButton>,
                            </td>
                        </tr>--%>
                        <%--<tr>
                            <td>
                                <asp:LinkButton Enabled="true" ID="lnkBimCon2012" runat="server" OnClick="lnkBimCon2012_Click">BIM Connector</asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>--%>
            </tr>
            <tr>
                <th align="left">
                    <asp:Label ID="Label18" runat="server" Text="<%$Resources:Resource,Category%>"></asp:Label>:
                </th>
                <td align="left">
                    <div runat="server" id="td_category">
                        <asp:Label ID="lbl_category" runat="server"  />
                        <asp:LinkButton ID="lnkAddOmniclass" runat="server" OnClientClick="javascript:return OpenOmniclassWindow()"
                            TabIndex="3">
                            <asp:Label ID="Label20" Text="<%$Resources:Resource, Select%>" runat="server"></asp:Label>
                         </asp:LinkButton>
                    </div>
                </td>
                <th align="left">
                    BIM Connector Installer:
                </th>
                <td class="linkText">
                    <table>
                        <%-- <tr>
                            <td>
                                <asp:LinkButton Enabled="true" ID="lnkBimCon2011" runat="server" OnClick="lnkBimCon2011_Click">BIM Connector 2011 version 9.7.2012</asp:LinkButton>,
                            </td>
                        </tr>--%>
                        <tr>
                            <td>
                                <asp:LinkButton Enabled="true" ID="lnkBimCon2012" runat="server" OnClick="lnkBimCon2012_Click">BIM Connector</asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="trViewer" runat="server">
                <th align="left">
                    <asp:Label ID="label25" runat="server" Text="<%$Resources:Resource,Viewer%>"></asp:Label>:
                </th>
                <td>
                    <telerik:RadComboBox ID="cmbViewer" runat="server" Width="185px" Filter="Contains" Height="70" DataTextField = "Name" DataValueField = "Id"
                        TabIndex="18">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblViewer" runat="server" CssClass="LabelText"></asp:Label>
                </td>
                <th align="left" style="display: none;">
                    <asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource,Address2%>"></asp:Label>:
                </th>
                <td style="display: none;">
                    <asp:TextBox ID="txtAddress2" CssClass="SmallTextBox" runat="server" TabIndex="13"></asp:TextBox>
                    <asp:Label ID="lblAddress2" runat="server" CssClass="LabelText"></asp:Label>
                </td>
              
            </tr>
            <tr>
                <td style="">
                </td>
                <td style="" colspan="3">
                    <asp:Label ID="lblMessage" ForeColor="Red" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                </td>
            </tr>
            <tr>
                <td align="left" colspan="4">
                    <asp:Button ID="btnSave" ValidationGroup="my_validation" Width="100px" runat="server"
                        OnClick="btnSave_Click" Text="<%$Resources:Resource,Save%>" TabIndex="18" />
                    <asp:Button ID="btnClone" Text="<%$Resources:Resource,Save_and_Clone%>" runat="server"
                        Width="100px" OnClick="btnClone_Click" ValidationGroup="my_validation" TabIndex="19" />
                    <asp:Button ID="btnDelete" Text="<%$Resources:Resource,Delete%>" runat="server" Width="100px"
                        TabIndex="20" OnClick="btnDelete_Click" OnClientClick="javascript:return validate();" />
                    <asp:Button ID="btnCancel" Text="<%$Resources:Resource,Cancel%>" runat="server" Width="100px" 
                        OnClick="btnCancel_Click" TabIndex="20" />
                    <asp:Button ID="btnclose" runat="server" Width="100" Text="<%$Resources:Resource, Close%>"
                        OnClientClick="Javascript:closewindow();" />
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
           <%-- <telerik:AjaxSetting AjaxControlID="cmbState">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbCity" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
            <telerik:AjaxSetting AjaxControlID="cmbCountry">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cmbCity" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="hfPassward">
                <UpdatedControls>
                   <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cmbCity" LoadingPanelID="loadingPanel1" />
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
             <telerik:AjaxSetting AjaxControlID="lnk_btn_addnewCountry">
                <UpdatedControls>
                   <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cmbCity" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSetOrganization">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblOrganization" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnSetOrganization">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtOrganizationId" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txtAddress1" />
                    <telerik:AjaxUpdatedControl ControlID="txtAddress2" />
                    <telerik:AjaxUpdatedControl ControlID="txtPostalCode" />
                    <telerik:AjaxUpdatedControl ControlID="txtcity" />
                    <telerik:AjaxUpdatedControl ControlID="cmbCountry" />
                    <telerik:AjaxUpdatedControl ControlID="cmbState" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="radWindowMgrSelectOrganization" runat="server" VisibleTitlebar="true" Title="Select Organization" Behaviors="Close,Move"  
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="radWindowAddClient"  runat="server" KeepInScreenBounds="true"   DestroyOnClose="false"  AutoSize="false"  AutoSizeBehaviors="Default" 
                VisibleStatusbar="false" VisibleOnPageLoad="false" EnableAjaxSkinRendering="false" EnableShadow="true" 
                Modal="true" Overlay="false" ReloadOnShow="True" BorderStyle="Solid"  >
            </telerik:RadWindow>
            <telerik:RadWindow ID="radWindow1" runat="server" Animation="None" Behavior="Move,Resize"
                KeepInScreenBounds="true" ReloadOnShow="True" BorderStyle="Solid" VisibleStatusbar="false" Skin="">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rad_window" runat="server" VisibleTitlebar="true" Title="Select Organization" Behaviors="Close,Move"  
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="None" 
                KeepInScreenBounds="true" ReloadOnShow="True" BorderStyle="Solid"  DestroyOnClose="false"  AutoSize="false"  AutoSizeBehaviors="Default" 
                VisibleStatusbar="false" VisibleOnPageLoad="false" EnableAjaxSkinRendering="false" EnableShadow="true" 
                Modal="true" Overlay="false"  >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:HiddenField runat="server" ID="hfOrganizationId" />
    <asp:HiddenField runat="server" ID="hfOrganizationName" />
    <asp:HiddenField runat="server" ID="hfUserId" />
    <asp:HiddenField runat="server" ID="hfFlag" />
    <asp:HiddenField runat="server" ID="hfFlagClone" />
    <asp:HiddenField runat="server" ID="hfPassward" />
    <asp:HiddenField runat="server" ID="hfOrganization" />
    <asp:HiddenField runat="server" ID="hfpopupflag" />
    <asp:HiddenField runat="server" ID="hf_AddNewUser" />
    <asp:HiddenField runat="server" ID="hf_lblOmniClassid" />
    <asp:HiddenField runat="server" ID="hf_uniclass_id" />
    <asp:HiddenField ID="hf_uniclass" runat="server" />
    <asp:HiddenField ID="hf_category_name" runat="server" />
    <asp:HiddenField ID="hf_omniclass" runat="server" />
    <div style="display: none">
        <asp:Button ID="btnSetOrganization" runat="server" OnClick="btnSetOrganization_Click" />
        <asp:Button ID="btnrefresh" OnClick="btnrefresh_Click" runat="server" />
        <asp:Button ID="btnrefresh_state" OnClick="btnrefreshState_Click" runat="server" />
    </div>
    <div>
        <telerik:RadWindowManager ID="rd_manger_NewUI"  runat="server" VisibleTitlebar="true" Title="Assign Classification" Behaviors="Close,Move"  
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
            <Windows>
                <telerik:RadWindow ID="rd_window_master_Uniformat" runat="server" ReloadOnShow="false"
                    Width="550" AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false"
                    OffsetElementID="btn_search" VisibleStatusbar="false" VisibleOnPageLoad="false"
                    BorderColor="Black" EnableAjaxSkinRendering="false" EnableShadow="true"
                    BackColor="Black"  BorderWidth="2" Overlay="false">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
    </form>
</body>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
</html>
