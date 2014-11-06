using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using User;
using System.Data;

public partial class App_Settings_UserMenu : System.Web.UI.Page
{
    #region Global Variables
    int blank_master;
    #endregion
     
    #region Page Events

    protected void Page_PreInit(object sender, EventArgs e)
    {

        if ((Request.QueryString["flag"] == "no_master") && (Request.QueryString["organization_id"] != ""))
        {
            Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";
            blank_master = 1;
        }
        if ((Request.QueryString["flag"] == "clone") && (Request.QueryString["UserId"] != null) && (Request.QueryString["organization_id"] != null))
        {
            Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";
            blank_master = 1;
        }
        if ((Request.QueryString["flag"] == "no_master") && (Request.QueryString["UserId"] != null) && (Request.QueryString["organization_id"] != null))
        {
            Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";
            blank_master = 1;
        }
        if (Request.QueryString["popupflag"] == "popup")
        {
            Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";

        }
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //check if session contains value for user
        if (SessionController.Users_.UserId != null)
        {
            if (Request.QueryString != null)
            {
                hforganization_id.Value = SessionController.Users_.OrganizationID;
                hfUserRole.Value = SessionController.Users_.UserSystemRole;
                string value = "<script language='javascript'>pageload('User Profile')</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
            }
            if (Request.QueryString["organization_id"] != null)
            {
                hforganization_id.Value = Request.QueryString["organization_id"].ToString();
            }
            if (Request.QueryString["user_role"]!=null)
            {
                hfUserRole.Value=Request.QueryString["user_role"].ToString();
            }
            if (Request.QueryString["pagevalue"] == null)
            {
                if (Request.QueryString["UserId"] != null)
                {
                    if (Request.QueryString["popupflag"] == "popup")
                    {
                        hfpopupflag.Value = "popup";
                    }

                    string value = "";
                    if (Request.QueryString["flag"].ToString().Equals("no_master") && Request.QueryString["User"] != null && Request.QueryString["page"].ToString() == "")
                    {
                        value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','User.aspx?organization_id=" + hforganization_id.Value + "&UserId=" + Request.QueryString["UserId"] + "&flag=clone');</script>";
                    }
                    else if (Request.QueryString["flag"].ToString().Equals("clone"))
                    {
                        value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','UserProfile.aspx?organization_id="+hforganization_id.Value+"&UserId=" + Request.QueryString["UserId"] + "&flag=clone');</script>";
                    }
                    else if (Request.RawUrl.ToString().Contains("projectCounts"))
                    {
                        value = "<script language='javascript'>loadProjectsPage('frameSettingsMenu','UserProjects.aspx?UserId=" + Request.QueryString["UserId"] + "&Organization_Id=" + hforganization_id.Value + "&flag=no_master&user_role=OA');</script>";
                        rtsSettingMenu.SelectedIndex = 1;
                    }
                    else
                    {
                        value = "<script language='javascript'>loadintoIframe('frameSettingsMenu','UserProfile.aspx?organization_id=" + hforganization_id.Value + "&Organization_name=" + Request.QueryString["Organization_name"] + "&UserId=" + Request.QueryString["UserId"] + "&flag=from_no_master');</script>";
                    }
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script", value);

                    //save user id for onitemclicking
                    hfUserid.Value = Request.QueryString["UserId"].ToString();
                    Guid derypted_user_id = new Guid(hfUserid.Value);
                    //when user id null i.e. insert new user
                    if (derypted_user_id == Guid.Empty)
                    {
                        rtsSettingMenu.Style.Add("display", "none");
                    }
                    else
                    {
                        rtsSettingMenu.Style.Add("display", "inline");
                    }
                    if (Request.QueryString["flag1"] == "showradmenu")
                    {
                        rtsSettingMenu.Visible = true;
                        blank_master = 1;
                        //td_obj.Visible = true;
                    }
                    else if (Request.QueryString["flag"] == "no_master")
                    {
                        blank_master = 1;
                        //td_obj.Visible = false;
                        rtsSettingMenu.Visible = false;
                    }
                    if (Request.QueryString["flag1"] == "no_radmenu")
                    {
                        rtsSettingMenu.Visible = false;
                    }
                     
                }
                lblUserName.Text = "User Name : " + SessionController.Users_.UserName.ToString();
            }
            else
            {
                hfUserid.Value = Request.QueryString["UserId"].ToString();
                string abvalue = Request.QueryString["pagevalue"].ToString();
                string value = "<script language='javascript'>pageload('" + abvalue + "')</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);
            }

            //bind left menu
            UserClient ctrl = new UserClient();
            UserModel mdl = new UserModel();
            DataSet ds = new DataSet();
            mdl.NavigateUrl = "Settings#";
            ds = ctrl.GetSettingsMenuItemsForUser(mdl);
            rtsSettingMenu.DataTextField = "page_heading";
            rtsSettingMenu.DataFieldID = "pk_setting_page_Id";
            rtsSettingMenu.DataNavigateUrlField = "NavigateUrl";
            rtsSettingMenu.DataValueField = "page_heading";
            rtsSettingMenu.DataSource = ds;
            rtsSettingMenu.DataBind();
        }
        else
        {
            string Updatedvalue = "<script language='javascript'>top.window.CallClickEvent(~/App/loginPM.aspx)')</script>";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "script", Updatedvalue);
        }
    }

    protected void btnclick_Click(object sender, EventArgs e)
    {

        string tabIndex = hfSelectedIndex.Value;
        if (tabIndex == (string)GetGlobalResourceObject("Resource", "User_Profile"))
        {
            rtsSettingMenu.SelectedIndex = 0;
            hfSelectedIndex.Value = "";
        }
        if (tabIndex == (string)GetGlobalResourceObject("Resource", "Projects"))
        {
            rtsSettingMenu.SelectedIndex = 1;
            hfSelectedIndex.Value = "";
        }
       

    }
    #endregion
}
