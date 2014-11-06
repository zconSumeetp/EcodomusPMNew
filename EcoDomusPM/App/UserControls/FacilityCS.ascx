<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FacilityCS.ascx.cs" Inherits="App_UserControls_FacilityCS" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
<link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    .style1
    {
        font-family: Times New Roman, Times, serif;
        font-size: 18px;
    }
</style>
<style type="text/css">
.fieldsetstyle
    {
        border: 1.5px solid black;
    }
     
</style>
<script type="text/javascript">
    function Clear() {

       // document.getElementById("<%=txtSearch.ClientID %>").value = "";
        return false;

    }
   
    function setValuesAssetType() {

        document.getElementById("ContentPlaceHolder1_~/App/UserControls/AssetTypeuserControl_btnLoadAssetTypeGrid").click();

    }

</script>
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
<div >
    <div id="divFacilityList" runat="server" style="margin: 0px">
    <fieldset class="fieldsetstyle">   
        <table id="Table1" width="99%" border="0" style="table-layout: fixed;margin:05px;">
            <tr>
                <td>
                    <div class="rpbItemHeader">
                        <asp:Panel ID="panelFacility" runat="server" DefaultButton="btnSearch">
                            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                                <tr>
                                    <td align="left" class="entityImage" style="width: 50%;">
                                        <asp:Label runat="server" Text="<%$Resources:Resource,Facility%>" ID="lbl_grid_head"
                                            CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Font-Names="Arial"
                                            Font-Size="12"></asp:Label>
                                    </td>
                                    <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;
                                        width: 48%;">
                                        <div id="div_search" style="width: 200px; background-color: white;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="180px">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ClientIDMode="Static" ID="btnSearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                            OnClick="btnSearch_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td style="width: 2%;">
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                    <div>
                        <telerik:RadGrid ID="RgFacility" AllowMultiRowSelection="true" runat="server" AllowPaging="True"
                            AutoGenerateColumns="false" AllowSorting="True" PagerStyle-AlwaysVisible="true"
                            PageSize="10" OnSortCommand="RgFacility_sortcommand" OnDataBound="RgFacility_DataBound"
                            GridLines="None" Skin="Default" OnPageIndexChanged="RgFacility_pageindexchanged"
                            OnPageSizeChanged="RgFacility_OnPageSizeChanged">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                            <ClientSettings>
                                <Selecting AllowRowSelect="true" />
                                <Scrolling AllowScroll="true" ScrollHeight="280" UseStaticHeaders="true" />
                            </ClientSettings>
                            <MasterTableView ClientDataKeyNames="facility_id" DataKeyNames="facility_id">
                              <%-- <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                    <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />--%>
                                    <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                    <FooterStyle Height="25px" Font-Names="Arial" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="facility_id" Visible="false">
                                        <ItemStyle CssClass="column" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridClientSelectColumn UniqueName="GridCheckBox">
                                        <ItemStyle Width="10px" />
                                        <HeaderStyle Width="10px" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Facility_Name%>"
                                        SortExpression="Name">
                                        <ItemStyle />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
    </td> </tr>
    <%--<tr style="height:20px">    
    <td align="right" style="margin:0px 5px 5px 0px">
    <telerik:RadButton ID="btnNext" runat="server" Text="<%$Resources:Resource,Next%>" Enabled="true"
                OnClick="nextButton_Click" />
    </td>    
    </tr>--%>
    </table>
    </fieldset>
   
    </div>
     <div style="text-align:right;padding-top:2px;">
         <%--<div style="border:1px solid black; border-top:0px;width:70px;text-align:center"  >--%>
            <telerik:RadButton ID="btnNext" runat="server" Text="<%$Resources:Resource,Next%>"
                    Enabled="true" Skin="Default" BorderStyle="None" Width="100px" OnClick="nextButton_Click" />
        <%--</div>--%>
    </div>
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="organizationsManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgFacility" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RgFacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgFacility" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
</div>
<asp:HiddenField ID="hdnFacilityLoaded" runat="server" Visible="false" Value="false" />
<asp:HiddenField ID="hdnSelectedFacility" runat="server" Visible="false" />
