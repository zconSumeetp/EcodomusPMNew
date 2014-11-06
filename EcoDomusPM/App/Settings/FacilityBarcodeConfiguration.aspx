<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FacilityBarcodeConfiguration.aspx.cs" Inherits="App_Locations_Default" %>
    <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Facility Configuration</title>
      <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link href="../../App_Themes/EcoDomus/style_new_ui_pm.css" rel="stylesheet" type="text/css" />
  <%--  <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <telerik:RadCodeBlock runat="server">
   <script type="text/javascript" language="javascript">
       function saveconfigutation() {
           var grid = $find("<%=rgEntity.ClientID %>"); 
           var MasterTable = grid.get_masterTableView();
           var Rows = MasterTable.get_dataItems(); 
           var tempEntity = 0;
           var tempField = 0;
           if (Rows.length > 0) {
               for (i = 0; i < Rows.length; i++) {
                   var control = Rows[i].findControl("ddlEntity");
                   if (control._selectedIndex == 0) {
                       tempEntity = 1;
                       break;
                   }
                   else if (Rows[i].findControl("ddlField")._selectedIndex == 0 && control._text!="Randomize") {
                       tempField = 1;
                       break;
                   }
               }
           }

           if (tempEntity == 1) {
               alert("Please select entity.");
               return false;
           }
           else if (tempField == 1) {
               alert("Please select field.");
               return false;
           }
           else if ($find("<%=ddlBarcodeType.ClientID %>")._selectedIndex == 0) {
               alert("Please select barcode type.");
               return false;
           }
           else
               return true;
       }
       function isNumberKey(evt) {
           var charCode = (evt.which) ? evt.which : event.keyCode;
           if (charCode != 46 && charCode > 31
            && (charCode < 48 || charCode > 57))
               return false;

           return true;
       }
       function navigate_facilitybarcode(selectedtab,facilityId) {
           var url = "../Settings/FacilityBarcodeConfigurationNew.aspx?Facilityid=" + facilityId + "&entity_name=Facility&selectedtab=" + selectedtab;
           window.location.href(url);
       }





       function enableHeightWidth() {
          
     
           var txtheight = document.getElementById("<%= txtBarcodeHeight.ClientID %>")
           var txtwidth = document.getElementById("<%= txtBarcodeWidth.ClientID %>")
           var ddtemplate = document.getElementById("<%= ddDocumentTemplate.ClientID %>")
           var barcodeperpage = document.getElementById("<%=txtBarcodePerPage.ClientID %>")
           

           
           
           if(ddtemplate.options[ddtemplate.selectedIndex].text== "Custom Template" )  {
                txtheight.disabled = false;
                txtwidth.disabled = false;
                barcodeperpage.disabled = false;
           }
           else           {
                    txtheight.disabled = true;
                     txtwidth.disabled = true;
                     barcodeperpage.disabled= true;
                 }
                 return true;

             }
             function navigate_facilitybarcode(selectedtab, facilityId) {
                 var url = "../Settings/FacilityBarcodeConfigurationNew.aspx?Facilityid=" + facilityId + "&entity_name=Facility&selectedtab=" + selectedtab;

                 window.location.href(url);
             }
    </script>
    </telerik:RadCodeBlock>
<style type="text/css"> 
   <%-- #rgEntity_GridData  
    {  
       overflow-x:hidden !important;  
    } --%>       
    .th    
    {
        font-style:normal;
        font-weight:bolder;
    }
    .style1
    {
        width: 40%;
    }
</style> 
</head>
<%--<style>
   #divGridContainer
   {
        -webkit-border-radius : 15px;
        -moz-border-radius: 15px;
        -khtml-border-radius: 15px;
        border-radius: 15px;
        behavior: url(jquery/border-radius.htc);
    }
   
