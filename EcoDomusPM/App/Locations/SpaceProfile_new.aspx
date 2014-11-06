<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SpaceProfile_new.aspx.cs" Inherits="SpaceProfile_new" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%--<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">--%>
<html>
<head>
<%--<title>
    EcoDomus PM : Space Profile 
</title>--%>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
  
     
 <telerik:RadCodeBlock ID="radcodeblock1" runat="server">

        <script type="text/javascript" language="javascript">

            function openAddDocument() {
                var url = "AddDocument.aspx?flag=S&id=" + document.getElementById("hflocationid").value;
                window.open(url, "Window1", "menubar=no,width=880,height=500,toolbar=no,scrollbars=no");

                return false;
            }

            function openpopupaddomniclasslinkup() {
                var url = "AssignOmniclass.aspx?Item_type=space";
                window.open(url, "Window1", "menubar=no,width=500,height=950,right=50,toolbar=no,scrollbars=yes");
                return false;
            }
            function NavigateToFindLocation() {

                top.location.href = "../Locations/FindLocation.aspx";
            }

            function navigate_space() {
                var url = "../locations/facilitymenu.aspx?pagevalue=Space Profile&id=" + document.getElementById("hflocationid").value + "&profileflag=old";
                parent.location.href(url);
            }

            function validate() {
                alert("Space name already exists");
                return false;
            }

            function NavigateToFindLocationPM() {
                top.location.href = "../Locations/SpacePM.aspx";
            }
            function chkdelete() {
                var flag;
                flag = confirm("Do you want to delete this Space?");
                return flag;

            }
            function LogoutNavigation() {

                var query = parent.location.href;
                top.location.href(query);

            }

            function closewindow() {
                window.close();
            }
            </script>
            </telerik:RadCodeBlock>  
            <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
</head>
<body style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG');  background-color:white;padding: 0px;">
<form id="form1" runat="server" style="margin: 0 0 0 0;padding-left:0px;"> 
    <asp:ScriptManager ID="Scriptmanager1" runat="server">
    </asp:ScriptManager>
<%--<asp:updatepanel ID="updatepanel1" runat="server">--%>
       <%-- <ContentTemplate>--%>

      
     <asp:HiddenField ID="hflocationid" runat="server" />

<div id="divProfilePage" runat="server" style="width:100%;padding-left:2px;padding-top:2px;" align="left">

  <table>
   <tr>
   <td style="width:100%;padding-left:20px; "><table align="left"    >
   <tr>
   <th width="100"  align="left">
            <asp:Label ID="Label2" runat="server"  Text="<%$Resources:Resource, Description%>"  ></asp:Label>:
        </th>
        <td>
        <asp:TextBox ID="txtdescription" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
         <asp:Label runat="server" ID="lbldescription" CssClass="linkText" ></asp:Label> 
        </td>
        <td style ="width:10px;"></td>
        <th width="100" align="left">
            <asp:Label ID="Label8" runat="server"  Text="<%$Resources:Resource, Barcode%>" ></asp:Label>:
        </th>
        <td>
        <asp:TextBox ID="txtBarcode" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
         <asp:Label runat="server" ID="lblBarcode" CssClass="linkText" ></asp:Label> 
        </td>
   </tr>
   <tr > <td style="height:08px"></td></tr>

   

   <tr>
   <th width="100" align="left">
            <asp:Label ID="Label3" runat="server"  Text="<%$Resources:Resource, Facility%>"  ></asp:Label>:
        </th>
        <td>
        <telerik:RadComboBox ID="cmbfacility" runat="server"  height="100px" width="175px" 
                AutoPostBack="true" onselectedindexchanged="cmbfacility_SelectedIndexChanged" ></telerik:RadComboBox>
         <asp:Label runat="server" ID="lblfacility"  CssClass="linkText" ></asp:Label> 
         <asp:RequiredFieldValidator  ID="rf_validatorfacility" runat="server" ControlToValidate="cmbfacility" InitialValue="--Select--" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
         ValidationGroup="rf_validationgroup" SetFocusOnError="true"> 
        </asp:RequiredFieldValidator>
        </td>
    
      <td style ="width:10px;"></td>
          
           <th width="100" align="left" >
          <asp:Label ID="Label5" runat="server"  Text="<%$Resources:Resource,  Net_Area%>" ></asp:Label>:
        </th>
        <td>
        <asp:TextBox ID="txt_area" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
        <asp:Label runat="server" ID="lblArea"  CssClass="linkText" ></asp:Label>         
        </td>
           
        </tr>
         <tr>
           <td style="height:08px"></td>
          </tr>
