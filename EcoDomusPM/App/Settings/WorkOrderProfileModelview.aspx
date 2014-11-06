<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkOrderProfileModelview.aspx.cs"
    Inherits="App_Settings_WorkOrderProfileModelview" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="../UserControls/UCComboAssignedTo.ascx" TagName="UCComboAssigned"
    TagPrefix="uc2" %>
<%@ Register Src="~/App/UserControls/UCLocation.ascx" TagName="UCLocation" TagPrefix="uc3" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />

    <telerik:RadCodeBlock runat="server">
    <script language="javascript" type="text/javascript">
        function closewindow() {
            try {
           
            window.close();
            window.opener.document.getElementById("btn_properties").click()
                return false;
            }

            catch (err) {
                alert(err);
            }
        }
        function open_asset_popup() {
            var url = "../Asset/issuefacilitylist.aspx?facilitystatus=" + document.getElementById("<%=hdnfacility.ClientID%>").value + "";
            manager = $find("<%= rw_manager.ClientID %>");
            if (manager != null) {
                var windows = manager.get_windows();
                windows[0].show();
                windows[0].set_modal(false);
                windows[0].setUrl(url);
            }
            return false;
        }

        function cursor() {
            document.getElementById("txt_work_order_number").focus();
        }



        function load_comp(name, id, type_name) {
            document.getElementById("<%=hf_asset_id.ClientID %>").value = id;
            var reg = new RegExp('&nbsp;', 'g');
            name = name.replace(reg, ' ');
            type_name = type_name.replace(reg, ' ');
            var reg1 = new RegExp('single', 'g')
            name = name.replace(reg1, "'");
            type_name = type_name.replace(reg1, "'");
            document.getElementById("<%=lbl_asset_name.ClientID %>").innerText = name;
            document.getElementById("<%=hdnasset_name.ClientID %>").value = name;
        }

        function delete_() {
            var flag;
            flag = confirm("Are you sure you want to delete?");
            return flag;
        }


        function open_facility(id) {
            document.getElementById('ContentPlaceHolder1_hf_facility_id').value = id;
            document.getElementById('ContentPlaceHolder1_btn_navigate').click();
        }

        function validate() {
            alert("Please select facility!!!!!!!!!!!!!!!!!!");
        }
       


    </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
        .style1
        {
            width: 299px;
        }
    </style>
</head>
<body style="background: white; padding: 0px; margin: 15px 50px 50px 50px;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div>
        <table style="margin-left: 60px; margin-top: 15px;" align="left" border="0" width="60%">
            <telerik:RadFormDecorator ID="RadFormDecorator" runat="server" Skin="Hay" DecoratedControls="Buttons" />
            <caption >
                <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Work_Order_Profile%>">:</asp:Label>
            </caption>
            <tr>
                <td style="height: 20px">
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="work_order_number" Text="<%$Resources:Resource,Work_Order_Number%>"
                        runat="server" CssClass="Label"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txt_work_order_number" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rf_name" runat="server" ControlToValidate="txt_work_order_number"
                        SetFocusOnError="True" Display="Dynamic" ValidationGroup="validation_group" ErrorMessage="*"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:Label ID="lbl_work_order_number" runat="server" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="work_order_desc" runat="server" Text="<%$Resources:Resource,Description%>"
                        CssClass="Label"></asp:Label>
                </td>
                <td class="style1">
                    <asp:TextBox ID="txt_work_order_desc" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lbl_work_order_desc" runat="server" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <asp:Label ID="lbl_asset" runat="server" Text="<%$Resources:Resource,Asset%>" CssClass="Label">:</asp:Label>
                </td>
                <td class="style1">
                    <asp:Label ID="lbl_asset_name" runat="server"> </asp:Label>
                    <asp:Label ID="lbl_req_asset" runat="server" Visible="false" Text="*" ForeColor="Red"></asp:Label>
                    <asp:LinkButton ID="lnk_asset" runat="server" Text="<%$Resources:Resource,Add%>"
                        OnClientClick="javascript:return open_asset_popup();"></asp:LinkButton>
                    <telerik:RadGrid ID="rg_asset" runat="server" Skin="Hay" Visible="False" OnItemCommand="rg_asset_ItemCommand"
                        AutoGenerateColumns="False">
                        <MasterTableView DataKeyNames="pk_asset_id" ClientDataKeyNames="pk_asset_id">
                            <Columns>
                                <%--<telerik:GridBoundcolumn DataField="asset_name" HeaderText="Name">
