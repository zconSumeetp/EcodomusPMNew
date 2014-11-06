<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ModelViewerV1.aspx.cs" Inherits="App_Settings_ModelViewerV1" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .rpbItemHeader
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray1.png');
            padding: 4px;
            font-family: Arial;
        }
        
        .gridHeaderGray
        {
            background-color: #bdbdbd;
            text-align: center;
            font-family: Arial;
            font-weight: bold;
            font-size: 11px;
        }
        
        .gridHeaderGray a
        {
            text-decoration: none;
            color: Black;
        }
        
        .lnkReport
        {
            color: Black;
        }
        
        .gridItemGray
        {
            background-color: #d9d9d9;
        }
        
        .tdGrayHeaderReport
        {
            background-color: #bdbdbd;
            text-align: center;
            font-family: Arial;
            font-weight: bold;
            font-size: 14px;
            border-bottom: 1px solid Black;
            border-right: 1px solid Black;
        }
        
        .GridMainGray table th, .GridMainGray table td
        {
            border-right: solid 1px black;
        }
        
        .GridViewPointCompItem td, .GridViewPointCompAlt td, .GridViewPointCompHead
        {
            border-bottom: 1px solid;
            empty-cells:show;
            text-align: left;
            font-family: Arial;
            font-size: 12px;
            height: 25px;
            
        }
        
                
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        
        .gridPropertiesAlternateItem
        {
            background-color: #f5f5f5;
            height: 25px;
        }
        
        .gridPropertiesItem
        {
            background-color: White;
            height: 25px;
            
        }
        
        .NavigationTools
        {
            width: 200px;
            background-color: Red;
            position: absolute;
            top: 10%;
            z-index: 99999;
        }
        
       
        /*  .RadPanelGray .rpRootGroup
        {
            border: none !important;
        }*/
    </style>
   

