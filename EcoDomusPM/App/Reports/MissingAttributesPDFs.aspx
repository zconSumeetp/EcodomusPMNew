<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MissingAttributesPDFs.aspx.cs" Inherits="App_Reports_MissingAttributesPDFs" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Issue Report</title>
    <style type="text/css">
        .GridRow_Gray td, .GridAltRow_Gray td
        {
            border: none;
            border-collapse: inherit;
        }
    </style>
    <style type="text/css">
        
          #rgMissingAttributes
        {
            border: solid 2px black;
        }
         #rgMissingAttributes td
        {

            border-right: solid 1px black;
            border-left: solid 1px black;
        }
        
    /* #rg_missing_attribute_reports
        {
            border: solid 2px black;
        }
        #rg_missing_attribute_reports td
        {
            border-bottom: none;
            border-top: none;
            border-right: solid 1px black;
            border-collapse: collapse;
        }
        #rg_missing_attribute_reports thead th
        {
            border-bottom: solid 1px black;
            border-top: none;
            border-right: solid 1px black;
            border-collapse: collapse;
            background: #F5F5F5;
        }*/
    </style>
</head>
<body>
   
    <form id="form1" runat="server">
    <asp:ScriptManager ID="S1" runat="server">
    </asp:ScriptManager>
    <div>
        <table width="100%">
          
        <%--    <caption style="font-size: 20px; width:182px;text-align:left">
            Missing Attributes           
                </caption>       --%>
                
        </table>
        <table width="100%">
               
               <tr align="center">
               <td>
               <asp:Label ID="lbl_missing_attributes" runat="server" Text="Missing Attributes"></asp:Label>
               </td>
               </tr>

            <tr align="center">
                <td>
                    <div style="margin-top: 15px;">
                     <telerik:RadGrid ID="rg_missing_attribute_reports" runat="server"  Font-Bold="true" Font-Size="Large" 
                            AllowPaging="true" AllowSorting="true" ExportSettings-Pdf-FontType="Embed"                           
                           AutoGenerateColumns="false" PagerStyle-AlwaysVisible="true" Width="60%" >


                           <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="left" Width="100%" />
                           <MasterTableView DataKeyNames="id,omniclass_id" GridLines="Vertical">
                           <Columns>

                              <telerik:GridBoundColumn DataField="omniclass_id" HeaderText="omniclass_id"
                                    Visible="false">                                   
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn  DataField="omniclassname" HeaderText="<%$Resources:Resource,OmniClass%>" SortExpression="omniclassname">
                                  <ItemStyle CssClass="column" Width ="20%" Font-Size="11px" ></ItemStyle>
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="name"  HeaderText="<%$Resources:Resource,Name%>" UniqueName="column" SortExpression="name" >                               
                                  <ItemStyle CssClass="column"  Width ="10%" Font-Size="11px" ></ItemStyle>
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="attributes"  HeaderText="<%$Resources:Resource,Required_Attributes%>" UniqueName="column" SortExpression="attributes" >                               
                                  <ItemStyle CssClass="column"  Width ="10%" Font-Size="11px" ></ItemStyle>
                                </telerik:GridBoundColumn>

                           </Columns>
                           </MasterTableView>
                          </telerik:RadGrid>

                    </div>
                </td>
            </tr>
        
        </table>
    </div>
    </form>
</body>
</html>
