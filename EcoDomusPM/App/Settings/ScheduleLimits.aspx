<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomus_PM_New.master"  AutoEventWireup="true"
    CodeFile="ScheduleLimits.aspx.cs" Inherits="App_Settings_ScheduleLimits" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
        <script type="text/javascript" language="javascript">
            function validate() {
                var RadGrid1 = $find("<%=rg_schedule_limit.ClientID %>");
                var masterTable = $find("<%= rg_schedule_limit.ClientID %>").get_masterTableView();
                var row = masterTable.get_dataItems().length;
                var cnt = 0;
                for (var i = 0; i < row; i++) {
                    var row1 = masterTable.get_dataItems()[i];
                    if (row1.get_selected()) {
                        cnt = cnt + 1;
                        //return true;
                        //return true;
                    }


                }

                if (cnt != 0) {

                    var flag;
                    flag = confirm("Do you want to delete?");
                    return flag;
                    //return true;
                }
                else {
                    alert("Please select item");
                    return false;

                }



            }

            function NiceScrollOnload() {
                if (screen.height > 721) {
                    $("html").css('overflow-y', 'hidden');
                    $("html").css('overflow-x', 'auto');
                }
                var screenhtg = set_NiceScrollToPanel();
            }
            function check() {
                var objLowerLimit = document.getElementById("<%=txtLowerLimit.ClientID %>");
                var str = objLowerLimit.value;
                var patt1 = new RegExp("^\S\d*.+$");
                if (patt1.test(str)) {
                    alert("Found");
                }

            }
            function deselect_row(sender, args) {
          
                var RadGrid1 = $find("<%=rg_schedule_limit.ClientID %>");
                var objName = document.getElementById("<%=txtName.ClientID %>");
                objName.value = "";
                var objDescription = document.getElementById("<%=txtDescription.ClientID %>");
                objDescription.value = "";
                var objUnitType = document.getElementById("<%=txtUnitType.ClientID %>");
                objUnitType.value = "";
                var objLowerLimit = document.getElementById("<%=txtLowerLimit.ClientID %>");
                objLowerLimit.value = "";
                var objUpperLimit = document.getElementById("<%=txtUpperLimit.ClientID %>");
                objUpperLimit.value = "";
                var objUpperLimit = document.getElementById("<%=txtUpperLimit.ClientID %>");
                objUpperLimit.value = "";
                var objchkInterpolate = document.getElementById("<%=chkInterpolate.ClientID %>");
                objchkInterpolate.checked = false;
                var objrcbNumericType = document.getElementById("<%=rcbNumericType.ClientID %>");
                
                var combo = $find('<%= rcbNumericType.ClientID%>')
                //Find item by its text.
                var item = combo.findItemByText("--Select--");
                if (item != null) {
                    item.select();
                }
            }
        </script>
    </telerik:RadCodeBlock>
   <%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <div class="divMargin" id="divmaincontent" runat="server">
        <telerik:RadFormDecorator ID="rdfSetupSync" runat="server" Skin="Default" 
            DecoratedControls="RadioButtons, Buttons, Scrollbars, Textbox" />
            <table width="100%">
            <tr>
            <td align="left" style="width:100%;"> 
            <table cellpadding="0" cellspacing="5" border="0" width="70%" style="margin: 0px 50px 5px 0px;">
            <caption >
                <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Schedule_Limits%>"></asp:Label>
            </caption>
            <tr>
                <td style="width: 100px" colspan="6">
                </td>
            </tr>
            <tr>
                <td style="width: 20%">
                    <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,  Name%>" CssClass="normalLabelBold"></asp:Label>:
                </td>
                <td style="width: 25%">
                    <asp:TextBox ID="txtName" runat="server" CssClass="SmallTextBox" Width="200px" OnTextChanged="txtName_TextChanged"
                        AutoPostBack="true"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="rftxtName" ValidationGroup="validateScheduleLimit"
                        runat="server" ControlToValidate="txtName" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                        Visible="true" SetFocusOnError="true">
                    </asp:RequiredFieldValidator>
                </td>
                <td style="width: 5%">
                </td>
                <td style="width: 20%">
                    <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,  Description%>"
                        CssClass="normalLabelBold"></asp:Label>:
                </td>
                <td style="width: 25%">
                    <asp:TextBox ID="txtDescription" CssClass="SmallTextBox" runat="server" Width="200px"></asp:TextBox>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource, Numeric_Type%>"
                        CssClass="normalLabelBold"></asp:Label>:
                </td>
                <td>
                    <telerik:RadComboBox ID="rcbNumericType" CausesValidation="false" Height="100px"
                        runat="server" Width="200px" CssClass="DropDown" Filter="Contains" AllowCustomText="false"
                        IsEditable="False">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Value="0" Text="--Select--" Selected="true" />
                            <telerik:RadComboBoxItem runat="server" Value="1" Text="CONTINUOUS" />
                            <telerik:RadComboBoxItem runat="server" Value="2" Text="DISCRETE" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="rfrcbNumericType" ValidationGroup="validateScheduleLimit"
                        runat="server" ControlToValidate="rcbNumericType" ErrorMessage="*" ForeColor="Red"
                        Display="Dynamic" InitialValue="--Select--" Visible="true" SetFocusOnError="true">
                    </asp:RequiredFieldValidator>
                </td>
                <td>
                </td>
                <td>
                    <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource, Unit_Type%>" CssClass="normalLabelBold"></asp:Label>:
                </td>
                <td>
                    <%--<telerik:RadComboBox ID="rcbUnitType" CausesValidation="false" MarkFirstMatch="true" Height="100px"
                        runat="server" Width="220px" CssClass="DropDown" AllowCustomText ="true" IsEditable="True">
                    </telerik:RadComboBox>--%>
                    <asp:TextBox ID="txtUnitType" CssClass="SmallTextBox" runat="server" Width="200px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource,  Lower_Limit_min%>"
                        CssClass="normalLabelBold"></asp:Label>:
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtLowerLimit" CssClass="SmallTextBox" runat="server" Width="100px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator1" runat="server"
                                    ValidationGroup="validateScheduleLimit" ControlToValidate="txtLowerLimit" ErrorMessage="*"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:RegularExpressionValidator ID="reg1" ValidationGroup="validateScheduleLimit"
                                    Display="Dynamic" runat="server" ControlToValidate="txtLowerLimit" ErrorMessage="Enter valid number"
                                    ForeColor="Red" ValidationExpression="(\d)*(\.)?(\d)+"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                </td>
                <td align="left">
                </td>
                <td>
                    <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,  Upper_Limit_max%>"
                        CssClass="normalLabelBold"></asp:Label>:
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtUpperLimit" CssClass="SmallTextBox" runat="server" Width="100px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator2" runat="server"
                                    ValidationGroup="validateScheduleLimit" ControlToValidate="txtUpperLimit" ErrorMessage="*"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:RegularExpressionValidator ID="reg2" ValidationGroup="validateScheduleLimit"
                                    Display="Dynamic" runat="server" ControlToValidate="txtUpperLimit" ErrorMessage="Enter valid number"
                                    ForeColor="Red" ValidationExpression="(\d)*(\.)?(\d)+"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="chkInterpolate" runat="server" Text="<%$Resources:Resource, Interpolate%>"
                        TextAlign="Right" CssClass="normalLabelBold"/>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td align="left">
                    <asp:Button ID="btnadd" Width="30%" runat="server" Text="<%$Resources:Resource,Add%>"
                        OnClick="btnadd_Click" ValidationGroup="validateScheduleLimit" />
                </td>
            </tr>
            <tr>
                <td colspan="6" style="height: 20px; width: 100%;">
                    <asp:Label ID="lblErrorMsg" runat="server" Text="" Visible="false" ForeColor="Red"
                        CssClass="Message"></asp:Label>
                </td>
            </tr>
           
        </table>
            </td>
            </tr>
            <tr>
            <td align="left">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td style="height: 1px; background-color: Orange">
                </td>
            </tr>
            <tr style="background-color: Gray;">
                <td style="height: 30px; padding-left: 15px">
                    <asp:Label ID="Label8" runat="server" Text="SCHEDULES LIMITS" CssClass="normalLabel"
                        ForeColor="White"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 1px; background-color: Orange">
                </td>
            </tr>
            <tr>
                <td>
                    <table border="1" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;border-top-width:0px;border-top-color:transparent;border-bottom-width:0px;border-bottom-color:transparent">
                        <tr>
                            <td>
                                <telerik:RadGrid ID="rg_schedule_limit" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                    AllowSorting="True" PagerStyle-AlwaysVisible="true" Width="100%" ItemStyle-Wrap="false"
                                    BorderWidth="1" GridLines="None" Skin="Default" OnPageIndexChanged="rg_schedule_limit_PageIndexChanged"
                                    OnPageSizeChanged="rg_schedule_limit_PageSizeChanged" OnSortCommand="rg_schedule_limit_SortCommand"
                                    OnSelectedIndexChanged="rg_schedule_limit_SelectedIndexChanged" CellSpacing="0"
                                    HeaderStyle-CssClass="gridHeaderText">
                                    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                    <ClientSettings EnablePostBackOnRowClick="true" ClientEvents-OnRowDeselected="deselect_row">
                                        <Selecting AllowRowSelect="true" />
                                    </ClientSettings>
                                    <MasterTableView ClientDataKeyNames="pk_simulation_schedule_limit_id" DataKeyNames="pk_simulation_schedule_limit_id">
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="pk_simulation_schedule_limit_id" Visible="false">
                                                <ItemStyle CssClass="column" Width="10%" Wrap="false" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridClientSelectColumn>
                                                <ItemStyle Width="10px" Wrap="false" />
                                                <HeaderStyle Width="10px" Wrap="false" />
                                            </telerik:GridClientSelectColumn>
                                            <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource, Name%>"
                                                SortExpression="name">
                                                <ItemStyle Wrap="false" />
                                                <HeaderStyle Wrap="false" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>">
                                                <ItemStyle Wrap="false" />
                                                <HeaderStyle Wrap="false" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="lower_limit" HeaderText="<%$Resources:Resource,Lower_Limit_min%>">
                                                <ItemStyle Wrap="false" />
                                                <HeaderStyle Wrap="false" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="upper_limit" HeaderText="<%$Resources:Resource,  Upper_Limit_max%>">
                                                <ItemStyle Wrap="false" />
                                                <HeaderStyle Wrap="false" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="numeric_type" HeaderText="<%$Resources:Resource, Numeric_Type%>">
                                                <ItemStyle Wrap="false" />
                                                <HeaderStyle Wrap="false" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="unit_type" HeaderText="<%$Resources:Resource, Unit_Type%>">
                                                <ItemStyle Wrap="false" />
                                                <HeaderStyle Wrap="false" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="interpolate" HeaderText="<%$Resources:Resource, Interpolate%>"
                                                Visible="false">
                                                <ItemStyle Wrap="false" />
                                                <HeaderStyle Wrap="false" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="right" style="padding-top: 10px">
                    <asp:Button ID="btnDelete" Width="50px" runat="server" OnClientClick="javascript:return validate();"
                        Text="<%$Resources:Resource,Delete%>" OnClick="btnDelete_Click" />
                </td>
            </tr>
        </table>
            </td>
            </tr>
            </table>
        
        
        
                
        <asp:HiddenField ID="hf_pk_simulation_Schedule_limit" Value="" runat="server" />
        <asp:UpdatePanel ID ="Panel1" runat ="server">
        <ContentTemplate >
        <asp:HiddenField ID="hf_flag" Value="" runat="server" />
        </ContentTemplate>
        </asp:UpdatePanel>
    
        
    </div>
    <%--<telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>--%>
    <telerik:RadAjaxManagerProxy ID="energyPlusManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_schedule_limit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_schedule_limit" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnadd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtName" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    <telerik:AjaxUpdatedControl ControlID="txtLowerLimit" />
                    <telerik:AjaxUpdatedControl ControlID="txtUpperLimit" />
                    <telerik:AjaxUpdatedControl ControlID="rcbNumericType" />
                    <telerik:AjaxUpdatedControl ControlID="txtUnitType" />
                    <telerik:AjaxUpdatedControl ControlID="chkInterpolate" />
                    <telerik:AjaxUpdatedControl ControlID="lblErrorMsg" />
                    <telerik:AjaxUpdatedControl ControlID="hf_pk_simulation_Schedule_limit" />
                    
                    <telerik:AjaxUpdatedControl ControlID="rg_schedule_limit" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_schedule_limit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtName" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    <telerik:AjaxUpdatedControl ControlID="txtLowerLimit" />
                    <telerik:AjaxUpdatedControl ControlID="txtUpperLimit" />
                    <telerik:AjaxUpdatedControl ControlID="rcbNumericType" />
                    <telerik:AjaxUpdatedControl ControlID="txtUnitType" />
                    <telerik:AjaxUpdatedControl ControlID="chkInterpolate" />
                    <telerik:AjaxUpdatedControl ControlID="hf_pk_simulation_Schedule_limit" />
                    <telerik:AjaxUpdatedControl ControlID="btnadd" />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <%-- <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnDelete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_schedule_limit"  />
                   
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
