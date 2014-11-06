<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="DocumentChecklist.aspx.cs" Inherits="App_Reports_DocumentChecklist" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" language="javascript">
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
    <script type="text/javascript" language="javascript">
        window.onload = body_load;
        function resize_Nice_Scroll() {

            $(".divScroll").getNiceScroll().resize();
            if (document.getElementById("<%=txtSearch.ClientID %>") != null)
                document.getElementById("<%=txtSearch.ClientID %>").focus();
        }

        function body_load() {
            var screenhtg = set_NiceScrollToPanel();
            
            if(document.getElementById("<%=txtSearch.ClientID %>") != null )
                document.getElementById("<%=txtSearch.ClientID %>").focus();

            document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span><a>Report</a></span>" + "&nbsp;" +                                           
                                            "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>Document Checklist</span><a id='SiteMapPath1_SkipLink'></a></span>";
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

    </script>
    <script language="javascript" type="text/javascript">
        function Clear() {
            try {

                document.getElementById("ContentPlaceHolder1_txtSearch").value = "";
                return false;
            }
            catch (e) {
                return false;
            }
        }
        function openadddocumentpopup(entity_id, flag, type_comp_flag, Entity_detail_id, doc_type_id, facility_id) {
            //debugger

           // alert("test"); 
            var url = "AddComponentDocument.aspx?flag=" + flag + "&entity_id=" + entity_id + "&type_comp_flag=" + type_comp_flag + "&Entity_detail_id=" + Entity_detail_id + "&doc_type_id=" + doc_type_id + "&facility_id=" + facility_id;

            window.open(url, "Window1", "menubar=no,width=700,height=480,toolbar=no,scrollbars=no,resizable=yes");
            return false;
        }
        function validate(id, name) {
            alert("Select an Attribute Template for this facility.....!");
            //top.location.href = "../Locations/FacilityMenu.aspx?FacilityId=" + document.getElementById("ContentPlaceHolder1_hf_facility_id").value + "&FacilityName=" + document.getElementById("ContentPlaceHolder1_hf_facility_name").value;
            window.location.href = "../Locations/FacilityMenu.aspx?FacilityId=" + id + "&FacilityName=" + name;
            //window.location.href = "../Settings/AttributeTemplate.aspx";
            return false;
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
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <asp:Panel ID="pnlDocumentChecklstsId" runat="server" DefaultButton="btnSearch" >

        <table align="left" width="100%" style="table-layout:fixed;">
            <tr>
                <td class="centerAlign">
                    <div class="rpbItemHeader">
                        <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;">
                            <tr>
                                <td align="left" class="entityImage"  >
                                    <asp:Label runat="server" Text="<%$Resources:Resource,Document_Checklist%>" ID="lbl_grid_head"
                                        CssClass="gridHeadText" Width="159px" Font-Names="Arial" Font-Size="12"></asp:Label>
                                </td>
                                <td align="left" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                     >
                                    <div id="div_search"  >
                                        <table>
                                            <tr>
                                               
                                                <td align="center">
                                                                    <telerik:RadComboBox ID="cmb_entity" OnSelectedIndexChanged="cmb_entity_SelectedIndexChanged"
                                                                        runat="server" Height="100%" Width="160px" AutoPostBack="true">
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                                <td  style="background-color :#808080;width:1%;">
                                                                </td>
                                                                <td >
                                                                    <telerik:RadComboBox ID="cmb_facility" OnSelectedIndexChanged="cmb_facility_SelectedIndexChanged"
                                                                        runat="server" Height="70" Width="220px" AutoPostBack="true">
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                                <td    style="background-color :#808080;width:1%;">
                                                                </td>
                                                                <td  style="background-color :#808080;">
                                                                    <asp:RadioButton ID="rdBtnOmniClass" GroupName="OmniClassVersion" OnCheckedChanged="rdBtnOmniClass_CheckedChanged"
                                                                        runat="server"  CssClass="gridHeadText" Text="OmniClass 2010" Font-Size="10pt" AutoPostBack="True" Checked="true"
                                                                        Font-Bold="false"  />
                                                                </td>
                                                                <td style="background-color :#808080;">
                                                                    <asp:RadioButton ID="rdBtnOmniClass2" GroupName="OmniClassVersion" OnCheckedChanged="rdBtnOmniClass2_CheckedChanged"
                                                                        runat="server"  CssClass="gridHeadText" Text="OmniClass 2006" Font-Size="10pt" Font-Bold="false" AutoPostBack="True" />
                                                                </td>
                                                                <td  style="background-color :#808080;width:1%;">
                                                                </td>
                                                       
                                             
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="width:18%; "align="right" >
                                 <div id="div1" style="width: 200px; background-color: white;"  >
                                        <table>
                                            <tr>
                                                <td> 
                                       <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                        Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearch" Width="180px">
                                       </telerik:RadTextBox>
                                    </td>
                                       <td> <asp:ImageButton ClientIDMode="Static" ID="btnSearch" Height="13px" runat="server"
                                                  ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btnSearch_Click" />
                                                </td>
                                                 </tr>
                                        </table>
                                    </div>
                                </td>
                                <td align="right" style="padding: 4px 6px 0 0; width: 20px;">
                                    <%--<asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                        ClientIDMode="Static" ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                                </td>
                            </tr>
                        </table> 
                    </div>
                    <div id="divSelectedDomponentContent">
                        <telerik:RadGrid ID="rg_document_checklist" runat="server" BorderWidth="1px" CellPadding="0"
                            AllowPaging="True" AutoGenerateColumns="False" PagerStyle-AlwaysVisible="true"
                            GroupHeaderItemStyle-BorderWidth="1" AllowMultiRowSelection="False" ShowStatusBar="true"
                            OnPageIndexChanged="rg_document_checklist_pageindexchanged" AllowSorting="True"
                            OnItemCommand="rg_document_checklist_OnItemCommand"  ItemStyle-Wrap="false"
                            OnPageSizeChanged="rg_document_checklist_pagesizechanged" OnItemDataBound="rg_document_ItemDataBound"
                            OnDetailTableDataBind="rg_document_checklist_OnDetailTableDataBind" GridLines="None"
                            Skin="Default">
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right"></PagerStyle>
                            <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="400" />
                             <ClientEvents OnGridCreated="GridCreated" />
                            </ClientSettings>
                            <MasterTableView Width="100%" DataKeyNames="omniclass_detail_id" AllowMultiColumnSorting="True"
                                Name="omniclass_name">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="omniclass_detail_id" HeaderText="omniclass_detail_id"
                                        Visible="false">
                                        <ItemStyle CssClass="column1" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Omniclass" HeaderText="<%$Resources:Resource,Classifications%>">
                                        <ItemStyle CssClass="column1" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <DetailTables>
                                    <telerik:GridTableView AllowCustomPaging="false" PagerStyle-VerticalAlign="Bottom"
                                        PagerStyle-Mode="NextPrevAndNumeric" Width="100%" AutoGenerateColumns="false"
                                        DataKeyNames="Id" Name="category_grid" GridLines="Horizontal" AllowSorting="true"
                                        Style="border-color: #d5b96a; border: 0" PageSize="10" AllowPaging="true">
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="Id" HeaderText="Register_ID" Visible="false">
                                                <ItemStyle CssClass="column1" Wrap="false" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="omniclass_detail_id" HeaderText="Omniclass_ID"
                                                Visible="false">
                                                <ItemStyle CssClass="column1" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="name" HeaderText="<%$Resources:Resource,Name%>"
                                                Visible="true">
                                                <ItemStyle CssClass="column1" Wrap="false" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="refresh" UniqueName="refresh" HeaderText="Refresh"
                                                Visible="true">
                                                <ItemStyle CssClass="column1" Width="20%" />
                                                <ItemTemplate>
                                                    <asp:Button ID="btn_refresh" runat="server" alt="Edit" CausesValidation="false" Text="<%$Resources:Resource,Refresh%>"
                                                        CommandName="refresh" doc_type_id='<%# DataBinder.Eval(Container.DataItem,"Id")%>' />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <DetailTables>
                                            <telerik:GridTableView AllowCustomPaging="false" PagerStyle-VerticalAlign="Bottom"
                                                PagerStyle-Mode="NextPrevAndNumeric" Width="100%" AutoGenerateColumns="false"
                                                DataKeyNames="Id,doc_type_id" Name="doc_type_grid" GridLines="Horizontal" AllowSorting="True"
                                                Style="border-color: #d5b96a; border: 0" PageSize="10" AllowPaging="true">
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="Id" HeaderText="Register_ID" Visible="false">
                                                        <ItemStyle CssClass="column1" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="doc_type_id" HeaderText="Doc_type_ID" Visible="false">
                                                        <ItemStyle CssClass="column1" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn DataField="doc_type_name" UniqueName="TypeName" HeaderText="<%$Resources:Resource,Documnet_type%>"
                                                        Visible="true">
                                                        <ItemStyle CssClass="column1" Wrap="false" Width="30%" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblGrdTypeName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"doc_type_name")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="uploaded_file_name" UniqueName="uploaded_files"
                                                        HeaderText="<%$Resources:Resource,Uploaded_documents%>" Visible="true">
                                                        <ItemStyle CssClass="column1" Width="50%" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbl_uploaded_documents" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"uploaded_file_name")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="upload_document" UniqueName="upload_document"
                                                        HeaderText="<%$Resources:Resource,Upload%>">
                                                        <ItemStyle CssClass="column1" Width="20%" Font-Size="11px"></ItemStyle>
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnupload" runat="server" alt="Edit" CausesValidation="false" Text="<%$Resources:Resource,Upload%>"
                                                                doc_type_id='<%# DataBinder.Eval(Container.DataItem,"doc_type_id")%>' />
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </telerik:GridTableView>
                                        </DetailTables>
                                    </telerik:GridTableView>
                                </DetailTables>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
            
        </table>
    </asp:Panel>
     <asp:HiddenField ID="hfUserPMPageSize" runat="server" Value="" />
    <telerik:RadAjaxManagerProxy SkinID="Default" ID="ramProjects" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_document_checklist">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_document_checklist" LoadingPanelID="alp" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmb_entity">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_document_checklist" LoadingPanelID="alp" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmb_facility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_document_checklist" LoadingPanelID="alp" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_document_checklist" LoadingPanelID="alp" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="alp" runat="server" Height="50px" Width="75px" InitialDelayTime="0">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
