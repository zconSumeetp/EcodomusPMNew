<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddEditRequiredAttributes.aspx.cs"
    Inherits="App_Settings_AddEditRequiredAttributes" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">

            function validate() {
                alert("Attribute with this name already exists. Please use another name");
                return false;
            }


            function confirmation() {
                var flag;
                flag = confirm("Are you sure you want to delete this attribute?");
                if (flag)
                    return true;
                else
                    return false;
            }

            function closeWindow() {
                window.parent.refreshgrid();
                window.close();
                return false;
            }
            
        </script>
    </telerik:RadCodeBlock>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
</head>
<body style="margin: 0px 0px 0px 0px; padding-top: 0; background: white;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrmg1" runat="server" EnablePartialRendering="True">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div style="margin: 10px 10px 5px 20px;">
        <h2>
            <asp:Label ID="lbl_omniclass_name" Text=" " runat="server"></asp:Label>
        </h2>
    </div>
    <div style="margin: 10px 10px 5px 20px;">
       
                    <asp:Label ID="lblError" runat="server" Text="" Style="color: Red; font-size: 11px;"
                        Visible="true"></asp:Label>
            
     
    </div>
    <table style="margin: 10px 10px 5px 20px;">
       
        <tr>
            <td>
                <telerik:RadGrid ID="rgAttribute" runat="server" AutoGenerateColumns="False" Skin="Hay"
                    PageSize="5" OnPageIndexChanged="rgAttribute_OnPageIndexChanged" OnPageSizeChanged="rgAttribute_OnPageSizeChanged"
                    OnItemCommand="rgAttribute_OnItemCommand" OnSortCommand="rgAttribute_OnSortCommand"
                    Width="90%" AllowPaging="True" AllowSorting="True" PagerStyle-AlwaysVisible="true">
                    <MasterTableView DataKeyNames="pk_attribute_template_value_id,fk_required_attribute_group_id"
                        ClientDataKeyNames="pk_attribute_template_value_id,fk_required_attribute_group_id">
                        <Columns>
                            <telerik:GridTemplateColumn Visible="false" DataField="pk_attribute_template_value_id"
                                HeaderText="Name" UniqueName="pk_attribute_template_value_id">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkPkattribute_value_id" runat="server" Text='<%# Bind("pk_attribute_template_value_id") %>'
                                        CommandName="SelectTemplate">
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="15%" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="fk_attribute_template_id" HeaderText="fk_attribute_template_id"
                                Visible="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="fk_required_attribute_group_id" HeaderText="fk_required_attribute_group_id"
                                Visible="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AttributeName" HeaderText="<%$Resources:Resource,Attribute_Name%>">
                                <ItemStyle CssClass="column" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Abbreviation" HeaderText="<%$Resources:Resource,Abbreviation%>">
                                <ItemStyle CssClass="column" />
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn DataField="Value" HeaderText="<%$Resources:Resource,Value%>">
                                <ItemStyle CssClass="column" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="UOM" HeaderText="<%$Resources:Resource,UOM%>"
                                Visible="false">
                                <ItemStyle CssClass="column" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="pk_attribute_template_value_id" UniqueName="pk_attribute_template_value_id"
                                HeaderText="<%$Resources:Resource,Edit%>">
                                <ItemStyle CssClass="column" Width="5%" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" runat="server" CausesValidation="false" CommandName="editTemplate"
                                        Text="Edit">
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="pk_attribute_template_value_id" HeaderText="<%$Resources:Resource,Delete%>">
                                <ItemStyle CssClass="column" Width="5%" />
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deleteattributes"
                                        OnClientClick="javascript:return confirmation();" ImageUrl="~/App/Images/Delete.gif" />
                                    <asp:LinkButton ID="lnkDelete" Visible="false" runat="server" CausesValidation="false"
                                        CommandName="deleteTemplate" Text='<%# Bind("pk_attribute_template_value_id") %>'>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
         <tr>
            <td>
                <asp:Label runat="server" ID="lblmsg" Text="" Style="color: Red; font-size: 11px;"></asp:Label>
            </td>
        </tr>
    </table>
    <div style="width: 100%;">
        <table style="margin: 10px 10px 5px 20px;">
            <tr id="traddclose" runat="server">
                <td style="height: 40px">
                    <asp:Button ID="btn_add" runat="server" Text="<%$Resources:Resource,Add%>" Width="80px"
                        OnClick="btn_add_click" />
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="bnt_close" runat="server" Text="<%$Resources:Resource,Close%>" Width="80px"
                        OnClientClick="javascript: return closeWindow();" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="margin: 10px 10px 5px 20px;">
                        <asp:Label ID="Label1" runat="server" Text="" Style="color: Red; font-size: 11px;"></asp:Label>
                    </div>
                </td>
            </tr>
            <tr id="tradd" runat="server">
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblName" CssClass="Label" runat="server" Text="<%$Resources:Resource,Name%>">:</asp:Label>:
                            </td>
                            <td>
                                <asp:TextBox ID="txtaddattribute" CssClass="textbox" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rf_name" ValidationGroup="req" runat="server" ForeColor="Red"
                                    ControlToValidate="txtaddattribute" ErrorMessage="*" Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblAbbreviation" CssClass="Label" runat="server" Text="<%$Resources:Resource,Abbreviation%>">:</asp:Label>:
                            </td>
                            <td>
                                <asp:TextBox ID="txtAbbrivations" CssClass="textbox" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblValue" CssClass="Label" runat="server" Text="<%$Resources:Resource,Value%>">:</asp:Label>:
                            </td>
                            <td>
                                <asp:TextBox ID="txtValue" CssClass="textbox" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td>
                                <asp:Label ID="lblUOM" runat="server" CssClass="Label" Text="<%$Resources:Resource,UOM%>">:</asp:Label>:
                            </td>
                            <td>
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <telerik:RadComboBox ID="cmbox_uom_list" runat="server" CssClass="DropDown" Height="120"
                                            Width="220">
                                        </telerik:RadComboBox>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px">
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 40px; width: 40px">
                                <asp:Button ID="btn_save" runat="server" Text="Save" Width="80px" ValidationGroup="req"
                                    OnClick="btn_Save_click" />
                            </td>
                            <td>
                                <asp:Button ID="btn_cancel" runat="server" Text="Cancel" Width="80px" OnClick="btn_cancel_click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <asp:HiddenField ID="hfattributeid" runat="server" />
            <asp:HiddenField ID="hfattributename" runat="server" />
            <asp:HiddenField ID="hfAbbrivations" runat="server" />
            <asp:HiddenField ID="hf_group_id" runat="server" />
            <asp:HiddenField ID="hf_attribute_name" runat="server" />
        </table>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
      <%--  <AjaxSettings>       
            <telerik:AjaxSetting AjaxControlID="btn_save">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAttribute" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="rad_load_panel" Skin="Hay" runat="server" Width="50px">
    </telerik:RadAjaxLoadingPanel>
    </div>
    </form>
</body>
</html>
