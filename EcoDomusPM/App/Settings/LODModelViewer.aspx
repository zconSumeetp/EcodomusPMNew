<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LODModelViewer.aspx.cs" Inherits="App_Settings_LODModelViewer" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .rpbItemHeader
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray1.png');
            padding: 4px;
            font-family: Arial;
        }
        
        .gridHeaderGray
        {
            background-color: #bdbdbd;
            text-align: center;
            font-family: Arial;
            font-weight: bold;
            font-size: 11px;
        }
        
        .gridHeaderGray a
        {
            text-decoration: none;
            color: Black;
        }
        
        .lnkReport
        {
            color: Black;
        }
        
        .gridItemGray
        {
            background-color: #d9d9d9;
        }
        
        .tdGrayHeaderReport
        {
            background-color: #bdbdbd;
            text-align: center;
            font-family: Arial;
            font-weight: bold;
            font-size: 14px;
            border-bottom: 1px solid Black;
            border-right: 1px solid Black;
        }
        
        .GridMainGray table th, .GridMainGray table td
        {
            border-right: solid 1px black;
        }
        
        .GridViewPointCompItem td, .GridViewPointCompAlt td, .GridViewPointCompHead
        {
            border-bottom: 2px solid;
            text-align: left;
            font-family: Arial;
            font-size: 12px;
            height: 25px;
        }
        
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        
        .gridPropertiesAlternateItem
        {
            background-color: #f5f5f5;
            height: 25px;
        }
        
        .gridPropertiesItem
        {
            background-color: White;
            height: 25px;
        }
        
        .NavigationTools
        {
            width: 200px;
            background-color: Red;
            position: absolute;
            top: 10%;
            z-index: 99999;
        }
        
        /*  .RadPanelGray .rpRootGroup
        {
            border: none !important;
        }*/
    </style>
