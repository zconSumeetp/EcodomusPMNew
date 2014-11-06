<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddOmniclassUniclass.aspx.cs"
    Inherits="App_Settings_AddOmniclassUniclass" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head id="Head1" runat="server">
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
        <script type="text/javascript" language="javascript">


            function select_uniclass(id, name) {
                if (id == "") {
                    alert('Please select UniClass');
                    return false;
                }

            }

            function select_Sub_System1(id, name) {

                var rdw = GetRadWindow();
                if (window.parent.location.href.indexOf('OrganizationProfile') > 0) {
                    window.parent.load_omni_class(name, id);
                    rdw.close();
                }
                else if (window.parent.location.href.indexOf('UserProfile') > 0) {
                    window.parent.load_omni_class(name, id);
                    rdw.close();
                }
                else if (window.parent.location.href.indexOf('ClientUserProfile') > 0) {
                    window.parent.load_omni_class(name, id);
                    rdw.close();

                }
                else {
                    //window.parent.refreshgrid();
                    rdw.close();
                }

            }
            function onTabSelecting(sender, args) {
                if (args.get_tab().get_pageViewID()) {
                    args.get_tab().set_postBack(false);
                }
            }
            function test() {
                //          parent.document.getElementById('hfformatid').value = id;
            }


            function selectedformat(id, name) {
                if (window.parent.location.href.indexOf('TypePM') == -1) {
                    parent.document.getElementById('hfformatid').value = id;
                    parent.document.getElementById('hfformatname').value = name;
                    parent.document.getElementById('lblMasterFormat').innerHTML = name;

                }
                window.parent.refreshgrid();
                var oWnd = GetRadWindow();
                oWnd.close();
            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }
            var previous = "";
            function adjust_height(tabname) {

//                var wnd = GetRadWindow();
//                if (wnd != null) {
//                    var bounds = wnd.getWindowBounds();
//                    var x = bounds.x;
//                    var y = bounds.y;
//                    //alert(x);
//                    //alert(y);
//                    if (x == 0)
//                        wnd.moveTo(x + 270, 100);

//                    //  wnd.center();
//                    //alert('window page' + document.body.scrollHeight);
//                    if (tabname == "MasterFormat") {
//                        // wnd.set_width(document.body.scrollWidth);
//                        wnd.set_height(380);
//                        previous = tabname;
//                    }
//                    else if (tabname == "UniFormat") {
//                        //wnd.set_height(document.body.scrollHeight);
//                        wnd.set_height(250);
//                        previous = tabname;
//                    }
//                    else if (tabname == "OmniClass") {
//                        if (previous == "MasterFormat") {
//                            wnd.set_height(document.body.scrollHeight + 210);
//                            previous = "OmniClass";
//                        }
//                        //wnd.set_height(533);
//                        else if (previous == "UniFormat") {
//                            // wnd.set_height(533);
//                            wnd.set_height(document.body.scrollHeight + 330);
//                            previous = "OmniClass";
//                        }
//                        if (previous == "UniClass") {
//                            wnd.set_height(document.body.scrollHeight - 30);
//                            previous = "OmniClass";
//                        }
//                    }
//                    else if (tabname == "UniClass") {
//                        if (previous == "MasterFormat") {
//                            wnd.set_height(560);
//                            previous = "UniClass";
//                        }
//                        else if (previous == "UniFormat") {
//                            wnd.set_height(560);
//                            previous = "UniClass";
//                        }
//                        else if (previous == "OmniClass") {
//                            wnd.set_height(560);
//                            previous = "UniClass";
//                        }
//                        else {
//                            wnd.set_height(560);
//                        }
//                    }
//                    else {
//                        if (window.parent.location.href.indexOf("TypeProfile.aspx") >= 0) {
//                            wnd.moveTo(x - 200, 10);
//                            wnd.set_height(510);
//                        }
//                        else {
//                            wnd.set_height(document.body.scrollHeight + 30);
//                        }
//                    }
                    // alert('window page' + document.body.offsetWidth);
                    //wnd.set_width(document.body.scrollWidth+200)
 //               }

            }


            function selectuniformat(id, name) {

                if (window.parent.location.href.indexOf('TypePM') == -1) {
                    parent.document.getElementById('hfuniformat_id').value = id;
                    parent.document.getElementById('hfuniformatname').value = name;
                    parent.document.getElementById('lblUniFormat').innerHTML = name;

                }
                window.parent.refreshgrid();
                var oWnd = GetRadWindow();
                oWnd.close();

            }

            function refreshpage() {
                // alert('hii');
                window.parent.refreshgrid();
                var oWnd = GetRadWindow();
                oWnd.close();
            }
            function CloseAndRebind(args) {
                GetRadWindow().Close();
                GetRadWindow().BrowserWindow.refreshGrid(args);
            }
            function chkvalidate() {
                alert("Please select Masterformat");
                return false;

            }
            function chkuniformat() {

                alert("Please select Uniformat");
                return false;
            }
            function CloseWindow() {
                var url = GetRadWindow().BrowserWindow.location.href; ;
                //GetRadWindow().BrowserWindow.referesh_facility_page();
                window.parent.resizePopup('popResizeBack');
                GetRadWindow().close();
               
                return false;
            }
            function OnClinetTab_selected(sender, args) {
                //       adjust_height();
                var tabname = args.get_tab().get_text();
                if (tabname == "OmniClass") {
                    document.getElementById("hf_OmniclassFlag").value = "OmniClass";
                }
                else if (tabname == "UniClass") {
                    document.getElementById("hf_OmniclassFlag").value = "UniClass";
                }

             

            }
            function select_Sub_System(id, name) {

                var rdw = GetRadWindow();
                if (window.parent.location.href.indexOf('TypePM') == -1) {

                    rdw.BrowserWindow.load_omni_class(name, id);

                    window.close();
                }
                var rdw = GetRadWindow();
                rdw.close();
                GetRadWindow().BrowserWindow.refreshGrid();
                window.parent.refreshgrid();
                window.opener.load_omni_class(name, id);
                self.close();
            }
            // window.onload = adjust_height; 
        </script>
    </telerik:RadCodeBlock>
    <link href="../../App_Themes/EcoDomus/Skins/MyCustomTabStrip/TabStrip.MyCustomTabStrip.css"
        rel="stylesheet" type="text/css" />
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
    <%-- <style type="text/css"> 
    div.RadTabStrip .rtsLI 
    { 
        margin-right: 0px; 
      
    } 
