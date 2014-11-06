<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserFacility.aspx.cs" Inherits="App_Settings_UserFacility" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <title></title>
    <script type="text/javascript" language="javascript">
    

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
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            
            function get()
            {
                var get;
                get=confirm("Do you want to delete this facility?");
                return get;
            }

            function Clear() {
                document.getElementById("txtSearch").value = "";
                return false;
            }




             function OpenPopupAssignFacility() {
                url = "../Settings/AssignFacility.aspx?OrganizationPrimaryuserId="+document.getElementById("hfOrganizatioPrimaryUserid").value;
                manager = $find("rad_window");
                if (manager != null) {
                    var windows = manager.get_windows();
                    var intWidth = document.body.clientWidth;
                    windows[0]._left = parseInt(intWidth * (0.2));
                    windows[0]._width = parseInt(intWidth * 0.6);
                    var intHeight = document.body.clientHeight;
                    windows[0]._top = 50;
                    windows[0]._height = "600";
                    //parseInt(intHeight * 2.40);
                    windows[0].setUrl(url);
                    windows[0].show();
                    //windows[0].set_modal(false);
                    return false;
                }
                return false;
            }

        </telerik:RadCodeBlock>
    
    </script>
</head>
<body style="background-position: white; background: white; padding: 0px; margin: 0px 0px 0px 0px;">
    <form id="form2" runat="server">
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
    <telerik:RadScriptManager runat="server" ID="RadScriptManager" EnableScriptCombine="false">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Hay" DecoratedControls="Buttons" />
    <table style="margin-top: 0px; " border="0">
        <tr>
            <td align="left" style=" vertical-align: bottom" colspan="4">
                <caption>
                <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Facilities%>">:</asp:Label>
                </caption>   
                
            </td>
        </tr>
        <tr align="left">
            <td>
                <asp:Panel ID="aspPanel" runat="server" DefaultButton="btnSearch">
                    <asp:TextBox CssClass="SmallTextBox" ID="txtSearch" runat="server" TabIndex="1"></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="<%$Resources:Resource,Search%>" Width="100px" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="<%$Resources:Resource,Clear%>" Width="100px" OnClientClick="javascript:return Clear();" />
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr align="left">
            <td>
                <telerik:RadGrid ID="rgUserFacility" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                    OnItemCommand="rgUserFacility_ItemCommand" AllowSorting="true" OnSortCommand="rgUserFacility_SortCommand"
                    OnPageIndexChanged="rgUserFacility_PageIndexChanged" OnPageSizeChanged="rgUserFacility_PageSizeChanged"
                    Skin="Hay" PagerStyle-AlwaysVisible="true">
                    <PagerStyle Mode="NextPrevAndNumeric" />
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
                    <MasterTableView DataKeyNames="ID,cons_string">
                        <Columns>
                            <telerik:GridButtonColumn ButtonType="LinkButton" SortExpression="Name" CommandName="EditFacility"
                                HeaderText="<%$Resources:Resource,Name%>" DataTextField="Name">
                                <ItemStyle CssClass="column" Font-Underline="true" Width="150px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="description" SortExpression="description" HeaderText="<%$Resources:Resource,Description%>"
                                UniqueName="description">
                                <ItemStyle CssClass="itemstyle"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ID" UniqueName="ID" Visible="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="ID" UniqueName="ID">
                                <ItemStyle CssClass="column" Font-Underline="true" Width="5%" />
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deletefacility"
                                        OnClientClick="javascript:return get();" ImageUrl="~\\App\\Images\\Delete.gif" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td>
                <div id="div_btnFacilityAssigned" runat="server" style="display:none">
                    <asp:Button ID="btnFacilityAssigned" Text="Facility Assigned" runat="server" 
                        onclick="btnFacilityAssigned_Click" />
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="div_btnAssignFacility" runat="server"> 
                    <asp:Button ID="btnAssignFacility" runat="server" Text="<%$Resources:Resource,Assign_Facility%>" Width="100px" OnClientClick="javascript:return OpenPopupAssignFacility();"/>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbl_msg" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfAssignedFacilityListIds" runat="server" />
                <asp:HiddenField ID="hfOrganizatioPrimaryUserid" runat="server" />
                <asp:HiddenField ID="hfAssignedFacilityListNames" runat="server" />
                <asp:HiddenField ID="hfUserRole" runat="server" />
                <asp:HiddenField ID="hfUserId" runat="server" />
            </td>
        </tr>
    </table>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgUserFacility" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgUserFacility">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgUserFacility" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnFacilityAssigned">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgUserFacility" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadWindowManager ID="rad_window" runat="server" VisibleStatusbar="false">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="None" Behavior="Move,Maximize,Minimize,Close"
                KeepInScreenBounds="true" ReloadOnShow="True" BorderStyle="Solid" VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    
    </form>
</body>
</html>