</style>--%>
<body onload="enableHeightWidth()" style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG');padding:0px 0px 0px 0px;"  >
    <form id="form1" runat="server" style="">
    <div>  
     <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <telerik:RadFormDecorator ID="RadFormDecorator1" DecoratedControls="Buttons,Scrollbars" Skin="Default"
            runat="server" />
            <telerik:RadTabStrip ID="rtsBarcodeEntity" runat="server"  
            MultiPageID="RadMultiPage1" style="margin-top:10px" 
            OnTabClick="Page_Load" SelectedIndex="0" >
            <Tabs>
            <telerik:RadTab Text="<%$Resources:Resource,Component%>" value = "Asset" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="<%$Resources:Resource,Space%>" value= "Space"  ></telerik:RadTab>
            </Tabs>
            </telerik:RadTabStrip>
    <div id="divGridContainer" class="tdZebraLightGray divScroll" style="background-color:transparent; border:1px solid Black; margin-top:5px; margin-left:10px; padding-left:5px; padding-top:5px; width:65%; height:50%;" >
    <asp:UpdatePanel ID="upAddNew" runat="server" >
    <ContentTemplate>
    <fieldset style="border-width:0px; ">
  
     <asp:Button ID="ButtonAdd" runat="server" Text="<%$Resources:Resource,Add_New_Line%>" OnClick="ButtonAdd_Click" Width="100px" /> 
      <telerik:RadGrid ID="rgEntity" runat="server" AllowPaging="false" AutoGenerateColumns="false"
                   PagerStyle-AlwaysVisible="true" Width="100%" height="120px" CssClass="tdZebraLightGray"
                    GridLines="None" BorderWidth="0px"
                    Skin="Default" ShowHeader="false" AlternatingItemStyle-BackColor="white" BorderColor="Black"  >
                    <ClientSettings>
                    <Scrolling AllowScroll="true" ScrollHeight="80px" />
                    </ClientSettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridTemplateColumn>
                              <ItemTemplate>
                                <asp:Label ID="lblSelectEntity" Text="<%$Resources:Resource,Select_Entity%>" runat="server" ></asp:Label>
                             </ItemTemplate>
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn>
                              <ItemTemplate>
                              <telerik:RadComboBox ID="ddlEntity" runat="server"  AutoPostBack="true" OnSelectedIndexChanged="ddlEntityIndexChange"></telerik:RadComboBox>
                                
                             </ItemTemplate>
                            </telerik:GridTemplateColumn>   
                           <telerik:GridTemplateColumn>
                              <ItemTemplate>
                                <asp:Label ID="lblSelectField" Text="<%$Resources:Resource,Select_Field %>" runat="server"></asp:Label>
                             </ItemTemplate>
                            </telerik:GridTemplateColumn>
                           <telerik:GridTemplateColumn>
                              <ItemTemplate>
                              <telerik:RadComboBox ID="ddlField" runat="server" ></telerik:RadComboBox>
                             </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn>
                              <ItemTemplate>
                                <asp:ImageButton  ID="btnDelete" runat="server" ImageUrl="../Images/remove.gif" CausesValidation="false" OnClick="BtnonDelete_ClicK"/>
                             </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid> 
                </fieldset>
                </ContentTemplate>  
                
                </asp:UpdatePanel>
            </div>
            <table style="padding-left:5px; height:100%" cellspacing="10px;"  >
                <tr>
                    <th style="width:15% ;"> <asp:Label ID="lblSelectSymbol" Text="<%$Resources:Resource,Select_Symbol %>" runat="server" CssClass="LabelText"></asp:Label></th>
                    <td style="width:35% ;" class="style1"> <telerik:RadComboBox ID="ddlSymbol" runat="server" Width="79%"></telerik:RadComboBox></td>

                     <th style="width:15% ;"> <asp:UpdatePanel ID="update_lbl_height" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                    <asp:Label ID="lblBarcodeHeight" Text="<%$Resources:Resource,Barcode_Height %>" runat="server" CssClass="LabelText"></asp:Label>
                    </ContentTemplate>
                    </asp:UpdatePanel>
                </th>
                <td style="width:35% ;"> <asp:UpdatePanel ID="update_txt_height" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                    <asp:TextBox ID="txtBarcodeHeight" runat="server" Width="79%" Enabled="false" ToolTip="In Inches"></asp:TextBox>
                    </ContentTemplate> 
                    </asp:UpdatePanel>
                </td>
                </tr>
                <tr>
               
                    <th style="width:15% ;"> <asp:UpdatePanel ID="upRandomLabel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                        <asp:Label ID="lblRandomizationLength" Text="<%$Resources:Resource,Randomization_Length %>" runat="server"  CssClass="LabelText"></asp:Label>
                        </ContentTemplate>
                        </asp:UpdatePanel>
                    </th>
                    <td style="width:35% ;" class="style1">  
                        <asp:UpdatePanel ID="upRandomText" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:TextBox ID="txtRandomizationLength" runat="server" Width="79%" Enabled="false" onkeypress="return isNumberKey(event)"></asp:TextBox>
                        </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>

                     <th style="width:15% ;"> <asp:UpdatePanel ID="update_lbl_width" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                    <asp:Label ID="lblBarcodeWidth" Text="<%$Resources:Resource,Barcode_Width %>" runat="server" CssClass="LabelText"></asp:Label>
                    </ContentTemplate>
                    </asp:UpdatePanel>
                </th>
                <td style="width:35% ;"> <asp:UpdatePanel ID="update_txt_width" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                    <asp:TextBox ID="txtBarcodeWidth" runat="server" Width="79%" Enabled="false" ToolTip="In Inches"></asp:TextBox>
                    </ContentTemplate>
                    </asp:UpdatePanel>
               </td>
                    

                </tr>

                <tr >
                    <th style="width:15% ;"> <asp:Label ID="lblBarcodType" Text="<%$Resources:Resource,Barcode_Type %>" runat="server" CssClass="LabelText"></asp:Label></th>
                    <td style="width:35% ;" class="style1"> <telerik:RadComboBox  ID="ddlBarcodeType" runat="server" Width="79%" height="150px"  ></telerik:RadComboBox></td>
                     <th style="width:15% ;"><asp:Label ID="lblBarcodePerPage" Text="<%$Resources:Resource,Barcode_Per_Page %>" runat="server" CssClass="LabelText" ></asp:Label></th>
                    <td style="width:35% ;"><asp:TextBox ID="txtBarcodePerPage" runat="server" Width="79%" Enabled="false"></asp:TextBox></td>
                </tr>

                 <tr>
                <th style="width:15% ;"><asp:Label ID="lblBarcodeTemplate" Text="<%$Resources:Resource,Document_Template %>" runat="server" CssClass="LabelText"></asp:Label></th>
               <td style="width:35% ;" valign="top" class="style1"> <asp:DropDownList ID="ddDocumentTemplate" runat="server" Width="79%" 
                       onchange="enableHeightWidth()" >
                  
                   </asp:DropDownList></td> 

                      <th style="width:15% ;"><asp:Label ID="lblBarcodePrintOption" Text="<%$Resources:Resource,Barcode_Print_Option %>" runat="server" CssClass="LabelText" ></asp:Label></th>
                        <td style="width:35% ;"><asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="vertical" CssClass="LabelText" >
                        <asp:ListItem Value="0" Text="<%$Resources:Resource,Barcode_without_Data %>"></asp:ListItem>
                        <asp:ListItem Value="1" Selected="True" Text="<%$Resources:Resource,Barcode_with_Data %>"> Barcode with Data</asp:ListItem>
                        </asp:RadioButtonList></td>
              <%--  <td><telerik:RadComboBox ID="ddDocumentTemplate" runat="server" Width="185px"  OnClientTextChange="enableHeightWidth()" OnClientSelectedIndexChanged="enableHeightWidth()" ></telerik:RadComboBox></td>--%>
                </tr>

                
                
                <tr >
                    <th style="width:15% ;"> <asp:Label ID="lblBarcodeSample" Text="<%$Resources:Resource,Barcode_Sample %>" runat="server" CssClass="LabelText"></asp:Label></th>
                    <td  style="width:35% ;" class="style1"> <asp:Image ID="imgBarcodeSample" runat="server"    AlternateText="<%$Resources:Resource,Barcode_Preview %>"/>
                    </td>
                </tr>
               
                <tr >
                    <td style="width:35% ;" colspan=2> 
                        <asp:Button ID="btnPreview" runat="server" Text="<%$Resources:Resource,Preview %>"
                        Width="100px" onclick="btnPreview_Click" OnClientClick="javascript:return saveconfigutation();"/>
                    &nbsp;&nbsp;
                    <asp:Button ID="btnSave" runat="server" Text="<%$Resources:Resource,Save %>" Width="100px"
                        CausesValidation="false" onclick="btnSave_Click" OnClientClick="javascript:return saveconfigutation();" />
                          &nbsp;&nbsp;
                    <asp:Button ID="btnCancel" runat="server" Text="<%$Resources:Resource,Cancel %>" Width="100px"
                        CausesValidation="false" onclick="btnCancel_Click" />
                     </td>
                </tr>
    
            </table>

    </div>
    </form>
</body>
</html>
