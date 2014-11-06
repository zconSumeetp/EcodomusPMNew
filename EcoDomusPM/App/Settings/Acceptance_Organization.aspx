<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Acceptance_Organization.aspx.cs" Inherits="App_Settings_Acceptance_Organization" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%--<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">--%>
  
    <html>
    <head id="Head1" runat="server">
 <base target="_self"/> 
 <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <title>EcoDomus :- Accept Organization</title>
 </head>
    <body>
    <form id="form1" runat="server">
   
    <img alt="EcoDomus logo" src="../Images/EcoDomus_logo.jpg" />
  <telerik:RadFormDecorator ID="rfdAcceptanceProject" runat="server"  DecoratedControls="All"  />
      <asp:ScriptManager ID="ScriptManager2" runat="server">
    </asp:ScriptManager>

    <table width ="100%" border="0" style="margin-top:15">
    <tr>
       <td colspan ="2" class="head"  align="left">
         <h2>
         <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Organization_Acceptance%>"></asp:Label>
         :</h2>   
          
        </td>
    </tr>
 
    
   <%-- <tr>
        <td align="right" style="font:12px bold">
            <span style="font-weight:bold">Organization Name:</span>
        </td>
        <td>
            &nbsp<asp:Label ID="lblProjectName" runat="server"></asp:Label>
        </td>
    </tr>--%>
    <tr>
        <td colspan="2">
            &nbsp
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td align="right" >
            <asp:Button ID="btnAccept" runat="server" Text="<%$Resources:Resource,Accept%>" Width="100px" 
                onclick="btnAccept_Click" />
        </td>
        <td>
            <asp:Button ID="btnDeny" runat="server" Text="<%$Resources:Resource,Deny%>" Width="100px" onclick="btnDeny_Click"/>                            
            &nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Button ID="btnClose" runat="server" Text="<%$Resources:Resource,Close%>" Width="100px" OnClientClick="javascript:window.close();"  /> 
         <%--   <input type="button" value="Close"  Text="<%$Resources:Resource,Close%>" style="width:100px" onclick="javascript:window.close();"  />--%>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            &nbsp
        </td>
    </tr>
     <tr>
        <td colspan="2">
            &nbsp
        </td>
    </tr>
    <tr>
        <td align="Center" colspan="4">
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
        </td>
    </tr>
</table>
</form>
    </body>
    </html>

<%--</asp:Content>
--%>