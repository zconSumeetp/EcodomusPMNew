<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrganizationProject.aspx.cs" Inherits="App_Settings_OrganizationProject" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head runat="server">
    <title></title>
    
    <script type="text/javascript" language="javascript" >

        function resize_Nice_Scroll() {

           // $(".divScroll").getNiceScroll().resize();
        } 

        function body_load() {
            $("html").css('overflow-y', 'hidden');
            $("html").css('overflow-x', 'auto');
            var screenhtg = parseInt(window.screen.height * 0.66);
            document.getElementById("divSelectedDomponentContent").style.height = screenhtg * 0.60;
            $(".divScroll").niceScroll({ touchbehavior: false, cursorcolor: "#969696", cursoropacitymax: 0.8, cursorborder: "none", cursorwidth: 10, background: "#cccccc", overflow: "hidden" });
            $("#divSelectedDomponentContent").show();

        }
        //window.onload = body_load;

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
        function Clear() {
            document.getElementById("txtSearch").value = "";
            return false;
        }

        function NavigateToProjectProfile() {
            top.location.href = "../Settings/ProjectMenu.aspx?pagevalue=ProjectProfile&pk_project_id=" + document.getElementById("hfprojectid").value;
        }

        function validate() {
            alert("Unable to add a project");
            return false;
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

        function addproject() {
            top.location.href = "../settings/projectmenu.aspx?pagevalue=ProjectProfile&pk_project_id=" + document.getElementById("hfprojectid").value + "&org_id=" + document.getElementById("hforgid").value + "&org_name=" + document.getElementById("hforgname").value + "&ispage=organization";
        }

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }
        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {

            var pageSize = document.getElementById("hfDocumentPMPageSize").value;
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
    <%--<style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
        .rpbItemHeader
             {
            background-color:#808080;
             }
             .divProperties
                {
                    background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
                }
                html
                {
                    overflow:hidden;
                }
    </style>--%>
   
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
  <%--  <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
</head>
<body style="background: #F7F7F7; padding: 0px">
<form id="form1" runat="server">
<telerik:RadScriptManager ID="ScriptManager1" runat="server" >
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
<script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />

    <table style="width:100%;table-layout:fixed" >
      <tr>
        <td style="">
            <div style="height:10px;">
                <asp:Button ID="btnAddProject" runat="server" Text="<%$Resources:Resource,Add_New_Project%>"
                    Width="150px" TabIndex="4" onclick="btnAddProject_Click"/>
            </div>
        </td>
    </tr>
       <tr>
           <td class="centerAlign" style="width: 100%;">
               <div class="rpbItemHeader ">
                   <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                       <tr>
                           <td align="left" class="entityImage">
                               <asp:Label runat="server" Text="<%$Resources:Resource,Projects%>" ID="lbl_grid_head"
                                   CssClass="gridHeadText" Width="100px" ForeColor="#F8F8F8" Font-Names="Arial"
                                   Font-Size="12"></asp:Label>
                           </td>
                           <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;">
                               <div id="div1" style="width: 200px; background-color: white;">
                                   <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch">
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
                           <td align="right" style="padding: 4px 6px 0 0; width: 20px">
                               <%--  <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)"  />--%>
                           </td>
                       </tr>
                   </table>
               </div>
               <div id="divSelectedDomponentContent">
                   <telerik:RadGrid Width="100%" ID="rgProjects" runat="server" BorderWidth="1px" CellPadding="0"
                       AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True" GridLines="None"
                       PageSize="10" OnItemCommand="rgProjects_ItemCommand" OnSortCommand="rgProjects_SortCommand"
                       OnPageSizeChanged="rgProjects_PageSizeChanged" ItemStyle-Wrap="false" OnPageIndexChanged="rgProjects_PageIndexChanged"
                       PagerStyle-AlwaysVisible="true" Skin="Default" OnItemDataBound="rgProjects_ItemDataBound">
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
                                   <ItemStyle CssClass="" Wrap="false" Width="35%" />
                                   <HeaderStyle Wrap="false" Width="35%" />
                               </telerik:GridButtonColumn>
                               <telerik:GridBoundColumn DataField="lead_organization" HeaderText="<%$Resources:Resource,Lead_Organization%>"
                                   UniqueName="OrganizationName" SortExpression="lead_organization">
                                   <ItemStyle CssClass="" Wrap="false" Width="30%"></ItemStyle>
                                   <HeaderStyle Wrap="false" Width="30%" />
                               </telerik:GridBoundColumn>
                               <telerik:GridBoundColumn DataField="owner_org" HeaderText="<%$Resources:Resource,Owner_Organization%>"
                                   UniqueName="owner_org" SortExpression="owner_org">
                                   <ItemStyle CssClass="" Wrap="false" Width="16%"></ItemStyle>
                                   <HeaderStyle Wrap="false" Width="16%" />
                               </telerik:GridBoundColumn>
                               <telerik:GridBoundColumn DataField="State" HeaderText="<%$Resources:Resource,City_State_1%>"
                                   UniqueName="State">
                                   <ItemStyle CssClass="" Wrap="false" Width="13%" />
                                   <HeaderStyle CssClass="" Wrap="false" Width="13%" />
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
           </td>
        </tr>
        <tr>
             <td style="text-align:right;vertical-align:middle;float:right;">
       </td>
        </tr>
        
    <tr>
     <asp:HiddenField ID="hfprojectid" runat="server" />  
     <asp:HiddenField ID="hfDocumentPMPageSize"  runat="server" Value="" />  
    </tr>
    </table>
   
<%--</div>--%>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxyPage1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rgProjects">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rgProjects" LoadingPanelID="alpProjects" />                
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnSearch">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rgProjects" LoadingPanelID="alpProjects" />                
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="alpProjects" runat="server" Skin="Default" InitialDelayTime="0">
</telerik:RadAjaxLoadingPanel>

<asp:HiddenField ID="hforgid" runat="server" />
<asp:HiddenField ID="hforgname" runat="server" />

</form>
</body>
</html>


