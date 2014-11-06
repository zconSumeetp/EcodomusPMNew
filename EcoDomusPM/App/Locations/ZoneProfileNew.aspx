<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ZoneProfileNew.aspx.cs" Inherits="App_Locations_ZoneProfile" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html>
<head id="Head1" runat="server">
    <title>
        Zone Profile 
    </title> 

    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
<link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />

    <telerik:RadCodeBlock ID="Codeblock1" runat="server" >
    <script type="text/javascript" language="javascript" >
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CloseWindow1() {

            // GetRadWindow().BrowserWindow.referesh_project_page();
            GetRadWindow().close();
            //top.location.reload();
            //GetRadWindow().BrowserWindow.adjust_parent_height();
            return false;
        }
        function CancelWindow() {
            CloseWindow1();
        }

        function NavigateToFindLocation() {
            //debugger
            top.location.href = "../Locations/FacilityMenu.aspx?zones=Zones&FacilityId=" + document.getElementById("hfFacility_id").value;


        }
        function NavigateToZonePM() {

            top.location.href = "ZonePM.aspx";


        }


        function navigate_zone_profile_pm() {
            var url = "../locations/facilitymenu.aspx?name=" + document.getElementById("hfzonename").value + "&pagevalue=Zone Profile&id=" + document.getElementById("hflocationid").value;
            parent.location.href(url);
        }
        function navigate_zone_profile_pmpopup() {
            var url = "../locations/zoneprofileNew.aspx?name=" + document.getElementById("hfzonename").value + "&pagevalue=Zone Profile&id=" + document.getElementById("hflocationid").value + "&popupflag=popup";
            window.location.href(url);
        }
        function chkdelete() {

            var flag;
            flag = confirm("Do you want to delete this zone ?");
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
<form id="form1" runat="server" style="margin: 0 0 0 0" defaultfocus="txtzonename" >
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
       <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
<div  id="divProfilePage" style="width:100%;padding:0px;" runat="server">
    <table runat="server" id="tbltitle" border="0" cellpadding="0" cellspacing="0" width="100%"
        style="border-collapse: collapse; display: none;">
        <tr>
            <td class="wizardHeadImage" style="border-collapse: collapse; display: none;" colspan="3">
                <div class="wizardLeftImage">
                    <asp:Label ID="lblpoupmsg" runat="server" Text=""></asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                        OnClientClick="javascript:return CancelWindow();" />
                </div>
            </td>
        </tr>
    </table>
    <table style="margin-left: 20px;" align="left">
        <tr>
           <td>
            <div runat="server" id="divZoneName" style="display:none">
                <table style="margin-top: 15px; margin-left: 0px;" >
                    <tr>
                        <td>
                            <asp:Label ID="lblzoneheading" runat="server" Text="<%$Resources:Resource, Name%>"
                                CssClass="Label"></asp:Label>:
                        </td>
                        <td>
                            <asp:TextBox ID="txtzonename" runat="server" CssClass="SmallTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvname" ValidationGroup="rf_validationgroup" runat="server"
                                ControlToValidate="txtzonename" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                Visible="true" SetFocusOnError="true">
                            </asp:RequiredFieldValidator>
                            <asp:Label runat="server" ID="lblzonename" CssClass="LabelText"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                    <td colspan="2" height="20px"></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblfacilityheading" runat="server" Text="<%$Resources:Resource, Facility%> "
                                CssClass="Label"></asp:Label>:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cmbfacility" runat="server" Height="90" Width="180px">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="rfvfacility" runat="server" ControlToValidate="cmbfacility"
                                InitialValue="--Select--" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                ValidationGroup="rf_validationgroup" SetFocusOnError="true"> 
                            </asp:RequiredFieldValidator>
                            <asp:Label ID="lblfacility" runat="server" CssClass="LabelText"></asp:Label>
                       </td>
                    </tr>
                </table>
                </div>
            </td>
            <td width="0px">
            <div id="divSpace" runat="server" style="display:none;width:0px">
           
             </div>
               </td>
           
            <%--Original Table TD--%>
            <td>
                <table style="margin-top: 15px; margin-left: 0px;" align="left">
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, Description%>"
                                CssClass="Label"></asp:Label>:
                        </td>
                        <td>
                            <asp:TextBox ID="txtdescription" runat="server" CssClass="SmallTextBox"></asp:TextBox>
                            <asp:Label runat="server" ID="lbldescription" CssClass="LabelText"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                    <td colspan="2" height="20px"></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, Category%>" CssClass="Label"></asp:Label>:
                        </td>
                        <td>
                            <asp:TextBox ID="txtcategory" runat="server" CssClass="SmallTextBox"></asp:TextBox>
                            <asp:Label runat="server" ID="lblcategory" CssClass="LabelText"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
            <%--Original Table TD--%>
        </tr><%--Original Table TR--%>

        <tr>
         <td colspan="3"></td>
        </tr>


        <tr>
            <td colspan="3">
                <table style="margin-top: 15px; margin-left: 0px;" align="left">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnEdit" runat="server" Text="<%$Resources:Resource, Edit%>" skin="Default" 
                                Width="80" OnClick="btnedit_click" >
                           </telerik:RadButton>
                           <telerik:RadButton ID="btnDelete" runat="server" Text="<%$Resources:Resource, Delete%>"
                                skin="Default" Width="80" OnClick="btnDelete_Click" OnClientClicked="chkdelete" >
                          </telerik:RadButton>
                        </td>
                        <td>
                        <telerik:RadButton ID="btnSave" runat="server" Text="<%$Resources:Resource, Save%>" skin="Default"
                                Width="80" OnClick="btnsave_click" ValidationGroup="rf_validationgroup" ></telerik:RadButton>
                        <telerik:RadButton ID="btnCancel" runat="server" Text="<%$Resources:Resource, Cancel%>"
                                skin="Default" Width="80" OnClick="btncancel_Click" ></telerik:RadButton>
                        <telerik:RadButton ID="btnclose" runat="server" Width="100" Text="<%$Resources:Resource, Close%>"  OnClientClicked="closewindow" ></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr><%--Original Table TR--%>
    </table>
</div>

  <%--<div style="width:100%;">
  <table style="margin-top:15px; margin-left:0px;" align="left" >
<caption>
   <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Zone_Profile%>" Visible="false"></asp:Label>
</caption>
<tr>
    <td style="height: 20px">
    </td>
</tr>
<tr>
    <td align="left"><asp:Label ID="lblzoneheading" runat="server"  Text="<%$Resources:Resource, Name%>" CssClass="Label" ></asp:Label>:
    </td>
    <td align="left">
    <asp:TextBox ID="txtzonename" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvname" ValidationGroup="rf_validationgroup" runat="server" ControlToValidate="txtzonename" 
        ErrorMessage="*" ForeColor="Red" Display="Dynamic" Visible="true" SetFocusOnError="true">
        </asp:RequiredFieldValidator>
        <asp:Label runat="server" ID="lblzonename"  CssClass="LabelText" ></asp:Label>
        </td>
    <td style="width:20px;">
    </td>
       
    <td align="left">
    <asp:Label ID="Label3" runat="server"  Text="<%$Resources:Resource, Description%>" CssClass="Label" ></asp:Label> :
    </td>
    <td align="left">
        <asp:TextBox ID="txtdescription" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
        <asp:Label runat="server" ID="lbldescription" CssClass="LabelText" ></asp:Label> 
    </td>

</tr>
<tr>
    <td style="height: 20px">
    </td>
</tr>
<tr>
    <td align="left">
    <asp:Label ID="lblfacilityheading" runat="server"  Text="<%$Resources:Resource, Facility%> " CssClass="Label" ></asp:Label> :
    </td>
    <td align="left">
    <telerik:RadComboBox ID="cmbfacility" runat="server"  Height="100px" Width="180px" ></telerik:RadComboBox>
    <asp:RequiredFieldValidator  ID="rfvfacility" runat="server" ControlToValidate="cmbfacility" InitialValue="--Select--" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
         ValidationGroup="rf_validationgroup" SetFocusOnError="true"> 
        </asp:RequiredFieldValidator>
    <asp:Label ID="lblfacility" runat="server" CssClass="LabelText" ></asp:Label>
    
     </td>
     <td style="width:20px;">
     </td>
      <td align="left">
      <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, Category%>" CssClass="Label" ></asp:Label> :
      </td>
    <td align="left">
        <asp:TextBox ID="txtcategory" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
        <asp:Label runat="server" ID="lblcategory" CssClass="LabelText"></asp:Label>
    </td>
</tr>
<tr>
     <td style="height: 20px">
     </td>
</tr>

<tr><td></td></tr>
<tr><td></td></tr>
<tr>
<td><asp:Button ID="btnEdit" runat="server" Text="<%$Resources:Resource, Edit%>" skin="Hay" Width="80" OnClick="btnedit_click" /> </td>
<td><asp:Button ID="btnSave" runat="server" Text="<%$Resources:Resource, Save%>" skin="Hay" Width="80" OnClick="btnsave_click" ValidationGroup="rf_validationgroup" />
 <asp:Button ID="btnCancel" runat="server" Text="<%$Resources:Resource, Cancel%>" skin="Hay" Width="80" OnClick="btncancel_Click" /> 
 <asp:Button ID="btnDelete" runat="server" Text="<%$Resources:Resource, Delete%>" skin="Hay" Width="80" OnClick="btnDelete_Click" /> 
 </td>
<td>&nbsp;</td>
<td>&nbsp;</td>

</tr>
<tr><td> <asp:Label ID="lblMsg" runat="server" ></asp:Label> </td></tr>
    </table>

    <div id="divhf" style="display: none;">
         <asp:HiddenField ID="hfFacility_id" runat="server" />
         <asp:HiddenField ID="hflocationid" runat="server" />
         <asp:HiddenField ID="hfzonename" runat="server" />
    </div>
    </div>--%>

     <div id="divhf" style="display: none;">
         <asp:HiddenField ID="hfFacility_id" runat="server" />
         <asp:HiddenField ID="hflocationid" runat="server" />
         <asp:HiddenField ID="hfzonename" runat="server" />
         <asp:HiddenField ID="hfpopupflag" runat="server" ClientIDMode="Static" />
    </div>
    </form>
</body>
</html>
