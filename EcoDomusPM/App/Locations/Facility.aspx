<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Facility.aspx.cs" Inherits="App_Locations_Facility" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link rel="stylesheet" type="text/css" href="../App_Themes/EcoDomus/style.css" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table id="orgprofile" width="80%" style="vertical-align: top; margin-left: 120px;
        margin-top: 60px; border: 1;" cellpadding="0" cellspacing="0">
        <caption>
            Select Facility
        </caption>
        <tr>
            <td>
                <asp:TextBox CssClass="SmallTextBox" ID="srch_txt_box" runat="server" TabIndex="1"></asp:TextBox>&nbsp;&nbsp;
                <asp:Button ID="btnSearch" Width="75px" runat="server" Text="Search" TabIndex="2"
                    />
                <asp:Button ID="btnclear" runat="server" Text="Clear" TabIndex="3" Width="75px" />
            </td>
        </tr>
        <tr>
            <td style="height: 10px">
            </td>
        </tr>
        <tr>
            <td>
                <telerik:radgrid id="rgFacility" runat="server" allowpaging="True" skin="Hay" width="350px"
                    allowsorting="True" autogeneratecolumns="False"
                    >
                    <MasterTableView DataKeyNames="ID,cons_string,Name,client_id,Client_Name">
                        <Columns>
                            <telerik:GridBoundColumn DataField="ID" HeaderText="ID" Display="false" SortExpression="ID"
                                UniqueName="ID">
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn DataTextField="Name" HeaderText="Name" ButtonType="LinkButton"
                                SortExpression="name" CommandName="Facility">
                                <HeaderStyle BackColor="Transparent" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="cons_string" HeaderText="ID" Display="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="client_name" HeaderText="Client Name" Display="true"
                                SortExpression="client_name" UniqueName="client_name">
                                <HeaderStyle BackColor="Transparent" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:radgrid>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbl_msg" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
