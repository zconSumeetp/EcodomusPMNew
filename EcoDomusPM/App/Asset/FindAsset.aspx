<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true" CodeFile="FindAsset.aspx.cs" Inherits="App_Asset_FindAsset"  %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<script language="javascript" type="text/javascript" >

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

    function gotoPage(id,pagename) {
        var url;
        if (pagename == "Asset") {
            url = "AssetMenu.aspx?assetid=" + id;//  + "&pagevalue=AssetProfile";
        }
        else if (pagename == "Type") {
            url = "TypeProfileMenu.aspx?type_id=" + id ;
            //alert("Page Under Construction");
        }
        else if (pagename == "Facility") {
            url = "../Locations/FacilityMenu.aspx?FacilityId=" + id;

        }
        else if (pagename == "System") {
            url = "SystemMenu.aspx?system_id="+ id ;

        }
        else if (pagename == "Space") {
            url = "../Locations/FacilityMenu.aspx?pagevalue=Space Profile&id="+ id ;

        }

        window.location.href(url);
    }

    function OnClientDropDownClosing(sender, eventArgs) {
        eventArgs.set_cancel(false);
    }

    function deleteLocation() {
        var flag;
        flag = confirm("If the asset is deleted, then attributes, documents, work orders related to this asset also will be deleted. Are you sure you want to delete this Asset?");
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

   <%-- <asp:updatepanel runat="server" ID="updatepanel1" >--%>
    <ContentTemplate>
 
<table style="margin: 15px 50px 50px 50px; width: 95%">
  <caption>
  <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,Find_Asset%>"></asp:Label>:
  </caption>
  <tr><td style="height:20px"></td></tr>
  <tr>
    <td>
        <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Search_By%>" CssClass="Label"></asp:Label>:
    </td>
    <td>
        <telerik:RadComboBox ID="cmblocation" runat="server"  Height="100px" 
            Width="170px"  AutoPostBack="true" ></telerik:RadComboBox>
    </td>
    <td>
        <asp:Label ID="lblfacility"  runat="server"  Text="<%$Resources:Resource,Facility%>" CssClass="Label" ></asp:Label>:
    </td>
    <td>
       <%-- <telerik:RadComboBox ID="cmbfacility" runat="server"  Height="100px" Width="175px"></telerik:RadComboBox>--%>
        <telerik:RadComboBox Width="170px" ID="cmbfacility" Filter="Contains" runat="server" oncopy="return false;" OnItemDataBound="cmbfacility_ItemDataBound" AllowCustomText="True"
                    onpaste="return false;" oncut="return false;" onkeypress="return tabOnly(event)"
                    onmousewheel="return false" >
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Text='<%# Eval("name") %>'  />
                    </ItemTemplate>
        </telerik:RadComboBox>
      </td>
      <td>
        <asp:Label ID="Label2"  runat="server"  Text="<%$Resources:Resource,Criteria%>" CssClass="Label" ></asp:Label>: 
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
            <telerik:RadButton ID="btnsearch" runat="server" Text="<%$Resources:Resource,Search%>" width="50px"  Skin="Hay" OnClick="btnsearch_Click" />
             <telerik:RadButton ID="btnclear" runat="server" Text="<%$Resources:Resource,Clear%>" width="50px"  Skin="Hay" OnClientClicked="Clear"/>
        </td>
  </tr>
  <tr><td style="height:20px"></td> </tr>
  <tr>
    <td align="center" colspan="9" >
        <telerik:RadGrid runat="server" id="rgasset" BorderWidth="1px" 
            AllowPaging="true" PageSize="10"  AutoGenerateColumns="False" AllowSorting="True"
            PagerStyle-AlwaysVisible="false" Visible="false"  
             Skin="Hay" onitemcommand="rgasset_ItemCommand"
            OnSortCommand="btnsearch_Click" OnPageIndexChanged="btnsearch_Click" 
            OnPageSizeChanged="btnsearch_Click"  >
         <PagerStyle mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" AlwaysVisible="true"  />
            <MasterTableView DataKeyNames="Assetid">
                <Columns>

                    <telerik:GridBoundColumn DataField="Assetid" HeaderText="AssetId" UniqueName="AssetId" Visible="false" SortExpression="Assetid">
                    </telerik:GridBoundColumn>

                    <%--<telerik:GridTemplateColumn DataField="Asset_Name" HeaderText="AssetName" UniqueName="AssetName" SortExpression="Asset_Name">
                        <ItemStyle CssClass="column" Width="200" />
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkassetname" CommandName="AssetProfile"
                                     Text='<%# DataBinder.Eval(Container.DataItem,"Asset_Name") %>' runat="server" >
                                </asp:LinkButton>
                            </ItemTemplate>
                    </telerik:GridTemplateColumn>--%>

                    <telerik:GridBoundColumn DataField="linkasset" HeaderText="<%$Resources:Resource,Asset_Name%>" UniqueName="linkasset" SortExpression="Asset_Name" >
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="Space_Name" HeaderText="<%$Resources:Resource,Location%>" UniqueName="Location"  >
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="Asset_Description" HeaderText="<%$Resources:Resource,Description%>" UniqueName="Description" SortExpression="Asset_Description">
                    </telerik:GridBoundColumn>

            <%--        <telerik:GridTemplateColumn DataField="Type_Name" HeaderText="Type" UniqueName="Type" SortExpression="Type_Name">
                        <ItemStyle CssClass="column" Width="200" />
                            <ItemTemplate>
                                <asp:LinkButton ID="lnktype" CommandName="TypeProfile"
                                     Text='<%# DataBinder.Eval(Container.DataItem,"Type_Name") %>' runat="server" >
                                </asp:LinkButton>
                            </ItemTemplate>
                    </telerik:GridTemplateColumn>--%>

                    <telerik:GridBoundColumn DataField="linktype" HeaderText="<%$Resources:Resource,Type%>" UniqueName="linktype" SortExpression="Type_Name" >
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="System_Name" HeaderText="<%$Resources:Resource,System%>" UniqueName="System"  >
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="linkfacility" HeaderText="<%$Resources:Resource,Facility%>" UniqueName="Facility" SortExpression="Facility_Name" >
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn  UniqueName="remove"
                             SortExpression="Remove"  ItemStyle-HorizontalAlign="Center">
                        <ItemStyle CssClass="column" Width="100px"  />
                              <ItemTemplate >
                                        <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" runat="server"  CommandName="delete" OnClientClick="javascript:return deleteLocation();" />
                              </ItemTemplate>
                    </telerik:GridTemplateColumn>

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </td>
  </tr>

  <tr><td style="height:20px"></td> </tr>

  <tr>
        <td>
            <telerik:RadButton ID ="btnaddasset" runat ="server" Skin="Hay" 
                Text="<%$Resources:Resource,Add_Asset%>" onclick="btnaddasset_Click"  />
        </td>
  </tr>
  <tr>
  <td> <asp:HiddenField ID="hfFacilityid" runat="server" /></td>
  </tr>
</table> 
</ContentTemplate>
<%--</asp:updatepanel>--%>

<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgasset">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgasset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>


 
</asp:Content>


