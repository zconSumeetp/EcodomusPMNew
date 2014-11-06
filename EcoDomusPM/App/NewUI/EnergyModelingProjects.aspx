<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomus_PM_New.master"  AutoEventWireup="true" 
CodeFile="EnergyModelingProjects.aspx.cs" Inherits="App_NewUI_EnergyModelingProjects" %>

<%@ Register Src="~/App/NewUI/User Controls/EnergyModelingProjects.ascx" TagName="EnenrgyModelingProjects" TagPrefix="EMP" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <script type="text/javascript">

     function referesh_project_page() {
         top.location.reload();
     }

     var panelBar;
     var panelBarProductsTab;
     var multiPage;

     function stopPropagation(e) {
         e.cancelBubble = true;
         if (e.stopPropagation)
             e.stopPropagation();
     }
     function openAddProjectPopup(action) {
         
         manager = $find("<%=rd_manager.ClientID%>");
         var hdn_field = document.getElementById('<%=hf_pk_project_id.ClientID %>');
         if (hdn_field.value == ''&& action=='U') {
             alert("Reselect Row");
         }
         else {
             var url = "EnergyModelingAddProject.aspx?pk_project_id=" + hdn_field.value + "&action=" + action;
             if (manager != null) {
                 var windows = manager.get_windows();
                 if (windows[0] != null) {//line changed for pop ups issue with new master page
                     windows[0].setUrl(url);
                     windows[0].show();
                     windows[0].set_modal(false);
                 }
             }
         }
         return false;
     }

     function set_project_id(id) {
         var hdn_field = document.getElementById('<%=hf_pk_project_id.ClientID %>');
         hdn_field.value = id;
        
     }
     function RowSelected(sender, eventArgs) {
         var grid = sender;
         var MasterTable = grid.get_masterTableView(); var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
         var url = "EnergyModelingEquipment.aspx";
         top.location.href(url);

     }
     function NiceScrollOnload() {
         if (screen.height > 721) {
             $("html").css('overflow-y', 'hidden');
             $("html").css('overflow-x', 'auto');
         }
         var screenhtg = set_NiceScrollToPanel();
     }
    </script>
    <style type="text/css">
        div
        {
            overflow-x: hidden;
        }
    </style>
    <%--<link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />--%>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" DecoratedControls="RadioButtons,Scrollbars,Buttons" />
     <asp:Panel ID="pnlSearch" DefaultButton="" BorderColor="Transparent" BorderWidth="0" runat="server">

     <table id="tbl_containing" runat="server" border="0" width="95%" class="tablecolor"
        cellpadding="0" cellspacing="0">
        <tr id="tr_radtab">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <telerik:RadTabStrip ID="radtabstrip_projects" runat="server" MultiPageID="RadMultiPageProjects"
                                SelectedIndex="0" >
                                <Tabs>
                               <telerik:RadTab Text="Projects" Font-Size="11" Font-Names="Arial" runat="server" PageViewID="radPageView_projects" Selected="true">
                                   </telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                        <td align="right">
                            <asp:ImageButton ID="ibtn_Edit" runat="server"  ImageUrl="~/App/Images/Icons/icon_edit_sm.png" OnClientClick="javascript:return openAddProjectPopup('U');"  
                             Width="15" Height="15" ImageAlign="Bottom"/>
                       
                        </td>
                        <td width="4%" align="right" style="padding-right:5px;vertical-align:middle;">
                         <asp:LinkButton ID="lbtn_edit" ForeColor="#585858" Font-Bold="true" Font-Names="Arial" runat="server" Text="EDIT"  CssClass="lnkButton" OnClientClick="javascript:return openAddProjectPopup('U');"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width="100%">
                <telerik:RadMultiPage ID="RadMultiPageProjects" runat="server" SelectedIndex="0">
                    <telerik:RadPageView runat="server" ID="radPageView_projects" Selected="true">
                       <EMP:EnenrgyModelingProjects ID="emp_EnenrgyModelingProjects" runat="server" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>

        </tr>
         <tr>

    <td align="right" width="100%">
    <table width="20.7%" border="0" cellpadding="0" cellspacing="0" >
    <tr>
    <td align="right">
    <asp:ImageButton ID="ibtnNewProject"  runat="server" OnClientClick="javascript:return openAddProjectPopup('I');"  ImageUrl="~/App/Images/Icons/NewProject.png" />
    </td>
    </tr>
    </table>
    </td>
    
    </tr>
    </table>
    <telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Red" Skin="">
        <Windows>
           
             <telerik:RadWindow ID="rd_add_project" runat="server" ReloadOnShow="false" Height="200"
                Width="350" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search" 
                VisibleStatusbar="false" VisibleOnPageLoad="false"  BorderColor="Black"
                EnableAjaxSkinRendering="false" BorderStyle="None" BackColor="Red" VisibleTitlebar="false"
                Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    </asp:Panel>
    <asp:HiddenField ID="hf_pk_project_id" runat="server" Value="" />
</asp:Content>


