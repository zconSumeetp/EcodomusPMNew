<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddComponentDocument.aspx.cs" Inherits="App_Reports_AddComponentDocument" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <script language="javascript" type="text/javascript">
        function select() {
            window.opener.bindgrid();
            closeWindow();
        }

        function closeWindow() {
            //window.opener.refreshgrid();
            window.close();
            return false;
        }
        function ShowConfirm() {
            var answer = confirm("Are you sure you want to delete this Document?");
            if (answer) {
                __doPostBack('imgbtnDelete', '')
            }
            else
                return false;

        }
        function restoreScr() {
            window.opener.blur();
            window.focus();
        }

        function Hidetable() {
            document.getElementById("tbleitdocument").style.display = "none";
            return false;

        }
    </script>

    <link href="../../App_Themes/EcoDomus/style_new_1.css"  rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style3
        {
            width: 162px;
        }
        .style8
        {
            width: 153px;
        }
    </style>
</head>
<body style="margin: 10px 0px 0px 40px; padding-top: 0; background: white;" onload="restoreScr();">
    <form id="Form1" runat="server" method="Post" style="margin: 0px 0px 0px 0px; padding-top: 0;">
    <asp:ScriptManager ID="scrmg1" runat="server">
    </asp:ScriptManager>
    <telerik:radformdecorator id="formdecorator1" runat="server" decoratedcontrols="Buttons"
        skin="Default" />
    <div style="margin-left: 20px">
        <h2>
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </h2>
    </div>
    <div>
        <table style="margin: 10 20 20 20 width: 85%;">
            <tr>
                <td>
                    <telerik:radgrid id="rgDocument" runat="server" borderwidth="1px" cellpadding="0"
                        allowpaging="true" pagesize="5" autogeneratecolumns="False" allowsorting="True"
                        OnPageIndexChanged="rgDocument_OnPageIndexChanged" OnPageSizeChanged="rgDocument_OnPageSizeChanged"
                        OnItemCommand="rgDocument_OnItemCommand" OnSortCommand="rgDocument_OnSortCommand"
                         pagerstyle-alwaysvisible="true"
                        width="626px">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" />
                        <MasterTableView DataKeyNames="id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="id" HeaderText="id" UniqueName="id" Visible="false">
                                    <ItemStyle CssClass="column" Width="50px" />
                                </telerik:GridBoundColumn>
                              
                                <telerik:GridBoundColumn DataField="Name" HeaderText="Name" SortExpression="Name">
                                    <ItemStyle CssClass="column" Width="250px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Category" HeaderText="Category" SortExpression="Category">
                                    <ItemStyle CssClass="column" Width="250px" />
                                </telerik:GridBoundColumn>
                           
                                <telerik:GridBoundColumn DataField="FILE" HeaderText="File">
                                    <ItemStyle CssClass="column" Width="250px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn Visible="false" DataField="file_path">
                                    <ItemStyle CssClass="column" Width="225px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="id" UniqueName="id">
                                    <ItemStyle CssClass="column" Width="5%" />
                                    <ItemTemplate>
                                        <asp:LinkButton Text="Edit" ID="lnkEdit" CausesValidation="false" runat="server"
                                            CommandName="editDocument"></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="id" UniqueName="id">
                                    <ItemStyle CssClass="column" Width="5%" />
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CausesValidation="false"
                                             CommandName="deleteDocument" ImageUrl="~/App/Images/Delete.gif" OnClientClick ="javascript:return ShowConfirm();" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                        <AlternatingItemStyle CssClass="alternateColor" />
                        <ClientSettings>
                            <Selecting AllowRowSelect="True" />
                            <ClientEvents />
                        </ClientSettings>
                    </telerik:radgrid>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnadddocument" Text="Add" runat="server" 
                        onclick="btnadddocument_Click" />
                    &nbsp;
                    <asp:Button ID="btnclosepopup" Text="Close" OnClientClick="javascript:return closeWindow()"
                        runat="server" />
                </td>
            </tr>
        </table>
        <table id="tbleitdocument" runat="server" style="margin: 30 0 0 20; width: 100%;">
            <tr>
                <th align="left">
                    Name<span id="spanName" runat="server" style="color: red">*</span>:
                </th>
                <td align="left" style="padding-top: 5px">
                    <asp:TextBox ID="txtName" runat="server" CssClass="SmallTextBox" TabIndex="1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="add" runat="server"
                        ControlToValidate="txtName" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <th align="left" style="width: 315px">
                    Directory Name<span id="spanDirName" runat="server" style="color: red">*</span>:
                </th>
                <td align="left" style="width: 200px">
                    <asp:TextBox ID="txtDirName" runat="server" CssClass="SmallTextBox" TabIndex="2">Document</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="add" runat="server"
                        ControlToValidate="txtDirName" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <th align="left">
                    Category<span id="span2" runat="server" style="color: red">*</span>:
                </th>
                <td align="left" style="padding-top: 20px">
                    <asp:Label ID="lblcategory" runat="server"></asp:Label>
                    <telerik:radcombobox width="190px" tabindex="3" causesvalidation="false" filter="Contains"
                        markfirstmatch="true" height="140px" id="rcbcategory" runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="add" runat="server"
                        ControlToValidate="rcbcategory" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <th align="left" class="style8">
                    Stage<span id="span5" runat="server" style="color: red">*</span>:
                </th>
                <td align="left">
                    <asp:Label ID="lblStage" runat="server"></asp:Label>
                    <telerik:radcombobox tabindex="4" causesvalidation="false" markfirstmatch="true"
                        height="140px" id="radStage" runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="add" runat="server"
                        ControlToValidate="radStage" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <th align="left">
                    Approval By<span id="span3" runat="server" style="color: red">*</span>:
                </th>
                <td align="left">
                    <asp:Label ID="lblapprovalby" runat="server"></asp:Label>
                    <telerik:radcombobox tabindex="5" causesvalidation="false" markfirstmatch="true"
                        height="140px" id="rcbapprovalby" runat="server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" InitialValue="--Select--"
                        ValidationGroup="add" runat="server" ControlToValidate="rcbapprovalby" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <th align="left" class="style8">
                    Upload File:
                </th>
                <td align="left">
                    <telerik:radupload tabindex="6" enablefileinputskinning="false" id="ruDocument" runat="server"
                        initialfileinputscount="1" overwriteexistingfiles="false" controlobjectsvisibility="none">
                    </telerik:radupload>
                    <asp:HiddenField ID="hfAttachedFile" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:Label ID="lblError" CssClass="linkText" runat="server" Style="color: Red;"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style3">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td valign="top" style="padding-top: 0px;" colspan="4">
                    <asp:Button ID="BtnDocSave" ValidationGroup="add" runat="server" TabIndex="7" Text="Save Document"
                        Width="100px" onclick="BtnDocSave_Click" />&nbsp;&nbsp;
                    <asp:Button ID="btnDocCancle" runat="server" TabIndex="8" Text="Cancel" Width="100px"
                        OnClientClick="javascript:return Hidetable();" CausesValidation="false" />
                    <asp:HiddenField ID="hfdocument_id" runat="server" />
                    <asp:HiddenField ID="hfid" runat="server" />
                    <asp:HiddenField ID="hdcompdoctype" runat="server" />
                    <asp:HiddenField ID="hffilename" runat="server" />
                </td>
            </tr>
            <tr style="height: 20px;">
                <td colspan="4">
                    <asp:Label ID="lblMsg" CssClass="linkText" runat="server" ForeColor="red"></asp:Label>
                </td>
            </tr>
        </table>
       <%-- <telerik:RadAjaxManager SkinID="Gray" ID="ramProjects" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="BtnDocSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgDocument" LoadingPanelID="alp" />
                </UpdatedControls>
            </telerik:AjaxSetting> 
        </AjaxSettings>
    </telerik:RadAjaxManager>
    
    <telerik:RadAjaxLoadingPanel Skin="Forest" ID="alp" runat="server" InitialDelayTime="0">
    </telerik:RadAjaxLoadingPanel>--%>
    </div>
    </form>
</body>
</html>
