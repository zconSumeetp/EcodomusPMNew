<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true" CodeFile="ActivityLogReport.aspx.cs" Inherits="App_Reports_ActivityLogReport" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
        <style type="text/css">
            .divProperties
            {
                background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
                height:100%;
            }
            .rpbItemHeader
            {
                background-color: #808080;
            }         
            .column
            {
                font-size:13px;
                font-family:Arial;
            }              
            .searchImage
            {
                background-image: url('/App/Images/Icons/icon_search_sm.png');
                background-repeat: no-repeat;
                background-position: right;
                font-family: "Arial" , sans-serif;
                font-size: 12px;
            }
            .gridHeadText
            {
                font-family: "Verdana" , "Sans-Serif";
                font-style: normal;
                font-size: medium;
                color: White;
            }
            .entityImage
            {
                padding-left: 7px;
            }
            .gridHeaderText
            {
                font-family: "Arial" , sans-serif;
                font-size: 16px;
                height: 20px;
                font-weight: bold;
                background-color: #AFAFAF;
            }        
            .gridRadPnlHeader
            {
                background-color: Gray;
                height: 30px;
                width: 100%;
                vertical-align: middle;
            }
            .captiondock
            {
                font-family: Arial, Helvetica, sans-serif;
                font-size: 14px;
                color: #990000;
                text-align: left;
                vertical-align: middle;
                margin-top: 10px;
                margin-bottom: 10px;
                font-weight: normal;
            }        
            .gridRadPnlHeaderBottom
            {
                background-color: Orange;
                height: 1px;
                width: 100%;
            }
            .dropDownImage
            {
                right: 15px;
            }        
            .searchTextBox
            {
                position: relative;
                right: 10px;
            }
            .wizardHeadImage
            {
                background-color: #FFA500;
                height: 30px;
                background-attachment: scroll;
                width: 100%;
                background-attachment: fixed;
                background-position: right;
                background-repeat: no-repeat;
                position: relative;
            }
            .wizardLeftImage
            {
                float: left;
                padding-left: 15px;
                vertical-align: middle;
                height: 20;
                right: 5px;
            }
            .wizardRightImage
            {
                float: right;
                padding-right: 10px;
                vertical-align: middle;
                height: 20;
            }        
            .normalLabelBold
            {
                font-family: "Arial" , sans-serif;
                font-size: 12px;
                font-weight: bold;
            }
            .headerBoldLabel
            {
                font-family: "Arial" , sans-serif;
                font-size: 16px;
                font-weight: bold;
            }
            .lblHeading
            {
                font-family: "Arial";
                font-size: 10px;
            }
            .tdValign
            {
                vertical-align: top;
                margin: 0;
            }
            .lnkButton
            {
                font-family: "Arial";
                font-size: 10px;
                color: Black;
                text-decoration: none;
            }
            .lnkButtonImg
            {
                height: 14px;
                vertical-align: bottom;
            }        
            .lblBold
            {
                font-family: "Arial" , sans-serif;
                font-size: 12px;
                height: 20px;
                vertical-align: middle;
                font-weight: bold;
            }
            .gridHeaderBoldText
            {
                font-family: "Arial" , sans-serif;
                font-size: 14px;
                vertical-align: bottom;
                font-weight: bold;
            }
            .textAreaScrollBar
            {
                font-family: "Arial" , sans-serif;
                font-size: 12px;
                overflow: auto;
                padding-left: 10px;
                padding-top: 10px;
                border-left-color: #D4D4C3;
                border-top-color: #D4D4C3;
                border-bottom-color: #E8E8E8;
                border-right-color: #E8E8E8;
                height: 170px;
            }  
        </style>    
</asp:Content>

