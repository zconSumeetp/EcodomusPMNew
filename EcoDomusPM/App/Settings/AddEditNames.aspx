<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddEditNames.aspx.cs" Inherits="App_Settings_AddEditNames" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <title>Add Edit Names</title>
    <script language="javascript" type="text/javascript">
        function closeWindow() {

            window.parent.refreshgrid();
            window.close();
            return false;
        }
        function LogoutNavigation() {
            var query = parent.location.href;
            top.location.href(query);
        }

        function refresh_page() {
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
        function adjust_height() {

            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                //alert(x);
                //alert(y);
                wnd.moveTo(x - 40, 120);
                //alert('window page' + document.body.scrollHeight);
                wnd.set_height(document.body.scrollHeight + 35)
                // alert('window page' + document.body.offsetWidth);
                wnd.set_width(document.body.scrollWidth + 25)
            }

        }
        window.onload = adjust_height;

    </script>
    <style type="text/css">
        .style1
        {
            width: 18px;
        }
         html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
</head>
<body style="margin: 0px 0px 0px 0px; padding-top: 0; background: white;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrmg1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div style="padding-left: 0px; width: 100%; background-color: #EEEEEE; border: 2px">
        <table width="100%">
           <tr style="display:none">
                <td class="wizardHeadImage">
                    <div class="wizardLeftImage">
                        <asp:Label ID="Label1" runat="server" Font-Size="10pt" Text="<%$Resources:Resource,Add_Edit_Names%>"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClientClick="javascript:return closeWindow();" OnClick="ibtn_close_Click"
                            Style="height: 16px" />
                    </div>
                </td>
            </tr>
            <tr>
                <td style="height: 20px;">
                </td>
            </tr>
            <tr>
                <td>
                    <div>
                        <h2>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Label ID="l1" runat="server"></asp:Label>
                        </h2>
                    </div>
                    <div style="margin-left: 50px">
                        <table id="tblAddEditName">
                            <tr>
                                <td align="left" class="style1" style="width: 80px">
                                    <asp:Label ID="lblLongName" runat="server" Text="<%$Resources:Resource,Long_Name%>"
                                        Style="font-weight: 700"></asp:Label>:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtLongName" runat="server" Width="223 px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="style1" style="width: 80px">
                                    <asp:Label ID="lblShortName" runat="server" Text="<%$Resources:Resource,Short_Name%>"
                                        Style="font-weight: 700"></asp:Label>:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtShortName" runat="server" Width="223 px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="style1" style="width: 80px">
                                    <asp:Label ID="lblCustomName" runat="server" Text="<%$Resources:Resource,Custom_Name%>"
                                        Style="font-weight: 700"></asp:Label>:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCustomName" runat="server" Width="223 px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="style1">
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style1" style="height: 40px">
                                    <asp:Button runat="server" ID="btnSave" Text="<%$Resources:Resource,Save%>" Width="74px"
                                        OnClick="btnSave_Click" />
                                </td>
                                <td>
                                    <asp:Button runat="server" ID="btnClick" Text="<%$Resources:Resource,Close%>" Width="74px"
                                        OnClientClick="javascript:return closeWindow();" />
                                </td>
                            </tr>
                        </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
