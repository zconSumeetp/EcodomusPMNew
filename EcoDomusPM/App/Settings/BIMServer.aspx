<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    ValidateRequest="false" CodeFile="BIMServer.aspx.cs" Inherits="App_Settings_BIMServer" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
    </telerik:RadStyleSheetManager>
    <%--<html xmlns="http://www.w3.org/1999/xhtml">--%>
    <telerik:RadCodeBlock runat="server">
        <script type="text/javascript">
            window.onload = body_load;
            function body_load() {
                var screenhtg = set_NiceScrollToPanel();

            }
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            function ProjectValidation() {

                alert('Please select Project');
                window.location = '../Settings/Project.aspx';
                return false;

            }

            function NiceScrollOnload() {

                var screenhtg = set_NiceScrollToPanel();
                $("html").css('overflow-y', 'hidden');
                $("html").css('overflow-x', 'auto');

            }

            $(document).ready(function () {
                $("#div_contentPlaceHolder").scroll(function () {
                    $("#ctl00_ContentPlaceHolder1_ruImportLocation").removeClass('RadUpload');
                    $("#ctl00_ContentPlaceHolder1_ruImportLocation").addClass('RadUpload');

                    $("#ctl00_ContentPlaceHolder1_btnSubmit,#ctl00_ContentPlaceHolder1_btnreplace,#ctl00_ContentPlaceHolder1_btn_download").removeClass('rbSkinnedButton');
                    $("#ctl00_ContentPlaceHolder1_btnSubmit,#ctl00_ContentPlaceHolder1_btnreplace,#ctl00_ContentPlaceHolder1_btn_download").addClass('rbSkinnedButton');

                });
            });

            function set_popup_values(id, name) {
                document.getElementById("<%=hfselectedId.ClientID %>").value = id;
                document.getElementById("<%=hf_facilityid.ClientID %>").value = id;
                document.getElementById("<%=hfselectedname.ClientID %>").value = name;
               
            }

            function buttoncallback_Type() {

                document.getElementById("<%=lblselectedfacility.ClientID %>").innerHTML = document.getElementById("<%=hfselectedname.ClientID %>").value;
                document.getElementById("<%=btn_refresh.ClientID %>").click();

            }

            function openpopupSelectFacility() {


                manager = $find("<%=rad_windowmgr.ClientID %>");
               
                var url;
                var url = "../Asset/selectfacilitypopupmodel.aspx";

                if (manager != null) {
                    var windows = manager.get_windows();

                    windows[0].setUrl(url);
                    windows[0].show();
                    
                }
                return false ;
            }
         

            function openpopupSelectFacility1(fileid,facilityid) {


                manager = $find("<%=rad_windowmgr1.ClientID %>");

                var url;
                var url = "../Settings/FileHistoryPopup.aspx?fileid="+fileid+"&facilityid="+facilityid+"";

                if (manager != null) {
                    var windows = manager.get_windows();

                    windows[0].setUrl(url);
                    windows[0].show();
                 
                }
                return false;
            }
         
     
            function deleteLocation() {
                var flag;
                flag = confirm("Do you want to delete this file?");
                return flag;
            }


            var viewpointcnt = 0;
            function jump_model(file_id, facility_id, file_name, fk_master_file_id) {
                //debugger
                var str = file_name.toString();
                if (str.match("nwd") == "nwd") {
                    window.location.replace("ModelViewer.aspx?FileId=" + file_id + "&view_pt=none&fk_master_file_id=" + fk_master_file_id + "&facility_id=" + facility_id + "");
                    return false;
                }
                else {
                    window.location.replace("EcodomusModelViewer.aspx?FileId=" + file_id + "&view_pt=none&fk_master_file_id=" + fk_master_file_id + "&facility_id=" + facility_id + "");
                    return false;
                }
            }

            function result_msg(msg) {
                alert(msg);
                //return false;

            }

            function extract_view() {

                
                try {

                    document.getElementById("<%=hf_parent_id.ClientID %>").value = 0;
                    document.getElementById("<%=hf_parent_2nd.ClientID %>").value = 0;
                    document.getElementById("<%=hf_view_pt.ClientID %>").value = "<root>"
                    document.getElementById("<%=hf_sqnc_number.ClientID %>").value = 0;

                    for (var i = 1; i <= document.NWControl01.State.SavedViews().count; i++) {

                        var view = document.NWControl01.State.SavedViews(i);
                        switch (document.NWControl01.State.SavedViews(i).ObjectName) {

                            case "nwOpFolderView":
                                var nwid_int;
                                var nwid;
                                nwid_int = 0;

                                nwid_int = view.name;

                                document.getElementById("<%=hf_nwid.ClientID %>").value = nwid_int;

                                nwid = "" + document.getElementById("<%=hf_nwid.ClientID %>").value;

                                var folder;
                                folder = view;

                                document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "<folder   name='" + view.name + "' id='" + nwid + "' parentid='" + document.getElementById("<%=hf_parent_id.ClientID %>").value + "' sqn_number='" + document.getElementById("<%=hf_sqnc_number.ClientID %>").value + "'>";
                               // viewpointcnt = viewpointcnt + 1;


                                document.getElementById("<%=hf_parent_id.ClientID %>").value = nwid;


                                myrecurse(folder, document.getElementById("<%=hf_parent_id.ClientID %>").value)

                                document.getElementById("<%=hf_parent_id.ClientID %>").value = 0;
                                document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "</folder>";
                                break;

                            case "nwOpView":


                                var nwid_int1;
                                var nwid1;
                                nwid_int1 = 0;



                                document.getElementById("<%=hf_nwid.ClientID %>").value = nwid_int1

                                nwid1 = "" + document.getElementById("<%=hf_nwid.ClientID %>").value

                                document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "<view name='" + view.name + "' id='" + nwid1 + "' parentid='" + document.getElementById("<%=hf_parent_id.ClientID %>").value + "' sqn_number='" + document.getElementById("<%=hf_sqnc_number.ClientID %>").value + "'/>"

                                viewpointcnt = viewpointcnt + 1

                                break;

                        }

                      //  document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "</folder>";
                    }

                    document.getElementById("<%=hf_sqnc_number.ClientID %>").value = viewpointcnt;
                    document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "</root>"
                   

                }
                catch (e) {
                    alert("Exception Caught:" + e.Description);
                    return false;

                }

            }

            function extract_view_old() {

           // debugger
                try {

                    document.getElementById("<%=hf_parent_id.ClientID %>").value = 0;
                    document.getElementById("<%=hf_parent_2nd.ClientID %>").value = 0;
                    document.getElementById("<%=hf_view_pt.ClientID %>").value = "<root>"
                    document.getElementById("<%=hf_sqnc_number.ClientID %>").value = 0;

                    for (var i = 1; i <= document.NWControl01.State.SavedViews().count; i++) {

                        var view = document.NWControl01.State.SavedViews(i);
                        switch (document.NWControl01.State.SavedViews(i).ObjectName) {

                            case "nwOpFolderView":
                                var nwid_int;
                                var nwid;
                                nwid_int = 0;

                                nwid_int = view.name;

                                document.getElementById("<%=hf_nwid.ClientID %>").value = nwid_int;

                                nwid = "" + document.getElementById("<%=hf_nwid.ClientID %>").value;

                                var folder;
                                folder = view;

                                document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "<folder name='" + view.name + "' id='" + nwid + "' parentid='" + document.getElementById("<%=hf_parent_id.ClientID %>").value + "' sqn_number='" + document.getElementById("<%=hf_sqnc_number.ClientID %>").value + "'></folder>";
                                viewpointcnt = viewpointcnt + 1;


                                document.getElementById("<%=hf_parent_id.ClientID %>").value = nwid;


                                myrecurse(folder, document.getElementById("<%=hf_parent_id.ClientID %>").value)

                                document.getElementById("<%=hf_parent_id.ClientID %>").value = 0;
                                break;

                            case "nwOpView":


                                var nwid_int1;
                                var nwid1;
                                nwid_int1 = 0;



                                document.getElementById("<%=hf_nwid.ClientID %>").value = nwid_int1

                                nwid1 = "" + document.getElementById("<%=hf_nwid.ClientID %>").value

                                document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "<view name='" + view.name + "' id='" + nwid1 + "' parentid='" + document.getElementById("<%=hf_parent_id.ClientID %>").value + "' sqn_number='" + document.getElementById("<%=hf_sqnc_number.ClientID %>").value + "'/>"

                                viewpointcnt = viewpointcnt + 1

                                break;

                        }


                    }

                    document.getElementById("<%=hf_sqnc_number.ClientID %>").value = viewpointcnt;
                    document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "</root>"


                }
                catch (e) {
                    alert("Exception Caught:" + e.Description);
                    return false;

                }

            }
            //added following 2 lines on 18-05-2012
            var parentcnt = 0;

            var ParentValues = new Array();
            function myrecurse(view1, parent_id) {

                //  debugger
                document.getElementById("<%=hf_parent_2nd.ClientID %>").value = parent_id;

                for (var i = 1; i <= view1.SavedViews().count; i++) {


                    var view = view1.SavedViews(i);
                    switch (view.ObjectName) {



                        case "nwOpFolderView":

                            var folder;
                            folder = view;
                            var nwid_int2;
                            var nwid2;
                            nwid_int2 = 0;
                            //document.NWControl01.State.X64PtrVar(view, nwid_int2);
                            nwid_int2 = view.name;

                            document.getElementById("<%=hf_nwid.ClientID %>").value = nwid_int2;
                            nwid2 = "" + document.getElementById("<%=hf_nwid.ClientID %>").value;
                            document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "<folder name='" + view.name + "' id='" + nwid2 + "' parentid='" + parent_id + "' sqn_number='" + document.getElementById("<%=hf_sqnc_number.ClientID %>").value + "'>";
                           // viewpointcnt = viewpointcnt + 1;
                            document.getElementById("<%=hf_parent_2nd.ClientID %>").value = nwid2;


                            myrecurse(folder, document.getElementById("<%=hf_parent_2nd.ClientID %>").value);

                            document.getElementById("<%=hf_parent_2nd.ClientID %>").value = document.getElementById("<%=hf_parent_id.ClientID %>").value;
                            document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "</folder>"
                            break;

                        case "nwOpView":

                            var nwid_int3;
                            var nwid3;
                            nwid_int3 = 0;
                            // document.NWControl01.State.X64PtrVar(view, nwid_int3);
                            document.getElementById("<%=hf_nwid.ClientID %>").value = nwid_int3;
                            nwid3 = "" & document.getElementById("<%=hf_nwid.ClientID %>").value;
                            //  document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "<view name='" + view.name + "' id='" + nwid3 + "' parentid='" + document.getElementById("<%=hf_parent_2nd.ClientID %>").value + "' sqn_number='" + document.getElementById("<%=hf_sqnc_number.ClientID %>").value + "'></view>";
                            document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "<view name='" + view.name + "' id='" + nwid3 + "' parentid='" + parent_id + "' sqn_number='" + document.getElementById("<%=hf_sqnc_number.ClientID %>").value + "'></view>";
                            viewpointcnt = viewpointcnt + 1;
                            break;

                    }

                }

            }

            function myrecurse_old(view1, parent_id) {

              //  debugger
                document.getElementById("<%=hf_parent_2nd.ClientID %>").value = parent_id;

                for (var i = 1; i <= view1.SavedViews().count; i++) {


                    var view = view1.SavedViews(i);
                    switch (view.ObjectName) {



                        case "nwOpFolderView":

                            var folder;
                            folder = view;
                            var nwid_int2;
                            var nwid2;
                            nwid_int2 = 0;
                            //document.NWControl01.State.X64PtrVar(view, nwid_int2);
                            nwid_int2 = view.name;

                            document.getElementById("<%=hf_nwid.ClientID %>").value = nwid_int2;
                            nwid2 = "" + document.getElementById("<%=hf_nwid.ClientID %>").value;
                            document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "<folder name='" + view.name + "' id='" + nwid2 + "' parentid='" + parent_id + "' sqn_number='" + document.getElementById("<%=hf_sqnc_number.ClientID %>").value + "'></folder>";
                            viewpointcnt = viewpointcnt + 1;
                            document.getElementById("<%=hf_parent_2nd.ClientID %>").value = nwid2;


                            myrecurse(folder, document.getElementById("<%=hf_parent_2nd.ClientID %>").value);

                            document.getElementById("<%=hf_parent_2nd.ClientID %>").value = document.getElementById("<%=hf_parent_id.ClientID %>").value;
                            break;

                        case "nwOpView":

                            var nwid_int3;
                            var nwid3;
                            nwid_int3 = 0;
                            // document.NWControl01.State.X64PtrVar(view, nwid_int3);
                            document.getElementById("<%=hf_nwid.ClientID %>").value = nwid_int3;
                            nwid3 = "" & document.getElementById("<%=hf_nwid.ClientID %>").value;
                          //  document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "<view name='" + view.name + "' id='" + nwid3 + "' parentid='" + document.getElementById("<%=hf_parent_2nd.ClientID %>").value + "' sqn_number='" + document.getElementById("<%=hf_sqnc_number.ClientID %>").value + "'></view>";
                            document.getElementById("<%=hf_view_pt.ClientID %>").value = document.getElementById("<%=hf_view_pt.ClientID %>").value + "<view name='" + view.name + "' id='" + nwid3 + "' parentid='" + parent_id + "' sqn_number='" + document.getElementById("<%=hf_sqnc_number.ClientID %>").value + "'></view>";
                            viewpointcnt = viewpointcnt + 1;
                            break;

                    }

                }

            }

            function sethdnfield() {
               
                document.getElementById("<%=hf_sqnc_number.ClientID %>").value = "";
                if (document.getElementById("<%=lnk_assgnFacility.ClientID %>") != null) {
                    if (document.getElementById("<%=hfselectedId.ClientID %>").value == "") {
                        alert("Please select Facility")
                        return false;
                    }

                }
            }

            function message() {
                //alert("View Point Extracted into EcoDomus");
                alert(document.getElementById("<%=hf_sqnc_number.ClientID %>").value + " View Points Extracted..!!")
                document.getElementById("<%=hf_sqnc_number.ClientID %>").value = "";

            }

            function onClientProgressBarUpdating(progressArea, args) {
                progressArea.updateHorizontalProgressBar(args.get_progressBarElement(), args.get_progressValue());
                args.set_cancel(true);
            }

            function RowSelected(sender, eventArgs) {
           
              
                var dataItem = $get(eventArgs.get_id());
                var grid = sender;
//                var MasterTable = grid.get_masterTableView();
//                var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
//                var cell = MasterTable.getCellByColumnUniqueName(row, "pk_uploaded_file_id");
//                var facility = MasterTable.getCellByColumnUniqueName(row, "pk_facility_id");

              
                document.getElementById("hfselected_fileid");

                document.getElementById(cell.innerHTML).checked = true;

//                var fileid = document.getElementById("<%=hfselected_fileid.ClientID %>");
//                fileid.value = MasterTable.getCellByColumnUniqueName(row, "pk_uploaded_file_id").innerHTML;
//                var facilityID = document.getElementById("<%=hffacilityID.ClientID %>");
//               
//                facilityID.value = MasterTable.getCellByColumnUniqueName(row, "pk_facility_id").innerHTML;


            }

            function ColumnSelected() { 
            }
      
        </script>
    </telerik:RadCodeBlock> 
  
   
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <script language="VBScript" type="text/vbscript">
     
        Option Explicit
        Dim counter

        Public Sub NWControl01_OnFileOpen()
 

                    Dim comp_id
                    if document.getElementById("<%=hf_sqnc_number.ClientID%>").value="" Then
                            
                            
                            document.getElementById("<%=btn_extract_data.ClientID%>").click()
                            

                    End If
 


        End Sub

    </script>
    <%-- <body>  --%>
    <div>
        <asp:HiddenField ID="PK_element_Numeric_ID" runat="server" />
        <asp:HiddenField ID="masterflag" runat="server" />
        <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Hay" DecoratedControls="Buttons" />
        <table runat="server" id="tblBIMServerId" style="width: 100%;">
            <tr>
                <td>
                    <table runat="server" id="tblhead" style="width: 90%;">
                        <tr id="trUploadBim" runat="server">
                            <td valign="top" style="width: 5%;">
                                <asp:Label ID="lblfac" runat="server" Text="<%$Resources:Resource, Facility%>" CssClass="Label"
                                    Font-Size="12px" Font-Bold="false"></asp:Label>:
                            </td>
                            <td valign="top">
                                <asp:Label ID="lblselectedfacility" runat="server"></asp:Label>&nbsp;
                                <asp:LinkButton ID="lnk_assgnFacility" CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupSelectFacility()">
                                    <asp:Label ID="lblselectfacility" runat="server" Text="<%$Resources:Resource, Select_Facility%>"></asp:Label>
                                </asp:LinkButton>
                            </td>
                            <td valign="top" style="width: 9%;">
                                <asp:Label ID="Label1" CssClass="Label" runat="server" Font-Size="12px" Font-Bold="false"
                                    Text="<%$Resources:Resource,Master_File%>"></asp:Label>:
                            </td>
                            <td valign="top" style="width: 25%;">
                                <telerik:RadComboBox ID="cmbmasterfiles" Skin="Default" runat="server" Width="90%"
                                    DataValueField="pk_uploaded_file_id" DataTextField="file_name">
                                </telerik:RadComboBox>
                            </td>
                            <td valign="top" style="width: 25%; margin-top: 2px;">
                                <telerik:RadUpload ID="ruImportLocation" runat="server" ControlObjectsVisibility="None"
                                    InitialFileInputsCount="1" OverwriteExistingFiles="false" Width="100%" />
                                <label id="invalidext">
                                </label>
                                <%--<telerik:RadProgressManager ID="rpmanager1" runat="server"></telerik:RadProgressManager>
                <telerik:RadProgressArea ID="rpaImportLocation" runat="server" ProgressIndicators="TotalProgressBar, TotalProgress, TotalProgressPercent, RequestSize, CurrentFileName, TimeElapsed, TimeEstimated, TransferSpeed">
                </telerik:RadProgressArea>
                                --%><%--  <telerik:RadWindowManager ID="rwmanager1" runat="server" VisibleStatusbar="false">
                        <Windows>
                            <telerik:RadWindow ID="RadWindow1" runat="server" Animation="None" Behavior="Resize"
                                BorderStyle="Solid" Title="Wait" VisibleStatusbar="false">
                            </telerik:RadWindow>
                        </Windows>
                   
                    </telerik:RadWindowManager>--%>
                            </td>
                            <td valign="top" style="width: 20%;">
                                <telerik:RadButton Skin="Default" ID="btnSubmit" runat="server" Text="<%$Resources:Resource, Upload_replace%>"
                                    OnClick="btnSubmit_Click"   >
                                </telerik:RadButton>
                            </td>
                            <td align="left" style="vertical-align: top; text-align: center; display: none;">
                                <telerik:RadComboBox Width="90%" ID="cmbfacility" Filter="Contains" runat="server"
                                    oncopy="return false;" AllowCustomText="True" onpaste="return false;" oncut="return false;"
                                    onkeypress="return tabOnly(event)" onmousewheel="return false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CheckBox1" runat="server" Text='<%# Eval("name") %>' />
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </td>
                            <%--    <td align="left"   style="vertical-align: top; text-align: center;">
                   <telerik:RadButton Skin="Default" CausesValidation="true" ID="btnSubmit" runat="server" Text="<%$Resources:Resource, Upload%>" OnClick="btnSubmit_Click" 
                        OnClientClick="javascript:return sethdnfield();" />
                </td>--%>
                            <%--      <td align="left"  style="vertical-align: top; text-align: center;" >
                   <telerik:RadButton Skin="Default" ID="btnreplace" runat="server"   Text="<%$Resources:Resource, Replace%>" onclick="btnreplace_Click" ></telerik:RadButton>
                </td>--%>
                            <%--    <td align="left"  style="vertical-align: top; text-align: center;" >
                   <telerik:RadButton Skin="Default" ID="btn_download" runat="server"  Text="<%$Resources:Resource, Download%>" onclick="btn_download_Click" ></telerik:RadButton>
                </td>--%>
                            <td valign="top" style="display: none;">
                                <asp:Button ID="btn_extract_data" runat="server" Visible="true" Width="0px" OnClick="btn_extract_data_OnClick"
                                    OnClientClick="javascript:return extract_view();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr align="left">
                <td align="left">
                    <table align="left" style="margin-top: 5px; margin-left: 0px;" width="90%">
                        <tr>
                            <td style="width: 100%; vertical-align: top;">
                                <telerik:RadGrid ID="rguploadedfiles" AutoGenerateColumns="false" Skin="Default"
                                    AllowSorting="True" PageSize="10" runat="server" AllowPaging="True" GridLines="None"
                                    OnPageIndexChanged="rguploadedfiles_OnPageIndexChanged" OnPageSizeChanged="rguploadedfiles_PageSizeChanged"
                                    OnSortCommand="rguploadedfiles_SortCommand" OnItemDataBound="rguploadedfiles_ItemDataBound"
                                    OnItemCommand="rguploadedfiles_OnItemCommand" OnDetailTableDataBind="rg_childfilebind"
                                    Width="100%" PagerStyle-AlwaysVisible="true" CellPadding="0" CellSpacing="0"
                                    ItemStyle-Wrap="false">
                                    <PagerStyle Mode="NextPrevAndNumeric" />
                                    <ClientSettings>
                                        <Selecting AllowRowSelect="True" />
                                        <ClientEvents  OnRowSelected="RowSelected" />
                                        <ClientEvents OnColumnClick="ColumnSelected" />
                                       
                                    </ClientSettings>
                                    
                                    <FilterMenu EnableEmbeddedSkins="false">
                                    </FilterMenu>
                                    <GroupingSettings CaseSensitive="false" />
                                    <MasterTableView DataKeyNames="pk_uploaded_file_id,pk_facility_id" Name="ParentFiles">
                                    
                                        <DetailTables>
                                        
                                            <telerik:GridTableView Name="childFiles" Width="99%" ShowHeader="false" ShowFooter="false" BorderStyle="None" DataKeyNames="pk_uploaded_file_id">
                                            <PagerStyle AlwaysVisible="false" Visible="false" ShowPagerText="false" />
                                           
                                                <Columns>
                                                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="<%$Resources:Resource, Select%>"
                                                        UniqueName="TemplateColumn">
                                                        <ItemStyle Width="5%" />
                                                        <ItemTemplate>
                                                            <input id='<%# Eval("pk_uploaded_file_id") %>' name="rdselect" type="radio" value='<%# Eval("pk_uploaded_file_id") %>',<%# Eval("fk_facility_id") %>' />
                                                        </ItemTemplate> 
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="pk_uploaded_file_id" HeaderText="pk_uploaded_file_id"
                                                        Display="False" SortExpression="pk_uploaded_file_id" UniqueName="pk_uploaded_file_id">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="fk_facility_id" HeaderText="fk_facility_id" Display="False"
                                                        SortExpression="fk_facility_id" UniqueName="fk_facility_id">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="file_name" HeaderText="<%$Resources:Resource, Uploaded_File_Name%>"
                                                        AllowFiltering="true" SortExpression="file_name" UniqueName="file_name">
                                                          <ItemStyle Width="25%" CssClass="itemstyle" Wrap="false" HorizontalAlign="Left" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="filesize" FilterListOptions="VaryByDataTypeAllowCustom"
                                                        HeaderText="<%$Resources:Resource, File_Size%>" AllowFiltering="true" SortExpression="filesize"
                                                        UniqueName="filesize" >
                                                         <ItemStyle CssClass="itemstyle" HorizontalAlign="Left" Wrap="false" Width="12%" />
                                                         <HeaderStyle HorizontalAlign="Left" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Uploaded_By" HeaderText="<%$Resources:Resource, Uploaded_By%>"
                                                        AllowFiltering="true" SortExpression="Uploaded_By" UniqueName="Uploaded_By">
                                                       <ItemStyle CssClass="itemstyle" HorizontalAlign="Left" Wrap="false" Width="20%" />
                                                       <HeaderStyle HorizontalAlign="Left" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="uploadedon" FilterListOptions="VaryByDataTypeAllowCustom"
                                                        HeaderText="<%$Resources:Resource, Uploaded_On%>" AllowFiltering="true" SortExpression="uploadedon"
                                                        UniqueName="uploadedon">
                                                           <ItemStyle CssClass="itemstyle" HorizontalAlign="Left" Wrap="false" Width="14%" />
                                                         <HeaderStyle HorizontalAlign="Left" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="fk_master_file_id" HeaderText="fk_master_file_id"
                                                        Display="False" SortExpression="fk_master_file_id" UniqueName="fk_master_file_id">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="<%$Resources:Resource, View%>"
                                                        UniqueName="bim">
                                                        <ItemStyle Width="8%" HorizontalAlign="Center" Wrap="false" />
                                                          <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="btn_bim" runat="server" ImageUrl="~/App/Images/icon_BIMview_sm.png"
                                                                AlternateText="<%$Resources:Resource, View%>"  />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn UniqueName="Show_Log" HeaderText="Show Log Change" ItemStyle-HorizontalAlign="Center" Visible="false">
                                                        <ItemStyle CssClass="column" HorizontalAlign="Center" Wrap="false"  />
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imgbtnshowlog" ImageUrl="~/App/Images/log_file_icon1.png" AlternateText="<%Resources:Resource, Show_change_log %>"
                                                                runat="server" CommandName="ShowLog"  />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn UniqueName="History" HeaderText="History" ItemStyle-HorizontalAlign="Center">
                                                       <ItemStyle CssClass="column" HorizontalAlign="Center" Wrap="false" Width="7%" />
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imgbtnhistory" ImageUrl="~/App/Images/history-2.png" AlternateText="<%Resources:Resource,History %>"
                                                                runat="server"  CommandName="history"   />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn UniqueName="download" HeaderText="Download" ItemStyle-HorizontalAlign="Center">
                                                         <ItemStyle CssClass="column" HorizontalAlign="Center" Wrap="false" width="9%" />
                                                          <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imgbtnsave" ImageUrl="~/App/Images/save.png" AlternateText="<%Resources:Resource,Download %>"
                                                                runat="server"  onclick="btn_download_Click"   />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn UniqueName="remove" HeaderText="<%$Resources:Resource, Delete%>"
                                                        ItemStyle-HorizontalAlign="Center">
                                                       <ItemStyle CssClass="column" HorizontalAlign="Center" Width="8%" Wrap="false" />
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" alt="<%$Resources:Resource, Delete%>"
                                                                runat="server" CommandName="delete_child" OnClientClick="javascript:return deleteLocation();"   />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="file_type" Visible="false" HeaderText="<%$Resources:Resource, Uploaded_File_Name%>"
                                                        AllowFiltering="true" SortExpression="file_type" UniqueName="file_type">
                                                        <ItemStyle  CssClass="itemstyle" Wrap="false" />
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                            </telerik:GridTableView>
                                        </DetailTables>
                                        <Columns>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="<%$Resources:Resource, Select%>"
                                                UniqueName="TemplateColumn">
                                                <ItemStyle Width="2%" />
                                                <ItemTemplate>
                                                    <input id='<%# Eval("pk_uploaded_file_id") %>' name="rdselect" type="radio" value='<%# Eval("pk_uploaded_file_id") %>,<%# Eval("pk_facility_id") %>' />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="pk_uploaded_file_id" HeaderText="pk_uploaded_file_id"
                                                Display="False" SortExpression="pk_uploaded_file_id" UniqueName="pk_uploaded_file_id">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="pk_facility_id" HeaderText="pk_facility_id" Display="False"
                                                SortExpression="pk_facility_id" UniqueName="pk_facility_id">
                                            </telerik:GridBoundColumn>
                                            <%-- <telerik:GridBoundColumn DataField="sysfilename" AllowFiltering="true" HeaderText="System File Name"
                                SortExpression="sysfilename" UniqueName="sysfilename">
                                <ItemStyle CssClass="itemstyle" HorizontalAlign="Left" Width="15%" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </telerik:GridBoundColumn>--%>
                                            <telerik:GridBoundColumn DataField="file_name" HeaderText="<%$Resources:Resource, Uploaded_File_Name%>"
                                                AllowFiltering="true" SortExpression="file_name" UniqueName="file_name">
                                                <ItemStyle Width="25%" CssClass="itemstyle" Wrap="false" HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="filesize" FilterListOptions="VaryByDataTypeAllowCustom"
                                                HeaderText="<%$Resources:Resource, File_Size%>" AllowFiltering="true" SortExpression="filesize"
                                                UniqueName="filesize">
                                                <ItemStyle CssClass="itemstyle" HorizontalAlign="Left" Wrap="false" Width="12%" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Uploaded_By" HeaderText="<%$Resources:Resource, Uploaded_By%>"
                                                AllowFiltering="true" SortExpression="Uploaded_By" UniqueName="Uploaded_By">
                                                <ItemStyle CssClass="itemstyle" HorizontalAlign="Left" Wrap="false" Width="20%" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="uploadedon" FilterListOptions="VaryByDataTypeAllowCustom"
                                                HeaderText="<%$Resources:Resource, Uploaded_On%>" AllowFiltering="true" SortExpression="uploadedon"
                                                UniqueName="uploadedon">
                                                <ItemStyle CssClass="itemstyle" HorizontalAlign="Left" Wrap="false" Width="15%" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn> 
                                            <telerik:GridBoundColumn DataField="fk_master_file_id" HeaderText="fk_master_file_id"
                                                Display="False" SortExpression="fk_master_file_id" UniqueName="fk_master_file_id">
                                            </telerik:GridBoundColumn>
                                            <%-- <telerik:GridTemplateColumn AllowFiltering="false" Visible="false" UniqueName="GoogleEarth">
                                <ItemStyle Width="20px" />
                                <ItemTemplate>
                                    <asp:Button ID="btnGoogleEarth" runat="server" CausesValidation="false" Text="Map" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>--%>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="<%$Resources:Resource, View%>"
                                                UniqueName="bim">
                                                <ItemStyle Width="8%" HorizontalAlign="Center" Wrap="false" />
                                                  <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_bim" runat="server" ImageUrl="~/App/Images/icon_BIMview_sm.png"
                                                        AlternateText="<%$Resources:Resource, View%>"  />
                                                    <%-- <asp:Button ID="btn_bim" Skin="Default"  runat="server" CausesValidation="false" Text="<%$Resources:Resource, BIM%>" />--%>
                                                    <%-- <telerik:RadButton Skin="Default" ID="btn_bim"  runat="server" Text="<%$Resources:Resource, BIM%>" ></telerik:RadButton>--%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="Show_Log" HeaderText="Show Log Change" ItemStyle-HorizontalAlign="Center" Visible="false">
                                                <ItemStyle CssClass="column" HorizontalAlign="Center" Wrap="false" Width="5%" />
                                                 <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imgbtnshowlog" ImageUrl="~/App/Images/log_file_icon1.png" AlternateText="<%Resources:Resource, Show_change_log %>"
                                                        runat="server" CommandName="ShowLog"   />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="History" HeaderText="History" ItemStyle-HorizontalAlign="Center">
                                                <ItemStyle CssClass="column" HorizontalAlign="Center" Wrap="false" Width="8%" />
                                                 <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imgbtnhistory" ImageUrl="~/App/Images/history-2.png" AlternateText="<%Resources:Resource,History %>"
                                                        runat="server" CommandName="history"  />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="download" HeaderText="Download" ItemStyle-HorizontalAlign="Center">
                                                <ItemStyle CssClass="column" HorizontalAlign="Center" Wrap="false" width="8%" />
                                                 <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imgbtnsave" ImageUrl="~/App/Images/save.png" AlternateText="<%Resources:Resource,Download %>"
                                                        runat="server"    onclick="btn_download_Click" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="remove" HeaderText="<%$Resources:Resource, Delete%>"
                                                ItemStyle-HorizontalAlign="Center">
                                                <ItemStyle CssClass="column" HorizontalAlign="Center" Width="8%" Wrap="false" />
                                                 <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" alt="<%$Resources:Resource, Delete%>"
                                                        runat="server" CommandName="delete" OnClientClick="javascript:return deleteLocation();" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="file_type" Visible="false" HeaderText="<%$Resources:Resource, Uploaded_File_Name%>"
                                                AllowFiltering="true" SortExpression="file_type" UniqueName="file_type">
                                                <ItemStyle Width="30%" CssClass="itemstyle" Wrap="false" />
                                            </telerik:GridBoundColumn>
                                            <%--<telerik:GridTemplateColumn DataField="ProjectAddress" UniqueName="ProjectAddress"
                                Display="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddress" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ProjectAddress")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>--%>
                                        </Columns>
                                    </MasterTableView>
                                    <FilterMenu EnableTheming="True">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </FilterMenu>
                                    <FilterItemStyle VerticalAlign="Top" Wrap="False" />
                                </telerik:RadGrid>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 364px" colspan="2">
                                <asp:Label ID="lblMessage1" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td>
                                <asp:Button ID="btn_refresh" runat="server" OnClick="btn_refresh_Click" />
                            </td>
                        </tr>
                    </table>
                </td>         
            </tr>
            <tr align="left">
                <td align="left">
                    <table style="margin-top: 10px; margin-left: 0px;">
                   <%-- <a onclick="openpopupSelectFacility1()">test cick</a>
                    <asp:Button ID="btn_test" runat="server" Text="Click" OnClientClick="javascript:return openpopupHistory();" /> --%>
                    </table>
                </td>
            </tr>
            <tr align="left">
                <td align="left">
                    <table style="margin-top: 10px; margin-left: 50px;">
                        <tr>
                            <td style="width: 50%; vertical-align: top;">
                                <telerik:RadProgressManager ID="Radprogressmanager1" runat="server" />
                                <telerik:RadProgressArea ID="rpaImportLocation" runat="server" Localization-TotalFiles="1"
                                    Skin="Default" OnClientProgressBarUpdating="onClientProgressBarUpdating" ProgressIndicators="TotalProgressBar, TotalProgress, TotalProgressPercent, RequestSize, FilesCountPercent, SelectedFilesCount, CurrentFileName, TimeElapsed, TimeEstimated, TransferSpeed">
                                </telerik:RadProgressArea>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hf_nwid" runat="server" />
        <asp:HiddenField ID="hf_view_pt" runat="server" />
        <asp:HiddenField ID="hf_sqnc_number" runat="server" />
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:HiddenField ID="HiddenField2" runat="server" />
        <asp:HiddenField ID="hf_navis_selected_version" runat="server" />
        <asp:HiddenField ID="hffilepath" runat="server" />
        <asp:HiddenField ID="hf_parent_id" runat="server" />
        <asp:HiddenField ID="hf_parent_2nd" runat="server" />
        <asp:HiddenField ID="hfselectedId" runat="server" />
        <asp:HiddenField ID="hfselectedname" runat="server" />
        <asp:HiddenField ID="hfselected_fileid" runat="server" />
        <asp:HiddenField ID="fileid" runat="server" />
        <asp:HiddenField ID ="hf_facilityid" runat="server" />
        
        <input type="hidden" id="radGridClickedRowIndex" xml:lang="kro" name="radGridClickedRowIndex"
            runat="server" />
        <div id="navis_view" runat="server">
        </div>
        <%-- <table>
            <tr>
                <td>
                    <telerik:RadComboBox runat="server">
        <Items>
        <telerik:RadComboBoxItem Text="---Select---" />
        <telerik:RadComboBoxItem Text="PA" />
        
        <telerik:RadComboBoxItem Text="GU" />
        <telerik:RadComboBoxItem Text="LU" />
        </Items>
        </telerik:RadComboBox>
                </td>
            </tr>
        </table> --%>
        <asp:HiddenField ID="hfifcxmlpath" runat="server" />
        <asp:HiddenField ID="hfzipfilepath" runat="server" />
        <asp:HiddenField ID="hfselectedfile" runat="server" />
        <asp:HiddenField ID="hffacilityID" runat="server" />
        <telerik:RadWindowManager ID="rad_windowmgr" runat="server" Skin="Default" VisibleStatusbar="false">
            <Windows>
                <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="None" KeepInScreenBounds="true"
                    ReloadOnShow="false" VisibleTitlebar="false" AutoSize="false" BorderStyle="None"  Width="600" Height="450"
                    OffsetElementID="rguploadedfiles" VisibleStatusbar="false" VisibleOnPageLoad="false"
                    Skin="Default" Behaviors="Move,Resize">
                </telerik:RadWindow>
            </Windows>
            
           
            
           
        </telerik:RadWindowManager>


        <telerik:RadWindowManager ID="rad_windowmgr1" runat="server" Skin="Default" VisibleStatusbar="false">
         <windows>
            
            <telerik:RadWindow ID="radWindowHistory" runat="server" Animation="None" KeepInScreenBounds="true" 
            ReloadOnShow="false" VisibleTitlebar="false" AutoSize="false" Width="800" Height="450"
                  VisibleStatusbar="false"  VisibleOnPageLoad="false"
                    Skin="Default" Behaviors="Move,Close">                 
                     </telerik:RadWindow>
                     
            </windows>

        </telerik:RadWindowManager>
    

    </div>
    <telerik:RadAjaxManagerProxy ID="radBIMServer" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btn_refresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbmasterfiles" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="rguploadedfiles"  LoadingPanelID="RadAjaxLoadingPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px" />
       <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel2" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <%--</body>--%>
    <%-- </html>--%>
</asp:Content>
