<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddFacilityPopUp.aspx.cs"
    Inherits="App_Locations_AddFacilityPopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <script type="text/javascript" language="javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        function CloseWindow() {


            GetRadWindow().close();

            return false;
        }
        function Navigate(str) {
            window.parent.document.location.href = "FacilityMenu.aspx?FacilityId=" + str + "&profileflag=old";
            window.close();

        }
        function NavigateToFacility() {
       
           // window.parent.document.location.href = "ExistingFacilities.aspx";
           GetRadWindow().close();
           parent.openFacilityPopup();
           return false;
        }
        function closeWindow() {

            //var rdw = GetRadWindow();
            //rdw.close();
            self.close();
        }
    </script>
</head>
<body style="margin: 0px 0px 0px 0px; padding-top: 0; background: white;background-color:#EEEEEE">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,Scrollbars" />
    <div style="width:100%">
       <table align="center">
            <tr style="height: 40px; width: 300px;">
                <td>
                    <table style="border-spacing: 15px;">
                        <tr>
                            <td>
                                <asp:RadioButton ID="rdbtnAddNewFaciltiy" OnCheckedChanged="rdbtnAddNewFaciltiy_checked"
                                    GroupName="AddFacility" runat="server" Text="<%$Resources:Resource,Add_New_Facility%>"
                                    Font-Size="10pt" Checked="true" AutoPostBack="True" CssClass="LabelText" />
                            </td>
                            <td>
                                <asp:RadioButton ID="rdbtnAddExistingFacility" OnCheckedChanged="rdbtnAddExistingFacility_checked"
                                    GroupName="AddFacility" runat="server" Text="<%$Resources:Resource,Add_Existing_Facility%>"
                                    Font-Size="10pt" AutoPostBack="True" CssClass="LabelText" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 40px; width: 300px;">
                <td style="padding: 15px;">
                    <asp:Button ID="btnOk" runat="server" Text="<%$Resources:Resource,Ok%>" Width="60px"
                        OnClick="btnOK_Click" />
                    <asp:Button ID="btnCancel" style="position:relative;" runat="server" Text="<%$Resources:Resource,Cancel%>" Width="60px"
                       OnClientClick="javascript:return closeWindow();" />
                </td>
                <td>

                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
