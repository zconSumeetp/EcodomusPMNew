<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddEditDocument.aspx.cs"
    Inherits="App_Settings_AddEditDocument" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <head id="Head1" runat="server">
        <title>EcoDomus PM: Add Edit Document</title>
        <telerik:RadCodeBlock runat="server" ID="id1">
            <script type="text/javascript" language="javascript">

                function CloseWindow() {
                    window.parent.refreshgrid();
                    window.close();
                    return false;
                }

                function ShowConfirm() {
                    var ans = confirm("Are you sure you want to delete this document?");
                    if (ans) {
                        __doPostBack('imgbtnDelete', '')
                    }
                    else
                        return false;
                }
                function LogoutNavigation() {
                    var query = parent.location.href;
                    top.location.href(query);
                }

                function refresh_page() {
                    return false;
                }

                function validate() {
                    alert("Document already exists.\nPlease select another document");
                    return false;
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
                        wnd.set_height(document.body.scrollHeight + 45)
                        // alert('window page' + document.body.offsetWidth);
                        wnd.set_width(document.body.scrollWidth + 35)
                    }

                }
                window.onload = adjust_height;


            </script>
        </telerik:RadCodeBlock>
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
        <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    </head>
    <body style="margin: 0px 0px 0px 0px; padding-top: 0; background: #EEEEEE">
        <form id="form1" runat="server">
        <asp:ScriptManager ID="scrpt_manager" runat="server">
        </asp:ScriptManager>
        <telerik:RadFormDecorator ID="formdecorator1" runat="server" DecoratedControls="Buttons,Scrollbars"
            Skin="Default"></telerik:RadFormDecorator>
        <div style="padding-left: 0px; width: 100%; background-color: #EEEEEE; border: 2px">
            <table width="100%">
                <tr style="display:none">
                    <td class="wizardHeadImage">
                        <div class="wizardLeftImage">
                            <asp:Label ID="Label1" runat="server" Font-Size="10pt" Text="<%$Resources:Resource,Add_Edit_Document%>">
                            </asp:Label>
                        </div>
                        <div class="wizardRightImage">
                            <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                OnClientClick="javascript:return CloseWindow();" OnClick="ibtn_close_Click" Style="height: 16px" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="height: 20px;">
                    </td>
                </tr>
                <tr>
                    <td align="center" style="padding-left: 40px;">
                        <h2>
                            <asp:Label ID="lbldoc" runat="server"></asp:Label>
                        </h2>
                    </td>
                </tr>
                <tr>
                    <td style="height: 10px;">
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 40px;">
                        <asp:Label id="lbl_type" runat="server" Text="<%$Resources:Resource,Type%>" CssClass="Label">:</asp:Label>:
                        <telerik:RadComboBox ID="cmb_type" runat="server" Height="90" Width="180" AutoPostBack="true" OnSelectedIndexChanged="cmb_type_OnSelectedIndexChanged">
                        </telerik:RadComboBox>
                        <asp:RequiredFieldValidator ID="rf_status" ControlToValidate="cmb_type" runat="server"
                            InitialValue="--Select--" ForeColor="Red" ErrorMessage="*" SetFocusOnError="true"
                            ValidationGroup="validation_group">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 40px;">
                        <table>
                            <tr>
                                <td style="height: 10px;">
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 35px;">
                                    <asp:Button ID="btnAddedit" Text="<%$Resources:Resource,Save%>" runat="server" OnClick="btnAddedit_Click"
                                        width="60px" ValidationGroup="validation_group" />
                                </td>
                                <td style="padding-left: 10px;">
                                    <asp:Button ID="btnClose" OnClientClick="javascript: return CloseWindow();" width="60px"
                                        Text="<%$Resources:Resource,Close%>" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblerror" runat="server" ForeColor="red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 5px;">
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 40px;">
                        <telerik:RadGrid ID="rgdocument" runat="server" BorderWidth="1px" CellPadding="0"
                            AutoGenerateColumns="False" ClientSettings-Selecting-AllowRowSelect="true" AllowPaging="true"
                            PageSize="5" OnItemCommand="rgdocument_ItemCommand" Skin="Default" AllowSorting="True"
                            Width="90%" PagerStyle-AlwaysVisible="true" OnPageIndexChanged="rgdocument_PageIndexChanged"
                            OnPageSizeChanged="rgdocument_PageSizeChanged" OnSortCommand="rgdocument_SortCommand">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                            <MasterTableView DataKeyNames="pk_required_document_id" ClientDataKeyNames="pk_required_document_id">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="pk_required_document_id" HeaderText="pk_required_document_id"
                                        Visible="false">
                                        <ItemStyle CssClass="column" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="document_type_name" HeaderText="<%$Resources:Resource,Type%>">
                                       <%-- <ItemStyle CssClass="column" />--%>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="document_for" HeaderText="<%$Resources:Resource,Category%>">
                                        <%--<ItemStyle CssClass="column" />--%>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="pk_required_document_id" UniqueName="pk_required_document_id_delete"
                                        HeaderText="<%$Resources:Resource,Delete%>">
                                        <%--<ItemStyle CssClass="column" Width="5%" />--%>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deletedocument"
                                                OnClientClick="javascript:return ShowConfirm();" ImageUrl="~/App/Images/Delete.gif" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings>
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <AlternatingItemStyle CssClass="alternateColor" />
                        </telerik:RadGrid>
                    </td>
                </tr>
            </table>
        </div>
        </form>
    </body>
</html>
