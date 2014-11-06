<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeleteAttribute.aspx.cs" Inherits="App_Asset_DeleteAttribute" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<%----%>
<script type="text/javascript" language="javascript">
    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    }

    function closeWindow() {        
        var oWnd = GetRadWindow();
        oWnd.close();
        parent.window.refreshgrid();
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

    function viewcompodelete() {
        document.getElementById('btnDeleteAllAttrCompo').style.display = 'block'       
        document.getElementById('btnDeleteAllAttrType').style.display = 'none'
    }

    function viewtypedelete() {
        document.getElementById('btnDeleteAllAttrType').style.display = 'block'
        document.getElementById('btnDeleteAllAttrCompo').style.display = 'none'
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    }

</script>
<title></title>
<link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
</head>
<body style="width:100%;background-color:#EEEEEE;">
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <form id="form1" runat="server" style="overflow:hidden ;">
        <asp:ScriptManager ID="scrmg1" runat="server">
    </asp:ScriptManager>
     <telerik:RadFormDecorator ID="formdecorator1" runat="server" DecoratedControls="Buttons"
        Skin="Default" />

<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse">
<tr>
<td style="padding-top:10px;padding-right:0px;padding-bottom:0px;padding-left:0px">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" >
        <tr>
            <td>
               
              <asp:Label ID="Label2" Font-Size="Medium" style="padding-left:25px ;" Text="Are you sure you want to delete attributes?" runat="server"></asp:Label>
    
            </td>            
        </tr>
        
        <tr>
            <td colspan="3" style="height: 15px">
            </td>
        </tr>    

        <tr>
        <td colspan="3" align="left" style="padding-left:25px;">
         <asp:Button ID="btnDeleteAttr" runat="server" Text="Delete Attributes" Width="120px" onclick="btnDeleteAttr_Click"/>  
      <asp:Button ID="btnDeleteAllAttr" runat="server" Text="" Width="240px" onclick="btnDeleteAllAttrCompo_Click"  />    
     
      <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                OnClientClick="javascript:return closeWindow()"/>
        </td>
        </tr>
        <tr>
            <td colspan="3" style="height: 30px">
            </td>
        </tr>   
    </table>
</td>
</tr>
</table>

    </form>
</body>
<%--Please don't move this code--%>
<%-- <link rel="Stylesheet" type="text/css" href="~/App_Themes/EcoDomus/style_new_ui_pm.css" />--%>
</html>

