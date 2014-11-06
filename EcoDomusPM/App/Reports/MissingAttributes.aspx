<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MissingAttributes.aspx.cs" Inherits="App_Reports_MissingAttributes" MasterPageFile="~/App/EcoDomus_PM_New.master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
    <style type="text/css">
        .EcoDomusProgressBar {
            background-image: none !important;
            padding: 0;
            margin: 0;
        }

        .EcoDomusProgressBar .ruProgressHeader {
            display: none !important;
        }

        .EcoDomusProgressBar .ruProgress,
        .EcoDomusProgressBar .ruFilePortion {
            border: none !important;
        }

        .EcoDomusProgressBar .ruShadow,
        .EcoDomusProgressBar .ruShadow > div,
        .EcoDomusProgressBar .ruFilePortion,
        .EcoDomusProgressBar .ruBar > div {
            padding: 0 !important;
            margin: 0 !important;
        }

        .EcoDomusProgressBar .ruBar {
            margin: 0 !important;
        }

        .EcoDomusProgressBar .ruShadow,
        .EcoDomusProgressBar .ruShadow > div {
            background-image: none !important;        
        }

        .EcoDomusProgressBar div.ruBar > div {
            background-image: none !important;
            background-color: #A0A0A0 !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadScriptBlock runat="server">
        <script type="text/javascript" language="javascript">
            function ProjectValidation() {

                alert('Please select Project');
                window.location = '../Settings/Project.aspx';
                return false;

            }
            function setFocus() {
                var screenhtg = set_NiceScrollToPanel();
                if (document.getElementById("<%=txtSearch.ClientID %>") != null)
                    document.getElementById("<%=txtSearch.ClientID %>").focus();

                if (screen.height > 721) {

                    $("html").css('overflow-y', 'hidden');
                    $("html").css('overflow-x', 'auto');

                }
            }
            window.onload = setFocus;
        </script>
    
        <script type="text/javascript" language="javascript">
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

            function gotoPage(id, name, attribute_name) {
                if (name == "Type") {
                    url = "../Asset/TypeProfileMenu.aspx?type_id=" + id + "&isFromMissingAttribute=Y&attribute_name=" + attribute_name;
                }
                else if (name == "Asset") {

                    url = "../Asset/AssetMenu.aspx?assetid=" + id + "&isFromMissingAttribute=Y&attribute_name=" + attribute_name;

                }
                else if (name == "Facility") {

                    url = "../Locations/FacilityMenu.aspx?FacilityId=" + id + "&isFromMissingAttribute=Y&attribute_name=" + attribute_name;
                }
                else if (name == "Space") {

                    url = "../Locations/FacilityMenu.aspx?IsFromSpace=y&pagevalue=Space Profile&id=" + id + "&profileflag=new&isFromMissingAttribute=Y&attribute_name=" + attribute_name;

                }


                window.location.href(url);

            }
            function validate(id, name) {
                alert("Select an Attribute Template for this facility.....!");
                // top.location.href = "../Locations/FacilityMenu.aspx?FacilityId=" + document.getElementById("ContentPlaceHolder1_hf_facility_id").value + "&FacilityName=" + document.getElementById("ContentPlaceHolder1_hf_facility_name").value;
                window.location.href = "../Locations/FacilityMenu.aspx?FacilityId=" + id + "&FacilityName=" + name;
                // window.location.href = "../Settings/AttributeTemplate.aspx";

                return false;
            }



            function validate1(sender, eventArgs) {
                var s1 = $find("<%=rg_missing_attribute_reports.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[0].getDataKeyValue("id") + ",";
                }

                if (s == "") {
                    alert("Please select atleast one attribute");
                    eventArgs.set_cancel(true);
                }
            }

            function pageLoad() {
                var divRadGridMissingAttributes = $($(".RadGridMissingAttributes").get(0));
                var parent = $(window);
                divRadGridMissingAttributes.height(parent.height() - 280);
                var radGridMissingAttributes = $find("<%= rg_missing_attribute_reports.ClientID %>");
                radGridMissingAttributes.repaint();
            }

            function confirmation(sender, eventArgs) {
                var confirmationMessage = $get("<%= HiddenFieldConfirmationMessage.ClientID %>").value;

                if (!confirm(confirmationMessage)) {
                    eventArgs.set_cancel(true);
                }
            }

            function ShowAlert() {
                alert("<%= Resources.Resource.Attributes_added_successfully %>");
            }
        </script>
    </telerik:RadScriptBlock>

    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    
    <telerik:RadProgressManager ID="RadProgressManager1" runat="server" />            

        <table style="height: 100%" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 15px; min-width: 15px">
                </td>
                <td valign="top">
                    <table>
                        <tr>
                            <td>
                                <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch">
                                    <table align="left">
                                        <caption style="padding-bottom: 20px;">
                                            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Missing_Attributes%>"></asp:Label>
                                        </caption>
                                        <tr>
                                            <td align="left">
                                                <telerik:RadTextBox ID="txtSearch" runat="server" CssClass="SmallTextBox" TabIndex="1" CausesValidation="false"></telerik:RadTextBox>
                                            </td>
                                            <td align="left">
                                                <telerik:RadButton ID="btnSearch" runat="server" Text="<%$Resources:Resource,Search%>" Width="100px"
                                                    CausesValidation="false" OnClick="btn_search_click" />
                                            </td>
                                            <td align="left">
                                                <telerik:RadButton ID="btnclear" runat="server" Text="<%$Resources:Resource,Clear%>" Width="100px"
                                                    OnClientClick="javascript:return Clear();" />
                                            </td>
                                            <td align="left">
                                                <telerik:RadButton ID="btnpdf" runat="server" Width="100px" OnClick="btn_pdf_click" Text="<%$Resources:Resource,Export_To_PDF%>" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 15px">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table align="left">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbl_category" runat="server" Text="<%$Resources:Resource,Category %> "
                                                CssClass="LabelText" Font-Size="8pt" Font-Bold="true"></asp:Label>:
                                            <telerik:RadComboBox ID="cmbentity" runat="server" OnSelectedIndexChanged="cmbentity_SelectedIndexChanged"
                                                AutoPostBack="true" Width="100px">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="lbl_facility" runat="server" Text="<%$Resources:Resource,Facility%>"
                                                CssClass="LabelText" Font-Size="8pt" Font-Bold="true"></asp:Label>:
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cmbfacility" runat="server" Visible="true" OnSelectedIndexChanged="cmbfacility_SelectedIndexChanged"
                                                Filter="Contains" MarkFirstMatch="true" AutoPostBack="True" Width="170px">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="width: 30px;">
                                        </td>
                                        <td>
                                            <asp:Label ID="lblMajor" Text="<%$Resources:Resource, Major%>" runat="server" CssClass="Label"></asp:Label>:
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="ckbox_major" runat="server" AutoPostBack="true" OnCheckedChanged="ckbox_major_CheckedChanged" />
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:RadioButton ID="rdBtnOmniClass" GroupName="OmniClassVersion" runat="server"
                                                Text="OmniClass 2010" Font-Size="10pt" AutoPostBack="True" Checked="true" Font-Bold="false"
                                                OnCheckedChanged="rdBtnOmniClass_CheckedChanged" />
                                        </td>
                                        <td>
                                            <asp:RadioButton ID="rdBtnOmniClass2" GroupName="OmniClassVersion" OnCheckedChanged="rdBtnOmniClass2_CheckedChanged"
                                                AutoPostBack="true" runat="server" Text="OmniClass 2006" Font-Size="10pt" Font-Bold="false" />
                                        </td>
                                    </tr>
                                </table>    
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 20px">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table cellpadding="0" cellspacing="0" style="border-collapse: collapse">
                                    <tr>
                                        <td>
                                            <div class="RadGridMissingAttributes" style="padding: 0 2px 2px 0">
                                                <telerik:RadGrid ID="rg_missing_attribute_reports" runat="server" AllowPaging="true"
                                                    AllowSorting="true" Skin="Default" OnSortCommand="rg_omniclass_sort_command"
                                                    OnPageIndexChanged="rg_missing_attribute_pageindexchanged" OnPageSizeChanged="rg_missing_attribute_pagesizechanged"
                                                    AllowMultiRowSelection="true" AutoGenerateColumns="false"
                                                    Width="100%" Height="100%" OnItemCommand="rg_missing_attribute_reports_itemcommand">
                                                    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Left" Width="100%" Position="Bottom" AlwaysVisible="True" />
                                                    <ClientSettings>
                                                        <Selecting AllowRowSelect="true" />
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                                    </ClientSettings>
                                                    <MasterTableView DataKeyNames="id,omniclass_id,name,attributes" TableLayout="Auto">
                                                        <ItemStyle Font-Size="11px" Wrap="True"></ItemStyle>
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="omniclass_id" HeaderText="omniclass_id" Visible="false">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="id" HeaderText="id" Visible="false">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridClientSelectColumn Resizable="False">
                                                                <HeaderStyle Wrap="true" Width="30px" HorizontalAlign="Center" />
                                                                <ItemStyle Wrap="true" HorizontalAlign="Center" />
                                                            </telerik:GridClientSelectColumn>
                                                            <telerik:GridBoundColumn DataField="omniclassname" HeaderText="<%$Resources:Resource,OmniClass%>"
                                                                SortExpression="omniclassname">
                                                                <HeaderStyle Width="200px" Wrap="True" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn DataField="name" HeaderText="<%$Resources:Resource,Name%>"
                                                                SortExpression="name">
                                                                <HeaderStyle Width="300px" Wrap="True"  />
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="linkEntityName" PostBackUrl="#" runat="server" alt="Delete" Text='<%# DataBinder.Eval(Container.DataItem,"name")%>'
                                                                        CommandName="Edit_" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridBoundColumn DataField="attributes" HeaderText="<%$Resources:Resource,Required_Attributes%>"
                                                                UniqueName="column" SortExpression="attributes">
                                                                <HeaderStyle Wrap="true" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn DataField="attribute_nolink" HeaderText="<%$Resources:Resource,Required_Attributes%>"
                                                                UniqueName="column" SortExpression="attribute_nolink" Visible="false">
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                                <asp:HiddenField ID="hf_facility_name" runat="server" />
                                                <asp:HiddenField ID="hf_facility_id" runat="server" />
                                                <asp:HiddenField ID="hf_template_id" runat="server" />
                                                <asp:HiddenField ID="hf_page_size" runat="server" /> 
                                                <asp:HiddenField ID="HiddenFieldConfirmationMessage" runat="server" />    
                                            </div> 
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>    
                        <tr>
                            <td style="height: 18px">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="height: 30px">
                                    <telerik:RadProgressArea ID="RadProgressArea1" runat="server" DisplayCancelButton="False" EnableEmbeddedSkins="False" ProgressIndicators="TotalProgressBar" CssClass="EcoDomusProgressBar" Visible="True" Width="100%" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 2px">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <div style="display: inline-block; *display: inline; zoom: 1;">
                                                <telerik:RadButton ID="btn_add" runat="server" Text="<%$Resources:Resource,Add_Required_Attributes_to_Model%>"
                                                    OnClick="btn_add_click" OnClientClicking="validate1">
                                                </telerik:RadButton>    
                                            </div>
                                            <div style="display: inline-block; *display: inline; zoom: 1; width: 10px">
                                            </div>
                                            <div style="display: inline-block; *display: inline; zoom: 1;">
                                                <telerik:RadButton ID="ButtonAddForAll" runat="server" Text=" "
                                                    OnClick="ButtonAddForAll_OnClick" OnClientClicking="confirmation">
                                                </telerik:RadButton>    
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <telerik:RadAjaxPanel runat="server">
                                                <asp:HiddenField ID="hf_entity_name" runat="server"></asp:HiddenField>
                                            </telerik:RadAjaxPanel>
                                        </td>
                                    </tr>
                                </table>    
                            </td>
                        </tr>
                    </table>    
                </td>
                <td style="width: 15px; min-width: 15px">
                </td>
            </tr>
        </table>  
    <%--</asp:Panel>--%>

    <telerik:RadAjaxManagerProxy ID="ramProjects" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbentity">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_missing_attribute_reports" LoadingPanelID="alp" />
                    <telerik:AjaxUpdatedControl ControlID="ButtonAddForAll" LoadingPanelID="" />
                    <telerik:AjaxUpdatedControl ControlID="HiddenFieldConfirmationMessage" LoadingPanelID="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmbfacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_missing_attribute_reports" LoadingPanelID="alp" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_missing_attribute_reports" LoadingPanelID="alp" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ckbox_major">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_missing_attribute_reports" LoadingPanelID="alp" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rg_missing_attribute_reports">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_missing_attribute_reports" LoadingPanelID="alp" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="sbtn_add">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lbl_add" UpdatePanelRenderMode="Inline" />
                    <telerik:AjaxUpdatedControl ControlID="rg_missing_attribute_reports" LoadingPanelID="alp" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ButtonAddForAll">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lbl_add" UpdatePanelRenderMode="Inline" />
                    <telerik:AjaxUpdatedControl ControlID="rg_missing_attribute_reports" LoadingPanelID="alp" />
                    <telerik:AjaxUpdatedControl ControlID="RadProgressArea1" UpdatePanelHeight="100%" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadAjaxLoadingPanel Skin="Default" ID="alp" runat="server" InitialDelayTime="0">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
