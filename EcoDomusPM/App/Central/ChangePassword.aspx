<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="App_Central_ChangePassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Change Password</title>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <style type="text/css">
        .style1
        {
            font-family: serif;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table id="tblmaster" class="tableHeader" border="0" width="100%" cellpadding="0"
        cellspacing="0" style="margin: 0 0 0 0;">
        <tr style="margin-left: 700px;">
            <td align="left" valign="top" style="width: 25%; height: 20px">
                <img alt="EcoDomus logo" src="../../App/Images/EcoDomus_logo.jpg" style="height: 25px;
                    width: 100px" />
            </td>
            <td align="right" style="padding-right: 10px;">
                <asp:LinkButton ID="lnkbtnLogout" runat="server" Text="<%$Resources:Resource,Logout%>"
                    CausesValidation="false" OnClick="lnkbtnLogOut_Click"></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="padding: 25px 0 0 25px;">
                <table style="width: 100%">
                    <tr>
                        <td colspan="2" style="font-size: 13px; font-weight: bold; padding-bottom: 12px;">
                            <asp:Label ID="lblChangePassword" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 11px; width: 8%; padding-bottom: 8px;" valign="top">
                            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Current_Password%>"></asp:Label>
                        </td>
                        <td style="padding-bottom: 8px;">
                            <asp:TextBox ID="txtOldPassword" TextMode="Password" runat="server" Width="20%" Height="20px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqOldPassword" runat="server" ErrorMessage="*" ForeColor="Red"
                                ControlToValidate="txtOldPassword"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 11px; padding-bottom: 8px;" valign="top">
                            <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, New_Password%>"></asp:Label>
                        </td>
                        <td style="padding-bottom: 8px;">
                            <asp:TextBox ID="txtNewPassword" TextMode="Password" runat="server" Width="20%" Height="20px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqNewPassword" runat="server" ErrorMessage="*" ForeColor="Red"
                                ControlToValidate="txtNewPassword"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 11px; padding-bottom: 8px;" valign="top">
                            <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, Confirm_Password%>"></asp:Label>
                        </td>
                        <td style="padding-bottom: 8px;">
                            <asp:TextBox ID="txtConfirmPassword" TextMode="Password" runat="server" Width="20%"
                                Height="20px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqConfirmPassword" runat="server" ErrorMessage="*"
                                ForeColor="Red" ControlToValidate="txtConfirmPassword"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="compPassword" runat="server" ControlToValidate="txtConfirmPassword"
                                ForeColor="Red" ControlToCompare="txtNewPassword">New Password and Confirm Password not matched...</asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Button ID="btnChangePassword" runat="server" Text="<%$Resources:Resource, Change_Password%>"
                                OnClick="btnChangePassword_OnClick" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
