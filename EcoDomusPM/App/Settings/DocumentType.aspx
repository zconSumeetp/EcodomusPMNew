<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocumentType.aspx.cs" Inherits="App_Settings_DocumentType" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head id="Head1" runat="server">
    <title></title>
    <script language="javascript" type="text/javascript">

        function resize_Nice_Scroll() {

            // $(".divScroll").getNiceScroll().resize();
        }

        function body_load() {
            $("html").css('overflow-y', 'hidden');
            $("html").css('overflow-x', 'auto');

            var screenhtg = parseInt(window.screen.height * 0.65);
            document.getElementById("divSelectedDomponentContent").style.height = screenhtg * 0.69;
            $(".divScroll").niceScroll({ touchbehavior: false, cursorcolor: "#969696", cursoropacitymax: 0.8, cursorborder: "none", cursorwidth: 08, background: "#cccccc", overflow: "hidden" });
            $("#divSelectedDomponentContent").show();

        }
        //window.onload = body_load;

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
      <script type="text/javascript">
          function confirmation() {
              var flag;
              flag = confirm("Are you sure you want to delete this document Type?");
              if (flag)
                  return true;
              else
                  return false;
          }

          function AlertExistDocument() {
              alert('Phase name already exists..');
          }
          function stopPropagation(e) {

              e.cancelBubble = true;

              if (e.stopPropagation)
                  e.stopPropagation();
          }

          //This Function set scroll Height to fix when docheight is less than scrollHeight
          function GridCreated(sender, args) {

              var pageSize = document.getElementById("hfDocumentPMPageSize").value;
              var scrollArea = sender.GridDataDiv;
              var dataHeight = sender.get_masterTableView().get_element().clientHeight;
              if (!flag) {
                  if (dataHeight < parseInt(pageSize) * 40) {
                      scrollArea.style.height = dataHeight + "px";
                  }
                  else {
                      scrollArea.style.height = (parseInt(11) * 40 - 13) + "px";
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
    
    <style type="text/css">
        .rtWrapperContent
        {
            padding: 10px !important;
            color: Black !important;
        }
          div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
        .rpbItemHeader
             {
            background-color:#808080;
             }
             .divProperties
                {
                    background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
                }
                html
                {
                    overflow:hidden;
                }
    </style>
    <script src="../../App_Themes/EcoDomus/jquery-1.8.3.js" type="text/javascript"></script>

    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
</head>
<body style="background:#F7F7F7; padding: 0px;">
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" >
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
     <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <table style="width: 100%;table-layout:fixed;">
        <tr>
            <td class="centerAlign" style="width: 100%">
                <div class="rpbItemHeader ">
                    <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                        <tr>
                            <td align="left" class="entityImage">
                                <asp:Label runat="server" Text="<%$Resources:Resource,Document_Type%>" ID="lbl_grid_head"
                                    CssClass="gridHeadText" Width="100%" ForeColor="#F8F8F8" Font-Names="Arial"
                                    Font-Size="12"></asp:Label>
                            </td>
                            <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;">
                                <div id="div1" style="width: 200px; background-color: white;">
                                    <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch">
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="180px">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ClientIDMode="Static" ID="btnSearch" Height="13px" runat="server"
                                                        ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnSearch_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
                            </td>
                            <td align="right" style="padding: 4px 6px 0 0; width: 20px">
                                <%--  <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)"  />--%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divSelectedDomponentContent">
                    <telerik:RadGrid Width="100%" ID="rgDocumentType" runat="server" BorderWidth="1px"
                        CellPadding="0" AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True"
                        GridLines="None" PageSize="10" ItemStyle-Wrap="false" PagerStyle-AlwaysVisible="true"
                        OnNeedDataSource="rgDocumentType_OnNeedDataSource" 
                        OnItemCommand="rgDocumentType_ItemCommand" 
                        onitemcreated="rgDocumentType_ItemCreated" 
                        onitemdatabound="rgDocumentType_ItemDataBound">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="true" />
                         <ClientSettings  EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                 <Selecting AllowRowSelect="true"/>
                                <ClientEvents OnGridCreated="GridCreated" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="400px" />
                            </ClientSettings>
                            <MasterTableView CommandItemDisplay="Top" CommandItemSettings-AddNewRecordText="<%$Resources:Resource,Add_New%>" CommandItemSettings-ShowRefreshButton="false" DataKeyNames="pk_document_type_id" HeaderStyle-CssClass="gridHeaderTextMedium">
                                <%--<ItemStyle Height="31px" Font-Names="Arial" Font-Size="10"  />
                                <AlternatingItemStyle Height="31px"  Font-Names="Arial" Font-Size="10" />--%>
                                 <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                <FooterStyle Height="25px" Font-Names="Arial"/>
                                <Columns>
                                    <telerik:GridBoundColumn DataField="document_type_name" HeaderText="<%$Resources:Resource,Document_type%>"
                                    UniqueName="document_type_name" EditFormColumnIndex="0" >
                                        <ItemStyle CssClass="" Font-Underline="True" Width="80%" />
                                        <HeaderStyle CssClass="" Font-Underline="True" Width="80%" />
                                    </telerik:GridBoundColumn>
                                    
                                    
                                    <telerik:GridTemplateColumn UniqueName="deleteColumn" HeaderText="<%$Resources:Resource,Delete%>">
                                         <ItemStyle CssClass="" Wrap="false" Width="10%" />
                                         <HeaderStyle CssClass="" Wrap="false" Width="10%" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnRemove" runat="server" CommandName="Delete" alt="Delete"
                                            Height="25px" OnClientClick="return confirmation();" ImageUrl="~/App/Images/Delete.gif" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                 <EditFormSettings ColumnNumber="3" EditFormType="AutoGenerated" InsertCaption="Add New:"  CaptionFormatString="Edit:">
                                     <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                    <FormCaptionStyle CssClass=""></FormCaptionStyle>
                                    <FormMainTableStyle GridLines="None" BackColor="White" Width="100%" />
                                    <FormTableStyle BackColor="White" Height="50px" />
                                    
                                    <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                                    <EditColumn ButtonType="ImageButton" UpdateText="Update record" UniqueName="EditCommandColumn1"
                                        CancelText="Cancel" UpdateImageUrl="~/App/Images/sign1.jpg">
                                    </EditColumn>
                                    <EditColumn ButtonType="ImageButton" InsertText="Insert Record"  UniqueName="EditColumnInsertColum2"
                                        CancelText="Cancel" >
                                    </EditColumn>
                                    <EditColumn UniqueName="EditColumn">
                                    </EditColumn>
                                    <FormTableButtonRowStyle HorizontalAlign="Right" CssClass=""></FormTableButtonRowStyle>
                                </EditFormSettings>
                            </MasterTableView>



                        <%--<ClientSettings>
                            <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="pk_document_type_id" HeaderStyle-CssClass="gridHeaderTextMedium">
                            <Columns>
                                <telerik:GridBoundColumn DataField="document_type_name" HeaderText="<%$Resources:Resource,Document_type%>"
                                    UniqueName="document_type_name" SortExpression="document_type_name">
                                    <ItemStyle CssClass="column"></ItemStyle>
                                    <HeaderStyle ForeColor="GrayText" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn UniqueName="deleteColumn" HeaderText="<%$Resources:Resource,Delete%>">
                                    <HeaderStyle ForeColor="GrayText" Width="10%" />
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnRemove" runat="server" CommandName="Delete" alt="Delete"
                                            Height="17px" OnClientClick="return confirmation();" ImageUrl="~/App/Images/Delete.gif" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>--%>
                    </telerik:RadGrid>
                </div>
            </td>
        </tr>
        <tr>
            <td style="">
            <asp:HiddenField ID="hfDocumentPMPageSize"  runat="server" Value="" />
                <table style="width: 100%">
                    <tr id="trAddDocumentType" style="display: none;" runat="server">
                        <td>
                            <telerik:RadButton ID="btnAddDocumentType" runat="server" Text="<%$Resources:Resource,Add%>"
                                Width="90px" OnClick="btnAddDocumentType_OnClick" />
                        </td>
                    </tr>
                    <tr id="trSaveDocumentType" runat="server" style="display: none;">
                        <td>
                            <table>
                                <tr>
                                    <td valign="top">
                                        <asp:Label ID="lbl" runat="server" Text=' <%$Resources:Resource,Document_Type%>'></asp:Label>:
                                    </td>
                                    <td valign="top">
                                        <telerik:RadTextBox runat="server" ID="txtDocumentTypeName" Width="150px">
                                        </telerik:RadTextBox>
                                        
                                    </td>
                                    <td><asp:RequiredFieldValidator ID="req1" runat="server" ControlToValidate="txtDocumentTypeName"
                                            ErrorMessage="*" ForeColor="Red" ValidationGroup="saveDocumentType"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td style="padding-top: 2px;">
                                        <telerik:RadButton ID="btnSaveDocumentType" runat="server" Text="<%$Resources:Resource,Save%>"
                                            Width="90px" OnClick="btnSaveDocumentType_Click" ValidationGroup="saveDocumentType" />
                                    </td>
                                    <td style="padding-top: 2px;">
                                        <telerik:RadButton ID="btnCancleDocumentType" runat="server" Text="<%$Resources:Resource,Cancel%>"
                                            Width="90px" OnClick="btnCancleDocumentType_OnClick" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblMsg" runat="server"></asp:Label>
                                 </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
    </table>
    
    <telerik:RadAjaxManager ID="DocumentTypeProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgDocumentType">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl LoadingPanelID="loadingPanel1" ControlID="rgDocumentType" />
                </UpdatedControls>
            </telerik:AjaxSetting>
              <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl LoadingPanelID="loadingPanel1" ControlID="rgDocumentType" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" Skin="Default" runat="server" Height="75px" Width="75px">
        <%--<img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />--%>
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" DecoratedControls="Buttons" />
    </form>
</body>
</html>
