<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SetLocationHierarchy.aspx.cs" Inherits="App_Locations_SetLocationHierarchy" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EcoDomus PM : Map Location Hierarchy</title>
    <link href="../../App_Themes/EcoDomus/style.css" rel="stylesheet" type="text/css" />
      <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
        <script type="text/javascript" language="javascript">

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function closeWindow_assign() {
                var rdw = GetRadWindow();
                rdw.close();
            }

            function closeWindow() {
                self.close();
            }
        </script>
      </telerik:RadCodeBlock>

      
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-position: white; background: white;">
    <form id="form1" runat="server">
    <div style="margin-left:25px;">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
       <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" Skin="Hay" DecoratedControls="Buttons"  />
            <table style="margin-top:10px;">
             <caption>
               <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Location_Hierarchy%>"></asp:Label>
             </caption>
                <tr>
                    <td>
                        
                    </td>
                </tr>
            </table>
            
              <asp:Table ID="tblHierarchy" runat="server"></asp:Table>

            <table><tr><td style="height:20px" ></td></tr></table>
              <asp:Button ID="btn_save_hierarchy" Text="<%$Resources:Resource, Save_Hierarchy%>" runat="server" Width="125" 
            onclick="btn_save_hierarchy_Click"  /> &nbsp;&nbsp;&nbsp;
              <asp:Button ID="btn_close" runat="server" Text="<%$Resources:Resource, Close%>" Width="100" OnClientClick="javascript:closeWindow();" />

      
    </div>
    </form>
</body>
</html>
