<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingAASAlgorithmEdit.aspx.cs"
    Inherits="App_NewUI_EnergyModelingAASAlgorithmEdit" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CloseWindow() {
            GetRadWindow().close();
            //   top.location.reload();
            //GetRadWindow().BrowserWindow.adjust_parent_height();
            return false;

           


        }
    </script>
    <style type="text/css">
        .tdback1
        {
            background-image: url('/App/Images/Icons/edit1.png');
            background-repeat: no-repeat;
        }
        
        .tdback2
        {
            background-image: url('/App/Images/Icons/edit2.png');
            background-repeat: no-repeat;
        }
        
        .tdback3
        {
            background-image: url('/App/Images/Icons/edit3.png');
            background-repeat: no-repeat;
        }
        
        .style8
        {
            height: 30px;
            width: 200px;
        }
        .style9
        {
            height: 1px;
            width: 200px;
        }
        .style18
        {
            width: 180px;
        }
        .style19
        {
            height: 30px;
            width: 160px;
        }
        .style20
        {
            height: 1px;
            width: 160px;
        }
        .style22
        {
            width: 250px;
        }
        .style23
        {
            width: 160px;
        }
    </style>
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
                                    <asp:Label ID="lbl_header" Text=" AAS Algorithm Edit" runat="server"></asp:Label>
                                </div>
                                <div class="wizardRightImage">
                                    <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                        OnClick="ibtn_close_Click" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="background: #F7F7F7; height: 40px; padding-left: 20px">
                                <asp:Label ID="lbl_label1" runat="server" Text="" CssClass="normalLabel" ForeColor="#404040"></asp:Label>
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
                                        <td colspan="3" style="padding-bottom: 5px">
                                            <asp:Label ID="lbl_description" runat="server" Text="Description"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <telerik:RadTextBox ID="txt_description" runat="server" Width="500px">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 15px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="1" class="style22">
                                            <asp:Label ID="lblComparision" runat="server" Text="Comparision Statement:"></asp:Label>
                                        </td>
                                        <td colspan="1" class="style22" align="center">
                                            <asp:Label ID="lblTolerance" runat="server" Text="Tolerance"></asp:Label>
                                        </td>
                                        <td class="style18">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 10px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style22">
                                            <asp:Label ID="lblIf" runat="server" Text="IF" Font-Bold="true"></asp:Label>
                                            &nbsp&nbsp&nbsp
                                            <asp:Label ID="lblmeasrement" runat="server" Text="Measurement"></asp:Label>
                                            &nbsp&nbsp&nbsp
                                            <asp:DropDownList runat="server" ID="ddlComparision" Width="80">
                                                <asp:ListItem Text="<"></asp:ListItem>
                                                <asp:ListItem Text=">"></asp:ListItem>
                                                <asp:ListItem Text="<>"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td class="style22">
                                            <asp:Label ID="Label2" runat="server" Text="Simulation"></asp:Label>
                                            &nbsp&nbsp&nbsp
                                            <asp:DropDownList runat="server" ID="ddlTolarece" Width="70">
                                                <asp:ListItem Text="+"></asp:ListItem>
                                                <asp:ListItem Text="-"></asp:ListItem>
                                                <asp:ListItem Text="+-"></asp:ListItem>
                                            </asp:DropDownList>
                                            &nbsp&nbsp&nbsp
                                            <asp:TextBox ID="txttol" Width="50px" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="style18">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 10px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label runat="server" ID="lblThen" Text="Then: " Font-Bold="true"></asp:Label>
                                            &nbsp;
                                            <asp:DropDownList runat="server" ID="ddlImpactOperator" Width="450">
                                                <asp:ListItem Text="Apply Performance Impact As Negative Performance"></asp:ListItem>
                                                <asp:ListItem Text="Apply Performance Impact As Positive Performance"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="height: 30px">
                                        </td>
                                    </tr>
                                    </table>
                                    <table width="100%">
                                    <tr>
                                        <td valign="top">
                                            <table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse">
                                                <tr>
                                                    <td style="height: 30px;">
                                                    <asp:Image ID="Image2" runat="server" ImageUrl="~/App/Images/Icons/edit1.png" />
                                                    </td>
                                                </tr>
                                             <%--   <tr>
                                                    <td style="height: 1px; background-color: Orange">
                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td class="style8">
                                                        <asp:Label runat="server" ID="lbl3" Text="OmniClass Name"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style8">
                                                        <asp:TextBox runat="server" ID="txtOmniName" Width="220px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style8">
                                                        <asp:Label runat="server" ID="Label3" Text="BAS Attribute Name"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style8">
                                                        <asp:TextBox ID="txtBASAttrName" runat="server" Width="220px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top" >
                                            <table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse">
                                                <tr>
                                                    <td style="height: 30px;">
                                                     <asp:Image ID="Image1" runat="server" ImageUrl="~/App/Images/Icons/edit2.png" />
                                                    </td>
                                                </tr>
                                               <%-- <tr>
                                                    <td style="height: 1px; background-color: Orange" >
                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td class="style8">
                                                        <asp:Label runat="server" ID="Label5" Text="Energy Model Class Name"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style8">
                                                        <asp:TextBox runat="server" ID="txtIDDClass" Width="220px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style8">
                                                        <asp:Label runat="server" ID="Label6" Text="Energy Model Class FIeld"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style8">
                                                        <asp:TextBox ID="txtIDDClassField" runat="server" Width="220px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top">
                                            <table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse">
                                                <tr>
                                                    <td style="height: 30px;">
                                                     <asp:Image ID="Image3" runat="server" ImageUrl="~/App/Images/Icons/edit3.png" />
                                                    </td>
                                                </tr>
                                               <%-- <tr>
                                                    <td style="height: 1px; background-color: Orange">
                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td class="style19">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style19">
                                                        <asp:TextBox runat="server" ID="txtImpact" Width="160px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style19">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style23">
                                                        &nbsp;
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
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
