<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCUploadDocument.ascx.cs"
    Inherits="App_UserControls_UCUploadDocument" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
    <title></title>
</head>
<body>
    <style>
        .dummyButton
        {
            display: none;
        }
        li .ruCancel, li .ruRemove
        {
            visibility: hidden;
        }
        li.ruUploading
        {
            height: 0px;
        }
        .ruFileWrap
        {
            padding: 1px !important;
        }
        .cssMessege
        {
            color: Green;
            font-weight: bold;
            font-size: 12px;
        }
    </style>
    <script type="text/javascript">
        function fileSelected(sender, args) {
           // sender.set_enabled(false);
        }
        function fileUploaded(sender, args) {
            //sender.set_enabled(true);
            document.getElementById('<%= btnDummy.ClientID %>').click();

        }
        function OnClientFileUploading(sender, args) {
            //sender.set_enabled(true);
        }
    </script>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadFormDecorator ID="QsfFromDecorator" runat="server" DecoratedControls="All"
        EnableRoundedCorners="false" />
    <div class="qsf-demo-canvas" style="min-height: 380px; background-color: #F7F7F7;">
        <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td valign="top" style="padding-top: 10px;">
                                <telerik:RadComboBox runat="server" ID="cmbfacility" EmptyMessage="---Select---"> 
                                </telerik:RadComboBox>
                            </td>
                            <td style="padding-bottom: 20px; padding-top: 12px;" valign="top">
                                <telerik:RadAsyncUpload runat="server" ID="AsyncUploadFiles" OnClientFilesUploaded="fileUploaded"  OnClientFileUploading="OnClientFileUploading"
                                    UploadedFilesRendering="BelowFileInput" EnableInlineProgress="false" MultipleFileSelection="Automatic" OnClientFilesSelected="fileSelected" 
                                    Width="250px" />
                            </td>
                            <td style="padding-top: 10px;" align="left" valign="top">
                                <telerik:RadProgressArea runat="server" ID="RadProgressArea1" Skin="Hay" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding-top: 5px;">
                    <asp:Label ID="lblMessege" runat="server" Visible="false" CssClass="cssMessege"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="padding-top: 10px;">
                    <asp:Label ID="lblErrorMessege" runat="server" Visible="false" CssClass="cssMessege"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div style="width: 100%; border: 0px; border-color: Red; background-color: #FFFFFF;">
        <table border="0" width="100%" cellspacing="0">
            <tr>
                <td height="1px" style="background-color: Orange; border-collapse: collapse; border-right-color: #C5C4C2;">
                </td>
            </tr>
            <tr>
                <td style="background-color: #F7F7F7; height:32px;" align="justify">
                    <%--<asp:Image ID="img_entity" CssClass="wizardRightImage" ImageAlign="Left" runat="server"
                        ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm.png" />--%>
                        <asp:ImageButton ID="img_entity" ImageAlign="Left" runat="server" Enabled="false" ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm.png"
                         CssClass="wizardRightImage" OnClick="btnNext_Click"/>
                    <asp:Button ID="btnNext" Text="<%$Resources:Resource,Next %>" Font-Size="Medium" runat="server" Enabled="false" BackColor="Transparent"
                        CssClass="wizardRightImage" BorderStyle="None" BorderWidth="0px" OnClick="btnNext_Click" />
                </td>
            </tr>
            <tr>
                <td height="1px" style="background-color: #C5C4C2; border-collapse: collapse">
                </td>
            </tr>
        </table>
        <asp:Button ID="btnDummy" CssClass="dummyButton" OnClick="btnDummy_OnClick" runat="server" />
    </div>
</body>
</html>
