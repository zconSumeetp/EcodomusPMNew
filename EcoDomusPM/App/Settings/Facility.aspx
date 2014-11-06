<%@ Page Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true" CodeFile="Facility.aspx.cs" Inherits="App_ProjectData_Facility" Title="Project Facility" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       
       <table style="margin-top:15px; margin-left:50px;">
        <tr>
        <td style="height:20px; vertical-align:bottom">
        <h1>
        <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Facility%>"></asp:Label>
         
        </h1>     
        </td>
        </tr>
        <tr>
            <td style="margin-top: 4px">
                <telerik:radgrid id="rgFacility" runat="server" allowpaging="True" skin="Forest"
                    width="350px" allowsorting="True" autogeneratecolumns="False" pagerstyle-alwaysvisible="true"
                    onsortcommand="rgFacility_OnSortCommand" onpageindexchanged="rgFacility_PageIndexChanged"
                    onpagesizechanged="rgFacility_PageSizeChanged" 
                    onitemcommand="rgFacility_ItemCommand">
                <PagerStyle HorizontalAlign="Right" Mode="NextPrevAndNumeric" />
                <MasterTableView DataKeyNames="ID">
                    <Columns>
                        <telerik:GridBoundColumn DataField="ID" HeaderText="<%$Resources:Resource,ID%>" Display="false" SortExpression="ID"
                            UniqueName="ID">
                        </telerik:GridBoundColumn>
                         <telerik:GridButtonColumn DataTextField="name" HeaderText="<%$Resources:Resource,Name%>" ButtonType="LinkButton"
                                 SortExpression="name" CommandName="EditFacility">
                                     <HeaderStyle BackColor="Transparent" />
                            </telerik:GridButtonColumn>
                        <telerik:GridBoundColumn DataField="DESC1" HeaderText="<%$Resources:Resource,Description%>" UniqueName="DESC1">
                           <HeaderStyle HorizontalAlign="Left" BackColor="Transparent" />
                             <ItemStyle HorizontalAlign="Left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField=" org_name" HeaderText="<%$Resources:Resource,Organization%>" UniqueName="org_name">
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Left" BackColor="Transparent" />
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:radgrid>
            </td>
    </tr>
    <tr>
    <td>
    <asp:Label ID="lblMessage" runat="server"> </asp:Label>
    </td>
    </tr>
    </table>

     <telerik:RadAjaxManager ID="Ajax_manager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgFacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgFacility" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            </AjaxSettings>
            </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Hay" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>

