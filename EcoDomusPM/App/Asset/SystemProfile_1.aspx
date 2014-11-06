<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SystemProfile_1.aspx.cs" Inherits="App_Asset_SystemProfile_1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
 <html>
<head>
    <title>System Profile </title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />

<telerik:RadCodeBlock ID="loadPopUp" runat="server">

     <script language="javascript" type="text/javascript">
         function Navigate() 
         {
             if (document.getElementById('hfSystemId').value == '00000000-0000-0000-0000-000000000000') {
                 top.location.href = 'System.aspx';
             }
             else {
                 if (document.getElementById('btnEdit') == null) {
                     var query = parent.location.search.substring(1);
                     var flag = query.split("=");
                     var reg = new RegExp(flag[1], 'g');
                     var str = window.parent.location.href;
                     str = str.replace(reg, document.getElementById('hfSystemId').value);
                     window.parent.location.href = str;
                 }
                 else {
                     top.location.href = 'System.aspx';
                 }
             }
         }
         function open_system(system_id) {

             top.location.href = "Systemmenu.aspx?system_id=" + system_id + "";

         }

         function close(sender, args) {
             window.close();
           }

         function closewindow() {
         
             window.close();
             return false;
         }
         function RefreshParent() 
         {         
//             var query = parent.location.search.substring(1);
//             var flag = query.split("=");
//             var reg = new RegExp(flag[1], 'g');
//             var str = window.parent.location.href;
//             str = str.replace(reg, document.getElementById('hfSystemId').value);            
             str = str = '../Asset/SystemMenu.aspx?system_id=' + document.getElementById('hfSystemId').value+"&page_load=SystemProfile";
             window.parent.location.href = str;
         }
         function RefreshParentpopup() {
              str = str = '../Asset/Systemprofile.aspx?system_id=' + document.getElementById('hfSystemId').value + "&page_load=SystemProfile&popupflag=popup&value=system";
             window.location.href = str;
         }


         function OpenOmniclassWindow() {
             var url = "../Locations/AssignOmniclass.aspx?Item_type=System";
             manager = $find("<%= rad_window.ClientID %>");
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
             strlblOmniClassid_uniqueID = strlblOmniClassid_uniqueID.slice("6");
             document.getElementById('hf_lblOmniClassid').value = id;
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
         function LogoutNavigation() {

             var query = parent.location.href;
             top.location.href(query);

         }

         function CloseWindow1() {

             // GetRadWindow().BrowserWindow.referesh_project_page();
             window.close();
             //top.location.reload();
             //GetRadWindow().BrowserWindow.adjust_parent_height();
             return false;
         }
         function CancelWindow() {
             CloseWindow1();
         }
     </script>

     <style type="text/css">
    
	 td{
	         font-size : 12px;
	         font-weight : normal;
	         padding-left: 0px;
	         font-weight:normal;
	         font-family: Arial, Helvetica, sans-serif;
	         vertical-align: text-top;
	         text-align:left;
	         table-layout:fixed;
	    }
    </style>
 </telerik:RadCodeBlock>
  

   <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" style="margin: 0 0 0 0">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
    <div id="divProfilePage" style="width: 100%; padding: 2px;" runat="server">
        <table runat="server" id="tbltitle" border="0" cellpadding="0" cellspacing="0" width="100%"
            style="border-collapse: collapse;display:none;">
            <tr>
                <td class="wizardHeadImage"  style="border-collapse: collapse;display:none;">
                    <div class="wizardLeftImage">
                        <%-- <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />--%>
                        <asp:Label ID="lblpopup" Style="padding-left: 0px;" runat="server"></asp:Label>
                    </div>
                    <div class="wizardRightImage">
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                            OnClientClick="javascript:return CancelWindow();" />
                    </div>
                </td>
            </tr>
        </table>
        <table style="margin-top: 15px; margin-left: 20px;" align="left">
            <%--<caption>
            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, System_Profile%>"></asp:Label>
            </caption>--%>
            <tr>
                <td style="height: 10px">
                </td>
            </tr>
            <tr>
                <th>
                    <asp:Label ID="lblDescription" Text="<%$Resources:Resource, Description%>" runat="server"
                        CssClass="Label"></asp:Label>:
                </th>
                <td>
                    <asp:Label ID="lblSystemDescription" Text="" runat="server" Style="font-size: 11px;"></asp:Label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="SmallTextBox" TabIndex="4"></asp:TextBox>
                </td>
                 <td style="height: 30px">
                </td>
                <th>
                    <asp:Label ID="lblCategory" Text="<%$Resources:Resource, Category%>" runat="server"
                        CssClass="Label"></asp:Label>:
                </th>
                <td>
                    <div runat="server" id="td_category">
                        <asp:Label ID="lblOmniClass" runat="server" Text="" Style="font-size: 11px;"></asp:Label>
                        <asp:LinkButton ID="lnkAddOmniclass" runat="server" CssClass="linkText" OnClientClick="javascript:return OpenOmniclassWindow()"
                            TabIndex="3">Add</asp:LinkButton>
                    </div>
                </td>
            </tr>
           
            
            <tr>
                <td style="height: 10px">
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
                <th>
                    <asp:Label ID="lblFacility" Text="<%$Resources:Resource, Facility%>" runat="server"
                        CssClass="Label"></asp:Label>:
                </th>
                <td>
                    <asp:Label ID="lblFacilityNames" Text="" runat="server" Style="font-size: 11px;"
                        TabIndex="2"></asp:Label>
                    <%--<telerik:RadComboBox Width="170px" ID="cmbfacility"  runat="server" oncopy="return false;"  
                        onpaste="return false;" oncut="return false;" onkeypress="return tabOnly(event)"
                        onmousewheel="return false" OnItemDataBound="cmbfacility_ItemDataBound"></telerik:RadComboBox>--%>
                    <telerik:RadComboBox Width="170px" ID="cmbfacility" Filter="Contains" TabIndex="2" 
                        runat="server" oncopy="return false;" AllowCustomText="True" onpaste="return false;"
                        oncut="return false;" onkeypress="return tabOnly(event)" onmousewheel="return false"
                        OnItemDataBound="cmbfacility_ItemDataBound" AutoPostBack="True">
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Text='<%# Eval("name") %>' />
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="*" ControlToValidate="cmbfacility"
                        ForeColor="Red" SetFocusOnError="true" runat="server" InitialValue="" ValidationGroup="save" />
                </td>
                <td style="height: 30px">
                </td>
                 <th>
                    <asp:Label ID="lblParentSystem" Text="<%$Resources:Resource,Parent_System%>" runat="server"
                        CssClass="Label"></asp:Label>:
                </th>
                <td>
                    <asp:Label ID="lblparentsystemname" runat="server" Style="font-size: 11px;"></asp:Label>
                </td>
            </tr>
            
           
            <tr>
                <td colspan="5">
                    <table>
                        <tr>
                            <td style="height: 40px">
                                <telerik:RadButton ID="btnSave" runat="server" Text="<%$Resources:Resource, Save%>"
                                    Width="70px" Skin="Default" OnClick="btnSave_Click" TabIndex="5" ValidationGroup="save" />
                                <telerik:RadButton ID="btnEdit" runat="server" Text="<%$Resources:Resource, Edit%>"
                                    Width="70px" Skin="Default" OnClick="btnEdit_Click" />
                                <telerik:RadButton ID="btnCancel" runat="server" Text="<%$Resources:Resource, Cancel%>"
                                    Width="70px" OnClientClicked="Navigate" AutoPostBack="true" TabIndex="6" />
                                <telerik:RadButton ID="btndelete" runat="server" Text="<%$Resources:Resource, Delete%>"
                                    Width="70px" OnClick="btndelete_Click" OnClientClicked="delete_" AutoPostBack="true"
                                    TabIndex="6" />
                                <telerik:RadButton ID="btnclose" runat="server" Width="70" Text="<%$Resources:Resource, Close%>"
                                    OnClientClicked="close" AutoPostBack="true" >
                                </telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                    </td>
            </tr>
        </table>
    </div>
    <telerik:RadWindowManager Visible="true" ID="rad_window" VisibleStatusbar="false"
        AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server"
        KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_omniclass_popup" runat="server" 
                Animation="Slide" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="true"
                AutoSize="false" Title="Add Omniclass" Width="900" Height="400" VisibleStatusbar="false"
                 VisibleOnPageLoad="false" Skin="Default" Behaviors="Move, Resize">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
                <asp:HiddenField ID="hf_lblOmniClassid" runat="server" />
                <asp:HiddenField ID="hf_page" runat="server" />
                <asp:HiddenField ID="hf_uniclass" runat="server" />
                <asp:HiddenField ID="hf_omniclass" runat="server" />
                <asp:HiddenField ID="hfpopupflag" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hfSystemId" runat="server" />
    </form>
</body>
</html>
