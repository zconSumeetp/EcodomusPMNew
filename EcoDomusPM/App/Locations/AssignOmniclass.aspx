<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignOmniclass.aspx.cs"
    Inherits="App_omniclasslinkup" EnableEventValidation="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <%--<title>Assign OmniClass</title>--%>
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
        <script type="text/javascript" language="javascript">

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
            
                //callRootFunction(window, 'adjsutHeightToReverce');
                var rdw = GetRadWindow();
                
                rdw.close();
                
                window.parent.adjsutHeightToReverce();
                return false;
                //self.close();
            }

            function select_Sub_System(id, name) {

                var rdw = GetRadWindow();
                rdw.BrowserWindow.load_omni_class(name, id);
                rdw.close();
                window.parent.adjsutHeightToReverce();
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
                alert("Please Select Omniclass");
            }
            function adjust_height() {
                debugger;

                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    //alert(x);
                    //alert(y);
                  //  if (x == 0)
                        wnd.moveTo(x + 25, 02);

                        wnd.set_height(document.body.scrollHeight + 30)
                        if (document.getElementById('hf_size').value == "ALL") {
                            wnd.set_height(document.body.scrollHeight+40)
                            wnd.set_width(document.body.scrollWidth - 100);
                            document.getElementById('hf_size').value = "";
                        }
                       
                       // wnd.set_height(450);
                }
                    window.parent.adjustHeight();
            }
            function adjust_width() {
                var wnd = GetRadWindow();
                if (wnd != null) {
                    document.getElementById('hf_size').value = "ALL";
                    wnd.set_height(document.body.scrollHeight + 40)
                    wnd.set_width(document.body.scrollWidth + 150);
                }
            
            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }
            window.onload = adjust_height;
        </script>
       
        
    </telerik:RadCodeBlock>
    <style type="text/css">
        *
        {
            margin: 0;
            padding: 0;
        }
        .style1
        {
            width: 1036px;
        }

    </style>
</head>
<body style="background-color:#EEEEEE; padding: 0px; margin: 0px 0px 0px 0px;">
    <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
        <script language="javascript" type="text/javascript">


            function clear_txt() {
                document.getElementById("txtSearch").value = "";
                return false;
            }
    
        </script>
    </telerik:RadCodeBlock>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <div >
        <table width="100%" border="0">
             <%--<tr>
                <td class="wizardHeadImage">
                    <div class="wizardLeftImage">
                        <asp:Label ID="lbl_header" Text="<%$Resources:Resource, Assign_Category%>" Font-Names="Verdana" Font-Size="11pt" runat="server"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClientClick="javascript:return closeWindow();" OnClick="ibtn_close_Click" />
                    </div>
                </td>
            </tr>--%>
           
            <tr>
                <td>
                    <%--<asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, OmniClass_version%>" CssClass="LabelText"></asp:Label>:--%>
                    <telerik:RadComboBox ID="ddlomniclass" AutoPostBack="true" Filter="Contains" runat="server"
                        AllowCustomText="false" OnSelectedIndexChanged="ddlomniclass_SelectedIndexChanged">
                        <Items>
                            <telerik:RadComboBoxItem Text="OmniClass 2006" Value="N" />
                            <telerik:RadComboBoxItem Text="OmniClass 2010" Value="Y" Selected="true" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="padding-left: 10px;padding-right:10px;">
                        <tr align="center">
                            <td align="right">
                                <asp:Panel ID="panel1" runat="server" DefaultButton="btn_search">
                                    <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                        <tr>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="<%$Resources:Resource, Assign_OmniClass%>" ID="lbl_grid_head"
                                                    CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Font-Names="Arial"
                                                    Font-Size="12"></asp:Label>
                                            </td>
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
                                                                <asp:ImageButton ClientIDMode="Static" OnClick="OnClick_BtnSearch" ID="btn_search"
                                                                    Height="13px" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <td style="padding-right:6px;" class="dropDownImage">
                                                <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                    ID="img_arrow" />--%>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td height="1px" style="background-color: Orange; border-collapse: collapse; width: 70%">
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#EEEEEE;">
                                <fieldset style="border-style: solid; margin: 0px; border-left-color: #DCDCDC; border-top-color: #DCDCDC;
                                    border-top-width: 0px; border-left-width: 1px; border-bottom-width: 1px; border-right-width: 1px;
                                    border-bottom-color: #A0A0A0; border-right-color: #B4B4B4;">
                                    <telerik:RadGrid ID="rg_omniclass" runat="server" AllowPaging="True" AutoGenerateColumns="false"
                                        AllowSorting="True" PagerStyle-AlwaysVisible="true" Width="100%" PageSize="10"
                                        GridLines="None" OnItemDataBound="rg_omniclass_OnItemDataBound" OnSortCommand="btnSearch_OnClick"
                                        OnItemEvent="rg_omniclass_OnItemEvent" OnPageSizeChanged="rg_omniclass_PageSizeChanged"
                                        OnPageIndexChanged="btnSearch_OnClick" OnItemCreated="rg_omniclass_ItemCreated"
                                        Skin="Default" ItemStyle-Wrap="false">
                                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                        <ClientSettings>
                                            <Selecting AllowRowSelect="true" />
                                             <Scrolling AllowScroll="true" ScrollHeight="323" />
                                        </ClientSettings>
                                        <MasterTableView ClientDataKeyNames="CategoryID" DataKeyNames="CategoryID">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="CategoryID" Visible="false">
                                                    <ItemStyle CssClass="column" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridClientSelectColumn>
                                                    <ItemStyle Width="5%" />
                                                    <HeaderStyle Width="5%" />
                                                </telerik:GridClientSelectColumn>
                                                <telerik:GridBoundColumn DataField="Category" SortExpression="Category" HeaderText="<%$Resources:Resource, Category%>">
                                                    <ItemStyle CssClass="column" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                    </fieldset>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height: 10px;">
                </td>
            </tr>
            <tr>
                <td align="left" style="padding-left: 10px;padding-right:20px;">
                    <asp:Button ID="btnassignomniclass" runat="server" Text="<%$Resources:Resource, Assign_OmniClass%>"
                        OnClick="btn_select_click" />
                    <asp:HiddenField ID="hfItems_id" runat="server" />
                    <asp:Button ID="btn_close" runat="server" Width="60px" Text="<%$Resources:Resource, Close%>"
                        OnClientClick="javascript:return closeWindow();" />
                    <asp:HiddenField ID="hfnames" runat="server" />
                    <asp:HiddenField ID="hfdscnt" runat="server" />
                       <asp:HiddenField ID="hf_size" runat="server" />
                         <asp:HiddenField ID="hf_uniclass" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadAjaxManager ID="ramSystem" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnassignomniclass">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_omniclass" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_omniclass" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rg_omniclass">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_omniclass" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
