<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Unassign.aspx.cs" Inherits="App_Asset_Unassign" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function refreshParent() {
            var rdw = GetRadWindow();
            rdw.close();       
          window.close();
        }
     
  
         
    </script>
</head>
<body>
   
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="36000">
    </asp:ScriptManager>
    <div style="margin-top: 40px">
        <table>
        <tr>
        <td colspan="2">
        <asp:Label ID="lbl_title" runat="server" Text="Select" ForeColor="#990000" Font-Bold="true"></asp:Label>
        </td>
        </tr>
            <tr>
                <td colspan="2" class="style1">
                    <telerik:RadGrid ID="rg_unassign" runat="server" AutoGenerateColumns="false" Width="100%"
                        PagerStyle-AlwaysVisible="true" OnNeedDataSource="system_grid_NeedDataSource"
                        AllowMultiRowSelection="true" AllowSorting="true" ShowFooter="True" OnSortCommand="rg_unassign_OnSortCommand">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="Unassign_Items">
                            <Columns>
                                <telerik:GridClientSelectColumn ItemStyle-Width="100px">
                                    <ItemStyle Width="100px" />
                                    <HeaderStyle Width="100px" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="Unassign_Items" HeaderText="Unassign Items" ItemStyle-Width="200px">
                                    <ItemStyle CssClass="column" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadFormDecorator ID="rdfAll" DecoratedControls="Scrollbars,Buttons" Skin="Hay"
                        runat="server" />
                    <asp:Button ID="btn_unassign" runat="server" Text="Unassign" Width="100px" OnClick="btn_unassign_Click" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
