<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AttributeVersioningPopup.aspx.cs" Inherits="App_Asset_AttributeVersioningPopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<telerik:RadFormDecorator ID="rdfTaskHistory" runat="server" Skin="Default" DecoratedControls="Buttons,Textbox"/>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
<%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
<%--<link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />--%>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />

    <%--<title>Attribute Version</title>--%>
      <script language="javascript" type="text/javascript">

          function GetRadWindow() {
              var oWindow = null;
              if (window.radWindow) oWindow = window.radWindow;
              else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
              return oWindow;
          }

          function close_() {
              window.close();
              return false;
          }

          function stopPropagation(e) {

              e.cancelBubble = true;

              if (e.stopPropagation)
                  e.stopPropagation();
          }

          function CloseWindow1() {

              // GetRadWindow().BrowserWindow.referesh_project_page();
              GetRadWindow().close();
              //top.location.reload();
              //GetRadWindow().BrowserWindow.adjust_parent_height();
              return false;
          }
          function CancelWindow() {
              CloseWindow1();
          }

          function clear_txt() {
              document.getElementById("txtSearch").value = "";
              return false;
          }
            </script>
     <script type="text/javascript" language="javascript">
                window.onload = body_load;
                function body_load() {
                    var screenhtg = parseInt(window.screen.height * 0.65);
                   // document.getElementById("divSelectedDomponentContent").style.height = screenhtg * 0.61;
                    //$(".divScroll").niceScroll({ touchbehavior: false, cursorcolor: "#969696", cursoropacitymax: 0.8, cursorborder: "none", cursorwidth: 8, background: "#cccccc", overflow: "hidden" });
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
   
    <style type="text/css">
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
      HTML
            {
                overflow: hidden;
                           
            }
           
            
    </style>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
   <%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />--%>
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
</head>
<body style="width:100%;background-color:#EEEEEE;" >
    <form id="form1"  runat="server"  style="width:100%;background-color:#EEEEEE;">
     <telerik:RadScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="360000">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
     <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <asp:Panel ID="ppanal1" runat="Server" ScrollBars="None">
    <div id="div1" class="div_outer">
      
      
     <table id="Table1" style="margin: 03px 0px 02px 05px;" width="98%">
         <tr>
             <td  style="width:100%;">
                <div class="rpbItemHeader">
                            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                                <tr>
                                    <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width: 50%;">
                                        <asp:Label runat="server" ID="lbl_grid_head" CssClass="gridHeadText" Width="200px"
                                            ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                    </td>
                                     <%--<td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                    <asp:Label runat="server" Text="<%$Resources:Resource,Projects%>" ID="lbl_grid_head"
                                                        CssClass="gridHeadText" Width="100px"
                                                        ></asp:Label>
                                                </td>   --%> 
                                    <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                        onclick="stopPropagation(event)">
                                        <div id="div_search" style="width: 200px; background-color: white;" onclick="stopPropagation(event)">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="180px">
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
                                    <td align="right" style="padding: 4px 6px 0 0;">
                                        <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                     
                 <div id="divSelectedDomponentContent" class="divProperties  RightMenu_1_Content">
                      <telerik:RadGrid ID="Rghistory" AllowMultiRowSelection="true"  runat="server" AllowPaging="True" AutoGenerateColumns="false"
                         AllowSorting="True" PagerStyle-AlwaysVisible="true" PageSize="10" OnSortCommand="Rghistory_SortCommand"
                         GridLines="None" Skin="Default" OnPageIndexChanged="Rghistory_PageIndexChanged1" OnPageSizeChanged="Rghistory_PageSizeChanged1"  onprerender="Rghistory_PreRender">
                       <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                       <ClientSettings>
                            <Selecting AllowRowSelect="true"  />
                            <Scrolling AllowScroll="true" ScrollHeight="280" UseStaticHeaders="true" />
                        </ClientSettings>
                          <PagerStyle Mode="NextPrevAndNumeric" />
                      <MasterTableView   EditMode="EditForms" DataKeyNames="value" GroupLoadMode="Client">
                        <Columns>
                            <telerik:GridBoundColumn DataField="value" HeaderText="<%$ Resources:Resource,Value %>"  >
                                <ItemStyle CssClass="column" Width="110px" />
                            </telerik:GridBoundColumn>
                               <telerik:GridBoundColumn DataField="created_by" HeaderText="<%$ Resources:Resource,created_by %>" >
                                <ItemStyle CssClass="column" Width="100px" />
                            </telerik:GridBoundColumn>
                               <telerik:GridBoundColumn DataField="created_on" HeaderText="<%$ Resources:Resource,created_on %>" 
                                EditFormColumnIndex="0" >
                                <ItemStyle CssClass="column" Width="120px" />
                            </telerik:GridBoundColumn>
                          </Columns>
                         </MasterTableView>
                        </telerik:RadGrid >
                      </div>   
                </td> 
            </tr> 
             
        </table>
        <table width="40%" id="table2" style="vertical-align: top; margin-left: 5px;  margin-top: 10px;" border="0">
            <tr >
                <td>
                    <asp:Button ID="btnClose" runat ="server" Text="<%$Resources:Resource,Close%>"
                        Width="100px" OnClientClick= "javascript:close_();true,false" 
                        onclick="btnClose_Click"/> 
                  
                </td>
           </tr>
           </table>

     </div>
     </asp:Panel>
    </form>
</body>
</html>
