<%@ Page Language="C#" AutoEventWireup="true" CodeFile="contacts.aspx.cs" Inherits="App_Settings_contacts"
     MasterPageFile="~/App/EcoDomus_PM_New.master"  %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <telerik:RadCodeBlock ID="codeClient" runat="server">
        <script type="text/javascript" language="javascript">
              function Clear() {
                document.getElementById("ContentPlaceHolder1_txtSearch").value = "";
               
                return false;

            }


            function get() {
                var answer = confirm("Are you sure you want to delete this item?")
                if (answer)
                    return true;
                else
                    return false;

            }
            function ProjectValidation() {
               
                alert('Please select Project');
                window.location = '../Settings/Project.aspx';
                return false;

            }

            function NiceScrollOnload() {
                if (screen.height > 721) {
                    $("html").css('overflow-y', 'hidden');
                    $("html").css('overflow-x', 'auto');
                }
                var screenhtg = set_NiceScrollToPanel();
            }
            function open_space_popup() {


                alert('Please select Project');
                return false;

            }

            function ConfigureDesign() {

            }
            function getSelected() {
                var RadGrid1 = $find("<%=rgAssignedUser.ClientID %>");
                var masterTable = $find("<%= rgAssignedUser.ClientID %>").get_masterTableView();
                var row = masterTable.get_dataItems().length;
                var cnt = 0;
                for (var i = 0; i < row; i++) {
                    var row1 = masterTable.get_dataItems()[i];
                    var chk1 = row1.findElement("chkSelect");


                    if (chk1.checked) {

                        cnt = cnt + 1;
                        break;
                        return true;
                    }

                }

                if (cnt == 0) {
                    alert("Please select the contact to Notify!!!")
                    return false;
                }
            }
            function GridCreated(sender, args) {
                debugger;
                //alert(sender.get_masterTableView().get_pageSize());
                var pageSize = document.getElementById("ContentPlaceHolder1_hfTypePMPageSize").value;
                var scrollArea = sender.GridDataDiv;
                var dataHeight = sender.get_masterTableView().get_element().clientHeight;

                if (dataHeight < parseInt(pageSize) * 17) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 17 - 12) + "px";
                }

                //sender.get_masterTableView().set_pageSize(globalPageHeight);
            }

            function GridCreated1(sender, args) {
                debugger;
                //alert(sender.get_masterTableView().get_pageSize());
                var pageSize = document.getElementById("ContentPlaceHolder1_hfTypePMPageSize").value;
                var scrollArea = sender.GridDataDiv;
                var dataHeight = sender.get_masterTableView().get_element().clientHeight;

                if (dataHeight < parseInt(pageSize) * 15) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 15 - 12) + "px";
                }

                //sender.get_masterTableView().set_pageSize(globalPageHeight);
            }


            function confirmation() {
                var RadGrid1 = $find("<%=rgAssignedUser.ClientID %>");
                var masterTable = $find("<%=rgAssignedUser.ClientID %>").get_masterTableView();
                var row = masterTable.get_dataItems().length;
                var cnt = 0;
                for (var i = 0; i < row; i++) {
                    var row1 = masterTable.get_dataItems()[i];

                    if (row1.get_selected()) {
                        cnt = cnt + 1;
                    }
                }
                //alert(cnt);
                if (cnt > 0) {

                    var ddl = document.getElementById("ctl00$ContentPlaceHolder1$ddlProjectrole").value;
                    // alert(ddl);
                    if (ddl == "00000000-0000-0000-0000-000000000000") {
                        alert("Please select project role");
                        return false;
                    }
                    else {
                        var flag;
                        //flag = confirm("Do you want to assign selected role to contact?");
                        return true;

                    }
                }
                else {
                    alert("Please select atleast one contact");
                    return false;
                }

            }

       

        </script>
    </telerik:RadCodeBlock>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />

    <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <table id="tblUser"  width="95%" style="margin-top: 0px;" border="0" cellpadding="0" cellspacing="0">
         <caption >
            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Contacts%>">:</asp:Label>
            </caption>
       <tr style="height: 18px">
            <td>
                <asp:Label Style="font-family: Arial, Helvetica, sans-serif; font-size: 12px;" ID="lblheading"
                    runat="server" CssClass="Label" Text="<%$Resources:Resource,Assign_Project_roles_to_Contacts%>"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="margin-top: 10px">
                <telerik:RadGrid ID="rgAssignedUser" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                    ItemStyle-Wrap="false" AllowSorting="true" Skin="Default" PagerStyle-AlwaysVisible="true"
                    PageSize="5" OnPageSizeChanged="bind_Contact" OnPageIndexChanged="bind_Contact"
                    OnSortCommand="rgAssignedUser_bind_Contact" AllowMultiRowSelection="true" OnItemDataBound="rgAssignedUser_ItemDataBound">
                    <PagerStyle Mode="NextPrevAndNumeric" />
                    <ClientSettings>
                        <Selecting AllowRowSelect="true"  />
                         <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="170"/>
                          <ClientEvents OnGridCreated="GridCreated" />
                    </ClientSettings>
                    <MasterTableView DataKeyNames="pk_organization_id,user_id,pk_user_project_id">
                        <Columns>
                            <telerik:GridClientSelectColumn UniqueName="GridCheckBox">
                                <ItemStyle Width="3%" />
                                <HeaderStyle Width="5%" />
                              
                              
                            </telerik:GridClientSelectColumn>
                            <telerik:GridBoundColumn DataField="pk_user_project_id" SortExpression="pk_user_project_id"
                                Visible="false" UniqueName="pk_user_project_id">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn UniqueName="TemplateColumn1" HeaderText="<%$Resources:Resource,Project_Contact%>"
                                Visible="false">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkProjectContact" runat="server" />
                                </ItemTemplate>
                               <%-- <ItemStyle Width="2px" Wrap="false" />--%>
                            </telerik:GridTemplateColumn>
                            <%--<telerik:GridTemplateColumn  UniqueName="TemplateColumn1" HeaderText="<%$Resources:Resource,Select%>">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server"  />
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                    <ItemStyle Width="5px" />
                         </telerik:GridTemplateColumn>--%>
                            <telerik:GridBoundColumn DataField="username" SortExpression="username" HeaderText="<%$Resources:Resource,Name%>"
                                UniqueName="username">
                                <ItemStyle CssClass="itemstyle" Wrap="false" Width="19%"></ItemStyle>
                                <HeaderStyle Wrap="False" Width="19%"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="organization" SortExpression="organization" HeaderText="<%$Resources:Resource,Organization%>"
                                UniqueName="organization">
                                <ItemStyle CssClass="itemstyle" Wrap="false" Width="20%"></ItemStyle>
                                <HeaderStyle Wrap="False" Width="20%"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="phone_number" HeaderText="<%$Resources:Resource,Phone_Number%>"
                                UniqueName="phone_number">
                                <ItemStyle CssClass="itemstyle" Wrap="false" Width="10%"></ItemStyle>
                                <HeaderStyle Wrap="False" Width="10%"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="email_address" AllowSorting="true" HeaderText="<%$Resources:Resource,Email%>"
                                UniqueName="email_address">
                                <ItemStyle CssClass="itemstyle" Wrap="false" Width="20%"></ItemStyle>
                                 <HeaderStyle Wrap="False" Width="20%"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="role_name" AllowSorting="true" HeaderText="<%$Resources:Resource,Project_Role%>"
                                UniqueName="role_name">
                                <ItemStyle CssClass="itemstyle" Wrap="false" Width="15%"></ItemStyle>
                                 <HeaderStyle Wrap="False" Width="15%"></HeaderStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="<%$Resources:Resource,Unassign%>">
                                <ItemStyle CssClass="column"  />
                                <HeaderStyle Wrap="False"  />
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnRemove" runat="server" alt="Delete" OnClick="btnRemove_Click"
                                        CommandArgument='<%# DataBinder.Eval(Container.DataItem,"pk_user_project_id")%>'
                                        ImageUrl="~/App/Images/remove.gif" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="pk_organization_id" UniqueName="pk_organization_id"
                                Visible="false">
                                <ItemStyle CssClass="itemstyle"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="user_id" UniqueName="user_id" Visible="false">
                                <ItemStyle CssClass="itemstyle"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="pk_user_project_id" UniqueName="pk_user_project_id"
                                Visible="false">
                                <ItemStyle CssClass="itemstyle"></ItemStyle>
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <div id="dvassignrole" runat="server">
        <table id="tblUser2" width="95%"  style="margin-top: 0px;" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td align="left">
                    <table cellpadding="2">
                        <tr align="center">
                            <td style="height: 38px">
                                &nbsp;
                                <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Project_Role%>"
                                    CssClass="Label"></asp:Label>
                            </td>
                            <td>
                            
                                <%-- <telerik:RadComboBox CausesValidation="true" MarkFirstMatch="true" Height="100px"
                        DataTextField="project_role" DataValueField="project_role" ID="ddlProjectrole"
                        runat="server" Width="180px" >
                        <Items>
                            
                       </Items>
                   </telerik:RadComboBox>--%>
                                <asp:DropDownList ID="ddlProjectrole" runat="server" Width="180px" AutoPostBack="True">
                                    <%--onselectedindexchanged="ddlLanguage_SelectedIndexChanged" --%>
                                </asp:DropDownList>
                            </td>
                            <td >
                                <asp:Button ID="btnAssignProjectContact" Width="150px" runat="server" Text="<%$Resources:Resource,Assign_Project_Role%>"
                                    OnClick="btnAssignProjectContact_Click" OnClientClick="javascript:return confirmation();" />
                            </td>
                            <td >
                                &nbsp;
                                <asp:Button ID="Button1" Width="100px" runat="server" Text="<%$Resources:Resource,Export_Contact%>" />
                            </td>
                            <td >
                                &nbsp;
                              <%--  <asp:Button ID="Button2" Width="100px" runat="server" Text="<%$Resources:Resource,Notify%>"
                                    OnClick="btn_Click" OnClientClick="javascript:return getSelected();" />--%>

                                      <a onclick = "javascript:return getSelected();"> <asp:Button ID="Button2" Width="100px" runat="server" Text="<%$Resources:Resource,Notify%>"
                                    OnClick="btn_Click" />
                                    </a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_msg" runat="server" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
          <%--  <tr>
                <td>
                    &nbsp;
                </td>
            </tr>--%>
            <tr>
                <td align="left">
                    <asp:Label Style="font-family: Arial, Helvetica, sans-serif; font-size: 13px;" CssClass="Label"
                        runat="server" Text="<%$Resources:Resource,Assign_Contacts_to_Project%>" Font-Size="10pt"></asp:Label>
                </td>
            </tr>
            <tr>
                <td  align="left">
                    <table >
                        <tr> <td align="left">
          
                <asp:Panel ID="aspPanel" runat="server" DefaultButton="btnSearch">
                   
                    <asp:TextBox CssClass="SmallTextBox" ID="txtSearch" runat="server" TabIndex="1"></asp:TextBox>
                     
                    <asp:Button ID="btnSearch" runat="server" Text="<%$Resources:Resource,Search%>" Width="100px" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="<%$Resources:Resource,Clear%>" Width="100px" OnClientClick="javascript:return Clear();" />
               
                </asp:Panel>
            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td  style="margin-top: 8px">
                    <telerik:RadGrid ID="rgAssignContacts" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                        ItemStyle-Wrap="false" AllowSorting="true" Skin="Default" PagerStyle-AlwaysVisible="true" PageSize="5"
                        OnPageIndexChanged="bind_Contact" OnPageSizeChanged="bind_Contact" OnSortCommand="rgAssignContacts_OnSortCommand">
                        <PagerStyle Mode="NextPrevAndNumeric" />
                        <ClientSettings >
                        <Scrolling AllowScroll="true" UseStaticHeaders="true"  ScrollHeight="163"/>
                         <ClientEvents OnGridCreated="GridCreated1" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="pk_organization_id,user_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="Username" HeaderText="<%$Resources:Resource,Name%>"
                                    UniqueName="title" SortExpression="Username">
                                    <ItemStyle CssClass="itemstyle" Wrap="false" Width="30%">
                                    
                                    </ItemStyle>
                                    <HeaderStyle Wrap="false" Width="30%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="OrganizationName" SortExpression="OrganizationName"
                                    HeaderText="<%$Resources:Resource,Organization%>" UniqueName="OrganizationName">
                                    <ItemStyle CssClass="itemstyle" Wrap="false" Width="30%"></ItemStyle>
                                    <HeaderStyle Wrap="false" Width="30%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="email_address" AllowSorting="true" HeaderText="<%$Resources:Resource,Email%>"
                                    UniqueName="email_address">
                                    <ItemStyle CssClass="itemstyle" Wrap="false" Width="30%"></ItemStyle>
                                    <HeaderStyle Wrap="false" Width="30%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="<%$Resources:Resource,Assign%>">
                                    <ItemTemplate>
                                        <asp:Button ID="btnAssign" runat="server" Text="<%$Resources:Resource,Assign%>" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"user_id")%>'
                                            OnClick="btnAssign_Click" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
            <tr>
                <%-- <td>
                <asp:Label ID="lbl_msg" runat="server"></asp:Label>
            </td>--%>
            </tr>
        </table>
    </div>
    <telerik:RadAjaxManagerProxy ID="Ajax_manager" runat="server">
        
        <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAssignContacts" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlProjectrole">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlProjectrole" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgAssignedUser">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAssignedUser" />
                    <telerik:AjaxUpdatedControl ControlID="rgAssignContacts" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rgAssignContacts">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAssignedUser" />
                    <telerik:AjaxUpdatedControl ControlID="rgAssignContacts" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRemove">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAssignedUser" />
                    <telerik:AjaxUpdatedControl ControlID="rgAssignContacts" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnAssign">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAssignContacts" />
                    <telerik:AjaxUpdatedControl ControlID="rgAssignedUser" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Default" runat="server" Height="50px"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
     <asp:HiddenField ID="hfTypePMPageSize" runat="server" Value="" />
</asp:Content>
