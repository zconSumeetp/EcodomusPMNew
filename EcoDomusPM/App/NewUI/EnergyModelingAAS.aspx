<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingAAS.aspx.cs" Inherits="App_NewUI_EnergyModelingAAS" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
     <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CloseWindow() {
            GetRadWindow().close();
            return false;
        }
        </script>
        </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
                        <tr>
                            <td class="wizardHeadImage">
                                <div class="wizardLeftImage">
                                    <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_equipment_sm.png" />
                                    <asp:Label ID="lbl_header" Text=" AAS" runat="server"></asp:Label>
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
                <td style="background: #F7F7F7; height: 40px; padding-left: 20px">
                    <asp:Label ID="lbl_label1" runat="server" Text="Add new assumption,approximation or simplification"
                        CssClass="normalLabel" ForeColor="#404040"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 2px; background-color: #A9A9A9">
                </td>
            </tr>
            <tr>
                <td style="padding-left: 20px;">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td style="height: 20px" colspan="2">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="padding-bottom: 5px">
                                <asp:Label ID="lbl_description" runat="server" Text="Description" CssClass="normalLabel"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <telerik:RadTextBox ID="txt_description" runat="server" Width="480">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 30px">
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                               <table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse">
                                    <tr>
                                        <td style="background: #E4E4E4; height: 30px">
                                            <asp:Image ID="Image2" runat="server" ImageUrl="~/App/Images/Icons/header1.png" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="background: #E4E4E4; height: 30px">
                                            <asp:RadioButton ID="rbtn_simulation" runat="server" GroupName="SM" Text="Simulation"
                                                CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 30px">
                                            <asp:RadioButton ID="rbtn_measurement" runat="server" GroupName="SM" Text="Measurement"
                                                CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 1px; background-color: Orange">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top">
                                <table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse">
                                    <tr>
                                        <td style="background: #E4E4E4; height: 30px">
                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/App/Images/Icons/header2.png" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="background: #E4E4E4; height: 30px">
                                            <asp:RadioButton ID="rbtn_assumption" runat="server" GroupName="AAS" Text="Assumption"
                                                CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 30px">
                                            <asp:RadioButton ID="rbtn_approximation" runat="server" GroupName="AAS" Text="Approximation"
                                                CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="background: #E4E4E4; height: 30px">
                                            <asp:RadioButton ID="rbtn_simplification" runat="server" GroupName="AAS" Text="Simplification"
                                                CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 1px; background-color: Orange">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height: 20px">
                </td>
            </tr>
            <tr>
                <td style="height: 1px; background-color: Orange;">
                </td>
            </tr>
            <tr>
                <td align="right" style="padding-right: 10px">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <asp:LinkButton ID="lbtn_cancel" runat="server" Text="Cancel" ForeColor="Black" Font-Underline="false"
                                    CssClass="normalLabel" OnClick="lbtn_cancel_Click"></asp:LinkButton>
                            </td>
                            <td style="padding-left: 10px; padding-right: 10px">
                                <asp:LinkButton ID="lbtn_gap" runat="server" Text="|" Enabled="false" ForeColor="Black"></asp:LinkButton>
                            </td>
                            <td style="padding-right: 5px">
                                <asp:LinkButton ID="lbtn_save" runat="server" Text="Save" ForeColor="Black" Font-Underline="false"
                                    CssClass="normalLabel" OnClick="lbtn_save_Click"></asp:LinkButton>
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
