<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomus_PM_New.master"  AutoEventWireup="true"
    CodeFile="ClientUserProfile.aspx.cs" Inherits="App_Settings_ClientUserProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript" language="javascript">


        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;

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
                if (str == 'popResize') {
                    wnd.set_height(document.body.scrollHeight + 260);
                    wnd.set_width(document.body.scrollWidth + 20);
                }
                if (str == 'popResizeBack') {
                    wnd.set_height(document.body.scrollHeight + 50);
                    //wnd.set_width(document.body.scrollWidth + 20);
                }
            }
        }

        function NiceScrollOnload() {
            if (screen.height > 721) {
                $("html").css('overflow-y', 'hidden');
                $("html").css('overflow-x', 'auto');
            }
            var screenhtg = set_NiceScrollToPanel();
        }


        function chklbl() {

            var btnval = document.getElementById("ContentPlaceHolder1_btnSave").value;
            

            if (btnval == "Edit") {
                return true;
            }
            else {
                var pincode = document.getElementById("ContentPlaceHolder1_txtPostalCode").value;
                if (pincode.length < 5) {
                    if (pincode != "") {
                        document.getElementById("ContentPlaceHolder1_lbltestPin").innerText = "Enter 5 digit Pincode";
                        document.getElementById("ContentPlaceHolder1_txtPostalCode").focus();
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
        function OpenOmniclassWindow() {
           
            //var url = "../Locations/AssignOmniclass.aspx?Item_type=Organization";
            var url = "../Settings/AddOmniclassUniclass.aspx?Item_type=Organization";
            manager = $find("<%= rd_manger_NewUI.ClientID %>");
            var windows = manager.get_windows();
            windows[0].show();
            windows[0].setUrl(url);
            windows[0].moveTo(300, 25);
            //window[0]._top = 25;
            windows[0].set_height(580);
            //windows[0].set_modal(false);
            return false;
        }

        function load_omni_class(name, id) {

            document.getElementById('ContentPlaceHolder1_hf_uniclass_id').value = '';
            document.getElementById('ContentPlaceHolder1_hf_lblOmniClassid').value = id;
            document.getElementById('ContentPlaceHolder1_lbl_category').innerText = name;
           
//            var isuniclass = document.getElementById('ContentPlaceHolder1_hf_uniclass').value;

//            if (isuniclass == 'Y') {
//                document.getElementById('ContentPlaceHolder1_hf_uniclass_id').value = id;
//                document.getElementById('ContentPlaceHolder1_hf_lblOmniClassid').value = '';
//            }
//            else {
//                document.getElementById('ContentPlaceHolder1_hf_uniclass_id').value = '';
//                document.getElementById('ContentPlaceHolder1_hf_lblOmniClassid').value = id;
//            }
//            var reg = new RegExp('&nbsp;', 'g');
//            name = name.replace(reg, ' ');


//            document.getElementById('ContentPlaceHolder1_lbl_category').innerText = name;
        }
        
        function setFocus() {
            if (document.getElementById("<%=txtFirstName.ClientID %>") != null)
                document.getElementById("<%=txtFirstName.ClientID %>").focus();

        }
        window.onload = setFocus;
</script>

        <script type="text/javascript" language="javascript">
            function Text_Changed(eve) {
             
               //var combo = $find("cmbState");
               var combo = document.getElementById("ctl00_ContentPlaceHolder1_cmbState").value;
                if (combo != null) {
                    
//                    var text = combo.get_text();

                    if (combo == " --Select--") {

                        document.getElementById("ContentPlaceHolder1_lblError").innerText = "*";
                        document.getElementById("ContentPlaceHolder1_lblMsg").innerText = "Please select State";
                        //alert("please select state");
                        return false;
                    }
                    else {

                        document.getElementById("ContentPlaceHolder1_lblError").innerText = "";
                        document.getElementById("ContentPlaceHolder1_lblMsg").innerText = "";
                        return true;
                    }


                }


            }


            function OpenPopupSelectOrganization() {
                var url = "../Settings/SelectOrganizationPopup.aspx";
                manager = $find("<%=radWindowMgrSelectOrganization.ClientID%>");
                var windows = manager.get_windows();
                var intWidth = document.body.clientWidth;
                windows[0]._left = parseInt(intWidth * (0.2));
                windows[0]._width = parseInt(intWidth * 0.6);
                var intHeight = document.body.clientHeight;
                windows[0]._top = 50;
                windows[0]._height = parseInt(intHeight * 1.20);
                windows[0].setUrl(url);
                windows[0].show();
                return false;
            }

            function RedirectToUser() {
                parent.window.location.href = "../Settings/User.aspx";
            }

            function RedirectToUserProfile(userid) {
                parent.window.location.href = "../Settings/UserMenu.aspx?UserId=" + userid + "&flag=";
            }

            function openAddNewStatePopup(reg) {
                var url
                if (reg.id == "ContentPlaceHolder1_lnk_btn_addnewState") {
                    var id = $find("ctl00_ContentPlaceHolder1_cmbCountry")

                    url = "../Settings/AddNewState.aspx?Id=" + id._value + "&flag=state";

                }

                else if (reg.id == "ContentPlaceHolder1_lnk_btn_addnewCity") {

                    var id = $find("ctl00_ContentPlaceHolder1_cmbCity")

                    url = "../Settings/AddNewState.aspx?Id=" + id._value + "&flag=city";

                }
                else {

                    url = "../Settings/AddNewState.aspx?Id=00000000-0000-0000-0000-000000000000&flag=country";

                }
                manager = $find("ctl00_ContentPlaceHolder1_rad_window");
                if (manager != null) {
                    var windows = manager.get_windows();
                    var intWidth = document.body.clientWidth;
                    windows[0]._left = parseInt(intWidth * (0.2));
                    windows[0]._width = parseInt(intWidth * 0.5);
                    var intHeight = document.body.clientHeight;
                    windows[0]._top = 85;
                    windows[0]._height = parseInt(intHeight * 0.6);
                    windows[0].setUrl(url);
                    windows[0].show();
                }
                return false;
            }
            function refreshgrid_country() {
                document.getElementById("ContentPlaceHolder1_btnrefresh").click();
            }
            function refreshgrid_state() {

                document.getElementById("ContentPlaceHolder1_btnrefresh_state").click();
            }
        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/New_UI_Panelbar.css" />
   
    <telerik:RadFormDecorator ID="rdfClientUserProfile" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <table width="100%" style="margin-top: 0px; margin-left: 0px;" border="0">
        <caption>
             <asp:Label ID="lblUserProfile" runat="server" Text="<%$Resources:Resource,My_Profile%>"></asp:Label>
        </caption>
        <tr>
            <td colspan="4">
            </td>
        </tr>
        <tr>
            <th style="width: 15%" align="left">
            <asp:Label ID="labelFName" runat="server" Text="<%$Resources:Resource, First_Name%>"></asp:Label>:
            </th>
            <td align="left" style="width: 25%">
                <asp:TextBox ID="txtFirstName" CssClass="SmallTextBox" runat="server" TabIndex="1"></asp:TextBox>
                <asp:Label ID="lblFirstName" runat="server" CssClass="LabelText"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtFirstName"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True">
                </asp:RequiredFieldValidator>
            </td>
            <th style="width:20%;" align="left">
                <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Phone%>"></asp:Label>:
            </th>
            <td >
                <asp:TextBox ID="txtPhoneNo" CssClass="SmallTextBox" runat="server" TabIndex="10"></asp:TextBox>
                <asp:Label ID="lblPhoneNo" runat="server" CssClass="LabelText"></asp:Label>
            </td>
        </tr>
        <tr>
            <th style="width: 120px" align="left">
                   <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, Last_Name%>"></asp:Label>:
            </th>
            <td >
                <asp:TextBox ID="txtLastName" CssClass="SmallTextBox" runat="server" TabIndex="2"></asp:TextBox>
                <asp:Label ID="lblLastName" runat="server" CssClass="LabelText"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtLastName"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True">
                </asp:RequiredFieldValidator>
            </td>
            <th style="width: 120px" align="left">
                 <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, Email%>"></asp:Label>:
            </th>
            <td align="left" style="width: 250px">
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
            <th style="width: 120px" align="left">
               <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, Title%>"></asp:Label>:
            </th>
            <td align="left" style="width: 250px">
                <asp:TextBox ID="txtTitle" CssClass="SmallTextBox" runat="server" TabIndex="3"></asp:TextBox>
                <asp:Label ID="lblTitle" runat="server" CssClass="LabelText"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtTitle"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True">
                </asp:RequiredFieldValidator>
            </td>
            <th style="width: 120px" align="left">
               <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource, Street_Address %>"></asp:Label>:
            </th>
            <td align="left" style="width: 250px">
                <asp:TextBox ID="txtAddress1" CssClass="SmallTextBox" runat="server" TabIndex="12"></asp:TextBox>
                <asp:Label ID="lblAddress1" runat="server" CssClass="LabelText"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAddress1"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <th style="width: 120px" align="left">
                 <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource, Organization %>"></asp:Label>:
            </th>
            <td align="left" style="width: 250px">
                <asp:Label ID="lblOrganization" runat="server" CssClass="LabelText"></asp:Label>
                <div id="divOrgId" style="display: none">
                    <asp:TextBox ID="txtOrganizationId" runat="server"></asp:TextBox>
                </div>
                <asp:LinkButton ID="btnSelectOrganization" runat="server" OnClientClick="javascript:return OpenPopupSelectOrganization()" TabIndex="4">Select</asp:LinkButton>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ControlToValidate="txtOrganizationId"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True">
                </asp:RequiredFieldValidator>
            </td>
             <th style="width: 120px" align="left">
                 <asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource, City %>"></asp:Label>:
            </th>
            <td align="left" style="width: 250px">
                <%--<telerik:RadComboBox ID="cmbCity" runat="server" Width="185px">
                </telerik:RadComboBox>
                --%>
                <%--<asp:LinkButton ID="lnk_btn_addnewCity" CssClass="linkText" OnClientClick="javascript:return openAddNewStatePopup(this)"
                    Text="<%$Resources:Resource, Add_New%>" runat="server"></asp:LinkButton>--%>
                <asp:TextBox ID="txtcity" runat="server" CssClass="SmallTextBox" TabIndex="14"  AutoCompleteType="Disabled" ></asp:TextBox>
                <asp:Label ID="lblCity" runat="server" CssClass="LabelText"></asp:Label>
                <asp:Label ID="lblMsg" CssClass="linkText" Text="" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <th style="width: 120px" align="left">
                 <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource, System_Role %>"></asp:Label>:
            </th>
            <td align="left" style="width: 250px">
                <telerik:RadComboBox ID="cmbSystemRole" runat="server" Width="185px" TabIndex="5">
                </telerik:RadComboBox>
                <asp:Label ID="lblSystemRole" runat="server" CssClass="LabelText"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="cmbSystemRole"
                    InitialValue="--Select--" Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*"
                    ForeColor="Red" SetFocusOnError="True">
                </asp:RequiredFieldValidator>
            </td>
            <th style="width: 120px" align="left">
                <asp:Label ID="Label11" runat="server" Text="<%$Resources:Resource, State %>"></asp:Label>:
            </th>
            <td >
            <table>
              <tr>
               <td>
                
                <telerik:RadComboBox ID="cmbState" runat="server" Width="185px" AutoPostBack="true" TabIndex="15"> <%--OnSelectedIndexChanged="cmbState_SelectedIndexChanged"--%>
                </telerik:RadComboBox>
                <asp:Label ID="lblstate" runat="server" CssClass="LabelText"></asp:Label>
                <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                </td>
                <td>
                <asp:LinkButton ID="lnk_btn_addnewState" CssClass="linkText" OnClientClick="javascript:return openAddNewStatePopup(this)"
                    Text="<%$Resources:Resource,Add_New%>" runat="server" 
                        ></asp:LinkButton>
                  
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="cmbState"
                    InitialValue="--Select--" Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*"
                    ForeColor="Red" SetFocusOnError="True">
                </asp:RequiredFieldValidator>--%>
                </td>
                </tr>
                </table>
            </td>
        </tr>
        <tr>
            <th style="width: 120px" align="left">
                <asp:Label ID="Label10" runat="server" Text="<%$Resources:Resource, Username %>"></asp:Label>:
            </th>
            <td align="left" style="width: 250px">
                <asp:TextBox ID="txtUsername" CssClass="SmallTextBox" runat="server" TabIndex="6"></asp:TextBox>
                <asp:Label ID="lblUsername" runat="server" CssClass="LabelText"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtUsername"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True">
                </asp:RequiredFieldValidator>
            </td>
          <th style="width: 120px" align="left">
                 <asp:Label ID="Label13" runat="server" Text="<%$Resources:Resource,Zip_Postal_Code%>"></asp:Label>:
            </th>
            <td align="left" style="width: 250px">
                <asp:TextBox ID="txtPostalCode" CssClass="SmallTextBox" runat="server" TabIndex="16" 
               ></asp:TextBox>
                <asp:Label runat="server" ID="lbltestPin" Text="" ForeColor="Red"></asp:Label>
                <asp:Label ID="lblPostalCode" runat="server" CssClass="LabelText"></asp:Label>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtPostalCode"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="txtPostalCode" ValidationGroup="my_validation"
                    ErrorMessage="*" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\d{5}(-\d{4})?"></asp:RegularExpressionValidator>--%>
            </td>
        </tr>
        <tr>
            <th style="width: 120px" align="left">
                  <asp:Label ID="Label12" runat="server" Text="<%$Resources:Resource, Password %>"></asp:Label>:
            </th>
            <td align="left" style="width: 250px">
                <asp:TextBox ID="txtPassword" CssClass="SmallTextBox" runat="server" 
                    TextMode="Password" TabIndex="7"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtPassword"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <th style="width: 120px" align="left">
               <asp:Label ID="Label15" runat="server" Text="<%$Resources:Resource, Country %>"></asp:Label>:
            </th>
            <td align="left" style="width: 250px">
                <telerik:RadComboBox ID="cmbCountry" runat="server" Width="185px" OnSelectedIndexChanged="cmbCountry_SelectedIndexChanged"
                    AutoPostBack="True" TabIndex="17">
                </telerik:RadComboBox>
                <asp:Label ID="lblCountry" runat="server" CssClass="LabelText"></asp:Label>
                <asp:LinkButton ID="lnk_btn_addnewCountry" CssClass="linkText" OnClientClick="javascript:return openAddNewStatePopup(this)"
                    Text="<%$Resources:Resource,Add_New%>" runat="server"></asp:LinkButton>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="cmbCountry"
                    InitialValue="--Select--" Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*"
                    ForeColor="Red" SetFocusOnError="True">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <th style="width: 120px" align="left">
                <asp:Label ID="Label14" runat="server" Text="<%$Resources:Resource, Abbreviation %>"></asp:Label>:
            </th>
            <td align="left" style="width: 250px">
                <asp:TextBox ID="txtAbbreviation" CssClass="SmallTextBox" runat="server" TabIndex="8"></asp:TextBox>
                <asp:Label ID="lblAbbreviation" runat="server" CssClass="LabelText"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtAbbreviation"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True">
                </asp:RequiredFieldValidator>
            </td>
          <th id="tdlblViewer" runat="server" align="left">
                    <asp:Label ID="label25" runat="server" Text="<%$Resources:Resource,Viewer%>"></asp:Label>:
                </th>
                <td>
                    <telerik:RadComboBox ID="cmbViewer" runat="server" Width="185px"
                      Filter="Contains" TabIndex="18" >
                    </telerik:RadComboBox>
                    <asp:Label ID="lblViewer" runat="server" CssClass="LabelText"></asp:Label>
                </td>
        </tr>
        <tr>
            <th style="width: 120px" align="left">
                <asp:Label ID="Label16" runat="server" Text="<%$Resources:Resource, Category%>"></asp:Label>:
            </th>
            <td align="left" >
             <div runat="server" id="td_category">
                 <asp:LinkButton ID="lnkAddOmniclass" runat="server" CssClass="linkText" OnClientClick="javascript:return OpenOmniclassWindow()"
                        TabIndex="3">
                        <asp:Label ID="Label20" Text="<%$Resources:Resource, Add%>" runat="server" CssClass="Label"></asp:Label></asp:LinkButton>
                    <asp:Label ID="lbl_category" runat="server" />
            </div></td>
           <th style="width:120px; display:none"  align="left" >
                <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource, Address2 %>"></asp:Label>:
            </th>
            <td align="left" style="width: 250px; display:none">
                <asp:TextBox ID="txtAddress2" CssClass="SmallTextBox" runat="server" TabIndex="13"></asp:TextBox>
                <asp:Label ID="lblAddress2" runat="server" CssClass="LabelText"></asp:Label>
            </td> 
                
        </tr>
        <tr>
            <td style="height: 30px">
            </td>
            <td style="height: 30px" colspan="3">
                <asp:Label ID="lblMessage" ForeColor="Red" runat="server"></asp:Label>
            </td>
            
        </tr>
        <tr>
            <td colspan="4">
          <%--  <telerik:RadComboBox ID="cmbOmniClass" runat="server" Width="185px" TabIndex="9">
                </telerik:RadComboBox>
                <asp:Label ID="lblOmniClass" runat="server" CssClass="LabelText"></asp:Label>--%>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="4">
                <asp:Button ID="btnSave" ValidationGroup="my_validation" Width="100px" runat="server"
                    OnClick="btnSave_Click" Text="<%$Resources:Resource,Save%>"  />
                <asp:Button ID="btnCancel" Width="100px" runat="server" Text="<%$Resources:Resource, Cancel%>" OnClick="btnCancel_Click" />
            </td>
        </tr>
    </table>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbState">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbCity" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmbCountry">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cmbCity" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnrefresh">
                <UpdatedControls>
                   <telerik:AjaxUpdatedControl ControlID="cmbCountry" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cmbState" LoadingPanelID="loadingPanel1" />
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
    <telerik:RadWindowManager ID="radWindowMgrSelectOrganization" runat="server" VisibleTitlebar="false" >
        <Windows>
            <telerik:RadWindow ID="radWindowAddClient" Title="Select Organization" runat="server"
                Animation="None" Behavior="Close,Move" KeepInScreenBounds="true"
                ReloadOnShow="True" BorderStyle="Solid" VisibleStatusbar="false" Visible="true">
            </telerik:RadWindow>
            <telerik:RadWindow ID="radWindow1" runat="server" Animation="None" Behavior="Move,Close"
                KeepInScreenBounds="true" ReloadOnShow="True" BorderStyle="Solid" VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>


    <telerik:RadWindowManager ID="rad_window" runat="server" VisibleStatusbar="false" VisibleTitlebar="false" Top = "50" Skin="">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="None" Behavior="Move,Close" 
                KeepInScreenBounds="true" ReloadOnShow="True"  VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:HiddenField runat="server" ID="hfOrganizationId" />
    <asp:HiddenField runat="server" ID="hfOrganizationName" />
    <asp:HiddenField runat="server" ID="hfUserId" />
    <asp:HiddenField runat="server" ID="hfFlag" />
    <asp:HiddenField runat="server" ID="hfFlagClone" />
    <asp:HiddenField runat="server" ID="hfPassward" />
    <asp:HiddenField runat="server" ID="hf_lblOmniClassid" />
    <asp:HiddenField runat="server" ID="hf_uniclass_id" />
    <asp:HiddenField ID="hf_uniclass" runat="server" />
    <asp:HiddenField ID="hf_category_name" runat="server" />
    <asp:HiddenField ID="hf_omniclass" runat="server" />
    <div style="display: none">
        <asp:Button ID="btnSetOrganization" runat="server" OnClick="btnSetOrganization_Click" />
        <asp:Button ID="btnrefresh" OnClick="btnrefresh_Click" runat="server" />
         <asp:Button ID="btnrefresh_state" OnClick="btnrefreshState_Click" runat="server" />
    </div> <div>
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
</asp:Content>
