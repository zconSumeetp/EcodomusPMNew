<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Error" %>

<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript">


    function GetRadWindow() {
        var oWindow = null;
    if (window.radWindow)
            oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog      
    else if(window.frameElement!=null)
       
            if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow; //IE (and Moz as well)      
       
        return oWindow;
    }

    function Close() {
        if (GetRadWindow()!=null)
        GetRadWindow().Close();
    }

    function CheckUrl() {
    
            parent.parent.location.href = "../app/loginPM.aspx";
            Close();
        
        }
    
    
    </script>
    <title></title>
    <link rel="stylesheet" type="text/css" href="../App_Themes/EcoDomus/style.css" />
</head>
<body>
    <form id="form1" runat="server">
    <%--    <asp:Content ID="head" ContentPlaceHolderID="cphHead" runat="server">
     <link rel="stylesheet" type="text/css" href="app_themes/ecodomus/style.css" />
    
    </asp:Content>
    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">--%>
    <script type="text/javascript">
    
    </script>
    <table>
        <tr style="height: 100px;">
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td style="font-weight: bold;">
                            The following captured error occurred:
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblerrormessage" runat="server" ForeColor="red" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            please describe what you were trying to do:
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtuserdesc" runat="server" TextMode="multiline" Height="50px" Width="300px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnLogError" OnClick="btnLogError_OnClick" runat="server" Text="Maintain Log" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <td style="display: none">
            <asp:Button ID="btnredirect" runat="server" OnClick="btnredirect_click" />
        </td>
        <tr>
        </tr>
    </table>
    <%-- </asp:Content>--%>
    </form>
</body>
</html>
