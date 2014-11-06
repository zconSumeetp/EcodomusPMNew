<%@ Page Title="" Language="C#" MasterPageFile="~/App/EcoDomus_PM_New.master" AutoEventWireup="true"
    CodeFile="Training.aspx.cs" Inherits="App_Training" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .MyGridClass .rgDataDiv
        {
            height: 200px;
        }
    </style>
    <script type="text/javascript" >
        window.onload = function body_load() {
           set_NiceScrollToPanel();
        }
    </script>
    <link rel="stylesheet" type="text/css" href="../App_Themes/EcoDomus/style_new_1.css" />
    <telerik:RadFormDecorator ID="rdftraining" runat="server" Skin="Default" DecoratedControls="Buttons,RadioButtons,Scrollbars" />

    <table style="margin-left: 8px; margin-top: 2px; margin-right: 10px;" align="left"
        width="90%" border="0" cellpadding="20px">

        <caption>
            <asp:Label ID="Label3" runat="server" Text="EcoDomus Training Videos"></asp:Label>
        </caption>
        <tr>
            <td valign="top" style="margin-left:10px;right:20px;">
                <telerik:RadGrid ID="rgvideo" Width="98%" runat="server" BorderWidth="1px" 
                    AutoGenerateColumns="False" AllowSorting="True" AllowMultiRowSelection="true"
                    PagerStyle-AlwaysVisible="true" Skin="Default" OnItemCommand="rgvideo_itemcommand">
                    <MasterTableView DataKeyNames="pk_training_video_id,file_path" CssClass="MyGridClass">
                        <Columns>
                            <telerik:GridBoundColumn DataField="pk_training_video_id" HeaderText="pk_training_video_id"
                                UniqueName="pk_training_video_id" Visible="False">
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn DataTextField="video_name" HeaderText="Video" ButtonType="LinkButton"
                                CommandName="Play" UniqueName="video_name">
                            </telerik:GridButtonColumn>
                             <telerik:GridButtonColumn DataTextField="Download" HeaderText="Download" ButtonType="LinkButton"
                                CommandName="download" UniqueName="download">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="file_path" HeaderText="File_Path" UniqueName="file_path"
                                Visible="false">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
               <br />
                <p>
                    <a href="http://www.manula.com/manuals/ecodomus/ecodomus/1/en/topic/setup-and-login"
                        target="_blank">
                        Please click here to view and download ecodomus user guide.
                        </a>
                </p>
              <br />
                   <p>
                   Please submit your questions using the form on this page -<a href="http://www.ecodomus.com/index.php/support"
                        target="_blank">http://www.ecodomus.com/index.php/support</a>. We recommend attaching a screenshot describing a problem that you encounter.
                   </p> 
            </td>
            <td align="right" valign="top" style="margin-left=20px;">
                <div runat="server" id="Video">
                </div>
                <br />
                   <p>
                 Note:  Please double click the media player to view the video in full screen.
                   </p> 
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
