<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomus_PM_New.master"  AutoEventWireup="true"
    CodeFile="UserMenu.aspx.cs" Inherits="App_Settings_UserMenu" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
      <script type="text/javascript" language="javascript">
        function sitemap() {
          /*  document.getElementById("divsitemap").innerHTML =
                                            "<span><img id='ctl00_ctl00_SiteMapPath1_ctl01_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
                                           "</span><span><a>Settings</a></span>" + "&nbsp;" +
                                            "<span><img id='ctl00_ctl00_SiteMapPath1_ctl03_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
                                            "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;" +
                                            "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
                                            "</span><span>Organization Profile</span><a id='ctl00_ctl00_SiteMapPath1_SkipLink'></a></span>";

            */
            document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span><span><a>Settings</a></span>" + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='Organizations.aspx'>Organizations</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Organization Profile</span><a id='SiteMapPath1_SkipLink'></a></span>";
        }

        //get the address of page to load into iframe
        function pageload(flag) {
           if (flag == 'User Profile') {
                pageToLoad = "UserProfile.aspx?UserId=" + document.getElementById("ContentPlaceHolder1_hfUserid").value + "&Organization_Id=" + document.getElementById("ContentPlaceHolder1_hforganization_id").value + "&flag=";
                if (document.getElementById("hfpopupflag").value != 'popup')
               
               /* document.getElementById("divsitemap").innerHTML = "<span><img id='ctl00_ctl00_SiteMapPath1_ctl01_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
                                                " </span><span><a>Settings</a></span>" + "&nbsp;" +
                                           "<span><img id='ctl00_ctl00_SiteMapPath1_ctl03_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
                                           "</span><span><a style='text-decoration:none' href='User.aspx'>Users</a></span>" + "&nbsp;" +
                                            "<span><img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
                                            "</span><span>User Profile</span><a id='ctl00_ctl00_SiteMapPath1_SkipLink'></a></span>" + "&nbsp;";
            */
                    document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span><span><a>Settings</a></span>" + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='User.aspx'>Users</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>User Profile</span><a id='SiteMapPath1_SkipLink'></a></span>";
            }
            else if (flag == 'Projects') {
            
                pageToLoad = "UserProjects.aspx?flag=no_master&UserId=" + document.getElementById('ContentPlaceHolder1_hfUserid').value + "&Organization_Id=" + document.getElementById("ContentPlaceHolder1_hforganization_id").value + "&user_role=" + document.getElementById("ContentPlaceHolder1_hfUserRole").value;
                if (document.getElementById("hfpopupflag").value != 'popup')
               // pageToLoad = "UserFacility.aspx?UserId=" + document.getElementById('ContentPlaceHolder1_hfUserid').value + "&user_role=" + document.getElementById('ContentPlaceHolder1_hfUserRole').value;
               
               /* document.getElementById("divsitemap").innerHTML = "<span><img id='ctl00_ctl00_SiteMapPath1_ctl01_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
                                            " </span><span><a>Settings</a></span>" + "&nbsp;" +
                                           "<span><img id='ctl00_ctl00_SiteMapPath1_ctl03_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
                                           "</span><span><a style='text-decoration:none' href='User.aspx'>Users</a></span>" + "&nbsp;" +
                                            "<span><img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/arrow-brdcrms.gif' style='border-width:0px;' />" + "&nbsp;" +
                                           "</span><span>Projects</span><a id='ctl00_ctl00_SiteMapPath1_SkipLink'></a></span>" + "&nbsp;";*/
                    document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span><span><a>Settings</a></span>" + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='User.aspx'>Users</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Projects</span><a id='SiteMapPath1_SkipLink'></a></span>";
            }
            loadintoIframe('frameSettingsMenu', pageToLoad)
            return false;
        }

        //assign url to iframe
        function loadintoIframe(iframeid, url) {
            document.getElementById(iframeid).src = url;
        }

        function loadProjectsPage(iframeid, url) {
            document.getElementById(iframeid).src = url;
            document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span><span><a>Settings</a></span>" + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='User.aspx'>Users</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Projects</span><a id='SiteMapPath1_SkipLink'></a></span>";
        }

        function CallClickEvent(url) {
            window.location = url;
        }

        //To get Updated Task Id
        function UpdateTaskId(newtaskid) {
            document.getElementById("ctl00_ContentPlaceHolder1_hfUserid").value = newtaskid;
        }

        //  when clicked on left menu item
        function onClicking(sender, eventArgs) {
            var item = eventArgs.get_item();
            pageload(item.get_value());
            eventArgs.set_cancel(true);
        }

        function CallClickEvent(url) {
            window.location = url;
        }

        function onClientTabSelected(sender, args) {

            // document.getElementById["ctl00_ContentPlaceHolder1_rtsFacilityProfile_ClientState"].selectedIndex = -1;
            //this.selected = true;


            var newTabValue = args.get_tab().get_value();
            var tabStrip = $find("<%= rtsSettingMenu.ClientID %>");



            //  RadTab currentTab = rtsFacilityProfile.FindTabByUrl(Request.Url.PathAndQuery);
            // if (currentTab != null) currentTab.Selected = true;
            //var tab = tabStrip.findTabByText(newTabValue);
         

            pageload(newTabValue);

            //var tabStrip = $find("<%= rtsSettingMenu.ClientID %>");
            //tabStrip.setvisible = true;

            //tabStrip.set_selectedIndex = args._tab._control.__msdisposeindex;            
            args.set_cancel(true);
            document.getElementById('<%= hfSelectedIndex.ClientID %>').value = newTabValue;

            document.getElementById('<%= btnclick.ClientID %>').click();

        }


        //iframe resize
        function resize_iframe(obj) {
            try {
                document.getElementById("frameSettingsMenu").hideFocus = true;
                var oBody = frameSettingsMenu.document.body;
                var oFrame = document.all("frameSettingsMenu");

                if (obj != null) {
                    docHeight = frameSettingsMenu.document.body.scrollHeight;
                    if (docHeight > 500) {
                        document.getElementById("ctl00_ContentPlaceHolder1_tblleftmenu").style.height = docHeight + 'px';
                        obj.style.height = docHeight + 'px'
                    }
                    else {
                        if (document.getElementById("ctl00_ContentPlaceHolder1_tblleftmenu") != null)
                            document.getElementById("ctl00_ContentPlaceHolder1_tblleftmenu").style.height = '500px';
                        obj.style.height = '600px'
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
         
          //  $(".divScroll").niceScroll({ touchbehavior: false, cursorcolor: "#969696", cursoropacitymax: 0.8, cursorborder: "none", cursorwidth: 08, background: "#cccccc", overflow: "hidden", show: true });
        }
        
    </script>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    </telerik:RadCodeBlock>

    <table id="tblleftmenu" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;
        margin-top: 0%; vertical-align: top; height:600px" runat="server" width="100%">
         <tr>
             <th>
                <asp:Label ID="lblUserName" Visible="false" runat="server" CssClass="profileName" Text="Project Name:"></asp:Label>
            </th>
        </tr> 
         
        
        <tr>
           <%-- <td id="td_obj" runat="server" style="vertical-align: top; width: 120px">
                <telerik:RadMenu ID="rmSettingsMenu" runat="server" Width="100%" EnableEmbeddedSkins="false"
                    CssClass="MenuVisibility" BorderWidth="0px" Flow="vertical" CausesValidation="false"
                    OnClientItemClicking="onClicking" Visible="true" >
                </telerik:RadMenu>
            </td>--%>
            <td class="centerAlign" style="vertical-align: top; text-align: left;">
                 <telerik:RadTabStrip ID="rtsSettingMenu" runat="server" Skin="Default" MultiPageID="RadMultiPage1" OnClientTabSelecting="onClientTabSelected"
                 SelectedIndex="0">
                </telerik:RadTabStrip>
                <div style="text-align: left;">
                    <iframe id="frameSettingsMenu" name="frameSettingsMenu" frameborder="0" 
                        onload="resize_iframe(this)" width="100%" scrolling="no" height="600px"></iframe>
                </div>
                <asp:HiddenField ID="hfUserid" runat="server" Value="0" />
                <asp:HiddenField ID="hfUserRole" runat="server" />
                <asp:HiddenField ID="hforganization_id" runat="server" />
                  <asp:HiddenField ID="hfpopupflag" runat="server" ClientIDMode="Static"/>
                  <asp:HiddenField ID="hfSelectedIndex" runat="server" Value="0" />
              
               <div style="display:none;"> <asp:Button runat="server" ID = "btnclick" Text="" BackColor="Transparent" 
                    onclick="btnclick_Click"  /></div>
            </td>
        </tr>
        <tr><td>
          <telerik:RadAjaxManagerProxy ID="ramAsset" runat="server" >

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnclick">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rtsSettingMenu" />
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
