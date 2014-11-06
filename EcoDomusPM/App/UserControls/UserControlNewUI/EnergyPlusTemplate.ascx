<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EnergyPlusTemplate.ascx.cs" Inherits="App_UserControls_EnergyPlusTemplate" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<script type="text/javascript">
    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    }

    function adjust_window_height() {
        var wnd = GetRadWindow();
        if (wnd != null) {
            var bounds = wnd.getWindowBounds();
            var x = bounds.x;
            var y = bounds.y;
            //alert(x);
            //alert(y);
            wnd.moveTo(x, 25);
            wnd.set_height(document.body.scrollHeight + 20);
        }
    }
    window.onload = adjust_height;
</script>
<style type="text/css">
    .style1
    {
        width: 509px;
    }
    .lblValign
    {
        vertical-align:middle;
        }
    .style2
    {
        height: 30px;
    }
    .textAreaScrollBar
    {
        font-family: "Arial" , sans-serif;
        font-size: 12px;
        overflow:auto;
        padding-left:10px;
        padding-top:10px;
         border-left-color:#D4D4C3;
            border-top-color:#D4D4C3;
            border-bottom-color:#E8E8E8;
            border-right-color:#E8E8E8;
        height:170px;
        }
        
</style>
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
<link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
<fieldset style="border-top-color:#DCDCDC;border-left-color:transparent;border-right-color:transparent;border-bottom-color:transparent">
<div>
<table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td style="width: 60%;padding-left:20px;" class="tdValign" >
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td style="padding-top: 15px; padding-bottom: 15px">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lbl_attribute_template" Text="Select Attribute Template"
                                        CssClass="headerBoldLabel"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <p>
                                        <asp:Label runat="server" ID="lbl_template_msg" Text="" CssClass="normalLabel"></asp:Label>
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 25px">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lbl_template" Text="Available Attribute Template" CssClass="normalLabel"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td >
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="height:50px">
                                    <telerik:RadComboBox ID="cmb_attribute_template" runat="server" Width="300px" ExpandDirection="Down"
                                        ZIndex="10"  AutoPostBack="true"
                                        onselectedindexchanged="cmb_attribute_template_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>
                                <td style="padding-left: 10px;vertical-align:middle;padding-top:5px">
                                    <%--<telerik:RadTextBox runat="server" Width="200px" Height="22px" CssClass="searchImage"
                                        ID="rtx_search_text" EmptyMessage="Search" Skin="">
                                    </telerik:RadTextBox>--%>
                                    <asp:ImageButton ID="ibtn_search" runat="server" 
                                        ImageUrl="~/App/Images/Icons/btnSearch.png" onclick="ibtn_search_Click" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 10px">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_attribute_template_items" runat="server" Text="Attribute Template Items" CssClass="normalLabel"></asp:Label>
                                </td>
                            </tr>
                        </table>  

                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 10px; padding-bottom: 15px">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="style1">
                                   <asp:ListBox ID="lst_templates_items" runat="server" Width="95%" Height="120" 
                                        BackColor="#FFFFE1">
                                           
                                        </asp:ListBox>
                                    <%--<asp:TextBox ID="rtxt_template_items" Width="95%" TextMode="MultiLine" runat="server" BackColor="#FFFFE1"  BorderStyle="Inset"
                                        CssClass="textAreaScrollBar"></asp:TextBox>--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td style="width: 40%; padding-top: 15px;background-color:#EEEEEE" valign="top" class="tdValign">
            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="vertical-align: middle; padding-left: 10px; width: 30px">
                                    <asp:Image ID="img_selected_facility" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_lg.png" />
                                </td>
                                <td style="vertical-align: bottom; padding-left: 10px" align="left">
                                    <asp:Label ID="lbl_selected_facility" runat="server" Text="Selected Facility" CssClass="normalLabel">
                                    </asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="height: 10px">
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 10px">
                        <table border="0" width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_facility_name" runat="server" Text="Facility Name" CssClass="normalLabel"
                                        ForeColor="#B22222"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                    </td>
                </tr>
                <tr>
                    <td style="padding-left:40px;padding-bottom: 30px">
                        <table border="0" width="100%" cellpadding="0" cellspacing="0" align="left" style="background-image: url('/App/Images/asset_button_orange.png');
                            background-repeat: no-repeat; background-position: inherit; height: 26px;width:140px">
                            <tr>
                                <td style="padding-left: 5px; vertical-align: middle">
                                    <%--<asp:CheckBox ID="chk_no_template" runat="server" Text="No Template"  CssClass="normalLabel"/>--%>
                                    <asp:Image ID="img_no_template" runat="server" ImageUrl="~/App/Images/Icons/asset_checkbox1.png" />
                                </td>
                                <td valign="top">
                                    <asp:Label ID="lbl_no_template" runat="server" Text="No Template" CssClass="normalLabel"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
              </tr>
                <tr>
                    <td style="padding-left:40px">
                        <table border="0" width="100%" cellpadding="0" cellspacing="0" align="left" style="background-image: url('/App/Images/asset_button_orange.png');
                            background-repeat: no-repeat; background-position: inherit;height:26px;width:140px">
                            <tr>
                                <td style="padding-left: 5px; vertical-align: middle">
                                    <%--<asp:CheckBox ID="chk_selected_template" runat="server" Text="Selected Template" CssClass="normalLabel"/>--%>
                                    <asp:Image ID="img_template" runat="server" ImageUrl="~/App/Images/Icons/asset_checkbox1.png" />
                                </td>
                                <td valign="top">
                                    <asp:Label ID="lbl_selected_template" runat="server" Text="Selected Template" CssClass="normalLabel"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
           </table>
        </td>
    </tr>

    <tr>
        <td style="background-color: Orange; height: 1px" colspan="2">
      
        </td>
    </tr>
    <tr>
        <td align="right" colspan="2">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <asp:ImageButton ID="ibtn_back" runat="server" Height="14" CssClass="lnkButtonImg"
                            ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm2.png" 
                            onclick="ibtn_back_Click" />
                    </td>
                    <td valign="top">
                        <asp:LinkButton ID="lbtn_back" runat="server" Text="Back" ForeColor="Black" onclick="lbtn_back_Click" CssClass="lnkButton"></asp:LinkButton>
                    </td>
                    <td style="padding-left: 25px; padding-right: 25px" valign="middle">
                        <asp:Image ID="img_hbar" runat="server" ImageUrl="~/App/Images/Icons/asset_scrollbar_bar.png"
                            Width="2px" Height="10px" />
                    </td>
                    <td>
                      <asp:LinkButton ID="Label1" runat="server" Text="Skip" ForeColor="Black" CssClass="lnkButton"></asp:LinkButton>
                    </td>
                    <td style="padding-left: 25px; padding-right: 25px" valign="middle">
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/App/Images/Icons/asset_scrollbar_bar.png"
                            Width="2px" Height="10px" />
                    </td>
                    <td valign="top">
                        <asp:LinkButton ID="lbtn_next" runat="server" Text="Next" ForeColor="Black" CssClass="lnkButton" onclick="lbtn_next_Click"></asp:LinkButton>
                    </td>
                    <td >
                        <asp:ImageButton ID="ibtn_next" runat="server" 
                            ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm.png" 
                            onclick="ibtn_next_Click" CssClass="lnkButtonImg" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
 
<asp:HiddenField ID="hf_is_loaded" runat="server" Value="No" />
   <%-- <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmb_attribute_template">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rtxt_template_items" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
            
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>--%>

</div>
</fieldset>