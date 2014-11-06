<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="AssetProfileNew.aspx.cs"
    Inherits="App_Settings_AssetProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>
<%@ Register Src="../UserControls/UCLocationProject.ascx" TagName="UCLocation" TagPrefix="uc1" %>
<html>
<head>
    <title>Component Profile</title>
       <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
  <%--  <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />--%>
  
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <%--<link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />--%>
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
	
	 .widthTh
	 {
	     width:11px;
	 }
    </style>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">

            function numbersonly() {
                var data = document.getElementById('<%=txtNoOfClones.ClientID %>').value;
                var filter = /^[0-9]+$/;
                if (!filter.test(data)) {
                    alert("Please enter numeric only");
                    document.getElementById('<%=txtNoOfClones.ClientID %>').value = "";
                    document.getElementById('<%=txtNoOfClones.ClientID %>').focus();
                    return false;
                }


                if (data.Length > 3) {
                    alert("Please enter 3 digits number.");
                    return false;
                }
                else
                    return true;
            }

            function GotoProfile(id) {
                top.location.href = "AssetMenu.aspx?pagevalue=AssetProfile&assetid=" + id;
            }

            function CloneCreated() {
                alert("Clone is created.");
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

            //This function returns rad window instance to resize it popup
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }
            function resizePopup() {
                window.document.clear();
                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    wnd.set_height(document.body.scrollHeight + 50);
                    wnd.set_width(document.body.scrollWidth + 130);
                }
            }

            function NavigateToFindAsset() {
                if (document.getElementById('hfAssetId').value == '00000000-0000-0000-0000-000000000000') {
                    top.location.href = "ComponentPM.aspx";
                }
                else {
                    if (document.getElementById('btnEdit') == null) {
                        var query = parent.location.search.substring(1);
                        var flag = query.split("=");
                        var reg = new RegExp(flag[1], 'g');
                        var str = window.parent.location.href;
                        str = str.replace(reg, document.getElementById('hfAssetId').value);
                        window.parent.location.href = str;
                    }
                    else {
                        top.location.href = 'ComponentPM.aspx';
                    }
                }


            }

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

                if (document.getElementById("btnsave").value != "Edit") {
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
                        if ($find("UCLocation1_rtvLocationSpaces").get_checkedNodes().length == 0) {

                            var notification = $find("<%=RadNotification1.ClientID %>");
                            notification.show();
                            return false;
                        }

                        else {
                            return true;
                        }
                    }
                }
                resizePopup();
            }

            function chk_facility() {
                if (document.getElementById("ctl00_ContentPlaceHolder1_ddlfacility").value == "") {
                    return confirm("Selected Type does not assign to any facility, so we will assign it to default facility of project");
                }
            }

            function alertforsinglefac() {
                alert("Please select locations under single facility.");
                return false;
            }
            function RefreshParent() {

                str = str = '../Asset/AssetMenu.aspx?assetid=' + document.getElementById('hfAssetId').value + "&page_load=AssetProfile";
                window.parent.location.href = str;
            }
            function RefreshParentpopup() {

                str = str = '../Asset/Assetprofile.aspx?assetid=' + document.getElementById('hfAssetId').value + "&page_load=AssetProfile&popupflag=popup&value=asset";
                window.location.href = str;
            }
            function naviagatetoProject() {
                top.location.href = "ComponentPM.aspx";

            }
            function deleteComponent() {
                var flag;
                flag = confirm("Are you sure you want to delete?");
                return flag;
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
   
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" style="margin: 0 0 0 0">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
     <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
     <div id="divProfilePage" style="width: 99%;" runat="server">
        <table id="tblheader" runat="server" border="0" style=" display:none;" cellspacing="0">
            <tr>
                <td class="wizardHeadImage" style="display:none;" >
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
        <table style="margin: 10px 10px 0px 10px;width:100%">
            <%--<caption>
                <asp:Label ID="lblpopup" runat="server" Text=""></asp:Label>
            </caption>--%>
            <tr>
                <th align="left" class="style4" width="10%" valign="bottom">
                    <asp:Label ID="lbl_Description" runat="server" Text="<%$Resources:Resource, Description%>"></asp:Label>:
                    <%-- <span id="spandescription" runat="server"></span>:--%>
                </th>
                <td align="left" style="width: 20%" valign="bottom">
                    <asp:TextBox TabIndex="6" ID="txtdescrption" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lbldescription" CssClass="linkText lblTextCss lblTextCss" runat="Server"></asp:Label>
                    <%-- <asp:RequiredFieldValidator ValidationGroup="valid" ID="RequiredFieldValidator2"
                    runat="server" ControlToValidate="txtdescrption" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                    <%--<span id="s2" style="visibility: hidden; color: Red;" visible="false">*</span>--%>
                </td>
                <td width="1%">
                    <%--<asp:RequiredFieldValidator ValidationGroup="valid" ID="RequiredFieldValidator1"
                        Display="Dynamic" SetFocusOnError="true" InitialValue=" " runat="server" ControlToValidate="txtassetname"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </td>
                <th align="left" class="style2" style="width:11%;">
                    <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource,  Serial_Number%>"></asp:Label>:
                    <%-- <span id="serialNoSpan" runat="server"></span>:--%>
                </th>
                <td class="style3" align="left" style="width: 20%">
                    <asp:TextBox TabIndex="2" ID="txtSerialNo" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lblSerialNo" CssClass="linkText lblTextCss" runat="Server"></asp:Label>
                </td>
            </tr>
            <tr> <td colspan="5" style="width:100%;height:05px;"></td> </tr>
            <tr>
                <th align="left">
                    <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource, Type_Name%>"></asp:Label>:
                </th>
                <td align="left" style="width: 220px">
                    <telerik:RadComboBox TabIndex="4" ID="ddltypename" Filter="Contains" Height="200px"
                        Width="160px" runat="server">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblvalidatetype" runat="server" Text="" ClientIDMode="Static" CssClass="LabelText"
                        ForeColor="Red"></asp:Label>
                    <asp:LinkButton ID="lbltypename" runat="server" CssClass="linkText lblTextCss" OnClick="typelink"></asp:LinkButton>
                </td>
                <td width="10px">
                </td>
                <th align="left" class="style4">
                    <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource,   Installation_Date%>"></asp:Label>:
                    <%-- <span id="spanManufacturer" runat="server" style="color: Red"></span>:--%>
                </th>
                <td align="left" style="width: 220px">
                    <telerik:RadDatePicker TabIndex="3" AutoPostBack="false" ID="rdpinstallationdate"
                        runat="server">
                        <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" runat="server" UseColumnHeadersAsSelectors="False"
                            ViewSelectorText="x">
                        </Calendar>
                        <DateInput ID="DateInput1"  runat="server" DateFormat="MM/dd/yy hh:mm tt">
                        </DateInput>
                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDatePicker>
                    <%--<asp:RequiredFieldValidator ValidationGroup="valid" ID="RequiredFieldValidator22"
                        SetFocusOnError="true" Display="Dynamic" runat="server" ForeColor="Red" ControlToValidate="rdpinstallationdate"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                    <asp:Label ID="lblinstallationdate" CssClass="linkText lblTextCss" runat="Server"></asp:Label>
                </td>
            </tr>
            <tr> <td colspan="5" style="width:100%;height:05px;"></td> </tr>
            <tr>
                <th align="left" class="style2">
                    <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource,Barcode%>"></asp:Label>:
                    <%-- <span id="span1" runat="server"></span>:--%>
                </th>
                <td class="style3" align="left" style="width: 220px">
                    <asp:TextBox TabIndex="8" ID="txtbarcode" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lblbarcode" CssClass="linkText lblTextCss" runat="Server"></asp:Label>
                </td>
                <td width="10px">
                </td>
                <th align="left" class="style2">
                    <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,Tag_Number%>"></asp:Label>:
                    <%--  <span id="spanmodel" runat="server"></span>:--%>
                </th>
                <td class="style3" align="left" style="width: 220px">
                    <asp:TextBox TabIndex="7" ID="txttagnumber" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lbltagnumber" CssClass="linkText lblTextCss" runat="Server"></asp:Label>
                </td>
            </tr>
            <tr> <td colspan="5" style="width:100%;height:05px;"></td> </tr>
            <tr>
                <th align="left" valign="top">
                    <asp:Label ID="Label10" runat="server" Text="<%$Resources:Resource,  Asset_Identifier%>"></asp:Label>:
                </th>
                <td align="left" style="width: 220px" valign="top">
                    <asp:TextBox TabIndex="5" ID="txtassetidentifier" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lblassetidentifier" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
                <td width="10px">
                </td>
                <th align="left">
                    <asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource,Warranty_Start_Date%>"></asp:Label>:
                    <%--  <span id="span2" runat="server" style="color: Red"></span>:--%>
                </th>
                <td align="left" style="width: 220px">
                    <telerik:RadDatePicker TabIndex="9" AutoPostBack="false" ID="rdpwarrantytart" runat="server">
                        <DateInput ID="DateInput3" runat="server" LabelCssClass="radLabelCss_Gray"  DateFormat="MM/dd/yy hh:mm tt">
                        </DateInput>
                        <Calendar ID="Calendar3" runat="server">
                        </Calendar>
                        <DatePopupButton TabIndex="10" />
                    </telerik:RadDatePicker>
                    <%--<asp:RequiredFieldValidator ValidationGroup="valid" ID="RequiredFieldValidator2"
                        SetFocusOnError="true" Display="Dynamic" runat="server" ForeColor="Red" ControlToValidate="rdpwarrantytart"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                    <asp:Label ID="lblwarrantystart" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
            </tr>
            <tr> <td colspan="5" style="width:100%;height:05px;"></td> </tr>
            <tr>
                <th align="left" valign="top">
                    <asp:Label ID="Label11" runat="server" Text="<%$Resources:Resource,Location%>"></asp:Label>:
                </th>
                <td align="left" style="width: 220px">
                    <asp:Label ID="lblspace" runat="server" CssClass="linkText lblTextCss"></asp:Label>
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
                    <uc1:UCLocation ID="UCLocation1" runat="server" />
                </td>
                <td width="10px">
                </td>
                <th align="left" valign="top">
                    <asp:Label ID="Condition" runat="server" Text="<%$Resources:Resource,Condition_type%>"></asp:Label>:
                </th>
                <td align="left" style="width: 220px" valign="top">
                    <telerik:RadComboBox ID="rcmbConditionType" runat="server" Sort="Ascending" TabIndex="11">
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
                    <asp:Label ID="lblConditionTypeValue" CssClass="linkText lblTextCss" runat="server"></asp:Label>
                </td>
            </tr>
            <tr> <td colspan="5" style="width:100%;height:05px;"></td> </tr>
             <tr>
                  <th align="left" valign="top">
                    <asp:Label ID="lblLinkedInBIM" runat="server" Text="<%$Resources:Resource,Linked_In_BIM%>"></asp:Label>
                  
                </th>
               <td align="left" style="width: 220px" valign="top">
                   
                    <asp:Label ID="lblAssetIsLinked" CssClass="linkText lblTextCss" runat="Server" Text="" ></asp:Label>
                </td>
                <td width="10px">
                </td>
                <%--<th align="left" class="style2">
                   
                </th>
                <td class="style3" align="left" style="width: 220px">
                   
                </td>--%>

                 <th align="left">
                    <asp:Label ID="lblWarrentyEndDate" runat="server" Text="<%$Resources:Resource,Warranty_End_Date%>"></asp:Label>:
                    <%--  <span id="span2" runat="server" style="color: Red"></span>:--%>
                </th>

                <td align="left" style="width: 220px">
                    <telerik:RadDatePicker TabIndex="9" AutoPostBack="false" ID="rdpWarrentyEndDate" runat="server">
                        <DateInput ID="DateInput2" runat="server" LabelCssClass="radLabelCss_Gray"  DateFormat="MM/dd/yy" DisplayDateFormat="MM/dd/yy">
                        </DateInput>
                        <Calendar ID="Calendar2" runat="server">
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
                 <th align="left" valign="top">
                    <asp:Label ID="lblNoClones" runat="server" Text="<%$Resources:Resource, Number_Of_Clones_To_Be_Created%>"></asp:Label>
                </th>
                <td align="left" style="width: 100px" valign="top">
                    <asp:TextBox ID="txtNoOfClones" CssClass="SmallTextBox" Maxlength="3" runat="server" Width="70px"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNoOfClones"
                    Display="Dynamic" ValidationGroup="my_validation" ErrorMessage="*" ForeColor="Red"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            </tr>
            <tr>
                <td colspan="5" align="left" style="padding-top:10px; vertical-align:middle">
                      <asp:Button ID="btnsave" CausesValidation="true" runat="server" Text="<%$Resources:Resource, Save%>"
                         Width="100px" OnClick="btnsave_Click" Font-Names="arial" Font-Size="Medium" TabIndex="11" OnClientClick="javascript:return chknodes();" />&nbsp;
                     <asp:Button ID="btnClone" CausesValidation="true" runat="server" Text="<%$Resources:Resource, Clone%>"
                         Width="100px" TabIndex="11" onclick="btnClone_Click" />&nbsp;
                     <asp:Button ID="btndelete" runat="server" Text="<%$Resources:Resource, Delete%>"
                        Width="100px" Font-Names="arial" Font-Size="Medium" OnClick="btndelete_Click" OnClientClick="javascript:return delete_();" />&nbsp;
                         <asp:Button ID="btnclose" runat="server" Width="100" Text="<%$Resources:Resource, Close%>"  OnClientClick="Javascript:closewindow();" />&nbsp;
                    <%--  <asp:Button ID="btncancel" runat="server" Text="<%$Resources:Resource, Cancel%>"
                        Width="50px" OnClick="btncancel_Click" TabIndex="12" />--%>
                       <asp:Button ID="btnCreateClones" CausesValidation="true" runat="server" Text="<%$Resources:Resource, Create_Clones%>"
                        Width="150px" ValidationGroup="my_validation" OnClientClick="Javascript:return numbersonly();" onclick="btnCreateClones_Click"  />&nbsp;
                 
                </td>
            </tr>
            
        </table>

     </div>
      <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server" >
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnCreateClones">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtNoOfClones" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
           
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>


        <asp:Button ID="btngetdefaultfacility" Name="btngetdefaultfacility" runat="server"
            Visible="false" OnClick="btngetdefaultfacility_Click" />
   
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
            <asp:Button ID="btnOK" Text="OK" runat="server" Width="60" OnClick="btnOK_click" />
            <asp:HiddenField ID="hf_page" runat="server" />
        </ContentTemplate>
    </telerik:RadNotification>
    <asp:HiddenField ID="hfpopupflag" runat="server" ClientIDMode="Static" />
      <asp:HiddenField ID="hfAssetid" runat="server" />
        <asp:HiddenField ID="hfFacilityid" runat="server" />
        <asp:HiddenField runat="server" ID="myJSString" />
    </form>
</body>
</html>
