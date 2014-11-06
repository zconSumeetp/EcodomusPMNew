<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TypeSpares.aspx.cs" Inherits="App_Asset_TypeSpares" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">  
<head runat="server">
    <title></title>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" language="javascript">
            function validate() {
                alert("Spare with this name already exists.");
                return false;
            }
            function Clear() {
                document.getElementById("txtSearch").value = "";
                return false;
            }
            function AddSpare() {

                manager = $find("<%=rd_manger_NewUI.ClientID%>");
                var windows = manager.get_windows();
                windows[0].show();
                //document.getElementById('trAddAttribute').style.display = "block";
                //document.getElementById('trbtnAddAttribute').style.display = "none";
                            
                return false;
            }

            function doClick(buttonName, e) {
                //the purpose of this function is to allow the enter key to 
                //point to the correct button to click.
                var key;

                if (window.event)
                    key = window.event.keyCode;     //IE
                else
                    key = e.which;     //firefox

                if (key == 13) {
                    //Get the button the user wants to have clicked
                    var btn = document.getElementById(buttonName);
                    if (btn != null) { //If we find the button click it
                        btn.click();
                        event.keyCode = 0
                    }
                }
            }

            function CancelAddSpare() {
                
            }
            function delete_attribute() {
                var delete_attribute = confirm("Do you want to delete this Spare?");
                return delete_attribute;

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
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }
            function openpopupSelectResources() {
                manager = $find("<%=rd_manager.ClientID%>");

                url = "SpareSuppliersPopup.aspx?";

                if (manager != null) {
                    var window = manager.get_windows();
                    if (window[0] != null) {
                        window[0]._height = 500;
                        window[0].setUrl(url);
                        var bounds = window[0].getWindowBounds();
                        var x = bounds.x;
                        var y = bounds.y;
                        window[0].moveTo(x ,0);
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
            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }
        </script>
        <script type="text/javascript" language="javascript">
            window.onload = body_load;

            function resize_Nice_Scroll() {

                $(".divScroll").getNiceScroll().resize();
            }

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
            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {
                
                var pageSize = document.getElementById("hfAttributePMPageSize").value;
                var scrollArea = sender.GridDataDiv;
                var dataHeight = sender.get_masterTableView().get_element().clientHeight;
                if (!flag) {
                    if (dataHeight < parseInt(pageSize) * 40) {
                        scrollArea.style.height = dataHeight + "px";
                    }
                    else {
                        scrollArea.style.height = ((parseInt(pageSize) - 2 )* 40 + 10) + "px";

                    }
                }
                else {

                    if (dataHeight - 260 > 180)
                        scrollArea.style.height = (dataHeight - 220) + "px";
                    else if (dataHeight - 260 < 180 && dataHeight > 220)
                        scrollArea.style.height = 220 + "px";
                    else
                        scrollArea.style.height = dataHeight + "px";
                    flag = false;
                }

            }
            var flag = false;
            function resize_gridHeight() {

                flag = true;
            }
    </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
          .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }                     
        
        
        .style1
        {
            width: 112px;
            height: 0px;
        }
        .style2
        {
            height: 30px;
        }
        .SmallTextBox
        {
        }
        .style3
        {
            width: 112px;
        }
        .column
        { 
            font-weight:bold;
           
            }
             
    </style>
     <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
</head>
<body style="background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); margin:0px;padding:0px;" >
    <form id="form1"   runat="server">
     <telerik:RadScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="" DecoratedControls="Buttons" />
    <asp:Panel ID="pnlSearch" BorderWidth="0"
        runat="server">
        <%--    <table id="tbl_containing" border="0" width="100%" class="tablecolor">
            <tr id="tr_radtab">
                <td style="">--%>
        <table width="100%" cellpadding="0" style="" cellspacing="0" border="0">
            <%-- <tr>
                <td>
                    <asp:TextBox CssClass="SmallTextBox" ID="txtSearch" runat="server" TabIndex="1"></asp:TextBox>
                    <telerik:RadButton ID="btnSearch" runat="server" Text="<%$Resources:Resource,Search%>"
                        Width="100px" OnClick="btnSearch_Click" />
                    <telerik:RadButton ID="btnClear" runat="server" Text="<%$Resources:Resource,Clear%>"
                        Width="100px" OnClientClicked="Clear" />
                </td>
            </tr> 
            OnClick="btnAddAttribute_Click"
            --%>
            
            <tr>
                <td class="centerAlign" >
                    <div class="rpbItemHeader">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                            <tr>
                                <td align="left" class="entityImage"  style="width: 50%;">
                                    <asp:Label runat="server" ID="lbl_grid_head" Text='<%$Resources:Resource,Spares%>'
                                        CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Font-Names="Arial"
                                        Font-Size="12"></asp:Label>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                    >
                                    <div id="div_search" style="width: 200px; background-color: white;" >
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                        Height="100%" EmptyMessage="<%$Resources:Resource,Search%>" BorderColor="White" ID="txtSearch" Width="180px">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ClientIDMode="Static" ID="btnSearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                        OnClick="btnSearch_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td align="right" style="padding: 4px 6px 0 0;">
                                    <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                        ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContent">
                   <%--     <fieldset style="border-style: solid; margin: 0px; border-left-color: #DCDCDC; border-top-color: #DCDCDC;
                            border-top-width: 0px; border-left-width: 0px; border-bottom-width: 1px; border-right-width: 0px;
                            border-bottom-color: #A0A0A0; border-right-color: #B4B4B4;">--%>
                            <telerik:RadGrid ID="rg_TypeSpares" runat="server" AllowPaging="true" PageSize="10"
                                AllowSorting="true" BorderColor="Gray" AllowMultiRowSelection="false" BorderWidth="1px"
                                PagerStyle-AlwaysVisible="true" AutoGenerateColumns="false"     ShowStatusBar="True"
                                AllowAutomaticUpdates="true" OnItemCommand="rg_TypeSpares_OnItemCommand" OnItemDataBound="rg_TypeSpares_OnItemDataBound"
                                OnItemCreated="rg_TypeSpares_ItemCreated" OnSortCommand="rg_TypeSpares_OnSortCommand"
                                OnPageSizeChanged="rg_TypeSpares_OnPageSizeChanged" OnPageIndexChanged="rg_TypeSpares_OnPageIndexChanged"
                                OnPreRender="rg_TypeSpares_OnPreRender">
                                <ClientSettings AllowColumnsReorder="true"  EnableRowHoverStyle="true" EnableAlternatingItems="true" ReorderColumnsOnClient="true">
                                    <Selecting AllowRowSelect="true" />
                                    <Resizing ResizeGridOnColumnResize="True" AllowResizeToFit="true"></Resizing>
                                     <Scrolling AllowScroll="true"  UseStaticHeaders="true" ScrollHeight="400" />
                                <ClientEvents OnGridCreated="GridCreated"  />
                                </ClientSettings>
                                <MasterTableView ClientDataKeyNames="pk_spare_id" DataKeyNames="pk_spare_id" HeaderStyle-CssClass="gridHeaderBoldText"
                                    TableLayout="Fixed" EditMode="EditForms" CommandItemDisplay="Top" CommandItemSettings-AddNewRecordText="<%$Resources:Resource,Add_Spare%>" >
                                    <ItemStyle CssClass="Row50" />
                                    <AlternatingItemStyle CssClass="Row50" />
                                    <PagerStyle Mode="NextPrevAndNumeric" />
                                    <Columns>
                                        <telerik:GridEditCommandColumn HeaderStyle-Width="50px" ButtonType="ImageButton"
                                            HeaderText="<%$Resources:Resource,Edit%>" UniqueName="EditCommandColumn"  ItemStyle-Width="50px">
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridBoundColumn DataField="SpareName" Visible="true" HeaderText="<%$Resources:Resource,Spare_Name%>"
                                            UniqueName="SpareName" EditFormColumnIndex="0">
                                            
                                            <ItemStyle Width="15%" Wrap="false" />
                                            <HeaderStyle Width="15%" Wrap="false" />
                                        </telerik:GridBoundColumn>
                                     <%-- <telerik:GridTemplateColumn DataField="SpareName" Visible="true" HeaderText="<%$Resources:Resource,Spare_Name%>"
                                            UniqueName="SpareName" EditFormColumnIndex="0">
                                            <ItemTemplate>
                                                 <asp:Label ID="lblSparesname" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Spare_Name")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                
                                            </EditItemTemplate>
                                            <ItemStyle Width="15%" Wrap="false" />
                                            <HeaderStyle Width="15%" Wrap="false" />
                                       </telerik:GridTemplateColumn>--%>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource,Category%>" DataField="Category"
                                            EditFormColumnIndex="0" SortExpression="Category" UniqueName="Category">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcategory" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"category")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="cmb_category" Height="155" runat="server" Width="155px" >
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorCategory" ControlToValidate="cmb_category"
                                                    ErrorMessage="*" InitialValue="---Select---" runat="server" Display="Dynamic"
                                                    ForeColor="Red">
                                                </asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                            <ItemStyle  Wrap="false" Width="10%" />
                                             <HeaderStyle Wrap="false" Width="10%" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource,Supplier%>" DataField="Suppliers" UniqueName="suppliers"
                                            EditFormColumnIndex="0" SortExpression="Suppliers">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSupplier" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Suppliers")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="cmb_Supplier" runat="server" Height="150" Width="155px">
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="cmb_Supplier"
                                                            ErrorMessage="*" InitialValue="---Select---" runat="server" Display="Dynamic"
                                                            ForeColor="Red">
                                                        </asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                            <ItemStyle Wrap="false" Width="20%" />
                                             <HeaderStyle Wrap="false" Width="20%" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="SetNumber" HeaderText="<%$Resources:Resource,Set_Number%>"
                                            Visible="true" UniqueName="SetNumber" EditFormColumnIndex="1" ColumnEditorID="GridTextBoxColumnEditor1">
                                          
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="PartNumber" HeaderText="<%$Resources:Resource,Part_Number%>"
                                            Visible="true" UniqueName="PartNumber" EditFormColumnIndex="1" ColumnEditorID="GridTextBoxColumnEditor1">
                                            <ItemStyle Width="15%" />
                                            <HeaderStyle  Width="15%" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>"
                                            Visible="true" UniqueName="Description" EditFormColumnIndex="1" ColumnEditorID="GridTextBoxColumnEditor1">
                                            <ItemStyle Width="15%" />
                                            <HeaderStyle  Width="15%" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="pk_spare_id" UniqueName="pk_spare_id" Resizable="true" 
                                            HeaderText="<%$Resources:Resource,Delete%>"  HeaderStyle-Width="10%">
                                            <ItemStyle CssClass="column"  Font-Underline="false" Width="10%" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnDelete" ToolTip="Delete" runat="server" alt="Delete" CommandName="deleteSpare"
                                                    ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return delete_attribute();" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <EditFormSettings ColumnNumber="2" EditFormType="AutoGenerated" CaptionFormatString="Edit Spares:">
                                        <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                        <FormCaptionStyle CssClass="column"></FormCaptionStyle>
                                        <FormMainTableStyle GridLines="None" BackColor="White" Width="100%" />
                                        <%--  <FormTableStyle BackColor="White" Height="110px" />--%>
                                        <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                                        <EditColumn ButtonType="ImageButton" UpdateText="Update record" UniqueName="EditCommandColumn1"
                                            CancelText="Cancel edit" UpdateImageUrl="~/App/Images/sign1.jpg">
                                        </EditColumn>
                                        <EditColumn UniqueName="EditColumn">
                                        </EditColumn>
                                        <FormTableButtonRowStyle HorizontalAlign="Right" CssClass=""></FormTableButtonRowStyle>
                                    </EditFormSettings>
                                </MasterTableView>
                                <ValidationSettings CommandsToValidate="Update" />
                            </telerik:RadGrid>
                    <%--    </fieldset>--%>
                    </div>
                </td>
            </tr>
            <tr id="trbtnAddAttribute" >
                        <td class="centerAlign" >
                            <telerik:RadButton ID="btnAddAttribute" Visible="false" runat="server" AutoPostBack="false" Text="<%$Resources:Resource,Add_Spare%>"
                                Width="100px" OnClientClicked="AddSpare" />
                                 <asp:HiddenField ID="hfAttributePMPageSize" runat="server" />
                        </td>
                    </tr>
        </table>
        
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rg_TypeSpares">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_TypeSpares" LoadingPanelID="loadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnSearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_TypeSpares" LoadingPanelID="loadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="imgbtnDelete">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rg_TypeSpares" LoadingPanelID="loadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="loadingPanel1" Skin="" runat="server" Height="75px" Width="75px">
        </telerik:RadAjaxLoadingPanel>
        <%--</td></tr></table>--%>
    </asp:Panel>
    <asp:HiddenField ID="hf_supplier_ids" runat="server" />
    <asp:HiddenField ID="hf_supplier_selected_names" runat="server" />
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

     <telerik:RadWindowManager ID="rd_manger_NewUI" runat="server"  BackColor="#EEEEEE" VisibleTitlebar="true"  Title="<%$Resources:Resource,Add_Spare%>" Behaviors="Close,Move" 
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
            <Windows>
                <telerik:RadWindow ID="rd_window_master_Uniformat" 
                    runat="server"  BorderWidth="0px" Top="10"  Modal="true" 
                ReloadOnShow="True" Width="500"  VisibleOnPageLoad="false"  
                BackColor="#EEEEEE">
                <ContentTemplate>
                <div style="width:100%">
                    <table style="margin: 10px;background-color:#EEEEEE;" cellpadding="0" cellspacing="0" border="0">
                    
                    <tr id="trAddAttribute">
                        <td>
                            <table border="0">
                                <%--<tr>
                                    <td class="style3">
                                        <asp:Label ID="Label2" CssClass="captiondock" runat="server" Text="<%$Resources:Resource,Add_Spare%>">:</asp:Label>:
                                    </td>
                                </tr>--%>
                                <tr>
                                    <th align="left" class="style3">
                                        <asp:Label ID="Label3" runat="server" CssClass="normalLabel" Text="<%$Resources:Resource,Name%>">:</asp:Label>:
                                    </th>
                                    <td>
                                        <asp:TextBox ID="txtName" runat="server" CssClass="SmallTextBox" TabIndex="1" Width="152px"></asp:TextBox>
                                        <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidatorName" runat="server"
                                            ValidationGroup="RequiredFieldGroup" ControlToValidate="txtName" ErrorMessage="*"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style1">
                                        <asp:Label ID="Label4" runat="server" CssClass="normalLabel" Text="<%$Resources:Resource,Category%>">:</asp:Label>:
                                    </th>
                                    <td class="">
                                        <telerik:RadComboBox ID="cmb_category" MarkFirstMatch="true" runat="server" Width="160px"
                                            TabIndex="3">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator1" runat="server"
                                            ValidationGroup="RequiredFieldGroup" ControlToValidate="cmb_category" ErrorMessage="*"
                                            ForeColor="Red" InitialValue="---Select---"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style3">
                                        <asp:Label ID="Label20" runat="server" CssClass="normalLabel" Text="<%$Resources:Resource,Supplier%>">:</asp:Label>:
                                    </th>
                                    <%--<td>
                                <telerik:RadComboBox ID="cmb_Supplier" MarkFirstMatch="true" runat="server" Width="160px"
                                     TabIndex="3">
