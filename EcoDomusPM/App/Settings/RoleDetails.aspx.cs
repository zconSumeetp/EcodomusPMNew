using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Text;
using System.Data;
using Asset;
using System.Threading;
using System.Globalization;
using Login;
using TypeProfile;
using Facility;
using Locations;
using SyncAsset;

public partial class App_Settings_RoleDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //  disableControl();
            // ScriptManager.RegisterStartupScript(this, this.GetType(), "roleid", "getRole_Id();", true);
            if (Request.QueryString["roleid"] != null)
            {
                if (Request.QueryString["roleid"].ToString() != "")
                {
                    hf_roleId_roleDetail.Value = Request.QueryString["roleid"].ToString();
                    Disable_Control(hf_roleId_roleDetail.Value);
                }
                else
                {
                    disableControl();
                    hf_roleId_roleDetail.Value = Guid.Empty.ToString();
                }
            }
            // visibleControl();
            //hf_system_role.Value = Request.QueryString["SystemRole"].ToString();
            if (Request.QueryString["SystemRole"] != null)
            {
                string systemrole = Request.QueryString["SystemRole"].ToString();
                if (systemrole == "SA")
                {
                    btnEdit.Enabled = false;
                    btnDelete.Enabled = false;
                }
            }
            btnAdd.Text = (string)GetGlobalResourceObject("Resource", "Save");
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

            //redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {

        try
        {

            if (SessionController.Users_.ProjectId != null)
            {
                Roles.RolesClient obj_roleClient = new Roles.RolesClient();
                Roles.RolesModel obj_roleModel = new Roles.RolesModel();
                DataSet ds = new DataSet();
                obj_roleModel.Project_RoleId = Guid.Empty;
                obj_roleModel.Fk_project_id = new Guid(SessionController.Users_.ProjectId);
                obj_roleModel.Role_Name = txtRoleName.Text;
                obj_roleModel.Role_Desc = txtRoleDesc.Text;
                obj_roleModel.User_Id = new Guid(SessionController.Users_.UserId);
                ds = obj_roleClient.Insert_update_roles(obj_roleModel, SessionController.ConnectionString);
                if (ds.Tables[0].Rows[0]["existsflag"].ToString() == "Y")
                {
                    lblMsg.Text = "Role with this name already exists..!";
                }
                else
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NavigateTo('" + ds.Tables[0].Rows[0]["pk_project_role_id"].ToString() + "');", true);
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "CancelNavigation();", true);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }


    public void Get_RoleProfile(string RoleId)
    {
        try
        {
            Roles.RolesClient obj_roleClient = new Roles.RolesClient();
            Roles.RolesModel obj_roleModel = new Roles.RolesModel();
            DataSet ds = new DataSet();
            obj_roleModel.Project_RoleId = new Guid(RoleId);
            ds = obj_roleClient.Get_RoleProfile(obj_roleModel, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0] != null)
                {
                    lblRoleName.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    lblRoleDesc.Text = ds.Tables[0].Rows[0]["description"].ToString();

                }
            }

        }


        catch (Exception ex)
        {
            throw ex;

        }

    }

    public void disableControl()
    {

        btnSave.Visible = false;
        btnEdit.Visible = false;
        btnDelete.Visible = false;///////
        lblRoleDesc.Visible = false;
        lblRoleName.Visible = false;
     
    }
    public void visibleControl()
    {

        btnSave.Visible = true;
        btnCancel.Visible = true;
        btnEdit.Visible = true;
        btnDelete.Visible = true;////
        btnAdd.Visible = true;
        lblRoleDesc.Visible = true;
        lblRoleName.Visible = true;
        txtRoleDesc.Visible = true;
        txtRoleName.Visible = true;
    }
    public void Disable_Control(string str)
    {

        if (str == Guid.Empty.ToString())
        {
            btnAdd.Visible = true;
            btnEdit.Visible = false;
            btnDelete.Visible = false;
            btnSave.Visible = false;
            btnCancel.Visible = true;
        }
        else
        {
            btnAdd.Visible = false;
            btnEdit.Visible = true;
            btnDelete.Visible = true;
            btnSave.Visible = false;
            btnCancel.Visible = false;
            txtRoleDesc.Visible = false;
            txtRoleName.Visible = false;
            Get_RoleProfile(hf_roleId_roleDetail.Value);

        }
    }


    protected void hdnbtn_Click(object sender, EventArgs e)
    {
        string str = hf_roleId_roleDetail.Value;
        if (str == Guid.Empty.ToString())
        {
            btnAdd.Visible = true;
            btnEdit.Visible = false;
            btnDelete.Visible = false;
            btnSave.Visible = false;
            btnCancel.Visible = true;
        }
        else
        {
            btnAdd.Visible = false;
            btnEdit.Visible = true;
            btnDelete.Visible = true;
            btnSave.Visible = false;
            btnCancel.Visible = false;
            txtRoleDesc.Visible = false;
            txtRoleName.Visible = false;
            Get_RoleProfile(hf_roleId_roleDetail.Value);

        }

    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        btnSave.Visible = true;
        btnCancel.Visible = true;
        btnEdit.Visible = false;
        btnDelete.Visible = false;////
        btnAdd.Visible = false;
        lblRoleDesc.Visible = false;
        lblRoleName.Visible = false;
        txtRoleDesc.Visible = true;
        txtRoleDesc.Text = lblRoleDesc.Text;
        txtRoleName.Visible = true;
        txtRoleName.Text = lblRoleName.Text;

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.ProjectId != null)
            {
                //txtRoleName.Text = lblRoleName.Text;
                //txtRoleDesc.Text = lblRoleDesc.Text;
                Roles.RolesClient obj_roleClient = new Roles.RolesClient();
                Roles.RolesModel obj_roleModel = new Roles.RolesModel();
                DataSet ds = new DataSet();
                obj_roleModel.Project_RoleId = new Guid(hf_roleId_roleDetail.Value);
                obj_roleModel.Fk_project_id = new Guid(SessionController.Users_.ProjectId);
                obj_roleModel.Role_Name = txtRoleName.Text;
                obj_roleModel.Role_Desc = txtRoleDesc.Text;
                obj_roleModel.User_Id = new Guid(SessionController.Users_.UserId);
                ds = obj_roleClient.Insert_update_roles(obj_roleModel, SessionController.ConnectionString);
                btnSave.Visible = false;
                btnCancel.Visible = false;
                btnEdit.Visible = true;
                btnDelete.Visible = true;
                btnAdd.Visible = false;
                lblRoleDesc.Visible = true;
                lblRoleName.Visible = true;
                txtRoleDesc.Visible = false;
                txtRoleName.Visible = false;
                Get_RoleProfile(hf_roleId_roleDetail.Value);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {

        if (hf_roleId_roleDetail.Value == Guid.Empty.ToString())
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "CancelNavigation();", true);

        }
        else
        {
            btnSave.Visible = false;
            btnCancel.Visible = false;
            btnEdit.Visible = true;
            btnDelete.Visible = true; /////////
            btnAdd.Visible = false;
            lblRoleDesc.Visible = true;
            lblRoleName.Visible = true;
            txtRoleDesc.Visible = false;
            txtRoleName.Visible = false;
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            Roles.RolesClient obj_roleClient = new Roles.RolesClient();
            Roles.RolesModel obj_roleModel = new Roles.RolesModel();
            obj_roleModel.Project_RoleId = new Guid(hf_roleId_roleDetail.Value);
            obj_roleClient.Delete_project_role(obj_roleModel, SessionController.ConnectionString);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Roles", "CancelNavigation();", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }
}