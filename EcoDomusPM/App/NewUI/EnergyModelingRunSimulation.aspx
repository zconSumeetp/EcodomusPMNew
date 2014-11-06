<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusPM_Master.master" AutoEventWireup="true"
    CodeFile="EnergyModelingRunSimulation.aspx.cs" Inherits="App_NewUI_EnergyModelingRunSimulation" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
    </telerik:RadStyleSheetManager>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <script type="text/javascript">
        function onClientProgressBarUpdating(progressArea, args) {
            progressArea.updateHorizontalProgressBar(args.get_progressBarElement(), args.get_progressValue());
            args.set_cancel(true);
        }
        
    </script>
    <style type="text/css">
        .RadUploadProgressArea .ruProgress
        {
            margin-top: -40px;
            margin-left: -10px;
            margin-right: -10px;
            background-image: none !important;
            background-color: transparent;
            border-style: none;
        }
    </style>
    <table border="0" cellpadding="0" cellspacing="0" width="98%" style="border-collapse: collapse;
        border-top-color: transparent; border-top-width: 0px; border-left-color: transparent;
        border-left-width: 0px">
        <tr>
            <td style="border-bottom-color: transparent; border-bottom-width: 0px">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color: #F7F7F7;
                    border-collapse: collapse; border-width: 0px">
                    <tr>
                        <td style="width: 10%; background-color: #FFFFFF">
                            <asp:Image ID="img_weather_tab" runat="server" ImageUrl="~/App/Images/Icons/simulation_tab.png" />
                        </td>
                        <td style="width: 80%">
                        </td>
                        <td style="width: 10%" align="right">
                            <table border="0">
                                <tr>
                                    <td align="right">
                                        <asp:ImageButton ID="img_edit" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                            Width="15" Height="15" ImageAlign="Bottom" />
                                        <asp:LinkButton ID="lbtn_edit" runat="server" Text="EDIT" ForeColor="Black" CssClass="lnkButton"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="border-top-color: transparent; border-top-width: 0px;">
                <table border="2" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;
                    border-top-color: transparent; border-top-width: 0px;">
                    <tr>
                        <td style="padding-top: 15px; padding-left: 15px; height: 57px; border-color: transparent;
                            border-width: 0px">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="background-image: url('/App/Images/asset_container_2.png'); height: 40px;
                                        width: 200px; background-repeat: no-repeat;" align="center">
                                        <asp:Label ID="lbl_project_name" runat="server" Text="Project Name" Font-Size="10"
                                            ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                    </td>
                                    <td style="width: 5px">
                                    </td>
                                    <td style="background-image: url('/App/Images/asset_container_3.png'); height: 40px;
                                        width: 200px; background-repeat: no-repeat" align="center">
                                        <asp:Label ID="lbl_list" runat="server" Text="Simulation Control" Font-Size="10"
                                            ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px; padding-top: 5px; padding-right: 15px; padding-bottom: 0px;
                            border-color: transparent; border-width: 0px">
                            <asp:Label ID="lbl_err_msg" runat="server" Text="" CssClass="normalLabel" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px; padding-top: 15px; padding-right: 15px; padding-bottom: 0px;
                            border-color: transparent; border-width: 0px">
                            <asp:UpdatePanel ID="up_simulation_parameter" runat="server">
                                <ContentTemplate>
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td style="width: 50%" valign="top">
                                                <table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-color: #6F6F6F;
                                                    border-collapse: collapse; background-color: #F2F2F2; border-top-color: Black;">
                                                    <tr>
                                                        <td style="background-color: #BFBFBF; height: 25px; padding-left: 10px; border-bottom-color: transparent;
                                                            border-bottom-width: 0px">
                                                            <asp:Label ID="Label1" Text="Simulation Parameter" runat="server" CssClass="normalLabel"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-top: 0px; background-color: #F2F2F2; border-top-color: transparent;
                                                            border-top-width: 0px" valign="top">
                                                            <table border="1" cellpadding="0" cellspacing="0" width="100%" style="vertical-align: top;
                                                                empty-cells: show; border-collapse: collapse">
                                                                <tr>
                                                                    <td style="height: 20px; width: 50%">
                                                                        <asp:Label ID="lbl_field" runat="server" Text="Field" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 20%; padding-left: 5px">
                                                                        <asp:Label ID="lbl_unit" runat="server" Text="Unit" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 30%; padding-left: 5px">
                                                                        <asp:Label ID="lbl_obj1" runat="server" Text="Obj1" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 15px">
                                                                        <asp:Label ID="lbl_dzsc" runat="server" Text="Do Zone Sizing Calculation" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label2" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_dzsc" runat="server" AutoPostBack="true" Width="90" Height="20"
                                                                            OnSelectedIndexChanged="ddl_dzsc_SelectedIndexChanged">
                                                                            <asp:ListItem Value="0" Text="-Select-" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_dzsc" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 15px">
                                                                        <asp:Label ID="lbl_dssc" runat="server" Text="Do System Sizing Calculation" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label3" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_dssc" runat="server" AutoPostBack="true" Height="20" Width="90"
                                                                            OnSelectedIndexChanged="ddl_dssc_SelectedIndexChanged">
                                                                            <asp:ListItem Value="0" Text="-Select-" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_dssc" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 15px">
                                                                        <asp:Label ID="lbl_dpsc" runat="server" Text="Do Plant Sizing Calculation" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label4" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_dpsc" runat="server" AutoPostBack="true" Height="20" Width="90"
                                                                            OnSelectedIndexChanged="ddl_dpsc_SelectedIndexChanged">
                                                                            <asp:ListItem Value="0" Text="-Select-" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_dpsc" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 15px">
                                                                        <asp:Label ID="lbl_rsfsp" runat="server" Text="Run Simulation for Sizing Periods"
                                                                            CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label5" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_rsfsp" runat="server" AutoPostBack="true" Height="20" Width="90"
                                                                            OnSelectedIndexChanged="ddl_rsfsp_SelectedIndexChanged">
                                                                            <asp:ListItem Value="0" Text="-Select-" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_rsfsp" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 15px">
                                                                        <asp:Label ID="lbl__rsfwfrp" runat="server" Text="Run Simulation for Weather File Run Periods"
                                                                            CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label6" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_rsfwfrp" runat="server" AutoPostBack="true" Height="20"
                                                                            Width="90" OnSelectedIndexChanged="ddl_rsfwfrp_SelectedIndexChanged">
                                                                            <asp:ListItem Value="0" Text="-Select-" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_rsfwfrp" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3">
                                                                        <div style="height: 1px; background-color: Orange">
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 2%">
                                            </td>
                                            <td style="width: 48%; padding-right: 20px; height: 100%" valign="top">
                                                <table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-color: #6F6F6F;
                                                    background-color: #F2F2F2; border-top-color: Black;">
                                                    <tr>
                                                        <td style="background-color: #BFBFBF; height: 25px; padding-left: 10px; border-bottom-color: transparent;
                                                            border-bottom-width: 0px">
                                                            <asp:Label ID="lbl_simulation_control" Text="Simulation Control" runat="server" CssClass="normalLabel"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-top: 15px; background-color: #F2F2F2; border-top-color: transparent;
                                                            height: 110px; border-top-width: 0px">
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;">
                                                                <tr>
                                                                    <td align="center" style="width: 25%">
                                                                        <asp:Label ID="lbl_start" runat="server" Text="Start" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td align="center" style="width: 75%">
                                                                        <asp:Label ID="lbl_status" runat="server" Text="Status" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="center" style="width: 25%">
                                                                        <asp:ImageButton ID="ibtn_start" runat="server" ImageUrl="~/App/Images/Icons/run_simulation.png"
                                                                            OnClick="ibtn_start_Click" />
                                                                    </td>
                                                                    <td style="width: 75%">
                                                                        <telerik:RadProgressManager ID="RadProgressManager1" runat="server" />
                                                                        <telerik:RadProgressArea ID="RadProgressArea1" runat="server" Height="80px" ProgressIndicators="TotalProgressBar,CurrentFileName"
                                                                            Localization-TotalFiles="1" BorderStyle="None" BorderWidth="0px" Skin="Windows7"
                                                                            EnableAjaxSkinRendering="false" EnableViewState="False" Width="340px" />
                                                                    </td>
                                                                </tr>
                                                              
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div style="height: 1px; background-color: Orange">
                                                            </div>
                                                            <%--<asp:Image ID="img_hbar" runat="server" ImageUrl="~/App/Images/asset_1pxl-line_orange.png" Width="100%"/>--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px; padding-top: 5px; padding-right: 15px; padding-bottom: 0px;
                            border-color: transparent; border-width: 0px">
                            <asp:UpdatePanel ID="up_time_step" runat="server">
                                <ContentTemplate>
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td style="width: 50%" valign="top">
                                                <table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-color: #6F6F6F;
                                                    background-color: #F2F2F2; border-collapse: collapse; border-top-color: Black;">
                                                    <tr>
                                                        <td style="background-color: #BFBFBF; height: 25px; padding-left: 10px; border-bottom-color: transparent;
                                                            border-bottom-width: 0px">
                                                            <asp:Label ID="Label13" Text="Time Step" runat="server" CssClass="normalLabel"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
                                                                <tr>
                                                                    <td style="height: 20px; width: 50%">
                                                                        <asp:Label ID="Label15" runat="server" Text="Field" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 20%; padding-left: 5px">
                                                                        <asp:Label ID="Label17" runat="server" Text="Unit" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 30%; padding-left: 5px">
                                                                        <asp:Label ID="Label19" runat="server" Text="Obj1" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_notph" runat="server" Text="Number of Timesteps per Hour" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label26" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:TextBox ID="txt_notph" runat="server" Width="85" AutoPostBack="true" OnTextChanged="txt_notph_TextChanged"></asp:TextBox>
                                                                        <asp:HiddenField ID="hf_notph" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label28" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label24" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label30" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div style="height: 1px; background-color: Orange">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 2%">
                                            </td>
                                            <td style="width: 48%; padding-right: 20px; height: 100%" valign="top">
                                                <table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-color: #6F6F6F;
                                                    background-color: #F2F2F2; border-collapse: collapse; border-top-color: Black;">
                                                    <tr>
                                                        <td style="background-color: #BFBFBF; height: 25px; padding-left: 10px; border-bottom-color: transparent;
                                                            border-bottom-width: 0px">
                                                            <asp:Label ID="Label22" Text="Schedule Control" runat="server" CssClass="normalLabel"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%--<telerik:RadSchedulerRecurrenceEditor ID="RadSchedulerRecurrenceEditor1" 
                                                        runat="server"  >
                                                    
                                                    </telerik:RadSchedulerRecurrenceEditor>--%>
                                                            <table border="0" cellpadding="0" cellspacing="0" width="65%" style="border-collapse: collapse">
                                                                <tr>
                                                                    <td style="height: 20px; width: 50%" colspan="4">
                                                                        <asp:CheckBox ID="chk_enabled" runat="server" Text="Enabled" CssClass="normalLabel" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 5%; height: 20px">
                                                                    </td>
                                                                    <td>
                                                                        <asp:CheckBox ID="CheckBox1" runat="server" Text="Hourly" CssClass="normalLabel" />
                                                                    </td>
                                                                    <td align="left">
                                                                        <telerik:RadNumericTextBox ID="txtradnumeriktextbox" runat="server" ShowSpinButtons="true"
                                                                            Label="Every" CssClass="normalLabel" Type="Number" DataType="intger" MinValue="0"
                                                                            BorderColor="Black" ButtonsPosition="Left">
                                                                            <IncrementSettings Step="1" />
                                                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lbl_weeks" runat="server" Text="Weeks" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 5%; height: 20px">
                                                                    </td>
                                                                    <td>
                                                                        <asp:CheckBox ID="CheckBox2" runat="server" Text="Daily" CssClass="normalLabel" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server" ShowSpinButtons="true"
                                                                            Width="80%" CssClass="normalLabel" Type="Number" DataType="intger" MinValue="0"
                                                                            BorderColor="Black" ButtonsPosition="Left">
                                                                            <IncrementSettings Step="1" />
                                                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 5%; height: 20px">
                                                                    </td>
                                                                    <td>
                                                                        <asp:CheckBox ID="CheckBox3" runat="server" Text="Weekly" CssClass="normalLabel" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <telerik:RadNumericTextBox ID="RadNumericTextBox2" runat="server" ShowSpinButtons="true"
                                                                            CssClass="normalLabel" Type="Number" DataType="intger" MinValue="0" BorderColor="Black"
                                                                            ButtonsPosition="Left">
                                                                            <IncrementSettings Step="1" />
                                                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 5%; height: 20px">
                                                                    </td>
                                                                    <td>
                                                                        <asp:CheckBox ID="CheckBox4" runat="server" Text="Monthly" CssClass="normalLabel" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <telerik:RadNumericTextBox ID="RadNumericTextBox3" runat="server" ShowSpinButtons="true"
                                                                            CssClass="normalLabel" Type="Number" DataType="intger" MinValue="0" BorderColor="Black"
                                                                            ButtonsPosition="Left">
                                                                            <IncrementSettings Step="1" />
                                                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadNumericTextBox ID="RadNumericTextBox4" runat="server" ShowSpinButtons="true"
                                                                            Width="40px" CssClass="normalLabel" Type="Number" DataType="intger" MinValue="0"
                                                                            BorderColor="Black" ButtonsPosition="Left">
                                                                            <IncrementSettings Step="1" />
                                                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px; padding-top: 5px; padding-right: 15px; padding-bottom: 0px;
                            border-color: transparent; border-width: 0px">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
                                <tr>
                                    <td style="width: 50%" valign="top">
                                        <asp:UpdatePanel ID="up_runperiod" runat="server">
                                            <ContentTemplate>
                                                <table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-color: #6F6F6F;
                                                    border-collapse: collapse; background-color: #F2F2F2; border-top-color: Black;">
                                                    <tr>
                                                        <td style="background-color: #BFBFBF; height: 25px; padding-left: 10px; border-bottom-color: transparent;
                                                            border-bottom-width: 0px">
                                                            <asp:Label ID="Label7" Text="Run Period" runat="server" CssClass="normalLabel"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding-top: 0px; background-color: #F2F2F2; border-top-color: transparent;
                                                            border-top-width: 0px" valign="top">
                                                            <table border="1" cellpadding="0" cellspacing="0" width="100%" style="vertical-align: top;
                                                                empty-cells: show; border-collapse: collapse">
                                                                <tr>
                                                                    <td style="height: 20px; width: 50%">
                                                                        <asp:Label ID="Label8" runat="server" Text="Field" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 20%; padding-left: 5px">
                                                                        <asp:Label ID="Label9" runat="server" Text="Unit" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 30%; padding-left: 5px">
                                                                        <asp:Label ID="Label10" runat="server" Text="Obj1" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_name" runat="server" Text="Name" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label12" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:TextBox ID="txt_name" runat="server" Width="85" AutoPostBack="true" OnTextChanged="txt_name_TextChanged"></asp:TextBox>
                                                                        <asp:HiddenField ID="hf_name" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_bm" runat="server" Text="Begin Month" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label14" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_bm" runat="server" AutoPostBack="true" Height="22" Width="90"
                                                                            OnSelectedIndexChanged="ddl_bm_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_bm" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_bdom" runat="server" Text="Begin Day of Month" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label16" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_bdom" runat="server" AutoPostBack="true" Width="90" Height="22"
                                                                            OnSelectedIndexChanged="ddl_bdom_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_bdom" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_em" runat="server" Text="End Month" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label18" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_em" runat="server" AutoPostBack="true" Width="90" Height="22"
                                                                            OnSelectedIndexChanged="ddl_em_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_em" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_edom" runat="server" Text="End Day of Month" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label20" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_edom" runat="server" AutoPostBack="true" Width="90" Height="22"
                                                                            OnSelectedIndexChanged="ddl_edom_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_edom" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_dowfsd" runat="server" Text="Day of Week for Start Day" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label21" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_dowfsd" runat="server" AutoPostBack="true" Width="90" Height="22"
                                                                            OnSelectedIndexChanged="ddl_dowfsd_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_dowfsd" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_uwfhasd" runat="server" Text="Use Weather File Holidays and Special Days"
                                                                            CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label23" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_uwfhasd" runat="server" AutoPostBack="true" Height="22"
                                                                            Width="90" OnSelectedIndexChanged="ddl_uwfhasd_SelectedIndexChanged">
                                                                            <asp:ListItem Value="0" Text="-Select-" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_uwfhasd" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_uwfdsp" runat="server" Text="Use Weather File Daylight Saving Period"
                                                                            CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label25" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_uwfdsp" runat="server" AutoPostBack="true" Width="90" OnSelectedIndexChanged="ddl_uwfdsp_SelectedIndexChanged"
                                                                            Height="22">
                                                                            <asp:ListItem Value="0" Text="-Select-" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_uwfdsp" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_awhr" runat="server" Text="Apply Weekend Holiday Rule" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label27" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_awhr" runat="server" AutoPostBack="true" Width="90" OnSelectedIndexChanged="ddl_awhr_SelectedIndexChanged"
                                                                            Height="22">
                                                                            <asp:ListItem Value="0" Text="-Select-" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_awhr" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_uwfri" runat="server" Text="Use Weather File Rain Indicators"
                                                                            CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label29" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_uwfri" runat="server" AutoPostBack="true" Width="90" Height="22"
                                                                            OnSelectedIndexChanged="ddl_uwfri_SelectedIndexChanged">
                                                                            <asp:ListItem Value="0" Text="-Select-" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_uwfri" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_uwfsi" runat="server" Text="Use Weather File Snow Indicators"
                                                                            CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label31" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:DropDownList ID="ddl_uwfsi" runat="server" AutoPostBack="true" Width="90" Height="22"
                                                                            OnSelectedIndexChanged="ddl_uwfsi_SelectedIndexChanged">
                                                                            <asp:ListItem Value="0" Text="-Select-" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hf_uwfsi" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 20px">
                                                                        <asp:Label ID="lbl_notrtbr" runat="server" Text="Number of Times Runperiod to be Repeated"
                                                                            CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label33" runat="server" Text="" CssClass="normalLabel"></asp:Label>
                                                                    </td>
                                                                    <td style="background-color: White">
                                                                        <asp:TextBox ID="txt_notrtbr" runat="server" Width="85" AutoPostBack="true" OnTextChanged="txt_notrtbr_TextChanged"></asp:TextBox>
                                                                        <asp:HiddenField ID="hf_notrtbr" runat="server" Value="" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3">
                                                                        <div style="height: 1px; background-color: Orange">
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                    <td style="width: 2%">
                                    </td>
                                    <td style="width: 48%; padding-right: 20px; height: 100%" valign="top">
                                        <table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-color: #6F6F6F;
                                            background-color: #F2F2F2; border-top-color: Black;">
                                            <tr>
                                                <td style="background-color: #BFBFBF; height: 25px; padding-left: 10px; border-bottom-color: transparent;
                                                    border-bottom-width: 0px">
                                                    <asp:Label ID="Label11" Text="Simulation Result" runat="server" CssClass="normalLabel"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 290px">
                                                        <tr>
                                                            <td style="width: 30%; padding-top: 10px;" align="center">
                                                                <asp:Button ID="btn_spreadsheets" runat="server" Text="Spreadsheets" Width="100" />
                                                            </td>
                                                            <td style="width: 30%; padding-top: 10px;" align="center">
                                                                <asp:Button ID="btn_html" runat="server" Text="HTML" Width="100" />
                                                            </td>
                                                            <td style="width: 30%; padding-top: 10px;" align="center">
                                                                <asp:Button ID="btn_drawingFile" runat="server" Text="Drawing File" Width="100" />
                                                            </td>
                                                            <td style="width: 10%; padding-top: 10px;">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_idf_table" runat="server" Text="Tables" Width="45" OnClick="btn_idf_table_Click" />
                                                                <asp:Button ID="btn_idf_error" runat="server" Text="Errors" Width="45" OnClick="btn_idf_error_Click" />
                                                            </td>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_idf_dein" runat="server" Text="DE IN" Width="45" OnClick="btn_idf_dein_Click" />
                                                                <asp:Button ID="Button5" runat="server" Text="ELDMP" Width="45" OnClick="Button5_Click" />
                                                            </td>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_idf_bnd" runat="server" Text="BND" Width="45" OnClick="btn_idf_bnd_Click" />
                                                                <asp:Button ID="btn_idf_bsmto" runat="server" Text="Bsmt O" Width="45" OnClick="btn_idf_bsmto_Click" />
                                                            </td>
                                                            <td style="width: 10%;">
                                                                <asp:Button ID="btn_idf_bsmtc" runat="server" Text="Bsmt C" Width="45" OnClick="btn_idf_bsmtc_Click" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_meters" runat="server" Text="Meters" Width="45" OnClick="btn_meters_Click" />
                                                                <asp:Button ID="btn_idf_rdd" runat="server" Text="RDD" Width="45" OnClick="btn_idf_rdd_Click" />
                                                            </td>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_deout" runat="server" Text="DE OUT" Width="45" OnClick="btn_deout_Click" />
                                                                <asp:Button ID="btn_dfdmp" runat="server" Text="DFDMP" Width="45" OnClick="btn_dfdmp_Click" />
                                                            </td>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_dbg" runat="server" Text="DBG" Width="45" OnClick="btn_dbg_Click" />
                                                                <asp:Button ID="btn_idf_bsmt" runat="server" Text="Bsmt" Width="45" OnClick="btn_idf_bsmt_Click" />
                                                            </td>
                                                            <td style="width: 10%;" align="center">
                                                                <asp:Button ID="btn_idf_edd" runat="server" Text="EDD" Width="45" OnClick="btn_idf_edd_Click" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_idf_variab" runat="server" Text="Variab" Width="45" OnClick="btn_idf_variab_Click" />
                                                                <asp:Button ID="btn_idf_mdd" runat="server" Text="MDD" Width="45" OnClick="btn_idf_mdd_Click" />
                                                            </td>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_idf_map" runat="server" Text="MAP" Width="45" OnClick="btn_idf_map_Click" />
                                                                <asp:Button ID="btn_idf_screen" runat="server" Text="Screen" Width="45" OnClick="btn_idf_screen_Click" />
                                                            </td>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_sln" runat="server" Text="SLN" Width="45" OnClick="btn_sln_Click" />
                                                                <asp:Button ID="btn_idf_bsmta" runat="server" Text="Bsmt A" Width="45" OnClick="btn_idf_bsmta_Click" />
                                                            </td>
                                                            <td style="width: 10%;" align="center">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 30%; padding-top: 15px" align="center">
                                                                <asp:Button ID="btn_idf_eio" runat="server" Text="EIO" Width="45" OnClick="btn_idf_eio_Click" />
                                                                <asp:Button ID="btn_idf_mtd" runat="server" Text="MTD" Width="45" OnClick="btn_idf_mtd_Click" />
                                                            </td>
                                                            <td style="width: 30%; padding-top: 15px" align="center">
                                                                <asp:Button ID="btn_idf_expidf" runat="server" Text="EXPIDF" Width="45" OnClick="btn_idf_expidf_Click" />
                                                                <asp:Button ID="btn_idf_shd" runat="server" Text="SHD" Width="45" OnClick="btn_idf_shd_Click" />
                                                            </td>
                                                            <td style="width: 30%; padding-top: 15px" align="center">
                                                                <asp:Button ID="btn_idf_eso" runat="server" Text="ESO" Width="45" OnClick="btn_idf_eso_Click" />
                                                                <asp:Button ID="btn_idf_slabo" runat="server" Text="Slab O" Width="45" OnClick="btn_idf_slabo_Click" />
                                                            </td>
                                                            <td style="width: 10%; padding-top: 15px" align="center">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_idf_svg" runat="server" Text="SVG" Width="45" OnClick="btn_idf_svg_Click" />
                                                                <asp:Button ID="btn_idf_zsz" runat="server" Text="ZSZ" Width="45" OnClick="btn_idf_zsz_Click" />
                                                            </td>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_idf_epmidf" runat="server" Text="EPMIDF" Width="45" OnClick="btn_idf_epmidf_Click" />
                                                                <asp:Button ID="btn_idf_vrml" runat="server" Text="VRML" Width="45" OnClick="btn_idf_vrml_Click" />
                                                            </td>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_idf_mtr" runat="server" Text="MTR" Width="45" OnClick="btn_idf_mtr_Click" />
                                                                <asp:Button ID="btn_idf_slab" runat="server" Text="Slab" Width="45" OnClick="btn_idf_slab_Click" />
                                                            </td>
                                                            <td style="width: 10%;" align="center">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_idf_dxf" runat="server" Text="DXF" Width="45" OnClick="btn_idf_dxf_Click" />
                                                                <asp:Button ID="btn_idf_ssz" runat="server" Text="SSZ" Width="45" OnClick="btn_idf_ssz_Click" />
                                                            </td>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_idf_epmdet" runat="server" Text="EPMDET" Width="45" OnClick="btn_idf_epmdet_Click" />
                                                                <asp:Button ID="btn_idf_audit" runat="server" Text="Audit" Width="45" OnClick="btn_idf_audit_Click" />
                                                            </td>
                                                            <td style="width: 30%" align="center">
                                                                <asp:Button ID="btn_idf_proc" runat="server" Text="Proc" Width="45" OnClick="btn_idf_proc_Click" />
                                                                <asp:Button ID="btn_idf_slaberr" runat="server" Text="Slab Err" Width="45" OnClick="btn_idf_slaberr_Click" />
                                                            </td>
                                                            <td style="width: 10%;" align="center">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div style="height: 1px; background-color: Orange">
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px; padding-top: 5px; padding-right: 15px; padding-bottom: 10px;
                            border-color: transparent; border-width: 0px">
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hf_idf_file_name" Value="" runat="server" />
    <asp:HiddenField ID="hf_ep_batch_file_path" Value="" runat="server" />
 
    <%--<telerik:RadAjaxManagerProxy ID="radBIMServer" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadProgressArea1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>--%>
</asp:Content>
