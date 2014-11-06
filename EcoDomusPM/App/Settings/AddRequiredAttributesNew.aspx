<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddRequiredAttributesNew.aspx.cs"
    Inherits="App_Settings_AddRequiredAttributesNew" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="uc" TagName="PropertyValueControl" Src="~/App/UserControls/PropertyValueControl/PropertyValueControl.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<script type="text/javascript">
    function closeWindow() {
        window.parent.refreshgrid();
        window.close();
        return false;
    }
    function SuccessPupup(name) {

        alert('Group with name ' + name + ' is assigned successfully.');
        window.close();
        //window.parent.refreshgrid();
        return false;

    }
    function SuccessPupupUnAssign(name) {

        alert('Group with name ' + name + ' is Un-Assigned successfully.');
        window.close();
        //window.parent.refreshgrid();
        return false;

    }
    function checkboxClick(sender) {

        collectSelectedItems(sender);
        document.getElementById('btn_navigate').click();
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
    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    }
    function LogoutNavigation() {
        var query = parent.location.href;
        top.location.href(query);
    }

    function adjust_height() {

        var wnd = GetRadWindow();
        if (wnd != null) {
            var bounds = wnd.getWindowBounds();
            var x = bounds.x;
            wnd.moveTo(x - 40, 120);
            wnd.set_height(document.body.scrollHeight + 65);
        }

    }


    window.onload = function() {
        adjust_height();
    }

