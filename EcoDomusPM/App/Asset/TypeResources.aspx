<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TypeResources.aspx.cs" Inherits="App_Asset_TypeResources" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head id="Head1" runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">

            function resize_Nice_Scroll() {

//                $(".divScroll").getNiceScroll().resize();
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

            function Clear(sender, eventargs) {
                document.getElementById("txtSearch").value = "";
                return false;
            }

            function deleteResource() {
                var flag;
                flag = confirm("Do you want to delete this Resource?");
                return flag;
            }
            function AddResource() {
                document.getElementById('trAddResource').style.display = "block";
                ////////////////////////////////////
                var cmb_category = $find("<%= cmb_category.ClientID %>");
                cmb_category.clearSelection();

                document.getElementById("<%= txtName.ClientID %>").value = "";
                document.getElementById('txtDescription').value = "";
                document.getElementById('trbtnAddResource').style.display = "none";
                var obj = parent.window.frames[1];
                if (obj != null) {

                    window.parent.resize_iframe(parent.window.frames[1]);

                }
                return false;
            }
            function CancelAddResource() {
                document.getElementById('trAddResource').style.display = "none";
                document.getElementById('trbtnAddResource').style.display = "block";
                var obj = parent.window.frames[1];
                if (obj != null) {

                    window.parent.resize_iframe(parent.window.frames[1]);

                }
                return false;
            }

            function validate() {
                alert("Resource with this name already exists.");
                return false;
            }
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {

                var pageSize = document.getElementById("hfDocumentPMPageSize").value;
                var scrollArea = sender.GridDataDiv;
                var dataHeight = sender.get_masterTableView().get_element().clientHeight;
                if (!flag) {
             
                    if (dataHeight < (parseInt(pageSize) +2 ) * 40) {
                        scrollArea.style.height = dataHeight + "px";
                    }
                    else {
                        scrollArea.style.height = ((parseInt(pageSize) - 2) * 40 + 10) + "px";

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
        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
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
            border-width: 1px;
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
    </style>
    <style>
          
            html
            {   
                
               overflow-y:hidden;
               -ms-overflow-x:auto;
              
            }
             .gridHeaderText
            {
                font-family: "Arial" , sans-serif;
                font-size: 16px;
                height: 25px;
                font-weight: bold;
                background-color: #AFAFAF;
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
    <style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
        
        .style2
        {
            width: 103px;
        }
    </style>
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG');margin: 0px 0px 0px 0px; padding:0px 0px 0px 0px; ">
    <form id="form1" runat="server" defaultfocus="txtSearch">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" >
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <telerik:RadFormDecorator ID="QsfFromDecorator1" runat="server" DecoratedControls="CheckBoxes, RadioButtons, Buttons, Textbox"
        EnableRoundedCorners="false" />
    <fieldset id="fldsearch" style="padding-top: 0; padding-left: 0; border: 0;" runat="server">
        <table style="padding-left: 0;" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td id="Td1" runat="server" visible="false">
                    <asp:Label ID="lbl_entity_name" CssClass="LabelText" runat="server"></asp:Label>
                    <asp:Label ID="lbl_entity_value" CssClass="LabelText" runat="server"></asp:Label>
                     
                </td>
            </tr>
                        
        </table>
        <table width="100%" style="table-layout : fixed;">
            <tr>
                <td class="centerAlign" style="width: 100%;">
                    <div class="rpbItemHeader">
                     <table cellpadding="0" cellspacing="0" width="100%" style="background-color:#808080;">
                        <tr>
                            <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width:35%;">
                              <asp:Label runat="server" Text="Resources" ID="lbl_grid_head" CssClass="gridHeadText"
                                                        Width="200px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                            </td>
                             <%--<td id="Td2" onclick="stopPropagation(event)" visible="false" runat="server">
                                                        <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Facility_Name%>"
                                                            CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10">:</asp:Label>
                                                        :<asp:Label runat="server" ID="lblFacilityName" CssClass="Label" Visible="false"></asp:Label>
                             </td>--%>  
                              <%--<td id="Td3" runat="server" visible="false">
                                                        <asp:Label ID="lblzone" runat="server" Text="<%$Resources:Resource,  Zone_Name%>"
                                                            CssClass="LabelText"></asp:Label>
                                                        <asp:Label ID="lblzonename" runat="server" CssClass="LabelText"></asp:Label>
                                                    </td>--%>
                                <%--<td>
                                                        <div id="divFloorDropDown" runat="server" style="display: none">
                                                            <asp:Label ID="lblFloorName" Text="<%$Resources:Resource,  Floor_Name%>" CssClass="LabelText"
                                                                runat="server" Visible="true"></asp:Label>
                                                            <telerik:RadComboBox ID="rcbFloors" runat="server" Filter="Contains" Width="185px">
                                                            </telerik:RadComboBox>
                                                        </div>                                                        
                                                    </td>--%>

                              <td align="right" style=" background-color:#808080;padding-top: 02px; padding-bottom: 02px;" onclick="stopPropagation(event)">
                                <div id="div1" style="width: 200px; background-color: white;" onclick="stopPropagation(event)">
                                    
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
                            <td align="right" style="padding: 4px 6px 0 0;width:20px;" >
                               <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                  
                            </td>
                        </tr>
                    </table>
                    </div>
                    <div id="divSelectedDomponentContent" >
                        <telerik:RadGrid ID="rgResources" runat="server" CellPadding="0" CellSpacing="0"
                            BorderWidth="1px" GridLines="None" AllowPaging="true" OnPageIndexChanged="rgResources_OnPageIndexChanged"
                            CssClass="rgcss1" AllowSorting="true" AutoGenerateColumns="False" OnPageSizeChanged="rgResources_OnPageSizeChanged"
                            OnSortCommand="rgResources_OnSortCommand" OnItemCommand="rgResources_OnItemCommand"
                            PagerStyle-AlwaysVisible="true" PageSize="10" ItemStyle-Wrap="false" AllowMultiRowSelection="true"
                            OnItemDataBound="rgResources_ItemDataBound" 
                            OnPreRender="rgResources_OnPreRender" onitemcreated="rgResources_ItemCreated">
                            <PagerStyle Mode="NextPrevAndNumeric" Width="100%" AlwaysVisible="true" />
                            <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                <Selecting AllowRowSelect="true" />
                                                              
                                <Scrolling AllowScroll="true"  UseStaticHeaders="true" ScrollHeight="400" />
                                <ClientEvents OnGridCreated="GridCreated"  />
                            </ClientSettings>
                            <MasterTableView EditMode="EditForms" DataKeyNames="pk_resource_id" ClientDataKeyNames="pk_resource_id"
                                Width="100%" CommandItemDisplay="Top" CommandItemSettings-ShowRefreshButton="false" CommandItemSettings-AddNewRecordText="Add Resources" GroupLoadMode="Client" ExpandCollapseColumn-Visible="false" HeaderStyle-CssClass="gridHeaderText">
                                <GroupHeaderItemStyle BorderWidth="0px" Width="2%" />
                          
                                <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10"  />
                                <AlternatingItemStyle Height="31px"  Font-Names="Arial" Font-Size="10" />
                                 <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                <FooterStyle Height="25px" Font-Names="Arial"/>
                                <Columns>
                                    <telerik:GridEditCommandColumn HeaderStyle-Width="5%" ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                        ItemStyle-Width="5%" HeaderText="<%$Resources:Resource,Edit%>">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" BackColor="#8E8E8E" Font-Size="14px" />
                                        <%--<ItemStyle  Width="5%" Wrap="false" />--%>
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridBoundColumn DataField="Resource_name" UniqueName="Resource_name" HeaderText="<%$Resources:Resource,Resource_Name%>"
                                        EditFormColumnIndex="0" Resizable="false" SortExpression="Resource_name">
                                        <ItemStyle  Wrap="false" />
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40%" BackColor="#8E8E8E"
                                            Font-Size="14px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource,Category%>" DataField="resource_category_name"
                                        UniqueName="resource_category_name" EditFormColumnIndex="1" SortExpression="resource_category_name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblresourcecategory" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"resource_category_name")%>'> </asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cmb_resource_category" runat="server" Width="150px" EmptyMessage="--Select--">
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <ItemStyle  Width="100px" Wrap="false" />
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" BackColor="#8E8E8E" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="Resource_description" HeaderText="<%$Resources:Resource,Description%>"
                                        SortExpression="Resource_description" EditFormColumnIndex="2" AllowSorting="true">
                                        <ItemStyle VerticalAlign="Top" Height="40px"  Width="20%" Wrap="false" />
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" BackColor="#8E8E8E" Font-Size="14px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="pk_resource_id" UniqueName="pk_resource_id"
                                        Visible="true" HeaderText="<%$Resources:Resource,Delete%>" HeaderStyle-Width="7%">
                                        <ItemStyle  Width="5%" />
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" BackColor="#8E8E8E" Font-Size="14px" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" AlternateText="Delete" CommandName="deleteResource"
                                                ImageUrl="~/App/Images/Delete.gif" Height="18px" OnClientClick="javascript:return deleteResource();" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="pk_resource_id" UniqueName="pk_resource_id" Visible="False"
                                        ReadOnly="true" Display="false">
                                        <ItemStyle  />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <EditFormSettings ColumnNumber="3" EditFormType="AutoGenerated" CaptionFormatString="Edit Resources :">
                                    <FormTableItemStyle Width="20%" Height="40px" Wrap="False"></FormTableItemStyle>
                                    <FormCaptionStyle ></FormCaptionStyle>
                                    <FormMainTableStyle GridLines="None" BackColor="White" Width="100%" />
                                    <FormTableStyle BackColor="White"  Height="40px" />
                                    <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                                    <EditColumn ButtonType="ImageButton" UpdateText="Update record" UniqueName="EditCommandColumn1"
                                        CancelText="Cancel edit" UpdateImageUrl="~/App/Images/sign1.jpg">
                                    </EditColumn>
                                    <EditColumn UniqueName="EditColumn">
                                    </EditColumn>
                                    <FormTableButtonRowStyle HorizontalAlign="Right" CssClass=""></FormTableButtonRowStyle>
                                </EditFormSettings>
                            </MasterTableView>
                            <ValidationSettings CommandsToValidate="Update" />
                            <ClientSettings AllowColumnsReorder="true" ReorderColumnsOnClient="true">
                                <Resizing ResizeGridOnColumnResize="True" AllowResizeToFit="true"></Resizing>
                            </ClientSettings>
                            <AlternatingItemStyle CssClass="alternateColor" />
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td style="height: 10">
                <asp:HiddenField ID="hfDocumentPMPageSize"  runat="server" Value="" />
                </td>
            </tr>
            
            <tr id="trAddResource" runat="server" style="display: none;">
               
                <td>
                    <asp:Button ID="btnAddResource" runat="server" Text="<%$Resources:Resource,Add_Resource%>"
                        CausesValidation="false" Width="150px" OnClientClick="javascript:return AddResource();" />
                        <asp:HiddenField ID="hf_Resource_id" runat="server" />
                </td>
              
                           <td>
                    <table border="0">
                        <tr>
                            <td>
                                <asp:Label ID="Label2" runat="server" CssClass="captiondock" Text="<%$Resources:Resource,Add_Resource%>">:</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th style="width: 100px" align="left">
                                <asp:Label ID="Label3" runat="server" CssClass="normalLabel1" Text="<%$Resources:Resource,Resource_Name%>">:</asp:Label>:
                            </th>
                            <td>
                                <telerik:RadTextBox ID="txtName" runat="server" CssClass="SmallTextBox" TabIndex="1"
                                    Width="185px">
                                </telerik:RadTextBox>
                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator2" runat="server"
                                    ValidationGroup="RequiredField" ControlToValidate="txtName" ErrorMessage="*"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <th style="width: 100px" align="left">
                                <asp:Label ID="Label5" runat="server" CssClass="normalLabel1" Text="<%$Resources:Resource,Category%>">:</asp:Label>:
                            </th>
                            <td>
                                <telerik:RadComboBox ID="cmb_category" MarkFirstMatch="true" runat="server" Width="185px"
                                    EmptyMessage="--Select--" TabIndex="4">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <th style="width: 100px" align="left">
                                <asp:Label ID="Label8" runat="server" CssClass="normalLabel1" Text="<%$Resources:Resource,Description%>">:</asp:Label>:
                            </th>
                            <td>
                                <telerik:RadTextBox ID="txtDescription" runat="server" CssClass="SmallTextBox" TabIndex="5"
                                    Width="185px">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Button ID="btnSave" runat="server" TabIndex="7" Text="<%$Resources:Resource,Save%>"
                                    Width="100px" ValidationGroup="RequiredField" OnClick="btnSave_Click" />
                                <asp:Button ID="btnCancel" runat="server" TabIndex="8" Text="<%$Resources:Resource,Cancel%>"
                                    Width="100px" OnClientClick="javascript:return CancelAddResource();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </fieldset>
     <telerik:RadAjaxManager ID="my_pa" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgResources" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgResources">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgResources" LoadingPanelID="RadAjaxLoadingPanel1" />
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
