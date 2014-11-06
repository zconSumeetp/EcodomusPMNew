<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="RequiredAttribute.aspx.cs" Inherits="App_Settings_RequiredAttribute" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadScriptBlock ID="scbScripts" runat="server">
        <script type="text/javascript" language="javascript">
            function setFocus() {
                if (document.getElementById("<%=txtSearch.ClientID %>") != null)
                    document.getElementById("<%=txtSearch.ClientID %>").focus();
                var screenhtg = set_NiceScrollToPanel();
            }
            window.onload = setFocus;

            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {
                var pageSize = document.getElementById("ContentPlaceHolder1_hfUserPMPageSize").value;
                var scrollArea = sender.GridDataDiv;
                var dataHeight = sender.get_masterTableView().get_element().clientHeight;
                if (dataHeight < parseInt(pageSize) * 40) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
                }

            }
        </script>
        <script language="javascript" type="text/javascript">

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


            function openAddEditAttributes(reg) {
                var templateId = document.getElementById("ContentPlaceHolder1_hfRequiredAttributeTemplateId").value;
                var entity_id = document.getElementById("ContentPlaceHolder1_hf_entity_id").value;
                var url = "../Settings/AddEditRequiredAttributes.aspx?templateId=" + templateId + "&entity_id=" + entity_id + "&Name=" + reg.omniclassname + "&omniclass_detail_id=" + reg.omniclass_detail_id;
                var manager = $find("<%=rad_window.ClientID %>");
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                }
                return false;
            }



            function openAddEditNamingConvention(reg) {
                var templateId = document.getElementById("ContentPlaceHolder1_hfRequiredAttributeTemplateId").value;
                var entity_id = document.getElementById("ContentPlaceHolder1_hf_entity_id").value;
                var s = reg.omniclass_detail_id + ",";
                var url = "../Settings/AddEditNames.aspx?templateId=" + templateId + "&entity_id=" + entity_id + "&Name=" + reg.omniclassname + "&omniclass_detail_id=" + s;
                var manager = $find("<%=rd_manger_naming.ClientID %>");
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                }
                return false;

            }
            function openAddNamingConvention() {
                var s1 = $find("<%=rg_omniclass.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                if (document.getElementById("ContentPlaceHolder1_hf_OmniClass_id").value != "") {

                    s = document.getElementById("ContentPlaceHolder1_hf_OmniClass_id").value + ",";
                }
                var s2 = "";
                var name = "";
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("omniclass_id") + ",";
                    name = s1.get_masterTableView().get_selectedItems()[0].getDataKeyValue("OmniClassName");
                    s2 = s2 + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("omniclass_id") + ",";
                }

                if (s == "") {
                    alert("Please select at least one classification.");
                    return false;
                }
                else if (selectedRows.length > 1) {

                    alert("Please select only one Standard.");
                }
                else {
                    var templateId = document.getElementById("ContentPlaceHolder1_hfRequiredAttributeTemplateId").value;
                    var entity_id = document.getElementById("ContentPlaceHolder1_hf_entity_id").value;
                    if (document.getElementById("ContentPlaceHolder1_hf_OmniClass_id").value != "") {
                        var url = "../Settings/AddEditNames.aspx?templateId=" + templateId + "&entity_id=" + entity_id + "&Name=" + name + "&omniclass_detail_id=" + s;
                    }
                    else {

                        var url = "../Settings/AddEditNames.aspx?templateId=" + templateId + "&entity_id=" + entity_id + "&Name=" + name + "&omniclass_detail_id=" + s2;
                    }

                    var manager = $find("<%=rd_manger_naming.ClientID %>");
                    if (manager != null) {
                        var windows = manager.get_windows();
                        windows[0].setUrl(url);
                        windows[0].show();
                    }
                    return false;
                }
            }


            function openAddEditDocument(reg) {

                var templateId = document.getElementById("ContentPlaceHolder1_hfRequiredAttributeTemplateId").value;
                var entity_id = document.getElementById("ContentPlaceHolder1_hf_entity_id").value;
                var s = reg.omniclass_detail_id + ",";
                var url = "../Settings/AddEditDocument.aspx?templateId=" + templateId + "&entity_id=" + entity_id + "&Name=" + reg.omniclassname + "&omniclass_detail_id=" + reg.omniclass_detail_id;
                manager = $find("<%=rg_manager_edit_doc.ClientID %>");
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                }
                return false;

            }
            function openAddDocument() {

                var s1 = $find("<%=rg_omniclass.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                var s2 = "";
                var id = "";
                if (document.getElementById("ContentPlaceHolder1_hf_OmniClass_id").value != "") {
                    s = document.getElementById("ContentPlaceHolder1_hf_OmniClass_id").value + ",";
                }

                var name = "";
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("omniclass_id") + ",";
                    name = s1.get_masterTableView().get_selectedItems()[0].getDataKeyValue("OmniClassName");
                    s2 = s2 + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("omniclass_id") + ",";
                }

                if (s == "") {
                    alert("Please select at least one classification.");
                    return false;
                }
                else {
                    var templateId = document.getElementById("ContentPlaceHolder1_hfRequiredAttributeTemplateId").value;
                    var entity_id = document.getElementById("ContentPlaceHolder1_hf_entity_id").value;

                    if (document.getElementById("ContentPlaceHolder1_hf_OmniClass_id").value != "") {
                        var url = "../Settings/AddRequiredDocument.aspx?templateId=" + templateId + "&entity_id=" + entity_id + "&Name=" + name + "&omniclass_detail_id=" + s;
                    }
                    else {

                        var url = "../Settings/AddRequiredDocument.aspx?templateId=" + templateId + "&entity_id=" + entity_id + "&Name=" + name + "&omniclass_detail_id=" + s2;
                    }


                    var manager = $find("<%=rd_manger_new.ClientID %>");
                    if (manager != null) {
                        var windows = manager.get_windows();
                        windows[0].setUrl(url);
                        windows[0].show();
                    }
                    return false;
                }
            }

            function openAddAttributes() {

                var s1 = $find("<%=rg_omniclass.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                var s2 = "";
                var name = "";
                if (document.getElementById("ContentPlaceHolder1_hf_OmniClass_id").value != "") {
                    s = document.getElementById("ContentPlaceHolder1_hf_OmniClass_id").value + ",";
                }
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("omniclass_id") + ",";
                    name = s1.get_masterTableView().get_selectedItems()[0].getDataKeyValue("OmniClassName");
                    s2 = s2 + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("omniclass_id") + ",";
                }

                if (s == "") {
                    alert("Please select at least one classification.");
                    return false;
                } else {
                    var templateId = document.getElementById("ContentPlaceHolder1_hfRequiredAttributeTemplateId").value;
                    var entity_id = document.getElementById("ContentPlaceHolder1_hf_entity_id").value;
                    if (document.getElementById("ContentPlaceHolder1_hf_OmniClass_id").value != "") {
                        var url = "../Settings/AddRequiredAttributesNew.aspx?templateId=" + templateId + "&entity_id=" + entity_id + "&Name=" + name + "&omniclass_detail_id=" + s;
                    } else {

                        var url = "../Settings/AddRequiredAttributesNew.aspx?templateId=" + templateId + "&entity_id=" + entity_id + "&Name=" + name + "&omniclass_detail_id=" + s2;
                    }

                    var manager = $find("<%=rg_manager_add_attribute.ClientID %>");
                    if (manager != null) {
                        var windows = manager.get_windows();
                        windows[0].setUrl(url);
                        windows[0].show();
                    }
                    return false;
                }
            }

            function openCreateAttributeGroup() {
                var s1 = $find("<%=rg_omniclass.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                var s2 = "";
                var name = "";

                var templateId = document.getElementById("ContentPlaceHolder1_hfRequiredAttributeTemplateId").value;
                var entity_id = document.getElementById("ContentPlaceHolder1_hf_entity_id").value;
                var url = "../Settings/RequiredAttributeGroup.aspx?templateId=" + templateId + "&entity_id=" + entity_id; // + "&Name=" + name + "&omniclass_detail_id=" +s2;
                var manager = $find("<%=rd_manger_NewUI.ClientID %>");
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                }
                return false;

            }

            function refreshgrid() {
                document.getElementById("ContentPlaceHolder1_btnrefreshgrid").click();
            }
            function refreshgrid_new() {
                document.getElementById("ContentPlaceHolder1_btn_refresh_grid_new").click();

            }
            function gotoPage(template_id, entity_id, omniclass_id, omniclass_name, group_id, attribute_name) {
                var template_name = document.getElementById("ContentPlaceHolder1_hf_template_name").value;
                var url = "../Settings/AttributeGroup.aspx?templateId=" + template_id + "&Name=" + omniclass_name + "&entity_id=" + entity_id + "&omniclass_detail_id=" + omniclass_id + "&group_id=" + group_id + "&attribute_name=" + attribute_name + "&template_name=" + template_name;
                window.location.href(url);
            }
            function load_url(url) {
                var manager = $find("<%=rad_window.ClientID %>");
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                }
                return false;

            }
            function stopPropagation(e) {
                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }


            function openAssignPMJobs() {
                var organization_id = document.getElementById("<%=hf_organization_id.ClientID %>").value;

                var s1 = $find("<%=rg_omniclass.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                var s2 = "";
                var name = "";
                if (document.getElementById("ContentPlaceHolder1_hf_OmniClass_id").value != "") {
                    s = document.getElementById("ContentPlaceHolder1_hf_OmniClass_id").value + ",";
                }
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("omniclass_id") + ",";
                    name = s1.get_masterTableView().get_selectedItems()[0].getDataKeyValue("OmniClassName");
                    s2 = s2 + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("omniclass_id") + ",";
                }

                if (s == "") {
                    alert("Please select at least one classification.");
                    return false;
                }
                else {
                    var templateId = document.getElementById("ContentPlaceHolder1_hfRequiredAttributeTemplateId").value;
                    var entity_id = document.getElementById("ContentPlaceHolder1_hf_entity_id").value;
                    if (document.getElementById("ContentPlaceHolder1_hf_OmniClass_id").value != "") {
                        var url = "../Settings/JobTemplate.aspx?templateId=" + templateId + "&entity_id=" + entity_id + "&Name=" + name + "&omniclass_detail_id=" + s + "&organization_id=" + organization_id;
                    }
                    else {

                        var url = "../Settings/JobTemplate.aspx?templateId=" + templateId + "&entity_id=" + entity_id + "&Name=" + name + "&omniclass_detail_id=" + s2 + "&organization_id=" + organization_id;
                    }

                    manager = $find("<%=rg_manager_job_template.ClientID %>");
                    if (manager != null) {
                        var windows = manager.get_windows();
                        windows[0].setUrl(url);
                        windows[0].show();
                    }
                    return false;
                }

            }
        
        </script>
    </telerik:RadScriptBlock>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <table style="margin: 0px 0px 0px 0px; width: 100%" cellpadding="0" cellspacing="0"
        border="0">
        <tr>
            <td class="centerAlign">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnaddrequiredattributes" Text="<%$Resources:Resource,Required_Attributes%>"
                                OnClientClick="javascript:return openAddAttributes();" runat="server" />
                        </td>
                        <td>
                            <asp:Button ID="btnaddrequireddocuments" Text="<%$Resources:Resource,Required_Documents%>"
                                runat="server" OnClientClick="javascript:return openAddDocument();" />
                        </td>
                        <td>
                            <asp:Button ID="btnaddnamingconvention" Text="<%$Resources:Resource,Naming_Convention%>"
                                runat="server" OnClientClick="javascript:return openAddNamingConvention();" />
                        </td>
                        <td>
                            <asp:Button ID="btncreateattributegroup" Text="<%$Resources:Resource,Attribute_Group%>"
                                runat="server" OnClientClick="javascript:return openCreateAttributeGroup();" />
                        </td>
                        <td>
                            <asp:Button ID="btn_PM_jobs" Text="<%$Resources:Resource,PM_jobs%>" runat="server"
                                OnClientClick="javascript:return openAssignPMJobs();" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr align="center">
            <td class="centerAlign">
                <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                    <tr>
                        <td align="left" style="padding: 3px;" class="entityImage">
                            <asp:Label runat="server" Text="<%$Resources:Resource, Required_Attributes%>" ID="lbl_grid_head"
                                CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                            <asp:Label ID="Label1" runat="server" CssClass="gridHeadText" ForeColor="#F8F8F8"
                                Font-Names="Arial" Font-Size="12" Text=":"></asp:Label>
                            <asp:Label ID="lbl_template_name" CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial"
                                Font-Size="12" runat="server"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadComboBox Width="170px" ID="cmb_type" Style="padding-right: 5px;" Filter="contains"
                                runat="server" oncopy="return false;" OnSelectedIndexChanged="cmb_type_SelectedIndexChanged"
                                onpaste="return false;" oncut="return false;" onkeypress="return tabonly(event)"
                                onmousewheel="return false" AutoPostBack="true">
                            </telerik:RadComboBox>
                        </td>
                        <td align="right" class="entityImage" style="padding-left: 0px;">
                            <table>
                                <tr>
                                    <td>
                                        <div id="div_search" style="background-color: White; width: 170px;">
                                            <asp:Panel ID="panel1" runat="server" DefaultButton="btnSearch">
                                                <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                    width: 100%;">
                                                    <tr style="border-spacing: 0px;">
                                                        <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                            padding-bottom: 0px;">
                                                            <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="100%">
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                            padding-bottom: 0px;">
                                                            <asp:ImageButton ClientIDMode="Static" OnClick="btnSearchClick" ID="btnSearch" Height="13px"
                                                                runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="center" style="padding-right: 10px;">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <telerik:RadGrid ID="rg_omniclass" runat="server" AllowPaging="true" AllowSorting="true"
                                Skin="Default" OnSortCommand="rg_omniclass_sort_command" OnPageIndexChanged="rg_omniclass_pageindexchanged"
                                OnPageSizeChanged="rg_omniclass_pagesizechanged" AutoGenerateColumns="false"
                                PagerStyle-AlwaysVisible="true" OnItemDataBound="rgOmniClass_ItemDataBound" AllowMultiRowSelection="true"
                                EnableEmbeddedSkins="true">
                                <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="left" Width="100%" />
                                <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                    <Scrolling UseStaticHeaders="true" ScrollHeight="450" AllowScroll="true" />
                                    <Selecting AllowRowSelect="true" />
                                    <ClientEvents OnGridCreated="GridCreated" />
                                </ClientSettings>
                                <MasterTableView DataKeyNames="omniclass_id,OmniClassName" ClientDataKeyNames="omniclass_id,OmniClassName">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="omniclass_id" HeaderText="omniclass_id" Visible="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridClientSelectColumn>
                                            <ItemStyle Width="20px" />
                                            <HeaderStyle Width="20px" />
                                        </telerik:GridClientSelectColumn>
                                        <telerik:GridBoundColumn DataField="OmniClassName" HeaderText="<%$Resources:Resource,Classifications%>"
                                            SortExpression="OmniClassName">
                                            <ItemStyle VerticalAlign="Top" Width="20%" />
                                            <HeaderStyle VerticalAlign="Top" Width="20%" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="attributes" HeaderText="<%$Resources:Resource,Applied_Group_Name%>"
                                            UniqueName="column" SortExpression="attributes">
                                            <ItemStyle VerticalAlign="Top" Wrap="false" Width="20%" />
                                            <HeaderStyle VerticalAlign="Top" Width="20%" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="name" HeaderText="<%$Resources:Resource,Naming_Convention%>"
                                            UniqueName="column" EditFormColumnIndex="0">
                                            <ItemStyle VerticalAlign="Top" Width="20%" />
                                            <HeaderStyle VerticalAlign="Top" Width="20%" />
                                            <ItemTemplate>
                                                <asp:HyperLink ID="rg_lh_naming" Text='<%# DataBinder.Eval(Container.DataItem,"name")%>'
                                                    onclick="javascript:return openAddEditNamingConvention(this);" runat="server"
                                                    NavigateUrl="#" omniclassname='<%# DataBinder.Eval(Container.DataItem,"OmniClassName")%>'
                                                    omniclass_detail_id='<%# DataBinder.Eval(Container.DataItem,"omniclass_id")%>'></asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="job_name" HeaderText="<%$Resources:Resource,PM_Jobs%>"
                                            UniqueName="Job_name">
                                            <ItemStyle VerticalAlign="Top" Width="20%" />
                                            <HeaderStyle VerticalAlign="Top" Width="20%" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="req_docs" HeaderText="<%$Resources:Resource,Required_Documents%>"
                                            UniqueName="column" EditFormColumnIndex="0">
                                            <ItemStyle VerticalAlign="Top" Width="20%" />
                                            <HeaderStyle VerticalAlign="Top" Width="20%" />
                                            <ItemTemplate>
                                                <asp:HyperLink ID="rg_lh_req_doc" Text='<%# DataBinder.Eval(Container.DataItem,"req_docs")%>'
                                                    onclick="javascript:return openAddEditDocument(this);" runat="server" NavigateUrl="#"
                                                    omniclassname='<%# DataBinder.Eval(Container.DataItem,"OmniClassName")%>' omniclass_detail_id='<%# DataBinder.Eval(Container.DataItem,"omniclass_id")%>'></asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:RadioButton ID="rdBtnOmniClass" GroupName="OmniClassVersion" OnCheckedChanged="rdBtnOmniClass_CheckedChanged"
                    runat="server" Text="OmniClass 2010" Font-Size="10pt" AutoPostBack="True" Checked="true"
                    Font-Bold="false" />
            </td>
            <td>
                <asp:RadioButton ID="rdBtnOmniClass2" GroupName="OmniClassVersion" OnCheckedChanged="rdBtnOmniClass2_CheckedChanged"
                    runat="server" Text="OmniClass 2006" Font-Size="10pt" Font-Bold="false" AutoPostBack="True" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="hf_OmniClass_id" runat="server" />
                        <asp:HiddenField ID="hf_template_name" runat="server" />
                        <asp:HiddenField ID="hfUserPMPageSize" runat="server" Value="" />
                        <asp:HiddenField ID="hf_organization_id" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td style="height: 20px;">
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hfRequiredAttributeTemplateId" runat="server" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hf_entity_id" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div style="display: none">
        <asp:Button ID="btnrefreshgrid" runat="server" OnClick="btnrefreshgrid_Click" />
        <asp:Button ID="btn_refresh_grid_new" runat="server" OnClick="btn_refresh_grid_new_Click" />
    </div>
    <%--</td>
