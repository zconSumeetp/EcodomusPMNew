<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectedPhase.aspx.cs" Inherits="App_Settings_SelectedPhase" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<script type="text/javascript">
    window.onload = body_load;
    function body_load() {
        var td =  document.getElementById("<%= td_tree.ClientID %>");
        var pageSize = document.getElementById("<%= hfPageSize.ClientID %>").value;
        var height = (parseInt(pageSize) * 35) + "px";
        
        td.style.height = height;
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
    function RequestMessage(flag) {
        // debugger
        if (flag == 0)
            alert("File has been exported.");

    }
    var g;
    function onExpand(e) {

        var docheight = document.body.scrollHeight;
        var t = parent.document.getElementById('frameSettingsMenu').style.height;
        g = docheight;
        var docheight = document.body.scrollHeight;
        if (docheight <= 400) {
            parent.document.getElementById('frameSettingsMenu').style.height = 600;
        }
        else {
            parent.document.getElementById('frameSettingsMenu').style.height = docheight;

        }


    }

    function onExpanded(e) {

        var docheight = document.body.scrollHeight;
        var t = parent.document.getElementById('frameSettingsMenu').style.height;
        if (docheight <= 100) {
            parent.document.getElementById('frameSettingsMenu').style.height = g;
        }
        else {

            parent.document.getElementById('frameSettingsMenu').style.height = docheight + 400;

        }



    }
</script>
<html>
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
</head>
<body style="background: transparent; background-image: url('../Images/asset_zebra-bkgrd_gray2.PNG');
    padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server">
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
    <div>
        <table style="margin: 15px 50px 0px 0px; width: 95%" border="0">
            <caption>
             <asp:Label ID="lblcaption" runat="server" Text="<%$Resources:Resource,COBie_QualityControl%>"></asp:Label>
          
                    <asp:Label ID="lblphaseName" runat="server" Text=""></asp:Label>
            </caption>
            <tr>
                <td id="td_tree" runat="server">
                    <telerik:RadTreeView ID="rtvsheetnames" runat="server" CheckBoxes="true" MultipleSelect="true"
                        OnClientNodeChecked="AfterCheck" IsSingleExpandPath="true" IsExpanded="true"
                        autopostback="true" OnClientNodeExpanded="onExpanded" OnClientNodeCollapsed="onExpand"
                        Height="100%" PersistLoadOnDemandNodes="true">
                    </telerik:RadTreeView>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnSave" runat="server" Width="70px" Text="<%$Resources:Resource,Save%>"
                        OnClick="btnSave_Click" />
                    <%--</td>
  <td align="left">--%>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblsavemsg" runat="server" Text="" ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hfphaseid" runat="server" />
        <asp:HiddenField ID="hforganization_id" runat="server" />
        <asp:HiddenField ID="hfPageSize" runat="server" Value="" />
        
    </div>
    </form>
</body>
</html>
