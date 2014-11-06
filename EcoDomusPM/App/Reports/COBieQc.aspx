<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App/EcoDomus_PM_New.master"
    CodeFile="COBieQc.aspx.cs" Inherits="App_Reports_COBieQc" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

    function ValidateFacility() { 

        alert('Please select facility');  
        return false;


    }
    function ProjectValidation() {

        alert('Please select Project');
        window.location = '../Settings/Project.aspx';
        return false;

    }

    function GridCreated(sender, args) {
        //alert(sender.get_masterTableView().get_pageSize());
        //debugger;
        var scrollArea = sender.GridDataDiv;
        var dataHeight = sender.get_masterTableView().get_element().clientHeight;

        if (dataHeight < 400 ) {
            scrollArea.style.height = dataHeight + "px";
        }
        else {
            scrollArea.style.height = 500 + "px";
        }

        //sender.get_masterTableView().set_pageSize(globalPageHeight);
    }

    function NiceScrollOnload() {

        //var screenhtg = set_NiceScrollToPanel();

    }
    window.onload = body_load;
    function body_load() {
        var screenhtg = set_NiceScrollToPanel();
     }
</script>
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/PopupStyleSheet.css" />
<%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_ui_pm.css" />--%>
   <style type="text/css"  >
    .RadWindow_Simple
	    {
	      border: solid 0px #616161;
	    }
	    #div_contentPlaceHolder
          {
               
          }
  </style>
    <%-- <link href="../../App_Themes/EcoDomus/radmenu.css" rel="stylesheet" type="text/css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
     <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
   --%>
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars,Checkboxes" />
    <div>
        <table style="width: 100%" border="0">
            <tr>
                <td align="left">
                    <div>
                        <table>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table>
                                        <caption>
                                            <asp:Label ID="lblCOBieDataQualityControl" Text="<%$Resources:Resource, COBieDataQualityControl%>"
                                                runat="server"></asp:Label>:
                                        </caption>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <th valign="top">
                                    <asp:Label ID="lblfacility" Text="<%$Resources:Resource, Facility%>" runat="server"
                                        CssClass="Label"></asp:Label>:
                                </th>
                                <td>
                                    <telerik:RadComboBox ID="ddlFacility" runat="server" Visible="true" CssClass="DropDown"
                                        Filter="Contains" MarkFirstMatch="true">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="ddlFacility"
                                        Display="Dynamic" EnableClientScript="true" ErrorMessage="*" InitialValue="--Select--"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <asp:Label ID="lblMajor" Text="<%$Resources:Resource, Major%>" runat="server" CssClass="Label"></asp:Label>:
                                </td>
                                <td>
                                    <asp:CheckBox ID="ckbox_major" runat="server" />
                                </td>
                                <td>
                                    <asp:Button ID="btnSubmitDetails" runat="server" Text="<%$Resources:Resource, Generate_Report%>"
                                        Visible="true" OnClick="btnSubmitDetails_Click" />
                                </td>
                                <td>
                                    <div>
                                        <asp:Button ID="btnExcel" runat="server" Text="<%$Resources:Resource, Export_To_Excel%>"
                                            Visible="false" OnClick="btnExcel_Click" />
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <%--<tr>
   <td align="right"> 
   <asp:Label ID="lblFacility" Text="<%$Resources:Resource, Facility%>" runat="server" CssClass="Label" ></asp:Label> :
   </td>
   <td class="style1"  align="right" colspan="1">
     <telerik:RadComboBox Width="170px" ID="cmbfacility" Filter="Contains" runat="server" oncopy="return false;"  AllowCustomText="True"
        onpaste="return false;" oncut="return false;" onkeypress="return tabOnly(event)" onmousewheel="return false" >
        <ItemTemplate>
        <asp:CheckBox ID="chkbxfacility" runat="server" Text='<%# Eval("name") %>'  />
         </ItemTemplate>
         </telerik:RadComboBox>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="ddlFacility"
                                        Display="Dynamic" EnableClientScript="true" ErrorMessage="*" InitialValue="--Select--"
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
    </td>
    <td align="left">
    <asp:Button ID="btnSubmitDetails" runat="server" Text="Generate Report" Visible="true"/>
    </td>
    </tr>--%>
        </table>
    </div>
      <table cellpadding="0"  cellspacing="0" style="width: 90%; border: 3;">
       <%-- <tr>
            <td style="padding-left: 250px;">
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>--%>
        <tr>
            <td align="right">
                <asp:Label ID="phaselabel" runat="server" Text="Label" Font-Size="Medium" ForeColor="Red"
                    Visible="false">Please select a phase of the project</asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left"  style="padding-left: 5px">
                <%-- Skin="Web20"------------------------------------------------------------------------------------------%>
                <%--<div id="load_div1" runat="server">--%>
                    <telerik:RadGrid ID="rg_sheet_name" ShowStatusBar="true" HeaderStyle-BackColor="#4b66a4"
                        Skin="Default" runat="server" Width="95%" AutoGenerateColumns="False" AllowSorting="True"
                        AllowMultiRowSelection="False" PageSize="10" GroupHeaderItemStyle-BorderWidth="0"  
                        GroupHeaderItemStyle-Width="2%" AllowPaging="true" GridLines="None" AllowCustomPaging="true"
                        OnDetailTableDataBind="rg_sheet_name_DetailTableDataBind" OnItemCommand="rg_sheet_name_ItemCommand">
                        <PagerStyle Mode="NumericPages"></PagerStyle>
                        <ClientSettings>
                            <Scrolling AllowScroll="true"  UseStaticHeaders="true" ScrollHeight="400"/>
                            <ClientEvents OnGridCreated="GridCreated" />
                        </ClientSettings>
                        <MasterTableView Width="100%" AllowCustomPaging="true" DataKeyNames="fk_entity_id"
                            AllowMultiColumnSorting="True">
                            <DetailTables>
                                <telerik:GridTableView AllowCustomPaging="false" PagerStyle-VerticalAlign="Bottom" 
                                    PagerStyle-Mode="NextPrevAndNumeric" Width="100%" DataKeyNames="ID" runat="server"
                                    Name="error_grid" GridLines="Horizontal" Style="border-color: #d5b96a; border: 1" 
                                    PageSize="10" AllowPaging="true" AutoGenerateColumns="false">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="name" UniqueName="Name" HeaderText="Name">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn ItemStyle-Width="43%" DataField="Errors" UniqueName="Errors"
                                            HeaderText="Errors" Visible="true" AllowSorting="true">
                                        </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="entity_name" UniqueName="Entity_Name" HeaderText="Entity_Name" Visible="false">
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                </telerik:GridTableView>
                            </DetailTables>
                            <Columns>
                                <telerik:GridTemplateColumn ItemStyle-Width="58%" UniqueName="Name" HeaderText="">
                                    <ItemTemplate>
                                        <asp:Label ID="lblcertificates" Text='<%# Eval("name") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" UniqueName="refresh" HeaderStyle-BackColor=""
                                    ItemStyle-Height="5px" ItemStyle-Width="42%" ImageUrl="~/App/Images/Icons/icon_sync_sm.png"  
                                    CommandName="refresh" >
                                </telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                <%--</div>--%>
               <%-- <br />--%>
            </td>
         </tr>
    </table>
    <asp:HiddenField ID="hfphaseid" runat="server" />
   

   <telerik:RadWindowManager ID="rad_window"  runat="server" VisibleTitlebar="true"   Behaviors="Close,Move"  
        BorderWidth="0px"  Skin="Simple" BorderStyle="None">
        <Windows>
            <telerik:RadWindow ID="rd_profile_popup" runat="server" ReloadOnShow="false"  Width="700" 
                DestroyOnClose="false" OffsetElementID="btn_search" AutoSize="false"  AutoSizeBehaviors="Default" 
                VisibleStatusbar="false" VisibleOnPageLoad="false" EnableAjaxSkinRendering="false" EnableShadow="false" 
                Modal="true" Overlay="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <%--<telerik:RadWindowManager Visible="true" ID="rad_window" VisibleStatusbar="false" 
       EnableShadow="false" ShowOnTopWhenMaximized="false" runat="server" AutoSize="true"
        KeepInScreenBounds="true">
        <Windows>
            <telerik:RadWindow Visible="true" ID="rd_profile_popup" runat="server" Behaviors="Close,Move" AutoSizeBehaviors="HeightProportional,WidthProportional"
                Animation="Slide" KeepInScreenBounds="true" ReloadOnShow="false" VisibleTitlebar="false"
                AutoSize="false"  Width="700" Height="400" VisibleStatusbar="false" 
                VisibleOnPageLoad="false" Skin="" Title="" >
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>--%>
    <telerik:RadCodeBlock ID="loadPopUp" runat="server">
        <script language="javascript" type="text/javascript">
            function gotoPage(id, pagename, role, entity_name) {
             
                var url;
                var popupflag='popup';
                name = name.replace('$', '"');
                switch (pagename) {
                    case 'Attribute':
                        break;

                    case 'Contact':
                        url = "../Settings/Userprofile.aspx?UserId=" + id + "&flag=&user_role=" + role + '&popupflag=popup';
                        load_popup(url);
                        break;

                    case 'Facility':
                        url = "../Locations/FacilityprofileNew.aspx?FacilityId=" + id + "&FacilityName=" + role + "&profileflag=new" + '&popupflag=popup';
                        load_popup(url);
                        break;

                    case 'Floor':
                        url = "../Locations/FloorProfileNew.aspx?pagevalue=Floor Profile&id=" + id + '&popupflag=popup';
                        load_popup(url);
                        break;

                    case 'Space':
                        url = "../Locations/SpaceProfile_New.aspx?pagevalue=Space Profile&id=" + id + "&profileflag=new" + '&popupflag=popup';
                        load_popup(url);
                        break;

                    case 'Zone':
                        url = "../Locations/ZoneProfileNew.aspx?pagevalue=Zone Profile&id=" + id + "&profileflag=new&name=" + role + '&popupflag=popup';
                        load_popup(url);
                        break;

                    case 'Type':
                    
                    url = "../Asset/TypeProfileNew.aspx?type_id=" + id+ "&popupflag=" + popupflag;
                        load_popup(url);
                        break;

                    case 'Asset':
                        url = "../Asset/AssetProfileNew.aspx?assetid=" + id + '&popupflag=popup';  //+ "&pagevalue=AssetProfile";
                        load_popup(url);
                        break;

                    case 'System':
                        url = "../Asset/SystemProfile_1.aspx?system_id=" + id + '&popupflag=popup'+"&value=system";
                        load_popup(url);
                        break;

                    case 'Document':
                        url = "../Asset/DocumentProfile.aspx?DocumentId=" + id + "&fk_row_id=" + role + "&entity_name=" + entity_name + '&popupflag=popup';
                        load_popup(url);
                        break;
                   
                    case 'work_order':
                        url = "../Asset/WorkOrderprofile.aspx?work_order_id=" + id + "&flag=issue" + '&popupflag=popup';
                        load_popup(url);
                        break;

                }
                //window.location.href(url); 
            }

            function load_popup(url) {

                manager = $find("<%= rad_window.ClientID %>");
                
                var windows = manager.get_windows();

                windows[0].setUrl(url);
                //windows[0].width = '800px';
               // windows[0].set_width(760);
               // windows[0].set_scroll();
               

                if (url.indexOf("WorkOrderprofile") >= 0) {
                    windows[0]._titleElement.innerHTML = " Work Order Profile";
                }
                if (url.indexOf("ZoneProfileNew") >= 0) {
                    windows[0].set_height(250);
                    windows[0].set_width(600);
                   
                    windows[0]._titleElement.innerHTML = " Zone Profile";

                }
                else if (url.indexOf("FacilityprofileNew") >= 0) {
                    windows[0].set_height(400);
                    windows[0].set_width(700);
                    windows[0]._titleElement.innerHTML = " Document Profile";
                }

                else if (url.indexOf("FloorProfileNew") >= 0) {
                    windows[0].set_height(260);
                    windows[0].set_width(600);
                    windows[0]._titleElement.innerHTML = " Document Profile";
                }
                else if (url.indexOf("DocumentProfile") >= 0) {
                    windows[0].set_height(330);
                    windows[0].set_width(700);
                    windows[0]._titleElement.innerHTML = " Document Profile";
                }
                else if (url.indexOf("AssetProfileNew") >= 0) {
                    windows[0].set_height(280);
                    windows[0].set_width(600);
                    //windows[0]._titleElement.innerHTML = "Component Profile";
                }
                else if (url.indexOf("SystemProfile_1") >= 0) {
                    windows[0].set_height(320);
                    windows[0].set_width(600);
                    windows[0]._titleElement.innerHTML = " System Profile";
                }
                else if (url.indexOf("Userprofile") >= 0) {
                    windows[0].set_width(800);
                    windows[0].set_height(400);
                    windows[0]._titleElement.innerHTML = " User Profile";
                }
                else if (url.indexOf("SpaceProfile") >= 0) {
                    windows[0].set_height(230);
                    windows[0].set_width(630);
                    windows[0]._titleElement.innerHTML = "";
                    windows[0]._titleElement.innerHTML = " Space Profile";
                }
                else if (url.indexOf("TypeProfile") >= 0) {
                    windows[0].set_height(350);
                    windows[0].set_width(730);
                   windows[0]._titleElement.innerHTML = " Type Profile";
                }
//                else if (url.indexOf("") >= 0) {
//                    windows[0]._titleElement.innerHTML = "EcoDomus PM:User Profile";
//                }
               // window[0]._height = "700";
               windows[0].show();
              windows[0].set_modal(false)
                 return false;
            }

            function visible_export_btn(flag) {
                document.getElementById('divbtnExcel').style.display = "inline";
            }             
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="radCobieqc" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_sheet_name">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_sheet_name" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel Skin="Default" ID="RadAjaxLoadingPanel1" runat="server"
        Height="75px" Width="75px">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
