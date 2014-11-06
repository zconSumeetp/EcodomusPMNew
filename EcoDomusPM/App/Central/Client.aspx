<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master"
    AutoEventWireup="true" CodeFile="Client.aspx.cs" Inherits="App_Central_Client" %> 
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="codeClient" runat="server">
    <script language="javascript" type="text/javascript">

        function btnAddNewClient_click() {
            var url = "../Central/AddNewClient.aspx";
            manager = $find("<%=radWindowMgrAddClient.ClientID%>");
            var windows = manager.get_windows();
            var intWidth = document.body.clientWidth;
            var intHeight = document.body.clientHeight;
            windows[0]._width = parseInt(intWidth * 0.40);
            windows[0]._height = parseInt(intHeight * 0.32);
            windows[0]._top = parseInt(screen.height* 0.2);
            windows[0]._left = parseInt(screen.width * 0.3);
            windows[0].setUrl(url);
            windows[0].show();
            //windows[0].set_modal(false);
            return false;
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


        function Clear() {
            document.getElementById("ContentPlaceHolder1_txtSearch").value = "";
            return false;
        }

        function delete_client() {
            var flag;
            flag = confirm("Do you want to delete this client?");
            return flag;
        }

        function validateRole() {
            alert("Please select role to login.");
            return false;
        }
        function refreshgrid() {
            document.getElementById("ContentPlaceHolder1_btn_RefreshGrid").click();
        }

    </script>

    <script type="text/javascript" language="javascript">
        window.onload = body_load;
        function resize_Nice_Scroll() {

           
        }


        function body_load() {
            var screenhtg = set_NiceScrollToPanel();

            document.getElementById("<%=txtSearch.ClientID %>").focus();
           
           }



           function RightMenu_expand_collapse(index) {
               debugger;

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
            var pageSize = document.getElementById("ContentPlaceHolder1_hfClientPMPageSize").value;
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

    </telerik:RadCodeBlock>

    <style type="text/css">
         .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color:#808080;
        }
        html
        {
            overflow:hidden;
        }
        </style>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
    <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <table border="0" width="100%"  >     
        <tr>
            <td class="topbuttons"  >
                <asp:Button OnClientClick="javascript:return btnAddNewClient_click()" ID="btnAddNewClient"
                    Text="<%$Resources:Resource,Assign_Organization_To_Client%>" Width="180px" runat="server" />
            </td>
        </tr>
         <tr>
              <td style="display: none;">
                  <table>
                      <tr>
                          <td style="padding-top: 0px; display: none" align="left">
                              <asp:HiddenField ID="hfClientPMPageSize" runat="server" Value="" />
                          </td>
                      </tr>
                  </table>
              </td>
          </tr>
        <tr>
            <td class="centerAlign" style="width:100%" >
           <div class="rpbItemHeader">
                   <table cellpadding="0" cellspacing="0" width="100%" style="background-color:#808080;">
                        <tr>
                            <td align="left" class="entityImage"  style="width:50%;">
                                <asp:Label runat="server" Text="<%$Resources:Resource,Clients%>" ID="lbl_grid_head" CssClass="gridHeadText"
                                    Width="200px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                            </td>
                            <td align="right" style=" background-color:#808080;padding-top: 02px;
                                padding-bottom: 02px;" >
                                <div id="div_search" style="width: 200px; background-color: white;" >
                                 <asp:Panel ID="aspPanel" Width="100%"  runat="server" DefaultButton="btnSearch">
                                <table>
                                <tr>
                                <td>
                                <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                    Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="180px">
                                </telerik:RadTextBox>
                            
                                </td><td>
                                <asp:ImageButton ClientIDMode="Static" ID="btnSearch"  runat="server"
                                    ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnSearch_Click" />
                                    </td>
                                    </tr>
                            </table>
                             </asp:Panel>
                            </div>
                            </td>
                            
                            <td align="right" style="padding: 4px 6px 0 0;">
                                <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                            </td>
                            </tr>
                    </table>
                </div>

                <div id="divSelectedDomponentContent" class="divProperties RightMenu_1_Content">
                    <telerik:RadGrid ID="rgClient" runat="server" Skin="Default" OnItemCommand="OnItemCommand_rgClient"
                        PagerStyle-AlwaysVisible="true" AutoGenerateColumns="false" OnItemDataBound="rgClient_OnItemDataBound"
                        AllowSorting="true" BorderWidth="1px" AllowPaging="true" PageSize="10" OnPageIndexChanged="rgClient_OnPageIndexChanged"
                        OnSortCommand="rgClient_SortCommand" OnPageSizeChanged="rgClient_OnPageSizeChanged">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                        <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                            <Selecting AllowRowSelect="true" />
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                            <ClientEvents OnGridCreated="GridCreated" />
                           <%-- <Resizing AllowResizeToFit="true" AllowRowResize="true" />--%>
                        </ClientSettings>
                        <MasterTableView EditMode="EditForms" DataKeyNames="clientId,ConnectionString,clientName">
                            <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                            <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                            <FooterStyle Height="25px" Font-Names="Arial" />
                            <Columns>
                                <telerik:GridBoundColumn DataField="clientId" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ConnectionString" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="Client Name" DataField="clientName"
                                    SortExpression="clientName" UniqueName="clientName">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkName" CommandName="" runat="server" CommandArgument="select"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"clientName")%>' />
                                    </ItemTemplate> 

                                    <ItemStyle  Font-Underline="True" Wrap="false" Width="35%" />
                                     <HeaderStyle  Font-Underline="false" Wrap="false" Width="35%" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource,Organization_Name%>" UniqueName="organization_name"
                                    DataField="OrganizationName" SortExpression="organization_name">
                                    <ItemStyle Wrap="false" Width="35%" />
                                     <HeaderStyle Wrap="false" Width="35%" />

                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource,Login_As%>" EditFormColumnIndex="0"
                                    SortExpression="systemRole">
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="cmb_role" ToolTip="Select Role" runat="server"  >
                                        </telerik:RadComboBox>
                                    </ItemTemplate>
                                    <ItemStyle  HorizontalAlign="Left" Width="16%" Wrap="false" />
                                    <HeaderStyle HorizontalAlign="Left" Width="16%" Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn>
                                    <ItemStyle  Width="10%" Wrap="false" />
                                    <HeaderStyle Width="10%" Wrap="false" />
                                    <ItemTemplate>
                                        <asp:Button ID="btnClientLogin" CommandName="Login" Text="<%$Resources:Resource,OK%>" ToolTip="Login"
                                            runat="server" Width="100%"  />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn> 
                                    <%--<ItemStyle  Width="5%"  Wrap="false" />
                                    <HeaderStyle Width="5%"  Wrap="false" />
                                   --%> <ItemTemplate>
                                        <asp:ImageButton OnClientClick="javascript:return delete_client()" CommandName="delete_client" ToolTip="Delete Client"
                                            ID="imgbtnDelete" runat="server" alt="Delete" ImageUrl="~/App/Images/Delete.gif" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                        <%--<ClientSettings>
                        <ClientEvents OnRowSelected="Test" OnColumnClick="Test" OnKeyPress="Test" OnCommand="Test" OnRowClick="Test"/>
                    </ClientSettings>--%>
                    </telerik:RadGrid>
                </div>
               
            </td>
        </tr>
        
    </table>

    
                 
    <div style="display: none">
        <telerik:RadButton ID="btnRefresh" Visible="true" runat="server" OnClick="btnRefresh_Click">
        </telerik:RadButton>
        <asp:Button ID="btn_RefreshGrid" runat="server" OnClick="btn_RefreshGrid_Click" />
    </div>
    <telerik:RadWindowManager ID="radWindowMgrAddClient" runat="server" VisibleTitlebar="true"  Title="Add New Client" Behaviors="Close,Move" 
        BorderWidth="0px"  Skin="Simple" BorderStyle="None" >
        <Windows>
            <telerik:RadWindow ID="radWindowAddClient"   runat="server" ReloadOnShow="false"
                Width="450" Height="330" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" EnableAjaxSkinRendering="false" EnableShadow="true" BackColor="Black"
                Modal="true" BorderWidth="2" Overlay="false" >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server" >
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgClient">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgClient" LoadingPanelID="loadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgClient" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgClient" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_RefreshGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgClient" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
   </telerik:RadAjaxManagerProxy>
        
             <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px" Skin="Default">
      
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
