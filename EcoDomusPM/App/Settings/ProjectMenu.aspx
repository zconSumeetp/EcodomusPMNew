<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProjectMenu.aspx.cs" Inherits="App_Settings_ProjectMenu"  MasterPageFile="~/App/EcoDomus_PM_New.master"  %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
   <script type="text/javascript" language="javascript">
       function pageload(flag)        
       {       
           if (flag == 'ProjectProfile') 
           {               
               //var IsFromClient = document.getElementById("ContentPlaceHolder1_hf_no_master").value;
               //if (IsFromClient == "no_master")
                 //  pageToLoad = "../Settings/ProjectProfile.aspx?flag=no_master&ProjectId=" + document.getElementById("ContentPlaceHolder1_hfProjectID").value;
               if (document.getElementById("ContentPlaceHolder1_hfispage").value == "organization") 
               {
                   pageToLoad = "../Settings/ProjectProfile.aspx?ProjectId=" + document.getElementById("ContentPlaceHolder1_hfProjectID").value + "&org_id=" + document.getElementById("ContentPlaceHolder1_hforgid").value + "&org_name=" + document.getElementById("ContentPlaceHolder1_hforgname").value+"&ispage=organization";
               }
               //else if (document.getElementById("ContentPlaceHolder1_hforgid").value != "")
               
               else if (document.getElementById("ContentPlaceHolder1_hfispage").value != "organization") 
               {
                   pageToLoad = "../Settings/ProjectProfile.aspx?ProjectId=" + document.getElementById("ContentPlaceHolder1_hfProjectID").value+"&ispage=";
               }
           }


           else 
           {
           }
           loadintoIframe('frameSettingsMenu', pageToLoad) 
           return false;
       }

       function loadintoIframe(iframeid, url)
        {
           //var iframewindow = document.getElementById(iframeid);
           //iframewindow.src = url;
           document.getElementById(iframeid).src = url;  
       }

       function CallClickEvent(url) 
       {
           window.location = url;
       }

       //  On menu item onClicking event.
       function onClicking(sender, eventArgs) 
       {
           var item = eventArgs.get_item();
           pageload(item.get_value());
           eventArgs.set_cancel(true);
       }

       function CallClickEvent(url) {

           window.location = url;
       }

       function onClientTabSelected(sender, args) 
       {          
           var newTabValue = args.get_tab().get_value();
           pageload(newTabValue);
           args.set_cancel(true);
       }


       function resize_iframe(obj) 
       {       
           try {

               document.getElementById("frameSettingsMenu").hideFocus = true;
               var oBody = frameSettingsMenu.document.body;
               var oFrame = document.all("frameSettingsMenu");

               if (obj != null) {
                   docHeight = frameSettingsMenu.document.body.scrollHeight;
                   if (docHeight > 500) {
                       //   document.getElementById("ctl00_ContentPlaceHolder1_tblleftmenu").style.height = docHeight + 'px';
                       obj.style.height = docHeight + 'px'
                   }
                   else {
                       if (document.getElementById("ctl00_ContentPlaceHolder1_tblleftmenu") != null)
                           document.getElementById("ctl00_ContentPlaceHolder1_tblleftmenu").style.height = '500px';
                       obj.style.height = '500px'
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
    
 <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
   <table id="tblleftmenu" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;
        margin-top: 0%; vertical-align: top;" runat="server" width="100%">
        <tr>
             <th>
                <asp:Label ID="lblProjectName" Visible="false" runat="server" CssClass="profileName" Text="Project Name:"></asp:Label>
            </th>
        </tr> 
         
         <tr>
            <td style="vertical-align: top" class="centerAlign" >

                <telerik:RadTabStrip ID="rtsProjectProfile" runat="server" MultiPageID="RadMultiPage1" 
                 OnClientTabSelecting="onClientTabSelected" SelectedIndex="0">
               <%-- <Tabs>
                <telerik:RadTab Text="Profile" Selected="true" Value="0" TabIndex="0" 
                                PageViewID="rpvTypeProfile">
                            </telerik:RadTab>
                </Tabs>--%>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="rmpProjectProfile" runat="server"
                        SelectedIndex="0" >
                    <telerik:RadPageView ID="rpvProjectProfile" Width="100%" runat="server">
                    <iframe id="frameSettingsMenu" name="frameSettingsMenu" frameborder="0" marginwidth="100%"
                        onload="resize_iframe(this)" scrolling="no" width="110%">                      
                                <%--onload="resize_iframe('<%= rpvTypeProfile.ClientID %>',this);"--%>
                            </iframe>
                    </telerik:RadPageView>     
                </telerik:RadMultiPage>
            </td>

            <td style="vertical-align: top; width: 120px">
                <telerik:RadMenu ID="rmSettingsMenu" runat="server" Width="100%" EnableEmbeddedSkins="false"
                    CssClass="MenuVisibility" BorderWidth="0px" Flow="vertical" CausesValidation="false" Visible="false"
                    OnClientItemClicking="onClicking">
                </telerik:RadMenu>
            </td>
            <td style="vertical-align: top; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px;
                text-align: left;">
                <div style="text-align: left;">
                    <%--<iframe id="frameSettingsMenu" name="frameSettingsMenu" frameborder="0" marginwidth="100%"
                        onload="resize_iframe(this)" width="100%" scrolling="no"></iframe>--%>
                </div>
            </td>
        </tr>
    </table>

    <table>
        <tr>
            <td>
                <asp:HiddenField ID="hfProjectID" runat="server" Value="0" />
                <asp:HiddenField ID="hf_page_id" runat="server" Value="0" />
                  <asp:HiddenField ID="hf_no_master" runat="server" Value="0" />

                  <asp:HiddenField ID="hforgid" runat="server" Value="0" />
                  <asp:HiddenField ID="hforgname" runat="server" Value="0" />
                  <asp:HiddenField ID="hfispage" runat="server" Value="0" />
            </td>
        </tr>
    </table>
</asp:Content>