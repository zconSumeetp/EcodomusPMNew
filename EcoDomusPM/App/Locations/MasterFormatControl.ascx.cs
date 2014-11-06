using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using TypeProfile;
using System.Data;

public partial class App_Locations_MasterFormatControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TypeModel tm = new TypeModel();
        TypeProfileClient tc = new TypeProfileClient();
        DataSet ds = new DataSet();
        if (SessionController.Users_.UserId != null)
        {            
            if (hf_masterformat_id.Value == "false")
            {
                tm.Parent_master_format_id = Guid.Empty;
                ds = tc.BindMasterFormat(tm, SessionController.ConnectionString);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    SessionController.Users_.MasterFormatId = Guid.Empty.ToString();
                    rcbLevel1.Enabled = true;
                    rcbLevel1.DataValueField = "Id";
                    rcbLevel1.DataTextField = "Name";
                    rcbLevel1.DataSource = ds;
                    rcbLevel1.DataBind();
                    hfid.Value = rcbLevel1.SelectedValue.ToString();
                }
                else
                {
                    rcbLevel1.Enabled = false;
                    rcbLevel2.Enabled = false;
                    rcbLevel3.Enabled = false;
                    rcbLevel4.Enabled = false;
                }
                hf_masterformat_id.Value = "true";
            }                       
        }
 
        
    }

    protected void rcbLevel1_SelectedIndexChanged(object o,Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {

        DataSet ds = new DataSet();
        TypeModel tm = new TypeModel();
        TypeProfileClient tc = new TypeProfileClient();
        try
        {
            tm.Parent_master_format_id = new Guid(rcbLevel1.SelectedValue.ToString());
            ds = tc.BindMasterFormat(tm, SessionController.ConnectionString);
            lblmasterformat.Text = rcbLevel1.SelectedItem.Text.ToString();
            SessionController.Users_.MasterFormatId = rcbLevel1.SelectedValue.ToString();

            rcbLevel2.Items.Clear();
            rcbLevel2.DataSource = null;
            rcbLevel3.Items.Clear();
            rcbLevel3.DataSource = null;
            rcbLevel4.Items.Clear();
            rcbLevel4.DataSource = null;
            if (ds.Tables[0].Rows.Count > 0)
            {

                rcbLevel2.Enabled = true;
                rcbLevel2.DataSource = ds;
                rcbLevel2.DataValueField = "Id";
                rcbLevel2.DataTextField = "name";
                rcbLevel2.DataBind();
                hfid.Value = rcbLevel2.SelectedValue.ToString();
            }
            else
            {
                rcbLevel2.Enabled = false;
                rcbLevel3.Enabled = false;
                rcbLevel4.Enabled = false;
            }
        }
        catch (Exception ex)
        {
            lblErr.Text = "Level 1:- " + ex.Message;
        }
    }

    protected void rcbLevel2_SelectedIndexChanged(object o, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        DataSet ds = new DataSet();
        TypeModel tm = new TypeModel();
        TypeProfileClient tc = new TypeProfileClient();
        try
        {
            tm.Parent_master_format_id = new Guid(rcbLevel2.SelectedValue.ToString());
            ds = tc.BindMasterFormat(tm, SessionController.ConnectionString);
            lblmasterformat.Text = rcbLevel2.SelectedItem.Text.ToString();
            SessionController.Users_.MasterFormatId = rcbLevel2.SelectedValue.ToString();
            rcbLevel3.Items.Clear();
            rcbLevel3.DataSource = null;
            rcbLevel4.Items.Clear();
            rcbLevel4.DataSource = null;
            if (ds.Tables[0].Rows.Count > 0)
            {
                rcbLevel3.Enabled = true;
                rcbLevel3.DataSource = ds;
                rcbLevel3.DataValueField = "Id";
                rcbLevel3.DataTextField = "name";
                rcbLevel3.DataBind();
                hfid.Value = rcbLevel3.SelectedValue.ToString();
            }
            else
            {
                rcbLevel3.Enabled = false;
                rcbLevel4.Enabled = false;
            }

        }
        catch (Exception ex)
        {
            lblErr.Text = "Level 2:- " + ex.Message;
        }
    }

    protected void rcbLevel3_SelectedIndexChanged(object o, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        TypeModel tm = new TypeModel();
        TypeProfileClient tc = new TypeProfileClient();
        DataSet ds = new DataSet();
        try
        {
            tm.Parent_master_format_id = new Guid(rcbLevel3.SelectedValue.ToString());
            ds = tc.BindMasterFormat(tm, SessionController.ConnectionString);
            rcbLevel4.Items.Clear();
            rcbLevel4.DataSource = null;
            lblmasterformat.Text = rcbLevel3.SelectedItem.Text.ToString();
            SessionController.Users_.MasterFormatId = rcbLevel3.SelectedValue.ToString();
            if (ds.Tables[0].Rows.Count > 0)
            {
                rcbLevel4.Enabled = true;
                rcbLevel4.DataSource = ds;
                rcbLevel4.DataValueField = "Id";
                rcbLevel4.DataTextField = "name";
                rcbLevel4.DataBind();
                hfid.Value = rcbLevel4.SelectedValue.ToString();
            }
            else
            {
                rcbLevel4.Enabled = false;
            }

        }
        catch (Exception ex)
        {
            lblErr.Text = "Level 3:- " + ex.Message;
        }
    }

    protected void rcbLevel4_SelectedIndexChanged(object o, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            lblmasterformat.Text = rcbLevel4.SelectedItem.Text.ToString();
            SessionController.Users_.MasterFormatId = rcbLevel4.SelectedValue.ToString();
        }
        catch (Exception ex)
        {
            lblErr.Text = "Level 4:- " + ex.Message;
        }
    }



    protected void btnAssign_Click(object sender, EventArgs e)
    {
        string id = SessionController.Users_.MasterFormatId.ToString();
        string name = lblmasterformat.Text;
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "script", "javascript:selectedFormat('" + id + "','" + name + "');", true);                        
        //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "script", "selectedFormat('" + id + "','" + name + "');", true);                        
    }
}