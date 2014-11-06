<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="EnergyModelingSchedule.aspx.cs" Inherits="App_NewUI_EnergyModelingSchedule" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">

            function OnClientClicked(sender, args) {
                if (args.IsSplitButtonClick()) {
                    //TODO: Execute SplitButton logic
                    alert("Split button clicked!");
                }
                else {
                    //TODO: Execute main button logic
                    alert("Main button clicked!");
                }
            }

            var grid;
            function GridCreated(sender, args) {
                grid = sender;
            }

            

            function ShouldInitiateAjaxRequest(comboText) {

                //if there are three or more symbols entered, filter the data in the dropdown grid
                if (comboText.length > 1) {
                    $find("<%= RadAjaxManager.GetCurrent(Page).ClientID %>").ajaxRequest("LoadFilteredData");
                    return true;
                }
                else {
                    return false;
                }
            }
            function HandleOpen(sender, args) {

                var flag = ShouldInitiateAjaxRequest(sender.get_text());

                //cancel the dropdown opening if less than three characters are entered in the combobox' input
                if (!flag) {
                    args.set_cancel(true);
                }
            }
            function HandleKeyPressed(sender) {
                document.getElementById("<%=hdn_basEnergy_combo.ClientID %>").value = "Energy";
                var combo = $find(sender.id);
                combo.showDropDown();


            }
            function HandleKeyPressedbas(sender) {
                document.getElementById("<%=hdn_basEnergy_combo.ClientID %>").value = "Bas";
                var combo = $find(sender.id);
                combo.showDropDown();

            }

            function gotoPage(pk_energymodel_schedule_id, page_name) {
                //var url = "EnergyModelingSchedule.aspx?asset_id=" + pk_asset_id;
                //top.location.href(url);
                //alert(pk_energymodel_schedule_id)
                openEnergyModelingUpdateSchedule(pk_energymodel_schedule_id, page_name);
            }

            function preserverowsselected() {
                var grids = document.getElementsByClassName("<%=rg_schedule.ClientID %>");
                var MasterTable = document.getElementById("<%=rg_schedule.ClientID %>");
                var row = MasterTable.get_dataItems()[document.getElementById("<%=hdn_row_index.ClientID %>").value];
                var Name = MasterTable.getCellByColumnUniqueName(row, "action");
                var radbutton = $find(Name.children[0].id);
                document.getElementById(Name.children[0].id).style.display = "inline";
            }

            function openEnergyModelingUpdateSchedule(pk_energymodel_schedule_id, page_name) {
                manager = $find("<%=rd_manager.ClientID%>");
                var url;
                var url = "EnergyModelingAddSchedule.aspx?pk_energymodel_schedule_id=" + pk_energymodel_schedule_id;
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

            function openEnergyModelingAddSchedule() {
                manager = $find("<%=rd_manager.ClientID%>");
                var url;
                var url = "EnergyModelingAddSchedule.aspx";
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

            function delete_schedule() {
                var answer = confirm("Are you sure you want to delete this item?")
                if (answer)
                    return true;
                else
                    return false;

            }

            function anchor_test(id) {
                window.alert("This is an anchor test.")
                alert(id);
            }


            function OnDeleteClicked(button, args) {
                var is_selected = document.getElementById("<%= hf_is_selected.ClientID %>").value;
                if (is_selected == "true") {
                    if (window.confirm("Are you sure you want to delete this item(s)?")) {
                        document.getElementById("<%= hf_is_selected.ClientID %>").value = "false";
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

            function set_is_seleted_value() {
                var is_selected_value = document.getElementById("<%= hf_is_selected.ClientID %>").value;
                document.getElementById("<%= hf_is_selected.ClientID %>").value = "true";
            }



            function NiceScrollOnload() {
              
                if (screen.height > 721) {
                    //$("html").css('overflow-y', 'hidden');
                    //$("html").css('overflow-x', 'auto');
                }
                var screenhtg = set_NiceScrollToPanel();
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="CheckBoxes, RadioButtons, Buttons, Textbox, Textarea, Fieldset, Label, H4H5H6, Select, Zone, GridFormDetailsViews, ValidationSummary, LoginControls" />
    <table border="2" cellpadding="0" cellspacing="0" width="98%" style="border-collapse: collapse;
        border-top-color: transparent; border-top-width: 0px;">
        <tr>
            <td style="border-bottom-color: transparent; border-bottom-width: 0px">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color: #F7F7F7;
                    border-collapse: collapse; border-width: 0px">
                    <tr>
                        <td style="width: 7%; background-color: #FFFFFF">
                            <asp:Image ID="img_weather_tab" runat="server" ImageUrl="~/App/Images/Icons/schedule_tab.png" />
                        </td>
                        <td style="width: 80%">
                        </td>
                        <td style="width: 10%" align="right">
                            <table border="0">
                                <tr>
                                    <td align="right">
                                        <asp:ImageButton ID="img_edit" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                            Width="15" Height="15" ImageAlign="Bottom" />
                                        <asp:LinkButton ID="lbtn_edit" runat="server" Text="EDIT" ForeColor="Black" CssClass="lnkButton"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="border-top-color: transparent; border-top-width: 0px;">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;
                    border-top-color: transparent; border-top-width: 0px;">
                    <tr>
                        <td style="padding-top: 10px; padding-left: 15px; height: 57px; border-color: transparent;
                            border-width: 0px">
                            <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse"
                                width="100%">
                                <tr>
                                    <td style="width: 50%" valign="top">
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="background-image: url('../Images/asset_container_2.png'); height: 40px;
                                                    width: 200px; background-repeat: no-repeat;" align="center">
                                                    <asp:Label ID="lbl_project_name" runat="server" Text="Project Name" Font-Size="10"
                                                        ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                                </td>
                                                <td style="width: 5px">
                                                </td>
                                                <td style="background-image: url('../Images/asset_container_3.png'); height: 40px;
                                                    width: 200px; background-repeat: no-repeat" align="center">
                                                    <asp:Label ID="lbl_list" runat="server" Text="Schedules" Font-Size="10" ForeColor="Red"
                                                        CssClass="normalLabel"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 50%" align="right">
                                        <table border="0" cellpadding="0" cellspacing="0" width="50%">
                                            <tr>
                                                <td style="padding-bottom: 3px">
                                                    <asp:Label ID="lbl_schedule_type" runat="server" Text="Select Schedule Type" CssClass="normalLabel"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 2px">
                                                    <telerik:RadComboBox ID="cmb_schedule_type" runat="server" Height="150" Width="225"
                                                        ExpandDirection="Down" Skin="Default" AutoPostBack="true" OnSelectedIndexChanged="cmb_schedule_type_SelectedIndexChanged">
                                                    </telerik:RadComboBox>
                                                    <%-- <telerik:RadButton ID="btn_show" runat="server" Text="Show" Width="50"></telerik:RadButton>--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
                                <tr>
                                    <td style="height: 1px; background-color: Orange">
                                    </td>
                                </tr>
                                <tr style="background-color: Gray;">
                                    <td style="height: 30px; padding-left: 15px">
                                        <asp:Label ID="Label1" runat="server" Text="SCHEDULES" CssClass="normalLabel" ForeColor="White"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 1px; background-color: Orange">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadGrid ID="rg_schedule" runat="server" BorderWidth="1px" CellPadding="0"
                                Width="100%" GridLines="None" AllowPaging="true" AllowSorting="true" 
                                AutoGenerateColumns="False" PagerStyle-AlwaysVisible="true" ItemStyle-Wrap="false"
                                AllowMultiRowSelection="true" OnItemDataBound="rg_schedule_ItemDataBound" OnPageSizeChanged="rg_schedule_PageSizeChanged"
                                OnItemCommand="rg_schedule_ItemCommand" OnPageIndexChanged="rg_schedule_PageIndexChanged"
                                OnSortCommand="rg_schedule_SortCommand" 
                                OnItemCreated="rg_schedule_ItemCreated" ondatabound="rg_schedule_DataBound">
                                <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                                <ClientSettings>
                                    <Selecting AllowRowSelect="true" />
                                </ClientSettings>
                                <MasterTableView EditMode="EditForms" DataKeyNames="attribute_id,fk_field_id,object_id,header_text" CellPadding="0" CellSpacing="0"
                                    GroupHeaderItemStyle-HorizontalAlign="Left" GroupHeaderItemStyle-BackColor="#D9D9D9" TableLayout="Fixed"
                                    ClientDataKeyNames="attribute_id,fk_field_id,object_id,header_text" GroupLoadMode="Client"
                                    AllowNaturalSort="true">
                                    <GroupHeaderTemplate>
                                        <asp:CheckBox ID="chk_delete" runat="server" ToolTip="Select object to delete" onclick="set_is_seleted_value();" />
                                        <asp:Label ID="lbl_object" runat="server" Text='<%# Eval("header_text") %>'></asp:Label>
                                        <asp:HiddenField ID="hf_object_id" runat="server" Value='<%# Eval("header_text") %>' />
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
                                                <telerik:RadComboBox ID="cmb_attribute_value" runat="server" Width="160px" AllowCustomText="true">
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
                        <td style="height: 15px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%--<asp:Button ID="btn_delete" runat="server" Text="Delete Object" OnClientClick="if (!confirm('Are you sure you want to delete this item(s)?')) return false;"  OnClick="btn_delete_Click">
                            </asp:Button>--%>
                            <telerik:RadButton ID="btn_delete" runat="server" Text="Delete Object" OnClick="btn_delete_Click" OnClientClicked="OnDeleteClicked" AutoPostBack="false"></telerik:RadButton>
                        </td>
                    </tr>
                    <%--<tr>
                        <td align="right">
                            <div style="float:left">
                                <asp:Button ID="btn_save_selection" runat="server" Text="Delete Object" Width="100"
                                    OnClick="btn_save_selection_Click" />
                                    </div>
                            <div style="float:right">
                                <asp:ImageButton ID="ibtnNewEnergyModeling" runat="server" ImageUrl="~/App/Images/Icons/img_add_schedule.png"
                                    BorderWidth="0" OnClientClick="javascript:return openEnergyModelingAddSchedule();">
                                </asp:ImageButton>
                            </div>
                        </td>
                    </tr>--%>
                </table>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hf_is_selected" runat="server" Value="false" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdn_row_index" runat="server" />
            <asp:HiddenField ID="hdn_row_deselected" runat="server" />
            <asp:HiddenField ID="hdn_basEnergy_combo" runat="server" />
            <asp:HiddenField ID="hdnassetid" runat="server" />
            <asp:HiddenField ID="hdnscheduletypeid" runat="server" Value="" />
            <asp:HiddenField ID="hf_toggle_state" runat="server" Value="" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">

            function DeleteObjectConfirmation() {
            debugger
            if (confirm("Are you sure you want to delete this Object?"))
                {
                    __doPostBack('ctl00$ContentPlaceHolder1$btn_delete');
                    return true;
                    }
                else
                    return false;
            }

            function onTabSelected(sender, args) {
                //            if (args.get_tab().get_index() == 0) {
                //                //Reset the current product
                //                $get("products").innerHTML = "Books";
                //            }
                //            else {
                //                //Reset the current service
                //                $get("services").innerHTML = "Web";
                //            }
            }

            function OnClientClicked_Enabled(sender, args) {
                var btndisabledid = $find(sender.get_id().replace("btn_enabled", "btn_disabled"))
                if (sender.get_selectedToggleStateIndex() == 1) {

                    btndisabledid.set_selectedToggleStateIndex(0);
                }
                else {
                    btndisabledid.set_selectedToggleStateIndex(0);

                }
            }

            function OnClientClicked_Disabled(sender, args) {
                var btndisabledid = $find(sender.get_id().replace("btn_disabled", "btn_enabled"))
                if (sender.get_selectedToggleStateIndex() == 1) {

                    btndisabledid.set_selectedToggleStateIndex(0);
                }
                else {
                    btndisabledid.set_selectedToggleStateIndex(0);

                }
            }

            function onrowselected(sender, eventArgs) {
                var e = eventArgs.get_domEvent();
                var MasterTable = sender.get_masterTableView();
                var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
                document.getElementById("<%=hdn_row_index.ClientID %>").value = eventArgs.get_itemIndexHierarchical();
                var Name = MasterTable.getCellByColumnUniqueName(row, "action");
                document.getElementById(Name.children[0].id).style.display = "inline";
                document.getElementById("<%=hdn_row_deselected.ClientID%>").value = "row_selected";
            }


            function onrowsdeselected(sender, eventArgs) {
                var e = eventArgs.get_domEvent();
                var MasterTable = sender.get_masterTableView();
                var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
                var Name = MasterTable.getCellByColumnUniqueName(row, "action");
                document.getElementById("<%=hdn_row_index.ClientID %>").value = "";
                document.getElementById(Name.children[0].id).style.display = "none";
                document.getElementById("<%=hdn_row_deselected.ClientID%>").value = "row_deselected";
                if (document.getElementById(Name.children[0].id).getElementsByTagName("input")[0].src.indexOf("down-arrow.png") == -1) {
                    //document.getElementById(Name.children[0].id).getElementsByTagName("input")[0].click();
                }
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy runat="server" ID="RadAjaxManagerProxy1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_schedule">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_schedule" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmb_schedule_type">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_schedule" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
            <telerik:AjaxSetting AjaxControlID="btn_delete">
                <UpdatedControls>
                  <telerik:AjaxUpdatedControl ControlID="btn_delete"  />
                    <telerik:AjaxUpdatedControl ControlID="rg_schedule" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default" />
    <telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Red" Skin=""
        Behaviors="None">
        <Windows>
            <telerik:RadWindow ID="rd_window_schedule" runat="server" ReloadOnShow="false" Behaviors="Move,Resize"
                Width="700" Height="520" AutoSize="false" OffsetElementID="btn_search" VisibleStatusbar="false"
                VisibleOnPageLoad="false" BorderColor="Black" EnableAjaxSkinRendering="false"
                BorderStyle="None" BackColor="Red" VisibleTitlebar="false" Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
