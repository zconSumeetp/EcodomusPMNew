<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignSystem.aspx.cs" Inherits="App_Asset_AssignSystem" %>
    <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Assign System</title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
  
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">

        <script type="text/javascript" language="javascript">
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            function Load_Body() {
                var masterTable = $find("<%= rg_System.ClientID %>").get_masterTableView();
                masterTable.fireCommand("Rebind", "");
            }            

            function CloseWindow1() {

                // GetRadWindow().BrowserWindow.referesh_project_page();
                GetRadWindow().close();
                //top.location.reload();
                //GetRadWindow().BrowserWindow.adjust_parent_height();
                return false;
            }
            function CancelWindow() {
                CloseWindow1();
            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function closeWindow_assign() {
                var rdw = GetRadWindow();
                rdw.close();
            }

            function bindproviders() {
                var rdw = GetRadWindow();
                rdw.BrowserWindow.rebindgrid();
                rdw.close();
            }

            function closeWindow() {
                           var rdw = GetRadWindow();
                           rdw.BrowserWindow.refreshgrid();
                           rdw.close();
                
                //self.close();
            }

            function select_Sub_System(id, name) {

                var rdw = GetRadWindow();
                rdw.BrowserWindow.load_omni_class(name, id);
                rdw.close();
                //                window.opener.load_omni_class(name, id);
                //                self.close();
            }


            function load_me() {

                if (document.getElementById("hfnames").value == '' || document.getElementById("hfItems_id").value == '') {
                    alert("Select Category");
                    return false;
                }
                else {
                    window.parent.opener.load_omni_class(document.getElementById("hfnames").value, document.getElementById("hfItems_id").value);
                    self.close();
                }
            }

            function assignomniclass() {
                alert("Please Select System");
            }
        </script>

    </telerik:RadCodeBlock>
    <style>
        html
        {
            overflow:hidden;
        }
    </style>
</head>
<body style="padding: 0px; overflow:hidden; margin: 0px 0px 0px 0px; background:white; background-color: #EEEEEE; " onload="Load_Body();" >
 <telerik:RadCodeBlock ID="radcodeblock2" runat="server">

        <script language="javascript" type="text/javascript">


            function clear_txt() {
                document.getElementById("txtSearch").value = "";
                return false;
            }
    
        </script>

    </telerik:RadCodeBlock>
    <form id="form1" runat="server" style="overflow:hidden;" defaultfocus="txtSearch">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" Skin="Default" DecoratedControls="Buttons"/>
    <asp:Panel ID="panelSearch" runat="server"  >
     <div style="width:100%; height:460px;" align="center" >
        <table style="width:100%; table-layout:fixed;">
              
            <tr >
                <td style="padding:10px;" >
                 <table width="100%">
                    <tr>
                    <td>
                    <div style="overflow:hidden;" >
                     <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" BorderWidth="0"
                                ExpandMode="MultipleExpandedItems" BorderColor="Transparent">
                                <ExpandAnimation Type="OutSine" />
                                <Items>
                                    <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                                        BorderWidth="0" BorderColor="Transparent">
                                        <HeaderTemplate>
                                            <asp:Panel ID="pnl_job" runat="server" BorderWidth="0" DefaultButton="btnsearch"
                                                Width="100%" BorderColor="Transparent">
                                                <table id="tbl_jobs" cellpadding="0" cellspacing="0" class="gridRadPnlHeader" runat="server"
                                                    width="100%">
                                                    <tr>
                                                        <td align="right" onclick="stopPropagation(event)">
                                                            <div id="div_search" onclick="stopPropagation(event)" style="background-color: White;
                                                                width: 170px;">
                                                                <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                                    width: 100%;">
                                                                    <tr style="border-spacing: 0px;">
                                                                        <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                                            padding-bottom: 0px;">
                                                                            <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                                Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="90%">
                                                                            </telerik:RadTextBox>
                                                                        </td>
                                                                        <td align="left" rowspan="0px" width="15%" style="background-color: White; height: 14px;
                                                                            padding-bottom: 0px;">
                                                                            <asp:ImageButton ClientIDMode="Static" ID="btnSearch" Height="13px" runat="server"
                                                                                ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnSearch_OnClick" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                        <td align="right" style="padding-right:10px;" class="dropDownImage">
                                                        <%--    <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                                ID="img_arrow" />--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table id="tbl_jobs1" runat="server" cellpadding="0" cellspacing="0" width="100%"
                                                    style="background-color: #707070; border-width: 0px;">
                                                    <tr>
                                                        <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </HeaderTemplate>
                                        <ContentTemplate>
                        <telerik:RadGrid ID="rg_System" runat="server" AllowPaging="True" AutoGenerateColumns="false"
                            AllowSorting="True" PagerStyle-AlwaysVisible="true" PageSize="10"  BorderWidth="1px"
                            GridLines="None"  OnSortCommand="btnSearch_OnClick" ItemStyle-Wrap="false" AllowMultiRowSelection="true"
                            OnPageSizeChanged="btnSearch_OnClick" OnPageIndexChanged="btnSearch_OnClick"
                            OnItemDataBound="rg_system_OnItemDataBound" skin="Default" ItemStyle-Height="12px" >
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                            <ClientSettings>
                                <Selecting AllowRowSelect="true" />
                                <Scrolling AllowScroll="true" ScrollHeight="245px" UseStaticHeaders="true" />
                            </ClientSettings>
                            <MasterTableView ClientDataKeyNames="pk_system_id" DataKeyNames="pk_system_id">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="pk_system_id" Visible="false">
                                       <%-- <ItemStyle CssClass="column" Wrap="false" />--%>
                                    </telerik:GridBoundColumn>
                                     
                                    <telerik:GridClientSelectColumn>
                                        <ItemStyle Width="20px" CssClass="column"  />
                                        <HeaderStyle Width="20px" CssClass="column"  Wrap="false" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,System_Name%>">                                      
                                         <ItemStyle Width="400px"  CssClass="column" Wrap="false" />
                                        <HeaderStyle Width="400px" CssClass="column"  />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        </ContentTemplate>
                                    </telerik:RadPanelItem>
                                </Items>
                            </telerik:RadPanelBar>
                    </div>
                    </td>
                    </tr>
                </table>
                    
                </td>
            </tr>
             <tr>
                <td align="left" style="padding-left:10px;"  class="style1">
                <div >
                    <asp:Button ID="btnassignSystem" runat="server" Text="<%$Resources:Resource,Assign_System%>" OnClick="btn_select_click" />
                   
                    <asp:Button ID="btn_close" runat="server" Text="<%$Resources:Resource,Close%>" OnClientClick="javascript:closeWindow();" />
                    <asp:HiddenField ID="hfnames" runat="server" />
                    <asp:HiddenField ID="hfdscnt" runat="server" />
                     <asp:HiddenField ID="hfItems_id" runat="server" />
                 </div>
                  
                </td>
            </tr>
        </table>
    </div>
    </asp:Panel>

      <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_System" LoadingPanelID="loadingPanel1" />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
   </telerik:RadAjaxManager>
    
       <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px" Skin="Default">
      
    </telerik:RadAjaxLoadingPanel>


    </form>
</body>
</html>
