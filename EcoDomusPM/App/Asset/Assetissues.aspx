<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Assetissues.aspx.cs" Inherits="App_Asset_Assetissues" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript" language="javascript">
        
        function NavigateAddIssue(assetid) {        
        top.location.href = "../Asset/WorkOrderProfile.aspx?work_order_id=00000000-0000-0000-0000-000000000000&assetid=" + assetid;
            return false;
        }

        function NavigateIssueProfile(issueid) 
        {
            top.location.href = "../Asset/WorkOrderProfile.aspx?work_order_id=" + issueid;
            //top.location.href = "../Asset/IssueProfile.aspx?issue_id=" + issueid + "&assetid=" + assetid + "";
            return false;

        }

        function Clear() {

            document.getElementById("<%=txtSearch_Issue.ClientID%>").value = "";
            return false;
        }


        function delete_issues() {
            var answer = confirm("Do you want to delete this issue?")
            if (answer)
                return true;
            else
                return false;
        }


        function close_issues() {
            var answer = confirm("Do you want to close this issue?")
            if (answer)
                return true;
            else
                return false;
        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }

    </script>

    </telerik:RadCodeBlock>
    
   
  <%--  <telerik:RadAjaxManagerProxy ID="issueProfilesManagerProxy" runat="server">
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
    </telerik:RadAjaxManagerProxy>--%>
