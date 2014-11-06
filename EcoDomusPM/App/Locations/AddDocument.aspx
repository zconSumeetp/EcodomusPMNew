<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddDocument.aspx.cs" Inherits="App_Locations_AddDocument" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    
     
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

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }


        function DocumentGrid() 
        {        
        if (document.getElementById("hdnfrommodel").value == "True") 
            {
                select();
            }
            else {
                var rdw = GetRadWindow();
                rdw.BrowserWindow.regreshgrid();
                rdw.close();
            }
        }

        function confirmation() {
            var flag;
            flag = confirm("Do you want to delete document?");
            if (flag)
                return true;
            else
                return false;
        }
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
        .style1
        {
            width: 305px;
        }
       
    </style>
    <%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
    <%--<link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />--%>
</head>
<body style=" background:#EEEEEE; margin: 0px 0px 0px 0px; padding-top: 0;">
    <form id="Form1" runat="server" method="Post"  defaultfocus="txtName">
    <asp:ScriptManager ID="scrmg1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="formdecorator1" runat="server" DecoratedControls="Buttons,TextArea"
        Skin="Default" />
    <div >
       
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;padding-right:10px;padding-left:10px;">
       
            <tr>
                <td colspan="4">
                    <h5>
                        <asp:Label ID="lblrowname" CssClass="LabelText" runat="server"></asp:Label>
                    </h5>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbl_add_document" runat="server" CssClass="LabelText" Text="<%$Resources:Resource, Add_Document_to%>"></asp:Label>
                </td>
                <td>
                    <telerik:RadComboBox width="180px" tabindex="3" enabled="true" 
                        CausesValidation="false" Filter="Contains" AutoPostBack="true"
                        MarkFirstMatch="true" Height="140px" ID="cmb_sheet_name" runat="server" 
                        onselectedindexchanged="cmb_sheet_name_SelectedIndexChanged" />
                </td>
            </tr>
          
            <tr>
                <td>
                    <%--<asp:Label ID="lbl_Component" CssClass="LabelText" runat="server"></asp:Label>--%>
                    <asp:Label ID="lbl_Component" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,Asset_Name%>" Visible="false">:</asp:Label>
                    <asp:Label ID="lbl_Type_name" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,Type_Name%>" Visible="false">:</asp:Label>
                    <asp:Label ID="lbl_Space_Name" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,Space_Name%>" Visible="false">:</asp:Label>
                    <asp:Label ID="lbl_system_name" CssClass="LabelText" runat="server" Text="<%$Resources:Resource,System%>" Visible="false">:</asp:Label>
                </td>
                <td>
                    <asp:Label ID="lbl_Component_Name" CssClass="LabelText" runat="server"></asp:Label>
                </td>
            </tr>
            
            <tr  style="height: 40px;">
                <td style="width:50%">
                    <asp:Label ID="Label2" CssClass="LabelText" runat="server" Text="<%$Resources:Resource, Name%>">:</asp:Label>:
                </td>
                <td align="left" style="width:50%" >
                    <asp:TextBox ID="txtName" runat="server" Width="170px" CssClass="SmallTextBox" TabIndex="1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="add" runat="server" ForeColor="Red"
                        Display="Dynamic" ControlToValidate="txtName" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr style="height: 50px;">
                <td>
                    <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, Category%>"></asp:Label>:
                    </td>
                <td align="left">
                    <asp:Label CssClass="LabelText" ID="lblcategory" runat="server"></asp:Label>
                    <telerik:RadComboBox Width="180px" TabIndex="3" CausesValidation="false" Filter="Contains"
                        MarkFirstMatch="true" Height="140px" ID="rcbcategory" runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="add" InitialValue="--Select--"
                     runat="server" SetFocusOnError="true" ForeColor="Red" Display="Dynamic" 
                     ControlToValidate="rcbcategory" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr style="height: 50px;">
                <td>
                    <asp:Label CssClass="LabelText" ID="Label4" runat="server" Text="<%$Resources:Resource, Stage%>"></asp:Label>:
                    </td>
                <td align="left">
                    <asp:Label CssClass="LabelText" ID="lblstage" runat="server"></asp:Label>
                    <telerik:RadComboBox Width="180px" TabIndex="3" CausesValidation="false" Filter="Contains"
                        MarkFirstMatch="true" Height="140px" ID="rcbstage" runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" InitialValue="--Select--" ValidationGroup="add" 
                    runat="server" SetFocusOnError="true" ForeColor="Red" Display="Dynamic" ControlToValidate="rcbstage" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr style="height: 50px;">
                <td>
                    <asp:Label CssClass="LabelText" ID="Label5" runat="server" Text="<%$Resources:Resource,  Approval_By%>"></asp:Label>:
                    </td>
                <td align="left">
                    <asp:Label CssClass="LabelText" ID="Label1" runat="server"></asp:Label>
                    <telerik:RadComboBox Width="180px" TabIndex="3" CausesValidation="false" Filter="Contains"
                        MarkFirstMatch="true" Height="100px" ID="rcbapprovalby" runat="server" />
                    <asp:RequiredFieldValidator ValidationGroup="add" InitialValue="--Select--" ID="RequiredFieldValidator4" 
                    SetFocusOnError="true" Display="Dynamic" runat="server" ForeColor="Red"
                      ControlToValidate="rcbapprovalby" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td>
                    <asp:Label CssClass="LabelText" ID="Label6" runat="server" Text="<%$Resources:Resource,   Upload_File%>"></asp:Label>:
                </td>
                <td align="left">
                    <telerik:RadUpload TabIndex="6" EnableFileInputSkinning="false" ID="ruDocument" runat="server" 
                        InitialFileInputsCount="1" OverwriteExistingFiles="false"  ControlObjectsVisibility="none">
                    </telerik:RadUpload>
                    <asp:Label ID="lbl_document_path" runat="server" Visible="false"></asp:Label>
                    <asp:HiddenField ID="hfAttachedFile" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:Label ID="lblError" CssClass="linkText" runat="server" Style="color: Red;"></asp:Label>
                </td>
            </tr>
            
            <tr>
                
                <td style="padding-top: 0px; margin-left: 200px;" colspan="2">
                    <asp:Button ID="BtnDocSave" ValidationGroup="add" runat="server" TabIndex="7" Text="<%$Resources:Resource, Save_Document%>"
                        Width="100px" OnClick="btnDocSave_Click" />&nbsp;&nbsp;
                    <asp:Button ID="btnDocCancle" runat="server" TabIndex="8" Text="<%$Resources:Resource, Cancel%>"
                        Visible="false" OnClientClick="javascript:return closeWindow();" Width="100px"
                         />
                    <asp:Button ID="btnWindowClose" runat="server" TabIndex="9" Text="<%$Resources:Resource, Cancel%>"
                        Width="100px" OnClientClick="javascript:return closeWindow();" CausesValidation="false" />

                    <asp:Button ID="btn_delete" runat="server" TabIndex="9" Text="<%$Resources:Resource, Delete%>" OnClick="btn_delete_Click"
                        Width="100px" OnClientClick="javascript:return confirmation();" CausesValidation="false" />
                </td>
            </tr>
            <tr style="height: 05px;">
                <td colspan="4">
                    <asp:Label ID="lblMsg" CssClass="linkText" runat="server" ForeColor="red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:HiddenField ID="hf_document_id" runat="server" />
                    <asp:HiddenField ID="hdnfrommodel" runat="server" />

                     <asp:HiddenField ID="hf_type_id" runat="server" />
                    <asp:HiddenField ID="hf_asset_id" runat="server" />
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
