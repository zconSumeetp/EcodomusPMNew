<%@ Page Title="" Language="C#"  AutoEventWireup="true"  CodeFile="FacilityProfileNew1.aspx.cs" Inherits="App_Reports_FacilityProfileNew1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<head>
<title>EcoDomus PM : Facility Profile </title>
 <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
 <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
<%--<script language="javascript" type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false" ></script>--%>
    <script src="../../App_Themes/EcoDomus/Googlemaps.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">

    function close_Window() {
        window.close();
        return false;
    }

    function NavigateToFacilityPM() {

        top.location.href = "FacilityPM.aspx";


    }



    function deleteDocument() {
        var flag;
        flag = confirm("Are you sure you want to delete this Document?");
        return flag;
    }

    function GoToFacilityProfile() {

        var url = "../Locations/FacilityMenu.aspx?FacilityId=" + document.getElementById("hfFacility_id").value;
        top.location.href = url;

    }

     var geocoder;
    
    function GetLatLngFacility() {

        geocoder = new google.maps.Geocoder();
        var strAddress1 = document.getElementById("txtAddress1").value;
        var strAddress2 = document.getElementById("txtAddress2").value;
        var strZipPostal = document.getElementById("txtZipPostal").value;
        if ((strAddress1 == "") | (strAddress2 == "") | (strZipPostal == "") | (strAddress1 == "N/A") | (strAddress2 == "N/A") | (strZipPostal == "N/A")) {
            alert("Address 1 , Address 2 and Zip Postal code are compulsary fields to get location. Please enter city name in Address 1 and city state in Address 2.");
            return false;
        }
        else {

                var strCompleteAddress = strAddress1 + ',' + strAddress2 + ',' + strZipPostal + ', USA';

                geocoder.geocode(
                                  { 'address': strCompleteAddress }, 
                                  function (results, status)
                                  {
                                    if (status == google.maps.GeocoderStatus.OK) 
                                    {
                                        getLocation(results);
                                        // document.getElementById('ctl00_ContentPlaceHolder1_hfFacilityLatitude').value = results[0].geometry.location.lat();
                                        // document.getElementById('ctl00_ContentPlaceHolder1_hfFacilityLongitude').value = results[0].geometry.location.lng();

                                    }
                                  }
                             )
         }
    }

    function getLocation(results) 
    {
                     
        document.getElementById('hfFacilityLatitude').value = results[0].geometry.location.lat();
        document.getElementById('hfFacilityLongitude').value = results[0].geometry.location.lng();


        document.getElementById('txtLatitude').value = results[0].geometry.location.lat();
        // document.getElementById('hfFacilityLatitude').value;
        //results[0].geometry.location.lat();
        document.getElementById('txtLongitude').value = results[0].geometry.location.lng();
        //document.getElementById('hfFacilityLongitude').value;
                         //results[0].geometry.location.lng();
                         
   }
//                     function ClearLatLngTexts() {
//                     debugger
//                         document.getElementById('txtLatitude').value = "";
//                         document.getElementById('txtLongitude').value = "";
//                     }

   

</script>
    <style type="text/css">
        .style1
        {
            width: 19%;
        }
    </style>
</head>

