<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddRequiredAttributes.aspx.cs"
    Inherits="App_Settings_AddRequiredAttributes" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="../UserControls/PropertyValueControl/PropertyValueControl.ascx" TagName="PropertyValueControl" TagPrefix="uc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script language="javascript" type="text/javascript">
        
        function closeWindow() {
            try {
                // debugger
                //window.parent.refreshgrid();
                var ownd = GetRadWindow();
                ownd.BrowserWindow.refreshgrid();
                ownd.close();
                //window.opener.location.reload(true);
                return false;
            }
            catch (e) {
                throw e;
            }
        }
        function LogoutNavigation() {
            var query = parent.location.href;
            top.location.href(query);
        }
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        function adjust_height() {

            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                //alert(x);
                //alert(y);
                wnd.moveTo(x - 40, 120);
                //alert('window page' + document.body.scrollHeight);
                wnd.set_height(document.body.scrollHeight + 25);
                // alert('window page' + document.body.offsetWidth);
                wnd.set_width(document.body.scrollWidth + 15);
            }

        }
        //window.onload = adjust_height;

        //$(window).load(function () {
        //});

        window.onload = function() {
            adjust_height();
        }

    </script>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <style type="text/css">
        .style1
        {
            width: 18px;
        }
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
</head>
<body style="margin: 0px 0px 0px 0px; padding-top: 0; background: #EEEEEE;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrmg1" runat="server" EnablePartialRendering="true" AsyncPostBackTimeout="360000">
         <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
    </asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxPanel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadAjaxPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            </AjaxSettings>
             <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadComboBoxAttributeType">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PropertyValueControl" LoadingPanelID="LaodingPanel1" UpdatePanelHeight="100%"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        
        
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <%--<telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel1" LoadingPanelID="RadAjaxLoadingPanel1" Width="100%">  --%>
    <telerik:RadAjaxLoadingPanel runat="server" ID="LaodingPanel1"></telerik:RadAjaxLoadingPanel>
    <div style="padding-left: 0px; width: 100%; background-color: #EEEEEE; border: 2px">
        <table width="100%">
            <tr style="display:none">
                <td class="wizardHeadImage">
                    <div class="wizardLeftImage">
                        <asp:Label ID="Label2" runat="server" Font-Size="10pt" Text="<%$Resources:Resource,Add_Required_Attributes%>"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClientClick="javascript:return closeWindow();" OnClick="ibtn_close_Click" Style="height: 16px" />
                    </div>
                </td>
            </tr>
        </table>
        <div id="divAdd" style="margin-left: 5px; margin-top: 3px; display: block;" runat="server">
            <table cellspacing="3" style="margin: 0px 20px 0px 20px; width: 50%">
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <h2>
                                        <asp:Label ID="lblnamegroup" runat="server" Text="<%$Resources:Resource,group_name%>"></asp:Label>:
                                    </h2>
                                </td>
                                <td>
                                    <h2>
                                        <asp:Label ID="lblGroupName" runat="server" Text=""></asp:Label>
                                    </h2>
                                </td>
                    </tr></table> </td>
                </tr>
            </table>
            <table cellspacing="3" style="margin: 0px 20px 0px 20px; width: 50%">
             
                <tr>
                    <td style="width: 15%;">
                        <asp:Label ID="lblName" runat="server" Text="<%$Resources:Resource,Name%>" CssClass="Label">:</asp:Label>:
                    </td>
                    <td style="width: 40%;">
                        <asp:TextBox ID="txtaddattribute" CausesValidation="true" CssClass="textbox" runat="server"
                            Width="167px" Height="21px"></asp:TextBox>
                       
                       </td>
                       <td> <asp:RequiredFieldValidator ID="Reaquirefield1" ValidationGroup="req" runat="server"
                            ControlToValidate="txtaddattribute" ErrorMessage="*" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblAbbreviation" runat="server" Text="<%$Resources:Resource,Abbreviation%>"
                            CssClass="Label">:</asp:Label>:
                    </td>
                    <td>
                        <asp:TextBox ID="txtAbbrivations" CausesValidation="true" runat="server" Width="168px"
                            Height="21px" CssClass="textbox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblValue" runat="server" Text="<%$Resources:Resource,Value%>" CssClass="Label">:</asp:Label>:
                    </td>
                    <td>
                        <%--<asp:TextBox ID="txtValue" CausesValidation="true" runat="server" Width="168px" Height="21px"
                            CssClass="textbox"></asp:TextBox>--%>
                            <div style="margin-left: 1px;">
                        <uc:PropertyValueControl ID="PropertyValueControl" runat="server" ControlsWidth="168px" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Type%>" CssClass="Label">:</asp:Label>:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="RadComboBoxAttributeType" runat="server" Height="100" CssClass="DropDown" OnSelectedIndexChanged="RadComboBoxAttributeType_OnSelectedIndexChanged"
                            Width="168" OnItemDataBound="RadComboBoxAttributeType_OnItemDataBound" AutoPostBack="True">
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
        </div>
        <table style="margin: 0px 10px 5px 50px; width: 20%">
            <tr>
                <%-- <td  align="left">
                <asp:Button ID="btnAdd" Text=" Add " Width="100"  runat="server" OnClick="btnAdd_Click" />
            </td>
                --%>
                <td id="tdSave" runat="server" align="left">
                    <asp:Button ID="btnSave" Text="<%$Resources:Resource,Save%>" ValidationGroup="req"
                        Width="100" runat="server" OnClick="btnSave_Click" />
                </td>
                <td align="left">
                    <asp:Button ID="btnclose" Width="100" OnClientClick="javascript:return closeWindow()"
                        Text="<%$Resources:Resource,Close%>" runat="server" OnClick="btnclose_Click" />
                </td>
            </tr>
        </table>
        <table style="margin: 10px 50px 5px 50px;">
            <tr>
                <td style="height: 20px" colspan="2">
                    <asp:Label ID="lblMsgSuccess" runat="server" Visible="false" Style="color: Black;"
                        Font-Size="10pt"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblError" runat="server" Visible="false" Style="color: Red; font-size: 11px;"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="LabelText"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:HiddenField ID="hfPkRequiredAttributeTemplateValueId" runat="server" />
                    <asp:HiddenField ID="hf_attribute_value_id" runat="server" />
                    <asp:HiddenField ID="hf_attribute_id" runat="server" />
                    <asp:HiddenField ID="HiddenFieldDispalUnitType" runat="server" />
                </td>
                <td>
                    <asp:HiddenField ID="hfdscnt" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <%--</telerik:RadAjaxPanel>--%>
    </form>
</body>
</html>
