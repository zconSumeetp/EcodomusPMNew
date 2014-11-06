<%@ Page Language="C#" MasterPageFile="~/App/EcoDomusMaster.master" AutoEventWireup="true"
    CodeFile="Hierarchy.aspx.cs" Inherits="App_Settings_Hierarchy" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">
        function NavigateToPopup(obj) 
        {                      
            var hypid = obj.id;
            var hypid_value = obj.innerText;/*Get the value of Link Button*/

            var hidid = obj.id.replace("rg_lh_anchor", "rg_lh_hf_anchor");
            var hididval = document.getElementById(hidid).value;
            var hidcustid = obj.id.replace("rg_lh_anchor", "rg_custom_flag");
            var hidcustidval = document.getElementById(hidcustid).value;
            // alert(hidcustidval);
           

            /*var custom_flag=document.getElementById("rg_custom_flag");//Id for custom flag
            document.getElementById("rg_custom_flag").value=0;
            var custom_flag_value = document.getElementById("rg_custom_flag").value;*/

            
            var hidnid = obj.id.replace("rg_lh_anchor", "rg_lh_hf_anchor_name");
            var url = "../Settings/Add_Custom_Hierarchy_data.aspx?LinkButtonText=" + hypid + '&LinkButtonValue=' + hypid_value + '&HiddenFieldId=' + hidid + '&HiddenFieldValue=' + hididval + '&hfnid=' + hidnid + '&HiddenFieldCustId=' + hidcustid + '&HiddenFieldCustValue=' + hidcustidval;
            
            //var url = "../Settings/Add_Custom_Hierarchy_data.aspx?LinkButtonText=" + hypid + '&HiddenFieldId=' + hidid + '&hfnid=' + hidnid;
            manager = $find("<%=rwmanager.ClientID %>");
            if (manager != null) 
            {
                var windows = manager.get_windows();
                windows[0].setUrl(url);
                //windows[0].set_modal(false);
                windows[0].show();               
            }
            return false;
        }


        function ChangeValue(id, value, id1, id2, hf_name) 
        {
            if (value != "") 
            {
                document.getElementById(id).innerHTML = value;         
                document.getElementById(id).value = value;        
                document.getElementById(id1).value = id2
                document.getElementById(hf_name).value = value;
                document.getElementById('hdf_change_value').value = document.getElementById(hf_name).value;               
            }
            else
            {
                document.getElementById(id).innerHTML = "Select";
                document.getElementById("ContentPlaceHolder1_hdf_value").value = value;               
            }            
        }

        function gotoPage(id) 
        {
            var url = "../Settings/Add_Edit_Custom _data.aspx?pk_hierarchy_table_id=" + id;
            manager = $find("<%=rwmanager.ClientID %>");
            if (manager != null) 
            {
                var windows = manager.get_windows();
                windows[1].setUrl(url);
                //windows[1].set_modal(false);
                windows[1].show();
            }
        }

        function OnClientShow_(radwindow)
         {
            var delscrollbar = radwindow.RadWindow1;
            document.getElementsByName(delScrollbar)[0].setAttribute("scrolling", "no"); 
        }



    </script>
        <%--<style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }   
        HTML
        {
        	overflow-x:hidden;
        }                  
    </style>--%>

    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
    <table border="0" width="80%" style="margin: 50px 0px 0px 70px">
     <telerik:RadFormDecorator ID="RadFormDecorator" runat="server" Skin="Hay" DecoratedControls="Buttons" />    
        <caption><asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Location_Hierarchy%>"></asp:Label></caption>
        <tr>
            <td>
                <telerik:RadGrid ID="rg_lh" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                  AllowSorting="true" Skin="Hay"
                    OnSortCommand="rg_lh_sortcommand">
                    <MasterTableView EditMode="EditForms" DataKeyNames="pk_hierarchy_table_id,fk_level_id,level_name,hierarchy_name">
                        <Columns>
                            <telerik:GridBoundColumn DataField="" Visible="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="fk_level_id" Visible="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, Levels%>" DataField="level_name" UniqueName="level_name">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="hierarchy_name" UniqueName="hierarchy_name"
                                HeaderText="<%$Resources:Resource, Hierarchy%>" EditFormColumnIndex="0">
                                <ItemTemplate>
                                    <asp:HyperLink ID="rg_lh_anchor" Text='<%# DataBinder.Eval(Container.DataItem,"hierarchy_name")%>'
                                        onclick="javascript:NavigateToPopup(this)" runat="server" NavigateUrl="#"></asp:HyperLink>
                                    <asp:HiddenField ID="rg_lh_hf_anchor" Value='<%# DataBinder.Eval(Container.DataItem,"db_table_name")%>' runat="server" />
                                    <asp:HiddenField ID="rg_lh_hf_anchor_name" runat="server" />
                                    <asp:HiddenField  ID="rg_custom_flag" value='<%# DataBinder.Eval(Container.DataItem,"custom_flag")%>' runat="server"/>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                                                        
                            <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, Add_Edit_Custom_Data%>" DataField="Custom_data"
                                UniqueName="Custom_data">
                            </telerik:GridBoundColumn>                                                                                                                                                                                                   
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
                <asp:Label ID="lbl_my_test" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btn_save" Text="<%$Resources:Resource, Save%>" runat="server" Width="80" OnClick="btn_save_Click" />
            </td>
           <%-- <td style="visibility: hidden;">
                <asp:Button ID="btn_Refresh" runat="server" OnClick="btn_Refresh_Click" Text="" />
            </td>--%>
        </tr>
    </table>
    <div>
        <telerik:RadWindowManager ID="rwmanager" runat="server" VisibleStatusbar="false" >
            <Windows>
                <telerik:RadWindow ID="RadWindow_Custom_Hierarchy_data" runat="server" Animation="Slide" Behavior="Move,Close,Resize"
                    ReloadOnShow="True" BorderStyle="Solid" Title="EcoDomus FM : Add Hierarchy" VisibleStatusbar="false"
                    Height="250px" Width="400px" Skin="Forest" AutoSize="false">
                </telerik:RadWindow>
                <telerik:RadWindow ID="RadWindow_Hierarchy" runat="server" Animation="Slide" Behavior="Move,Close,Resize"
                    ReloadOnShow="True" BorderStyle="Solid" Title="EcoDomus FM : Add Custom Data" VisibleStatusbar="false"
                    Height="400px" Width="600px" Skin="Forest" AutoSize="false" >
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
    <asp:HiddenField ID="hf_id" runat="server" />
    <asp:HiddenField ID="hdfitemindex" runat="server" />
    <asp:HiddenField ID="PRimary" runat="server" />
    <asp:HiddenField ID="hdfLinkButtontxt" runat="server" />
    <asp:HiddenField ID="hdf_value" runat="server" />
    <asp:HiddenField ID="hdf_level" runat="server" />
  <%--  Hidden field to store change value      --%> 
    <asp:HiddenField ID="hdf_flag" runat="server" />
</asp:Content>