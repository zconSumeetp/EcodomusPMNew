<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true" CodeFile="Floors.aspx.cs" Inherits="App_Settings_Floors" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


 <table style="margin-top:15px; margin-left:50px;" align="center" >
        
        <tr>
            <td>
            <asp:Label runat="server" ID="lblfacility" Text="<%$Resources:Resource,Facility%>" CssClass="Label"  ></asp:Label>:
                <telerik:RadComboBox ID="cmbfacility" runat="server" ></telerik:RadComboBox>
            </td>
        </tr>

        </table> 
  
</asp:Content>