</script>
<head runat="server">
    <title></title>
    <style type="text/css">
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
</head>
<body style="background: #EEEEEE; padding: 0; margin: 0;">
  <div id="mytestdiv"></div>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" AsyncPostBackTimeout="360000">
        <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
    </asp:ScriptManager>
    
    <telerik:RadAjaxManager ID="ramAttribute" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rg_attribute">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_attribute" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="cmb_attribute_group_list">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_attribute" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnAssign">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_attribute" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadComboBoxAttributeType">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PropertyValueControl" LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px" Width="75px">
        </telerik:RadAjaxLoadingPanel>

    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div style="padding-left: 0px; width: 100%; background-color: #EEEEEE; border: 2px">
        <div runat="server" ID="AddAttributeWindowContent">
        <table width="100%">
            <tr style="display:none;">
                <td class="wizardHeadImage">
                    <div class="wizardLeftImage">
                        <asp:Label ID="Label1" runat="server" Font-Size="10pt" Text="<%$Resources:Resource,Add_Edit_Names%>"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClientClick="javascript:return closeWindow();" OnClick="ibtn_close_Click" Style="height: 16px" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td style="padding-left:20px;">
                                <asp:RadioButton ID="rdBtnAddExistingAttributes" runat="server" OnCheckedChanged="rdBtnAddExistingAttributes_CheckedChanged" 
                                    AutoPostBack="True" BorderWidth="0" BackColor="transparent" GroupName="AddAttribute" Checked="true" CssClass="LabelText"
                                      Text="<%$Resources:Resource,Add_Existing_Attributes%>" />
                            </td>
                            <td>
                                <asp:RadioButton ID="rdBtnAddNewAttribtues" runat="server"   OnCheckedChanged="rdBtnAddNewAttribtues_CheckedChanged"
                                     AutoPostBack="True" BorderWidth="0" BackColor="transparent" GroupName="AddAttribute" Text="<%$Resources:Resource,Add_New_Attribute%>" CssClass="LabelText" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        
        <div id="div_add_new" runat="server" Visible="False">
            <asp:Panel runat="server" ID="AddNewPanel">
            <table>
                <tr>
                    <td align="right" style="width: 140px;">
                        <asp:Label ID="lblName" CssClass="Label" runat="server" Text="<%$Resources:Resource,Attribute_Name%>">:</asp:Label>:
                    </td>
                    <td>
                        <asp:TextBox Width="220" ID="txtaddattribute" CssClass="textbox" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rf_name" ValidationGroup="req" runat="server" ForeColor="Red"
                            ControlToValidate="txtaddattribute" ErrorMessage="*" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblDescription" CssClass="Label" runat="server" Text="<%$Resources:Resource,Abbreviation%>">:</asp:Label>:
                    </td>
                    <td>
                        <asp:TextBox ID="txtDescription" Width="220" CssClass="textbox" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                         <asp:Label ID="lblValue" runat="server" CssClass="Label" Text="<%$Resources:Resource,Value%>">:</asp:Label>:
                    </td>
                    <td>
                        <div style="height: 40px; position: relative; top:22%;">
                            <div class="PropertyValueControlFixPosition">
                                <uc:PropertyValueControl ID="PropertyValueControl" runat="server" ControlsWidth="168px" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="right" >
                        <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Type%>" CssClass="Label">:</asp:Label>:
                    </td>
                    <td >
                        <telerik:RadComboBox ID="RadComboBoxAttributeType" runat="server" CssClass="DropDown" OnSelectedIndexChanged="RadComboBoxAttributeType_OnSelectedIndexChanged" AppendDataBoundItems="True"
                         Width="168"  OnItemDataBound="RadComboBoxAttributeType_OnItemDataBound" AutoPostBack="True" 
                        >
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblAttributeGroup" runat="server" CssClass="Label" Text="<%$Resources:Resource,Attribute_Group_List%>">:</asp:Label>:
                    </td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <telerik:RadComboBox ID="cmb_attribute_grp_list" Filter="Contains" runat="server" ExpandDirection="Up"
                                    CssClass="DropDown" Height="70" Width="225">
                                </telerik:RadComboBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td style="height: 10px;">
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 40px;">
                        <asp:Button ID="btn_save" runat="server" Text="<%$Resources:Resource,Save%>" Width="80px"
                            ValidationGroup="req" OnClick="btn_save_Click" />
                    </td>
                    <td>
                        <asp:Button ID="btn_cancel" runat="server" Text="<%$Resources:Resource,Cancel%>"
                            Width="80px" OnClientClick="javascript:return closeWindow();" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label runat="server" ID="lblMsg" ForeColor="Red" Font-Size="10pt" Text="" Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="ResultMessage"></asp:Label>
                    </td>
                </tr>
            </table>
            </asp:Panel>
        </div>
        <div id="div_add_existing" runat="server">
            <table width="100%">
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td style="padding-left: 20px;">
                                    <asp:Label ID="lblAttributegrplist" runat="server" CssClass="Label" Text="<%$Resources:Resource,Attribute_Group_List%>">:</asp:Label>:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cmb_attribute_group_list" runat="server" ExpandDirection="Up"  CssClass="DropDown" 
                                        Filter="Contains" OnSelectedIndexChanged="cmb_attribute_group_list_SelectedIndexChanged"
                                        AutoPostBack="True" Height="150" Width="200">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField ID="hf_group_id" runat="server" />
                        <asp:HiddenField ID="hf_attribute_value_id" runat="server" />
                        <asp:HiddenField ID="SelectTypeValue" runat="server"/>
                        <div style="display: none">
                            <asp:Button ID="btn_navigate" runat="server" OnClick="navigate" />
                            <%--<asp:Button ID="btn_refresh" runat="server" OnClick="btn_refresh_click" />--%>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%">  
                            <tr>
                                <td style="padding-left: 15px;padding-right: 20px;">
                                    <telerik:RadGrid runat="server" ID="rg_attribute" BorderWidth="1px" AllowPaging="true"
                                        PageSize="10" AutoGenerateColumns="False" AllowSorting="True" PagerStyle-AlwaysVisible="true"
                                        Visible="true" Skin="Default" Width="510" OnSortCommand="rg_attribute_SortCommand"
                                        OnPageIndexChanged="rg_attribute_PageIndexChanged" OnPageSizeChanged="rg_attribute_PageSizeChanged">
                                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="50%" AlwaysVisible="true" />
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="240px" />
                                        </ClientSettings>
                                        <MasterTableView DataKeyNames="pk_required_group_attribute_id,attribute_name" ClientDataKeyNames="pk_required_group_attribute_id,attribute_name">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="pk_required_group_attribute_id" HeaderText="pk_required_group_attribute_id"
                                                    Visible="false">
                                                </telerik:GridBoundColumn>
                                                <%--<telerik:GridBoundColumn DataField="fk_attribute_template_id" HeaderText="fk_attribute_template_id"
                                                    Visible="false">
                                                </telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn Resizable="false" DataField="attribute_name" HeaderText="<%$Resources:Resource,Attribute_Name%>"
                                                    UniqueName="attribute_name" SortExpression="attribute_name">
                                                    <ItemStyle CssClass="column" Width="10%" HorizontalAlign="Left" />
                                                    <HeaderStyle HorizontalAlign="Left" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Abbreviation%>"
                                                    UniqueName="attribute_name" SortExpression="attribute_name">
                                                    <ItemStyle CssClass="column" Width="4%" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="value" HeaderText="<%$Resources:Resource,Value%>"
                                                    UniqueName="value" SortExpression="value">
                                                    <ItemStyle CssClass="column" Width="3%" />
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                           </tr>
                         
                           <tr>
                                    <td style="height: 10px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnAssign"  runat="server" Text="<%$Resources:Resource,Assign%>" OnClick="btn_assign_click">
                                            <%--OnClientClick="javascript:return closeWindow();"--%>
                                        </asp:Button>
                                        <asp:Button ID="btnUnassign" runat="server" Text="<%$Resources:Resource,UnAssign%>" OnClick="btnUnAssign_Click" />
                                       
                                        <asp:Button ID="btnClose"  runat="server" Text="<%$Resources:Resource,Close%>" OnClientClick="javascript:return closeWindow();">
                                        </asp:Button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMsgDisplay" runat="server" Font-Size="10pt" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                          
                        </table>

                    </td>
                </tr>
            </table>
        </div>
        </div>
    </div>
    </form>
</body>
</html>
