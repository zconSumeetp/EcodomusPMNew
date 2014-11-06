<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AttributeMappingCS.ascx.cs" Inherits="App_UserControls_AttributeMappingCS" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
<style type="text/css">
.fieldsetstyle
    {
        border: 1.5px solid black;
    }
     
</style>

<fieldset class="fieldsetstyle">

<div class="rpbItemHeader" style="padding:07px; ">
    <asp:Panel ID="panelAttribute" runat="server" DefaultButton="btnSearch">
        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
            <tr style="padding:05px;">
                <td align="left" class="entityImage" style="width: 50%;">
                    <asp:Label runat="server" Text="<%$Resources:Resource,Attributes%>" ID="lbl_grid_head"
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
                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearchAM" Width="180px">
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
            <tr>
            <td class="" colspan="3">
                <div id="dv_mapping_grid" style="width: 100%" align="center">
    <telerik:RadGrid ID="rgAttributes" runat="server" BorderWidth="1px" CellPadding="0"
        GridLines="None" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="False"
        PagerStyle-AlwaysVisible="true" Skin="Default" ItemStyle-Wrap="false" AllowMultiRowSelection="true"
        OnPageIndexChanged="rgAttributes_OnPageIndexChanged" OnPageSizeChanged="rgAttributes_PageSizeChanged"
        OnItemDataBound="rgAttributes_ItemDataBound" OnDataBound="rgAttributes_DataBound">
        <PagerStyle Mode="NextPrevAndNumeric" />
        <ClientSettings>
            <Resizing AllowColumnResize="true" AllowRowResize="false" ResizeGridOnColumnResize="false"
                ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="325" />
                
        </ClientSettings>
        <MasterTableView EditMode="EditForms" DataKeyNames="TypeId,attribute_group" ClientDataKeyNames="TypeId"
            GroupLoadMode="Client">
            <GroupByExpressions>
                <telerik:GridGroupByExpression>
                    <SelectFields>
                        <telerik:GridGroupByField FieldAlias="attribute_group" FieldName="attribute_group" FormatString="" HeaderText=""
                            SortOrder="None"></telerik:GridGroupByField>
                    </SelectFields>
                    <GroupByFields>
                        <telerik:GridGroupByField FieldName="attribute_group"></telerik:GridGroupByField>
                    </GroupByFields>
                </telerik:GridGroupByExpression>
            </GroupByExpressions>
            <Columns>
                <telerik:GridBoundColumn DataField="TypeId" Display="false" SortExpression="ID" UniqueName="TypeId">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="attribute_group" Display="false" SortExpression="ID" UniqueName="attribute_group">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TypeValue" HeaderText="<%$Resources:Resource,External_System%>"
                    EditFormColumnIndex="0" SortExpression="Name">
                    <ItemStyle   Wrap="false" />
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource,Name%>" EditFormColumnIndex="0"
                    SortExpression="">
                    <ItemTemplate>
                        <telerik:RadComboBox ID="cmbExternalSystem" runat="server" Width="250px" ExpandDirection="Down"
                            ZIndex="100" IsEditable="True" IsReadOnly="True" AllowCustomText="false" Filter="Contains">
                            <Items>
                            </Items>
                        </telerik:RadComboBox>
                    </ItemTemplate>
                    <ItemStyle   Width="100px" />
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
        <ValidationSettings CommandsToValidate="Update" />
        <ClientSettings AllowColumnsReorder="true" ReorderColumnsOnClient="true">
            <Resizing ResizeGridOnColumnResize="True" AllowResizeToFit="true"></Resizing>
        </ClientSettings> 
        <AlternatingItemStyle CssClass="alternateColor" />
    </telerik:RadGrid>
</div>
            </td>
            </tr>
        </table>
    </asp:Panel>
  </div>  
</fieldset>

<div style="text-align:right;padding-top:2px;">
<div style="float: left">
 <asp:Label ID="lblMapMsg" runat="server" ForeColor="Red" CssClass="LabelText Msg"></asp:Label>
</div>
<div style="float: right ; padding-left:3px;" >
    <telerik:RadButton ID="btnNext" Width="100px" runat="server" Text="<%$Resources:Resource,Next%>"
        Skin="Default" OnClick="btnNext_Click" 
         />
</div>
<div style="float: right;">
    <telerik:RadButton ID="btn_map" Width="100px" runat="server" Text="<%$Resources:Resource,Map%>"
        OnClick="btn_map_Click">
    </telerik:RadButton>
</div>

</div>



<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rgAttributes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rgAttributes" LoadingPanelID="loadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnSearch">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rgAttributes" LoadingPanelID="loadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
    Skin="Default">
</telerik:RadAjaxLoadingPanel>

<asp:HiddenField ID="hf_attribute_loaded" runat="server" Value="false" 
    Visible="False" />
