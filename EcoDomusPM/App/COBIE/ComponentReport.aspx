<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/App/EcoDomusPM_Master.master"  CodeFile="ComponentReport.aspx.cs" Inherits="App_COBIE_ComponentReport" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Src="~/App/COBIE/ComponentReportExport.ascx" TagName="ComponentReportExport" TagPrefix="cre" %>

<%--<meta http-equiv="refresh" content="15"/>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" Runat="Server">
 <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
 <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />--%>
 

 <table width="100%" style="margin:  10px 50px 0px 20px;height:100%;"  cellpadding="0" >
                     <tr>
                        <td colspan="2" style="width: 100%" valign="top" >
                            <telerik:RadTabStrip ID="rdstripcomponent" SelectedIndex="0" runat="server" 
                                MultiPageID="rmpagecobie" ValidationGroup="LoginValidationGroup">
                              <Tabs >
                               <telerik:RadTab  runat="server" Text ="<%$Resources:Resource,Export%>" Selected="true">
                              
                              </telerik:RadTab>
                              </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" style="width: 100%" >
                           
                                <table width="100%" >
                                    <tr>
                                        <td style="width: 100%" valign="top">
                                            <telerik:RadMultiPage ID="rmpagecobie" runat="server" CssClass="multiPage" 
                                                SelectedIndex="0">
                                             <telerik:RadPageView ID="rpvExport" runat ="server" >
                                             <cre:ComponentReportExport ID="ComponetExport" runat="server" />                                          
                                            </telerik:RadPageView>
                                            </telerik:RadMultiPage>
                                        </td>
                                    </tr>
                                </table>
                           
                        </td>
                        </tr>
                        </table>
</asp:Content>
