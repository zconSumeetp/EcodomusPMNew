<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EnergyModelingProjectDetails.aspx.cs" MasterPageFile="~/App/EcoDomus_PM_New.master" Inherits="App_NewUI_EnergyModelingProjectAttributes" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <%--  <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />--%>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">
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

                $("html").css('overflow-y', 'hidden');
                $("html").css('overflow-x', 'auto');
                var screenhtg = set_NiceScrollToPanel();
            }
        </script>
    </telerik:RadCodeBlock>
     <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" 
        DecoratedControls="Default, Textbox, Label" />
    <table border="0" cellpadding="2" cellspacing="0" width="95%" style="border-collapse: collapse; ">
        <tr>
            <td align="left" class="tdValign" style="border-bottom-color: transparent; border-bottom-width: 0px">
               <table width="95%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td  >
                            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" ClientIDMode="Static"  
                                MultiPageID="RadMultiPage1" SelectedIndex="0">
                                <Tabs>
                                    <telerik:RadTab Text="Details" Font-Size="11" Font-Names="Arial" runat="server" PageViewID="RadPageView1" Selected="true">
                                    </telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>
                        </td>
                        <td align="right">
                            <asp:ImageButton ID="img_edit" runat="server"  ImageUrl="~/App/Images/Icons/icon_edit_sm.png"  
                             Width="15" Height="15" ImageAlign="Bottom"/>
                       
                        </td>
                        <td width="4%" align="right" style="padding-right:5px;vertical-align:middle;">
                         <asp:LinkButton ID="lbtn_edit" ForeColor="#585858" Font-Bold="true" Font-Names="Arial" runat="server" Text="EDIT" OnClientClick="javascript:return openEnergyModelingWizard();"  CssClass="lnkButton"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <%--<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse; border-width: 0px">
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
                </table>--%>
            </td>
        </tr>
    </table>

    <table cellpadding="2" cellspacing="0" width="95%" style="border-collapse: collapse;">
        <tr>
            <td style="border-top-color: transparent; border-top-width: 0px;">
                <table cellpadding="0" cellspacing="0" width="100%" style="margin-top: -1px;
                    border-collapse: collapse; border-top-color: transparent; border-top-width: 0px;
                    border-bottom-color: transparent; border-bottom-width: 0px; border-right-color: transparent;
                    border-right-width: 0px">
                    <tr>
                        <td align="left" class="tdValign"  style="border-bottom-color: transparent;padding-left:40px; padding-top:20px;
                            border-bottom-width: 0px;">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="background-image: url('../Images/asset_container_2.png'); height: 40px;
                                        width: 200px; background-repeat: no-repeat;" align="center">
                                        <asp:Label ID="lbl_project_name" runat="server" Text="Project Name"
                                            Font-Size="10" ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                    </td>
                                    <td style="width: 5px">
                                    </td>
                                    <td style="background-image: url('../Images/asset_container_3.png'); height: 40px;
                                        width: 200px; background-repeat: no-repeat" align="center">
                                        <asp:Label ID="lbl_list" runat="server" Text="Details" Font-Size="10" ForeColor="Red"
                                            CssClass="normalLabel"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="padding-top: 25px; padding-left: 40px; border-bottom-color: transparent;
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
                                            Skin="Default" Font-Bold="true" OnClick="btn_add_modeling_obj_Click" 
                                            style="top: 0px; left: 0px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 20px" colspan="2">
                                    <asp:Label ID="lbl_msg" runat="server" Text="" ForeColor="Red" CssClass="normalLabel"></asp:Label>
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
                           
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="tdValign" style="padding-left: 40px; padding-bottom: 25px">
                            <table border="0" cellpadding="0" cellspacing="0" width="95%">
                                <tr>
                                    <td align="left" class="gridRadPnlHeader" style="padding-left: 5px; vertical-align: middle">
                                         <asp:Label ID="lable1" runat="server" Text="Details" CssClass="gridHeadText"
                                        ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="1px" style="background-color: Orange; border-collapse: collapse">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border-right-width: 2;">
                                        <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse;border-top-width:0px;border-top-color:transparent;" width="100%">
                                            <tr>
                                                <td>
                                                    <telerik:RadGrid ID="rgAttributes" runat="server" BorderWidth="1px" 
                                                        CellPadding="0" ShowGroupPanel="false"
                                                        Width="100%" GridLines="None" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="False" 
                                                        PagerStyle-AlwaysVisible="true" ItemStyle-Wrap="false" AllowMultiRowSelection="true" 
                                                        OnItemDataBound="rgAttributes_ItemDataBound" OnPageSizeChanged="rgAttributes_PageSizeChanged"
                                                        OnItemCommand="rgAttributes_ItemCommand" 
                                                        OnPageIndexChanged="rgAttributes_PageIndexChanged" 
                                                        ondatabound="rgAttributes_DataBound">
                                                        <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true"/>
                                                        </ClientSettings>
                                                        
                                                        <MasterTableView EditMode="EditForms" DataKeyNames="attribute_id,fk_field_id,object_id,header_text"  TableLayout="Fixed"
                                                            GroupHeaderItemStyle-BackColor="#D9D9D9" ClientDataKeyNames="attribute_id,fk_field_id,object_id,header_text" GroupLoadMode="Client" ExpandCollapseColumn-HeaderStyle-HorizontalAlign="Left" 
                                                            AllowNaturalSort="true">
                                                            <GroupHeaderTemplate>
                                                                <asp:CheckBox ID="chk_delete" runat="server" ToolTip="Select object to delete" onclick="set_is_seleted_value();"  />
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
                                                                        <telerik:RadComboBox ID="cmb_attribute_value" runat="server" Width="160px" Height="150" AllowCustomText="true">
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
                                                                FormCaptionStyle-Font-Names="Arial" FormCaptionStyle-Font-Underline="true" FormCaptionStyle-Wrap="false"
                                                                FormCaptionStyle-Font-Bold="true">
                                                                <FormTableItemStyle Wrap="False" CssClass="normalLabel" HorizontalAlign="Right"></FormTableItemStyle>
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
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 15px">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                       <%-- <asp:Button ID="btn_delete" runat="server" Text="Delete Object" OnClick="btn_delete_Click"  OnClientClick="javascript:return delete_schedule();">
                                        </asp:Button>--%>
                                        <telerik:RadButton ID="btn_delete" runat="server" Text="Delete Object" OnClick="btn_delete_Click" OnClientClicked="OnDeleteClicked" AutoPostBack="false"></telerik:RadButton>
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

    <asp:HiddenField ID="hf_is_selected" runat="server" Value="false" />
        <telerik:RadAjaxManagerProxy ID="organizationProfilesManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmb_modeling_class">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmb_modeling_object" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmb_modeling_object">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAttributes" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgAttributes">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAttributes" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btn_add_modeling_obj">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAttributes" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="lbl_msg"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btn_delete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAttributes" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
    
</asp:Content>

