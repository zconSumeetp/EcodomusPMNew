<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingWizardWindow.aspx.cs"
    Inherits="App_NewUI_EnergyModelingWizardWindow" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        
        function CloseWindow() {
        var url = GetRadWindow().BrowserWindow.location.href; ;
        GetRadWindow().BrowserWindow.referesh_facility_page();
        GetRadWindow().close();
            return false;
        }

        function page_javascript_function() {
            alert('page_javascript_function');
        
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
                //alert('window page' + document.body.scrollHeight);
                wnd.set_height(document.body.scrollHeight + 20)
                // alert('window page' + document.body.offsetWidth);
                //wnd.set_width(document.body.scrollWidth+200)
            }
        }
        
    </script>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <style type="text/css">
        .rtsSelected
        {
            background-color: transparent;
            font-weight: bold;
            font-size: 14px;
            font-family: "Arial" , sans-serif;
        }
        
        .rtsIn
        {
            background-color: transparent;
            color: #696969;
           
        }
        .rtsImg
        {
            background-color: transparent;
            width: 22px;
            height:40px;
            margin:0px;
        }
       html, body, form
        {
            margin: 0;
            padding: 0;
           overflow:auto;
        }
    </style>
</head>
<body>
    <form id="frm_wizard" runat="server">
    <asp:ScriptManager ID="ScriptManagerId" runat="server" AsyncPostBackTimeout="3600">
    </asp:ScriptManager>
    <div style="width: 100%; border: 0px; border-color: Red; background-color:#FFFFFF;">
        <table border="0" width="100%" cellspacing="0">
            <tr>
                <td class="wizardHeadImage">
                    <div class="wizardLeftImage">
                        <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />
                        <asp:Label ID="lbl_header" Text="Add Energy Modeling" runat="server"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClick="ibtn_close_Click" />
                    </div>
                </td>
            </tr>
            <tr>
                <td style="background-color: #F7F7F7;">
                    <telerik:RadTabStrip runat="server" ID="rts_energy_plus" SelectedIndex="0" MultiPageID="rmp_energy_plus"
                        Align="Justify" ShowBaseLine="True" Skin="" dir="ltr" CssClass="normalLabel"
                        Height="40px" OnTabClick="rts_energy_plus_TabClick" BorderWidth="0px">
                    </telerik:RadTabStrip>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadMultiPage runat="server" ID="rmp_energy_plus" SelectedIndex="0" OnPageViewCreated="rmp_energy_plus_PageViewCreated">
                    </telerik:RadMultiPage>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hf_facility_id" runat="server" Value="" />
     <asp:HiddenField ID="hf_zone_xml" runat="server" Value="" />
      <asp:HiddenField ID="hf_system_xml" runat="server" Value="" />
    <asp:HiddenField ID="hf_facility_name" runat="server" Value="" />
    <asp:HiddenField ID="hf_file_path" runat="server" Value="" />
    <asp:HiddenField ID="hf_file_full_path" runat="server" Value="" />
    <asp:HiddenField ID="hf_file_name" runat="server" Value="" />
    </form>
</body>
</html>
