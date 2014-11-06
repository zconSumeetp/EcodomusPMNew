<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FileHistoryPopup.aspx.cs" Inherits="App_Settings_fileHistoryPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head>
<title></title>
 <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
        <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />

 <telerik:RadCodeBlock ID="radcodeblock2" runat="server">
        <script language="javascript" type="text/javascript">

            function CloseWindow1() {
                GetRadWindow().close();
                return false;
            }
            function CancelWindow() {
                CloseWindow1();
            }
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog      
                else if (window.frameElement != null) {
                    if (window.frameElement.radWindow)
                        oWindow = window.frameElement.radWindow; //IE (and Moz as well)      
                }
                return oWindow;
            }
            function closeWindow() {

                var rdw = GetRadWindow();
                rdw.close();
                //self.close();
            }
            function adjust_height() {
                debugger;

                var wnd = GetRadWindow();
                if (wnd != null) {
                    var bounds = wnd.getWindowBounds();
                    var x = bounds.x;
                    var y = bounds.y;
                    //alert(x);
                    //alert(y);
                    //  if (x == 0)
                   // wnd.moveTo(x + 25, 02);

                    wnd.set_height(document.body.scrollHeight + 30)
                    if (document.getElementById('hf_size').value == "ALL") {
                        wnd.set_height(document.body.scrollHeight + 40)
                        wnd.set_width(document.body.scrollWidth - 100);
                        document.getElementById('hf_size').value = "";
                    }

                    // wnd.set_height(450);
                }
                window.parent.adjustHeight();
            }
            function adjust_width() {
                var wnd = GetRadWindow();
                if (wnd != null) {
                  //  document.getElementById('hf_size').value = "ALL";
                    wnd.set_height(document.body.scrollHeight + 40)
                    wnd.set_width(document.body.scrollWidth + 150);
                }

            }

            function jump_model(file_id, facility_id, file_name, fk_master_file_id) {
                //debugger
                var str = file_name.toString();
                var url;
                if (str.match("nwd") == "nwd") {
                   // window.location.replace("ModelViewer.aspx?FileId=" + file_id + "&view_pt=none&fk_master_file_id=" + fk_master_file_id + "&facility_id=" + facility_id + "&name="+ file_name +"&history_flag=Y");
                    //  window.location.replace("ModelViewer.aspx?name=" + file_name + "&view_pt=none&fk_master_file_id=" + fk_master_file_id + "&facility_id=" + facility_id + "");
                    url = "ModelViewer.aspx?FileId=" + file_id + "&view_pt=none&fk_master_file_id=" + fk_master_file_id + "&facility_id=" + facility_id + "&name="+ file_name +"&history_flag=Y";
                   // alert(url);
                    window.parent.navigate(url);
                   
                    return false;
                }
                else {
                    url = "EcodomusModelViewer.aspx?FileId=" + file_id + "&view_pt=none&fk_master_file_id=" + fk_master_file_id + "&facility_id=" + facility_id + "&history_flag=Y";
                    window.parent.navigate(url);
                   // window.location.replace("EcodomusModelViewer.aspx?FileId=" + file_id + "&view_pt=none&fk_master_file_id=" + fk_master_file_id + "&facility_id=" + facility_id + "");
                    return false;
                }
            }

            window.onload = adjust_height;

          </script>
    </telerik:RadCodeBlock>
</head>
  
   

