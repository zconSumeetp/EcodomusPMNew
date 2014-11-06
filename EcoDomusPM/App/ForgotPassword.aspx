<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="App_ForgotPassword" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EcoDomus: Forgot Password</title>
    <link rel="stylesheet" href="../App_Themes/EcoDomus/style_new_1.css" type="text/css" />
    <script type="text/javascript">
        function RedirectUser() {
            alert("Your password has been sent to your Email Id....");
            document.getElementById('btnpostback').click();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="divLogin" style="width: 341px">
        <table>
            <tr>
                <td colspan="2">
                    <div style="float: left;">
                        <asp:Image ID="imgEcoDomusLogo" runat="server" ImageUrl="../App/Images/EcoDomusLogo.gif"
                            AlternateText="EcoDomus Logo" Width="70px" Height="70px" />
                    </div>
                    <div style="padding-left: 15px; float: left; padding-top: 5px;">
                        <h1 style="font-family: Arial, Helvetica, sans-serif; font-size: xx-large; font-weight: bold;
                            color: #37B34A; padding-left: 10px;">
                            EcoDomus PM</h1>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="font-weight: normal; font-size: 12px;">
                    <asp:Label ID="msg1" runat="server" Text="<%$Resources:Resource, Forgot_password_message_1%>"></asp:Label>.
                    <br />
                    <asp:Label ID="msg2" runat="server" Text="<%$Resources:Resource, Forgot_password_message_2%>"></asp:Label>.
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Text="<%$Resources:Resource, Username%>">
                                </asp:Label>:
                            </td>
                            <td>
                                <asp:TextBox CssClass="SmallTextBox" ID="UserName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                    ForeColor="Red" ToolTip="User Name is required." ValidationGroup="lgnUserSubmit">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="EmailLable" runat="server" Text="<%$Resources:Resource, Email%>">
                                </asp:Label>:
                            </td>
                            <td>
                                <asp:TextBox CssClass="SmallTextBox" ID="UserEmail" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="UserEmail"
                                    ForeColor="Red" ValidationGroup="lgnUserSubmit">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="regEmail" runat="server" ControlToValidate="UserEmail"
                                    Display="Dynamic" ValidationGroup="lgnUserSubmit" ErrorMessage="*" ForeColor="Red"
                                    SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                </asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnSubmit" runat="server" Text="<%$Resources:Resource, Submit%>"
                                    ValidationGroup="lgnUserSubmit" Width="70" OnClick="btnSubmit_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="<%$Resources:Resource, Cancel%>"
                                    Width="70" OnClick="btnCancel_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblFailureText" ForeColor="Red" Width="400px" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div style="display: none;">
            <asp:Button ID="btnpostback" runat="server" OnClick="postback_Click" /></div>
    </div>
    </form>
</body>
</html>
