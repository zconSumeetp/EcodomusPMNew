<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MapDocuments.aspx.cs" Inherits="App_Asset_MapDocuments"
     MasterPageFile="~/App/EcoDomusPM_Master.master"  %>

<%@ Register Src="../UserControls/UCMapDocuments.ascx" TagName="UCMapDocuments" TagPrefix="ucMapDoc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="margin: 5px 0px 10px 0px; width: 100%">
        <caption>
            <asp:Label ID="Label3" runat="server" Text="Map Documents"></asp:Label>
        </caption>
        <tr>
            <td style="padding-right: 15px; padding-top: 4px;">
                <ucMapDoc:UCMapDocuments ID="ctrlUCMapDocuments" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
