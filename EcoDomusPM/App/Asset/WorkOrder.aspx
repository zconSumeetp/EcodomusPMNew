<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomus_PM_New.master"  AutoEventWireup="true"
    CodeFile="WorkOrder.aspx.cs" Inherits="App_Asset_Issues" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

  <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />--%>
  <%--<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
  <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
  --%>  
  <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
    <script type="text/javascript" language="javascript">
        function NavigateAddIssue() {

            location.href = "../Asset/AddIssue.aspx";
            return false;

        }

        function Clear() {

            document.getElementById("<%=txtSearch_Issue.ClientID%>").value = "";
            return false;
        }


        function delete_issues() {
            var answer = confirm("Do you want to delete this work order?")
            return answer;
        }
        function ProjectValidation() {

            alert('Please select Project');
            window.location = '../Settings/Project.aspx';
            return false;

        }

//        function NiceScrollOnload() {
//            $("html").css('overflow-y', 'hidden');
//            $("html").css('overflow-x', 'auto');
//            var screenhtg = set_NiceScrollToPanel();
//        }

        function close_issues() {
            var answer = confirm("Do you want to close this work order?")
            if (answer)
                return true;
            else
                return false;
        }


        function getItemCheckBox(item) {
            //Get the 'div' representing the current RadComboBox Item.
            var itemDiv = item.get_element();

            //Get the collection of all 'input' elements in the 'div' (which are contained in the Item).
            var inputs = itemDiv.getElementsByTagName("input");

            for (var inputIndex = 0; inputIndex < inputs.length; inputIndex++) {
                var input = inputs[inputIndex];

                //Check the type of the current 'input' element.
                if (input.type == "checkbox") {
                    return input;
                }
            }
            return null;
        }

        function checkboxClick(sender) {
            collectSelectedItems(sender);
            document.getElementById('ContentPlaceHolder1_btn_navigate').click();
        }


        function collectSelectedItems(sender) {
            var combo = $find(sender);
            var items = combo.get_items();

            var selectedItemsTexts = "";
            var selectedItemsValues = "";

            var itemsCount = items.get_count();

            for (var itemIndex = 0; itemIndex < itemsCount; itemIndex++) {
                var item = items.getItem(itemIndex);

                var checkbox = getItemCheckBox(item);

                //Check whether the Item's CheckBox) is checked.
                if (checkbox.checked) {
                    selectedItemsTexts += item.get_text() + ", ";
                    selectedItemsValues += item.get_value() + ", ";
                }
            }

            selectedItemsTexts = selectedItemsTexts.substring(0, selectedItemsTexts.length - 2);
            selectedItemsValues = selectedItemsValues.substring(0, selectedItemsValues.length - 2);

            //Set the text of the RadComboBox with the texts of the selected Items, separated by ','.
            combo.set_text(selectedItemsTexts);


            //Set the comboValue hidden field value with values of the selected Items, separated by ','.

            if (selectedItemsValues == "") {
                combo.clearSelection();
            }
            document.getElementById('ContentPlaceHolder1_hf_facility_id').value = selectedItemsValues;
        }

        //  this code is addedd by Rajendra Barhate For Resolving Scrolling Issue Of RadControls i.e RadDatePicker for Workorder.aspx page
        $(document).ready(function () {
            //thes 2line removes 'rcSingle' class Dynamically from webresource.axd file which comming from webresources
            $("#ctl00_ContentPlaceHolder1_rdpfrom_dateInput_wrapper").removeClass('rcSingle');
            $("#ctl00_ContentPlaceHolder1_rdpto_dateInput_wrapper").removeClass('rcSingle');

            //these 2lines set id for tble under div dynamically for user to remove some classes for that
            $("#ctl00_ContentPlaceHolder1_rdpfrom_wrapper").find('table').prop('id', 'tblrdpFromid');
            $("#ctl00_ContentPlaceHolder1_rdpto_wrapper").find('table').prop('id', 'tblrdpToid');


            $("#div_contentPlaceHolder").scroll(function () {
                //these 2 lines removes 'riSingle' class from webresource.axd file 
                $("#ctl00_ContentPlaceHolder1_rdpto_dateInput_wrapper").removeClass('riSingle');
                $("#ctl00_ContentPlaceHolder1_rdpfrom_dateInput_wrapper").removeClass('riSingle');

                $("#tblrdpFromid").removeClass('rcSingle');
                $("#tblrdpToid").removeClass('rcSingle');

                //these code of part used for hiding div deu to after insersion of date is not working properlly
                var p = $('#divrdpId').position();
                if (p.top > 1 && p.top < 78) {
                    $('#divrdpId').hide();
                    //alert(p.top);
                }
                else
                    $('#divrdpId').show();
                //alert(p.top);


            });
        });

       

    </script>
   
    <script type="text/javascript" language="javascript">
        function setFocus() {
            var screenhtg = set_NiceScrollToPanel();
            if (screen.height > 721) {
                $("html").css('overflow-y', 'hidden');
                $("html").css('overflow-x', 'auto');
            }
        
            if (document.getElementById("<%=txtSearch_Issue.ClientID %>") != null)
                document.getElementById("<%=txtSearch_Issue.ClientID %>").focus();

        }
        window.onload = setFocus;
