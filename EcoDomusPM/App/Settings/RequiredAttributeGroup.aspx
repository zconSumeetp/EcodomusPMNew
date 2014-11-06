<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RequiredAttributeGroup.aspx.cs"
    Inherits="App_Settings_RequiredAttributeGroup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="uc" TagName="PropertyValueControl" Src="~/App/UserControls/PropertyValueControl/PropertyValueControl.ascx" %>
<%@ Reference Control="~/App/UserControls/UCAttributeDetails.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript">

    function onTabSelecting(sender, args) {
        if (args.get_tab().get_pageViewID()) {
            args.get_tab().set_postBack(false);
        }
    }

    function chkselect() {
        alert("Please select Group");
        return false;
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    }
    function adjust_height() {

        var wnd = GetRadWindow();
        if (wnd != null) {
            var bounds = wnd.getWindowBounds();
            var x = bounds.x;
            wnd.moveTo(x - 40, 50);
            wnd.set_height(350);
        }

    }

    function deleteItem() {
        var flag;
        flag = confirm("Are you sure you want to delete this Template?");
        return flag;
    }

    var RequiredAttributeGroupLib = {
        AttributeGroup: {
            SetAttributeWindowHeight: function() {
                var wnd = GetRadWindow();
                wnd.set_height(500);
            },
            SetAttributeWindowFullHeight :function() {
                var wnd = GetRadWindow();
                wnd.set_height(550);
            }
        },
        AttributeDetail: {
            SetAttributeWindowHeight: function() {
                var wnd = GetRadWindow();
                wnd.set_height(580);
            },
            SetAttributeWindowHeightSmall : function() {
                var wnd = GetRadWindow();
                wnd.set_height(400);
            }
        }
    }

    function delete_attribute() {

        var flag = confirm("Do you want to delete this attribute?");
        return flag;
    }

    function ViewAddAtrributesDialogPath() {
        $('#tr_add_attribute').css('display', 'block');
        RequiredAttributeGroupLib.AttributeDetail.SetAttributeWindowHeight();
    }

    function GridCreated(sender, args) {

        var size = sender.get_element().style.width;
        var height = sender.get_element().style.height;
    }

    
    function CloseWindow() {
        window.parent.refreshgrid_new();
        window.close();
        return false;
    }
    function LogoutNavigation() {
        var query = parent.location.href;
        top.location.href(query);
    }


</script>
<head runat="server">
    <style type="text/css">
        .rtsSelected
        {
            background-color: transparent;
            font-weight: bold;
            font-size: 14px;
            font-family: "Arial" , sans-serif;
        }
        
        .rtsIn
        {
            background-color: transparent;
            color: #696969;
        }
        .rtsTxt
        {
            padding-left: 0px !important;
            text-align: center !important;
            margin-top: 10px;
        }
        .rtsImg
        {
            background-color: transparent;
            width: 22px;
            height: 40px;
            margin: 0px;
        }
        
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
    <title></title>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
