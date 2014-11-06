<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignOrganization.aspx.cs" Inherits="App_Settings_AssignOrganization" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Assign Organization</title>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
<script language="javascript" type="text/javascript">
    function Clear() 
    {
        try 
        {
            document.getElementById("txtSearchOrganization").value = "";
            return false;
        }
        catch (e)
         {
            alert(e.message + "  " + e.Number);
            return false;
        }
    }

    function stopPropagation(e) {

        e.cancelBubble = true;

        if (e.stopPropagation)
            e.stopPropagation();
    }
    function check() 
    {
        var grid = $find("<%=rgOrganizations.ClientID %>");
        var MasterTable = grid.get_masterTableView();
        var selectedRows = MasterTable.get_selectedItems();
        if (selectedRows.length == 0) {
            alert("Please Select Organization");
//            lblMsg.innerText = "Please Select Organization";
            return false;
        }
        else 
        {
            lblMsg.innerText = "";
            window.close();            
        }
    }

    function selectedPP(id, name, value) 
    {
                     
        if (value=="L") {
        
            window.parent.document.getElementById("hflblOrganization").value = id;
            window.parent.document.getElementById("lblCreatedNm").innerText = name;
            
            window.parent.document.getElementById("hf_lead_org_name").innerText = name;//added            
            closewindow();
            window.close();
            return false;
        }

        else if (value == "O") {         
             window.parent.document.getElementById("hflblOwnerOrg").value = id;
             window.parent.document.getElementById("lblOwnerNm").innerText = name;

             window.parent.document.getElementById("hftxtownerorganization_value").value = name;

             window.parent.document.getElementById("hf_org_name").innerText = name; //added
             window.parent.bind_dropdown();
             window.close();
            // return false;
        }        
        closewindow();
    }

    function closewindow()
     {
        window.close();
        return false;
    }
</script>
</telerik:RadCodeBlock>
    
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/NEWUI_Grid.css" />
    <link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
