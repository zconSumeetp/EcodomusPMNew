<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true"
    CodeFile="AssetConditionReport.aspx.cs" Inherits="App_Reports_AssetConditionReport" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="../UserControls/UCComboFacility.ascx" TagName="UCComboFacility" TagPrefix="uc1" %>
 <%@ Register TagPrefix="telerik" Namespace="Telerik.Charting" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript" >
    function checkboxClick(sender) {

        collectSelectedItems(sender);
    }
    function Clear() {
        try {
            document.getElementById("txtcriteria").value = "";
            return false;
        }
        catch (e) {
            alert(e.message + "  " + e.Number);
            return false;
        }
    }

    function gotoPage(id, pagename) {
        var url;
        if (pagename == "Asset") {
            url = "AssetMenu.aspx?assetid=" + id + "&pagevalue=AssetProfile";
        }
        else if (pagename == "Type") {
            url = "TypeProfileMenu.aspx?type_id=" + id;
            //alert("Page Under Construction");
            //return false;
        }

        top.location.href(url);
    }

    function OnClientDropDownClosing(sender, eventArgs) {
        eventArgs.set_cancel(false);
    }

    function deleteLocation() {
        var flag;
        flag = confirm("Do you want to UnAssign this Asset?");
        return flag;
    }

    function checkboxClick(sender) {

        collectSelectedItems(sender);
    }

    function getItemCheckBox(item) {
        //Get the 'div' representing the current RadComboBox Item.
        var itemDiv = item.get_element();

        //Get the collection of all 'input' elements in the 'div' (which are contained in the Item).
        var inputs = itemDiv.getElementsByTagName("input");

        for (var inputIndex = 0; inputIndex < inputs.length; inputIndex++) {
            var input = inputs[inputIndex];

            //Check the type of the current 'input' element.
            if (input.type == "checkbox") {
                return input;
            }
        }

        return null;
    }

    function collectSelectedItems(sender) {
        var combo = $find(sender);
        var items = combo.get_items();

        var selectedItemsTexts = "";
        var selectedItemsValues = "";

        var itemsCount = items.get_count();

        for (var itemIndex = 0; itemIndex < itemsCount; itemIndex++) {
            var item = items.getItem(itemIndex);

            var checkbox = getItemCheckBox(item);

            //Check whether the Item's CheckBox) is checked.
            if (checkbox.checked) {
                selectedItemsTexts += item.get_text() + ", ";
                selectedItemsValues += item.get_value() + ", ";
            }
        }

        selectedItemsTexts = selectedItemsTexts.substring(0, selectedItemsTexts.length - 2);
        selectedItemsValues = selectedItemsValues.substring(0, selectedItemsValues.length - 2);

        //Set the text of the RadComboBox with the texts of the selected Items, separated by ','.
        combo.set_text(selectedItemsTexts);

        //Set the comboValue hidden field value with values of the selected Items, separated by ','.

        if (selectedItemsValues == "") {
            combo.clearSelection();
        }
    }


</script>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <table style="margin-left: 80px;">
        <caption>
            <asp:Label ID="lblAssetConditionReport" runat="server" Text="<%$Resources:Resource,Asset_Condition_Report%>">:</asp:Label>
        </caption>
        <telerik:RadFormDecorator ID="rdfReport" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
        <tr>
            <td style="height: 20px">
            </td>
        </tr>
        <tr>
            <td style="width: 10px">
                <asp:Label ID="lblfacility" runat="server" Text="<%$Resources:Resource,Facility%>"
                    CssClass="Label">:</asp:Label>
            </td>
            <td>
                <%-- <telerik:RadComboBox ID="cmbfacility" runat="server"  Height="100px" Width="175px"></telerik:RadComboBox>--%>
                <telerik:RadComboBox Width="170px" ID="cmbfacility" Filter="Contains" runat="server"
                    oncopy="return false;" OnItemDataBound="cmbfacility_ItemDataBound" AllowCustomText="True"
                    onpaste="return false;" oncut="return false;" onkeypress="return tabOnly(event)"
                    onmousewheel="return false">
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Text='<%# Eval("name") %>' />
                    </ItemTemplate>
                </telerik:RadComboBox>
            </td>
             <td> <asp:HiddenField ID="hfFacilityid" runat="server" /></td>
             <td><asp:Button ID="btn_Generate_Report" runat="server" Text="Generate Report" OnClick="btnGenerateReport_Click"  /></td>
        </tr>
    </table>

     <table style="margin-left: 80px; margin-top: 15px;" align="left" width="100%" border="0">
        <tr>
            <td valign="top">
                <telerik:RadGrid ID="rgConditionReport" runat="server" AllowFilteringByColumn="True"
                    AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" PageSize="10"
                    PagerStyle-Visible="true" GridLines="None" AllowPaging="True" OnPageIndexChanged="rgConditionReport_PageIndexChanged"
                    OnSortCommand="rgConditionReport_SortCommand" Skin="Hay" OnItemCommand="rgConditionReport_ItemCommand">
                    <GroupingSettings CaseSensitive="false" />
                    <MasterTableView DataKeyNames="pk_asset_id">
                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                        <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <Columns>
                            <%--<telerik:GridBoundColumn DataField="name" FilterControlAltText="Filter name column"
                                HeaderText="Asset Name" UniqueName="name" AutoPostBackOnFilter="false" CurrentFilterFunction="EqualTo">
                            </telerik:GridBoundColumn>--%>

                               <telerik:GridTemplateColumn DataField="name" HeaderText="Asset Name" SortExpression="name">
                                <ItemStyle CssClass="column" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="linkAssetName" PostBackUrl="#" runat="server" alt="Delete"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"name")%>' CommandName="Edit_"/>
                                    </ItemTemplate>
                            </telerik:GridTemplateColumn>


                            <telerik:GridBoundColumn DataField="Facility_name" FilterControlAltText="Filter Facility_name column"
                                HeaderText="Facility" UniqueName="Facility_name" AutoPostBackOnFilter="false"
                                CurrentFilterFunction="EqualTo">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="value" FilterControlAltText="Filter value column"
                                HeaderText="Condition" UniqueName="value" AutoPostBackOnFilter="false" CurrentFilterFunction="EqualTo">
                            </telerik:GridBoundColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                            </EditColumn>
                        </EditFormSettings>
                        <PagerStyle AlwaysVisible="True" />
                    </MasterTableView>
                    <PagerStyle AlwaysVisible="True" />
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                    </HeaderContextMenu>
                </telerik:RadGrid>
            </td>
            <td>
                <telerik:RadChart ID="RadChart2" runat="server" DefaultType="Pie" Width="500px" AutoTextWrap="true"
                    OnItemDataBound="RadChart2_ItemDataBound" ChartTitle-TextBlock-Text="Asset Condition Report"
                    Height="300px">
                    <Appearance Dimensions-Width="500px">
                    </Appearance>
                    <Series>
                        <telerik:ChartSeries Name="Series 1" Type="Pie" DataYColumn="Counts">
                            <Appearance LegendDisplayMode="ItemLabels">
                            </Appearance>
                        </telerik:ChartSeries>
                    </Series>
                </telerik:RadChart>
            </td>
        </tr>
    </table>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
