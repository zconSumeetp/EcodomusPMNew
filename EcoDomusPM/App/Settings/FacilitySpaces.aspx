<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FacilitySpaces.aspx.cs" Inherits="App_Settings_FacilitySpaces" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1"  runat="server">
    <title>EcoDomus FM</title>
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





            function assignAsset() {
                alert("Please Select Asset");
            }

            function checkassets() {

                if ($find("rg_space").get_masterTableView().get_selectedItems().length == 0) {
                    alert("Please Select Space");
                    return false;
                }

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
                    <telerik:AjaxUpdatedControl ControlID="rg_space" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px" Skin="Forest">
        
    </telerik:RadAjaxLoadingPanel>
    
    
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
       
           
        <table style="margin-top: 30px; margin-left: 40px;" width="100%" border="0" >
            <caption style="margin-left:8px;">
                Assign Space to Assets:
            </caption>
            <tr>
                <td align="left">
                    <table>
                        <tr>
                            <td valign="top">
                                <asp:TextBox ID="txtClass" CssClass="SmallTextBox" runat="server">
                                </asp:TextBox>
                            </td>
                           
                           
                            <td>
                                <asp:Button ID="btnSearch" CausesValidation="false" runat="server" Width="70px" OnClick="btnSearch_Click"
                                     Text="<%$Resources:Resource,Search%>" />
                            </td>
                            <td>
                                <asp:Button ID="btnclear" runat="server" Text="<%$Resources:Resource,Clear%>" Width="70px" OnClientClick="javascript:return Clear();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height: 369px" align="left" valign="top">
                    <telerik:RadGrid ID="rg_space" runat="server" AllowMultiRowSelection="false" AllowPaging="True" AutoGenerateColumns="false"
                        Skin="Hay" AllowSorting="True" PageSize="10" GridLines="None" 
                        OnPageSizeChanged="rg_space_PageSizeChanged" OnPageIndexChanged="rg_space_PageIndexChanged"
                        OnSortCommand="rg_space_SortCommand"
                         Width="90%"
                        >
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                        </ClientSettings>
                        <MasterTableView ClientDataKeyNames="pk_location_id" DataKeyNames="pk_location_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_location_id" Visible="false">
                                    <ItemStyle CssClass="column" />
                                </telerik:GridBoundColumn>
                                <telerik:GridClientSelectColumn>
                                    <ItemStyle Width="10%" CssClass="column" />
                                    <HeaderStyle Width="10%" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Space_Name%>" >
                                    <ItemStyle HorizontalAlign="Left" Width="20%" Wrap="false" />
                                    <HeaderStyle Width="20%" />
                                </telerik:GridBoundColumn>
                               
                                <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>">
                                   <ItemStyle HorizontalAlign="Left" Width="20%"  Wrap="false"/>
                                    <HeaderStyle Width="20%" />
                                </telerik:GridBoundColumn>
                            
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <br />
                      <asp:Button ID="btnSelect" Visible="true" runat="server" Text="<%$Resources:Resource,Assign%>" Width="110px" OnClientClick="javascript:return checkassets();"
                         OnClick="btnSelect_Click"/>
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
           
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Hay" runat="server" 
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
    <asp:HiddenField runat="server" ID="hfentityname" />
    <asp:HiddenField runat="server" ID="hfid" />
    <asp:HiddenField ID="HiddenField1" runat="server" />
    </form>
</body>
</html>
