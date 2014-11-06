<%@ Control Language="c#" AutoEventWireup="true" CodeFile="~/App/UserControls/SyncProfileCS.ascx.cs"
    Inherits="Setup_Sync_SyncCS" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
<link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    .style1
    {
        font-family: Times New Roman, Times, serif;
        font-size: 18px;
    }
    .style3
    {
        height: 32px;
    }
    .style5
    {
        width: 394px;
    }
    
    .style6
    {
        width: 36%;
    }
    .style7
    {
        height: 24px;
    }
    .fieldsetstyle
    {
        border: 1.5px solid black;
    }
</style>
<script type="text/javascript">

    function checkConfigurationName() {

        if (document.getElementById("ContentPlaceHolder1_~/App/UserControls/SyncProfileuserControl_txtConfigName").value == "") {
            document.getElementById("ContentPlaceHolder1_~/App/UserControls/SyncProfileuserControl_lblConfigNameErrMsg").innerHTML = '*';
            return false;

        }
        if ($find('<%=ddlExternalSystem.ClientID %>').get_selectedItem().get_text() == " --Select--") {
            document.getElementById("ContentPlaceHolder1_~/App/UserControls/SyncProfileuserControl_lblExSysNameErrMsg").innerHTML = '*';
            return false;

        }

        else {
            return true;
        }
    }
</script>
<style type="text/css">
.fieldsetstyle
    {
        border: 1.5px solid black;
    }
     
