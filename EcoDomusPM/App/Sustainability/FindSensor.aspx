<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true"
    CodeFile="FindSensor.aspx.cs" Inherits="App_Sustainability_FindSensor" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,Scrollbars,Select" />
    <div id="page">
        <table>
            <tr>
                <td valign="top">
                    <table cellspacing="10px" cellpadding="10px">
                        <tr>
                            <td>
                                <asp:Button ID="btnsearch" runat="server" Text="Search" />
                            </td>
                            <td>
                                <asp:Button ID="btnclear" runat="server" Text="Clear" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label CssClass="LabelText" Text="Search By" runat="server"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadComboBox runat="server">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="Asset" Value="asset" />
                                        <telerik:RadComboBoxItem Text="Space" Value="space" />
                                        <telerik:RadComboBoxItem Text="Facility" Value="facility" />
                                        <telerik:RadComboBoxItem Text="System" Value="system" />
                                        <telerik:RadComboBoxItem Text="Floor" Value="floor" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label CssClass="LabelText" Text="Criteria" runat="server"></asp:Label>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="RadComboBox1" runat="server">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="Name" Value="name" />
                                        <telerik:RadComboBoxItem Text="Description" Value="description" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label CssClass="LabelText" Text="Searh Text:" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtsearch" Width="155px" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label Text="Search Result" CssClass="LabelText" runat="server"></asp:Label>
                                <telerik:RadTreeView ID="radtreeview" runat="server">
                                </telerik:RadTreeView>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                    <table cellspacing="10px" cellpadding="10px">
                        <tr>
                            <td style="width: 260px;" valign="top">
                                <fieldset>
                                    <legend>Data Sources</legend>
                                    <table cellspacing="10px" cellpadding="10px">
                                        <tr>
                                            <td>
                                                <asp:RadioButtonList runat="server" RepeatDirection="Vertical">
                                                    <asp:ListItem Text="Real Time Data" Value="r"></asp:ListItem>
                                                    <asp:ListItem Text="Historical Data" Value="h"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                            <td align="left">
                                                <asp:Button ID="btnupdate" runat="server" Text="Update" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label CssClass="LabelText" runat="server" Text="Start Date/ Time:"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:RadDatePicker ID="raddatepickerstartdate" runat="server" Width="170px">
                                                    <DateInput DateFormat="dddd, MMMM d yyyy">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                                <br />
                                                <telerik:RadTimePicker runat="server" Width="170px">
                                                </telerik:RadTimePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" CssClass="LabelText" runat="server" Text="End Date/ Time:"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:RadDatePicker ID="raddatepickerenddate" runat="server" Width="170px">
                                                    <DateInput DateFormat="dddd, MMMM d yyyy">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                                <br />
                                                <telerik:RadTimePicker ID="RadTimePicker1" Width="170px" runat="server">
                                                </telerik:RadTimePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="chkweatherstation" runat="server" Text="Weather Station" />
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="radweathecmb" runat="server" Width="100px">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                            <td valign="top" style="width: 150px;">
                                <fieldset>
                                    <legend>Weather</legend>
                                    <asp:CheckBoxList runat="server">
                                        <asp:ListItem Text="Temp f" Value="tempf"></asp:ListItem>
                                        <asp:ListItem Text="Temp c" Value="tempf"></asp:ListItem>
                                        <asp:ListItem Text="Relative Hum." Value="tempf"></asp:ListItem>
                                        <asp:ListItem Text="Wind mph." Value="tempf"></asp:ListItem>
                                        <asp:ListItem Text="Wind gust" Value="tempf"></asp:ListItem>
                                        <asp:ListItem Text="Pressure mb" Value="tempf"></asp:ListItem>
                                        <asp:ListItem Text="Pressure In" Value="tempf"></asp:ListItem>
                                        <asp:ListItem Text="Dew Point f" Value="tempf"></asp:ListItem>
                                        <asp:ListItem Text="Dew Point c" Value="tempf"></asp:ListItem>
                                        <asp:ListItem Text="Heat Index f" Value="tempf"></asp:ListItem>
                                        <asp:ListItem Text="Heat Index c" Value="tempf"></asp:ListItem>
                                        <asp:ListItem Text="Wind Chill f" Value="tempf"></asp:ListItem>
                                        <asp:ListItem Text="Wind Chill c" Value="tempf"></asp:ListItem>
                                    </asp:CheckBoxList>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
