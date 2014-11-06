<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="LicenseRegistration.aspx.cs" Inherits="App_Settings_LicenseRegistration" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <script type="text/javascript" language="javascript">
         window.onload = body_load;
         function body_load() {
             this.set_NiceScrollToPanel();
             document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span><span><a>Settings</a></span>" + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='LicenseRegistration.aspx'>Register license</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span><span>EcoDomus Registration</span><a id='SiteMapPath1_SkipLink'></a></span>";
         }
      </script>
     <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" Skin="Default" DecoratedControls="Buttons" />
    <div style="width: 100%;">
        <table width="100%"  > 
        
            <tr>
                <td> 
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table width="50%" align="left">
                                <tr><td colspan="3" align="left" style="height:10px;"></td></tr>
                                <tr>
                                    <td colspan="3" align="left">
                                        <b>
                                            <asp:Label runat="server" ID="lbl_Registration" Text="EcoDomus Registration" ForeColor="Brown"
                                                Style="font-size: large;" /></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="height: 50px;">
                                    </td>
                                </tr>
                                <tr style="height: 20px;">
                                    <td align="right">
                                        <asp:Label runat="server" ID="lbl_email" Text="Please Enter Your Email Id :" CssClass="Label" />
                                    </td>
                                    <td width="5%">
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txt_email" Width="200px" /><asp:Label runat="server"
                                            ID="lbl_req_field" Text="" ForeColor="Red" /><asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                                                runat="server" ErrorMessage="Enter Valid Email ID" 
                                            ControlToValidate="txt_email"  ForeColor="Red" 
                                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr style="height: 20px;">
                                    <td align="right">
                                        <asp:Label runat="server" ID="lbl_select_duration" Text="Select the type of License :"
                                            CssClass="Label" />
                                    </td>
                                    <td width="5%">
                                    </td>
                                    <td>
                                        <asp:RadioButtonList ID="Rb_list_duration" runat="server" RepeatDirection="Horizontal"
                                            OnSelectedIndexChanged="Rb_list_duration_SelectedIndexChanged" AutoPostBack="true"
                                            EnableViewState="true">
                                            <asp:ListItem Selected="True" Value="Trial Version">Trial Version</asp:ListItem>
                                            <asp:ListItem Value="License Version">License Version</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr runat="server" id="tr_duration">
                                    <td align="right">
                                        <asp:Label runat="server" ID="lbl_duration" Text="License Duration :" CssClass="Label" />
                                    </td>
                                    <td width="5%">
                                    </td>
                                    <td>
                                        <%--<asp:TextBox runat="server" ID="txt_duration"  />--%>
                                        <asp:DropDownList ID="dd_years" runat="server">
                                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                                            <asp:ListItem Value="1">1</asp:ListItem>
                                            <asp:ListItem Value="2">2</asp:ListItem>
                                            <asp:ListItem Value="3">3</asp:ListItem>
                                            <asp:ListItem Value="4">4</asp:ListItem>
                                            <asp:ListItem Value="5">5</asp:ListItem>
                                            <asp:ListItem Value="6">6</asp:ListItem>
                                            <asp:ListItem Value="7">7</asp:ListItem>
                                            <asp:ListItem Value="8">8</asp:ListItem>
                                            <asp:ListItem Value="9">9</asp:ListItem>
                                            <asp:ListItem Value="10">10</asp:ListItem>
                                            <asp:ListItem Value="11">11</asp:ListItem>
                                            <asp:ListItem Value="12">12</asp:ListItem>
                                            <asp:ListItem Value="13">13</asp:ListItem>
                                            <asp:ListItem Value="14">14</asp:ListItem>
                                            <asp:ListItem Value="15">15</asp:ListItem>
                                            <asp:ListItem Value="16">16</asp:ListItem>
                                            <asp:ListItem Value="17">17</asp:ListItem>
                                            <asp:ListItem Value="18">18</asp:ListItem>
                                            <asp:ListItem Value="19">19</asp:ListItem>
                                            <asp:ListItem Value="20">20</asp:ListItem>
                                            
                                        </asp:DropDownList>
                                        <asp:Label runat="server" ID="lbl_yrs" Text="Yrs" />
                                        <asp:Label runat="server" ID="lbl_req_field2" Text="" ForeColor="Red" />
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="height: 20px;">
                                    </td>
                                </tr>
                                <tr>
                                <td></td>
                                <td></td>
                                    <td  align="left" >
                                        <asp:Button runat="server" ID="btn_trail" Text="Request For License Key" OnClick="btn_trail_Click"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="center">
                                        <asp:Label runat="server" ID="lbl_mail_note" Text="" ForeColor="Green" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="height: 30px;">
                </td>
            </tr>
            <tr>
                <td align="left" >
                    <table width="90%" align="center" style="background-color: White;">
                        <tr>
                            <td>
                                <div style="width: 100%;">
                                    <asp:Panel ID="Panel1" runat="server" BorderColor="Aqua" GroupingText="Activate License"
                                        DefaultButton="btn_activate" Width="100%">
                                        <table width="100%" align="left">
                                            <tr>
                                                <td colspan="4" style="height: 5px;">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lbl_key" Text="Enter EcoDomus license Key :" CssClass="Label" />
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txt_key" TextMode="MultiLine" Width="600px" />
                                                </td>
                                                <td>
                                                    <asp:Button runat="server" ID="btn_activate" Text="Activate License" OnClick="btn_activate_Click"
                                                        CausesValidation="false" Skin="Default" />
                                                </td>
                                                <td>
                                                    <asp:Button runat="server" ID="btn_cont" Text="Continue" CausesValidation="false"
                                                        OnClick="btn_cont_Click" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" align="center">
                                                    <asp:Label runat="server" ID="lbl_activation_msg" ForeColor="Red" Text="" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" style="height: 5px;">
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
                            </td>
                        </tr>
                    </table>
                    
                 </td>
            </tr>
            <tr>
                <td style="height: 100px;">
                </td>
            </tr>
            
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
