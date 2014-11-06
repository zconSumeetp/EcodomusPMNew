<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignSpace.aspx.cs" Inherits="App_Locations_AssignSpace" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<html>
<head runat="server"> 
    <title>Assign Space</title>

    
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">

        <script type="text/javascript" language="javascript">
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }


            function clearText() {
                document.getElementById("txtSearchText").value = "";
                return false;
            }
            function alertmsg() {
                alert("Please select at least one Space.");
                return false;
            }
            function Assign_space_for_zone(Id, Name) {
                
                Name = Name.replace(/#/g, "'");
                window.parent.document.getElementById("hf_selected_id").value = Id;
                window.parent.document.getElementById("hf_selected_name").value = Name;
                window.parent.buttoncallback_Zone();
                
                //top.location.href = "../Locations/FacilityMenu.aspx?pagevalue=Zone Profile&id=" + document.getElementById('hfzoneid').value;
                CloseWindow();

            }

            //for assign values from zone pm grid
            function Assign_space_for_zone_pm(Id, Name, zone_id) {
                                
                Name = Name.replace(/#/g, "'");
                window.parent.callback_zone_pm(Id, Name, zone_id);
              
                CloseWindow();

            }

//            function closeWindow() {
//                alert('h');
//                var rdw = GetRadWindow();
//                rdw.close();
//               // self.close();
//            }

            function GetRadWindow() {

                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function CloseWindow() {
                GetRadWindow().close();

                return false;
            }
           
           

        </script>


    </telerik:RadCodeBlock>

    <%--<style type="text/css">
        .style1
        {
            width: 67%;
        }
        .style2
        {
            height: 20px;
            width: 67%;
        }
    </style>--%>
    <style type="text/css">
    body
    {
        overflow:hidden;
    }
    .rpbItemHeader
             {
            background-color:#808080;
             }
    </style>

</head>
<body style="background-position: white; background: white; padding:0px 0px 0px 0px;  margin:0px 0px 0px 0px;background-color: #EEEEEE; width : 100%;" >
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfFormDecorator1" runat="server" Skin="Default" DecoratedControls="Buttons"/>
    <div>
    <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch">
         <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr style="width:100%">
                    <td class="wizardHeadImage" >
                        <div class="wizardLeftImage">
                            <asp:Label ID="lbl_header" Text="<%$Resources:Resource,Assign_Space%>" Font-Names="Verdana"
                                Font-Size="11pt" runat="server"></asp:Label>
                        </div>
                        <div class="wizardRightImage">
                            <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                OnClientClick="javascript:return CloseWindow();" />
                        </div>
                    </td>
                </tr>                 
                <tr>
                    <td>
                        <table border="0" style=" width:95%; margin:0px 15px 0px 15px;">
                            <tr align="right">
                                <td align="right" >
                                    <asp:Panel ID="panel1" runat="server" DefaultButton="btnSearch">
                                        <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                            <tr>
                                               <%-- <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                    <asp:Label runat="server" Text="<%$Resources:Resource, Assign_Component%>" ID="lbl_grid_head"
                                                        CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Font-Names="Arial"
                                                        Font-Size="12"></asp:Label>
                                                </td>--%>
                                                <td align="right" onclick="stopPropagation(event)">
                                                    <div id="div_search" style="background-color: White; width: 170px;" onclick="stopPropagation(event)">
                                                        <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                            width: 100%;">
                                                            <tr style="border-spacing:0px;">
                                                                <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                                    padding-bottom: 0px;" onclick="stopPropagation(event)">
                                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearchText" Width="100%">
                                                                    </telerik:RadTextBox>
                                                                </td>
                                                                <td  align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                                    padding-bottom: 0px;" onclick="stopPropagation(event)">
                                                                    <asp:ImageButton ClientIDMode="Static" OnClick="btnSearch_Click" ID="btnSearch" Height="13px"
                                                                        runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
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
                                    </asp:Panel>
                                </td>
                            </tr>
                            <%--<tr>
                                <td height="1px" style="background-color: Orange; border-collapse: collapse; " 
                                    class="style1">
                                </td>
                            </tr>--%>
        <tr>
            <td class="style1" >
                    <telerik:RadGrid ID="rgSpaces" Width="100%" runat="server" BorderWidth="1px" CellPadding="0"
                        AllowPaging="true" PageSize="10" AutoGenerateColumns="False" AllowSorting="True"
                        AllowMultiRowSelection="true" PagerStyle-AlwaysVisible="true" Skin="Default" OnPageIndexChanged="rgSpaces_PageIndexChanged"
                        OnPageSizeChanged="rgSpaces_PageSizeChanged" OnSortCommand="rgSpaces_SortCommand">
                        <%-- OnItemCommand="rgSpaces_ItemCommand"--%>
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" />
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                              <Scrolling AllowScroll="true" ScrollHeight="340px" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="space_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="space_id" HeaderText="space_id" UniqueName="space_id"
                                    Visible="False">
                                </telerik:GridBoundColumn>
                                <telerik:GridClientSelectColumn>
                                    <ItemStyle Width="10px" />
                                    <HeaderStyle Width="10px" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="space_name" HeaderText="<%$Resources:Resource, Space_Name%>"
                                    UniqueName="space_name">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="floor_name" HeaderText="<%$Resources:Resource, Floor%>"
                                    UniqueName="floor_name">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="space_desc" HeaderText="<%$Resources:Resource, Description%>"
                                    UniqueName="space_desc">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
            <tr>
                <td class="style2">
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Button ID="btnAssign" runat="server" Text="<%$Resources:Resource, Assign%>"
                        skin="Default" Width="100px" OnClick="btnAssign_Click" />
                    <asp:Button ID="btnClose" runat="server" Text="<%$Resources:Resource, Close%>" skin="Default"
                        Width="100px" OnClientClick="javascript:return CloseWindow();" />
                </td>
            </tr>
        </table> 
        </td></tr></table> 
        </asp:Panel>
<asp:HiddenField ID="hfzoneid" runat="server" />   
    </div>

    <telerik:RadAjaxManager ID="ajax_spaces" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnOK">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgSpaces" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
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

    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