<<<<<<< TypeSpares.aspx
                                </telerik:RadComboBox>
                                <asp:LinkButton ID="btnSelect" runat="server" Text="Select"></asp:LinkButton>
                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator3" runat="server"
                                    ValidationGroup="RequiredFieldGroup" ControlToValidate="cmb_Supplier" ErrorMessage="*"
                                    ForeColor="Red"  InitialValue="---Select---"></asp:RequiredFieldValidator>
=======
                                </telerik:RadComboBox>--%>
                                    <td align="left" colspan="1">
                                        <asp:Label ID="LblSupplierText" runat="server"></asp:Label>
                                        <asp:LinkButton ID="lnkSelectSupplier" ForeColor="Black" CssClass="linkText" runat="server"
                                            OnClientClick="javascript:return openpopupSelectResources()" TabIndex="11">
                                            <asp:Label ID="Label27" runat="server" Text="<%$Resources:Resource,Select_Add%>"></asp:Label></asp:LinkButton>
                                        <%-- <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator3" runat="server"
                                    ValidationGroup="RequiredFieldGroup" ControlToValidate="LblSupplierText" ErrorMessage="*"
                                    ForeColor="Red"  InitialValue="---Select---"></asp:RequiredFieldValidator>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style3">
                                        <asp:Label ID="Label8" runat="server" CssClass="normalLabel" Text="<%$Resources:Resource,Description%>">:</asp:Label>:
                                    </th>
                                    <td>
                                        <asp:TextBox ID="txtDescription" runat="server" CssClass="SmallTextBox" TabIndex="6"
                                            Width="155px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style3">
                                        <asp:Label ID="Label1" runat="server" CssClass="normalLabel" Text="<%$Resources:Resource,Set_Number%>">:</asp:Label>:
                                    </th>
                                    <td>
                                        <asp:TextBox ID="txtSetNumber" runat="server" CssClass="SmallTextBox" TabIndex="6"
                                            Width="155px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style3">
                                        <asp:Label ID="Label5" runat="server" CssClass="normalLabel" Text="<%$Resources:Resource,Part_Number%>">:</asp:Label>:
                                    </th>
                                    <td>
                                        <asp:TextBox ID="txtPartNumber" runat="server" CssClass="SmallTextBox" TabIndex="6"
                                            Width="155px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <telerik:RadButton ID="btnSave" runat="server" TabIndex="7" Text="<%$Resources:Resource,Save%>"
                                            Width="100px" OnClick="btnSave_Click" ValidationGroup="RequiredFieldGroup" />
                                        <telerik:RadButton ID="btnCancel" runat="server" AutoPostBack="false" TabIndex="8"
                                            Text="<%$Resources:Resource,Cancel%>" Width="100px" OnClientClicked="CancelAddSpare" />
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
    </form>
</body>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
<style>
     .RadWindow_Simple
        {
            border: solid 0px #616161;
        }
        .rwWindowContent
        {
            background-color:#EEEEEE;
        }
</style>
</html>
