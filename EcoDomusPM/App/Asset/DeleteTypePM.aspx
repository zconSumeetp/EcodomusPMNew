<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeleteTypePM.aspx.cs" Inherits="App_Asset_DeleteTypePM" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" language="javascript">
    function closeWindow() 
    {     
        var oWnd = GetRadWindow();
        oWnd.close();
        parent.window.refreshgrid();
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    }

</script>
</head>
<body style="margin: 0px 0px 0px 0px; padding-top: 0; background: white;">
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <form id="form1" runat="server">
        <asp:ScriptManager ID="scrmg1" runat="server">
    </asp:ScriptManager>
     <telerik:RadFormDecorator ID="formdecorator1" runat="server" DecoratedControls="Buttons"
        Skin="Hay" />
     <div style="margin-left: 20px;margin-top:20px;">
        <h2>
              <asp:Label ID="lbladdcompattribute" Font-Size="Small"   Text="Are you sure you want to delete this Type?" runat="server"></asp:Label>
        </h2>
    </div>
    <div style="margin-left:10px; margin-top:3px;">
      <asp:Button ID="btnDeleteTypeOnly" runat="server" Text="Delete Type only" Width="120px" OnClick="btn_delete_type"  />
         
      <asp:Button ID="btnDeleteTypeWithComponent" runat="server" Text="Delete Type with its Components" Width="200px" OnClick="btnDeleteTypeWithComponent_Click" />
           
      <asp:Button ID="btnCancel" runat="server" Text="Cancel"  Width="50px" OnClientClick="javascript:return closeWindow()" />
      </div>
    </form>
</body>
</html>

</html>
