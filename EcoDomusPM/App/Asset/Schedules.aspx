<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Schedules.aspx.cs" Inherits="App_Asset_Schedules" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/App/UserControls/SchedulesWeekDaysCS.ascx" TagName="schedules"
    TagPrefix="sc" %>
<%@ Register Src="~/App/UserControls/SchedulesAllDaysCS.ascx" TagName="schedules1"
    TagPrefix="sc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/radmenu.css" />
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
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
            function validateScheduleData() {
            
            result = true;

            if ($find('<%=rcbScheduleName.ClientID %>').get_text() == "--Select--") {
                document.getElementById("<%=lblScheduleName.ClientID %>").innerHTML = '*';
                result = false;
                //Page_ClientValidate();
                //return false
            }
            if ($find('<%=rcbScheduleName.ClientID %>').get_text() == "") {
                document.getElementById("<%=lblScheduleName.ClientID %>").innerHTML = '*';
                result = false;
            }
            if ($find('<%=rcbTypeName.ClientID %>').get_selectedItem().get_text() == " --Select-- ") {
                document.getElementById("<%=lblTypeName.ClientID %>").innerHTML = '*';
                result = false;
                //Page_ClientValidate();
                //return false
            }

            if ($find('<%=rcbFor.ClientID %>').get_selectedItem().get_text() == " --Select-- ") {
                document.getElementById("<%=lblFor.ClientID %>").innerHTML = '*';
                result = false;
                //Page_ClientValidate();
                //return false
            }
            return result
           }
          //window.onload = validateForm;

            function deleteTab(tabText) {
                var tabStrip = $find("<%= rdstripSchedules.ClientID %>");
                var multiPage = $find("<%= rmpageSchedules.ClientID %>");
                var obj = $find("<%= rcbFor.ClientID %>");
                tabStrip.trackChanges();
                multiPage.trackChanges();
                var name = obj._text;
                var tab = tabStrip.findTabByText(name);
                var pageView = tab.get_pageView();
                var tabToSelect = tab.get_nextTab();
                if (!tabToSelect)
                    tabToSelect = tab.get_previousTab();
                tabStrip.get_tabs().remove(tab);
                tabStrip.commitChanges();
                multiPage.get_pageViews().remove(pageView);
                multiPage.commitChanges();
                if (tabToSelect)
                    tabToSelect.set_selected(true);

            }
        </script>
    </telerik:RadCodeBlock>
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManagerId" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" DecoratedControls="Buttons" />
    <div>
        <table align="left" style="margin-left: 0px; float: none" cellpadding="0" border="0"
            width="80%">
            <tr>
                <td>
                    <table border="0">
                        <tr>
                            <th>
                                <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource, Name%>" CssClass="LabelText"></asp:Label>:
                            </th>
                            <td>
                               <%-- <asp:TextBox ID="txtName" runat="server" CssClass="SmallTextBox" Width="200px" CausesValidation="true"></asp:TextBox>--%>
                                <telerik:RadComboBox ID="rcbScheduleName" runat="server" Height="100px" Width="200px"
                                    CausesValidation="true"  AutoPostBack="true"  AllowCustomText="true" Text="--Select--"
                                    onselectedindexchanged="rcbScheduleName_SelectedIndexChanged">
                                    
                                </telerik:RadComboBox>
                                <asp:Label ID="lblScheduleName" runat="server" Text="" ForeColor="Red"></asp:Label>
                            </td>
                            <td>
                                <%--<asp:RequiredFieldValidator ID="rftxtName" ValidationGroup="validateForSection" runat="server"
                                    Text="*" ControlToValidate="rcbScheduleName" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                    Visible="true" SetFocusOnError="true" InitialValue="--Select--">
                                </asp:RequiredFieldValidator>--%>
                            </td>
                            <th>
                                <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource, Type_Name%>" CssClass="LabelText" ></asp:Label>:
                            </th>
                            <td>
                                <telerik:RadComboBox ID="rcbTypeName" runat="server" Height="100px" Width="200px"
                                    CausesValidation="true">
                                </telerik:RadComboBox>
                                 <asp:Label ID="lblTypeName" runat="server" Text="" ForeColor="Red"></asp:Label>
                            </td>
                            <td>
                                <%--<asp:RequiredFieldValidator ID="rfrcbTypeName" ValidationGroup="validateForSection"
                                    Text="*" runat="server" ControlToValidate="rcbTypeName" ErrorMessage="*" ForeColor="Red"
                                    Display="Dynamic" InitialValue=" --Select-- " Visible="true" SetFocusOnError="true">
                                </asp:RequiredFieldValidator>--%>
                               
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <asp:Label ID="Label4" runat="server" Text="For" CssClass="LabelText"></asp:Label>:
                            </th>
                            <td>
                                <telerik:RadComboBox ID="rcbFor" runat="server"  Width="200px" AllowCustomText="false" Filter="Contains">
                                   <%-- <Items>
                                        <telerik:RadComboBoxItem runat="server" Value="Select" Text="--Select--" Selected="true" />
                                        <telerik:RadComboBoxItem runat="server" Value="AllDays" Text="All Days" />
                                        <telerik:RadComboBoxItem runat="server" Value="AllOtherDays" Text="All Other Days" />
                                        <telerik:RadComboBoxItem runat="server" Value="CustomDay1" Text="Custom Day 1" />
                                        <telerik:RadComboBoxItem runat="server" Value="CustomDay2" Text="Custom Day 2" />
                                        <telerik:RadComboBoxItem runat="server" Value="Holiday" Text="Holiday" />
                                        <telerik:RadComboBoxItem runat="server" Value="SummerDesignDays" Text="Summer Design Days" />
                                        <telerik:RadComboBoxItem runat="server" Value="WeekDays" Text="Week Days" />
                                        <telerik:RadComboBoxItem runat="server" Value="WeekEnds" Text="Week Ends" />
                                        <telerik:RadComboBoxItem runat="server" Value="WinterDesignDay" Text="Winter Design Day" />
                                    </Items>--%>
                                </telerik:RadComboBox>
                                <asp:Label ID ="lblFor" runat="server" Text="" ForeColor="Red"></asp:Label>
                            </td>
                            <td>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="validateForSection"
                                    runat="server" ControlToValidate="rcbFor" ErrorMessage="*" ForeColor="Red" Text="*"
                                    InitialValue="--Select--" Visible="true" SetFocusOnError="true">
                                </asp:RequiredFieldValidator>--%>
                                
                            </td>
                            <td colspan="2">
                                <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="<%$Resources:Resource, Add%>" Width="50px"
                                     OnClientClick="javascript:return validateScheduleData();"/>
                                &nbsp;&nbsp
                                <asp:Button ID="btnDelete" Width="50px" runat="server" Text="<%$Resources:Resource, Delete%>" OnClick="btnDelete_Click" />
                                <%--OnClientClick="javascript:return deleteTab();"--%>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <asp:Label ID="lblErrMsg" runat="server" Text="" ForeColor="Red" CssClass="LabelText"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            </table>


            <table border="0" width="80%">
            <tr>
                <td>
                    <table border="0" width="80%">
                        <tr>
                            <td>
                                <telerik:RadTabStrip ID="rdstripSchedules" SelectedIndex="0" runat="server" MultiPageID="rmpageSchedules"
                                    OnTabClick="rdstripSchedules_TabClick" ScrollChildren="true" ScrollButtonsPosition="Middle">
                                </telerik:RadTabStrip>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                 <table border="0">
                        <tr>
                            <td>
                    <telerik:RadMultiPage ID="rmpageSchedules" runat="server" CssClass="multiPage" SelectedIndex="0"
                        OnPageViewCreated="RadMultiPage1_PageViewCreated" RenderSelectedPageOnly="true">
                    </telerik:RadMultiPage>
                    </td>
                    </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td >
                    
                </td>
            </tr>
        </table>
        <div runat="server" id="dvBtn" style="display:none">
        <table border="0" width="80%">
                        <tr>
                            <td style="width:50%" align="right">
                                <asp:Button ID="btnAddNewSchedule" runat="server" Text="New Schedule" Width="100"
                                    ValidationGroup="validateForSection" OnClick="btnAddNewSchedule_Click" />
                            </td>
                            <td style="width: 50%" align="left">
                                <asp:Button ID="btnDeleteSchedule" runat="server" Text="Delete Scheduele" Width="100"
                                    ValidationGroup="validateForSection" OnClick="btnDeleteSchedule_Click" />
                            </td>
                        </tr>
        </table>
        </div>
    </div>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="dvSchedule" />
                    <telerik:AjaxUpdatedControl ControlID="dvSchedule" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdstripSchedules">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rmpageSchedules" />
                    <telerik:AjaxUpdatedControl ControlID="rcbFor" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        >
    </telerik:RadAjaxLoadingPanel>
    <asp:HiddenField ID="hf_pk_WeekDays" runat="server" Value="" />
    <asp:HiddenField ID="hf_pk_AllDays" runat="server" Value="" />
    <asp:HiddenField ID="hf_pk_AllOtherDays" runat="server" Value="" />
    <asp:HiddenField ID="hf_pk_WinterDesignDay" runat="server" Value="" />
    <asp:HiddenField ID="hf_pk_SummerDesignDays" runat="server" Value="" />
    <asp:HiddenField ID="hf_pk_CustomDay1" runat="server" Value="" />
    <asp:HiddenField ID="hf_pk_CustomDay2" runat="server" Value="" />
    <asp:HiddenField ID="hf_pk_WeekEnds" runat="server" Value="" />
    <asp:HiddenField ID="hf_pk_Holiday" runat="server" Value="" />
    <asp:HiddenField ID="hf_IsNewSchedule" runat="server" Value="Yes" />
    <asp:HiddenField ID="hf_IsFirstTime" runat="server" Value="Yes" />
    <asp:HiddenField ID="hf_IsCleanData" runat="server" Value="No" />
    <asp:HiddenField ID="hf_tab_name" runat="server" Value="" />

    <asp:HiddenField ID="week_days" runat="server" Value="" />
    <asp:HiddenField ID="all_days" runat="server" Value="" />
    <asp:HiddenField ID="all_other_days" runat="server" Value="" />
    <asp:HiddenField ID="winter_design_day" runat="server" Value="" />
    <asp:HiddenField ID="summer_design_day" runat="server" Value="" />
    <asp:HiddenField ID="custom_day_1" runat="server" Value="" />
    <asp:HiddenField ID="custom_day_2" runat="server" Value="" />
    <asp:HiddenField ID="week_ends" runat="server" Value="" />
    <asp:HiddenField ID="holiday" runat="server" Value="" />
    <asp:HiddenField ID="hf_is_delete" runat="server" Value="N" />

    </form>
</body>
</html>
