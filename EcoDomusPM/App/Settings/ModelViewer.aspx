<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="ModelViewer.aspx.cs" Inherits="App_Settings_ModelViewer" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.Design" Namespace="Telerik.Web.Design" TagPrefix="telerik" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
      <style type="text/css">
          .rmpHiddenView
            {
                display: none;
            }
        A:link
        {
            color: black;
        }
        A:visited
        {
            color: Black;
        }
        A:hover
        {
            color: red;
        }
        A:active
        {
            color: Black;
        }
        #lblUserName
        {
            font-size: 10px;
            color: #333333;
            font-family: Verdana;
            background-image: url(../../Images/top.jpg);
        }
        #form
        {
            width: 100%;
            height: 100%;
            border: 1;
        }
        .style1
        {
            width: 20%;
            height: 19%;
        }
        .rlbGroup
        {
            border: none !important;
        }
        html, body
        {
            margin-top: 0px;
            margin-left: 0px;
            margin-right: 0px;
            width: 100%;
            height: 100%;
        }
        #RadGrid
        {
            font-size: 10px;
        }
    </style>
    
    <script type="text/vbscript">
    

 public sub NWControl01_OnLButtonUp(flags,x_coord,y_coord)
    
     select_point()
end sub

    
    </script>

</head>
<body id="Body1" style="background:transparent;background-image:url('../Images/asset_zebra-bkgrd_gray2.PNG'); margin-bottom: 0; border: 0 margin-left: 0; margin-right: 0;
    background-color: #ECF8E0; margin-top: 0; padding: 0; width: 100%;max-height:100% " >
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

      <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
          <script type="text/javascript">

              function open_type_popup(attribute_name, attribute_id, table_name, attribute_value, UOM_id, PK_element_Numeric_ID) {

                  var r = confirm("Please select type for component.")
                  if (r == true) {
                      var left = (window.screen.width / 2) - (700 / 2);
                      var top = (window.screen.height / 2) - (700 / 2);
                      var url = "../Settings/FacilityTypes.aspx?element_numeric_id=" + document.getElementById("PK_element_Numeric_ID").value + "&file_id=" + document.getElementById("hf_file_id").value + "&facility_id=" + document.getElementById("hdnfacilityid").value + "" + "&attribute_name=" + attribute_name + "" + "&attribute_id=" + attribute_id + "" + "&table_name=" + table_name + "" + "&attribute_value=" + attribute_value + "";
                      window.open(url, '', 'width=700px,height=550px,scrollbars=yes,Resizable=yes,top=' + top + ', left=' + left);


                  }
                  else
                      refresh_asset_grid();
              }


              function ShowNotification() {

                  var notification = $find("<%=RadNotification1.ClientID %>");
                  notification.show();
                  return false;
              }

              function selectAssetAttributeTab() {
                
              }

              function gotoAttributeHistoryGraph() {

                  var grid = $find("<%=rg_comp_sensor.ClientID%>");
                
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var attributeids="";
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    attributeids = attributeids + row.getDataKeyValue("pk_asset_attribute_id") + ",";


                }

                if (attributeids == "") {
                    alert("Please select atleast one attribute");
                }

                else {

                    var frmdate = $find("<%=radfrmdatepicker.ClientID%>");
                    var todate = $find("<%=radtodatepicker.ClientID%>");
                    var left = (window.screen.width / 2) - (700 / 2);
                    var top = (window.screen.height / 2) - (700 / 2);
                    var url = "../Settings/AttributeHistoryGraph.aspx?asset_id=" + document.getElementById("<%=hf_component_id.ClientID%>").value + "&conn_string=" + document.getElementById("<%=hdn_conn_string.ClientID%>").value + "&Frm_time_stmp=" + frmdate.get_textBox().value + "&To_time_stmp=" + todate.get_textBox().value + "&attributeids=" + attributeids + "";
                    window.open(url, '', 'width=750,height=540,scrollbars=yes,left=200px,top=210px');
                    return false;
                }

              }
              //              function LogoutNavigation() {

              //                  var query = parent.location.href;
              //                  top.location.href(query);

              //              }


              function ShowNotification_GroupSelection() {
                  //debugger
                  var notification1 = $find("<%=RadNotification3.ClientID %>");
                  notification1.show();
                  return false;
              }

              function enablemultipleselection() {
                  try {
                  //debugger

                      if (document.getElementById("hdngroupselctionflag").value == "True") {
                          document.getElementById("hdngroupselctionflag").value = "False";
                          document.getElementById("hdnmultipleasset").value = "";
                          document.getElementById('<%=btn_groupSelection.ClientID%>').src = "../Images/GroupSelection_off.png";
                          alert("Multiple selection Disabled");

                          var list = $find("<%= radlstassetsforspace.ClientID %>");
                          var items = list.get_items();
                          items.clear();
                          list.commitChanges();
                          var notification2 = $find("<%=RadNotification3.ClientID %>");
                          notification2.hide();
                          return false;
                      }
                      else {
                          document.getElementById("hdngroupselctionflag").value = "True";
                          var success1 = ShowNotification_GroupSelection();
                          document.getElementById('<%=btn_groupSelection.ClientID%>').src = "../Images/GroupSelection_on.png";
                          alert("Multiple selection Enabled")
                          return false;

                      }
                  }

                  catch (err) {
                      var error = err.description
                      alert(err.description);
                  }
              }
              function insertupdateitemstolistbox(assetid, assetname) {
                  try {

                      listBox = $find("<%= radlstassetsforspace.ClientID %>");
                      listBox.trackChanges();
                      //Instantiate a new client item
                      var item = new Telerik.Web.UI.RadListBoxItem();
                      item.set_text(assetname);
                      item.set_value(assetid.replace("}]", ""));

                      if (listBox.findItemByValue(assetid.replace("}]", "")) == null) {

                          listBox.get_items().add(item);
                      }
                      else {
                          alert("Already Added")
                      }

                      item.check();
                      item.scrollIntoView();
                      listBox.commitChanges();
                      return false;
                  }
                  catch (err) {
                      var error = err.description
                      alert(error);
                  }

              }
              function RestfulResource(resource_url, category,Elementnumericid) {
            
                  this.resource_url = resource_url

                  this.xmlhttp = new XMLHttpRequest();

                  /**
                  * Get the resource or a list of resources calling the RESTful web service with the GET http method
                  * @param id The id of the resource, if is null a list of resources will be retrieved.
                  */

                  var url = this.resource_url

                  url = this.resource_url.concat("/GetSelectedComponent?FileID=" + document.getElementById("hf_file_id").value + "&ELEMENTNUMERICID=" + Elementnumericid + "&conn_string=" + document.getElementById("hf_client_con_string").value + "&category=" + category)

                  var self = this;

                  if (self.xmlhttp.readyState == 4) {
                      if (self.xmlhttp.status == 200) {
                          self.onRetrieveSuccess.call(self, self.xmlhttp.responseText);
                      } else {
                          self.onRetrieveError.call(self, self.xmlhttp.statusText);
                      }
                  }

                  this.xmlhttp.open("GET", url, true);
                  this.xmlhttp.send();


                  self.xmlhttp.onreadystatechange = function X() {

                      if (self.xmlhttp.readyState == 4) {
                          var response = self.xmlhttp.responseText;
                          if (response != "[]") {
                              response = response.split(",");
                              var resposeid = response[3].split(':');
                              response = response[0].split(":");

                              insertupdateitemstolistbox(resposeid[1], response[1]);

                          }
                      }
                  }


                  /*
                  * The method called when a resource is successfully retrieved.
                  */
                  this.onRetrieveSuccess = function (responseText) {
                      alert("onRetrieveSuccess method " + responseText);
                  }

                  /*
                  * The method called when a resource is not created.
                  */
                  this.onRetrieveError = function (statusText) {
                      alert("onRetrieveError method " + statusText);
                  }

                  /**
                  * Create the resource calling the RESTful web service with the PUT http method
                  * @param jsonObject The jsonObject that will be created.
                  */
                  this.create = function (jsonObject) {
                      var jsonString = JSON.stringify(jsonObject);
                      var self = this;
                      this.xmlhttp.onreadystatechange = function () {
                          if (self.xmlhttp.readyState == 4) {
                              if (self.xmlhttp.status == 200) {
                                  self.onCreateSuccess.call(self, self.xmlhttp.responseText);
                              } else {
                                  self.onCreateError.call(self, self.xmlhttp.statusText);
                              }
                          }
                      }
                      this.xmlhttp.open("PUT", this.resource_url, true);
                      this.xmlhttp.setRequestHeader("Content-type", "application/json");
                      this.xmlhttp.setRequestHeader("Content-length", jsonString.length);
                      this.xmlhttp.setRequestHeader("Connection", "close");
                      this.xmlhttp.send(jsonString);
                  }

                  /*
                  * The method called when the resource is successfully created.
                  */
                  this.onCreateSuccess = function (responseText) {
                      alert("onCreateSuccess method " + responseText);
                  }

                  /*
                  * The method called when the resource can't be created.
                  */
                  this.onCreateError = function (statusText) {
                      alert("onCreateError method " + statusText);
                  }

                  /**
                  * Update a resource calling the RESTful web service with the POST http method
                  * @param id The id of the resource, if is null a list of resources will be retrieved.
                  * @return The retrieved resource.
                  */
                  this.update = function (jsonObject) {
                      var jsonString = JSON.stringify(jsonObject);
                      var self = this;
                      this.xmlhttp.onreadystatechange = function () {
                          if (self.xmlhttp.readyState == 4) {
                              if (self.xmlhttp.status == 200) {
                                  self.onUpdateSuccess.call(self, self.xmlhttp.responseText);
                              } else {
                                  self.onUpdateError.call(self, self.xmlhttp.statusText);
                              }
                          }
                      }
                      this.xmlhttp.open("POST", this.resource_url, true);
                      this.xmlhttp.setRequestHeader("Content-type", "application/json");
                      this.xmlhttp.setRequestHeader("Content-length", jsonString.length);
                      this.xmlhttp.setRequestHeader("Connection", "close");
                      this.xmlhttp.send(jsonString);
                  }

                  /**
                  * The method called when the resource is successfully updated.
                  */
                  this.onUpdateSuccess = function (responseText) {
                      alert("onUpdateSuccess method " + responseText);
                  }

                  /**
                  * The method called when the resource can't be updated.
                  */
                  this.onUpdateError = function (statusText) {
                      alert("onUpdateError method " + statusText);
                  }

                  /**
                  * Remove a resource calling the RESTful web service with the DELETE http method
                  * @param id The id of the resource.
                  */
                  this.remove = function (id) {
                      var url = this.resource_url.concat("/" + id);
                      var self = this;
                      this.xmlhttp.onreadystatechange = function () {
                          if (self.xmlhttp.readyState == 4) {
                              if (self.xmlhttp.status == 200) {
                                  self.onRemoveSuccess.call(self, self.xmlhttp.responseText);
                              } else {
                                  self.onRemoveError.call(self, self.xmlhttp.statusText);
                              }
                          }
                      }
                      this.xmlhttp.open("DELETE", url, true);
                      this.xmlhttp.send(null);
                  }

                  /**
                  * The method called when the resource is successfully removed.
                  */
                  this.onRemoveSuccess = function (responseText) {
                      alert("onRemoveSuccess method " + responseText);
                  }

                  /**
                  * The method called when the resource can't be removed.
                  */
                  this.onRemoveError = function (statusText) {
                      alert("onRemoveError method " + statusText);
                  }

              }

              ////Rest WCF
              function assignspacepopup() {

                  try {
                      listBox = $find("<%= radlstassetsforspace.ClientID %>");

                      var array = listBox.get_checkedItems();
                      var i;
                      var assetids = "";
                      for (i = 0; i < array.length; i++) {
                          var item = new Telerik.Web.UI.RadListBoxItem();
                          item = array[i];
                          assetids = assetids + item.get_value() + ",";
                      }
                      assetids = assetids.substring(0, assetids.length - 1);

                      openfacilityspaces(assetids);
                      //window.open("ModelSpaces.aspx?comp_ids=" + assetids, '', 'width=700px,height=400px')
                      return false;
                  }
                  catch (err) {
                      var error = err.description
                      alert(err.description);


                  }

              }

              function OpenModelSpaces(fileid) 
              {
                  var left = (window.screen.width / 2) - (700 / 2);
                  var top = (window.screen.height / 2) - (700 / 2);
                  var url = "../Settings/ModelSpaces.aspx?file_id=" + fileid + "&element_numeric_ids=" + document.getElementById("hf_component_id").value + "";
                  window.open(url, '', 'width=700px,height=550px,scrollbars=yes,top=' + top + ', left=' + left);
                  document.getElementById("btn_properties").click();
              }
              function openfacilityspaces(asset_ids) {


                  var left = (window.screen.width / 2) - (700 / 2);
                  var top = (window.screen.height / 2) - (700 / 2);
                  var url = "../Settings/FacilitySpaces.aspx?element_numeric_ids=" + asset_ids + "&file_id=" + document.getElementById("hf_file_id").value + "";
                  window.open(url, '', 'width=700px,height=550px,scrollbars=yes,Resizable=yes,top=' + top + ', left=' + left);

              }

              function openassignmanufacturer(typeid) {
                  var left = (window.screen.width / 2) - (700 / 2);
                  var top = (window.screen.height / 2) - (700 / 2);
                  var url = "../Settings/AssignManufacturerModelViewer.aspx?typeid=" + typeid;
                  window.open(url, '', 'width=700px,height=550px,scrollbars=yes,Resizable=yes,top=' + top + ', left=' + left);
              }

              function radtreeviewsystem_OnClientNodeClicked(sender, e) {
                  document.getElementById("hf_category").value = "System";
                  document.getElementById("hf_system_id").value = e.get_node().get_value();
              }
              
            </script>    
            </telerik:RadCodeBlock>
    <telerik:RadAjaxManager ID="radmanager" runat="server" EnableHistory="true" >
        <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="radtreeviewsystem">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_component" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="right_dock_zone" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_properties">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProperties" LoadingPanelID="RadAjaxLoadingPanel2" />
                    <telerik:AjaxUpdatedControl ControlID="rgspace" LoadingPanelID="RadAjaxLoadingPanel2" />
                    <telerik:AjaxUpdatedControl ControlID="right_dock_zone" LoadingPanelID="RadAjaxLoadingPanel2" />
                     <telerik:AjaxUpdatedControl ControlID="hf_comp_Guid_id" />                    
                    <telerik:AjaxUpdatedControl ControlID="rg_room_data_sheet" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="radworkorder"  />
                       <telerik:AjaxUpdatedControl ControlID="radgrdimpact" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_refresh_asset">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgProperties" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="rgspace" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="right_dock_zone" LoadingPanelID="RadAjaxLoadingPanel2" />
                    <telerik:AjaxUpdatedControl ControlID="hf_comp_Guid_id" />
                    <telerik:AjaxUpdatedControl ControlID="rg_room_data_sheet" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="radworkorder" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="rg_search_data_new" LoadingPanelID="RadAjaxLoadingPanel1" />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_find_component">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_search_data_new" />
                    <telerik:AjaxUpdatedControl ControlID="divloading" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

             <telerik:AjaxSetting AjaxControlID="rg_search_data_new">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="rg_search_data_new" LoadingPanelID="RadAjaxLoadingPanel1" /> 
                    <telerik:AjaxUpdatedControl ControlID="lbl_sliding" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="lbl_sliding_left" LoadingPanelID="RadAjaxLoadingPanel1" />                                   
                </UpdatedControls>

            </telerik:AjaxSetting>
           
               <telerik:AjaxSetting AjaxControlID="rgSearchSpace">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="rgSearchSpace" LoadingPanelID="RadAjaxLoadingPanel1" /> 
                    <telerik:AjaxUpdatedControl ControlID="lbl_sliding" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="lbl_sliding_left" LoadingPanelID="RadAjaxLoadingPanel1" />                                
                </UpdatedControls>

            </telerik:AjaxSetting>
            
             <telerik:AjaxSetting AjaxControlID="btn_system_assets">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_component" />                    
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnFindSpace">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="rgSearchSpace" LoadingPanelID="RadAjaxLoadingPanel1" />                                     
                </UpdatedControls>

            </telerik:AjaxSetting>

             <telerik:AjaxSetting AjaxControlID="rgSearchSpace">
                <UpdatedControls>                  
                    <telerik:AjaxUpdatedControl ControlID="rg_room_data_sheet" LoadingPanelID="RadAjaxLoadingPanel1"/>                              
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="rdcmb_search_type">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdcmb_search_by" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="Timer1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_comp_sensor"  />
                     <telerik:AjaxUpdatedControl ControlID="lbl_sliding" />
                    <telerik:AjaxUpdatedControl ControlID="lbl_sliding_left"/>
                </UpdatedControls>
           </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="radfrmdatepicker" EventName="OnPopupOpening">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lbl_sliding" />
                    <telerik:AjaxUpdatedControl ControlID="lbl_sliding_left"/>
                    <telerik:AjaxUpdatedControl ControlID="lblmiddlepane"/>
                    
                </UpdatedControls>
            </telerik:AjaxSetting>

              <telerik:AjaxSetting AjaxControlID="radtodatepicker" >
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lbl_sliding" />
                    <telerik:AjaxUpdatedControl ControlID="lbl_sliding_left"/>
                    <telerik:AjaxUpdatedControl ControlID="lblmiddlepane"/>
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Forest" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
     <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" Skin="Forest" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>
    <div>
        <table runat="server" id="tblparent" border="0" style="width: 100%; height:100%; "
            cellspacing="0">
            <tr style="width: 100%;">
                <td colspan="2" style="background-color: #74bd47; height: 7px">
                </td>
            </tr>
            <tr>
                <td id="main_td" colspan="2" style="vertical-align: top; height: 100%">
                    <telerik:RadSplitter ID="RadSplitter1" runat="server" BorderStyle="Double" Orientation="Vertical"
                        BorderSize="0" Skin="Forest" ResizeWithParentPane="false" VisibleDuringInit="false"
                        Width="100%" Height="100%" OnClientLoad="Dock_load" PanesBorderSize="0" SplitBarsSize="">
                        <telerik:RadPane ID="LeftPane" runat="server" Height="100%" Width="250px" Scrolling="X">
                            <telerik:RadDockZone BackColor="#ECF8E0" BorderWidth="0" ID="RadDockZone1" runat="server"
                                Orientation="Vertical" MinHeight="300px" Height="100%">
                                <telerik:RadDock DockMode="Docked" Skin="Forest" Collapsed="false" BorderWidth="0"
                                    OnClientCommand="DockCommand" OnClientInitialize="DockInit" ID="RadDock1" runat="server"
                                    Title="<%$Resources:Resource, Viewpoints%>" EnableAnimation="true" EnableRoundedCorners="true" Resizable="true"
                                    DockHandle="TitleBar">
                                    <ContentTemplate>
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <telerik:RadTreeView Width="99%" Height="100%" runat="server" ID="Treeview_Views"
                                                    AutoPostBack="false" OnClientNodeClicked="ClientNodeClicked">
                                                </telerik:RadTreeView>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </ContentTemplate>
                                </telerik:RadDock>
                                <telerik:RadDock BorderWidth="0" Skin="Forest" OnClientInitialize="DockInit" Collapsed="false"
                                    OnClientCommand="DockCommand" DockMode="Docked" ID="RadDock2" Resizable="true"
                                    DockHandle="TitleBar" runat="server" Title="<%$Resources:Resource, System%>" EnableAnimation="true" EnableRoundedCorners="true">
                                    <ContentTemplate>
                                        <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                              <telerik:RadTreeView Skin="Hay" OnNodeClick="radtreeviewsystem_click" ID="radtreeviewsystem"
                                                    OnClientNodeClicked="radtreeviewsystem_OnClientNodeClicked" runat="server">
                                                </telerik:RadTreeView>
                                                    </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </ContentTemplate>
                                </telerik:RadDock>
                                <telerik:RadDock DockMode="Docked" Skin="Forest" Collapsed="true" OnClientCommand="DockCommand"
                                    OnClientInitialize="DockInit" BorderWidth="0" ID="RadDock3" runat="server" Title="<%$Resources:Resource, System_Asset%>"
                                    EnableAnimation="true" EnableRoundedCorners="true" Resizable="true" DockHandle="TitleBar" Height="90%">
                                    <ContentTemplate>
                                        <telerik:RadGrid ShowHeader="false" ID="rg_component" BorderStyle="None" Style="width: 95%; 
                                            height: 100%;" Skin="Forest" runat="server" EnableViewState="true" AutoGenerateColumns="false" 
                                            AllowSorting="true" MasterTableView-TableLayout="Fixed" >
                                            <ClientSettings AllowDragToGroup="true">
                                                <Selecting AllowRowSelect="false" />
                                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                                <Resizing AllowColumnResize="true"></Resizing>
                                            </ClientSettings>
                                            <MasterTableView HeaderStyle-Height="0px" DataKeyNames="pk_asset_id" TableLayout="Fixed"
                                                GroupLoadMode="Client">
                                                <Columns>
                                                    <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="system_component"
                                                        Visible="true">
                                                        <HeaderStyle Height="0px" Wrap="false" />
                                                        <ItemStyle Wrap="true" />
                                                    </telerik:GridButtonColumn>
                                                </Columns>
                                            </MasterTableView></telerik:RadGrid></ContentTemplate>
                                </telerik:RadDock>

                                <telerik:RadDock DockMode="Docked" Skin="Forest" OnClientCommand="DockCommand" OnClientInitialize="DockInit" 
                                    Collapsed="true" BorderWidth="0" ID="RadDock4" runat="server" Resizable="true"
                                    Title="<%$Resources:Resource, Search_Asset%>" EnableAnimation="true" EnableRoundedCorners="true" DockHandle="TitleBar">
                                    <ContentTemplate>
                                        <table border="0" width="90%">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="rdcmb_search_type" runat="server" Width="90%" AutoPostBack="true"
                                                        OnSelectedIndexChanged="rdcmb_search_type_selectedindexchanged">
                                                        <%--<Items>
                                                            <telerik:RadComboBoxItem Text="Select" Value="Select" />
                                                            <telerik:RadComboBoxItem Text="Asset" Value="Asset" />
                                                            <telerik:RadComboBoxItem Text="Type" Value="Type" />
                                                            <telerik:RadComboBoxItem Text="Space" Value="Space" />
                                                        </Items>--%>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="rdcmb_search_by" runat="server" Width="90%">
                                                        <Items>
                                                          <%--  <telerik:RadComboBoxItem Text="Select" Value="Select" />--%>
                                                            <telerik:RadComboBoxItem Text="Name" Value="Name" />
                                                            <telerik:RadComboBoxItem Text="Description" Value="Description" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txt_search" runat="server" Width="88%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btn_find_component" runat="server" Width="50%" Text="<%$Resources:Resource, Find%>" OnClick="btn_find_component_click" />
                                                </td>
                                            </tr>
                                            
                                        </table>
                                       
                                        <telerik:RadGrid Skin="Forest" ID="rg_search_data_new" Font-Size="Small" runat="server"
                                            Style="width: 90%;" BorderWidth="0px" CellPadding="0" EnableViewState="true" AllowPaging="true" PageSize="5"
                                            AutoGenerateColumns="false" OnPageIndexChanged="rg_search_data_new_OnPageIndexChanged" OnPageSizeChanged="rg_search_data_new_OnPageSizeChanged" AllowSorting="true" ClientSettings-Resizing-AllowColumnResize="true"
                                            MasterTableView-TableLayout="Fixed" ClientSettings-Scrolling-AllowScroll="true">
                                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="true" />
                                            <ClientSettings AllowDragToGroup="true">
                                                <Selecting AllowRowSelect="false" />
                                                <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                <Resizing AllowColumnResize="True"></Resizing>
                                            </ClientSettings>
                                            <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" ShowHeader="false">
                                                <Columns>
                                                    <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblcertificates" Text='<%# Eval("AssetName")%>' runat="server"></asp:Label></ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblType" Text='<%# Eval("Asset_Name")%>' runat="server"></asp:Label></ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="view_name" UniqueName="view_name" Visible="false"
                                                        HeaderText="View Name">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="ExtIdentifier" Visible="false">
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                            </MasterTableView></telerik:RadGrid>
                                            
                                             <div id="divloading" style="height:10%;" runat="server"></div>
                                            </ContentTemplate>
                                </telerik:RadDock>
                                   <telerik:RadDock DockMode="Docked" Skin="Forest" OnClientCommand="DockCommand" OnClientInitialize="DockInit" 
                                    Collapsed="true" BorderWidth="0" ID="RadDock8" runat="server" Resizable="true"
                                    Title="<%$Resources:Resource, Impact%>" EnableAnimation="true" EnableRoundedCorners="true" DockHandle="TitleBar">
                                    <ContentTemplate>
                                        <telerik:RadGrid Skin="Forest" ID="radgrdimpact" Font-Size="Small" runat="server" 
                                            Style="width: 90%;" BorderWidth="0px" CellPadding="0" EnableViewState="true"
                                            AllowPaging="true" PageSize="5" AutoGenerateColumns="false" OnPageIndexChanged="radgrdimpact_OnPageIndexChanged"
                                            OnPageSizeChanged="radgrdimpact_OnPageSizeChanged" AllowSorting="true" ClientSettings-Resizing-AllowColumnResize="true"
                                            MasterTableView-TableLayout="Fixed" ClientSettings-Scrolling-AllowScroll="true">
                                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                            <ClientSettings AllowDragToGroup="true">
                                                <Selecting AllowRowSelect="false" />
                                                <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                <Resizing AllowColumnResize="True"></Resizing>
                                            </ClientSettings>
                                            <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" ShowHeader="true">
                                                <Columns>
                                                    <telerik:GridTemplateColumn UniqueName="name" HeaderText="Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblcertificates" Text='<%# Eval("name")%>' runat="server"></asp:Label></ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn UniqueName="Description" HeaderText="Description">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldescription" Text='<%# Eval("description")%>' runat="server"></asp:Label></ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn UniqueName="EntityName" HeaderText="Entity Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblentity" Text='<%# Eval("entity_name")%>' runat="server"></asp:Label></ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView></telerik:RadGrid>
                                        <div id="div1" style="height: 10%;" runat="server">
                                        </div>
                                    </ContentTemplate>
                                  </telerik:RadDock>
                                <telerik:RadDock DockMode="Docked" Skin="Forest" OnClientCommand="DockCommand" OnClientInitialize="DockInit"
                                    Collapsed="true" BorderWidth="0" ID="RadDock5" runat="server" Resizable="true"
                                    Title="<%$Resources:Resource, Search_Space%>" EnableAnimation="true" EnableRoundedCorners="true" DockHandle="TitleBar">
                                    <ContentTemplate>
                                        <table border="0" width="90%">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="rdCmbSearchCriteria" runat="server" Width="90%">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="Name" Value="Name" />
                                                            <telerik:RadComboBoxItem Text="Description" Value="Description" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtSearchSpace" runat="server" Width="88%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnFindSpace" runat="server" Width="50%" Text="<%$Resources:Resource, Find%>" OnClick="btnFindSpace_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                        <telerik:RadGrid Skin="Forest" ID="rgSearchSpace" Font-Size="Small" runat="server"
                                            Style="width: 90%;" BorderWidth="0px" CellPadding="0" EnableViewState="true"
                                            PageSize="5" AllowPaging="true" AutoGenerateColumns="false" AllowSorting="true"
                                            OnPageSizeChanged="rgSearchSpace_OnPageSizeChanged" OnPageIndexChanged="rgSearchSpace_OnPageIndexChanged"
                                            ClientSettings-Resizing-AllowColumnResize="true" MasterTableView-TableLayout="Fixed"
                                            ClientSettings-Scrolling-AllowScroll="true">
                                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="true" />
                                            <ClientSettings AllowDragToGroup="true">
                                                <Selecting AllowRowSelect="false" />
                                                <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                <Resizing AllowColumnResize="True"></Resizing>
                                            </ClientSettings>
                                            <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" ShowHeader="false" DataKeyNames="pk_location_id,fk_external_system_data_id"
                                                ClientDataKeyNames="pk_location_id,fk_external_system_data_id">
                                                <Columns>
                                                    <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnk_space" runat="server" Text='<%# Eval("Space_Name")%>'>
                                                            </asp:LinkButton></ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblType" Text='<%# Eval("Description")%>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn Visible="false" UniqueName="profile" HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSpaceId" Text='<%# Eval("pk_location_id")%>' runat="server"></asp:Label></ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn Visible="false" UniqueName="element_numeric_id" HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblelementnumericId" Text='<%# Eval("fk_external_system_data_id")%>'
                                                                runat="server"></asp:Label></ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView></telerik:RadGrid></ContentTemplate>
                                </telerik:RadDock>
                                <telerik:RadDock DockMode="Docked" Skin="Forest" OnClientCommand="DockCommand" OnClientInitialize="DockInit"
                                    Collapsed="true" BorderWidth="0" ID="RadDock6" runat="server" Resizable="true"
                                    Title="<%$Resources:Resource, Room_Data_Sheet%>" EnableAnimation="true" EnableRoundedCorners="true" DockHandle="TitleBar">
                                    <ContentTemplate>
                                        <telerik:RadGrid Skin="Forest" ID="rg_room_data_sheet" Font-Size="Small" runat="server"
                                            Style="width: 90%;" BorderWidth="0px" CellPadding="0" EnableViewState="true"
                                            AutoGenerateColumns="false" AllowSorting="true" ClientSettings-Resizing-AllowColumnResize="true"
                                            MasterTableView-TableLayout="Fixed" ClientSettings-Scrolling-AllowScroll="true">
                                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                            <ClientSettings AllowDragToGroup="true">
                                                <Selecting AllowRowSelect="false" />
                                                <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                <Resizing AllowColumnResize="True"></Resizing>
                                            </ClientSettings>
                                            <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" ShowHeader="false">
                                                <Columns>
                                                    <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblcertificates" Text='<%# Eval("AssetName")%>' runat="server"></asp:Label></ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView></telerik:RadGrid></ContentTemplate>
                                </telerik:RadDock>
                                <telerik:RadDock DockMode="Docked" Skin="Forest" OnClientCommand="DockCommand" OnClientInitialize="DockInit" style="display:none"
                                    Collapsed="true" BorderWidth="0" ID="radockworkorder" runat="server" Resizable="true" 
                                    Title="<%$Resources:Resource, Work_Orders%>" EnableAnimation="true" EnableRoundedCorners="true" DockHandle="TitleBar">
                                    <ContentTemplate>
                                        <telerik:RadGrid Skin="Forest" ID="radworkorder" Font-Size="Small" runat="server"
                                            Style="width: 90%;" BorderWidth="0px" CellPadding="0" EnableViewState="true"
                                            AutoGenerateColumns="false" AllowSorting="true" ClientSettings-Resizing-AllowColumnResize="true"
                                            MasterTableView-TableLayout="Fixed" ClientSettings-Scrolling-AllowScroll="true">
                                            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                            <ClientSettings AllowDragToGroup="true">
                                                <Selecting AllowRowSelect="false" />
                                                <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                <Resizing AllowColumnResize="True"></Resizing>
                                            </ClientSettings>
                                            <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" ShowHeader="false">
                                                <Columns>
                                                    <telerik:GridTemplateColumn UniqueName="profile" HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblcertificates" Text='<%# Eval("linkwordOrder")%>' runat="server"></asp:Label></ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView></telerik:RadGrid></ContentTemplate>
                                </telerik:RadDock>
                                <telerik:RadDock DockMode="Docked" Skin="Forest" OnClientCommand="DockCommand" OnClientInitialize="DockInit" style="display:none;"
                                    Collapsed="true" BorderWidth="0" ID="RadDock7" runat="server" Title="<%$Resources:Resource, BAS_Information%>"
                                    EnableAnimation="true" EnableRoundedCorners="true" Resizable="true" DockHandle="TitleBar"
                                    ForbiddenZones="right_dock_zone,rz_opc">
                                    <ContentTemplate>
                                        <asp:Panel ID="Description_HeaderPanel" runat="server">
                                            <div class="heading">
                                                <asp:ImageButton ID="ImageButton1" OnClientClick="javascript:return ShowNotification();"
                                                    runat="server" ImageUrl="~/App/Images/icon-graph.jpg" Width="50px" Height="37px" />
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="Description_ContentPanel" runat="server" Style="width: 180px;">
                                            <p>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadNotification ID="RadNotification1" runat="server" Width="200" Animation="Fade"
                                                                Position="BottomLeft" EnableRoundedCorners="true" EnableShadow="true" Skin="Office2010Black"
                                                                AutoCloseDelay="5000" Style="z-index: 35000" LoadContentOn="PageLoad" Title="BAS Attribute History">
                                                                <ContentTemplate>
                                                                    <table>
                                                                        <tr>
                                                                            <td style="font-size: x-small; color: White;">
                                                                                Start Date / Time:
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <telerik:RadDateTimePicker ID="radfrmdatepicker" AutoPostBackControl="Both" runat="server"
                                                                                    ZIndex="35001">
                                                                                </telerik:RadDateTimePicker>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="font-size: x-small; color: White;">
                                                                                End Date / Time:
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <telerik:RadDateTimePicker ID="radtodatepicker" AutoPostBackControl="Both" runat="server"
                                                                                    ZIndex="35001">
                                                                                </telerik:RadDateTimePicker>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <telerik:RadButton ID="radbtnupdate" runat="server" AutoPostBack="false" OnClientClicked="gotoAttributeHistoryGraph"
                                                                                    Text="Update">
                                                                                </telerik:RadButton>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ContentTemplate>
                                                            </telerik:RadNotification>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </p>
                                        </asp:Panel>
                                        <%--</td>
                                                <td>--%>
                                        <telerik:RadGrid ID="rg_comp_sensor" BorderStyle="None" Style="width: 90%;" Skin="Forest"
                                            ShowHeader="false" runat="server" EnableViewState="true" AutoGenerateColumns="false"
                                            AllowSorting="true" AllowPaging="false" >
                                            <ClientSettings AllowDragToGroup="true">
                                                <Selecting AllowRowSelect="true" />
                                                <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                <Resizing AllowColumnResize="True"></Resizing>
                                            </ClientSettings>
                                            <%-- <MasterTableView HeaderStyle-Height="0px" TableLayout="Fixed" GroupLoadMode="Client" >--%>
                                            <MasterTableView>
                                                <RowIndicatorColumn Visible="True">
                                                </RowIndicatorColumn>
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="attribute_name" HeaderText="AttributeName" Visible="true">
                                                        <HeaderStyle Width="60%" Wrap="false" />
                                                        <ItemStyle Width="60%" Wrap="false" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="current_value" HeaderText="Value" Visible="true">
                                                        <HeaderStyle Width="20%" Wrap="false" />
                                                        <ItemStyle Width="20%" Wrap="false" />
                                                    </telerik:GridBoundColumn>
                                                      <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Left">
                                                        <ItemStyle Width="20%" />
                                                        <HeaderStyle Width="20%" />
                                                    </telerik:GridClientSelectColumn>
                                                </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                  <%--  <asp:Timer ID="Timer1" runat="server" Interval="10000" OnTick="Timer1_Tick" />--%>
                                                <%--</td>
                                            </tr>--%>
                                           <%-- <ajaxToolkit:CollapsiblePanelExtender ID="cpeDescription" runat="Server" TargetControlID="Description_ContentPanel"
                                                ExpandControlID="Description_HeaderPanel" CollapseControlID="Description_HeaderPanel"
                                                Collapsed="true" />--%>
                                        <%--</table>--%>
                                    </ContentTemplate>
                                </telerik:RadDock>
                               
                            </telerik:RadDockZone>
                            <asp:Label ID="lbl_sliding_left" runat="server"></asp:Label></telerik:RadPane>
                        <telerik:RadPane ID="MiddlePane1" runat="server" Scrolling="None" Height="100%">
                            <telerik:RadSplitter ID="Radsplitter3" runat="server" ResizeWithParentPane="true"
                                Orientation="Horizontal" LiveResize="true" VisibleDuringInit="false">
                                <telerik:RadPane ID="Radpane1" runat="server" Height="100%" Scrolling="none" Border="0">
                                    <table border="0" id="tbl_obj" style="z-index: 3; height:100%;" width="100%" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td style="height: 100%; vertical-align: top;" align="left">
                                                <table border="0" style="vertical-align: top;">
                                                    <tr>
                                                        <td align="center" valign="bottom" style="margin-bottom: 0px; padding-left: 0px;">
                                                            <table border="0" style="vertical-align: TOP;">
                                                                <tr>
                                                                    <td align="center" valign="bottom" style="padding-right: 15px;">
                                                                        <asp:ImageButton runat="server" ToolTip="Back to Model Server" ImageUrl="~/App/Images/Back_off.png"
                                                                            OnClick="btnBack_Click" ID="btnBack" Text="Back To Model Server" Height="35"
                                                                            Width="35" Style="cursor: default;" OnClientClick="javascript:btnBack_OnClientClick()"
                                                                            onmouseover="Back_onmouseover()" onmouseout="Back_onmouseout()" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td align="left" valign="top">
                                                            <asp:Panel ID="pnlNavigationButtons" runat="server" GroupingText="Navigation" CssClass="pnlNavigation">
                                                                <table border="0" style="border-collapse: collapse; margin-top: -1px; margin-bottom: -5px"
                                                                    cellpadding="3" cellspacing="3">
                                                                    <tr>
                                                                        <td align="center" valign="bottom" style="margin-bottom: 0px; padding: 0px;">
                                                                            <a onclick="btnNav_Clicked(16)" onmouseover="image_onmouseover('Select')" onmouseout="image_onmouseout('Select')">
                                                                                <img src="../Images/Select_off.png" alt="Select" id="Select" width="35" height="35" /></a>
                                                                        </td>
                                                                        <td align="center" valign="bottom" style="margin-bottom: 0px; padding: 0px;">
                                                                            <a onclick="btnNav_Clicked(3)" onmouseover="image_onmouseover('WalkThrough')" onmouseout="image_onmouseout('WalkThrough')">
                                                                                <img src="../Images/WalkThrough_off.png" alt="Walk" id="WalkThrough" width="35" height="35" /></a>
                                                                        </td>
                                                                        <td valign="bottom" align="center" style="padding: 0px;">
                                                                            <a onclick="btnNav_Clicked(1)" onmouseover="image_onmouseover('LookAround')" onmouseout="image_onmouseout('LookAround')">
                                                                                <img src="../Images/LookAround_off.png" alt="Look Around" id="LookAround" width="35"
                                                                                    height="35" /></a>
                                                                        </td>
                                                                        <td align="center" valign="bottom" style="padding: 0px;">
                                                                            <a onclick="btnNav_Clicked(7)" onmouseover="image_onmouseover('Zoom')" onmouseout="image_onmouseout('Zoom')">
                                                                                <img src="../Images/Zoom_off.png" alt="Zoom" id="Zoom" width="35" height="35" /></a>
                                                                        </td>
                                                                        <td align="center" valign="bottom" style="padding: 0px;">
                                                                            <a onclick="btnNav_Clicked(12)" onmouseover="image_onmouseover('ZoomBox')" onmouseout="image_onmouseout('ZoomBox')">
                                                                                <img src="../Images/ZoomBox_off.png" alt="Zoom Box" id="ZoomBox" width="35" height="35" /></a>
                                                                        </td>
                                                                        <td align="center" valign="bottom" style="padding: 0px;">
                                                                            <a onclick="btnNav_Clicked(8)" onmouseover="image_onmouseover('Pan')" onmouseout="image_onmouseout('Pan')">
                                                                                <img src="../Images/Pan_off.png" alt="Pan" id="Pan" width="35" height="35" /></a>
                                                                        </td>
                                                                        <td align="center" valign="bottom" style="padding: 0px;">
                                                                            <a onclick="btnNav_Clicked(11)" onmouseover="image_onmouseover('Orbit')" onmouseout="image_onmouseout('Orbit')">
                                                                                <img src="../Images/Orbit_off.png" alt="Orbit" id="Orbit" width="35" height="35" /></a>
                                                                        </td>
                                                                        <%--<td align="center" valign="bottom" style="padding: 0px;">
                                                                            <a onclick="btnNav_Clicked(2)" onmouseover="image_onmouseover('Examine')" onmouseout="image_onmouseout('Examine')">
                                                                                <img src="../Images/Examine_off.png" alt="Examine" id="Examine" width="35" height="35" /></a>
                                                                        </td>--%>
                                                                        <td align="center" valign="bottom" style="padding: 0px;">
                                                                            <a onclick="btnNav_Clicked(4)" onmouseover="image_onmouseover('Fly')" onmouseout="image_onmouseout('Fly')">
                                                                                <img src="../Images/Fly_off.png" alt="Fly" id="Fly" width="35" height="35" /></a>
                                                                        </td>
                                                                        <td align="center" valign="bottom" style="padding: 0px;">
                                                                            <a onclick="btnNav_Clicked(5)" onmouseover="image_onmouseover('TurnTable')" onmouseout="image_onmouseout('TurnTable')">
                                                                                <img src="../Images/TurnTable_off.png" alt="Turn Table" id="TurnTable" width="35"
                                                                                    height="35" /></a>
                                                                        </td>
                                                                        <td align="center" valign="bottom" style="padding: 0px;">
                                                                            <a onclick="reset_transperency()" onmouseover="image_onmouseover('ResetModel')" onmouseout="image_onmouseout('ResetModel')">
                                                                                <img src="../Images/ResetModel_off.png" alt="Reset Model" id="ResetModel" width="35"
                                                                                    height="35" /></a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                        <td align="left" style="padding-left: 15px;">
                                                            <asp:UpdatePanel runat="server" ID="UpdatePanel2" UpdateMode="Conditional">
                                                                <ContentTemplate>
                                                                    <asp:Panel ID="pnlDataButtons" runat="server" GroupingText="Data" CssClass="pnlNavigation">
                                                                        <table border="0" style="border-collapse: collapse; margin-top: -1px; margin-bottom: -5px"
                                                                            cellpadding="3" cellspacing="3">
                                                                            <tr>
                                                                                <td style="padding: 0px;">
                                                                                    <asp:ImageButton ID="btn_search" ToolTip="Link to data" Style="cursor: default;"
                                                                                        ImageUrl="~/App/Images/LinkData_off.png" onmouseover="LinkData_onmouseover()"
                                                                                        onmouseout="LinkData_onmouseout()" runat="server" OnClientClick="javascript:check_Numeric_Id()"
                                                                                        Width="35" Height="35" />
                                                                                </td>
                                                                                <td style="padding: 0px;">
                                                                                    <asp:ImageButton ID="btn_groupSelection" ToolTip="Group Selection" Style="cursor: default;"
                                                                                        ImageUrl="~/App/Images/GroupSelection_off.png" onmouseover="GroupSelection_onmouseover()"
                                                                                        Width="35" Height="35" onmouseout="GroupSelection_onmouseout()" runat="server"
                                                                                        OnClientClick="javascript:return enablemultipleselection();" />
                                                                                </td>
                                                                                <td style="padding: 0px;">
                                                                                   <%-- <asp:ImageButton ID="btn_open_doc_popup" ToolTip="Add Document" style="cursor: default;" ImageUrl="~/App/Images/add-doc.png" onmouseover="AddDocument_onmouseover()"
                                                                                    onmouseout="AddDocument_onmouseout()" runat="server" OnClientClick="javascript:load_popup(this);" Width="35" Height="35" />--%>
                                                                                    <asp:ImageButton ID="btn_open_doc_popup" pk_document_id='00000000-0000-0000-0000-000000000000' ToolTip="Add Document" style="cursor: default;" ImageUrl="~/App/Images/Add_doc_over.png" onmouseover="AddDocument_onmouseover()"
                                                                                              onmouseout="AddDocument_onmouseout()" runat="server" OnClientClick="javascript:load_popup(this);"  Width="35" Height="35" />
                                                                                    
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div id="tdObj" runat="server" align="left" style="width: 100%; border: 0; height: 100%;">
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                       <asp:Label ID="lblmiddlepane" Text="" style="display:none;" runat="server"></asp:Label>
                                </telerik:RadPane>
                            </telerik:RadSplitter></telerik:RadPane>


                        <telerik:RadSplitBar ID="RadSplitBar2" Skin="Forest" Visible="true" Width="0px" ResizeWithParentPane="true"
                            runat="server">
                        </telerik:RadSplitBar>
                        <telerik:RadPane Height="100%" Collapsed="true" Width="25%" Scrolling="None" runat="server"
                            ID="RightPane">
                            <asp:UpdatePanel runat="server" ID="attribute_panel" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                <ContentTemplate>
                                    <telerik:RadDockLayout ID="RadDockLayout1" runat="server" EnableViewState="true"
                                        Skin="Forest">
                                        <telerik:RadDockZone BorderWidth="0" ID="right_dock_zone" runat="server" Orientation="Vertical">
                                            <telerik:RadDock BorderWidth="0" ID="rdk_asset" runat="server" Title="<%$Resources:Resource, Asset%>"
                                                OnClientInitialize="DockInit" EnableAnimation="true" EnableRoundedCorners="true"
                                                Style="overflow-x: hidden;" EnableDrag="false" Resizable="true" DockHandle="TitleBar"
                                                ForbiddenZones="left_dock_zone,rz_opc">
                                                <ContentTemplate>
                                                    <telerik:RadGrid ID="rgcomponent" BorderStyle="None" Style="height: 94%" Skin="Forest"
                                                        runat="server" AutoGenerateColumns="False" AllowSorting="True" MasterTableView-TableLayout="Fixed"
                                                        ClientSettings-Resizing-AllowColumnResize="true" OnColumnCreated="rgcomponent_OnColumnCreated"
                                                        OnItemCreated="rgcomponent_OnItemCreated" ClientSettings-Resizing-AllowRowResize="false"
                                                        ClientSettings-Scrolling-AllowScroll="true" OnItemCommand="rgcomponent_OnItemCommand"
                                                        OnSortCommand="rgcomponent_OnSortCommand" GridLines="None" OnItemDataBound="rgcomponent_OnItemDataBound"
                                                        OnPreRender="rgcomponent_OnPreRender">
                                                        <ClientSettings AllowDragToGroup="true">
                                                            <DataBinding EnableCaching="true">
                                                            </DataBinding>
                                                            <DataBinding EnableCaching="true">
                                                            </DataBinding>
                                                            <Selecting AllowRowSelect="true" />
                                                            <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                        </ClientSettings>
                                                        <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" EditMode="EditForms"
                                                            Width="100%" DataKeyNames="id,pk_unit_of_measurement_id">
                                                            <GroupByExpressions>
                                                                <telerik:GridGroupByExpression>
                                                                    <SelectFields>
                                                                        <telerik:GridGroupByField FieldAlias="Group" FieldName="Group_Name"></telerik:GridGroupByField>
                                                                    </SelectFields>
                                                                    <GroupByFields>
                                                                        <telerik:GridGroupByField FieldName="Group_Name"></telerik:GridGroupByField>
                                                                    </GroupByFields>
                                                                </telerik:GridGroupByExpression>
                                                            </GroupByExpressions>
                                                            <GroupHeaderItemStyle Width="1%" />
                                                            <RowIndicatorColumn Visible="True">
                                                            </RowIndicatorColumn>
                                                            <Columns>
                                                                <telerik:GridEditCommandColumn ButtonType="ImageButton" CancelText="Cancel" ItemStyle-Width="0px"
                                                                    UniqueName="EditCommandColumn" UpdateText="Update">
                                                                    <HeaderStyle Font-Size="Smaller" Width="6%" Wrap="false" />
                                                                    <ItemStyle Width="5%" Wrap="false" />
                                                                </telerik:GridEditCommandColumn>
                                                                <telerik:GridBoundColumn DataField="attribute_name" HeaderText="<%$Resources:Resource, Parameter%>"
                                                                    ReadOnly="true" UniqueName="parameter" Visible="true">
                                                                    <HeaderStyle Width="30%" Wrap="false" />
                                                                    <ItemStyle Width="30%" Wrap="false" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="attribute_value" HeaderText="<%$Resources:Resource, Value%>"
                                                                    Visible="true" UniqueName="Atrr_value">
                                                                    <HeaderStyle Width="70%" Wrap="false" />
                                                                    <ItemStyle Width="70%" Wrap="false" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="UOM" HeaderText="<%$Resources:Resource, UOM%>"
                                                                    ReadOnly="true" UniqueName="Atrr_UOM" Visible="false">
                                                                    <HeaderStyle Width="0%" Wrap="false" />
                                                                    <ItemStyle Width="0%" Wrap="false" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="Group_Name" Display="false" HeaderText="group_name"
                                                                    ReadOnly="true" Visible="false">
                                                                    <HeaderStyle Wrap="false" />
                                                                    <ItemStyle Wrap="false" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="table_name" HeaderText="tbl_name" ReadOnly="true"
                                                                    Visible="false">
                                                                    <HeaderStyle Wrap="false" />
                                                                    <ItemStyle Wrap="false" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="read_only_flag" HeaderText="read_only_flag" ReadOnly="true"
                                                                    Visible="false">
                                                                    <HeaderStyle Wrap="false" />
                                                                    <ItemStyle Wrap="false" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="id" HeaderText="ID" Visible="false" ReadOnly="true">
                                                                    <HeaderStyle Wrap="false" />
                                                                    <ItemStyle Wrap="false" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridTemplateColumn UniqueName="remove" SortExpression="Remove" ItemStyle-HorizontalAlign="Center"
                                                                    HeaderText="<%$Resources:Resource, Remove%>" Visible="false">
                                                                    <HeaderStyle Width="0%" HorizontalAlign="Center" />
                                                                    <ItemStyle CssClass="column" Width="0%" />
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" runat="server"
                                                                            Width="14px" CommandName="delete" OnClientClick="javascript:return delete_attribute();" />
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                            </Columns>
                                                            <EditFormSettings>
                                                                <EditColumn UniqueName="EditCommandColumn1">
                                                                </EditColumn>
                                                            </EditFormSettings>
                                                            <GroupHeaderItemStyle Width="1%" />
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </ContentTemplate>
                                                </telerik:RadDock>
                                                 <telerik:RadDock BorderWidth="0" ID="rdk_system_attributes" runat="server" Title="<%$Resources:Resource, System%>"
                                                OnClientInitialize="DockInit" EnableAnimation="true" EnableRoundedCorners="true" Closed="true"
                                                Style="overflow-x: hidden;" EnableDrag="true" Resizable="true" DockHandle="TitleBar"
                                                ForbiddenZones="left_dock_zone,rz_opc">
                                                <ContentTemplate>
                                                    <telerik:RadGrid ID="rgSystemAttributes" BorderStyle="None" Style="height: 94%" Skin="Forest"
                                                        runat="server" AutoGenerateColumns="False" AllowSorting="True" MasterTableView-TableLayout="Fixed"
                                                        ClientSettings-Resizing-AllowColumnResize="true" OnItemCreated="rgcomponent_OnItemCreated"
                                                        ClientSettings-Resizing-AllowRowResize="false" ClientSettings-Scrolling-AllowScroll="true" GridLines="None"
                                                         OnItemCommand="rgSystemAttributes_OnItemCommand" 
                                                         OnColumnCreated="rgSystemAttributes_OnColumnCreated"  OnItemDataBound="rgSystemAttributes_OnItemDataBound"
                                                        OnPreRender="rgSystemAttributes_OnPreRender">
                                                        <ClientSettings AllowDragToGroup="true">
                                                            <DataBinding EnableCaching="true">
                                                            </DataBinding>
                                                            <DataBinding EnableCaching="true">
                                                            </DataBinding>
                                                            <Selecting AllowRowSelect="true" />
                                                            <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                        </ClientSettings>
                                                        <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" EditMode="EditForms"
                                                            Width="100%" DataKeyNames="pk_system_attribute_id, attribute_name">
                                                            <GroupByExpressions>
                                                                <telerik:GridGroupByExpression>
                                                                    <SelectFields>
                                                                        <telerik:GridGroupByField FieldAlias="Group" FieldName="group_name"></telerik:GridGroupByField>
                                                                    </SelectFields>
                                                                    <GroupByFields>
                                                                        <telerik:GridGroupByField FieldName="group_name"></telerik:GridGroupByField>
                                                                    </GroupByFields>
                                                                </telerik:GridGroupByExpression>
                                                            </GroupByExpressions>
                                                            <GroupHeaderItemStyle Width="1%" />
                                                            <RowIndicatorColumn Visible="True">
                                                            </RowIndicatorColumn>
                                                            <Columns>
                                                                <telerik:GridEditCommandColumn ButtonType="ImageButton" CancelText="Cancel" ItemStyle-Width="0px"
                                                                    UniqueName="EditCommandColumn" UpdateText="Update">
                                                                    <HeaderStyle Font-Size="Smaller" Width="6%" Wrap="false" />
                                                                    <ItemStyle Width="5%" Wrap="false" />
                                                                </telerik:GridEditCommandColumn>
                                                                <telerik:GridBoundColumn DataField="attribute_name" HeaderText="<%$Resources:Resource, Parameter%>"
                                                                    ReadOnly="true" UniqueName="parameter" Visible="true">
                                                                    <HeaderStyle Width="30%" Wrap="false" />
                                                                    <ItemStyle Width="30%" Wrap="false" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="attribute_value" HeaderText="<%$Resources:Resource, Value%>"
                                                                    Visible="true" UniqueName="Atrr_value">
                                                                    <HeaderStyle Width="70%" Wrap="false" />
                                                                    <ItemStyle Width="70%" Wrap="false" />
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                            <EditFormSettings>
                                                                <EditColumn UniqueName="EditCommandColumn1">
                                                                </EditColumn>
                                                            </EditFormSettings>
                                                            <GroupHeaderItemStyle Width="1%" />
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </ContentTemplate>
                                            </telerik:RadDock>
                                                <telerik:RadDock BorderWidth="0" ID="rdk_type" runat="server" Title="<%$Resources:Resource, Type%>"
                                                    OnClientInitialize="DockInit" EnableAnimation="true" EnableRoundedCorners="true"
                                                    EnableDrag="false" Resizable="true" DockHandle="TitleBar" ForbiddenZones="left_dock_zone,rz_opc">
                                                    <contenttemplate>
                                                            <telerik:RadGrid ID="rgtype" BorderStyle="None" Style="height: 94%" Skin="Forest"
                                                                runat="server" AutoGenerateColumns="False" AllowSorting="True" MasterTableView-TableLayout="Fixed"
                                                                   OnColumnCreated="rgtype_OnColumnCreated" OnItemCreated="rgtype_OnItemCreated"
                                                                ClientSettings-Resizing-AllowColumnResize="true" ClientSettings-Resizing-AllowRowResize="false"
                                                                ClientSettings-Scrolling-AllowScroll="true" OnSortCommand="rgtype_OnSortCommand" OnItemCommand="rgtype_OnItemCommand" GridLines="None" CellSpacing="0"
                                                                OnItemDataBound="rgtype_OnItemDataBound" OnPreRender="rgtype_OnPreRender">
                                                                <ClientSettings AllowDragToGroup="true">
                                                                    <DataBinding EnableCaching="true">
                                                                    </DataBinding>
                                                                    <DataBinding EnableCaching="true">
                                                                    </DataBinding>
                                                                    <Selecting AllowRowSelect="true" />
                                                                    <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                                    <Resizing AllowColumnResize="True" />
                                                                </ClientSettings>
                                                                <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" EditMode="EditForms"
                                                                    GroupHeaderItemStyle-BorderWidth="20px" DataKeyNames="id,pk_unit_of_measurement_id">
                                                                    <GroupByExpressions>
                                                                        <telerik:GridGroupByExpression>
                                                                            <SelectFields>
                                                                                <telerik:GridGroupByField   FieldAlias="Group" FieldName="Group_Name"></telerik:GridGroupByField>
                                                                            </SelectFields>
                                                                            <GroupByFields>
                                                                                <telerik:GridGroupByField     FieldName="Group_Name"></telerik:GridGroupByField>
                                                                            </GroupByFields>
                                                                        </telerik:GridGroupByExpression>
                                                                    </GroupByExpressions>
                                                                    <RowIndicatorColumn Visible="True">
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>
                                                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" CancelText="<%$Resources:Resource, Cancel%>" ItemStyle-Width="0px"
                                                                            UniqueName="EditCommandColumn" UpdateText="<%$Resources:Resource, Update%>">
                                                                            <HeaderStyle Font-Size="Smaller" Width="6%" Wrap="false" />
                                                                            <ItemStyle Width="5%" Wrap="false" />
                                                                        </telerik:GridEditCommandColumn>
                                                                        <telerik:GridBoundColumn DataField="attribute_name" HeaderText="<%$Resources:Resource, Parameter%>" ReadOnly="true"
                                                                            UniqueName="parameter" Visible="true">
                                                                            <HeaderStyle Width="30%" Wrap="false" />
                                                                            <ItemStyle Width="30%" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="attribute_value" HeaderText="<%$Resources:Resource, Value%>" Visible="true" UniqueName="Atrr_value">
                                                                            <HeaderStyle Width="70%" Wrap="false" />
                                                                            <ItemStyle Width="70%" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="UOM" HeaderText="<%$Resources:Resource, UOM%>" ReadOnly="true"  UniqueName="Atrr_UOM" Visible="false">
                                                                            <HeaderStyle Width="0%" Wrap="false" />
                                                                            <ItemStyle Width="0%" Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="group_Name" Display="false" HeaderText="group_name"
                                                                            ReadOnly="true" Visible="false">
                                                                            <HeaderStyle Wrap="false" />
                                                                            <ItemStyle Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="table_name" HeaderText="tbl_name" ReadOnly="true"
                                                                            Visible="false">
                                                                            <HeaderStyle Wrap="false" />
                                                                            <ItemStyle Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="read_only_flag" HeaderText="read_only_flag" ReadOnly="true"
                                                                            Visible="false">
                                                                            <HeaderStyle Wrap="false" />
                                                                            <ItemStyle Wrap="false" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="id" HeaderText="ID" Visible="false" ReadOnly="true">
                                                                            <HeaderStyle Wrap="false" />
                                                                            <ItemStyle Wrap="false" />
                                                                        </telerik:GridBoundColumn>

                                                                         <telerik:GridTemplateColumn  UniqueName="remove" SortExpression="Remove" ItemStyle-HorizontalAlign="Center" Visible="false" 
                                                                            HeaderText="<%$Resources:Resource, Remove%>">
                                                                            <HeaderStyle Width="0%" HorizontalAlign="Center"   />
                                                                            <ItemStyle CssClass="column"  Width="0%"/>
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" runat="server" Width="14px"
                                                                                    CommandName="delete" OnClientClick="javascript:return delete_attribute();" />
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>

                                                                    </Columns>
                                                                    <EditFormSettings>
                                                                        <EditColumn UniqueName="EditCommandColumn1">
                                                                        </EditColumn>
                                                                    </EditFormSettings>
                                                                    <GroupHeaderItemStyle Width="10px" />
                                                                </MasterTableView><FilterMenu EnableImageSprites="False">
                                                                </FilterMenu>
                                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Forest">
                                                                </HeaderContextMenu>
                                                            </telerik:RadGrid>
                                                       </contenttemplate>
                                                </telerik:RadDock>
                                                <telerik:RadDock BorderWidth="0" ID="rdk_document" runat="server" Title="<%$Resources:Resource, Document%>"
                                                    OnClientInitialize="DockInit" EnableAnimation="true" EnableRoundedCorners="true"
                                                    EnableDrag="false" Resizable="true" DockHandle="TitleBar" ForbiddenZones="left_dock_zone,rz_opc">
                                                    <contenttemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td align="left">
                                                                        <%--<asp:Button SkinID="Forest" runat="server" Text="<%$Resources:Resource, Add_Document%>" pk_document_id='00000000-0000-0000-0000-000000000000'
                                                                            OnClientClick="javascript:load_popup(this);" ID="btn_open_doc_popup" />--%>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <telerik:RadGrid ID="rgdocument" runat="server" AutoGenerateColumns="false" AllowSorting="true"
                                                                ClientSettings-Resizing-AllowColumnResize="true" MasterTableView-TableLayout="Auto" OnSortCommand="rgdocument_OnSortCommand"
                                                                AllowPaging="false" ClientSettings-Scrolling-AllowScroll="true" Skin="Forest" OnItemCommand="rg_document_item_command">
                                                                <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                                                <ClientSettings AllowDragToGroup="true">
                                                                    <Selecting AllowRowSelect="true" />
                                                                     <Selecting AllowRowSelect="true" />
                                                                    <Scrolling AllowScroll="false" UseStaticHeaders="true" />
                                                                    <Resizing AllowColumnResize="True" />
                                                               </ClientSettings>
                                                                <MasterTableView DataKeyNames="document_id,entity_name" TableLayout="Fixed" GroupLoadMode="Client">
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn DataField="document_id" HeaderText="ID" Visible="false">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridTemplateColumn DataField="document_name" HeaderText="<%$Resources:Resource, Document_Name%>">
                                                                             <ItemStyle CssClass="column" Width="60%" />
                                                                                <HeaderStyle Width="60%"/>
                                                                            <ItemTemplate>
                                                                                <asp:HyperLink ID="hlnkDocName" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"file_path")%>'
                                                                                    Text='<%# DataBinder.Eval(Container.DataItem,"document_name")%>' runat="server"
                                                                                    Target="_blank"></asp:HyperLink></ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn DataField="document_id">
                                                                            <ItemStyle CssClass="column" />
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkEdit" Visible="true" runat="server" CausesValidation="false"
                                                                                    OnClientClick="javascript:return load_popup(this);" Text="Edit" pk_document_id='<%# DataBinder.Eval(Container.DataItem,"document_id")%>' entity_name='<%# DataBinder.Eval(Container.DataItem,"entity_name")%>'>
                                                                                </asp:LinkButton></ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                          <telerik:GridBoundColumn DataField="entity_name" HeaderText="">
                                                                            <ItemStyle CssClass="column"/>

                                                                        </telerik:GridBoundColumn>

                                                                           <telerik:GridTemplateColumn  UniqueName="remove" SortExpression="Remove" ItemStyle-HorizontalAlign="Left"
                                                                            HeaderText="<%$Resources:Resource, Remove%>"  Visible="false">
                                                                            <HeaderStyle Width="20%" HorizontalAlign="Left"   />
                                                                            <ItemStyle CssClass="column"  Width="20%"/>
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="imgbtnremove" ImageUrl="~/App/Images/Buttons/Delete.gif" runat="server"
                                                                                    CommandName="delete"  />
                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>

                                                                    </Columns>
                                                                </MasterTableView></telerik:RadGrid>
                                                      
                                                </contenttemplate>
                                            </telerik:RadDock>
                                        </telerik:RadDockZone>
                                    </telerik:RadDockLayout>
                                    <asp:Label ID="lbl_sliding" Text="" Style="display: none;" runat="server"></asp:Label></ContentTemplate>
                            </asp:UpdatePanel>
                        </telerik:RadPane>
                    </telerik:RadSplitter>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td style="display:none";> 
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Button ID="btn_properties" runat="server" OnClick="btn_properties_click" />
                            <asp:Button ID="btn_refresh_asset" runat="server" OnClick="btn_refresh_asset_click" />
                            <asp:HiddenField ID="hf_component_id" runat="server" />
                            <asp:HiddenField ID="hdnpropertystatus" runat="server" />
                            <asp:HiddenField ID="hdnmultipleasset" runat="server" />
                            <asp:HiddenField ID="hdn_asset_id" runat="server" />
                            <asp:HiddenField ID = "hf_assetTab" runat="server" />
                              <asp:HiddenField ID="hf_type_id" runat="server" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
         <table>
            <tr>
                <td>
                    <telerik:RadNotification ID="RadNotification3" runat="server" Width="240" Height="400"
                        Animation="Resize" ShowCloseButton="false" Position="MiddleLeft" EnableRoundedCorners="true"
                        EnableShadow="true" Skin="Office2010Black" AutoCloseDelay="0" Style="z-index: 35001"
                        Title="Selected Assets">
                        <ContentTemplate>
                           <%-- <table>
                                <tr>
                                    <td style="font-size: medium; color: White;">
                                        <telerik:RadListBox ID="radlstassetsforspace" runat="server" CheckBoxes="true" Width="230"
                                            Height="340px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="btn_assign" runat="server" Width="50%" OnClientClick="javascript:return assignspacepopup()"
                                            Text="<%$Resources:Resource,Assign_Space%>" />
                                    </td>
                                </tr>
                            </table>--%>
                             <div id="div2" style="height:340; overflow-y:auto; overflow-x:hidden;">
                                        <telerik:RadListBox ID="radlstassetsforspace" runat="server" CheckBoxes="true" Width="230"
                                                Height="340" />
                             </div>
                            <div>
                             <asp:button id="btn_assign" runat="server" width="50%" onclientclick="javascript:return assignspacepopup()"
                                                text="<%$Resources:Resource,Assign_Space%>" />
                             <div>
                        </ContentTemplate>
                    </telerik:RadNotification>
                </td>
            </tr>
        </table>
        <telerik:RadWindowManager Visible="true" ID="rad_window" VisibleStatusbar="false"
            AutoSize="false" EnableShadow="true" ShowOnTopWhenMaximized="false" runat="server"
            KeepInScreenBounds="true">
            <Windows>
                <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" Animation="Slide"
                    KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="true" AutoSize="false"
                    Width="600" Height="400" VisibleStatusbar="false" VisibleOnPageLoad="false" Skin="Forest"
                    Title="EcoDomus PM: Add Document">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>

        <asp:HiddenField ID="hfViewName" runat="server" />
        <asp:HiddenField ID="hf_system_id" runat="server" />
        <asp:HiddenField ID="hidden_view_name" runat="server" />
        <asp:HiddenField ID="hidden_Object_code" runat="server" />
        <asp:HiddenField ID="PK_element_Numeric_ID" runat="server" />
        <asp:HiddenField ID="hf_entity_handle" runat="server" />
        <asp:HiddenField ID="hf_category" runat="server" />
        <asp:HiddenField ID="hf_layer" runat="server" />
        <asp:HiddenField ID="hf_guid" runat="server" />
        <asp:HiddenField ID="hf_strElementName" runat="server" />
        <asp:HiddenField ID="hf_TypeID" runat="server" />
        <asp:HiddenField ID="str_element_ID" runat="server" />
        <asp:HiddenField ID="hfSpaceElementNumericId" runat="server" />
        <asp:HiddenField ID="hf_cb_attribute_id" runat="server" />
        <asp:HiddenField ID="hf_cb_attribute_id_1" runat="server" />
        <asp:HiddenField ID="hf_work_order_id" runat="server" />
        <asp:HiddenField ID="hf_dock_num" runat="server" />
        <asp:HiddenField ID="comp_element_id" runat="server" />
        <asp:HiddenField ID="pk_location_id" runat="server" />
        <asp:HiddenField ID="hdn_system_component" runat="server" />
        <asp:HiddenField ID="hf_location_id" runat="server" />
        <asp:HiddenField ID="hf_entity" runat="server" />
        <asp:HiddenField ID="hdn_conn_string" runat="server" />
        <asp:HiddenField ID="hdnrevitautocad" runat="server" />
        <asp:HiddenField ID="hdnfacilityid" runat="server" />
        <asp:HiddenField ID="hdnsystemid" runat="server" />
      

          <asp:HiddenField ID="hf_RestServiceUrl" runat="server" />
          <asp:HiddenField ID="hdngroupselctionflag" runat="server" />
           <asp:HiddenField ID="hf_client_con_string" runat="server" />
           <asp:HiddenField ID="hf_btnback_flag" runat="server" />
        <asp:Label ID="lblasset" runat="server" Text="<%$Resources:Resource, Asset%>" Visible="false"></asp:Label>
        <asp:Label ID="lblspace" runat="server" Text="<%$Resources:Resource, Space%>" Visible="false"></asp:Label>


           <asp:HiddenField ID="hf_file_id" runat="server" />
           <div id="divbtn" style="display: none;">
            <asp:Button ID="btn_refresh"  runat="server" Style="display:none;"   OnClick="btn_refresh_Click" />
            <asp:Button ID="btn_system_assets" runat="server" Style="display: none;" OnClick="btn_system_assets_Click" />
            </div>
        <telerik:RadCodeBlock  runat="server">
            <script type="text/javascript">
                function check_Numeric_Id() {
                    var oPath;
                    var m_state;
                    var Gutcolls;
                    var attribute;
                    var node1;
                    m_state = document.NWControl01.State;
                    var xyz;
                    try {
                        if (document.NWControl01.State.CurrentSelection.Paths().Count != 0) {
                            oPath = document.NWControl01.State.CurrentSelection.Paths(1);
                            xyz = m_state.GetGUIPropertyNode(oPath, false);
                            Gutcolls = xyz.GUIAttributes();
                            //get_element(Gutcolls);
                            //var Elementnumericid = document.getElementById("PK_element_Numeric_ID").value;
                            // get the element External System Id
                            // use the method get_external_system_element_id on javascript instead of get_element on VBscript which is hard to debug
                            var Elementnumericid = get_external_system_element_id(Gutcolls);
                            document.getElementById("PK_element_Numeric_ID").value = Elementnumericid;
                        }

                        if (Elementnumericid != "" && Elementnumericid != null) {

                           if (document.getElementById('hf_category').value == "Floors" || document.getElementById('hf_layer').value == "PLATFORM" || document.getElementById('hf_layer').value == "C134-OVE-S-DMA-N105_F-20036 - G2221-M_Floors suspended slabs reinforced concrete") {//|| document.getElementById('hf_category').value == "Generic Models"
                                openfacilityspacesLinktodata();
                            }
                            else {
                                openfacilityassets();
                            }
                        }
                        else {
                            alert("Please select Asset to link");
                            return false;
                        }
                    }
                    catch (err) {
                        var error = err.description
                        if (error == "<<NavisWorks Error - Invalid index>>") {


                        }
                        else {
                            alert(err.description);
                        }

                    }

                }
              
            </script>
        </telerik:RadCodeBlock>
        <script type="text/javascript">
            var selected_view_pt;
            var jump_on_systemComponent = "";
            var allDocks = [];



            function expand_property() {
               
            }

            function open_search_documentpopup() {
                var dockSearch = $find("<%= RadDock5.ClientID %>");
                dockSearch.set_collapsed(false);
                return false;
            }



            function Bind_asset() {

                document.getElementById("btn_properties").click();

            }


            function refresh_asset_grid() {

                document.getElementById("btn_refresh_asset").click();
            }
            function Validate() {


                document.getElementById("btn_properties").click();
                return false;

            }


            function RowDblClick(sender, eventArgs) {
                editedRow = eventArgs.get_itemIndexHierarchical();
                $find("<%= rgcomponent.ClientID %>").get_masterTableView().editItem(editedRow);
            }

            function DockCommand(dock, args) {

                var cnt;
                var cnt1 = 0;
                var flag = 0;

                var commandName = args.command.get_name();

                if (commandName = "ExpandCollapse") {


                    for (var j = 0; j < allDocks.length; j++) {
                        if (allDocks[j].get_collapsed() == false) {
                            cnt1 = cnt1 + 1;
                        }
                    }


                    if (dock.get_collapsed() == false && (cnt1 >= 3)) {


                        for (var i = 0; i < allDocks.length; i++) {

                            if (allDocks[i] != dock) {


                                if (allDocks[i].get_collapsed() == false) {

                                    if (document.getElementById('hf_dock_num').value == i) {

                                    }
                                    else {
                                        if (flag == 0 && allDocks[i]._uniqueID != "rdk_asset" && allDocks[i]._uniqueID != "rdk_system_attributes" && allDocks[i]._uniqueID != "rdk_type" && allDocks[i]._uniqueID != "rdk_document" && allDocks[i]._uniqueID != "RadDock1") {
                                            allDocks[i].set_collapsed(true);
                                            flag = 1;
                                        }
                                    }
                                }
                            }
                            else {
                                document.getElementById('hf_dock_num').value = i;
                            }

                        }
                    }
                }

            }


            function gotoPage(workorderid, workorder) {

                var left = (window.screen.width / 2) - (700 / 2);
                var top = (window.screen.height / 2) - (700 / 2);
                var url = "../Settings/WorkOrderProfileModelview.aspx?Work_order_id=" + workorderid + "";
                window.open(url, '', 'width=700px,height=550px,scrollbars=yes,top=' + top + ', left=' + left);

            }

            function openfacilityassets() {

                var left = (window.screen.width / 2) - (700 / 2);
                var top = (window.screen.height / 2) - (700 / 2);
                var url = "../Settings/facilityassets.aspx?element_numeric_id=" + document.getElementById("PK_element_Numeric_ID").value + "&file_id=" + document.getElementById("hf_file_id").value + "&facility_id=" + document.getElementById("hdnfacilityid").value + "" + "&properties=" + document.getElementById("hdnpropertystatus").value + "";
                window.open(url, '', 'width=980px,height=550px,scrollbars=yes,Resizable=yes,top=' + top + ', left=' + left);

            }

            function openfacilityspacesLinktodata() {

                var left = (window.screen.width / 2) - (700 / 2);
                var top = (window.screen.height / 2) - (700 / 2);
                var url = "../Settings/LinkToSpace.aspx?element_numeric_id=" + document.getElementById("PK_element_Numeric_ID").value + "&file_id=" + document.getElementById("hf_file_id").value + "&facility_id=" + document.getElementById("hdnfacilityid").value + "" + "&properties=" + document.getElementById("hdnpropertystatus").value + "";
                window.open(url, '', 'width=700px,height=550px,scrollbars=yes,Resizable=yes,top=' + top + ', left=' + left);

            }

              function load_popup(reg) {
                  if (document.getElementById("hf_category").value == "System") {
                      document.getElementById('btn_open_doc_popup').src = "../Images/Add_doc_on.png";
                    var url = "../Locations/AddDocument.aspx?fk_row_id=" + document.getElementById("hf_system_id").value + "&Document_Id=" + reg.pk_document_id + "&Flag=Model" + "&Item_type=System";
                    window.open(url, '', 'width=700px,height=400px');
                }
                else {
                    document.getElementById('btn_open_doc_popup').src = "../Images/Add_doc_on.png";
                    var IsAsset = document.getElementById("hf_assetTab").value;
                    if (document.getElementById("hf_component_id").value != "" && document.getElementById("hf_category").value != "Floors" && ((document.getElementById("hf_layer").value != "PLATFORM" && document.getElementById("hf_layer").value != "C134-OVE-S-DMA-N105_F-20036 - G2221-M_Floors suspended slabs reinforced concrete" && document.getElementById("hf_category").value == "Generic Models") || document.getElementById("hf_category").value != "Generic Models"))//category is not floor for asset  || document.getElementById("hf_category").value == "Generic Models"
                    {

                        document.getElementById("hf_entity").value = "Asset";
                       
                        //var url = "../Locations/AddDocument.aspx?fk_row_id=" + document.getElementById("hf_component_id").value + "&Document_Id=00000000-0000-0000-0000-000000000000" + "&Flag=Model" + "&Item_type=Asset";
                        var url = "../Locations/AddDocument.aspx?fk_row_id=" + document.getElementById("hf_component_id").value + "&Document_Id=" + reg.pk_document_id + "&Flag=Model" + "&Item_type=Asset" + "&entity_name=type&entity_id=" + document.getElementById("hf_type_id").value;
                        window.open(url, '', 'width=700px,height=400px');
                    }


                    else if (document.getElementById("hf_component_id").value != "" && (document.getElementById("hf_category").value == "Floors" || document.getElementById("hf_layer").value == "PLATFORM" || document.getElementById("hf_layer").value == "C134-OVE-S-DMA-N105_F-20036 - G2221-M_Floors suspended slabs reinforced concrete" || document.getElementById("hf_category").value != "Generic Models") || document.getElementById("hf_category").value == "Space")//category is floor for space
                    {
                        document.getElementById('btn_open_doc_popup').src = "../Images/Add_doc_on.png";

                        document.getElementById("hf_entity").value = "Floor";
                        var url = "../Locations/AddDocument.aspx?fk_row_id=" + document.getElementById("hf_component_id").value + "&Document_Id=" + reg.pk_document_id + "&Flag=Model" + "&Item_type=Space";
                        window.open(url, '', 'width=700px,height=400px');
                    }

                    else//I am not responsible other than floor
                    {
                        document.getElementById('btn_open_doc_popup').src = "../Images/Add_doc_on.png";
                        if (IsAsset == 'Space') {
                            alert("Please Select the Space ");
                        }
                        else {
                            alert("Please Select the Asset");
                        }
                    }
                }
                return false;
            }
            function regreshgrid() {
                document.getElementById("btn_refresh").click();
            }

            function jump_system_compns_from_proprtydock(systemid) {
               
                document.getElementById("hdnsystemid").value = systemid;
                document.getElementById("btn_system_assets").click();


            }
            function jump_on_comp_by_assetId(assetId) {
               
                document.getElementById("hf_category").value = "Asset";
                document.getElementById("hdn_asset_id").value = assetId;
                document.getElementById("hf_entity").value = "Asset";
                document.getElementById("btn_properties").click();


            }


            // search conditions for navisworks
            // Navis models created from different formats
            // have different property contains ID of the element
            // So, you should not use this ugly comparison
            // document.getElementById("hdnrevitautocad").value == "LcOpDwgEntityAttrib") 
            // any more.
            // For new format, just add the condition
            // the best way is to write the conditions to the XML file or database,
            // But my knowledge of javascript is not enough:(
            function getFindSpecToFindElementInEcoDomusByExternalSystemId(state, id) {
                var findspec = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFindSpec"));

                // AutoCad, Revit
                var findCon1 = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFindCondition"));
                findCon1.StartGroup = false; // for OR condition				
                findCon1.SetAttributeNames("LcOpDwgEntityAttrib");
                findCon1.SetPropertyNames("LcOaNat64AttributeValue");
                findCon1.Condition = state.GetEnum("eFind_EQUAL");
                findCon1.value = id;

                // Second
                var findCon2 = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFindCondition"));
                findCon2.StartGroup = false; // for OR condition				
                findCon2.SetAttributeNames("LcOaPropOverrideCat");
                findCon2.SetPropertyNames("Id");
                findCon2.Condition = state.GetEnum("eFind_EQUAL");
                findCon2.value = id;

                // Third
                var findCon3 = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFindCondition"));
                findCon3.StartGroup = false; // for OR condition
                findCon3.SetAttributeNames("LcRevitId");
                findCon3.SetPropertyNames("LcOaNat64AttributeValue");
                findCon3.Condition = state.GetEnum("eFind_EQUAL");
                findCon3.value = id;

                // Bentley
                var findCon4 = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFindCondition"));
                findCon4.StartGroup = false; // for OR condition
                findCon4.SetAttributeNames("LcDgnElementId");
                findCon4.SetPropertyNames("LcOaNat64AttributeValue");
                findCon4.Condition = state.GetEnum("eFind_EQUAL");
                findCon4.value = id;


                // Ifc
                var findCon5 = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFindCondition"));
                findCon5.StartGroup = false; // for OR condition
                findCon5.SetAttributeNames("LcIFCProperty");
                findCon5.SetPropertyNames("IFCString", "GLOBALID");
                findCon5.Condition = state.GetEnum("eFind_EQUAL");
                findCon5.value = id;

                findspec.Selection.SelectAll();
                findspec.Conditions().add(findCon1);
                findspec.Conditions().add(findCon2);
                findspec.Conditions().add(findCon3);
                findspec.Conditions().add(findCon4);
                findspec.Conditions().add(findCon5);

                // to search everywhere
                findspec.Selection.SelectAll();

                return findspec;
            }


            // call this method when click to the asset at the asset search result window
            function jump_on_comp(id) {
                document.getElementById("hdn_asset_id").value = "";
                var state = document.NWControl01.State;
                state.CurrentSelection.SelectAll();
                state.OverrideTransparency(state.CurrentSelection, 0.8599); // incredible accuracy :-)
                var find = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFind"));

                var findspec = getFindSpecToFindElementInEcoDomusByExternalSystemId(state, id);

                find.FindSpec = findspec;

                var sel = find.FindAll();

                //alert(sel.IsAnyContained(sel));

                state.CurrentSelection = sel;
                state.ZoomInCurViewOnCurSel();
                state.OverrideTransparency(state.CurrentSelection, 0);

                document.getElementById("PK_element_Numeric_ID").value = id;

                var oPath;
                var xyz;
                var Gutcolls;
                var m_state;

                m_state = document.NWControl01.State;
                if (document.NWControl01.State.CurrentSelection.Paths().count > 0) {

                    oPath = document.NWControl01.State.CurrentSelection.Paths(1);
                    xyz = m_state.GetGUIPropertyNode(oPath, false);

                    Gutcolls = xyz.GUIAttributes();

                    // this method is find the id of the element
                    // among navisworks parameters
                    // and something else unclear for me.
                    // I leave this method for a while, 
                    // but should consider to remove it at all.
                    get_element(Gutcolls);

                    // rewrite the value as method get_element may overwrite the value with the wrong value
                    document.getElementById("PK_element_Numeric_ID").value = id;

                    document.getElementById("hf_entity").value = "Asset";

                    if ($find("<%= radockworkorder.ClientID %>") != null) {
                        if ($find("<%= radockworkorder.ClientID %>").get_collapsed() == true) {
                            $find("<%= radockworkorder.ClientID %>").set_collapsed(false);

                        }
                    }

                    // show the asset properties
                    document.getElementById("btn_properties").click();
                }
                else { }
            }



            // call this method when click to the asset at the asset search result window and pass Asset id as well with new version
            function jump_on_comp_v1(id, asset_id) {

                document.getElementById("hdn_asset_id").value = "";
                var state = document.NWControl01.State;
                state.CurrentSelection.SelectAll();
                state.OverrideTransparency(state.CurrentSelection, 0.8599); // incredible accuracy :-)
                var find = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFind"));

                var findspec = getFindSpecToFindElementInEcoDomusByExternalSystemId(state, id);

                find.FindSpec = findspec;

                var sel = find.FindAll();

                //alert(sel.IsAnyContained(sel));

                state.CurrentSelection = sel;
                state.ZoomInCurViewOnCurSel();
                state.OverrideTransparency(state.CurrentSelection, 0);

                document.getElementById("PK_element_Numeric_ID").value = id;
                document.getElementById("hdn_asset_id").value = asset_id;

                var oPath;
                var xyz;
                var Gutcolls;
                var m_state;

                m_state = document.NWControl01.State;
                if (document.NWControl01.State.CurrentSelection.Paths().count > 0) {

                    oPath = document.NWControl01.State.CurrentSelection.Paths(1);
                    xyz = m_state.GetGUIPropertyNode(oPath, false);

                    Gutcolls = xyz.GUIAttributes();

                    // this method is find the id of the element
                    // among navisworks parameters
                    // and something else unclear for me.
                    // I leave this method for a while, 
                    // but should consider to remove it at all.
                    get_element(Gutcolls);

                    // rewrite the value as method get_element may overwrite the value with the wrong value
                    document.getElementById("PK_element_Numeric_ID").value = id;
                    document.getElementById("hdn_asset_id").value = asset_id;
                    document.getElementById("hf_entity").value = "Asset";

                    if ($find("<%= radockworkorder.ClientID %>") != null) {
                        if ($find("<%= radockworkorder.ClientID %>").get_collapsed() == true) {
                            $find("<%= radockworkorder.ClientID %>").set_collapsed(false);

                        }
                    }

                    // show the asset properties
                    document.getElementById("btn_properties").click();
                }
                else {
                    document.getElementById("hdn_asset_id").value = asset_id;
                    document.getElementById("hf_entity").value = "Asset";
                    // show the asset properties
                    document.getElementById("btn_properties").click();
                
                }

            }


            // method called when you click on the space at the space search result
            function jump_on_space_comp(id, pk_location_id) {

                var hf_category = document.getElementById("hf_category").value;
                document.getElementById("hf_category").value = "Floors";

                var state = document.NWControl01.State;
                state.CurrentSelection.SelectAll();
                state.OverrideTransparency(state.CurrentSelection, 0.8599); // incredible accuracy :-)
                var find = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFind"));
                var findspec = getFindSpecToFindElementInEcoDomusByExternalSystemId(state, id);

                find.FindSpec = findspec;
                var sel = find.FindAll();
                state.CurrentSelection = sel;
                state.ZoomInCurViewOnCurSel();
                state.OverrideTransparency(state.CurrentSelection, 0);
                document.getElementById("PK_element_Numeric_ID").value = id;

                var oPath;
                var xyz;
                var Gutcolls;
                var m_state;

                m_state = document.NWControl01.State;

                if (document.NWControl01.State.CurrentSelection.Paths().count > 0) {

                    oPath = document.NWControl01.State.CurrentSelection.Paths(1);
                    xyz = m_state.GetGUIPropertyNode(oPath, false);
                    Gutcolls = xyz.GUIAttributes();

                    // this method is find the id of the element
                    // among navisworks parameters
                    // and something else unclear for me.
                    // I leave this method for a while, 
                    // but shuold consider to remove it at all.
                    get_element(Gutcolls);
                }

                // the space may not be at the model. But as we have space id in ecodomus,
                // we may show the space properties.
                if (pk_location_id != "" || document.NWControl01.State.CurrentSelection.Paths().count > 0) {

                    // rewrite the value as method get_element may overwrite the value with the wrong value
                    document.getElementById("PK_element_Numeric_ID").value = id;

                    document.getElementById("hf_entity").value = "Space";

                    document.getElementById("hf_location_id").value = pk_location_id;
                    document.getElementById("btn_properties").click();
                }


                if ($find("<%= RadDock6.ClientID %>").get_collapsed() == true) {
                    $find("<%= RadDock6.ClientID %>").set_collapsed(false);

                }

                document.getElementById("hf_category").value = hf_category;
            }

            // select all component in the system
            function jump_on_system_components(ElementNumericids) {


                if (ElementNumericids != "") {
                    var SplitResult = ElementNumericids.split(",");

                    var state = document.NWControl01.State;
                    state.CurrentSelection.SelectAll();
                    state.OverrideTransparency(state.CurrentSelection, 0.8599); // incredible accuracy :-)

                    for (i = 0; i < SplitResult.length - 1; i++) {

                        var id = SplitResult[i];

                        var find = state.ObjectFactory(state.GetEnum("eObjectType_nwOpFind"));
                        var findspec = getFindSpecToFindElementInEcoDomusByExternalSystemId(state, id);

                        find.FindSpec = findspec;

                        var sel = find.FindAll();

                        state.CurrentSelection.UniteSelection(sel);

                        if (i == 0)
                            state.CurrentSelection = sel;

                        state.ZoomInCurViewOnCurSel();
                        state.OverrideTransparency(state.CurrentSelection, 0);

                    }


                }
                if ($find("<%= RadDock3.ClientID %>").get_collapsed() == true) {

                    open_sys_comp();
                }


            }



            function open_space_popup() {

                var dockSearch = $find("<%= RadDock6.ClientID %>");
                dockSearch.set_collapsed(false);
            }

            function open_sys_comp() {


                var dockSearch = $find("<%= RadDock3.ClientID %>");
                dockSearch.set_collapsed(false);
                return false;
            }
            function open_comp() {

                var dockSearch = $find("<%= RadDock4.ClientID %>");
                dockSearch.set_collapsed(false);

                var dockBAS = $find("<%= RadDock7.ClientID %>");
                dockBAS.set_collapsed(false);

            }


            function DockInit(dock, args) {
                allDocks[allDocks.length] = dock;
                document.getElementById('hf_dock_num').value = 1;
                dock.set_height((document.body.clientHeight / 2) - 100);
            }

            function ClientNodeClicked(sender, eventArgs) {
                var node = eventArgs.get_node();
                findall(node.get_text());
            }

            function findall(view_point) {


                var view;
                var selected_node;
                selected_view_pt = view_point;


                for (var i = 1; i <= document.NWControl01.State.SavedViews().count; i++) {
                    var view = document.NWControl01.State.SavedViews(i);

                    myrecurse(view, selected_view_pt);
                }
            }


            // function returns element external system id from
            // navisworks attributes and properties
            // use this function instead of get_element on VBScript
            function get_external_system_element_id(attributeColl) {
                for (var i = 1; i <= attributeColl.Count; i++) {

                    var attr = attributeColl.Item(i);
                    var name = attr.ClassUserName.toUpperCase();
                    var className = attr.ClassName.toUpperCase();
                    var props;
                    var k;
                    var prop;
                    var pName;
                    var pVal;

                    //for IFC looking for GLOBALID properties
                    if (name == "IFC") {
                        props = attr.Properties();
                        for (k = 1; k <= props.Count; k++) {
                            prop = props.Item(k);
                            pName = prop.UserName.toUpperCase();
                            pVal = prop.Value;

                            if (pName == "GLOBALID")
                                return pVal;
                        }
                    }

                    if (name == "要素") {
                        props = attr.Properties();
                        for (k = 1; k <= props.Count; k++) {
                            prop = props.Item(k);
                            pName = prop.UserName.toUpperCase();
                            pVal = prop.Value;

                            if (pName == "ID")
                                return pVal;
                        }
                    }
                    if (name == "ELEMENT") {
                        props = attr.Properties();
                        for (k = 1; k <= props.Count; k++) {
                            prop = props.Item(k);
                            pName = prop.UserName.toUpperCase();
                            pVal = prop.Value;

                            if (pName == "ID")
                                return pVal;
                        }
                    }


                    if (name == "ENTITY HANDLE") {
                        props = attr.Properties();
                        for (k = 1; k <= props.Count; k++) {
                            prop = props.Item(k);
                            pName = prop.UserName.toUpperCase();
                            pVal = prop.Value;

                            if (pName == "VALUE")
                                return pVal;
                        }
                    }

                    if (name == "LCDGNELEMENTID" || className == "LCDGNELEMENTID") {
                        props = attr.Properties();
                        for (k = 1; k <= props.Count; k++) {
                            prop = props.Item(k);
                            pName = prop.UserName.toUpperCase();
                            pVal = prop.Value;

                            if (pName == "VALUE")
                                return pVal;
                        }
                    }
                }

                return "";
            }

            // select an object on the viewer
            function select_point() {

                // magic numbers :-)
                // SelectionBehaviour 2 is FirsObject as I remember,
                // What is Paradigm = 6 - it is a mystery
                // !For every one:
                // If you use 'magic' numbers,
                // please explain what they mean in the comment
                if (document.NWControl01.state.CurrentView.ViewPoint.Paradigm == 6) {
                    if ((document.NWControl01.SelectionBehaviour != 2)) {

                        document.NWControl01.SelectionBehaviour = 2;
                        alert("Please Reselect Component");
                        return false;
                    }

                    var oPath;
                    var m_state;
                    var Gutcolls;
                    var attribute;
                    var node1;
                    m_state = document.NWControl01.State;
                    var xyz;
                    try {

                        if (document.NWControl01.State.CurrentSelection.Paths().Count != 0) {

                            // get the first selected object
                            oPath = document.NWControl01.State.CurrentSelection.Paths(1);

                            xyz = m_state.GetGUIPropertyNode(oPath, false);
                            Gutcolls = xyz.GUIAttributes();

                            //--------------------
                            // this is the old workflow
                            // I do not understand the logic
                            // Element numericid is assignment at the get_element method
                            // so, when you click to the object for the first time after you open the model
                            // Elementnumericid always empty.

                            var Elementnumericid = document.getElementById("PK_element_Numeric_ID").value;

                            // seems this method have to be before previous method;
                            // I keep this method call as something unknown in that method;
                            // furthermore 
                            // this method is find the id of the element
                            // among navisworks parameters
                            // and something else unclear for me.
                            // I leave this method for a while, 
                            // but should consider to remove it at all.
                            get_element(Gutcolls);
                            //----------------------

                            // get the element External System Id
                            // use the method get_external_system_element_id on javascript instead of get_element on VBscript which is hard to debug
                            Elementnumericid = get_external_system_element_id(Gutcolls);
                            document.getElementById("PK_element_Numeric_ID").value = Elementnumericid;

                            // magic conditions
                            // Guys please explain unclear and hard conditions
                            // the first condition is always true
                            if (document.getElementById("hf_category").value != "Floors" &&
                                document.getElementById("hf_category").value != "Generic Models" && document.getElementById("hdngroupselctionflag").value == "True") {
                                RestfulResource(document.getElementById("hf_RestServiceUrl").value, document.getElementById("hf_category").value, document.getElementById("PK_element_Numeric_ID").value);

                            }
                            else {

                                document.getElementById("hdn_asset_id").value = "";

                                //show properties of the selected element
                                document.getElementById("btn_properties").click();

                            }

                            // alert(document.getElementById("PK_element_Numeric_ID").value);
                            return true;
                        }
                        else {
                            //  document.body.focus();
                            return true;
                        }

                    }

                    catch (err) {
                        var error = err.description;
                        if (error == "<<NavisWorks Error - Invalid index>>") {
                            // document.body.focus();

                        }
                        else {
                            alert(err.description);
                        }


                    }
                }

                else {
                    // document.body.focus();
                }

            }

            function myrecurse(view, selected_view_pt) {
                var cmd;
                var oOption;
                var eCmd_Play;


                switch (view.Objectname) {


                    case "nwOpView":

                        if (selected_view_pt == view.name) {

                            document.NWControl01.State.ApplyView(view);
                        }


                        break;

                    case "nwOpFolderView":
                        var folder;
                        folder = view;
                        var childview;

                        for (var i = 1; i <= folder.SavedViews().count; i++) {

                            childview = folder.SavedViews(i);
                            myrecurse(childview, selected_view_pt);

                        }
                        break;
                }
            }

            function image_onmouseover(img_name) {
                var oldsrc = document.getElementById(img_name).src;
                if (oldsrc.indexOf(img_name + "_on.png") == -1) {
                    document.getElementById(img_name).src = "../Images/" + img_name + "_over.png";
                }
            }

            function image_onmouseout(img_name) {
                var oldsrc = document.getElementById(img_name).src;
                if (oldsrc.indexOf(img_name + "_on.png") == -1) {
                    document.getElementById(img_name).src = "../Images/" + img_name + "_off.png";
                }
            }

            function Back_onmouseover() {
                var oldsrc = document.getElementById('<%=btnBack.ClientID%>').src;
                if (oldsrc.indexOf('Back_on.png') == -1) {
                    document.getElementById('<%=btnBack.ClientID%>').src = "../Images/Back_over.png";
                }
            }

            function Back_onmouseout() {
                var oldsrc = document.getElementById('<%=btnBack.ClientID%>').src;
                if (oldsrc.indexOf('Back_on.png') == -1) {
                    document.getElementById('<%=btnBack.ClientID%>').src = "../Images/Back_off.png";
                }
            }

            function btnBack_OnClientClick() {
                ResetImages();
                
            }

            function LinkData_onmouseover() {
                var oldsrc = document.getElementById('<%=btn_search.ClientID%>').src;
                if (oldsrc.indexOf('LinkData' + "_on.png") == -1) {
                    document.getElementById('<%=btn_search.ClientID%>').src = "../Images/LinkData_over.png";
                }
            }

            function LinkData_onmouseout() {
                var oldsrc = document.getElementById('<%=btn_search.ClientID%>').src;
                if (oldsrc.indexOf('LinkData_on.png') == -1) {
                    document.getElementById('<%=btn_search.ClientID%>').src = "../Images/LinkData_off.png";
                }
            }

            function GroupSelection_onmouseover() {
                var oldsrc = document.getElementById('<%=btn_groupSelection.ClientID%>').src;
                if (oldsrc.indexOf('GroupSelection_on.png') == -1) {
                    document.getElementById('<%=btn_groupSelection.ClientID%>').src = "../Images/GroupSelection_over.png";
                }
            }

            function GroupSelection_onmouseout() {
                var oldsrc = document.getElementById('<%=btn_groupSelection.ClientID%>').src;
                if (oldsrc.indexOf('GroupSelection_on.png') == -1) {
                    document.getElementById('<%=btn_groupSelection.ClientID%>').src = "../Images/GroupSelection_off.png";
                }
            }

            function AddDocument_onmouseover() {
                var oldsrc = document.getElementById('<%=btn_open_doc_popup.ClientID%>').src;
                if (oldsrc.indexOf('Add_doc_on.png') == -1) {
                    document.getElementById('<%=btn_open_doc_popup.ClientID%>').src = "../Images/Add_doc_off.png";
                }
            }

            function AddDocument_onmouseout() {
                var oldsrc = document.getElementById('<%=btn_open_doc_popup.ClientID%>').src;
                if (oldsrc.indexOf('Add_doc_on.png') == -1) {
                    document.getElementById('<%=btn_open_doc_popup.ClientID%>').src = "../Images/Add_doc_over.png";
                }
            }


            function btnNav_Clicked(nmd_ndx) {
                //     document.getElementById("NWControl01").ForceEvents = true;
                document.NWControl01.ForceEvents = true;
                document.NWControl01.state.CurrentView.ViewPoint.Paradigm = nmd_ndx;
                switch (nmd_ndx) {
                    case 16:
                        ResetImages();
                        document.getElementById('Select').src = "../Images/Select_on.png";
                        break;
                    case 3:
                        ResetImages();
                        document.getElementById('WalkThrough').src = "../Images/WalkThrough_on.png";
                        break;
                    case 1:
                        ResetImages();
                        document.getElementById('LookAround').src = "../Images/LookAround_on.png";
                        break;
                    case 7:
                        ResetImages();
                        document.getElementById('Zoom').src = "../Images/Zoom_on.png";
                        break;
                    case 12:
                        ResetImages();
                        document.getElementById('ZoomBox').src = "../Images/ZoomBox_on.png";
                        break;
                    case 8:
                        ResetImages();
                        document.getElementById('Pan').src = "../Images/Pan_on.png";
                        break;
                    case 11:
                        ResetImages();
                        document.getElementById('Orbit').src = "../Images/Orbit_on.png";
                        break;
                    //                    case 2: 
                    //                        ResetImages(); 
                    //                        document.getElementById('Examine').src = "../Images/Examine_on.png"; 
                    //                        break; 
                    case 4:
                        ResetImages();
                        document.getElementById('Fly').src = "../Images/Fly_on.png";
                        break;
                    case 5:
                        ResetImages();
                        document.getElementById('TurnTable').src = "../Images/TurnTable_on.png";
                        break;
                }
            }

            function reset_transperency() {
                ResetImages();
                document.getElementById('ResetModel').src = "../Images/ResetModel_on.png";
                var state = document.NWControl01.State;
                state.CurrentSelection.SelectAll()
                state.OverrideTransparency(state.CurrentSelection, 0);
                state.CurrentSelection.SelectNone();
            }

            function ResetImages() {
                document.getElementById('Select').src = "../Images/Select_off.png";
                document.getElementById('WalkThrough').src = "../Images/WalkThrough_off.png";
                document.getElementById('LookAround').src = "../Images/LookAround_off.png";
                document.getElementById('Zoom').src = "../Images/Zoom_off.png";
                document.getElementById('ZoomBox').src = "../Images/ZoomBox_off.png";
                document.getElementById('Pan').src = "../Images/Pan_off.png";
                document.getElementById('Orbit').src = "../Images/Orbit_off.png";
                //document.getElementById('Examine').src = "../Images/Examine_off.png";
                document.getElementById('Fly').src = "../Images/Fly_off.png";
                document.getElementById('TurnTable').src = "../Images/TurnTable_off.png";
                document.getElementById('ResetModel').src = "../Images/ResetModel_off.png";
            }
            
            function Dock_load() {
                var splitter = $find("<%= RadSplitter1.ClientID %>");
                splitter.set_height(document.getElementById("main_td").style.height);
                slide_right_pane_expand();
                var h = splitter.get_height() - 10;
                var h40per = parseInt(h * 0.37);
                var h20per = parseInt(h * 0.26);
                var docAsset = $find("<%= rdk_asset.ClientID %>");
                docAsset.set_height(h40per);
                var docType = $find("<%= rdk_type.ClientID %>");
                docType.set_height(h40per);
                var docDocument = $find("<%= rdk_document.ClientID %>");
                docDocument.set_height(h20per);
                return false;
            }
            function slide_right_pane_expand() {
                var splitter = $find("<%= RadSplitter1.ClientID %>");
                var vRightPanel = splitter.getPaneById("RightPane");
                var collapse = vRightPanel.expand();
                return false;
            }

            

            var screenht = document.body.clientHeight - 50;
            var viewpt_ht = screenht * (1 / 2);
            var system_ht = screenht * (1 / 2);

            var screenhtg = document.body.clientHeight;
            var screenwth = window.screen.width;
            document.getElementById("main_td").style.height = screenhtg;
            document.getElementById("Form1").style.height = screenhtg;
            document.getElementById("tblparent").style.height = screenhtg;
            //document.getElementById("NWControl01").style.height = screenhtg;

           
            function delete_attribute() {
                return confirm("Are you sure you want to delete this field and its value?");
            }

            function btnForceEvents_Clicked() {

                //   alert(document.getElementById("NWControl01").ForceEvents);

            }
            function result_msg(msg) {
                alert(msg);
            }

            

     
        </script>
        <script language="VBScript" type="text/vbscript">
