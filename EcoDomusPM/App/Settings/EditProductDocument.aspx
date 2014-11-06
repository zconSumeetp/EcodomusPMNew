<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditProductDocument.aspx.cs" Inherits="App_Locations_AddDocument" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
    <title>EcoDomus PM : Edit Document </title>
       <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
<link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
   
    <script type="text/javascript" language="javascript">
        function setFocus() {
            if (document.getElementById("<%=txtName.ClientID %>") != null)
                document.getElementById("<%=txtName.ClientID %>").focus();

        }
        window.onload = setFocus;
</script>
    <script language="javascript" type="text/javascript">
        function select() {
            if (document.getElementById("hdnfrommodel").value == "True") {
                window.opener.document.getElementById('btn_properties').click();
                closeWindow();
            }
            else {
                window.opener.regreshgrid();
                closeWindow();
            }
        }

        
        function closeWindow() {
            window.close();
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

        function ColseAfterSave() {
            var rdw = GetRadWindow();
            rdw.BrowserWindow.location.reload();
            rdw.close();
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }


//        function DocumentGrid() 
//        {        
//        if (document.getElementById("hdnfrommodel").value == "True") 
//            {
//                select();
//            }
//            else {
//                var rdw = GetRadWindow();
//                rdw.BrowserWindow.regreshgrid();
//                rdw.close();
//            }
//        }

//        function confirmation() {
//            var flag;
//            flag = confirm("Do you want to delete document?");
//            if (flag)
//                return true;
//            else
//                return false;
//        }
        function onClientProgressBarUpdating(progressArea, args) {
        
            progressArea.updateVerticalProgressBar(args.get_progressBarElement(), args.get_progressValue());
            args.set_cancel(true);
        }
        function Validation() {

            alert('please select component with name ');
            window.close();
            
        }
    
    </script>
    <style type="text/css">

        html
        {
            overflow:hidden;
        }
        .style8
        {
            width: 200px;
        }
        .style9
        {
            width: 200px;
            text-align: right;
        }
        .style10
        {
            width: 200px;
            text-align: right;
            height: 40px;
        }
        .style11
        {
            width: 0px;
            height: 40px;
        }
        .style13
        {
            height: 40px;
        }
    </style>
</head>
<body style="margin: 0px 0px 0px 0px; padding-top: 0;">
    <form id="Form1" runat="server" method="Post" style="margin: 0px 0px 0px 0px; padding-top: 0;border-color:Black;border-width:2px; background: white;" defaultfocus="txtName">
    <asp:ScriptManager ID="scrmg1" runat="server">
    </asp:ScriptManager>
        <telerik:RadFormDecorator ID="formdecorator1" runat="server" DecoratedControls="Buttons"
        Skin="Default" />
    <div >
       <table>
       <tr>
        <td colspan="2">
             <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse">
        <tr>
            <td class="wizardHeadImage" style="width:100%;">
                <div class="wizardLeftImage" >
                   <%-- <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />--%>
                    <asp:Label ID="Label1" Text="Edit Document" style="font-size:medium ;" runat="server"></asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                         OnClientClick="javascript:return CancelWindow();" />
                </div>
            </td>
        </tr>
    </table>
       </td>
       </tr>
                     <tr>
                        <td colspan="2">
                    <h2>
                        <asp:Label ID="lblProduct" runat="server"></asp:Label>
                    </h2>
                </td>
            </tr>
                        <tr>
                            <th class="style10">
                                Name<span id="spanName" runat="server" style="color: red"></span>:
                            </th>
                            <td align="left" class="style11">
                                <asp:TextBox ID="txtName" runat="server" CssClass="SmallTextBox" TabIndex="1"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="add" runat="server" ForeColor="Red"
                                    ControlToValidate="txtName" ErrorMessage="*"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <th class="style10">
                                Description:<span id="span3" runat="server" style="color: red"></span>
                            </th>
                            <td class="style13">
                                <asp:TextBox ID="txtdescription" runat="server" CssClass="SmallTextBox" TabIndex="1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th class="style10">
                                Category<span id="span2" runat="server" style="color: red"></span>:
                            </th>
                            <td align="left" class="style13">
                                <asp:Label ID="lblcategory" runat="server"></asp:Label>
                                <telerik:RadComboBox Width="180px" TabIndex="3" ErrorMessage="*" CausesValidation="true" 
                                    Filter="Contains" MarkFirstMatch="true" Height="140px" ID="rcbcategory" ValidationGroup="add"
                                    runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="add" runat="server" ForeColor="Red"
                                    ControlToValidate="rcbcategory" InitialValue=" --Select--" ErrorMessage="*"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr style="height: 30px;">
                            <th class="style9">
                                Upload File:
                            </th>
                            <td align="left">
                                <telerik:RadUpload TabIndex="6" EnableFileInputSkinning="false" ID="ruDocument" runat="server"
                                    InitialFileInputsCount="1" OverwriteExistingFiles="false" ControlObjectsVisibility="none">
                                </telerik:RadUpload>
                                <asp:HiddenField ID="hfAttachedFile" runat="server" />
                            </td>
                        </tr>
                        <tr style="height: 30px;">
                            <th class="style9">
                                &nbsp;</th>
                            <td align="left">
                                <asp:Button ID="BtnDocSave" ValidationGroup="add" runat="server" TabIndex="7" Text="Save Document"
                                    OnClick="btnDocSave_Click" Width="100px" />&nbsp;&nbsp;
                                     <asp:Button ID="btnRadCancel" ValidationGroup="add" runat="server" TabIndex="8" Text="Cancel"
                                     OnClientClick="javascript:return CancelWindow();" Width="100px" />
                              </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblError" CssClass="linkText" runat="server" Style="color: Red;"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style8">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="padding-top: 0px;" colspan="2">
                                &nbsp;&nbsp;
                                
                                <asp:HiddenField ID="hfrowname" runat="server" />
                                <asp:HiddenField ID="hfid" runat="server" />
                                <asp:HiddenField ID="hdfsheetname" runat="server" />
                                <asp:HiddenField ID="hfDocumentId" runat="server" />
                            </td>
                        </tr>
             
                        <tr style="height: 20px;">
                            <td colspan="2">
                                <asp:Label ID="lblMsg" CssClass="linkText" runat="server" ForeColor="red"></asp:Label>
                            </td>
                        </tr>
                
        </table>
        <table style="margin-top: 10px; margin-left: 50px;">
                 <tr>
                 <td style="width: 50%; vertical-align: top;">
                        <telerik:RadProgressManager ID="Radprogressmanager1" runat="server" />
                        <telerik:RadProgressArea ID="rpaImportLocation" runat="server" 
                            Localization-TotalFiles="1" Skin="Default"
                            OnClientProgressBarUpdating="onClientProgressBarUpdating" 
                            ProgressIndicators="TotalProgressBar, TotalProgress, TotalProgressPercent, RequestSize, FilesCountPercent, SelectedFilesCount, CurrentFileName, TimeElapsed, TimeEstimated, TransferSpeed">
                        </telerik:RadProgressArea>
                    </td>
                 </tr>
            </table>
    </div>
    </form>
</body>
</html>
