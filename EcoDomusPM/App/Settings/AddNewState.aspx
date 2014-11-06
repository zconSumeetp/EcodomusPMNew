<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddNewState.aspx.cs" Inherits="App_Settings_AddNewState" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
    <script type="text/javascript">

        function ClearFields() {

            document.getElementById("txtName").value = "";
        }

        function confirm_insert() {
            //alert("Hi");
            var answer = confirm("Are you sure you want to insert?")
            if (answer)
                return true;
            else
                return false;

        }
        function Close() {
           
            if (window.parent.location.href.indexOf('OrganizationProfile') != -1) {
                if (document.getElementById("hfFlag").value == "country") {
                    window.parent.refreshgrid_country();
                }
                else if (document.getElementById("hfFlag").value == "state") {

                    window.parent.refreshgrid_state();
                }
                // parent.window.document.getElementById("btnrefresh").click();
                self.close();
            }
            else if (window.parent.location.href.indexOf('Userprofile') != -1) {
                if (document.getElementById("hfFlag").value == "country") {
                    window.parent.refreshgrid_country();
                }
                else if (document.getElementById("hfFlag").value == "state") {

                    window.parent.refreshgrid_state();
                }
                // parent.window.document.getElementById("ContentPlaceHolder1_btnrefresh").click();
                self.close();

            }
            else if (window.parent.location.href.indexOf('ClientUserProfile') != -1) {
                if (document.getElementById("hfFlag").value == "country") {
                    window.parent.refreshgrid_country();
                }
                else if (document.getElementById("hfFlag").value == "state") {

                    window.parent.refreshgrid_state();
                }
                // parent.window.document.getElementById("ContentPlaceHolder1_btnrefresh").click();
                self.close();

            }
            else if (window.parent.location.href.indexOf('AddManufacturerOrganization') != -1) {
                if (document.getElementById("hfFlag").value == "country") {
                    window.parent.refreshgrid_country();
                    window.parent.document.getElementById("btnrefreshcmbcountry").click();
                }
                else if (document.getElementById("hfFlag").value == "state") {

                    window.parent.refreshgrid_state();
                }

                self.close();

            }

        }
    
    </script>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
</head>
<body style="background: white; background-color: #EEEEEE;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="mgr" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <div style="height:250px;">
    <table style="height:200px; width: 100%;" >
        <tr style="width:100%;border-collapse:collapse;"  >
                <td  colspan="3">
                     <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse">
                        <tr>
                         <td class="wizardHeadImage" style="display:none;" >
                            <div class="wizardLeftImage" style="font-size:medium;">
                                <%-- <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />--%>
                                <asp:Label ID="lblAddCountry" Text="<%$Resources:Resource, Add_New_Country%>"  runat="server"></asp:Label>
                                <asp:Label ID="lblAddState" Text="<%$Resources:Resource, Add_New_State%>" runat="server"></asp:Label>
                                <asp:Label ID="lblAddCity" Text="<%$Resources:Resource, Add_New_City%>" runat="server"></asp:Label>
                            </div>
                            <div class="wizardRightImage">
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                    OnClientClick="javascript:return Close();" />
                            </div>
                        </td>
                   </tr>
                   </table>
                </td>
            </tr>
        <tr>
            <td rowspan="2" style="width: 50%;padding-left:10px;" align="center">
                <table width="100%" >
                    <tr>
                        <td  align="right">
                            <asp:Label ID="lbl_name" Text="<%$Resources:Resource, State%>" runat="server" CssClass="LabelText"></asp:Label>
                            <asp:Label ID="lbl_Country" Text="<%$Resources:Resource, Country%>" runat="server"
                                CssClass="LabelText"></asp:Label>
                            <asp:Label ID="lbl_City" Text="<%$Resources:Resource, City%>" runat="server" CssClass="LabelText"></asp:Label>:
                        </td>
                        <td >
                            <asp:TextBox CssClass="SmallTextBox" ID="txtName" runat="server" TabIndex="1" Width="130px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" >
                            <asp:Label ID="lbl_abbrivation" Text="<%$Resources:Resource, Abbreviation%>" runat="server" CssClass="LabelText"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="SmallTextBox" ID="txtAbbrivation" runat="server" TabIndex="2"
                                Width="130px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        
                            <asp:Label runat="server" ID="lblAbbrivationError" Text="" style="color:Red; font-size:small;"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 20%;">
                <asp:Button ID="btnRemove" Width="100px" runat="server" Text="<%$Resources:Resource, Remove%>"
                    TabIndex="3" OnClick="btnRemove_Click" />
            </td>
            <td valign="top" rowspan="3" style="height: 100%; width: 20%;padding-right:10px;padding-top:10px;">
                <asp:ListBox ID="lst_states" SelectionMode="Single" AutoPostBack="true" OnSelectedIndexChanged="lst_states_SelectedIndexChanged"
                    Height="100%" Width="100%" runat="server"></asp:ListBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnAdd" Width="100px" runat="server" Text="<%$Resources:Resource, Add%>"
                    TabIndex="3" OnClientClick="javascript:return confirm_insert();" OnClick="btnAdd_Click" />
            </td>
        </tr>
        <tr >
            <td valign="top" style="padding-left:50px;">
                <%-- <asp:Button ID="btnOk" OnClientClick="Close();" Width="100px" runat="server" Text="OK" TabIndex="3" />--%>
                <asp:Button ID="btnClear" OnClientClick="ClearFields();" Width="100px" runat="server"
                    Text="<%$Resources:Resource, Clear%>" TabIndex="3" />
                <asp:Button ID="btnClose" OnClientClick="javascript:return Close();" Width="100px"
                    runat="server" Text="<%$Resources:Resource, Close%>" TabIndex="3" />
            </td>
            <td>
                <asp:Button ID="btnRename" Width="100px" runat="server" Text="<%$Resources:Resource, Rename%>"
                    TabIndex="3" OnClick="btnRename_Click" />
            </td>
        </tr>
    </table>
    </div>
    <asp:Label ID="lblMessage" runat="server" CssClass="LabelText" ForeColor="Red"></asp:Label>
    <asp:HiddenField ID="hfFlag" runat="server" />
    </form>
</body>
</html>
