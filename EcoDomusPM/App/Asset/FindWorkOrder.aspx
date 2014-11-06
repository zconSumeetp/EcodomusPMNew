<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="FindworkOrder.aspx.cs" EnableEventValidation="true"
    Inherits="App_Asset_FindWorkOrder" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head>
    <title>Work Order</title>
    <telerik:RadCodeBlock ID="Codeblock1" runat="server">
        <script language="javascript" type="text/javascript">
            function fn_Clear() {
                try {
                    document.getElementById("txt_search").value = "";
                    return false;
                }
                catch (e) {
                    alert(e.message + "  " + e.Number);
                    return false;
                }
            }

            function delete_workorder()
             {
                var answer = confirm("Are you sure you want to delete this work order?")
                if (answer)
                    return true;
                else
                    return false;
            }

            function navigatetoworkoder() {
                //top.location.href = "../asset/workorderprofile.aspx"; earlier            
                top.location.href = "../asset/workorderprofile.aspx?asset_id=" + document.getElementById('hf_asset_id').value;
            }

            function cursor() {
                document.getElementById("txt_search").focus();
            }

        </script>
    </telerik:RadCodeBlock>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
</head>
<body style="background: white; padding: 0px">
    <form id="Form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <table style="margin: 10px 50px 50px 0px;" align="left" width="80%" border="0">
        <%--<caption>
        <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Work_Orders%>">:</asp:Label>
            </caption>--%>
        <tr>
            <%--<td>
                <asp:Label ID="lbl_Asset" runat="server" CssClass="LabelText" Text="<%$Resources:Resource,Asset_Name%>">:</asp:Label>
                <asp:Label ID="lbl_asset_value" runat="server" CssClass="LabelText"></asp:Label>
            </td>--%>
        </tr>
        <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td valign="middle">
                <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Criteria%>" CssClass="Label"></asp:Label>
                &nbsp;&nbsp;
                <telerik:RadComboBox ID="cmb_category" runat="server" Height="100px" Width="170px">
                    <Items>
                        <telerik:RadComboBoxItem Value="Name" Text="Name" Selected="true" Font-Size="11px" />
                        <telerik:RadComboBoxItem Value="Description" Text="Description" Selected="true" Font-Size="11px" />
                    </Items>
                </telerik:RadComboBox>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox runat="server" ID="txt_search" CssClass="SmallTextBox"></asp:TextBox>
                <%--  </td>
                <td>--%>
                <asp:Button ID="btn_search" runat="server" Skin="Hay" Width="50px" Text="<%$Resources:Resource,Search%>"
                    OnClick="btn_Search_Click" />
                <%--</td>
                <td>--%>
                <asp:Button ID="btn_clear" runat="server" Skin="Hay" Width="50px" Text="<%$Resources:Resource,Clear%>" OnClientClick="javascript:return fn_Clear();" />
            </td>
        </tr>
        <tr>
        <td style="height:10px;"></td>
        </tr>
        <tr>
            <td align="center">
                <telerik:RadGrid ID="rg_work_order" runat="server" Width="100%" AutoGenerateColumns="false"
                    Skin="Hay" OnItemCommand="rg_work_order_ItemCommand" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                    PageSize="10" AllowSorting="true" OnSortCommand="rg_work_order_OnSortCommand"
                    OnPageSizeChanged="rg_work_order_OnPageSizeChanged" OnPageIndexChanged="rg_work_order_OnPageIndexChanged">
                    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="true" />
                    <MasterTableView DataKeyNames="pk_work_order_id" ClientDataKeyNames="pk_work_order_id">
                        <Columns>
                            <telerik:GridTemplateColumn DataField="pk_work_order_id" Visible="false">
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="work_order_number" SortExpression="work_order_number"
                                HeaderText="<%$Resources:Resource,Work_Order_No%>">
                                <ItemStyle CssClass="column" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="linkWorkOrderName" PostBackUrl="#" runat="server" alt="Delete"
                                        Text='<%# DataBinder.Eval(Container.DataItem,"work_order_number")%>' CommandName="Edit_" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="Status" HeaderText="<%$Resources:Resource,Status%>">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="workorder_desc" HeaderText="<%$Resources:Resource,Description%>">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="startdate" HeaderText="<%$Resources:Resource,Start_Date%>">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="enddate" HeaderText="<%$Resources:Resource,End_Date%>">
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn DataField="pk_work_order_id" UniqueName="pk_work_order_id">
                                <ItemStyle CssClass="column" Width="5%" />
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="Delete" OnClientClick="javascript:return delete_workorder();" 
                                        ImageUrl="~/App/Images/Delete.gif" />
                                    <asp:LinkButton ID="lnkDelete" Visible="false" runat="server" CausesValidation="false" 
                                        CommandName="Delete" Text='<%# Bind("pk_work_order_id")%>'>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>


                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
        <td style="height:10px;"></td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btn_add" Text="<%$Resources:Resource,Add_Work_Order%>" Width="120px" runat="server" OnClientClick="javascript:return navigatetoworkoder();" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hf_asset_id" runat="server" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
