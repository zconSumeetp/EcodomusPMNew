<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomusPM_Master.master"  AutoEventWireup="true"
    CodeFile="EnergyModelingWizard.aspx.cs" Inherits="App_NewUI_EnergyModelingWizard" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">

            function openEnergyModelingWizard() {
                manager = $find("<%=rd_manager.ClientID%>");
                var url;
                var url = "EnergyModelingWizardWindow.aspx";
                if (manager != null) {
                    var windows = manager.get_windows();
                    if (window[0] != null) {
                        windows[0].setUrl(url);
                       
                       windows[0].show();
                      windows[0].set_modal(false);

                        //var oWnd = window[0].radopen('EnergyModelingWizardWindow.aspx', 'window1'); //Opens the window  
                      //windows[0].add_close(OnClientClose); //set a function to be called when RadWindow is closed  
                    }
                }
                return false;
            }


            function openAddProjectPopup() {
                manager = $find("<%=rd_manager.ClientID%>");
                var url;
                var url = "EnergyModelingAddProject.aspx";
                if (manager != null) {
                    var windows = manager.get_windows();
                    if (window[1] != null) {
                        windows[1].setUrl(url);

                        windows[1].show();
                        windows[1].set_modal(false);

                        //var oWnd = window[0].radopen('EnergyModelingWizardWindow.aspx', 'window1'); //Opens the window  
                        //windows[0].add_close(OnClientClose); //set a function to be called when RadWindow is closed  
                    }
                }
                return false;
            
            }

            function OnClientClose(oWnd) {
                alert('hi');
                oWnd.setUrl(""); // Sets url to blank 
                oWnd.remove_close(OnClientClose); //remove the close handler - it will be set again on the next opening 
            }

           
           
           
        </script>
    </telerik:RadCodeBlock>
  <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <asp:Button ID="btn_show" Text="Show Wizards" runat="server" OnClientClick="javascript:return openEnergyModelingWizard();" />
    <asp:Button ID="btn_add_project" Text="Add Project" runat="server" OnClientClick="javascript:return openAddProjectPopup();" />
    <telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Red" Skin="">
        <Windows>
            <telerik:RadWindow ID="rd_window_modeling_wizard" runat="server" ReloadOnShow="false"
                Width="900" DestroyOnClose="true" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" Behaviors="Resize,Move" BorderColor="Black"
                EnableAjaxSkinRendering="false" BorderStyle="None" BackColor="Red" VisibleTitlebar="false"
                Overlay="true">
            </telerik:RadWindow>
             <telerik:RadWindow ID="rd_add_project" runat="server" ReloadOnShow="false" Height="450"
                Width="330" DestroyOnClose="true" AutoSize="false" OffsetElementID="btn_search" 
                VisibleStatusbar="false" VisibleOnPageLoad="false" Behaviors="Resize,Move" BorderColor="Black"
                EnableAjaxSkinRendering="false" BorderStyle="None" BackColor="Red" VisibleTitlebar="false"
                Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