</style>
<telerik:RadFormDecorator ID="rdfSetupSync" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
<div >
 <fieldset class="fieldsetstyle">
    <table width="100%" cellspacing="10px" style="margin:05px;" id="tblSyncProfile">
        <caption>
            <asp:Label ID="lblSyncProfile" runat="server" Text="<%$Resources:Resource,Sync_Profile%>"></asp:Label>
        </caption>
        <tr>
            <td colspan="2" style="width: 20%">
                <asp:Label ID="lbl_facility_name" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label runat="server" ID="lblConfigName" AssociatedControlID="txtConfigName"
                    Text="<%$ Resources:Resource,Configuration_Name %>" CssClass="LabelText"></asp:Label>
                :
            </td>
            <td>
                <asp:TextBox ID="txtConfigName" runat="server" CssClass="SmallTextBox" Width="200px"></asp:TextBox>
                <asp:Label ID="lblConfigNameErrMsg" runat="server" ForeColor="Red" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Label runat="server" ID="lblExternalSystem" AssociatedControlID="ddlExternalSystem"
                    Text="<%$ Resources:Resource,External_System %>" CssClass="LabelText" />:
            </td>
            <td align="left">
                <telerik:RadComboBox ID="ddlExternalSystem" runat="server" Height="100px" Width="200px"
                    AutoPostBack="true" OnSelectedIndexChanged="ddlExternalSystem_SelectedIndexChanged1">
                </telerik:RadComboBox>
                <asp:Label ID="lblExSysNameErrMsg" runat="server" ForeColor="Red" Text=""></asp:Label>
                <%-- <asp:RequiredFieldValidator runat="server"  ID="RequiredFieldValidator2"
                ControlToValidate="ddlExternalSystem" Display="Dynamic" ErrorMessage="Please Fill Configuration Name"
                ValidationGroup="LoginValidationGroup" Text="*"/>--%>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td colspan="2" id="userpasscon">
                <div id="divUserPassConnString" runat="server" visible="false">
                    <fieldset style="float: left; width: 75%" class="fieldsetstyle">
                        <legend>
                            <asp:Label ID="lblconnString" runat="server" Text="<%$ Resources:Resource,Connection_String %>"
                                CssClass="LabelText"></asp:Label>
                        </legend>
                        <table width="100%" cellspacing="10px">
                            <tr>
                                <td align="right" class="style5">
                                    <asp:Label runat="server" ID="lblServiceAuthUrl" AssociatedControlID="txtServiceAuthUrl"
                                        Text="<%$ Resources:Resource,Service_URL %>" CssClass="LabelText" />:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtServiceUrl" runat="server" CssClass="SmallTextBox" Width="200px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style5">
                                    <asp:Label runat="server" ID="lblServiceClientUrl" AssociatedControlID="txtServiceAuthUrl"
                                        Text="<%$ Resources:Resource,Service_Authentication_URL %>" CssClass="LabelText" />:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtServiceAuthUrl" runat="server" CssClass="SmallTextBox" Width="200px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style5">
                                    <asp:Label runat="server" ID="lblUserName" AssociatedControlID="txtUserName" Text="<%$ Resources:Resource,User_Name %>"
                                        CssClass="LabelText" />:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtUserName" runat="server" CssClass="SmallTextBox" Width="200px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style5">
                                    <asp:Label runat="server" ID="lblPassword" AssociatedControlID="txtPassword" Text="<%$ Resources:Resource,Password %>"
                                        CssClass="LabelText" />:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="SmallTextBox"
                                        Width="200px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style5">
                                    <asp:Label runat="server" ID="lblServiceClient" AssociatedControlID="txtServiceclient"
                                        Text="<%$ Resources:Resource,Service_Client %>" CssClass="LabelText" Width="200px" />:
                                </td>
                                <td class="style3">
                                    <asp:TextBox ID="txtServiceclient" runat="server" CssClass="SmallTextBox" Width="200px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </td>
        </tr>
        <%--tma--%>
        <tr>
            <td colspan="2">
                <div id="divconnString" runat="server" visible="false">
                    <fieldset class="fieldsetstyle">
                        <legend>
                            <asp:Label ID="lblconnString2" runat="server" Text="<%$Resources:Resource, Connection_String%>"
                                CssClass="LabelText">
                            </asp:Label>
                        </legend>
                        <table width="100%" cellspacing="10px">
                            <tr>
                                <td align="right" class="style6">
                                    <asp:Label ID="lblConnString1" runat="server" Text="<%$ Resources:Resource, URL %>"
                                        CssClass="LabelText"></asp:Label>
                                </td>
                                <td align="left" style="width: 70%">
                                    <asp:TextBox ID="txtURL" runat="server" CssClass="SmallTextBox" Width="200px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="divFileUpload" runat="server" style="width:100%;"  visible="false">
                    <fieldset class="fieldsetstyle" >
                        <legend>
                            <asp:Label ID="Label1" runat="server" Text="Upload File" CssClass="LabelText">
                            </asp:Label>
                        </legend>
                        <table align="center">
                            <tr>
                                <td  align="left">
                                    <telerik:RadUpload ID="ruImportOjectInp" Skin="Default" AllowedFileExtensions=".inp" 
                                        InputSize="50" runat="server" ControlObjectsVisibility="None" FocusOnLoad="true" >
                                        
                                       </telerik:RadUpload>
                                </td>
                                <td valign="top">
                                    <telerik:RadButton runat="server" ID="btnupload" Text="<%$Resources:Resource,Upload%>"
                                        OnClick="btnupload_Click"></telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </td>
        </tr>
        <%--famis--%>
        <%--  <tr>
        <td colspan="2" id="Td1">
            <div id="divCorrigoConnString" runat="server" visible="false" >
                <fieldset style="border: 1.5px solid green; float: left; width: 75%">
                    <legend>
                        <asp:Label ID="Label1" runat="server" Text="<%$ Resources:Resource,Connection_String %>"
                            CssClass="LabelText"></asp:Label>
                    </legend>
                    <table width="100%" cellspacing="10px">
                        <tr>
                            <td align="right" class="style5">
                                <asp:Label runat="server" ID="Label2" AssociatedControlID="txtServiceAuthUrl"
                                    Text="<%$ Resources:Resource,Service_URL %>" CssClass="LabelText" />:
                            </td>
                            <td>
                                <asp:TextBox ID="txtcorrigoServiceURL" runat="server" CssClass="SmallTextBox" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="style5">
                                <asp:Label runat="server" ID="Label3" AssociatedControlID="txtServiceAuthUrl"
                                    Text="<%$ Resources:Resource,Service_Authentication_URL %>" CssClass="LabelText" />:
                            </td>
                            <td>
                                <asp:TextBox ID="txtcorrigoServiceAuthURL" runat="server" CssClass="SmallTextBox" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="style5">
                                <asp:Label runat="server" ID="Label4" AssociatedControlID="txtUserName" Text="<%$ Resources:Resource,User_Name %>"
                                    CssClass="LabelText" />:
                            </td>
                            <td>
                                <asp:TextBox ID="txtCorrigoUserName" runat="server" CssClass="SmallTextBox" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="style5">
                                <asp:Label runat="server" ID="Label5" AssociatedControlID="txtPassword" Text="<%$ Resources:Resource,Password %>"
                                    CssClass="LabelText" />:
                            </td>
                            <td>
                                <asp:TextBox ID="txtCorrigoPass" runat="server" TextMode="Password" CssClass="SmallTextBox" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="style5">
                                <asp:Label runat="server" ID="Label6" AssociatedControlID="txtServiceclient"
                                    Text="<%$ Resources:Resource,Company_Name %>" CssClass="LabelText" Width="200px"/>:
                            </td>
                            <td class="style3">
                                <asp:TextBox ID="txtCorrigoCompanyName" runat="server" CssClass="SmallTextBox" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
        </td>
        </tr>
        --%>
        <%--corrigo--%>
        <tr>
            <td colspan="2" class="style7">
                <%--<asp:Label ID="lblErrMsg" runat="server" Text="" ForeColor="Red" CssClass="Msg"></asp:Label>--%>
            </td>
        </tr>
        <tr>
            <%-- <td align="right" colspan="2">
            <telerik:RadButton ID="btnNext" runat="server" CausesValidation="true"
                Text="<%$Resources:Resource, Next%>" Skin="Hay" Width="60px"
                OnClick="nextButton_Click" />
            <asp:ValidationSummary runat="server" ID="validationSummary"/>
    
        </td>--%>
            <td align="right" colspan="2">
            
                
            </td> 
            <%--OnClientClick="javascript:return checkConfigurationName();"--%>
        </tr>
    </table>
  </fieldset>
  <div style="text-align:right;padding-top:2px;">
  <div style="float: left">
  <asp:Label ID="lblErrMsg" runat="server" Text="" ForeColor="Red" CssClass="Msg"></asp:Label>
  </div>
  <div style=" border-top:0px;text-align:right"  >
    <asp:Button ID="btnNext" runat="server" Text="<%$Resources:Resource, Next%>" Width="100px"
                    OnClientClick="javascript:return checkConfigurationName();" 
          OnClick="nextButton_Click" BorderStyle="None" />
    </div>
    
  </div>
</div>

<asp:HiddenField ID="hdnnewid" runat="server" />
<div class="buttonSeparator">
</div>
