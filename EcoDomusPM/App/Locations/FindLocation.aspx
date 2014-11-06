<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true" CodeFile="FindLocation.aspx.cs" Inherits="App_Locations_FindLocation" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<script language="javascript" type="text/javascript">

    function Clear() {
        try {
            document.getElementById("ContentPlaceHolder1_txtcriteria").value = "";
            return false;
        }
        catch (e) {
            alert(e.message + "  " + e.Number);
            return false;
        }
    }

    function doClick(buttonName, e) {
        //the purpose of this function is to allow the enter key to 
        //point to the correct button to click.
        var key;

        if (window.event)
            key = window.event.keyCode;     //IE
        else
            key = e.which;     //firefox
        
        if (key == 13) {
            //Get the button the user wants to have clicked
            var btn = document.getElementById(buttonName);
            if (btn != null) { //If we find the button click it
                btn.click();
                event.keyCode = 0
            }
        }
    }
   function OnClientDropDownClosing(sender, eventArgs) {
        eventArgs.set_cancel(false);
    }

    function deleteLocation() {
        var flag;
        flag = confirm("Are you sure you want to delete this Location?");
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
        document.getElementById("ContentPlaceHolder1_hf_cmb_text").value = selectedItemsTexts;

        //Set the comboValue hidden field value with values of the selected Items, separated by ','.

        if (selectedItemsValues == "") {
            combo.clearSelection();
        }
    }


    function navigate_space() 
    {
        var url = "../locations/facilitymenu.aspx?pagevalue=Space Profile&id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value;
        parent.location.href(url);
        //parent.window.location.href(url);
    }

    function navigate_floor() {
        var url = "../locations/facilitymenu.aspx?pagevalue=Floor Profile&id=" + document.getElementById('ContentPlaceHolder1_hf_location_id').value;
        parent.location.href(url);
        //parent.window.location.href(url);
    }
    function navigate_zone() {
        var url = "../locations/facilitymenu.aspx?pagevalue=Zone Profile&id=" + document.getElementById("ContentPlaceHolder1_hf_location_id").value + "&name= ";
        parent.location.href(url);
    }

</script>


    <asp:updatepanel ID="updatepanel1" runat="server">
        <ContentTemplate>
          <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
