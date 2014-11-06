<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UpdateTypeNames.aspx.cs" Inherits="App_Asset_UpdateTypeNames" %>

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
        window.parent.refreshgrid_new(name);
        return false;
    }
  
    function CloseWindow1() {

        // GetRadWindow().BrowserWindow.referesh_project_page();
        GetRadWindow().close();
        //top.location.reload();
        //GetRadWindow().BrowserWindow.adjust_parent_height();
        return false;
    }
    function CancelWindow() {
        CloseWindow1();
    }

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Update Type Name</title>
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
     <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />

     
<style type="text/css">
    .div_outer  
            {
                                overflow:hidden;
                border:1; 
                height:420px; 
                border-style:solid; 
                border-width:1px;  
                border-color: #808080;
            }
</style>
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
       
    </style>
</head>
<body style="background:#EEEEEE">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrmg1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="formdecorator1" runat="server" DecoratedControls="Buttons"
        Skin="Default" />
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
                <asp:Button ID="btnOk" runat="server" Text="<%$Resources:Resource,Ok%>" Width="60px" OnClick="btnOK_Click"
                    ValidationGroup="validation_group" style="margin-left:10px;" />
                   
                   
                <asp:Button ID="btnCancel" runat="server" Text="<%$Resources:Resource,Cancel%>" Width="60px" OnClick="btnCancel_Click" style="margin-left:100px;"  />
            </td>
            
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
