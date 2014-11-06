<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TypeProfileMenu.aspx.cs"   MasterPageFile="~/App/EcoDomus_PM_New.master"  Inherits="App_Asset_TypeProfileMenu" %>
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
                                            "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='TypePM.aspx'>Types</a></span></font>" + "&nbsp;" +
                                            "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>" + name + "</span><a id='SiteMapPath1_SkipLink'></a></span>";
        };

        function pageload(flag, id, val) {//alert(flag);
           
            if (flag == 'Type Profile') {
                pageToLoad = "TypeProfileNew.aspx?type_id=" + document.getElementById("ContentPlaceHolder1_hf_type_id").value;
                SectionNameMaker('Type Profile');
            }
            else if (flag == 'Attributes') {

                pageToLoad = "TypeAttribute.aspx?entity_id=" + document.getElementById("ContentPlaceHolder1_hf_type_id").value + "&entity_name=Type";
                SectionNameMaker('Attributes');

            }
            else if (flag == 'Components') {

                pageToLoad = "Asset.aspx?id=" + document.getElementById("ContentPlaceHolder1_hf_type_id").value + "&name=type";
                SectionNameMaker('Components');

            }
            else if (flag == 'Affect') {

                pageToLoad = "../Asset/AssetsAffect.aspx?asset_id=" + document.getElementById("ContentPlaceHolder1_hf_type_id").value;
                SectionNameMaker('Affect');

            }
            else if (flag == 'Documents') {

                pageToLoad = "Assign_Document.aspx?id=" + document.getElementById("ContentPlaceHolder1_hf_type_id").value + "&name=Type";
                SectionNameMaker('Documents');
            }
            else if (flag == 'Spares') {
                pageToLoad = "TypeSpares.aspx?Type_id=" + document.getElementById("ContentPlaceHolder1_hf_type_id").value + "&name=type";
                SectionNameMaker('Spares');
            }



            else if (flag == 'Jobs') {
                pageToLoad = "TypeJobs.aspx?Type_id=" + document.getElementById("ContentPlaceHolder1_hf_type_id").value + "&name=type" + "&resolution=" + document.getElementById("hfScreenResolution").value;
                SectionNameMaker('Jobs');
            }

            else if (flag == 'Organization Profile') {
                pageToLoad = "OrganizationProfile.aspx?Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value;
                SectionNameMaker('Organization Profile');
            }


            else if (flag == 'Type Profile' && val == 'type') {
                pageToLoad = "TypeProfile.aspx?type_id=" + document.getElementById("ContentPlaceHolder1_hf_type_id").value + "&val=type";
                SectionNameMaker('Type Profile');
            }


            else if (flag == 'Resources') {

                pageToLoad = "TypeResources.aspx?entity_id=" + document.getElementById("ContentPlaceHolder1_hf_type_id").value + "&entity_name=Type";
                SectionNameMaker('Resources');

            }

            loadintoIframe('frameSettingsMenu', pageToLoad)
            return false;
        }

        function loadintoIframe(iframeid, url) {
            document.getElementById(iframeid).src = url;
        }


        function CallClickEvent(url) {

            window.location = url;

        }

        //To get Updated Task Id
        function UpdateTaskId(newtaskid) {
            document.getElementById("ctl00_ContentPlaceHolder1_hfOrgid").value = newtaskid;
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

        function resize_iframe(obj) {
            try {
                document.getElementById("frameSettingsMenu").hideFocus = true;
                var oBody = frameSettingsMenu.document.body;
                var oFrame = document.all("frameSettingsMenu");
                var string = document.getElementById("frameSettingsMenu").src.toString();

                if (obj != null) {
                    docHeight = frameSettingsMenu.document.body.scrollHeight;
                    docWidth = frameSettingsMenu.document.body.scrollWidth;
                    if (document.getElementById("hfScreenResolution").value == "0")
                        document.getElementById("hfScreenResolution").value = frameSettingsMenu.document.body.scrollWidth;

                    if (docHeight <= 400) {
                        document.getElementById("frameSettingsMenu").height = 500;
                        document.getElementById("frameSettingsMenu").className = "tdZebraLightGray";
                    }
                    else {
                        document.getElementById("frameSettingsMenu").height = docHeight + 250;
                        document.getElementById("frameSettingsMenu").className = "tdZebraLightGray";

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

   var flagTabSelect = false;
   function onClientTabSelected(sender, args) {
      
       var newTabValue = args.get_tab().get_value();
       
       var tabStrip = $find("<%= rtsTypeProfile.ClientID %>");
       args.set_cancel(false);
       document.getElementById('<%= hfSelectedIndex.ClientID %>').value = newTabValue;
       pageload(newTabValue);
   }

   function selectTab(text) {
       var tabStrip = $find("<%= rtsTypeProfile.ClientID %>");
       var tab = tabStrip.findTabByText(text);
       if (tab) {
           tab.select();
       }
       else {
           alert("Tab with text '" + text + "' not found.");
       }
   } 

    
    </script>
  
  <style type="text/css">
      .RadTabStrip_Default .rtsLink
            {
                font-family:Arial;
                font-weight:normal;
                color:Black;
                font-size:12px;	
            }
  </style>

    <table id = "tblmainLayout" style="table-layout:fixed" >
    <tr>
    <td align="left">
    <table >
        <caption >
            <div id="Type" style="text-align:left;" runat="server" visible="false">
                <asp:Label ID="lbltype" runat="server" Text="<%$Resources:Resource, Type_Name%>"></asp:Label>:
                <asp:Label ID="lbltypename" runat="server"></asp:Label></div>
            <div id="TypeProfile" runat="server" visible="false">
                <asp:Label ID="lbltypeprofile" runat="server" Text="<%$Resources:Resource, Type_Profile%>"></asp:Label></div>
        </caption>
    </table>
    </td>
    </tr>
    
    <tr>
    <td align="left">
    <table id="tblleftmenu" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;
        margin-top:0%; vertical-align: top;" runat="server" width="100%">
        <tr>
            <td style="vertical-align: top;">
                <telerik:RadTabStrip ID="rtsTypeProfile" runat="server" MultiPageID="RadMultiPage1"
                    OnClientTabSelecting="onClientTabSelected" SelectedIndex="0"  
                    Skin="Default">
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="rmpTypeProfile" runat="server" SelectedIndex="0">
                    <telerik:RadPageView ID="rpvTypeProfile" Width="100%"   runat="server">
                      <iframe id="frameSettingsMenu" name="frameSettingsMenu" frameborder="0"  width="100%"
                            scrolling="no" onload="resize_iframe(this)"></iframe>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
        <tr>
            <td>
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
                                <telerik:AjaxUpdatedControl ControlID="rtsTypeProfile" />
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
    
    
    <asp:HiddenField ID="hf_type_id" runat="server" Value="0" />
    <asp:HiddenField ID="hfSelectedIndex" runat="server" Value="0" />
    <asp:HiddenField ID="hfMissingAttribute" runat="server" />
     <asp:HiddenField ID="hfScreenResolution" runat="server" ClientIDMode="Static"  Value="0" />
     
</asp:Content>

