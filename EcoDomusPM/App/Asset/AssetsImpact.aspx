<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="AssetsImpact.aspx.cs"
    Inherits="App_Asset_AssetsImpact" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Systems</title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
   <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
        <script language="javascript" type="text/javascript">
            //            window.onload = body_load;

            //            function resize_Nice_Scroll() {

            //                $(".divScroll").getNiceScroll().resize();
            //            }

            //            function body_load1() {

            //                $("html").css('overflow-y', 'hidden');
            //                $("html").css('overflow-x', 'auto');
            //                document.getElementById("<%=txt_name.ClientID %>").focus();
            //                var screenhtg = parseInt(window.screen.height * 0.65);
            //                document.getElementById("divSelectedDomponentContent").style.height = screenhtg * 0.81;
            //                document.getElementById("divSelectedDomponentContent1").style.height = screenhtg * 0.69;
            //                $(".divScroll").niceScroll({ touchbehavior: false, cursorcolor: "#969696", cursoropacitymax: 0.8, cursorborder: "none", cursorwidth: 8, background: "#cccccc", overflow: "hidden" });
            //            }



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

            function Clear() {
                try {
                    document.getElementById("txt_name").value = "";
                    return false;
                }
                catch (e) {
                    alert(e.message + "  " + e.Number);
                    return false;
                }
            }

            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            function Clear1() {
                try {
                    document.getElementById("txt_search").value = "";
                    return false;
                }
                catch (e) {
                    alert(e.message + "  " + e.Number);
                    return false;
                }
            }

            function deleteimpact() {
                var flag;
                flag = confirm("Do you want to delete this Impact?");
                return flag;
            }

            function selectCategory() {
                //alert(document.getElementById("ddl_entity").value);
                if (document.getElementById("ddl_entity") != null) {
                    var ddltype = document.getElementById("ddl_entity").value;
                    //alert(ddltype);
                    if (ddltype == "00000000-0000-0000-0000-000000000000") {
                        alert("Please select Category");
                        return false;
                    }
                }
            }
            function duplicate() {
                alert(" Impact already exists");
                return false;
            }

            function selectAtleastOne() {
                alert("Please select item");
                return false;
            }


            function gotoPage(id, pagename) {
                var url;
                if (pagename == "Asset") {
                    url = "AssetMenu.aspx?assetid=" + id; //  + "&pagevalue=AssetProfile";
                }
                else if (pagename == "Type") {
                    url = "TypeProfileMenu.aspx?type_id=" + id;
                    //alert("Page Under Construction");
                }
                else if (pagename == "Facility") {
                    url = "../Locations/FacilityMenu.aspx?FacilityId=" + id;

                }
                else if (pagename == "System") {
                    url = "SystemMenu.aspx?system_id=" + id;

                }
                else if (pagename == "Space") {
                    url = "../Locations/FacilityMenu.aspx?pagevalue=Space Profile&id=" + id;

                }
                else if (pagename == "Floor") {
                    url = "../Locations/FacilityMenu.aspx?pagevalue=Floor Profile&id=" + id;

                }

                parent.location.href(url);
            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }


        </script>
</telerik:RadCodeBlock>

     
    <style type="text/css">
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
        
    </style>
