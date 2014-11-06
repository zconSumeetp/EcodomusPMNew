<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SystemProfile.aspx.cs" Inherits="App_Asset_SystemProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head>
    <title>System Profile </title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    
    <telerik:RadCodeBlock ID="loadPopUp" runat="server">
        <script language="javascript" type="text/javascript">


            function Navigate() {

                if (document.getElementById('hfSystemId').value == '00000000-0000-0000-0000-000000000000') {
                    top.location.href = 'System.aspx';
                }
                else {
                     if (document.getElementById('hfpopupflag').value == 'popup') {

                        str = '../Asset/Systemprofile_1.aspx?system_id=' + document.getElementById('hfSystemId').value + "&popupflag=popup&value=system";
                        window.location.href = str;
                    }
                    else {
                        str = str = '../Asset/SystemMenu.aspx?system_id=' + document.getElementById('hfSystemId').value;
                        window.parent.location.href = str;

                    }
                }
       
                return false;
            }


            function RefreshParent() {
                //             var query = parent.location.search.substring(1);
                //             var flag = query.split("=");
                //             var reg = new RegExp(flag[1], 'g');
                //             var str = window.parent.location.href;
                //             str = str.replace(reg, document.getElementById('hfSystemId').value);


                str = '../Asset/SystemMenu.aspx?system_id=' + document.getElementById('hfSystemId').value;
                window.parent.location.href = str;
            }
            function RefreshParentpopup() {

                str = '../Asset/Systemprofile_1.aspx?system_id=' + document.getElementById('hfSystemId').value + "&popupflag=popup&value=system";
                window.location.href = str;
            }

            function OpenOmniclassWindow() {
                
                var url = "../Locations/AssignOmniclass.aspx?Item_type=System";
                manager = $find("<%= rd_manger_NewUI.ClientID %>");
                var windows = manager.get_windows();
                windows[0].show();
                windows[0].setUrl(url);
                //windows[0].set_modal(false);
                return false;
            }

            function load_omni_class(name, id) {

                var radButton = $find("<%=btnSave.ClientID %>");
                var strradButton_uniqueID = radButton._uniqueID;
                var strhf_lblOmniClassid_uniqueID = strradButton_uniqueID.replace("btnSave", "hf_lblOmniClassid");
                var strradButton_clientStateFieldID = radButton._clientStateFieldID;
                var strlblOmniClassid_uniqueID = strradButton_clientStateFieldID.replace("btnSave_ClientState", "lblOmniClass");
                var isuniclass = document.getElementById('hf_uniclass').value;
                strlblOmniClassid_uniqueID = strlblOmniClassid_uniqueID.slice("6");
                if (isuniclass == 'Y') {
                    document.getElementById('hf_uniclass_id').value = id;
                    document.getElementById('hf_lblOmniClassid').value = '';
                }
                else {
                    document.getElementById('hf_uniclass_id').value = '';
                    document.getElementById('hf_lblOmniClassid').value = id;
                }
                var reg = new RegExp('&nbsp;', 'g');
                name = name.replace(reg, ' ');


                document.getElementById('lblOmniClass').innerText = name;
            }

            function delete_() {
                var flag;
                flag = confirm("Are you sure you want to delete?");
                return flag;
            }

            function naviagatetoProject() {
                top.location.href = "System.aspx";

            }

            function checkboxClick(sender) {

                collectSelectedItems(sender);

                $find("<%= cmbfacility.ClientID %>").hideDropDown();
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
            function closewindow() {
               
                window.close();
                return false;
            }
            
            function closewindow1() {
                window.close();
                return false;
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
            function adjustHeight() {

                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    wnd.set_height(document.body.scrollHeight + 40)
                    wnd.set_width(document.body.scrollWidth + 30)
                   }
            }

            function adjsutHeightToReverce() {
                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    wnd.set_height(document.body.scrollHeight + 50)
                    wnd.set_width(document.body.scrollWidth + 10)
                }
            }

        </script>
    </telerik:RadCodeBlock>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" style="margin: 0 0 0 0" defaultfocus="txtSystemName">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
   
        <telerik:RadWindowManager Visible="true" ID="rad_window" VisibleStatusbar="false"
            AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server"
            KeepInScreenBounds="true">
            <Windows>
                <telerik:RadWindow Visible="true" ID="rd_omniclass_popup" runat="server" OffsetElementID="txtSystemName"
                    Animation="Slide" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="true"
                    AutoSize="false" Title="Add Omniclass" Width="700" Height="400" VisibleStatusbar="false"
                    VisibleOnPageLoad="false" Skin="Default" Behaviors="Move, Resize">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
        <telerik:RadWindowManager ID="rd_manger_NewUI"  runat="server" VisibleTitlebar="true"  Title="Assign Category" Behaviors="Close,Move"  
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
            <Windows>
                <telerik:RadWindow ID="rd_window_master_Uniformat" runat="server" ReloadOnShow="false"
                    Width="550" AutoSizeBehaviors="Height" DestroyOnClose="false" AutoSize="false"
                     VisibleStatusbar="false" VisibleOnPageLoad="false"  Top="0"
                    EnableAjaxSkinRendering="false" EnableShadow="true"
                    BorderWidth="0" Overlay="false">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
         <div style="width: 100%;padding:2px;" id="divProfilePage" runat="server">
         <table runat="server" id="tbltitle" border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse;display:none;">
            <tr>
            <td class="wizardHeadImage" style="border-collapse:collapse;display:none;">
                <div class="wizardLeftImage">
                   <%-- <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />--%>
                    <asp:Label ID="lblpopup" style="padding-left:10px ;" runat="server"></asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                         OnClientClick="javascript:return closewindow1();" />
                </div>
            </td>
        </tr>
    </table>
         <table style="margin-top: 10px; margin-left: 20px;" align="left">
           
            <%--<caption>
            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, System_Profile%>"></asp:Label>
            </caption>--%>
             <tr>
                <td>
                    <asp:Label ID="lblName" Text="<%$Resources:Resource, Name%>" runat="server" CssClass="Label"></asp:Label>:
                </td>
                <td>
                    <asp:Label ID="lblSystemName" Text="" runat="server" Style="font-size: 11px;"></asp:Label>
                    <asp:TextBox ID="txtSystemName" runat="server" CssClass="SmallTextBox" TabIndex="1"></asp:TextBox>
                    <asp:RequiredFieldValidator ErrorMessage="*" ControlToValidate="txtSystemName" ForeColor="Red"
                        SetFocusOnError="true" runat="server" ValidationGroup="save" />
                </td>
            </tr>
            <tr>
                <td style="height: 10px" colspan="2">
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblDescription" Text="<%$Resources:Resource, Description%>" runat="server"
                        CssClass="Label"></asp:Label>:
                </td>
                <td>
                    <asp:Label ID="lblSystemDescription" Text="" runat="server" Style="font-size: 11px;"></asp:Label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="SmallTextBox" TabIndex="2"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="height: 02px" colspan="2">
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblCategory" Text="<%$Resources:Resource, Category%>" runat="server"
                        CssClass="Label"></asp:Label>:
                </td>
                <td>
                    <table cellspacing="5" cellpadding="5">
                        <tr>
                            <td>
                                <asp:Label ID="lblOmniClass" runat="server" Text="" Style="font-size: 11px;"></asp:Label>
                            </td>
                            <td><div runat="server" id="td_category">
                                <asp:LinkButton ID="lnkAddOmniclass" runat="server" CssClass="linkText" OnClientClick="javascript:return OpenOmniclassWindow()"
                                    TabIndex="3">
                                    <asp:Label ID="Label1" Text="<%$Resources:Resource, Add%>" runat="server" CssClass="Label"></asp:Label></asp:LinkButton>
                                    </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height: 01px" colspan="2">
                </td>
            </tr>
            <%--    <tr>
            <td>
                <asp:Label ID="lblDescription" Text="<%$Resources:Resource, Description%>" runat="server" CssClass="Label"></asp:Label> :
            </td>
            <td>
                <asp:Label ID="lblSystemDescription" Text="" runat="server" Style="font-size: 11px;"></asp:Label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="SmallTextBox" TabIndex="4"></asp:TextBox>
            </td>
        </tr>--%>
            <tr>
                <td>
                    <asp:Label ID="lblFacility" Text="<%$Resources:Resource, Facility%>" runat="server"
                        CssClass="Label"></asp:Label>:
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblFacilityNames" Text="" runat="server" Style="font-size: 11px;"
                                    TabIndex="2"></asp:Label>
                                <%--<telerik:RadComboBox Width="170px" ID="cmbfacility"  runat="server" oncopy="return false;"  
                        onpaste="return false;" oncut="return false;" onkeypress="return tabOnly(event)"
                        onmousewheel="return false" OnItemDataBound="cmbfacility_ItemDataBound"></telerik:RadComboBox>--%>
                                <telerik:RadComboBox Width="170px" ID="cmbfacility" Filter="Contains" TabIndex="4" Height="100px"
                                    runat="server" oncopy="return false;" AllowCustomText="True" EmptyMessage="--Select--"
                                    onpaste="return false;" oncut="return false;" onkeypress="return tabOnly(event)"
                                    onmousewheel="return false" OnItemDataBound="cmbfacility_ItemDataBound" AutoPostBack="True">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CheckBox1" runat="server" Text='<%# Eval("name") %>' />
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="*" ControlToValidate="cmbfacility"
                                    ForeColor="Red" SetFocusOnError="true" runat="server" InitialValue="" ValidationGroup="save" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height: 10px" colspan="2">
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblParentSystem" Text="<%$Resources:Resource,Parent_System%>" runat="server"
                        CssClass="Label"></asp:Label>:
                </td>
                <td>
                    <asp:Label ID="lblparentsystemname" runat="server" Style="font-size: 11px;"></asp:Label>
                </td>
            </tr>
          
            <tr>
                <td style="padding-top:05px;" colspan="2">
                    <table width="100%">
                        <tr>
                            <td >
                                <telerik:RadButton ID="btnSave" runat="server" Text="<%$Resources:Resource, Save%>"
                                    Width="70px" Skin="Default" OnClick="btnSave_Click" TabIndex="5" ValidationGroup="save" />
                                <%--    <telerik:RadButton ID="btnEdit" runat="server" Text="<%$Resources:Resource, Edit%>" Width="70px"
                                Skin="Hay" onclick="btnEdit_Click"  />--%>
                          
                                 <telerik:RadButton ID="btnCancel" runat="server" Text="<%$Resources:Resource, Cancel%>"
                                    Width="70px" OnClick="btnCancel_Click" TabIndex="6" />
                          
                                 <telerik:RadButton ID="btndelete" runat="server" Text="<%$Resources:Resource, Delete%>"
                                    Width="70px" OnClick="btndelete_Click" OnClientClicked="delete_();"
                                    TabIndex="6" />
                         
                                 <telerik:RadButton ID="btnclose" runat="server" Width="70" Text="<%$Resources:Resource, Close%>"
                                    OnClientClicked="closewindow" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
         <asp:HiddenField ID="hf_lblOmniClassid" runat="server" />
                <asp:HiddenField ID="hfpopupflag" runat="server" ClientIDMode="Static" />
                <%-- <td>--%>
                <asp:HiddenField ID="hfSystemId" runat="server" />
                <asp:HiddenField ID="hf_uniclass" runat="server" />
                <asp:HiddenField ID ="hf_uniclass_id" runat="server" />
                <asp:HiddenField ID="hf_omniclass" runat="server" />
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="cmbfacility">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="cmbfacility" />
                    </UpdatedControls>
                    <%--<UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="CheckBox1" LoadingPanelID="loadingPanel1" />                 
                </UpdatedControls>--%>
                </telerik:AjaxSetting>
                <%-- <telerik:AjaxSetting AjaxControlID="cmbfacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="CheckBox1" LoadingPanelID="loadingPanel1" />                 
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        </telerik:RadAjaxLoadingPanel>
    </div>
    </form>
</body>
<link href="../../App_Themes/EcoDomus/PopupStyleSheet.css" rel="stylesheet" type="text/css" />
</html>
