<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EnergyPlusImportData.ascx.cs"
    Inherits="App_UserControls_EnergyPlusImportData" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">

        function ConfirmationMessage() {
            alert("Import is completed");
            document.getElementById("<%=lbl_imp_msg.ClientID%>").value = "Import is completed!";
        }

        function adjust_frame_height() {

            if (document.body.scrollHeight < 500) {
                var obj_dv = document.getElementById("dv_space1");
                obj_dv.style.height = "120";
            }

        }

        function ShowDetailWindow(entity_name, rowIndex, facility_id) {
            //alert(entity_name);
            //alert(facility_id);
            manager = $find("<%=rd_manager1.ClientID%>");
            var url;
            var url = "EntityDetailPage.aspx?entity_name=" + entity_name + "&facility_id=" + facility_id;
            if (manager != null) {
                var windows = manager.get_windows();
                if (window[0] != null) {
                    windows[0].setUrl(url);
                    windows[0].show();
                    windows[0].set_modal(false);
                }
            }

        }

        function adjust_parent_height() {
           
            adjust_height();
        }

       // window.onload = adjust_height;

     

    </script>
</telerik:RadCodeBlock>
<style type="text/css">
    .RadUploadProgressArea .ruProgress
    {
        background-image: none !important;
        background-color: transparent;
        border-style: none;
    }
    
    
    .cursorStyle
    {
        cursor: pointer;
    }
