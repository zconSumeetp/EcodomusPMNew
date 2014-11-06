<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddModelNumber.aspx.cs" Inherits="App_Asset_AddModelNumber" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--<title>Add Model Number</title>--%>
    <script type="text/javascript" language="javascript">
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        function GetSelectedItems() {
                var item_length=  $find("<%= rgProducts.MasterTableView.ClientID %>").get_selectedItems().length;
                if(item_length>0)
                {
                    return true;
                }
                else
                {
                    alert("Please select product!");
                    return false;
                }
            }
        
        function Clear() {
                document.getElementById("txtSearch").value = "";
                return false;
            }
        
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog      
            else if (window.frameElement != null) {
                if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow; //IE (and Moz as well)      
            }
            return oWindow;
        }

        function Close() {
            GetRadWindow().Close();
              window.parent.resizeParentPopupReversBack();
        }

         function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

             function CloseWindow1() {

       // GetRadWindow().BrowserWindow.referesh_project_page();
        GetRadWindow().close();
        //top.location.reload();
        //GetRadWindow().BrowserWindow.adjust_parent_height();
        window.parent.resizeParentPopupReversBack();
        return false;
    }
    function CancelWindow() {
        CloseWindow1();
    }
        function AssignProductAttributesToType()
        {
            window.parent.document.getElementById("txtDescription").value = document.getElementById('hfDescription').value;
            window.parent.document.getElementById("lblmanufacturer").innerText = document.getElementById('hfManufacturerName').value;
            window.parent.document.getElementById("hfManufacturerName").innerText = document.getElementById('hfManufacturerName').value;
//            window.parent.document.getElementById("lnkManufacturer").innerText = document.getElementById('hfManufacturerName').value;
            window.parent.document.getElementById("hf_man_org_id").value = document.getElementById('hfManufacturerId').value;
            window.parent.document.getElementById("hfUniFormatId").value = document.getElementById('hfUniFormatId').value;
//            window.parent.document.getElementById("lblUniFormat").innerText = document.getElementById('hfUniFormat').value;
            window.parent.document.getElementById("txtPartNumber").value = document.getElementById('hfPartNumber').value;
            window.parent.document.getElementById("txtExpectedLife").value = document.getElementById('hfExpectedLife').value;
            window.parent.document.getElementById("hfWarrantyDurationUnit").innerText = document.getElementById('hfWarrantyDurationUnit').value;
//            window.parent.document.getElementById("lblWarrantyDurationUnit").innerText = document.getElementById('').value;
            window.parent.document.getElementById("txtReplacementCost").value = document.getElementById('hfReplacementCost').value;
            window.parent.document.getElementById("txtWarrantyDescription").value = document.getElementById('hfWarrantyDescription').value;
            window.parent.document.getElementById("hfWarrantyGuarantorLaborId").innerText = document.getElementById('hfWarrantyGuarantorLaborId').value;
            window.parent.document.getElementById("lblOmniClass").style.display = "block";
            window.parent.document.getElementById("lblOmniClass").innerText = document.getElementById('hfOmniClassName').value;
            
            window.parent.document.getElementById("hfOmniClassName").innerText=document.getElementById('hfOmniClassName').value;
            window.parent.document.getElementById("hf_lblOmniClassid").innerText = document.getElementById('hfOmniClassId').value;
//            window.parent.document.getElementById("lblAssetType").innerText = document.getElementById('hfAssetType').value;
            window.parent.document.getElementById("hfAssetTypeId").innerText = document.getElementById('hfAssetTypeId').value;
            window.parent.document.getElementById("txtModelNumber").value = document.getElementById('hfModelNumber').value;
            window.parent.document.getElementById("txtWarrantyDurationPart").value = document.getElementById('hfWarrantyDurationParts').value;
            window.parent.document.getElementById("hfWarrantyGuarantorPartsName").innerText = document.getElementById('hfWarrantyGuarantorParts').value;
            window.parent.document.getElementById("hfWarrantyGuarantorPartsId").innerText = document.getElementById('hfWarrantyGuarantorPartsId').value;
            window.parent.document.getElementById("txtWarrantyDurationLabor").value = document.getElementById('hfWarrantyDurationLabor').value;
            window.parent.document.getElementById("hfWarrantyGuarantorLaborName").innerText = document.getElementById('hfWarrantyGuarantorLabor').value;
            window.parent.document.getElementById("hfProductId").innerText = document.getElementById('hfProductId').value;
            window.parent.document.getElementById("hfProductAssigned").innerText = "Y";
            window.parent.product_info();
            Close();
              window.parent.resizeParentPopupReversBack();

        }
        
        </telerik:RadCodeBlock>
    </script>
    <style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
    </style>
   
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
</head>
<body style="background:white;background-color: #EEEEEE; padding:0px;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Default"
        DecoratedControls="Buttons" />
   <div style="width:100%; overflow:hidden;">
        
    <table border="0"  width="100%" style="">
        <%--<tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
                    <tr>
                        <td class="wizardHeadImage">
                            <div class="wizardLeftImage">
                                <asp:Label ID="Label1" Text="Products" Style="padding-left: 0px;font-size:medium;" runat="server"></asp:Label>
                            </div>
                            <div class="wizardRightImage">
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                    OnClientClick="javascript:return CancelWindow();" />
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>--%>
       
        <tr >
            <td align="center" style="padding-left:10px;padding-right:10px;">
            <table style="width:100%;">
                <tr>
                 <td>
                    <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" BorderWidth="0"
                    ExpandMode="MultipleExpandedItems" BorderColor="Transparent">
                    <ExpandAnimation Type="OutSine" />
                    <Items>
                        <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                            BorderWidth="0" BorderColor="Transparent">
                             <HeaderTemplate>
                                                <asp:Panel ID="pnl_job" runat="server" DefaultButton="btn_search" BorderWidth="0"
                                                    Width="100%" BorderColor="Transparent">
                                                    <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                                        <tr>
                                                            <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                                <asp:Label runat="server" Text="<%$Resources:Resource, Product%>" ID="lbl_grid_head"
                                                                    CssClass="gridHeadText" Width="200px" ForeColor="#F8F8F8" Font-Names="Arial"
                                                                    Font-Size="12"></asp:Label>
                                                            </td>
                                                            <td align="right" onclick="stopPropagation(event)">
                                                                <div id="div_search" style="background-color: White; width: 170px;" onclick="stopPropagation(event)">
                                                                    <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                                        width: 100%;">
                                                                        <tr style="border-spacing=0px;">
                                                                            <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                                                padding-bottom: 0px;">
                                                                                <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                                    Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="100%">
                                                                                </telerik:RadTextBox>
                                                                            </td>
                                                                            <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                                                padding-bottom: 0px;">
                                                                                <asp:ImageButton ClientIDMode="Static" OnClick="btnSearch_Click" ID="btn_search"
                                                                                    Height="13px" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png"
                                                                                    Style="width: 13px" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                            <td align="right" class="dropDownImage" style="padding:6px;"  onclick="stopPropagation(event)">
                                                               <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" 
                                                                    ID="img_arrow" />--%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                  <table id="tbl_jobs1" runat="server" cellpadding="0" cellspacing="0" width="100%"
                                                style="background-color: #707070; border-width: 0px;">
                                                <tr>
                                                    <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </HeaderTemplate>
                            <ContentTemplate>
                           <telerik:RadGrid ID="rgProducts" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                                    AllowSorting="true" OnSortCommand="rgProducts_OnSortCommand" OnPageIndexChanged="rgProducts_OnPageIndexChanged"
                                    OnPageSizeChanged="rgProducts_OnPageSizeChanged" OnItemCommand="rgProducts_OnItemCommand"
                                    Skin="Default" PagerStyle-AlwaysVisible="true">
                                    <PagerStyle Mode="NextPrevAndNumeric" />
                                    <ClientSettings>
                                        <Selecting AllowRowSelect="True" />
                                        <Scrolling AllowScroll="true" ScrollHeight="280" UseStaticHeaders="true" />
                                    </ClientSettings>
                                    <MasterTableView DataKeyNames="pk_product_id">
                                        <Columns>
                                            <telerik:GridClientSelectColumn>
                                                <ItemStyle Width="10px" />
                                                <HeaderStyle Width="10px" />
                                            </telerik:GridClientSelectColumn>
                                            <telerik:GridBoundColumn DataField="pk_product_id" Visible="false">
                                                <ItemStyle CssClass="column" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="manufacturer_id" Visible="false">
                                                <ItemStyle CssClass="column" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="model_number" HeaderText="<%$Resources:Resource,Model_Number%>"
                                                SortExpression="model_number">
                                                <ItemStyle CssClass="column" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="manufacturer_name" HeaderText="<%$Resources:Resource,Manufacturer%>">
                                                <ItemStyle CssClass="column" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Product_Description%>">
                                                <ItemStyle CssClass="column" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                           
                            </ContentTemplate>
                        </telerik:RadPanelItem>
                    </Items>
                </telerik:RadPanelBar>
                 </td>
                </tr>
            </table>
                
            </td>
        </tr>
        <tr>
            <td>
                <%--OnClientClick="javascript:return GetSelectedItems();" --%>
            </td>
        </tr>
        <tr>
            <td style="padding-left:10px;">
                <asp:Button ID="btnAssignProduct" runat="server" Text="<%$Resources:Resource,Assign_Product%>"
                    OnClick="btnAssignProduct_Click" />
                <asp:Button ID="btnClose" runat="server" Width="100px" Text="<%$Resources:Resource,Close%>"
                    OnClientClick="javascript:return Close();" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfProductId" runat="server" />
                <asp:HiddenField ID="hfDescription" runat="server" />
                <asp:HiddenField ID="hfManufacturerName" runat="server" />
                <asp:HiddenField ID="hfManufacturerId" runat="server" />
                <asp:HiddenField ID="hfOmniClassName" runat="server" />
                <asp:HiddenField ID="hfOmniClassId" runat="server" />
                <asp:HiddenField ID="hfAssetType" runat="server" />
                <asp:HiddenField ID="hfAssetTypeId" runat="server" />
                <asp:HiddenField ID="hfModelNumber" runat="server" />
                <asp:HiddenField ID="hfWarrantyDurationParts" runat="server" />
                <asp:HiddenField ID="hfWarrantyGuarantorParts" runat="server" />
                <asp:HiddenField ID="hfWarrantyGuarantorPartsId" runat="server" />
                <asp:HiddenField ID="hfWarrantyDurationLabor" runat="server" />
                <asp:HiddenField ID="hfWarrantyGuarantorLabor" runat="server" />
                <asp:HiddenField ID="hfWarrantyGuarantorLaborId" runat="server" />
                <asp:HiddenField ID="hfWarrantyDescription" runat="server" />
                <asp:HiddenField ID="hfReplacementCost" runat="server" />
                <asp:HiddenField ID="hfWarrantyDurationUnit" runat="server" />
                <asp:HiddenField ID="hfWarrantyDurationUnitId" runat="server" />
                <asp:HiddenField ID="hfExpectedLife" runat="server" />
                <asp:HiddenField ID="hfPartNumber" runat="server" />
                <asp:HiddenField ID="hfUniFormat" runat="server" />
                <asp:HiddenField ID="hfUniFormatId" runat="server" />
            </td>
        </tr>
    </table>
    </div>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProducts" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgProducts">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProducts" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
</html>
