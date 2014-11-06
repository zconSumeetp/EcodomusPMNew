<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RoleDetails.aspx.cs" Inherits="App_Settings_RoleDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%-- <link href="../../App_Themes/EcoDomus/style_new_1.css" rel="stylesheet" type="text/css" /> --%>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" language="javascript">


          


            function resize_frame_page() {
                //window.resizeTo(1000, height);

                var docHeight;
                try {
                    var obj = parent.window.frames[1];
                    if (obj != null) {

                        window.parent.resize_iframe(parent.window.frames[1]);
                    }
                }
                catch (e) {
                    window.status = 'Error: ' + e.number + '; ' + e.description;
                }
            }


            function chkdelete() 
            {
                var flag;
                flag = confirm("Do you want to delete this Role ?");
                return flag;
            }

            function openpopupVersioning(attributeid) {


                manager = $find("rad_windowmgr");
                var url;
                url = "../Asset/AttributeVersioningPopup.aspx?attribute_id=" + attributeid + "&attribute_flag=Asset";

                if (manager != null) {

                    var windows = manager.get_windows();
                    windows[0].setUrl(url);
                    windows[0].show();
                    //windows[0].set_modal(false);
                    //  window.moveBy(0, -20);
                    windows[0].set_top(200);
                }
                return false;
            }

            function CancelNavigation() {

                top.location.href = "../Settings/Roles.aspx";
            }


            function validate() {
                alert("Attribute with this name already exists.");
                return false;
            }

             function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }

        function getRole_Id() {
        
                var roleid = window.parent.document.getElementById("ContentPlaceHolder1_hf_roleId").value;
                //                alert(roleid);
                document.getElementById("hf_roleId_roleDetail").value = roleid;
                document.getElementById("hdnbtn").click();

            }

            function NavigateTo(id) {
                top.location.href = "../Settings/RolesMenu.aspx?roleId=" + id;
            }

          
           

        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
        .style1
        {
            height: 27px;
        }
        .style2
        {
            height: 26px;
        }
        
        .html
        {
            overflow:hidden;
            height:10%;
        }
        
    </style>
  <%--  <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
  --%>  <%-- <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" /> --%>
    <%--<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />--%>
</head>
 <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
     <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
<body  style="overflow:hidden;background-color:transparent;">
    <form id="form1" runat="server" defaultfocus="txtRoleName">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
    <div id="divRoleDetailsId" class="tdZebraLightGray" style="width: 100%; height:410px; "  runat="server">
        <table width="95%"> 
            <tr>
                <td colspan="2" class="style1">
                </td>
            </tr>
            <tr>
                <th align="left" style="width:10%" valign="top">
                    <asp:Label ID="lbl_RoleName" Text="<%$Resources:Resource, Name%>" runat="server"></asp:Label>:
                </th>
                <td>
                    <asp:TextBox ID="txtRoleName" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lblRoleName" Style="font-size: 11px;" runat="server"></asp:Label>
                    <asp:RequiredFieldValidator ID="rf_space_name" ValidationGroup="rf_validationgroup"
                        runat="server" ControlToValidate="txtRoleName" ErrorMessage="*" ForeColor="Red"
                        Display="Dynamic" Visible="true" SetFocusOnError="true">
                    </asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <th align="left" style="width:10%" valign="top">
                    <asp:Label ID="lbl_RoleDesc" Text="<%$Resources:Resource, Description%>" runat="server"></asp:Label>:
                </th>
                <td>
                    <asp:TextBox ID="txtRoleDesc" CssClass="SmallTextBox" runat="server"></asp:TextBox>
                    <asp:Label ID="lblRoleDesc" Style="font-size: 11px;" runat="server"></asp:Label>
                </td>
            </tr>
            <tr><td style="height:5px"></td></tr>
            <tr>
                <td class="style2" colspan="2">
                    <asp:Button ID="btnAdd" runat="server" Width="80px" Text="<%$Resources:Resource,Add_Details%>" OnClick="btnAdd_Click"  Skin="Default" ValidationGroup="rf_validationgroup" />
                    <asp:Button ID="btnEdit" runat="server" Text="<%$Resources:Resource, Edit%>" Width="80px" OnClick="btnEdit_Click"  Skin="Default"  />
                    <asp:Button ID="btnDelete" runat="server" 
                        Text="<%$Resources:Resource, Delete%>" Width="80px" Skin="Default" 
                        onclick="btnDelete_Click"  OnClientClick="javascript:return chkdelete();"  />
                    <asp:Button ID="btnSave" runat="server" Text="<%$Resources:Resource, Save%>" Width="80px" OnClick="btnSave_Click"  Skin="Default" ValidationGroup="rf_validationgroup" />
                    <asp:Button ID="btnCancel" runat="server" Text="<%$Resources:Resource, Cancel%>" Width="90px"  Skin="Default" OnClick="btnCancel_Click" />
                    </td>
                     <td style="display:none">
                    <asp:Button ID="hdnbtn" runat="server" OnClick="hdnbtn_Click" Style="display: none" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hf_roleId_roleDetail" runat="server" />
          <asp:HiddenField ID="hf_system_role" runat="server" />
    </div>
    </form>
</body>
</html>
