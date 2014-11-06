<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="ProjectProfile.aspx.cs"
    Inherits="App_Settings_ProjectProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Project Profile</title> 
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">

            function onlyNumbers(evt) {
                var e = event || evt; // for trans-browser compatibility
                var charCode = e.which || e.keyCode;

                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;

                return true;

            }

            function Text_Changed(eve) {

                var combo = $find("ddlState");
                if (combo != null) {


                    var text = combo.get_text();

                    if (text == " --Select--") {

                        document.getElementById("lblError1").innerText = "*";
                        document.getElementById("lblmsgState").innerText = "Please select State";
                        //alert("please select state");
                        return false;
                    }
                    else {

                        document.getElementById("lblError1").innerText = "";
                        document.getElementById("lblmsgState").innerText = "";
                        return true;
                    }
                }

            }



            function naviagatetoProject(url) {
                //top.location.href="Project.aspx";
                top.location.href = url;
            }
            function showImage() {
                if (document.getElementById('imgDiv') != null) {

                    document.getElementById('imgDiv').style.visibility = "visible";
                }
                return true;
            }

            function OpenPopupSelectOrganization(type) {

                if (type == "L") {
                    var url = "../Settings/AssignOrganization.aspx?type=L";
                    manager = $find("<%=radWindowMgrSelectOrganization.ClientID%>");
                    var windows = manager.get_windows();
                    var intWidth = document.body.clientWidth;
                    windows[0]._left = parseInt(intWidth * (0.2));
                    windows[0]._width = parseInt(intWidth * 0.52);
                    var intHeight = document.body.clientHeight;

                    windows[0]._height = parseInt(intHeight * 1.3);
                    windows[0].setUrl(url);
                    windows[0].show();

                    windows[0].set_modal(false);
                    return false;
                }
                else {
                    var url = "../Settings/AssignOrganization.aspx?type=O";
                    manager = $find("<%=radWindowMgrSelectOrganization.ClientID%>");
                    var windows = manager.get_windows();
                    var intWidth = document.body.clientWidth;
                    windows[0]._left = parseInt(intWidth * (0.2));
                    windows[0]._width = parseInt(intWidth * 0.52);
                    var intHeight = document.body.clientHeight;

                    windows[0]._height = parseInt(intHeight * 1.3);
                    windows[0].setUrl(url);
                    windows[0].show();
                    windows[0].set_modal(false);
                    return false;
                }
            }


            function delete_() {
                var flag;
                flag = confirm("Are you sure you want to delete?");
                return flag;
            }

            function GotoProfile() {
                top.location.href = "ProjectMenu.aspx?pagevalue=ProjectProfile&pk_project_id=" + document.getElementById("<%=hfProjectId.ClientID %>").value + "";
            }


            function GotoLeadOrganizationProfile(id) {

                top.location.href = "../Settings/SettingsMenu.aspx?organization_id=" + id + "&Organization_name=" + document.getElementById('hf_lead_org_name').value;
            }

            function GotoOwnerOrganizationProfile(id) {
                top.location.href = "SettingsMenu.aspx?organization_id=" + id + "&Organization_name=" + document.getElementById('hf_org_name').value;
            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }
            function chklbl() {


                var pincode = document.getElementById("txtPostalCode").value;
                if (document.getElementById("<%=txtProjectName.ClientID%>").value == "") {


                    document.getElementById("lblprojname").innerText = "*";

                    document.getElementById("<%=txtProjectName.ClientID%>").focus();
                    return false;

                }
                else if (document.getElementById("<%=lblOwnerNm.ClientID%>").innerText == "") {

                    document.getElementById("lblselect").innerText = "*";
                    return false;

                }

                else if (pincode.length < 5) {
                    if (pincode != "") {
                        document.getElementById("lbltest").innerText = "Enter 5 digit Pincode";
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

            function bind_dropdown() {

                document.getElementById("btnphase").click(); //added
                document.getElementById("btnOrgChangeAddress").click();

            }
            function checkboxClick(sender) {

                collectSelectedItems(sender);
                // document.getElementById('ContentPlaceHolder1_btn_navigate').click();

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
                    else {
                        var unseelectedText = item.get_text();
                        var unselectedValue = item.get_value();
                        selectedItemsTexts.replace(item.get_text(), '');

                    }
                }  //for closed

                document.getElementById('hf_uniclass_id').value;
                document.getElementById('hf_OmniClass2010').value
                selectedItemsTexts = selectedItemsTexts.substring(0, selectedItemsTexts.length - 2);
                selectedItemsValues = selectedItemsValues.substring(0, selectedItemsValues.length - 2);

                //Set the text of the RadComboBox with the texts of the selected Items, separated by ','.
                combo.set_text(selectedItemsTexts);

                alert(selectedItemsTexts);
                //Set the comboValue hidden field value with values of the selected Items, separated by ','.

                if (selectedItemsValues == "") {
                    combo.clearSelection();
                }
                //document.getElementById('ContentPlaceHolder1_hfFacilityid').value = selectedItemsValues;   
            }

        </script>
        <script type="text/javascript" src="../../App_Themes/EcoDomus/jquery-1.8.3.js"></script>
    </telerik:RadCodeBlock>
    <style type="text/css">
        .style1
        {
            width: 10%;
        }
        a
        {
            color: Gray;
        }
        a:hover
        {
            color: #CC0000;
        }
        th
        {
            font-size: 12px;
            font-weight: normal;
            color: #330000;
            vertical-align: top;
            font-weight: bolder;
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            padding-top: 0px;
            width: 15%;
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
        .profileName
        {
            color: #990000;
            font-family: Arial;
            font-size: 16px;
            font-style: normal;
            font: 12px;
            font-weight: lighter;
            padding-bottom: 5px;
        }
    </style>
</head>
<%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />--%>
<body style="background: transparent; background-image: url('../Images/asset_zebra-bkgrd_gray2.PNG');
    padding: 10px; margin: 0 0 0 0;">
    <form id="form1" runat="server" style="margin: 0 0 0 0;" defaultfocus="txtProjectName">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfAll" DecoratedControls="Buttons" Skin="Default"
        runat="server" />
    <div style="display: none">
        <asp:Button ID="btnrefreshgrid" runat="server" />
        <asp:LinkButton ID="PostBack1" runat="server" CausesValidation="false" Text="">
        </asp:LinkButton>
    </div>
    <div id="Profile22" style="padding-left: 0px;" runat="server">
        <table width="90%" style="vertical-align: top; border-collapse: collapse" cellpadding="0"
            cellspacing="2" border="0">
            <caption style="text-align: left">
                <asp:Label ID="lbl_title" runat="server" CssClass="profileName" Text="<%$Resources:Resource,Project_Profile%>"
                    Visible="true"></asp:Label>
            </caption>
            <tr>
                <th style="width: 15%">
                    <asp:Label ID="lbl_project" runat="server" CssClass="LabelText" Text="<%$Resources:Resource,Project_Name%>"></asp:Label>:
                </th>
                <td class="tdTextBox" style="width: 25%; padding: 0px;">
                    <table>
                        <tr>
                            <td align="left">
                                <asp:TextBox ID="txtProjectName" Width="180px" runat="server" CssClass="SmallTextBox"
                                    TabIndex="1"></asp:TextBox>
                                <asp:Label ID="lblProjectName" runat="server" CssClass="LabelText"></asp:Label>
                            </td>
                            <td align="left">
                            </td>
                            <td>
                                <asp:Label ID="lblprojname" runat="server" ForeColor="Red" Text=""></asp:Label>
                                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtProjectName" ForeColor="Red"
                        Display="Dynamic" ValidationGroup="My_Vgroup" EnableClientScript="true" ErrorMessage="*" SetFocusOnError="True"
                        TabIndex="7"></asp:RequiredFieldValidator>--%>
                            </td>
                            <td>
                                <asp:HiddenField ID="hfValue" runat="server" />
                                <asp:HiddenField ID="hftemp" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="width: 10px;">
                </td>
                <th style="width: 15%">
                    <asp:Label ID="lbl_address1" runat="server" CssClass="LabelText" Text="<%$Resources:Resource,Street_Address%>">
                    </asp:Label>:
                </th>
                <td class="tdTextBox" style="width: 301px">
                    <asp:TextBox ID="txtAddress1" runat="server" Width="182px" CssClass="SmallTextBox"
                        TabIndex="7"></asp:TextBox>
                    <asp:Label ID="lblAddress1" runat="server" CssClass="LabelText"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtAddress1" ForeColor="Red"
                        Display="Dynamic" ValidationGroup="My_Vgroup" EnableClientScript="true" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                </td>
                <td rowspan="4">
                    <div style="float: right; padding-right: 3px; margin-left: 3px;" id="imgDiv" runat="server">
                        <asp:Image ID="ImgProjectLogo" runat="server" Width="150px" Height="60px" />
                    </div>
                    <asp:Label ID="lblimgmsg" runat="server" Visible="false"></asp:Label>
                </td>
                <%--<td>
                   <div style="float:right;padding-right:10px; margin-left:80px; ">
                  <asp:Image ID="ImgProjectLogo" runat="server" Width="150px" Height="60px" />
                     <asp:Label ID="lblimgmsg" runat="server" Visible="false"></asp:Label>
                   </div>                 
                </td>--%>
            </tr>
            <tr style="height: 10px">
                <td>
                </td>
            </tr>
            <tr>
                <th>
                    <asp:Label ID="lbl_enabled" runat="server" CssClass="LabelText" Text="<%$Resources:Resource,Enabled%>"></asp:Label>:
                </th>
                <td class="tdTextBox" style="width: 301px;">
                    <telerik:RadComboBox ID="ddlEnabled" runat="server" CssClass="rcbItem" Height="140px"
                        MarkFirstMatch="true" TabIndex="2" Width="186px">
                        <Items>
                            <telerik:RadComboBoxItem Selected="True" Text="Yes" Value="1" />
                            <telerik:RadComboBoxItem Text="No" Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                    <asp:Label ID="lblEnabled" runat="server" CssClass="rtIn">
                    </asp:Label>
                </td>
                <td style="width: 10px;">
                </td>
                <th>
                    <asp:Label ID="lbl_city" runat="server" CssClass="LabelText" Text="<%$Resources:Resource,City%>"></asp:Label>:
                </th>
                <td class="tdTextBox">
                    <asp:TextBox ID="txtCity" runat="server" CssClass="SmallTextBox" TabIndex="9" Width="184px"
                        AutoCompleteType="Disabled"></asp:TextBox>
                    <asp:Label ID="lblmsgState" CssClass="linkText" Text="" runat="server"></asp:Label>
                    <asp:Label ID="lblCity" runat="server" CssClass="LabelText"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtCity" ForeColor="Red"
                        Display="Dynamic" ValidationGroup="My_Vgroup" EnableClientScript="true" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr style="height: 10px">
                <td>
                </td>
            </tr>
            <tr>
                <th>
                    <asp:Label ID="lbl_lead_organization" runat="server" CssClass="LabelText" Text="<%$Resources:Resource,Lead_Organization%>"></asp:Label>:
                </th>
                <td class="tdTextBox" style="width: 301px">
                    <asp:HiddenField ID="hflblOrganization" runat="server" />
                    <asp:LinkButton ID="lblCreatedNm" runat="server" OnClick="lead_org_link"></asp:LinkButton>
                    &nbsp;&nbsp;
                    <asp:LinkButton ID="linkOrganizationChange" runat="server" CausesValidation="false"
                        CssClass="linkText" OnClientClick="javascript:return OpenPopupSelectOrganization('L')"
                        TabIndex="3" Text="Select" Font-Size="Small"></asp:LinkButton>
                    <asp:LinkButton ID="PostBack" runat="server" CausesValidation="false" Text="">
                                                
                    </asp:LinkButton>
                </td>
                <td style="width: 10px;">
                </td>
                <th>
                    <asp:Label ID="lbl_postal_code" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,Zip_Postal_Code%>"></asp:Label>:
                </th>
                <td class="tdTextBox">
                    <asp:TextBox ID="txtPostalCode" runat="server" CssClass="SmallTextBox" TabIndex="10"
                        Width="184px"></asp:TextBox>
                    <%-- MaxLength="5" onkeypress="return onlyNumbers();" onpaste="return false"--%>
                    <asp:Label runat="server" ID="lbltest" Text="" ForeColor="Red"></asp:Label>
                    <asp:Label ID="lblPostalCode" runat="server" CssClass="LabelText"></asp:Label>
                </td>
            </tr>
            <tr style="height: 10px">
                <td>
                </td>
            </tr>
            <tr>
                <th>
                    <asp:Label ID="lbl_owner_organization" Text="<%$Resources:Resource,Owner_Organization%>"
                        CssClass="LabelText" runat="server"></asp:Label>:
                </th>
                <td class="tdTextBox" style="width: 301px">
                    <asp:HiddenField ID="hflblOwnerOrg" runat="server" />
                    <asp:HiddenField ID="hftxtownerorganization_value" runat="server" />
                    <asp:LinkButton ID="lblOwnerNm" runat="server" OnClick="owner_org_link"></asp:LinkButton>
                    &nbsp;&nbsp;
                    <asp:LinkButton ID="lnbtnselect" runat="server" CausesValidation="false" OnClientClick="javascript:return OpenPopupSelectOrganization('C')"
                        TabIndex="4" Text="Select" Font-Size="Small"></asp:LinkButton>
                    <asp:LinkButton ID="lnPostBack_owner" runat="server" CausesValidation="false" Text="">                                                                        
                    </asp:LinkButton>
                    <asp:Label ID="lblselect" runat="server" ForeColor="Red" Text=""></asp:Label>
                </td>
                <td style="width: 10px;">
                </td>
                <th>
                    <asp:Label ID="lbl_state" runat="server" CssClass="LabelText" Text="<%$Resources:Resource,State%>"></asp:Label>:
                </th>
                <td class="tdTextBox">
                    <telerik:RadComboBox ID="ddlState" runat="server" CssClass="rcbItem" Height="140px"
                        MarkFirstMatch="true" TabIndex="11" Width="186px">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblState" runat="server" CssClass="rtIn"></asp:Label>
                    <asp:Label ID="lblError1" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlState" ForeColor="Red"
                        Display="Dynamic" ValidationGroup="My_Vgroup" ErrorMessage="*" InitialValue="--Select--"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr style="height: 10px">
                <td>
                </td>
            </tr>
            <tr>
                <th>
                    <asp:Label ID="lblphase" runat="server" CssClass="LabelText" Text="<%$Resources:Resource,Phase%>"></asp:Label>:
                </th>
                <td>
                    <telerik:RadComboBox ID="ddlphase" runat="server" Width="185px" AutoPostBack="false"
                        CausesValidation="true" MarkFirstMatch="true" CssClass="DropDown">
                    </telerik:RadComboBox>
                    <asp:Label ID="lbltxtphase" runat="server" CssClass="LabelText"></asp:Label>
                </td>
                <td style="width: 10px;">
                </td>
                <th>
                    <asp:Label ID="lbl_Country" runat="server" CssClass="LabelText" Text="<%$Resources:Resource,Country%>"></asp:Label>:
                </th>
                <td class="tdTextBox">
                    <telerik:RadComboBox ID="ddlCountry" AutoPostBack="true" runat="server" CssClass="DropDown"
                        Height="140px" DataTextField="Name" DataValueField="Id" MarkFirstMatch="true"
                        TabIndex="5" Width="186px" OnSelectedIndexChanged="ddl_Country_SelectedIndexChanged">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblCountry" runat="server" CssClass="rtIn"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="ddlCountry"
                        ForeColor="Red" Display="Dynamic" ValidationGroup="My_Vgroup" EnableClientScript="true"
                        ErrorMessage="*" InitialValue="--Select--" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr style="height: 10px">
                <td>
                </td>
            </tr>
            <tr>
                <th style="width: 10px;">
                    <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Classifications%>"
                        CssClass="LabelText"></asp:Label>:
                </th>
                <td>
                
                    <asp:Label ID="lbl_standard" runat="server" CssClass="LabelText" Text=""></asp:Label>
                    <telerik:RadComboBox Width="187px" ID="cmbSelectStandard_v1" runat="server" CheckBoxes="true"
                        OnItemChecked="cmbSelectStandard_v1_ItemChecked" AutoPostBack="true">
                    </telerik:RadComboBox>
                </td>
                <td style="width: 10px;">
                </td>
                <th>
                    <asp:Label ID="lbl_created_on" runat="server" CssClass="LabelText" Text="<%$Resources:Resource,Created_On_1%>"
                        Visible="true"></asp:Label>
                </th>
                <td id="td1" runat="server" class="tdTextBox" style="width: 264px">
                    <asp:Label ID="lblCreatedOn" runat="server" CssClass="linkText"></asp:Label>
                </td>
            </tr>
            <tr style="height: 10px">
                <td>
                </td>
            </tr>
            <%-- <tr style="height: 10px">
                
                <td>

                </td>
                <td>

                </td>
            </tr>--%>
            <tr>
                <th>
                    <asp:Label ID="lbl_created_by" runat="server" CssClass="LabelText" Text="<%$Resources:Resource,Created_By_1%>"
                        Visible="false"></asp:Label>
                </th>
                <td id="tdlblCreatedBy" runat="server" class="tdTextBox" style="width: 264px">
                    <asp:Label ID="lblCreatedBy" runat="server" CssClass="LabelText"></asp:Label>
                </td>
                <td>
                </td>
                <th style="display: none;">
                    <asp:Label ID="lbl_Address_2" runat="server" CssClass="LabelText" Text="<%$Resources:Resource,Address_2%>"></asp:Label>:
                </th>
                <td class="tdTextBox" style="width: 301px; display: none;">
                    <asp:TextBox ID="txtAddress2" runat="server" CssClass="SmallTextBox" TabIndex="8"></asp:TextBox>
                    <asp:Label ID="lblAddress2" runat="server" CssClass="LabelText"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <th class="style1">
                    <asp:Label ID="lbl_logo" runat="server" CssClass="LabelText" Text="<%$Resources:Resource, Logo%>">:</asp:Label>
                </th>
                <td id="tdUpload" runat="server" align="left" style="width: 301px" colspan="3" class="tdTextBox">
                    <div style="float: left; padding-top: 5px">
                        <telerik:RadUpload ID="ruProjectLogo" runat="server" AllowedFileExtensions=".jpg,.jpeg,.gif,.bmp,.dib,.gif,.tiff,.png"
                            ControlObjectsVisibility="None" radcontrolsdir="~/App/RadControls" TabIndex="6"
                            Width="230px" Height="28px">
                        </telerik:RadUpload>
                    </div>
                    <div style="padding-top: 4px">
                        <asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" CausesValidation="false"
                            Text="<%$Resources:Resource, Upload%>" Width="65px" TabIndex="9" />
                    </div>
                </td>
            </tr>
        </table>
        <table>
            <tr style="height: 10px">
                <td>
                </td>
            </tr>
            <tr>
                <td colspan="6" style="height: 10px">
                    <asp:Button ID="btnEdit" runat="server" Width="100px" TabIndex="17" Text="<%$Resources:Resource,Edit%>"
                        CausesValidation="false" OnClick="btnEdit_Click" />
                    <a onclick="javascript:return chklbl();">
                        <asp:Button ID="btnSave" runat="server" Text="<%$Resources:Resource,Save%>" Width="100px"
                            TabIndex="18" OnClick="btnSave_Click" /><%--ValidationGroup="My_Vgroup"--%>
                    </a>
                    <asp:Button ID="btn_clone" runat="server" Text="<%$Resources:Resource,Clone%>" OnClick="Button1_Click"
                        Width="100px" TabIndex="19" />
                    <asp:Button ID="btn_save_clone" runat="server" Text="<%$Resources:Resource,Save_And_Clone%>"
                        Visible="false" Width="100px" OnClick="btn_save_clone_Click" />
                    <%--  </td>       
              <td>--%>
                    <asp:Button ID="btnCancel" runat="server" Text="<%$Resources:Resource,Cancel%>" Width="100px"
                        CausesValidation="false" TabIndex="20" OnClick="btnCancel_Click" />
                    <asp:Button ID="btnDelete" runat="server" Visible="true" Width="100px" Text="<%$Resources:Resource,Delete%>"
                        CausesValidation="false" OnClientClick="javascript:return delete_();" TabIndex="21"
                        OnClick="btnDelete_Click" />
                </td>
                <%-- <td colspan="4">
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" Width="100px" TabIndex="17"
                        CausesValidation="false" onclick="btnEdit_Click" />&nbsp;&nbsp;

                    <asp:Button ID="btnSave" runat="server" Text="Save" Width="100px" TabIndex="18" ValidationGroup="My_Vgroup" onclick="btnSave_Click"  />

                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btn_clone" runat="server" OnClick="Button1_Click"
                        Text="Clone" Width="100px" TabIndex="19"/>

                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel"
                        Width="100px" CausesValidation="false" TabIndex="20" 
                        onclick="btnCancel_Click" />
                    &nbsp; &nbsp;

                    <asp:Button ID="btnDelete" runat="server" Visible="true" Text="Delete" Width="100px"
                        CausesValidation="false" OnClientClick="javascript:return delete_();"
                        TabIndex="21" onclick="btnDelete_Click" />
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;

                    <asp:Button ID="btn_save_clone" runat="server" Text="Save and Clone" 
                        Visible="false" Width="100px" onclick="btn_save_clone_Click" />

                </td>--%>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                    <asp:HiddenField ID="hfProjectId" runat="server" />
                    <asp:HiddenField ID="hfLogo" runat="server" />
                    <asp:HiddenField ID="hfProjName" runat="server" />
                    <asp:HiddenField ID="hfOldProjectId" runat="server" />
                    <asp:HiddenField ID="hfNewProjectId" runat="server" />
                    <asp:HiddenField ID="hfExternalSystemID" runat="server" />
                    <asp:HiddenField ID="hfnewlead" runat="server" />
                    <asp:HiddenField ID="hfnewowner" runat="server" />
                    <asp:HiddenField ID="hfoldlead" runat="server" />
                    <asp:HiddenField ID="hfoldowner" runat="server" />
                    <asp:HiddenField ID="hf_lead_org_name" runat="server" />
                    <asp:HiddenField ID="hf_org_name" runat="server" />
                    <asp:HiddenField ID="hf_redirect_value" runat="server" />
                    <asp:HiddenField ID="hfownerorganization" runat="server" />
                    <asp:HiddenField ID="hf_uniclass_id" runat="server" />
                    <asp:HiddenField ID="hf_UniFormat" runat="server" />
                    <asp:HiddenField ID="hf_MasterFormat" runat="server" />
                    <asp:HiddenField ID="hf_OmniClass2010" runat="server" />
                    <asp:HiddenField ID="hf_uni_flag" runat="server" />
               <%--     <asp:HiddenField ID="hf_selected_standards" runat="server" />
                    <asp:HiddenField ID="hf_selected_standards_text" runat="server" />                    
--%>
                    <br />
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadWindowManager ID="radWindowMgrSelectOrganization" runat="server" VisibleTitlebar="true"
        Title="Select Organization" Behaviors="Close,Move" BorderWidth="0px" Skin="Simple"
        BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="radWindowAddClient" runat="server" Width="600px" Height="400px"
                Top="100px" Left="200px" KeepInScreenBounds="true" DestroyOnClose="false" AutoSize="false"
                AutoSizeBehaviors="Default" VisibleStatusbar="false" VisibleOnPageLoad="false"
                EnableAjaxSkinRendering="false" EnableShadow="false" Modal="true" Overlay="false"
                ReloadOnShow="True" BorderStyle="Solid">
            </telerik:RadWindow>
            <telerik:RadWindow ID="radWindow1" runat="server" Width="600px" Height="400px" Top="100px"
                Left="200px" KeepInScreenBounds="true" DestroyOnClose="false" AutoSize="false"
                AutoSizeBehaviors="Default" VisibleStatusbar="false" VisibleOnPageLoad="false"
                EnableAjaxSkinRendering="false" EnableShadow="false" Modal="true" Overlay="false"
                ReloadOnShow="True" BorderStyle="Solid">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <div style="display: none">
        <asp:Button ID="btnphase" runat="server" OnClick="btnphase_click" />
        <asp:Button ID="btnOrgChangeAddress" runat="server" OnClick="btnOrgChangeAddress_click" />
    </div>
    <telerik:RadAjaxManager ID="radphase" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnphase">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="OrganizationName" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="ddlphase" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnOrgChangeAddress">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Address_1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="Address_2" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="postalCode" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmbSelectStandard_v1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbSelectStandard_v1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
</html>
