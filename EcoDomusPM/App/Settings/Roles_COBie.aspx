<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Roles_COBie.aspx.cs" Inherits="App_Settings_Roles_COBie" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script language="javascript" type="text/javascript">
        function stopPropagation(e) {
            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
        }

        function GridCreated(sender, args) {
            //debugger;
            //alert(sender.get_masterTableView().get_pageSize());
            //var pageSize =  document.getElementById("hfAttributePMPageSize").value;
            //var scrollArea = sender.GridDataDiv;
            //var dataHeight = sender.get_masterTableView().get_element().clientHeight;

            //if (dataHeight < parseInt(pageSize) * 40) {
            //    scrollArea.style.height = dataHeight + "px";
            //}
            //else {
            //    scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
            //}
            //sender.get_masterTableView().set_pageSize(globalPageHeight);
        }

        function rowclick(sender, args) {
            var Id = document.getElementById("hfCheckviewValues").value;
        }

        function gotoPage(id, pagename) {
            var url;
            if (pagename == "Asset") {
                url = "AssetMenu.aspx?assetid=" + id;  //+ "&pagevalue=AssetProfile";
            }
            else
            if (pagename == "Type") {
                url = "TypeProfileMenu.aspx?type_id=" + id;
                //alert("Page Under Construction");
            }
            else if (pagename == "Facility") {
                url = "../Locations/FacilityMenu.aspx?FacilityId=" + id;
            }
            else if (pagename == "System") {
                url = "SystemMenu.aspx?system_id=" + id;
            }
            else if (pagename == "Space") {
                url = "../Locations/FacilityMenu.aspx?pagevalue=Space Profile&id=" + id;
            }

            window.location.href(url);
        }

        function getRole_Id() 
        {
            var roleid = window.parent.document.getElementById("ContentPlaceHolder1_hf_roleId").value;
            //alert(roleid);
            document.getElementById("hf_roleId_cobie").value = roleid;
            document.getElementById("hdnbtn").click();
        }

        function NavigateTo(id) {
            top.location.href = "../Settings/RolesMenu.aspx?roleId="+ id+"&pagename=Roles_Cobie";
        }

        function resize_frame_page() {
            //window.resizeTo(1000, height);
            var docHeight;
            try {
                var obj = parent.window.frames[1];
                if (obj != null) {
                    window.parent.resize_iframe(parent.window.frames[1]);
                }
            }
            catch (e) {
                window.status = 'Error: ' + e.number + '; ' + e.description;
            }
        }
  
        function chkViewClick(obj, id,name) {
            var hf = document.getElementById("hfCheckviewValues");
            var control_name = document.getElementById("hfname");
            hf.value = id;
            control_name.value = name;
        }

        function viewcheckclicked() {
            var editcheckbox = document.getElementById("CheckBoxEditPermission");
            var deletecheckbox = document.getElementById("CheckBoxDeletePermission");
            var viewcheckbox = document.getElementById("CheckBoxViewPermission");
            if (viewcheckbox.checked == true) {

            }
        }

        function CheckAll(id) {
            var masterTable = $find("<%# RadGridPermissions.ClientID %>").get_masterTableView();
            var row = masterTable.get_dataItems();
            if (id.checked == true) {
                for (var i = 0; i < row.length; i++) {
                    masterTable.get_dataItems()[i].findElement("CheckBoxViewPermission").checked = true;
                }
            }
            else {
                for (var i = 0; i < row.length; i++) {
                    masterTable.get_dataItems()[i].findElement("CheckBoxViewPermission").checked = false;
                }
            }
        }

        function Check(id) {
            var masterTable = $find("<%# RadGridPermissions.ClientID %>").get_masterTableView();
            var row = masterTable.get_dataItems();
            var hidden = document.getElementById("hfSelectedValue");
            if (id.checked == false) {
                var checkBox = document.getElementById(hidden.value);
                checkBox.checked = false;
            }
            else {
                var checkBox = document.getElementById(hidden.value);
                checkBox.checked = true;
                for (var i = 0; i < row.length; i++) {
                    if (masterTable.get_dataItems()[i].findElement("CheckBoxViewPermission").checked == false) {
                        var checkBox = document.getElementById(hidden.value);
                        checkBox.checked = false;
                    }
                }
            }
        }
        
    </script>
    
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />

