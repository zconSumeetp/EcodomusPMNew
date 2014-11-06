<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App/EcoDomusMasterBlank.master"
    CodeFile="ExistingFacilities.aspx.cs" Inherits="App_Locations_ExistingFacilities" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" language="javascript">
        function GetRowSelected(args) {

            var s1 = $find("<%=rgExistingFacility.ClientID %>");
            var MasterTable = s1.get_masterTableView();
            var selectedRows = MasterTable.get_selectedItems();
            var s = "";
            for (var i = 0; i < selectedRows.length; i++) {
                s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("pk_facility_id") + ",";
            }

            if (s == "" || s == ",") {
                document.getElementById("ContentPlaceHolder1_hf_Facility_ids").value = "";
                return false;
            }
            else {

                document.getElementById("ContentPlaceHolder1_hf_Facility_ids").value = s;

            }

        }

        function fn_Clear() {
            try {
                document.getElementById("ContentPlaceHolder1_txt_search").value = "";
                return false;
            }
            catch (e) {
                alert(e.message + "  " + e.Number);
                return false;
            }
        }
        function validate() {

            alert('please select Facility');
            return false;

        }
        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }
        function body_load() {

            var screenhtg = set_NiceScrollToPanel();
            if (document.getElementById("<%=txt_search.ClientID %>") != null)
                document.getElementById("<%=txt_search.ClientID %>").focus();
        }
        function NevigateToFacilityPM() {
         
            window.parent.document.location.href = "FacilityPM.aspx";
            window.close();
        }
       // window.onload = body_load; 
    </script>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:radformdecorator id="rdfTaskEquipment" runat="server" skin="Default" decoratedcontrols="Buttons,RadioButtons,Scrollbars" />
   
        <table style="font-family: Arial, Helvetica, sans-serif;float: left;
            padding-top: 0px;width: 100%; vertical-align: top">            
            <tr>
                <td>
                    <telerik:radpanelbar runat="server" id="RadPanelBar1" width="100%" borderwidth="0"
                        expandmode="MultipleExpandedItems" bordercolor="Transparent">
                        <ExpandAnimation Type="OutSine" />
                        <Items>
                            <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                                BorderWidth="0" BorderColor="Transparent">
                                <HeaderTemplate>
                                    <asp:Panel ID="pnl_job" runat="server" BorderWidth="0" DefaultButton="btn_Search"
                                        Width="100%" BorderColor="Transparent">
                                        <table id="tbl_jobs" cellpadding="0" cellspacing="0" class="gridRadPnlHeader" runat="server"
                                            width="100%">
                                            <tr>
                                                <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                    <asp:Label runat="server" Text="<%$Resources:Resource,Assign_Existing_Facilities%>" ID="lbl_grid_head"
                                                        CssClass="gridHeadText" Width="204px">
                                                        </asp:Label>
                                                </td>                                              
                                                <td align="Right" onclick="stopPropagation(event)">
                                                    <div id="div_search"  style="background-color: White;
                                                        width: 160px;">
                                                         <asp:Panel ID="panelSearch" DefaultButton="btn_Search" runat="server">  
                                                        <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                            width: 100%;">
                                                            <tr style="border-spacing:0px;">
                                                                <td align="left" width="60%" rowspan="0px" style="background-color: White; height: 14px;
                                                                    padding-bottom: 0px;">
                                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txt_search" Width="90%">
                                                                    </telerik:RadTextBox>
                                                                </td>
                                                                <td align="left" rowspan="0px" width="13%" style="background-color: White; height: 14px;
                                                                    padding-bottom: 0px;">                                                                    
                                                                    <asp:ImageButton ClientIDMode="Static" ID="btn_Search" Height="13px" runat="server"
                                                                        ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btn_search_click" />                                                                       
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        </asp:Panel>
                                                    </div>
                                                </td>
                                                <td style="padding-right:10px;">
                                                   <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
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
                    <telerik:RadGrid ID="rgExistingFacility" runat="server" EnableViewState="true" AllowPaging="True"
                        AllowSorting="True" AutoGenerateColumns="False" BorderWidth="1px" CellPadding="0"
                         PagerStyle-AlwaysVisible="true" AllowMultiRowSelection="true" PageSize="10"
                        EnableEmbeddedSkins="true" OnPageIndexChanged="rgExistingFacility_OnPageIndexChanged"
                        OnSortCommand="rgExistingFacility_OnSortCommand" Skin="Default" GridLines="None"
                        ItemStyle-Wrap="false" 
                        onpagesizechanged="rgExistingFacility_PageSizeChanged">
                        <PagerStyle HorizontalAlign="Right" Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                            <Scrolling  AllowScroll="true" UseStaticHeaders="true" ScrollHeight="280" />
                            <ClientEvents OnRowSelected="GetRowSelected" OnRowDeselected="GetRowSelected" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="pk_facility_id,name" ClientDataKeyNames="pk_facility_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_facility_id" Visible="false">
                                    <ItemStyle CssClass="column" Width="10%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridClientSelectColumn>
                                    <ItemStyle Width="20px" />
                                    <HeaderStyle Width="20px" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Facility_Name%>"
                                    UniqueName="name">
                                    <ItemStyle Width="400px"  CssClass="column" Wrap="false" HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left"  Width="400px" Wrap="false" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                     </ContentTemplate>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:radpanelbar>
                </td>
            </tr>
            <tr>
                <td style="height: 50px">
                    <asp:Button ID="btnShowAdd" runat="server" Text="<%$Resources:Resource,Assign_Facility%>"
                        Width="100px" CausesValidation="false" OnClick="btnShowAdd_Click" />&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td style="display: none;">
                    <asp:HiddenField ID="hf_Facility_ids" runat="server" />
                </td>
            </tr>
        </table>
  
    <telerik:radwindowmanager id="rd_manager" runat="server" skin="Default" showontopwhenmaximized="false"
        keepinscreenbounds="true">
        <Windows>
            <telerik:RadWindow ID="rd_window_add_facility" runat="server" Title="EcoDomus PM :Add Facility"
                ReloadOnShow="false" VisibleTitlebar="false" AutoSize="false" Width="630px" Height="400px"
                OffsetElementID="btn_search" VisibleStatusbar="false" VisibleOnPageLoad="false"
                Skin="Default" Behaviors="Move,Resize,Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:radwindowmanager>
    <telerik:radajaxmanagerproxy id="RadAjaxManagerFacility" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btn_Search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgExistingFacility" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="rgExistingFacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgExistingFacility" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnShowAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgExistingFacility" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:radajaxmanagerproxy>
    <telerik:radajaxloadingpanel id="loadingPanel1" runat="server" height="75px" width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:radajaxloadingpanel>
</asp:Content>
