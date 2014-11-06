<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="SpaceProfile.aspx.cs"
    Inherits="App_Settings_SpaceProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">--%>
<html>
<head>
    <title>Space Profile </title>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <telerik:RadCodeBlock ID="radcodeblock1" runat="server">
        <script type="text/javascript" language="javascript">

            function openAddDocument() {
                var url = "AddDocument.aspx?flag=S&id=" + document.getElementById("hflocationid").value;
                window.open(url, "Window1", "menubar=no,width=880,height=500,toolbar=no,scrollbars=no");

                return false;
            }

            function openpopupaddomniclasslinkup() {
                var url = "AssignOmniclass.aspx?Item_type=space";
                window.open(url, "Window1", "menubar=no,width=500,height=950,right=50,toolbar=no,scrollbars=yes");
                return false;
            }
            function NavigateToFindLocation() {

                top.location.href = "../Locations/FindLocation.aspx";
            }

            function navigate_space() {
                var url = "../locations/facilitymenu.aspx?pagevalue=Space Profile&id=" + document.getElementById("hflocationid").value + "&profileflag=new";
                parent.location.href(url);
            }
            function navigate_spacepopup() {
                var url = "../locations/spaceprofile_new.aspx?pagevalue=Space Profile&id=" + document.getElementById("hflocationid").value + "&profileflag=new&popupflag=popup";
                window.location.href(url);
                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    wnd.set_height(document.body.scrollHeight - 30)
                    wnd.set_width(document.body.scrollWidth - 60)
                    //wnd.set_height(350)
                }
                ///xxxx
            }

            function validate() {
                alert("Space name already exists");
                return false;
            }

            function NavigateToFindLocationPM() {
                top.location.href = "../Locations/SpacePM.aspx";
            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }

            function closewindow() {
                window.close();
                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    wnd.set_height(330);
                }

            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
