<%@ Page Title=""   MasterPageFile="~/App/EcoDomus_PM_New.master"   Language="C#" AutoEventWireup="true"
    CodeFile="FacilityDetailPM.aspx.cs" Inherits="App_NewUI_FacilityDetailPM" %>

<%@ Register Src="~/App/NewUI/User Controls/EnergyModelingFacilities.ascx" TagName="EnergyModelingFacilities"
    TagPrefix="EMF" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        var panelBar;
        var panelBarProductsTab;
        var multiPage;

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }

        function referesh_facility_page() {
            
            top.location.reload();
        }

        function NiceScrollOnload() {
            if (screen.height > 721) {
                $("html").css('overflow-y', 'hidden');
                $("html").css('overflow-x', 'auto');
            }
            var screenhtg = set_NiceScrollToPanel();
        }

        function openEnergyModelingWizard() {
            manager = $find("<%=rd_manager.ClientID%>");
            var url;
            var url = "EnergyModelingWizardWindow.aspx";
            if (manager != null) {
                var windows = manager.get_windows();
                if (windows[0] != null) {
                    windows[0].setUrl(url);

                    windows[0].show();
                    windows[0].set_modal(false);

                }
            }
            return false;
        }
        
    </script>
    <style>
        div
        {
            overflow-x: hidden;
        }
        
        #tbl_containing
        {
            position: relative;
        }
        #parent
        {
            width: 100px;
            height: 100px;
        }
        #child
        {
            position: absolute;
            top: 10px;
            left: 10px;
            width: 50%;
            height: 50%;
        }
        
         html, body, form
        {
            margin: 0;
            padding: 0;
          
        }
    </style>
   <%-- <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
   --%>  
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <asp:Panel ID="pnlSearch" DefaultButton="" BorderColor="Transparent" BorderWidth="0" runat="server">
    <table id="tbl_containing" border="0" width="100%" class="tablecolor">
        <tr id="tr_radtab">
            <td style="">
                <table width="95%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td  >
                            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" ClientIDMode="Static"  
                                MultiPageID="RadMultiPage1" SelectedIndex="0">
                                <Tabs>
                                    <telerik:RadTab Text="Facilities" Font-Size="11" Font-Names="Arial" runat="server" PageViewID="RadPageView1" Selected="true">
                                    </telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                        <td align="right">
                            <asp:ImageButton ID="ibtn_Edit" runat="server"  ImageUrl="~/App/Images/Icons/icon_edit_sm.png"  OnClick="OnclickibtnEdit"
                             Width="15" Height="15" ImageAlign="Bottom"/>
                       
                        </td>
                        <td width="4%" align="right" style="padding-right:5px;vertical-align:middle;">
                         <asp:LinkButton ID="lbtn_edit" ForeColor="#585858" Font-Bold="true" Font-Names="Arial" runat="server" Text="EDIT" OnClientClick="javascript:return openEnergyModelingWizard();"  CssClass="lnkButton"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0">
                    <telerik:RadPageView ID="RadPageView1" runat="server" Selected="true">
                        <EMF:EnergyModelingFacilities ID="EMF_EnergyModelingFacilities" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="radpage_edit" runat="server">
                        <div id="div1" style="width: 30px; color: Black;">
                        </div>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
        
    </table>
   </asp:Panel>
     <telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Red" Skin="">
        <Windows>
            <telerik:RadWindow ID="rd_window_modeling_wizard" runat="server" ReloadOnShow="false"
                Width="900" DestroyOnClose="true" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" Behaviors="Resize,Move" BorderColor="Black"
                EnableAjaxSkinRendering="false" BorderStyle="None" BackColor="Red" VisibleTitlebar="false"
                Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
