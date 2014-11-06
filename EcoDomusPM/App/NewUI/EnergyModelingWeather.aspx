<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="EnergyModelingWeather.aspx.cs" Inherits="App_NewUI_EnergyModelingWeather" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
     <script type="text/javascript">
         var $fileInput;
         function onClientAdded(sender, args) {
             $fileInput = $telerik.$(args._fileInputField);
         }

         function OpenDialog() {
             $fileInput.click();
         }


         function show_data() {

         }

         $(document).ready(function () {
             //thes 2line removes 'rcSingle' class Dynamically from webresource.axd file which comming from webresources
             
            
             //these 2 Line Removes .css Class Dynamically from Document files..
             $("#ctl00_ContentPlaceHolder1_RadListBox1").removeClass('RadListBox  RadListBoxScrollable'); //RadListBox_Default
             $("#ctl00_ContentPlaceHolder1_lb_weather_files").removeClass('RadListBoxScrollable RadListBox ');
             $("#div_contentPlaceHolder").scroll(function () {
                 $("#ctl00_ContentPlaceHolder1_btnConfigure,#ctl00_ContentPlaceHolder1_rbtn_upload_file").removeClass('rbSkinnedButton');
                 $("#ctl00_ContentPlaceHolder1_btnConfigure,#ctl00_ContentPlaceHolder1_rbtn_upload_file").addClass('rbSkinnedButton');
               
                 $("#ctl00_ContentPlaceHolder1_ru_file").removeClass('RadUpload');
                 $("#ctl00_ContentPlaceHolder1_ru_filefile0").hide();

                 $("#ctl00_ContentPlaceHolder1_ru_file").addClass('RadUpload');

                 $("#ctl00_ContentPlaceHolder1_ru_filefile0").show();

             });

           
              
         });

         function NiceScrollOnload() {
             if (screen.height > 721) {
                 $("html").css('overflow-y', 'hidden');
                 $("html").css('overflow-x', 'auto');
             }
             var screenhtg = set_NiceScrollToPanel();
         }

         function setRadListBoxScrollable() {
             $("#ctl00_ContentPlaceHolder1_lb_weather_files").addClass('RadListBoxScrollable RadListBox_Default RadListBox');
             
         }
         function removeRadListBoxScrollable() {

             $("#ctl00_ContentPlaceHolder1_lb_weather_files").removeClass('RadListBoxScrollable RadListBox');
         }


    </script>
    </telerik:RadCodeBlock>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" 
         DecoratedControls="Buttons, Textbox" />
    <div>
        <table border="2" cellpadding="0" cellspacing="0" width="98%" style="border-collapse: collapse;border-top-color:transparent;border-top-width:0px;border-left-color:transparent;border-left-width:0px">
            <tr>
                <td style="border-bottom-color:transparent;border-bottom-width:0px">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" style=" border-collapse:collapse; border-width: 0px">
                        <tr>
                            <td style="width: 7%; margin: 0px;">
                                <asp:Image ID="img_weather_tab" runat="server" ImageUrl="~/App/Images/Icons/Tab.png"/>
                            </td>
                            <td style="width: 83%">
                            </td>
                            <td style="width: 10%" align="right">
                                <table border="0">
                                    <tr>
                                        <td align="right">
                                            <asp:ImageButton ID="img_edit" runat="server" ImageUrl="~/App/Images/Icons/icon_edit_sm.png"
                                                Width="15" Height="15" ImageAlign="Bottom" />
                                            <asp:LinkButton ID="lbtn_edit" runat="server" Text="EDIT" ForeColor="Black" CssClass="lnkButton"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            

            <tr>
            <td style="border-top-color:transparent;border-top-width:0px;">
                <table border="1" cellpadding="0" cellspacing="0" width="100%" style="margin-top: -1px;
                    border-collapse: collapse; border-top-color: transparent; border-top-width: 0px;
                    border-bottom-color: transparent; border-bottom-width: 0px; border-right-color: transparent;
                    border-right-width: 0px">
                    <tr>
                        <td style="padding-top: 15px; padding-left: 15px; height: 57px;">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="background-image: url('../Images/asset_container_2.png'); height: 40px;
                                        width: 200px; background-repeat: no-repeat;" align="center">
                                        <asp:Label ID="lbl_project_name" runat="server" Text="Project Name" Font-Size="10"
                                            ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                    </td>
                                    <td style="width: 5px">
                                    </td>
                                    <td style="background-image: url('../Images/asset_container_3.png'); height: 40px;
                                        width: 200px; background-repeat: no-repeat" align="center">
                                        <asp:Label ID="lbl_list" runat="server" Text="Simulation Control" Font-Size="10"
                                            ForeColor="Red" CssClass="normalLabel"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px; padding-top: 15px; padding-bottom: 15px">
                            <asp:Label ID="Label2" Text="Select weather configuration for the simulation project."
                                runat="server" ForeColor="Black" Width="500" CssClass="lblBold"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px">
                            <table border="0" width="100%" cellpadding="0" cellspacing="0" align="left"  style="background-image: url('/App/Images/asset_button_orange_large.png');
                                background-repeat: no-repeat; background-position: inherit; height: 26px;vertical-align:middle">
                                <tr>
                                    <td style="padding-left: 5px;" valign="top" colspan="2">
                                        <asp:CheckBox ID="chk_noaa_weather_data" runat="server" Text="NOAA Weather Data"  CssClass="normalLabel"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 30px; padding-top: 10px; width: 100%">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td style="width:40%; padding-bottom: 5px">
                                        <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="padding-left:5px;">
                                                    <asp:Label ID="Label1" runat="server" Text="Select NOAA Weather Station" Width="225" CssClass="normalLabelBold" ForeColor="#8B8B8B"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <telerik:RadButton ID="btnConfigure" runat="server" Width="150px" Text="Configure NOAA Weather">
                                                    </telerik:RadButton>
                                                  <%--  <asp:Button ID="btnConfigure" runat="server" Width="155px"  Text="Configure NOAA Weather"/>--%>
                                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="padding-top: 5px">
                                                    <asp:TextBox ID="txt1" runat="server" Width="410" BackColor="#FFFFE1" Height="15"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 2%">
                                    </td>
                                    <td style="width: 58%">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 40%">
                                        <telerik:RadListBox ID="RadListBox1" runat="server" Width="100%"  BorderStyle="Solid" BorderWidth="0px" BackColor="White" BorderColor="#8E8E8E"
                                            Height="100" AutoPostBack="false" Font-Names="Arial" Font-Size="10pt" 
                                            ></telerik:RadListBox>
                                    </td>
                                    <td style="width: 2%">
                                    </td>
                                    <td style="width: 58%" valign="top">
                                    <p>
                                        <asp:Label ID="lbl_1" runat="server" Text="Note:" CssClass="normalLabel" ForeColor="#8B8B8B"></asp:Label>
                                        </p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px;padding-top:10px">
                            <table border="0" width="100%" cellpadding="0" cellspacing="0" align="left" style="background-image: url('/App/Images/asset_button_orange_large.png');
                                background-repeat: no-repeat; background-position: inherit; height: 26px;vertical-align:middle">
                                <tr>
                                    <td style="padding-left: 5px;" colspan="2" valign="top">
                                        <asp:CheckBox ID="chk_weather_data_from_file" runat="server" Text="Weather Data From File"  CssClass="normalLabel"/>
                                        
                                    </td>
                                   <%-- <td valign="middle" style="padding-left: 0px;">
                                        <asp:Label ID="Label6" runat="server" Text="Weather Data From File" CssClass="lblBold"></asp:Label>
                                    </td>--%>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 30px; padding-top: 10px; width: 100%">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td style="width: 40%; padding-bottom: 5px">
                                        <table border="0" width="100%" cellpadding="0" cellspacing="0" align="left">
                                            <tr>
                                                <td style="padding-left: 5px;padding-bottom:10px">
                                                    <asp:Label ID="Label4" runat="server" Text="Select Weather Data File" CssClass="normalLabelBold" ForeColor="#8B8B8B"></asp:Label>
                                                </td>
                                                <td>
                                                
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="middle">
                                                    <telerik:RadUpload ID="ru_file" runat="server" InputSize="25" CssClass="RadUpload"   EnableFileInputSkinning="true" 
                                                        OnClientAdded="onClientAdded" Width="100%" ControlObjectsVisibility="None" OnClientFileSelected="show_data" FocusOnLoad="true"
                                                        AllowedFileExtensions=".epw,.EPW" />
                                                       
                                                </td>
                                                <td valign="top">
                                                <telerik:RadButton ID="rbtn_upload_file" runat="server" Width="150px" AutoPostBack="true" 
                                                        Text="Upload Weather Data File" onclick="rbtn_upload_file_Click">
                                                    </telerik:RadButton>
                                                </td>
                                                
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="padding-top: 5px">
                                                    <asp:TextBox ID="txt_weather_file_name" runat="server" Width="410" BackColor="#FFFFE1" Height="15"></asp:TextBox>
                                                </td>
                                            </tr>
                                            
                                        </table>
                                    </td>
                                    <td style="width: 2%">
                                    </td>
                                    <td style="width: 58%">
                                    <p>
                                        <asp:Label ID="lbl_2" runat="server" Text="Note:" CssClass="normalLabel" ForeColor="#8B8B8B"></asp:Label>
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 40%">
                                        <telerik:RadListBox ID="lb_weather_files" runat="server" Width="100%"  BorderStyle="Solid" BorderWidth="0px" BackColor="White" BorderColor="#8E8E8E"
                                            Height="100" AutoPostBack="true" Font-Names="Arial" Font-Size="10pt" onselectedindexchanged="lb_weather_files_SelectedIndexChanged"></telerik:RadListBox>
                                    </td>
                                    <td style="width:2%"> 
                                    </td>
                                    <td style="width: 58%" valign="middle">
                                        <p>
                                            <asp:Label ID="lbl_3" runat="server" Text="Note:" CssClass="normalLabel" Width="100%" ForeColor="#8B8B8B"></asp:Label>
                                        </p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 30px; padding-top: 5px; padding-bottom: 10px">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td style="padding-bottom: 5px">
                                        <asp:Label ID="Label3" runat="server" Text="Additional weather data files are available at:"
                                            CssClass="LabelNormal"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:HyperLink ID="lbtn" runat="server" Text="http://apps1.eere.energy.gov/buildings/energyplus/cfm//weather data.cfm"
                                            CssClass="normalLabel" ForeColor="Blue" Font-Underline="true" NavigateUrl="http://apps1.eere.energy.gov/buildings/energyplus/cfm//weather data.cfm"
                                            Target="_blank"></asp:HyperLink>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            </tr>
            </table>
   </div>

    

    <telerik:RadAjaxManagerProxy  runat="server" ID="RadAjaxManagerProxy1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="lb_weather_files">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txt_weather_file_name" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="ctl00_ContentPlaceHolder1_ru_file">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ru_file" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default" />
</asp:Content>
