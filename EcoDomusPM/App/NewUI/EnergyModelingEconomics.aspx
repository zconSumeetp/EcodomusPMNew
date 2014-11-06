<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true" CodeFile="EnergyModelingEconomics.aspx.cs" Inherits="App_NewUI_EnergyModelingEconomics" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />--%>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">

            function OnClientClicked(sender, args) {
                if (args.IsSplitButtonClick()) {
                    //TODO: Execute SplitButton logic
                    alert("Split button clicked!");
                }
                else {
                    //TODO: Execute main button logic
                    alert("Main button clicked!");
                }
            }

            function ShouldInitiateAjaxRequest(comboText) {

                //if there are three or more symbols entered, filter the data in the dropdown grid
                if (comboText.length > 1) {
                    $find("<%= RadAjaxManager.GetCurrent(Page).ClientID %>").ajaxRequest("LoadFilteredData");
                    return true;
                }
                else {
                    return false;
                }
            }

            function OnDeleteClicked(button, args) {
                var is_selected = document.getElementById("<%= hf_is_selected.ClientID %>").value;
                if (is_selected == "true") {
                    if (window.confirm("Are you sure you want to delete this item(s)?")) {
                        document.getElementById("<%= hf_is_selected.ClientID %>").value = "false";
                        button.set_autoPostBack(true);
                    }
                    else {
                        button.set_autoPostBack(false);
                    }
                }
                else {
                    window.confirm("Please select item(s)");
                }
            }

            function set_is_seleted_value() {
                var is_selected_value = document.getElementById("<%= hf_is_selected.ClientID %>").value;
                document.getElementById("<%= hf_is_selected.ClientID %>").value = "true";
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
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="CheckBoxes, RadioButtons, Buttons, Textbox, Textarea, Fieldset, Label, H4H5H6, Select, Zone, GridFormDetailsViews, ValidationSummary, LoginControls" />
    <table  cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;  ">
        <tr>
            <td >
            <table width="98%" cellpadding="0" cellspacing="0" >
                    <tr>
                        <td >
                            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" ClientIDMode="Static"  
                                MultiPageID="RadMultiPage1" SelectedIndex="0">
                                <Tabs>
                                    <telerik:RadTab Text="Economics" Font-Size="11" Font-Names="Arial" runat="server" PageViewID="RadPageView1" Selected="true">
                                    </telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                        <td align="right">
                            <asp:ImageButton ID="ibtn_Edit" runat="server"  ImageUrl="~/App/Images/Icons/icon_edit_sm.png"  
                             Width="15" Height="15" ImageAlign="Bottom"/>
                       
                        </td>
                        <td width="4%" align="right" style="padding-right:5px;vertical-align:middle;">
                         <asp:LinkButton ID="LinkButton1" ForeColor="#585858" Font-Bold="true" Font-Names="Arial" runat="server" Text="EDIT"  CssClass="lnkButton"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
                
            </td>
        </tr>
        <tr>
            <td >
                <table cellpadding="0" cellspacing="0" width="98%" style="border-collapse: collapse;">
                    <tr>
                        <td style="padding-top: 10px; padding-left: 15px; height: 57px;">
                            <table  cellpadding="0" cellspacing="0" style="border-collapse: collapse"
                                width="100%">
                                <tr>
                                    <td style="width: 50%" valign="top">
                                        <table  cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="background-image: url('../Images/asset_container_2.png'); height: 40px;
                                                    width: 200px; background-repeat: no-repeat;" align="center">
                                                    <asp:Label ID="lbl_project_name" runat="server" Text="Project Name" Font-Size="10"
                                                        ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                                </td>
                                                <td style="width: 5px">
                                                </td>
                                                <td style="background-image: url('../Images/asset_container_3.png'); height: 40px;
                                                    width: 200px; background-repeat: no-repeat" align="center">
                                                    <asp:Label ID="lbl_list" runat="server" Text="Economics" Font-Size="10" ForeColor="Red"
                                                        CssClass="normalLabel"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 50%" align="right">
                                        <table cellpadding="0" cellspacing="0" width="50%">
                                            <tr>
                                                <td style="padding-bottom: 3px">
                                                    <asp:Label ID="lbl_schedule_type" runat="server" Text="Select Economics Type" CssClass="normalLabel"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding: 2px">
                                                    <telerik:RadComboBox ID="cmb_ecomonics_type" runat="server" Height="150" Width="225"
                                                        ExpandDirection="Down" Skin="Default" AutoPostBack="true" OnSelectedIndexChanged="cmb_schedule_type_SelectedIndexChanged">
                                                    </telerik:RadComboBox>
                                                    <%-- <telerik:RadButton ID="btn_show" runat="server" Text="Show" Width="50"></telerik:RadButton>--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <table border="0" cellpadding="0" cellspacing="0" width="99%" style="border-collapse: collapse">
                                <tr>
                                    <td style="height: 1px; background-color: Orange">
                                    </td>
                                </tr>
                                <tr style="background-color: Gray;">
                                    <td style="height: 30px;padding-left:15px;">
                                        <asp:Label ID="Label1" runat="server" Text="ECONOMICS" CssClass="normalLabel" ForeColor="White"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 1px; background-color: Orange">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadGrid ID="rg_economics" runat="server" BorderWidth="1px" CellPadding="0"
                                Width="99%" GridLines="None" AllowPaging="true" AllowSorting="true" 
                                AutoGenerateColumns="False" PagerStyle-AlwaysVisible="true" ItemStyle-Wrap="false"
                                AllowMultiRowSelection="true" OnItemDataBound="rg_economics_ItemDataBound" OnPageSizeChanged="rg_economics_PageSizeChanged"
                                OnItemCommand="rg_economics_ItemCommand" OnPageIndexChanged="rg_economics_PageIndexChanged"
                                OnSortCommand="rg_economics_SortCommand" OnItemCreated="rg_economics_ItemCreated">
                                <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                                <ClientSettings>
                                    <Selecting AllowRowSelect="true" />
                                </ClientSettings>
                                <MasterTableView EditMode="EditForms" DataKeyNames="attribute_id,fk_field_id,object_id,header_text" CellPadding="0" CellSpacing="0"
                                    GroupHeaderItemStyle-HorizontalAlign="Left" GroupHeaderItemStyle-BackColor="#D9D9D9" TableLayout="Fixed"
                                    ClientDataKeyNames="attribute_id,fk_field_id,object_id,header_text" GroupLoadMode="Client"
                                    AllowNaturalSort="true">
                                    <GroupHeaderTemplate>
                                        <asp:CheckBox ID="chk_delete" runat="server" ToolTip="Select object to delete" onclick="set_is_seleted_value();" />
                                        <asp:Label ID="lbl_object" runat="server" Text='<%# Eval("header_text") %>'></asp:Label>
                                        <asp:HiddenField ID="hf_object_id" runat="server" Value='<%# Eval("header_text") %>' />
                                    </GroupHeaderTemplate>
                                    <Columns>
                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="<%$Resources:Resource,Edit%>"
                                            HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                            UniqueName="EditCommandColumn">
                                        </telerik:GridEditCommandColumn>
                                        
                                        <telerik:GridBoundColumn DataField="Attribute_name" HeaderText="<%$Resources:Resource,Attribute_Name%>"
                                            HeaderStyle-Width="48%" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                            EditFormColumnIndex="0">
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridBoundColumn DataField="Attribute_value" HeaderText="<%$Resources:Resource,Value%>"
                                            HeaderStyle-Width="38%" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                            EditFormColumnIndex="0">
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridTemplateColumn HeaderText="Value" DataField="Attribute_value" ItemStyle-HorizontalAlign="Left"
                                            EditFormColumnIndex="0" SortExpression="attribute_unit">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_attribute_value" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Attribute_value")%>'> </asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="cmb_attribute_value" runat="server" Width="160px" AllowCustomText="true">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>
                                     
                                    </Columns>
                                    <GroupByExpressions>
                                        <telerik:GridGroupByExpression>
                                            <SelectFields>
                                                <telerik:GridGroupByField FieldAlias="Object" FieldName="group_name" HeaderText=""
                                                    SortOrder="None"></telerik:GridGroupByField>
                                            </SelectFields>
                                            <GroupByFields>
                                                <telerik:GridGroupByField FieldName="header_text"></telerik:GridGroupByField>
                                            </GroupByFields>
                                        </telerik:GridGroupByExpression>
                                    </GroupByExpressions>
                                    <EditFormSettings EditFormType="AutoGenerated" CaptionFormatString="Edit Field:{0}:"
                                        EditColumn-HeaderStyle-HorizontalAlign="Left" CaptionDataField="Attribute_name"
                                        FormCaptionStyle-Font-Names="Arial" FormCaptionStyle-Font-Underline="true"  FormCaptionStyle-Wrap="false"
                                        FormCaptionStyle-Font-Bold="true">
                                        <FormTableItemStyle Wrap="False" CssClass="normalLabel" HorizontalAlign="Right">
                                        </FormTableItemStyle>
                                        <FormCaptionStyle CssClass="column" HorizontalAlign="Left"></FormCaptionStyle>
                                        <FormMainTableStyle GridLines="None" Width="100%" CellPadding="0" CellSpacing="1"
                                            HorizontalAlign="Center" BackColor="White" />
                                        <FormTableStyle BackColor="White" CssClass="normalLabel" CellSpacing="2" HorizontalAlign="Justify" />
                                        <FormTableAlternatingItemStyle Wrap="False" HorizontalAlign="Right"></FormTableAlternatingItemStyle>
                                        <EditColumn UpdateText="Update" UniqueName="EditCommandColumn1" CancelText="Cancel"
                                            ButtonType="ImageButton">
                                        </EditColumn>
                                        <FormTableButtonRowStyle HorizontalAlign="Right"></FormTableButtonRowStyle>
                                    </EditFormSettings>
                                </MasterTableView>
                                <ValidationSettings CommandsToValidate="Update" />
                                <ClientSettings AllowColumnsReorder="true" ReorderColumnsOnClient="true">
                                    <Resizing ResizeGridOnColumnResize="True" AllowResizeToFit="true"></Resizing>
                                </ClientSettings>
                                <AlternatingItemStyle CssClass="alternateColor" />
                            </telerik:RadGrid>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 15px">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%--<asp:Button ID="btn_delete" runat="server" Text="Delete Object" OnClientClick="if (!confirm('Are you sure you want to delete this item(s)?')) return false;"  OnClick="btn_delete_Click">
                            </asp:Button>--%>
                            <telerik:RadButton ID="btn_delete" runat="server" Text="Delete Object" OnClick="btn_delete_Click" OnClientClicked="OnDeleteClicked" AutoPostBack="false"></telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td style="height:5px">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hf_is_selected" runat="server" Value="false" />
    
    <telerik:RadAjaxManagerProxy runat="server" ID="RadAjaxManagerProxy1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_economics">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_economics" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmb_ecomonics_type">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_economics" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
            <telerik:AjaxSetting AjaxControlID="btn_delete">
                <UpdatedControls>
                  <telerik:AjaxUpdatedControl ControlID="btn_delete"  />
                    <telerik:AjaxUpdatedControl ControlID="rg_economics" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default" />
</asp:Content>

