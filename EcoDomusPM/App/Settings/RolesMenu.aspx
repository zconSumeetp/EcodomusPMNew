<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true" CodeFile="RolesMenu.aspx.cs" Inherits="App_Settings_RolesPermissions" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript" language="javascript">
    window.onload = body_load;
    function body_load() {

        var screenhtg = set_NiceScrollToPanel();
    }

    function pageload(flag, id, val) {//alert(flag);
        if (flag == 'Role Details') {
            var role_id = QuseryStringValue('roleid');
            pageToLoad = "../Settings/RoleDetails.aspx?roleId="+role_id;
//            document.getElementById("divsitemap").innerHTML = "<span><img id='ctl00_ctl00_SiteMapPath1_ctl01_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
//                                            "</span><span>Project Setup</span>" + "&nbsp;" +
//                                            "<span><img id='ctl00_ctl00_SiteMapPath1_ctl01_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
//                                            "</span><span><a style='text-decoration:none' href='Roles.aspx'>Roles</a></span>" + "&nbsp;" +
//                                            "<span><img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
            //                                            "</span><a id='ctl00_ctl00_SiteMapPath1_SkipLink'>Role Details</a></span>";

            document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span><a>Project Setup</a></span>" + "&nbsp;" +

                                            "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='Roles.aspx'>Roles</a></span></font>" + "&nbsp;" +
                                            "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>Role Details</span><a id='SiteMapPath1_SkipLink'></a></span>";
        }

        else if (flag == 'Permissions') {
            pageToLoad = "../Settings/Roles_COBie.aspx";
            document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span><a>Project Setup</a></span>" + "&nbsp;" +

                                            "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='Roles.aspx'>Roles</a></span></font>" + "&nbsp;" +
                                            "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>Permissions</span><a id='SiteMapPath1_SkipLink'></a></span>";
//            document.getElementById("divsitemap").innerHTML = "<span><img id='ctl00_ctl00_SiteMapPath1_ctl01_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
//                                            "</span><span>Project Setup</span>" + "&nbsp;" +
//                                            "<span><img id='ctl00_ctl00_SiteMapPath1_ctl01_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
//                                            "</span><span><a style='text-decoration:none' href='Roles.aspx'>Roles</a></span>" + "&nbsp;" +
//                                            "<span><img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
//                                            "</span><a id='ctl00_ctl00_SiteMapPath1_SkipLink'>Permissions</a></span>";
        }
        else 
        {
        }

        loadintoIframe('frameSettingsMenu', pageToLoad)
        return false;
    }



    function loadintoIframe(iframeid, url) 
    {
    
        var iframewindow = document.getElementById(iframeid);
        iframewindow.src = url;


    }

    function QuseryStringValue(QID) {
        // Fetch the query string.
        var QStringOriginal = window.location.search.substring(1);

        // Change the case as querystring id values normally case insensitive.
        QString = QStringOriginal.toLowerCase();
        var qsValue = '';

        // QueryString ID.
        QID = QID.toLowerCase();
        // Start & end point of the QueryString Value.
        var qsStartPoint = QString.indexOf(QID);
        if (qsStartPoint != -1) {
            qsValue = QStringOriginal.substring(qsStartPoint + QID.length + 1);
            // Search for '&' in the query string;
            var qsEndPoint = qsValue.indexOf('&');
            if (qsEndPoint != -1) {
                // retrive the QueryString value & Return it.
                qsValue = qsValue.substring(0, qsEndPoint);
            }
            else if (qsValue.indexOf('#') != -1) {
                // Search for '#' in the query string;
                qsEndPoint = qsValue.indexOf('&');
                // retrive the QueryString value & Return it.
                qsValue = qsValue.substring(0, qsEndPoint);
            }
            else {
                qsValue = qsValue.substring(0);
            }
        }
        return qsValue;
    }

    function onClientTabSelected(sender, args) {
        
        var newTabValue = args.get_tab().get_value();
        pageload(newTabValue);
        var tabStrip = $find("<%= rtsRolesProfile.ClientID %>");
        tabStrip.set_selectedIndex = true;
        args.set_cancel(true);
        document.getElementById('<%= hfSelectedIndex.ClientID %>').value = newTabValue;
        document.getElementById('<%= btnclick.ClientID %>').click();
    }

    

    function resize_iframe(obj) 
    {
        try {

            document.getElementById("frameSettingsMenu").hideFocus = true;
            var oBody = frameSettingsMenu.document.body;
            var oFrame = document.all("frameSettingsMenu");
            var string = document.getElementById("frameSettingsMenu").src.toString();


            if (obj != null) {
                docHeight = frameSettingsMenu.document.body.scrollHeight;
                if (docHeight <= 400) {
                    document.getElementById("frameSettingsMenu").height = 400;
                    $('divRoleDetailsId').addClass('tdZebraLightGray');
                }
                else {
                    //obj.height = docHeight + 20;

                    document.getElementById("frameSettingsMenu").height = docHeight;
                }
            }
        }

        catch (e) {
            window.status = 'Error: ' + e.number + '; ' + e.description;
        }
    }
    window.onresize = resize_iframe; 
    
  
</script>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
     <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
<table>
  <caption>
    <div id="component" runat="server" visible="false">
       <asp:Label ID="lblcomponent" runat="server" Text="<%$Resources:Resource,Component_Name%>" ></asp:Label>:
     </div>
 </caption> 
</table>

<table id="tblleftmenu" class="tdZebraLightGray" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;background-color:transparent;
       vertical-align: top;" runat="server" width="100%">
        
        <tr><td style="height:10px;"></td></tr>
        <tr>
             <td class="tdZebraLightGray" style="vertical-align: top; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px; text-align: left;">
          <telerik:RadTabStrip ID="rtsRolesProfile"  runat="server" MultiPageID="rmpRolesProfile" Visible="true" OnClientTabSelecting="onClientTabSelected" CssClass="tdZebraLightGray"
                SelectedIndex="0" AutoPostBack="true">
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="rmpRolesProfile" runat="server" SelectedIndex="0">
                <telerik:RadPageView ID="rpvRolesProfile" Width="100%" runat="server">
                <iframe id="frameSettingsMenu" name="frameSettingsMenu" frameborder="0" width="100%" class="tdZebraLightGray" onload="resize_iframe(this)" scrolling="no"></iframe>
                </telerik:RadPageView>
                </telerik:RadMultiPage>    
            </td>
        </tr>
     
 <tr><td>

    <asp:HiddenField ID="hf_roleId" runat ="server" Value="" />
    <asp:HiddenField ID="hfSelectedIndex" runat="server" Value="0" />
                <div style="display: none;">
                    <asp:Button runat="server" ID="btnclick" Text="" BackColor="Transparent" OnClick="btnclick_Click" /></div>
                   <telerik:RadAjaxManagerProxy ID="ramAsset" runat="server">
                    <AjaxSettings>
                        <telerik:AjaxSetting AjaxControlID="btnclick">
                            <UpdatedControls>
                                <telerik:AjaxUpdatedControl ControlID="rtsRolesProfile" />
                            </UpdatedControls>
                        </telerik:AjaxSetting>
                         
                    </AjaxSettings>
                </telerik:RadAjaxManagerProxy>
                <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
                    Height="75px" Width="75px">
                </telerik:RadAjaxLoadingPanel>
                   
                    </td></tr>
   </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

