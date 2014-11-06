<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="AssetProfile.aspx.cs"
    Inherits="App_Settings_AssetProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>
<%@ Register Src="../UserControls/UCLocationProject.ascx" TagName="UCLocation" TagPrefix="uc1" %>
<html>
<head>
    <title>Component Profile </title>
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
     <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
     <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
  
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG');  padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" class="tdZebraLightGray" style="margin: 0 0 0 0" defaultfocus="txtassetname">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">

            function GotoProfile(id) {
                top.location.href = "AssetMenu.aspx?pagevalue=AssetProfile&assetid=" + id + "&facility_id" + document.getElementById('hfFacilityid').value;
            }

            function GotoTypeProfile(id) {
                top.location.href = "TypeProfileMenu.aspx?type_id=" + id;
            }

            function selectType() {
                if (document.getElementById("ddltypename") != null) {
                    var ddltype = document.getElementById("ddltypename").value;
                    //alert(ddltype);
                    if (ddltype == "---Select---") {
                        alert("Please select Type");
                        return false;
                    }
                }
            }

            function RefreshParent() {
               
                str = '../Asset/AssetMenu.aspx?assetid=' + document.getElementById('hfAssetId').value + "&facility_id" + document.getElementById('hfFacilityid').value;
                window.parent.location.href = str;
            }
            function RefreshParentpopup() {
                str = '../Asset/AssetprofileNew.aspx?assetid=' + document.getElementById('hfAssetId').value + "&facility_id" + document.getElementById('hfFacilityid').value + "&popupflag=popup&value=asset";
                window.location.href = str;
                resizePopup('parentWindow');

            }

            function NavigateToFindAsset() {
                if (document.getElementById('hfAssetId').value == '00000000-0000-0000-0000-000000000000') {
                    top.location.href = "../Asset/ComponentPM.aspx";
                }
                else {

                    str = str = '../Asset/AssetMenu.aspx?assetid=' + document.getElementById('hfAssetId').value + "&facility_id" + document.getElementById('hfFacilityid').value;
                    window.parent.location.href = str;
                }


            }
            //        function NavigateToFindAssetpopup() 
            //      {          
            //              str = str = '../Asset/AssetprofileNew.aspx?assetid=' + document.getElementById('hfAssetId').value + "&facility_id" + document.getElementById('hfFacilityid').value+"&popupflag=popup&value=asset;
            //              window.parent.location.href = str;
            //      }

            function gotoPage(id, pagename) {
                var url;
                if (pagename == "Space") {
                    url = "../Locations/FacilityMenu.aspx?id=" + id + "&pagevalue=Space Profile";
                }
                else if (pagename == "Facility") {
                    url = "../Locations/FacilityMenu.aspx?id=" + id + "&pagevalue=Profile";
                    //alert("Page Under Construction");
                }

                top.location.href(url);
            }

            //      function ShowNotification() {
            //      
            //          var flag = confirm("Asset is not assigned to any facility. So we will assign it to a default facility of the project.");
            //          
            //          //notification.show();
            //          if (flag) {
            //              document.getElementById("myJSString").value = flag;
            //              document.getElementById("btngetdefaultfacility").click();
            //          }
            //          else
            //              return false;
            //      }
            function chknodes() {
              
                // To make asset name compulsary field
                var x = document.getElementById("txtassetname").value;
                if (x == null || x == "") {
                    document.getElementById("lblvalidatename").innerText = "*";
                    document.getElementById("txtassetname").focus = true;
                    return false;
                }
                else {
                    document.getElementById("lblvalidatename").innerText = "";
                }

                //To make typename compulsary field
                var y = document.forms["form1"]["ddltypename"].value;
                if (y == "---Select---") {
                    document.getElementById("lblvalidatetype").innerText = "*";
                    return false;
                }
                else {
                    document.getElementById("lblvalidatetype").innerText = "";
                }


                if ($find("UCLocation1_rtvLocationSpaces") != null) {
                  
                    var parent = 0;
                    var child = 0;
                    for (var i = 0; i < $find("UCLocation1_rtvLocationSpaces").get_allNodes().length; i++) {
                        var level = $find("UCLocation1_rtvLocationSpaces").get_allNodes()[i].get_level();
                        if (level == "0") {

                        }
                        else if (level == "1") {

                            parent = parent + 1;
                        }
                        else if (level == "2") {
                            child = child + 1;
                        }

                    }
                    if (parent == 0) {
                        alert('Please add new facility.');
                        return false;
                    }
                    if (child == 0) {

                        alert('Please add new space');
                        return false;
                    }
                    
                    if ($find("UCLocation1_rtvLocationSpaces").get_checkedNodes().length == 0) {

                        if ((document.getElementById('hfFacilityid').value == "")||(document.getElementById('hfFacilityid').value=="00000000-0000-0000-0000-000000000000")) {
                            var notification = $find("<%=RadNotification1.ClientID %>");
                            notification.show();

                            //alert('Please Select Space');
                            return false;
                        }
                    }

                    else {
                        return true;
                    }
                }
            }

            function chk_facility() {
                if (document.getElementById("ctl00_ContentPlaceHolder1_ddlfacility").value == "") {
                    return confirm("Selected Type does not assign to any facility, so we will assign it to default facility of project");
                }
            }

            function alertmsg(msg) {

                alert(msg);
                return false;
            }
            function naviagatetoProject() {
                top.location.href = "ComponentPM.aspx";

            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

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
                    if (str == 'expand')
                        wnd.set_height(document.body.scrollHeight + 60);
                    else if (str == 'collaps')
                        wnd.set_height(document.body.scrollHeight + 50);
                    else if (str == 'datePopExpand') {
                        if (stateTreeViewTest() != 'true')
                            wnd.set_height(document.body.scrollHeight + 100);
                    }
                    else if (str == 'datePopCollaps') {
                        if (stateTreeViewTest() != 'true')
                            wnd.set_height(document.body.scrollHeight + 20);
                    }
                    else if (str == 'datePopExpand2') {
                        if (stateTreeViewTest() != 'true')
                            wnd.set_height(document.body.scrollHeight + 160);
                    }
                    else if (str == 'datePopCollaps2') {
                        if (stateTreeViewTest() != 'true')
                            wnd.set_height(document.body.scrollHeight - 60);
                    }
                    else if (str == 'parentWindow')
                        wnd.set_width(document.body.scrollWidth - 80);
                }
            }

            var stateTreeView = 'false';
            function setSateteTreeView(str) {
                stateTreeView = str;
            }
            function stateTreeViewTest() {
                return stateTreeView;
            }
            
            function closewindow() {
                window.close();
            }
            function chkfacility() {

                if (document.getElementById("RadNotification1_C_cmbfacility").value == " --Select--") {
                    return alert("Please select facility.");
                    return false;
                }
                else {
                    alert("Facility is selected successfully.");
                    window.close();
                    return true;
                }
            }
            function resizeParentPopupWindowOnOpen(sender, eventArgs) {
                resizePopup('datePopExpand');
            }
            function resizeParentPopupWindowOnClose(sender, eventArgs) {
                resizePopup('datePopCollaps');
            }

            function resizeParentPopupWindowOnOpen2(sender, eventArgs) {
                resizePopup('datePopExpand2');
            }
            function resizeParentPopupWindowOnClose2(sender, eventArgs) {

                resizePopup('datePopCollaps2');
            }
        </script>



       
      
    </telerik:RadCodeBlock>

     <asp:HiddenField ID="hfAssetid" runat="server" />
        <asp:HiddenField ID="hfFacilityid" runat="server" />
        <asp:HiddenField runat="server" ID="myJSString" />
        <asp:HiddenField ID="hfTypeId" runat="server" />
        <asp:HiddenField ID="hfpopupflag" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hfWarrentyDurationParts" runat="server" Value="0"/>
    <div id="divProfilePage" style="width: 100%;padding:2px;" runat="server">
        <table id="tblheader" runat="server" border="0" width="100%" style="display:none;" cellspacing="0">
            <tr>
                <td class="wizardHeadImage" style="display:none" >
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
        <table style="margin: 10px 20px 0px 20px;" border="0">
           <%-- <caption>
                <asp:Label ID="lblpopup" runat="server" Text=""></asp:Label>
            </caption>--%>
            <tr>
                <th align="left" class="style4" width="25%" valign="bottom">
                    <asp:Label ID="lbl_AssetName" runat="server" Text="<%$Resources:Resource, Name%>"></asp:Label>:
                    <%--<span id="spanName" runat="server" style="color: Red"></span>:--%>
                </th>
                <td align="left"  valign="bottom" >
                    <asp:TextBox TabIndex="1" ID="txtassetname" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <%--<asp:RequiredFieldValidator ValidationGroup="valid" ID="RequiredFieldValidator1"
                        Display="Dynamic" SetFocusOnError="true" runat="server" ControlToValidate="txtassetname"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                    <asp:Label ID="lblvalidatename" runat="server" Text="" ClientIDMode="Static" CssClass="LabelText"
                        ForeColor="Red"></asp:Label>
                    <asp:Label ID="lblname" CssClass="linkText" runat="Server"></asp:Label>
                </td>
               
                <th align="left" class="style4" width="25%" valign="bottom">
                    <asp:Label ID="lbl_Description" runat="server" Text="<%$Resources:Resource, Description%>"></asp:Label>:
                    <%--  <span id="spandescription" runat="server"></span>:--%>
                </th>
                <td align="left"  valign="bottom">
                    <asp:TextBox TabIndex="7" ID="txtdescrption" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lbldescription" CssClass="linkText" runat="Server"></asp:Label>
                    <%-- <asp:RequiredFieldValidator ValidationGroup="valid" ID="RequiredFieldValidator2"
                    runat="server" ControlToValidate="txtdescrption" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                    <%--<span id="s2" style="visibility: hidden; color: Red;" visible="false">*</span>--%>
                </td>
            </tr>
            <tr>
                <th align="left">
                    <asp:Label ID="lbl_TypeName" runat="server" Text="<%$Resources:Resource, Type_Name%>"></asp:Label>:
                </th>
                <td>
                    <telerik:RadComboBox TabIndex="2" ID="ddltypename" Filter="Contains" Height="100px" AutoPostBack=true
                        Width="180px" runat="server"   onselectedindexchanged="ddltypename_SelectedIndexChanged">
                    </telerik:RadComboBox>
                    <%--<asp:RequiredFieldValidator ValidationGroup="valid" InitialValue="---Select---" ID="RequiredFieldValidator3"
                        SetFocusOnError="true" Display="Dynamic" runat="server" ForeColor="Red" ControlToValidate="ddltypename"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                    <asp:Label ID="lblvalidatetype" runat="server" Text="" ClientIDMode="Static" CssClass="LabelText"
                        ForeColor="Red"></asp:Label>
                    <asp:LinkButton ID="lbltypename" runat="server" CssClass="linkText" OnClick="typelink"></asp:LinkButton>
                </td>
               
                <th align="left" class="style4">
                    <asp:Label ID="lbl_SerialNo" runat="server" Text="<%$Resources:Resource,  Serial_Number%>"></asp:Label>:
                    <%--<span id="serialNoSpan" runat="server"></span>:--%>
                </th>
                <td class="style3">
                    <asp:TextBox TabIndex="8" ID="txtSerialNo" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lblSerialNo" CssClass="linkText" runat="Server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th align="left" class="style2">
                    <asp:Label ID="lbl_Barcode" runat="server" Text="<%$Resources:Resource,Barcode%>"></asp:Label>:
                    <%-- <span id="span1" runat="server"></span>:--%>
                </th>
                <td class="style3" align="left">
                    <asp:TextBox TabIndex="3" ID="txtbarcode" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lblbarcode" CssClass="linkText" runat="Server"></asp:Label>
                </td>
               
                <th align="left" class="style4">
                    <asp:Label ID="lbl_InstallationDate" runat="server" Text="<%$Resources:Resource,   Installation_Date%>"></asp:Label>:
                    <%--  <span id="spanManufacturer" runat="server" style="color: Red"></span>:--%>
                </th>
                <td align="left">
                    <%-- <telerik:RadDatePicker TabIndex="9" AutoPostBack="false" ID="rdpinstallationdate"
                        runat="server" Width="180px">
<Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" runat="server" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" ></Calendar>

<DateInput ID="DateInput1"  runat="server" DateFormat="MM/dd/yy hh:mm tt" DisplayDateFormat="MM/dd/yy hh:mm tt"
                            TabIndex="9"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="9" ></DatePopupButton>
                    </telerik:RadDatePicker>--%>
                    <telerik:RadDatePicker TabIndex="9" AutoPostBack="false" ID="rdpinstallationdate" ShowPopupOnFocus="true"  ClientEvents-OnPopupOpening="resizePopup('str')"
                        runat="server" Width="180px">
                        <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" runat="server" UseColumnHeadersAsSelectors="False"
                            ViewSelectorText="x">
                        </Calendar>
                        <DateInput ID="DateInput1" runat="server" DateFormat="MM/dd/yy" DisplayDateFormat="MM/dd/yy"
                            TabIndex="9">
                        </DateInput>
                        <ClientEvents OnPopupOpening="resizeParentPopupWindowOnOpen" OnPopupClosing="resizeParentPopupWindowOnClose" />
                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="9"></DatePopupButton>
                    </telerik:RadDatePicker>
                    <%--<asp:RequiredFieldValidator ValidationGroup="valid" ID="RequiredFieldValidator22"
                        SetFocusOnError="true" Display="Dynamic" runat="server" ForeColor="Red" ControlToValidate="rdpinstallationdate"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                    <asp:Label ID="lblinstallationdate" CssClass="linkText" runat="Server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th align="left" valign="top">
                    <asp:Label ID="lbl_AssetIdentifier" runat="server" Text="<%$Resources:Resource,  Asset_Identifier%>"></asp:Label>:
                </th>
                <td align="left" valign="top">
                    <asp:TextBox TabIndex="5" ID="txtassetidentifier" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lblassetidentifier" CssClass="linkText" runat="server"></asp:Label>
                </td>
              
                <th align="left" class="style2">
                    <asp:Label ID="lbl_TagNo" runat="server" Text="<%$Resources:Resource,Tag_Number%>"></asp:Label>:
                    <%-- <span id="spanmodel" runat="server"></span>:--%>
                </th>
                <td class="style3">
                    <asp:TextBox TabIndex="10" ID="txttagnumber" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lbltagnumber" CssClass="linkText" runat="Server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th align="left" valign="top">
                    <asp:Label ID="lbl_ConditionType" runat="server" Text="<%$Resources:Resource,Condition_type%>"></asp:Label>:
                </th>
                <td align="left" valign="top">
                    <telerik:RadComboBox ID="rcmbConditionType" runat="server" Sort="Ascending" TabIndex="6" Height="85"
                        InitialValue="--Select--" Width="180px">
                        <Items>
                            <%--  <telerik:RadComboBoxItem runat="server" Text="Good" Value="1" />
                           <telerik:RadComboBoxItem runat="server" Text="Bad" Value="2" />
                           <telerik:RadComboBoxItem runat="server" Text="Fair" Value="3" />
                           <telerik:RadComboBoxItem runat="server" Text="Poor" Value="4" />
                           <telerik:RadComboBoxItem runat="server" Selected="True" Text="New" Value="5" />--%>
                            <telerik:RadComboBoxItem runat="server" Text="--Select--" Value="1" />
                            <telerik:RadComboBoxItem runat="server" Text="Bad" Value="2" />
                            <telerik:RadComboBoxItem runat="server" Text="Fair" Value="3" />
                            <telerik:RadComboBoxItem runat="server" Text="Good" Value="4" />
                            <telerik:RadComboBoxItem runat="server" Text="New" Value="5" />
                            <telerik:RadComboBoxItem runat="server" Text="Poor" Value="6" />
                        </Items>
                    </telerik:RadComboBox>
                    <asp:Label ID="lblConditionTypeValue" CssClass="linkText" runat="server"></asp:Label>
                </td>
              
                <th align="left">
                    <asp:Label ID="lbl_WarrantyStDate" runat="server" Text="<%$Resources:Resource,Warranty_Start_Date%>"></asp:Label>:
                    <%--   <span id="span2" runat="server" style="color: Red"></span>:--%>
                </th>
                <td align="left">

                 <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                                                    <script language="javascript" type="text/javascript">
                                                        //<![CDATA[

                                                        function DateSelectedChanged(sender, eventArgs) {

                                                  
                                                            var warrentyEnddate = $find("<%= rdpWarrentyEndDate.ClientID %>");
                                                            var waraantyStartDate = eventArgs.get_newDate();


                                                            if (waraantyStartDate != null) {
                                                                var parts = document.getElementById('hfWarrentyDurationParts').value
                                                                waraantyStartDate.setDate(waraantyStartDate.getDate() + parseInt(parts));

                                                                warrentyEnddate.set_selectedDate(waraantyStartDate);
                                                            }
                                                            else
                                                                warrentyEnddate.clear();
                                                        


                                                        }

                                                            //]]>
                                                    </script>
                                                </telerik:RadScriptBlock>
                  
                  
                    <telerik:RadDatePicker TabIndex="11" AutoPostBack="false" ID="rdpwarrantytart" ShowPopupOnFocus="true" runat="server" 
                        Width="180px">
                        <DateInput ID="DateInput3" runat="server" LabelCssClass="radLabelCss_Gray" DateFormat="MM/dd/yy"
                            DisplayDateFormat="MM/dd/yy" TabIndex="11">
                        </DateInput>
                        <Calendar ID="Calendar3" runat="server">
                        </Calendar>
                         <ClientEvents OnPopupOpening="resizeParentPopupWindowOnOpen2" OnPopupClosing="resizeParentPopupWindowOnClose2" OnDateSelected="DateSelectedChanged" />
                        <DatePopupButton TabIndex="11" />
                    </telerik:RadDatePicker>
                    <%--<asp:RequiredFieldValidator ValidationGroup="valid" ID="RequiredFieldValidator2"
                        SetFocusOnError="true" Display="Dynamic" runat="server" ForeColor="Red" ControlToValidate="rdpwarrantytart"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                    <asp:Label ID="lblwarrantystart" CssClass="linkText" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th align="left" valign="top">
                    <asp:Label ID="lbl_Location" runat="server" Text="<%$Resources:Resource,Location%>"></asp:Label>:
                </th>
                <td style="width:20%;">
                    <asp:Label ID="lblspace" runat="server" CssClass="linkText"></asp:Label>
                    <%--<telerik:RadGrid ID="rgLocation" runat="server" AllowPaging="true" Width="100%" BorderWidth="1px"
                        CellPadding="0" AutoGenerateColumns="False" Skin="Hay" PageSize="5" AllowSorting="true"
                        OnSortCommand="rgLocation_OnSortCommand">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="50%" AlwaysVisible="true" />
                        <MasterTableView DataKeyNames="locationid">
                            <Columns>
                                <telerik:GridBoundColumn DataField="locationid" HeaderText="location_id" Visible="false">
                                    <ItemStyle CssClass="column" Width="100px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="linkspace" HeaderText="<%$Resources:Resource, Space_Names%>">
                                    <ItemStyle CssClass="column" Width="300px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource, Description%>">
                                    <ItemStyle CssClass="column" Width="300px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="linkfacility" HeaderText="<%$Resources:Resource, Facility%>">
                                    <ItemStyle CssClass="column" Width="300px" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>--%>
                    
                    <uc1:UCLocation ID="UCLocation1" runat="server"  />
                </td>



                   <th align="left">
                    <asp:Label ID="lblWarrentyEndDate" runat="server" Text="<%$Resources:Resource,Warranty_End_Date%>"></asp:Label>:
                    <%--  <span id="span2" runat="server" style="color: Red"></span>:--%>
                </th>

                <td align="left" style="width: 220px">

               
                    <telerik:RadDatePicker TabIndex="9" AutoPostBack="false" ID="rdpWarrentyEndDate" runat="server" Width="180px">
                        <DateInput ID="DateInput2" runat="server" LabelCssClass="radLabelCss_Gray"  DateFormat="MM/dd/yy" DisplayDateFormat="MM/dd/yy"  >
                        </DateInput>
                        <Calendar ID="Calendar2" runat="server" >
                        </Calendar>
                        <DatePopupButton TabIndex="10" />
                   </telerik:RadDatePicker>
                    <%--<asp:RequiredFieldValidator ValidationGroup="valid" ID="RequiredFieldValidator2"
                        SetFocusOnError="true" Display="Dynamic" runat="server" ForeColor="Red" ControlToValidate="rdpwarrantytart"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                    <asp:Label ID="lblWarrentyEnd" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>

            </tr>
            <tr>
                <td colspan="5" align="left">
                    <asp:Button ID="btnsave" CausesValidation="true" runat="server" Text="<%$Resources:Resource, Save%>"
                        Width="50px" OnClick="btnsave_Click" TabIndex="12" OnClientClick="javascript:return chknodes();" />
                    <asp:Button ID="btncancel" runat="server"   Text="<%$Resources:Resource, Cancel%>"
                        Width="70px" OnClick="btncancel_Click" TabIndex="12" />
                    <asp:Button ID="btnclose" runat="server" Width="100" Text="<%$Resources:Resource, Close%>"
                        OnClientClick="Javascript:closewindow();" />
                </td>
            </tr>
            <%--     <tr>
            <td>
 <telerik:RadNotification ID="RadNotification1" runat="server" Width="200" Height="100" Position="TopCenter" 
              EnableRoundedCorners="true" EnableShadow="true" Skin="Hay" 
              LoadContentOn="PageLoad" Title="Facility for component" AutoCloseDelay="50000">
    <ContentTemplate>
    Please select facility for this component.
    <telerik:RadComboBox ID="cmbfacility" runat="server">
    </telerik:RadComboBox>
    <asp:Button ID="btnOK" Text="OK" runat="server" OnClick="btnOK_click" />
    </ContentTemplate>
    </telerik:RadNotification>
            </td>
            </tr>--%>
        </table>
        <asp:Button ID="btngetdefaultfacility" Name="btngetdefaultfacility" runat="server" Skin="Default"
            Visible="false" OnClick="btngetdefaultfacility_Click" />
    </div>
    <%-- <telerik:RadWindowManager ID="radWindowMgrSelectFacility" Visible="true" VisibleStatusbar="false"
        AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server"
        KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow ID="radWindowSelectFacility1" Visible="true" Title="Select Facility" runat="server"
                Animation="Slide" Behavior="Move,Resize,Close" KeepInScreenBounds="true" VisibleTitlebar="true" AutoSize="false"
                ReloadOnShow="false" VisibleStatusbar="false" VisibleOnPageLoad="false" Skin="Hay">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>--%>
    <telerik:RadNotification ID="RadNotification1" runat="server" Width="260" Height="100"
        Position="TopCenter" EnableRoundedCorners="true" EnableShadow="true" Skin="Default"
        OffsetX="-150" OffsetY="170" Pinned="false" LoadContentOn="PageLoad" Title="Facility for component"
        AutoCloseDelay="50000">
        <ContentTemplate>
            Please select facility for this component.
            <br />
            <br />
            <telerik:RadComboBox ID="cmbfacility" runat="server">
            </telerik:RadComboBox>
            &nbsp;&nbsp;
            <asp:Button ID="btnOK" Text="OK" runat="server" Width="60" OnClick="btnOK_click" OnClientClick="javascript:return chkfacility();" />
        </ContentTemplate>
    </telerik:RadNotification>


     <telerik:RadAjaxManager ID="rgmTypeProfile" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddltypename">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdpWarrentyEndDate" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
          
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="30px" Width="30px">
      
    </telerik:RadAjaxLoadingPanel>

    </form>
</body>
</html>
