<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeFile="EntityDetailPage.aspx.cs" Inherits="App_UserControls_UserControlNewUI_EntityDetailPage" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CloseWindow() {
            GetRadWindow().close();
            GetRadWindow().BrowserWindow.adjust_parent_height();
            return false;
        }


        function adjust_height() {
            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                //alert(x);
                //alert(y);
                wnd.moveTo(x, 25);
               // alert('window page' + document.body.scrollHeight);
                wnd.set_height(document.body.scrollHeight)
                // alert('window page' + document.body.offsetWidth);
                //wnd.set_width(document.body.scrollWidth+200)
            }
        }
        
    </script>

    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
</head>
<body style="overflow:hidden;">
<form runat="server">
 <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="RadioButtons,Scrollbars" />
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td class="wizardHeadImage">
            <div class="wizardLeftImage">
                <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />
                <asp:Label ID="lbl_header" Text="Details" runat="server"></asp:Label>
            </div>
            <div class="wizardRightImage">
                <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                    OnClick="ibtn_close_Click" />
            </div>
        </td>
    </tr>
    <tr>
        <td style="padding-left:5px;padding-right:5px;padding-top:5px;padding-bottom:5px" align="center">
            <telerik:RadGrid ID="rg_entity_import_details" runat="server" 
                AllowPaging="true" BorderColor="#BFBFBF" BorderStyle="Solid"
                PageSize="10"  BorderWidth="1" AllowMultiRowSelection="true" 
                PagerStyle-AlwaysVisible="true" AutoGenerateColumns="false" Width="100%" 
                onpageindexchanged="rg_entity_import_details_PageIndexChanged" 
                onpagesizechanged="rg_entity_import_details_PageSizeChanged">
                <ClientSettings EnableRowHoverStyle="true">
                    <Selecting AllowRowSelect="true" />
                </ClientSettings>
                <MasterTableView DataKeyNames="name" HeaderStyle-CssClass="gridHeaderText">
                    <PagerStyle HorizontalAlign="Right" Mode="NextPrevAndNumeric" AlwaysVisible="true"
                        PageSizeLabelText="Show Rows" />
                    <AlternatingItemStyle BackColor="#F8F8F8" />
                    <Columns>
                        <telerik:GridBoundColumn DataField="name" HeaderText="Name" UniqueName="name">
                            <ItemStyle Wrap="false" />
                            <HeaderStyle Wrap="false" />
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </td>
    </tr>
    <tr>
        <td style="background-color: Orange; height: 1px;">
        </td>
    </tr>
     <tr>
        <td style="height:10px;">
        </td>
    </tr>
</table>
</form>
</body>
</html>

