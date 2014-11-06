<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditDesignerContractor.aspx.cs" Inherits="App_Asset_EditDesignerContractor" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">   
<script language="javascript" type="text/javascript">
    function onTabSelecting(sender, args) {
        if (args.get_tab().get_pageViewID()) {
            args.get_tab().set_postBack(false);
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
    }
</script>     
</head>
<body>
    <form runat="server" id="mainForm" method="post">
     <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />        
     <telerik:RadAjaxLoadingPanel runat="server" ID="LoadingPanel1">
     </telerik:RadAjaxLoadingPanel>
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

        <script type="text/javascript">

          
        </script>

        <div class="spreadSheet">
         <div class="bottomSheetFrame">             
             <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="RadTabStrip1" SelectedIndex="0" CssClass="tabStrip" OnTabClick="rdstripSetupSync_TabClick"
                 runat="server" MultiPageID="RadMultiPage1" Skin="Default"  Orientation="HorizontalTop">
             </telerik:RadTabStrip>            
             <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" OnPageViewCreated="RadMultiPage1_PageViewCreated" CssClass="multiPage">
             </telerik:RadMultiPage>
            </div>
        </div> 

        <telerik:RadButton ID="radbtnAssignMaster" runat="server"  OnClientClicking="test"  Text="Assign" Skin="Hay" OnClick="btn_click" OnClientClicked="javascript:refreshpage();" ></telerik:RadButton>

        <asp:HiddenField ID="hfformatid1" runat="server"/>
        <asp:HiddenField ID="hfformatname1" runat="server" />      
        
    </form>
</body>
</html>
