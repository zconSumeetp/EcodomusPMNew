<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="FloorProfile.aspx.cs" Inherits="App_Settings_FloorProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">--%>
<html>
<head> 
<title>
    EcoDomus FM : Floor Profile 
</title>
 <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
 
 <telerik:RadCodeBlock ID="radcodeblock1" runat="server">

        <script type="text/javascript" language="javascript">

            function openpopupaddomniclasslinkup() {
                var url = "AssignOmniclass.aspx?Item_type=floor";
                window.open(url, "Window1", "menubar=no,width=500,height=450,right=50,toolbar=no,scrollbars=yes");
                return false;
            }
            function NavigateToFindLocation() 
            {
                top.location.href = "../Locations/FindLocation.aspx";
            }


            function navigate_floor() 
            {
                var url = "../locations/facilitymenu.aspx?pagevalue=Floor Profile&id=" + document.getElementById("hf_floor_id").value;
                // + "&facility_id=" + document.getElementById("hf_facility_id").value;
                parent.location.href(url);                
            }

            function validate() {
                alert("Floor name already exists");
                return false;
            }

            function NavigateToFindLocationPM() 
            {
                top.location.href = "../Locations/FloorsPM.aspx";
            }
            



            </script>
            </telerik:RadCodeBlock>
             <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
            </head>
            <body style="background: white; padding: 0px; margin: 0 0 0 0;">
<form id="form1" runat="server" style="margin: 0 0 0 0">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>

     <asp:HiddenField ID="hflocationid" runat="server" />

  <table style="margin-top:15px; margin-left:0px;" align="left" >
  <caption>
      <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Floor_Profile%>"></asp:Label>      
  </caption>
  <tr> <td style="height:20px"></td></tr>
   <tr>
        <td width="100">
            <asp:Label runat="server"  Text="<%$Resources:Resource, Name%>" CssClass="Label" ></asp:Label>
        </td>
        <td>
        <asp:TextBox ID="txtfloorname" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
         <asp:Label runat="server" ID="lblfloorname"  CssClass="linkText" ></asp:Label> 
          <asp:RequiredFieldValidator  ID="rf_validatorfloorname" runat="server" ControlToValidate="txtfloorname" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
         ValidationGroup="rf_validationgroup" SetFocusOnError="true"> 
        </asp:RequiredFieldValidator>
        </td>
                     <td width="100px"></td>
         <td width="100">
            <asp:Label runat="server"  Text="<%$Resources:Resource, Facility%>" CssClass="Label" ></asp:Label> :
        </td>
        <td>
        <telerik:RadComboBox ID="cmbfacility" runat="server"  Height="100px" Width="175px"></telerik:RadComboBox>
         <asp:Label runat="server" ID="lblfacility"  CssClass="linkText" ></asp:Label> 
        <asp:RequiredFieldValidator  ID="rf_validatorfacility" runat="server" ControlToValidate="cmbfacility" InitialValue="--Select--" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
         ValidationGroup="rf_validationgroup" SetFocusOnError="true"> 
        </asp:RequiredFieldValidator>
        </td>
    </tr>
   <tr > <td style="height:10px"></td></tr>
   <tr>
        <td width="100">
            <asp:Label runat="server"   Text="<%$Resources:Resource, Description%>" CssClass="Label" ></asp:Label> :
        </td>
        <td>
            <asp:TextBox ID="txtdescription" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
            <asp:Label runat="server" ID="lblDescription"  CssClass="linkText" ></asp:Label> 
        </td>
                    <td width="100px"></td>
         <td width="100">
            <asp:Label runat="server" id="lbl_height"  Text="<%$Resources:Resource, Height%>" CssClass="Label" ></asp:Label> :
        </td>
        <td>
            <asp:TextBox ID="txtheight" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
            <asp:Label runat="server" ID="lblheight"  CssClass="linkText" ></asp:Label> 
        </td>
   </tr>
    <tr > <td style="height:10px"></td></tr>
   <tr>
         <td width="100">
            <asp:Label runat="server" ID="lbl_category" Text="<%$Resources:Resource, Category%>" CssClass="Label" ></asp:Label> : 
        </td>
        <td>
        <telerik:RadComboBox ID="cmbcategory" runat="server" Height="100px" Width="175px"> </telerik:RadComboBox>
        <asp:Label runat="server" ID="lblcategory"   CssClass="linkText" ></asp:Label> 

<%--        <asp:LinkButton ID="lnkbtncategory" runat="server" OnClientClick="javascript:return openpopupaddomniclasslinkup()">Add</asp:LinkButton>
--%>        </td>
          <td width="100px"></td>
         <td width="100">
            <asp:Label runat="server"  id="lbl_elevation"  Text="<%$Resources:Resource, Elevation%>" CssClass="Label" ></asp:Label> :
        </td>
        <td>
            <asp:TextBox ID="txtelevation" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
            <asp:Label runat="server" ID="lblelevation"   CssClass="linkText" ></asp:Label> 
        </td>
   </tr>
    <tr > <td style="height:20px"></td></tr>
   <tr>
        <td colspan="5" align="left" >
            <asp:Button ID="btnsave" runat="server" Text="<%$Resources:Resource, Save%>" width="50px"  ValidationGroup="rf_validationgroup" 
                onclick="btnsave_Click" />
             <asp:Button ID="btncancel" runat="server" Text="<%$Resources:Resource, Cancel%>" width="50px" 
                onclick="btncancel_Click" />
        </td>
   </tr>
  </table> 
  <asp:HiddenField ID="hf_floor_id" runat="server" />
  <asp:HiddenField ID="hf_facility_id" runat="server" />
  </form> 
  </body> 
 </html>
 <%--</asp:Content>--%>