<body style="background: white; padding: 0px; margin: 0 0 0 0;">
    <form id="form1" runat="server" style="margin: 0 0 0 0;">
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    
    <div id="Profile" style="margin-left:0px;">
       <table id="facProfile" width="70%" style="vertical-align: top; margin-left:0px; margin-top:10px; border-collapse: collapse; "
           cellpadding="0" cellspacing="0" border="0">
            <%--<caption>
                 <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Facility_Profile%>"></asp:Label>
            </caption>--%> 
            <tr style="height: 25px;">
                <td align="left">
                   <b><asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, Name%>"></asp:Label> :</b> 
                </td>
                <td  style="text-align: left;width:30%;">
                    <asp:TextBox ID="txtfacilityname" TabIndex="1" runat="server" CssClass="SmallTextBox"></asp:TextBox>
                    <asp:Label ID="lblfacilityname" Visible="False" runat="server" CssClass="linkText"></asp:Label>
                    <asp:RequiredFieldValidator  ID="rf_validatorfacilityname" runat="server" ControlToValidate="txtfacilityname" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
         ValidationGroup="rf_validationgroup" SetFocusOnError="true"> 
        </asp:RequiredFieldValidator>
                </td>
                  <td align="left">
                   <b><asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, Site_Name%>"></asp:Label> :</b>
                </td>
                <td  style="text-align: left;width:30%;">
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="SmallTextBox" TabIndex="7"></asp:TextBox>
                    <asp:Label ID="lblDescription" runat="server" Visible="false" CssClass="linkText"></asp:Label>
                </td>
                 <%--<td align="left">
                   <b><asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, Category%>"></asp:Label> :</b>
                </td>
                <td  style="text-align: left;width:30%;">
                    <asp:Label ID="lblcategories" runat="server" CssClass="linkText"></asp:Label>
               <asp:LinkButton ID="lnkCategories" runat="server" Text="Select"  OnClientClick="javascript:return omniclass_popup();" TabIndex="7"></asp:LinkButton>
                </td>--%>
               
            </tr>
            <tr style="height: 25px;">
            <td align="left">
                   <b><asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, Category%>"></asp:Label> :</b>
                </td>
                <td  style="text-align: left;width:30%;">
                    <asp:Label ID="lblcategories" runat="server" CssClass="linkText"></asp:Label>
               <asp:LinkButton ID="lnkCategories" runat="server" Text="Select"  OnClientClick="javascript:return omniclass_popup();" TabIndex="2"></asp:LinkButton>
                </td>
                 
                <td align="left">
                    <b><asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource, Description%>"></asp:Label>:</b>
                </td>

                <td  style="text-align: left;width:30%;">
                     <asp:TextBox ID="txtSiteName" runat="server" CssClass="SmallTextBox" TabIndex="8"></asp:TextBox>
                    <asp:Label ID="lblsitename" runat="server" CssClass="linkText" Visible="False"></asp:Label>
                </td>
                  
               
            </tr>
            <%--<tr style="height: 25px;">
                  <td align="left">
                    <b><asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource, Ext_System_Site%>"></asp:Label>:</b>
                </td>
               <td  style="text-align: left;width:30%;">
                    <asp:TextBox ID="txtExtSysSite" runat="server" CssClass="SmallTextBox" TabIndex="3"></asp:TextBox>
                    <asp:Label ID="lblExtSysSite" Visible="false" runat="server" CssClass="linkText"></asp:Label>
                </td>
                 <td align="left">
                    <b><asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource, Ext_System_Facility%>"></asp:Label>:</b>
                </td>
                 <td  style="text-align: left;width:30%;">
                    <asp:TextBox ID="txtExtSysFacility" runat="server" CssClass="SmallTextBox" TabIndex="9"></asp:TextBox>
                    <asp:Label ID="lblExtSysFacility" runat="server" Visible="false" CssClass="linkText"></asp:Label>
                </td>
            </tr>--%>
               <tr style="height: 25px;">
               <td align="left">
                   <b><asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource, Address1%>"></asp:Label>:</b>
               </td>
           <td  style="text-align: left;width:30%;">
                    <asp:TextBox ID="txtAddress1" runat="server" CssClass="SmallTextBox" TabIndex="3"></asp:TextBox>
                    <asp:Label ID="lblAddress1" Visible="false" runat="server" CssClass="linkText"></asp:Label>
                </td>
                  <td align="left">
                   <b><asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource,  Address2%>"></asp:Label>:</b>
                </td>
              <td  style="text-align: left;width:30%;">
                    <asp:TextBox ID="txtAddress2" runat="server" CssClass="SmallTextBox" TabIndex="9"></asp:TextBox>
                    <asp:Label ID="lblAddress2" runat="server" Visible="false" CssClass="linkText"></asp:Label>
                </td>
            </tr>
              <tr style="height: 25px;">
                <td align="left">
                    <b><asp:Label ID="Label10" runat="server" Text="<%$Resources:Resource,  Zip_Postal_Code%>"></asp:Label>:</b>
                </td>
           <td  style="text-align: left;width:30%;">
                    <asp:TextBox ID="txtZipPostal" runat="server" CssClass="SmallTextBox" TabIndex="4"></asp:TextBox>
                    <asp:Label ID="lblZipPostal" Visible="false" runat="server" CssClass="linkText"></asp:Label>
                </td>
                <td align="left">
                    <b><asp:Label ID="Label12" runat="server" Text="<%$Resources:Resource,  Longitude%>"></asp:Label>:</b>
                </td>
           
            <td  style="text-align: left;width:30%;">
                    <asp:TextBox ID="txtLongitude" runat="server" CssClass="SmallTextBox" TabIndex="10"></asp:TextBox>
                    <asp:Label ID="lblLongitude" runat="server" Visible="false" CssClass="linkText"></asp:Label>
                </td>
             
            </tr>
              <tr style="height: 25px;">
                <td align="left">
                    <b><asp:Label ID="Label11" runat="server" Text="<%$Resources:Resource,  Latitude%>"></asp:Label>:</b>
                </td>
           <td  style="text-align: left;width:30%;">
                    <asp:TextBox ID="txtLatitude" runat="server" CssClass="SmallTextBox" TabIndex="5"></asp:TextBox>
                    <asp:Label ID="lblLatitude" Visible="false" runat="server" CssClass="linkText"></asp:Label>
                </td>
                 <td align="left">
               <b><asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,  Attribute_Template%>"></asp:Label>:</b>               
               </td>
                <td>
               <telerik:RadComboBox ID="cmb_template" runat="server" TabIndex="11"></telerik:RadComboBox>
               <asp:Label ID="lbl_attribute_template" runat="server" Visible="false"></asp:Label>
               </td>
              
            </tr>

        <%--</table>
        <table border="0"  style="vertical-align: top; width: 100%; table-layout:auto;margin-left:15px;"  >--%>
            <tr style="height: 20px;">
                <%--<td align="left"  valign="top"  >
                    <b><asp:Label ID="Label13" runat="server" Text="<%$Resources:Resource,  Document%>"></asp:Label>:</b>
                </td>--%>
              <%--<td  width="30%"  >
                    <telerik:RadGrid width="90%" ID="rgDocuments"  runat="server" BorderWidth="1px" CellPadding="0" 
                     Skin="Hay"    AllowPaging="true" PageSize="5" AutoGenerateColumns="False" AllowSorting="True"
                        PagerStyle-AlwaysVisible="true" OnItemCommand="rgDocument_ItemCommand" OnPageIndexChanged="rgDocuments_PageIndexChanged" OnPageSizeChanged="rgDocuments_PageSizeChanged" OnSortCommand="rgDocuments_SortCommand">

                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="70%" />
                        <MasterTableView DataKeyNames="document_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="document_id" HeaderText="document_id" UniqueName="task_id"
                                    Visible="False">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="document_name" UniqueName="document_name"
                                    HeaderText="<%$Resources:Resource,  Document_Name%>" SortExpression="document_name">
                                    <ItemStyle CssClass="column" Width="100px" />
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hlnkDocName" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"file_path")%>'
                                            Text='<%# DataBinder.Eval(Container.DataItem,"document_name")%>' runat="server"
                                            Target="_blank"></asp:HyperLink>
                                       
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="document_id" UniqueName="document_id" Visible="false">
                                    <ItemStyle CssClass="column"/>
                                   <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" document_id='<%# DataBinder.Eval(Container.DataItem,"document_id")%>'
                                            OnClientClick="javascript:return deleteProduct(this);" CommandName="deleteProduct"
                                            ImageUrl="~/App/Images/Delete.gif" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>--%>

                        
                <td valign="top" >
                    <b><asp:Label ID="Label14" runat="server" Text="<%$Resources:Resource, Location_Hierarchy%>"></asp:Label>:</b>
                </td>
              <td valign="top"  >

              
                <asp:Table Width="200px" runat="server" ID="tblHierarchy" BorderColor="White">                      
                </asp:Table>
               
                <asp:LinkButton Visible="false" ID="lnkEditLocation" runat="server" Text="<%$Resources:Resource, Edit_Location_Hierarchy%>"  OnClientClick="javascript:return hierarchy_popup();" TabIndex="6" ></asp:LinkButton>
            

                    
                </td>

                           

            </tr>
           <tr style="height: 20px;">
              
              
                <td  colspan="4">
               
                
                    <asp:Button ID="btnsave" runat="server" Text="<%$Resources:Resource, Save%>" Width="80px" OnClick="btnsave_Click" ValidationGroup="rf_validationgroup" TabIndex="12" />
                                     

                    <asp:Button ID="btnEdit" runat="server" Text="<%$Resources:Resource, Edit%>" Width="80px" OnClick="btnedit_Click" TabIndex="13"/>&nbsp;&nbsp;
                    &nbsp;&nbsp;  
                    <asp:Button ID="btnDelete" runat="server" Text="<%$Resources:Resource, Delete%>"
                                skin="Hay" Width="80" OnClick="btnDelete_Click" />                    

                    <%-- <asp:Button ID="btnAddDocument" runat="server" Text="<%$Resources:Resource, Add_Document%>" Width="100px"  OnClientClick="javascript:return load_popup(this);" pk_document_id='00000000-0000-0000-0000-000000000000'
                       Visible="false" />&nbsp;&nbsp;--%>  
                       <asp:Button ID="btnCancel" runat="server" Visible="false" Text="<%$Resources:Resource, Cancel%>" Width="80px"
                        CausesValidation="false" OnClick="btnCancel_Click" TabIndex="14"/>&nbsp;&nbsp;    
                        <asp:Button ID="btnclose" runat="server" Text="<%$Resources:Resource, Close%>" Visible="false" Width="80px"
                        OnClientClick="javascript:close_Window();" CausesValidation="false" />

                        <%--<asp:Button ID="btnGetLatitudeLongitude" runat="server" Visible="false" Text="Get Location" Width="100px"
                        CausesValidation="false" OnClientClick="javascript:return GetLatLngFacility();" />--%>
                        <input type="button" runat="server" id="btnGetLatitudeLongitude" value="Get Location" style="width:100px;" onclick="javascript:return GetLatLngFacility();" tabindex="15" />
              </td>
        
       

            </tr>
           
            <tr>
               <th class="style1" >
                    
                </th>
              <td  >
                  <asp:Label ID="lblMsg" runat="server" ForeColor="red"></asp:Label>
                </td>
                  <th >
                    
                </th>
              <td >

              </td>
          
            </tr>
        </table>

      <%--  <table border="0" style="margin: 20px 50px 50px 30px; width: 100%">
            <tr style="height: 20px;">
                <th class="style1">
                    Location Hierarchy:
                </th>
                <td style="text-align: left; width: 30%;" colspan="2">
                    <asp:Table runat="server" ID="aspTblHierarchy" BorderColor="#000066" BorderStyle="Dotted">
                        <asp:TableRow ID="level0" runat="server" Visible="false" >
                        
                            <asp:TableCell ID="tc_level0_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level0_db_table_name" runat="server">
                            <telerik:RadComboBox ID="rcblevel0" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level1" runat="server" Visible="false">
                        
                            <asp:TableCell ID="tc_level1_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level1_db_table_name" runat="server">
                            <telerik:RadComboBox ID="rcblevel1" runat="server"></telerik:RadComboBox>
                            
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level2" runat="server" Visible="false">
                        
                            <asp:TableCell ID="tc_level2_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level2_db_table_name" runat="server">
                            <telerik:RadComboBox ID="rcblevel2" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level3" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level3_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level3_db_table_name" runat="server">
                            <telerik:RadComboBox ID="rcblevel3" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level4" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level4_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level4_db_table_name" runat="server">
                            <telerik:RadComboBox ID="rcblevel4" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level5" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level5_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level5_db_table_name" runat="server">
                            <telerik:RadComboBox ID="rcblevel5" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level6" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level6_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level6_db_table_name" runat="server">
                            <telerik:RadComboBox ID="rcblevel6" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level7" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level7_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level7_db_table_name" runat="server">
                            <telerik:RadComboBox ID="rcblevel7" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level8" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level8_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level8_db_table_name" runat="server">
                            <telerik:RadComboBox ID="rcblevel8" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="level9" runat="server" Visible="false">
                            <asp:TableCell ID="tc_level9_hierarchy_name" runat="server"></asp:TableCell>
                            <asp:TableCell ID="tc_level9_db_table_name" runat="server">
                            <telerik:RadComboBox ID="rcblevel9" runat="server"></telerik:RadComboBox>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </td>
                <td style="text-align: left; width: 30%;">
                </td>
            </tr>
            <tr style="height: 20px;">
                <td style="text-align: left;" class="style1">
                    &nbsp;
                </td>
            </tr>
        
        </table>--%>

         <div id="divbtn" style="display: none;">
         <asp:HiddenField ID="hfFacility_id" runat="server" />
             <asp:HiddenField ID="hf_lblOmniClassid" runat="server" />
             <asp:HiddenField ID="hf_facility_name" runat="server" />
             <asp:HiddenField ID="hfFacilityLatitude" runat="server" />
             <asp:HiddenField ID="hfFacilityLongitude" runat="server" />
        <asp:Button ID="btn_refresh" runat="server" OnClick="btn_refresh_Click" Style="display: none;" />
    </div>
    </div>


        <telerik:RadWindowManager Visible="true" ID="rad_window" VisibleStatusbar="false"
        AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server"
        KeepInScreenBounds="true" >
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" Modal="true" 
                Animation="Slide" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="true"
                AutoSize="false"  Width="600" Height="400" VisibleStatusbar="false" Behaviors="Move, Resize"
                VisibleOnPageLoad="false" Skin="Forest">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    
    
 <telerik:RadCodeBlock ID="loadPopUp" runat="server">

     <script language="javascript" type="text/javascript">

         function deleteProduct() {
             var flag;
             flag = confirm("Do you want to delete this document?");
             return flag;
         }

         function load_popup(reg) {
             var url = "../Locations/AddDocument.aspx?Item_type=Facility&fk_row_id=" + document.getElementById("hfFacility_id").value + "&Document_Id=" + reg.pk_document_id; ;
             manager = $find("<%= rad_window.ClientID %>");
             var windows = manager.get_windows();
             windows[0].show();
             windows[0].setUrl(url);
             return false;
         }


         function omniclass_popup() {
             var url = "../Locations/AssignOmniclass.aspx?Item_type=Facility&id=" + document.getElementById("hfFacility_id").value;
             manager = $find("<%= rad_window.ClientID %>");
             var windows = manager.get_windows();
             windows[0].show();
             windows[0].setUrl(url);
             return false;
         }

         function hierarchy_popup() {
             var url = "../Locations/SetLocationHierarchy.aspx?Item_type=Facility&id=" + document.getElementById("hfFacility_id").value;
             manager = $find("<%= rad_window.ClientID %>");
             var windows = manager.get_windows();
             windows[0].show();
             windows[0].setUrl(url);
             return false;
         }




         function regreshgrid() {
             document.getElementById("btn_refresh").click();
         }



         function load_omni_class(name, id) {

             document.getElementById("hf_lblOmniClassid").value = id;
             var reg = new RegExp('&nbsp;', 'g');
             name = name.replace(reg, ' ');
             document.getElementById("lblcategories").innerText = name;
         }
         

                  
     </script>
 </telerik:RadCodeBlock>

</form>

</body>



</html>