</script>
    </telerik:RadCodeBlock>
     <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
<script type="text/javascript" language="javascript">

    function open_space(id) {

        document.getElementById('ContentPlaceHolder1_hf_space_id').value = id;
        document.getElementById('ContentPlaceHolder1_btn_navigate_space').click();

    }

</script>
      
      </telerik:RadCodeBlock>

  <%--<telerik:RadAjaxManager ID="RadAjaxManager" runat="server" UpdatePanelsRenderMode="Inline">
    </telerik:RadAjaxManager>--%>
   
    <telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
    <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch">
    <table cellpadding="0" cellspacing="0" width="100%" border="0" align="left"  style="table-layout:fixed;">
       <caption>
            <asp:Image ID="Image3" runat="server" ImageUrl="~/App/Images/Issue.gif" />
            <asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Issues%>"></asp:Label>
                
       </caption>
        <tr>
            <td align="center" style="width:100%;">
                <asp:Label ID="lblMsg" runat="server" ForeColor="red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <div style="width:100%;" id="divrdpId" >
                    <table width="80%">
                        <tr>
                        <td align="left" style="font-size: small; font-weight: lighter; ">
                        <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource, From%>"></asp:Label>:  </td>
                        <td align="left">
                        <div  >
                     
                        <telerik:RadDatePicker  ID="rdpfrom" runat="server" TabIndex="1"  Width="200px"  style="display:block;position:;"  >
                                
                        <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"  
                            ViewSelectorText="x"  runat="server">
                        </Calendar>
                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="1"></DatePopupButton>
                        <DateInput ID="fromdate_input" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" ToolTip="Date Input"
                            TabIndex="1" runat="server">
                        </DateInput>
                        </telerik:RadDatePicker> 
                      
                        </div>
                        </td>
                        <td style="font-size: small; font-weight: lighter;"><asp:Label ID="Label3" runat="server" Text="<%$Resources:Resource, To%>"></asp:Label>: </td>
                        <td>
                        <telerik:RadDatePicker ID="rdpto" runat="server" TabIndex="2" Width="200px" AutoPostBack="false">
                        <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                            ViewSelectorText="x" runat="server">
                        </Calendar>
                        <DatePopupButton   TabIndex="2"></DatePopupButton>
                        <DateInput ID="todate_input" DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" TabIndex="2"
                            runat="server">
                        </DateInput>
                        </telerik:RadDatePicker>
                    </td>
                    <td style="font-size: small; font-weight: lighter;">&nbsp;&nbsp;<asp:Label ID="Label4" runat="server" Text="<%$Resources:Resource, Category%>"></asp:Label>:</td>
                    <td>
                    <telerik:RadComboBox ID="cmb_CategoryType" runat="server" Height="90" Width="100px"
                        TabIndex="3">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Text="All" />
                            <telerik:RadComboBoxItem Value="typename" runat="server" Text="Type" />
                            <telerik:RadComboBoxItem Value="spacename" runat="server" Text="Space" />
                            <telerik:RadComboBoxItem Value="assetname" runat="server" Text="Component" />
                        </Items>
                    </telerik:RadComboBox>
                    </td>
                    <td style="font-size: small; font-weight: lighter;">&nbsp;&nbsp;<asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource, Facility%>"></asp:Label>:</td>
                    <td><telerik:RadComboBox ID="cmb_facility" runat="server" Height="90" Width="150px" OnItemDataBound="cmbfacility_ItemDataBound">
                      <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked="true" Text='<%# Eval("name") %>' />
                        </ItemTemplate>
                    </telerik:RadComboBox></td>
                    </tr>
                    </table>
                </div>
            </td>
        </tr>

           <tr>
            <td>
            <div style="width: 100%; height:10px;">   </div> 
             </td> 
             </tr>
          <tr >      
                <td>
                
                  <div style="width: 100%;">
                  <table><tr>
                  <td>
                 <%--<span id="Span5" style="font-size: small; font-weight: lighter;">
                    <asp:Label ID="Label5" runat="server" Text="<%$Resources:Resource, Search_By%>"></asp:Label>   :
                 </span>--%>
                 </td>
                 <td>
                     <asp:TextBox ID="txtSearch_Issue" runat="server" TabIndex="4" Width="170px"></asp:TextBox>
                </td>
                   <td><asp:Button ID="btn_clear" runat="server"  Text="<%$Resources:Resource, Clear%>" Width="80px" OnClientClick="javascript:return Clear()" /></td> 
                 
                   <td>
                     <asp:Button ID="btnSearch" runat="server" Text="<%$Resources:Resource, Show_Report%>"
                        Width="121px" OnClick="btnSearch_Click" TabIndex="5" CausesValidation="false" />
                     </td>

                  <td>  <asp:Button ID="btnpdf" runat="server" Width="121px" OnClick="btnpdf_click"
                        Text="<%$Resources:Resource, Export_To_PDF%>" TabIndex="6" /></td> 

                   <td> <asp:Button ID="btnShowAI" runat="server" Width="150px" OnClick="btnShowAI_click" OnPageIndexChanged="rgIssue_OnPageIndexChanged"
                        Text="<%$Resources:Resource, Show_All_Issues%>" TabIndex="7"  /></td> 
                    </tr>    </table>
                 </div>    
               
                </td> 
            
         </tr>

           <tr>
            <td colspan="2">
                <div style="margin-top: 15px; width: 95%;table-layout:fixed;">
                    <telerik:RadGrid ID="rgIssue" runat="server" BorderWidth="1px" CellPadding="0" Skin="Default"
                        AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True" OnItemCommand="rgIssue_ItemCommand" OnItemDataBound="rgIssue_ItemDataBound" OnPageIndexChanged="rgIssue_OnPageIndexChanged"
                        OnSortCommand="rgIssue_OnSortCommand"  Width="100%"
                         OnPageSizeChanged="rgIssue_OnPageSizeChanged" 
                       
                        PagerStyle-AlwaysVisible="true"  
                        GridLines="None" TabIndex="7"  >
                        <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" width="100%"/>
                        <MasterTableView DataKeyNames="pk_work_order_id">
                            <Columns>
                                <telerik:GridBoundColumn DataField="pk_work_order_id" HeaderText="cb_issues_id" Visible="false">
                                    <ItemStyle CssClass="column"/>
                                </telerik:GridBoundColumn>
                                
                                <telerik:GridButtonColumn ButtonType="LinkButton" DataTextField="work_ordername" CommandName="Profile" 
                                    HeaderText="<%$Resources:Resource, Issue_Name%>" SortExpression="work_ordername" >
                                    <ItemStyle CssClass="column"  Font-Underline="true" Width="150px" />
                                </telerik:GridButtonColumn>

                                
                                 <telerik:GridBoundColumn DataField="work_order_number" HeaderText="<%$Resources:Resource, Issue_Number%>"  SortExpression="work_order_number" >
                                   <ItemStyle CssClass="column"  Width="100px" />
                                </telerik:GridBoundColumn>
                                
                                <telerik:GridBoundColumn DataField="work_order_type" HeaderText="<%$Resources:Resource, Issue_Type%>"  SortExpression="work_order_type" >
                                    <ItemStyle CssClass="column"  Width="120px" />
                                </telerik:GridBoundColumn>

                                 <telerik:GridBoundColumn DataField="priority" HeaderText="<%$Resources:Resource, Priority%>"  SortExpression="priority" >
                                    <%--<ItemStyle CssClass="column"  Width="100px" />--%>
                                </telerik:GridBoundColumn>
                             


                                <telerik:GridBoundColumn DataField="organizationusername" UniqueName="Owner" HeaderText="<%$Resources:Resource, Assigned_To%>" SortExpression ="organizationusername">
                                   <ItemStyle CssClass="column" Width="80px" />
                                </telerik:GridBoundColumn>


                                <telerik:GridBoundColumn DataField="requested_by" UniqueName="Owner" HeaderText="<%$Resources:Resource, Requested_By%>" SortExpression ="requested_by">
                                   <ItemStyle CssClass="column" Width="100px" />
                                </telerik:GridBoundColumn>
                                


                          
                                
                                <telerik:GridBoundColumn DataField="created_on" HeaderText="<%$Resources:Resource, Created_On%>" SortExpression="created_on" >
                                    <ItemStyle CssClass="column"  Width="100px" />
                                </telerik:GridBoundColumn>

                                 <telerik:GridBoundColumn DataField="work_orderstatus" HeaderText="<%$Resources:Resource, Issue_Status%>" SortExpression="work_orderstatus">                                      
                                 <ItemStyle CssClass="column"  Width="100px" />
                                </telerik:GridBoundColumn>
                                  <%--<telerik:GridBoundColumn DataField="work_orderstatus" HeaderText="work_orderStatus" Visible="false">
                                    
                                </telerik:GridBoundColumn>--%>
                        
                                
                                 <telerik:GridTemplateColumn DataField="pk_work_order_id" UniqueName="imgbtnclose_" HeaderText="<%$Resources:Resource,Status%>">
                                  <%--<ItemStyle CssClass="column" Width="5%" />--%>
                                  <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnclose" runat="server" alt="<%$Resources:Resource, Resolved%>" CommandName ="closeIssue"  ImageUrl="~/App/Images/remove.gif" OnClientClick="javascript:return close_issues();"/>
                                  </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn DataField="pk_work_order_id" UniqueName="imgbtnDelete_" HeaderText="<%$Resources:Resource,Delete%>">
                                  <%--<ItemStyle CssClass="column"  Width="5%"/>--%>
                                  <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" runat="server" alt="<%$Resources:Resource, Delete%>" CommandName ="deleteIssue"  ImageUrl="~/App/Images/Delete.gif" OnClientClick="javascript:return delete_issues();"/>
                                  </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <br />
                    <asp:Button ID="Button1" Text="<%$Resources:Resource, Add_Issue%>" runat="server" OnClick="btnaddissue_click"/>
                    
                </div>
            </td>
        </tr>
                
    </table>
    </asp:Panel>
    
     
    <div style="display:none">
    <asp:Button ID="btn_navigate_space" runat="server" OnClick="navigate_space"/>
    </div>

    <div style="display: none">
        <asp:Button ID="btn_navigate" runat="server" OnClick="navigate" />
    </div>
      <telerik:RadAjaxManagerProxy ID="issueProfilesManagerProxy" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnShowAI">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgIssue" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="btnShowAI" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="panelSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdpfrom" LoadingPanelID="loadingPanel1" />
                  
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="rdpfrom">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdpfrom" LoadingPanelID="loadingPanel1" />
                  
                </UpdatedControls>
            </telerik:AjaxSetting>

             <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgIssue" LoadingPanelID="loadingPanel1" />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server">
       
    </telerik:RadAjaxLoadingPanel>
     <asp:HiddenField ID="hf_space_id" runat="server"/>
     <asp:HiddenField ID="hf_facility_id" runat="server"/>
    <asp:HiddenField ID="hfcount" runat="server"/>
     <asp:HiddenField ID="hffacids" runat="server"/>
     
</asp:Content>