</head>
<body style="background-color: #EEEEEE; padding: 0px; margin: 0 0 0 0; width: 100%">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </asp:ScriptManager>
    <telerik:RadAjaxManager runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadComboBoxAttributeType">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PropertyValueControl" LoadingPanelID="LaodingPanel1"
                        UpdatePanelHeight="100%" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="TestCombo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="TestText" LoadingPanelID="LaodingPanel1" UpdatePanelHeight="100%" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div style="padding-left: 0px; width: 100%; background-color: #EEEEEE; border: 2px">
        <table width="100%">
            <tr style="display: none;">
                <td class="wizardHeadImage">
                    <div class="wizardLeftImage">
                        <asp:Label ID="Label1" runat="server" Font-Size="10pt" Text="<%$Resources:Resource,Create_Required_Attribute_Group%>"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClientClick=" javascript:return CloseWindow();" OnClick="ibtn_close_Click"
                            Style="height: 16px" />
                    </div>
                </td>
            </tr>
            <tr>
                <td style="background-color: #F7F7F7;">
                    
                    <div runat="server" ID="AttributeGroupPanel" Visible="True">
                        <div style="padding-left: 0px; margin: 0px 0px 20px 0px; width: 100%">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" style="padding-left: 10px;
                                padding-right: 10px;">
                                <tr>
                                    <td align="right">
                                        <asp:Panel ID="panel2" runat="server" DefaultButton="btn_search">
                                            <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                                <tr>
                                                    <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                        <asp:Label runat="server" Text="<%$Resources:Resource, Attribute_Group%>" ID="Label2"
                                                            CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Font-Names="Arial"
                                                            Font-Size="12"></asp:Label>
                                                    </td>
                                                    <td align="right">
                                                        <div id="div1" style="background-color: White; width: 170px;">
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
                                                    <td align="center" style="padding-right: 05px" class="dropDownImage">
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
                                            <telerik:RadGrid runat="server" ID="RadGrid1" BorderWidth="1px" AllowPaging="true"
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
                                        <table id="Table1" runat="server" visible="false" width="100%">
                                            <tr>
                                                <td style="height: 10px; width: 150px;">
                                                    <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,Attribute_Group_Name%>"
                                                        CssClass="Label"></asp:Label>:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="TextBox1" runat="server" Height="15px" CssClass="textbox" AutoPostBack="False"
                                                        Width="207px"></asp:TextBox>
                                                    <asp:Label ID="lblError" runat="server" ForeColor="Red" Text=""></asp:Label>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1AttributeGroup" ClientIDMode="Static" ValidationGroup="req" runat="server"
                                                        ForeColor="Red" ControlToValidate="TextBox1" ErrorMessage="*" Display="Dynamic">
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
                                                    <asp:Button ID="Button1" runat="server" Text="<%$Resources:Resource,Save%>" Width="80px" ValidationGroup="req"
                                                        OnClick="btnAttributeGroup_save_Click"  />
                                                </td>
                                                <td align="left">
                                                    <asp:Button ID="Button4" runat="server" Text="<%$Resources:Resource,Cancel%>" Width="80px"
                                                        OnClick="btnAttributeGroup_cancel_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 10px;">
                                        <asp:HiddenField ID="hf_temp_group_id" runat="server" />
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
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
                                                    <asp:ImageButton ID="ImageButton1" runat="server" Width="10" ImageUrl="~/App/Images/Icons/arrow_left.gif"
                                                        Enabled="false" OnClick="ibtn_back_Click" ImageAlign="Top" CssClass="lnkButtonImg" />
                                                </td>
                                                <td valign="top">
                                                    <asp:LinkButton ID="LinkButton1" runat="server" Text="Back" CssClass="disableLinkButton"
                                                        Font-Underline="false" Enabled="false" OnClick="lbtn_back_Click"></asp:LinkButton>
                                                </td>
                                                <td style="padding-left: 25px; padding-right: 25px" valign="middle">
                                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/App/Images/Icons/asset_scrollbar_bar.png"
                                                        Width="2px" Height="10px" />
                                                </td>
                                                <td valign="top">
                                                    <asp:LinkButton ID="LinkButton2" runat="server" Text="Next" Font-Underline="false"
                                                        OnClick="lbtnGroup_next_Click" CssClass="lnkButton"></asp:LinkButton>
                                                </td>
                                                <td valign="bottom">
                                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm.png"
                                                        OnClick="ibtnGroup_next_Click" CssClass="lnkButtonImg" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    

                    <div  id="AttributeDetailPanel" runat="server" Visible="False">
                        <div style="padding-left: 0; margin: 0; width: 100%">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" style="padding-left: 10px;
                                padding-right: 10px;">
                                <tr align="center">
                                    <td align="right">
                                        <asp:Panel ID="panel1" runat="server" DefaultButton="btn_search1">
                                            <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                                <tr>
                                                    <td align="left" class="entityImage">
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
                                                    <td align="center" style="padding-right: 05px;" class="dropDownImage">
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadGrid runat="server" ID="rg_attribute_group" BorderWidth="1px" AllowPaging="true"
                                            PageSize="7" AutoGenerateColumns="False" AllowSorting="True" PagerStyle-AlwaysVisible="true"
                                            Visible="true" Skin="Default" Width="100%" OnSortCommand="rg_attribute_group_SortCommand"
                                            OnPageIndexChanged="rg_attribute_group_PageIndexChanged" OnPageSizeChanged="rg_attribute_group_PageSizeChanged"
                                            OnItemCommand="rg_attribute_group_OnItemCommand">
                                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="50%" AlwaysVisible="true"
                                                Wrap="false" />
                                            <ClientSettings>
                                                <ClientEvents OnGridCreated="GridCreated" />
                                                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="220" />
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="GroupId,AttributeName,AttributeValueDto.DisplayUnitType"
                                                ClientDataKeyNames="GroupId">
                                                <Columns>
                                                    <telerik:GridEditCommandColumn HeaderStyle-Width="1%" ButtonType="ImageButton" HeaderText="<%$Resources:Resource,Edit%>"
                                                        UniqueName="EditCommandColumn" ItemStyle-Width="1%">
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridBoundColumn DataField="GroupId" HeaderText="GroupId"
                                                        Visible="false">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Value" HeaderText="Value" Visible="false">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn Resizable="false" DataField="AttributeName" HeaderStyle-Width="5%"
                                                        HeaderText="<%$Resources:Resource,Attribute_Name%>" UniqueName="AttributeName"
                                                        SortExpression="AttributeName">
                                                        <HeaderStyle />
                                                        <ItemStyle CssClass="column" Width="15%" HorizontalAlign="Left" />
                                                        <HeaderStyle HorizontalAlign="Left" Width="15%" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Description" Resizable="false" HeaderStyle-Width="3%"
                                                        HeaderText="<%$Resources:Resource,Abbreviation%>" UniqueName="Description" SortExpression="description">
                                                        <HeaderStyle />
                                                        <ItemStyle CssClass="column" Width="3%" />
                                                        <HeaderStyle CssClass="column" Width="3%" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="AttributeType" Resizable="False"
                                                        HeaderStyle-Width="3%" Visible="false" HeaderText="" UniqueName="AttributeType"
                                                        SortExpression="AttributeType">
                                                        <HeaderStyle />
                                                        <ItemStyle CssClass="column" Width="3%" />
                                                        <HeaderStyle CssClass="column" Width="3%" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="AttributeValueDto.DisplayUnitType" Resizable="False"
                                                        HeaderStyle-Width="3%" Visible="false" HeaderText="" UniqueName="DisplayUnitType"
                                                        SortExpression="DisplayUnitType">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="AttributeValueDto.IntegerValue" Resizable="False"
                                                        HeaderStyle-Width="3%" Visible="false" HeaderText="" UniqueName="IntegerValue"
                                                        SortExpression="IntegerValue">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="AttributeValueDto.StringValue" Resizable="False"
                                                        HeaderStyle-Width="3%" Visible="false" HeaderText="" UniqueName="StringValue"
                                                        SortExpression="StringValue">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="AttributeValueDto.DateTimeValue" Resizable="False"
                                                        HeaderStyle-Width="3%" Visible="false" HeaderText="" UniqueName="DateTimeValue"
                                                        SortExpression="DateTimeValue">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="AttributeValueDto.DoubleValue" Resizable="False"
                                                        HeaderStyle-Width="3%" Visible="false" HeaderText="" UniqueName="DoubleValue"
                                                        SortExpression="DoubleValue">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Value" Resizable="false" HeaderStyle-Width="3%"
                                                        HeaderText="<%$Resources:Resource,Value%>" UniqueName="Value" SortExpression="Value">
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
                                             OnClientClick="ViewAddAtrributesDialogPath(); return false;"></asp:Button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table id="tbl_add" width="100%" style="display: none">
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
                                <tr id="tr_add_attribute" style="display: none">
                                    <td>
                                        <table id="tbl_add_details" runat="server" width="100%">
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="lblName" CssClass="Label" runat="server" Text="<%$Resources:Resource,Name%>">:</asp:Label>:
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtaddattribute" CssClass="textbox" runat="server" CausesValidation="true"
                                                        Width="164"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="CheckValidAttributeName" ClientIDMode="Static" ValidationGroup="attributeDetaildNewEdit" 
                                                    ControlToValidate="txtaddattribute" ErrorMessage="*" ForeColor="Red" />
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
                                                    <telerik:RadComboBox ID="RadComboBoxAttributeType" runat="server" Height="100" CssClass="DropDown"
                                                                         OnSelectedIndexChanged="RadComboBoxAttributeType_OnSelectedIndexChanged" Width="168"
                                                                         OnItemDataBound="RadComboBoxAttributeType_OnItemDataBound" AutoPostBack="True" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 10px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 40px; width: 40px">
                                                    <asp:Button ID="Button2" runat="server" Text="<%$Resources:Resource,Save%>" Width="80px" ValidationGroup="attributeDetaildNewEdit"
                                                        OnClick="btn_save_Click" />
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
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                 <%--   <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" OnPageViewCreated="RadMultiPage1_PageViewCreated"
                        CssClass="multiPage">
                    </telerik:RadMultiPage>--%>
                </td>
            </tr>
        </table>
    </div>
    
    
                                                    
                                                    
    <asp:HiddenField ID="hfTemplate_id" runat="server" />
    <asp:HiddenField ID="hf_entity_id" runat="server" />
    <asp:HiddenField ID="hf_group_id" runat="server" />
    <asp:HiddenField ID="hf_flag" runat="server" />
    <asp:HiddenField ID="hf_flag_first" runat="server" />
    <asp:HiddenField ID="hf_tab_click" runat="server" />
    </form>
</body>
</html>
