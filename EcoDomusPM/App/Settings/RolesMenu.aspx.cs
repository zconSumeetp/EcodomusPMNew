using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Session;
using System.Data;
using Asset;
using BIMModel;
using System.Globalization;
using System.Threading;
using Telerik.Web.UI;

public partial class App_Settings_RolesPermissions : System.Web.UI.Page
{
    string created_by = "";
    string AccessRole = "";
    string System_Role = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataSet ds = new DataSet();
            Roles.RolesClient RolesClient = new Roles.RolesClient();
            Roles.RolesModel RolesModel = new Roles.RolesModel();
            RolesModel.Entity_Name = "Role";
            RolesModel.Culture = Session["Culture"].ToString();
            ds = RolesClient.get_customised_left_menu(RolesModel, SessionController.ConnectionString);
            rtsRolesProfile.DataTextField = "page_heading1";
            rtsRolesProfile.DataFieldID = "pk_setting_page_id";
            //rtsRolesProfile.DataNavigateUrlField = "NavigateUrl";
            rtsRolesProfile.DataValueField = "page_heading";
            rtsRolesProfile.DataSource = ds;
            rtsRolesProfile.DataBind();
            string abc = Request.QueryString.ToString();
            hf_roleId.Value = Guid.Empty.ToString();
            if (Request.QueryString["created_by"] != null && Request.QueryString["roleid"] != null)
            {
                created_by = Request.QueryString["created_by"].ToString();
                hf_roleId.Value = Request.QueryString["roleid"].ToString();
                //string flag = checkAssignedRole();
                //if (flag == "Y")
                //{
                //    // Request.QueryString["System_role"] - role of the user who create the role
                //    if (Request.QueryString["System_role"] != null)
                //    {
                //        System_Role = Request.QueryString["System_role"].ToString();

                //        // if the role was created by SA user and the current user is not SA 
                //        // disable the tabs
                //        if (System_Role == "SA" && SessionController.Users_.UserId.ToString() != created_by.ToLower() && System_Role != AccessRole)
                //        {
                //            rtsRolesProfile.Tabs[0].Enabled = false;
                //            rtsRolesProfile.Tabs[1].Enabled = false;
                //        }


                //    }
                //}

                var rolesToEditTheRoles = new[] {"SA", "OA", "PA"};
                if (rolesToEditTheRoles.Contains(SessionController.Users_.UserSystemRole))
                {
                    rtsRolesProfile.Tabs[0].Enabled = true;
                    rtsRolesProfile.Tabs[1].Enabled = true;
                }
                else
                {
                    rtsRolesProfile.Tabs[0].Enabled = false;
                    rtsRolesProfile.Tabs[1].Enabled = false;
                }

            }
            if (Request.QueryString["roleid"] != null)
            {
                hf_roleId.Value = Request.QueryString["roleid"].ToString();
            }
            if (Request.QueryString["roleid"] == null)
            {
                rtsRolesProfile.Tabs[1].Enabled = false;

            } string value = "";
            if (Request.QueryString["pagename"] != null)
            {
                if (Request.QueryString["pagename"] == "Roles_Cobie")
                {
                    value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','../Settings/Roles_COBie.aspx?roleId=" + Request.QueryString["roleId"] + "&created_by=" + created_by + "');</script>";//sitemapSystem();

                    rtsRolesProfile.FindTabByText("Permissions").Selected = true;
                }
            }
            else
            {
                //value = "<script language='javascript'>onClientTabSelected('" + sender + "','" + rtsRolesProfile.ClientID + "');</script>";//sitemapSystem();
                value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','RoleDetails.aspx?roleId=" + Request.QueryString["roleId"] + "&SystemRole=" + System_Role + "');</script>";//sitemapSystem();
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);

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
            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {
        Response.Redirect(url, false);
    }

    public string checkAssignedRole()
    {

        try
        {
            string flag = "";
            Roles.RolesClient RolesClient = new Roles.RolesClient();
            Roles.RolesModel RolesModel = new Roles.RolesModel();
            RolesModel.Project_id = new Guid(SessionController.Users_.ProjectId);
            RolesModel.User_Id = new Guid(SessionController.Users_.UserId);
            RolesModel.Project_RoleId = new Guid(hf_roleId.Value);
            DataSet ds = new DataSet();

            ds = RolesClient.Get_Verfiy_Role(RolesModel, SessionController.ConnectionString);
            if (ds.Tables.Count > 0)
            {
                // if a project has roles
                if (ds.Tables[0].Rows.Count > 0)
                {
                    flag = "Y";
                    // if user has a role
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        // Access role = user role
                        AccessRole = ds.Tables[1].Rows[0]["name"].ToString();
                    }
                }
                else
                {
                    flag = "N";
                }
            }
            return flag;

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void btnclick_Click(object sender, EventArgs e)
    {

        string tabName = hfSelectedIndex.Value;
        if (tabName.Contains(" "))
        {
            tabName = tabName.Trim().Replace(" ", "_");
        }
        ContentPlaceHolder ctnobj = (ContentPlaceHolder)Page.Master.FindControl("ContentPlaceHolder1");
        if (ctnobj != null)
        {
            RadTabStrip tabStrip = (RadTabStrip)ctnobj.FindControl("rtsRolesProfile");
            if (tabStrip != null)
            {
                RadTab objTab = tabStrip.FindTabByText((string)GetGlobalResourceObject("Resource", tabName));
                if (objTab != null)
                {
                    objTab.Enabled = true;
                    objTab.Selected = true;
                }
            }
        }
    }
}