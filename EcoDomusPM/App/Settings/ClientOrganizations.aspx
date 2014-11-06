<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientOrganizations.aspx.cs"
    MasterPageFile="~/App/EcoDomus_PM_New.master" Inherits="App_Settings_ClientOrganizations" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">--%>
<%--<html>
<head>--%>
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

           if(document.getElementById("<%=txtSearch.ClientID %>") != null)
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

        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {
            //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
            var pageSize = document.getElementById("ContentPlaceHolder1_hfClientOrgaPMPageSize").value;
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
    </telerik:RadCodeBlock>
     <link href="../../App_Themes/EcoDomus/style_new_1.css" rel="stylesheet" type="text/css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    
         
  
    <telerik:radformdecorator id="rdfTaskEquipment" runat="server" skin="Default" decoratedcontrols="Buttons,RadioButtons,Scrollbars" />
    <asp:Panel ID="pnlClintOrgnizarionId" runat="server" DefaultButton="btnsearch" >
    <table width="100%" style="table-layout:fixed;" >
           
           
            <tr>
                <td class="topbuttons">
                    
                        <asp:Button ID="btnAddNewResources" runat="server" Text="<%$Resources:Resource, Assign_Organization%>"
                            OnClick="btnAddNewResources_Click" />
                  
                </td>
            </tr>    
            <tr>
              <td style="display: none;">
                  <table>
                      <tr>
                          <td style="padding-top: 0px; display: none" align="left">
                              <asp:HiddenField ID="hfClientOrgaPMPageSize" runat="server" Value="" />
                              
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
                                <td align="left" class="entityImage"  style="width:20%;">
                                    <asp:Label runat="server" Text="<%$Resources:Resource,Organizations%>" ID="lbl_grid_head"
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
                                                    <asp:ImageButton ClientIDMode="Static" ID="btnsearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                        OnClick="btnSearch_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td align="right" style="padding: 4px 6px 0 0;">
                                    <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                        ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                   <div id="divSelectedDomponentContent" class="divProperties RightMenu_1_Content" >
                  <telerik:RadGrid ID="rgResources" runat="server" AllowPaging="True" AllowSorting="True"  
                        AutoGenerateColumns="False" BorderWidth="1px" CellPadding="0" GridLines="None"
                       OnItemCommand="rgResources_ItemCommand" Skin="Default" ItemStyle-Wrap="false" 
                        OnItemDataBound="rgResources_ItemDataBound" OnSortCommand="rgResources_SortCommand" OnPageIndexChanged="rgResources_OnPageIndexChanged" 
                          PagerStyle-AlwaysVisible="true" OnPageSizeChanged="rgResources_OnPageSizeChanged" PageSize="10" >
                          <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                        <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                            <Selecting AllowRowSelect="true" />
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                            <ClientEvents OnGridCreated="GridCreated" />
                        </ClientSettings>
                       <MasterTableView  DataKeyNames="pk_organization_id,primary_contact_id,Role,OrganizationName">
                            <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                            <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                            <FooterStyle Height="25px" Font-Names="Arial" />
                           <Columns>
                            <telerik:GridButtonColumn ButtonType="LinkButton" HeaderText="<%$Resources:Resource, Name%>" DataTextField="OrganizationName" ItemStyle-Font-Underline="true"  
                               CommandName="EditOrganization" CommandArgument="sel" SortExpression="OrganizationName" HeaderButtonType="TextButton" UniqueName="name">
                                <ItemStyle  Font-Underline="true" Wrap="false" Width="20%" />
                                <HeaderStyle  Wrap="false" Width="20%" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="OrganizationType" HeaderText="<%$Resources:Resource, Type%>" UniqueName="OrganizationType">
                                <ItemStyle  Width="13%" Wrap="false"></ItemStyle>                               
                                <HeaderStyle Width="13%" Wrap="false"/>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="primary_contact_id" HeaderText=" primary_contact_id" UniqueName="primary_contact_id" Visible="false">
                                <ItemStyle Width="10%" ></ItemStyle>                               
                                <HeaderStyle Width="10%" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="citystate" HeaderText="<%$Resources:Resource, City_State%>" UniqueName="CityState"  HeaderStyle-Wrap="false" >
                                <ItemStyle  Wrap="false" Width="10%"></ItemStyle> 
                                <HeaderStyle  Wrap="false" Width="10%"/>                              
                            </telerik:GridBoundColumn>
                            
                           <telerik:GridBoundColumn DataField="PrimaryContact" HeaderText="<%$Resources:Resource, Primary_Contact%>" UniqueName="PrimaryContact" HeaderStyle-Wrap="false">
                            <ItemStyle  Width="10%" Wrap="false"></ItemStyle>
                            <HeaderStyle Width="10%" Wrap="false"/>
                            </telerik:GridBoundColumn>
                            
                           <%-- <telerik:GridBoundColumn DataField="Phone_Number" HeaderText="<%$Resources:Resource, Phone%>" UniqueName="PhoneNumber">
                            <ItemStyle CssClass="column" Width="150px"></ItemStyle>
                            </telerik:GridBoundColumn>--%>
                            
                            <telerik:GridBoundColumn DataField="Email_Address" HeaderText="<%$Resources:Resource, Email%>" UniqueName="Email">
                            <ItemStyle  Wrap="false" Width="15%"></ItemStyle>
                            <HeaderStyle Wrap="false" Width="15%"/>
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="web_address" HeaderText="<%$Resources:Resource, Website%>" UniqueName="web_address">
                            <ItemStyle  Wrap="false" Width="15%"></ItemStyle>
                            <HeaderStyle Wrap="false" Width="15%"/>
                            </telerik:GridBoundColumn>
                            
                             <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, Status%>" SortExpression="Role" UniqueName="status" >
                             <%--<ItemStyle Wrap="false" Width="5%"/>
                            <HeaderStyle Wrap="false" Width="5%"/>--%>
                                <ItemTemplate>
                                    <asp:Button ID="btn" runat="server" ToolTip="Assigned" Text="Request Pending" Width="140px"   CommandArgument='<%# DataBinder.Eval(Container.DataItem,"pk_organization_id") %>' />
                                    
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            
                             <telerik:GridTemplateColumn Visible="false" >
                                <ItemTemplate>
                                    <asp:Label ID="lblColor" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Color")%>'  Width="10px"  />
                              </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, Unassign%>" SortExpression="Role" UniqueName="unassign" >
                            <ItemStyle Wrap="false" Width="2%"/>
                            <HeaderStyle Wrap="false" Width="6%"/>
                                <ItemTemplate>
                                    <asp:ImageButton  ID="btnRemove" runat="server" ImageUrl="../Images/remove.gif" CausesValidation="false"  ToolTip="Unassign"  Width="20px"    CommandName ="RemoveOrganization"/>
                              </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="Role" UniqueName="Role" Visible="false"></telerik:GridBoundColumn>
                            <%--<telerik:GridBoundColumn DataField="organization_project_type_id" HeaderText="organization_project_type_id" Visible="false"  UniqueName="organization_project_type_id">
                                <ItemStyle CssClass="column"></ItemStyle>                               
                            </telerik:GridBoundColumn>--%>
                            
                        </Columns> 
                    </MasterTableView> 
                    <AlternatingItemStyle CssClass="alternateColor" />
                    </telerik:RadGrid>
                    </div>
                </td>
            </tr>
            
            
        </table>
    </asp:Panel>
    <asp:Label ID="lblMessage" runat="server" CssClass="LabelText" ForeColor="Red"></asp:Label>
    <%--   <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>--%>
    <telerik:radajaxmanagerproxy id="organizationsManagerProxy" runat="server">
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
    </telerik:radajaxmanagerproxy>
    <telerik:radajaxloadingpanel id="RadAjaxLoadingPanel1" skin="Default" runat="server" Height="75px"
        width="50px">
    </telerik:radajaxloadingpanel>
    <%--</form>--%>
    <%--</body>--%>
    <%--</html>--%>
</asp:Content>
<%--</asp:Content>--%>
