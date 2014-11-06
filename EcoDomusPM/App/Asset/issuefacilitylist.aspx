<%@ Page Language="C#" AutoEventWireup="true" CodeFile="issuefacilitylist.aspx.cs"
    Inherits="App_Asset_issuefacilitylist" %>
     
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
  
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
  
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    

    
    <telerik:RadCodeBlock runat="server">
        <script type="text/javascript">
            function stopPropagation(e) {
                
                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            function assign_asset() {
               
                alert("Please Select Component");
                    return false;
            }

            function closeWindow() {
               
                self.close();
            }

            function Clear() {

                document.getElementById("<%=txtClass.ClientID %>").value = "";
                return false;

            }
           
            function facilitystatus() {
            
              document.getElementById("<%=hdnfacility.ClientID %>").value = parent.top.document.getElementById("ContentPlaceHolder1_hdnfacility").value;
                return false;
          }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog      
                else if (window.frameElement != null) {
                    if (window.frameElement.radWindow)
                        oWindow = window.frameElement.radWindow; //IE (and Moz as well)      
                }
                return oWindow;
            }
            function CloseWindow1() {

                // GetRadWindow().BrowserWindow.referesh_project_page();
                GetRadWindow().close();
                //top.location.reload();
                //GetRadWindow().BrowserWindow.adjust_parent_height();
                return false;
            }
            function CancelWindow() {
                CloseWindow1();
            }

            function select_Sub_System(id, name, type_name) 
            {
                //parent.window.load_comp(name, id, type_name);                
                var Radwindow = GetRadWindow();
               // parent.window.regreshgrid();
                parent.window.load_comp(name, id, type_name);                
                //Radwindow.BrowserWindow.load_comp(name, id, type_name);                
                Radwindow.close();

            }

            function load_me() {
                if (document.getElementById("hfnames").value == '' || document.getElementById("hfItems_id").value == '') {
                    alert("Select Category");
                    return false;
                }
                else {
                    window.parent.opener.load_comp(document.getElementById("hfnames").value, document.getElementById("hfItems_id").value, document.getElementById("hfItems_id").value);
                    self.close();
                }
            }
    
        </script>
        <style>
            body
            {
                margin-top:0px;
            }
        </style>
    </telerik:RadCodeBlock>
</head>

<body style="background: white; overflow:hidden; background-color:#EEEEEE; padding: 0px; margin:0px;">
    <form id="form1" runat="server" style="overflow:hidden;">


    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>


    <telerik:RadAjaxManagerProxy ID="issueProfilesManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_asset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

             <telerik:AjaxSetting AjaxControlID="btnSelect">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_asset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>



        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px" Skin="Default">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
    <div style=" overflow:hidden;">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <telerik:RadFormDecorator ID="RadFormDecorator1" DecoratedControls="Buttons" Skin="Default"
            runat="server" />
            <asp:Panel ID="panelSearch" runat="server" >
        
        
        <div  style="width:99%; overflow:hidden; height:440px;">
        <table width="100%" style="margin:2px 0px 2px 2px;">
            <tr>
            <td class="wizardHeadImage"  align="left" valign="middle">
                <div class="wizardLeftImage">
                   <%-- <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />--%>
                    <asp:Label ID="lblHeader" Text="Assign Component" style="font-size :medium;" runat="server"></asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                         OnClientClick="javascript:return CancelWindow();" />
                </div>
            </td>
        </tr>
            </table>
        <table width="95%" align="center" style="table-layout:fixed;" >
                  
            <tr>
                <td  align="center" style="padding-top:10px;" valign="top">
                 <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" BorderWidth="0"
                        ExpandMode="MultipleExpandedItems" BorderColor="Transparent">
                        <ExpandAnimation Type="OutSine" />
                        <Items>
                            <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                                BorderWidth="0" BorderColor="Transparent">
                                <HeaderTemplate>
                                    <asp:Panel ID="pnl_job" runat="server" BorderWidth="0" DefaultButton="btnSearch" Width="100%"
                                        BorderColor="Transparent">
                                        <table id="tbl_jobs" cellpadding="0" cellspacing="0" class="gridRadPnlHeader" runat="server"
                                            width="100%">
                                            <tr>                                                                                            
                                                <td align="right" onclick="stopPropagation(event)">
                                                    <div id="div_search" onclick="stopPropagation(event)" style="background-color: White;
                                                        width: 170px;">
                                                        <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                            width: 100%;">
                                                            <tr style="border-spacing=0px;">
                                                                <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                                    padding-bottom: 0px;">
                                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtClass" Width="100%">
                                                                    </telerik:RadTextBox>
                                                                </td>
                                                                <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                                    padding-bottom: 0px;">
                                                                    <asp:ImageButton ClientIDMode="Static" ID="btnSearch" Height="13px" runat="server"
                                                                        ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnSearch_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                                <td align="center" class="dropDownImage">
                                                    <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
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
                    <telerik:RadGrid ID="rg_asset" Width="100%" runat="server" AllowPaging="True" AllowCustomPaging="true" AutoGenerateColumns="false" ItemStyle-Wrap="false" 
                        Skin="Default" AllowSorting="True" PagerStyle-AlwaysVisible="true" PageSize="10" GridLines="None" OnSortCommand="rg_component_SortCommand"
                        OnPageSizeChanged="rg_component_PageSizeChanged" OnPageIndexChanged="rg_component_PageIndexChanged"  Ite>
                        <PagerStyle Mode="NextPrevAndNumeric"  />
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                            <Scrolling AllowScroll="true" ScrollHeight="300px" />
                        </ClientSettings>
                        <MasterTableView ClientDataKeyNames="pk_asset_id" DataKeyNames="pk_asset_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_asset_id" Visible="false">
                                    <ItemStyle CssClass="column" Wrap="false" />
                                </telerik:GridBoundColumn>
                                <telerik:GridClientSelectColumn>
                                    <ItemStyle Wrap="true" Width="2%" CssClass="column" />
                                    <HeaderStyle Width="2%" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="AssetName" HeaderText="<%$Resources:Resource,Component%>" SortExpression="AssetName">
                                    <HeaderStyle Width="35%" />
                                    <ItemStyle CssClass="column"  Width="35%"   Wrap="false"/>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="typename" HeaderText="<%$Resources:Resource,Type%>">
                                    <HeaderStyle Width="20%" />
                                    <ItemStyle CssClass="column" Width="20%" Wrap="false"/>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="space" HeaderText="<%$Resources:Resource,Space%>">
                                     <HeaderStyle Width="40%" />
                                    <ItemStyle CssClass="column" Width="40%"   Wrap="false" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    </ContentTemplate>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:RadPanelBar>
                   
                </td>
            </tr>
        </table>
        <div style="padding-left:30px; " align="left">
         <br />
                      <asp:Button ID="btnSelect" Visible="true" runat="server" Text="<%$Resources:Resource,Select%>" Width="110px"
                        OnClick="btnSelect_Click" />
                    <asp:Button ID="btnClose" Visible="true" runat="server" Text="<%$Resources:Resource,Close_Window%>" Width="110px"
                        OnClientClick="javascript:return closeWindow();" />
         </div>
        </div>
        
        </asp:panel>

        <asp:HiddenField ID="hdnfacility" runat="server" />
    </div>
    <telerik:RadAjaxManager ID="my_pa" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_component" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rg_component">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_component" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