</tr>--%>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmb_type">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_omniclass" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_omniclass">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_omniclass" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_omniclass" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnrefreshgrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_omniclass" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btn_refresh_grid_new">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_omniclass" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="rad_load_panel" Skin="Default" runat="server" Width="50px">
    </telerik:RadAjaxLoadingPanel>
    <%--</table>--%>
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
    <telerik:RadWindowManager ID="rd_manger_NewUI" runat="server" VisibleTitlebar="true"
        Title="<%$Resources:Resource,Create_Required_Attribute_Group%>" Behaviors="Close,Move"
        BorderWidth="0px" Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rd_window_new" runat="server" ReloadOnShow="false" Width="620" Height="500"
                AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" BorderColor="Black" EnableAjaxSkinRendering="false"
                EnableShadow="true" BackColor="Black" BorderWidth="2" Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_manger_new" runat="server" VisibleTitlebar="true"
        Title="<%$Resources:Resource,Add_Edit_Names%>" Behaviors="Close,Move" BorderWidth="0px"
        Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rdw_document" runat="server" ReloadOnShow="false" Width="350" Height="180"
                AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" BorderColor="Black" EnableAjaxSkinRendering="false"
                EnableShadow="true" BackColor="Black" BorderWidth="2" Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_manger_naming" runat="server" VisibleTitlebar="true"
        Title="<%$Resources:Resource,Add_Edit_Names%>" Behaviors="Close,Move" BorderWidth="0px"
        Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rdw_naming" runat="server" ReloadOnShow="false" Width="450"
                AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" BorderColor="Black" EnableAjaxSkinRendering="false"
                EnableShadow="true" BackColor="Black" BorderWidth="2" Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rg_manager_edit_doc" VisibleTitlebar="true" runat="server"
        Title="<%$Resources:Resource,Add_Edit_Document%>" Behaviors="Close,Move" BorderWidth="0px"
        Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rdw_edit_doc" runat="server" ReloadOnShow="false" Width="480"
                AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" BorderColor="Black" EnableAjaxSkinRendering="false"
                EnableShadow="true" BackColor="Black" BorderWidth="2" Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rg_manager_add_attribute" runat="server" VisibleTitlebar="true"
        Title="<%$Resources:Resource,Add_Edit_Names%>" Behaviors="Close,Move" BorderWidth="0px"
        Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rdw_attribute" runat="server" ReloadOnShow="false" Width="550"
                AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" BorderColor="Black" EnableAjaxSkinRendering="false"
                EnableShadow="true" BackColor="Black" BorderWidth="2" Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rg_manager_job_template" runat="server" VisibleTitlebar="false"
        Title="<%$Resources:Resource,Job_Template%>" Behaviors="Move" BorderWidth="0px"
        Skin="" BorderColor="Transparent" AutoSize="true" AutoSizeBehaviors="Height">
        <Windows>
            <telerik:RadWindow ID="rdw_job_template" runat="server" ReloadOnShow="false" Width="620"
                Height="500" DestroyOnClose="false" AutoSize="true" AutoSizeBehaviors="Height"
                OffsetElementID="btn_search" VisibleStatusbar="false" VisibleOnPageLoad="false"
                EnableAjaxSkinRendering="false" EnableShadow="true" BackColor="Black" BorderWidth="0"
                Overlay="false" Skin="">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <style>
        .rwWindowContent
        {
            border-width: 0px;
            border: 0px none transparent;
        }
    </style>
</asp:Content>