<tr>
<th width="100" align="left">
            <asp:Label ID="Label6" runat="server"  Text="<%$Resources:Resource, Floor_Name%>"  ></asp:Label>:
        </th>
        <td>
        <telerik:RadComboBox ID="cmbfloorname" runat="server"  height="100px" width="175px"></telerik:RadComboBox>
        <asp:RequiredFieldValidator  ID="rf_validatorfloor" runat="server" ControlToValidate="cmbfloorname" InitialValue="---Select---" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
         ValidationGroup="rf_validationgroup" SetFocusOnError="true"> 
        </asp:RequiredFieldValidator>
        <asp:Label runat="server" ID="lblfloorname"  CssClass="linkText" ></asp:Label> 
        </td>

         <td style ="width:10px;"></td>
        <th width="100" align="left" >
          <asp:Label ID="Label10" runat="server"  Text="<%$Resources:Resource,  Gross_Area%>"  ></asp:Label>:
        </th>
        <td>
        <asp:TextBox ID="txt_Grossarea" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
        <asp:Label runat="server" ID="lblGrossArea"  CssClass="linkText" ></asp:Label>         
        </td>

           
</tr>
       

         <tr>
          <td style="height:08px"></td>
          </tr>
          <tr>
          <th width="100" align="left">
            <asp:Label ID="Label4" runat="server"  Text="<%$Resources:Resource,  Category%>"  ></asp:Label>:
        </th>
        <td>
        <%--<telerik:RadComboBox ID="cmbcategory" runat="server"  height="100px" width="175px"></telerik:RadComboBox>--%>
           <asp:Label runat="server" ID="lblcategory" CssClass="linkText"  ></asp:Label> 

           <asp:LinkButton ID="lnkbtncategory" runat="server" text="select" CssClass="linkText" OnClientClick="javascript:return omniclass_popup();" ForeColor="Red"></asp:LinkButton>
          
        </td>
         <td style ="width:50px;"></td>
        
        <th width="100" align="left" >
          <asp:Label ID="Label9" runat="server"  Text="<%$Resources:Resource,  Usable_Height%>"  ></asp:Label>:
        </th>
        <td>
        <asp:TextBox ID="txtusableheight" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
        <asp:Label runat="server" ID="lblusableheight"  CssClass="linkText" ></asp:Label>         
        </td>
          </tr>
           <tr>
           <td style="height:08px"></td>
          </tr>
          <tr>
           <th width="100" align="left" >
            <asp:Label ID="lblRoomtagheading" runat="server"  Text="<%$Resources:Resource, Room_Tag%>"  ></asp:Label>:
        </th>
        <td>
        <asp:TextBox ID="txtRoomTag" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
        <asp:Label runat="server" ID="lblroomtag"  CssClass="linkText" ></asp:Label> 
        </td> 
          </tr>
         <%-- <tr>
          
<td width="100" align="left" >
            <asp:Label ID="lblRoomtagheading1" runat="server"  Text="<%$Resources:Resource, Room_Tag%>" CssClass="Label" ></asp:Label> :
        </td>
        <td>
        <asp:TextBox ID="txtRoomTag1" runat="server"  CssClass="SmallTextBox"></asp:TextBox>
        <asp:Label runat="server" ID="lblroomtag1"  CssClass="linkText" ></asp:Label> 
        

        </td> 

<td width="100px"></td>
          
          </tr>--%>



        <tr>
       <%-- <td width="100" align="left">
            <asp:Label runat="server" Text="<%$Resources:Resource, Document%>"  CssClass="Label" ></asp:Label> :
        </td>--%>
       <%-- <td width="40%">
       <telerik:RadGrid ID="rgDocuments" Width="70%" runat="server" BorderWidth="1px" CellPadding="0"
                            AllowPaging="true" PageSize="10" 
                            AutoGenerateColumns="False" AllowSorting="True"
                            PagerStyle-AlwaysVisible="false" Skin="Hay"  OnItemCommand="rgDocument_ItemCommand" OnSortCommand="btn_refresh_Click" >
                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="100%" />
                            <MasterTableView DataKeyNames="document_id">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="document_id" HeaderText="document_id" UniqueName="task_id"
                                        Visible="False">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="document_name" UniqueName="document_name"
                                        HeaderText="<%$Resources:Resource,  Document_Name%>" SortExpression="document_name" >
                                        <ItemStyle CssClass="column" />
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hlnkDocName" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"file_path")%>'
                                                Text='<%# DataBinder.Eval(Container.DataItem,"document_name")%>' runat="server"
                                                Target="_blank"></asp:HyperLink>
                                            <%--<asp:Label ID="lblDocName" Text='<%# DataBinder.Eval(Container.DataItem,"document_name")%>'
                                                CssClass="linkText" runat="server"></asp:Label>--%>
                                   <%--     </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="document_id" UniqueName="document_id" Visible="true">
                                        <ItemStyle CssClass="column" Width="5%" />
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" alt="Delete" CommandName="deleteDocument"
                                                ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return deleteSpaceDocument();" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
        </td>--%>
         <td width="100px"></td>
      
   </tr>
    <tr > <td style="height:08px"></td></tr>

    <tr>
        <td colspan="5" align="left" >
            <telerik:RadButton ID="btnsave" runat="server" Text="<%$Resources:Resource,  Save%>" skin="Default" Width="90px"
                onclick="btnsave_Click" ValidationGroup="rf_validationgroup"  />
                            
             <%--<asp:Button  ID="btnadddocument" runat="server" Text="<%$Resources:Resource,  Add_Document%>" pk_document_id='00000000-0000-0000-0000-000000000000'
                OnClientClick="javascript:return load_popup(this);" 
                  />--%>
             <%--<telerik:RadButton ID="btndelete" runat="server" Text="<%$Resources:Resource,  Delete%>" skin="Hay" Width="90px" 
                 OnClick="btnDelete_Click" OnClientClick="javascript:return chkdelete();" />--%>
                 <asp:Button ID="btndelete" runat="server" Text="<%$Resources:Resource,  Delete%>" skin="Default" Width="100" 
                 OnClick="btnDelete_Click" OnClientClick="javascript:return chkdelete();" />
              <asp:Button ID="btnclose" runat="server" Width="100" Text="<%$Resources:Resource, Close%>"  OnClientClick="Javascript:closewindow();" />
        </td>
   </tr>

   
