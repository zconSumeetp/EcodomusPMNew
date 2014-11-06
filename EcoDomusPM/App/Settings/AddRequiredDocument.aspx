<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddRequiredDocument.aspx.cs"
    Inherits="App_Settings_AddRequiredDocument" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Required Documents</title>
    <script type="text/javascript" language="javascript">
        function CloseWindow() {
            window.parent.refreshgrid();
            window.close();
            return false;
        }

        function refreshParentGrid() {
            window.parent.refreshgrid();
            return false;
        }

        function ShowConfirm() {
            var ans = confirm("Are you sure you want to delete this document?");
            if (ans) {
                __doPostBack('imgbtnDelete', '')
            }
            else
                return false;
        }

        function refresh_page() {
            return false;
        }

        function validate() {
            alert("Document already exists.\n Please select another document.");
            return false;
        }
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        function LogoutNavigation() {
            var query = parent.location.href;
            top.location.href(query);
        }

    </script>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <style type="text/css">
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
</head>
<link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
<body style="margin: 0px 0px 0px 0px; padding-top: 0; background: #EEEEEE;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrpt_manager" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="formdecorator1" runat="server" DecoratedControls="Buttons,Scrollbars"
        Skin="Default"></telerik:RadFormDecorator>
    <div style="padding-left: 0px; width: 100%; background-color: #EEEEEE; border: 2px">
        <table width="100%">
            <tr style="display:none">
                <td class="wizardHeadImage">
                    <div class="wizardLeftImage">
                        <asp:Label ID="Label1" runat="server" Font-Size="10pt" Text="<%$Resources:Resource,Add_Required_Documents%>"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClientClick=" javascript:return CloseWindow();" OnClick="ibtn_close_Click"
                            Style="height: 16px" />
                    </div>
                </td>
            </tr>
            <tr>
                <td style="height: 20px;">
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lbl_type" runat="server" Text="<%$Resources:Resource,Type%>" CssClass="Label">:</asp:Label>:
                    <telerik:RadComboBox ID="cmb_type" runat="server" Height="90" Width="180" AutoPostBack="true" >
                    </telerik:RadComboBox>
                    <asp:RequiredFieldValidator ID="reqCategory" ControlToValidate="cmb_type" SetFocusOnError="true"
                        runat="server" ErrorMessage="*" ValidationGroup="ClassValidationGroup"
                        InitialValue="--Select--" Display="Dynamic" ForeColor="Red">
                    </asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <table>
                        <tr>
                            <td style="height: 10px;">
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 0px;">
                                <asp:Button ID="btnAddedit" Text="<%$Resources:Resource,Save%>" runat="server" OnClick="btnAddedit_Click"
                                    Width="60" ValidationGroup="ClassValidationGroup" />
                            </td>
                            <td style="padding-left: 10px;">
                                <asp:Button ID="btnClose" OnClientClick="javascript: return CloseWindow();" Text="<%$Resources:Resource,Close%>"
                                    Width="60" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <table style="margin: 10px 50px 5px 50px;">
                        <tr>
                            <td style="height: 20px">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="LabelText"></asp:Label>
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
