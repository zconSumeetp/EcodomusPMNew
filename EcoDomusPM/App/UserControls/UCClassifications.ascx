<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCClassifications.ascx.cs"
    Inherits="App_UserControls_UCClassifications" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
<link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    .checkbox
    {
        font-family: Tahoma;
        font-size: 12px;
        font-weight: normal;
        padding: 1px;
    }
</style>
<script type="text/javascript">
    function closeWindow() {
        window.parent.refreshgrid();
        window.close();
        return false;


    }
    function LogoutNavigation() {
        var query = parent.location.href;
        top.location.href(query);
    }
    window.onload = adjust_height;
</script>
<div style="padding-left: 0px; margin: 0px 50px 5px 0px; background: #EEEEEE; width: 100%">
    <table width="100%">
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <table id="tbl_add" runat="server" width="100%">
                    <tr>
                        <td style="padding-left:10px">
                            <asp:Label ID="lblhdr" runat="server" Text="Select Classification to be added for current Template"
                                CssClass="captiondock"></asp:Label>:
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 5px;">
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left:10px">
                            <asp:CheckBox ID="chkOmniClass" runat="server" Checked="true" Font-Size="10pt" Text="OmniClass"
                                CssClass="LabelText" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 5px;">
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left:10px;">
                            <asp:CheckBox ID="chkUniclass" runat="server" Checked="false" Font-Size="10pt" Text="UniClass"
                                CssClass="LabelText" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 5px;">
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left:10px">
                            <asp:CheckBox ID="chkMasterformat" runat="server" Font-Size="10pt" Text="MasterFormat"
                                CssClass="LabelText" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 5px;">
                        </td>
                    </tr> 
                    <tr>
                        <td style="padding-left:10px">
                            <asp:CheckBox ID="chkUniFormat" runat="server" Font-Size="10pt" Text="UniFormat"
                                CssClass="LabelText" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 5px;">
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left:10px">
                            <asp:CheckBox ID="chkMedicalCodes" runat="server" Font-Size="10pt" Text="MedicalCodes"
                                CssClass="LabelText" />
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
         <tr>
                <td style="background-color: Orange; height: 1px; border-bottom-color: transparent;
                    border-bottom-width: 0px; border-top-color: transparent; border-top-width: 0px;">
                </td>
            </tr>
        <tr>
                <td align="right" style="padding-bottom: 0px; margin-bottom: 0px">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="middle" style="padding-right: 2px">
                                <asp:ImageButton ID="ibtn_back" runat="server" Width="10" ImageUrl="~/App/Images/Icons/arrow_left.gif"
                                    Enabled="true" Visible="true" OnClick="ibtn_back_Click" ImageAlign="Top" CssClass="lnkButtonImg" />
                            </td>
                            <td valign="top">
                                <asp:LinkButton ID="lbtn_back" runat="server" Text="Back" CssClass="lnkButton" Font-Underline="false"
                                    Enabled="true" OnClick="lbtn_back_Click"></asp:LinkButton>
                            </td>
                            <td style="padding-left: 25px; padding-right: 25px" valign="middle">
                                <asp:Image ID="img_vbar" runat="server" ImageUrl="~/App/Images/Icons/asset_scrollbar_bar.png"
                                    Width="2px" Height="10px" />
                            </td>
                            <td valign="top">
                                <asp:LinkButton ID="lbtn_next" runat="server" Text="Finish" ForeColor="Black" CssClass="lnkButton"
                                    OnClick="lbtn_next_Click" OnClientClick="javascript:return closeWindow();"></asp:LinkButton>
                            </td>
                            <td valign="bottom">
                                <asp:ImageButton ID="ibtn_next" runat="server" ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm.png"
                                    OnClick="ibtn_next_Click" CssClass="lnkButtonImg" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
    </table>
</div>
