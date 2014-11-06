<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LicenseRegistration1.aspx.cs"
    Inherits="App_Settings_LicenseRegistration1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>License Registration</title>

     <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css"/>
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
</head> 

<body>
    <form id="form1" runat="server">
    <asp:scriptmanager ID="Scriptmanager1" runat="server"></asp:scriptmanager>
    <table id="tblmaster" class="tableHeader" border="0" width="100%" cellpadding="0"
        cellspacing="0" style="margin: 0 0 0 0;">
        <tr>
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
            <td colspan="2" style="padding: 60px 0 0 25px;">
                <div style="width: 100%;">
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <table width="50%" align="left">
                                            <tr>
                                                <td colspan="3" align="left" style="height: 10px;">
                                                </td> 
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="left">
                                                    <b>
                                                        <asp:Label runat="server" ID="lbl_Registration" Text="EcoDomus Registration" ForeColor="Brown"
                                                            Style="font-size: large;" /></b>
                                                </td>
                                            </tr>
                                            <tr> 
                                                <td colspan="3" style="height: 50px;">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr style="height: 20px;">
                                                <td align="left">
                                                    <asp:Label runat="server" ID="lbl_email" Text="Please Enter Your Email Id :" CssClass="Label" />
                                                </td>
                                                <td width="5%">
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txt_email" Width="200px" /><asp:Label runat="server"
                                                        ID="lbl_req_field" Text="" ForeColor="Red" /><asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                                                            runat="server" ErrorMessage="Enter Valid Email ID" ControlToValidate="txt_email"
                                                            ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                            <tr style="height: 20px;">
                                                <td align="left">
                                                    <asp:Label runat="server" ID="lbl_select_duration" Text="Select the type of License :"
                                                        CssClass="Label" />
                                                </td>
                                                <td width="5%">
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList ID="Rb_list_duration" runat="server" RepeatDirection="Horizontal"
                                                        OnSelectedIndexChanged="Rb_list_duration_SelectedIndexChanged" AutoPostBack="true"
                                                        EnableViewState="true">
                                                        <asp:ListItem Selected="True" Value="Trial Version">Trial Version</asp:ListItem>
                                                        <asp:ListItem Value="License Version">License Version</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                            <tr runat="server" id="tr_duration">
                                                <td align="right">
                                                    <asp:Label runat="server" ID="lbl_duration" Text="License Duration :" CssClass="Label" />
                                                </td>
                                                <td width="5%">
                                                </td>
                                                <td>
                                                    <%--<asp:TextBox runat="server" ID="txt_duration"  />--%>
                                                    <asp:DropDownList ID="dd_years" runat="server">
                                                        <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                        <asp:ListItem Value="1">1</asp:ListItem>
                                                        <asp:ListItem Value="2">2</asp:ListItem>
                                                        <asp:ListItem Value="3">3</asp:ListItem>
                                                        <asp:ListItem Value="4">4</asp:ListItem>
                                                        <asp:ListItem Value="5">5</asp:ListItem>
                                                        <asp:ListItem Value="6">6</asp:ListItem>
                                                        <asp:ListItem Value="7">7</asp:ListItem>
                                                        <asp:ListItem Value="8">8</asp:ListItem>
                                                        <asp:ListItem Value="9">9</asp:ListItem>
                                                        <asp:ListItem Value="10">10</asp:ListItem>
                                                        <asp:ListItem Value="11">11</asp:ListItem>
                                                        <asp:ListItem Value="12">12</asp:ListItem>
                                                        <asp:ListItem Value="13">13</asp:ListItem>
                                                        <asp:ListItem Value="14">14</asp:ListItem>
                                                        <asp:ListItem Value="15">15</asp:ListItem>
                                                        <asp:ListItem Value="16">16</asp:ListItem>
                                                        <asp:ListItem Value="17">17</asp:ListItem>
                                                        <asp:ListItem Value="18">18</asp:ListItem>
                                                        <asp:ListItem Value="19">19</asp:ListItem>
                                                        <asp:ListItem Value="20">20</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:Label runat="server" ID="lbl_yrs" Text="Yrs" />
                                                    <asp:Label runat="server" ID="lbl_req_field2" Text="" ForeColor="Red" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" style="height: 20px;">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="center">
                                                    <asp:Button runat="server" ID="btn_trail" Text="Request For License Key" OnClick="btn_trail_Click" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="center">
                                                    <asp:Label runat="server" ID="lbl_mail_note" Text="" ForeColor="Green" />
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 30px;">
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <div style="width: 100%;">
                                    <asp:Panel ID="Panel1" runat="server" BorderColor="Aqua" GroupingText="Activate License"
                                        DefaultButton="btn_activate" Width="100%">
                                        <table width="90%" align="left">
                                            <tr>
                                                <td colspan="4" style="height: 5px;">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lbl_key" Text="Enter EcoDomus license Key :" CssClass="Label" />
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txt_key" TextMode="MultiLine" Width="600px" />
                                                </td>
                                                <td>
                                                    <asp:Button runat="server" ID="btn_activate" Text="Activate License" OnClick="btn_activate_Click"
                                                        CausesValidation="false" Skin="Hay" />
                                                </td>
                                                <td>
                                                    <asp:Button runat="server" ID="btn_cont" Text="Continue" CausesValidation="false"
                                                        OnClick="btn_cont_Click" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" align="center">
                                                    <asp:Label runat="server" ID="lbl_activation_msg" ForeColor="Red" Text="" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" style="height: 5px;">
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 100px;">
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
