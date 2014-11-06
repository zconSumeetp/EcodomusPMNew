<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MasterFormatControl.ascx.cs"
    Inherits="App_Locations_MasterFormatControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head>
    <title></title>
    <telerik:RadCodeBlock runat="server">
        <script type="text/javascript" language="javascript">
            function closewindow() {
                window.close();
            }
            window.onload = adjust_height;

        </script>
        <style type="text/css">
       
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow:hidden;
        }
    </style>
    </telerik:RadCodeBlock>
      <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
</head>
<body >
    <div>
        <div style="margin-left: 0px; background-color: #EEEEEE; padding-left: 65px;">
            <table width="85%">
                <tr style="padding-bottom:05px;">
                    <td colspan="2">
                        <asp:Label ID="lbl_title" runat="server" CssClass="normalLabel" Font-Size="11pt" Text="<%$Resources:Resource,Select_Master_Format%>"
                            ForeColor="#990000"></asp:Label>
                    </td>
                    <td>
                    <telerik:RadAjaxManager runat="server" ID="ramGrid">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rcbLevel1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rcbLevel1" LoadingPanelID="" />
                        <telerik:AjaxUpdatedControl ControlID="hfid" LoadingPanelID="" />
                        <telerik:AjaxUpdatedControl ControlID="rcbLevel2" LoadingPanelID="loadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="rcbLevel3" LoadingPanelID="" />
                        <telerik:AjaxUpdatedControl ControlID="rcbLevel4" LoadingPanelID="" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rcbLevel2">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rcbLevel2" LoadingPanelID="" />
                        <telerik:AjaxUpdatedControl ControlID="hfid" LoadingPanelID="" />
                        <telerik:AjaxUpdatedControl ControlID="rcbLevel3" LoadingPanelID="loadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="rcbLevel4" LoadingPanelID="" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rcbLevel3">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rcbLevel3" LoadingPanelID="" />
                        <telerik:AjaxUpdatedControl ControlID="hfid" LoadingPanelID="" />
                        <telerik:AjaxUpdatedControl ControlID="rcbLevel4" LoadingPanelID="loadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rcbLevel4">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rcbLevel4" LoadingPanelID="loadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="hfid" LoadingPanelID="" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
            <img alt="Loading..." src='../Images/img/loading3.gif' style="border: 0px;" />
        </telerik:RadAjaxLoadingPanel>
                        <%--<asp:Label ID="lblSelectedmasterformat" Text="<%$Resources:Resource,Selected_Masterformat%>" runat="server" />:--%>
                        <asp:Label ID="lblmasterformat" runat="server" />
                        <asp:HiddenField runat="server" ID="hfmasterid" />
                    </td>
                </tr>
                <tr style="padding-bottom:10px;">
                    <td width="90%">
                        <telerik:RadComboBox ID="rcbLevel1" runat="server" OnSelectedIndexChanged="rcbLevel1_SelectedIndexChanged"
                            AutoPostBack="true" Width="400px">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr style="padding-bottom:10px;">
                    <td width="90%">
                        <telerik:RadComboBox ID="rcbLevel2" runat="server" OnSelectedIndexChanged="rcbLevel2_SelectedIndexChanged"
                            AutoPostBack="true" Width="400px" Enabled="false">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr style="padding-bottom:10px;">
                    <td width="90%">
                        <telerik:RadComboBox ID="rcbLevel3" runat="server" OnSelectedIndexChanged="rcbLevel3_SelectedIndexChanged"
                            AutoPostBack="true" Width="400px" Enabled="false">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr style="padding-bottom:10px;">
                    <td width="90%">
                        <telerik:RadComboBox ID="rcbLevel4" runat="server" AutoPostBack="true" Width="400px"
                            Enabled="false" OnSelectedIndexChanged="rcbLevel4_SelectedIndexChanged">
                        </telerik:RadComboBox>
                        <br />
                        <asp:Label ID="lblErr" runat="server" Style="color: Red; font-size: 11px;"></asp:Label>      
                    </td>
                       <asp:HiddenField runat="server" ID="hfid" />
                        <asp:HiddenField runat="server" ID="hf_masterformat_id" Value="false" />
                </tr>
               
            </table>
        </div>
        
    </div>
</body>
</html>