<body style="margin: 0px 0px 0px 0px; background-color: #EEEEEE;overflow:hidden;padding:0px;" >
<form id="form1" runat="server">
 
    <table id="man_serch" width="100%">
    <tr>
            <td class="wizardHeadImage">
                <div class="wizardLeftImage">
                   <%-- <asp:Image ID="img_entity" ImageAlign="Left" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_sm.png" />--%>
                    <asp:Label ID="Label1" Text="History" style="font-size :medium ;" runat="server"></asp:Label>
                </div>
                <div class="wizardRightImage">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                         OnClientClick="javascript:return CancelWindow();" />
                </div>
            </td>
        </tr>        
    </table>

    <table id="Table1" width="100%" >
    <tr>
     <td>
    <telerik:RadGrid ID="rghistory" runat="server" AutoGenerateColumns="false" Skin="Default"
                                    AllowSorting="True" PageSize="10"  AllowPaging="True" GridLines="None"                                
                                    OnPageSizeChanged="rghistory_pagesizeChanged"  OnItemCommand="rghistory_OnItemCommand"  OnItemDataBound="rghistory_ItemDataBound"
                                    Width="100%"  PagerStyle-AlwaysVisible="true" CellPadding="0" CellSpacing="0"
                                    ItemStyle-Wrap="false">
                                    <PagerStyle Mode="NextPrevAndNumeric" />
                                    <ClientSettings>
                                       
                                        <%--<ClientEvents  OnRowSelected="RowSelected" />--%>
                                    </ClientSettings>
                                    <FilterMenu EnableEmbeddedSkins="false">
                                    </FilterMenu>
                                    <GroupingSettings CaseSensitive="false" /> 
                                    <MasterTableView DataKeyNames="fk_uploaded_file_id,pk_uploaded_file_id_history">
                                    <Columns>
                                     <telerik:GridBoundColumn DataField="pk_uploaded_file_id_history" HeaderText="pk_uploaded_file_id_history"
                                                Display="False" SortExpression="pk_uploaded_file_id_history" UniqueName="pk_uploaded_file_id_history">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="fk_uploaded_file_id" HeaderText="fk_uploaded_file_id"
                                                Display="False" SortExpression="fk_uploaded_file_id" UniqueName="fk_uploaded_file_id">
                                            </telerik:GridBoundColumn>
                                            
                                             <telerik:GridBoundColumn DataField="fk_master_file_id" HeaderText="fk_master_file_id"
                                                Display="False" SortExpression="fk_master_file_id" UniqueName="fk_master_file_id">
                                            </telerik:GridBoundColumn>

                                             <telerik:GridBoundColumn DataField="fk_facility_id" HeaderText="fk_facility_id"
                                                Display="False" SortExpression="fk_facility_id" UniqueName="fk_facility_id">
                                            </telerik:GridBoundColumn>
                                                                           
                                                                                
                                           <telerik:GridBoundColumn DataField="file_name" HeaderText="<%$Resources:Resource, Uploaded_File_Name%>"
                                                AllowFiltering="true" SortExpression="file_name" UniqueName="file_name">
                                                <ItemStyle Width="25%" CssClass="itemstyle" Wrap="false" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="filesize" FilterListOptions="VaryByDataTypeAllowCustom"
                                                HeaderText="<%$Resources:Resource, File_Size%>" AllowFiltering="true" SortExpression="filesize"
                                                UniqueName="filesize">
                                                <ItemStyle CssClass="itemstyle" HorizontalAlign="Left" Wrap="false" Width="12%" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Uploaded_By" HeaderText="<%$Resources:Resource, Uploaded_By%>"
                                                AllowFiltering="true" SortExpression="Uploaded_By" UniqueName="Uploaded_By">
                                                <ItemStyle CssClass="itemstyle" HorizontalAlign="Left" Wrap="false" Width="20%" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="created_on" FilterListOptions="VaryByDataTypeAllowCustom"
                                                HeaderText="<%$Resources:Resource, Uploaded_On%>" AllowFiltering="true" SortExpression="uploadedon"
                                                UniqueName="uploadedon">
                                                <ItemStyle CssClass="itemstyle" HorizontalAlign="Left" Wrap="false" Width="15%" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                           
                                             <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="<%$Resources:Resource, View%>" UniqueName="bim">
                                              <ItemStyle Width="8%" HorizontalAlign="Center" Wrap="false" />
                                                          <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btn_bim" runat="server" ImageUrl="~/App/Images/icon_BIMview_sm.png"
                                                        AlternateText="<%$Resources:Resource, View%>" />
                                                 
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                             <telerik:GridTemplateColumn UniqueName="Show_Log" HeaderText="Show Log Change" ItemStyle-HorizontalAlign="Center" Visible="false">
                                                <ItemStyle CssClass="column" HorizontalAlign="Center" Wrap="false" />
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imgbtnshowlog" ImageUrl="~/App/Images/log_file_icon.jpg" AlternateText="<%Resources:Resource, Show_change_log %>"
                                                        runat="server" CommandName="ShowLog" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                              <telerik:GridTemplateColumn UniqueName="download" HeaderText="Download" ItemStyle-HorizontalAlign="Center">
                                           <ItemStyle Width="8%" HorizontalAlign="Center" Wrap="false" />
                                                          <HeaderStyle HorizontalAlign="Center" />
                                               <ItemTemplate>
                                                    <asp:ImageButton ID="imgbtnsave" ImageUrl="~/App/Images/save.png" AlternateText="<%Resources:Resource,Download %>"
                                                        runat="server" CommandName="Download"  />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                           

                                    </Columns>
                                   
                                    </MasterTableView>
                                      <FilterMenu EnableTheming="True">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </FilterMenu>
                                    <FilterItemStyle VerticalAlign="Top" Wrap="False" />
                                      </telerik:RadGrid>
    </td>
     <asp:HiddenField ID="hf_size" runat="server" />
    </tr>
    </table>
      <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskConflicts" runat="server" Skin="Default" DecoratedControls="Buttons" />
     
    </form>  

</body>
 
</html>