Option Explicit
Dim counter
Dim apply
dim selected_view_pt 
 
 


 
public sub get_element(oGUIAttColl)
Dim oGUIAtt


Dim name
For Each oGUIAtt In oGUIAttColl

    name=UCase(oGUIAtt.ClassUserName)
'For ITEM
            If InStr(name,"ITEM") <> 0 then       
                For Each oP In oGUIAtt.Properties                  
                    If UCase(oP.UserName) = "LAYER" Then                              
                       ' alert(oP.value)  
                        document.getElementById("hf_layer").value=Replace(Replace(oP.value,"<",""),">","")
                        'alert(document.getElementById("hf_layer").value)                                      
                    End If
                 next
            End If  
       
        
        If InStr(name,"ELEMENT") <> 0 then
                Dim oP
                    For Each oP In oGUIAtt.Properties
                          
                                If UCase(oP.UserName) = "ID" Then
                                
                                      document.getElementById("PK_element_Numeric_ID").value=oP.value
                                       
                                    
                                End If
                                
                                If UCase(oP.UserName) = "UNIQUEID" Then
                          
                                        document.getElementById("str_element_ID").value=oP.value
                                       
                            
                                End If

                                If UCase(oP.UserName) = "CATEGORY" Then                                                           
                                        document.getElementById("hf_category").value=oP.value 
                                       ' alert(document.getElementById("hf_category").value)
                                        
                            
                                End If
                                
 
                                If UCase(oP.UserName) = "NAME" Then
                          
                                        document.getElementById("hf_strElementName").value=oP.value
                            
                                End If


                                If UCase(oP.UserName) = "UNIQUEGUID" Then
                                        
                                        document.getElementById("hf_guid").value=oP.value            
                            
                                End If
                    next
