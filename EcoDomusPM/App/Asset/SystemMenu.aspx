<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomus_PM_New.master"  AutoEventWireup="true"
    CodeFile="SystemMenu.aspx.cs" Inherits="App_Settings_SettingsMenu" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
     <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript">

        //  On menu item onClicking event.
        function onClicking(sender, eventArgs) {

            var item = eventArgs.get_item();
            pageload(item.get_value());
            eventArgs.set_cancel(true);

        }

        function SectionNameMaker(name) {
            document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span><span><a>COBie</a></span>" + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;'  href='System.aspx'>Systems</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>" + name +"</span><a id='SiteMapPath1_SkipLink'></a></span>";
        };

        function sitemapSystem() {
            SectionNameMaker('System Profile');
        }

        function pageload(flag,id,val)
         {         
            if (flag == 'System Profile')
             {
                pageToLoad = "SystemProfile_1.aspx?system_id=" + document.getElementById("ContentPlaceHolder1_hfSystemId").value;
                SectionNameMaker('System Profile');

            }

            if (flag == 'System Profile' && val == 'system') {

                pageToLoad = "SystemProfile.aspx?system_id=" + document.getElementById("ContentPlaceHolder1_hfSystemId").value + "&val=system";
                SectionNameMaker('System Profile');
            }


            else if (flag == 'Subsystems') {
                pageToLoad = "SubSystem.aspx?system_id=" + document.getElementById("ContentPlaceHolder1_hfSystemId").value; ;
                SectionNameMaker('Subsystems');

            }

            else if (flag == 'Components') {


                pageToLoad = "Asset.aspx?id=" + document.getElementById("ContentPlaceHolder1_hfSystemId").value + "&name=system";
                SectionNameMaker('Components');

            }

            else if (flag == 'Documents') {


            pageToLoad = "Assign_Document.aspx?id=" + document.getElementById("ContentPlaceHolder1_hfSystemId").value + "&name=System";
            SectionNameMaker('Components');
            }

            else if (flag == 'Affect') {

                pageToLoad = "../Asset/AssetsAffect.aspx?asset_id=" + document.getElementById("ContentPlaceHolder1_hfSystemId").value;
                SectionNameMaker('Affect');
            }

            else if (flag == 'View in BIM') {
                //debugger
                if (document.getElementById("ContentPlaceHolder1_hf_file_ext").value == 'nwd') {
                    pageToLoad = "../Settings/ModelViewer.aspx?id=" + document.getElementById("ContentPlaceHolder1_hfSystemId").value + "&name=System" + "&FileId=" + document.getElementById("ContentPlaceHolder1_hfUploaded_File_Id").value + "&facility_id=" + document.getElementById("ContentPlaceHolder1_hf_facility_id").value + "&fk_master_file_id=" + document.getElementById("ContentPlaceHolder1_hf_fk_masterfile_id").value;
                    SectionNameMaker('View in BIM');
                }
                else {
                    pageToLoad = "../Settings/EcodomusModelViewer.aspx?id=" + document.getElementById("ContentPlaceHolder1_hfSystemId").value + "&name=System" + "&FileId=" + document.getElementById("ContentPlaceHolder1_hfUploaded_File_Id").value + "&facility_id=" + document.getElementById("ContentPlaceHolder1_hf_facility_id").value + "&fk_master_file_id=" + document.getElementById("ContentPlaceHolder1_hf_fk_masterfile_id").value;
                    SectionNameMaker('View in BIM');
                }

            }


            else if (flag == 'Attributes') {
                pageToLoad = "Attribute.aspx?entity_name=System&entity_id=" + document.getElementById("ContentPlaceHolder1_hfSystemId").value;
                SectionNameMaker('Attributes');
            }

            

            loadintoIframe('frameSettingsMenu', pageToLoad)
            return false;
        }


        function loadintoIframe(iframeid, url) {//alert("in loading to iframe");
            document.getElementById(iframeid).src = url;
        }


        function CallClickEvent(url) {

            window.location = url;

        }

        function onClientTabSelected(sender, args) {

            var newTabValue = args.get_tab().get_value();
            pageload(newTabValue);

            var tabStrip = $find("<%= rtsSystemProfile.ClientID %>");
           // tabStrip.set_selectedIndex = true;

            args.set_cancel(false);
            document.getElementById('<%= hfSelectedIndex.ClientID %>').value = newTabValue;

            //document.getElementById('<%= btnclick.ClientID %>').click();
        }


        function resize_iframe(obj) {
        
            //alert("hello");
            try {
                document.getElementById("frameSettingsMenu").hideFocus = true;
                var oBody = frameSettingsMenu.document.body;
                var oFrame = document.all("frameSettingsMenu");
                var string = document.getElementById("frameSettingsMenu").src.toString();


                if (obj != null) {
                    docHeight = frameSettingsMenu.document.body.scrollHeight;
                    if (docHeight <= 400) {
                        document.getElementById("frameSettingsMenu").height = 600;
                    }
                    else {
                        //obj.height = docHeight + 20;

                        document.getElementById("frameSettingsMenu").height = docHeight+200;
                    }
                }
                
            }
            catch (e) {
                //alert(e.description);
                window.status = 'Error: ' + e.number + '; ' + e.description;
            }
        }
        window.onresize = resize_iframe;
        window.onload = body_load;
        function body_load() {
            var screenhtg = set_NiceScrollToPanel();
           
        }
        
    </script>
    <table id = "tblmainLayout" style="table-layout:fixed" >
    <tr>
    <td align="left">
    <table>
    <caption>
    <div id="system" runat="server" visible="false">
       <asp:Label ID="lblsystem" runat="server" Text="<%$Resources:Resource, System_Name%>" ></asp:Label>:
        <asp:Label ID="lblsystemname" runat="server" ></asp:Label></div>

   <div id="systemProfile" runat="server" visible="false">
   <asp:Label ID="lblsystemprofile" runat="server" Text="<%$Resources:Resource, System_Profile%>" ></asp:Label></div>
   </caption>
   </table></td>
    </tr>
    <tr>
    <td align="left">
    <table id="tblleftmenu" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;
        margin-top: 2%; vertical-align: top;" runat="server" width="100%">
        <tr><td style="height:10px;"></td></tr>
        <tr>
           <td style="vertical-align: top; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px;
                text-align: left;">
                <telerik:RadTabStrip ID="rtsSystemProfile" runat="server" MultiPageID="RadMultiPage1" Visible="true" OnClientTabSelecting="onClientTabSelected" 
                SelectedIndex="0">
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="rmpSystemProfile" runat="server" SelectedIndex="0">
                <telerik:RadPageView ID="rpvSystemProfile" Width="100%" runat="server">
                <iframe id="frameSettingsMenu" name="frameSettingsMenu" frameborder="0" marginwidth="100%"
                        onload="resize_iframe(this)" width="100%" scrolling="no" height="900"></iframe>
                
                </telerik:RadPageView>
                </telerik:RadMultiPage>
                
                    
                
            </td>
            <td style="vertical-align: top; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px;
                text-align: left;">
                <asp:HiddenField ID="hfSystemId" runat="server" Value="0" />
                <asp:HiddenField ID="hfUploaded_File_Id" runat="server" />
                <asp:HiddenField ID="hf_facility_id" runat="server" />
                <asp:HiddenField ID="hf_element_numeric_id" runat="server" Value="0" />
                <asp:HiddenField ID="hfSelectedIndex" runat="server" Value="0" />
                <asp:HiddenField ID="hf_fk_masterfile_id" runat="server" Value="0" />
                 <asp:HiddenField ID="hf_file_ext" runat="server" Value="0" />
               <div style="display:none;"> <asp:Button runat="server" ID = "btnclick" Text="" BackColor="Transparent" 
                    onclick="btnclick_Click"  /></div>
            </td>
        </tr>
        <tr><td>
          <telerik:RadAjaxManagerProxy ID="ramAsset" runat="server" >

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnclick">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rtsSystemProfile" />
                </UpdatedControls>
            </telerik:AjaxSetting>
               
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

     <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
        </td></tr>
    </table></td>
    </tr>
    
    </table>

    

    
     
</asp:Content>
