<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Spaces.aspx.cs" Inherits="App_Locations_Spaces" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>EcoDomus PM - Spaces</title>
    
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
        <script type="text/javascript" language="javascript">
            function resize_Nice_Scroll() {

                $(".divScroll").getNiceScroll().resize();
            }

            function body_load() {

                var screenhtg = parseInt(window.screen.height * 0.65);
            
            }
            window.onload = body_load;

            function RightMenu_expand_collapse(index) {

                var img = document.getElementById("RightMenu_" + index + "_img_expand_collapse");
                $('.RightMenu_' + index + '_Content').toggle();
                if (img.src.indexOf("asset_carrot_up") != -1) {
                    img.src = img.src.replace("asset_carrot_up", "asset_carrot_down");
                }
                else {
                    img.src = img.src.replace("asset_carrot_down", "asset_carrot_up");
                }
                $(".divScroll").getNiceScroll().resize();
            }
            function doClick(buttonName, e) {
                //the purpose of this function is to allow the enter key to 
                //point to the correct button to click.
                var key;

                if (window.event)
                    key = window.event.keyCode;     //IE
                else
                    key = e.which;     //firefox

                if (key == 13) {
                    //Get the button the user wants to have clicked
                    var btn = document.getElementById(buttonName);
                    if (btn != null) { //If we find the button click it
                        btn.click();
                        event.keyCode = 0
                    }
                }
            }
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            function clearText() {
                document.getElementById("txtSearchText").value = "";

            }

            function deleteSpace() {
                var flag;
                flag = confirm("Do you want to delete this Space?");
                return flag;
            }

            function NavigateToFindLocation(id) {

                //top.location.href = "../Locations/FacilityMenu.aspx?pagevalue=Profile&id=" + document.getElementById('hf_location_id').value + "&profileflag=new";
                var url = "../Locations/FacilityMenu.aspx?pagevalue=Space Profile&id=" + id + "&profileflag=new";
                parent.location.href(url);
            }
            function AssignSpace_popup() {
                var url = "../Locations/AssignSpace.aspx?id=" + document.getElementById('hf_zone_id').value;
                manager = $find("<%= rad_window.ClientID %>");
                var windows = manager.get_windows();
                windows[0].show();
                windows[0].setUrl(url);
                //windows[0].set_modal(false);
                return false;
            }

            function buttoncallback_Zone() {

                document.getElementById("btnselect1").click();
            }

            function navigate_space() {
                var url = "../locations/facilitymenu.aspx?pagevalue=Space Profile&id=" + document.getElementById('hf_location_id').value;
                parent.location.href(url);
                //parent.window.location.href(url);
            }
            function navigate_space_floor(floor_id) {
                var url = "../locations/facilitymenu.aspx?pagevalue=Space Profile&id=" + document.getElementById('hf_location_id').value + "&floor_id=" + floor_id;
                parent.location.href(url);
                //parent.window.location.href(url);
            }

            function validate() {
                var RadGrid1 = $find("<%=rgSpaces.ClientID %>");
                var masterTable = $find("<%= rgSpaces.ClientID %>").get_masterTableView();
                var row = masterTable.get_dataItems().length;
                var cnt = 0;
                for (var i = 0; i < row; i++) {
                    var row1 = masterTable.get_dataItems()[i];
                    if (row1.get_selected()) {
                        cnt = cnt + 1;
                        //return true;
                        //return true;
                    }


                }
                if (cnt != 0) {

                    var flag;
                    flag = confirm("Do you want to delete this space?");
                    return flag;
                    //return true;
                }
                else {
                    alert("Please select space");
                    return false;

                }

                //alert("Please select at least one zone to delete.");

            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }
            function resize_frame_page() {
                //window.resizeTo(1000, height);

                var docHeight;
                try {
                    var obj = parent.window.frames[1];
                    if (obj != null) {

                        window.parent.resize_iframe(parent.window.frames[1]);

                    }
                }
                catch (e) {
                    window.status = 'Error: ' + e.number + '; ' + e.description;
                }

            }

            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {
                //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
                var pageSize = document.getElementById("hfDocumentPMPageSize").value;
                var scrollArea = sender.GridDataDiv;
                var dataHeight = sender.get_masterTableView().get_element().clientHeight;

                if (dataHeight < parseInt(pageSize) * 40) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
                }

            }

        </script>
    </telerik:RadCodeBlock>
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" style="margin: 0 0 0 0" defaultfocus="txtSearchText">
   <telerik:RadScriptManager ID="ScriptManager1" runat="server" >
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <style>
                  
            .divProperties
                {
                    background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
                }
            .rpbItemHeader
             {
            background-color:#808080;
             }
              iframe
            {
                overflow:hidden;
            }
    </style>
    <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div style="width: 100%;">
        <asp:Panel ID="panelSearch" runat="server">
            <table width="100%" style="table-layout:fixed;">
                <tr>
                    <td class="centerAlign" style="width:100%">
                        <asp:Button ID="btnAssignSpace" runat="server" Text="<%$Resources:Resource, Assign_Space%>"
                            skin="Default" Width="90" OnClientClick="javascript:return AssignSpace_popup();"
                            OnClick="btnAssignSpace_Click" />
                      
                        <asp:Button ID="btn_space" runat="server" SkinID="Default" OnClick="btn_space_click"
                            Text="<%$Resources:Resource, Add_Space%>" />
                        <asp:Button ID="btnDelete" runat="server" SkinID="Default" OnClick="btnDelete_click"
                            OnClientClick="javascript:return validate();" Text="<%$Resources:Resource, Delete%>"
                            Width="60px" />
                        <asp:Button ID="btnUnAssignSpace" runat="server" Visible="false" Text="<%$Resources:Resource, Unassign_Space%>"
                            skin="Default" Width="100" OnClick="btnUnAssignSpace_Click" />
                            <asp:HiddenField ID="hfDocumentPMPageSize"  runat="server" Value="" />
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lblMsg"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="centerAlign" style="width:100%">

                         <div class="rpbItemHeader">
                             <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                                 <tr>
                                     <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width: 35%;">
                                         <asp:Label runat="server" Text="<%$Resources:Resource,Spaces%>" ID="lbl_grid_head"
                                             CssClass="gridHeadText" Width="100px" ForeColor="#F8F8F8" Font-Names="Arial"
                                             Font-Size="12"></asp:Label>
                                     </td>
                                     <td id="Td1" onclick="stopPropagation(event)" visible="false" runat="server">
                                         <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Facility_Name%>"
                                             CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10">:</asp:Label>
                                         :<asp:Label runat="server" ID="lblFacilityName" CssClass="Label" Visible="false"></asp:Label>
                                     </td>
                                     <td id="Td2" runat="server" visible="false">
                                         <asp:Label ID="lblzone" runat="server" Text="<%$Resources:Resource,  Zone_Name%>"
                                             CssClass="LabelText"></asp:Label>
                                         <asp:Label ID="lblzonename" runat="server" CssClass="LabelText"></asp:Label>
                                     </td>
                                     <td>
                                         <div id="divFloorDropDown" runat="server" style="display: none">
                                             <asp:Label ID="lblFloorName" Text="<%$Resources:Resource,  Floor_Name%>" CssClass="LabelText"
                                                 runat="server" Visible="true"></asp:Label>
                                             <telerik:RadComboBox ID="rcbFloors" runat="server" Filter="Contains" Width="185px">
                                             </telerik:RadComboBox>
                                         </div>
                                     </td>
                                     <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                         onclick="stopPropagation(event)">
                                         <div id="div1" style="width: 200px; background-color: white;" >
                                             <table>
                                                 <tr>
                                                     <td>
                                                         <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                             Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearchText" Width="180px">
                                                         </telerik:RadTextBox>
                                                     </td>
                                                     <td>
                                                         <asp:ImageButton ClientIDMode="Static" ID="btnSearch" Height="13px" runat="server"
                                                             ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnSearch_Click" />
                                                     </td>
                                                 </tr>
                                             </table>
                                         </div>
                                     </td>
                                     <td align="right" style="padding: 4px 6px 0 0; width: 10px;">
                                         <%--  <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                     </td>
                                 </tr>
                             </table>
                    </div>
                     <div id="divSelectedDomponentContent" >
                     <telerik:RadGrid ID="rgSpaces"  runat="server" BorderWidth="1px" CellPadding="0"
                                            AllowPaging="true" PageSize="10" AutoGenerateColumns="False" AllowSorting="True"
                                            PagerStyle-AlwaysVisible="true" Skin="Default" OnItemCommand="rgSpace_ItemCommand"
                                            AllowMultiRowSelection="true" OnPageIndexChanged="rgSpace_PageIndexChanged" OnPageSizeChanged="rgSpace_PageSizeChanged"
                                            OnSortCommand="rgSpace_SortCommand" ItemStyle-Wrap="false" OnItemDataBound="rgSpaces_OnItemDataBound">
                                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" />
                                            <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                                <Selecting AllowRowSelect="true" />
                                              <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"     ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                               <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="400" />
                                              <ClientEvents OnGridCreated="GridCreated"  />
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="space_id">
                                                   <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10"  />
                                <AlternatingItemStyle Height="31px"  Font-Names="Arial" Font-Size="10" />
                                 <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                            <FooterStyle Height="25px" Font-Names="Arial"/>
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="space_id" HeaderText="space_id" UniqueName="space_id"
                                                        Visible="False">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridClientSelectColumn>
                                                        <ItemStyle Width="3%" Wrap="false" />
                                                        <HeaderStyle Width="3%" Wrap="false" />
                                                    </telerik:GridClientSelectColumn>
                                                    <telerik:GridTemplateColumn DataField="space_name" UniqueName="space_name" HeaderText="<%$Resources:Resource,  Space_Name%> "
                                                        SortExpression="space_name">
                                                        <ItemStyle  Wrap="false" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="hlnkSpaceName" CommandName="profile" Text='<%# DataBinder.Eval(Container.DataItem,"space_name")%>'
                                                                runat="server">
                                                            </asp:LinkButton>
                                                            <%--
                                             Target="_blank">
                                            NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"file_path")%>'

                                                            --%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="floor_name" HeaderText="<%$Resources:Resource,  Floor%>"
                                                        UniqueName="floor_name">
                                                        <ItemStyle  Wrap="false" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="space_desc" HeaderText="<%$Resources:Resource,  Description%>"
                                                        UniqueName="space_desc">
                                                        <ItemStyle  Wrap="false" />
                                                    </telerik:GridBoundColumn>
                                                    <%--<telerik:GridTemplateColumn DataField="space_id" UniqueName="space_id" Visible="true">
                                        <ItemStyle CssClass="column" Width="5%" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deleteSpace"
                                                ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return deleteSpace();" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>--%>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                     </div>
                    </td>
                </tr>
                <tr style="height: 20px">
                    <td>
                    </td>
                </tr>
                
            </table>
        </asp:Panel>
        <asp:HiddenField ID="hf_location_id" runat="server" />
        <asp:HiddenField ID="hf_zone_id" runat="server" />
        <asp:HiddenField ID="hf_selected_id" runat="server" />
        <asp:HiddenField ID="hf_selected_name" runat="server" />
        <asp:HiddenField ID="hf_zone_name" runat="server" />
    </div>
    <telerik:RadWindowManager Visible="true" ID="rad_window" VisibleStatusbar="false"
         AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false"
        runat="server" KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_spaces_popup" runat="server" Animation="Slide"
                Behaviors="Move, Resize" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="false"
                AutoSize="false" Width="700" Height="500" VisibleStatusbar="false" VisibleOnPageLoad="false" Top="15px" Left="180px"
                Skin="">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <div style="display: none">
        <asp:Button ID="btnselect1" Name="btnselect" runat="server" OnClick="btnselect1_Click" />
    </div>
    <telerik:RadAjaxManager ID="my_pa" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgSpaces" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgSpaces">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgSpaces" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
