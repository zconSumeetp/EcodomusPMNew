<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductDocument.aspx.cs"
    Inherits="App.Settings.AppCentralProductDocument" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function load_popup(reg) {
                var title = 'Add Document';
                var str = document.getElementById("hfproductId");
                var productId = str.value;
                var updateDocument = false;
                var str1 = document.getElementById("hfOrgId");
                var orgId = str1.value;
                if (reg.document_name == undefined) {
                    reg.document_name = '';
                } else {
                    title = 'Edit Document';
                    updateDocument = true;
                }

                if (reg.document_desc == undefined) {
                    reg.document_desc = '';
                }
                var url = "../Settings/ProductDocument.aspx?ProductId=" + productId + "&Ispopup=Y" + "&organization_id=" + orgId + "&category=" + reg.category + "&document_name=" + reg.document_name +
                "&document_desc=" + reg.document_desc + "&update=" + updateDocument + "&file_path=" + reg.file_path + "&file_name=" + reg.file_name + "&document_id=" + reg.pk_product_document_id;
                var addEditWindow = $find("<%= rd_profile_popup.ClientID %>");
                addEditWindow.set_title(title);
                addEditWindow.show();
                addEditWindow.setUrl(url);
                
                var obj = parent.window.frames[1];
                if (obj != null) {

                    window.parent.resize_iframe(parent.window.frames[0]);

                }

                return false;
            }
            function resize_frame_page() {
                var docHeight;
                try {
                    var obj = parent.window.frames[1];
                    if (obj != null) {

                        window.parent.resize_iframe(parent.window.frames[0]);

                    }
                }
                catch (e) {
                    window.status = 'Error: ' + e.number + '; ' + e.description;
                }

            }

            function body_load() {

                //var screenhtg = parseInt(window.screen.height * 0.66);
                //document.getElementById("divSelectedDomponentContent").style.height = screenhtg * 0.74;
                //$(".divScroll").niceScroll({ touchbehavior: false, cursorcolor: "#969696", cursoropacitymax: 0.8, cursorborder: "none", cursorwidth: 08, background: "#cccccc", overflow: "hidden" });
                $("#divSelectedDomponentContent").show();

            }
            window.onload = body_load;

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


            function Toggle(button, args) {

                document.getElementById('tblAdddocument').style.display = 'block';
                if (button._text == "Add Document") {

                    document.getElementById('txtName').value = "";
                    document.getElementById('txtdescription').value = "";

                    var combo = $find("rcbcategory");
                    document.getElementById('tblAdddocument').style.display = 'block';
                    var obj = parent.window.frames[0];
                    if (obj != null) {

                        window.parent.resize_iframe(parent.window.frames[0]);

                    }
                }
                else {
                    document.getElementById('tblAdddocument').style.display = 'none';
                }

            }

            function deleteSystem() {
                var flag;
                flag = confirm("Are you sure you want to delete this Document");
                return flag;
            }

            function Clear() {
                try {

                    document.getElementById("txtSearch").value = "";

                    return false;
                }
                catch (e) {
                    return false;
                }
            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }


            function GetRadWindow() {

                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function CloseWindow() {
                window.parent.callback_refresh();
                GetRadWindow().close();

                return false;
            }

            function callback_refresh() {


                document.getElementById("<%= btn_refresh_doc.ClientID %>").click();

            }


        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
        .RadWindow_Default .rwCorner .rwTopLeft, .RadWindow_Default .rwTitlebar
        {
            width: 500px;
            height: 300px;
        }
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
        .rpbItemHeader
        {
            background-color: #808080;
        }
        .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        html
        {
            overflow-y: hidden;
            overflow-x: Auto;
        }
    </style>
</head>
<body style="background-position: white; background: white; padding: 0px; margin: 0px 0px 0px 0px;background: #F7F7F7;">
    <form id="form1" runat="server" style="margin-left: 1%;" defaultfocus="txtSearch">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <asp:Panel ID="aspPanel" runat="server" DefaultButton="btnSearch">
        <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
        <table width="99%">
            <div id="divblock" runat="server">
            <tr>
                    <td>
                        <telerik:RadButton ID="RadButton1" runat="server" AutoPostBack="false" OnClientClicked="load_popup"
                            Skin="Default" Text="<%$Resources:Resource, Add_Document%>">
                        </telerik:RadButton>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%">
                        <div class="rpbItemHeader">
                            <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">

                                <tr>
                                    <td align="left" style="width: 30%">
                                        <asp:Label ID="Label1" runat="server" CssClass="gridHeadText" ForeColor="#F8F8F8"
                                            Font-Names="Arial" Font-Size="12" Text="<%$Resources:Resource, Product%>"></asp:Label>
                                        <asp:Label ID="lblColon" runat="server" CssClass="gridHeadText" ForeColor="#F8F8F8"
                                            Font-Names="Arial" Font-Size="12" Text=":"></asp:Label>
                                        <asp:Label ID="lblproduct" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"
                                            CssClass="gridHeadText" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 40%">
                                        <asp:Label ID="Label2" runat="server" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"
                                            CssClass="gridHeadText" Text="<%$Resources:Resource,   Product_Manufacturer%>"></asp:Label>
                                        <asp:Label ID="lblColn1" runat="server" CssClass="gridHeadText" ForeColor="#F8F8F8"
                                            Font-Names="Arial" Font-Size="12" Text=":"></asp:Label>
                                        <asp:Label ID="lblProductManufacturer" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"
                                            CssClass="gridHeadText" runat="server"></asp:Label>
                                    </td>
                                    <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                        onclick="stopPropagation(event)">
                                        <div id="div1" style="width: 200px; background-color: white;" onclick="stopPropagation(event)">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox ID="txtSearch" CssClass="txtboxHeight" ClientIDMode="Static"
                                                            runat="server" Height="100%" EmptyMessage="Search" BorderColor="White" Width="180px">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ClientIDMode="Static" ID="btnSearch" Height="13px" runat="server"
                                                            CausesValidation="false" ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnSearch_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                    <td align="right" style="padding: 4px 4px 0 0; width: 40px">
                                        <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                            ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="divSelectedDomponentContent1" class="divProperties divScroll RightMenu_1_Content">
                            <telerik:RadGrid ID="rgProductDoc" TabIndex="18" runat="server" BorderWidth="1px"
                                Skin="Default" PageSize="10" Width="99%" OnItemDataBound="rgDocument_ItemDataBound"
                                OnItemCommand="rgDocument_ItemCommand" PagerStyle-AlwaysVisible="true" AllowPaging="true"
                                OnSortCommand="rgProductDoc_onSortCommand" AutoGenerateColumns="False" AllowSorting="True">
                                <MasterTableView DataKeyNames="document_id" ClientDataKeyNames="document_id">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="document_id" HeaderText="document_id" UniqueName="task_id"
                                            Visible="False">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="document_id" HeaderText="<%$Resources:Resource, Edit%>">
                                            <ItemStyle CssClass="column" />
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnEdit" Visible="true" runat="server" AlternateText="Edit"
                                                    ImageUrl="~/App/Images/PencilIcon.gif" OnClientClick="javascript:return load_popup(this);"
                                                    pk_product_document_id='<%# DataBinder.Eval(Container.DataItem,"document_id")%>'
                                                    document_name='<%# DataBinder.Eval(Container.DataItem,"document_name")%>' document_desc='<%# DataBinder.Eval(Container.DataItem,"document_desc")%>'
                                                    category='<%# DataBinder.Eval(Container.DataItem,"category")%>' file_path='<%# DataBinder.Eval(Container.DataItem,"file_path")%>' 
                                                    file_name='<%# DataBinder.Eval(Container.DataItem,"file_name")%>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="document_name" UniqueName="document_name"
                                            SortExpression="document_name" HeaderText="<%$Resources:Resource,  Document_Name%>">
                                            <ItemStyle CssClass="column" Width="300px" />
                                            <ItemTemplate>
                                                <asp:HyperLink ID="hlnkDocName" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"file_path")%>'
                                                    Text='<%# DataBinder.Eval(Container.DataItem,"document_name")%>' runat="server"
                                                    Target="_blank"></asp:HyperLink>
                                                <asp:Label ID="lblDocName" Text='<%# DataBinder.Eval(Container.DataItem,"document_name")%>'
                                                    CssClass="linkText" runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="document_desc" UniqueName="document_desc" HeaderText="<%$Resources:Resource,  Description%>">
                                            <ItemStyle CssClass="column" Width="250px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="category" UniqueName="category" HeaderText="<%$Resources:Resource,  Category%>">
                                            <ItemStyle CssClass="column" Width="250px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="document_id" UniqueName="document_id" HeaderText="<%$Resources:Resource,  File%>">
                                            <ItemStyle CssClass="column" Width="5%" />
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deleteDocument"
                                                    ImageUrl="~/App/Images/Delete.gif" Height="23px" OnClientClick="javascript:return deleteSystem();" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="left" id="tdProductDoc" style="text-align: left; vertical-align: top;"
                        runat="server">
                    </td>
                </tr>
                
                <telerik:RadWindowManager ID="rad_window" Visible="true" VisibleStatusbar="false"
                    Behaviors="Close" AutoSize="false" EnableShadow="false" ShowOnTopWhenMaximized="true"
                    runat="server" KeepInScreenBounds="true" VisibleTitlebar="true" Skin="Simple"
                    >
                    <Windows>
                        <telerik:RadWindow ID="rd_profile_popup" runat="server" Animation="Slide" BorderStyle="Solid"
                            BorderColor="Black" BorderWidth="2" KeepInScreenBounds="true" ReloadOnShow="false" 
                            AutoSize="false" Width="600" Height="300" VisibleStatusbar="false"
                            VisibleOnPageLoad="false" Behaviors="Move,Close">
                        </telerik:RadWindow>
                    </Windows>
                </telerik:RadWindowManager>
            </div>
        </table>
        <table id="tblAdd" runat="server">
            <tr id="tblAdddocument" runat="server" style="display: none">
                <td>
                    <table>
                        <tr>
                            <td colspan="2">
                                <h2>
                                    <asp:Label ID="lblrowname" runat="server"></asp:Label>
                                </h2>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Name<span id="spanName" runat="server" style="color: red"></span>:
                            </th>
                            <td align="left" style="width: 0px;">
                                <asp:TextBox ID="txtName" runat="server" CssClass="SmallTextBox" TabIndex="1"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="add" runat="server"
                                    ForeColor="Red" ControlToValidate="txtName" ErrorMessage="*"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Description:<span id="span3" runat="server" style="color: red"></span>
                            </th>
                            <td>
                                <asp:TextBox ID="txtdescription" runat="server" CssClass="SmallTextBox" TabIndex="1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Category<span id="span2" runat="server" style="color: red"></span>:
                            </th>
                            <td align="left">
                                <asp:Label ID="lblcategory" runat="server"></asp:Label>
                                <telerik:RadComboBox Width="180px" TabIndex="3" ErrorMessage="*" CausesValidation="true"
                                    Filter="Contains" MarkFirstMatch="true" Height="140px" ID="rcbcategory" ValidationGroup="add"
                                    runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="add" runat="server"
                                    ForeColor="Red" ControlToValidate="rcbcategory" InitialValue=" --Select--" ErrorMessage="*"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr style="height: 30px;">
                            <th>
                                <asp:Label runat="server" ID="UploadFileLabel">Upload File: </asp:Label> 
                            </th>
                            <td align="left">
                                <telerik:RadUpload TabIndex="6" EnableFileInputSkinning="false" ID="ruDocument" runat="server" 
                                    InitialFileInputsCount="1" OverwriteExistingFiles="false" ControlObjectsVisibility="none">
                                </telerik:RadUpload>
                                <asp:HiddenField ID="hfAttachedFile" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblError" CssClass="linkText" runat="server" Style="color: Red;"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style1">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="padding-top: 0px;" colspan="2">
                                <telerik:RadButton ID="BtnDocSave" ValidationGroup="add" runat="server" TabIndex="7" Text="Save Document"  AutoPostBack="True"
                                    OnClientClick="CloseWindow" OnClick="btnDocSave_Click" Width="100px" />&nbsp;&nbsp;
                                <telerik:RadButton ID="btnRadCancel" Skin="Default" runat="server" Text="Cancel"
                                    AutoPostBack="false" OnClientClicked="CloseWindow">
                                </telerik:RadButton>
                                <asp:HiddenField ID="hfrowname" runat="server" />
                                <asp:HiddenField ID="hfid" runat="server" />
                                <asp:HiddenField ID="hdfsheetname" runat="server" />
                                <asp:HiddenField ID="hfDocumentId" runat="server" />
                                <asp:HiddenField ID="hfproductId" runat="server" />
                                <br />
                                <asp:HiddenField ID="hfOrgId" runat="server" />
                            </td>
                        </tr>
                        <tr style="height: 20px;">
                            <td colspan="2">
                                <asp:Label ID="lblMsg" CssClass="linkText" runat="server" ForeColor="red"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table style="display: none;">
            <tr>
                <td>
                    <asp:Button runat="server" ID="btn_refresh_doc" OnClick="btn_refresh_doc_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgProductDoc">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProductDoc" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProductDoc" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_refresh_doc">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProductDoc" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgProductDoc">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rd_profile_popup" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
<style>
    .RadWindow_Simple
    {
        border: solid 0px #616161;
    }
</style>
</html>
