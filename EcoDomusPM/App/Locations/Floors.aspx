<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Floors.aspx.cs" Inherits="App_Locations_Floors" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>EcoDomus FM - Floors</title>
    
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
        <script type="text/javascript" language="javascript">

            function resize_Nice_Scroll() {

               
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


            function clearText() {
                document.getElementById("txtSearchText").value = "";

            }

            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {
                //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
                var pageSize = document.getElementById("hfDocumentPMPageSize").value;
                var scrollArea = sender.GridDataDiv;
                var dataHeight = sender.get_masterTableView().get_element().clientHeight;
                //sender.get_masterTableView().set_pageSize(pageSize);
                if (dataHeight < parseInt(pageSize) * 40) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
                }

            }


            function deleteFloor() {
                var RadGrid1 = $find("<%=rgFloors.ClientID %>");
                var masterTable = $find("<%= rgFloors.ClientID %>").get_masterTableView();
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
                    flag = confirm("Do you want to delete this floor?");
                    return flag;
                    //return true;
                }
                else {
                    alert("Please select floor");
                    return false;

                }



            }

            function NavigateToFindLocation(id) {

                // top.location.href = "../Locations/FacilityMenu.aspx?pagevalue=Floor Profile&id=" + document.getElementById('hf_location_id').value;
                var url = "../Locations/FacilityMenu.aspx?pagevalue=Floor Profile&id=" + id + "&profileflag=new";
                parent.location.href(url);
            }


            function navigate_floor() {
                var url = "../locations/facilitymenu.aspx?pagevalue=Floor Profile&id=" + document.getElementById('hf_location_id').value;
                parent.location.href(url);
                //parent.window.location.href(url);
            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

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
        </script>

    </telerik:RadCodeBlock>
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; ">
  <form id="form1" runat="server" style="" defaultfocus="txtSearchText">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" >
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <style type="text/css" runat="server" >
          
            html
            {                   
               overflow-y:hidden;
               -ms-overflow-x:auto;
              
            }
            
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
        
            <table width="100%" style="table-layout : fixed ;">
            <tr>
                    <td>
                        <asp:Button ID="btn_floor" runat="server" Text="<%$Resources:Resource, Add_Floor%>"
                            OnClick="btn_floor_Click" />
                        <asp:Button ID="btnDelete" runat="server" SkinID="Hay" OnClientClick="javascript:return deleteFloor()"
                            OnClick="btnDelete_click" Text="<%$Resources:Resource, Delete%>" Width="60px" />
                            <asp:HiddenField ID="hfDocumentPMPageSize"  runat="server" Value="" />
                    </td>
                </tr>
                <tr>
                   <td style="width: 100%; " class="centerAlign">
                    <div class="rpbItemHeader">
                     <table cellpadding="0" cellspacing="0" width="100%" style="background-color:#808080;">
                        <tr>
                            <td align="left" class="entityImage" style="width:35%;">
                              <asp:Label runat="server" Text="<%$Resources:Resource,Floors%>" ID="lbl_grid_head"
                                                            CssClass="gridHeadText" Width="100px" ForeColor="#F8F8F8" Font-Names="Arial"
                                                            Font-Size="12"></asp:Label>
                            </td>
                             <td id="Td1"  visible="false" runat="server">
                                                        <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Facility_Name%>"
                                                            CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10">:</asp:Label>
                                                        :<asp:Label runat="server" ID="lblFacilityName" CssClass="Label" Visible="false"></asp:Label>
                             </td>  
                              <td align="right" style=" background-color:#808080;padding-top: 02px; padding-bottom: 02px;" >
                                <div id="div1" style="width: 200px; background-color: white;" >
                                    <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch"> 
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
                                    </asp:Panel>
                                </div>
                            </td>
                            <td align="right" style="padding: 4px 6px 0 0;width:10px;" >
                               <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />
                                --%>  
                            </td>
                        </tr>
                    </table>
                    </div>
                     <div id="divSelectedDomponentContent" >
                         <telerik:RadGrid ID="rgFloors"  runat="server" BorderWidth="1px" CellPadding="0"
                             AllowPaging="true" PageSize="10" AutoGenerateColumns="False" AllowSorting="True"
                             PagerStyle-AlwaysVisible="true" Skin="Default" OnItemCommand="rgFloor_ItemCommand"
                             AllowMultiRowSelection="true" OnPageIndexChanged="rgFloor_PageIndexChanged" OnPageSizeChanged="rgFloor_PageSizeChanged"
                             OnSortCommand="rgFloor_SortCommand" ItemStyle-Wrap="false" OnItemDataBound="rgFloors_OnItemDataBound"
                             ItemStyle-Height="20px">
                             <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                             <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                 <Selecting AllowRowSelect="true" />
                                 <ClientEvents OnGridCreated="GridCreated" />
                                 <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="400" />
                             </ClientSettings>
                             <MasterTableView DataKeyNames="floor_id">
                                <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10"  />
                                <AlternatingItemStyle Height="31px"  Font-Names="Arial" Font-Size="10" />
                                 <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                <FooterStyle Height="25px" Font-Names="Arial"/>
                                 <Columns>
                                     <telerik:GridBoundColumn DataField="floor_id" HeaderText="floor_id" UniqueName="floor_id"
                                         Visible="False">
                                     </telerik:GridBoundColumn>
                                     <telerik:GridClientSelectColumn>
                                         <ItemStyle Width="5%" Wrap="false" />
                                         <HeaderStyle Width="5%"  Wrap="false"/>
                                     </telerik:GridClientSelectColumn>
                                     <telerik:GridTemplateColumn DataField="floor_name" UniqueName="floor_name" HeaderText="<%$Resources:Resource,  Floor_Name%>"
                                         SortExpression="floor_name">
                                         <ItemStyle  Width="30%" Wrap="false" />
                                         <HeaderStyle  Width="30%" Wrap="false" />
                                         <ItemTemplate>
                                             <asp:LinkButton ID="hlnkFloorName" CommandName="profile" Text='<%# DataBinder.Eval(Container.DataItem,"floor_name")%>'
                                                 runat="server">
                                             </asp:LinkButton>
                                         </ItemTemplate>
                                     </telerik:GridTemplateColumn>
                                     <telerik:GridBoundColumn DataField="floor_desc" HeaderText="<%$Resources:Resource,  Description%>"
                                         UniqueName="floor_desc">
                                         <ItemStyle  Width="50%" Wrap="false" />
                                          <HeaderStyle  Width="50%" Wrap="false" />
                                     </telerik:GridBoundColumn>
                                     <%--<telerik:GridTemplateColumn DataField="floor_id" UniqueName="floor_id" Visible="true">
                                        <ItemStyle CssClass="column" Width="5%" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deleteFloor"
                                                ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return deleteFloor();" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>--%>
                                 </Columns>
                             </MasterTableView>
                         </telerik:RadGrid>
                     </div>

                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lblMsg"></asp:Label>
                    </td>
                </tr>
                
                
            </table>
       
    </div>
    <asp:HiddenField ID="hf_location_id" runat="server" />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgFloors" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
