<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusPM_Master.master" AutoEventWireup="true"
    CodeFile="EnergyModelingEquipment.aspx.cs" Inherits="App_NewUI_EnergyModelingEquipment" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <style type="text/css">
        
            div
        {
            overflow-x: hidden;
        }
        ddl
        {
            overflow-x: hidden;
            }
        .lnkBtnBgImg
        {
            background-image: url('/App/Images/asset_button_sm_gray.png');
            background-repeat: no-repeat;
            height: 25px;
            width: 60px;
            vertical-align: middle;
        }
        .innerTblTd
        {
            padding-left: 5px;
            height: 25px;
        }
       
        .row
        {
            background-color:White;
            }
            .tblShadow
            {
                border-top-color:transparent;
                border-top-width:0px;
                border-bottom-width:3px;
                border-left-width:1px;
                border-right-width:1px;
                border-left-color:#E8E8E8;
                border-right-color:#E8E8E8;
                border-bottom-color:#E8E8E8;
                border-bottom-style:outset;
                }
                .tblBackGroud
                {
                    background-color:transparent;
                    border-collapse:collapse;
                }
                
    </style>
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">

            function onRowDoubleClicked(sender, eventArgs) {
                var pk_asset_id="";
                pk_asset_id = eventArgs.getDataKeyValue("pk_asset_id");
                alert(pk_asset_id);
                var grid = sender;
                var MasterTable = grid.get_masterTableView(); var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
                var url = "EnergyModelingSchedule.aspx?asset_id=" + pk_asset_id;
                top.location.href(url);

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
    <script type="text/javascript">
        function HierarchyExpanding(sender, eventArgs) {
            alert("HI");
            var grids = document.getElementById("<%=rg_equipments.ClientID %>");
            alert(grids);
            var MasterTable = document.getElementById("<%=rg_equipments.ClientID %>");
            var row = MasterTable.get_dataItems()[document.getElementById("<%=hdn_row_index.ClientID %>").value];

            var Name = MasterTable.getCellByColumnUniqueName(row, "action");
            var radbutton = $find(Name.children[0].id);
            document.getElementById(Name.children[0].id).style.display = "inline";

        }

        function HierarchyCollapsing(sender, args) {
            alert("hi");

        }

        function OnRowSelecting(sender, eventArgs) {

            var pk_asset_id = eventArgs.getDataKeyValue("pk_asset_id");
            var space_id = eventArgs.getDataKeyValue("space_id");
            var pk_class_id = eventArgs.getDataKeyValue("group_id");
            var zone_id = eventArgs.getDataKeyValue("pk_location_id");
            var space = document.getElementById("<%=hf_space_ids.ClientID%>").value;
            var asset = document.getElementById("<%=hf_asset_ids.ClientID%>").value;
            var class1 = document.getElementById("<%=hfEquipment_class.ClientID%>").value;
            var zone = document.getElementById("<%=hfzone_id.ClientID%>").value;

            if (space != "") {
                if (space.indexOf(space_id) == -1)
                    document.getElementById("<%=hf_space_ids.ClientID%>").value = document.getElementById("<%=hf_space_ids.ClientID%>").value + ',' + space_id;

            }
            else {
                document.getElementById("<%=hf_space_ids.ClientID%>").value = space_id;
            }


            if (asset != "") {
                if (asset.indexOf(pk_asset_id) == -1) {
                    document.getElementById("<%=hf_asset_ids.ClientID%>").value = document.getElementById("<%=hf_asset_ids.ClientID%>").value + ',' + pk_asset_id;
                }
            }

            else
                document.getElementById("<%=hf_asset_ids.ClientID%>").value = pk_asset_id;

            if (class1 != "") {
                if (class1.indexOf(pk_class_id) == -1) {
                    document.getElementById("<%=hfEquipment_class.ClientID%>").value = document.getElementById("<%=hfEquipment_class.ClientID%>").value + ',' + pk_class_id;
                }
            }

            else
                document.getElementById("<%=hfEquipment_class.ClientID%>").value = pk_class_id;

            if (zone != "") {
                if (zone.indexOf(zone_id) == -1) {
                    document.getElementById("<%=hfzone_id.ClientID%>").value = document.getElementById("<%=hfzone_id.ClientID%>").value + ',' + zone_id;
                }
            }

            else
                document.getElementById("<%=hfzone_id.ClientID%>").value = zone_id;

        }

        function OnRowDeselecting(sender, eventArgs) {

            var pk_asset_id = eventArgs.getDataKeyValue("pk_asset_id");
            var space_id = eventArgs.getDataKeyValue("space_id");
            var zone_id = eventArgs.getDataKeyValue("pk_location_id");
            var pk_class_id = eventArgs.getDataKeyValue("group_id");
            var space = document.getElementById("<%=hf_space_ids.ClientID%>").value;
            var asset = document.getElementById("<%=hf_asset_ids.ClientID%>").value;
            var class1 = document.getElementById("<%=hfEquipment_class.ClientID%>").value;
            var zone = document.getElementById("<%=hfzone_id.ClientID%>").value;

            if (asset != "") {
                if (asset.indexOf(pk_asset_id) != -1)
                    document.getElementById("<%=hf_asset_ids.ClientID%>").value = asset.replace(pk_asset_id, "00000000-0000-0000-0000-000000000000");

            }
//            if (space != "") {
//                if (space.indexOf(space_id) != -1)
//                    document.getElementById("<%=hf_space_ids.ClientID%>").value = space.replace(space_id, "00000000-0000-0000-0000-000000000000");

//            }

//            if (class1 != "") {
//                if (class1.indexOf(pk_class_id) != -1)
//                    document.getElementById("<%=hf_asset_ids.ClientID%>").value = class1.replace(pk_class_id, "00000000-0000-0000-0000-000000000000");

//            }
//            if (zone != "") {
//                if (zone.indexOf(pk_class_id) != -1)
//                    document.getElementById("<%=hfzone_id.ClientID%>").value = zone.replace(zone_id, "00000000-0000-0000-0000-000000000000");

//            }



        }

       
    </script>
      <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" 
        DecoratedControls="RadioButtons, Buttons, Scrollbars" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">


        function onrowselected(sender, eventArgs) {
            
           
                var e = eventArgs.get_domEvent();
                var MasterTable = sender.get_masterTableView();
                var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
                document.getElementById("<%=hdn_row_index.ClientID %>").value = eventArgs.get_itemIndexHierarchical();
                var Name = MasterTable.getCellByColumnUniqueName(row, "action");
                document.getElementById(Name.children[0].id).style.display = "inline";
                document.getElementById("<%=hdn_row_deselected.ClientID%>").value = "row_selected";
           
        }


        function onrowsdeselected(sender, eventArgs) {
        


            var e = eventArgs.get_domEvent();
            var MasterTable = sender.get_masterTableView();
            var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
            var Name = MasterTable.getCellByColumnUniqueName(row, "action");
            document.getElementById("<%=hdn_row_index.ClientID %>").value = "";
            document.getElementById(Name.children[0].id).style.display = "none";
            document.getElementById("<%=hdn_row_deselected.ClientID%>").value = "row_deselected";
//            if (document.getElementById(Name.children[0].id).getElementsByTagName("input")[0].src.indexOf("down-arrow.png") == -1) {
//                document.getElementById(Name.children[0].id).getElementsByTagName("input")[0].click();
            //            }

            if (document.getElementById("<%=hfExpand.ClientID%>").value == "expanded")
                document.getElementById(Name.children[0].id).getElementsByTagName("input")[0].click();
        }
    </script>
    </telerik:RadCodeBlock>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:HiddenField ID="hdn_row_index" runat="server" />
                    <asp:HiddenField ID="hdn_row_deselected" runat="server" />
                     <asp:HiddenField ID="hdn_basEnergy_combo" runat="server" />
                     <asp:HiddenField ID="hdnassetid" runat="server" />
                      <asp:HiddenField ID="hf_em_of_seq_id" runat="server" />
                       <asp:HiddenField ID="hf_space_ids" runat="server" />
                        <asp:HiddenField ID="Hfindexes" runat="server" />
                           <asp:HiddenField ID="hfExpand" runat="server" />
                             <asp:HiddenField ID="hfEquipment_class" runat="server" />
                              <asp:HiddenField ID="hfzone_id" runat="server" />
            <asp:HiddenField ID="hf_asset_ids" runat="server" />
        <asp:HiddenField ID="hf_zone_id" runat="server" />
          <asp:HiddenField ID="hf_equipment_id" runat="server" />
              <asp:HiddenField ID="hf_mode" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
    <div style="border-collapse: collapse">
        <table border="0" cellpadding="0" cellspacing="0" width="99%" style="border-collapse: collapse">
            <tr>
                <td class="tdValign">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;
                        margin: 0px">
                        <tr>
                            <td style="width: 85px; vertical-align: bottom;" align="justify">
                                <telerik:RadTabStrip runat="server" ID="rts_energy_plus_project_details" SelectedIndex="0"
                                    MultiPageID="rmp_energy_plus" Align="Justify" ShowBaseLine="True" Skin="Office2010Silver"
                                    CssClass="normalLabel" Height="23px" Width="85px">
                                    <Tabs>
                                        <telerik:RadTab Text="Equipment" PageViewID="rpv_facility" Value="select_facility"
                                            Font-Bold="true">
                                        </telerik:RadTab>
                                    </Tabs>
                                </telerik:RadTabStrip>
                            </td>
                            <td align="right" valign="top" style="margin: 0px; background-color: #F8F8F8;">
                                <table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-width: 2px;
                                    border-style: solid; border-left-color: transparent; border-bottom-color: #DCDCDC;
                                    border-right-color: transparent; border-top-color: transparent; border-collapse: collapse;">
                                    <tr>
                                        <td align="right">
                                            <asp:ImageButton ID="img_edit" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                                Width="15" Height="15" ImageAlign="Bottom" />
                                            <asp:LinkButton ID="lbtn_edit" runat="server" Text="EDIT" ForeColor="Black" CssClass="lnkButton"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top" style="padding-left: 1px">
                  <%--<fieldset style="border-style: solid; border-color: #DCDCDC; border-width: 2px; border-top-width: 0px;
                        border-top-color: transparent; border-right-style: outset; border-bottom-style: outset">--%>
                    <table border="1" width="100%" cellpadding="0" cellspacing="0" style="border-top-color: transparent;
                        border-top-width: 0px; border-bottom-width: 3px; border-left-width: 1px; border-right-width: 1px;
                        border-left-color: #E8E8E8; border-right-color: #E8E8E8; border-bottom-color: #E8E8E8;
                        border-bottom-style: outset;">
                        <tr>
                            <td class="tdValign" style="padding-top: 10px; padding-left: 10px; border-bottom-color: transparent">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="background-image: url('/App/Images/asset_container_2.png'); height: 40px;
                                            width: 200px; background-repeat: no-repeat;" align="center">
                                            <asp:Label ID="lbl_project_name" runat="server" 
                                                Font-Size="10" ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                        </td>
                                        <td style="width: 5px">
                                        </td>
                                        <td style="background-image: url('/App/Images/asset_container_3.png'); height: 40px;
                                            width: 200px; background-repeat: no-repeat" align="center">
                                            <asp:Label ID="lbl_list" runat="server" Text="Equipment List" Font-Size="10" ForeColor="Red"
                                                CssClass="normalLabel"></asp:Label>
                                        </td>
                                        <td style="height: 15px; padding-left: 10px">
                                            <telerik:RadComboBox ID="cmb_search" runat="server" Width="200px" ExpandDirection="Down"
                                                Height="10px" ZIndex="10" Skin="Default">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="vertical-align: middle; padding-left: 5px; height: 15px" align="center">
                                            <asp:ImageButton ID="ibtn_search" runat="server" ImageUrl="~/App/Images/Icons/btnSearch.png" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdValign" style="padding-left: 0px; padding-bottom: 0px">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td height="10px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="1px" style="background-color: Orange; border-collapse: collapse;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="gridRadPnlHeader">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="1px" style="background-color: Orange; border-collapse: collapse;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <telerik:RadMultiPage runat="server" ID="rmp_energy_plus" SelectedIndex="0" Width="100%">
                                             <telerik:RadPageView ID="RadPageView1" runat="server">
                                                                <telerik:RadGrid ID="rg_equipments" runat="server" AllowPaging="true" 
                                                                    PageSize="10" BorderColor="White"
                                                                    BorderWidth="0" AutoGenerateColumns="false" Width="100%" AllowSorting="true"
                                                                    AllowMultiRowSelection="true" PagerStyle-AlwaysVisible="false" OnItemCommand="rg_equipments_ItemCommand"
                                                                    OnColumnCreated="rg_equipments_ColumnCreated" OnPageSizeChanged="rg_equipments_PageSizeChanged" 
                                                                    OnPageIndexChanged="rg_equipments_PageIndexChanged" OnSortCommand="rg_equipments_OnSortCommand"
                                                                    OnItemCreated="rg_equipments_ItemCreated1" 
                                                                    OnItemDataBound="rg_equipments_ItemDataBound" 
                                                                    OnPreRender="rg_equipments_PreRender1" ondatabound="rg_equipments_DataBound">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" UseClientSelectColumnOnly="true" />
                                                                        <ClientEvents OnRowSelected="onrowselected" OnRowDeselected="onrowsdeselected" 
                                                                        OnRowSelecting="OnRowSelecting" OnRowDeselecting="OnRowDeselecting" />
                                                                    </ClientSettings>
                                                                   
                                                        <MasterTableView DataKeyNames="pk_asset_id,name,group_id,space_id,pk_energy_modeling_project_equipments_linkup" AllowMultiColumnSorting="True" ClientDataKeyNames="pk_asset_id,name,group_id,space_id,pk_energy_modeling_project_equipments_linkup"
                                                                        GroupLoadMode="Server" ExpandCollapseColumn-Visible="false" HeaderStyle-CssClass="gridHeaderText" CellPadding="0" CellSpacing="0"
                                                           >
                                                            <PagerStyle  Mode="NextPrevNumericAndAdvanced" HorizontalAlign="Right" Width="100%"
                                                                            AlwaysVisible="true"/>
                                                            <Columns>
                                                                <telerik:GridClientSelectColumn HeaderStyle-Width="20px" HeaderStyle-VerticalAlign="Top"
                                                                    UniqueName="ClientSelectColumn" CommandName="expandcolumn" ImageUrl="~/App/Images/Icons/icon_edit_sm.png">
                                                                </telerik:GridClientSelectColumn>
                                                                <telerik:GridBoundColumn DataField="pk_location_id" Visible="false">
                                                                    <ItemStyle CssClass="column" Width="2%" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="space_id" Visible="false">
                                                                    <ItemStyle CssClass="column" Width="2%" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="pk_asset_id" Visible="false">
                                                                    <ItemStyle CssClass="column" Width="2%" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="group_id" Visible="false">
                                                                    <ItemStyle CssClass="column" Width="2%" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="pk_energy_modeling_project_equipments_linkup"
                                                                    UniqueName="pk_energy_modeling_project_equipments_linkup" Visible="false">
                                                                    <ItemStyle CssClass="column" Width="2%" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderStyle-ForeColor="#404040" HeaderStyle-Font-Size="13px"
                                                                    HeaderStyle-Font-Bold="true" DataField="name" HeaderText="Zone List" UniqueName="Floor">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderStyle-ForeColor="#404040" HeaderStyle-Font-Size="13px"
                                                                    HeaderStyle-Font-Bold="true" DataField="Space" HeaderText="Zone Name" UniqueName="Zone_name">
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn HeaderStyle-ForeColor="#404040" HeaderStyle-Font-Size="13px"
                                                                    HeaderStyle-Font-Bold="true" DataField="space_equipment" HeaderText="Name" UniqueName="space_equipment">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderStyle-ForeColor="#404040" HeaderStyle-Font-Size="13px"
                                                                    HeaderStyle-Font-Bold="true" DataField="Equipment_class" HeaderText="Equipment Class"
                                                                    UniqueName="Equipment_class">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderStyle-HorizontalAlign="Justify" HeaderStyle-ForeColor="#404040"
                                                                    HeaderStyle-Font-Size="13px" HeaderStyle-Font-Bold="true" DataField="Schedule"
                                                                    HeaderText="Schedule" UniqueName="Schedule">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridTemplateColumn HeaderText="Action" UniqueName="action" HeaderStyle-ForeColor="#404040"
                                                                    HeaderStyle-Font-Size="13px" HeaderStyle-Font-Bold="true" HeaderStyle-Width="100px">
                                                                    <ItemTemplate>
                                                                        <table border="0" id="tbl_edit" cellspacing="0" cellpadding="0" width="100%" style="display: none"
                                                                            runat="server">
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
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                            </Columns>
                                                            <NestedViewSettings>
                                                                <ParentTableRelation>
                                                                    <telerik:GridRelationFields DetailKeyField="pk_asset_id" MasterKeyField="pk_asset_id" />
                                                                </ParentTableRelation>
                                                            </NestedViewSettings>
                                                            <NestedViewTemplate>
                                                                   <asp:Panel Width="100%" BackColor="#DBDBDB" ID="Pnl_whole_control" runat="server" BorderColor="#DBDBDB">
                                                                                <div>
                                                                                  <fieldset style="padding-top: 10px; padding-bottom:7px;padding-right:10px; border:0;">
                                                                                <asp:Table id="tbl_modelingObject" runat="server" width="100%" cellpadding="0"  cellspacing="0">
                                                                                  <asp:TableRow>
                                                                                  <asp:TableCell ID="TableCell1" Width="50%" runat="server">
                                                                                  <asp:Table id="tbl_modelingObject1" runat="server" width="78%" cellpadding="0"  cellspacing="0">
                                                                                    <asp:TableRow>
                                                                                                <asp:TableCell width="150px" VerticalAlign="top" id="tdModelingObjects" HorizontalAlign="Left" runat="server">
                                                                                                    <asp:Label ID="lblModelingObjects" Text="Select Modeling Objects" runat="server"
                                                                                                        Font-Bold="true"></asp:Label>
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell   width="150px" HorizontalAlign="left"  VerticalAlign="top">
                                                                                                    <telerik:RadComboBox ID="rcbmodelingObjects" Height="140"  ClientIDMode="Static" runat="server" Width="200px">
                                                                                                    </telerik:RadComboBox>
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell Width="2px" HorizontalAlign="Left">
                                                                                                
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell Width="60px" HorizontalAlign="Center"  Enabled="false"  style="padding-bottom: 3px;">
                                                                                                    <asp:LinkButton ID="lbtnAdd" runat="server" CssClass="lnkBtnBgImg" Text="Add" Font-Size="10" Font-Names="Arial Regular"
                                                                                                        ForeColor="Black" Font-Underline="false" Height="23"></asp:LinkButton>
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell></asp:TableCell>
                                                                                                </asp:TableRow>
                                                                                               </asp:Table>
                                                                                                </asp:TableCell>
                                                                                                 
                                                                                                <asp:TableCell Width="10%">
                                                                                                
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell HorizontalAlign="Right"  Width="12%">
                                                                                                    <asp:Table BorderColor="0" ID="Table2" Width="100%"  runat="server">
                                                                                                        <asp:TableRow>
                                                                                                            <asp:TableCell ColumnSpan="3" Width="45%" HorizontalAlign="Center"  Enabled="false" BorderWidth="0px">
                                                                                                                <asp:LinkButton ID="lbtn_copy" runat="server"  Text="Copy" CssClass="lnkBtnBgImg" Font-Size="10" Font-Names="Arial Regular"
                                                                                                                    ForeColor="Black" Font-Underline="false" Height="23"></asp:LinkButton>
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell Style="width:2px" HorizontalAlign="Right">
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell   HorizontalAlign="Center">
                                                                                                                <asp:LinkButton ID="lbtn_paste"  runat="server" Enabled="false" CssClass="lnkBtnBgImg"  Text="Paste" Font-Size="10" Font-Names="Arial Regular"
                                                                                                                    ForeColor="Black" Font-Underline="false" Height="23"></asp:LinkButton>
                                                                                                            </asp:TableCell>
                                                                                                        </asp:TableRow>
                                                                                                    </asp:Table>
                                                                                                </asp:TableCell>
                                                                                  </asp:TableRow>
                                                                                </asp:Table>
                                                                                              
                                                                                </fieldset>
                                                                                    <fieldset style="padding: 7px;padding-left:0px; padding-top:0px; border:0;">
                                                                                      <asp:Panel Width="99%" ID="NestedViewPanel" Height="150px" ScrollBars="Vertical"
                                                                                                BackColor="White"  runat="server" BorderColor="#DBDBDB">
                                                                                        <asp:Table ID="tblequipment_attributes" runat="server" CellPadding="0" CellSpacing="0"
                                                                                            ClientIDMode="Static" Width="97.5%" border="0">
                                                                                          
                                                                                        </asp:Table>
                                                                                            </asp:Panel>
                                                                                             <fieldset style="padding-top: 7px;border:0;">
                                                                                            <table border="0"  width="100%">
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <asp:Table ID="Table1" Width="100%" runat="server">
                                                                                                                    <asp:TableRow>
                                                                                                                        <asp:TableCell ColumnSpan="3" HorizontalAlign="Right" BorderWidth="0px">
                                                                                                                            <td align="center" class="lnkBtnBgImg">
                                                                                                                                <asp:LinkButton ID="LinkButton1" runat="server" Text="UNDO" Enabled="false" ForeColor="Gray" Font-Size="10"
                                                                                                                                    Font-Names="Arial Regular" Font-Underline="false" Height="20"></asp:LinkButton>
                                                                                                                            </td>
                                                                                                                            <td style="width: 0.5%">
                                                                                                                            </td>
                                                                                                                            <td align="center" class="lnkBtnBgImg">
                                                                                                                                <asp:LinkButton ID="LinkButton2" runat="server" Text="SAVE" Enabled="false" ForeColor="Gray" Font-Size="10"
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

                                                                         <asp:Panel Width="100%" ClientIDMode="Static" Visible="false" BackColor="#DBDBDB" ID="PnlEdit" runat="server" BorderColor="#DBDBDB">
                                                                                <div>
                                                                                  <fieldset style="padding-top: 10px;  padding-bottom:7px;padding-right:10px; border:0;">
                                                                                <asp:Table id="tbl_edit_modelingObject" runat="server" width="100%" cellpadding="0"  cellspacing="0">
                                                                                  <asp:TableRow>
                                                                                   <asp:TableCell ID="TableCell2" Width="50%" runat="server">
                                                                                  <asp:Table id="Table3" runat="server" width="78%" cellpadding="0"  cellspacing="0">
                                                                                    <asp:TableRow>
                                                                                                <asp:TableCell width="150px"  VerticalAlign="top" HorizontalAlign="Left" id="TableCell22" runat="server">
                                                                                                    <asp:Label ID="lbl_edit_modeling_object" Text="Select Modeling Objects" runat="server"
                                                                                                        Font-Bold="true"></asp:Label>
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell   width="150px" HorizontalAlign="left" VerticalAlign="top">
                                                                                                    <telerik:RadComboBox ID="rcb_edit_modeling_object" Height="140" ClientIDMode="Static" runat="server" Width="200px">
                                                                                                    </telerik:RadComboBox>
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell Width="2px"  HorizontalAlign="Left">
                                                                                                
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell Width="60px" HorizontalAlign="center"  Enabled="false" style="padding-bottom: 3px;">
                                                                                                    <asp:LinkButton ID="lbtn_edit_add" runat="server" Text="Add" CssClass="lnkBtnBgImg"  Font-Size="10" Font-Names="Arial Regular"
                                                                                                        ForeColor="Black" Font-Underline="false" Height="22"></asp:LinkButton>
                                                                                                </asp:TableCell>
                                                                                                   </asp:TableRow>
                                                                                               </asp:Table>
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell Width="10%">
                                                                                                
                                                                                                </asp:TableCell>
                                                                                                <asp:TableCell HorizontalAlign="Right"  Width="12%" >
                                                                                                    <asp:Table BorderColor="0" ID="tbl_edit_copyPaste" Width="100%"  runat="server">
                                                                                                        <asp:TableRow>
                                                                                                            <asp:TableCell ColumnSpan="3" Width="45%" HorizontalAlign="Center"  BorderWidth="0px">
                                                                                                                <asp:LinkButton ID="lbtn_edit_copy" Enabled="false" runat="server"  CssClass="lnkBtnBgImg" Text="Copy" Font-Size="10" Font-Names="Arial Regular"
                                                                                                                    ForeColor="GrayText" Font-Underline="false" Height="22"></asp:LinkButton>
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell Style="width:1%">
                                                                                                            </asp:TableCell>
                                                                                                            <asp:TableCell  HorizontalAlign="Center" >
                                                                                                                <asp:LinkButton ID="lbtn_edit_paste" Enabled="false"  runat="server" CssClass="lnkBtnBgImg"  Text="Paste" Font-Size="10" Font-Names="Arial Regular"
                                                                                                                    ForeColor="GrayText" Font-Underline="false" Height="22"></asp:LinkButton>
                                                                                                            </asp:TableCell>
                                                                                                        </asp:TableRow>
                                                                                                    </asp:Table>
                                                                                                </asp:TableCell>
                                                                                              
                                                                                  </asp:TableRow>
                                                                                </asp:Table>
                                                                                              
                                                                                </fieldset>
                                                                                    <fieldset style="padding: 7px;padding-left:0px; border:0;">
                                                                                      <asp:Panel Width="99%" ClientIDMode="Static" ID="pnl_edit_attributes_table" Height="150px" ScrollBars="Vertical"
                                                                                                BackColor="White"  runat="server" BorderColor="#DBDBDB">
                                                                                        <asp:Table ID="tbl_edit_equipment_attributes" runat="server" CellPadding="0" CellSpacing="0"
                                                                                            ClientIDMode="Static" Width="97.5%" border="0">
                                                                                          
                                                                                        </asp:Table>
                                                                                            </asp:Panel>
                                                                                             <fieldset style="padding-top: 7px;border:0;">
                                                                                            <table border="0"  width="100%">
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <asp:Table ID="Table6" Width="100%" runat="server">
                                                                                                                    <asp:TableRow>
                                                                                                                        <asp:TableCell ColumnSpan="3" HorizontalAlign="Right" BorderWidth="0px">
                                                                                                                            <td align="center" class="lnkBtnBgImg">
                                                                                                                                <asp:LinkButton ID="lbtn_edit_undo" Enabled="false" runat="server" ClientIDMode="Static" Text="UNDO"  ForeColor="Black" Font-Size="10"
                                                                                                                                    Font-Names="Arial Regular" Font-Underline="false"  Height="20"></asp:LinkButton>
                                                                                                                            </td>
                                                                                                                            <td style="width: 0.5%">
                                                                                                                            </td>
                                                                                                                            <td align="center" class="lnkBtnBgImg">
                                                                                                                                <asp:LinkButton ID="lbtn_edit_save" CommandName="save"  runat="server" OnClick="OnClick_lbtn_edit_save" Text="SAVE"  ClientIDMode="Static" Enabled="true" ForeColor="Black" Font-Size="10"
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
                            </td>
                        </tr>
                    </table>
                   <%--</fieldset>--%>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <fieldset style="padding-top: 7px; border: 0;">
                        <table cellpadding="0" cellspacing="0" border="0" width="20%">
                            <tr>
                                <td>
                                <telerik:RadButton ID="radbtnSaveSelection" Width="100px" OnClick="btn_addAssetstoProject_Click" Text="Save Selection"  runat="server"></telerik:RadButton>
                                </td>
                             <td style="width:10px">&nbsp;</td>
                              <td>
                                    <%--<telerik:RadButton ID="btnRunSimulation"  Width="120px" Text="Run Simulation" runat="server" PostBackUrl="~/App/NewUI/EnergyModelingRunSimulation.aspx" ></telerik:RadButton>--%>
                                </td>
                                 <td style="width:10px">&nbsp;</td>
                              <td>
                                    <%--<telerik:RadButton ID="btn_Statements"  Width="120px" Text="Statements" runat="server" PostBackUrl="FacilityBillinsStatements.aspx" ></telerik:RadButton>--%>
                                </td>
                                <td>
                                    <%--<telerik:RadButton ID="RadButton1"  Width="120px" Text="Weather" runat="server" PostBackUrl="EnergyModelingWeather.aspx" ></telerik:RadButton>--%>
                                </td>
                               
                                 <td>
                                <%--<asp:Button ID="btn_schedules" runat="server" Width="100" Text="Assign Schedule"  PostBackUrl="~/App/NewUI/EnergyModelingSchedule.aspx"/>--%>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
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