</table></td>
   </tr>
  </table>
  
<div id="divbtn" style="display:none;"  >
         <asp:HiddenField ID="hfFacility_id" runat="server" />
             <asp:HiddenField ID="hf_lblOmniClassid" runat="server" />
             <asp:HiddenField  ID="hf_floor_id" runat="server"/>
               <asp:HiddenField  ID="hfpopupflag" runat="server" ClientIDMode="Static"/>
       <asp:Button ID="btn_refresh" runat="server" OnClick="btn_refresh_Click" Style="display: none;" />
    </div>
     
</div>

<telerik:RadWindowManager Visible="true" ID="rad_window" VisibleStatusbar="false" runat="server">
         <Windows>
            <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" 
                Animation="Slide" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="true"
                AutoSize="true"  Width="700" Height="500" VisibleStatusbar="false"
                VisibleOnPageLoad="false" Skin="">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

 <telerik:RadCodeBlock ID="loadPopUp" runat="server">

     <script language="javascript" type="text/javascript">

         function deleteSpaceDocument() {
             var flag;
             flag = confirm("Do you want to delete this document?");
             return flag;
         }

         function load_popup(reg) {
             var url = "../Locations/AddDocument.aspx?Item_type=Space&fk_row_id=" + document.getElementById("hflocationid").value + "&Document_Id=" + reg.pk_document_id;
             manager = $find("<%= rad_window.ClientID %>");
             var windows = manager.get_windows();
             windows[0].setUrl(url);
             windows[0].show();
             //windows[0].set_modal(false);
             return false;
         }


         function omniclass_popup() {

             var url = "../Locations/AssignOmniclass.aspx?Item_type=Space&id=" + document.getElementById("hflocationid").value;
             manager = $find("<%= rad_window.ClientID %>");
             var windows = manager.get_windows();
             windows[0].setUrl(url);
             windows[0].show();
             //windows[0].set_modal(false);
             return false;
         }

         function regreshgrid() {
             document.getElementById("btn_refresh").click();
         }

         

         function load_omni_class(name, id) {

             document.getElementById("hf_lblOmniClassid").value = id;
             var reg = new RegExp('&nbsp;', 'g');
             name = name.replace(reg, ' ');
             document.getElementById("lblcategory").innerText = name;
         }

         function navigate_space() {
             var url = "../locations/facilitymenu.aspx?pagevalue=Space Profile&id=" + document.getElementById("hflocationid").value + "&profileflag=old&floor_id=";
             parent.location.href(url);
         }
         //This function returns rad window instance to resize it popup
         function GetRadWindow() {
             var oWindow = null;
             if (window.radWindow) oWindow = window.radWindow;
             else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
             return oWindow;
         }

         function navigate_spacepopup() {
             window.document.clear();
             var wnd = GetRadWindow();
             if (wnd != null) {
                 var bounds = wnd.getWindowBounds();
                 var x = bounds.x;
                 var y = bounds.y;
                 //alert(x);
                 //alert(y);
                 //wnd.moveTo(x, 25);
                 //alert('window page' + document.body.scrollHeight);
                 wnd.set_height(document.body.scrollHeight + 150)
                // wnd.set_width(750)
                 // alert('window page' + document.body.offsetWidth);
                 wnd.set_width(document.body.scrollWidth + 100)
             }
             var url = "../locations/spaceprofile.aspx?pagevalue=Space Profile&id=" + document.getElementById("hflocationid").value + "&profileflag=old&popupflag=popup";
             window.location.href(url);
         }
     </script>
 </telerik:RadCodeBlock>

 
 <%--</ContentTemplate>--%>
<%--</asp:updatepanel>--%>
        </form> 
         </body> 
 </html>
<%-- </asp:Content> --%>