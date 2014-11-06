<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditDesignerContractorNew.aspx.cs"
    Inherits="App_Asset_EditDesignerContractorNew" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">
        function CloseWindow() {
             var url = GetRadWindow().BrowserWindow.location.href; ;
            //GetRadWindow().BrowserWindow.referesh_facility_page();
            GetRadWindow().close();
            window.parent.resizeParentPopupReversBack();
            return false;
        }
 

        function onTabSelecting(sender, args) {
         
            if (args.get_tab().get_pageViewID()) {
                args.get_tab().set_postBack(false);
            }
            var tab = args.get_tab();
            var flag = args.get_tab()._linkElement.toString();
            var name = tab.get_text();
            if (name == "Contractor") {
                //window.location.indexOf("franky") >= 0
                if (flag.indexOf("IsFromTypePM=Y") >= 0) {
                    adjust_height("Contractor1")
                }

                else {
                    adjust_height(name);
                }
            }
            else {
                if (flag.indexOf("IsFromTypePM=Y") >= 0) {
                    adjust_height(name);
                }
                else {
                    adjust_height("Designer1");
                }
            }
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        //    function selectedformat(id, name) {
        //        
        //        if (window.parent.location.href.indexOf('TypePM') == -1) {
        //            parent.document.getElementById('hfContractorId').value = id;
        //            parent.document.getElementById('hfContractorName').value = name;
        //            parent.document.getElementById('lblContractor').innerHTML = name;

        //        }
        //        var oWnd = GetRadWindow();
        //        oWnd.close();
        //    }
        function refreshpage() {
           
            window.parent.refreshgrid();
            var oWnd = GetRadWindow();
            oWnd.close();
            window.parent.resizeParentPopupReversBack();
        }

        function adjust_height(tabname) {
            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                //alert(x);
                //alert(y);
                var url = window.location.href;
                if (x == 0)
                    wnd.moveTo(x + 400, 65);
                else {
                    if (window.parent.location.href.indexOf("TypeProfile.aspx") >= 0) {
                        wnd.moveTo(x-20,1);
                    }


                }


                //  wnd.center();
                //alert('window page' + document.body.scrollHeight);
                if (tabname == "Contractor") {
                    // wnd.set_width(document.body.scrollWidth);
                    wnd.set_height(document.body.scrollHeight + 50);

                }
                else if (tabname == "Designer") {
                    //wnd.set_height(document.body.scrollHeight);
                    wnd.set_height(document.body.scrollHeight + 20);

                }
                else if (tabname == "Contractor1") {
                    wnd.set_height(document.body.scrollHeight + 30);
                }
                else {
                    wnd.set_height(document.body.scrollHeight + 30);
                }
                // alert('window page' + document.body.offsetWidth);
                //wnd.set_width(document.body.scrollWidth+200)
            }

        }
        function LogoutNavigation() {

                    var query = parent.location.href;
            top.location.href(query);

        }
      
    </script>
   
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
       
    </style>
    <style type="text/css">
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
    
            .div_outer  
            {
               
                border:1; 
                height:380px; 
                border-style:solid; 
                border-width:1px;  
                border-color: #808080;
            }
            
    </style>
   <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />

     <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
    <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
</head>
<body style="background-color: #EEEEEE;overflow:hidden;padding=0px;">
    <form runat="server" id="mainForm" method="post">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <telerik:RadFormDecorator ID="rdfTaskConflicts" Skin="Default" runat="server" DecoratedControls="Buttons,ScrollBars" />
    <telerik:RadAjaxLoadingPanel runat="server" ID="LoadingPanel1" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <div id="div1" class="">
        <table border="0" width="100%" style="color: #808080;	text-align: left;
	                            font-size :large ;" cellspacing="0">
            <%--<tr style="display:none">
                <td class="wizardHeadImage">
                    <div class="wizardLeftImage">
                        <asp:Label ID="lbl_header" Font-Names="Verdana" Font-Size="11pt" runat="server"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" Width="15px" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClientClick="javascript:return CloseWindow();" />
                    </div>
                </td>
            </tr>--%>
            <tr>
                <td style="background-color: #F7F7F7;height:10px;">
                    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="RadTabStrip1" OnTabClick="rdstripSetupSync_TabClick"
                        runat="server" MultiPageID="RadMultiPage1" SelectedIndex="0" CssClass="normalLabel"
                        Align="Center" ShowBaseLine="True" dir="ltr" BorderWidth="0px" Skin="">
                    </telerik:RadTabStrip>
                </td>
            </tr>
            <tr align="center">
                <td>
                    <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" OnPageViewCreated="RadMultiPage1_PageViewCreated"
                        CssClass="multiPage">
                    </telerik:RadMultiPage>
                </td>
            </tr>
        </table>
       
        <table> <tr><td>
        <telerik:RadButton ID="radbtnAssignMaster" runat="server" OnClientClicking="test"
            Text="Assign" Skin="Default" OnClick="btn_click" OnClientClicked="javascript:refreshpage();">
        </telerik:RadButton>
        <asp:HiddenField ID="hfformatid1" runat="server" />
        <asp:HiddenField ID="hfformatname1" runat="server" />
        </td></tr></table>
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
    </form>
</body>
</html>
