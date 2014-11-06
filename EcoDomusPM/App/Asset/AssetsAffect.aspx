<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="AssetsAffect.aspx.cs"
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
