<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddEnergyModelingZoneList.aspx.cs" Inherits="App_NewUI_AddEnergyModelingZoneList" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
 <script type="text/javascript">
     function GetRadWindow() {
         var oWindow = null;
         if (window.radWindow) oWindow = window.radWindow;
         else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
         return oWindow;
     }

     function CloseWindow() {

         GetRadWindow().BrowserWindow.referesh_project_page();
         GetRadWindow().close();
         top.location.reload();
         //GetRadWindow().BrowserWindow.adjust_parent_height();
         return false;
     }


     function validate() {
         alert("ZoneList with this name already exists. Please enter another name.....");
         return false;
     }


     function adjust_Add_project_Popup(sender, args) {
         var wnd = GetRadWindow();
         if (wnd != null) {
             var bounds = wnd.getWindowBounds();
             var x = bounds.x;
             var y = bounds.y;
             //alert(x);
             //alert(y);
             wnd.moveTo(x, 25);
             // alert('window page' + document.body.scrollHeight);
             wnd.set_height(document.body.scrollHeight + 25)
             // alert('window page' + document.body.offsetWidth);
             //wnd.set_width(document.body.scrollWidth+200)

         }
         return true;
     }
       
        </script>
        
</head>
<body>
<form id="Form1" runat="server">
<asp:ScriptManager ID="Scriptmanager1" runat="server"></asp:ScriptManager>
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse">
<tr>
<td>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse">
        <tr>
            <td class="wizardHeadImage">
                <div class="wizardLeftImage">
                   <%-- <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />--%>
                    <asp:Label ID="lbl_header" Text="Add Zone List" runat="server"></asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                        OnClick="ibtn_close_Click" />
                </div>
            </td>
        </tr>
    </table>
</td>
</tr>

<tr>
<td style="padding-top:20px;padding-right:20px;padding-bottom:0px;padding-left:20px">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" >
        <tr>
            <td>
                <asp:Label ID="lbl_zone_list_name" runat="server" Text="Name:" CssClass="normalLabel"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txt_zone_list_name" runat="server" Width="200"></asp:TextBox>
            </td>
        </tr>
        
        <tr>
            <td colspan="2" style="height: 10px">
            </td>
        </tr>

        <tr>
            <td>
                <asp:Label ID="lbl_zone_list_description" runat="server" Text="Description:" CssClass="normalLabel"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txt_zone_list_description" runat="server" Width="200"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height: 10px">
            </td>
        </tr>

        <tr>
        <td colspan="2" align="right" style="padding-right:25px">
        <asp:Button ID="btn_save" runat="server" Text="Add" Width="50" 
                onclick="btn_save_Click" />
        </td>
        </tr>
    </table>
</td>
</tr>
</table>
<asp:HiddenField ID="hf_is_first_time" runat="server" Value="Y" />
<asp:HiddenField ID="hf_id" runat="server" Value="" />
</form>
</body>
</html>