</head>
<body style="padding: 0; margin: 0;" onload="body_load();">
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <telerik:RadCodeBlock ID="radcodeblock3" runat="server">
        <script language="javascript" type="text/javascript">
            function body_load() {
                var screenhtg = parseInt(window.screen.height * 0.60);
                document.getElementById("divComponentContent").style.height = screenhtg * 0.39;
                document.getElementById("divTypeContent").style.height = screenhtg * 0.39;
                document.getElementById("divdocumentContent").style.height = screenhtg * 0.23;
                document.getElementById("trbody").style.height = window.screen.height * 0.73;
                document.getElementById("divReportContent").style.height = window.screen.height * 0.29;
                document.getElementById("divViewpointsContent").style.height = screenhtg * 0.34;
                document.getElementById("divSelectedDomponentContent").style.height = screenhtg * 0.32;
                document.getElementById("divSystemContent").style.height = screenhtg * 0.32;
                document.getElementById("divSystemComponentsContent").style.height = screenhtg * 0.32;
                document.getElementById("divRoomDataSheetContent").style.height = screenhtg * 0.32;
                document.getElementById("divWorkordersContent").style.height = screenhtg * 0.32;
                $(".divScroll").niceScroll({ touchbehavior: false, cursorcolor: "#969696", cursoropacitymax: 0.8, cursorborder: "none", cursorwidth: 10, background: "#cccccc" });
                $("#divSelectedDomponentContent").show();
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
        <script language="javascript" type="text/javascript">
            function rd_document_onClientCommand(sender, args) {
                if (args.get_commandName() == "Edit") {
                    var itemIndex = args.get_commandArgument();
                    var document_id = sender.get_masterTableView().get_dataItems()[itemIndex].getDataKeyValue("document_id");
                    var entity_name = sender.get_masterTableView().get_dataItems()[itemIndex].getDataKeyValue("entity_name");
                    load_popup(document_id, null, entity_name);
                    args.set_cancel(true);
                }
            }

            function load_popup(pk_document_id, entity_id, entity_name) {

                if (document.getElementById("hf_component_id").value != "" && (document.getElementById("hf_category").value != "Floors" || document.getElementById("hf_category").value == "Generic Models"))//category is not floor for asset
                {
                    document.getElementById("hf_entity").value = "Asset";

                    var url = "../Locations/AddDocument.aspx?fk_row_id=" + document.getElementById("hf_component_id").value + "&Document_Id=" + pk_document_id + "&Flag=Model" + "&Item_type=Asset" + "&entity_name=" + entity_name + "&entity_id=" + entity_id;
                    window.open(url, '', 'width=700px,height=400px');
                }
                else if (document.getElementById("hf_component_id").value != "" && (document.getElementById("hf_category").value == "Floors" || document.getElementById("hf_category").value == "Generic Models"))//category is floor for space
                {
                    document.getElementById("hf_entity").value = "Space";
                    var url = "../Locations/AddDocument.aspx?fk_row_id=" + document.getElementById("hf_component_id").value + "&Document_Id=" + pk_document_id + "&Flag=Model" + "&Item_type=Space";
                    window.open(url, '', 'width=700px,height=400px');
                }

                else//I am not responsible other than floor
                {
                    alert("Please Select the Asset");
                }
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadCodeBlock ID="radCodeExpandCollapse" runat="server">
        <script language="javascript" type="text/javascript">
            function closeReportWindow() {
                $("#trReport").hide();
                document.getElementById("NWControl01").style.height = "100%";
            }

            function LeftMenu_expand_collapse(index) {
                var img = document.getElementById("LeftMenu_" + index + "_img_expand_collapse");
                $('.LeftMenu_' + index + '_Content').toggle();

                if (img.src.indexOf("asset_carrot_up") != -1) {
                    img.src = img.src.replace("asset_carrot_up", "asset_carrot_down");
                }
                else {
                    img.src = img.src.replace("asset_carrot_down", "asset_carrot_up");
                    if (index != 0) {
                        for (var i = 1; i <= 5; ++i) {
                            if (i != index) {
                                var itemImg = document.getElementById("LeftMenu_" + i + "_img_expand_collapse");
                                itemImg.src = itemImg.src.replace("asset_carrot_up", "asset_carrot_down");
                                $('.LeftMenu_' + i + '_Content').hide();
                            }
                        }
                    }
                }
                $(".divScroll").getNiceScroll().resize();
            }

            function RightMenu_expand_collapse(index) {
                var img = document.getElementById("RightMenu_" + index + "_img_expand_collapse");
                $('.RightMenu_' + index + '_Content').toggle();
                if (img.src.indexOf("asset_carrot_up") != -1) {
                    img.src = img.src.replace("asset_carrot_up", "asset_carrot_down");
                }
                else {
                    img.src = img.src.replace("asset_carrot_down", "asset_carrot_up");
                }
                $(".divScroll").getNiceScroll().resize();
            }

            function ReportMenu_expand_collapse(index) {
                var img = document.getElementById("ReportMenu_" + index + "_img_expand_collapse");
                $('.ReportMenu_' + index + '_Content').toggle();
                if (img.src.indexOf("asset_carrot_up") != -1) {
                    img.src = img.src.replace("asset_carrot_up", "asset_carrot_down");
                    document.getElementById("NWControl01").style.height = "95%";
                }
                else {
                    img.src = img.src.replace("asset_carrot_down", "asset_carrot_up");
                    document.getElementById("NWControl01").style.height = "55%";
                }
                $(".divScroll").getNiceScroll().resize();
            }
        </script>
    </telerik:RadCodeBlock>
    <div>
        <table style="width: 100%; margin: 0;" cellpadding="0" cellspacing="0">
            <tr id="trHead">
                <td style="width: 20%; padding: 0; border-bottom: 3px solid Black; background-color: Gray;
                    height: 40px;" valign="middle">
                    <table cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;">
                        <tr>
                            <td style="width: 85%;">
                                <asp:Image ImageUrl="~/App/Images/Icons/logo_final.png" runat="server" ID="imgLogo"
                                    Height="40px" />
                            </td>
                            <td style="padding-right: 8px; padding-left: 2px;">
                                <asp:LinkButton ID="lbtnVersion" Text="v1.5" runat="server" CssClass="VersionHead"
                                    OnClientClick="return ShowVersionInfo();"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td colspan="2" style="border-bottom: 3px solid Black; background-color: #F0F0EA;
                    padding-left: 8px;">
                    s
                </td>
            </tr>
            <tr id="trbody">
                <td valign="top">
                    <table style="border-collapse: collapse;" cellpadding="0" cellspacing="0" width="100%">
                        <tr id="trSearch">
                            <td>
                                <table style="width: 100%; border-collapse: collapse; background-image: url('../Images/asset_zebra-bkgrd_gray3.png');
                                    font-family: Arial; font-size: 11px;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="padding: 2px 0 0 8px;">
                                            SEARCH
                                        </td>
                                        <td style="padding-right: 20px; padding-top: 2px;" align="right">
                                            Equipment
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 2px 20px 4px 8px;" colspan="2">
                                            <table cellpadding="0px" cellspacing="0px" style="background-color: #fcfce1; width: 100%;">
                                                <tr>
                                                    <td align="left" width="90%" rowspan="0px" style="padding-bottom: 0px;">
                                                        <telerik:RadTextBox runat="server" BackColor="#fcfce1" BorderStyle="None" ID="txtSearch"
                                                            Width="100%">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td align="left" rowspan="0px" width="10%" style="height: 14px; padding-bottom: 0px;">
                                                        <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table style="border-collapse: collapse;" cellpadding="0" cellspacing="0" width="100%">
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="trViewPoints">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_BIMview_sm.png" ID="Image11" />
                                            </td>
                                            <td align="left" class="entityImage">
                                                <asp:Label runat="server" Text="VIEWPOINTS" Font-Size="11px" ID="Label9"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 8px 0 0px; width: 20px;">
                                                <asp:ImageButton ID="btnAddViewpoint" runat="server" ImageUrl="~/App/Images/Icons/asset_add_sm.png"
                                                    AlternateText="Add Viewpoint" OnClick="btnAddViewpoint_OnClick" />
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0; width: 20px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up.png" ClientIDMode="Static"
                                                    ID="LeftMenu_0_img_expand_collapse" onclick="LeftMenu_expand_collapse(0)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divViewpointsContent" class="divScroll LeftMenu_0_Content">
                                    View Points
                                </div>
                            </td>
                        </tr>
                        <tr id="trSelectedComponents">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <%--<td onclick="stopPropagation(event)" style="width: 10px; padding: 4px 0 0 0px;">
                                                    <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_BIMview_sm.png" ID="Image1" />
                                                </td>--%>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)" style="padding-left: 4px;">
                                                <asp:Label runat="server" Text="SELECTED ITEMS" Font-Size="11px" ID="Label10"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up.png" ClientIDMode="Static"
                                                    ID="LeftMenu_1_img_expand_collapse" onclick="LeftMenu_expand_collapse(1)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divSelectedDomponentContent" class="divScroll LeftMenu_1_Content" style="display: none">
                                    <telerik:RadGrid ID="rd_selected_components" Skin="" runat="server" AutoGenerateColumns="False"
                                        AllowSorting="False" GridLines="None" Font-Names="Arial" Font-Size="9">
                                        <ClientSettings>
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                            <Selecting AllowRowSelect="true" />
                                        </ClientSettings>
                                        <ItemStyle CssClass="GridViewPointCompItem" />
                                        <AlternatingItemStyle CssClass="GridViewPointCompAlt" />
                                        <HeaderStyle CssClass="GridViewPointCompHead" />
                                        <MasterTableView Width="100%">
                                            <Columns>
                                                <telerik:GridTemplateColumn ItemStyle-Width="4%">
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="component_name" HeaderText="Component" UniqueName="component_name"
                                                    ItemStyle-Width="35%" HeaderStyle-Width="35%">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="component_type" HeaderText="<%$Resources:Resource, Type%>"
                                                    UniqueName="component_type">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn UniqueName="EditCommandColumn1">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                        <tr id="trSystem">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_system_sm.png" ID="Image5" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="SYSTEM" Font-Size="11px" ID="Label5"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_down.png" ClientIDMode="Static"
                                                    ID="LeftMenu_2_img_expand_collapse" onclick="LeftMenu_expand_collapse(2)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divSystemContent" class="divScroll LeftMenu_2_Content" style="display: none;">
                                    System
                                </div>
                            </td>
                        </tr>
                        <tr id="trSystemComponents">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_system_components.png"
                                                    ID="Image8" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="SYSTEM ComponentS" Font-Size="11px" ID="Label6"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_down.png" ClientIDMode="Static"
                                                    ID="LeftMenu_3_img_expand_collapse" onclick="LeftMenu_expand_collapse(3)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divSystemComponentsContent" class="divScroll LeftMenu_3_Content" style="display: none;">
                                    System Components
                                </div>
                            </td>
                        </tr>
                        <tr id="trRoomDataSheet">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_Documents_sm.png" ID="Image10" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="ROOM DATA SHEET" Font-Size="11px" ID="Label7"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_down.png" ClientIDMode="Static"
                                                    ID="LeftMenu_4_img_expand_collapse" onclick="LeftMenu_expand_collapse(4)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divRoomDataSheetContent" class="divScroll LeftMenu_4_Content" style="display: none;">
                                    Room DataSheet
                                </div>
                            </td>
                        </tr>
                        <tr id="trWorkorders">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)" style="padding-left: 4px;">
                                                <asp:Label runat="server" Text="WORK ORDERS" Font-Size="11px" ID="Label8"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 8px 0 0px; width: 20px;" onclick="stopPropagation(event)">
                                                <asp:ImageButton ID="btnAddWorkorder" runat="server" ImageUrl="~/App/Images/Icons/asset_add_sm.png"
                                                    AlternateText="Add New Workorder" OnClick="btnAddWorkorder_OnClick" />
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0; width: 20px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_down.png" ClientIDMode="Static"
                                                    ID="LeftMenu_5_img_expand_collapse" onclick="LeftMenu_expand_collapse(5)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divWorkordersContent" class="divScroll LeftMenu_5_Content" style="display: none;">
                                    Room DataSheet
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                    <div id="divModel" style="min-height: 55%;" runat="server">
                    </div>
                    <table style="border-collapse: collapse;" cellpadding="0" cellspacing="0" width="100%">
                        <tr id="trReport">
                            <td>
                                <div class="gridRadPnlHeader" style="border-bottom: 1px solid Orange;">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td style="width: 25px; padding-left: 4px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_reports_sm_white.png"
                                                    Height="25" Width="25" ID="Image3" />
                                            </td>
                                            <td align="left" class="entityImage">
                                                <asp:Label runat="server" Text="REPORT" ID="lbl_grid_head" CssClass="gridHeadText"
                                                    ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10"></asp:Label>
                                            </td>
                                            <td style="width: 20px; padding-right: 4px;">
                                                <asp:Image ID="imgExport" ImageUrl="~/App/Images/Icons/icon_export_sm_white.png"
                                                    runat="server" />
                                            </td>
                                            <td style="width: 40px; color: White; padding-right: 2px; vertical-align: middle;">
                                                Export
                                            </td>
                                            <td style="width: 10px; padding-right: 20px;">
                                                <asp:Image ID="Image1" ImageUrl="~/App/Images/Icons/asset_arrow_down_white_sm.png"
                                                    runat="server" />
                                            </td>
                                            <td align="right" style="padding-right: 5px; width: 20px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                    ClientIDMode="Static" ID="ReportMenu_0_img_expand_collapse" onclick="ReportMenu_expand_collapse(0)" />
                                            </td>
                                            <td align="right" style="width: 20px; padding-right: 15px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_close_lg_white.png"
                                                    onclick="closeReportWindow();" ClientIDMode="Static" ID="Image7" Height="18"
                                                    Width="18" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divReportContent" class="divScroll ReportMenu_0_Content" style="padding: 0 20px 0 4px;
                                    border-bottom: 1px solid Orange;">
                                    <table width="100%" cellpadding="0" cellspacing="0" style="margin-top: 1px;">
                                        <tr>
                                            <td class="tdGrayHeaderReport">
                                                Assigned Components
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="border-bottom: 6px solid #0f233d;">
                                                <telerik:RadGrid runat="server" ID="rd_assigned_components" AllowPaging="false" GridLines="None"
                                                    AutoGenerateColumns="False" AllowSorting="True" ItemStyle-Wrap="false" HeaderStyle-Wrap="false"
                                                    Width="100%" Skin="" CssClass="GridMainGray">
                                                    <HeaderStyle CssClass="gridHeaderGray" />
                                                    <ItemStyle CssClass="gridItemGray" />
                                                    <MasterTableView Width="100%">
                                                        <Columns>
                                                            <telerik:GridBoundColumn HeaderText="Element ID" DataField="element_id" SortExpression="element_id">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="OmniClass ID" ItemStyle-Width="15%" DataField="omniclass_id"
                                                                SortExpression="omniclass_id">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="UniFormat ID" ItemStyle-Width="15%" DataField="uniformat_id"
                                                                SortExpression="uniformat_id">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="# of Components" ItemStyle-Width="15%" DataField="no_of_components"
                                                                SortExpression="no_of_components">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Action">
                                                                <ItemTemplate>
                                                                    <a href="" class="lnkReport">Show</a>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                        <NoRecordsTemplate>
                                                            <div style="background-color: #d6d6d6; padding-left: 8px;">
                                                                No assigned components present</div>
                                                        </NoRecordsTemplate>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdGrayHeaderReport">
                                                Unassigned Components
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="border-bottom: 6px solid #0f233d;">
                                                <telerik:RadGrid runat="server" ID="rd_unassigned_components" AllowPaging="false"
                                                    GridLines="None" AutoGenerateColumns="False" AllowSorting="True" ItemStyle-Wrap="false"
                                                    HeaderStyle-Wrap="false" Width="100%" Skin="" CssClass="GridMainGray">
                                                    <HeaderStyle CssClass="gridHeaderGray" />
                                                    <ItemStyle CssClass="gridItemGray" />
                                                    <MasterTableView Width="100%">
                                                        <Columns>
                                                            <telerik:GridBoundColumn HeaderText="Type" DataField="Type" SortExpression="Type">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="# of Components" DataField="no_of_components"
                                                                SortExpression="no_of_components" ItemStyle-Width="15%">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Action" ItemStyle-Width="15%">
                                                                <ItemTemplate>
                                                                    <a href="" class="lnkReport">Assign</a> &nbsp; <a href="" class="lnkReport">Show</a>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                        <NoRecordsTemplate>
                                                            <div style="background-color: #d6d6d6; padding-left: 8px;">
                                                                No unassigned components present</div>
                                                        </NoRecordsTemplate>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdGrayHeaderReport">
                                                Missing Components
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:RadGrid runat="server" ID="rd_missing_components" AllowPaging="false" GridLines="None"
                                                    AutoGenerateColumns="False" AllowSorting="True" ItemStyle-Wrap="false" HeaderStyle-Wrap="false"
                                                    Width="100%" Skin="" CssClass="GridMainGray">
                                                    <HeaderStyle CssClass="gridHeaderGray" />
                                                    <ItemStyle CssClass="gridItemGray" />
                                                    <MasterTableView Width="100%">
                                                        <Columns>
                                                            <telerik:GridBoundColumn HeaderText="Element ID" DataField="element_id" SortExpression="element_id">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="OmniClass ID" DataField="omniclass_id" SortExpression="omniclass_id"
                                                                ItemStyle-Width="15%">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="UniFormat ID" DataField="uniformat_id" SortExpression="uniformat_id"
                                                                ItemStyle-Width="15%">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Action" ItemStyle-Width="15%">
                                                                <ItemTemplate>
                                                                    <a href="" class="lnkReport">Assign</a>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                        <NoRecordsTemplate>
                                                            <div style="background-color: #d6d6d6; padding-left: 8px;">
                                                                No missing components present</div>
                                                        </NoRecordsTemplate>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="width: 22%" valign="top">
                    <table style="border-collapse: collapse;" cellpadding="0" cellspacing="0" width="100%">
                        <tr id="trComponents">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_asset_sm.png" ID="Image12" />
                                            </td>
                                            <td align="left" class="entityImage">
                                                <asp:Label runat="server" Text="ComponentS" Font-Size="11px" ID="Label11"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 4px 0 0;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up.png" ClientIDMode="Static"
                                                    ID="RightMenu_0_img_expand_collapse" onclick="RightMenu_expand_collapse(0)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divComponentContent" class="divProperties divScroll RightMenu_0_Content">
                                    <telerik:RadGrid ID="rd_component" Skin="" runat="server" AutoGenerateColumns="False"
                                        Font-Names="Arial" Font-Size="9" AllowSorting="False" ShowHeader="false" Width="100%"
                                        GridLines="None" OnColumnCreated="rd_component_ColumnCreated">
                                        <ItemStyle CssClass="gridPropertiesItem" />
                                        <AlternatingItemStyle CssClass="gridPropertiesAlternateItem" />
                                        <ClientSettings AllowDragToGroup="true">
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                        </ClientSettings>
                                        <MasterTableView EditMode="EditForms" GroupLoadMode="Client" Width="100%">
                                            <GroupByExpressions>
                                                <telerik:GridGroupByExpression>
                                                    <SelectFields>
                                                        <telerik:GridGroupByField FieldAlias="Group" FieldName="Group_Name"></telerik:GridGroupByField>
                                                    </SelectFields>
                                                    <GroupByFields>
                                                        <telerik:GridGroupByField FieldName="Group_Name"></telerik:GridGroupByField>
                                                    </GroupByFields>
                                                </telerik:GridGroupByExpression>
                                            </GroupByExpressions>
                                            <GroupHeaderItemStyle Width="7%" Height="25px" />
                                            <ItemStyle />
                                            <AlternatingItemStyle Height="26px" />
                                            <Columns>
                                                <telerik:GridEditCommandColumn ButtonType="ImageButton" CancelText="<%$Resources:Resource, Cancel%>"
                                                    UniqueName="EditCommandColumn" UpdateText="<%$Resources:Resource, Update%>">
                                                    <ItemStyle Width="10%" Wrap="false" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridBoundColumn DataField="attribute_name" HeaderText="<%$Resources:Resource, Parameter%>"
                                                    ReadOnly="true" UniqueName="parameter" ItemStyle-Width="25%" ItemStyle-Wrap="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="attribute_value" HeaderText="<%$Resources:Resource, Value%>"
                                                    Visible="true" UniqueName="Atrr_value">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn UniqueName="EditCommandColumn1">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                        <tr id="trType">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_type_sm.png" ID="Image4" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="TYPE" Font-Size="11px" ID="Label3"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 4px 0 0;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up.png" ClientIDMode="Static"
                                                    ID="RightMenu_1_img_expand_collapse" onclick="RightMenu_expand_collapse(1)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divTypeContent" class="divProperties divScroll RightMenu_1_Content">
                                    <telerik:RadGrid ID="rd_type" Skin="" runat="server" AutoGenerateColumns="False"
                                        Font-Names="Arial" Font-Size="9" AllowSorting="False" ShowHeader="false" Width="100%"
                                        GridLines="None" OnColumnCreated="rd_type_ColumnCreated">
                                        <ItemStyle CssClass="gridPropertiesItem" />
                                        <AlternatingItemStyle CssClass="gridPropertiesAlternateItem" />
                                        <ClientSettings AllowDragToGroup="true">
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                        </ClientSettings>
                                        <MasterTableView EditMode="EditForms" GroupLoadMode="Client" Width="100%">
                                            <GroupByExpressions>
                                                <telerik:GridGroupByExpression>
                                                    <SelectFields>
                                                        <telerik:GridGroupByField FieldAlias="Group" FieldName="Group_Name"></telerik:GridGroupByField>
                                                    </SelectFields>
                                                    <GroupByFields>
                                                        <telerik:GridGroupByField FieldName="Group_Name"></telerik:GridGroupByField>
                                                    </GroupByFields>
                                                </telerik:GridGroupByExpression>
                                            </GroupByExpressions>
                                            <GroupHeaderItemStyle Width="7%" Height="25px" />
                                            <Columns>
                                                <telerik:GridEditCommandColumn ButtonType="ImageButton" CancelText="<%$Resources:Resource, Cancel%>"
                                                    UniqueName="EditCommandColumn" UpdateText="<%$Resources:Resource, Update%>">
                                                    <ItemStyle Width="10%" Wrap="false" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridBoundColumn DataField="attribute_name" HeaderText="<%$Resources:Resource, Parameter%>"
                                                    ReadOnly="true" UniqueName="parameter" ItemStyle-Width="25%" ItemStyle-Wrap="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="attribute_value" HeaderText="<%$Resources:Resource, Value%>"
                                                    Visible="true" UniqueName="Atrr_value">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn UniqueName="EditCommandColumn1">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                        <tr id="trDocuments">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_documents_sm.png" ID="Image6" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="DOCUMENTS" Font-Size="11px" ID="Label4"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 8px 0 0px; width: 20px;" onclick="stopPropagation(event)">
                                                <asp:ImageButton ID="btnAddDocument" runat="server" ImageUrl="~/App/Images/Icons/asset_add_sm.png"
                                                    AlternateText="<%$Resources:Resource, Add_Document%>" OnClick="btnAddDocument_OnClick" />
                                            </td>
                                            <td align="right" style="padding: 4px 4px 0 0; width: 20px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up.png" ClientIDMode="Static"
                                                    ID="RightMenu_2_img_expand_collapse" onclick="RightMenu_expand_collapse(2)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divdocumentContent" class="divProperties divScroll RightMenu_2_Content">
                                    <telerik:RadGrid ID="rd_document" runat="server" AutoGenerateColumns="false" AllowSorting="false"
                                        Font-Names="Arial" Font-Size="9" GridLines="None" AllowPaging="false" Skin=""
                                        ShowHeader="false" OnItemCommand="rd_document_OnItemCommand">
                                        <ClientSettings>
                                            <ClientEvents OnCommand="rd_document_onClientCommand" />
                                        </ClientSettings>
                                        <ItemStyle CssClass="gridPropertiesItem" />
                                        <AlternatingItemStyle CssClass="gridPropertiesAlternateItem" />
                                        <MasterTableView DataKeyNames="document_id" ClientDataKeyNames="document_id, entity_name"
                                            Width="100%">
                                            <Columns>
                                                <telerik:GridTemplateColumn>
                                                    <ItemStyle Width="7%" Wrap="false" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                                    <ItemStyle Width="10%" Wrap="false" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridTemplateColumn DataField="document_name" HeaderText="<%$Resources:Resource, Document_Name%>">
                                                    <ItemStyle Width="60%" />
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlnkDocName" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"file_path")%>'
                                                            Text='<%# DataBinder.Eval(Container.DataItem,"document_name")%>' runat="server"
                                                            Target="_blank"></asp:HyperLink>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn UniqueName="remove">
                                                    <ItemStyle Width="10%" />
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Icons/asset_close_black.png"
                                                            runat="server" CommandName="delete" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <NoRecordsTemplate>
                                                <div style="background-color: #d6d6d6; padding-left: 8px;">
                                                    No documents present</div>
                                            </NoRecordsTemplate>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hf_component_id" runat="server" />
    <asp:HiddenField ID="hf_category" runat="server" />
    <asp:HiddenField ID="hf_entity" runat="server" />
    <telerik:RadAjaxManagerProxy ID="ComponentProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rd_component">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rd_component" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
