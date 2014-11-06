<%@ Page Language="C#" AutoEventWireup="true" CodeFile="facilityassets.aspx.cs" Inherits="App_Settings_facilityassets" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1"  runat="server">
    <title>EcoDomus PM</title>
    <telerik:RadCodeBlock runat="server">
        <script type="text/javascript">

            function closeWindow() {

                window.opener.refresh_asset_grid();
                window.close();
            }

            function Clear() {

                document.getElementById("<%=txtClass.ClientID %>").value = "";
                return false;

            }

            function facilitystatus() {
                
                document.getElementById("<%=hdnfacility.ClientID %>").value = parent.top.document.getElementById("ContentPlaceHolder1_hdnfacility").value;
                return false;
            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog     
                    
                else if (window.frameElement != null) {
                    if (window.frameElement.radWindow)
                        oWindow = window.frameElement.radWindow; //IE (and Moz as well)      
                }
              
                return oWindow;
            }

            function select_Sub_System(id, name, type_name) {

                parent.window.load_comp(name, id, type_name);
                var Radwindow = GetRadWindow();
                Radwindow.close();
            }

            function load_me() {
                if (document.getElementById("hfnames").value == '' || document.getElementById("hfItems_id").value == '') {
                    alert("Select Category");
                    return false;
                }
                else {
                    window.parent.opener.load_comp(document.getElementById("hfnames").value, document.getElementById("hfItems_id").value, document.getElementById("hfItems_id").value);
                    self.close();
                }
            }

            function assignAsset() {
                alert("Please Select Asset");
            }

            function checkassets() {
            
                if ($find("rg_asset").get_masterTableView().get_selectedItems().length == 0) {
                    alert("Please Select Asset");
                    return false;
                }

            }

            function mergeattributealert() {
                
                alert("Attributes can not be merged because asset to be merged does not have properties. Please select asset having properties.")
                return false;
            }
            function existattributealert() {
                
                alert("There are no properties for existing asset. Please select asset having properties.")
                return false;
            }
            
    
        </script>
    </telerik:RadCodeBlock>
