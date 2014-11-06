<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddTypeJobsSubtask.aspx.cs"
    Inherits="App_Asset_AddTypeJobsSubtask" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <title></title>
    <script type="text/javascript">

        function GetRadWindow() {

            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CloseWindow() {
            GetRadWindow().close();

            return false;
        }
        function CloseWindow_after_save(type_id, ScreenResolution) {
            GetRadWindow().close();
            url = "TypeJobs.aspx?Type_id=" + type_id + "&name=type" + "&resolution=" + ScreenResolution + "";
            //   top.parent.url = url;
            window.parent.location.href = url;
            //top.location.href = url;
            //top.location.reload();
            return false;
        }
        function close() {
            GetRadWindow().close();
            return false;
        }

        function adjust_Add_project_Popup(sender, args) {
            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                wnd.moveTo(x, 25);
                wnd.set_height(document.body.scrollHeight + 25)
            }
            return true;
        }

        function NumberOnly(sender, eventArgs) {
            var charCode = eventArgs.get_keyCode();
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                eventArgs.set_cancel(true);
        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }
        function refreshgrid_new() {
            // document.getElementById("btnAssign").click();

        }
        function openpopupSelectResources() {

            manager = $find("<%# rd_manager.ClientID%>");
            var type_id = document.getElementById("<%# hftype_id.ClientID %>").value;
            var resolution = document.getElementById("<%# hfScreenResolution.ClientID %>").value;
            url = "ResourePopup.aspx?pk_type_id=" + type_id + "";

            if (manager != null) {
                var window = manager.get_windows();
                if (window[0] != null) {

                    window[0].setUrl(url);
                    var bounds = window[0].getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    window[0].moveTo(x + 10, 50);
                    window[0].show();
                    window[0].set_modal(false);
                    document.body.style.overflow = 'hidden';
                }
            }

            return false;
        }
        function adjust_height() {
            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                wnd.moveTo(x, 25);

                wnd.set_height(document.body.scrollHeight + 20)

            }
        }
    </script>
    <style type="text/css">
        div
        {
            overflow-x: hidden;
        }
        
        .SmallTextBox1
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
        .SmallTextBoxDescription
        {
            font-family: Verdana;
            font-size: 11px;
            margin-top: 10px;
            margin-bottom: 2px;
            border-top: #7F9DB9 1px solid;
            border-bottom: #7F9DB9 1px solid;
            text-align: left;
        }
        .smallsearchbtn1
        {
            margin-top: 10px;
            height: 11px;
            width: 78px;
        }
        
        .normalLabel1
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            font-weight: bold;
        }
        .style2
        {
            width: 85px;
        }
        .style3
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            font-weight: bold;
            width: 85px;
        }
    </style>