</head>
<body style="background: transparent; background-image: url('../Images/asset_zebra-bkgrd_gray2.PNG');
    padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" style="margin: 0 0 0 0" defaultfocus="txtspacename">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
    <asp:HiddenField ID="hflocationid" runat="server" />
    <div style="width: 100%; padding-left: 2px; padding-top: 2px;" id="divProfilePage"
        runat="server">
        <%--<table runat="server" id="tbltitle" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;display:none;">
            <tr>
                <td class="wizardHeadImage" >
                    <div class="wizardLeftImage">
                        <asp:Label ID="lblSpaceProfileName" runat="server" Text="<%$Resources:Resource, Space_Profile%>" Visible="false" Font-Names="Verdana" Font-Size="11pt"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ibtn_close" Width="15px" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                          OnClientClick="Javascript:closewindow();" />
                    </div>
                </td>
            </tr>
  </table>--%>
        <table>
            <tr>
                <td style="width: 100%; padding-left: 20px;">
                    <table style="margin-top: 15px; margin-left: 0px;" align="left">
                        <tr>
                            <th width="100" align="left">
                                <asp:Label runat="server" Text="<%$Resources:Resource, Name%>"></asp:Label>:
                            </th>
                            <td>
                                <asp:TextBox ID="txtspacename" runat="server" CssClass="SmallTextBox" TabIndex="1"></asp:TextBox>
                                <asp:Label runat="server" ID="lblspacename" CssClass="linkText"></asp:Label>
                                <asp:RequiredFieldValidator ID="rf_space_name" ValidationGroup="rf_validationgroup"
                                    runat="server" ControlToValidate="txtspacename" ErrorMessage="*" ForeColor="Red"
                                    Display="Dynamic" Visible="true" SetFocusOnError="true">
                                </asp:RequiredFieldValidator>
                            </td>
                            <td width="50px">
                            </td>
                            <th width="100" align="left">
                                <asp:Label ID="lblRoomtagheading" runat="server" Text="<%$Resources:Resource, Room_Tag%>"></asp:Label>:
                            </th>
                            <td>
                                <asp:TextBox ID="txtRoomTag" runat="server" CssClass="SmallTextBox" TabIndex="6"></asp:TextBox>
                                <asp:Label runat="server" ID="lblroomtag" CssClass="linkText"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px">
                            </td>
                        </tr>
                        <tr>
                            <th width="100" align="left">
                                <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, Description%>"></asp:Label>:
                            </th>
                            <td>
                                <asp:TextBox ID="txtdescription" runat="server" CssClass="SmallTextBox" TabIndex="2"></asp:TextBox>
                                <asp:Label runat="server" ID="lbldescription" CssClass="linkText"></asp:Label>
                            </td>
                            <td width="50px">
                            </td>
                            <th width="100" align="left">
                                <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource, Barcode%>"></asp:Label>:
                            </th>
                            <td>
                                <asp:TextBox ID="txtBarcode" runat="server" CssClass="SmallTextBox" TabIndex="7"></asp:TextBox>
                                <asp:Label runat="server" ID="lblBarcode" CssClass="linkText"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px">
                            </td>
                        </tr>
                        <tr>
                            <th width="100" align="left">
                                <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, Facility%>"></asp:Label>:
                            </th>
                            <td>
                                <telerik:RadComboBox ID="cmbfacility" runat="server" Height="100px" Width="175px"
                                    TabIndex="3" AutoPostBack="true" OnSelectedIndexChanged="cmbfacility_SelectedIndexChanged">
                                </telerik:RadComboBox>
                                <asp:Label runat="server" ID="lblfacility" CssClass="linkText"></asp:Label>
                                <asp:RequiredFieldValidator ID="rf_validatorfacility" runat="server" ControlToValidate="cmbfacility"
                                    InitialValue="--Select--" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                    ValidationGroup="rf_validationgroup" SetFocusOnError="true"> 
                                </asp:RequiredFieldValidator>
                            </td>
                            <td width="50px">
                            </td>
                            <th width="100" align="left">
                                <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,  Net_Area%>"></asp:Label>:
                            </th>
                            <td>
                                <asp:TextBox ID="txt_area" runat="server" CssClass="SmallTextBox" TabIndex="8"></asp:TextBox>
                              <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator_txt_area" ControlToValidate="txt_area"
                                    runat="server" ErrorMessage="Only numbers allowed" ValidationGroup="rf_validationgroup"
                                    ValidationExpression="^-?\d*\.?\d*"></asp:RegularExpressionValidator>--%>
                                <asp:Label runat="server" ID="lblArea" CssClass="linkText"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px">
                            </td>
                        </tr>
                        <tr>
                            <th width="100" align="left">
                                <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource, Floor_Name%>"></asp:Label>:
                            </th>
                            <td>
                                <telerik:RadComboBox ID="cmbfloorname" runat="server" Height="100px" Width="175px"
                                    TabIndex="4">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="rf_validatorfloor" runat="server" ControlToValidate="cmbfloorname"
                                    InitialValue="---Select---" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                    ValidationGroup="rf_validationgroup" SetFocusOnError="true"> 
                                </asp:RequiredFieldValidator>
                                <asp:Label runat="server" ID="lblfloorname" CssClass="linkText"></asp:Label>
                            </td>
                            <td width="50px">
                            </td>
                            <th width="100" align="left">
                                <asp:Label ID="Label10" runat="server" Text="<%$Resources:Resource,  Gross_Area%>"></asp:Label>:
                            </th>
                            <td>
                                <asp:TextBox ID="txt_Grossarea" runat="server" CssClass="SmallTextBox" TabIndex="9"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator_txt_Grossarea" ControlToValidate="txt_Grossarea"
                                    runat="server" ErrorMessage="Only numbers allowed" ValidationGroup="rf_validationgroup"
                                    ValidationExpression="^-?\d*\.?\d*"></asp:RegularExpressionValidator>
                                <asp:Label runat="server" ID="lblGrossArea" CssClass="linkText"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px">
                            </td>
                        </tr>
                        <tr>
                            <th width="100" align="left">
                                <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource,  Category%>"></asp:Label>:
                            </th>
                            <td>
                                <%--<telerik:RadComboBox ID="cmbcategory" runat="server"  height="100px" width="175px"></telerik:RadComboBox>--%>
                                <table cellspacing="5" cellpadding="5">
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="lblcategory" CssClass="linkText"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="lnkbtncategory" runat="server" Text="<%$Resources:Resource,Select%>"
                                                CssClass="linkText" TabIndex="5" OnClientClick="javascript:return omniclass_popup();"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="50px">
                            </td>
                            <th width="100" align="left">
                                <asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource,  Usable_Height%>"></asp:Label>:
                            </th>
                            <td>
                                <asp:TextBox ID="txtusableheight" runat="server" CssClass="SmallTextBox" TabIndex="10"></asp:TextBox>
                                <asp:Label runat="server" ID="lblusableheight" CssClass="linkText"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px">
                            </td>
                        </tr>
                        <%-- <tr>
          
