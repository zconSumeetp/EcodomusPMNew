<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingZoneList.ascx.cs" Inherits="App_UserControls_UserControlNewUI_EnergyModelingZoneList" %>
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
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/Skins/MyCustomTabStrip/TabStrip.MyCustomTabStrip.css" />
    
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="RadioButtons, Buttons, Scrollbars, Textbox, Select">
    </telerik:RadFormDecorator>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        function OnDeleteListClicked(button, args) {
            var hf_is_selected_zoneList = document.getElementById("<%= hf_is_selected_zoneList.ClientID %>").value;
            if (hf_is_selected_zoneList == "true") {
                if (window.confirm("Are you sure you want to delete this item(s)?")) {
                    document.getElementById("<%= hf_is_selected_zoneList.ClientID %>").value = "false";
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

        function set_is_seleted_zoneList_value() {
            var hf_is_selected_zoneList = document.getElementById("<%= hf_is_selected_zoneList.ClientID %>").value;
            document.getElementById("<%= hf_is_selected_zoneList.ClientID %>").value = "true";
        }
        function referesh_project_page() {
            top.location.reload();
        }

        function RowSelected(sender, eventArgs) {
            manager = $find('<%=rd_manager_zones.ClientID%>');
            var grid = sender;
            var MasterTable = grid.get_masterTableView();
            var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];

            var id = MasterTable.getCellByColumnUniqueName(row, "pk_location_id").innerText;
            var name = MasterTable.getCellByColumnUniqueName(row, "name").innerText;

            var url = "EnergyModelingZoneListZone.aspx?id=" + id + "&name=" + name;

            if (manager != null) {
                var windows = manager.get_windows();
                if (window[0] != null) {
                    windows[0].setUrl(url);
                    windows[0].show();
                    windows[0].set_modal(false);
                }
            }
        }


        function openAddZoneListPopup() {
            manager = $find("<%=rd_manager_zones_list.ClientID%>");
            var url = "AddEnergyModelingZoneList.aspx";
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


        function GetRadWindow() {
            manager = $find('<%=rd_manager_zones.ClientID%>');
            if (manager != null) {
                var oWindow = manager.get_windows();
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            }
            return oWindow;
        }


        function adjust_Add_project_Popup(sender, args) {
            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                wnd.moveTo(x, 25);
                wnd.set_height(document.body.scrollHeight + 25)
                wnd.set_width(document.body.scrollWidth + 50)
            }
            return true;
        }
        //window.onload = adjust_Add_project_Popup;

        function NiceScrollOnload() {
            if (screen.height > 721) {
                $("html").css('overflow-y', 'hidden');
                $("html").css('overflow-x', 'auto');
            }
            var screenhtg = set_NiceScrollToPanel();
        }
    </script>
</telerik:RadCodeBlock>
    
<div style="border-collapse: collapse">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
        <tr>
            <td class="tdValign">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;
                    margin: 0px">
                    <tr>
                        <td style="width: 75px; vertical-align: bottom;">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top" style="padding-left: 1px">
                <fieldset style="border-style: solid; border-color: #DCDCDC; border-width: 2px; border-top-width: 0px;
                    border-top-color: transparent; border-right-color: #B4B4B4; border-bottom-style: outset">
                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="tdValign" style="padding-top: 10px; padding-left: 10px">
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
                                            <asp:Label ID="lbl_list" runat="server" Text="Zone List" Font-Size="10" ForeColor="Red"
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
                                            <asp:ImageButton ID="ibtnSearch" runat="server" ImageUrl="~/App/Images/Icons/btnSearch.png" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 7px;">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 20px">
                            </td>
                        </tr>
                        <tr>
                            <td class="tdValign" style="padding-left: 0px; padding-right: 0px;">
                                <div style="width: 100%">
                                    <fieldset style="border-style: solid; margin: 0px; border-left-color: #DCDCDC; border-top-color: #DCDCDC;
                                        border-width: 1px; border-bottom-color: #A0A0A0; border-right-color: #B4B4B4;">
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
                                                <td valign="top">
                                                    <telerik:RadGrid ID="rg_em_zoneslist" runat="server" BorderWidth="1px" CellPadding="0"
                                                        ShowGroupPanel="false" Width="100%" GridLines="None" AllowPaging="true" AllowSorting="true"
                                                        AutoGenerateColumns="False" PagerStyle-AlwaysVisible="true" ItemStyle-Wrap="false"
                                                        AllowMultiRowSelection="true" OnItemDataBound="rg_em_zoneslist_ItemDataBound"
                                                        OnPageSizeChanged="rg_em_zoneslist_PageSizeChanged" OnItemCommand="rg_em_zoneslist_ItemCommand"
                                                        OnPageIndexChanged="rg_em_zoneslist_PageIndexChanged" 
                                                        OnSortCommand="rg_em_zoneslist_SortCommand" 
                                                        ondatabound="rg_em_zoneslist_DataBound">
                                                        <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true" />
                                                        </ClientSettings>
                                                        <MasterTableView EditMode="EditForms" DataKeyNames="attribute_id" GroupHeaderItemStyle-HorizontalAlign="Left"
                                                            TableLayout="Fixed" GroupHeaderItemStyle-BackColor="#D9D9D9" ClientDataKeyNames="attribute_id"
                                                            GroupLoadMode="Client" AllowNaturalSort="true">
                                                            <GroupHeaderTemplate>
                                                                 <asp:CheckBox ID="chk_delete_zoneList" runat="server" ToolTip="Select object to delete" onclick="set_is_seleted_zoneList_value();"  />
                                                                <asp:Label ID="lbl_object_zoneList" runat="server" Text='<%# Eval("header_text") %>'></asp:Label>
                                                                <asp:HiddenField ID="hf_object_zoneList_id" runat="server" Value='<%# Eval("header_text") %>' />
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
                                                <td align="right">
                                                    <%--<asp:Button id="btn_add_zone_list"  Text="Add Zone List" Height="25px"  OnClientClick="javascript:return openAddZoneListPopup('A');"
                                                        runat="server" onclick="btn_add_zone_list_Click" /> --%>
                                                    <%--<asp:ImageButton ID="ibtnNewZoneList" runat="server" OnClientClick="javascript:return openAddZoneListPopup();"
                                                            ImageUrl="~/App/Images/Icons/add_zonelist.png" />--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 15px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                <telerik:RadButton ID="btn_delete_zoneList" runat="server" Text="Delete Object" OnClick="btn_delete_zoneList_Click" OnClientClicked="OnDeleteListClicked" AutoPostBack="false"></telerik:RadButton>
                                                    <%--<asp:Button ID="btn_delete" runat="server" Text="Delete Object" OnClick="btn_delete_Click">
                                                    </asp:Button>--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
    </table>
</div>

<asp:HiddenField ID="hf_is_selected_zoneList" runat="server" Value="false" />

<telerik:RadWindowManager ID="rd_manager_zones" runat="server" BorderColor="Red"
    Skin="">
    <Windows>
        <telerik:RadWindow ID="rad_zones" runat="server" ReloadOnShow="false" Height="450"
            Width="850" DestroyOnClose="true" AutoSize="false" OffsetElementID="btn_search"
            VisibleStatusbar="false" VisibleOnPageLoad="false" BorderColor="Black" EnableAjaxSkinRendering="false"
            BorderStyle="None" BackColor="Red" VisibleTitlebar="false" Overlay="false">
        </telerik:RadWindow>
    </Windows>
</telerik:RadWindowManager>    


<telerik:RadWindowManager ID="rd_manager_zones_list" runat="server" BorderColor="Red"
    Skin="">
    <Windows>
        <telerik:RadWindow ID="rad_zone_list" runat="server" ReloadOnShow="false" Height="180"
            Width="330" DestroyOnClose="true" AutoSize="false" VisibleStatusbar="false" VisibleOnPageLoad="false"
            BorderColor="Black" EnableAjaxSkinRendering="false" BorderStyle="None" BackColor="Red"
            VisibleTitlebar="false" Overlay="false">
        </telerik:RadWindow>
    </Windows>
</telerik:RadWindowManager>  
    
<telerik:RadAjaxManagerProxy ID="EnergyModelingZoneListManagerProxy" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rg_em_zoneslist">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rg_em_zoneslist" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btn_delete_zoneList">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rg_em_zoneslist" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
    Height="75px" Width="75px">
</telerik:RadAjaxLoadingPanel>  










<%--               </fieldset>
                                        <fieldset style="padding: 7px; padding-left: 0px; padding-top: 0px; border: 0;">
                                            <asp:Panel Width="99%" ID="NestedViewPanel" Height="150px" ScrollBars="Vertical"
                                                BackColor="White" runat="server" BorderColor="#DBDBDB">
                                                <asp:Table ID="tblSpace_attributes" runat="server" CellPadding="0" CellSpacing="0"
                                                    ClientIDMode="Static" Width="97.5%" border="0">
                                                </asp:Table>
                                            </asp:Panel>
                                            <fieldset style="padding-top: 7px; border: 0;">
                                                <table border="0" width="100%">
                                                    <tr>
                                                        <td>                                                       
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </fieldset>
                                    </div>
                                    </asp:Panel>
                                    <asp:Panel Width="100%" ClientIDMode="Static" Visible="false" BackColor="#DBDBDB"
                                        ID="PnlEdit" runat="server" BorderColor="#DBDBDB">
                                        <div>
                                            <fieldset style="padding-top: 10px; padding-bottom: 7px; padding-right: 10px; border: 0;">
                                                <asp:Table ID="tbl_edit_modelingObject" runat="server" Width="100%" CellPadding="0"
                                                    CellSpacing="0">
                                                    <asp:TableRow>
                                                        <asp:TableCell ID="TableCell2" Width="50%" runat="server">
                                                            <asp:Table ID="Table3" runat="server" Width="78%" CellPadding="0" CellSpacing="0">
                                                                <asp:TableRow>
                                                                    <asp:TableCell Width="150px" VerticalAlign="top" HorizontalAlign="Left" ID="TableCell1"
                                                                        runat="server">
                                                                        <asp:Label ID="lbl_edit_modeling_object" Text="Select Modeling Objects" runat="server"
                                                                            Font-Bold="true"></asp:Label>
                                                                    </asp:TableCell>
                                                                    <asp:TableCell Width="150px" HorizontalAlign="left" VerticalAlign="top">
                                                                        <telerik:RadComboBox ID="rcb_edit_modeling_object" Height="140" ClientIDMode="Static"
                                                                            runat="server" Width="200px">
                                                                        </telerik:RadComboBox>
                                                                    </asp:TableCell>
                                                                    <asp:TableCell Width="2px" HorizontalAlign="Left">
                                                                                                
                                                                    </asp:TableCell>
                                                                    <asp:TableCell Width="60px" HorizontalAlign="center" Enabled="false" Style="padding-bottom: 3px;">
                                                                        <asp:LinkButton ID="lbtn_edit_add" runat="server" Text="Add" CssClass="lnkBtnBgImg"
                                                                            Font-Size="10" Font-Names="Arial Regular" ForeColor="Black" Font-Underline="false"
                                                                            Height="22"></asp:LinkButton>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </asp:TableCell>
                                                        <asp:TableCell Width="10%">
                                                                                                
                                                        </asp:TableCell>
                                                        <asp:TableCell HorizontalAlign="Right" Width="12%">
                                                            <asp:Table BorderColor="0" ID="tbl_edit_copyPaste" Width="100%" runat="server">
                                                                <asp:TableRow>
                                                                    <asp:TableCell ColumnSpan="3" Width="45%" HorizontalAlign="Center" BorderWidth="0px">
                                                                        <asp:LinkButton ID="lbtn_edit_copy" Enabled="false" runat="server" CssClass="lnkBtnBgImg"
                                                                            Text="Copy" Font-Size="10" Font-Names="Arial Regular" ForeColor="GrayText" Font-Underline="false"
                                                                            Height="22"></asp:LinkButton>
                                                                    </asp:TableCell>
                                                                    <asp:TableCell Style="width: 1%">
                                                                    </asp:TableCell>
                                                                    <asp:TableCell HorizontalAlign="Center">
                                                                        <asp:LinkButton ID="lbtn_edit_paste" Enabled="false" runat="server" CssClass="lnkBtnBgImg"
                                                                            Text="Paste" Font-Size="10" Font-Names="Arial Regular" ForeColor="GrayText" Font-Underline="false"
                                                                            Height="22"></asp:LinkButton>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </asp:TableCell>
                                                    </asp:TableRow>
                                                </asp:Table>
                                            </fieldset>
                                            <fieldset style="padding: 7px; padding-left: 0px; border: 0;">
                                                <asp:Panel Width="99%" ClientIDMode="Static" ID="pnl_edit_attributes_table" Height="150px"
                                                    ScrollBars="Vertical" BackColor="White" runat="server" BorderColor="#DBDBDB">
                                                    <asp:Table ID="tbl_edit_space_attributes" runat="server" CellPadding="0" CellSpacing="0"
                                                        ClientIDMode="Static" Width="97.5%" border="0">
                                                    </asp:Table>
                                                </asp:Panel>
                                                <fieldset style="padding-top: 7px; border: 0;">
                                                    <table border="0" width="100%">
                                                        <tr>
                                                            <td>
                                                                <asp:Table ID="Table6" Width="100%" runat="server">
                                                                    <asp:TableRow>
                                                                        <asp:TableCell ColumnSpan="3" HorizontalAlign="Right" BorderWidth="0px">
                                                                            <td align="center" class="lnkBtnBgImg">
                                                                                <asp:LinkButton ID="lbtn_edit_undo" Enabled="false" runat="server" ClientIDMode="Static"
                                                                                    Text="UNDO" ForeColor="Black" Font-Size="10" Font-Names="Arial Regular" Font-Underline="false"
                                                                                    Height="20"></asp:LinkButton>
                                                                            </td>
                                                                            <td style="width: 0.5%">
                                                                            </td>
                                                                            <td align="center" class="lnkBtnBgImg">
                                                                                <asp:LinkButton ID="lbtn_edit_save" CommandName="save" runat="server" Text="SAVE"
                                                                                    ClientIDMode="Static" Enabled="true" ForeColor="Black" Font-Size="10" Font-Names="Arial Regular"
                                                                                    Font-Underline="false" Height="20"></asp:LinkButton>
                                                                            </td>
                                                                        </asp:TableCell>
                                                                    </asp:TableRow>
                                                                </asp:Table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </fieldset>
                                        </div>
                                    </asp:Panel>
                                    </NestedViewTemplate> </MasterTableView> </telerik:RadGrid> </telerik:RadPageView>
                                    </telerik:RadMultiPage>
                                </td>
                            </tr>
                        </table>
    </div>
    </table> </div> </div> </div> </div> </div> </div> </div> </div> </div> </div> </div>
    </div>
    </table>
    </div>--%>
