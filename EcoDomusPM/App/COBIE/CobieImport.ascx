<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CobieImport.ascx.cs" Inherits="App_COBIE_CobieImport" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

   
   <telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Default" DecoratedControls="Buttons" />
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
   <script type="text/javascript" language="javascript">

       function ProjectValidation() {

           alert('Please select Project');
           window.location = '../Settings/Project.aspx';
           return false;

       }
       function NiceScrollOnload() {

           var screenhtg = set_NiceScrollToPanel();
           if (screen.height >= 725) {
               $("html").css('overflow-y', 'hidden');
               $("html").css('overflow-x', 'auto');
           }
       } 
       function onClientProgressBarUpdating(progressArea, args) {
           progressArea.updateHorizontalProgressBar(args.get_progressBarElement(), args.get_progressValue());
           args.set_cancel(true);
       }
       function ImportRequestMessage() {
           // debugger
            if (document.getElementById('ruImportLocation') == null) {
                alert("Please select the file with the extensions like .xlsx or .xls");
                return true;
            }
       }

    
    function validateRadUpload1(source, arguments) {
        arguments.IsValid = $find("<%= ruImportLocation.ClientID %>").validateExtensions();
    }
    function validateRadUpload1(source, arguments) {
        arguments.IsValid = $find("<%= ruImportLocation.ClientID %>").validateExtensions();
    }
    function validateRadUpload(source, e) {
        e.IsValid = false;
        var upload = $find("<%= ruImportLocation.ClientID %>");
        var inputs = upload.getFileInputs();
        for (var i = 0; i < inputs.length; i++) {
            //check for empty string or invalid extension     
            if (inputs[i].value != "" && upload.isExtensionValid(inputs[i].value)) {
                e.IsValid = true;
                break;
            }
        }
    }
</script>
<style>

.ruFileWrap
        {
            padding: 1px !important;
        }

</style>
</telerik:RadCodeBlock>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
 <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
   <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />

 <div>
        <table  style="margin: 20px 0px 00px 0px"; border="0">
            <caption>
            <asp:Label ID="Label2" runat="server" Text= "<%$Resources:Resource,COBie_File_Import%>" ></asp:Label>
             </caption>   
                  <%--<asp:Label ID="Label2" Text="" runat ="server" ForeColor="Maroon" Font-Size="Small"  Skin="Hay" > </asp:Label>--%>
           
          <tr id="Tr1"  runat="server">
                <td valign="top" align="left" >
                    <telerik:RadUpload ID="ruImportLocation" Skin="Default"  allowedfileextensions=".xlsx,.xls"  runat="server" ControlObjectsVisibility="None" 
                      Width="230px" FocusOnLoad="true" />
                         

                        </td>
                      
                        <td valign="top" >
                       <asp:Button CausesValidation="true" ID="btnupload" runat="server" Text="<%$Resources:Resource,Upload%>"
                                Width="70px" onclick="btnupload_Click" />
                            <asp:Label ID="lbl_valid" runat="server" Skin="Default" Font-Bold="True" 
                                Font-Size="Medium" ForeColor="#FF6600"></asp:Label>
                </td>
                  <td>
                        <asp:CustomValidator runat="server"  ID="CustomValidator1" Display="Dynamic" ClientValidationFunction="validateRadUpload1"
    OnServerValidate="CustomValidator1_ServerValidate" ErrorMessage="Please select the file with the extensions like .xlsx or .xls" ForeColor="Red" Font-Size="Small" >        
  
</asp:CustomValidator>
<%-- <asp:CustomValidator runat="server"  ID="CustomValidator2" Display="Dynamic"
    OnServerValidate="CustomValidator2_ServerValidate" ErrorMessage="Please select the file with the extensions like .xlsx or .xls" ForeColor="Red" Font-Size="Small" ClientValidationFunction="validateRadUpload">        
  
