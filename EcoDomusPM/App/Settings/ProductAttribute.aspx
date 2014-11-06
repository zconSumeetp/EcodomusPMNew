<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductAttribute.aspx.cs"
    Inherits="App_Central_ProductAttribute" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head>
    <title></title>
    <script language="javascript" type="text/javascript">

        //        function body_load() {

        //            var screenhtg = parseInt(window.screen.height * 0.66);
        //            document.getElementById("divSelectedDomponentContent").style.height = screenhtg * 0.72;
        //            $(".divScroll").niceScroll({ touchbehavior: false, cursorcolor: "#969696", cursoropacitymax: 0.8, cursorborder: "none", cursorwidth: 08, background: "#cccccc", overflow: "hidden" });
        //            $("#divSelectedDomponentContent").show();

        //        }
        //  window.onload = body_load;

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
            document.getElementById("txtSearch").value = "";
            return false;
        }

        function openpopupAddAttribute() {


            manager = $find("<%=rad_windowmgr.ClientID %>");

            if (manager != null) {
                var windows = manager.get_windows();

                windows[0].show();

            }
            return false;
        }
        function CloseWindow() {

            GetRadWindow().Hide();

            return false;
        }


        function deleteattribute() {
            var flag;
            flag = confirm("Are you sure you want to delete this Attribute?");
            return flag;
        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }
        function AddAttribute() {
            document.getElementById('trAddAttribute').style.display = "block";
            var cmbGroup_outer = $find("<%= cmbGroup_outer.ClientID %>");
            cmbGroup_outer.clearSelection();
            cmbGroup_outer.get_items().getItem(0).select();
            var cmbStage = $find("<%= cmbStage.ClientID %>");
            cmbStage.clearSelection();
            cmbStage.get_items().getItem(0).select();
            var cmb_uom = $find("<%= cmb_uom.ClientID %>");
            cmb_uom.clearSelection();
            document.getElementById('txtName').value = "";
            document.getElementById('txtValue').value = "";
            document.getElementById('txtDescription').value = "";
            document.getElementById('trbtnAddAttribute').style.display = "none";
            var obj = parent.window.frames[1];
            if (obj != null) {

                window.parent.resize_iframe(parent.window.frames[1]);

            }
            return false
        }
        function CancelAddAttribute() {
            document.getElementById('trAddAttribute').style.display = "none";
            document.getElementById('trbtnAddAttribute').style.display = "block";
            var obj = parent.window.frames[1];
            if (obj != null) {

                window.parent.resize_iframe(parent.window.frames[1]);

            }
            return false;
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
        function validate() {
            alert("Attribute with this name already exists.");
            return false;
        }



        function RowDblClick(sender, eventArgs) {

            sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
        }
        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {

            var pageSize = document.getElementById("hfAttributePMPageSize").value;
            var scrollArea = sender.GridDataDiv;
            var dataHeight = sender.get_masterTableView().get_element().clientHeight;
            if (!flag) {
                if (dataHeight < parseInt(pageSize) * 38) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 38 - 12) + "px";
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
    </script>
    <style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
            height: 100%;
        }
        html
        {
            overflow: hidden;
        }
        .column
        {
            font-size: 13px;
            font-family: Arial;
        }
    </style>
    <%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-position: white; padding: 0px; margin: 0px 0px 0px 0px; background: #F7F7F7;">
    <form id="FormProdAttr" runat="server" style="margin-left: 1%;" defaultfocus="txtSearch">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <asp:Panel ID="aspPanel" runat="server" DefaultButton="btnSearch">
        <table width="99%">
            <tr id="trbtnAddAttribute" runat="server">
                <td>
                    <asp:Button ID="btnAddAttribute" runat="server" Text="<%$Resources:Resource, Add_Attribute%>"
                        CausesValidation="false" Width="120px" OnClientClick="javascript:return openpopupAddAttribute();" /><%--OnClick="btnAddAttribute_Click" --%>
                </td>
            </tr>
            <tr>
                <td style="width: 100%">
                    <div class="rpbItemHeader">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                            <tr>
                                <td align="left" style="width: 30%">
                                    <asp:Label ID="Label1" runat="server" CssClass="gridHeadText" ForeColor="#F8F8F8"
                                        Font-Names="Arial" Font-Size="12" Text="<%$Resources:Resource, Product%>"></asp:Label>
                                    <asp:Label ID="lblColon" runat="server" CssClass="gridHeadText" ForeColor="#F8F8F8"
                                        Font-Names="Arial" Font-Size="12" Text=":"></asp:Label>
                                    <asp:Label ID="lblproduct" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"
                                        CssClass="gridHeadText" runat="server"></asp:Label>
                                </td>
                                <td align="left" style="width: 40%">
                                    <asp:Label ID="Label2" runat="server" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"
                                        CssClass="gridHeadText" Text="<%$Resources:Resource,   Product_Manufacturer%>"></asp:Label>
                                    <asp:Label ID="lblColn1" runat="server" CssClass="gridHeadText" ForeColor="#F8F8F8"
                                        Font-Names="Arial" Font-Size="12" Text=":"></asp:Label>
                                    <asp:Label ID="lblProductManufacturer" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"
                                        CssClass="gridHeadText" runat="server"></asp:Label>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                    onclick="stopPropagation(event)">
                                    <div id="div1" style="width: 200px; background-color: white;" onclick="stopPropagation(event)">
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadTextBox ID="txtSearch" CssClass="txtboxHeight" ClientIDMode="Static"
                                                        runat="server" Height="100%" EmptyMessage="Search" BorderColor="White" Width="180px">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ClientIDMode="Static" ID="btnSearch" Height="13px" runat="server"
                                                        CausesValidation="false" ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnSearch_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td align="right" style="padding: 4px 4px 0 0; width: 40px">
                                    <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                        ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContent" class="divProperties divScroll RightMenu_1_Content">
                        <telerik:RadGrid ID="rgProductAttributes" runat="server" BorderWidth="1px" CellPadding="0"
                            Skin="Default" Width="99%" AllowPaging="True" AutoGenerateColumns="False" PagerStyle-AlwaysVisible="true"
                            GridLines="None" PageSize="10" OnPageIndexChanged="rgProductAttributes_OnPageIndexChanged"
                            OnPageSizeChanged="rgProductAttributes_OnPageSizeChanged" OnItemCommand="rgProductAttributes_ItemCommand"
                            OnSortCommand="rgProductAttributes_onSortCommand" OnItemDataBound="rgProductAttributes_ItemDataBound"
                            AllowSorting="true" ItemStyle-Wrap="false" Font-Size="Medium">
                            <PagerStyle Mode="NextPrevAndNumeric" />
                            <ClientSettings EnableRowHoverStyle="true">
                                <Selecting AllowRowSelect="true" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                                <ClientEvents OnGridCreated="GridCreated" OnRowDblClick="RowDblClick" />
                            </ClientSettings>
                            <MasterTableView AllowMultiColumnSorting="true" EditMode="EditForms" DataKeyNames="pk_product_attribute_id"
                                GroupLoadMode="Client">
                                <GroupByExpressions>
                                    <telerik:GridGroupByExpression>
                                        <SelectFields>
                                            <telerik:GridGroupByField FieldAlias="Group" FieldName="group_name" FormatString=""
                                                HeaderText="" SortOrder="None"></telerik:GridGroupByField>
                                        </SelectFields>
                                        <GroupByFields>
                                            <telerik:GridGroupByField FieldName="group_name"></telerik:GridGroupByField>
                                        </GroupByFields>
                                    </telerik:GridGroupByExpression>
                                </GroupByExpressions>
                                <Columns>
                                    <telerik:GridEditCommandColumn HeaderStyle-Width="5%" ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                        ItemStyle-Width="2%" HeaderText="<%$Resources:Resource,Edit%>">
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridBoundColumn DataField="pk_product_attribute_id" UniqueName="pk_product_attribute_id"
                                        HeaderText="ID" ReadOnly="True" Visible="False" Display="false">
                                        <HeaderStyle ForeColor="Silver" />
                                        <ItemStyle CssClass="column"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="attribute_name" SortExpression="attribute_name"
                                        HeaderText="<%$Resources:Resource, Attribute_Name%>" EditFormColumnIndex="0">
                                        <ItemStyle CssClass="column" Wrap="false" Width="30%" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="attribute_value" SortExpression="attribute_value"
                                        HeaderText="<%$Resources:Resource, Value%>" EditFormColumnIndex="0">
                                        <ItemStyle CssClass="column" Wrap="false" Width="12%" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, Unit%>" SortExpression="units"
                                        DataField="units" EditFormColumnIndex="0">
                                        <ItemTemplate>
                                            <asp:Label ID="lblunit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"units")%>'> </asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cmb_unit" runat="server" Width="150px">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <ItemStyle CssClass="column" Wrap="false" Width="12%" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, Stage%>" SortExpression="stage_name"
                                        DataField="stage_name" EditFormColumnIndex="1">
                                        <ItemTemplate>
                                            <asp:Label ID="lblstage" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"stage_name")%>'> </asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cmb_stage" runat="server" Width="150px">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <ItemStyle CssClass="column" Wrap="false" Width="15%" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Group" SortExpression="group_name" DataField="group_name"
                                        EditFormColumnIndex="1" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblgroup" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"group_name")%>'> </asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cmb_group" runat="server" Width="150px">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <ItemStyle CssClass="column" Wrap="false" Width="10%" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="description" SortExpression="description" HeaderText="<%$Resources:Resource, Description%>"
                                        EditFormColumnIndex="1">
                                        <ItemStyle CssClass="column" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="pk_product_attribute_id" UniqueName="pk_product_attribute_id"
                                        HeaderText="<%$Resources:Resource, Delete%>">
                                        <ItemStyle CssClass="column" Wrap="false" Width="20%" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deleteAttribute"
                                                ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return deleteattribute();" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <EditFormSettings ColumnNumber="2" EditFormType="AutoGenerated" CaptionFormatString="Edit Attributes:">
                                    <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                    <FormCaptionStyle CssClass="column"></FormCaptionStyle>
                                    <FormMainTableStyle GridLines="None" BackColor="White" Width="100%" />
                                    <FormTableStyle BackColor="White" />
                                    <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                                    <EditColumn ButtonType="ImageButton" UpdateText="Update record" UniqueName="EditCommandColumn1"
                                        CancelText="Cancel edit" UpdateImageUrl="~/App/Images/sign1.jpg">
                                    </EditColumn>
                                    <EditColumn UniqueName="EditColumn">
                                    </EditColumn>
                                    <FormTableButtonRowStyle HorizontalAlign="Right" CssClass=""></FormTableButtonRowStyle>
                                </EditFormSettings>
                            </MasterTableView>
                            <AlternatingItemStyle CssClass="alternateColor" />
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
            <tr>
                <th id="Th1" runat="server" style="width: 100%">
                </th>
            </tr>
            <tr>
                <td align="center" style="width: 500px">
                    <asp:Label ID="lblMsg" CssClass="Message" runat="server" ForeColor="red"></asp:Label>
                </td>
            </tr>
            <tr id="trAddAttribute" runat="server" style="display: none;">
                <td>
                    <table width="60%" border="0" cellpadding="0" cellspacing="0">
                        <caption>
                            <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,  Add_Product_Attribute%>">:</asp:Label>
                        </caption>
                        <%--     <tr>
                        <th align="left" style="Width:100px;">
                              <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource,  Name%>"></asp:Label>
                              
                        </th>
                        <td>
                            <asp:TextBox ID="txtName" TabIndex="1" runat="server" CssClass="SmallTextBox" Style="width: 180px;"
                                ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName"
                                ErrorMessage="*" ForeColor="Red" ValidationGroup="add"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                         <th align="left">
                            <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,  Value%>"></asp:Label>
                            
                        </th>
                        <td>
                            <asp:TextBox ID="txtValue" TabIndex="2" runat="server" CssClass="SmallTextBox" Style="width: 180px;"
                                ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtValue"
                                ErrorMessage="*" ForeColor="Red" ValidationGroup="add"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                          <th align="left">
                            <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource,  Unit%>"></asp:Label>
                           
                        </th>
                        <td>
                            <telerik:RadComboBox ID="cmb_uom" TabIndex="3" MarkFirstMatch="true" runat="server" Width="180px">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorUnit" runat="server" ControlToValidate="cmb_uom"
                                ErrorMessage="*" ForeColor="Red" InitialValue="- Select UOM -" ValidationGroup="add"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                          <th align="left">
                            <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource,  Stage%>"></asp:Label>
                           
                        </th>
                        <td>
                            <telerik:RadComboBox ID="cmbStage" TabIndex="4" MarkFirstMatch="true" runat="server" Width="180px">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cmbStage"
                                ErrorMessage="*" ForeColor="Red" InitialValue="- Select  -" ValidationGroup="add"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <th align="left">
                             <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource,  Group%>"></asp:Label>
                           
                        </th>
                        <td>
                            <telerik:RadComboBox ID="cmbGroup_outer" TabIndex="5" MarkFirstMatch="true" runat="server" Width="180px">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cmb_uom"
                                ErrorMessage="*" ForeColor="Red" ValidationGroup="add1"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <th align="left">
                             <asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource,  Description%>"></asp:Label>
                            
                        </th>
                        <td>
                            <asp:TextBox ID="txtDescription" runat="server" TabIndex="6" CssClass="SmallTextBox" Style="width: 180px;"
                                ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtName"
                                ErrorMessage="*" ForeColor="Red" ValidationGroup="add1"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                 
                    <tr>
                        <td valign="top" colspan="2">
                            <table cellspacing="10" cellpadding="10">
                                <tr>
                                    <td>
                                    
                                        <asp:Button ID="btnSave" runat="server" TabIndex="7" Width="100px"  Text="<%$Resources:Resource,  Save%>" ValidationGroup="add"
                                            OnClick="btnSave_Click" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnCancelSave" runat="server" TabIndex="8"  Width="100px" Text="<%$Resources:Resource,  Cancel%>" CausesValidation="false"
                                            OnClick="btnCancelSave_Click"  OnClientClick="javascript:return CancelAddAttribute();"  />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>--%>
                    </table>
                    <asp:Label ID="lblmessage" runat="server" Style="display: none; color: Red; font-size: 11px;"> 
                            
                    </asp:Label>
                    <asp:HiddenField ID="hfregisterid" runat="server" />
                    <asp:HiddenField ID="hfFilePath" runat="server" />
                    <asp:HiddenField ID="hfAttributePMPageSize" runat="server" />
                    <asp:HiddenField ID="hf_attribute_id" runat="server" />
                    <asp:HiddenField ID="hf_count" runat="server" />
                    <telerik:RadWindowManager ID="rad_windowmgr" runat="server" VisibleStatusbar="false">
                        <Windows>
                            <telerik:RadWindow ID="radWindowAddNew" runat="server" KeepInScreenBounds="true"
                                VisibleTitlebar="false" AutoSize="false" Width="320" Height="395" OffsetElementID="rguploadedfiles"
                                VisibleStatusbar="false" VisibleOnPageLoad="false"  Behaviors="Close"
                                Animation="Slide" BorderStyle="Solid" BorderColor="Black" BorderWidth="2" ReloadOnShow="false"
                                Top="20px" Left="380px" BackColor="Gray">
                                <ContentTemplate>
                                    <table style="background: #F7F7F7;">
                                        <tr style="width: 100%;">
                                            <td class="wizardHeadImage" colspan="3">
                                                <div class="wizardLeftImage">
                                                    <asp:Label ID="lbl_Add_Classification" Text="<%$Resources:Resource,Add_Attribute%>"
                                                        Font-Names="Verdana" Font-Size="11pt" runat="server"></asp:Label>
                                                </div>
                                                <div class="wizardRightImage">
                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                                        OnClientClick="javascript:return CloseWindow();" CausesValidation="false" />
                                                    <%--OnClientClick="javascript:return CloseWindow();" --%>
                                                </div>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="left" style="width: 100px;">
                                                <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource,  Name%>"></asp:Label>
                                            </th>
                                            <td>
                                                <asp:TextBox ID="txtName" TabIndex="1" runat="server" CssClass="SmallTextBox" Style="width: 180px;"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName"
                                                    ErrorMessage="*" ForeColor="Red" ValidationGroup="add"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="left">
                                                <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,  Value%>"></asp:Label>
                                            </th>
                                            <td>
                                                <asp:TextBox ID="txtValue" TabIndex="2" runat="server" CssClass="SmallTextBox" Style="width: 180px;"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtValue"
                                                    ErrorMessage="*" ForeColor="Red" ValidationGroup="add"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="left">
                                                <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource,  Unit%>"></asp:Label>
                                            </th>
                                            <td>
                                                <telerik:RadComboBox ID="cmb_uom" TabIndex="3" MarkFirstMatch="true" runat="server"
                                                    Height="220" Width="180px">
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorUnit" runat="server" ControlToValidate="cmb_uom"
                                                    ErrorMessage="*" ForeColor="Red" InitialValue="- Select UOM -" ValidationGroup="add"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="left">
                                                <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource,  Stage%>"></asp:Label>
                                            </th>
                                            <td>
                                                <telerik:RadComboBox ID="cmbStage" TabIndex="4" MarkFirstMatch="true" runat="server"
                                                    Height="180" Width="180px">
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cmbStage"
                                                    ErrorMessage="*" ForeColor="Red" InitialValue="- Select  -" ValidationGroup="add"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="left">
                                                <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource,  Group%>"></asp:Label>
                                            </th>
                                            <td>
                                                <telerik:RadComboBox ID="cmbGroup_outer" TabIndex="5" MarkFirstMatch="true" runat="server"
                                                    Height="140" Width="180px">
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cmb_uom"
                                                    ErrorMessage="*" ForeColor="Red" ValidationGroup="add1"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th align="left">
                                                <asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource,  Description%>"></asp:Label>
                                            </th>
                                            <td>
                                                <asp:TextBox ID="txtDescription" runat="server" TabIndex="6" CssClass="SmallTextBox"
                                                    Style="width: 180px;"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtName"
                                                    ErrorMessage="*" ForeColor="Red" ValidationGroup="add1"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" colspan="2">
                                                <table cellspacing="10" cellpadding="10">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="btnSave" runat="server" TabIndex="7" Width="100px" Text="<%$Resources:Resource,  Save%>"
                                                                ValidationGroup="add" OnClick="btnSave_Click" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnCancelSave" runat="server" TabIndex="8" Width="100px" Text="<%$Resources:Resource,  Cancel%>"
                                                                CausesValidation="false" OnClick="btnCancelSave_Click" OnClientClick="javascript:return CancelAddAttribute();" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </telerik:RadWindow>
                        </Windows>
                    </telerik:RadWindowManager>
                    
                </td>
            </tr>
        </table>
    </asp:Panel>
    <telerik:RadAjaxManager ID="rmspaces" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgProductAttributes">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProductAttributes" LoadingPanelID="ralpRoles" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProductAttributes" LoadingPanelID="ralpRoles" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="ralpRoles" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
