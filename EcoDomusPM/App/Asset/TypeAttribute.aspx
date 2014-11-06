<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TypeAttribute.aspx.cs" Inherits="App.Asset.Attribute" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="../UserControls/AttributesControl.ascx" TagName="AttributesControl" TagPrefix="uc" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title></title>
        <style type="text/css">
            html,
            body {
                margin: 0;
                padding: 0;
                background-color: #f7f7f7;
            }
            html,
            body,
            form {
                height: 100%;
            }
            .rgCommandCell {
                border: none !important;
            }
            .GridHeadDiv {
                background-color: #707070; 
                height: 35px;
            }
            .GridButtons {
                vertical-align: middle;
                display: inline-block !important;
                background-repeat:no-repeat;
            }
            .RadGridAttributes .rgEditForm table {
                line-height: normal !important;    
            }
            * html .RadInput {
                height: auto !important;
            }

            .header-cell
            {
                border-left: 1px solid #808080 !important;
                border-top: 0 none !important;
                border-right: 0 none !important;
                border-bottom: 0 none !important;
            }
            
            .header-cell.rgGroupCol  {
                border-left: 0 none !important;
            }
        </style>
    </head>
    <body>
        <form runat="server">
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server" OnAsyncPostBackError="RadScriptManager1_OnAsyncPostBackError">
                <Scripts>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
                </Scripts>
            </telerik:RadScriptManager>

            <telerik:RadAjaxManager runat="server" />
            
            <table width="95%" height="100%" style="height: 100%">
                <tr style="height: 100%">
                    <td style="height: 100%">
                        <uc:AttributesControl runat="server" ID="AttributesControl" style="width: 95%; height: 100%" />
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
