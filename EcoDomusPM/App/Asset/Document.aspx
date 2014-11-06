<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Document.aspx.cs" Inherits="App_Asset_Document"
    MasterPageFile="~/App/EcoDomus_PM_New.master"%> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
        <script language="javascript" type="text/javascript">
            function resize_Nice_Scroll() {

                // $(".divScroll").getNiceScroll().resize();
                if (document.getElementById("<%=txtcriteria.ClientID %>") != null)
                    document.getElementById("<%=txtcriteria.ClientID %>").focus();
            }

            function body_load() {
                var screenhtg = set_NiceScrollToPanel();
                if (document.getElementById("<%=txtcriteria.ClientID %>") != null)
                    document.getElementById("<%=txtcriteria.ClientID %>").focus();

            }

            function doClick(buttonName, e) {
                //the purpose of this function is to allow the enter key to 
                //point to the correct button to click.
                var key;

                if (window.event)
                    key = window.event.keyCode;     //IE
                else
                    key = e.which;     //firefox

                if (key == 13) {
                    //Get the button the user wants to have clicked
                    var btn = document.getElementById(buttonName);
                    if (btn != null) { //If we find the button click it
                        btn.click();
                        event.keyCode = 0
                    }
                }
            }

            window.onload = body_load;

            function stopPropagation(e) {

                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            }

            //This Function set scroll Height to fix when docheight is less than scrollHeight
            function GridCreated(sender, args) {
                //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
                var pageSize = document.getElementById("ContentPlaceHolder1_hfDocumentPMPageSize").value;
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

            function deleteLocation(sender, args) {
                var s1 = $find("<%=rgdocument.ClientID %>");
                var MasterTable = s1.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var s = "";
                for (var i = 0; i < selectedRows.length; i++) {
                    s = s + s1.get_masterTableView().get_selectedItems()[0].getDataKeyValue("pk_document_id") + ",";
                }
                if (s == "") {
                    alert("Please select a document to delete");
                    sender.set_autoPostBack(false);
                }
                else {
                    var flag;
                    flag = confirm("Do you want to delete this document?");
                    sender.set_autoPostBack(flag);
                }
            }

            function checkSelection(sender, args) {

                var selectedRows = $find("<%=rgdocument.ClientID %>").get_masterTableView().get_selectedItems();

                if (selectedRows.length < 1) {
                    alert("Please select a document to map");
                    sender.set_autoPostBack(false);
                }
                else {
                    var FacilityID = selectedRows[0].getDataKeyValue("fk_facility_id");
                    var flag = false;
                    for (var i = 0; i < selectedRows.length; ++i) {
                        if (selectedRows[i].getDataKeyValue("fk_facility_id") != FacilityID) {
                            flag = true;
                            break;
                        }
                    }
                    if (flag) {
                        alert("Please select documents with same facility..");
                        sender.set_autoPostBack(false);
                    }
                    else {
                        sender.set_autoPostBack(true);
                    }
                }
            }

            function ProjectValidation() {

                alert('Please select project');
                window.location = '../Settings/Project.aspx';
                return false;

            }


            function fn_Clear(sender, args) {
                try {
                    document.getElementById("ContentPlaceHolder1_txtcriteria").value = "";
                    document.getElementById("<%=chkShowUnassignedFlag.ClientID %>").checked = false;
                    document.getElementById("<%=txtcriteria.ClientID %>").focus();
                    sender.set_autoPostBack(false);
                }
                catch (e) {
                    alert(e.message + "  " + e.Number);
                    sender.set_autoPostBack(false);
                }

            }

            function doClick(buttonName, e) {
                //the purpose of this function is to allow the enter key to 
                //point to the correct button to click.
                var key;

                if (window.event)
                    key = window.event.keyCode;     //IE
                else
                    key = e.which;     //firefox

                if (key == 13) {
                    //Get the button the user wants to have clicked
                    var btn = document.getElementById(buttonName);
                    if (btn != null) { //If we find the button click it
                        btn.click();
                        event.keyCode = 0
                    }
                }
            }

            function checkboxClick(sender) {


                collectSelectedItems(sender);
                document.getElementById('ContentPlaceHolder1_btn_navigate').click();
                //$find("<%= cmbfacility.ClientID %>").hideDropDown();
                // document.getElementById('ContentPlaceHolder1_btn_refresh').click();
            }

            function doClick(buttonName, e) {
                //the purpose of this function is to allow the enter key to 
                //point to the correct button to click.
                var key;

                if (window.event)
                    key = window.event.keyCode;     //IE
                else
                    key = e.which;     //firefox

                if (key == 13) {
                    //Get the button the user wants to have clicked
                    var btn = document.getElementById(buttonName);
                    if (btn != null) { //If we find the button click it
                        btn.click();
                        event.keyCode = 0
                    }
                }
            }

            function collectSelectedItems(sender) {
                var combo = $find(sender);
                var items = combo.get_items();

                var selectedItemsTexts = "";
                var selectedItemsValues = "";

                var itemsCount = items.get_count();

                for (var itemIndex = 0; itemIndex < itemsCount; itemIndex++) {
                    var item = items.getItem(itemIndex);

                    var checkbox = getItemCheckBox(item);

                    //Check whether the Item's CheckBox) is checked.
                    if (checkbox.checked) {
                        selectedItemsTexts += item.get_text() + ", ";
                        selectedItemsValues += item.get_value() + ", ";
                    }
                }  //for closed

                selectedItemsTexts = selectedItemsTexts.substring(0, selectedItemsTexts.length - 2);
                selectedItemsValues = selectedItemsValues.substring(0, selectedItemsValues.length - 2);

                //Set the text of the RadComboBox with the texts of the selected Items, separated by ','.
                combo.set_text(selectedItemsTexts);

                //Set the comboValue hidden field value with values of the selected Items, separated by ','.

                if (selectedItemsValues == "") {
                    combo.clearSelection();
                }
                //document.getElementById('ContentPlaceHolder1_hfFacilityid').value = selectedItemsValues;   
            }

            function getItemCheckBox(item) {
                //Get the 'div' representing the current RadComboBox Item.
                var itemDiv = item.get_element();

                //Get the collection of all 'input' elements in the 'div' (which are contained in the Item).
                var inputs = itemDiv.getElementsByTagName("input");

                for (var inputIndex = 0; inputIndex < inputs.length; inputIndex++) {
                    var input = inputs[inputIndex];

                    //Check the type of the current 'input' element.
                    if (input.type == "checkbox") {
                        return input;
                    }
                }

                return null;
            }

            function ShowFullEntityName(lblEntityName) {
                var lblEntityNameId = lblEntityName.id;
                var hfId = lblEntityNameId.replace("lblEntityNames", "hfEntityNamesFull");
                var tooltip = $find("<%=RadToolTip1.ClientID %>");

                tooltip.set_targetControlID(lblEntityNameId);
                tooltip.set_text(document.getElementById(hfId).value);
                window.setTimeout(function () {
                    tooltip.show();
                }, 100);
            }

            function HideTooltip() {
                var tooltip = Telerik.Web.UI.RadToolTip.getCurrent();
                if (tooltip) tooltip.hide();
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

        </script>
        
        <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
        <style type="text/css">
            
            
        .rtWrapperContent
        {
            padding: 10px !important;
            color: Black !important;
        }
        .RadGrid .Row50 td
        {
            padding-top: 0;
            padding-bottom: 0;
            height: 30px;
            vertical-align: middle;
        }
        
        
            .divProperties
                {
                    background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
                }
            .rpbItemHeader
             {
            background-color:#808080;
            }
              .entityImage
            {
                padding-left: 7px;
            }
    </style>
    </telerik:RadCodeBlock>
   <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />

    <telerik:RadToolTip runat="server" ID="RadToolTip1" HideEvent="ManualClose" ShowEvent="FromCode"
        RelativeTo="Element" Sticky="true" Skin="WebBlue" Width="420px">
    </telerik:RadToolTip>
    <asp:Panel ID="pnlDocumentsId" runat="server" DefaultButton="btnSearch" >

    <table width="100%" style="table-layout:fixed;" >
        <tr>
            <td class="topbuttons" style="width:21%">
             
                           <telerik:RadButton ID="btnaddDocument" runat="server" Width="130px" Text="<%$Resources:Resource,Add_Document%>"
                                OnClick="btnaddDocument_Click" />&nbsp
                           <telerik:RadButton ID="btnDelete" runat="server" Text="<%$Resources:Resource,Delete%>"
                                OnClientClicked="deleteLocation" OnClick="btnDelete_click" Width="100px" />
              </td>
              <td align="left">            
                   <telerik:RadButton ID="btnMapDocuments" runat="server"  Text="Map Documents" OnClientClicked="checkSelection"
                                OnClick="btnMapDocuments_click" Width="130px" Visible="false" />
            </td>
        </tr>
         <tr>
            <td colspan="2" style="display:none;">
                <table>
                    <tr>
                        <td style="padding-top: 0px; display: none" align="left">
                            <asp:HiddenField ID="hfDocumentPMPageSize" runat="server" Value="" />
                            <asp:HiddenField ID="hfFacilityid" runat="server" />
                            <asp:HiddenField ID="hf_row_ids" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="centerAlign">
                <div class="rpbItemHeader divBorder">
                <table cellpadding="0" cellspacing="0" width="100%" style="background-color:#808080;">
                    <tr>
                        <td align="left" class="entityImage" style="width:35%"  >
                             <asp:Label runat="server" Text="Documents" ID="lbl_grid_head" CssClass="gridHeadText"
                                                    ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblfacility" runat="server"  CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10" Text="<%$Resources:Resource,Facility%>">:</asp:Label>
                             <telerik:RadComboBox Width="170px" ID="cmbfacility" Filter="contains" runat="server"
                                                                oncopy="return false;" OnItemDataBound="cmbfacility_itemdatabound" AllowCustomText="true"
                                                                onpaste="return false;" oncut="return false;" onkeypress="return tabonly(event)"
                                                                onmousewheel="return false">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="checkbox1" Checked="true" runat="server" Text='<%#Eval("name") %>' />
                               </ItemTemplate>
                                </telerik:RadComboBox>
                        </td>

                        <td align="left" class="entityImage" style="padding: 0 2px 0 2px;" >
                                   <asp:CheckBox ID="chkShowUnassignedFlag" runat="server" OnCheckedChanged="btnsearch_Click"
                                                                AutoPostBack="true" ForeColor="#F8F8F8" Text="Show unassigned documents" />
                         </td>
                         <td align="right" style=" background-color:#808080;padding-top: 02px; padding-bottom: 02px;" >
                                    <div id="div_search" style="width: 200px; background-color: white;" >
                                       <table >
                                             <tr>
                                                <td>
                                                       <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                         EmptyMessage="Search" BorderColor="White" ID="txtcriteria" Width="180px">
                                                          </telerik:RadTextBox>
                                                             </td>
                                                              <td>
                                                                <asp:ImageButton ClientIDMode="Static" OnClick="btnsearch_Click" ID="btnSearch" 
                                                                       runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                              </td>
                                                         </tr>
                                                     </table>
                                                </div>
                                 </td>
                                 <td align="center" style="padding: 4px 6px 0 0;">
                                   <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                                 ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                 </td>     
                            </tr>
                </table>
                </div> <%--OnPageIndexChanged="btnsearch_Click" OnPageSizeChanged="btnsearch_Click"--%>
                <div id="divSelectedDomponentContent" class="divProperties RightMenu_1_Content" >
                <telerik:RadGrid runat="server" ID="rgdocument" AllowPaging="true" BorderWidth="1px"
                        PageSize="10" AutoGenerateColumns="False" AllowSorting="True" PagerStyle-AlwaysVisible="true"
                        Visible="false" AllowMultiRowSelection="true" Skin="Default" OnItemCommand="rgdocument_ItemCommand"
                        ItemStyle-Wrap="false" HeaderStyle-Wrap="false" OnSortCommand="btnsearch_Click" OnItemCreated="rgdocument_OnItemCreated"
                        OnPageIndexChanged="rgdocument_OnPageIndexChanged" OnPageSizeChanged="rgdocument_OnPageIndexChanged" OnItemDataBound="rgdocument_ItemDataBound"
                        >
                 <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                 <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                            <Selecting AllowRowSelect="true" />
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                            <ClientEvents OnGridCreated="GridCreated" />
                        </ClientSettings>
                  <MasterTableView DataKeyNames="pk_document_id,document_name,fk_row_id,entity_name,row_ids,fk_facility_id"
                            ClientDataKeyNames="fk_facility_id" HeaderStyle-CssClass="gridHeaderTextMedium">
                            <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                            <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                            <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                            <FooterStyle Height="25px" Font-Names="Arial" />
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_document_id" HeaderText="pk_document_id" UniqueName="pk_document_id"
                                    Visible="false" SortExpression="pk_document_id">
                                </telerik:GridBoundColumn>
                                <telerik:GridClientSelectColumn>
                                    <HeaderStyle Width="3%" />
                                    <ItemStyle Wrap="true" Width="3%" />
                                </telerik:GridClientSelectColumn>
                                <%--<telerik:GridBoundColumn DataField="document_name" HeaderText="" UniqueName="document_name"
                                    SortExpression="document_name" Visible="false">
                                </telerik:GridBoundColumn>--%>
                                <telerik:GridButtonColumn ButtonType="LinkButton" CommandName="Edit" UniqueName="document_name"
                                    CommandArgument="document_name" SortExpression="document_name" HeaderText="<%$Resources:Resource,Document_Name%>"
                                    DataTextField="document_name">
                                    <HeaderStyle Width="25%" ForeColor="GrayText"></HeaderStyle>
                                    <ItemStyle Width="25%" Wrap="true" Font-Underline="true" />
                                </telerik:GridButtonColumn>
                                <telerik:GridBoundColumn DataField="FacilityName" HeaderText="Facility" UniqueName="FacilityName"
                                    SortExpression="FacilityName" Visible="false">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="entity_name" HeaderText="<%$Resources:Resource,Entity%>"
                                    UniqueName="entity_name">
                                    <HeaderStyle ForeColor="GrayText" Width="12%"></HeaderStyle>
                                    <ItemStyle Wrap="true" Width="12%" />
                                </telerik:GridBoundColumn>
                                <%--<telerik:GridBoundColumn HeaderText="<%$Resources:Resource,Entity_Name%>" UniqueName="RowName"
                                    SortExpression="RowName">
                                    <HeaderStyle ForeColor="GrayText" Width="20%"></HeaderStyle>
                                    <ItemStyle Width="20%" Wrap="false"/>
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntityNames" onmouseover="ShowFullEntityName(this)" onmouseout="HideTooltip()"
                                            runat="server"></asp:Label>
                                        <asp:HiddenField ID="hfEntityNamesFull" Value='<%# DataBinder.Eval(Container.DataItem,"RowName") %>'
                                            runat="server" />
                                    </ItemTemplate>
                                </telerik:GridBoundColumn>--%>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource,Entity_Name%>" UniqueName="RowName"
                                                SortExpression="RowName">
                                                <HeaderStyle ForeColor="GrayText" Width="20%"></HeaderStyle>
                                                <ItemStyle Wrap="true" Width="20%" />
                                                <ItemTemplate>
                                                     <asp:Label ID="lblEntityNames"  runat="server"></asp:Label>
                                                    <asp:HiddenField ID="hfEntityNamesFull" Value='<%# DataBinder.Eval(Container.DataItem,"RowName") %>'
                                                        runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="fk_row_id" HeaderText="" HeaderStyle-Width="0%"
                                    UniqueName="fk_row_id" Visible="false" SortExpression="fk_row_id">
                                </telerik:GridBoundColumn>
                       
                                <telerik:GridBoundColumn DataField="Category" HeaderText="<%$Resources:Resource,Category%>"
                                    UniqueName="Category" SortExpression="Category">
                                    <HeaderStyle ForeColor="GrayText" Width="18%"></HeaderStyle>
                                    <ItemStyle Wrap="false" Width="18%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn SortExpression="filename" DataField="filename" UniqueName="File"
                                    HeaderText="<%$Resources:Resource,File%>">
                                    <HeaderStyle ForeColor="GrayText" Width="18%"></HeaderStyle>
                                    <ItemStyle  Wrap="false" Width="18%" />
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hlnkDocName" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"file_path")%>'
                                            Text='<%# DataBinder.Eval(Container.DataItem,"filename")%>'  runat="server" Target="_blank"></asp:HyperLink>
                                        <asp:Label ID="lblDocName" Text='<%# DataBinder.Eval(Container.DataItem,"filename")%>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="row_ids" HeaderText="" UniqueName="row_ids" Visible="false"
                                    SortExpression="row_ids">
                                </telerik:GridBoundColumn>
                              </Columns>
                        </MasterTableView>
                       </telerik:RadGrid>
                    
                </div>
                                
            </td>
        </tr>
        
    </table>
    </asp:Panel>
    <div style="display: none">
        <asp:Button ID="btn_navigate" runat="server" OnClick="navigate" />
    </div>

    <telerik:RadAjaxManagerProxy ID="DocumentProfileProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="chkShowUnassignedFlag">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgdocument" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="btnMapDocuments" />
                    <telerik:AjaxUpdatedControl ControlID="rcb_map_facility" />
                    <telerik:AjaxUpdatedControl ControlID="lblFac" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmbfacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgdocument" LoadingPanelID="loadingPanel1" />
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
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1"  Skin="Default" runat="server" Height="75px" Width="75px">
        <%--<img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />--%>
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
