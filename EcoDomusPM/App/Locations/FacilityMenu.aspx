
<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomus_PM_New.master"  AutoEventWireup="true"
    CodeFile="FacilityMenu.aspx.cs" Inherits="App_Locations_FacilityMenu" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">

        function SectionNameMaker(name) {
            document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span><a>COBie</a></span>" + "&nbsp;" +
                                            "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='FacilityPM.aspx'>Facility</a></span></font>" + "&nbsp;" +
                                            "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>" + name + "</span><a id='SiteMapPath1_SkipLink'></a></span>";
        };
        
        function sitemap() {
                
            var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
            if (IsFromClient == "N") {
                SectionNameMaker('Component Profile');
                
            }
            else {
                SectionNameMaker('Profile');
                                            
               
            }


        }

        function pageload(flag, id, profileflag, id1) {
            var link;
            var IsFromFacility;
            IsFromFacility = document.getElementById("ctl00$ContentPlaceHolder1$hfIsFromFacility").value;
            var IsFromFloor;
            IsFromFloor = document.getElementById("ContentPlaceHolder1_hfIsFromFloor").value;
            var IsFromZone;
            IsFromZone = document.getElementById("ContentPlaceHolder1_hfIsFromZone").value;
            var IsFromSpace;
            IsFromSpace = document.getElementById("ContentPlaceHolder1_hfIsFromSpace").value;

            if (flag == 'Profile' && profileflag == 'old') {


                pageToLoad = "FacilityProfile.aspx?FacilityId=" + document.getElementById('ContentPlaceHolder1_hf_Facility_id').value;
                sitemap();
            }

            else if (flag == 'Profile' && profileflag == 'new') {


                pageToLoad = "FacilityProfileNew.aspx?FacilityId=" + document.getElementById('ContentPlaceHolder1_hf_Facility_id').value;
                sitemap();
            }

            else if (flag == 'Profile') {


                pageToLoad = "FacilityProfileNew.aspx?FacilityId=" + document.getElementById('ContentPlaceHolder1_hf_Facility_id').value;
                sitemap();
            }
            else if (flag == 'Floors') {


                pageToLoad = "Floors.aspx";

                if (IsFromFacility == "Y") {
                    SectionNameMaker('Floors');
                }
                else {
                    SectionNameMaker('Floors');
                }
            }

            else if (flag == 'Spaces') {
                if (IsFromFacility == "Y") {
                    pageToLoad = "Spaces.aspx?Id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&name=Facility";
                    SectionNameMaker('Spaces');
                }
                else if (IsFromFloor == "Y") {
                    pageToLoad = "Spaces.aspx?Id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&name=Floor";
                    SectionNameMaker('Spaces');
                }
                else if (IsFromZone == "Y") {
                    pageToLoad = "Spaces.aspx?Id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&name=" + document.getElementById('ContentPlaceHolder1_hf_zone_name').value;
                    SectionNameMaker('Spaces');
                }

                else {
                    pageToLoad = "Spaces.aspx?Id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&name=" + document.getElementById('ContentPlaceHolder1_hf_zone_name').value;
                    SectionNameMaker('Spaces');
                }

            }

            else if (flag == 'Zones') {


                pageToLoad = "Zones.aspx";
                if (IsFromFacility == "Y") {
                    SectionNameMaker('Zones');
                }

                else {
                    SectionNameMaker('Zones');
                }
            }

            else if (flag == 'Floor Profile') {
                pageToLoad = "FloorProfileNew.aspx?id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&name=New";
                SectionNameMaker('Floor Profile');
            }

            else if (flag == 'Space Profile' && profileflag == 'old') {

                pageToLoad = "SpaceProfile.aspx?id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&floor_id=" + id1;
                SectionNameMaker('Space Profil');
            }
            else if (flag == 'Space Profile' && profileflag == 'new') {

                pageToLoad = "SpaceProfile_new.aspx?id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value;
                SectionNameMaker('Space Profil');
            }
            else if (flag == 'Space Profile') {

                pageToLoad = "SpaceProfile_new.aspx?id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&name=";
                SectionNameMaker('Space Profile');
            }

            else if (flag == 'Zone Profile') {

                pageToLoad = "ZoneProfileNew.aspx?id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&name=" + document.getElementById('ContentPlaceHolder1_hf_zone_name').value;
                if (IsFromZone == "Y") {
                    SectionNameMaker('Zone Profile');
                }
                else {
                    SectionNameMaker('Zone Profile');
                }
            }

            else if (flag == 'Affect') {
                pageToLoad = "../Asset/AssetsAffect.aspx?asset_id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value;
                SectionNameMaker('Affect');
            }

            else if (flag == 'Room Data Sheet') {

                pageToLoad = "../Asset/SpaceComponent.aspx?id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&name=Space";
                if (IsFromSpace == "Y") {
                    SectionNameMaker('Room Data Sheet');
                }
                else {
                    SectionNameMaker('Room Data Sheet');
                }
            }

            else if (flag == 'Resources') {
                if (document.getElementById("ContentPlaceHolder1_hfAttributeflag").value == "1") {
                    pageToLoad = "../Asset/TypeResources.aspx?entity_id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&entity_name=Facility";
                    if (IsFromFacility == "Y") {
                        SectionNameMaker('Resources');
                    }

                }
            }
            else if (flag == 'Configuration') {
                if (document.getElementById("ContentPlaceHolder1_hfAttributeflag").value == "1") {
                    pageToLoad = "../Settings/FacilityBarcodeConfigurationNew.aspx?Facilityid=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&entity_name=Facility&selectedtab=Asset";

                    if (IsFromFacility == "Y") {
                        SectionNameMaker('Configuration');
                    }

                }
            }
            else if (flag == 'Attributes') {
                if (document.getElementById("ContentPlaceHolder1_hfAttributeflag").value == "1") {
                    pageToLoad = "FacilityAttributes.aspx?entity_id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&entity_name=Facility";
                    if (IsFromFacility == "Y") {
                        SectionNameMaker('Attributes');
                    }
                    else if (IsFromSpace == "Y") {
                        SectionNameMaker('Attributes');
                    }
                    else {
                        SectionNameMaker('Attributes');
                    }
                }
                else if (document.getElementById("ContentPlaceHolder1_hfAttributeflag").value == "0") {

                    if (document.getElementById("ContentPlaceHolder1_hfMissisingAttributeSpace").value != "") {
                        pageToLoad = "../Asset/TypeAttribute.aspx?entity_id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&entity_name=Space&attribute_name=" + document.getElementById("ContentPlaceHolder1_hfMissisingAttributeSpace").value;
                    }
                    else {
                        pageToLoad = "../Asset/TypeAttribute.aspx?entity_id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value + "&entity_name=zone";
                    }
                    if (IsFromSpace == "Y") {
                        SectionNameMaker('Attributes');
                    }
                    else if (IsFromZone == "Y") {
                        SectionNameMaker('Attributes');
                    }
                    else {
                        SectionNameMaker('Attributes');
                    }
                }
            }
            /////////////////////////////////////////////////////



            ///////////////////////////////////////////////////
            else if (flag == 'Documents') {
                //hfAttributeflag = 1 for Facility Documents
                // 0 for space Documents
                // 2 for floor Documents
                // 3 for zone Documents

                if (document.getElementById("ContentPlaceHolder1_hfAttributeflag").value == "1") {
                    pageToLoad = "../Asset/Assign_Document.aspx?name=Facility&id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value;
                    if (IsFromFacility == "Y") {
                        SectionNameMaker('Documents');
                    }
                    else if (IsFromFloor == "Y") {
                        SectionNameMaker('Documents');
                    }

                    else if (IsFromZone == "Y") {
                        SectionNameMaker('Documents');
                    }
                    else if (IsFromSpace == "Y") {//xxxx
                        SectionNameMaker('Documents');
                    }
                    else {
                        SectionNameMaker('Documents');
                    }
                }
                else if (document.getElementById("ContentPlaceHolder1_hfAttributeflag").value == "0") {
                    pageToLoad = "../Asset/Assign_Document.aspx?name=Space&id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value;
                    if (IsFromFloor == "Y") {
                        SectionNameMaker('Documents');
                    }
                    else if (IsFromZone == "Y") {
                        SectionNameMaker('Documents');
                    }
                    else if (IsFromSpace == "Y") {
                        SectionNameMaker('Documents');
                    }
                    else {
                        SectionNameMaker('Documents');
                    }
                }
                else if (document.getElementById("ContentPlaceHolder1_hfAttributeflag").value == "2") {
                    pageToLoad = "../Asset/Assign_Document.aspx?name=Floor&id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value;
                    if (IsFromFloor == "Y") {
                        SectionNameMaker('Documents');
                    }
                    else if (IsFromZone == "Y") {
                        SectionNameMaker('Documents');
                    }
                    else if (IsFromSpace == "Y") {
                        SectionNameMaker('Documents');
                    }
                    else {
                        SectionNameMaker('Documents');
                    }
                }
                else if (document.getElementById("ContentPlaceHolder1_hfAttributeflag").value == "3") {
                    pageToLoad = "../Asset/Assign_Document.aspx?name=Zone&id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value;
                    if (IsFromFloor == "Y") {
                        SectionNameMaker('Documents');
                    }
                    else if (IsFromZone == "Y") {
                        SectionNameMaker('Documents');
                    }
                    else if (IsFromSpace == "Y") {
                        SectionNameMaker('Documents');
                    }
                    else {
                        SectionNameMaker('Documents');
                    }
                }


            }
            else if (flag == 'View in BIM') {
                if (document.getElementById("ContentPlaceHolder1_hf_file_ext").value == 'nwd') {
                    pageToLoad = "../Settings/ModelViewer.aspx?View_flag=Space&FileId=" + document.getElementById("ContentPlaceHolder1_hf_uploaded_File_id").value + "&element_numeric_id=" + document.getElementById("ContentPlaceHolder1_hf_element_numeric_id").value + "&facility_id=" + document.getElementById("ContentPlaceHolder1_hfFacilityid").value + "&fk_master_file_id=" + document.getElementById("ContentPlaceHolder1_hf_fk_masterfile_id").value;

                }
                else {
                    pageToLoad = "../Settings/EcodomusModelViewer.aspx?View_flag=Space&FileId=" + document.getElementById("ContentPlaceHolder1_hf_uploaded_File_id").value + "&element_numeric_id=" + document.getElementById("ContentPlaceHolder1_hf_element_numeric_id").value + "&facility_id=" + document.getElementById("ContentPlaceHolder1_hfFacilityid").value + "&fk_master_file_id=" + document.getElementById("ContentPlaceHolder1_hf_fk_masterfile_id").value;
                }
                if (IsFromSpace == "Y") {
                    SectionNameMaker('View In BIM');
                }
                else {
                    SectionNameMaker('View In BIM');
                }
            }

            else
            { }

            loadintoIframe('frameSettingsMenu', pageToLoad)
            return false;
        }

        function loadintoIframe(iframeid, url) {//alert("in loading to iframe");

            var iframewindow = document.getElementById(iframeid);

            iframewindow.src = url;
        }

        function CallClickEvent(url) {

            window.location = url;

        }

        //To get Updated Task Id
        function UpdateTaskId(newtaskid) {
            //debugger;

            alert(document.getElementById("ctl00_ContentPlaceHolder1_hf_Facility_id").value);
            document.getElementById("ctl00_ContentPlaceHolder1_hf_Facility_id").value = newtaskid;
        }



        //  On menu item onClicking event.
        function onClicking(sender, eventArgs) {
            var item = eventArgs.get_item();


            pageload(item.get_value());
            eventArgs.set_cancel(true);

        }

        function CallClickEvent(url) {

            window.location = url;
        }
        function onClientTabSelected(sender, args) {
            var newTabValue = args.get_tab().get_value();
            pageload(newTabValue);
            var tabStrip = $find("<%= rtsFacilityProfile.ClientID %>");

            args.set_cancel(false);
            document.getElementById('<%= hfSelectedIndex.ClientID %>').value = newTabValue;
        }

        function resize_iframe(obj) {

            try {
            
                document.getElementById("frameSettingsMenu").hideFocus = true;
                var oBody = frameSettingsMenu.document.body;
                var oFrame = document.all("frameSettingsMenu");
                var string = document.getElementById("frameSettingsMenu").src.toString();


                if (obj != null) {
                    docHeight = frameSettingsMenu.document.body.scrollHeight;
                    if(docHeight <= 600)
                    {
                     document.getElementById("frameSettingsMenu").height = 800;
                    }
                    else
                    {
                        document.getElementById("frameSettingsMenu").height = docHeight + 200;
                    }
                }
                body_load();
             }
          
            catch (e) {
                window.status = 'Error: ' + e.number + '; ' + e.description;
            }
        }

        window.onresize = resize_iframe;

        window.onload = body_load;
        function body_load() {
            var screenhtg = set_NiceScrollToPanel();
           }
    </script>

    <script type="text/javascript">
        function autoIframe(frameId) {
            try {
                frame = document.getElementById(frameId);
                innerDoc = (frame.contentDocument) ? frame.contentDocument : frame.contentWindow.document;
                objToResize = (frame.style) ? frame.style : frame;
                objToResize.height = innerDoc.body.scrollHeight + 10;
            }
            catch (err) {
                window.status = err.message;
            }
        }
