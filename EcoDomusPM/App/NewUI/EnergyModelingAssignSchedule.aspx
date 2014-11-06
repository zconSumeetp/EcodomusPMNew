<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeFile="EnergyModelingAssignSchedule.aspx.cs" Inherits="App_NewUI_EnergyModelingAssignSchedule" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CloseWindow() {
           
            GetRadWindow().close();
            //top.location.reload();
            top.location.href = top.location.href; 
            //GetRadWindow().BrowserWindow.adjust_parent_height();
            
            return false;
        }
        function adjust_height() {
            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                //alert(x);
                //alert(y);
                wnd.moveTo(x, 110);
                //alert('window page' + document.body.scrollHeight);
                wnd.set_height(document.body.scrollHeight+20)
                // alert('window page' + document.body.offsetWidth);
                //wnd.set_width(document.body.scrollWidth+200)
            }
        }

        function checkSelectedValue(button, args) {
            var grid = $find("<%=rg_schedule.ClientID %>");
            var MasterTable = grid.get_masterTableView();
            var selectedRows = MasterTable.get_selectedItems();
            for (var i = 0; i < selectedRows.length; i++) {
                var row = selectedRows[i];
                var cell = selectedRows[i].getDataKeyValue("pk_energymodel_schedule_id")
                //alert(cell);
            }
            if (selectedRows.length > 0) {
                //alert(selectedRows.length);
                button.set_autoPostBack(true);
            }
            else {
                button.set_autoPostBack(false);
            }

           
        }
        </script>
        </telerik:RadCodeBlock>
     <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
     
</head>
<body>
    <form id="frm_assing_schedules" runat="server">
     <asp:ScriptManager ID="ScriptManagerId" runat="server">
    </asp:ScriptManager>
     <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" 
        DecoratedControls="RadioButtons, Buttons, Scrollbars" />
    <table border="0" width="100%" cellspacing="0" style="border-collapse: collapse">
        <tr>
            <td class="wizardHeadImage">
                <div class="wizardLeftImage">
                    <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />
                    <asp:Label ID="lbl_header" Text="Assign Schedule" runat="server"></asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                        OnClick="ibtn_close_Click" />
                </div>
            </td>
        </tr>
        <tr>
            <td style="height: 20px">
            </td>
        </tr>
        <tr>
            <td align="center" style="padding-bottom:10px">
                <table border="1" cellpadding="0" cellspacing="0" width="98%" style="border-collapse: collapse;
                    border-style: solid; border-color: #828282">
                    <tr>
                        <td>
                            <telerik:RadGrid ID="rg_schedule" runat="server" AllowPaging="true" PageSize="10"
                                GridLines="None" BorderColor="White" BorderWidth="2" AllowMultiRowSelection="true"
                                PagerStyle-AlwaysVisible="true" AutoGenerateColumns="false" Width="100%" OnPageIndexChanged="rg_schedule_PageIndexChanged"
                                OnPageSizeChanged="rg_schedule_PageSizeChanged">
                                <ClientSettings EnableRowHoverStyle="true">
                                    <Selecting AllowRowSelect="true" />
                                    
                                </ClientSettings>
                                <MasterTableView DataKeyNames="pk_energymodel_schedule_id,pk_simulation_schedule_limit_id"
                                    HeaderStyle-CssClass="gridHeaderText" ClientDataKeyNames="pk_energymodel_schedule_id,pk_simulation_schedule_limit_id">
                                    <PagerStyle HorizontalAlign="Right" Mode="NextPrevNumericAndAdvanced" AlwaysVisible="true"
                                        PageSizeLabelText="Show Rows" />
                                    <AlternatingItemStyle BackColor="#F8F8F8" />
                                    <Columns>
                                        <telerik:GridClientSelectColumn HeaderStyle-Width="20px" HeaderStyle-VerticalAlign="Top"
                                            UniqueName="ClientSelectColumn" CommandName="expandcolumn">
                                        </telerik:GridClientSelectColumn>
                                        <telerik:GridBoundColumn DataField="pk_energymodel_schedule_id" Visible="false" UniqueName="pk_energymodel_schedule_id">
                                            <ItemStyle CssClass="column" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="schedule_name" HeaderText="Schedule Name" UniqueName="schedule_name">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="schedule_type" HeaderText="Schedule Type" UniqueName="schedule_type">
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                   
                </table>
            </td>
        </tr>
        <tr>
        <td style="padding-left:10;">
        <asp:Label ID="lbl_msg" runat="server" Text="" ForeColor="Red"></asp:Label>
        </td>
        </tr>
        <tr>
            <td style="padding-left:10;padding-bottom:10">
                <telerik:RadButton ID="btn_assign_schedule" runat="server" Text="Assign" AutoPostBack="false"
                     onclick="btn_assign_schedule_Click" OnClientClicked="checkSelectedValue" />
            </td>
        </tr>

        <tr>
        <td style="height:1px;background-color:Orange"></td>
        </tr>
        <tr>
        <td style="height:10px"></td>
        </tr>
    </table>
    </form>
</body>
