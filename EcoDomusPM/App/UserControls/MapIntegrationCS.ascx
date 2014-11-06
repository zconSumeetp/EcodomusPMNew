<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MapIntegrationCS.ascx.cs"
    Inherits="App_UserControls_MapIntegrationCS" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
<link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    function setValues() {
        document.getElementById("ContentPlaceHolder1_~/App/UserControls/AssetTypeuserControl_btnLoadAssetTypeGrid").click();
    }
</script>
<style type="text/css">
    
    .style1
    {
        font-family: Times New Roman, Times, serif;
        font-size: 16px;
    }
</style> 

<telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="organizationsManagerProxy" runat="server">
        <AjaxSettings>
           
            <telerik:AjaxSetting AjaxControlID="FACILITY">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgEntityMappingGrid" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnMap">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgEntityMappingGrid" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>


<table style="width:100%;" border="0" cellspacing="5px" class="style1">
   
            <tr>
                <td align="left" valign="top" style="width:30%">
                    <asp:Table ID="tblEntityNameList" runat="server">
                    </asp:Table>
                </td>
                <td align="left" style="width:70%" valign="top">
                    <telerik:RadGrid ID="RgEntityMappingGrid" runat="server" AllowPaging="True" Skin="Default"
                        OnItemDataBound="OnItemDataBound_rgClient" AllowSorting="True" AutoGenerateColumns="False"
                        Width="100%" Visible="true" PagerStyle-AlwaysVisible="true" PageSize="10" OnPageIndexChanged="RgEntityMappingGrid_pageindexchanged"
                        OnPageSizeChanged="RgEntityMappingGrid_OnPageSizeChanged" OnDataBound="RgEntityMappingGrid_OnDataBound">
                        <MasterTableView DataKeyNames="TypeId">
                            <Columns>
                                <telerik:GridBoundColumn DataField="TypeId" Display="false" SortExpression="ID" UniqueName="FacilityName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TypeValue" ItemStyle-Width="50%" Display="true"
                                    SortExpression="TypeValue" UniqueName="TypeValue">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource,External_System%>"
                                    EditFormColumnIndex="0" SortExpression="">
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="cmbExternalSystem" runat="server" Width="250px" ExpandDirection="Down"
                                            ZIndex="100" IsEditable="True" IsReadOnly="True" AllowCustomText="false" Filter="Contains">
                                        </telerik:RadComboBox>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="column" Width="100px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 30%">
                </td>
                <td align="right" valign="top">
                    <telerik:RadButton ID="btnMap" runat="server" Text="<%$Resources:Resource,Map%>"
                        Width="60px" Skin="Default" OnClick="save_mapped_record" Enabled="true" Font-Names="Times New Roman"
                        Font-Size="Medium" Visible="false" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <asp:Label ID="lblMapMsg" runat="server" ForeColor="Red" CssClass="LabelText"></asp:Label>
                </td>
            </tr>
        
    <tr>
        <td>
        </td>
        <td align="right">
            <telerik:RadButton ID="btnNext" runat="server" Text="<%$Resources:Resource,Next%>"
                Width="60px" Skin="Default" OnClick="btnNext_Click" Enabled="true" Font-Names="Times New Roman"
                Font-Size="Medium" />
        </td>
    </tr>
</table>

<asp:HiddenField ID="hdnTableName" runat="server" Visible="False" />
<asp:HiddenField ID="hdnEntityCode" runat="server" Visible="False" />
<asp:HiddenField ID="hdnEntityName" runat="server" Visible="false" />
<asp:HiddenField ID="FacilityLoaded" runat="server" Value="false" 
    Visible="False" />



