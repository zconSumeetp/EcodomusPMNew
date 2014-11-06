<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomusPM_Master.master"  AutoEventWireup="true" CodeFile="EnergyModelingFacilityUtilityData.aspx.cs" Inherits="App_NewUI_FacilityBillinsStatements" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/App/NewUI/User Controls/AddUtilityData.ascx" TagName="FacilityBillimgStatement" TagPrefix="FBS" %>
<%@ Register Src="~/App/NewUI/User Controls/UtilityRateSchedules.ascx" TagName="UtilityRateschedules" TagPrefix="URS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">

        var panelBar;
        var panelBarProductsTab;
        var multiPage;

        function referesh_project_page() {
            top.location.reload();
        }

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }

        function set_utility_data_id(id) {
            var hdn_field = document.getElementById('<%=hf_pk_facility_utility_data_id.ClientID %>');
            hdn_field.value = id;

        }

        function OpenUtilityDataPopupU() {
       
            manager = $find("<%=rd_manager_U.ClientID%>");
            var hdn_field = document.getElementById('<%=hf_pk_facility_utility_data_id.ClientID %>');
            if (hdn_field.value == '')
            {
                alert("Reselect Row");
            }
            else {
                var url = "EnergyModelingAddUtilityData.aspx?pk_facility_utility_data_id=" + hdn_field.value;
                if (manager != null) {
                    var windows = manager.get_windows();
                    if (window[0] != null) {
                        windows[0].setUrl(url);
                        windows[0].show();
                        windows[0].set_modal(false);
                    }
                }
            }
            return false;
        }

    </script>
    <style type="text/css">
        div
        {
            overflow-x: hidden;
        }
      
      
    </style>
    <link href="../../App_Themes/EcoDomus/Skins/MyCustomTabStrip/TabStrip.MyCustomTabStrip.css"
        rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" DecoratedControls="RadioButtons,Scrollbars,Buttons" />
    <table id="tbl_containing" runat="server" border="0" width="95%" class="tablecolor"
        cellpadding="0" cellspacing="0">
        <tr id="tr_radtab">
            <td width="100%">
                <table width="95%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <telerik:RadTabStrip ID="radtabstrip_Statements" runat="server" MultiPageID="RadMultiPageStatements"
                                SelectedIndex="1" EnableEmbeddedSkins="False" Skin="MyCustomTabStrip">
                                <Tabs>
                                    <telerik:RadTab Text="Statements" Font-Bold="true" runat="server" PageViewID="radPageView_statements"
                                        BorderColor="Gray">
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Rate Schedules" Font-Bold="true" runat="server" 
                                        PageViewID="radPageView_schedules" Selected="True">
                                    </telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                         <td align="right">
                                            <asp:ImageButton ID="ibtn_Edit" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                                Width="15" Height="15" ImageAlign="Bottom" />
                                        </td>
                                        <td width="4%" align="right" style="padding-right:5px;vertical-align:middle;">
                                            <asp:LinkButton ID="lbtn_edit" ForeColor="#585858" Font-Bold="true" Font-Names="Arial"
                                                runat="server" Text="EDIT" CssClass="lnkButton" OnClientClick="javascript:return OpenUtilityDataPopupU();"></asp:LinkButton>
                                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width="100%">
                <telerik:RadMultiPage ID="RadMultiPageStatements" runat="server" 
                    SelectedIndex="1">
                    <telerik:RadPageView runat="server" ID="radPageView_statements" Selected="true">
                        <FBS:FacilityBillimgStatement ID="FBS" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView runat="server" ID="radPageView_schedules">
                        <URS:UtilityRateschedules ID="URS" runat="server" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
    </table>
      <telerik:RadWindowManager ID="rd_manager_U" runat="server" BorderColor="Red" Skin="">
        <Windows>
             <telerik:RadWindow ID="rd_add_project" runat="server" ReloadOnShow="false" Height="375"
                Width="350" DestroyOnClose="true" AutoSize="false" OffsetElementID="btn_search" 
                VisibleStatusbar="false" VisibleOnPageLoad="false"  BorderColor="Black"
                EnableAjaxSkinRendering="false" BorderStyle="None" BackColor="Red" VisibleTitlebar="false"
                Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>     
     <asp:HiddenField ID="hf_pk_facility_utility_data_id" runat="server" Value="" />
     </asp:Content>

