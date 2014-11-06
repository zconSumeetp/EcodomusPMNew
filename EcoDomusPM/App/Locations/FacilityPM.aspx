<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="FacilityPM.aspx.cs" Inherits="App_Locations_FacilityPM" %> 

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
    <script type="text/javascript" language="javascript">
        function resize_Nice_Scroll() {
              
            if (document.getElementById("<%=txt_search.ClientID %>") != null)
                document.getElementById("<%=txt_search.ClientID %>").focus();
        }

        function openFacilityPopup() {
         
            manager = $find("<%=rd_managerAssignFacility.ClientID%>");
            var url;
            var url = "ExistingFacilities.aspx";
            if (manager != null) {

                var windows = manager.get_windows();
                windows[0].setUrl(url);
                windows[0].show();
                //window[0].moveTo(10, -50);
                windows[0].set_modal(false);
            }
            return false;
        }
        function body_load() {

            var screenhtg = set_NiceScrollToPanel();
            if (document.getElementById("<%=txt_search.ClientID %>") != null)
                document.getElementById("<%=txt_search.ClientID %>").focus();
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
     

    </script>
    <script src="../../App_Themes/EcoDomus/jquery.nicescroll.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">

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

        function delete_() {
            var flag;
            flag = confirm("Do you want to delete?");
            return flag;
        }


        function fn_Clear() {
            try {
                document.getElementById("ContentPlaceHolder1_txt_search").value = "";
                return false;
            }
            catch (e) {
                alert(e.message + "  " + e.Number);
                return false;
            }
        }
        function ProjectValidation() {

            alert('Please select Project');
            window.location = '../Settings/Project.aspx';
            return false;

        }


        function validate() {
            alert("Select atleast one facility.....!");
            return false;
        }

        function confirmation() {

            var RadGrid1 = $find("<%=rgFacility.ClientID %>");
            var masterTable = $find("<%=rgFacility.ClientID %>").get_masterTableView();
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
                flag = confirm("Do you want to delete facility?");
                return flag;
                //return true;
            }
            else {
                alert("Please select facility");
                return false;

            }

        }
        function openAddFacilitypopup() {

          
            manager = $find("<%=rd_manager.ClientID%>");
            var url;
            var url = "AddFacilityPopUp.aspx";
            if (manager != null) {
        
                var windows = manager.get_windows();
                windows[0].setUrl(url);
                windows[0].show();
                //window[0].moveTo(10, -50);
                //windows[0].set_modal(false);
            }
            return false;
        }

        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {
            //var globalPageHeight = parseInt((set_NiceScrollToPanel() - 130) / 32);
            var pageSize = document.getElementById("ContentPlaceHolder1_hfFacilityPMPageSize").value;
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
     <style>
     .RadWindow_Simple
        {
            border: solid 0px #616161;
        }
         .RadWindow .rdWindowContent
         {
             background-color:#EEEEEE;
         }
</style>
    <style type="text/css">
        body
        {
        }
        
        .searchImage
        {
            background-image: url('/App/Images/Icons/icon_search_sm.png');
            background-repeat: no-repeat;
            background-position: right;
            font-family: "Arial" , sans-serif;
            font-size: 12px;
        }
        .gridHeadText
        {
            font-family: "Verdana" , "Sans-Serif";
            font-style: normal;
            font-size: medium;
            color: White;
        }
        .entityImage
        {
            padding-left: 7px;
        }
        .gridHeaderText
        {
            font-family: "Arial" , sans-serif;
            font-size: 16px;
            height: 20px;
            font-weight: bold;
            background-color: #AFAFAF;
        }
        
        .gridRadPnlHeader
        {
            background-color: Gray;
            height: 30px;
            width: 100%;
            vertical-align: middle;
        }
        .captiondock
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
            color: #990000;
            text-align: left;
            vertical-align: middle;
            margin-top: 10px;
            margin-bottom: 10px;
            font-weight: normal;
        }
        
        .gridRadPnlHeaderBottom
        {
            background-color: Orange;
            height: 1px;
            width: 100%;
        }
        .dropDownImage
        {
            right: 15px;
        }
        
        .searchTextBox
        {
            position: relative;
            right: 10px;
        }
        
        .wizardHeadImage
        {
            background-color: #FFA500;
            height: 30px;
            background-attachment: scroll;
            width: 100%;
            background-attachment: fixed;
            background-position: right;
            background-repeat: no-repeat;
            position: relative;
        }
        .wizardLeftImage
        {
            float: left;
            padding-left: 15px;
            vertical-align: middle;
            height: 20;
            right: 5px;
        }
        .wizardRightImage
        {
            float: right;
            padding-right: 10px;
            vertical-align: middle;
            height: 20;
        }
        
        
        
        .RadWindow_Default .rwCorner .rwTopLeft, .RadWindow_Default .rwTitlebar
        {
            width: 0px;
            height: 0px;
        }
        .RadWindow_Default .rwCorner .rwTopRight, .RadWindow_Default .rwIcon, .RadWindow_Default table .rwTopLeft, .RadWindow_Default table .rwTopRight, .RadWindow_Default table .rwFooterLeft, .RadWindow_Default table .rwFooterRight, .RadWindow_Default table .rwFooterCenter, .RadWindow_Default table .rwBodyLeft, .RadWindow_Default table .rwBodyRight, .RadWindow_Default table .rwTitlebar
        {
            background: none;
        }
        
        .RadWindow_Default table .rwStatusbar .rwLoading
        {
            background: none !important;
            border: 0px;
            display: none;
            width: 0px;
            height: 0px;
        }
        .RadWindow.rwMinimizedWindowShadow .RadWindow.rwMinimizedWindowShadow .rwTable, .normalLabel
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
        }
        .normalLabelBold
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            font-weight: bold;
        }
        .headerBoldLabel
        {
            font-family: "Arial" , sans-serif;
            font-size: 16px;
            font-weight: bold;
        }
        
        .lblHeading
        {
            font-family: "Arial";
            font-size: 10px;
        }
        
        .tdValign
        {
            vertical-align: top;
            margin: 0;
        }
        .lnkButton
        {
            font-family: "Arial";
            font-size: 10px;
            color: Black;
            text-decoration: none;
        }
        
        .lnkButtonImg
        {
            height: 14px;
            vertical-align: bottom;
        }
        
        
        .lblBold
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            height: 20px;
            vertical-align: middle;
            font-weight: bold;
        }
        
        .gridHeaderBoldText
        {
            font-family: "Arial" , sans-serif;
            font-size: 14px;
            vertical-align: bottom;
            font-weight: bold;
        }
        
        
        .textAreaScrollBar
        {
            font-family: "Arial" , sans-serif;
            font-size: 12px;
            overflow: auto;
            padding-left: 10px;
            padding-top: 10px;
            border-left-color: #D4D4C3;
            border-top-color: #D4D4C3;
            border-bottom-color: #E8E8E8;
            border-right-color: #E8E8E8;
            height: 170px;
        }
        
               
            .divProperties
                {
                    background-image: url('../Images/asset_zebra-bkgrd_gray2.png');
                }
            .rpbItemHeader
             {
            background-color:#808080;
             }
    </style>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
    </telerik:RadCodeBlock>
    

    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
  <asp:Panel ID="pnlFacilitesId" runat="server" DefaultButton="btn_search" >

      <table style="font-family: Arial, Helvetica, sans-serif; vertical-align: top; table-layout: fixed;"
          width="100%">
          <tr>
              <td class="topbuttons">
                  <asp:Button ID="btnShowAdd" runat="server" Text="<%$Resources:Resource,Add_Facility%>"
                      Width="100px" CausesValidation="false" OnClientClick="javascript:return openAddFacilitypopup();" />
                  <asp:Button ID="btndelete" runat="server" Text="<%$Resources:Resource,Delete%>" Width="100px"
                      OnClick="btn_delete_click" CausesValidation="false" OnClientClick="javascript:return confirmation();" />
              </td>
          </tr>
          <tr>
              <td style="display: none;">
                  <table>
                      <tr>
                          <td style="padding-top: 0px; display: none" align="left">
                              <asp:HiddenField ID="hfFacilityPMPageSize" runat="server" Value="" />
                          </td>
                      </tr>
                  </table>
              </td>
          </tr>
          <tr>
              <td class="centerAlign">
                  <div class="rpbItemHeader divBorder">
                      <table cellpadding="0" cellspacing="0" width="100%" style="background-color: #808080;
                          table-layout: fixed;">
                          <tr>
                              <td align="left" class="entityImage"  style="width: 25%;">
                                  <asp:Label runat="server" Text="<%$Resources:Resource,Facility%>" ID="lbl_grid_head"
                                      CssClass="gridHeadText" Width="100px" ForeColor="#F8F8F8" Font-Names="Arial"
                                      Font-Size="12"></asp:Label>
                              </td>
                              <td align="right" style="background-color: #808080; padding-top: 02px; padding-bottom: 02px;"
                                  >
                                  <div id="div1" style="width: 200px; background-color: white;" >
                                      <table>
                                          <tr>
                                              <td>
                                                  <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                      Height="100%" EmptyMessage="Search" BorderColor="White" ID="txt_search" Width="180px">
                                                  </telerik:RadTextBox>
                                              </td>
                                              <td>
                                                  <asp:ImageButton ClientIDMode="Static" ID="btn_search" Height="13px" runat="server"
                                                      ImageUrl="~/App/Images/Icons/icon_search_sm.png" OnClick="btn_search_click" />
                                              </td>
                                          </tr>
                                      </table>
                                  </div>
                              </td>
                              <td align="right" style="width: 10px; padding: 4px 2px 0 0;">
                                  <%--    <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />--%>
                              </td>
                          </tr>
                      </table>
                  </div>
                  <div id="divSelectedDomponentContent" class="divProperties RightMenu_1_Content">
                      <telerik:RadGrid ID="rgFacility" runat="server" EnableViewState="true" AllowPaging="True"
                          AllowSorting="True" AutoGenerateColumns="False" BorderWidth="1px" CellPadding="0"
                          OnSortCommand="rgFacility_OnSortCommand" PagerStyle-AlwaysVisible="true" OnPageSizeChanged="rgFacility_PageSizeChanged"
                          AllowMultiRowSelection="true" PageSize="10" EnableEmbeddedSkins="true" OnPageIndexChanged="rgFacility_PageIndexChanged"
                          OnItemCommand="rgFacility_ItemCommand" Skin="Default" GridLines="None" ItemStyle-Wrap="false"
                          OnItemDataBound="rgFacility_OnItemDataBound">
                          <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Visible="true" />
                          <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                              <Selecting AllowRowSelect="true" />
                              <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" ScrollHeight="400" />
                              <ClientEvents OnGridCreated="GridCreated" />
                          </ClientSettings>
                          <MasterTableView DataKeyNames="pk_facility_id,name">
                              <ItemStyle Height="31px" Wrap="false" Font-Names="Arial" Font-Size="10" />
                              <AlternatingItemStyle Height="31px" Font-Names="Arial" Font-Size="10" />
                              <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                              <FooterStyle Height="25px" Font-Names="Arial" />
                              <Columns>
                                  <telerik:GridBoundColumn DataField="pk_facility_id" Visible="false">
                                      <ItemStyle Width="10%" />
                                  </telerik:GridBoundColumn>
                                  <telerik:GridClientSelectColumn>
                                      <ItemStyle Width="5%" />
                                      <HeaderStyle Width="5%" />
                                  </telerik:GridClientSelectColumn>
                                  <telerik:GridButtonColumn ButtonType="LinkButton" ItemStyle-Font-Underline="true"
                                      UniqueName="facname" CommandName="Edit" CommandArgument="sel" SortExpression="name"
                                      HeaderText="<%$Resources:Resource,Facility_Name%>" HeaderStyle-Wrap="false" DataTextField="name">
                                      <HeaderStyle Wrap="False"></HeaderStyle>
                                      <ItemStyle Wrap="false" Font-Underline="true" />
                                  </telerik:GridButtonColumn>
                                  <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>"
                                      UniqueName="description">
                                      <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                      <HeaderStyle HorizontalAlign="Left" Wrap="false" />
                                  </telerik:GridBoundColumn>
                              </Columns>
                          </MasterTableView>
                      </telerik:RadGrid>
                  </div>
              </td>
              
          </tr>
      </table>
    </asp:Panel>
    <telerik:RadWindowManager ID="rd_manager"  runat="server" VisibleTitlebar="true"  Title="Assign Classification" Behaviors="Close,Move" 
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rd_window_add_facility" runat="server" Title="Add Facility"  ReloadOnShow="false"  AutoSize="false" Width="400px" Height="150px"
                VisibleStatusbar="false" VisibleOnPageLoad="false" BorderWidth="0px"  EnableShadow="true" BackColor="#EEEEEE" >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_managerAssignFacility"  runat="server" VisibleTitlebar="true"  Title="Assign Facility" Behaviors="Close,Move" 
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="RadWindow1" runat="server" Title="Assign Facility"  ReloadOnShow="false"  AutoSize="false" Width="500px" Height="500px"
                VisibleStatusbar="false" VisibleOnPageLoad="false" BorderWidth="0px"  EnableShadow="true" BackColor="#EEEEEE" >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btn_Search">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgFacility" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgFacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgFacility" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgFacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgFacility" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"  Skin="Default">
       

    </telerik:RadAjaxLoadingPanel>
</asp:Content>
