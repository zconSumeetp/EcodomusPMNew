<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkOrderPDFs.aspx.cs" Inherits="App_Asset_IssuePDF" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Issue Report</title>
    <style type="text/css">
        .GridRow_Gray td, .GridAltRow_Gray td
        {
            border: none;
            border-collapse: inherit;
        }
    </style>
    <style type="text/css">
        #rgIssue
        {
            border: solid 2px black;
        }
        #rgIssue td
        {
            border-bottom: none;
            border-top: none;
            border-right: solid 1px black;
            border-collapse: collapse;
        }
        #rgIssue thead th
        {
            border-bottom: solid 1px black;
            border-top: none;
            border-right: solid 1px black;
            border-collapse: collapse;
            background: #F5F5F5;
        }
    </style>
</head>
<body>
    <%--lastly edited by ganesh for issue 340 5/Aug/2010--%>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="S1" runat="server">
    </asp:ScriptManager>
    <div>
        <table width="100%">
            <caption style="font-size: 25px">
            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Issue_Report%>"></asp:Label>
                </caption>
            <tr>
                <td align="center" style="font-size: 25px">
                    <asp:Panel ID="panelFrm" runat="server" Visible="true">
                    <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,From%>">:</asp:Label>
                        &nbsp;<asp:Label ID="lblfromdate" runat="server" Style="font-size: 20px; float: inherit"></asp:Label>
                        &nbsp;- <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,To%>">:</asp:Label>&nbsp;&nbsp;&nbsp;<asp:Label ID="lbltodate" runat="server" Style="font-size: 20px;
                            float: inherit"></asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="panelTo" runat="server" Visible="true">
                        &nbsp;&nbsp;
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td>
                    <div style="margin-top: 15px">
                        <telerik:RadGrid ID="rgIssue" runat="server" BorderWidth="1px" CellPadding="0" Width="107%"
                            Skin="Hay" AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True"
                            OnItemDataBound="rgIssue_ItemDataBound" PagerStyle-AlwaysVisible="true" GridLines="None"
                            TabIndex="7">
                            <HeaderStyle ForeColor="black" Font-Bold="true" BorderStyle="Solid" BorderWidth="1px"
                                BorderColor="black" />
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="50%" />
                            <MasterTableView DataKeyNames="pk_work_order_id">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="pk_work_order_id" HeaderText="cb_issues_id" Visible="false">
                                        <ItemStyle CssClass="column" Width="100px" />
                                        <HeaderStyle HorizontalAlign="Left" Height="60" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="work_ordername" CommandName="Profile"
                                        HeaderText="<%$Resources:Resource,Issue_Name%>" SortExpression="work_ordername">
                                        <ItemStyle CssClass="column" Font-Underline="true" Width="100px" />
                                        <HeaderStyle HorizontalAlign="Left" Height="60" />
                                    </telerik:GridButtonColumn>

                                    <telerik:GridBoundColumn DataField="work_order_number" HeaderText="<%$Resources:Resource,Issue_Number%>" SortExpression="work_order_number">
                                        <ItemStyle CssClass="column" Width="100px" />
                                        <HeaderStyle HorizontalAlign="Left" Height="60" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="work_order_type" UniqueName="Owner" HeaderText="<%$Resources:Resource,Issue_Type%>"
                                        SortExpression="work_order_type">
                                        <ItemStyle CssClass="column" Width="100px" />
                                        <HeaderStyle HorizontalAlign="Left" Height="60" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="Priority" HeaderText="<%$Resources:Resource,Priority%>" SortExpression="Priority">
                                        <ItemStyle CssClass="column" Width="80px" />
                                        <HeaderStyle HorizontalAlign="Left" Height="60" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="organizationusername" HeaderText="<%$Resources:Resource,Assigned_To%>" SortExpression="organizationusername">
                                        <ItemStyle CssClass="column" Width="80px" />
                                        <HeaderStyle HorizontalAlign="Left" Height="60" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="requested_by" Visible="true" HeaderText="<%$Resources:Resource,Requested_By%>" SortExpression="requested_by" >
                                       <ItemStyle CssClass="column" Width="80px" />
                                        <HeaderStyle HorizontalAlign="Left" Height="60" />
                                    </telerik:GridBoundColumn>

                                      <telerik:GridBoundColumn DataField="created_on" HeaderText="<%$Resources:Resource,Created_On%>" SortExpression="created_on">
                                        <ItemStyle CssClass="column" Width="100px" />
                                        <HeaderStyle HorizontalAlign="Left" Height="60" />
                                    </telerik:GridBoundColumn>
                                     
                                     <telerik:GridBoundColumn DataField="work_orderstatus" HeaderText="<%$Resources:Resource, Issue_Status%>" SortExpression="work_orderstatus" Visible="true">                                    
                                       <ItemStyle CssClass="column" Width="100px" />
                                        <HeaderStyle HorizontalAlign="Left" Height="60" />
                                     </telerik:GridBoundColumn>


                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
        
        </table>
    </div>
    </form>
</body>
</html>