</head>
<body style="background-position: white; background: white; padding: 0px; margin: 0px 0px 0px 0px;" >
  <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
 <telerik:RadFormDecorator ID="RadFormDecorator1" DecoratedControls="Buttons" Skin="Hay"
            runat="server" />
    <form id="form1" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="issueProfilesManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_asset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="cmbcriteria">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_asset" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
    
    
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
       
           
        <table style="margin-top: 30px; margin-left: 40px;" width="100%" border="0" >
            <caption style="margin-left:8px;">
                <asp:Label ID="lblheading" runat="server" Text="<%$Resources:Resource,Link_to_Component%>" Visible="true"></asp:Label> 
            </caption>
            <tr>
                <td align="left">
                    <table>
                        <tr>
                            <td valign="top">
                                <asp:TextBox ID="txtClass" CssClass="SmallTextBox" runat="server">
                                </asp:TextBox>
                            </td>
                            <td valign="top">
                                <telerik:RadComboBox ID="cmbcriteria"  OnSelectedIndexChanged="cmbcriteria_SelectedIndexChanged"
                                    AutoPostBack="true" runat="server" Height="100px" Width="170px">
                                    <Items>
                                        <telerik:RadComboBoxItem Value="Asset" Text="Asset" Selected="True" runat="server" Font-Size="11px" />
                                        <telerik:RadComboBoxItem Value="Space" Text="Space" runat="server" Font-Size="11px" />
                                        <telerik:RadComboBoxItem Value="Type" Text="Type" runat="server" Font-Size="11px" />
                                        <telerik:RadComboBoxItem Value="Tag Number" Text="Tag Number" runat="server" Font-Size="11px" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td valign="top">
                                <telerik:RadComboBox ID="radcombo_asset_status"  OnSelectedIndexChanged="radcombo_asset_status_SelectedIndexChanged"
                                    AutoPostBack="false" runat="server" Height="100px" Width="170px">
                                    <Items>
                                        <telerik:RadComboBoxItem Value="Overwrite" Text="Overwrite" Selected="True" runat="server"
                                            Font-Size="11px" />
                                        <telerik:RadComboBoxItem Value="Merge" Text="Merge" runat="server" Font-Size="11px" />
                                        <telerik:RadComboBoxItem Value="Existing" Text="Existing" runat="server" Font-Size="11px" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" CausesValidation="false" runat="server" Width="100px"
                                    OnClick="btnSearch_Click" Text="<%$Resources:Resource,Search%>" />
                            </td>
                            <td>
                                <asp:Button ID="btnclear" runat="server" Text="<%$Resources:Resource,Clear%>" Width="100px" OnClientClick="javascript:return Clear();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height: 369px" align="left" valign="top">
                    <telerik:RadGrid ID="rg_asset" runat="server" AllowMultiRowSelection="false" AllowPaging="True" AutoGenerateColumns="false"
                        Skin="Hay" AllowSorting="True" PageSize="10" GridLines="None" OnSortCommand="rg_component_SortCommand" OnNeedDataSource="rg_asset_OnNeedDataSource"
                        OnPageSizeChanged="rg_component_PageSizeChanged" OnPageIndexChanged="rg_component_PageIndexChanged" Width="90%" OnItemEvent='rgassets_OnItemEvent'  AllowCustomPaging="true">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible = "true" />
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                        </ClientSettings>
                        <MasterTableView ClientDataKeyNames="pk_asset_id" DataKeyNames="pk_asset_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_asset_id" Visible="false">
                                    <ItemStyle CssClass="column" />
                                </telerik:GridBoundColumn>
                                <telerik:GridClientSelectColumn>
                                    <ItemStyle Width="10%" CssClass="column" />
                                    <HeaderStyle Width="10%" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="asset_name" HeaderText="<%$Resources:Resource,Component_Name%>" >
                                    <ItemStyle HorizontalAlign="Left" Width="20%" />
                                    <HeaderStyle Width="20%" />
                                </telerik:GridBoundColumn>
                                <%--<telerik:GridBoundColumn DataField="typename" HeaderText="Type">
                                    <ItemStyle CssClass="column" HorizontalAlign="Left" />
                                </telerik:GridBoundColumn>--%>
                                <telerik:GridBoundColumn DataField="asset_description" HeaderText="<%$Resources:Resource,description%>">
                                   <ItemStyle HorizontalAlign="Left" Width="20%" />
                                    <HeaderStyle Width="20%" />
                                </telerik:GridBoundColumn>
                                   <telerik:GridBoundColumn DataField="space_name" HeaderText="<%$Resources:Resource,Space_Name%>">
                                   <ItemStyle HorizontalAlign="Left" Width="20%" />
                                    <HeaderStyle Width="20%" />
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="type_name" HeaderText="<%$Resources:Resource,Type_Name%>">
                                   <ItemStyle HorizontalAlign="Left" Width="20%" />
                                    <HeaderStyle Width="20%" />
                                </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Tagnumber" HeaderText="<%$Resources:Resource,Tag_Number%>">
                                   <ItemStyle HorizontalAlign="Left" Width="20%" />
                                    <HeaderStyle Width="20%" />
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="status" HeaderText="<%$Resources:Resource,Link_Status%>">
                                   <ItemStyle HorizontalAlign="Left" Width="10%"  Wrap="false"/>
                                    <HeaderStyle Width="20%" />
                                </telerik:GridBoundColumn>

                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <br />
                      <asp:Button ID="btnSelect" Visible="true" runat="server" Text="<%$Resources:Resource,Select%>" Width="110px" OnClientClick="javascript:return checkassets();"
                        OnClick="btnSelect_Click" />
                    <asp:Button ID="btnClose" Visible="true" runat="server" Text="<%$Resources:Resource,Close_Window%>" Width="110px"
                        OnClientClick="javascript:return closeWindow();" />
                </td>
            </tr>
            <tr>
                <td align="left">
                  
                </td>
            </tr>
        </table>

        <asp:HiddenField ID="hdnfacility" runat="server" />
    </div>
    <telerik:RadAjaxManager ID="my_pa" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_component" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rg_component">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_component" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Forest" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
    <asp:HiddenField runat="server" ID="hfentityname" />
    <asp:HiddenField runat="server" ID="hfid" />
    <asp:HiddenField ID="HiddenField1" runat="server" />
     <asp:HiddenField ID="hf_asset_id" runat="server" />
      <asp:HiddenField ID="hf_count" runat="server" />

    </form>
</body>
</html>
