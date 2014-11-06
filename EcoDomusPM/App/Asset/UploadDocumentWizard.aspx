<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UploadDocumentWizard.aspx.cs"
    Inherits="App_Asset_UploadDocumentWizard"  MasterPageFile="~/App/EcoDomus_PM_New.master"  %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <style type="text/css">
        .rtsSelected
        {
            background-color: transparent;
            font-weight: bold;
            font-size: 14px;
            font-family: "Arial" , sans-serif;
        }
        
        .rtsIn
        {
            background-color: transparent;
            color: #696969;
        }
        .rtsImg
        {
            background-color: transparent;
            width: 22px;
            height: 40px;
            margin: 0px;
        }
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: auto;
        }
    </style>
    <script type="text/javascript" language="javascript" >
            window.onload = body_load;
            function body_load() {

                var screenhtg = set_NiceScrollToPanel();
            }
    </script>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" />
    <div style="width: 95%; border: 0px;   border-color: Red; margin-top:20px; background-color: #FFFFFF;">
        <table border="0"  width="100%"  cellspacing="0">
            <tr>
                <td height="1px" style="background-color: Orange; border-collapse: collapse">
                </td>
            </tr>
            <tr>
                <td style="background-color: #F7F7F7;">
                    <telerik:RadTabStrip runat="server" ID="rts_upload_document" SelectedIndex="0" MultiPageID="rmp_upload_document"
                        Align="Justify" ShowBaseLine="True" Skin="" dir="ltr" CssClass="normalLabel"
                        Height="40px" OnTabClick="rts_uplaod_document_TabClick" BorderWidth="0px">
                    </telerik:RadTabStrip>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadMultiPage runat="server" ID="rmp_upload_document" SelectedIndex="0" OnPageViewCreated="rmp_uplaod_document_PageViewCreated">
                    </telerik:RadMultiPage>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
