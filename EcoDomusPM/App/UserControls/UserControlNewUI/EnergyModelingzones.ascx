<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingZones.ascx.cs" Inherits="App_UserControls_UserControlNewUI_EnergyModelingZones" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<style type="text/css">
    .tblBorder
    {
        border: 1px;
        height: auto;
        border-collapse: collapse;
    }
    .lnkBtnBgImg
    {
        background-image: url('/App/Images/asset_button_sm_gray.png');
        background-repeat: no-repeat;
        height: 25px;
        width: 60px;
        vertical-align: middle;
    }
    
    div
    {
        overflow-x: hidden;
    }
    
    .SelectedStyle
    {
        background-color: red !important;
    }
</style>


  <link href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
  <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="RadioButtons,Scrollbars,Buttons" />
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">

        function OnDeleteClicked(button, args) {
            var is_selected = document.getElementById("<%= hf_is_zone_selected.ClientID %>").value;
            if (is_selected == "true") {
                if (window.confirm("Are you sure you want to delete this item(s)?")) {
                    document.getElementById("<%= hf_is_zone_selected.ClientID %>").value = "false";
                    button.set_autoPostBack(true);
                }
                else {
                    button.set_autoPostBack(false);
                }
            }
            else {
                window.confirm("Please select item(s)");
            }
        }

        function set_is_seleted_zone_value() {
            var is_selected_value = document.getElementById("<%= hf_is_zone_selected.ClientID %>").value;
            document.getElementById("<%= hf_is_zone_selected.ClientID %>").value = "true";
        }

        function gotoPageAssignSchedule(pk_entity_id, page_name, entity_name) {
            //var url = "EnergyModelingSchedule.aspx?asset_id=" + pk_asset_id;
            //top.location.href(url);
            openAssignSchedulePopup(pk_entity_id, entity_name);
        }

        function gotoPageSchedule(pk_schedule_ids, page_name, entity_name) {
            url = "EnergyModelingSchedule.aspx?pk_schedule_ids=" + pk_schedule_ids;
            top.location.href(url);
        }

        function openAssignSchedulePopup(pk_entity_id, entity_name) {
            manager = $find("<%=rd_manager.ClientID%>");
            var url;
            var url = "EnergyModelingAssignSchedule.aspx?pk_entity_id=" + pk_entity_id + "&entity_name=" + entity_name;
            if (manager != null) {
                var windows = manager.get_windows();
                if (window[0] != null) {
                    windows[0].setUrl(url);

                    windows[0].show();
                    windows[0].set_modal(false);

                }
            }
            return false;
        }

        function NiceScrollOnload() {
            if (screen.height > 721) {
                $("html").css('overflow-y', 'hidden');
                $("html").css('overflow-x', 'auto');
            }
            var screenhtg = set_NiceScrollToPanel();
        }
    </script>
</telerik:RadCodeBlock>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:HiddenField ID="hf_is_zone_selected" runat="server" Value="false" />
        <asp:HiddenField ID="hdn_row_index" runat="server" />
        <asp:HiddenField ID="hdn_row_deselected_index" runat="server" />
        <asp:HiddenField ID="hdn_row_deselected" runat="server" />
        <asp:HiddenField ID="hdn_basEnergy_combo" runat="server" />
        <asp:HiddenField ID="hdnassetid" runat="server" />
        <asp:HiddenField ID="hf_space_ids" runat="server" />
        <asp:HiddenField ID="hf_zone_ids" runat="server" />
        <asp:HiddenField ID="hfExpand" runat="server" />
    </ContentTemplate>
</asp:UpdatePanel>

