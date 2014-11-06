<%@ Page Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="Project.aspx.cs" Inherits="App.Settings.Projects" Title="EcoDomus PM: Projects" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 
    <style type="text/css">
         .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color:#808080;
        }
            
            </style>
    <script type="text/javascript" language="javascript">
        window.onload = body_load;
        function body_load() {
		var screenhtg = set_NiceScrollToPanel();
    	
              if(document.getElementById("<%=txtSearch.ClientID %>") != null )
                document.getElementById("<%=txtSearch.ClientID %>").focus();
          }

          function doClick(buttonName, e) {
              //the purpose of this function is to allow the enter key to 
              //point to the correct button to click.
              var key;

              if (window.event)
                  key = window.event.keyCode;     //IE
              else
                  key = e.which;     //firefox

              if (key == 13) {
                  //Get the button the user wants to have clicked
                  var btn = document.getElementById(buttonName);
                  if (btn != null) { //If we find the button click it
                      btn.click();
                      event.keyCode = 0
                  }
              }
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
    
        function resize_Nice_Scroll(){

            if (document.getElementById("<%=txtSearch.ClientID %>") != null)
                document.getElementById("<%=txtSearch.ClientID %>").focus();
         }
        

    </script>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        function Clear() {
            document.getElementById("ContentPlaceHolder1_txtSearch").value = "";
            return false;
        }

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }

        function NavigateToProjectProfile() {
            top.location.href = "../Settings/ProjectMenu.aspx?pagevalue=ProjectProfile&pk_project_id=" + document.getElementById("ContentPlaceHolder1_hfprojectid").value;
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
        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {
            //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
            var pageSize = document.getElementById("ContentPlaceHolder1_hfProjectPMPageSize").value;
            var scrollArea = sender.GridDataDiv;
            var dataHeight = sender.get_masterTableView().get_element().clientHeight;
            //sender.get_masterTableView().set_pageSize(pageSize);
            if (dataHeight < parseInt(pageSize) * 40) {
                scrollArea.style.height = dataHeight + "px";
            }
            else {
                scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
            }

        }
    </script>

    
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
   <%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
   --%> 
    <%--<div id="Profile">--%>
    <%--<asp:Panel ID="panelSearch" runat="server">--%>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
        <asp:Panel ID="pnlProjectsId" runat="server" DefaultButton="btnsearchProject" >

        <table style="width: 100%; table-layout:fixed; " border="0">
            <caption style ="display:none;" >
                <div id="divPageHeader" visible="true" >
                 <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Projects%>">:</asp:Label>
              </div>
            </caption>  
            <tr>
                <td class="topbuttons" >
                  
                        <asp:Button ID="btnAddProject" runat="server" Text="<%$Resources:Resource,Add_New_Project%>"
                            Width="150px" TabIndex="4" OnClick="btnAddProject_Click" />
                
                </td>
            </tr>        
            <tr>
              <td style="display: none;">
                  <table>
                      <tr>
                          <td style="padding-top: 0px; display: none" align="left">
                              <asp:HiddenField ID="hfProjectPMPageSize" runat="server" Value="" />
                              
                          </td>
                      </tr>
                  </table>
              </td>
          </tr>
            <tr>
                <td class="centerAlign">
                  <div class="rpbItemHeader"  >
                    <table cellpadding="0" cellspacing="0" width="100%" style="background-color:#808080;">
                        <tr>
                        
                            <td align="left" class="entityImage"  style="width:50%;">
                                <asp:Label runat="server" ID="lbl_grid_head" CssClass="gridHeadText" Text="<%$Resources:Resource,Projects%>"
                                    Width="200px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                            </td>
                            <td align="right" style=" background-color:#808080;padding-top: 02px;
                                padding-bottom: 02px;" >
                                <div id="div_search" style="width: 200px; background-color: white;" >
                                <table>
                                <tr>
                                <td>
                                <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                    Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="180px">
                                </telerik:RadTextBox>
                            
                             </td><td>
                                <asp:ImageButton ClientIDMode="Static" ID="btnsearchProject"  runat="server"
                                    ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnSearch_Click" />
                                    </td>
                                    </tr>
                            </table>
                            </div>
                            </td>
                            
                            <td align="right" style="padding: 4px 4px 0 0;">
                                <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                            </td>
                            </tr>
                    </table>
                </div>

                <div id="divSelectedDomponentContent"  class="divProperties RightMenu_1_Content" >
                    <telerik:RadGrid ID="rgProjects" runat="server" BorderWidth="1px" CellPadding="0"
                        AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True" GridLines="None"
                        PageSize="10" OnItemCommand="rgProjects_ItemCommand" OnSortCommand="rgProjects_SortCommand"
                        ItemStyle-Height="15px" OnPageSizeChanged="rgProjects_PageSizeChanged" ItemStyle-Wrap="false"
                        OnPageIndexChanged="rgProjects_PageIndexChanged" PagerStyle-AlwaysVisible="true"
                        Skin="Default" OnItemDataBound="rgProjects_OnItemDataBound">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                        <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                            <Selecting AllowRowSelect="true" />
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                            <ClientEvents OnGridCreated="GridCreated" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="pk_project_id,cons_string,project_name,pk_client_id"
                            ClientDataKeyNames="pk_project_id,project_name">
                            <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                            <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                            <FooterStyle Height="25px" Font-Names="Arial" />
                            <Columns>
                                <telerik:GridButtonColumn DataTextField="project_name" HeaderText="<%$Resources:Resource,Project_Name%>"
                                    ButtonType="LinkButton" ItemStyle-Font-Underline="true" SortExpression="project_name"
                                    UniqueName="project_name" CommandName="Edit">
                                    <ItemStyle  Wrap="false" Width="20%" />
                                    <HeaderStyle Wrap="false" Width="20%" />
                                </telerik:GridButtonColumn>
                                <telerik:GridBoundColumn DataField="lead_organization" HeaderText="<%$Resources:Resource,Lead_Organization%>"
                                    UniqueName="OrganizationName" SortExpression="lead_organization">
                                    <ItemStyle  Wrap="false" Width="25%"></ItemStyle>
                                    <HeaderStyle Wrap="false" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="owner_org" HeaderText="<%$Resources:Resource,Owner_Organization%>"
                                    UniqueName="owner_org" SortExpression="owner_org">
                                    <ItemStyle  Wrap="false" Width="25%"></ItemStyle>
                                    <HeaderStyle Wrap="false" Width="25%"/>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="State" HeaderText="<%$Resources:Resource,City_State_1%>"
                                    UniqueName="State">
                                    <ItemStyle  Wrap="false" Width="15%"></ItemStyle>
                                    <HeaderStyle  Wrap="false" Width="15%"/>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="cons_string" HeaderText="conn string" Display="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="client_name" HeaderText="client" Display="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="pk_client_id" HeaderText="client_id" Display="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="enabled" UniqueName="enabled" Visible="false">
                                    <ItemStyle ></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="client_name" HeaderText="Client" UniqueName="client_name">
                                    <ItemStyle  Wrap="false" Width="15%"></ItemStyle>
                                    <HeaderStyle Wrap="false" Width="15%"/>
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
                    </div>
                               
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
                    <telerik:AjaxUpdatedControl ControlID="RadGridRecentProjects" LoadingPanelID="RadAjxPanelId1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnsearchProject">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridRecentProjects" LoadingPanelID="RadAjxPanelId1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjxPanelId1" runat="server" Skin="Default" InitialDelayTime="0" Width="75px" Height="50px">
        <%-- <asp:Image ID="imgLoading" runat="server" ImageUrl="~/App/Images/loading3.gif" />--%>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
