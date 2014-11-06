<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Add_Custom_Hierarchy_data.aspx.cs"
    Inherits="App_Add_Custom_Hierarchy_data" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html>
<title title="Add Custom Hierarchy"></title>
<head runat="server">
    <script language="javascript" type="text/javascript">

        function cursor()
        {
            document.getElementById("txt_name").focus();
        }

        function update_text_value(obj) //For Custom option
        {
            document.getElementById('hf_selected_value').value = document.getElementById('txt_name').value;
        }

        function CallParentWindowFunction() 
        {           
            var e = document.getElementById("ddl");
            var strVal = e.options[e.selectedIndex].text;
            var strhyptxt;
            var strid = e.options[e.selectedIndex].value;
            var strCustom;
            var isClose = false;
            var hf_hyp_id = document.getElementById("hf_hyp_id").value;
            var hf_hid_id = document.getElementById("hf_hid_id").value;
            var hf_Cust_id = document.getElementById("hf_Cust_id").value;
            var hf_nid = document.getElementById("hf_name").value;
          
            if (strVal == "Custom") {
                var custmhirch = document.getElementById("txt_name").value;                
                if (custmhirch != "") {
                    isClose = true;
                    strhyptxt = custmhirch;
                }

                strCustom = "Y";

            }
            else {

                isClose = true;
                strCustom = "N";
                strhyptxt = strVal;
            }

            if (isClose) 
            {                
                if (strhyptxt == "---Select----") //added
                {
                    window.parent.document.getElementById(hf_hyp_id).innerText = "Select";
                    window.parent.document.getElementById(hf_nid).value = strhyptxt;
                    window.parent.document.getElementById(hf_hid_id).value = strid;
                    window.parent.document.getElementById(hf_Cust_id).value = strCustom;
                    window.close();
                    return false;
                }
                else
                 {                    
                    
                    window.parent.document.getElementById(hf_hyp_id).innerText = strhyptxt;                 
                    window.parent.document.getElementById(hf_nid).value = strhyptxt;
                    window.parent.document.getElementById(hf_hid_id).value = strid;
                    window.parent.document.getElementById(hf_Cust_id).value = strCustom;
                    window.close();
                    return false;
                }
            }                      
        }

        function close_() 
        {
            window.close();
            return false;
        }      
    </script>
        <style type="text/css">
        div.RadComboBox_Gray .rcbInput
        {
            height: 17px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style.css" />
</head>
<body style="margin: 0px 0px 0px 0px; padding-top: 0; background: white;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadFormDecorator ID="RadFormDecorator" runat="server" Skin="Hay" DecoratedControls="Buttons" />
    <table border="0" width="700px" style="margin: 50px 0px 0px 70px">               
        <caption><asp:Label ID="Label1" runat="server" Text="<%$Resources:Resource, Add_Hierarchy%>"></asp:Label></caption>
        <tr>
            <td>
                 <asp:Label ID="lbl_hierarchy" runat="server" Text="<%$Resources:Resource, Hierarchy%>" CssClass="LabelText"></asp:Label>
                <asp:DropDownList ID="ddl" runat="server" Width="140" AutoPostBack="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="trCustom" runat="server" visible="false">
            <td>
                <asp:Label Text="<%$Resources:Resource, Custom_Hierarchy_Name%>" ID="lbl_name" runat="server" CssClass="LabelText"></asp:Label> :
                <asp:TextBox ID="txt_name" runat="server" Height="25" CssClass="textbox" onkeyup="javascript:return update_text_value(this);"></asp:TextBox>
                <asp:RequiredFieldValidator ID="req_name" runat="server" ControlToValidate="txt_name"
                    ErrorMessage="*" ValidationGroup="rf_name" Display="Dynamic" ForeColor="Red">
                </asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btn_save" Text="<%$Resources:Resource, Save%>"  Width="50" runat="server" OnClientClick="return CallParentWindowFunction()"
                    ValidationGroup="rf_name" />
                <asp:Button ID="btn_cancel" Text="<%$Resources:Resource, Close%>"  Width="50" OnClientClick="close_()" runat="server" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hf_selected_crtl_id" runat="server" />
    <asp:HiddenField ID="hf_selected_value" runat="server" />
    <asp:HiddenField ID="hf_id" runat="server" />
    <asp:HiddenField ID="hf_no" runat="server" />
    <asp:HiddenField ID="hf_name" runat="server" />


    <asp:HiddenField ID="hf_hyp_id" runat="server" />
    <asp:HiddenField ID="hf_hid_id" runat="server" />
    <asp:HiddenField ID="hf_Cust_id" runat="server" />
    
    </form>
</body>
</html>