</style>
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
<div>
    <fieldset style="border-top-color: #DCDCDC; border-left-color: transparent; border-right-color: transparent;
        border-bottom-color: transparent">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 80%; padding-left: 20px; vertical-align: top" class="tdValign">
                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width: 100%; padding-top: 20px">
                                <table border="0" cellpadding="0" cellspacing="0" width="60%">
                                    <tr>
                                        <td style="width: 125px; height: 45px;">
                                            <telerik:RadButton ID="btn_import_data" runat="server" Text="Import Data" Width="80px"
                                                Skin="Default" OnClick="btn_import_data_Click" Style="top: 0px; left: 0px; height: 22px;" />
                                        </td>
                                        <td class="tdValign">
                                        </td>
                                        <td>
                                            <telerik:RadProgressManager ID="RadProgressManager1" runat="server"></telerik:RadProgressManager>
                                            <telerik:RadProgressArea runat="server" ID="RadProgressArea1" ProgressIndicators="TotalProgressBar"
                                                DisplayCancelButton="false" Skin="Windows7" Localization-TotalFiles="1" EnableViewState="false"
                                                Height="20px" loLocalization-TotalFiles="1" EnableAjaxSkinRendering="false" Style="margin-left: 10px; margin-top: 15px;">
                                            </telerik:RadProgressArea>
                                        </td>
                                    </tr>
                                  
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 15px; padding-bottom: 10px; padding-right: 20px">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <telerik:RadGrid ID="rgEnergySimulation" runat="server" CellPadding="0" GridLines="None" GroupHeaderItemStyle-HorizontalAlign="Left"
                                                AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" PagerStyle-AlwaysVisible="true"
                                                Skin="Default" ItemStyle-Wrap="false" Width="100%" OnSortCommand="rgEnergySimulation_SortCommand"
                                                Visible="true" CellSpacing="0" OnItemCommand="rgEnergySimulation_ItemCommand"
                                                OnPageIndexChanged="rgEnergySimulation_PageIndexChanged1" OnPageSizeChanged="rgEnergySimulation_PageSizeChanged1"
                                                OnItemCreated="rgEnergySimulation_ItemCreated">
                                                <PagerStyle Mode="NextPrevNumericAndAdvanced" AlwaysVisible="true" />
                                                <ClientSettings EnableRowHoverStyle="true">
                                                </ClientSettings>
                                                <MasterTableView DataKeyNames="object_name" ExpandCollapseColumn-ButtonType="PushButton" ItemStyle-HorizontalAlign="Left"
                                                    BorderWidth="0">
                                                    <AlternatingItemStyle BackColor="#E4E4E4" />
                                                    <HeaderStyle BorderColor="Orange" BorderStyle="Solid" />
                                                    <NoRecordsTemplate>
                                                        <asp:Label ID="lbl_no_data" runat="server" Text="No Data" CssClass="normalLabel"></asp:Label>
                                                    </NoRecordsTemplate>
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="object_name" HeaderText="Import Type" UniqueName="entity_name"  ItemStyle-HorizontalAlign="Left"
                                                            ItemStyle-Width="90%">
                                                           
                                                        </telerik:GridBoundColumn>
                                                     <%--   <telerik:GridBoundColumn DataField="ecodomus_count" HeaderText="EcoDomus Items" UniqueName="ecodomus_count"
                                                            ItemStyle-HorizontalAlign="Center" ItemStyle-Width="15%">
                                                            <ItemStyle Wrap="false" />
                                                            <HeaderStyle Wrap="false" />
                                                        </telerik:GridBoundColumn>--%>
                                                        <telerik:GridBoundColumn DataField="objectCount" HeaderText="Count" UniqueName="import_count"
                                                            ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10%">
                                                           
                                                        </telerik:GridBoundColumn>
                                                       <%-- <telerik:GridBoundColumn DataField="match_count" HeaderText="Matched" UniqueName="match_count"
                                                            ItemStyle-HorizontalAlign="Center" ItemStyle-Width="15%">
                                                            <ItemStyle Wrap="false" />
                                                            <HeaderStyle Wrap="false" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="failed" HeaderText="Failed" UniqueName="failed"
                                                            ItemStyle-HorizontalAlign="Center" ItemStyle-Width="15%">
                                                            <ItemStyle Wrap="false" />
                                                            <HeaderStyle Wrap="false" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn UniqueName="TemplateEditColumn" HeaderText="Details"
                                                            ItemStyle-HorizontalAlign="Center" ItemStyle-Width="15%">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="img_details" ImageUrl="~/App/Images/Icons/icon_profile-doc_sm.png"
                                                                    ImageAlign="Left" runat="server" CommandName="details" CssClass="cursorStyle" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>--%>
                                                    </Columns>
                                                    <%-- <CommandItemTemplate>
                                                        <a href="#" onclick="return ShowInsertForm();">Add New Record</a>
                                                    </CommandItemTemplate>--%>
                                                </MasterTableView>
                                            </telerik:RadGrid>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-top: 10px">
                                            <asp:Label ID="lbl_imp_msg" runat="server" Text="" CssClass="normalLabel" ForeColor="Red"></asp:Label>
                                        </td>
                                    </tr>
                                    <%--<tr>
                                        <td align="right" style="padding-top: 10px">
                                            <telerik:RadButton ID="btn_continue_import" Text="Continue Import" runat="server"
                                                Width="100" Visible="true" Enabled="false" OnClick="btn_continue_import_Click" />
                                        </td>
                                    </tr>--%>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="width: 20%; padding-top: 5px; background-color: #E8E8E8" valign="top"
                    class="tdValign">
                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <table width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="vertical-align: middle; padding-left: 10px; width: 30px">
                                            <asp:Image ID="img_selected_facility" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_lg.png" />
                                        </td>
                                        <td style="vertical-align: bottom; padding-left: 10px" align="left">
                                            <asp:Label ID="lbl_selected_facility" runat="server" Text="Selected Facility" CssClass="normalLabel">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px">
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 10px">
                                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbl_facility_name" runat="server" Text="" CssClass="normalLabel" ForeColor="#B22222"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 10px; padding-top: 30px">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 10%">
                                            <asp:Image ID="img_select_facility" runat="server" ImageUrl="~/App/Images/Icons/icon_checkmark_green.png" />
                                        </td>
                                        <td style="width: 90%">
                                            <asp:Label ID="lbl_select_facility" runat="server" Text="Select Facility" CssClass="normalLabel"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 10px; padding-top: 5px">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 10%">
                                            <asp:Image ID="img_select_attribute_template" runat="server" ImageUrl="~/App/Images/Icons/icon_checkmark_green.png" />
                                        </td>
                                        <td style="width: 90%">
                                            <asp:Label ID="lbl_select_attribute_template" runat="server" Text="Select Attributes Template"
                                                CssClass="normalLabel"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 10px; padding-top: 5px">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 10%">
                                            <asp:Image ID="img_select_data_import" runat="server" ImageUrl="~/App/Images/Icons/icon_checkmark_green.png" />
                                        </td>
                                        <td style="width: 90%">
                                            <asp:Label ID="lbl_select_data_import" runat="server" Text="Select Data To Import From"
                                                CssClass="normalLabel"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 10px; padding-top: 5px">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 10%">
                                            <asp:Image ID="img_import_energy_modeling_data" runat="server" ImageUrl="~/App/Images/Icons/icon_checkmark_green.png" />
                                        </td>
                                        <td style="width: 90%">
                                            <asp:Label ID="lbl_import_energy_modeling_data" runat="server" Text="Import Energy Modeling Data"
                                                CssClass="normalLabel"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 10px; padding-top: 5px; padding-bottom: 15px">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 10%">
                                            <asp:Image ID="img_view_import_result" runat="server" ImageUrl="~/App/Images/Icons/icon_checkmark_green.png" />
                                        </td>
                                        <td style="width: 90%">
                                            <asp:Label ID="lbl_view_import_result" runat="server" Text="View Import Results"
                                                CssClass="normalLabel"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="height: 0px" id="dv_space1">
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="background-color: Orange; height: 1px" colspan="2">
                </td>
            </tr>
            <tr>
                <td align="right" colspan="2">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="middle">
                                <asp:ImageButton ID="ibtn_back" runat="server" ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm2.png"
                                    OnClick="ibtn_back_Click" CssClass="lnkButtonImg" />
                            </td>
                            <td valign="top">
                                <asp:LinkButton ID="lbtn_back" runat="server" Text="Back" ForeColor="Black" OnClick="lbtn_back_Click"
                                    CssClass="lnkButton"></asp:LinkButton>
                            </td>
                            <td style="padding-left: 25px; padding-right: 25px" valign="middle">
                                <asp:Image ID="img_hbar" runat="server" ImageUrl="~/App/Images/Icons/asset_scrollbar_bar.png"
                                    Width="2px" Height="10px" />
                            </td>
                            <td valign="top">
                                <asp:LinkButton ID="lbtn_next" runat="server" Text="Finish" ForeColor="Black" CssClass="lnkButton"
                                    OnClick="lbtn_next_Click"></asp:LinkButton>
                            </td>
                            <td valign="middle">
                                <asp:ImageButton ID="ibtn_next" runat="server" ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm.png"
                                    OnClick="ibtn_next_Click" CssClass="lnkButtonImg" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </fieldset>
    <asp:HiddenField ID="hf_is_loaded" runat="server" Value="No" />
    <telerik:RadAjaxManager ID="RadAjaxManager2" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btn_continue_import">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadProgressArea1" />
                    <telerik:AjaxUpdatedControl ControlID="rgEnergySimulation" />
                    <telerik:AjaxUpdatedControl ControlID="btn_continue_import" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
      <ClientEvents OnResponseEnd="adjust_parent_height"  />
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btn_import_data">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgEnergySimulation" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="btn_continue_import" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgEnergySimulation">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgEnergySimulation" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default" IsSticky="false">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px"
        Width="75px" Skin="Default" IsSticky="false">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="rd_manager1" runat="server" BorderColor="Red" Skin="">
        <Windows>
            <telerik:RadWindow ID="rd_item_detail_window" runat="server" ReloadOnShow="false"
                DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search" Width="450"
                VisibleStatusbar="false" VisibleOnPageLoad="false" Behaviors="Resize,Move" BorderColor="Black"
                EnableAjaxSkinRendering="false" BorderStyle="None" BackColor="Red" VisibleTitlebar="false"
                Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</div>