</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px;margin:0px;">
    <form runat="server">
    
    <telerik:RadScriptBlock runat="server">
        <script src="../Scripts/json3.min.js" type="text/javascript"></script>

        <script type="text/javascript" language="javascript">
            function pageLoad() {
                window.$ = $telerik.$;

                var divRadGridRoles = $($(".js-radgrid-roles").get(0));
                var parent = $(window);

                divRadGridRoles.height(parent.height());

                var radGridRoles = $find("<%= RadGridPermissions.ClientID %>");
                radGridRoles.repaint();
            }

            function PermissionsDictionary(array) {
                this.obj = {};

                this.addOrUpdate = function (key, value) {
                    this.obj[key] = value;
                }

                this.values = function () {
                    var result = [];
                    
                    for (var key in this.obj) {
                        if (this.obj.hasOwnProperty(key)) {
                            var currentObject = this.obj[key];
                            result.push
                            ({
                                PageControlId: key,
                                PageTitle: currentObject.pageTitle,
                                AddPermission: currentObject.addPermission,
                                EditPermission: currentObject.editPermission,
                                DeletePermission: currentObject.deletePermission,
                                ViewPermission: currentObject.viewPermission
                            });
                        }
                    }

                    return result;
                }

                this.createFromArray = function (array) {
                    for (var i = 0; i < array.length; i++) {
                        var currentObject = array[i];
                        var key = currentObject.PageControlId;
                        var value =
                        {
                            pageTitle: currentObject.PageTitle,
                            addPermission: currentObject.AddPermission,
                            editPermission: currentObject.EditPermission,
                            deletePermission: currentObject.DeletePermission,
                            viewPermission: currentObject.ViewPermission
                        }
                        this.obj[key] = value;
                    }
                }

                if (array instanceof Array) {
                    this.createFromArray(array);
                }
            }

            // Permissions
            var Permissions = (function () { return {
                ProcessEventAndGetParameters: function (sender) {
                    var serializedCheckBoxParameters = sender.getAttribute("<%= AttributeName %>");
                    var checkBoxParameters = JSON.parse(serializedCheckBoxParameters);
                    var checked = sender.checked;
                    
                    //var checkBoxAddPermissionClientId = checkBoxParameters.CheckBoxAddPermissionClientId;
                    //var checkBoxAddPermission = $get(checkBoxAddPermissionClientId);

                    var checkBoxEditPermissionClientId = checkBoxParameters.CheckBoxEditPermissionClientId;
                    var checkBoxEditPermission = $get(checkBoxEditPermissionClientId);

                    var checkBoxDeletePermissionClientId = checkBoxParameters.CheckBoxDeletePermissionClientId;
                    var checkBoxDeletePermission = $get(checkBoxDeletePermissionClientId);

                    var checkBoxViewPermissionClientId = checkBoxParameters.CheckBoxViewPermissionClientId;
                    var checkBoxViewPermission = $get(checkBoxViewPermissionClientId);
                    
                    var relatedCheckBoxesClientIds = checkBoxParameters.RelatedCheckBoxesClientIds;
                    //var pageParameters = checkBoxParameters.PageParameters;
                    Permissions.SetRelatedCheckboxesState(relatedCheckBoxesClientIds, checked);

                    var pageTitle = checkBoxParameters.PageTitle;
                    var pageControlId = checkBoxParameters.PageControlId;
                    var addPermission = true;//checkBoxAddPermission.checked;
                    var editPermission = checkBoxEditPermission.checked;
                    var deletePermission = checkBoxDeletePermission.checked;
                    var viewPermission = checkBoxViewPermission.checked;

                    Permissions.SetEnabledSaveButton();
                    Permissions.SavePermissionsChanges(pageTitle, pageControlId, addPermission, editPermission, deletePermission, viewPermission);

                    var result =
                    {
                        checked: checked,
                        //checkBoxAddPermission: checkBoxAddPermission,
                        checkBoxEditPermission: checkBoxEditPermission,
                        checkBoxDeletePermission: checkBoxDeletePermission,
                        checkBoxViewPermission: checkBoxViewPermission
                    }

                    return result;
                },

                SetEnabledSaveButton: function() {
                    var saveButton = $find("<%= btnSave.ClientID %>");
                    saveButton.set_enabled(true);
                },

                // SetRelatedCheckboxesState
                SetRelatedCheckboxesState: function(relatedCheckBoxesClientIds, checked) {
                    for (var i = 0; i < relatedCheckBoxesClientIds.length; i++) {
                        var chexBox = $get(relatedCheckBoxesClientIds[i]);
                        chexBox.checked = checked;
                        $(chexBox).trigger("onclick");
                    }
                },

                SavePermissionsChanges: function(pageTitle, pageControlId, addPermission, editPermission, deletePermission, viewPermission) {
                    var hiddenFieldPermissionsChanges = $get("<%= HiddenFieldPermissionsChanges.ClientID %>");
                    var hiddenFieldPermissionsChangesValue = hiddenFieldPermissionsChanges.value;
                    
                    var permissionsDictionary;
                    if (hiddenFieldPermissionsChangesValue) {
                        var arrayOfPermissionItems = JSON.parse(hiddenFieldPermissionsChangesValue);
                        permissionsDictionary = new PermissionsDictionary(arrayOfPermissionItems);
                    } else {
                        permissionsDictionary = new PermissionsDictionary();
                    }

                    var key = pageControlId;
                    var value =
                    {
                        pageTitle: pageTitle,
                        addPermission: addPermission,
                        editPermission: editPermission,
                        deletePermission: deletePermission,
                        viewPermission: viewPermission
                    }

                    permissionsDictionary.addOrUpdate(key, value);

                    arrayOfPermissionItems = permissionsDictionary.values();
                    var jsonString = JSON.stringify(arrayOfPermissionItems);
                    hiddenFieldPermissionsChanges.value = jsonString;
                },

                // RadGridPermissions
                RadGridPermissions:
                {
                    // CheckBoxAddPermission
                    CheckBoxAddPermission:
                    {
                        // OnClick
                        OnClick: function (sender) {
                            Permissions.ProcessEventAndGetParameters(sender);
                        }
                    },

                    // CheckBoxViewPermission
                    CheckBoxViewPermission:
                    {
                        // OnClick
                        OnClick: function (sender) {
                            var parameters = Permissions.ProcessEventAndGetParameters(sender);
                            var checked = parameters.checked;
                            var checkBoxEditPermission = parameters.checkBoxEditPermission;
                            
                            if (!checked) {
                                checkBoxEditPermission.checked = false;
                                $(checkBoxEditPermission).trigger("onclick");
                            }
                        }
                    },

                    // CheckBoxEditPermission
                    CheckBoxEditPermission:
                    {
                        // OnClick
                        OnClick: function (sender) {
                            var parameters = Permissions.ProcessEventAndGetParameters(sender);
                            var checked = parameters.checked;
                            var checkBoxViewPermission = parameters.checkBoxViewPermission;
                            var checkBoxDeletePermission = parameters.checkBoxDeletePermission;
                            
                            if (!checked) {
                                checkBoxDeletePermission.checked = false;
                                $(checkBoxDeletePermission).trigger("onclick");
                            }

                            if (checked) {
                                checkBoxViewPermission.checked = true;
                                $(checkBoxViewPermission).trigger("onclick");
                            }
                        }
                    },

                    // CheckBoxDeletePermission
                    CheckBoxDeletePermission:
                    {
                        // OnClick
                        OnClick: function (sender) {
                            var parameters = Permissions.ProcessEventAndGetParameters(sender);
                            var checked = parameters.checked;
                            var checkBoxEditPermission = parameters.checkBoxEditPermission;

                            if (checked) {
                                checkBoxEditPermission.checked = true;
                                $(checkBoxEditPermission).trigger("onclick");
                            }
                        } 
                    }
                }
            };
            })();

            function RadAjaxManager1_OnRequestStart(sender, eventArgs) {
                var saveButton = $find("<%= btnSave.ClientID %>");
                saveButton.set_enabled(false);
            }
        </script>
    </telerik:RadScriptBlock>

    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        
    <div style="margin-left:0px;">
    
        <table width="100%">
            <tr>
                <td class="centerAlign">
                    <telerik:RadButton ID="btnSave" runat="server" Text="<%$Resources:Resource,Save%>" Width="80px" onclick="btnSave_Click" Enabled="False" />
                </td>
                <td style="display:none">
                    <asp:Button ID="hdnbtn" runat="server" style="display:none" onclick="hdnbtn_Click"/>
                </td>
            </tr>
            <tr style="margin:0px">
                <td class="centerAlign">
                    <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" BorderWidth="0" ExpandMode="MultipleExpandedItems" BorderColor="Transparent">
                        <ExpandAnimation Type="OutSine" />
                        <Items>
                            <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false" BorderWidth="0" BorderColor="Transparent">
                                <HeaderTemplate>
                                    <asp:Panel ID="pnl_job" runat="server" BorderWidth="0" Width="100%" BorderColor="Transparent">
                                        <table id="tbl_jobs" cellpadding="0" cellspacing="0" class="gridRadPnlHeader" runat="server" width="100%">
                                            <tr>
                                                <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                    <asp:Label runat="server" Text="<%$Resources:Resource,Permissions%>" ID="lbl_grid_head" CssClass="gridHeadText" Width="100px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                                </td>
                                                <td align="center" style="padding-right:10px;"  class="dropDownImage">
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tbl_jobs1" runat="server" cellpadding="0" cellspacing="0" width="100%" style="background-color: #707070; border-width: 0px;">
                                            <tr>
                                                <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <div class=".js-radgrid-roles">
                                        <telerik:RadGrid AllowMultiRowSelection="False" AlternatingItemStyle-BackColor="" AutoGenerateColumns="False" GridLines="None" 
                                                         GroupHeaderItemStyle-BorderWidth="1" HeaderStyle-Wrap="false" ID="RadGridPermissions" ItemStyle-BackColor="" 
                                                         OnDetailTableDataBind="RadGridPermissions_OnDetailTableDataBind" OnItemCommand="RadGridPermissions_OnItemcommand" 
                                                         OnItemDataBound="RadGridPermissions_OnItemDataBound" OnPreRender="RadGridPermissions_OnPreRender" runat="server" ShowStatusBar="true" 
                                                         Skin="Default" Width="100%">
                                            <PagerStyle Mode="NumericPages"></PagerStyle>
                                            <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="400" />
                                                <Selecting AllowRowSelect="true" />
                                                <ClientEvents OnGridCreated="GridCreated" />
                                            </ClientSettings>
                                            <MasterTableView Width="100%" DataKeyNames="pk_project_role_controls,name" AllowMultiColumnSorting="True" Name="ParentGrid" HierarchyLoadMode="Client">
                                                <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                                                <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                                <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                                <FooterStyle Height="25px" Font-Names="Arial" />
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="pk_project_role_controls" HeaderText="pk_project_role_controls" Visible="false">
                                                        <ItemStyle CssClass="column" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource, Page_Title%>">
                                                        <ItemStyle CssClass="column" Width="70%" />
                                                        <HeaderStyle Width="70%" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn DataField="view_permission" Visible="false">
                                                        <ItemStyle CssClass="column" />
                                                        <HeaderStyle/>
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="view_permission" HeaderText="<%$Resources:Resource, View%>" Visible="true">
                                                        <ItemStyle CssClass="column" Width="10%" />
                                                        <HeaderStyle Width="10%" />
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="CheckBoxViewPermission" runat="server" AutoPostBack="False" onclick="javascript:return Permissions.RadGridPermissions.CheckBoxViewPermission.OnClick(this);" />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridBoundColumn DataField="add_permission" Visible="false">
                                                        <ItemStyle CssClass="column" />
                                                        <HeaderStyle />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="add_permission" HeaderText="<%$Resources:Resource, Add%>" Visible="false">
                                                        <ItemStyle CssClass="column" />
                                                        <HeaderStyle />
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="CheckBoxAddPermission" runat="server" AutoPostBack="False" onclick="javascript:return Permissions.RadGridPermissions.CheckBoxAddPermission.OnClick(this);" />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridBoundColumn DataField="edit_permission" Visible="false">
                                                    <ItemStyle CssClass="column" />
                                                    <HeaderStyle />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="edit_permission" HeaderText="<%$Resources:Resource, Edit%>">
                                                        <ItemStyle CssClass="column" Width="10%" />
                                                        <HeaderStyle Width="10%" />
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="CheckBoxEditPermission" runat="server" AutoPostBack="False" onclick="javascript:return Permissions.RadGridPermissions.CheckBoxEditPermission.OnClick(this);" />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridBoundColumn DataField="delete_permission" Visible="false">
                                                        <ItemStyle CssClass="column" />
                                                        <HeaderStyle Width="100%" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="delete_permission" HeaderText="<%$Resources:Resource, Delete%>">
                                                        <ItemStyle CssClass="column" Width="10%" />
                                                        <HeaderStyle Width="10%" />
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="CheckBoxDeletePermission" runat="server" AutoPostBack="False" onclick="javascript:return Permissions.RadGridPermissions.CheckBoxDeletePermission.OnClick(this);" />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>

                                                <DetailTables>
                                                    <telerik:GridTableView AllowCustomPaging="false" AllowPaging="false" AllowSorting="true" AlternatingItemStyle-BackColor="PaleGoldenrod" 
                                                                           AutoGenerateColumns="false" DataKeyNames="pk_project_role_controls,name" GridLines="Horizontal" 
                                                                           ItemStyle-BackColor="PaleGoldenrod" Name="ChildGrid" PagerStyle-Mode="NextPrevAndNumeric" 
                                                                           PagerStyle-VerticalAlign="Bottom" PageSize="10" Style="border-color: #d5b96a; border: 0" Width="100%">
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="pk_project_role_controls" HeaderText="pk_project_role_controls" Visible="false">
                                                                <ItemStyle CssClass="column" />
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="name" HeaderText="">
                                                                <ItemStyle CssClass="column" Width="70%" />
                                                                <HeaderStyle Width="70%" />
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="view_permission" Visible="false">
                                                                <ItemStyle CssClass="column" />
                                                                <HeaderStyle Width="100%" />
                                                            </telerik:GridBoundColumn>
                                
                                                            <telerik:GridTemplateColumn DataField="view_permission" HeaderText="<%$Resources:Resource, View%>" Visible="true">
                                                                <ItemStyle CssClass="column ChildGrid" Width="10%" />
                                                                <HeaderStyle Width="10%" />
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="CheckBoxViewPermission" runat="server" AutoPostBack="False" onclick="javascript:return Permissions.RadGridPermissions.CheckBoxViewPermission.OnClick(this);" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>

                                                            <telerik:GridBoundColumn DataField="add_permission" Visible="false">
                                                                <ItemStyle CssClass="column" />
                                                                <HeaderStyle Width="100%" />
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridTemplateColumn DataField="add_permission" HeaderText="<%$Resources:Resource, Add%>" Visible="false">
                                                                <ItemStyle CssClass="column" />
                                                                <HeaderStyle Width="100%" />
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="CheckBoxAddPermission" runat="server" AutoPostBack="False" onclick="javascript:return Permissions.RadGridPermissions.CheckBoxAddPermission.OnClick(this);" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>

                                                            <telerik:GridBoundColumn DataField="edit_permission" Visible="false">
                                                                <ItemStyle CssClass="column" />
                                                                <HeaderStyle Width="100%" />
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridTemplateColumn DataField="edit_permission" HeaderText="<%$Resources:Resource, Edit%>">
                                                                <ItemStyle CssClass="column" Width="10%" />
                                                                <HeaderStyle Width="10%" />
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="CheckBoxEditPermission" runat="server" AutoPostBack="False" onclick="javascript:return Permissions.RadGridPermissions.CheckBoxEditPermission.OnClick(this);" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>

                                                            <telerik:GridBoundColumn DataField="delete_permission" Visible="false">
                                                                <ItemStyle CssClass="column" />
                                                                <HeaderStyle Width="100%" />
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridTemplateColumn DataField="delete_permission" HeaderText="<%$Resources:Resource, Delete%>">
                                                                <ItemStyle CssClass="column" Width="10%" />
                                                                <HeaderStyle Width="10%" />
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="CheckBoxDeletePermission" runat="server" AutoPostBack="False" onclick="javascript:return Permissions.RadGridPermissions.CheckBoxDeletePermission.OnClick(this);" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                    </telerik:GridTableView>
                                                </DetailTables> 
                                            </MasterTableView>
                                        </telerik:RadGrid> 
                                    </div>
                                </ContentTemplate>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:RadPanelBar>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lblStatus"></asp:Label>
                </td>
            </tr>
        </table>
    </div>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="CheckBoxViewPermission">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridPermissions" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <%-- <telerik:AjaxUpdatedControl ControlID="btnSave" LoadingPanelID="RadAjaxLoadingPanel1" /> --%>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridPermissions" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <ClientEvents OnRequestStart="RadAjaxManager1_OnRequestStart" />
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server" Height="75px" Width="75px" />

    <asp:HiddenField ID="hf_roleId_cobie" runat ="server" Value="abc" />
    <asp:HiddenField ID= "hfAttributePMPageSize" runat="Server" />
    <asp:HiddenField ID="hfCheckviewValues" runat="server" />
    <asp:HiddenField ID="hfname" runat="server" />
    <asp:HiddenField ID="hfSelectedValue" runat="server" />
    <asp:HiddenField ID="HiddenFieldPermissionsChanges" runat="server" />

</form> 
</body>
</html>
