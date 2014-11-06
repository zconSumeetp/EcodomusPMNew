using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Dashboard;
using System.Xml;
using System.Net;
using System.Threading;
using System.Globalization;
using System.IO;

public partial class App_ProjectData_Facility : System.Web.UI.Page
{
    /* Declare the Global connection object */

//    Dashboard.ConnectionModel conObj_Dashboardmdl = new Dashboard.ConnectionModel();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] != null)
            {
                /* Create the Client DB Connection object ! */
              //  CreateClientDBConnectionObject();

                if (!IsPostBack)
                {
                    //BindFacilities();
                }
            }
            else
            {
                Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            }
        }
        catch (Exception ex)
        {
            Response.Write("Page_Load:-" + ex.Message);
        }
    }

    //public void CreateClientDBConnectionObject()
    //{
    //    try
    //    {
    //        conObj_Dashboardmdl.ClientID = Session["Pk_clientID"].ToString();
    //        conObj_Dashboardmdl.ServerInstance = Session["ServerInstance"].ToString();
    //        conObj_Dashboardmdl.InitialCatalog = Session["InitialCatalog"].ToString();
    //        conObj_Dashboardmdl.SqlUserID = Session["SqlUserID"].ToString();
    //        conObj_Dashboardmdl.SqlPassword = Session["SqlPassword"].ToString();
    //        conObj_Dashboardmdl.PersistSecurityInfo = Session["PersistSecurityInfo"].ToString();
    //        conObj_Dashboardmdl.ConnectTimeout = Session["ConnectTimeout"].ToString();

    //    }
    //    catch (Exception ex)
    //    {
    //        Response.Write(ex.ToString());
    //    }
    //}

    //protected void BindFacilities()
    //{
    //    try
    //    {
    //        DataSet ds = new DataSet();
    //        DashboardModel mdl = new DashboardModel();
    //        DashboardClient obj_dash = new Dashboard.DashboardClient();
    //    //    mdl.OrganizationId = new Guid(Session["OrganizationId"].ToString());
    //      //  ds = obj_dash.GetFacilities(mdl, conObj_Dashboardmdl);
    //        rgFacility.DataSource = ds;
    //        rgFacility.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
            
    //       lblMessage.Text = " BindFacilities:-  " + ex.Message.ToString();
    //    }
       
    //}
    
    
    protected void rgFacility_PageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {

    //    BindFacilities();
    }

    protected override void InitializeCulture()
    {
        string culture = Session["Culture"].ToString();
        if (culture == null)
        {
            culture = "en-US";
        }
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
    }

    protected void rgFacility_OnSortCommand(object source,Telerik.Web.UI.GridSortCommandEventArgs e)
        {
            try
            {
                //BindFacilities();
            }
            catch (Exception ex)
            {

                Response.Write("rgFacility_OnSortCommand :-" + ex.Message.ToString());
            }
        }

    protected void rgFacility_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        //BindFacilities();
    }

    
    protected void rgFacility_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "EditFacility")
        {
            Response.Redirect("FacilityProfile.aspx");
        }
    }
}
