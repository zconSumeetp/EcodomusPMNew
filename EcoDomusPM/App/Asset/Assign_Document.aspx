<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Assign_Document.aspx.cs"    Inherits="App_Asset_Assign_Document" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %> 
<html  xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server"> 
    <title>Assign Document</title>
    
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript" language="javascript">
        function load_popup(reg) {
            var str = reg.pk_document_id;
            if (str == "00000000-0000-0000-0000-000000000000") {
                var url = "../Locations/AddDocument.aspx?Item_type=" + document.getElementById("hfEntity").value + "&fk_row_id=" + document.getElementById("hfAsset_id").value + "&Document_Id=" + reg.pk_document_id;
            }
            else {
                var url = "../Locations/AddDocument.aspx?Item_type=" + document.getElementById("hfEntity").value + "&fk_row_id=" + reg.fk_row_id + "&Document_Id=" + reg.pk_document_id;

            }
            manager = $find("<%= rad_window.ClientID %>");
            var windows = manager.get_windows();
            windows[0].show();
            windows[0].setUrl(url);
            //windows[0].set_modal(false);
            var obj = parent.window.frames[1];
            if (obj != null) {

                window.parent.resize_iframe(parent.window.frames[1]);

            }

            return false;
        }

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
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

        function delete_() {
            var flag;
            flag = confirm("Do you want to delete this document?");
            return flag;
        }

        function regreshgrid() {
            document.getElementById("btn_refresh").click();
        }

        function fn_Clear() {
            try {
                document.getElementById("txt_search").value = "";
                return false;
            }
            catch (e) {
                alert(e.message + "  " + e.Number);
                return false;
            }
        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }

        function GridCreated(sender, args) {
            //debugger;
            //alert(sender.get_masterTableView().get_pageSize());
            var pageSize = document.getElementById("hfAttributePMPageSize").value;
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

    </script>
    <script type="text/javascript" language="javascript">
        window.onload = body_load;

        function resize_Nice_Scroll() {

//         $(".divScroll").getNiceScroll().resize();
        }

        function body_load() {
                  
            if (document.getElementById("<%=txt_search.ClientID %>") != null)
                document.getElementById("<%=txt_search.ClientID %>").focus();
           
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

    </script>
     <%--<script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>--%>
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
     
    </style>
    <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />--%>
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
</head>
<body style="padding: 0px; background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); ">

    <form id="form1" runat="server" class="tdZebraLightGray" defaultfocus="txt_search">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="360000">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <telerik:RadFormDecorator ID="RadFormDecorator" runat="server" Skin="Default" DecoratedControls="Buttons" />
   <%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
  <div style="width:100%">
   
   
        <table style="width: 100%; table-layout:fixed;" align="left" border="0">
           <tr>
                <td>
                    <asp:Button ID="btn_document" Width="120px" runat="server" Text="<%$Resources:Resource, Add_Document%>"
                        pk_document_id='00000000-0000-0000-0000-000000000000' OnClientClick="javascript:return load_popup(this);" />
                </td>
            </tr>
            <tr> 
                <td  class="centerAlign" style="width:100%;">
                    <div class="rpbItemHeader">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                            <tr>
                                <td align="left" class="entityImage"   style="width: 50%;">
                                    <asp:Label runat="server" ID="lbl_grid_head" CssClass="gridHeadText" Width="200px" Text="<%$Resources:Resource, Document%>"
                                        ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                     >
                                    <div id="div_search" style="width: 200px; background-color: white;"  >
                                     <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnsearch"> 
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                        Height="100%" EmptyMessage="<%$Resources:Resource, Search%>" BorderColor="White" ID="txt_search" Width="180px">
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ClientIDMode="Static" ID="btnsearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                        OnClick="btn_Search" />
                                                </td>
                                            </tr>
                                        </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                                <td align="right" style="padding: 4px 6px 0 0;">
                                    <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                        ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContent" >
                        <telerik:RadGrid ID="rg_document" runat="server" AllowPaging="true" PageSize="10" BorderWidth="1px"
                            AutoGenerateColumns="false" Visible="false" AllowSorting="true" PagerStyle-AlwaysVisible="true"
                            Width="100%" OnItemCommand="rg_document_ItemCommand" Skin="Default" OnSortCommand="rg_document_OnSortCommand"
                            OnPageIndexChanged="rg_document_OnPageIndexChanged" OnPageSizeChanged="rg_document_OnPageSizeChanged"
                            ItemStyle-Wrap="false" OnPreRender="rg_document_OnPreRender">
                            <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400"  />
                            <ClientEvents OnGridCreated="GridCreated" />
                           </ClientSettings>
                            <MasterTableView DataKeyNames="document_id,fk_row_id" ClientDataKeyNames="document_id,fk_row_id">
                                 <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10"  />
                                    <AlternatingItemStyle Height="31px"  Font-Names="Arial" Font-Size="10" />
                                    <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                     <FooterStyle Height="25px" Font-Names="Arial"/>
                                  <Columns>
                                    <telerik:GridBoundColumn DataField="document_id" HeaderText="ID" Visible="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="document_id" HeaderText="<%$Resources:Resource, Edit%>">
                                        <ItemStyle CssClass="column" Width="3%" />
                                        <HeaderStyle CssClass="column" Width="3%" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnEdit" Visible="true" runat="server" AlternateText="Edit"  
                                                ImageUrl="~/App/Images/PencilIcon.gif" OnClientClick="javascript:return load_popup(this);"
                                                pk_document_id='<%# DataBinder.Eval(Container.DataItem,"document_id")%>' fk_row_id='<%# DataBinder.Eval(Container.DataItem,"fk_row_id")%>' />
                                            <%--<asp:LinkButton ID="lnkEdit" Visible="true" runat="server" CausesValidation="false" OnClientClick="javascript:return load_popup(this);"
                                         Text="Edit" pk_document_id='<%# DataBinder.Eval(Container.DataItem,"document_id")%>'>
                                    </asp:LinkButton>--%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <%--<telerik:GridEditCommandColumn HeaderStyle-Width="50px" ButtonType="ImageButton"
                                UniqueName="EditCommandColumn" ItemStyle-Width="5px">
                            </telerik:GridEditCommandColumn>--%>
                                    <telerik:GridTemplateColumn DataField="document_name" HeaderText="<%$Resources:Resource, Document_Name%>"
                                        SortExpression="document_name">
                                        <ItemStyle CssClass="column1" Width="50%" Wrap="false" />
                                        <HeaderStyle CssClass="column1" Width="50%" Wrap="false" />
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hlnkDocName" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"file_path")%>'
                                                Text='<%# DataBinder.Eval(Container.DataItem,"document_name")%>' runat="server"
                                                Target="_blank"></asp:HyperLink>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="document_Category" HeaderText=" <%$Resources:Resource, Category%>" Visible="true" UniqueName="typeCategory" >
                                    <ItemStyle Width="20%" Wrap="false" />
                                    <HeaderStyle Width="20%" Wrap="false" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="document_id" UniqueName="imgbtnDelete" HeaderText="<%$Resources:Resource, Delete%>">
                                         <ItemStyle CssClass="column1" Width="10%" Wrap="false" />
                                        <HeaderStyle CssClass="column1" Width="10%" Wrap="false" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="<%$Resources:Resource, Delete%>" Height="25px"
                                                CommandName="Delete_" ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return delete_()" />
                                            <asp:LinkButton ID="lnkDelete" Visible="false" runat="server" CausesValidation="false"
                                                CommandName="Delete_" Text='<%# Bind("document_id")%>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
           <tr>
          
           </tr>
            
            <tr>
                <td>
                    <asp:HiddenField ID="hfAsset_id" runat="server" />
                    <asp:HiddenField ID="hfEntity" runat="server" />
                    <asp:HiddenField ID="hfrow_id" runat="server" />
                    <asp:HiddenField ID="hfDocument_id" runat="server" />
                     <asp:HiddenField ID="hfAttributePMPageSize" runat="server" />
                </td>
            </tr>
            <tr>
            <td>
            <telerik:RadWindowManager Visible="true" ID="rad_window" runat="server"  VisibleTitlebar="true"  Title="<%$Resources:Resource,Upload_Document%>" Behaviors="Close,Move" 
                    BorderWidth="0px"  Skin="Simple" BorderStyle="None">
                <Windows>
                    <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" Animation="Slide" BorderStyle="Solid" BorderColor="Black" BorderWidth=""
                        KeepInScreenBounds="true" ReloadOnShow="false" Top="20px" Left="180px" 
                        AutoSize="false" Width="600" Height="300" VisibleStatusbar="false" VisibleOnPageLoad="false"
                     >
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
             <div id="divbtn" style="display: none;">
        <asp:Button ID="btn_refresh" runat="server" Style="display: none;" OnClick="btn_refresh_Click" />
    </div>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnsearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_document" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
         <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_document">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_document" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    </td>
    </tr>
        </table>
      
   
   </div>
   
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
