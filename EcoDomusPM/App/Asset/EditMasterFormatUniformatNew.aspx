<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditMasterFormatUniformatNew.aspx.cs"
    Inherits="App_Asset_EditMasterFormatUniformatNew" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head id="Head1" runat="server">
    <script type="text/javascript" language="javascript">
        function select_uniclass(id,name) {
            if (id == "") {
                alert('Please select UniClass');
                return false;
            } 
            
        }

        function select_Sub_System1(id, name) {
            var rdw = GetRadWindow();
            if (window.parent.location.href.indexOf('TypeProfile') > 0) {
                window.parent.refreshuniclasslable(name);
                rdw.close();
            }
            else {
                //window.parent.refreshgrid("");
                window.parent.refreshtypepm();
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
          
            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                //alert(x);
                //alert(y);
                if (x == 0) {
                    //                    wnd.center();
                    //                    wnd.top = 85;
                    wnd.moveTo(x + 400, 65);
                }
                else {
                    wnd.moveTo(290, 10);
                }
//                    wnd.moveTo(x+220, 85);
              
              //  wnd.center();
                //alert('window page' + document.body.scrollHeight);
                if (tabname == "MasterFormat") {
                    // wnd.set_width(document.body.scrollWidth);
                    wnd.set_height(380);
                    previous = tabname;
                }
                else if (tabname == "UniFormat") {
                    //wnd.set_height(document.body.scrollHeight);
                    wnd.set_height(250);
                    previous = tabname;
                }
                else if (tabname == "OmniClass") {
                    if (previous == "MasterFormat")
                    {
                        wnd.set_height(document.body.scrollHeight + 200);
                        previous = "OmniClass";
                    }
                    //wnd.set_height(533);
                    else if (previous == "UniFormat")
                    {
                    // wnd.set_height(533);
                        wnd.set_height(document.body.scrollHeight + 330);
                          previous="OmniClass";
                      }
                      if (previous == "UniClass") {
                          wnd.set_height(document.body.scrollHeight+30);
                          previous = "OmniClass";
                      }
                }
                else if (tabname == "UniClass") {
                if (previous == "MasterFormat") {
                    wnd.set_height(560);
                    previous = "UniClass";
                }
                else if (previous == "UniFormat") {
                    wnd.set_height(560);
                    previous = "UniClass";
                }
                else if (previous == "OmniClass") {
                    wnd.set_height(560);
                    previous = "UniClass";
                }
                else {
                    wnd.set_height(560);
                }
                }
                else {
                    if (window.parent.location.href.indexOf("TypeProfile.aspx") >= 0) {
                       //wnd.moveTo(x - 200, 10);
                        wnd.set_height(480);
                    }
                    else {
                        wnd.set_height(document.body.scrollHeight + 30);
                    }
                }
                // alert('window page' + document.body.offsetWidth);
                //wnd.set_width(document.body.scrollWidth+200)
            }
            
        }


        function selectuniformat(id, name) {

            if (window.parent.location.href.indexOf('TypePM') == -1) {
                parent.document.getElementById('hfuniformat_id').value = id;
                parent.document.getElementById('hfuniformatname').value = name;
                parent.document.getElementById('lblUniFormat').innerHTML = name;

            }
           // window.parent.refreshgrid();
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
            GetRadWindow().close();
            window.parent.resizeParentPopupReversBack();
            return false;
        }
      
//        function removeCssClass() {
//            debugger;
//            $('li-rtsLI').removeProp('width');
//        }
        function OnClinetTab_selected(sender, args) {
            //       adjust_height();
            
            var tabname = args.get_tab().get_text();
            if (tabname == "MasterFormat") {
               
                adjust_height(tabname);
                //      $('li').css('width', '150px');
                $('li').removeProp('width');
                         
            }
            else if (tabname == "UniFormat") {
          
                adjust_height(tabname);
            
            }
            else {
                adjust_height(tabname);
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
         window.onload = adjust_height; 
    </script>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <script src="../../App_Themes/EcoDomus/jquery-1.8.3.js" type="text/javascript"></script>
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
        .div_outer  
            {
               
                border:1; 
                height:320;
                border-style:solid; 
                border-width:1px;  
                border-color: #808080;
                
            }
    </style>
    <%-- <style type="text/css"> 
    div.RadTabStrip .rtsLI 
    { 
        margin-right: 0px; 
      
    } 
</style> --%>

</head>
<body style="background-color: #EEEEEE;overflow:hidden;padding:0px;margin:0px;">
    <form runat="server" id="mainForm" method="post">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" DecoratedControls="Buttons,ScrollBars" />
    <telerik:RadAjaxLoadingPanel runat="server" ID="LoadingPanel1" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <div class="" style="width: 100%;">
        <table border="0" width="100%" cellspacing="0" style="padding-left: 10px;
                        padding-right: 10px;" >
            <%--<tr>
                <td class="wizardHeadImage" style="width:100%">
                    <div class="wizardLeftImage">
                        <asp:Label ID="lbl_header" Text="Assign Classification" Font-Names="Verdana" Font-Size="11pt"  runat="server"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClientClick="javascript:return CloseWindow();" OnClick="ibtn_close_Click" />
                    </div>
                </td>
            </tr>--%>
            <tr>
                <td style="background-color: #F7F7F7;">
                    <telerik:RadTabStrip runat="server" ID="RadTabStrip1" SelectedIndex="0" MultiPageID="RadMultiPage1"
                        Align="Center" ShowBaseLine="True" Skin="" dir="ltr" CssClass="normalLabel" Height="10px"  Width="100%"
                        OnTabClick="rdstripSetupSync_TabClick" BorderWidth="0px" OnClientTabSelected="OnClinetTab_selected">
                    </telerik:RadTabStrip>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" OnPageViewCreated="RadMultiPage1_PageViewCreated" >
                    </telerik:RadMultiPage>
                </td>
            </tr>
        </table>
        <div runat="server" id="div_assign" style="margin-left: 0px; padding-left:65px;">
            <telerik:RadButton ID="radbtnAssignMaster" runat="server" OnClientClicking="test"
                Text="<%$Resources:Resource,Assign_MasterFormat%>" OnClick="btn_click">
            </telerik:RadButton>
             
            <telerik:RadButton ID="radbtnAssignUniformt" runat="server" OnClientClicking="test"
                Text="<%$Resources:Resource,Assign_UniFormat%>" OnClick="btn_click_uniFormat">
            </telerik:RadButton>
            <asp:HiddenField ID="hfformatid1" runat="server" />
            <asp:HiddenField ID="hfformatname1" runat="server" />
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
