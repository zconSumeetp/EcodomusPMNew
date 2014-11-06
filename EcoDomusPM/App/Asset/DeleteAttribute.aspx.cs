using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TypeProfile;
using EcoDomus.Session;
using System.Data;
using System.Data.SqlClient;
using Attributes;

public partial class App_Asset_DeleteAttribute : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string attr_id = "";
            if (Request.QueryString["attribute_id"] != null)
            {
                string id = Request.QueryString["attribute_id"].ToString();
                attr_id = id.Substring(0, id.Length - 1);
                // string id = Request.QueryString["type_id"].ToString();
            }
            if (Request.QueryString["flag"].ToString() == "type")
            {
                btnDeleteAllAttr.Text = "Delete Attributes from all types";
               // ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:viewtypedelete();", true);
            }
            else if (Request.QueryString["flag"].ToString() == "component")
            {
                btnDeleteAllAttr.Text = "Delete Attributes from all components";
              //  ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:viewcompodelete();", true);
            }

            else if (Request.QueryString["flag"].ToString() == "system")
            {
                btnDeleteAllAttr.Text = "Delete Attributes from all Systems";
            }


            else if (Request.QueryString["flag"].ToString() == "space")
            {
                btnDeleteAllAttr.Visible = false;
            }

            else if (Request.QueryString["flag"].ToString() == "zone")
            {
                btnDeleteAllAttr.Visible = false;
            }
        }
    }



    protected void btnDeleteAttr_Click(object sender, EventArgs e)
    {
        try
        {
            AttributeModel mdl = new AttributeModel();
            AttributeClient ctrl = new AttributeClient();
            mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
            mdl.Is_delete_for_all = "N";
            mdl.Entiy = Request.QueryString["EntityName"].ToString();
            mdl.Entiy_data_id = new Guid(Request.QueryString["EntityDataId"].ToString());
            mdl.Attribute_ids = Request.QueryString["attribute_id"].ToString();
            ctrl.DeleteAttributesAll(mdl, SessionController.ConnectionString);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:closeWindow();", true);
        }
        catch (Exception es)
        {
            throw es;
        }
    }

    //protected void btnDeleteAllAttrType_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        AttributeModel mdl = new AttributeModel();
    //        AttributeClient ctrl = new AttributeClient();
    //        mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
    //        mdl.Is_delete_for_all = "Y";
    //        mdl.Entiy = Request.QueryString["EntityName"].ToString();
    //        mdl.Entiy_data_id = new Guid(Request.QueryString["EntityDataId"].ToString());
    //        mdl.Attribute_ids = Request.QueryString["attribute_id"].ToString();
    //        ctrl.DeleteAttributesAll(mdl, SessionController.ConnectionString);
    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:closeWindow();", true);
    //    }
    //    catch (Exception es)
    //    {
    //        throw es;
    //    }
    //}
    protected void btnDeleteAllAttrCompo_Click(object sender, EventArgs e)
    {
        
        try
        {
            AttributeModel mdl = new AttributeModel();
            AttributeClient ctrl = new AttributeClient();
            mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
            mdl.Is_delete_for_all = "Y";
            mdl.Entiy = Request.QueryString["EntityName"].ToString();
            mdl.Entiy_data_id = new Guid(Request.QueryString["EntityDataId"].ToString());
            mdl.Attribute_ids = Request.QueryString["attribute_id"].ToString();
            ctrl.DeleteAttributesAll(mdl, SessionController.ConnectionString);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:closeWindow();", true);
        }
        catch (Exception es)
        {
            throw es;
        }
    
    }


}