<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddSelectManufacturerpopup.aspx.cs"
    Inherits="App_Asset_AddSelectManufacturerpopup" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--<title>EcoDomus PM</title>--%>
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
        <script language="javascript" type="text/javascript">
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

                //window.parent.refreshgrid_new();
                var rdw = GetRadWindow();

                GetRadWindow().close();
                window.parent.resizeParentPopupReversBack();
                return false;
                //self.close();
            }
            function togggle_div() {
                // debugger
                document.getElementById('div_assignedManufacturer').style.display = 'inline'
                document.getElementById('div_addManufacturer').style.display = 'none'
                return false;

            }


            function clear_txt() {
                document.getElementById("txtSearch").value = "";
                return false;
            }
            function select_Sub_System(id, name,flag_name) {

                if (flag_name == "Warranty_Labor") {
                    if (window.parent.location.href.indexOf('TypePM') == -1) {
                        parent.document.getElementById('hf_WarrantyGarantyLabor_id').value = id;
                        //  parent.document.getElementById('hf_manufaturer_selected_name').value = name;
                        parent.document.getElementById('lblWarrantyGuarantorLabor').innerHTML = name;

                    }

                }
                else if (flag_name == "Warranty_Parts") {
                    if (window.parent.location.href.indexOf('TypePM') == -1) {
                        parent.document.getElementById('hf_WarrantyGarantyPart_id').value = id;
                        // parent.document.getElementById('hf_manufaturer_selected_name').value = name;
                        parent.document.getElementById('lblWarrantyGuarantorParts').innerHTML = name;

                    }
                }
                else {
                    if (window.parent.location.href.indexOf('TypePM') == -1) {
                        parent.document.getElementById('hf_man_org_id').value = id;
                        parent.document.getElementById('hf_manufaturer_selected_name').value = name;
                        parent.document.getElementById('lblmanufacturer').innerHTML = name;

                    }
                }

                window.parent.refreshgrid_new();
                var oWnd = GetRadWindow();
                oWnd.close();
                window.parent.resizeParentPopupReversBack();
                return false;
                // var rdw = GetRadWindow();
                // rdw.BrowserWindow.load_manufacturer(name, id);
                // rdw.close();

            }
            function assignmanufacturer() {
                alert("Please Select Manufacturer");
            }
            function adjust_height() {

                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    //alert(x);
                    //alert(y);
                    //  if (x == 0)
                    wnd.moveTo(x , 10);

                    wnd.set_height(document.body.scrollHeight + 40)
                    //  wnd.set_width(document.body.scrollWidth )

                }

            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }
            function Assign_manufacturer() {
                var s1 = $find("<%=RgManufacturers.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var id = "";
                var name = "";
                for (var i = 0; i < selectedRows.length; i++) {
                    id = id + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("pk_organization_id");
                    name = name + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("name");
                }

                if (id == "") {
                    alert("Please select manufacturer");
                    return false;
                }
                else {
                    var flag_name="";
                    if (document.getElementById('hf_flag_name')!=null)
                        flag_name = document.getElementById('hf_flag_name').value;

                    if (flag_name == "Warranty_Labor") {
                        if (window.parent.location.href.indexOf('TypePM') == -1) {
                            parent.document.getElementById('hf_WarrantyGarantyLabor_id').value = id;
                            parent.document.getElementById('hf_WarrantyGarantyLabor').value = name;
                            parent.document.getElementById('lblWarrantyGuarantorLabor').innerHTML = name;

                        }

                    }
                    else if (flag_name == "Warranty_Parts") {
                        if (window.parent.location.href.indexOf('TypePM') == -1) {
                            parent.document.getElementById('hf_WarrantyGarantyPart_id').value = id;
                            parent.document.getElementById('hf_WarrantyGarantyPart').value = name;
                            parent.document.getElementById('lblWarrantyGuarantorParts').innerHTML = name;

                        }
                    }
                    else {
                        if (window.parent.location.href.indexOf('TypePM') == -1) {
                            parent.document.getElementById('hf_man_org_id').value = id;
                            parent.document.getElementById('hf_manufaturer_selected_name').value = name;
                            parent.document.getElementById('lblmanufacturer').innerHTML = name;

                            parent.document.getElementById('hf_WarrantyGarantyLabor_id').value = id;
                            parent.document.getElementById('hf_WarrantyGarantyLabor').value = name;
                            parent.document.getElementById('lblWarrantyGuarantorLabor').innerHTML = name;

                            parent.document.getElementById('hf_WarrantyGarantyPart_id').value = id;
                            parent.document.getElementById('hf_WarrantyGarantyPart').value = name;
                            parent.document.getElementById('lblWarrantyGuarantorParts').innerHTML = name;

                        }
                    }
                    window.parent.refreshgrid_new(flag_name);
                    var oWnd = GetRadWindow();
                    oWnd.close();
                    window.parent.resizeParentPopupReversBack();
                    return false;
                }
            }
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();

            }
            function stopPro(e) {
                adjust_height_width();

            }
            var previous = "";
            function adjust_height_width() {


                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    if (previous == "") {
                        wnd.set_height(document.body.scrollHeight - 260)
                        previous = "1";
                    }
                    else {

                        wnd.set_height(document.body.scrollHeight + 370)
                        previous = "";
                    }
                    //  wnd.set_width(document.body.scrollWidth )
                }

            }

            window.onload = adjust_height;
        </script>
    </telerik:RadCodeBlock>
