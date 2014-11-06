<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TypeJobs.aspx.cs" Inherits="App_Asset_TypeJobs" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<html>
<head>
    <%--  <link href="../../App_Themes/EcoDomus/style.css" rel="stylesheet" type="text/css" />--%>
     <title></title>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" language="javascript">

            function fn_Clear() {
                try {
                    document.getElementById("txt_search").value = "";
                    return false;
                }
                catch (e) { 
                    alert(e.message + "  " + e.Number);
                    return false;
                }
            }


            function CancelAddAttribute() {
                document.getElementById('tr_AddJob').style.display = "none";
                document.getElementById('trbtnAddJob').style.display = "block";
                var obj = parent.window.frames[1];
                if (obj != null) {

                    window.parent.resize_iframe(parent.window.frames[1]);

                }
                return false;
            }

            function ShowDetailWindow(job_id, category_id, index) {

                manager = $find("<%=rd_manager.ClientID%>");
                var radGrid = $find("<%=rg_TypeJobs.ClientID %>");
                var type_id = document.getElementById("<%=hf_type_id.ClientID %>").value;
                var resolution = document.getElementById("<%=hfScreenResolution.ClientID %>").value;
                url = "AddTypeJobsSubtask.aspx?pk_job_id=" + job_id + "&category_id=" + category_id + "&type_id=" + type_id + "&resolution=" + resolution + "";
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
                    }
                }
                return false;
            }

            function AddAttributeShopop() {
               
                var manager = $find("<%=rad_window.ClientID%>");
                if (manager != null) {
                    var window = manager.get_windows();
                    if (window[0] != null) {
                        window[0]._height = 340;
                       
                        // window[0].setUrl(url);
                       // var bounds = window[0].getWindowBounds();
                        //var x = bounds.x;
                        //var y = bounds.y;
                        // window[0].moveTo(x, 217);
                        var cmb_uom = $find("<%= cmb_Category.ClientID %>");
                        if (cmb_uom != null)
                            cmb_uom.clearSelection();
                        window[0]._widht = 750;
                        window[0].show();
                        window[0].set_modal(false);
                        document.body.style.overflow = 'hidden';
                    }
                }
                return false;
            }

            function AddAttribute() {
               document.getElementById('tr_AddJob').style.display = "block";

                var cmb_uom = $find("<%= cmb_Category.ClientID %>");
                if (cmb_uom != null)
                    cmb_uom.clearSelection();
                document.getElementById('txtName').value = "";
                document.getElementById('trbtnAddJob').style.display = "none";
                var obj = parent.window.frames[1];
                if (obj != null) {

                    window.parent.resize_iframe(parent.window.frames[1]);

                }
               
                return false
            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }
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



            function RowSelected(sender, args) {
                var label = document.getElementById("<%= rg_TypeJobs.ClientID %>");
                var job_id = args.getDataKeyValue("pk_job_id");
                var category_id = args.getDataKeyValue("pk_job_category");
            }

            function deleteJob() {
                var flag;
                flag = confirm("Do you want to delete this Job?");
                return flag;
            }

            function deleteTask() {
                var flag;
                flag = confirm("Do you want to delete this Task?");
                return flag;
            }

            function Clear(sender, eventargs) {
                document.getElementById("txtSearch").value = "";
                return false;
            }

            function NumberOnly(sender, eventArgs) {
                var charCode = eventArgs.get_keyCode();
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    eventArgs.set_cancel(true);
            }
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }
            function openpopupSelectResources() {

                manager = $find("<%=rd_mahager_job.ClientID%>");
                var type_id = document.getElementById("<%=hf_type_id.ClientID %>").value;
                var hf_resource_ids = document.getElementById("<%=hf_resource_ids.ClientID %>").value;
                var resolution = document.getElementById("<%=hfScreenResolution.ClientID %>").value;
                url = "ResourePopup.aspx?pk_type_id=" + type_id + "&hf_resource_ids=" + hf_resource_ids + "&edit=edit";

                if (manager != null) {
                    var window = manager.get_windows();
                    if (window[0] != null) {
                        window[0]._height = 540;
                        window[0].setUrl(url);
                        var bounds = window[0].getWindowBounds();
                        var x = bounds.x;
                        var y = bounds.y;
                        // window[0].moveTo(x, 217);
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

                    wnd.set_height(document.body.scrollHeight + 10)

                }
            }
            function refreshgrid_new() {
                // document.getElementById("btnAssign").click();

            }
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog      
                else if (window.frameElement != null) {
                    if (window.frameElement.radWindow)
                        oWindow = window.frameElement.radWindow; //IE (and Moz as well)      
                }
                return oWindow;
            }

            function ShowFullEntityName(lblResourceEdit) {

                var lblResourceEdit = lblResourceEdit.id;
                var hfId = lblResourceEdit.replace("lblResourceEdit", "hf_resources");
                var tooltip = $find("<%=RadToolTip1.ClientID %>");

                tooltip.set_targetControlID(lblResourceEdit);
                tooltip.set_text(document.getElementById(hfId).value);
                window.setTimeout(function () {
                    tooltip.show();
                }, 100);
            }

            function HideTooltip() {
                var tooltip = Telerik.Web.UI.RadToolTip.getCurrent();
                if (tooltip) tooltip.hide();
            }
            function validate() {
                alert("Job name already exists");
                AddAttribute()
                return false;
            }
            function validate1() {
                alert("Job name already exists");

                return false;
            }

        </script>

        <script type="text/javascript" language="javascript">
            window.onload = body_load;
            function body_load() {
                    document.getElementById("<%=txtSearch.ClientID %>").focus();
             }



            function RightMenu_expand_collapse(index) {

                var img = document.getElementById("RightMenu_" + index + "_img_expand_collapse");
                $('.RightMenu_' + index + '_Content').toggle();
                if (img.src.indexOf("asset_carrot_up") != -1) {
                    img.src = img.src.replace("asset_carrot_up", "asset_carrot_down");
                }
                else {
                    img.src = img.src.replace("asset_carrot_down", "asset_carrot_up");
                }
                $(".divScroll").getNiceScroll().resize();
            }   

    </script>
    </telerik:RadCodeBlock>
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
     <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
        <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
