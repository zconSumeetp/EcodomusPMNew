<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ZoneProfile.aspx.cs" Inherits="App_Locations_ZoneProfile" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>



<html>
<head runat="server">
    <title>
        EcoDomus PM : Zone Profile
    </title>

    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />

    <telerik:RadCodeBlock ID="Codeblock1" runat="server" >
    <script type="text/javascript" language="javascript" >
        function NavigateToFindLocation() {
            top.location.href = "../Locations/FacilityMenu.aspx?zones=Zones&FacilityId=" + document.getElementById("hfFacility_id").value;


        }
        function NavigateToZonePM() {

            top.location.href = "ZonePM.aspx";


        }

        function navigate_zone_profile_pm() 
        {
            var url = "../locations/facilitymenu.aspx?name=" + document.getElementById("hfzonename").value + "&pagevalue=Zone Profile&id=" + document.getElementById("hflocationid").value;           
            parent.location.href(url);
        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }
       
    
    </script>
    </telerik:RadCodeBlock>




</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin: 0 0 0 0;">
<form id="form1" runat="server" style="margin: 0 0 0 0">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
       <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />


  <div style="width:100%;">
  <table style="margin-top:15px; margin-left:0px;" align="left" >
<caption>
   <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Zone_Profile%>" Visible="false"></asp:Label>
</caption>
<tr>
    <td style="height: 20px">
    </td>
</tr>
<tr>
    <td align="left"><asp:Label ID="lblzoneheading" runat="server"  Text="<%$Resources:Resource, Name%>" CssClass="Label" ></asp:Label>:</td>
    <td align="left"><asp:TextBox ID="txtzonename" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvname" ValidationGroup="rf_validationgroup" runat="server" ControlToValidate="txtzonename" 
        ErrorMessage="*" ForeColor="Red" Display="Dynamic" Visible="true" SetFocusOnError="true">
        </asp:RequiredFieldValidator>
        <asp:Label runat="server" ID="lblzonename"  CssClass="LabelText" ></asp:Label></td>
    <td style="width:20px;">
    </td>
       
    <td align="left">
    <asp:Label ID="Label3" runat="server"  Text="<%$Resources:Resource, Description%>" CssClass="Label" ></asp:Label>:
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
    <td align="left"><asp:Label ID="lblfacilityheading" runat="server"  Text="<%$Resources:Resource, Facility%> " CssClass="Label" ></asp:Label>:</td>
    <td align="left"><telerik:RadComboBox ID="cmbfacility" runat="server"  Height="100px" Width="180px" ></telerik:RadComboBox>
    <asp:RequiredFieldValidator  ID="rfvfacility" runat="server" ControlToValidate="cmbfacility" InitialValue="--Select--" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
         ValidationGroup="rf_validationgroup" SetFocusOnError="true"> 
        </asp:RequiredFieldValidator>
    <asp:Label ID="lblfacility" runat="server" CssClass="LabelText" ></asp:Label>
    
     </td>
     <td style="width:20px;">
     </td>
      <td align="left"><asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, Category%>" CssClass="Label" ></asp:Label>:</td>
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

   
    </div>


 



    </form>
</body>
</html>
