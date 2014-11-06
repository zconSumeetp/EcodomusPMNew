<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Product.aspx.cs" Inherits="App_Central_Product" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <telerik:RadCodeBlock runat="server" ID ="radCode1">
    <script language="javascript" type="text/javascript">
        function body_load() {
            $("html").css('overflow-y', 'hidden');
             $("html").css('overflow-x', 'auto');

            var screenhtg = parseInt(window.screen.height * 0.66);   
           
            $(".divScroll").niceScroll({ touchbehavior: false, cursorcolor: "#969696", cursoropacitymax: 0.8, cursorborder: "none", cursorwidth: 08, background: "#cccccc", overflow: "hidden" });
            $("#divSelectedDomponentContent").show(); 

        }
        function resize_Nice_Scroll() {

            $(".divScroll").getNiceScroll().resize();
        } 

        window.onload = body_load;

        function Product_profile(reg) {

            var ProductId = reg.pk_product_id;
            top.location.href = "SettingsMenu.aspx?ProductId=" + ProductId + "&organization_id=" + parent.document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&IsfromClient=" + parent.document.getElementById("ContentPlaceHolder1_HiddenField1").value + "&IsFromProduct=" + document.getElementById("hfIsFromProduct").value + "";
            return false;
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

        function deleteProduct() {
            var flag;
            flag = confirm("Do you want to delete this product?");
            return flag;
        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }

        function stopPropagation(e) {

            e.cancelBubble = true;

            if (e.stopPropagation)
                e.stopPropagation();
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
       <script src="../../App_Themes/EcoDomus/jquery-1.8.3.js" type="text/javascript"></script>
          </telerik:RadCodeBlock>
    <style type="text/css">
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
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
</head>
<body style="background-position: white; background: white; padding: 0px; margin: 0px 0px 0px 0px;">
    <form id="form1" runat="server" style="margin: 0px 0px 0px 0px;" defaultfocus="txtSearch">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" >
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
        </Scripts>
    </telerik:RadScriptManager>
    
   <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>

    <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <asp:Panel ID="aspPanel" runat="server">
        <table width="95%" style="table-layout:fixed;" >
         <tr id="trbtnAddProduct" runat="server">
                <td>
                   <div style="height:10px"></div> 
                    <asp:Button ID="btnAddProduct" runat="server" Text="<%$Resources:Resource, Add_Product%>"
                        OnClick="btnAddProduct_Click" Width="150px" />
                </td>
            </tr>
            <tr>
                <td style="width:100%;">
                    <div class="rpbItemHeader divBorder">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color:#808080;">
                        <tr>
                        <td align="center">
                                                        <asp:Label ID="lblMsg" runat="server" ForeColor="red" Font-Size="Medium"></asp:Label>
                         </td>
                            <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width:35%;">
                                 <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Manufacturer%>" CssClass="gridHeadText"></asp:Label><asp:Label ID="lbl11" Text=":" CssClass="gridHeadText" runat="server"></asp:Label>
                                 <asp:Label ID="lbltitleOrg" runat="server" CssClass="gridHeadText"></asp:Label>
                            </td>
                             <td align="right" style=" background-color:#808080;padding-top: 02px; padding-bottom: 02px;" onclick="stopPropagation(event)">
                                <div id="div1" style="width: 200px; background-color: white;" onclick="stopPropagation(event)">
                                    
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
                                    </div>
                            </td>
                           
                             <td align="right" style="padding: 4px 4px 0 0 ; width:40px">
                                   <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)"  />
                       
                            </td>
                            </tr>
                            </table>
                    </div>

                      <div id="divSelectedDomponentContent" class="divProperties divScroll divBorder RightMenu_1_Content" style="background:#cccccc;">
                        <telerik:RadGrid ID="rgProducts" runat="server"   Width="100%" AllowPaging="True" BorderWidth="0px"
                                            Skin="Default" AutoGenerateColumns="False" AllowSorting="True" PagerStyle-AlwaysVisible="true"
                                            OnPageIndexChanged="rgProducts_OnPageIndexChanged" OnPageSizeChanged="rgProducts_OnPageSizeChanged"
                                            OnSortCommand="rgProducts_onSortCommand" GridLines="None" OnItemCommand="rgProduct_ItemCommand">
                                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="left" />
                                            <ClientSettings>
                                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"     ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                           </ClientSettings>
                                            <MasterTableView DataKeyNames="pk_product_id">
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="pk_product_id" Visible="false">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn DataField="model_number" HeaderText="<%$Resources:Resource, Model_Number%>"
                                                        SortExpression="model_number">
                                                        <ItemStyle CssClass="column" Font-Size="11px"></ItemStyle>
                                                        <ItemTemplate>
                                                            <asp:LinkButton ButtonType="LinkButton" ID="lnkbtnProducts" runat="server" alt="Edit"
                                                                CausesValidation="false" Text='<%# DataBinder.Eval(Container.DataItem,"model_number")%>'
                                                                CommandName="Edit_Product" pk_product_id='<%# DataBinder.Eval(Container.DataItem,"pk_product_id")%>'
                                                                PostBackUrl="#" OnClientClick="javascript:return Product_profile(this);" />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="short_name" HeaderText="<%$Resources:Resource, Product_Name%>">
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle CssClass="column" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource, Description%>">
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle CssClass="column" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn DataField="pk_product_id" UniqueName="pk_product_id"
                                                        HeaderText="<%$Resources:Resource, Delete%>">
                                                        <ItemStyle CssClass="column" Width="5px" />
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" product_id='<%# DataBinder.Eval(Container.DataItem,"pk_product_id")%>'
                                                                OnClientClick="javascript:return deleteProduct(this);" CommandName="deleteProduct"
                                                                ImageUrl="~/App/Images/Delete.gif" Height="20px"/>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                            <ClientSettings>
                                                <Resizing AllowColumnResize="false" />
                                            </ClientSettings>
                                        </telerik:RadGrid>
                      </div>

                        
                   
                </td>
            </tr>
           
        </table>
        <div>
            <asp:HiddenField ID="hfIsFromProduct" runat="server" />
        </div>
    </asp:Panel>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgProducts">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProducts" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProducts" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
