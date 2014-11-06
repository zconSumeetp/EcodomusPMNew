<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true"
    CodeFile="SetupBasAccess.aspx.cs" Inherits="App_Sustainability_SetupBasAccess" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
    <script type="text/javascript">


        function delete_BAS() {
            var answer = confirm("Are you sure you want to delete this item?")
            if (answer)
                return true;
            else
                return false;
        }

        function Clear() {

            document.getElementById("<%=txtsearch.ClientID %>").value = "";
            return false;

        }

        function changeCaptiontext() {


            document.getElementById("<%=caption.ClientID %>").innerText = "Edit BAS Server";
            

        
        }


    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />

    <div class="divMargin" id="divmaincontent" runat="server">
             <asp:Panel ID ="panel1" runat="server" DefaultButton="radbtnSearch">
        <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars,Select" />
        <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
        </telerik:RadAjaxManager>
        <telerik:RadAjaxManagerProxy ID="issueProfilesManagerProxy" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnaddbasserver">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="tblbasserver" LoadingPanelID="loadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="btnaddbasserver" LoadingPanelID="loadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnsave">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnaddbasserver" LoadingPanelID="loadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="rgbasserver" LoadingPanelID="loadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btncancel">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnaddbasserver" LoadingPanelID="loadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rgbasserver">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rgbasserver" LoadingPanelID="loadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="tblbasserver" LoadingPanelID="loadingPanel1" />
                          <telerik:AjaxUpdatedControl ControlID="btnaddbasserver" LoadingPanelID="loadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="radbtnsearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rgbasserver" LoadingPanelID="loadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManagerProxy>
        <%--<telerik:RadAjaxLoadingPanel ID="loadingPanel1" IsSticky="true" runat="server" Height="75px" Width="75px">
            <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
                style="border: 0px;" />
        </telerik:RadAjaxLoadingPanel>--%>
        <table style="margin: 15px 50px 50px 50px; width: 100%">
            <caption align="top" id="head" runat="server">
               <asp:Label ID="Label11" runat="server" Text="<%$Resources:Resource, Building_Automation_System_Server%>"></asp:Label> 
            </caption>
           
            <tr>
                <td>
                    <asp:TextBox ID="txtsearch" Width="150px" runat="server"></asp:TextBox>
                    <asp:Button ID="radbtnsearch" runat="server" Text="<%$Resources:Resource, Search%>" OnClick="radbtnsearch_click"
                        Width="70px" />
                    <asp:Button ID="btnclear" runat="server" Text="<%$Resources:Resource, Clear%>" OnClientClick="javascript:return Clear();"
                        Width="70px" />
                </td>
            </tr>
            <tr style="height: 10px;">
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <span id="Span12" style="font-weight: bold"></span>
                    <telerik:RadGrid ID="rgbasserver" runat="server" AllowPaging="true" Width="30%" BorderWidth="1px"
                        Skin="Hay" OnItemCommand="rgbasserver_itemcommad" OnSortCommand="rgbasserver_sortcommand"
                        CellPadding="0" AutoGenerateColumns="False" AllowSorting="true" PagerStyle-AlwaysVisible="true">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="50%" />
                        <MasterTableView DataKeyNames="pk_bas_server_id">
                            <Columns>
                                <telerik:GridTemplateColumn UniqueName="navigate" DataField="servername" HeaderText="<%$Resources:Resource, Server_Name%>">
                                    <ItemStyle CssClass="column" Width="50%" />
                                    <ItemTemplate>
                                        <asp:LinkButton CommandName="navigate" runat="server" Text='<%#Eval("servername") %>' OnClientClick="javascript:return changeCaptiontext();"></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, URL%>" DataField="bas_server_url" SortExpression="bas_server_url">
                                    <ItemStyle CssClass="column" Width="50%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, Protocol%>" DataField="protocolname" SortExpression="protocolname">
                                    <ItemStyle CssClass="column" Width="50%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn UniqueName="imgbtnDelete_">
                                    <ItemStyle CssClass="column" Width="50%" />
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="DeleteBASserver"
                                            ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return delete_BAS();" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
            <tr style="height: 10px;">
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnaddbasserver" runat="server" Text="<%$Resources:Resource, Add_BAS_Server%>" OnClick="btnaddbasserver_click" />
                </td>
            </tr>
            <tr style="height: 10px;">
                <td>
                </td>
            </tr>
        </table>
          <telerik:RadAjaxLoadingPanel ID="loadingPanel1" IsSticky="true" runat="server" Height="75px" Width="75px">
            <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
                style="border: 0px;" />
        </telerik:RadAjaxLoadingPanel>
        <table id="tblbasserver" style="display:none;" runat="server" cellspacing="10">
            <tr>
                <td>
                    <caption id="caption" runat="server">
                       <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Add_BAS_Server%>"></asp:Label>:
                    </caption>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblname" runat="server" Text="<%$Resources:Resource, Name%>" CssClass="LabelText"></asp:Label>:
                </td>
                <td>
                    <asp:TextBox ID="txtname" runat="server" Width="200px">></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="btnsavegroup"
                        runat="server" Display="Dynamic" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtname"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
            
                <td>
                    <asp:Label ID="lblurl" runat="server" Text="<%$Resources:Resource, URL%>" CssClass="LabelText"></asp:Label>:
                </td>
                <td>
                    <asp:TextBox ID="txturl" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="btnsavegroup"
                        runat="server" Display="Dynamic" ErrorMessage="*" ForeColor="Red" ControlToValidate="txturl"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblprotocol" runat="server" Text="<%$Resources:Resource, Protocol%>" CssClass="LabelText"></asp:Label>:
                </td>
                <td>
                    <telerik:RadComboBox ID="ddlprotocol" Width="200px" runat="server" DataTextField="name"
                        DataValueField="pk_bas_protocol_id">
                    </telerik:RadComboBox>

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="btnsavegroup" InitialValue="---Select---"
                        runat="server" Display="Dynamic" ErrorMessage="*" ForeColor="Red" ControlToValidate="ddlprotocol"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblusername" runat="server" Text="<%$Resources:Resource, Username%>" CssClass="LabelText"></asp:Label>:
                </td>
                <td>
                    <asp:TextBox ID="txtusername" Width="200px" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblpassword" runat="server" Text="<%$Resources:Resource, Password%>" CssClass="LabelText"></asp:Label>:
                </td>
                <td>
                    <asp:TextBox ID="txtpassword" Width="200px" TextMode="Password" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr id="trsavecancel" runat="server">
                <td>
                    <asp:Button ID="btnsave" OnClick="btnsave_Click" runat="server" Text="<%$Resources:Resource, Save%>" Width="107px"
                        ValidationGroup="btnsavegroup" />
                </td>
                <td>
                    <asp:Button ID="btncancel" OnClick="btncancel_Click" runat="server" Text="<%$Resources:Resource, Cancel%>"
                        Width="113px" />
                </td>
            </tr>
        </table>
        </asp:Panel>
    </div>
    
</asp:Content>
