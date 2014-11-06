<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FacilityBarcodeConfigurationNew.aspx.cs" Inherits="App_Settings_Default" %>
 <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=8;FF=3;OtherUA=4" />
    <title></title>
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
  <%--  <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
   <script type="text/javascript" language="javascript">
         function navigate_facilitybarcode(selectedtab,facilityId) {
             var url = "../Settings/FacilityBarcodeConfiguration.aspx?Facilityid=" + facilityId + "&entity_name=Facility&selectedtab=" + selectedtab;
           
           window.location.href(url);
       } 
        
    
       function Configurefacility() {

           alert("Barcode is not configured");

       }
    </script>
    </telerik:RadCodeBlock> 
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG');padding:0px 0px 0px 0px;" >
    <form id="form1" runat="server" style="">
    <div>  
     <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <telerik:RadFormDecorator ID="RadFormDecorator1" DecoratedControls="Buttons,Scrollbars" Skin="Default"
            runat="server" />
            <telerik:RadTabStrip ID="rtsBarcodeEntity" runat="server"  
            MultiPageID="RadMultiPage1" SelectedIndex="0" style="margin-top:10px" 
            OnTabClick="Page_Load">
            <Tabs>
            <telerik:RadTab Text="<%$Resources:Resource,Component%>" value = "Asset" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="<%$Resources:Resource,Space%>" value= "Space" ></telerik:RadTab>
            </Tabs>
            </telerik:RadTabStrip>
    <div id="divGridContainer" style="background-color:White; border:1px solid black; margin:10px 10px 10px 10px; padding:10px 10px 10px 10px; width:45%" >

      <telerik:RadGrid ID="rgEntity" runat="server" AllowPaging="false" AutoGenerateColumns="false"
                   PagerStyle-AlwaysVisible="true" Width="95%" 
                    GridLines="None" BorderWidth="0px"
                    Skin="Default" ShowHeader="false" AlternatingItemStyle-BackColor="white" >
                    <ClientSettings>
                    <Scrolling AllowScroll="true" ScrollHeight="100" />
                    </ClientSettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridTemplateColumn>
                              <ItemTemplate>
                                <asp:Label ID="lblEntity" Text="<%$Resources:Resource,Entity %>" runat="server" ></asp:Label>
                             </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="entity_name">
                            </telerik:GridBoundColumn>
                            <%-- <telerik:GridTemplateColumn>
                              <ItemTemplate>
                               <asp:Label ID="lblEntityValue" runat="server" ></asp:Label>
                                
                             </ItemTemplate>
                            </telerik:GridTemplateColumn>   --%>
                           <telerik:GridTemplateColumn>
                              <ItemTemplate>
                                <asp:Label ID="lblField" Text="<%$Resources:Resource,Field %>" runat="server"></asp:Label>
                             </ItemTemplate>
                            </telerik:GridTemplateColumn>
                             <telerik:GridBoundColumn DataField="field_name">
                           </telerik:GridBoundColumn>
                          <%-- <telerik:GridTemplateColumn>
                              <ItemTemplate>
                              <asp:Label ID="lblFieldValue" runat="server"></asp:Label>
                             </ItemTemplate>
                            </telerik:GridTemplateColumn>--%>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
            <table style="padding-left:10px;" cellspacing="15px";>
                <tr>
                    <td style="width:15%;"> <asp:Label ID="lblSymbol" Text="<%$Resources:Resource,Symbol %>" runat="server" CssClass="LabelText"></asp:Label></td>
                    <td style="width:30%;"><asp:Label  ID="lblSymbolValue" runat="server" CssClass="LabelText"></asp:Label> </td>
                    <td style="Width:15%"><asp:Label  ID="lblBarcodeHeight" Text="<%$Resources:Resource,Barcode_Height %>" runat="server" CssClass="LabelText"></asp:Label></td>
                    <td style="width:30%;"><asp:Label  ID="lblBarcodeHeightValue" runat="server" CssClass="LabelText"></asp:Label></td>
                </tr>
                <tr>
                
                    <td style="width:15%;">
                        <asp:Label ID="lblRandomizationLength" Text="<%$Resources:Resource,Randomization_Length %>" runat="server" CssClass="LabelText"></asp:Label></td>
                    <td style="width:30%;">  
                        <asp:Label ID="lblRandomizationLengthValue" runat="server" CssClass="LabelText"></asp:Label>
                    </td>
                    <td style="width:15%;"><asp:Label  ID="lblBarcodeWidth" Text="<%$Resources:Resource,Barcode_Width %>" runat="server" CssClass="LabelText"></asp:Label></td>
                    <td style="width:30%;"><asp:Label  ID="lblBarcodeWidthValue" runat="server" CssClass="LabelText"></asp:Label></td>
              
                </tr>
                <tr >
                    <td style="width:15%;"> <asp:Label ID="lblBarcodeType" Text="<%$Resources:Resource,Barcode_Type %>" runat="server" CssClass="LabelText"></asp:Label></td>
                    <td style="width:30%;"> <asp:Label ID="lblBarcodeTypeValue" runat="server" CssClass="LabelText"></asp:Label></td>
                    <td style="width:15%;"><asp:Label  ID="lblBarcodePerPage" Text="<%$Resources:Resource,Barcode_Per_Page %>" runat="server" CssClass="LabelText"></asp:Label></td>
                    <td style="width:30%;"><asp:Label  ID="lblBarcodePerPageValue" runat="server" CssClass="LabelText"></asp:Label></td>

                </tr>

                <tr>
                    <td style="width:15%;"><asp:Label ID="lblTemplatetype" Text="<%$Resources:Resource,Document_Template %>" runat="server" CssClass="LabelText"></asp:Label></td>
                    <td style="width:30%;"><asp:Label ID="lblTemplateValue" runat="server" CssClass="LabelText"></asp:Label></td>
                    <td style="width:15%;"><asp:Label ID="lblBarcodePrintOption" Text="<%$Resources:Resource,Barcode_Print_Option %>" runat="server" CssClass="LabelText"></asp:Label> </td>
                    <td style="width:30%;"><asp:Label ID="lblBarcodePrintOptionValue" runat="server" CssClass="LabelText"></asp:Label></td>
                </tr>

                <tr>
                    <td style="width:15%;"> <asp:Label ID="lblBarcodeSample" Text="<%$Resources:Resource,Barcode_Sample %>" runat="server" CssClass="LabelText"></asp:Label></td>
                    <td style="width:30%; height:50%" > <asp:Image ID="imgBarcodeSample" runat="server"
                            AlternateText="Brcode Preview" />
                    </td>
                </tr>
                <tr >
                <td style="width:15%;">
                    <asp:Button ID="btnEdit" runat="server" Text="<%$Resources:Resource,Edit %>" width="100px"
                        CausesValidation="false" onclick="btnEdit_Click"  />             
                     </td>
                </tr>
    
            </table>

    </div>
    </form>
</body>
</html>
