<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Classification.aspx.cs" Inherits="App_Settings_Classification" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <style type="text/css">
        .table_group
        {
            border-collapse: collapse;
        }
    </style>
</head>
<body style="background: transparent; background-image: url('../Images/asset_zebra-bkgrd_gray2.PNG');
    padding: 0px; margin: 0px 0px 0px 0px;">
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager" EnableScriptCombine="false">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <telerik:RadFormDecorator ID="rdclassification" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <table width="100%">
        <tr>
            <td style="width: 10%;">
                <asp:Button runat="server" ID="btn_add" Text="<%$Resources:Resource,Add_Classification%>"
                    Width="100%" Font-Bold="true" OnClientClick="javascript:return Classification_popup();" />
            </td>
            <td style="width: 90%;" colspan="3">
            </td>
        </tr>
        <tr>
            <td colspan="4">
            </td>
        </tr>
    </table>
    <table width="100%" style="height: 100%;">
        <%--Grid table --%>
        <tr>
            <td>
                <telerik:RadGrid ID="rg_classification" runat="server" ShowStatusBar="true" Width="100% "
                    AutoGenerateColumns="False" AllowSorting="True" AllowMultiRowSelection="true"
                    AllowPaging="True" OnDetailTableDataBind="rg_classification_DetailTableDataBind"
                    OnNeedDataSource="rg_classification_NeedDataSource" OnItemCommand="rg_classification_ItemCommand"
                    OnPreRender="rg_classification_PreRender" PagerStyle-VerticalAlign="Bottom" PagerStyle-Mode="NextPrevAndNumeric"
                    PagerStyle-AlwaysVisible="true" ShowFooter="true" OnItemDataBound="rg_classification_ItemDataBound">
                    <PagerStyle Mode="NextPrevAndNumeric"></PagerStyle>
                    <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" VerticalAlign="Middle" />
                    <FooterStyle Height="23px" Font-Names="Arial" />
                    <ClientSettings>
                        <Selecting AllowRowSelect="true" CellSelectionMode="MultiCell" />
                        <Scrolling AllowScroll="true" ScrollHeight="350" UseStaticHeaders="true" />
                        <ClientEvents OnGridCreated="GridCreated" />
                    </ClientSettings>
                    <MasterTableView DataKeyNames="pk_standard_id" AllowMultiColumnSorting="True" Width="99.99%"
                        ShowFooter="false">
                        <ItemStyle Height="20px" Font-Names="Arial" Font-Size="10" VerticalAlign="Middle" />
                        <AlternatingItemStyle Height="20px" Font-Names="Arial" Font-Size="10" VerticalAlign="Middle" />
                        <HeaderStyle Height="25px" Font-Names="Arial" Font-Size="10" VerticalAlign="Bottom" />
                        <Columns>
                            <%--columns from outermost table--%>
                            <telerik:GridBoundColumn SortExpression="pk_standard_id" HeaderText="pk_standard_id"
                                HeaderButtonType="TextButton" DataField="pk_standard_id" Visible="false">
                                <HeaderStyle Width="0%" Wrap="false" />
                                <ItemStyle Width="0%" Wrap="false" />
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="standard_name" UniqueName="standard_name"
                                CommandName="standard_details" HeaderText="<%$Resources:Resource, name%>">
                                <HeaderStyle Width="30%" Wrap="false" />
                                <ItemStyle Width="30%" Wrap="false" />
                            </telerik:GridButtonColumn>
                            <%--<telerik:GridBoundColumn SortExpression="standard_name" UniqueName="standard_name"
                                HeaderButtonType="TextButton" DataField="standard_name" HeaderText="name">
                                <HeaderStyle Width="30%" Wrap="false" />
                                <ItemStyle Width="30%" Wrap="false" />
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="<%$Resources:Resource, Details%>"
                                UniqueName="details">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btn_Assign_Standard_Details" runat="server" ImageUrl="~/App/Images/Icons/asset_add_sm.png"
                                        CommandName="details" CausesValidation="false" AlternateText="<%$Resources:Resource, Details%>" />
                                </ItemTemplate>
                                <HeaderStyle Width="30%" HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle Width="30%" HorizontalAlign="Center" Wrap="false" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn SortExpression="Default_standard" UniqueName="Default_standard"
                                HeaderButtonType="TextButton" DataField="Default_standard" HeaderText="Default_flag">
                                <HeaderStyle Width="0%" Wrap="false" />
                                <ItemStyle Width="0%" Wrap="false" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="<%$Resources:Resource, Delete%>"
                                UniqueName="delete">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btn_delete" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                        CommandName="delete" CausesValidation="false" AlternateText="<%$Resources:Resource, Delete%>" />
                                </ItemTemplate>
                                <HeaderStyle Width="30%" HorizontalAlign="Center" Wrap="false" />
                                <ItemStyle Width="30%" HorizontalAlign="Center" Wrap="false" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div style="display: none;">
        <asp:HiddenField runat="server" ID="hfClassificationPageSize" />
        <asp:HiddenField runat="server" ID="hf_pk_standard_id" />
        <asp:HiddenField runat="server" ID="hf_default_standard" Value="N" />
        <asp:Button runat="server" ID="btn_refresh_details_grid" OnClick="btn_refresh_details_grid_Click"
            CausesValidation="false" />
    </div>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_classification">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_classification" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_save_std_details">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btn_save_std_details" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txt_standard_details_name" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txt_standard_code" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="lbl_msg" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_refresh_details_grid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_classification_details" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rg_classification_details">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_classification_details" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_delete_detail">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_classification_details" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <%--<telerik:AjaxSetting AjaxControlID="cmb_select_entity">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_classification_details" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
            <telerik:AjaxSetting AjaxControlID="btn_search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_classification_details" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager Visible="true" ID="rad_window_classification" VisibleStatusbar="false"
        AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server"
        KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_spaces_popup" runat="server" Animation="Slide"
                Behaviors="Move, Resize" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="false"
                AutoSize="false" Width="330" Height="152" VisibleStatusbar="false" VisibleOnPageLoad="false"
                Top="15px" Left="300px" Skin="">
                <ContentTemplate>
                    <table style="background-image: url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px;
                        margin: 0px 0px 0px 0px; width: 100%;">
                        <tr style="width: 100%;">
                            <td class="wizardHeadImage" colspan="3">
                                <div class="wizardLeftImage">
                                    <asp:Label ID="lbl_Add_Classification" Text="<%$Resources:Resource,Add_Classification%>"
                                        Font-Names="Verdana" Font-Size="11pt" runat="server"></asp:Label>
                                </div>
                                <div class="wizardRightImage">
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                        OnClick="btn_close_Click" CausesValidation="false" />
                                    <%--OnClientClick="javascript:return CloseWindow();" --%>
                                </div>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr style="height: 10px;">
                            <td colspan="3">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 3%;">
                            </td>
                            <th style="width: 17%;">
                                <asp:Label runat="server" ID="lbl_Standard_name" Text="<%$Resources:Resource,Name%>"></asp:Label>:
                            </th>
                            <td style="width: 80%;">
                                <asp:TextBox runat="server" ID="txt_Standard_name" Width="80%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="req_Standard_name" runat="server" ControlToValidate="txt_Standard_name"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr style="height: 10px;">
                            <td colspan="3">
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td colspan="2">
                                <asp:Button runat="server" ID="btn_save_classification" Text="<%$Resources:Resource, Save%>"
                                    OnClick="btn_save_standard_click" CausesValidation="true" />
                                <asp:Button ID="btnClose" runat="server" Text="<%$Resources:Resource, Cancel%>" skin="Default"
                                    OnClick="btn_close_Click" CausesValidation="false" />
                            </td>
                        </tr>
                        <tr style="height: 13px;">
                            <td colspan="2">
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager Visible="true" ID="rad_window_classification_details" VisibleStatusbar="false"
        AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server"
        KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow Visible="true" ID="RadWindow2" runat="server" Animation="Slide"
                Behaviors="Move" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="false"
                AutoSize="false" Width="450" Height="224" VisibleStatusbar="false" VisibleOnPageLoad="false"
                Top="15px" Left="200px" Skin="">
                <ContentTemplate>
                    <asp:Panel runat="server" ID="pnl_details_window" DefaultButton="btn_save_std_details">
                        <table style="background-image: url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px;
                            margin: 0px 0px 0px 0px; width: 100%;">
                            <tr style="width: 100%;">
                                <td class="wizardHeadImage">
                                    <div class="wizardLeftImage">
                                        <asp:Label ID="lbl" Text="<%$Resources:Resource,Add_Classification_Details%>" Font-Names="Verdana"
                                            Font-Size="11pt" runat="server"></asp:Label>
                                    </div>
                                    <div class="wizardRightImage">
                                        <asp:ImageButton ID="btn_close_details" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                            OnClick="btn_close_Click" CausesValidation="false" />
                                        <%--OnClientClick="javascript:return CloseWindow();" --%>
                                    </div>
                                </td>
                            </tr>
                            <tr style="height: 10px;">
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 10px;">
                                    <table width="100%">
                                        <tr>
                                            <th style="width: 40%;">
                                                <asp:Label runat="server" ID="lbl_standard_code" Text="<%$Resources:Resource,Classification_Detail_Code%>" />:
                                            </th>
                                            <td style="width: 55%;">
                                                <asp:TextBox runat="server" ID="txt_standard_code" Width="97%"></asp:TextBox>
                                            </td>
                                            <td style="width: 3%;">
                                                <asp:RequiredFieldValidator ID="req_txt_standard_code" runat="server" ControlToValidate="txt_standard_code"
                                                    ErrorMessage="*" ValidationGroup="val_details_group"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>
                                                <asp:Label runat="server" ID="lbl_standard_details_name" Text="<%$Resources:Resource,Classification_Detail_Name%>" />:
                                            </th>
                                            <td>
                                                <asp:TextBox runat="server" ID="txt_standard_details_name" Width="97%"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="req_txt_standard_details_name" runat="server" ControlToValidate="txt_standard_details_name"
                                                    ErrorMessage="*" ValidationGroup="val_details_group"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>
                                                <asp:Label runat="server" ID="lbl_entity" Text="<%$Resources:Resource, Entity%>" />:
                                            </th>
                                            <td>
                                                <telerik:RadComboBox ID="cmbentity" runat="server" Width="100%" Filter="Contains"
                                                    ViewStateMode="Enabled" AllowCustomText="true">
                                                </telerik:RadComboBox>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="req_cmbentity" runat="server" ControlToValidate="cmbentity"
                                                    ErrorMessage="*" ValidationGroup="val_details_group"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr style="height: 10px;">
                                            <td colspan="3">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Button runat="server" ID="btn_save_std_details" Text="<%$Resources:Resource, Save%>"
                                                                OnClick="btn_save_standard_details_click" CausesValidation="true" ValidationGroup="val_details_group" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btn_cancel_details" runat="server" Text="<%$Resources:Resource, Close%>"
                                                                skin="Default" OnClick="btn_close_Click" CausesValidation="false" />
                                                        </td>
                                                    </tr>
                                                    <tr style="height: 15px;">
                                                        <th colspan="2">
                                                            <asp:Label runat="server" ID="lbl_msg"></asp:Label>
                                                        </th>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="height: 5px;">
                                <td>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </ContentTemplate>
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager Visible="true" ID="rad_window_show_classification_details"
        BorderWidth="0" VisibleStatusbar="false" AutoSize="false" EnableShadow="true"
        ShowOnTopWhenMaximized="false" runat="server" KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow Visible="true" ID="RadWindow3" runat="server" Animation="Slide"
                Behaviors="Move" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="false"
                BorderWidth="0" AutoSize="false" Width="650" Height="430" VisibleStatusbar="false"
                VisibleOnPageLoad="false" Top="15px" Left="200px" Skin="">
                <ContentTemplate>
                    <asp:Panel runat="server" ID="Panel1" DefaultButton="btn_search">
                        <table class="table_group" style="background-image: url('../Images/asset_zebra-bkgrd_gray2.PNG');
                            padding: 0px; margin: 0px 0px 0px 0px; width: 100%; overflow: hidden;" border="0">
                            <tr style="width: 100%;">
                                <td class="wizardHeadImage">
                                    <div class="wizardLeftImage">
                                        <asp:Label ID="lbl_classification_details" Text="<%$Resources:Resource,Classifications %>"
                                            Font-Names="Verdana" Font-Size="11pt" runat="server"></asp:Label>
                                    </div>
                                    <div class="wizardRightImage">
                                        <asp:ImageButton ID="img_btn_close_details" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                            OnClick="btn_close_Click" CausesValidation="false" />
                                        <%--OnClientClick="javascript:return CloseWindow();" --%>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 0px; margin: 0px 0px 0px 0px;">
                                    <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader"
                                        style="width: 100%">
                                        <tr>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width: 50%">
                                                <asp:Label runat="server" Text="<%$Resources:Resource, Assigned_Classifications%>" ID="lbl_grid_head" CssClass="gridHeadText"
                                                    Width="200px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                            </td>
                                            <%--<td align="right" class="collapsRemove" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" ID="lbl_select_entity" Text="<%$Resources:Resource,Entity %>"></asp:Label>:
                                            </td>--%>
                                            <td align="right" class="collapsRemove" onclick="stopPropagation(event)" style="width: 25%">
                                                <telerik:RadComboBox ID="cmb_select_entity" runat="server" Width="100%" Filter="Contains"
                                                    ViewStateMode="Enabled" AllowCustomText="true" OnClientDropDownClosed="refresh"
                                                    CausesValidation="false">
                                                </telerik:RadComboBox>
                                                <%--OnSelectedIndexChanged="cmb_select_entity_SelectedIndexChanged" --%>
                                            </td>
                                            <td align="right" class="collapsRemove" onclick="stopPropagation(event)" style="width: 25%">
                                                <div id="div_search" style="background-color: White; width: 170px;">
                                                    <table  cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                        width: 100%;">
                                                        <tr style="border-spacing: 0px;">
                                                            <td align="left" onclick="stopPropagation(event)" width="70%" rowspan="0px" style="background-color: White;
                                                                height: 14px; padding-bottom: 0px;">
                                                                <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                    Height="100%" onclick="stopPropagation(event)" EmptyMessage="Search" BorderColor="White"
                                                                    ID="txt_search" Width="100%">
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                                padding-bottom: 0px;">
                                                                <asp:ImageButton ClientIDMode="Static" ID="btn_search" Height="13px" runat="server"
                                                                    ImageUrl="~/App/Images/Icons/icon_search_sm.png" CausesValidation="false" OnClick="btn_search_click" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table width="100%" class="table_group" border="0">
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="rg_classification_details" runat="server" ShowStatusBar="true"
                                        AllowSorting="true" Width="100% " AutoGenerateColumns="False" AllowMultiRowSelection="true"
                                        AllowPaging="True" BorderWidth="0" OnDetailTableDataBind="rg_classification_details_DetailTableDataBind"
                                        OnNeedDataSource="rg_classification_details_NeedDataSource" OnItemCommand="rg_classification_details_ItemCommand"
                                        OnItemDataBound="rg_classification_details_ItemDataBound" OnPreRender="rg_classification_details_PreRender"
                                        PagerStyle-VerticalAlign="Bottom" PagerStyle-Mode="NextPrevAndNumeric" PagerStyle-AlwaysVisible="true"
                                        ShowFooter="true" PageSize="10">
                                        <PagerStyle Mode="NextPrevAndNumeric"></PagerStyle>
                                        <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" VerticalAlign="Middle" />
                                        <FooterStyle Height="23px" Font-Names="Arial" />
                                        <ClientSettings>
                                            <Selecting AllowRowSelect="true" CellSelectionMode="MultiCell" />
                                            <Scrolling AllowScroll="true" ScrollHeight="280" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <MasterTableView DataKeyNames="CategoryID" AllowMultiColumnSorting="True" Width="99.99%"
                                            ShowFooter="false">
                                            <ItemStyle Height="20px" Font-Names="Arial" Font-Size="10" VerticalAlign="Middle" />
                                            <AlternatingItemStyle Height="20px" Font-Names="Arial" Font-Size="10" VerticalAlign="Middle" />
                                            <HeaderStyle Height="20px" Font-Names="Arial" Font-Size="10" VerticalAlign="Bottom" />
                                            <Columns>
                                                <%--columns from outermost table--%>
                                                <telerik:GridBoundColumn SortExpression="CategoryID" HeaderText="CategoryID" HeaderButtonType="TextButton"
                                                    DataField="CategoryID" Visible="false">
                                                    <HeaderStyle Width="0%" Wrap="false" />
                                                    <ItemStyle Width="0%" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn SortExpression="Category" HeaderText="<%$Resources:Resource, Category%>"
                                                    HeaderButtonType="TextButton" DataField="Category" Visible="true">
                                                    <HeaderStyle Width="70%" Wrap="false" />
                                                    <ItemStyle Width="70%" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="<%$Resources:Resource, Delete%>"
                                                    UniqueName="delete">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="btn_delete_detail" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                                            CommandName="delete_detail" CausesValidation="false" AlternateText="<%$Resources:Resource, Delete%>" />
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="30%" HorizontalAlign="Center" Wrap="false" />
                                                    <ItemStyle Width="30%" HorizontalAlign="Center" Wrap="false" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </ContentTemplate>
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadCodeBlock ID="loadPopUp" runat="server">
        <script language="javascript" type="text/javascript">

            function Classification_popup() {

                //url = "../Locations/AssignSpace.aspx?id=f758670f-dad4-4809-944e-6d662a18c560"; //document.getElementById('hf_zone_id').value;
                // var url = "../Locations/AssignSpace.aspx?id=d259ae75-8b34-4a4b-bded-15a719dcb45a&flag=zonepm";

                manager = $find("<%= rad_window_classification.ClientID %>");
                var windows = manager.get_windows();
                document.getElementById("<%=txt_Standard_name.ClientID %>").focus();
                windows[0].show();

                //windows[0].setUrl(url);

                return false;
            }

            function Classification_details_popup(pk_standard_id) {

                document.getElementById("<%= hf_pk_standard_id.ClientID %>").value = pk_standard_id;
                document.getElementById("<%= lbl_msg.ClientID %>").innerText = "";
                manager = $find("<%= rad_window_classification_details.ClientID %>");
                var windows = manager.get_windows();
                windows[0].show();

                //windows[0].setUrl(url);

                return false;
            }

            function Show_classification_details_popup(pk_standard_id, flag) {

                document.getElementById("<%=hf_default_standard.ClientID %>").value = flag;
                document.getElementById("<%= hf_pk_standard_id.ClientID %>").value = pk_standard_id;
                document.getElementById("<%= btn_refresh_details_grid.ClientID %>").click();
                manager = $find("<%= rad_window_show_classification_details.ClientID %>");
                var windows = manager.get_windows();
                windows[0].show();

                //windows[0].setUrl(url);

                return false;
            }


            function refresh(sender, eventArgs) {
                document.getElementById("<%= btn_refresh_details_grid.ClientID %>").click();
            }
        </script>
    </telerik:RadCodeBlock>
    </form>
</body>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script src="../../App_Themes/EcoDomus/jquery-1.8.3.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">

        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {

            //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
            var pageSize = document.getElementById("<%=hfClassificationPageSize.ClientID %>").value;
            //alert(pageSize);
            var scrollArea = sender.GridDataDiv;
            var dataHeight = sender.get_masterTableView().get_element().clientHeight;
            //sender.get_masterTableView().set_pageSize(pageSize);
            if (dataHeight < parseInt(pageSize) * 32) {
                scrollArea.style.height = dataHeight + "px";
            }
            else {
                scrollArea.style.height = (parseInt(pageSize) * 32 - 12) + "px";
            }
        }

        function GetRadWindow() {

            var oWindow = null;
            if (window.rad_window_classification) oWindow = window.rd_spaces_popup;
            else if (window.frameElement.rad_window_classification) oWindow = window.frameElement.rad_window_classification;
            return oWindow;
        }

        function CloseWindow() {

            GetRadWindow().Hide();

            //            var window = $find('<%=rad_window_classification.ClientID %>');
            //            window.Close;

            return false;
        }
       
    </script>
</telerik:RadCodeBlock>
</html>
