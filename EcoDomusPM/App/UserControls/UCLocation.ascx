<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCLocation.ascx.cs" Inherits="App_UserControls_UCLocation" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<script language="javascript" type="text/javascript">

    function UpdateAllLocationSpacesChildren(nodes, checked) {

        var i;
        if (checked) {
            for (i = 0; i < nodes.get_count(); i++) {
                nodes.getNode(i).check();
                if (nodes.getNode(i).get_nodes().get_count() > 0) {
                    var LevetTwoChildNodes = nodes.getNode(i).get_nodes();
                    UpdateAllLocationSpacesChildren(LevetTwoChildNodes, nodes.getNode(i).get_checked())
                }
            }
        }
        else {
            for (i = 0; i < nodes.get_count(); i++) {
                nodes.getNode(i).set_checked(false);
                if (nodes.getNode(i).get_nodes().get_count() > 0) {
                    var LevetTwoChildNodes = nodes.getNode(i).get_nodes();
                    UpdateAllLocationSpacesChildren(LevetTwoChildNodes, nodes.getNode(i).get_checked())
                }
            }
        }



    }
    function AfterLocationSpacesCheck(sender, eventArgs) {
        var childNodes = eventArgs.get_node().get_nodes();
        var isChecked = eventArgs.get_node().get_checked();

        if (childNodes.get_count() > 0) {
            UpdateAllLocationSpacesChildren(childNodes, isChecked);
        }

    }

    function AfterRootCollapsedLocation(sender, eventArgs) 
    {
        var rootNode = eventArgs.get_node();
        if (rootNode._getData().text == 'All Facilities')
         {
            if (!rootNode._expanding) 
            {
                if (document.getElementById('divLocationTree') != null) {
                    var divLocationTree = document.getElementById('divLocationTree');
                    document.getElementById('divLocationTree').style.height = "20px";
                }
                else if (document.getElementById('ContentPlaceHolder1_divLocationTree') != null) 
                {
                    var divLocationTree = document.getElementById('ContentPlaceHolder1_divLocationTree');
                    document.getElementById('divLocationTree').style.height = "20px";
                }
            }

        }
    }

    function AfterRootExpandedLocation(sender, eventArgs) {
        var rootNode = eventArgs.get_node();
            if (rootNode._getData().text == 'All Facilities') 
            {
                if (rootNode._expanding) 
                {
                    if (document.getElementById('divLocationTree') != null) 
                    {
                        var divLocationTree = document.getElementById('divLocationTree');
                        document.getElementById('divLocationTree').style.height = "200px";
                    }
                    else if (document.getElementById('ContentPlaceHolder1_divLocationTree') != null) 
                    {
                        var divLocationTree = document.getElementById('ContentPlaceHolder1_divLocationTree');
                        document.getElementById('divLocationTree').style.height = "200px";
                    }
            }

        }
    }
</script>


            <div style="width:300px" id="divLocationTree" >
            <telerik:RadTreeView ID="rtvLocationSpaces" Height="200" OnClientNodeExpanded="AfterRootExpandedLocation"  OnClientNodeCollapsed="AfterRootCollapsedLocation" OnClientNodeChecked="AfterLocationSpacesCheck"
                ViewStateMode="Enabled" Width="100%" runat="server" CheckBoxes="true" Visible="true"
                autopostback="true" MultipleSelect="true">
            </telerik:RadTreeView>
            </div>