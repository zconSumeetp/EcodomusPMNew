<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="SyncAsset.aspx.cs" Inherits="App_Asset_SyncAsset" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <head>
        <%-- <meta http-equiv="REFRESH" content="30">--%>
        <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
        <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <script type="text/javascript">

                function Clear() {
                    try {
                        document.getElementById("ContentPlaceHolder1_txtSearch").value = "";
                        return false;
                    }
                    catch (e) {
                        alert(e.message + "  " + e.Number);
                        return false;
                    }
                }

                function GridCreated(sender, args) {
                    //alert(sender.get_masterTableView().get_pageSize());
                    var pageSize = document.getElementById("ContentPlaceHolder1_hfTypePMPageSize").value;
                    var scrollArea = sender.GridDataDiv;
                    var dataHeight = sender.get_masterTableView().get_element().clientHeight;

                    if (dataHeight < parseInt(pageSize) * 40) {
                        scrollArea.style.height = dataHeight + "px";
                    }
                    else {
                        scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
                    }

                    //sender.get_masterTableView().set_pageSize(globalPageHeight);
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
                function openpopupSyncStatus(obj, obj1, obj2, status) {

                    if (status != "Never Ran") {
                        var manager;
                        manager = $find("<%= RadWindowManager1.ClientID%>");
                        var url = "../Asset/SyncStatus.aspx?external_system_name=" + obj + "&pk_external_system_sync_history_id=" + obj1 + "&fk_external_system_configuration_id=" + obj2 + "";

                        if (manager != null) {
                            var windows = manager.get_windows();
                            windows[0].setUrl(url);
                            windows[0].show();
                            // windows[0].set_modal(false);
                        }
                    }
                    else {
                        alert("This Configuration never ran before")
                    }
                    return false;
                }
                window.onload = body_load;
                function body_load() {
                    var screenhtg = set_NiceScrollToPanel();
                }
            </script>
        </telerik:RadScriptBlock>
    </head>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <%--<telerik:RadWindowManager ID="rad_windowmgr" runat="server" Skin="Forest" VisibleStatusbar="false">
    <Windows>
        <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="Slide" KeepInScreenBounds="true"
            ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false" Width="720" Height="400"
            Top="2px" VisibleStatusbar="false" VisibleOnPageLoad="false" Visible="true" Skin="Forest">
        </telerik:RadWindow>
    </Windows>
      </telerik:RadWindowManager>--%>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" VisibleTitlebar="true"
        Title="Ecodomus FM Synch Status" Behaviors="Close,Move" BorderWidth="0px" Skin="Simple"
        BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="radWindow1" runat="server" Animation="Slide" KeepInScreenBounds="true"
                ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false" Width="720" Height="450"
                Top="100px" Left="150px" VisibleStatusbar="false" VisibleOnPageLoad="false" Visible="true"
              >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:Timer ID="Timer1" Interval="30000" OnTick="Timer1_click" runat="server">
    </asp:Timer>
    <table style="margin: 0px; width:100%"  align="left">
        
        <tr>
            <td class="centerAlign">
             
                <asp:Button ID="btnSynchronize" runat="server" Text="<%$Resources:Resource, Synchronize%>"
                    oWidth="110px" OnClick="btnSynchronize_Click" />
                    <asp:HiddenField ID="HiddenField1" runat="server" Value="1033747F-DC40-E111-96C1-00101832264B" />
                    <asp:HiddenField ID="hfTypePMPageSize" runat="server" Value="" />
            </td>
            <td style="width: 168px">
             <asp:HiddenField ID="hid" runat="server" Value="1033747F-DC40-E111-96C1-00101832264B" />
            </td>
           
           <td>
                <asp:Label ID="lblRefreshMsg" CssClass="Label" Text="<%$Resources:Resource,Sync_Bottom_Line%>"
                    runat="server" Font-Size="Small" ForeColor="#009933"></asp:Label>
            </td>
             <td style="width: 30px; height: 26px;">
                <asp:Label ID="lblSyncCompleteStatus" class="Message" runat="server" Width="200px"></asp:Label>
            </td>
        </tr>
        
       
        <tr>
            <td class="centerAlign" colspan="5">
                <div class="rpbItemHeader">
                    <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                        <tr>
                            <td align="left" class="entityImage" style="width: 50%;">
                                <asp:Label runat="server" Text="<%$Resources:Resource,Synchronize%>"
                                    ID="lbl_grid_head" CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8"
                                    Font-Names="Arial" Font-Size="12"></asp:Label>
                            </td>
                            <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;">
                                <div id="div_search" style="width: 200px; background-color: white;">
                                    <table>
                                        <tr>
                                            <td>
                                                <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                    Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="180px">
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
                            <td align="right" style="padding: 4px 4px 0 0;">
                                <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div>
                    <telerik:RadGrid ID="SyncFacility" runat="server" AllowPaging="True" Skin="Default"
                        OnItemDataBound="SyncFacility_ItemDatabound" AllowSorting="True"
                        AutoGenerateColumns="False" CellSpacing="0" GridLines="None" AllowMultiRowSelection="True"
                        OnPageIndexChanged="SyncFacility_PageIndexChanged" OnPageSizeChanged="SyncFacility_PageSizeChanged"
                        OnSortCommand="SyncFacility_SortCommand">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" AlwaysVisible="true" />
                        <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                            <Selecting AllowRowSelect="true" />
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="400" />
                            <ClientEvents OnGridCreated="GridCreated" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="pk_external_system_id">
                         <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                            <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                            <FooterStyle Height="25px" Font-Names="Arial" />
                            <Columns>
                                <telerik:GridClientSelectColumn UniqueName="GridCheckBox">
                                    <ItemStyle Width="20px" />
                                    <HeaderStyle Width="20px" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="fk_external_system_configuration_id" HeaderText="Configuration ID"
                                    UniqueName="ConfigurationId" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="configuration_name" HeaderText="<%$Resources:Resource,Configuration_Name%>"
                                    UniqueName="ConfigurationName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Facility_Name%>"
                                    UniqueName="FacilityName" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="external_system_name" HeaderText="<%$Resources:Resource,External_System%>"
                                    UniqueName="ExternalSystem">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sync_end_datetime" HeaderText="<%$Resources:Resource,Last_Sync_Date%>"
                                    UniqueName="Last_Sync_Date">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="pk_external_system_sync_history_id" HeaderText="History ID"
                                    UniqueName="HistoryID" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="sync_status" HeaderText="<%$Resources:Resource,Status%>"
                                    UniqueName="Status">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="sync_status" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"sync_status")%>'
                                            Font-Underline="true"></asp:HyperLink>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="sync_message" HeaderText="<%$Resources:Resource,Message%>"
                                    UniqueName="Message_text">
                                </telerik:GridBoundColumn>
                                <%-- <telerik:GridButtonColumn ButtonType="LinkButton"   DataTextField ="status" HeaderText="<%$Resources:Resource,Status%>" UniqueName="Status">
                    </telerik:GridButtonColumn>
                                --%>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </td>
        </tr>
        
      
        <tr>
            
            <td>
            </td>
        </tr>
        <tr>
            <td style="width: 30px">
                &nbsp;
                <div>
                    <asp:Table ID="tbl" runat="server" />
                </div>
            </td>
            <td style="width: 168px">
                &nbsp;
            </td>
        </tr>
    </table>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSynchronize">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="SyncFacility" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblSyncCompleteStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="Timer1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="SyncFacility" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="SyncFacility" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblSyncCompleteStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="Button2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtSearch" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="SyncFacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="SyncFacility" LoadingPanelID="RadAjaxLoadingPanel1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
