<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCComboFacility.ascx.cs" Inherits="App_UserControls_UserControlComboFacility" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<script language="javascript" type="text/javascript">

    function UpdateAllChildren(nodes, checked, cmbfacility, varHiddenFacilitiesList) {
        cmbfacility.set_text("");
        varHiddenFacilitiesList.value = "";
        var i;
        if (checked) {
            cmbfacility.set_text("All Facilities");

            for (i = 0; i < nodes.get_count(); i++) {
                nodes.getNode(i).check();
                if (cmbfacility._text == "") {
                    varHiddenFacilitiesList.value = nodes.getNode(i).get_text();
                }
                else {
                    varHiddenFacilitiesList.value += ',' + nodes.getNode(i).get_text();
                }
            }
        }
        else {
            cmbfacility.set_text("");
            varHiddenFacilitiesList.value = "";
            for (i = 0; i < nodes.get_count(); i++) {
                nodes.getNode(i).set_checked(false);
                varHiddenFacilitiesList.value = "";
            }
        }

    }
    function AfterCheck(sender, eventArgs) {
       
        var cmbfacility = $find("<%=cmbFacility.ClientID%>");
        var varFacilitiesList = $find("<%=FacilitiesList.ClientID%>");
        var strcmbfacility = cmbfacility._uniqueId;
        var hiddenFieldId = strcmbfacility.replace("cmbFacility", "FacilitiesList");

        var varHiddenFacilitiesList = document.getElementById(hiddenFieldId);

        var childNodes = eventArgs.get_node().get_nodes();
        var isChecked = eventArgs.get_node().get_checked();

        if (childNodes.get_count() > 0) {
            UpdateAllChildren(childNodes, isChecked, cmbfacility, varHiddenFacilitiesList);
        }
        else {
            if (isChecked) {

                if (cmbfacility._text == "") {
                    cmbfacility.set_text(eventArgs.get_node().get_text());
                    varHiddenFacilitiesList.value = eventArgs.get_node().get_text();
                }
                else {
                    cmbfacility.set_text(cmbfacility._text + ',' + eventArgs.get_node().get_text());
                    varHiddenFacilitiesList.value += ',' + eventArgs.get_node().get_text();
                }
            }
            else {

                var strToBeReplaced = eventArgs.get_node().get_text();
                var strOriginal = varHiddenFacilitiesList.value;

                if (strOriginal.match(strToBeReplaced + ",") != null) {
                    strOriginal = strOriginal.replace(strToBeReplaced + ",", "");
                }
                else if (strOriginal.match("," + strToBeReplaced) != null) {
                    strOriginal = strOriginal.replace("," + strToBeReplaced, "");
                }
                else {
                    strOriginal = strOriginal.replace(strToBeReplaced, "");
                }
                if (strOriginal.charAt(0) == ",") {
                    strOriginal = strOriginal.slice(1);
                }
                cmbfacility.set_text(strOriginal);
                varHiddenFacilitiesList.value = strOriginal;
            }
        }
    }
</script>

<table>
  
    <tr>
        <td>
           
            <telerik:RadComboBox Width="170px" ID="cmbFacility" ViewStateMode="Enabled" Filter="Contains"
                runat="server" oncopy="return false;" AllowCustomText="True" onpaste="return false;"
                oncut="return false;" onmousewheel="return false" Visible="true" >
                <ItemTemplate>
                    <telerik:RadTreeView ID="rtvFacilities" Height="200"   OnClientNodeChecked="AfterCheck"
                         ViewStateMode="Enabled" Width="100%" runat="server"
                        CheckBoxes="true" Visible="true" autopostback="true" MultipleSelect="true">
                    </telerik:RadTreeView>
                </ItemTemplate>
            </telerik:RadComboBox>
           
        </td>
        
        <td style="width:1px">
            <asp:HiddenField   ID="FacilitiesList" Value="" EnableViewState="true" runat="server" />
            
        </td>
       
    </tr>
    
</table>