<td width="100" align="left" >
            <asp:Label ID="lblRoomtagheading1" runat="server"  Text="<%$Resources:Resource, Room_Tag%>" CssClass="Label" ></asp:Label> :
        </td>
        <td>
        <asp:TextBox ID="txtRoomTag1" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
        <asp:Label runat="server" ID="lblroomtag1"  CssClass="linkText" ></asp:Label> 
        

        </td> 

<td width="100px"></td>
          
          </tr>--%>
                        <tr>
                            <%-- <td width="100" align="left">
            <asp:Label runat="server" Text="<%$Resources:Resource, Document%>"  CssClass="Label" ></asp:Label> :
        </td>--%>
                            <%-- <td width="40%">
       <telerik:RadGrid ID="rgDocuments" Width="70%" runat="server" BorderWidth="1px" CellPadding="0"
                            AllowPaging="true" PageSize="10" 
                            AutoGenerateColumns="False" AllowSorting="True"
                            PagerStyle-AlwaysVisible="false" Skin="Hay"  OnItemCommand="rgDocument_ItemCommand" OnSortCommand="btn_refresh_Click" >
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" />
                            <MasterTableView DataKeyNames="document_id">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="document_id" HeaderText="document_id" UniqueName="task_id"
                                        Visible="False">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="document_name" UniqueName="document_name"
                                        HeaderText="<%$Resources:Resource,  Document_Name%>" SortExpression="document_name" >
                                        <ItemStyle CssClass="column" />
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hlnkDocName" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"file_path")%>'
                                                Text='<%# DataBinder.Eval(Container.DataItem,"document_name")%>' runat="server"
                                                Target="_blank"></asp:HyperLink>
                                            <%--<asp:Label ID="lblDocName" Text='<%# DataBinder.Eval(Container.DataItem,"document_name")%>'
                                                CssClass="linkText" runat="server"></asp:Label>--%>
                            <%--     </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="document_id" UniqueName="document_id" Visible="true">
                                        <ItemStyle CssClass="column" Width="5%" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deleteDocument"
                                                ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return deleteSpaceDocument();" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
        </td>--%>
                            <td width="100px">
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" align="left">
                                <telerik:RadButton ID="btnsave" runat="server" Text="<%$Resources:Resource, Save%>"
                                    Skin="Default" Width="90px" OnClick="btnsave_Click" ValidationGroup="rf_validationgroup" />
                                <%--<asp:Button  ID="btnadddocument" runat="server" Text="<%$Resources:Resource,  Add_Document%>" pk_document_id='00000000-0000-0000-0000-000000000000'
                OnClientClick="javascript:return load_popup(this);" 
                  />--%>
                                <telerik:RadButton ID="btncancel" runat="server" Text="<%$Resources:Resource,  Cancel%>"
                                    Skin="Default" Width="90px" OnClick="btncancel_Click" OnClientClick="javascript:close_Window();" />
                                <asp:Button ID="btnclose" runat="server" Width="100" Text="<%$Resources:Resource, Close%>"
                                    OnClientClick="Javascript:closewindow();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div id="divbtn" style="display: none;">
            <asp:HiddenField ID="hfFacility_id" runat="server" />
            <asp:HiddenField ID="hf_lblOmniClassid" runat="server" />
            <asp:HiddenField ID="hf_floor_id" runat="server" />
            <asp:HiddenField ID="hfpopupflag" runat="server" ClientIDMode="Static" />
            <asp:Button ID="btn_refresh" runat="server" OnClick="btn_refresh_Click" Style="display: none;" />
        </div>
    </div>
    <telerik:RadWindowManager Visible="true" ID="rad_window" VisibleStatusbar="false"
        runat="server" Skin="">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" OffsetElementID="txtspacename"
                Animation="Slide" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="true"
                AutoSize="false" Width="600" Height="400" VisibleStatusbar="false" Behaviors="Move,Resize"
                VisibleOnPageLoad="false" Skin="">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadWindowManager ID="rd_manger_NewUI" runat="server" VisibleTitlebar="true"
        Title="Assign Category" Behaviors="Close,Move" BorderWidth="0px" Skin="Simple"
        BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rd_window_master_Uniformat" runat="server" DestroyOnClose="false"
                OffsetElementID="btn_search" AutoSize="false" AutoSizeBehaviors="Default" VisibleStatusbar="false"
                VisibleOnPageLoad="false" EnableAjaxSkinRendering="false" EnableShadow="true"
                Width="450" Modal="true" Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadAjaxManagerProxy ID="Space_mgr" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbfacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbfloorname" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadCodeBlock ID="loadPopUp" runat="server">
        <script language="javascript" type="text/javascript">

            function deleteSpaceDocument() {
                var flag;
                flag = confirm("Do you want to delete this document?");
                return flag;
            }

            function load_popup(reg) {
                var url = "../Locations/AddDocument.aspx?Item_type=Space&fk_row_id=" + document.getElementById("hflocationid").value + "&Document_Id=" + reg.pk_document_id;
                manager = $find("<%= rad_window.ClientID %>");
                var windows = manager.get_windows();
                windows[0].setUrl(url);
                windows[0].show();
                //windows[0].set_modal(false);
                return false;
            }
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function adjustParentWindowSize() {
                window.parent.navigate_spacepopup();
            }

            function adjsutHeightToReverce() {

                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    wnd.set_height(document.body.scrollHeight + 50)
                    //wnd.set_height(350)
                }
            }
            function adjustHeight() {

                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    //alert(x);
                    //alert(y);
                    //wnd.moveTo(x, 25);
                    //alert('window page' + document.body.scrollHeight);
                    //wnd.set_height(y)
                    wnd.set_height(document.body.scrollHeight + 50)
                    // alert('window page' + document.body.offsetWidth);
                    //wnd.set_width(document.body.scrollWidth+200)
                }
            }
            function omniclass_popup() {

                var url = "../Locations/AssignOmniclass.aspx?Item_type=Space&id=" + document.getElementById("hflocationid").value;
                manager = $find("<%= rd_manger_NewUI.ClientID %>");
                var windows = manager.get_windows();
                windows[0].setUrl(url);
                windows[0].show();
                windows[0].set_modal(false);
                adjustHeight();
                return false;
            }

            function regreshgrid() {
                document.getElementById("btn_refresh").click();
            }



            function load_omni_class(name, id) {

                document.getElementById("hf_lblOmniClassid").value = id;
                var reg = new RegExp('&nbsp;', 'g');
                name = name.replace(reg, ' ');
                document.getElementById("lblcategory").innerText = name;
            }
         

                  
        </script>
    </telerik:RadCodeBlock>
    </form>
</body>
<link href="../../App_Themes/EcoDomus/PopupStyleSheet.css" rel="stylesheet" type="text/css" />
</html>
<%-- </asp:Content> --%>