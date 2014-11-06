<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditMasterFormatUniFormat.aspx.cs"
    Inherits="App_Asset_EditMasterFormatUniFormat" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <script type="text/javascript">

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
            window.parent.resizeParentPopupReversBack();
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
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
            window.parent.resizeParentPopupReversBack();

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
            var url = GetRadWindow().BrowserWindow.location.href;
            //GetRadWindow().BrowserWindow.referesh_facility_page();
            GetRadWindow().close();
            window.parent.resizeParentPopupReversBack();
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
                wnd.moveTo(x, 5);
                //alert('window page' + document.body.scrollHeight);
                wnd.set_height(document.body.scrollHeight + 50)
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

    <style type="text/css">
            .RadWindow_Simple
            {
                border: solid 0px #616161;
            }
       .rwWindowContent
       {
            border: solid 0px #616161;
       }
            .RadWindow_Simple .rwCorner .rwTopLeft,  
            .RadWindow_Simple .rwCorner .rwTopRight,  
            .RadWindow_Simple .rwIcon, 
            .RadWindow_Simple table .rwTopLeft,  
            .RadWindow_Simple table .rwTopRight,  
            .RadWindow_Simple table .rwFooterLeft,  
            .RadWindow_Simple table .rwFooterRight,  
            .RadWindow_Simple table .rwFooterCenter,  
            .RadWindow_Simple table .rwBodyLeft,  
            .RadWindow_Simple table .rwBodyRight,  
            .RadWindow_Simple table .rwTopResize, 
            .RadWindow_Simple table .rwStatusbar, 
            .RadWindow_Simple table .rwStatusbar .rwLoading 
             {    
                 display: none !important;   
             }
            .RadWindow_Simple .rwTitlebar,
            .RadWindow_Simple .rwCloseButton
            {
                background-color:#FFA500;
                font-family:Arial;
                font-size:large;
            }
             
            .RadWindow_Simple .rwControlButtons A:hover
             {
                 border-color: #FFA500;
                 background-color:#FFA500;
                 border:1px solid #FFA500;
             }
            .RadWindow_Simple .rwWindowContent
            {
                border:0px;
            }
            .RadWindow_Simple .rwControlButtons A
            {
                 border-color: #FFA500;
                 background-color:#FFA500;
                 border:1px solid #FFA500;
            }
            DIV.RadWindow_Simple .rwShadow EM
            {
                padding:7px 0 0 15px
            }
            
            .RadWindow .rwTitleRow EM
            {
                font:normal 15px "Segoe UI",Arial;
                overflow:hidden;
                white-space:nowrap;
                float:left;
                text-transform:inherit;
            }
        
       
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
            height:100%;
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
         
         .column
         {
             font-size:13px;
             font-family:Arial;
         } 
             
        .searchImage
        {
            background-image: url('/App/Images/Icons/icon_search_sm.png');
            background-repeat: no-repeat;
            background-position: right;
            font-family: "Arial" , sans-serif;
            font-size: 12px;
        }
        .gridHeadText
        {
            font-family: "Verdana" , "Sans-Serif";
            font-style: normal;
            font-size: medium;
            color: White;
        }
        .entityImage
        {
            padding-left: 7px;
        }
        .gridHeaderText
        {
            font-family: "Arial" , sans-serif;
            font-size: 16px;
            height: 20px;
            font-weight: bold;
            background-color: #AFAFAF;
        }
        
        .gridRadPnlHeader
        {
            background-color: Gray;
            height: 30px;
            width: 100%;
            vertical-align: middle;
        }
        .captiondock
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
            color: #990000;
            text-align: left;
            vertical-align: middle;
            margin-top: 10px;
            margin-bottom: 10px;
            font-weight: normal;
        }
        
        .gridRadPnlHeaderBottom
        {
            background-color: Orange;
            height: 1px;
            width: 100%;
        }
        .dropDownImage
        {
            right: 15px;
        }
        
        .searchTextBox
        {
            position: relative;
            right: 10px;
        }
        
        .wizardHeadImage
        {
            background-color: #FFA500;
            height: 30px;
            background-attachment: scroll;
            width: 100%;
            background-attachment: fixed;
            background-position: right;
            background-repeat: no-repeat;
            position: relative;
        }
        .wizardLeftImage
        {
            float: left;
            padding-left: 15px;
            vertical-align: middle;
            height: 20;
            right: 5px;
        }
        .wizardRightImage
        {
            float: right;
            padding-right: 10px;
            vertical-align: middle;
            height: 20;
        }
        
        .normalLabelBold
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            font-weight: bold;
        }
        .headerBoldLabel
        {
            font-family: "Arial" , sans-serif;
            font-size: 16px;
            font-weight: bold;
        }
        
        .lblHeading
        {
            font-family: "Arial";
            font-size: 10px;
        }
        
        .tdValign
        {
            vertical-align: top;
            margin: 0;
        }
        .lnkButton
        {
            font-family: "Arial";
            font-size: 10px;
            color: Black;
            text-decoration: none;
        }
        
        .lnkButtonImg
        {
            height: 14px;
            vertical-align: bottom;
        }
        
        
        .lblBold
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            height: 20px;
            vertical-align: middle;
            font-weight: bold;
        }
        
        .gridHeaderBoldText
        {
            font-family: "Arial" , sans-serif;
            font-size: 14px;
            vertical-align: bottom;
            font-weight: bold;
        }
        
        
        .textAreaScrollBar
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            overflow: auto;
            padding-left: 10px;
            padding-top: 10px;
            border-left-color: #D4D4C3;
            border-top-color: #D4D4C3;
            border-bottom-color: #E8E8E8;
            border-right-color: #E8E8E8;
            height: 170px;
        }
      
            
    </style>
