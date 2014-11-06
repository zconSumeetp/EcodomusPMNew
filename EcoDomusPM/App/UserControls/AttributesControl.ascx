<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AttributesControl.ascx.cs" Inherits="App.UserControls.AttributesControl" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Reference Control="~/App/UserControls/AttributeDetails.ascx" %>

<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript">
        // AttributesControl
        var AttributesControl = (function () { return {
            // PageLoad
            PageLoad: function () {
                var hiddenFieldIsPageSizeCalculated = $get("<%= HiddenFieldIsPageSizeCalculated.ClientID %>");
                if (!hiddenFieldIsPageSizeCalculated) return;
                var isPageSizeCalculated = (hiddenFieldIsPageSizeCalculated.value == "<%= true %>");

                if (!isPageSizeCalculated) {
                    var height = AttributesControl.RadGridAttributes.GetHeight();
                    AttributesControl.SendCommand("<%= Command.GridPageSizeCalculatingNeeded %>", height.toString());
                }

                //AttributesControl.RadGridAttributes.AttachNiceScroll();

                //var radGridAttributesMutationObserver = new GridMutationObserver(AttributesControl.RadGridAttributes.className, AttributesControl.RadGridAttributes.niceScroll);
                //radGridAttributesMutationObserver.Start();
            },

            // RadGridAttributes
            RadGridAttributes:
            {
                // ClientID
                ClientID: "<%= RadGridAttributes.ClientID %>",

                // niceScroll
                niceScroll: null,

                // className
                className: "RadGridAttributes",

                // AttachNiceScroll
                AttachNiceScroll: function () {
                    var dataDiv = $(".RadGridAttributes .rgDataDiv");
                    AttributesControl.RadGridAttributes.niceScroll = Common.AttachNiceScroll(dataDiv, true);
                },

                // OnGroupExpandedCollapsed
                OnGroupExpandedCollapsed: function (sender, eventArgs) {
                    //Common.ResizeNiceScroll(AttributesControl.RadGridAttributes.niceScroll);
                },

                // GetHeight
                GetHeight: function () {
                    var grid = $find(AttributesControl.RadGridAttributes.ClientID);
                    return $(grid.GridDataDiv).height();
                },

                OnGridCreated: function (sender, eventArgs) {
                    var grid = sender;
                    var column = grid.get_masterTableView().getColumnByUniqueName("AttributeValue");
                    var columnWidth = column.get_element().clientWidth;
                    var minimalColumnWidth = 250;

                    if (columnWidth < minimalColumnWidth) {
                        columnWidth = minimalColumnWidth;
                    }

                    grid.get_masterTableView().resizeColumn(column.get_element().cellIndex, columnWidth);
                },

                // RadButtonDelete
                RadButtonDelete:
                {
                    // OnClientClicking
                    OnClientClicked: function (sender, eventArgs) {
                        var selectedRowsCount = $find("<%= RadGridAttributes.ClientID %>").get_masterTableView().get_selectedItems().length;
                        if (selectedRowsCount == 0) {
                            return;
                        }

                        //if (!confirm("Are you sure you want to remove the selected attribute(s)?")) {
                        //    eventArgs.set_cancel(true);
                        //}

                        var radWindowDeleteAttributesConfirmation = $find("<%= RadWindowDeleteAttributesConfirmation.ClientID %>");
                        radWindowDeleteAttributesConfirmation.show();
                    }
                }
            },

            // SendCommand
            SendCommand: function (commandName, commandArgument) {
                var radButtonCommand = $find("<%= RadButtonCommand.ClientID %>");
                radButtonCommand.set_commandName(commandName);
                radButtonCommand.set_commandArgument(commandArgument);

                var radAjaxManager = $find("<%= RadAjaxManager.GetCurrent(Page).ClientID %>");
                radAjaxManager.ajaxRequestWithTarget("<%= RadButtonCommand.UniqueID %>", "");
            },

            // RadWindowDeleteAttributesConfirmation
            RadWindowDeleteAttributesConfirmation:
            {
                Close: function() {
                    var radWindowDeleteAttributesConfirmation = $find("<%= RadWindowDeleteAttributesConfirmation.ClientID %>");
                    radWindowDeleteAttributesConfirmation.close();
                },

                // RadButtonCancel
                RadButtonCancel:
                {
                    // OnClientClicked
                    OnClientClicked: function (sender, eventArgs) {
                        AttributesControl.RadWindowDeleteAttributesConfirmation.Close();
                    }
                },

                // RadButtonDeleteAttributes
                RadButtonDeleteAttributes:
                {
                    // OnClientClicked
                    OnClientClicked: function (sender, eventArgs) {
                        AttributesControl.RadWindowDeleteAttributesConfirmation.Close();
                    }
                },

                // RadButtonDeleteAttributesOfAllTypes
                RadButtonDeleteAttributesOfAllTypes:
                {
                    // OnClientClicked
                    OnClientClicked: function (sender, eventArgs) {
                        AttributesControl.RadWindowDeleteAttributesConfirmation.Close();
                    }
                }
            }

        }})();
        
        //$(document).bind("PageLoad", AttributesControl.PageLoad);
    </script>
