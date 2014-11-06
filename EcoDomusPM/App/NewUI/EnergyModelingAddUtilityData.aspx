<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingAddUtilityData.aspx.cs"
    Inherits="App_NewUI_EnergyModelingAddUtilityData" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <style type="text/css">
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CloseWindow() {

            GetRadWindow().BrowserWindow.referesh_project_page();
            GetRadWindow().close();
            top.location.reload();
            return false;
        }

        function adjust_Add_project_Popup(sender, args) {
            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                 wnd.moveTo(x, 25);
                wnd.set_height(document.body.scrollHeight + 25)
            }
            return true;
        }
       
    </script>
</head>
<body>
    <form id="Form1" runat="server">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
                    <tr>
                        <td class="wizardHeadImage">
                            <div class="wizardLeftImage">
                                <%-- <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />--%>
                                <asp:Label ID="lbl_header" Text="Add Utility Data" runat="server"></asp:Label>
                            </div>
                            <div class="wizardRightImage">
                                <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                    OnClick="ibtn_close_Click" />
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="padding-top: 20px; padding-right: 20px; padding-bottom: 0px; padding-left: 20px">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <asp:Label ID="lbl_type_of_service" runat="server" Text="Type Of Service:" CssClass="normalLabel"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_type_of_service" runat="server" Width="200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbl_meter" runat="server" Text="Meter #:" CssClass="normalLabel"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_meter" runat="server" Width="200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbl_read_date" runat="server" Text="Read Date:" CssClass="normalLabel"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDatePicker TabIndex="7" AutoPostBack="false" ID="rdpstartdate" runat="server"
                                MaxDate="2099-01-01" MinDate="1900-01-01">
                                <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                    ViewSelectorText="x">
                                </Calendar>
                                <DateInput ID="DateInput1" runat="server" TabIndex="7" DisplayDateFormat="M/d/yy"
                                    DateFormat="M/d/yy">
                                </DateInput>
                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="7"></DatePopupButton>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbl_previous" runat="server" Text="Previous:" CssClass="normalLabel"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_previous" runat="server" Width="200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbl_current" runat="server" Text="Current:" CssClass="normalLabel"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_current" runat="server" Width="200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbl_multiplier" runat="server" Text="Multiplier:" CssClass="normalLabel"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_multiplier" runat="server" Width="200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbl_usage" runat="server" Text="Usage:" CssClass="normalLabel"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_usage" runat="server" Width="200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbl_Amount" runat="server" Text="Amount:" CssClass="normalLabel"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_amount" runat="server" Width="200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right" style="padding-right: 25px">
                            <asp:Button ID="btn_save" runat="server" Text="Add" Width="50" OnClick="btn_save_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hf_is_first_time" runat="server" Value="Y" />
    <asp:HiddenField ID="hf_id" runat="server" Value="" />
    </form>
</body>
</html>
