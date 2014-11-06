<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomusPM_Master.master"  AutoEventWireup="true"
    CodeFile="Issues.aspx.cs" Inherits="App_Asset_Issues" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript" language="javascript">
    function setFocus() {
        if (document.getElementById("<%=txtSearch_Issue.ClientID %>") != null)
            document.getElementById("<%=txtSearch_Issue.ClientID %>").focus();

    }
    window.onload = setFocus;
</script>
  <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />

   <%-- <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">--%>
    <script type="text/javascript" language="javascript">
        function NavigateAddIssue() {

            location.href = "../Asset/AddIssue.aspx";
            return false;

        }

        function Clear() {

            document.getElementById("<%=txtSearch_Issue.ClientID%>").value = "";
            return false;
        }

        
        function delete_issues() {
            var answer = confirm("Do you want to delete this issue?")
            return answer;
        }
        function ProjectValidation() {

            alert('Please select Project');
            window.location = '../Settings/Project.aspx';
            return false;

        }


        function close_issues() {
            var answer = confirm("Do you want to close this issue?")
            if (answer)
                return true;
            else
                return false;
        }
      
    </script>

  <%--  </telerik:RadCodeBlock>--%>
    <%-- <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">--%>
<script type="text/javascript" language="javascript">

    function open_space(id) {
       
            document.getElementById('ContentPlaceHolder1_hf_space_id').value = id;
            document.getElementById('ContentPlaceHolder1_btn_navigate_space').click();
            
             }
//        function gotoPage(id, pagename) {
//            var url;
//            if (pagename == "Facility") {
//                url = "../Locations/FacilityMenu.aspx?FacilityId=" + id;

//            }
//            else if (pagename == "System") {
//                url = "SystemMenu.aspx?system_id=" + id;

//            }
//            else if (pagename == "Space") {
//                url = "../Locations/FacilityMenu.aspx?pagevalue=Space Profile&id=" + id;