<ItemStyle Width="22%" />
</telerik:GridBoundcolumn>--%>
                                <%--<telerik:GridTemplateColumn DataField="asset_name" HeaderText="<%$Resources:Resource,Name%>">
                                    <ItemStyle CssClass="column" Width="22%" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnk_asset_button" runat="server" PostBackUrl="#" alt="delete"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"asset_name")%>' CommandName="Edit_"></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>--%>
                                <telerik:GridBoundColumn DataField="asset_name" HeaderText="<%$Resources:Resource,Description%>">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td style="vertical-align: top">
                    <asp:Label ID="lbl_assign_to" Text="<%$Resources:Resource,Assign_To%>" runat="server"
                        CssClass="Label">:</asp:Label>
                </td>
                <td class="style1">
                    <uc2:UCComboAssigned ID="UCComboAssigned" runat="server" />
                    <telerik:RadGrid ID="rg_assign_to" runat="server" Skin="Hay" Visible="False" AutoGenerateColumns="False"
                        AllowPaging="true" AllowSorting="true" PageSize="5">
                        <MasterTableView DataKeyNames="pk_user_id" ClientDataKeyNames="pk_user_id">
                            <Columns>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource,Name%>" DataField="name">
                                    <ItemStyle Width="22%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource,Organization%>" DataField="Organization">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td style="vertical-align: top">
                    <asp:Label ID="lbl_location" Text="<%$Resources:Resource,Location%>" runat="server"
                        CssClass="Label"></asp:Label>
                </td>
                <td class="style1">
                    <uc3:UCLocation ID="UCLocation" runat="server" />
                    <telerik:RadGrid ID="rg_location" runat="server" Skin="Hay" Visible="False" AutoGenerateColumns="False"
                        OnItemCommand="rg_location_ItemCommand">
                        <MasterTableView DataKeyNames="pk_location_id,facility" ClientDataKeyNames="pk_location_id,facility">
                            <Columns>
                                <telerik:GridTemplateColumn Visible="false" DataField="pk_location_id">
                                </telerik:GridTemplateColumn>
                                <%--<telerik:GridBoundColumn HeaderText="Name" DataField="name" >
</telerik:GridBoundColumn>--%>
                              <%--  <telerik:GridTemplateColumn DataField="name" HeaderText="<%$Resources:Resource,Name%>">
                                    <ItemStyle CssClass="column" Width="22%" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnk_space_button" runat="server" PostBackUrl="#" alt="delete"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"name")%>' CommandName="Edit_Space"></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>--%>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource,Name%>" DataField="name">
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource,Description%>" DataField="description">
                                </telerik:GridBoundColumn>
                                <%--<telerik:GridTemplateColumn DataField="Facility" HeaderText="Facility">
