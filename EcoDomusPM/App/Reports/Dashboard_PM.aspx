<%@ Page Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true" CodeFile="Dashboard_PM.aspx.cs" Inherits="App.Reports.DashboardPM" Title="EcoDomus PM : Dashboard" %>
<%@ MasterType VirtualPath="~/App/EcoDomus_PM_New.master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <style type="text/css">
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        
        .RadDock
        {
            text-align: left;
            font: 11px/14px arial,verdana,sans-serif;
            font-weight: bold;
        }

        .RadDock .rdTitlebar
        {
            height: auto;
            background-image: none !important;
            font-size: 1.1em;
            line-height: 2em;
        }

        .RadDock div
        {
            border-color: #eee !important;
        }

        .RadDock .innerWrp
        { 
            margin: 0;
            padding: 10px;
        }

        #ctl00_ContentPlaceHolder1_rdoTasksDueToday
        {
            border: solid thin #afeffa;
        }

        #ctl00_ContentPlaceHolder1_rdoTasksDueToday .rdTable .rdTop td
        {
            background: #afeffa;
        }

        #ctl00_ContentPlaceHolder1_rdoTasksDueToday #ctl00_ContentPlaceHolder1_rdoTasksDueToday_T
        {
            background: #afeffa;
            font-weight: bold;
        }

        #ctl00_ContentPlaceHolder1_rdoConflicts
        {
            border: solid thin #FA8AC6;
        }

        #ctl00_ContentPlaceHolder1_rdoConflicts .rdTable .rdTop td
        {
            background: #FA8AC6;
        }

        #ctl00_ContentPlaceHolder1_rdoConflicts #ctl00_ContentPlaceHolder1_rdoConflicts_T
        {
            background: #FA8AC6;
            font-weight: bold;
        }

        #ctl00_ContentPlaceHolder1_rdoCommitementsToYou
        {
            border: solid thin #cbc633;
        }

        #ctl00_ContentPlaceHolder1_rdoCommitementsToYou .rdTable .rdTop td
        {
            background: #cbc633;
        }

        #ctl00_ContentPlaceHolder1_rdoCommitementsToYou #ctl00_ContentPlaceHolder1_rdoCommitementsToYou_T
        {
            background: #cbc633;
            font-weight: bold;
        }

        #ctl00_ContentPlaceHolder1_rdoCommitmentsByyou
        {
            border: solid thin #FFAC5A;
        }

        #ctl00_ContentPlaceHolder1_rdoCommitmentsByyou .rdTable .rdTop td
        {
            background: #FFAC5A;
        }

        #ctl00_ContentPlaceHolder1_rdoCommitmentsByyou #ctl00_ContentPlaceHolder1_rdoCommitmentsByyou_T
        {
            background: #FFAC5A;
            font-weight: bold;
        }

        #ctl00_ContentPlaceHolder1_rdoIncomingRequests
        {
            border: solid thin #add45f;
        }

        #ctl00_ContentPlaceHolder1_rdoIncomingRequests .rdTable .rdTop td
        {
            background: #add45f;
        }

        #ctl00_ContentPlaceHolder1_rdoIncomingRequests #ctl00_ContentPlaceHolder1_rdoIncomingRequests_T
        {
            background: #add45f;
            font-weight: bold;
        }

        #ctl00_ContentPlaceHolder1_rdoOutgoingRequests
        {
            border: solid thin #ffcd33;
        }

        #ctl00_ContentPlaceHolder1_rdoOutgoingRequests .rdTable .rdTop td
        {
            background: #ffcd33;
        }

        #ctl00_ContentPlaceHolder1_rdoOutgoingRequests #ctl00_ContentPlaceHolder1_rdoOutgoingRequests_T
        {
            background: #ffcd33;
            font-weight: bold;
        }

        .raddock
        {
            margin-bottom: 25px !important;
        }

        .RadDock
        {
            text-align: left;
            font: 11px/14px arial,verdana,sans-serif;
            font-weight: bold;
        }

        .RadDock .rdTitlebar
        {
            height: auto;
            background-image: none !important;
            font-size: 1.1em;
            line-height: 2em;
        }

        .RadDock div
        {
            border-color: White !important;
        }

        .RadDock .innerWrp
        {
            margin: 0;
            padding: 10px;
        }

        #ctl00_ContentPlaceHolder1_rdoAlerts
        {
            border: solid thin #afeffa;
        }

        #ctl00_ContentPlaceHolder1_rdoAlerts .rdTable .rdTop td
        {
            background: #afeffa;
        }

        #ctl00_ContentPlaceHolder1_rdoAlerts #ctl00_ContentPlaceHolder1_rdoAlerts_T
        {
            background: #afeffa;
            font-weight: bold;
        }

        #ctl00_ContentPlaceHolder1_rdoFacility
        {
            border: solid thin #FA8AC6;
        }

        #ctl00_ContentPlaceHolder1_rdoFacility .rdTable .rdTop td
        {
            background: #FA8AC6;
        }

        #ctl00_ContentPlaceHolder1_rdoFacility #ctl00_ContentPlaceHolder1_rdoFacility_T
        {
            background: #FA8AC6;
            font-weight: bold;
        }
        
        #ctl00_ContentPlaceHolder1_rdoRecentProjects
        {
            border: solid thin #AFEFFA;
        }

        #ctl00_ContentPlaceHolder1_rdoRecentProjects .rdTable .rdTop td
        {
            background: #AFEFFA;
        }

        #ctl00_ContentPlaceHolder1_rdoRecentProjects #ctl00_ContentPlaceHolder1_rdoRecentProjects_T
        {
            background: #AFEFFA;
            font-weight: bold;
        }
        
        #ctl00_ContentPlaceHolder1_rdoIssues
        {
            border: solid thin #FFAC5A;
        }

        #ctl00_ContentPlaceHolder1_rdoIssues .rdTable .rdTop td
        {
            background: #FFAC5A;
        }

        #ctl00_ContentPlaceHolder1_rdoIssues #ctl00_ContentPlaceHolder1_rdoIssues_T
        {
            background: #FFAC5A;
            font-weight: bold;
        }
        
        #ctl00_ContentPlaceHolder1_rdoInbox
        {
            border: solid thin #cbc633;
        }

        #ctl00_ContentPlaceHolder1_rdoInbox .rdTable .rdTop td
        {
            background: #cbc633;
        }

        #ctl00_ContentPlaceHolder1_rdoInbox #ctl00_ContentPlaceHolder1_rdoInbox_T
        {
            background: #cbc633;
            font-weight: bold;
        }

        #ctl00_ContentPlaceHolder1_rdoDemand_Response
        {
            border: solid thin #FFAC5A;
        }
        
        #ctl00_ContentPlaceHolder1_rdoDemand_Response .rdTable .rdTop td
        {
            background: #FFAC5A;
        }

        #ctl00_ContentPlaceHolder1_rdoDemand_Response #ctl00_ContentPlaceHolder1_rdoDemand_Response_T
        {
            background: #FFAC5A;
            font-weight: bold;
        }

        .raddock
        {
            margin-bottom: 25px !important;
        }

        .column
        {
            font-size:small;
        }
    </style>
    
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" /> 
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" language="javascript">
        function project_validate() {
            alert('Please select the project.');
            window.location = '../Settings/Project.aspx';
            return false;
        }

        function delete_issues() {
            return confirm("Are you sure you want to delete this item?");
        }

        function close_issues() {
            return confirm("Are you sure you want to close this issue?");
        }

        function ClearText() {
            document.getElementById("ctl00_ContentPlaceHolder1_rdoConflicts_C_txtSearch").value = "";
            return false;
        }

        function ClearAll() {
            document.getElementById("ctl00_ContentPlaceHolder1_rdoTasksDueToday_C_txtSearch1").value = "";
            return false;
        }

        function clickButton_txtSearch(e, buttonid) {
            var bt = document.getElementById(buttonid);
            if (bt) {
                if (navigator.appName.indexOf("Netscape") > (-1)) {
                    if (e.keyCode == 13) {
                        bt.click();
                        return false;
                    }
                }

                if (navigator.appName.indexOf("Microsoft Internet Explorer") > (-1)) {
                    if (event.keyCode == 13) {
                        bt.click();
                        return false;
                    }
                }
            }
        }

        function clickButton_txtSearch1(e, buttonid) {
            var bt = document.getElementById(buttonid);
            if (bt) {
                if (navigator.appName.indexOf("Netscape") > (-1)) {
                    if (e.keyCode == 13) {
                        bt.click();
                        return false;
                    }
                }

                if (navigator.appName.indexOf("Microsoft Internet Explorer") > (-1)) {
                    if (event.keyCode == 13) {
                        bt.click();
                        return false;
                    }
                }
            }
        }

        function Validate() {
            alert("File not uploaded for this facility");
            return false;
        }

        function NavigateToProjectProfile(projectId) {
            top.location.href = "../Settings/ProjectMenu.aspx?pagevalue=ProjectProfile&pk_project_id=" + projectId;
        }
    
        function resize_Nice_Scroll() {
            $(".divScroll").getNiceScroll().resize();
        }

        function body_load() {
            $("#divResentFacilitiesContent").show();
            $("#divResentProjectsContent").show();
            $("#divmenubar").show();
        }

        window.onload = body_load;

        function RightMenu_expand_collapse(index) {
            var img = document.getElementById("RightMenu_" + index + "_img_expand_collapse");
            $('.RightMenu_' + index + '_Content').toggle();
            if (img.src.indexOf("asset_carrot_up") != -1) {
                img.src = img.src.replace("asset_carrot_up", "asset_carrot_down");
            }
            else {
                img.src = img.src.replace("asset_carrot_down", "asset_carrot_up");
            }
        }

        function closeRecentEntityWindow(entity) {
            $('#tblRecent' + entity).hide();
        }
    </script>
    
    <telerik:RadFormDecorator id="rdfAll" DecoratedControls="Buttons" Skin="Default" runat="server" />

    <table border="0" style="width: 100%;" align="center" id="tbldashbord">
        <tr>
            <td class="centerAlign">
                <div id="div_recent_project" runat="server" style="display:block">
                    <table cellpadding="0" cellspacing="0" style="table-layout: fixed;" id="tblRecentProjects">
                        <tr style="background-color:#808080;">
                            <td align="left" class="entityImage" style="width:100%;padding:2px;">
                                <asp:Image ID="Image1" runat="server" Style=" padding: 4px 4px 0 0; vertical-align: middle;" ImageAlign="Left" ImageUrl="~/App/Images/Icons/icon_projects_sm_white.png" />
                                <asp:Label runat="server" Text="<%$Resources:Resource,Recent_Projects%>" ID="Label2" CssClass="gridHeadText" Width="150px" style="vertical-align:middle" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12" />
                                <asp:Label ID="LabelProjectCount" style="vertical-align:middle" runat="server" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12" />
                            </td>
                            <td align="right" style="width: 25px; padding: 4px 4px 0 0;">
                                <asp:Image runat="server" Visible="false" ImageUrl="~/App/Images/Icons/asset_close_lg_white.png" onclick="closeRecentEntityWindow('Projects');" ClientIDMode="Static" ID="Image5" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <div id="divResentProjectsContent" class="divScroll RightMenu_2_Content">
                                    <telerik:RadGrid ID="RadGridRecentProjects" runat="server" AutoGenerateColumns="False" BorderWidth="1px" 
                                                     HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" OnItemCommand="RadGridRecentProjects_OnItemCommand" 
                                                     OnItemDataBound="RadGridRecentProjects_OnItemDataBound" Skin="Default">
                                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                                        <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                            <Selecting AllowRowSelect="true" />
                                        </ClientSettings>
                                        <MasterTableView DataKeyNames="Id, Name, RecentEntityProperties.ClientId, RecentEntityProperties.ConnectionString"> 
                                            <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                                            <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                            <FooterStyle Height="25px" Font-Names="Arial" />
                                            <Columns>
                                                <telerik:GridButtonColumn DataTextField="Name" UniqueName="Name" HeaderText="<% $Resources:Resource, Project_Name %>" ButtonType="LinkButton" CommandName="ShowProfile">
                                                    <ItemStyle CssClass="column" Font-Underline="true" Width="30%" />
                                                </telerik:GridButtonColumn>
                                                <telerik:GridBoundColumn DataField="OwnerOrganizationName" UniqueName="OwnerOrganizationName" HeaderText="<% $Resources:Resource, Owner_Organization %>">
                                                    <ItemStyle CssClass="column" Width="25%" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="LeadOrganizationName" UniqueName="LeadOrganizationName" HeaderText="<% $Resources:Resource, Lead_Organization %>">
                                                    <ItemStyle CssClass="column" Width="25%" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CityState" UniqueName="CityState" HeaderText="<% $Resources:Resource, City_State_1 %>">
                                                    <ItemStyle CssClass="column" Width="25%" />
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td style="height: 5px">
            </td>
        </tr>
        <tr>
            <td class="centerAlign">
                <div id="div_recent_facility" runat="server" style="display:block">
                    <table cellpadding="0" cellspacing="0" style="table-layout: fixed;" id="tblRecentFacilities" >
                        <tr style="background-color: #808080">
                            <td align="left" class="entityImage" style="width:100%;padding:2px;">
                                <asp:Image ID="igm_building" runat="server" Style=" padding: 4px 4px 0 0; vertical-align: middle;" ImageAlign="Left" ImageUrl="~/App/Images/Icons/icon_facilities_sm_white.png" />
                                <asp:Label runat="server" Text="<%$Resources:Resource,Recent_Facilities%>" ID="Label1" CssClass="gridHeadText" style="vertical-align:middle" Width="150px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12" />
                                <asp:Label ID="LabelFacilityCount" style="vertical-align:middle" runat="server" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12" />
                            </td>
                            <td align="right" style="width: 25px; padding: 4px 4px 0 0;">
                                <asp:Image runat="server" Visible="false" ImageUrl="~/App/Images/Icons/asset_close_lg_white.png" onclick="closeRecentEntityWindow('Facilities');" ClientIDMode="Static" ID="Image3" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" >
                                <div id="divResentFacilitiesContent" class="divScroll RightMenu_1_Content">
                                    <telerik:RadGrid runat="server" ID="RadGridRecentFacilities" AutoGenerateColumns="False" HeaderStyle-HorizontalAlign="Left" 
                                                     ItemStyle-HorizontalAlign="Left" OnItemCommand="RadGridRecentFacilities_OnItemCommand" OnItemDataBound="RadGridRecentFacilities_OnItemDataBound" 
                                                     OnPreRender="RadGridRecentFacilities_OnPreRender" PagerStyle-AlwaysVisible="true" Skin="Default">
                                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                                        <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                            <Selecting AllowRowSelect="true" />
                                        </ClientSettings>
                                        <MasterTableView DataKeyNames="Id, Name, RecentEntityProperties.ClientId, RecentEntityProperties.ConnectionString, Project.Id, Project.Name">
                                            <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                                            <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                            <FooterStyle Height="25px" Font-Names="Arial" />
                                            <Columns>
                                                <telerik:GridButtonColumn DataTextField="Name" UniqueName="Name" HeaderText="<% $Resources:Resource, Name %>" ButtonType="LinkButton" CommandName="ShowProfile">
                                                    <ItemStyle CssClass="column" Font-Underline="true" Width="30%" />
                                                </telerik:GridButtonColumn>
                                                <telerik:GridBoundColumn DataField="CityState" UniqueName="CityState" HeaderText="<% $Resources:Resource, City_State_1 %>">
                                                    <ItemStyle CssClass="column" Width="25%" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="<% $Resources:Resource, Project_Name %>" UniqueName="ProjectName" DataField="Project.Name"> 
                                                    <ItemStyle CssClass="column" Width="25%" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn UniqueName="ViewInBIM" HeaderText="<% $Resources:Resource, BIM %>">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="ImageButtonViewInBIM" runat="server" Text="<% $Resources:Resource, BIM %>" CommandName="ViewInBIM" ImageUrl="~/App/Images/Icons/icon_BIMview_sm.png" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