</telerik:RadScriptBlock>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="RadGridAttributes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadGridAttributes" LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelHeight="100%" />                
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="RadButtonCommand">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadGridAttributes" LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelHeight="100%" />
                <telerik:AjaxUpdatedControl ControlID="HiddenFieldIsPageSizeCalculated" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="RadScriptManager1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadGridAttributes" LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelHeight="100%" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="RadButtonDeleteAttributes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadGridAttributes" LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelHeight="100%" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="RadButtonDeleteAttributesOfAllTypes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadGridAttributes" LoadingPanelID="RadAjaxLoadingPanel1" UpdatePanelHeight="100%" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
    
<telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1" Skin="Default" />

<asp:ScriptManagerProxy runat="server" ID="ScriptManagerProxy" OnNavigate="ScriptManagerProxy_OnNavigate" /> 

<telerik:RadGrid ID="RadGridAttributes" runat="server" AllowPaging="true" AutoGenerateColumns="False" AllowMultiRowSelection ="true" Skin="Default" PageSize="20"
                 Culture="<%# System.Threading.Thread.CurrentThread.CurrentCulture %>" GroupingEnabled="True" OnPageIndexChanged="RadGridAttributes_OnPageIndexChanged" 
                 OnUpdateCommand="RadGridAttributes_OnUpdateCommand" OnItemDataBound="RadGridAttributes_OnItemDataBound" OnPageSizeChanged="RadGridAttributes_OnPageSizeChanged"
                 OnInsertCommand="RadGridAttributes_OnInsertCommand" CssClass="RadGrid RadGridAttributes" 
                 AllowMultiRowEdit="False" OnNeedDataSource="RadGridAttributes_OnNeedDataSource" Width="100%"> <%--Height="100%"--%>
    <PagerStyle Mode="NextPrevAndNumeric" HorizontalAlign="Right" AlwaysVisible="True" />
    <ClientSettings EnableAlternatingItems="True" EnableRowHoverStyle="True">
        <Selecting AllowRowSelect="True" UseClientSelectColumnOnly="True" />
        <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="600" /> <%--ScrollHeight="400"--%>
        <Resizing AllowColumnResize="True" AllowResizeToFit="True" ClipCellContentOnResize="True" EnableRealTimeResize="True" ResizeGridOnColumnResize="True" />
        <ClientEvents OnGroupExpanded="AttributesControl.RadGridAttributes.OnGroupExpandedCollapsed" OnGroupCollapsed="AttributesControl.RadGridAttributes.OnGroupExpandedCollapsed" OnGridCreated="AttributesControl.RadGridAttributes.OnGridCreated" />
        <ClientMessages ColumnResizeTooltipFormatString="" />
    </ClientSettings>
    <MasterTableView TableLayout="Fixed" GroupLoadMode="Client" EditMode="EditForms" DataKeyNames="AttributeId,AttributeType,DataType,IntegerValue,DateTimeValue,DoubleValue,StringValue"
                     CommandItemDisplay="Top" Font-Size="14px">
        <ItemStyle Height="29px" Wrap="False" />
        <HeaderStyle Height="31px" Wrap="False" CssClass="header-cell" />
        <AlternatingItemStyle Height="29px" Wrap="False" />
        <CommandItemTemplate>
            <div class="GridHeadDiv">
                <table style="height: 100%">
                    <tr style="height: 100%">
                        <td style="height: 100%; vertical-align: middle; border-left: 8px solid transparent;">
                            <telerik:RadButton runat="server" ID="RadButtonAdd" CssClass="GridButtons" CommandName="InitInsert" ToolTip="<%$Resources:Resource, Add_New_Type%>" Width="20px" Height="20px">
                                <Image ImageUrl="~/App/Images/Icons/asset_add_sm_white.png" HoveredImageUrl="~/App/Images/Icons/asset_add_sm_black.png" />
                            </telerik:RadButton>    
                        </td>
                        <td style="height: 100%; vertical-align: middle; border-left: 8px solid transparent;">
                            <asp:Label runat="server" ID="lbl_grid_head" Text="Add New Attribute" Font-Name="Segoe UI" Font-Size="14px" ForeColor="#FFFFFF" />    
                        </td>
                        <td style="height: 100%; vertical-align: middle; border-left: 8px solid transparent;">
                            <telerik:RadButton runat="server" ID="RadButtonDelete" CssClass="GridButtons" ToolTip="<%$Resources:Resource, Delete%>" Width="20px" Height="20px" 
                                               OnClientClicked="AttributesControl.RadGridAttributes.RadButtonDelete.OnClientClicked" AutoPostBack="False">
                                <Image ImageUrl="~/App/Images/Buttons/Delete.gif" />
                            </telerik:RadButton>    
                        </td>
                        <td style="height: 100%; vertical-align: middle; border-left: 8px solid transparent;">
                            <asp:Label runat="server" Text="Delete attribute(s)" Font-Name="Segoe UI" Font-Size="14px" ForeColor="#FFFFFF" />    
                        </td>
                    </tr>
                </table>
            </div>
        </CommandItemTemplate>
        <GroupByExpressions>
            <telerik:GridGroupByExpression>
                <SelectFields>
                    <telerik:GridGroupByField FieldAlias="Group" FieldName="Group" FormatString="" HeaderText="" SortOrder="None" />
                </SelectFields>
                <GroupByFields>
                    <telerik:GridGroupByField FieldName="Group" />
                </GroupByFields>
            </telerik:GridGroupByExpression>
        </GroupByExpressions>
        <Columns>
            <telerik:GridClientSelectColumn UniqueName="Select" HeaderText="<%$Resources:Resource, Delete%>" HeaderTooltip="Select all" Resizable="False">
                <ItemStyle Width="40px" Wrap="false" HorizontalAlign="Center" />
                <HeaderStyle Width="40px" Wrap="false" HorizontalAlign="Center" />
            </telerik:GridClientSelectColumn>
            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" HeaderToolTip="<%$Resources:Resource, Edit%>" HeaderImageUrl="~/App/Images/Icons/edit.gif" Resizable="False">
                <HeaderStyle Width="41px" HorizontalAlign="Center" />
                <ItemStyle Width="41px" HorizontalAlign="Center" />
            </telerik:GridEditCommandColumn>
            <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, Attribute_Name%>" UniqueName="AttributeName" HeaderTooltip="<%$Resources:Resource, Attribute_Name%>">
                <HeaderStyle Width="250px" />
                <ItemStyle Width="250px" />
                <ItemTemplate>
                    <asp:Label runat="server" ID="LabelAttributeName" Text='<%# DataBinder.Eval(Container.DataItem, "Name")%>' ToolTip='<%# DataBinder.Eval(Container.DataItem, "Name")%>' />
                </ItemTemplate>   
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn UniqueName="AttributeValue" HeaderText="<%$Resources:Resource, Value%>" HeaderToolTip="<%$Resources:Resource, Value%>">
                <HeaderStyle Width="250px" />
                <ItemStyle Width="250px" />
                <ItemTemplate>
                    <asp:Label runat="server" ID="LabelAttributeValue" Visible="True"/>
                    <asp:CheckBox  runat="server" ID="CheckBoxAttributeValue" Visible="False" Enabled="False"/>
                </ItemTemplate>   
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, Unit%>" DataField="DisplayUnitType" HeaderToolTip="<%$Resources:Resource, Unit%>" Visible="false">
                <%--<ItemStyle Width="100px" />--%>
                <ItemTemplate>
                    <asp:Label ID="lblunit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DisplayUnitType")%>' ToolTip='<%# DataBinder.Eval(Container.DataItem, "DisplayUnitType")%>' /> 
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, Stage%>" DataField="StageName" HeaderToolTip="<%$Resources:Resource, Stage%>">
                <HeaderStyle Width="161px" />
                <ItemStyle Width="161px" />
                <ItemTemplate>
                    <asp:Label ID="lblstage" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StageName")%>' ToolTip='<%# DataBinder.Eval(Container.DataItem, "StageName")%>' /> 
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn UniqueName="AttributeDescription" HeaderText="<%$Resources:Resource, Description%>" HeaderToolTip="<%$Resources:Resource, Description%>">
                <HeaderStyle Width="250px" />
                <ItemStyle Width="250px" />
                <ItemTemplate>
                    <asp:Label runat="server" ID="LabelAttributeDescription" Text='<%# DataBinder.Eval(Container.DataItem, "Description")%>' ToolTip='<%# DataBinder.Eval(Container.DataItem, "Description")%>' />
                </ItemTemplate>   
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn UniqueName="Versioning" HeaderToolTip="<%$Resources:Resource, Versioning%>" HeaderImageUrl="~/App/Images/Icons/history.png" Resizable="False">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" Width="41px" />
                <ItemTemplate>
                    <asp:ImageButton ID="imgbtnHistory" runat="server" alt="History" CommandName="Versioning" ImageUrl="~/App/Images/Icons/history.png" ToolTip="History" />
                </ItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
        <EditFormSettings EditFormType="WebUserControl" UserControlName="~/App/UserControls/AttributeDetails.ascx" />
    </MasterTableView>
