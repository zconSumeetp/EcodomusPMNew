<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectFacilityPopup.aspx.cs" Inherits="App_Asset_SelectFacilityPopup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EcoDomus FM</title>

     <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
        <script language="javascript" type="text/javascript">
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
            function closeWindow() {

                var rdw = GetRadWindow();
                rdw.close();
                //self.close();
            }
           
           
            function clear_txt() {
                document.getElementById("txtSearch").value = "";
                return false;
            }
            function select_Sub_System(id, name) {

                var rdw = GetRadWindow();
                rdw.BrowserWindow.load_manufacturer(name, id);
                rdw.close();

            }
            function assignfacility() {
                alert("Please Select Facility");
            }


            function selectfacilityForType(Id,Name) 
            {
            
            //debugger
                Name = Name.replace(/#/g, "'");
                //alert(Name);
                var selectId = window.parent.document.getElementById("hfselectedId");
                if (selectId != null) {
                    window.parent.document.getElementById("hfselectedId").value = Id;
                    window.parent.document.getElementById("hfselectedname").value = Name;
                    window.parent.buttoncallback_Type();
                    closeWindow();
                }
                 //window.parent.document.getElementById("hfselectedId").value = Id;
                //window.parent.document.getElementById("hfselectedname").value = Name;
                var facilityName = parent.document.getElementById("ContentPlaceHolder1_~/App/UserControls/SyncuserControl_lbl_facility_name");
                if (facilityName != null) {
                    parent.document.getElementById("ContentPlaceHolder1_~/App/UserControls/SyncuserControl_lbl_facility_name").innerHTML = Name;
                    parent.document.getElementById("ContentPlaceHolder1_~/App/UserControls/SyncuserControl_hlblFacilityName").value = Name;
                    parent.document.getElementById("ContentPlaceHolder1_~/App/UserControls/SyncuserControl_hlblFacilityID").value = Id;
                    closeWindow();
                }
            }
    
        </script>
    </telerik:RadCodeBlock>
</head>
<body  style="background-position: white; background: white;">
    <form id="form1" runat="server">
   
    
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" Skin="Hay" DecoratedControls="Buttons" />
    <table id="man_serch" width="50%" style="vertical-align: top; margin-left: 20px;
     margin-top: 20px;" border="0">
        <tr>
            <td style="margin-right: 1px">
                <asp:TextBox ID="txtSearch" runat="server" TabIndex="1" Width="200px"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Width="100px" Text="<%$Resources:Resource,Search%>"
                    TabIndex="2" onclick="btnSearch_Click"/>
                   
                <asp:Button ID="btnclear" runat="server" Text="<%$Resources:Resource,Clear%>" Width="100px" OnClientClick="javascript:return clear_txt();" />
            </td>
        </tr>
    </table>

    
     <table id="Table1" width="80%" style="vertical-align: top; margin-left: 20px; margin-bottom:10px;
     margin-top: 10px;" border="0">
     <tr>
     <td width="100%">
        <telerik:RadGrid ID="RgFacility" AllowMultiRowSelection="true"  runat="server" AllowPaging="True" AutoGenerateColumns="false"
            AllowSorting="True" PagerStyle-AlwaysVisible="true" Width="50%" PageSize="10" OnSortCommand="RgFacility_sortcommand"
            GridLines="None" Skin="Hay" OnPageIndexChanged="RgFacility_pageindexchanged" OnPageSizeChanged="RgFacility_OnPageSizeChanged">
            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
            <ClientSettings>
                <Selecting AllowRowSelect="true"  />
            </ClientSettings>
            <MasterTableView ClientDataKeyNames="facility_id" DataKeyNames="facility_id">
                <Columns>
                    <telerik:GridBoundColumn DataField="facility_id" Visible="false">
                        <ItemStyle CssClass="column" />
                    </telerik:GridBoundColumn>

                    <telerik:GridClientSelectColumn >
                        <ItemStyle Width="10px" />
                        <HeaderStyle Width="10px" />

                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Facility_Name%>" SortExpression="Name">
                        <ItemStyle CssClass="column" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        </td>
        </tr>
    </table>
      <table id="Table2" width="40%" style="vertical-align: top; margin-left: 20px;"
         border="0">
       
        <tr>
            <td>
                <asp:Button ID="btnAssign" runat="server" Text="<%$Resources:Resource,Assign%>" Width="100px" TabIndex="4"
                    ValidationGroup="my_validation" onclick="btnAssign_Click"/>&nbsp;&nbsp;
                <asp:Button ID="btnClose" runat="server" Text="<%$Resources:Resource,Close%>" Width="100px"  OnClientClick="javascript:closeWindow();" TabIndex="5"
                    ValidationGroup="my_validation" />&nbsp;&nbsp;                  
            </td>
        </tr>
        </table>
       
   
   
    </form>
</body>
</html>
