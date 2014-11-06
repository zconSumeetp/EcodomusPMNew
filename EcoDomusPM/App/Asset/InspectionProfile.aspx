<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InspectionProfile.aspx.cs"
     Inherits="App_Asset_InspectionProfile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<html>
<head>
    <title>EcoDomus FM : Asset Profile </title>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">


            function facility_popup() {

                var url = "../Locations/Select_Facility.aspx";
                manager = $find("<%= rad_window.ClientID %>");
                var windows = manager.get_windows();
                windows[0].show();
                windows[0].setUrl(url);
                windows[0].set_modal(false);
                return false;
            }
            function load_facilityname(name, id) {



                document.getElementById("hffacilityid").value = id;
                var reg = new RegExp('&nbsp;', 'g');
                name = name.replace(reg, ' ');
                document.getElementById("lblfacility").innerText = name;

                document.getElementById("hffacilityname").innerText = name;



                if (document.getElementById("lblfacility").value != null) {
                    document.getElementById("Span2").style.visibility = "visible";
                }


            }

            function GotoProfile(id) {
                top.location.href = "InspectionMenu.aspx?pagevalue=InspectionProfile&inspectionid=" + id;
            }

            function NavigateToFindInspection() {

                top.location.href = "../Asset/Inspections.aspx";
            }

                          
        </script>
    </telerik:RadCodeBlock>
      <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
      </head>

<body style="background: white; padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" style="margin: 0 0 0 0">
     <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>

    <div style="padding-left: 50px;" id="div_Add_Inspection">
        <table>
            <caption>
            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Inspection_Profile%>">:</asp:Label>
                </caption>
            <tr>
            <td style="height: 20px">
            </td>
            </tr>
            <tr>
                <th align="left">
                <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Name%>"></asp:Label>:
                </th>
                <td align="left">
                    <asp:TextBox ID="txtName" runat="server" CssClass="SmallTextbox" Width="150px"></asp:TextBox>
                    <asp:Label ID="lblName" runat="server" CssClass="LabelText"></asp:Label>
                    <asp:RequiredFieldValidator ValidationGroup="valid" ID="rqfname"
                    runat="server" ControlToValidate="txtName" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                   
                </td>
            </tr>
            <tr>
            <td style="height: 20px">
            </td>
            </tr>
            <tr>
                <th align="left">
                <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,Description%>"></asp:Label>:
                </th>
                <td align="left">
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="SmallTextBox" Width="150px"></asp:TextBox>
                    <asp:Label ID="lblDescription" runat="server" CssClass="LabelText"></asp:Label>
                    
                </td>
            </tr>
            <tr>
            <td style="height: 20px">
            </td>
            </tr>

            <tr>
                <th align="left">
                <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource,Date%>"></asp:Label>:
                </th>
                <td align="left">
                    <telerik:RadDatePicker ID="dt_Inspection" runat="server" Visible="true" 
                        Width="185px" MinDate="">
                    </telerik:RadDatePicker>
                    <asp:Label ID="lblDate" runat="server" CssClass="LabelText"></asp:Label>
                    <asp:RequiredFieldValidator ValidationGroup="valid" ID="Rqfdate"
                    runat="server" ControlToValidate="dt_Inspection" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                   
                    

                </td>
            </tr>
            <tr>
            <td style="height: 20px">
            </td>
            </tr>
            <tr>
                <th align="left">
                <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,Facility%>"></asp:Label>:
                </th>
                <td align="left">
                     
                     <asp:Label ID="lblfacility" runat="server"  CssClass="LabelText" Visible="true"></asp:Label>
                    <asp:Label ID="lblvalidate" runat="server" Text="*" CssClass="LabelNormal" Visible="false" ForeColor="Red"></asp:Label>
                    <asp:LinkButton ID="lnkbtnfacility" runat="server" Text="Select Facility"
                        OnClientClick="javascript:return facility_popup();" CssClass="linkText"></asp:LinkButton>
                </td>
            </tr>
            <tr>
            <td style="height: 30px">
            </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Button ID="btnSave" runat="server" Width="100px" Text="<%$Resources:Resource,Save%>" OnClick="btnSave_Click"  ValidationGroup="valid" />
                </td>
                <td align="left">
                    <asp:Button ID="btnCancel" runat="server" Width="100px" Text="<%$Resources:Resource,Cancel%>" OnClick="btnCancel_Click"  />
                </td>
                <td> 
                    <asp:Label ID="lblMessage" runat="server" CssClass="LabelText"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hfinspectionid" runat="server" />
        <asp:HiddenField ID="hfuserid" runat="server" />
        <asp:HiddenField ID="hffacilityid" runat="server" />
        <asp:HiddenField ID="hffacilityname" runat="server" />
    </div>
    <telerik:RadWindowManager Visible="true" ID="rad_window" VisibleStatusbar="false"
        AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server"
        KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" Animation="Slide" Behaviors="None"
                KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false" 
                Width="700" Height="450" VisibleStatusbar="false" VisibleOnPageLoad="false" Skin="Forest">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

       </form>
</body>
</html>
