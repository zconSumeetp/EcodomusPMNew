<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="FloorProfileNew.aspx.cs"
    Inherits="App_Settings_FloorProfileNew" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">--%>
<html>
<head>
    <title>Floor Profile</title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
  
    <telerik:radcodeblock id="radcodeblock1" runat="server">

        <script type="text/javascript" language="javascript">

            function openpopupaddomniclasslinkup() {
                var url = "AssignOmniclass.aspx?Item_type=floor";
                window.open(url, "Window1", "menubar=no,width=500,height=450,right=50,toolbar=no,scrollbars=yes");
                return false;
            }
            function NavigateToFindLocation() {
              
                top.location.href = "../Locations/FindLocation.aspx";
            }
            function NavigateToFloorPM() {

                top.location.href = "../Locations/FloorsPM.aspx";
            
            }


            function navigate_floor() 
            {
                var url = "../locations/facilitymenu.aspx?pagevalue=Floor Profile&id=" + document.getElementById("hf_floor_id").value;
                // + "&facility_id=" + document.getElementById("hf_facility_id").value;
                parent.location.href(url);
            }
            function navigate_floorpopup() {
            
                var url = "../locations/FloorprofileNew.aspx?pagevalue=Floor Profile&id=" + document.getElementById("hf_floor_id").value+"&popupflag=popup";
                // + "&facility_id=" + document.getElementById("hf_facility_id").value;
                window.location.href(url);
            }

            function validate() {
                alert("Floor name already exists");
                return false;
            }

            function NavigateToFindLocationPM() {
                if (document.getElementById('<%=hflocationid.ClientID%>').value == "00000000-0000-0000-0000-000000000000") {
                    top.location.href = "../Locations/FloorsPM.aspx";
                }
                else {
                    window.location = "../locations/FloorProfileNew.aspx?pagevalue=Floor Profile&id=" + document.getElementById('<%=hflocationid.ClientID%>').value;

                }
                //top.location.href = "../Locations/FloorsPM.aspx";
            }
            function NavigateToFindLocationPMpopup() {
                 window.location = "../locations/FloorProfileNew.aspx?pagevalue=Floor Profile&id=" + document.getElementById('<%=hflocationid.ClientID%>').value+"&popupflag=popup";               

            }
//            function NavigateToFindLocationPM() {
//                
//                    window.location = "../locations/FloorProfile.aspx?pagevalue=Floor Profile&id=" + document.getElementById('<%=hflocationid.ClientID%>').value+"&popupflag=popup";

