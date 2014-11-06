<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomusPM_Master.master"  AutoEventWireup="true"
    CodeFile="IssueProfile.aspx.cs" Inherits="App_Asset_AddIssue" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="../UserControls/UCComboAssignedTo.ascx" TagName="UCComboAssignedTo"
    TagPrefix="uc1" %>
<%@ Register Src="../UserControls/UCLocationProject.ascx" TagName="UCLocation" TagPrefix="uc2" %>

<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
    <script type="text/javascript" language="javascript">
    function setFocus() {
    if(document.getElementById("<%=txtName.ClientID %>")!=null)
        document.getElementById("<%=txtName.ClientID %>").focus();
    
    }
    window.onload = setFocus;

    //This function returns rad window instance to resize it popup
    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    }
    function resizePopup(str) {

        window.document.clear();
        var wnd = GetRadWindow();
        if (wnd != null) {
            var bounds = wnd.getWindowBounds();
            var x = bounds.x;
            var y = bounds.y;
            if (str == 'expand')
                wnd.set_height(document.body.scrollHeight + 60);
            else if (str == 'collaps')
                wnd.set_height(document.body.scrollHeight + 50);
            else if (str == 'datePopExpand') {
                if (stateTreeViewTest() != 'true')
                    wnd.set_height(document.body.scrollHeight + 100);
            }
            else if (str == 'datePopCollaps') {
                if (stateTreeViewTest() != 'true')
                    wnd.set_height(document.body.scrollHeight + 20);
            }
            else if (str == 'datePopExpand2') {
                if (stateTreeViewTest() != 'true')
                    wnd.set_height(document.body.scrollHeight + 160);
            }
            else if (str == 'datePopCollaps2') {
                if (stateTreeViewTest() != 'true')
                    wnd.set_height(document.body.scrollHeight - 60);
            }
            else if (str == 'parentWindow')
                wnd.set_width(document.body.scrollWidth - 100);
        }
    }

    var stateTreeView = 'false';
    function setSateteTreeView(str) {
        stateTreeView = str;
    }
    function stateTreeViewTest() {
        return stateTreeView;
    }