<asp:Content ID="cntActivityLogReport" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
        <script type="text/javascript">
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            function body_load() {
                var screenhtg = set_NiceScrollToPanel();
            }

            function resize_Nice_Scroll() {
                //set_NiceScrollToPanel();
            }

            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {
                //var pageSize = document.getElementById("ContentPlaceHolder1_hfPageSize").value;
                //var scrollArea = sender.GridDataDiv;
                //var dataHeight = sender.get_masterTableView().get_element().clientHeight;

                //if (dataHeight < parseInt(pageSize) * 40) {
                //    scrollArea.style.height = dataHeight + "px";
                //}
                //else {
                //    scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
                //}
            }
            window.onload = body_load;
            
            function pageLoad() {
                var divRadGrdActivityLog = $($("div#divDataGrid").get(0));
                var parent = $(window);
                divRadGrdActivityLog.height(parent.height() - 130);
                var radGrdActivityLog = $find("<%= radGrdActivityLog.ClientID %>");
                radGrdActivityLog.repaint();
            }

            function columnClick(e, a) {
            }
        </script>        
    </telerik:RadCodeBlock>
    <div id="divOperations">
        <table width="100%" style="font-family: Arial, Helvetica, sans-serif; table-layout: fixed;
            border-bottom-style: none; border-bottom-width: 0px; width: 100%; overflow: hidden;">
            <tr>
                <td style="height: 25px;padding-bottom:0px;padding-left:02px;width: 100%;">
                    <asp:Button ID="btnGenerate" runat="server" Width="110px"  Text="<%$Resources:Resource,Generate_Report%>" OnClick="btnGenerate_OnClick"/>
                    <asp:Button ID="btnExport" runat="server" Width="110px" Text="<%$Resources:Resource,Export%>" OnClick="btnExport_OnClick" />
                </td>
            </tr>
        </table>
    </div>
    <div  style="padding-right:4px; padding-left:4px">
        <div class="rpbItemHeader">
            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                <tr>
                    <td align="left" class="entityImage" style="width: 35%;">
                        <asp:Label runat="server" Text="Activity Log" ID="lbl_grid_head" CssClass="gridHeadText"
                            Width="250px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                    </td>
                    <td align="right" style="background-color: #808080; padding-top: 2px; padding-bottom: 2px;">
                        <asp:Label ID="lblName" runat="server" Text="<%$Resources:Resource,Name%>"
                            CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10"></asp:Label>
                        <asp:Label ID="lblColon" runat="server" Text=":" CssClass="gridHeadText"
                            ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                    </td>
                    <td align="left" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;">
                        <div id="div_search">
                            <table>
                                <tr>
                                    <td>
                                        <telerik:RadTextBox ID="txtNameLastname" ClientIDMode="Static" runat="server"
                                            EmptyMessage="Search" BorderColor="White" Width="180px">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td align="right" style="background-color: #808080; padding-top: 2px; padding-bottom: 2px;">
                        <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Start_Date%>"
                            CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10"></asp:Label>
                        <asp:Label ID="Label2" runat="server" Text=":" CssClass="gridHeadText"
                            ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>   
                    </td>
                    <td align="left" style="background-color: #808080; padding-top: 2px; padding-bottom: 2px;">
                        <telerik:RadDatePicker ID="radCldStart" runat="server"
                            DateInput-DateFormat="M/d/yyyy"
                            DateInput-DisplayDateFormat="M/d/yyyy">
                        </telerik:RadDatePicker>
                    </td>
                    <td align="right" style="background-color: #808080; padding-top: 2px; padding-bottom: 2px;">
                        <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,End_Date%>"
                            CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10"></asp:Label>
                        <asp:Label ID="Label4" runat="server" Text=":" CssClass="gridHeadText"
                            ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                    </td>
                    <td align="left" style="background-color: #808080; padding-top: 2px; padding-bottom: 2px;">
                        <telerik:RadDatePicker ID="radCldEnd" runat="server"
                            DateInput-DateFormat="M/d/yyyy"
                            DateInput-DisplayDateFormat="M/d/yyyy">
                        </telerik:RadDatePicker>
                    </td>
                    <td align="right" style="background-color: #808080; padding-top: 2px; padding-bottom: 2px;">
                        <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,SortBy%>"
                            CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10"></asp:Label>
                        <asp:Label ID="Label6" runat="server" Text=":" CssClass="gridHeadText"
                            ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                    </td>
                    <td align="left" style="background-color: #808080; padding-top: 2px; padding-bottom: 2px;">
                        <telerik:RadComboBox runat="server" ID="cbSortBy">
                            <Items>
                                <telerik:RadComboBoxItem Text="<%$Resources:Resource,Name%>" Value="name" />
                                <telerik:RadComboBoxItem Text="<%$Resources:Resource,Log_In%>" Value="time" Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="divDataGrid" style="/*height:100%;*/padding-right:4px; padding-left:4px;">
        <telerik:RadGrid
            ID="radGrdActivityLog" Height="100%"
            runat="server"
            Skin="Default"
            GridLines="None"
            AllowPaging="true"
            AllowCustomPaging="true" 
            AllowSorting="false"
            AllowFilteringByColumn="false"
            ItemStyle-Wrap="false"
            OnNeedDataSource="radGrdActivityLog_NeedDataSource"
            OnPageSizeChanged="radGrdActivityLog_PageSizeChanged"
            >
            <GroupingSettings CaseSensitive="false" />
            <PagerStyle
                Mode="NextPrevAndNumeric"
                HorizontalAlign="Right"/>            
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                <%--<Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400px"  />--%>
                <ClientEvents OnGridCreated="GridCreated" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="false">
                <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10"  />
                <AlternatingItemStyle Height="31px"  Font-Names="Arial" Font-Size="10" />
                <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                <FooterStyle Height="25px" Font-Names="Arial"/>
                <Columns>
                    <telerik:GridHyperLinkColumn HeaderText="<%$Resources:Resource,Name%>" UniqueName="UserName" HeaderTooltip="Click to sort"
                        DataNavigateUrlFields="UserId" DataNavigateUrlFormatString="~/App/Settings/UserMenu.aspx?userId={0}&flag=" 
                        DataTextField="UserName" DataTextFormatString="{0}" >
                        <HeaderStyle Wrap="true" Width="20%" />
                        <ItemStyle Wrap="false" Width="20%" />
                    </telerik:GridHyperLinkColumn>
                    <telerik:GridHyperLinkColumn HeaderText="<%$Resources:Resource,Organization%>"
                        DataNavigateUrlFields="OrganizationId,OrganizationName" DataNavigateUrlFormatString="~/App/Settings/SettingsMenu.aspx?organization_id={0}&Organization_name={1}"
                        DataTextField="OrganizationName">
                        <HeaderStyle Wrap="true" Width="20%" />
                        <ItemStyle Wrap="false" Width="20%" />
                    </telerik:GridHyperLinkColumn>
                    <telerik:GridBoundColumn HeaderText="<%$Resources:Resource,Log_In%>" DataField="SessionInTime"
                        UniqueName="SessionInTime">
                        <HeaderStyle Wrap="true" Width="20%" />
                        <ItemStyle Wrap="false" Width="20%" />                        
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="<%$Resources:Resource,Logout%>" DataField="SessionOutTime" AllowSorting="false"
                        UniqueName="SessionOutTime">
                        <HeaderStyle Wrap="true" Width="20%" />
                        <ItemStyle Wrap="false" Width="20%" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>                        
    </div>
    <asp:HiddenField ID="hfPageSize" runat="server" />
</asp:Content>