</style> --%>
</head>
<body style="background-color: #EEEEEE; overflow: hidden;">
    <form runat="server" id="mainForm" method="post">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" DecoratedControls="Buttons,ScrollBars" />
    <telerik:RadAjaxLoadingPanel runat="server" ID="LoadingPanel1" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <div style="width: 100%; border: 0px; border-color: Red; background-color: #EEEEEE;
        overflow: hidden;">
        <table border="0" width="100%" cellspacing="0" style="overflow: hidden;">
           <tr>
                <td style="background-color: #F7F7F7; padding-top: 10px;">
                    <telerik:RadTabStrip runat="server" ID="RadTabStrip1" SelectedIndex="0" MultiPageID="RadMultiPage1"
                        Align="Center" Orientation="HorizontalBottom" ShowBaseLine="True" dir="ltr" CssClass="normalLabel"
                        Height="30px" BorderWidth="0px" EnableEmbeddedSkins="false" OnClientTabSelected="OnClinetTab_selected"
                        OnTabClick="rdstripSetupSync_TabClick">
                    </telerik:RadTabStrip>
                </td>
            </tr>
            <tr>
                <td style="overflow: hidden;">
                    <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" OnPageViewCreated="RadMultiPage1_PageViewCreated">
                    </telerik:RadMultiPage>
                </td>
            </tr>
        </table>
        <div runat="server" id="div_assign" style="margin-left: 0px; padding-left: 65px;">
            <asp:HiddenField ID="hfformatid1" runat="server" />
            <asp:HiddenField ID="hfformatname1" runat="server" />
            <asp:HiddenField ID="hf_OmniclassFlag" runat="server" />
            <br />
        </div>
    </div>
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadTabStrip1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadTabStrip1" />
                    <telerik:AjaxUpdatedControl ControlID="RadMultiPage1" LoadingPanelID="LoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="radbtnAssignUniformt" LoadingPanelID="LoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="radbtnAssignMaster" LoadingPanelID="LoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadMultiPage1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadMultiPage1" LoadingPanelID="LoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <asp:HiddenField ID="hfisfromtypepm" runat="server" />
    </form>
</body>
</html>