//            }
//            window.location.href(url);
//        }
</script>
      
      <%--</telerik:RadCodeBlock>--%>

 <%-- <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>--%>
    <telerik:RadAjaxManagerProxy ID="issueProfilesManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnShowAI">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgIssue" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="btnShowAI" />
                </UpdatedControls>
            </telerik:AjaxSetting>

             <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgIssue" LoadingPanelID="loadingPanel1" />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server">
       
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch">
    <table cellpadding="0" cellspacing="0" width="100%" border="0" style="margin: 15px 50px 10px 25px;">
       <caption>
            <asp:Image ID="Image3" runat="server" ImageUrl="~/App/Images/Issue.gif" />
            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Issues%>"></asp:Label>
                
       </caption>
        <tr>
            <td align="center">
                <asp:Label ID="lblMsg" runat="server" ForeColor="red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <div style="float: left">
                    <span id="Span2" style="font-size: small; font-weight: lighter; margin-left:0px">
                        <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, From%>"></asp:Label>: 
                    </span>
                    <telerik:RadDatePicker ID="rdpfrom" runat="server" TabIndex="1" Width="200px">
                        <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                            ViewSelectorText="x" runat="server">
                        </Calendar>
                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="1"></DatePopupButton>
                        <DateInput ID="fromdate_input" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy"
                            TabIndex="1" runat="server">
                        </DateInput>
                    </telerik:RadDatePicker>
                    &nbsp;&nbsp;<span id="Span3" style="font-size: small; font-weight: lighter;">
                    <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, To%>"></asp:Label>:
                    </span>
                    <telerik:RadDatePicker ID="rdpto" runat="server" TabIndex="2" Width="200px">
                        <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                            ViewSelectorText="x" runat="server">
                        </Calendar>
                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="2"></DatePopupButton>
                        <DateInput ID="todate_input" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" TabIndex="2"
                            runat="server">
                        </DateInput>
                    </telerik:RadDatePicker>
                    <span id="Span4" style="font-size: small; font-weight: lighter;">
                      <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, Category%>"></asp:Label>: 
                    </span>
                    <telerik:RadComboBox ID="cmb_CategoryType" runat="server" Height="90" Width="200px"
                        TabIndex="3">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="All" />
                            <telerik:RadComboBoxItem Value="typename" runat="server" Text="Type" />
                            <telerik:RadComboBoxItem Value="spacename" runat="server" Text="Space" />
                            <telerik:RadComboBoxItem Value="assetname" runat="server" Text="Asset" />
                        </Items>
                    </telerik:RadComboBox>
                </div>
            </td>
        </tr>

           <tr> <td><div style="width: 100%;">   </div>  </td> </tr>
          <tr >      
                <td>
                
                  <div style="width: 100%;">
                  <table><tr>
                  <td>
                 <%--<span id="Span5" style="font-size: small; font-weight: lighter;">
                    <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource, Search_By%>"></asp:Label>   :
                 </span>--%>
                 </td><td>
                     <asp:TextBox ID="txtSearch_Issue" runat="server" TabIndex="4" Width="170px"></asp:TextBox>
                </td>
                   <td><asp:Button ID="btn_clear" runat="server"  Text="<%$Resources:Resource, Clear%>" Width="80px" OnClientClick="javascript:return Clear()" /></td> 
                    <td><asp:Button ID="btnSearch" runat="server"  Text="<%$Resources:Resource, Search%>" Width="80px" OnClick="btn_Search_Click"
                        TabIndex="5" CausesValidation="false" /></td> 
                  <td>  <asp:Button ID="btnpdf" runat="server" Width="121px" OnClick="btnpdf_click"
                        Text="<%$Resources:Resource, Export_To_PDF%>" TabIndex="6" /></td> 
                   <td> <asp:Button ID="btnShowAI" runat="server" Width="111px" OnClick="btnShowAI_click" OnPageIndexChanged="rgIssue_OnPageIndexChanged"
                        Text="<%$Resources:Resource, Show_All_Issues%>" TabIndex="7"  /></td> 
                    </tr>    </table>
                 </div>    
               
                </td> 
            
         </tr>

           <tr>
            <td colspan="2">
                <div style="margin-top: 15px; width: 90%;">
                    <telerik:RadGrid ID="rgIssue" runat="server" BorderWidth="1px" CellPadding="0" Width="107%" Skin="Hay"
                        AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True" OnItemCommand="rgIssue_ItemCommand" OnItemDataBound="rgIssue_ItemDataBound" OnPageIndexChanged="rgIssue_OnPageIndexChanged"
                        OnSortCommand="rgIssue_OnSortCommand" 
                         OnPageSizeChanged="rgIssue_OnPageSizeChanged" 
                       
                        PagerStyle-AlwaysVisible="true"  
                        GridLines="None" TabIndex="7"  >
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" width="100%"/>
                        <MasterTableView DataKeyNames="pk_issues_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_issues_id" HeaderText="cb_issues_id" Visible="false">
                                    <ItemStyle CssClass="column" Width="100px" />
                                </telerik:GridBoundColumn>
                                
                                <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="issuename" CommandName="Profile" 
                                    HeaderText="<%$Resources:Resource, Issue_Name%>" SortExpression="issuename" >
                                    <ItemStyle CssClass="column"  Font-Underline="true" Width="300px" />
                                </telerik:GridButtonColumn>
                                
                                <telerik:GridBoundColumn DataField="issue_type" HeaderText="<%$Resources:Resource, Issue_Type%>"  SortExpression="issue_type" >
                                    <ItemStyle CssClass="column"  Width="300px" />
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="spacename"  HeaderText="<%$Resources:Resource, Location%>" UniqueName="location">
                                    <ItemStyle CssClass="column" Width="150px" />
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="organizationusername" UniqueName="Owner" HeaderText="<%$Resources:Resource, Assigned_To%>" SortExpression ="organizationusername">
                                    <ItemStyle CssClass="column" Width="300px" />
                                </telerik:GridBoundColumn>
                                
                                <telerik:GridBoundColumn DataField="createdby" HeaderText="<%$Resources:Resource, Created_By%>" SortExpression="createdby" >
                                    <ItemStyle CssClass="column"  Width="300px" />
                                </telerik:GridBoundColumn>
                                
                                <telerik:GridBoundColumn DataField="created_on" HeaderText="<%$Resources:Resource, Created_On%>" SortExpression="created_on" >
                                    <ItemStyle CssClass="column"  Width="300px" />
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="issuestatus" HeaderText="<%$Resources:Resource, Issue_Status%>" SortExpression="issuestatus">
                                    
                                </telerik:GridBoundColumn>
                                  <%--<telerik:GridBoundColumn DataField="issuestatus" HeaderText="IssueStatus" Visible="false">
                                    
                                </telerik:GridBoundColumn>--%>
                        
                                
                                 <telerik:GridTemplateColumn DataField="pk_issues_id" UniqueName="imgbtnclose_" HeaderText="<%$Resources:Resource,Status%>">
                                  <ItemStyle CssClass="column" Width="5%" />
                                  <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnclose" runat="server" alt="<%$Resources:Resource, Resolved%>" CommandName ="closeIssue"  ImageUrl="~/App/Images/remove.gif" OnClientClick="javascript:return close_issues();"/>
                                  </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn DataField="pk_issues_id" UniqueName="imgbtnDelete_" HeaderText="<%$Resources:Resource,Delete%>">
                                  <ItemStyle CssClass="column"  Width="5%"/>
                                  <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" runat="server" alt="<%$Resources:Resource, Delete%>" CommandName ="deleteIssue"  ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return delete_issues();"/>
                                  </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <br />
                    <asp:Button ID="Button1" Text="<%$Resources:Resource, Add_Issue%>" runat="server" OnClick="btnaddissue_click"/>
                </div>
            </td>
        </tr>
                
    </table>
    </asp:Panel>
     <table cellpadding="0" cellspacing="0" width="100%" border="0" style="margin: 0px 0px 0px 0px;">
    <tr >
        <td >
            &nbsp;</td>
        </tr>
    </table>
     
    <div style="display:none">
    <asp:Button ID="btn_navigate_space" runat="server" OnClick="navigate_space"/>
    </div>
     <asp:HiddenField ID="hf_space_id" runat="server"/>
</asp:Content>
