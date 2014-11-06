<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UpdateComponentNames.aspx.cs" Inherits="App.Asset.AppAssetUpdateComponentNames" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<script type="text/javascript" language="javascript">
    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    } 
    function CloseWindow(name) {
        GetRadWindow().close();
        window.parent.refreshgrid(name);
        return false;
    }
    function CloseWindow1() {
        GetRadWindow().close();
        return false;
    }
    function CancelWindow() {
        CloseWindow1();
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
     <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
     <style type="text/css">
    .div_outer  
            {
               overflow:hidden;
                border:1px; 
                height:420px; 
                border-style:solid; 
                border-width:1px;  
                border-color: #808080;
            }
</style>
</head>
<body style="background:#EEEEEE">
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server">
        <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
    </asp:ScriptManager>
    <telerik:RadAjaxManager runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnOk">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UpdateNamePanel" LoadingPanelID="LoadingPanel"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel runat="server" ID="LoadingPanel" Height="75px" Width="75px" Skin="Default"></telerik:RadAjaxLoadingPanel>
    <telerik:RadFormDecorator ID="formdecorator1" runat="server" DecoratedControls="Buttons"
        Skin="Default" />
        <asp:Panel runat="server" ID="UpdateNamePanel">
   <div class="" id="outer_div"  style="height:120px;">
   <table style=" height:20px; padding-left: 10px;">
    <tr>
        <td style="padding-top:03px;"></td>
    </tr>
        <tr style="height:30%; width: 300px;">
        <td>
            <table style="border-spacing: 15px;">
                <tr style="padding-top:20px;">
                    <td>
                        <asp:RadioButton ID="rdbtnUpdateTemplate" OnCheckedChanged="rdbtnUpdateTemplate_checked"
                            GroupName="UpdateNames" runat="server" Text= "<%$Resources:Resource,Use_Attribute_Template%>" Font-Size="10pt"
                            Checked="true" AutoPostBack="True" CssClass="LabelText" />
                    </td>
                    <td>
                        <asp:RadioButton ID="rdbtnUpdateNames" OnCheckedChanged="rdbtnUpdateNames_checked"
                            GroupName="UpdateNames" runat="server" Text="<%$Resources:Resource,Provide_New_Name%>" Font-Size="10pt"
                            AutoPostBack="True" CssClass="LabelText" />
                    </td>
                </tr>
            </table>
            </td>
        </tr>
       
        <tr style="height:30%;padding-top:10px;">
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblName" runat="server" Text="<%$Resources:Resource,Name%>" CssClass="Label">
                            </asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtUpdateName" runat="server" CssClass="textbox"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rf_status" ControlToValidate="txtUpdateName" runat="server"
                                ForeColor="Red" ErrorMessage="*" SetFocusOnError="true" ValidationGroup="validation_group">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
       
        <tr style="height:30%; padding-top:10px;">
            <td>
                <telerik:RadButton ID="btnOk" runat="server" Text="<%$Resources:Resource,Ok%>" Width="60px" OnClick="btnOK_Click" AutoPostBack="True"
                    ValidationGroup="validation_group" style="margin-left:10px;" />
                   
                   
                <asp:Button ID="btnCancel" runat="server" Text="<%$Resources:Resource,Cancel%>" Width="60px" OnClick="btnCancel_Click" style="margin-left:100px;"  />
            </td>
            
        </tr>
    </table>
    </div>
    </asp:Panel>
    </form>
</body>
</html>
