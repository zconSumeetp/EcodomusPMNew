<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EnergyPlusData.ascx.cs"
    Inherits="App_UserControls_EnergyPlusData" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        function show_data() {
            document.getElementById('<%=btn_show.ClientID %>').click();

        }

        function onClientProgressBarUpdating() {

            adjust_height();

        }
       
    </script>
    <style type="text/css">
        .RadUploadProgressArea .ruProgress
        {
            margin-top: -60px;
            margin-left: -20px;
            background-image: none !important;
            background-color: transparent;
            border-style: none;
        }
        
        
       
    </style>
</telerik:RadCodeBlock>
<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript">

        var fileList = null,
                fileListUL = null;

        function fileUploaded(sender, args) {
            debugger
            var name = args.get_fileName(),
                    li = document.createElement("li");

            if (fileList == null) {
                fileList = document.getElementById("exFileList");
                fileListUL = document.createElement("ul");
                fileList.appendChild(fileListUL);

                fileList.style.display = "block";

            }

            li.innerHTML = name;
            fileListUL.appendChild(li);
        }
   
    </script>
</telerik:RadScriptBlock>
<link rel="Stylesheet" type="text/css" href="../../../App_Themes/EcoDomus/style_new_ui_pm.css" />
<telerik:RadFormDecorator ID="rdfTaskEquipment" runat="server" Skin="Hay" DecoratedControls="Buttons,RadioButtons,Scrollbars" />
<div>
    <fieldset style="border-top-color: #DCDCDC; border-left-color: transparent; border-right-color: transparent;
        border-bottom-color: transparent">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 65%; padding-left: 20px; vertical-align: top" class="tdValign">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="padding-top: 25px">
                                <asp:Label ID="lbl_msg" runat="server" Text="Select the data file to import energy modeling data"
                                    CssClass="headerBoldLabel"> </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 20px">
                                <asp:Label ID="lbl_select_file" runat="server" Text="Selected import file" CssClass="normalLabel"> </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 5px; width: 100%">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 70%">
                                            <%--OnClientFileSelected="show_data"--%>
                                            <telerik:RadProgressManager runat="server" ID="RadProgressManager1" />
                                            <telerik:RadUpload ID="ru_file" runat="server" Skin="Default" CssClass="normalLabel"
                                                ControlObjectsVisibility="None" OnClientFileSelected="show_data" ViewStateMode="Enabled"
                                                Height="49px" InputSize="55" />
                                            <telerik:RadProgressArea runat="server" ID="RadProgressArea1" ProgressIndicators="TotalProgress,TotalProgressBar,TotalProgressPercent"
                                                DisplayCancelButton="false" Skin="Windows7" EnableViewState="False" Height="20px"
                                                Width="417px" OnClientProgressBarUpdating="onClientProgressBarUpdating" />
                                          
                                        </td>
                                        <td align="left" valign="top">
                                            <%--<telerik:RadButton ID="rbtn_upload" runat="server" Text="Upload" 
                                            onclick="rbtn_upload_Click" ></telerik:RadButton>--%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <%--<tr>
                        <td>
                            <asp:Label ID="lbl1" runat="server" Text="Select existing file" CssClass="normalLabel"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 5px">
                            <telerik:RadComboBox ID="cmb_file_list" runat="server" Width="370px" ExpandDirection="Down"
                                ZIndex="10">
                            </telerik:RadComboBox>
                        </td>
                    </tr>--%>
                        <tr>
                            <td style="padding-top: 20px">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbl_file_info" runat="server" Text="File Information" CssClass="normalLabel"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 5px; padding-bottom: 15px">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td class="style1">
                                            <%--<asp:TextBox ID="rtxt_file_data" Width="95%" TextMode="MultiLine" runat="server"
                                BackColor="#FFFFE1" BorderStyle="Inset" CssClass="textAreaScrollBar"></asp:TextBox>--%>
                                            <asp:ListBox ID="lst_file_info" runat="server" Width="95%" Height="120" BackColor="#FFFFE1">
                                            </asp:ListBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="width: 35%; padding-top: 15px; background-color: #E8E8E8" valign="top"
                    class="tdValign">
                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <table width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="vertical-align: middle; padding-left: 10px; width: 30px">
                                            <asp:Image ID="img_selected_facility" runat="server" ImageUrl="~/App/Images/Icons/icon_facilities_lg.png" />
                                        </td>
                                        <td style="vertical-align: bottom; padding-left: 10px" align="left">
                                            <asp:Label ID="lbl_selected_facility" runat="server" Text="Selected Facility" CssClass="normalLabel"> </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px">
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 10px">
                                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbl_facility_name" runat="server" Text="" CssClass="normalLabel" ForeColor="#B22222"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 30px">
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 40px; padding-bottom: 30px">
                                <%--<table border="0" width="100%" cellpadding="0" cellspacing="0" align="center" style="background-image: url('/App/Images/asset_button_orange.png');
                        background-repeat: no-repeat; background-position: inherit">
                        <tr>
                            <td style="padding-left: 5px">
                                <asp:CheckBox ID="chk_none" runat="server" Text="None" CssClass="normalLabel"/>
                            </td>
                        </tr>
                    </table>--%>
                                <table border="0" width="100%" cellpadding="0" cellspacing="0" align="left" style="background-image: url('/App/Images/asset_button_orange.png');
                                    background-repeat: no-repeat; background-position: inherit; height: 26px; width: 140px">
                                    <tr>
                                        <td style="padding-left: 5px; vertical-align: middle">
                                            <asp:CheckBox ID="chk_none" runat="server" Text="None" CssClass="normalLabel" />
                                            <%--<asp:Image ID="img_no_template" runat="server" ImageUrl="~/App/Images/Icons/asset_checkbox1.png" />--%>
                                        </td>
                                        <%-- <td valign="top">
                                <asp:Label ID="lbl_none" runat="server" Text="None" CssClass="normalLabel"></asp:Label>
                            </td>--%>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 40px">
                                <%-- <table border="0" width="100%" cellpadding="0" cellspacing="0" align="center" style="background-image: url('/App/Images/asset_button_orange.png');
                        background-repeat: no-repeat; background-position: inherit">
                        <tr>
                            <td style="padding-left: 5px">
                                <asp:CheckBox ID="chk_idf_file" runat="server" Text="IDF File"  CssClass="normalLabel" />
                            </td>
                        </tr>
                    </table>--%>
                                <table border="0" width="100%" cellpadding="0" cellspacing="0" align="left" style="background-image: url('/App/Images/asset_button_orange.png');
                                    background-repeat: no-repeat; background-position: inherit; height: 26px; width: 140px">
                                    <tr>
                                        <td style="padding-left: 5px; vertical-align: middle">
                                            <asp:CheckBox ID="chk_idf_file" runat="server" Text="IDF File" CssClass="normalLabel" />
                                            <%--<asp:Image ID="img_idf_file" runat="server" ImageUrl="~/App/Images/Icons/asset_checkbox1.png" />--%>
                                        </td>
                                        <%--<td valign="top">
                                <asp:Label ID="Label2" runat="server" Text="IDF File" CssClass="normalLabel"></asp:Label>
                            </td>--%>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 40px; padding-top: 30px; padding-bottom: 30px">
                                <%-- <table border="0" width="100%" cellpadding="0" cellspacing="0" align="center" style="background-image: url('/App/Images/asset_button_orange.png');
                        background-repeat: no-repeat; background-position: inherit">
                        <tr>
                            <td style="padding-left: 5px">
                                <asp:CheckBox ID="chk_gbxml_file" runat="server" Text="gbXML File"  CssClass="normalLabel" />
                            </td>
                        </tr>
                    </table>--%>
                                <table border="0" width="100%" cellpadding="0" cellspacing="0" align="left" style="background-image: url('/App/Images/asset_button_orange.png');
                                    background-repeat: no-repeat; background-position: inherit; height: 26px; width: 140px;">
                                    <tr>
                                        <td style="padding-left: 5px; vertical-align: middle">
                                            <asp:CheckBox ID="chk_gbXML_file" runat="server" Text="gbXML File" CssClass="normalLabel" />
                                            <%--<asp:Image ID="Image3" runat="server" ImageUrl="~/App/Images/Icons/asset_checkbox1.png" />--%>
                                        </td>
                                        <%-- <td valign="top" class="disableLabel">
                                <asp:Label ID="Label3" runat="server" Text="gbXML File" CssClass="normalLabel"></asp:Label>
                            </td>--%>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="background-color: Orange; height: 1px" colspan="2">
                </td>
            </tr>
            <tr>
                <td align="right" colspan="2">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td valign="middle">
                                <asp:ImageButton ID="ibtn_back" runat="server" CssClass="lnkButtonImg" ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm2.png"
                                    OnClick="ibtn_back_Click" />
                            </td>
                            <td valign="top">
                                <asp:LinkButton ID="lbtn_back" runat="server" Text="Back" ForeColor="Black" OnClick="lbtn_back_Click"
                                    CssClass="lnkButton"></asp:LinkButton>
                            </td>
                            <td style="padding-left: 25px; padding-right: 25px" valign="middle">
                                <asp:Image ID="img_hbar" runat="server" ImageUrl="~/App/Images/Icons/asset_scrollbar_bar.png"
                                    Width="2px" Height="10px" />
                            </td>
                            <td class="tdValign">
                                <asp:LinkButton ID="Label1" runat="server" Text="Skip" ForeColor="Black" CssClass="lnkButton"
                                    OnClick="Label1_Click"></asp:LinkButton>
                            </td>
                            <td style="padding-left: 25px; padding-right: 25px" valign="middle">
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/App/Images/Icons/asset_scrollbar_bar.png"
                                    Width="2px" Height="10px" />
                            </td>
                            <td valign="top">
                                <asp:LinkButton ID="lbtn_next" runat="server" Text="Next" ForeColor="Black" OnClick="lbtn_next_Click"
                                    CssClass="lnkButton"></asp:LinkButton>
                            </td>
                            <td valign="middle">
                                <asp:ImageButton ID="ibtn_next" runat="server" ImageUrl="~/App/Images/Icons/asset_wizard_arrow_sm.png"
                                    OnClick="ibtn_next_Click" CssClass="lnkButtonImg" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </fieldset>
    <div id="divbtn" style="display: none;">
        <asp:Button ID="btn_show" runat="server" Style="display: none;" OnClick="btn_show_Click" />
    </div>
    <asp:HiddenField ID="hf_is_loaded" runat="server" Value="No" />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ru_file">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lst_file_info" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="cmb_file_list" LoadingPanelID="loadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadProgressArea1"  />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="loadingPanel1" runat="server" Height="75px" Width="75px"
        Skin="Default">
    </telerik:RadAjaxLoadingPanel>
</div>
