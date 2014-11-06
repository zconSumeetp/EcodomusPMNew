<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EulaRegistration.aspx.cs" Inherits="App_Central_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Change Password</title>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
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
                            <asp:Label ID="lblEULA" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 11px; width: 8%; padding-bottom: 8px;" valign="top">
                            &nbsp;</td>
                        <td style="padding-bottom: 8px;">
                            &nbsp;<asp:Literal ID="ltrEULA" runat="server"></asp:Literal></td>
                    </tr>
                    <tr>
                        <td style="font-size: 11px; padding-bottom: 8px;" valign="top">
                            &nbsp;</td>
                        <td style="padding-bottom: 8px;">
                        <iframe runat="server" id="iframepdf" height="400" width="900" src="getpdf.ashx"> </iframe>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td style="font-size: 11px; padding-bottom: 8px;" valign="top">
                            &nbsp;</td>
                        <td style="padding-bottom: 8px;">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Button ID="btnIAgree" runat="server" Text="<%$Resources:Resource,IAgree%>" 
                                onclick="btnIAgree_Click"/>
                            &nbsp;  &nbsp;
                            <asp:Button ID="btnIDecline" runat="server" Text="<%$Resources:Resource,IDecline%>" 
                                onclick="btnIDecline_Click"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

