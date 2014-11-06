<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EnergyPlusFacility.ascx.cs" Inherits="App_UserControls_EnergyPlusFacility" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<script type="text/javascript" language="javascript">
   
</script>
<style type="text/css">
.disableLinkButton
{
    font-family: "Arial";
    font-size: 10px;
    text-decoration: none;
    color:#D2CFCF;
    font-size:10px;
    }
    
   
</style>
<script type="text/javascript">
  function RowSelected(sender, eventArgs) {
    var grid = sender;
    var MasterTable = grid.get_masterTableView(); var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
    var cell_desc = MasterTable.getCellByColumnUniqueName(row, "description");
    var cell_facility = MasterTable.getCellByColumnUniqueName(row, "facility");
    //here cell.innerHTML holds the value of the cell

    var lbl_facility = document.getElementById('<%=lbl_facility_name.ClientID %>');
    lbl_facility.innerHTML = cell_facility.innerHTML;

    var lbl_desc = document.getElementById('<%=lbl_facility_desc.ClientID %>');
    lbl_desc.innerHTML = cell_desc.innerHTML;
}

function validate_facility_selection() {
    var grid = $find("<%=rg_facility.ClientID %>");
    count = grid.get_masterTableView().get_selectedItems().length
    if (count > 0) {
        return true;
    }
    else {
        alert("Select facility!");
        return false;
    }
   
}
function adjust_frame_height() {
  
    if (document.body.scrollHeight < 500) {
        var obj_dv = document.getElementById("dv_space");
        obj_dv.style.height = "200";
    }

}


  </script>
 <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
<div id="dv_facility" style="vertical-align:top;border-color:Red;">
<fieldset style="border-left-color:transparent;border-top-color:#EEEEEE; border-right-color:transparent; border-bottom-color:transparent;
    border-top-width:2px;border-left-width:0px;border-right-width:0px;margin:0px">
<table border="0" width="100%" cellpadding="0" cellspacing="0">
    <tr>
        <td style="width: 70%;" class="tdValign">
            <table width="100%" cellpadding="0" cellspacing="0" id="tbl_grid">
                <tr>
                    <td>
                    
                        <telerik:RadGrid ID="rg_facility" runat="server" AllowPaging="true" PageSize="10"
                            BorderColor="White" BorderWidth="2" AllowMultiRowSelection="true" PagerStyle-AlwaysVisible="true"
                            AutoGenerateColumns="false" Width="100%" OnPageSizeChanged="rg_facility_PageSizeChanged"
                            OnPageIndexChanged="rg_facility_PageIndexChanged" >
                            <ClientSettings EnableRowHoverStyle="true">
                                <Selecting AllowRowSelect="true" />
                                <ClientEvents OnRowSelected="RowSelected"/>
                            </ClientSettings>
                            <MasterTableView DataKeyNames="pk_facility_id,name,description" HeaderStyle-CssClass="gridHeaderText">
                                <PagerStyle HorizontalAlign="Right" Mode="NextPrevNumericAndAdvanced" AlwaysVisible="true"
                                    PageSizeLabelText="Show Rows" />
                                    <AlternatingItemStyle BackColor="#F8F8F8" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="pk_facility_id" Visible="false">
                                        <ItemStyle CssClass="column" Width="10%" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Name%>" 
                                        UniqueName="facility">
                                        
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="city_state" HeaderText="City/State"
                                        UniqueName="city_state">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="description"  HeaderText="<%$Resources:Resource,Description%>"
                                        UniqueName="description">
                                        <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Left" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </td>
                </tr>
            </table>
          
        </td>
        <td style="width: 30%; vertical-align: top; padding-top: 0px; background-color: #EEEEEE;
            margin:0px;border-left-color:transparent;border-left-width:0px" class="tdValign">
            
            <table border="0" width="100%" cellpadding="0" cellspacing="0" style="border-bottom-color:White">
            <tr>
            <td style="height:10px">
            
            </td>
            </tr>
                <tr>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="vertical-align: middle; padding-left: 10px; width: 30px">
                                    <asp:Image ID="img_selected_facility" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_lg.png" />
                                </td>
                                <td style="vertical-align: bottom; padding-left: 10px" align="left">
                                    <asp:Label ID="lbl_selected_facility" runat="server" Text="Selected Facility" CssClass="lblHeading">
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
                                    <asp:Label ID="lbl_facility_name" runat="server" Text="Facility Name"
                                        ForeColor="#B22222"></asp:Label>
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
                                    <asp:Label ID="lbl_description" runat="server" Text="Description"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 10px; padding-top: 5px">
                        <table border="0" width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <p>
                                        <asp:Label ID="lbl_facility_desc" runat="server" Text="DESCRIPTION" ForeColor="#B22222"
                                            CssClass="normalLabel"></asp:Label>
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style="height: 0px" id="dv_space">
                        </div>
                    </td>
                </tr>
            </table>
       
        </td>
    </tr>
    <%--<tr>
        <td>
            <div style="height:0px" id="dv_space">
            </div>
        </td>
    </tr>--%>
    <tr>
        <td style="background-color: Orange; height: 1px;border-bottom-color:transparent;border-bottom-width:0px;border-top-color:transparent;border-top-width:0px;" colspan="2">

        </td>
    </tr>
    <tr>
        <td align="right" colspan="2" style="padding-bottom:0px;margin-bottom:0px">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td valign="middle" style="padding-right:2px">
                        <asp:ImageButton ID="ibtn_back" runat="server"  Width="10" 
                            ImageUrl="~/App/Images/Icons/arrow_left.gif"  Enabled="false" 
                            onclick="ibtn_back_Click" ImageAlign="Top" CssClass="lnkButtonImg"/>
                    </td>
                    <td valign="top">
                        <asp:LinkButton ID="lbtn_back" runat="server" Text="Back" CssClass="disableLinkButton" 
                            Font-Underline="false" Enabled="false" onclick="lbtn_back_Click"></asp:LinkButton>
                    </td>
                    <td style="padding-left: 25px; padding-right: 25px" valign="middle">
                        <asp:Image ID="img_vbar" runat="server" ImageUrl="~/App/Images/Icons/asset_scrollbar_bar.png"
                            Width="2px" Height="10px" />
                    </td>
                    <td valign="top">
                        <asp:LinkButton ID="lbtn_next" runat="server" Text="Next" OnClientClick="javascript:return validate_facility_selection();"
                            Font-Underline="false" onclick="lbtn_next_Click" CssClass="lnkButton"></asp:LinkButton>
                    </td>
                    <td valign="bottom">
                        <asp:ImageButton ID="ibtn_next" runat="server" OnClientClick="javascript:return validate_facility_selection();"
                            ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm.png" 
                            onclick="ibtn_next_Click" CssClass="lnkButtonImg"/>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</fieldset>
<asp:HiddenField ID="hf_is_loaded" runat="server" Value="No" />
</div>