<%--    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>--%>
    <title></title>
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" defaultfocus="txtSearch_Issue">


     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
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
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>


    <div>
    <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch">
       <table cellpadding="7" cellspacing="7" width="100%" border="0" style="margin: 10px 50px 10px 0px;">
       <caption>
           <%-- <asp:Image ID="Image3" runat="server" ImageUrl="~/App/Images/Issue.gif" />--%>
            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Issues%>"></asp:Label>
            </caption>
        <tr>
            <td align="center">
                <asp:Label ID="lblMsg" runat="server" ForeColor="red"></asp:Label>
            </td>
        </tr>
        <tr>
       <%-- <td align="left">
         <span id="Span1" style="font-size: small; font-weight: lighter;">
         <asp:Label ID="lblInspectionName" runat="server" CssClass="Label" Text="<%$Resources:Resource,Name%>"></asp:Label>:
         </span> 
        <asp:Label ID="lblName" runat="server" Text="" CssClass="Label"></asp:Label>
        </td>--%>
        </tr>
        <tr>
            <td>
                <div style="float: left">
                    <span id="Span2" style="font-size: small; font-weight: lighter;">
                    <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,From%>">:</asp:Label>:
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
                    <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,To%>">:</asp:Label>:
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
                    <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource,Category%>">  :</asp:Label>:
                      </span>
                    <telerik:RadComboBox ID="cmb_CategoryType" runat="server" Height="90" Width="200px"
                        TabIndex="3">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="All" />
                            <telerik:RadComboBoxItem Value="typename" runat="server" Text="Type" />
                            <telerik:RadComboBoxItem Value="spacename" runat="server" Text="Space" />
                            <telerik:RadComboBoxItem Value="assetname" runat="server" Text="Component" />
                        </Items>
                    </telerik:RadComboBox>
                </div>
            </td>
        </tr>

           <tr> <td><div style="height:10px;"> </div>  </td> </tr>
          <tr>      
                <td>
                  <div>
                 <%--<span id="Span5" style="font-size: small; font-weight: lighter;">
                 <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource,Search_By%>">:</asp:Label>
                 </span>--%>
                     <asp:TextBox ID="txtSearch_Issue" runat="server" TabIndex="4" Width="170px"></asp:TextBox>
                
                    <asp:Button ID="btn_clear" runat="server"  Text="<%$Resources:Resource,Clear%>" Width="121px" OnClientClick="javascript:return Clear()"
                         />
                    <asp:Button ID="btnSearch" runat="server"  Text="<%$Resources:Resource,Search%>" Width="121px" OnClick="btnSearch_Click"
                        TabIndex="5" CausesValidation="false" />
                    <asp:Button ID="btnpdf" runat="server" Width="121px" OnClick="btnpdf_click"
                        Text="<%$Resources:Resource,Export_To_PDF%>" TabIndex="6"  />
                    <asp:Button ID="btnShowAI" runat="server" Width="130px" OnClick="btnShowAI_click" OnPageIndexChanged="rgIssue_OnPageIndexChanged"
                        Text="<%$Resources:Resource,Show_All_Issues%>" TabIndex="7"  />
                       
                 </div>     
               
                </td> 
            
         </tr>

           <tr>
            <td>
                <div style="margin-top: 15px; width: 80%;">
                    <telerik:RadGrid ID="rgIssue" runat="server" BorderWidth="1px" CellPadding="0" Width="107%" Skin="Default"
                        AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True" OnItemCommand="rgIssue_ItemCommand" OnItemDataBound="rgIssue_ItemDataBound" OnPageIndexChanged="rgIssue_OnPageIndexChanged"
                        OnSortCommand="rgIssue_OnSortCommand" ItemStyle-Wrap="false"
                         OnPageSizeChanged="rgIssue_OnPageSizeChanged"
                       
                        PagerStyle-AlwaysVisible="true"  
                        GridLines="None" TabIndex="7">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="50%" />
                        <MasterTableView DataKeyNames="pk_work_order_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_work_order_id" HeaderText="cb_work_order_id" Visible="false">
                                    <ItemStyle CssClass="column" Width="100px" />
                                </telerik:GridBoundColumn>
                                
                                <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="work_ordername" CommandName="Profile"
                                    HeaderText="<%$Resources:Resource,Issue_Name%>" SortExpression="work_ordername">
                                    <ItemStyle CssClass="column" Font-Underline="true" Width="300px" Wrap="false" />
                                </telerik:GridButtonColumn>
                                
                                <telerik:GridBoundColumn DataField="work_order_number" HeaderText="<%$Resources:Resource,Issue_Number%>" SortExpression="work_order_number" >
                                    <ItemStyle CssClass="column" Width="300px" Wrap="false" />
                                </telerik:GridBoundColumn>
                                
                                <telerik:GridBoundColumn DataField="work_order_type" HeaderText="<%$Resources:Resource,Issue_Type%>" SortExpression ="work_order_type">
                                    <ItemStyle CssClass="column" Width="300px" />
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="priority" HeaderText="<%$Resources:Resource,Priority%>" SortExpression ="priority">
                                    <%--<ItemStyle CssClass="column" Width="300px" />--%>
                                </telerik:GridBoundColumn>
                                
                                <telerik:GridBoundColumn DataField="organizationusername" HeaderText="<%$Resources:Resource,Assigned_To%>" SortExpression="organizationusername" >
                                    <ItemStyle CssClass="column" Width="300px" Wrap="false" />
                                </telerik:GridBoundColumn>
                                
                                <telerik:GridBoundColumn DataField="requested_by" HeaderText="<%$Resources:Resource,Requested_By%>" SortExpression="requested_by" >
                                    <ItemStyle CssClass="column" Width="300px" Wrap="false" />
                                </telerik:GridBoundColumn>
                                
                                   <telerik:GridBoundColumn DataField="created_on" HeaderText="<%$Resources:Resource,Created_On%>" SortExpression="created_on" >
                                    <ItemStyle CssClass="column" Width="300px" />
                                </telerik:GridBoundColumn>
                                
                                <telerik:GridBoundColumn DataField="work_orderstatus" HeaderText="<%$Resources:Resource, Issue_Status%>" SortExpression="work_orderstatus">
                                 </telerik:GridBoundColumn>
                                
                                 <telerik:GridTemplateColumn DataField="pk_work_order_id" UniqueName="imgbtnclose_" HeaderText="<%$Resources:Resource,Status%>">
                                  <ItemStyle CssClass="column" Width="5%"/>
                                  <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnclose" runat="server" alt="Resolved" CommandName ="closeIssue"  ImageUrl="~/App/Images/remove.gif" OnClientClick="javascript:return close_issues();"/>
                                  </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn DataField="pk_work_order_id" UniqueName="imgbtnDelete_" HeaderText="<%$Resources:Resource,Delete%>">
                                  <ItemStyle CssClass="column" Width="5%"/>
                                  <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" runat="server" alt="<%$Resources:Resource,Delete%>" CommandName ="deleteIssue"  ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return delete_issues();"/>
                                  </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </td>
        </tr>

        
    </table>
    </asp:Panel>
    <table cellpadding="0" cellspacing="0" width="100%" border="0" style="margin: 0px 50px 50px 6px;">
    <tr >
        <td >
        <asp:Button ID="btnaddissue" Text="<%$Resources:Resource,Add_Issue%>" runat="server" OnClick="btnaddissue_click"/>
        
        </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