<ItemStyle CssClass="column" Width="22%"/>
<ItemTemplate>
<asp:LinkButton ID="lnk_facility_button" runat="server" PostBackUrl="#" alt="delete" Text='<%# DataBinder.Eval(Container.DataItem,"Facility")%>' CommandName="Edit_Facility"></asp:LinkButton>
</ItemTemplate>
</telerik:GridTemplateColumn>--%>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource,Facility%>" DataField="facility_name">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbl_start_date" runat="server" Text="<%$Resources:Resource,Start_Date%>"
                        CssClass="Label">:</asp:Label>
                </td>
                <td class="style1">
                    <asp:Label ID="lbl_start_date_selected" runat="server" Visible="false"></asp:Label>
                    <telerik:RadDatePicker TabIndex="7" AutoPostBack="false" ID="rdpstartdate" runat="server"
                        Width="50%" MaxDate="2099-01-01" MinDate="1900-01-01">
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                        </Calendar>
                        <DateInput TabIndex="7" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy">
                        </DateInput>
                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="7"></DatePopupButton>
                    </telerik:RadDatePicker>
                    <%--<asp:RequiredFieldValidator ID="rf_start_date" runat="server"  ControlToValidate="rdpstartdate" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbl_end_date" runat="server" Text="<%$Resources:Resource,End_Date%>"
                        Class="Label">:</asp:Label>
                </td>
                <td class="style1">
                    <asp:Label ID="lbl_end_date_selected" runat="server" Visible="false"></asp:Label>
                    <telerik:RadDatePicker TabIndex="7" AutoPostBack="false" ID="rdpenddate" runat="server"
                        Width="50%" MaxDate="2099-01-01" MinDate="1900-01-01">
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                        </Calendar>
                        <DateInput TabIndex="7" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy">
                        </DateInput>
                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="7"></DatePopupButton>
                    </telerik:RadDatePicker>
                </td>
                <%--<asp:RequiredFieldValidator ID="rf_end_date" runat="server" ControlToValidate="rdpenddate" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                <tr>
                    <td>
                    </td>
                    <td class="style1">
                        <asp:CompareValidator ID="dateCompareValidator" runat="server" ControlToValidate="rdpenddate"
                            ValidationGroup="validation_group" ControlToCompare="rdpstartdate" Operator="GreaterThanEqual"
                            Type="Date" ErrorMessage="The start date must be smaller than end date" ForeColor="Red">
                        </asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_status" runat="server" Text="<%$Resources:Resource,Status%>" CssClass="Label">:</asp:Label>
                    </td>
                    <td class="style1">
                        <telerik:RadComboBox ID="cmb_status" runat="server" Height="100px" Width="185px">
                        </telerik:RadComboBox>
                        <asp:Label ID="lbl_status_selected" runat="server" Visible="false"></asp:Label>
                        <asp:RequiredFieldValidator ID="rf_status" ControlToValidate="cmb_status" runat="server"
                            InitialValue="---Select---" ForeColor="Red" ErrorMessage="*" SetFocusOnError="true"
                            ValidationGroup="validation_group"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td class="style1">
                        <asp:Button ID="btn_save" Text="<%$Resources:Resource,Save%>" runat="server" ValidationGroup="validation_group"
                            Width="50px" OnClick="btnSave_Click" />
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btn_cancel" Text="<%$Resources:Resource,Cancel%>" runat="server" OnClientClick="javascript:return closewindow();"
                            Width="50px" />
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btn_delete" Text="<%$Resources:Resource,Delete%>" runat="server"
                            Visible="false" OnClick="btnDelete_Click" OnClientClick="javascript:return delete_(); " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_msg" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField ID="hf_pk_work_order_id" runat="server" />
                    </td>
                    <td class="style1">
                        <asp:HiddenField ID="hf_asset_id" runat="server" />
                    </td>
                    <td>
                        <asp:HiddenField ID="hdnfacility" runat="server" />
                    </td>
                    <td>
                        <asp:HiddenField ID="hdnasset_name" runat="server" />
                    </td>
                </tr>
                <telerik:RadWindowManager ID="rw_manager" runat="server" VisibleStatusbar="false"
                    AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" KeepInScreenBounds="true">
                    <Windows>
                        <telerik:RadWindow Visible="true" ID="radwindow_asset" runat="server" Animation="Slide"
                            KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false"
                            Width="900" Height="500" VisibleStatusbar="false" Behaviors="Move,Resize" VisibleOnPageLoad="false"
                            Skin="Forest" Title="EcoDomus FM:Asset">
                        </telerik:RadWindow>
                    </Windows>
                </telerik:RadWindowManager>
        </table>
        <div style="display: none">
            <asp:Button ID="btn_navigate" runat="server" OnClick="navigate" />
        </div>
        <asp:HiddenField ID="hf_facility_id" runat="server" />
    </div>
    </form>
</body>
</html>
