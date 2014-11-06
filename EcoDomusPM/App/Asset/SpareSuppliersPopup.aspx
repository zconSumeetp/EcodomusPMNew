<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SpareSuppliersPopup.aspx.cs"
    Inherits="App_Asset_SpareSuppliersPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <telerik:RadCodeBlock runat="server">
        <script type="text/javascript" language="javascript">
            //   function adjust_height() {
            //            var wnd = GetRadWindow();
            //            if (wnd != null) {
            //                var bounds = wnd.getWindowBounds();
            //                var x = bounds.x;
            //                var y = bounds.y;
            //                wnd.moveTo(x, 25);
            //            
            //                wnd.set_height(document.body.scrollHeight + 20)
            //               
            //            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }
            function adjust_frame_height() {

                //          if (document.body.scrollHeight < 500) {
                //              var obj_dv = document.getElementById("dv_space");
                //              obj_dv.style.height = "200";
                //          }
                window.parent.adjust_height();
            }

            function select_Resource() {
                var s1 = $find("<%=rg_suppliers.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                var names = "";
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("ID") + ",";
                    names = names + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("name") + ",";

                }

                if (s == "") {
                    alert("Please select supplier");
                    return false;
                }
                else {
                    var id = s.substring(0, s.length - 1);
                    var name = names.substring(0, names.length - 1);
                    if (window.parent.location.href.indexOf('TypePM') == -1) {

                        parent.document.getElementById('hf_supplier_ids').value = id;
                        parent.document.getElementById('hf_supplier_selected_names').value = name;
                        parent.document.getElementById('LblSupplierText').innerHTML = name;

                    }
                    //   window.parent.refreshgrid_new();
                    var oWnd = GetRadWindow();
                    oWnd.close();
                    return false;
                }


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
            function CloseWindow() {
                GetRadWindow().close();

                return false;
            }

        </script>
    </telerik:RadCodeBlock>
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <title></title>
    <style type="text/css">
        .gridRadPnlHeader1
        {
            background-color: Gray;
            height: 30px;
            vertical-align: middle;
        }
        .SmallTextBox
        {
            font-family: Verdana;
            font-size: 11px;
            height: 20px;
            margin-top: 10px;
            margin-bottom: 2px;
            border-top: #7F9DB9 1px solid;
            border-bottom: #7F9DB9 1px solid;
            text-align: left;
        }
        .smallsearchbtn
        {
            margin-top: 10px;
            height: 20px;
            width: 78px;
        }
        .style1
        {
            width: 185px;
        }
        
        .normalLabel1
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            font-weight: bold;
        }
        .rgcss
        {
            border-style: solid;
            margin: 0px;
            border-left-color: #DCDCDC;
            border-top-color: #DCDCDC;
            border-top-width: 0px;
            border-bottom-width: 1px;
            border-left-width: 1px;
            border-right-width: 1px;
            border-bottom-color: #A0A0A0;
            border-right-color: #B4B4B4;
        }
        .rgcss1
        {
            margin: 0px;
            border: 0;
            border-left-width: 0;
            border-bottom-width: 0;
        }
        
        div
        {
            overflow-x: hidden;
        }
        
        .SmallTextBox1
        {
            font-family: Verdana;
            font-size: 11px;
            height: 11px;
            margin-top: 10px;
            margin-bottom: 2px;
            border-top: #7F9DB9 1px solid;
            border-bottom: #7F9DB9 1px solid;
            text-align: left;
        }
        .smallsearchbtn1
        {
            margin-top: 10px;
            height: 11px;
            width: 78px;
        }
        
        .normalLabel1
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            font-weight: bold;
        }
        .style2
        {
            width: 85px;
        }
        .style3
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            font-weight: bold;
            width: 85px;
        }
        .GridDataDiv_SkinName
        {
            overflow-y: scroll !important;
        }
        
        div.RadPanelBar
        {
            width: 200px;
        }
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        
        #rg_Resources_GridData
        {
            overflow-x: hidden !important;
        }
    </style>
