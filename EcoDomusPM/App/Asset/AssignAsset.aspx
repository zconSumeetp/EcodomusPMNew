<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignAsset.aspx.cs" Inherits="App_Asset_AssignAsset" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
   <%-- <title></title>--%>
    <telerik:RadCodeBlock runat="server">
        <script type="text/javascript" language="javascript">

//            window.onload = setFocus;
        </script>
        <script type="text/javascript">

            function closeWindow() {
                window.parent.refreshgrid_asset();
                var rdw = GetRadWindow();
                rdw.close();
                return false;
            }
            function closeWindow12() {
                var rdw = GetRadWindow();
                rdw.close();
                window.parent.refreshgrid_asset();
              return false;     
             }
         

//            function Clear() {

//              
//                return false;

//            }

            function facilitystatus() {

                document.getElementById("<%=hdnfacility.ClientID %>").value = parent.top.document.getElementById("ContentPlaceHolder1_hdnfacility").value;
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

            function select_Sub_System(id, name, type_name) {

                parent.window.load_comp(name, id, type_name);
                var Radwindow = GetRadWindow();
                Radwindow.close();
            }

            function load_me() {
                if (document.getElementById("hfnames").value == '' || document.getElementById("hfItems_id").value == '') {
                    alert("Select Category");
                    return false;
                }
                else {
                    window.parent.opener.load_comp(document.getElementById("hfnames").value, document.getElementById("hfItems_id").value, document.getElementById("hfItems_id").value);
                    self.close();
                }
            }

            function assignAsset() {
                alert("Please Select Component");

            }
            function gotoPage(id, pagename) {
                var url;

                if (pagename == "Asset") {
                    url = "AssetMenu.aspx?assetid=" + id; //+ //"&pagevalue=AssetProfile";
                }
                else if (pagename == "Type") {
                    url = "TypeProfileMenu.aspx?type_id=" + id;
                    //alert("Page Under Construction");
                    //return false;
                }
                else if (pagename == "Space") {
                    url = "../Locations/FacilityMenu.aspx?pagevalue=Space Profile&id=" + id;
                }

                top.location.href(url);
            }

            function stopPropagation(e) {
                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }
            function adjust_height() {

                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    //alert(x);
                    //alert(y);
                    //wnd.moveTo(x+50, 10);
                    wnd.moveTo(250, 10);
                    //alert('window page' + document.body.scrollHeight);
                    wnd.set_height(document.body.scrollHeight + 40)
                    // alert('window page' + document.body.offsetWidth);
                    //wnd.set_width(document.body.scrollWidth+200)
                }
               

            }
           //window.onload = adjust_height;
        </script>
        <style type="text/css">
         html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        </style>
    </telerik:RadCodeBlock>
</head>
<body style="background-color: #EEEEEE; padding: 0px; margin: 0px 0px 0px 0px;">
    <form id="form1" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="issueProfilesManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_asset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="rg_asset">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_asset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <telerik:RadFormDecorator ID="RadFormDecorator1" DecoratedControls="Buttons,Scrollbars" Skin="Default"
            runat="server" />
        
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
             
                <tr>
                    <td align="left">
                        <table border="0" width="100%" style="padding: 10px; " cellpadding="0" cellspacing="0">
                            <tr align="center">
                                <td align="right">
                                    <asp:Panel ID="panel1" runat="server" DefaultButton="btnSearch">
                                        <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                            <tr>
                                               <%-- <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                    <asp:Label runat="server" Text="<%$Resources:Resource, Assign_Component%>" ID="lbl_grid_head"
                                                        CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Font-Names="Arial"
                                                        Font-Size="12"></asp:Label>
                                                </td>--%>
                                                <td align="right">
                                                    <div id="div_search" style="background-color: White; width: 170px;">
                                                        <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                            width: 100%;">
                                                            <tr style="border-spacing=0px;">
                                                                <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                                    padding-bottom: 0px;">
                                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txt_search" Width="100%">
                                                                    </telerik:RadTextBox>
                                                                </td>
                                                                <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                                    padding-bottom: 0px;">
                                                                    <asp:ImageButton ClientIDMode="Static" OnClick="btnSearch_Click" ID="btnSearch" Height="13px"
                                                                        runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                                <td  style="padding-right:03px;">
                                                    <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                        ID="img_arrow" />--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td height="1px" style="background-color: Orange; border-collapse: collapse; width: 100%">
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <telerik:RadGrid ID="rg_asset" runat="server" AllowMultiRowSelection="true" AllowPaging="True"
                                        AllowCustomPaging="true" AutoGenerateColumns="false" Skin="Default" AllowSorting="True"
                                        GridLines="None" OnSortCommand="rg_component_SortCommand" PagerStyle-AlwaysVisible="true"
                                        OnPageSizeChanged="rg_component_PageSizeChanged" OnPageIndexChanged="rg_component_PageIndexChanged"
                                       >
                                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                        <ClientSettings>
                                            <Selecting AllowRowSelect="true" />
                                            <Scrolling AllowScroll="true" ScrollHeight="280" UseStaticHeaders="true"/>
                                        </ClientSettings>
                                        <MasterTableView ClientDataKeyNames="pk_asset_id" DataKeyNames="pk_asset_id">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="pk_asset_id" Visible="false">
                                                    <ItemStyle CssClass="column" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridClientSelectColumn HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle  Width="4%"  />
                                                    <HeaderStyle Width="4%"   />
                                                </telerik:GridClientSelectColumn>
                                                <telerik:GridBoundColumn DataField="AssetName" HeaderText="<%$Resources:Resource,Component_Name%>">
                                                    <ItemStyle HorizontalAlign="Left"  />
                                                    <HeaderStyle Width="30%" />
                                                    <ItemStyle Width="30%" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="space" HeaderText="<%$Resources:Resource,Space%>">
                                                    <ItemStyle HorizontalAlign="Left" Width="20%" />
                                                    <HeaderStyle Width="20%" />
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="height: 5px;">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="btnSelect" Visible="true" runat="server" Text="<%$Resources:Resource,Assign%>"
                                        Width="110px" OnClick="btnSelect_Click"  />
                                    <asp:Button ID="btnClose" Visible="true" runat="server" Text="<%$Resources:Resource,Close%>"
                                        Width="110px" OnClientClick="javascript:return closeWindow();" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        <asp:HiddenField ID="hdnfacility" runat="server" />
    </div>
    <telerik:RadAjaxManager ID="my_pa" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_component" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="hdnfacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_component" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rg_component">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_component" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_component" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Forest" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
    <asp:HiddenField runat="server" ID="hfentityname" />
    <asp:HiddenField runat="server" ID="hfid" />
    <asp:HiddenField ID="HiddenField1" runat="server" />
    </form>
</body>
</html>
