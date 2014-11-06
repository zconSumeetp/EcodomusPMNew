<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FacilityList.aspx.cs" Inherits="App_FacilityList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <base target="_self" />
    <link rel="stylesheet" type="text/css" href="../App_Themes/EcoDomus/style.css" />
    <title>EcoDomus :- Select facility</title>
</head>
<script language="javascript" type="text/javascript">

    function Clear() {
        document.getElementById("<%=srch_txt_box.ClientID %>").value = "";
        return false;
    }

    function close_Window(msg) {
        alert(msg);
        this.close();
    }

    function OpenDashboard() {
        window.returnValue = "1";
        this.close();
    }

</script>
<body runat="server" id="bdy">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table runat="server" id="main_tbl" cellspacing="0" border="0">
        <tr style="height: 80%;">
            <td align="left" valign="top" style="width: 25%;">
                <img alt="EcoDomus logo" src="Images/EcoDomus_logo.jpg" />
            </td>
            <td align="left" valign="top" style="width: 65%;">
                <asp:Label runat="server" ID="lbl_user_info"></asp:Label>
            </td>
            <td style="width: 5%; vertical-align: top; margin-top: 10px">
                <asp:Label ID="lblTodayDate" Font-Bold="true" runat="server"></asp:Label>
            </td>
            <td style="width: 20px; vertical-align: top">
                <asp:ImageButton ID="divHelp" runat="server" ImageUrl="~/App/Images/Buttons/newhelp.gif"
                    OnClick="divHelp_Click" />
            </td>
            <td style="width: 20px; vertical-align: top">
                <asp:ImageButton ID="lnkbtnLogOut" runat="server" CausesValidation="false" OnClick="lnkbtnLogOut_Click"
                    ImageUrl="~/App/Images/Buttons/LogOut.gif" />
            </td>
        </tr>
        <tr>
            <td>
                <div style="margin: 19px 0px 0px 0px" id="divsitemap">
                    <asp:SiteMapPath ID="SiteMapPath1" runat="server" CssClass="ChangeColor">
                        <PathSeparatorTemplate>
                            <asp:Image ID="imgBrdcrmsLogo" runat="server" ImageUrl="~/App/Images/arrow-brdcrms.gif" />
                        </PathSeparatorTemplate>
                    </asp:SiteMapPath>
                </div>
            </td>
        </tr>
    </table>
    <table id="orgprofile" width="80%" style="vertical-align: top; margin-left: 120px;
        margin-top: 60px; border: 1;" cellpadding="0" cellspacing="0">
        <caption>
        <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Select_Facility%>">:</asp:Label>
            
        </caption>
        <tr>
            <td>
                <asp:TextBox CssClass="SmallTextBox" ID="srch_txt_box" runat="server" TabIndex="1"></asp:TextBox>&nbsp;&nbsp;
                <asp:Button ID="btnSearch" Width="75px" runat="server" Text="<%$Resources:Resource,Search%>" TabIndex="2"
                    OnClick="btnSearch_Click" />
                <asp:Button ID="btnclear" runat="server" Text="<%$Resources:Resource,Clear%>" TabIndex="3" Width="75px" OnClientClick="javascript:return Clear();" />
            </td>
        </tr>
        <tr>
            <td style="height: 10px">
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="rgFacility" runat="server" AllowPaging="True" PagerStyle-AlwaysVisible="true" Skin="Hay" Width="350px"
                    AllowSorting="True" AutoGenerateColumns="False" OnSortCommand="rgFacility_OnSortCommand"
                    OnPageIndexChanged="rgFacility_PageIndexChanged" OnPageSizeChanged="rgFacility_PageSizeChanged"
                    OnItemCommand="rgFacility_ItemCommand">
                    <MasterTableView DataKeyNames="ID,cons_string,Name,client_id,Client_Name">
                        <Columns>
                            <telerik:GridBoundColumn DataField="ID" HeaderText="ID" Display="false" SortExpression="ID"
                                UniqueName="ID">
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn DataTextField="Name" HeaderText="<%$Resources:Resource,Name%>" ButtonType="LinkButton"
                                SortExpression="Name" CommandName="Facility">
                                <HeaderStyle BackColor="Transparent" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="cons_string" HeaderText="ID" Display="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="client_name" HeaderText="<%$Resources:Resource,Client_Name%>" Display="true"
                                SortExpression="client_name" UniqueName="client_name">
                                <HeaderStyle BackColor="Transparent" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
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