</head>
<body style="background-color: #EEEEEE; margin: 0; overflow: hidden">
    <form id="form1" runat="server" style="background-color: transparent; margin: 0;">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <table style="background-color: #EEEEEE; width: 100%; border-collapse: collapse;
        padding: 0;" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="wizardHeadImage">
                            <div class="wizardLeftImage">
                                <asp:Label ID="lbl_header" Text="Add Task" runat="server" Font-Names="Verdana" Font-Size="11pt"></asp:Label>
                            </div>
                            <div class="wizardRightImage">
                                <asp:ImageButton ID="ibtn_close" runat="server" OnClientClick="javascript:return CloseWindow();"
                                    ImageUrl="~/App/Images/Icons/icon-close.png" />
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <%--  <table border="0" width="100%" cellpadding="0" cellspacing="0">
                    <tr id="tr_Addtask">
                        <td>--%>
                <table width="100%">
                    <tr>
                        <td>
                            <table border="0" width="100%" style="margin-top: 7px;">
                                <tr>
                                    <td style="padding-left: 25px;">
                                        <asp:Label ID="lblDescription" runat="server" Text="Description" CssClass="normalLabel1"></asp:Label>:
                                    </td>
                                    <td style="padding-left: 20px;">
                                        <telerik:RadTextBox Width="490" ID="radTextDescription" runat="server" CssClass="SmallTextBox1"
                                            TextMode="MultiLine" Columns="25" TabIndex="1">
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator2" runat="server"
                                            ValidationGroup="RequiredField" ControlToValidate="radTextDescription" ErrorMessage="*"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                            <table border="0" width="100%">
                                <tr>
                                    <td style="height: 3px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 25px;">
                                        <asp:Label ID="lblStart" runat="server" Text="Start Date" CssClass="normalLabel1"></asp:Label>:
                                    </td>
                                    <td height="13">
                                        <telerik:RadDatePicker runat="server" ID="radDatetimePicker" Width="190">
                                            <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" runat="server" UseColumnHeadersAsSelectors="False"
                                                ViewSelectorText="x">
                                            </Calendar>
                                            <DateInput ID="DateInput1" DisplayDateFormat="MM-dd-yyyy" runat="server" DateFormat="dd-MM-yyyy"
                                                Height="15px">
                                            </DateInput>
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" SetFocusOnError="true"
                                            ValidationGroup="RequiredField" ControlToValidate="radDatetimePicker" ErrorMessage="*"
                                            ForeColor="Red">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblStartUnit" runat="server" Text="Start Unit" CssClass="normalLabel1"></asp:Label>:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cmb_StartUnit" MarkFirstMatch="true" runat="server" Width="185px"
                                            EmptyMessage="--Select--" TabIndex="2">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 25px;">
                                        <asp:Label ID="lblDuration" runat="server" Text="Duration" CssClass="normalLabel1"></asp:Label>:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtDuration" Width="180" runat="server" CssClass="SmallTextBox1"
                                            TabIndex="1">
                                            <ClientEvents OnKeyPress="NumberOnly" />
                                        </telerik:RadTextBox>
                                        <asp:RegularExpressionValidator ID="RegExpressionDuration" runat="server" ErrorMessage="*"
                                            ControlToValidate="txtDuration" ForeColor="Red" ValidationGroup="RequiredField"
                                            SetFocusOnError="True" ValidationExpression="^(0|[1-9][0-9]*)$">
                                        </asp:RegularExpressionValidator>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblDurationUnit" runat="server" Text="Duration Unit" CssClass="normalLabel1"></asp:Label>:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cmb_durationUnit" MarkFirstMatch="true" runat="server" Width="185px"
                                            EmptyMessage="--Select--" TabIndex="2">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 25px;">
                                        <asp:Label ID="lblFrequency" runat="server" Text="Frequency" CssClass="normalLabel1"></asp:Label>:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="txtFrequency" Width="180" runat="server" CssClass="SmallTextBox1"
                                            TabIndex="1">
                                            <ClientEvents OnKeyPress="NumberOnly" />
                                        </telerik:RadTextBox>
                                        <asp:RegularExpressionValidator ID="RegExpFrequency" runat="server" ErrorMessage="*"
                                            ControlToValidate="txtFrequency" ForeColor="Red" ValidationGroup="RequiredField"
                                            SetFocusOnError="True" ValidationExpression="^(0|[1-9][0-9]*)$">
                                        </asp:RegularExpressionValidator>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblFrequencyUnit" runat="server" Text="Frequency Unit" CssClass="normalLabel1"></asp:Label>:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cmb_frequencyUnit" MarkFirstMatch="true" runat="server"
                                            Width="185px" EmptyMessage="--Select--" TabIndex="2">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 25px;">
                                        <asp:Label ID="lblPriors" runat="server" Text="Priors" CssClass="normalLabel1"></asp:Label>:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox Width="180" ID="txtPriors" runat="server" CssClass="SmallTextBox1"
                                            TabIndex="1">
                                            <ClientEvents OnKeyPress="NumberOnly" />
                                        </telerik:RadTextBox>
                                        <asp:RegularExpressionValidator ID="RegExpressionPriors" runat="server" ErrorMessage="*"
                                            ControlToValidate="txtPriors" ForeColor="Red" ValidationGroup="RequiredField"
                                            SetFocusOnError="True" ValidationExpression="^(0|[1-9][0-9]*)$">
                                        </asp:RegularExpressionValidator>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblStatus" runat="server" Text="Status" CssClass="normalLabel1"></asp:Label>:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cmb_status" MarkFirstMatch="true" runat="server" Width="185px"
                                            EmptyMessage="--Select--" TabIndex="2">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 25px;">
                                        <asp:Label ID="LbltaskNumber" runat="server" Text="Task Number" CssClass="normalLabel1"></asp:Label>:
                                    </td>
                                    <td>
                                        <telerik:RadTextBox Width="180" ID="Txttasknumber" runat="server" CssClass="SmallTextBox1"
                                            TabIndex="1">
                                            <ClientEvents OnKeyPress="NumberOnly" />
                                        </telerik:RadTextBox>
                                        <asp:RegularExpressionValidator ID="RegExpressionTaskNumber" runat="server" ErrorMessage="*"
                                            ControlToValidate="Txttasknumber" ForeColor="Red" ValidationGroup="RequiredField"
                                            SetFocusOnError="True" ValidationExpression="^(0|[1-9][0-9]*)$">
                                        </asp:RegularExpressionValidator>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblResource" runat="server" Text="Resource" CssClass="normalLabel1"></asp:Label>:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox Width="185px" ID="cmb_resource" EmptyMessage="--Select--" runat="server"
                                            CheckBoxes="true" ViewStateMode="Enabled">
                                        </telerik:RadComboBox>
                                    </td>
                                    <%--  <td  align="left" colspan="1" >
                                                    <asp:Label ID="LblResourceText"   runat="server"  ></asp:Label>
                                               
                                                                                            
                                                    <asp:LinkButton ID="lnkSelectReferences" ForeColor="Black"  CssClass="linkText" runat="server" OnClientClick="javascript:return openpopupSelectResources()"
                                                        TabIndex="11">
                                                        <asp:Label ID="Label27" runat="server" Text="<%$Resources:Resource,Select_Add%>"></asp:Label></asp:LinkButton>
                                                </td>--%>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="padding-left: 25px;">
                                        <asp:Button ID="btnSave" runat="server" TabIndex="3" Text="<%$Resources:Resource,Save%>"
                                            ValidationGroup="RequiredField" Width="100px" OnClick="btnSave_Click" />
                                        <asp:Button ID="btnClose" runat="server" OnClientClick="javascript:return CloseWindow();"
                                            TabIndex="8" Text="<%$Resources:Resource,Close%>" Width="100px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 20;">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top" id="tdbasinfo" runat="server">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Black" BorderWidth="2"
        Skin="">
        <Windows>
            <telerik:RadWindow ID="rd_add_jobTasks" runat="server" ReloadOnShow="false" Height="340"
                Width="700" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" Behaviors="Resize,Move" BorderColor="Black"
                EnableAjaxSkinRendering="false" EnableShadow="true" BackColor="Black" VisibleTitlebar="false"
                BorderWidth="2" Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:HiddenField ID="hftype_id" runat="server" />
    <asp:HiddenField ID="hfjob_id" runat="server" />
    <asp:HiddenField ID="hf_category_id" runat="server" />
    <asp:HiddenField ID="hf_resource_ids" runat="server" />
    <asp:HiddenField ID="hf_resource_selected_names" runat="server" />
    <asp:HiddenField ID="hfScreenResolution" runat="server" ClientIDMode="Static" Value="0" />
    </form>
</body>
</html>
