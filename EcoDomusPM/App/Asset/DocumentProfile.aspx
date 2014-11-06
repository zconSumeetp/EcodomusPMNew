<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocumentProfile.aspx.cs"
    Inherits="App_Asset_DocumentProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
  
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" language="javascript">
            function navigate() {

                top.window.location = "Document.aspx";
            }
            function setFocus() {

                if (document.getElementById("<%=txtname.ClientID %>") != null)
                    document.getElementById("<%=txtname.ClientID %>").focus();
                parent.set_Height();
              }
            window.onload = setFocus;
        </script>
        <script type="text/javascript" language="javascript">

            function select() {
                window.opener.regreshgrid();
                closeWindow();
            }
            //this function used to resize the radwindow on opening of pop ups
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function resiseParentPopwindow(str) {
        
                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    if(str == 'expand' )
                        wnd.set_height(document.body.scrollHeight + 50);
                    else
                        wnd.set_height(document.body.scrollHeight + 50);
                   if(str == 'resize' )
                       wnd.set_height(document.body.scrollHeight + 40);
                    // wnd.set_width(document.body.scrollWidth + 160);
                }
            }
            function entity_popup() {

                if ($find("<%= rcbentity.ClientID %>").get_value() == "00000000-0000-0000-0000-000000000000") {
                    alert("Please select entity from the dropdown.");
                    return false;
                }

                var row_ids = "";
                var row_name = "";

                if (document.getElementById("<%=hf_row_ids.ClientID %>").value != "") {
                    if (document.getElementById("<%=hf_rowname.ClientID %>").value != "") {
                        row_name = document.getElementById("<%=hf_rowname.ClientID %>").value;
                    }

                    row_ids = document.getElementById("<%=hf_row_ids.ClientID %>").value;

                    document.getElementById("<%=hf_old_row_ids.ClientID %>").value = row_ids;

                    flag = document.getElementById("<%=hf_flag.ClientID %>").value;

                    var url = "../Locations/Select_Entity_PM.aspx?entityflag=" + document.getElementById("<%=hf_entityid.ClientID %>").value + "&entityname=" + document.getElementById("<%=hf_entityname.ClientID %>").value + "&row_ids=" + row_ids + "&flag=" + flag + "&row_name=" + row_name + "&facilityid=" + document.getElementById("<%=hf_facility_id.ClientID %>").value;
                }
                else {
                    var url = "../Locations/Select_Entity_PM.aspx?entityflag=" + document.getElementById("<%=hf_entityid.ClientID %>").value + "&entityname=" + document.getElementById("<%=hf_entityname.ClientID %>").value + "&row_ids=" + row_ids + "&facilityid=" + document.getElementById("<%=hf_facility_id.ClientID %>").value;
                }
                manager = $find("<%=rad_window.ClientID %>");
                var windows = manager.get_windows();
                windows[0].show();
                windows[0].setUrl(url);
                resiseParentPopwindow('expand');
                return false;
            }
            function load_facilityname(name, id, row_ids) {
                document.getElementById("<%=hf_row_ids.ClientID %>").value = id;
                document.getElementById("<%=hf_row_ids_old.ClientID %>").value = row_ids;
                document.getElementById("<%=hf_flag.ClientID %>").value = "N";
                var reg = new RegExp('&nbsp;', 'g');
                name = name.replace(reg, ' ');
                var reg1 = new RegExp('single', 'g')
                name = name.replace(reg1, "'");
                var old_row_ids = row_ids;
                document.getElementById("<%=hf_rowname.ClientID %>").value = name;
                document.getElementById("<%=lblentityname.ClientID %>").innerText = name;
                document.getElementById("<%=hf_lbl_entitynames.ClientID %>").value = name;
            }

            function GotoProfile(id, row_ids, entity_name) {
                //top.location.href = "DocumentProfile.aspx?DocumentId=" + id + "&fk_row_id=" + row_ids + "&entity_name=" + entity_name;
                window.location.href = "DocumentProfile.aspx?DocumentId=" + id + "&fk_row_id=" + row_ids + "&entity_name=" + entity_name;
            }
            function GotoProfilepopup(id, row_ids, entity_name) {
                window.location.href = "DocumentProfile.aspx?DocumentId=" + id + "&popupflag=popup" + "&fk_row_id=" + row_ids + "&entity_name=" + entity_name;
                resiseParentPopwindow('resize');
            }


            function Navigate() {
                if (document.getElementById('<%=hf_document_id.ClientID%>').value == "00000000-0000-0000-0000-000000000000") {
                    window.location = "../Asset/Document.aspx";
                }
                else {
                    window.location = "../Asset/DocumentProfile.aspx?DocumentId=" + document.getElementById('<%=hf_document_id.ClientID%>').value + "&fk_row_id=" + document.getElementById('<%=hf_row_ids.ClientID%>').value + "&entity_name=" + document.getElementById('<%=hf_entity_name.ClientID%>').value;

                }
            }
            function Navigatepopup() {

                window.location = "../Asset/DocumentProfile.aspx?DocumentId=" + document.getElementById('<%=hf_document_id.ClientID%>').value + "&fk_row_id=" + document.getElementById('<%=hf_rowid.ClientID%>').value + "&popupflag=popup";

                resiseParentPopwindow('resize');
            }
            function closewindow() {
                window.close();
            }
            function Validate() {
                var flag;
                flag = confirm("Do you want to delete this document?");
                return flag;
            }

        </script>
        <script src="../../App_Themes/EcoDomus/jquery-1.8.3.js" type="text/javascript"></script>
    </telerik:RadCodeBlock>