//                
//                //top.location.href = "../Locations/FloorsPM.aspx";
//            }
            function chkdelete() {

                var flag;
                flag = confirm("Do you want to delete this floor?");
//                if (flag) {
                    return flag;
//                }
//                else {

//                    return false;
//                }
//            

                }
                function LogoutNavigation() {

                    var query = parent.location.href;
                    top.location.href(query);

                }

                function closewindow() {
                    window.close();
                }



            </script>
            </telerik:radcodeblock>
    <telerik:radformdecorator id="rdfTaskEquipment" runat="server" skin="Default" decoratedcontrols="Buttons,RadioButtons,Scrollbars" />
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG');  padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" style="margin: 0 0 0 0" defaultfocus="txtfloorname">
    <asp:scriptmanager id="Scriptmanager1" runat="server">
    </asp:scriptmanager>
    <asp:hiddenfield id="hflocationid" runat="server" />
    <div  id="divProfilePage" style =" width:99%;" runat="server">
    <table id = "tblHeader" runat="server" border="0" width="100%" style=" text-align:left; font-size :large ;margin: 2px 0px 2px 2px;display:none;" cellspacing="0">
            <tr>
                <td class="wizardHeadImage" style="display:none;">
                    <div class="wizardLeftImage">
                         <asp:Label id="Label1" runat="server" text="<%$Resources:Resource, Floor_Profile%>" visible="false" Font-Names="Verdana" Font-Size="11pt"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" Width="15px" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                          OnClientClick="Javascript:closewindow();" />
                    </div>
                </td>
            </tr>
  </table>
    <div style="padding-left:20px;">
    <table style="margin-top: 5px; margin-left: 0px;" align="left">
          <tr>
            <td>
                <div runat="server" id="divFloorName" style="display: ">
                    <table align="left">
                        <tr>
                            <td width="100">
                                <asp:label id="Label2" runat="server" text="<%$Resources:Resource, Name%>" cssclass="Label">
                                </asp:label>:
                            </td>
                            <td width="200">
                                <asp:textbox id="txtfloorname" runat="server" cssclass="SmallTextBox" tabindex="1">
                                </asp:textbox>
                                <asp:label runat="server" id="lblfloorname" cssclass="linkText"></asp:label>
                                <asp:requiredfieldvalidator id="rf_validatorfloorname" runat="server" controltovalidate="txtfloorname"
                                    errormessage="*" forecolor="Red" display="Dynamic" validationgroup="rf_validationgroup"
                                    setfocusonerror="true">
                                </asp:requiredfieldvalidator>
                                                            
                            </td>
                            <td width="20px"></td>
                            <td width="50">
                             <asp:label id="Label3" runat="server" text="<%$Resources:Resource, Facility%>" cssclass="Label">
                                </asp:label>:
                            </td>
                          <td width="200">
                                <telerik:radcombobox id="cmbfacility" runat="server" height="100px" width="180px"
                                    tabindex="4">
                                </telerik:radcombobox>
                                <asp:label runat="server" id="lblfacility" cssclass="linkText"></asp:label>
                                <asp:requiredfieldvalidator id="rf_validatorfacility" runat="server" controltovalidate="cmbfacility"
                                    initialvalue="--Select--" errormessage="*" forecolor="Red" display="Dynamic"
                                    validationgroup="rf_validationgroup" setfocusonerror="true">
                                </asp:requiredfieldvalidator>
                            </td>
                        </tr>
                         <tr>
                            <td style="height: 10px" colspan="5">
                            </td>
                        </tr>
                        <tr>
                            <td width="100">
                                <asp:label ID="Label4" runat="server" text="<%$Resources:Resource, Description%>" cssclass="Label">
                                </asp:label>:
                            </td>
                            <td width="200">
                                <asp:textbox id="txtdescription" runat="server" cssclass="SmallTextBox" tabindex="2">
                                </asp:textbox>
                                <asp:label runat="server" id="lblDescription" cssclass="linkText"></asp:label>
                            </td>
                            <td width="20px">
                            </td>
                            <td width="50">
                                <asp:label runat="server" id="lbl_height" text="<%$Resources:Resource, Height%>"
                                    cssclass="Label"></asp:label>:
                            </td>
                           <td width="200">
                                <asp:textbox id="txtheight" runat="server" cssclass="SmallTextBox" tabindex="5">
                                </asp:textbox>
                                <asp:label runat="server" id="lblheight" cssclass="linkText"></asp:label>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px" colspan="5">
                            </td>
                        </tr>
                        <tr>
                            <td width="100">
                                <asp:label runat="server" id="lbl_category" text="<%$Resources:Resource, Category%>"
                                    cssclass="Label"></asp:label>:
                            </td>
                          <td width="200">
                                <telerik:radcombobox id="cmbcategory" runat="server" height="100px" width="180px"
                                    tabindex="3">
                                </telerik:radcombobox>
                                <asp:label runat="server" id="lblcategory" cssclass="linkText"></asp:label>
                                <%--        <asp:LinkButton ID="lnkbtncategory" runat="server" OnClientClick="javascript:return openpopupaddomniclasslinkup()">Add</asp:LinkButton>
                                --%>
                            </td>
                            <td width="20px">
                            </td>
                           <td width="50">
                                <asp:label runat="server" id="lbl_elevation" text="<%$Resources:Resource, Elevation%>"
                                    cssclass="Label"></asp:label>:
                            </td>
                            <td>
                                <asp:textbox id="txtelevation" runat="server" cssclass="SmallTextBox" tabindex="6">
                                </asp:textbox>
                                <asp:label runat="server" id="lblelevation" cssclass="linkText"></asp:label>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 20px" colspan="5">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" align="left">
                                <asp:button id="btnsave" runat="server" text="<%$Resources:Resource, Save%>" width="80px"
                                    tabindex="7" validationgroup="rf_validationgroup" onclick="btnsave_Click" /> 
                                <asp:button id="btnDelete" runat="server" width="80px" text="<%$Resources:Resource, Delete%>"
                                    onclick="btnDelete_click" onclientclick="javascript:return chkdelete();" tabindex="8" />
                                <asp:button id="btncancel" runat="server" text="<%$Resources:Resource, Cancel%>"
                                    tabindex="8" width="80px" onclick="btncancel_Click" />
                                    <asp:Button ID="btnclose" runat="server" Width="80px" Text="<%$Resources:Resource, Close%>" Skin="Default" OnClientClick="Javascript:closewindow();" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>

        <tr>
            <td colspan="5">
                <div runat="server" id="divFloorDesc">
                    <table style="margin-top: 0px; margin-left: 0px;" align="left">
                       
                    </table>
                </div>
            </td>
        </tr>
    </table>
    </div>
    </div>
    <asp:hiddenfield id="hf_floor_id" runat="server" />
    <asp:hiddenfield id="hf_facility_id" runat="server" />
    <asp:hiddenfield id="hfpopupflag" runat="server" clientidmode="Static" />
    </form>
</body>
</html>
<%--</asp:Content>--%>