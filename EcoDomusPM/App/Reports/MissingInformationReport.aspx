<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="MissingInformationReport.aspx.cs" Inherits="App_Reports_MissingInformationReport" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <html>
    <head>
        <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
        <style type="text/css">
            th
            {
                font-size: 12px;
                font-weight: normal;
                color: #330000;
                vertical-align: middle;
                font-weight: bolder;
                font-family: Arial, Helvetica, sans-serif;
            }
            td
            {
                font-size: 12px;
                font-weight: normal;
                padding-left: 0px;
                font-weight: normal;
                font-family: Arial, Helvetica, sans-serif;
                vertical-align: top;
                table-layout: fixed;
            }
           
        </style>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript" language="javascript">

                window.onload = body_load;
                function body_load() {

                    var screenhtg = set_NiceScrollToPanel();
                }
                function GridCreated(sender, args) {
                    //alert(sender.get_masterTableView().get_pageSize());
                    var pageSize = document.getElementById("ContentPlaceHolder1_hfPageSize").value;
                    //var pageSize = 12;
                    var scrollArea = sender.GridDataDiv;
                    var dataHeight = sender.get_masterTableView().get_element().clientHeight;

                    if (dataHeight < parseInt(pageSize) * 40) {
                        scrollArea.style.height = dataHeight + "px";
                    }
                    else {
                        scrollArea.style.height = (parseInt(pageSize) * 40) + "px";
                    }

                    //sender.get_masterTableView().set_pageSize(globalPageHeight);
                }

            </script>
        </telerik:RadCodeBlock>
    </head>
    <body style="table-layout: fixed;">
        <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
        <table width="100%">
            <tr> 
                <td>
                    <asp:Label ID="lbl_missing_info_report" Style="font-size: large; color: #610B0B;"
                        runat="server" Text="<%$Resources:Resource,Missing_Information_Report%>"></asp:Label>
                </td>
            </tr>
        </table>
        <table width="100%" border="0" style="margin-right: 0px;">
            <tr>
                <th style="width: 10%">
                    <asp:Label ID="lbl_designer_contractor" runat="server" Text="<%$Resources:Resource,Designer_Contractor%>" />:
                </th>
                <th style="width: 15%">
                    <telerik:RadComboBox ID="cmb_designer_contractor" runat="server" Visible="true" Filter="Contains"
                        MarkFirstMatch="true" AutoPostBack="True" CheckBoxes="true" CheckedItemsTexts="DisplayAllInInput"
                        EnableCheckAllItemsCheckBox="true" Width="100%">
                    </telerik:RadComboBox>
                    <%--OnClientDropDownClosed="check_designer_contractor()"--%>
                </th>
                <th style="width: 5%">
                    <asp:Label ID="lbl_facility" runat="server" Text="<%$Resources:Resource,facility%>" />:
                </th>
                <th style="width: 15%">
                    <telerik:RadComboBox ID="cmbfacility" runat="server" Visible="true" Filter="Contains"
                        MarkFirstMatch="true" AutoPostBack="True" Width="100%">
                    </telerik:RadComboBox>
                    <%--OnSelectedIndexChanged="cmbfacility_SelectedIndexChanged"--%>
                </th>
                <th style="width: 5%">
                    <asp:Label ID="lbl_report" runat="server" Text="<%$Resources:Resource,Report%>" />:
                </th>
                <th style="width: 30%">
                    <telerik:RadComboBox ID="cmbReport_type" runat="server" Visible="true" Filter="Contains"
                        MarkFirstMatch="true" AutoPostBack="True" CheckBoxes="true" CheckedItemsTexts="DisplayAllInInput"
                        Width="100%">
                    </telerik:RadComboBox>
                    <%--OnItemChecked="cmbReport_type_ItemChecked"--%>
                </th>
                <th style="width: 15%">
                    <asp:Button runat="server" ID="btn_generate_report" Text="<%$Resources:Resource,Generate_Report%>"
                        OnClick="btn_generate_report_Click" Width="100%" />
                </th>
                <th>
                    <asp:Button runat="server" ID="btn_export_report" Text="<%$Resources:Resource,Export%>"
                        OnClick="btn_export_report_Click" Width="100%" />
                </th>
            </tr>
        </table>
        <table width="100%" border="0">
            <tr>
                <td style="width: 100%;">
                    <telerik:RadGrid ID="rg_MI_report" runat="server" ShowStatusBar="true" Width="100%"
                        AutoGenerateColumns="False" PageSize="7" AllowSorting="True" AllowMultiRowSelection="False"
                        AllowPaging="True" OnDetailTableDataBind="rg_MI_report_DetailTableDataBind" OnNeedDataSource="rg_MI_report_NeedDataSource"
                        OnPreRender="rg_MI_report_PreRender" OnItemDataBound="rg_MI_report_ItemDataBound">
                        <PagerStyle Mode="NumericPages"></PagerStyle>
                        <ClientSettings>
                            <Scrolling AllowScroll="true" ScrollHeight="480" UseStaticHeaders="true" />
                            <ClientEvents OnGridCreated="GridCreated" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="id" AllowMultiColumnSorting="True">
                            <ItemStyle Height="20px" Font-Names="Arial" Font-Size="10" VerticalAlign="Middle" />
                            <AlternatingItemStyle Height="20px" Font-Names="Arial" Font-Size="10" VerticalAlign="Middle" />
                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                            <FooterStyle Height="23px" Font-Names="Arial" />
                            <DetailTables>
                                <telerik:GridTableView DataKeyNames="entity_name" Name="pk_entity_id">
                                    <DetailTables>
                                        <telerik:GridTableView DataKeyNames="id" Name="id" PagerStyle-VerticalAlign="Bottom"
                                            PagerStyle-Mode="NextPrevAndNumeric" PagerStyle-AlwaysVisible="true" Width="100%"
                                            PageSize="10" AllowPaging="true" AutoGenerateColumns="false">
                                            <DetailTables>
                                                <telerik:GridTableView DataKeyNames="row_id" Name="row_id">
                                                    <%--columns from third details view--%>
                                                    <Columns>
                                                        <telerik:GridBoundColumn SortExpression="row_id" HeaderText="row_id" HeaderButtonType="TextButton"
                                                            DataField="pk_facility_id" Visible="false">
                                                            <HeaderStyle Width="0%" Wrap="false" />
                                                            <ItemStyle Width="0%" Wrap="false" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn SortExpression="attributes" HeaderButtonType="TextButton"
                                                            DataField="attributes" UniqueName="attributes">
                                                            <HeaderStyle Width="95%" Wrap="true" />
                                                            <ItemStyle Width="95%" Wrap="true" />
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
                                                </telerik:GridTableView>
                                            </DetailTables>
                                            <Columns>
                                                <%--columns from second details view--%>
                                                <telerik:GridBoundColumn SortExpression="id" HeaderText="id" HeaderButtonType="TextButton"
                                                    DataField="id" Visible="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn SortExpression="name" HeaderText="<%$Resources:Resource,Entity_Names%>"
                                                     DataField="name" UniqueName="name">
                                                    <HeaderStyle Width="96%" />
                                                    <ItemStyle Width="96%" />
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </telerik:GridTableView>
                                    </DetailTables>
                                    <Columns>
                                        <%--columns from first details view--%>
                                        <telerik:GridBoundColumn SortExpression="pk_entity_id" HeaderText="pk_entity_id"
                                            HeaderButtonType="TextButton" DataField="pk_entity_id" Visible="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn SortExpression="entity_name" HeaderText="<%$Resources:Resource,Entity%>"
                                            HeaderButtonType="TextButton" DataField="entity_name" UniqueName="entity_name">
                                            <HeaderStyle Width="96%" />
                                            <ItemStyle Width="96%" />
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                </telerik:GridTableView>
                            </DetailTables>
                            <Columns>
                                <%--columns from outermost table--%>
                                <telerik:GridBoundColumn SortExpression="id" HeaderText="id" HeaderButtonType="TextButton"
                                    DataField="id" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn SortExpression="MI_report_types" HeaderText="<%$Resources:Resource,Missing_Information_Report%>"
                                    HeaderButtonType="TextButton" DataField="MI_report_types">
                                    <HeaderStyle Width="100%" Wrap="false" />
                                    <ItemStyle Width="100%" Wrap="false" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>
        <table style="display: none;">
            <tr>
                <td>
                    <asp:HiddenField ID="hfPageSize" runat="server" Value="" />
                    <telerik:RadComboBox ID="cmbentity" runat="server" AutoPostBack="true" Width="100%">
                    </telerik:RadComboBox>
                    <asp:Label ID="lbl_entity" runat="server" Text="<%$Resources:Resource,Entity%>" />
                </td>
                <td>
                    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
                        <AjaxSettings>
                            <telerik:AjaxSetting AjaxControlID="rg_MI_report">
                                <UpdatedControls>
                                    <telerik:AjaxUpdatedControl ControlID="rg_MI_report" LoadingPanelID="alp"></telerik:AjaxUpdatedControl>
                                </UpdatedControls>
                            </telerik:AjaxSetting>
                            <telerik:AjaxSetting AjaxControlID="cmbReport_type">
                                <UpdatedControls>
                                    <telerik:AjaxUpdatedControl ControlID="cmbReport_type" LoadingPanelID="alp"></telerik:AjaxUpdatedControl>
                                </UpdatedControls>
                            </telerik:AjaxSetting>
                            <telerik:AjaxSetting AjaxControlID="cmb_designer_contractor">
                                <UpdatedControls>
                                    <telerik:AjaxUpdatedControl ControlID="cmb_designer_contractor" LoadingPanelID="alp">
                                    </telerik:AjaxUpdatedControl>
                                </UpdatedControls>
                            </telerik:AjaxSetting>
                            <telerik:AjaxSetting AjaxControlID="btn_designer_contractor_checked">
                                <UpdatedControls>
                                    <telerik:AjaxUpdatedControl ControlID="btn_designer_contractor_checked"></telerik:AjaxUpdatedControl>
                                </UpdatedControls>
                            </telerik:AjaxSetting>
                            <telerik:AjaxSetting AjaxControlID="btn_generate_report">
                                <UpdatedControls>
                                    <telerik:AjaxUpdatedControl ControlID="rg_MI_report" LoadingPanelID="alp"></telerik:AjaxUpdatedControl>
                                </UpdatedControls>
                            </telerik:AjaxSetting>
                            <telerik:AjaxSetting AjaxControlID="cmbentity">
                                <UpdatedControls>
                                    <telerik:AjaxUpdatedControl ControlID="cmbentity" LoadingPanelID="alp"></telerik:AjaxUpdatedControl>
                                </UpdatedControls>
                            </telerik:AjaxSetting>
                            <telerik:AjaxSetting AjaxControlID="cmbfacility">
                                <UpdatedControls>
                                    <telerik:AjaxUpdatedControl ControlID="cmbfacility" LoadingPanelID="alp"></telerik:AjaxUpdatedControl>
                                </UpdatedControls>
                            </telerik:AjaxSetting>
                        </AjaxSettings>
                    </telerik:RadAjaxManagerProxy>
                    <telerik:RadAjaxLoadingPanel Skin="Default" ID="alp" runat="server" InitialDelayTime="0">
                    </telerik:RadAjaxLoadingPanel>
                </td>
            </tr>
        </table>
    </body>
    </html>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
