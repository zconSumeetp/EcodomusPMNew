<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FacilityAttributes.aspx.cs" Inherits="FacilityAttributes" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title> 
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

<script type="text/javascript" language="javascript">
    //window.onload = body_load;
    function resize_Nice_Scroll() {

     // $(".divScroll").getNiceScroll().resize();
        }

        function body_load() {
           
            document.getElementById("<%=txtSearch.ClientID %>").focus();
            
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
        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }

        function Clear() {
            document.getElementById("txtSearch").value = "";
            return false;
        }

        function delete_attribute() {
            var delete_attribute = confirm("Do you want to delete this attribute?");
            return delete_attribute;
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

        function resize_frame_page()
         {
            //window.resizeTo(1000, height);
              
             var docHeight;
               try {
                     var obj=parent.window.frames[1];
                     if (obj != null) 
                      {

                          window.parent.resize_iframe(parent.window.frames[1]);
                        
                      }
                    }
              catch (e) 
               {
                     window.status = 'Error: ' + e.number + '; ' + e.description;
              }
           
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

        function openpopupVersioning(attributeid, attributeflag) {


            manager = $find("rad_windowmgr");
            var url;
            url = "../Asset/AttributeVersioningPopup.aspx?attribute_id=" + attributeid + "&attribute_flag=" + attributeflag + "";
            if (manager != null) {
                var windows = manager.get_windows();
                windows[0].setUrl(url);
                windows[0].show();
                //windows[0].set_modal(false);
                //  window.moveBy(0, -20);

            }
            return false;
        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

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


//        function deleteAttributes() {
//          
//            var s1 = $find("<%=rgAttributes.ClientID %>");
//            var MasterTable = s1.get_masterTableView();

//            var selectedRows = MasterTable.get_selectedItems();
//            var s = "";

//            var entityname = document.getElementById("<%=hf_entity_name.ClientID%>").value;

//            for (var i = 0; i < selectedRows.length; i++) {
//                s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("attribute_id") + ",";
//            }

//            if (s == "") {
//                alert("Please select Attribute");
//                return false;
//            }
//            else {
//                document.getElementById("hf_Attribute_id").value = s;
//                var manager = $find("<%=RadWindowManager1.ClientID%>");
//                var itemtodelete;
//                itemtodelete = document.getElementById("hf_Attribute_id").value;

//                if (entityname == "Facility") {
//                    var url = "../Asset/DeleteAttribute.aspx?attribute_id=" + itemtodelete.toString() + "&flag=facility" + "&EntityDataId=" + document.getElementById("<%=hf_entity_data_id.ClientID%>").value + "&EntityName=" + document.getElementById("<%=hf_entity_name.ClientID%>").value;
//                }
////                else if (entityname == "Space") {
////                    var url = "../Asset/DeleteAttribute.aspx?attribute_id=" + itemtodelete.toString() + "&flag=space" + "&EntityDataId=" + document.getElementById("<%=hf_entity_data_id.ClientID%>").value + "&EntityName=" + document.getElementById("<%=hf_entity_name.ClientID%>").value;
////                }
////                else if (entityname == "Zone") {
////                    var url = "../Asset/DeleteAttribute.aspx?attribute_id=" + itemtodelete.toString() + "&flag=zone" + "&EntityDataId=" + document.getElementById("<%=hf_entity_data_id.ClientID%>").value + "&EntityName=" + document.getElementById("<%=hf_entity_name.ClientID%>").value;
////                }

//                if (manager != null) {
//                    var windows = manager.get_windows();
//                    windows[0].setUrl(url);
//                    windows[0].show();
//                }
//                return false;
//            }

//        }
        function deleteAttributes() {
            var s1 = $find("<%=rgAttributes.ClientID %>"); 
            var MasterTable = s1.get_masterTableView();
            var selectedRows = MasterTable.get_selectedItems();
            var s = "";
            for (var i = 0; i < selectedRows.length; i++) {
                s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("attribute_id") + ",";
            }

            if (s == "") {
                alert("Please select Attribute");
                return false;
            }
            else {

                var delete_attribute = confirm("Do you want to delete this attribute?");
                if (delete_attribute) {

                    document.getElementById("hf_Attribute_id").value = s;
                }
                else
                    return delete_attribute;

            }
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
        <style type="text/css">
        .RadWindow_Simple .rwTitlebar
        {
            background-color: #FFA500;
            font-family: Arial;
            font-size: large;
        }
        
        .RadWindow_Simple
        {
            border: solid 0px #616161;
        }
        
            .RadWindow_Simple .rwCorner .rwTopLeft,  
            .RadWindow_Simple .rwCorner .rwTopRight,  
            .RadWindow_Simple .rwIcon, 
            .RadWindow_Simple table .rwTopLeft,  
            .RadWindow_Simple table .rwTopRight,  
            .RadWindow_Simple table .rwFooterLeft,  
            .RadWindow_Simple table .rwFooterRight,  
            .RadWindow_Simple table .rwFooterCenter,  
            .RadWindow_Simple table .rwBodyLeft,  
            .RadWindow_Simple table .rwBodyRight,  
            .RadWindow_Simple table .rwTopResize, 
            .RadWindow_Simple table .rwStatusbar, 
            .RadWindow_Simple table .rwStatusbar .rwLoading 
             {    
                 display: none !important;   
             }
            .RadWindow_Simple .rwTitlebar,
            .RadWindow_Simple .rwCloseButton
            {
                background-color:#FFA500;
                font-family:Arial;
                font-size:large;
            }
             
            .RadWindow_Simple .rwControlButtons A:hover
             {
                 border-color: #FFA500;
                 background-color:#FFA500;
                 border:1px solid #FFA500;
             }
            .RadWindow_Simple .rwWindowContent
            {
                border:0px;
            }
            .RadWindow_Simple .rwControlButtons A
            {
                 border-color: #FFA500;
                 background-color:#FFA500;
                 border:1px solid #FFA500;
            }
            DIV.RadWindow_Simple .rwShadow EM
            {
                padding:7px 0 0 15px
            }
            
            .RadWindow .rwTitleRow EM
            {
                font:normal 15px "Segoe UI",Arial;
                overflow:hidden;
                white-space:nowrap;
                float:left;
                text-transform:inherit;
                padding-top:0px;
                padding-left:10px;
            }
        
       
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
            height:100%;
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
         
         .column
         {
             font-size:13px;
             font-family:Arial;
         } 
             
        .searchImage
        {
            background-image: url('/App/Images/Icons/icon_search_sm.png');
            background-repeat: no-repeat;
            background-position: right;
            font-family: "Arial" , sans-serif;
            font-size: 12px;
        }
        .gridHeadText
        {
            font-family: "Verdana" , "Sans-Serif";
            font-style: normal;
            font-size: medium;
            color: White;
        }
        .entityImage
        {
            padding-left: 7px;
        }
        .gridHeaderText
        {
            font-family: "Arial" , sans-serif;
            font-size: 16px;
            height: 20px;
            font-weight: bold;
            background-color: #AFAFAF;
        }
        
        .gridRadPnlHeader
        {
            background-color: Gray;
            height: 30px;
            width: 100%;
            vertical-align: middle;
        }
        .captiondock
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
            color: #990000;
            text-align: left;
            vertical-align: middle;
            margin-top: 10px;
            margin-bottom: 10px;
            font-weight: normal;
        }
        
        .gridRadPnlHeaderBottom
        {
            background-color: Orange;
            height: 1px;
            width: 100%;
        }
        .dropDownImage
        {
            right: 15px;
        }
        
        .searchTextBox
        {
            position: relative;
            right: 10px;
        }
        
        .wizardHeadImage
        {
            background-color: #FFA500;
            height: 30px;
            background-attachment: scroll;
            width: 100%;
            background-attachment: fixed;
            background-position: right;
            background-repeat: no-repeat;
            position: relative;
        }
        .wizardLeftImage
        {
            float: left;
            padding-left: 15px;
            vertical-align: middle;
            height: 20;
            right: 5px;
        }
        .wizardRightImage
        {
            float: right;
            padding-right: 10px;
            vertical-align: middle;
            height: 20;
        }
        
        .normalLabelBold
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            font-weight: bold;
        }
        .headerBoldLabel
        {
            font-family: "Arial" , sans-serif;
            font-size: 16px;
            font-weight: bold;
        }
        
        .lblHeading
        {
            font-family: "Arial";
            font-size: 10px;
        }
        
        .tdValign
        {
            vertical-align: top;
            margin: 0;
        }
        .lnkButton
        {
            font-family: "Arial";
            font-size: 10px;
            color: Black;
            text-decoration: none;
        }
        
        .lnkButtonImg
        {
            height: 14px;
            vertical-align: bottom;
        }
        
        
        .lblBold
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            height: 20px;
            vertical-align: middle;
            font-weight: bold;
        }
        
        .gridHeaderBoldText
        {
            font-family: "Arial" , sans-serif;
            font-size: 14px;
            vertical-align: bottom;
            font-weight: bold;
        }
        
        
        .textAreaScrollBar
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            overflow: auto;
            padding-left: 10px;
            padding-top: 10px;
            border-left-color: #D4D4C3;
            border-top-color: #D4D4C3;
            border-bottom-color: #E8E8E8;
            border-right-color: #E8E8E8;
            height: 170px;
        }
      
            
    </style>
     <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="~/App_Themes/EcoDomus/PopupStyleSheet.css" />--%>
    <link rel="stylesheet" type="text/css" href="~/App_Themes/EcoDomus/PopupStyleSheet.css" />
   <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG');margin: 0px 0px 0px 0px; padding: 0px; ">
    <form id="form1" runat="server" defaultfocus="txtSearch">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="360000">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Default" DecoratedControls="Buttons" />
   <table border="0" width="99%" style="margin: 0px 0px 0px 0px;padding:0px; ">
         <tr>
                <td colspan="2" style="display:none;">
               <asp:HiddenField ID="hf_entity_name" runat="server" />
               <asp:HiddenField ID="hf_entity_data_id" runat="server" />
               <asp:HiddenField ID="hf_Attribute_id" runat="server" />
               <asp:HiddenField ID="hfAttributePMPageSize" runat="server" />
              </td>
         </tr>
        <tr>
        <td  class="centerAlign" style=" padding-top: 0px;">
           <div class="rpbItemHeader ">
            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                            <tr>
                                <td align="left" class="entityImage"  style="width: 50%;">
                               <asp:Label runat="server" ID="lbl_grid_head" CssClass="gridHeadText" Width="200px" Text="Attributes"
                                        ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                    >
                                    
                                    <div id="div_search" style="width: 200px; background-color: white;" >
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="180px">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                <asp:ImageButton ClientIDMode="Static"  ID="btnSearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                 OnClick="btnSearch_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    
                                </td>
                                <td align="right" style="padding: 4px 4px 0 0;">
                                   <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                        ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
           <div id="divSelectedDomponentContent" >
                        <telerik:RadGrid ID="rgAttributes" runat="server" BorderWidth="1px" CellPadding="0"
                            GridLines="None" AllowPaging="true" OnPageIndexChanged="rgAttributes_OnPageIndexChanged"
                            Width="100%"  OnPageSizeChanged="rgAttributes_OnPageSizeChanged" OnSortCommand="rgAttributes_OnSortCommand"
                            MasterTableView-AllowAutomaticInserts="true" OnItemCommand="rgAttributes_OnItemCommand"
                            AllowSorting="true" OnItemDataBound="rgAttributes_OnItemDataBound" AutoGenerateColumns="False"
                            PagerStyle-AlwaysVisible="true" Skin="Default" PageSize="10" ItemStyle-Wrap="false"
                            AllowMultiRowSelection="true" CellSpacing="0" 
                            OnPreRender="rgAttributes_OnPreRender" onitemcreated="rgAttributes_ItemCreated">
                            <PagerStyle Mode="NextPrevAndNumeric"   />
                            <ClientSettings  EnableRowHoverStyle="true">
                                <Selecting AllowRowSelect="true" />
                                <Scrolling AllowScroll="true"  UseStaticHeaders="true" ScrollHeight="400" />
                                <ClientEvents OnGridCreated="GridCreated"  OnRowDblClick="RowDblClick" />
                            </ClientSettings>
                            <MasterTableView EditMode="EditForms" DataKeyNames="attribute_id,attribute_unit"
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" CommandItemDisplay="Top" CommandItemSettings-AddNewRecordText="Add Attribute"
                                CommandItemSettings-ShowRefreshButton="true"  CommandItemSettings-RefreshText="Delete"
                                CommandItemSettings-RefreshImageUrl="../Images/Buttons/Delete.gif" ClientDataKeyNames="attribute_id"
                                GroupLoadMode="Client">
                                <CommandItemTemplate >
                                <asp:LinkButton ID="lkbtnAddAttribute" CommandName="InitInsert" runat="server" ToolTip="Add Attribute"  >
                                    <img   src="../Images/Icons/asset_add_sm.png" style="padding:6px;border:0px; margin-left:05px;  " />
                                </asp:LinkButton>
                                <asp:Label runat="server"  ID="lblAddAttribute"  Text="Add Attribute"  ToolTip="Add Attribute"  ></asp:Label>
                                <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="javascript:return deleteAttributes();" CommandName="delete" Text="Delete Attribute"  >
                                    <img   src="../Images/Buttons/Delete.gif" style="padding:6px;border:0px; margin-left:25px; margin-top:3px; margin-bottom:3px; " />
                                </asp:LinkButton>
                                <asp:Label runat="server"  ID="lblDeleteAtt"  Text="Delete "  ToolTip="Delete Attribute"  ></asp:Label>
                                </CommandItemTemplate>
                                <GroupByExpressions>
                                    <telerik:GridGroupByExpression>
                                        <SelectFields>
                                            <telerik:GridGroupByField FieldAlias="Group" FieldName="Attribute_group" FormatString=""
                                                HeaderText="" SortOrder="None"></telerik:GridGroupByField>
                                        </SelectFields>
                                        <GroupByFields>
                                            <telerik:GridGroupByField FieldName="Attribute_group"></telerik:GridGroupByField>
                                        </GroupByFields>
                                    </telerik:GridGroupByExpression>
                                </GroupByExpressions>
                                    
                                <Columns>
                                    <telerik:GridEditCommandColumn HeaderStyle-Width="3%" ButtonType="ImageButton"
                                        UniqueName="EditCommandColumn"  HeaderText="<%$Resources:Resource,Edit%>">
                                         <ItemStyle CssClass="column" Width="3%" Wrap="false" />
                                        <HeaderStyle CssClass="column" Width="3%" Wrap="false" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridClientSelectColumn UniqueName="chkSelect" HeaderText="<%$Resources:Resource,Delete%>">
                                       <ItemStyle CssClass="column" Width="2%" Wrap="false" />
                                      <HeaderStyle  CssClass="column" Width="3%" Wrap="false" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridBoundColumn DataField="Attribute_name" UniqueName="Attribute_name" HeaderText="<%$Resources:Resource,Attribute_Name%>"
                                        EditFormColumnIndex="0" SortExpression="Attribute_name">
                                        <ItemStyle CssClass="column" Width="23%" Wrap="false" />
                                        <HeaderStyle CssClass="column" Width="23%" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Attribute_value" HeaderText="<%$Resources:Resource,Value%>"
                                        EditFormColumnIndex="0">
                                       <ItemStyle CssClass="column" Width="10%" Wrap="false" />
                                        <HeaderStyle CssClass="column" Width="10%" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource,Unit%>" DataField="attribute_unit" UniqueName="unitName"
                                        EditFormColumnIndex="0" SortExpression="attribute_unit">
                                        <ItemTemplate>
                                            <asp:Label ID="lblunit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"attribute_unit")%>'> </asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cmb_unit" runat="server" Width="150px" Height="150" EmptyMessage="--Select--">
                                            </telerik:RadComboBox>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="cmb_unit"
                                        ErrorMessage="*" runat="server" Display="Dynamic" ForeColor="Red">
                                    </asp:RequiredFieldValidator>--%>
                                        </EditItemTemplate>
                                        <ItemStyle CssClass="column" Width="15%" Wrap="false" />
                                        <HeaderStyle CssClass="column" Width="15%" Wrap="false" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource,Stage%>" DataField="Attribute_stage_name" UniqueName="StageName"
                                        EditFormColumnIndex="1" SortExpression="Attribute_stage_name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblstage" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Attribute_stage_name")%>'> </asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cmb_stage" runat="server" Width="150px" Height="150" EmptyMessage="--Select--">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="cmb_stage"
                                                ErrorMessage="*" runat="server" Display="Dynamic" ForeColor="Red">
                                            </asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                      <ItemStyle CssClass="column" Width="15%" Wrap="false" />
                                        <HeaderStyle CssClass="column" Width="15%" Wrap="false" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Group" DataField="Attribute_group" EditFormColumnIndex="1"
                                        SortExpression="Attribute_group" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblgroup" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Attribute_group")%>'> </asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cmb_group"  runat="server" Width="150px" Height="150" EmptyMessage="--Select--">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="cmb_group"
                                                ErrorMessage="*" runat="server" Display="Dynamic" ForeColor="Red">
                                            </asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                       <ItemStyle CssClass="column" Width="15%" Wrap="false" />
                                        <HeaderStyle CssClass="column" Width="15%" Wrap="false" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="Attribute_description" HeaderText="<%$Resources:Resource,Description%>"
                                        EditFormColumnIndex="1">
                                       <ItemStyle CssClass="column" Width="25%" Wrap="false" />
                                        <HeaderStyle CssClass="column" Width="25%" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Attribute_id" UniqueName="Attribute_id" Visible="False"
                                        ReadOnly="true" Display="false">
                                        <ItemStyle CssClass="column" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="" UniqueName="Versioning" Resizable="true" SortExpression="attribute_id"
                                        HeaderText="<%$Resources:Resource,Version%>">
                                        <ItemStyle CssClass="column" Width="10%" Wrap="false" />
                                        <HeaderStyle CssClass="column" Width="10%" Wrap="false" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnHistory" runat="server" ImageUrl="~/App/Images/history.png"
                                                Height="30px" Width="30px" alt="History" CommandName="Versioning" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                   
                                </Columns>
                                <EditFormSettings ColumnNumber="3" EditFormType="AutoGenerated" CaptionFormatString="Edit Attributes:">
                                    <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                    <FormCaptionStyle CssClass="column"></FormCaptionStyle>
                                    <FormMainTableStyle GridLines="None" BackColor="White" Width="100%" />
                                    <FormTableStyle BackColor="White" Height="110px" />
                                    <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                                    <EditColumn ButtonType="ImageButton" UpdateText="Update record" UniqueName="EditCommandColumn1"
                                        CancelText="Cancel" UpdateImageUrl="~/App/Images/sign1.jpg">
                                    </EditColumn>
                                    <EditColumn ButtonType="ImageButton" InsertText="Insert Record"  UniqueName="EditColumnInsertColum2"
                                        CancelText="Cancel" InsertImageUrl="~/App/Images/sign1.jpg">
                                    </EditColumn>
                                    <EditColumn UniqueName="EditColumn">
                                    </EditColumn>
                                    <FormTableButtonRowStyle HorizontalAlign="Right" CssClass=""></FormTableButtonRowStyle>
                                </EditFormSettings>
                            </MasterTableView>
                            <ValidationSettings CommandsToValidate="Update" />
                           
                            <AlternatingItemStyle CssClass="alternateColor" />
                        </telerik:RadGrid>
                    </div>
                
            </td>
        </tr>
        <tr>
        <td id="Td1" runat="server" visible="false">
        <asp:Label ID="lbl_entity_name"  CssClass="LabelText" runat="server"></asp:Label>
        <asp:Label ID="lbl_entity_value" CssClass="LabelText" runat="server"></asp:Label>
        </td>
        </tr>
         
        <tr id="trbtnAddAttribute" style="display:none;">
            <td>
                <asp:Button ID="btnAddAttribute" runat="server" Text="<%$Resources:Resource,Add_Attribute%>" CausesValidation="false"
                    Width="150px" OnClientClick="javascript:return AddAttribute();" />
            <asp:Button ID="btnDelete" runat="server" Text="<%$Resources:Resource,Delete%>" CausesValidation="false"
                    Width="100px" OnClientClick="javascript:return deleteAttributes();" OnClick="btnDelete_Click" />
            </td>
            <td>
                
            </td>
        </tr>
        <tr id="trAddAttribute" runat="server" style="display: none;">
            <td style="height:100%">
                <table border="0">
                    <caption>
                    <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Add_Attribute%>">:</asp:Label>
                        
                    </caption>
                    <tr>
                        <th style="width: 100px" align="left">
                        <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,Name%>">:</asp:Label>:
                            
                        </th>
                        <td>
                            <asp:TextBox ID="txtName" runat="server" CssClass="SmallTextBox" TabIndex="1"></asp:TextBox>
                            <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidatorName" runat="server"
                                ValidationGroup="RequiredField" ControlToValidate="txtName" ErrorMessage="*"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 100px" align="left">
                        <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource,Value%>">:</asp:Label>:

                            
                        </th>
                        <td>
                            <asp:TextBox ID="txtValue" runat="server" CssClass="SmallTextBox" TabIndex="2"></asp:TextBox>
                            <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator1" runat="server"
                                ValidationGroup="RequiredField" ControlToValidate="txtValue" ErrorMessage="*"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 100px" align="left">
                        <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,Unit%>">:</asp:Label>:
                            
                        </th>
                        <td>
                            <telerik:RadComboBox ID="cmb_uom" MarkFirstMatch="true" runat="server" Width="185px"
                                EmptyMessage="--Select--" TabIndex="3">
                            </telerik:RadComboBox>
                            <%--<asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator3" runat="server"
                                ValidationGroup="RequiredField" ControlToValidate="cmb_uom" ErrorMessage="*"
                                ForeColor="Red"></asp:RequiredFieldValidator>--%>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 100px" align="left">
                         <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource,Stage%>">:</asp:Label>:
                            
                            
                        </th>
                        <td>
                            <telerik:RadComboBox ID="cmbStage" MarkFirstMatch="true" runat="server" Width="185px" TabIndex="4">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator4" runat="server"
                                ValidationGroup="RequiredField" ControlToValidate="cmbStage" ErrorMessage="*"
                                ForeColor="Red" InitialValue="--Select--"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 100px" align="left">
                        <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource,Group%>">:</asp:Label>:
                            
                        </th>
                        <td>
                            <telerik:RadComboBox ID="cmbGroup_outer" MarkFirstMatch="true" runat="server" Width="185px" TabIndex="5">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator5" runat="server"
                                ValidationGroup="RequiredField" ControlToValidate="cmbGroup_outer" ErrorMessage="*"
                                ForeColor="Red" InitialValue="--Select--"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 100px" align="left">
                        <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource,Description%>">:</asp:Label>:
                        
                         
                        </th>
                        <td>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="SmallTextBox" TabIndex="6"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Button ID="btnSave" runat="server" TabIndex="7" Text="<%$Resources:Resource,Save%>" Width="100px" OnClick="btnSave_Click" ValidationGroup="RequiredField" />
                            <asp:Button ID="btnCancel" runat="server" TabIndex="8" Text="<%$Resources:Resource,Cancel%>" Width="100px"
                                OnClientClick="javascript:return CancelAddAttribute();" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgAttributes">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAttributes" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAttributes" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

       <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px" Skin="Default">
      
    </telerik:RadAjaxLoadingPanel>
     <telerik:RadWindowManager ID="rad_windowmgr"  runat="server"  VisibleTitlebar="true"  Title="Attribute Version" Behaviors="Close,Move" 
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server"  Width="530" 
                Height="450" DestroyOnClose="false" AutoSize="false" VisibleStatusbar="false" VisibleOnPageLoad="false" EnableAjaxSkinRendering="false" BackColor="#EEEEEE" 
                BorderWidth="0px"   >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
   <telerik:RadWindowManager ID="RadWindowManager1" runat="server"  VisibleTitlebar="true"  Title="Delete Attributes" Behaviors="Close,Move" 
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="RadWindow1" runat="server"  BorderWidth="0px"
                ReloadOnShow="True" Width="500" Height="145"   VisibleOnPageLoad="false" Top="200%" Left="250%" EnableAjaxSkinRendering="false"
                BackColor="#EEEEEE">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    </form>
</body>
<%--Please don't move this code--%>
  <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
</html>
