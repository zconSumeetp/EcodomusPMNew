<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCAttributeDetails.ascx.cs"
    Inherits="App_UserControls_UCAttributeDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="uc" TagName="PropertyValueControl" Src="~/App/UserControls/PropertyValueControl/PropertyValueControl.ascx" %>
<html>
<telerik:RadCodeBlock runat="server" ID="rdb1">
    <script type="text/javascript">

        function setFocus() {

        }
        window.onload = setFocus;
        function delete_attribute() {

            var flag = confirm("Do you want to delete this attribute?");
            return flag;
        }

        function closeWindow() {
            window.parent.refreshgrid_new();
            window.close();
            return false;
        }

        function fn_Clear() {

            try {
                document.getElementById("~/App/UserControls/UCAttributeDetails.ascxAttributeGroup_txtSearch").value = "";
                return false;
            }
            catch (e) {
                alert(e.message + "  " + e.Number);
                return false;
            }
        }

       function chkValidate() {
           var result = true;
           var lblMonLimitTime;
           var valThrough = object1.value;
                if (valThrough == "") {
                    lblMonLimitTime.innerHTML = "*";
                    result = false;
                }
                else {
                    lblMonLimitTime.innerHTML = "";
                }
           return result;
        }
        function GridCreated(sender, args) {

            var size = sender.get_element().style.width;
            var height = sender.get_element().style.height;
        }

        function stopPropagation(e) {
            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }
        function LogoutNavigation() {
            var query = parent.location.href;
            top.location.href(query);
        }
        window.onload = adjust_height;

    </script>
