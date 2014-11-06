<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="User.aspx.cs" Inherits="App_Reports_UserProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">   
     
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript" language="javascript">
            window.onload = body_load;
            function resize_Nice_Scroll() {
            }

            function GetParameterValues(param) {
                var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < url.length; i++) {
                    var urlparam = url[i].split('=');
                    if (urlparam[0] == param) {
                        return urlparam[1];
                    }
                }
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


            function body_load() {
                var screenhtg = set_NiceScrollToPanel();
                if (GetParameterValues('flag') != 'no_master') {
                    //var screenhtg = set_NiceScrollToPanel();

                }
                document.getElementById("<%=txtSearch.ClientID %>").focus();
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

        </script>
         <script src="../../App_Themes/EcoDomus/jquery-1.8.3.js" type="text/javascript"></script>

    </telerik:RadCodeBlock>

    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
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
    <telerik:RadCodeBlock ID="codeClient" runat="server">
        <script type="text/javascript" language="javascript">
            function Clear() {
                document.getElementById("ContentPlaceHolder1_txtSearch").value = "";
                return false;
            }


            function get() {
                var answer = confirm("Do you want to delete this User?")
                if (answer)
                    return true;
                else
                    return false;

            }

            function ConfigureDesign() {

            }

            function SetCaption(flag) {

                if (flag == "Y") {
                    document.getElementById("divPageHeader").style.display = 'none';
                }
                else {
                    document.getElementById("divPageHeader").style.display = 'Inline';
                }
            }

            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }

            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {
                //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
                var pageSize = document.getElementById("ContentPlaceHolder1_hfUserPMPageSize").value;
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
    </telerik:RadCodeBlock>
        <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
        <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
      <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Default"  DecoratedControls="Buttons,RadioButtons,Scrollbars" />
          
          <table id="tblUser" style="width: 100%; overflow: hidden;border-bottom-style: none; border-bottom-width: 0px;" >
          <caption style="display: none;">
                <div id="divPageHeader" visible="true">
                    <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Users%>">:</asp:Label>
                </div>
            </caption>
            <tr>
            <td class="topbuttons" >

                            <asp:Button ID="btnAddNewUser" runat="server" Text="<%$Resources:Resource,Add_New_User%>"
                                Width="150px" TabIndex="4" OnClick="btnAddNewUser_Click" />
                       
                    </td>
             </tr>
              <tr>
              <td style="display: none;">
                  <table>
                      <tr>
                          <td style="padding-top: 0px; display: none" align="left">
                              <asp:HiddenField ID="hfUserPMPageSize" runat="server" Value="" />
                               <asp:HiddenField ID="hfprojectid" runat="server" />
                          </td>
                      </tr>
                  </table>
              </td>
          </tr>
             <tr>
                <td class="centerAlign" >
                    <div class="rpbItemHeader ">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                            <tr>
                                <td align="left" class="entityImage"  style="width: 50%;">
                                    <asp:Label runat="server" Text="<%$Resources:Resource,Users%>" ID="Label1" CssClass="gridHeadText"
                                        Width="200px"></asp:Label>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                    >
                                    <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnsearch"> 
                                    <div id="div_search" style="width: 200px; background-color: white;" >
                                        <table>
                                            <tr>
                                                <td>                                                
                                                 <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                    Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="180px">
                                                  </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ClientIDMode="Static" ID="btnsearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                        OnClick="btnSearch_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    </asp:Panel>
                                </td>
                                <td align="right" style="padding: 4px 4px 0 0;">
                                  <%--  <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                        ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContent" class="divProperties RightMenu_1_Content">
                        <telerik:RadGrid ID="rgUsers" runat="server" BorderWidth="1px" CellPadding="0" AutoGenerateColumns="False"
                            AllowSorting="True" GridLines="None" PageSize="10" OnItemCommand="rgUsers_ItemCommand"
                            OnSortCommand="rgUsers_SortCommand" OnPreRender="rgUsers_OnPreRender" OnPageSizeChanged="rgUsers_PageSizeChanged"
                            ItemStyle-Wrap="false" OnPageIndexChanged="rgUsers_PageIndexChanged" PagerStyle-AlwaysVisible="true"
                            Skin="Default" OnItemDataBound="rgUsers_OnItemDataBound">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                            <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                <Selecting AllowRowSelect="true" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                                <ClientEvents OnGridCreated="GridCreated" />
                            </ClientSettings>
                            <MasterTableView DataKeyNames="ID,system_role" AllowPaging="true">
                                <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                                <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                <FooterStyle Height="25px" Font-Names="Arial" />
                                <Columns>
                                    <telerik:GridButtonColumn ButtonType="LinkButton" SortExpression="Name" CommandName="EditUser"
                                        HeaderText="<%$Resources:Resource,Name%>" DataTextField="Name" UniqueName="Name">
                                        <ItemStyle  Font-Underline="true" Width="20%" />
                                        <HeaderStyle   Width="20%" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridBoundColumn DataField="org_name" SortExpression="org_name" HeaderText="<%$Resources:Resource,Organization%>"
                                        UniqueName="org_name">
                                        <ItemStyle  Wrap="false" Width="20%" />
                                        <HeaderStyle Wrap="false" Width="20%"/>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="title" HeaderText="<%$Resources:Resource,Title%>"
                                        UniqueName="title">
                                        <ItemStyle  Wrap="false" Width="10%"/>
                                        <HeaderStyle Wrap="false"  Width="10%"/>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="phone" AllowSorting="true" HeaderText="<%$Resources:Resource,Phone_Number%>"
                                        UniqueName="phone">
                                        <ItemStyle  Wrap="false" Width="10%"/>
                                        <HeaderStyle Wrap="false" Width="10%"/>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="email_address" AllowSorting="true" HeaderText="<%$Resources:Resource,Email%>"
                                        UniqueName="email_address">
                                        <ItemStyle  Wrap="false" Width="20%"/>
                                        <HeaderStyle Wrap="false" Width="20%"/>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="system_role" HeaderText="<%$Resources:Resource,System_Role%>"
                                        UniqueName="system_role">
                                        <ItemStyle  Width="10%"/>
                                        <HeaderStyle Wrap="false" Width="10%" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="ID" SortExpression="org_name" UniqueName="clone" HeaderText="<%$Resources:Resource,Clone%>">
                                        <%--<ItemStyle  Font-Underline="true"  Width="2%"/>--%>
                                       <%-- <HeaderStyle Font-Underline="true" Width="5%" />--%>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnClone" runat="server" alt="Clone" CommandName="cloneuser"
                                                ImageUrl="~/App/Images/clone.gif" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="ID" SortExpression="org_name" UniqueName="delete" HeaderText="<%$Resources:Resource,Delete%>">
                                        <%--<ItemStyle  Font-Underline="true"  Width="2%"/>--%>
                                        <%--<HeaderStyle Font-Underline="true" Width="5%" />--%>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deleteuser"
                                                OnClientClick="javascript:return get();" ImageUrl="~/App/Images/Delete.gif" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <ExpandCollapseColumn Visible="False">
                                    <HeaderStyle Width="5%" />
                                </ExpandCollapseColumn>
                                <RowIndicatorColumn Visible="False">
                                    <HeaderStyle Width="5%" />
                                </RowIndicatorColumn>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbl_msg" runat="server"></asp:Label>
                </td>
            </tr>           
          
        </table>
    <telerik:RadAjaxManagerProxy ID="Ajax_manager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgUsers">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgUsers" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgUsers" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server" Width="50px">
    </telerik:RadAjaxLoadingPanel>
   
</asp:Content>
