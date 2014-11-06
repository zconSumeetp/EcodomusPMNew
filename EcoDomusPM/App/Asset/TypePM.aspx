<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="TypePM.aspx.cs" Inherits="App_TypePM" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
    <style type="text/css">
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
            height: 100%;
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
        
        .column
        {
            font-size: 13px;
            font-family: Arial;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .column > a
        {
            width: 100%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;        
        }

        .header-cell
        {
            border-left: 1px solid #808080 !important;
        }

        .first-column {
            border-left: none;
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
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadScriptBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript" language="javascript"> 

           // window.onload = body_load;
            function body_load() {

                var screenhtg = set_NiceScrollToPanel();

                if (document.getElementById("<%=txt_search.ClientID %>") != null)
                    document.getElementById("<%=txt_search.ClientID %>").focus();
                //screenhtg = parseInt((screenhtg - 130) / 40); 
                //globalPageHeight = screenhtg;
                //alert(screenhtg);
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

            function rgtype_OnRowDataBound(sender, args) {

                var cell = sender.get_masterTableView().getCellByColumnUniqueName(args.get_item(), "ClientSelectColumn");
            }

            function gridItemAdjustmentOnscreenHeight() {

                //var itemHeight =;rgtype.MasterTableView.HeaderStyle.Height;
                var grid = $find("<%=rgtype.ClientID %>");
                var MasterTable = grid.get_masterTableView();
                var itemHeight = MasterTable.HeaderStyle.Height();
                alert(itemHeight);
            }

            /*
            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {
              
            var view, rowHeight, pageSize, firstRow,pagerControl;
            view = sender.MasterTableView;
            pageSize = view.PageSize;
            firstRow = view._firstRow;
            rowHeight = firstRow.clientHeight;
            pagerControl = sender.PagerControl;
            //pageSize = Math.max(pageSize, Math.floor(sender.get_masterTableView().get_element().clientHeight / rowHeight));
               
              
            var radCombo = $telerik.findElement(pagerControl, "PageSizeComboBox");
            //radCombo.items.clear();
            //var value = radCombo.control._itemData[0].value;
            radCombo.control._itemData[2].selected = true;
            var value = radCombo.control._itemData[0].value;
            radCombo.control._itemData[0].value = "25";
            //var item = radCombo.Attributes.Add("ownerTableViewId", rgtype.MasterTableView.ClientID);
            // radCombo.commitChanges();
            //var radComboItem = $telerik.findElement(radCombo, "RadComboBoxItem");
               
            var scrollArea = sender.GridDataDiv;
            var dataHeight = sender.get_masterTableView().get_element().clientHeight;
            pageSize = Math.max(1, Math.floor((set_NiceScrollToPanel() - 150) / rowHeight));
              
            if (view.PageSize !== 0) {
            if (view.PageSize < pageSize) {
            scrollArea.style.height = view.PageSize * rowHeight + "px";

            }
            else {

            view.PageSize = pageSize;

            if (dataHeight >= pageSize * rowHeight) {
            scrollArea.style.height = pageSize * rowHeight + "px";
            }
            else {
            scrollArea.style.height = pageSize * rowHeight + "px";
            }
            if (view.get_pageCount()) {
            view.PageCount = Math.floor(view._virtualItemCount / pageSize);
            view._pageButtonCount = pageSize;
            //sender.get_masterTableView().set_pageSize(pageSize);
            }
                        
            }
            }
                
            }
            */

            function GridCreated(sender, args) {
                //alert(sender.get_masterTableView().get_pageSize());
                var pageSize = document.getElementById("ContentPlaceHolder1_hfTypePMPageSize").value;
                var scrollArea = sender.GridDataDiv;
                var dataHeight = sender.get_masterTableView().get_element().clientHeight;

                if (dataHeight < parseInt(pageSize) * 40) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
                }

                //sender.get_masterTableView().set_pageSize(globalPageHeight);
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

                // $(".divScroll").getNiceScroll().resize();
            }

            function resize_Nice_Scroll() {


                set_NiceScrollToPanel();

                if (document.getElementById("<%=txt_search.ClientID %>") != null)
                    document.getElementById("<%=txt_search.ClientID %>").focus();

            } 
        </script>
        <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    </telerik:RadScriptBlock>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" language="javascript">


            /*--for facility dropdown with checkboxes -->>  --*/
            function checkboxClick(sender) {
               
                collectSelectedItems(sender);
                document.getElementById("<%=btn_navigate.ClientID %>").click();

            }

            function collectSelectedItems(sender) {
                
                var combo = $find(sender);
                var items = combo.get_items();

                var selectedItemsTexts = "";
                var selectedItemsValues = "";

                var itemsCount = items.get_count();

                for (var itemIndex = 0; itemIndex < itemsCount; itemIndex++) {
                    var item = items.getItem(itemIndex);

                    var checkbox = getItemCheckBox(item);

                    //Check whether the Item's CheckBox) is checked.
                    if (checkbox.checked) {
                        selectedItemsTexts += item.get_text() + ", ";
                        selectedItemsValues += item.get_value() + ", ";

                    }
                }  //for closed

                selectedItemsTexts = selectedItemsTexts.substring(0, selectedItemsTexts.length - 2);
                selectedItemsValues = selectedItemsValues.substring(0, selectedItemsValues.length - 2);

                //Set the text of the RadComboBox with the texts of the selected Items, separated by ','.
                combo.set_text(selectedItemsTexts);

                //Set the comboValue hidden field value with values of the selected Items, separated by ','.

                if (selectedItemsValues == "") {
                    combo.clearSelection();
                }
                //document.getElementById('ContentPlaceHolder1_hfFacilityid').value = selectedItemsValues;   
               
            }

            function getItemCheckBox(item) {
                //Get the 'div' representing the current RadComboBox Item.
                var itemDiv = item.get_element();

                //Get the collection of all 'input' elements in the 'div' (which are contained in the Item).
                var inputs = itemDiv.getElementsByTagName("input");

                for (var inputIndex = 0; inputIndex < inputs.length; inputIndex++) {
                    var input = inputs[inputIndex];

                    //Check the type of the current 'input' element.
                    if (input.type == "checkbox") {
                        return input;
                    }
                }

                return null;
            }


            /*--for facility dropdown with checkboxes --*/


            function refreshParent() {

                //var rdw = GetRadWindow();
                //rdw.close();
                window.parent.refreshgrid();
                window.close();
            }
            function showMenu_type(e) {
                var contextMenu = $find("<%= rad_panel_disp_column.ClientID %>");

                if ((!e.relatedTarget) || (!$telerik.isDescendantOrSelf(contextMenu.get_element(), e.relatedTarget))) {
                    contextMenu.show(e);
                }
                $telerik.cancelRawEvent(e);
            }



            function fn_Clear() {
                try {
                    document.getElementById("ContentPlaceHolder1_txt_search").value = "";
                    return false;
                }
                catch (e) {
                    alert(e.message + "  " + e.Number);
                    return false;
                }
            }
            function ProjectValidation() {

                alert('Please select Project');
                window.location = '../Settings/Project.aspx';
                return false;

            }

            function GoToTypeProfile() {
                var url = "../Asset/TypeProfileMenu.aspx?type_id=" + document.getElementById("ContentPlaceHolder1_hf_type_id").value;
            }


            function confirmation() {
                var flag;
                flag = confirm("Are you sure you want to delete these types?");
                if (flag)
                    return true;
                else
                    return false;
            }

            function validate() {
                alert("Select the type.");
                return false;
            }


            function openpopupEditMasterFormat() {
                manager = $find("<%=rd_manager.ClientID%>");
                var url;
                var url = "../Asset/EditMasterFormatUniFormat.aspx?page=o";
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                    //windows[0].set_modal(true);
                }
                return false;
            }

            function deletebatchRegister() {

                var manager = $find("<%=RadWindowManager1.ClientID%>");
                var itemtodelete;
                itemtodelete = document.getElementById("ContentPlaceHolder1_hf_type_id").value;
                var url = "../DeleteTypePM.aspx?type_id=" + itemtodelete.toString();
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                    //windows[0].set_modal(true);

                }
                return false;
            }


            function GetSelectedNames() {
                var s = GetSelectedTypes();

                if (s == "") {
                    alert("Please select type");
                    return false;
                }
                else {
                    document.getElementById("ContentPlaceHolder1_hf_type_id").value = s;
                    var manager = $find("<%=RadWindowManager1.ClientID%>");

                    var itemtodelete;
                    itemtodelete = document.getElementById("ContentPlaceHolder1_hf_type_id").value;
                    var url = "../Asset/DeleteTypePM.aspx?type_id=" + itemtodelete.toString();
                    if (manager != null) {
                        var windows = manager.get_windows();
                        windows[0].setUrl(url);
                        windows[0].show();
                        //windows[0].set_modal(true);
                        window[0]._width = "540px";
                        window[0]._height = "540px";
                    }
                    return false;
                }

            }

            function GetSelectedTypes() {
                //var s = sender.get_masterTableView().get_selectedItems()[0].getDataKeyValue("pk_type_id");

                var s1 = $find("<%=rgtype.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("pk_type_id") + ",";
                }

                return s;
            }

            function CheckBeforeMerge() {
                var s = GetSelectedTypes();

                if (s == "") {
                    alert("Please select types");
                    return false;
                } else {
                    if (confirm("Do you want to merge selected types?"))
                        return true;
                    else
                        return false;
                }
            }

            function refreshgrid() {
                //document.getElementById("ContentPlaceHolder1_txt_search").value = name;
                document.getElementById("ContentPlaceHolder1_btn_refresh").click();
            }
            function refreshgrid_new(name) {

                document.getElementById("<%=txt_search.ClientID %>").value = name;
                document.getElementById("ContentPlaceHolder1_btn_refresh").click();
            }

            function disp() {
                var notification = $find("<%=rd_display_window.ClientID %>");
                notification.show();
                return false;
            }
            function disp_unassign() {

                var s1 = $find("<%=rgtype.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[0].getDataKeyValue("pk_type_id") + ",";
                }
                if (s == "") {
                    alert("Please select type");
                    return false;
                }
                else {

                    var notification = $find("<%=rd_unassign_window.ClientID %>");
                    notification.show();
                    return false;
                }

            }

            function display_columns(chk) {
                if (chk.checked) {
                    
                    return true;
                }
            }

            function GetSelectedType() {

                //var s = sender.get_masterTableView().get_selectedItems()[0].getDataKeyValue("pk_type_id");
                //debugger
                var s1 = $find("<%=rgtype.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("pk_type_id") + ",";
                }

                if (s == "") {
                    alert("Please select type");
                    return false;
                }
                else {
                    document.getElementById("ContentPlaceHolder1_hf_type_id").value = s;
                    manager = $find("<%=rd_manger_NewUI.ClientID%>");

                    // var itemtodelete;
                    //itemtodelete = document.getElementById("ContentPlaceHolder1_hf_type_id").value;
                    var url = "../Asset/EditMasterFormatUniFormatNew.aspx?IsFromTypePM=Y&type_id=" + s;  //+ itemtodelete.toString();
                    if (manager != null) {
                        var windows = manager.get_windows();
                        windows[0].setUrl(url);
                        windows[0].show();
                        windows[0].set_modal(false);
                        windows[0].moveTo(400, 65);
                        // window[0]._width = "540px";
                        //window[0]._height ="400";
                    }
                    return false;
                }

            }




            function GetSelectedTypeForDesignerContractorNew() {

                var s1 = $find("<%=rgtype.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("pk_type_id") + ",";
                }

                if (s == "") {
                    alert("Please select type");
                    return false;
                }
                else {
                    //document.getElementById("ContentPlaceHolder1_hf_type_id").value = s;

                    manager = $find("<%=rd_Designer_contractor.ClientID%>");
                    var itemtodelete;
                    itemtodelete = document.getElementById("ContentPlaceHolder1_hf_type_id").value;
                    // var url = "../Asset/EditDesignerContractor.aspx?type_id=" + s; // + itemtodelete.toString();
                    //var url = "../Asset/EditDesignerContractorNew.aspx?type_id=" + s;
                    var url = "../Asset/EditDesignerContractorNew.aspx?type_id=" + s + "&IsFromTypePM=Y&popupflag="; // + itemtodelete.toString();
                    if (manager != null) {
                        var windows = manager.get_windows();
                        windows[0].setUrl(url);
                        windows[0].show();
                        windows[0].set_modal(false);
                        //windows[0].moveTo(250, 100);
                        windows[0].moveTo(400, 65);
                        //                        window[0].center();
                        // window[0]._width = "540px";
                        //window[0]._height ="400";
                    }
                    return false;
                }

            }

            function resizeParentPopupReversBack() {
            }

            function GetSelectedTypeForDesignerContractor() {

                var s1 = $find("<%=rgtype.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("pk_type_id") + ",";
                }

                if (s == "") {
                    alert("Please select type");
                    return false;
                }
                else {
                    //document.getElementById("ContentPlaceHolder1_hf_type_id").value = s;
                    manager = $find("<%=rd_manager1.ClientID%>");

                    var itemtodelete;
                    itemtodelete = document.getElementById("ContentPlaceHolder1_hf_type_id").value;
                    var url = "../Asset/EditDesignerContractor.aspx?type_id=" + s; // + itemtodelete.toString();
                    //var url = "../Asset/EditDesignerContractorNew.aspx?type_id=" + s; // + itemtodelete.toString();
                    if (manager != null) {
                        var windows = manager.get_windows();
                        windows[0].setUrl(url);
                        var bounds = windows[0].getWindowBounds();
                        var x = bounds.x;
                        var y = bounds.y;
                        if (x == 0 && y == 0)
                            windows[0].moveTo(x - 800, -50);
                        windows[0].show();
                        //windows[0].set_modal(true);
                        windows[0]._width = "580px";
                        windows[0]._height = "600px";
                        windows[0]._title = "EcoDomus PM :Assign Designer/Contractor"
                    }
                    return false;
                }

            }

            function chk_validate() {
                if (document.getElementById("<%=chk_master_unassign.ClientID%>").checked == false &&
                        document.getElementById("<%=chk_uniformat_unassign.ClientID%>").checked == false &&
                        document.getElementById("<%=chk_omniclass_unassign.ClientID%>").checked == false &&
                        document.getElementById("<%=chk_designer_unassign.ClientID%>").checked == false &&
                        document.getElementById("<%=chk_contractor_unassign.ClientID%>").checked == false &&
                        document.getElementById("<%=chk_uniclass_unassign.ClientID%>").checked == false) {

                    alert('please select any value');
                    return false;

                }

                else {
                    //                     var notification = $find("<%=rd_unassign_window.ClientID %>");
                    //                     notification.hide();

                    return true;
                }

            }
            function refreshtypepm() {

                document.getElementById("ContentPlaceHolder1_btn_refresh").click();
            }

            function refreshGrid(arg) {

                if (!arg) {
                    $find("<%= RadAjaxManagerProxyTypePM.ClientID %>").ajaxRequest("Rebind");
                }
            }
            function openUpdateNamesPopuo() {

                var s1 = $find("<%=rgtype.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                var s2 = "";
                if (document.getElementById("ContentPlaceHolder1_hf_type_id").value != "") {

                    s = document.getElementById("ContentPlaceHolder1_hf_type_id").value + ",";
                }
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("pk_type_id") + ",";
                    s2 = s2 + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("pk_type_id") + ",";
                }

                if (s == "") {
                    alert("Please select type");
                    return false;
                }
                else {

                    manager = $find("<%=rd_manager1.ClientID%>");
                    if (document.getElementById("ContentPlaceHolder1_hf_type_id").value != "") {
                        var url = "../Asset/UpdateTypeNames.aspx?type_id=" + s;
                    }
                    else {

                        var url = "../Asset/UpdateTypeNames.aspx?type_id=" + s2;
                    }
                    if (manager != null) {
                        var windows = manager.get_windows();
                        windows[0].setUrl(url);
                        windows[0].show();
                        //windows[0].set_modal(true);
                        windows[0]._width = "540px";
                        windows[0]._height = "200px";
                        windows[0]._title = "EcoDomus PM :Update Names"
                    }
                    return false;
                }


            }


            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }




            function divSelectedDomponentContent_onmouseover() {
                //refreshParent();
                //resize_Nice_Scroll();
                //refreshGrid();
            }

        </script>
    </telerik:RadCodeBlock>
  
    <telerik:RadFormDecorator ID="rdfTaskEquipment" Skin="Default" runat="server" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <table border="0" style="font-family: Arial, Helvetica, sans-serif; table-layout: fixed;
        border-bottom-style: none; border-bottom-width: 0px; width: 100%; overflow: hidden;">
        <tr>
            <td style="height: 25px; padding-bottom: 0px; padding-left: 02px; width: 100%;">
                <telerik:RadContextMenu ID="rad_panel_disp_column" runat="server" Skin="Default"
                    EnableRoundedCorners="true" EnableShadows="false" EnableTheming="true" EnableImagePreloading="true"
                    EnableImageSprites="true">
                    <Items>
                        <telerik:RadMenuItem Text="<%$Resources:Resource,Designer%>" />
                        <telerik:RadMenuItem Text="<%$Resources:Resource,Contractor%>" />
                        <telerik:RadMenuItem Text="MasterFormat" />
                        <telerik:RadMenuItem Text="UniFormat" />
                    </Items>
                </telerik:RadContextMenu>
                <telerik:RadContextMenu ID="rad_panel_disp_column_unassign" runat="server" Skin="Default"
                    EnableRoundedCorners="true" EnableShadows="false" EnableTheming="true" EnableImagePreloading="true"
                    EnableImageSprites="true">
                    <Items>
                        <telerik:RadMenuItem Text="<%$Resources:Resource,Designer%>" />
                        <telerik:RadMenuItem Text="<%$Resources:Resource,Contractor%>" />
                        <telerik:RadMenuItem Text="OmniClass" />
                        <telerik:RadMenuItem Text="MasterFormat" />
                        <telerik:RadMenuItem Text="UniFormat" />
                    </Items>
                </telerik:RadContextMenu>
                <%--<asp:Button ID="btn_display_column" runat="server" Text="Display Columns" OnClientClick="showMenu_type(event)" Width="5%" />
            &nbsp;&nbsp;--%>
                            <asp:Button ID="bn_add_type" runat="server" Font-Names="Arial" Text=" <%$Resources:Resource,Add_Type%>"
                    Width="100px" OnClick="btn_add_type_click" />
                
                <asp:Button ID="btn_display_column" Font-Names="Arial" runat="server" Text=" <%$Resources:Resource,Display_Columns%>"
                    Width="110px" OnClientClick="javascript:return disp();" />
                                    <asp:Button ID="btn_update_names" Font-Names="Arial" runat="server" Text="<%$Resources:Resource,Update_Names%>"
                    OnClientClick="javascript:return openUpdateNamesPopuo();" Width="100px" />
                
                <asp:Button ID="btn_edit_masterformat_uniformat" Font-Names="Arial" runat="server"
                    Text="<%$Resources:Resource,Edit_Classification%>" Width="120px" OnClientClick="javascript:return GetSelectedType();" />
                <asp:Button ID="btn_designer_contractor" Font-Names="Arial" runat="server" Text=" <%$Resources:Resource,Edit_Designer_Contractor%>"
                    OnClientClick="javascript:return GetSelectedTypeForDesignerContractorNew();"
                    Width="150px" />
                                    <asp:Button ID="btnAssignMajor" Font-Names="Arial" runat="server" Text="<%$Resources:Resource,Assign_As_Major%>"
                    Width="100px" OnClick="btnAssignMajor_Click" />
                
                <asp:Button ID="btn_assign" Font-Names="Arial" runat="server" Text="<%$Resources:Resource,Unassign%>"
                    Width="100px" OnClientClick="javascript:return disp_unassign();" /><%--OnClientClick-="javascript:return GetSelecteTypeForUnassign();"--%>
                <asp:Button ID="btndelete" runat="server" Font-Names="Arial" Text="<%$Resources:Resource,Delete%>"
                    Width="100px" CausesValidation="false" OnClientClick="javascript:return GetSelectedNames();" />

                <asp:Button ID="btnMerge" runat="server" Font-Names="Arial" Text="<%$Resources:Resource,Merge%>"
                    Width="100px" CausesValidation="false" OnClientClick="javascript:return CheckBeforeMerge();" OnClick="btnMerge_Click" />
            </td>
        </tr>
        <tr>
            <td style="display: none;">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="hf_type_id" runat="server" />
                        <asp:HiddenField ID="hfTypePMPageSize" runat="server" Value="" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td style="width: 100%;" class="centerAlign">
                <%--<asp:Panel ID="pnlTypePMid" runat="server" DefaultButton="btnSearch">--%>
                <div class="rpbItemHeader">
                    <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                        <tr>
                            <td align="left" class="entityImage" style="width: 30%;">
                                <asp:Label runat="server" Text="<%$Resources:Resource,Types%>" ID="lbl_grid_head" CssClass="gridHeadText"
                                    Width="200px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                    
                            </td>
                            <td>
                                <asp:Label ID="lblfacility" runat="server" Text="<%$Resources:Resource,Facility%>"
                                    CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10"></asp:Label>
                                    <asp:Label runat="server" Text=":" ID="Label1" CssClass="gridHeadText"
                                     ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                <telerik:RadComboBox Width="170px" ID="cmbfacility" Filter="Contains" runat="server"
                                    ViewStateMode="Enabled" OnItemDataBound="cmbfacility_ItemDataBound" AllowCustomText="True" 
                                    onkeypress="return tabOnly(event)" onmousewheel="return false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CheckBox1"  runat="server" Text='<%# Eval("name") %>' />
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </td>
                            <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;">
                                <div id="div_search" style="width: 200px; background-color: white;">
                                    <table>
                                        <tr>
                                            <td>
                                                <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                    Height="100%" EmptyMessage="<%$Resources:Resource,Search%>" BorderColor="White" ID="txt_search" Width="180px">
                                                </telerik:RadTextBox>
                                            </td>
                                            <td>
                                                <asp:ImageButton ClientIDMode="Static" ID="btnSearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                    OnClick="btn_search_click" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                            <td align="right" style="padding: 4px 4px 0 0;">
                                <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divSelectedDomponentContent" style="height: 100%;" class="divProperties RightMenu_1_Content">
                    <telerik:RadGrid ID="rgtype" runat="server" AllowCustomPaging="true" BorderWidth="1px"
                        AllowSorting="true" AutoGenerateColumns="False" PageSize="15" OnPageSizeChanged="rgtype_PageSizeChanged"
                        PagerStyle-Wrap="false" OnSortCommand="rgtype_SortCommand" PagerStyle-AlwaysVisible="true"
                        Skin="Default" OnItemDataBound="rgtype_OnItemDataBound" AllowMultiRowSelection="true"
                        OnPageIndexChanged="rgtype_PageIndexChanged" OnItemCommand="rgtype_ItemCommand"
                        ItemStyle-Wrap="false" OnItemEvent="rgtype_OnItemEvent" OnItemCreated="rgtype_OnItemCreated">
                        <PagerStyle HorizontalAlign="Right" Mode="NextPrevAndNumeric" />
                        <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                            <Selecting AllowRowSelect="true" />
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                            <ClientEvents OnGridCreated="GridCreated" />
                            <Resizing AllowColumnResize="True" ClipCellContentOnResize="True" EnableRealTimeResize="True" ResizeGridOnColumnResize="False" />
                            <ClientMessages ColumnResizeTooltipFormatString="" />
                        </ClientSettings>
                        <MasterTableView Name="tblvRgTypegridMasterTable" DataKeyNames="pk_type_id,name"
                            ClientDataKeyNames="pk_type_id,name" AllowPaging="true" TableLayout="Fixed">
                            <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10" Wrap="False" />
                            <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" CssClass="header-cell" />
                            <FooterStyle Height="25px" Font-Names="Arial" />
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_type_id" UniqueName="pk_type_id" Visible="false">
                                    <ItemStyle CssClass="column" />
                                    <HeaderStyle />
                                </telerik:GridBoundColumn>
                                <telerik:GridClientSelectColumn Resizable="False">
                                    <ItemStyle Width="28px" Wrap="false" HorizontalAlign="Center" />
                                    <HeaderStyle Width="28px" Wrap="false" HorizontalAlign="Center" CssClass="first-column" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridButtonColumn DataTextField="name" HeaderText="<%$Resources:Resource,Type_Name%>"
                                    UniqueName="name" ButtonType="LinkButton" ItemStyle-Font-Underline="true" CommandName="Edit"
                                    SortExpression="name">
                                    <ItemStyle CssClass="column" Wrap="false" /> <%--Width="7%"--%> 
                                    <HeaderStyle Wrap="false" /> <%--Width="7%"--%>
                                </telerik:GridButtonColumn>
                                <telerik:GridBoundColumn DataField="omniclass" HeaderText="<%$Resources:Resource,OmniClass%>"
                                    UniqueName="omniclass" SortExpression="omniclass" DataFormatString="<nobr>{0}</nobr>">
                                    <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" /> <%--Width="10%"--%>
                                    <%--HorizontalAlign="Left"--%>
                                    <HeaderStyle HorizontalAlign="Left" Wrap="false" /> <%--Width="10%"--%>
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="ismajor" UniqueName="TemplateColumn1" HeaderText="<%$Resources:Resource,Major%>"
                                    SortExpression="ismajor">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkMajor" runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle Width="60px" HorizontalAlign="Center" />
                                    <HeaderStyle Width="60px" Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Master_format" UniqueName="Master_format" HeaderText="MasterFormat"
                                    Visible="true" DataFormatString="<nobr>{0}</nobr>">
                                    <ItemStyle CssClass="column" Wrap="false" /> <%--Width="7%"--%>
                                    <HeaderStyle Wrap="false" /> <%--Width="7%"--%>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="uniformat" UniqueName="uniformat" HeaderText="UniFormat"
                                    Visible="true" DataFormatString="<nobr>{0}</nobr>">
                                    <ItemStyle CssClass="column" Wrap="false" /> <%--Width="5%"--%>
                                    <HeaderStyle Wrap="false" /> <%--Width="5%"--%>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Designer" UniqueName="Designer" HeaderText="<%$Resources:Resource,Designer%>"
                                    Visible="true" DataFormatString="<nobr>{0}</nobr>">
                                    <ItemStyle CssClass="column" Wrap="false" /> <%--Width="3%"--%> 
                                    <HeaderStyle Wrap="false" /> <%--Width="3%"--%>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="contractor" UniqueName="contractor" HeaderText="<%$Resources:Resource,Contractor%>"
                                    Visible="true" DataFormatString="<nobr>{0}</nobr>">
                                    <ItemStyle CssClass="column" Wrap="false" /> <%--Width="3%"--%>
                                    <HeaderStyle Wrap="false" /> <%--Width="3%"--%>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Component_Count" UniqueName="Component_Count"
                                    HeaderText="<%$Resources:Resource,Number_of_Components%>" Visible="true">
                                    <ItemStyle CssClass="column" Wrap="false" /> <%--Width="3%"--%>
                                    <HeaderStyle Wrap="false" /> <%--Width="3%"--%>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="uniclass" HeaderText="<%$Resources:Resource,UniClass%>"
                                    UniqueName="uniclass" SortExpression="omniclass" DataFormatString="<nobr>{0}</nobr>">
                                    <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" /> <%--Width="5%"--%>
                                    <%--HorizontalAlign="Left"--%>
                                    <HeaderStyle HorizontalAlign="Left" Wrap="false" /> <%--Width="5%"--%>
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
                <%-- </asp:Panel>--%>
            </td>
        </tr>
    </table>
    <telerik:RadNotification ID="rd_display_window" runat="server" Width="220" KeepOnMouseOver="true"
        Position="TopCenter" AutoCloseDelay="500000" EnableRoundedCorners="true" EnableShadow="true"
        OffsetX="-300" OffsetY="75" LoadContentOn="PageLoad" Title="Display Columns"
        Skin="Default">
        <ContentTemplate>
            <asp:Panel ID="panel_bar" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_master" runat="server" Text="MasterFormat" AutoPostBack="true"
                                OnCheckedChanged="chk_master_click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_uniformat" runat="server" Text="UniFormat" AutoPostBack="true"
                                OnCheckedChanged="chk_uniformat_click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_omniclass" runat="server" Text="OmniClass" AutoPostBack="true"
                                OnCheckedChanged="chk_omniclass_click" Checked="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_designer" runat="server" Text="<%$Resources:Resource,Designer%>"
                                AutoPostBack="true" OnCheckedChanged="chk_designer_click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_contractor" runat="server" Text="<%$Resources:Resource,Contractor%>"
                                AutoPostBack="true" OnCheckedChanged="chk_contractor_click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_uniclass" runat="server" Text="UniClass" AutoPostBack="true"
                                OnCheckedChanged="chk_uniclass_CheckedChanged" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </ContentTemplate>
    </telerik:RadNotification>
    <telerik:RadNotification ID="rd_unassign_window" runat="server" Width="220" KeepOnMouseOver="true"
        Position="TopCenter" AutoCloseDelay="500000" EnableRoundedCorners="true" EnableShadow="true"
        OffsetX="100" OffsetY="75" LoadContentOn="PageLoad" Title="Unassign MasterFormat/UniFormat/Designer"
        Skin="Default">
        <ContentTemplate>
            <asp:Panel ID="panel1" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_master_unassign" runat="server" Text="MasterFormat" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_uniformat_unassign" runat="server" Text="UniFormat" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_omniclass_unassign" runat="server" Text="OmniClass" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_designer_unassign" runat="server" Text="<%$Resources:Resource,Designer%>" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_contractor_unassign" runat="server" Text="<%$Resources:Resource,Contractor%>" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chk_uniclass_unassign" runat="server" Text="UniClass" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btn_unassign" runat="server" Text="Unassign" Width="8%" OnClick="btn_unassign_click"
                                OnClientClick="javascript:return chk_validate();" /><%--OnClientClick="javascript:return chk_validate();"--%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </ContentTemplate>
    </telerik:RadNotification>
    <div id="divbtn" style="display: none;">
    <asp:Button ID="btn_navigate" runat="server" OnClick="navigate" />
        <asp:Button ID="btn_refresh" runat="server" Style="display: none; overflow: hidden"
            BorderStyle="None" Skin="Default" OnClick="btn_refresh_Click" />
    </div>
    <telerik:RadWindowManager ID="rd_manager" runat="server" Skin="Default" ShowOnTopWhenMaximized="false"
        KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow ID="rd_window_masterformat" runat="server" Title="Assign OmniClass/MasterFormat/UniFormat"
                ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false" Width="700" Height="450"
                Top="10px" Left="45px" VisibleStatusbar="false" VisibleOnPageLoad="false" Skin="Default"
                Behaviors="Move,Resize,Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_manger_NewUI" runat="server" VisibleTitlebar="true"
        Title="Assign Classification" Behaviors="Close,Move" BorderWidth="0px" Skin="Simple"
        BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rd_window_master_Uniformat" runat="server" ReloadOnShow="false"
                Width="550" Height="530" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" EnableAjaxSkinRendering="false"
                EnableShadow="true" BackColor="Black" Modal="true" BorderWidth="2" Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_Designer_contractor" runat="server" VisibleTitlebar="true"
        Title="Assign Designer/Contractor" Behaviors="Close,Move" BorderWidth="0px" Skin="Simple"
        BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="RadWindow4" runat="server" ReloadOnShow="false" Width="530"
                Height="530" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" EnableAjaxSkinRendering="false"
                EnableShadow="true" BackColor="#EEEEEE" Modal="true" BorderWidth="0px" Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_manager1" runat="server" VisibleTitlebar="true"
        Title="Update Type Name" Behaviors="Close,Move" BorderWidth="0px" Skin="Simple"
        BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="RadWindow3" runat="server" ReloadOnShow="false" AutoSize="false"
                Width="400px" Height="130px" VisibleStatusbar="false" VisibleOnPageLoad="false"
                BorderWidth="0px" EnableShadow="true" BackColor="#EEEEEE">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindow1" runat="server" Animation="None" Behavior="Resize"
                ReloadOnShow="True" BorderStyle="Solid" Title="EcoDomus PM:Delete Type" VisibleStatusbar="false"
                Width="500" Height="135" Behaviors="Move,Resize,Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="RadWindowManager2" runat="server" Skin="Default">
        <Windows>
            <telerik:RadWindow ID="RadWindow2" runat="server" Animation="None" Behavior="Resize"
                ReloadOnShow="True" BorderStyle="Solid" Title="EcoDomus PM:Unassign" VisibleStatusbar="false"
                Width="400px" Height="400px" Behaviors="Move,Resize,Close">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:UpdatePanel ID="UpdatePanel2" Visible="false" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hfcount" runat="server" />
            <div style="display: none;">
                <%-- <asp:Button runat="server" ID="btnclick" Text="" BackColor="Transparent" OnClick="btnclick_Click" />--%>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <telerik:RadAjaxManagerProxy runat="server" ID="RadAjaxManagerProxyTypePM">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chk_uniclass_CheckedChanged">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chk_uniclass">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chk_master">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chk_omniclass">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chk_uniformat">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgtype">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chk_designer">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chk_contractor">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_refresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnCustomPageSize">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnCustomPageSize" LoadingPanelID="rad_load_panel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="rad_load_panel" Skin="Default" Height="75px" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
