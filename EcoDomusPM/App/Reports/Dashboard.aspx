<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true"
    CodeFile="Dashboard.aspx.cs" Inherits="App_Reports_Dashboard" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <%--  <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"> </script>--%>
    <script src="../../App_Themes/EcoDomus/Googlemaps.js" type="text/javascript"></script> 
    <script language="javascript" type="text/javascript"> 


        //----------- Global variables ----------------
        var regionMarkers = new Array();
        var childMarkers = new Array();

        var arrChildIds = new Array();
        var arrChildNames = new Array();
        var arrChildLatitudes = new Array();
        var arrChildLongitudes = new Array();
        var arrAddresses = new Array();
        var arrFlags = new Array();

        var map;

        // To show the balloon information 

        var infowindow = new google.maps.InfoWindow(
                                                      {
                                                          size: new google.maps.Size(555, 555)
                                                      }
                                                    );
        document.body.onload = function () {
            initialize();
        }
        // To show google map on the page

        function initialize() {

            if (map == null) {
                var latlng = new google.maps.LatLng(20.0, -10.0);
                var myOptions =
                            {
                                zoom: 1,
                                center: latlng,
                                navigationControl: true,
                                mapTypeId: google.maps.MapTypeId.ROADMAP
                            };

                map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

                // To close the balloon pop up on clicking map

                google.maps.event.addListener(map, 'click', function (event) {
                    if (infowindow != null) {
                        infowindow.close();
                    }
                }
                                                      );

                // To close the balloon pop up on mouseover on  map

                google.maps.event.addListener(map, 'mouseover', function (event) {

                    if (infowindow != null) {
                        infowindow.close();
                    }
                }
           );
            }
        }
        function deleteAllPreviousChildPlacemarks() {

            if (childMarkers) {
                for (i in childMarkers) {
                    childMarkers[i].setMap(null);
                }
            }


        }

        // To set placemark on clicking tree node

        function setPlacemarksForRegion(ID, latitude, longitude, strRegionName, strFacilityflag, strAddress, strimage, strColor) {

            document.getElementById('ContentPlaceHolder1_latitude').value = latitude
            document.getElementById('ContentPlaceHolder1_longitude').value = longitude
            document.getElementById('ContentPlaceHolder1_strRegionName').value = strRegionName
            document.getElementById('ContentPlaceHolder1_strFacilityflag').value = strFacilityflag
            document.getElementById('ContentPlaceHolder1_strAddress').value = strAddress
            document.getElementById('ContentPlaceHolder1_strimage').value = strimage
            document.getElementById('ContentPlaceHolder1_strColor').value = strColor
            document.getElementById('ContentPlaceHolder1_hdnfaciliy_id').value = ID
            if (document.getElementById('ContentPlaceHolder1_hdninitialize').value == "initialize") {
                initialize();
                document.getElementById('ContentPlaceHolder1_hdninitialize').value = "";

            }



            if (document.getElementById('ContentPlaceHolder1_hdnfromserverside').value != "FromServerSide") {


                document.getElementById("ContentPlaceHolder1_Button1").click();

            }
            else {
                deleteAllPreviousChildPlacemarks();
                var point = new google.maps.LatLng(latitude, longitude);
                var marker = createMarkerForRegion(ID, point, strRegionName, strFacilityflag, strAddress, strColor, strimage)
                regionMarkers.push(marker);

                document.getElementById('ContentPlaceHolder1_hdnfromserverside').value = "";
            }

        }

        // To set placemark on clicking tree node
        function createMarkerForRegion(ID, latlng, strRegionName, strFacilityflag, strAddress, strColor, strImage) {


            document.getElementById('ContentPlaceHolder1_hf_ID').value = "";



            var marker = new google.maps.Marker(
                                                    {
                                                        title: strRegionName,
                                                        position: latlng,
                                                        strID: "" + ID,
                                                        map: map,
                                                        zIndex: Math.round(latlng.lat() * -100000) << 5
                                                    }
                                                );



            if (strFacilityflag == 'Y') {

                var strContentInfoWindow = '<span id="firstHeading" style="color:' + strColor + ';">' + strRegionName + '</br><input type="Button" value="BIM" onclick="doButtonPostBack()"/></span>';
                map.setMapTypeId(google.maps.MapTypeId.SATELLITE);
                map.setZoom(18);

            }
            else {
                var strContentInfoWindow = '<span id="firstHeading" style="color:' + strColor + ';">' + strRegionName + '</span>';
                map.setMapTypeId(google.maps.MapTypeId.ROADMAP);
                map.setZoom(5);
            }

            iconFile = '..\\Images\\Icons\\' + strImage + '.png'
            marker.setIcon(iconFile);

            var infoSize = new google.maps.Size(50, 40);

            // Show information of balloon on its pop up

            google.maps.event.addListener(marker, 'mouseover', function () {

                infowindow.setContent(strContentInfoWindow);
                infowindow.setSize(infoSize);
                infowindow.open(map, marker);
            }
                                            );
            map.setCenter(latlng);

            // Place child markers on clicking a balloon

            if (strFacilityflag != 'Y') {
                google.maps.event.addListener(marker, 'click', function () {
                    document.getElementById('ContentPlaceHolder1_hf_ID').value = this.strID;
                    document.getElementById('ContentPlaceHolder1_hf_btn_navigation').click();
                }
            );
            }

            return marker;
        }



        //To Naviagte to Model Viewer Page
        function doButtonPostBack() {
            document.getElementById('ContentPlaceHolder1_btnnavigate').click();
        }


        // To delete previous placemarks

        function deleteUnrelatedRegionMarkers() {


            if (regionMarkers) {
                for (i in regionMarkers) {
                    regionMarkers[i].setMap(null);
                }
                regionMarkers.length = 0;
            }
        }

        // To set placemarks for child markers

        function setPlacemarksForChilds(strIds, strNames, strLatitudes, strLongitudes, strAddresses, strFlags) {
            arrChildIds = strIds.split("*");
            arrChildNames = strNames.split("*");
            arrChildLatitudes = strLatitudes.split("*");
            arrChildLongitudes = strLongitudes.split("*");
            arrAddresses = strAddresses.split("*");
            arrFlags = strFlags.split("*");

            var i = 0;

            for (i = 0; i < arrChildIds.length; i++) {
                var point = new google.maps.LatLng(arrChildLatitudes[i], arrChildLongitudes[i]);
                var marker = createMarkerForChilds(arrChildIds[i], point, arrChildNames[i], arrFlags[i], arrAddresses[i]);
                childMarkers.push(marker);
            }
        }

        // To create marker for child placemarks

        function createMarkerForChilds(ID, latlng, strRegionName, strFacilityflag, strAddress) {
            var reg = new RegExp('#', 'g');
            strAddress = strAddress.replace(reg, ',');

            var marker = new google.maps.Marker(
                                                    {
                                                        title: strRegionName,
                                                        position: latlng,
                                                        strID: "" + ID,
                                                        map: map,
                                                        zIndex: Math.round(latlng.lat() * -100000) << 5
                                                    }
                                                );


            if (strFacilityflag == 'Y') {
                var strContentInfoWindow = '<span id="firstHeading" style="color:green;">' + strRegionName + ', ' + strAddress + '</span>';
                iconFile = 'http://maps.google.com/mapfiles/kml/pal3/icon21.png';
                google.maps.event.addListener(marker, 'mouseover', function () {

                    infowindow.setContent(strContentInfoWindow);
                    infowindow.setSize(infoSize);
                    infowindow.open(map, marker);
                }
                                            );
                map.setCenter(latlng);

                google.maps.event.addListener(marker, 'click', function () {
                    document.getElementById('ContentPlaceHolder1_hf_ID').value = this.strID;
                    SetFacilityView(marker);
                }
            );

            }
            else {
                var strContentInfoWindow = '<span id="firstHeading" style="color:red;">' + strRegionName + '</span>';
                iconFile = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
                google.maps.event.addListener(marker, 'mouseover', function () {

                    infowindow.setContent(strContentInfoWindow);
                    infowindow.setSize(infoSize);
                    infowindow.open(map, marker);
                }
                                            );
                map.setCenter(latlng);

                if (strFacilityflag == 'Y') {
                    google.maps.event.addListener(marker, 'click', function () {
                        deleteUnrelatedMarkers('N', marker.strID);
                        document.getElementById('ContentPlaceHolder1_hf_ID').value = this.strID;
                        document.getElementById('ContentPlaceHolder1_hf_btn_navigation').click();
                    }
            );
                }

            }

            marker.setIcon(iconFile);
            var infoSize = new google.maps.Size(100, 20);
            return marker;
        }
        // Set zoom level & sattelite view for facility marker

        function SetFacilityView(marker) {
            map.setCenter(marker.position);
            map.setMapTypeId(google.maps.MapTypeId.SATELLITE);
            map.setZoom(18);
        }

        // Delete previous markers so as to show only current clicked marker & its child markers

        function deleteUnrelatedMarkers(strFlag, strID) {
            if (strFlag == 'N') {
                if (childMarkers) {
                    for (i in childMarkers) {
                        if (childMarkers[i].strID != strID) {
                            childMarkers[i].setMap(null);
                        }
                    }
                }
                if (regionMarkers) {
                    for (i in regionMarkers)
                        if (regionMarkers[i].strID != strID) {
                            regionMarkers[i].setMap(null);
                        }

                }
            }
        }

        function navigate(pk_uploaded_file_id) {
            if (pk_uploaded_file_id != "")
                location.href = "../Settings/ModelViewer.aspx?fileid=" + pk_uploaded_file_id + "";
            else
                alert("There is no file uploaded for this facility");
        }
    </script>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <telerik:RadDockLayout ID="RadDockLayout1" runat="server">
        <table border="0-" id="main_table" style="width: 100%">
            <tr>
                <td id="td_left" style="vertical-align: top; width: 60%;" valign="top">
                    <telerik:RadDockZone ID="rdz_navigate" runat="server" FitDocks="true">
                        <telerik:RadDock ID="rd_navigation" Skin="Forest" runat="server" Resizable="true"
                            Title="<%$Resources:Resource,Navigation%>">
                            <ContentTemplate>
                                <telerik:RadCodeBlock runat="server" ID="blck">
                                    <script type="text/javascript" language="javascript">
                                        function Dock_load() {

                                            var tbl_height = parseInt(window.screen.height) - 300;
                                            var height_Navigation = parseInt(tbl_height) * 2 / 3;

                                            height_Navigation = height_Navigation + 60;

                                            var rd_navigation_dock = $find("<%=rd_navigation.ClientID %>");
                                            var rdo_search_dock = $find("<%=rdo_search.ClientID %>");
                                            var rdo_recent_dock = $find("<%=rdo_recent.ClientID %>");
                                            var RadSplitter1_dock = $find("<%=RadSplitter1.ClientID %>");
                                            var rdoInbox_dock = $find("<%=rdoInbox.ClientID %>");
                                            var treeDiv = document.getElementById("ctl00_ContentPlaceHolder1_rd_navigation_C_NavigationTree");

                                            document.getElementById('main_table').style.height = parseInt(tbl_height)

                                            RadSplitter1_dock.set_height(5);

                                            rd_navigation_dock.set_height(parseInt(height_Navigation));

                                            rdo_search_dock.set_height((parseInt(height_Navigation) * 1.15 / 3));
                                            rdo_recent_dock.set_height((parseInt(height_Navigation) *3.42 / 3));

                                            rdoInbox_dock.set_height(parseInt(tbl_height) - (parseInt(height_Navigation)) + 70);
                                            document.getElementById('gis_table').style.height = parseInt(height_Navigation) - 45;
                                            document.getElementById('map_canvas').style.height = parseInt(height_Navigation) - 45;
                                            treeDiv.style.height = parseInt(height_Navigation) - 45;

                                        }
                                    </script>
                                </telerik:RadCodeBlock>
                                <table id="gis_table" style="width: 99%; height: 90%" border="0">
                                    <tr>
                                        <td style="width: 23%" valign="top">
                                            <telerik:RadTreeView Width="100%" Skin="Vista" ID="NavigationTree" runat="server">
                                            </telerik:RadTreeView>
                                        </td>
                                        <td id="_div" style="width: 70%;" valign="top" align="right">
                                            <div id="map_canvas" style="height: 200px">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                </td>
                <td id="td_right" style="vertical-align: top; width: 40%; height:120%;" rowspan="5">
                    <telerik:RadDockZone ID="rdz_search" runat="server" FitDocks="true" Height="100%">
                        <telerik:RadDock ID="rdo_search" Skin="Forest" runat="server" Height="30%" Resizable="false" Visible="true"
                            Title="<%$Resources:Resource,Search%>">
                            <ContentTemplate>
                                <table style="width: 95%;">
                                    <tr>
                                        <td style="height: 3px" colspan="4">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span>
                                                <asp:Label ID="LblAsset" runat="server" Text="<%$Resources:Resource,Asset%>">:</asp:Label>
                                            </span>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox Skin="Vista" ID="cmb_assets" Width="130px" runat="server">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox Skin="Vista" ID="cmb_search_condition_asset" Width="90px" runat="server">
                                                <Items>
                                                    <telerik:RadComboBoxItem Value="equal to" Text="Equal to" Selected="True" runat="server"
                                                        Font-Size="11px" />
                                                    <telerik:RadComboBoxItem Value="contains" Text="Contains" runat="server" Font-Size="11px" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox Skin="Vista" ID="txt_result_asset" Width="130px" runat="server">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 3px" colspan="4">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span>
                                                <asp:Label ID="LblSpace" runat="server" Text="<%$Resources:Resource,Space%>">:</asp:Label>
                                            </span>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox Skin="Vista" ID="cmb_spaces" Width="130px" runat="server">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox Skin="Vista" ID="cmb_search_condition_spaces" Width="90px" runat="server">
                                                <Items>
                                                    <telerik:RadComboBoxItem Value="equal to" Text="Equal to" Selected="True" runat="server"
                                                        Font-Size="11px" />
                                                    <telerik:RadComboBoxItem Value="contains" Text="Contains" runat="server" Font-Size="11px" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox Skin="Vista" ID="txt_result_spaces" Width="130px" runat="server">
                                            </telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 3px" colspan="4">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td colspan="4">
                                            <asp:Button ID="btn_search" runat="server" OnClick="btn_search_Click" Text="<%$Resources:Resource,Search%>"
                                                Width="100px" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </telerik:RadDock>
                        <telerik:RadDock ID="rdo_recent" Skin="Forest" runat="server" Title="<%$Resources:Resource,Recent%>"
                            Resizable="false" Visible="true" Height="100%">
                            <ContentTemplate>
                                <telerik:RadGrid Skin="Vista" ID="rgFacility" runat="server" AutoGenerateColumns="false"
                                    AllowSorting="false" OnItemCommand="rgFacility_ItemCommand" Width="95%">
                                    <MasterTableView DataKeyNames="facility_id">
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="facility_id" HeaderText="facility_id" Visible="False">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridButtonColumn DataTextField="name" ItemStyle-Width="100px" HeaderText="<%$Resources:Resource,Facility%>"
                                                ButtonType="LinkButton" SortExpression="name" CommandName="editFacility">
                                            </telerik:GridButtonColumn>
                                            <telerik:GridBoundColumn DataField="description" ItemStyle-Width="100px" HeaderText="<%$Resources:Resource,Description%>"
                                                UniqueName="name">
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                                <br />
                                <telerik:RadGrid Skin="Vista" ID="rg_assets" runat="server" AutoGenerateColumns="false"
                                    AllowSorting="false" OnItemCommand="rg_assets_ItemCommand" Width="95%">
                                    <MasterTableView CommandItemDisplay="None" DataKeyNames="asset_id,facility_name,facility_id">
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="asset_id" HeaderText="asset_id" UniqueName="asset_id"
                                                Visible="False">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridButtonColumn DataTextField="name" ItemStyle-Width="100px" HeaderText="<%$Resources:Resource,Assets%>"
                                                ButtonType="LinkButton" SortExpression="name" CommandName="editAssets">
                                            </telerik:GridButtonColumn>
                                            <telerik:GridBoundColumn DataField="description" ItemStyle-Width="100px" HeaderText="<%$Resources:Resource,Description%>"
                                                UniqueName="name">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridButtonColumn CommandName="Editfacility" ItemStyle-Width="100px" DataTextField="facility_name"
                                                HeaderText="<%$Resources:Resource,Facility%>" ButtonType="LinkButton">
                                            </telerik:GridButtonColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                                <br />
                                <telerik:RadGrid Skin="Vista" ID="rg_spaces" runat="server" AutoGenerateColumns="false"
                                    AllowSorting="false" OnItemCommand="rg_spaces_ItemCommand" Width="95%">
                                    <MasterTableView DataKeyNames="pk_location_id,facility_id">
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="pk_location_id" HeaderText="space_id" UniqueName="space_id"
                                                Visible="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridButtonColumn DataTextField="space_name" HeaderText="<%$Resources:Resource,Space%>"
                                                ButtonType="LinkButton" ItemStyle-Width="100px" SortExpression="space_name" CommandName="editSpaces">
                                            </telerik:GridButtonColumn>
                                            <telerik:GridBoundColumn DataField="description" ItemStyle-Width="100px" HeaderText="<%$Resources:Resource,Description%>"
                                                UniqueName="name">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridButtonColumn CommandName="Editfacility" DataTextField="facility" HeaderText="<%$Resources:Resource,Facility%>"
                                                ButtonType="LinkButton">
                                            </telerik:GridButtonColumn>
                                            <telerik:GridBoundColumn DataField="facility_id" HeaderText="facility_id" UniqueName="facility_id"
                                                Visible="false">
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                </td>
            </tr>
            <tr>
                <td colspan="1" style="vertical-align: top;">
                    <telerik:RadDockZone Width="99%" ID="rdz_inbox" runat="server" FitDocks="true">
                        <telerik:RadDock ID="rdoInbox" Skin="Forest" runat="server" Title="<%$Resources:Resource,Inbox%>"
                            Resizable="false" Visible="true">
                            <ContentTemplate>
                                <telerik:RadGrid Skin="Vista" ID="rgInbox" AllowPaging="true" runat="server" AutoGenerateColumns="false"
                                    Width="98%" PageSize="3" OnPageIndexChanged="rgInbox_OnPageIndexChanged" OnPageSizeChanged="rgInbox_OnPageSizeChanged"
                                    OnSortCommand="rgInbox_OnSortCommand">
                                    <MasterTableView CommandItemDisplay="None">
                                        <PagerStyle AlwaysVisible="true" />
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="object" HeaderText="<%$Resources:Resource,Object%>"
                                                UniqueName="Object">
                                                <ItemStyle Width="100px" />
                                                <HeaderStyle Width="100px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="attribute" HeaderText="<%$Resources:Resource,Action%>"
                                                UniqueName="Action">
                                                <ItemStyle Width="100px" />
                                                <HeaderStyle Width="100px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="changed_by" HeaderText="<%$Resources:Resource,Changed_By%>"
                                                UniqueName="Changed By">
                                                <ItemStyle Width="100px" />
                                                <HeaderStyle Width="100px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="changed_date" HeaderText="<%$Resources:Resource,Date%>"
                                                UniqueName="Date">
                                                <ItemStyle Width="100px" />
                                                <HeaderStyle Width="100px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="system" HeaderText="<%$Resources:Resource,System%>"
                                                UniqueName="System">
                                                <ItemStyle Width="100px" />
                                                <HeaderStyle Width="100px" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </telerik:RadDock>
                    </telerik:RadDockZone>
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Size="Small"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 5px;">
                    <telerik:RadSplitter ID="RadSplitter1" runat="server" Orientation="Vertical" BorderSize="0"
                        VisibleDuringInit="false" OnClientLoad="Dock_load" Width="0%" Height="0%">
                    </telerik:RadSplitter>
                    <asp:HiddenField ID="hf_ID" runat="server" />
                </td>
            </tr>
        </table>
    </telerik:RadDockLayout>
    <div style="display: none">
        <asp:Button runat="server" Height="1px" Width="1px" ID="hf_btn_navigation" OnClick="hf_btn_navigation_Click"
            Style="display: none; background-color: transparent; border-color: transparent" />
    </div>
    <div style="display: none;">
        <asp:HiddenField ID="hdnfaciliy_id" runat="server" />
        <asp:Button ID="btnnavigate" runat="server" OnClick="btnnavigate_click" />
        
        <asp:HiddenField ID="latitude" runat="server" />
        <asp:HiddenField ID="longitude" runat="server" />
        <asp:HiddenField ID="strRegionName" runat="server" />
        <asp:HiddenField ID="strFacilityflag" runat="server" />
        
        <asp:HiddenField ID="strAddress" runat="server" />
        <asp:HiddenField ID="strimage" runat="server" />
        <asp:HiddenField ID="strColor" runat="server" />
        <asp:HiddenField ID="hdnfromserverside" runat="server" />
        <asp:HiddenField ID="hdninitialize" runat="server" />
    </div>
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" />
    <telerik:RadAjaxManager ID="ramr" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="map_canvas">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="hf_btn_navigation" />
                    <telerik:AjaxUpdatedControl ControlID="hf_ID" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="hf_btn_navigation">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="map_canvas" />
                    <telerik:AjaxUpdatedControl ControlID="hf_ID" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
</asp:Content>
