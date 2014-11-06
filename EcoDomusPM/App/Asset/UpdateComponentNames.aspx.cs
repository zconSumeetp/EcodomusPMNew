using System;
using System.Collections.Generic;
using System.Globalization;
using System.Threading;
using System.Web.UI;
using Asset;
using EcoDomus.Session;

namespace App.Asset
{
    public partial class AppAssetUpdateComponentNames : System.Web.UI.Page
    {
        string _componentIds = "";
        string[] ids;
        List<String> ls = new List<string>();
        string _name = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtUpdateName.Visible = false;
                rf_status.Visible = false;
                lblName.Visible = false;
            }


            if (Request.QueryString["Component_id"] != null)
            {
                try
                {
                    _componentIds = Request.QueryString["Component_id"];
                    _componentIds = _componentIds.Substring(0, _componentIds.Length - 1);
                    ids = _componentIds.Split(',');
                    if (ids.Length > 0)
                    {
                        for (int i = 0; i < ids.Length; i++)
                        {
                            if (!ls.Contains(ids[i]))
                            {
                                ls.Add(ids[i]);
                            }

                        }

                    }
                    _componentIds = "";

                    for (int i = 0; i < ls.Count; i++)
                    {
                        _componentIds = _componentIds + ls[i] + ",";

                    }
                    _componentIds = _componentIds.Substring(0, _componentIds.Length - 1);

                }


                catch (Exception ex)
                {

                    throw ex;
                }
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
                    var objlocMdl = new AssetModel();
                    var objlocCrtl = new AssetClient();
                    objlocMdl.Component_Ids = _componentIds;
                    objlocMdl.Project_id = new Guid(SessionController.Users_.ProjectId);
                    objlocMdl.IsNew = 'N';
                    objlocMdl.New_Name = "";
                    objlocCrtl.UpdateComponentNames(objlocMdl, SessionController.ConnectionString);
                    ScriptManager.RegisterStartupScript(this, GetType(), "script1", "CloseWindow('"+_name+"');", true);
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
                    var objlocMdl = new AssetModel();
                    var objlocCrtl = new AssetClient();
                    objlocMdl.Component_Ids = _componentIds;
                    objlocMdl.Project_id = new Guid(SessionController.Users_.ProjectId);
                    objlocMdl.IsNew = 'Y';
                    objlocMdl.New_Name = txtUpdateName.Text;
                    objlocCrtl.UpdateComponentNames(objlocMdl, SessionController.ConnectionString);
                    _name = txtUpdateName.Text;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "CloseWindow('" + _name + "');", true);
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
            _name = "";
            ScriptManager.RegisterStartupScript(this, GetType(), "script1", "CloseWindow('" + _name + "');", true);
        }
    }
}