</script>
   
  
  
    <table  width="100%">
        <tr>
            <td align="left">
                <table>
                    <caption>
                        <div id="facility" runat="server" visible="false">
                            <asp:Label ID="lblfacility" runat="server" Text="<%$Resources:Resource, Facility_Name%>"></asp:Label>:
                            <asp:Label ID="lblfacilityname" runat="server"></asp:Label></div>
                        <div id="floor" runat="server" visible="false">
                            <asp:Label ID="lblfloor" runat="server" Text="<%$Resources:Resource, Floor_Name%>"></asp:Label>:
                            <asp:Label ID="lblfloorname" runat="server"></asp:Label></div>
                        <div id="zone" runat="server" visible="false">
                            <asp:Label ID="lblzone" runat="server" Text="<%$Resources:Resource, Zone_Name%>"></asp:Label>:
                            <asp:Label ID="lblzonename" runat="server"></asp:Label></div>
                        <div id="space" runat="server" visible="false">
                            <asp:Label ID="lblspace" runat="server" Text="<%$Resources:Resource, Space_Name%>"></asp:Label>:
                            <asp:Label ID="lblspacename" runat="server"></asp:Label></div>
                        <div id="facilityprofile" runat="server" visible="false">
                            <asp:Label ID="lblfacilityprofile" runat="server" Text="<%$Resources:Resource, Facility_Profile%>"></asp:Label></div>
                        <div id="floorProfile" runat="server" visible="false">
                            <asp:Label ID="lblfloorprofile" runat="server" Text="<%$Resources:Resource, Floor_Profile%>"></asp:Label></div>
                        <div id="spaceprofile" runat="server" visible="false">
                            <asp:Label ID="lblspaceprofile" Text="<%$Resources:Resource, Space_Profile%>" runat="server"></asp:Label></div>
                        <div id="zoneprofile" runat="server" visible="false">
                            <asp:Label ID="lblzoneprofile" runat="server" Text="<%$Resources:Resource, Zone_Profile%>"></asp:Label></div>
                    </caption>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left">
                <table id="tblleftmenu" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;
                    margin-top: 0%; vertical-align: top; height: 100%" runat="server" width="100%">
                    <tr>
                        <td style="vertical-align: top; margin-left: 0px;">
                            <telerik:RadTabStrip ID="rtsFacilityProfile" Skin="Default" runat="server" MultiPageID="RadMultiPage1"
                                OnClientTabSelecting="onClientTabSelected" SelectedIndex="0">
                            </telerik:RadTabStrip>
                            <telerik:RadMultiPage ID="rmpFacilityProfile" runat="server" SelectedIndex="0">
                                <telerik:RadPageView ID="rpvFacilityProfile" Width="100%" runat="server">
                                    <iframe id="frameSettingsMenu" name="frameSettingsMenu" frameborder="0" marginwidth="100%"
                                        width="100%" scrolling="no" onload="resize_iframe(this)"></iframe>
                                    <%--onload="resize_iframe(this)"--%>
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
   
    
    
       
    <table>
        <tr>
            <td>
                <asp:HiddenField ID="hf_Facility_id" runat="server" Value="0" />
                <asp:HiddenField ID="hf_location_id" runat="server" Value="0" />
                <asp:HiddenField ID="hf_zone_name" runat="server" />
                <asp:HiddenField ID="hf_location_name" runat="server" />
                <asp:HiddenField ID="HiddenField1" runat="server" />     
                <asp:HiddenField ID="hfAttributeflag" runat="server" />   
                <asp:HiddenField ID="hf_uploaded_File_id" runat="server" Value="0" />
                <asp:HiddenField ID="hf_element_numeric_id" runat="server" Value="0" />        
                <asp:HiddenField ID="hfSelectedIndex" runat="server" Value="0" />
                <asp:HiddenField ID="hfIsFromFacility" runat="server" />
                <asp:HiddenField ID="hfIsFromFloor" runat="server" />
                <asp:HiddenField ID="hfIsFromZone" runat="server" />
                <asp:HiddenField ID="hfIsFromSpace" runat="server" />
                <asp:HiddenField ID="hfMissisingAttributeSpace" runat="server" />
                <asp:HiddenField ID="hfMissisingAttributeFacility" runat="server" />
                  <asp:HiddenField ID="hf_fk_masterfile_id" runat="server" Value="0" />
                 <asp:HiddenField ID="hf_file_ext" runat="server" Value="0" />
                 <asp:HiddenField ID="hfFacilityid" runat="server" Value="0" />
            </td>
        </tr>
        <tr><td> <div style="display:none;"> <asp:Button runat="server" ID = "btnclick" Text="" BackColor="Transparent" 
                    onclick="btnclick_Click"  /></div></td></tr>
                    <tr><td>
                      <telerik:RadAjaxManagerProxy ID="ramAsset" runat="server" >

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnclick">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rtsFacilityProfile" />
                </UpdatedControls>
            </telerik:AjaxSetting>
               
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
     <telerik:RadAjaxLoadingPanel Skin="Forest" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
                    </td></tr>  
    </table>
    

   
</asp:Content>