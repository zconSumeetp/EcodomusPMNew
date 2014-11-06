<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCProfile.ascx.cs" Inherits="App_UserControls_UCProfile" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
<link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    #footer
    {
        height: 50px;
        width: 100%;
        position: absolute;
        left: 0;
        bottom: 0;
    }
</style>
<script type="text/javascript">
    function delete_attribute() {

        var flag = confirm("Do you want to delete this attribute?");
        return flag;

    }
    function closeWindow() {
        //window.parent.refreshgrid();
        window.close();
        return false;
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

    function checkboxClick(sender) {
        collectSelectedItems(sender);
        adjust_height();
    }

    function validate() {
        alert("Template with this name already exists.");
        return false;
    }
    function LogoutNavigation() {
        var query = parent.location.href;
        top.location.href(query);
    }

    window.onload = adjust_height;
</script>
<div style="padding-left: 0px; margin: 0px 50px 5px 0px; background: #EEEEEE; height: 180px;
    width: 100%">
    <table width="100%" height="90%" >
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td style="height: 5px;">
            </td>
        </tr>
        <tr id="tr_add_attribute" runat="server">
            <td  style="vertical-align:top;">
                <table id="tbl_add_details" runat="server" width="100%" >
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblName" CssClass="Label" runat="server" Text="<%$Resources:Resource,Name%>">:</asp:Label>:
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtaddattribute" Width="215px" runat="server" CausesValidation="true"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="rf_name" ValidationGroup="req" runat="server" ForeColor="Red"
                                            ControlToValidate="txtaddattribute" ErrorMessage="*" Display="Dynamic">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblUOM" runat="server" CssClass="Label" Text="<%$Resources:Resource,Facility%>">:</asp:Label>:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cmbox_facility_list" runat="server" EmptyMessage="--Select--"
                                CssClass="DropDown" Height="120" Width="220" OnItemDataBound="cmbox_facility_list_ItemDataBound"
                                AutoPostBack="true">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkfacility" runat="server" Text='<%# Eval("name") %>' />
                                </ItemTemplate>
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="req" runat="server"
                                ForeColor="Red" ControlToValidate="cmbox_facility_list" ErrorMessage="*" Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="display: none;">
                            <asp:Label ID="lblDescription" CssClass="Label" runat="server" Text="<%$Resources:Resource,Description%>">:</asp:Label>:
                        </td>
                        <td style="display: none;">
                            <asp:TextBox ID="txtAbbrivations" CssClass="textbox" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div>
        <table width="100%">
            <%--  <tr>
            <td align="right" style="width: 50%">
                <asp:Button ID="btnNext" runat="server" Width="60px" Text="<%$Resources:Resource,Next%>"
                    OnClick="btnNext_Click" ValidationGroup="req" CausesValidation="true" />
            </td>
        </tr>--%>
            <tr>
                <td style="background-color: Orange; height: 1px; border-bottom-color: transparent;
                    border-bottom-width: 0px; border-top-color: transparent; border-top-width: 0px;">
                </td>
            </tr>
            <tr style="height: 15px;">
                <td align="right" style="padding-bottom: 0px; margin-bottom: 0px">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="middle" style="padding-right: 2px">
                                <asp:ImageButton ID="ibtn_back" runat="server" Width="10" ImageUrl="~/App/Images/Icons/arrow_left.gif"
                                    Enabled="false" OnClick="ibtn_back_Click" ImageAlign="Top" CssClass="lnkButtonImg" />
                            </td>
                            <td valign="top">
                                <asp:LinkButton ID="lbtn_back" runat="server" Text="Back" CssClass="disableLinkButton"
                                    Font-Underline="false" Enabled="false" OnClick="lbtn_back_Click"></asp:LinkButton>
                            </td>
                            <td style="padding-left: 25px; padding-right: 25px" valign="middle">
                                <asp:Image ID="img_vbar" runat="server" ImageUrl="~/App/Images/Icons/asset_scrollbar_bar.png"
                                    Width="2px" Height="10px" />
                            </td>
                            <td valign="top">
                                <asp:LinkButton ID="lbtn_next" runat="server" Text="Next" Font-Underline="false"
                                    OnClick="lbtn_next_Click" CssClass="lnkButton" ValidationGroup="req"></asp:LinkButton>
                            </td>
                            <td valign="bottom">
                                <asp:ImageButton ID="ibtn_next" runat="server" ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm.png"
                                    OnClick="ibtn_next_Click" CssClass="lnkButtonImg" ValidationGroup="req" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</div>
