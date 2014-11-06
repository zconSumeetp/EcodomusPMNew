<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="DocumentMenu.aspx.cs" Inherits="App_Asset_DocumentMenu" %>
 
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
      <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
     <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function onClientTabSelected(sender, args) {
          
            var newTabValue = args.get_tab().get_value();
            var url = '';
            var data = document.getElementById("<% =hfPageData.ClientID %>").value; // $find("<%= hfPageData.ClientID %>")


            if (newTabValue == 'Attributes') {
                url = 'DocumentAttributes.aspx' + data;
                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span><span><a>COBie</a></span>" + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='Document.aspx'>Document</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Attributes</span><a id='SiteMapPath1_SkipLink'></a></span>";
            }
            else {
                url = 'DocumentProfile.aspx' + data;
                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span><span><a>COBie</a></span>" + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='Document.aspx'>Document</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Document Profile</span><a id='SiteMapPath1_SkipLink'></a></span>";
            }
            
            loadintoIframe('frameSettingsMenu', url);

        }

        function loadintoIframe(iframeid, url) {//alert("in loading to iframe");

            var iframewindow = document.getElementById(iframeid);
         
            iframewindow.src = url;
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
                        document.getElementById("frameSettingsMenu").height = 600;

                    }
                    else {
                       document.getElementById("frameSettingsMenu").height = docHeight + 50;
                        document.getElementById("frameSettingsMenu").width = docWidth;
                    }
                }
                body_load();
            }

            catch (e) {
                window.status = 'Error: ' + e.number + '; ' + e.description;
            }

        }

        function setDefault() {
            document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span><span><a>COBie</a></span>" + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='Document.aspx'>Document</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Document Profile</span><a id='SiteMapPath1_SkipLink'></a></span>";
            var data = document.getElementById("<% =hfPageData.ClientID %>").value; // $find("<%= hfPageData.ClientID %>")
            loadintoIframe('frameSettingsMenu', 'DocumentProfile.aspx' + data);
        }
        window.onload = body_load;
        function body_load() {
            var screenhtg = set_NiceScrollToPanel();
        }
       
    </script>
    <table width="100%">
        <tr>
            <td align="left">
                <telerik:RadTabStrip ID="rtsDocumentmenu" runat="server" MultiPageID="RadMultiPage1"
                    Visible="true" OnClientTabSelecting="onClientTabSelected" SelectedIndex="0">
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="rmpDocumentMenu" runat="server" SelectedIndex="0">
                    <telerik:RadPageView ID="rpvDocumentProfile" Width="100%" runat="server">
                        <iframe id="frameSettingsMenu" name="frameSettingsMenu" frameborder="0" marginwidth="100%"
                            onload="resize_iframe(this)" width="100%" scrolling="no"></iframe>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <asp:HiddenField runat="server" ID="hfPageData" Value="" />
            </td>
        </tr>
    </table>
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