</telerik:RadCodeBlock>
<head>
    <title></title>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color: transparent;">

    <div style="padding-left: 0; margin: 0; width: 100%">
        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="padding-left:10px;padding-right:10px;">
          
            <tr align="center">
                <td align="right">
                    <asp:Panel ID="panel1" runat="server" DefaultButton="btn_search1">
                        <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                            <tr>
                                <td align="left" class="entityImage"  >
                                    <asp:Label runat="server" Text="<%$Resources:Resource, Attribute_Details%>" ID="lbl_grid_head"
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
                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txt_search1" Width="100%">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                    padding-bottom: 0px;">
                                                    <asp:ImageButton ClientIDMode="Static" OnClick="OnClick_BtnSearch1" ID="btn_search1"
                                                        Height="13px" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td align="center" style="padding-right:05px;" class="dropDownImage">
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                        <telerik:RadGrid runat="server" ID="rg_attribute_group" BorderWidth="1px" AllowPaging="true"
                            PageSize="5" AutoGenerateColumns="False" AllowSorting="True" PagerStyle-AlwaysVisible="true"
                            Visible="true" Skin="Default" Width="100%" OnSortCommand="rg_attribute_group_SortCommand"
                            OnPageIndexChanged="rg_attribute_group_PageIndexChanged" OnPageSizeChanged="rg_attribute_group_PageSizeChanged"
                            OnItemCommand="rg_attribute_group_OnItemCommand">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="50%" AlwaysVisible="true"
                                Wrap="false" />
                            <ClientSettings>
                                <ClientEvents OnGridCreated="GridCreated" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="220" />
                            </ClientSettings>
                            <MasterTableView DataKeyNames="pk_required_group_attribute_id,Attribute_name,pk_unit_of_measurement_id"
                                ClientDataKeyNames="pk_required_group_attribute_id">
                                <Columns>
                                    <telerik:GridEditCommandColumn HeaderStyle-Width="1%" ButtonType="ImageButton" HeaderText="<%$Resources:Resource,Edit%>"
                                        UniqueName="EditCommandColumn" ItemStyle-Width="1%">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridBoundColumn DataField="pk_required_group_attribute_id" HeaderText="pk_required_group_attribute_id"
                                        Visible="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Value" HeaderText="Value" Visible="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn Resizable="false" DataField="Attribute_name" HeaderStyle-Width="5%"
                                        HeaderText="<%$Resources:Resource,Attribute_Name%>" UniqueName="Attribute_name"
                                        SortExpression="Attribute_name">
                                        <HeaderStyle />
                                        <ItemStyle CssClass="column" Width="15%" HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Left" Width="15%" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="description" Resizable="false" HeaderStyle-Width="3%"
                                        HeaderText="<%$Resources:Resource,Abbreviation%>" UniqueName="description" SortExpression="description">
                                        <HeaderStyle />
                                        <ItemStyle CssClass="column" Width="3%" />
                                        <HeaderStyle CssClass="column" Width="3%" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="pk_unit_of_measurement_id" Resizable="false"
                                        HeaderStyle-Width="3%" Visible="false" HeaderText="" UniqueName="pk_unit_of_measurement_id"
                                        SortExpression="pk_unit_of_measurement_id">
                                        <HeaderStyle />
                                        <ItemStyle CssClass="column" Width="3%" />
                                         <HeaderStyle CssClass="column" Width="3%" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="value" Resizable="false" HeaderStyle-Width="3%"
                                        HeaderText="<%$Resources:Resource,Value%>" UniqueName="value" SortExpression="value">
                                        <HeaderStyle />
                                        <ItemStyle CssClass="column" Width="3%" />
                                         <HeaderStyle CssClass="column" Width="3%" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="pk_required_group_attribute_id" UniqueName="pk_required_group_attribute_id"
                                        Resizable="true" HeaderText="<%$Resources:Resource,Delete%>">
                                        <HeaderStyle Wrap="false" />
                                        <ItemStyle CssClass="column" Font-Underline="false" Width="3%" />
                                         <HeaderStyle CssClass="column" Width="3%" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deleteAttribute"
                                                CausesValidation="false" ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return delete_attribute();" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                </td>
            </tr>
            <tr>
                <td style="height: 10px;">
                </td>
            </tr>
            <tr id="tr_attribute" runat="server">
                <td>
                    <asp:Button ID="btnAttribute" runat="server" Text="<%$Resources:Resource,Add_Attribute%>"
                        OnClick="btnAtttribute_Click"></asp:Button>
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
                                <asp:TextBox ID="txtAttributeGroupName" runat="server" Height="15px" CssClass="textbox"
                                    Width="207px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rf_name" ValidationGroup="req" runat="server" ForeColor="Red"
                                    ControlToValidate="txtAttributeGroupName" ErrorMessage="*" Display="Dynamic"> </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 15px;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;&nbsp;
                                <asp:Button ID="btn_save" runat="server" Text="<%$Resources:Resource,Save%>" Width="80px"
                                    ValidationGroup="req" OnClick="btn_save_Click" />
                            </td>
                            <td>
                                <asp:Button ID="btn_cancel" runat="server" Text="<%$Resources:Resource,Cancel%>"
                                    Width="80px" OnClick="btn_cancel_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="tr_add_attribute" runat="server">
                <td>
                    <table id="tbl_add_details" runat="server" width="100%">
                        <tr>
                            <td align="right">
                                <asp:Label ID="lblName" CssClass="Label" runat="server" Text="<%$Resources:Resource,Name%>">:</asp:Label>:
                            </td>
                            <td>
                                <asp:TextBox ID="txtaddattribute" CssClass="textbox" runat="server" CausesValidation="true" Width="164"></asp:TextBox>
                                <asp:Label ID="lblMsgError" runat="server" Text="" ForeColor="Red" CssClass="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lblDescription" CssClass="Label" runat="server" Text="<%$Resources:Resource,Abbreviation%>">:</asp:Label>:
                            </td>
                            <td>
                                <asp:TextBox ID="txtDescription" CssClass="textbox" runat="server" Width="164"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lblValue" runat="server" CssClass="Label" Text="<%$Resources:Resource,Value%>">:</asp:Label>:
                            </td>
                            <td>
                                <uc:PropertyValueControl ID="PropertyValueControl" runat="server" ControlsWidth="168px" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lbl_uom" runat="server" CssClass="Label" Text="<%$Resources:Resource,Type%>">:</asp:Label>:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="RadComboBoxAttributeType" runat="server" Height="100" CssClass="DropDown" OnSelectedIndexChanged="RadComboBoxAttributeType_OnSelectedIndexChanged"
                                    Width="168" OnItemDataBound="RadComboBoxAttributeType_OnItemDataBound" AutoPostBack="True">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px">
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 40px; width: 40px">
                                <asp:Button ID="Button2" runat="server" Text="<%$Resources:Resource,Save%>" Width="80px"
                                    OnClick="btn_save_Click" OnClientClick="javascript:return chkValidate();" />
                            </td>
                            <td>
                                <asp:Button ID="Button3" runat="server" Text="<%$Resources:Resource,Cancel%>" Width="80px"
                                    OnClick="btn_cancel_Click" />
                                <asp:HiddenField ID="hf_temp_flag" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMsg" Visible="false" ForeColor="Red" Font-Size="10pt" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td style="background-color: Orange; height: 1px; border-bottom-color: transparent;
                    border-bottom-width: 0px; border-top-color: transparent; border-top-width: 0px;">
                </td>
            </tr>
            <tr>
                <td align="right" style="padding-bottom: 0px; margin-bottom: 0px">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="middle" style="padding-right: 2px">
                                <asp:ImageButton ID="ibtn_back" runat="server" Width="10" ImageUrl="~/App/Images/Icons/arrow_left.gif"
                                    Enabled="true" OnClick="ibtn_back_Click" ImageAlign="Top" CssClass="lnkButtonImg" />
                            </td>
                            <td valign="top">
                                <asp:LinkButton ID="lbtn_back" runat="server" Text="Back" CssClass="lnkButton" Font-Underline="false"
                                    Enabled="true" OnClick="lbtn_back_Click"></asp:LinkButton>
                            </td>
                            <td style="padding-left: 25px; padding-right: 25px" valign="middle">
                                <asp:Image ID="img_vbar" runat="server" ImageUrl="~/App/Images/Icons/asset_scrollbar_bar.png"
                                    Width="2px" Height="10px" />
                            </td>
                            <td valign="top">
                                <asp:LinkButton ID="lbtn_next" runat="server" Text="Finish" ForeColor="Black" CssClass="lnkButton"
                                    OnClick="lbtn_next_Click" OnClientClick="javascript:return closeWindow();"></asp:LinkButton>
                            </td>
                            <td valign="bottom">
                                <asp:ImageButton ID="ibtn_next" runat="server" ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm.png"
                                    OnClick="ibtn_next_Click" CssClass="lnkButtonImg" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    
    <telerik:RadAjaxManager ID="RadAjaxManagerAttributeDetail" runat="server">
            <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadComboBoxAttributeType">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PropertyValueControl" LoadingPanelID="LaodingPanel1" UpdatePanelHeight="100%"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

</body>
</html>
