<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="Roles.aspx.cs" Inherits="App_Settings_Roles" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="content1" ContentPlaceHolderID="contentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">

        function validate_delete() {

            alert("This role is created by System Admin.You can not delete it.")

        }

        function gotoPage(id, pagename, created_by, System_role) {
            var url;
            if (pagename == "Role") {
                url = "RolesMenu.aspx?roleid=" + id + "&created_by=" + created_by + "&System_role=" + System_role;  //+ "&pagevalue=AssetProfile";
            }


            window.location.href(url);
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


        function delete_Role() {
            var answer = confirm("Do you want to delete this role?")
            if (answer)
                return true;
            else
                return false;
        }

        function Clear() {
            try {
                document.getElementById("ContentPlaceHolder1_txtRole").value = "";
                document.getElementById("<%=txtRole.ClientID %>").focus();
                return false;
            }
            catch (e) {
                alert(e.message + "  " + e.Number);
                return false;
            }
        }


        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }
    </script>
    <script type="text/javascript" language="javascript">
        window.onload = body_load;
        function resize_Nice_Scroll() {

         
            if (document.getElementById("<%=txtRole.ClientID %>") != null)
                document.getElementById("<%=txtRole.ClientID %>").focus();
        }


        function body_load() {
         var screenhtg = set_NiceScrollToPanel();
         
         if( document.getElementById("<%=txtRole.ClientID %>") != null )
                document.getElementById("<%=txtRole.ClientID %>").focus();
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
            debugger;
            //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);

            var pageSize = document.getElementById("ContentPlaceHolder1_hfSearchResultPMPageSize").value;
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
    <%--<link href="../../App_Themes/EcoDomus/style_new_1.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />--%>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <asp:Panel ID="pnlRolesId" runat="server" DefaultButton="btnsearch" >

        <table align="left" style="table-layout:fixed; width:100%">
           <tr>
                <td class="topbuttons">
                    <asp:Button ID="btnAddRole" runat="server" Text="<%$Resources:Resource,Add_Role%>"
                        Width="80px" OnClick="btnAddRole_Click"></asp:Button>
                </td>
            </tr>
        
           <tr>
              <td style="display: none;">
                  <table>
                      <tr>
                          <td style="padding-top: 0px; display: none" align="left">
                              <asp:HiddenField ID="hfSearchResultPMPageSize" runat="server" Value="" />
                              
                          </td>
                      </tr>
                  </table>
              </td>
          </tr>
            <tr>
                <td class="centerAlign">
                
                    <div class="rpbItemHeader ">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                            <tr>
                                <td align="left" class="entityImage"  style="width: 50%;">
                                    <asp:Label runat="server" ID="lbl_grid_head" CssClass="gridHeadText" Text="<%$Resources:Resource,Roles%>"
                                        Width="200px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                    >
                                    <div id="div_search" style="width: 200px; background-color: white;" >
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtRole" Width="180px">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ClientIDMode="Static" ID="btnsearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                        OnClick="btnsearch_Click" />
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
                        <telerik:RadGrid ID="rgRoles" runat="server" AllowPaging="True" AllowSorting="True"
                            AutoGenerateColumns="False"   CellPadding="0" GridLines="None" BorderWidth="1px" AllowCustomPaging="true"
                            OnItemCommand="rgRoles_ItemCommand" Skin="Default" ItemStyle-Wrap="false" OnSortCommand="rgRoles_SortCommand"
                            OnPageIndexChanged="rgRoles_OnPageIndexChanged" PagerStyle-AlwaysVisible="true" OnItemDataBound="rgRoles_OnItemDataBound"
                            OnPageSizeChanged="rgRoles_OnPageSizeChanged" PageSize="10" >
                           
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                                        <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                            <Selecting AllowRowSelect="true" />
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                                            <ClientEvents OnGridCreated="GridCreated" />
                                        </ClientSettings>
                                <MasterTableView DataKeyNames="pk_project_role_id,linkrole,name,system_role,created_by">
                                        <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                                            <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                            <FooterStyle Height="25px" Font-Names="Arial" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="pk_project_role_id" UniqueName="RoleId" Visible="false">
                                        <ItemStyle CssClass="column" Wrap="false"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="system_role" UniqueName="SystemRole" Visible="false">
                                        <ItemStyle CssClass="column" Wrap="false"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="created_by" UniqueName="CreatedBy" Visible="false">
                                        <ItemStyle Wrap="false"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="linkrole" HeaderText="<%$Resources:Resource,Role_Name%>"
                                        UniqueName="RoleName" SortExpression="name">
                                        <ItemStyle Width="30%"  Wrap="false"></ItemStyle>
                                        <HeaderStyle Width="30%"  Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>"
                                        UniqueName="Description" HeaderStyle-Wrap="false">
                                        <ItemStyle Width="50%"  Wrap="false"></ItemStyle>
                                        <HeaderStyle Width="50%"  Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="pk_project_role_id" UniqueName="imgbtnDelete_" SortExpression="pk_project_role_id"
                                        HeaderText="<%$Resources:Resource,Delete%>">
                                        <ItemStyle  Width="5%" />
                                        <HeaderStyle  Width="5%" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="<%$Resources:Resource,Delete%>"
                                                CommandName="deleteRole" ToolTip="Delete Role" ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return delete_Role();" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                            <AlternatingItemStyle CssClass="alternateColor" />
                        </telerik:RadGrid>
                    </div>
                
                </td>
            </tr>
            
            </table>
         </asp:Panel>
         <telerik:RadAjaxManagerProxy ID="Ajax_manager" runat="server">
        
        <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgRoles"  LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            </AjaxSettings>
            </telerik:RadAjaxManagerProxy>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server" Height="50px"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
        <asp:HiddenField runat="server" ID="hf_role_delete" />
        <asp:HiddenField runat="server" ID="hf_system_role" />
        <asp:HiddenField runat="server" ID="hf_created_by" />
   
</asp:Content>
