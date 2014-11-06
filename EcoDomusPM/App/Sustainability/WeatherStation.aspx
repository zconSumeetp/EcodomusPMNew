<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true"
    CodeFile="WeatherStation.aspx.cs" Inherits="App_Sustainability_WeatherStation" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 
 <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">


     function delete_Weather() {
         var answer = confirm("Are you sure you want to delete this item?")
         if (answer)
             return true;
         else
             return false;
     }

     function Clear() {

         document.getElementById("<%=txtsearch.ClientID %>").value = "";
         return false;

     }

     function changeCaptiontext() {


         document.getElementById("<%=caption.ClientID %>").innerText = "Edit Weather Station";



     }


    </script>
    </telerik:RadCodeBlock>
   
  
         <div>
        
       <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        </telerik:RadAjaxManager>
          <telerik:RadAjaxManagerProxy ID="weatherstation" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnaddWeatherStation">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="tblbasserver"  />
                        <telerik:AjaxUpdatedControl ControlID="btnaddWeatherStation" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnsave">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnaddWeatherStation" LoadingPanelID="loadingPanel2" />
                        <telerik:AjaxUpdatedControl ControlID="rgweatherstation" LoadingPanelID="loadingPanel2" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btncancel">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnaddWeatherStation" LoadingPanelID="loadingPanel2" />
                        <telerik:AjaxUpdatedControl ControlID="rgweatherstation" LoadingPanelID="loadingPanel2" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rgweatherstation">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rgweatherstation" LoadingPanelID="loadingPanel2" />
                        <telerik:AjaxUpdatedControl ControlID="tblbasserver"  />
                        <telerik:AjaxUpdatedControl ControlID="btnaddWeatherStation" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="radbtnsearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rgweatherstation" LoadingPanelID="loadingPanel2" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManagerProxy>

           <telerik:RadAjaxLoadingPanel ID="loadingPanel2" runat="server" Height="75px" Width="75px" Skin="Forest">
          
        </telerik:RadAjaxLoadingPanel>
        
           </div>

         
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <div class="divMargin" style="padding-left: 120px" id="divmaincontent" runat="server">
        <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars,Select" />
         <asp:Panel ID ="panel1" runat="server" DefaultButton="radbtnsearch"> 
    
        <table width="100%">
            <caption align="top" id="head" runat="server">
                <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Weather_Station%>"></asp:Label>
            </caption>
            <tr>
                <td>
                    <asp:TextBox ID="txtsearch" Width="150px" runat="server"></asp:TextBox>
                    <asp:Button ID="radbtnsearch" runat="server" Text="<%$Resources:Resource, Search%>" OnClick="radbtnsearch_click"
                        Width="70px" />
                    <asp:Button ID="btnclear" runat="server" Text="<%$Resources:Resource, Clear%>" OnClientClick="javascript:return Clear();"
                        Width="70px" />
                </td>
            </tr>
            <tr style="height: 10px;">
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <span id="Span12" style="font-weight: bold"></span>
                    <telerik:RadGrid ID="rgweatherstation" runat="server" AllowPaging="true" Width="85%"
                        BorderWidth="1px" Skin="Hay" OnItemCommand="rgbasserver_itemcommad" OnSortCommand="rgbasserver_sortcommand"
                        CellPadding="0" AutoGenerateColumns="False" AllowSorting="true">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="50%" />
                        <MasterTableView DataKeyNames="pk_bas_weather_station_id">
                            <Columns>
                                <telerik:GridTemplateColumn UniqueName="navigate" DataField="data_provider_name" 
                                    HeaderText="<%$Resources:Resource, Data_Provider%>"> 
                                    <ItemStyle CssClass="column" Width="40%" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" CommandName="navigate" runat="server" Text='<%#Eval("data_provider_name") %>'
                                            OnClientClick="javascript:return changeCaptiontext();"></asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, URL%>" DataField="data_provider_url" SortExpression="data_provider_url">
                                    <ItemStyle CssClass="column" Width="30%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, Station_Name%>" DataField="station_name" SortExpression="station_name">
                                    <ItemStyle CssClass="column" Width="30%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Station Id" DataField="station_id" SortExpression="station_id">
                                    <ItemStyle CssClass="column" Width="40%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, Altitude%>" DataField="altitude_msl" SortExpression="altitude_msl">
                                    <ItemStyle CssClass="column" Width="30%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, Latitude%>" DataField="latitude" SortExpression="latitude">
                                    <ItemStyle CssClass="column" Width="30%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, Longitude%>" DataField="longitude" SortExpression="longitude">
                                    <ItemStyle CssClass="column" Width="30%" />
                                </telerik:GridBoundColumn>
                                <telerik:GridCheckBoxColumn HeaderText="<%$Resources:Resource, Enabled%>" DataField="enabled" SortExpression="enabled">
                                    <ItemStyle CssClass="column" Width="30%" />
                                </telerik:GridCheckBoxColumn>
                                  
                                <telerik:GridTemplateColumn UniqueName="imgbtnDelete_">
                                    <ItemStyle CssClass="column" Width="30%" />
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="DeleteWeather"
                                            ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return delete_Weather();" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
            <tr style="height: 10px;">
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnaddWeatherStation" runat="server" Text="<%$Resources:Resource, Add_Weather_Station%>" OnClick="btnaddWeatherStation_click" />
                </td>
            </tr>
            <tr style="height: 10px;">
                <td>
                </td>
            </tr>
        </table>

     
        <table id="tblbasserver" style="display: none;" runat="server" cellspacing="10">
            <tr>
                <td>
                    <caption id="caption" runat="server">
                        <asp:Label ID="Label111" runat="server" Text="<%$Resources:Resource, Add_Weather_Station%>"></asp:Label>:
                    </caption>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblname" runat="server" Text="<%$Resources:Resource, Data_Provider%>" CssClass="LabelText"></asp:Label>:
                </td>
                <td>
                    <asp:TextBox ID="txtdataprovidername" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="btnsavegroup"
                        runat="server" Display="Dynamic" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtdataprovidername"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblurl" runat="server" Text="<%$Resources:Resource, URL%>" CssClass="LabelText"></asp:Label>:
                </td>
                <td>
                    <asp:TextBox ID="txturl" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="btnsavegroup"
                        runat="server" Display="Dynamic" ErrorMessage="*" ForeColor="Red" ControlToValidate="txturl"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblprotocol" runat="server" Text="<%$Resources:Resource, Station_Name%>" CssClass="LabelText"></asp:Label>:
                </td>
                <td>
                    <asp:TextBox ID="txtstationname" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="btnsavegroup"
                        runat="server" Display="Dynamic" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtstationname"></asp:RequiredFieldValidator>
                </td>
            </tr>
             <tr>
                <td>
                    <asp:Label ID="lblstationid" runat="server" Text="Station Id:" CssClass="LabelText"></asp:Label>:
                </td>
                <td>
                    <asp:TextBox ID="txtstationid" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="btnsavegroup"
                        runat="server" Display="Dynamic" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtstationid"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblusername" runat="server" Text="<%$Resources:Resource, Altitude%>" CssClass="LabelText"></asp:Label>:
                    
                </td>
                <td>
                    <asp:TextBox ID="txtaltitude" Width="200px" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationExpression="^-{0,1}\d*\.{0,1}\d+$" ControlToValidate="txtaltitude" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblpassword" runat="server" Text="<%$Resources:Resource, Latitude%>" CssClass="LabelText"></asp:Label>:
                </td>
                <td>
                    <asp:TextBox ID="txtlatitude" Width="200px"  runat="server"></asp:TextBox>
                    
                    
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LabelLogitude" runat="server" Text="<%$Resources:Resource, Longitude%>" CssClass="LabelText"></asp:Label>:
                </td>
                <td>
                    <asp:TextBox ID="txtlongitude" Width="200px"  runat="server"></asp:TextBox>
                      
                </td>
            </tr>

             <tr>
                <td>
                    <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, Enabled%>" CssClass="LabelText"></asp:Label>:
                </td>
                <td>
                    <asp:CheckBox ID="chkbasenabled" runat="server" />
                      
                </td>
            </tr>
            <tr id="trsavecancel" runat="server">
                <td>
                    <asp:Button ID="btnsave" OnClick="btnsave_Click" runat="server" Text="<%$Resources:Resource, Save%>" Width="107px"
                        ValidationGroup="btnsavegroup" />
                </td>
                <td>
                    <asp:Button ID="btncancel" OnClick="btncancel_Click" runat="server" Text="<%$Resources:Resource, Cancel%>"
                        Width="113px" />
                </td>
            </tr>
   
        </table>
     </asp:Panel>
    </div>
   
</asp:Content>
