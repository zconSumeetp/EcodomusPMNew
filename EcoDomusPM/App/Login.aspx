<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="App_Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="../App_Themes/EcoDomus/style.css" />
    <title>EcoDomus - Login</title>
    <script language="javascript" type="text/javascript">
        function keypress(e) {
            if (e.keyCode == 13) {
                document.getElementById("lgnUserLOgin_LoginButton").click();
            }
        }

        function OpenFacilityGrid(id) {
            $find("RadWindow_NavigateUrl").show();
        }

     

    </script>
    <style type="text/css">
        .style1
        {
            width: 60px;
        }
        .style2
        {
            width: 197px;
        }
    </style>
</head>
<body onkeypress="keypress(event);">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <%--<div id="divLanguage" style=" margin-top:90px; margin-right:"85%;" align="right"   >
    Language: 
        <asp:DropDownList ID="ddlLanguage" runat="server" Width="161px" 
            AutoPostBack="True" onselectedindexchanged="ddlLanguage_SelectedIndexChanged"    >
            </asp:DropDownList>
    
    
    </div>--%>
    <div id="divLogin" style="width: 341px">
        <table style="width: 332px">
            <tr>
                <td colspan="2">
                    <div style="float: left;">
                        <asp:Image ID="imgEcoDomusLogo" runat="server" ImageUrl="../App/Images/EcoDomusLogo.gif"
                            AlternateText="EcoDomus Logo" Width="70px" Height="70px" />
                    </div>
                    <div style="padding-left: 15px; float: left; padding-top: 5px;">
                        <h1 style="font-family: Arial, Helvetica, sans-serif; font-size: xx-large; font-weight: bold;
                            color: #37B34A; padding-left: 10px;">
                             EcoDomus FM
                        </h1>
                    </div>
                </td>
            </tr>
            <tr>
            <td>
              <table>
                 <tr>
                   <td>
                     <asp:Label ID="Label1" runat="server"  Text="<%$Resources:Resource, Language%>"></asp:Label>:
                    </td>
                    <td >
                       &nbsp; <asp:DropDownList ID="ddlLanguage" runat="server" Width="180px" 
                            AutoPostBack="True" onselectedindexchanged="ddlLanguage_SelectedIndexChanged" >
                        </asp:DropDownList>
                    </td>
                 </tr>
              </table>
                </td>
              </tr>
            <tr>
                <td >
                    <asp:Login ID="lgnUserLOgin" runat="server" OnAuthenticate="lgnUserLOgin_Authenticate">
                        <LayoutTemplate>
                            <table>
                                 <tr>
                                    <td>
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Text="<%$Resources:Resource, Username%>">
                                       
                                        </asp:Label>:
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="SmallTextBox" ID="UserName" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                            ErrorMessage="User Name is required." ForeColor="Red" ToolTip="User Name is required."
                                            ValidationGroup="lgnUserLOgin">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" Text="<%$Resources:Resource, Password%>">
                                      
                                        </asp:Label> :
                                    </td>
                                    <td>
                                        <asp:TextBox CssClass="SmallTextBox" ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                            ErrorMessage="Password is required." ForeColor="Red" ToolTip="Password is required."
                                            ValidationGroup="lgnUserLOgin">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="<%$Resources:Resource, Log_In%>" Width="70"
                                            ValidationGroup="lgnUserLOgin" />
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                    </asp:Login>
                    <div>

                       <telerik:RadWindowManager EnableShadow="true" Behaviors="Close, Move, Resize,Maximize"
                            ID="RadWindowManager_1" DestroyOnClose="true" RestrictionZoneID="RestrictionZone"
                            Opacity="99" runat="server" Width="450" Height="400">
                            <Windows>
                                <telerik:RadWindow runat="server" ID="RadWindow_NavigateUrl" NavigateUrl="FacilityList.aspx"
                                    Modal="true">
                                </telerik:RadWindow>
                            </Windows>
                        </telerik:RadWindowManager>

                        <asp:Button ID="Redirect_Btn" runat="server" Style="display: none" Text="" Width="70"
                            OnClick="Redirect_Btn_Click" />
                        <asp:HiddenField runat="server" ID="flag" />
                        <asp:Label ID="lblFailureText" Width="400px" runat="server"></asp:Label>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
