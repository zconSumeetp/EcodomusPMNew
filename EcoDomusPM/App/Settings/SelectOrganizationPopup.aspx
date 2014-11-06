<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectOrganizationPopup.aspx.cs"
    Inherits="App_Settings_SelectOrganizationPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head runat="server">
    <title>Select Organization</title>
      <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript" language="javascript">
        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }
      
            
            function Clear() {
                document.getElementById("txtSearch").value = "";
                return false;
            }
            
            function Update_UserProfile(id, name)
            {
                window.parent.document.getElementById("hfOrganizationId").value=id;
                window.parent.document.getElementById("hfOrganizationName").value=name;
                window.parent.document.getElementById("btnSetOrganization").click();
               Close();
            }

            function closewindow() {
                window.Close();
                window.parent.resizePopup('popResizeBack');
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

        function Close() {
            GetRadWindow().Close();
            window.parent.resizePopup('popResizeBack');
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
            window.parent.resizePopup('popResizeBack');
        }
    </script>   
       </telerik:RadCodeBlock>
    
 
    <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
       
        <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin: 0px 0px 0px 0px; padding-top: 0;background:White; overflow:hidden;background-color:#EEEEEE" >
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <table  width="100%" cellpadding="0" cellspacing="0" >
    
    <tr >
        <td align="center" style="width:100%;padding:10px;">
            <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" BorderWidth="0"
                ExpandMode="MultipleExpandedItems" BorderColor="Transparent">
                <ExpandAnimation Type="OutSine" />
                <Items>
                    <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                        BorderWidth="0" BorderColor="Transparent">
                        <HeaderTemplate>
                            <asp:Panel ID="pnl_job" runat="server" BorderWidth="0" DefaultButton="btnSearch"
                                Width="100%" BorderColor="Transparent">
                                <table id="tbl_jobs" cellpadding="0" cellspacing="0" class="gridRadPnlHeader" runat="server"
                                    width="100%">
                                    <tr>
                                        <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                            <asp:Label runat="server" Text="<%$Resources:Resource,Products%>" ID="lbl_grid_head"
                                                CssClass="gridHeadText" Width="100px" ForeColor="#F8F8F8" Font-Names="Arial"
                                                Font-Size="12" Visible="false"></asp:Label>
                                        </td>
                                        <td align="right" onclick="stopPropagation(event)">
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
                                        <td align="left"  style="padding:03px;">
                                            <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                ID="img_arrow" />--%>
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
                            <telerik:RadGrid ID="rgOrganization" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                                AllowSorting="true" OnSortCommand="rgOrganization_SortCommand" OnPageIndexChanged="rgOrganization_PageIndexChanged"
                                OnPageSizeChanged="rgOrganization_PageSizeChanged" Skin="Default" PagerStyle-AlwaysVisible="true"
                                OnItemCommand="rgOrganization_ItemCommand">
                                <PagerStyle Mode="NextPrevAndNumeric" />
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="true" ScrollHeight="364" />
                                </ClientSettings>
                                <MasterTableView DataKeyNames="ID">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="ID" Visible="false">
                                            <ItemStyle CssClass="column" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridClientSelectColumn>
                                            <ItemStyle Width="10px" />
                                            <HeaderStyle Width="10px" />
                                        </telerik:GridClientSelectColumn>
                                        <telerik:GridBoundColumn DataField="name" HeaderText="Organization">
                                            <ItemStyle CssClass="column" />
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
        <tr style="height:10px;">
            <td>
            </td>
        </tr>
        <tr >
            <td align="left" style="padding-left:10px;">
                <asp:Button ID="btnSelectOrganization" runat="server" Text="Select Organization"
                    Width="120px" OnClick="btnSelectOrganization_Click" />

                <asp:Button ID="btnclose" runat="server" Text="Close"
                    Width="90px" OnClientClick="javascript:return closewindow();" />
                    
            </td>
        </tr>
    </table>
    </form>
</body>
 
</html>