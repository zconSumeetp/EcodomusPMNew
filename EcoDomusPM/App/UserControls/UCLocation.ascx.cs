using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;

public partial class App_UserControls_UCLocation : System.Web.UI.UserControl
{
    #region Page Events
    
    protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {

                    UserControl.UserControlClient objUserControlClient = new UserControl.UserControlClient();
                    UserControl.UserControlModel objUserControlModel = new UserControl.UserControlModel();
                    objUserControlModel.UserId = new Guid(SessionController.Users_.UserId);
                    objUserControlModel.ClientId = new Guid(SessionController.Users_.ClientID);
                    objUserControlModel.Organization_id = new Guid(SessionController.Users_.OrganizationID);
                    objUserControlModel.Systemrole = SessionController.Users_.UserSystemRole;
                    DataSet ds = new DataSet();
                    ds = objUserControlClient.GetSpaces(objUserControlModel, SessionController.ConnectionString);
                    if (ds.Tables.Count>0)
                    {
                        if (ds.Tables[0].Rows.Count>0)
                        {
                            rtvLocationSpaces.DataTextField = "Name";
                            rtvLocationSpaces.DataValueField = "Id";

                            rtvLocationSpaces.DataFieldParentID = "ParentId";
                            rtvLocationSpaces.DataFieldID = "Id";

                            rtvLocationSpaces.DataSource = ds;
                            rtvLocationSpaces.DataBind();
                            rtvLocationSpaces.ExpandAllNodes();
                            
                        }
                   
                    }
               
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    #endregion
}