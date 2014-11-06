<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignFacility.aspx.cs" Inherits="App_Settings_AssignFacility" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Select Facility </title>
    
  <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
<script language="javascript" type="text/javascript">

    function validate() {
        alert("Please select Faclity!");
        return false;
    }

    function close_Window() {
        closewindow();
    }

    function Get_Assigned_Facilities(id, name)
     {       
        window.parent.document.getElementById("hfAssignedFacilityListIds").value = id;
        window.parent.document.getElementById("hfAssignedFacilityListNames").value = name;
        window.parent.document.getElementById("btnFacilityAssigned").click();
        Close();
    }

    function Clear() {
        document.getElementById("<%=srch_txt_box.ClientID %>").value = "";
        return false;
    }


    function closewindow() {
        Close();
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow)
            oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog      
        else if (window.frameElement != null) {
            if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow; //IE (and Moz as well)      
        }
        return oWindow;
    }

    function Close() {
        GetRadWindow().Close();
    }
     </telerik:RadCodeBlock>
</script>
 <style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
</head>
<body runat="server" id="bdy" style="background:white;">
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager" EnableScriptCombine="false">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Hay" DecoratedControls="Buttons" />
    <table id="orgprofile" width="80%" style="vertical-align: top; margin-left: 120px;
        margin-top: 10px; border: 1;" cellpadding="0" cellspacing="0" border="0">
        <caption>
        <asp:Label runat="server" Text="<%$Resources:Resource,Facilities%>"></asp:Label>
           
        </caption>
        <tr>
            <td>
                <asp:TextBox CssClass="SmallTextBox" ID="srch_txt_box" runat="server" TabIndex="1"></asp:TextBox>&nbsp;&nbsp;
                <asp:Button ID="btnSearch" Width="75px" runat="server" Text="<%$Resources:Resource,Search%>" TabIndex="2"  OnClick="btnSearch_Click" />
                <asp:Button ID="btnclear" runat="server" Text="<%$Resources:Resource,Clear%>" TabIndex="3" Width="75px" OnClientClick="javascript:return Clear();" />
            </td>
        </tr>
        <tr>
            <td style="height: 10px">
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="rgFacility" runat="server" AllowPaging="True" Skin="Hay" Width="380px" AllowMultiRowSelection="true"
                    AllowSorting="True" AutoGenerateColumns="False" OnSortCommand="rgFacility_OnSortCommand" PageSize="5"
                    OnPageIndexChanged="rgFacility_PageIndexChanged" OnPageSizeChanged="rgFacility_PageSizeChanged" PagerStyle-AlwaysVisible="true"> 
                    <ClientSettings>
                        <Selecting AllowRowSelect="True"/>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="ID,Name">
                        <Columns>
                            <telerik:GridClientSelectColumn >
                                <ItemStyle Width="10px" />
                                <HeaderStyle Width="10px" />
                            </telerik:GridClientSelectColumn>
                            <telerik:GridBoundColumn DataField="ID" HeaderText="<%$Resources:Resource,ID%>" Display="false" SortExpression="ID"
                                UniqueName="ID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Name" Display="false" UniqueName="Name" >
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn DataTextField="Name" HeaderText="<%$Resources:Resource,Name%>" ButtonType="LinkButton"
                                SortExpression="Name" CommandName="Facility">
                                <HeaderStyle BackColor="Transparent" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="cons_string" HeaderText="<%$Resources:Resource,ID%>" Display="false">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnAssign" runat="server" Text="<%$Resources:Resource,Assign%>" Width="100px" 
                    onclick="btnAssign_Click" />
                <asp:Button ID="btnClose" runat="server" Text="<%$Resources:Resource,Close%>" Width="100px" OnClientClick="Close();" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbl_msg" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgFacility" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>

    </form>
</body>
</html>
