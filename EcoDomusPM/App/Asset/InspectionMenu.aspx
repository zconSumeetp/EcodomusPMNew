<%@ Page Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true" CodeFile="InspectionMenu.aspx.cs" Inherits="App_Asset_InspectionMenu" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <script type="text/javascript" language="javascript">


       function pageload(flag, id) {//alert(flag); 
       
           if (flag == 'InspectionProfile') {
           
               // alert(document.getElementById("ctl00_ContentPlaceHolder1_hf_Facility_id").value)
               pageToLoad = "InspectionProfile.aspx?InspectionId=" + document.getElementById("ContentPlaceHolder1_hfInspectionID").value;
               

           }
           else if (flag == 'Issues') {
               pageToLoad = "Assetissues.aspx?inspectionid=" + document.getElementById("ContentPlaceHolder1_hfInspectionID").value;
           }

           else {
           }

           loadintoIframe('frameSettingsMenu', pageToLoad)
           return false;
       }

       function loadintoIframe(iframeid, url) {//alert("in loading to iframe");

       
           var iframewindow = document.getElementById(iframeid);
           iframewindow.src = url;
           //            iframewindow.reload(true);

           //            var iframe = document.getElementById('frame0');
           //            var newiframe = document.createElement('iframe');
           //            newiframe.src = iframe.src;
           //            iframe.parentNode.replaceChild(newiframe, iframe);

       }


       function CallClickEvent(url) {

           window.location = url;

       }

       //To get Updated Task Id
       function UpdateTaskId(newtaskid) {


           //alert(document.getElementById("ctl00_ContentPlaceHolder1_hfOrgid") + "  = " + newtaskid);
           alert(document.getElementById("ctl00_ContentPlaceHolder1_hf_Facility_id").value);
           // alert(newtaskid);
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


        function resize_iframe(obj) {

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
   <table id="tblleftmenu" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;
        margin-top: 5%; vertical-align: top;" runat="server" width="100%">
        <tr>
            <td style="vertical-align: top; width: 120px">
                <telerik:RadMenu ID="rmSettingsMenu" runat="server" Width="100%" EnableEmbeddedSkins="false"
                    CssClass="MenuVisibility" BorderWidth="0px" Flow="vertical" CausesValidation="false"
                    OnClientItemClicking="onClicking">
                </telerik:RadMenu>
            </td>
            <td style="vertical-align: top; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px;
                text-align: left;">
                <div style="text-align: left;">
                    <iframe id="frameSettingsMenu" name="frameSettingsMenu" frameborder="0" marginwidth="100%"
                        onload="resize_iframe(this)" width="100%" scrolling="no"></iframe>
                </div>
            </td>
        </tr>
    </table>

    <table>
        <tr>
            <td>
                <asp:HiddenField ID="hfInspectionID" runat="server" Value="0" />
                
            </td>
        </tr>
    </table>
</asp:Content>
