<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomus_PM_New.master"  AutoEventWireup="true"
    CodeFile="AssetMenu.aspx.cs" Inherits="App_Asset_AssetMenu"  %>

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
                                            "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='ComponentPM.aspx'>Component</a></span></font>" + "&nbsp;" +
                                            "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>" + name+"</span><a id='SiteMapPath1_SkipLink'></a></span>";
         }

        function pageload(flag, id, val) {
       
            if (flag == 'ComponentProfile' || flag == 'Component Profile') {
                pageToLoad = "AssetProfileNew.aspx?assetid=" + document.getElementById("ContentPlaceHolder1_hf_asset_id").value;
                SectionNameMaker('Component Profile');
                window.location.reload(true);


            }
            else if (flag == 'ComponentProfile' || flag == 'Component Profile' && val == 'asset') {
                    pageToLoad = "AssetProfile.aspx?assetid=" + document.getElementById("ContentPlaceHolder1_hf_asset_id").value + "&value=asset";
                    SectionNameMaker('Component Profile');
                }

                else if (flag == 'Issues') { 
                    pageToLoad = "Assetissues.aspx?assetid=" + document.getElementById("ContentPlaceHolder1_hf_asset_id").value;
                    SectionNameMaker('Issues');
                }
                else if (flag == 'Work Orders') {
                    pageToLoad = "Assetissues.aspx?assetid=" + document.getElementById("ContentPlaceHolder1_hf_asset_id").value;
                    SectionNameMaker('Work Orders');
                }
                else if (flag == 'Documents') {
                    pageToLoad = "Assign_Document.aspx?name=Asset&id=" + document.getElementById("ContentPlaceHolder1_hf_asset_id").value;
                    SectionNameMaker('Documents');
                }
                else if (flag == 'Attributes') {
                   pageToLoad = "Attribute.aspx?entity_name=Asset&entity_id=" + document.getElementById("ContentPlaceHolder1_hf_asset_id").value;
                    SectionNameMaker('Attributes');
                }
                else if (flag == 'Systems') {
                    pageToLoad = "AssetSystems.aspx";
                    SectionNameMaker('Systems');
                }

                else if (flag == 'View in BIM') {
                                      
                    if (document.getElementById("ContentPlaceHolder1_hf_file_ext").value == 'nwd') {
                      pageToLoad = "../Settings/ModelViewer.aspx?View_flag=Asset&FileId=" + document.getElementById("ContentPlaceHolder1_hf_uploaded_File_id").value + "&element_numeric_id=" + document.getElementById("ContentPlaceHolder1_hf_element_numeric_id").value + "&facility_id=" + document.getElementById("ContentPlaceHolder1_hfFacilityid").value + "&fk_master_file_id=" + document.getElementById("ContentPlaceHolder1_hf_fk_masterfile_id").value;
                    }
                    else {
                        pageToLoad = "../Settings/ModelViewer.aspx?View_flag=Asset&FileId=" + document.getElementById("ContentPlaceHolder1_hf_uploaded_File_id").value + "&element_numeric_id=" + document.getElementById("ContentPlaceHolder1_hf_element_numeric_id").value + "&facility_id=" + document.getElementById("ContentPlaceHolder1_hfFacilityid").value + "&fk_master_file_id=" + document.getElementById("ContentPlaceHolder1_hf_fk_masterfile_id").value;
                    }
                    SectionNameMaker('View in BIM');
                }

                else if (flag == 'Affect') {
                    pageToLoad = "../Asset/AssetsImpact.aspx";
                    SectionNameMaker('Affect');
                }
                else if (flag == 'Schedules') {
                    pageToLoad = "../Asset/Schedules.aspx";
                    SectionNameMaker('Schedules');
                }
                else if (flag == 'SubAssemblies') {
                    pageToLoad = "../Asset/SubAssembly.aspx?assetid=" + document.getElementById("ContentPlaceHolder1_hf_asset_id").value + "&facility_id=" +document.getElementById("ContentPlaceHolder1_hfFacilityid").value;
                    SectionNameMaker('SubAssembly');
                }

                else {
                }

            loadintoIframe('frameSettingsMenu', pageToLoad)
            return false;
        }

        function loadintoIframe(iframeid, url) {

            var iframewindow = document.getElementById(iframeid);
            iframewindow.src = url;
           
        }


        function CallClickEvent(url) {
            window.location = url;
        }

        //To get Updated Task Id
        function UpdateTaskId(newtaskid) {


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

            var tabStrip = $find("<%= rtsComponentProfile.ClientID %>");

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
                    docWidth = frameSettingsMenu.document.body.scrollWidth;
                    if (docHeight <= 400) {
                        document.getElementById("frameSettingsMenu").height =600;
                    }
                    else {
                        document.getElementById("frameSettingsMenu").height = docHeight+ 200;
                        document.getElementById("frameSettingsMenu").width = docWidth;
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
    <table width="100%">
        <tr>
            <td align="left">
                <table>
                    <caption>
                        <div id="component" runat="server" visible="false">
                            <asp:Label ID="lblcomponent" runat="server" Text="<%$Resources:Resource,Component_Name%>"></asp:Label>:
                            <asp:Label ID="lblcomponentname" runat="server"></asp:Label>
                        </div>
                        <div id="componentProfile" runat="server" visible="false">
                            <asp:Label ID="lblcomponentprofile" Text="<%$Resources:Resource,Component_Profile%>"
                                runat="server"></asp:Label>
                        </div>
                    </caption>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left"  class="tdZebraLightGray">
                <table id="tblleftmenu" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;
                    margin-top: 0%; vertical-align: top;" runat="server" width="100%">
                    <tr>
                        <td class="tdZebraLightGray" style="vertical-align: top; margin: 0px 0px 0px 0px;
                            padding: 0px 0px 0px 0px; text-align: left;">
                            <telerik:RadTabStrip ID="rtsComponentProfile" runat="server" MultiPageID="RadMultiPage1"
                                Visible="true" OnClientTabSelecting="onClientTabSelected" SelectedIndex="0">
                            </telerik:RadTabStrip>
                            <telerik:RadMultiPage ID="rmpComponentProfile" runat="server" SelectedIndex="0">
                                <telerik:RadPageView ID="rpvComponentProfile" Width="100%" runat="server">
                                    <iframe id="frameSettingsMenu" name="frameSettingsMenu" frameborder="0" marginwidth="100%"
                                        onload="resize_iframe(this)" width="100%" scrolling="no"></iframe>
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:HiddenField ID="hf_asset_id" runat="server" Value="0" />
                            <asp:HiddenField ID="hf_location_id" runat="server" Value="0" />
                            <asp:HiddenField ID="hfFacilityid" runat="server" Value="0" />
                            <asp:HiddenField ID="hf_uploaded_File_id" runat="server" Value="0" />
                            <asp:HiddenField ID="hf_element_numeric_id" runat="server" Value="0" />
                            <asp:HiddenField ID="hfSelectedIndex" runat="server" Value="0" />
                            <asp:HiddenField ID="hf_fk_masterfile_id" runat="server" Value="0" />
                            <asp:HiddenField ID="hf_file_ext" runat="server" Value="0" />
                            <asp:HiddenField ID="hfMissingAttribute" runat="server" />
                            <div style="display: none;">
                                <asp:Button runat="server" ID="btnclick" Text="" BackColor="Transparent" OnClick="btnclick_Click" /></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadAjaxManagerProxy ID="ramAsset" runat="server">
                                <AjaxSettings>
                                    <telerik:AjaxSetting AjaxControlID="btnclick">
                                        <UpdatedControls>
                                            <telerik:AjaxUpdatedControl ControlID="rtsComponentProfile" />
                                        </UpdatedControls>
                                    </telerik:AjaxSetting>
                                </AjaxSettings>
                            </telerik:RadAjaxManagerProxy>
                            <telerik:RadAjaxLoadingPanel Skin="Forest" ID="RadAjaxLoadingPanel1" runat="server"
                                Height="75px" Width="75px">
                            </telerik:RadAjaxLoadingPanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    
    
    
</asp:Content>
