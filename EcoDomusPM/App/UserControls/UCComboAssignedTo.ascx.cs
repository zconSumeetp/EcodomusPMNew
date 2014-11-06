using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;

public partial class App_UserControls_UCComboAssignedTo : System.Web.UI.UserControl
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
                objUserControlModel.ClientId = new Guid(SessionController.Users_.ClientID);
                objUserControlModel.UserId = new Guid(SessionController.Users_.UserId);
                
                objUserControlModel.Organization_id = new Guid(SessionController.Users_.OrganizationID);
                DataSet ds = new DataSet();
                ds = objUserControlClient.GetUsersByClientId(objUserControlModel, SessionController.ConnectionString);
                if (ds.Tables.Count>0)
                {
                    if (ds.Tables[0].Rows.Count>0)
                    {
                        rtvOrganizationUsers.DataTextField = "Name";
                        rtvOrganizationUsers.DataValueField = "Id";

                        rtvOrganizationUsers.DataFieldParentID = "ParentId";
                        rtvOrganizationUsers.DataFieldID = "Id";

                        rtvOrganizationUsers.DataSource = ds;
                        rtvOrganizationUsers.DataBind();
                        //rtvOrganizationUsers.ExpandAllNodes();
                        rtvOrganizationUsers.CollapseAllNodes();
                        rtvOrganizationUsers.FindNodeByText("Organizations").Checkable = false;
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