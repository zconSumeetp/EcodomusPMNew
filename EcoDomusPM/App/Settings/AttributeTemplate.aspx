<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="AttributeTemplate.aspx.cs" Inherits="App_Settings_AttributeTemplate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %> 
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
      <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">       
        <script language="javascript" type="text/javascript">

            function deleteItem() {
                var flag;
                flag = confirm("Are you sure you want to delete this Template?");
                return flag;
            }

            function Clear() {

                try {
                    document.getElementById("ContentPlaceHolder1_txt_search").value = "";
                    if (document.getElementById("<%=txt_search.ClientID %>") != null)
                        document.getElementById("<%=txt_search.ClientID %>").focus();
                    return false;
                }
                catch (e) {
                    alert(e.message + "  " + e.Number);
                    return false;
                }
            }


            function validate() {
                alert("Template with this name already exists.");
                return false;
            }
            function Hidetable() {
                //debugger
                document.getElementById("ContentPlaceHolder1_tradd").style.display = "none";
                //document.getElementById("ContentPlaceHolder1_btnAddTemplate").style.display = "inline";
                return false;

            }
            function openaddtemplatepopup() {

                var url = "../Settings/AddTemplate.aspx?templateId="; //?templateId=" + templateId + "&entity_id=" + entity_id + "&Name=" + reg.omniclassname + "&omniclass_detail_id=" + s;
                manager = $find("<%=rg_manager_add_attribute.ClientID %>");
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                    // windows[2].set_modal(false);
                }
                return false;

            }
            function openAttributeTemplate(reg) {


                //var template_id = document.getElementById('hftemplateid').value;
                var url = "../Settings/AddTemplate.aspx?templateId=" + reg.template_id + "&flag=" + reg.global_flag;
                manager = $find("<%=rg_manager_add_attribute.ClientID %>");
                if (manager != null) {
                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();


                }
                return false;
            }

            function refreshgrid() {
                document.getElementById("ContentPlaceHolder1_btnRefresh").click();



            }

            function ProjectValidation() {

                alert('Please select Project');
                window.location = '../Settings/Project.aspx';
                return false;


            }

            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }
        </script>
    </telerik:RadCodeBlock>

     <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
    <script type="text/javascript" language="javascript">
        window.onload = body_load;
        function resize_Nice_Scroll() {

          
            if (document.getElementById("<%=txt_search.ClientID %>") != null)
                document.getElementById("<%=txt_search.ClientID %>").focus();
        }

        function body_load() {
            var screenhtg = set_NiceScrollToPanel();
             if (document.getElementById("<%=txt_search.ClientID %>") != null)
                document.getElementById("<%=txt_search.ClientID %>").focus();
            //var screenhtg = parseInt(window.screen.height * 0.65);
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

        function divSelectedDomponentContent_onmouseover() {
            resize_Nice_Scroll();
        }
        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {
            //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
            var pageSize = document.getElementById("ContentPlaceHolder1_hfUserPMPageSize").value;
            var scrollArea = sender.GridDataDiv;
            var dataHeight = sender.get_masterTableView().get_element().clientHeight;
            //sender.get_masterTableView().set_pageSize(pageSize);
            if (dataHeight < parseInt(pageSize) * 40) {
                scrollArea.style.height = dataHeight + "px";
            }
            else {
                scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
            }

        }
    </script>
    </telerik:RadCodeBlock>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
   
   <style>
             .divProperties
        {
            background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
        }
        .rpbItemHeader
        {
            background-color:#808080;
        }
            
    </style>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
   
    <div style="width: 100%;">
        <table align="left" border="0" width="100%" cellpadding="0" cellspacing="0" style="table-layout: fixed;">
           <tr>
                <td class="centerAlign">
                    <asp:Button ID="btnAddTemplate" runat="server" Text="<%$Resources:Resource,Add_Template%>"
                        OnClick="btnAddTemplate_OnClick" OnClientClick="javascript:return openaddtemplatepopup();" />
                    <asp:HiddenField ID="hftemplateid" runat="server" />
                     <asp:HiddenField ID="hfUserPMPageSize" runat="server" Value="" />
                </td>
            </tr>
            <tr align="center">
                <td align="right" class="centerAlign" style="width: 100%;">
                    <div class="rpbItemHeader">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                                                      <tr>
                                <td align="left" class="entityImage" style="width: 50%;">
                                    <asp:Label runat="server" Text="<%$Resources:Resource, Attribute_Template%>" ID="lbl_grid_head"
                                        CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Font-Names="Arial"
                                        Font-Size="12"></asp:Label>
                                </td>
                                <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;">
                                    <div id="div_search" style="width: 200px; background-color: white;">
                                        <asp:Panel runat="server" ID="panal1" DefaultButton="btnSearch">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                            Height="100%" EmptyMessage="Search" BorderColor="White" ID="txt_search" Width="180px">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ClientIDMode="Static" ID="btnSearch" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                            OnClick="btn_search_click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                                <td align="right" style="padding: 4px 6px 0 0;">
                                    <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divSelectedDomponentContentV1">
                        <telerik:RadGrid ID="rgRequiredAttriTemplate" runat="server" AllowPaging="True" AllowSorting="True"
                            BorderWidth="1px" AutoGenerateColumns="False" GridLines="None" Skin="Default"
                            OnPageIndexChanged="rgRequiredAttriTemplate_OnPageIndexChanged" OnPageSizeChanged="rgRequiredAttriTemplate_OnPageSizeChanged"
                            OnSortCommand="rgRequiredAttriTemplate_OnSortCommand" CellPadding="0" PagerStyle-AlwaysVisible="true"
                            OnItemDataBound="rgRequiredAttriTemplate_ItemDataBound" OnItemCommand="rgRequiredAttriTemplate_OnItemCommand">
                            <PagerStyle AlwaysVisible="True" HorizontalAlign="Right"></PagerStyle>
                            <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                            <Selecting AllowRowSelect="true" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                                <ClientEvents OnGridCreated="GridCreated" />
                            </ClientSettings>
                            <MasterTableView DataKeyNames="pk_attribute_template_id,template_name">
                            <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                                <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                                <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                <FooterStyle Height="25px" Font-Names="Arial" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="pk_attribute_template_id,global_flag" SortExpression="pk_attribute_template_id,global_flag"
                                        UniqueName="pk_attribute_template_id" Visible="false">
                                        <ItemStyle />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="template_name" HeaderText="<%$Resources:Resource,Name%>"
                                        UniqueName="template_name" SortExpression="template_name">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkName" runat="server" Text='<%# Bind("template_name") %>' CommandName="selecttemplate"> 
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="70%" Wrap="false" />
                                        <HeaderStyle Wrap="false" Width="70%" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="global_flag" Visible="false" HeaderText="global_flag"
                                        UniqueName="global_flag">
                                        <ItemStyle CssClass="column" Width="3%"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="pk_attribute_template_id" HeaderText="<%$resources:resource,edit%>"
                                        UniqueName="pk_attribute_template_id">
                                        <ItemStyle Wrap="false"  Width="10%" />
                                         <HeaderStyle Wrap="false" Width="10%" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkedit" runat="server" CausesValidation="false" CommandName="Edit_"
                                                OnClientClick="javascript:return openAttributeTemplate(this);" Text="<%$resources:resource,edit%>"
                                                template_id='<%# DataBinder.Eval(Container.DataItem,"pk_attribute_template_id")%>'
                                                global_flag='<%# DataBinder.Eval(Container.DataItem,"global_flag")%>'>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <%--   <telerik:gridtemplatecolumn datafield="pk_attribute_template_id" headertext="<%$resources:resource,edit%>"
                                    uniquename="pk_attribute_template_id" >
                                    <itemstyle cssclass="column" width="2%" />
                                    <itemtemplate>
                                        <asp:hyperlink id="rg_lh_attribute" text="<%$resources:resource,edit%>" 
                                            onclick="javascript:return test();" runat="server" navigateurl="#"
                                            ></asp:hyperlink>
                                    </itemtemplate>
                                </telerik:gridtemplatecolumn>--%>
                                    <telerik:GridTemplateColumn DataField="pk_attribute_template_id" HeaderText="<%$Resources:Resource,Clone%>"
                                        UniqueName="pk_attribute_template_id" AutoPostBackOnFilter="true">
                                        <ItemStyle CssClass="column" Width="10%" />
                                        <HeaderStyle Wrap="false" Width="10%" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnClone" runat="server" alt="Clone" CommandName="clonetemplate"
                                                ImageUrl="~/App/Images/clone.gif" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="pk_required_attribute_template_id" HeaderText="<%$Resources:Resource,Delete%>"
                                        UniqueName="pk_required_attribute_template_id">
                                        <ItemStyle CssClass="column" Width="10%" />
                                        <HeaderStyle Wrap="false" Width="10%" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CausesValidation="false"
                                                CommandName="delete" OnClientClick="javascript:return deleteItem();" ImageUrl="~/App/Images/Delete.gif" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
             </table>
           <table style="display:none">
            <%--<tr>
                <td height="1px" style="background-color: Orange; border-collapse: collapse; width: 70%">
                </td>
            </tr>--%>
             <tr>
                <td style="height: 20px">
                    <div style="display: none;">
                        <asp:Button ID="btnRefresh" Style="display: none" runat="server" Text="Refresh" OnClick="btnRefresh_Click" />
                    </div>
                </td>
            </tr>
            
            <tr>
                <td>
                    <asp:Label runat="server" ID="lblErrMsg" Style="color: Red; font-size: 11px;"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 10px">
                </td>
            </tr>
            <tr runat="server" id="tradd">
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_add" Text="<%$Resources:Resource,Add_Template%>" CssClass="Label"
                                    ForeColor="#990000" runat="server"></asp:Label>
                            </td>
                            <%--<td style="color: Red; font-weight: bold;">
                                Add Template
                            </td>--%>
                        </tr>
                        <tr>
                            <td style="height: 5px">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_name" Text="<%$Resources:Resource,Name%>" ForeColor="#990000"
                                    CssClass="Label" runat="server">:</asp:Label>: &nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="txtName" runat="server" CssClass="SmallTextBox">
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="Reaquirefield1" runat="server" ControlToValidate="txtName"
                                    ForeColor="Red" ErrorMessage="*" Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 20px">
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 50px">
                                <asp:Button ID="btnSave" runat="server" Text="<%$Resources:Resource,Save%>" OnClick="btnSave_Click"
                                    Width="100px" />&nbsp;&nbsp;
                                <asp:Button ID="btnCancel" runat="server" Text="<%$Resources:Resource,Cancel%>" OnClick="btnCancel_OnClick"
                                    CausesValidation="false" Width="100px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgRequiredAttriTemplate" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgRequiredAttriTemplate" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="rgRequiredAttriTemplate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgRequiredAttriTemplate" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="rad_window" VisibleStatusbar="false" AutoSize="false"
        EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server" KeepInScreenBounds="true"
        Width="600px">
        <Windows>
            <telerik:RadWindow ID="rad_AddEditRequiredAttribute" Width="450px" Height="400px"
                Behaviors="Move,Resize,close" Skin="Default" runat="server" KeepInScreenBounds="true"
                DestroyOnClose="true" ReloadOnShow="false" VisibleTitlebar="true" Title="EcoDomusPM: Add Template"
                VisibleStatusbar="false" VisibleOnPageLoad="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
     <telerik:RadWindowManager ID="rg_manager_add_attribute" runat="server" VisibleTitlebar="true" Title="<%$Resources:Resource, Attribute_Template%>" Behaviors="Close,Move"  
        BorderWidth="0px"  Skin="Simple" BorderStyle="None" >
        <Windows>
            <telerik:RadWindow ID="rdw_attribute" runat="server" ReloadOnShow="false" Width="580"
                AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false" OffsetElementID="btn_search"
                VisibleStatusbar="false" VisibleOnPageLoad="false" EnableAjaxSkinRendering="false" EnableShadow="true" BackColor="Black" Overlay="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
  
</asp:Content>