</asp:CustomValidator>
--%>

                        
                        </td>
                
             
            </tr>
            </table>
            <%--<table>
           
           <%-- <caption>
             <asp:Label ID="lbluploadmsg" Text="" runat ="server"  Skin="Hay" > </asp:Label>
              </caption>

               
                        </table >--%>
                         <asp:Label ID="lbluploadmsg" Text="" runat ="server" ForeColor="Maroon" Font-Size="Small"  Skin="Default" > </asp:Label>
       <table style="margin: 20px 0px 00px 0px"; border="0" width="80%">
             <caption>
                 <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Imported_Files%>"></asp:Label>
              </caption>
            <tr>
             <td >
         <asp:Timer ID="Timer1" Interval="10000" OnTick="Timer1_click" runat="server"></asp:Timer>
             <telerik:RadGrid ID="radgimported_files" runat="server" EnableViewState="true"  Visible="true"
                AllowPaging="True" AllowSorting="True" AutoGenerateColumns="false"  BorderWidth="1px" 
                                 CellPadding="0" Width="100%" 
                GridLines="None" PageSize="10"  EnableEmbeddedSkins="true"  Skin="Default" 
                                 onpageindexchanged="radgimported_files_PageIndexChanged" 
                                 onpagesizechanged="radgimported_files_PageSizeChanged" 
                                 onsortcommand="radgimported_files_SortCommand" 
                                 onitemcommand="radgimported_files_ItemCommand">

                    <PagerStyle mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" AlwaysVisible="true"  />
                    <ClientSettings>
                        <Selecting AllowRowSelect="true"  />
                    </ClientSettings>
                        <MasterTableView DataKeyNames="pk_uploaded_file_id">
                        <Columns>
                       <telerik:GridBoundColumn  DataField="file_name" HeaderText="<%$Resources:Resource,File_Name%>" UniqueName="FileName" >
                       </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn  DataField="imported_on" HeaderText="<%$Resources:Resource,Imported_on%>" UniqueName="ImportedOn"  DataFormatString="{0:MM/dd/yy hh:mm tt}" >
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn  DataField="importedby" HeaderText="<%$Resources:Resource,Imported_by%>" UniqueName="ImportedBy">
                    </telerik:GridBoundColumn>   
                    <telerik:GridBoundColumn  DataField="filesize" HeaderText="<%$Resources:Resource,File_size%>" UniqueName="FileSize" >
                    </telerik:GridBoundColumn>  
                     <telerik:GridBoundColumn  DataField="status" HeaderText="<%$Resources:Resource,Status%>" UniqueName="Status">
                    </telerik:GridBoundColumn>    
                 <%--    <telerik:GridBoundColumn  DataField="message" HeaderText="<%$Resources:Resource,message%>" UniqueName="message">
                    </telerik:GridBoundColumn> --%> 
                       <telerik:GridTemplateColumn  UniqueName="imgbtnDelete_" HeaderText="<%$Resources:Resource,Delete%>">
                                  <ItemStyle CssClass="column" Width="7%"/>
                                  <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" OnClientClick="javascript:return deleteRequest();" CommandName ="Deletefile"  ImageUrl="~/App/Images/Delete.gif"/>
                                  </ItemTemplate>
                                </telerik:GridTemplateColumn> 
                 <telerik:GridBoundColumn  DataField="file_results" HeaderText="File Results" UniqueName="FileResults" Visible="false">
                    </telerik:GridBoundColumn>            
                      </Columns>
                      </MasterTableView>
                       </telerik:RadGrid>
                        </td>
                        </tr>
                        <tr>
                            <td style="width: 50%; vertical-align: top;">
                        <telerik:RadProgressManager ID="Radprogressmanager1" runat="server" />
                        <telerik:RadProgressArea ID="rpaImportLocation" runat="server" Localization-TotalFiles="1" Skin="Default"
                                  OnClientProgressBarUpdating="onClientProgressBarUpdating" ProgressIndicators="TotalProgressBar, TotalProgress, TotalProgressPercent, RequestSize, FilesCountPercent, SelectedFilesCount, CurrentFileName, TimeElapsed, TimeEstimated, TransferSpeed">
                        </telerik:RadProgressArea>
                    </td>
                        </tr>
                        </table>
     <telerik:RadAjaxManagerProxy ID="radAjaxmager" runat="server">
     <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Timer1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="radgimported_files" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
                  <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lbluploadmsg"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="radgimported_files">
            <UpdatedControls>
            <telerik:AjaxUpdatedControl ControlID="radgimported_files" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
                 </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>    
       
  
      <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
         </telerik:RadAjaxLoadingPanel>
         <asp:HiddenField ID="hfstrprojectdId" runat="server" />
           <asp:HiddenField ID="hfstruploaded_file_id" runat="server" />
 </div>
