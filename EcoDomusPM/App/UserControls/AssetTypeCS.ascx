<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AssetTypeCS.ascx.cs" Inherits="App_UserControls_AssetTypeCS" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
<link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
<style type="text/css">
  .style1
  {
  	font-family:Times New Roman, Times, serif;
  	font-size:18px
  	}  
</style>
<script type="text/javascript">
    function Clear() {

        document.getElementById("<%=txtSearch.ClientID %>").value = "";
        return false;

    }
</script>
<div style="margin: 0px 50px 50px 10px;">
    <table width="100%" style="margin: 0px 50px 0px 5px;">
        <caption>
            <asp:Label ID="lblAssetType" runat="server" Text="<%$Resources:Resource,Asset_Type%>"></asp:Label>
        </caption>
    </table>
    <div id="divAssetType" runat="server" style="margin: 0px 50px 10px 5px;">

<table id="man_serch" width="100%"  border="0" style="margin: 0px 0px 10px 0px;">
        <tr>
            <td style="margin-right: 1px">
                <asp:TextBox ID="txtSearch" runat="server" TabIndex="1" CssClass="SmallTextBox"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="<%$Resources:Resource,Search%>"
                    Width="70px" OnClick="btnSearch_Click" />
               <asp:Button ID="btnclear" runat="server" Text="<%$Resources:Resource, Clear%>" OnClientClick="javascript:return Clear();"
                        Width="70px" />
            </td>
           
        </tr>
</table>

<table border="0px" width="100%">
<tr>
    <td>
        <telerik:RadGrid ID="RgAssetType" AllowMultiRowSelection="true" runat="server" AllowPaging="True"
            AutoGenerateColumns="false" AllowSorting="True" PagerStyle-AlwaysVisible="true"
            Width="90%" PageSize="10" GridLines="None" Skin="Hay" 
            onpageindexchanged="RgAssetType_PageIndexChanged" 
            onpagesizechanged="RgAssetType_PageSizeChanged" 
            onsortcommand="RgAssetType_SortCommand"
            OnDataBound="RgAssetType_DataBound">
            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView ClientDataKeyNames="pk_standard_detail_id" DataKeyNames="pk_standard_detail_id">
                <Columns>
                    <telerik:GridBoundColumn DataField="pk_standard_detail_id" Visible="false">
                        <ItemStyle CssClass="column" />
                    </telerik:GridBoundColumn>

                    <%--Displays a Checkbox control for each item in the column.--%> 
                    <telerik:GridClientSelectColumn>
                        <ItemStyle Width="10px" />
                        <HeaderStyle Width="10px" />
                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="omniClass" HeaderText="<%$Resources:Resource,OmniClass%>">
                        <ItemStyle CssClass="column" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </td>
</tr>
</table>
</div>
<table width="80%">
    <tr>
    <td>
    </td>
    <td align="right">
    <telerik:RadButton ID="RadButton1" runat="server" Text="<%$Resources:Resource,Next%>"  Skin="Hay"
     Width="60px" OnClick="nextButton_Click" Enabled="true"/>
    </td>
    </tr>
</table>
<telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="organizationsManagerProxy" runat="server">
        <AjaxSettings>
           
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgAssetType" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Hay" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
</div>


<asp:HiddenField ID="hdnAssetTypeLoaded" runat="server" Value="false"/>


