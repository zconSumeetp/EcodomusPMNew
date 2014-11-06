<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true" CodeFile="Inspections.aspx.cs" Inherits="App_Asset_Inspections" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register src="../UserControls/UCComboFacility.ascx" tagname="UCComboFacility" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <%-- <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
<link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />--%>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
<script language="javascript" type="text/javascript">

    function Clear() {  

        document.getElementById("ContentPlaceHolder1_txtSearch").value = "";
        return false;

    }
    function get() {
        var answer = confirm("If the inspection is deleted, then issues related to this inspection and issue documents also will be deleted. Are you sure you want to delete this inspection?")
        if (answer)
            return true;
        else
            return false;

    }

    function NavigateToInspectionProfile() {
   
    top.location.href = "../Asset/InspectionMenu.aspx?pagevalue=InspectionProfile&InspectionId=" + document.getElementById('ContentPlaceHolder1_hfInspectionID').value;
}



</script>
</telerik:RadCodeBlock>
<telerik:RadFormDecorator ID="rdfFormDecorator1" runat="server" Skin="Hay" DecoratedControls="Buttons"/>

<div style="padding-left:20px;">
    <table border="0" style="margin-top: 30px; margin-left: 50px;" > 
  
        <caption>
             <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Inspections%>"></asp:Label>
        </caption>
        <tr>
            <th align="left">
                <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, Facility%>"></asp:Label>:
            </th>
            <td>
            <uc1:UCComboFacility ID="UCComboFacility1" runat="server" />
            </td>
            <td>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="SmallTextBox" TabIndex="1"></asp:TextBox>
            </td>
            <td>
           <%-- <telerik:RadButton ID="btnSearch" runat="server" Text="Search" Width="100px" Skin="Hay" TabIndex="2" OnClick="btnSearch_click" />--%>
            <asp:Button ID="btnSearch" runat="server" Text="<%$Resources:Resource, Search%>" Width="100px" Skin="Hay" TabIndex="2" OnClick="btnSearch_click" />
            &nbsp;&nbsp;
           <asp:Button ID="btnClear" runat="server" Width="100px" Text="<%$Resources:Resource, Clear%>" TabIndex="3"  skin="Hay" OnClientClick="javascript:return Clear();" />
           
            <%-- <telerik:RadButton ID="btnClear" runat="server"  Text="Clear" Width="100px"  Skin="Hay" OnClientClicked="Clear"/>--%>

            </td>
        </tr>
        <tr>
            <td colspan="4" align="left">
            <div style="margin-top:15px; width: 559px;">
            <telerik:RadGrid ID="rgInspections" runat="server" BorderWidth="1px" CellPadding="0" AllowMultiRowSelection="true" 
            AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" 
     OnItemCommand="rgInspections_ItemCommand" OnPageIndexChanged="rgInspections_PageIndexChanged" OnPageSizeChanged="rgInspections_PageSizeChanged" OnSortCommand="rgInspections_SortCommand"
      PagerStyle-AlwaysVisible="true" skin="Hay" PageSize="10" GridLines="None" > 
           
             <PagerStyle Mode="NextPrevAndNumeric" />
            <MasterTableView ClientDataKeyNames="pk_inspection_id" DataKeyNames="pk_inspection_id,name,fk_facility_id">
            <Columns>

                <telerik:GridTemplateColumn DataField="name" HeaderText="<%$Resources:Resource, Name%>"  SortExpression="name" >
                    <ItemStyle CssClass="column" />
                        <ItemTemplate>
                           <asp:LinkButton ID="linkInspectionName" PostBackUrl="#" runat="server"
                            Text='<%# DataBinder.Eval(Container.DataItem,"name")%>' CommandName="profile"/>
                        </ItemTemplate>
                </telerik:GridTemplateColumn>

                
                <telerik:GridBoundColumn DataField="description" SortExpression="Description" HeaderText="<%$Resources:Resource, Description%>" UniqueName="Description">
                <ItemStyle CssClass="itemstyle" />
                </telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="inspection_date" AllowSorting="true" HeaderText="<%$Resources:Resource, Date%>" UniqueName="Date">
                <ItemStyle CssClass="column" Width="15%" />
                </telerik:GridBoundColumn>
             

                <telerik:GridTemplateColumn DataField="Facility_name" HeaderText="<%$Resources:Resource, Facility%>"  SortExpression="Facility_name" >
                    <ItemStyle CssClass="column" />
                        <ItemTemplate>
                           <asp:LinkButton ID="linkFacilityName" PostBackUrl="#" runat="server"
                            Text='<%# DataBinder.Eval(Container.DataItem,"Facility_name")%>' CommandName="Facilityprofile"/>
                        </ItemTemplate>
                </telerik:GridTemplateColumn>


                <telerik:GridTemplateColumn DataField="ID" UniqueName="ID">
                    <ItemStyle CssClass="column" Font-Underline="true" Width="5%" />
                        <ItemTemplate>
                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deleteinspection"
                            OnClientClick="javascript:return get();" ImageUrl="~\\App\\Images\\Delete.gif" />
                        </ItemTemplate>
                </telerik:GridTemplateColumn>
                 
            </Columns>
            </MasterTableView>                    
            </telerik:RadGrid>
                
            
            </div>
            </td>
        </tr>
        <tr>
        <td colspan="4">
        <asp:Label ID="lblMessage" CssClass="linkText" runat="server"></asp:Label>
        </td>
        </tr>
        <tr>
            <td colspan="2" align="left"> 
            <asp:Button ID="btnAdd_Inspection" runat="server" Width="120px" Skin="Hay" 
                    Text="<%$Resources:Resource, Add_Inspection%>" TabIndex="4" OnClick="btnAdd_Inspection_Click" />
                       <asp:HiddenField ID="hfuserid" runat="server" />
                         <asp:HiddenField ID="hfInspectionID" runat="server" />
                         <asp:Label runat="server" ID="lblMsg"></asp:Label>
            </td>

        </tr>
   
    </table>

    
</div>





</asp:Content>


