<%@ Page Language="C#" AutoEventWireup="true" CodeFile="selectfacilitypopupmodel.aspx.cs" Inherits="App_Asset_selectfacilitypopupmodel" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>EcoDomus PM</title>

     <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
        <script language="javascript" type="text/javascript">
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
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
            function closeWindow() {

                var rdw = GetRadWindow();
                rdw.close();
                //self.close();
            }


            function clear_txt() {
                document.getElementById("txtSearch").value = "";
                return false;
            }
            function select_Sub_System(id, name) {

                var rdw = GetRadWindow();
                rdw.BrowserWindow.load_manufacturer(name, id);
                rdw.close();

            }
            function assignfacility() {
                alert("Please Select Facility");
            }


            function selectfacilityForType(Id, Name) {


                Name = Name.replace(/#/g, "'");

                window.parent.set_popup_values(Id, Name);
                window.parent.buttoncallback_Type();
                closeWindow();

            }

            function CloseWindow1() {               
                GetRadWindow().close();               
                return false;
            }
            function CancelWindow() {
                CloseWindow1();
            }
    
        </script>
    </telerik:RadCodeBlock>

</head>

   <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
        <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />

<body  style="background: #7f7f7;">
    <form id="form1" runat="server">
   
    
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <asp:Panel ID="panelSearch" runat="server">

    <table id="man_serch" width="100%">
    <tr>
            <td class="wizardHeadImage">
                <div class="wizardLeftImage">
                   <%-- <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />--%>
                    <asp:Label ID="Label1" Text="Select Facility" style="font-size :medium ;" runat="server"></asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                         OnClientClick="javascript:return CancelWindow();" />
                </div>
            </td>
        </tr>        
    </table>

    
     <table id="Table1" width="100%" >
     <tr>
     <td width="100%">
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
                                            <%--<td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                    <asp:Label runat="server" Text="<%$Resources:Resource,Projects%>" ID="lbl_grid_head"
                                                        CssClass="gridHeadText" Width="100px"
                                                        ></asp:Label>
                                                </td>   --%>
                                            <td align="Right" onclick="stopPropagation(event)">
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
        <telerik:RadGrid ID="RgFacility" runat="server" AllowPaging="True" AutoGenerateColumns="false" ItemStyle-Wrap="false"
            AllowSorting="True" PagerStyle-AlwaysVisible="true" Width="100%" PageSize="10" OnSortCommand="RgFacility_sortcommand"
            GridLines="None" Skin="Default" OnPageIndexChanged="RgFacility_pageindexchanged" OnPageSizeChanged="RgFacility_OnPageSizeChanged">
            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
            <ClientSettings>
                <Selecting AllowRowSelect="true"  />
            </ClientSettings>
            <MasterTableView ClientDataKeyNames="pk_facility_id" DataKeyNames="pk_facility_id">
                <Columns>
                    <telerik:GridBoundColumn DataField="pk_facility_id" Visible="false">
                        <ItemStyle CssClass="column" />
                    </telerik:GridBoundColumn>

                    <telerik:GridClientSelectColumn >
                        <ItemStyle Width="10px" />
                        <HeaderStyle Width="10px" />

                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Facility_Name%>" SortExpression="Name">
                        <ItemStyle CssClass="column" Wrap="false" />
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
    </asp:Panel>
      <table id="Table2" width="80%" style="vertical-align: top; margin-left: 20px;"
         border="0">
       
        <tr>
            <td>
                <asp:Button ID="btnAssign" runat="server" Text="<%$Resources:Resource,Assign%>" Width="100px" TabIndex="4"
                    ValidationGroup="my_validation" onclick="btnAssign_Click"/>&nbsp;&nbsp;
                <asp:Button ID="btnClose" runat="server" Text="<%$Resources:Resource,Close%>" Width="100px"  OnClientClick="javascript:closeWindow();" TabIndex="5"
                    ValidationGroup="my_validation" />&nbsp;&nbsp;                  
            </td>
        </tr>
        </table>
        <telerik:RadAjaxManager ID="ramSystem" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgFacility" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
   
    </form>
</body>
</html>
