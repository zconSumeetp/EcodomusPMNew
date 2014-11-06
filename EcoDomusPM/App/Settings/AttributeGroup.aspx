<%@ Page Language="C#"  MasterPageFile="~/App/EcoDomus_PM_New.master"  AutoEventWireup="true"
    CodeFile="AttributeGroup.aspx.cs" Inherits="App_Settings_AttributeGroup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%--<%@ Register Src="../UserControls/PropertyValueControl/PropertyValueControl.ascx" TagName="PropertyValueControl" TagPrefix="uc" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadScriptBlock ID="scbScripts" runat="server">
        <script type="text/javascript" language="javascript">
            function Clear() {

                try {
                    document.getElementById("ContentPlaceHolder1_txtSearch").value = "";
                    return false;
                }
                catch (e) {
                    alert(e.message + "  " + e.Number);
                    return false;
                }
            }
            window.onload = body_load;
            function body_load() {
                var screenhtg = set_NiceScrollToPanel();
                if (document.getElementById("<%=txtSearch.ClientID %>") != null)
                    document.getElementById("<%=txtSearch.ClientID %>").focus();
                //var screenhtg = parseInt(window.screen.height * 0.65);
            }

            function deleteAttribute() {
                var names = "";
                var s = "";
                var s1 = $find("<%=rg_group_attribute.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var row = MasterTable.get_dataItems().length;
                var cnt = 0;

                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("pk_required_group_attribute_id") + ",";
                    names = names + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("Attribute_name") + ",";
                    document.getElementById("<%=hf_attribute_ids.ClientID%>").value = s;
                    document.getElementById("<%=hf_attribute_names.ClientID%>").value = names;
                    cnt = cnt + 1;
                }

                if (cnt != 0) {
                    var flag = confirm("Do you want to delete this attribute?");
                    return flag;
                }
                else {
                    alert("Please select attribute");
                    return false;

                }
            }
            function getSelectedAttributes() {
                var s1 = $find("<%=rg_group_attribute.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("pk_required_group_attribute_id") + ",";
                }

                if (s == "") {
                    alert("Please select attribute");
                    return false;
                }
                return true;
            }

            function openAddAttribute() {

                var templateId = document.getElementById("ContentPlaceHolder1_hfAttributeTemplateId").value;
                var group_id = document.getElementById("ContentPlaceHolder1_hf_group_id").value;
                var group_name = document.getElementById("ContentPlaceHolder1_hf_group_name").value;
                var omniClass = document.getElementById("<%= hf_OmniClass_id.ClientID %>").value;
                var entityId = document.getElementById("<%= hfEntityId.ClientID %>").value;
                var url = "AddRequiredAttributes.aspx?templateId=" + templateId + "&group_id=" + group_id + "&Name=" + group_name + "&omniclass_detail_id=" + omniClass
                + "&entity_id=" + entityId; //  + "&omniclass_detail_id=" + reg.omniclass_detail_id;
                manager = $find("<%=rg_manager_add_attribute.ClientID %>");
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                    // windows[2].set_modal(false);
                }
                return false;

            }

            function openAddEditAttributes(reg) {

                var templateId = document.getElementById("ContentPlaceHolder1_hfAttributeTemplateId").value;
                var group_id = document.getElementById("ContentPlaceHolder1_hf_group_id").value;
                var group_name = document.getElementById("ContentPlaceHolder1_hf_group_name").value;
                var displayUnitType = GetSelectedNames();
                // var s = reg.omniclass_detail_id + ",";
                var url = "AddRequiredAttributes.aspx?templateId=" + templateId + "&group_id=" + group_id + "&Name=" + group_name + "&attribute_id=" + reg.attribute_id + "&display_unit_type" + displayUnitType;
                manager = $find("<%=rg_manager_add_attribute.ClientID %>");
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                    // windows[2].set_modal(false);
                }
                return false;

            }

            function GetSelectedNames() {
                var grid = $find("<%=rg_group_attribute.ClientID %>");
                var masterTable = grid.get_masterTableView();
                var selectedRows = masterTable.get_selectedItems();
                var type = null;
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    type = masterTable.getCellByColumnUniqueName(row, "display_unit_type");
                    //here cell.innerHTML holds the value of the cell    
                }
                return type;
            }

            function refreshgrid() {
                document.getElementById("ContentPlaceHolder1_btnRefresh").click();

            }
            function stopPropagation(e) {
                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {
                //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
                var pageSize = document.getElementById("ContentPlaceHolder1_hfUserPMPageSize").value;
                var scrollArea = sender.GridDataDiv;
                var dataHeight = sender.get_masterTableView().get_element().clientHeight;
                //sender.get_masterTableView().set_pageSize(pageSize);
                if (dataHeight < parseInt(pageSize) * 40) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
                }

            }
        </script>
    </telerik:RadScriptBlock>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <table width="100%"  cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td class="centerAlign">
                <table style="margin: 0px 0px 0px 0px; width: 100%" cellpadding="0" cellspacing="0"
                    border="0">
                    <caption>
                        <asp:Label ID="lbl_template_name" runat="server"></asp:Label>
                    </caption>
                    <tr>
                        <td>
                            <asp:Label ID="lbl_omniclass" Text="<%$Resources:Resource,OmniClass%>" Font-Bold="true"
                                runat="server" Font-Size="10pt">:</asp:Label>:
                            <asp:Label ID="lbl_OmniClass_name" runat="server" Font-Size="10pt"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-bottom:05px;">
                            <asp:Label ID="Label1" Text="<%$Resources:Resource,Attribute_Group_Name%>" Font-Bold="true"
                                runat="server" Font-Size="10pt">:</asp:Label>:
                            <asp:Label ID="lbl_group_name" runat="server" Font-Size="10pt"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                    <td>
                    <table>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnaddrequiredattributes" Text="<%$Resources:Resource,Add_Attribute%>"
                                            OnClientClick="javascript:return openAddAttribute();" runat="server" Width="100px" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnDelete" Text="<%$Resources:Resource,Delete_Attribute%>" runat="server"
                                            OnClientClick="javascript:return deleteAttribute();" Width="100px"  OnClick="btnDelete_Click" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnSave" Text="<%$Resources:Resource,Save%>" runat="server"  OnClientClick="javascript:return getSelectedAttributes()" OnClick="btnSave_Click"
                                            Width="100px" CommandName="saveChanges"  CausesValidation="false" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnCancel" CommandName="cancel" Text="<%$Resources:Resource,Cancel%>" runat="server" Width="100px"
                                            OnClick="btnCancel_Click" />
                                    </td>
                                </tr>
                            </table>
                    </td>
                    </tr>
                    <tr align="center">
                        <td align="right">
                            <asp:Panel ID="panel1" runat="server" DefaultButton="btnSearch">
                                <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                    <tr>
                                        <td align="left" class="entityImage">
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
                                                                Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="100%">
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                            padding-bottom: 0px;">
                                                            <asp:ImageButton ClientIDMode="Static" OnClick="btn_search_click" ID="btnSearch"
                                                                Height="13px" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                        <td align="center" style="padding-right: 05px;" class="dropDownImage">
                                            <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                    ID="img_arrow" />--%>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="rg_group_attribute" runat="server" AllowPaging="true" AllowSorting="true"
                    Skin="Default" OnSortCommand="rg_group_attribute_Sort_command" OnPageIndexChanged="rg_group_attribute_pageindexchanged"
                    OnPageSizeChanged="rg_group_attribute_pagesizechanged" AutoGenerateColumns="false" 
                    PagerStyle-AlwaysVisible="true" OnItemDataBound="rg_group_attribute_ItemDataBound"
                    EnableEmbeddedSkins="true" AllowMultiRowSelection="true" 
                    onitemcommand="rg_group_attribute_ItemCommand">
                    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="left" Width="100%" />
                    <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                        <Selecting AllowRowSelect="true" />
                        <Scrolling AllowScroll="true" UseStaticHeaders = "true" ScrollHeight="400" />
                        <ClientEvents OnGridCreated="GridCreated" />
                    </ClientSettings>
                    <MasterTableView DataKeyNames="pk_required_group_attribute_id,Attribute_name,value"
                        ClientDataKeyNames="pk_required_group_attribute_id,Attribute_name,value" CommandItemDisplay="Top" >
                        <CommandItemTemplate>
                            
                        </CommandItemTemplate>

                         <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                                <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                <FooterStyle Height="25px" Font-Names="Arial" />
                        <Columns>
                            <telerik:GridBoundColumn DataField="pk_required_group_attribute_id" HeaderText=""
                                Visible="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridClientSelectColumn>
                                <ItemStyle Width="20px" Wrap="false" VerticalAlign="Top" />
                                <HeaderStyle Width="20px"  Wrap="false"/>
                            </telerik:GridClientSelectColumn>
                            <telerik:GridTemplateColumn DataField="Attribute_name" HeaderText="<%$Resources:Resource,Attribute_Name%>"
                                UniqueName="column" EditFormColumnIndex="0" SortExpression="Attribute_name">
                                <ItemStyle Width="35%" VerticalAlign="Middle" />
                                 <HeaderStyle Width="35%" VerticalAlign="Middle" />
                                <ItemTemplate>
                                    <asp:HyperLink ID="rg_lh_attribute" Text='<%# DataBinder.Eval(Container.DataItem,"Attribute_name")%>'
                                        onclick="javascript:return openAddEditAttributes(this);" runat="server" NavigateUrl="#"
                                        attribute_id='<%# DataBinder.Eval(Container.DataItem,"pk_required_group_attribute_id")%>'
                                        attribute_name='<%# DataBinder.Eval(Container.DataItem,"value")%>'></asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            
                            <telerik:GridTemplateColumn DataField="value" HeaderText="<%$Resources:Resource,Value%>"
                                UniqueName="value" SortExpression="value">
                                <ItemStyle Width="10%" VerticalAlign="Middle" Wrap="false" />
                                 <HeaderStyle Width="10%" VerticalAlign="Middle" Wrap="false" />
                                <ItemTemplate>
                                    <asp:Label ID="MakeTextBox" Width="100%" runat="Server" Text='<%# Bind("value") %>' />
                                    <asp:CheckBox runat="server" ID="CheckedFiled" Visible="False" Enabled="False"/>
                                    <telerik:RadComboBox ID="cmb_value_list" runat="server" Width="100%" ExpandDirection="Down"
                                        ZIndex="10">
                                    </telerik:RadComboBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="attribute_type" HeaderText="<%$Resources:Resource,AttributeType%>"
                                UniqueName="attribute_type" SortExpression="attribute_type" >
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Default_value" HeaderText="<%$Resources:Resource,Default_Value%>"
                                UniqueName="value" EditFormColumnIndex="0" SortExpression="Default_value">
                                <ItemStyle Width="10%" VerticalAlign="Middle" />
                                <HeaderStyle Width="10%" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="is_choice" HeaderText="<%$Resources:Resource,Value_Range_Choices%>"
                                UniqueName="value" EditFormColumnIndex="0">
                               <%-- <ItemStyle Width="10%" VerticalAlign="Top" />--%>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="is_required" HeaderText="<%$Resources:Resource,Required_Optional%>"
                                UniqueName="value" EditFormColumnIndex="0">
                               <%-- <ItemStyle Width="10%" VerticalAlign="Top" />--%>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description_Comments%>"
                                UniqueName="value" EditFormColumnIndex="0">
                                <ItemStyle Width="10%" VerticalAlign="Middle" />
                                 <HeaderStyle Width="10%" Wrap="true" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
                <%--<uc:PropertyValueControl runat="server" />--%>
            </td>
        </tr>
                </table>
            </td>
        </tr>
        
       <tr>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:HiddenField ID="hf_OmniClass_id" runat="server" />
                                    <asp:HiddenField ID="hf_template_name" runat="server" />
                                    <asp:HiddenField ID="hfEntityId" runat="server" />
                                    <asp:HiddenField ID="hf_attribute_ids" runat="server" />
                                    <asp:HiddenField ID="hf_attribute_names" runat="server" />
                                    <asp:HiddenField ID="hfAttributeTemplateId" runat="server" />
                                    <asp:HiddenField ID="hf_group_id" runat="server" />
                                    <asp:HiddenField ID="hf_group_name" runat="server" />
                                     <asp:HiddenField ID="hfUserPMPageSize" runat="server" Value="" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
        <tr>
            <td align="right">
                
            </td>
            <td style="display: none;">
                <asp:Button ID="btnRefresh" runat="server" OnClick="btnRefresh_Click" />
            </td>
        </tr>
    </table>
    <telerik:RadWindowManager ID="rad_window" VisibleStatusbar="false" AutoSize="false"
        EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server" KeepInScreenBounds="true"
        Width="600px">
        <Windows>
            <telerik:RadWindow ID="rad_AddEditRequiredAttribute" Width="480px" Height="390px"
                Behaviors="Move,Resize" Skin="Forest" runat="server" KeepInScreenBounds="true"
                DestroyOnClose="true" ReloadOnShow="false" VisibleTitlebar="true" Title="Required Attributes"
                VisibleStatusbar="false" VisibleOnPageLoad="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_group_attribute">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_group_attribute" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
          <%--  <telerik:AjaxSetting AjaxControlID="btnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_group_attribute" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_group_attribute" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnCancel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_group_attribute" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_group_attribute" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>
      <telerik:RadWindowManager ID="rg_manager_add_attribute" runat="server" VisibleTitlebar="true" Title="<%$Resources:Resource,Add_Required_Attributes%>" Behaviors="Close,Move"  
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rdw_add" runat="server" ReloadOnShow="false" Width="480"
                AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false"  BorderColor="Black"
                EnableAjaxSkinRendering="false" EnableShadow="true" BackColor="Black" 
                BorderWidth="2" Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
