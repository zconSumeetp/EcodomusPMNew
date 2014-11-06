<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App/EcoDomusPM_Master.master"
    CodeFile="UserProjects.aspx.cs" Inherits="UserProjects" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" language="javascript">
        function setFocus() {
            document.getElementById("<%=txtSearch.ClientID %>").focus();

        }
        window.onload = setFocus;
    </script>
    <script type="text/javascript" language="javascript">
        function Clear() {
            document.getElementById("ContentPlaceHolder1_txtSearch").value = "";
            return false;
        }

        function NavigateToProjectProfile() {
            top.location.href = "../Settings/ProjectMenu.aspx?pagevalue=ProjectProfile&pk_project_id=" + document.getElementById("ContentPlaceHolder1_hfprojectid").value;
        }

        function validate() {
            alert("Unable to add a project");
            return false;
        }

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }

        function SetCaption(flag) {

            if (flag == "Y") {
                document.getElementById("divPageHeader").style.display = 'none';
            }
            else {
                document.getElementById("divPageHeader").style.display = 'Inline';
            }
        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }
        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {

            var pageSize = document.getElementById("ContentPlaceHolder1_hfDocumentPMPageSize").value;
            var scrollArea = sender.GridDataDiv;
            var dataHeight = sender.get_masterTableView().get_element().clientHeight;
            if (!flag) {
                if (dataHeight < parseInt(pageSize) * 40) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
                }
            }
            else {

                if (dataHeight - 260 > 180)
                    scrollArea.style.height = (dataHeight - 220) + "px";
                else if (dataHeight - 260 < 180 && dataHeight > 220)
                    scrollArea.style.height = 220 + "px";
                else
                    scrollArea.style.height = dataHeight + "px";
                flag = false;
            }

        }

        var flag = false;
        function resize_gridHeight() {

            flag = true;
        }

    </script>
    <style type="text/css">
    
      BODY
      {
          margin:0px;
          padding:0px;
      }
     *
     {
          margin:0px;
          padding:0px;
     }
    </style>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
   <%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <%--<div id="Profile">--%>
    <asp:Panel ID="panelSearch" runat="server">
        <table style="margin: 0px 0px 0px 0px;padding:0px; background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); width: 100%" border="0">
            <caption style="display: none;">
                <div id="divPageHeader" visible="true">
                    <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Projects%>">:</asp:Label>
                    <asp:HiddenField ID="hfDocumentPMPageSize"  runat="server" Value="" /> 
                </div>
            </caption>
            <%--  <caption style="height:10px">Projects</caption>--%>
            <%--</div>--%>
          
            <tr>
            <td class="centerAlign" style="width:100%;">
                <div class="rpbItemHeader ">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color:#808080;">
                        <tr>
                           <td align="left" class="entityImage">
                              <asp:Label runat="server" Text="<%$Resources:Resource,Projects%>" ID="lbl_grid_head"
                                             CssClass="gridHeadText" Width="100px" ForeColor="#F8F8F8" Font-Names="Arial"
                                                            Font-Size="12"></asp:Label>
                             </td>  
                             
                             <td align="right" style=" background-color:#808080;padding-top: 02px; padding-bottom: 02px;">
                                <div id="div1" style="width: 200px; background-color: white;">
                                    <asp:Panel ID="panel1" runat="server" DefaultButton="btnSearch" >  
                                    <table>
                                        <tr>
                                            <td>
                                                 <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                            Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="180px">
                                                                        </telerik:RadTextBox>
                                             </td>
                                             <td>
                                                <asp:ImageButton ClientIDMode="Static" ID="btnSearch" Height="13px" runat="server"
                                                                            ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnSearch_Click" />
                                             </td>
                                        </tr>
                                    </table>
                                    </asp:Panel>
                                    </div>
                            </td>  
                            <td align="right" style="padding: 4px 6px 0 0 ; width:20px">
                                 <%--  <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)"  />--%>
                       
                            </td>                    
                        </tr>
                        </table>
                    </div>

                <div id="divSelectedDomponentContent">
                <telerik:RadGrid  ID="rgProjects" runat="server" BorderWidth="1px" CellPadding="0"
                    AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True" GridLines="None"
                    PageSize="10" OnItemCommand="rgProjects_ItemCommand" OnSortCommand="rgProjects_SortCommand"
                       OnPageSizeChanged="rgProjects_PageSizeChanged" ItemStyle-Wrap="false" OnPageIndexChanged="rgProjects_PageIndexChanged"
                    PagerStyle-AlwaysVisible="true" Skin="Default" 
                        onitemdatabound="rgProjects_ItemDataBound">
                    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                    <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                        <Selecting AllowRowSelect="true" />
                        <ClientEvents OnGridCreated="GridCreated" />
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="400px" />
                    </ClientSettings>
                    <MasterTableView DataKeyNames="pk_project_id, cons_string, project_name, pk_client_id"
                        ClientDataKeyNames="pk_project_id,project_name">
                        <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                        <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                        <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                        <FooterStyle Height="25px" Font-Names="Arial" />
                        <Columns>
                            <telerik:GridButtonColumn DataTextField="project_name" HeaderText="<%$Resources:Resource,Project_Name%>"
                                ButtonType="LinkButton" ItemStyle-Font-Underline="true" SortExpression="project_name"
                                CommandName="Edit">
                               <%-- <ItemStyle CssClass="" Wrap="false" Width="35%" />
                                <HeaderStyle Wrap="false" Width="35%" />--%>
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="lead_organization" HeaderText="<%$Resources:Resource,Lead_Organization%>"
                                UniqueName="OrganizationName" SortExpression="lead_organization">
                                <ItemStyle CssClass="" Wrap="false" Width="13%" />
                                <HeaderStyle Wrap="false" Width="13%" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="owner_org" HeaderText="<%$Resources:Resource,Owner_Organization%>"
                                UniqueName="owner_org" SortExpression="owner_org">
                                <ItemStyle CssClass="" Wrap="false" Width="15%" />
                                <HeaderStyle Wrap="false" Width="15%" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="State" HeaderText="<%$Resources:Resource,City_State_1%>"
                                UniqueName="State">
                                <ItemStyle CssClass="" Wrap="false" Width="20%" />
                                <HeaderStyle CssClass="" Wrap="false" Width="20%" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="cons_string" HeaderText="conn string" Display="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="client_name" HeaderText="client" Display="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="pk_client_id" HeaderText="client_id" Display="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="enabled" UniqueName="enabled" Visible="false">
                                <ItemStyle CssClass=""></ItemStyle>
                            </telerik:GridBoundColumn>
                        </Columns>
                        <ExpandCollapseColumn Visible="False">
                            <%--  <HeaderStyle Width="19px" />--%>
                        </ExpandCollapseColumn>
                        <RowIndicatorColumn Visible="False">
                            <%--<HeaderStyle Width="20px" />--%>
                        </RowIndicatorColumn>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
                             
      
                    <%--<telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="90%" BorderWidth="0"
                        ExpandMode="MultipleExpandedItems" BorderColor="Transparent">
                        <ExpandAnimation Type="OutSine" />
                        <Items>
                            <telerik:RadPanelItem Expanded="true" Width="100%" Text="Users" IsSeparator="false"
                                BorderWidth="0" BorderColor="Transparent">
                                <HeaderTemplate>
                                    <asp:Panel ID="pnl_job" runat="server" BorderWidth="0" DefaultButton="btnsearch"
                                        Width="100%" BorderColor="Transparent">
                                        <table id="tbl_jobs" cellpadding="0" cellspacing="0" class="gridRadPnlHeader" runat="server"
                                            width="100%">
                                            <tr>
                                                <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                    <asp:Label runat="server" ID="lbl_grid_head" Text="Projects" CssClass="gridHeadText" Width="100px"></asp:Label>
                                                </td>
                                                <td align="Right" style="padding-right:10px;" onclick="stopPropagation(event)">
                                                    <div id="div_search" onclick="stopPropagation(event)" style="background-color: White;
                                                        width: 170px;">
                                                        <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                            width: 100%;">
                                                            <tr style="border-spacing: 0px;">                                                              
                                                                <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                                    padding-bottom: 0px;">
                                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="90%">
                                                                    </telerik:RadTextBox>
                                                                </td>
                                                                <td align="left" rowspan="0px" width="15%" style="background-color: White; height: 14px;
                                                                    padding-bottom: 0px;">
                                                                    <asp:ImageButton ClientIDMode="Static" ID="btnSearch" Height="13px" runat="server"
                                                                        ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnSearch_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                                <td align="center" class="dropDownImage" onclick="stopPropagation(event)">
                                                    <asp:Image runat="server" Visible="false" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                        ID="img_arrow" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tbl_jobs1" runat="server" cellpadding="0" cellspacing="0" width="100%"
                                            style="background-color: #707070; border-width: 0px;">
                                            <tr>
                                                <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <telerik:RadGrid Width="100%" ID="RadGridRecentProjects" runat="server" BorderWidth="1px" CellPadding="0"
                                        AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True" GridLines="None"
                                        PageSize="10" OnItemCommand="RadGridRecentProjects_ItemCommand" OnSortCommand="RadGridRecentProjects_SortCommand"
                                        OnPageSizeChanged="RadGridRecentProjects_PageSizeChanged" ItemStyle-Wrap="false" OnPageIndexChanged="RadGridRecentProjects_PageIndexChanged"
                                        PagerStyle-AlwaysVisible="true" Skin="Default">
                                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                        <MasterTableView DataKeyNames="pk_project_id,cons_string,project_name,pk_client_id"
                                            ClientDataKeyNames="pk_project_id,project_name">
                                            <Columns>
                                                <telerik:GridButtonColumn DataTextField="project_name" HeaderText="<%$Resources:Resource,Project_Name%>"
                                                    ButtonType="LinkButton" ItemStyle-Font-Underline="true" SortExpression="project_name"
                                                    CommandName="Edit">
                                                    <ItemStyle CssClass="column" Wrap="false" Width="25%" />
                                                    <HeaderStyle Wrap="false" />
                                                </telerik:GridButtonColumn>
                                                <telerik:GridBoundColumn DataField="lead_organization" HeaderText="<%$Resources:Resource,Lead_Organization%>"
                                                    UniqueName="OrganizationName" SortExpression="lead_organization">
                                                    <ItemStyle CssClass="column" Wrap="false" Width="25%"></ItemStyle>
                                                    <HeaderStyle Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="owner_org" HeaderText="<%$Resources:Resource,Owner_Organization%>"
                                                    UniqueName="owner_org" SortExpression="owner_org">
                                                    <ItemStyle CssClass="column" Wrap="false" Width="25%"></ItemStyle>
                                                    <HeaderStyle Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="State" HeaderText="<%$Resources:Resource,City_State_1%>"
                                                    UniqueName="State">
                                                    <ItemStyle CssClass="column" Wrap="false" Width="15%"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="cons_string" HeaderText="conn string" Display="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="client_name" HeaderText="client" Display="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="pk_client_id" HeaderText="client_id" Display="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="enabled" UniqueName="enabled" Visible="false">
                                                    <ItemStyle CssClass="column"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <ExpandCollapseColumn Visible="False">
                                                <HeaderStyle Width="19px" />
                                            </ExpandCollapseColumn>
                                            <RowIndicatorColumn Visible="False">
                                                <HeaderStyle Width="20px" />
                                            </RowIndicatorColumn>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </ContentTemplate>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:RadPanelBar>--%>
                </td>
            </tr>
            
            <tr>
                <asp:HiddenField ID="hfprojectid" runat="server" />
                
            </tr>
        </table>
    </asp:Panel>
    <%--</div>--%>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGridRecentProjects">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridRecentProjects" LoadingPanelID="alpProjects" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridRecentProjects" LoadingPanelID="alpProjects" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="alpProjects" runat="server" Skin="Default" InitialDelayTime="0">
        <%-- <asp:Image ID="imgLoading" runat="server" ImageUrl="~/App/Images/loading3.gif" />--%>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
