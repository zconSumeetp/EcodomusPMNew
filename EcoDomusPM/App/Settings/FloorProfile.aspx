<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true" CodeFile="FloorProfile.aspx.cs" Inherits="App_Settings_FloorProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <table style="margin-top:15px; margin-left:50px;" align="left" >
  <caption >
  
<asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Floor_Profile%>">:</asp:Label>
   </caption>

   <tr>
        <td width="100">
            <asp:Label runat="server" ID="lblfloorname" Text="<%$Resources:Resource,Floor_Name%>" CssClass="Label" ></asp:Label>
        </td>
        <td>
        <asp:TextBox ID="txtfloorname" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
        </td>
                     <td width="100px"></td>
         <td width="100">
            <asp:Label runat="server" ID="lblfacility" Text="<%$Resources:Resource,Facility%>" CssClass="Label" ></asp:Label>:
        </td>
        <td>
        <telerik:RadComboBox ID="cmbfacility" runat="server"  Height="100px" Width="175px"></telerik:RadComboBox>
        </td>
   </tr>
   <tr > <td style="height:20px"></td></tr>
   <tr>
        <td width="100">
            <asp:Label runat="server" ID="lblDescription"  Text="<%$Resources:Resource,Description%>" CssClass="Label" ></asp:Label>:
        </td>
        <td>
            <asp:TextBox ID="txtdescription" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
        </td>
                    <td width="100px"></td>
         <td width="100">
            <asp:Label runat="server" ID="lblheight"  Text="<%$Resources:Resource,Height%>" CssClass="Label" ></asp:Label>:
        </td>
        <td>
            <asp:TextBox ID="txtheight" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
        </td>
   </tr>
    <tr > <td style="height:20px"></td></tr>
   <tr>
         <td width="100">
            <asp:Label runat="server" ID="lblcategory" Text="<%$Resources:Resource,Category%>" CssClass="Label" ></asp:Label>: 
        </td>
        <td>
        <telerik:RadComboBox ID="cmbcategory" runat="server" Height="100px" Width="175px"> </telerik:RadComboBox>
        </td>
          <td width="100px"></td>
         <td width="100">
            <asp:Label runat="server" ID="lblelevation"  Text="<%$Resources:Resource,Elevation%>" CssClass="Label" ></asp:Label>:
        </td>
        <td>
            <asp:TextBox ID="txtelevation" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
        </td>
   </tr>
    <tr > <td style="height:20px"></td></tr>
   <tr>
        <td colspan="5" align="center" >
            <asp:Button ID="btnsave" runat="server" Text="<%$Resources:Resource,Save%>" CssClass="btnGreen" />
             <asp:Button ID="btncancel" runat="server" Text="<%$Resources:Resource,Cancel%>" CssClass="btnGreen" />
        </td>
   </tr>

        </table> 

</asp:Content>

