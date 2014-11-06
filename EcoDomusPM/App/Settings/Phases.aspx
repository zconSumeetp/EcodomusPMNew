<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Phases.aspx.cs" Inherits="App_Settings_Phases" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
        function deleteComponent() {
            var flag;
            flag = confirm("This phase may be assigned to project. Do you want to delete?");
            return flag;
        }


        function divVisibleAdd() {

            document.getElementById("txtPhaseName").value = "";
            document.getElementById("divAdd").style.display = "inline"; //text
            document.getElementById("divsavebtn").style.display = "inline";
            document.getElementById("divaddbtn").style.display = "none"; //button
            document.getElementById("divcancel").style.display = "inline";
            var obj = parent.window.frames[1];
            if (obj != null) {

                window.parent.resize_iframe(parent.window.frames[1]);

            }



            return false;
        }
        function chkPhaseName() {
            if (document.getElementById("txtPhaseName").value == "") {
                alert("Add New Phase");
                return false;
            }
            else {
                return true;
            }

            document.getElementById("divsavebtn").style.display = "none";
            document.getElementById("divaddbtn").style.display = "inline";
            document.getElementById("divcancel").style.display = "none";
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

    </script>
    <script language="javascript" type="text/javascript">
        function body_load() {

            var screenhtg = parseInt(window.screen.height * 0.66);
            document.getElementById("divSelectedDomponentContent").style.height = screenhtg * 0.80;
            $(".divScroll").niceScroll({ touchbehavior: false, cursorcolor: "#969696", cursoropacitymax: 0.8, cursorborder: "none", cursorwidth: 10, background: "#cccccc", overflow: "hidden" });
            $("#divSelectedDomponentContent").show();

        }
        //window.onload = body_load;

        function Product_profile(reg) {

            var ProductId = reg.pk_product_id;
            top.location.href = "SettingsMenu.aspx?ProductId=" + ProductId + "&organization_id=" + parent.document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&IsfromClient=" + parent.document.getElementById("ContentPlaceHolder1_HiddenField1").value + "&IsFromProduct=" + document.getElementById("hfIsFromProduct").value + "";
            return false;
        }


        function Clear() {
            try {

                document.getElementById("txtSearch").value = "";

                return false;
            }
            catch (e) {
                return false;
            }
        }

        function deleteProduct() {
            var flag;
            flag = confirm("Do you want to delete this product?");
            return flag;
        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }
        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {

            var pageSize = document.getElementById("hfDocumentPMPageSize").value;
            var scrollArea = sender.GridDataDiv;
            var dataHeight = sender.get_masterTableView().get_element().clientHeight;
            if (!flag) {
                if (dataHeight < parseInt(pageSize) * 40) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
                }
            }
            else {

                if (dataHeight - 260 > 180)
                    scrollArea.style.height = (dataHeight - 220) + "px";
                else if (dataHeight - 260 < 180 && dataHeight > 220)
                    scrollArea.style.height = 220 + "px";
                else
                    scrollArea.style.height = dataHeight + "px";
                flag = false;
            }

        }

        var flag = false;
        function resize_gridHeight() {

            flag = true;
        }
        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
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
</head>
<body style="background: #F7F7F7; padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div>
        <table border="0" width="100%" style="margin: 0px">
            <tr>
                <td class="centerAlign">
                    <div class="rpbItemHeader ">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                            <tr>
                                <td align="left" class="entityImage">
                                    <asp:Label runat="server" Text="<%$Resources:Resource,Phase%>" ID="lbl_grid_head"
                                        CssClass="gridHeadText" Width="100px" ForeColor="#F8F8F8" Font-Names="Arial"
                                        Font-Size="12"></asp:Label>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;">
                                    <div id="div1" style="width: 200px; background-color: white;">
                                        <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="<%$Resources:Resource,Search%>" BorderColor="White" ID="txtSearch" Width="180px">
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
                                <td align="right" style="padding: 4px 6px 0 0; width: 20px">
                                    <%--  <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)"  />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContent">
                        <telerik:RadGrid ID="rg_phases_grid" runat="server" BorderWidth="1px" CellPadding="0"
                            Width="100%" AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True"
                            GridLines="None" PagerStyle-AlwaysVisible="true" Skin="Default" OnItemCommand="rg_phases_grid_ItemCommand"
                            OnPageIndexChanged="rg_phases_grid_PageIndexChanged" OnPageSizeChanged="rg_phases_grid_PageSizeChanged"
                            OnSortCommand="rg_phases_grid_SortCommand" OnItemCreated="rg_phases_grid_ItemCreated"
                            OnItemDataBound="rg_phases_grid_ItemDataBound">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="left" Width="100%" />
                            <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                <Selecting AllowRowSelect="true" />
                                <ClientEvents OnGridCreated="GridCreated" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="400px" />
                            </ClientSettings>
                            <MasterTableView CommandItemDisplay="Top" CommandItemSettings-AddNewRecordText="<%$Resources:Resource,Add_New%>"
                                CommandItemSettings-ShowRefreshButton="false" DataKeyNames="pk_phase_id,phase_name">
                                <%--<ItemStyle Height="31px" Font-Names="Arial" Font-Size="10"  />
                                <AlternatingItemStyle Height="31px"  Font-Names="Arial" Font-Size="10" />--%>
                                <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" Font-Underline="false" />
                                <FooterStyle Height="25px" Font-Names="Arial" />
                                <Columns>
                                    <%--<telerik:GridButtonColumn DataTextField="phase_name" HeaderText="<%$Resources:Resource,Phase_Name%>"
                                        SortExpression="phase_name" UniqueName="phase_name" CommandName="phasename">
                                        <ItemStyle CssClass="" Font-Underline="True" Width="90%" />
                                        <HeaderStyle CssClass="" Font-Underline="True" Width="90%" />
                                    </telerik:GridButtonColumn>--%>

                                    <telerik:GridBoundColumn DataField="phase_name" HeaderText="<%$Resources:Resource,Phase_Name%>"

                               

                                        SortExpression="phase_name" EditFormColumnIndex="0" UniqueName="phase_name"  >

                                 

                                        <ItemStyle CssClass="" Font-Underline="True" Width="90%" />

                                   
                                        <HeaderStyle CssClass="" Font-Underline="True" Width="90%" />

                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="pk_phase_id" HeaderText=" <%$Resources:Resource,Delete%>" UniqueName="phase_delete">
                                        <ItemStyle CssClass="" Wrap="false" Width="14%" />
                                        <HeaderStyle CssClass="" Wrap="false" Width="14%" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deletephases"
                                                ImageUrl="~/App/Images/Delete.gif" Height="25px" OnClientClick="javascript:return deleteComponent();" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <EditFormSettings ColumnNumber="3" EditFormType="AutoGenerated" InsertCaption="Add New:"
                                    CaptionFormatString="Edit:">
                                    <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                    <FormCaptionStyle CssClass=""></FormCaptionStyle>
                                    <FormMainTableStyle GridLines="None" BackColor="White" Width="100%" />
                                    <FormTableStyle BackColor="White" Height="50px" />
                                    <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                                    <EditColumn ButtonType="ImageButton" UpdateText="Update record" UniqueName="EditCommandColumn1"
                                        CancelText="Cancel" UpdateImageUrl="~/App/Images/sign1.jpg">
                                    </EditColumn>
                                    <EditColumn ButtonType="ImageButton" InsertText="Insert Record" UniqueName="EditColumnInsertColum2"
                                        CancelText="Cancel">
                                    </EditColumn>
                                    <EditColumn UniqueName="EditColumn">
                                    </EditColumn>
                                    <FormTableButtonRowStyle HorizontalAlign="Right" CssClass=""></FormTableButtonRowStyle>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div id="divAdd" style="margin-top: 10px; margin-bottom: 10px; display: none;" runat="server">
        <table>
            <tr>
                <th>
                    <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Phase%>" CssClass="LabelNormal"></asp:Label>:
                    <asp:TextBox ID="txtPhaseName" runat="server" CssClass="SmallTextBox"></asp:TextBox>&nbsp;&nbsp;
                </th>
            </tr>
        </table>
    </div>
    <div style="display: none;">
        <table border="0">
            <tr>
                <td colspan="2">
                    <asp:Label ID="lbl_organization" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 10px" colspan="2">
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divaddbtn" align="left" runat="server">
                        <asp:Button ID="btnadd" Text="<%$Resources:Resource,Add%>" Width="80px" runat="server"
                            OnClientClick="javascript:return divVisibleAdd()" />
                    </div>
                    <div id="divsavebtn" style="display: none;" align="left" runat="server">
                        <asp:Button ID="btnsave" Width="80px" Text="<%$Resources:Resource,Save%>" runat="server"
                            OnClick="btnsave_Click" OnClientClick="javascript:return chkPhaseName();" />
                    </div>
                </td>
                <td>
                    <div id="divcancel" style="margin-left: 50px; display: none;" runat="server">
                        <asp:Button ID="btncancel" Text="<%$Resources:Resource,Cancel%>" Width="80px" runat="server" />
                    </div>
                </td>
            </tr>
            <tr>
                <td style="height: 10px" colspan="2">
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="organization_id" runat="server" Value="" />
    <asp:HiddenField ID="hfDocumentPMPageSize" runat="server" Value="" />
    </form>
</body>
</html>
