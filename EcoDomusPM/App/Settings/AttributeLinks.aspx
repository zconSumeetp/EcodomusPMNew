<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AttributeLinks.aspx.cs" Inherits="App_Settings_AttributeLinks" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script type="text/javascript" language="javascript" >
        function delete_link() {
            var flag = confirm("Do you want to delete this file?");
            return flag;
        }
        function LogoutNavigation() {

            var query = parent.location.href;
            top.location.href(query);

        }
        //This Function set scroll Height to fix when docheight is less than scrollHeight
        function GridCreated(sender, args) {

            var pageSize = document.getElementById("hfDocumentPMPageSize").value;
            var scrollArea = sender.GridDataDiv;
            var dataHeight = sender.get_masterTableView().get_element().clientHeight;
            if (!flag) {
                if (dataHeight < parseInt(pageSize) * 40) {
                    scrollArea.style.height = dataHeight + "px";
                }
                else {
                    scrollArea.style.height = (parseInt(pageSize) * 40 - 12) + "px";
                }
            }
            else {

                if (dataHeight - 260 > 180)
                    scrollArea.style.height = (dataHeight - 220) + "px";
                else if (dataHeight - 260 < 180 && dataHeight > 220)
                    scrollArea.style.height = 220 + "px";
                else
                    scrollArea.style.height = dataHeight + "px";
                flag = false;
            }

        }

        var flag = false;
        function resize_gridHeight() {

            flag = true;
        }
        </script>
        <link  href="../../App_Themes/EcoDomus/style_new_ui_pm.css" type="text/css" runat="server"/>
         <link id="Link1"  href="~/App_Themes/EcoDomus/style_new_1.css" type="text/css" runat="server"/>
