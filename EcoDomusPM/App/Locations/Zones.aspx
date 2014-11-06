<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Zones.aspx.cs" Inherits="App_Locations_Zones" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>EcoDomus PM - Zones</title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
    <script type="text/javascript" language="javascript">
        window.onload = body_load;
        function resize_Nice_Scroll() {

//            $(".divScroll").getNiceScroll().resize();
        }

        function body_load() {
            document.getElementById("<%=txtSearchText.ClientID %>").focus();
          }



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

        </script>
          <script type="text/javascript" language="javascript">
              function clearText() {
                  document.getElementById("txtSearchText").value = "";
                  return false;

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


              function deleteZone() {
                  var RadGrid1 = $find("<%=rgZones.ClientID %>");
                  var masterTable = $find("<%=rgZones.ClientID %>").get_masterTableView();
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
                      flag = confirm("Do you want to delete this zone?");
                      return flag;
                      //return true;
                  }
                  else {
                      alert("Please select zone");
                      return false;

                  }

                  //alert("Please select at least one zone to delete.");

              }
              //                var flag;
              //                flag = confirm("Do you want to delete this Zone?");
              //                return flag;
              //            }
              function NavigateToFindLocation() {

                  top.location.href = "../Locations/FacilityMenu.aspx?pagevalue=Zone Profile&id=" + document.getElementById('hf_location_id').value + "&name=" + document.getElementById('hf_zone_name').value;
              }

              function navigate_zone() {
                  var url = "../locations/facilitymenu.aspx?pagevalue=Zone Profile&id=" + document.getElementById("hf_location_id").value + "&name= ";
                  parent.location.href(url);
              }
              function LogoutNavigation() {

                  var query = parent.location.href;
                  top.location.href(query);

              }
              function stopPropagation(e) {

                  e.cancelBubble = true;

                  if (e.stopPropagation)
                      e.stopPropagation();
              }

        </script>
        
      <style type="text/css">
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
        html
        {
            overflow-y: hidden;
            overflow-x: Auto;
        }
    </style>
    </telerik:RadCodeBlock>
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" style="margin: 0 0 0 0" defaultfocus="txtSearchText">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="360000">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />

    <div style="width: 100%;">
        
            <table style="margin-left: 0px; margin-top: 0%;table-layout : fixed;" align="left" border="0" width="100%">
                <tr>
                    <td>
                        <asp:Button ID="btnadd" runat="server" Text="<%$Resources:Resource, Add_Zone%>" Width="100px"
                            CausesValidation="false" OnClick="btnadd_Click" />
                        <asp:Button ID="btnDelete" runat="server" SkinID="Default" OnClick="btnDelete_click"
                            OnClientClick="javascript:return deleteZone();" Text="<%$Resources:Resource, Delete%>"
                            Width="60px" />
                        <asp:Button ID="btnclose" runat="server" Text="Close" Visible="false" Width="100px"
                            CausesValidation="false" OnClick="btnclose_Click" />
                            <asp:HiddenField ID="hfDocumentPMPageSize"  runat="server" Value="" />
                    </td>
                </tr>
                <tr>
                    <td style="width:100%;" class="centerAlign">
                        <div class="rpbItemHeader">
                            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                                <tr>
                                    <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width: 35%;">
                                        <asp:Label runat="server" ID="lbl_grid_head" CssClass="gridHeadText" Width="200px" Text="<%$Resources:Resource,Zones%>"
                                            ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                    </td>
                                    <td id="Td1" onclick="stopPropagation(event)" visible="false" runat="server">
                                                        <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Facility_Name%>"
                                                            CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10">:</asp:Label>
                                                        :<asp:Label runat="server" ID="lblFacilityName" CssClass="Label" Visible="false"></asp:Label>
                                                    </td>
                                    <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                        onclick="stopPropagation(event)">
                                        <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch">        
                                        <div id="div_search" style="width: 200px; background-color: white; ">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearchText" Width="180px">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ClientIDMode="Static" ID="btnSearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                            OnClick="btnSearch_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        </asp:Panel>
                                    </td>
                                    <td align="right" style="padding: 4px 6px 0 0;">
                                        <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />
                                --%>    </td>
                                </tr>
                            </table>
                        </div>

                        <div id="divSelectedDomponentContent" >
                            <telerik:RadGrid ID="rgZones"  runat="server" BorderWidth="1px" CellPadding="0"
                                AllowPaging="true" PageSize="10" ItemStyle-Wrap="false" AutoGenerateColumns="False"
                                AllowSorting="True" AllowMultiRowSelection="true" PagerStyle-AlwaysVisible="true"
                                Skin="Default" OnItemCommand="rgZones_ItemCommand" OnSortCommand="rgZones_SortCommand"
                                OnPageIndexChanged="rgZones_PageIndexChanged" OnPageSizeChanged="rgZones_PageSizeChanged"
                                OnItemDataBound="rgZones_OnItemDataBound">
                                <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" />
                                <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                    <Selecting AllowRowSelect="true" />
                                   
                                </ClientSettings>
                                <MasterTableView DataKeyNames="zone_id,zone_name">
                                     <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10"  />
                                <AlternatingItemStyle Height="31px"  Font-Names="Arial" Font-Size="10" />
                                 <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                            <FooterStyle Height="25px" Font-Names="Arial"/>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="zone_id" HeaderText="zone_id" UniqueName="zone_id"
                                            Visible="False">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridClientSelectColumn>
                                            <ItemStyle Width="5%" />
                                            <HeaderStyle Width="5%" />
                                        </telerik:GridClientSelectColumn>
                                        <telerik:GridTemplateColumn DataField="zone_name" UniqueName="zone_name" HeaderText=" <%$Resources:Resource, Zone_Name%>"
                                            SortExpression="zone_name">
                                            <ItemStyle   Width="35%" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="hlnkZoneName" CommandName="profile" Text='<%# DataBinder.Eval(Container.DataItem,"zone_name")%>'
                                                    runat="server">
                                                </asp:LinkButton>
                                                <%--
                                             Target="_blank">
                                            NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"file_path")%>'

                                                --%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="zone_desc" HeaderText="<%$Resources:Resource, Description%>"
                                            UniqueName="zone_desc">
                                            <ItemStyle   Width="50%" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridBoundColumn DataField="floor_name" HeaderText="Floor Name" UniqueName="floor_name"
                                        >
                                    </telerik:GridBoundColumn>--%>
                                        <%--    <telerik:GridTemplateColumn DataField="zone_id" UniqueName="zone_id" Visible="true">
                                            <ItemStyle  Width="5%" />
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deleteZone"
                                                    ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return deleteZone();" />
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
    <asp:HiddenField ID="hf_zone_name" runat="server" />
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgZones" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgZones">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgZones" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