<table style="margin-top:15px; margin-left:60px;" align="left">
 <caption>
 <asp:Label ID="lblFindLocation" runat="server" Text="<%$Resources:Resource,Find_Location%>"></asp:Label>
 </caption>
  <tr > <td style="height:20px"></td></tr>
  <tr>
    <td>
        <asp:Label runat="server" Text="<%$Resources:Resource,Location%>" CssClass="Label">:</asp:Label>
    </td>
    <td>
        <telerik:RadComboBox ID="cmblocation" runat="server"  Height="100px" 
            Width="170px" onselectedindexchanged="cmblocation_SelectedIndexChanged" AutoPostBack="true" ></telerik:RadComboBox>
    </td>
    <td>
        <asp:Label ID="lblfacility"  runat="server"  Text="<%$Resources:Resource,Facility%>" CssClass="Label" Visible="false"  >:</asp:Label> 
    </td>
    <td>
       <%-- <telerik:RadComboBox ID="cmbfacility" runat="server"  Height="100px" Width="175px"></telerik:RadComboBox>--%>
        <telerik:RadComboBox Width="170px" ID="cmbfacility" Filter="Contains" runat="server" oncopy="return false;" OnItemDataBound="cmbfacility_ItemDataBound"  AllowCustomText="True"
                    onpaste="return false;" oncut="return false;" onkeypress="return tabOnly(event)"
                    onmousewheel="return false" Visible="false"  >
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Text='<%# Eval("name") %>'  />
                    </ItemTemplate>
                    </telerik:RadComboBox>
      </td>
      <td>
        <asp:Label  runat="server"  Text="<%$Resources:Resource,Criteria%>" CssClass="Label" ></asp:Label> 
    </td>
    <td>
        <telerik:RadComboBox ID="cmbcriteria" runat="server"  Height="100px" Width="170px">
         <Items>
                 <telerik:RadComboBoxItem Value="Name" Text="Name" Selected="True" runat="server"
                                          Font-Size="11px" />
                 <telerik:RadComboBoxItem Value="Description" Text="Description" runat="server" Font-Size="11px" />
         </Items>
        </telerik:RadComboBox>
      </td>
      <td>
        <asp:TextBox ID="txtcriteria" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
      </td>
      <td>
            <telerik:RadButton ID="btnsearch" runat="server" Text="<%$Resources:Resource,Search%>" width="50px" OnClick="btnsearch_Click" Skin="Hay" />
             <telerik:RadButton ID="btnclear" runat="server" Text="<%$Resources:Resource,Clear%>" width="50px" OnClientClicked="Clear" Skin="Hay"/>
        </td>
  </tr>

  <tr><td style="height:20px"></td> </tr>
  
  <tr>
    <td align="center" colspan="9" >
        <telerik:RadGrid runat="server" id="rglocation" BorderWidth="1px" 
            AllowPaging="true" PageSize="10"  AutoGenerateColumns="False" AllowSorting="True"
         PagerStyle-AlwaysVisible="true" Visible="false"  
            OnPreRender="rglocation_PreRender" Skin="Hay" 
            onitemcommand="rglocation_ItemCommand" OnSortCommand="rglocation_SortCommand" OnPageIndexChanged="btnsearch_Click" 
            OnPageSizeChanged="btnsearch_Click" >
         <PagerStyle mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" />
            <MasterTableView DataKeyNames="LocationId,FacilityName,Name">
                <Columns>
                     <telerik:GridBoundColumn DataField="LocationId" HeaderText="locationId" UniqueName="locationId" Visible="False" SortExpression="LocationId">
                     </telerik:GridBoundColumn>
                     <telerik:GridTemplateColumn DataField="Name" UniqueName="name"
                     HeaderText="<%$Resources:Resource,Name%>" SortExpression="Name">
                     <ItemStyle CssClass="column" Width="200px" />
                                        <ItemTemplate>
                                            <asp:LinkButton  ID="lnkbtnName" CommandName="locationprofile" 
                                                Text='<%# DataBinder.Eval(Container.DataItem,"Name")%>' runat="server"
                                                ></asp:LinkButton >
                                         </ItemTemplate>
                       </telerik:GridTemplateColumn>

                     <telerik:GridTemplateColumn DataField="Description" UniqueName="description"
                     HeaderText="<%$Resources:Resource,Description%>" SortExpression="Description" >
                     <ItemStyle CssClass="column" Width="200px" />
                                        <ItemTemplate>
                                        <asp:Label id="lblDescription" Text='<%# DataBinder.Eval(Container.DataItem,"Description")%>' runat="server" ></asp:Label>
                                        </ItemTemplate>
                       </telerik:GridTemplateColumn>

                     <telerik:GridTemplateColumn DataField="Floor" UniqueName="floor"
                     HeaderText="<%$Resources:Resource,Floors%>" SortExpression="Floor" >
                     <ItemStyle CssClass="column" Width="250px" />
                                        <ItemTemplate>
                                            <asp:LinkButton  ID="lnkbtnFloor" CommandName="floorprofile"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"Floor")%>' runat="server"></asp:LinkButton>
                                        </ItemTemplate>
                     </telerik:GridTemplateColumn>

                     <telerik:GridTemplateColumn DataField="FacilityName" UniqueName="facility"
                     HeaderText="<%$Resources:Resource,Facility%>" SortExpression="FacilityName" >
                     <ItemStyle CssClass="column" Width="250px" />
                                        <ItemTemplate>
                                            <asp:LinkButton  ID="hlnkFacility" CommandName="facilityprofile"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"FacilityName")%>' runat="server"></asp:LinkButton>
                                       </ItemTemplate>
                       </telerik:GridTemplateColumn>

                     <telerik:GridTemplateColumn  UniqueName="remove"
                         SortExpression="Remove"  ItemStyle-HorizontalAlign="Center">
                        <ItemStyle CssClass="column" Width="100px"  />
                              <ItemTemplate >
                                        <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" runat="server"  CommandName="delete" OnClientClick="javascript:return deleteLocation();"/>
                              </ItemTemplate>
                        </telerik:GridTemplateColumn>
                     </Columns>
             </MasterTableView>
          </telerik:RadGrid>
            </td>
        </tr>
        <tr><td height="20px"></td></tr>
        <tr>
        <td colspan="8">
            <asp:Button  ID="btn_facility" runat="server"  Text="Add New Facility"  OnClick="btn_facility_click"/>
            <asp:Button ID="btn_space" runat="server" Text="Add Space" Visible="false" OnClick="btn_space_click" />
            <asp:Button ID="btn_floor" runat="server" Text="Add Floor" Visible="false" OnClick="btn_floor_click"/>
            <asp:Button  ID="btn_zone" runat="server" Text="Add Zone" Visible="false" 
                onclick="btn_zone_Click" />
            <asp:HiddenField  ID="hf_location_id" runat="server"/>
             <asp:HiddenField  ID="hf_cmb_text" runat="server"/>
        </td>
        </tr>
    </table> 
  </ContentTemplate>
  </asp:updatepanel>
</asp:Content>