</telerik:RadGrid>

<%-- CommandButton --%>
<div style="display: none; position: absolute">
    <telerik:RadButton runat="server" ID="RadButtonCommand" OnCommand="RadButtonCommand_OnCommand" />
</div>

<asp:HiddenField runat="server" ID="HiddenFieldIsPageSizeCalculated" />

<telerik:RadWindowManager runat="server" EnableShadow="true">
    <Windows>
        <telerik:RadWindow runat="server" ID="RadWindowDeleteAttributesConfirmation" Modal="True" Behaviors="Move,Close" VisibleStatusbar="False" Width="480px" Height="150px" IconUrl="InvalidIconURL">
            <ContentTemplate>
                <table style="table-layout: auto" width="450px">
                    <tr>
                        <td>
                            <div style="height: 18px">
                                
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center">
                            <asp:Label Font-Size="14px" Font-Name="Segoe UI" Text="Are you sure you want to delete attribute(s)?" runat="server" />            
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center">
                            <telerik:RadButton ID="RadButtonDeleteAttributes" OnClick="RadButtonDeleteAttributes_OnClick" runat="server" Text="Delete attributes" Font-Size="14px" 
                                               OnClientClicked="AttributesControl.RadWindowDeleteAttributesConfirmation.RadButtonDeleteAttributes.OnClientClicked" />            
                            <telerik:RadButton ID="RadButtonDeleteAttributesOfAllTypes" OnClick="RadButtonDeleteAttributesOfAllTypes_OnClick" runat="server" 
                                               Text="Delete Attributes from all types" Font-Size="14px" 
                                               OnClientClicked="AttributesControl.RadWindowDeleteAttributesConfirmation.RadButtonDeleteAttributesOfAllTypes.OnClientClicked" />
                            <telerik:RadButton ID="RadButtonCancel" runat="server" OnClientClicked="AttributesControl.RadWindowDeleteAttributesConfirmation.RadButtonCancel.OnClientClicked" 
                                               AutoPostBack="False" Text="Cancel" Font-Size="14px" />                
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </telerik:RadWindow>
    </Windows>
</telerik:RadWindowManager>