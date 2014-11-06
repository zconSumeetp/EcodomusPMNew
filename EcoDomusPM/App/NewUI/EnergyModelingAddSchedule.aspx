<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeFile="EnergyModelingAddSchedule.aspx.cs" Inherits="App_NewUI_EnergyModelingAddSchedule" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title></title>
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CloseWindow() {
            var url = GetRadWindow().BrowserWindow.location.href; ;
            //GetRadWindow().BrowserWindow.referesh_facility_page();
            GetRadWindow().close();
            return false;
        }

        function adjust_height() {
            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                //alert(x);
                //alert(y);
                wnd.moveTo(x, 25);
                //alert('window page' + document.body.scrollHeight);
                wnd.set_height(document.body.scrollHeight + 20)
                // alert('window page' + document.body.offsetWidth);
                //wnd.set_width(document.body.scrollWidth+200)
            }
        }
        //window.onload = adjust_height;
    </script>
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
            function validateScheduleData(button, args) {

                result = true;

                var txtTueTime = document.getElementById("<%=txtScheduleName.ClientID %>");
                var valTueTime = txtTueTime.value;


                if (txtTueTime.value == "") {
                document.getElementById("<%=lblScheduleName.ClientID %>").innerHTML = '*';
                result = false;
                }

                if ($find('<%=rcbTypeName.ClientID %>').get_selectedItem().get_text() == " --Select-- ") {
                    document.getElementById("<%=lblTypeName.ClientID %>").innerHTML = '*';
                    result = false;
                    
                }

                if ($find('<%=rcbFor.ClientID %>').get_selectedItem().get_text() == " --Select-- ") {
                    document.getElementById("<%=lblFor.ClientID %>").innerHTML = '*';
                    result = false;
                    //Page_ClientValidate();
                    //return false
                }
                if (result) {
                    button.set_autoPostBack(true);
                }
                else {
                    button.set_autoPostBack(false);
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
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/Skins/MyCustomTabStrip/TabStrip.MyCustomTabStrip.css" />
</head>
<body style="overflow:hidden;">
    <form id="frm_wizard" runat="server">
     <asp:ScriptManager ID="ScriptManagerId" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" 
         DecoratedControls="CheckBoxes, Buttons, Textbox" />
    <table width="100%" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
        <tr>
            <td class="wizardHeadImage">
                <div class="wizardLeftImage">
                    <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />
                    <asp:Label ID="lbl_header" Text="Add Schedule" runat="server"></asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ibtn_close" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                        OnClick="ibtn_close_Click" />
                </div>
            </td>
        </tr>
        
        <tr>
            <td style="padding:10px">
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td align="center">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource, Name%>" CssClass="normalLabel"></asp:Label>:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtScheduleName" runat="server" CssClass="SmallTextBox" Width="210px"
                                            CausesValidation="true"></asp:TextBox>
                                        <asp:Label ID="lblScheduleName" runat="server" Text="" ForeColor="Red"></asp:Label>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource, Type_Name%>" CssClass="normalLabel"></asp:Label>:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="rcbTypeName" runat="server" Height="100px" Width="200px"
                                            CausesValidation="true">
                                        </telerik:RadComboBox>
                                        <asp:Label ID="lblTypeName" runat="server" Text="" ForeColor="Red"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="height: 15px">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label4" runat="server" Text="For" CssClass="normalLabel"></asp:Label>:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="rcbFor" runat="server" Width="200px" AllowCustomText="false"
                                            Filter="Contains">
                                        </telerik:RadComboBox>
                                        <asp:Label ID="lblFor" runat="server" Text="" ForeColor="Red"></asp:Label>
                                    </td>
                                    <td>
                                    </td>
                                    <td align="center">
                                        <%--<asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="<%$Resources:Resource, Add%>"
                                            Width="50px" OnClientClick="javascript:return validateScheduleData();" />--%>
                                            <telerik:RadButton ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="<%$Resources:Resource, Add%>" OnClientClicked="validateScheduleData" AutoPostBack="false"></telerik:RadButton>
                                    </td>
                                    <td align="left">
                                        <%--<asp:Button ID="btnDelete" Width="50px" runat="server" Text="<%$Resources:Resource, Delete%>"
                                            OnClick="btnDelete_Click" />--%>
                                            <telerik:RadButton ID="btnDelete" runat="server" Text="<%$Resources:Resource, Delete%>" OnClick="btnDelete_Click"></telerik:RadButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        <asp:Label ID="lblErrMsg" runat="server" Text="" ForeColor="Red" CssClass="LabelText"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center">
                <table border="0" cellpadding="0" cellspacing="0" width="98%">
                    <tr>
                        <td>
                            <telerik:RadTabStrip ID="rdstripSchedules" SelectedIndex="0" runat="server" MultiPageID="rmpageSchedules"
                                OnTabClick="rdstripSchedules_TabClick" ScrollChildren="true" ScrollButtonsPosition="Middle"
                                EnableEmbeddedSkins="False" Skin="MyCustomTabStrip">
                            </telerik:RadTabStrip>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 400" valign="top">
                            <telerik:RadMultiPage ID="rmpageSchedules" runat="server" CssClass="multiPage" SelectedIndex="0"
                                OnPageViewCreated="RadMultiPage1_PageViewCreated" RenderSelectedPageOnly="true">
                            </telerik:RadMultiPage>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
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
    <asp:HiddenField ID="hf_pk_schedule_id" runat="server" Value="" />


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
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px" Skin="Forest">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
