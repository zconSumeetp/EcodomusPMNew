<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SchedulerCS.ascx.cs" Inherits="App_UserControls_SchedulerCS" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
<link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.fieldsetstyle
    {
        border: 1.5px solid black;
    }
     
</style>
<script type="text/javascript">
    function pageLoad() {
        
        var $ = $telerik.$;
        $(".RecurrenceEditor").children().each(function (i) {
            if (i == 0)
                $($($(this).children()[0]).children()[0]).attr("checked", "checked");
            else if (i == 1)
                this.style.display = "block";
        });

        var ul_list = $(".rsRecurrenceOptionList");

        ul_list.prepend("<li><input class='rfdRealInput1' name='ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$RadSchedulerRecurrenceEditor1$RepeatFrequency'  id='my_id' type='radio' onClick='function1();' /><label id='id2'> Minutes</label></li>");

        var div_con = $(".rsAdvRecurrencePatterns");

        div_con.append("<div class='rsAdvRecurrenceFreq1' id='my_div' style='display:none;border:0px solid black;width:400px;height:150px;'> &nbsp; &nbsp; &nbsp; Every <input type='number' id='txt_minutes' name='txt_minutes' style='width:25px;' value='1' onkeypress='return onlyNumbers(event);' />&nbsp;Minute(s) </div>");
        test2();
        $(".RecurrenceEditor_Default").css({ "font-family": "Arial", "font-size": "11px", "font-style": "normal", "font-variant": "normal" });
        $(".RecurrenceEditor_Default .rsAdvPatternPanel").css({ "height": "120px" });
        $(".fieldsetstyle").css({"border" :"1px solid black"});
    }
    //    $(document).ready(function () {
    //        var ul_list = $(".rsRecurrenceOptionList");

    //        ul_list.prepend("<li><input class='rfdRealInput1' name='ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$RadSchedulerRecurrenceEditor1$RepeatFrequency'  id='my_id' type='radio'  /><label id='id2'> kaustubh</label></li>");

    //        var div_con = $(".rsAdvOptionsPanel");
    //        div_con.prepend("<div class='rsAdvRecurrenceFreq' id='my_div' style='display:none;' > For region</div>");
    //       
    //       
    //        $("#my_id").click(
    //        alert('hi')
    //        )
    //   
    //    });
    function function1() {

        //alert("hello");
        //        document.getElementById("my_div").style.display = 'block';
        //        document.getElementById("my_div").style.float = 'left';

        document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RecurrencePatternHourlyPanel").style.display = 'none';
        document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RecurrencePatternDailyPanel").style.display = 'none';
        document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RecurrencePatternWeeklyPanel").style.display = 'none';
        document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RecurrencePatternMonthlyPanel").style.display = 'none';
        document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RecurrencePatternYearlyPanel").style.display = 'none';
        document.getElementById("my_div").style.display = 'block';
        //        document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_minute_flag").value = "1";
    }
    function validate_minute() {

        //alert(document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_minute_flag").value);
        var i = 0;
        if (document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RecurrencePatternHourlyPanel").style.display != 'none') {
            i++;
            document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_minute_flag").value = "0";
        }
        if (document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RecurrencePatternDailyPanel").style.display != 'none') {
            i++;
            document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_minute_flag").value = "0";
        }
        if (document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RecurrencePatternWeeklyPanel").style.display != 'none') {
            i++;
            document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_minute_flag").value = "0";
        }
        if (document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RecurrencePatternMonthlyPanel").style.display != 'none') {
            i++;
            document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_minute_flag").value = "0";
        }
        if (document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RecurrencePatternYearlyPanel").style.display != 'none') {
            i++;
            document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_minute_flag").value = "0";
        }
        if (i != 0) {
            document.getElementById("my_div").style.display = 'none';
            document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_minute_flag").value = "0";
        }
        else {
            document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_minute_flag").value = "1";

            if (document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RepeatIndefinitely").checked) {
                //                alert("1st checked");
                document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_repeat_flag").value = "1";
            }
            if (document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RepeatGivenOccurrences").checked) {
                //                alert("2nd checked");
                document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_repeat_flag").value = "2";
                document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_Occurrences_no").value = document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RangeOccurrences_text").value;
            }
            if (document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RepeatUntilGivenDate").checked) {
                //                alert("3rd checked");
                document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_repeat_flag").value = "3";
                document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_end_by_date").value = document.getElementById("ctl00_ContentPlaceHolder1_~/App/UserControls/ScheduleruserControl_RadSchedulerRecurrenceEditor1_RangeEndDate_dateInput_text").value;

            }
        }
        
    }
    function onlyNumbers(evt) {

        var e = event || evt; // for trans-browser compatibility
        var charCode = e.which || e.keyCode;

        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;

        return true;

    }
    function test2() {
        
        if (document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_minutes_track").value != "") {
            document.getElementById("my_div").style.display = 'block';
            document.getElementById("my_div").style.height = "150px";
            document.getElementById("txt_minutes").value = document.getElementById("ctl00$ContentPlaceHolder1$~/App/UserControls/ScheduleruserControl$hf_minutes_track").value;
            document.getElementById("my_id").checked = true;
        }
        //alert('in javascript');
    }
