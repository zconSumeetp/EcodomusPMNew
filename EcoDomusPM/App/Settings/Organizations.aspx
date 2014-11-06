<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomus_PM_New.master"  AutoEventWireup="true"
    CodeFile="Organizations.aspx.cs" Inherits="App_Settings_Organizations" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="loadPopUp" runat="server">
        <script type="text/javascript" language="javascript">
            function Clear() {
                 document.getElementById("<%=txtSearch.ClientID %>").value = "";

               return false;
            }

            function keypress(e) {

                if (e.keyCode == 13) {

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

            function get1() {
                var answer = confirm("Are you sure you want to delete this Organization?")
                if (answer)
                    return true;
                else
                    return false;

            }

            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }
        </script>
        <script type="text/javascript" language="javascript">
            window.onload = body_load;
            function body_load() {
                   var screenhtg = set_NiceScrollToPanel();
                document.getElementById("<%=txtSearch.ClientID %>").focus();
             }

            function resize_Nice_Scroll() {
                 if (document.getElementById("<%=txtSearch.ClientID %>") != null)
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

            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {
                //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
                var pageSize = document.getElementById("ContentPlaceHolder1_hfOrgnizatioPMPageSize").value;
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
        
        </style>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <asp:Panel ID="aspPanel"  runat="server" DefaultButton="btnSearch">
  
    <table style="margin-top: 0px; margin-left: 0px;" width="100%">
     <tr>
            <td class="topbuttons">
                
                    <asp:Button ID="btnNewOrganization" runat="server" Width="170px" Text="<%$Resources:Resource,Add_New_Organization%>" TabIndex="4"
                        OnClick="btnNewOrganization_Click" />
                
            </td>
        </tr>
     <tr>
              <td style="display: none;">
                  <table>
                      <tr>
                          <td style="padding-top: 0px; display: none" align="left">
                              <asp:HiddenField ID="hfOrgnizatioPMPageSize" runat="server" Value="" />
                              
                          </td>
                      </tr>
                  </table>
              </td>
          </tr>
     <tr>
            <td class="centerAlign">
                <div class="rpbItemHeader ">
                    <table cellpadding="0" cellspacing="0" width="100%" style="background-color:#808080;">
                        <tr>
                            <td align="left" class="entityImage"  style="width:30%;">
                                <asp:Label runat="server" Text="<%$Resources:Resource,Organizations%>" ID="lbl_grid_head" CssClass="gridHeadText"
                                    Width="200px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                            </td>
                            
                            <td align="center" style="width:15%;">
                                <asp:Label ID="Label2" runat="server" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="11"  Text="<%$Resources:Resource,Organization_Type%>"></asp:Label>
                                <asp:Label ID="Label1" runat="server" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="11"  Text=":"></asp:Label>
                            </td>

                            <td>
                                <telerik:RadComboBox ID="cmbOrganizationType" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="cmbOrganizationType_SelectedIndexChanged" TabIndex="2">
                                </telerik:RadComboBox>
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
                                <asp:ImageButton ClientIDMode="Static" ID="btnSearch"  runat="server"
                                    ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnSearch_Click" />
                                    </td>
                                    </tr>
                            </table>
                            </div>
                            </td>
                            
                            <td align="right" style="padding: 4px 6px 0 0;">
                              <%--  <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                            </td>
                            </tr>
                    </table>
                </div>

                <div id="divSelectedDomponentContent" class="divProperties RightMenu_1_Content">
                    <telerik:RadGrid ID="RgOrganizations" runat="server" AutoGenerateColumns="False"
                        BorderWidth="1px" AllowSorting="True" PagerStyle-AlwaysVisible="true" AllowPaging="true" OnItemDataBound="RgOrganizations_OnItemDataBound"
                        PageSize="10" Skin="Default" OnItemCommand="OnItemCommand_RgOrganizations" OnPageIndexChanged="RgOrganizations_PageIndexChanged"
                        OnPageSizeChanged="RgOrganizations_PageSizeChanged" OnSortCommand="RgOrganizations_SortCommand">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                        <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                            <Selecting AllowRowSelect="true" />
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                            <ClientEvents OnGridCreated="GridCreated" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="ID,name,Role,primary_contact">
                            <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                            <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                            <FooterStyle Height="25px" Font-Names="Arial" />
                            <Columns>
                                <telerik:GridBoundColumn DataField="ID" HeaderText="ID" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridButtonColumn DataTextField="name" HeaderText="<%$Resources:Resource,Name%>"
                                    ButtonType="LinkButton" UniqueName="Name" SortExpression="name" CommandName="EditOrganization">
                                    <ItemStyle  Wrap="false" Width="30%" />
                                    <HeaderStyle  Wrap="false" Width="30%"  />
                                </telerik:GridButtonColumn>
                                <telerik:GridBoundColumn DataField="type_name" HeaderText="<%$Resources:Resource,Type%>"
                                    SortExpression="type_name">
                                      <ItemStyle  Wrap="false" Width="20%" />
                                    <HeaderStyle  Wrap="false" Width="20%"  />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="state" HeaderText="<%$Resources:Resource,City_State%>"
                                    SortExpression="state">
                                      <ItemStyle  Wrap="false" Width="10%" />
                                    <HeaderStyle  Wrap="false" Width="10%"  />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="email_address" SortExpression="email_address"
                                    AllowSorting="true" HeaderText="<%$Resources:Resource,Email%>">
                                      <ItemStyle  Wrap="false" Width="15%" />
                                    <HeaderStyle  Wrap="false" Width="15%"  />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="web_address" SortExpression="web_address" AllowSorting="true"
                                    HeaderText="<%$Resources:Resource,WebSite%>">
                                      <ItemStyle  Wrap="false" Width="15%" />
                                    <HeaderStyle  Wrap="false" Width="15%"  />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn UniqueName="delete"  SortExpression="web_address"  HeaderText="<%$Resources:Resource,Delete%>">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnDelete" runat="server" ToolTip="Delete Organizations" ImageUrl="../Images/Delete.gif" CausesValidation="false"
                                            OnClientClick="javascript:return get1();" CommandName="RemoveOrganization" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Role" UniqueName="Role" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="primary_contact" UniqueName="primary_contact"
                                    Visible="false">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </td>
        </tr>
        
        <tr>
            <td>
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    </asp:Panel>
    <%--
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>--%>
  
    <telerik:RadAjaxManagerProxy ID="organizationsManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbOrganizationType">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgOrganizations" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgOrganizations" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RgOrganizations">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgOrganizations" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
    
</asp:Content>
