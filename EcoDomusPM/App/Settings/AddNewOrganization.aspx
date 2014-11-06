<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddNewOrganization.aspx.cs"
    Inherits="App_Settings_AddNewOrganization" MasterPageFile="~/App/EcoDomus_PM_New.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<telerik:RadCodeBlock ID="RadCodeBlock2" runat="server"> 
    <script type="text/javascript" language="javascript">
        window.onload = body_load;
        function resize_Nice_Scroll() {

         
            if (document.getElementById("<%=txtSearch.ClientID %>") != null)
                document.getElementById("<%=txtSearch.ClientID %>").focus();

        }

        function body_load() {
            var screenhtg = set_NiceScrollToPanel();
                if (document.getElementById("<%=txtSearch.ClientID %>") != null)
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


        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
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

        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {
            //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
            var pageSize = document.getElementById("ContentPlaceHolder1_hfNewClientOrgaPMPageSize").value;
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
         <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    
    <script type="text/javascript">

        function Navigate() {

            window.location.href = "~/App/Settings/AddNewOrganization.aspx";
            return false;

        }
        function Clear() {
            document.getElementById("ContentPlaceHolder1_txtSearch").value = "";
            document.getElementById("ContentPlaceHolder1_ddlOrgType").value = "00000000-0000-0000-0000-000000000000";
            return false;
        }
    </script>
    <style type="text/css">
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
       
    </style>
    <script type="text/javascript" language="javascript">
        function Clear() {
            document.getElementById("ContentPlaceHolder1_txtSearch").value = "";
            return false;
        }

        function keypress(e) {

            if (e.keyCode == 13) {

            }

        }

//        function sitemap() {
//            document.getElementById("divsitemap").innerHTML =
//                                            "<span><img id='ctl00_ctl00_SiteMapPath1_ctl01_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
//                                           "</span><span><a>Project Setup</a></span>" + "&nbsp;" +
//                                            "<span><img id='ctl00_ctl00_SiteMapPath1_ctl03_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
//                                            "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;" +
//                                            "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
//                                            "</span><span>Assign organization</span><a id='ctl00_ctl00_SiteMapPath1_SkipLink'></a></span>";

        //        }
        function sitemap() {
            document.getElementById("SiteMapPath1").innerHTML =
                                            "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px;' />" + "&nbsp;" +
                                            "</span><span>Project Setup</span>" + "&nbsp;" +
                                            "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px;' />" + "&nbsp;" +
                                            "</span><span><a style='width: 15px; height: 15px; border-top-width: 0px; border-right-width: 0px; color border-bottom-width: 0px; border-left-width: 0px;' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;" +
                                            "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px;' />" + "&nbsp;" +
                                            "</span><span>Assign organization</span><a id='SiteMapPath1_SkipLink'></a></span>";

         }

    </script>
    </telerik:RadCodeBlock>
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Default" DecoratedControls="Buttons" />
  <asp:Panel ID="pnlClintOrgnizarionId" runat="server" DefaultButton="btnsearch" >
    <table width="100%" style="table-layout:fixed;" >  
          <tr>
              <td class="topbuttons" >
              <asp:Button ID="btnAddNewResources" runat="server" Width="200px" Text="<%$Resources:Resource, Request_To_Add_New_Organization%>"
                        OnClick="btnAddNewResources_Click" />
              </td>
            </tr>
             <tr>
              <td style="display: none;">
                  <table>
                      <tr>
                          <td style="padding-top: 0px; display: none" align="left">
                              <asp:HiddenField ID="hfNewClientOrgaPMPageSize" runat="server" Value="" />
                              
                          </td>
                      </tr>
                  </table>
              </td>
          </tr>

       <tr>
             <td class="centerAlign" style="width:100%;">
                <div class="rpbItemHeader ">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                            <tr>
                                <td align="left" class="entityImage"  style="width:20%;">
                                    <asp:Label runat="server" Text="<%$Resources:Resource,Assign_Organization%>" ID="lbl_grid_head"
                                                        CssClass="gridHeadText">
                                                        </asp:Label>
                                </td>
                                <td style=" width:35%;" >
                                      <%--<div id="div1"  style="background-color: White;">
                                              <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                            width: 100%;">
                                                            <tr>
                                                            <td style="width:9%;" align="center" >
                                                             <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, Organization_Type%>" CssClass="Label"  ></asp:Label>   
                                                             </td>
                                                             <td align="left" width="10%">                           
                                                              <asp:DropDownList ID="ddlOrgType" runat="server" Width="200px" onselectedindexchanged="ddlOrgType_SelectedIndexChanged" AutoPostBack="True" >
                                                             
                                                                </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>--%>
                                <asp:Label ID="lblOrganizationType" runat="server" Text="<%$Resources:Resource, Organization_Type%>"
                                        CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10">:</asp:Label>
                                <asp:Label ID="lblCol2" runat="server"  Text=":"  CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10" ></asp:Label>
                                   <asp:DropDownList ID="ddlOrgType" runat="server" Width="200px" onselectedindexchanged="ddlOrgType_SelectedIndexChanged" AutoPostBack="True" >
                                   </asp:DropDownList>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                    >
                                    <div id="div_search" style="width: 200px; background-color: white;" >
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
                                    </div>
                                </td>
                                <td align="right" style="padding: 4px 6px 0 0;">
                                   <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                        ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
               <div id="divSelectedDomponentContent" class="divProperties RightMenu_1_Content" >
                  <telerik:RadGrid ID="rgResources" runat="server" AllowPaging="True" AllowSorting="True" ItemStyle-Wrap="false"
                        OnItemDataBound="rgAddResources_ItemDataBound1" OnItemCommand="OnItemCommand_rgResources"
                        AutoGenerateColumns="False" BorderWidth="1px" OnPageIndexChanged="rgAddResources_PageIndexChanged"
                        OnSortCommand="rgAddResources_SortCommand" OnPageSizeChanged="rgAddResources_PageSizeChanged"
                        CellPadding="0" GridLines="None" PagerStyle-AlwaysVisible="true" PageSize="10" 
                        Skin="Default" CellSpacing="0">
                         <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                        <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                            <Selecting AllowRowSelect="true" />
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                            <ClientEvents OnGridCreated="GridCreated" />
                        </ClientSettings>

                        <MasterTableView DataKeyNames="organization_id, OrganizationName">
                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                            </ExpandCollapseColumn>
                              <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                            <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                            <FooterStyle Height="25px" Font-Names="Arial" />
                            <Columns>
                                <telerik:GridButtonColumn ButtonType="LinkButton" HeaderText="<%$Resources:Resource, Name%>" DataTextField="OrganizationName"
                                    ItemStyle-Font-Underline="true" CommandName="EditOrganization" CommandArgument="sel" UniqueName="name"
                                    SortExpression="OrganizationName">
                                    <ItemStyle  Font-Underline="true" Wrap="false" Width="23%" />
                                    <HeaderStyle  Wrap="false" Width="23%" />
                                </telerik:GridButtonColumn>
                                <telerik:GridBoundColumn DataField="OrganizationType" HeaderText="<%$Resources:Resource, Type%>" UniqueName="OrganizationType">
                                   <ItemStyle  Width="15%" Wrap="false"></ItemStyle>                               
                                <HeaderStyle Width="15%" Wrap="false"/>                        
                                    </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CityState" HeaderText="<%$Resources:Resource, City_State%> " UniqueName="CityState" HeaderStyle-Wrap="false">
                                    <ItemStyle  Wrap="false" Width="10%"></ItemStyle> 
                                <HeaderStyle  Wrap="false" Width="10%"/>            
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="PrimaryContact" HeaderText="<%$Resources:Resource, Primary_Contact%>"
                                    UniqueName="PrimaryContact"  HeaderStyle-Wrap="false">
                                   <ItemStyle  Width="11%" Wrap="false"></ItemStyle>
                                    <HeaderStyle Width="11%" Wrap="false"/>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="PhoneNumber" HeaderText="<%$Resources:Resource, Phone%>" UniqueName="PhoneNumber">
                                    <ItemStyle  Width="10%" Wrap="false"></ItemStyle>
                                    <HeaderStyle Width="10%" Wrap="false"/>
                                </telerik:GridBoundColumn>
                               <%-- <telerik:GridBoundColumn DataField="Email_Address" HeaderText="<%$Resources:Resource, Email%>" UniqueName="Email">
                                    <ItemStyle CssClass="column" Wrap="false"></ItemStyle>
                                </telerik:GridBoundColumn>--%>
                                 <telerik:GridTemplateColumn HeaderButtonType="TextButton" UniqueName="email" SortExpression="organization_id" HeaderText="<%$Resources:Resource, Email%>">
                                  <ItemStyle  Wrap="false" Width="15%"></ItemStyle>
                                    <HeaderStyle Wrap="false" Width="15%"/>
                                    <ItemTemplate>
                                        <asp:Label ID="Email_Address" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Email_Address")%>'
                                            Width="0px" />
                                    </ItemTemplate>
                                    
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn  UniqueName="status"  SortExpression="organization_id" HeaderText="<%$Resources:Resource, Status%>">
                                    <ItemStyle Wrap="false" Width="15%"/>
                                    <HeaderStyle Wrap="false" Width="15%"/>
                                    <ItemTemplate>
                                        <asp:Button ID="btn" runat="server"  Text="Request Pending" Width="180px" OnClick="btn_Click"
                                            CommandArgument='<%# DataBinder.Eval(Container.DataItem,"organization_id") %>' />
                                    </ItemTemplate>
                                    
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:Label ID="lblPrimaryContact" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"PrimaryContact1")%>'
                                            Visible="false"  />
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:Label ID="lblColor" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Color")%>'
                                            Visible="false"  />
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <%--<telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnRemove" runat="server" ImageUrl="../Images/remove.gif" CausesValidation="false" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>--%>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                            </EditFormSettings>
                            <PagerStyle AlwaysVisible="True"></PagerStyle>
                        </MasterTableView>
                        <AlternatingItemStyle CssClass="alternateColor" />
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Black">
                        </HeaderContextMenu>
                    </telerik:RadGrid>
                    </div>
            </td>
        </tr>
        
        <tr>
            <td colspan="2">
                
            <asp:Label ID="lbl_msg" runat="server" Visible="false"></asp:Label>
            </td>
        </tr>
    </table>
    </asp:Panel>
      
      <%--  <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>--%>
    <telerik:RadAjaxManagerProxy ID="organizationsManagerProxy" runat="server">
        <AjaxSettings>
            
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgResources" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        
         <telerik:AjaxSetting AjaxControlID="ddlOrgType">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgResources" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
      
         <telerik:AjaxSetting AjaxControlID="rgResources">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgResources" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
              </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server" Height="75px"
        Width="50px">
    </telerik:RadAjaxLoadingPanel> 
</asp:Content>
