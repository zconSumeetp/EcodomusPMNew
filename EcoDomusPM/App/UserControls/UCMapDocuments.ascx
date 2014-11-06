<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCMapDocuments.ascx.cs"
    EnableViewState="true" Inherits="App_UserControls_UCMapDocuments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
    <title></title>
</head>
<body style="background-color: #F7F7F7;">
    <style type="text/css">
        .rtWrapperContent
        {
            padding: 10px !important;
            color: Black !important;
        }
    </style>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadFormDecorator ID="QsfFromDecorator" runat="server" DecoratedControls="All"
        EnableRoundedCorners="false" />
    <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
        <script language="javascript" type="text/javascript">
            function selection_change(sender, e) {
               
                var entity_id = sender._value.toString()
                var entity_name = sender._selectedItem._text.toString();

                document.getElementById("<%=hf_entityid.ClientID %>").value = entity_id;
                document.getElementById("<%=hf_entityname.ClientID %>").value = entity_name;
                document.getElementById("<%=hf_row_ids.ClientID %>").value = "";
                document.getElementById("<%=lblentityname.ClientID %>").innerText = "";
               
                
            }
            function checkSelection(sender, args) {
                var rgdocument = $find("<%=rgdocument.ClientID %>");
                var MasterTable = rgdocument.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                if (selectedRows.length < 1) {
                    args.IsValid = false;
                }
            }

            function checkComboBox(clientId, args) {
                if (!$find("<%= chbAutoMapDocuments.ClientID %>").get_checked()) {
                    var combo = $find(clientId);
                    if (combo.get_selectedIndex() < 1) {
                        args.IsValid = false;
                    }
                }
            }

            function checkCategory(sender, args) {
                checkComboBox("<%= rcbcategory.ClientID %>", args);
            }

            function checkFileNameFormat(sender, args) {
                if ($find("<%= chbAutoMapDocuments.ClientID %>").get_checked() && $find("<%= cbAutoMapFileNameFormat.ClientID %>").get_text() == "") {
                     args.IsValid = false;
                }
            }

            function autoMapCheckedChanged(sender, args) {
                Page_ClientValidate("MapDocumentsValid");
            }

            function ShowFullEntityNameGrid(lblEntityName) {
                var lblEntityNameId = lblEntityName.id;
                var hfId = lblEntityNameId.replace("lblEntityNames", "hfEntityNamesFull");
                var tooltip = $find("<%=RadToolTip1.ClientID %>");

                tooltip.set_targetControlID(lblEntityNameId);
                tooltip.set_text(document.getElementById(hfId).value);
                window.setTimeout(function () {
                    tooltip.show();
                }, 100);
            }

            function ShowFullEntityName(lblEntityName) {
                var lblEntityNameId = lblEntityName.id;
                var tooltip = $find("<%=RadToolTip1.ClientID %>");

                tooltip.set_targetControlID(lblEntityNameId);
                tooltip.set_text(document.getElementById("<%=hf_entitynames.ClientID %>").value);
                window.setTimeout(function () {
                    tooltip.show();
                }, 100);
            }

            function HideTooltip() {
                var tooltip = Telerik.Web.UI.RadToolTip.getCurrent();
                if (tooltip) tooltip.hide();
            }

        </script>
    </telerik:RadCodeBlock>

    <telerik:RadToolTip runat="server" ID="RadToolTip1" HideEvent="ManualClose" ShowEvent="FromCode"
        RelativeTo="Element" Sticky="true" Skin="WebBlue" Width="420px">
    </telerik:RadToolTip>
    <div class="qsf-demo-canvas" style="background-color: #F7F7F7;">
        <table width="100%">
            <tr>
                <td style="padding-top: 12px; width: 72%;" valign="top">
                    <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" ExpandMode="MultipleExpandedItems"
                        BorderWidth="0" BorderColor="Transparent">
                        <ExpandAnimation Type="OutSine" />
                        <Items>
                            <telerik:RadPanelItem Expanded="true" IsSeparator="false" BorderWidth="0" BorderColor="Transparent">
                                <HeaderTemplate>
                                    <asp:Panel ID="pnlDocuments" runat="server" DefaultButton="btnsearch" BorderWidth="0"
                                        BorderColor="Transparent">
                                        <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                            <tr>
                                                <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                    <asp:Label runat="server" Text="<%$Resources:Resource, Map_Documents%>" ID="lbl_grid_head" CssClass="gridHeadText"
                                                        Width="200px" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                                </td>
                                                <td align="right" onclick="stopPropagation(event)">
                                                    <div id="div_search" onclick="stopPropagation(event)" style="background-color: White;
                                                        width: 170px;">
                                                        <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                            width: 100%;">
                                                            <tr style="border-spacing=0px;">
                                                                <td align="left" width="70%" rowspan="0px" style="background-color: White; padding-bottom: 0px;">
                                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                        EmptyMessage="<%$Resources:Resource, Search%>" BorderColor="White" ID="txtSearch" Width="100%">
                                                                    </telerik:RadTextBox>
                                                                </td>
                                                                <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                                    padding-bottom: 0px;">
                                                                    <asp:ImageButton ClientIDMode="Static" OnClick="btnsearch_Click" ID="btnSearch" Height="13px"
                                                                        runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                                <td align="center" class="dropDownImage">
                                                    <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                        ID="img_arrow" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #707070;
                                            border-width: 0px;">
                                            <tr>
                                                <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <telerik:RadGrid runat="server" ID="rgdocument" BorderWidth="1px" AllowPaging="true"
                                        PageSize="10" AutoGenerateColumns="False" AllowSorting="True" PagerStyle-AlwaysVisible="false"
                                        Visible="false" AllowMultiRowSelection="true" OnSortCommand="btnsearch_Click"
                                        OnPageIndexChanged="btnsearch_Click" OnPageSizeChanged="btnsearch_Click" OnItemDataBound="rgdocument_ItemDataBound">
                                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="true" />
                                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                        <ClientSettings>
                                            <Selecting AllowRowSelect="true" />
                                        </ClientSettings>
                                        <MasterTableView DataKeyNames="pk_document_ids,document_name,entity_name,row_ids,file_path"
                                            HeaderStyle-CssClass="gridHeaderTextMedium">
                                            <Columns>
                                                <telerik:GridClientSelectColumn>
                                                    <ItemStyle Width="1%" Wrap="false" />
                                                    <HeaderStyle Width="1%" />
                                                </telerik:GridClientSelectColumn>
                                                <telerik:GridBoundColumn DataField="document_name" HeaderText="<%$Resources:Resource,Document_Name%>"
                                                    UniqueName="document_name" SortExpression="document_name">
                                                    <HeaderStyle Width="20%" ForeColor="GrayText"></HeaderStyle>
                                                    <ItemStyle CssClass="column" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="entity_name" HeaderText="<%$Resources:Resource,Entity%>"
                                                    UniqueName="entity_name">
                                                    <HeaderStyle ForeColor="GrayText" Width="10%"></HeaderStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource,Entity_Name%>" UniqueName="RowName"
                                                    SortExpression="RowName">
                                                    <HeaderStyle ForeColor="GrayText"></HeaderStyle>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEntityNames" onmouseover="ShowFullEntityNameGrid(this)" onmouseout="HideTooltip()"
                                                            runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hfEntityNamesFull" Value='<%# DataBinder.Eval(Container.DataItem,"RowName") %>'
                                                            runat="server" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="Category" HeaderText="<%$Resources:Resource,Category%>"
                                                    UniqueName="Category" SortExpression="Category">
                                                    <HeaderStyle ForeColor="GrayText" Width="21%"></HeaderStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn SortExpression="filename" DataField="filename" UniqueName="File"
                                                    HeaderText="<%$Resources:Resource,File%>">
                                                    <ItemStyle CssClass="column" Width="13%" />
                                                    <HeaderStyle ForeColor="GrayText"></HeaderStyle>
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlnkDocName" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"file_path")%>'
                                                            Text='<%# DataBinder.Eval(Container.DataItem,"document_name")%>' runat="server"
                                                            Target="_blank"></asp:HyperLink>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn UniqueName="Status" HeaderText="<%$Resources:Resource,Status%>">
                                                    <ItemStyle CssClass="column" Width="10%" />
                                                    <HeaderStyle ForeColor="GrayText" />
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblMappingStatus"></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </ContentTemplate>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:RadPanelBar>
                </td>
                <td style="padding-left: 15px; padding-top: 12px;" valign="top">
                    <table>
                        <tr>
                            <td style="padding-bottom: 6px;">
                                <asp:Panel ID="pnlMapData" runat="server">
                                    <table>
                                        <tr>
                                            <td style="padding-bottom: 8px;">
                                                <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Entity%>" CssClass="Label"></asp:Label>:
                                            </td>
                                            <td style="padding-bottom: 8px;">
                                                <telerik:RadComboBox ID="rcbentity" runat="server" CssClass="smallTextBox" AutoPostBack="False"
                                                    ClientIDMode="Static" OnClientSelectedIndexChanged="selection_change">
                                                     <%--OnSelectedIndexChanged="rcbentity_SelectedIndexChanged"--%>
                                                     
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator style="padding-left: 15px;" ValidationGroup="MapDocumentsValid" InitialValue="--Select--"
                                                    ID="rfvrcbentity" ClientIDMode="Static" SetFocusOnError="true" Display="Dynamic"
                                                    runat="server" ForeColor="Red" Font-Bold="true" ControlToValidate="rcbentity"
                                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 8px;" valign="top">
                                                <asp:Label runat="server" ID="lbl" Text="<%$Resources:Resource, Entity_Name%>" CssClass="Label"></asp:Label>:
                                            </td>
                                            <td style="padding-bottom: 8px;" valign="top">
                                                <table style="table-layout: fixed; border-collapse: collapse; width: 100%">
                                                    <tr>
                                                        <td valign="top">
                                                            <asp:LinkButton ID="lnkselect" runat="server" Text="<%$Resources:Resource, Select%>"
                                                                OnClientClick="javascript:return entity_popup();"></asp:LinkButton>
                                                            <asp:CustomValidator style="padding-left: 15px;" ValidationGroup="MapDocumentsValid" ID="rfvhf_row_ids" ClientIDMode="Static"
                                                                SetFocusOnError="true" Display="Dynamic" runat="server" ForeColor="Red" Font-Bold="true"
                                                                ClientValidationFunction="ValidateEntityName" ErrorMessage=" *"></asp:CustomValidator>
                                                        </td>
                                                        <td style="padding-left: 4px;" valign="top">
                                                            <asp:Label ID="lblvalidate" runat="server" Text="*" CssClass="LabelNormal" Visible="false"
                                                                ForeColor="Red"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" valign="top">
                                                            <asp:Label ID="lblentityname" onmouseover="ShowFullEntityName(this)" onmouseout="HideTooltip()"
                                                                runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 8px;">
                                                <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, Category%>" CssClass="Label"></asp:Label>:
                                            </td>
                                            <td style="padding-bottom: 8px;">
                                                <telerik:RadComboBox ID="rcbcategory" runat="server" CssClass="smallTextBox" CausesValidation="false"
                                                    ClientIDMode="Static" Filter="Contains">
                                                </telerik:RadComboBox>
                                                <asp:CustomValidator style="padding-left: 15px;" ValidationGroup="MapDocumentsValid"
                                                    ID="rfvrcbcategory" ClientIDMode="Static" SetFocusOnError="true" Display="Dynamic"
                                                    runat="server" ForeColor="Red" Font-Bold="true" ControlToValidate="rcbcategory" ClientValidationFunction="checkCategory"
                                                    ErrorMessage="*"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 8px;">
                                                <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, Stage%>" CssClass="Label"></asp:Label>:
                                            </td>
                                            <td style="padding-bottom: 8px;">
                                                <telerik:RadComboBox ID="rcbstage" runat="server" ClientIDMode="Static" CssClass="smallTextBox">
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator style="padding-left: 15px;" ValidationGroup="MapDocumentsValid" InitialValue="--Select--"
                                                    ID="rfvrcbstage" ClientIDMode="Static" SetFocusOnError="true" Display="Dynamic"
                                                    runat="server" ForeColor="Red" Font-Bold="true" ControlToValidate="rcbstage"
                                                    ErrorMessage=" *"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 8px; width: 90px;">
                                                <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, Approval_By%>"
                                                    CssClass="Label"></asp:Label>:
                                            </td>
                                            <td style="padding-bottom: 8px;">
                                                <telerik:RadComboBox ID="rcbapproval" runat="server" ClientIDMode="Static" CssClass="smallTextBox"
                                                    TabIndex="7">
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator style="padding-left: 15px;" ValidationGroup="MapDocumentsValid" InitialValue="--Select--"
                                                    ID="rfvrcbapproval" ClientIDMode="Static" SetFocusOnError="true" Display="Dynamic"
                                                    runat="server" ForeColor="Red" Font-Bold="true" ControlToValidate="rcbapproval"
                                                    ErrorMessage=" *"></asp:RequiredFieldValidator>
                                                <asp:HiddenField ID="hf_row_ids" runat="server" />
                                                <asp:HiddenField ID="hf_entityname" runat="server" />
                                                <asp:HiddenField ID="hf_entitynames" runat="server" />
                                                <asp:HiddenField ID="hf_entityid" runat="server" />
                                                <asp:HiddenField ID="hf_flag" runat="server" />

                                                <asp:HiddenField ID="hf_facility_id" runat="server" />

                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 8px; width: 90px;">
                                                <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,File_name_format %>" CssClass="Label"></asp:Label>:
                                            </td>
                                            <td style="padding-bottom: 8px;">
                                                <telerik:RadComboBox runat="server" ID="cbAutoMapFileNameFormat" ClientIDMode="Static" CssClass="smallTextBox" TabIndex="8" AllowCustomText="true" ValidationGroup="MapDocumentsValid">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="%Project%_%Name%_%DocumentType%" Selected="true" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                                <asp:CustomValidator style="padding-left: 15px;" ValidationGroup="MapDocumentsValid"
                                                    ID="CustomValidator1" ClientIDMode="Static" SetFocusOnError="true" Display="Dynamic" ValidateEmptyText="true"
                                                    runat="server" ForeColor="Red" Font-Bold="true" ControlToValidate="cbAutoMapFileNameFormat" ClientValidationFunction="checkFileNameFormat"
                                                    ErrorMessage="*"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 8px; width: 90px;">
                                                <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource,Auto_map_documents %>" CssClass="Label"></asp:Label>:
                                            </td>
                                            <td style="padding-bottom: 8px;">
                                                <telerik:RadButton runat="server" ID="chbAutoMapDocuments" Checked="False" ButtonType="ToggleButton" ToggleType="CheckBox" ValidationGroup="MapDocumentsValid" OnClientCheckedChanged="autoMapCheckedChanged"></telerik:RadButton>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnMapDocument" runat="server" Text="Map Documents" OnClick="btnMapDocument_Click"
                                                UseSubmitBehavior="false" Width="110px" Skin="Hay" ValidationGroup="MapDocumentsValid" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnReset" runat="server" Text="Reset fields" OnClick="btnReset_Click"
                                                UseSubmitBehavior="false" Width="100px" Skin="Hay" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 4px; font-size: 12px;">
                                <asp:CustomValidator ID="cusValidator" runat="server" ClientIDMode="Static" ValidationGroup="MapDocumentsValid"
                                    ClientValidationFunction="checkSelection" ForeColor="Red" ErrorMessage="<%$Resources:Resource,Please_select_at_least_one_document %>"></asp:CustomValidator>
                                <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" language="javascript">
        //<![CDATA[
            function entity_popup() {
            
                if (document.getElementById("<%=hf_entityid.ClientID %>").value != "") {
                    var row_ids = "";
                    var row_name = "";
                    if (document.getElementById("<%=hf_row_ids.ClientID %>").value != "") {
                        if (document.getElementById("<%=hf_entitynames.ClientID %>").value != "") {
                            row_name = document.getElementById("<%=hf_entitynames.ClientID %>").value;
                        }
                        row_ids = document.getElementById("<%=hf_row_ids.ClientID %>").value;
                        var url = "../Locations/Select_Entity_PM.aspx?entityflag=" + document.getElementById("<%=hf_entityid.ClientID %>").value + "&entityname=" + document.getElementById("<%=hf_entityname.ClientID %>").value + "&row_ids=" + row_ids + "&row_name=" + row_name + "&facilityid=" + document.getElementById("<%=hf_facility_id.ClientID %>").value;
                    }
                    else 
                    {
                        var url = "../Locations/Select_Entity_PM.aspx?entityflag=" + document.getElementById("<%=hf_entityid.ClientID %>").value + "&entityname=" + document.getElementById("<%=hf_entityname.ClientID %>").value + "&row_ids=" + row_ids + "&facilityid=" + document.getElementById("<%=hf_facility_id.ClientID %>").value;
                    }
                    manager = $find("<%=rad_window.ClientID %>");
                    var windows = manager.get_windows();
                    windows[0].show();
                    windows[0].setUrl(url);
                    return false;
                }
                else {
                    alert('<%= Resources.Resource.Please_select_entity_from_the_dropdown %>');
                    return false;
                }
            }

            function ValidateEntityName(sender, args) {
                var auto = $find("<%= chbAutoMapDocuments.ClientID %>").get_checked();

                if (!auto && document.getElementById("<%=hf_row_ids.ClientID %>").value == "") {
                    args.IsValid = false;
                }
            }
            
            function resiseParentPopwindow(str) {
                
            }

            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            function load_facilityname(name, id, row_ids) {     
                   
                document.getElementById("<%=hf_flag.ClientID %>").value = "N";
                document.getElementById("<%=hf_row_ids.ClientID %>").value = id;
                var reg = new RegExp('&nbsp;', 'g');
                name = name.replace(reg, ' ');
                var reg1 = new RegExp('single', 'g')
                name = name.replace(reg1, "'");

                name = name.split(",").join(", ");

                document.getElementById("<%=hf_entitynames.ClientID %>").value = name;
                if (name.length > 25) {
                    name = name.substring(0, 25) + ' ...';
                }
                document.getElementById("<%=lblentityname.ClientID %>").innerText = name;

            }
            //]]>
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="DocumentProfileProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnMapDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgdocument" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="lblMsg" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnAutoMapDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgdocument" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="lblMsg" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnReset">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="pnlMapData" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgdocument" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgdocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgdocument" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager Visible="true" ID="rad_window" runat="server" BorderColor="Black"
        BorderWidth="2" Skin="">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" Animation="Slide"
                Behaviors="Move, Resize" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="false"
                BorderColor="Black" EnableAjaxSkinRendering="false" EnableShadow="true" BorderWidth="2"
                AutoSize="false" Width="700" Height="480" VisibleStatusbar="false" VisibleOnPageLoad="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <div style="height: 40px;background-color: #F7F7F7;">
    </div>
    <div style="width: 100%; border: 0px; border-color: Red; background-color: #F7F7F7;">
        <table border="0" width="100%" cellspacing="0">
            <tr>
                <td height="1px" style="background-color: Orange; border-collapse: collapse; border-right-color: #C5C4C2;">
                </td>
            </tr>
            <tr>
                <td style="background-color: #F7F7F7; height: 32px; padding: 4px 6px 4px 4px;" align="right">
                    <asp:Button ID="btnDone" Text="<%$Resources:Resource, Done%>" Font-Size="Medium" runat="server" BackColor="Transparent"
                        CssClass="wizardRightImage" BorderStyle="None" BorderWidth="0px" OnClick="btnDone_Click" />
                </td>
            </tr>
            <tr>
                <td height="1px" style="background-color: #C5C4C2; border-collapse: collapse">
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
