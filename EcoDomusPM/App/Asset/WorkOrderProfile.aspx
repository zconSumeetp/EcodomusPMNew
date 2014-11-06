<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="WorkOrderProfile.aspx.cs" Inherits="App_Asset_WorkOrderProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="../UserControls/UCComboAssignedTo.ascx" TagName="UCComboAssignedTo"
    TagPrefix="uc1" %>
<%@ Register Src="~/App/UserControls/UCLocationProject.ascx" TagName="UCLocation"
    TagPrefix="uc2" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <script type="text/javascript">
        function CancelWindow() {
            window.close();
        }

        function navigate() {
            top.window.location = "../asset/WorkOrder.aspx?popupflag=popup";
        }
        function NavigateToIssue() {
            location.href = "../app/asset/workorder.aspx";
        }

        //This function returns rad window instance to resize it popup
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        function resizePopup(str) {

            window.document.clear();
            var wnd = GetRadWindow();
            if (wnd != null) {
                var bounds = wnd.getWindowBounds();
                var x = bounds.x;
                var y = bounds.y;
                if (str == 'expand')
                    wnd.set_height(document.body.scrollHeight + 60);
                else if (str == 'collaps')
                    wnd.set_height(document.body.scrollHeight + 50);
                else if (str == 'datePopExpand') {
                    if (stateTreeViewTest() != 'true')
                        wnd.set_height(document.body.scrollHeight + 100);
                }
                else if (str == 'datePopCollaps') {
                    if (stateTreeViewTest() != 'true')
                        wnd.set_height(document.body.scrollHeight + 20);
                }
                else if (str == 'datePopExpand2') {
                    if (stateTreeViewTest() != 'true')
                        wnd.set_height(document.body.scrollHeight + 160);
                }
                else if (str == 'datePopCollaps2') {
                    if (stateTreeViewTest() != 'true')
                        wnd.set_height(document.body.scrollHeight - 60);
                }
                else if (str == 'parentWindow')
                    wnd.set_width(document.body.scrollWidth - 100);
            }
        }

        var stateTreeView = 'false';
        function setSateteTreeView(str) {
            stateTreeView = str;
        }
        function stateTreeViewTest() {
            return stateTreeView;
        }
               
        function gotoPage(id, pagename) {

            var popup;
            popup = document.getElementById("ContentPlaceHolder1_hfpopupflag").value;
            var url;
            if (pagename == "Asset") {

                url = "AssetMenu.aspx?assetid=" + id;  //+ "&pagevalue=AssetProfile";

            }
            else if (pagename == "Type") {
                url = "TypeProfileMenu.aspx?type_id=" + id + "";

            }
            else if (pagename == "Issue") {
                url = "InspectionMenu.aspx?pagevalue=InspectionProfile&InspectionId=" + id;

            }

            else if (pagename == "Space") {
                url = "../Locations/FacilityMenu.aspx?pagevalue=Space Profile&id=" + id;

            }
            if (popup == 'popup') {
                top.location.href(url);
            }
            else {
                window.location.href(url);
            }
        }

        function Openfacilitylist() {


            manager = $find("<%=rad_windowmgr.ClientID %>");
            var url;
            var url = "../Asset/issuefacilitylist.aspx?facilitystatus=" + document.getElementById("<%=hdnfacility.ClientID%>").value + "";

            if (manager != null) {
                var windows = manager.open(url);
                windows.show();
                windows.setSize(900, 460);
                windows.MoveTo(100, 150);
                windows.center();             

                //                var windows = manager.get_windows();
                //                var intWidth = document.body.clientWidth;
                //                var intHeight = document.body.clientHeight;
                //                windows[0]._left = parseInt(intWidth * (0.2));
                //                windows[0]._width = parseInt(intWidth * 0.6);
                //                windows[0]._height = parseInt(intHeight * 0.5);
                //                var intHeight = document.body.clientHeight;



                //                windows[0].setUrl(url);
                //                windows[0].show();
                //                windows[0].center();
            }
            return false;
        }

        function load_comp(name, id, type_name) {

            document.getElementById("<%=hf_lbl_comp_id.ClientID %>").value = id;
            var reg = new RegExp('&nbsp;', 'g');
            name = name.replace(reg, ' ');
            type_name = type_name.replace(reg, ' ');
            var reg1 = new RegExp('single', 'g')
            name = name.replace(reg1, "'");
            type_name = type_name.replace(reg1, "'");
            document.getElementById("<%=lbl_Comp_name.ClientID %>").innerText = name;
            document.getElementById("<%=lbl_type_name.ClientID %>").innerText = type_name;
            document.getElementById("<%=hf_comp_name.ClientID %>").value = document.getElementById("<%=lbl_Comp_name.ClientID %>").innerText;
            document.getElementById("<%=hf_type_name.ClientID %>").value = document.getElementById("<%=lbl_type_name.ClientID %>").innerText;
        }

        function delete_() {

            var flag;
            flag = confirm("Are you sure you want to delete?");
            return flag;
        }
        function closewindow() {
            
            window.close();
        }

        function chklbl() {



            if (document.getElementById("<%=lbl_Comp_name.ClientID%>").innerText == "") {
                document.getElementById("lbl_req_asset").innerText = "*";
                return false;

            }

            else {

                return true;
            }


        }


        //        function gotoPage(id, pagename) {
        //            var url;
        //            if (pagename == "Space") {
        //                url = "../Locations/FacilityMenu.aspx?pagevalue=Space Profile&id=" + id;

        //            }

        //            window.location.href(url);
        //        }



        function validate() {
            alert('Please select atleast one space');
            return false;
        }

        function validate1() {
        
            var name = document.getElementById("ContentPlaceHolder1_txtName").value;
            var s = $find("ctl00_ContentPlaceHolder1_UCLocation1_rtvLocationSpaces").get_checkedNodes().length;
            if (s == 0) {
                if (name != "") {
                    alert("Please select atleast one space");
                }
                return false;
            }
            else {
                return true;
            }
        }
        function ProjectValidation() {

            alert('Please select Project');
            window.location = '../Settings/Project.aspx';
            return false;

        }
       
       
        function NiceScrollOnload() {
            if (screen.height > 721) {
                //$("html").css('overflow-y', 'hidden');
                $("html").css('overflow-x', 'auto');
            }
            var screenhtg = set_NiceScrollToPanel();
        }

        $(window).load(function () {
            $('#div_contentPlaceHolder').height("auto");
            $('html').niceScroll();
        });
       
    </script> 
    <telerik:RadWindowManager ID="rad_windowmgr" runat="server" 
    VisibleTitlebar ="false" BorderStyle ="None" 
    VisibleStatusbar="false" AutoSize="false" ShowOnTopWhenMaximized="false">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="None" style="overflow:hidden;" Behavior="Resize" AutoSize="false" 
                KeepInScreenBounds="true" ReloadOnShow="True" BorderStyle="None" BorderWidth="0" Overlay="false" Width="400px" Height="200px"  >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <%--    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>--%>
    <telerik:RadAjaxManagerProxy ID="issueProfilesManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btn_resolve">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblIssueStatus" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="btn_resolve" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy> 
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Height="75px" Skin="Default"
        Width="75px">
       <%-- <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />--%>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
       <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <div class="divMargin" style="padding-left: 0px" id="div1"  runat="server">
     
        <table runat="server" align="left" id="tbltitle" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;display:none;">
        <tr>
            <td class="wizardHeadImage">
                <div class="wizardLeftImage">
                    <asp:Label ID="Label10" Font-Size="Medium"  Text="<%$Resources:Resource, Issue_Profile%>" runat="server"></asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                         OnClientClick="javascript:return CancelWindow();" />
                </div>
            </td>
        </tr>
    </table>

        <table width="100%" style="margin: 10px 0px 0px 0px;" border="0" id="TableWorkOrderProfileContent">
           
            <tr>
                <td style="width: 12%">
                </td>
            </tr>
            <tr>
                <th style="width: 12%">
                    <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Issue_Number%>"
                        Width=" 100%"></asp:Label>
                    <span id="span1" runat="server" style="color: red; width: 200px;"></span>
                </th>
                <td align="left" style="width: 20%">
                    <asp:Label ID="lbl_work_order_number" CssClass="LabelText" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <th style="width: 12%">
                    <asp:Label ID="Label17" runat="server" Text="<%$Resources:Resource,Issue_Name%>"></asp:Label>:
                    <span id="span2" runat="server" style="color: red; width: 100%;"></span>
                </th>
                <td align="left" style="width: 20%;">
                    <asp:TextBox ID="txtName" runat="server" CssClass="textbox" Width="80%"></asp:TextBox>
                    <asp:Label ID="lblname" CssClass="LabelText" runat="server"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                        ControlToValidate="txtName" ValidationGroup="valid" Display="Dynamic" SetFocusOnError="True"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
                <td style="width: 1%">
                </td>
                <th style="width: 5%">
                    <asp:Label ID="Label19" runat="server" Text="<%$Resources:Resource, Description%>"></asp:Label>:
                </th>
                <td align="left">
                    <asp:Label ID="lblDescription" CssClass="LabelText" runat="server"></asp:Label>
                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Height="30px"
                        CssClass="textbox" Width="35%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <th style="width: 12%">
                    <asp:Label ID="Label21" runat="server" Text="<%$Resources:Resource,   Issue_Type%>"></asp:Label>:
                </th>
                <td style="width: 20%">
                    <telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" ID="rcbType"
                        DataTextField="work_order_category_name" DataValueField="pk_work_order_category_id"
                        runat="server" CssClass="DropDown" Width="80%">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblType" CssClass="LabelText" runat="server"></asp:Label>
                </td>
                <td>
                </td>
                <th style="width: 10%">
                    <asp:Label ID="Label23" runat="server" Text="<%$Resources:Resource, Document%>"></asp:Label>:
                </th>
                <td>
                    <asp:HyperLink ID="lnkDocument" runat="server" CssClass="linkText" Target="_blank"></asp:HyperLink>
                    <div style="float: left; padding-top: 5px">
                        <telerik:RadUpload ID="ruDocument" runat="server" ControlObjectsVisibility="None"
                            Width="230px">
                        </telerik:RadUpload>
                    </div>
                    <div style="padding-top: 5px">
                        <%--   <asp:Button ID="btnUpload" runat="server" CausesValidation="false" Text="Upload"
                            Width="65px" TabIndex="9" />--%>
                        <asp:Label ID="lblselectdocument" runat="server" CssClass="Message" ForeColor="Red"></asp:Label>
                    </div>
                    <asp:HiddenField ID="hfAttachedFile" runat="server" />
                    <asp:HiddenField ID="hfDocumentName" runat="server" />
                    <asp:HiddenField ID="hfdocument_id" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <th style="width: 12%">
                    <asp:Label ID="Label25" runat="server" Text="<%$Resources:Resource, Component%>"></asp:Label>:
                </th>
                <td>
                    <asp:Label ID="lbl_Comp_name" CssClass="linkText" Text="" runat="server"></asp:Label>
                    &nbsp; &nbsp;
                    <asp:LinkButton ID="btn_add_Comp" Text="Add" OnClientClick="javascript:return Openfacilitylist();"
                        runat="server"></asp:LinkButton>
                    <asp:Label ID="lbl_req_asset" ClientIDMode="static" runat="server" Text="" ForeColor="Red"
                        CssClass="LabelText"></asp:Label>
                </td>
                <td>
                </td>
                <th style="width: 100px">
                    <asp:Label ID="Label27" runat="server" Text="<%$Resources:Resource, Type%>"></asp:Label>:
                </th>
                <td>
                    <asp:Label ID="lbl_type_name" Text="" CssClass="linkText" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <th style="width: 12%">
                    <asp:Label ID="Label29" runat="server" Text="<%$Resources:Resource, Start_Date%>"></asp:Label>:
                </th>
                <td align="left" style="width: 20%">
                    <asp:Label ID="lblstartdate" CssClass="linkText" Text="" runat="server"></asp:Label>
                    <telerik:RadDatePicker TabIndex="7" AutoPostBack="false" ID="rdpstartdate" runat="server"
                        Width="80%" MaxDate="2099-01-01" MinDate="1900-01-01">
                        <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                            ViewSelectorText="x">
                        </Calendar>
                        <DateInput ID="DateInput1" runat="server" TabIndex="7" DisplayDateFormat="M/d/yy"
                            DateFormat="M/d/yy">
                        </DateInput>
                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="7"></DatePopupButton>
                    </telerik:RadDatePicker>
                </td>
                <td>
                </td>
                <th style="width: 100px">
                    <asp:Label ID="Label30" runat="server" Text="<%$Resources:Resource, End_Date%>"></asp:Label>:
                </th>
                <td>
                    <asp:Label ID="lblenddate" Text="" CssClass="linkText" runat="server"></asp:Label>
                    <telerik:RadDatePicker TabIndex="7" AutoPostBack="false" ID="rdpenddate" runat="server"
                        Width="50%" MaxDate="2099-01-01" MinDate="1900-01-01">
                        <Calendar ID="Calendar2" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                            ViewSelectorText="x">
                        </Calendar>
                        <DateInput ID="DateInput2" runat="server" TabIndex="7" DisplayDateFormat="M/d/yy"
                            DateFormat="M/d/yy">
                        </DateInput>
                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="7"></DatePopupButton>
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <th style="width: 10%">
                </th>
                <td style="width: 20%">
                    <asp:CompareValidator ID="dateCompareValidator" runat="server" ControlToValidate="rdpenddate"
                        ValidationGroup="valid" ControlToCompare="rdpstartdate" Operator="GreaterThanEqual"
                        Type="Date" ErrorMessage="The start date must be smaller than end date" ForeColor="Red"> </asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <th style="width: 10%">
                    <asp:Label ID="Label31" runat="server" Text="<%$Resources:Resource, Status%>"></asp:Label>:
                    <span id="span3" runat="server" style="color: red"></span>
                </th>
                <td valign="middle" style="width: 20%">
                    <asp:Label runat="server" CssClass="LabelText" ID="lblIssueStatus"></asp:Label>
                    <telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" Height="100px"
                        DataTextField="work_orderstatus" DataValueField="work_orderstatus" ID="rcb_Status"
                        runat="server" Width="80%">
                        <%--<Items>
                            <telerik:RadComboBoxItem runat="server" Text="Open" Value="1" />
                           <telerik:RadComboBoxItem runat="server" Text="Resolved" Value="2" />
                       </Items>--%>
                    </telerik:RadComboBox>
                    <asp:RequiredFieldValidator ID="rf_status" ControlToValidate="rcb_Status" runat="server"
                        InitialValue="---Select---" ForeColor="Red" Font-Size="Medium" ErrorMessage="*"
                        SetFocusOnError="true" ValidationGroup="valid"> </asp:RequiredFieldValidator>
                </td>
                <td>
                </td>
                <th style="width: 100px">
                    <asp:Label ID="Label33" runat="server" Text="<%$Resources:Resource, Chance%>"></asp:Label>:
                </th>
                <td>
                    <asp:Label ID="lblChance" CssClass="LabelText" runat="server"></asp:Label>
                    <telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" Height="100px"
                        DataTextField="work_order_chance_name" DataValueField="pk_work_order_chance_id"
                        ID="rcbChance" runat="server" Width="220px">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <th style="width: 10%">
                    <asp:Label ID="Label35" runat="server" Text="<%$Resources:Resource, Impact%>"></asp:Label>:
                </th>
                <td style="width: 20%">
                    <asp:Label ID="lblImpact" CssClass="LabelText" runat="server"></asp:Label>
                    <telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" Height="100px"
                        DataTextField="work_order_impact_name" DataValueField="pk_work_order_impact_id"
                        ID="rcbImpact" runat="server" Width="80%">
                    </telerik:RadComboBox>
                </td>
                <td>
                </td>
                <th style="width: 100px">
                    <asp:Label ID="Label40" runat="server" Text="<%$Resources:Resource, Priority%>"></asp:Label>:
                </th>
                <td align="left">
                    <asp:Label ID="lblpriority" CssClass="LabelText" runat="server"></asp:Label>
                    <telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" Height="100px"
                        ID="ddlpriority" runat="server" Width="220px">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="width: 10%">
                </td>
            </tr>
            <tr>
                <th style="width: 10%">
                    <asp:Label ID="Label39" runat="server" Text="<%$Resources:Resource, Requested_By%>"></asp:Label>:
                </th>
                <td align="left" style="width: 20%">
                    <asp:TextBox ID="txt_request" runat="server" CssClass="textbox" Width="80%"></asp:TextBox>
                    <asp:Label ID="lblrequestby" CssClass="LabelText" runat="server"></asp:Label>
                    <%--<telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" Height="100px"
                        DataTextField="name" DataValueField="pk_inspection_id" ID="ddlRequestedBy"
                        runat="server" Width="220px">
                    </telerik:RadComboBox>--%>
                </td>
                <td>
                </td>
                <th style="width: 100px">
                    <asp:Label ID="Label37" runat="server" Text="<%$Resources:Resource, Risk%>"></asp:Label>:
                </th>
                <td>
                    <asp:Label ID="lblRisk" CssClass="LabelText" runat="server"></asp:Label>
                    <telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" Height="100px"
                        DataTextField="work_order_risk_name" DataValueField="pk_work_order_risk_id" ID="rcbRisk"
                        runat="server" Width="220px" CssClass="DropDown">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <%-- <th style="width: 100px">
                    <asp:Label ID="Label41" runat="server" Text="<%$Resources:Resource, Inspections%>"></asp:Label>:
                </th>
                <td align="left" >
                    <asp:Label ID="lblinspection" CssClass="LabelText" runat="server"></asp:Label>
                   <telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" Height="100px"
                        DataTextField="name" DataValueField="pk_inspection_id" ID="rcbinspection"
                        runat="server" Width="220px">
                    </telerik:RadComboBox>
                </td>


                 <td >
                </td>--%>
                <th style="width: 10%" valign="top">
                    <asp:Label ID="Label42" runat="server" Text="<%$Resources:Resource, Mitigation%>"></asp:Label>:
                </th>
                <td align="left" valign="top" style="width: 20%">
                    <asp:Label ID="lblMitigation" CssClass="LabelText" runat="server"></asp:Label>
                    <asp:TextBox ID="txtMitigation" runat="server" CssClass="textbox" Width="80%"></asp:TextBox>
                </td>
                <td>
                </td>
            </tr>
            <%--   <tr>
            <td></td>
            </tr>--%>
            <tr>
                <th style="width: 10%" valign="top">
                    <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource, Assigned_To%>"></asp:Label>:
                </th>
                <td valign="top" style="width: 27%">
                    <span id="Span12" style="font-weight: bold"></span>
                     <telerik:RadPanelBar runat="server" ID="RadPanelBar3" Width="100%" BorderWidth="0"
                        ExpandMode="MultipleExpandedItems" BorderColor="Transparent" Visible="true">
                        <ExpandAnimation Type="OutSine" />
                        <Items>
                            <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                                BorderWidth="0" BorderColor="Transparent">
                                <HeaderTemplate>
                                    <asp:Panel ID="pnl_job3" runat="server" BorderWidth="0" Width="100%"
                                        BorderColor="Transparent">
                                        <table id="tbl_jobs3" cellpadding="0" cellspacing="0" class="gridRadPnlHeader" runat="server"
                                            width="100%">
                                            <tr>                                                
                                                <td align="right" class="dropDownImage">
                                                    <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                        ID="img_arrow3" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tbl_jobs4" runat="server" cellpadding="0" cellspacing="0" width="100%"
                                            style="background-color: #707070; border-width: 0px;">
                                            <tr>
                                                <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </HeaderTemplate>
                                <ContentTemplate>
                    <telerik:RadGrid ID="rgAssignTo" runat="server" AllowPaging="true" Width="100%" BorderWidth="1px"
                        OnPageIndexChanged="rgAssignTo_PageIndexChanged" OnPageSizeChanged="rgAssignTo_PageSizeChanged"
                        OnSortCommand="rgAssignTo_SortCommand" CellPadding="0" AutoGenerateColumns="False"
                        PageSize="5" Skin="Default">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="left" Width="100%" AlwaysVisible="true" />
                        <MasterTableView>
                            <Columns>
                                <telerik:GridBoundColumn DataField="UserOrganizationname" HeaderText="<%$Resources:Resource,Name%>"
                                    SortExpression="UserOrganizationname">
                                    <ItemStyle CssClass="column" Width="100%" Wrap="false" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    </ContentTemplate>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:RadPanelBar>
                    <uc1:UCComboAssignedTo ID="UCComboAssignedTo1" runat="server" />
                </td>
                <td>
                </td>
                <th style="width: 100px" valign="top">
                    <asp:Label ID="Label11" runat="server" Text="<%$Resources:Resource, Location%>"></asp:Label>:
                    <span id="span9" runat="server" style="color: red"></span>
                </th>
                <td valign="top">
                 <telerik:RadPanelBar runat="server" ID="RadPanelBar2" Width="60%" BorderWidth="0" Visible="true"
                        ExpandMode="MultipleExpandedItems" BorderColor="Transparent">
                        <ExpandAnimation Type="OutSine" />
                        <Items>
                            <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                                BorderWidth="0" BorderColor="Transparent">
                                <HeaderTemplate>
                                    <asp:Panel ID="pnl_job1" runat="server" BorderWidth="0" Width="100%"
                                        BorderColor="Transparent">
                                        <table id="Table1" cellpadding="0" cellspacing="0" class="gridRadPnlHeader" runat="server"
                                            width="100%">
                                            <tr>                                                
                                                <td align="right" class="dropDownImage">
                                                    <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                        ID="img_arrow1" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="Table2" runat="server" cellpadding="0" cellspacing="0" width="100%"
                                            style="background-color: #707070; border-width: 0px;">
                                            <tr>
                                                <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </HeaderTemplate>
                                <ContentTemplate>
                    <telerik:RadGrid ID="rgLocation" runat="server" AllowPaging="true" Width="100%" BorderWidth="1px"
                        OnPageIndexChanged="rgLocation_PageIndexChanged" OnPageSizeChanged="rgLocation_PageSizeChanged"
                        OnSortCommand="rgLocation_SortCommand" CellPadding="0" AutoGenerateColumns="False"
                        PageSize="5" Skin="Default">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="50%" AlwaysVisible="true" />
                        <MasterTableView DataKeyNames="pk_location_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_location_id" HeaderText="location_id" Visible="false">
                                    <ItemStyle CssClass="column" Width="100px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Name%>"
                                    SortExpression="name">
                                    <ItemStyle CssClass="column" Width="300px" Wrap="false" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>"
                                    SortExpression="description">
                                    <ItemStyle CssClass="column" Width="300px" Wrap="false" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    </ContentTemplate>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:RadPanelBar>
                    <uc2:UCLocation ID="UCLocation1" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="height: 5px; width: 10%;">
                </td>
            </tr>
            <tr>
                <th style="width: 10%" valign="top" runat="server" id="td_work_order_log">
                    <asp:Label ID="lbl_WorkOrderLog" runat="server" Text="<%$Resources:Resource, Issue_Log%>"></asp:Label>:
                    <span id="span5" runat="server" style="color: red"></span>
                </th>
                <td valign="top" colspan="4">
                 <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="78%" BorderWidth="0" Visible="true" ExpandMode="MultipleExpandedItems" BorderColor="Transparent" >
                        <ExpandAnimation Type="OutSine" />
                        <Items>
                            <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                                BorderWidth="0" BorderColor="Transparent">
                                <HeaderTemplate>
                                    <asp:Panel ID="pnl_job" runat="server" BorderWidth="0" Width="100%"
                                        BorderColor="Transparent">
                                        <table id="tbl_jobs" cellpadding="0" cellspacing="0" class="gridRadPnlHeader" runat="server"
                                            width="100%">
                                            <tr>                                                
                                                <td align="right" class="dropDownImage">
                                                    <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                        ID="img_arrow" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tbl_jobs1" runat="server" cellpadding="0" cellspacing="0" width="100%"
                                            style="background-color: #707070; border-width: 0px;">
                                            <tr>
                                                <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </HeaderTemplate>
                                <ContentTemplate>
                    <telerik:RadGrid ID="rg_work_order_log" runat="server" AllowPaging="true" Width="100%"
                        BorderWidth="1px" AllowSorting="true" OnPageIndexChanged="rg_work_order_log_OnPageIndexChanged"
                        OnPageSizeChanged="rg_work_order_log_OnPageSizeChanged" OnSortCommand="rg_work_order_log_OnSortCommand"
                        CellPadding="0" AutoGenerateColumns="False" PageSize="5" Skin="Default">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" AlwaysVisible="true" />
                        <MasterTableView DataKeyNames="pk_work_order_log_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_work_order_log_id" HeaderText="log_id" Visible="false">
                                    <ItemStyle CssClass="column" Width="1%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Updated_On" HeaderText="<%$Resources:Resource, Updated_On%>"
                                    SortExpression="Updated_On">
                                    <ItemStyle CssClass="column" Width="8%" Wrap="true" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="updated_by" HeaderText="<%$Resources:Resource, Updated_By%>"
                                    SortExpression="updated_by">
                                    <ItemStyle CssClass="column" Width="10%" Wrap="true" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource, Description%>"
                                    SortExpression="description">
                                    <ItemStyle CssClass="column" Width="20%" Wrap="true" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    </ContentTemplate>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:RadPanelBar>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="3">
                    <asp:Label ID="lblMessage" align="Center" runat="server" Style="color: Red; font-size: 16;"
                        size="50px" CssClass="Message"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 10%">
                </td>
            </tr>
            <tr>
                <td style="width: 10%">
                </td>
            </tr>
            <tr>
                <th style="width: 10%">
                    <asp:Label ID="lblMsg" CssClass="linkText" runat="server" ForeColor="red"></asp:Label>
                    <asp:HiddenField ID="hfcobie2_issues_id" runat="server" />
                    <asp:HiddenField ID="hfFileID" runat="server" />
                    <asp:HiddenField ID="hfUploadedFileId" runat="server" />
                    <asp:HiddenField ID="hf_lbl_comp_id" runat="server" />
                    <asp:HiddenField ID="hdnfacility" runat="server" />
                    <asp:HiddenField ID="hfFilePath" runat="server" />
                    <asp:HiddenField ID="hfFilename" runat="server" />
                    <asp:HiddenField ID="hfworkorderid" runat="server" />
                    <asp:HiddenField ID="hffacilityid" runat="server" />
                    <asp:HiddenField ID="hf_comp_name" runat="server" />
                    <asp:HiddenField ID="hf_type_name" runat="server" />
                </th>
            </tr>
        </table>
        <table align="left">
            <tr>
                <td>
                   <a onclick="javascript:return validate1();"> <asp:Button ID="btnSave" runat="server" Text="<%$Resources:Resource, Save%>" Width="100px"
                        ValidationGroup="valid" OnClick="btnSave_click" /></a>
                </td>
                <td>
                    <asp:Button ID="btn_resolve" Visible="true" runat="server" Text="<%$Resources:Resource,Resolved%>"
                        Width="100px" OnClick="btnresolve_click" />
                </td>
                <td>
                    <asp:Button ID="btn_delete" OnClick="btndelete_click" runat="server" Text="<%$Resources:Resource, Delete%>"
                        Width="100px" OnClientClick="javascript:return delete_();" />
                </td>
                <td>
                    <asp:Button ID="btnCancel" OnClick="cancel_click" runat="server" Text="<%$Resources:Resource, Cancel%>"
                        Width="100px" CausesValidation="false" />
                </td>
                <td>
                    <asp:Button ID="btnclose" runat="server" Width="100" Text="<%$Resources:Resource, Close%>"
                        OnClientClick="Javascript:closewindow();" />
                </td>
            </tr>
            <tr>
                <td>
                    <div style="height: 20px"></div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hfpopupflag" runat="server" />
    </div>
    </div>
</asp:Content>
