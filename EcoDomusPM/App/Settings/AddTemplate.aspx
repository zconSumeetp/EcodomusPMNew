<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddTemplate.aspx.cs" Inherits="App_Settings_AddTemplate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript">

    function onTabSelecting(sender, args) {
        if (args.get_tab().get_pageViewID()) {
            args.get_tab().set_postBack(false);
        }
    }
    function CloseWindow() {
        //var url = GetRadWindow().BrowserWindow.location.href; ;
        window.parent.refreshgrid();
        window.close();
        return false;
    }
    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    }
    function LogoutNavigation() {
        var query = parent.location.href;
        top.location.href(query);
    }

    function adjust_height() {

        var wnd = GetRadWindow();
        if (wnd != null) {
            var bounds = wnd.getWindowBounds();
            var x = bounds.x;
            var y = bounds.y;
            //alert(x);
            //alert(y);
            wnd.moveTo(x - 40, 140);
            //alert('window page' + document.body.scrollHeight);
            wnd.set_height(document.body.scrollHeight + 30)
            // alert('window page' + document.body.offsetWidth);
            //wnd.set_width(document.body.scrollWidth + 15)
        }

    }
</script>
<head id="Head1" runat="server">
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
        .rtsTxt
        {
            padding-left: 0px !important;
            text-align: center !important;
            margin-top: 10px;
        }
        .rtsImg
        {
            background-color: transparent;
            width: 22px;
            height: 40px;
            margin: 0px;
        }
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
    <title></title>
</head>
<body style="background: #EEEEEE; padding: 0px; margin: 0 0 0 0;">
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div style="padding-left: 0px; width: 100%; background-color: #EEEEEE; border: 2px">
        <%-- <table>
            <caption>
                <asp:Label ID="lbl" runat="server" Text="Add Template"></asp:Label>:
            </caption>
        </table>--%>
        <div id="div_add_existing" runat="server" visible="true">
            <table width="100%">
                <tr style="display:none">
                    <td class="wizardHeadImage">
                        <div class="wizardLeftImage">
                            <asp:Label ID="Label1" runat="server" Font-Size="10pt" Text="<%$Resources:Resource,Attribute_Template%>"></asp:Label>
                        </div>
                        <div class="wizardRightImage">
                            <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                OnClientClick="javascript:return CloseWindow();"  Style="height: 16px" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="background-color: #F7F7F7;">
                        <telerik:RadTabStrip runat="server" ID="RadTabStrip1" SelectedIndex="0" MultiPageID="RadMultiPage1"
                            Align="Justify" ShowBaseLine="True" Skin="" dir="ltr" CssClass="normalLabel"
                            Height="40px" OnTabClick="rdstripSetupSync_TabClick" BorderWidth="0px">
                        </telerik:RadTabStrip>
                    </td>
                </tr> 
                <tr>
                    <td>
                        <telerik:RadMultiPage ID="RadMultiPage1" Height="190px" runat="server" SelectedIndex="0" OnPageViewCreated="RadMultiPage1_PageViewCreated"
                            CssClass="multiPage">
                        </telerik:RadMultiPage> 
                    </td>
                    <td>
                        <asp:HiddenField ID="hftemplate_id" runat="server" />
                        <asp:HiddenField ID="hfTemplate_name" runat="server" />
                        <asp:HiddenField ID="hf_flag" runat="server" />
                        <asp:HiddenField ID="hf_facility_ids" runat="server" />
                        <asp:HiddenField ID="hfglobal_flag" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
