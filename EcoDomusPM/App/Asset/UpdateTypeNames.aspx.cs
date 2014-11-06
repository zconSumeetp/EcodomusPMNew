using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;
using TypeProfile;
using EcoDomus.Session;

public partial class App_Asset_UpdateTypeNames : System.Web.UI.Page
{

    string type_ids="";
   // string type_id;
    string [] ids;
    List<String> ls = new List<string>();
    string name = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtUpdateName.Visible = false;
            rf_status.Visible = false;
            lblName.Visible = false;
        }

            if (Request.QueryString["type_id"] != null)
            {
                type_ids = Request.QueryString["type_id"].ToString();
                type_ids = type_ids.Substring(0, type_ids.Length - 1);
                ids = type_ids.Split(',');
                if (ids.Length > 0)
                {
                    for (int i = 0; i < ids.Length; i++)
                    {
                        if (!ls.Contains(ids[i].ToString()))
                        {
                            ls.Add(ids[i].ToString());
                        }

                    }

                }
                type_ids = "";

                for (int i = 0; i < ls.Count; i++)
                {
                    type_ids = type_ids + ls[i].ToString() + ",";

                }
                type_ids = type_ids.Substring(0, type_ids.Length - 1);

            }
        
    }
    protected override void InitializeCulture()
    {
        try
        {
            string culture = Session["Culture"].ToString();
            if (culture == null)
            {
                culture = "en-US";
            }
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
        }
        catch (Exception ex)
        {

            Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
        }

    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        if (rdbtnUpdateTemplate.Checked)
        {
            try
            {
                TypeModel mdl = new TypeModel();
                TypeProfileClient tc = new TypeProfileClient();
                mdl.Type_Ids = type_ids;
                mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
                mdl.IsNew ='N';
                mdl.New_Name = "";
                tc.UpdateTypeNames(mdl, SessionController.ConnectionString);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "CloseWindow('" + name + "');", true);
            }
            catch (Exception ex)
            {
                throw ex;

            }
        }
        else if (rdbtnUpdateNames.Checked)
        {
            try
            {
                TypeModel mdl = new TypeModel();
                TypeProfileClient tc = new TypeProfileClient();
                mdl.Type_Ids = type_ids;
                mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
                mdl.IsNew = 'Y';
                mdl.New_Name =txtUpdateName.Text;
                tc.UpdateTypeNames(mdl, SessionController.ConnectionString);
                name = txtUpdateName.Text;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "CloseWindow('" + name + "');", true);
            }
            catch (Exception ex)
            {
                throw ex;

            }


        }

    }

    protected void rdbtnUpdateTemplate_checked(object sender, EventArgs e)
    {
        txtUpdateName.Visible = false;
        rf_status.Visible = false;
        lblName.Visible = false;

    }
    protected void rdbtnUpdateNames_checked(object sender, EventArgs e)
    {
        txtUpdateName.Visible = true;
        rf_status.Visible = true;
        lblName.Visible = true;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        name = "";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "CloseWindow('" + name + "');", true);
    }
}