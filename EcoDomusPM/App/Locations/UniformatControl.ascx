<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UniformatControl.ascx.cs"
    Inherits="App_Locations_UniformatControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadCodeBlock ID="radcodeblock1" runat="server" />
<html>
<head>
    <title></title>
    <script type="text/javascript" language="javascript">
        window.onload = adjust_height;
    </script>
    <style type="text/css">
        .RadComboBox table td.rcbInputCell, .RadComboBox .rcbInputCell .rcbInput
        {
            font-size: 13px !important;
            margin-top: -6px !important;
            
        }
     
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
</head>
<body>
    <div style="background-position: white; background-color: #EEEEEE; padding: 0px;
        margin: 0px 0px 0px 0px; padding-left: 65px;">
        <table width="100%" border="0">
            <tr style="height: 40px">
                <td style="margin-right: 1px">
                    <asp:Label ID="lbl_uniformat" runat="server" CssClass="normalLabel" Font-Size="11pt"
                        Text="<%$Resources:Resource,Select_Uniformat%>" ForeColor="#990000"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 40px">
                    <telerik:RadComboBox ID="rcmb_uniformat" AutoPostBack="true" Filter="Contains" Width="400px" Height="100px" 
                        runat="server" AllowCustomText="false" />
                    <asp:HiddenField runat="server" ID="hf_uniformat_id" Value="false" />
                </td>
            </tr>
            <%--  <tr>
                <td height="5px"></td></tr>--%>
        </table>
    </div>
</body>
</html>
