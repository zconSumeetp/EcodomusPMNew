<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCAttributeGroup.ascx.cs"
    Inherits="App_UserControls_UCAttributeGroup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<telerik:RadCodeBlock runat="server" ID="rdb1">
    <script type="text/javascript">
        //        function setFocus() {
        //        

        //        }
        //        window.onload = setFocus;

        function chkselect() {

            alert("Please select Group");
            return false;


        }
        function deleteItem() {
            var flag;
            flag = confirm("Are you sure you want to delete this Template?");
            return flag;
        }
        function fn_Clear() {

            try {
                document.getElementById("~/App/UserControls/UCAttributeGroup.ascxAttributeGroup_txtSearch").value = "";
                return false;
            }
            catch (e) {
                alert(e.message + "  " + e.Number);
                return false;
            }
        }
        function LogoutNavigation() {
            var query = parent.location.href;
            top.location.href(query);
        }
        window.onload = adjust_height;
        function validatecontrol() {
            if (document.getElementById("~/App/UserControls/UCAttributeGroup.ascxAttributeGroup_txtAttributeGroupName").value == "") {
                document.getElementById("~/App/UserControls/UCAttributeGroup.ascxAttributeGroup_lblError").innerText = "*";
                return false;
            }
            else {
                document.getElementById("~/App/UserControls/UCAttributeGroup.ascxAttributeGroup_lblError").innerText = "";
                return true;
            }
            
        }
    </script>
    <style type="text/css">
        .disableLinkButton
        {
            color: #D2CFCF;
            font-family: "Arial";
            font-size: 10px;
            text-decoration: none;
        }
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
</telerik:RadCodeBlock>
<link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
<div style="padding-left: 0px; margin: 0px 0px 20px 0px; width: 100%">
    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="padding-left: 10px;padding-right: 10px;">
      
        <tr >
            <td align="right">
                <asp:Panel ID="panel1" runat="server" DefaultButton="btn_search">
                    <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                        <tr>
                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                <asp:Label runat="server" Text="<%$Resources:Resource, Attribute_Group%>" ID="lbl_grid_head"
                                    CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Font-Names="Arial"
                                    Font-Size="12"></asp:Label>
                            </td>
                            <td align="right">
                                <div id="div_search" style="background-color: White; width: 170px;">
                                    <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                        width: 100%;">
                                        <tr style="border-spacing=0px;">
                                            <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                padding-bottom: 0px;">
                                                <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                    Height="100%" EmptyMessage="Search" BorderColor="White" ID="txt_search" Width="100%">
                                                </telerik:RadTextBox>
                                            </td>
                                            <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                padding-bottom: 0px;">
                                                <asp:ImageButton ClientIDMode="Static" OnClick="OnClick_BtnSearch" ID="btn_search"
                                                    Height="13px" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                            <td align="center" style="padding-right:05px" class="dropDownImage">
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td height="1px" style="background-color: Orange; border-collapse: collapse; width: 70%">
            </td>
        </tr>
        <tr>
            <td>
                <fieldset style="border-style: solid; margin: 0px; border-left-color: #DCDCDC; border-top-color: #DCDCDC;
                    border-top-width: 0px; border-left-width: 1px; border-bottom-width: 1px; border-right-width: 1px;
                    border-bottom-color: #A0A0A0; border-right-color: #B4B4B4;">
                    <telerik:RadGrid runat="server" ID="rg_attribute_group" BorderWidth="1px" AllowPaging="true"
                        PageSize="10" AutoGenerateColumns="False" AllowSorting="True" PagerStyle-AlwaysVisible="true"
                        Visible="true" Skin="Default" Width="100%" OnSortCommand="rg_attribute_group_SortCommand"
                        OnItemCommand="rg_attribute_group_OnItemCommand" OnPageIndexChanged="rg_attribute_group_PageIndexChanged"
                        OnPageSizeChanged="rg_attribute_group_PageSizeChanged" AllowMultiRowSelection="false">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="50%" AlwaysVisible="true" />
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                            <Resizing AllowColumnResize="false" />
                            <Scrolling AllowScroll="true" ScrollHeight="282" UseStaticHeaders="true" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="pk_required_attribute_group_id,group_name" ClientDataKeyNames="pk_required_attribute_group_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_required_attribute_group_id" HeaderText="pk_required_attribute_group_id"
                                    Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridClientSelectColumn>
                                    <ItemStyle Width="10%" />
                                    <HeaderStyle Width="10%" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="group_name" Resizable="false" HeaderStyle-Width="3%"
                                    HeaderText="<%$Resources:Resource,Attribute_Group_Name%>" UniqueName="group_name"
                                    SortExpression="group_name">
                                    <ItemStyle CssClass="column" Width="70%" HorizontalAlign="Left" />
                                    <HeaderStyle Width="70%" HorizontalAlign="Left" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="pk_required_attribute_group_id" HeaderText="<%$resources:resource,edit%>"
                                    UniqueName="pk_required_attribute_group_id">
                                    <ItemStyle CssClass="column" Width="20%" />
                                    <HeaderStyle CssClass="column" Width="20%" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkedit" runat="server" CausesValidation="false" CommandName="Edit_"
                                            Text="<%$resources:resource,edit%>">
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="pk_required_attribute_group_id" HeaderText="<%$Resources:Resource,Delete%>"
                                    UniqueName="pk_required_attribute_group_id">
                                    <ItemStyle CssClass="column" Width="20%" />
                                    <HeaderStyle CssClass="column" Width="20%" />
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CausesValidation="false"
                                            CommandName="delete" OnClientClick="javascript:return deleteItem();" ImageUrl="~/App/Images/Delete.gif" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td style="height: 10px;">
            </td>
        </tr>
        <tr id="tr_btn_add" runat="server">
            <td>
                <asp:Button ID="btnAttributeGroup" runat="server" Text="<%$Resources:Resource,Add_Attribute_Group%>"
                    OnClick="btnAttributeGroup_Click"></asp:Button>
            </td>
        </tr>
        <tr>
            <td>
                <table id="tbl_add" runat="server" visible="false" width="100%">
                    <tr>
                        <td style="height: 10px; width: 150px;">
                            <asp:Label ID="lblAttributeGroupName" runat="server" Text="<%$Resources:Resource,Attribute_Group_Name%>"
                                CssClass="Label"></asp:Label>:
                        </td>
                        <td>
                            <asp:TextBox ID="txtAttributeGroupName" runat="server" Height="15px" CssClass="textbox" AutoPostBack="False" 
                                Width="207px"></asp:TextBox>
                                <asp:Label ID="lblError" runat="server" ForeColor="Red" Text=""></asp:Label>
                            <asp:RequiredFieldValidator ID="rf_name" ValidationGroup="req" runat="server" ForeColor="Red"
                                ControlToValidate="txtAttributeGroupName" ErrorMessage="*" Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 15px;">
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            &nbsp;&nbsp;
                            <asp:Button ID="btn_save" runat="server" Text="<%$Resources:Resource,Save%>" Width="80px"
                                OnClick="btn_save_Click" OnClientClick="javascript:return validatecontrol();" />
                     </td>
                        <td align="left">
                            <asp:Button ID="btn_cancel" runat="server" Text="<%$Resources:Resource,Cancel%>"
                                Width="80px" OnClick="btn_cancel_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="height: 10px;">
                <asp:HiddenField ID="hf_temp_group_id" runat="server" />
                <asp:HiddenField ID="hf_temp_flag" runat="server" />
            </td>
        </tr>
    </table>
    <%--  </div>--%>
    <table width="100%">
        <tr>
            <td style="background-color: Orange; height: 1px; border-bottom-color: transparent;
                border-bottom-width: 0px; border-top-color: transparent; border-top-width: 0px;">
            </td>
        </tr>
        <tr style="height: 15px;">
            <td align="right" style="padding-bottom: 0px; margin-bottom: 0px">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="middle" style="padding-right: 2px">
                            <asp:ImageButton ID="ibtn_back" runat="server" Width="10" ImageUrl="~/App/Images/Icons/arrow_left.gif"
                                Enabled="false" OnClick="ibtn_back_Click" ImageAlign="Top" CssClass="lnkButtonImg" />
                        </td>
                        <td valign="top">
                            <asp:LinkButton ID="lbtn_back" runat="server" Text="Back" CssClass="disableLinkButton"
                                Font-Underline="false" Enabled="false" OnClick="lbtn_back_Click"></asp:LinkButton>
                        </td>
                        <td style="padding-left: 25px; padding-right: 25px" valign="middle">
                            <asp:Image ID="img_vbar" runat="server" ImageUrl="~/App/Images/Icons/asset_scrollbar_bar.png"
                                Width="2px" Height="10px" />
                        </td>
                        <td valign="top">
                            <asp:LinkButton ID="lbtn_next" runat="server" Text="Next" Font-Underline="false"
                                OnClick="lbtn_next_Click" CssClass="lnkButton"></asp:LinkButton>
                        </td>
                        <td valign="bottom">
                            <asp:ImageButton ID="ibtn_next" runat="server" ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm.png"
                                OnClick="ibtn_next_Click" CssClass="lnkButtonImg" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <%--  <tr>
            <td align="right" style="width: 40%">
                <asp:Button ID="btnNext" runat="server" Width="60px" Text="<%$Resources:Resource,Next%>"
                    OnClick="btnNext_Click" />
            </td>
        </tr>--%>
    </table>
    <%--<telerik:RadAjaxManager ID="ramSystem" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btn_search">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_attribute_group" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
               <telerik:AjaxSetting AjaxControlID="rg_attribute_group">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_attribute_group" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btn_save">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_attribute_group" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"
            Height="75px" Width="75px">
        </telerik:RadAjaxLoadingPanel>--%>
</div>
