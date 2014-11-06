<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true"
    CodeFile="Search.aspx.cs" Inherits="Reports_Search" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script language="javascript" type="text/javascript">
    function OpenFacilityProfile(facility_id) {
        //location.href = ("~/App/Settings/FacilityProfile.aspx?facility_id="+facility_id);      
        window.location.href = "../Settings/FacilityProfile.aspx?facility_id=" +facility_id;

    }
    function OpenSpaceProfile(space_id) {
             
        window.location.href = "../Asset/ComponentProfile.aspx?asset_id=" + space_id;
        //alert(space_id)
    }

</script>

    <table border="0" style="margin-left:50px; width: 90%">
        <tr>
            <td style="width:45%; vertical-align:top">
                <asp:Label ID="lbl_asset" Text="Assets" runat="server" Font-Size="Small"></asp:Label>
                <telerik:RadGrid ID="RgAssetData" runat="server" AutoGenerateColumns="False" AllowSorting="True"   
                    Width="98%" OnPageIndexChanged="RgAssetData_OnPageIndexChanged" OnPageSizeChanged="RgAssetData_OnPageSizeChanged"
                    OnSortCommand="RgAssetData_OnSortCommand" OnItemCommand="RgAssetData_OnItemCommand"
                    PagerStyle-AlwaysVisible="true" AllowPaging="true" PageSize="10" 
                    Skin="Hay">
                    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                    <MasterTableView DataKeyNames="pk_asset_id,fk_facility_id">
                        <Columns>
                            <telerik:GridBoundColumn DataField="ID" HeaderText="ID" Visible="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn DataTextField="name" HeaderText="<%$Resources:Resource,Name%>" ButtonType="LinkButton"
                                ItemStyle-Width="40%" SortExpression="name" CommandName="editassets">
                            <HeaderStyle BackColor="Transparent" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>" ItemStyle-Width="30%">
                            <HeaderStyle BackColor="Transparent" />
                            </telerik:GridBoundColumn>

                             <telerik:GridTemplateColumn UniqueName="TemplateColumn" DataField="facilityname" HeaderText="<%$Resources:Resource,Facility%>" ItemStyle-Width="30%" SortExpression="facilityname">
                                <ItemTemplate>
                                  <%-- <asp:Label ID="lbl_asset_location" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"facilityname")%>'></asp:Label>--%>
                                   <asp:LinkButton ID="linkWorkOrderName" PostBackUrl="#" runat="server" alt="Delete"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"facilityname")%>' CommandName="Edit_"/>
                                </ItemTemplate>
                                <ItemStyle Width="5px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
            <td style="width:45%;vertical-align:top;">
                <asp:Label ID="lbl_space" Text="Space" runat="server" Font-Size="Small"></asp:Label>
                <telerik:RadGrid ID="RgSpaceData" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                    Width="98%" OnPageIndexChanged="RgSpaceData_OnPageIndexChanged" OnPageSizeChanged="RgSpaceData_OnPageSizeChanged"
                    OnSortCommand="RgSpaceData_OnSortCommand" OnItemCommand="RgSpaceData_OnItemCommand"
                    PagerStyle-AlwaysVisible="true" PageSize="10" AllowPaging="true" 
                    Skin="Hay">
                    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                    <MasterTableView DataKeyNames="pk_location_id,fk_facility_id">
                        <Columns>
                            <telerik:GridBoundColumn DataField="ID" HeaderText="ID" Visible="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn DataTextField="name" HeaderText="<%$Resources:Resource,Name%>" ButtonType="LinkButton"
                                SortExpression="name" ItemStyle-Width="40%" CommandName="editspaces">
                                <HeaderStyle BackColor="Transparent" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>">
                                <HeaderStyle BackColor="Transparent" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn UniqueName="TemplateColumn" DataField="facilityname" HeaderText="<%$Resources:Resource,Facility%>" SortExpression="facilityname">
                                <ItemTemplate>
                                  <%--<asp:Label ID="lbl_unit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"facilityname")%>'> </asp:Label>--%>
                                     <asp:LinkButton ID="linkWorkOrderName" PostBackUrl="#" runat="server" alt="Delete"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"facilityname")%>' CommandName="Edit_"/>
                                </ItemTemplate>
                                <ItemStyle Width="5px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbl_msg" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>