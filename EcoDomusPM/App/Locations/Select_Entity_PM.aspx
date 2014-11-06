<%@ Page Language="C#" CodeFile="Select_Entity_PM.aspx.cs" Inherits="Select_Entity_PM" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--<title>Assign Entity</title>--%>
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
  
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
        <script language="javascript" type="text/javascript">

            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
                                  }

            function Clear() {
                try {
                    document.getElementById("txtcriteria").value = "";
                    return false;
                }
                catch (e) {
                    //alert(e.message + "  " + e.Number);
                    return false;
                }
            }

            function closeWindow(sender, args) {
                window.close();
                window.parent.resiseParentPopwindow('collaps');
                return false;
            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog      
                else if (window.frameElement != null) {
                    if (window.frameElement.radWindow)
                        oWindow = window.frameElement.radWindow; //IE (and Moz as well)      
                }
                return oWindow;
            }

            function CloseWindowTop() {
                GetRadWindow().close();
                window.parent.resiseParentPopwindow('collaps');
                return false;
            }

            function assignfacility() {
                alert("Please Select Entity.");
            }

            function selectfacilityForType(id, name, row_ids) {            
                var rdw = GetRadWindow();
                //rdw.BrowserWindow.load_facilityname(name, id);
                //parent.top.load_facilityname(name,id,row_ids);   //initially
                parent.load_facilityname(name, id, row_ids);
                window.parent
                rdw.close();
                window.close();
                window.parent.resiseParentPopwindow('collaps');

            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function Select_entity() {


            }
            function setTitle(title){
               var wind = GetRadWindow();
               wind._titleElement.innerHTML = title ;
            }
            

        </script>
    </telerik:RadCodeBlock>
    <style>
    html 
    {
        overflow: hidden;
    }
    </style>
</head>
<body style="background: #EEEEEE; overflow:hidden; margin: 0;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="RadFormDecorator" runat="server" DecoratedControls="Buttons, Scrollbars" />
    <div style="overflow:hidden; height:420px;" width="100%">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <%--<tr>
            <td>
                <table style="background-color: #EEEEEE; width:100%; border-collapse: collapse;
                                       padding:0;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <table width="99%" cellpadding="0" cellspacing="0" style="margin:2px 0px 2px 2px;">
                                <tr>
                                    <td class="wizardHeadImage">
                                        <div class="wizardLeftImage">
                                            <asp:Label ID="Label1" runat="server" Font-Size="11pt" Text="<%$Resources:Resource,Select%>"
                                                Font-Names="Verdana"></asp:Label>&nbsp;
                                            <asp:Label ID="lblType" runat="server" Visible="false" Text="<%$Resources:Resource,Type%>"
                                               Font-Size="11pt"  Font-Names="Verdana"></asp:Label>
                                            <asp:Label ID="lblComponent" runat="server" Visible="false" Font-Size="11pt" Text="<%$Resources:Resource,Component%>"
                                                Font-Names="Verdana"></asp:Label>
                                            <asp:Label ID="lblSystem" runat="server" Visible="false" Font-Size="11pt" Text="<%$Resources:Resource,System%>"
                                                Font-Names="Verdana"></asp:Label>
                                            <asp:Label ID="lblFacility" runat="server" Visible="false" Font-Size="11pt" Text="<%$Resources:Resource,Facility%>"
                                                Font-Names="Verdana"></asp:Label>
                                            <asp:Label ID="lblFloor" runat="server" Visible="false" Font-Size="11pt" Text="<%$Resources:Resource,Floor%>"
                                                Font-Names="Verdana"></asp:Label>
                                            <asp:Label ID="lblSpace" runat="server" Visible="false" Font-Size="11pt" Text="<%$Resources:Resource,Space%>"
                                                Font-Names="Verdana"></asp:Label>
                                        </div>
                                        <div class="wizardRightImage">
                                            <asp:ImageButton ID="ibtn_close" runat="server" OnClientClick="javascript:return CloseWindowTop();"
                                                ImageUrl="~/App/Images/Icons/icon-close.png" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>--%>
        <tr>
        <td  align="center" style="padding:10px;padding-right:10px;">
           <%-- <td style="padding-left: 25px; padding-right: 25px; padding-top: 10px;">--%>
                <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" ExpandMode="MultipleExpandedItems"
                    BorderWidth="0" BorderColor="Transparent">
                    <ExpandAnimation  />
                    <Items>
                        <telerik:RadPanelItem Expanded="true" IsSeparator="false" BorderWidth="0" BorderColor="Transparent">
                            <HeaderTemplate>
                                <asp:Panel ID="pnlDocuments" runat="server" DefaultButton="btnsearch" BorderWidth="0"
                                    BorderColor="Transparent">
                                    <table cellpadding="0px" cellspacing="0px" onclick="stopPropagation(event)" class="gridRadPnlHeader" border="0">
                                        <tr>
                                            <td align="left" class="entityImage" >
                                                <asp:Label runat="server" Text="Select Entity" ID="lbl_grid_head" CssClass="gridHeadText"
                                                    ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                            </td>
                                            <td align="left" class="entityImage" >
                                            </td>
                                            <td align="right">
                                                <div id="div_search"  onclick="stopPropagation(event)" style="background-color: White;
                                                    width: 170px;">
                                                    <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                                        width: 100%;"       
                                                        <tr style="border-spacing=0px;">
                                                            <td align="left" width="70%" rowspan="0px" style="background-color: White; padding-bottom: 0px;">
                                                                <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                    EmptyMessage="Search" BorderColor="White" ID="txtcriteria" Width="100%">
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                                padding-bottom: 0px;">
                                                                <asp:ImageButton ClientIDMode="Static" OnClick="btnsearch_Click" ID="btnsearch" Height="13px"
                                                                    runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <td style="padding-right:10px" >
                                               <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                    ID="img_arrow" />--%>
                                            </td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #707070;
                                        border-width: 0px;">
                                        <tr>
                                            <td class="gridRadPnlHeaderBottom"  style="height: 1px">
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </HeaderTemplate>
                            <ContentTemplate>
                                <telerik:RadGrid runat="server" ID="rgentity" AllowPaging="true" PageSize="10" AllowSorting="True"
                                    AutoGenerateColumns="false" OnPageSizeChanged="rgentity_OnPageSizeChanged" PagerStyle-AlwaysVisible="true"
                                    EnableViewState="true" OnSortCommand="rgentity_OnSortCommand" OnPageIndexChanged="rgentity_OnPageIndexChanged"
                                    OnItemDataBound="rgentity_OnItemDataBound" Width="100%" ItemStyle-Wrap="false"
                                    AllowMultiRowSelection="true" HeaderStyle-CssClass="gridHeaderTextMedium">
                                    <PagerStyle Mode="NextPrevAndNumeric" PageButtonCount="5" Width="100%" AlwaysVisible="true" />
                                    
                                    <%--  <MasterTableView DataKeyNames="fk_row_id, Rowname">--%>
                                    <MasterTableView DataKeyNames="id,asset_name" ClientDataKeyNames="id,asset_name">
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="id" HeaderText="id" UniqueName="id" Visible="false"
                                                SortExpression="id">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridClientSelectColumn ItemStyle-Width="1%">
                                                <HeaderStyle Width="1%" ForeColor="GrayText" />
                                            </telerik:GridClientSelectColumn>
                                            <telerik:GridBoundColumn DataField="asset_name" HeaderText="Name" UniqueName="asset_name" SortExpression="asset_name">
                                                <HeaderStyle Wrap="false" Width="90%" ForeColor="GrayText" />
                                                <ItemStyle Wrap="false" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                    <ClientSettings>
                                        <Selecting AllowRowSelect="true" />
                                        <Scrolling AllowScroll="true" ScrollHeight="340"    />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadPanelItem>
                    </Items>
                </telerik:RadPanelBar>
            </td>
        </tr>
        <tr>
            <td style="padding: 2px 0px 0px 10px;">

                <asp:Button ID="btnAssign" runat="server" Text="<%$Resources:Resource,Assign%>"
                    Width="100px" OnClick="btnAssign_Click" OnClientClick="javascript:return Select_entity();"  />

                    

                <telerik:RadButton ID="btnDocCancle" runat="server" Text="<%$Resources:Resource,Close%>"
                           Width="100px" OnClientClicked="closeWindow" />
            </td>
        </tr>
    </table>
    </div>
    <asp:HiddenField ID="hf_row_ids" runat="server" />
    <asp:HiddenField ID="hf_Entity_ids" runat="server" />
    <asp:HiddenField ID="hf_Entity_Names" runat="server" />

    <asp:HiddenField ID="hf_facility_id" runat="server" />


    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnsearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgentity" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgentity">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgentity" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Skin="Default" Width="75px">
        <%--<img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />--%>
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
