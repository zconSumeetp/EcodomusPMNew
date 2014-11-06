<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LinkToSpace.aspx.cs" Inherits="App_Settings_LinkToSpace" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EcoDomus FM</title>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
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
                alert("Please Select Space");
            }

            function checkassets() {

                if ($find("rg_space").get_masterTableView().get_selectedItems().length == 0) {
                    alert("Please Select Space");
                    return false;
                }

            }
            function mergeattributealert() {

                alert("Attributes cannot be merge because space to be merge doesnot have properties.")
                return false;
            }

            function mergeattributealert1() {

                alert("Space doesn't have the properties.")
                return false;
            }
    
        </script>
    </telerik:RadCodeBlock>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
   
</head>
<body style="background-position: white; background: white; padding: 0px; margin: 0px 0px 0px 0px;" >
 <telerik:RadFormDecorator ID="RadFormDecorator1" DecoratedControls="Buttons" Skin="Hay" runat="server" />
    <form id="form1" runat="server">
    <div>
      <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
       

     <table style="margin-top: 30px; margin-left: 40px;" width="100%" border="0" >
            <caption style="margin-left:8px;">
               <asp:Label runat="server" ID="lbl_linktospace" text="<%$Resources:Resource,Link_To_Space%>"></asp:Label>
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
                                
                            </td>
                            <td valign="top">
                                <telerik:RadComboBox ID="radcombo_space_status"  OnSelectedIndexChanged="radcombo_space_status_SelectedIndexChanged"
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
                                <asp:Button ID="btnSearch" CausesValidation="false" runat="server" Width="70px"
                                    OnClick="btnSearch_Click" Text="<%$Resources:Resource,Search%>" />
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
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="true" />
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
                              <telerik:GridBoundColumn DataField="status" HeaderText="<%$Resources:Resource,Link_Status%>">
                                   <ItemStyle HorizontalAlign="Left" Width="10%"  Wrap="false"/>
                                    <HeaderStyle Width="20%" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <br />
                      <asp:Button ID="btnSelect" Visible="true" runat="server" 
                             Text="<%$Resources:Resource,Select%>" Width="110px" 
                             OnClientClick="javascript:return checkassets();" onclick="btnSelect_Click"
                        />
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
    </form>
</body>
</html>