</script>
<style type="text/css">
    .style1
    {
        font-family: Times New Roman, Times, serif;
        font-size: 18px;
    }
    .style3
    {
        height: 36px;
    }
    .style4
    {
        height: 37px;
    }
    .fieldsetstyle
    {
        border: 1.5px solid black;
    }
     
</style>
<telerik:RadCodeBlock  runat="server" ID="RadCodeBlock1">
<style type="text/css">
    .rsRecurrenceOptionList
    {
        height: 150px;
    }
    .rsAdvRecurrencePatterns
    {
        height: 150px;
    }
    .rfdRealInput1
    {
        float: left;
    }
    div.RecurrenceEditor_Default
    {
        font-family:Arial;
        font-size:11px;
        font-style:normal;
        font-variant:normal;
    }
    .RecurrenceEditor_Default .rsAdvPatternPanel
    {
        height:120px;
    }
</style>
</telerik:RadCodeBlock>
<telerik:RadFormDecorator ID="rdfSetupSync" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
<div >
<fieldset class="fieldsetstyle">
<div style="margin: 05px 10px 20px 10px;">
    <table width="100%">
        <tr>
            <td align="left">
                <caption>
                    <asp:Label ID="lblScheduler" runat="server" Text="<%$Resources:Resource,Scheduler%>"
                        ForeColor="#990033"></asp:Label>
                </caption>
            </td>
        </tr>
    </table>
    <table width="100%" >
        <tr>
            <td>
                <div onclick="validate_minute();">
                    <telerik:RadSchedulerRecurrenceEditor ID="RadSchedulerRecurrenceEditor1" runat="server"
                        OnLoad="OnControlLoad"  MinutesPerRow="True">

                    </telerik:RadSchedulerRecurrenceEditor>
                </div>
            </td>
        </tr>
        <tr>
            <td class="style3">
                <asp:Label ID="lbl_test" Text="" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="style4">
                <div onclick="validate_minute();">
                    <asp:Button ID="btnSaveSchedule" runat="server" Text="<%$Resources:Resource,Save_Schedule%>"
                        OnClick="btnSaveSchedule_Click" />
                </div>
                <br />
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <asp:HiddenField runat="server" ID="hf_minute_flag" Value="" />
                <asp:HiddenField runat="server" ID="hf_repeat_flag" Value="" />
                <asp:HiddenField runat="server" ID="hf_Occurrences_no" Value="" />
                <asp:HiddenField runat="server" ID="hf_end_by_date" Value="" />
                <asp:HiddenField runat="server" ID="hf_minutes_track" Value="" />
            </td>
        </tr>
    </table>
</div>
</fieldset>
</div>
<style type="text/css">
.fieldsetstyle
    {
        border: 1.5px solid black;
    }
     
</style>