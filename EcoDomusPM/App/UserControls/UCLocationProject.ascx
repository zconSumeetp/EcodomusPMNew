<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCLocationProject.ascx.cs"
    Inherits="UCLocationProject" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
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

        function AfterRootCollapsedLocation(sender, eventArgs) {
       
            var rootNode = eventArgs.get_node();
            if (rootNode._getData().text == 'All Facilities') {
                if (!rootNode._expanding) {
                    if (document.getElementById('divLocationTree') != null) {
                        var divLocationTree = document.getElementById('divLocationTree');
                        document.getElementById('divLocationTree').style.height = "20px";
                        $get("<%=rtvLocationSpaces.ClientID %>").style.height = "30px";
                        resizePopup('collaps');
                        setSateteTreeView('false');
                    }
                    else if (document.getElementById('ContentPlaceHolder1_divLocationTree') != null) {
                        var divLocationTree = document.getElementById('ContentPlaceHolder1_divLocationTree');
                        document.getElementById('divLocationTree').style.height = "20px";
                    }
                }
            }
           
        }


        function AfterRootExpandedLocation(sender, eventArgs) {
           
            var rootNode = eventArgs.get_node();
            if (rootNode._getData().text == 'All Facilities') {
                if (rootNode._expanding) {
                    if (document.getElementById('divLocationTree') != null) {
                        var divLocationTree = document.getElementById('divLocationTree');
                        document.getElementById('divLocationTree').style.height = "200px";
                        resizePopup('expand');
                        setSateteTreeView('true');
                    }
                    else if (document.getElementById('ContentPlaceHolder1_divLocationTree') != null) {
                        var divLocationTree = document.getElementById('ContentPlaceHolder1_divLocationTree');
                        document.getElementById('divLocationTree').style.height = "200px";
                    }
                }

            }
            $get("<%=rtvLocationSpaces.ClientID %>").style.height = "200px";
        }

        function LogoutNavigation() {
            var query = parent.location.href;
            top.location.href(query);
        }
        
    </script>
</telerik:RadCodeBlock>
<style type="text/css">
    .RadTreeView
    {
        overflow: auto !important;
    }
</style>
<asp:UpdatePanel ID="upSpaceTree" runat="server">
    <ContentTemplate>
        <div style="width: 300px;" id="divLocationTree">
            <telerik:RadTreeView ID="rtvLocationSpaces" OnClientNodeExpanded="AfterRootExpandedLocation" 
                OnClientNodeCollapsed="AfterRootCollapsedLocation" OnClientNodeChecked="AfterLocationSpacesCheck"
                ViewStateMode="Enabled" Width="100%" runat="server" CheckBoxes="true" Visible="true"
                autopostback="true" MultipleSelect="true">
            </telerik:RadTreeView>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