<table border="2" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;
    border-top-color: transparent; border-top-width: 0px;">
    <tr>
        <td style="height: 20px; border-top-width: 0px; border-bottom-width: 0px; border-top-color: transparent;
            border-bottom-color: transparent">
        </td>
    </tr>
    <tr>
        <td style="padding: 15px; border-top-width: 0px; border-bottom-width: 0px; border-top-color: transparent;
            border-bottom-color: transparent">
            <table border="0" cellpadding="0" cellspacing="0" style="vertical-align: middle">
                <tr>
                    <td style="vertical-align: middle; background-image: url('../Images/asset_container_2.png');
                        height: 40px; width: 200px; background-repeat: no-repeat;" align="center">
                        <asp:Label ID="lbl_project_name" runat="server" Font-Size="10" ForeColor="Red" CssClass="normalLabel"></asp:Label>
                    </td>
                    <td style="width: 5px">
                    </td>
                    <td style="vertical-align: middle; background-image: url('../Images/asset_container_zones.png');
                        height: 40px; width: 200px; background-repeat: no-repeat" align="center">
                        <asp:Label ID="lbl_list" runat="server" Text="Zone" Font-Size="10" ForeColor="Red"
                            CssClass="normalLabel"></asp:Label>
                    </td>
                    <td style="width: 3%; height: 40px;" align="left">
                    </td>
                    <td valign="middle" style="height: 20px;">
                        <telerik:RadComboBox ID="rarcmbZones" runat="server" Width="150px">
                        </telerik:RadComboBox>
                    </td>
                    <td width="6px">
                    </td>
                    <td valign="middle" style="height: 20px;">
                        <asp:ImageButton ID="ibtnSearch" runat="server" ImageUrl="~/App/Images/Icons/btnSearch.png"
                            OnClick="ibtnSearch_Click" />
                    </td>
                </tr>
                <tr>
                    <td style="height: 7px;" colspan="7">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="border-top-width: 0px; border-bottom-width: 0px; border-top-color: transparent;
            border-bottom-color: transparent">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right" class="gridRadPnlHeader">
                    </td>
                </tr>
                <tr>
                    <td height="1px" style="background-color: Orange; border-collapse: collapse">
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadGrid ID="rg_em_zones" runat="server" BorderWidth="1px" CellPadding="0"
                            ShowGroupPanel="false" Width="100%" GridLines="None" AllowPaging="true" AllowSorting="true"
                            AutoGenerateColumns="False" PagerStyle-AlwaysVisible="true" ItemStyle-Wrap="false"
                            AllowMultiRowSelection="true" OnItemDataBound="rg_em_zones_ItemDataBound" OnPageSizeChanged="rg_em_zones_PageSizeChanged"
                            OnItemCommand="rg_em_zones_ItemCommand" OnPageIndexChanged="rg_em_zones_PageIndexChanged"
                            OnSortCommand="rg_em_zones_SortCommand" 
                            ondatabound="rg_em_zones_DataBound">
                            <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                            <ClientSettings>
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <MasterTableView EditMode="EditForms" DataKeyNames="attribute_id" GroupHeaderItemStyle-HorizontalAlign="Left"
                                TableLayout="Fixed" GroupHeaderItemStyle-BackColor="#D9D9D9" ClientDataKeyNames="attribute_id"
                                GroupLoadMode="Client" AllowNaturalSort="true">
                                <GroupHeaderTemplate>
                                    <asp:CheckBox ID="chk_delete_zone" runat="server" ToolTip="Select object to delete" onclick="set_is_seleted_zone_value();" />
                                    <asp:Label ID="lbl_object_zone" runat="server" Text='<%# Eval("header_text") %>'></asp:Label>
                                    <asp:HiddenField ID="hf_object_zone_id" runat="server" Value='<%# Eval("header_text") %>' />
                                </GroupHeaderTemplate>
                                <Columns>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="<%$Resources:Resource,Edit%>"
                                        HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                        UniqueName="EditCommandColumn">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridBoundColumn DataField="Attribute_name" HeaderText="<%$Resources:Resource,Attribute_Name%>"
                                        HeaderStyle-Width="48%" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                        EditFormColumnIndex="0">
                                    </telerik:GridBoundColumn>
                                    <%--<telerik:GridBoundColumn DataField="Attribute_value" HeaderText="<%$Resources:Resource,Value%>"
                                        HeaderStyle-Width="38%" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                        EditFormColumnIndex="0">
                                    </telerik:GridBoundColumn>--%>
                                    <telerik:GridTemplateColumn HeaderText="Value" DataField="Attribute_value" ItemStyle-HorizontalAlign="Left"
                                        EditFormColumnIndex="0" SortExpression="attribute_unit">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_attribute_value" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Attribute_value")%>'> </asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cmb_attribute_value" runat="server" Width="160px" Height="150"
                                                AllowCustomText="true">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <GroupByExpressions>
                                    <telerik:GridGroupByExpression>
                                        <SelectFields>
                                            <telerik:GridGroupByField FieldAlias="Object" FieldName="group_name" HeaderText=""
                                                SortOrder="None"></telerik:GridGroupByField>
                                        </SelectFields>
                                        <GroupByFields>
                                            <telerik:GridGroupByField FieldName="header_text"></telerik:GridGroupByField>
                                        </GroupByFields>
                                    </telerik:GridGroupByExpression>
                                </GroupByExpressions>
                                <EditFormSettings EditFormType="AutoGenerated" CaptionFormatString="Edit Field:{0}:"
                                    EditColumn-HeaderStyle-HorizontalAlign="Left" CaptionDataField="Attribute_name"
                                    FormCaptionStyle-Font-Names="Arial" FormCaptionStyle-Font-Underline="true" FormCaptionStyle-Wrap="false"
                                    FormCaptionStyle-Font-Bold="true">
                                    <FormTableItemStyle Wrap="False" CssClass="normalLabel" HorizontalAlign="Right">
                                    </FormTableItemStyle>
                                    <FormCaptionStyle CssClass="column" HorizontalAlign="Left"></FormCaptionStyle>
                                    <FormMainTableStyle GridLines="None" Width="100%" CellPadding="0" CellSpacing="1"
                                        HorizontalAlign="Center" BackColor="White" />
                                    <FormTableStyle BackColor="White" CssClass="normalLabel" CellSpacing="2" HorizontalAlign="Justify" />
                                    <FormTableAlternatingItemStyle Wrap="False" HorizontalAlign="Right"></FormTableAlternatingItemStyle>
                                    <EditColumn UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel"
                                        ButtonType="ImageButton">
                                    </EditColumn>
                                    <FormTableButtonRowStyle HorizontalAlign="Right"></FormTableButtonRowStyle>
                                </EditFormSettings>
                            </MasterTableView>
                            <ValidationSettings CommandsToValidate="Update" />
                            <ClientSettings AllowColumnsReorder="true" ReorderColumnsOnClient="true">
                                <Resizing ResizeGridOnColumnResize="True" AllowResizeToFit="true"></Resizing>
                            </ClientSettings>
                            <AlternatingItemStyle CssClass="alternateColor" />
                        </telerik:RadGrid>
                    </td>
                </tr>
                <tr>
                    <td style="height: 5px">
                    </td>
                </tr>
                <tr>
                    <td>
                        <%--<asp:Button ID="btn_delete" runat="server" Text="Delete Object" OnClick="btn_delete_Click">
                        </asp:Button>--%>
                        <telerik:RadButton ID="btn_delete_zones" runat="server" Text="Delete Object" OnClick="btn_delete_zone_Click"
                            OnClientClicked="OnDeleteClicked" AutoPostBack="false">
                        </telerik:RadButton>
                    </td>
                </tr>
                <tr>
                    <td style="height: 15px">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table border="0" cellpadding="0" cellspacing="01" width="100%">
    <tr>
        <td style="padding-top: 10px">
            <%--<telerik:RadButton ID="btn_addSpacestoProject" Text="Save Selection" runat="server">
            </telerik:RadButton>--%>
        </td>
    </tr>
</table>

<asp:HiddenField ID="hf_em_of_seq_id" runat="server" />
        <asp:HiddenField ID="hf_zone_id" runat="server" />
          <asp:HiddenField ID="hf_space_id" runat="server" />
              <asp:HiddenField ID="hf_mode" runat="server" />
              <asp:HiddenField ID="hf_is_first_time" runat="server" Value="Y" />

<telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Red" Skin=""
    Behaviors="None">
    <Windows>
        <telerik:RadWindow ID="rd_window_assign_schedule" runat="server" ReloadOnShow="false"
            Behaviors="Move" Width="700" AutoSize="false" OffsetElementID="btn_search" VisibleStatusbar="false"
            VisibleOnPageLoad="false" BorderColor="Black" EnableAjaxSkinRendering="false"
            BorderStyle="None" BackColor="Red" VisibleTitlebar="false" Overlay="true">
        </telerik:RadWindow>
    </Windows>
</telerik:RadWindowManager>

<telerik:RadAjaxManagerProxy ID="EnergyModelingZoneManagerProxy" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rg_em_zones">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rg_em_zones" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btn_delete_zones">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rg_em_zones" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
    Height="75px" Width="75px">
</telerik:RadAjaxLoadingPanel>

