<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ComponentReportExport.ascx.cs" Inherits="App_COBIE_ComponentReportExport" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Hay" DecoratedControls="Buttons" />
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
<script type="text/javascript">
    function ProjectValidation() {

        alert('Please select Project');
        window.location = '../Settings/Project.aspx';
        return false;

    }
    function checkboxClick(sender) {

        collectSelectedItems(sender);

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
        }  //for closed

        selectedItemsTexts = selectedItemsTexts.substring(0, selectedItemsTexts.length - 2);
        selectedItemsValues = selectedItemsValues.substring(0, selectedItemsValues.length - 2);

        //Set the text of the RadComboBox with the texts of the selected Items, separated by ','.
        combo.set_text(selectedItemsTexts);

        //Set the comboValue hidden field value with values of the selected Items, separated by ','.

        if (selectedItemsValues == "") {
            combo.clearSelection();
        }
        //document.getElementById('ContentPlaceHolder1_hfFacilityid').value = selectedItemsValues;   
    }
    function AfterCheck(sender, eventArgs) {
        var childNodes = eventArgs.get_node().get_nodes();
        var isChecked = eventArgs.get_node().get_checked();
        UpdateAllChildren(childNodes, isChecked);
    }
    function UpdateAllChildren(nodes, checked) {
        var i;
        for (i = 0; i < nodes.get_count(); i++) {
            if (checked) {
                nodes.getNode(i).check();
            }
            else {
                nodes.getNode(i).set_checked(false);
            }

            if (nodes.getNode(i).get_nodes().get_count() > 0) {
                UpdateAllChildren(nodes.getNode(i).get_nodes(), checked);
            }
        }
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
    function deleteRequest() {
        var flag;
        flag = confirm("Do you want to delete file ?");
        return flag;
    }
    function RequestMessage(flag) {
       // debugger
        if (flag == 0)
            alert("File is getting exported. Please wait.");
        else if (flag == 1)
            alert("Please Select facility!");
        else
            alert("Please Select Organization!");
    }
</script>
<div>
    <table style="margin: 15px 50px 0px 0px; width: 35%" border="0">
        <caption style="width:100%;">
            <asp:Label ID="Label2" runat="server" Width="100%" Text="<%$Resources:Resource, Generate_Component_Analysis_Report%>"></asp:Label>
        </caption>
        <tr>
            <td style="width: 60px" colspan="2">
                <asp:Label ID="lblfacility" runat="server" Text="<%$Resources:Resource, Facility%>"
                    CssClass="Label"></asp:Label>
                :
            </td>
            <td>
                <telerik:RadComboBox Width="170px" ID="cmbfacility" Filter="Contains" runat="server"
                    oncopy="return false;" OnItemDataBound="cmbfacility_ItemDataBound" AllowCustomText="True"
                    onpaste="return false;" oncut="return false;" onkeypress="return tabOnly(event)"
                    onmousewheel="return false">
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Text='<%# Eval("name") %>' />
                    </ItemTemplate>
                </telerik:RadComboBox>
            </td>
        </tr>
    </table>
    <table style="margin: 15px 50px 0px 0px; width: 23%" border="0">
        <tr>
            <td>
                <telerik:RadTreeView ID="rtvtypeorgfilters" runat="server" CheckBoxes="true" autopostback="true"
                    OnDataBinding="rtvtypeorgfilters_OnDataBinding" Visible="true" MultipleSelect="true"
                    OnClientNodeChecked="AfterCheck" DataFieldID="Id" DataValueField="Id" DataFieldParentID="ParentId"
                    DataTextField="Name">
                </telerik:RadTreeView>
                <asp:Timer ID="Timer1" Interval="5000" OnTick="Timer1_click" runat="server">
                </asp:Timer>
            </td>
        </tr>
        <tr>
            
            <td>
           
              <asp:Button ID="btnGenerateComponentAnalysisReport" runat="server" Text="<%$Resources:Resource,Generate_Component_Analysis_Report%>"
              Width="43%" Skin="Hay" OnClick="btnGenerateComponentAnalysisReport_Click" />
               
           </td>
                
            
        </tr>
    </table>
    <table style="margin: 15px 50px 0px 0px; width: 23%" border="0">
        <tr>
            <td style="width: 114px" colspan="2">
                <telerik:RadGrid ID="rgexportedfiles" runat="server" AllowPaging="True" Skin="Hay"
                    Width="650px" AllowSorting="True" AutoGenerateColumns="false" CellSpacing="0"
                    GridLines="None" AllowMultiRowSelection="True" OnDataBinding="rgexportedfiles_DataBinding"
                    OnItemCommand="rgexportedfiles_ItemCommand" OnNeedDataSource="rgexportedfiles_NeedDataSource">
                    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" AlwaysVisible="true" />
                    <ClientSettings>
                        <Selecting AllowRowSelect="true" />
                    </ClientSettings>
                    <MasterTableView DataKeyNames="pk_request_id">
                        <Columns>
                            <telerik:GridBoundColumn DataField="FileName" HeaderText="<%$Resources:Resource,File_Name%>" 
                                UniqueName="File Name" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ExportedOn" HeaderText="<%$Resources:Resource,ExportedOn%>"
                                UniqueName="Exported On" ItemStyle-Wrap="false" HeaderStyle-Wrap="false" DataFormatString="{0:MM/dd/yy hh:mm tt}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ExportedBy" HeaderText="<%$Resources:Resource,ExportedBy%>"
                                UniqueName="Exported By" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                            </telerik:GridBoundColumn>
                              <telerik:GridBoundColumn DataField="status"    HeaderText="<%$Resources:Resource,Status%>"   
                              UniqueName="Status" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="filesize" HeaderText="<%$Resources:Resource,filesize%>"
                                UniqueName="File Size" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="filepath" UniqueName="filepath" HeaderText="<%$Resources:Resource,filepath%>" 
                            ItemStyle-Wrap="false"  Visible="true" HeaderStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_filepath" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"filepath")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="imgbtnDelete_" HeaderText="<%$Resources:Resource,Delete%>" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                                <ItemStyle CssClass="column" Width="5%" />
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" OnClientClick="javascript:return deleteRequest();"
                                        CommandName="Deletefile" ImageUrl="~/App/Images/Delete.gif" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <telerik:RadAjaxManagerProxy ID="radAjaxmager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Timer1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgexportedfiles" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel Skin="Forest" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
</div>
