<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JobTemplate.aspx.cs" Inherits="App_Settings_JobTemplate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
    <style type="text/css">
        .gridRadPnlHeader1
        {
            background-color: Gray;
            height: 30px;
            vertical-align: middle;
        }
        .SmallTextBox
        {
            font-family: Verdana;
            font-size: 11px;
            height: 20px;
            margin-top: 10px;
            margin-bottom: 2px;
            border-top: #7F9DB9 1px solid;
            border-bottom: #7F9DB9 1px solid;
            text-align: left;
        }
        .smallsearchbtn
        {
            margin-top: 10px;
            height: 20px;
            width: 78px;
        }
        .style1
        {
            width: 185px;
        }
        
        .normalLabel1
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            font-weight: bold;
        }
        .rgcss
        {
            border-style: solid;
            margin: 0px;
            border-left-color: #DCDCDC;
            border-top-color: #DCDCDC;
            border-top-width: 0px;
            border-bottom-width: 1px;
            border-left-width: 1px;
            border-right-width: 1px;
            border-bottom-color: #A0A0A0;
            border-right-color: #B4B4B4;
        }
        .rgcss1
        {
            margin: 0px;
            border: 0;
            border-left-width: 0;
            border-bottom-width: 0;
        }
        html, body, form
        {
            margin: 0;
            padding: 0;
            overflow: auto;
        }
        .rtWrapperContent
        {
            padding: 10px !important;
            color: Black !important;
        }
        
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
    </style>
    <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link href="../../App_Themes/EcoDomus/NEWUI_Grid.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function closeWindow() {

                window.parent.refreshgrid();

                window.close();

                return false;
            }
            function NumberOnly(sender, eventArgs) {
                var charCode = eventArgs.get_keyCode();
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    eventArgs.set_cancel(true);
            }

            function AssignPMJobs() {
                var s1 = $find("<%=rg_Job_templates.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var ids = "";
                document.getElementById("<%= hf_selected_ids.ClientID %>").value = ""; //

                if (document.getElementById("<%= hf_selected_ids.ClientID %>").value != "") {
                    ids = "," + document.getElementById("<%= hf_selected_ids.ClientID %>").value;
                }
                for (var i = 0; i < selectedRows.length; i++) {
                    ids = ids + "," + s1.get_masterTableView().get_selectedItems()[i].getDataKeyValue("Id");
                }
                if (ids.length > 0) {
                    ids = ids.substring(1, ids.length);
                }
                document.getElementById("<%= hf_selected_ids.ClientID %>").value = ids;
                if (ids == "") {
                    alert("Please select at least one template.");
                    return false;
                }
                else {

                    return true;
                }
            }

            function confirmDelete(grid) {

                return confirm("Are you sure you want to delete?");

            }

            /*--try for persisting values on page index changed--*/
            function AssignPMJobs_test() {
                var s1 = $find("<%=rg_Job_templates.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var rows = MasterTable.get_dataItems();
                var ids = "";
                document.getElementById("<%= hf_selected_ids.ClientID %>").value = ""; //

                var selected_items = [];
                selected_items.push("1");
                selected_items.push("2");
                selected_items.push("3");

                selected_items.splice(1, 1);

                return false;


            }

          
                    
        </script>
    </telerik:RadCodeBlock>
</head>
<body style="background: #EEEEEE; padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager" EnableScriptCombine="false">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div>
        <table width="100%" style="padding: 0px; margin: 0 0 0 0;">
            <tr>
                <td>
                    <table width="100%" style="padding: 0px; margin: 0 0 0 0;">
                        <%--<tr style="display: none;">--%>
                        <tr>
                            <td class="wizardHeadImage">
                                <div class="wizardLeftImage">
                                    <asp:Label ID="lbl_job_template" runat="server" Font-Size="10pt" Text="<%$Resources:Resource,Job_Template%>"></asp:Label>
                                </div>
                                <div class="wizardRightImage">
                                    <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                        OnClientClick="javascript:return closeWindow();" Style="height: 16px" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button runat="server" ID="btn_add_job_template" Text="<%$Resources:Resource,Add_new%>"
                                    OnClick="btn_add_job_template_Click" />
                            </td>
                        </tr>
                    </table>
                    <table id="tbl_jobs2" style="padding-top: 0;" cellpadding="0" cellspacing="0" runat="server"
                        border="0" width="100%">
                        <tr id="tr_AddJob" runat="server" style="display: block;">
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <table width="100%">
                                                <tr style="height: 5px;">
                                                    <td colspan="5">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5" style="width: 98%;">
                                                        <asp:Panel runat="server" ID="pnl_job_category" GroupingText="Job details">
                                                            <table width="100%">
                                                                <tr>
                                                                    <td style="width: 20%;">
                                                                        <asp:Label ID="lblName" CssClass="normalLabel1" runat="server" Text="<%$Resources:Resource,Name%>"></asp:Label>:
                                                                    </td>
                                                                    <td style="width: 30%;">
                                                                        <telerik:RadTextBox ID="txtName" runat="server" Width="100%" CssClass="SmallTextBox"
                                                                            TabIndex="1">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td style="width: 2%;">
                                                                        <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator2" runat="server"
                                                                            ValidationGroup="RequiredField" ControlToValidate="txtName" ErrorMessage="*"
                                                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                    <td style="width: 21%;">
                                                                        <asp:Label ID="lblCategory" CssClass="normalLabel1" runat="server" Text="<%$Resources:Resource,Category%>"></asp:Label>:
                                                                    </td>
                                                                    <td style="width: 25%;">
                                                                        <telerik:RadComboBox ID="cmb_Category" MarkFirstMatch="true" runat="server" Width="100%"
                                                                            EmptyMessage="--Select--" TabIndex="2">
                                                                        </telerik:RadComboBox>
                                                                    </td>
                                                                    <td style="width: 2%;">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr style="height: 5px;">
                                                    <td colspan="5">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5" style="width: 98%;">
                                                        <asp:Panel runat="server" ID="pnl_job_task_details" GroupingText="Task details">
                                                            <table width="100%" >
                                                                <tr>
                                                                    <td class="normalLabel1" style="width: 20%;">
                                                                        <asp:Label ID="lblDuration" runat="server" Text="<%$Resources:Resource,Duration%>"></asp:Label>:
                                                                    </td>
                                                                    <td style="width: 30%;">
                                                                        <telerik:RadTextBox ID="txtDuration" Width="100%" runat="server" CssClass="SmallTextBox"
                                                                            TabIndex="1">
                                                                            <ClientEvents OnKeyPress="NumberOnly" />
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td style="width: 2%;">
                                                                    </td>
                                                                    <td class="normalLabel1" style="width: 21%;">
                                                                        <asp:Label ID="lblDurationUnit" runat="server" Text="<%$Resources:Resource,Duration_Unit%>"></asp:Label>:
                                                                    </td>
                                                                    <td style="width: 25%;">
                                                                        <telerik:RadComboBox ID="cmb_duration_unit" MarkFirstMatch="true" runat="server"
                                                                            Width="100%" EmptyMessage="--Select--" TabIndex="2">
                                                                        </telerik:RadComboBox>
                                                                    </td>
                                                                    <td style="width: 2%;">
                                                                    </td>
                                                                </tr>
                                                                <tr style="height: 5px;">
                                                                    <td colspan="6">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="normalLabel1">
                                                                        <asp:Label ID="lblFrequency" runat="server" Text="<%$Resources:Resource,Frequency%>"></asp:Label>:
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox ID="txtFrequency" Width="100%" runat="server" CssClass="SmallTextBox"
                                                                            TabIndex="1">
                                                                            <ClientEvents OnKeyPress="NumberOnly" />
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                    <td class="normalLabel1">
                                                                        <asp:Label ID="lblFrequencyUnit" runat="server" Text="<%$Resources:Resource,Frequency_Unit%>"></asp:Label>:
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadComboBox ID="cmb_frequency_unit" MarkFirstMatch="true" runat="server"
                                                                            Width="100%" EmptyMessage="--Select--" TabIndex="2">
                                                                        </telerik:RadComboBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr style="height: 5px;">
                                                                    <td colspan="6">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="normalLabel1">
                                                                        <asp:Label ID="lblStart" runat="server" Text="<%$Resources:Resource,Start%>"></asp:Label>:
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadDatePicker runat="server" ID="radDatePicker" Width="100%">
                                                                            <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" runat="server" UseColumnHeadersAsSelectors="False"
                                                                                ViewSelectorText="x">
                                                                            </Calendar>
                                                                            <DateInput ID="DateInput1" DisplayDateFormat="MM-dd-yyyy" runat="server" DateFormat="dd-MM-yyyy"
                                                                                Height="15px">
                                                                            </DateInput>
                                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                        </telerik:RadDatePicker>
                                                                    </td>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator9" runat="server"
                                                                            ValidationGroup="RequiredField" ControlToValidate="radDatePicker" ErrorMessage="*"
                                                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                    <td class="normalLabel1">
                                                                        <asp:Label ID="lblStartUnit" runat="server" Text="<%$Resources:Resource,Start_Unit%>"></asp:Label>:
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadComboBox ID="cmb_start_unit" MarkFirstMatch="true" runat="server" Width="100%"
                                                                            EmptyMessage="--Select--" TabIndex="2">
                                                                        </telerik:RadComboBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr style="height: 5px;">
                                                                    <td colspan="6">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="normalLabel1">
                                                                        <asp:Label ID="LbltaskNumber" runat="server" Text="<%$Resources:Resource,Task_Number%>"></asp:Label>:
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox Width="100%" ID="Txttasknumber" runat="server" CssClass="SmallTextBox"
                                                                            TabIndex="1">
                                                                            <ClientEvents OnKeyPress="NumberOnly" />
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                    <td class="normalLabel1">
                                                                        <asp:Label ID="lblPriors" runat="server" Text="<%$Resources:Resource,Priors%>"></asp:Label>:
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadTextBox Width="100%" ID="txtPriors" runat="server" CssClass="SmallTextBox"
                                                                            TabIndex="1">
                                                                            <ClientEvents OnKeyPress="NumberOnly" />
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr style="height: 5px;">
                                                                    <td colspan="6">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="normalLabel1">
                                                                        <asp:Label ID="lblStatus" runat="server" Text="<%$Resources:Resource,Status%>"></asp:Label>:
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadComboBox ID="cmb_status" MarkFirstMatch="true" runat="server" Width="100%"
                                                                            EmptyMessage="--Select--" TabIndex="2">
                                                                        </telerik:RadComboBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                    <td colspan="3">
                                                                    </td>
                                                                </tr>
                                                                <tr style="height: 5px;">
                                                                    <td colspan="6">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="normalLabel1" style="vertical-align: middle; width: 20%;">
                                                                        <asp:Label ID="lblDesc" runat="server" Text="<%$Resources:Resource,Description%>"></asp:Label>:
                                                                    </td>
                                                                    <td class="normalLabel1" style="vertical-align: middle; width: 78%;" colspan="4">
                                                                        <telerik:RadTextBox ID="txt_Description" runat="server" TextMode="MultiLine" Width="100%"
                                                                            Height="80px">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td style="width: 2%;">
                                                                        <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator1" runat="server"
                                                                            ValidationGroup="RequiredField" ControlToValidate="txt_Description" ErrorMessage="*"
                                                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                                <tr style="height: 10px;">
                                                                    <td colspan="5">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr style="height: 10px;">
                                                    <td colspan="5">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5">
                                                        <asp:Button ID="btnSave" runat="server" TabIndex="3" Text="<%$Resources:Resource,Save%>"
                                                            ValidationGroup="RequiredField" Width="100px" OnClick="btnSave_Click" />
                                                        <asp:Button ID="btnCancel" runat="server" TabIndex="8" Text="<%$Resources:Resource,Cancel%>"
                                                            Width="100px" OnClick="btnCancel_Click" Style="height: 26px" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table id="tbl_task_grid" style="padding-top: 0;" cellpadding="0" cellspacing="0"
                        runat="server" border="0" width="100%">
                        <tr runat="server" id="tr_add_new_task">
                            <td align="left" style="vertical-align: top;">
                                <asp:Button runat="server" ID="btn_add_new_task" OnClick="btn_add_new_task_Click"
                                    Text="<%$Resources:Resource,Add_new%>" />
                                <asp:Label runat="server" ID="lbl_job_template_name" Visible="false" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadGrid runat="server" ID="rg_tasks" BorderWidth="1px" AllowPaging="true"
                                    PageSize="10" AutoGenerateColumns="False" AllowSorting="True" PagerStyle-AlwaysVisible="true"
                                    Visible="true" Skin="Default" Width="99%" OnSortCommand="rg_tasks_SortCommand"
                                    OnPageIndexChanged="rg_tasks_PageIndexChanged" OnPageSizeChanged="rg_tasks_PageSizeChanged"
                                    OnItemCommand="rg_tasks_ItemCommand" AllowMultiRowSelection="true">
                                    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" AlwaysVisible="true" />
                                    <ClientSettings>
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="300px" />
                                        <Selecting AllowRowSelect="false" />
                                    </ClientSettings>
                                    <ItemStyle Height="15px" Wrap="true" />
                                    <MasterTableView DataKeyNames="Id" ClientDataKeyNames="Id">
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="Id" HeaderText="Id" Visible="false">
                                                <HeaderStyle Width="0%" HorizontalAlign="Center" />
                                                <ItemStyle Width="0%" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="StatusId" HeaderText="StatusId" Visible="false">
                                                <HeaderStyle Width="0%" HorizontalAlign="Center" />
                                                <ItemStyle Width="0%" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="StartUnit" HeaderText="StartUnit" Visible="false">
                                                <HeaderStyle Width="0%" HorizontalAlign="Center" />
                                                <ItemStyle Width="0%" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="JobTemplateId" HeaderText="JobTemplateId" Visible="false">
                                                <HeaderStyle Width="0%" HorizontalAlign="Center" />
                                                <ItemStyle Width="0%" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DurationUnit" HeaderText="DurationUnit" Visible="false">
                                                <HeaderStyle Width="0%" HorizontalAlign="Center" />
                                                <ItemStyle Width="0%" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="FrequencyUnit" HeaderText="FrequencyUnit" Visible="false">
                                                <HeaderStyle Width="0%" HorizontalAlign="Center" />
                                                <ItemStyle Width="0%" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="CreatedBy" HeaderText="CreatedBy" Visible="false">
                                                <HeaderStyle Width="0%" HorizontalAlign="Center" />
                                                <ItemStyle Width="0%" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn Resizable="false" DataField="Des" HeaderText="<%$Resources:Resource,Description%>"
                                                UniqueName="Des" SortExpression="Des">
                                                <ItemStyle HorizontalAlign="Left" Wrap="true" />
                                                <HeaderStyle HorizontalAlign="Left" Wrap="true" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn Resizable="false" DataField="TaskNumber" HeaderText="<%$Resources:Resource,Task_Number%>"
                                                UniqueName="TaskNumber" SortExpression="TaskNumber">
                                                <ItemStyle Width="12%" HorizontalAlign="Left" />
                                                <HeaderStyle Width="12%" HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn Resizable="false" DataField="Priors" HeaderText="<%$Resources:Resource,Priors%>"
                                                UniqueName="Priors" SortExpression="Priors">
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                <HeaderStyle Width="10%" HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn Resizable="false" DataField="Duration" HeaderText="<%$Resources:Resource,Duration%>"
                                                UniqueName="Duration" SortExpression="Duration">
                                                <ItemStyle Width="12%" HorizontalAlign="Left" />
                                                <HeaderStyle Width="12%" HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn Resizable="false" DataField="Start" HeaderText="<%$Resources:Resource,Start%>"
                                                UniqueName="Start" SortExpression="Start">
                                                <ItemStyle Width="15%" HorizontalAlign="Left" />
                                                <HeaderStyle Width="15%" HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn Resizable="false" DataField="Frequency" HeaderText="<%$Resources:Resource,Frequency%>"
                                                UniqueName="Frequency" SortExpression="Frequency">
                                                <ItemStyle Width="13%" HorizontalAlign="Left" />
                                                <HeaderStyle Width="13%" HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_edit_task" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                                        CommandName="edit_task" AlternateText="<%$Resources:Resource, Edit%>" />
                                                </ItemTemplate>
                                                <HeaderStyle Width="10%" HorizontalAlign="Center" />
                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_delete_template" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                                        OnClientClick="javascript:return confirmDelete(this);" CommandName="delete_task"
                                                        AlternateText="<%$Resources:Resource, Delete%>" />
                                                </ItemTemplate>
                                                <HeaderStyle Width="10%" HorizontalAlign="Center" />
                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <asp:Button runat="server" ID="btn_cancel_task" Text="<%$Resources:Resource, Cancel%>"
                                    OnClick="btnCancel_Click" />
                            </td>
                        </tr>
                    </table>
                    <table id="tbl_job_template_grid" runat="server">
                        <tr>
                            <td>
                                <telerik:RadGrid runat="server" ID="rg_Job_templates" BorderWidth="1px" AllowPaging="true"
                                    PageSize="10" AutoGenerateColumns="False" AllowSorting="True" PagerStyle-AlwaysVisible="true"
                                    Visible="true" Skin="Default" Width="99%" OnSortCommand="rg_Job_templates_SortCommand"
                                    OnPageIndexChanged="rg_Job_templates_PageIndexChanged" OnPageSizeChanged="rg_Job_templates_PageSizeChanged"
                                    OnItemCommand="rg_Job_templates_ItemCommand" AllowMultiRowSelection="true">
                                    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" AlwaysVisible="true" />
                                    <ClientSettings>
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="310px" />
                                        <Selecting AllowRowSelect="true" CellSelectionMode="MultiCell" />
                                    </ClientSettings>
                                    <MasterTableView DataKeyNames="Id,Name" ClientDataKeyNames="Id,Name">
                                        <Columns>
                                            <telerik:GridClientSelectColumn>
                                                <ItemStyle Width="22px" />
                                                <HeaderStyle Width="22px" />
                                            </telerik:GridClientSelectColumn>
                                            <telerik:GridBoundColumn DataField="Id" HeaderText="Id" Visible="false">
                                                <HeaderStyle Width="0px" HorizontalAlign="Center" />
                                                <ItemStyle Width="0px" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="JobCategoryId" HeaderText="JobCategoryId" Visible="false">
                                                <HeaderStyle Width="0px" HorizontalAlign="Center" />
                                                <ItemStyle Width="0px" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="JobId" HeaderText="JobId" Visible="false">
                                                <HeaderStyle Width="0px" HorizontalAlign="Center" />
                                                <ItemStyle Width="0px" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn Resizable="false" DataField="Name" HeaderText="<%$Resources:Resource,Name%>"
                                                UniqueName="name" SortExpression="Name">
                                                <ItemStyle Width="300px" HorizontalAlign="Left" />
                                                <HeaderStyle Width="300px" HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="OrganizationId" HeaderText="OrganizationId" Visible="false">
                                                <HeaderStyle Width="0px" HorizontalAlign="Center" />
                                                <ItemStyle Width="0px" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" Visible="false" HeaderText="<%$Resources:Resource, Edit%>">
                                                <ItemTemplate>
                                                    <asp:Image runat="server" ID="img_edit_template" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                                        AlternateText="<%$Resources:Resource, Edit%>" />
                                                    <%--  <asp:ImageButton ID="btn_edit_template" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                                        CommandName="edit_template" AlternateText="<%$Resources:Resource, Edit%>" CausesValidation="true"  />--%>
                                                </ItemTemplate>
                                                <HeaderStyle Width="35px" HorizontalAlign="Center" />
                                                <ItemStyle Width="35px" HorizontalAlign="Center" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_edit_template_task" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                                        CommandName="edit_template_task" AlternateText="Add/Edit task" />
                                                </ItemTemplate>
                                                <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                                <ItemStyle Width="50px" HorizontalAlign="Center" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_delete_template" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                                        OnClientClick="javascript:return confirmDelete();" CommandName="delete_template"
                                                        AlternateText="<%$Resources:Resource, Delete%>" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" />
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>
                    <table width="100%" runat="server" id="tbl_assign_unassign">
                        <tr>
                            <td style="width: 10%">
                                <asp:Button runat="server" ID="btn_Assign_template" Text="<%$Resources:Resource,Assign%>"
                                    OnClick="btn_Assign_template_Click" OnClientClick="javascript:return AssignPMJobs();" />
                            </td>
                            <td style="width: 10%">
                                <asp:Button runat="server" ID="btn_unassign_template" Text="<%$Resources:Resource,Unassign%>"
                                    OnClick="btn_unassign_template_Click" OnClientClick="javascript:return AssignPMJobs();" />
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblmsg" ForeColor="Red" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:HiddenField runat="server" ID="hf_task_id" />
        <asp:HiddenField runat="server" ID="hf_job_template_id" />
        <asp:HiddenField runat="server" ID="hf_job_template_name" />
        <asp:HiddenField runat="server" ID="hf_template_category" />
        <asp:HiddenField runat="server" ID="hf_organization_id" />
        <asp:HiddenField runat="server" ID="hf_selected_ids" />
        <asp:HiddenField runat="server" ID="hf_from_task" Value="" />
        <telerik:RadAjaxManager ID="ramJobs" runat="server">
            <AjaxSettings>
                <%-- <telerik:AjaxSetting AjaxControlID="rg_Job_templates">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_Job_templates" LoadingPanelID="loadingPanel1" />
                        
                    </UpdatedControls>
                </telerik:AjaxSetting>--%>
                <%-- <telerik:AjaxSetting AjaxControlID="btn_edit_template">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_Job_templates" LoadingPanelID="loadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>--%>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
            Skin="Default">
        </telerik:RadAjaxLoadingPanel>
        <%--following code is not in used right now coded for edit window for job template--%>
        <telerik:RadWindowManager Visible="true" ID="rad_window_job_template" VisibleStatusbar="false"
            AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server"
            KeepInScreenBounds="true">
            <Windows>
                <telerik:RadWindow Visible="true" ID="rd_template_popup" runat="server" Animation="Slide"
                    Behaviors="Move, Resize" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="false"
                    AutoSize="false" Width="430" Height="152" VisibleStatusbar="false" VisibleOnPageLoad="false"
                    Top="15px" Left="300px" Skin="">
                    <ContentTemplate>
                        <table style="background-image: url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px;
                            margin: 0px 0px 0px 0px; width: 100%;">
                            <tr style="width: 100%; height: 100%;">
                                <td class="wizardHeadImage" colspan="3">
                                    <div class="wizardLeftImage">
                                        <asp:Label ID="lbl_Add_Classification" Text="Edit Template" Font-Names="Verdana"
                                            Font-Size="11pt" runat="server"></asp:Label>
                                    </div>
                                    <div class="wizardRightImage">
                                        <asp:ImageButton ID="btn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                            OnClick="btn_close_Click" CausesValidation="false" />
                                        <%--OnClientClick="javascript:return CloseWindow();" --%>
                                    </div>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
        <telerik:RadCodeBlock ID="loadPopUp" runat="server">
            <script language="javascript" type="text/javascript">
                function template_popup() {
                    manager = $find("<%= rad_window_job_template.ClientID %>");

                    var windows = manager.get_windows();

                    windows[0].show();

                    //windows[0].setUrl(url);

                    return false;
                }

                
             
            </script>
        </telerik:RadCodeBlock>
    </div>
    <style>
        *
        {
            font-family: Arial;
        }
    </style>
    </form>
</body>
</html>
