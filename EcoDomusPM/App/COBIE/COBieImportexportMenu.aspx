<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomus_PM_New.master"  AutoEventWireup="true" CodeFile="COBieImportexportMenu.aspx.cs" Inherits="App_COBIE_COBieImportexportMenu" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Src="~/App/COBIE/CobieImport.ascx" TagName="CobieImport" TagPrefix="coi" %>
<%@ Register Src="~/App/COBIE/CobieExport.ascx" TagName="CobieExport" TagPrefix="cox" %>

<%--<meta http-equiv="refresh" content="15"/>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" Runat="Server">
    <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
 <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
--%>
 <table align="left" width="100%" style="margin: 0px 0px 0px 0px;height:100%";  cellpadding="0"  >
     <tr>
                        <td colspan="" style="width: 100%" valign="top" >
                            <telerik:RadTabStrip ID="rdstripcobie" SelectedIndex="0" runat="server" 
                                MultiPageID="rmpagecobie" ValidationGroup="LoginValidationGroup">
                              <Tabs >
                              <telerik:RadTab  runat="server" Text ="<%$Resources:Resource,Import %>" Selected="True" >
                              
                              </telerik:RadTab>
                              <telerik:RadTab  runat="server" Text ="<%$Resources:Resource,Export %>">
                              
                              </telerik:RadTab>
                              </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                    </tr>
                    <tr>
                         <td style="width: 100%" valign="top">
                                            <telerik:RadMultiPage ID="rmpagecobie" runat="server" CssClass="multiPage" 
                                                SelectedIndex="0">
                                            <telerik:RadPageView ID="rpvimport" runat="server" Enabled="true" >
                                            <coi:CobieImport ID="coiImport" runat ="server"  />
                                            </telerik:RadPageView>
                                            <telerik:RadPageView ID="rpvExport" runat ="server" >
                                            
                                               <cox:CobieExport ID="CobieExport1" runat="server" />
                                            
                                            </telerik:RadPageView>
                                            </telerik:RadMultiPage>
                                        </td>
                       </tr>
                    <%--<tr>
                    <td valign="top" style="width: 100%" >
                 
                                <table width="100%" >
                                    
                                </table>
                           
                        </td>
                        </tr>--%>
          </table>
</asp:Content>