</head>
<body style=" background:#F7F7F7; margin:0 0 0 0;">
     <form id="form1" runat="server" style=" margin:0 0 0 0;">
           
            <asp:ScriptManager ID="ScriptManager1" runat ="server"></asp:ScriptManager>

             <telerik:RadFormDecorator ID="rdfAll" DecoratedControls="Buttons" Skin="Default" runat="server" />

           <%--  <div style="padding-left: 20px;">--%>
             <table style="height: 100%; width:100%; vertical-align: top;" cellpadding="0"
                cellspacing="0" border="0">
               <%-- <caption id="Link_cap" runat="server"  style="width:400px; font-size:20px;">
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/App/Images/Icons/project_48.gif" />
                     <asp:Label  ID="Links" Text="<%$ Resources:Resource,Links %>" runat="server" 
                        Font-Bold="False"></asp:Label> 
                 </caption>--%>
                <%--<tr>
                <th id="Th1" align="left" colspan="2" runat="server" style="width:100%">
                Organization: <asp:Label id="lbltitleOrg"  runat="server"></asp:Label>
                </th>
                </tr>--%>     
                                        
                <tr>
                    <td class="centerAlign" colspan="5">
                    <div class="rpbItemHeader">
                     <table cellpadding="0" cellspacing="0" width="100%" style="background-color:#808080;">
                        <tr>
                            <td align="left" class="entityImage" onclick="stopPropagation(event)" style="width:35%;padding-left:05px;">
                              <asp:Label runat="server" Text="<%$Resources:Resource,Links%>" ID="lbl_grid_head"
                                                            CssClass="gridHeadText" Width="100px" ForeColor="#F8F8F8" Font-Names="Arial"
                                                            Font-Size="12"></asp:Label>
                            </td>
                             <td id="Td1" onclick="stopPropagation(event)" visible="false" runat="server">
                                                        <asp:Label ID="Label2" runat="server" Text="<%$Resources:Resource,Facility_Name%>"
                                                            CssClass="gridHeadText" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="10">:</asp:Label>
                                                        :<asp:Label runat="server" ID="lblFacilityName" CssClass="Label" Visible="false"></asp:Label>
                             </td>  
                              <td align="right" style=" background-color:#808080;padding-top: 02px; padding-bottom: 02px;" >
                                <div id="div1" style="width: 200px; background-color: white;" >
                                    <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch"> 
                                    <table>
                                        <tr>

                                            <td>
                                             <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                            Height="100%" EmptyMessage="Search" BorderColor="White" ID="txtSearchText" Width="180px">
                                                                        </telerik:RadTextBox>
                                            </td>
                                            <td>
                                             <asp:ImageButton ClientIDMode="Static" ID="btnSearch" Height="13px" runat="server"
                                                                            ImageUrl="~/App/Images/Icons/icon_search_sm.png" 
                                                    onclick="btnSearch_Click"  /> <%--OnClick="btnSearch_Click"--%>
                                            </td>
                                        </tr>
                                    </table>
                                    </asp:Panel>
                                </div>
                            </td>
                            <td align="right" style="padding: 4px 6px 0 0;width:10px;" >
                               <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png" ClientIDMode="Static"
                                    ID="RightMenu_1_img_expand_collapse" onClick="RightMenu_expand_collapse(1)" />
                                --%>  
                            </td>
                        </tr>
                    </table>
                    </div>
                        <div style="margin-top: 0px;">
                            <telerik:RadGrid ID="rgAttributeLink" runat="server" 
                                AutoGenerateColumns="False" OnSortCommand="rgAttributeLink_OnSortCommand" OnItemCommand="rgAttributeLink_OnItemCommand"
                               AllowSorting="True" GridLines="None"  PagerStyle-AlwaysVisible="true" 
                                AllowPaging="true" PageSize="10"  
                                OnPageIndexChanged="rgAttributeLink_OnPageIndexChanged" 
                                OnPageSizeChanged="rgAttributeLink_OnPageSizeChanged" Skin="Default" 
                                onitemcreated="rgAttributeLink_ItemCreated" 
                                onitemdatabound="rgAttributeLink_ItemDataBound" >
                                <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" />
                                <ClientSettings EnableAlternatingItems="true" EnableRowHoverStyle="true">
                                <Selecting AllowRowSelect="true"/>
                                <ClientEvents OnGridCreated="GridCreated" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="400px" />
                                </ClientSettings>
                                <MasterTableView CommandItemDisplay="Top" CommandItemSettings-AddNewRecordText="Add New" CommandItemSettings-ShowRefreshButton="false" DataKeyNames="attribute_hyperlink_id,Name,URL_Link,Attribute_Name">
                                    <ItemStyle Height="31px" Font-Names="Arial" Font-Size="10"  />
                                <AlternatingItemStyle Height="31px"  Font-Names="Arial" Font-Size="10" />
                                 <HeaderStyle Height="27px" Font-Names="Arial" Font-Size="10" />
                                <FooterStyle Height="25px" Font-Names="Arial"/>
                                    <Columns>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton"
                                        UniqueName="EditCommandColumn"  HeaderText="<%$Resources:Resource,Edit%>">
                                       <%--  <ItemStyle CssClass="column" Width="4%" Wrap="false" />
                                        <HeaderStyle CssClass="column" Width="4%" Wrap="false" />--%>
                                    </telerik:GridEditCommandColumn>
                                        <telerik:GridBoundColumn DataField="Name" HeaderText="<%$Resources:Resource,Name%>" UniqueName="Name">
                                            <ItemStyle CssClass="" Wrap="false"  Width="30%" />
                                             <HeaderStyle CssClass="column" Wrap="false" Width="30%" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn EditFormColumnIndex="1" DataField="Attribute_Name" CurrentFilterFunction="Contains" HeaderText="<%$Resources:Resource,Attribute_Name%>" UniqueName="AttributeName">
                                            <ItemStyle CssClass="" Wrap="false"  Width="30%" />
                                            <HeaderStyle CssClass="column" Wrap="false"   Width="30%" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn EditFormColumnIndex="2" DataField="URL_Link" HeaderText="<%$Resources:Resource,URL%>" UniqueName="URL">
                                            <ItemStyle CssClass=""  Wrap="false"  Width="30%" />
                                            <HeaderStyle CssClass="column" Font-Underline="false" Wrap="false"  Width="30%" />
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridTemplateColumn DataField="project_hyperlink_id" UniqueName="project_hyperlink_id"
                                            Visible="true" HeaderText="<%$Resources:Resource,Edit%>">
                                            <ItemStyle CssClass="column" Width="5%"  />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnEdit" runat="server" Text="<%$Resources:Resource,Edit%>" CommandName="Update" CommandArgument="edit"
                                                    Font-Underline="true" Width="15px" CausesValidation="false"> 
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>--%>
                                        <telerik:GridTemplateColumn DataField="attribute_hyperlink_id" UniqueName="attribute_hyperlink_id"
                                            Visible="true"  HeaderText="<%$Resources:Resource,Delete%>" >
                                            <ItemStyle CssClass="column" Wrap="false" Width="5%" />
                                             <HeaderStyle CssClass="column" Wrap="false" Width="5%" />
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnDelete" runat="server" Width="20px" Height="20px" alt="Delete" OnClientClick="javascript:return delete_link();" CommandName="deletehyperlink"
                                                    ImageUrl="~/App/Images/Delete.gif" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <%--<ExpandCollapseColumn Visible="False">
                                        <HeaderStyle Width="19px" />
                                    </ExpandCollapseColumn>
                                    <RowIndicatorColumn Visible="False">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>--%>
                                <EditFormSettings ColumnNumber="3" EditFormType="AutoGenerated" InsertCaption="Add New:"  CaptionFormatString="Edit:">
                                     <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                                    <FormCaptionStyle CssClass=""></FormCaptionStyle>
                                    <FormMainTableStyle GridLines="None" BackColor="White" Width="100%" />
                                    <FormTableStyle BackColor="White" Height="50px" />
                                    <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                                    <EditColumn ButtonType="ImageButton" UpdateText="Update record" UniqueName="EditCommandColumn1"
                                        CancelText="Cancel" UpdateImageUrl="~/App/Images/sign1.jpg">
                                    </EditColumn>
                                    <EditColumn ButtonType="ImageButton" InsertText="Insert Record"  UniqueName="EditColumnInsertColum2"
                                        CancelText="Cancel" >
                                    </EditColumn>
                                    <EditColumn UniqueName="EditColumn">
                                    </EditColumn>
                                    <FormTableButtonRowStyle HorizontalAlign="Right" CssClass=""></FormTableButtonRowStyle>
                                </EditFormSettings>
                                </MasterTableView>
                                
                                <AlternatingItemStyle CssClass="alternateColor" />
                            </telerik:RadGrid>
                        </div>
                    </td>
                </tr>
                
            </table>
            
              <table width="95%" style="vertical-align: top; display:none;" cellpadding="15px" cellspacing="0"  border="0">
                <tr>
                    <td>
                        <asp:Button ID="btnAddNew" runat="server" Text="<%$Resources:Resource,Add_New%>" OnClick="btnAddNew_OnClick" CausesValidation="false" />
                    </td>
                </tr>
                <tr> <td>
                    &nbsp;   &nbsp;   &nbsp;
                </td></tr>
                <tr>
                <td>
                    <table id="addtbl" runat="server" border="0">
                        <tr>
                            <td>
                                <asp:Label ID="lblAddAttribute" Text=" Add New Attributelink:" CssClass=" taskheading "  runat="server"></asp:Label>  
                            </td>
                        </tr>
                        <tr> <td>
                               &nbsp;   &nbsp;   &nbsp;
                       </td></tr>
                        <tr>
                            <td>
                            <asp:Label ID="lblName" Text="<%$Resources:Resource,Name%>" CssClass="LabelText" runat="server"></asp:Label>:
                           </td>
                            <td align="left">
                                    <asp:TextBox ID="txtName" TabIndex="17" runat="server" Width="250px"></asp:TextBox>
                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName"
                                    ErrorMessage="*" Display="Dynamic" ForeColor="Red" ValidationGroup="rfv"></asp:RequiredFieldValidator>
                            </td>
                          </tr>
                        <tr>
                            <td>
                            <asp:Label ID="lblAttributeName" Text="<%$Resources:Resource,Attribute_Name%>" CssClass="LabelText" runat="server">:</asp:Label>:  
                           </td>

                            <td align="left">
                                <asp:TextBox ID="txtAttribute" runat="server" TabIndex="18" Width="250px"></asp:TextBox>
                                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAttribute"
                                    ErrorMessage="*" Display="Dynamic"  ForeColor="Red" ValidationGroup="rfv"></asp:RequiredFieldValidator >
                            </td>
                            
                        </tr>
                        <tr>
                            <td>
                                 <asp:Label ID="lblURL" Text="<%$Resources:Resource,URL%>" CssClass="LabelText" runat="server">:</asp:Label>:  
                           </td>
                            
                            <td align="left">
                                <asp:TextBox ID="txtURLLink" runat="server" TabIndex="19" Width="250px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtURLLink"
                                    ErrorMessage="*"  ForeColor="Red" Display="Dynamic" ValidationGroup="rfv"></asp:RequiredFieldValidator>
                              
                            </td>
                         
                            
                        </tr>
                        <tr> <td>
                               &nbsp;   &nbsp;   &nbsp;
                       </td></tr>
                         <tr>
                            <td colspan="2">
                                <asp:Button ID="btnSave" runat="server" Text="<%$Resources:Resource,Save%>" Width="100px" TabIndex="20" 
                                    ValidationGroup="rfv" onclick="btnSave_Click"/>
                                <asp:Button ID="btnupdate" runat="server" Text="<%$Resources:Resource,Update%>" Visible="false" 
                                    Width="100px" TabIndex="21" ValidationGroup="rfv" onclick="btnupdate_Click"  />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" Text="<%$Resources:Resource,Cancel%>" TabIndex="22" 
                                    Width="100px" CausesValidation="false" onclick="btnCancel_Click" />
                            </td>
                        </tr>
                    </table>
                 </td>
                </tr>
                <tr>
                  
                    <td>
                      <asp:HiddenField ID="hfDocumentPMPageSize"  runat="server" Value="" />
                        <asp:HiddenField ID="hfHyperlinkid" runat="server" />
                        <asp:HiddenField ID="hfname" runat="server" />
                        <asp:HiddenField ID="hfattributename" runat="server" />
                        <asp:HiddenField ID="hfurl" runat="server" />
                        <asp:HiddenField ID="hfuserId" runat="server" />
                        <asp:HiddenField ID="hfOrganizationid" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
            </table>
            <telerik:RadAjaxManager ID="ramTypeAttribute"  runat="server" EnableAJAX="true" >
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rgAttributeLink">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAttributeLink" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgAttributeLink" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
         </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>
           <%-- </div>     --%>
     </form>
</body>
</html>
