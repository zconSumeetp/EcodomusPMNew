<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCComboAssignedTo.ascx.cs" Inherits="App_UserControls_UCComboAssignedTo" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<script language="javascript" type="text/javascript">

    function UpdateAllOrganizationUserChildren(nodes, checked) 
    {

        var i;
        if (checked)
         {
            for (i = 0; i < nodes.get_count(); i++) 
            {
                nodes.getNode(i).check();
                if (nodes.getNode(i).get_nodes().get_count() > 0)
                {
                    var LevetTwoChildNodes = nodes.getNode(i).get_nodes();
                    UpdateAllOrganizationUserChildren(LevetTwoChildNodes, nodes.getNode(i).get_checked())
                }
            }
        }
        else 
        {
            for (i = 0; i < nodes.get_count(); i++) 
            {
                nodes.getNode(i).set_checked(false);
                if (nodes.getNode(i).get_nodes().get_count() > 0)
                 {
                    var LevetTwoChildNodes = nodes.getNode(i).get_nodes();
                    UpdateAllOrganizationUserChildren(LevetTwoChildNodes, nodes.getNode(i).get_checked())
                }
            }
        }

       

    }
    function AfterOrganizationUserCheck(sender, eventArgs) 
    {
        var childNodes = eventArgs.get_node().get_nodes();
        var isChecked = eventArgs.get_node().get_checked();

        if (childNodes.get_count() > 0) 
        {
            var grandchildNodes = childNodes.getNode(0).get_nodes();
            if (grandchildNodes.get_count() > 0) 
            {
                
            }
            else 
            {
                UpdateAllOrganizationUserChildren(childNodes, isChecked);
            }
        }

    }


    function AfterRootCollapsedOrganization(sender, eventArgs) {
        var rootNode = eventArgs.get_node();
        if (rootNode._getData().text == 'Organizations') {
            if (!rootNode._expanding) {
                if (document.getElementById('divOrganizationsTree') != null) {
                    var divLocationTree = document.getElementById('divOrganizationsTree');
                    document.getElementById('divOrganizationsTree').style.height = "20px";
                }
                else if (document.getElementById('ContentPlaceHolder1_divOrganizationsTree') != null) {
                    var divLocationTree = document.getElementById('ContentPlaceHolder1_divOrganizationsTree');
                    document.getElementById('divOrganizationsTree').style.height = "20px";
                }
            }
            $get("<%=rtvOrganizationUsers.ClientID %>").style.height = "25px";
        }
    }

    function AfterRootExpandedOrganization(sender, eventArgs) {
        var rootNode = eventArgs.get_node();
        if (rootNode._getData().text == 'Organizations') {
            if (rootNode._expanding) {
                if (document.getElementById('divOrganizationsTree') != null) {
                    var divLocationTree = document.getElementById('divOrganizationsTree');
                    document.getElementById('divOrganizationsTree').style.height = "200px";
                }
                else if (document.getElementById('ContentPlaceHolder1_divOrganizationsTree') != null) {
                    var divLocationTree = document.getElementById('ContentPlaceHolder1_divOrganizationsTree');
                    document.getElementById('divOrganizationsTree').style.height = "200px";
                }
            }
            $get("<%=rtvOrganizationUsers.ClientID %>").style.height = "200px";
        }
    }
</script>


            <div style="width:300px" id="divOrganizationsTree" >
            <telerik:RadTreeView ID="rtvOrganizationUsers"  OnClientNodeExpanded="AfterRootExpandedOrganization"  OnClientNodeCollapsed="AfterRootCollapsedOrganization" OnClientNodeChecked="AfterOrganizationUserCheck"
                ViewStateMode="Enabled" Width="100%" runat="server" CheckBoxes="true" Visible="true"
                autopostback="true" MultipleSelect="true">
            </telerik:RadTreeView>
            </div>
        
