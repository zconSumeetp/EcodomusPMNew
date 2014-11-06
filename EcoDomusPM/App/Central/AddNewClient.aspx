<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddNewClient.aspx.cs" Inherits="App_Central_AddNewClient" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head runat="server">
    <title></title> 
    <script type="text/javascript" language="javascript">
        function refresh_parent() {
        //window.parent.document.getElementById("ctl00_ContentPlaceHolder1_btnRefresh").click()
        Close();
        window.parent.refreshgrid();
    }


        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog      
            else if (window.frameElement != null) {
                if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow; //IE (and Moz as well)      
            }
            return oWindow;
        }

        function Close() {
            GetRadWindow().Close();
        }
    </script>
    <style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
        .html
        {
            overflow:hidden;
            
        }
        .LabelText
        {
            font-family:Arial;
            font-weight:bolder;
            font-size:12px;
        }
    </style>
   <%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
   
</head>
<body style="margin: 0px; padding: 0px; background: white;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <table  width="90%" style="margin-left:20px;">
        
            
         <tr>
            <td align="left" style=" width:30%">
            <asp:Label ID="lblOrganizationName" Text="<%$Resources:Resource, Organization_Name%>" CssClass="LabelText" runat="server"></asp:Label>:
                
            </td>
            <td>
                <telerik:RadComboBox ID="rcbOrganizations" runat="server" Width="220px" Height="150px" EmptyMessage="--Select--" EnableTextSelection="False" ShowDropDownOnTextboxClick="True">
                </telerik:RadComboBox>
                <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator2"
                    runat="server" ValidationGroup="RequiredField" ControlToValidate="rcbOrganizations"
                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td  align="left">
                <asp:Label ID="lbl_name" Text="<%$Resources:Resource, Client_Name%>" CssClass="LabelText" runat="server"></asp:Label>:
            </td>
            <td>
                <asp:TextBox CssClass="SmallTextBox" ID="txtClientName" runat="server" Width="220"
                    ValidationGroup="RequiredField">
                </asp:TextBox>
                <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator" runat="server"
                    ValidationGroup="RequiredField" ControlToValidate="txtClientName" ErrorMessage="*"
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td  align="left">
                <asp:Label ID="lblDatabaseName" Text="<%$Resources:Resource, Database_Name%>" CssClass="LabelText" runat="server"></asp:Label>:
            </td>
            <td>
                <asp:TextBox ID="txtDatabaseName" CssClass="SmallTextBox" runat="server" Width="220"
                    ValidationGroup="RequiredField">
                </asp:TextBox>
                <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator1" runat="server"
                    ValidationGroup="RequiredField" ControlToValidate="txtDatabaseName" ErrorMessage="*"
                    ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="rgv" 
                           ValidationGroup="RequiredField" runat="server" ControlToValidate="txtDatabaseName" ErrorMessage="Special character and space are not allowed."
                              ValidationExpression="^[a-zA-Z0-9_]{1,40}$"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td  align="left">
                <asp:Button Width="100" ID="btnAddClient" ValidationGroup="RequiredField" Text="<%$Resources:Resource, Ok%>"
                    runat="server" OnClick="AddNewClientClick" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ForeColor="Red" ID="lblMessage" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
