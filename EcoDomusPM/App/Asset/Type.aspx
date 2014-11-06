<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true" CodeFile="Type.aspx.cs" Inherits="App_Asset_Type" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register src="../UserControls/UCComboFacility.ascx" tagname="UCComboFacility" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <telerik:RadCodeBlock ID="loadPopUp" runat="server">
    <script type="text/javascript" language="javascript">

function Clear() {

    document.getElementById("<%=txtsearch.ClientID %>").value = "";
            
            return false;
        }
        function checkCSI04(chk) {
         
            var hfid = chk.id;
            //alert(hfid);
            var TypeId = hfid.substring(0, hfid.length - 9) + "hfSelect";
            var id = hfid.substring(0, hfid.length - 9) + "chkSelect";

            var str = "";
            //document.getElementById("ContentPlaceHolder1_hftype_id").value = "";
            if (document.getElementById(id).checked == true) {
                
                document.getElementById("ContentPlaceHolder1_hftype_id").value = document.getElementById(TypeId).value + "," + document.getElementById("ContentPlaceHolder1_hftype_id").value; // anirudha
                //document.getElementById("ContentPlaceHolder1_hftype_id").value = document.getElementById(TypeId).value + document.getElementById("ContentPlaceHolder1_hftype_id").value; //my
                str = document.getElementById("ContentPlaceHolder1_hftype_id").value;
                document.getElementById("ContentPlaceHolder1_hftype_id").value = str.replace(",,", ",");
            }
            else {
                //alert("test1");
                str = "," + document.getElementById("ContentPlaceHolder1_hftype_id").value;
                var rep = "," + document.getElementById(TypeId).value + ",";
                str = str.replace(rep, ",");
                // alert(str);
                document.getElementById("ContentPlaceHolder1_hftype_id").value = str.replace(",,", ",");
               }
        }
        function openpopupaddomniclasslinkup() {
            //manager = $find("rad_windowmgr");

            var type_id = document.getElementById("ContentPlaceHolder1_hftype_id").value; //Anirudha
            //var type_id = document.getElementById("ContentPlaceHolder1_hftype_id").value + document.getElementById("ContentPlaceHolder1_hftype_id").value; // my
            if(type_id.length<2)
            {
               alert("Select atleast one type.....!");
               return false;
            }
           
            
            else
            {
            manager = $find("<%=rad_windowmgr.ClientID%>");
        
            var url;
            var url = "../Locations/AssignOmniclass.aspx?Item_type=type";
            
            if (manager != null) {
                var windows = manager.get_windows();
                var intWidth = document.body.clientWidth;
                windows[0]._left = parseInt(intWidth * (0.2));
                windows[0]._width = parseInt(intWidth * 0.8);
                var intHeight = document.body.clientHeight;
                //windows[0]._top = 5;

               // windows[0]._height = parseInt(intHeight * 1);
               windows[0]._height = "450";
                windows[0].setUrl(url);
                windows[0].show();
                windows[0].center();
            }
            return false;
            }
        }
        function load_omni_class(name, id) {
        
        document.getElementById("ContentPlaceHolder1_hf_lblOmniClassid").value = id;
            //var reg = new RegExp('&nbsp;', 'g');//Ani
            //name = name.replace(reg, ' '); //Ani
            document.getElementById("ContentPlaceHolder1_btnAssignOmni").click();
            //document.getElementById("hfOmniClassName").innerText = name;
            document.getElementById("ContentPlaceHolder1_hftype_id").value = "";
        }
        function get1() {
                var answer = confirm("If the type is deleted, then type-attributes, assets, asset-attributes under this type will be deleted. Are you sure you want to delete this Type?")
                if (answer)
                    return true;
                else
                    return false;

            }
             function assignomniclass() {
                alert("Please Select Omniclass!");
            }

//             function OpenFacilityProfile(facility_id) {
//       
//        window.location.href = "~/App/Locations/FacilityMenu.aspx?FacilityId=" +facility_id;