</script>
      <script type="text/javascript">

          function NavigateToIssue() {

              location.href = "../app/asset/issues.aspx";
          }


          function Openfacilitylist() {


              manager = $find("<%=rad_windowmgr.ClientID %>");
              var url;
              var url = "../Asset/issuefacilitylist.aspx?facilitystatus=" + document.getElementById("<%=hdnfacility.ClientID%>").value + "";

              if (manager != null) {
                  var windows = manager.get_windows();
                  var intWidth = document.body.clientWidth;
                  var intHeight = document.body.clientHeight;
                  windows[0]._left = parseInt(intWidth * (0.2));
                  windows[0]._width = parseInt(intWidth * 0.6);
                  windows[0]._height = parseInt(intHeight * 0.5);
                  var intHeight = document.body.clientHeight;



                  windows[0].setUrl(url);
                  windows[0].show();
                  windows[0].center();
              }
              return false;
          }

          function load_comp(name, id, type_name) {

              document.getElementById("<%=hf_lbl_comp_id.ClientID %>").value = id;
              var reg = new RegExp('&nbsp;', 'g');
              name = name.replace(reg, ' ');
              type_name = type_name.replace(reg, ' ');
              var reg1 = new RegExp('single', 'g')
              name = name.replace(reg1, "'");
              type_name = type_name.replace(reg1, "'");
              document.getElementById("<%=lbl_Comp_name.ClientID %>").innerText = name;
              document.getElementById("<%=lbl_type_name.ClientID %>").innerText = type_name;
          }

          function delete_() {

              var flag;
              flag = confirm("Are you sure you want to delete?");
              return flag;
          }
          function ProjectValidation() {

              alert('Please select Project');
              window.location = '../Settings/Project.aspx';
              return false;

          }

          function chklbl() 
          {
              
              //alert(document.getElementById("<%=btnSave.ClientID%>").value);
              if (document.getElementById("<%=btnSave.ClientID%>").value == "Save") 
              {
                  var combobox = $find("<%=rcb_Status.ClientID %>");
                 // if (combobox != null)
                      var text = combobox.get_text();
                  if (document.getElementById("<%=txtName.ClientID%>").value == "") 
                  {


                      document.getElementById("lblIssuename").innerText = "*";

                      document.getElementById("<%=txtName.ClientID%>").focus();
                      return false;

                  }
                  else
                      if (document.getElementById("<%=lbl_Comp_name.ClientID%>").innerText == "") 
                      {

                          document.getElementById("lbl_req_asset").innerText = "*";
                          return false;

                      }
                      else if (text == "---Select---")
                       {

                          document.getElementById("<%=lblstatus.ClientID%>").innerText = "*";
                          return false;

                      }
                      else {

                          return true;
                      }
              }

          }
          function closewindow() {
              window.close();
          }
          function gotoPage(id, pagename) {
          
              var url;
              if (pagename == "Asset") {
                  url = "AssetMenu.aspx?assetid=" + id;// + "&pagevalue=AssetProfile";
              }
              else if (pagename == "Type") {
                  url = "TypeProfileMenu.aspx?type_id=" + id;
                  //alert("Page Under Construction");
              }


              top.location.href(url);
          }

        
    </script>
    <link rel="Stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css"/>
  <telerik:RadWindowManager ID="rad_windowmgr" runat="server" VisibleStatusbar="false"
        Skin="Forest">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="None" Behavior="Move,Resize"
                 KeepInScreenBounds="true" ReloadOnShow="True" BorderStyle="Solid"
                VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
  <%--  <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>--%>
   
 
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="divMargin" style="padding-left: 0px" id="divmaincontent" runat="server">
        <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
        <table cellpadding="0" cellspacing="0"  border="0" width="100%" style="margin: 15px 50px 10px 0px;" >
            <caption align="top" id="head" runat="server">
                <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,  Issue_Profile%>"></asp:Label>
               
            </caption>
            <tr>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <th colspan="1" style="width: 100px">
                   <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,  Name%>"></asp:Label>:
                   <%-- <span id="span2" runat="server" style="color: red; width: 100px;"></span>--%>
                </th>
                <td align="left" colspan="3">
                
                   
                    <asp:TextBox ID="txtName"   runat="server" CssClass="textbox" Width="220px"></asp:TextBox>
                     <asp:Label ID="lblname"  runat="server" CssClass="LabelText"></asp:Label>
                    <asp:Label ID="lblIssuename" ClientIDMode="Static" runat="server" Text="" ForeColor="Red" CssClass="LabelText"></asp:Label>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                        ControlToValidate="txtName" Display="Dynamic" ForeColor="Red"  SetFocusOnError="True"></asp:RequiredFieldValidator>
                  --%>
                </td>
            </tr>
            <tr>
                <th style="width: 100px">
                    <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,   Issue_Type%>"></asp:Label>:
                   
                </th>
                <td align="left" colspan="3">
                    <asp:Label ID="lblType" CssClass="LabelText" runat="server"></asp:Label>
                    <telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" ID="rcbType"
                        DataTextField="issue_category_name" DataValueField="pk_issue_category_id" runat="server"
                        CssClass="DropDown" Width="220px">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <th style="width: 100px">
                    <asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, Description%>"></asp:Label>:        
                </th>
                <td align="left" colspan="3">
                    <asp:Label ID="lblDescription" CssClass="LabelText" runat="server"></asp:Label>
                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Height="30px"
                        CssClass="textbox" Width="220px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th style="width: 100px">
                   <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource, Document%>"></asp:Label>:
                </th>
                <td>
                    <asp:HyperLink ID="lnkDocument" runat="server" CssClass="linkText" Target="_blank"></asp:HyperLink>
                    <div style="float: left; padding-top: 5px">
                        <telerik:RadUpload ID="ruDocument" runat="server" ControlObjectsVisibility="None"
                            Width="230px">
                        </telerik:RadUpload>
                    </div>
                    <div style="padding-top: 5px">
                     <%--   <asp:Button ID="btnUpload" runat="server" CausesValidation="false" Text="Upload"
                            Width="65px" TabIndex="9" />--%>
                        <asp:Label ID="lblselectdocument" runat="server" CssClass="Message" ForeColor="Red"></asp:Label>
                    </div>
                    <asp:HiddenField ID="hfAttachedFile" runat="server" />
                    <asp:HiddenField ID="hfDocumentName" runat="server" />
                    <asp:HiddenField ID="hfdocument_id" runat="server" />
                </td>
            </tr>
            <tr>
                <th style="width: 100px" valign="top">
                    <asp:Label ID="Label6" runat="server" Text="<%$Resources:Resource, Assigned_To%>"></asp:Label>:
                    
                </th>
                <td>
                    <span id="Span12" style="font-weight: bold"></span>
                    <telerik:RadGrid ID="rgAssignTo" runat="server" AllowPaging="true" Width="50%" BorderWidth="1px" Skin="Hay"  OnPageIndexChanged="rgAssignTo_OnPageIndexChanged"
                        CellPadding="0" AutoGenerateColumns="False" PageSize ="5" PagerStyle-AlwaysVisible="true" OnPageSizeChanged="rgAssignTo_OnPageSizeChanged">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" Width="50%" AlwaysVisible="true" />
                        <MasterTableView>
                            <Columns>
                                <telerik:GridBoundColumn DataField="UserOrganizationname" HeaderText="Name">
                                    <ItemStyle CssClass="column" Width="50%" Wrap ="false" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <uc1:UCComboAssignedTo ID="UCComboAssignedTo1" runat="server" />
                   
                </td>
            </tr>
            <tr>
                <th style="width: 100px">
                   <asp:Label ID="Label7" runat="server" Text="<%$Resources:Resource, Component%>"></asp:Label>:
                    
                </th>
                <td>
                    <asp:Label ID="lbl_Comp_name" ClientIDMode="Static" CssClass="linkText" Text="" runat="server"></asp:Label>
                    &nbsp; &nbsp;
                    <asp:LinkButton ID="btn_add_Comp" Text="<%$Resources:Resource, Add%>" OnClientClick="javascript:return Openfacilitylist();"
                        runat="server"></asp:LinkButton>
                        <asp:Label ID="lbl_req_asset" ClientIDMode="static" runat="server" Text="" ForeColor="Red" CssClass="LabelText"></asp:Label>
                </td>
            </tr>
            <tr>
                <th style="width: 100px">
                    <asp:Label ID="Label8" runat="server" Text="<%$Resources:Resource, Type%>"></asp:Label>:
                </th>
                <td>
                    <asp:Label ID="lbl_type_name" Text="" CssClass="linkText" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th style="width: 100px">
                     <asp:Label ID="Label9" runat="server" Text="<%$Resources:Resource, Mitigation%>"></asp:Label>: 
                </th>
                <td align="left" colspan="3">
                    <asp:Label ID="lblMitigation" CssClass="LabelText" runat="server"></asp:Label>
                    <asp:TextBox ID="txtMitigation" runat="server" CssClass="textbox" Width="220px"></asp:TextBox>
                </td>
            </tr>
           <%-- <tr>
                <th style="width: 100px">
                    <asp:Label ID="Label10" runat="server" Text="<%$Resources:Resource, Inspections%>"></asp:Label> :
                </th>
                <td align="left" colspan="3">
                    <asp:Label ID="lblinspection" CssClass="LabelText" runat="server"></asp:Label>
                   <telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" Height="100px"
                        DataTextField="name" DataValueField="pk_inspection_id" ID="rcbinspection"
                        runat="server" Width="220px">
                    </telerik:RadComboBox>
                </td>
            </tr>--%>
            <tr>
                <th style="width: 100px" valign="top">
                    <asp:Label ID="Label11" runat="server" Text="<%$Resources:Resource, Location%>"></asp:Label>:
                   <%-- <span id="span9" runat="server" style="color: red"></span>:--%>
                </th>
                <td>
                    <telerik:RadGrid ID="rgLocation" runat="server" AllowPaging="true" Width="50%" BorderWidth="1px" Skin="Hay" OnPageIndexChanged="rgLocation_OnPageIndexChanged"
                        CellPadding="0" AutoGenerateColumns="False" PagerStyle-AlwaysVisible="true" PageSize="5"  OnPageSizeChanged="rgLocation_OnPageSizeChanged">
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right"  AlwaysVisible="true" />
                        <MasterTableView DataKeyNames="pk_location_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_location_id" HeaderText="location_id" Visible="false">
                                    <ItemStyle CssClass="column" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="name" HeaderText="Name">
                                    <ItemStyle CssClass="column" Width="50%" Wrap="false" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="description" HeaderText="Description">
                                    <ItemStyle CssClass="column" Width="50%" Wrap="false" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    
                    <uc2:uclocation ID="UCLocation1" runat="server" />
                </td>
            </tr>
            <tr>
                <th style="width: 100px; height: 27px">
                    <asp:Label ID="Label12" runat="server" Text="<%$Resources:Resource, DeadLine%>"></asp:Label>:
                <%--    <span id="span1" runat="server" style="color: red"></span>:--%>
                </th>
                <td>
                    <asp:Label ID="lbldeadline" CssClass="LabelText" runat="server"></asp:Label>
                    <telerik:RadDatePicker ID="issue_dead_line" runat="server">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <th style="width: 100px; height: 27px">
                    <asp:Label ID="Label13" runat="server" Text="<%$Resources:Resource, Status%>"></asp:Label>:
                  <%--  <span id="span3" runat="server" style="color: red"></span>:--%>
                </th>
                <td>
                    <asp:Label runat="server" CssClass="LabelText" ID="lblIssueStatus"></asp:Label>
                    <telerik:RadComboBox CausesValidation="true" MarkFirstMatch="true" Height="100px"
                        DataTextField="issuestatus" DataValueField="issuestatus" ID="rcb_Status"
                        runat="server" Width="220px" >
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="Open" Value="1" />
                           <telerik:RadComboBoxItem runat="server" Text="Resolved" Value="2" />
                       </Items>
                   </telerik:RadComboBox>&nbsp;
                   <asp:Label ID="lblstatus" runat="server" Text="" ForeColor="Red"></asp:Label>
                   
                  
                </td>
            </tr>
            <tr>
                <th style="width: 100px">
                    <asp:Label ID="Label14" runat="server" Text="<%$Resources:Resource, Chance%>"></asp:Label>:
                    
                </th>
                <td>
                    <asp:Label ID="lblChance" CssClass="LabelText" runat="server"></asp:Label>
                    <telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" Height="100px"
                        DataTextField="issue_chance_name" DataValueField="pk_issue_chance_id" ID="rcbChance"
                        runat="server" Width="220px">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <th style="width: 100px">
                    <asp:Label ID="Label15" runat="server" Text="<%$Resources:Resource, Impact%>"></asp:Label>:
                    
                </th>
                <td>
                    <asp:Label ID="lblImpact" CssClass="LabelText" runat="server"></asp:Label>
                    <telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" Height="100px"
                        DataTextField="issue_impact_name" DataValueField="pk_issue_impact_id" ID="rcbImpact"
                        runat="server" Width="220px">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <th style="width: 100px">
                    <asp:Label ID="Label16" runat="server" Text="<%$Resources:Resource, Risk%>"></asp:Label>:
                    
                </th>
                <td>
                    <asp:Label ID="lblRisk" CssClass="LabelText" runat="server"></asp:Label>
                    <telerik:RadComboBox CausesValidation="false" MarkFirstMatch="true" Height="100px"
                        DataTextField="issue_risk_name" DataValueField="pk_issue_risk_id" ID="rcbRisk"
                        runat="server" Width="220px" CssClass="DropDown">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="3">
                    <asp:Label ID="lblMessage" align="Center" runat="server" Style="color: Red; font-size: 16;"
                        size="50px" CssClass="Message"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <th style="width: 100px">
                    <asp:Label ID="lblMsg" CssClass="linkText" runat="server" ForeColor="red"></asp:Label>
                    <asp:HiddenField ID="hfcobie2_issues_id" runat="server" />
                    <asp:HiddenField ID="hfFileID" runat="server" />
                    <asp:HiddenField ID="hfUploadedFileId" runat="server" />
                    <asp:HiddenField ID="hf_lbl_comp_id" runat="server" />
                     <asp:HiddenField ID="hdnfacility" runat="server" />
                     <asp:HiddenField ID="hfFilePath" runat="server" />
                    <asp:HiddenField ID="hfFilename" runat="server" />
                     <asp:HiddenField ID="hfpopupflag" runat="server" ClientIDMode="Static" />
                </th>
            </tr>
            <tr style="width: 100%">
                <td  >
                    <asp:Button ID="btnSave" runat="server" Text="<%$Resources:Resource, Save%>" Width="100px" OnClick="btnSave_click" OnClientClick="javascript:return chklbl();"/>
               
                </td>
                <td>
                    <table><tr><td><asp:Button ID="btn_resolve" runat="server" Text="<%$Resources:Resource, Resolved%>" Width="80px" OnClick="btnresolve_click"  /></td>
                       <td><asp:Button ID="btn_delete" OnClick="btndelete_click" runat="server" Text="<%$Resources:Resource, Delete%>"
                        Width="80px" OnClientClick="javascript:return delete_();" /></td>
                 <td> <asp:Button ID="btnCancel" OnClick="cancel_click" runat="server" Text="<%$Resources:Resource, Cancel%>" Width="80px"
                        CausesValidation="false" /></td>
                        <td>
                         <asp:Button ID="btnclose" runat="server" Width="100" Text="<%$Resources:Resource, Close%>"  OnClientClick="Javascript:closewindow();" />
                        </td>
                        </table>
                </td>
            </tr>
        </table>
    </div>
    
     <telerik:RadAjaxManagerProxy ID="issueProfilesManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btn_resolve">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblIssueStatus" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="btn_resolve" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="rgAssignTo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAssignTo" LoadingPanelID="loadingPanel1" />
                   
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="rgLocation">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgLocation" LoadingPanelID="loadingPanel1" />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
               
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
     <telerik:RadAjaxLoadingPanel ID="loadingPanel1" Skin="Hay" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
     
     
</asp:Content>

