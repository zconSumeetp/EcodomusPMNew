<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginPM.aspx.cs" Inherits="App_LoginPM" %>

<%@ OutputCache Location="None" VaryByParam="None" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <title></title>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">
            function showMenuAt(e) {
                var contextMenu = $find("<%= rcm_languages.ClientID %>"),
                x = parseInt($get("coordX").value),
                y = parseInt($get("coordY").value);
                if (isNaN(x) || isNaN(y)) {
                    alert("Please provide valid integer coordinates");
                    return;
                }
                $telerik.cancelRawEvent(e);
                contextMenu.showAt(x, y);
                //alert
            }

            function showLanguageMenu(e) {
                var contextMenu = $find("<%= rcm_languages.ClientID %>");
                $telerik.cancelRawEvent(e);
                if ((!e.relatedTarget) || (!$telerik.isDescendantOrSelf(contextMenu.get_element(), e.relatedTarget))) {
                    contextMenu.show(e);

                }
            }

            function onClientItemClickedHandler(sender, eventArgs) {
                //alert(eventArgs.get_item().get_value());

                document.getElementById("<%=hf_culture_id.ClientID%>").value = eventArgs.get_item().get_value();
                document.getElementById("<%=lbl_language_name.ClientID%>").value = eventArgs.get_item().get_text();

                var ddl_language = document.getElementById('<%=ddlLanguage.ClientID %>')
                for (var i = 0; i < ddl_language.options.length; i++) {
                    //alert("All"+ddl_language.options[i].value);
                    if (ddl_language.options[i].value == eventArgs.get_item().get_value()) {
                        //alert("Match"+ddl_language.options[i].value);
                        ddl_language.options[i].selected = true;
                    }
                }
            }
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement && window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function refreshparent() {
                var win = GetRadWindow();
                if (win)
                    top.location.reload();
            }
            function body_load() {
                var screenhtg = parseInt($(window).height() - 58);
                document.getElementById('<%= hfPageSize.ClientID %>').value = parseInt((screenhtg - 130) / 40);

            }

            window.onload = body_load;

            function rcm_languages_OnClientItemClicking(sender, eventArgs) {
                var culture = eventArgs.get_item().get_attributes().getAttribute("culture");
                SaveSelectedCultureInCookie(culture);
            }

            function SaveSelectedCultureInCookie(culture) {
                $.cookie("SelectedCulture", culture, { expires: 30, path: '/' });
            }
        </script>
        <script src="../App_Themes/EcoDomus/jquery-1.8.3.js" type="text/javascript"></script>
        <script src="../App_Themes/EcoDomus/jquery.cookie.js" type="text/javascript"></script>
    </telerik:RadCodeBlock>
</head> 
<body class="LoginBody">
    <form id="form1" runat="server" defaultbutton="LoginButton">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>
    <div class="LangaugeTop">
    </div>
    <div class="LangaugeBox">
        <table border="0" cellpadding="0" cellspacing="0" align="right">
            <tr>
                <td>
                    <asp:Label ID="lbl_language_name" CssClass="LangaugeBox" runat="server" Text="English" ForeColor="White"></asp:Label>
                </td>
                <td style="padding-right: 5px;">
                    <%--  <asp:ImageButton ID="img_language" runat="server" ImageUrl="~/App/Images/Icons/asset_arrow_lg.png" style="outline:none"
                        OnClientClick="showLanguageMenu(event)"  />--%>
                   <asp:Image ID="Image1" runat="server" ImageUrl="~/App/Images/Icons/asset_arrow_lg.png" AlternateText="Select Language" onmouseover="showLanguageMenu(event)" />
                </td>
                <td>
                    <div style="display: none">
                        <asp:DropDownList ID="ddlLanguage" runat="server" Width="180px" AutoPostBack="True">
                            <%--onselectedindexchanged="ddlLanguage_SelectedIndexChanged" --%>
                        </asp:DropDownList>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div class="LoginBox">
        <table cellpadding="0" cellspacing="0" class="LoginBoxTable">
            <tr>
                <td colspan="6" valign="middle" style="padding-bottom: 6px;">
                    <div>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="padding-right: 12px;">
                                    <asp:Image ID="Img1" runat="server" ImageUrl="~/App/Images/Icon-Small-50.png" />
                                </td>
                                <td style="font-family: 'Microsoft Sans Serif'; font-size: 22pt; color: #FFFFFF;
                                    vertical-align: middle;">
                                    EcoDomus PM
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="font-family: 'Microsoft Sans Serif'; font-size: 32pt; color: #FFFFFF">
                    <asp:Label ID="lbl_login" runat="server" Text="<%$Resources:Resource, LogIn%>"></asp:Label>
                </td>
                <td valign="middle" style="padding-left: 20px;">
                    <telerik:RadTextBox CssClass="LoginTextBox" ID="UserName" runat="server" EmptyMessage="<%$Resources:Resource, Username%>"
                        Skin="Office2010Black" Font-Size="12pt" Width="180px">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                        ForeColor="Red" ErrorMessage="User Name is required." ToolTip="User Name is required."
                        ValidationGroup="lgnUserLOgin">*</asp:RequiredFieldValidator>
                </td>
                <td style="padding-left: 10px;">
                    <telerik:RadTextBox CssClass="LoginTextBox" ID="Password" TextMode="Password" runat="server"
                        EmptyMessage="<%$Resources:Resource, Password%>" Skin="Office2010Black" Font-Size="12pt"
                        Width="180px">
                    </telerik:RadTextBox>
                </td>
                <td style="padding-right: 10px;">
                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                        ForeColor="Red" ErrorMessage="Password is required." ToolTip="Password is required."
                        ValidationGroup="lgnUserLOgin">*</asp:RequiredFieldValidator>
                </td>
                <td style="padding-left: 10px; border-left: 1px solid white;" valign="middle">
                    <asp:ImageButton ID="LoginButton" runat="server" ImageUrl="~/App/Images/Icons/icon_login.png"
                        CommandName="Login" ValidationGroup="lgnUserLOgin" CssClass="LoginButton" OnClick="LoginButton_Click" />
                </td>
            </tr> 
            <tr>
                <td colspan="5">
                </td>
                <td style="padding-top: 8px;">
                    <asp:CheckBox ID="chkRememberMe" CssClass="LangaugeBox" runat="server" Text="Remember Me" ForeColor="White" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td colspan="5" style="padding-left: 20px; padding-top: 8px;">
                    <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Font-Size="18px"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div class="ForgotPassword">
        <asp:LinkButton ID="ForgotPassword" Text="I Forgot my password ..."  CssClass="LangaugeBox"
            runat="server" onclick="ForgotPassword_Click"></asp:LinkButton>
    </div>
    <telerik:RadContextMenu ID="rcm_languages" runat="server" EnableRoundedCorners="true" OnItemDataBound="rcm_languages_OnItemDataBound" OnClientItemClicking="rcm_languages_OnClientItemClicking"
        Width="60px" EnableShadows="true" Skin="Black" CssClass="LangaugeBox" OnClientItemClicked="onClientItemClickedHandler"
        OnItemClick="rcm_languages_ItemClick">
    </telerik:RadContextMenu>
     <asp:HiddenField ID="hf_culture_id" runat="server" Value="" />
      <asp:HiddenField ID="hfPageSize" runat="server" Value="" />
    </form>
</body>
</html>
