<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/App/EcoDomusPM_Master.master"  CodeFile="EnergyEquipment.aspx.cs" Inherits="App_Asset_EnergyEquipment" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <link rel="stylesheet" href="../App_Themes/EcoDomus/style_new_1.css" type="text/css" />

   <div class="exampleWrapper" width="100%" height="900px"  >
       <table width="80%">
           <tr align="right">
               <td align="right" onclick="stopPropagation(event)">
                   <div onclick="stopPropagation(event)" style="background-color: White; width: 243px;
                       height: 22px">
                       <table border="0" width="80%">
                           <tr>
                               <td>
                                 <%--  <telerik:RadTextBox runat="server" EmptyMessage="Search" ID="txt_search" Height="15px">
                                   </telerik:RadTextBox>--%>
                                    <asp:DropDownList runat="server" Width="150px" ID="txt_Search" Height="15px"></asp:DropDownList>
                               </td>
                               <td>
                                   <asp:ImageButton ID="btn_searchimg" Height="15px" AlternateText="Search" Width="80px"
                                       runat="server" ImageUrl="~/App/Images/Icons/btnSearch.png" />
                               </td>
                           </tr>
                       </table>
                   </div>
               </td>
           </tr>
       </table>
       <table width="100%" style="height: 100%;">
           <tr>
               <td align="right">
               </td>
           </tr>
           <tr style="height: 10%; background-color: Gray; border-color: Yellow; border-width: 1px;">
               <td style="margin-left: 10%;">
                   <asp:Label ID="Label1" runat="server" Text="Equipment" Font-Size="Medium" ForeColor="White"></asp:Label>
               </td>
           </tr>
           <tr>
               <td align="right">
               </td>
           </tr>
           <tr>
               <td>
                   <telerik:RadGrid ID="rgorders" runat="server" AutoGenerateColumns="False" OnColumnCreated="RadGrid1_ColumnCreated"
                       BorderWidth="2px" AllowSorting="True" AllowPaging="True" PageSize="10" GridLines="None"
                       ShowGroupPanel="True" AllowMultiRowSelection="true" PagerStyle-AlwaysVisible="false">
                       <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="left" Width="80%" AlwaysVisible="true" />
                       <ClientSettings>
                           <Selecting AllowRowSelect="true" />
                           <ClientEvents OnRowSelected="onrowselected" OnRowDeselected="onrowsdeselected" />
                       </ClientSettings>
                       <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" AlwaysVisible="true" />
                       <MasterTableView DataKeyNames="zone_id,zone_name,zone_desc" AllowMultiColumnSorting="True"
                           GroupLoadMode="Server" ExpandCollapseColumn-Visible="false" HeaderStyle-CssClass="gridHeaderText">
                           <Columns>
                               <telerik:GridClientSelectColumn HeaderStyle-Width="20px" HeaderStyle-VerticalAlign="Top"
                                   ButtonType="ImageButton" ImageUrl="../Images/checkbox2.png">
                               </telerik:GridClientSelectColumn>
                               <%--   <telerik:GridTemplateColumn HeaderText="Status" ItemStyle-Width="150px">
                                                <ItemTemplate>
                                                    <telerik:RadButton ID="btn_disabled" runat="server" ToggleType="CustomToggle" AutoPostBack="false"
                                                        Width="58px" ButtonType="ToggleButton">
                                                        <ToggleStates>
                                                            <telerik:RadButtonToggleState PrimaryIconUrl="../Images/disable_toggle1.png" PrimaryIconHeight="20px"
                                                                PrimaryIconWidth="150px" />
                                                            <telerik:RadButtonToggleState PrimaryIconUrl="../Images/disable_toggle2.png" PrimaryIconHeight="20px"
                                                                PrimaryIconWidth="150px" />
                                                        </ToggleStates>
                                                    </telerik:RadButton>
                                                   
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>--%>
                               <telerik:GridBoundColumn DataField="zone_name" HeaderText="Zone List" SortExpression="ContactTitle"
                                   ItemStyle-Width="200px" UniqueName="Name">
                               </telerik:GridBoundColumn>
                               <telerik:GridBoundColumn DataField="zone_name" HeaderText="Zone Name" SortExpression="ContactTitle"
                                   ItemStyle-Width="200px" UniqueName="Name">
                               </telerik:GridBoundColumn>
                               <telerik:GridBoundColumn DataField="zone_desc" HeaderText="Zone Volume" SortExpression="ContactTitle"
                                   ItemStyle-Width="200px" UniqueName="Name">
                               </telerik:GridBoundColumn>
                               <telerik:GridBoundColumn DataField="zone_desc" HeaderText="Equipment" SortExpression="ContactTitle"
                                   ItemStyle-Width="200px" UniqueName="Name">
                               </telerik:GridBoundColumn>
                               <telerik:GridTemplateColumn HeaderText="Schedule" UniqueName="action" ItemStyle-HorizontalAlign="Left"
                                   ItemStyle-Width="200px" HeaderStyle-Width="100px" ItemStyle-Height="18px">
                                   <ItemTemplate>
                                       <table style="display: none;" id="tbl_img" runat="server">
                                           <tr>
                                               <td>
                                                   VIEW LIMITS & SCHEDULES
                                               </td>
                                               <td>
                                                   <asp:ImageButton ID="img_view" ImageUrl="~/App/Images/down-arrow.png" runat="server"
                                                       CommandName="expandcolumn" Height="10px" />
                                               </td>
                                           </tr>
                                       </table>
                                   </ItemTemplate>
                               </telerik:GridTemplateColumn>
                               <%--<telerik:GridBoundColumn DataField="CompanyName" HeaderText="Actions" SortExpression="CompanyName"
                                                UniqueName="CompanyName">
                                            </telerik:GridBoundColumn>--%>
                           </Columns>
                           <NestedViewSettings>
                               <ParentTableRelation>
                                   <telerik:GridRelationFields DetailKeyField="CustomerID" MasterKeyField="CustomerID" />
                               </ParentTableRelation>
                           </NestedViewSettings>
                           <NestedViewTemplate>
                               <asp:Panel ID="NestedViewPanel" runat="server" CssClass="viewWrap" BackColor="#DBDBDB">
                                   <div class="contactWrap">
                                       <fieldset style="padding: 10px;">
                                           <table width="100%">
                                               <tr>
                                                   <td width="50%" valign="top">
                                                       <b>Limits Schedule</b>
                                                       <br />
                                                       <br />
                                                       <asp:Table runat="server" ID="tbl_limit_schedule" BorderWidth="1px" BorderColor="Gray"
                                                           Style="border-collapse: collapse; width: 80%; background-color: white;">
                                                       </asp:Table>
                                                       <br />
                                                       <asp:Table ID="Table1" Width="80%" runat="server">
                                                           <asp:TableRow>
                                                               <asp:TableCell ColumnSpan="3" HorizontalAlign="Right" BorderWidth="0px">
                                                                   <telerik:RadButton ID="radbtnundo" runat="server" Text="Undo" CommandName="cmdundo">
                                                                   </telerik:RadButton>
                                                                   <telerik:RadButton ID="radbtnsave" runat="server" Text="Save" CommandName="cmdsave">
                                                                   </telerik:RadButton>
                                                               </asp:TableCell>
                                                           </asp:TableRow>
                                                       </asp:Table>
                                                   </td>
                                                   <td width="50%" valign="top" id="tdsimulationvalueschedule" runat="server">
                                                       <b>Simulation Values Schedule</b>
                                                       <%-- <br />
                                                                    <b>Through:</b>
                                                                    <asp:Label ID="lblthrough" runat="server"></asp:Label>--%>
                                                       <br />
                                                       <br />
                                                       <telerik:RadMultiPage ID="radmltschedules" runat="server">
                                                           <%-- <telerik:RadPageView ID="sub1" runat="server">
                                                                            <asp:Table runat="server" ID="tbl_header" BorderWidth="1px" BorderColor="Gray" Style="border-collapse: collapse;
                                                                                width: 70%; background-color: white;">
                                                                                <asp:TableHeaderRow>
                                                                                    <asp:TableHeaderCell Text="HOUR" BorderWidth="1px" BorderColor="Gray" HorizontalAlign="Center"
                                                                                        Height="25px" Width="47.90%">
                                                                                    </asp:TableHeaderCell>
                                                                                    <asp:TableHeaderCell Text="VALUE" BorderWidth="1px" BorderColor="Gray" HorizontalAlign="Center"
                                                                                        Height="25px" Width="52.30%">
                                                                                    </asp:TableHeaderCell>
                                                                                </asp:TableHeaderRow>
                                                                            </asp:Table>--%>
                                                           <%--<asp:Panel runat="server" ScrollBars="Vertical" ID="pnl_simulation_value_schedule">
                                                                                <asp:Table runat="server" ID="tbl_simulation_value_schedule" BorderWidth="1px" BorderColor="Gray"
                                                                                    Style="border-collapse: collapse; width: 95%; background-color: white;">
                                                                                </asp:Table>
                                                                            </asp:Panel>--%>
                                                           <%-- </telerik:RadPageView>--%>
                                                       </telerik:RadMultiPage>
                                                       <telerik:RadTabStrip runat="server" MultiPageID="radmltschedules" ID="radtabstripschedule"
                                                           Orientation="HorizontalBottom">
                                                       </telerik:RadTabStrip>
                                                       <br />
                                                       <asp:Table ID="Table2" Width="80%" runat="server">
                                                           <asp:TableRow>
                                                               <asp:TableCell ColumnSpan="3" HorizontalAlign="Right" BorderWidth="0px">
                                                                   <telerik:RadButton ID="radbtnundoschedule" runat="server" Text="Undo" CommandName="cmdundo">
                                                                   </telerik:RadButton>
                                                                   <telerik:RadButton ID="radbtnsaveschedule" runat="server" Text="Save" CommandName="cmdsave">
                                                                   </telerik:RadButton>
                                                               </asp:TableCell>
                                                           </asp:TableRow>
                                                       </asp:Table>
                                                   </td>
                                               </tr>
                                           </table>
                                       </fieldset>
                                   </div>
                               </asp:Panel>
                           </NestedViewTemplate>
                       </MasterTableView>
                       <PagerStyle Mode="NumericPages"></PagerStyle>
                       <ClientSettings AllowDragToGroup="true" />
                   </telerik:RadGrid>
               </td>
           </tr>
       </table>
   </div>


</asp:Content>