</head>
<body style="padding: 0; margin: 0;" onload="body_load();">
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" 
        DecoratedControls="RadioButtons, Buttons, Textbox" />
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <telerik:RadCodeBlock ID="radcodeblock3" runat="server">
        <script language="javascript" type="text/javascript">

            function openEnergyModelingAAS(attribute_name, attribute_id, table_name, attribute_value, UOM_id, PK_element_Numeric_ID) {
                manager = $find("<%=rd_manager.ClientID%>");
                //alert(manager);
                var url = "../Settings/FacilityTypesV1.aspx?element_numeric_id=" + document.getElementById("PK_element_Numeric_ID").value + "&file_id=" + document.getElementById("hf_file_id").value + "&facility_id=" + document.getElementById("hdnfacilityid").value + "" + "&attribute_name=" + attribute_name + "" + "&attribute_id=" + attribute_id + "" + "&table_name=" + table_name + "" + "&attribute_value=" + attribute_value + "";
                
                if (manager != null) {
                    var windows = manager.get_windows();
                    if (window[0] != null) {
                        windows[0].setUrl(url);
                        windows[0].show();
                        windows[0].set_modal(false);
                    }
                }
                return false;
            }

           
            function body_load() {
              
                var screenhtg = parseInt(window.screen.height * 0.60);
                document.getElementById("divComponentContent").style.height = screenhtg * 0.42;
                document.getElementById("divTypeContent").style.height = screenhtg * 0.42;
                document.getElementById("divdocumentContent").style.height = screenhtg * 0.28;

                document.getElementById("trbody").style.height = window.screen.height * 0.73;
                document.getElementById("divViewpointsContent").style.height = screenhtg * 0.35;
                document.getElementById("divSystemContent").style.height = screenhtg * 0.35;
                document.getElementById("divSystemComponentsContent").style.height = screenhtg * 0.32;
                document.getElementById("divRoomDataSheetContent").style.height = screenhtg * 0.35;
                document.getElementById("divImpactContent").style.height = screenhtg * 0.32;

                document.getElementById("divReportContent").style.height = window.screen.height * 0.23;
                $(".divScroll").niceScroll({ touchbehavior: false, cursorcolor: "#969696", cursoropacitymax: 0.8, cursorborder: "none", cursorwidth: 10, background: "#cccccc",horizrailenabled:true });
                $("#divSelectedDomponentContent").show();
                $("#divViewpointsContent").show();
                $("#divComponentContent").show();
            }
            function resize_Nice_Scroll() {
              
                $(".divScroll").getNiceScroll().resize();
            
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
        <script language="javascript" type="text/javascript">
            function rd_document_onClientCommand(sender, args) {
                if (args.get_commandName() == "Edit") {
                    var itemIndex = args.get_commandArgument();
                    var document_id = sender.get_masterTableView().get_dataItems()[itemIndex].getDataKeyValue("document_id");
                    var entity_name = sender.get_masterTableView().get_dataItems()[itemIndex].getDataKeyValue("entity_name");
                    load_popup(document_id, null, entity_name);
                    args.set_cancel(true);
                }
            }

            function load_popup(pk_document_id, entity_id, entity_name) {

                if (document.getElementById("hf_component_id").value != "" && (document.getElementById("hf_category").value != "Floors" || document.getElementById("hf_category").value == "Generic Models"))//category is not floor for asset
                {
                    document.getElementById("hf_entity").value = "Asset";

                    var url = "../Locations/AddDocument.aspx?fk_row_id=" + document.getElementById("hf_component_id").value + "&Document_Id=" + pk_document_id + "&Flag=Model" + "&Item_type=Asset" + "&entity_name=" + entity_name + "&entity_id=" + entity_id;
                    window.open(url, '', 'width=700px,height=400px');
                }
                else if (document.getElementById("hf_component_id").value != "" && (document.getElementById("hf_category").value == "Floors" || document.getElementById("hf_category").value == "Generic Models"))//category is floor for space
                {
                    document.getElementById("hf_entity").value = "Space";
                    var url = "../Locations/AddDocument.aspx?fk_row_id=" + document.getElementById("hf_component_id").value + "&Document_Id=" + pk_document_id + "&Flag=Model" + "&Item_type=Space";
                    window.open(url, '', 'width=700px,height=400px');
                }

                else//I am not responsible other than floor
                {
                    alert("Please Select the Asset");
                }
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadCodeBlock ID="rcViewpoints" runat="server">
        <script language="javascript" type="text/javascript">

            function showMenus(e) {
                var contextMenu = $find("<%= rcm_entity.ClientID %>");
                $telerik.cancelRawEvent(e);
                if ((!e.relatedTarget) || (!$telerik.isDescendantOrSelf(contextMenu.get_element(), e.relatedTarget))) {
                    contextMenu.show(e);

                }
            }
            function ClientNodeClicked(sender, eventArgs) {
                var node = eventArgs.get_node();
                findall(node.get_text());
            }

           

            function findall(view_point) {
                var view;
                var selected_node;
                selected_view_pt = view_point;
                for (var i = 1; i <= document.NWControl01.State.SavedViews().count; i++) {
                    var view = document.NWControl01.State.SavedViews(i);
                    myrecurse(view, selected_view_pt);
                }
            }

            function select_point() {
                if (document.NWControl01.state.CurrentView.ViewPoint.Paradigm == 6) {
                    if ((document.NWControl01.SelectionBehaviour != 2)) {
                        document.NWControl01.SelectionBehaviour = 2;
                        alert("Please Reselect Component");
                        return false;
                    }
                    var oPath;
                    var m_state;
                    var Gutcolls;
                    var attribute;
                    var node1;
                    m_state = document.NWControl01.State;
                    var xyz;
                    try {
                        if (document.NWControl01.State.CurrentSelection.Paths().Count != 0) {
                            oPath = document.NWControl01.State.CurrentSelection.Paths(1);

                            xyz = m_state.GetGUIPropertyNode(oPath, false);
                            Gutcolls = xyz.GUIAttributes();

                            var Elementnumericid = document.getElementById("PK_element_Numeric_ID").value;

                            get_element(Gutcolls);


                            if (Elementnumericid == "") {

                                // alert("Component doesn't have id, so unable to show properties.");
                                return false;
                            }
                            else {

                                if (Elementnumericid != document.getElementById("PK_element_Numeric_ID").value && document.getElementById("hf_category").value != "Floors" && document.getElementById("hdngroupselctionflag").value == "True") {//&& document.getElementById("hf_category").value != "Generic Models"
                                    RestfulResource(document.getElementById("hf_RestServiceUrl").value, document.getElementById("hf_category").value, document.getElementById("PK_element_Numeric_ID").value);

                                }
                                else {
                                    document.getElementById("hdn_asset_id").value = "";
                                    document.getElementById("btn_properties").click();
                                }
                            }


                            return true;
                        }
                        else {

                            return true;
                        }

                    }

                    catch (err) {
                        var error = err.description
                        if (error == "<<NavisWorks Error - Invalid index>>") {


                        }
                        else {
                            alert(err.description);
                        }
                    }
                }

                else {
                }
            }

            function myrecurse(view, selected_view_pt) {
                var cmd;
                var oOption;
                var eCmd_Play;


                switch (view.Objectname) {

                    case "nwOpView":

                        if (selected_view_pt == view.name) {

                            document.NWControl01.State.ApplyView(view);
                        }

                        break;

                    case "nwOpFolderView":
                        var folder;
                        folder = view;
                        var childview;

                        for (var i = 1; i <= folder.SavedViews().count; i++) {

                            childview = folder.SavedViews(i);
                            myrecurse(childview, selected_view_pt);

                        }
                        break;
                }
            }

            function jump_on_system_components(ElementNumericids) {
                debugger;
                if (ElementNumericids != "") {
                    var SplitResult = ElementNumericids.split(",");
                    var state = document.NWControl01.State;
                    state.CurrentSelection.SelectAll()
                    state.OverrideTransparency(state.CurrentSelection, 0.8599)

                    for (i = 0; i < SplitResult.length - 1; i++) {


                        var find = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFind"));
                        var findspec = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFindSpec"));
                        var findcon = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFindCondition"));
                        //findcon.SetPropertyNames("LcOaNat64AttributeValue");
                        if (document.getElementById("hdnrevitautocad").value == "LcOpDwgEntityAttrib") {
                            findcon.SetPropertyNames("LcOaNat64AttributeValue");
                            findcon.SetAttributeNames("LcOpDwgEntityAttrib");
                        }
                        else if (document.getElementById("hdnrevitautocad").value == "LcOaPropOverrideCat") {
                            findcon.SetPropertyNames("Id");
                            findcon.SetAttributeNames("LcOaPropOverrideCat");
                        }
                        else {
                            findcon.SetPropertyNames("LcOaNat64AttributeValue");
                            findcon.SetAttributeNames("LcRevitId");
                        }

                        findcon.Condition = state.GetEnum("eFind_EQUAL");
                        findcon.value = SplitResult[i];
                        findspec.Selection.SelectAll();
                        findspec.Conditions().add(findcon);
                        find.FindSpec = findspec;
                        var sel = find.FindAll();

                        if (sel.IsAnyContained(sel) == false && document.getElementById("hdnrevitautocad").value == "") {
                            findcon.SetPropertyNames("LcOaNat64AttributeValue");
                            findcon.SetAttributeNames("LcOpDwgEntityAttrib");


                            //if (sel.IsAnyContained(sel) == false) {
                            //    document.getElementById("hdnrevitautocad").value = "LcOaPropOverrideCat"
                            //   findcon.SetPropertyNames("Id");
                            //    findcon.SetAttributeNames("LcOaPropOverrideCat");

                            // }
                            // else {
                            document.getElementById("hdnrevitautocad").value = "LcOpDwgEntityAttrib"

                            //}

                            find.FindSpec = findspec;
                            var sel = find.FindAll();
                        }
                        state.CurrentSelection.UniteSelection(sel);
                        if (i == 0)
                            state.CurrentSelection = sel;

                        state.ZoomInCurViewOnCurSel();
                        state.OverrideTransparency(state.CurrentSelection, 0)

                    }
                }
            }

            function Bind_asset() {
               
                document.getElementById("btn_properties").click();

            }

            function open_type_popup(attribute_name, attribute_id, table_name, attribute_value, UOM_id, PK_element_Numeric_ID) {
                var r = confirm("Please select type for component.")
                if (r == true) {
                    var left = (window.screen.width / 2) - (700 / 2);
                    var top = (window.screen.height / 2) - (700 / 2);
                    var url = "../Settings/FacilityTypes.aspx?element_numeric_id=" + document.getElementById("PK_element_Numeric_ID").value + "&file_id=" + document.getElementById("hf_file_id").value + "&facility_id=" + document.getElementById("hdnfacilityid").value + "" + "&attribute_name=" + attribute_name + "" + "&attribute_id=" + attribute_id + "" + "&table_name=" + table_name + "" + "&attribute_value=" + attribute_value + "";
                    window.open(url, '', 'width=700px,height=550px,scrollbars=yes,Resizable=yes,top=' + top + ', left=' + left);


                }
                else
                    refresh_asset_grid();
        }


            function refresh_asset_grid() {
               
                document.getElementById("btn_refresh_asset").click();
            }

            function jump_system_compns_from_proprtydock(systemid) {
                document.getElementById("hdnsystemid").value = systemid;
               // document.getElementById("btn_system_assets").click();


            }

            function jump_on_comp_by_assetId(assetId) {
                document.getElementById("hf_category").value = "Asset";
                document.getElementById("hdn_asset_id").value = assetId;
                document.getElementById("hf_entity").value = "Asset";
                document.getElementById("btn_properties").click();
            }


            function selectAssetAttributeTab() {
                //alert("selectAssetAttributeTab");
            }

            function jump_on_comp(id) {
                
                document.getElementById("hdn_asset_id").value = "";
                var state = document.NWControl01.State;
                state.CurrentSelection.SelectAll()
                state.OverrideTransparency(state.CurrentSelection, 0.8599)
                var find = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFind"));
                var findspec = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFindSpec"));
                var findcon = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFindCondition"));

                if (document.getElementById("hdnrevitautocad").value == "LcOpDwgEntityAttrib") {

                    findcon.SetPropertyNames("LcOaNat64AttributeValue");
                    findcon.SetAttributeNames("LcOpDwgEntityAttrib");

                }
                else if (document.getElementById("hdnrevitautocad").value == "LcOaPropOverrideCat") {
                    findcon.SetPropertyNames("Id");
                    findcon.SetAttributeNames("LcOaPropOverrideCat");

                }
                else {
                    findcon.SetPropertyNames("LcOaNat64AttributeValue");
                    findcon.SetAttributeNames("LcRevitId");

                }

                findcon.Condition = state.GetEnum("eFind_EQUAL");
                findcon.value = id;
                findspec.Selection.SelectAll();
                findspec.Conditions().add(findcon);
                find.FindSpec = findspec;
                var sel = find.FindAll();

                if (sel.IsAnyContained(sel) == false && document.getElementById("hdnrevitautocad").value == "") {
                    findcon.SetPropertyNames("LcOaNat64AttributeValue");
                    findcon.SetAttributeNames("LcOpDwgEntityAttrib");
                    find.FindSpec = findspec;
                    var sel = find.FindAll();
                    if (sel.IsAnyContained(sel) == false) {
                        document.getElementById("hdnrevitautocad").value = "LcOaPropOverrideCat"
                        findcon.SetPropertyNames("Id");
                        findcon.SetAttributeNames("LcOaPropOverrideCat");

                    }
                    else {
                        document.getElementById("hdnrevitautocad").value = "LcOpDwgEntityAttrib"

                    }

                    find.FindSpec = findspec;
                    var sel = find.FindAll();
                }

                //alert(document.getElementById("hdnrevitautocad").value);
                //alert(sel.IsAnyContained(sel));
                state.CurrentSelection = sel;
                state.ZoomInCurViewOnCurSel();
                state.OverrideTransparency(state.CurrentSelection, 0)
                document.getElementById("PK_element_Numeric_ID").value = id;


                var oPath;
                var xyz;
                var Gutcolls;
                var m_state;

                m_state = document.NWControl01.State;

                if (document.NWControl01.State.CurrentSelection.Paths().count > 0) {
                    oPath = document.NWControl01.State.CurrentSelection.Paths(1);
                    xyz = m_state.GetGUIPropertyNode(oPath, false);
                    Gutcolls = xyz.GUIAttributes();


                    get_element(Gutcolls);

                    document.getElementById("hf_entity").value = "Asset";
                    document.getElementById("btn_properties").click();
                }

            }


            function jump_on_space_comp(id, pk_location_id) {

                var state = document.NWControl01.State;
                state.CurrentSelection.SelectAll()
                state.OverrideTransparency(state.CurrentSelection, 0.8599)
                var find = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFind"));
                var findspec = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFindSpec"));
                var findcon = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFindCondition"));
                //findcon.SetPropertyNames("LcOaNat64AttributeValue");
                if (document.getElementById("hdnrevitautocad").value == "LcOpDwgEntityAttrib") {
                    findcon.SetPropertyNames("LcOaNat64AttributeValue");
                    findcon.SetAttributeNames("LcOpDwgEntityAttrib");
                }
                else if (document.getElementById("hdnrevitautocad").value == "LcOaPropOverrideCat") {
                    findcon.SetPropertyNames("Id");
                    findcon.SetAttributeNames("LcOaPropOverrideCat");
                }
                else {
                    findcon.SetPropertyNames("LcOaNat64AttributeValue");
                    findcon.SetAttributeNames("LcRevitId");
                }
                findcon.Condition = state.GetEnum("eFind_EQUAL");
                findcon.value = id;
                findspec.Selection.SelectAll();
                findspec.Conditions().add(findcon);
                find.FindSpec = findspec;
                var sel = find.FindAll();

                if (sel.IsAnyContained(sel) == false && document.getElementById("hdnrevitautocad").value == "") {
                    findcon.SetPropertyNames("LcOaNat64AttributeValue");
                    findcon.SetAttributeNames("LcOpDwgEntityAttrib");


                    //if (sel.IsAnyContained(sel) == false) {
                    //    document.getElementById("hdnrevitautocad").value = "LcOaPropOverrideCat"
                    //    findcon.SetPropertyNames("Id");
                    //    findcon.SetAttributeNames("LcOaPropOverrideCat");

                    // }
                    // else {
                    document.getElementById("hdnrevitautocad").value = "LcOpDwgEntityAttrib"

                    // }

                    find.FindSpec = findspec;
                    var sel = find.FindAll();
                }

                state.CurrentSelection = sel;
                state.ZoomInCurViewOnCurSel();
                state.OverrideTransparency(state.CurrentSelection, 0)
                document.getElementById("PK_element_Numeric_ID").value = id;

                var oPath;
                var xyz;
                var Gutcolls;
                var m_state;

                m_state = document.NWControl01.State;

                if (document.NWControl01.State.CurrentSelection.Paths().count > 0) {
                    oPath = document.NWControl01.State.CurrentSelection.Paths(1);
                    xyz = m_state.GetGUIPropertyNode(oPath, false);
                    Gutcolls = xyz.GUIAttributes();


                    get_element(Gutcolls);
                    document.getElementById("hf_entity").value = "Space";


                    document.getElementById("hf_location_id").value = pk_location_id;
                    document.getElementById("btn_properties").click();
                }
               
            }
            function expand_room_data_sheet() {
                index = 7;
                var expandCount = 2;
                var expandedCount = 0;

                if (index != 0) {
                    expandedCount = 1;
                }

                if ($('.LeftMenu_0_Content').css("display") == "block") { // if viewPointsTab is expanded then only one another tab can be expanded
                    expandCount = 1;
                }
                $('.LeftMenu_' + index + '_Content').show();
                for (var i = 1; i <= 7; ++i) {
                    if (i != index) {

                        if ($('.LeftMenu_' + i + '_Content').css("display") == "block") {
                            if (expandedCount >= expandCount) {
                                var itemImg = document.getElementById("LeftMenu_" + i + "_img_expand_collapse");
                                itemImg.src = itemImg.src.replace("asset_carrot_up", "asset_carrot_down");
                                
                                $('.LeftMenu_' + i + '_Content').hide();
                            }
                            else {
                                expandedCount++;
                            }
                        }
                    }
                    else {
                        expandedCount++;
                    }
                }

                $(".divScroll").getNiceScroll().resize();
            }

        </script>
    </telerik:RadCodeBlock>
    <telerik:RadCodeBlock ID="radCodeExpandCollapse" runat="server">
        <script language="javascript" type="text/javascript">
            function closeReportWindow() {
                $("#trReport").hide();
                document.getElementById("NWControl01").style.height = "100%";
            }

            function showReportWindow() {
                $("#trReport").show();
                document.getElementById("NWControl01").style.height = "65%";
            }

            function LeftMenu_expand_collapse(index) {
                var img = document.getElementById("LeftMenu_" + index + "_img_expand_collapse");
                $('.LeftMenu_' + index + '_Content').toggle();

                if (img.src.indexOf("asset_carrot_up") != -1) {
                    img.src = img.src.replace("asset_carrot_up", "asset_carrot_down");
                }
                else {
                    img.src = img.src.replace("asset_carrot_down", "asset_carrot_up");

                    var expandCount = 2;
                    var expandedCount = 0;

                    if (index != 0) {
                        expandedCount = 1;
                    }

                    if ($('.LeftMenu_0_Content').css("display") == "block") { // if viewPointsTab is expanded then only one another tab can be expanded
                        expandCount = 1;
                    }

                    for (var i = 1; i <= 7; ++i) {
                        if (i != index) {

                            if ($('.LeftMenu_' + i + '_Content').css("display") == "block") {
                                if (expandedCount >= expandCount) {

                                    var itemImg = document.getElementById("LeftMenu_" + i + "_img_expand_collapse");
                                    itemImg.src = itemImg.src.replace("asset_carrot_up", "asset_carrot_down");
                                    $('.LeftMenu_' + i + '_Content').hide();
                                }
                                else {
                                    expandedCount++;
                                }
                            }
                        }
                        else {
                            expandedCount++;
                        }
                    }
                }
                $(".divScroll").getNiceScroll().resize();
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

            function ReportMenu_expand_collapse(index) {
                var img = document.getElementById("ReportMenu_" + index + "_img_expand_collapse");
                $('.ReportMenu_' + index + '_Content').toggle();
                if (img.src.indexOf("asset_carrot_up") != -1) {
                    img.src = img.src.replace("asset_carrot_up", "asset_carrot_down");
                    document.getElementById("NWControl01").style.height = "97%";
                }
                else {
                    img.src = img.src.replace("asset_carrot_down", "asset_carrot_up");
                    document.getElementById("NWControl01").style.height = "65%";
                }
                $(".divScroll").getNiceScroll().resize();
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadCodeBlock ID="rcode_selectTools" runat="server">
        <script language="javascript" type="text/javascript">
            function btnNav_Clicked(nmd_ndx) {
                document.NWControl01.ForceEvents = true;
                document.NWControl01.state.CurrentView.ViewPoint.Paradigm = nmd_ndx;
                switch (nmd_ndx) {
                    case 16:
                        ResetImages();
                        document.getElementById('Select').src = "../Images/Select_on.png";
                        break;
                    case 3:
                        ResetImages();
                        document.getElementById('WalkThrough').src = "../Images/WalkThrough_on.png";
                        break;
                    case 1:
                        ResetImages();
                        document.getElementById('LookAround').src = "../Images/LookAround_on.png";
                        break;
                    case 7:
                        ResetImages();
                        document.getElementById('Zoom').src = "../Images/Zoom_on.png";
                        break;
                    case 12:
                        ResetImages();
                        document.getElementById('ZoomBox').src = "../Images/ZoomBox_on.png";
                        break;
                    case 8:
                        ResetImages();
                        document.getElementById('Pan').src = "../Images/Pan_on.png";
                        break;
                    case 11:
                        ResetImages();
                        document.getElementById('Orbit').src = "../Images/Orbit_on.png";
                        break;
                    case 4:
                        ResetImages();
                        document.getElementById('Fly').src = "../Images/Fly_on.png";
                        break;
                    case 5:
                        ResetImages();
                        document.getElementById('TurnTable').src = "../Images/TurnTable_on.png";
                        break;
                }
            }

            function reset_transperency() {
                var state = document.NWControl01.State;
                state.CurrentSelection.SelectAll()
                state.OverrideTransparency(state.CurrentSelection, 0);
                state.CurrentSelection.SelectNone();
            }

            function ResetImages() {
                document.getElementById('Select').src = "../Images/Select_off.png";
                document.getElementById('WalkThrough').src = "../Images/WalkThrough_off.png";
                document.getElementById('LookAround').src = "../Images/LookAround_off.png";
                document.getElementById('Zoom').src = "../Images/Zoom_off.png";
                document.getElementById('ZoomBox').src = "../Images/ZoomBox_off.png";
                document.getElementById('Pan').src = "../Images/Pan_off.png";
                document.getElementById('Orbit').src = "../Images/Orbit_off.png";
                document.getElementById('Fly').src = "../Images/Fly_off.png";
                document.getElementById('TurnTable').src = "../Images/TurnTable_off.png";
            }

            function image_onmouseover(img_name) {
                var oldsrc = document.getElementById(img_name).src;
                if (oldsrc.indexOf(img_name + "_on.png") == -1) {
                    document.getElementById(img_name).src = "../Images/" + img_name + "_over.png";
                }
            }

            function image_onmouseout(img_name) {
                var oldsrc = document.getElementById(img_name).src;
                if (oldsrc.indexOf(img_name + "_on.png") == -1) {
                    document.getElementById(img_name).src = "../Images/" + img_name + "_off.png";
                }
            }


            function LinkData_onmouseover() {
                var oldsrc = document.getElementById('<%=btn_search.ClientID%>').src;
                if (oldsrc.indexOf('LinkData' + "_on.png") == -1) {
                    document.getElementById('<%=btn_search.ClientID%>').src = "../Images/LinkData_over.png";
                }
            }

            function LinkData_onmouseout() {
                var oldsrc = document.getElementById('<%=btn_search.ClientID%>').src;
                if (oldsrc.indexOf('LinkData_on.png') == -1) {
                    document.getElementById('<%=btn_search.ClientID%>').src = "../Images/LinkData_off.png";
                }
            }

            function GroupSelection_onmouseover() {
                var oldsrc = document.getElementById('<%=btn_groupSelection.ClientID%>').src;
                if (oldsrc.indexOf('GroupSelection_on.png') == -1) {
                    document.getElementById('<%=btn_groupSelection.ClientID%>').src = "../Images/GroupSelection_over.png";
                }
            }

            function GroupSelection_onmouseout() {
                var oldsrc = document.getElementById('<%=btn_groupSelection.ClientID%>').src;
                if (oldsrc.indexOf('GroupSelection_on.png') == -1) {
                    document.getElementById('<%=btn_groupSelection.ClientID%>').src = "../Images/GroupSelection_off.png";
                }
            }

            function rtv_System_click_OnClientNodeClicked(sender, e) {
                document.getElementById("hf_category").value = "System";
                document.getElementById("hf_system_id").value = e.get_node().get_value();
            }
        </script>
    </telerik:RadCodeBlock>
    <script type="text/javascript">

        function select_point() {

            if (document.NWControl01.state.CurrentView.ViewPoint.Paradigm == 6) {
                if ((document.NWControl01.SelectionBehaviour != 2)) {
                    document.NWControl01.SelectionBehaviour = 2;
                    alert("Please Reselect Component");
                    return false;
                }
                var oPath;
                var m_state;
                var Gutcolls;
                var attribute;
                var node1;
                m_state = document.NWControl01.State;
                var xyz;
                try {
                    if (document.NWControl01.State.CurrentSelection.Paths().Count != 0) {
                        oPath = document.NWControl01.State.CurrentSelection.Paths(1);

                        xyz = m_state.GetGUIPropertyNode(oPath, false);
                        Gutcolls = xyz.GUIAttributes();

                        var Elementnumericid = document.getElementById("PK_element_Numeric_ID").value;
                        get_element(Gutcolls);

                        if (Elementnumericid != document.getElementById("PK_element_Numeric_ID").value && document.getElementById("hf_category").value != "Floors" && document.getElementById("hdngroupselctionflag").value == "True") {
                            RestfulResource(document.getElementById("hf_RestServiceUrl").value, document.getElementById("hf_category").value, document.getElementById("PK_element_Numeric_ID").value);

                        }
                        else {
                            document.getElementById("btn_properties").click();
                        }


                        return true;
                    }
                    else {

                        return true;
                    }

                }

                catch (err) {
                    var error = err.description
                    if (error == "<<NavisWorks Error - Invalid index>>") {
                    }
                    else {
                        alert(err.description);
                    }
                }
            }

            else {

            }
        }
   
    </script>
    <script language="VBScript" type="text/vbscript">
Option Explicit
Dim counter
Dim apply
dim selected_view_pt 
 
public sub get_element(oGUIAttColl)
Dim oGUIAtt

Dim name
For Each oGUIAtt In oGUIAttColl
    
    name=UCase(oGUIAtt.ClassUserName)       
        
        'For Elemment
        If InStr(name,"ELEMENT") <> 0 then
            Dim oP
                For Each oP In oGUIAtt.Properties                          
                    If UCase(oP.UserName) = "ID" Then
                            document.getElementById("PK_element_Numeric_ID").value=oP.value
                    End If
                                
                    If UCase(oP.UserName) = "UNIQUEID" Then                          
                            document.getElementById("str_element_ID").value=oP.value
                    End If

                    If UCase(oP.UserName) = "CATEGORY" Then                                                           
                            document.getElementById("hf_category").value=oP.value 
                    End If
                                
                    If UCase(oP.UserName) = "NAME" Then
                        document.getElementById("hf_strElementName").value=oP.value
                    End If

                    If UCase(oP.UserName) = "UNIQUEGUID" Then                                        
                            document.getElementById("hf_guid").value=oP.value                                        
                    End If
                next
            End If

            'For ITEM
            If InStr(name,"ITEM") <> 0 then       
                For Each oP In oGUIAtt.Properties                  
                    If UCase(oP.UserName) = "LAYER" Then                              
                       ' alert(oP.value)  
                        document.getElementById("hf_layer").value=Replace(Replace(oP.value,"<",""),">","")
                        'alert(document.getElementById("hf_layer").value)                                      
                    End If
                 next
            End If  


            If InStr(name,"REVIT TYPE") <> 0 then
                For Each oP In oGUIAtt.Properties         
                    If UCase(oP.UserName) = "ID" Then                                        
                        document.getElementById("hf_TypeID").value=oP.value                                        
                    End If         
                next
            End If


            If InStr(name,"ENTITY HANDLE") <> 0 then
                For Each oP In oGUIAtt.Properties                  
                    If UCase(oP.UserName) = "VALUE" Then
                                document.getElementById("PK_element_Numeric_ID").value=oP.value
                                'document.getElementById("hdnrevitautocad").value="LcOaPropOverrideCat"
                                document.getElementById("hdnrevitautocad").value=""
                                          
                    End If
                next
            End If

Next
End Sub



 Public Sub NWControl01_OnFileOpen()

 
 
 Dim comp_id
  Dim location_id
  
  If document.getElementById("hdn_system_component").value = "Space" Then
    comp_id=document.getElementById("comp_element_id").value
    location_id=document.getElementById("pk_location_id").value
    document.getElementById("hf_location_id").value=location_id
    jump_on_space_comp comp_id,location_id
  End If
 
 If document.getElementById("hdn_system_component").value = "Component" Then
 
    comp_id=document.getElementById("comp_element_id").value
    jump_on_comp(comp_id)
  End If
  If document.getElementById("hdn_system_component").value = "System" Then
    comp_id=document.getElementById("comp_element_id").value
    jump_on_system_components(comp_id)
  End If
  
   btnNav_Clicked(16)

End Sub



    </script>
    <script type="text/vbscript">
        public sub NWControl01_OnLButtonUp(flags,x_coord,y_coord)
    
            select_point()
        end sub
    </script>

    <telerik:RadCodeBlock ID="RadCodeBlock2"  runat="server">
            <script type="text/javascript">
                function check_Numeric_Id() {
                  
                    var oPath;
                    var m_state;
                    var Gutcolls;
                    var attribute;
                    var node1;
                    m_state = document.NWControl01.State;
                    var xyz;
                    try {
                        if (document.NWControl01.State.CurrentSelection.Paths().Count != 0) {
                            oPath = document.NWControl01.State.CurrentSelection.Paths(1);
                            xyz = m_state.GetGUIPropertyNode(oPath, false);
                            Gutcolls = xyz.GUIAttributes();
                            get_element(Gutcolls);
                            var Elementnumericid = document.getElementById("PK_element_Numeric_ID").value;
                        }
                        if (Elementnumericid != "" && Elementnumericid != null) {
                            if (document.getElementById('hf_category').value == "Floors" || document.getElementById('hf_layer').value == "PLATFORM") {//|| document.getElementById('hf_category').value == "Generic Models"
                                openfacilityspacesLinktodata();
                            }
                            else {
                                openfacilityassets();
                            }
                        }
                        else {
                            alert("Please select Asset to link");
                            return false;
                        }
                    }
                    catch (err) {
                        var error = err.description
                        if (error == "<<NavisWorks Error - Invalid index>>") {
                        }
                        else {
                            alert(err.description);
                        }
                    }
                }

                function openfacilityspacesLinktodata() {

                    var left = (window.screen.width / 2) - (700 / 2);
                    var top = (window.screen.height / 2) - (700 / 2);
                    var url = "../Settings/LinkToSpace.aspx?element_numeric_id=" + document.getElementById("PK_element_Numeric_ID").value + "&file_id=" + document.getElementById("hf_file_id").value + "&facility_id=" + document.getElementById("hdnfacilityid").value + "" + "&properties=" + document.getElementById("hdnpropertystatus").value + "";
                    window.open(url, '', 'width=700px,height=550px,scrollbars=yes,Resizable=yes,top=' + top + ', left=' + left);

                }
                function openfacilityassets() {

                    var left = (window.screen.width / 2) - (700 / 2);
                    var top = (window.screen.height / 2) - (700 / 2);
                    var url = "../Settings/facilityassets.aspx?element_numeric_id=" + document.getElementById("PK_element_Numeric_ID").value + "&file_id=" + document.getElementById("hf_file_id").value + "&facility_id=" + document.getElementById("hdnfacilityid").value + "" + "&properties=" + document.getElementById("hdnpropertystatus").value + "";
                    window.open(url, '', 'width=980px,height=550px,scrollbars=yes,Resizable=yes,top=' + top + ', left=' + left);
                   
                }

            </script>
        </telerik:RadCodeBlock>
    <div>
        <div style="display: none;">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Button ID="btn_properties" runat="server" OnClick="btn_properties_click" />
                    <asp:Button ID="btn_refresh_asset" runat="server" OnClick="btn_refresh_asset_click" />
                     <asp:HiddenField ID="hf_component_id" runat="server" />
                    <asp:HiddenField ID="hf_layer" runat="server" />
                    <asp:HiddenField ID="hf_location_id" runat="server" />
                    <asp:HiddenField ID="PK_element_Numeric_ID" runat="server" />
                    <asp:HiddenField ID="hdnpropertystatus" runat="server" />
                    <asp:HiddenField ID="hdn_asset_id" runat="server" />
                    <asp:HiddenField ID="hdn_system_component" runat="server" />
                    <asp:HiddenField ID="hf_RestServiceUrl" runat="server" />
                    <asp:HiddenField ID="hdngroupselctionflag" runat="server" />
                    <asp:HiddenField ID="hf_assetTab" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <table style="width: 100%; margin: 0;" cellpadding="0" cellspacing="0">
            <tr id="trHead">
                <td style="width: 20%; padding: 0; border-bottom: 3px solid Black; background-color: Gray;
                    height: 40px;" valign="middle">
                    <table cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;">
                        <tr>
                            <td style="width: 85%;">
                                <asp:Image ImageUrl="~/App/Images/Icons/logo_final.png" runat="server" ID="imgLogo"
                                    Height="40px" />
                            </td>
                            <td style="padding-right: 8px; padding-left: 2px;">
                                <asp:LinkButton ID="lbtnVersion" Text="V1.5" runat="server" CssClass="VersionHead"
                                    OnClientClick="return ShowVersionInfo();"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td colspan="2" style="border-bottom: 3px solid Black; background-color: #F0F0EA;
                    padding-left: 8px;">
                   Model Viewer
                </td>
            </tr>
            <tr id="trbody">
                <td valign="top">
                    <table style="border-collapse: collapse;" cellpadding="0" cellspacing="0" width="100%">
                        <tr id="trSearch">
                            <td>
                                <table style="width: 100%; border-collapse: collapse; background-image: url('../Images/asset_zebra-bkgrd_gray3.png');
                                    font-family: Arial; font-size: 11px;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="padding: 2px 0 0 8px;">
                                            SEARCH
                                        </td>
                                        <td style="padding-top: 2px;" align="right">
                                        <asp:Label ID="lbl_entity" runat="server" Text="Asset" Font-Size="12px"></asp:Label>
                                        </td>
                                        <td>
                                        <asp:ImageButton ID="ibtn_entity" runat="server" ImageAlign="Top"
                                                            ImageUrl="~/App/Images/Icons/asset_arrow_lg.png" OnClientClick="showMenus(event)" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 2px 20px 4px 8px;" colspan="2">
                                        <asp:Panel ID="pnl_search" runat="server" DefaultButton="btnSearch">
                                            <table cellpadding="0px" cellspacing="0px" style="background-color: #fcfce1; width: 100%;">
                                                <tr>
                                                    <td align="left" width="90%" rowspan="0px" style="padding-bottom: 0px;">
                                                        <telerik:RadTextBox runat="server" BackColor="#fcfce1" BorderStyle="None" ID="txtSearch"
                                                            Width="100%">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td align="left" rowspan="0px" width="10%" style="height: 14px; padding-bottom: 0px;">
                                                        <asp:ImageButton ID="btnSearch" runat="server" 
                                                            ImageUrl="~/App/Images/Icons/icon_search_sm.png" onclick="btnSearch_Click" 
                                                            style="width: 13px" />
                                                    </td>
                                                </tr>
                                            </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table style="border-collapse: collapse;" cellpadding="0" cellspacing="0" width="100%">
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="trViewPoints">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_BIMview_sm.png" ID="Image11" />
                                            </td>
                                            <td align="left" class="entityImage">
                                                <asp:Label runat="server" Text="VIEWPOINTS" Font-Size="11px" ID="Label9"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 8px 0 0px; width: 20px;">
                                                <asp:ImageButton ID="btnAddViewpoint" runat="server" ImageUrl="~/App/Images/Icons/asset_add_sm.png"
                                                    AlternateText="Add Viewpoint" OnClick="btnAddViewpoint_OnClick" />
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0; width: 20px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up.png" ClientIDMode="Static"
                                                    ID="LeftMenu_0_img_expand_collapse" onclick="LeftMenu_expand_collapse(0)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divViewpointsContent" class="divScroll LeftMenu_0_Content">
                                    <div style="padding: 6px;">
                                        <telerik:RadTreeView Width="99%" Skin="Default" runat="server" ID="rtv_Viewpoints"
                                            AutoPostBack="false" OnClientNodeClicked="ClientNodeClicked" OnClientNodeExpanded="resize_Nice_Scroll">
                                        </telerik:RadTreeView>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <%--<tr id="trSelectedComponents">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)" style="padding-left: 4px;">
                                                <asp:Label runat="server" Text="SELECTED ITEMS" Font-Size="11px" ID="Label10"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up.png" ClientIDMode="Static"
                                                    ID="LeftMenu_1_img_expand_collapse" onclick="LeftMenu_expand_collapse(1)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divSelectedDomponentContent" class="divScroll LeftMenu_1_Content" style="display: none">
                                    <telerik:RadGrid ID="rd_selected_components" Skin="" runat="server" AutoGenerateColumns="False"
                                        AllowSorting="False" GridLines="None" Font-Names="Arial" Font-Size="9">
                                        <ClientSettings>
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                            <Selecting AllowRowSelect="true" />
                                        </ClientSettings>
                                        <ItemStyle CssClass="GridViewPointCompItem" />
                                        <AlternatingItemStyle CssClass="GridViewPointCompAlt" />
                                        <HeaderStyle CssClass="GridViewPointCompHead" />
                                        <MasterTableView Width="100%">
                                            <Columns>
                                                <telerik:GridTemplateColumn ItemStyle-Width="4%">
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="component_name" HeaderText="Component" UniqueName="component_name"
                                                    ItemStyle-Width="35%" HeaderStyle-Width="35%">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="component_type" HeaderText="<%$Resources:Resource, Type%>"
                                                    UniqueName="component_type">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn UniqueName="EditCommandColumn1">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>--%>
                        <tr id="trSystem">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_system_sm.png" ID="Image5" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="SYSTEM" Font-Size="11px" ID="Label5"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_down.png" ClientIDMode="Static"
                                                    ID="LeftMenu_2_img_expand_collapse" onclick="LeftMenu_expand_collapse(2)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divSystemContent" class="divScroll LeftMenu_2_Content" style="display: none;">
                                    <telerik:RadTreeView Skin="Default" OnNodeClick="rtv_System_click" ID="rtv_System"
                                        OnClientNodeClicked="rtv_System_click_OnClientNodeClicked" runat="server" OnClientNodeExpanded="resize_Nice_Scroll">
                                    </telerik:RadTreeView>
                                </div>
                            </td>
                        </tr>
                        <tr id="trSystemComponents">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_system_sm.png" ID="Image7" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="SYSTEM ASSET" Font-Size="11px" ID="Label6"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_down.png" ClientIDMode="Static"
                                                    ID="LeftMenu_3_img_expand_collapse" onclick="LeftMenu_expand_collapse(3)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divSystemComponentsContent" class="divScroll LeftMenu_3_Content" style="display: none;">
                                    <telerik:RadGrid  ID="rg_component" Skin="" runat="server" AutoGenerateColumns="False"
                                        AllowSorting="False" GridLines="None" Font-Names="Arial" Font-Size="9">
                                        <ClientSettings AllowDragToGroup="true">
                                            <Selecting AllowRowSelect="false" />
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                            <Resizing AllowColumnResize="true"></Resizing>
                                        </ClientSettings>
                                        <ItemStyle CssClass="GridViewPointCompItem" />
                                        <AlternatingItemStyle CssClass="GridViewPointCompAlt" />
                                        <HeaderStyle CssClass="GridViewPointCompHead" />
                                        <MasterTableView HeaderStyle-Height="0px" DataKeyNames="pk_asset_id" TableLayout="Fixed"
                                            GroupLoadMode="Client">
                                            <Columns>
                                                <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="system_component"  
                                                    Visible="true">
                                                    <HeaderStyle Height="0px" Wrap="false"/>
                                                    <ItemStyle Wrap="true"  ForeColor="Red" Font-Underline="false"/>
                                                </telerik:GridButtonColumn>
                                                
                                            </Columns>
                                        </MasterTableView></telerik:RadGrid>
                                </div>
                            </td>
                        </tr>

                      <%--  <tr id="trSearchAsset">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                 <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_system_components.png"
                                                    ID="Image1" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="SEARCH ASSET" Font-Size="11px" ID="Label1"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_down.png" ClientIDMode="Static"
                                                    ID="LeftMenu_4_img_expand_collapse" onclick="LeftMenu_expand_collapse(4)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divSearchAssetContent" class="divScroll LeftMenu_4_Content" style="display: none;">
                                    <table border="0" width="90%">
                                        <tr>
                                            <td>
                                                <telerik:RadComboBox ID="rdcmb_search_type" runat="server" Width="155px" AutoPostBack="true"
                                                    OnSelectedIndexChanged="rdcmb_search_type_selectedindexchanged">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:RadComboBox ID="rdcmb_search_by" runat="server" Width="155px">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Name" Value="Name" />
                                                        <telerik:RadComboBoxItem Text="Description" Value="Description" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txt_search" runat="server" Width="150px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btn_find_component" runat="server" Width="100" Text="<%$Resources:Resource, Find%>"
                                                    OnClick="btn_find_component_click" />
                                            </td>
                                        </tr>
                                        <tr>
                                        <td>
                                            <telerik:RadGrid ID="rg_search_data_new" OnPageIndexChanged="rg_search_data_new_OnPageIndexChanged"
                                                OnPageSizeChanged="rg_search_data_new_OnPageSizeChanged" Skin="" runat="server"
                                                AutoGenerateColumns="False" AllowSorting="False" GridLines="None" Font-Names="Arial"
                                                Font-Size="9">
                                                <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="true" />
                                                <ClientSettings AllowDragToGroup="true">
                                                    <Selecting AllowRowSelect="false" />
                                                    <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                    <Resizing AllowColumnResize="True"></Resizing>
                                                </ClientSettings>
                                                <ItemStyle CssClass="GridViewPointCompItem" />
                                                <AlternatingItemStyle CssClass="GridViewPointCompAlt" />
                                                <HeaderStyle CssClass="GridViewPointCompHead" />
                                                <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" ShowHeader="false">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblcertificates" Text='<%# Eval("AssetName")%>' runat="server"></asp:Label></ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblType" Text='<%# Eval("Asset_Name")%>' runat="server"></asp:Label></ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn DataField="view_name" UniqueName="view_name" Visible="false"
                                                            HeaderText="View Name">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="ExtIdentifier" Visible="false">
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
                                                </MasterTableView></telerik:RadGrid>
                                        </td>
                                            
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>--%>

                         <tr id="trImpact">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_Documents_sm.png" ID="Image2" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="IMPACT" Font-Size="11px" ID="Label2"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_down.png" ClientIDMode="Static"
                                                    ID="LeftMenu_5_img_expand_collapse" onclick="LeftMenu_expand_collapse(5)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divImpactContent" class="divScroll LeftMenu_5_Content" style="display: none;">
                                    <telerik:RadGrid ID="radgrdimpact" runat="server" OnPageIndexChanged="radgrdimpact_OnPageIndexChanged"
                                        OnPageSizeChanged="radgrdimpact_OnPageSizeChanged" Skin="" AutoGenerateColumns="False" 
                                        AllowSorting="False" GridLines="None" Font-Names="Arial" Font-Size="9" ShowHeader="false">
                                        <ClientSettings AllowDragToGroup="true">
                                            <Selecting AllowRowSelect="false" />
                                            <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                            <Resizing AllowColumnResize="True"></Resizing>
                                        </ClientSettings>
                                        <ItemStyle CssClass="GridViewPointCompItem" />
                                        <AlternatingItemStyle CssClass="GridViewPointCompAlt" />
                                        <HeaderStyle CssClass="GridViewPointCompHead" />
                                        <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" ShowHeader="true">
                                            <Columns>
                                                <telerik:GridTemplateColumn UniqueName="name" HeaderText="Name" Visible="true">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblcertificates" Text='<%# Eval("name")%>' runat="server"></asp:Label></ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn UniqueName="Description" HeaderText="Description" Visible="true">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbldescription" Text='<%# Eval("description")%>' runat="server"></asp:Label></ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn UniqueName="EntityName" HeaderText="Entity Name" Visible="true">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblentity" Text='<%# Eval("entity_name")%>' runat="server"></asp:Label></ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView></telerik:RadGrid>
                                </div>
                            </td>
                        </tr>


                         <%--<tr id="trSearchSpace">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_Documents_sm.png" ID="Image3" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="SEARCH SPACE" Font-Size="11px" ID="Label12"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_down.png" ClientIDMode="Static"
                                                    ID="LeftMenu_6_img_expand_collapse" onclick="LeftMenu_expand_collapse(6)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divSearchSpaceContent" class="divScroll LeftMenu_6_Content" style="display: none;">
                                    <table border="0" width="90%">
                                        <tr>
                                            <td>
                                                <telerik:RadComboBox ID="rdCmbSearchCriteria" runat="server" Width="155">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Name" Value="Name" />
                                                        <telerik:RadComboBoxItem Text="Description" Value="Description" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtSearchSpace" runat="server" Width="155px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnFindSpace" runat="server" Width="100px" Text="<%$Resources:Resource, Find%>"
                                                    OnClick="btnFindSpace_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:RadGrid ID="rgSearchSpace" runat="server" OnPageSizeChanged="rgSearchSpace_OnPageSizeChanged"
                                                    OnPageIndexChanged="rgSearchSpace_OnPageIndexChanged" Skin="" runat="server"
                                                    AutoGenerateColumns="False" AllowSorting="False" GridLines="None" Font-Names="Arial"
                                                    Font-Size="9">
                                                    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="true" />
                                                    <ClientSettings AllowDragToGroup="true">
                                                        <Selecting AllowRowSelect="false" />
                                                        <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                        <Resizing AllowColumnResize="True"></Resizing>
                                                    </ClientSettings>
                                                    <ItemStyle CssClass="GridViewPointCompItem" />
                                                    <AlternatingItemStyle CssClass="GridViewPointCompAlt" />
                                                    <HeaderStyle CssClass="GridViewPointCompHead" />
                                                    <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" ShowHeader="false" DataKeyNames="pk_location_id,fk_external_system_data_id"
                                                        ClientDataKeyNames="pk_location_id,fk_external_system_data_id">
                                                        <Columns>
                                                            <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnk_space" runat="server" Text='<%# Eval("Space_Name")%>'>
                                                                    </asp:LinkButton></ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblType" Text='<%# Eval("Description")%>' runat="server"></asp:Label></ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn Visible="false" UniqueName="profile" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSpaceId" Text='<%# Eval("pk_location_id")%>' runat="server"></asp:Label></ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn Visible="false" UniqueName="element_numeric_id" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblelementnumericId" Text='<%# Eval("fk_external_system_data_id")%>'
                                                                        runat="server"></asp:Label></ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                    </MasterTableView></telerik:RadGrid>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>--%>

                        <tr id="trRoomDataSheet">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_Documents_sm.png" ID="Image10" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="ROOM DATA SHEET" Font-Size="11px" ID="Label7"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 3px 0 0">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_down.png" ClientIDMode="Static"
                                                    ID="LeftMenu_7_img_expand_collapse" onclick="LeftMenu_expand_collapse(7)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divRoomDataSheetContent" class="divScroll LeftMenu_7_Content" style="display: none;">
                                    <telerik:RadGrid  ID="rg_room_data_sheet" BorderWidth="0px" MasterTableView-TableLayout="Fixed"
                                        ClientSettings-Scrolling-AllowScroll="true" Skin="" runat="server" AutoGenerateColumns="False"
                                        AllowSorting="False" GridLines="None" Font-Names="Arial" Font-Size="9">
                                        <ClientSettings AllowDragToGroup="true">
                                            <Selecting AllowRowSelect="false" />
                                            <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                            <Resizing AllowColumnResize="True"></Resizing>
                                        </ClientSettings>
                                        <ItemStyle CssClass="GridViewPointCompItem" />
                                        <AlternatingItemStyle CssClass="GridViewPointCompAlt" />
                                        <HeaderStyle CssClass="GridViewPointCompHead" />
                                        <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" ShowHeader="false">
                                            <Columns>
                                                <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblcertificates" Text='<%# Eval("AssetName")%>' runat="server"></asp:Label></ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView></telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                       
                    </table>
                </td>
               <td valign="top">
                <div style="background-color: Black; width: 100%;min-height:8%">
                        <table border="0" width="100%" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
                            <tr>
                                <td>
                                    <table border="0" style="border-collapse: collapse;" cellpadding="2" cellspacing="2">
                                        <tr>
                                        <td style="width:5px"></td>
                                            <td align="center" valign="bottom" style="margin-bottom: 0px; padding: 0px;">
                                                <a onclick="btnNav_Clicked(16)" onmouseover="image_onmouseover('Select')" onmouseout="image_onmouseout('Select')">
                                                    <img src="../Images/Select_off.png" alt="Select" id="Select" width="32" height="32" /></a>
                                            </td>
                                            <td align="center" valign="bottom" style="margin-bottom: 0px; padding: 0px;">
                                                <a onclick="btnNav_Clicked(3)" onmouseover="image_onmouseover('WalkThrough')" onmouseout="image_onmouseout('WalkThrough')">
                                                    <img src="../Images/WalkThrough_off.png" alt="Walk" id="WalkThrough" width="32" height="32" /></a>
                                            </td>
                                            <td valign="bottom" align="center" style="padding: 0px;">
                                                <a onclick="btnNav_Clicked(1)" onmouseover="image_onmouseover('LookAround')" onmouseout="image_onmouseout('LookAround')">
                                                    <img src="../Images/LookAround_off.png" alt="Look Around" id="LookAround" width="32"
                                                        height="32" /></a>
                                            </td>
                                            <td align="center" valign="bottom" style="padding: 0px;">
                                                <a onclick="btnNav_Clicked(7)" onmouseover="image_onmouseover('Zoom')" onmouseout="image_onmouseout('Zoom')">
                                                    <img src="../Images/Zoom_off.png" alt="Zoom" id="Zoom" width="32" height="32" /></a>
                                            </td>
                                            <td align="center" valign="bottom" style="padding: 0px;">
                                                <a onclick="btnNav_Clicked(12)" onmouseover="image_onmouseover('ZoomBox')" onmouseout="image_onmouseout('ZoomBox')">
                                                    <img src="../Images/ZoomBox_off.png" alt="Zoom Box" id="ZoomBox" width="32" height="32" /></a>
                                            </td>
                                            <td align="center" valign="bottom" style="padding: 0px;">
                                                <a onclick="btnNav_Clicked(8)" onmouseover="image_onmouseover('Pan')" onmouseout="image_onmouseout('Pan')">
                                                    <img src="../Images/Pan_off.png" alt="Pan" id="Pan" width="32" height="32" /></a>
                                            </td>
                                            <td align="center" valign="bottom" style="padding: 0px;">
                                                <a onclick="btnNav_Clicked(11)" onmouseover="image_onmouseover('Orbit')" onmouseout="image_onmouseout('Orbit')">
                                                    <img src="../Images/Orbit_off.png" alt="Orbit" id="Orbit" width="32" height="32" /></a>
                                            </td>
                                            <td align="center" valign="bottom" style="padding: 0px;">
                                                <a onclick="btnNav_Clicked(4)" onmouseover="image_onmouseover('Fly')" onmouseout="image_onmouseout('Fly')">
                                                    <img src="../Images/Fly_off.png" alt="Fly" id="Fly" width="32" height="32" /></a>
                                            </td>
                                            <td align="center" valign="bottom" style="padding: 0px;">
                                                <a onclick="btnNav_Clicked(5)" onmouseover="image_onmouseover('TurnTable')" onmouseout="image_onmouseout('TurnTable')">
                                                    <img src="../Images/TurnTable_off.png" alt="Turn Table" id="TurnTable" width="32"
                                                        height="32" /></a>
                                            </td>
                                            <td align="center" valign="bottom">
                                                <a onclick="reset_transperency()" onmouseover="image_onmouseover('ResetModel')" onmouseout="image_onmouseout('ResetModel')">
                                                    <img src="../Images/ResetModel_off.png" alt="Reset Model" id="ResetModel" width="32"
                                                        height="32" /></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <table border="0" style="border-collapse: collapse;" cellpadding="2" cellspacing="2"
                                        align="right">
                                        <tr>
                                            <td align="center" valign="bottom" style="padding: 0px;">
                                                <asp:ImageButton ID="btn_search" ToolTip="Link to data" Style="cursor: default;"
                                                    ImageUrl="~/App/Images/LinkData_off.png" onmouseover="LinkData_onmouseover()"
                                                    onmouseout="LinkData_onmouseout()" runat="server" OnClientClick="javascript:check_Numeric_Id()"
                                                    Width="32" Height="32" />
                                            </td>
                                            <td align="center" valign="bottom" style="padding: 0px;">
                                                <asp:ImageButton ID="btn_groupSelection" ToolTip="Group Selection" Style="cursor: default;"
                                                    ImageUrl="~/App/Images/GroupSelection_off.png" onmouseover="GroupSelection_onmouseover()"
                                                    Width="32" Height="32" onmouseout="GroupSelection_onmouseout()" runat="server"
                                                    OnClientClick="javascript:return enablemultipleselection();" />
                                            </td>
                                            <td align="center" valign="bottom" style="padding: 0px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/Report_Img.jpg" ToolTip="Show Report"
                                                    onclick="showReportWindow();" ClientIDMode="Static" ID="Image1" Width="32" Height="32" />
                                            </td>
                                              <td style="width:5px"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divModel" style="min-height: 65%;" runat="server">
                    </div>
                    <table style="border-collapse: collapse;" cellpadding="0" cellspacing="0" width="100%">
                        <tr id="trReport">
                            <td>
                                <div class="gridRadPnlHeader" style="border-bottom: 1px solid Orange;">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td style="width: 25px; padding-left: 4px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_reports_sm_white.png"
                                                    Height="25" Width="25" ID="Image8" />
                                            </td>
                                            <td align="left" class="entityImage">
                                                <asp:Label runat="server" Text="REPORT" ID="lbl_grid_head" CssClass="gridHeadText"
                                                    ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10"></asp:Label>
                                            </td>
                                            <td style="width: 20px; padding-right: 4px;">
                                                <asp:Image ID="imgExport" ImageUrl="~/App/Images/Icons/icon_export_sm_white.png"
                                                    runat="server" />
                                            </td>
                                            <td style="width: 40px; color: White; padding-right: 2px; vertical-align: middle;">
                                                Export
                                            </td>
                                            <td style="width: 10px; padding-right: 20px;">
                                                <asp:Image ID="Image9" ImageUrl="~/App/Images/Icons/asset_arrow_down_white_sm.png"
                                                    runat="server" />
                                            </td>
                                            <td align="right" style="padding-right: 5px; width: 20px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                    ClientIDMode="Static" ID="ReportMenu_0_img_expand_collapse" onclick="ReportMenu_expand_collapse(0)" />
                                            </td>
                                            <td align="right" style="width: 20px; padding-right: 15px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_close_lg_white.png"
                                                    onclick="closeReportWindow();" ClientIDMode="Static" ID="Image13" Height="18"
                                                    Width="18" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divReportContent" class="divProperties divScroll ReportMenu_0_Content">
                                    <table width="100%" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td valign="top">
                                            <div id="dv_asset" runat="server" style="display:block">
                                                <telerik:RadGrid ID="rg_search_data_new" OnPageIndexChanged="rg_search_data_new_OnPageIndexChanged"
                                                    OnPageSizeChanged="rg_search_data_new_OnPageSizeChanged" Skin="" runat="server"
                                                    AutoGenerateColumns="False" AllowSorting="False" GridLines="None" Font-Names="Arial"
                                                    Font-Size="9" Width="100%">
                                                    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="true" />
                                                    <ClientSettings AllowDragToGroup="true">
                                                        <Selecting AllowRowSelect="false" />
                                                        <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                        <Resizing AllowColumnResize="True"></Resizing>
                                                    </ClientSettings>
                                                    <ItemStyle CssClass="GridViewPointCompItem" HorizontalAlign="Center" />
                                                    <AlternatingItemStyle CssClass="GridViewPointCompAlt" />
                                                    <HeaderStyle CssClass="GridViewPointCompHead" />
                                                    <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" ShowHeader="false">
                                                        <Columns>
                                                            <telerik:GridTemplateColumn UniqueName="profile" HeaderText="" ItemStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                               
                                                                    <asp:Label ID="lblcertificates" Text='<%# Eval("AssetName")%>' runat="server"></asp:Label></ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblType" Text='<%# Eval("Asset_Name")%>' runat="server"></asp:Label></ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn UniqueName="location" HeaderText="">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblLocation" Text='<%# Eval("Space_Name")%>' runat="server"></asp:Label></ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn DataField="view_name" UniqueName="view_name" Visible="false"
                                                                HeaderText="View Name">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="ExtIdentifier" Visible="false">
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView></telerik:RadGrid>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                        <td>
                                            <telerik:RadGrid ID="rgSearchSpace" OnPageSizeChanged="rgSearchSpace_OnPageSizeChanged"
                                                OnPageIndexChanged="rgSearchSpace_OnPageIndexChanged" 
                                                MasterTableView-TableLayout="Fixed" Skin="" runat="server" AutoGenerateColumns="False"
                                                AllowSorting="False" GridLines="None" Font-Names="Arial" Font-Size="9">
                                                <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="true" />
                                                <ClientSettings AllowDragToGroup="true">
                                                    <Selecting AllowRowSelect="false" />
                                                    <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                    <Resizing AllowColumnResize="True"></Resizing>
                                                </ClientSettings>
                                                <ItemStyle CssClass="GridViewPointCompItem" />
                                               <AlternatingItemStyle CssClass="GridViewPointCompAlt" />
                                                <HeaderStyle CssClass="GridViewPointCompHead" />
                                                <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" ShowHeader="false" DataKeyNames="pk_location_id,fk_external_system_data_id"
                                                    ClientDataKeyNames="pk_location_id,fk_external_system_data_id">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnk_space" runat="server" Text='<%# Eval("Space_Name")%>'>
                                                                </asp:LinkButton></ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblType" Text='<%# Eval("Description")%>' runat="server"></asp:Label></ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn Visible="false" UniqueName="profile" HeaderText="">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSpaceId" Text='<%# Eval("pk_location_id")%>' runat="server"></asp:Label></ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn Visible="false" UniqueName="element_numeric_id" HeaderText="" Display="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblelementnumericId" Text='<%# Eval("fk_external_system_data_id")%>'
                                                                    runat="server"></asp:Label></ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                </MasterTableView></telerik:RadGrid>
                                        </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="width: 22%" valign="top">
                    <table id="tblRightPanel" runat="server" style="border-collapse: collapse;" cellpadding="0" cellspacing="0" width="100%">
                        <tr id="trComponents">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_asset_sm.png" ID="Image12" />
                                            </td>
                                            <td align="left" class="entityImage">
                                                <asp:Label runat="server" Text="ASSET" Font-Size="11px" ID="lbl_components"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 4px 0 0;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up.png" ClientIDMode="Static"
                                                    ID="RightMenu_0_img_expand_collapse" onclick="RightMenu_expand_collapse(0)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divComponentContent" class="divProperties divScroll RightMenu_0_Content">
                                    <telerik:RadGrid ID="rgcomponent" OnColumnCreated="rgcomponent_OnColumnCreated" OnItemCreated="rgcomponent_OnItemCreated"
                                        OnItemCommand="rgcomponent_OnItemCommand" OnSortCommand="rgcomponent_OnSortCommand"
                                        OnItemDataBound="rgcomponent_OnItemDataBound" OnPreRender="rgcomponent_OnPreRender"
                                        Skin="" runat="server" AutoGenerateColumns="False" AllowSorting="False" GridLines="None"
                                        ShowHeader="false" Font-Names="Arial" Font-Size="9">
                                        <ItemStyle CssClass="gridPropertiesItem" />
                                        <AlternatingItemStyle CssClass="gridPropertiesAlternateItem" />
                                        <ClientSettings AllowDragToGroup="true">
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                        </ClientSettings>
                                        <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" EditMode="EditForms"
                                            Width="100%" DataKeyNames="id,pk_unit_of_measurement_id">
                                            <GroupByExpressions>
                                                <telerik:GridGroupByExpression>
                                                    <SelectFields>
                                                        <telerik:GridGroupByField FieldAlias="Group" FieldName="Group_Name"></telerik:GridGroupByField>
                                                    </SelectFields>
                                                    <GroupByFields>
                                                        <telerik:GridGroupByField FieldName="Group_Name"></telerik:GridGroupByField>
                                                    </GroupByFields>
                                                </telerik:GridGroupByExpression>
                                            </GroupByExpressions>
                                            <GroupHeaderItemStyle Width="7%" Height="25px" />
                                            <ExpandCollapseColumn ExpandImageUrl="../Images/Icons/asset_carrot_down.png" CollapseImageUrl="../Images/Icons/asset_carrot_up.png"></ExpandCollapseColumn>
                                            <AlternatingItemStyle Height="26px" />
                                            <RowIndicatorColumn Visible="True">
                                            </RowIndicatorColumn>
                                            <Columns>
                                                <telerik:GridEditCommandColumn ButtonType="ImageButton" CancelText="Cancel" ItemStyle-Width="0px"
                                                    UniqueName="EditCommandColumn" UpdateText="Update">
                                                    <HeaderStyle Font-Size="Smaller" Width="6%" Wrap="false" />
                                                    <ItemStyle Width="5%" Wrap="false" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridBoundColumn DataField="attribute_name" HeaderText="<%$Resources:Resource, Parameter%>"
                                                    ReadOnly="true" UniqueName="parameter" Visible="true">
                                                    <HeaderStyle Width="30%" Wrap="false" />
                                                    <ItemStyle Width="30%" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="attribute_value" HeaderText="<%$Resources:Resource, Value%>"
                                                    Visible="true" UniqueName="Atrr_value">
                                                    <HeaderStyle Width="70%" Wrap="false" />
                                                    <ItemStyle Width="70%" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UOM" HeaderText="<%$Resources:Resource, UOM%>"
                                                    ReadOnly="true" UniqueName="Atrr_UOM" Visible="false">
                                                    <HeaderStyle Width="0%" Wrap="false" />
                                                    <ItemStyle Width="0%" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Group_Name" Display="false" HeaderText="group_name"
                                                    ReadOnly="true" Visible="false">
                                                    <HeaderStyle Wrap="false" />
                                                    <ItemStyle Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="table_name" HeaderText="tbl_name" ReadOnly="true"
                                                    Visible="false">
                                                    <HeaderStyle Wrap="false" />
                                                    <ItemStyle Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="read_only_flag" HeaderText="read_only_flag" ReadOnly="true"
                                                    Visible="false">
                                                    <HeaderStyle Wrap="false" />
                                                    <ItemStyle Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="id" HeaderText="ID" Visible="false" ReadOnly="true">
                                                    <HeaderStyle Wrap="false" />
                                                    <ItemStyle Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn UniqueName="remove" SortExpression="Remove" ItemStyle-HorizontalAlign="Center"
                                                    HeaderText="<%$Resources:Resource, Remove%>" Visible="false">
                                                    <HeaderStyle Width="0%" HorizontalAlign="Center" />
                                                    <ItemStyle CssClass="column" Width="0%" />
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" runat="server"
                                                            Width="14px" CommandName="delete" OnClientClick="javascript:return delete_attribute();" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn UniqueName="EditCommandColumn1">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                        <tr id="trType">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_type_sm.png" ID="Image4" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="TYPE" Font-Size="11px" ID="Label3"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 4px 0 0;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up.png" ClientIDMode="Static"
                                                    ID="RightMenu_1_img_expand_collapse" onclick="RightMenu_expand_collapse(1)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divTypeContent" class="divProperties divScroll RightMenu_1_Content">
                                    <telerik:RadGrid ID="rgtype" OnColumnCreated="rgtype_OnColumnCreated" OnItemCreated="rgtype_OnItemCreated"
                                        OnSortCommand="rgtype_OnSortCommand" OnItemCommand="rgtype_OnItemCommand" OnItemDataBound="rgtype_OnItemDataBound"
                                        OnPreRender="rgtype_OnPreRender" Skin="" runat="server" AutoGenerateColumns="False"
                                        AllowSorting="False" GridLines="None" ShowHeader="false" Font-Names="Arial" Font-Size="9">
                                        <ItemStyle CssClass="gridPropertiesItem" />
                                        <AlternatingItemStyle CssClass="gridPropertiesAlternateItem" />
                                        <ClientSettings AllowDragToGroup="true">
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                        </ClientSettings>
                                        <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" EditMode="EditForms" 
                                           Width="100%" DataKeyNames="id,pk_unit_of_measurement_id">
                                            <GroupByExpressions>
                                                <telerik:GridGroupByExpression>
                                                    <SelectFields>
                                                        <telerik:GridGroupByField FieldAlias="Group" FieldName="Group_Name"></telerik:GridGroupByField>
                                                    </SelectFields>
                                                    <GroupByFields>
                                                        <telerik:GridGroupByField FieldName="Group_Name"></telerik:GridGroupByField>
                                                    </GroupByFields>
                                                </telerik:GridGroupByExpression>
                                            </GroupByExpressions>
                                            <GroupHeaderItemStyle Width="7%" Height="25px" />
                                            <AlternatingItemStyle Height="26px" />
                                            <RowIndicatorColumn Visible="True">
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <telerik:GridEditCommandColumn ButtonType="ImageButton" CancelText="<%$Resources:Resource, Cancel%>"
                                                    ItemStyle-Width="0px" UniqueName="EditCommandColumn" UpdateText="<%$Resources:Resource, Update%>">
                                                    <HeaderStyle Font-Size="Smaller" Width="6%" Wrap="false" />
                                                    <ItemStyle Width="5%" Wrap="false" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridBoundColumn DataField="attribute_name" HeaderText="<%$Resources:Resource, Parameter%>"
                                                    ReadOnly="true" UniqueName="parameter" Visible="true">
                                                    <HeaderStyle Width="30%" Wrap="false" />
                                                    <ItemStyle Width="30%" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="attribute_value" HeaderText="<%$Resources:Resource, Value%>"
                                                    Visible="true" UniqueName="Atrr_value">
                                                    <HeaderStyle Width="70%" Wrap="false" />
                                                    <ItemStyle Width="70%" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UOM" HeaderText="<%$Resources:Resource, UOM%>"
                                                    ReadOnly="true" UniqueName="Atrr_UOM" Visible="false">
                                                    <HeaderStyle Width="0%" Wrap="false" />
                                                    <ItemStyle Width="0%" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="group_Name" Display="false" HeaderText="group_name"
                                                    ReadOnly="true" Visible="false">
                                                    <HeaderStyle Wrap="false" />
                                                    <ItemStyle Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="table_name" HeaderText="tbl_name" ReadOnly="true"
                                                    Visible="false">
                                                    <HeaderStyle Wrap="false" />
                                                    <ItemStyle Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="read_only_flag" HeaderText="read_only_flag" ReadOnly="true"
                                                    Visible="false">
                                                    <HeaderStyle Wrap="false" />
                                                    <ItemStyle Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="id" HeaderText="ID" Visible="false" ReadOnly="true">
                                                    <HeaderStyle Wrap="false" />
                                                    <ItemStyle Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn UniqueName="remove" SortExpression="Remove" ItemStyle-HorizontalAlign="Center"
                                                    Visible="false" HeaderText="<%$Resources:Resource, Remove%>">
                                                    <HeaderStyle Width="0%" HorizontalAlign="Center" />
                                                    <ItemStyle CssClass="column" Width="0%" />
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" runat="server"
                                                            Width="14px" CommandName="delete" OnClientClick="javascript:return delete_attribute();" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn UniqueName="EditCommandColumn1">
                                                </EditColumn>
                                            </EditFormSettings>
                                            <GroupHeaderItemStyle Width="10px" />
                                        </MasterTableView>
                                        <FilterMenu EnableImageSprites="False">
                                        </FilterMenu>
                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Forest">
                                        </HeaderContextMenu>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                        <tr id="trDocuments">
                            <td>
                                <div class="rpbItemHeader">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td onclick="stopPropagation(event)" style="width: 20px; padding: 4px 0 0 3px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/icon_documents_sm.png" ID="Image6" />
                                            </td>
                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                <asp:Label runat="server" Text="DOCUMENTS" Font-Size="11px" ID="Label4"></asp:Label>
                                            </td>
                                            <td align="right" style="padding: 4px 8px 0 0px; width: 20px;" onclick="stopPropagation(event)">
                                                <asp:ImageButton ID="btnAddDocument" runat="server" ImageUrl="~/App/Images/Icons/asset_add_sm.png"
                                                    AlternateText="<%$Resources:Resource, Add_Document%>" OnClick="btnAddDocument_OnClick" />
                                            </td>
                                            <td align="right" style="padding: 4px 4px 0 0; width: 20px;">
                                                <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up.png" ClientIDMode="Static"
                                                    ID="RightMenu_2_img_expand_collapse" onclick="RightMenu_expand_collapse(2)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divdocumentContent" class="divProperties divScroll RightMenu_2_Content">
                                    <telerik:RadGrid ID="rgdocument" runat="server" AutoGenerateColumns="false" OnSortCommand="rgdocument_OnSortCommand"
                                        AllowPaging="false" OnItemCommand="rg_document_item_command" Skin="" 
                                        AllowSorting="False" GridLines="None" ShowHeader="false" Font-Names="Arial" Font-Size="9">
                                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                        <ItemStyle CssClass="gridPropertiesItem" />
                                        <AlternatingItemStyle CssClass="gridPropertiesAlternateItem" />
                                        <ClientSettings AllowDragToGroup="true">
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                            <DataBinding EnableCaching="true">
                                            </DataBinding>
                                        </ClientSettings>
                                        <MasterTableView DataKeyNames="document_id,entity_name" TableLayout="Fixed" GroupLoadMode="Client">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="document_id" HeaderText="ID" Visible="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="document_name" HeaderText="<%$Resources:Resource, Document_Name%>">
                                                    <ItemStyle CssClass="column" Width="60%" />
                                                    <HeaderStyle Width="60%" />
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlnkDocName" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"file_path")%>'
                                                            Text='<%# DataBinder.Eval(Container.DataItem,"document_name")%>' runat="server"
                                                            Target="_blank"></asp:HyperLink></ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="document_id">
                                                    <ItemStyle CssClass="column" />
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkEdit" Visible="true" runat="server" CausesValidation="false"
                                                            OnClientClick="javascript:return load_popup(this);" Text="Edit" pk_document_id='<%# DataBinder.Eval(Container.DataItem,"document_id")%>'
                                                            entity_name='<%# DataBinder.Eval(Container.DataItem,"entity_name")%>'>
                                                        </asp:LinkButton></ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="entity_name" HeaderText="">
                                                    <ItemStyle CssClass="column" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn UniqueName="remove" SortExpression="Remove" ItemStyle-HorizontalAlign="Left"
                                                    HeaderText="<%$Resources:Resource, Remove%>" Visible="false">
                                                    <HeaderStyle Width="20%" HorizontalAlign="Left" />
                                                    <ItemStyle CssClass="column" Width="20%" />
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" runat="server"
                                                            CommandName="delete" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                        </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hfViewName" runat="server" />
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:HiddenField ID="hidden_view_name" runat="server" />
    <asp:HiddenField ID="hidden_Object_code" runat="server" />
    <asp:HiddenField ID="HiddenField2" runat="server" />
    <asp:HiddenField ID="hf_entity_handle" runat="server" />
    <asp:HiddenField ID="HiddenField3" runat="server" />
    <asp:HiddenField ID="HiddenField4" runat="server" />
    <asp:HiddenField ID="hf_guid" runat="server" />
    <asp:HiddenField ID="hf_strElementName" runat="server" />
    <asp:HiddenField ID="hf_TypeID" runat="server" />
    <asp:HiddenField ID="str_element_ID" runat="server" />
    <asp:HiddenField ID="hfSpaceElementNumericId" runat="server" />
    <asp:HiddenField ID="hf_cb_attribute_id" runat="server" />
    <asp:HiddenField ID="hf_cb_attribute_id_1" runat="server" />
    <asp:HiddenField ID="hf_work_order_id" runat="server" />
    <asp:HiddenField ID="hf_dock_num" runat="server" />
    <asp:HiddenField ID="comp_element_id" runat="server" />
    <asp:HiddenField ID="pk_location_id" runat="server" />
    <asp:HiddenField ID="HiddenField5" runat="server" />
    <asp:HiddenField ID="HiddenField6" runat="server" />
    <asp:HiddenField ID="HiddenField7" runat="server" />
    <asp:HiddenField ID="hdn_conn_string" runat="server" />
    <asp:HiddenField ID="hdnrevitautocad" runat="server" />
    <asp:HiddenField ID="hdnfacilityid" runat="server" />
    <asp:HiddenField ID="hdnsystemid" runat="server" />
    <asp:HiddenField ID="HiddenField8" runat="server" />
    <asp:HiddenField ID="HiddenField9" runat="server" />
    <asp:HiddenField ID="hf_client_con_string" runat="server" />
    <asp:HiddenField ID="hf_btnback_flag" runat="server" />
   
    <asp:HiddenField ID="hf_category" runat="server" />
    <asp:HiddenField ID="hf_entity" runat="server" />
    <asp:HiddenField ID="hf_system_id" runat="server" />
    <asp:HiddenField ID="hf_file_id" runat="server" />
    <telerik:RadAjaxManager ID="manager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgcomponent">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgcomponent"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rtv_System">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_component" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_find_component">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_search_data_new" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnFindSpace">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgSearchSpace" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_search_data_new" LoadingPanelID="RadAjaxLoadingPanel1" />
                     <telerik:AjaxUpdatedControl ControlID="rgSearchSpace" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="rcm_entity">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lbl_entity" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btn_properties">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="RadAjaxLoadingPanel2" />
                    <telerik:AjaxUpdatedControl ControlID="rgcomponent" LoadingPanelID="RadAjaxLoadingPanel2" />
                    <telerik:AjaxUpdatedControl ControlID="rg_room_data_sheet" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="radgrdimpact" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="rgdocument" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="rgSearchSpace" LoadingPanelID="RadAjaxLoadingPanel1" />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_refresh_asset" >
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgtype" LoadingPanelID="RadAjaxLoadingPanel2" />
                    <telerik:AjaxUpdatedControl ControlID="rgcomponent" LoadingPanelID="RadAjaxLoadingPanel2" />
                    <telerik:AjaxUpdatedControl ControlID="rg_room_data_sheet" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="radgrdimpact" LoadingPanelID="RadAjaxLoadingPanel1" />
                     <telerik:AjaxUpdatedControl ControlID="rgdocument" LoadingPanelID="RadAjaxLoadingPanel1" />
                      <telerik:AjaxUpdatedControl ControlID="rg_search_data_new" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>


     <telerik:RadContextMenu ID="rcm_entity" runat="server" EnableRoundedCorners="true"
        Width="40px" EnableShadows="true" OnItemClick="rcm_entity_ItemClick" 
        CssClass="normalLabel">
        <Items>
            <telerik:RadMenuItem Text="Asset" Font-Names="Arial" Value="Equipment" />
            <telerik:RadMenuItem Text="Space" Font-Names="Arial" Value="Space" />
            <telerik:RadMenuItem Text="Type" Font-Names="Arial" Value="Type" />
        </Items>
    </telerik:RadContextMenu>

    <telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Red" Skin="">
        <Windows>
             <telerik:RadWindow ID="rd_add_type" runat="server" ReloadOnShow="false" Height="450"
                Width="600"  AutoSize="false" OffsetElementID="btn_search" 
                VisibleStatusbar="false" VisibleOnPageLoad="false"  BorderColor="Black"  Behaviors="Resize"
                EnableAjaxSkinRendering="false" BorderStyle="None" BackColor="Red" VisibleTitlebar="false"
                Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    </form>
</body>
</html>
