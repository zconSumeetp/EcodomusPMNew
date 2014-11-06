<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MapLocationHierarchy.aspx.cs" Inherits="App_Locations_MapLocationHierarchy" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <title>EcoDomus FM : Map Location Hierarchy</title>
    <%--    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
 <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">

        <script type="text/javascript" language="javascript">

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function RefreshHierarchy() {

                var rdw = GetRadWindow();
                rdw.BrowserWindow.regreshgrid();
                rdw.close();
            }

            
            function closeWindow_assign() {
                var rdw = GetRadWindow();
                rdw.close();
            }

            function bindproviders() {
                var rdw = GetRadWindow();
                rdw.BrowserWindow.rebindgrid();
                rdw.close();
            }

            function closeWindow() {
                self.close();
            }

            function select_Sub_System(id, name) {

                var rdw = GetRadWindow();
                rdw.BrowserWindow.load_omni_class(name, id);
                rdw.close();
               
            }


            function load_me() {

                if (document.getElementById("hfnames").value == '' || document.getElementById("hfItems_id").value == '') {
                    alert("Select Category");
                    return false;
                }
                else {
                    window.parent.opener.load_omni_class(document.getElementById("hfnames").value, document.getElementById("hfItems_id").value);
                    self.close();
                }
            }

            function get_click_event() {

             

                document.getElementById("btn_Click").click();



            }









        </script>

    </telerik:RadCodeBlock>
   
</head>
<body>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
       <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" Skin="Hay" DecoratedControls="Buttons"  />
    <div style="margin-left:100px;margin-top:50px;">
    
      <table border="0" style="width: 100%">
      <caption>
          <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,  Location_Hierarchy%>"></asp:Label>
     :
      </caption>

            <tr style="height: 20px;">
               
                <td style="text-align: left; width: 100%;" >
                    <asp:Table runat="server" ID="aspTblHierarchy" BorderColor="#000066" BorderStyle="Solid">
                        <asp:TableRow ID="level0" runat="server" Visible="false" >
                        
                            <asp:TableCell ID="tc_level0_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level0_db_table_name" runat="server">
                            <telerik:RadComboBox ID="rcblevel0" runat="server"   ></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level1" runat="server" Visible="false">
                        
                            <asp:TableCell ID="tc_level1_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level1_db_table_name" runat="server">
                            <telerik:RadComboBox ID="rcblevel1" runat="server"   ></telerik:RadComboBox>
                            
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level2" runat="server" Visible="false">
                        
                            <asp:TableCell ID="tc_level2_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level2_db_table_name" runat="server">
                            <telerik:RadComboBox     ID="rcblevel2" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level3" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level3_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level3_db_table_name" runat="server">
                            <telerik:RadComboBox     ID="rcblevel3" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level4" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level4_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level4_db_table_name" runat="server">
                            <telerik:RadComboBox     ID="rcblevel4" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level5" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level5_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level5_db_table_name" runat="server">
                            <telerik:RadComboBox     ID="rcblevel5" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level6" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level6_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level6_db_table_name" runat="server">
                            <telerik:RadComboBox     ID="rcblevel6" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level7" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level7_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level7_db_table_name" runat="server">
                            <telerik:RadComboBox     ID="rcblevel7" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level8" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level8_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level8_db_table_name" runat="server">
                            <telerik:RadComboBox     ID="rcblevel8" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level9" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level9_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level9_db_table_name" runat="server">
                            <telerik:RadComboBox     ID="rcblevel9" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </td>
                
            </tr>
            <tr style="height: 20px;">
                <td style="text-align: left;" class="style1">
                <asp:Button ID="btn_save_hierarchy" Text="<%$Resources:Resource,  Save_Hierarchy%>" runat="server" 
                 OnClientClick="javascript:get_click_event();"      />
                     <asp:Button ID="btn_close" runat="server" Text="<%$Resources:Resource,  Close%>" OnClientClick="javascript:closeWindow();" />

                </td>
              
            </tr>
            <tr>
              <td>
                    <asp:Label ID="lblMsg" runat="server" ForeColor="red"></asp:Label>
                </td>
            
            </tr>
        
        </table>

         <div id="divbtn" style="display: none;">
       
        <asp:Button ID="btn_Click" runat="server" OnClick="btn_Click_Click" Style="display: none;" />
    </div>
    </div>
    </form>
</body>
</html>
