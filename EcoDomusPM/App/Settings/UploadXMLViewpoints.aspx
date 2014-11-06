<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UploadXMLViewpoints.aspx.cs" Inherits="App_Settings_UploadXMLViewpoints" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title></title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <telerik:RadCodeBlock ID="r1" runat="server">
    <script language="javascript" type="text/javascript">
        function closeWindow() {
            window.close();
            return false;
        }


        function LoadViews() {

            window.opener.document.getElementById('btn_upload_server').click();
            closeWindow();
        }
        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
        .style1
        {
            width: 305px;
        }
    </style>
</head>
<body style="margin: 0px 0px 0px 0px; padding-top: 0; background: white;">
     <telerik:RadFormDecorator ID="formdecorator1" runat="server" DecoratedControls="Buttons"  
        Skin="Hay" />
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <div>
        <table style="margin: 0px 50px 50px 50px; width: 50%;">
        <caption>Upload XML:</caption>
            <tr style="height:10px">
               <td></td> 
            </tr>
            
            <tr >
                <td colspan="2">
                    <telerik:radupload id="upload_xml" runat="server" controlobjectsvisibility="None"
                        initialfileinputscount="1" overwriteexistingfiles="false" width="100%" />
                </td>
            </tr>
            <tr>
            
                <td style= "width:30%">
                    <asp:Button ID="btn_upload" runat="server" Width="100px" Text="<%$Resources:Resource,Upload%>" 
                        onclick="btn_upload_Click"  />
                </td>
                <td >
                    <asp:Button ID="btn_close" runat="server" OnClientClick="javascript:return closeWindow();" Width="100px" Text="<%$Resources:Resource,Close%>" />
                </td>
            </tr>
        </table>
    </div>
   
    </form>
</body>
</html>
