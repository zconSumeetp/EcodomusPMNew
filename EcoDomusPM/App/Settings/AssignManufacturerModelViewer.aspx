<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignManufacturerModelViewer.aspx.cs" Inherits="App_Settings_AssignManufacturerModelViewer" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head id="Head1" runat="server">   
    <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
       <script language="javascript" type="text/javascript">

           function assignmanufacturer() {
               var s1 = $find("<%=rg_manufacturer.ClientID %>");
               var MasterTable = s1.get_masterTableView();
               var selectedRows = MasterTable.get_selectedItems();
               var s = "";
               for (var i = 0; i < selectedRows.length; i++) {
                   s = s + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("pk_organization_id") + ",";
               }

               if (s == "") {
                   alert("Please select manufacturer");
                   return false;
               }

               else {
                   return true;
               }
           }

           function closeWindow() {
               window.opener.refresh_asset_grid();
               window.close();
           }

       </script>
       </telerik:RadCodeBlock>
</head>


<body style=" background-position:white;background:white;padding: 0px; margin: 0px 0px 0px 0px;">
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
<telerik:RadFormDecorator ID="RadFormDecorator1" DecoratedControls="Buttons" Skin="Hay"
            runat="server" />

    <form id="form1" runat="server">
    <div>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

     <table style="margin-top: 30px; margin-left: 40px;" width="100%" border="0" >
     <caption style="margin-left:8px;">
               <asp:Label ID="Label1" runat="server"  Text="<%$Resources:Resource,Assign_Manufacturer%>"></asp:Label>
            </caption>

            <tr>

            <td align="left">
            <table>

             <tr>
                   <td valign="top">
                                <asp:TextBox ID="txtsearch" CssClass="SmallTextBox" runat="server">
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
                   <telerik:RadGrid ID="rg_manufacturer" runat="server" AllowMultiRowSelection="false" AllowPaging="True" AutoGenerateColumns="false"
                        Skin="Hay" AllowSorting="True" PageSize="10" GridLines="None" 
                        OnPageSizeChanged="rg_manufacturer_PageSizeChanged" OnPageIndexChanged="rg_manufacturer_PageIndexChanged"
                        OnSortCommand="rg_manufacturer_SortCommand"
                         Width="90%">
                       
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                        </ClientSettings>
                        <MasterTableView ClientDataKeyNames="pk_organization_id" DataKeyNames="pk_organization_id">
                            <Columns>
                                
                                <telerik:GridBoundColumn DataField="pk_organization_id" Visible="false">
                                    <ItemStyle CssClass="column" />
                                </telerik:GridBoundColumn>

                                <telerik:GridClientSelectColumn>
                                    <ItemStyle Width="10%" CssClass="column" />
                                    <HeaderStyle Width="10%" />
                                </telerik:GridClientSelectColumn>

                                <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Manufacturer%>">
                                <ItemStyle CssClass="column" />
                                </telerik:GridBoundColumn>
                            
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <br />
                    
                      <asp:Button ID="btnAssign" runat="server" Text="<%$Resources:Resource,Assign%>" Width="80px" TabIndex="4" OnClientClick="javascript:assignmanufacturer();"
                     onclick="btnAssign_Click" />&nbsp;&nbsp;
                    <asp:Button ID="btnClose" runat="server" Text="<%$Resources:Resource,Close%>" Width="80px"  OnClientClick="javascript:closeWindow();" TabIndex="5"
                    />&nbsp;&nbsp;
                 </td>
            </tr>


     </table>
    
    </div>

    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>


    <telerik:RadAjaxManagerProxy ID="my_pa" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_manufacturer" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
            <telerik:AjaxSetting AjaxControlID="rg_manufacturer">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_manufacturer" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            






        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Hay" runat="server" 
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
    </form>


</body>
</html>
