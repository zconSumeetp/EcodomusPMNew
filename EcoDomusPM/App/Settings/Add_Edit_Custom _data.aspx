<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Add_Edit_Custom _data.aspx.cs" Inherits="App_Settings_Add_Edit_Custom__data" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<head runat="server">
 <script language="javascript" type="text/javascript">
        function getval()
        {
            if (document.getElementById("hf_pk_custom_hierarchy_data").value == "")
             {
                document.getElementById("hf_pk_custom_hierarchy_data").value='00000000-0000-0000-0000-000000000000';
            }
            else
                return true;
        }

        function close_() 
        {
            window.close();
        }

        function delete_()
         {
            var flag;
            flag = confirm("Are you sure you want to delete?");
            return flag;
        }

        function validate_() 
        {
            var a = document.getElementById("txt_name").value;
            var b = document.getElementById("txt_longitude").value;
            var c = document.getElementById("txt_latitude").value;
            if (a == "" || b == "" || c == "")
                return false;
            else
                return true;
        }
    </script>
        <style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
</head>

<body style="margin: 0px 0px 0px 0px; padding-top: 0; background: white;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrpt_manager" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="RadFormDecorator" runat="server" Skin="Hay" DecoratedControls="Buttons" />
    <table border="0" width="100%" style="margin: 5px 0px 0px 70px">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <caption><asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, Add_Custom_Data%>"></asp:Label></caption>
        <tr>
            <td>
                <asp:Label ID="lbl_name" Text="<%$Resources:Resource, Name%>" CssClass="LabelText" runat="server"></asp:Label>&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_name" runat="server" CssClass="textbox" Height="20"></asp:TextBox>
                <asp:Label ID="lbl_validate" runat="server" Text="*" ForeColor="Red" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbl_longitude" Text="<%$Resources:Resource, Longitude%>" runat="server" CssClass="LabelText"></asp:Label>:
                &nbsp;            
                <asp:TextBox ID="txt_longitude" runat="server" CssClass="textbox" Height="20"></asp:TextBox>
                <asp:Label ID="lbl_validate_long" runat="server" Text="*" ForeColor="Red" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbl_latitude" Text="<%$Resources:Resource, Latitude%>" runat="server" CssClass="LabelText"></asp:Label> :
                &nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_latitude" runat="server" CssClass="textbox" Height="20"></asp:TextBox>
                <asp:Label ID="lbl_validate_lat" runat="server" Text="*" ForeColor="Red" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btn_add" runat="server" Text="<%$Resources:Resource, Add%>" Width="50" OnClick="btn_save_Click"
                    OnClientClick="javascript:return getval()" />
                <asp:Button ID="btn_close" runat="server" Text="<%$Resources:Resource, Close%>" Width="50" OnClientClick="close_()" />
                <asp:Label ID="lbl_region" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" CssClass="LabelText" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <td>
                <table style="margin: 10px 50px 5px 2px; width: 80%">
                    <tr>
                        <td>
                            <telerik:RadGrid ID="rg_custom_data" runat="server" AutoGenerateColumns="false" PagerStyle-AlwaysVisible="true"
                                Width="100%" OnItemCommand="rg_custom_data_OnItemCommand" Skin="Hay" AllowPaging="true"
                                OnPageIndexChanged="rg_custom_data_PageIndexChanged" OnPageSizeChanged="rg_custom_data_PageSizeChanged"
                                PageSize="10" AllowSorting="true" OnSortCommand="rg_custom_data_onsort">
                                <MasterTableView DataKeyNames="pk_custom_hierarchy_data_id" ClientDataKeyNames="pk_custom_hierarchy_data_id">
                                    <Columns>
                                        <telerik:GridTemplateColumn Visible="false" DataField="pk_custom_hierarchy_data_id"
                                            HeaderText="Name" UniqueName="pk_custom_hierarchy_data_id">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkpk_custom_hierarchy_data_id" runat="server" Text='<%# Bind("pk_custom_hierarchy_data_id") %>'
                                                    CommandName="SelectTemplate">
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle Width="15%" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="custom_hierarchy_data_name" HeaderText="<%$Resources:Resource, Custom_Data%>">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="longitude" HeaderText="<%$Resources:Resource, Longitude%>">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="latitude" HeaderText="<%$Resources:Resource, Latitude%>">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="pk_custom_hierarchy_data_id">
                                            <ItemStyle CssClass="column" Width="10%" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnk_edit" runat="server" CausesValidation="false" Text="Edit"
                                                    CommandName="Edit_"></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn Visible="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="pk_custom_hierarchy_data_id">
                                            <ItemStyle CssClass="column" Width="5%" />
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete_" CommandName="Delete_"
                                                    ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return delete_()" />
                                                <asp:LinkButton ID="lnkDelete" Visible="false" runat="server" CausesValidation="false"
                                                    CommandName="Delete_" Text='<%# Bind("pk_custom_hierarchy_data_id")%>'>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hf_pk_custom_hierarchy_data" runat="server" />
    <asp:HiddenField ID="hf_pk_hierarchy_table_id" runat="server" />
    </form>
</body>