</head>
<body style="background-color: #EEEEEE; margin: 0; border-bottom-width: 1;">
    <form id="form1" runat="server" style="background-color: transparent; margin: 0;">
    <table style="border-color: Black; border-width: 2; background-color: #EEEEEE; width: 100%;
        margin: 0;" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:ScriptManager ID="Scriptmanager1" runat="server">
                </asp:ScriptManager>
                <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
                <table style="background-color: transparent; border-style: ridge; width: 100%; border-collapse: collapse;
                    padding: 0;" border="2" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="wizardHeadImage">
                                        <div class="wizardLeftImage">
                                            <asp:Label ID="lbl_header" Text="<%$Resources:Resource,Assign_Supplier%>" runat="server"
                                                Font-Names="Verdana" Font-Size="11pt"></asp:Label>
                                        </div>
                                        <div class="wizardRightImage">
                                            <asp:ImageButton ID="ibtn_close" runat="server" OnClientClick="javascript:return CloseWindow();"
                                                ImageUrl="~/App/Images/Icons/icon-close.png" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table style="padding-left: 25px; padding-right: 25px; width: 100%;">
                    <tr>
                        <td>
                            <fieldset style="border-width: 0px; border-top-width: 0px; margin-top: 20px; border-top-color: transparent;
                                border-right-color: #B4B4B4; border-bottom-style: outset">
                                <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" BorderWidth="0"
                                    ExpandMode="MultipleExpandedItems" BorderColor="Transparent">
                                    <ExpandAnimation Type="OutSine" />
                                    <Items>
                                        <telerik:RadPanelItem Expanded="true" Width="100%" Text="Suppliers" IsSeparator="false"
                                            BorderWidth="0" BorderColor="Transparent">
                                            <HeaderTemplate>
                                                <asp:Panel ID="pnl_job" runat="server" DefaultButton="btn_searchimg" BorderWidth="0"
                                                    Width="100%" BorderColor="Transparent">
                                                    <table id="tbl_jobs" cellpadding="0" cellspacing="0" class="gridRadPnlHeader1" runat="server"
                                                        width="100%">
                                                        <tr>
                                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                                <asp:Label runat="server" Text="<%$Resources:Resource,Supplier%>" ID="lbl_grid_head" CssClass="gridHeadText"
                                                                    Width="200px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                                            </td>
                                                            <td align="right" onclick="stopPropagation(event)">
                                                                <div id="div_search" onclick="stopPropagation(event)" style="background-color: White;
                                                                    width: 170px;">
                                                                    <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                                        width: 100%;">
                                                                        <tr style="border-spacing=0px;">
                                                                            <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                                                padding-bottom: 0px;">
                                                                                <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                                    Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="100%">
                                                                                </telerik:RadTextBox>
                                                                            </td>
                                                                            <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                                                padding-bottom: 0px;">
                                                                                <asp:ImageButton ClientIDMode="Static" ID="btn_searchimg" Height="13px" runat="server"
                                                                                    ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btn_searchimg_Click" />
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
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td>
                                                            <telerik:RadGrid ID="rg_suppliers" runat="server" AllowPaging="true" PageSize="10"
                                                                Width="99.7%" BorderColor="Gray" CellPadding="0" AutoGenerateColumns="false"
                                                                AllowSorting="true" AllowMultiRowSelection="false" GridLines="None" CellSpacing="0"
                                                                PagerStyle-AlwaysVisible="true" OnPageIndexChanged="rg_Resources_PageIndexChanged"
                                                                OnPageSizeChanged="rg_Resources_PageSizeChanged" OnSortCommand="rg_Resources_SortCommand"
                                                                OnItemDataBound="rg_Resources_ItemDataBound">
                                                                <ClientSettings AllowColumnsReorder="true" ReorderColumnsOnClient="true">
                                                                    <Selecting AllowRowSelect="true" />
                                                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="280px" />
                                                                </ClientSettings>
                                                                <MasterTableView DataKeyNames="ID" Name="rgJob" ClientDataKeyNames="ID,name" EditMode="EditForms"
                                                                    TableLayout="Auto" GroupLoadMode="Client" CellPadding="0" CellSpacing="0" GridLines="None"
                                                                    HeaderStyle-CssClass="gridHeaderBoldText">
                                                                    <PagerStyle BorderWidth="1" BorderColor="Gray" Mode="NextPrevAndNumeric" AlwaysVisible="false" />
                                                                    <Columns>
                                                                        <telerik:GridClientSelectColumn>
                                                                            <ItemStyle Width="25px" Wrap="false" />
                                                                            <HeaderStyle Width="25px" Wrap="false" />
                                                                        </telerik:GridClientSelectColumn>
                                                                        <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Supplier%>"
                                                                            UniqueName="Supplier">
                                                                            <HeaderStyle Wrap="false" />
                                                                            <ItemStyle CssClass="column" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="ID" Visible="false" UniqueName="ID">
                                                                            <ItemStyle CssClass="column" />
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                    <EditFormSettings ColumnNumber="2" EditFormType="AutoGenerated" CaptionFormatString="Edit Job :"
                                                                        FormMainTableStyle-BorderStyle="Solid" FormMainTableStyle-BorderColor="#999999"
                                                                        FormMainTableStyle-BorderWidth="1px">
                                                                        <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                                                        <FormCaptionStyle CssClass="column"></FormCaptionStyle>
                                                                        <FormMainTableStyle GridLines="None" BackColor="White" Width="100%" />
                                                                        <FormTableStyle BackColor="White" Height="25px" />
                                                                        <FormTableAlternatingItemStyle Wrap="true"></FormTableAlternatingItemStyle>
                                                                        <EditColumn ButtonType="ImageButton" UpdateText="Update record" UniqueName="EditCommandColumn1"
                                                                            CancelText="Cancel edit">
                                                                        </EditColumn>
                                                                        <EditColumn UniqueName="EditColumn">
                                                                        </EditColumn>
                                                                        <FormTableButtonRowStyle HorizontalAlign="Right" CssClass=""></FormTableButtonRowStyle>
                                                                    </EditFormSettings>
                                                                    <PagerStyle AlwaysVisible="True" />
                                                                </MasterTableView>
                                                                <EditItemStyle BorderStyle="None" />
                                                                <HeaderStyle BorderWidth="0px" />
                                                                <PagerStyle AlwaysVisible="True" />
                                                                <FilterMenu EnableImageSprites="False">
                                                                </FilterMenu>
                                                                <ClientSettings>
                                                                    <Selecting AllowRowSelect="true" />
                                                                    <ClientEvents />
                                                                </ClientSettings>
                                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                                                </HeaderContextMenu>
                                                            </telerik:RadGrid>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </telerik:RadPanelItem>
                                    </Items>
                                </telerik:RadPanelBar>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnAssign" runat="server" Text="<%$Resources:Resource,Assign%>" CausesValidation="false"
                                                Width="100px" OnClick="btnAssign_Click" OnClientClick="javascript:return select_Resource();" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btn_Close" runat="server" Text="<%$Resources:Resource,Close%>" CausesValidation="false"
                                                OnClientClick="javascript:return CloseWindow();" Width="100px" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hftype_id" runat="server" />
                <asp:HiddenField ID="hfjob_id" runat="server" />
                <asp:HiddenField ID="hf_category_id" runat="server" />
                <asp:HiddenField ID="hfScreenResolution" runat="server" ClientIDMode="Static" Value="0" />
                <asp:HiddenField ID="hf_is_loaded" runat="server" Value="No" />
                <asp:HiddenField ID="hf_resource_ids" runat="server" />
                <asp:HiddenField ID="hf_jobedit" ClientIDMode="Static" runat="server" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
