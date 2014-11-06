using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data; 

public partial class UCLocationProject : System.Web.UI.UserControl
{
    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                {

                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                }
                else
                {
                    if (!IsPostBack)
                    {
                        UserControl.UserControlClient objUserControlClient = new UserControl.UserControlClient();
                        UserControl.UserControlModel objUserControlModel = new UserControl.UserControlModel();
                        objUserControlModel.UserId = new Guid(SessionController.Users_.ProjectId);
                        DataSet ds = new DataSet();
                        ds = objUserControlClient.GetSpacesforProject(objUserControlModel, SessionController.ConnectionString);
                        if (ds.Tables.Count > 0)
                        {
                            if (ds.Tables[0].Rows.Count > 0)
                            {
                                rtvLocationSpaces.DataTextField = "Name";
                                rtvLocationSpaces.DataValueField = "Id";

                                rtvLocationSpaces.DataFieldParentID = "ParentId";
                                rtvLocationSpaces.DataFieldID = "Id";

                                rtvLocationSpaces.DataSource = ds;
                                rtvLocationSpaces.DataBind();
                               // rtvLocationSpaces.ExpandAllNodes();
                                  rtvLocationSpaces.CollapseAllNodes();
                            }

                        }

                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);

            }
        }
        catch (Exception ex)
        {
            throw ex;
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }

    #endregion
}