End If


If InStr(name,"REVIT TYPE") <> 0 then


         For Each oP In oGUIAtt.Properties
         
                     If UCase(oP.UserName) = "ID" Then
                                        
                           document.getElementById("hf_TypeID").value=oP.value            
                            
                     End If
         
         next
End If

If InStr(name,"ENTITY HANDLE") <> 0 then
 For Each oP In oGUIAtt.Properties                  
                                If UCase(oP.UserName) = "VALUE" Then
                                          document.getElementById("PK_element_Numeric_ID").value=oP.value
                                          document.getElementById("hdnrevitautocad").value="LcOaPropOverrideCat"
                                          
                                End If
next
End If

Next
End Sub



 Public Sub NWControl01_OnFileOpen()

 
 
 Dim comp_id
  Dim location_id
  
  If document.getElementById("hdn_system_component").value = "Space" Then
    comp_id=document.getElementById("comp_element_id").value
    location_id=document.getElementById("pk_location_id").value
    document.getElementById("hf_location_id").value=location_id
    jump_on_space_comp comp_id,location_id
  End If
 
 If document.getElementById("hdn_system_component").value = "Component" Then
 
    comp_id=document.getElementById("comp_element_id").value
    jump_on_comp(comp_id)
  End If
  If document.getElementById("hdn_system_component").value = "System" Then
    comp_id=document.getElementById("comp_element_id").value
    jump_on_system_components(comp_id)
  End If
  
   btnNav_Clicked(16)

End Sub



</script>

    </div>
    </form>
</body>
</html>