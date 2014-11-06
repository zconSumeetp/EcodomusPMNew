<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App/EcoDomusPM_Master.master"
    CodeFile="EnergyZones.aspx.cs" Inherits="App_test_EnergyZones" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .tblBorder
        {
            border: 1px;
            height: auto;
            border-collapse: collapse;
        }
        .lnkBtnBgImg
        {
            background-image: url('/App/Images/asset_button_sm_gray.png');
            background-repeat: no-repeat;
            height: 25px;
            width: 60px;
            vertical-align: middle;
        }
       
            div
        {
            overflow-x: hidden;
        }
       
.SelectedStyle 
     { 
      background-color: red !important; 
      
     } 

        
    </style>
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="RadioButtons,Scrollbars,Buttons" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">

            function RowSelected(sender, eventArgs) {

                var grid = sender;
                var MasterTable = grid.get_masterTableView(); var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
                var url = "EnergyModelingEquipment.aspx";
                top.location.href(url);

            }

            function pagesize(sender, GridCommandEventArgs) {

                sender.set_value(10);
                // var e = GridCommandEventArgs.get_domEvent();
            }
            function pagesize_changed(sender, GridCommandEventArgs) {

                // var e = GridCommandEventArgs.get_domEvent();
            }
            function onrowselected(sender, eventArgs) {

                var e = eventArgs.get_domEvent();
                var MasterTable = sender.get_masterTableView();
                var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
                document.getElementById("<%=hdn_row_index.ClientID %>").value = eventArgs.get_itemIndexHierarchical();
                document.getElementById("<%=hdn_row_deselected_index.ClientID %>").value = eventArgs.get_itemIndexHierarchical();
                var Name = MasterTable.getCellByColumnUniqueName(row, "action");
                document.getElementById(Name.children[0].id).style.display = "inline";
                document.getElementById("<%=hdn_row_deselected.ClientID%>").value = "row_selected";


            }

            function onRowSelecting(sender, eventArgs) {

                var pk_space = eventArgs.getDataKeyValue("space_id");
                var pk_zone_id = eventArgs.getDataKeyValue("pk_location_id");
                var space = document.getElementById("<%=hf_space_ids.ClientID%>").value;
                var zone = document.getElementById("<%=hf_zone_ids.ClientID%>").value;

                if (space != "") {
                    if (space.indexOf(pk_space) == -1)
                        document.getElementById("<%=hf_space_ids.ClientID%>").value = document.getElementById("<%=hf_space_ids.ClientID%>").value + ',' + pk_space;

                }
                else {
                    document.getElementById("<%=hf_space_ids.ClientID%>").value = pk_space;
                }


                if (zone != "") {
                    if (zone.indexOf(pk_zone_id) == -1) {
                        document.getElementById("<%=hf_zone_ids.ClientID%>").value = document.getElementById("<%=hf_zone_ids.ClientID%>").value + ',' + pk_zone_id;
                    }
                }

                else
                    document.getElementById("<%=hf_zone_ids.ClientID%>").value = pk_zone_id;
            }

            function OnRowDeselecting(sender, eventArgs) {

                var pk_space = eventArgs.getDataKeyValue("space_id");
                var pk_zone_id = eventArgs.getDataKeyValue("pk_location_id");
                var space = document.getElementById("<%=hf_space_ids.ClientID%>").value;
                var zone = document.getElementById("<%=hf_zone_ids.ClientID%>").value;

                if (space != "") {
                    if (space.indexOf(pk_space) != -1)
                        document.getElementById("<%=hf_space_ids.ClientID%>").value = space.replace(pk_space, "00000000-0000-0000-0000-000000000000");

                }



            }


            function onrowsdeselected(sender, eventArgs) {
            
                var e = eventArgs.get_domEvent();
                var pk_space = eventArgs.getDataKeyValue("space_id");

                var MasterTable = sender.get_masterTableView();
                var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
                var Name = MasterTable.getCellByColumnUniqueName(row, "action");
                document.getElementById("<%=hdn_row_index.ClientID %>").value = "";
                document.getElementById("<%=hdn_row_deselected_index.ClientID %>").value = eventArgs.get_itemIndexHierarchical();
                document.getElementById(Name.children[0].id).style.display = "none";
                document.getElementById("<%=hdn_row_deselected.ClientID%>").value = "row_deselected";
//                if (document.getElementById(Name.children[0].id).getElementsByTagName("input")[0].src.indexOf("down-arrow.png") == -1) {
//                    document.getElementById(Name.children[0].id).getElementsByTagName("input")[0].click();
//                }
                if (document.getElementById("<%=hfExpand.ClientID%>").value == "expanded")
                    document.getElementById(Name.children[0].id).getElementsByTagName("input")[0].click();


            }


            function gotoPageAssignSchedule(pk_entity_id, page_name, entity_name) {
                //var url = "EnergyModelingSchedule.aspx?asset_id=" + pk_asset_id;
                //top.location.href(url);
                openAssignSchedulePopup(pk_entity_id, entity_name);
            }

            function gotoPageSchedule(pk_schedule_ids, page_name, entity_name) {
                url = "EnergyModelingSchedule.aspx?pk_schedule_ids=" + pk_schedule_ids;
                top.location.href(url);
            }

            function openAssignSchedulePopup(pk_entity_id, entity_name) {
                manager = $find("<%=rd_manager.ClientID%>");
                var url;
                var url = "EnergyModelingAssignSchedule.aspx?pk_entity_id=" + pk_entity_id + "&entity_name=" + entity_name;
                if (manager != null) {
                    var windows = manager.get_windows();
                    if (window[0] != null) {
                        windows[0].setUrl(url);

                        windows[0].show();
                        windows[0].set_modal(false);

                    }
                }
                return false;
            }
            

   
        </script>
    </telerik:RadCodeBlock>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdn_row_index" runat="server" />
               <asp:HiddenField ID="hdn_row_deselected_index" runat="server" />
            <asp:HiddenField ID="hdn_row_deselected" runat="server" />
            <asp:HiddenField ID="hdn_basEnergy_combo" runat="server" />
            <asp:HiddenField ID="hdnassetid" runat="server" />
             <asp:HiddenField ID="hf_space_ids" runat="server" />
            <asp:HiddenField ID="hf_zone_ids" runat="server" />
              <asp:HiddenField ID="hfExpand" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div style="border-collapse: collapse">
        <table border="0" cellpadding="0" cellspacing="0" width="95%" style="border-collapse: collapse">
            <tr>
                <td class="tdValign">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;
                        margin: 0px">
                        <tr>
                            <td style="width: 75px; vertical-align: bottom;">
                                <telerik:RadTabStrip runat="server" ID="rts_energy_plus_zones" SelectedIndex="0"
                                    MultiPageID="rmp_energy_plus" Align="Justify" ShowBaseLine="True" Skin="Office2010Silver"
                                    dir="ltr" CssClass="normalLabel" Height="23px" Width="80px">
                                    <Tabs>
                                        <telerik:RadTab Text="Zones" PageViewID="rpv_facility" Value="select_facility" Font-Bold="true">
                                        </telerik:RadTab>
                                    </Tabs>
                                </telerik:RadTabStrip>
                            </td>
                            <td align="right" valign="top" style="margin: 0px; background-color: #F8F8F8;">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-width: 2px;
                                    border-style: solid; border-left-color: transparent; border-bottom-color: #DCDCDC;
                                    border-right-color: transparent; border-top-color: transparent; border-collapse: collapse;">
                                    <tr>
                                        <td align="right">
                                            <asp:ImageButton ID="ibtn_Edit" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                                Width="15" Height="15" ImageAlign="Bottom" />
                                        </td>
                                        <td width="4%" align="right" style="padding-right: 5px; vertical-align: top;">
                                            <asp:LinkButton ID="lbtn_edit" ForeColor="#585858" Font-Bold="true" Font-Names="Arial"
                                                runat="server" Text="EDIT" CssClass="lnkButton"></asp:LinkButton>
                                        </td>
                                        <%--<td align="right">
                                            <asp:ImageButton ID="img_edit" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                                Width="15" Height="15" ImageAlign="Bottom" />
                                            <asp:LinkButton ID="lbtn_edit" runat="server" Text="EDIT" ForeColor="Black" CssClass="lnkButton"></asp:LinkButton>
                                        </td>--%>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top" style="padding-left: 1px">
                    <fieldset style="border-style: solid; border-color: #DCDCDC; border-width: 2px; border-top-width: 0px;
                        border-top-color: transparent; border-right-color: #B4B4B4; border-bottom-style: outset">
                        <table border="0" width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="tdValign" style="padding-top: 10px; padding-left: 10px">
                                    <table border="0" cellpadding="0" cellspacing="0" style="vertical-align: middle">
                                        <tr>
                                            <td style="vertical-align: middle; background-image: url('/App/Images/asset_container_2.png');
                                                height: 40px; width: 200px; background-repeat: no-repeat;" align="center">
                                                <asp:Label ID="lbl_project_name" runat="server" Font-Size="10" ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                            </td>
                                            <td style="width: 5px">
                                            </td>
                                            <td style="vertical-align: middle; background-image: url('/App/Images/asset_container_zones.png');
                                                height: 40px; width: 200px; background-repeat: no-repeat" align="center">
                                                <asp:Label ID="lbl_list" runat="server" Text="Zone List" Font-Size="10" ForeColor="Red"
                                                    CssClass="normalLabel"></asp:Label>
                                            </td>
                                            <td style="width: 3%; height: 40px;" align="left">
                                            </td>
                                            <td valign="middle" style="height: 20px;">
                                                <telerik:RadComboBox ID="rarcmbZones" runat="server" Width="150px">
                                                </telerik:RadComboBox>
                                            </td>
                                            <td width="6px">
                                            </td>
                                            <td valign="middle" style="height: 20px;">
                                                <asp:ImageButton ID="ibtnSearch" runat="server" ImageUrl="~/App/Images/Icons/btnSearch.png"
                                                    OnClick="ibtnSearch_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 7px;">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 40px; padding-top: 15px">
                                </td>
                            </tr>
                            <tr>
                                <td class="tdValign" style="padding-left: 0px; padding-right: 0px;">
                                    <div style="width: 100%">
                                        <fieldset style="border-style: solid; margin: 0px; border-left-color: #DCDCDC; border-top-color: #DCDCDC;
                                            border-width: 1px; border-bottom-color: #A0A0A0; border-right-color: #B4B4B4;">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td align="right" class="gridRadPnlHeader">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="1px" style="background-color: Orange; border-collapse: collapse">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top">
                                                        <telerik:RadMultiPage runat="server" ID="rmp_energy_plus" SelectedIndex="0" Width="100%">
                                                            <telerik:RadPageView ID="rpv_details_grid" runat="server">
                                                                <telerik:RadGrid ID="rg_zones" runat="server" AllowPaging="true" PageSize="10" BorderColor="White"
                                                                    BorderWidth="0" AutoGenerateColumns="false" Width="100%" AllowSorting="true"
                                                                    AllowMultiRowSelection="true" PagerStyle-AlwaysVisible="false" OnItemCommand="rg_zones_ItemCommand"
                                                                    OnColumnCreated="rg_zones_ColumnCreated" OnPageSizeChanged="rg_zones_PageSizeChanged"
                                                                    OnPageIndexChanged="rg_zones_PageIndexChanged" OnSortCommand="rg_zones_OnSortCommand"
                                                                    OnPreRender="rg_zones_PreRender1" OnItemCreated="rg_zones_ItemCreated1" OnItemDataBound="rg_zones_ItemDataBound"
                                                                    MasterTableView-CellPadding="0" MasterTableView-CellSpacing="0" 
                                                                    ondatabound="rg_zones_DataBound">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true" />
                                                                        <ClientEvents OnRowSelected="onrowselected" OnRowSelecting="onRowSelecting" OnRowDeselecting="OnRowDeselecting"
                                                                            OnRowDeselected="onrowsdeselected" OnRowDblClick="RowSelected" />
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="pk_location_id,name,space_id,pk_energy_modeling_project_zonelist_linkup"
                                                                        AllowMultiColumnSorting="True" ClientDataKeyNames="pk_location_id,name,space_id,pk_energy_modeling_project_zonelist_linkup"
                                                                        GroupLoadMode="Server" ExpandCollapseColumn-Visible="false" HeaderStyle-CssClass="gridHeaderText">
                                                                        <PagerStyle Mode="NextPrevNumericAndAdvanced" HorizontalAlign="Right" Width="100%"
                                                                            AlwaysVisible="true" />
                                                                        <%--   <PagerStyle Mode="NumericPages" BackColor="White" ForeColor="Black" HorizontalAlign="Center" AlwaysVisible="true" />
                                                                        <PagerTemplate>
                                                                            <table id="tblPagerTemplate" width="100%" border="0" cellpadding="0" cellspacing="0" runat="server">
                                                                                <tr>
                                                                                    <td height="1px" style="background-color: Orange;" colspan="4">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="35%">
                                                                                    </td>
                                                                                    <td width="14%" align="left" style="height: 25px;">
                                                                                        <asp:Label  ID="lblTotalZoneVolume" Text="1272" runat="server" ForeColor="Black" Font-Bold="true"
                                                                                            Font-Size="Smaller"></asp:Label>
                                                                                    </td>
                                                                                    <td width="10%" align="left" style="height: 25px;">
                                                                                        <asp:Label ID="lblTotalEquipment" Text="52" runat="server" ForeColor="Black" Font-Bold="true"
                                                                                            Font-Size="Smaller"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <table border="0" width="100%" align="right" cellpadding="0" cellspacing="0" style="background: #F2F2F2;">
                                                                                <tr>
                                                                                    <td height="1px" style="background-color: Orange;" colspan="9">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="1%">
                                                                                    </td>
                                                                                    <td width="3%" align="right">
                                                                                        <asp:Label ID="lblgotopage" runat="server" Text="Go to:">
                                                                                        </asp:Label>
                                                                                    </td>
                                                                                    <td width="2%" align="left">
                                                                                        <asp:TextBox ID="txtgotopage" Text='<%# (int)DataBinder.Eval(Container, "OwnerTableView.CurrentPageIndex") + 1 %>'
                                                                                            OnTextChanged="txtgotopage_textChanged" runat="server" Width="80%">
                                                                                        </asp:TextBox>
                                                                                    </td>
                                                                                    <td width="3%">
                                                                                        <asp:LinkButton ID="btngotopage" Text="Go"  OnClick="btngotopage_click" runat="server" CommandName="gotoPage"
                                                                                            CommandArgument="gotoPage" />
                                                                                    </td>
                                                                                    <td width="4%" align="right">
                                                                                        <asp:Label ID="lblshowrows" runat="server" Text="Show rows:">
                                                                                        </asp:Label>
                                                                                    </td>
                                                                                    <td width="4%" align="left">
                                                                                        <telerik:RadNumericTextBox ID="txtradnumeriktextbox" ClientEvents-OnKeyPress="pagesize_changed" ClientEvents-OnLoad="pagesize" runat="server" ShowSpinButtons="true"
                                                                                            Width="60%" Type="Number" DataType="intger" MinValue="0">
                                                                                            <IncrementSettings Step="1" />
                                                                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                                                        </telerik:RadNumericTextBox>
                                                                                    </td>
                                                                                    <td width="4%" align="left">
                                                                                        <asp:Label ID="lbltotal" runat="server" Text="1-7 of 88">
                                                                                        </asp:Label>
                                                                                    </td>
                                                                                    <td width="7%" align="left">
                                                                                        <asp:ImageButton CommandName="page" Height="25px" ID="ibtnleft" runat="server" ImageUrl="~/App/Images/Icons/left_btn.png" />
                                                                                        <asp:ImageButton CommandName="page" Height="25px" ID="ibtnright" runat="server" ImageUrl="~/App/Images/Icons/right_btn.png" />
                                                                                    </td>
                                                                                    <td align="right" width="20%">
                                                                                        <asp:ImageButton ID="ibtnNewEnergyModeling" runat="server" ImageUrl="~/App/Images/Icons/Add_Zones.png"
                                                                                            BorderWidth="0" >
                                                                                        </asp:ImageButton>
                                                                                    </td>
                                                                                    <td width="1%">
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </PagerTemplate>--%>
                                                                        <Columns>
                                                                            <telerik:GridClientSelectColumn HeaderStyle-Width="20px" HeaderStyle-VerticalAlign="Top"
                                                                                ButtonType="ImageButton" ImageUrl="../Images/checkbox2.png">
                                                                            </telerik:GridClientSelectColumn>
                                                                            <telerik:GridBoundColumn DataField="pk_location_id" Visible="false">
                                                                                <ItemStyle CssClass="column" Width="4%" />
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="space_id" Visible="false">
                                                                                <ItemStyle CssClass="column" Width="3%" />
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="pk_energy_modeling_project_zonelist_linkup" UniqueName="pk_energy_modeling_project_zonelist_linkup"
                                                                                Visible="false">
                                                                                <ItemStyle CssClass="column" Width="3%" />
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderStyle-ForeColor="#404040" HeaderStyle-Font-Size="13px"
                                                                                HeaderStyle-Font-Bold="true" DataField="name" HeaderText="Zone List" UniqueName="Floor">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderStyle-ForeColor="#404040" HeaderStyle-Font-Size="13px"
                                                                                HeaderStyle-Font-Bold="true" DataField="Space" HeaderText="Zone Name" UniqueName="Zone_name">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderStyle-ForeColor="#404040" HeaderStyle-Font-Size="13px"
                                                                                HeaderStyle-Font-Bold="true" DataField="volume" HeaderText="Zone Volume" UniqueName="Zone_Volume">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderStyle-ForeColor="#404040" HeaderStyle-Font-Size="13px"
                                                                                HeaderStyle-Font-Bold="true" DataField="space_equipment" HeaderText="Zone Equipment"
                                                                                UniqueName="Zone_Equipment">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderStyle-HorizontalAlign="Justify" HeaderStyle-ForeColor="#404040"
                                                                                HeaderStyle-Font-Size="13px" HeaderStyle-Font-Bold="true" DataField="Schedule"
                                                                                HeaderText="Schedule" UniqueName="Schedule">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridTemplateColumn HeaderText="Action" UniqueName="action" HeaderStyle-ForeColor="#404040"
                                                                                HeaderStyle-Font-Size="13px" HeaderStyle-Font-Bold="true" HeaderStyle-Width="100px">
                                                                                <ItemTemplate>
                                                                                    <table border="0" id="tbl_edit" height="100%" cellspacing="0" cellpadding="0" width="100%"
                                                                                        style="display: none; margin: 0;" runat="server">
                                                                                        <tr>
                                                                                            <td width="60%">
                                                                                            </td>
                                                                                            <td style="padding-left: 2px; border-bottom-color: transparent;">
                                                                                                <asp:ImageButton ID="ibtn_expand" runat="server" ImageUrl="~/App/Images/Icons/asset_arrow_lg.png"
                                                                                                    CommandName="attributes" Width="15" Height="15" />
                                                                                            </td>
                                                                                            <td style="padding-left: 2px; border-bottom-color: transparent;">
                                                                                                <asp:ImageButton ID="ibtn_edit" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                                                                                    Width="15" Height="15" CommandName="editAttributes" />
                                                                                            </td>
                                                                                            <td style="padding-left: 2px; border-bottom-color: transparent;">
                                                                                                <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                                                                                    Width="15" Height="15" CommandName="closeAttributes" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                    <table border="0" id="tbl_edit2" cellspacing="0" cellpadding="0" width="100%" style="display: none"
                                                                                        runat="server">
                                                                                        <tr>
                                                                                            <td width="60%">
                                                                                            </td>
                                                                                            <td style="padding-left: 2px; border-bottom-color: transparent;">
                                                                                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/asset_arrow_lg.png"
                                                                                                    CommandName="attributes" Width="15" Height="15" />
                                                                                            </td>
                                                                                            <td style="padding-left: 2px; border-bottom-color: transparent;">
                                                                                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                                                                                    Width="15" Height="15" CommandName="editAttributes" />
                                                                                            </td>
                                                                                            <td style="padding-left: 2px; border-bottom-color: transparent;">
                                                                                                <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                                                                                    Width="15" Height="15" CommandName="closeAttributes" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>
                                                                        </Columns>
                                                                        <NestedViewSettings>
                                                                            <ParentTableRelation>
                                                                                <telerik:GridRelationFields DetailKeyField="pk_zonlistId" MasterKeyField="pk_zonlistId" />
                                                                            </ParentTableRelation>
                                                                        </NestedViewSettings>
                                                                        <NestedViewTemplate>
                                                                            <asp:Panel Width="100%" BackColor="#DBDBDB" ID="Pnl_whole_control" runat="server"
                                                                                BorderColor="#DBDBDB">
                                                                                <div>
                                                                                    <fieldset style="padding-top: 10px; padding-bottom: 7px; padding-right: 10px; border: 0;">
                                                                                        <asp:Table ID="tbl_modelingObject" runat="server" Width="100%" CellPadding="0" CellSpacing="0">
                                                                                            <asp:TableRow>
                                                                                                <asp:TableCell Width="50%" runat="server">
                                                                                                    <asp:Table ID="tbl_modelingObject1" runat="server" Width="78%" CellPadding="0" CellSpacing="0">
                                                                                                        <asp:TableRow>
                                                                                                            <asp:TableCell Width="150px" VerticalAlign="top" ID="tdModelingObjects" HorizontalAlign="Left"
                                                                                                                runat="server">
                                                                                                                <asp:Label ID="lblModelingObjects" Text="Select Modeling Objects" runat="server"
                                                                                                                    Font-Bold="true"></asp:Label>
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell Width="150px" HorizontalAlign="left" VerticalAlign="top">
                                                                                                                <telerik:RadComboBox ID="rcbmodelingObjects" Height="140" ClientIDMode="Static" runat="server"
                                                                                                                    Width="200px">
                                                                                                                </telerik:RadComboBox>
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell Width="2px" HorizontalAlign="Left">
                                                                                                
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell Width="60px" HorizontalAlign="Center" Enabled="false" Style="padding-bottom: 3px;">
                                                                                                                <asp:LinkButton ID="lbtnAdd" runat="server" CssClass="lnkBtnBgImg" Text="Add" Font-Size="10"
                                                                                                                    Font-Names="Arial Regular" ForeColor="Black" Font-Underline="false" Height="23"></asp:LinkButton>
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell></asp:TableCell>
                                                                                                        </asp:TableRow>
                                                                                                    </asp:Table>
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell Width="10%">
                                                                                                
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell HorizontalAlign="Right" Width="12%">
                                                                                                    <asp:Table BorderColor="0" ID="Table2" Width="100%" runat="server">
                                                                                                        <asp:TableRow>
                                                                                                            <asp:TableCell ColumnSpan="3" Width="45%" HorizontalAlign="Center" Enabled="false"
                                                                                                                BorderWidth="0px">
                                                                                                                <asp:LinkButton ID="lbtn_copy" runat="server" Text="Copy" CssClass="lnkBtnBgImg"
                                                                                                                    Font-Size="10" Font-Names="Arial Regular" ForeColor="Black" Font-Underline="false"
                                                                                                                    Height="23"></asp:LinkButton>
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell Style="width: 2px" HorizontalAlign="Right">
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell HorizontalAlign="Center">
                                                                                                                <asp:LinkButton ID="lbtn_paste" runat="server" Enabled="false" CssClass="lnkBtnBgImg"
                                                                                                                    Text="Paste" Font-Size="10" Font-Names="Arial Regular" ForeColor="Black" Font-Underline="false"
                                                                                                                    Height="23"></asp:LinkButton>
                                                                                                            </asp:TableCell>
                                                                                                        </asp:TableRow>
                                                                                                    </asp:Table>
                                                                                                </asp:TableCell>
                                                                                            </asp:TableRow>
                                                                                        </asp:Table>
                                                                                    </fieldset>
                                                                                    <fieldset style="padding: 7px; padding-left: 0px; padding-top: 0px; border: 0;">
                                                                                        <asp:Panel Width="99%" ID="NestedViewPanel" Height="150px" ScrollBars="Vertical"
                                                                                            BackColor="White" runat="server" BorderColor="#DBDBDB">
                                                                                            <asp:Table ID="tblSpace_attributes" runat="server" CellPadding="0" CellSpacing="0"
                                                                                                ClientIDMode="Static" Width="97.5%" border="0">
                                                                                            </asp:Table>
                                                                                        </asp:Panel>
                                                                                        <fieldset style="padding-top: 7px; border: 0;">
                                                                                            <table border="0" width="100%">
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <asp:Table ID="Table1" Width="100%" runat="server">
                                                                                                            <asp:TableRow>
                                                                                                                <asp:TableCell ColumnSpan="3" HorizontalAlign="Right" BorderWidth="0px">
                                                                                                                    <td align="center" class="lnkBtnBgImg">
                                                                                                                        <asp:LinkButton ID="LinkButton1" runat="server" Text="UNDO" Enabled="false" ForeColor="Gray"
                                                                                                                            Font-Size="10" Font-Names="Arial Regular" Font-Underline="false" Height="20"></asp:LinkButton>
                                                                                                                    </td>
                                                                                                                    <td style="width: 0.5%">
                                                                                                                    </td>
                                                                                                                    <td align="center" class="lnkBtnBgImg">
                                                                                                                        <asp:LinkButton ID="LinkButton2" runat="server" Text="SAVE" Enabled="false" ForeColor="Gray"
                                                                                                                            Font-Size="10" Font-Names="Arial Regular" Font-Underline="false" Height="20"></asp:LinkButton>
                                                                                                                    </td>
                                                                                                                </asp:TableCell>
                                                                                                            </asp:TableRow>
                                                                                                        </asp:Table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </fieldset>
                                                                                    </fieldset>
                                                                                </div>
                                                                            </asp:Panel>
                                                                            <asp:Panel Width="100%" ClientIDMode="Static" Visible="false" BackColor="#DBDBDB"
                                                                                ID="PnlEdit" runat="server" BorderColor="#DBDBDB">
                                                                                <div>
                                                                                    <fieldset style="padding-top: 10px; padding-bottom: 7px; padding-right: 10px; border: 0;">
                                                                                        <asp:Table ID="tbl_edit_modelingObject" runat="server" Width="100%" CellPadding="0"
                                                                                            CellSpacing="0">
                                                                                            <asp:TableRow>
                                                                                                <asp:TableCell ID="TableCell2" Width="50%" runat="server">
                                                                                                    <asp:Table ID="Table3" runat="server" Width="78%" CellPadding="0" CellSpacing="0">
                                                                                                        <asp:TableRow>
                                                                                                            <asp:TableCell Width="150px" VerticalAlign="top" HorizontalAlign="Left" ID="TableCell1"
                                                                                                                runat="server">
                                                                                                                <asp:Label ID="lbl_edit_modeling_object" Text="Select Modeling Objects" runat="server"
                                                                                                                    Font-Bold="true"></asp:Label>
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell Width="150px" HorizontalAlign="left" VerticalAlign="top">
                                                                                                                <telerik:RadComboBox ID="rcb_edit_modeling_object" Height="140" ClientIDMode="Static"
                                                                                                                    runat="server" Width="200px">
                                                                                                                </telerik:RadComboBox>
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell Width="2px" HorizontalAlign="Left">
                                                                                                
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell Width="60px" HorizontalAlign="center" Enabled="false" Style="padding-bottom: 3px;">
                                                                                                                <asp:LinkButton ID="lbtn_edit_add" runat="server" Text="Add" CssClass="lnkBtnBgImg"
                                                                                                                    Font-Size="10" Font-Names="Arial Regular" ForeColor="Black" Font-Underline="false"
                                                                                                                    Height="22"></asp:LinkButton>
                                                                                                            </asp:TableCell>
                                                                                                        </asp:TableRow>
                                                                                                    </asp:Table>
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell Width="10%">
                                                                                                
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell HorizontalAlign="Right" Width="12%">
                                                                                                    <asp:Table BorderColor="0" ID="tbl_edit_copyPaste" Width="100%" runat="server">
                                                                                                        <asp:TableRow>
                                                                                                            <asp:TableCell ColumnSpan="3" Width="45%" HorizontalAlign="Center" BorderWidth="0px">
                                                                                                                <asp:LinkButton ID="lbtn_edit_copy" Enabled="false" runat="server" CssClass="lnkBtnBgImg"
                                                                                                                    Text="Copy" Font-Size="10" Font-Names="Arial Regular" ForeColor="GrayText" Font-Underline="false"
                                                                                                                    Height="22"></asp:LinkButton>
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell Style="width: 1%">
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell HorizontalAlign="Center">
                                                                                                                <asp:LinkButton ID="lbtn_edit_paste" Enabled="false" runat="server" CssClass="lnkBtnBgImg"
                                                                                                                    Text="Paste" Font-Size="10" Font-Names="Arial Regular" ForeColor="GrayText" Font-Underline="false"
                                                                                                                    Height="22"></asp:LinkButton>
                                                                                                            </asp:TableCell>
                                                                                                        </asp:TableRow>
                                                                                                    </asp:Table>
                                                                                                </asp:TableCell>
                                                                                            </asp:TableRow>
                                                                                        </asp:Table>
                                                                                    </fieldset>
                                                                                    <fieldset style="padding: 7px; padding-left: 0px; border: 0;">
                                                                                        <asp:Panel Width="99%" ClientIDMode="Static" ID="pnl_edit_attributes_table" Height="150px"
                                                                                            ScrollBars="Vertical" BackColor="White" runat="server" BorderColor="#DBDBDB">
                                                                                            <asp:Table ID="tbl_edit_space_attributes" runat="server" CellPadding="0" CellSpacing="0"
                                                                                                ClientIDMode="Static" Width="97.5%" border="0">
                                                                                            </asp:Table>
                                                                                        </asp:Panel>
                                                                                        <fieldset style="padding-top: 7px; border: 0;">
                                                                                            <table border="0" width="100%">
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <asp:Table ID="Table6" Width="100%" runat="server">
                                                                                                            <asp:TableRow>
                                                                                                                <asp:TableCell ColumnSpan="3" HorizontalAlign="Right" BorderWidth="0px">
                                                                                                                    <td align="center" class="lnkBtnBgImg">
                                                                                                                        <asp:LinkButton ID="lbtn_edit_undo" Enabled="false" runat="server" ClientIDMode="Static"
                                                                                                                            Text="UNDO" ForeColor="Black" Font-Size="10" Font-Names="Arial Regular" Font-Underline="false"
                                                                                                                            Height="20"></asp:LinkButton>
                                                                                                                    </td>
                                                                                                                    <td style="width: 0.5%">
                                                                                                                    </td>
                                                                                                                    <td align="center" class="lnkBtnBgImg">
                                                                                                                        <asp:LinkButton ID="lbtn_edit_save" CommandName="save" runat="server" OnClick="OnClick_lbtn_edit_save"
                                                                                                                            Text="SAVE" ClientIDMode="Static" Enabled="true" ForeColor="Black" Font-Size="10"
                                                                                                                            Font-Names="Arial Regular" Font-Underline="false" Height="20"></asp:LinkButton>
                                                                                                                    </td>
                                                                                                                </asp:TableCell>
                                                                                                            </asp:TableRow>
                                                                                                        </asp:Table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </fieldset>
                                                                                    </fieldset>
                                                                                </div>
                                                                            </asp:Panel>
                                                                        </NestedViewTemplate>
                                                                    </MasterTableView>
                                                                </telerik:RadGrid>
                                                            </telerik:RadPageView>
                                                        </telerik:RadMultiPage>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
        <table width="95%">
            <tr>
                <td align="left">
                    <fieldset style="padding-top: 7px; border: 0;">
                        <telerik:RadButton ID="btn_addSpacestoProject" Text="Save Selection" runat="server"
                            OnClick="btn_addSpacestoProject_Click">
                        </telerik:RadButton>
                    </fieldset>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hf_em_of_seq_id" runat="server" />
        <asp:HiddenField ID="hf_zone_id" runat="server" />
        <asp:HiddenField ID="hf_space_id" runat="server" />
        <asp:HiddenField ID="hf_mode" runat="server" />
    </div>

    <telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Red" 
        Skin="" Behaviors="None">
        <Windows>
            <telerik:RadWindow ID="rd_window_assign_schedule" runat="server" ReloadOnShow="false" Behaviors="Move"
                Width="700" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false"  BorderColor="Black"
                EnableAjaxSkinRendering="false" BorderStyle="None" BackColor="Red" VisibleTitlebar="false"
                Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