</head>
<body style="background:#F7F7F7; padding: 0px">
    <form id="form1" runat="server" defaultfocus="txt_search">

    <telerik:RadScriptManager ID="ScriptManager1" runat="server" >
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>

    <telerik:RadToolTip runat="server" ID="RadToolTip1" HideEvent="ManualClose" ShowEvent="FromCode"
        RelativeTo="Element" Sticky="true" Skin="WebBlue" Width="420px">
    </telerik:RadToolTip>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_TypeJobs">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_TypeJobs"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    
    <telerik:RadFormDecorator ID="RadFormDecorator" runat="server" DecoratedControls="Buttons, Scrollbars" />
  <%--  <fieldset id="fldsearch" style=" padding-left: 0; width:100%; border: 0;" runat="server">   --%>    
        <asp:Panel ID="pnl_job" runat="server" DefaultButton="btn_searchimg" BorderWidth="0"
            BorderColor="Transparent">            
            <table id="tbl_jobs" cellpadding="0" cellspacing="0" style="width:100%;" runat="server">
                <tr id="trbtnAddJob" >
                <td  style="padding-top: 02;">
                    <asp:Button ID="btnAddJob" runat="server" Text="<%$Resources:Resource, Add_Job%>" CausesValidation="false"
                        Width="100px" OnClientClick="javascript:return AddAttributeShopop();" />
                </td>
                <td>
                    <asp:HiddenField ID="hf_Attribute_id" runat="server" />
                </td>
            </tr>
                <tr>
                   <td  class="centerAlign">
                    <div class="rpbItemHeader" >
                        <table cellpadding="0" cellspacing="0" >
                            <tr>
                                <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width: 100%;">
                                    <asp:Label runat="server" ID="lbl_grid_head" CssClass="gridHeadText" Width="200px" Text="<%$Resources:Resource,Jobs%>"
                                        ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                    onclick="stopPropagation(event)">
                                    <div id="div_search" style="width:200px; background-color: white;" onclick="stopPropagation(event)">
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                        Height="100%" EmptyMessage="<%$Resources:Resource, Search%>" BorderColor="White" ID="txtSearch" Width="180px">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ClientIDMode="Static" ID="btn_searchimg" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                        OnClick="btn_searchimg_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td align="right" style="padding: 4px 10px 0 0;">
                                   <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                        ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContent" >
                    <telerik:RadGrid ID="rg_TypeJobs" runat="server" AllowPaging="true" PageSize="10" BorderWidth="1px"
                        CellPadding="0" AutoGenerateColumns="false" AllowSorting="true" Width="100%"
                        GridLines="None" CellSpacing="0" PagerStyle-AlwaysVisible="true" OnDetailTableDataBind="rg_TypeJobs_OnDetailTableDataBind"
                        OnItemCommand="rg_TypeJobs_OnItemCommand" OnItemDataBound="rg_TypeJobs_OnItemDataBound"
                        OnItemCreated="rg_TypeJobs_ItemCreated" OnNeedDataSource="rg_TypeJobs_NeedDataSource"
                        OnSortCommand="rg_TypeJobs_OnSortCommand" OnPreRender="rg_TypeJobs_OnPreRender">
                        <ClientSettings AllowColumnsReorder="true" ReorderColumnsOnClient="true">                            
                            <Selecting AllowRowSelect="true" />
                            <Resizing ResizeGridOnColumnResize="True" AllowResizeToFit="true"></Resizing>
                        </ClientSettings>
                        <MasterTableView DataKeyNames="pk_job_id,pk_job_category" Name="rgJob" ClientDataKeyNames="pk_job_id,pk_job_category"
                            EditMode="EditForms" GroupLoadMode="Client" CellPadding="0" CellSpacing="0" GridLines="None"
                            HeaderStyle-CssClass="gridHeaderBoldText">
                             <ItemStyle CssClass="Row50" />
                             <AlternatingItemStyle CssClass="Row50" />
                            <PagerStyle BorderWidth="1" BorderColor="Gray" Mode="NextPrevAndNumeric" AlwaysVisible="false" />
                            <DetailTables>
                                <telerik:GridTableView runat="server" AllowCustomPaging="false" AllowPaging="true" 
                                    GridLines="None" PagerStyle-AlwaysVisible="true" PagerStyle-Mode="NextPrevAndNumeric"
                                    TableLayout="Auto" PageSize="5" AutoGenerateColumns="false" AllowSorting="true"
                                    DataKeyNames="pk_job_task_id,pk_job_status_id,pk_duration_unit_id,Start_unit_id,Frequency_unit_id,start,ResourceNames"
                                    BorderColor="White" Name="rg_JobTasks" ClientDataKeyNames="pk_job_task_id,pk_job_status_id,pk_duration_unit_id,Start_unit_id,Frequency_unit_id,start,ResourceNames"
                                    CssClass="rgcss" CellPadding="0" CellSpacing="0" BorderWidth="0">
                                    <CommandItemSettings />
                                    
                                      <HeaderStyle Height="50" />
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" />
                                    <ExpandCollapseColumn Resizable="false" FilterControlAltText="Filter ExpandColumn column" />
                                    <Columns>
                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                            HeaderStyle-Width="3%">
                                            <ItemStyle />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridBoundColumn DataField="des" HeaderText="Description" UniqueName="Description"
                                            EditFormColumnIndex="0" Resizable="false">
                                            <HeaderStyle HorizontalAlign="Left" Width="50%" Wrap="false" VerticalAlign="Bottom"
                                                Font-Size="14px" />
                                            <ItemStyle HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn HeaderText="Task Number" SortExpression="task_number"
                                            DataField="task_number" EditFormColumnIndex="1" UniqueName="task_number">
                                            <ItemTemplate>
                                                <asp:Label ID="lbltask_numberEdit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"task_number")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox ID="txttask_numberEdit" runat="server" Width="155" Height="20">
                                                    <ClientEvents OnKeyPress="NumberOnly" />
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" VerticalAlign="Bottom" Font-Size="14px" />
                                            <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Priors" SortExpression="priors" DataField="priors"
                                            EditFormColumnIndex="0" UniqueName="priors">
                                            <ItemTemplate>
                                                <asp:Label ID="lblpriorsEdit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"priors")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox ID="txtpriorsEdit" runat="server" Width="160" Height="20">
                                                    <ClientEvents OnKeyPress="NumberOnly" />
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" VerticalAlign="Bottom" Font-Size="14px" />
                                            <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Status" SortExpression="Status" DataField="Status"
                                            HeaderStyle-Width="11%" EditFormColumnIndex="1" UniqueName="Status">
                                            <ItemTemplate>
                                                <asp:Label ID="lblstatusEdit" runat="server" ToolTip='<%# DataBinder.Eval(Container.DataItem,"status")%>'
                                                    Text='<%# DataBinder.Eval(Container.DataItem,"status")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="cmb_statusEdit" runat="server" Width="160" MarkFirstMatch="true"
                                                    EmptyMessage="--Select--">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" VerticalAlign="Bottom" Font-Size="14px" />
                                            <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Duration" SortExpression="Duration" DataField="Duration"
                                            EditFormColumnIndex="0" UniqueName="Duration">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDurationEdit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Duration")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox ID="txtDurationEdit" runat="server" Width="160" Height="20">
                                                    <ClientEvents OnKeyPress="NumberOnly" />
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" VerticalAlign="Bottom" Font-Size="14px" />
                                            <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn SortExpression="Duration_unit" HeaderText="Duration Unit"
                                            DataField="Duration_unit" EditFormColumnIndex="1" UniqueName="Duration_unit">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDuration_unitEdit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Duration_unit")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="cmb_durationUnitEidt" MarkFirstMatch="true" runat="server"
                                                    Width="160" EmptyMessage="--Select--">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" VerticalAlign="Bottom" Font-Size="14px" />
                                            <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn SortExpression="Start" HeaderText="Start" DataField="Start"
                                            EditFormColumnIndex="0" UniqueName="Start">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStartEdit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Start")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadDatePicker runat="server" ID="radDateStartDate" Width="160" Height="20">
                                                    <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" runat="server" UseColumnHeadersAsSelectors="False"
                                                        ViewSelectorText="x">
                                                    </Calendar>
                                                    <DateInput ID="DateInput1" DisplayDateFormat="MM-dd-yyyy" runat="server" DateFormat="dd-MM-yyyy"
                                                        Height="15px">
                                                    </DateInput>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                </telerik:RadDatePicker>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorStart" ControlToValidate="radDateStartDate"
                                                    ErrorMessage="*" runat="server" Display="Dynamic" ForeColor="Red">
                                                </asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" VerticalAlign="Bottom" Font-Size="14px" />
                                            <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn SortExpression="Start_unit" HeaderText="Start Unit" DataField="Start_unit"
                                            EditFormColumnIndex="1" UniqueName="Start_unit">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStartUnitEdit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Start_unit")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="cmb_startUnitEidt" runat="server" Width="160" MarkFirstMatch="true"
                                                    EmptyMessage="--Select--">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Bottom" Wrap="true" Font-Size="14px" />
                                            <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Frequency" SortExpression="Frequency" DataField="Frequency"
                                            EditFormColumnIndex="0" UniqueName="Frequency">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFrequencyEdit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Frequency")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadTextBox ID="txtFrequencyEdit" runat="server" Width="160" Height="20">
                                                    <ClientEvents OnKeyPress="NumberOnly" />
                                                </telerik:RadTextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" VerticalAlign="Bottom" Font-Size="14px" />
                                            <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Frequency Unit" SortExpression="Frequency_unit"
                                            DataField="Frequency_unit" EditFormColumnIndex="1" UniqueName="Frequency_unit">
                                            <ItemTemplate>
                                                <asp:Label ID="lblfrequencyUnitEdit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Frequency_unit")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="cmb_Frequency_unitEdit" MarkFirstMatch="true" runat="server"
                                                    Width="155" EmptyMessage="--Select--">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" Wrap="true" VerticalAlign="Bottom" Font-Size="14px" />
                                            <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Resource" SortExpression="ResourceNames"
                                            DataField="ResourceNames" EditFormColumnIndex="0" UniqueName="ResourceNames"
                                            ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblResourceEdit" onmouseover="ShowFullEntityName(this)" onmouseout="HideTooltip()"
                                                    runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ResourceNames")%>'> </asp:Label>
                                                <asp:HiddenField ID="hf_resources" Value='<%# DataBinder.Eval(Container.DataItem,"ResourceNames") %>'
                                                    runat="server" />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox Width="160" ID="cmb_resourceEdit" runat="server" ViewStateMode="Enabled"
                                                    AllowCustomText="True">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="CheckBox1" MarkFirstMatch="true" runat="server" Text='<%# Eval("Resource_name") %>' />
                                                    </ItemTemplate>
                                                </telerik:RadComboBox>                                               
                                            </EditItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" Wrap="false" VerticalAlign="Bottom" Width="10%" />
                                            <ItemStyle CssClass="column" Wrap="false" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="pk_job_task_id" UniqueName="pk_job_task_id"
                                            Visible="true">
                                            <ItemStyle CssClass="column" Wrap="true" Width="1%" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnDelete" Width="20" Height="20" runat="server" AlternateText="Delete"
                                                    CommandName="deleteTask" ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return deleteTask();" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <EditFormSettings ColumnNumber="2" EditFormType="AutoGenerated" CaptionFormatString="Edit Task:"
                                        FormMainTableStyle-BorderStyle="Solid" FormMainTableStyle-BorderColor="#999999"
                                        FormMainTableStyle-BorderWidth="1px">
                                        <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                        <FormCaptionStyle CssClass="column"></FormCaptionStyle>
                                        <FormMainTableStyle GridLines="None" BackColor="White" Width="100%" />
                                        <FormTableStyle BackColor="White" Height="110px" />
                                        <FormTableAlternatingItemStyle Wrap="true"></FormTableAlternatingItemStyle>
                                        <EditColumn ButtonType="ImageButton" UpdateText="Update record" UniqueName="EditCommandColumn1"
                                            CancelText="Cancel edit">
                                        </EditColumn>
                                        <FormTableButtonRowStyle HorizontalAlign="Right" CssClass=""></FormTableButtonRowStyle>
                                    </EditFormSettings>
                                    <PagerStyle AlwaysVisible="false" />
                                    <HeaderStyle BorderWidth="0px" />
                                </telerik:GridTableView>
                            </DetailTables>
                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="<%$Resources:Resource,Edit%>"
                                    UniqueName="EditCommandColumn">
                                    <ItemStyle HorizontalAlign="Left" Wrap="true" VerticalAlign="Middle" Width="10%" />
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="8%" BackColor="#8E8E8E"
                                        Font-Size="14px" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn DataField="" UniqueName="AddJobtask" Resizable="true"
                                    HeaderText="<%$Resources:Resource,Add_Task%>">
                                    <ItemStyle CssClass="column" Font-Underline="false" Wrap="false" />
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnAddSubtask" runat="server" alt="Add Job Task" CommandName="AddJobtask"
                                            ImageUrl="~/App/Images/Icons/add1.png" Width="15px" Height="15px" /><%--OnClientClick="javascript:return openAddProjectPopup();"--%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Wrap="true" VerticalAlign="Middle" />
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="true" Width="12%"
                                        BackColor="#8E8E8E" Font-Size="14px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Name" HeaderText="<%$Resources:Resource,Name%>" Resizable="False" UniqueName="Name"
                                    EditFormColumnIndex="0" SortExpression="Name">
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="true" VerticalAlign="Middle" Width="42%"
                                        BackColor="#8E8E8E" Font-Size="14px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn SortExpression="Category" HeaderText="<%$Resources:Resource,Category%>" DataField="Category"
                                    EditFormColumnIndex="1" UniqueName="Category">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCategoryEdit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Category")%>'> </asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="cmb_categoryEdit" runat="server" Width="150px">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorCategory" ControlToValidate="cmb_categoryEdit"
                                            ErrorMessage="*" runat="server" Display="Dynamic" ForeColor="Red">
                                        </asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" Font-Size="14px" />
                                    <ItemStyle CssClass="column" Width="40%" Wrap="true" HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="pk_job_id" UniqueName="pk_job_id" Visible="true"
                                    HeaderText="<%$Resources:Resource,Delete%>">
                                    <ItemStyle CssClass="column" Wrap="true" Width="3%" />
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#8E8E8E" />
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnDelete" Width="20" Height="20" runat="server" AlternateText="Delete"
                                            CommandName="deleteJob" ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return deleteJob();" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <EditFormSettings ColumnNumber="2" EditFormType="AutoGenerated" CaptionFormatString="Edit Job :"
                                FormMainTableStyle-BorderStyle="Solid" FormMainTableStyle-BorderColor="#999999"
                                FormMainTableStyle-BorderWidth="1px">
                                <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                <FormCaptionStyle CssClass="column"></FormCaptionStyle>
                                <FormMainTableStyle GridLines="None" BackColor="White" Width="100%" />
                                <FormTableStyle BackColor="White" Height="25px" />
                                <FormTableAlternatingItemStyle Wrap="true"></FormTableAlternatingItemStyle>
                                <EditColumn ButtonType="ImageButton" UpdateText="Update record" UniqueName="EditCommandColumn1"
                                    CancelText="Cancel edit">
                                </EditColumn>
                                <EditColumn UniqueName="EditColumn">
                                </EditColumn>
                                <FormTableButtonRowStyle HorizontalAlign="Right" CssClass=""></FormTableButtonRowStyle>
                            </EditFormSettings>
                            <PagerStyle AlwaysVisible="True" />
                        </MasterTableView>
                        <EditItemStyle BorderStyle="None" />
                        <HeaderStyle BorderWidth="0px" />
                        <PagerStyle AlwaysVisible="True" />
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                            <ClientEvents />
                        </ClientSettings>
                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                        </HeaderContextMenu>
                    </telerik:RadGrid>
                    </div>
                   </td>
                </tr>
            </table>
            <%--<table id="tbl_jobs1" runat="server" cellpadding="0" cellspacing="0" width="100%"
                style="background-color: #707070; border-width: 0px;">
                <tr>
                    <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                    </td>
                </tr>
            </table>--%>
       
        
         </asp:Panel>      
        <telerik:RadWindowManager ID="rd_manager" runat="server" BorderColor="Black" BorderWidth="2"
            Skin="">
            <Windows>
                <telerik:RadWindow ID="rd_add_jobTasks" runat="server" ReloadOnShow="false" Height="300"
                    Width="700" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                    VisibleStatusbar="false" VisibleOnPageLoad="false" Behaviors="Resize,Move" BorderColor="Black"
                    EnableAjaxSkinRendering="false" EnableShadow="true" BackColor="Black" VisibleTitlebar="false"
                    BorderWidth="2" Overlay="false">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_mahager_job" runat="server" VisibleTitlebar="true"  Title="Add Resource"
        Behaviors="Close,Move" BorderWidth="0px"
        Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rd_add_job" runat="server" ReloadOnShow="false" Height="500"
                Width="600" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                EnableAjaxSkinRendering="false" EnableShadow="true" BackColor="Black" BorderWidth="2"
                Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

         <telerik:RadWindowManager Visible="true" ID="rad_window" runat="server"  VisibleTitlebar="true"  Title="<%$Resources:Resource,Add_Job%>" Behaviors="Close,Move" 
                    BorderWidth="0px"  Skin="Simple" BorderStyle="None">
                <Windows>
                    <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" Animation="Slide" BorderStyle="Solid" BorderColor="Black" BorderWidth=""
                        KeepInScreenBounds="true" ReloadOnShow="false" Top="20px" Left="180px" 
                        AutoSize="false" Width="650" Height="300" VisibleStatusbar="false" VisibleOnPageLoad="false"
                     >
                     <ContentTemplate>
                     <div id="templet">
                         <table id="tbl_jobs2" style="padding-top: 10;" cellpadding="0" cellspacing="0" runat="server"
                             border="0" width="90%">
                             <tr id="tr_AddJob" runat="server" style="display: block;">
                                 <td>
                                     <table>
                                         <tr>
                                             <td>
                                                 <table border="0">
                                                     <tr>
                                                         <td>
                                                             <asp:Label ID="lblName" CssClass="normalLabel1" runat="server" Text="Name"></asp:Label>:
                                                         </td>
                                                         <td>
                                                             <telerik:RadTextBox ID="txtName" runat="server" Width="180" CssClass="SmallTextBox"
                                                                 TabIndex="1">
                                                             </telerik:RadTextBox>
                                                             <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator2" runat="server"
                                                                 ValidationGroup="RequiredField" ControlToValidate="txtName" ErrorMessage="*"
                                                                 ForeColor="Red"></asp:RequiredFieldValidator>
                                                         </td>
                                                         <td>
                                                             <asp:Label ID="lblCategory" CssClass="normalLabel1" runat="server" Text="Category"></asp:Label>:
                                                         </td>
                                                         <td>
                                                             <telerik:RadComboBox ID="cmb_Category" MarkFirstMatch="true" runat="server" Width="100px"
                                                                 EmptyMessage="--Select--" TabIndex="2">
                                                             </telerik:RadComboBox>
                                                         </td>
                                                     </tr>
                                                     <tr>
                                                         <td class="normalLabel1">
                                                             <asp:Label ID="lblDuration" runat="server" Text="Duration"></asp:Label>:
                                                         </td>
                                                         <td>
                                                             <telerik:RadTextBox ID="txtDuration" Width="60" runat="server" CssClass="SmallTextBox"
                                                                 TabIndex="1">
                                                                 <ClientEvents OnKeyPress="NumberOnly" />
                                                             </telerik:RadTextBox>
                                                         </td>
                                                         <td class="normalLabel1">
                                                             <asp:Label ID="lblDurationUnit" runat="server" Text="Duration Unit"></asp:Label>:
                                                         </td>
                                                         <td>
                                                             <telerik:RadComboBox ID="cmb_duration_unit" MarkFirstMatch="true" runat="server"
                                                                 Width="100px" EmptyMessage="--Select--" TabIndex="2">
                                                             </telerik:RadComboBox>
                                                         </td>
                                                     </tr>
                                                     <tr>
                                                         <td class="normalLabel1">
                                                             <asp:Label ID="lblFrequency" runat="server" Text="Frequency"></asp:Label>:
                                                         </td>
                                                         <td>
                                                             <telerik:RadTextBox ID="txtFrequency" Width="60" runat="server" CssClass="SmallTextBox"
                                                                 TabIndex="1">
                                                                 <ClientEvents OnKeyPress="NumberOnly" />
                                                             </telerik:RadTextBox>
                                                         </td>
                                                         <td class="normalLabel1">
                                                             <asp:Label ID="lblFrequencyUnit" runat="server" Text="Frequency Unit"></asp:Label>:
                                                         </td>
                                                         <td>
                                                             <telerik:RadComboBox ID="cmb_frequency_unit" MarkFirstMatch="true" runat="server"
                                                                 Width="100px" EmptyMessage="--Select--" TabIndex="2">
                                                             </telerik:RadComboBox>
                                                         </td>
                                                     </tr>
                                                     <tr>
                                                         <td class="normalLabel1">
                                                             <asp:Label ID="lblStart" runat="server" Text="Start"></asp:Label>:
                                                         </td>
                                                         <td>
                                                             <telerik:RadDatePicker runat="server" ID="radDatePicker" Width="185">
                                                                 <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" runat="server" UseColumnHeadersAsSelectors="False"
                                                                     ViewSelectorText="x">
                                                                 </Calendar>
                                                                 <DateInput ID="DateInput1" DisplayDateFormat="MM-dd-yyyy" runat="server" DateFormat="dd-MM-yyyy"
                                                                     Height="15px">
                                                                 </DateInput>
                                                                 <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                             </telerik:RadDatePicker>
                                                             <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator9" runat="server"
                                                                 ValidationGroup="RequiredField" ControlToValidate="radDatePicker" ErrorMessage="*"
                                                                 ForeColor="Red"></asp:RequiredFieldValidator>
                                                         </td>
                                                         <td class="normalLabel1">
                                                             <asp:Label ID="lblStartUnit" runat="server" Text="Start Unit"></asp:Label>:
                                                         </td>
                                                         <td>
                                                             <telerik:RadComboBox ID="cmb_start_unit" MarkFirstMatch="true" runat="server" Width="100px"
                                                                 EmptyMessage="--Select--" TabIndex="2">
                                                             </telerik:RadComboBox>
                                                         </td>
                                                     </tr>
                                                     <tr>
                                                         <td class="normalLabel1">
                                                             <asp:Label ID="LbltaskNumber" runat="server" Text="Task Number"></asp:Label>:
                                                         </td>
                                                         <td>
                                                             <telerik:RadTextBox Width="60" ID="Txttasknumber" runat="server" CssClass="SmallTextBox"
                                                                 TabIndex="1">
                                                                 <ClientEvents OnKeyPress="NumberOnly" />
                                                             </telerik:RadTextBox>
                                                         </td>
                                                         <td class="normalLabel1">
                                                             <asp:Label ID="lblPriors" runat="server" Text="Priors"></asp:Label>:
                                                         </td>
                                                         <td>
                                                             <telerik:RadTextBox Width="60" ID="txtPriors" runat="server" CssClass="SmallTextBox"
                                                                 TabIndex="1">
                                                                 <ClientEvents OnKeyPress="NumberOnly" />
                                                             </telerik:RadTextBox>
                                                         </td>
                                                     </tr>
                                                     <tr>
                                                         <%-- <td class="normalLabel1">
                                                    <asp:Label ID="lblDesc" runat="server" Text="Description"></asp:Label>:
                                                </td>
                                                <td>
                                                    <telerik:RadTextBox Width="180" ID="txt_Description" runat="server" CssClass="SmallTextBox"
                                                        TabIndex="1">
                                                    </telerik:RadTextBox>
                                                    <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator1" runat="server"
                                                        ValidationGroup="RequiredField" ControlToValidate="txt_Description" ErrorMessage="*"
                                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>--%>
                                                         <td class="normalLabel1">
                                                             <asp:Label ID="lblStatus" runat="server" Text="Status"></asp:Label>:
                                                         </td>
                                                         <td>
                                                             <telerik:RadComboBox ID="cmb_status" MarkFirstMatch="true" runat="server" Width="160px"
                                                                 EmptyMessage="--Select--" TabIndex="2">
                                                             </telerik:RadComboBox>
                                                         </td>
                                                     </tr>
                                                 </table>
                                                 <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                     <tr>
                                                         <td class="normalLabel1" style="width: 14%; vertical-align: middle;">
                                                             <asp:Label ID="lblDesc" runat="server" Text="Description"></asp:Label>:
                                                         </td>
                                                         <td class="normalLabel1" style="width: 85%; vertical-align: middle;">
                                                             <telerik:RadTextBox ID="txt_Description" runat="server" Width="470" TextMode="MultiLine"
                                                                 Columns="25">
                                                             </telerik:RadTextBox>
                                                             <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator1" runat="server"
                                                                 ValidationGroup="RequiredField" ControlToValidate="txt_Description" ErrorMessage="*"
                                                                 ForeColor="Red"></asp:RequiredFieldValidator>
                                                         </td>
                                                     </tr>
                                                 </table>
                                                 <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                     <tr>
                                                         <td class="normalLabel1" align="left">
                                                             <asp:Label ID="LblResource" runat="server" Text="Resources"></asp:Label>:
                                                         </td>
                                                         <td align="left" colspan="1" style="padding-left: 10px;">
                                                             <table>
                                                                 <tr>
                                                                   <td class="normalLabel" style="padding-left: 02px;">
                                                                     <asp:Label ID="LblResourceText" Width="470" runat="server" Style=""></asp:Label>
                                                                         <asp:LinkButton ID="lnkSelectReferences" ForeColor="Black" CssClass="linkText" runat="server"
                                                                             OnClientClick="javascript:return openpopupSelectResources()" TabIndex="11">
                                                                             <asp:Label ID="Label27" runat="server" Text="<%$Resources:Resource,Select_Add%>"
                                                                                 CssClass="normalLabel">
                                                                              </asp:Label>
                                                                          </asp:LinkButton>
                                                                     </td>
                                                                     
                                                                 </tr>
                                                             </table>
                                                         </td>
                                                     </tr>
                                                 </table>
                                                 <table width="100%">
                                                     <tr>
                                                         <td>
                                                             <asp:Button ID="btnSave" runat="server" TabIndex="3" Text="<%$Resources:Resource,Save%>"
                                                                 ValidationGroup="RequiredField" Width="100px" OnClick="btnSave_Click" />
                                                             <asp:Button ID="btnCancel" runat="server" OnClientClick="javascript:return CancelAddAttribute();"
                                                                 TabIndex="8" Text="<%$Resources:Resource,Cancel%>" Width="100px" />
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
                    </div>
                     </ContentTemplate>
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>

        <asp:HiddenField ID="hf_type_id" runat="server" />
        <asp:HiddenField ID="hf_job_id" runat="server" />
        <asp:HiddenField ID="hf_resource_ids" runat="server" />
        <asp:HiddenField ID="hf_resource_selected_names" runat="server" />
        <asp:HiddenField ID="hfScreenResolution" runat="server" ClientIDMode="Static" Value="0" />
        <asp:HiddenField ID="hf_AddNewJob" ClientIDMode="Static" Value="hf_AddNewJob" runat="server" />
        <asp:HiddenField ID="hf_resources" runat="server" />
        <asp:HiddenField ID="hf_task_number" runat="server" />
        <asp:HiddenField ID="hf_priors" runat="server" />
        <asp:HiddenField ID="hf_duration" runat="server" />
        <asp:HiddenField ID="hf_frequency" runat="server" />
 <%--   </fieldset>--%>
    </form>
</body>
 <%--Please don't move this code--%>
 <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
 <style>
     .RadWindow_Simple
        {
            border: solid 0px #616161;
        }
         .RadWindow .rdWindowContent
         {
             background-color:#EEEEEE;
         }
</style>
</html>
