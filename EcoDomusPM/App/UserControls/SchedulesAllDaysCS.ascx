<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SchedulesAllDaysCS.ascx.cs" Inherits="App_UserControls_SchedulesAllDaysCS" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<script language="javascript" type="text/javascript">
    function resize_frame_page() {
        //window.resizeTo(1000, height);

        var docHeight;
        try {
            var obj = parent.window.frames[1];
            if (obj != null) {

                window.parent.resize_iframe(parent.window.frames[1]);

            }
        }
        catch (e) {
            window.status = 'Error: ' + e.number + '; ' + e.description;
        }

    }

    function ValidateThrough(result) {

        lblMsg = document.getElementById("<%=lblDateErrMsg.ClientID %>");
        objThrough = document.getElementById("<%=txtThrough.ClientID %>");
        lblMonLimitTime = document.getElementById("<%=lblThrough.ClientID %>");
        if (objThrough != null) {
            valThrough = objThrough.value;
            if (valThrough == "") {
                lblMonLimitTime.innerHTML = "*";
                result = false;
            }
            else {
                lblMonLimitTime.innerHTML = "";
            }
            if (valThrough != "") {
                //var regex = /^(1[0-2]|[1-9])\/(3[01]|[12][0-9]|[1-9])$/;
               
                var regex = /^(1[0-2]|[1-9]|0[1-9])\/(3[01]|[12][0-9]|[1-9]|0[1-9])$/;
                if (!regex.test(valThrough.replace(/^s+/g, '').replace(/s+$/g, ''))) {
                    if (lblMsg.innerHTML == "") {
                        lblMsg.innerHTML = "Enter valid date";
                    }
                    result = false;
                }
                else {
                    lblMsg.innerHTML = "";
                }
            }
        }
        return result;
    }

    function ValidateFields(button, args) {
        result = true;
        result = ValidateThrough(result);
        //For Monday
        txtMonTime = document.getElementById("<%=txtMonTime.ClientID %>");
        valMonTime = txtMonTime.value;
        txtMonLimitTime = document.getElementById("<%=txtMonLimitTime.ClientID %>");
        valMonLimitTime = txtMonLimitTime.value;
        lblMonLimitTime = document.getElementById("<%=lblMonLimitTime.ClientID %>");
        lblMsg = document.getElementById("<%=lblNumberFormatMsg.ClientID %>");
        if (valMonTime == "" || valMonLimitTime == "") {
            lblMonLimitTime.innerHTML = "*";
            result = false;
        }
        else {
            lblMonLimitTime.innerHTML = "";
        }
        if (valMonTime != "" || valMonLimitTime != "") {
            var regex = /^(\d)+(\:)?(\d)*$/;
            var reges1 = /^(\d)+(\.)?(\d)*$/;
            if (!regex.test(valMonTime)) {
                if (lblMsg.innerHTML == "") {
                    lblMsg.innerHTML = "Allows only number";
                }
                txtMonTime.style.borderColor = "SeaGreen";
                result = false;
            }
            else {
                txtMonTime.style.borderColor = "";
            }

            if (!reges1.test(valMonLimitTime)) {
                if (lblMsg.innerHTML == "") {
                    lblMsg.innerHTML = "Allows only number";
                }
                txtMonLimitTime.style.borderColor = "SeaGreen";
                result = false;
            }
            else {
                txtMonLimitTime.style.borderColor = "";
            }

        }
        //For Tuesday
        var txtTueTime = document.getElementById("<%=txtTueTime.ClientID %>");
        var valTueTime = txtTueTime.value;
        var txtTueTimeLimit = document.getElementById("<%=txtTueTimeLimit.ClientID %>");
        var valTueTimeLimit = txtTueTimeLimit.value;
        result = validatValues(txtTueTime, txtTueTimeLimit, result);

        //For Wednesday
        var txtWenTime = document.getElementById("<%=txtWenTime.ClientID %>");
        var valWenTime = txtWenTime.value;
        var txtWenTimeLimit = document.getElementById("<%=txtWenTimeLimit.ClientID %>");
        var valWenTimeLimit = txtWenTimeLimit.value;
        result = validatValues(txtWenTime, txtWenTimeLimit, result);

        //For Thursday
        var txtThuTime = document.getElementById("<%=txtThuTime.ClientID %>");
        var valThuTime = txtThuTime.value;
        var txtThuTimeLimit = document.getElementById("<%=txtThuTimeLimit.ClientID %>");
        var valThuTimeLimit = txtThuTimeLimit.value;
        result = validatValues(txtThuTime, txtThuTimeLimit, result);

        //For Friday
        var txtFriTime = document.getElementById("<%=txtFriTime.ClientID %>");
        var valFriTime = txtFriTime.value;
        var txtFriTimeLimit = document.getElementById("<%=txtFriTimeLimit.ClientID %>");
        var valFriTimeLimit = txtFriTimeLimit.value;
        result = validatValues(txtFriTime, txtFriTimeLimit, result);

        //For Saturday
        var txtSatTime = document.getElementById("<%=txtSatTime.ClientID %>");
        var valSatTime = txtSatTime.value;
        var txtSatLimitTime = document.getElementById("<%=txtSatLimitTime.ClientID %>");
        var valSatLimitTime = txtSatLimitTime.value;
        result = validatValues(txtSatTime, txtSatLimitTime, result);

        //For Sunday
        var txtSunTime = document.getElementById("<%=txtSunTime.ClientID %>");
        var valSunTime = txtSunTime.value;
        var txtSunTimeLimit = document.getElementById("<%=txtSunTimeLimit.ClientID %>");
        var valSunTimeLimit = txtSunTimeLimit.value;
        result = validatValues(txtSunTime, txtSunTimeLimit, result);

        //For Holiday
        var txtHoliTime = document.getElementById("<%=txtHoliTime.ClientID %>");
        var valHoliTime = txtHoliTime.value;
        var txtHoliTimeLimit = document.getElementById("<%=txtHoliTimeLimit.ClientID %>");
        var valHoliTimeLimit = txtHoliTimeLimit.value;
        result = validatValues(txtHoliTime, txtHoliTimeLimit, result);

        //For Custom Day
        var txtCusTime = document.getElementById("<%=txtCusTime.ClientID %>");
        var valCusTime = txtCusTime.value;
        var txtCusTimeLimit = document.getElementById("<%=txtCusTimeLimit.ClientID %>");
        var valCusTimeLimit = txtCusTimeLimit.value;
        result = validatValues(txtCusTime, txtCusTimeLimit, result);
        resize_frame_page();
        if (result) {
            button.set_autoPostBack(true);
        }
        else {
            button.set_autoPostBack(false);
        }

        return result;
    }


    function validatValues(txtValTime, txtValLimit, result) {
        valTime = txtValTime.value;
        valTimeLimit = txtValLimit.value;
        lblMsg = document.getElementById("<%=lblNumberFormatMsg.ClientID %>");
        if (valTime != "" || valTimeLimit != "") {
            var regex = /^(\d)+(\:)?(\d)*$/;
            var regex1 = /^(\d)+(\.)?(\d)*$/;
            if (!regex.test(valTime)) {

                if (lblMsg.innerHTML == "") {
                    lblMsg.innerHTML = "Allows only number";
                }
                txtValTime.style.borderColor = "SeaGreen";
                result = false;
            }
            else {
                txtValTime.style.borderColor = "";
            }

            if (!regex1.test(valTimeLimit)) {
                if (lblMsg.innerHTML == "") {
                    lblMsg.innerHTML = "Allows only number";
                }
                txtValLimit.style.borderColor = "SeaGreen";
                result = false;
            }

            else {
                txtValLimit.style.borderColor = "";
            }

        }
        return result;
    }
    
    
    </script>
    <telerik:RadFormDecorator ID="rdfSchedules" runat="server" 
    DecoratedControls="Buttons,RadioButtons,Scrollbars" Skin="Default" />
    <fieldset runat="server" id="id1" visible="true" style="border-color: #F9EAEA; border-style: inherit;
    float: inherit; table-layout:fixed">
        <table id="Table1" runat="server" border="0" width="100%">
            <tr>
                <td style="width: 40%">
                    <table border="0">
                        <tr>
                            <td valign="top">
                                <table border="0" align="left">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label11" runat="server" Text="From" CssClass="normalLabel"></asp:Label>:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFrom" runat="server" CssClass="SmallTextBox" Width="100px" Text="01/01"
                                                ReadOnly="true" AutoPostBack="false" Enabled="false"></asp:TextBox>
                                        </td>
                                        <td>
                                            <%-- <asp:RequiredFieldValidator ID="rftxtFrom" ValidationGroup="validateSchedule" runat="server"
                                                    ControlToValidate="txtFrom" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                    Visible="true" SetFocusOnError="true">
                                                </asp:RequiredFieldValidator>--%>
                                            <asp:Label ID="lblFrom1" runat="server" Text="(mm/dd)" CssClass="normalLabel"></asp:Label>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" style="height: 10px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label12" runat="server" Text="Through" CssClass="normalLabel"></asp:Label>:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtThrough" runat="server" CssClass="SmallTextBox" Width="100px"
                                                Text="01/01"></asp:TextBox>
                                        </td>
                                        <td>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="validateSchedule"
                                                    runat="server" ControlToValidate="txtThrough" ErrorMessage="*" ForeColor="Red"
                                                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                                                </asp:RequiredFieldValidator>--%>
                                            <asp:Label ID="lblThrough1" runat="server" Text="(mm/dd)" CssClass="normalLabel"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblThrough" runat="server" Text="" ForeColor="Red"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <asp:Label ID="lblDateErrMsg" runat="server" Text="" ForeColor="Red" CssClass="LabelText"></asp:Label>
                                        </td>
                                    </tr>
                                   
                                    
                                    <tr>
                                        <td colspan="4">
                                            <asp:CheckBox ID="chkWeekDays" runat="server" Text="Week Days" TextAlign="Right"
                                                CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <asp:CheckBox ID="chkAllDays" runat="server" Text="All Days" TextAlign="Right" CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <asp:CheckBox ID="chkAllOtherDays" runat="server" Text="All Other Days" TextAlign="Right"
                                                CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <asp:CheckBox ID="chkWinterDesignDay" runat="server" Text="Winter Design Day" TextAlign="Right"
                                                CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <asp:CheckBox ID="chkSummerDesignDays" runat="server" Text="Summer Design Days" TextAlign="Right"
                                                CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <asp:CheckBox ID="chkCustomDay1" runat="server" Text="Custom Day1" TextAlign="Right"
                                                CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <asp:CheckBox ID="chkCustomDay2" runat="server" Text="Custom Day2" TextAlign="Right"
                                                CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <asp:CheckBox ID="chkWeekEnds" runat="server" Text="Week Ends" TextAlign="Right"
                                                CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <asp:CheckBox ID="chkHoliday" runat="server" Text="Holiday" TextAlign="Right" CssClass="normalLabel" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                    <fieldset id="id3" style="border-right-color: transparent; border-left-color: #A9A9A9;
                        border-top-color: transparent; border-bottom-color: transparent; border-right-style: solid">
                        <table border="0" width="80%" align="left">
                            <tr>
                                <td align="left" style="width: 10%;">
                                </td>
                                <td align="left" style="width: 20%;">
                                    <asp:Label ID="lblTime" runat="server" Text="Time" CssClass="Label" Font-Underline="true"></asp:Label>
                                </td>
                                <td>
                                </td>
                                <td align="left" style="width: 20%;">
                                    <asp:Label ID="lblLimitValue" runat="server" Text="Limit Value" CssClass="Label"
                                        Font-Underline="true"></asp:Label>
                                </td>
                                <td align="left" style="width: 20%;">
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label10" runat="server" Text="Start" CssClass="normalLabel" Font-Underline="true"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="TextBox17" runat="server" CssClass="SmallTextBox" Width="100px"
                                        Text="00.00" Enabled="false"></asp:TextBox>
                                </td>
                                <td>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator20" ValidationGroup="valGroup<%= ClientId %>"
                    runat="server" ControlToValidate="txtMonLimitTime" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="TextBox18" runat="server" CssClass="SmallTextBox" Width="100px"
                                        Text="0.0" Enabled="false"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator19" ValidationGroup="valGroup<%= ClientId %>"
                    runat="server" ControlToValidate="txtMonTime" ErrorMessage="*" ForeColor="Red" 
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label1" runat="server" Text="Monday" CssClass="normalLabel"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtMonTime" runat="server" CssClass="SmallTextBox" Width="100px"
                                        Text="00:00" CausesValidation="true" ></asp:TextBox>
                                </td>
                                <td>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtMonTime" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                    <%--<asp:CompareValidator ID="id1" runat="server" ControlToValidate="txtMonTime" EnableClientScript="false"
                     ErrorMessage="Only number" ForeColor="Red" Operator="DataTypeCheck" Type="Double"
                     ValidationGroup="validateSchedule" SetFocusOnError="true"></asp:CompareValidator>--%>
                                    <asp:Label Text="" runat="server" ID="lblMonTime" ForeColor="Red"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtMonLimitTime" runat="server" CssClass="SmallTextBox" Width="100px"
                                        CausesValidation="true" Text="0.0"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtMonLimitTime" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                    <%--<asp:CompareValidator ID="CompareValidator1" ControlToValidate="txtMonTime" Type="Double"
                     ErrorMessage="Only number" ForeColor="Red" runat="server" ValidationGroup="validateSchedule"
                     Operator="DataTypeCheck" EnableClientScript="false" SetFocusOnError="true"></asp:CompareValidator>--%>
                                    <asp:Label Text="*" runat="server" ID="lblMonLimitTime" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label2" runat="server" Text="Tuesday" CssClass="normalLabel"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtTueTime" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtTueTime" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtTueTimeLimit" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtTueTimeLimit" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label3" runat="server" Text="Wednesday" CssClass="normalLabel"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtWenTime" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtWenTime" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtWenTimeLimit" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtWenTimeLimit" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label4" runat="server" Text="Thursday" CssClass="normalLabel"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtThuTime" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtThuTime" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtThuTimeLimit" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtThuTimeLimit" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label5" runat="server" Text="Friday" CssClass="normalLabel"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFriTime" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtFriTime" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFriTimeLimit" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtFriTimeLimit" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label6" runat="server" Text="Saturday" CssClass="normalLabel"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtSatTime" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtSatTime" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtSatLimitTime" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator11" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtSatLimitTime" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label7" runat="server" Text="Sunday" CssClass="normalLabel"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtSunTime" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator14" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtSunTime" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtSunTimeLimit" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator13" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtSunTimeLimit" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label8" runat="server" Text="Holiday" CssClass="normalLabel"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtHoliTime" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtHoliTime" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtHoliTimeLimit" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator15" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtHoliTimeLimit" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>
                                    --%>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label9" runat="server" Text="Custom Day" CssClass="normalLabel" Width="100px"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtCusTime" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator18" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtCusTime" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtCusTimeLimit" runat="server" CssClass="SmallTextBox" Width="100px"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator17" ValidationGroup="validateSchedule"
                    runat="server" ControlToValidate="txtCusTimeLimit" ErrorMessage="*" ForeColor="Red"
                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                </asp:RequiredFieldValidator>--%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center">
                                    <asp:Label ID="lblMsg" ForeColor="Red" runat="server" Text="" Width="100%" CssClass="normalLabel"></asp:Label>
                                </td>
                                <td align="right">
                                    <%--<asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" OnClientClick="javascript:return ValidateFields()" />--%>
                                    <telerik:RadButton runat="server" ID="btnSave" OnClick="btnSave_Click" 
                                        Text="Save" OnClientClicked="ValidateFields" AutoPostBack="false" 
                                        style="top: 0px; left: -57px"></telerik:RadButton>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5">
                                    <asp:Label ID="lblNumberFormatMsg" runat="server" Text="" ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
</fieldset>
<asp:HiddenField ID="hf_pk_simulation_schedules_id" runat ="server" Value="" />
<asp:HiddenField ID="IsFirstTime" runat ="server" Value="Yes" />
<asp:HiddenField ID ="isCleanData" runat="server" Value="Yes" />