</head>
<body style="background-color: #EEEEEE; padding: 0px; margin: 0px 0px 0px 0px;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" Skin="Default" DecoratedControls="Buttons,Scrollbars" />
    <div>
        <table width="100%" border="0">
            <%--<tr>
                <td class="wizardHeadImage">
                    <div class="wizardLeftImage">
                        <asp:Label ID="lbl_header" Text="<%$Resources:Resource,Assign_Manufacturer%>" Font-Names="Verdana"
                            Font-Size="11pt" runat="server"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClientClick="javascript:return closeWindow();" />
                    </div>
                </td>
            </tr>--%>
            <tr>
                <td>
                    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="padding-left: 10px;
                        padding-right: 10px;">
                        <tr>
                            <td height="10px">
                            </td>
                        </tr>
                        <tr align="center">
                            <td align="right">
                                <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" BorderWidth="0"
                                    ExpandMode="MultipleExpandedItems" BorderColor="Transparent">
                                    <ExpandAnimation Type="OutSine" />
                                    <Items>
                                        <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                                            BorderWidth="0" BorderColor="Transparent">
                                            <HeaderTemplate>
                                                <asp:Panel ID="pnl_job" runat="server" DefaultButton="btn_search" BorderWidth="0"
                                                    Width="100%" BorderColor="Transparent">
                                                    <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                                        <tr>
                                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                                <asp:Label runat="server" Text="<%$Resources:Resource, Assign_Manufacturer%>" ID="lbl_grid_head"
                                                                    CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Font-Names="Arial"
                                                                    Font-Size="12"></asp:Label>
                                                            </td>
                                                            <td align="right" onclick="stopPropagation(event)">
                                                                <div id="div_search" style="background-color: White; width: 170px;" onclick="stopPropagation(event)">
                                                                    <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                                        width: 100%;">
                                                                        <tr style="border-spacing=0px;">
                                                                            <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                                                padding-bottom: 0px;">
                                                                                <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                                    Height="100%" EmptyMessage="Search" BorderColor="White" ID="txt_search" Width="100%">
                                                                                </telerik:RadTextBox>
                                                                            </td>
                                                                            <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                                                padding-bottom: 0px;">
                                                                                <asp:ImageButton ClientIDMode="Static" OnClick="btn_search_Click" ID="btn_search"
                                                                                    Height="13px" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                                                    Style="width: 13px" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                            <td align="right" class="dropDownImage" style="padding:6px;"  onclick="stopPropagation(event)">
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
                                    <telerik:RadGrid ID="RgManufacturers" runat="server" PageSize="10" AllowPaging="True"
                                        AutoGenerateColumns="false" OnPageIndexChanged="RgManufacturers_OnPageIndexChanged"
                                        ItemStyle-Wrap="false" OnPageSizeChanged="RgManufacturers_OnPageSizeChanged"
                                        OnSortCommand="RgManufacturers_OnSortCommand" AllowSorting="True" PagerStyle-AlwaysVisible="true"
                                        Width="100%" GridLines="None" Skin="Default">
                                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" PageButtonCount="5" />
                                        <ClientSettings>
                                            <Selecting AllowRowSelect="true" />
                                            <Scrolling AllowScroll="true" ScrollHeight="332"  UseStaticHeaders="false"  />
                                        </ClientSettings>
                                        <MasterTableView ClientDataKeyNames="pk_organization_id,name" DataKeyNames="pk_organization_id,name"
                                            GridLines="None">
                                         <ItemStyle Height="18px" />
                                         <HeaderStyle Height="18px" />
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="pk_organization_id" Visible="false">
                                                    <ItemStyle CssClass="column" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridClientSelectColumn>
                                                    <ItemStyle Width="2%" Wrap="false" />
                                                    <HeaderStyle Width="2%" Wrap="false" />
                                                </telerik:GridClientSelectColumn>
                                                <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Manufacturer_Name%>">
                                                    <ItemStyle Width="95%" Wrap="false" />
                                                    <HeaderStyle Width="95%" Wrap="false" />
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
                </td>
            </tr>
            <tr>
                <td>
                    <table style="padding-left: 8px; padding-right: 10px;">
                        <tr>
                            <td>
                                <asp:Button ID="btnAssign" runat="server" Text="<%$Resources:Resource,Assign%>" Width="100px"
                                    TabIndex="4" OnClick="btnAssign_Click" OnClientClick="javascript:return Assign_manufacturer();" />
                            </td>
                            <td style="width: 2px;">
                            </td>
                            <td>
                                <asp:Button ID="btnClose" runat="server" Text="<%$Resources:Resource,Close%>" Width="100px"
                                    OnClientClick="javascript:return closeWindow();" TabIndex="5" ValidationGroup="my_validation" />
                            </td>
                            <td style="width: 2px;">
                            </td>
                            <td>
                                <asp:Button ID="btnAddManufacturer" runat="server" Text="<%$Resources:Resource,Add_Manufacturer%>"
                                    Width="140px" TabIndex="4" OnClick="btnAddManufacturer_Click1" />
                                    
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="div_addManufacturer" runat="server" style="margin-left: 20px">
        <telerik:RadGrid ID="rgResources" runat="server" AllowPaging="True" AllowSorting="True"
            OnItemDataBound="rgAddResources_ItemDataBound1" AutoGenerateColumns="False" BorderWidth="1px"
            OnPageIndexChanged="rgAddResources_PageIndexChanged" OnSortCommand="rgAddResources_SortCommand"
            OnPageSizeChanged="rgAddResources_PageSizeChanged" CellPadding="0" GridLines="None"
            PagerStyle-AlwaysVisible="true" PageSize="20" Skin="Default" Width="100%" CellSpacing="0">
            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
            <MasterTableView DataKeyNames="organization_id">
                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                </RowIndicatorColumn>
                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                </ExpandCollapseColumn>
                <Columns>
                    <%-- <telerik:GridButtonColumn ButtonType="LinkButton" HeaderText="Name" DataTextField="OrganizationName"
                                    ItemStyle-Font-Underline="true" CommandName="EditOrganization" CommandArgument="sel"
                                    SortExpression="OrganizationName">
                                    <ItemStyle CssClass="column" Font-Underline="true" Width="150px" />
                                </telerik:GridButtonColumn>--%>
                    <telerik:GridBoundColumn DataField="OrganizationName" HeaderText="<%$Resources:Resource,Name%>"
                        UniqueName="OrganizationName">
                        <ItemStyle CssClass="column"></ItemStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CityState" HeaderText="<%$Resources:Resource,City_State%>"
                        UniqueName="CityState">
                        <ItemStyle CssClass="column"></ItemStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PrimaryContact" HeaderText="<%$Resources:Resource,Primary_Contact%>"
                        UniqueName="PrimaryContact">
                        <ItemStyle CssClass="column"></ItemStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PhoneNumber" HeaderText="<%$Resources:Resource,Phone%>"
                        UniqueName="PhoneNumber">
                        <ItemStyle CssClass="column" Width="150px"></ItemStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Email_Address" HeaderText="<%$Resources:Resource,Email%>"
                        UniqueName="Email">
                        <ItemStyle CssClass="column"></ItemStyle>
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn>
                        <ItemTemplate>
                            <asp:Button ID="btn" runat="server" Text="<%$Resources:Resource,Request_Pending%>"
                                Width="180px" OnClick="btn_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"organization_id") %>' />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn>
                        <ItemTemplate>
                            <asp:Label ID="lblPrimaryContact" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"PrimaryContact1")%>'
                                Visible="false" Width="0px" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn>
                        <ItemTemplate>
                            <asp:Label ID="lblColor" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Color")%>'
                                Visible="false" Width="0px" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                    </EditColumn>
                </EditFormSettings>
                <PagerStyle AlwaysVisible="True"></PagerStyle>
            </MasterTableView>
            <AlternatingItemStyle CssClass="alternateColor" />
            <FilterMenu EnableImageSprites="False">
            </FilterMenu>
            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Black">
            </HeaderContextMenu>
        </telerik:RadGrid>
        <asp:Button ID="btnBack" runat="server" Text="<%$Resources:Resource,Back%>" Width="100px"
            TabIndex="5" ValidationGroup="my_validation" OnClick="btnBack_Click" />&nbsp;&nbsp;
            
    </div>
    <asp:Label ID="lbl_msg" runat="server" Visible="false"></asp:Label>
    <asp:HiddenField ID="hf_flag_name" runat="server" Value="" />
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="organizationsManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btn_search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgManufacturers" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RgManufacturers">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgManufacturers" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
