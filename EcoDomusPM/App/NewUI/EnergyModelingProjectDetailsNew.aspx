<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App/EcoDomusPM_Master.master"
    CodeFile="EnergyModelingProjectDetailsNew.aspx.cs" Inherits="App_NewUI_EnergyModelingProjectDetailsNew" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
    <style type="text/css">
       
        
        div
        {
            overflow-x: hidden;
        }
        
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
        
        .lnkBtnBgImg
        {
            background-image: url('/App/Images/asset_button_sm_gray.png');
            background-repeat: no-repeat;
            height: 25px;
            width: 60px;
            vertical-align: middle;
        }
    </style>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" 
        DecoratedControls="Default, Textbox, Label" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" language="javascript">


            function resize_iframe(obj) {

                try {

                    document.getElementById("frameSettingsMenu").hideFocus = true;
                    var oBody = frameSettingsMenu.document.body;
                    var oFrame = document.all("frameSettingsMenu");
                    //                    var string = document.getElementById("frameSettingsMenu").src.toString();


                    if (obj != null) {
                        docHeight = frameSettingsMenu.document.body.scrollHeight;
                        docWidth = frameSettingsMenu.document.body.scrollWidth;
                        if (docHeight <= 400) {
                            document.getElementById("frameSettingsMenu").height = 600;

                        }
                        else {
                            //obj.height = docHeight + 20;

                            document.getElementById("frameSettingsMenu").height = docHeight;
                            document.getElementById("frameSettingsMenu").width = docWidth;
                        }
                    }
                }

                catch (e) {
                    window.status = 'Error: ' + e.number + '; ' + e.description;
                }
            }

            window.onresize = resize_iframe;

            function resize_frame_page() {
                //window.resizeTo(1000, height);

                var docHeight;
                try {
                    var obj = parent.window.frames[1];
                    if (obj != null) {
                        resize_iframe(parent.window.frames[1]);
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

            function validate() {
                alert("Attribute with this name already exists.");
                return false;
            }

            function NiceScrollOnload() {
                if (screen.height > 721) {
                    $("html").css('overflow-y', 'hidden');
                    $("html").css('overflow-x', 'auto');
                }
                var screenhtg = set_NiceScrollToPanel();
            }
        </script>
    </telerik:RadCodeBlock>
    <div style="border-collapse: collapse" id="frameSettingsMenu">
        <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
        <table border="0" cellpadding="2" cellspacing="0" width="95%" style="border-collapse: collapse;
            border-top-color: transparent; border-top-width: 0px;  border-left-width:2;
            border-right-color: Gray;  border-right-width: 2px;">
            <tr>
                <td class="tdValign" style="border-bottom-color: transparent; border-bottom-width: 0px">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color: #F7F7F7;
                        border-collapse: collapse; border-width: 0px">
                        <tr>
                            <td style="margin: 0px; background-color: #FFFFFF; width: 90px; height: 30px">
                                <asp:Image ID="img_weather_tab" runat="server" ImageUrl="~/App/Images/Icons/Detail_Tab.png" />
                            </td>
                            <td style="width: 80%">
                            </td>
                            <td style="" align="right">
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
        </table>
        <table border="2" cellpadding="2" cellspacing="0" width="95%" style="border-collapse: collapse; border-left-width:2;
            border-top-color: transparent; border-top-width: 0px;">
            <tr>
                <td style="border-top-color: transparent; border-top-width: 0px;">
                    <table border="1" cellpadding="0" cellspacing="0" width="100%" style="margin-top: -1px;
                        border-collapse: collapse; border-top-color: transparent; border-top-width: 0px;
                        border-bottom-color: transparent; border-bottom-width: 0px; border-right-color: transparent;
                        border-right-width: 0px">
                        <tr>
                            <td class="tdValign" style="padding-top: 10px; padding-left: 10px; border-bottom-color: transparent;
                                border-bottom-width: 0px;">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="background-image: url('/App/Images/asset_container_2.png'); height: 40px;
                                            width: 200px; background-repeat: no-repeat;" align="center">
                                            <asp:Label ID="lbl_project_name" runat="server" Text="Annex Simulation Project 1"
                                                Font-Size="10" ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                        </td>
                                        <td style="width: 5px">
                                        </td>
                                        <td style="background-image: url('/App/Images/asset_container_3.png'); height: 40px;
                                            width: 200px; background-repeat: no-repeat" align="center">
                                            <asp:Label ID="lbl_list" runat="server" Text="Details" Font-Size="10" ForeColor="Red"
                                                CssClass="normalLabel"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 25px; padding-left: 40px; border-bottom-color: transparent;
                                border-bottom-width: 0px;">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="padding-right: 5px">
                                            <asp:Label ID="lbl_modeling_class" runat="server" Text="Modeling Class" CssClass="lblBold"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cmb_modeling_class" runat="server" Width="350px" ExpandDirection="Down"
                                                ZIndex="10" AutoPostBack="True" OnSelectedIndexChanged="cmb_modeling_class_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 20px" colspan="2">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-right: 5px">
                                            <asp:Label ID="lbl_modeling_object" runat="server" Text="Modeling Object" CssClass="lblBold"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cmb_modeling_object" runat="server" Width="350px" ExpandDirection="Down"
                                                ZIndex="10" AutoPostBack="True" OnSelectedIndexChanged="cmb_modeling_object_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="padding-left: 10px">
                                            <telerik:RadButton ID="btn_add_modeling_obj" runat="server" Text="Add Modeling Object"
                                                Skin="Default" Font-Bold="true" onclick="btn_add_modeling_obj_Click" />
                                        </td>
                                    </tr>
                                     <tr>
                                        <td style="height: 20px" colspan="2">
                                        </td>
                                    </tr>
                                 <%--     <tr>
                                    <td style="padding-right: 5px">
                                            <asp:Label ID="lblEntity" runat="server" Text="Entity" CssClass="lblBold"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cmb_entity" runat="server" Width="350px" 
                                                ExpandDirection="Down" ZIndex="10" AutoPostBack="True" 
                                                onselectedindexchanged="cmb_entity_SelectedIndexChanged" >
                                           <Items>
                                           <telerik:RadComboBoxItem Value="Select" Text="--Select--" runat="server" Selected="true" />
                                           <telerik:RadComboBoxItem Value="Asset" Text="Asset" runat="server" />            
                                           <telerik:RadComboBoxItem Value="Facility" Text="Facility" runat="server" />       
                                           <telerik:RadComboBoxItem Value="Space" Text="Space" runat="server" />                                     
                                           </Items>                                                
                                            </telerik:RadComboBox>
                                        </td>
                                    
                                    </tr>--%>

                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 40px; padding-top: 15px; border-bottom-color: transparent;
                                border-bottom-width: 0px; border-top-color: transparent; border-top-width: 0px;">
                                <asp:Label ID="lable1" runat="server" Text="Details" Font-Bold="true" CssClass="lblBold"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdValign" style="padding-left: 40px; padding-bottom: 25px">
                                <table border="0" cellpadding="0" cellspacing="0" width="95%">
                                    <tr>
                                        <td align="right" class="gridRadPnlHeader" style="padding-right:5px;vertical-align:middle">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td align="center">
                                                        <%--<asp:LinkButton ID="lbtn_copy" runat="server" Text="Copy" Font-Size="10" ForeColor="Black"
                                                            Font-Underline="false" Height="20"></asp:LinkButton>--%>
                                                            
                                                            <telerik:RadButton ID="btn_copy" Text="Copy" runat="server"  Width="40"></telerik:RadButton>
                                                    </td>
                                                    <td style="width: 5px">
                                                    </td>
                                                    <td align="center">
                                                       <%-- <asp:LinkButton ID="lbtn_paste" runat="server" Text="Paste" Font-Size="10" ForeColor="Black"
                                                            Font-Underline="false" Height="20"></asp:LinkButton>--%>
                                                            
                                                            <telerik:RadButton ID="btn_paste" Text="Paste" runat="server" Width="40"></telerik:RadButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="1px" style="background-color: Orange; border-collapse: collapse">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style=" border-right-width: 2;">
                                        <table style="border-right-width:2; border-bottom-color:Gray; border-right-color:Gray; border-bottom-width:2;" cellpadding="0" cellspacing="0">
                                        <tr>
                                        <td>
                                            <telerik:RadGrid ID="rg_details" runat="server" AllowPaging="true" PageSize="10"
                                                AutoGenerateColumns="true" Width="950px" AllowSorting="true" AllowMultiRowSelection="true"
                                                PagerStyle-AlwaysVisible="false"  OnPreRender="rg_details_PreRender" MasterTableView-CellPadding="0" MasterTableView-CellSpacing="0"
                                                AllowAutomaticUpdates="true" ItemStyle-Wrap="false" OnPageIndexChanged="rg_details_OnPageIndexChanged"
                                                OnPageSizeChanged="rg_details_OnPageSizeChanged" OnItemCommand="rg_details_OnItemCommand"
                                                OnColumnCreated="rg_details_OnColumnCreated" OnItemDataBound="rg_details_OnItemDataBound" OnItemCreated="rg_details_OnItemCreated">
                                                <MasterTableView EditMode="EditForms" ClientDataKeyNames="Field"
                                                    DataKeyNames="Field" GroupLoadMode="Client"
                                                    HeaderStyle-CssClass="gridHeaderBoldText" ExpandCollapseColumn-Visible="false"
                                                    TableLayout="Fixed">
                                                    <PagerStyle Mode="NextPrevNumericAndAdvanced" HorizontalAlign="Right" Width="100%"
                                                        AlwaysVisible="true" />
                                                        
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn HeaderStyle-Width="50px" ButtonType="ImageButton" EditFormColumnIndex="1"
                                                            HeaderText="Edit" UniqueName="EditCommandColumn" ItemStyle-Width="5px">
                                                        </telerik:GridEditCommandColumn>
                                                        <%--<telerik:GridBoundColumn DataField="field" Visible="true" HeaderText="Field" UniqueName="field"
                                                            ReadOnly="True">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="description" HeaderText="Description" Visible="true"
                                                            UniqueName="description" EditFormColumnIndex="0">
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="value" HeaderText="Value" Visible="true" UniqueName="value"
                                                            EditFormColumnIndex="1">
                                                        </telerik:GridBoundColumn>--%>
                                                    </Columns>
                                                    <EditFormSettings  EditFormType="AutoGenerated"  CaptionFormatString="Edit Field:{0}" CaptionDataField="Field"  FormCaptionStyle-Font-Names="Arial" FormCaptionStyle-Font-Size="Small" FormCaptionStyle-Font-Underline="true" FormCaptionStyle-Wrap="false" FormCaptionStyle-Font-Bold="true">
                                                        <FormTableItemStyle Wrap="False" CssClass="normalLabel"></FormTableItemStyle>
                                                        <FormCaptionStyle CssClass="column"></FormCaptionStyle>
                                                        <FormMainTableStyle GridLines="None"  Width="100%"  CellPadding="0" CellSpacing="1" HorizontalAlign="Center" BackColor="White" />
                                                        <FormTableStyle BackColor="White"  CssClass="normalLabel" />
                                                        <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                                                        <EditColumn  UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel" ButtonType="ImageButton">
                                                        </EditColumn>
                                                        <FormTableButtonRowStyle HorizontalAlign="Right"></FormTableButtonRowStyle>
                                                        
                                                    </EditFormSettings>
                                                </MasterTableView>
                                                <ValidationSettings CommandsToValidate="Update" />
                                                <ClientSettings EnableRowHoverStyle="true"  AllowColumnsReorder="true" ReorderColumnsOnClient="true">
                                                    <Selecting AllowRowSelect="true" />
                                                    <Resizing ResizeGridOnColumnResize="True" AllowResizeToFit="true"></Resizing>
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                            </td>
                                            </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table border="0" cellpadding="0" cellspacing="0" width="95%">
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadWindowManager ID="rad_windowmgr" runat="server" VisibleStatusbar="false">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="Slide" KeepInScreenBounds="true"
                ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false" Width="950" Height="500"
                Top="2px" VisibleStatusbar="false" VisibleOnPageLoad="false" Skin="Forest" Behaviors="Move,Resize">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadAjaxManagerProxy ID="organizationProfilesManagerProxy" runat="server">
        <AjaxSettings>
           
            <telerik:AjaxSetting AjaxControlID="cmb_modeling_class">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmb_modeling_object" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="cmb_entity" LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>

             <telerik:AjaxSetting AjaxControlID="cmb_modeling_object">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmb_entity" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="rg_details" LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="rg_details">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_details" LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="cmb_entity">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_details"  LoadingPanelID="RadAjaxLoadingPanel1"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
    <asp:HiddenField ID="hdnModelingObjId" runat="server" />
    <asp:HiddenField ID="hdnModelingObjName" runat="server" />
    <asp:HiddenField ID="hdnEntity" runat="server" />
    <asp:HiddenField ID="hdnattrId" runat="server" />
    <asp:HiddenField ID="hdndesc" runat="server" />
    <asp:HiddenField ID="hdnvalue" runat="server" />
</asp:Content>