//    }
     function gotoPage(id,pagename) {
        var url;
        
      // debugger
        // if (pagename == "Facility")// {
          //  url = "../Locations/FacilityMenu.aspx?FacilityId=" + id ;

        //}

        // window.location.href(url);
        document.getElementById('ContentPlaceHolder1_hf_facility_id').value = id;
        document.getElementById('ContentPlaceHolder1_btn_navigate').click();    
    }
       
        </script>
         </telerik:RadCodeBlock>
<telerik:RadFormDecorator ID="rdfOrganizationProfile" runat="server" Skin="Hay" DecoratedControls="Buttons" />
    
    <table style="margin-top: 30px; margin-left: 50px;" width="90%" border="0">
    <caption>
        <asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource,Type%>"></asp:Label>:
    </caption>
        <tr>
       
            <td style="width:60px">
                <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource,Facility%>" CssClass="Label"></asp:Label>:
            </td>
            <td style="width:80px">
            <div id="dv_facility" runat="server">
                <uc1:UCComboFacility ID="UCComboFacility1" runat="server" />
            </div>
            </td>
           
            <td style="width:60px">
                <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Criteria%>" CssClass="Label"></asp:Label>:
            </td>
            <td style="width:60px">
                <telerik:RadComboBox ID="cmbcriteria" OnSelectedIndexChanged="cmbcriteria_SelectedIndexChanged"  AutoPostBack="true" runat="server" Height="100px" Width="170px">
                    <Items>
                        <telerik:RadComboBoxItem Value="Name" Text="Name" Selected="True" runat="server"
                            Font-Size="11px" />
                        <telerik:RadComboBoxItem Value="Description" Text="Description" runat="server" Font-Size="11px" />
                    </Items>
                </telerik:RadComboBox>
            </td>
            <td style="width:60px">
                <asp:TextBox ID="txtsearch" runat="server" CssClass="SmallTextBox"></asp:TextBox>
            </td>
            <td>
                <%--<telerik:RadButton ID="btnsearch" runat="server" Text="Search" Width="100px" 
                    Skin="Hay" onclick="btnsearch_Click" />--%>
                   <asp:Button ID="btnsearch" runat="server" Text="<%$Resources:Resource,Search%>" Width="100px" 
                    Skin="Hay" onclick="btnsearch_Click" />
                &nbsp;<asp:Button ID="btnclear" runat="server" Text="<%$Resources:Resource,Clear%>" Width="100px" OnClientClick="javascript:return Clear();" />
                 &nbsp;<asp:Button ID="btnAssignOmniclass" runat="server" Text="<%$Resources:Resource,Assign_Omniclass%>" OnClientClick="javascript:return openpopupaddomniclasslinkup()" 
                    Width="130" />
             <asp:Button ID="btnAssignMajor" runat="server" Text="<%$Resources:Resource,Assign_As_Major%>"
                    Width="130" onclick="btnAssignMajor_Click" />
            </td>                               
        </tr>
    </table>
    <table style="margin-top: 15px; margin-left: 50px; margin-bottom:10px;" width="90%" border="0">
        <tr>
            <td>
             <telerik:RadGrid ID="RgTypes" runat="server" AllowPaging="True" AutoGenerateColumns="false" ClientSettings-Selecting-AllowRowSelect="true"
            AllowSorting="True" PagerStyle-AlwaysVisible="true" OnItemCommand="OnItemCommand_RgTypes"  Width="95%" PageSize="10"  OnItemDataBound="RgTypes_ItemDataBound"
           OnPageSizeChanged="RgTypes_PageSizeChanged" OnSortCommand="RgTypes_SortCommand" OnPageIndexChanged="RgTypes_PageIndexChanged"  GridLines="None" Skin="Hay">
            <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
           
            <MasterTableView ClientDataKeyNames="type_id" DataKeyNames="type_id">
                <Columns>
                    <telerik:GridBoundColumn DataField="type_id" Visible="false">
                        <ItemStyle CssClass="column" />
                    </telerik:GridBoundColumn>

                   <%-- <telerik:GridClientSelectColumn>
                        <ItemStyle Width="10px" />
                        <HeaderStyle Width="10px" />
                    </telerik:GridClientSelectColumn>--%>
                     <telerik:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="<%$Resources:Resource,Select%>">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" onclick="javascript:checkCSI04(this);"
                                            value='<%# DataBinder.Eval(Container.DataItem,"type_id")%>' type_id='<%# DataBinder.Eval(Container.DataItem,"type_id")%>' />
                                        <asp:HiddenField ID="hfSelect" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"type_id")%>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="5px" />
                                </telerik:GridTemplateColumn>
                     

                    <telerik:GridBoundColumn DataField="omniclass_name" HeaderText="<%$Resources:Resource,Omniclass%>">
                        <ItemStyle CssClass="column" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="major_flag" UniqueName="TemplateColumn1" HeaderText="<%$Resources:Resource,Major%>"
                                    SortExpression="major_flag">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkMajor" runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle Width="5px" />
                      </telerik:GridTemplateColumn>
                    <telerik:GridButtonColumn DataTextField="name" HeaderText="<%$Resources:Resource,Type_Name%>" ButtonType="LinkButton"
                        SortExpression="name" CommandName="EditType">
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="description" HeaderText="<%$Resources:Resource,Description%>">
                        <ItemStyle CssClass="column" />
                    </telerik:GridBoundColumn>
                     <%--<telerik:GridButtonColumn DataTextField="facility_name" HeaderText="Facility" ButtonType="LinkButton"
                        SortExpression="name" CommandName="EditFacility">
                    </telerik:GridButtonColumn>--%>
                    <telerik:GridBoundColumn DataField="link_facility" HeaderText="<%$Resources:Resource,Facility%>">
                      </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn>
                        <ItemTemplate>
                            <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="../Images/Delete.gif" OnClientClick="javascript:return get1();" CausesValidation="false"
                               CommandName="RemoveType" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
            </td>
        </tr>
        <tr>
        <td style="margin-top: 20px;">
        
        </td>
        </tr>
        <tr style="margin-top: 30px;">
            <td align="left">
                <asp:Button ID="btnAddType" runat="server" Text="<%$Resources:Resource,Add_Type%>" Width="110" OnClick="btnAddType_Click" />&nbsp;
               
                    
            </td>          
        </tr>
    </table>
   <asp:Label ID="lblMsg" runat="server" Text="" Style="font-size: 11px;"></asp:Label>
       <asp:HiddenField ID="hftype_id" runat="server" />
       <asp:HiddenField ID="hf_lblOmniClassid" runat="server" />
        <asp:HiddenField ID="hf_facility_id" runat="server" />
    <div style="display: none">
        <asp:Button ID="btnAssignOmni" Name="btnselect" runat="server" OnClick="btnAssignOmni_Click" />
         <asp:Button ID="btn_navigate" runat="server" OnClick="navigate"/>
    </div>

       <telerik:RadWindowManager ID="rad_windowmgr" runat="server" Skin="Forest" VisibleStatusbar="false">
        <Windows>
            <telerik:RadWindow ID="radWindowAddNew" runat="server" Animation="None" Behavior="Move,Resize"
                KeepInScreenBounds="true" ReloadOnShow="True" BorderStyle="Solid"
                VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>    
           
    </telerik:RadWindowManager>
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>
    <telerik:RadAjaxManagerProxy ID="organizationsManagerProxy" runat="server">
        <AjaxSettings>
           
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgTypes" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmbcriteria">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgTypes" LoadingPanelID="RadAjaxLoadingPanel1" />
                   
                </UpdatedControls>
            </telerik:AjaxSetting>

             <telerik:AjaxSetting AjaxControlID="btnAssignOmni">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgTypes" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnAssignMajor">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RgTypes" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Skin="Hay" runat="server"
        Width="50px">
    </telerik:RadAjaxLoadingPanel>

</asp:Content>


