<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Select_Facility.aspx.cs" Inherits="App_Locations_Select_Facility"  EnableEventValidation="false" %>

 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EcoDomus FM : Select Facility</title>  
</head>
<body>
<telerik:RadCodeBlock ID="radcodeblock2" runat="server">

        <script language="javascript" type="text/javascript">

          

            function Clear() {

                document.getElementById("txtSearch").value = "";
                return false;

            }

            function select_facility(id, name) {
              
                var rdw = GetRadWindow();
                rdw.BrowserWindow.load_facilityname(name, id);

                rdw.close();
                window.close();

          
            }

            function closeWindow() {
               
                self.close();
            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function alert_msg() {

                alert("Select at least one facility");
                return false;
            }


    
        </script>

    </telerik:RadCodeBlock>
   


    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" Skin="Hay" DecoratedControls="Buttons"/>
    <div>

    <table border="0" style="margin-top: 30px; margin-left: 50px;">
    <tr>
    <td>
        <asp:TextBox ID="txtSearch" runat="server" ></asp:TextBox>
    </td>
    <td>
   <telerik:RadButton ID="btnSearch" runat="server" Text="<%$Resources:Resource, Search%>" Width="100px" TabIndex="2" OnClick="btnSearch_Click" />
    </td>
     <td>
     <telerik:RadButton ID="btnClear" runat="server"  Text="<%$Resources:Resource, Clear%>" Width="100px"  Skin="Hay" OnClientClicked="Clear"/>
     </td>
    </tr>

    </table>
    <table border="0" style="margin-top: 30px; margin-left: 50px;" width="100%">
    <tr>
         <td>
               <telerik:RadGrid id="rg_facility" runat="server" AllowPaging="True" AutoGenerateColumns="false"
                            AllowSorting="True" PagerStyle-AlwaysVisible="true" Width="80%" PageSize="10"
                            GridLines="None" Skin="Hay"  Visible="true" OnSortCommand="rg_facility_sortcommand" OnPageIndexChanged="rg_facility_OnpageIndexChanged" OnPageSizeChanged="rg_facility_OnPageSizeChanged" >
                     <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                         <ClientSettings>
                                <Selecting AllowRowSelect="true" />
                                
                         </ClientSettings> 
                     <MasterTableView DataKeyNames="facility_id">     
                     <Columns>
                           <telerik:GridBoundColumn DataField="facility_id" Visible="false">
                                 <ItemStyle CssClass="column" />
                                    </telerik:GridBoundColumn>
                              

                                     <telerik:GridClientSelectColumn>
                                     <ItemStyle Width="10px"/>
                                        <HeaderStyle Width="10px" />
                                     </telerik:GridClientSelectColumn>
                                     
                                      
                                    <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource, Facility%>" SortExpression="name">
                                 <ItemStyle CssClass="column" />
                           </telerik:GridBoundColumn>
                             <%--<telerik:GridBoundColumn DataField="name"  HeaderText="<%$Resources:Resource, Description%>" SortExpression="name" >
                                 <ItemStyle CssClass="column" />
                           </telerik:GridBoundColumn>--%>
                      </Columns>
                      </MasterTableView>
                            
                  </telerik:RadGrid>
                  
               
            </td>
            
        </tr>

        <tr>
        <td>
        <asp:Button ID="btnSelectFacility" runat="server" Width="100px" Text="<%$Resources:Resource, Select_Facility%>" OnClick="btn_select_click" />
          
        <asp:Button ID="btnClose" runat="server" Width="100px" Text="<%$Resources:Resource, Close%>" OnClientClick="javascript:return closeWindow();" />  
                </td>
      
        </tr>
    
    </table>
    
    </div>
    <telerik:RadAjaxManager ID="ajax_facility" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSelectFacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_facility" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_facility" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rg_facility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_facility" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel Skin="Forest" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>



    </form>
</body>
</html>
