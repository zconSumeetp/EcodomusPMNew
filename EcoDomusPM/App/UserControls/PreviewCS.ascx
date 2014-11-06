<%@ Control Language="C#" AutoEventWireup="true" CodeFile="~/App/UserControls/PreviewCS.ascx.cs"
    Inherits="Setup_Sync_PreviewCS" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
<link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    function maxMinData(divName, imgID) {
        var displayStatus = document.getElementById(divName).style.display;
        if (displayStatus == "block") {
            document.getElementById(divName).style.display = "none";

            document.getElementById(imgID).src = "../Images/plus_sign.png";
            document.getElementById(imgID).alt = "Maximize"

        }
        if (displayStatus == "none") {
            document.getElementById(divName).style.display = "block";
            document.getElementById(imgID).src = "../Images/minus_sign.gif";
            document.getElementById(imgID).alt = "Manimize"
        }


    } 
</script>
<table width="100%">
    <tr>
        <td>
        </td>
    </tr>
</table>
<div id="previewPage">
    <%--Sync Profile--%>
    <table width="100%" cellspacing="5px">
        <tr>
            <td width="10%" align="right">
                <asp:Image ID="imgSycProfile" runat="server" AlternateText="Checked" ImageUrl="~/App/Images/Buttons/icon_checked.png"
                    Visible="false" />
            </td>
            <td align="left" width="90%">
                <asp:Label ID="lblSyncProfile" runat="server" Text="<%$Resources:Resource,Sync_Profile%>"
                    Font-Names="Verdana" Font-Size="Medium" ForeColor="Black"></asp:Label>
            </td>
        </tr>
    </table>
    <%--Facility--%>
    <table width="100%" cellspacing="5px">
        <tr>
            <td width="10%" align="right">
                <asp:Image ID="imgFacility" runat="server" AlternateText="Checked" ImageUrl="~/App/Images/Buttons/icon_checked.png"
                    Visible="false" />
            </td>
            <td align="left" width="90%">
                <asp:Label ID="lblFacility" runat="server" Text="<%$Resources:Resource,Facility%>"
                    Font-Names="Verdana" Font-Size="Medium" ForeColor="Black"></asp:Label>
            </td>
        </tr>
    </table>
    
    <%--Map Integration--%>
    <table width="100%" cellspacing="5px">
        <tr>
            <td width="10%" align="right">
                <asp:Image ID="imgMapIntegration" runat="server" AlternateText="Checked" ImageUrl="~/App/Images/Buttons/icon_checked.png"
                    Visible="false" />
            </td>
            <td align="left" width="90%">
                <asp:Label ID="lblMapIntegration" runat="server" Text="<%$Resources:Resource,Map_Integration%>"
                    Font-Names="Verdana" Font-Size="Medium" ForeColor="Black"></asp:Label>
            </td>
        </tr>
    </table>
    <%--Scheduler--%>
    <table width="100%" cellspacing="5px">
        <tr>
            <td width="10%" align="right">
                <asp:Image ID="imgScheduler" runat="server" AlternateText="Checked" ImageUrl="~/App/Images/Buttons/icon_checked.png"
                    Visible="false" />
            </td>
            <td align="left" width="90%">
                <asp:Label ID="lblScheduler" runat="server" Text="<%$Resources:Resource,Scheduler%>"
                    Font-Names="Verdana" Font-Size="Medium" ForeColor="Black"></asp:Label>
            </td>
        </tr>
    </table>
    <%--Asset Type--%>
    <table width="100%" cellspacing="5px">
        <tr style="display:none;">
            <td width="10%" align="right">
                <asp:Image ID="imgAssetType" runat="server" AlternateText="Checked" ImageUrl="~/App/Images/Buttons/icon_checked.png"
                    Visible="false" />
            </td>
            <td align="left" width="90%">
                <asp:Label ID="lblAssetType" runat="server" Text="<%$Resources:Resource,Asset_Type%>"
                    Font-Names="Verdana" Font-Size="Medium" ForeColor="Black"></asp:Label>
            </td>
        </tr>
    </table>
    <%--Space Type--%>
    <table width="100%" cellspacing="5px">
        <tr style="display:none;">
            <td width="10%" align="right">
                <asp:Image ID="imgSpaceType" runat="server" AlternateText="Checked" ImageUrl="~/App/Images/Buttons/icon_checked.png"
                    Visible="false" />
            </td>
            <td align="left" width="90%">
                <asp:Label ID="lblSpaceType" runat="server" Text="<%$Resources:Resource,Space_Type%>"
                    Font-Names="Verdana" Font-Size="Medium" ForeColor="Black"></asp:Label>
            </td>
        </tr>
    </table>
</div>
