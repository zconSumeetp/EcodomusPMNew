<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingReport.aspx.cs"
     MasterPageFile="~/App/EcoDomus_PM_New.master"  Inherits="App_NewUI_EnergyModelingReport" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Charting" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .tblBorder
        {
            border: 1px;
            height: auto;
            border-collapse: collapse;
        }
        .button
        {
            background-color: #F2F2F2;
            color: #F2F2F2;
            width: 60px;
        }
        .lnkBtnBgImg
        {
            background-image: url('/App/Images/asset_button_sm_gray.png');
            background-repeat: no-repeat;
            height: 25px;
            width: 60px;
            vertical-align: middle;
        }
        .lnkBtnBgImg1
        {
            background-image: url('/App/Images/asset_button_sm_gray.png');
            background-repeat: no-repeat;
            height: 25px;
            width: 90px;
            vertical-align: middle;
        }
        
        div
        {
            overflow-x: hidden;
            overflow-y: hidden;
        }
        
        .SelectedStyle
        {
            background-color: red !important;
        }
        .style7
        {
            width: 30%;
            height:5%;
        }
        .style8
        {
            width: 27%;
        }
        .ApplyPosition
        {
            position:relative;
        }
    </style>
    <script  type="text/javascript" >
    
    function NiceScrollOnload(){
        if (screen.height > 721) {
            $("html").css('overflow-y', 'hidden');
            $("html").css('overflow-x', 'auto');
        }
            var screenhtg = set_NiceScrollToPanel();
        }
        
      $(document).ready(function () {
          $("#ctl00_ContentPlaceHolder1_btnReportList_input,#ctl00_ContentPlaceHolder1_btnNew_input,#ctl00_ContentPlaceHolder1_btnEdit_input,#ctl00_ContentPlaceHolder1_btnUpdate_input,#ctl00_ContentPlaceHolder1_btnDelete_input").removeClass('rbDecorated');
          $("#ctl00_ContentPlaceHolder1_btnReportList,#ctl00_ContentPlaceHolder1_btnNew,#ctl00_ContentPlaceHolder1_btnEdit,#ctl00_ContentPlaceHolder1_btnUpdate,#ctl00_ContentPlaceHolder1_btnDelete").removeClass('rbSkinnedButton');
      $("#div_contentPlaceHolder").scroll(function () {
         // $("#ctl00_ContentPlaceHolder1_btnReportList,#ctl00_ContentPlaceHolder1_btnNew,#ctl00_ContentPlaceHolder1_btnEdit,#ctl00_ContentPlaceHolder1_btnUpdate,#ctl00_ContentPlaceHolder1_btnDelete").removeClass('rbSkinnedButton');
          $("#ctl00_ContentPlaceHolder1_btnReportList").removeClass('ApplyPosition');
         // $("#ctl00_ContentPlaceHolder1_btnReportList").addClass('ApplyPosition');
         });
     });

        </script>
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <telerik:RadFormDecorator ID="QsfFromDecorator" runat="server" Skin="Default" DecoratedControls="All"
        EnableRoundedCorners="false" />
    <table border="0" cellpadding="0" cellspacing="0" style="height: 95%; width:98%;border-collapse: collapse; margin: 0">
        <tr>
            <td class="tdValign">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;
                    margin: 0px">
                    <tr>
                        <td style="width: 75px; vertical-align: bottom;">
                            <telerik:RadTabStrip runat="server" ID="rts_energy_plus_Report" SelectedIndex="0"
                                Align="Justify" dir="ltr" CssClass="normalLabel"
                                Height="23px" Width="80px">
                                <Tabs>
                                    <telerik:RadTab Text="Reports" Font-Bold="true">
                                    </telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                        <td align="right" valign="top" style="margin: 0px; ">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-width: 2px;
                                border-style: solid; border-left-color: transparent; border-bottom-color: #DCDCDC;
                                border-right-color: transparent; border-top-color: transparent; border-collapse: collapse;">
                                <tr>
                                    <td align="right">
                                        <asp:ImageButton ID="ibtn_Edit" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                            Width="15" Height="15" ImageAlign="Bottom" />
                                    </td>
                                    <td width="4%" align="right" style="padding-right: 5px; vertical-align: top;">
                                        <asp:LinkButton ID="lbtn_edit" ForeColor="#585858" Font-Bold="true" Font-Names="Arial"
                                            runat="server" Text="EDIT" CssClass="lnkButton"></asp:LinkButton>
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
                <table border="2" width="100%" cellpadding="0" cellspacing="0" style="border-top-width: 0px;
                    border-top-color: transparent;">
                    <tr>
                        <td valign="top" style="border-top-width: 0; border-top-color: transparent">
                            <table border="1" width="100%" cellpadding="0" cellspacing="0" style="border-top-color: transparent;
                                border-top-width: 0px; border-bottom-width: 3px; border-left-width: 1px; border-right-width: 1px;
                                border-left-color: transparent; border-right-color: transparent; border-bottom-color: transparent;
                                border-bottom-style: outset;">
                                <tr>
                                    <td class="tdValign" style="padding-top: 10px; padding-left: 10px; border-bottom-color: transparent;
                                        border-top-width: 0; border-top-color: transparent">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="background-image: url('../Images/asset_container_2.png'); height: 40px;
                                                    width: 200px; background-repeat: no-repeat;" align="center">
                                                    <asp:Label ID="lbl_project_name" runat="server" Font-Size="10" ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                                </td>
                                                <td style="width: 5px">
                                                </td>
                                                <td style="background-image: url('../Images/asset_container_3.png'); height: 40px;
                                                    width: 200px; background-repeat: no-repeat" align="center">
                                                    <asp:Label ID="lblReport" runat="server" Text="Report" Font-Size="10" ForeColor="Red"
                                                        CssClass="normalLabel"></asp:Label>
                                                </td>
                                                <td style="width: 40%">
                                                    <asp:Label ID="SelectedReport" runat="server" Text="Selected Report" Font-Size="10"
                                                        ForeColor="Black" CssClass="normalLabel"></asp:Label>
                                                    <asp:Label ID="SelectedReportName" runat="server" Text="Report.rpt" Font-Size="10"
                                                        ForeColor="Black" CssClass="normalLabel"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table border="0" cellpadding="0" width="100%" cellspacing="0" style="vertical-align: middle;">
                                            <tr>
                                                <td align="right" style="width: 90%; height: 40%;">
                                                    <table id="tblButtons" style="width: 100%" runat="server" cellspacing="2">
                                                        <tr>
                                                            <td align="center">
                                                                <telerik:RadButton ID="btnReportList" CssClass="ApplyPosition" Text="Report List" Width="90px" runat="server">
                                                                </telerik:RadButton>
                                                                <%-- <asp:Button ID="btnReportList" CssClass="ApplyPosition" Text="Report List" Width="90px" runat="server"/>--%>
                                                               
                                                            </td>
                                                            <td align="center">
                                                                <telerik:RadButton ID="btnEdit" Text="Edit" Width="61px" runat="server">
                                                                </telerik:RadButton>
                                                            </td>
                                                            <td align="center">
                                                                <telerik:RadButton ID="btnUpdate" Text="Update" Width="60px" runat="server">
                                                                </telerik:RadButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                            </td>
                                                            <td align="center">
                                                                <telerik:RadButton ID="btnNew" Text="New" Width="60px" runat="server">
                                                                </telerik:RadButton>
                                                            </td>
                                                            <td align="center">
                                                                <telerik:RadButton ID="btnDelete" Text="Delete" Width="60px" runat="server">
                                                                </telerik:RadButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 96%">
                            <table style="width: 100%; border-left-color: #C9C9C9; border-bottom-color: #C9C9C9">
                                <tr>
                                    <td valign="top" style="width: 23%; height: 100%; border-width: 2px; border-color: Black;">
                                        <table border="1px" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <%--<telerik:RadTreeView ID="rtvSummaryReport" runat="server" Height="100%" Width="100px">
                                                    </telerik:RadTreeView>--%>
                                                    <asp:TreeView ID="rtvSummaryReport" runat="server" CssClass="normalLabel"  onselectednodechanged="rtvSummaryReport_SelectedNodeChanged">
                                                        <SelectedNodeStyle ForeColor="#0066FF" />
                                                    </asp:TreeView>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 2%; background-color: White">
                                    </td>
                                    <td style="border-right-color: Blue; width: 75%; border-width: 2px;">
                                        <table border="1px" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <table style="width: 98%; height: 40%">
                                                        <tr>
                                                            <td colspan="2">
                                                                <table width="100%" style="height: 5px">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <table border="0" cellpadding="0" cellspacing="0">
                                                                                <tr>
                                                                                    <td style="width: 32px">
                                                                                        <asp:ImageButton runat="server" ID="imground_left_arrow" src="../Images/round_left_arrow.png"
                                                                                            alt="Back"  />
                                                                                    </td>
                                                                                    <td style="width: 32px">
                                                                                        <asp:ImageButton runat="server" ID="imground_right_arrow" src="../Images/round_right_arrow.png"
                                                                                            alt="Forward" />
                                                                                    </td>
                                                                                    <td style="width: 32px">
                                                                                        <asp:ImageButton runat="server" ID="imgFirst" src="../Images/First.png" alt="First" />
                                                                                    </td>
                                                                                    <td style="width: 32px">
                                                                                        <asp:ImageButton runat="server" ID="imgPrevious" src="../Images/Previous.png" alt="Previous" />
                                                                                    </td>
                                                                                    <td style="width: 32px">
                                                                                        <asp:TextBox ID="txtPageNumber" runat="server" Width="10px"> </asp:TextBox>
                                                                                    </td>
                                                                                    <td style="width: 32px">
                                                                                        <asp:Label ID="lblPagenumber" Text="" runat="server"> </asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 32px">
                                                                                        <asp:ImageButton runat="server" ID="imgNext" src="../Images/Forward.png" alt="Next" />
                                                                                    </td>
                                                                                    <td style="width: 32px">
                                                                                        <asp:ImageButton runat="server" ID="imgLast" src="../Images/Last.png" alt="Last" />
                                                                                    </td>
                                                                                    <td style="width: 32px">
                                                                                        <asp:ImageButton runat="server" ID="img_Refresh" src="../Images/img_Refresh.png"
                                                                                            alt="Refresh" />
                                                                                    </td>
                                                                                    <td style="width: 32px">
                                                                                        <asp:ImageButton runat="server" ID="imgPrint_Preview" src="../Images/Print_Preview.jpg"
                                                                                            alt="Preview" />
                                                                                    </td>
                                                                                    <td style="width: 32px">
                                                                                        <asp:ImageButton runat="server" ID="imgprinter" src="../Images/printer.png" alt="Printer" />
                                                                                    </td>
                                                                                    <td style="width: 32px">
                                                                                        <asp:ImageButton runat="server" ID="imgsave" src="../Images/Icons/icon_profile-doc_sm.png" alt="Save" />
                                                                                    </td>
                                                                                    <td style="width: 32px">
                                                                                        <asp:ImageButton runat="server" ID="img_settings" src="../Images/img_settings.png"
                                                                                            alt="Settings" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td rowspan="2" style="background-color: #8991A4; width:3%; height:3%">
                                                                            <asp:Image ID="imgProjectLogo" runat="server" ImageUrl=""  Width="50px" Height="50px" />
                                                                         </td>
                                                                        <td>
                                                                            <asp:Label ID="lblProjectName" runat="server" CssClass="normalLabelBold"> </asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="background-color: #8991A4; height:10px" >
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" align="right">
                                                                            <asp:Label ID="lblFromToMonts" Text="From January 2001 to December 2004" runat="server"
                                                                                CssClass="normalLabel"> </asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" valign="top" style="width: 50%; background-color: #EDEFEE">
                                                                <asp:Label ID="lblmonthlySummeryReportNode" Text="Space Gains Monthly" runat="server"
                                                                    CssClass="normalLabel"> </asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top" style="width: 50%;">
                                                                <telerik:RadGrid ID="rgBardata" AllowPaging="true" PageSize="5" AllowSorting="true"
                                                                    runat="server" AutoGenerateColumns="false" OnPageIndexChanged="rgBardata_OnPageIndexChanged" OnPageSizeChanged="rgBardata_OnPageSizeChanged">
                                                                    <ClientSettings AllowColumnHide="true">
                                                                    </ClientSettings>
                                                                    <MasterTableView  DataKeyNames="pk_floor_id, pk_space_id" AllowMultiColumnSorting="True"
                                                                        GroupLoadMode="Server" ExpandCollapseColumn-Visible="false">
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn UniqueName="Name" DataField="name" SortExpression="name">
                                                                                <ItemStyle Width="75%" />
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn UniqueName="Value" DataField="value" SortExpression="value">
                                                                             <ItemStyle Width="25%" />
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                    </MasterTableView>
                                                                </telerik:RadGrid>
                                                            </td>
                                                            <td style="width: 100%; height: 30%">
                                                                <telerik:RadChart ID="chrtBars" Skin="Yellow" Legend-Appearance-Visible="false" AutoLayout="true"
                                                                    Height="200px" SeriesOrientation="Horizontal" SkinsOverrideStyles="true" runat="server">
                                                                    <Series>
                                                                        <telerik:ChartSeries Type="Bar">
                                                                            <Appearance>
                                                                                <FillStyle MainColor="#F2CD72" SecondColor="#D5A232">
                                                                                </FillStyle>
                                                                            </Appearance>
                                                                           
                                                                        </telerik:ChartSeries>
                                                                    </Series>
                                                                    <PlotArea>
                                                                        <XAxis>
                                                                            <Appearance LabelAppearance-Border-PenStyle="Solid">
                                                                            </Appearance>
                                                                        </XAxis>
                                                                        <Appearance Dimensions-Margins="0px, 0px, 0px, 0px">
                                                                            <FillStyle MainColor="Transparent" SecondColor="Transparent">
                                                                            </FillStyle>
                                                                            <Border Visible="false" />
                                                                        </Appearance>
                                                                    </PlotArea>
                                                                    <ChartTitle>
                                                                        <Appearance Visible="false">
                                                                        </Appearance>
                                                                    </ChartTitle>
                                                                </telerik:RadChart>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table style="width: 98%; height: 30%">
                                                        <tr>
                                                            <td colspan="2" valign="top" style="width: 50%; background-color: #EDEFEE">
                                                                <asp:Label ID="Label1" Text="Space Gains Monthly" Width="100%" CssClass="normalLabel"
                                                                    runat="server"> </asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td valign="top" style="width: 50%;">
                                                                <telerik:RadGrid ID="rgPieData" AllowPaging="true" PageSize="5" AllowSorting="true"
                                                                    runat="server" AutoGenerateColumns="false"  OnPageIndexChanged="rgPieData_OnPageIndexChanged" OnPageSizeChanged="rgPieData_OnPageSizeChanged">
                                                                    <ClientSettings AllowColumnHide="true">
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="pk_floor_id, pk_space_id" AllowMultiColumnSorting="True"
                                                                        GroupLoadMode="Server" ExpandCollapseColumn-Visible="false">
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn UniqueName="Name" DataField="name" SortExpression="name" >
                                                                                <ItemStyle Width="75%" />
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn UniqueName="Value" DataField="value" SortExpression="value">
                                                                                <ItemStyle Width="25%" />
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                    </MasterTableView>
                                                                </telerik:RadGrid>
                                                            </td>
                                                            <td style="width: 100%; height: 30%">
                                                                <telerik:RadChart ID="chrtPie" runat="server" Skin="Vista" DefaultType="Pie" AutoLayout="true" Height="200px"
                                                                    SeriesOrientation="Vertical" AutoTextWrap="true">
                                                                    <Legend Visible="true" Appearance-FillStyle-FillSettings-ImageAlign="Right">
                                                                 
                                                                        <Appearance Border-Visible="false" ItemMarkerAppearance-Border-PenStyle="Solid" ItemMarkerAppearance-Figure="Circle"  Dimensions-Width="5%" Position-AlignedPosition="TopRight">
                                                                            <FillStyle FillType="Solid">
                                                                            </FillStyle>
                                                                        </Appearance>
                                                                    </Legend>
                                                                    <Series>
                                                                        <telerik:ChartSeries Type="Pie">
                                                                            
                                                                            <Appearance LegendDisplayMode="ItemLabels">
                                                                                 <FillStyle MainColor="#F2CD72" SecondColor="#D5A232">
                                                                                </FillStyle>
                                                                            </Appearance>
                                                                          
                                                                        </telerik:ChartSeries>
                                                                    </Series>
                                                                    <PlotArea>
                                                                    <XAxis DataLabelsColumn="name">
                                                                           </XAxis>
                                                                        <Appearance Dimensions-Margins="0px, 0px, 0px, 0px">
                                                                            <FillStyle MainColor="Transparent" SecondColor="Transparent">
                                                                            </FillStyle>
                                                                            <Border Visible="false" />
                                                                        </Appearance>
                                                                    </PlotArea>
                                                                    <ChartTitle>
                                                                        <TextBlock Text="">
                                                                        </TextBlock>
                                                                        <Appearance Visible="true">
                                                                        </Appearance>
                                                                    </ChartTitle>
                                                                </telerik:RadChart>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
        <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgPieData">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgPieData" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgBardata">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgBardata" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Forest">
    </telerik:RadAjaxLoadingPanel>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