</head>
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin: 0 0 0 0; overflow: scroll;">
    <form id="form1" runat="server" scrolling="yes">
  <telerik:RadScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="360000">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    
    <div style="overflow:auto; width:100%; height:100%; min-height:800px; margin-bottom:10px;" >

    <telerik:RadSplitter ID="RadSplitter1" runat="server" Height="800" Width="100%" >
          <telerik:RadPane ID="RadPane1" runat="server">
               <asp:Panel ID="panelSearch" runat="server">
        <table border="0" style=" width: 100%;table-layout:fixed;">       
            <tr>
                <td height="10px" style="width:100%;">
                </td>
            </tr>
            <tr>
                <td>
                 <div class="rpbItemHeader divBorder">
                            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                                <tr>
                                    <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width: 50%;">
                                        <asp:Label runat="server" ID="lbl_grid_head" CssClass="gridHeadText" Width="200px"
                                            ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12">Affects</asp:Label>
                                    </td>
                                    <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                        onclick="stopPropagation(event)">
                                        <div id="div_search" style="width: 200px; background-color: white;" onclick="stopPropagation(event)">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="<%$Resources:Resource,Search%>" BorderColor="White" ID="txt_name" Width="180px">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ClientIDMode="Static" ID="btn_search_impact" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                            OnClick="btn_search_impact_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td align="right" style="padding: 4px 4px 0 0;">
                                        <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="divSelectedDomponentContent" class="divProperties divBorder divScroll RightMenu_1_Content">

                    <telerik:RadGrid ID="rgimpact" runat="server" AutoGenerateColumns="false" AllowPaging="True" ItemStyle-Wrap="false" BorderWidth="0px" 
                        Skin="Default" OnItemCommand="rgimpact_ItemCommand" OnPageSizeChanged="rgimpact_PageSizeChanged" Width="100%"
                        OnPageIndexChanged="rgimpact_pageindexchanged" AllowSorting="true" OnSortCommand="btn_search_impact_Click" CssClass="NoRecordsGrid" >
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right"  AlwaysVisible="true" />
                        
                        <ClientSettings>
                            <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"  ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                        </ClientSettings>

                        <MasterTableView TableLayout="Auto" DataKeyNames="pk_impact_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_impact_id" HeaderText="" UniqueName="" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="pk_location_id" HeaderText="" UniqueName="" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="linkname" HeaderText="<%$Resources:Resource,Name%>"
                                    UniqueName="linkname" SortExpression="name">
                                    <HeaderStyle Wrap="false" />
                                    <ItemStyle Wrap="false" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="entity_name" HeaderText="<%$Resources:Resource,Category%>"
                                    UniqueName="">
                                    <HeaderStyle Wrap="false" />
                                    <ItemStyle Wrap="false" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Description" HeaderText="<%$Resources:Resource,Description%>"
                                    UniqueName="">
                                    <HeaderStyle Wrap="false" />
                                    <ItemStyle Wrap="false" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="sync_status" HeaderText="<%$Resources:Resource,Edit%>" UniqueName="Status">
                                    <HeaderStyle Width="65" HorizontalAlign="Center" />
                                    <ItemStyle CssClass="column" Wrap="false" />
                                    <ItemTemplate>
                                        <asp:Button ID="btn_edit" runat="server" Text="<%$Resources:Resource,Edit%>" Width="50px"
                                            CommandName="EditImpact" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="pk_issues_id" HeaderText="<%$Resources:Resource,Delete%>" UniqueName="imgbtnDelete_">
                                    <HeaderStyle Width="45" />
                                    <ItemStyle CssClass="column" Height="40"/>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" OnClientClick="javascript:return deleteimpact();"
                                            CommandName="DeleteImpact" ImageUrl="~/App/Images/Delete.gif" Width="35"/>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    </div>
                </td>
            </tr>
            <tr>
                <td height="20px">
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button runat="server" ID="btn_addImpact" Text="<%$Resources:Resource,Add_Affects%>"
                        OnClick="btn_addImpact_Click" Width="120px" />
                </td>
            </tr>
        </table>
    </asp:Panel> 

    <div runat="server" id="div_add_impact" style="display: none" >
         <table border="0" style="width: 95%">
            <caption>
                <asp:Label ID="lbl_add_edit_impact" runat="server" Text="<%$Resources:Resource,Add_Affects%>"></asp:Label>
            </caption>
            <tr>
                <td width="150px">
                    <asp:Label ID="Label2" Text="<%$ Resources:Resource,Description %>" runat="server" CssClass="Label"
                        Width="65px"></asp:Label>:
                </td>
                <td align="left">
                    <asp:TextBox ID="txt_description" runat="server" TextMode="MultiLine" Height="56px"
                        Width="216px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label4" Text="<%$ Resources:Resource,Category %>" runat="server" CssClass="Label"
                        Width="55px"></asp:Label>:
                </td>
                <td>
                    <asp:DropDownList ID="ddl_entity" runat="server" OnSelectedIndexChanged="ddl_entity_SelectedIndexChanged"
                        AutoPostBack="true" Width="100px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>

        <asp:Panel ID="serachImact" runat="server">

        <table border="0" style="width: 100%">       
       
       <tr id="tr_entity" style="display: none" runat="server">
                <td>
                  <div class="rpbItemHeader">
                            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                                <tr>
                                    <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width: 50%;">
                                        <asp:Label runat="server" ID="Label1" CssClass="gridHeadText" Width="200px"
                                            ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                    </td>
                                    <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                        onclick="stopPropagation(event)">
                                        <div id="div1" style="width: 200px; background-color: white;" onclick="stopPropagation(event)">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="<%$ Resources:Resource,Search %>" BorderColor="White" ID="txt_search" Width="180px">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ClientIDMode="Static" ID="btn_search" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                            OnClick="btn_search_Click" OnClientClick="javascript:return body_load1();" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td align="right" style="padding: 4px 4px 0 0;">
                                        <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ClientIDMode="Static" ID="Image1" onClick="RightMenu_expand_collapse(3)" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div id="divSelectedDomponentContent1" class="divProperties divScroll RightMenu_3_Content">
                    <telerik:RadGrid ID="rgentity" runat="server" AllowMultiRowSelection="true" AutoGenerateColumns="false"
                        PagerStyle-AlwaysVisible="true" Skin="Default" AllowPaging="true" Width="100%"  AllowSorting="true"
                        OnSortCommand="rgentity_OnSortCommand" Style="display: none" OnPageIndexChanged="rgentity_pageindexchanged"
                        OnPageSizeChanged="rgentity_PageSizeChanged" OnDataBound="rgentity_DataBound">
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="id">
                            <Columns>
                                <telerik:GridClientSelectColumn UniqueName="GridCheckBox">
                                    <ItemStyle Width="10px" />
                                    <HeaderStyle Width="10px" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="id" HeaderText="id" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Name%>"
                                    UniqueName="" SortExpression="name">
                                    <ItemStyle Height="30"/>
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                   </div>
                </td>
            </tr>
            <tr>
                <td height="20px">
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button runat="server" ID="btn_saveImpact" Text="<%$Resources:Resource,Save_Affect%>"
                        OnClientClick="javascript:return selectCategory();" OnClick="btn_saveImpact_Click"
                        Width="100px" />
                    <asp:Button runat="server" ID="btn_cancel" Text="<%$Resources:Resource,Cancel%>"
                        OnClick="btn_cancel_Click" Width="100px" />
                </td>
            </tr>
        </table>
        </asp:Panel>

    </div>
          </telerik:RadPane>
          <telerik:RadSplitBar ID="RadSplitbar1" runat="server">
          </telerik:RadSplitBar>


          <telerik:RadPane ID="RadPane2" runat="server">
                  <asp:Panel ID="SearchAffectedBy" runat="server">
        <table border="0" style=" width: 100%;table-layout:fixed;">       
            <tr>
                <td height="10px" style="width:100%;">
                </td>
            </tr>
            <tr>
                <td>
                 <div class="rpbItemHeader divBorder">
                            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                                <tr>
                                    <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width: 50%;">
                                        <asp:Label runat="server" ID="Label3" CssClass="gridHeadText" Width="200px"
                                            ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12" Text="<%$Resources:Resource,Affected_By%>"></asp:Label>
                                    </td>
                                    <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                        onclick="stopPropagation(event)">
                                        <div id="div2" style="width: 200px; background-color: white;" onclick="stopPropagation(event)">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="<%$Resources:Resource,Search%>" BorderColor="White" ID="RadTextBoxSearchAffectedBy" Width="180px">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ClientIDMode="Static" ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                            OnClick="btnSearchAffectedByClick" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td align="right" style="padding: 4px 4px 0 0;">
                                        <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ClientIDMode="Static" ID="RightMenu_2_img_expand_collapse" onClick="RightMenu_expand_collapse(2)" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="div3" class="divProperties divBorder divScroll RightMenu_2_Content">

                    <telerik:RadGrid ID="AffectedByGrid" runat="server" AutoGenerateColumns="false" AllowPaging="True" ItemStyle-Wrap="false" BorderWidth="0px" 
                        Skin="Default" OnPageSizeChanged="rgAffectedByPageSizeChanged" Width="100%"
                        OnPageIndexChanged="rgAffectedByPageIndexChanged" AllowSorting="true" OnSortCommand="btnSearchAffectedByClick" CssClass="NoRecordsGrid" >
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right"  AlwaysVisible="true" />
                        <ClientSettings>
                         
                        <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"  ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />

                    </ClientSettings>
                        <MasterTableView TableLayout="Auto" DataKeyNames="asset_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="asset_id" HeaderText="" UniqueName="" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="pk_location_id" HeaderText="" UniqueName="" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridHyperLinkColumn DataTextField="name" HeaderText="<%$Resources:Resource,Name%>"
                                    UniqueName="linkname" SortExpression="name" DataNavigateUrlFields="asset_id" DataNavigateUrlFormatString="javascript:gotoPage('{0}','Asset')">
                                    <HeaderStyle Wrap="false" />
                                    <ItemStyle Wrap="false" />
                                </telerik:GridHyperLinkColumn>
                                <telerik:GridBoundColumn DataField="entity_name" HeaderText="<%$Resources:Resource,Category%>"
                                    UniqueName="">
                                    <HeaderStyle Wrap="false" />
                                    <ItemStyle Wrap="false" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Description" HeaderText="<%$Resources:Resource,Description%>"
                                    UniqueName="">
                                    <HeaderStyle Wrap="false" />
                                    <ItemStyle Wrap="false" Height="40"/>
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    </div>
                </td>
            </tr>
            <tr>
                <td height="20px">
                </td>
            </tr>
        </table>
    </asp:Panel>
          </telerik:RadPane>
          <telerik:RadSplitBar ID="RadSplitbar2" runat="server">
          </telerik:RadSplitBar>
     </telerik:RadSplitter>

     </div>
     
    <asp:HiddenField ID="hffacilityid" runat="server" />
    </form>
    <telerik:RadAjaxManagerProxy runat="server" ID="RadAjaxManager1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btn_search_impact">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgimpact" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btn_search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgentity" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="rad_load_panel" Skin="Hay" runat="server" Width="50px">
    </telerik:RadAjaxLoadingPanel>
</body>
</html>