</head>

<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px;margin:0px;">
    <form id="form1" runat="server" style="margin: 0px 0px 0px 0px;">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager" EnableScriptCombine="false">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    
    <div id="divProfilePage" style="vertical-align: top; margin: 0px;width:102%; "
        runat="server">
       <table runat="server" id="tblHeader1" border="0" width="100%" style="display: none;"
        cellspacing="0">
        <tr>
            <td class="wizardHeadImage" style="width:100%;display: none;">
                <div class="wizardLeftImage">
                    <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,Document_Profile%>"
                        Visible="false" Font-Names="Verdana" Font-Size="11pt"></asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ibtn_close" Width="15px" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                        OnClientClick="Javascript:return closewindow();" />
                </div>
            </td>
        </tr>
    </table>
   <table id="tbldocprofile" style="margin: 0px 20px 0px 20px; " border="0">
                <caption>
                    <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Document_Profile%>"></asp:Label>
                </caption>
                <tr>
                    <td style="height: 03px;width:100%;" colspan="4">
                    </td>
                </tr>
                <tr>
                    <th style="width: 10%">
                        <asp:Label runat="server" Text="<%$Resources:Resource, Name%>" CssClass="Label"></asp:Label>:
                    </th>
                    <td style="width: 25%">
                        <asp:TextBox ID="txtname" runat="server" CssClass="smallTextBox" Width="155" TabIndex="1"></asp:TextBox>
                        <asp:Label ID="lblname" runat="server" CssClass="linkText" Visible="false"></asp:Label>
                        <asp:RequiredFieldValidator ValidationGroup="valid" ID="RequiredFieldValidator1"
                            Display="Dynamic" SetFocusOnError="true" runat="server" ControlToValidate="txtname"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                    <th style="width: 15%">
                        <asp:Label runat="server" Text="<%$Resources:Resource, Description%>" CssClass="Label"></asp:Label>:
                    </th>
                    <td style="width: 30%">
                        <asp:TextBox ID="txtdescription" runat="server" CssClass="smallTextBox" Width="155"
                            TabIndex="5"></asp:TextBox>
                        <asp:Label ID="lbldescription" runat="server" CssClass="linkText" Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 20px" colspan="4">
                    </td>
                </tr>
                <tr>
                    <th>
                        <asp:Label runat="server" Text="<%$Resources:Resource, Entity%>" CssClass="Label"></asp:Label>:
                    </th>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadComboBox ID="rcbentity" runat="server" CssClass="smallTextBox" AutoPostBack="True"
                                        OnSelectedIndexChanged="rcbentity_SelectedIndexChanged" TabIndex="2">
                                    </telerik:RadComboBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblentity" runat="server" CssClass="linkText"></asp:Label>
                                    <asp:RequiredFieldValidator ValidationGroup="valid" InitialValue="--Select--" ID="RequiredFieldValidator3"
                                        SetFocusOnError="true" Display="Dynamic" runat="server" ForeColor="Red" ControlToValidate="rcbentity"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <th>
                                    <asp:Label runat="server" ID="lbl" Text="<%$Resources:Resource, Entity_Name%>" CssClass="Label"></asp:Label>:
                     </th>
                    <td>
                        <table>
                            <tr>
                                
                                <td>
                                    <asp:Label ID="lblentityname" runat="server" Style="display: inline" CssClass="linkText"></asp:Label>
                                </td>
                                <td >
                                    <asp:LinkButton ID="lnkselect" runat="server"  Font-Names="Arial" Font-Size="8" Text="<%$Resources:Resource, Select%>"
                                        OnClientClick="javascript:return entity_popup();" TabIndex="6"></asp:LinkButton>
                                </td>
                                <td>
                        
                     <asp:Label ID="lblvalidate" runat="server" Text="*" CssClass="LabelNormal" Visible="false"
                                        ForeColor="Red"></asp:Label>
                   </td>
                            </tr>
                        </table>
                    </td>
                    
                    
                    </tr>
                      <tr>
                <td style="height: 20px" colspan="4">
                </td>
            </tr>
            <tr>
                <th>
                    <asp:Label runat="server" Text="<%$Resources:Resource, Category%>" CssClass="Label"></asp:Label>:
                </th>
                <td>
                    <telerik:RadComboBox ID="rcbcategory" runat="server" CssClass="smallTextBox" CausesValidation="false"
                        Filter="Contains" TabIndex="3">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblcategory" runat="server" CssClass="linkText" Visible="false"></asp:Label>
                    <asp:RequiredFieldValidator ValidationGroup="valid" InitialValue="--Select--" ID="RequiredFieldValidator2"
                        SetFocusOnError="true" Display="Dynamic" runat="server" ForeColor="Red" ControlToValidate="rcbcategory"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <th>
                    <asp:Label runat="server" Text="<%$Resources:Resource, Approval_By%>" CssClass="Label"></asp:Label>:
                </th>
                <td>
                    <telerik:RadComboBox ID="rcbapproval" runat="server" CssClass="smallTextBox" TabIndex="7">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblapproval" runat="server" CssClass="linkText" Visible="false"></asp:Label>
                    <asp:RequiredFieldValidator ValidationGroup="valid" InitialValue="--Select--" ID="RequiredFieldValidator4"
                        SetFocusOnError="true" Display="Dynamic" runat="server" ForeColor="Red" ControlToValidate="rcbapproval"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="height: 20px" colspan="4">
                </td>
            </tr>
            <tr>
                <th>
                    <asp:Label runat="server" Text="<%$Resources:Resource, Stage%>" CssClass="Label"></asp:Label>:
                </th>
                <td>
                    <telerik:RadComboBox ID="rcbstage" runat="server" CssClass="smallTextBox" TabIndex="4">
                    </telerik:RadComboBox>
                    <asp:Label ID="lblstage" runat="server" CssClass="linkText" Visible="false"></asp:Label>
                    <asp:RequiredFieldValidator ValidationGroup="valid" InitialValue="--Select--" ID="RequiredFieldValidator5"
                        SetFocusOnError="true" Display="Dynamic" runat="server" ForeColor="Red" ControlToValidate="rcbstage"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <th>
                    <asp:Label runat="server" Text="<%$Resources:Resource, File_Name%>" CssClass="Label"></asp:Label>:
                </th>
                <td>
                    <telerik:RadUpload TabIndex="8" EnableFileInputSkinning="false" ID="ruDocument" runat="server"
                        InitialFileInputsCount="1" OverwriteExistingFiles="false" ControlObjectsVisibility="none"
                        Width="220px">
                    </telerik:RadUpload>
                    <asp:Label ID="lbl_document_path" runat="server" Visible="false"></asp:Label>
                    <%--<asp:LinkButton ID="lbl_document_path" runat="server" Visible="false" ></asp:LinkButton>--%>
                    <asp:HiddenField ID="hfAttachedFile" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="height: 20px" colspan="4">
                </td>
            </tr>
            <tr>
                <th>
                    <asp:Label ID="lblcreated_by_heading" runat="server" Text="<%$Resources:Resource, Created_By_1%>"
                        CssClass="Label"></asp:Label>
                </th>
                <td>
                    <asp:Label ID="lblcreated_by" runat="server" Text="" CssClass="linkText"></asp:Label>
                </td>
                <th>
                    <asp:Label ID="lblcreated_on_heading" runat="server" Text="<%$Resources:Resource, Created_On_1%>"
                        CssClass="Label"></asp:Label>
                </th>
                <td>
                    <asp:Label ID="lblcreated_on" runat="server" Text="" CssClass="linkText"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="height: 20px" colspan="4">
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="btnEdit" runat="server" Width="100" Text="<%$Resources:Resource, Edit%>"
                                    Visible="false" OnClick="btnEdit_Click" TabIndex="9" />
                            </td>
                            <td>
                                <asp:Button ID="btnSave" runat="server" Width="100" Text="<%$Resources:Resource, Save%>"
                                    OnClick="btnSave_Click" ValidationGroup="valid" TabIndex="10" />
                            </td>
                            <td>
                                <asp:Button ID="btnCancel" runat="server" Width="100" Text="<%$Resources:Resource, Cancel%>"
                                    OnClick="btnCancel_Click" TabIndex="11" />
                            </td>
                            <td>
                                <asp:Button ID="btnDelete" runat="server" Width="100" Text="<%$Resources:Resource, Delete%>"
                                    OnClick="btnDelete_click" TabIndex="11" OnClientClick="Javascript:return Validate();" />
                            </td>
                            <td>
                                <asp:Button ID="btnclose" runat="server" Width="100" Text="<%$Resources:Resource, Close%>"
                                    OnClientClick="Javascript:closewindow();" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red" Font-Size="10pt"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="display: none">
                    <asp:HiddenField ID="hf_document_id" runat="server" />
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <asp:HiddenField ID="hf_entityname" runat="server" />
                            <asp:HiddenField ID="hf_entityid" runat="server" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:HiddenField ID="hf_rowid" runat="server" />
                    <asp:HiddenField ID="hf_rowname" runat="server" />
                    <asp:HiddenField ID="hfpopupflag" runat="server" ClientIDMode="Static" />
                    <asp:HiddenField ID="hf_filename" runat="server" />
                    <asp:HiddenField ID="hf_row_ids" runat="server" />
                    <asp:HiddenField ID="hf_entity_name" runat="server" />
                    <asp:HiddenField ID="hf_old_document_name" runat="server" />
                    <asp:HiddenField ID="hf_row_ids_old" runat="server" />
                    <asp:HiddenField ID="hf_lbl_entitynames" runat="server" />
                    <asp:HiddenField ID="hf_flag" runat="server" />
                    <asp:HiddenField ID="hf_cancel" runat="server" />
                    <asp:HiddenField ID="hf_old_row_ids" runat="server" />
                    <asp:HiddenField ID="hf_facility_id" runat="server" />
                </td>
            </tr>
            </table>
       
    </div>
    <telerik:RadAjaxManagerProxy ID="DocumentProfileProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rcbentity">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="hf_entityid" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="hf_row_ids" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="hf_entityname" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="lblentityname" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="hf_lbl_entitynames" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="0px" Width="0px">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager Visible="true" ID="rad_window"  runat="server" VisibleTitlebar="true"   Behaviors="Close,Move"  
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server"   DestroyOnClose="false"  AutoSize="false" 
                VisibleStatusbar="false" VisibleOnPageLoad="false" Left="15" Top="5" EnableAjaxSkinRendering="false" EnableShadow="true" 
                Overlay="false"   Width="600" Height="460" >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    </div> </div> </div>
    </form>
</body>
  <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
</html>