</head>
<body style="background-color: #EEEEEE; overflow: hidden;">
    <form runat="server" id="mainForm" method="post">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <telerik:RadAjaxLoadingPanel runat="server" ID="LoadingPanel1"  Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    
    <div style="width: 100%; border: 0px; border-color: Red; background-color: #EEEEEE;">
        <table border="0" width="100%" cellspacing="0">
            <%--<tr>
                <td class="wizardHeadImage">
                    <div class="wizardLeftImage">
                          <asp:Label ID="lbl_header" Text="" Font-Names="Verdana" Font-Size="11pt" runat="server"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClientClick=" javascript:return CloseWindow();" OnClick="ibtn_close_Click"
                            Style="height: 16px" />
                    </div>
                </td>
            </tr>--%>
            <tr>
                <td style="background-color: #F7F7F7;">
                    <telerik:RadTabStrip runat="server" ID="RadTabStrip1" SelectedIndex="0" MultiPageID="RadMultiPage1"
                        Align="Justify" ShowBaseLine="True" Skin="" dir="ltr" CssClass="normalLabel"
                        Height="30px" OnTabClick="rdstripSetupSync_TabClick" BorderWidth="0px">
                    </telerik:RadTabStrip>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" OnPageViewCreated="RadMultiPage1_PageViewCreated">
                    </telerik:RadMultiPage>
                </td>
            </tr>
        </table>
        <div runat="server" id="div_assign" style="margin-left: 0px; padding-left: 65px;">
            <br />
           
                <telerik:RadButton ID="radbtnAssignMaster" runat="server" OnClientClicking="test"
                    Text="<%$Resources:Resource,Assign_MasterFormat%>" OnClick="btn_click">
                </telerik:RadButton>
                <telerik:RadButton ID="radbtnAssignUniformt" runat="server" OnClientClicking="test"
                    Text="<%$Resources:Resource,Assign_UniFormat%>" OnClick="btn_click_uniFormat">
                </telerik:RadButton>
                <br />
            <asp:HiddenField ID="hfformatid1" runat="server" />
            <asp:HiddenField ID="hfformatname1" runat="server" />
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
        </div>
    </div>
    
    </form>
</body>
</html>