</head>
<body style="background: white; background-color:#EEEEEE; padding: 0px" >
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
      <telerik:radformdecorator id="rdfAll" decoratedcontrols="Buttons" skin="Default" runat="server" />
        <div style="overflow:hidden;" >
      
      <table width="100%" border="0">
       <%--<caption align="top">Organizations</caption>--%>
       <%--<tr style="width:100%;border-collapse:collapse;"  >
                <td  >
                     <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;">
                        <tr onclick="stopPropagation(event)">
                         <td class="wizardHeadImage">
                            <div class="wizardLeftImage" style="font-size:medium;">
                               
                                <asp:Label ID="lblAddCity" Text="Orgnization" runat="server"></asp:Label>
                            </div>
                            <div class="wizardRightImage">
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/App/Images/Icons/icon-close.png"
                                    OnClientClick="javascript:return closewindow();" />
                            </div>
                        </td>
                   </tr>
                   </table>
                </td>
            </tr>--%>
        
          <tr>
            <td  align="center">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" >
           
                <tr>
                    <td style="padding: 10px;">
                        <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" BorderWidth="0"
                            ExpandMode="MultipleExpandedItems" BorderColor="Transparent">
                            <ExpandAnimation Type="OutSine" />
                            <Items>
                                <telerik:RadPanelItem Expanded="true" Width="100%" Text="Resources" IsSeparator="false"
                                    BorderWidth="0" BorderColor="Transparent">
                                    <HeaderTemplate>
                                        <asp:Panel ID="panelSearch" runat="server" DefaultButton="btnSearch">
                                            <table cellpadding="0px" cellspacing="0px" class="gridRadPnlHeader" border="0">
                                                <tr>
                                                    <td align="left" class="entityImage" onclick="stopPropagation(event)">
                                                        <asp:Label runat="server" Text="Assign Orgnization" ID="lbl_grid_head" CssClass="gridHeadText"
                                                            Width="70%" ForeColor="#F8F8F8" Font-Names="Arial" Font-Size="12"></asp:Label>
                                                    </td>
                                                    <td align="right" onclick="stopPropagation(event)">
                                                        <div id="div_search" style="background-color: White; width: 170px;">
                                                            <table border="0px" cellpadding="0px" cellspacing="0px" style="background-color: White;
                                                                width: 100%;">
                                                                <tr style="border-spacing=0px;">
                                                                    <td align="left" width="70%" rowspan="0px" style="background-color: White; height: 14px;
                                                                        padding-bottom: 0px;" onclick="stopPropagation(event)">
                                                                        <telerik:RadTextBox CssClass="txtboxHeight" ClientIDMode="Static" runat="server"
                                                                            onclick="stopPropagation(event)" Height="100%" EmptyMessage="Search" BorderColor="White"
                                                                            ID="txtSearchOrganization" TabIndex="17" Width="100%">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td align="left" rowspan="0px" width="10%" style="background-color: White; height: 14px;
                                                                        padding-bottom: 0px;" onclick="stopPropagation(event)">
                                                                        <asp:ImageButton ClientIDMode="Static" OnClick="btnSearch_Click1" ID="btnSearch"
                                                                            CausesValidation="false" TabIndex="18" Height="13px" runat="server" ImageUrl="~/App/Images/Icons/icon_search_sm.png" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                    <td style="padding-right:10px;" class="dropDownImage">
                                                       <%-- <asp:Image runat="server" ImageUrl="~/App/Images/Icons/asset_carrot_up_white.png"
                                                            ID="img_arrow" />--%>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tbl_jobs1" runat="server" cellpadding="0" cellspacing="0" width="100%"
                                                style="background-color: #707070; border-width: 0px;">
                                                <tr>
                                                    <td class="gridRadPnlHeaderBottom" onclick="stopPropagation(event)" style="height: 1px">
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <telerik:RadGrid ID="rgOrganizations" runat="server" CellPadding="0" AllowPaging="True"
                                            AllowMultiRowSelection="false" Width="100%" OnItemCreated="rgOrganizations_ItemCreated"
                                            PageSize="10" AutoGenerateColumns="false" AllowSorting="true" OnItemCommand="rgOrganizations_ItemCommand">
                                            <PagerStyle Mode="NextPrevAndNumeric" ShowPagerText="true" HorizontalAlign="Left" />
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="true" />
                                                <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="280" />
                                            </ClientSettings>
                                            <MasterTableView CommandItemDisplay="top" DataKeyNames="pk_organization_id">
                                                <CommandItemTemplate>
                                                    <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                                                </CommandItemTemplate>
                                                <Columns>
                                                    <telerik:GridClientSelectColumn>
                                                        <ItemStyle Width="10%" />
                                                         <HeaderStyle Width="10%" />
                                                    </telerik:GridClientSelectColumn>
                                                    <telerik:GridBoundColumn DataField="pk_organization_id" HeaderText="pk_organization_id"
                                                        UniqueName="pk_organization_id" Visible="false">
                                                        <ItemStyle CssClass="itemstyle" Width="20px"></ItemStyle>
                                                        <HeaderStyle Font-Size="11px" Font-Bold="true" Font-Names="Lucida Sans Unicode" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="name" HeaderText="Organization Name" UniqueName="name"
                                                        AllowSorting="true" SortExpression="name">
                                                        <ItemStyle CssClass="itemstyle" Width="30%"></ItemStyle>
                                                        <HeaderStyle   Width="30%"/>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Type" HeaderText="Organization Type" UniqueName="Type"
                                                        AllowSorting="true">
                                                        <ItemStyle CssClass="itemstyle" Width="50%"></ItemStyle>
                                                        <HeaderStyle Width="50%" />
                                                    </telerik:GridBoundColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </ContentTemplate>
                                </telerik:RadPanelItem>
                            </Items>
                        </telerik:RadPanelBar>
                    </td>
                </tr>
                   
          
            </table>
            </td>
          </tr>
         
       

        <tr>
            <td style="padding-left:80px;">
                <asp:Label ID = "lblMsg" runat="server" ForeColor ="red" ></asp:Label>
            </td>
        </tr>
         
        <tr>
            <td style="padding-left:10px;" >
                <asp:Button ID="btnClose" runat="server" Width="100px" Text="Select" OnClick="btnClose_Click" OnClientClick="javascript:return check();"  />
                <asp:HiddenField ID="hftype" runat="server" />
                <asp:Button ID="btnclosewindow" runat="server" Text="Close"
                   Width="90px" OnClientClick="javascript:return closewindow();" />
            </td>
        </tr>
    </table>  
  
    </div>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgOrganizations" LoadingPanelID="loadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px">
        <img alt="Loading..." src='<%= RadAjaxLoadingPanel.GetWebResourceUrl(Page, "Telerik.Web.UI.Skins.Default.Ajax.loading.gif") %>'
            style="border: 0px;" />
    </telerik:RadAjaxLoadingPanel>
    </form>
    
</body>
</html>
